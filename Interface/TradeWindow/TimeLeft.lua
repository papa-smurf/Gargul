---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

GL:tableSet(GL, "Interface.TradeWindow.TimeLeft", {
    _initialized = false,
    isVisible = false,
    refreshing = false,
    Bars = {},
});

---@class TradeWindowTimeLeft
local TimeLeft = GL.Interface.TradeWindow.TimeLeft;

---@return void
function TimeLeft:_init()
    GL:debug("TimeLeft:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- Make sure to wait a bit with registering everything after a reload
    -- That way we don't have any stutters or weird behavior like bars not showing up
    GL.Ace:ScheduleTimer(function ()
        GL.Events:register({
            {"TimeLeftBagUpdateDelayedListener", "BAG_UPDATE_DELAYED"},
            {"TimeLeftBagMasterLooterLostListener", "GL.USER_LOST_MASTER_LOOTER"},
            {"TimeLeftBagMasterLooterObtainedListener", "GL.USER_OBTAINED_MASTER_LOOTER"},
        }, function ()
            self:refreshBars();
        end);

        LibStub("LibCandyBarGargul-3.0").RegisterCallback(GL.Ace, "LibCandyBar_Stop", function (_, Bar)
            if (not self:enabled() -- The user doesn't want to see timer bars
                or not Bar
                or type(Bar.Get) ~= "function"
                or Bar:Get("type") ~= "TRADE_WINDOW_TIME_LEFT" -- This is not a timer bar, ignore it!
            ) then
                return;
            end

            self:refreshBars();
        end);

        self:refreshBars();
    end, 3);

    self._initialized = true;
end

---@return void
function TimeLeft:draw()
    GL:debug("Overview:draw");

    -- The overview is already visible
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    local Window = CreateFrame("Frame", "GARGUL_TIMELEFT_WINDOW", UIParent, Frame);
    Window:Show();
    Window:SetSize(240, 16);
    Window:SetPoint(GL.Interface:getPosition("TimeLeft"));

    Window:SetMovable(true);
    Window:EnableMouse(true);
    Window:SetClampedToScreen(true);
    Window:SetFrameStrata("HIGH");
    Window:RegisterForDrag("LeftButton");
    Window:SetScript("OnDragStart", Window.StartMoving);
    Window:SetScript("OnDragStop", function()
        Window:StopMovingOrSizing();
        GL.Interface:storePosition(Window, "TimeLeft");
    end);
    Window:SetScript("OnMouseDown", function (_, button)
        -- Close the roll window on right-click
        if (button == "RightButton") then
            self:close();
        end
    end);

    local Texture = Window:CreateTexture(nil,"BACKGROUND");
    Texture:SetColorTexture(0, 0, 0, .6);
    Texture:SetAllPoints(Window)
    Window.texture = Texture;
    GL.Interface:setItem(self, "Window", Window);

    local Title = Window:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
    Title:SetPoint("TOPLEFT", 3, -3);
    Title:SetText(string.format("%s to roll out loot!", GL.Settings:get("ShortcutKeys.rollOff")));
    Title:SetTextColor(1, 1, 1, 1);

    local Cogwheel = CreateFrame("Button", "TimeLeft_Cogwheel" .. GL:uuid(), Window, Frame);
    Cogwheel:Show();
    Cogwheel:SetClipsChildren(true);
    Cogwheel:SetSize(13, 13);
    Cogwheel:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -2, -3);

    local CogwheelTexture = Cogwheel:CreateTexture();
    CogwheelTexture:SetPoint("BOTTOMRIGHT", 0, 0);
    CogwheelTexture:SetSize(16,16);
    CogwheelTexture:SetTexture("interface\\cursor\\interact");
    CogwheelTexture:SetTexture("interface\\cursor\\unableinteract");
    Cogwheel.texture = CogwheelTexture;

    Cogwheel:SetScript('OnEnter', function()
        CogwheelTexture:SetTexture("interface\\cursor\\interact");
    end);
    Cogwheel:SetScript('OnLeave', function()
        CogwheelTexture:SetTexture("interface\\cursor\\unableinteract");
    end);

    Cogwheel:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            GL.Settings:draw("LootTradeTimers");
        end
    end);

    self:refreshBars();
end

---@return boolean
function TimeLeft:enabled()
    GL:debug("TimeLeft:enabled");

    -- Check if test mode is enabled
    if (GL.Interface.Settings.LootTradeTimers.testEnabled) then
        return true;
    end

    -- Check whether we should be showing the bars at all
    if (not GL.Settings:get("LootTradeTimers.enabled") -- The user disabled this feature
        or ( -- The user only wants to see it when master looting and is not the master looter
            not GL.User.isMasterLooter
            and GL.Settings:get("LootTradeTimers.showOnlyWhenMasterLooting")
        )
    ) then
        return false;
    end

    return true;
end

function TimeLeft:refreshBars()
    GL:debug("TimeLeft:refreshBars");

    -- We're already busy refreshing, return so we don't refresh endlessly
    if (self.refreshing) then
        return;
    end

    if (not self:enabled()) then
        self:stopAllBars();

        return;
    end

    self.refreshing = true;

    local Window = GL.Interface:getItem(self, "Window");

    if (not Window) then
        self:draw();
    end

    Window = GL.Interface:getItem(self, "Window");
    Window:SetHeight(0);

    local ItemsWithTradeTimeRemaining = {};
    local tradeTimeRemainingByLink = {};
    for bag = 0, 4 do
        for slot = 1, GetContainerNumSlots(bag) do
            (function ()
                local icon, _, _, _, _, _, itemLink, _, _ = GetContainerItemInfo(bag, slot);

                -- There's no eligible item in this bag slot
                if (not icon or not itemLink) then
                    return;
                end

                -- The item can not be traded anymore or is not soulbound to begin with
                local timeRemaining = GL:inventoryItemTradeTimeRemaining(bag, slot);
                if (timeRemaining < 1 or timeRemaining == GL.Data.Constants.itemIsNotBound) then
                    return;
                end

                tinsert(ItemsWithTradeTimeRemaining, {
                    icon = icon,
                    itemLink = itemLink,
                    timeRemaining = timeRemaining,
                });

                -- We're not tracking this item yet or this version of the item has a smaller trade time window
                -- I realize that this might not work perfectly with duplicate items in your inventory
                -- but since we always look at the item with the lowest trade duration left it should be fine
                if (not tradeTimeRemainingByLink[itemLink]
                    or tradeTimeRemainingByLink[itemLink] > timeRemaining
                ) then
                    tradeTimeRemainingByLink[itemLink] = timeRemaining;
                end
            end)();
        end
    end

    -- Sort inventory items from shortest to largest trade duration left
    table.sort(ItemsWithTradeTimeRemaining, function (a, b)
        return a.timeRemaining < b.timeRemaining;
    end);

    local barsDiffer = false;
    local numberOfItemsAvailable = #ItemsWithTradeTimeRemaining;

    -- We're already showing timer expiration bars, see if something changed in the meantime
    if (not GL:empty(self.Bars)) then
        -- The number of bars don't match so we're definitely missing some
        if (GL:count(self.Bars) ~= math.max(numberOfItemsAvailable, 5)) then
            barsDiffer = true;
        else
            for _, Bar in pairs(self.Bars) do
                -- If there's no bar for the itemLink or the time remaining differs too much
                if (Bar:Get("type") == "TRADE_WINDOW_TIME_LEFT" -- Ignore non-timer bars
                    and (
                        not tradeTimeRemainingByLink[Bar.itemLink]
                        or (tradeTimeRemainingByLink[Bar.itemLink] - Bar.remaining > 2
                            or tradeTimeRemainingByLink[Bar.itemLink] - Bar.remaining < 2
                        )
                    )
                ) then
                    barsDiffer = true;
                end
            end
        end

    -- We're not showing any bars but there are items available now
    else
        barsDiffer = true;
    end

    -- There's nothing that needs changing
    if (not barsDiffer) then
        self.refreshing = false;
        return;
    end

    self:stopAllBars();

    local barsAvailable = false;
    for index = 1, GL.Settings:get("LootTradeTimers.maximumNumberOfBars", 5) do
        local BagItem = ItemsWithTradeTimeRemaining[index];

        if (GL:empty(BagItem)) then
            break;
        end

        -- Make sure the bar window has the appropriate height
        Window:SetHeight(math.max(Window:GetHeight(), 16) + 18);

        local TimerBar = LibStub("LibCandyBarGargul-3.0"):New(
            "Interface\\AddOns\\Gargul\\Assets\\Textures\\timer-bar",
            240,
            18
        );
        TimerBar:SetParent(Window);
        TimerBar:SetDuration(BagItem.timeRemaining);
        TimerBar:SetColor(0, 1, 0, .3); -- Reset color to green
        TimerBar:SetLabel(BagItem.itemLink);
        TimerBar:SetIcon(BagItem.icon);
        TimerBar:Set("type", "TRADE_WINDOW_TIME_LEFT");

        local offsetY = ((index - 1) * 18) * -1 - 16;
        TimerBar:SetPoint("TOP", Window, "TOP", 0, offsetY);
        TimerBar.candyBarLabel:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE");

        -- Make the bar turn green/yellow/red based on time left
        TimerBar:AddUpdateFunction(function (Bar)
            local percentageLeft = (BagItem.timeRemaining / 7200) * 100;

            if (percentageLeft >= 60) then
                Bar:SetColor(0, 1, 0, .3);
            elseif (percentageLeft >= 30) then
                Bar:SetColor(1, 1, 0, .3);
            else
                Bar:SetColor(1, 0, 0, .3);
            end
        end);

        -- Close the roll window on rightclick
        TimerBar:SetScript("OnMouseDown", function(_, mouseButtonPressed)
            local keyPressIdentifier = GL.Events:getClickCombination(mouseButtonPressed);

            -- Open the roll window
            if (keyPressIdentifier == GL.Settings:get("ShortcutKeys.rollOff")) then
                GL.MasterLooterUI:draw(BagItem.itemLink);

            -- Open the award window
            elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.award")) then
                GL.Interface.Award:draw(BagItem.itemLink);

            -- Unregistered hotkey was pressed and it turns out to be SHIFT_CLICK, add item link to chat/editbox etc
            elseif (keyPressIdentifier == "SHIFT_CLICK") then
                if (ChatFrameEditBox and ChatFrameEditBox:IsVisible()) then
                    ChatFrameEditBox:Insert(BagItem.itemLink);
                else
                    ChatEdit_InsertLink(BagItem.itemLink);
                end
            end
        end)

        TimerBar:SetScript("OnLeave", function()
            GameTooltip:Hide();
        end);

        -- Show a gametooltip for the item up for roll
        -- when hovering over the progress bar
        TimerBar:SetScript("OnEnter", function()
            GameTooltip:SetOwner(Window, "ANCHOR_TOP");
            GameTooltip:SetHyperlink(BagItem.itemLink);
            GameTooltip:Show();
        end);

        TimerBar:Start(7200); -- Default trade duration is two hours
        tinsert(self.Bars, TimerBar);

        barsAvailable = true;
    end

    if (barsAvailable) then
        Window:Show();
    else
        Window:Hide();
    end

    self.refreshing = false;
end

--- Stop all active trade timer bars
---
---@return void
function TimeLeft:stopAllBars()
    GL:debug("TimeLeft:barStopped");

    for _, Bar in pairs(self.Bars) do
        Bar:Stop();
    end

    self.Bars = {};

    local Window = GL.Interface:getItem(self, "Window");

    if (Window) then
        Window:Hide();
    end
end

---@return void
function TimeLeft:close()
    GL:debug("Overview:close");

    local Window = GL.Interface:getItem(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    -- Stop all the bars
    for _, Bar in pairs(self.Bars) do
        Bar:Stop();
    end

    self.Bars = {};

    -- Clear the frame and its widgets
    Window:Hide();
    self.isVisible = false;
end

GL:debug("Interfaces/TMB/Overview.lua");