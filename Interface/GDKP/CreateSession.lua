---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@class CreateSession
GL.Interface.GDKP.CreateSession = {
    isVisible = false,
};

---@type CreateSession
local CreateSession = GL.Interface.GDKP.CreateSession;

---@type GDKPOverview
local Overview = GL.Interface.GDKP.Overview;

---@type Interface
local Interface = GL.Interface;

---@return Frame
function CreateSession:build()
    GL:debug("Interface.GDKP.CreateSession:build");

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
    Label:SetText("Create a new GDKP session");
    Window:AddChild(Label);

    local Name = GL.AceGUI:Create("EditBox");
    Name:DisableButton(true);
    Name:SetHeight(20);
    Name:SetFullWidth(true);
    Name:SetLabel("Name");
    Window:AddChild(Name);

    local Description = GL.AceGUI:Create("EditBox");
    Description:DisableButton(true);
    Description:SetHeight(20);
    Description:SetFullWidth(true);
    Description:SetLabel("Description");
    Window:AddChild(Description);

    local SwitchCheckbox = AceGUI:Create("CheckBox");
    SwitchCheckbox:SetValue(false);
    SwitchCheckbox:SetLabel("Switch to this session");
    SwitchCheckbox:SetFullWidth(true);
    SwitchCheckbox:SetValue(GL.GDKP:getActiveSession() == false);
    SwitchCheckbox.text:SetTextColor(.99, .85, .06);
    SwitchCheckbox.text:SetFontObject(_G["GameFontHighlightSmall"]);
    Interface:set(self, "Switch", SwitchCheckbox);
    Window:AddChild(SwitchCheckbox);

    local Save = AceGUI:Create("Button");
    Save:SetText("Save");
    Save:SetFullWidth(true);
    Save:SetCallback("OnClick", function()
        local title = strtrim(Name:GetText());

        if (GL:empty(title)) then
            return;
        end

        local Session = GL.GDKP:createSession(title);
        if (SwitchCheckbox:GetValue()) then
            GL.GDKP:setActiveSession(Session.ID);
        end

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
function CreateSession:window()
    GL:debug("Interface.GDKP.CreateSession:window");

    local Window = Interface:get(self, "Window");

    if (not Window) then
        Window = self:build();
    end

    return Window;
end

--- Toggle the create session window that's anchored to the right side of the GDKP overview window
---
---@return void
function CreateSession:toggle()
    GL:debug("Interface.GDKP.CreateSession:toggle");

    if (self.isVisible) then
        return self:close();
    end

    self:open();
end

---@return void
function CreateSession:open()
    GL:debug("Interface.GDKP.CreateSession:open");

    -- It seems our GDKP overview window is not opened
    if (not Overview.isVisible) then
        return;
    end

    local Window = self:window();

    self.isVisible = true;
    Interface:get(self, "CheckBox.Switch"):SetValue(GL.GDKP:getActiveSession() == false);
    Window.frame:SetPoint("TOPLEFT", Interface:get(Overview, "GDKPOverview").frame, "TOPRIGHT", 2, 16);
    Window.frame:Show();
end

---@return void
function CreateSession:close()
    GL:debug("Interface.GDKP.CreateSession:close");

    local Window = self:window();

    if (self.isVisible) then
        Window.frame:Hide();
        self.isVisible = false;
    end
end

GL:debug("Interface.GDKP.CreateSession.lua");