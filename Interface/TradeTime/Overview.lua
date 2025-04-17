local L = Gargul_L;
local CandyBar = LibStub("LibCandyBarGargul-3.0");

---@type GL
local _, GL = ...;
GL.Interface.TradeTime = GL.Interface and GL.Interface.TradeTime or {};

---@type Constants
local Constants = GL.Data.Constants;

---@type DB
local DB = GL.DB;

---@type Settings
local Settings = GL.Settings;

---@type Events
local Events = GL.Events;

---@type TradeTime
local TradeTime = GL.TradeTime;

---@type SoftRes
local SoftRes = GL.SoftRes;

---@type Interface
local Interface = GL.Interface;

---@class TradeTimeOverviewInterface
GL.Interface.TradeTime.Overview = {
    _initialized = false,

    ---@type string
    windowName = "Gargul.Interface.TradeTime.Overview.Window",

    ---@type table
    HiddenItems = {},

    ---@type table
    ItemRows = {},
};

---@type TradeTimeOverviewInterface
local Overview = GL.Interface.TradeTime.Overview;

--[[ LOCALS ]]
local FONT;
local HEADER_HEIGHT = 20 + GL:remOffset();
local ROW_HEIGHT = 16 + GL:remOffset();
local HIDE_AWARDED = false;
local HIDE_AWARDED_TO_SELF = false;
local HIDE_DISENCHANTED = false;
local MAXIMUM_TRADE_TIME_LEFT = 7200; -- Two hours in seconds

---@return void
function Overview:_init()
    if (self._initialized) then
        return;
    end

    self._initialized = true;
    FONT = GL.FONT;

    -- We fetch these values once on boot in order to increase performance
    HIDE_AWARDED = Settings:get("LootTradeTimers.hideAwarded");
    HIDE_AWARDED_TO_SELF = Settings:get("LootTradeTimers.hideAwardedToSelf");
    HIDE_DISENCHANTED = Settings:get("LootTradeTimers.hideDisenchanted");
    MAXIMUM_TRADE_TIME_LEFT = Settings:get("LootTradeTimers.maximumTradeTimeLeft") * 60;


    Events:register({
        "GL.USER_LOST_MASTER_LOOTER",
        "GL.USER_OBTAINED_MASTER_LOOTER",
    }, function (_)
        GL:after(2, "TradeTimeOverviewInit", function ()
            self:refresh();
        end);
    end);

    Events:register({
        "GL.ITEM_AWARDED",
        "GL.ITEM_UNAWARDED",
        "GL.TRADE_TIME_DURATIONS_CHANGED",
    }, function (_)
        self:refresh();
    end);

    -- Refresh every 60 seconds so that we can dynamically show
    -- items that meet the user's maximumTradeTimeLeft setting
    GL:after(10, "TradeTimeOverviewRefreshInterval", function ()
        GL:interval(60, "TradeTimeOverviewRefreshInterval", function ()
            self:refresh();
        end);
    end);

    -- Make sure to update setting values whenever the user changes a relevant setting
    GL:after(2, "TradeTimeOverviewSettingChangeTimer", function ()
        Settings:onChange("LootTradeTimers.hideAwarded", function ()
            HIDE_AWARDED = Settings:get("LootTradeTimers.hideAwarded");
        end);

        Settings:onChange("LootTradeTimers.hideAwardedToSelf", function ()
            HIDE_AWARDED_TO_SELF = Settings:get("LootTradeTimers.hideAwardedToSelf");
        end);

        Settings:onChange("LootTradeTimers.hideDisenchanted", function ()
            HIDE_DISENCHANTED = Settings:get("LootTradeTimers.hideDisenchanted");
        end);

        Settings:onChange("LootTradeTimers.maximumTradeTimeLeft", function ()
            MAXIMUM_TRADE_TIME_LEFT = Settings:get("LootTradeTimers.maximumTradeTimeLeft") * 60;
        end);
    end);
end

---@return Frame
function Overview:open()
    local Window = _G[self.windowName] or self:build();

    self:setWindowHeight();
    Window:Show();
    return Window;
end

---@return void
function Overview:close()
    for key, Row in pairs(self.ItemRows) do
        if (Row) then
            self:releaseItemRow(Row);
            Row = nil;
            self.ItemRows[key] = nil;
        end
    end

    return _G[self.windowName] and _G[self.windowName]:Hide();
end

---@return Frame
function Overview:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = 250,
        height = 100,
        minWidth = 206,
        minHeight = 60,
        maxWidth = 1600,
        maxHeight = 900,
        hideCloseButton = true,
        closeWithEscape = false,
        hideWatermark = true,
        template = false,
    };

    -- Position move / minimize buttons
    Window.MoveButton:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -22, 0);
    Window.Minimize:SetPoint("TOPRIGHT", Window, "TOPRIGHT", 4, 4);

    -- Position the Resize button
    Window.Resize:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -3, 2);
    Window.Resize:SetFrameLevel(500);

    -- Change its default texture to the "up" variant to increase visibility
    Window.Resize.NormalTexture:SetTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up");
    Window.Resize:SetSize(10, 10);

    -- Only allow changing the width of the window
    Window:HookScript("OnSizeChanged", function ()
        Overview:setWindowHeight();
    end);

    local WindowBackgroundTexture = Window:CreateTexture(nil,"BACKGROUND");
    WindowBackgroundTexture:SetColorTexture(0, 0, 0, .6);
    WindowBackgroundTexture:SetAllPoints(Window)
    Window.texture = WindowBackgroundTexture;
    GL.Interface:set(self, "Window", Window);

    local howToRollText = (L["%s to roll out loot!"]):format(GL.Settings:get("ShortcutKeys.rollOffOrAuction"));
    local howToAwardText =(L["%s to award loot!"]):format(GL.Settings:get("ShortcutKeys.award"));

    local Title = Interface:createFontString(Window, howToRollText);
    Title:SetPoint("TOPLEFT", 22, -5);
    Title:SetTextColor(1, 1, 1, 1);
    Title.headerTextType = "howToRoll";

    -- Keep switching the text in the header from how to roll to how to award
    if (not self.HeaderSwitchTimer) then
        GL:debug("Schedule new TimeLeft.HeaderSwitchTimer");
        self.HeaderSwitchTimer = GL.Ace:ScheduleRepeatingTimer(function ()
            GL:debug("Run TimeLeft.HeaderSwitchTimer");

            if (Title.headerTextType == "howToRoll") then
                Title:SetText(howToAwardText);
                Title.headerTextType = "howToAward";
            else
                Title:SetText(howToRollText);
                Title.headerTextType = "howToRoll";
            end

            -- There are no bars shown, stop the timer
            if (not Window:IsVisible()) then
                GL:debug("Cancel TimeLeft.HeaderSwitchTimer");

                GL.Ace:CancelTimer(self.HeaderSwitchTimer);
                self.HeaderSwitchTimer = nil;
            end
        end, 10);
    end

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L["Broadcast"], notCheckable = true, func = function ()
            Interface.TradeTime.Broadcast:open();
            CloseMenus();
        end },
        "divider",
        {text = L["Hide"], notCheckable = true, SubMenu = {
            {
                text = L["Hide all awarded items"],
                checked = function ()
                    return Settings:get("LootTradeTimers.hideAwarded");
                end,
                func = function (Entry)
                    Settings:set("LootTradeTimers.hideAwarded", Entry.checked);
                end,
            },
            {
                text = L["Hide items awarded to self"],
                checked = function ()
                    return Settings:get("LootTradeTimers.hideAwardedToSelf");
                end,
                func = function (Entry)
                    Settings:set("LootTradeTimers.hideAwardedToSelf", Entry.checked);
                end,
            },
            {
                text = L["Hide disenchanted items"],
                checked = function ()
                    return Settings:get("LootTradeTimers.hideDisenchanted");
                end,
                func = function (Entry)
                    Settings:set("LootTradeTimers.hideDisenchanted", Entry.checked);
                end,
            },
        }},
        "divider",
        {text = L["Window"], isTitle = true, notCheckable = true },
        {text = L["Adjust Scale"], notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
        "divider",
        {text = L["All Settings"], notCheckable = true, func = function ()
            Settings:draw("LootTradeTimers");
            CloseMenus();
        end },
    });

    --[[ CUSTOM MINIMIZED FRAME ]]
    local top, left;
    local oldOnSizeChanged = Window:GetScript("OnSizeChanged");
    local oldOnDragStop = Window.MoveButton:GetScript("OnDragStop");
    Window.Minimize.MinimizeButton:SetScript("OnClick", function ()
        top, left = Window:GetTop(), Window:GetLeft();
        Window:SetScript("OnSizeChanged", function () end);
        Window.MoveButton:SetScript("OnDragStop", function ()
            Window:StopMovingOrSizing();
            Window.MoveButton:SetButtonState("NORMAL");
            top, left = Window:GetTop(), Window:GetLeft();
        end);
        Window:ClearAllPoints();
        Window:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top);
        Window.Minimize.MinimizeButton:Hide();
        Window.Minimize.MaximizeButton:Show();
        Window.Resize:Hide();

        self.minimized = true;
        self:refresh();
        Settings:set("LootTradeTimers.minimize", true);
    end);
    Window.Minimize.MaximizeButton:SetScript("OnClick", function ()
        Window:SetScript("OnSizeChanged", oldOnSizeChanged);
        Window.MoveButton:SetScript("OnDragStop", oldOnDragStop);
        Interface:restoreDimensions(Window);
        Window:ClearAllPoints();
        Window:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top);
        Window.Minimize.MinimizeButton:Show();
        Window.Minimize.MaximizeButton:Hide();
        Window.Resize:Show();

        self.minimized = false;
        self:refresh();
        Settings:set("LootTradeTimers.minimize", false);
    end);

    ---@type Frame
    local ActionButtons;

    do -- [[ ACTION BUTTONS ]]
        ---@type Frame
        ActionButtons = CreateFrame("Frame", nil, Window);
        ActionButtons:SetSize(ROW_HEIGHT, ROW_HEIGHT);
        ActionButtons:Hide();

        --[[ BID BUTTON ]]
        ---@type Button
        local HideButton = CreateFrame("Button", nil, ActionButtons, "UIPanelButtonTemplate");
        HideButton:SetSize(ROW_HEIGHT, ROW_HEIGHT);
        HideButton:SetPoint("TOPLEFT", ActionButtons, "TOPLEFT");

        ---@type Texture
        local NormalTexture = HideButton:CreateTexture();
        NormalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/eye");
        NormalTexture:SetAllPoints(HideButton);
        HideButton:SetNormalTexture(NormalTexture);

        ---@type Texture
        local HighlightTexture = HideButton:CreateTexture();
        HighlightTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/bag");
        NormalTexture:SetAllPoints(HideButton);
        HideButton:SetHighlightTexture(HighlightTexture);

        Interface:addTooltip(HideButton, L["Hide"]);

        HideButton:HookScript("OnLeave", function ()
            if (Interface:mouseIsOnFrame(Window)) then
                return;
            end

            ActionButtons:Hide();
        end);

        ActionButtons.HideButton = HideButton;
    end

    Window.ActionButtons = ActionButtons;

    if (Settings:get("LootTradeTimers.minimize")) then
        Window.Minimize.MinimizeButton:Click();
    end

    _G[self.windowName] = Window;
    return Window;
end

---@return void
function Overview:refresh()
    local State = TradeTime:getState() or {};

    -- There's nothing to show!
    if (type(State) ~= "table" or GL:empty(State)) then
        return self:close();
    end

    -- Check if we're allowed to show bars based on settings
    if (not self:barsEnabled()) then
        return self:close();
    end

    ---@type Frame
    local Window = _G[self.windowName] or self:build();

    -- This item no longer has a trade time remaining
    -- or the player opted to not show the item on the list
    for itemGUID, Row in pairs(self.ItemRows or {}) do
        if (not State[itemGUID] or self.HiddenItems[itemGUID]) then
            self:releaseItemRow(Row);
            Row = nil;
            self.ItemRows[itemGUID] = nil;
        end
    end

    ---@type Frame
    local ActionButtons = Window.ActionButtons;

    -- Add newly acquired items to the list
    for itemGUID, Details in pairs(State) do
        local AwardDetails = DB:get("RecentlyAwardedItems." .. Details.itemGUID);
        local disenchanted = AwardDetails and AwardDetails.awardedTo == GL.Exporter.disenchantedItemIdentifier;
        local awarded = not disenchanted and not not AwardDetails;
        local awardedToSelf = awarded and not disenchanted and GL:iEquals(AwardDetails.awardedTo, GL.User.fqn);
        local itemIsTooNew = Details.secondsRemaining > MAXIMUM_TRADE_TIME_LEFT;

        if (not self.ItemRows[itemGUID]
            and not self.HiddenItems[itemGUID]
        ) then
            ---@type Frame
            local ItemRow = self:buildItemRow(Details, Window, ActionButtons);
            self.ItemRows[itemGUID] = ItemRow;
        end

        if (self.ItemRows[itemGUID] and (
            itemIsTooNew
            or (awarded and HIDE_AWARDED)
            or (awardedToSelf and HIDE_AWARDED_TO_SELF)
            or (disenchanted and HIDE_DISENCHANTED)
        )) then
            local Row = self.ItemRows[itemGUID];
            self:releaseItemRow(Row);
            self.ItemRows[itemGUID] = nil;
            Row = nil;
        end
    end

    local Values = GL:tableValues(State);

    -- Sort by time remaining (low > high)
    table.sort(Values, function (a, b)
        return a.secondsRemaining
            and b.secondsRemaining
            and a.secondsRemaining < b.secondsRemaining;
    end);

    -- Order all items based on their time remaining
    local i = 1;
    for _, Details in pairs(Values or {}) do
        if (self.ItemRows[Details.itemGUID]) then
            self.ItemRows[Details.itemGUID].order = i;
            i = i + 1;
            self.ItemRows[Details.itemGUID]:Hide();
        end
    end

    -- Position the items according to their time remaining
    local rowsShown = 0;
    local maxNumberOfItems = GL.Settings:get("LootTradeTimers.maximumNumberOfBars");
    for _, ItemRow in pairs(self.ItemRows or {}) do
        (function ()
            -- No need to show more than one item if we're minimized
            if (self.minimized and ItemRow.order > 1) then
                return;
            end

            -- We don't want to show this many items
            if (ItemRow.order > maxNumberOfItems) then
                return;
            end

            ItemRow:SetPoint("TOP", Window, "TOP", 0, (ItemRow.order - 1) * -ROW_HEIGHT - 20);

            -- Make sure the icon is correct (item icon / disenchanted / awarded
            ItemRow.updateIcon();

            -- Show the item
            ItemRow:Show();

            rowsShown = rowsShown + 1;
        end)();
    end

    self.rowsShown = rowsShown;
    if (rowsShown <= 0) then
        return self:close();
    end

    self:open();
end

--- Determine the window height based on the number of items shown
---
---@return void
function Overview:setWindowHeight()
    local Window = _G[self.windowName] or self:build();
    Window:SetHeight(HEADER_HEIGHT + (self.rowsShown * ROW_HEIGHT));
end

--- Check whether we should be showing the bars at all
---@return boolean
function Overview:barsEnabled()
    return (GL.Settings:get("LootTradeTimers.enabled")
        and (GL.User.isMasterLooter
            or not GL.Settings:get("LootTradeTimers.showOnlyWhenMasterLooting")
        )
    );
end

---@param Details table
---@param ActionButtons Frame
---@return Frame
function Overview:buildItemRow(Details, Window, ActionButtons)
    ---@type Frame
    local ItemRow = CreateFrame("Frame", nil, Window);
    ItemRow:SetHeight(ROW_HEIGHT);
    ItemRow:SetPoint("LEFT", Window, "LEFT", 0, 0);
    ItemRow:SetPoint("RIGHT", Window, "RIGHT", 0, 0);

    local CountDownBar = CandyBar:New(
        "Interface/AddOns/Gargul/Assets/Textures/timer-bar",
        240,
        ROW_HEIGHT
    );
    CountDownBar:Set("type", "TRADE_TIME_LEFT");
    CountDownBar:Set("itemGUID", Details.itemGUID);
    CountDownBar:SetParent(ItemRow);
    CountDownBar:SetDuration(Details.secondsRemaining);
    CountDownBar:SetColor(0, 1, 0, .3); -- Reset color to green
    CountDownBar.candyBarLabel:SetFont(FONT, GL:rem(1.2), "OUTLINE");
    CountDownBar:SetLabel(" " .. Details.itemLink);
    CountDownBar:SetAllPoints(ItemRow);
    CountDownBar:SetTimeVisibility(false);

    CountDownBar:SetScript("OnMouseUp", function (_, mouseButtonPressed)
        -- Allow selling an item from the trade timer bars by right clicking
        if (mouseButtonPressed == "RightButton") then
            if (GL.merchantIsShown) then
                local bag, slot = GL:getBagAndSlotByGUID(Details.itemGUID);

                if (bag) then
                    GL:useContainerItem(bag, slot);
                end
            end

            return;
        end

        HandleModifiedItemClick(Details.itemLink, mouseButtonPressed);
    end);

    ItemRow.updateIcon = function ()
        ItemRow.awarded = false;
        ItemRow.disenchanted = false;

        CountDownBar:SetIcon(Details.itemIcon);
        local AwardDetails = DB:get("RecentlyAwardedItems." .. Details.itemGUID);

        if (AwardDetails) then
            if (AwardDetails.awardedTo == GL.Exporter.disenchantedItemIdentifier) then
                CountDownBar:SetIcon("Interface/AddOns/Gargul/Assets/Icons/disenchant");
                ItemRow.awarded = true;
            else
                CountDownBar:SetIcon("Interface/AddOns/Gargul/Assets/Icons/trophy");
                ItemRow.disenchanted = true;
            end
        end
    end
    ItemRow.updateIcon();

    CountDownBar:SetScript("OnLeave", function()
        CountDownBar:SetTimeVisibility(false);

        GameTooltip:Hide();

        if (not Interface:mouseIsOnFrame(ActionButtons)) then
            ActionButtons:Hide();
        end
    end);

    -- Show a tooltip for the item up for roll
    -- when hovering over the progress bar
    CountDownBar:SetScript("OnEnter", function()
        CountDownBar:SetTimeVisibility(true);

        GameTooltip:SetOwner(ItemRow);
        GameTooltip:SetHyperlink(Details.itemLink);
        GameTooltip:Show();

        ActionButtons:ClearAllPoints();
        ActionButtons:SetPoint("TOPLEFT", ItemRow, "TOPLEFT", 0, 0);
        ActionButtons:SetFrameLevel(CountDownBar:GetFrameLevel() + 1);

        ActionButtons:Show();

        -- Hide this item
        ActionButtons.HideButton:SetScript("OnClick", function ()
            if (IsModifierKeyDown()) then
                return;
            end

            self:hideItemRow(Details.itemGUID);
            ActionButtons:Hide();
        end);
    end);

    local itemIsHardReserved, itemIsSoftReserved, itemIsWishListed, itemIsPrioritized;
    local updateReservationDetails = function()
        -- Check if this item is reserved
        itemIsHardReserved = SoftRes:linkIsHardReserved(Details.itemLink);
        itemIsSoftReserved = not itemIsHardReserved and SoftRes:linkIsReserved(Details.itemLink);

        -- Check if this item is on TMB
        itemIsWishListed, itemIsPrioritized = false, false;
        local TMBInfo = GL.TMB:byItemLink(Details.itemLink) or {};
        for _, Entry in pairs(TMBInfo or {}) do
            itemIsWishListed = true;

            if (Entry.type == Constants.tmbTypePrio) then
                itemIsPrioritized = true;
                break;
            end
        end
        itemIsWishListed = not itemIsPrioritized and itemIsWishListed;
    end

    Events:register({
        { "TradeTimeOverviewSoftresImported" .. Details.itemGUID, "GL.SOFTRES_IMPORTED" },
        { "TradeTimeOverviewSoftresCleared" .. Details.itemGUID, "GL.SOFTRES_CLEARED" },
        { "TradeTimeOverviewTMBImported" .. Details.itemGUID, "GL.TMB_IMPORTED" },
        { "TradeTimeOverviewTMBCleared" .. Details.itemGUID, "GL.TMB_CLEARED" },
    }, updateReservationDetails);
    updateReservationDetails();

    -- Make the bar turn green/yellow/red based on time left
    CountDownBar:AddUpdateFunction(function (Bar)
        if (CountDownBar.remaining > MAXIMUM_TRADE_TIME_LEFT) then
            self:releaseItemRow(self.ItemRows[Details.itemGUID]);

            return;
        end

        local percentageLeft = (CountDownBar.remaining / 7200) * 100;

        if (itemIsHardReserved) then
            Bar:SetColor(.77, .12, .23, 1);
        elseif (itemIsSoftReserved) then
            Bar:SetColor(.95686, .5490, .72941, 1);
        elseif (itemIsPrioritized) then
            Bar:SetColor(1, .48627, .0392, 1);
        elseif (itemIsWishListed) then
            Bar:SetColor(1, 1, 1, 1);
        elseif (ItemRow.awarded or ItemRow.disenchanted) then
            Bar:SetColor(0, 0, 0, .6);
        elseif (percentageLeft >= 60) then
            Bar:SetColor(0, 1, 0, .3);
        elseif (percentageLeft >= 30) then
            Bar:SetColor(1, 1, 0, .3);
        else
            Bar:SetColor(1, 0, 0, .3);
        end
    end);

    CandyBar.RegisterCallback(GL.Ace, "LibCandyBar_Stop", function (_, Bar)
        if (Bar
            and Bar.Get
            and Bar:Get("type") == "TRADE_TIME_LEFT"
            and not Bar:Get("stopping")
        ) then
            local itemGUID = Bar:Get("itemGUID");

            if (type(itemGUID) == "string"
                and not GL:empty(itemGUID)
            ) then
                self:hideItemRow(itemGUID, false);
            end
        end
    end);

    CountDownBar:Start(7200); -- Default trade duration is two hours
    ItemRow.CountDownBar = CountDownBar;

    return ItemRow;
end

---@param itemGUID string
---@return void
function Overview:hideItemRow(itemGUID)
    self.HiddenItems[itemGUID] = true;

    self:refresh();
end

--- Release an ItemRow (aka remove it, hide it, take care of the countdown bar it holds)
---
---@param ItemRow Frame
---@return void
function Overview:releaseItemRow(ItemRow)
    if (type(ItemRow) ~= "table") then
        return;
    end

    local CountDownBar = ItemRow.CountDownBar;
    if (type(CountDownBar) == "table"
        and CountDownBar.Get
        and CountDownBar:Get("type") == "TRADE_TIME_LEFT"
        and not CountDownBar:Get("stopping")
    ) then
        CountDownBar:SetParent(UIParent);
        CountDownBar:Set("stopping", true);

        if (CountDownBar.running) then
            CountDownBar:Stop();
        end
    end

    Interface:release(ItemRow);
end
