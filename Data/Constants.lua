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
                timer = 15,
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
    commChannel = "GargulComm2",
    CommActions = {
        auctionResult = "Auction.Result",
        bid = "Bidder.Bid",
        broadcastCharacters = "Sync.Characters",
        broadcastLootHistory = "Sync.LootHistory",
        broadcastSoftReserves = "SoftReservers.Broadcast",
        inspectBags = "BagInspector.inspect",
        response = "Comm.Response",
        retractBid = "Bidder.RetractBid",
        requestAppVersion = "Version.requestAppVersion",
        startAuction = "Auction.Start",
        startRollOff = "RollOff.Start",
        stopAuction = "Auction.Stop",
        stopRollOff = "RollOff.Stop",
    },

    --[[
        LIBRARIES
    ]]
    ScrollingTable = {
        ascending = 1,
        descending = 2,
    }
};