---@type GL
local _, GL = ...;

---@class DefaultSettings : Data
GL.Data = GL.Data or {};

GL.Data.DefaultSettings = {
    muted = false,
    announceLootToChat = true,
    minimumQualityOfAnnouncedLoot = 4,
    includeSoftResInLootAnnouncement = true,
    autoTradeAfterAwardingAnItem = true,
    autoAssignAfterAwardingAnItem = true,
    debugModeEnabled = false,
    highlightsDisabled = false,

    Rolling = {
        showRollOffWindow = true,
        announcePass = true,
    },

    SoftRes = {
        includeSoftResInfoInLootAnnouncement = true,
        hideInfoOfPeopleNotInGroup = true,
        showSoftResInfoOnTooltips = true,
    },

    TMB = {
        includeWishListInfoInLootAnnouncement = true,
        includePrioListInfoInLootAnnouncement = true,
        hideInfoOfPeopleNotInGroup = true,
        showWishListInfoOnTooltips = true,
        showPrioListInfoOnTooltips = true,
        hideWishListInfoIfPriorityIsPresent = true,
        maximumNumberOfTooltipEntries = 50,
    },

    PackMule = {
        enabled = false,
        persistsAfterReload = false,
        persistsAfterZoneChange = false,
        Rules = {},
    },

    UI = {
        Award = {
            autoClose = false,
            timer = 25,
        },
        Bidder = {
            timer = 25,
        },
        Dashboard = {
            showInRaidOnly = false,
        },
        RollOff = {
            autoClose = false,
            timer = 25,
        },
    }
};