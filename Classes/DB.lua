---@type GL
local _, GL = ...;

---@type Events
local Events = GL.Events;

---@class DB
---@field AwardHistory table
---@field BoostedRolls table
---@field CommTrace table
---@field GDKP table
---@field LoadDetails table
---@field LootPriority table
---@field MinimapButton table
---@field PlusOnes table
---@field RecentlyAwardedItems table
---@field RollOff table
---@field Settings table
---@field SoftRes table
---@field TMB table
---@field Utility table
local DB = {
    _initialized = false,

    Tables = {
        "AwardHistory",
        "BoostedRolls",
        "CommTrace",
        "GDKP",
        "LoadDetails",
        "LootPriority",
        "MinimapButton",
        "PlusOnes",
        "RecentlyAwardedItems",
        "RollOff",
        "Settings",
        "SoftRes",
        "TMB",
        "Utility",
    },
};

---@type DB
GL.DB = DB;

local KnownTables = {};
for _, identifier in ipairs(DB.Tables) do
    KnownTables[identifier] = true;
end

--- Only tables listed in DB.Tables are saved, so refuse writes to anything else
---@param keyString string
---@return boolean
local function isKnownTable(keyString)
    local identifier = strmatch(tostring(keyString), "^[^.]+");
    if (KnownTables[identifier]) then
        return true;
    end

    GL:warning(("DB: '%s' is not in DB.Tables and won't be saved"):format(tostring(identifier)));
    return false;
end

function DB:_init()
    if (self._initialized) then
        return;
    end

    -- Should only be possible on first boot
    if (type(GargulDB) ~= "table") then
        GargulDB = {};
    end

    -- Prepare our saved variables and add a shortcut to each table
    for _, identifier in ipairs(self.Tables) do
        GargulDB[identifier] = GargulDB[identifier] or {};
        self[identifier] = GargulDB[identifier];
    end

    -- Fire DB:store before every logout/reload/exit
    Events:register("DBPlayerLogoutListener", "PLAYER_LOGOUT", function ()
        self:store();
    end);

    self._initialized = true;
end

---@param keyString string
---@return boolean
function DB:has(keyString)
    return GL:tableGet(self, keyString) ~= nil;
end

---@param keyString string
---@param default any
---@return any
function DB:get(keyString, default)
    return GL:tableGet(self, keyString, default);
end

---@param keyString string
---@param value any
---@param ignoreIfExists ?boolean If the given final key exists then it will not be overwritten
---@return boolean
function DB:set(keyString, value, ignoreIfExists)
    if (not isKnownTable(keyString)) then
        return false;
    end

    return GL:tableSet(self, keyString, value, ignoreIfExists);
end

---@param keyString string
---@param value any
---@return boolean
function DB:add(keyString, value)
    if (not isKnownTable(keyString)) then
        return false;
    end

    return GL:tableAdd(self, keyString, value);
end

--- Write our tables back to GargulDB, needed because some code replaces them (e.g. DB.TMB = {})
function DB:store()
    for _, identifier in ipairs(self.Tables) do
        GargulDB[identifier] = self[identifier];
    end
end
