---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class DroppedLootSettings
GL.Interface.Settings.DroppedLoot = {
    description = "Gargul allows you to automatically announce dropped loot into your group chat.\n\nNB: In order for loot to be announced you need to be in a group and need to have the master looter role!",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Announcing-Loot-in-Chat",
};
local DroppedLoot = GL.Interface.Settings.DroppedLoot; ---@type DroppedLootSettings

---@return void
function DroppedLoot:draw(Parent)
    GL:debug("DroppedLoot:draw");

    local HorizontalSpacer;
    local AceGUI = GL.AceGUI;

    local MinimumQualityLabel = AceGUI:Create("Label");
    MinimumQualityLabel:SetText("The minimum quality an item should have in order to be announced in chat");
    MinimumQualityLabel:SetHeight(20);
    MinimumQualityLabel:SetFullWidth(true);
    Parent:AddChild(MinimumQualityLabel);

    local DropDownItems = {
        [0] = "0 - Poor",
        [1] = "1 - Common",
        [2] = "2 - Uncommon",
        [3] = "3 - Rare",
        [4] = "4 - Epic",
        [5] = "5 - Legendary",
    };

    local MinimumQuality = AceGUI:Create("Dropdown");
    MinimumQuality:SetValue(GL.Settings:get("minimumQualityOfAnnouncedLoot"));
    MinimumQuality:SetList(DropDownItems);
    MinimumQuality:SetText(DropDownItems[GL.Settings:get("minimumQualityOfAnnouncedLoot")]);
    MinimumQuality:SetWidth(150);
    MinimumQuality:SetCallback("OnValueChanged", function()
        GL.Settings:set("minimumQualityOfAnnouncedLoot", MinimumQuality:GetValue());
    end);
    Parent:AddChild(MinimumQuality);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local Checkboxes = {
        {
            label = "Announce loot to chat",
            description = "Checking this will make sure that dropped loot of a given minimum quality (see the minimum announce quality setting) is announced to the party or raid chat",
            setting = "announceLootToChat",
        },
        {
            label = "Include SoftRes details",
            description = "Checking this will make sure that SoftRes details of dropped loot are also announced in the chat",
            setting = "includeSoftResInLootAnnouncement",
        },
        {
            label = "Include TMB wishlist details",
            description = "Checking this will make sure that TMB wishlist details of dropped loot are announced in the chat",
            setting = "TMB.includeWishListInfoInLootAnnouncement",
        },
        {
            label = "Include TMB item priority details",
            description = "Checking this will make sure that TMB item priority details of dropped loot is announced in the chat",
            setting = "TMB.includePrioListInfoInLootAnnouncement",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/DroppedLoot.lua");