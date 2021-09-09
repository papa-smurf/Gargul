---@type GL
local _, GL = ...;

---@class ItemLinks : Data
GL.Data = GL.Data or {};

GL.Data.ItemLinks = {
    -- Head of Onyxia (Horde/Alliance/Rewards)
    ["18422"] = {18423, 18403, 18404, 18406,},
    ["18423"] = {18422, 18403, 18404, 18406,},

    -- Magtheridon's Head (Horde/Alliance/Rewards)
    ["32385"] = {32386, 28790, 28791, 28792, 28793,},
    ["32386"] = {32385, 28790, 28791, 28792, 28793,},

    -- Head of Nefarian (Horde/Alliance/Rewards)
    ["19002"] = {19003, 19383, 19366, 19384,},
    ["19003"] = {19002, 19383, 19366, 19384,},

    -- Head of Ossirian the Unscarred
    ["21220"] = {21504, 21507, 21505, 21506,},

    -- The Phylactery of Kel'Thuzad
    ["22520"] = {23206, 23207,},

    -- Heart of Hakkar
    ["19802"] = {19948, 19950, 19949,},

    -- Verdant Sphere
    ["32405"] = {30015,30007,30018,30017,},

    --[[ TIER 3 ITEMS ]]
        -- Desecrated Sandals
        ["22372"] = {22500, 22508, 22516,},

        -- Desecrated Boots
        ["22365"] = {22440, 22492, 22468, 22430,},

        -- Desecrated Sabatons
        ["22358"] = {22480, 22420,},

        -- Desecrated Belt
        ["22370"] = {22518, 22502, 22510,},

        -- Desecrated Girdle
        ["22363"] = {22442, 22494, 22470, 22431,},

        -- Desecrated Waistguard
        ["22356"] = {22482, 22422,},

        -- Desecrated Gloves
        ["22371"] = {22501, 22517, 22509,},

        -- Desecrated Handguards
        ["22364"] = {22441, 22493, 22469, 22426,},

        -- Desecrated Gauntlets
        ["22357"] = {22481, 22421,},

        -- Desecrated Circlet
        ["22367"] = {22514, 22498, 22506,},

        -- Desecrated Headpiece
        ["22360"] = {22438, 22490, 22466, 22428,},

        -- Desecrated Helmet
        ["22353"] = {22478, 22418,},

        -- Desecrated Leggings
        ["22366"] = {22497, 22513, 22505,},

        -- Desecrated Legguards
        ["22359"] = {22437, 22489, 22465, 22427,},

        -- Desecrated Legplates
        ["22352"] = {22477, 22417,},

        -- Desecrated Shoulderpads
        ["22368"] = {22499, 22507, 22515,},

        -- Desecrated Spaulders
        ["22361"] = {22439, 22491, 22467, 22429,},

        -- Desecrated Pauldrons
        ["22354"] = {22479, 22419,},

        -- Desecrated Robe
        ["22351"] = {22496, 22504, 22512,},

        -- Desecrated Tunic
        ["22350"] = {22436, 22488, 22464, 22425,},

        -- Desecrated Breastplate
        ["22349"] = {22476, 22416,},

        -- Desecrated Bindings
        ["22369"] = {22519, 22503, 22511,},

        -- Desecrated Wristguards
        ["22362"] = {22443, 22495, 22471, 22424,},

        -- Desecrated Bracers
        ["22355"] = {22483, 22423,},

    --[[ TIER 4 ITEMS ]]
        -- Gloves of the Fallen Champion
        ["29757"] = {29039, 29032, 29034, 29072, 29065, 29067, 29048,},

        -- Gloves of the Fallen Defender
        ["29758"] = {29097, 29090, 29092, 29057, 29055, 29020, 29017,},

        -- Gloves of the Fallen Hero
        ["29756"] = {29085, 29080, 28968,},

        -- Helm of the Fallen Champion
        ["29760"] = {29035, 29028, 29040, 29073, 29061, 29068, 29044,},

        -- Helm of the Fallen Defender
        ["29761"] = {29093, 29086, 29049, 29058, 29011, 29021, 29098,},

        -- Helm of the Fallen Hero
        ["29759"] = {29076, 29081, 28963,},

        -- Pauldrons of the Fallen Champion
        ["29763"] = {29037, 29031, 29043, 29064, 29070, 29075, 29047,},

        -- Pauldrons of the Fallen Defender
        ["29764"] = {29054, 29100, 29095, 29089, 29060, 29016, 29023,},

        -- Pauldrons of the Fallen Hero
        ["29762"] = {29084, 29079, 28967,},

        -- Leggings of the Fallen Champion
        ["29766"] = {29030, 29036, 29042, 29063, 29069, 29074, 29046,},

        -- Leggings of the Fallen Defender
        ["29767"] = {29094, 29099, 29059, 29088, 29053, 29022, 29015,},

        -- Leggings of the Fallen Hero
        ["29765"] = {29083, 29078, 28966,},

        -- Chestguard of the Fallen Champion
        ["29754"] = {29038, 29033, 29029, 29071, 29066, 29062, 29045,},

        -- Chestguard of the Fallen Defender
        ["29753"] = {29096, 29087, 29091, 29050, 29056, 29019, 29012,},

        -- Chestguard of the Fallen Hero
        ["29755"] = {29082, 29077, 28964,},

    --[[ TIER 5 ITEMS ]]
        -- Chestguard of the Vanquished Defender
        ["30237"] = {30216, 30231, 30150, 30222, 30118, 30113, 30237,},

        -- Chestguard of the Vanquished Hero
        ["30238"] = {30196, 30214, 30139,},

        -- Chestguard of the Vanquished Champion
        ["30236"] = {30129, 30144, 30169, 30164, 30134, 30123, 30185,},

        -- Leggings of the Vanquished Defender
        ["30246"] = {30220, 30234, 30153, 30229, 30162, 30116, 30121,},

        -- Leggings of the Vanquished Hero
        ["30247"] = {30207, 30213, 30142,},

        -- Leggings of the Vanquished Champion
        ["30245"] = {30137, 30148, 30172, 30167, 30132, 30126, 30192,},

        -- Helm of the Vanquished Defender
        ["30243"] = {30219, 30233, 30152, 30228, 30161, 30120, 30243,},

        -- Helm of the Vanquished Hero
        ["30244"] = {30206, 30212, 30141,},

        -- Helm of the Vanquished Champion
        ["30242"] = {30190, 30146, 30166, 30136, 30171, 30131, 30125,},

        -- Gloves of the Vanquished Defender
        ["30240"] = {30217, 30232, 30151, 30223, 30160, 30119, 30114,},

        -- Gloves of the Vanquished Hero
        ["30241"] = {30211, 30205, 30140,},

        -- Gloves of the Vanquished Champion
        ["30239"] = {30135, 30165, 30145, 30170, 30124, 30189, 30130,},

        -- Pauldrons of the Vanquished Defender
        ["30249"] = {30221, 30235, 30154, 30230, 30117, 30122, 30163,},

        -- Pauldrons of the Vanquished Hero
        ["30250"] = {30215, 30210, 30143,},

        -- Pauldrons of the Vanquished Champion
        ["30248"] = {30127, 30149, 30173, 30133, 30194, 30138, 30168,},
};