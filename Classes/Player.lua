local _, GL = ...;

---@class Player
GL.Player = {
    playerClassByName = {},
};
GL.Player.__index = GL.Player;

---@type Player
local Player = GL.Player;

setmetatable(Player, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

---@return Player
function Player._new()
    GL:debug("Player._new");

    local self = setmetatable({}, Player);
    return self;
end

--- Instantiate a new player object using a player's GUID
---
---@param GUID string
---@return boolean|Player
function Player.fromID(GUID)
    GL:debug("Player.fromID");

    if (not GUID or not type(GUID) == "string") then
        GL:error("Invalid GUID provided for Player.fromID");
        return false;
    end

    local self = Player._new();

    self.id = GUID;
    self.localizedClass, self.class, self.localizedRace, self.race, self.gender, self.name, self.realm = GetPlayerInfoByGUID(self.id);
    self.realm = not GL:empty(self.realm) and self.realm or GL.User.realm;
    self.fqn = GL:addRealm(self.name, self.realm);
    self.race = string.lower(self.race);

    -- The GUID turns out to be invalid, destroy the player object
    if (not self.name or not type(self.name) == "string") then
        self = nil;
        GL:error("Invalid GUID provided for Player.fromID: " .. GUID);
        return false;
    end

    self.classFile = string.upper(self.class);

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

--- Instantiate a new player object using a player's name (also accepts FQNs)
---
---@param name string
---@return boolean|Player
function Player:fromName(name)
    GL:debug("Player.fromName");

    if (not name or not type(name) == "string") then
        return false;
    end

    name = GL:nameFormat(name);
    local playerId = UnitGUID(name);

    if (not playerId) then
        return false;
    end

    return Player.fromID(playerId);
end

--- Instantiate a new player object for the addon actor (current player)
---
---@return boolean|Player
function Player.fromActor()
    GL:debug("Player.fromActor");

    local playerId = UnitGUID("player");

    if (not playerId) then
        GL:warning("Unable to confirm identity of addon actor");
        return false;
    end

    return Player.fromID(playerId);
end

--- Returns true of player has lead or assist
---
---@param playerNameOrID string
---@return boolean
function Player:hasAssist(playerNameOrID)
    if (type(playerNameOrID) ~= "string") then
        return false;
    end

    local playerName = playerNameOrID;
    local realm, _;
    if (GL:strStartsWith(playerNameOrID, "Player-")) then
        _, _, _, _, _, playerName, realm = GetPlayerInfoByGUID(playerNameOrID);
        playerName = GL:nameFormat{ name = playerName, realm = realm };
    else
        playerName = GL:nameFormat(playerNameOrID);
    end

    if (not playerName) then
        return false;
    end

    -- If the player is not in our group then we're done checking
    if (not GL.User:unitInGroup(playerName)) then
        return false;
    end

    -- Check if the player has lead or assist
    local maximumNumberOfGroupMembers = GL.User.isInRaid and _G.MAX_RAID_MEMBERS or _G.MEMBERS_PER_RAID_GROUP;
    for index = 1, maximumNumberOfGroupMembers do
        local name, rank = GetRaidRosterInfo(index);

        -- Rank 1 = assist, 2 = lead
        if (name == playerName) then
            return rank > 0;
        end
    end

    return false;
end

--- Returns true of player has lead
---
---@param playerNameOrID string
---@return boolean
function Player:hasLead(playerNameOrID)
    if (type(playerNameOrID) ~= "string") then
        return false;
    end

    local playerName = playerNameOrID;
    local realm, _;
    if (GL:strStartsWith(playerNameOrID, "Player-")) then
        _, _, _, _, _, playerName, realm = GetPlayerInfoByGUID(playerNameOrID);
        playerName = GL:nameFormat{ name = playerName, realm = realm };
    end

    if (not playerName) then
        return false;
    end

    -- If the player is not in our group then we're done checking
    if (not GL.User:unitInGroup(playerName)) then
        return false;
    end

    -- Check if the player has lead or assist
    local maximumNumberOfGroupMembers = GL.User.isInRaid and _G.MAX_RAID_MEMBERS or _G.MEMBERS_PER_RAID_GROUP;
    for index = 1, maximumNumberOfGroupMembers do
        local name, rank = GetRaidRosterInfo(index);

        -- Rank 1 = assist, 2 = lead
        if (GL:iEquals(GL:nameFormat(name), playerName)) then
            return rank == 2;
        end
    end

    return false;
end

--- Returns true of player is the master looter
---
---@param playerNameOrID string
---@return boolean
function Player:isMasterLooter(playerNameOrID)
    if (type(playerNameOrID) ~= "string") then
        return false;
    end

    local playerName = playerNameOrID;
    local realm, _;
    if (GL:strStartsWith(playerNameOrID, "Player-")) then
        _, _, _, _, _, playerName, realm = GetPlayerInfoByGUID(playerNameOrID);
        playerName = GL:nameFormat{ name = playerName, realm };
    else
        playerName = GL:nameFormat(playerNameOrID);
    end

    if (not playerName) then
        return false;
    end

    -- If the player is not in our group then we're done checking
    if (not GL.User:unitInGroup(playerName)) then
        return false;
    end

    local lootMethod, masterLooterPartyID, masterLooterRaidID = GetLootMethod();

    -- Master looting is active and this player is the master looter
    if (lootMethod == 'master') then
        local ID = masterLooterPartyID or masterLooterRaidID;
        return GL:iEquals(GetRaidRosterInfo(ID), GL:nameFormat(playerName));
    end

    return false;
end

--- Fetch a player's class by a given player name
---
---@param playerName string
---@param default string|nil
---@return string
function Player:classByName(playerName, default)
    GL:debug("Player:classByName");

    if (type(default) == "nil") then
        default = "priest";
    end

    playerName = GL:nameFormat{ name = playerName, func = strlower };

    -- We already know this player's class name, return it
    if (self.playerClassByName[playerName]) then
        return self.playerClassByName[playerName];
    end

    -- Attempt to fetch the player class
    local classFile = UnitClassBase(playerName);

    -- Player names can be stored for the entire session since
    -- it's impossible for them to change during runtime
    if (type(classFile) == "string"
        and not GL:empty(classFile)
    ) then
        if (GL.Data.Constants.UnitClasses[string.upper(classFile)]) then
            self.playerClassByName[playerName] = string.lower(classFile);
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

    if (GL:empty(class)) then
        return;
    end

    self.playerClassByName[string.lower(playerName)] = class;
end

GL:debug("Player.lua");