---@type GL
local _, GL = ...;

local L = Gargul_L;
local Interface = GL.Interface;

--- Launcher UI for E2E scenarios: select scenarios (all checked by default), Start to run selected, Stop to stop all running.
--- Use via GL.Interface.Tests.Launcher:open()
---@class Launcher
local Launcher = {
    Window = nil,
    checkboxes = {},
    StartButton = nil,
    StopButton = nil,
    refreshTimerID = nil,
    pendingQueue = {},
    currentRunningKey = nil,
    queueWaitScheduled = false,
    nextScenarioTimerID = nil,
    runnerOpenedForQueue = false,
};

--- Seconds to wait between finishing one scenario and starting the next.
local QUEUE_DELAY_SECONDS = 3;

local REFRESH_TIMER_ID = "GargulTestsLauncher.Refresh";
local NEXT_SCENARIO_TIMER_ID = "GargulTestsLauncher.NextScenario";

--- List of E2E scenarios: key in GL.Tests.E2E, display label. Scenario ref resolved at open.
local E2E_SCENARIOS = {
    { key = "GDKPMultiAuction", label = "GDKP Multi-Auction E2E", },
    { key = "GDKPAuction", label = "GDKP Auction E2E", },
};

---@return boolean
function Launcher:isAnyRunning()
    local E2E = GL.Tests and GL.Tests.E2E;
    for _, entry in ipairs(E2E_SCENARIOS) do
        local scenario = E2E and E2E[entry.key];
        if (scenario and scenario.isRunning) then
            return true;
        end
    end
    return false;
end

---@return boolean
function Launcher:isQueueInProgress()
    return self.currentRunningKey ~= nil or self.queueWaitScheduled or #self.pendingQueue > 0;
end

---@return nil
function Launcher:refreshButtons()
    if (not self.StopButton or not self.StartButton) then
        return;
    end
    local anyRunning = self:isAnyRunning();
    self.StopButton:SetEnabled(anyRunning);
    self.StartButton:SetEnabled(not self:isQueueInProgress());
end

---@return nil
function Launcher:startRefreshTimer()
    if (self.refreshTimerID) then
        return;
    end
    self.refreshTimerID = REFRESH_TIMER_ID;
    GL:interval(1, REFRESH_TIMER_ID, function ()
        if (not self.Window or not self.Window:IsShown()) then
            GL:cancelTimer(self.refreshTimerID);
            self.refreshTimerID = nil;
            return;
        end
        self:checkScenarioFinished();
        self:refreshButtons();
        if (not self:isAnyRunning() and not self:isQueueInProgress()) then
            GL:cancelTimer(self.refreshTimerID);
            self.refreshTimerID = nil;
        end
    end);
end

--- If the current queued scenario finished, remove it and schedule the next after QUEUE_DELAY_SECONDS.
---@return nil
function Launcher:checkScenarioFinished()
    if (not self.currentRunningKey) then
        return;
    end
    local scenario = GL.Tests and GL.Tests.E2E and GL.Tests.E2E[self.currentRunningKey];
    if (scenario and scenario.isRunning) then
        return;
    end
    tremove(self.pendingQueue, 1);
    self.currentRunningKey = nil;
    self.queueWaitScheduled = true;
    self.nextScenarioTimerID = NEXT_SCENARIO_TIMER_ID;
    GL:after(QUEUE_DELAY_SECONDS, NEXT_SCENARIO_TIMER_ID, function ()
        self.queueWaitScheduled = false;
        self.nextScenarioTimerID = nil;
        self:startNextInQueue();
    end);
end

--- Build Runner scenario list from pendingQueue (labels + step titles). Used when opening Runner for the queue.
---@return table scenarios Array of { name = string, steps = table, key = string, expanded = boolean }
local function buildRunnerScenariosFromQueue(pendingQueue)
    local scenarios = {};
    for i, key in ipairs(pendingQueue) do
        local entry = nil;
        for _, e in ipairs(E2E_SCENARIOS) do
            if (e.key == key) then
                entry = e;
                break;
            end
        end
        local label = entry and entry.label or key;
        local scenario = GL.Tests and GL.Tests.E2E and GL.Tests.E2E[key];
        local stepTitles = (scenario and type(scenario.getStepTitles) == "function") and scenario:getStepTitles() or {};
        tinsert(scenarios, {
            name = label,
            steps = stepTitles,
            key = key,
            expanded = (i == 1),
        });
    end
    return scenarios;
end

--- Start the next scenario in pendingQueue (called after delay).
---@return nil
function Launcher:startNextInQueue()
    if (#self.pendingQueue == 0) then
        self.runnerOpenedForQueue = false;
        self:refreshButtons();
        return;
    end
    local key = self.pendingQueue[1];
    local scenario = GL.Tests and GL.Tests.E2E and GL.Tests.E2E[key];
    if (not scenario or type(scenario.start) ~= "function") then
        tremove(self.pendingQueue, 1);
        self:startNextInQueue();
        return;
    end

    local Runner = GL.Interface.Tests.Runner;
    if (not self.runnerOpenedForQueue) then
        local runnerScenarios = buildRunnerScenariosFromQueue(self.pendingQueue);
        Runner:open("E2E Tests", runnerScenarios);
        self.runnerOpenedForQueue = true;
    else
        Runner:setActiveScenario(key);
    end

    scenario:start(true);
    self.currentRunningKey = key;
    self:refreshButtons();
end

---@return nil
function Launcher:stop()
    if (self.nextScenarioTimerID) then
        GL:cancelTimer(self.nextScenarioTimerID);
        self.nextScenarioTimerID = nil;
    end
    self.pendingQueue = {};
    self.currentRunningKey = nil;
    self.queueWaitScheduled = false;
    self.runnerOpenedForQueue = false;
    for _, entry in ipairs(E2E_SCENARIOS) do
        local scenario = GL.Tests and GL.Tests.E2E and GL.Tests.E2E[entry.key];
        if (scenario and type(scenario.stop) == "function" and scenario.isRunning) then
            scenario:stop();
        end
    end
    self:refreshButtons();
end

---@return nil
function Launcher:startSelected()
    if (self:isQueueInProgress()) then
        return;
    end
    self:startRefreshTimer();
    self.runnerOpenedForQueue = false;
    self.pendingQueue = {};
    for _, entry in ipairs(E2E_SCENARIOS) do
        local cb = self.checkboxes[entry.key];
        if (cb and cb:GetChecked()) then
            tinsert(self.pendingQueue, entry.key);
        end
    end
    if (#self.pendingQueue == 0) then
        return;
    end
    self:startNextInQueue();
end

---@return nil
function Launcher:close()
    if (self.refreshTimerID) then
        GL:cancelTimer(self.refreshTimerID);
        self.refreshTimerID = nil;
    end
    if (self.nextScenarioTimerID) then
        GL:cancelTimer(self.nextScenarioTimerID);
        self.nextScenarioTimerID = nil;
    end
    self.pendingQueue = {};
    self.currentRunningKey = nil;
    self.queueWaitScheduled = false;
    if (self.Window) then
        self.Window:Hide();
        self.Window = nil;
    end
    self.checkboxes = {};
end

---@return nil
function Launcher:open()
    if (self.Window) then
        self.Window:Show();
        self:refreshButtons();
        return;
    end

    local Window = Interface:createWindow({
        name = "GargulTestsLauncher",
        width = 280,
        height = 200,
        hideMinimizeButton = true,
        hideResizeButton = true,
        hideWatermark = true,
        OnClose = function ()
            self:close();
        end,
    });

    self.Window = Window;

    local Title = Interface:createFontString(Window, "E2E Tests");
    Title:SetFont(1.25, "OUTLINE");
    Title:SetPoint("TOP", Window, "TOP", 0, -18);

    local leftMargin = 20;
    local topOffset = 50;

    for i, entry in ipairs(E2E_SCENARIOS) do
        ---@type CheckButton
        local Checkbox = Interface:createCheckbox({
            Parent = Window,
            name = "GargulTestsLauncher_" .. entry.key,
            checked = true,
            label = entry.label,
            callback = function ()
                self:refreshButtons();
            end,
        });
        if (i == 1) then
            Checkbox:SetPoint("TOPLEFT", Window, "TOPLEFT", leftMargin, -topOffset);
        else
            local prev = self.checkboxes[E2E_SCENARIOS[i - 1].key];
            Checkbox:SetPoint("TOPLEFT", prev, "BOTTOMLEFT", 0, -8);
        end
        self.checkboxes[entry.key] = Checkbox;
    end

    local StartButton = Interface:dynamicPanelButton(Window, "Start");
    StartButton:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 20);
    StartButton:SetScript("OnClick", function ()
        self:startSelected();
    end);
    self.StartButton = StartButton;

    local StopButton = Interface:dynamicPanelButton(Window, "Stop");
    StopButton:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -20, 20);
    StopButton:SetScript("OnClick", function ()
        self:stop();
    end);
    self.StopButton = StopButton;

    Interface:makeCloseableWithEscape(Window, Window:GetName());
    self:refreshButtons();
    self:startRefreshTimer();
    Window:Show();
end

GL.Interface.Tests = GL.Interface.Tests or {};
GL.Interface.Tests.Launcher = Launcher; ---@type Launcher
