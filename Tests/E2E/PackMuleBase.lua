---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field, need-check-nil

assert(GL.Tests.E2E and GL.Tests.E2E.Base and type(GL.Tests.E2E.Base.startWith) == "function", "GL.Tests.E2E.Base missing (TOC: Tests/E2E/Base.lua before this file)");

--- Table-driven case runner shared by the PackMule E2E scenarios. A scenario calls
--- PackMuleBase:extend({ scenarioName, label, CASES, ... }) and gets Setup, one Runner step per case, and Cleanup.
---
--- Case fields (all optional except title):
---   title, requires(): boolean, skipReason
---   players: { "Name", { name, online, candidateName, }, } (the master looter is always added as player 1)
---   user: GL.User flag overrides, settings: { ["Setting.key"] = value, }, rules: PackMule rules
---   items: Loot:open items, cacheItems: extra item IDs to warm
---   arrange(E2E, Loot, State) before opening, start(E2E, Loot, State) replaces Loot:open
---   afterOpen(E2E, Loot, State), poll(E2E, Loot, elapsed, State), ready(E2E, Loot, State), check(E2E, Loot, State)
---     afterOpen/poll/check return a failure message, ready returns true or false plus what it's waiting for
---   expect = { handouts, untouched, remaining, removed, errors, messages, rolls, }
---   allowMessages, allowExtraHandouts, settle, timeout, pollInterval, leaveOpen
---@class PackMuleE2EBase : E2EBase
local Base = {};
setmetatable(Base, { __index = GL.Tests.E2E.Base, });
GL.Tests.E2E.PackMuleBase = Base; ---@type PackMuleE2EBase

local Loot = GL.Tests.Fakes.Loot;
local GroupLoot = GL.Tests.Fakes.GroupLoot;

local POLL_INTERVAL = .25;
local DEFAULT_SETTLE = 1.2;
local DEFAULT_ERROR_SETTLE = 2.2;
local DEFAULT_TIMEOUT = 4;
local CACHE_RETRIES = 40;

local DEFAULT_PLAYER_SPECS = { "PackMuleTarget", "PackMuleBackup", };

local BASE_SETTINGS = {
    ["PackMule.enabledForMasterLoot"] = true,
    ["PackMule.enabledForGroupLoot"] = false,
    ["PackMule.lootGold"] = false,
    ["PackMule.autoConfirmGroup"] = false,
    ["PackMule.autoConfirmSolo"] = false,
    ["PackMule.autoDisableForGroupLoot"] = false,
    ["PackMule.needWithoutAssist"] = false,
    ["PackMule.announceDisenchantedItems"] = false,
    ["DroppedLoot.announceLootToChat"] = false,
    ["ShortcutKeys.showLegend"] = false,
    ["ExportingLoot.showLootAssignmentReminder"] = false,
    ["AwardingLoot.autoAssignAfterAwardingAnItem"] = true,
    ["AwardingLoot.autoTradeAfterAwardingAnItem"] = false,
    ["AwardingLoot.awardMessagesEnabled"] = false,
};

local PACKMULE_TIMER_PREFIXES = { "PackMule.Handout.", "PackMule.LootError.", "PackMuleResetProcessingFlag", };

--- The longest literal piece of a localized format string, e.g. "%s's bags are full (%s)" -> "'s bags are full ("
---
---@param format string
---@return string
function Base.fragment(format)
    local longest = "";
    for piece in (tostring(format) .. "%s"):gmatch("(.-)%%s") do
        if (strlen(piece) > strlen(longest)) then
            longest = piece;
        end
    end

    return longest;
end

---@param Definition table
---@return PackMuleE2EBase
function Base:extend(Definition)
    Definition.isRunning = false;
    Definition.runnerStep = 0;
    Definition.retryCount = 0;
    Definition.cleanupComplete = true;
    return setmetatable(Definition, { __index = Base, });
end

---@return table
function Base:buildSteps()
    local Steps = { { title = "Setup", fn = "stepSetup", }, };
    for _, Case in ipairs(self.CASES or {}) do
        table.insert(Steps, { title = Case.title, fn = "stepCase", Case = Case, });
    end
    table.insert(Steps, { title = "Cleanup", fn = "stepCleanup", });

    return Steps;
end

---@return table
function Base:getStepTitles()
    local Titles = {};
    for _, Step in ipairs(self:buildSteps()) do
        table.insert(Titles, Step.title);
    end

    return Titles;
end

---@param skipRunnerOpen? boolean
---@return nil
function Base:start(skipRunnerOpen)
    if (self.isRunning) then
        self:log(("Test already running. Use /run Gargul.Tests.E2E.%s:stop() to stop it first."):format(self.scenarioName));
        return;
    end

    self.retryCount = 0;
    self.setupDone = false;
    self.CaseState = nil;
    self.steps = self:buildSteps();

    if (skipRunnerOpen) then
        self.isRunning = true;
        self.runnerStep = 0;
        GL.Interface.Tests.Runner:setActiveScenario(self.scenarioName);
        self:log(("========== Starting %s =========="):format(self.label or self.scenarioName));
        self:runStep(1);
        return;
    end

    self:startWith("E2E Tests", { { name = self.label or self.scenarioName, steps = self:getStepTitles(), key = self.scenarioName, }, });
    self:runStep(1);
end

---@return nil
function Base:stop()
    self:resetRunnerState();

    if (self.CaseState and type(self.onCaseFinish) == "function") then
        pcall(self.onCaseFinish, self, self.CaseState.Case, self.CaseState);
    end
    self.CaseState = nil;
    self:cleanup();
    self:log("Stopped and cleaned up");
end

--[[ PLAYERS ]]

---@param spec string|table
---@param index number
---@return table
function Base:buildPlayer(spec, index)
    local Spec = type(spec) == "table" and spec or { name = spec, };
    local realm = GL.User.realm or "";
    local fqn = Spec.fqn or GL:addRealm(Spec.name, realm, false);

    return {
        name = GL:stripRealm(fqn),
        realm = realm,
        fqn = fqn,
        rank = Spec.rank or 0,
        subgroup = 1,
        level = GL.User.level or 80,
        class = strlower(GL.User.classFile or "WARRIOR"),
        classFile = GL.User.classFile or "WARRIOR",
        zone = "PackMule E2E",
        online = Spec.online ~= false,
        isDead = false,
        role = "",
        isML = false,
        isLeader = false,
        hasAssist = Spec.hasAssist == true,
        index = index,
        candidateName = Spec.candidateName,
    };
end

---@param Specs? table
---@return table
function Base:buildPlayers(Specs)
    local Players = {
        {
            name = GL.User.name,
            realm = GL.User.realm or "",
            fqn = GL.User.fqn,
            rank = 2,
            subgroup = 1,
            level = GL.User.level or 80,
            class = strlower(GL.User.classFile or "WARRIOR"),
            classFile = GL.User.classFile or "WARRIOR",
            zone = "PackMule E2E",
            online = true,
            isDead = false,
            role = "",
            isML = true,
            isLeader = true,
            hasAssist = true,
            index = 1,
        },
    };

    for _, spec in ipairs(Specs or self.PLAYERS or DEFAULT_PLAYER_SPECS) do
        table.insert(Players, self:buildPlayer(spec, #Players + 1));
    end

    return Players;
end

--- Resolve a case's player reference ("SELF", "PackMuleTarget", "Cline Gloomhaunt") to the fake player's FQN
---
---@param name string
---@return string
function Base:playerFQN(name)
    if (name == "SELF") then
        return GL.User.fqn;
    end

    local Player = Loot:playerByName(name);
    if (Player) then
        return Player.fqn;
    end

    return GL:addRealm(name, GL.User.realm or "", false);
end

---@param actual? string
---@param Targets string|table
---@return boolean
function Base:playerMatches(actual, Targets)
    if (type(actual) ~= "string" or actual == "") then
        return false;
    end

    Targets = type(Targets) == "table" and Targets or { Targets, };
    local realm = GL.User.realm or "";
    actual = GL:addRealm(actual, realm, false);

    for _, name in ipairs(Targets) do
        if (GL:playerNamesMatch(actual, GL:addRealm(self:playerFQN(name), realm, false))) then
            return true;
        end
    end

    return false;
end

---@param Targets string|table
---@return string
local function describeTargets(Targets)
    if (type(Targets) == "table") then
        return table.concat(Targets, " or ");
    end

    return tostring(Targets);
end

--[[ STATE ]]

---@return table
function Base:settingKeys()
    local Keys = {};
    local function add(Settings)
        for key in pairs(Settings or {}) do
            Keys[key] = true;
        end
    end

    add(BASE_SETTINGS);
    add(self.SETTINGS);
    for _, Case in ipairs(self.CASES or {}) do
        add(Case.settings);
    end

    return Keys;
end

---@return nil
function Base:saveState()
    local PackMule = GL.PackMule;

    -- Assigned only once complete so a failed save is never restored over the user's settings
    local SavedSettings = {};
    for key in pairs(self:settingKeys()) do
        local value = GL.Settings:get(key);
        SavedSettings[key] = type(value) == "table" and GL:cloneTable(value) or value;
    end
    self.SavedRules = GL:cloneTable(GL.Settings:get("PackMule.Rules", {}));
    self.SavedSettings = SavedSettings;

    self.SavedPackMuleState = {
        LootErrors = PackMule.LootErrors,
        PendingHandouts = PackMule.PendingHandouts,
        RoundRobinItems = PackMule.RoundRobinItems,
        processing = PackMule.processing,
        disenchanter = PackMule.disenchanter,
        noDisenchanterSetWarningGiving = PackMule.noDisenchanterSetWarningGiving,
        playerIsInHeroicInstance = PackMule.playerIsInHeroicInstance,
        lootWindowIsOpened = GL.DroppedLoot.lootWindowIsOpened,
    };
end

---@return nil
function Base:restoreState()
    if (self.SavedSettings) then
        for key, value in pairs(self.SavedSettings) do
            GL.Settings:set(key, value, true);
        end
        GL.Settings:set("PackMule.Rules", self.SavedRules or {}, true);
    end

    local Saved = self.SavedPackMuleState;
    if (Saved) then
        local PackMule = GL.PackMule;
        PackMule.LootErrors = Saved.LootErrors or {};
        PackMule.PendingHandouts = Saved.PendingHandouts or {};
        PackMule.RoundRobinItems = Saved.RoundRobinItems or {};
        PackMule.processing = Saved.processing;
        PackMule.disenchanter = Saved.disenchanter;
        PackMule.noDisenchanterSetWarningGiving = Saved.noDisenchanterSetWarningGiving;
        PackMule.playerIsInHeroicInstance = Saved.playerIsInHeroicInstance;
        GL.DroppedLoot.lootWindowIsOpened = Saved.lootWindowIsOpened;
    end

    GL.PackMule.Rules = GL.Settings:get("PackMule.Rules", {});
    self.SavedSettings = nil;
    self.SavedRules = nil;
    self.SavedPackMuleState = nil;
end

---@return nil
function Base:cancelPackMuleTimers()
    local timerIDs = {};
    for timerID in pairs(GL.Timers or {}) do
        for _, prefix in ipairs(PACKMULE_TIMER_PREFIXES) do
            if (GL:strStartsWith(timerID, prefix)) then
                table.insert(timerIDs, timerID);
                break;
            end
        end
    end

    GL:cancelTimer(timerIDs);

    if (GL.PackMule.LootChangedTimer) then
        GL.Ace:CancelTimer(GL.PackMule.LootChangedTimer);
        GL.PackMule.LootChangedTimer = nil;
    end
end

---@return nil
function Base:resetPackMuleState()
    local PackMule = GL.PackMule;
    self:cancelPackMuleTimers();
    PackMule.LootErrors = {};
    PackMule.PendingHandouts = {};
    PackMule.RoundRobinItems = {};
    PackMule.processing = false;
    PackMule.disenchanter = nil;
    PackMule.noDisenchanterSetWarningGiving = false;
    PackMule.playerIsInHeroicInstance = false;
end

---@param CaseSettings? table
---@return nil
function Base:applySettings(CaseSettings)
    for _, Settings in ipairs({ BASE_SETTINGS, self.SETTINGS or {}, CaseSettings or {}, }) do
        for key, value in pairs(Settings) do
            GL.Settings:set(key, value, true);
        end
    end
end

---@param Rules table
---@return nil
function Base:setRules(Rules)
    GL.PackMule.Rules = GL:cloneTable(Rules or {});
    GL.Settings:set("PackMule.Rules", GL.PackMule.Rules, true);
end

---@return nil
function Base:cleanup()
    if (self.cleanupComplete) then
        return;
    end

    self:resetPackMuleState();

    if (type(self.onTeardown) == "function") then
        pcall(self.onTeardown, self);
    end

    Loot:uninstall();
    self:resetPackMuleState();
    self:restoreState();
    self.cleanupComplete = true;
end

--[[ STEPS ]]

---@return table
function Base:collectCacheIDs()
    local Seen, IDs = {}, {};
    local function add(itemID)
        itemID = math.floor(tonumber(itemID) or 0);
        if (itemID > 0 and not Seen[itemID]) then
            Seen[itemID] = true;
            table.insert(IDs, itemID);
        end
    end

    for _, Case in ipairs(self.CASES or {}) do
        for _, Item in ipairs(Case.items or {}) do
            if (not Item.money and not Item.name and not Item.link and not Item.allowSynthetic) then
                add(Item.id or Item.itemID);
            end
        end

        for _, itemID in ipairs(Case.cacheItems or {}) do
            add(itemID);
        end
    end

    return IDs;
end

---@return nil
function Base:stepSetup()
    if (not self.isRunning) then return; end

    if (not self.setupDone) then
        self:log("Installing loot harness...");
        self.cleanupComplete = false;
        Loot:install();
        self:saveState();
        self:resetPackMuleState();
        self:applySettings();
        self:setRules({});
        Loot:setGroup(self:buildPlayers(), self.USER);

        if (type(self.onSetup) == "function") then
            local failure = self:onSetup();
            if (failure) then
                self:fail(failure);
                return;
            end
        end

        self.setupDone = true;
        self.retryCount = 0;
        self.cacheIDs = self:collectCacheIDs();

        if (#self.cacheIDs > 0) then
            GL:onItemLoadDo(self.cacheIDs, function () end);
        end
    end

    local Missing = {};
    for _, itemID in ipairs(self.cacheIDs or {}) do
        if (not Loot:itemHasRealData(itemID)) then
            table.insert(Missing, itemID);
        end
    end

    if (#Missing == 0) then
        self.retryCount = 0;
        self:success("Harness installed");
        self:next(.2);
        return;
    end

    self.retryCount = self.retryCount + 1;
    if (self.retryCount >= CACHE_RETRIES) then
        self:fail(("Items never loaded: %s"):format(table.concat(Missing, ", ")));
        return;
    end

    self:retry(.25);
end

---@return nil
function Base:stepCleanup()
    if (not self.isRunning) then return; end

    self:cleanup();
    self:success("PackMule state restored");
    self:log(("========== %s Complete =========="):format(self.label or self.scenarioName));
    self:next();
end

---@return nil
function Base:stepCase()
    if (not self.isRunning) then return; end

    local ok, err = pcall(self.runCase, self);
    if (not ok) then
        self:fail(("Lua error: %s"):format(tostring(err)));
    end
end

---@param message string
---@return nil
function Base:fail(message)
    local State = self.CaseState;
    local Case = State and State.Case;

    Gargul:xd({
        event = ("Tests.E2E.%s:failure"):format(self.scenarioName),
        case = Case and Case.title,
        message = message,
        lootLog = Loot.log,
        messages = Loot.messages,
        lootErrors = GL.PackMule.LootErrors,
        pendingHandouts = GL.PackMule.PendingHandouts,
        groupLootLog = GroupLoot and GroupLoot.installed and GroupLoot.log or nil,
    });

    if (State and type(self.onCaseFinish) == "function") then
        pcall(self.onCaseFinish, self, Case, State);
    end

    self.CaseState = nil;
    self:error(Case and ("%s: %s"):format(Case.title, message) or message);
end

---@param Case table
---@param State table
---@return nil
function Base:prepareCase(Case, State)
    self:resetPackMuleState();
    Loot:resetCase();

    if (GroupLoot and GroupLoot.installed) then
        GroupLoot:resetCase();
    end

    local UserFlags = {};
    for key, value in pairs(self.USER or {}) do
        UserFlags[key] = value;
    end
    for key, value in pairs(Case.user or {}) do
        UserFlags[key] = value;
    end

    Loot:setGroup(self:buildPlayers(Case.players), UserFlags);
    self:applySettings(Case.settings);
    self:setRules(Case.rules or {});

    if (type(self.onCaseReset) == "function") then
        self:onCaseReset(Case, State);
    end

    if (type(Case.arrange) == "function") then
        Case.arrange(self, Loot, State);
    end
end

---@param Case table
---@param State table
---@return string|nil failure
function Base:openCase(Case, State)
    if (type(Case.start) == "function") then
        return Case.start(self, Loot, State);
    end

    if (Case.items) then
        local Skipped = Loot:open(Case.items);
        if (not GL:empty(Skipped)) then
            return ("Items not cached: %s"):format(table.concat(Skipped, ", "));
        end
    end

    if (type(Case.afterOpen) == "function") then
        return Case.afterOpen(self, Loot, State);
    end
end

---@param itemID number
---@param Targets string|table
---@return boolean
function Base:itemHandedTo(itemID, Targets)
    if (Loot:itemIsInWindow(itemID)) then
        return false;
    end

    for _, Entry in ipairs(Loot.log) do
        if (Entry.action == "GiveMasterLoot"
            and Entry.itemID == itemID
            and Entry.result == "success"
            and self:playerMatches(Entry.player, Targets)
        ) then
            return true;
        end
    end

    return false;
end

---@param Expected table { player, reason, items? }
---@return table|nil
function Base:lootErrorFor(Expected)
    for _, Entry in pairs(GL.PackMule.LootErrors or {}) do
        if (Entry.reasonCategory == Expected.reason
            and self:playerMatches(Entry.playerName, Expected.player)
        ) then
            return Entry;
        end
    end
end

---@param Entry table
---@return number
local function lootErrorItemCount(Entry)
    return #(Entry.ItemLinks or {}) + GL:count(Entry.Reported or {});
end

---@param Case table
---@param State table
---@return boolean, string|nil
function Base:positivesMet(Case, State)
    local Expect = Case.expect or {};

    for itemID, Targets in pairs(Expect.handouts or {}) do
        if (not self:itemHandedTo(itemID, Targets)) then
            return false, ("item %d handed to %s"):format(itemID, describeTargets(Targets));
        end
    end

    for _, itemID in ipairs(Expect.removed or {}) do
        if (Loot:itemIsInWindow(itemID)) then
            return false, ("item %d removed from the loot window"):format(itemID);
        end
    end

    for _, Expected in ipairs(Expect.errors or {}) do
        local Entry = self:lootErrorFor(Expected);
        if (not Entry) then
            return false, ("%s loot error for %s"):format(Expected.reason, Expected.player);
        end

        if (Expected.items and lootErrorItemCount(Entry) < Expected.items) then
            return false, ("%d items in the %s loot error"):format(Expected.items, Expected.reason);
        end
    end

    for _, Message in ipairs(Expect.messages or {}) do
        if (Loot:countMessages(Message.text, Message.level) < (Message.count or 1)) then
            return false, ("message '%s'"):format(Message.text or "?");
        end
    end

    for itemID, roll in pairs(Expect.rolls or {}) do
        if (GroupLoot:rollFor(itemID) ~= roll) then
            return false, ("roll %d on item %d"):format(roll, itemID);
        end
    end

    if (type(Case.ready) == "function") then
        local ready, waitingFor = Case.ready(self, Loot, State);
        if (not ready) then
            return false, waitingFor or "custom ready condition";
        end
    end

    return true;
end

---@param Message table
---@param Expect table
---@return boolean
local function messageIsExpected(Message, Expect)
    for _, Expected in ipairs(Expect.messages or {}) do
        if ((not Expected.level or Expected.level == Message.level)
            and (not Expected.text or strfind(Message.text, Expected.text, 1, true))
        ) then
            return true;
        end
    end

    return false;
end

---@param Case table
---@return string|nil failure
function Base:checkNegatives(Case)
    local Expect = Case.expect or {};

    if (not Case.allowExtraHandouts) then
        for _, Entry in ipairs(Loot.log) do
            if (Entry.action == "GiveMasterLoot" and Entry.result == "success") then
                local Targets = Expect.handouts and Expect.handouts[Entry.itemID];
                if (not Targets) then
                    return ("unexpected handout of %s to %s"):format(Entry.itemLink or tostring(Entry.itemID), Entry.player or "?");
                end

                if (not self:playerMatches(Entry.player, Targets)) then
                    return ("%s went to %s, expected %s"):format(Entry.itemLink or tostring(Entry.itemID), Entry.player or "?", describeTargets(Targets));
                end
            end
        end
    end

    for _, itemID in ipairs(Expect.untouched or {}) do
        local attempts = Loot:handoutAttempts(itemID);
        if (attempts > 0) then
            return ("item %d should not have been handed out (%d attempts)"):format(itemID, attempts);
        end

        if (not Loot:itemIsInWindow(itemID)) then
            return ("item %d should still be in the loot window"):format(itemID);
        end
    end

    for _, itemID in ipairs(Expect.remaining or {}) do
        if (not Loot:itemIsInWindow(itemID)) then
            return ("item %d should still be in the loot window"):format(itemID);
        end
    end

    for _, Entry in pairs(GL.PackMule.LootErrors or {}) do
        local expected = false;
        for _, Expected in ipairs(Expect.errors or {}) do
            if (Entry.reasonCategory == Expected.reason and self:playerMatches(Entry.playerName, Expected.player)) then
                expected = true;

                if (Expected.items and lootErrorItemCount(Entry) ~= Expected.items) then
                    return ("%s loot error has %d items, expected %d"):format(Entry.reasonCategory, lootErrorItemCount(Entry), Expected.items);
                end
            end
        end

        if (not expected) then
            return ("unexpected %s loot error for %s"):format(tostring(Entry.reasonCategory), tostring(Entry.playerName));
        end
    end

    for _, Expected in ipairs(Expect.messages or {}) do
        local count = Loot:countMessages(Expected.text, Expected.level);
        if (count ~= (Expected.count or 1)) then
            return ("message '%s' shown %d times, expected %d"):format(Expected.text or "?", count, Expected.count or 1);
        end
    end

    if (not Case.allowMessages) then
        for _, Message in ipairs(Loot.messages) do
            if ((Message.level == "error" or Message.level == "warning")
                and not messageIsExpected(Message, Expect)
            ) then
                return ("unexpected %s: %s"):format(Message.level, Message.text);
            end
        end
    end

    if (GroupLoot and GroupLoot.installed) then
        for _, Entry in ipairs(GroupLoot.log) do
            if (Entry.action == "RollOnLoot") then
                local expectedRoll = Expect.rolls and Expect.rolls[Entry.itemID];
                if (expectedRoll ~= Entry.roll) then
                    return ("unexpected roll %s on item %s"):format(tostring(Entry.roll), tostring(Entry.itemID));
                end
            end
        end
    end
end

---@param Case table
---@param State table
---@return nil
function Base:finishCase(Case, State)
    if (not Case.leaveOpen) then
        Loot:close();
    end

    if (type(self.onCaseFinish) == "function") then
        self:onCaseFinish(Case, State);
    end

    local successes = Loot:countHandoutsByResult("success");
    local attempts = Loot:countActions("GiveMasterLoot");
    self:log(("Handouts: %d successful of %d attempts, %d messages"):format(successes, attempts, #Loot.messages));
    for _, Message in ipairs(Loot.messages) do
        self:log(("[%s] %s"):format(Message.level, Message.text));
    end

    self.CaseState = nil;
end

---@return nil
function Base:runCase()
    local Step = self.steps[self.runnerStep];
    local Case = Step and Step.Case;
    if (not Case) then
        self:fail("No case found for this step");
        return;
    end

    local State = self.CaseState;

    if (not State or State.Case ~= Case) then
        if (type(Case.requires) == "function" and not Case.requires(self)) then
            self:success(("Skipped: %s"):format(Case.skipReason or "not applicable on this client"));
            self:next(0);
            return;
        end

        State = { Case = Case, startedAt = GetTime(), };
        self.CaseState = State;
        self:log(("Case: %s"):format(Case.title));
        self:prepareCase(Case, State);

        local failure = self:openCase(Case, State);
        if (failure) then
            self:fail(failure);
            return;
        end

        self:retry(Case.pollInterval or POLL_INTERVAL);
        return;
    end

    local elapsed = GetTime() - State.startedAt;

    if (type(Case.poll) == "function") then
        local failure = Case.poll(self, Loot, elapsed, State);
        if (failure) then
            self:fail(failure);
            return;
        end
    end

    local Expect = Case.expect or {};
    local settle = Case.settle or ((Expect.errors or Expect.messages) and DEFAULT_ERROR_SETTLE or DEFAULT_SETTLE);
    local timeout = Case.timeout or (settle + DEFAULT_TIMEOUT);
    local met, waitingFor = self:positivesMet(Case, State);

    if (met and elapsed >= settle) then
        local failure = self:checkNegatives(Case);
        if (not failure and type(Case.check) == "function") then
            failure = Case.check(self, Loot, State);
        end

        if (failure) then
            self:fail(failure);
            return;
        end

        self:finishCase(Case, State);
        self:success(Case.title);
        self:next(.3);
        return;
    end

    if (elapsed >= timeout) then
        self:fail(("Timed out waiting for %s"):format(waitingFor or "the settle period"));
        return;
    end

    self:retry(Case.pollInterval or POLL_INTERVAL);
end

return Base;
