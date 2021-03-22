--[[
    This class lets the master looter appoint "pack mules"
    The pack mules (player) will automatically receive all items
    that their eligible for according to the rules as set up by the ML
]]
local _, App = ...;

App.PackMuleUI = App.PackMuleUI or {
    setupWindowIsActive = false,

    UIComponents = {
        Input = {
            SpecificItemRules = {},
        },
    },
};

local Utils = App.Utils;
local AceGUI = App.Ace.GUI;
local Settings = App.Settings;
local PackMuleUI = App.PackMuleUI;

function PackMuleUI:drawSetupWindow()
    Utils:debug("PackMuleUI:drawSetupWindow");

    -- Check to make sure the setup window isn't active already
    if (self.setupWindowIsActive) then
        return;
    else
        self.setupWindowIsActive = true;
    end

    self.UIComponents.Input = {
        SpecificItemRules = {},
    };

    -- Divide the PackMule rules in 3 types:
    --      1 Rule that decides where item lower than quality X get sent
    --      1 Rule that decides where item higher than quality X get sent
    --      Multiple rules that decide where specific items go (based on name)
    local LowerThanRule;
    local HigherThanRule;
    local SpecificItemRules = {};
    for _, Rule in pairs(Settings:get("PackMule.Rules")) do
        if (Rule.item) then
            tinsert(SpecificItemRules, Rule);
        elseif (Rule.operator) then
            if (Rule.operator == "<") then
                LowerThanRule = Rule;
            elseif (Rule.operator == ">") then
                HigherThanRule = Rule;
            end
        end
    end

    -- Create a container/parent frame
    local Frame = AceGUI:Create("Frame");
    Frame:SetCallback("OnClose", function(widget)
        self:processSettings();
        AceGUI:Release(widget);
        self.setupWindowIsActive = false;
    end);
    Frame:SetTitle(App.name .. " v" .. App.version);
    Frame:SetStatusText("Addon v" .. App.version);
    Frame:SetLayout("Flow");
    Frame:SetWidth(600);
    Frame:SetHeight(450);
    Frame.statustext:GetParent():Hide(); -- Hide the statustext bar
    Frame:EnableResize(false);

    self:drawSpacer(Frame, 1, 10);

    --[[ INFO ]]
    self:drawInfoSection(Frame);

    --[[ SETTINGS ]]
    self:drawHeader(Frame, "Settings");
    self:drawSettingsSection(Frame);
    self:drawSpacer(Frame, 1, 10);

    --[[ ITEM QUALITY RULES ]]
    self:drawHeader(Frame, "Item Quality");
    self:drawLowerThanQualityRule(Frame, LowerThanRule);
    self:drawSpacer(Frame, 1, 5);
    self:drawHigherThanQualityRule(Frame, HigherThanRule);
    self:drawSpacer(Frame, 1, 20);

    --[[ SPECIFIC ITEM RULES ]]
    self:drawHeader(Frame, "Specific Items");

    local ScrollFrame = self:drawScrollFrame(Frame);
    local numberOfRules = 4; -- TODO: Hardcoded for now, make dynamic

    for _, Rule in pairs(SpecificItemRules) do
        self:drawSpecifItemRule(ScrollFrame, Rule);
    end

    -- Make sure to draw aditional item rules in case we have less than 4
    for index = #self.UIComponents.Input.SpecificItemRules, 4 do
        self:drawSpecifItemRule(ScrollFrame);
    end
end

function PackMuleUI:drawInfoSection(Frame)
    local Row = AceGUI:Create("SimpleGroup");
    Row:SetLayout("Flow");
    Row:SetFullWidth(true);
    Row:SetHeight(30);
    Frame:AddChild(Row);

    self:drawSpacer(Row, 25, 1);

    -- LABEL: Info about PackMule
    local Info = AceGUI:Create("Label");
    Info:SetText([[
PackMule will only work if you are the master looter, you're in a raid and PackMule is "enabled"
]]);
    Info:SetHeight(20);
    Info:SetWidth(520);
    Row:AddChild(Info);
end

function PackMuleUI:drawSettingsSection(Frame)
    Utils:debug("PackMuleUI:drawSettingsSection");

    local Row = AceGUI:Create("SimpleGroup");
    Row:SetLayout("Flow");
    Row:SetFullWidth(true);
    Row:SetHeight(30);
    Frame:AddChild(Row);

    self:drawSpacer(Row, 35, 1);

    local EnablePackMule = AceGUI:Create("CheckBox");
    EnablePackMule:SetLabel("Enable");
    EnablePackMule:SetValue(Settings:get("PackMule.enabled", false));
    EnablePackMule:SetWidth(120);
    EnablePackMule:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(EnablePackMule.frame, "ANCHOR_TOP");
        GameTooltip:SetText("The rules will only be applied if this box is checked");
        GameTooltip:Show();
    end);
    EnablePackMule:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);
    Row:AddChild(EnablePackMule);
    self.UIComponents.Input.Enabled = EnablePackMule;

    local PackMulePersistsAfterZoneChange = AceGUI:Create("CheckBox");
    PackMulePersistsAfterZoneChange:SetLabel("Persist after zone switch");
    PackMulePersistsAfterZoneChange:SetValue(Settings:get("PackMule.persistsAfterZoneChange", false));
    PackMulePersistsAfterZoneChange:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(PackMulePersistsAfterZoneChange.frame, "ANCHOR_TOP");
        GameTooltip:SetText([[
PackMule is disabled by default after you as a player change to a different zone (e.g. you enter or leave an instance).
If you check this box then PackMule will keep its former state even after moving between zones. |cff8aecffUse with caution!
]]);
        GameTooltip:Show();
    end);
    PackMulePersistsAfterZoneChange:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);
    Row:AddChild(PackMulePersistsAfterZoneChange);
    self.UIComponents.Input.PeristAfterZoneChange = PackMulePersistsAfterZoneChange;

    local PackMulePersistsAfterReload = AceGUI:Create("CheckBox");
    PackMulePersistsAfterReload:SetLabel("Persist after reload");
    PackMulePersistsAfterReload:SetValue(Settings:get("PackMule.persistsAfterReload", false));
    PackMulePersistsAfterReload:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(PackMulePersistsAfterReload.frame, "ANCHOR_TOP");
        GameTooltip:SetText([[
PackMule is disabled by default after you as a player reload (e.g. reload the UI or restart the game).
If you check this box then PackMule will keep its former state even after reloading. |c00be3333Use with EXTREME caution|r!
]]);
        GameTooltip:Show();
    end);
    PackMulePersistsAfterReload:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);
    Row:AddChild(PackMulePersistsAfterReload);
    self.UIComponents.Input.PeristAfterReload = PackMulePersistsAfterReload;
end

function PackMuleUI:drawScrollFrame(Frame)
    local ScrollFrameParent = AceGUI:Create("SimpleGroup");
    ScrollFrameParent:SetLayout("Fill");
    ScrollFrameParent:SetFullWidth(true);
--    ScrollFrameParent:SetHeight(120);
    ScrollFrameParent:SetHeight(110);
    Frame:AddChild(ScrollFrameParent);

    local ScrollFrame = AceGUI:Create("ScrollFrame");
    ScrollFrame:SetLayout("Flow");
    ScrollFrameParent:AddChild(ScrollFrame);

    local AddRuleButton = AceGUI:Create("Button");
    AddRuleButton:SetText("Add Item Rule");
    AddRuleButton:SetWidth(140);
    AddRuleButton:SetHeight(20);
    AddRuleButton:SetCallback("OnClick", function()
        local index = self.numberOfSpecificItemRules or 0;
        self:drawSpecifItemRule(ScrollFrame);
    end);

    self:drawSpacer(Frame, 1, 10);

    local Row = AceGUI:Create("SimpleGroup");
    Row:SetLayout("Flow");
    Row:SetFullWidth(true);
    Row:SetHeight(30);
    Frame:AddChild(Row);

    self:drawSpacer(Row, 35, 1);
    Row:AddChild(AddRuleButton);

    return ScrollFrame;
end

function PackMuleUI:drawSpecifItemRule(Frame, Rule)
    Utils:debug("PackMuleUI:drawSpecifItemRule");

    Rule = Rule or {
        item = "",
        target = "",
    };

    local Row = AceGUI:Create("SimpleGroup");
    Row:SetLayout("Flow");
    Row:SetFullWidth(true);
    Row:SetHeight(30);
    Frame:AddChild(Row);

    self:drawSpacer(Row, 35, 1);

    -- LABEL: Send loot of quality lower than
    local beforeItemLabel = AceGUI:Create("Label");
    local ruleIndex = #self.UIComponents.Input.SpecificItemRules + 1;
    beforeItemLabel:SetText(ruleIndex .. ". Send item with name");
    beforeItemLabel:SetHeight(20);
    beforeItemLabel:SetWidth(140);
    Row:AddChild(beforeItemLabel);

    -- ITEM NAME
    local ItemName = AceGUI:Create("EditBox");
    ItemName:DisableButton(true);
    ItemName:SetHeight(25);
    ItemName:SetWidth(150);
    ItemName:SetText(Rule.item);
    Row:AddChild(ItemName);

    -- Increase space between input and next label ("to")
    self:drawSpacer(Row, 8, 1);

    -- LABEL: to
    local afterItemLabel = AceGUI:Create("Label");
    afterItemLabel:SetText("to");
    afterItemLabel:SetHeight(20);
    afterItemLabel:SetWidth(16);
    Row:AddChild(afterItemLabel);

    local ItemTarget = AceGUI:Create("EditBox");
    ItemTarget:DisableButton(true);
    ItemTarget:SetHeight(25);
    ItemTarget:SetWidth(150);
    ItemTarget:SetText(Rule.target);
    Row:AddChild(ItemTarget);

    tinsert(self.UIComponents.Input.SpecificItemRules, {
        Name = ItemName,
        Target = ItemTarget
    });
end

function PackMuleUI:drawSpacer(Parent, width, height)
    Utils:debug("self:drawSpacer");

    local Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetWidth(width);
    Spacer:SetHeight(height);
    Parent:AddChild(Spacer);
end

function PackMuleUI:drawLowerThanQualityRule(Frame, Rule)
    Utils:debug("PackMuleUI:drawLowerThanQualityRule");

    Rule = Rule or {
        quality = nil,
        target = "",
    }

    local Row = AceGUI:Create("SimpleGroup");
    Row:SetLayout("Flow");
    Row:SetFullWidth(true);
    Row:SetHeight(30);
    Frame:AddChild(Row);

    self:drawSpacer(Row, 35, 1);

    -- LABEL: Send loot of quality lower than
    local beforeLowerThanRuleLabel = AceGUI:Create("Label");
    beforeLowerThanRuleLabel:SetText("Send loot of quality |c00f7922elower|r than");
    beforeLowerThanRuleLabel:SetHeight(20);
    beforeLowerThanRuleLabel:SetWidth(170);
    Row:AddChild(beforeLowerThanRuleLabel);

    -- DROPDOWN
    local LowerThanRuleQuality = AceGUI:Create("Dropdown");
    LowerThanRuleQuality:SetHeight(20);
    LowerThanRuleQuality:SetWidth(120);
    LowerThanRuleQuality:SetList({
        [0] = "0 - Poor",
        [1] = "1 - Common",
        [2] = "2 - Uncommon",
        [3] = "3 - Rare",
        [4] = "4 - Epic",
        [5] = "5 - Legendary"
    });
    LowerThanRuleQuality:SetValue(Rule.quality);
    Row:AddChild(LowerThanRuleQuality);
    self.UIComponents.Input.LowerThanRuleQuality = LowerThanRuleQuality;

    -- Increase space between dropdown and next label ("to")
    self:drawSpacer(Row, 8, 1);

    -- LABEL: to
    local afterLowerThanRuleLabel = AceGUI:Create("Label");
    afterLowerThanRuleLabel:SetText("to");
    afterLowerThanRuleLabel:SetHeight(20);
    afterLowerThanRuleLabel:SetWidth(16);
    Row:AddChild(afterLowerThanRuleLabel);

    local LowerThanRuleTarget = AceGUI:Create("EditBox");
    LowerThanRuleTarget:DisableButton(true);
    LowerThanRuleTarget:SetHeight(25);
    LowerThanRuleTarget:SetWidth(150);
    LowerThanRuleTarget:SetText(Rule.target);
    Row:AddChild(LowerThanRuleTarget);
    self.UIComponents.Input.LowerThanRuleTarget = LowerThanRuleTarget;
end

function PackMuleUI:drawHigherThanQualityRule(Frame, Rule)
    Utils:debug("PackMuleUI:drawHigherThanQualityRule");

    Rule = Rule or {
        quality = nil,
        target = "",
    }

    local Row = AceGUI:Create("SimpleGroup");
    Row:SetLayout("Flow");
    Row:SetFullWidth(true);
    Row:SetHeight(40);
    Frame:AddChild(Row);

    self:drawSpacer(Row, 35, 1);

    -- LABEL: Send loot of quality lower than
    local beforeHigherThanRuleLabel = AceGUI:Create("Label");
    beforeHigherThanRuleLabel:SetText("Send loot of quality |c00f7922ehigher|r than");
    beforeHigherThanRuleLabel:SetHeight(20);
    beforeHigherThanRuleLabel:SetWidth(170);
    Row:AddChild(beforeHigherThanRuleLabel);

    -- DROPDOWN
    local HigherThanRuleQuality = AceGUI:Create("Dropdown");
    HigherThanRuleQuality:SetHeight(20);
    HigherThanRuleQuality:SetWidth(120);
    HigherThanRuleQuality:SetList({
        [0] = "0 - Poor",
        [1] = "1 - Common",
        [2] = "2 - Uncommon",
        [3] = "3 - Rare",
        [4] = "4 - Epic",
        [5] = "5 - Legendary"
    });
    HigherThanRuleQuality:SetValue(Rule.quality);
    Row:AddChild(HigherThanRuleQuality);
    self.UIComponents.Input.HigherThanRuleQuality = HigherThanRuleQuality;

    -- Increase space between dropdown and next label ("to")
    self:drawSpacer(Row, 8, 1);

    -- LABEL: to
    local afterHigherThanRuleLabel = AceGUI:Create("Label");
    afterHigherThanRuleLabel:SetText("to");
    afterHigherThanRuleLabel:SetHeight(20);
    afterHigherThanRuleLabel:SetWidth(16);
    Row:AddChild(afterHigherThanRuleLabel);

    local HigherThanRuleTarget = AceGUI:Create("EditBox");
    HigherThanRuleTarget:DisableButton(true);
    HigherThanRuleTarget:SetHeight(25);
    HigherThanRuleTarget:SetWidth(150);
    HigherThanRuleTarget:SetText(Rule.target);
    Row:AddChild(HigherThanRuleTarget);
    self.UIComponents.Input.HigherThanRuleTarget = HigherThanRuleTarget;
end

function PackMuleUI:drawHeader(Frame, text)
    Utils:debug("PackMuleUI:drawHeader");

    local Heading = AceGUI:Create("Heading");
    Heading:SetFullWidth(true);
    Heading:SetText(text);
    Frame:AddChild(Heading);
end

-- Process all values of the PackMule settings window
function PackMuleUI:processSettings()
    Utils:debug("PackMuleUI:processSettings");

    local Rules = {};
    local enabled = self.UIComponents.Input.Enabled:GetValue();
    local persistAfterReload = self.UIComponents.Input.PeristAfterReload:GetValue();
    local persistAfterZoneChange = self.UIComponents.Input.PeristAfterZoneChange:GetValue();

    -- Lower/higher than quality rules
    local lowerThanRuleQuality = self.UIComponents.Input.LowerThanRuleQuality:GetValue();
    local lowerThanRuleTarget = tostring(self.UIComponents.Input.LowerThanRuleTarget:GetText());
    local higherThanRuleQuality = self.UIComponents.Input.HigherThanRuleQuality:GetValue();
    local higherThanRuleTarget = tostring(self.UIComponents.Input.HigherThanRuleTarget:GetText());

    -- Reset (clear) all the current PackMule rules
    App.PackMule:resetRules();

    Settings:set("PackMule.enabled", enabled);
    Settings:set("PackMule.persistsAfterZoneChange", persistAfterZoneChange);
    Settings:set("PackMule.persistsAfterReload", persistAfterReload);

    -- Add the item-specific rules first
    for _, SpecificItemRule in pairs(self.UIComponents.Input.SpecificItemRules) do
        local name = tostring(SpecificItemRule.Name:GetText());
        local target = tostring(SpecificItemRule.Target:GetText());

        App.PackMule:addRule({
            item = name,
            target = target,
        });
    end

    -- Add the quality lower than X rule
    if (type(lowerThanRuleQuality) ~= "nil"
            and lowerThanRuleTarget
            and lowerThanRuleTarget ~= ""
    ) then
        App.PackMule:addRule({
            quality = lowerThanRuleQuality,
            operator = "<",
            target = lowerThanRuleTarget,
        });
    end

    -- Add the quality higher than X rule
    if (type(higherThanRuleQuality) ~= "nil"
            and higherThanRuleTarget
            and higherThanRuleTarget ~= ""
    ) then
        App.PackMule:addRule({
            quality = higherThanRuleQuality,
            operator = ">",
            target = higherThanRuleTarget,
        });
    end
end

Utils:debug("PackMuleUI.lua");