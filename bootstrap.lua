-- arg1 is the name of the addon, arg2 is the addon namespace
---@class Bootstrapper
local appName, GL = ...;

GL.name = appName;
GL._initialized = false;
GL.clientUIinterface = 0;
GL.clientVersion = 0;
GL.isEra = false;
GL.isRetail = false;
GL.isClassic = false;
GL.testMode = false;
GL.version = GetAddOnMetadata(GL.name, "Version");
GL.DebugLines = {};
GL.EventFrame = {};

-- Register our addon with the Ace framework
GL.Ace = LibStub("AceAddon-3.0"):NewAddon(GL.name, "AceConsole-3.0", "AceComm-3.0", "AceTimer-3.0");

-- Bootstrap the addon
function GL:bootstrap(_, _, addonName)
    -- The addon was already bootstrapped or this is not the correct event
    if (self._initialized) then
        return;
    end

    -- We only want to continue bootstrapping
    -- when it's this addon that's successfully loaded
    if (addonName ~= self.name) then
        return;
    end

    self:debug("GL:bootstrap");

    -- The addon was loaded, we no longer need the event listener now
    self.EventFrame:UnregisterEvent("ADDON_LOADED");

    -- Initialize our classes / services
    self:_init();
    self._initialized = true;

    -- Add the minimap icon
    self.MinimapButton:_init();
end

--- Callback to be fired when the addon is completely loaded
---
---@return void
function GL:_init()
    self:debug("GL:_init");

    do
        local version, _, _, uiVersion = GetBuildInfo();

        self.clientUIinterface = uiVersion;
        local expansion,majorPatch,minorPatch = (version or "3.0.0"):match("^(%d+)%.(%d+)%.(%d+)");
        self.clientVersion = (expansion or 0) * 10000 + (majorPatch or 0) * 100 + (minorPatch or 0);
    end

    if self.clientVersion < 20000 then
        self.isEra = true;
    elseif self.clientVersion < 90000 then
        self.isClassic = true;
    else
        self.isRetail = true;
    end

    -- Initialize classes
    self.Events:_init(self.EventFrame);
    self.DB:_init();
    self.Settings:_init();

    -- Show a welcome message
    if (self.Settings:get("welcomeMessage")) then
        print(string.format(
            "|cff%sGargul v%s|r by Zhorax@Razorgore. Type |cff%s/gl|r or |cff%s/gargul|r to get started!",
            self.Data.Constants.addonHexColor,
            self.version,
            self.Data.Constants.addonHexColor,
            self.Data.Constants.addonHexColor
        ))
    end

    if (self.Settings:get("fixMasterLootWindow")) then
        --[[
            This fix was discovered by Kirsia-Dalaran. More info here: https://bit.ly/3tc8nvw
        ]]--

        hooksecurefunc(MasterLooterFrame, 'Hide', function(self) self:ClearAllPoints() end);
    end

    self.Comm:_init();
    self.User:_init();
    self.LootPriority:_init();
    self.AwardedLoot:_init();
    self.SoftRes:_init();
    self.TMB:_init();
    self.DroppedLoot:_init();
    self.GroupLoot:_init();
    self.PackMule:_init();
    self.Interface.MasterLooterDialog:_init();

    -- Hook the bagslot events
    self:hookBagSlotEvents();
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

        local keyPressIdentifier = GL.Events:getClickCombination(mouseButtonPressed);

        -- Open the roll window
        if (keyPressIdentifier == GL.Settings:get("ShortcutKeys.rollOff")) then
            GL.MasterLooterUI:draw(itemLink);

        -- Open the award window
        elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.award")) then
            GL.Interface.Award:draw(itemLink);
        end
    end);
end

-- Fire GL.bootstrap every time an addon is loaded
GL.EventFrame = CreateFrame("FRAME");
GL.EventFrame:RegisterEvent("ADDON_LOADED");
GL.EventFrame:SetScript("OnEvent", function (...) GL:bootstrap(...); end);