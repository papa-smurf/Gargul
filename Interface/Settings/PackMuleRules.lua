---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class PackMuleRulesSettings
GL.Interface.Settings.PackMuleRules = {
    description = "For group loot use: |c00f7922ePASS|r, |c00f7922eGREED|r, |c00f7922eNEED|r, |c00f7922eIGNORE|r\nNote: group loot rules only work on items that are tradeable after picking them up. |c00f7922eNEED|r by default only works when you have lead/assist (see /gl pm settings)!\n\nFor Master Looting use player names and placeholders:\n|c00f7922eSELF|r - send to yourself\n|c00f7922eRANDOM|r - send to random player\n|c00f7922eRR|r - round robin\n|c00f7922eDE|r - send to disenchanter (/gl sd [mydisenchanter])\n|c00f7922eIGNORE|r - prevent from being auto-looted\n\nList of players are also supported:\n|c00f7922ePlayer1,Player2,SELF|r - Items will be sent to a random person in this list.\n\nSend an item to the first player who's in the raid instead of random by adding an exclamation mark: |c00f7922e!Player1,!Player2,SELF|r",

    UIComponents = {
        Input = {
            SpecificItemRules = {},
        },
    },
};
local PackMuleRules = GL.Interface.Settings.PackMuleRules; ---@type PackMuleRulesSettings

---@return void
function PackMuleRules:draw(Parent)
    GL:debug("PackMuleSettings:draw");

    self.UIComponents.Input.SpecificItemRules = {};

    -- First we divide all existing PackMule rules in 3 sections:
    --      1 Rule that decides where items lower than quality X get sent
    --      1 Rule that decides where items higher than quality X get sent
    --      Multiple rules that decide where specific items go (based on name / ID / link)
    local LowerThanOrEqualToRule;
    local HigherThanOrEqualToRule;
    local SpecificItemRules = {};
    for _, Rule in pairs(GL.Settings:get("PackMule.Rules", {})) do
        if (Rule.item) then
            tinsert(SpecificItemRules, Rule);
        elseif (Rule.operator) then
            if (Rule.operator == "<=") then
                LowerThanOrEqualToRule = Rule;
            elseif (Rule.operator == ">=") then
                HigherThanOrEqualToRule = Rule;
            end
        end
    end

    --[[ ITEM QUALITY RULES ]]
    local Heading = GL.AceGUI:Create("Heading");
    Heading:SetFullWidth(true);
    Heading:SetText("Item quality rules");
    Parent:AddChild(Heading);

    Overview:drawSpacer(Parent, 20, 1);

    local SectionDescription = GL.AceGUI:Create("Label");
    SectionDescription:SetText("Example to send to yourself when loot master and greed when group looting:\n|c00a79effSELF GREED|r");
    SectionDescription:SetFontObject(_G["GameFontNormal"]);
    SectionDescription:SetFullWidth(true);
    Parent:AddChild(SectionDescription);

    self:drawLowerThanQualityRule(Parent, LowerThanOrEqualToRule);
    Overview:drawSpacer(Parent, 1, 5);
    self:drawHigherThanQualityRule(Parent, HigherThanOrEqualToRule);

    Overview:drawSpacer(Parent, 1, 10);

    --[[ SPECIFIC ITEM RULES ]]
    Heading = GL.AceGUI:Create("Heading");
    Heading:SetFullWidth(true);
    Heading:SetText("Specific item rules");
    Parent:AddChild(Heading);

    Overview:drawSpacer(Parent, 20, 1);

    SectionDescription = GL.AceGUI:Create("Label");
    SectionDescription:SetText("You can add item IDs, item links (shift click or drag/drop), item names and name wilcards: |c00f7922e*ushroom|r, |c00f7922emushroo*|r and |c00f7922e*ushroo*|r will all match an item named |c00f7922emushroom|r.");
    SectionDescription:SetFontObject(_G["GameFontNormal"]);
    SectionDescription:SetFullWidth(true);
    Parent:AddChild(SectionDescription);

    for _, Rule in pairs(SpecificItemRules) do
        self:drawSpecifItemRule(Parent, Rule);
    end

    -- Make sure to draw additional item rules in case we have less than 30
    for _ = #SpecificItemRules, 75 do
        self:drawSpecifItemRule(Parent);
    end
end

function PackMuleRules:drawSpecifItemRule(Frame, Rule)
    GL:debug("PackMuleRules:drawSpecifItemRule");

    Rule = Rule or {
        item = "",
        target = "",
    };

    local Row = GL.AceGUI:Create("SimpleGroup");
    Row:SetLayout("Flow");
    Row:SetFullWidth(true);
    Row:SetHeight(30);
    Frame:AddChild(Row);

    Overview:drawSpacer(Row, 20, 1);

    -- LABEL: Send loot of quality lower than
    local beforeItemLabel = GL.AceGUI:Create("Label");
    beforeItemLabel:SetText("Send");
    beforeItemLabel:SetHeight(20);
    beforeItemLabel:SetWidth(46);
    Row:AddChild(beforeItemLabel);

    -- ITEM NAME
    local ItemName = GL.AceGUI:Create("EditBox");
    ItemName:DisableButton(true);
    ItemName:SetHeight(25);
    ItemName:SetWidth(150);
    ItemName:SetText(Rule.item);
    Row:AddChild(ItemName);

    -- Increase space between input and next label ("to")
    Overview:drawSpacer(Row, 8, 1);

    -- LABEL: to
    local afterItemLabel = GL.AceGUI:Create("Label");
    afterItemLabel:SetText("to");
    afterItemLabel:SetHeight(20);
    afterItemLabel:SetWidth(16);
    Row:AddChild(afterItemLabel);

    local ItemTarget = GL.AceGUI:Create("EditBox");
    ItemTarget:DisableButton(true);
    ItemTarget:SetHeight(25);
    ItemTarget:SetWidth(244);
    ItemTarget:SetText(Rule.target);
    Row:AddChild(ItemTarget);

    tinsert(self.UIComponents.Input.SpecificItemRules, {
        Name = ItemName,
        Target = ItemTarget
    });
end

--- Store the custom rules when we close the settings (or change sections)
---
---@return void
function PackMuleRules:onClose()
    GL:debug("PackMuleRules:onClose");

    local sanitizeTarget = function(target)
        target = target:gsub(",", " ");
        target = target:gsub("  ", " ");

        return target;
    end;

    -- Lower/higher than quality rules
    local lowerThanRuleQuality = self.UIComponents.Input.LowerThanOrEqualToRuleQuality:GetValue();
    local lowerThanRuleTarget = tostring(self.UIComponents.Input.LowerThanOrEqualToRuleTarget:GetText());
    local higherThanRuleQuality = self.UIComponents.Input.HigherThanOrEqualToRuleQuality:GetValue();
    local higherThanRuleTarget = tostring(self.UIComponents.Input.HigherThanOrEqualToRuleTarget:GetText());

    -- Reset (clear) all the current PackMule rules
    GL.PackMule:resetRules();

    -- Add the item-specific rules first
    for _, SpecificItemRule in pairs(self.UIComponents.Input.SpecificItemRules) do
        local name = tostring(SpecificItemRule.Name:GetText());
        local target = tostring(SpecificItemRule.Target:GetText());

        GL.PackMule:addRule({
            item = name,
            target = sanitizeTarget(target),
        });
    end

    -- Add the quality lower than X rule
    if (type(lowerThanRuleQuality) ~= "nil"
        and lowerThanRuleTarget
        and lowerThanRuleTarget ~= ""
    ) then
        GL.PackMule:addRule({
            quality = lowerThanRuleQuality,
            operator = "<=",
            target = sanitizeTarget(lowerThanRuleTarget),
        });
    end

    -- Add the quality higher than X rule
    if (type(higherThanRuleQuality) ~= "nil"
        and higherThanRuleTarget
        and higherThanRuleTarget ~= ""
    ) then
        GL.PackMule:addRule({
            quality = higherThanRuleQuality,
            operator = ">=",
            target = sanitizeTarget(higherThanRuleTarget),
        });
    end
end

--- Draw the "lower than X quality" rule
---
---@param Frame table
---@param Rule table
---@return void
function PackMuleRules:drawLowerThanQualityRule(Frame, Rule)
    GL:debug("PackMuleRules:drawLowerThanQualityRule");

    Rule = Rule or {
        quality = nil,
        target = "",
    }

    local Row = GL.AceGUI:Create("SimpleGroup");
    Row:SetLayout("Flow");
    Row:SetFullWidth(true);
    Row:SetHeight(30);
    Frame:AddChild(Row);

    Overview:drawSpacer(Row, 20, 1);

    -- LABEL: Send loot of quality lower than
    local beforeLowerThanRuleLabel = GL.AceGUI:Create("Label");
    beforeLowerThanRuleLabel:SetText("Send");
    beforeLowerThanRuleLabel:SetHeight(20);
    beforeLowerThanRuleLabel:SetWidth(34);
    Row:AddChild(beforeLowerThanRuleLabel);

    local LowerThanList = {};
    local lowestValidItemQuality = GL.isEra and 0 or 2; -- Era supports quality 0 and up, in retail it's green +
    local highestValidItemQuality = 4;

    local ItemQualityColors = GL.Data.Constants.ItemQualityColors;
    for i = lowestValidItemQuality, highestValidItemQuality do
        LowerThanList[i] = string.format("|c00%s%s|r", ItemQualityColors[i].hex, ItemQualityColors[i].description);
    end

    -- DROPDOWN
    local LowerThanOrEqualToQuality = GL.AceGUI:Create("Dropdown");
    LowerThanOrEqualToQuality:SetHeight(20);
    LowerThanOrEqualToQuality:SetWidth(120);
    LowerThanOrEqualToQuality:SetList(LowerThanList);
    LowerThanOrEqualToQuality:SetValue(Rule.quality);
    Row:AddChild(LowerThanOrEqualToQuality);
    self.UIComponents.Input.LowerThanOrEqualToRuleQuality = LowerThanOrEqualToQuality;

    -- Increase space between dropdown and next label ("to")
    Overview:drawSpacer(Row, 8, 1);

    -- LABEL: to
    local afterLowerThanRuleLabel = GL.AceGUI:Create("Label");
    afterLowerThanRuleLabel:SetText("|c00f7922eand lower|r to");
    afterLowerThanRuleLabel:SetHeight(20);
    afterLowerThanRuleLabel:SetWidth(72);
    Row:AddChild(afterLowerThanRuleLabel);

    local LowerThanRuleTarget = GL.AceGUI:Create("EditBox");
    LowerThanRuleTarget:DisableButton(true);
    LowerThanRuleTarget:SetHeight(25);
    LowerThanRuleTarget:SetWidth(230);
    LowerThanRuleTarget:SetText(Rule.target);
    Row:AddChild(LowerThanRuleTarget);
    self.UIComponents.Input.LowerThanOrEqualToRuleTarget = LowerThanRuleTarget;
end

function PackMuleRules:drawHigherThanQualityRule(Frame, Rule)
    GL:debug("PackMuleRules:drawHigherThanQualityRule");

    Rule = Rule or {
        quality = nil,
        target = "",
    }

    local Row = GL.AceGUI:Create("SimpleGroup");
    Row:SetLayout("Flow");
    Row:SetFullWidth(true);
    Row:SetHeight(40);
    Frame:AddChild(Row);

    Overview:drawSpacer(Row, 20, 1);

    -- LABEL: Send loot of quality lower than
    local beforeHigherThanRuleLabel = GL.AceGUI:Create("Label");
    beforeHigherThanRuleLabel:SetText("Send");
    beforeHigherThanRuleLabel:SetHeight(20);
    beforeHigherThanRuleLabel:SetWidth(34);
    Row:AddChild(beforeHigherThanRuleLabel);

    local HigherThanList = {};
    local lowestValidItemQuality = GL.isEra and 0 or 2; -- Era supports quality 0 and up, in retail it's green +
    local highestValidItemQuality = 4;

    local ItemQualityColors = GL.Data.Constants.ItemQualityColors;
    for i = lowestValidItemQuality, highestValidItemQuality do
        HigherThanList[i] = string.format("|c00%s%s|r", ItemQualityColors[i].hex, ItemQualityColors[i].description);
    end

    -- DROPDOWN
    local HigherThanOrEqualToRuleQuality = GL.AceGUI:Create("Dropdown");
    HigherThanOrEqualToRuleQuality:SetHeight(20);
    HigherThanOrEqualToRuleQuality:SetWidth(120);
    HigherThanOrEqualToRuleQuality:SetList(HigherThanList);
    HigherThanOrEqualToRuleQuality:SetValue(Rule.quality);
    Row:AddChild(HigherThanOrEqualToRuleQuality);
    self.UIComponents.Input.HigherThanOrEqualToRuleQuality = HigherThanOrEqualToRuleQuality;

    -- Increase space between dropdown and next label ("to")
    Overview:drawSpacer(Row, 8, 1);

    -- LABEL: to
    local afterHigherThanRuleLabel = GL.AceGUI:Create("Label");
    afterHigherThanRuleLabel:SetText("|c00f7922eand higher|r to");
    afterHigherThanRuleLabel:SetHeight(20);
    afterHigherThanRuleLabel:SetWidth(72);
    Row:AddChild(afterHigherThanRuleLabel);

    local HigherThanOrEqualToRuleTarget = GL.AceGUI:Create("EditBox");
    HigherThanOrEqualToRuleTarget:DisableButton(true);
    HigherThanOrEqualToRuleTarget:SetHeight(25);
    HigherThanOrEqualToRuleTarget:SetWidth(230);
    HigherThanOrEqualToRuleTarget:SetText(Rule.target);
    Row:AddChild(HigherThanOrEqualToRuleTarget);
    self.UIComponents.Input.HigherThanOrEqualToRuleTarget = HigherThanOrEqualToRuleTarget;
end

GL:debug("Interface/Settings/PackMuleRules.lua");