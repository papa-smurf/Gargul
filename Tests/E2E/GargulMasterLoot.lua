---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field, need-check-nil

local L = Gargul_L;

assert(GL.Tests.E2E and GL.Tests.E2E.PackMuleBase, "GL.Tests.E2E.PackMuleBase missing (TOC: Tests/E2E/PackMuleBase.lua before this file)");
assert(GL.Tests.Fakes and GL.Tests.Fakes.GroupLoot, "GL.Tests.Fakes.GroupLoot missing (TOC: Tests/Fakes/GroupLoot.lua before this file)");

local PackMuleBase = GL.Tests.E2E.PackMuleBase;
local GroupLoot = GL.Tests.Fakes.GroupLoot;
local Env = GL.Tests.Fakes.Env;
local Loot = GL.Tests.Fakes.Loot;

local CommActions = GL.Data.Constants.Comm.Actions;
local Config = GL.Data.Constants.GargulMasterLoot;
local Actions = GL.Data.Constants.GroupLootActions;

local BIND_NONE = GL.LE_ITEM_BIND_NONE;
local BIND_PICKUP = GL.LE_ITEM_BIND_ON_ACQUIRE;

local MASTER_LOOTER = "PackMuleTarget";
local MEMBER = "PackMuleBackup";
local OTHER_MEMBER = "GmlBystander";
local SESSION_ID = "gml-e2e";

-- Someone else's session needs a master looter with assist
local MASTER_LOOTER_PLAYER = { name = MASTER_LOOTER, hasAssist = true, };

local Sent = {}; -- What the client would have sent to the master looter
local Outgoing = {}; -- Every other comm message that would have left the test
local Responses = {}; -- What we responded to incoming messages
local Violations = {}; -- What the master looter would have been warned about
local Finished = {}; -- Reasons the session ended with
local OptInPrompts = {}; -- Opt-in dialogs that would have been shown
local optInAnswer = true; -- How the fake opt-in dialog answers
local Saved = {};

---@param itemID number
---@param quality number
---@param Extra? table
---@return table
local function item(itemID, quality, Extra)
    local Item = { id = itemID, quality = quality, bindType = BIND_NONE, };
    for key, value in pairs(Extra or {}) do
        Item[key] = value;
    end

    return Item;
end

--[[ ARRANGE HELPERS ]]

--- The current user is a regular group member in someone else's session
---@param E2E table
---@return nil
local function asClient(E2E)
    GL.GargulMasterLoot.Mode.Session = {
        active = true,
        confirmed = true,
        sessionID = SESSION_ID,
        masterLooter = MASTER_LOOTER,
        masterLooterFqn = E2E:playerFQN(MASTER_LOOTER),
    };

    GL.GargulMasterLoot.Client:start();
end

--- The current user is the master looter
---@param E2E table
---@param Names? table Players that are in the session
---@param status? string Opt-in status of those players (default accepted)
---@return nil
local function asMasterLooter(E2E, Names, status)
    local Mode = GL.GargulMasterLoot.Mode;

    Mode.Session = {
        active = true,
        confirmed = true,
        sessionID = SESSION_ID,
        masterLooter = GL.User.name,
        masterLooterFqn = GL.User.fqn,
    };

    Mode.Members = {};
    for _, name in ipairs(Names or { MEMBER, }) do
        Mode.Members[Mode.identity(name)] = {
            name = name,
            fqn = E2E:playerFQN(name),
            unit = name,
            status = status or "accepted",
            online = true,
            lastSeen = GetTime(),
            graceUntil = 0,
        };
    end

    GL.User.isPseudoMasterLooter = true;
    GL.GargulMasterLoot.Monitor:start();
end

--- A message as the comm layer hands it to a handler
---@param E2E table
---@param name string
---@param content table
---@return table
local function message(E2E, name, content)
    content.sessionID = content.sessionID or SESSION_ID;

    return {
        Sender = { isSelf = false, name = name, },
        senderFqn = E2E:playerFQN(name),
        version = GL.version,
        content = content,
        respond = function (_, Response)
            table.insert(Responses, Response);
        end,
    };
end

--- The last outgoing message with the given action
---@param action number
---@return table|nil
local function outgoing(action)
    for index = #Outgoing, 1, -1 do
        if (Outgoing[index].action == action) then
            return Outgoing[index];
        end
    end

    return nil;
end

---@param state string
---@return boolean
local function respondedWith(state)
    for _, Response in ipairs(Responses) do
        if (type(Response) == "table" and Response.state == state) then
            return true;
        end
    end

    return false;
end

--- Start a roll the way the client does and return its link
---@param Item table
---@param rollTime? number
---@return string link
local function startRoll(Item, rollTime)
    local Registered = Loot:registerItem(Item);
    local rollID = GroupLoot.nextRollID;

    GroupLoot.nextRollID = GroupLoot.nextRollID + 1;
    GroupLoot.Rolls[rollID] = Registered;
    GL.Events:fire("START_LOOT_ROLL", rollID, rollTime or 60000);

    return Registered.link;
end

--- Announce a roll message in chat (patterns that don't exist on this client are skipped).
--- Only pass the texts (name, link) in the order the pattern uses them: numbers like the
--- loot history ID or the roll some clients have are filled in automatically.
---@param pattern string|nil
---@vararg string
---@return nil
local function chat(pattern, ...)
    if (type(pattern) ~= "string") then
        return;
    end

    local Texts = { ... };
    local Arguments = {};
    local textIndex = 0;

    for conversion in pattern:gsub("%%%%", ""):gmatch("%%[%d%$%.%-]*([sdfg])") do
        if (conversion == "s") then
            textIndex = textIndex + 1;
            table.insert(Arguments, Texts[textIndex]);
        else
            table.insert(Arguments, 54);
        end
    end

    if (textIndex ~= #Texts) then
        error(("chat pattern %q takes %d texts, got %d"):format(pattern, textIndex, #Texts));
    end

    GL.Events:fire("CHAT_MSG_LOOT", pattern:format(unpack(Arguments)));
end

--[[ CHECK HELPERS ]]

---@param expected number
---@param kind? string The kind of the first violation
---@return function
local function expectViolations(expected, kind)
    return function ()
        if (#Violations ~= expected) then
            return ("expected %d violations, got %d (%s)"):format(expected, #Violations, Violations[1] and Violations[1].reason or "none");
        end

        if (kind and Violations[1].kind ~= kind) then
            return ("expected a '%s' violation, got '%s'"):format(kind, tostring(Violations[1].kind));
        end
    end;
end

---@param action number
---@return number
local function sentCount(action)
    local count = 0;
    for _, Entry in ipairs(Sent) do
        if (Entry.action == action) then
            count = count + 1;
        end
    end

    return count;
end

---@param event string
---@return table|nil
local function sentStateChange(event)
    for _, Entry in ipairs(Sent) do
        if (Entry.action == CommActions.gmlStateChange and Entry.content.event == event) then
            return Entry.content;
        end
    end

    return nil;
end

--[[ CLIENT CASES ]]

---@param title string
---@param Item table
---@param passes boolean
---@param Extra? table
---@return table
local function clientCase(title, Item, passes, Extra)
    local Case = {
        title = title,
        players = { MASTER_LOOTER_PLAYER, MEMBER, },
    };
    Case.cacheItems = { Item.id, };
    Case.settle = .6;
    Case.arrange = asClient;
    Case.start = function ()
        startRoll(Item);
    end;
    Case.expect = { rolls = passes and { [Item.id] = Actions.PASS, } or nil, };
    Case.check = function ()
        local reports = sentCount(CommActions.gmlPassReport);
        if (passes and reports ~= 1) then
            return ("expected 1 pass report, got %d"):format(reports);
        elseif (not passes and reports ~= 0) then
            return "a pass report was sent for an item that isn't covered";
        end
    end;

    for key, value in pairs(Extra or {}) do
        Case[key] = value;
    end

    return Case;
end

local CASES = {
    --[[ CLIENT: AUTO PASS ]]
    clientCase("Passes on an eligible item and reports it", item(25, 2), true),
    clientCase(
        GL.isRetail and "Skips BoP items in a raid on Retail" or "Passes on BoP items in a raid",
        item(25, 2, { bindType = BIND_PICKUP, }),
        not GL.isRetail
    ),
    clientCase("Skips items below the loot threshold", item(25, 1), false),
    clientCase("Skips recipes", item(25, 2, { classID = GL.LE_ITEM_CLASS_RECIPE, }), false),
    clientCase("Skips quest items", item(25, 2, { classID = GL.LE_ITEM_CLASS_QUESTITEM, }), false),
    clientCase("Skips companion pets", item(25, 2, {
        classID = GL.LE_ITEM_CLASS_MISCELLANEOUS,
        subclassID = GL.LE_ITEM_MISCELLANEOUS_SUBCLASS_COMPANION_PET,
    }), false),
    clientCase("Skips BoP items outside of a raid", item(25, 2, { bindType = BIND_PICKUP, }), false, {
        user = { isInRaid = false, isInParty = true, },
    }),
    clientCase("The master looter never passes", item(25, 2), false, {
        arrange = function (E2E)
            asClient(E2E);
            GL.GargulMasterLoot.Mode.Session.masterLooter = GL.User.name;
        end,
    }),
    clientCase("Nothing happens without a session", item(25, 2), false, {
        arrange = function () end,
    }),
    clientCase("PackMule yields while a session is active", item(25, 2), true, {
        settings = { ["PackMule.enabledForGroupLoot"] = true, },
        rules = { { operator = ">=", quality = 0, target = L["NEED"], }, },
    }),
    clientCase("Doesn't pass when the master looter is out of range", item(25, 2), false, {
        arrange = function (E2E)
            asClient(E2E);
            Env:set("UnitIsVisible", function () return false; end);
        end,
        allowMessages = true,
        check = function ()
            if (sentCount(CommActions.gmlPassReport) ~= 0) then
                return "a pass report was sent while the master looter was out of range";
            end

            if (not sentStateChange("skipped")) then
                return "the master looter wasn't told why we didn't pass";
            end
        end,
    }),
    clientCase("Doesn't pass when the master looter is offline", item(25, 2), false, {
        players = { { name = MASTER_LOOTER, hasAssist = true, online = false, }, MEMBER, },
        allowMessages = true,
        check = function ()
            if (sentCount(CommActions.gmlPassReport) ~= 0) then
                return "a pass report was sent while the master looter was offline";
            end

            if (not sentStateChange("skipped")) then
                return "the master looter wasn't told why we didn't pass";
            end
        end,
    }),

    --[[ MASTER LOOTER: OBSERVED ROLLS ]]
    {
        title = "A member rolling Need is a violation",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = .8,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2));
            chat(_G.LOOT_ROLL_NEED, MEMBER, link);
        end,
        allowMessages = true,
        check = expectViolations(1, "roll"),
    },
    {
        title = "A member rolling Greed is a violation",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = .8,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2));
            chat(_G.LOOT_ROLL_GREED, MEMBER, link);
        end,
        allowMessages = true,
        check = expectViolations(1, "roll"),
    },
    {
        title = "A member passing is fine",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = .8,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2));
            chat(_G.LOOT_ROLL_PASSED, MEMBER, link);
        end,
        check = expectViolations(0),
    },
    {
        title = "Rolling on an item that isn't covered is fine",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = .8,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2, { classID = GL.LE_ITEM_CLASS_RECIPE, }));
            chat(_G.LOOT_ROLL_NEED, MEMBER, link);
        end,
        check = expectViolations(0),
    },
    {
        title = "The master looter's own roll messages are ignored",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = .8,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2));
            chat(_G.LOOT_ROLL_NEED, GL.User.name, link);
        end,
        check = expectViolations(0),
    },
    {
        title = "Rolling without having opted in is flagged as such",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = .8,
        arrange = function (E2E) asMasterLooter(E2E, { MEMBER, }, "declined"); end,
        start = function ()
            local link = startRoll(item(25, 2));
            chat(_G.LOOT_ROLL_NEED, MEMBER, link);
        end,
        allowMessages = true,
        check = function ()
            local failure = expectViolations(1, "roll")();
            if (failure) then
                return failure;
            end

            if (not strfind(Violations[1].reason, L["had not opted in"], 1, true)) then
                return "the violation doesn't mention that the player had not opted in";
            end
        end,
    },
    {
        title = "A Need selection and its roll result warn once",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = .8,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2));
            chat(_G.LOOT_ROLL_NEED, MEMBER, link);
            chat(_G.LOOT_ROLL_ROLLED_NEED, link, MEMBER);
        end,
        allowMessages = true,
        check = expectViolations(1, "roll"),
    },
    {
        title = "Rolls the master looter never got are ignored",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = .8,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local Registered = Loot:registerItem(item(25, 2));
            chat(_G.LOOT_ROLL_NEED, MEMBER, Registered.link);
        end,
        check = expectViolations(0),
    },

    --[[ MASTER LOOTER: MISSING PASSES ]]
    {
        title = "A member that never passes is flagged once the roll is over",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = 2.4,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            startRoll(item(25, 2), 1000);
        end,
        allowMessages = true,
        check = function ()
            local failure = expectViolations(1, "missing")();
            if (failure) then
                return failure;
            end

            if (Violations[1].reason ~= L["no pass seen"]) then
                return ("unexpected reason: %s"):format(tostring(Violations[1].reason));
            end
        end,
    },
    {
        title = "An observed pass prevents the missing pass warning",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = 2.4,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2), 1000);
            chat(_G.LOOT_ROLL_PASSED, MEMBER, link);
        end,
        check = expectViolations(0),
    },
    {
        title = "Passing on every copy of an identical item raises nothing",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = 2.4,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2), 1000);
            startRoll(item(25, 2), 1000);
            chat(_G.LOOT_ROLL_PASSED, MEMBER, link);
            chat(_G.LOOT_ROLL_PASSED, MEMBER, link);
        end,
        check = expectViolations(0),
    },
    {
        title = "Passing on only one copy of an identical item is flagged once",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = 2.4,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2), 1000);
            startRoll(item(25, 2), 1000);
            chat(_G.LOOT_ROLL_PASSED, MEMBER, link);
        end,
        allowMessages = true,
        check = expectViolations(1, "missing"),
    },
    {
        title = "A reported but unobserved pass has its own reason",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = 2.4,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function (E2E)
            local link = startRoll(item(25, 2), 1000);
            GL.GargulMasterLoot.Monitor:onPassReport(message(E2E, MEMBER, { itemLink = link, rollID = 1, }));
        end,
        allowMessages = true,
        check = function ()
            local failure = expectViolations(1, "missing")();
            if (failure) then
                return failure;
            end

            if (Violations[1].reason ~= L["reported a pass, but none was seen"]) then
                return ("unexpected reason: %s"):format(tostring(Violations[1].reason));
            end
        end,
    },
    {
        title = "Everyone passing after an announced winner raises nothing",
        players = { MEMBER, },
        cacheItems = { 25, },
        settle = 2.4,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local link = startRoll(item(25, 2), 1000);
            chat(_G.LOOT_ROLL_PASSED, MEMBER, link);
            chat(_G.LOOT_ROLL_YOU_WON, link);
        end,
        check = expectViolations(0),
    },

    --[[ MASTER LOOTER: HEARTBEATS AND STATE ]]
    {
        title = "A member that went silent is flagged",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local Mode = GL.GargulMasterLoot.Mode;
            Mode.Members[Mode.identity(MEMBER)].lastSeen = GetTime() - Config.heartbeatTimeout - 5;
            GL.GargulMasterLoot.Monitor:tick();
        end,
        allowMessages = true,
        check = expectViolations(1, "silent"),
    },
    {
        title = "A member that went silent is flagged only once",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local Mode = GL.GargulMasterLoot.Mode;
            Mode.Members[Mode.identity(MEMBER)].lastSeen = GetTime() - Config.heartbeatTimeout - 5;
            GL.GargulMasterLoot.Monitor:tick();
            GL.GargulMasterLoot.Monitor:tick();
        end,
        allowMessages = true,
        check = expectViolations(1, "silent"),
    },
    {
        title = "Silence during the grace period is tolerated",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local Mode = GL.GargulMasterLoot.Mode;
            local Entry = Mode.Members[Mode.identity(MEMBER)];
            Entry.lastSeen = GetTime() - Config.heartbeatTimeout - 5;
            Entry.graceUntil = GetTime() + 10;
            GL.GargulMasterLoot.Monitor:tick();
        end,
        check = expectViolations(0),
    },
    {
        title = "Offline members are not flagged for silence",
        players = { { name = MEMBER, online = false, }, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function ()
            local Mode = GL.GargulMasterLoot.Mode;
            Mode.Members[Mode.identity(MEMBER)].lastSeen = GetTime() - Config.heartbeatTimeout - 5;
            GL.GargulMasterLoot.Monitor:tick();
        end,
        check = expectViolations(0),
    },
    {
        title = "A heartbeat resets the silence clock",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function (E2E)
            local Mode = GL.GargulMasterLoot.Mode;
            local Entry = Mode.Members[Mode.identity(MEMBER)];
            Entry.lastSeen = GetTime() - Config.heartbeatTimeout - 5;

            GL.GargulMasterLoot.Monitor:onHeartbeat(message(E2E, MEMBER, { ok = true, }));
            GL.GargulMasterLoot.Monitor:tick();
        end,
        check = expectViolations(0),
    },
    {
        title = "A failing integrity check in a heartbeat is a violation",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function (E2E)
            GL.GargulMasterLoot.Monitor:onHeartbeat(message(E2E, MEMBER, { ok = false, reason = "RollOnLoot was replaced", }));
        end,
        allowMessages = true,
        check = expectViolations(1, "tamper"),
    },
    {
        title = "A lasting integrity failure warns only once",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function (E2E)
            local Monitor = GL.GargulMasterLoot.Monitor;
            local reason = "RollOnLoot was replaced";

            Monitor:onStateChange(message(E2E, MEMBER, { event = "tamper", reason = reason, }));
            Monitor:onHeartbeat(message(E2E, MEMBER, { ok = false, reason = reason, }));
            Monitor:onHeartbeat(message(E2E, MEMBER, { ok = false, reason = reason, }));
        end,
        allowMessages = true,
        check = expectViolations(1, "tamper"),
    },
    {
        title = "An integrity failure that returns after a fix warns again",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function (E2E)
            local Monitor = GL.GargulMasterLoot.Monitor;
            local reason = "RollOnLoot was replaced";

            Monitor:onHeartbeat(message(E2E, MEMBER, { ok = false, reason = reason, }));
            Monitor:onHeartbeat(message(E2E, MEMBER, { ok = true, }));
            Monitor:onHeartbeat(message(E2E, MEMBER, { ok = false, reason = reason, }));
        end,
        allowMessages = true,
        check = expectViolations(2, "tamper"),
    },
    {
        title = "A tamper state change is a violation",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function (E2E)
            GL.GargulMasterLoot.Monitor:onStateChange(message(E2E, MEMBER, { event = "tamper", reason = "The auto-pass listener was removed", }));
        end,
        allowMessages = true,
        check = expectViolations(1, "tamper"),
    },
    {
        title = "Coming back after a logout cancels the pending warning",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function (E2E)
            local Mode = GL.GargulMasterLoot.Mode;

            GL.GargulMasterLoot.Monitor:onStateChange(message(E2E, MEMBER, { event = "loggingOut", }));
            if (not Mode.Members[Mode.identity(MEMBER)].logoutAt) then
                return "the logout wasn't registered";
            end

            GL.GargulMasterLoot.Monitor:onStateChange(message(E2E, MEMBER, { event = "loaded", }));
            if (Mode.Members[Mode.identity(MEMBER)].logoutAt) then
                return "the pending logout wasn't cleared by the loaded message";
            end
        end,
        check = expectViolations(0),
    },
    {
        title = "Messages of another session are ignored",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E) asMasterLooter(E2E); end,
        start = function (E2E)
            GL.GargulMasterLoot.Monitor:onHeartbeat(message(E2E, MEMBER, { sessionID = "another", ok = false, }));
        end,
        check = expectViolations(0),
    },

    --[[ LIFECYCLE ]]
    {
        title = "The master looter can end the session",
        players = { MASTER_LOOTER_PLAYER, MEMBER, },
        settle = .3,
        arrange = asClient,
        start = function (E2E)
            GL.GargulMasterLoot.Mode:onEnd(message(E2E, MASTER_LOOTER, { reason = "test", }));
        end,
        allowMessages = true,
        check = function ()
            if (GL.GargulMasterLoot.Mode.Session) then
                return "the session is still active";
            end

            if (GL.GargulMasterLoot.Client.armed) then
                return "the client is still armed";
            end
        end,
    },
    {
        title = "Regular members can't end the session",
        players = { MASTER_LOOTER_PLAYER, MEMBER, },
        settle = .3,
        arrange = asClient,
        start = function (E2E)
            GL.GargulMasterLoot.Mode:onEnd(message(E2E, MEMBER, { reason = "test", }));
        end,
        check = function ()
            if (not GL.GargulMasterLoot.Mode.Session) then
                return "a regular member ended the session";
            end
        end,
    },
    {
        title = "The session ends on a loot method change",
        players = { MASTER_LOOTER_PLAYER, MEMBER, },
        settle = .3,
        arrange = asClient,
        start = function ()
            GroupLoot:setLootMethod("freeforall");
            GL.GargulMasterLoot.Mode:validate();
        end,
        allowMessages = true,
        check = function ()
            if (GL.GargulMasterLoot.Mode.Session) then
                return "the session survived a loot method change";
            end

            if (Finished[1] ~= L["The loot method changed"]) then
                return ("the session ended for the wrong reason: %s"):format(tostring(Finished[1]));
            end
        end,
    },
    {
        title = "Validating is postponed while a persisted session resumes",
        players = { MASTER_LOOTER_PLAYER, MEMBER, },
        settle = .3,
        arrange = function (E2E)
            asClient(E2E);
            GL.GargulMasterLoot.Mode.resumePending = true;
        end,
        start = function ()
            GroupLoot:setLootMethod("freeforall");
            GL.GargulMasterLoot.Mode:validate();
        end,
        check = function ()
            if (not GL.GargulMasterLoot.Mode.Session) then
                return "the session was validated before it resumed";
            end
        end,
    },

    --[[ OPT IN / ACTIVATION ]]
    {
        title = "Opting in makes the sender the master looter, whatever the message says",
        players = { MASTER_LOOTER_PLAYER, MEMBER, },
        settle = .3,
        start = function (E2E)
            GL.GargulMasterLoot.Mode:onOptInRequest(message(E2E, MASTER_LOOTER, {
                sessionID = "gml-optin",
                ml = MEMBER,
                mlFqn = E2E:playerFQN(MEMBER),
            }));
        end,
        check = function ()
            local Mode = GL.GargulMasterLoot.Mode;

            if (#OptInPrompts ~= 1) then
                return ("expected 1 opt-in prompt, got %d"):format(#OptInPrompts);
            end

            if (not Mode.Session or Mode.identity(Mode.Session.masterLooter) ~= Mode.identity(MASTER_LOOTER)) then
                return ("expected %s as master looter, got %s"):format(MASTER_LOOTER, tostring(Mode.Session and Mode.Session.masterLooter));
            end

            if (not respondedWith("prompted") or not respondedWith("accepted")) then
                return "the master looter didn't hear that we were prompted and accepted";
            end

            if (not GL.GargulMasterLoot.Client.armed) then
                return "the client isn't armed after opting in";
            end
        end,
    },
    {
        title = "Declining the opt-in leaves us out of the session",
        players = { MASTER_LOOTER_PLAYER, MEMBER, },
        settle = .3,
        arrange = function () optInAnswer = false; end,
        start = function (E2E)
            GL.GargulMasterLoot.Mode:onOptInRequest(message(E2E, MASTER_LOOTER, { sessionID = "gml-optin", }));
        end,
        check = function ()
            if (GL.GargulMasterLoot.Mode.Session) then
                return "declining still created a session";
            end

            if (not respondedWith("declined")) then
                return "the master looter didn't hear that we declined";
            end
        end,
    },
    {
        title = "Opt-in requests from players without assist are ignored",
        players = { MASTER_LOOTER_PLAYER, MEMBER, },
        settle = .3,
        start = function (E2E)
            GL.GargulMasterLoot.Mode:onOptInRequest(message(E2E, MEMBER, { sessionID = "gml-optin", }));
        end,
        check = function ()
            if (#OptInPrompts > 0 or GL.GargulMasterLoot.Mode.Session) then
                return "a player without assist could ask us to opt in";
            end
        end,
    },
    {
        title = "Only the master looter can confirm the session",
        players = { MASTER_LOOTER_PLAYER, { name = OTHER_MEMBER, hasAssist = true, }, },
        settle = .3,
        arrange = function (E2E)
            asClient(E2E);
            GL.GargulMasterLoot.Mode.Session.confirmed = false;
        end,
        start = function (E2E)
            local Mode = GL.GargulMasterLoot.Mode;

            Mode:onActivate(message(E2E, OTHER_MEMBER, {}));
            if (Mode.Session.confirmed) then
                return "another assistant confirmed the session";
            end

            Mode:onActivate(message(E2E, MASTER_LOOTER, {}));
            if (not Mode.Session.confirmed) then
                return "the master looter couldn't confirm the session";
            end
        end,
        allowMessages = true,
    },
    {
        title = "The session starts once everyone accepted",
        players = { MEMBER, },
        settle = .3,
        start = function (E2E)
            local Mode = GL.GargulMasterLoot.Mode;

            if (not Mode:start() or not Mode.Check) then
                return "the roster check didn't start";
            end

            local sessionID = Mode.Check.sessionID;
            Mode:onOptInResponse(message(E2E, MEMBER, { sessionID = sessionID, state = "accepted", }));
            Mode:checkProgress();

            if (not Mode:isActive() or Mode.Session.sessionID ~= sessionID) then
                return "the session isn't active after everyone accepted";
            end

            if (not GL.GargulMasterLoot.Monitor.running) then
                return "the monitor isn't running";
            end

            if (not outgoing(CommActions.gmlActivate)) then
                return "the group wasn't told the session is active";
            end
        end,
        allowMessages = true,
    },
    {
        title = "An outdated member blocks the start",
        players = { MEMBER, },
        settle = .3,
        start = function (E2E)
            local Mode = GL.GargulMasterLoot.Mode;

            Mode:start();
            local Response = message(E2E, MEMBER, { sessionID = Mode.Check.sessionID, state = "accepted", });
            Response.version = "1.0.0";
            Mode:onOptInResponse(Response);
            Mode:checkProgress();

            if (Mode:isActive()) then
                return "the session started with an outdated member";
            end

            local Entry = Mode.Check.Members[Mode.identity(MEMBER)];
            if (not Entry or Entry.status ~= "outdated") then
                return ("expected the member to be outdated, got %s"):format(tostring(Entry and Entry.status));
            end
        end,
        allowMessages = true,
    },

    --[[ RESUMING ]]
    {
        title = "A client drops a resumed session the master looter no longer runs",
        players = { MASTER_LOOTER_PLAYER, MEMBER, },
        settle = .3,
        arrange = function (E2E)
            asClient(E2E);
            GL.GargulMasterLoot.Mode.resumePending = true;
        end,
        start = function ()
            local Mode = GL.GargulMasterLoot.Mode;
            Mode:resume();

            local Request = outgoing(CommActions.gmlSyncRequest);
            if (not Request or type(Request.onResponse) ~= "function") then
                return "no sync request was sent";
            end

            Request.onResponse({ content = { sessionID = SESSION_ID, active = false, }, });
        end,
        allowMessages = true,
        check = function ()
            local Mode = GL.GargulMasterLoot.Mode;

            if (Mode.resumePending) then
                return "the session is still marked as resuming";
            end

            if (Mode.Session) then
                return "the client kept a session the master looter no longer runs";
            end
        end,
    },
    {
        title = "The master looter resumes with fresh clocks",
        players = { MEMBER, },
        settle = .3,
        arrange = function (E2E)
            asMasterLooter(E2E);
            local Mode = GL.GargulMasterLoot.Mode;
            Mode.resumePending = true;
            Mode.Members[Mode.identity(MEMBER)].lastSeen = -1000;
        end,
        start = function ()
            local Mode = GL.GargulMasterLoot.Mode;
            Mode:resume();
            GL.GargulMasterLoot.Monitor:tick();
        end,
        allowMessages = true,
        check = function ()
            if (not GL.GargulMasterLoot.Mode:isActive()) then
                return "the session didn't survive resuming";
            end

            return expectViolations(0)();
        end,
    },
};

---@class GargulMasterLootE2E : PackMuleE2EBase
local E2E = PackMuleBase:extend({
    scenarioName = "GargulMasterLoot",
    label = "Gargul Master Loot E2E",
    PLAYERS = { MASTER_LOOTER, MEMBER, OTHER_MEMBER, },
    SETTINGS = {
        ["PackMule.enabledForMasterLoot"] = false,
        ["PackMule.enabledForGroupLoot"] = false,
    },
    USER = {
        isMasterLooter = false,
        isInGroup = true,
        isInRaid = true,
        isInParty = false,
        hasAssist = true,
        isLead = true,
    },
    CASES = CASES,
});
GL.Tests.E2E.GargulMasterLoot = E2E; ---@type GargulMasterLootE2E

--- Nothing from a previous case should leak into the next
---@return nil
function E2E:resetSession()
    local Mode = GL.GargulMasterLoot.Mode;

    GL.GargulMasterLoot.Monitor:stop();
    GL.GargulMasterLoot.Client:stop();

    for _, Roll in pairs(GL.GargulMasterLoot.Monitor.OpenRolls or {}) do
        GL:cancelTimer(Roll.timerID);
    end

    GL:cancelTimer({
        "GML.Mode.Check",
        "GML.Mode.Resume",
        "GML.Mode.Unconfirmed",
        "GML.Mode.Validate",
        "GML.Mode.LateJoiners",
        "GML.Client.Loaded",
    });

    Mode.Session = nil;
    Mode.Members = {};
    Mode.Check = nil;
    Mode.PendingOptIns = {};
    Mode.resumePending = false;
    GL.DB.GargulMasterLoot.Session = nil;
    GL.User.isPseudoMasterLooter = false;

    Env:set("UnitIsVisible", function () return true; end);

    Sent = {};
    Outgoing = {};
    Responses = {};
    Violations = {};
    Finished = {};
    OptInPrompts = {};
    optInAnswer = true;
end

---@return string|nil
function E2E:onSetup()
    local Mode = GL.GargulMasterLoot.Mode;

    if (Mode.Session or Mode.Check) then
        return "Stop Gargul Master Loot before running this test";
    end

    GroupLoot:install();

    -- Nothing leaves the test: collect what would have been sent and shown
    Saved.send = GL.GargulMasterLoot.Client.send;
    GL.GargulMasterLoot.Client.send = function (_, action, content)
        table.insert(Sent, { action = action, content = content, });
        return true;
    end;

    Saved.newMessage = GL.CommMessage.new;
    GL.CommMessage.new = function (Spec)
        return {
            send = function ()
                table.insert(Outgoing, Spec);
            end,
        };
    end;

    Saved.report = GL.Interface.GargulMasterLoot.ViolationPopup.report;
    GL.Interface.GargulMasterLoot.ViolationPopup.report = function (_, Violation)
        table.insert(Violations, Violation);
    end;

    Saved.optIn = GL.Interface.GargulMasterLoot.OptIn.show;
    GL.Interface.GargulMasterLoot.OptIn.show = function (_, Request, callback)
        table.insert(OptInPrompts, Request);
        callback(optInAnswer);
    end;

    Saved.finish = Mode.finish;
    Mode.finish = function (Self, reason)
        table.insert(Finished, reason or "");
        return Saved.finish(Self, reason);
    end;

    -- The real refresh reads the actual group (and fires group events), keep the fake group intact
    Saved.refresh = rawget(GL.User, "refresh");
    Saved.refreshStubbed = true;
    GL.User.refresh = function () end;

    Saved.grace = Config.missingPassGraceSeconds;
    Config.missingPassGraceSeconds = .3;

    Saved.minimumVersion = Config.minimumVersion;
    Config.minimumVersion = GL.version;

    self:resetSession();
end

---@return nil
function E2E:onCaseReset()
    self:resetSession();
end

---@return nil
function E2E:onCaseFinish()
    self:resetSession();
end

---@return nil
function E2E:onTeardown()
    self:resetSession();

    if (Saved.send) then
        GL.GargulMasterLoot.Client.send = Saved.send;
    end

    if (Saved.newMessage) then
        GL.CommMessage.new = Saved.newMessage;
    end

    if (Saved.report) then
        GL.Interface.GargulMasterLoot.ViolationPopup.report = Saved.report;
    end

    if (Saved.optIn) then
        GL.Interface.GargulMasterLoot.OptIn.show = Saved.optIn;
    end

    if (Saved.finish) then
        GL.GargulMasterLoot.Mode.finish = Saved.finish;
    end

    if (Saved.refreshStubbed) then
        GL.User.refresh = Saved.refresh;
    end

    if (Saved.grace) then
        Config.missingPassGraceSeconds = Saved.grace;
    end

    if (Saved.minimumVersion) then
        Config.minimumVersion = Saved.minimumVersion;
    end

    Saved = {};
    Env:clear("UnitIsVisible");
    GroupLoot:uninstall();
end

return E2E;
