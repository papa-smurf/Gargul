---@type GL
local _, GL = ...;

---@class CommMessage
GL.CommMessage = {};
GL.CommMessage.__index = GL.CommMessage;

---@type CommMessage
local CommMessage = GL.CommMessage;

CommMessage.Box = {};

local LibDeflate = LibStub:GetLibrary("LibDeflate");
local LibSerialize = LibStub:GetLibrary("LibSerialize");

-- This metatable allows us to have multiple instances of this object
setmetatable(CommMessage, {
    __call = function (cls, ...)
        return cls.new(...);
    end,
});

---@param action string See GL.Data.Constants.Comm for more info
---@param content any|nil The data you want to send
---@param channel string The channel (See the CHANNELS variable)
---@param recipient string|nil Only used in case of WHISPER
---@param acceptsResponse boolean|nil Specify whether players are allowed to respond to your message
---@param onResponse function|nil Callback that's fired whenever a response comes in
---@param onConfirm function|nil Callback that's fired whenever a received confirms that they received your message
---
---@return CommMessage
function CommMessage.new(action, content, channel, recipient, acceptsResponse, onResponse, onConfirm)
    if (content ~= nil or type(action) ~= "table") then
        GL:error("Pass a table instead of multiple arguments")
        return;
    end

    local self = setmetatable({}, CommMessage);

    content = action.content;
    channel = action.channel;
    recipient = action.recipient;
    onConfirm = action.onConfirm;
    onResponse = action.onResponse;
    acceptsResponse = action.acceptsResponse == true or type(onResponse) == "function" or type(onConfirm) == "function";

    if (channel == "GROUP") then
        channel = "PARTY";

        if (GL.User.isInRaid) then
            channel = "RAID";

        --- This might seem like an odd one, but it allows us to test
        --- most of Gargul's features without having to be in a group
        elseif (not GL.User.isInGroup) then
            channel = "WHISPER";
            recipient = GL.User.name;
        end
    end

    action = action.action;

    self.action = action;
    self.content = content;
    self.channel = channel;
    self.version = GL.version;
    self.minimumVersion = GL.Data.Constants.Comm.minimumAppVersion;
    self.senderRealm = GL.User.realm;
    self.senderFqn = GL.User.fqn or GL:addRealm(UnitName("player"), GL.User.realm);
    self.recipient = recipient and GL:nameFormat(recipient) or nil;

    -- Make sure self.correspondenceId is unique!
    -- This is very important if we wish to track responses to our comm message
    if (acceptsResponse) then
        local i = 0;
        while(true) do
            i = i + 1;
            self.correspondenceId = ("%s.%s"):format(floor(GetTime()), i);

            if (not CommMessage.Box[self.correspondenceId]) then
                break;
            end
        end

        self.Responses = {};
        self.onResponse = onResponse or function () end;
        self.onConfirm = onConfirm;
        self.confirmed = false;
        CommMessage.Box[self.correspondenceId] = self;
    end

    return self;
end

--- Create a CommMessage from a received message's payload
--- The channel and recipient always point to the sender of the original message using "WHISPER"
---
---@param Message table
---@return self
function CommMessage.newFromReceived(Message)
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
    -- Make sure to mark the message as unreceived if 3 seconds pass without receiving a confirmation
    if (self.onConfirm and self.correspondenceId) then
        local originalBroadcastFinishedCallback = broadcastFinishedCallback;
        broadcastFinishedCallback = function (...)
            GL:after(3, ("MARK_COMM_%s_AS_UNRECEIVED"):format(self.correspondenceId), function ()
                if (self.confirmed) then
                    return;
                end

                self.onConfirm(false);
            end);

            if (originalBroadcastFinishedCallback) then
                originalBroadcastFinishedCallback(...);
            end
        end;
    end

    GL.Comm:send(self, broadcastFinishedCallback, packageSentCallback);

    return self;
end

--- Reply to a CommMessage
---
---@param message string
---@return self
function CommMessage:respond(message)
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
        correspondenceId = self.correspondenceId or self.correspondenceId,
    };

    -- Not all comm messages accept a response
    if (Response.correspondenceId) then
        GL.Comm:send(Response);
    end

    return self;
end

--- Let the sender know that we've received their message
---
---@return self
function CommMessage:confirm()
    -- We can't confirm that we received a message without a correspondence ID
    if (not self.correspondenceId) then
        return;
    end

    -- Support cross-realm response
    local recipient = self.senderFqn;

    if (self.senderRealm == GL.User.realm) then
        recipient = self.Sender.name;
    end

    local success, encoded = pcall(function ()
        local serialized = LibSerialize:Serialize(self.correspondenceId);
        local compressed = LibDeflate:CompressDeflate(serialized, { level = 5, });
        local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed);

        return encoded;
    end);

    if (not success or not encoded) then
        return false;
    end

    if (GL.User:isDev()) then
        GL:xd(("Confirm | B: %s | T: %s"):format(strlen(self.correspondenceId) or 0, "N"));
    end

    GL.Ace:SendCommMessage(GL.Data.Constants.Comm.channel, encoded, "WHISPER", recipient, "ALERT");
    return self;
end

--- A response to one of our messages came in, sort it
---
---@return void
function CommMessage:processResponse()
    -- Make sure the message exists and actually accepts responses
    if (not self.correspondenceId
        or not CommMessage.Box[self.correspondenceId]
    ) then
        return;
    end

    local numberOfResponses = #CommMessage.Box[self.correspondenceId].Responses;
    CommMessage.Box[self.correspondenceId].Responses[numberOfResponses + 1] = self;

    -- Execute the original message's onResponse handler
    CommMessage.Box[self.correspondenceId].onResponse(self);
end

--- Compress a CommMessage so we can safely send it
---
---@param Message CommMessage
---@return string
function CommMessage:compress(Message)
    Message = Message or self;

    local FQN = Message.senderFqn;
    if (not GL:isCrossRealm()) then
        FQN = GL:stripRealm(FQN);
    end

    if (Message.channel == "WHISPER"
        and Message.recipient
    ) then
        Message.channel = GL.Comm:whisperOrGroup(Message.recipient);
    end

    local Payload = {
        a = Message.action, -- Action
        b = Message.content, -- Content
        c = FQN, -- Name of the sender
        d = Message.correspondenceId or Message.id, -- Response ID
        m = Message.minimumVersion, -- Minimum version recipient should have
        v = Message.version, -- Version of sender
        r = Message.channel ~= "WHISPER" and Message.recipient or nil;
    };

    local success, encoded = pcall(function ()
        local serialized = LibSerialize:Serialize(Payload);
        local compressed = LibDeflate:CompressDeflate(serialized, { level = 5, });
        local encoded = LibDeflate:EncodeForWoWAddonChannel(compressed);

        return encoded;
    end);

    if (not success or not encoded) then
        return false;
    end

    return encoded;
end

--- Decompress and deserialize a CommMessage
---
---@param encoded string
---@return table
function CommMessage:decompress(encoded)
    local success, Payload = pcall(function ()
        local compressed = LibDeflate:DecodeForWoWAddonChannel(encoded);
        local decompressed = LibDeflate:DecompressDeflate(compressed);
        local _, deserialized = LibSerialize:Deserialize(decompressed);

        return deserialized;
    end);

    if (not success or not Payload) then
        return;
    end

    if (type(Payload) == "string") then
        return Payload;
    end

    if (Payload.e and not GL:isCrossRealm()) then
        Payload.e = GL:addRealm(Payload.e);
    end

    -- Old versions send their content under the 'c' key which can be a table as well
    if (type(Payload.c) == "table") then
        Payload.c = nil;
    end

    return {
        action = Payload.a or nil, -- Action
        content = Payload.b or nil, -- Content
        senderFqn = Payload.c or nil, -- Name of the sender
        correspondenceId = Payload.d or Payload.id, -- Response ID
        minimumVersion = Payload.m or nil, -- Minimum version recipient should have
        version = Payload.v or nil, -- Version of sender
        recipient = Payload.r or nil, -- Recipient (in case we route whisper through group)
    };
end
