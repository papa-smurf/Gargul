local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

---@type GDKPDistribute
local Overview = GL.Interface.GDKP.Distribute.Overview;

---@type Interface
local Interface = GL.Interface;

---@class EditRaider
GL.Interface.GDKP.Distribute.EditRaider = {
    isVisible = false,
    player = nil,
    sessionID = nil,
};

---@type EditRaider
local EditRaider = GL.Interface.GDKP.Distribute.EditRaider;

---@return Frame
function EditRaider:build()
    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(200);
    Window:SetHeight(280);
    Window.frame:SetFrameStrata("HIGH");
    Window.frame:Show();
    Interface:set(self, "Window", Window);

    local Name = GL.AceGUI:Create("EditBox");
    Name:DisableButton(true);
    Name:SetHeight(20);
    Name:SetFullWidth(true);
    Name:SetLabel(L["Name"]);
    Window:AddChild(Name);
    Interface:set(self, "Name", Name);

    local Save = AceGUI:Create("Button");
    Save:SetText(L["Ok"]);
    Save:SetFullWidth(true);
    Save:SetCallback("OnClick", function()
        local name = strtrim(Name:GetText());
        if (GL:empty(name)) then
            GL:warning(L["Invalid data supplied"]);
            return;
        end

        if (GDKPPot:renamePlayer(self.sessionID, self.player, name)) then
            self:close();
            Overview:refresh();
            Name:SetText();
        end
    end);
    Window:AddChild(Save);

    local Cancel = AceGUI:Create("Button");
    Cancel:SetText(L["Cancel"]);
    Cancel:SetFullWidth(true);
    Cancel:SetCallback("OnClick", function()
        self:close();
    end);
    Window:AddChild(Cancel);

    return Window;
end

---@return Frame
function EditRaider:window()
    local Window = Interface:get(self, "Window");

    if (not Window) then
        Window = self:build();
    end

    return Window;
end

--- Toggle the create session window that's anchored to the right side of the GDKP overview window
---
---@return nil
function EditRaider:toggle()
    if (self.isVisible) then
        return self:close();
    end

    self:open();
end

---@return nil
function EditRaider:open(sessionID, player)
    -- It seems our GDKP overview window is not opened
    if (not Overview.isVisible) then
        return;
    end

    self.sessionID = sessionID;
    self.player = player;
    local Window = self:window();

    Interface:get(self, "EditBox.Name"):SetText(player);

    self.isVisible = true;
    Window.frame:SetPoint("TOPLEFT", Interface:get(Overview, "GDKPDistribute").frame, "TOPRIGHT", 2, 16);
    Window.frame:Show();
end

---@return nil
function EditRaider:close()
    local Window = self:window();

    if (self.isVisible) then
        Window.frame:Hide();
        self.isVisible = false;
    end
end
