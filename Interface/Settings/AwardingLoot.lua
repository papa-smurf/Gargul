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
            label = "Track bonus loot (MoP+)",
            description = "Track items won by players using their bonus roll",
            setting = "AwardingLoot.awardBonusLoot",
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
        {
            label = "Notify in case trade fails",
            description = "Send a whisper to the winner if you couldn't open a trade window with them",
            setting = "AwardingLoot.notifyOfFailedTradeStart",
        },
        {
            label = "Skip award confirmation dialog",
            setting = "AwardingLoot.skipAwardConfirmationDialog",
            description = "Disable the award confirmation. Hold shift while clicking award to temporarily enable/disable skipping this confirmation",
        },
        {
            label = "Auto trade disenchanter",
            setting = "AwardingLoot.autoTradeDisenchanter",
        },
        {
            label = "Auto trade during combat",
            setting = "AwardingLoot.autoTradeInCombat",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/AwardingLoot.lua");