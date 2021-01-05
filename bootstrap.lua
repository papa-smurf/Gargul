-- arg1 is the name off the addon, arg2 is the addon namespace
local appName, App = ...;

-- Register our addon with the Ace framework
App.Ace = LibStub("AceAddon-3.0"):NewAddon("Gargul", "AceConsole-3.0", "AceComm-3.0", "AceSerializer-3.0", "AceTimer-3.0");

App.name = appName;
App.version = "1.0.2";
App.debugEnabled = false;

App._initialized = false;
App.DebugLines = {};

-- Bootstrap the addon
App.bootstrap = function(...)
    -- The addon was already bootstrapped
    if (App._initialized) then
        return;
    end

    -- The loaded addon name is in the third position
    local addonName = select(3, ...);

    -- We only want to continue bootstrapping
    -- when this addon is succesfully loaded
    if (addonName ~= App.name) then
        return;
    end

    App:debug("App:bootstrap");

    -- The addon was loaded, we no longer need the event listener now
    App.bootstrapEvents:UnregisterEvent("ADDON_LOADED");
    App.bootstrapEvents = nil;

    -- Show a welcome message
    local successfullyLoadedMessage = "Sucessfully loaded (v" .. App.version .. ")";
    App:debug(successfullyLoadedMessage);

    -- Initialize our classes / services
    App:_init();
    App._initialized = true;
end

-- Callback to be fired when the addon is completely loaded
function App:_init()
    App:debug("App:_init");

    App.DB:_init();
    App.Settings:_init()
    App.Comm:_init();
    App.User:_init();
    App.LootPriority:_init();
end

function App.Ace:OnInitialize()
    App:debug("App.Ace:OnInitialize");

    App.Compressor = LibStub:GetLibrary("LibCompress");
    App.Compressor.EncodeTable = App.Compressor:GetAddonEncodeTable();
end

App.Ace:RegisterChatCommand("gl", function (...)
    App.Commands:_dispatch(...);
end)

-- Fire App.bootstrap every time an addon is loaded
App.bootstrapEvents = CreateFrame("FRAME");
App.bootstrapEvents:RegisterEvent("ADDON_LOADED");
App.bootstrapEvents:SetScript("OnEvent", App.bootstrap);