---@type GL
local _, GL = ...;

---@class RollerUI
GL.RollerUI = GL.RollerUI or {
    Window = nil,
};
local RollerUI = GL.RollerUI; ---@type RollerUI

---@return boolean
function RollerUI:show(...)
    GL:debug("RollerUI:show");

    if (self.Window and self.Window:IsShown()) then
        return false;
    end

    self:draw(...);
    return true;
end

--- Note: we're not using AceGUI here since getting a SimpleGroup to move properly is a friggin nightmare
---
---@param time number The duration of the RollOff
---@param itemId number
---@param itemLink string
---@param itemIcon string
---@param note string
---@return boolean
function RollerUI:draw(time, itemId, itemLink, itemIcon, note, SupportedRolls)
    GL:debug("RollerUI:draw");

    local Window = CreateFrame("Frame", "GargulUI_RollerUI_Window", UIParent, Frame);
    Window:Hide();
    Window:SetSize(350, 48);
    Window:SetPoint(GL.Interface:getPosition("Roller"));

    Window:SetMovable(true);
    Window:EnableMouse(true);
    Window:SetClampedToScreen(true);
    Window:SetFrameStrata("HIGH");
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
        end
    end);
    self.Window = Window;

    local Texture = Window:CreateTexture(nil,"BACKGROUND");
    Texture:SetColorTexture(0, 0, 0, .6);
    Texture:SetAllPoints(Window)
    Window.texture = Texture;

    local RollButtonWidthByAmount = {
        [1] = 80,
        [2] = 80,
        [3] = 72,
        [4] = 64,
        [5] = 56,
        [6] = 48,
    };
    local RollButtons = {};
    local numberOfButtons = #SupportedRolls;
    for i = 1, numberOfButtons do ---@todo
        local RollDetails = SupportedRolls[i] or {};

        local identifier = string.sub(RollDetails[1] or "", 1, 3);
        local min = math.floor(tonumber(RollDetails[2]) or 0);
        local max = math.floor(tonumber(RollDetails[3]) or 0);

        -- There are no more buttons to display
        if (GL:empty(identifier)) then
            break;
        end

        -- Roll button
        local Button = CreateFrame("Button", nil, Window, "GameMenuButtonTemplate");
        Button:SetSize(RollButtonWidthByAmount[numberOfButtons], 20);
        Button:SetText(identifier);
        Button:SetNormalFontObject("GameFontNormal");
        Button:SetHighlightFontObject("GameFontNormal");
        Button:SetScript("OnClick", function ()
            RandomRoll(min, max);

            if (GL.Settings:get("Rolling.closeAfterRoll")) then
                self:hide();
            end
        end);

        if (i == 1) then
            Button:SetPoint("TOPLEFT", Window, "TOPLEFT", 2, -1);
        else
            Button:SetPoint("TOPLEFT", RollButtons[i - 1], "TOPRIGHT", 1, 0);
        end

        tinsert(RollButtons, Button);
    end

    local PassButton = CreateFrame("Button", "GargulUI_RollerUI_Pass", Window, "GameMenuButtonTemplate");
    PassButton:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -3, -1);
    PassButton:SetSize(50, 20);
    PassButton:SetText("Pass");
    PassButton:SetNormalFontObject("GameFontNormal");
    PassButton:SetHighlightFontObject("GameFontNormal");
    PassButton:SetScript("OnClick", function ()
        self:hide();
    end);

    self:drawCountdownBar(time, itemLink, itemIcon, note);

    Window:Show();
end

--- Draw the countdown bar
---
---@param time number
---@param itemLink string
---@param itemIcon string
---@param note string
---@return void
function RollerUI:drawCountdownBar(time, itemLink, itemIcon, note)
    GL:debug("RollerUI:drawCountdownBar");

    -- This shouldn't be possible but you never know!
    if (not self.Window) then
        return false;
    end

    local TimerBar = LibStub("LibCandyBarGargul-3.0"):New(
        "Interface\\AddOns\\Gargul\\Assets\\Textures\\timer-bar",
        350,
        24
    );

    TimerBar:SetParent(self.Window);
    TimerBar:SetPoint("BOTTOM", self.Window, "BOTTOM");
    TimerBar.candyBarLabel:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE");

    -- Make the bar turn green/yellow/red based on time left
    TimerBar:AddUpdateFunction(function (Bar)
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

    TimerBar:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    TimerBar:SetDuration(time);
    TimerBar:SetColor(0, 1, 0, .3); -- Reset color to green

    note = note or "";
    local noteStringLengthAllowed = 53 - string.len(note);

    -- Make sure the item note does not go out of bounds
    if (noteStringLengthAllowed < 0) then
        noteStringLengthAllowed = 0;
    end
    TimerBar:SetLabel("  " .. itemLink .. " " .. string.sub(note, 0, noteStringLengthAllowed));

    TimerBar:SetIcon(itemIcon);
    TimerBar:Set("type", "ROLLER_UI_COUNTDOWN");
    TimerBar:Start();

    -- Show a gametooltip for the item up for roll
    -- when hovering over the progress bar
    TimerBar:SetScript("OnEnter", function()
        GameTooltip:SetOwner(self.Window, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
    end);
end

---@return void
function RollerUI:hide()
    GL:debug("RollerUI:hide");

    if (not self.Window) then
        return;
    end

    self.Window:Hide();
    self.Window = nil;
end

GL:debug("RollerUI.lua");