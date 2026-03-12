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

    --[[ CONTRIBUTORS ]]

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
        tinsert(PatronNames, ("|c%s%s|r"):format(Colors.legendary, name));
    end

    for _, name in pairs(Constants.Vips.Epic or {}) do
        tinsert(PatronNames, ("|c%s%s|r"):format(Colors.epic, name));
    end

    for _, name in pairs(Constants.Vips.Rare or {}) do
        tinsert(PatronNames, ("|c%s%s|r"):format(Colors.rare, name));
    end

    for _, name in pairs(Constants.Vips.Uncommon or {}) do
        tinsert(PatronNames, ("|c%s%s|r"):format(Colors.uncommon, name));
    end

    if (not GL:empty(PatronNames)) then
        local patronString = "";
        local lastColor = "";
        local first = true;
        for _, patron in pairs (PatronNames) do
            local color = strsub(patron, 1, 10);

            if (not first and color ~= lastColor) then
                patronString = ("%s%s%s"):format(
                    patronString,
                    "\n\n",
                    patron
                );
            elseif (not first) then
                patronString = ("%s, %s"):format(
                    patronString,
                    patron
                );
            else
                patronString = patron;
            end

            first = false;
            lastColor = color;
        end

        local PatronLabel = AceGUI:Create("Label");
        PatronLabel:SetText(" Patrons");
        PatronLabel:SetFontObject(_G.GameFontNormal);
        PatronLabel:SetWidth(100);
        Parent:AddChild(PatronLabel);

        local Patrons = AceGUI:Create("Label");
        Patrons:SetText(patronString);
        Patrons:SetFontObject(_G.GameFontNormal);
        Patrons:SetFullWidth(true);
        Parent:AddChild(Patrons);
    end

    local ContributorNames = {};
    for _, name in pairs(Constants.Vips.Contributors or {}) do
        tinsert(ContributorNames, ("|c00%s%s|r"):format(Colors.common, name));
    end

    if (not GL:empty(ContributorNames)) then
        local ContributorLabel = AceGUI:Create("Label");
        ContributorLabel:SetText("\n\nContributors");
        ContributorLabel:SetFontObject(_G.GameFontSmall);
        ContributorLabel:SetWidth(100);
        Parent:AddChild(ContributorLabel);

        local Contributors = AceGUI:Create("Label");
        Contributors:SetText(table.concat(ContributorNames, ", "));
        Contributors:SetFontObject(_G.GameFontSmall);
        Contributors:SetFullWidth(true);
        Parent:AddChild(Contributors);
    end

    local Title = AceGUI:Create("Label");
    Title:SetText("\n\n|c00ff424dGargul would not be here without these awesome people, thank you! <3|r\n\n");
    Title:SetFontObject(_G.GameFontNormal);
    Title:SetFullWidth(true);
    Parent:AddChild(Title);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local MoreInfoLabel = AceGUI:Create("Label");
    MoreInfoLabel:SetText("Can't find something? Join our Discord!\n");
    MoreInfoLabel:SetFontObject(_G.GameFontNormal);
    MoreInfoLabel:SetFullWidth(true);
    Parent:AddChild(MoreInfoLabel);

    local DiscordURL = AceGUI:Create("EditBox");
    DiscordURL:DisableButton(true);
    DiscordURL:SetHeight(20);
    DiscordURL:SetFullWidth(true);
    DiscordURL:SetText("https://discord.gg/D3mDhYPVzf");
    Parent:AddChild(DiscordURL);
end
