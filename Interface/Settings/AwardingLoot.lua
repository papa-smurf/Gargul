---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class AwardingLootSettings
GL.Interface.Settings.AwardingLoot = {
    description = "By default, Gargul will attempt to aid in trading items to the winner and post congratulatory messages in the appropriate group channel.\n\nTo award items you can either run '/gl award' or alt+shift+left-click an item from your inventory (NOT character screen) or enemy's loot window.\n\nNB: If alt/alt+shift clicking items does not work for you then it's mostly likely an add-on interfering with the Blizzard UI (ElvUI and xLoot are confirmed culprits for example)",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Awarding-Items",
};
local AwardingLoot = GL.Interface.Settings.AwardingLoot; ---@type AwardingLootSettings

---@return void
function AwardingLoot:draw(Parent)
    GL:debug("AwardingLootSettings:draw");

    local Checkboxes = {
        {
            label = "Disable award messages",
            description = "Check this if you don't want Gargul to post a message regarding awarded items in raid/party chat",
            setting = "AwardingLoot.awardMessagesDisabled",
        },
        {
            label = "Use raid warning",
            description = "Check this if you want Gargul to use /rw instead of /ra for announcing winners",
            setting = "AwardingLoot.announceAwardMessagesInRW",
        },
        {
            label = "Announce in Guild chat",
            description = "Check this if you want Gargul to announce awarded items in guild chat as well",
            setting = "AwardingLoot.announceAwardMessagesInGuildChat",
        },
        {
            label = "Auto assign loot",
            description = "Auto assign an item to the winner after awarding an item (with master loot enabled and boss window still open)",
            setting = "AwardingLoot.autoAssignAfterAwardingAnItem",
        },
        {
            label = "Auto trade loot",
            description = "If master loot is disabled, you are not the master looter or the boss' loot window is closed attempt to open a trade window with the winner of the item and put the item in the trade window automatically",
            setting = "AwardingLoot.autoTradeAfterAwardingAnItem",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/AwardingLoot.lua");