---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

---@class MasterLooterPopupInterface
GL.Interface.MasterLooterDialog = {
    _initialized = false,
    isVisible = false,
    announcedConflictingAddons = false,
};
local MasterLooterDialog = GL.Interface.MasterLooterDialog; ---@type MasterLooterPopupInterface

---@return void
function MasterLooterDialog:_init()
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    GL.Events:register("MasterLooterObtainedListener", "GL.USER_OBTAINED_MASTER_LOOTER", function ()
        if (GL.Settings:get("MasterLooting.autoOpenMasterLooterDialog", true)) then
            self:draw();
        end

        if (GL.Settings:get("MasterLooting.announceMasterLooter")) then
            self:flightAttendant();
        end

        -- Announce potential addon conflicts
        if (not self.announcedConflictingAddons) then
            self.announcedConflictingAddons = true;
            GL:announceConflictingAddons();
        end
    end);
end

function MasterLooterDialog:flightAttendant()
    local function announce()
        GL.Version:playersUsingAddon(function(Players)
            -- Both are set to one because the current user counts as well!
            local total = 1;
            local haveAddon = 1;
            for _, hasAddon in pairs(Players) do
                total = total + 1;

                if (hasAddon) then
                    haveAddon = haveAddon + 1;
                end
            end

            if (total > haveAddon) then
                GL:sendChatMessage(
                        string.format(
                            "Ladies and gentlemen this is your Master Looter %s speaking, today we are raiding with our trusty loot add-on: Gargul. %s/%s people are already on board. Get Gargul on CurseForge or your favorite add-on manager!",
                            GL.User.name,
                            haveAddon,
                            total
                        ),
                        "GROUP",
                        nil,
                        nil,
                        false
                );
            else
                GL:sendChatMessage(
                    string.format(
                        "Ladies and gentlemen this is your Master Looter %s speaking, today we are raiding with our trusty loot add-on: Gargul!",
                        GL.User.name
                    ),
                    "GROUP",
                    nil,
                    nil,
                    false
                );
            end
        end);
    end

    -- The comm channel takes around 2 seconds to be fully establed
    -- If the add-on has not been loaded for that long yet we need
    -- to set a delay for the announcement message
    local addonLoadedInSeconds = GetServerTime() - GL.loadedOn;
    if (addonLoadedInSeconds < 4) then
        GL.Ace:ScheduleTimer(function ()
            announce();
        end, 4 - addonLoadedInSeconds);
    else
        announce();
    end
end

---@return void
function MasterLooterDialog:draw()
    GL:debug("MasterLooterDialog:draw");

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("FLOW");
    Window:SetWidth(300);
    Window:SetHeight(180);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window:SetPoint(GL.Interface:getPosition("MasterLooterDialog"));
    GL.Interface:setItem(self, "Window", Window);

    local DescriptionFrame = AceGUI:Create("SimpleGroup");
    DescriptionFrame:SetLayout("FILL");
    DescriptionFrame:SetFullWidth(true);
    DescriptionFrame:SetHeight(25);
    Window:AddChild(DescriptionFrame);

    local Description = AceGUI:Create("Label");
    Description:SetFontObject(_G["GameFontNormal"]);
    Description:SetFullWidth(true);
    Description:SetJustifyH("CENTER");
    Description:SetText("You were given the role of Master Looter");
    DescriptionFrame:AddChild(Description);

    -- SoftRes
    local SoftResButtonText = "Clear SoftRes";
    if (not GL.SoftRes:available()) then
        SoftResButtonText = "Import SoftRes";
    end

    local SoftResButton = AceGUI:Create("Button");
    SoftResButton:SetText(SoftResButtonText);
    SoftResButton:SetHeight(20);
    SoftResButton:SetWidth(120);
    SoftResButton:SetCallback("OnClick", function()
        if (GL.SoftRes:available()) then
            GL.SoftRes:clear();
            SoftResButton:SetText("Import SoftRes");
            return;
        end

        GL.SoftRes:draw();
    end);
    Window:AddChild(SoftResButton);

    GL.Events:register("MasterLooterSoftResImportedListener", "GL.SOFTRES_IMPORTED", function ()
        SoftResButton:SetText("Clear SoftRes");
    end);

    local VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(12);
    VerticalSpacer:SetHeight(10);
    Window:AddChild(VerticalSpacer);

    -- TMB
    local TMBButtonText = "Clear TMB";
    if (not GL.TMB:available()) then
        TMBButtonText = "Import TMB";
    end

    local TMBButton = AceGUI:Create("Button");
    TMBButton:SetText(TMBButtonText);
    TMBButton:SetHeight(20);
    TMBButton:SetWidth(120);
    TMBButton:SetCallback("OnClick", function()
        if (GL.TMB:available()) then
            TMBButton:SetText("Import TMB");
            GL.TMB:clear();
            return;
        end

        GL.TMB:drawImporter();
    end);
    Window:AddChild(TMBButton);

    GL.Events:register("MasterLooterTMBImportedListener", "GL.TMB_IMPORTED", function ()
        TMBButton:SetText("Clear TMB");
    end);

    local HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Window:AddChild(HorizontalSpacer);

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(24);
    VerticalSpacer:SetHeight(10);
    Window:AddChild(VerticalSpacer);

    -- Auto open checkbox
    local AutoOpenCheckbox = AceGUI:Create("CheckBox");
    AutoOpenCheckbox:SetLabel("");
    AutoOpenCheckbox:SetDescription("");
    AutoOpenCheckbox:SetHeight(20);
    AutoOpenCheckbox:SetWidth(24);
    AutoOpenCheckbox:SetValue(GL.Settings:get("MasterLooting.autoOpenMasterLooterDialog", true));
    AutoOpenCheckbox:SetCallback("OnValueChanged", function(Checkbox)
        GL.Settings:set("MasterLooting.autoOpenMasterLooterDialog", Checkbox:GetValue());
        print(GL.Settings:get("MasterLooting.autoOpenMasterLooterDialog"));
    end);
    Window:AddChild(AutoOpenCheckbox);

    -- Plus one label
    local CheckBoxLabel = AceGUI:Create("InteractiveLabel");
    CheckBoxLabel:SetFontObject(_G["GameFontNormal"]);
    CheckBoxLabel:SetWidth(200);
    CheckBoxLabel:SetText("Open this window automatically");

    CheckBoxLabel:SetCallback("OnClick", function()
        AutoOpenCheckbox:ToggleChecked();
    end);

    Window:AddChild(CheckBoxLabel);
end

---@return void
function MasterLooterDialog:close()
    GL:debug("MasterLooterDialog:close");

    local Window = GL.Interface:getItem(self, "Window");

    if (not Window) then
        return;
    end

    GL.Interface:storePosition(Window, "MasterLooterDialog");
    Window:Hide();

    self.isVisible = false;
end

GL:debug("Interfaces/MasterLooterDialog.lua");