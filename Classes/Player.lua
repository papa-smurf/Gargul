local _, App = ...;

App.Player = {};
App.Player.__index = App.Player;

local Utils = App.Utils;
local Player = App.Player;

-- This metatable allows us to have multiple instances of this object
setmetatable(Player, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

function Player._new()
    Utils:debug("Player._new");

    local self = setmetatable({}, Player);
    return self;
end

-- Instantiate a new player object using a player's GUID
function Player.fromID(GUID)
    Utils:debug("Player.fromID");

    if (not GUID or not type(GUID) == "string") then
        return Utils:error("Invalid GUID provided for Player.fromID");
    end

    local self = Player._new();

    self.id = GUID;
    _, self.class, _, self.race, self.gender, self.name = GetPlayerInfoByGUID(self.id)

    -- The GUID turns out to be invalid, destroy the player object
    if (not self.name or not type(self.name) == "string") then
        self = nil;
        Utils:error("Invalid GUID provided for Player.fromID: " .. GUID);
        return;
    end

    self.Guild = {};
    self.Guild.name, self.Guild.rank, self.Guild.index = GetGuildInfo(self.id);

    return self;
end

-- Instantiate a new player object using a player's name
function Player.fromName(name)
    Utils:debug("Player.fromName");

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
    Utils:debug("Player.fromActor");

    local playerId = UnitGUID("player");

    if (not playerId) then
        Utils:warning("Unable to confirm identity of addon actor");
        return;
    end

    return Player.fromID(playerId);
end

Utils:debug("Player.lua");