---@type GL
local _, GL = ...;

---@class DefaultSettings : Data
GL.Data = GL.Data or {};

GL.Data.DefaultSettings = {
    announceLootToChat = true,
    autoAssignAfterAwardingAnItem = true,
    autoTradeAfterAwardingAnItem = true,
    debugModeEnabled = false,
    highlightsDisabled = false,
    highlightHardReservedItems = true,
    highlightSoftReservedItems = true,
    highlightWishlistedItems = true,
    minimumQualityOfAnnouncedLoot = 4,
    noMessages = false,
    noSounds = false,
    autoOpenCommandHelp = true,
    showMinimapButton = true,
    spreadTheWord = true,
    welcomeMessage = true,
    fixMasterLootWindow = true,

    PackMule = {
        announceDisenchantedItems = true,
        enabled = false,
        persistsAfterReload = false,
        persistsAfterZoneChange = false,
        Rules = {},
    },
    ExportingLoot = {
        includeDisenchantedItems = true,
        disenchanterIdentifier = "_disenchanted",
    },
    Rolling = {
        showRollOffWindow = true,
        osRollMax = 99,
        closeAfterRoll = false,
    },
    SoftRes = {
        announceInfoInChat = true,
        enableTooltips = true,
        hideInfoOfPeopleNotInGroup = true,
    },
    TMB = {
        hideInfoOfPeopleNotInGroup = true,
        hideWishListInfoIfPriorityIsPresent = true,
        includePrioListInfoInLootAnnouncement = true,
        includeWishListInfoInLootAnnouncement = true,
        maximumNumberOfTooltipEntries = 35,
        showPrioListInfoOnTooltips = true,
        showWishListInfoOnTooltips = true,
    },
    UI = {
        RollOff = {
            closeOnStart = true,
            closeOnAward = true,
            timer = 15,
        },
        PopupDialog = {
            Position = {
                offsetX = 0,
                offsetY = -115,
                point = "TOP",
                relativePoint = "TOP",
            }
        },
        Award = {
            closeOnAward = true,
        },
    }
};