local L;

-- arg1 is the name of the addon, arg2 is the addon namespace
---@class Bootstrapper
local appName, GL = ...;
_G.Gargul = GL; -- Open Gargul up to other developer integrations
_G.Gargul_L = {};

setmetatable(_G.Gargul_L, {
    __index = function (_, key)
        return tostring(key)
    end,
});

local GetAddOnMetadata = C_AddOns and C_AddOns.GetAddOnMetadata or GetAddOnMetadata;

GL.name = appName;
GL._initialized = false;
GL._isCrossRealm = nil; -- Will be set during runtime
GL.elvUILoaded = false;
GL.firstBoot = false; -- Indicates whether the user is new to Gargul
GL.tocVersion = select(4, GetBuildInfo());
GL.isEra = GL.tocVersion < 20000;
GL.isSoD = GL.isEra and C_Seasons.GetActiveSeason() == Enum.SeasonID.Placeholder;
GL.isClassic = not GL.isEra and GL.tocVersion < 90000;
GL.isRetail = GL.tocVersion >= 90000;
GL.isMuted = false;
GL.GDKPIsAllowed = true;
GL.version = GetAddOnMetadata(GL.name, "Version");
GL.DebugLines = {};
GL.EventFrame = nil;
GL.auctionHouseIsShown = false;
GL.bankIsShown = false;
GL.guildBankIsShown = false;
GL.mailIsShown = false;
GL.merchantIsShown = false;
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

    GL:after(1, nil, function()
        -- Check if ElvUI is loaded (useful for making adhoc UI changes)
        self.elvUILoaded = C_AddOns.GetAddOnEnableState(GL.User.name,"ElvUI") == 2;

        -- Check if the user doesn't already have MuteNotInGroup loaded
        if (self.isClassic and C_AddOns.GetAddOnEnableState(GL.User.name, "MuteNotInGroup") ~= 2) then
            -- Ignore "You aren't in a party" messages when you are in fact in a party (Blizzard LFD Bug)
            ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function (_, _, msg)
                return msg == ERR_NOT_IN_GROUP
                    and UnitInParty("player");
            end)
        end

        ---@todo: REMOVE
        GL.Interface.Settings:open(L.SETTINGS_SECTION_GETTING_STARTED);

        -- Disable any active GDKP session
        if (not self.GDKPIsAllowed) then
            GL.GDKP.Session:clearActive();
        end
    end);
end

--- Callback to be fired when the addon is completely loaded
function GL:_init()
    if (self.isSoD
        -- Taiwan is excluded apparently: https://tw.forums.blizzard.com/zh/wow/t/gdkp/12240
        and not GL:inTable({ "十字軍聖擊", "孤狼", "生命烈焰", "野性痊癒", }, GetRealmName())
    ) then
        self.GDKPIsAllowed = false;
    end

    -- Initialize classes
    self.Events:_init(self.EventFrame);
    self.DB:_init();
    self.Version:_init();
    self.Settings:_init();

    -- Determine which chat message locale to use
    local L = Gargul_L;
    local langMatch = false;
    local chatLocale = GL.Settings:get("chatLocale");

    -- The user previously selected a chatLocale
    if (chatLocale) then
        for lang, Translations in pairs(L.CHAT or {}) do
            if (lang == chatLocale) then
                L.CHAT = Translations;
                langMatch = true;
                break;
            end
        end
    end

    if (not chatLocale or not langMatch) then
        L.CHAT = {};
    end

    -- Make sure enUS fallbacks are available
    setmetatable(L.CHAT, {
        __index = function (_, key)
            return tostring(key)
        end,
    });

    GL.Settings:onChange("chatLocale", function ()
        if (GL.Settings:get("chatLocale") ~= chatLocale) then
            C_UI.Reload();
        end
    end);

    -- Register media
    local media = LibStub("LibSharedMedia-3.0")
    media:Register("sound", "Gargul: uh-oh", "Interface/AddOns/Gargul/Assets/Sounds/uh-oh.ogg");
    media:Register("sound", "Gargul: cheer", "Interface/AddOns/Gargul/Assets/Sounds/cheer.ogg");
    media:Register("sound", "Gargul: waow", "Interface/AddOns/Gargul/Assets/Sounds/waow.ogg");
    media:Register("sound", "Gargul: yay", "Interface/AddOns/Gargul/Assets/Sounds/yay.ogg");

    -- PTSansNarrow doesn't support al character sets
    if (GL:inTable({ "koKR", "zhCN", "zhTW", }, GetLocale())) then
        GL.FONT = STANDARD_TEXT_FONT;
    else
        media:Register("font", "PTSansNarrow", "Interface/AddOns/Gargul/Assets/Fonts/PTSansNarrow.ttf");
        GL.FONT = media:Fetch("font", "PTSansNarrow");
    end

    -- Show a welcome message
    if (self.Settings:get("welcomeMessage")) then
        print((L["|c00%sGargul v%s by Zhorax@Firemaw. Type |c00%s/gl or |c00%s/gargul to get started!"]):format(
            self.Data.Constants.addonHexColor,
            self.version,
            self.Data.Constants.addonHexColor,
            self.Data.Constants.addonHexColor
        ))
    end

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
    self.DroppedLootLedger:_init();
    self.TradeWindow:_init();
    self.TradeTime:_init();
    self.GDKP.Auctioneer:_init();
    self.GDKP.MultiAuction.Auctioneer:_init();
    self.GDKP.MultiAuction.Client:_init();
    self.Interface.MasterLooterDialog:_init();
    self.Interface.GDKP.BidderQueue:_init();
    self.Interface.GDKP.Distribute.MailCuts:_init();

    -- Hook native window events
    self:hookNativeWindowEvents();

    -- Hook item click events
    hooksecurefunc("HandleModifiedItemClick", function(itemLink)
        self:handleItemClick(itemLink, GetMouseButtonClicked());
    end);

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
function GL:announceConflictingAddons()
    local ConflictingAddons = {};
    local addonLoadedFunction = IsAddOnLoaded or C_AddOns.IsAddOnLoaded;

    for _, addon in pairs(GL.Data.Constants.GargulConflictsWith) do
        if (addonLoadedFunction(addon)) then
            tinsert(ConflictingAddons, addon);
        end
    end

    -- Nothing found, steady as she goes
    if (GL:empty(ConflictingAddons)) then
        return;
    end

    GL:warning((L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"]):format(
        table.concat(ConflictingAddons, ", ")
    ));
end

--- Keep track of when native UI elements (like AH/mailbox) are active
function GL:hookNativeWindowEvents()
    -- Make sure to reset window states when zoning
    GL.Events:register("BootstrapPlayerEnteringWorld", "PLAYER_ENTERING_WORLD", function ()
        GL.auctionHouseIsShown = false;
        GL.bankIsShown = false;
        GL.guildBankIsShown = false;
        GL.mailIsShown = false;
        GL.merchantIsShown = false;
    end);

    -- See https://wowpedia.fandom.com/wiki/PLAYER_INTERACTION_MANAGER_FRAME_HIDE for types
    if (not GL.isEra) then
        GL.Events:register("BootstrapPlayerInteractionShow", "PLAYER_INTERACTION_MANAGER_FRAME_SHOW", function(_, type)
            if (type == 5) then
                self.merchantIsShown = true;
            elseif (type == 8) then
                self.bankIsShown = true;
            elseif (type == 10) then
                self.guildBankIsShown = true;
            elseif (type == 17) then
                self.mailIsShown = true;
            elseif (type == 21) then
                self.auctionHouseIsShown = true;
            end
        end);

        GL.Events:register("BootstrapPlayerInteractionHide", "PLAYER_INTERACTION_MANAGER_FRAME_HIDE", function(_, type)
            if (type == 5) then
                self.merchantIsShown = false;
            elseif (type == 8) then
                self.bankIsShown = false;
            elseif (type == 10) then
                self.guildBankIsShown = false;
            elseif (type == 17) then
                self.mailIsShown = false;
            elseif (type == 21) then
                self.auctionHouseIsShown = false;
            end
        end);

        return;
    end

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

--- We hook all the tooltip data (tmb/softres etc) to a single event to make caching easier
function GL:hookTooltipSetItemEvents()
    GL.onTooltipSetItemFunc = function(Tooltip)
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
    end;

    -- Bind the appendAwardedLootToTooltip method to the OnTooltipSetItem event
    GL:onTooltipSetItem(GL.onTooltipSetItemFunc);
end

--[[ CREATE NECESSARY FRAMES ]]

-- Fire GL.bootstrap every time an addon is loaded
GL.EventFrame = CreateFrame("FRAME", "GargulEventFrame");
GL.EventFrame:RegisterEvent("ADDON_LOADED");
GL.EventFrame:SetScript("OnEvent", function (...) GL:bootstrap(...); end);

-- Frame that we can bind tooltips to to check item details
GL.TooltipFrame = CreateFrame("GameTooltip", "GargulTooltipFrame", nil, "GameTooltipTemplate");
GL.TooltipFrame:SetOwner(WorldFrame, "ANCHOR_NONE");