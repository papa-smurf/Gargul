local _, App = ...;

App.Comm = {
    initialized = false,
    channel = "",
};

local Comm = App.Comm;
local CommActions = App.Data.Constants.CommActions or {};

function Comm:_init()
    App:debug("Comm:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    self.channel = App.Data.Constants.commChannel;

    -- Register the Ace Comm channel listener
    App.Ace:RegisterComm(self.channel, Comm.listen);

    self._initialized = true;
end

-- Send a CommMessage object
function Comm:send(CommMessage)
    App:debug("Comm:send");

    local distribution = CommMessage.channel;
    local recipient = CommMessage.recipient;

    local compressedMessage = CommMessage:compress();

    if (not compressedMessage) then
        App:error("Something went wrong trying to compress the payload for 'Sync.Characters'");
        return;
    end

    App:debug("Payload size: " .. string.len(compressedMessage));

    App.Ace:SendCommMessage(self.channel, compressedMessage, distribution, recipient, "BULK");
end

-- Listen to any and all messages on the self.channel channel
function Comm:listen(payload, distribution, senderName)
    App:debug("Received message on channel '" .. App.Comm.channel .. "'");

    payload = App.CommMessage:decompress(payload);

    if (not senderName or not type(senderName) == "string"
        or not payload.senderName or not type(payload.senderName) == "string"
        or not payload.senderName == senderName
    ) then
        return App:warning("Failed to determine sender of COMM message");
    end

    local Sender = App.Player.fromName(senderName) or {};

    if (not Sender.id) then
        if (distribution ~= "GUILD") then
            return App:warning("Unable to confirm identity of sender '" .. senderName .. "'");
        else
            Sender.name = senderName;
        end
    end

    if (not payload) then
        if (type(payload) == "string") then
            return App:warning("Failed to decompress payload: " .. string.sub(payload, 0, 100));
        else
            return App:warning("Failed to decompress payload: not a string");
        end
    end

    if (not payload.action) then
        return App:warning("Payload is missing required property 'action'");
    end

    if (not type(payload.action) == "string") then
        return App:warning("Payload has an invalid action: not a string");
    end

    if (not payload.id
        and not payload.action == CommActions.response
    ) then
        return App:warning("Payload is missing required property 'id'");
    end

    if (not payload.correspondenceId
            and payload.action == CommActions.response
    ) then
        return App:warning("Payload is missing required property 'correspondenceId'");
    end

    -- Add the sender's profile to the payload
    payload.Sender = Sender;

    Comm:dispatch(App.CommMessage.newFromReceived(payload));
end

-- Dispatch messages to their handlers
function Comm:dispatch(CommMessage)

    App:debug("Comm:dispatch: '" .. CommMessage.action .. "'");
    App.User:refresh();

    local action = CommMessage.action;

    if (action == CommActions.response) then
        return CommMessage:processResponse();
    elseif (action == CommActions.broadcastCharacters) then
        return App.Sync:receiveCharacters(CommMessage);
    elseif (action == CommActions.broadcastLootHistory) then
        return App.Sync:receiveLoot(CommMessage);
    elseif (action == CommActions.startAuction) then
        return App.Auction:start(CommMessage);
    elseif (action == CommActions.stopAuction) then
        return App.Auction:stop(CommMessage);
    elseif (action == CommActions.bid) then
        return App.Auction:processBid(CommMessage);
    elseif (action == CommActions.retractBid) then
        return App.Auction:processRetractBid(CommMessage);
    elseif (action == CommActions.auctionResult) then
        return App.Auction:processResult(CommMessage);
    elseif (action == CommActions.startRollOff) then
        return App.RollOff:start(CommMessage);
    elseif (action == CommActions.stopRollOff) then
        return App.RollOff:stop(CommMessage);
    elseif (action == CommActions.broadcastSoftReserves) then
        return App.SoftReserves:receiveSoftReserves(CommMessage);
    elseif (action == CommActions.inspectBags) then
        return App.BagInspector:report(CommMessage);
    elseif (action == CommActions.requestAppVersion) then
        if (App.User.name ~= CommMessage.Sender.name) then
            App:debug("Respond to CommActions.requestAppVersion");
            return CommMessage:respond(App.Version.current);
        end

        return;
    end

    App:warning(string.format("Unknown comm action '%s'", action));
end

App:debug("Comm.lua");