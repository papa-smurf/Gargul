---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class PackMuleSettings
GL.Interface.Settings.PackMule = {
    description = "PackMule can auto loot items to any player in your raid. When looting you can hold the shift button to temporarily disable PackMule. |c00a79effGROUP LOOT SETTINGS ONLY AFFECT YOURSELF!|r",
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
            description = "The PackMule rules will be applied if you're master looting",
            setting = "PackMule.enabledForMasterLoot",
        },
        {
            label = "Enable for Group Loot",
            description = "The PackMule (NEED|GREED|PASS|IGNORE) rules apply in group loot",
            setting = "PackMule.enabledForGroupLoot",
        },
        {
            label = "Auto confirm loot when solo",
            description = "Auto confirm all loot when not in a group, bypassing the 'looting this will bind it to you message'",
            setting = "PackMule.autoConfirmSolo",
        },
        {
            label = "Auto confirm loot when in group",
            description = "Auto confirm all loot when group looting, bypassing the 'looting this will bind it to you message'. Use with caution!",
            setting = "PackMule.autoConfirmGroup",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/PackMule.lua");