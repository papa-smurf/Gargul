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
        return GL:error(L["GDKP raids are not allowed in this version of World of Warcraft"]);
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
    Label:SetText(L["Create a new GDKP session"]);
    Window:AddChild(Label);

    local Title = GL.AceGUI:Create("EditBox");
    Title:DisableButton(true);
    Title:SetHeight(20);
    Title:SetFullWidth(true);
    Title:SetLabel(L["Name"]);
    Window.TitleBox = Title;
    Window:AddChild(Title);

    local ManagementCut = GL.AceGUI:Create("EditBox");
    ManagementCut:DisableButton(true);
    ManagementCut:SetHeight(20);
    ManagementCut:SetFullWidth(true);
    ManagementCut:SetLabel(L["Management Cut %"]);
    ManagementCut:SetText(GL.Settings:get("UI.GDKP.Create.managementCut", ""));
    Window.ManagementCutBox = ManagementCut;
    Window:AddChild(ManagementCut);

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
    SessionTypeHelpIcon.frame:SetPoint("BOTTOMLEFT", SessionTypeLabel.frame, "BOTTOMLEFT", 1, 4);
    SessionTypeHelpIcon.frame:Show();

    Interface:addTooltip(SessionTypeHelpIcon, L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"], "RIGHT");

    local SessionType = {
        multi = L["Multi-Auction"],
        single = L["Single-Auction"],
    };

    local SessionTypeDropdown = GL.AceGUI:Create("Dropdown");
    SessionTypeDropdown:SetList(SessionType);
    SessionTypeDropdown:SetWidth(250);
    Window.SessionTypeDropdown = SessionTypeDropdown;
    Window:AddChild(SessionTypeDropdown);

    -- Prefill previously selected session type
    local previousSessionType = GL.Settings:get("UI.GDKP.Create.sessionType");
    if (previousSessionType) then
        if (previousSessionType == "single") then
            SessionTypeDropdown:SetText(L["Single-Auction"]);
            SessionTypeDropdown:SetValue("single");
        elseif (previousSessionType == "multi") then
            SessionTypeDropdown:SetValue("multi");
            SessionTypeDropdown:SetText(L["Multi-Auction"]);
        end
    end

    local SwitchCheckbox = AceGUI:Create("CheckBox");
    SwitchCheckbox:SetValue(false);
    SwitchCheckbox:SetLabel(L["Switch to this session"]);
    SwitchCheckbox:SetFullWidth(true);
    SwitchCheckbox:SetValue(GDKPSession:getActive() == false);
    SwitchCheckbox.text:SetTextColor(.99, .85, .06);
    SwitchCheckbox.text:SetFontObject(_G.GameFontHighlightSmall);
    Interface:set(self, "Switch", SwitchCheckbox);
    Window.SwitchCheckbox = SwitchCheckbox;
    Window:AddChild(SwitchCheckbox);

    local Save = AceGUI:Create("Button");
    Save:SetText(L["Ok"]);
    Save:SetFullWidth(true);
    Save:SetCallback("OnClick", function ()
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

        local Session = GDKPSession:create(title, managementCut or nil, type);

        if (not Session) then
            GL:warning(L["Something went wrong!"]);
            return;
        end

        -- Store session creation details so we can prefill next time
        GL.Settings:set("UI.GDKP.Create.managementCut", managementCut);
        GL.Settings:set("UI.GDKP.Create.sessionType", type);

        if (SwitchCheckbox:GetValue()) then
            GDKPSession:setActive(Session.ID);
        end

        Title:SetText();
        ManagementCut:SetText();
        SwitchCheckbox:SetValue(false);
        self:close();

        GL:notice(L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"]);
    end);
    Window.SaveButton = Save;
    Window:AddChild(Save);

    local Cancel = AceGUI:Create("Button");
    Cancel:SetText(L["Cancel"]);
    Cancel:SetFullWidth(true);
    Cancel:SetCallback("OnClick", function ()
        self:close();
    end);
    Window.CancelButton = Cancel;
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
---@return nil
function CreateSession:toggle()
    if (self.isVisible) then
        return self:close();
    end

    self:open();
end

---@return nil
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

---@return nil
function CreateSession:close()
    local Window = self:window();

    if (self.isVisible) then
        Window.frame:Hide();
        self.isVisible = false;
    end
end
