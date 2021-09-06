---@type GL
local _, GL = ...;

---@class RollerUI
GL.RollerUI = GL.RollerUI or {};
local RollerUI = GL.RollerUI; ---@type RollerUI

---@return boolean
function RollerUI:show(...)
    GL:debug("RollerUI:show");

    local Window = GL.Interface:getItem(self, "Window");

    if (Window and Window:IsShown()) then
        return false;
    end

    self:draw(...);
    return true;
end

---@return void
function RollerUI:hide()
    local Window = GL.Interface:getItem(self, "Window");
    local TimerBar = GL.Interface:getItem(self, "Frame.TimerBar");

    if (Window) then
        Window:Hide();
    end

    if (TimerBar) then
        TimerBar:Stop();
    end
end

--- Note: we're not using AceGUI here since getting a SimpleGroup to move properly is a friggin nightmare
---
---@param time number The duration of the RollOff
---@param itemId number
---@param itemLink string
---@param itemIcon string
---@param note string
---@return boolean
function RollerUI:draw(time, itemId, itemLink, itemIcon, note, osRollMax)
    GL:debug("RollerUI:draw");

    local Window = GL.Interface:getItem(self, "Window");

    -- All UI elements are already available, no need to render them again
    if (Window) then
        return self:update(time, itemId, itemLink, itemIcon, note, osRollMax);
    end

    Window = CreateFrame("Frame", "GargulUI_RollerUI_Window", UIParent, Frame);
    Window:Show();
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

    local Texture = Window:CreateTexture(nil,"BACKGROUND");
    Texture:SetColorTexture(0, 0, 0, .6);
    Texture:SetAllPoints(Window)
    Window.texture = Texture;

    -- Roll button
    local MSButton = CreateFrame("Button", "GargulUI_RollerUI_MS", Window, "GameMenuButtonTemplate");
    MSButton:SetPoint("TOPLEFT", Window, "TOPLEFT", 2, -1);
    MSButton:SetSize(60, 20);
    MSButton:SetText("MS");
    MSButton:SetNormalFontObject("GameFontNormal");
    MSButton:SetHighlightFontObject("GameFontNormal");
    MSButton:SetScript("OnClick", function ()
        RandomRoll(1, 100);

        if (GL.Settings:get("Rolling.closeAfterRoll")) then
            self:hide();
        end
    end);

    local OSButton = CreateFrame("Button", "GargulUI_RollerUI_OS", Window, "GameMenuButtonTemplate");
    OSButton:SetPoint("TOPLEFT", MSButton, "TOPRIGHT", 1, 0);
    OSButton:SetSize(60, 20);
    OSButton:SetText("OS");
    OSButton:SetNormalFontObject("GameFontNormal");
    OSButton:SetHighlightFontObject("GameFontNormal");

    local PassButton = CreateFrame("Button", "GargulUI_RollerUI_Pass", Window, "GameMenuButtonTemplate");
    PassButton:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -3, -1);
    PassButton:SetSize(60, 20);
    PassButton:SetText("Pass");
    PassButton:SetNormalFontObject("GameFontNormal");
    PassButton:SetHighlightFontObject("GameFontNormal");
    PassButton:SetScript("OnClick", function ()
        self:hide();
    end);

    local TimerBar = LibStub("LibCandyBar-3.0"):New(
        "Interface\\AddOns\\Gargul\\Assets\\Textures\\timer-bar",
        350,
        24
    );

    TimerBar:SetPoint("BOTTOM", Window, "BOTTOM");
    TimerBar.candyBarLabel:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE");

    -- Make the bar turn green/yellow/red based on time left
    TimerBar:AddUpdateFunction(function ()
        local percentageLeft = 100 / (time / TimerBar.remaining);

        if (percentageLeft >= 60) then
            TimerBar:SetColor(0, 1, 0, .3);
        elseif (percentageLeft >= 30) then
            TimerBar:SetColor(1, 1, 0, .3);
        else
            TimerBar:SetColor(1, 0, 0, .3);
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

    GL.Interface:setItem(self, "Window", Window);
    GL.Interface:setItem(self, "TimerBar", TimerBar);
    GL.Interface:setItem(self, "OSButton", OSButton);

    return self:update(time, itemId, itemLink, itemIcon, note, osRollMax);
end

--- This method updates the values of the RollerUI only
--- This allows us to keep reusing the same UI elements
--- without having to build them over and over again
---
---@param time number The duration of the RollOff
---@param itemId number
---@param itemLink string
---@param itemIcon string
---@param note string
---@return boolean
function RollerUI:update(time, itemId, itemLink, itemIcon, note, osRollMax)
    GL:debug("RollerUI:update");

    -- Fetch all UI elements
    local TimerBar = GL.Interface:getItem(self, "Frame.TimerBar");
    local Window = GL.Interface:getItem(self, "Window");

    -- This shouldn't be possible but you never know!
    if (not TimerBar
        or not Window
    ) then
        return false;
    end

    note = note or "";
    local noteStringLengthAllowed = 53 - string.len(note);

    -- Make sure the item note does not go out of bounds
    if (noteStringLengthAllowed < 0) then
        noteStringLengthAllowed = 0;
    end

    TimerBar:SetParent(Window);
    TimerBar:SetDuration(time);
    TimerBar:SetColor(0, 1, 0, .3); -- Reset color to green
    TimerBar:SetLabel("  " .. itemLink .. " " .. string.sub(note, 0, noteStringLengthAllowed));
    TimerBar.candyBarLabel:SetFont("Fonts\\ARIALN.ttf", 13, "OUTLINE");

    TimerBar:SetIcon(itemIcon);
    TimerBar:Start();
    Window:Show();

    -- Show a gametooltip for the item up for roll
    -- when hovering over the progress bar
    TimerBar:SetScript("OnEnter", function()
        GameTooltip:SetOwner(Window, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
    end);

    -- Check whether the Master Looter supports OS rolls
    local OSButton = GL.Interface:getItem(self, "Frame.OSButton");
    if (type(osRollMax) == "number"
        and not GL:higherThanZero(osRollMax)
    ) then
        OSButton:Hide();
    else

        OSButton:Show();
        OSButton:SetScript("OnClick", function ()
            RandomRoll(1, osRollMax or 99);

            if (GL.Settings:get("Rolling.closeAfterRoll")) then
                self:hide();
            end
        end);
    end

    return true;
end

GL:debug("RollerUI.lua");