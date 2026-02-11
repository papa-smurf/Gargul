---@type GL
local _, GL = ...;

local L = Gargul_L;
local Interface = GL.Interface;

--- Scenario/Test Runner UI: shows steps with green/red/gray, click step to view log
--- Use via GL.Interface.Tests.Runner
---@class Runner
local Runner = {
    isVisible = false,
    Window = nil,
    LogFrame = nil,
    scenarios = {},
    steps = {},
    stepButtons = {},
    scenarioHeaders = {},
    ItemHolder = nil,
    ROW_HEIGHT = 22,
    HEADER_HEIGHT = 24,
    activeScenarioKey = nil,
};

GL.Interface.Tests = GL.Interface.Tests or {};
GL.Interface.Tests.Runner = Runner; ---@type Runner

local STATUS = {
    pending = "pending",
    success = "success",
    fail = "fail",
};

local HEADER_COLOR = {
    running = "FFF569",
    success = "92FF00",
    fail = "BE3333",
};

--- Normalize input: (title, stepNames) or (title, scenarios)
---@param title string
---@param stepNamesOrScenarios table Array of step names, or array of { name = string, steps = table, key = string?, expanded = boolean? }
---@return table scenarios
local function normalizeScenarios(title, stepNamesOrScenarios)
    local first = stepNamesOrScenarios[1];
    if (type(first) == "string") then
        return { { name = title or "Scenario", steps = stepNamesOrScenarios, expanded = true, key = nil, } };
    end

    local out = {};
    for i, s in ipairs(stepNamesOrScenarios) do
        local expanded = s.expanded;
        if (expanded == nil) then
            expanded = (i == 1);
        end
        tinsert(out, {
            name = s.name or "?",
            steps = s.steps or {},
            expanded = expanded,
            key = s.key or s.name or "?",
        });
    end
    return out;
end

---@return number
function Runner:getContentHeight()
    local y = 0;
    for _, scenario in ipairs(self.scenarios) do
        y = y + self.HEADER_HEIGHT;
        if (scenario.expanded) then
            y = y + #scenario.steps * self.ROW_HEIGHT;
        end
    end
    return y;
end

---@param scenarioIndex number
---@param stepIndex number
---@return number
function Runner:getFlatStepIndex(scenarioIndex, stepIndex)
    local n = 0;
    for si = 1, scenarioIndex - 1 do
        n = n + #self.scenarios[si].steps;
    end
    return n + stepIndex;
end

--- Given a flat step index, return the scenario index and the 1-based step number within that scenario (for display).
---@param flatIndex number
---@return number|nil scenarioIndex
---@return number|nil stepInScenario
function Runner:getScenarioAndStepFromFlat(flatIndex)
    local count = 0;
    for si, scenario in ipairs(self.scenarios) do
        for stepIdx = 1, #scenario.steps do
            count = count + 1;
            if (count == flatIndex) then
                return si, stepIdx;
            end
        end
    end
    return nil, nil;
end

---@param key string Scenario key (e.g. "GDKPMultiAuction")
---@return number|nil 1-based scenario index or nil
function Runner:getScenarioIndexByKey(key)
    for i, s in ipairs(self.scenarios) do
        if (s.key == key) then
            return i;
        end
    end
    return nil;
end

---@param scenarioIndex number
---@return string "pending"|"success"|"fail"
function Runner:getScenarioStatus(scenarioIndex)
    local scenario = self.scenarios[scenarioIndex];
    if (not scenario) then
        return STATUS.pending;
    end

    local hasPending = false;
    local hasFail = false;
    for stepIdx = 1, #scenario.steps do
        local flatIndex = self:getFlatStepIndex(scenarioIndex, stepIdx);
        local step = self.steps[flatIndex];
        if (step) then
            if (step.status == STATUS.fail) then
                hasFail = true;
            elseif (step.status == STATUS.pending) then
                hasPending = true;
            end
        end
    end

    if (hasFail) then
        return STATUS.fail;
    end
    if (hasPending) then
        return "running";
    end
    return STATUS.success;
end

--- Collapse all scenarios and expand the one with the given key. Use when switching to the next scenario in a queue.
---@param key string Scenario key (e.g. "GDKPMultiAuction")
---@return nil
function Runner:setActiveScenario(key)
    self.activeScenarioKey = key;
    for _, scenario in ipairs(self.scenarios) do
        scenario.expanded = (scenario.key == key);
    end
    self:layoutRows();
    self:refresh();
end

---@return nil
function Runner:layoutRows()
    if (not self.ItemHolder) then
        return;
    end

    local y = 0;
    for scenarioIndex, scenario in ipairs(self.scenarios) do
        local header = self.scenarioHeaders[scenarioIndex];
        if (header) then
            header:ClearAllPoints();
            header:SetPoint("TOPLEFT", self.ItemHolder, "TOPLEFT", 0, -y);
            header:SetPoint("RIGHT", self.ItemHolder, "RIGHT", 0, 0);
            header:Show();
            local scenarioStatus = self:getScenarioStatus(scenarioIndex);
            local color = HEADER_COLOR[scenarioStatus] or "808080";
            local arrow = scenario.expanded and "  v" or "  >";
            header.Label:SetText(("|c00%s%s%s|r"):format(color, scenario.name, arrow));
            y = y + self.HEADER_HEIGHT;
        end

        if (scenario.expanded) then
            for stepIdx, step in ipairs(scenario.steps) do
                local flatIndex = self:getFlatStepIndex(scenarioIndex, stepIdx);
                local btn = self.stepButtons[flatIndex];
                if (btn) then
                    btn:ClearAllPoints();
                    btn:SetPoint("TOPLEFT", self.ItemHolder, "TOPLEFT", 12, -y);
                    btn:SetPoint("RIGHT", self.ItemHolder, "RIGHT", 0, 0);
                    btn:Show();
                    y = y + self.ROW_HEIGHT;
                end
            end
        else
            for stepIdx in ipairs(scenario.steps) do
                local flatIndex = self:getFlatStepIndex(scenarioIndex, stepIdx);
                local btn = self.stepButtons[flatIndex];
                if (btn) then
                    btn:Hide();
                end
            end
        end
    end

    self.ItemHolder:SetHeight(math.max(self:getContentHeight(), self.ItemHolder:GetParent():GetHeight()));
end

---@param title string
---@param stepNamesOrScenarios table Array of step names, or array of { name = string, steps = table }
---@return nil
function Runner:open(title, stepNamesOrScenarios)
    if (self.Window) then
        self.Window:Hide();
        self.Window = nil;
    end

    if (self.LogFrame) then
        self.LogFrame:Hide();
    end

    self.scenarios = normalizeScenarios(title, stepNamesOrScenarios);
    self.steps = {};
    self.stepButtons = {};
    self.scenarioHeaders = {};
    self.activeScenarioKey = (#self.scenarios > 0 and self.scenarios[1].key) or nil;

    local flatIndex = 0;
    for _, scenario in ipairs(self.scenarios) do
        for _, stepName in ipairs(scenario.steps) do
            flatIndex = flatIndex + 1;
            self.steps[flatIndex] = {
                name = stepName,
                status = STATUS.pending,
                log = {},
            };
        end
    end

    local contentHeight = self:getContentHeight();
    local windowHeight = math.min(420, contentHeight + 80);

    local Window = Interface:createWindow({
        name = "GargulTestsRunner",
        width = 320,
        height = windowHeight,
        hideMinimizeButton = true,
        hideResizeButton = true,
        hideWatermark = true,
        OnClose = function ()
            self.Window = nil;
            self.isVisible = false;
        end,
    });

    self.Window = Window;
    self.isVisible = true;

    local Title = Interface:createFontString(Window, title or L["Test Runner"]);
    Title:SetFont(1.25, "OUTLINE");
    Title:SetPoint("TOP", Window, "TOP", 0, -18);

    local ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate");
    ScrollFrame:SetPoint("TOP", Title, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 16, 0);
    ScrollFrame:SetPoint("RIGHT", Window, "RIGHT", -36, 0);
    ScrollFrame:SetPoint("BOTTOM", Window, "BOTTOM", 0, 20);

    local ItemHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(ItemHolder);
    ItemHolder:SetWidth(ScrollFrame:GetWidth() - 24);
    ItemHolder:SetHeight(math.max(contentHeight, ScrollFrame:GetHeight()));
    ItemHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    self.ItemHolder = ItemHolder;

    for scenarioIndex, scenario in ipairs(self.scenarios) do
        local header = CreateFrame("Button", nil, ItemHolder);
        header:SetHeight(self.HEADER_HEIGHT);
        header.scenarioIndex = scenarioIndex;
        local label = Interface:createFontString(header, scenario.name .. "  >");
        label:SetFont(1, "OUTLINE");
        label:SetPoint("LEFT", header, "LEFT", 4, 0);
        label:SetPoint("RIGHT", header, "RIGHT", -4, 0);
        label:SetJustifyH("LEFT");
        header.Label = label;
        header:SetScript("OnClick", function ()
            scenario.expanded = not scenario.expanded;
            self:layoutRows();
        end);
        self.scenarioHeaders[scenarioIndex] = header;
    end

    for flatIndex, step in ipairs(self.steps) do
        local btn = CreateFrame("Button", nil, ItemHolder);
        btn:SetHeight(self.ROW_HEIGHT);
        btn.stepIndex = flatIndex;

        local label = Interface:createFontString(btn, self:formatStepLine(flatIndex, step));
        label:SetPoint("LEFT", btn, "LEFT", 4, 0);
        label:SetPoint("RIGHT", btn, "RIGHT", -4, 0);
        label:SetJustifyH("LEFT");
        btn.Label = label;

        btn:SetScript("OnClick", function ()
            self:showStepLog(flatIndex);
        end);

        self.stepButtons[flatIndex] = btn;
    end

    self:layoutRows();
    Interface:makeCloseableWithEscape(Window, Window:GetName());
    Window:Show();
end

---@param stepIndex number Flat step index (1-based across all scenarios).
---@param step table
---@return string
function Runner:formatStepLine(stepIndex, step)
    local icon, color;
    if (step.status == STATUS.success) then
        icon = "|TInterface/RAIDFRAME/ReadyCheck-Ready:14:14|t";
        color = "92FF00"; -- green
    elseif (step.status == STATUS.fail) then
        icon = "|TInterface/RAIDFRAME/ReadyCheck-NotReady:14:14|t";
        color = "BE3333"; -- red
    else
        icon = "|TInterface/MINIMAP/TRACKING/None:14:14|t";
        color = "808080"; -- gray
    end
    local displayNum = stepIndex;
    if (#self.scenarios > 1) then
        local _, stepInScenario = self:getScenarioAndStepFromFlat(stepIndex);
        if (stepInScenario) then
            displayNum = stepInScenario;
        end
    end
    return ("|c00%s%s %d. %s|r"):format(color, icon, displayNum, step.name);
end

---@return nil
function Runner:refresh()
    if (not self.Window or not self.isVisible) then
        return;
    end

    for i, btn in ipairs(self.stepButtons) do
        local step = self.steps[i];
        if (step and btn.Label) then
            btn.Label:SetText(self:formatStepLine(i, step));
        end
    end

    for scenarioIndex, scenario in ipairs(self.scenarios) do
        local header = self.scenarioHeaders[scenarioIndex];
        if (header and header.Label) then
            local scenarioStatus = self:getScenarioStatus(scenarioIndex);
            local color = HEADER_COLOR[scenarioStatus] or "808080";
            local arrow = scenario.expanded and "  v" or "  >";
            header.Label:SetText(("|c00%s%s%s|r"):format(color, scenario.name, arrow));
        end
    end
end

--- When activeScenarioKey is set, stepIndex is the scenario's local step (1-based); otherwise flat index.
---@param stepIndex number Scenario-local step (if activeScenarioKey set) or flat step index
---@param status string "pending"|"success"|"fail"
---@param logLine? string Optional line to append to log
---@return nil
function Runner:setStepStatus(stepIndex, status, logLine)
    local flatIndex = stepIndex;
    if (self.activeScenarioKey) then
        local scenarioIndex = self:getScenarioIndexByKey(self.activeScenarioKey);
        if (scenarioIndex) then
            flatIndex = self:getFlatStepIndex(scenarioIndex, stepIndex);
        end
    end

    local step = self.steps[flatIndex];
    if (not step) then
        return;
    end

    step.status = status;
    if (logLine and type(logLine) == "string") then
        tinsert(step.log, logLine);
    end

    self:refresh();
end

--- When activeScenarioKey is set, stepIndex is the scenario's local step (1-based); otherwise flat index.
---@param stepIndex number Scenario-local step (if activeScenarioKey set) or flat step index
---@param line string
---@return nil
function Runner:appendStepLog(stepIndex, line)
    local flatIndex = stepIndex;
    if (self.activeScenarioKey) then
        local scenarioIndex = self:getScenarioIndexByKey(self.activeScenarioKey);
        if (scenarioIndex) then
            flatIndex = self:getFlatStepIndex(scenarioIndex, stepIndex);
        end
    end

    local step = self.steps[flatIndex];
    if (not step) then
        return;
    end

    tinsert(step.log, line);
end

---@param stepIndex number
---@return nil
function Runner:showStepLog(stepIndex)
    local step = self.steps[stepIndex];
    if (not step) then
        return;
    end

    local logText;
    if (#step.log > 0) then
        logText = table.concat(step.log, "\n");
    else
        logText = L["No log entries for this step"];
    end

    local displayNum = stepIndex;
    if (#self.scenarios > 1) then
        local _, stepInScenario = self:getScenarioAndStepFromFlat(stepIndex);
        if (stepInScenario) then
            displayNum = stepInScenario;
        end
    end
    local title = ("%d. %s"):format(displayNum, step.name);
    local fullText = ("[%s]\n\n%s"):format(title, logText);

    if (not self.LogFrame) then
        self:buildLogFrame();
    end

    self.LogFrame.EditBox:SetText(fullText);
    self.LogFrame.Title:SetText(title);

    local scrollFrame = self.LogFrame.EditBox:GetParent();
    if (scrollFrame.SetVerticalScroll) then
        scrollFrame:SetVerticalScroll(0);
    end

    self.LogFrame:Show();
end

---@return nil
function Runner:buildLogFrame()
    local LogFrame = Interface:createWindow({
        name = "GargulTestsRunnerLog",
        width = 500,
        height = 350,
        hideMinimizeButton = true,
        hideResizeButton = true,
        hideWatermark = true,
    });

    local Title = Interface:createFontString(LogFrame, "");
    Title:SetFont(1.25, "OUTLINE");
    Title:SetPoint("TOP", LogFrame, "TOP", 0, -18);

    local ScrollFrame = CreateFrame("ScrollFrame", nil, LogFrame, "UIPanelScrollFrameTemplate");
    ScrollFrame:SetPoint("TOP", Title, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("LEFT", LogFrame, "LEFT", 16, 0);
    ScrollFrame:SetPoint("RIGHT", LogFrame, "RIGHT", -36, 0);
    ScrollFrame:SetPoint("BOTTOM", LogFrame, "BOTTOM", 0, 20);

    local EditBox = CreateFrame("EditBox", nil, ScrollFrame);
    EditBox:SetAutoFocus(false);
    EditBox:SetFontObject(_G.ChatFontNormal);
    EditBox:SetMultiLine(true);
    EditBox:SetMaxLetters(0);
    EditBox:ClearFocus();
    EditBox:SetWidth(ScrollFrame:GetWidth() - 24);
    EditBox:SetHeight(2000);
    EditBox:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT", 4, 0);

    ScrollFrame:SetScrollChild(EditBox);

    LogFrame.EditBox = EditBox;
    LogFrame.Title = Title;
    self.LogFrame = LogFrame;

    Interface:makeCloseableWithEscape(LogFrame, LogFrame:GetName());
end

---@return nil
function Runner:close()
    if (self.Window) then
        self.Window:Hide();
    end

    if (self.LogFrame) then
        self.LogFrame:Hide();
    end

    self.Window = nil;
    self.isVisible = false;
end

return Runner;
