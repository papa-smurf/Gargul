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
    Label:SetText("Editing");
    Window:AddChild(Label);
    Interface:set(self, "Title", Label);

    local Title = GL.AceGUI:Create("EditBox");
    Title:DisableButton(true);
    Title:SetHeight(20);
    Title:SetFullWidth(true);
    Title:SetLabel("Name");
    Window:AddChild(Title);
    Interface:set(self, "Title", Title);

    local ManagementCut = GL.AceGUI:Create("EditBox");
    ManagementCut:DisableButton(true);
    ManagementCut:SetHeight(20);
    ManagementCut:SetFullWidth(true);
    ManagementCut:SetLabel("Management Cut %");
    Window:AddChild(ManagementCut);
    Interface:set(self, "ManagementCut", ManagementCut);

    local SessionTypeLabel = GL.AceGUI:Create("Label");
    SessionTypeLabel:SetText("     Auction type (|c00a79effi|r for more info)");
    SessionTypeLabel:SetColor(1, .95686, .40784);
    SessionTypeLabel:SetHeight(20);
    SessionTypeLabel:SetFullWidth(true);
    Window:AddChild(SessionTypeLabel);

    local MutatorHelpIcon = AceGUI:Create("Icon");
    MutatorHelpIcon:SetWidth(12);
    MutatorHelpIcon:SetHeight(12);
    MutatorHelpIcon:SetImageSize(12, 12);
    MutatorHelpIcon:SetImage("interface/friendsframe/informationicon");
    MutatorHelpIcon.frame:SetParent(SessionTypeLabel.frame);
    MutatorHelpIcon.frame:SetPoint("BOTTOMLEFT", SessionTypeLabel.frame, "BOTTOMLEFT", 1, -6);
    MutatorHelpIcon.frame:Show();

    MutatorHelpIcon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(MutatorHelpIcon.frame, "ANCHOR_RIGHT");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("|c00a79effMulti-Auction|r allows you to start bids on multiple items at once, speeding things up!");
        GameTooltip:AddLine("Follow the instructions after creating this session to get started");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("With |c00a79effSingle-Auction|r you choose to auction off single items instead or use the queue");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("Selecting |c00a79effMulti-Auction|r prevents dropped items from being added to the queue");
        GameTooltip:AddLine("You can mix |c00a79effMulti-Auction|r with |c00a79effSingle-Auction|r and the queue but we strongly advise against it");
        GameTooltip:AddLine(" ");
        GameTooltip:Show();
    end);

    MutatorHelpIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);

    local SessionType = {
        multi = "Multi-Auction",
        single = "Single-Auction",
    };

    local SessionTypeDropdown = GL.AceGUI:Create("Dropdown");
    SessionTypeDropdown:SetList(SessionType);
    SessionTypeDropdown:SetWidth(250);
    Window:AddChild(SessionTypeDropdown);

    local Save = AceGUI:Create("Button");
    Save:SetText("Save");
    Save:SetFullWidth(true);
    Save:SetCallback("OnClick", function()
        local title = strtrim(Title:GetText());
        if (GL:empty(title)) then
            GL:warning("Add a GDKP name");
            return;
        end

        local managementCut = strtrim(ManagementCut:GetText());
        if (not GL:empty(managementCut)) then
            managementCut = tonumber(managementCut);
            if (not managementCut
                    or managementCut < 0
            ) then
                GL:warning("Management Cut needs to be empty or between 0 and 99 (no % sign!)");
                return;
            end
        end

        local type = SessionTypeDropdown:GetValue();
        if (GL:empty(type)) then
            GL:warning("Choose a session type!");
            return;
        end

        GDKPSession:edit(Overview.selectedSession, title, managementCut, type);

        self:close();
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

    Interface:get(self, "Label.Title"):SetText("Editing " .. Session.title);
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