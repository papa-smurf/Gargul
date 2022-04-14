---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class TradeAnnouncements
GL.Interface.Settings.TradeAnnouncements = {
    description = "When should Gargul announce traded items and/or gold?",
};
local TradeAnnouncements = GL.Interface.Settings.TradeAnnouncements; ---@type TradeAnnouncements

---@return void
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
            label = "Items received",
            description = "Announce items received in a trade",
            setting = "TradeAnnouncements.itemsReceived",
        },
        {
            label = "Items given",
            description = "Announce items given in a trade",
            setting = "TradeAnnouncements.itemsGiven",
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
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);
end

GL:debug("Interface/Settings/TradeAnnouncements.lua");