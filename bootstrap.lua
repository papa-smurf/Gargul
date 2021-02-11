-- arg1 is the name off the addon, arg2 is the addon namespace
local appName, App = ...;

--[[ APP VERSION ]]
App.version = "2.1.2";

--[[ DEBUG MODE ]]
App.debugEnabled = false;

App.name = appName;
App._initialized = false;
App.clientUIinterface = 0;
App.clientVersion = 0;
App.isClassic = false;
App.DebugLines = {};

-- Register our addon with the Ace framework
App.Ace = LibStub("AceAddon-3.0"):NewAddon(App.name, "AceConsole-3.0", "AceComm-3.0", "AceSerializer-3.0", "AceTimer-3.0");

-- Bootstrap the addon
App.bootstrap = function(_, _, addonName)

    -- The addon was already bootstrapped or this is not the correct event
    if (App._initialized) then
        return;
    end

    -- We only want to continue bootstrapping
    -- when it's this addon that's succesfully loaded
    if (addonName ~= App.name) then
        return;
    end

    App:debug("App:bootstrap");

    -- The addon was loaded, we no longer need the event listener now
    App.eventFrame:UnregisterEvent("ADDON_LOADED");
    App.eventFrame = nil;

    -- Show a welcome message
    local successfullyLoadedMessage = "Sucessfully loaded (v" .. App.version .. ")";
    App:debug(string.format("Successfully loaded v%s", App.version));
    App:success("v" .. App:capitalize(App.version));

    -- Initialize our classes / services
    App:_init();
    App._initialized = true;
end

-- Callback to be fired when the addon is completely loaded
function App:_init()
    App:debug("App:_init");

    do
        local version, _, _, uiVersion = GetBuildInfo()

        App.clientUIinterface = uiVersion
        local expansion,majorPatch,minorPatch = (version or "3.0.0"):match("^(%d+)%.(%d+)%.(%d+)")
        App.clientVersion = (expansion or 0) * 10000 + (majorPatch or 0) * 100 + (minorPatch or 0)
    end

    if App.clientVersion < 30000 then
        App.isClassic = true
    end

    App.DB:_init();
    App.Settings:_init()
    App.Comm:_init();
    App.User:_init();
    App.LootPriority:_init();
    App.SoftReserves:_init();
    App.DroppedLoot:_init();
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
App.eventFrame = CreateFrame("FRAME");
App.eventFrame:RegisterEvent("ADDON_LOADED");
App.eventFrame:SetScript("OnEvent", App.bootstrap);