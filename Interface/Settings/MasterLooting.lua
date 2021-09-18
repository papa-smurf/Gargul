---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class MasterLootingSettings
GL.Interface.Settings.MasterLooting = {
    description = "",
};
local MasterLooting = GL.Interface.Settings.MasterLooting; ---@type MasterLootingSettings

---@return void
function MasterLooting:draw(Parent)
    GL:debug("MasterLootingSettings:draw");

    local Checkboxes = {
        {
            label = "Show Master Looter Popup",
            description = "This setting enables the master looter window that automatically pops up when you are given the role of master looter. It provides easy access to clearing and importing data from SoftRes and Thatsmybis",
            setting = "MasterLooting.autoOpenMasterLooterDialog",
        },
        {
            label = "Announce Master Looter",
            description = "When enabled you automatically post a message in chat when you are given the role of master looter. Disabling this rule automatically disables the 'Countdown on rolls' setting in order to raise awareness for Gargul",
            setting = "MasterLooting.announceMasterLooter",
            callback = function (Checkbox)
                if (not Checkbox:GetValue()) then
                    GL.Settings:set("MasterLooting.doCountdown", false);
                    local LinkedCheckbox = GL.Interface:getItem(GL.Settings, "CheckBox." .. "MasterLooting.doCountdown");

                    if (LinkedCheckbox) then
                        LinkedCheckbox:SetValue(false);
                    end
                end
            end
        },
        {
            label = "Countdown on rolls",
            description = "If enabled a countdown will be shown in chat when a roll is coming to an end (e.g: you have 5 seconds to roll). Enabling this rule automatically enables the 'Announce Master Looter' setting in order to raise awareness for Gargul",
            setting = "MasterLooting.doCountdown",
            callback = function (Checkbox)
                if (Checkbox:GetValue()) then
                    GL.Settings:set("MasterLooting.announceMasterLooter", true);
                    local LinkedCheckbox = GL.Interface:getItem(GL.Settings, "CheckBox." .. "MasterLooting.announceMasterLooter");

                    if (LinkedCheckbox) then
                        LinkedCheckbox:SetValue(true);
                    end
                end
            end
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local NumberOfSecondsToCountdown = GL.AceGUI:Create("Slider");
    NumberOfSecondsToCountdown:SetLabel("At how many seconds left do you want to start the countdown?");
    NumberOfSecondsToCountdown.label:SetTextColor(1, .95686, .40784);
    NumberOfSecondsToCountdown:SetFullWidth(true);
    NumberOfSecondsToCountdown:SetValue(GL.Settings:get("MasterLooting.numberOfSecondsToCountdown", 5));
    NumberOfSecondsToCountdown:SetSliderValues(3, 25, 1);
    NumberOfSecondsToCountdown:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));

        if (value >= 3) then
            GL.Settings:set("MasterLooting.numberOfSecondsToCountdown", value);
        end
    end);
    Parent:AddChild(NumberOfSecondsToCountdown);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    Overview:drawCheckboxes({
        {
            label = "Announce end of roll",
            description = "When enabled you post an announcement in /rw when a roll has ended",
            setting = "MasterLooting.announceRollEnd",
        },
    }, Parent);
end

GL:debug("Interface/Settings/MasterLooting.lua");