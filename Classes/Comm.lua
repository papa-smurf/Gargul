---@type GL
local _, GL = ...;

GL.Comm = {
    initialized = false,
    channel = "",
    notifiedOfNewerVersion = false,
};

local Comm = GL.Comm;
local CommActions = GL.Data.Constants.Comm.Actions or {};

function Comm:_init()
    GL:debug("Comm:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    self.channel = GL.Data.Constants.Comm.channel;

    -- Register the Ace Comm channel listener
    GL.Ace:RegisterComm(self.channel, Comm.listen);

    self._initialized = true;
end

-- Send a CommMessage object
function Comm:send(CommMessage)
    GL:debug("Comm:send");

    local distribution = CommMessage.channel;
    local recipient = CommMessage.recipient;

    if (distribution == "GROUP") then
        distribution = "PARTY";

        if (GL.User.isInRaid) then
            distribution = "RAID";
        end
    end

    local compressedMessage = "";

    -- If this is a fresh message, not a response, then CommMessage will
    -- be an instance of GL.CommMessage and as such will have its own compression method
    if (CommMessage.compress) then
        compressedMessage = CommMessage:compress();
    else
        compressedMessage = GL.CommMessage:compress(CommMessage);
    end

    if (not compressedMessage) then
        GL:error("Something went wrong trying to compress the payload for 'Sync.Characters'");
        return;
    end

    -- We lower the burst value on large payloads to make sure
    -- our messages are not dropped by the server
    local stringLength = string.len(compressedMessage);
    GL:debug("Payload size: " .. stringLength);
    local lowerBurstValue = stringLength > 800;

    local defaultBurstValue = _G.ChatThrottleLib.BURST or 4000;
    if (lowerBurstValue) then
        if (self.resetCTLBurstTimerID) then
            GL.Ace:CancelTimer(self.resetCTLBurstTimerID);
            self.resetCTLBurstTimerID = nil;
        end

        _G.ChatThrottleLib.BURST = 800;

        -- Failsafe in case the sent >= textlen below is not reached
        self.resetCTLBurstTimerID = GL.Ace:ScheduleTimer(function ()
            _G.ChatThrottleLib.BURST = defaultBurstValue;
        end, 5);
    end

    GL.Ace:SendCommMessage(self.channel, compressedMessage, distribution, recipient, "BULK", function (_, sent, textlen)
        GL:debug(string.format("Sent %s from %s characters", sent, textlen));

        if (sent >= textlen) then
            _G.ChatThrottleLib.BURST = defaultBurstValue;
            GL.Ace:CancelTimer(self.resetCTLBurstTimerID);
            self.resetCTLBurstTimerID = nil;
        end
    end);
end

--- Listen to any and all messages on the self.channel channel
---@param payload string
---@param distribution string
---@return boolean
function Comm:listen(payload, distribution)
    GL:debug(string.format("Received message on %s", GL.Comm.channel));

    payload = GL.CommMessage:decompress(payload);

    if (not payload.senderFqn or not type(payload.senderFqn) == "string") then
        GL:warning("Failed to determine sender of COMM message");
        return false;
    end

    local Sender = GL.Player:fromFqn(payload.senderFqn) or {};

    if (not Sender.id) then
        if (distribution ~= "GUILD") then
            GL:warning("Unable to confirm identity of sender '" .. payload.senderFqn .. "'");
            return false;
        else
            Sender.name = payload.senderName;
        end
    end

    if (not payload) then
        if (type(payload) == "string") then
            GL:warning("Failed to decompress payload: " .. string.sub(payload, 0, 100));
            return false;
        else
            GL:warning("Failed to decompress payload: not a string");
            return false;
        end
    end

    if (payload.version
        and type(payload.version) == "string"
        and not GL.Version:leftIsNewerThanOrEqualToRight(GL.version, payload.version)
    ) then
        if (not GL.Comm.notifiedOfNewerVersion) then
            GL:warning("There's an update available. Go to https://www.curseforge.com/wow/addons/gargul to update.");
            GL.Comm.notifiedOfNewerVersion = true;
        end
    end

    if (payload.minimumVersion
        and type(payload.minimumVersion) == "string"
        and not GL.Version:leftIsNewerThanOrEqualToRight(GL.version, payload.minimumVersion)
    ) then
        GL:error("I'm out of date and won't work properly until you update me!");
        return false;
    end

    if (not payload.action) then
        GL:warning("Payload is missing required property 'action'");
        return false;
    end

    if (not type(payload.action) == "string") then
        GL:warning("Payload has an invalid action: not a string");
        return false;
    end

    if (not payload.id
        and not payload.action == CommActions.response
    ) then
        GL:warning("Payload is missing required property 'id'");
        return false;
    end

    if (not payload.correspondenceId
            and payload.action == CommActions.response
    ) then
        GL:warning("Payload is missing required property 'correspondenceId'");
        return false;
    end

    -- Add the sender's profile to the payload
    payload.Sender = Sender;

    Comm:dispatch(GL.CommMessage.newFromReceived(payload));
end

-- Dispatch messages to their handlers
function Comm:dispatch(CommMessage)
    GL:debug("Comm:dispatch: '" .. CommMessage.action .. "'");
    GL.User:refresh();

    local action = CommMessage.action;

    if (action == CommActions.response) then
        return CommMessage:processResponse();
    elseif (action == CommActions.awardItem) then
        return GL.AwardedLoot:processAwardedLoot(CommMessage);
    elseif (action == CommActions.startRollOff) then
        return GL.RollOff:start(CommMessage);
    elseif (action == CommActions.stopRollOff) then
        return GL.RollOff:stop(CommMessage);
    elseif (action == CommActions.broadcastSoftRes) then
        return GL.SoftRes:receiveSoftRes(CommMessage);
    elseif (action == CommActions.broadcastTMBData) then
        return GL.TMB:receiveBroadcast(CommMessage);
    elseif (action == CommActions.inspectBags) then
        return GL.BagInspector:report(CommMessage);
    elseif (action == CommActions.requestAppVersion) then
        if (GL.User.name ~= CommMessage.Sender.name) then
            GL:debug("Respond to CommActions.requestAppVersion");
            return CommMessage:respond(GL.Version.current);
        end

        return;
    end

    GL:warning(string.format("Unknown comm action '%s'", action));
end

GL:debug("Comm.lua");