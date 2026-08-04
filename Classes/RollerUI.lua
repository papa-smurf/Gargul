local L = Gargul_L;

---@type GL
local _, GL = ...;

---@class RollerUI
GL.RollerUI = GL.RollerUI or {
    Window = nil,
    RollTrackerFrame = nil,
    rollTrackerExpanded = false,
    rollTrackerScrollOffset = 0,
};
local RollerUI = GL.RollerUI; ---@type RollerUI

local ROLL_TRACKER_ROW_HEIGHT = 16;
local ROLL_TRACKER_MAX_VISIBLE = 3;

---@param showRollAccepted? boolean Show "Roll accepted!" when draw completes (e.g. after auto-roll)
---@return boolean
function RollerUI:show(time, itemLink, itemIcon, note, SupportedRolls, bth, boostedRollIdentifier, showRollAccepted)
    if (self.Window and self.Window:IsShown()) then
        return false;
    end

    -- Make sure we can adjust the roller UI accordingly when a player can't use the item
    GL:canUserUseItem(itemLink, function (userCanUseItem)
        if (not userCanUseItem
            and GL.Settings:get("Rolling.dontShowOnUnusableItems", false)
        ) then
            return false;
        end

        self:draw(time, itemLink, itemIcon, note, SupportedRolls, userCanUseItem, bth, boostedRollIdentifier);

        if (showRollAccepted and self.Window) then
            self:showRollAcceptedNotification(self.Window);
        end
    end);

    return true;
end

--- Note: we're not using AceGUI here since getting a SimpleGroup to move properly is a friggin nightmare
---
---@param time number The duration of the RollOff
---@param itemLink string
---@param itemIcon string
---@param note string
---@param bth table|nil
---@param boostedRollIdentifier string|nil Identifier of the boosted roll button (e.g. "BR")
---@return boolean
function RollerUI:draw(time, itemLink, itemIcon, note, SupportedRolls, userCanUseItem, bth, boostedRollIdentifier)
    local Window = CreateFrame("Frame", "GargulUI_RollerUI_Window", UIParent, Frame);
    Window:SetSize(350, 48);
    Window:SetPoint(GL.Interface:getPosition("Roller"));

    Window:SetMovable(true);
    Window:EnableMouse(true);
    Window:SetClampedToScreen(true);
    Window:SetFrameStrata("FULLSCREEN_DIALOG");
    Window:RegisterForDrag("LeftButton");
    Window:SetScript("OnDragStart", Window.StartMoving);
    Window:SetScript("OnDragStop", function ()
        Window:StopMovingOrSizing();
        GL.Interface:storePosition(Window, "Roller");
    end);
    Window:SetScript("OnMouseDown", function (_, button)
        -- Close the roll window on right-click
        if (button == "RightButton") then
            self:hide();
            return;
        end

        HandleModifiedItemClick(itemLink, button);
    end);
    Window:SetScale(GL.Settings:get("Rolling.scale", 1));
    Window.ownedByGargul = true; -- We used this in the tooltip check later
    self.Window = Window;

    local Texture = Window:CreateTexture(nil,"BACKGROUND");
    Texture:SetColorTexture(0, 0, 0, .6);
    Texture:SetAllPoints(Window)
    Window.texture = Texture;

    local RollButtons = {};
    local numberOfButtons = #SupportedRolls;

    local rollerUIWidth = 0;
    for i = 1, numberOfButtons do
        local RollDetails = SupportedRolls[i] or {};

        local identifier = RollDetails[1];
        local min = math.floor(tonumber(RollDetails[2]) or 0);
        local max = math.floor(tonumber(RollDetails[3]) or 0);

        -- There are no more buttons to display
        if (GL:empty(identifier)) then
            break;
        end

        -- Roll button
        local Button = CreateFrame("Button", nil, Window, "GameMenuButtonTemplate");
        Button:SetText(identifier);
        Button:SetNormalFontObject("GameFontNormal");
        Button:SetHighlightFontObject("GameFontNormal");

        -- Base the width on the actual rendered text width rather than byte length
        local FontString = Button:GetFontString();
        local textWidth = FontString and FontString:GetStringWidth() or 0;
        local buttonWidth = math.max(math.ceil(textWidth) + 20, 70);
        rollerUIWidth = rollerUIWidth + buttonWidth + 4;
        Button:SetSize(buttonWidth, 20);

        if (not userCanUseItem) then
            Button:Disable();
            Button:SetMotionScriptsWhileDisabled(true);

            -- Make sure rolling is still possible in case something was amiss!
            Button:SetScript("OnEnter", function ()
                Button:Enable();
            end);

            Button:SetScript("OnLeave", function ()
                Button:Disable();
            end);
        end

        local isBoostedRollButton = boostedRollIdentifier and GL:iEquals(identifier, boostedRollIdentifier);

        if (isBoostedRollButton) then
            local existingOnEnter = Button:GetScript("OnEnter");
            local existingOnLeave = Button:GetScript("OnLeave");

            Button:SetScript("OnEnter", function ()
                if (existingOnEnter) then
                    existingOnEnter(Button);
                end

                local tooltipText;
                if (GL.BoostedRolls:hasPoints(GL.User.fqn)) then
                    local points = GL.BoostedRolls:getPoints(GL.User.fqn);
                    tooltipText = (L["Points: %s"]):format(tostring(points));
                else
                    tooltipText = (L["Points: %s"]):format(L["N/A"]);
                end

                GameTooltip:SetOwner(Button, "ANCHOR_TOP");
                GameTooltip:SetText(tooltipText);
                GameTooltip:Show();
            end);
            Button:SetScript("OnLeave", function ()
                GameTooltip:Hide();
                if (existingOnLeave) then
                    existingOnLeave(Button);
                end
            end);
        end

        Button:SetScript("OnClick", function ()
            RandomRoll(min, max);

            if (GL.Settings:get("Rolling.closeAfterRoll")) then
                self:hide();
            else
                self:showRollAcceptedNotification(Window);
            end
        end);

        if (i == 1) then
            Button:SetPoint("TOPLEFT", Window, "TOPLEFT", 2, -1);
        else
            Button:SetPoint("TOPLEFT", RollButtons[i - 1], "TOPRIGHT", 1, 0);
        end

        tinsert(RollButtons, Button);
    end

    -- Auto roll discovery hint: show only for simple MS/OS roll (2 buttons), not when BR or other buttons are present
    if (not GL.AutoRoll:hasAnyRulesInAnyProfile() and numberOfButtons == 2) then
        local AutoRollHint = Window:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
        AutoRollHint:SetText(("|c00%s%s: |c00FFFFFF/gl autoroll|r"):format(GL.Data.Constants.addonHexColor, L["Auto Roll"]));
        AutoRollHint:SetPoint("RIGHT", Window, "TOPRIGHT", -58, -11);
    end

    local PassButton = CreateFrame("Button", "GargulUI_RollerUI_Pass", Window, "GameMenuButtonTemplate");
    PassButton:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -3, -1);
    PassButton:SetSize(50, 20);
    PassButton:SetText(L["Pass"]);
    PassButton:SetNormalFontObject("GameFontNormal");
    PassButton:SetHighlightFontObject("GameFontNormal");
    PassButton:SetScript("OnClick", function ()
        self:hide();
    end);

    rollerUIWidth = math.max(rollerUIWidth + 54, 350);
    Window:SetWidth(rollerUIWidth);

    ---@type Frame
    local IdentityWindow, position = GL.Interface.Identity:buildForRoller(bth);
    IdentityWindow:SetParent(Window);

    if (type(position) ~= "function") then
        IdentityWindow:SetPoint("TOPLEFT", Window, "TOPRIGHT", 0, 0);
    else
        position(IdentityWindow, Window);
    end

    self:drawCountdownBar(time, itemLink, itemIcon, note, userCanUseItem, rollerUIWidth);
    self:drawRollTracker(rollerUIWidth);
end

--- Draw the countdown bar
---
---@param time number
---@param itemLink string
---@param itemIcon string
---@param note string
---@return nil
function RollerUI:drawCountdownBar(time, itemLink, itemIcon, note, userCanUseItem, width)
    -- This shouldn't be possible but you never know!
    if (not self.Window) then
        return false;
    end

    local TimerBar = LibStub("LibCandyBarGargul-3.0"):New(
        "Interface/AddOns/Gargul/Assets/Textures/timer-bar",
        width,
        24
    );
    self.TimerBar = TimerBar;

    TimerBar:SetParent(self.Window);
    TimerBar:SetPoint("BOTTOM", self.Window, "BOTTOM");
    TimerBar.candyBarLabel:SetFont(GL.FONT, 12, "OUTLINE");

    -- Make the bar turn green/yellow/red based on time left
    TimerBar:AddUpdateFunction(function (Bar)
        if (not userCanUseItem) then
            TimerBar:SetColor(0, 0, 0, .1);
            return;
        end

        local percentageLeft = 100 / (time / Bar.remaining);

        if (percentageLeft >= 60) then
            Bar:SetColor(0, 1, 0, .3);
        elseif (percentageLeft >= 30) then
            Bar:SetColor(1, 1, 0, .3);
        else
            Bar:SetColor(1, 0, 0, .3);
        end
    end);

    -- Close the roll window on rightclick
    TimerBar:SetScript("OnMouseDown", function (_, button)
        if (button == "RightButton") then
            self:hide();
        end
    end)

    TimerBar:SetDuration(time);

    -- Reset color to green or disabled
    if (userCanUseItem) then
        TimerBar:SetColor(0, 1, 0, .3);
    else
        TimerBar:SetColor(0, 0, 0, .1);
    end

    note = note or "";
    TimerBar:SetLabel("  " .. itemLink);

    if (not userCanUseItem) then
        TimerBar:SetLabel(("  |c00FFFFFF%s|r"):format(L["You can't use this item!"]));
    end

    TimerBar:SetIcon(itemIcon);
    TimerBar:Set("type", "ROLLER_UI_COUNTDOWN");
    TimerBar:Start();

    local lastShiftStatus;
    local itemTooltipIsShowing = false;
    local refreshTooltip = function ()
        GameTooltip:Hide();

        if (not self.Window) then
            return;
        end

        GameTooltip:SetOwner(self.Window, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
        itemTooltipIsShowing = true;
    end;

    -- Show a gametooltip for the item up for roll
    -- when hovering over the progress bar
    TimerBar:SetScript("OnEnter", function ()
        lastShiftStatus = IsShiftKeyDown();

        GameTooltip:SetOwner(self.Window, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
        itemTooltipIsShowing = true;
    end);

    TimerBar:SetScript("OnLeave", function ()
        GameTooltip:Hide();
        itemTooltipIsShowing = false;
    end);

    GL.Events:register("RollerUIModifierStateChanged", "MODIFIER_STATE_CHANGED", function (_, key, pressed)
        if (not itemTooltipIsShowing
            or (key ~= "LSHIFT" and key ~= "RSHIFT")
        ) then
            return;
        end

        if (lastShiftStatus ~= pressed) then
            refreshTooltip();
            lastShiftStatus = pressed;
        end
    end);
end

--- Create a single roll row frame with 4 text columns and gear widgets.
---
---@param parent Frame
---@param width number
---@return Frame
function RollerUI:createRollRow(parent, width)
    local Row = CreateFrame("Frame", nil, parent);
    Row:SetSize(width, ROLL_TRACKER_ROW_HEIGHT);

    local NameText = Row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    NameText:SetPoint("LEFT", Row, "LEFT", 1, 0);
    NameText:SetWidth(100);
    NameText:SetJustifyH("LEFT");

    local RollText = Row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    RollText:SetPoint("LEFT", NameText, "RIGHT", 2, 0);
    RollText:SetWidth(35);
    RollText:SetJustifyH("LEFT");

    local PlusOneText = Row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    PlusOneText:SetPoint("LEFT", RollText, "RIGHT", 2, 0);
    PlusOneText:SetWidth(35);
    PlusOneText:SetJustifyH("LEFT");

    local TypeText = Row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    TypeText:SetPoint("LEFT", PlusOneText, "RIGHT", 2, 0);
    TypeText:SetWidth(50);
    TypeText:SetJustifyH("LEFT");

    Row.NameText = NameText;
    Row.RollText = RollText;
    Row.PlusOneText = PlusOneText;
    Row.TypeText = TypeText;

    -- Gear panel toggle, matching the master looter table's cell
    local GearArrow = CreateFrame("Button", nil, Row);
    GearArrow:SetSize(14, ROLL_TRACKER_ROW_HEIGHT);
    local GearArrowText = GearArrow:CreateFontString(nil, "OVERLAY", GL.Data.Constants.GearPanelToggle.font);
    GearArrowText:SetAllPoints(GearArrow);
    GearArrowText:SetJustifyH("CENTER");
    GearArrow:Hide();
    Row.GearArrow = GearArrow;
    Row.GearArrowText = GearArrowText;

    -- Right gear icon slot
    local GearIcon2 = CreateFrame("Button", nil, Row);
    GearIcon2:SetSize(14, 14);
    GearIcon2.Texture = GearIcon2:CreateTexture(nil, "ARTWORK");
    GearIcon2.Texture:SetAllPoints(GearIcon2);
    GearIcon2:Hide();
    Row.GearIcon2 = GearIcon2;

    -- Left gear icon slot
    local GearIcon1 = CreateFrame("Button", nil, Row);
    GearIcon1:SetSize(14, 14);
    GearIcon1.Texture = GearIcon1:CreateTexture(nil, "ARTWORK");
    GearIcon1.Texture:SetAllPoints(GearIcon1);
    GearIcon1:Hide();
    Row.GearIcon1 = GearIcon1;

    -- Anchor chain from the right, clear of the 5px scroll track region
    GearArrow:SetPoint("RIGHT", Row, "RIGHT", -8, 0);
    GearIcon2:SetPoint("RIGHT", GearArrow, "LEFT", -2, 0);
    GearIcon1:SetPoint("RIGHT", GearIcon2, "LEFT", -2, 0);

    return Row;
end

--- Populate a row frame with roll data
---
---@param Row Frame
---@param Entry table
---@return nil
function RollerUI:fillRollRow(Row, Entry)
    local coloredName = GL:classColorize(Entry.displayName, Entry.class);
    Row.NameText:SetText(coloredName);
    Row.RollText:SetText(tostring(Entry.amount));
    Row.RollText:SetTextColor(1, 1, 1);

    if (GL:higherThanZero(Entry.plusOnes)) then
        Row.PlusOneText:SetText("+" .. Entry.plusOnes);
    else
        Row.PlusOneText:SetText("");
    end
    Row.PlusOneText:SetTextColor(.8, .8, .8);

    Row.TypeText:SetText(Entry.classification or "");
    Row.TypeText:SetTextColor(.8, .8, .8);

    self:fillGearWidgets(Row, Entry);
end

--- Populate the gear icon widgets and panel arrow on a roll row.
---
---@param Row Frame
---@param Entry table
---@return nil
function RollerUI:fillGearWidgets(Row, Entry)
    if (not Row.GearIcon1) then
        return;
    end

    local Gear = GL.RollOff:gearDisplayForRollEntry(Entry);
    local placeholderIcon = GL.Data.Constants.gearPlaceholderIcon;

    local function fillIcon(Icon, dehydratedLink, placeholder)
        if (not dehydratedLink and not placeholder) then
            Icon:Hide();
            Icon:SetScript("OnEnter", nil);
            Icon:SetScript("OnLeave", nil);
            return;
        end

        Icon.Texture:SetTexture(placeholderIcon);
        Icon:SetAlpha(Gear.alpha);
        Icon:Show();

        if (placeholder) then
            Icon:SetScript("OnEnter", function ()
                GameTooltip:SetOwner(Icon, "ANCHOR_TOP");
                GameTooltip:AddLine(L["No worn gear to compare with this item"]);
                GameTooltip:Show();
            end);
            Icon:SetScript("OnLeave", function ()
                GameTooltip:Hide();
            end);
            return;
        end

        local itemID = GL:itemIDFromDehydratedLink(dehydratedLink);
        if (itemID) then
            GL:onItemLoadDo(itemID, function (Details)
                if (not Details or not Icon.Texture) then
                    return;
                end
                Icon.Texture:SetTexture(Details.icon or placeholderIcon);
            end);
        end

        Icon:SetScript("OnEnter", function ()
            GameTooltip:SetOwner(Icon, "ANCHOR_TOP");
            GL:hydrateItemLink(dehydratedLink, function (itemLink)
                if (itemLink) then
                    GameTooltip:SetHyperlink(itemLink);
                    GameTooltip:Show();
                end
            end);
        end);
        Icon:SetScript("OnLeave", function ()
            GameTooltip:Hide();
        end);
    end

    fillIcon(Row.GearIcon1, Gear.leftLink, false);
    fillIcon(Row.GearIcon2, Gear.rightLink, Gear.placeholder);

    if (Gear.hasGear and Gear.playerKey) then
        Row.GearArrowText:SetText(GL.Data.Constants.GearPanelToggle.label);
        Row.GearArrow:Show();
        Row.GearArrow:SetScript("OnEnter", function ()
            GameTooltip:SetOwner(Row.GearArrow, "ANCHOR_TOP");
            GameTooltip:AddLine(L["Show all worn items"]);
            GameTooltip:Show();
        end);
        Row.GearArrow:SetScript("OnLeave", function ()
            GameTooltip:Hide();
        end);
        local player = Entry.player;
        Row.GearArrow:SetScript("OnClick", function ()
            GL.Interface.GearPanel:toggle(
                player,
                GL.RollerUI.Window,
                { point = "TOPRIGHT", relativePoint = "TOPLEFT", x = -5, y = 0, }
            );
        end);
    else
        Row.GearArrow:Hide();
    end
end

--- Draw the roll tracker panel below the countdown bar
---
---@param width number
---@return nil
function RollerUI:drawRollTracker(width)
    if (not self.Window) then
        return;
    end

    if (not GL.Settings:get("Rolling.showRollTracker")) then
        return;
    end

    self.rollTrackerScrollOffset = 0;

    local Window = self.Window;
    local Tracker = CreateFrame("Frame", nil, Window);
    Tracker:SetSize(width, ROLL_TRACKER_ROW_HEIGHT);
    Tracker:SetPoint("TOPLEFT", Window, "BOTTOMLEFT", 0, 0);
    Tracker:Hide();

    Tracker:EnableMouse(true);
    Tracker:RegisterForDrag("LeftButton");
    Tracker:SetScript("OnDragStart", function ()
        Window:StartMoving();
    end);
    Tracker:SetScript("OnDragStop", function ()
        Window:StopMovingOrSizing();
        GL.Interface:storePosition(Window, "Roller");
    end);

    local TrackerBG = Tracker:CreateTexture(nil, "BACKGROUND");
    TrackerBG:SetColorTexture(0, 0, 0, .5);
    TrackerBG:SetAllPoints(Tracker);

    self.RollTrackerFrame = Tracker;

    -- Top row: shows the #1 roll, clickable to expand
    local TopRow = CreateFrame("Button", nil, Tracker);
    TopRow:SetSize(width, ROLL_TRACKER_ROW_HEIGHT);
    TopRow:SetPoint("TOPLEFT", Tracker, "TOPLEFT", 0, 0);

    local TopRowHL = TopRow:CreateTexture(nil, "HIGHLIGHT");
    TopRowHL:SetColorTexture(1, 1, 1, .08);
    TopRowHL:SetAllPoints(TopRow);

    local NameText = TopRow:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    NameText:SetPoint("LEFT", TopRow, "LEFT", 1, 0);
    NameText:SetWidth(100);
    NameText:SetJustifyH("LEFT");

    local RollText = TopRow:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    RollText:SetPoint("LEFT", NameText, "RIGHT", 2, 0);
    RollText:SetWidth(35);
    RollText:SetJustifyH("LEFT");

    local PlusOneText = TopRow:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    PlusOneText:SetPoint("LEFT", RollText, "RIGHT", 2, 0);
    PlusOneText:SetWidth(35);
    PlusOneText:SetJustifyH("LEFT");

    local TypeText = TopRow:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall");
    TypeText:SetPoint("LEFT", PlusOneText, "RIGHT", 2, 0);
    TypeText:SetWidth(50);
    TypeText:SetJustifyH("LEFT");

    -- The toggle lives in its own frame so it can follow the last visible row
    local Controls = CreateFrame("Frame", nil, Tracker);
    Controls:SetSize(12, ROLL_TRACKER_ROW_HEIGHT);
    Controls:SetFrameLevel(Tracker:GetFrameLevel() + 10);
    self.RollTrackerControls = Controls;

    ---@type Button
    local ToggleButton = CreateFrame("Button", nil, Controls);
    ToggleButton:SetSize(12, 12);
    ToggleButton:SetPoint("RIGHT", Controls, "RIGHT", 0, 0);
    ToggleButton:SetNormalTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up");
    ToggleButton:SetHighlightTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight");
    ToggleButton:SetPushedTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down");
    ToggleButton:SetScript("OnEnter", function ()
        GameTooltip:SetOwner(ToggleButton, "ANCHOR_TOP");
        GameTooltip:SetText(self.rollTrackerExpanded and L["Hide rolls"] or L["Show rolls"]);
        GameTooltip:Show();
    end);
    ToggleButton:SetScript("OnLeave", function ()
        GameTooltip:Hide();
    end);
    ToggleButton:SetScript("OnClick", function ()
        self:toggleRollTracker();
    end);

    -- Gear widgets for the top row
    local TopGearArrow = CreateFrame("Button", nil, TopRow);
    TopGearArrow:SetSize(14, ROLL_TRACKER_ROW_HEIGHT);
    local TopGearArrowText = TopGearArrow:CreateFontString(nil, "OVERLAY", GL.Data.Constants.GearPanelToggle.font);
    TopGearArrowText:SetAllPoints(TopGearArrow);
    TopGearArrowText:SetJustifyH("CENTER");
    TopGearArrow:Hide();

    local TopGearIcon2 = CreateFrame("Button", nil, TopRow);
    TopGearIcon2:SetSize(14, 14);
    TopGearIcon2.Texture = TopGearIcon2:CreateTexture(nil, "ARTWORK");
    TopGearIcon2.Texture:SetAllPoints(TopGearIcon2);
    TopGearIcon2:Hide();

    local TopGearIcon1 = CreateFrame("Button", nil, TopRow);
    TopGearIcon1:SetSize(14, 14);
    TopGearIcon1.Texture = TopGearIcon1:CreateTexture(nil, "ARTWORK");
    TopGearIcon1.Texture:SetAllPoints(TopGearIcon1);
    TopGearIcon1:Hide();

    TopGearIcon2:SetPoint("RIGHT", TopGearArrow, "LEFT", -2, 0);
    TopGearIcon1:SetPoint("RIGHT", TopGearIcon2, "LEFT", -2, 0);

    TopRow.GearArrow = TopGearArrow;
    TopRow.GearArrowText = TopGearArrowText;
    TopRow.GearIcon2 = TopGearIcon2;
    TopRow.GearIcon1 = TopGearIcon1;

    TopRow.NameText = NameText;
    TopRow.RollText = RollText;
    TopRow.PlusOneText = PlusOneText;
    TopRow.TypeText = TypeText;
    TopRow.ToggleButton = ToggleButton;
    self.RollTrackerTopRow = TopRow;

    TopRow:SetScript("OnClick", function ()
        self:toggleRollTracker();
    end);

    -- Expanded area (hidden by default)
    local ExpandedFrame = CreateFrame("Frame", nil, Tracker);
    ExpandedFrame:SetPoint("TOPLEFT", TopRow, "BOTTOMLEFT", 0, 0);
    ExpandedFrame:SetWidth(width);
    ExpandedFrame:SetHeight(1);
    ExpandedFrame:Hide();

    local ExpandedBG = ExpandedFrame:CreateTexture(nil, "BACKGROUND");
    ExpandedBG:SetColorTexture(0, 0, 0, .5);
    ExpandedBG:SetAllPoints(ExpandedFrame);

    local Separator = ExpandedFrame:CreateTexture(nil, "ARTWORK");
    Separator:SetColorTexture(.5, .5, .5, .3);
    Separator:SetSize(width - 8, 1);
    Separator:SetPoint("TOPLEFT", ExpandedFrame, "TOPLEFT", 4, 0);

    self.RollTrackerExpandedFrame = ExpandedFrame;

    -- Pre-create row frames for the expanded view
    local Rows = {};
    for i = 1, ROLL_TRACKER_MAX_VISIBLE do
        local Row = self:createRollRow(ExpandedFrame, width);
        if (i == 1) then
            Row:SetPoint("TOPLEFT", ExpandedFrame, "TOPLEFT", 0, -2);
        else
            Row:SetPoint("TOPLEFT", Rows[i - 1], "BOTTOMLEFT", 0, 0);
        end
        Row:Hide();
        table.insert(Rows, Row);
    end
    self.RollTrackerRows = Rows;

    -- Scroll indicator (thin track on the right, shown when scrollable)
    local ScrollTrack = CreateFrame("Frame", nil, ExpandedFrame);
    ScrollTrack:SetWidth(3);
    ScrollTrack:SetPoint("TOPRIGHT", ExpandedFrame, "TOPRIGHT", -2, -4);
    ScrollTrack:SetPoint("BOTTOMRIGHT", ExpandedFrame, "BOTTOMRIGHT", -2, 4);
    ScrollTrack:Hide();

    local ScrollTrackBG = ScrollTrack:CreateTexture(nil, "BACKGROUND");
    ScrollTrackBG:SetColorTexture(1, 1, 1, .1);
    ScrollTrackBG:SetAllPoints(ScrollTrack);

    local ScrollThumb = ScrollTrack:CreateTexture(nil, "OVERLAY");
    ScrollThumb:SetColorTexture(1, 1, 1, .3);
    ScrollThumb:SetWidth(3);

    self.RollTrackerScrollTrack = ScrollTrack;
    self.RollTrackerScrollThumb = ScrollThumb;

    -- Mousewheel on expanded area
    ExpandedFrame:EnableMouseWheel(true);
    ExpandedFrame:SetScript("OnMouseWheel", function (_, delta)
        self:scrollRollTracker(-delta);
    end);

    -- Also allow mousewheel on top row when expanded
    TopRow:EnableMouseWheel(true);
    TopRow:SetScript("OnMouseWheel", function (_, delta)
        if (self.rollTrackerExpanded) then
            self:scrollRollTracker(-delta);
        end
    end);

    GL.Events:register("RollerUIRollAcceptedListener", "GL.ROLLOFF_ROLL_ACCEPTED", function ()
        GL:after(.05, "RollerUIRollTrackerRefresh", function ()
            self:refreshRollTracker();
        end);
    end);

    GL.Events:register("RollerUIGearReceivedListener", "GL.ROLLOFF_GEAR_RECEIVED", function ()
        GL:after(.05, "RollerUIRollTrackerRefresh", function ()
            self:refreshRollTracker();
        end);
    end);

    -- If the user previously expanded the tracker, restore that state
    if (self.rollTrackerExpanded) then
        self.RollTrackerExpandedFrame:Show();
    end

    self:positionRollTrackerControls();

    -- Catch up with any rolls that arrived before the listener was registered
    self:refreshRollTracker();
end

--- Anchor the toggle/info icons to the last visible row and keep the gear widgets clear of them
---
---@return nil
function RollerUI:positionRollTrackerControls()
    local Controls = self.RollTrackerControls;
    local TopRow = self.RollTrackerTopRow;

    if (not Controls or not TopRow) then
        return;
    end

    local TargetRow = TopRow;
    if (self.rollTrackerExpanded and self.RollTrackerRows) then
        for i = ROLL_TRACKER_MAX_VISIBLE, 1, -1 do
            local Row = self.RollTrackerRows[i];

            if (Row and Row:IsShown()) then
                TargetRow = Row;
                break;
            end
        end
    end

    Controls:ClearAllPoints();
    Controls:SetPoint("RIGHT", TargetRow, "RIGHT", TargetRow == TopRow and -4 or -8, 0);

    local anchorGear = function (Row)
        if (not Row or not Row.GearArrow) then
            return;
        end

        Row.GearArrow:ClearAllPoints();

        if (Row == TargetRow) then
            Row.GearArrow:SetPoint("RIGHT", Controls, "LEFT", -4, 0);
        else
            Row.GearArrow:SetPoint("RIGHT", Row, "RIGHT", -8, 0);
        end
    end;

    anchorGear(TopRow);
    for _, Row in pairs(self.RollTrackerRows or {}) do
        anchorGear(Row);
    end
end

--- Refresh the roll tracker display with current data
---
---@return nil
function RollerUI:refreshRollTracker()
    if (not self.RollTrackerFrame or not self.RollTrackerTopRow) then
        return;
    end

    local SortedRolls = GL.RollOff:buildSortedRollData();

    if (#SortedRolls < 1) then
        self.RollTrackerFrame:Hide();
        return;
    end

    self.RollTrackerFrame:Show();
    self.rollTrackerSortedData = SortedRolls;

    -- Fill top row with #1 entry
    local TopEntry = SortedRolls[1];
    local TopRow = self.RollTrackerTopRow;
    local coloredName = GL:classColorize(TopEntry.displayName, TopEntry.class);
    TopRow.NameText:SetText(coloredName);
    TopRow.RollText:SetText(tostring(TopEntry.amount));
    TopRow.RollText:SetTextColor(1, 1, 1);

    if (GL:higherThanZero(TopEntry.plusOnes)) then
        TopRow.PlusOneText:SetText("+" .. TopEntry.plusOnes);
    else
        TopRow.PlusOneText:SetText("");
    end
    TopRow.PlusOneText:SetTextColor(.8, .8, .8);

    TopRow.TypeText:SetText(TopEntry.classification or "");
    TopRow.TypeText:SetTextColor(.8, .8, .8);

    self:fillGearWidgets(TopRow, TopEntry);

    if (self.rollTrackerExpanded) then
        self:refreshExpandedRows();
    end
end

--- Fill the expanded rows based on scroll offset
---
---@return nil
function RollerUI:refreshExpandedRows()
    local SortedRolls = self.rollTrackerSortedData;

    if (not SortedRolls) then
        return;
    end

    -- Expanded rows show entries starting from index 2 (top row shows #1)
    local expandedEntries = #SortedRolls - 1;
    local maxOffset = math.max(0, expandedEntries - ROLL_TRACKER_MAX_VISIBLE);
    self.rollTrackerScrollOffset = math.min(self.rollTrackerScrollOffset, maxOffset);

    local visibleCount = math.min(expandedEntries, ROLL_TRACKER_MAX_VISIBLE);

    for i = 1, ROLL_TRACKER_MAX_VISIBLE do
        local Row = self.RollTrackerRows[i];
        local dataIndex = i + self.rollTrackerScrollOffset + 1; -- +1 because top row is index 1

        if (dataIndex <= #SortedRolls) then
            self:fillRollRow(Row, SortedRolls[dataIndex]);
            Row:Show();
        else
            Row:Hide();
        end
    end

    self:positionRollTrackerControls();

    -- Update expanded frame height
    local expandedHeight = (visibleCount * ROLL_TRACKER_ROW_HEIGHT) + 2;
    self.RollTrackerExpandedFrame:SetHeight(expandedHeight);

    -- Update tracker frame total height
    self.RollTrackerFrame:SetHeight(ROLL_TRACKER_ROW_HEIGHT + expandedHeight);

    -- Update scroll indicator
    if (expandedEntries > ROLL_TRACKER_MAX_VISIBLE) then
        self.RollTrackerScrollTrack:Show();

        local trackHeight = self.RollTrackerScrollTrack:GetHeight();
        local thumbHeight = math.max(10, trackHeight * (ROLL_TRACKER_MAX_VISIBLE / expandedEntries));
        self.RollTrackerScrollThumb:SetHeight(thumbHeight);

        local scrollRange = trackHeight - thumbHeight;
        local thumbOffset = maxOffset > 0 and (scrollRange * (self.rollTrackerScrollOffset / maxOffset)) or 0;
        self.RollTrackerScrollThumb:ClearAllPoints();
        self.RollTrackerScrollThumb:SetPoint("TOPLEFT", self.RollTrackerScrollTrack, "TOPLEFT", 0, -thumbOffset);
    else
        self.RollTrackerScrollTrack:Hide();
    end
end

--- Toggle the expanded state of the roll tracker
---
---@return nil
function RollerUI:toggleRollTracker()
    if (not self.RollTrackerExpandedFrame) then
        return;
    end

    self.rollTrackerExpanded = not self.rollTrackerExpanded;
    self.rollTrackerScrollOffset = 0;

    if (self.rollTrackerExpanded) then
        self.RollTrackerExpandedFrame:Show();
        self:refreshExpandedRows();
    else
        self.RollTrackerExpandedFrame:Hide();
        self.RollTrackerFrame:SetHeight(ROLL_TRACKER_ROW_HEIGHT);
        self:positionRollTrackerControls();
    end

    -- Refresh tooltip if the mouse is still over the toggle button
    local ToggleButton = self.RollTrackerTopRow and self.RollTrackerTopRow.ToggleButton;
    if (ToggleButton and GameTooltip:IsOwned(ToggleButton)) then
        GameTooltip:SetText(self.rollTrackerExpanded and L["Hide rolls"] or L["Show rolls"]);
    end
end

--- Scroll the expanded roll tracker by a number of rows
---
---@param direction number Positive = scroll down, negative = scroll up
---@return nil
function RollerUI:scrollRollTracker(direction)
    if (not self.rollTrackerExpanded or not self.rollTrackerSortedData) then
        return;
    end

    local expandedEntries = #self.rollTrackerSortedData - 1;
    local maxOffset = math.max(0, expandedEntries - ROLL_TRACKER_MAX_VISIBLE);
    local newOffset = self.rollTrackerScrollOffset + direction;
    newOffset = math.max(0, math.min(maxOffset, newOffset));

    if (newOffset ~= self.rollTrackerScrollOffset) then
        self.rollTrackerScrollOffset = newOffset;
        self:refreshExpandedRows();
    end
end

--- Show "Roll accepted!" notification for 2 seconds. Can be used after manual roll or auto-roll.
---@param anchorFrame Frame|nil If provided, position above this frame. Else center of screen.
---@return nil
function RollerUI:showRollAcceptedNotification(anchorFrame)
    if (self.RollAcceptedTimer) then
        GL.Ace:CancelTimer(self.RollAcceptedTimer);
        self.RollAcceptedTimer = nil;
    end
    if (self.RollAcceptedNotification) then
        self.RollAcceptedNotification.frame:Hide();
        GL.Interface:release(self.RollAcceptedNotification);
        self.RollAcceptedNotification = nil;
    end

    local RollAcceptedNotification = GL.AceGUI:Create("InlineGroup");
    RollAcceptedNotification:SetLayout("Fill");
    RollAcceptedNotification:SetWidth(150);
    RollAcceptedNotification:SetHeight(50);
    RollAcceptedNotification.frame:SetParent(UIParent);
    RollAcceptedNotification.frame:SetFrameStrata("FULLSCREEN_DIALOG");

    if (anchorFrame) then
        RollAcceptedNotification.frame:SetPoint("BOTTOMLEFT", anchorFrame, "TOPLEFT", 0, 4);
    else
        RollAcceptedNotification.frame:SetPoint("CENTER", UIParent, "CENTER", 0, 0);
    end

    local Text = GL.AceGUI:Create("Label");
    Text:SetText(L["Roll accepted!"]);
    RollAcceptedNotification:AddChild(Text);
    Text:SetJustifyH("CENTER");

    RollAcceptedNotification.frame:Show();

    self.RollAcceptedNotification = RollAcceptedNotification;
    self.RollAcceptedTimer = GL.Ace:ScheduleTimer(function ()
        if (self.RollAcceptedNotification) then
            self.RollAcceptedNotification.frame:Hide();
            GL.Interface:release(self.RollAcceptedNotification);
            self.RollAcceptedNotification = nil;
        end
        self.RollAcceptedTimer = nil;
    end, 2);
end

---@return nil
function RollerUI:hide()
    GL.Events:unregister("RollerUIModifierStateChanged");
    GL.Events:unregister("RollerUIRollAcceptedListener");
    GL.Events:unregister("RollerUIGearReceivedListener");
    GL:cancelTimer("RollerUIRollTrackerRefresh");
    GL.Interface.GearPanel:hide();

    if (self.RollAcceptedTimer) then
        GL.Ace:CancelTimer(self.RollAcceptedTimer);
        self.RollAcceptedTimer = nil;
    end
    if (self.RollAcceptedNotification) then
        self.RollAcceptedNotification.frame:Hide();
        GL.Interface:release(self.RollAcceptedNotification);
        self.RollAcceptedNotification = nil;
    end

    if (not self.Window) then
        return;
    end

    -- We can't release the timer bar because it will be reused later
    if (self.TimerBar and self.TimerBar.SetParent) then
        self.TimerBar:SetParent(UIParent);
        self.TimerBar:Stop();
        self.TimerBar = nil;
    end

    self.RollTrackerFrame = nil;
    self.RollTrackerTopRow = nil;
    self.RollTrackerExpandedFrame = nil;
    self.RollTrackerControls = nil;
    self.RollTrackerRows = nil;
    self.RollTrackerScrollTrack = nil;
    self.RollTrackerScrollThumb = nil;
    self.rollTrackerSortedData = nil;
    self.rollTrackerScrollOffset = 0;

    GL.Interface:release(self.Window);
    self.Window = nil;
end
