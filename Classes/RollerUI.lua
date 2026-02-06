local L = Gargul_L;

---@type GL
local _, GL = ...;

---@class RollerUI
GL.RollerUI = GL.RollerUI or {
    Window = nil,
};
local RollerUI = GL.RollerUI; ---@type RollerUI

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
    Window:SetScript("OnDragStop", function()
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
        local buttonWidth = math.max(string.len(identifier) * 12, 70);
        rollerUIWidth = rollerUIWidth + buttonWidth + 4;
        Button:SetSize(buttonWidth, 20);
        Button:SetText(identifier);
        Button:SetNormalFontObject("GameFontNormal");
        Button:SetHighlightFontObject("GameFontNormal");

        if (not userCanUseItem) then
            Button:Disable();
            Button:SetMotionScriptsWhileDisabled(true);

            -- Make sure rolling is still possible in case something was amiss!
            Button:SetScript("OnEnter", function()
                Button:Enable();
            end);

            Button:SetScript("OnLeave", function()
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

    -- Auto roll discovery hint: show when user has no rules in any profile (they're not yet aware of the module)
    if (not GL.AutoRoll:hasAnyRulesInAnyProfile()) then
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
    TimerBar.candyBarLabel:SetFont(STANDARD_TEXT_FONT, 12, "OUTLINE");

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
    TimerBar:SetScript("OnMouseDown", function(_, button)
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
    TimerBar:SetScript("OnEnter", function()
        lastShiftStatus = IsShiftKeyDown();

        GameTooltip:SetOwner(self.Window, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
        itemTooltipIsShowing = true;
    end);

    TimerBar:SetScript("OnLeave", function()
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

    GL.Interface:release(self.Window);
    self.Window = nil;
end
