---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@class CreateSession
GL.Interface.GDKP.CreateSession = {}

---@type CreateSession
local CreateSession = GL.Interface.GDKP.CreateSession;

---@return void
function CreateSession:draw()
    GL:debug("GDKP.CreateSession:draw");

    local VerticalSpacer;

    -- Release any existing edit auction window
    self:close();

    ---@type GDKPOverview
    local Overview = GL.Interface.GDKP.Overview;

    -- It seems our GDKP overview window is not opened
    if (not Overview.isVisible) then
        return;
    end

    -- Create a container/parent frame
    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(200);
    Window:SetHeight(280);
    Window:SetPoint("TOPLEFT", Overview.Window.frame, "TOPRIGHT", 2, 16);
    GL.Interface:set(self, "Window", Window);
    Window.frame:SetFrameStrata("HIGH");
    Window.frame:Show();

    local Label = GL.AceGUI:Create("Label");
    Label:SetHeight(20);
    Label:SetFullWidth(true);
    Label:SetText("Create a new GDKP session");
    Window:AddChild(Label);

    local Name = GL.AceGUI:Create("EditBox");
    Name:DisableButton(true);
    Name:SetHeight(20);
    Name:SetFullWidth(true);
    Name:SetText("");
    Name:SetLabel("Name");
    Window:AddChild(Name);

    local Description = GL.AceGUI:Create("EditBox");
    Description:DisableButton(true);
    Description:SetHeight(20);
    Description:SetFullWidth(true);
    Description:SetText("");
    Description:SetLabel("Description");
    Window:AddChild(Description);

    local thereIsAnActiveGDKPSession = GL.GDKP:getActiveSession() ~= false;
    local SwitchCheckbox = AceGUI:Create("CheckBox");
    SwitchCheckbox:SetValue(false);
    SwitchCheckbox:SetLabel("Switch to this session");
    SwitchCheckbox:SetFullWidth(true);
    SwitchCheckbox:SetValue(not thereIsAnActiveGDKPSession);
    SwitchCheckbox.text:SetTextColor(.99, .85, .06);
    SwitchCheckbox.text:SetFontObject(_G["GameFontHighlightSmall"]);
    Window:AddChild(SwitchCheckbox);

    local Save = AceGUI:Create("Button");
    Save:SetText("Save");
    Save:SetFullWidth(true);
    Save:SetCallback("OnClick", function()
        local title = strtrim(Description:GetText());

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
end

function CreateSession:close()
    GL.Interface:release(self, "Window");
end

GL:debug("Interfaces/GDKP/CreateSession.lua");