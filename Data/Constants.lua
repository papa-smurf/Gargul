---@type GL
local _, GL = ...;

---@class Data
GL.Data = GL.Data or {};

GL.Data.Constants = {
    --[[
        GLOBAL
    ]]
    addonHexColor =  "967fd2",

    success = 0,
    failure = 1,

    tmbTypePrio = 1,
    tmbTypeWish = 2,

    SoftReserveSources = {
        weakaura = 0,
        gargul = 1,
    },

    UntradeableItems = {
        "Splinter of Atiesh",
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

    classRGBAColors = {
        druid = {r = 1, g = .48627, b = .0392, a = 1},
        hunter = {r = .6666, g = .827450, b = .44705, a = 1},
        mage = {r = .4078, g = .8, b = .93725, a = 1},
        paladin = {r = .95686, g = .5490, b = .72941, a = 1},
        priest = {r = 1, g = 1, b = 1, a = 1},
        rogue = {r = 1, g = .95686, b = .40784, a = 1},
        shaman = {r = 0, g = .44, b = .87, a = 1},
        warlock = {r = .57647, g = .5098, b = .788235, a = 1},
        warrior = {r = .77647, g = .607843, b = .42745, a = 1},
    },

    classRGBColors = {
        druid = {1, .48627, .0392,},
        hunter = {.6666, .827450, .44705,},
        mage = {.4078, .8, .93725,},
        paladin = {.95686, .5490, .72941,},
        priest = {1, 1, 1, 1},
        rogue = {1, .95686, .40784,},
        shaman = {0, .44, .87,},
        warlock = {.57647, .5098, .788235,},
        warrior = {.77647, .607843, .42745,},
    },

    --[[
        COMM
    ]]
    Comm = {
        channel = "GargulComm2",
        minimumAppVersion = "3.1",
        Actions = {
            broadcastSoftRes = 5,
            inspectBags = 6,
            response = 7,
            requestAppVersion = 9,
            startRollOff = 11,
            stopRollOff = 13,
            broadcastTMBData = 14,
            awardItem = 15
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