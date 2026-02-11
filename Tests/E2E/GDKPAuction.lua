---@type GL
local _, GL = ...;
local L = Gargul_L;

--- End-to-End Test for GDKP single-item Auction: creates a session, opens Auctioneer via item, sets Min/Inc/Time/Anti Snipe, starts auction, bids minimum, asserts award, cleans up.
--- Run with: /run Gargul.Tests.E2E.GDKPAuction:start()
--- Stop with: /run Gargul.Tests.E2E.GDKPAuction:stop()

assert(GL.Tests.E2E and GL.Tests.E2E.Base and type(GL.Tests.E2E.Base.startWith) == "function", "GL.Tests.E2E.Base missing (TOC: Tests/E2E/Base.lua before this file)");

---@class GDKPAuction : E2EBase
local E2E = {
    scenarioName = "GDKPAuction",
    isRunning = false,
    runnerStep = 0,
    sessionName = nil,
    sessionID = nil,
    retryCount = 0,
};
setmetatable(E2E, { __index = GL.Tests.E2E.Base });
GL.Tests.E2E.GDKPAuction = E2E; ---@type GDKPAuction

local MAX_RETRIES = {
    step6 = 5,
    step8 = 15,
    step9 = 10,
    step10 = 20,
    step12 = 15,
    step13 = 25,
};

local E2E_STEPS = {
    { title = "Open GDKP Overview", fn = "step1_OpenGDKPOverview", },
    { title = "Open Create Session", fn = "step2_OpenCreateSession", },
    { title = "Fill Session Details", fn = "step3_FillSessionDetails", },
    { title = "Create Session", fn = "step4_CreateSession", },
    { title = "Close GDKP Windows", fn = "step5_CloseGDKPWindows", },
    { title = "Open Auctioneer via item", fn = "step6_OpenAuctioneerViaItem", },
    { title = "Set Min/Inc/Time/Anti Snipe", fn = "step7_SetAuctionFields", },
    { title = "Click Start", fn = "step8_ClickStart", },
    { title = "Assert auction started", fn = "step9_AssertAuctionStarted", },
    { title = "Assert Bidder shown", fn = "step10_AssertBidderShown", },
    { title = "Click Minimum", fn = "step11_ClickMinimum", },
    { title = "Assert bid went through", fn = "step12_AssertBidWentThrough", },
    { title = "Wait until auction done", fn = "step13_WaitUntilAuctionDone", },
    { title = "Assert item awarded", fn = "step14_AssertItemAwarded", },
    { title = "Remove from award history", fn = "step15_RemoveFromAwardHistory", },
    { title = "Force-delete session", fn = "step16_ForceDeleteSession", },
    { title = "Close windows", fn = "step17_CloseWindows", },
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
        GL:after(2, "E2E.GDKPAuction.PermanentDelete", function ()
            GL.DB:set("GDKP.Ledger." .. sessionID, nil);
            self:log("Session permanently deleted");
        end);
        self.sessionID = nil;
    end

    GL.Interface.GDKP.Overview:close();
    GL.Interface.GDKP.CreateSession:close();
    GL.Interface.GDKP.Auctioneer:close();
    if (GL.Interface.GDKP.Bidder and GL.Interface.GDKP.Bidder.Window) then
        GL.Interface.GDKP.Bidder:hide();
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
    self:startWith("E2E Tests", { { name = "GDKPAuction", steps = titles, } });
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
    Window.ManagementCutBox:SetText("10");
    Window.SessionTypeDropdown:SetValue("multi");
    Window.SessionTypeDropdown:SetText(L["Multi-Auction"]);
    Window.SwitchCheckbox:SetValue(true);

    self:success("Session details filled");
    self:next();
end

--- Step 4: Create Session
---@return nil
function E2E:step4_CreateSession()
    if (not self.isRunning) then return; end

    self:log("Step 4: Creating session...");

    local createdSessionID = nil;
    GL.Events:register("E2E.GDKPAuction.Step4", "GL.GDKP_SESSION_CREATED", function (_, Instance)
        createdSessionID = Instance and Instance.ID;
        GL.Events:unregister("E2E.GDKPAuction.Step4");
    end);

    local Window = Gargul.Interface:get(GL.Interface.GDKP.CreateSession, "Window");
    if (not Window or not Window.SaveButton) then
        self:error("Create Session window or SaveButton not found");
        return;
    end

    Window.SaveButton:Fire("OnClick");

    GL:after(.1, "E2E.GDKPAuction.Step4Verify", function ()
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

--- Get first tradeable (or any) item link from bags for E2E.
---@return string|nil
local function getFirstBagItemLink()
    local numBags = 5;
    for bag = 0, numBags - 1 do
        local numSlots = GL.GetContainerNumSlots and GL.GetContainerNumSlots(bag) or 0;
        for slot = 1, numSlots do
            local iconFileID, stackCount, isLocked, quality, isReadable, hasLoot, hyperlink, isFiltered, hasNoValue, itemID, isBound = GL:getContainerItemInfo(bag, slot);
            if (hyperlink and GL:isValidItemLink(hyperlink)) then
                return hyperlink;
            end
        end
    end
    return nil;
end

--- Step 6: Open single-item Auctioneer via item (addItemLink; no MultiAuction)
---@return nil
function E2E:step6_OpenAuctioneerViaItem()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 6: Opening single Auctioneer via item... (attempt " .. self.retryCount .. ")");

    local itemLink = getFirstBagItemLink();
    if (not itemLink) then
        self:error("No tradeable item in bags for alt+click");
        return;
    end

    GL.Interface.GDKP.Auctioneer:close();
    GL:after(.1, "E2E.GDKPAuction.OpenAuctioneer", function ()
        if (not self.isRunning) then return; end

        GL.GDKP.Auctioneer:addItemLink(itemLink);

        local window = _G["Gargul.Interface.GDKP.Auctioneer.Window"];
        if (window and window:IsShown()) then
            self.retryCount = 0;
            self:success("Single Auctioneer opened");
            self:next();
        elseif (self.retryCount >= MAX_RETRIES.step6) then
            self:error("Auctioneer window did not open after item click");
        else
            self:retry(.5);
        end
    end);
end

--- Step 7: Set Min 500, Inc 100, Time 10, Anti Snipe 5
---@return nil
function E2E:step7_SetAuctionFields()
    if (not self.isRunning) then return; end

    self:log("Step 7: Setting Min 500, Inc 100, Time 10, Anti Snipe 5...");

    local Window = _G["Gargul.Interface.GDKP.Auctioneer.Window"];
    if (not Window or not Window:IsShown()) then
        self:error("Auctioneer window not found");
        return;
    end

    if (not Window.MinInput or not Window.IncInput or not Window.TimeInput or not Window.SnipeInput) then
        self:error("Auctioneer input ref missing (MinInput/IncInput/TimeInput/SnipeInput)");
        return;
    end

    Window.MinInput:SetText("500");
    Window.IncInput:SetText("100");
    Window.TimeInput:SetText("10");
    Window.SnipeInput:SetText("5");

    self:success("Min 500, Inc 100, Time 10, Anti Snipe 5 set");
    self:next();
end

--- Step 8: Click Start (single Auctioneer UI)
---@return nil
function E2E:step8_ClickStart()
    if (not self.isRunning) then return; end

    self:log("Step 8: Clicking Start button...");

    local Window = _G["Gargul.Interface.GDKP.Auctioneer.Window"];
    if (not Window) then
        self:error("Auctioneer window not found");
        return;
    end

    local startButton = Window.StartButton or (function ()
        for i = 1, Window:GetNumChildren() do
            local child = select(i, Window:GetChildren());
            if (child and child.GetNumChildren) then
                for j = 1, child:GetNumChildren() do
                    local sub = select(j, child:GetChildren());
                    if (sub and sub.GetText and sub:GetText() == L["Start"]) then
                        return sub;
                    end
                end
            end
        end
        return nil;
    end)();

    if (startButton) then
        self.retryCount = 0;
        startButton:Click();
        self:success("Clicked Start button");
        self:next();
    elseif (self.retryCount >= MAX_RETRIES.step8) then
        self:error(("Start button not found after %d attempts"):format(MAX_RETRIES.step8));
    else
        self.retryCount = (self.retryCount or 0) + 1;
        self:retry(2);
    end
end

--- Step 9: Assert auction started
---@return nil
function E2E:step9_AssertAuctionStarted()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 9: Checking auction started... (attempt " .. self.retryCount .. ")");

    local Auction = GL.GDKP.Auction;
    if (Auction and Auction.inProgress and Auction.Current and Auction.Current.itemLink) then
        self.retryCount = 0;
        self:success("Auction started");
        self:next();
    elseif (self.retryCount >= MAX_RETRIES.step9) then
        self:error(("Auction did not start after %d attempts"):format(MAX_RETRIES.step9));
    else
        self:retry(1);
    end
end

--- Step 10: Assert Bidder window is visible
---@return nil
function E2E:step10_AssertBidderShown()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 10: Assert Bidder shown... (attempt " .. self.retryCount .. ")");

    local bidderWindow = _G["GARGUL_GDKP_BIDDER_WINDOW"];
    if (bidderWindow and bidderWindow:IsShown()) then
        self.retryCount = 0;
        self:success("Bidder window visible");
        self:next();
    elseif (self.retryCount >= MAX_RETRIES.step10) then
        self:error(("Bidder window did not appear after %d attempts"):format(MAX_RETRIES.step10));
    else
        self:retry(1);
    end
end

--- Step 11: Click Minimum button (Bidder must already be visible)
---@return nil
function E2E:step11_ClickMinimum()
    if (not self.isRunning) then return; end

    self:log("Step 11: Clicking Minimum...");

    local minButton = _G["GARGUL_GDKP_BIDDER_MINIMUM_BUTTON"];
    if (not minButton) then
        self:error("Bidder Minimum button not found");
        return;
    end

    minButton:Click();
    self:success("Minimum clicked");
    self:log("Waiting 1s for bid to register...");
    self:next(1);
end

--- Step 12: Assert bid went through (retry until TopBid reflects self at 500, or max retries)
---@return nil
function E2E:step12_AssertBidWentThrough()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 12: Assert bid went through... (attempt " .. self.retryCount .. ")");

    local Current = GL.GDKP.Auction and GL.GDKP.Auction.Current;
    local topBid = Current and Current.TopBid;
    local bid = topBid and topBid.bid;
    local bidderName = topBid and topBid.Bidder and topBid.Bidder.name;
    local myName = GL.User and GL.User.name;

    if (bidderName and GL:iEquals(bidderName, myName) and bid and bid >= 500) then
        self.retryCount = 0;
        self:success("Bid went through (min 500)");
        self:next();
    elseif (self.retryCount >= MAX_RETRIES.step12) then
        self:error("Bid not reflected after " .. MAX_RETRIES.step12 .. " attempts: expected self as top bidder at 500");
    else
        self:retry(1);
    end
end

--- Step 13: Wait until auction is done
---@return nil
function E2E:step13_WaitUntilAuctionDone()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log("Step 13: Waiting for auction to end... (attempt " .. self.retryCount .. ")");

    local Auction = GL.GDKP.Auction;
    if (not Auction or not Auction.inProgress) then
        self.retryCount = 0;
        self:success("Auction ended");
        self:next();
    elseif (self.retryCount >= MAX_RETRIES.step13) then
        self:error(("Auction did not end after %d attempts"):format(MAX_RETRIES.step13));
    else
        self:retry(1);
    end
end

--- Step 14: Assert item awarded to our minimum bid
---@return nil
function E2E:step14_AssertItemAwarded()
    if (not self.isRunning) then return; end

    self:log("Step 14: Assert item awarded to self at 500...");

    local ledger = self.sessionID and GL.DB:get("GDKP.Ledger." .. self.sessionID);
    local auctions = ledger and ledger.Auctions;
    if (not auctions) then
        self:error("No auction in session ledger");
        return;
    end

    local count = 0;
    local found = nil;
    for id, auct in pairs(auctions) do
        count = count + 1;
        found = auct;
    end

    if (count ~= 1 or not found) then
        self:error("No auction in session ledger");
        return;
    end

    local winnerName = found.Winner and found.Winner.name;
    local price = found.price;
    local myName = GL.User and GL.User.name;

    if (not winnerName or not GL:iEquals(winnerName, myName)) then
        self:error("Award winner is not self");
        return;
    end

    if (not price or price ~= 500) then
        self:error("Award price is not 500");
        return;
    end

    self.awardedAuction = found;
    self:success("Item awarded to self at 500");
    self:next();
end

--- Step 15: Remove awarded item from award history
---@return nil
function E2E:step15_RemoveFromAwardHistory()
    if (not self.isRunning) then return; end

    self:log("Step 15: Removing award from history...");

    local checksum = self.awardedAuction and self.awardedAuction.awardChecksum;
    if (not checksum) then
        self:error("Auction has no awardChecksum");
        return;
    end

    GL.AwardedLoot:deleteWinner(checksum, false, false);
    self:success("Award removed from history");
    self:next();
end

--- Step 16: Force-delete GDKP session
---@return nil
function E2E:step16_ForceDeleteSession()
    if (not self.isRunning) then return; end

    self:log("Step 16: Force-deleting session...");

    if (not self.sessionID) then
        self:error("No sessionID to delete");
        return;
    end

    local sessionID = self.sessionID;
    GL.GDKP.Session:delete(sessionID);
    GL:after(2, "E2E.GDKPAuction.PermanentDelete", function ()
        GL.DB:set("GDKP.Ledger." .. sessionID, nil);
    end);

    self:success("Session force-delete scheduled");
    self:next();
end

--- Step 17: Close windows (final)
---@return nil
function E2E:step17_CloseWindows()
    if (not self.isRunning) then return; end

    self:log("Step 17: Closing Auctioneer and Bidder...");

    GL.Interface.GDKP.Auctioneer:close();
    if (GL.Interface.GDKP.Bidder and GL.Interface.GDKP.Bidder.hide) then
        GL.Interface.GDKP.Bidder:hide();
    end

    local auctioneerShown = GL.Interface.GDKP.Auctioneer.isVisible;
    local bidderWindow = _G["GARGUL_GDKP_BIDDER_WINDOW"];
    local bidderShown = bidderWindow and bidderWindow:IsShown();

    if (auctioneerShown or bidderShown) then
        self:error("Auctioneer/Bidder window remained visible after close");
        return;
    end

    self:success("Auctioneer and Bidder closed");
    self:log("========== E2E Test Complete ==========");
    self:next();
end

return E2E;
