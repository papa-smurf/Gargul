---@type GL
local _, GL = ...;

---@class DefaultSettings : Data
GL.Data = GL.Data or {};

GL.Data.DefaultSettings = {
    announceLootToChat = true,
    debugModeEnabled = false,
    highlightsDisabled = false,
    highlightHardReservedItems = true,
    highlightSoftReservedItems = true,
    highlightWishlistedItems = true,
    highlightPriolistedItems = true,
    minimumQualityOfAnnouncedLoot = 4,
    noMessages = false,
    noSounds = false,
    autoOpenCommandHelp = true,
    showMinimapButton = true,
    welcomeMessage = true,
    fixMasterLootWindow = true,

    ShortcutKeys = {
        showLegend = true,
        rollOff = "ALT_CLICK",
        award = "ALT_SHIFT_CLICK",
        disenchant = "CTRL_SHIFT_CLICK",
    },
    MasterLooting = {
        autoOpenMasterLooterDialog = true,
        announceMasterLooter = false,
        doCountdown = true,
        announceRollEnd = true,
        announceRollStart = true,
        numberOfSecondsToCountdown = 5,
        preferredMasterLootingThreshold = 2,
    },
    AwardingLoot = {
        announceAwardMessagesInGuildChat = false,
        announceAwardMessagesInRW = false,
        autoAssignAfterAwardingAnItem = true,
        autoTradeAfterAwardingAnItem = true,
        awardMessagesDisabled = false,
    },
    ExportingLoot = {
        includeDisenchantedItems = true,
        disenchanterIdentifier = "_disenchanted",
    },
    LootTradeTimers = {
        maximumNumberOfBars = 5,
        enabled = true,
        showOnlyWhenMasterLooting = true,
    },
    PackMule = {
        announceDisenchantedItems = true,
        enabled = false,
        persistsAfterReload = false,
        persistsAfterZoneChange = false,
        Rules = {},
    },
    Rolling = {
        showRollOffWindow = true,
        closeAfterRoll = false,
    },
    RollTracking = {
        trackAll = false,
        Brackets = {
            {"MS", 1, 100, 2},
            {"OS", 1, 99, 3},
        },
    },
    SoftRes = {
        announceInfoInChat = true,
        enableTooltips = true,
        hideInfoOfPeopleNotInGroup = true,
    },
    StackedRoll = {
        enabled = false,
        automaticallyShareData = true,
        priority = 1,
        identifier = "ST",
        reserveThreshold = 180,
        defaultPoints = 100,
        defaultCost = 10,
        defaultStep = 10,
        enableWhisperCommand = true,
    },
    TMB = {
        automaticallyShareData = false,
        hideInfoOfPeopleNotInGroup = true,
        hideWishListInfoIfPriorityIsPresent = true,
        includePrioListInfoInLootAnnouncement = true,
        includeWishListInfoInLootAnnouncement = true,
        maximumNumberOfTooltipEntries = 35,
        maximumNumberOfAnouncementEntries = 5,
        showEntriesWhenSolo = true,
        showItemInfoOnTooltips = true,
        showLootAssignmentReminder = true,
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