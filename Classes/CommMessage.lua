local _, App = ...;

App.CommMessage = {};
App.CommMessage.__index = App.CommMessage;

local CommMessage = App.CommMessage;

CommMessage.Box = {};

local LibDeflate = LibStub:GetLibrary("LibDeflate");
local LibSerialize = LibStub:GetLibrary("LibSerialize");

-- This metatable allows us to have multiple instances of this object
setmetatable(CommMessage, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

-- Create a fresh new CommMessage
function CommMessage.new(action, content, channel, recipient)
    App:debug("CommMessage:new");

    local self = setmetatable({}, CommMessage);

    -- Make sure self.id is unique!
    -- This is very important if we wish to track responses to our comm message
    while(true) do
        self.id = App:uuid();

        if (not CommMessage.Box[self.id]) then
            break;
        end
    end

    self.action = action;
    self.content = content;
    self.channel = channel;
    self.version = App.version;
    self.minimumVersion = App.Data.Constants.Comm.minimumAppVersion;
    self.senderName = App.User.name;
    self.recipient = recipient;
    self.Responses = {};

    CommMessage.Box[self.id] = self;

    return self;
end

-- Create a CommMessage from a received message's payload
-- The channel and recipient always point to the sender of the original message using "WHISPER"
function CommMessage.newFromReceived(Message)
    App:debug("CommMessage:newFromReceived");

    local self = setmetatable({}, CommMessage);

    self.action = Message.action;
    self.content = Message.content;
    self.channel = Message.channel;
    self.version = Message.version;
    self.minimumVersion = App.Data.Constants.Comm.minimumAppVersion;
    self.Sender = Message.Sender;
    self.senderName = Message.Sender.name;
    self.recipient = Message.recipient;
    self.correspondenceId = Message.correspondenceId or Message.id;
    self.Responses = Message.Responses or {};

    return self;
end

-- Send the CommMessage as-is
function CommMessage:send()
    App:debug("CommMessage:send");

    App.Comm:send(self);

    return self;
end

-- Reply to a CommMessage
function CommMessage:respond(message)
    App:debug("CommMessage:respond");

    local Response = {
        action = App.Data.Constants.Comm.Actions.response,
        content = message,
        channel = "WHISPER",
        version = App.version;
        minimumVersion = App.Data.Constants.Comm.minimumAppVersion;
        senderName = App.User.name,
        recipient = self.Sender.name,
        correspondenceId = self.correspondenceId or self.id,
    };

    App.Comm:send(Response);

    return self;
end

-- A response to one of our messages came in, sort it
function CommMessage:processResponse()
    App:debug("CommMessage:processResponse");

    if (not self.correspondenceId) then
        App:warning("The message has no correspondence ID so we don't know what it responds to");
        return;
    end

    if (not CommMessage.Box[self.correspondenceId]) then
        App:warning("The response is valid, but doesn't belong to any of the message we've sent");
        return;
    end

    local numberOfResponses = #CommMessage.Box[self.correspondenceId].Responses;
    CommMessage.Box[self.correspondenceId].Responses[numberOfResponses + 1] = self;
end

-- Compress a CommMessage so we can safely send it
function CommMessage:compress(message)
    App:debug("CommMessage:compress");

    message = message or self;

    local Payload = {
        a = message.action, -- Action
        c = message.content, -- Content
        v = message.version, -- Version of sender
        mv = message.minimumVersion, -- Minimum version recipient should have
        s = message.senderName, -- Name of the sender
        r = message.correspondenceId or message.id, -- Response ID
    }

    local success, encoded = pcall(function ()
        local serialized = LibSerialize:Serialize(Payload);
        local compressed = LibDeflate:CompressDeflate(serialized, {level = 8});
        local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed);

        return encoded;
    end);

    if (not success or not encoded) then
        App:error("Something went wrong trying to compress a CommMessage in CommMessage:compress");
        return false;
    end

    return encoded;
end

-- Decompress and deserialize a CommMessage
function CommMessage:decompress(encoded)
    App:debug("CommMessage:compress");

    local success, Payload = pcall(function ()
        local compressed = LibDeflate:DecodeForWoWAddonChannel(encoded);
        local decompressed = LibDeflate:DecompressDeflate(compressed);
        local _, deserialized = LibSerialize:Deserialize(decompressed);

        return deserialized;
    end);

    if not (success or Payload) then
        return App:warning("Something went wrong while decoding the COMM payload");
    end

    return {
        action = Payload.a or nil, -- Action
        content = Payload.c or nil, -- Content
        version = Payload.v or nil, -- Version of sender
        minimumVersion = Payload.mv or nil, -- Minimum version recipient should have
        senderName = Payload.s or nil, -- Name of the sender
        correspondenceId = Payload.r or Payload.id, -- Response ID
    };
end

App:debug("CommMessage.lua");