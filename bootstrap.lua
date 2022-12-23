-- arg1 is the name of the addon, arg2 is the addon namespace
---@class Bootstrapper
local appName, GL = ...;
_G.Gargul = GL; -- Open Gargul up to other developer integrations

GL.name = appName;
GL._initialized = false;
GL.clientUIinterface = 0;
GL.clientVersion = 0;
GL.elvUILoaded = false;
GL.firstBoot = false; -- Indicates whether the user is new to Gargul
GL.isEra = false;
GL.isRetail = false;
GL.isClassic = false;
GL.clientIsDragonFlightOrLater = false;
GL.version = GetAddOnMetadata(GL.name, "Version");
GL.DebugLines = {};
GL.EventFrame = nil;
GL.auctionHouseIsShown = false
GL.bankIsShown = false
GL.guildBankIsShown = false
GL.mailIsShown = false
GL.merchantIsShown = false
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

    -- Draw the profiler if enabled
    if (GL.Settings:get("profilerEnabled")) then
        GL.Profiler:draw();
    end

    -- Add the minimap icon
    self.MinimapButton:_init();

    -- Mark the add-on as fully loaded
    GL.loadedOn = GetServerTime();

    GL.Ace:ScheduleTimer(function()
        self.elvUILoaded = GetAddOnEnableState(nil,"ElvUI") == 2;
    end, 1);
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

    if (self.clientVersion) < 20000 then
        self.isEra = true;
    elseif (self.clientVersion) < 90000 then
        self.isClassic = true;
    else
        if (self.clientVersion >= 100000) then
            self.clientIsDragonFlightOrLater = true;
        end

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

    -- Add forwards compatibility
    self:polyFill();

    self.Comm:_init();
    self.User:_init();
    self.AwardedLoot:_init();
    self.SoftRes:_init();
    self.GDKP.Auction:_init();
    self.TMB:_init();
    self.GDKP.Session:_init();
    self.BoostedRolls:_init();
    self.PlusOnes:_init();
    self.DroppedLoot:_init();
    self.GroupLoot:_init();
    self.PackMule:_init();
    self.TradeWindow:_init();
    self.Interface.MasterLooterDialog:_init();
    self.Interface.TradeWindow.TimeLeft:_init();

    -- Hook native window events
    self:hookNativeWindowEvents();

    -- Hook the bagslot events
    self:hookBagSlotEvents();

    -- Hook item tooltip events
    self:hookTooltipSetItemEvents();

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

    -- Register sounds
    local media = LibStub("LibSharedMedia-3.0")
    media:Register("sound", "Gargul: uh-oh", "Interface/AddOns/".. self.name .."/Assets/Sounds/uh-oh.ogg");
end

--- Adds forwards compatibility
---
---@return void
function GL:polyFill()
    if (_G.GetContainerItemInfo ~= nil or not C_Container.GetContainerItemInfo) then
        return;
    end

    -- The GetContainerNumSlots has the same return type in both classic and DF
    _G.GetContainerNumSlots = C_Container.GetContainerNumSlots;

    -- DF returns a single table instead of single values, polyFill time!
    _G.GetContainerItemInfo = function (bagID, slot)
        local result = C_Container.GetContainerItemInfo(bagID, slot);

        if (not result) then
            return nil;
        end

        return result.iconFileID, result.stackCount, result.isLocked, result.quality, result.isReadable,
            result.hasLoot, result.hyperlink, result.isFiltered, result.hasNoValue, result.itemID, result.isBound;
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
    GL.Commands:call("gdkp");
end);

--- Announce conflicting addons, if any
---
---@return void
function GL:announceConflictingAddons()
    local ConflictingAddons = {};
    for _, addon in pairs(GL.Data.Constants.GargulConflictsWith) do
        if (IsAddOnLoaded(addon)) then
            tinsert(ConflictingAddons, addon);
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

--- Keep track of when native UI elements (like AH/mailbox) are active
---
---@return void
function GL:hookNativeWindowEvents()
    GL.Events:register("BootstrapAuctionHouseShowListener", "AUCTION_HOUSE_SHOW", function()
        self.auctionHouseIsShown = true;
    end);

    GL.Events:register("BootstrapAuctionHouseClosedListener", "AUCTION_HOUSE_CLOSED", function()
        self.auctionHouseIsShown = false;
    end);

    GL.Events:register("BootstrapMailShowListener", "MAIL_SHOW", function()
        self.mailIsShown = true;
    end);

    GL.Events:register("BootstrapMailClosedListener", "MAIL_CLOSED", function()
        self.mailIsShown = false;
    end);

    GL.Events:register("BootstrapMerchantShowListener", "MERCHANT_SHOW", function()
        self.merchantIsShown = true;
    end);

    GL.Events:register("BootstrapMerchantClosedListener", "MERCHANT_CLOSED", function()
        self.merchantIsShown = false;
    end);

    GL.Events:register("BootstrapBankFrameShowListener", "BANKFRAME_OPENED", function()
        self.bankIsShown = true;
    end);

    GL.Events:register("BootstrapBankFrameClosedListener", "BANKFRAME_CLOSED", function()
        self.bankIsShown = false;
    end);

    GL.Events:register("BootstrapGuildBankFrameShowListener", "GUILDBANKFRAME_OPENED", function()
        self.guildBankIsShown = true;
    end);

    GL.Events:register("BootstrapGuildBankFrameClosedListener", "GUILDBANKFRAME_CLOSED", function()
        self.guildBankIsShown = false;
    end);
end

--- Hook into the HandleModifiedItemClick event to allow for Gargul's many hotkeys
---
---@return void
function GL:hookBagSlotEvents()
    hooksecurefunc("HandleModifiedItemClick", function(itemLink)
        -- The user doesnt want to use shortcut keys when solo
        if (not GL.User.isInGroup
            and GL.Settings:get("ShortcutKeys.onlyInGroup")
        ) then
            return;
        end

        if (not itemLink or type(itemLink) ~= "string") then
            return;
        end

        -- Make sure item interaction elements like ah/mail/shop/bank are closed
        if (self.auctionHouseIsShown
            or self.bankIsShown
            or self.guildBankIsShown
            or self.mailIsShown
            or self.merchantIsShown
        ) then
            return;
        end

        local keyPressIdentifier = GL.Events:getClickCombination();

        -- Open the action selection window
        if (keyPressIdentifier == GL.Settings:get("ShortcutKeys.rollOffOrAuction")) then
            if (GL.GDKP.Session:activeSessionID()
                and not GL.GDKP.Session:getActive().lockedAt
            ) then
                GL.Interface.GDKP.Auctioneer:draw(itemLink);
            else
                GL.MasterLooterUI:draw(itemLink);
            end
        -- Open the roll window
        elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.rollOff")) then
            GL.MasterLooterUI:draw(itemLink);

        -- Open the auction window
        elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.auction")) then
            GL.Interface.GDKP.Auctioneer:draw(itemLink);

        -- Open the award window
        elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.award")) then
            GL.Interface.Award:draw(itemLink);

        elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.disenchant")) then
            -- We only allow disenchanting from bags if the disenchant hotkey does not include control
            -- because otherwise it triggers the dressupframe which can be really annoying
            if (not IsControlKeyDown()) then
                GL.PackMule:disenchant(itemLink);
            end
        end
    end);
end

--- We hook all the tooltip data (tmb/softres etc) to a single event to make caching easier
---
---@return void
function GL:hookTooltipSetItemEvents()
    -- Bind the appendAwardedLootToTooltip method to the OnTooltipSetItem event
    GL:onTooltipSetItem(function(Tooltip)
        -- No valid item tooltip was provided
        if (not Tooltip
            or not Tooltip.GetItem
        ) then
            return false;
        end

        local _, itemLink = Tooltip:GetItem();

        -- We couldn't find an itemLink (this can actually happen!)
        if (GL:empty(itemLink)) then
            return;
        end

        local Lines = {};
        local clientTime = GetTime();

        if (self.lastTooltipTime
            and self.lastTooltipItemLink == itemLink
            and self.lastTooltipTime >= clientTime - .4
        ) then
            -- Use cached data
            Lines = self.LastTooltipLines;
        else
            for _, line in pairs(GL.AwardedLoot:tooltipLines(itemLink) or {}) do
                tinsert(Lines, line);
            end

            for _, line in pairs(GL.SoftRes:tooltipLines(itemLink) or {}) do
                tinsert(Lines, line);
            end

            for _, line in pairs(GL.TMB:tooltipLines(itemLink) or {}) do
                tinsert(Lines, line);
            end

            for _, line in pairs(GL.LootPriority:tooltipLines(itemLink) or {}) do
                tinsert(Lines, line);
            end

            for _, line in pairs(GL.GDKP.Session:tooltipLines(itemLink) or {}) do
                tinsert(Lines, line);
            end
        end

        self.lastTooltipItemLink = itemLink;
        self.lastTooltipTime = clientTime;
        self.LastTooltipLines = Lines;

        local linesAdded = false;
        for _, line in pairs(Lines or {}) do
            Tooltip:AddLine(line);
            linesAdded = true;
        end

        if (linesAdded) then
            Tooltip:AddLine(" ");
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