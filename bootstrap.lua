-- arg1 is the name of the addon, arg2 is the addon namespace
---@class Bootstrapper
local appName, GL = ...;

--[[ APP VERSION ]]
GL.version = "3.1.5";

GL.name = appName;
GL._initialized = false;
GL.clientUIinterface = 0;
GL.clientVersion = 0;
GL.isEra = false;
GL.isRetail = false;
GL.isClassic = false;
GL.testMode = false;
GL.DebugLines = {};
GL.EventFrame = {};

-- Register our addon with the Ace framework
GL.Ace = LibStub("AceAddon-3.0"):NewAddon(GL.name, "AceConsole-3.0", "AceComm-3.0", "AceTimer-3.0");

-- Bootstrap the addon
GL.bootstrap = function(_, _, addonName)
    -- The addon was already bootstrapped or this is not the correct event
    if (GL._initialized) then
        return;
    end

    -- We only want to continue bootstrapping
    -- when it's this addon that's successfully loaded
    if (addonName ~= GL.name) then
        return;
    end

    GL:debug("GL:bootstrap");

    -- The addon was loaded, we no longer need the event listener now
    GL.EventFrame:UnregisterEvent("ADDON_LOADED");

    -- Initialize our classes / services
    GL:_init();
    GL._initialized = true;

    -- Add the minimap icon
    GL.MinimapButton:_init();
end

-- Callback to be fired when the addon is completely loaded
function GL:_init()
    GL:debug("GL:_init");

    do
        local version, _, _, uiVersion = GetBuildInfo()

        GL.clientUIinterface = uiVersion
        local expansion,majorPatch,minorPatch = (version or "3.0.0"):match("^(%d+)%.(%d+)%.(%d+)")
        GL.clientVersion = (expansion or 0) * 10000 + (majorPatch or 0) * 100 + (minorPatch or 0)
    end

    if GL.clientVersion < 20000 then
        GL.isEra = true;
    elseif GL.clientVersion < 90000 then
        GL.isClassic = true;
    else
        GL.isRetail = true;
    end

    -- Initialize classes
    GL.Events:_init(GL.EventFrame);
    GL.DB:_init();
    GL.Settings:_init();

    -- Show a welcome message
    if (GL.Settings:get("welcomeMessage")) then
        print(string.format(
            "|cff%sGargul v%s|r by Zhorax@Razorgore. Type |cff%s/gl|r or |cff%s/gargul|r to get started!",
            GL.Data.Constants.addonHexColor,
            GL.version,
            GL.Data.Constants.addonHexColor,
            GL.Data.Constants.addonHexColor
        ))
    end

    GL.Comm:_init();
    GL.User:_init();
    GL.LootPriority:_init();
    GL.AwardedLoot:_init();
    GL.SoftRes:_init();
    GL.TMB:_init();
    GL.DroppedLoot:_init();
    GL.GroupLoot:_init();
    GL.PackMule:_init();

    -- Hook the bagslot events
    GL:hookBagSlotEvents();
end

-- Register the gl slash command
GL.Ace:RegisterChatCommand("gl", function (...)
    GL.Commands:_dispatch(...);
end)

-- Register the gargul slash command
GL.Ace:RegisterChatCommand("gargul", function (...)
    GL.Commands:_dispatch(...);
end)

-- Hook the bag slot events making it possible to alt(+shift) click
-- items in bags to either start rolling or auctioning them off
function GL:hookBagSlotEvents()
    hooksecurefunc("ContainerFrameItemButton_OnModifiedClick", function(self, mouseButtonPressed)
        local bag, slot = self:GetParent():GetID(), self:GetID();
        local itemLink = select(7, GetContainerItemInfo(bag, slot));

        if (not itemLink or type(itemLink) ~= "string") then
            return;
        end

        if (mouseButtonPressed == "LeftButton"
            and IsAltKeyDown()
        ) then
            -- Open the award window if both alt and shift are pressed
            if (IsShiftKeyDown()) then
                GL.Interface.Award:draw(itemLink);

            -- Open the default roll window
            else
                GL.MasterLooterUI:draw(itemLink);
            end
        end
    end);
end

-- Fire GL.bootstrap every time an addon is loaded
GL.EventFrame = CreateFrame("FRAME");
GL.EventFrame:RegisterEvent("ADDON_LOADED");
GL.EventFrame:SetScript("OnEvent", GL.bootstrap);