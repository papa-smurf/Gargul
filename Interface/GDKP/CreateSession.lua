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

    -- Create a container/parent frame
    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(300);
    Window:SetHeight(280);
    Window:SetPoint("TOPLEFT", GL.Interface:getItem(Overview, "Window").frame, "TOPRIGHT", 2, 16);
    GL.Interface:setItem(self, "Window", Window);
    Window.frame:SetFrameStrata("HIGH");
    Window.frame:Show();

    local SessionNameInput = GL.AceGUI:Create("EditBox");
    SessionNameInput:DisableButton(true);
    SessionNameInput:SetHeight(20);
    SessionNameInput:SetWidth(250);
    SessionNameInput:SetText("");
    SessionNameInput:SetLabel("Session name");
    Window:AddChild(SessionNameInput);

    local SwitchCheckbox = AceGUI:Create("CheckBox");
    SwitchCheckbox:SetValue(false);
    SwitchCheckbox:SetLabel("Switch to this session");
    SwitchCheckbox:SetFullWidth(true);
    SwitchCheckbox.text:SetTextColor(.99, .85, .06);
    SwitchCheckbox.text:SetFontObject(_G["GameFontHighlightSmall"]);
    Window:AddChild(SwitchCheckbox);

    local SaveButton = AceGUI:Create("Button");
    SaveButton:SetText("Save");
    SaveButton:SetWidth(100); -- Minimum is 60
    SaveButton:SetCallback("OnClick", function()
        local title = strtrim(SessionNameInput:GetText());

        if (GL:empty(title)) then
            return;
        end

        local Session = GL.GDKP:createSession(title);
        if (SwitchCheckbox:GetValue()) then
            GL.GDKP:setActiveSession(Session.ID);
        end

        if (Overview.isVisible) then
            GL.Interface:getItem(Overview, "Window"):Hide();
            Overview:draw();
            self:close();
        end
    end);
    Window:AddChild(SaveButton);

    local CancelButton = AceGUI:Create("Button");
    CancelButton:SetText("Cancel");
    CancelButton:SetWidth(100); -- Minimum is 60
    CancelButton:SetCallback("OnClick", function()
        self:close();
    end);
    Window:AddChild(CancelButton);
end

function CreateSession:close()
    GL.Interface:release(self, "Window");
end

GL:debug("Interfaces/GDKP/CreateSession.lua");