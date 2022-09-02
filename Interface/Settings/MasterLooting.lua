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

    -- SetLootMethod('Master','Character Name','1')

    -- Give classic era users an easy way to change the master looting threshold
    if (GL.isEra) then
        local LootThresholdLabel = GL.AceGUI:Create("Label");
        LootThresholdLabel:SetText("Master Loot quality Threshold");
        LootThresholdLabel:SetColor(1, .95686, .40784);
        LootThresholdLabel:SetHeight(20);
        LootThresholdLabel:SetFullWidth(true);
        Parent:AddChild(LootThresholdLabel);

        local DropdownItems = {
            [0] = "0 - Poor",
            [1] = "1 - Common",
            [2] = "2 - Uncommon",
            [3] = "3 - Rare",
            [4] = "4 - Epic",
            [5] = "5 - Legendary",
        };

        local LootThreshold = GL.AceGUI:Create("Dropdown");
        LootThreshold:SetValue(GL.Settings:get("MasterLooting.preferredMasterLootingThreshold", 2));
        LootThreshold:SetList(DropdownItems);
        LootThreshold:SetText(DropdownItems[GL.Settings:get("MasterLooting.preferredMasterLootingThreshold", 2)]);
        LootThreshold:SetWidth(150);
        LootThreshold:SetCallback("OnValueChanged", function()
            GL.Settings:set("MasterLooting.preferredMasterLootingThreshold", LootThreshold:GetValue());
        end);
        Parent:AddChild(LootThreshold);

        local VerticalSpacer = GL.AceGUI:Create("SimpleGroup");
        VerticalSpacer:SetLayout("FILL");
        VerticalSpacer:SetWidth(10);
        VerticalSpacer:SetHeight(10);
        Parent:AddChild(VerticalSpacer);

        local ApplyLootThreshold = GL.AceGUI:Create("Button");
        ApplyLootThreshold:SetText("Apply");
        ApplyLootThreshold:SetWidth("80");
        ApplyLootThreshold:SetCallback("OnClick", function()
            local threshold = LootThreshold:GetValue();
            SetLootMethod('Master', GL.User.name, tostring(threshold));
        end);
        Parent:AddChild(ApplyLootThreshold);

        local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
        HorizontalSpacer:SetLayout("FILL");
        HorizontalSpacer:SetFullWidth(true);
        HorizontalSpacer:SetHeight(10);
        Parent:AddChild(HorizontalSpacer);
    end

    local Checkboxes = {
        {
            label = "Show Master Looter Popup",
            description = "This setting enables the master looter window that automatically pops up when you are given the role of master looter. It provides easy access to clearing and importing data from SoftRes and Thatsmybis",
            setting = "MasterLooting.autoOpenMasterLooterDialog",
        },
        {
            label = "Announce Master Looter",
            description = "When enabled you automatically post a message in chat when you are given the role of master looter",
            setting = "MasterLooting.announceMasterLooter",
        },
        {
            label = "Announce start of roll",
            description = "When enabled you post an announcement in /rw when a roll starts",
            setting = "MasterLooting.announceRollStart",
        },
        {
            label = "Countdown on rolls",
            description = "If enabled a countdown will be shown in chat when a roll is coming to an end (e.g: you have 5 seconds to roll)",
            setting = "MasterLooting.doCountdown",
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

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(15);
    Parent:AddChild(HorizontalSpacer);

    local DefaultRollOffNote = GL.AceGUI:Create("EditBox");
    DefaultRollOffNote:DisableButton(true);
    DefaultRollOffNote:SetHeight(20);
    DefaultRollOffNote:SetFullWidth(true);
    DefaultRollOffNote:SetText(GL.Settings:get("MasterLooting.defaultRollOffNote", "/roll 100 for MS or /roll 99 for OS"));
    DefaultRollOffNote:SetLabel(string.format(
            "|cff%sSet a default note that's shown when rolling off items, pipes ( | ) are not allowed!|r",
            GL:classHexColor("rogue")
    ));
    DefaultRollOffNote:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
            or GL:strContains(value, "|")
        ) then
            GL:warning("Invalid note provided");
            GL.Settings:set("MasterLooting.defaultRollOffNote", "/roll 100 for MS or /roll 99 for OS")
        end

        GL.Settings:set("MasterLooting.defaultRollOffNote", value);
    end);
    Parent:AddChild(DefaultRollOffNote);

    Checkboxes = {
        {
            label = "Always show default note instead of item priority",
            description = "Gargul uses item priorities (if available) when rolling off items. Enabling this means you can use your custom default note instead",
            setting = "MasterLooting.alwaysUseDefaultNote",
            callback = function ()
                GL.MasterLooterUI:updateItemNote();
            end
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/MasterLooting.lua");