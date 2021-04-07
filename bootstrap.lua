-- arg1 is the name of the addon, arg2 is the addon namespace
local appName, App = ...;

--[[ APP VERSION ]]
App.version = "2.2.3";

App.name = appName;
App._initialized = false;
App.clientUIinterface = 0;
App.clientVersion = 0;
App.isClassic = false;
App.DebugLines = {};
App.EventFrame = {};

-- Register our addon with the Ace framework
App.Ace = LibStub("AceAddon-3.0"):NewAddon(App.name, "AceConsole-3.0", "AceComm-3.0", "AceTimer-3.0");

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

    App.Utils:debug("App:bootstrap");

    -- The addon was loaded, we no longer need the event listener now
    App.EventFrame:UnregisterEvent("ADDON_LOADED");

    -- Show a welcome message
    local successfullyLoadedMessage = "Sucessfully loaded (v" .. App.version .. ")";
    App.Utils:debug(string.format("Successfully loaded v%s", App.version));
    App.Utils:success("v" .. App.Utils:capitalize(App.version));

    -- Initialize our classes / services
    App:_init();
    App._initialized = true;
end

-- Callback to be fired when the addon is completely loaded
function App:_init()
    App.Utils:debug("App:_init");

    do
        local version, _, _, uiVersion = GetBuildInfo()

        App.clientUIinterface = uiVersion
        local expansion,majorPatch,minorPatch = (version or "3.0.0"):match("^(%d+)%.(%d+)%.(%d+)")
        App.clientVersion = (expansion or 0) * 10000 + (majorPatch or 0) * 100 + (minorPatch or 0)
    end

    if App.clientVersion < 30000 then
        App.isClassic = true
    end

    -- Initialize classes
    App.Events:_init(App.EventFrame);
    App.DB:_init();
    App.Settings:_init()
    App.Comm:_init();
    App.User:_init();
    App.LootPriority:_init();
    App.AwardedLoot:_init();
    App.SoftReserves:_init();
    App.DroppedLoot:_init();
    App.PackMule:_init();

    -- Hook the bagslot events
    App:hookBagSlotEvents();
end

-- Register the gl slash command
App.Ace:RegisterChatCommand("gl", function (...)
    App.Commands:_dispatch(...);
end)

-- Hook the bag slot events making it possible to alt(+shift) click
-- items in bags to either start rolling or auctioning them off
function App:hookBagSlotEvents()
    hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", function(self, mouseButtonPressed)
        local bag, slot = self:GetParent():GetID(), self:GetID();
        local itemLink = select(7, GetContainerItemInfo(bag, slot));

        if (not itemLink or type(itemLink) ~= "string") then
            return;
        end

        if (mouseButtonPressed == "LeftButton"
                and IsAltKeyDown()
        ) then
            if (IsShiftKeyDown()) then
                App.AuctioneerUI:draw(itemLink);
            else
                App.MasterLooterUI:draw(itemLink);
            end
        end
    end);
end

-- Fire App.bootstrap every time an addon is loaded
App.EventFrame = CreateFrame("FRAME");
App.EventFrame:RegisterEvent("ADDON_LOADED");
App.EventFrame:SetScript("OnEvent", App.bootstrap);