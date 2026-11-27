local L = Gargul_L;

--[[
    Gargul Master Loot: master loot via group loot.

    Everyone opts in, passes on tradable loot automatically and the master looter
    (the "pseudo ML") Needs everything and hands items out through trades.
    This class owns the lifecycle of such a session: roster/version checks,
    activation, pausing/ending, persistence and resuming after a reload.
]]
---@type GL
local _, GL = ...;

GL.GargulMasterLoot = GL.GargulMasterLoot or {};

---@type Version
local Version = GL.Version;

local CommActions = GL.Data.Constants.Comm.Actions;
local Config = GL.Data.Constants.GargulMasterLoot;

--[[ CONSTANTS ]]
local CHECK_TIMER_ID = "GML.Mode.Check";
local RESUME_TIMER_ID = "GML.Mode.Resume";
local UNCONFIRMED_TIMER_ID = "GML.Mode.Unconfirmed";
local VALIDATE_TIMER_ID = "GML.Mode.Validate";
local CHECK_DIALOG_AFTER = 45; -- Seconds before we tell the ML about players who aren't ready
local LATE_JOINER_NOTICE_AFTER = 30;
local UNCONFIRMED_TIMEOUT = 300; -- A client that opted in but never got confirmation from the ML gives up after this long

---@class GargulMasterLootMode
---@field _initialized boolean
---@field Session table|nil The active (or armed) session
---@field Members table Master looter only: identity => Entry (name, fqn, status, lastSeen ...)
---@field Check table|nil Master looter only: the roster check that precedes activation
---@field resumePending boolean True between loading a persisted session and resuming it
local Mode = {
    _initialized = false,
    Session = nil,
    Members = {},
    Check = nil,
    PendingOptIns = {},
    resumePending = false,
};

GL.GargulMasterLoot.Mode = Mode; ---@type GargulMasterLootMode

--- A comparable, realm-less, lowercase version of a player name
---
---@param name string|nil
---@return string
function Mode.identity(name)
    if (type(name) ~= "string" or name == "") then
        return "";
    end

    return strlower((GL:stripRealm(name)));
end
local identity = Mode.identity;

---@return nil
function Mode:_init()
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    -- Resume a session that survived a reload / short disconnect
    local Saved = GL.DB.GargulMasterLoot.Session;
    if (type(Saved) == "table"
        and Saved.active
        and type(Saved.sessionID) == "string"
        and type(Saved.masterLooter) == "string"
    ) then
        self.Session = Saved;
        self.Members = type(Saved.Members) == "table" and Saved.Members or {};
        Saved.Members = self.Members;

        -- Group data isn't reliable right after logging in, validating now could end a perfectly fine session
        self.resumePending = true;
        self:engage();
        GL:after(10, RESUME_TIMER_ID, function () self:resume(); end);
    end

    local validate = function ()
        -- GetLootMethod can lag behind its event, give it a moment
        GL:after(1, VALIDATE_TIMER_ID, function () self:validate(); end);
    end

    GL.Events:register("GMLModeLootMethodChangedListener", "PARTY_LOOT_METHOD_CHANGED", validate);
    GL.Events:register("GMLModeRosterChangedListener", "GL.GROUP_ROSTER_UPDATE_THROTTLED", function ()
        validate();
        self:rosterChanged();
    end);
    GL.Events:register("GMLModeLeftGroupListener", "GL.USER_LEFT_GROUP", function ()
        if (self.Session or self.Check) then
            self:finish(L["You left the group"]);
        end
    end);
end

---@return boolean
function Mode:isActive()
    return type(self.Session) == "table" and self.Session.active == true;
end

---@return string|nil
function Mode:masterLooterName()
    return self.Session and self.Session.masterLooter or nil;
end

--- Is the current user the master looter of the active session?
---
---@return boolean
function Mode:isMasterLooter()
    return self:isActive() and identity(self.Session.masterLooter) == identity(GL.User.name);
end

--- Group loot (or need before greed) is the only loot method this mode works with
---
---@return boolean
function Mode:groupLootActive()
    local method = GL.GetLootMethod();
    return method == "group" or method == "needbeforegreed";
end

--- Find a group member by name
---
---@param name string
---@return table|nil
function Mode:groupMember(name)
    local wanted = identity(name);
    if (wanted == "") then
        return nil;
    end

    for _, Member in pairs(GL.User:groupMembers()) do
        if (identity(Member.name) == wanted or identity(Member.fqn) == wanted) then
            return Member;
        end
    end

    return nil;
end

--- The group member that sent this message
---
---@param Message CommMessage
---@return table|nil
function Mode:sender(Message)
    return self:groupMember(Message.senderFqn or (Message.Sender and Message.Sender.name));
end

--- Can the person who sent this message manage loot (lead or assist)?
---
---@param Message CommMessage
---@return boolean
function Mode:senderIsManager(Message)
    local Member = self:sender(Message);
    return Member ~= nil and (Member.isLeader or Member.hasAssist);
end

--- Did the master looter of the current session send this message?
---
---@param Message CommMessage
---@return boolean
function Mode:senderIsMasterLooter(Message)
    local Member = self:sender(Message);
    return self.Session ~= nil
        and Member ~= nil
        and identity(Member.name) == identity(self.Session.masterLooter);
end

--- Is the given item handled by Gargul Master Loot? Everything that
--- triggers a group loot roll (>= threshold) and that PackMule considers tradable.
---
---@param Details table
---@param itemID number
---@return boolean
function Mode:isCovered(Details, itemID)
    if (type(Details) ~= "table" or not itemID) then
        return false;
    end

    local threshold = GetLootThreshold and tonumber(GetLootThreshold());
    if (threshold and Details.quality and Details.quality < threshold) then
        return false;
    end

    return GL.PackMule:isItemPassable(Details, itemID, "gml");
end

--- Persist the current session so we can resume after a reload
---
---@return nil
function Mode:persist()
    GL.DB.GargulMasterLoot.Session = self.Session;

    if (self.Session and GL.User.isPseudoMasterLooter) then
        self.Session.Members = self.Members;
    end
end

--- Start Monitor or Client depending on our role in the current session
---
---@return nil
function Mode:engage()
    if (not self.Session) then
        return;
    end

    if (identity(self.Session.masterLooter) == identity(GL.User.name)) then
        GL.User.isPseudoMasterLooter = true;
        GL.GargulMasterLoot.Monitor:start();
        GL.GargulMasterLoot.Monitor:resetClocks(); -- GetTime() restarts with every session of the game client
        return;
    end

    GL.GargulMasterLoot.Client:start();
end

--- Called shortly after a reload/login
---
---@return nil
function Mode:resume()
    self.resumePending = false;

    if (not self.Session) then
        return;
    end

    GL.User:refresh();
    self:validate();

    if (not self.Session) then
        return;
    end

    if (GL.User.isPseudoMasterLooter) then
        GL.GargulMasterLoot.Monitor:resetClocks();
        GL:success(L["Gargul Master Loot resumed"]);
        return;
    end

    GL.GargulMasterLoot.Client:requestSync();
end

--[[ MASTER LOOTER: START / ROSTER CHECK / ACTIVATE ]]

--- Start a new Gargul Master Loot session (the current user becomes the master looter)
---
---@return boolean
function Mode:start()
    GL.User:refresh();

    if (self:isActive() or self.Check) then
        GL:warning(L["Gargul Master Loot is already running, stop it first"]);
        return false;
    end

    if (not GL.User.isInGroup) then
        GL:warning(L["You need to be in a group to use Gargul Master Loot"]);
        return false;
    end

    if (not GL.User.isLead and not GL.User.hasAssist) then
        GL:warning(L["Only the group leader or an assistant can start Gargul Master Loot"]);
        return false;
    end

    if (GL.GetLootMethod() == "master") then
        GL:warning(L["Real master loot is active, Gargul Master Loot is meant for group loot"]);
        return false;
    end

    if (not self:groupLootActive()) then
        GL:warning(L["Set the loot method to Group Loot before starting Gargul Master Loot"]);
        return false;
    end

    local numberOfOtherMembers = 0;
    for _, Member in pairs(GL.User:groupMembers()) do
        if (identity(Member.name) ~= identity(GL.User.name)) then
            numberOfOtherMembers = numberOfOtherMembers + 1;
        end
    end

    if (numberOfOtherMembers == 0) then
        GL:warning(L["You're the only one in the group"]);
        return false;
    end

    self.Check = {
        sessionID = GL:uuid(),
        startedAt = GetTime(),
        dialogShownAt = nil,
        Members = {},
    };

    self:syncMembers(self.Check.Members);
    self:sendOptInRequest(self.Check);

    GL:message(L["Gargul Master Loot: waiting for everyone to accept..."]);
    GL:interval(1, CHECK_TIMER_ID, function () self:checkProgress(); end);

    return true;
end

--- Make sure Members holds exactly the people currently in our group (except us)
---
---@param Members table
---@return nil
function Mode:syncMembers(Members)
    local PresentIdentities = {};

    for _, Member in pairs(GL.User:groupMembers()) do
        local id = identity(Member.name);

        if (id ~= identity(GL.User.name)) then
            PresentIdentities[id] = true;

            local Entry = Members[id];
            if (not Entry) then
                Entry = { status = "waiting", lastSeen = GetTime(), joinedAt = GetTime(), };
                Members[id] = Entry;
            end

            Entry.name = Member.name;
            Entry.fqn = Member.fqn;
            Entry.unit = GL:storedPlayerName(GL:iEquals(Member.realm, GL.User.realm) and Member.name or Member.fqn);
            Entry.online = Member.online ~= false;
        end
    end

    for id in pairs(Members) do
        if (not PresentIdentities[id]) then
            Members[id] = nil;
        end
    end
end

--- Ask everyone (or just the given recipients) to opt in
---
---@param Context table Either self.Check or self.Session
---@param Recipients table|nil Entries, nil to ask the entire group
---@return nil
function Mode:sendOptInRequest(Context, Recipients)
    local content = {
        sessionID = Context.sessionID,
        minimumVersion = Config.minimumVersion,
    };

    local onResponse = function (Response) self:onOptInResponse(Response); end;

    if (not Recipients) then
        GL.CommMessage.new({
            action = CommActions.gmlOptInRequest,
            channel = "GROUP",
            content = content,
            onResponse = onResponse,
        }):send();

        return;
    end

    for _, Entry in pairs(Recipients) do
        GL.CommMessage.new({
            action = CommActions.gmlOptInRequest,
            channel = "WHISPER",
            recipient = Entry.fqn or Entry.name,
            content = content,
            onResponse = onResponse,
        }):send();
    end
end

--- The ML's view of a response to our opt-in request
---
---@param Response CommMessage
---@return nil
function Mode:onOptInResponse(Response)
    local Context = self.Check or self.Session;
    local content = Response.content;

    if (not Context
        or type(content) ~= "table"
        or content.sessionID ~= Context.sessionID
    ) then
        return;
    end

    local Members = self.Check and self.Check.Members or self.Members;
    local Entry = Members[identity(Response.Sender and Response.Sender.name or Response.senderFqn)];
    if (not Entry) then
        return;
    end

    Entry.lastSeen = GetTime();

    if (type(Response.version) ~= "string"
        or not Version:leftIsNewerThanOrEqualToRight(Response.version, Config.minimumVersion)
    ) then
        Entry.status = "outdated";
        return;
    end

    Entry.version = Response.version;

    if (content.state == "accepted") then
        Entry.status = "accepted";
        Entry.graceUntil = GetTime() + Config.graceSeconds;
    elseif (content.state == "declined") then
        Entry.status = "declined";
    elseif (Entry.status ~= "accepted") then
        Entry.status = "prompted";
    end
end

--- Entries (of a Members table) that are not yet opted in
---
---@param Members table
---@return table
function Mode:notReady(Members)
    local NotReady = {};

    for _, Entry in pairs(Members) do
        if (Entry.status ~= "accepted") then
            table.insert(NotReady, Entry);
        end
    end

    table.sort(NotReady, function (a, b) return (a.name or "") < (b.name or ""); end);

    return NotReady;
end

--- Called every second while we're waiting for people to opt in
---
---@return nil
function Mode:checkProgress()
    local Check = self.Check;
    if (not Check) then
        GL:cancelTimer(CHECK_TIMER_ID);
        return;
    end

    GL.User:refresh();

    if (not GL.User.isInGroup or not self:groupLootActive()) then
        self:cancelCheck(L["The group or loot method changed"]);
        return;
    end

    self:syncMembers(Check.Members);

    local NotReady = self:notReady(Check.Members);
    if (#NotReady == 0) then
        GL.Interface.GargulMasterLoot.RosterCheck:hide();
        self:activate();
        return;
    end

    local blockedForGood = false;
    for _, Entry in pairs(NotReady) do
        if (Entry.status == "declined" or Entry.status == "outdated") then
            blockedForGood = true;
        end
    end

    local waited = GetTime() - Check.startedAt;
    if (not Check.dialogShownAt
        and (waited >= CHECK_DIALOG_AFTER or (blockedForGood and waited >= 5))
    ) then
        Check.dialogShownAt = GetTime();

        GL.Interface.GargulMasterLoot.RosterCheck:show(NotReady, {
            remove = function ()
                for _, Entry in pairs(self:notReady(Check.Members)) do
                    UninviteUnit(Entry.unit or Entry.name);
                end

                Check.startedAt = GetTime();
                Check.dialogShownAt = nil;
            end,
            retry = function ()
                Check.startedAt = GetTime();
                Check.dialogShownAt = nil;
                self:sendOptInRequest(Check, self:notReady(Check.Members));
            end,
            cancel = function ()
                self:cancelCheck(L["Cancelled"]);
            end,
        });
    end
end

--- Abort the roster check
---
---@param reason string
---@return nil
function Mode:cancelCheck(reason)
    local Check = self.Check;
    if (not Check) then
        return;
    end

    GL:cancelTimer(CHECK_TIMER_ID);
    GL.Interface.GargulMasterLoot.RosterCheck:hide();
    self.Check = nil;

    -- Players that already accepted are armed, release them
    GL.CommMessage.new({
        action = CommActions.gmlEnd,
        channel = "GROUP",
        content = { sessionID = Check.sessionID, reason = reason, },
    }):send();

    GL:warning((L["Gargul Master Loot was not started: %s"]):format(reason));
end

--- Everyone opted in, make it official
---
---@return nil
function Mode:activate()
    local Check = self.Check;
    if (not Check) then
        return;
    end

    GL:cancelTimer(CHECK_TIMER_ID);
    self.Check = nil;

    self.Members = Check.Members;
    self.Session = {
        active = true,
        sessionID = Check.sessionID,
        masterLooter = GL.User.name,
        masterLooterFqn = GL.User.fqn,
        startedAt = GetServerTime(),
    };

    GL.User.isPseudoMasterLooter = true;
    self:persist();

    GL.CommMessage.new({
        action = CommActions.gmlActivate,
        channel = "GROUP",
        content = { sessionID = self.Session.sessionID, },
    }):send();

    GL.GargulMasterLoot.Monitor:start();
    GL.Events:fire("GL.GML_STARTED");

    GL:success(L["Gargul Master Loot is active. Everyone auto-passes on tradable loot, you Need everything and hand items out via trades."]);
end

--[[ ENDING ]]

--- End the session on request of the user (master looter or group leader)
---
---@return boolean
function Mode:stop()
    GL.User:refresh();

    if (self.Check) then
        self:cancelCheck(L["Cancelled"]);
        return true;
    end

    if (not self:isActive()) then
        GL:warning(L["Gargul Master Loot is not active"]);
        return false;
    end

    if (not GL.User.isPseudoMasterLooter and not GL.User.isLead) then
        GL:warning(L["Only the master looter or the group leader can stop Gargul Master Loot"]);
        return false;
    end

    GL.CommMessage.new({
        action = CommActions.gmlEnd,
        channel = "GROUP",
        content = { sessionID = self.Session.sessionID, reason = L["Stopped by the master looter or group leader"], },
    }):send();

    self:finish(L["Stopped by you"]);

    return true;
end

--- Clear everything about the current session locally
---
---@param reason string
---@return nil
function Mode:finish(reason)
    local hadSession = self.Session ~= nil;
    local sessionID = self.Session and self.Session.sessionID;

    GL:cancelTimer({ CHECK_TIMER_ID, RESUME_TIMER_ID, UNCONFIRMED_TIMER_ID, });

    self.resumePending = false;
    self.Session = nil;
    self.Members = {};
    self.Check = nil;
    GL.User.isPseudoMasterLooter = false;
    GL.DB.GargulMasterLoot.Session = nil;

    GL.GargulMasterLoot.Monitor:stop();
    GL.GargulMasterLoot.Client:stop();
    GL.Interface.GargulMasterLoot.RosterCheck:hide();
    GL.Interface.GargulMasterLoot.OptIn:hide(sessionID);

    if (hadSession) then
        GL.Events:fire("GL.GML_ENDED");
        GL:warning((L["Gargul Master Loot ended: %s"]):format(reason or ""));
    end
end

--- Pause (end) the session when the conditions it relies on no longer hold
---
---@return nil
function Mode:validate()
    if (not self.Session or self.resumePending) then
        return;
    end

    GL.User:refresh();

    local reason;
    if (not GL.User.isInGroup) then
        reason = L["You're no longer in a group"];
    else
        local method = GL.GetLootMethod();

        if (method and not self:groupLootActive()) then
            reason = L["The loot method changed"];
        else
            local MasterLooter = self:groupMember(self.Session.masterLooter);

            if (not MasterLooter) then
                reason = L["The master looter left the group"];
            elseif (not MasterLooter.isLeader and not MasterLooter.hasAssist) then
                reason = L["The master looter no longer has lead or assist"];
            end
        end
    end

    if (not reason) then
        return;
    end

    -- Make sure everyone else hears about it as well
    if (GL.User.isPseudoMasterLooter) then
        GL.CommMessage.new({
            action = CommActions.gmlEnd,
            channel = "GROUP",
            content = { sessionID = self.Session.sessionID, reason = reason, },
        }):send();
    end

    self:finish(reason);
end

--[[ MASTER LOOTER: LATE JOINERS / LEAVERS ]]

--- The group changed while a session is running (ML only)
---
---@return nil
function Mode:rosterChanged()
    if (not GL.User.isPseudoMasterLooter or not self:isActive()) then
        return;
    end

    local KnownNames = {};
    for id, Entry in pairs(self.Members) do
        KnownNames[id] = Entry.name or id;
    end

    self:syncMembers(self.Members);

    local Joined = {};
    for id, Entry in pairs(self.Members) do
        if (not KnownNames[id]) then
            table.insert(Joined, Entry);
        end
    end

    for id, name in pairs(KnownNames) do
        if (not self.Members[id]) then
            GL:message((L["%s left the group, Gargul Master Loot no longer applies to them"]):format(name));
        end
    end

    if (#Joined == 0) then
        self:persist();
        return;
    end

    self:sendOptInRequest(self.Session, Joined);

    GL:after(LATE_JOINER_NOTICE_AFTER, "GML.Mode.LateJoiners", function ()
        local Unprotected = {};
        for _, Entry in pairs(self.Members) do
            if (Entry.status ~= "accepted") then
                table.insert(Unprotected, Entry.name);
            end
        end

        if (#Unprotected > 0) then
            GL:warning((L["Gargul Master Loot: not protected yet: %s"]):format(table.concat(Unprotected, ", ")));
        end
    end);

    self:persist();
end

--[[ CLIENT: INCOMING COMMS ]]

--- The ML asks us to opt in
---
---@param Message CommMessage
---@return nil
function Mode:onOptInRequest(Message)
    local content = Message.content;

    if (Message.Sender.isSelf
        or type(content) ~= "table"
        or type(content.sessionID) ~= "string"
        or not GL.User.isInGroup
        or not self:senderIsManager(Message)
    ) then
        return;
    end

    -- Whoever asks us to opt in becomes our master looter, never trust a name in the content
    local MasterLooter = self:sender(Message);

    -- Already part of this session, just confirm
    if (self.Session and self.Session.sessionID == content.sessionID) then
        Message:respond({ sessionID = content.sessionID, state = "accepted", });
        return;
    end

    Message:respond({ sessionID = content.sessionID, state = "prompted", });

    if (self.PendingOptIns[content.sessionID]) then
        return;
    end

    self.PendingOptIns[content.sessionID] = true;

    GL.Interface.GargulMasterLoot.OptIn:show({
        sessionID = content.sessionID,
        masterLooter = MasterLooter.name,
    }, function (accepted)
        self.PendingOptIns[content.sessionID] = nil;

        if (not accepted) then
            Message:respond({ sessionID = content.sessionID, state = "declined", });
            return;
        end

        GL.User:refresh();

        -- Leave any session we were in before
        if (self.Session) then
            self:finish(L["You joined another session"]);
        end

        self.Session = {
            active = true,
            confirmed = false,
            sessionID = content.sessionID,
            masterLooter = MasterLooter.name,
            masterLooterFqn = MasterLooter.fqn or Message.senderFqn,
            startedAt = GetServerTime(),
        };

        self:persist();
        self:engage();

        Message:respond({ sessionID = content.sessionID, state = "accepted", });
        GL:success(L["You opted in to Gargul Master Loot: Gargul now passes on tradable loot for you"]);

        -- If the ML never confirms we shouldn't be stuck passing on everything forever
        GL:after(UNCONFIRMED_TIMEOUT, UNCONFIRMED_TIMER_ID, function ()
            if (self.Session
                and self.Session.sessionID == content.sessionID
                and self.Session.confirmed == false
            ) then
                self:finish(L["The master looter never confirmed the start"]);
            end
        end);
    end);
end

--- The roster check passed, the ML made it official
---
---@param Message CommMessage
---@return nil
function Mode:onActivate(Message)
    local content = Message.content;

    if (Message.Sender.isSelf
        or type(content) ~= "table"
        or not self.Session
        or self.Session.sessionID ~= content.sessionID
        or not self:senderIsMasterLooter(Message)
    ) then
        return;
    end

    self.Session.confirmed = true;
    GL:cancelTimer(UNCONFIRMED_TIMER_ID);
    self:persist();

    GL.Events:fire("GL.GML_STARTED");
    GL:success((L["Gargul Master Loot is active, %s is the master looter"]):format(self.Session.masterLooter));
end

--- Someone (ML or leader) ended the session
---
---@param Message CommMessage
---@return nil
function Mode:onEnd(Message)
    local content = Message.content;

    if (Message.Sender.isSelf or type(content) ~= "table") then
        return;
    end

    GL.Interface.GargulMasterLoot.OptIn:hide(content.sessionID);
    self.PendingOptIns[content.sessionID] = nil;

    if (not self.Session or self.Session.sessionID ~= content.sessionID) then
        return;
    end

    local Sender = self:sender(Message);
    if (not self:senderIsMasterLooter(Message) and not (Sender and Sender.isLeader)) then
        return;
    end

    self:finish(type(content.reason) == "string" and content.reason or L["Ended by the master looter"]);
end

--- A client wants to know whether the session it persisted is still running
---
---@param Message CommMessage
---@return nil
function Mode:onSyncRequest(Message)
    local content = Message.content;

    if (Message.Sender.isSelf or type(content) ~= "table") then
        return;
    end

    local active = (self.Session ~= nil and self.Session.sessionID == content.sessionID)
        or (self.Check ~= nil and self.Check.sessionID == content.sessionID);

    Message:respond({ sessionID = content.sessionID, active = active, });

    if (active) then
        GL.GargulMasterLoot.Monitor:onSync(Message);
    end
end

GL:registerForInit(Mode, { "User", });
