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
function RollerUI:draw(time, itemId, itemLink, itemIcon, note)
    GL:debug("RollerUI:draw");

    local Window = GL.Interface:getItem(self, "Window");

    -- All UI elements are already available, no need to render them again
    if (Window) then
        return self:update(time, itemId, itemLink, itemIcon, note);
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

    -- Roll info label
    local RollLabel = CreateFrame("Frame", "GargulUI_RollerUI_Label", Window, Frame);
    RollLabel:SetSize(1, 1);
    RollLabel:SetPoint("TOPLEFT", Window, "TOPLEFT", 5, -2);
    RollLabel:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -7);

    RollLabel.text = RollLabel:CreateFontString(nil, "ARTWORK");
    RollLabel.text:SetFont("Fonts\\ARIALN.ttf", 11, "OUTLINE");
    RollLabel.text:SetPoint("TOPLEFT", RollLabel, "TOPLEFT", 0, -4);

    -- Roll button
    local RollButton = CreateFrame("Button", "GargulUI_RollerUI_Roll", Window, "GameMenuButtonTemplate");

    RollButton:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -65, -2);
    RollButton:SetSize(60, 20);
    RollButton:SetText("Roll");
    RollButton:SetNormalFontObject("GameFontNormal");
    RollButton:SetHighlightFontObject("GameFontNormal");
    RollButton:SetScript("OnClick", function ()
        RandomRoll(1, 100);
    end);

    local PassButton = CreateFrame("Button", "GargulUI_RollerUI_Pass", Window, "GameMenuButtonTemplate");
    PassButton:SetPoint("TOPLEFT", RollButton, "TOPRIGHT", 1, 0);
    PassButton:SetSize(60, 20);
    PassButton:SetText("Pass");
    PassButton:SetNormalFontObject("GameFontNormal");
    PassButton:SetHighlightFontObject("GameFontNormal");
    PassButton:SetScript("OnClick", function ()
        -- Retract roll message
        local chatType = "PARTY";
        if (GL.User.isInRaid) then
            chatType = "RAID";
        end

        if (GL.Settings:get("Rolling.announcePass")) then
            GL:sendChatMessage("I pass!", chatType);
        end

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
    TimerBar:SetScript("OnMouseDown", function(widget, button)
        if (button == "RightButton") then
            self:hide();
        end
    end)

    TimerBar:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    GL.Interface:setItem(self, "RollInfo", RollLabel);
    GL.Interface:setItem(self, "Window", Window);
    GL.Interface:setItem(self, "TimerBar", TimerBar);

    return self:update(time, itemId, itemLink, itemIcon, note);
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
function RollerUI:update(time, itemId, itemLink, itemIcon, note)
    GL:debug("RollerUI:update");

    -- Fetch all UI elements
    local RollInfo = GL.Interface:getItem(self, "Frame.RollInfo");
    local TimerBar = GL.Interface:getItem(self, "Frame.TimerBar");
    local Window = GL.Interface:getItem(self, "Window");

    -- This shouldn't be possible but you never know!
    if (not RollInfo
        or not TimerBar
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

    local itemIsReserved = GL.SoftRes:idIsReserved(itemId);
    local itemIsReservedByUser = itemIsReserved and GL.SoftRes:itemIdIsReservedByPlayer(itemId, GL.User.name);
    local labelText = "";

    if (itemIsReserved) then
        local reservedByUserString = "NO";

        if (itemIsReservedByUser) then
            reservedByUserString = "YES";
        end

        labelText = string.format("SOFT RESERVED: |c00efb8cdYES|r     BY YOU: |c00efb8cd%s|r", reservedByUserString)
    else
        labelText = "SOFT RESERVED BY ANYONE: |c00efb8cdNO|r";
    end

    RollInfo.text:SetText(labelText);

    TimerBar:SetParent(Window);
    TimerBar:SetDuration(time);
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

    return true;
end

GL:debug("RollerUI.lua");