local L = Gargul_L;

--[[
    The master looter's side of Gargul Master Loot.

    Players can't be forced to pass, so we watch for deviations instead:
    - Observed roll messages (CHAT_MSG_LOOT) are the source of truth
    - Pass reports, state changes and heartbeats from the clients make us faster and more specific
    Any deviation raises a violation popup for the master looter.
]]
---@type GL
local _, GL = ...;

GL.GargulMasterLoot = GL.GargulMasterLoot or {};

local deformat = LibStub("LibDeformat-3.0");

local Config = GL.Data.Constants.GargulMasterLoot;

---@type GargulMasterLootMode
local Mode = GL.GargulMasterLoot.Mode;
local identity = Mode.identity;

--[[ CONSTANTS ]]
local TICK_TIMER_ID = "GML.Monitor.Tick";
local DEFAULT_ROLL_SECONDS = 60;
local LOGOUT_GRACE = math.max(Config.heartbeatTimeout, Config.graceSeconds) + 15; -- A logout without a "loaded" message within this time is treated as leaving

local KIND_PASS = "pass";
local KIND_ROLL = "roll";
local KIND_RESOLVED = "resolved";

--- Patterns of the roll related loot messages. Not every client has every global, we only use what's there.
--- The placeholders differ per client and locale (some start with a loot history ID, some reorder them),
--- so we never rely on their order: the item link and player name are recognized by their contents.
---@type table
local Patterns = {};
local function addPattern(globalName, kind, rollType, isResult)
    local pattern = _G[globalName];
    if (type(pattern) ~= "string") then
        return;
    end

    table.insert(Patterns, {
        pattern = pattern,
        kind = kind,
        rollType = rollType,
        isResult = isResult == true, -- "Need Roll - 54 for [item] by Player", follows the selection
    });
end

-- Passes
addPattern("LOOT_ROLL_PASSED", KIND_PASS);
addPattern("LOOT_ROLL_PASSED_AUTO", KIND_PASS);
addPattern("LOOT_ROLL_PASSED_AUTO_FEMALE", KIND_PASS);

-- Anything but a pass
addPattern("LOOT_ROLL_NEED", KIND_ROLL, "Need");
addPattern("LOOT_ROLL_GREED", KIND_ROLL, "Greed");
addPattern("LOOT_ROLL_DISENCHANT", KIND_ROLL, "Disenchant");
addPattern("LOOT_ROLL_TRANSMOG", KIND_ROLL, "Transmog");
addPattern("LOOT_ROLL_ROLLED_NEED", KIND_ROLL, "Need", true);
addPattern("LOOT_ROLL_ROLLED_GREED", KIND_ROLL, "Greed", true);
addPattern("LOOT_ROLL_ROLLED_DE", KIND_ROLL, "Disenchant", true);
addPattern("LOOT_ROLL_ROLLED_TRANSMOG", KIND_ROLL, "Transmog", true);

-- The roll is over
addPattern("LOOT_ROLL_WON", KIND_RESOLVED);
addPattern("LOOT_ROLL_YOU_WON", KIND_RESOLVED);
addPattern("LOOT_ROLL_ALL_PASSED", KIND_RESOLVED);

---@class GargulMasterLootMonitor
---@field running boolean
---@field OpenRolls table
local Monitor = {
    running = false,
    OpenRolls = {},
};

GL.GargulMasterLoot.Monitor = Monitor; ---@type GargulMasterLootMonitor

---@return nil
function Monitor:start()
    if (self.running) then
        return;
    end

    self.running = true;
    self.OpenRolls = {};

    GL.Events:register("GMLMonitorStartLootRollListener", "START_LOOT_ROLL", function (_, rollID, rollTime)
        self:onStartLootRoll(rollID, rollTime);
    end);

    GL.Events:register("GMLMonitorChatLootListener", "CHAT_MSG_LOOT", function (_, message)
        self:onChatLoot(message);
    end);

    -- Nothing reaches us during a loading screen. Logins and reloads reset the clocks via Mode:engage,
    -- a zone change only gets some extra slack so it doesn't wipe warnings that are already out
    GL.Events:register("GMLMonitorEnteringWorldListener", "PLAYER_ENTERING_WORLD", function ()
        local graceUntil = GetTime() + Config.graceSeconds;

        for _, Entry in pairs(Mode.Members) do
            Entry.graceUntil = math.max(Entry.graceUntil or 0, graceUntil);
        end
    end);

    GL:interval(5, TICK_TIMER_ID, function () self:tick(); end);
end

---@return nil
function Monitor:stop()
    if (not self.running) then
        return;
    end

    self.running = false;

    GL.Events:unregister({
        "GMLMonitorStartLootRollListener",
        "GMLMonitorChatLootListener",
        "GMLMonitorEnteringWorldListener",
    });

    GL:cancelTimer(TICK_TIMER_ID);

    for _, Roll in pairs(self.OpenRolls) do
        GL:cancelTimer(Roll.timerID);
    end

    self.OpenRolls = {};
end

--- Treat everyone as freshly seen. Used after we loaded or resumed a session.
---
---@return nil
function Monitor:resetClocks()
    local now = GetTime();

    for _, Entry in pairs(Mode.Members) do
        Entry.lastSeen = now;
        Entry.graceUntil = now + Config.graceSeconds;
        Entry.heartbeatViolation = nil;
        Entry.tamperReason = nil;
        Entry.logoutAt = nil;
    end
end

--- Any message from a member counts as proof of life
---
---@param Message CommMessage
---@return table|nil
function Monitor:entryFor(Message)
    local Entry = Mode.Members[identity(Message.Sender and Message.Sender.name or Message.senderFqn)];
    if (Entry) then
        Entry.lastSeen = GetTime();
    end

    return Entry;
end

--- Is this message for the running session?
---
---@param Message CommMessage
---@return boolean
function Monitor:validMessage(Message)
    local content = Message.content;

    return self.running
        and not Message.Sender.isSelf
        and Mode.Session ~= nil
        and type(content) == "table"
        and content.sessionID == Mode.Session.sessionID;
end

--[[ VIOLATIONS ]]

---@param Entry table|nil
---@param kind string
---@param reason string
---@param itemLink string|nil
---@return nil
function Monitor:violation(Entry, kind, reason, itemLink)
    local name = Entry and Entry.name or "?";

    if (Entry and Entry.status ~= "accepted") then
        reason = ("%s (%s)"):format(reason, L["had not opted in"]);
    end

    GL.Interface.GargulMasterLoot.ViolationPopup:report({
        name = name,
        kind = kind,
        reason = reason,
        itemLink = itemLink,
    });
end

--- Clients report a broken auto-pass both right away and in every heartbeat after,
--- only warn when the problem is new or changed
---
---@param Entry table
---@param reason string
---@return nil
function Monitor:tamper(Entry, reason)
    if (Entry.tamperReason == reason) then
        return;
    end

    Entry.tamperReason = reason;
    self:violation(Entry, "tamper", reason);
end

--[[ INCOMING COMMS ]]

---@param Message CommMessage
---@return nil
function Monitor:onHeartbeat(Message)
    if (not self:validMessage(Message)) then
        return;
    end

    local Entry = self:entryFor(Message);
    if (not Entry) then
        return;
    end

    if (Entry.heartbeatViolation) then
        Entry.heartbeatViolation = nil;
        GL:message((L["%s is reachable again"]):format(Entry.name));
    end

    if (Message.content.ok == false) then
        self:tamper(Entry, tostring(Message.content.reason or L["Auto-pass integrity check failed"]));
    elseif (Message.content.ok == true and Entry.tamperReason) then
        Entry.tamperReason = nil;
        GL:message((L["%s's auto-pass works again"]):format(Entry.name));
    end
end

---@param Message CommMessage
---@return nil
function Monitor:onPassReport(Message)
    if (not self:validMessage(Message)) then
        return;
    end

    local Entry = self:entryFor(Message);
    local itemID = GL:getItemIDFromLink(Message.content.itemLink);

    if (not Entry or not itemID) then
        return;
    end

    local id = identity(Entry.name);
    local Roll = self:findRoll(itemID, function (Candidate) return not Candidate.Reports[id]; end);

    if (Roll) then
        Roll.Reports[id] = true;
    end
end

---@param Message CommMessage
---@return nil
function Monitor:onStateChange(Message)
    if (not self:validMessage(Message)) then
        return;
    end

    local Entry = self:entryFor(Message);
    if (not Entry) then
        return;
    end

    local event = Message.content.event;
    local id = identity(Entry.name);

    if (event == "loaded") then
        Entry.logoutAt = nil;
        Entry.graceUntil = GetTime() + Config.graceSeconds;
        Entry.heartbeatViolation = nil;
    elseif (event == "loggingOut") then
        local logoutAt = GetTime();
        Entry.logoutAt = logoutAt;

        GL:after(LOGOUT_GRACE, "GML.Monitor.Logout." .. id, function ()
            if (Entry.logoutAt == logoutAt and Mode.Members[id] == Entry) then
                Entry.logoutAt = nil;
                self:violation(Entry, "left", L["logged out or reloaded without coming back (Gargul disabled?)"]);
            end
        end);
    elseif (event == "tamper") then
        self:tamper(Entry, tostring(Message.content.reason or L["Auto-pass was interrupted"]));
    elseif (event == "skipped") then
        -- The client didn't pass on purpose (e.g. we were out of range), keep the reason for if they roll
        local itemID = GL:getItemIDFromLink(Message.content.itemLink);
        local Roll = itemID and self:findRoll(itemID, function (Candidate) return not Candidate.Skipped[id]; end);

        if (Roll) then
            Roll.Skipped[id] = tostring(Message.content.reason or "?");
        end
    end
end

--- A client came back and asked about the session
---
---@param Message CommMessage
---@return nil
function Monitor:onSync(Message)
    if (not self.running) then
        return;
    end

    local Entry = self:entryFor(Message);
    if (Entry) then
        Entry.logoutAt = nil;
        Entry.graceUntil = GetTime() + Config.graceSeconds;
    end
end

--[[ HEARTBEATS ]]

--- Runs every few seconds: spot players that went quiet
---
---@return nil
function Monitor:tick()
    if (not self.running or not Mode:isActive()) then
        return;
    end

    local now = GetTime();

    -- Keep online state fresh, without touching member status
    local Online = {};
    for _, Member in pairs(GL.User:groupMembers()) do
        Online[identity(Member.name)] = Member.online ~= false;
    end

    for id, Entry in pairs(Mode.Members) do
        Entry.online = Online[id] ~= false;

        if (Entry.status == "accepted"
            and Entry.online
            and not Entry.heartbeatViolation
            and now > (Entry.graceUntil or 0)
            and now - (Entry.lastSeen or now) > Config.heartbeatTimeout
        ) then
            Entry.heartbeatViolation = true;
            self:violation(Entry, "silent", (L["no sign of Gargul for %d seconds (disabled or removed?)"]):format(math.floor(now - Entry.lastSeen)));
        elseif (not Entry.online) then
            -- Offline players can't be reached, don't count that against them when they return
            Entry.lastSeen = now;
            Entry.graceUntil = now + Config.graceSeconds;
        end
    end
end

--[[ ROLLS ]]

--- Find the oldest open roll of an item, optionally only those that pass the filter.
--- Identical items roll at the same time: matching messages to the oldest roll that
--- doesn't have one yet spreads them over all of those rolls.
---
---@param itemID number
---@param filter? fun(Roll: table): boolean
---@return table|nil
function Monitor:findRoll(itemID, filter)
    local Found;

    for _, Roll in pairs(self.OpenRolls) do
        if (Roll.itemID == itemID
            and (not filter or filter(Roll))
            and (not Found or Roll.rollID < Found.rollID)
        ) then
            Found = Roll;
        end
    end

    return Found;
end

---@param rollID number
---@param rollTime number|nil
---@return nil
function Monitor:onStartLootRoll(rollID, rollTime)
    if (not self.running or not Mode:isActive() or not tonumber(rollID)) then
        return;
    end

    local itemLink = GetLootRollItemLink(rollID);
    local itemID = itemLink and GL:getItemIDFromLink(itemLink);
    if (not itemID) then
        return;
    end

    -- START_LOOT_ROLL's roll time is in milliseconds
    local seconds = DEFAULT_ROLL_SECONDS;
    if (tonumber(rollTime) and tonumber(rollTime) > 0) then
        seconds = tonumber(rollTime) >= 1000 and tonumber(rollTime) / 1000 or tonumber(rollTime);
    end

    local key = tostring(rollID);
    local Roll = {
        key = key,
        rollID = tonumber(rollID),
        timerID = "GML.Monitor.Roll." .. key,
        itemID = itemID,
        itemLink = itemLink,
        startedAt = GetTime(),
        resolved = false,
        Seen = {}, -- Players we saw a pass or roll of
        Passed = {},
        Reports = {},
        Skipped = {},
        Flagged = {},
    };

    self.OpenRolls[key] = Roll;

    GL:after(seconds + Config.missingPassGraceSeconds, Roll.timerID, function ()
        self:evaluate(Roll);
    end);
end

--- Check who didn't pass once a roll is over
---
---@param Roll table
---@return nil
function Monitor:evaluate(Roll)
    if (self.OpenRolls[Roll.key] ~= Roll) then
        return;
    end

    self.OpenRolls[Roll.key] = nil;

    if (not self.running or not Mode:isActive()) then
        return;
    end

    GL:onItemLoadDo(Roll.itemLink, function (Details)
        if (not Mode:isCovered(Details, Roll.itemID)) then
            return;
        end

        for id, Entry in pairs(Mode.Members) do
            if (Entry.status == "accepted"
                and Entry.online
                and not Roll.Passed[id]
                and not Roll.Flagged[id]
                -- Players that are far away never get the roll
                and UnitIsVisible(Entry.unit or Entry.name)
            ) then
                Roll.Flagged[id] = true;

                local reason = Roll.Reports[id] and L["reported a pass, but none was seen"] or L["no pass seen"];
                if (Roll.Skipped[id]) then
                    reason = ("%s (%s)"):format(reason, (L["their Gargul skipped the pass: %s"]):format(Roll.Skipped[id]));
                end

                self:violation(Entry, "missing", reason, Roll.itemLink);
            end
        end
    end);
end

--- Parse a loot chat message
---
---@param message string
---@return table|nil
local function parse(message)
    for _, Definition in ipairs(Patterns) do
        local Results = { deformat(message, Definition.pattern), };

        if (Results[1] ~= nil) then
            local Parsed = {
                kind = Definition.kind,
                rollType = Definition.rollType,
                isResult = Definition.isResult,
                Names = {}, -- Every text that isn't the item link, one of them is the player
            };

            for _, value in ipairs(Results) do
                if (type(value) == "string") then
                    if (not Parsed.link and GL:getItemIDFromLink(value)) then
                        Parsed.link = value;
                    elseif (not tonumber(value)) then
                        table.insert(Parsed.Names, value);
                    end
                end
            end

            if (Parsed.link) then
                return Parsed;
            end
        end
    end

    return nil;
end

---@param message string
---@return nil
function Monitor:onChatLoot(message)
    if (not self.running or not Mode:isActive() or type(message) ~= "string") then
        return;
    end

    local Parsed = parse(message);
    if (not Parsed) then
        return;
    end

    local itemID = GL:getItemIDFromLink(Parsed.link);

    if (Parsed.kind == KIND_RESOLVED) then
        -- Everyone has rolled, no point waiting for the full roll time
        local Roll = self:findRoll(itemID, function (Candidate) return not Candidate.resolved; end);
        if (Roll) then
            Roll.resolved = true;
            GL:after(Config.missingPassGraceSeconds, Roll.timerID, function ()
                self:evaluate(Roll);
            end);
        end

        return;
    end

    local id, Entry;
    for _, name in ipairs(Parsed.Names) do
        if (Mode.Members[identity(name)]) then
            id = identity(name);
            Entry = Mode.Members[id];
            break;
        end
    end

    -- Not someone in our group or the master looter itself
    if (not Entry) then
        return;
    end

    -- The "Need Roll - 54 for [item] by Player" result follows the selection we already handled
    if (Parsed.isResult and self:findRoll(itemID, function (Candidate) return Candidate.Flagged[id]; end)) then
        return;
    end

    -- No open roll means we never got this roll ourselves (out of range for example),
    -- we couldn't have won it so there's nothing to protect
    local Roll = self:findRoll(itemID, function (Candidate) return not Candidate.Seen[id]; end);
    if (not Roll) then
        return;
    end

    Roll.Seen[id] = true;

    if (Parsed.kind == KIND_PASS) then
        Roll.Passed[id] = true;
        return;
    end

    -- They rolled something else than pass
    Roll.Flagged[id] = true;

    GL:onItemLoadDo(Parsed.link, function (Details)
        if (not Mode:isCovered(Details, itemID)) then
            Roll.Flagged[id] = nil;
            return;
        end

        local reason = (L["rolled %s instead of passing"]):format(Parsed.rollType or L["something"]);
        if (Roll.Skipped[id]) then
            reason = ("%s (%s)"):format(reason, (L["their Gargul skipped the pass: %s"]):format(Roll.Skipped[id]));
        end

        self:violation(Entry, "roll", reason, Parsed.link);
    end);
end
