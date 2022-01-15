---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class RollSettings
GL.Interface.Settings.Rolling = {
    description = "When a master looter who also uses Gargul announces that you can roll on an item you are presented with a small window that allows you to MS/OS roll or pass on an item. You can move this window around and position it wherever you'd like or close it by clicking the pass button or right-clicking the window (closing it this way is not permanent).\n\nIf you're the master looter you can announce a roll either by using /gl rolloff or even better: by alt-clicking an item in your inventory or a enemy's loot window!\n\nIf this doesn't work for you then it's mostly likely an add-on interfering with the Blizzard UI (ElvUI and xLoot are confirmed culprits for example).\n\nThe OS roll slider below is a master looter setting, meaning that whatever value the master looter sets this to goes for everyone in the raid! NB: If you set the slider to 0 then that means you don't support OS rolls.",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Rolling-Items",
};
local Rolling = GL.Interface.Settings.Rolling; ---@type RollSettings

---@return void
function Rolling:draw(Parent)
    GL:debug("RollSettings:draw");

    local Checkboxes = {
        {
            label = "Enable",
            description = "Checking this will make sure that you see the roll window with timer and roll/pass button whenever the master looter starts a roll. This only works if the master looter uses Gargul!",
            setting = "Rolling.showRollOffWindow",
        },
        {
            label = "Close after roll",
            description = "Checking this makes sure that the roll window is automatically closed after roll",
            setting = "Rolling.closeAfterRoll",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);
end

GL:debug("Interface/Settings/Rolling.lua");