---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class TradeAnnouncements
GL.Interface.Settings.TradeAnnouncements = {
    description = "When should Gargul announce traded items and/or gold?\n\n|cffC41E3ANote: gold trades are always announced when you have an active GDKP session!|r",
};
local TradeAnnouncements = GL.Interface.Settings.TradeAnnouncements; ---@type TradeAnnouncements

---@return nil
function TradeAnnouncements:draw(Parent)
    GL:debug("TradeAnnouncements:draw");

    local AceGUI = GL.AceGUI;
    local DropDownItems = {
        NEVER = "Never",
        ALWAYS = "Always",
        WHEN_IN_GROUP = "When in a group/raid",
        WHEN_ASSIST = "When I have lead/assist",
        WHEN_MASTERLOOTER = "Only when I'm the master looter",
    };
    local ItemOrder = {
        "NEVER",
        "ALWAYS",
        "WHEN_IN_GROUP",
        "WHEN_ASSIST",
        "WHEN_MASTERLOOTER",
    }

    local AnnounceWhen = AceGUI:Create("Dropdown");
    AnnounceWhen:SetValue(GL.Settings:get("TradeAnnouncements.mode"));
    AnnounceWhen:SetList(DropDownItems, ItemOrder);
    AnnounceWhen:SetText(DropDownItems[GL.Settings:get("TradeAnnouncements.mode")]);
    AnnounceWhen:SetWidth(250);
    AnnounceWhen:SetCallback("OnValueChanged", function()
        GL.Settings:set("TradeAnnouncements.mode", AnnounceWhen:GetValue());
    end);
    Parent:AddChild(AnnounceWhen);

    local HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local Checkboxes = {
        {
            label = "Always announce enchantments",
            description = "Announce trades that include enchants regardless of the setting above",
            setting = "TradeAnnouncements.alwaysAnnounceEnchantments",
        },
        {
            label = "Gold received",
            description = "Announce gold received in a trade",
            setting = "TradeAnnouncements.goldReceived",
        },
        {
            label = "Gold given",
            description = "Announce gold given in a trade",
            setting = "TradeAnnouncements.goldGiven",
        },
        {
            label = "Enchantment received",
            description = "Announce enchantment received in a trade",
            setting = "TradeAnnouncements.enchantmentReceived",
        },
        {
            label = "Enchantment given",
            description = "Announce enchantment given in a trade",
            setting = "TradeAnnouncements.enchantmentGiven",
        },
        {
            label = "Items received",
            description = "Announce items received in a trade",
            setting = "TradeAnnouncements.itemsReceived",
        },
        {
            label = "Items given",
            description = "Announce items given in a trade",
            setting = "TradeAnnouncements.itemsGiven",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local MinimumQualityLabel = AceGUI:Create("Label");
    MinimumQualityLabel:SetText("The minimum quality an item should have in order to be announced in chat");
    MinimumQualityLabel:SetHeight(20);
    MinimumQualityLabel:SetFullWidth(true);
    Parent:AddChild(MinimumQualityLabel);

    DropDownItems = {
        [0] = "0 - Poor",
        [1] = "1 - Common",
        [2] = "2 - Uncommon",
        [3] = "3 - Rare",
        [4] = "4 - Epic",
        [5] = "5 - Legendary",
    };

    local MinimumQuality = AceGUI:Create("Dropdown");
    MinimumQuality:SetValue(GL.Settings:get("TradeAnnouncements.minimumQualityOfAnnouncedLoot", 0));
    MinimumQuality:SetList(DropDownItems);
    MinimumQuality:SetText(DropDownItems[GL.Settings:get("TradeAnnouncements.minimumQualityOfAnnouncedLoot", 0)]);
    MinimumQuality:SetWidth(150);
    MinimumQuality:SetCallback("OnValueChanged", function()
        GL.Settings:set("TradeAnnouncements.minimumQualityOfAnnouncedLoot", MinimumQuality:GetValue());
    end);
    Parent:AddChild(MinimumQuality);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);
end

GL:debug("Interface/Settings/TradeAnnouncements.lua");