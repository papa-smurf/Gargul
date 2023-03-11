local L = Gargul_L;
local LCG = LibStub("LibCustomGlowGargul-1.0");

---@type GL
local _, GL = ...;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPPot
local Pot = GL.GDKP.Pot;

---@type Settings
local Settings = GL.Settings;

---@type Constants
local Constants = GL.Data.Constants;

---@type Interface
local Interface = GL.Interface;

---@type GDKPAuction
local Auction = GDKP.Auction;

---@type GDKPAuctioneer
local Auctioneer = GDKP.Auctioneer;

GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");
Interface.GDKP = Interface.GDKP or {};

---@class GDKPAuctioneerInterface
Interface.GDKP.Auctioneer = {
    isVisible = false,

    --[[ INPUT VALUES ]]
    antiSnipe = nil,
    increment = nil,
    itemLink = nil,
    minimumBid = nil,
    time = nil,

    reorderItems = nil, -- Overwritten later
    queueWindowName = "Gargul.Interface.GDKP.Auctioneer.Queue",
    windowName = "Gargul.Interface.GDKP.Auctioneer.Window",
    auctioneerShortcutName = "Gargul.Interface.GDKP.Auctioneer.Shortcut",

    BidsTable = nil,
    ItemRows = {};
    CountdownTimer = nil,
};

---@type GDKPAuctioneerInterface
local AuctioneerUI = Interface.GDKP.Auctioneer;

--[[ CONSTANTS ]]
local DEFAULT_WINDOW_HEIGHT = 281;
local DEFAULT_WINDOW_WIDTH = 350;
local DEFAULT_PLAYER_COLUMN_WIDTH = 150;
local DEFAULT_TABLE_ROWS = 6;
local FONT;
local HEIGHT_PER_TABLE_ROW = 18;
local QUESTION_MARK_TEXTURE = "Interface/Icons/INV_Misc_QuestionMark";

local BIDS_TABLE_COLUMNS = {
    { --[[ Player ]]
        width = DEFAULT_PLAYER_COLUMN_WIDTH,
        color = { r = .5, g = .5, b = 1.0, a = 1.0 },
    },
    { --[[ Bid ]]
        width = 108,
        color = { r = .5, g = .5, b = 1.0, a = 1.0 },
        sort = GL.Data.Constants.ScrollingTable.descending,
    },
    { --[[ Delete ]]
        width = 18,
        align = "RIGHT",
        DoCellUpdate = GL.LibStImageButtonCellUpdate,
    },
    { --[[ BID ID ]]
        width = 0,
    },
};

---@return table|nil
function AuctioneerUI:open()
    GL:debug("AuctioneerUI:open");

    if (GL.User.isInGroup
        and not GL.User.isMasterLooter
        and not GL.User.hasAssist
    ) then
        return GL:warning("You need to be the master looter or have an assist / lead role!");
    end

    self.isVisible = true;
    FONT = GL.FONT;

    local Window = _G[self.windowName] or self:build();

    Window:Show();
    return Window;
end

---@return void
function AuctioneerUI:close()
    GL:debug("AuctioneerUI:close");

    self.isVisible = false;
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

--- Build the auctioneer UI. We only do this once per runtime
---
---@return table
function AuctioneerUI:build()
    GL:debug("AuctioneerUI:build");

    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    --[[ THE MAIN AUCTIONEER WINDOW ]]
    ---@type Frame
    local Window = Interface:createWindow(self.windowName, {
        width = DEFAULT_WINDOW_WIDTH,
        height = DEFAULT_WINDOW_HEIGHT,
        minWidth = 350,
        minHeight = 239,
        maxWidth = 500,
        maxHeight = 700,
    });
    Window:Hide();

    Window:HookScript("OnShow", function ()
        self:closeAuctioneerShortcut();
    end);

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L.TUTORIAL, notCheckable = true, func = function ()
            GL:popupMessage(string.format(
                L.TUTORIAL_AUCTIONEER,
                GL.Settings:get("ShortcutKeys.rollOffOrAuction"),
                GL.Settings:get("ShortcutKeys.award"),
                L.AUCTION
            ));
            CloseMenus();
        end },
        {
            text = function ()
                return string.format("%s (|cFF%s%sg|r)",
                    L.GDKP_SESSION,
                    Constants.ClassHexColors.rogue,
                    Pot:total()
                );
            end,
            notCheckable = true,
            func = function ()
                Interface.GDKP.Overview:open();
                CloseMenus();
            end
        },
        "divider",
        {text = L.AUCTIONS, isTitle = true, notCheckable = true },
        {text = L.AUTO_AWARD, setting = "GDKP.autoAwardViaAuctioneer"},
        {text = L.NO_BIDS_ACTION, notCheckable = true, SubMenu = {
            {
                text = L.NOTHING,
                hideOnClick = true,
                isRadio = true,
                checked = function ()
                    return Settings:get("GDKP.queuedAuctionNoBidsAction") == "NOTHING";
                end,
                func = function (Entry)
                    Entry.checked = true;
                    Settings:set("GDKP.queuedAuctionNoBidsAction", "NOTHING");
                end,
            },
            {
                text = L.SKIP,
                hideOnClick = true,
                isRadio = true,
                checked = function ()
                    return Settings:get("GDKP.queuedAuctionNoBidsAction") == "SKIP";
                end,
                func = function (Entry)
                    Entry.checked = true;
                    Settings:set("GDKP.queuedAuctionNoBidsAction", "SKIP");
                end,
            },
            {
                text = L.DISENCHANT,
                hideOnClick = true,
                isRadio = true,
                checked = function ()
                    return Settings:get("GDKP.queuedAuctionNoBidsAction") == "DISENCHANT";
                end,
                func = function (Entry)
                    Entry.checked = true;
                    Settings:set("GDKP.queuedAuctionNoBidsAction", "DISENCHANT");
                end,
            },
        }},
        {text = L.AUTO_TRADE_OPTIONS, notCheckable = true, SubMenu = {
            {
                text = "Enable",
                checked = function ()
                    return Settings:get("AwardingLoot.autoTradeAfterAwardingAnItem");
                end,
                func = function (Entry)
                    Settings:set("AwardingLoot.autoTradeAfterAwardingAnItem", Entry.checked);
                end,
            },
            {
                text = "Disable for disenchanted",
                checked = function ()
                    return not Settings:get("AwardingLoot.autoTradeDisenchanter");
                end,
                func = function (Entry)
                    Settings:set("AwardingLoot.autoTradeDisenchanter", not Entry.checked);
                end,
            },
            {
                text = "Disable in combat",
                checked = function ()
                    return not Settings:get("AwardingLoot.autoTradeInCombat");
                end,
                func = function (Entry)
                    Settings:set("AwardingLoot.autoTradeInCombat", not Entry.checked);
                end,
            },
        }},
        {text = L.COMMUNICATION, notCheckable = true, SubMenu = {
            {
                text = L.SETTINGS_ANNOUNCE_START,
                checked = function ()
                    return Settings:get("GDKP.announceAuctionStart");
                end,
                func = function (Entry)
                    Settings:set("GDKP.announceAuctionStart", Entry.checked);
                end,
            },
            {
                text = L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD,
                checked = function ()
                    return Settings:get("GDKP.announcePotAfterAuction");
                end,
                func = function (Entry)
                    Settings:set("GDKP.announcePotAfterAuction", Entry.checked);
                end,
            },
            {
                text = L.SETTINGS_WHISPER_BID_TOO_LOW,
                checked = function ()
                    return Settings:get("GDKP.notifyIfBidTooLow");
                end,
                func = function (Entry)
                    Settings:set("GDKP.notifyIfBidTooLow", Entry.checked);
                end,
            },
            {
                text = L.SETTINGS_COUNTDOWN_IN_RAID_WARNING,
                checked = function ()
                    return Settings:get("GDKP.announceCountdownInRW");
                end,
                func = function (Entry)
                    Settings:set("GDKP.announceCountdownInRW", Entry.checked);
                end,
            },
            {
                text = L.SETTINGS_ANNOUNCE_INCOMING_BIDS,
                checked = function ()
                    return Settings:get("GDKP.announceNewBid");
                end,
                func = function (Entry)
                    Settings:set("GDKP.announceNewBid", Entry.checked);
                end,
            },
            {
                text = L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING,
                checked = function ()
                    return Settings:get("GDKP.announceNewBidInRW");
                end,
                func = function (Entry)
                    Settings:set("GDKP.announceNewBidInRW", Entry.checked);
                end,
            },
        }},
        "divider",
        {text = L.QUEUE, isTitle = true, notCheckable = true },
        {text = L.ADD_DROPS_TO_QUEUE, setting = "GDKP.addDropsToQueue", func = function(Entry, _, _, checked)
            Settings:set("GDKP.addDropsToQueue", checked);
            Entry.checked = checked;
        end},
        {text = L.INCLUDE_BOES, setting = "GDKP.addBOEDropsToQueue", func = function(Entry, _, _, checked)
            Settings:set("GDKP.addBOEDropsToQueue", checked);
            Entry.checked = checked;
        end},
        "divider",
        {text = L.WINDOW, isTitle = true, notCheckable = true },
        {text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
        {text = L.MINIMIZE_ON_START, setting = "GDKP.minimizeAuctioneerOnStart"},
        {text = L.MINIMIZE_ON_AWARD, setting = "GDKP.minimizeAuctioneerOnAward"},
        "divider",
        {text = L.ALL_SETTINGS, notCheckable = true, func = function ()
            Settings:draw("GDKP");
            CloseMenus();
        end },
    });

    --[[ PREPARE THE MINIMIZED VERSION OF THE WINDOW ]]
    Window.Minimized:SetHeight(70);
    Window.Minimized:SetWidth(150);

    ---@type Button
    local StopButton;

    ---@type FontString
    local CurrentPotLabel = Interface:createFontString(Window.Minimized, {
        text = function (self)
            self:SetText(string.format("%s: |cFF%s%sg|r",
                L.POT,
                Constants.ClassHexColors.rogue,
                Pot:total()
            ));
        end,
        updateOn = { "GL.GDKP_AUCTION_CHANGED", "GL.GDKP_SESSION_CHANGED" },
    });
    CurrentPotLabel:SetFont(GL.FONT, 12, "OUTLINE");
    CurrentPotLabel:SetPoint("TOPLEFT", Window.Minimized, "TOPLEFT", 24, -18);

    ---@type Button
    local MinimizedStopButton = Interface:dynamicPanelButton(Window.Minimized, L.STOP);
    MinimizedStopButton:SetPoint("TOPLEFT", Window.Minimized, "TOPLEFT", 20, -34);
    MinimizedStopButton:SetPoint("TOPRIGHT", Window.Minimized, "TOPRIGHT", -20, 0);
    MinimizedStopButton:SetScript("OnClick", function ()
        StopButton:Click();
    end);
    MinimizedStopButton:Hide();
    Window.Minimized.StopButton = MinimizedStopButton;

    ---@type Button
    local MinimizedOpenButton = Interface:dynamicPanelButton(Window.Minimized, L.OPEN_AUCTIONEER);
    MinimizedOpenButton:SetPoint("TOPLEFT", Window.Minimized, "TOPLEFT", 20, -34);
    MinimizedOpenButton:SetPoint("TOPRIGHT", Window.Minimized, "TOPRIGHT", -20, 0);
    MinimizedOpenButton:SetScript("OnClick", function ()
        self:open();
    end);
    Window.Minimized.OpenButton = MinimizedOpenButton;

    ---@type EditBox
    local ItemInput;

    ---@type Texture
    local ItemImage;

    do --[[ ITEM ICON / INPUT ]]
        ---@type Frame
        local Icon = CreateFrame("Frame",nil, Window);
        Icon:SetSize(40, 40);
        Icon:SetPoint("TOPLEFT", Window, "TOPLEFT", 28, -28);

        Icon:SetScript("OnEnter", function()
            if (not self.itemLink or not GL:getItemIDFromLink(self.itemLink)) then return; end
            GameTooltip:SetOwner(Icon, "RIGHT");
            GameTooltip:SetHyperlink(self.itemLink);
            GameTooltip:Show();
        end);

        Icon:SetScript("OnMouseUp", function (_, mouseButtonPressed)
            GL:handleItemClick(self.itemLink, mouseButtonPressed);
        end);

        Icon:SetScript("OnLeave", function()
            GameTooltip:Hide();
        end);

        ItemImage = Icon:CreateTexture(nil, "BACKGROUND")
        ItemImage:SetWidth(40)
        ItemImage:SetHeight(40)
        ItemImage:SetPoint("TOP", 0, 0);
        ItemImage:SetTexture(QUESTION_MARK_TEXTURE);

        ItemInput = Interface:inputBox(Window);
        ItemInput:SetPoint("TOPLEFT", Icon, "TOPRIGHT", 18, -18);
        ItemInput:SetPoint("RIGHT", Window, "RIGHT", -24, 0);
    end

    do --[[ CURRENT POT ]]
        --[[ ICON ]]
        ---@type Frame
        local Icon = CreateFrame("Frame",nil, Window);
        Icon:SetSize(12, 12);
        Icon:SetPoint("BOTTOMLEFT", ItemInput, "TOPLEFT", -4, 4);

        local PotImage = Icon:CreateTexture(nil, "BACKGROUND")
        PotImage:SetWidth(12)
        PotImage:SetHeight(12)
        PotImage:SetPoint("TOP", 0, 0);
        PotImage:SetTexture("Interface/AddOns/Gargul/Assets/Icons/achievement_guildperk_cashflow");

        --[[ TEXT ]]
        ---@type FontString
        local CurrentPotLabel = Interface:createFontString(Window, {
            text = function (self)
                self:SetText(string.format("%s: |cFF%s%sg|r",
                    L.POT,
                    Constants.ClassHexColors.rogue,
                    Pot:total()
                ));
            end,
            updateOn = { "GL.GDKP_AUCTION_CHANGED", "GL.GDKP_SESSION_CHANGED" },
        });
        CurrentPotLabel:SetPoint("TOPLEFT", Icon, "TOPRIGHT", 4, 0);
    end

    --[[ MINIMUM BID ]]
    ---@type FontString
    local MinLabel = Interface:createFontString(Window, L.MIN);
    MinLabel:SetPoint("TOPLEFT", Window, "TOPLEFT", 26, -82);

    ---@type EditBox
    local MinInput = Interface:inputBox(Window);
    MinInput:SetWidth(42);
    MinInput:SetPoint("TOPLEFT", MinLabel, "TOPRIGHT", 8, 6);
    MinInput:SetScript("OnTextChanged", function ()
        self.minimumBid = tonumber(MinInput:GetText());
    end);

    --[[ INCREMENT ]]
    ---@type FontString
    local IncLabel = Interface:createFontString(Window, L.INC);
    IncLabel:SetPoint("TOPLEFT", MinLabel, "TOPRIGHT", MinInput:GetWidth() + 12, 0);

    ---@type EditBox
    local IncInput = Interface:inputBox(Window);
    IncInput:SetWidth(36);
    IncInput:SetPoint("TOPLEFT", IncLabel, "TOPRIGHT", 8, 6);
    IncInput:SetScript("OnTextChanged", function ()
        self.increment = tonumber(IncInput:GetText());
    end);

    --[[ TIME ]]
    ---@type FontString
    local TimeLabel = Interface:createFontString(Window, L.TIME);
    TimeLabel:SetPoint("TOPLEFT", IncLabel, "TOPRIGHT", IncInput:GetWidth() + 12, 0);

    ---@type EditBox
    local TimeInput = Interface:inputBox(Window);
    TimeInput:SetText(Settings:get("GDKP.time"));
    TimeInput:SetWidth(20);
    TimeInput:SetPoint("TOPLEFT", TimeLabel, "TOPRIGHT", 8, 6);
    TimeInput:SetScript("OnTextChanged", function ()
        self.time = tonumber(TimeInput:GetText());
    end);

    --[[ ANTI SNIPE ]]
    ---@type FontString
    local SnipeLabel = Interface:createFontString(Window, L.ANTISNIPE);
    SnipeLabel:SetPoint("TOPLEFT", TimeLabel, "TOPRIGHT", TimeInput:GetWidth() + 12, 0);

    ---@type EditBox
    local SnipeInput = Interface:inputBox(Window);
    SnipeInput:SetText(Settings:get("GDKP.antiSnipe"));
    SnipeInput:SetWidth(20);
    SnipeInput:SetPoint("TOPLEFT", SnipeLabel, "TOPRIGHT", 8, 6);
    SnipeInput:SetScript("OnTextChanged", function ()
        self.antiSnipe = tonumber(SnipeInput:GetText());
    end);

    do --[[ HELP ICON ]]
        local texturePath = "interface/friendsframe/informationicon";

        ---@type Frame
        local Icon = CreateFrame("Button","Gargul.Interface.GDKP.Auctioneer.HelpIcon", Window);
        Icon:SetSize(12, 12);
        Icon:SetPoint("TOPLEFT", SnipeInput, "TOPRIGHT", 4, -4);

        ---@type Texture
        local image = Icon:CreateTexture(nil, "BACKGROUND")
        image:SetWidth(12)
        image:SetHeight(12)
        image:SetAllPoints(Icon)
        image:SetTexture(texturePath);

        ---@type Texture
        local highlight = Icon:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetAllPoints(Icon);
        highlight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
        highlight:SetTexCoord(0, 1, 0.23, 0.77);
        highlight:SetBlendMode("ADD");

        Interface:addTooltip(Icon, L.ANTISNIPE_EXPLANATION);
    end

    ---@type Frame
    local StoppedButtonFrame;

    do --[[ BUTTONS WHEN AUCTION STOPPED ]]
        StoppedButtonFrame = CreateFrame("Frame", nil, Window);
        StoppedButtonFrame:SetHeight(20);
        StoppedButtonFrame:SetPoint("TOPLEFT", Window, "TOPLEFT", 0, -108);
        StoppedButtonFrame:SetPoint("TOPRIGHT", Window, "TOPRIGHT", 0, -108);

        --[[ START ]]
        ---@type Button
        local StartButton = Interface:dynamicPanelButton(StoppedButtonFrame, L.START);
        StartButton:SetPoint("TOPLEFT", StoppedButtonFrame, "TOPLEFT", 26, 0);
        StartButton:SetScript("OnClick", function ()
            Auctioneer:start(true);
        end);

        --[[ DISENCHANT ]]
        ---@type Button
        local DisenchantButton = Interface:dynamicPanelButton(StoppedButtonFrame, L.DISENCHANT);
        DisenchantButton:SetPoint("TOPLEFT", StartButton, "TOPRIGHT", 1, 0);
        DisenchantButton:SetScript("OnClick", function ()
            Auctioneer:disenchant(self.itemLink);
        end);

        --[[ CLEAR ]]
        ---@type Button
        local ClearButton = Interface:dynamicPanelButton(StoppedButtonFrame, L.CLEAR);
        ClearButton:SetPoint("TOPLEFT", DisenchantButton, "TOPRIGHT", 1, 0);
        ClearButton:SetScript("OnClick", function ()
            Auctioneer:clear();
        end);

        --[[ NEXT ]]
        ---@type Button
        local NextButton = Interface:dynamicPanelButton(StoppedButtonFrame, L.NEXT);
        NextButton:SetPoint("TOPLEFT", ClearButton, "TOPRIGHT", 1, 0);
        NextButton:SetScript("OnClick", function ()
            Auctioneer:popFromQueue(true);
        end);

        --[[ AWARD ]]
        ---@type Button
        local AwardButton = Interface:dynamicPanelButton(StoppedButtonFrame, L.AWARD);
        AwardButton:SetPoint("TOPLEFT", NextButton, "TOPRIGHT", 1, 0);
        AwardButton:SetScript("OnClick", function ()
            Auctioneer:award();
        end);
    end

    ---@type Frame
    local StartedButtonFrame;

    do --[[ BUTTONS WHEN AUCTION STARTED ]]
        StartedButtonFrame = CreateFrame("Frame", nil, Window);
        StartedButtonFrame:SetHeight(StoppedButtonFrame:GetHeight());
        StartedButtonFrame:SetPoint("TOPLEFT", StoppedButtonFrame);
        StartedButtonFrame:SetPoint("TOPRIGHT", StoppedButtonFrame);
        StartedButtonFrame:Hide();

        --[[ START ]]
        ---@type Button
        StopButton = Interface:dynamicPanelButton(StartedButtonFrame, L.STOP);
        StopButton:SetPoint("TOPLEFT", StartedButtonFrame, "TOPLEFT", 26, 0);
        StopButton:SetScript("OnClick", function ()
            Auctioneer:stop();
        end);

        --[[ +10 ]]
        ---@type Button
        local ExtendButton = Interface:dynamicPanelButton(StartedButtonFrame, L.PLUS10);
        ExtendButton:SetPoint("TOPLEFT", StopButton, "TOPRIGHT", 1, 0);
        ExtendButton:SetScript("OnClick", function ()
            if (Auctioneer:extend()) then
                ExtendButton:SetEnabled(false);

                GL.Ace:ScheduleTimer(function ()
                    ExtendButton:SetEnabled(true);
                end, 2);
            end
        end);

        --[[ -10 ]]
        ---@type Button
        local ShortenButton = Interface:dynamicPanelButton(StartedButtonFrame, L.MINUS10);
        ShortenButton:SetPoint("TOPLEFT", ExtendButton, "TOPRIGHT", 1, 0);
        ShortenButton:SetScript("OnClick", function ()
            if (Auctioneer:shorten()) then
                ShortenButton:SetEnabled(false);

                GL.Ace:ScheduleTimer(function ()
                    ShortenButton:SetEnabled(true);
                end, 2);
            end
        end);
    end

    --[[ BIDS TABLE ]]
    local Table = self:buildBidsTable(Window);
    Table.frame:SetPoint("TOPLEFT", StoppedButtonFrame, "BOTTOMLEFT", 20, -10);
    self.BidsTable = Table;

    --[[ QUEUE (RIGHT SIDE) WINDOW ]]
    ---@type Frame
    local Queue = self:buildQueue(Window);

    do --[[ QUEUE TOGGLER BUTTON ]]
        local closedCoords = { 0.03125, 0.46875, 0.0078125, 0.9921875 };
        local openedCoords = { 0.53125, 0.96875, 0.0078125, 0.9921875 };

        ---@type Button
        local ToggleQueue = CreateFrame("Button", "Gargul.Interface.GDKP.Auctioneer.ToggleQueue", Window);
        ToggleQueue:SetSize(14,66);
        ToggleQueue:SetPoint("CENTER", Queue);
        ToggleQueue:SetScript("OnClick", function ()
            if (Settings:get("GDKP.disableQueues")) then
                GL:warning(L.YOU_DISABLED_GDKP_QUEUES);
                return;
            end

            if (Queue:IsVisible()) then
                Queue:Hide();
                ToggleQueue.texture:SetTexCoord(unpack(closedCoords));
                Settings:set("GDKP.showQueueWindow", false);
            else
                Queue:Show();
                ToggleQueue.texture:SetTexCoord(unpack(openedCoords));
                Settings:set("GDKP.showQueueWindow", true);
            end

            ToggleQueue:SetPoint("RIGHT", Queue:IsShown() and Queue or Window, "RIGHT", -10, 0);
        end);

        ToggleQueue.texture = ToggleQueue:CreateTexture();
        ToggleQueue.texture:SetAllPoints(ToggleQueue)
        ToggleQueue.texture:SetTexture("interface/raidframe/raidpanel-toggle");
        ToggleQueue.texture:SetTexCoord(unpack(closedCoords));
        ToggleQueue:SetPoint("RIGHT", Queue:IsShown() and Queue or Window, "RIGHT", -10, 0);

        if (Queue:IsShown()) then
            ToggleQueue.texture:SetTexCoord(unpack(openedCoords));
        end

        ToggleQueue.highlightTexture = ToggleQueue:CreateTexture(nil, "HIGHLIGHT");
        ToggleQueue.highlightTexture:SetPoint("TOPLEFT", ToggleQueue, "TOPLEFT", 3, -10);
        ToggleQueue.highlightTexture:SetPoint("BOTTOMRIGHT", ToggleQueue, "BOTTOMRIGHT", 2, 10);
        ToggleQueue.highlightTexture:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight");
        ToggleQueue.highlightTexture:SetTexCoord(0, 1, 0.23, 0.77);
        ToggleQueue.highlightTexture:SetBlendMode("ADD");
        ToggleQueue:SetHighlightTexture(ToggleQueue.highlightTexture);

        Interface:addTooltip(ToggleQueue, L.TOGGLE_QUEUE, "BOTTOMRIGHT");
    end

    --[[ ADJUST TABLE ROWS AFTER WINDOW RESIZE ]]
    Window:HookScript("OnSizeChanged", function (...)
        local extraVerticalRoomForTable = Window:GetHeight() - DEFAULT_WINDOW_HEIGHT;
        local extraHorizontalRoomForTable = Window:GetWidth() - DEFAULT_WINDOW_WIDTH;
        local additionalRows = math.floor(extraVerticalRoomForTable / HEIGHT_PER_TABLE_ROW);

        --[[ ADJUST ROWS ]]
        Table:SetDisplayRows(additionalRows + DEFAULT_TABLE_ROWS, HEIGHT_PER_TABLE_ROW);

        --[[ ADJUST COLUMN WIDTH ]]
        local newPlayerColumnWidth = math.floor(extraHorizontalRoomForTable + DEFAULT_PLAYER_COLUMN_WIDTH);
        BIDS_TABLE_COLUMNS[1].width = newPlayerColumnWidth
        Table:SetDisplayCols(BIDS_TABLE_COLUMNS);
    end);
    Window:GetScript("OnSizeChanged")();

    --[[ CHANGE THE CURRENTLY ACTIVE ITEM ]]

    ---@param _
    ---@param itemLink string
    ---@param minimum number
    ---@param increment number
    ---@return void
    Window.setItemByLink = function(_, itemLink, minimum, increment)
        GL:onItemLoadDo(GL:getItemIDFromLink(itemLink), function (Details)
            if (not Details) then
                return;
            end

            minimum = tonumber(minimum);
            increment = tonumber(increment);

            local PerItemSettings;
            if (not minimum or not increment) then
                PerItemSettings = GDKP:settingsForItemID(Details.id);
            end

            minimum = minimum or PerItemSettings.minimum;
            increment = increment or PerItemSettings.increment;

            ---@type table
            MinInput:SetText(minimum);
            IncInput:SetText(increment);

            self.itemLink = itemLink;
            self.minimumBid = minimum;
            self.increment = increment;
            ItemImage:SetTexture(Details.icon);
            ItemInput:SetText(Details.link);
        end);
    end;

    --[[ SHOW THE AUCTIONEER SHORTCUT WHEN CLOSING THE WINDOW DURING AN AUCTION ]]
    Window:SetScript("OnHide", function ()
        self.isVisible = false;

        if (Auction.inProgress and Auction:startedByMe()) then
            self:openAuctioneerShortcut();
        end
    end);

    --[[ CLEAR THE CURRENTLY ACTIVE ITEM ]]
    Window.clearItem = function()
        self.itemLink = nil;
        MinInput:SetText("");
        IncInput:SetText("");
        ItemImage:SetTexture(QUESTION_MARK_TEXTURE);
        ItemInput:SetText("");
    end

    --[[ SWITCH BETWEEN STOP / START BUTTONS ]]
    Window.stop = function ()
        StoppedButtonFrame:Show();
        StartedButtonFrame:Hide();
    end;

    Window.start = function ()
        StoppedButtonFrame:Hide();
        StartedButtonFrame:Show();

        --[[ SHOW TIME REMAINING ON STOP BUTTON ]]
        GL.Ace:CancelTimer(self.CountdownTimer);
        self.CountdownTimer = GL.Ace:ScheduleRepeatingTimer(function ()
            local secondsRemaining = Auction:timeRemaining();

            if (not secondsRemaining
                or not Auction.inProgress
            ) then
                GL.Ace:CancelTimer(self.CountdownTimer);
                StopButton:SetText(L.STOP);
                return;
            end

            secondsRemaining = math.max(secondsRemaining, 0);
            StopButton:SetText(GL:strPadRight(string.format("%s %ss", L.STOP, secondsRemaining), " ", string.len(L.STOP) + 5));
            MinimizedStopButton:SetText(string.format("%s %ss", L.STOP, secondsRemaining));
            MinimizedOpenButton:Hide();
            MinimizedStopButton:Show();
        end, .2);
    end;

    _G[self.windowName] = Window;
    return Window;
end

---@param Window Frame
---@return Frame
function AuctioneerUI:buildQueue(Window)
    GL:debug("AuctioneerUI:buildQueue");

    if (_G[self.queueWindowName]) then
        return _G[self.queueWindowName];
    end

    --[[ QUEUE WINDOW ]]
    ---@type Frame
    local Queue;

    do
        ---@type Frame
        local ItemHolder

        ---@type ScrollFrame
        local ScrollFrame;

        Queue = CreateFrame("Frame", self.queueWindowName, Window, "BackdropTemplate");
        Queue:SetPoint("TOPLEFT", Window, "TOPRIGHT", -2, 0);
        Queue:SetPoint("BOTTOMLEFT", Window, "BOTTOMRIGHT", -2, 0);
        Queue:SetResizable(true);
        Queue:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
        Interface:restoreDimensions(Queue, nil, 300);
        Interface:resizeBounds(Queue, 240, 1);
        Interface:addResizer(Queue);
        Queue:Show();

        Queue:SetScript("OnSizeChanged", function ()
            Queue:SetWidth(math.min(600, Queue:GetWidth()));
            Queue:ClearAllPoints();
            Queue:SetPoint("TOPLEFT", Window, "TOPRIGHT", -2, 0);
            Queue:SetPoint("BOTTOMLEFT", Window, "BOTTOMRIGHT", -2, 0);
            Interface:storeDimensions(Queue);
            ItemHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
        end);

        if (Settings:get("GDKP.disableQueues")
            or not Settings:get("GDKP.showQueueWindow")
        ) then
            Queue:Hide();
        end

        do --[[ HELP FRAME ]]
            ---@type Frame
            local HelpFrame = CreateFrame("Frame", nil, Queue);
            HelpFrame:SetSize(50, 20);
            HelpFrame:SetPoint("TOPLEFT", Queue, "TOPLEFT", 16, -16);

            ---@type Texture
            local highlight = HelpFrame:CreateTexture(nil, "HIGHLIGHT")
            highlight:SetAllPoints(HelpFrame);
            highlight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
            highlight:SetBlendMode("ADD");

            Interface:addTooltip(HelpFrame, { L.QUEUE .. " " .. L.INFO, string.format(
                L.GDKP_QUEUE_EXPLANATION,
                GL.Settings:get("ShortcutKeys.rollOffOrAuction"),
                L.HALT
            )}, "CURSOR");

            --[[ ICON ]]
            local texturePath = "interface/friendsframe/informationicon";

            ---@type Button
            local Icon = CreateFrame("Button",nil, Queue);
            Icon:SetSize(12, 12);
            Icon:SetPoint("TOPLEFT", HelpFrame, "TOPLEFT");

            ---@type Texture
            local image = Icon:CreateTexture(nil, "BACKGROUND")
            image:SetWidth(12)
            image:SetHeight(12)
            image:SetAllPoints(Icon)
            image:SetTexture(texturePath);

            --[[ INFO ]]
            ---@type FontString
            local InfoLabel = Interface:createFontString(HelpFrame, L.INFO);
            InfoLabel:SetPoint("TOPLEFT", HelpFrame, "TOPLEFT", 13, -1);
        end

        --[[ MINIMUM BID ]]
        ---@type FontString
        local MinLabel = Interface:createFontString(Queue, L.MINIMUM);
        MinLabel:SetPoint("TOPRIGHT", Queue, "TOPRIGHT", -118, -18);

        --[[ INCREMENT ]]
        ---@type FontString
        local IncLabel = Interface:createFontString(Queue, L.INCREMENT);
        IncLabel:SetPoint("TOPLEFT", MinLabel, "TOPRIGHT", 6, 0);

        --[[ SCROLLFRAME BOILERPLATE ]]
        ScrollFrame = CreateFrame("ScrollFrame", nil, Queue, "UIPanelScrollFrameTemplate")
        ScrollFrame:SetPoint("TOPLEFT", Queue, "TOPLEFT", 16, -32);
        ScrollFrame:SetPoint("BOTTOMRIGHT", Queue, "BOTTOMRIGHT", -44, 44);

        ItemHolder = CreateFrame("Frame");
        ScrollFrame:SetScrollChild(ItemHolder);
        ItemHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
        ItemHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
        ItemHolder:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");

        ---@type Frame
        local Items = CreateFrame("Frame", nil, ItemHolder);
        Items:SetAllPoints(ItemHolder);

        ---@type Frame
        local DeleteButton;

        do --[[ DELETE BUTTON ]]
            DeleteButton = CreateFrame("Button", nil, ItemHolder, "UIPanelButtonTemplate");
            DeleteButton:SetSize(18, 18);

            ---@type Texture
            local NormalTexture = DeleteButton.normalTexture or DeleteButton:CreateTexture();
            NormalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/delete");
            NormalTexture:SetAllPoints(DeleteButton);
            DeleteButton:SetNormalTexture(NormalTexture);

            ---@type Texture
            local HighlightTexture = DeleteButton:CreateTexture();
            HighlightTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/delete");
            NormalTexture:SetAllPoints(DeleteButton);
            DeleteButton:SetHighlightTexture(HighlightTexture);

            Interface:addTooltip(DeleteButton, L.DELETE, "TOP");
        end

        --[[ REORDER QUEUE ENTRIES ]]
        self.reorderItems = function()
            for key, ItemRow in pairs(self.ItemRows or {}) do
                if (not ItemRow or not ItemRow._itemLink or not Auction.Queue[ItemRow._identifier]) then
                    if (ItemRow and ItemRow.GetChildren) then
                        Interface:release(ItemRow);
                    end

                    self.ItemRows[key] = nil;
                end
            end

            local SortedQueue = GL:tableValues(Auction.Queue);
            table.sort(SortedQueue, function (a, b)
                if (a.order and b.order) then
                    return a.order < b.order;
                end

                return false;
            end);

            for _, QueuedItem in pairs(SortedQueue or {}) do
                local key = QueuedItem.identifier;
                local ItemRow = self.ItemRows[key];

                if (ItemRow and ItemRow._itemLink) then
                    ItemRow:ClearAllPoints();
                    ItemRow:Show();
                    ItemRow:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 0, ((QueuedItem.order - 1) * 20) * -1);
                    ItemRow:SetPoint("TOPRIGHT", ItemHolder, "TOPRIGHT", not GL.elvUILoaded and 0 or -4, 0);
                    self.ItemRows[key] = ItemRow;
                else
                    self.ItemRows[key] = nil;
                end
            end
        end

        --[[ ADD AN ITEM TO THE QUEUE WINDOW ]]
        local rowHeight = 20;
        Queue.addItemByLink = function (_, link, identifier)
            GL:onItemLoadDo(GL:getItemIDFromLink(link), function (Details)
                if (not Details or self.ItemRows[identifier]) then
                    return;
                end

                local bindOnPickup = GL:inTable({LE_ITEM_BIND_ON_ACQUIRE, LE_ITEM_BIND_QUEST}, Details.bindType);

                ---@type Frame
                local ItemRow = CreateFrame("Frame", nil, ItemHolder);

                ---@type table
                local PerItemSettings = GDKP:settingsForItemID(Details.id);
                ItemRow:SetHeight(rowHeight);
                ItemRow._itemLink = link;
                ItemRow._identifier = identifier;

                ItemRow:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 0, (GL:count(self.ItemRows) * 20) * -1);
                ItemRow:SetPoint("TOPRIGHT", ItemHolder, "TOPRIGHT", not GL.elvUILoaded and 0 or -4, 0);

                --[[ TOGGLE DELETE ON HOVER ]]
                ItemRow:SetScript("OnEnter", function ()
                    DeleteButton:SetFrameLevel(ItemRow:GetFrameLevel() + 1);
                    DeleteButton:ClearAllPoints();
                    DeleteButton:SetPoint("TOPRIGHT", ItemRow, "TOPRIGHT", -2, 0);
                    DeleteButton:Show();

                    DeleteButton:SetScript("OnClick", function ()
                        DeleteButton:SetParent(ItemHolder);
                        DeleteButton:Hide();
                        Auction:removeFromQueue(ItemRow._identifier);
                        self:reorderItems();
                    end);
                end);

                ItemRow:SetScript("OnLeave", function ()
                    if (not Interface:mouseIsOnFrame(DeleteButton)) then
                        DeleteButton:Hide();
                    end
                end);

                ItemRow:SetScript("OnMouseUp", function (_, mouseButtonPressed)
                    GL:handleItemClick(link, mouseButtonPressed, function ()
                        -- Remove the item from the queue if it was awarded/disenchanted
                        Auction:removeFromQueue(ItemRow._identifier);
                        self:deleteRowFromQueue(ItemRow);
                    end);
                end);

                local uiScale, mouseX, mouseY;
                ItemRow:SetScript("OnMouseDown", function ()
                    uiScale, mouseX, mouseY = UIParent:GetEffectiveScale(), GetCursorPosition();
                end);

                ItemRow:SetMovable(true);
                ItemRow:EnableMouse(true);
                ItemRow:RegisterForDrag("LeftButton");
                local indexWithGlow, RowWithGlow, MoveTimer, newPosition, originalPosition;
                ItemRow:SetScript("OnDragStart", function()
                    local numberOfRows = GL:count(self.ItemRows);
                    originalPosition = Auction.Queue[ItemRow._identifier].order;
                    local itemRowHeight = ItemRow:GetHeight();
                    ItemRow:StartMoving();

                    MoveTimer = GL.Ace:ScheduleRepeatingTimer(function ()
                        local _, newMouseY = GetCursorPosition();

                        newPosition = math.ceil(originalPosition - ((newMouseY - mouseY) / (itemRowHeight * uiScale)));
                        newPosition = math.max(1, newPosition);
                        newPosition = math.min(numberOfRows, newPosition);
                        if (newPosition == indexWithGlow
                            or newPosition == originalPosition
                        ) then
                            return;
                        end

                        if (RowWithGlow) then
                            LCG.PixelGlow_Stop(RowWithGlow);
                        end

                        RowWithGlow = Auction:QueuedItemByPosition(newPosition);
                        if (RowWithGlow) then
                            indexWithGlow = newPosition;
                            RowWithGlow = self.ItemRows[RowWithGlow.identifier];

                            LCG.PixelGlow_Start(RowWithGlow, {1,1,1,1}, 20, .05, 5, 3);
                        end
                    end, .1);
                end);
                ItemRow:SetScript("OnDragStop", function()
                    GL.Ace:CancelTimer(MoveTimer);
                    ItemRow:Hide();

                    if (RowWithGlow) then
                        LCG.PixelGlow_Stop(RowWithGlow);
                    end

                    if (tonumber(newPosition)) then
                        local MoveTo = Auction:QueuedItemByPosition(newPosition);

                        if (MoveTo) then
                            Auction:reorderQueueItem(ItemRow._identifier, MoveTo.identifier);
                        end
                    end

                    self:reorderItems();
                end);

                --[[ ITEM ICON ]]
                ---@type Frame
                local Icon = CreateFrame("Frame",nil, ItemRow);
                Icon:SetPoint("TOPLEFT", ItemRow, 0, -2);
                Icon:SetSize(rowHeight - 4, rowHeight - 4);

                Icon:SetScript("OnMouseUp", function (_, mouseButtonPressed)
                    -- Remove the item from the queue if it was awarded/disenchanted
                    Auction:removeFromQueue(ItemRow._identifier);
                    self:deleteRowFromQueue(ItemRow);
                end);

                Interface:addTooltip(Icon, Details.link);

                --[[ ICON HIGHLIGHT ]]
                GL:highlightItem(Icon, Details.link);

                ItemRow.Icon = Icon;

                ---@type Texture
                local Image = Icon:CreateTexture(nil, "BACKGROUND")
                Image:SetAllPoints(Icon);
                Image:SetTexture(Details.icon);

                --[[ INCREMENT ]]
                ---@type EditBox
                local IncInput = Interface:inputBox(ItemRow);
                IncInput:SetText(PerItemSettings.increment);
                IncInput:SetWidth(36);
                IncInput:SetPoint("TOPRIGHT", ItemRow, "TOPRIGHT", -24, 0);
                ItemRow.IncInput = IncInput;

                --[[ MINIMUM ]]
                ---@type EditBox
                local MinInput = Interface:inputBox(ItemRow);
                MinInput:SetText(PerItemSettings.minimum);
                MinInput:SetWidth(42);
                MinInput:SetPoint("TOPRIGHT", IncInput, "TOPLEFT", -8, 0);
                ItemRow.MinInput = MinInput;

                --[[ ITEM LINK ]]
                local BOEString = "";
                if (not bindOnPickup) then
                    BOEString = "BOE ";
                end

                ---@type FontString
                local Name = Interface:createFontString(ItemRow, BOEString .. Details.link);
                Name:SetPoint("CENTER", Icon);
                Name:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
                Name:SetPoint("RIGHT", MinInput, "LEFT", -6, 0);
                Name:SetHeight(20);

                ItemRow.order = GL:tableGet(Auction.Queue, identifier .. ".order", GL:count(Auction.Queue) + 1);

                self.ItemRows[identifier] = ItemRow;
                self:reorderItems();
            end);
        end;

        --[[ HALT/RESUME QUEUE BUTTON ]]
        ---@type Button
        local EnableQueue = Interface:dynamicPanelButton(Queue, L.HALT);
        EnableQueue:SetPoint("BOTTOMLEFT", Queue, "BOTTOMLEFT", 20, 16);
        EnableQueue:SetPoint("RIGHT", Queue, "CENTER", -2, 0);

        if (Settings:get("GDKP.queueIsHalted")) then
            EnableQueue:SetText(L.RESUME);
        end

        EnableQueue:SetScript("OnClick", function ()
            Auctioneer:toggleQueueStatus();

            if (Settings:get("GDKP.queueIsHalted")) then
                EnableQueue:SetText(L.RESUME);
            else
                EnableQueue:SetText(L.HALT);
            end
        end);

        --[[ CLEAR QUEUE ]]
        ---@type Button
        local ClearQueue = Interface:dynamicPanelButton(Queue, L.CLEAR);
        ClearQueue:SetPoint("BOTTOMRIGHT", Queue, "BOTTOMRIGHT", -20, 16);
        ClearQueue:SetPoint("LEFT", Queue, "CENTER", 2, 0);
        ClearQueue:SetScript("OnClick", function ()
            Auctioneer:clearQueue();

            for key, ItemRow in pairs(self.ItemRows or {}) do
                Interface:release(ItemRow);
                self.ItemRows[key] = nil;
            end

            self.ItemRows = {};
        end);
    end

    return Queue;
end

---@param Window Frame
---@return table
function AuctioneerUI:buildBidsTable(Window)
    GL:debug("AuctioneerUI:buildBidsTable");

    local Table = GL.ScrollingTable:CreateST(BIDS_TABLE_COLUMNS, DEFAULT_TABLE_ROWS, HEIGHT_PER_TABLE_ROW, nil, Window);
    Table:EnableSelection(true);
    Table.head:Hide(); -- Remove the table header

    Table:RegisterEvents({
        --[[ RECENTLY WON BY BIDDER TOOLTIP ]]
        OnEnter = function (rowFrame, _, data, _, _, realrow)
            -- Make sure something is actually highlighted, better safe than lua error
            if (not GL:higherThanZero(realrow)
                or type(data) ~= "table"
                or not data[realrow]
                or not data[realrow].cols
                or not data[realrow].cols[1]
            ) then
                return;
            end

            local bidder = data[realrow].cols[1].value;
            local ItemsWonByRollerInTheLast8Hours = GL.AwardedLoot:byWinner(bidder, GetServerTime() - (8 * 60 * 60));

            if (GL:empty(ItemsWonByRollerInTheLast8Hours)) then
                return;
            end

            Interface:addTooltip(rowFrame, {
                string.format("Items won by %s:", bidder),
                " ",
                ItemsWonByRollerInTheLast8Hours,
            });
        end,
    });

    return Table;
end

---@param buildWhenMissing boolean
---@return table|nil
function AuctioneerUI:getBidsTable(buildWhenMissing)
    GL:debug("AuctioneerUI:getBidsTable");

    if (not self.BidsTable and buildWhenMissing) then
        self:build();
    end

    return self.BidsTable;
end

---@return Frame
function AuctioneerUI:getWindow()
    GL:debug("AuctioneerUI:getWindow");

    return _G[self.windowName];
end

---@param buildWhenMissing boolean
---@return Frame|nil
function AuctioneerUI:getQueueWindow(buildWhenMissing)
    GL:debug("AuctioneerUI:getQueueWindow");

    local Window = _G[self.queueWindowName];

    if (not Window and buildWhenMissing) then
        Window = self:build();
        self:close();
    end

    return _G[self.queueWindowName];
end

---@return Frame
function AuctioneerUI:openAuctioneerShortcut()
    GL:debug("AuctioneerUI:openAuctioneerShortcut");

    if (self.isVisible) then
        return;
    end

    local Shortcut = _G[self.auctioneerShortcutName] or self:buildAuctioneerShortcut();
    Shortcut:SetNormalTexture(Auction.Current.itemIcon);
    Shortcut:Show();

    return Shortcut;
end

---@return Frame
function AuctioneerUI:closeAuctioneerShortcut()
    GL:debug("AuctioneerUI:closeAuctioneerShortcut");

    local Shortcut = _G[self.auctioneerShortcutName];

    if (Shortcut) then
        Shortcut:Hide();
    end

    return Shortcut;
end

---@return Frame
function AuctioneerUI:buildAuctioneerShortcut()
    GL:debug("AuctioneerUI:buildAuctioneerShortcut");

    if (_G[self.auctioneerShortcutName]) then
        return _G[self.auctioneerShortcutName];
    end

    local Button = CreateFrame("Button", self.auctioneerShortcutName, UIParent);
    Button:SetSize(42, 42);
    Button:SetNormalTexture(Auction.Current.itemIcon);
    Button:SetText("text");
    Interface:restorePosition(Button);

    Button:SetMovable(true);
    Button:EnableMouse(true);
    Button:SetClampedToScreen(true);
    Button:SetFrameStrata("FULLSCREEN_DIALOG");
    Button:RegisterForDrag("LeftButton");
    Button:SetScript("OnDragStart", Button.StartMoving);
    Button:SetScript("OnDragStop", function()
        Button:StopMovingOrSizing();

        -- Store the frame's last position for future play sessions
        Interface:storePosition(Button);
    end);

    local ButtonHighlight = Button:CreateTexture(nil, "HIGHLIGHT");
    ButtonHighlight:SetAllPoints(Button);
    ButtonHighlight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight");
    ButtonHighlight:SetTexCoord(0, 1, 0.23, 0.77);
    ButtonHighlight:SetBlendMode("ADD");
    Button.ButtonHighlight = ButtonHighlight;

    Button:SetScript("OnMouseUp", function (_, button)
        if (button == "LeftButton") then
            self:open();
            Button:Hide();
        end
    end);

    GL.Interface:addTooltip(Button, "Open auctioneer window", "ANCHOR_TOP");

    return Button;
end

---@param Row Frame
---@return void
function AuctioneerUI:deleteRowFromQueue(Row)
    LCG.PixelGlow_Stop(Row);
    LCG.PixelGlow_Stop(Row.Icon);
    Row:Hide();
    Row._itemLink = nil;
    Row._identifier = nil;
    Interface:release(Row);
    Row = nil;

    self:reorderItems();
end

---@return void
function AuctioneerUI:refreshIconGlows()
    for _, ItemRow in pairs(self.ItemRows or {}) do
        if (ItemRow and ItemRow._itemLink) then
            GL:highlightItem(ItemRow, ItemRow._itemLink);
        end
    end
end

GL:debug("Auctioneer.lua");