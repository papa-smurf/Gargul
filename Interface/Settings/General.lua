---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class GeneralSettings
GL.Interface.Settings.General = {
    description = "Gargul is a loot add-on that adds quality of life features for raiders, master looters and raid leaders. Gargul can be used together with SoftRes (softres.it) and TMB (thatsmybis.com) to create a hassle free raiding experience.\n\nCheck the various sections on the left-hand side of this window or visit our Wiki/Discord to get started!",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki",
};
local General = GL.Interface.Settings.General; ---@type GeneralSettings

---@return void
function General:draw(Parent)
    GL:debug("GeneralSettings:draw");

    local MoreInfoLabel = GL.AceGUI:Create("Label");
    MoreInfoLabel:SetText("For personal support or getting involved be sure to check out our Discord as well:\n");
    MoreInfoLabel:SetFontObject(_G["GameFontNormal"]);
    MoreInfoLabel:SetFullWidth(true);
    Parent:AddChild(MoreInfoLabel);

    local WikiUrlBox = GL.AceGUI:Create("EditBox");
    WikiUrlBox:DisableButton(true);
    WikiUrlBox:SetHeight(20);
    WikiUrlBox:SetFullWidth(true);
    WikiUrlBox:SetText("https://discord.gg/D3mDhYPVzf");
    Parent:AddChild(WikiUrlBox);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local Checkboxes = {
        {
            label = "Welcome message",
            setting = "welcomeMessage",
        },
        {
            label = "Minimap Icon",
            setting = "showMinimapButton",
            callback = function()
                GL.MinimapButton:drawOrHide();
            end,
        },
        {
            label = "No sounds",
            setting = "noSounds",
        },
        {
            label = "No messages",
            setting = "noMessages",
        },
        {
            label = "Show changelog",
            description = "Enable or disable the changelog which displays important update details after updating Gargul",
            setting = "changeLog",
        },
        {
            label = "Experimental: debug mode",
            description = "Enable debug mode, showing debug info in your chatbox. This is only meant for developers actively working on the Gargul add-on",
            setting = "debugModeEnabled",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/General.lua");