---@type GL
local _, GL = ...;

---@type Data
local Constants = GL.Data.Constants;

local AceGUI = GL.AceGUI;

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

    local MoreInfoLabel = AceGUI:Create("Label");
    MoreInfoLabel:SetText("Join our Discord for support and getting involved!\n");
    MoreInfoLabel:SetFontObject(_G["GameFontNormal"]);
    MoreInfoLabel:SetFullWidth(true);
    Parent:AddChild(MoreInfoLabel);

    local DiscordURL = AceGUI:Create("EditBox");
    DiscordURL:DisableButton(true);
    DiscordURL:SetHeight(20);
    DiscordURL:SetFullWidth(true);
    DiscordURL:SetText("https://discord.gg/D3mDhYPVzf");
    Parent:AddChild(DiscordURL);

    local HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local WikiLabel = AceGUI:Create("Label");
    WikiLabel:SetText("Gargul's wiki page\n");
    WikiLabel:SetFontObject(_G["GameFontNormal"]);
    WikiLabel:SetFullWidth(true);
    Parent:AddChild(WikiLabel);

    local WikiURL = AceGUI:Create("EditBox");
    WikiURL:DisableButton(true);
    WikiURL:SetHeight(20);
    WikiURL:SetFullWidth(true);
    WikiURL:SetText("https://github.com/papa-smurf/Gargul/wiki");
    Parent:AddChild(WikiURL);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local OpenSoftRes = AceGUI:Create("Button");
    OpenSoftRes:SetText("SoftRes");
    OpenSoftRes:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("softreserves");
    end);
    OpenSoftRes:SetWidth(172);
    Parent:AddChild(OpenSoftRes);

    local OpenTMB = AceGUI:Create("Button");
    OpenTMB:SetText("TMB or DFT");
    OpenTMB:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("tmb");
    end);
    OpenTMB:SetWidth(172);
    Parent:AddChild(OpenTMB);

    local OpenPackMule = AceGUI:Create("Button");
    OpenPackMule:SetText("Autolooting");
    OpenPackMule:SetCallback("OnClick", function()
        GL.Settings:draw("PackMule");
    end);
    OpenPackMule:SetWidth(172);
    Parent:AddChild(OpenPackMule);

    --[[ CONTRIBUTORS ]]

    local Spacer = AceGUI:Create("Label");
    Spacer:SetText("\n\n");
    Spacer:SetFontObject(_G["GameFontNormal"]);
    Spacer:SetFullWidth(true);
    Parent:AddChild(Spacer);

    local Patreon = AceGUI:Create("Icon");
    Patreon:SetWidth(20);
    Patreon:SetHeight(20);
    Patreon:SetImageSize(16, 16);
    Patreon:SetImage("Interface\\AddOns\\Gargul\\Assets\\Icons\\patreon-small");
    Parent:AddChild(Patreon);

    local Colors = {
        contributors = "FFFFFF",
        common = Constants.addonHexColor,
        uncommon = select(4, GetItemQualityColor(2)),
        rare = select(4, GetItemQualityColor(3)),
        epic = select(4, GetItemQualityColor(4)),
        legendary = select(4, GetItemQualityColor(5)),
    };

    --[[ PATRONS ]]

    local PatronNames = {};
    for _, name in pairs(Constants.Vips.Legendary or {}) do
        tinsert(PatronNames, string.format("|c%s%s|r", Colors.legendary, name));
    end

    for _, name in pairs(Constants.Vips.Epic or {}) do
        tinsert(PatronNames, string.format("|c%s%s|r", Colors.epic, name));
    end

    for _, name in pairs(Constants.Vips.Rare or {}) do
        tinsert(PatronNames, string.format("|c%s%s|r", Colors.rare, name));
    end

    for _, name in pairs(Constants.Vips.Uncommon or {}) do
        tinsert(PatronNames, string.format("|c%s%s|r", Colors.uncommon, name));
    end

    if (not GL:empty(PatronNames)) then
        local PatronLabel = AceGUI:Create("Label");
        PatronLabel:SetText(" Patrons");
        PatronLabel:SetFontObject(_G["GameFontNormal"]);
        PatronLabel:SetWidth(100);
        Parent:AddChild(PatronLabel);

        local Patrons = AceGUI:Create("Label");
        Patrons:SetText(table.concat(PatronNames, ", "));
        Patrons:SetFontObject(_G["GameFontNormal"]);
        Patrons:SetFullWidth(true);
        Parent:AddChild(Patrons);
    end

    local ContributorNames = {};
    for _, name in pairs(Constants.Vips.Contributors or {}) do
        tinsert(ContributorNames, string.format("|c00%s%s|r", Colors.common, name));
    end

    if (not GL:empty(ContributorNames)) then
        local ContributorLabel = AceGUI:Create("Label");
        ContributorLabel:SetText("\n\nContributors");
        ContributorLabel:SetFontObject(_G["GameFontSmall"]);
        ContributorLabel:SetWidth(100);
        Parent:AddChild(ContributorLabel);

        local Contributors = AceGUI:Create("Label");
        Contributors:SetText(table.concat(ContributorNames, ", "));
        Contributors:SetFontObject(_G["GameFontSmall"]);
        Contributors:SetFullWidth(true);
        Parent:AddChild(Contributors);
    end

    local Title = AceGUI:Create("Label");
    Title:SetText("\n\n|c00ff424dGargul would not be here without these awesome people, thank you! <3|r\n");
    Title:SetFontObject(_G["GameFontNormal"]);
    Title:SetFullWidth(true);
    Parent:AddChild(Title);
end

GL:debug("Interface/Settings/Welcome.lua");