---@type GL
local _, GL = ...;
local L = Gargul_L;

--- Standalone GDKP Tests (No WoWUnit Required)
--- Run with: /run GargulTests:runAll()
--- Run specific: /run GargulTests:run("Session Creation")

_G.GargulTests = {
    results = {
        passed = 0,
        failed = 0,
        total = 0,
    },
    currentCategory = nil,
};

local Tests = _G.GargulTests;

--- Simple assertion framework (replaces WoWUnit)
local Assert = {
    failures = {},
};

function Assert:reset()
    self.failures = {};
end

function Assert:assert(condition, message)
    if (not condition) then
        tinsert(self.failures, message or "Assertion failed");
        error(message or "Assertion failed");
    end
end

function Assert:assertEquals(expected, actual, message)
    if (expected ~= actual) then
        local msg = ("%s: expected '%s', got '%s'"):format(
            message or "Value mismatch",
            tostring(expected),
            tostring(actual)
        );
        tinsert(self.failures, msg);
        error(msg);
    end
end

function Assert:isNil(value, message)
    if (value ~= nil) then
        local msg = message or ("Expected nil, got %s"):format(tostring(value));
        tinsert(self.failures, msg);
        error(msg);
    end
end

--- Helper functions
local Helpers = {
    createdSessionID = nil,
};

function Helpers:generateSessionName()
    return ("test-%s"):format(date("%d%m-%H%M%S"));
end

function Helpers:cleanupSession()
    if (self.createdSessionID) then
        local sessionID = self.createdSessionID;

        -- First delete via traditional UI means (soft delete)
        GL.GDKP.Session:delete(sessionID);

        -- Then permanently delete after 2 seconds
        GL:after(2, "GargulTests.PermanentDelete." .. sessionID, function ()
            GL.DB:set("GDKP.Ledger." .. sessionID, nil);
        end);

        self.createdSessionID = nil;
    end
end

function Helpers:closeAllWindows()
    GL.Interface.GDKP.Overview:close();
    GL.Interface.GDKP.CreateSession:close();
    GL.Interface.GDKP.MultiAuction.Auctioneer:close();
    GL.Interface.GDKP.MultiAuction.FillFromInventory:close();
    GL.Interface.GroupVersionCheck:close();
end

--- Test runner
function Tests:runTest(category, testName, testFunc, setup, teardown)
    self.results.total = self.results.total + 1;

    local fullName = ("%s: %s"):format(category, testName);

    -- Setup
    if (setup) then
        pcall(setup);
    end

    -- Run test
    Assert:reset();
    local success, err = pcall(testFunc);

    -- Teardown
    if (teardown) then
        pcall(teardown);
    end

    -- Report result
    if (success) then
        self.results.passed = self.results.passed + 1;
        Gargul:xd(("[Test] ✓ %s"):format(fullName));
        return true;
    else
        self.results.failed = self.results.failed + 1;
        Gargul:xd(("[Test] ✗ %s"):format(fullName));
        Gargul:xd(("[Test]   Error: %s"):format(tostring(err)));

        -- Print any assertion failures
        if (#Assert.failures > 0) then
            for _, failure in ipairs(Assert.failures) do
                Gargul:xd(("[Test]     - %s"):format(failure));
            end
        end

        return false;
    end
end

function Tests:run(categoryName)
    Gargul:xd(("========== Running Tests: %s =========="):format(categoryName or "All"));
    self.results = { passed = 0, failed = 0, total = 0 };

    for category, tests in pairs(self.tests or {}) do
        if (not categoryName or category == categoryName) then
            self.currentCategory = category;

            local setup = tests.setup;
            local teardown = tests.teardown;

            for testName, testFunc in pairs(tests) do
                if (testName ~= "setup" and testName ~= "teardown") then
                    self:runTest(category, testName, testFunc, setup, teardown);
                end
            end
        end
    end

    Gargul:xd("");
    Gargul:xd(("========== Results =========="));
    Gargul:xd(("Total:  %d"):format(self.results.total));
    Gargul:xd(("Passed: %d"):format(self.results.passed));
    Gargul:xd(("Failed: %d"):format(self.results.failed));

    if (self.results.failed == 0) then
        Gargul:xd("✓ All tests passed!");
    end
end

function Tests:runAll()
    self:run(nil);
end

--- Test Suites
Tests.tests = {};

-----------------------------------------------------------
-- Session Creation Tests
-----------------------------------------------------------
Tests.tests["Session Creation"] = {
    ["Can open GDKP Overview"] = function ()
        GL.Interface.GDKP.Overview:open();

        local Window = Gargul.Interface:get(GL.Interface.GDKP.Overview, "GDKPOverview");
        Assert:assert(Window, "GDKP Overview window exists");
        Assert:assert(Window:IsShown(), "GDKP Overview is visible");

        -- Wait 1s before cleanup for visual feedback
        GL:after(1, "Test.Cleanup.Overview", function ()
            Helpers:closeAllWindows();
        end);
    end,

    ["Can create Multi-Auction session via UI"] = function ()
        GL.Interface.GDKP.Overview:open();
        GL.Interface.GDKP.CreateSession:open();

        local Window = Gargul.Interface:get(GL.Interface.GDKP.CreateSession, "Window");
        Assert:assert(Window, "CreateSession window exists");
        Assert:assert(Window.TitleBox, "TitleBox exists");
        Assert:assert(Window.ManagementCutBox, "ManagementCutBox exists");
        Assert:assert(Window.SessionTypeDropdown, "SessionTypeDropdown exists");
        Assert:assert(Window.SwitchCheckbox, "SwitchCheckbox exists");
        Assert:assert(Window.SaveButton, "SaveButton exists");

        local sessionName = Helpers:generateSessionName();

        Window.TitleBox:SetText(sessionName);
        Window.ManagementCutBox:SetText("10");
        Window.SessionTypeDropdown:SetValue("multi");
        Window.SessionTypeDropdown:SetText(L["Multi-Auction"]);
        Window.SwitchCheckbox:SetValue(true);
        Window.SaveButton:Fire("OnClick");

        -- Verify session was created
        local activeSessionID = GL.GDKP.Session:activeSessionID();
        Assert:assert(activeSessionID, "Active session ID exists");

        local session = GL.GDKP.Session:byID(activeSessionID);
        Assert:assert(session, "Session exists");
        -- Session title is capitalized by GL:capitalize()
        local expectedTitle = sessionName:sub(1, 1):upper() .. sessionName:sub(2);
        Assert:assertEquals(expectedTitle, session.title, "Session name matches");
        Assert:assertEquals(10, session.managementCut, "Management cut is 10");
        Assert:assertEquals("multi", session.type, "Session type is multi");

        Helpers.createdSessionID = activeSessionID;

        -- Wait 1s before cleanup for visual feedback
        GL:after(1, "Test.Cleanup.CreateSession", function ()
            Helpers:cleanupSession();
            Helpers:closeAllWindows();
        end);
    end,

    ["Can activate session"] = function ()
        local sessionName = Helpers:generateSessionName();
        local session = GL.GDKP.Session:create(sessionName, 5, "multi");
        Helpers.createdSessionID = session.ID;

        GL.GDKP.Session:setActive(session.ID);

        local activeID = GL.GDKP.Session:activeSessionID();
        Assert:assertEquals(session.ID, activeID, "Session is active");

        -- Cleanup
        Helpers:cleanupSession();
    end,

    ["Can delete session"] = function ()
        local sessionName = Helpers:generateSessionName();
        local session = GL.GDKP.Session:create(sessionName, 5, "multi");
        local sessionID = session.ID;

        Assert:assert(GL.GDKP.Session:byID(sessionID), "Session exists");

        GL.GDKP.Session:delete(sessionID);

        Assert:isNil(GL.GDKP.Session:byID(sessionID), "Session deleted");
    end,
};

-----------------------------------------------------------
-- MultiAuction Tests
-----------------------------------------------------------
Tests.tests["MultiAuction Setup"] = {
    ["Can open MultiAuction window"] = function ()
        -- Create session first
        local sessionName = Helpers:generateSessionName();
        local session = GL.GDKP.Session:create(sessionName, 10, "multi");
        Helpers.createdSessionID = session.ID;
        GL.GDKP.Session:setActive(session.ID);

        Assert:assert(GL.GDKP.Session:activeSessionID(), "Has active session");

        GL.Interface.GDKP.MultiAuction.Auctioneer:open();

        local window = _G["Gargul.Interface.GDKP.MultiAuction.Auctioneer.Window"];
        Assert:assert(window, "Auctioneer window exists");
        Assert:assert(window:IsShown(), "Auctioneer window is visible");

        -- Wait 1s before cleanup for visual feedback
        GL:after(1, "Test.Cleanup.MultiAuction", function ()
            Helpers:closeAllWindows();
            Helpers:cleanupSession();
        end);
    end,

    ["Can configure fill settings"] = function ()
        GL.Settings:set("GDKP.MultiAuction.minimumFillQuality", 0);
        GL.Settings:set("GDKP.MultiAuction.minimumFillItemLevel", "0");
        GL.Settings:set("GDKP.MultiAuction.includeBOEs", true);
        GL.Settings:set("GDKP.MultiAuction.includeAwarded", true);
        GL.Settings:set("GDKP.MultiAuction.includeMaterials", true);

        Assert:assertEquals(0, GL.Settings:get("GDKP.MultiAuction.minimumFillQuality"), "Min quality is Poor");
        Assert:assertEquals("0", GL.Settings:get("GDKP.MultiAuction.minimumFillItemLevel"), "Min ilvl is 0");
        Assert:assert(GL.Settings:get("GDKP.MultiAuction.includeBOEs"), "BOEs included");
    end,

    ["Can set auction time"] = function ()
        -- Create session first
        local sessionName = Helpers:generateSessionName();
        local session = GL.GDKP.Session:create(sessionName, 10, "multi");
        Helpers.createdSessionID = session.ID;
        GL.GDKP.Session:setActive(session.ID);

        GL.Interface.GDKP.MultiAuction.Auctioneer:open();

        local window = _G["Gargul.Interface.GDKP.MultiAuction.Auctioneer.Window"];
        Assert:assert(window._TimeInput, "TimeInput exists");

        window._TimeInput:SetText("20");
        local actualValue = tostring(window._TimeInput:GetText());
        Assert:assertEquals("20", actualValue, "Auction time set to 20");

        -- Wait 1s before cleanup for visual feedback
        GL:after(1, "Test.Cleanup.AuctionTime", function ()
            Helpers:closeAllWindows();
            Helpers:cleanupSession();
        end);
    end,
};

--- Convenience aliases
function Tests:session()
    self:run("Session Creation");
end

function Tests:multiauction()
    self:run("MultiAuction Setup");
end

return Tests;
