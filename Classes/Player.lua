local _, GL = ...;

GL.Player = {
    playerClassByName = {},
};
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
    self.localizedClass, self.class, self.localizedRace, self.race, self.gender, self.name = GetPlayerInfoByGUID(self.id);
    self.race = string.lower(self.race);

    -- The GUID turns out to be invalid, destroy the player object
    if (not self.name or not type(self.name) == "string") then
        self = nil;
        GL:error("Invalid GUID provided for Player.fromID: " .. GUID);
        return;
    end

    self.class = string.lower(self.class);

    self.Guild = {};

    -- GetGuildInfo(yourOwnID) doesn't work for yourself.. silly Blizzard
    if (self.id == GL.User.id or not GL.User.isInGroup) then
        self.Guild.name = GL.User.Guild.name;
        self.Guild.rank = GL.User.Guild.rank;
        self.Guild.index = GL.User.Guild.index;
    elseif (GL.User.isInGroup) then
        for _, Member in pairs(GL.User:groupMembers()) do
            if (Member.name == self.name) then
                local groupType = "raid";
                local groupIndex = Member.index;

                if (not GL.User.isInRaid) then
                    groupIndex = groupIndex - 1;
                    groupType = "party";
                end

                self.Guild.name, self.Guild.rank, self.Guild.index = GetGuildInfo(groupType .. groupIndex);
                break;
            end
        end
    end

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

--- Fetch a player's class by a given player name
---
---@param playerName string
---@param default string|nil
---@return string
function Player:classByName(playerName, default)
    if (type(default) == "nil") then
        default = "priest";
    end

    playerName = string.lower(playerName);

    -- We already know this player's class name, return it
    if (self.playerClassByName[playerName]) then
        return self.playerClassByName[playerName];
    end

    -- Attempt to fetch the player class
    local _, playerClass = UnitClass(playerName);

    -- Player names can be stored for the entire session since
    -- it's impossible for them to change during runtime
    if (type(playerClass) == "string"
        and not GL:empty(playerClass)
    ) then
        playerClass = string.lower(playerClass);

        if (GL.Data.Constants.Classes[playerClass]) then
            self.playerClassByName[playerName] = string.lower(playerClass);
        end
    end

    return self.playerClassByName[playerName] or default;
end

--- Cache a player's class
---
---@param playerName string
---@param class string
function Player:cacheClass(playerName, class)
    if (type(class) ~= "string") then
        return;
    end

    class = string.lower(class);

    if (not GL.Data.Constants.Classes[class]) then
        return;
    end

    self.playerClassByName[string.lower(playerName)] = class;
end

GL:debug("Player.lua");