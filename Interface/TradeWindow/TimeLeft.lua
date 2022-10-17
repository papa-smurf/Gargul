---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

GL:tableSet(GL, "Interface.TradeWindow.TimeLeft", {
    _initialized = false,
    isVisible = false,
    broadcastIsVisible = false,
    dragging = false,
    refreshing = false,
    Bars = {},
    HotKeyExplanation = nil,
    Broadcast = nil,
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

    local Window = CreateFrame("Frame", "GargulUI_RollerUI_Window", UIParent, Frame);
    self.Window = Window;

    Window:Show();
    Window:SetSize(240, 16);
    Window:SetPoint(GL.Interface:getPosition("TimeLeft"));

    Window:SetMovable(true);
    Window:EnableMouse(true);
    Window:SetClampedToScreen(true);
    Window:SetFrameStrata("HIGH");
    Window:RegisterForDrag("LeftButton");

    Window:SetScript("OnDragStart", function ()
        self.dragging = true;
        self:hideExplanationWindow();
        self.BroadCast.frame:SetAlpha(0);
        Window:StartMoving();
    end);
    Window:SetScript("OnDragStop", function()
        self.dragging = false;
        self:showExplanationWindow();

        if (self.broadcastIsVisible) then
            self:showBroadcastWindow();
        end

        Window:StopMovingOrSizing();
        GL.Interface:storePosition(Window, "TimeLeft");

        self:positionExplanationWindow();
    end);
    Window:SetScript("OnMouseDown", function (_, button)
        -- Close the roll window on right-click
        if (button == "RightButton") then
            self:close();
        end
    end);

    self:createHotkeyExplanationWindow();
    self:createBroadcastWindow();

    self:positionExplanationWindow();

    Window:SetScript('OnEnter', function()
        self:showExplanationWindow();
    end);
    Window:SetScript('OnLeave', function()
        self:hideExplanationWindow();
    end);

    local Texture = Window:CreateTexture(nil,"BACKGROUND");
    Texture:SetColorTexture(0, 0, 0, .6);
    Texture:SetAllPoints(Window)
    Window.texture = Texture;
    GL.Interface:setItem(self, "Window", Window);

    local howToRollText = string.format("%s to roll out loot!", GL.Settings:get("ShortcutKeys.rollOff"));
    local howToAwardText = string.format("%s to award loot!", GL.Settings:get("ShortcutKeys.award"));
    local Title = Window:CreateFontString(nil, "ARTWORK", "GameFontNormalSmall");
    Title:SetPoint("TOPLEFT", 3, -3);
    Title:SetText(howToRollText);
    Title:SetTextColor(1, 1, 1, 1);
    Title.headerTextType = "howToRoll";
    GL.Interface:setItem(self, "Header", Title);

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

    local BroadCast = CreateFrame("Button", "TimeLeft_BroadCast" .. GL:uuid(), Window, Frame);
    BroadCast:Show();
    BroadCast:SetClipsChildren(true);
    BroadCast:SetSize(13, 13);
    BroadCast:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -20, -1);

    local BroadCastTexture = BroadCast:CreateTexture();
    BroadCastTexture:SetPoint("BOTTOMRIGHT", 0, 0);
    BroadCastTexture:SetSize(11,11);
    BroadCastTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Icons\\broadcast-highlighted");
    BroadCastTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Icons\\broadcast");
    BroadCast.texture = BroadCastTexture;

    BroadCast:SetScript('OnEnter', function()
        BroadCastTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Icons\\broadcast-highlighted");
    end);
    BroadCast:SetScript('OnLeave', function()
        BroadCastTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Icons\\broadcast");
    end);

    BroadCast:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            self:toggleBroadcastWindow();
        end
    end);

    self:refreshBars();
end

--- Create the hotkey explanation window
---
---@return void
function TimeLeft:createHotkeyExplanationWindow()
    local HotKeyExplanation = GL.AceGUI:Create("InlineGroup");
    self.HotKeyExplanation = HotKeyExplanation;

    HotKeyExplanation:SetLayout("Fill");
    HotKeyExplanation:SetWidth(210);
    HotKeyExplanation:SetHeight(74);
    HotKeyExplanation.frame:SetParent(self.Window);
    self:hideExplanationWindow();

    local Text = GL.AceGUI:Create("Label");
    Text:SetText(string.format(
        "\nRoll: |c00a79eff%s|r\nAward: |c00a79eff%s|r\nDisenchant: |c00a79eff%s|r",
        GL.Settings:get("ShortcutKeys.rollOff"),
        GL.Settings:get("ShortcutKeys.award"),
        GL.Settings:get("ShortcutKeys.disenchant")
    ));
    HotKeyExplanation:AddChild(Text);
    Text:SetJustifyH("MIDDLE");
end

--- Create the hotkey explanation window
---
---@return void
function TimeLeft:createBroadcastWindow()
    local BroadCast = GL.AceGUI:Create("InlineGroup");
    self.BroadCast = BroadCast;

    BroadCast:SetLayout("Fill");
    BroadCast:SetWidth(210);
    BroadCast:SetHeight(110);
    BroadCast.frame:SetParent(self.Window);

    local Text = GL.AceGUI:Create("Label");
    local channel = "party";
    if (GL.User.isInRaid) then
        channel = "raid";
    end
    Text:SetText("Broadcast to " .. channel);
    BroadCast:AddChild(Text);
    Text:SetJustifyH("MIDDLE");

    local BroadcastButton = CreateFrame("Button", "GargulUI_TradeTimers_Broadcast", BroadCast.frame, "GameMenuButtonTemplate");
    BroadcastButton:SetPoint("TOPLEFT", BroadCast.frame, "BOTTOMLEFT", 20, 72);
    BroadcastButton:SetSize(160, 20);
    BroadcastButton:SetText("Broadcast");
    BroadcastButton:SetNormalFontObject("GameFontNormal");
    BroadcastButton:SetHighlightFontObject("GameFontNormal");
    BroadcastButton:SetScript("OnClick", function ()
        local timeFormat1 = "%d:%02d:%02d"
        local timeFormat2 = "%d:%02d"
        local timeFormat3 = "%.1f"
        local timeFormat4 = "%.0f"
        local barNumber = 1;
        local broadcastBars;
        broadcastBars = function()
            local Bar = self.Bars[barNumber];

            if (not Bar or not Bar.Details or Bar.Details.timeRemaining <= 0) then
                return;
            end

            local timeString;
            local time = Bar.Details.timeRemaining;
            if (time > 3599.9) then -- > 1 hour
                local h = floor(time/3600);
                local m = floor((time - (h*3600))/60);
                local s = (time - (m*60)) - (h*3600);
                timeString = string.format(timeFormat1, h, m, s);
            elseif (time > 59.9) then -- 1 minute to 1 hour
                local m = floor(time/60);
                local s = time - (m*60);
                timeString = string.format(timeFormat2, m, s);
            elseif (time < 10) then -- 0 to 10 seconds
                timeString = string.format(timeFormat3, time);
            else -- 10 seconds to one minute
                timeString = string.format(timeFormat4, time);
            end

            GL:sendChatMessage(string.format("%s (%s)",
                Bar.Details.itemLink,
                timeString
            ), "GROUP");

            barNumber = barNumber + 1;
            GL.Ace:ScheduleTimer(function ()
                broadcastBars(barNumber);
            end, .5);
        end;

        broadcastBars();
        self:hideBroadcastWindow();
    end);

    local CancelButton = CreateFrame("Button", "GargulUI_TradeTimers_Broadcast", BroadCast.frame, "GameMenuButtonTemplate");
    CancelButton:SetPoint("TOPLEFT", BroadcastButton, "BOTTOMLEFT", 0, -10);
    CancelButton:SetSize(160, 20);
    CancelButton:SetText("Cancel");
    CancelButton:SetNormalFontObject("GameFontNormal");
    CancelButton:SetHighlightFontObject("GameFontNormal");
    CancelButton:SetScript("OnClick", function ()
        self:hideBroadcastWindow();
    end);
end

function TimeLeft:toggleBroadcastWindow()
    if (self.broadcastIsVisible) then
        self:hideBroadcastWindow();
    else
        self:showBroadcastWindow();
    end
end

function TimeLeft:showBroadcastWindow()
    self.broadcastIsVisible = true;
    self.BroadCast.frame:ClearAllPoints();

    if (GL:inTable({"LEFT", "BOTTOMLEFT", "TOPLEFT"}, select(1, self.Window:GetPoint()))) then
        self.BroadCast.frame:SetPoint("TOPLEFT", self.HotKeyExplanation.frame, "TOPLEFT", 0, 0);
    else
        self.BroadCast.frame:SetPoint("TOPRIGHT", self.HotKeyExplanation.frame, "TOPRIGHT", 0, 0);
    end

    self.BroadCast.frame:SetAlpha(1);
end

function TimeLeft:hideBroadcastWindow()
    self.broadcastIsVisible = false;
    self.BroadCast.frame:SetAlpha(0);
end

--- Position the explanation window either left or right of the trade timer bars depending on its location
---
---@return void
function TimeLeft:positionExplanationWindow()
    -- Position the explanation to the right of the trade timers since there's more space there
    if (GL:inTable({"LEFT", "BOTTOMLEFT", "TOPLEFT"}, select(1, self.Window:GetPoint()))) then
        self.HotKeyExplanation.frame:ClearAllPoints();
        self.HotKeyExplanation.frame:SetPoint("TOPLEFT", self.Window, "TOPRIGHT", 0, 18);

        return;
    end

    self.HotKeyExplanation.frame:ClearAllPoints();
    self.HotKeyExplanation.frame:SetPoint("TOPRIGHT", self.Window, "TOPLEFT", 0, 18);
end;

--- Hide the explanation tooltip-like window
---
---@return void
function TimeLeft:hideExplanationWindow()
    self.HotKeyExplanation.frame:SetAlpha(0);
end

--- Show the explanation tooltip-like window
---
---@return void
function TimeLeft:showExplanationWindow()
    if (self.dragging
        or self.broadcastIsVisible
        or (GL.User.isInGroup and not (GL.User.hasAssist or GL.User.isMasterLooter))
        or not GL.Settings:get("LootTradeTimers.showHotkeyReminder")
    ) then
        return false;
    end

    self.HotKeyExplanation.frame:SetAlpha(1);
    return true;
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
        for slot = 1, C_Container.GetContainerNumSlots(bag) do
            (function ()
                local icon, _, _, _, _, _, itemLink, _, _ = C_Container.GetContainerItemInfo(bag, slot);

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
        TimerBar.Details = BagItem;

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
            -- The user doesnt want to use shortcut keys when solo
            if (not GL.User.isInGroup
                and GL.Settings:get("ShortcutKeys.onlyInGroup")
            ) then
                return;
            end

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
            self:hideExplanationWindow();
            GameTooltip:Hide();
        end);

        -- Show a gametooltip for the item up for roll
        -- when hovering over the progress bar
        TimerBar:SetScript("OnEnter", function()
            if (self:showExplanationWindow()) then
                if (GL:inTable({"BOTTOM", "BOTTOMLEFT", "BOTTOMRIGHT"}, select(1, self.Window:GetPoint()))) then
                    GameTooltip:SetOwner(self.Window, "ANCHOR_TOP");
                else
                    GameTooltip:SetOwner(self.HotKeyExplanation.frame, "ANCHOR_BOTTOM");
                end
            else
                GameTooltip:SetOwner(Window, "ANCHOR_TOP");
            end
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