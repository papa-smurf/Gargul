local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@type GDKPOverview
local Overview = GL.Interface.GDKP.Overview;

---@type Interface
local Interface = GL.Interface;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@class EditSession
GL.Interface.GDKP.EditSession = {
    isVisible = false,
};

---@type EditSession
local EditSession = GL.Interface.GDKP.EditSession;

---@return Frame
function EditSession:build()
    GL:debug("Interface.GDKP.EditSession:build");

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
    Label:SetText();
    Window:AddChild(Label);
    Interface:set(self, "Title", Label);

    local Title = GL.AceGUI:Create("EditBox");
    Title:DisableButton(true);
    Title:SetHeight(20);
    Title:SetFullWidth(true);
    Title:SetLabel(L["Name"]);
    Window:AddChild(Title);
    Interface:set(self, "Title", Title);

    local ManagementCut = GL.AceGUI:Create("EditBox");
    ManagementCut:DisableButton(true);
    ManagementCut:SetHeight(20);
    ManagementCut:SetFullWidth(true);
    ManagementCut:SetLabel(L["Management Cut %"]);
    Window:AddChild(ManagementCut);
    Interface:set(self, "ManagementCut", ManagementCut);

    local SessionTypeLabel = GL.AceGUI:Create("Label");
    SessionTypeLabel:SetText("     " .. L["Auction type (|c00A79EFFi for more info)"]);
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

    Interface:addTooltip(SessionTypeHelpIcon, L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"], "RIGHT");

    local SessionType = {
        multi = L["Multi-Auction"],
        single = L["Single-Auction"],
    };

    local SessionTypeDropdown = GL.AceGUI:Create("Dropdown");
    SessionTypeDropdown:SetList(SessionType);
    SessionTypeDropdown:SetWidth(250);
    Window:AddChild(SessionTypeDropdown);

    local Save = AceGUI:Create("Button");
    Save:SetText(L["Ok"]);
    Save:SetFullWidth(true);
    Save:SetCallback("OnClick", function()
        local title = strtrim(Title:GetText());
        if (GL:empty(title)) then
            GL:warning(L["Invalid data supplied"]);
            return;
        end

        local managementCut = strtrim(ManagementCut:GetText());
        if (not GL:empty(managementCut)) then
            managementCut = tonumber(managementCut);
            if (not managementCut
                    or managementCut < 0
            ) then
                GL:warning(L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"]);
                return;
            end
        end

        local type = SessionTypeDropdown:GetValue();
        if (GL:empty(type)) then
            GL:warning(L["Choose a session type!"]);
            return;
        end

        GDKPSession:edit(Overview.selectedSession, title, managementCut, type);

        self:close();
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
function EditSession:window()
    GL:debug("Interface.GDKP.EditSession:window");

    local Window = Interface:get(self, "Window");

    if (not Window) then
        Window = self:build();
    end

    return Window;
end

--- Toggle the create session window that's anchored to the right side of the GDKP overview window
---
---@return void
function EditSession:toggle()
    GL:debug("Interface.GDKP.EditSession:toggle");

    if (self.isVisible) then
        return self:close();
    end

    self:open();
end

---@return void
function EditSession:open()
    GL:debug("Interface.GDKP.EditSession:open");

    local Session = GDKPSession:byID(Overview.selectedSession);

    if (not Session) then
        return;
    end

    -- It seems our GDKP overview window is not opened
    if (not Overview.isVisible) then
        return;
    end

    local Window = self:window();

    Interface:get(self, "Label.Title"):SetText((L["Editing %s"]):format(Session.title));
    Interface:get(self, "EditBox.Title"):SetText(Session.title);
    Interface:get(self, "EditBox.ManagementCut"):SetText(Session.managementCut);

    self.isVisible = true;
    Window.frame:SetPoint("TOPLEFT", Interface:get(Overview, "GDKPOverview").frame, "TOPRIGHT", 2, 16);
    Window.frame:Show();
end

---@return void
function EditSession:close()
    GL:debug("Interface.GDKP.EditSession:close");

    local Window = self:window();

    if (self.isVisible) then
        Window.frame:Hide();
        self.isVisible = false;
    end
end

GL:debug("Interface.GDKP.EditSession.lua");