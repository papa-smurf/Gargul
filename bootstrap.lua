---@class GL
---@field Data Data
local GL;

---@type string
local appName;

appName, GL = ...;
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
-- Forever (Camelot): vanilla rules on the modern codebase, so Era behavior but not Era APIs.
GL.isForever = GL.tocVersion >= 16000 and GL.tocVersion < 17000;
GL.isClassic = not GL.isEra and GL.tocVersion < 90000;
GL.isRetail = GL.tocVersion >= 90000;
GL.isMuted = false;
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
GL.Ace = LibStub("AceAddon-3.0"):NewAddon(GL.name, "AceConsole-3.0", "AceComm-3.0");

-- Bootstrap the addon
---@return nil
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

    GL:after(1, nil, function ()
        -- Check if ElvUI is loaded (useful for making adhoc UI changes)
        self.elvUILoaded = GL.GetAddOnEnableState(UnitName("player"), "ElvUI") == 2;

        -- Check if the user doesn't already have MuteNotInGroup loaded
        if (self.isClassic and GL.GetAddOnEnableState(UnitName("player"), "MuteNotInGroup") ~= 2) then
            -- Ignore "You aren't in a party" messages when you are in fact in a party (Blizzard LFD Bug)
            ChatFrame_AddMessageEventFilter("CHAT_MSG_SYSTEM", function (_, _, msg)
                return msg == ERR_NOT_IN_GROUP
                    and UnitInParty("player");
            end)
        end
    end);
end

--- Callback to be fired when the addon is completely loaded
---@return nil
function GL:_init()
    self.Events:_init(self.EventFrame);
    self.DB:_init();
    self.Version:_init();
    self.Settings:_init();

    self:registerMedia();
    self:runInits();

    self:hookNativeWindowEvents();
    self:hookTooltipSetItemEvents();

    -- Listeners are registered above. refresh fires the group events they handle.
    self.User:refresh();
end

--- Register Gargul sounds and the default font. GL.FONT must exist before runInits.
---@return nil
function GL:registerMedia()
    local media = LibStub("LibSharedMedia-3.0");
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
end

--- Keep track of when native UI elements (like AH/mailbox) are active
---@return nil
function GL:hookNativeWindowEvents()
    local WindowFlags = {
        "auctionHouseIsShown",
        "bankIsShown",
        "guildBankIsShown",
        "mailIsShown",
        "merchantIsShown",
    };

    -- Make sure to reset window states when zoning
    GL.Events:register("BootstrapPlayerEnteringWorld", "PLAYER_ENTERING_WORLD", function ()
        for index = 1, #WindowFlags do
            GL[WindowFlags[index]] = false;
        end
    end);

    -- Era uses legacy events; other clients use PLAYER_INTERACTION_MANAGER_FRAME_* (types 5/8/10/17/21).
    -- Don't register both: 1.15.9 fires both, which would set window state twice.
    -- Forever gets both: we don't know which it fires and setting these twice is harmless.
    local FlagByInteractionType = {
        [5] = "merchantIsShown",
        [8] = "bankIsShown",
        [10] = "guildBankIsShown",
        [17] = "mailIsShown",
        [21] = "auctionHouseIsShown",
    };

    local function setInteractionShown(interactionType, isShown)
        local flag = FlagByInteractionType[interactionType];
        if (flag) then
            GL[flag] = isShown;
        end
    end

    if (not GL.isEra or GL.isForever) then
        GL.Events:register("BootstrapPlayerInteractionShow", "PLAYER_INTERACTION_MANAGER_FRAME_SHOW", function (_, interactionType)
            setInteractionShown(interactionType, true);
        end);

        GL.Events:register("BootstrapPlayerInteractionHide", "PLAYER_INTERACTION_MANAGER_FRAME_HIDE", function (_, interactionType)
            setInteractionShown(interactionType, false);
        end);
    end

    if (GL.isEra) then
        local LegacyEvents = {
            { "BootstrapAuctionHouseShowListener", "AUCTION_HOUSE_SHOW", "auctionHouseIsShown", true, },
            { "BootstrapAuctionHouseClosedListener", "AUCTION_HOUSE_CLOSED", "auctionHouseIsShown", false, },
            { "BootstrapMailShowListener", "MAIL_SHOW", "mailIsShown", true, },
            { "BootstrapMailClosedListener", "MAIL_CLOSED", "mailIsShown", false, },
            { "BootstrapMerchantShowListener", "MERCHANT_SHOW", "merchantIsShown", true, },
            { "BootstrapMerchantClosedListener", "MERCHANT_CLOSED", "merchantIsShown", false, },
            { "BootstrapBankFrameShowListener", "BANKFRAME_OPENED", "bankIsShown", true, },
            { "BootstrapBankFrameClosedListener", "BANKFRAME_CLOSED", "bankIsShown", false, },
            { "BootstrapGuildBankFrameShowListener", "GUILDBANKFRAME_OPENED", "guildBankIsShown", true, },
            { "BootstrapGuildBankFrameClosedListener", "GUILDBANKFRAME_CLOSED", "guildBankIsShown", false, },
        };

        for index = 1, #LegacyEvents do
            local identifier, event, flag, isShown = unpack(LegacyEvents[index]);
            GL.Events:register(identifier, event, function ()
                GL[flag] = isShown;
            end);
        end
    end
end

--- We hook all the tooltip data (tmb/softres etc) to a single event to make caching easier
---@return nil
function GL:hookTooltipSetItemEvents()
    GL.onTooltipSetItemFunc = function (Tooltip)
        -- No valid item tooltip was provided, or it's our own hidden scanning tooltip
        if (not Tooltip
            or not Tooltip.GetItem
            or Tooltip == GL.TooltipFrame
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