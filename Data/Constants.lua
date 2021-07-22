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

    tmbTypePrio = 1,
    tmbTypeWish = 2,

    LinkedItems = {
        -- Head of Onyxia (Horde/Alliance)
        ["18422"] = 18423,
        ["18423"] = 18422,

        -- Magtheridon's Head (Horde/Alliance)
        ["32385"] = 32386,
        ["32386"] = 32385,

        -- Tier 3 items
            -- Desecrated Sandals
            ["22372"] = {22500, 22508, 22516},

            -- Desecrated Boots
            ["22365"] = {22440, 22492, 22468, 22430},

            -- Desecrated Sabatons
            ["22358"] = {22480, 22420},

            -- Desecrated Belt
            ["22370"] = {22518, 22502, 22510},

            -- Desecrated Girdle
            ["22363"] = {22442, 22494, 22470, 22431},

            -- Desecrated Waistguard
            ["22356"] = {22482, 22422},

            -- Desecrated Gloves
            ["22371"] = {22501, 22517, 22509},

            -- Desecrated Handguards
            ["22364"] = {22441, 22493, 22469, 22426},

            -- Desecrated Gauntlets
            ["22357"] = {22481, 22421},

            -- Desecrated Circlet
            ["22367"] = {22514, 22498, 22506},

            -- Desecrated Headpiece
            ["22360"] = {22438, 22490, 22466, 22428},

            -- Desecrated Helmet
            ["22353"] = {22478, 22418},

            -- Desecrated Leggings
            ["22366"] = {22497, 22513, 22505},

            -- Desecrated Legguards
            ["22359"] = {22437, 22489, 22465, 22427},

            -- Desecrated Legplates
            ["22352"] = {22477, 22417},

            -- Desecrated Shoulderpads
            ["22368"] = {22499, 22507, 22515},

            -- Desecrated Spaulders
            ["22361"] = {22439, 22491, 22467, 22429},

            -- Desecrated Pauldrons
            ["22354"] = {22479, 22419},

            -- Desecrated Robe
            ["22351"] = {22496, 22504, 22512},

            -- Desecrated Tunic
            ["22350"] = {22436, 22488, 22464, 22425},

            -- Desecrated Breastplate
            ["22349"] = {22476, 22416},

            -- Desecrated Bindings
            ["22369"] = {22519, 22503, 22511},

            -- Desecrated Wristguards
            ["22362"] = {22443, 22495, 22471, 22424},

            -- Desecrated Bracers
            ["22355"] = {22483, 22423},

        -- Tier 4 items
		    -- Gloves of the Fallen Champion
            ["29757"] = {29039, 29032, 29034, 29072, 29065, 29067, 29048},

			-- Gloves of the Fallen Defender
            ["29758"] = {29097, 29090, 29092, 29057, 29055, 29020, 29017},

			-- Gloves of the Fallen Hero
            ["29756"] = {29085, 29080, 28968},

			-- Helm of the Fallen Champion
            ["29760"] = {29035, 29028, 29040, 29073, 29061, 29068, 29044},

			-- Helm of the Fallen Defender
            ["29761"] = {29093, 29086, 29049, 29058, 29011, 29021, 29098},

			-- Helm of the Fallen Hero
            ["29759"] = {29076, 29081, 28963},

			-- Pauldrons of the Fallen Champion
            ["29763"] = {29037, 29031, 29043, 29064, 29070, 29075, 29047},

			-- Pauldrons of the Fallen Defender
            ["29764"] = {29054, 29100, 29095, 29089, 29060, 29016, 29023},

			-- Pauldrons of the Fallen Hero
            ["29762"] = {29084, 29079, 28967},

			-- Leggings of the Fallen Champion
            ["29766"] = {29030, 29036, 29042, 29063, 29069, 29074, 29046},

			-- Leggings of the Fallen Defender
            ["29767"] = {29094, 29099, 29059, 29088, 29053, 29022, 29015},

			-- Leggings of the Fallen Hero
            ["29765"] = {29083, 29078, 28966},

			-- Chestguard of the Fallen Champion
            ["29754"] = {29038, 29033, 29029, 29071, 29066, 29062, 29045},

			-- Chestguard of the Fallen Defender
            ["29753"] = {29096, 29087, 29091, 29050, 29056, 29019, 29012},

			-- Chestguard of the Fallen Hero
            ["29755"] = {29082, 29077, 28964},
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

    ClassRgbColors = {
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

    --[[
        COMM
    ]]
    Comm = {
        channel = "GargulComm2",
        minimumAppVersion = "3",
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