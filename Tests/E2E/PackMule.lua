---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field, need-check-nil

assert(GL.Tests.E2E and GL.Tests.E2E.Base and type(GL.Tests.E2E.Base.startWith) == "function", "GL.Tests.E2E.Base missing (TOC: Tests/E2E/Base.lua before this file)");

---@class PackMuleE2E : E2EBase
local E2E = {
    scenarioName = "PackMule",
    isRunning = false,
    runnerStep = 0,
    retryCount = 0,
    savedSettings = nil,
    savedPackMuleState = nil,
    savedPackMuleMethods = nil,
    targetFQN = nil,
    errorItemID = nil,
    silentItemID = nil,
    pendingSilentCountBefore = 0,
    closePendingOpened = false,
    closePendingStartedAt = 0,
    cleanupComplete = false,
};
setmetatable(E2E, { __index = GL.Tests.E2E.Base });
GL.Tests.E2E.PackMule = E2E; ---@type PackMuleE2E

local Loot = GL.Tests.Fakes.Loot;

local MAX_RETRIES = {
    happy = 20,
    error = 20,
    silent = 25,
    close = 10,
};

local ITEM_IDS = {
    6948, -- Hearthstone
    25, -- Worn Shortsword
    35, -- Bent Staff
    36, -- Worn Mace
    159, -- Refreshing Spring Water
    117, -- Tough Jerky
};

local E2E_STEPS = {
    { title = "Setup fake master loot", fn = "step1_Setup", },
    { title = "Open six-item loot window", fn = "step2_OpenHappyLoot", },
    { title = "Assert happy handouts", fn = "step3_AssertHappyHandouts", },
    { title = "Simulate categorized loot error", fn = "step4_OpenErrorLoot", },
    { title = "Assert categorized loot error", fn = "step5_AssertErrorReported", },
    { title = "Simulate silent handout failure", fn = "step6_OpenSilentFailureLoot", },
    { title = "Assert silent failure fallback", fn = "step7_AssertSilentFailure", },
    { title = "Close with pending handout", fn = "step8_CloseWithPendingHandout", },
    { title = "Assert pending handout cleanup", fn = "step9_AssertCloseCleanup", },
    { title = "Cleanup", fn = "step10_Cleanup", },
};

---@return table
function E2E:getStepTitles()
    local titles = {};
    for _, step in ipairs(E2E_STEPS) do
        table.insert(titles, step.title);
    end
    return titles;
end

---@param name string
---@param index number
---@return table
local function buildPlayer(name, index)
    local realm = GL.User.realm or "";
    local fqn = GL:addRealm(name, realm, false);
    return {
        name = name,
        realm = realm,
        fqn = fqn,
        rank = index == 1 and 2 or 0,
        subgroup = 1,
        level = GL.User.level or 80,
        class = strlower(GL.User.class or "warrior"),
        classFile = GL.User.classFile or "WARRIOR",
        zone = "PackMule E2E",
        online = true,
        isDead = false,
        role = "",
        isML = index == 1,
        isLeader = index == 1,
        hasAssist = true,
        index = index,
    };
end

---@param itemIDs table
---@return table
local function buildItems(itemIDs)
    local items = {};
    for _, itemID in ipairs(itemIDs) do
        table.insert(items, {
            id = itemID,
        });
    end
    return items;
end

---@param itemIDs table
---@param target string
---@return table
local function buildRules(itemIDs, target)
    local rules = {};
    for _, itemID in ipairs(itemIDs) do
        table.insert(rules, {
            item = tostring(itemID),
            target = target,
        });
    end
    return rules;
end

---@param reason string
---@return boolean
function E2E:packMuleHasLootError(reason)
    for _, Entry in pairs(GL.PackMule.LootErrors or {}) do
        if (Entry.reasonCategory == reason) then
            return true;
        end
    end
    return false;
end

---@param result string
---@return nil
function E2E:logHandouts(result)
    for _, Entry in ipairs(Loot.log or {}) do
        if (Entry.action == "GiveMasterLoot"
            and (not result or Entry.result == result)
        ) then
            self:log(("%s -> %s (%s)"):format(Entry.itemLink or "?", Entry.player or "?", Entry.result or "?"));
        end
    end
end

---@param prefix string
---@return nil
function E2E:cancelPackMuleTimers(prefix)
    local timerIDs = {};
    for timerID in pairs(GL.Timers or {}) do
        if (GL:strStartsWith(timerID, prefix)) then
            table.insert(timerIDs, timerID);
        end
    end

    for _, timerID in ipairs(timerIDs) do
        GL:cancelTimer(timerID);
    end
end

---@return nil
function E2E:saveState()
    self.savedSettings = {
        enabledForMasterLoot = GL.Settings:get("PackMule.enabledForMasterLoot"),
        lootGold = GL.Settings:get("PackMule.lootGold"),
        autoConfirmGroup = GL.Settings:get("PackMule.autoConfirmGroup"),
        autoConfirmSolo = GL.Settings:get("PackMule.autoConfirmSolo"),
        Rules = GL:cloneTable(GL.Settings:get("PackMule.Rules", {})),
    };

    self.savedPackMuleState = {
        Rules = GL:cloneTable(GL.PackMule.Rules or {}),
        LootErrors = GL:cloneTable(GL.PackMule.LootErrors or {}),
        PendingHandouts = GL:cloneTable(GL.PackMule.PendingHandouts or {}),
        processing = GL.PackMule.processing,
        LootChangedTimer = GL.PackMule.LootChangedTimer,
    };

    self.savedPackMuleMethods = {
        lootReady = GL.PackMule.lootReady,
        getTargetForItem = GL.PackMule.getTargetForItem,
        giveMasterLoot = GL.PackMule.giveMasterLoot,
    };
end

---@return nil
function E2E:restoreState()
    self:cancelPackMuleTimers("PackMule.Handout.");
    self:cancelPackMuleTimers("PackMule.LootError.");

    if (self.savedSettings) then
        local SavedSettings = self.savedSettings;
        GL.Settings:set("PackMule.enabledForMasterLoot", SavedSettings.enabledForMasterLoot, true);
        GL.Settings:set("PackMule.lootGold", SavedSettings.lootGold, true);
        GL.Settings:set("PackMule.autoConfirmGroup", SavedSettings.autoConfirmGroup, true);
        GL.Settings:set("PackMule.autoConfirmSolo", SavedSettings.autoConfirmSolo, true);
        GL.Settings:set("PackMule.Rules", SavedSettings.Rules, true);
    end

    if (self.savedPackMuleState) then
        local SavedPackMuleState = self.savedPackMuleState;
        if (GL.PackMule.LootChangedTimer) then
            GL.Ace:CancelTimer(GL.PackMule.LootChangedTimer);
        end

        GL.PackMule.LootErrors = SavedPackMuleState.LootErrors or {};
        GL.PackMule.PendingHandouts = SavedPackMuleState.PendingHandouts or {};
        GL.PackMule.processing = SavedPackMuleState.processing;
        GL.PackMule.LootChangedTimer = nil;
    end

    if (self.savedPackMuleMethods) then
        GL.PackMule.lootReady = self.savedPackMuleMethods.lootReady;
        GL.PackMule.getTargetForItem = self.savedPackMuleMethods.getTargetForItem;
        GL.PackMule.giveMasterLoot = self.savedPackMuleMethods.giveMasterLoot;
    end

    GL.PackMule.Rules = GL.Settings:get("PackMule.Rules", {});
    self.savedSettings = nil;
    self.savedPackMuleState = nil;
    self.savedPackMuleMethods = nil;
end

---@return nil
function E2E:instrumentPackMule()
    local OriginalLootReady = self.savedPackMuleMethods.lootReady;
    local OriginalGetTargetForItem = self.savedPackMuleMethods.getTargetForItem;
    local OriginalGiveMasterLoot = self.savedPackMuleMethods.giveMasterLoot;

    GL.PackMule.lootReady = function (PackMule)
        Gargul:xd({
            event = "Tests.E2E.PackMule:lootReady.enter",
            processing = PackMule.processing,
            ruleCount = GL:count(PackMule.Rules or {}),
            isMasterLooter = GL.User.isMasterLooter,
            lootItems = GetNumLootItems(),
        });
        local result = OriginalLootReady(PackMule);
        Gargul:xd({
            event = "Tests.E2E.PackMule:lootReady.exit",
            processing = PackMule.processing,
            pendingHandouts = PackMule.PendingHandouts,
            lootLog = Loot.log,
        });
        return result;
    end;

    GL.PackMule.getTargetForItem = function (PackMule, itemLinkOrID, callback)
        Gargul:xd({
            event = "Tests.E2E.PackMule:getTargetForItem.enter",
            itemLinkOrID = itemLinkOrID,
        });
        return OriginalGetTargetForItem(PackMule, itemLinkOrID, function (target)
            Gargul:xd({
                event = "Tests.E2E.PackMule:getTargetForItem.callback",
                itemLinkOrID = itemLinkOrID,
                target = target,
            });
            if (type(callback) == "function") then
                return callback(target);
            end
        end);
    end;

    GL.PackMule.giveMasterLoot = function (PackMule, itemIndex, playerIndex, itemLink, playerName)
        Gargul:xd({
            event = "Tests.E2E.PackMule:giveMasterLoot",
            itemIndex = itemIndex,
            playerIndex = playerIndex,
            itemLink = itemLink,
            playerName = playerName,
        });
        return OriginalGiveMasterLoot(PackMule, itemIndex, playerIndex, itemLink, playerName);
    end;
end

---@return nil
function E2E:cleanup()
    if (self.cleanupComplete) then
        return;
    end

    self:cancelPackMuleTimers("PackMule.Handout.");
    self:cancelPackMuleTimers("PackMule.LootError.");
    GL.PackMule.LootErrors = {};
    Loot:uninstall();
    self:cancelPackMuleTimers("PackMule.Handout.");
    self:cancelPackMuleTimers("PackMule.LootError.");
    self:restoreState();
    self.cleanupComplete = true;
end

---@return nil
function E2E:stop()
    self:resetRunnerState();
    self:cleanup();
    self:log("Stopped and cleaned up");
end

---@param skipRunnerOpen boolean|nil
---@return nil
function E2E:start(skipRunnerOpen)
    self.retryCount = 0;
    self.cleanupComplete = false;
    self.closePendingOpened = false;
    self.steps = E2E_STEPS;

    if (skipRunnerOpen) then
        if (self.isRunning) then
            self:log("Test already running. Use /run Gargul.Tests.E2E.PackMule:stop() to stop it first.");
            return;
        end
        self.isRunning = true;
        self.runnerStep = 0;
        GL.Interface.Tests.Runner:setActiveScenario(self.scenarioName);
        self:log("========== Starting PackMule E2E Test ==========");
        self:runStep(1);
        return;
    end

    self:startWith("E2E Tests", { { name = "PackMule E2E", steps = self:getStepTitles(), key = "PackMule", } });
    self:runStep(1);
end

---@return nil
function E2E:step1_Setup()
    if (not self.isRunning) then return; end

    self:log("Step 1: Installing loot harness...");
    Loot:install();
    self:saveState();
    self:instrumentPackMule();

    local selfName = GL.User.name or "PackMuleML";
    self.targetFQN = GL:addRealm("PackMuleTarget", GL.User.realm or "", false);
    local players = {
        buildPlayer(selfName, 1),
        buildPlayer("PackMuleTarget", 2),
        buildPlayer("PackMuleBackup", 3),
    };
    Loot:setMasterLootGroup(players);

    GL.Settings:set("PackMule.enabledForMasterLoot", true, true);
    GL.Settings:set("PackMule.lootGold", false, true);
    GL.Settings:set("PackMule.autoConfirmGroup", false, true);
    GL.Settings:set("PackMule.autoConfirmSolo", false, true);

    GL.PackMule.Rules = buildRules(ITEM_IDS, self.targetFQN);
    GL.Settings:set("PackMule.Rules", GL.PackMule.Rules, true);
    GL.PackMule.LootErrors = {};
    GL.PackMule.PendingHandouts = {};
    GL.PackMule.processing = false;

    GL.PackMule:getTargetForItem(ITEM_IDS[1], function (target)
        Gargul:xd({
            event = "Tests.E2E.PackMule:targetProbe",
            itemID = ITEM_IDS[1],
            target = target,
            targetFQN = self.targetFQN,
            groupMemberNames = GL.User:groupMemberNames(true),
            candidate1 = GetMasterLootCandidate(1, 1),
            candidate2 = GetMasterLootCandidate(1, 2),
            rules = GL.PackMule.Rules,
            isMasterLooter = GL.User.isMasterLooter,
            lootMethod = GL.GetLootMethod(),
        });
    end);

    self:success("Fake master loot ready");
    self:next(.2);
end

---@return nil
function E2E:step2_OpenHappyLoot()
    if (not self.isRunning) then return; end

    self:log("Step 2: Opening six-item loot window...");
    Loot:open(buildItems(ITEM_IDS));

    if (#Loot:visibleSlots() ~= 4) then
        self:error("Expected first native loot page to expose four buttons");
        return;
    end

    Loot:setPage(2);
    if (#Loot:visibleSlots() ~= 2) then
        self:error("Expected second native loot page to expose the remaining two buttons");
        return;
    end
    Loot:setPage(1);

    self:success("Six-item loot window opened");
    self:next(.5);
end

---@return nil
function E2E:step3_AssertHappyHandouts()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    local successCount = Loot:countHandoutsByResult("success");
    self:log(("Step 3: Waiting for six handouts (%d/6, attempt %d)..."):format(successCount, self.retryCount));

    if (successCount >= 6 and Loot:remainingItemCount() == 0) then
        self.retryCount = 0;
        self:logHandouts("success");
        Loot:close();
        self:success("All six items were handed out and removed");
        self:next(.5);
    elseif (self.retryCount >= MAX_RETRIES.happy) then
        Gargul:xd({
            event = "Tests.E2E.PackMule:happyTimeout",
            successCount = successCount,
            remainingItemCount = Loot:remainingItemCount(),
            pendingHandouts = GL.PackMule.PendingHandouts,
            lootLog = Loot.log,
            processing = GL.PackMule.processing,
            rules = GL.PackMule.Rules,
        });
        self:error("PackMule did not hand out all six items");
    else
        self:retry(.5);
    end
end

---@return nil
function E2E:step4_OpenErrorLoot()
    if (not self.isRunning) then return; end

    self:log("Step 4: Opening loot with a bags-full failure...");
    self.errorItemID = 117;
    GL.PackMule.Rules = buildRules({ self.errorItemID, }, self.targetFQN);
    GL.Settings:set("PackMule.Rules", GL.PackMule.Rules, true);
    GL.PackMule.LootErrors = {};
    Loot:failHandoutForItem(self.errorItemID, "bagsFull");
    Loot:open(buildItems({ self.errorItemID, }));

    self:success("Categorized failure armed");
    self:next(.5);
end

---@return nil
function E2E:step5_AssertErrorReported()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log(("Step 5: Waiting for bags-full report (attempt %d)..."):format(self.retryCount));

    if (Loot:countHandoutsByResult("bagsFull") > 0 and self:packMuleHasLootError("bagsFull")) then
        self.retryCount = 0;
        Loot:close();
        self:success("Bags-full failure was reported through PackMule");
        self:next(.5);
    elseif (self.retryCount >= MAX_RETRIES.error) then
        self:error("PackMule did not report the simulated bags-full failure");
    else
        self:retry(.5);
    end
end

---@return nil
function E2E:step6_OpenSilentFailureLoot()
    if (not self.isRunning) then return; end

    self:log("Step 6: Opening loot with a silent handout failure...");
    self.silentItemID = 159;
    GL.PackMule.Rules = buildRules({ self.silentItemID, }, self.targetFQN);
    GL.Settings:set("PackMule.Rules", GL.PackMule.Rules, true);
    GL.PackMule.LootErrors = {};
    Loot:silentFailHandoutForItem(self.silentItemID);
    Loot:open(buildItems({ self.silentItemID, }));

    self:success("Silent failure armed");
    self:next(2);
end

---@return nil
function E2E:step7_AssertSilentFailure()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log(("Step 7: Waiting for still-in-window fallback (attempt %d)..."):format(self.retryCount));

    if (Loot:countHandoutsByResult("silentFailure") > 0 and self:packMuleHasLootError("stillInWindow")) then
        self.retryCount = 0;
        Loot:close();
        self:success("Silent failure fallback reported still-in-window");
        self:next(.5);
    elseif (self.retryCount >= MAX_RETRIES.silent) then
        self:error("PackMule did not report the silent handout failure");
    else
        self:retry(.5);
    end
end

---@return nil
function E2E:step8_CloseWithPendingHandout()
    if (not self.isRunning) then return; end

    if (not self.closePendingOpened) then
        self:log("Step 8: Opening loot for pending-handout close test...");
        local itemID = 25;
        GL.PackMule.Rules = buildRules({ itemID, }, self.targetFQN);
        GL.Settings:set("PackMule.Rules", GL.PackMule.Rules, true);
        GL.PackMule.LootErrors = {};
        GL.PackMule.PendingHandouts = {};
        self.pendingSilentCountBefore = Loot:countHandoutsByResult("silentFailure");
        self.closePendingStartedAt = GetTime();
        self.closePendingOpened = true;
        self.retryCount = 0;
        Loot:silentFailNextHandout();
        Loot:open(buildItems({ itemID, }));
    end

    self.retryCount = (self.retryCount or 0) + 1;
    local handoutStarted = Loot:countHandoutsByResult("silentFailure") > self.pendingSilentCountBefore
        and not GL:empty(GL.PackMule.PendingHandouts);
    local waitedLongEnough = GetTime() - self.closePendingStartedAt >= 1;

    if (handoutStarted and waitedLongEnough) then
        Loot:close();
        self.retryCount = 0;
        self:success("Closed loot during pending handout");
        self:next(2);
    elseif (self.retryCount >= MAX_RETRIES.close) then
        self:error("Pending handout never started before close");
    else
        self:retry(.2);
    end
end

---@return nil
function E2E:step9_AssertCloseCleanup()
    if (not self.isRunning) then return; end

    self.retryCount = (self.retryCount or 0) + 1;
    self:log(("Step 9: Checking pending handout cleanup (attempt %d)..."):format(self.retryCount));

    if (not GL:empty(GL.PackMule.PendingHandouts)) then
        if (self.retryCount >= MAX_RETRIES.close) then
            self:error("Pending handouts were not cleared after LOOT_CLOSED");
        else
            self:retry(.5);
        end
    elseif (self:packMuleHasLootError("stillInWindow")) then
        self:error("Late still-in-window fallback fired after LOOT_CLOSED");
    elseif (Loot:countHandoutsByResult("silentFailure") > self.pendingSilentCountBefore) then
        self.retryCount = 0;
        self:success("Pending handout was cleared and fallback stayed cancelled");
        self:next(.2);
    elseif (self.retryCount >= MAX_RETRIES.close) then
        self:error("No pending silent handout was recorded before close");
    else
        self:retry(.5);
    end
end

---@return nil
function E2E:step10_Cleanup()
    if (not self.isRunning) then return; end

    self:log("Step 10: Restoring PackMule and loot state...");
    self:cleanup();
    self:success("PackMule E2E cleanup complete");
    self:log("========== PackMule E2E Test Complete ==========");
    self:next();
end

return E2E;
