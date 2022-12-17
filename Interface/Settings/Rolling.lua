---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class RollSettings
GL.Interface.Settings.Rolling = {
    description = string.format("When a master looter who also uses Gargul announces that you can roll on an item, you are presented with a small window that allows you to MS/OS roll or pass on an item. You can move this window around and position it wherever you'd like or close it by clicking the pass button or right-clicking the window (closing it this way is not permanent).\n\nYou can start a roll by %s an item in your inventory, an enemy's loot window, or the trade duration bars.", GL.Settings:get("ShortcutKeys.rollOffOrAuction")),
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Rolling-Items",
};
local Rolling = GL.Interface.Settings.Rolling; ---@type RollSettings

---@return void
function Rolling:draw(Parent)
    GL:debug("RollSettings:draw");

    local Checkboxes = {
        {
            label = "Roll Window",
            description = "Show the roll window with timer roll buttons whenever the master looter starts a roll. This only works if the master looter uses Gargul!",
            setting = "Rolling.showRollOffWindow",
        },
        {
            label = "Close after roll",
            description = "Automatically close the window after rolling",
            setting = "Rolling.closeAfterRoll",
        },
        {
            label = "Don't show on unusable items",
            description = "Don't show the window if you can't use the item (lvl / class restriction etc.)",
            setting = "Rolling.dontShowOnUnusableItems",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local Scale = GL.AceGUI:Create("Slider");
    Scale:SetLabel("Magnification scale of the roller window");
    Scale.label:SetTextColor(1, .95686, .40784);
    Scale:SetFullWidth(true);
    Scale:SetValue(GL.Settings:get("Rolling.scale", 35));
    Scale:SetSliderValues(.8, 1.8, .1);
    Scale:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (value) then
            GL.Settings:set("Rolling.scale", value);

            -- Change the existing roll window if it's active!
            if (GL.RollerUI.Window
                and type(GL.RollerUI.Window.SetScale == "function")
            ) then
                GL.RollerUI.Window:SetScale(value);
            end
        end
    end);
    Parent:AddChild(Scale);
end

GL:debug("Interface/Settings/Rolling.lua");