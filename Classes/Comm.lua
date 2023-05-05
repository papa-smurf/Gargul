---@type GL
local _, GL = ...;

---@type Version
local Version = GL.Version;

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
        GL.AwardedLoot:deleteWinner(Message.content, false);
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

        Message:respond(Version.current);
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
        GL.GDKP.Auction:extend(Message);
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

        --- This might seem like an odd one, but it allows us to test
        --- most of Gargul's feature without having to be in a group
        elseif (not GL.User.isInGroup) then
            distribution = "WHISPER";
            recipient = GL.User.name;
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

    GL.Ace:SendCommMessage(self.channel, compressedMessage, distribution, recipient, "BULK", function (_, sent, textlen)
        GL:debug(string.format("Sent %s from %s characters", sent, textlen));

        -- Execute the package sent calback
        if (type(packageSentCallback) == "function") then
            packageSentCallback(sent, textlen);
        end

        if (sent >= textlen) then
            -- Execute the broadcast finished callback
            if (type(broadcastFinishedCallback) == "function") then
                broadcastFinishedCallback(sent, textlen);
            end
        end
    end);
end

--- Listen to any and all messages on the self.channel channel
---@param payload string
---@param distribution string
---@return boolean
function Comm:listen(payload, distribution, playerName)
    GL:debug(string.format("Received message on %s", GL.Comm.channel));

    payload = GL.CommMessage:decompress(payload);

    if (not payload.senderFqn and playerName) then
        payload.senderFqn = ("%s-%s"):format(playerName, GetRealmName());
    end

    -- The version includes a version, see if it's one we can work with
    if (payload.version and type(payload.version) == "string") then
        Version:addRelease(payload.version, true);

        -- The person sending us the message has an old version that's not compatible with ours, let him know!
        if (not Version:leftIsNewerThanOrEqualToRight(payload.version, GL.Data.Constants.Comm.minimumAppVersion)) then
            -- This empty message will trigger an out-of-date error on the recipient's side
            GL.CommMessage.new(
                Actions.response,
                nil,
                "WHISPER",
                playerName
            ):send();
            return;
        end
    end

    if (not payload.senderFqn or not type(payload.senderFqn) == "string") then
        GL:warning("Failed to determine sender of COMM message");
        return false;
    end

    local Sender = GL.Player:fromFqn(payload.senderFqn) or {};

    -- Let's find out who sent us this message
    if (not Sender.id) then
        Sender.name = playerName or GL:stripRealm(payload.senderFqn);
    end

    -- Was this sent by ourself?
    Sender.isSelf = GL:iEquals(Sender.id, GL.User.id)
        or GL:iEquals(playerName, GL.User.name)
        or GL:iEquals(Sender.name, GL.User.name);

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
    if (Comm.Actions[action]) then
        return Comm.Actions[action](CommMessage);
    end

    GL:warning(string.format("Unknown comm action '%s', make sure to update Gargul!", action));
end

GL:debug("Comm.lua");