---@type GL
local _, GL = ...;

---@type SettingsOverview
local Overview = GL.Interface.Settings.Overview;

---@class GeneralSettings
GL.Interface.Settings.General = {};

---@type GeneralSettings
local General = GL.Interface.Settings.General;

---@return void
function General:draw(Parent)
    GL:debug("GeneralSettings:draw");

    Overview:drawCheckboxes({
        {
            label = "Welcome message",
            description = "Show a message when booting Gargul",
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
            label = "Show changelog",
            description = "Enable or disable the changelog which displays important update details after updating Gargul",
            setting = "changeLog",
        },
        {
            label = "Show update alert",
            description = "Show an alert when there's an update. We believe in \"release early, release often\", it allows us to respond to bugs more quickly and limits the severity of issues",
            setting = "showUpdateAlert",
        },
        {
            label = "No messages",
            description = "This will prevent Gargul from posting any messages, ANYWHERE",
            setting = "noMessages",
        },
        {
            label = "No sounds",
            setting = "noSounds",
        },
    }, Parent);

    local Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local MinimumQualityLabel = GL.AceGUI:Create("Label");
    MinimumQualityLabel:SetColor(1, .95686, .40784);
    MinimumQualityLabel:SetText("On which channel should Gargul output its sounds (default SFX)");
    MinimumQualityLabel:SetHeight(20);
    MinimumQualityLabel:SetFullWidth(true);
    Parent:AddChild(MinimumQualityLabel);

    local SoundChannels = {
        Master = "Master",
        Music = "Music",
        SFX = "SFX",
        Ambience = "Ambience",
        Dialog = "Dialog",
    };

    local SoundChannelDropdown = GL.AceGUI:Create("Dropdown");
    SoundChannelDropdown:SetValue(GL.Settings:get("soundChannel"));
    SoundChannelDropdown:SetList(SoundChannels);
    SoundChannelDropdown:SetText(GL.Settings:get("soundChannel"));
    SoundChannelDropdown:SetWidth(250);
    SoundChannelDropdown:SetCallback("OnValueChanged", function()
        local channel = SoundChannelDropdown:GetValue();
        GL.Settings:set("soundChannel", channel);
    end);
    Parent:AddChild(SoundChannelDropdown);
end

GL:debug("Interface/Settings/General.lua");