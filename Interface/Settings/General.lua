---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class GeneralSettings
GL.Interface.Settings.General = {};
local General = GL.Interface.Settings.General; ---@type GeneralSettings

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
        {
            label = "Experimental: addon usage",
            description = "Show add-on memory usage. Warning: may cause FPS drop!",
            setting = "profilerEnabled",
            callback = function ()
                if (GL.Settings:get("profilerEnabled")) then
                    GL.Profiler:draw();
                else
                    GL.Profiler:close();
                end
            end,
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