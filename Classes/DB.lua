---@type GL
local _, GL = ...;

---@class DB
GL.DB = {
    _initialized = false,
    AwardHistory = {},
    Cache = {},
    LootPriority = {},
    MinimapButton = {},
    PlusOnes = {},
    Settings = {},
    LoadDetails = {},
    SoftRes = {},
    TMB = {},
    BoostedRolls = {},
};

local DB = GL.DB;

function DB:_init()
    GL:debug("DB:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    if (not GargulDB or not type(GargulDB) == "table") then
        GargulDB = {};
    end

    -- Prepare our database tables
    GargulDB.AwardHistory = GargulDB.AwardHistory or {};
    GargulDB.LootPriority = GargulDB.LootPriority or {};
    GargulDB.MinimapButton = GargulDB.MinimapButton or {};
    GargulDB.PlusOnes = GargulDB.PlusOnes or {};
    GargulDB.Settings = GargulDB.Settings or {};
    GargulDB.LoadDetails = GargulDB.LoadDetails or {};
    GargulDB.SoftRes = GargulDB.SoftRes or {};
    GargulDB.TMB = GargulDB.TMB or {};
    GargulDB.BoostedRolls = GargulDB.BoostedRolls or {};

    -- Provide a shortcut for each table
    self.AwardHistory = GargulDB.AwardHistory;
    self.LootPriority = GargulDB.LootPriority;
    self.MinimapButton = GargulDB.MinimapButton;
    self.PlusOnes = GargulDB.PlusOnes;
    self.Settings = GargulDB.Settings;
    self.LoadDetails = GargulDB.LoadDetails;
    self.SoftRes = GargulDB.SoftRes;
    self.TMB = GargulDB.TMB;
    self.BoostedRolls = GargulDB.BoostedRolls;

    -- Fire DB:store before every logout/reload/exit
    GL.Events:register("DBPlayerLogoutListener", "PLAYER_LOGOUT", self.store);

    self._initialized = true;
end

--- Make sure the database persists between sessions
--- This is just a safety precaution and should strictly
--- speaking not be necessary, but hey you never know!
function DB:store()
    GL:debug("DB:store");

    GargulDB.AwardHistory = GL.DB.AwardHistory;
    GargulDB.LootPriority = GL.DB.LootPriority;
    GargulDB.MinimapButton = GL.DB.MinimapButton;
    GargulDB.PlusOnes = GL.DB.PlusOnes;
    GargulDB.Settings = GL.Settings.Active;
    GargulDB.LoadDetails = GL.DB.LoadDetails;
    GargulDB.SoftRes = GL.DB.SoftRes;
    GargulDB.TMB = GL.DB.TMB;
    GargulDB.BoostedRolls = GL.DB.BoostedRolls;
end

-- Get a value from the database, or return a default if it doesn't exist
function DB:get(keyString, default)
    return GL:tableGet(DB, keyString, default);
end

-- Set a database value by a given key and value
function DB:set(keyString, value)
    return GL:tableSet(DB, keyString, value);
end

-- Reset the tables
function DB:reset()
    GL:debug("DB:reset");

    self.AwardHistory = {};
    self.LootPriority = {};
    self.MinimapButton = {};
    self.PlusOnes = {};
    self.Settings = {};
    self.LoadDetails = {};
    self.SoftRes = {};
    self.TMB = {};
    self.BoostedRolls = {};

    GL:success("Tables reset");
end

GL:debug("DB.lua");