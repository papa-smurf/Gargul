---@type GL
local _, GL = ...;

---@type Version
local Version = GL.Version;

---@type CommMessage
local CommMessage = GL.CommMessage;

---@class Comm
GL.Comm = {
    initialized = false,
    channel = "",
};

---@type Comm
local Comm = GL.Comm;

---@type Data
local Actions = GL.Data.Constants.Comm.Actions or {};

Comm.Actions = {
    [Actions.awardItem] = function (Message)
        GL.AwardedLoot:processAwardedLoot(Message);
    end,
    [Actions.editAwardedItem] = function (Message)
        GL.AwardedLoot:processEditedLoot(Message);
    end,
    [Actions.deleteAwardedItem] = function (Message)
        GL.AwardedLoot:deleteWinner(Message.content, false, false);
    end,
    [Actions.response] = function (Message)
        return Message:processResponse();
    end,
    [Actions.inspectBags] = function (Message)
        GL.BagInspector:report(Message);
    end,
    [Actions.broadcastLootPriorities] = function (Message)
        GL.LootPriority:receiveBroadcast(Message);
    end,
    [Actions.broadcastSoftRes] = function (Message)
        GL.SoftRes:receiveSoftRes(Message);
    end,
    [Actions.broadcastTMBData] = function (Message)
        GL.TMB:receiveBroadcast(Message);
    end,
    [Actions.inspectBags] = function (Message)
        GL.BagInspector:report(Message);
    end,
    [Actions.requestAppVersion] = function (Message)
        if (Message.Sender.isSelf) then
            return;
        end

        Message:respond();
    end,
    [Actions.checkForUpdate] = function (Message)
        Version:replyToUpdateCheck(Message);
    end,
    [Actions.requestSoftResData] = function (Message)
        GL.SoftRes:replyToDataRequest(Message);
    end,
    [Actions.requestTMBData] = function (Message)
        GL.TMB:replyToDataRequest(Message);
    end,
    [Actions.startRollOff] = function (Message)
        GL.RollOff:start(Message);
    end,
    [Actions.stopRollOff] = function (Message)
        GL.RollOff:stop(Message);
    end,
    [Actions.startGDKPAuction] = function (Message)
        GL.GDKP.Auction:start(Message);
    end,
    [Actions.stopGDKPAuction] = function (Message)
        GL.GDKP.Auction:stop(Message);
    end,
    [Actions.rescheduleGDKPAuction] = function (Message)
        GL.GDKP.Auction:reschedule(Message);
    end,
    [Actions.startGDKPMultiAuction] = function (Message)
        GL.GDKP.MultiAuction.Client:start(Message);
    end,
    [Actions.requestRunningGDKPMultiAuctionHash] = function (Message)
        if (Message.Sender.isSelf) then
            return;
        end

        local sessionHash = GL.GDKP.MultiAuction.Client:currentSessionHash();
        if (not sessionHash) then
            return;
        end

        Message:respond(sessionHash);
    end,
    [Actions.requestRunningGDKPMultiAuctionDetails] = function (Message)
        GL.GDKP.MultiAuction.Auctioneer:respondToDetailsRequest(Message);
    end,
    [Actions.bidOnGDKPMultiAuction] = function (Message)
        Message:confirm();
        GL.GDKP.MultiAuction.Auctioneer:processBid(Message);
    end,
    [Actions.announceChangesForGDKPMultiAuction] = function (Message)
        GL.GDKP.MultiAuction.Client:updateBids(Message);
    end,
    [Actions.broadcastGDKPAuctionQueue] = function (Message)
        GL.GDKP.Auction:receiveQueue(Message);
    end,
    [Actions.broadcastBoostedRollsData] = function (Message)
        GL.BoostedRolls:receiveBroadcast(Message);
    end,
    [Actions.requestBoostedRollsData] = function (Message)
        GL.BoostedRolls:replyToDataRequest(Message);
    end,
    [Actions.broadcastBoostedRollsMutation] = function (Message)
        GL.BoostedRolls:receiveUpdate(Message);
    end,
    [Actions.broadcastPlusOnesData] = function (Message)
        GL.PlusOnes:receiveBroadcast(Message);
    end,
    [Actions.requestPlusOnesData] = function (Message)
        GL.PlusOnes:replyToDataRequest(Message);
    end,
    [Actions.broadcastPlusOnesMutation] = function (Message)
        GL.PlusOnes:receiveUpdate(Message);
    end
};

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
    local action = CommMessage.action;

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
    -- our messages are not dropped by the server. ChatThrottleLib is not accurate enough sadly
    local stringLength = string.len(compressedMessage);
    local throttle = distribution ~= "WHISPER" and stringLength > 1900;

    local throttleResetTimer;
    -- Stop throttling: reset the burst and max cps values
    local stopThrottling = function()
        GL:debug("Resetting burst value and cps");

        _G.ChatThrottleLib.BURST = self.defaultBurstValue;
        _G.ChatThrottleLib.MAX_CPS = self.defaultCPSValue;
    end;

    if (throttle) then
        GL:debug("Throttling burst value and cps");

        _G.ChatThrottleLib.BURST = 2000;
        _G.ChatThrottleLib.MAX_CPS = 400;

        -- Make sure we reset the values even if the message couldn't be sent
        throttleResetTimer = GL.Ace:ScheduleTimer(function ()
            stopThrottling();
        end, 5);
    end

    -- Make sure we can keep an eye on comm behavior
    if (GL.User:isDev()) then
        local ActionsByID = GL:tableFlip(Actions);
        if (action == Actions.response) then
            GL:xd(("Respond | B: %s | T: %s"):format(stringLength or 0, throttle and "Y" or "N"));
        else
            GL:xd(("Send: %s | B: %s | T: %s"):format(tostring(ActionsByID[action] or action), stringLength or 0, throttle and "Y" or "N"));
        end
    end

    GL.Ace:SendCommMessage(self.channel, compressedMessage, distribution, recipient, "BULK", function (_, sent, textlen)
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
function Comm:listen(payload, distribution, playerName)
    local stringLength = string.len(payload);
    payload = GL.CommMessage:decompress(payload);

    -- We're missing a payload
    if (not payload) then
        return false;
    end

    -- If the payload is a string then it MUST be a message received confirmation
    if (type(payload) == "string") then
        local correspondenceId = payload;

        -- The correspondenceId doesn't exist or was already confirmed
        if (not GL.CommMessage.Box[correspondenceId]
            or GL.CommMessage.Box[correspondenceId].confirmed
        ) then
            return;
        end

        -- Mark the message as received and cancel any potential timers
        GL.CommMessage.Box[correspondenceId].confirmed = true;
        GL:cancelTimer(("MARK_COMM_%s_AS_UNRECEIVED"):format(correspondenceId));

        return GL.CommMessage.Box[correspondenceId].onConfirm
            and GL.CommMessage.Box[correspondenceId].onConfirm(true);
    end

    if (type(payload) ~= "table") then
        return false;
    end

    payload.channel = distribution;

    if (not payload.senderFqn and playerName) then
        payload.senderFqn = GL:nameFormat{name = playerName, forceRealm = true};
    elseif (payload.senderFqn) then
        local ciSenderFqn = strlower(strtrim(payload.senderFqn));
        local ciPlayerName = strlower(strtrim(playerName));

        -- This indicates potential source code tampering
        if (not GL:strStartsWith(ciSenderFqn, ciPlayerName)) then
            return false;
        end
    end

    -- The version includes a version, see if it's one we can work with
    if (payload.version and type(payload.version) == "string") then
        Version:addRelease(payload.version, true);

        -- The person sending us the message has an old version that's not compatible with ours, let him know!
        if (not Version:leftIsNewerThanOrEqualToRight(payload.version, GL.Data.Constants.Comm.minimumAppVersion)) then
            -- This empty message will trigger an out-of-date error on the recipient's side
            GL.CommMessage.new{
                action = Actions.response,
                channel = "WHISPER",
                recipient = playerName,
            }:send();
            return;
        end
    end

    if (not payload.senderFqn or not type(payload.senderFqn) == "string") then
        GL:warning("Failed to determine sender of COMM message");
        return false;
    end

    local Sender = GL.Player:fromName(payload.senderFqn) or {};

    -- Let's find out who sent us this message
    if (not Sender.id) then
        Sender.name = GL:nameFormat(payload.senderFqn);
    end

    -- Was this sent by ourself?
    Sender.isSelf = GL:iEquals(Sender.id, GL.User.id)
        or GL:iEquals(playerName, GL.User.name)
        or GL:iEquals(Sender.name, GL.User.name);

    -- The person sending us the message has a newer version that's not backwards compatible with ours
    -- If that's the case then we'll notify the user that his version is out of date (max once every 5 seconds)
    if (payload.minimumVersion
        and type(payload.minimumVersion) == "string"
        and not Version:leftIsNewerThanOrEqualToRight(Version.current, payload.minimumVersion)
    ) then
        Version:notBackwardsCompatibleNotice();
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
        and not payload.action == Actions.response
    ) then
        GL:warning("Payload is missing required property 'id'");
        return false;
    end

    if (not payload.correspondenceId
        and payload.action == Actions.response
    ) then
        return false;
    end

    -- Add the sender's profile to the payload
    payload.Sender = Sender;

    Comm:dispatch(GL.CommMessage.newFromReceived(payload), stringLength);
end

local WarnedAboutCommAction = {};
--- Dispatch incoming messages to their handlers
---
---@param CommMessage CommMessage
---@return any
function Comm:dispatch(CommMessage, stringLength)
    GL.User:refresh();

    local action = CommMessage.action;
    if (not action) then
        return;
    end

    if (Comm.Actions[action]) then
        -- Make sure we can keep an eye on comm behavior
        if (GL.User:isDev()) then
            local ActionsByID = GL:tableFlip(Actions);
            if (action == Actions.response) then
                local actionID = CommMessage.Box[CommMessage.correspondenceId] and CommMessage.Box[CommMessage.correspondenceId].action or Actions.respond;
                GL:xd(("Response: %s | B: %s"):format(tostring(ActionsByID[actionID] or actionID), stringLength or 0));
            else
                GL:xd(("Received: %s | B: %s"):format(tostring(ActionsByID[action] or action), stringLength or 0));
            end
        end

        return Comm.Actions[action](CommMessage);
    end

    if (WarnedAboutCommAction[action]) then
        return;
    end

    GL:warning(string.format("Unknown comm action '%s', make sure to update Gargul!", action));
    WarnedAboutCommAction[action] = true;
end

GL:debug("Comm.lua");