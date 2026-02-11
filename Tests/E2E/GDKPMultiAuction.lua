---@type GL
local _, GL = ...;
local L = Gargul_L;

--- End-to-End Test for GDKP MultiAuction: creates a session, opens MultiAuction, fills items, runs version check, then terminates.
--- Run with: /run Gargul.Tests.E2E.GDKPMultiAuction:start()
--- Stop with: /run Gargul.Tests.E2E.GDKPMultiAuction:stop()

assert(GL.Tests.E2E and GL.Tests.E2E.Base and type(GL.Tests.E2E.Base.startWith) == "function", "GL.Tests.E2E.Base missing (TOC: Tests/E2E/Base.lua before this file)");

---@class GDKPMultiAuction : E2EBase
local E2E = {
    scenarioName = "GDKPMultiAuction",
    isRunning = false,
    runnerStep = 0,
    sessionName = nil,
    sessionID = nil,
    retryCount = 0,
};
setmetatable(E2E, { __index = GL.Tests.E2E.Base });
GL.Tests.E2E.GDKPMultiAuction = E2E; ---@type GDKPMultiAuction

local MAX_RETRIES = {
    step10 = 15,   -- Start button (30s)
    step11 = 30,   -- Wait for MultiAuction client (60s)
    step13 = 20,   -- Confirm dialog (10s)
    step14 = 10,   -- Verify termination (10s)
};

local E2E_STEPS = {
    { title = "Open GDKP Overview", fn = "step1_OpenGDKPOverview", },
    { title = "Open Create Session", fn = "step2_OpenCreateSession", },
    { title = "Fill Session Details", fn = "step3_FillSessionDetails", },
    { title = "Create Session", fn = "step4_CreateSession", },
    { title = "Close GDKP Windows", fn = "step5_CloseGDKPWindows", },
    { title = "Open MultiAuction", fn = "step6_OpenMultiAuction", },
    { title = "Fill Items from Inventory", fn = "step7_FillItems", },
    { title = "Select Items", fn = "step8_SelectItems", },
    { title = "Click Next", fn = "step9_ClickNext", },
    { title = "Click Start in Version Check", fn = "step10_ClickStartInVersionCheck", },
    { title = "Wait for MultiAuction Client", fn = "step11_WaitForMultiAuctionClient", },
    { title = "Click Terminate", fn = "step12_ClickTerminate", },
    { title = "Confirm Terminate", fn = "step13_ClickYesOnConfirmation", },
    { title = "Verify Termination", fn = "step14_VerifyTermination", },
    { title = "Close Windows", fn = "step15_CloseWindows", },
};

---@return table Array of step title strings (used when Launcher opens Runner for queue).
function E2E:getStepTitles()
    local t = {};
    for _, s in ipairs(E2E_STEPS) do
        tinsert(t, s.title);
    end
    return t;
end

---@return nil
function E2E:stop()
    self:resetRunnerState();

    if (self.sessionID) then
        local sessionID = self.sessionID;
        GL.GDKP.Session:delete(sessionID);
        self:log("Session soft-deleted");
        GL:after(2, "E2E.GDKPMultiAuction.PermanentDelete", function ()
            GL.DB:set("GDKP.Ledger." .. sessionID, nil);
            self:log("Session permanently deleted");
        end);
        self.sessionID = nil;
    end

    GL.Interface.GDKP.Overview:close();
    GL.Interface.GDKP.CreateSession:close();
    GL.Interface.GDKP.MultiAuction.Auctioneer:close();
    GL.Interface.GDKP.MultiAuction.FillFromInventory:close();
    GL.Interface.GroupVersionCheck:close();

    local clientWindow = _G["Gargul.Interface.GDKP.MultiAuction.Client.Window"];
    if (clientWindow) then
        clientWindow:Hide();
    end

    self:log("Stopped and cleaned up");
end

---@param skipRunnerOpen boolean|nil If true, Runner was already opened by Launcher; only set active scenario and run.
---@return nil
function E2E:start(skipRunnerOpen)
    self.retryCount = 0;
    self.sessionName = ("E2E Test %s"):format(date("%H:%M:%S"));
    self.steps = E2E_STEPS;

    if (skipRunnerOpen) then
        if (self.isRunning) then
            self:log(("Test already running. Use /run Gargul.Tests.E2E.%s:stop() to stop it first."):format(self.scenarioName or "E2E"));
            return;
        end
        self.isRunning = true;
        self.runnerStep = 0;
        GL.Interface.Tests.Runner:setActiveScenario(self.scenarioName);
        self:log("========== Starting Visual E2E Test ==========");
        self:runStep(1);
        return;
    end

    local titles = {};
    for _, step in ipairs(E2E_STEPS) do
        tinsert(titles, step.title);
    end
    self:startWith("E2E Tests", { { name = "GDKPMultiAuction", steps = titles, } });
    self:runStep(1);
end

--- Step 1: Open GDKP Overview
---@return nil
function E2E:step1_OpenGDKPOverview()
    if (not self.isRunning) then return; end

    self:log("Step 1: Opening GDKP Overview...");

    GL.Interface.GDKP.Overview:open();

    local Window = Gargul.Interface:get(GL.Interface.GDKP.Overview, "GDKPOverview");
    if (not Window or not Window:IsShown()) then
        self:error("Failed to open GDKP Overview");
        return;
    end

    self:success("GDKP Overview opened");
    self:next();
end

--- Step 2: Open Create Session
---@return nil
function E2E:step2_OpenCreateSession()
    if (not self.isRunning) then return; end

    self:log("Step 2: Opening Create Session...");

    GL.Interface.GDKP.CreateSession:open();

    local Window = Gargul.Interface:get(GL.Interface.GDKP.CreateSession, "Window");
    if (not Window) then
        self:error("Create Session window not found");
        return;
    end

    if (not Window.frame or not Window.frame:IsShown()) then
        self:error("Create Session window did not open (Overview must be visible)");
        return;
    end

    self:success("Create Session opened");
    self:next();
end

--- Step 3: Fill Session Details
---@return nil
function E2E:step3_FillSessionDetails()
    if (not self.isRunning) then return; end

    self:log("Step 3: Filling session details...");

    local Window = Gargul.Interface:get(GL.Interface.GDKP.CreateSession, "Window");
    if (not Window) then
        self:error("Create Session window not found");
        return;
    end

    if (not Window.TitleBox or not Window.ManagementCutBox or not Window.SessionTypeDropdown or not Window.SwitchCheckbox) then
        self:error("Create Session form widgets not found (TitleBox, ManagementCutBox, SessionTypeDropdown, SwitchCheckbox)");
        return;
    end

    Window.TitleBox:SetText(self.sessionName);
    self:log("  - Name: " .. self.sessionName);
    Window.ManagementCutBox:SetText("10");
    self:log("  - Management cut: 10%");
    Window.SessionTypeDropdown:SetValue("multi");
    Window.SessionTypeDropdown:SetText(L["Multi-Auction"]);
    self:log("  - Type: Multi-Auction");
    Window.SwitchCheckbox:SetValue(true);
    self:log("  - Auto-switch: Yes");

    self:success("Session details filled");
    self:next();
end

--- Step 4: Create Session
---@return nil
function E2E:step4_CreateSession()
    if (not self.isRunning) then return; end

    self:log("Step 4: Creating session...");

    local createdSessionID = nil;
    GL.Events:register("E2E.GDKPMultiAuction.Step4", "GL.GDKP_SESSION_CREATED", function (_, Instance)
        createdSessionID = Instance and Instance.ID;
        GL.Events:unregister("E2E.GDKPMultiAuction.Step4");
    end);

    local Window = Gargul.Interface:get(GL.Interface.GDKP.CreateSession, "Window");
    if (not Window or not Window.SaveButton) then
        self:error("Create Session window or SaveButton not found");
        return;
    end

    Window.SaveButton:Fire("OnClick");

    GL:after(.1, "E2E.GDKPMultiAuction.Step4Verify", function ()
        if (not self.isRunning) then return; end

        if (not createdSessionID) then
            self:error("Failed to create session: GL.GDKP_SESSION_CREATED was not fired");
            return;
        end

        local activeSessionID = GL.GDKP.Session:activeSessionID();
        if (activeSessionID ~= createdSessionID) then
            self:error(("Session ID mismatch: created '%s', active is '%s'"):format(tostring(createdSessionID), tostring(activeSessionID)));
            return;
        end

        self.sessionID = activeSessionID;
        self:success("Session created: " .. activeSessionID);
        self:next();
    end);
end

--- Step 5: Close GDKP Windows
---@return nil
function E2E:step5_CloseGDKPWindows()
    if (not self.isRunning) then return; end

    self:log("Step 5: Closing GDKP windows...");

    GL.Interface.GDKP.Overview:close();
    GL.Interface.GDKP.CreateSession:close();

    if (GL.Interface.GDKP.Overview.isVisible) then
        self:error("GDKP Overview remained visible after close");
        return;
    end

    if (GL.Interface.GDKP.CreateSession.isVisible) then
        self:error("Create Session remained visible after close");
        return;
    end

    self:success("GDKP windows closed");
    self:next(0);
end

--- Step 6: Open MultiAuction
---@return nil
function E2E:step6_OpenMultiAuction()
    if (not self.isRunning) then return; end

    self:log("Step 6: Opening MultiAuction (/gl ma)...");

    GL.Interface.GDKP.MultiAuction.Auctioneer:close();

    GL:after(.1, "E2E.GDKPMultiAuction.OpenMA", function ()
        GL.Interface.GDKP.MultiAuction.Auctioneer:open();

        local window = _G["Gargul.Interface.GDKP.MultiAuction.Auctioneer.Window"];
        if (not window or not window:IsShown()) then
            self:error("Failed to open MultiAuction");
            return;
        end

        self:success("MultiAuction opened");
        self:next();
    end);
end

--- Step 7: Fill Items from Inventory
---@return nil
function E2E:step7_FillItems()
    if (not self.isRunning) then return; end

    self:log("Step 7: Filling items from inventory...");

    local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;
    if (not Auctioneer or not Auctioneer.fillFromInventory) then
        self:error("MultiAuction Auctioneer or fillFromInventory not found");
        return;
    end

    Auctioneer:fillFromInventory(0, 0, true, true, true);

    local ItemRows = GL.Interface.GDKP.MultiAuction.Auctioneer.ItemRows;
    if (type(ItemRows) ~= "table") then
        self:error("Auctioneer ItemRows is not a table after fillFromInventory");
        return;
    end

    local itemCount = #ItemRows;
    self:success(("Filled %d items from inventory"):format(itemCount));

    if (itemCount == 0) then
        self:log("WARNING: No items found in inventory to auction - test may fail");
    end

    self:next();
end

--- Step 8: Select Items
---@return nil
function E2E:step8_SelectItems()
    if (not self.isRunning) then return; end

    self:log("Step 8: Selecting items...");

    local SelectAll = GL.Interface.GDKP.MultiAuction.Auctioneer.SelectAll;
    if (SelectAll) then
        SelectAll:Click();
        local itemCount = #(GL.Interface.GDKP.MultiAuction.Auctioneer.ItemRows or {});
        self:success(("Selected all %d items"):format(itemCount));
    else
        self:error("SelectAll checkbox not found");
        return;
    end

    self:next();
end

--- Step 9: Click Next Button (Opens Version Check)
---@return nil
function E2E:step9_ClickNext()
    if (not self.isRunning) then return; end

    self:log("Step 9: Clicking Next button...");

    local auctioneerWindow = _G["Gargul.Interface.GDKP.MultiAuction.Auctioneer.Window"];
    if (not auctioneerWindow) then
        self:error("Auctioneer window not found");
        return;
    end

    local nextButton = nil;
    for _, child in ipairs({ auctioneerWindow:GetChildren() }) do
        if (child.GetText and child:GetText() == L["Next"]) then
            nextButton = child;
            break;
        end
    end

    if (nextButton) then
        nextButton:Click();
        self:success("Clicked Next button - Version Check should open");
        self:log("Waiting for version check to complete...");
        self:next(5);
    else
        self:error("Next button not found");
    end
end

--- Step 10: Auto-click Start in Version Check
---@return nil
function E2E:step10_ClickStartInVersionCheck()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 10: Auto-clicking Start in Version Check... (attempt " .. self.retryCount .. ")");

    local startButton = nil;
    for _, button in pairs(GL.Interface.GroupVersionCheck.ActionButtons or {}) do
        if (button and button.GetText and button:GetText() == L["Start"]) then
            startButton = button;
            break;
        end
    end

    if (startButton) then
        self.retryCount = 0;
        startButton:Click();
        self:success("Clicked Start button");
        self:next();
    elseif (self.retryCount >= MAX_RETRIES.step10) then
        self:error(("Start button not found after %d attempts"):format(MAX_RETRIES.step10));
    else
        self:log("Start button not found yet, waiting...");
        self:retry(2);
    end
end

--- Step 11: Wait for MultiAuction Client
---@return nil
function E2E:step11_WaitForMultiAuctionClient()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 11: Checking if MultiAuction client is visible... (attempt " .. self.retryCount .. ")");

    if (GL.GDKP.MultiAuction.Auctioneer:hasRunningAuctions()) then
        self.retryCount = 0;
        self:success("MultiAuction client is running");
        self:next(3);
    elseif (self.retryCount >= MAX_RETRIES.step11) then
        self:error(("MultiAuction client did not start after %d attempts"):format(MAX_RETRIES.step11));
    else
        self:log("MultiAuction not started yet, waiting...");
        self:retry(2);
    end
end

--- Step 12: Click Terminate Button
---@return nil
function E2E:step12_ClickTerminate()
    if (not self.isRunning) then return; end

    self:log("Step 12: Clicking Terminate button...");

    local clientWindow = _G["Gargul.Interface.GDKP.MultiAuction.Client.Window"];
    if (not clientWindow) then
        self:error("Client window not found");
        return;
    end

    local terminateButton = clientWindow.TerminateButton;

    if (terminateButton) then
        terminateButton:Click();
        self:success("Clicked Terminate button - waiting for confirmation dialog...");
        self:next();
    else
        self:error("Terminate button not found");
    end
end

--- Step 13: Click Yes on Confirmation (StaticPopup)
---@return nil
function E2E:step13_ClickYesOnConfirmation()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 13: Looking for StaticPopup confirmation dialog... (attempt " .. self.retryCount .. ")");

    ---@diagnostic disable-next-line: undefined-field
    local dialog = _G.StaticPopup1;

    if (dialog and dialog:IsShown()) then
        local dialogText = dialog.Text and dialog.Text:GetText() or "";
        if (not dialogText:match("Remove all")) then
            if (self.retryCount >= MAX_RETRIES.step13) then
                self:error(("Wrong or unexpected dialog shown after %d attempts: '%s'"):format(MAX_RETRIES.step13, strsub(dialogText, 1, 80)));
                return;
            end
            self:log("Wrong dialog shown: '" .. strsub(dialogText, 1, 50) .. "', waiting...");
            self:retry(.5);
            return;
        end

        self.retryCount = 0;
        self:log("Found terminate confirmation dialog");

        ---@diagnostic disable-next-line: undefined-field
        local dialogInfo = _G.StaticPopupDialogs[dialog.which];
        if (dialogInfo and dialogInfo.OnButton1) then
            self:log("Executing Yes callback...");
            dialogInfo.OnButton1(dialog);
            dialog:Hide();
            self:success("Executed Yes callback and closed dialog");
            self:next(.5);
        else
            self:error("OnButton1 callback not found on terminate confirmation dialog");
        end
    elseif (self.retryCount >= MAX_RETRIES.step13) then
        self:error(("StaticPopup confirmation dialog did not appear after %d attempts"):format(MAX_RETRIES.step13));
    else
        self:log("StaticPopup dialog not visible yet, waiting...");
        self:retry(.5);
    end
end

--- Step 14: Verify Termination Completed
---@return nil
function E2E:step14_VerifyTermination()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 14: Verifying auction terminated... (attempt " .. self.retryCount .. ")");

    if (not GL.GDKP.MultiAuction.Auctioneer:hasRunningAuctions()) then
        self.retryCount = 0;
        self:success("MultiAuction successfully terminated");
        self:next();
    elseif (self.retryCount >= MAX_RETRIES.step14) then
        self:error(("Auction did not terminate after %d attempts"):format(MAX_RETRIES.step14));
    else
        self:log("Auction still running, waiting...");
        self:retry(1);
    end
end

--- Step 15: Close Windows
---@return nil
function E2E:step15_CloseWindows()
    if (not self.isRunning) then return; end

    self:log("Step 15: Closing MultiAuction windows...");

    GL.Interface.GDKP.MultiAuction.Auctioneer:close();

    local clientWindow = _G["Gargul.Interface.GDKP.MultiAuction.Client.Window"];
    if (clientWindow) then
        clientWindow:Hide();
    end

    if (GL.Interface.GDKP.MultiAuction.Auctioneer:isShown()) then
        self:error("MultiAuction Auctioneer window remained visible after close");
        return;
    end

    if (GL.Interface.GDKP.MultiAuction.Client:isShown()) then
        self:error("MultiAuction Client window remained visible after close");
        return;
    end

    self:success("MultiAuction windows closed");
    self:log("========== E2E Test Complete ==========");
    self:next();
end

return E2E;
