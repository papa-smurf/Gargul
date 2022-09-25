---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class GeneralSettings
GL.Interface.Settings.General = {
    description = "Gargul adds quality of life features for raiders, master looters and raid leaders. It can be used with SoftRes (softres.it) and TMB (thatsmybis.com) to create a hassle free raiding experience. |c00f7922eMost of Gargul's features can be tested even when not in a group, so go check them out!|r",
};
local General = GL.Interface.Settings.General; ---@type GeneralSettings

---@return void
function General:draw(Parent)
    GL:debug("GeneralSettings:draw");

    local MoreInfoLabel = GL.AceGUI:Create("Label");
    MoreInfoLabel:SetText("Join our Discord for support and getting involved!\n");
    MoreInfoLabel:SetFontObject(_G["GameFontNormal"]);
    MoreInfoLabel:SetFullWidth(true);
    Parent:AddChild(MoreInfoLabel);

    local DiscordURL = GL.AceGUI:Create("EditBox");
    DiscordURL:DisableButton(true);
    DiscordURL:SetHeight(20);
    DiscordURL:SetFullWidth(true);
    DiscordURL:SetText("https://discord.gg/D3mDhYPVzf");
    Parent:AddChild(DiscordURL);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local OpenSoftRes = GL.AceGUI:Create("Button");
    OpenSoftRes:SetText("SoftRes");
    OpenSoftRes:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("softreserves");
    end);
    OpenSoftRes:SetWidth(176);
    Parent:AddChild(OpenSoftRes);

    local OpenTMB = GL.AceGUI:Create("Button");
    OpenTMB:SetText("TMB or DFT");
    OpenTMB:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("tmb");
    end);
    OpenTMB:SetWidth(176);
    Parent:AddChild(OpenTMB);

    local OpenPackMule = GL.AceGUI:Create("Button");
    OpenPackMule:SetText("Autolooting");
    OpenPackMule:SetCallback("OnClick", function()
        GL.Settings:draw("PackMule");
    end);
    OpenPackMule:SetWidth(176);
    Parent:AddChild(OpenPackMule);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
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