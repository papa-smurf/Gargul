---@type GL
local _, GL = ...;

---@type Events
local Events = GL.Events;

---@class DB
GL.DB = {
    _initialized = false,

    Tables = {
        "AwardHistory",
        "BoostedRolls",
        "GDKP",
        "LoadDetails",
        "LootPriority",
        "MinimapButton",
        "PlusOnes",
        "RecentlyAwardedItems",
        "Settings",
        "SoftRes",
        "TMB",
        "Utility",
    },
};

---@type DB
local DB = GL.DB;

---@return void
function DB:_init()
    if (self._initialized) then
        return;
    end

    -- Should only be possible on first boot
    if (not GargulDB or not type(GargulDB) == "table") then
        GargulDB = {};
    end

    -- Prepare our saved variables and add a shortcut to each table
    for _, identifier in pairs(self.Tables or {}) do
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
---@param default any
---@return any
function DB:get(keyString, default)
    return GL:tableGet(self, keyString, default);
end

---@param keyString string
---@param value any
---@param ignoreIfExists boolean If the given final key exists then it will not be overwritten
---@return boolean
function DB:set(keyString, value, ignoreIfExists)
    return GL:tableSet(self, keyString, value, ignoreIfExists);
end

---@param keyString string
---@param value any
---@return boolean
function DB:add(keyString, value)
    return GL:tableAdd(self, keyString, value);
end

--- Make extra(?) sure the database persists between sessions
--- This is just a safety precaution and should strictly
--- speaking not be necessary at all, but hey you never know!
---
---@return void
function DB:store()
    for _, identifier in pairs(self.Tables or {}) do
        GargulDB[identifier] = self[identifier];
    end
end
