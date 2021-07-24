--[[
    DEFAULT SETTINGS
]]

local _, App = ...;
App.Data = App.Data or {};

App.Data.DefaultSettings = {

    muted = false,
    announceLootToChat = true,
    minimumQualityOfAnnouncedLoot = 4,
    includeSoftReservesInLootAnnouncement = true,
    showRollOffWindow = true,
    autoTradeAfterAwardingAnItem = true,
    autoAssignAfterAwardingAnItem = true,
    debugModeEnabled = false,

    TMB = {
        includeWishListInfoInLootAnnouncement = true,
        includePrioListInfoInLootAnnouncement = true,
        hideInfoOfPeopleNotInraid = true,
        showWishListInfoOnTooltips = true,
        showPrioListInfoOnTooltips = true,
        hideWishListInfoIfPriorityIsPresent = true,
    },

    PackMule = {
        enabled = false,
        persistsAfterReload = false,
        persistsAfterZoneChange = false,
        Rules = {},
    },

    UI = {
        Dashboard = {
            showInRaidOnly = false,
            Position = {
                point = "Center",
                relativePoint = "Center",
                offsetX = 0,
                offsetY = 0,
            }
        },
        Auctioneer = {
            Position = {
                point = "Center",
                relativePoint = "Center",
                offsetX = 0,
                offsetY = 0,
            }
        },
        Award = {
            autoClose = false,
            timer = 25,
            Position = {
                point = "CENTER",
                relativePoint = "CENTER",
                offsetX = 0,
                offsetY = 0,
            }
        },
        Bidder = {
            timer = 25,
            Position = {
                point = "CENTER",
                relativePoint = "CENTER",
                offsetX = 0,
                offsetY = 0,
            }
        },
        Exporter = {
            Position = {
                point = "CENTER",
                relativePoint = "CENTER",
                offsetX = 0,
                offsetY = 0,
            }
        },
        RollOff = {
            autoClose = false,
            timer = 25,
            Position = {
                point = "CENTER",
                relativePoint = "CENTER",
                offsetX = 0,
                offsetY = 0,
            }
        },
        Roller = {
            Position = {
                point = "CENTER",
                relativePoint = "CENTER",
                offsetX = 0,
                offsetY = 0,
            }
        },
        ReopenAuctioneerUIButton = {
            Position = {
                point = "CENTER",
                relativePoint = "CENTER",
                offsetX = 0,
                offsetY = 0,
            }
        },
        ReopenMasterLooterUIButton = {
            Position = {
                point = "CENTER",
                relativePoint = "CENTER",
                offsetX = 0,
                offsetY = 0,
            }
        }
    }
};