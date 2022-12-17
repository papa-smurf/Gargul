---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@type Events
local Events = GL.Events;

---@class ActionSelector
Interface.ActionSelector = {
    itemLink = nil,
    AutoCloseTimer = nil,
};

---@type ActionSelector
local ActionSelector = Interface.ActionSelector;

---@return void
function ActionSelector:open(itemLink)
    GL:debug("Interface.ActionSelector:open");

    local Window = Interface:get(self, "Window");

    if (not Window) then
        Window = self:build();
    end

    GL.Ace:CancelTimer(self.AutoCloseTimer);

    if (self.isVisible) then
        -- Clicking the same item twice toggles (closes) the window
        if (itemLink == self.itemLink) then
            self:close();
            return;
        end

        self:moveToMouse();
    end

    self.isVisible = true;
    self.itemLink = itemLink;

    Window.frame:Show();

    Events:unregister("ActionSelectorGlobalMouseDownListener");
    Events:register("ActionSelectorGlobalMouseDownListener", "GLOBAL_MOUSE_DOWN", function ()
        GL.Ace:CancelTimer(self.AutoCloseTimer);
        self.AutoCloseTimer = GL.Ace:ScheduleTimer(function ()
            self:close();
        end, .15);
    end);

    self:moveToMouse();
end

---@return void
function ActionSelector:build()
    GL:debug("Interface.ActionSelector:build");

    local Window = Interface:get(self, "Window");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    ---@type AceGUIInlineGroup
    Window = AceGUI:Create("InlineGroup");
    Window:SetWidth(90);
    Window:SetLayout("FLOW");
    Window.frame:SetParent(UIParent);
    Window.frame:EnableMouse(true); -- Make sure you can't click through the window
    Interface:set(self, "Window", Window);

    ---@type AceGUIButton
    local Roll = AceGUI:Create("Button");
    Roll:SetText("Roll");
    Roll:SetFullWidth(true);
    Roll:SetHeight(20);
    Roll:SetCallback("OnClick", function()
        GL.MasterLooterUI:draw(self.itemLink);
        self:close();
    end);
    Window:AddChild(Roll);

    ---@type AceGUIButton
    local GDKP = AceGUI:Create("Button");
    GDKP:SetText("GDKP");
    GDKP:SetFullWidth(true);
    GDKP:SetHeight(20);
    GDKP:SetCallback("OnClick", function()
        GL.Interface.GDKP.Auctioneer:draw(self.itemLink);
        self:close();
    end);
    Window:AddChild(GDKP);

    Window.frame:Show();
    Window.frame:SetPoint("CENTER", UIParent, "CENTER");

    return Window;
end

--- Move the window to the player's mouse position
---@return void
function ActionSelector:moveToMouse()
    GL:debug("Interface.ActionSelector:moveToMouse");

    local Window = Interface:get(self, "Window");

    if (not Window) then
        return;
    end

    local uiScale, x, y = UIParent:GetEffectiveScale(), GetCursorPosition();
    Window.frame:ClearAllPoints();
    Window.frame:SetPoint("CENTER", nil, "BOTTOMLEFT", x / uiScale, y / uiScale + 50);
end

---@return void
function ActionSelector:close()
    GL:debug("Interface.ActionSelector:close");

    local Window = Interface:get(self, "Window");

    if (not Window) then
        return;
    end

    Window.frame:Hide();
    self.isVisible = false;

    Events:unregister("ActionSelectorGlobalMouseDownListener");
end