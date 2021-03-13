local _, App = ...;

App.Player = {};
App.Player.__index = App.Player;

-- This metatable allows us to have multiple instances of this object
setmetatable(App.Player, {
    __call = function (cls, ...)
        return cls.new(...)
    end,
})

function App.Player._new()
    App:debug("App.Player._new");

    local self = setmetatable({}, App.Player);
    return self;
end

-- Instantiate a new player object using a player's GUID
function App.Player.fromID(GUID)
    App:debug("App.Player.fromID");

    if (not GUID or not type(GUID) == "string") then
        return App:error("Invalid GUID provided for App.Player.fromID");
    end

    local self = App.Player._new();

    self.id = GUID;
    _, self.class, _, self.race, self.gender, self.name = GetPlayerInfoByGUID(self.id)

    -- The GUID turns out to be invalid, destroy the player object
    if (not self.name or not type(self.name) == "string") then
        self = nil;
        App:error("Invalid GUID provided for App.Player.fromID: " .. GUID);
        return;
    end

    self.Guild = {};
    self.Guild.name, self.Guild.rank, self.Guild.index = GetGuildInfo(self.id);

    return self;
end

-- Instantiate a new player object using a player's name
function App.Player.fromName(name)
    App:debug("Player:fromName");

    if (not name or not type(name) == "string") then
        return false;
    end

    local playerId = UnitGUID(name);

    if (not playerId) then
        return false;
    end

    return App.Player.fromID(playerId);
end

-- Instantiate a new player object for the addon actor (current player)
function App.Player.fromActor()
    App:debug("Player:fromName");

    local playerId = UnitGUID("player");

    if (not playerId) then
        App:warning("Unable to confirm identity of addon actor");
        return;
    end

    return App.Player.fromID(playerId);
end

App:debug("Player.lua");