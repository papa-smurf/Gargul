---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class AwardingLootSettings
GL.Interface.Settings.AwardingLoot = {
    description = string.format("By default, Gargul will attempt to aid in trading items to the winner and post congratulatory messages in the appropriate group channel.\n\nTo award items you can %s an item from your inventory, enemy loot window or trade timer bar.", GL.Settings:get("ShortcutKeys.award")),
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Awarding-Items",
};
local AwardingLoot = GL.Interface.Settings.AwardingLoot; ---@type AwardingLootSettings

---@return void
function AwardingLoot:draw(Parent)
    GL:debug("AwardingLootSettings:draw");

    local Checkboxes = {
        {
            label = "Award messages",
            description = "Gargul will anounce items awarded in raid/party chat",
            setting = "AwardingLoot.awardMessagesEnabled",
        },
        {
            label = "Use raid warning",
            description = "Announce winners in /rw instead of /ra",
            setting = "AwardingLoot.announceAwardMessagesInRW",
        },
        {
            label = "Announce in Guild chat",
            description = "Announce items awarded to guildies in your guild chat",
            setting = "AwardingLoot.announceAwardMessagesInGuildChat",
        },
        {
            label = "Announce disenchanted items",
            description = "Post a message whenever an item is marked as disenchanted",
            setting = "PackMule.announceDisenchantedItems",
        },
        {
            label = "Auto assign master loot items",
            description = "Auto assign an item to the winner after awarding it through master loot (with boss window still open)",
            setting = "AwardingLoot.autoAssignAfterAwardingAnItem",
        },
        {
            label = "Auto trade winner",
            description = "If you award an item from your inventory then automatically trade the winner if he's within reach",
            setting = "AwardingLoot.autoTradeAfterAwardingAnItem",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/AwardingLoot.lua");