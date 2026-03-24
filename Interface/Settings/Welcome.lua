local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Data
local Constants = GL.Data.Constants;

local AceGUI = GL.AceGUI;

---@class WelcomeSettings
GL.Interface.Settings.Welcome = {
    description = "\n|c00FFF569Welcome to Gargul!|r\n\nNew? Click |c00A79EFFStart here|r below for a quick tour of GDKP, SoftRes, auto looting and more.\n\nEverything can be tested without being in a raid!",
};
local Welcome = GL.Interface.Settings.Welcome; ---@type WelcomeSettings

---@return nil
function Welcome:draw(Parent)
    local HorizontalSpacer;

    local StartHere = AceGUI:Create("Button");
    StartHere:SetText(L["Start here"]);
    StartHere:SetCallback("OnClick", function ()
        GL.Settings:close();
        GL.Commands:call("start");
    end);
    StartHere:SetRelativeWidth(.5);
    Parent:AddChild(StartHere);

    local OpenBonusFeatures = AceGUI:Create("Button");
    OpenBonusFeatures:SetText("Bonus Features");
    OpenBonusFeatures:SetCallback("OnClick", function ()
        GL.Settings:close();
        GL.Interface.BonusFeatures:open();
    end);
    OpenBonusFeatures:SetRelativeWidth(.5);
    Parent:AddChild(OpenBonusFeatures);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local DiscordLabel = AceGUI:Create("Label");
    DiscordLabel:SetText("Join us on discord!\n");
    DiscordLabel:SetFontObject(_G.GameFontNormal);
    DiscordLabel:SetFullWidth(true);
    Parent:AddChild(DiscordLabel);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(4);
    Parent:AddChild(HorizontalSpacer);
    
    local DiscordRowContainer = AceGUI:Create("SimpleGroup");
    DiscordRowContainer:SetLayout("FILL");
    DiscordRowContainer:SetFullWidth(true);
    DiscordRowContainer:SetHeight(28);
    Parent:AddChild(DiscordRowContainer);

    local DiscordRow = CreateFrame("Button", nil, DiscordRowContainer.frame);
    DiscordRow:SetAllPoints(DiscordRowContainer.frame);
    DiscordRow:EnableMouse(true);

    local HighlightTex = DiscordRow:CreateTexture(nil, "HIGHLIGHT");
    HighlightTex:SetAllPoints();
    HighlightTex:SetColorTexture(1, 1, 1, .06);

    local DiscordLogo = DiscordRow:CreateTexture(nil, "ARTWORK");
    DiscordLogo:SetSize(20, 20);
    DiscordLogo:SetPoint("LEFT", DiscordRow, "LEFT", 0, 0);
    DiscordLogo:SetTexture("Interface/AddOns/Gargul/Assets/Icons/discord");

    local DiscordURLText = GL.Interface:createFontString(DiscordRow, ("|c00%sdiscord.gg/D3mDhYPVzf|r"):format(Constants.addonHexColor));
    DiscordURLText:SetPoint("LEFT", DiscordLogo, "RIGHT", 8, 0);
    DiscordURLText:SetFont(1.4, "");

    DiscordRow:SetScript("OnClick", function ()
        GL.Interface.Dialogs.HyperlinkDialog:open({
            description = L["Join the Gargul community on Discord!"],
            hyperlink = "discord.gg/D3mDhYPVzf",
        });
    end);
end
