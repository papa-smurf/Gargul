---@type GL
local _, GL = ...;
local L = Gargul_L;

--- End-to-End Test for GDKP MultiAuction
--- Run with: /run Gargul.Tests.MultiAuctionE2E:start()
--- Stop with: /run Gargul.Tests.MultiAuctionE2E:stop()

GL.Tests.MultiAuctionE2E = {
    isRunning = false,
    currentStep = 0,
    runnerStep = 0,
    sessionName = nil,
    sessionID = nil,
    retryCount = 0,
};

local MAX_RETRIES = {
    step9b = 15,   -- Start button (30s)
    step10 = 30,   -- Wait for MultiAuction client (60s)
    step11b = 20,  -- Confirm dialog (10s)
    step11c = 10,  -- Verify termination (10s)
};

local E2E = GL.Tests.MultiAuctionE2E;

local E2E_STEPS = {
    "Open GDKP Overview",
    "Open Create Session",
    "Fill Session Details",
    "Create Session",
    "Close GDKP Windows",
    "Open MultiAuction",
    "Fill Items from Inventory",
    "Select Items",
    "Click Next",
    "Click Start in Version Check",
    "Wait for MultiAuction Client",
    "Click Terminate",
    "Confirm Terminate",
    "Verify Termination",
    "Close Windows",
};

function E2E:log(message)
    Gargul:xd(("[E2E] %s"):format(message));
    local runner = GL.Interface.Tests.Runner;
    if (runner.isVisible and self.runnerStep > 0) then
        runner:appendStepLog(self.runnerStep, message);
    end
end

function E2E:success(message)
    Gargul:xd(("[E2E] [OK] %s"):format(message));
    local runner = GL.Interface.Tests.Runner;
    if (runner.isVisible and self.runnerStep > 0) then
        runner:setStepStatus(self.runnerStep, "success", message);
    end
end

function E2E:error(message)
    Gargul:xd(("[E2E] [FAIL] ERROR: %s"):format(message));
    local runner = GL.Interface.Tests.Runner;
    if (runner.isVisible and self.runnerStep > 0) then
        runner:setStepStatus(self.runnerStep, "fail", message);
    end
    self:stop();
end

function E2E:scheduleNext(delay, callback)
    GL:after(delay, "GargulVisualE2E.Step" .. (self.currentStep + 1), callback);
end

function E2E:stop()
    self.isRunning = false;
    self.currentStep = 0;
    self.runnerStep = 0;

    -- Keep Runner open so user can review results and click for logs
    -- Cleanup session
    if (self.sessionID) then
        local sessionID = self.sessionID;

        -- First delete via traditional UI means (soft delete)
        GL.GDKP.Session:delete(sessionID);
        self:log("Session soft-deleted");

        -- Then permanently delete after 2 seconds
        GL:after(2, "GargulVisualE2E.PermanentDelete", function ()
            GL.DB:set("GDKP.Ledger." .. sessionID, nil);
            self:log("Session permanently deleted");
        end);

        self.sessionID = nil;
    end

    -- Close all windows
    GL.Interface.GDKP.Overview:close();
    GL.Interface.GDKP.CreateSession:close();
    GL.Interface.GDKP.MultiAuction.Auctioneer:close();
    GL.Interface.GDKP.MultiAuction.FillFromInventory:close();
    GL.Interface.GroupVersionCheck:close();

    -- Close client window
    local clientWindow = _G["Gargul.Interface.GDKP.MultiAuction.Client.Window"];
    if (clientWindow) then
        clientWindow:Hide();
    end

    self:log("Stopped and cleaned up");
end

function E2E:start()
    if (self.isRunning) then
        self:log("Test already running. Use /run Gargul.Tests.MultiAuctionE2E:stop() to stop it first.");
        return;
    end

    self.isRunning = true;
    self.currentStep = 0;
    self.runnerStep = 0;
    self.retryCount = 0;
    self.sessionName = ("E2E Test %s"):format(date("%H:%M:%S"));

    GL.Interface.Tests.Runner:open("GDKP MultiAuction E2E", E2E_STEPS);

    self:log("========== Starting Visual E2E Test ==========");
    self:step1_OpenGDKPOverview();
end

--- Step 1: Open GDKP Overview
function E2E:step1_OpenGDKPOverview()
    if (not self.isRunning) then return; end

    self.currentStep = 1;
    self.runnerStep = 1;
    self:log("Step 1: Opening GDKP Overview...");

    GL.Interface.GDKP.Overview:open();

    local Window = Gargul.Interface:get(GL.Interface.GDKP.Overview, "GDKPOverview");
    if (not Window or not Window:IsShown()) then
        self:error("Failed to open GDKP Overview");
        return;
    end

    self:success("GDKP Overview opened");
    self:scheduleNext(1, function () self:step2_OpenCreateSession() end);
end

--- Step 2: Open Create Session
function E2E:step2_OpenCreateSession()
    if (not self.isRunning) then return; end

    self.currentStep = 2;
    self.runnerStep = 2;
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
    self:scheduleNext(1, function () self:step3_FillSessionDetails() end);
end

--- Step 3: Fill Session Details
function E2E:step3_FillSessionDetails()
    if (not self.isRunning) then return; end

    self.currentStep = 3;
    self.runnerStep = 3;
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
    self:scheduleNext(1, function () self:step4_CreateSession() end);
end

--- Step 4: Create Session
function E2E:step4_CreateSession()
    if (not self.isRunning) then return; end

    self.currentStep = 4;
    self.runnerStep = 4;
    self:log("Step 4: Creating session...");

    local createdSessionID = nil;
    GL.Events:register("E2E.Step4.CreatedSession", "GL.GDKP_SESSION_CREATED", function (_, Instance)
        createdSessionID = Instance and Instance.ID;
        GL.Events:unregister("E2E.Step4.CreatedSession");
    end);

    local Window = Gargul.Interface:get(GL.Interface.GDKP.CreateSession, "Window");
    if (not Window or not Window.SaveButton) then
        self:error("Create Session window or SaveButton not found");
        return;
    end

    Window.SaveButton:Fire("OnClick");

    -- Verify that the session we just created is the actual active session.
    -- Use a short delay so the Save callback (create + setActive + close) has finished.
    GL:after(0.1, "GargulVisualE2E.Step4Verify", function ()
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

        self:scheduleNext(1, function () self:step5_CloseGDKPWindows() end);
    end);
end

--- Step 5: Close GDKP Windows
function E2E:step5_CloseGDKPWindows()
    if (not self.isRunning) then return; end

    self.currentStep = 5;
    self.runnerStep = 5;
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
    -- Open MultiAuction immediately
    self:step6_OpenMultiAuction();
end

--- Step 6: Open MultiAuction
function E2E:step6_OpenMultiAuction()
    if (not self.isRunning) then return; end

    self.currentStep = 6;
    self.runnerStep = 6;
    self:log("Step 6: Opening MultiAuction (/gl ma)...");

    -- Make sure any previous instance is closed first
    GL.Interface.GDKP.MultiAuction.Auctioneer:close();

    -- Wait a moment then open
    GL:after(0.1, "GargulVisualE2E.OpenMA", function ()
        GL.Interface.GDKP.MultiAuction.Auctioneer:open();

        local window = _G["Gargul.Interface.GDKP.MultiAuction.Auctioneer.Window"];
        if (not window or not window:IsShown()) then
            self:error("Failed to open MultiAuction");
            return;
        end

        self:success("MultiAuction opened");
        self:scheduleNext(1, function () self:step7_FillItems() end);
    end);
end

--- Step 7: Fill Items from Inventory
function E2E:step7_FillItems()
    if (not self.isRunning) then return; end

    self.currentStep = 7;
    self.runnerStep = 7;
    self:log("Step 7: Filling items from inventory...");

    local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;
    if (not Auctioneer or not Auctioneer.fillFromInventory) then
        self:error("MultiAuction Auctioneer or fillFromInventory not found");
        return;
    end

    -- Trigger fill from inventory with parameters
    -- fillFromInventory(minimumQuality, minimumItemLevel, includeBOEs, includeAwarded, includeMaterials)
    Auctioneer:fillFromInventory(
        0,      -- minimumQuality (0 = Poor)
        0,      -- minimumItemLevel
        true,   -- includeBOEs
        true,   -- includeAwarded
        true    -- includeMaterials
    );

    -- ItemRows is on the UI Interface, not the Auctioneer class
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

    self:scheduleNext(1, function () self:step8_SelectItems() end);
end

--- Step 8: Select Items
function E2E:step8_SelectItems()
    if (not self.isRunning) then return; end

    self.currentStep = 8;
    self.runnerStep = 8;
    self:log("Step 8: Selecting items...");

    -- Click the SelectAll checkbox to trigger its callback
    local SelectAll = GL.Interface.GDKP.MultiAuction.Auctioneer.SelectAll;
    if (SelectAll) then
        SelectAll:Click();

        local itemCount = #(GL.Interface.GDKP.MultiAuction.Auctioneer.ItemRows or {});
        self:success(("Selected all %d items"):format(itemCount));
    else
        self:error("SelectAll checkbox not found");
        return;
    end

    self:scheduleNext(1, function () self:step9_ClickNext() end);
end

--- Step 9: Click Next Button (Opens Version Check)
function E2E:step9_ClickNext()
    if (not self.isRunning) then return; end

    self.currentStep = 9;
    self.runnerStep = 9;
    self:log("Step 9: Clicking Next button...");

    -- Find and click the Next button in the auctioneer window
    local auctioneerWindow = _G["Gargul.Interface.GDKP.MultiAuction.Auctioneer.Window"];
    if (not auctioneerWindow) then
        self:error("Auctioneer window not found");
        return;
    end

    -- Find the Next button (it's a dynamicPanelButton)
    -- We need to search through the window's children
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
        self:scheduleNext(5, function () self:step9b_ClickStartInVersionCheck() end);
    else
        self:error("Next button not found");
    end
end

--- Step 9b: Auto-click Start in Version Check
function E2E:step9b_ClickStartInVersionCheck()
    if (not self.isRunning) then return; end

    self.runnerStep = 10;
    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 9b: Auto-clicking Start in Version Check... (attempt " .. self.retryCount .. ")");

    -- Find the Start button in GroupVersionCheck
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
        self:scheduleNext(1, function () self:step10_WaitForMultiAuctionClient() end);
    elseif (self.retryCount >= MAX_RETRIES.step9b) then
        self:error(("Start button not found after %d attempts"):format(MAX_RETRIES.step9b));
    else
        self:log("Start button not found yet, waiting...");
        self:scheduleNext(2, function () self:step9b_ClickStartInVersionCheck() end);
    end
end

--- Step 10: Wait for MultiAuction Client
function E2E:step10_WaitForMultiAuctionClient()
    if (not self.isRunning) then return; end

    self.currentStep = 10;
    self.runnerStep = 11;
    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 10: Checking if MultiAuction client is visible... (attempt " .. self.retryCount .. ")");

    -- Check if auction is running
    if (GL.GDKP.MultiAuction.Auctioneer:hasRunningAuctions()) then
        self.retryCount = 0;
        self:success("MultiAuction client is running");
        self:scheduleNext(3, function () self:step11_ClickTerminate() end);
    elseif (self.retryCount >= MAX_RETRIES.step10) then
        self:error(("MultiAuction client did not start after %d attempts"):format(MAX_RETRIES.step10));
    else
        self:log("MultiAuction not started yet, waiting...");
        self:scheduleNext(2, function () self:step10_WaitForMultiAuctionClient() end);
    end
end

--- Step 11: Click Terminate Button
function E2E:step11_ClickTerminate()
    if (not self.isRunning) then return; end

    self.currentStep = 11;
    self.runnerStep = 12;
    self:log("Step 11: Clicking Terminate button...");

    -- Find and click Terminate button in the client window
    local clientWindow = _G["Gargul.Interface.GDKP.MultiAuction.Client.Window"];
    if (not clientWindow) then
        self:error("Client window not found");
        return;
    end

    -- Use the shortcut reference
    local terminateButton = clientWindow.TerminateButton;

    if (terminateButton) then
        terminateButton:Click();
        self:success("Clicked Terminate button - waiting for confirmation dialog...");
        self:scheduleNext(1, function () self:step11b_ClickYesOnConfirmation() end);
    else
        self:error("Terminate button not found");
    end
end

--- Step 11b: Click Yes on Confirmation (PopupDialog - AceGUI)
function E2E:step11b_ClickYesOnConfirmation()
    if (not self.isRunning) then return; end

    self.runnerStep = 13;
    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 11b: Looking for StaticPopup confirmation dialog... (attempt " .. self.retryCount .. ")");

    local dialog = _G.StaticPopup1;

    if (dialog and dialog:IsShown()) then
        local dialogText = dialog.Text and dialog.Text:GetText() or "";
        if (not dialogText:match("Remove all")) then
            if (self.retryCount >= MAX_RETRIES.step11b) then
                self:error(("Wrong or unexpected dialog shown after %d attempts: '%s'"):format(MAX_RETRIES.step11b, strsub(dialogText, 1, 80)));
                return;
            end
            self:log("Wrong dialog shown: '" .. strsub(dialogText, 1, 50) .. "', waiting...");
            self:scheduleNext(0.5, function () self:step11b_ClickYesOnConfirmation() end);
            return;
        end

        self.retryCount = 0;
        self:log("Found terminate confirmation dialog");

        -- Get the dialog info and call OnButton1 directly
        local dialogInfo = _G.StaticPopupDialogs[dialog.which];
        if (dialogInfo and dialogInfo.OnButton1) then
            self:log("Executing Yes callback...");
            dialogInfo.OnButton1(dialog);
            dialog:Hide();
            self:success("Executed Yes callback and closed dialog");
            self:scheduleNext(0.5, function () self:step11c_VerifyTermination() end);
        else
            self:error("OnButton1 callback not found on terminate confirmation dialog");
        end
    elseif (self.retryCount >= MAX_RETRIES.step11b) then
        self:error(("StaticPopup confirmation dialog did not appear after %d attempts"):format(MAX_RETRIES.step11b));
    else
        self:log("StaticPopup dialog not visible yet, waiting...");
        self:scheduleNext(0.5, function () self:step11b_ClickYesOnConfirmation() end);
    end
end

--- Step 11c: Verify Termination Completed
function E2E:step11c_VerifyTermination()
    if (not self.isRunning) then return; end

    self.runnerStep = 14;
    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 11c: Verifying auction terminated... (attempt " .. self.retryCount .. ")");

    -- Check if auctions are still running
    if (not GL.GDKP.MultiAuction.Auctioneer:hasRunningAuctions()) then
        self.retryCount = 0;
        self:success("MultiAuction successfully terminated");
        self:scheduleNext(1, function () self:step12_CloseWindows() end);
    elseif (self.retryCount >= MAX_RETRIES.step11c) then
        self:error(("Auction did not terminate after %d attempts"):format(MAX_RETRIES.step11c));
    else
        self:log("Auction still running, waiting...");
        self:scheduleNext(1, function () self:step11c_VerifyTermination() end);
    end
end

--- Step 12: Close Windows
function E2E:step12_CloseWindows()
    if (not self.isRunning) then return; end

    self.currentStep = 12;
    self.runnerStep = 15;
    self:log("Step 12: Closing MultiAuction windows...");

    GL.Interface.GDKP.MultiAuction.Auctioneer:close();

    -- Close client window
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

    -- Wait 1s before cleanup
    self:scheduleNext(1, function ()
        self:stop();
    end);
end

return E2E;
