local _, GL = ...;

GL.Player = {};
GL.Player.__index = GL.Player;

local Player = GL.Player;

-- This metatable allows us to have multiple instances of this object
setmetatable(Player, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

function Player._new()
    GL:debug("Player._new");

    local self = setmetatable({}, Player);
    return self;
end

-- Instantiate a new player object using a player's GUID
function Player.fromID(GUID)
    GL:debug("Player.fromID");

    if (not GUID or not type(GUID) == "string") then
        return GL:error("Invalid GUID provided for Player.fromID");
    end

    local self = Player._new();

    self.id = GUID;
    _, self.class, _, self.race, self.gender, self.name = GetPlayerInfoByGUID(self.id)

    -- The GUID turns out to be invalid, destroy the player object
    if (not self.name or not type(self.name) == "string") then
        self = nil;
        GL:error("Invalid GUID provided for Player.fromID: " .. GUID);
        return;
    end

    self.Guild = {};
    self.Guild.name, self.Guild.rank, self.Guild.index = GetGuildInfo(self.id);

    return self;
end

--- Instantiate a new player object using a player's FQN
---
---@param fqn string
---@return table|boolean
function Player:fromFqn(fqn)
    local parts = GL:strSplit(fqn, "-");
    local partCount = #parts;

    if (partCount == 1) then
        return self:fromName(fqn)
    elseif (partCount ~= 2) then
        return false
    end

    if (parts[2] == GL.User.realm) then
        return self:fromName(parts[1]);
    end

    return self:fromName(fqn);
end

-- Instantiate a new player object using a player's name
function Player:fromName(name)
    GL:debug("Player.fromName");

    if (not name or not type(name) == "string") then
        return false;
    end

    local playerId = UnitGUID(name);

    if (not playerId) then
        return false;
    end

    return Player.fromID(playerId);
end

-- Instantiate a new player object for the addon actor (current player)
function Player.fromActor()
    GL:debug("Player.fromActor");

    local playerId = UnitGUID("player");

    if (not playerId) then
        GL:warning("Unable to confirm identity of addon actor");
        return;
    end

    return Player.fromID(playerId);
end

GL:debug("Player.lua");