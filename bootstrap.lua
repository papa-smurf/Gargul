-- arg1 is the name of the addon, arg2 is the addon namespace
---@class Bootstrapper
local appName, GL = ...;
_G.Gargul = GL; -- Open Gargul up to other developer integrations

GL.name = appName;
GL._initialized = false;
GL.clientUIinterface = 0;
GL.clientVersion = 0;
GL.firstBoot = false; -- Indicates whether the user is new to Gargul
GL.isEra = false;
GL.isRetail = false;
GL.isClassic = false;
GL.version = GetAddOnMetadata(GL.name, "Version");
GL.DebugLines = {};
GL.EventFrame = {};
GL.loadedOn = 32503680000; -- Year 3000

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

    -- Mark the add-on as fully loaded
    GL.loadedOn = GetServerTime();
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
    self.Version:_init();
    self.Settings:_init();

    -- Show a welcome message
    if (self.Settings:get("welcomeMessage")) then
        print(string.format(
            "|cff%sGargul v%s|r by Zhorax@Firemaw. Type |cff%s/gl|r or |cff%s/gargul|r to get started!",
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
    self.GDKP:_init();
    self.TMB:_init();
    self.BoostedRolls:_init();
    self.DroppedLoot:_init();
    self.GroupLoot:_init();
    self.PackMule:_init();
    self.TradeWindow:_init();
    self.Interface.MasterLooterDialog:_init();
    self.Interface.TradeWindow.TimeLeft:_init();

    -- Hook the bagslot events
    self:hookBagSlotEvents();

    -- Make sure to initialize the user last
    self.User:refresh();

    -- Makes testing easier for devs
    if (self.User:isDev()) then
        -- Make sure we keep the command descriptions up-to-date during development
        for command in pairs(GL.Commands.Dictionary) do
            if (not GL.Commands.CommandDescriptions[command]) then
                GL:error("Missing description for command: " .. command);
            end
        end
    end

    -- Show the changelog window
    GL.Interface.Changelog:reportChanges();

---@todo: remove

    --Gargul_ContainedAlertFrameMixin = {};
    --Gargul_ContainedAlertFrameMixin.OnPostShow = ContainedAlertFrameMixin.OnPostShow;
    --Gargul_ContainedAlertFrameMixin.OnPostHide = ContainedAlertFrameMixin.OnPostHide;
    --Gargul_ContainedAlertFrameMixin.SetAlertContainer = ContainedAlertFrameMixin.SetAlertContainer;
    --Gargul_ContainedAlertFrameMixin.GetAlertContainer = ContainedAlertFrameMixin.GetAlertContainer;
    --Gargul_ContainedAlertFrameMixin.OnManagedAlertFrameVisibilityChanged = ContainedAlertFrameMixin.OnManagedAlertFrameVisibilityChanged;
    --Gargul_ContainedAlertFrameMixin.ManagesOwnOutroAnimation = ContainedAlertFrameMixin.ManagesOwnOutroAnimation;
    --Gargul_ContainedAlertFrameMixin.SetExternallyManagedOutroAnimation = ContainedAlertFrameMixin.SetExternallyManagedOutroAnimation;
    --
    ---- /script _G.alertFrameTester()
    --local NotificationLoader = AlertFrame:AddSimpleAlertFrameSubSystem("DKPReceivedAlertFrameTemplate", function (self) self.Amount:SetText("69 DKP. Nice!"); end, 6, 6, function () end);
    --_G.alertFrameTester = function() NotificationLoader:AddAlert(); end;
    -- /script _G.gargultest();
    _G.gargultest = function () self.Events:fire("GL.SOFTRES_IMPORTED"); end;

    if (true) then return; end

    local Notification = function (self)
        self.Amount:SetText("TEST");
    end;

    local NotificationSystem = AlertFrame:AddSimpleAlertFrameSubSystem("GargulBidAccepted", Notification, 6, 6), function () end;

    -- /script _G.Gargul:alertMe()
    GL.alertMe = function()
        GL:dump("NOW!");

        NotificationSystem:AddAlert();
    end

    -- /script _G.Gargul:alertMe2()
    GL.alertMe2 = function ()
        GL:dump("NOW 2!");

        NotificationLoader:AddAlert();
    end
end

-- Register the gl slash command
GL.Ace:RegisterChatCommand("gl", function (...)
    GL.Commands:_dispatch(...);
end);

-- Register the gargul slash command
GL.Ace:RegisterChatCommand("gargul", function (...)
    GL.Commands:_dispatch(...);
end);

-- Register the gdkp slash command
GL.Ace:RegisterChatCommand("gdkp", function (...)
    GL.Interface.GDKP.Overview:draw();
end);

--- Announce conflicting addons if any
---@return void
function GL:announceConflictingAddons()
    local ConflictingAddons = {};
    for _, addon in pairs(GL.Data.Constants.GargulConflictsWith) do
        if (IsAddOnLoaded(addon)) then
            tinsert(ConflictingAddons, addon);
        end
    end

    -- Check whether the player has ElvUI with the "Improve Loot" setting enabled.. We don't like that one bit, no no
    if(IsAddOnLoaded("ElvUI")
        and _G.ElvPrivateDB
    ) then
        local elvUILootSetting = GL:tableGet(_G.ElvPrivateDB, string.format("profiles.%s - %s.general.loot", GL.User.name, GL.User.realm));

        if (elvUILootSetting ~= nil
            and elvUILootSetting
        ) then
            GL:error("When using ElvUI you need to disable the loot improvement setting in order to be able to use Gargul to its full potential. Type /elvui, go to General > BlizzUI Improvements and disable 'Loot'");
        end
    end

    -- Nothing found, steady as she goes
    if (GL:empty(ConflictingAddons)) then
        return;
    end

    GL:warning(string.format(
        "You have one or more addons installed that interact with the loot window. If you don't disable them you might experience strange behavior with Gargul's looting features. These are the potentially conflicting addons: %s",
        table.concat(ConflictingAddons, ", ")
    ));
end

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
---@todo: Fixie fix
            GL.Interface.GDKP.Auctioneer:draw(itemLink);
            --GL.MasterLooterUI:draw(itemLink);

        -- Open the award window
        elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.award")) then
            GL.Interface.Award:draw(itemLink);
        end
    end);
end

--[[ CREATE NECESSARY FRAMES ]]

-- Fire GL.bootstrap every time an addon is loaded
GL.EventFrame = CreateFrame("FRAME", "GargulEventFrame");
GL.EventFrame:RegisterEvent("ADDON_LOADED");
GL.EventFrame:SetScript("OnEvent", function (...) GL:bootstrap(...); end);

-- Frame that we can bind tooltips to to check item details
GL.TooltipFrame = CreateFrame("GameTooltip", "GargulTooltipFrame", nil, "GameTooltipTemplate");
GL.TooltipFrame:SetOwner(WorldFrame, "ANCHOR_NONE");