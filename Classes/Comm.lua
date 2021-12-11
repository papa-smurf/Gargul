---@type GL
local _, GL = ...;

GL.Comm = {
    initialized = false,
    channel = "",
    notifiedOfNewerVersion = false,
    lastOutOfDateNotification = 0,
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

    -- Store the default ChatThrottleLib burst and CPS values
    self.defaultBurstValue = _G.ChatThrottleLib.BURST or 4000;
    self.defaultCPSValue = _G.ChatThrottleLib.MAX_CPS or 800;

    self._initialized = true;
end

--- Send a CommMessage object
---
---@param CommMessage CommMessage
---@param broadcastFinishedCallback function
---@param packageSentCallback function
---@return void
function Comm:send(CommMessage, broadcastFinishedCallback, packageSentCallback)
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

    -- We lower the burst value and cps on large payloads to make sure
    -- our messages are not dropped by the server, which happens A LOT ffs
    local stringLength = string.len(compressedMessage);
    GL:debug("Payload size: " .. stringLength);
    local throttle = stringLength > 800;

    local throttleResetTimer, stopThrottling;
    if (throttle) then
        GL:debug("Throttling burst value and cps");

        _G.ChatThrottleLib.BURST = 2000;
        _G.ChatThrottleLib.MAX_CPS = 400;

        -- Stop throttling: reset the burst and max cps values
        stopThrottling = function()
            GL:debug("Resetting burst value and cps");

            _G.ChatThrottleLib.BURST = self.defaultBurstValue;
            _G.ChatThrottleLib.MAX_CPS = self.defaultCPSValue;
        end;

        -- Make sure we reset the values even if the message couldn't be sent
        throttleResetTimer = GL.Ace:ScheduleTimer(function ()
            stopThrottling();
        end, 5);
    end

    GL.Ace:SendCommMessage(self.channel, compressedMessage, distribution, recipient, "BULK", function (_, sent, textlen)
        GL:debug(string.format("Sent %s from %s characters", sent, textlen));

        -- Cancel the throttle reset timer if it exists
        if (throttleResetTimer) then
            GL.Ace:CancelTimer(throttleResetTimer);
        end

        -- Execute the package sent calback
        if (type(packageSentCallback) == "function") then
            packageSentCallback(sent, textlen);
        end

        if (sent >= textlen) then
            if (throttle) then
                stopThrottling();
            end

            -- Execute the broadcast finished callback
            if (type(broadcastFinishedCallback) == "function") then
                broadcastFinishedCallback(sent, textlen);
            end
        else
            -- Make sure we reset the values even if the message couldn't be sent in full
            throttleResetTimer = GL.Ace:ScheduleTimer(function ()
                stopThrottling();
            end, 5);
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

    -- Let's find out who sent us this message
    if (not Sender.id) then
        if (distribution ~= "GUILD") then
            GL:warning("Unable to confirm identity of sender '" .. payload.senderFqn .. "'");
            return false;
        end

        Sender.name = payload.senderName;
    end

    -- We're missing a payload
    if (not payload) then
        if (type(payload) == "string") then
            GL:warning("Failed to decompress empty payload");
            return false;
        end

        GL:warning("Failed to decompress payload: not a string");
        return false;
    end

    -- The person sending us the message has a newer version that's not backwards compatible with ours
    -- If that's the case then we'll notify the user that his version is out of date (max once every 5 seconds)
    if (payload.minimumVersion
        and type(payload.minimumVersion) == "string"
        and not GL.Version:leftIsNewerThanOrEqualToRight(GL.version, payload.minimumVersion)
    ) then
        local serverTime = GetServerTime();
        if (serverTime - GL.Comm.lastOutOfDateNotification >= 5) then
            GL.Comm.lastOutOfDateNotification = serverTime;
            GL:error("I'm out of date and won't work properly until you update me!");
        end
        return false;
    end

    -- The version includes a version, see if it's one we can work with
    if (payload.version and type(payload.version) == "string") then
        -- The person sending us the message has a newer version. Ours is still compatible so we get off with a warning
        if (not GL.Version:leftIsNewerThanOrEqualToRight(GL.version, payload.version)) then
            if (not GL.Comm.notifiedOfNewerVersion) then
                GL:warning("There's an update available. Go to https://www.curseforge.com/wow/addons/gargul to update.");
                GL.Comm.notifiedOfNewerVersion = true;
            end
        end

        -- The person sending us the message has an old version that's not compatible with ours, let him know!
        if (not GL.Version:leftIsNewerThanOrEqualToRight(payload.version, GL.Data.Constants.Comm.minimumAppVersion)) then
            -- This empty message will trigger an out-of-date error on the recipient's side
            GL.CommMessage.new(
                GL.Data.Constants.Comm.Actions.response,
                nil,
                "WHISPER",
                Sender.name
            ):send();
            return;
        end
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

--- Dispatch incoming messages to their handlers
---
---@param CommMessage CommMessage
---@return any
function Comm:dispatch(CommMessage)
    GL:debug("Comm:dispatch: '" .. CommMessage.action .. "'");
    GL.User:refresh();

    local action = CommMessage.action;

    if (action == CommActions.response) then
        return CommMessage:processResponse();

    elseif (action == CommActions.awardItem) then
        return GL.AwardedLoot:processAwardedLoot(CommMessage);

    elseif (action == CommActions.broadcastLootPriorities) then
        return GL.LootPriority:receiveBroadcast(CommMessage);

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

    elseif (action == CommActions.requestSoftResData) then
        return GL.SoftRes:replyToDataRequest(CommMessage);

    elseif (action == CommActions.startRollOff) then
        return GL.RollOff:start(CommMessage);

    elseif (action == CommActions.stopRollOff) then
        return GL.RollOff:stop(CommMessage);
    end

    GL:warning(string.format("Unknown comm action '%s'", action));
end

GL:debug("Comm.lua");