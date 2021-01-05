--[[
    This class handles the addon's SavedVariables tables
    self.Characters is a shortcut for GargulDB.Characters *
    self.LootHistory is a shortcut for GargulDB.LootHistory *

    This class also provides functionality for
    compressing/decompressing our tables and checking their integrity

    *   Using these shortcuts makes persistency between game sessions
        buggy which is why we call DB:store before every logout
]]

local _, App = ...;

App.Settings = {
    _initialized = false,
    Defaults = App.Data.Constants.Settings,
    Active = {}, -- This object holds the actual setting values applicable to this runtime
};

local Settings = App.Settings;

function Settings:_init()
    App:debug("Settings:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- Combine defaults and user settings
    self:overrideDefaultsWithUserSettings();

    self._initialized = true;
end

function Settings:overrideDefaultsWithUserSettings()
    App:debug("Settings:overrideDefaultsWithUserSettings");

    -- Combine the default setings and user's settings to one settings table
    Settings = App:tableMerge(Settings.Defaults, App.DB.Settings);

    -- Set the values of the settings table directly on the App.Settings table.
    for key, value in pairs(Settings) do
        self.Active[key] = value;
    end

    App.DB.Settings = self.Active;
end

-- Get a setting by a given key. Use dot notation to traverse multiple levels e.g:
-- Settings.UI.Auctioneer.offsetX can be fetched using Settings:get("Settings.UI.Auctioneer.offsetX")
-- without having to worry about tables or keys existing yes or no.
function Settings:get(keyString, default)
    return App:tableGet(self.Active, keyString, default);
end

-- Set a setting by a given key and value. Use dot notation to traverse multiple levels e.g:
-- Settings.UI.Auctioneer.offsetX can be set using Settings:set("Settings.UI.Auctioneer.offsetX", myValue)
-- without having to worry about tables or keys existing yes or no.
function Settings:set(keyString, value)
    return App:tableSet(self.Active, keyString, value);
end

App:debug("Settings.lua");