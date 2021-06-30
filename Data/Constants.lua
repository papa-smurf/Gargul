--[[
    This class holds all static values the addon needs
]]

local _, App = ...;
App.Data = App.Data or {};

App.Data.Constants = {
    --[[
        GLOBAL
    ]]
    success = 0,
    failure = 1,

    UntradeableItems = {
        "Splinter of Atiesh",
    },

    RaidingZones = {
        "Molten Core",
        "Onyxia's Lair",
        "Blackwing Lair",
        "Zul'Gurub",
        "Ruins of Ahn'Qiraj",
        "Temple of Ahn'Qiraj",
        "Naxxramas",
    },

    Classes = {
        druid = 1,
        hunter = 2,
        mage = 3,
        paladin = 4,
        priest = 5,
        rogue = 6,
        shaman = 7,
        warlock = 8,
        warrior = 9,
    },

    ClassHexColors = {
        druid = "FF7D0A",
        hunter = "ABD473",
        mage = "69CCF0",
        paladin = "F58CBA",
        priest = "FFFFFF",
        rogue = "FFF569",
        shaman = "0070DE",
        warlock = "9482C9",
        warrior = "C79C6E",
    },

    ClassRgbColors = {
        druid = {r = 1, g = .48627, b = .0392, a = 1},
        hunter = {r = .6666, g = .827450, b = .44705, a = 1},
        mage = {r = .4078, g = .8, b = .93725, a = 1},
        paladin = {r = .95686, g = .5490, b = .72941, a = 1},
        priest = {r = 1, g = 1, b = 1, a = 1},
        rogue = {r = 1, g = .95686, b = .40784, a = 1},
        shaman = {r = .95686, g = .5490, b = .72941, a = 1},
        warlock = {r = .57647, g = .5098, b = .788235, a = 1},
        warrior = {r = .77647, g = .607843, b = .42745, a = 1},
    },

    --[[
        DEFAULT SETTINGS
    ]]
    Settings = {
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
            Bidder = {
                timer = 25,
                Position = {
                    point = "CENTER",
                    relativePoint = "CENTER",
                    offsetX = 0,
                    offsetY = 0,
                }
            },
            RollOff = {
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
            }
        }
    },

    --[[
        COMM
    ]]
    Comm = {
        channel = "GargulComm2",
        minimumAppVersion = "2",
        Actions = {
            auctionResult = 1,
            bid = 2,
            broadcastCharacters = 3,
            broadcastLootHistory = 4,
            broadcastSoftReserves = 5,
            inspectBags = 6,
            response = 7,
            retractBid = 8,
            requestAppVersion = 9,
            startAuction = 10,
            startRollOff = 11,
            stopAuction = 12,
            stopRollOff = 13,
            broadcastWishLists = 14
        },
    },

    --[[
        LIBRARIES
    ]]
    ScrollingTable = {
        ascending = 1,
        descending = 2,
    }
};