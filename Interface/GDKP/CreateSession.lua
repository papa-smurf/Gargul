local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@type GDKPOverview
local Overview = GL.Interface.GDKP.Overview;

---@type Interface
local Interface = GL.Interface;

---@class CreateSession
GL.Interface.GDKP.CreateSession = {
    isVisible = false,
};

---@type CreateSession
local CreateSession = GL.Interface.GDKP.CreateSession;

---@return Frame
function CreateSession:build()
    if (not GL.GDKPIsAllowed) then
        return GL:error(L.GDKPS_ARE_NOT_ALLOWED);
    end

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
    Label:SetText(L.GDKP_CREATE);
    Window:AddChild(Label);

    local Title = GL.AceGUI:Create("EditBox");
    Title:DisableButton(true);
    Title:SetHeight(20);
    Title:SetFullWidth(true);
    Title:SetLabel(L.NAME);
    Window:AddChild(Title);

    local ManagementCut = GL.AceGUI:Create("EditBox");
    ManagementCut:DisableButton(true);
    ManagementCut:SetHeight(20);
    ManagementCut:SetFullWidth(true);
    ManagementCut:SetLabel(L.GDKP_CREATE_MANAGEMENT_CUT);
    Window:AddChild(ManagementCut);

    local SessionTypeLabel = GL.AceGUI:Create("Label");
    SessionTypeLabel:SetText("     " .. L.GDKP_CREATE_SESSION_TYPE_LABEL);
    SessionTypeLabel:SetColor(1, .95686, .40784);
    SessionTypeLabel:SetHeight(20);
    SessionTypeLabel:SetFullWidth(true);
    Window:AddChild(SessionTypeLabel);

    local SessionTypeHelpIcon = AceGUI:Create("Icon");
    SessionTypeHelpIcon:SetWidth(12);
    SessionTypeHelpIcon:SetHeight(12);
    SessionTypeHelpIcon:SetImageSize(12, 12);
    SessionTypeHelpIcon:SetImage("interface/friendsframe/informationicon");
    SessionTypeHelpIcon.frame:SetParent(SessionTypeLabel.frame);
    SessionTypeHelpIcon.frame:SetPoint("BOTTOMLEFT", SessionTypeLabel.frame, "BOTTOMLEFT", 1, -6);
    SessionTypeHelpIcon.frame:Show();

    Interface:addTooltip(SessionTypeHelpIcon, L.GDKP_CREATE_SESSION_TYPE_INFO, "RIGHT");

    local SessionType = {
        multi = L.GDKP_CREATE_SESSION_TYPE_MULTI,
        single = L.GDKP_CREATE_SESSION_TYPE_SINGLE,
    };

    local SessionTypeDropdown = GL.AceGUI:Create("Dropdown");
    SessionTypeDropdown:SetList(SessionType);
    SessionTypeDropdown:SetWidth(250);
    Window:AddChild(SessionTypeDropdown);

    local SwitchCheckbox = AceGUI:Create("CheckBox");
    SwitchCheckbox:SetValue(false);
    SwitchCheckbox:SetLabel(L.GDKP_CREATE_SESSION_SWITCH);
    SwitchCheckbox:SetFullWidth(true);
    SwitchCheckbox:SetValue(GDKPSession:getActive() == false);
    SwitchCheckbox.text:SetTextColor(.99, .85, .06);
    SwitchCheckbox.text:SetFontObject(_G["GameFontHighlightSmall"]);
    Interface:set(self, "Switch", SwitchCheckbox);
    Window:AddChild(SwitchCheckbox);

    local Save = AceGUI:Create("Button");
    Save:SetText(L.OK);
    Save:SetFullWidth(true);
    Save:SetCallback("OnClick", function()
        local title = strtrim(Title:GetText());
        if (GL:empty(title)) then
            GL:warning(L.INVALID_DATA_WARNING);
            return;
        end

        local managementCut = strtrim(ManagementCut:GetText());
        if (not GL:empty(managementCut)) then
            managementCut = tonumber(managementCut);
            if (not managementCut
                or managementCut < 0
            ) then
                GL:warning(L.GDKP_CREATE_SESSION_INVALID_CUT);
                return;
            end
        end

        local type = SessionTypeDropdown:GetValue();
        if (GL:empty(type)) then
            GL:warning(L.GDKP_CREATE_SESSION_INVALID_TYPE);
            return;
        end

        local Session = GDKPSession:create(title, managementCut or nil, type);

        if (not Session) then
            GL:warning(L.SOMETHING_WENT_WRONG_WARNING);
            return;
        end

        if (SwitchCheckbox:GetValue()) then
            GDKPSession:setActive(Session.ID);
        end

        Title:SetText();
        ManagementCut:SetText();
        SwitchCheckbox:SetValue(false);
        self:close();

        GL:notice(L.GDKP_CREATE_SUCCESSFUL);
    end);
    Window:AddChild(Save);

    local Cancel = AceGUI:Create("Button");
    Cancel:SetText(L.CANCEL);
    Cancel:SetFullWidth(true);
    Cancel:SetCallback("OnClick", function()
        self:close();
    end);
    Window:AddChild(Cancel);

    return Window;
end

---@return Frame
function CreateSession:window()
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
    if (self.isVisible) then
        return self:close();
    end

    self:open();
end

---@return void
function CreateSession:open()
    -- It seems our GDKP overview window is not opened
    if (not Overview.isVisible) then
        return;
    end

    local Window = self:window();

    self.isVisible = true;
    Interface:get(self, "CheckBox.Switch"):SetValue(GDKPSession:getActive() == false);
    Window.frame:SetPoint("TOPLEFT", Interface:get(Overview, "GDKPOverview").frame, "TOPRIGHT", 2, 16);
    Window.frame:Show();
end

---@return void
function CreateSession:close()
    local Window = self:window();

    if (self.isVisible) then
        Window.frame:Hide();
        self.isVisible = false;
    end
end
