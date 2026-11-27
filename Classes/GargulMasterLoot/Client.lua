local L = Gargul_L;

--[[
    The player's side of Gargul Master Loot (everyone except the master looter).

    Passes on every covered item, reports it to the master looter, sends heartbeats
    and tells the master looter immediately when something about our own state changes.

    There is deliberately no setting or UI to turn this off while a session is active:
    the only legitimate way out is leaving the group (or the master looter ending the session).
]]
---@type GL
local _, GL = ...;

GL.GargulMasterLoot = GL.GargulMasterLoot or {};

local CommActions = GL.Data.Constants.Comm.Actions;
local Config = GL.Data.Constants.GargulMasterLoot;

---@type GargulMasterLootMode
local Mode = GL.GargulMasterLoot.Mode;

--[[ CONSTANTS ]]
local HEARTBEAT_TIMER_ID = "GML.Client.Heartbeat";
local START_LOOT_ROLL_LISTENER_ID = "GMLClientStartLootRollListener";
local LOGOUT_LISTENER_ID = "GMLClientLogoutListener";
local ENTERING_WORLD_LISTENER_ID = "GMLClientEnteringWorldListener";

-- Captured while the add-on loads so we can notice it being replaced later
local OriginalRollOnLoot = _G.RollOnLoot;

---@class GargulMasterLootClient
---@field armed boolean
---@field lastSentAt number
---@field reportedTamper string|nil
local Client = {
    armed = false,
    lastSentAt = 0,
    reportedTamper = nil,
};

GL.GargulMasterLoot.Client = Client; ---@type GargulMasterLootClient

---@return nil
function Client:start()
    if (self.armed) then
        return;
    end

    self.armed = true;
    self.reportedTamper = nil;

    GL.Events:register(START_LOOT_ROLL_LISTENER_ID, "START_LOOT_ROLL", function (_, rollID)
        self:onStartLootRoll(rollID);
    end);

    -- Best effort: tell the master looter we're going away. A reload shows up as "loaded" soon after.
    GL.Events:register(LOGOUT_LISTENER_ID, "PLAYER_LOGOUT", function ()
        self:send(CommActions.gmlStateChange, { event = "loggingOut", });
    end);

    GL.Events:register(ENTERING_WORLD_LISTENER_ID, "PLAYER_ENTERING_WORLD", function ()
        GL:after(3, "GML.Client.Loaded", function ()
            self:send(CommActions.gmlStateChange, { event = "loaded", });
        end);
    end);

    GL:interval(Config.heartbeatInterval, HEARTBEAT_TIMER_ID, function () self:heartbeat(); end);
end

---@return nil
function Client:stop()
    if (not self.armed) then
        return;
    end

    self.armed = false;

    GL.Events:unregister({
        START_LOOT_ROLL_LISTENER_ID,
        LOGOUT_LISTENER_ID,
        ENTERING_WORLD_LISTENER_ID,
    });

    GL:cancelTimer(HEARTBEAT_TIMER_ID);
end

--- Send something to the master looter
---
---@param action number
---@param content table
---@return boolean
function Client:send(action, content)
    local Session = Mode.Session;
    if (not Session or Mode:isMasterLooter()) then
        return false;
    end

    content.sessionID = Session.sessionID;

    GL.CommMessage.new({
        action = action,
        channel = "WHISPER",
        recipient = Session.masterLooterFqn or Session.masterLooter,
        content = content,
    }):send();

    self.lastSentAt = GetTime();

    return true;
end

--- Check that nothing got in the way of passing. This can't stop a determined
--- user but it does catch the accidental and the lazy ways out.
---
---@return boolean, string|nil
function Client:integrity()
    if (not Mode:isActive() or not Mode.Session) then
        return false, L["Gargul Master Loot session is missing"];
    end

    if (OriginalRollOnLoot and RollOnLoot ~= OriginalRollOnLoot) then
        return false, L["RollOnLoot was replaced"];
    end

    local Listeners = GL.Events.Registry.EventListeners["START_LOOT_ROLL"];
    if (type(Listeners) ~= "table" or not Listeners[START_LOOT_ROLL_LISTENER_ID]) then
        return false, L["The auto-pass listener was removed"];
    end

    if (not GL.Timers[HEARTBEAT_TIMER_ID]) then
        return false, L["The heartbeat was stopped"];
    end

    -- Group data isn't reliable yet right after logging in
    if (not Mode.resumePending and not Mode:groupMember(Mode.Session.masterLooter)) then
        return false, L["The master looter is not in the group"];
    end

    return true;
end

--- When the master looter can't roll (offline or too far away) and everyone passes,
--- the item ends up on the corpse for whoever loots it first. Don't pass in that case.
---
---@return boolean, string|nil
function Client:masterLooterCanRoll()
    local MasterLooter = Mode:groupMember(Mode.Session.masterLooter);
    if (not MasterLooter) then
        return false, L["the master looter is not in the group"];
    end

    if (MasterLooter.online == false) then
        return false, L["the master looter is offline"];
    end

    local unit = GL:storedPlayerName(GL:iEquals(MasterLooter.realm, GL.User.realm) and MasterLooter.name or MasterLooter.fqn);
    if (not UnitIsVisible(unit)) then
        return false, L["the master looter is out of range"];
    end

    return true;
end

--- Make the master looter aware of a problem with our auto-passing (once per kind of problem)
---
---@param reason string
---@return nil
function Client:reportTamper(reason)
    if (self.reportedTamper == reason) then
        return;
    end

    self.reportedTamper = reason;
    self:send(CommActions.gmlStateChange, { event = "tamper", reason = reason, });
end

--- Tell the master looter we're still here (skipped when we recently sent something else)
---
---@return nil
function Client:heartbeat()
    if (not self.armed) then
        return;
    end

    local ok, reason = self:integrity();
    if (not ok) then
        self:reportTamper(reason);
    else
        self.reportedTamper = nil;
    end

    if (GetTime() - self.lastSentAt < Config.heartbeatInterval - 1) then
        return;
    end

    self:send(CommActions.gmlHeartbeat, { ok = ok, reason = reason, });
end

--- Pass on everything Gargul Master Loot covers
---
---@param rollID number
---@return nil
function Client:onStartLootRoll(rollID)
    if (not self.armed or not rollID or not Mode:isActive() or Mode:isMasterLooter()) then
        return;
    end

    local ok, reason = self:integrity();
    if (not ok) then
        self:reportTamper(reason);
    end

    local itemLink = GetLootRollItemLink(rollID);
    local itemID = itemLink and GL:getItemIDFromLink(itemLink);
    if (not itemID) then
        return;
    end

    GL:onItemLoadDo(itemLink, function (Details)
        if (not self.armed or not Mode:isCovered(Details, itemID)) then
            return;
        end

        local canRoll, skipReason = self:masterLooterCanRoll();
        if (not canRoll) then
            GL:warning((L["Gargul Master Loot did not pass on %s: %s. Roll as you normally would."]):format(itemLink, skipReason));

            self:send(CommActions.gmlStateChange, {
                event = "skipped",
                itemLink = itemLink,
                reason = skipReason,
            });

            return;
        end

        -- Replacing RollOnLoot is caught by integrity() and reported to the master looter
        RollOnLoot(rollID, GL.Data.Constants.GroupLootActions.PASS);

        self:send(CommActions.gmlPassReport, {
            rollID = rollID,
            itemLink = itemLink,
        });
    end);
end

--- After a reload/login: is the session we persisted still running?
---
---@return nil
function Client:requestSync()
    local Session = Mode.Session;
    if (not Session) then
        return;
    end

    local sessionID = Session.sessionID;

    GL.CommMessage.new({
        action = CommActions.gmlSyncRequest,
        channel = "WHISPER",
        recipient = Session.masterLooterFqn or Session.masterLooter,
        content = { sessionID = sessionID, },
        onResponse = function (Response)
            local content = Response.content;

            if (type(content) == "table"
                and content.sessionID == sessionID
                and content.active == false
                and Mode.Session
                and Mode.Session.sessionID == sessionID
            ) then
                Mode:finish(L["The master looter ended Gargul Master Loot while you were away"]);
            end
        end,
    }):send();

    self.lastSentAt = GetTime();
end
