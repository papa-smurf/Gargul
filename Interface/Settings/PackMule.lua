---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class PackMuleSettings
GL.Interface.Settings.PackMule = {
    description = "PackMule can auto loot items to any player in your raid.\n\nWhen looting you can hold the shift button to temporarily disable PackMule, allowing you to loot the old fashioned way! PackMule ignores legendaries, quest items and recipes.\n\nIf you want to see what else is ignored (by default) then click the |c00f7922eIgnored Items|r section on the left. To set up your own rules use the |c00f7922eItem Rules|r section.",
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
            label = "Enable",
            description = "The PackMule rules will only be applied if this box is checked",
            setting = "PackMule.enabled",
        },
        {
            label = "Persist after zone switch",
            description = "PackMule is disabled by default after you change zones (e.g. you enter/leave an instance). Checking this ensures PackMule stays on instead",
            setting = "PackMule.persistsAfterZoneChange",
        },
        {
            label = "Persist after reload",
            description = "PackMule is disabled by default after you reload (e.g. reload UI or restart game). Checking this ensures PackMule stays on instead",
            setting = "PackMule.persistsAfterReload",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/PackMule.lua");