---@type GL
local _, GL = ...;

---@class CommMessage
GL.CommMessage = {};
GL.CommMessage.__index = GL.CommMessage;

local CommMessage = GL.CommMessage; ---@type CommMessage

CommMessage.Box = {};

local LibDeflate = LibStub:GetLibrary("LibDeflate");
local LibSerialize = LibStub:GetLibrary("LibSerialize");

-- This metatable allows us to have multiple instances of this object
setmetatable(CommMessage, {
    __call = function (cls, ...)
        return cls.new(...);
    end,
});

--- Create a fresh new CommMessage
---
---@param action string See GL.Data.Constants.Comm for more info
---@param content any
---@param channel string
---@param recipient string
function CommMessage.new(action, content, channel, recipient)
    GL:debug("CommMessage:new");

    local self = setmetatable({}, CommMessage);

    -- Make sure self.id is unique!
    -- This is very important if we wish to track responses to our comm message
    while(true) do
        self.id = GL:uuid();

        if (not CommMessage.Box[self.id]) then
            break;
        end
    end

    self.action = action;
    self.content = content;
    self.channel = channel;
    self.version = GL.version;
    self.minimumVersion = GL.Data.Constants.Comm.minimumAppVersion;
    self.senderRealm = GL.User.realm;
    self.senderFqn = GL.User.fqn or GL:addRealm(UnitName("player"), GL.User.realm);
    self.recipient = recipient and GL:nameFormat(recipient) or nil;
    self.Responses = {};

    CommMessage.Box[self.id] = self;

    return self;
end

--- Create a CommMessage from a received message's payload
--- The channel and recipient always point to the sender of the original message using "WHISPER"
---
---@param Message table
---@return self
function CommMessage.newFromReceived(Message)
    GL:debug("CommMessage:newFromReceived");

    local self = setmetatable({}, CommMessage);

    self.action = Message.action;
    self.content = Message.content;
    self.channel = Message.channel;
    self.version = Message.version;
    self.minimumVersion = GL.Data.Constants.Comm.minimumAppVersion;
    self.Sender = Message.Sender;
    self.senderFqn = Message.senderFqn;
    self.recipient = Message.recipient;
    self.correspondenceId = Message.correspondenceId or Message.id;
    self.Responses = Message.Responses or {};

    return self;
end

--- Send the CommMessage as-is
---
---@param broadcastFinishedCallback function thats gets executed when the message is fully broadcasted
---@param packageSentCallback function that gets executed every time (part of) the message is sent
---@return self
function CommMessage:send(broadcastFinishedCallback, packageSentCallback)
    GL:debug("CommMessage:send");

    GL.Comm:send(self, broadcastFinishedCallback, packageSentCallback);

    return self;
end

--- Reply to a CommMessage
---
---@param message string
---@return self
function CommMessage:respond(message)
    GL:debug("CommMessage:respond");

    -- Support cross-realm response
    local recipient = self.senderFqn;

    if (self.senderRealm == GL.User.realm) then
        recipient = self.Sender.name;
    end

    local Response = {
        action = GL.Data.Constants.Comm.Actions.response,
        content = message,
        channel = "WHISPER",
        version = GL.version,
        minimumVersion = GL.Data.Constants.Comm.minimumAppVersion,
        senderFqn = GL.User.fqn or GL:addRealm(UnitName("player"), GL.User.realm),
        recipient = recipient,
        correspondenceId = self.correspondenceId or self.id,
    };

    GL.Comm:send(Response);

    return self;
end

--- A response to one of our messages came in, sort it
---
---@return void
function CommMessage:processResponse()
    GL:debug("CommMessage:processResponse");

    if (not self.correspondenceId) then
        GL:warning("The message has no correspondence ID so we don't know what it responds to");
        return;
    end

    if (not CommMessage.Box[self.correspondenceId]) then
        GL:warning("The response is valid, but doesn't belong to any of the message we've sent");
        return;
    end

    local numberOfResponses = #CommMessage.Box[self.correspondenceId].Responses;
    CommMessage.Box[self.correspondenceId].Responses[numberOfResponses + 1] = self;
end

--- Compress a CommMessage so we can safely send it
---
---@param Message CommMessage
---@return string
function CommMessage:compress(Message)
    GL:debug("CommMessage:compress");

    Message = Message or self;

    local Payload = {
        a = Message.action, -- Action
        c = Message.content, -- Content
        v = Message.version, -- Version of sender
        mv = Message.minimumVersion, -- Minimum version recipient should have
        s = Message.senderFqn, -- Name of the sender
        r = Message.correspondenceId or Message.id, -- Response ID
    }

    local success, encoded = pcall(function ()
        local serialized = LibSerialize:Serialize(Payload);
        local compressed = LibDeflate:CompressDeflate(serialized, {level = 5});
        local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed);

        return encoded;
    end);

    if (not success or not encoded) then
        GL:error("Something went wrong trying to compress a CommMessage in CommMessage:compress");
        return false;
    end

    return encoded;
end

--- Decompress and deserialize a CommMessage
---
---@param encoded string
---@return table
function CommMessage:decompress(encoded)
    GL:debug("CommMessage:compress");

    local success, Payload = pcall(function ()
        local compressed = LibDeflate:DecodeForWoWAddonChannel(encoded);
        local decompressed = LibDeflate:DecompressDeflate(compressed);
        local _, deserialized = LibSerialize:Deserialize(decompressed);

        return deserialized;
    end);

    if not (success or Payload) then
        return GL:warning("Something went wrong while decoding the COMM payload");
    end

    return {
        action = Payload.a or nil, -- Action
        content = Payload.c or nil, -- Content
        version = Payload.v or nil, -- Version of sender
        minimumVersion = Payload.mv or nil, -- Minimum version recipient should have
        senderFqn = Payload.s or nil, -- Name of the sender
        correspondenceId = Payload.r or Payload.id, -- Response ID
    };
end

GL:debug("CommMessage.lua");