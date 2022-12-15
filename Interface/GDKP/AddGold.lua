---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@class AddGold
GL.Interface.GDKP.AddGold = {
    isVisible = false,
};

---@type AddGold
local AddGold = GL.Interface.GDKP.AddGold;

---@type GDKPOverview
local Overview = GL.Interface.GDKP.Overview;

---@type Interface
local Interface = GL.Interface;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

---@return Frame
function AddGold:build()
    GL:debug("Interface.GDKP.AddGold:build");

    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(200);
    Window:SetHeight(280);
    Window.frame:SetFrameStrata("HIGH");
    Window.frame:Show();
    Interface:set(self, "Window", Window);

    local Label = GL.AceGUI:Create("Label");
    Label:SetHeight(20);
    Label:SetFullWidth(true);
    Label:SetText("Add to");
    Window:AddChild(Label);
    Interface:set(self, "Title", Label);

    local Gold = GL.AceGUI:Create("EditBox");
    Gold:DisableButton(true);
    Gold:SetHeight(20);
    Gold:SetFullWidth(true);
    Gold:SetLabel("Gold");
    Interface:set(self, "Gold", Gold);
    Window:AddChild(Gold);

    local PaidForBy = GL.AceGUI:Create("EditBox");
    PaidForBy:DisableButton(true);
    PaidForBy:SetHeight(20);
    PaidForBy:SetFullWidth(true);
    PaidForBy:SetLabel("Paid for by");
    Interface:set(self, "PaidForBy", PaidForBy);
    Window:AddChild(PaidForBy);

    local Note = GL.AceGUI:Create("EditBox");
    Note:DisableButton(true);
    Note:SetHeight(20);
    Note:SetFullWidth(true);
    Note:SetLabel("Note");
    Interface:set(self, "Note", Note);
    Window:AddChild(Note);

    local Save = AceGUI:Create("Button");
    Save:SetText("Save");
    Save:SetFullWidth(true);
    Save:SetCallback("OnClick", function()
        local gold = tonumber(strtrim(Gold:GetText())) or 0;
        if (gold < 1) then
            GL:warning("Gold needs to be higher than 0");
            return;
        end

        local paidForBy = strtrim(PaidForBy:GetText());
        if (GL:empty(paidForBy)) then
            GL:warning("Who pays for this?");
            return;
        end

        GDKPPot:addGold(Overview.selectedSession, gold, paidForBy, Note:GetText());

        self:close();
    end);
    Window:AddChild(Save);

    local Cancel = AceGUI:Create("Button");
    Cancel:SetText("Cancel");
    Cancel:SetFullWidth(true);
    Cancel:SetCallback("OnClick", function()
        self:close();
    end);
    Window:AddChild(Cancel);

    return Window;
end

---@return Frame
function AddGold:window()
    GL:debug("Interface.GDKP.AddGold:window");

    local Window = Interface:get(self, "Window");

    if (not Window) then
        Window = self:build();
    end

    return Window;
end

--- Toggle the create session window that's anchored to the right side of the GDKP overview window
---
---@return void
function AddGold:toggle()
    GL:debug("Interface.GDKP.AddGold:toggle");

    if (self.isVisible) then
        return self:close();
    end

    self:open();
end

---@return void
function AddGold:open()
    GL:debug("Interface.GDKP.AddGold:open");

    local Session = GDKPSession:byID(Overview.selectedSession);

    if (not Session) then
        return;
    end

    -- It seems our GDKP overview window is not opened
    if (not Overview.isVisible) then
        return;
    end

    local Window = self:window();

    Interface:get(self, "Label.Title"):SetText("Add gold to " .. Session.title);
    Interface:get(self, "EditBox.Gold"):SetText("");
    Interface:get(self, "EditBox.PaidForBy"):SetText(GL.User.name);

    self.isVisible = true;
    Window.frame:SetPoint("TOPLEFT", Interface:get(Overview, "GDKPOverview").frame, "TOPRIGHT", 2, 16);
    Window.frame:Show();
end

---@return void
function AddGold:close()
    GL:debug("Interface.GDKP.AddGold:close");

    local Window = self:window();

    if (self.isVisible) then
        Window.frame:Hide();
        self.isVisible = false;
    end
end

GL:debug("Interface.GDKP.AddGold.lua");