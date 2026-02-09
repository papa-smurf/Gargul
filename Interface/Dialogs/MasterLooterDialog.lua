local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

---@class MasterLooterPopupInterface
GL.Interface.MasterLooterDialog = {
    _initialized = false,
    isVisible = false,
    announcedConflictingAddons = false,
    announcedUseOfGargul = false,
    showedMasterLooterDialog = false,
    VersionCheckTimer = nil,
};
local MasterLooterDialog = GL.Interface.MasterLooterDialog; ---@type MasterLooterPopupInterface

---@return nil
function MasterLooterDialog:_init()
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    GL.Events:register("MasterLooterObtainedListener", "GL.USER_OBTAINED_MASTER_LOOTER", function ()
        if (self.VersionCheckTimer) then
            GL:debug("Cancel MasterLooterDialog.VersionCheckTimer");

            GL.Ace:CancelTimer(self.VersionCheckTimer);
            self.VersionCheckTimer = nil;
        end

        if (not self.showedMasterLooterDialog
            and GL.Settings:get("MasterLooting.autoOpenMasterLooterDialog")
        ) then
            self.showedMasterLooterDialog = true;
            self:draw();
        end

        if (not self.announcedUseOfGargul
            and GL.Settings:get("MasterLooting.announceMasterLooter")
        ) then
            self.announcedUseOfGargul = true;
            self:flightAttendant();
        end

        -- Announce potential addon conflicts
        if (not self.announcedConflictingAddons) then
            self.announcedConflictingAddons = true;
            GL:announceConflictingAddons();
        end

        -- Make sure we periodically check whether the master looter's Gargul version is up-to-date
        GL:debug("Schedule new MasterLooterDialog.VersionCheckTimer");
        self.VersionCheckTimer = GL.Ace:ScheduleRepeatingTimer(function ()
            GL:debug("Run MasterLooterDialog.VersionCheckTimer");

            GL.Version:inspectQuietly();
        end, 1800);

        GL.Version:inspectQuietly();
    end);

    GL.Events:register("MasterLooterLostListener", "GL.USER_LOST_MASTER_LOOTER", function ()
        if (self.VersionCheckTimer) then
            GL:debug("Cancel MasterLooterDialog.VersionCheckTimer");

            GL.Ace:CancelTimer(self.VersionCheckTimer);
            self.VersionCheckTimer = nil;
        end
    end);
end

--- Announce the use of Gargul to the rest of the raid
---
---@return nil
---
--- /script _G.Gargul.Interface.MasterLooterDialog:flightAttendant();
function MasterLooterDialog:flightAttendant()
    local function announce()
        local message = L.CHAT["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"];
        local stw = not GL:strContains(strlower(message), L["Gargul"]);

        GL:sendChatMessage(
            message,
            "GROUP",
            nil,
            nil,
            stw
        );
    end

    -- If the add-on has not been loaded for that long yet we need
    -- to set a delay for the announcement message
    local addonLoadedInSeconds = GetServerTime() - GL.loadedOn;

    -- No need to announce if it's < 5 since it's most likely a /reload
    if (addonLoadedInSeconds >= 5) then
        announce();
    end
end

---@return nil
---
---@test /script _G.Gargul.Interface.MasterLooterDialog:draw();
function MasterLooterDialog:draw()
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetLayout("FLOW");
    Window:SetWidth(500);
    Window:SetHeight(160);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function ()
        self:close();
    end);
    Window:SetPoint(GL.Interface:getPosition("MasterLooterDialog"));
    GL.Interface:set(self, "Window", Window);

    -- Make sure the window can be closed by pressing the escape button
    _G.GARGUL_MASTER_LOOTER_DIALOG_WINDOW = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_MASTER_LOOTER_DIALOG_WINDOW");

    local DescriptionFrame = AceGUI:Create("SimpleGroup");
    DescriptionFrame:SetLayout("FILL");
    DescriptionFrame:SetFullWidth(true);
    DescriptionFrame:SetHeight(25);
    Window:AddChild(DescriptionFrame);

    local Description = AceGUI:Create("Label");
    Description:SetFontObject(_G.GameFontNormal);
    Description:SetFullWidth(true);
    Description:SetJustifyH("CENTER");
    Description:SetText(L["You were given the role of Master Looter"]);
    DescriptionFrame:AddChild(Description);

    -- SoftRes
    local SoftResButtonText = L["Clear SoftRes"];
    if (not GL.SoftRes:available()) then
        SoftResButtonText = L["Import SoftRes"];
    end

    local SoftResButton = AceGUI:Create("Button");
    SoftResButton:SetText(SoftResButtonText);
    SoftResButton:SetHeight(20);
    SoftResButton:SetWidth(124);
    SoftResButton:SetCallback("OnClick", function ()
        if (GL.SoftRes:available()) then
            GL.SoftRes:clear();
            SoftResButton:SetText(L["Import SoftRes"]);
            return;
        end

        GL.SoftRes:draw();
    end);
    Window:AddChild(SoftResButton);

    GL.Events:register("MasterLooterSoftResImportedListener", "GL.SOFTRES_IMPORTED", function ()
        SoftResButton:SetText(L["Clear SoftRes"]);
    end);

    local VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(12);
    VerticalSpacer:SetHeight(10);
    Window:AddChild(VerticalSpacer);

    -- TMB
    local TMBButtonText = L["Clear TMB"];
    if (not GL.TMB:available()) then
        TMBButtonText = L["Import TMB"];
    end

    local TMBButton = AceGUI:Create("Button");
    TMBButton:SetText(TMBButtonText);
    TMBButton:SetHeight(20);
    TMBButton:SetWidth(120);
    TMBButton:SetCallback("OnClick", function ()
        if (GL.TMB:available()) then
            TMBButton:SetText(L["Import TMB"]);
            GL.TMB:clear();
            return;
        end

        GL.TMB:draw();
    end);
    Window:AddChild(TMBButton);

    GL.Events:register("MasterLooterTMBImportedListener", "GL.TMB_IMPORTED", function ()
        TMBButton:SetText(L["Clear TMB"]);
    end);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(12);
    VerticalSpacer:SetHeight(10);
    Window:AddChild(VerticalSpacer);

    local GDKPButton = AceGUI:Create("Button");
    GDKPButton:SetText(L["GDKP"]);
    GDKPButton:SetHeight(20);
    GDKPButton:SetWidth(120);
    GDKPButton:SetCallback("OnClick", function ()
        GL.Interface.GDKP.Overview:open();
    end);
    Window:AddChild(GDKPButton);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(12);
    VerticalSpacer:SetHeight(10);
    Window:AddChild(VerticalSpacer);

    local PlusOneButton = AceGUI:Create("Button");
    PlusOneButton:SetText(L["+1"]);
    PlusOneButton:SetHeight(20);
    PlusOneButton:SetWidth(50);
    PlusOneButton:SetCallback("OnClick", function ()
        GL.Interface.PlusOnes.Overview:draw();
    end);
    Window:AddChild(PlusOneButton);

    local HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Window:AddChild(HorizontalSpacer);

    -- Auto open checkbox
    local AutoOpenCheckbox = AceGUI:Create("CheckBox");
    AutoOpenCheckbox:SetLabel("");
    AutoOpenCheckbox:SetDescription("");
    AutoOpenCheckbox:SetHeight(20);
    AutoOpenCheckbox:SetWidth(24);
    AutoOpenCheckbox:SetValue(GL.Settings:get("MasterLooting.autoOpenMasterLooterDialog", true));
    AutoOpenCheckbox:SetCallback("OnValueChanged", function (Checkbox)
        GL.Settings:set("MasterLooting.autoOpenMasterLooterDialog", Checkbox:GetValue());
    end);
    Window:AddChild(AutoOpenCheckbox);

    -- Auto open label
    local CheckBoxLabel = AceGUI:Create("InteractiveLabel");
    CheckBoxLabel:SetFontObject(_G.GameFontNormal);
    CheckBoxLabel:SetWidth(200);
    CheckBoxLabel:SetText(L["Open this window automatically"]);

    CheckBoxLabel:SetCallback("OnClick", function ()
        AutoOpenCheckbox:ToggleChecked();
        AutoOpenCheckbox:Fire("OnValueChanged");
    end);

    Window:AddChild(CheckBoxLabel);
end

---@return nil
function MasterLooterDialog:close()
    local Window = GL.Interface:get(self, "Window");

    if (not Window) then
        return;
    end

    GL.Interface:storePosition(Window, "MasterLooterDialog");
    Window:Hide();

    self.isVisible = false;
end
