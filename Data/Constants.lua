--[[--
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

    --[[
        DEFAULT SETTINGS
    ]]
    Settings = {
        UI = {
            Dashboard = {
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
    commChannel = "GiveitalickComm",
    CommActions = {
        response = "Comm.Response",
        broadcastCharacters = "Sync.Characters",
        broadcastLootHistory = "Sync.LootHistory",
        startAuction = "Auction.Start",
        stopAuction = "Auction.Stop",
        auctionResult = "Auction.Result",
        bid = "Bidder.Bid",
        retractBid = "Bidder.RetractBid",
        requestAppVersion = "Version.requestAppVersion",
    },

    --[[
        LIBRARIES
    ]]
    ScrollingTable = {
        ascending = 1,
        descending = 2,
    }
};