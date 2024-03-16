---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class PackMuleSettings
GL.Interface.Settings.PackMule = {
    description = "PackMule can auto loot items to any player in your raid. When looting you can hold the shift button to temporarily disable PackMule. |c00A79EFFGROUP LOOT SETTINGS ONLY AFFECT YOURSELF!|r",
};
local PackMule = GL.Interface.Settings.PackMule; ---@type PackMuleSettings

---@return void
function PackMule:draw(Parent)
    GL:debug("PackMuleSettings:draw");

    local ItemRules = GL.AceGUI:Create("Button");
    ItemRules:SetText("Item Rules");
    ItemRules:SetCallback("OnClick", function()
        GL.Settings:draw("PackMuleRules");
    end);
    Parent:AddChild(ItemRules);

    local IgnoredItems = GL.AceGUI:Create("Button");
    IgnoredItems:SetText("Ignored Items");
    IgnoredItems:SetCallback("OnClick", function()
        GL.Settings:draw("PackMuleIgnores");
    end);
    Parent:AddChild(IgnoredItems);

    Overview:drawSpacer(Parent, nil, 10);

    local Checkboxes = {
        {
            label = "Enable for Master Loot",
            setting = "PackMule.enabledForMasterLoot",
        },
        {
            label = "Enable for Group Loot",
            setting = "PackMule.enabledForGroupLoot",
            description = "Note: by default NEED only works when you have lead/assist (see setting below)",
        },
        {
            label = "Also NEED when not lead/assist",
            description = "NEED on group loot by default only works when you have lead/assist. This setting overrides that, use with caution!",
            setting = "PackMule.needWithoutAssist",
        },
        {
            label = "Disable for Group Loot when leaving group",
            setting = "PackMule.autoDisableForGroupLoot",
        },
        {
            label = "Auto confirm loot when solo",
            description = "Bypass the 'looting this will bind it to you message' when solo",
            setting = "PackMule.autoConfirmSolo",
        },
        {
            label = "Auto confirm loot when in group",
            description = "Bypass the 'looting this will bind it to you message' when in group",
            setting = "PackMule.autoConfirmGroup",
        },
        {
            label = "Auto loot gold",
            setting = "PackMule.lootGold",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/PackMule.lua");