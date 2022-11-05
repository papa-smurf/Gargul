---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class WelcomeSettings
GL.Interface.Settings.Welcome = {
    description = string.format(
            "Welcome! Almost all of Gargul's features can be tested when not in a group, so go check them out\n\nRoll: |c00a79eff%s|r. Award: |c00a79eff%s|r. Disenchant: |c00a79eff%s|r\n|c00f7922eNote: hotkeys are disabled when the AH, mailbox, shop or bank are active!|r",
            GL.Settings:get("ShortcutKeys.rollOff"),
            GL.Settings:get("ShortcutKeys.award"),
            GL.Settings:get("ShortcutKeys.disenchant")
    ),
};
local Welcome = GL.Interface.Settings.Welcome; ---@type WelcomeSettings

---@return void
function Welcome:draw(Parent)
    GL:debug("WelcomeSettings:draw");

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

    local WikiLabel = GL.AceGUI:Create("Label");
    WikiLabel:SetText("Gargul's wiki page\n");
    WikiLabel:SetFontObject(_G["GameFontNormal"]);
    WikiLabel:SetFullWidth(true);
    Parent:AddChild(WikiLabel);

    local WikiURL = GL.AceGUI:Create("EditBox");
    WikiURL:DisableButton(true);
    WikiURL:SetHeight(20);
    WikiURL:SetFullWidth(true);
    WikiURL:SetText("https://github.com/papa-smurf/Gargul/wiki");
    Parent:AddChild(WikiURL);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
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
    OpenSoftRes:SetWidth(172);
    Parent:AddChild(OpenSoftRes);

    local OpenTMB = GL.AceGUI:Create("Button");
    OpenTMB:SetText("TMB or DFT");
    OpenTMB:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("tmb");
    end);
    OpenTMB:SetWidth(172);
    Parent:AddChild(OpenTMB);

    local OpenPackMule = GL.AceGUI:Create("Button");
    OpenPackMule:SetText("Autolooting");
    OpenPackMule:SetCallback("OnClick", function()
        GL.Settings:draw("PackMule");
    end);
    OpenPackMule:SetWidth(172);
    Parent:AddChild(OpenPackMule);
end

GL:debug("Interface/Settings/Welcome.lua");