---@type GL
local _, GL = ...;

---@class ItemLinks : Data
GL.Data = GL.Data or {};

GL.Data.ItemLinks = {
    -- Head of Onyxia (Horde)
    ["18422"] = {
        18403, -- Dragonslayer's Signet
        18404, -- Onyxia Tooth Pendant
        18406, -- Onyxia Blood Talisman
        18423, -- Head of Onyxia (Alliance)
    },
    -- Head of Onyxia (Alliance)
    ["18423"] = {
        18403, -- Dragonslayer's Signet
        18404, -- Onyxia Tooth Pendant
        18406, -- Onyxia Blood Talisman
        18422, -- Head of Onyxia (Horde)
    },
    -- Head of Nefarian (Horde)
    ["19002"] = {
        19003, -- Head of Nefarian (Alliance)
        19366, -- Master Dragonslayer's Orb
        19383, -- Master Dragonslayer's Medallion
        19384, -- Master Dragonslayer's Ring
    },
    -- Head of Nefarian (Alliance)
    ["19003"] = {
        19002, -- Head of Nefarian (Horde)
        19366, -- Master Dragonslayer's Orb
        19383, -- Master Dragonslayer's Medallion
        19384, -- Master Dragonslayer's Ring
    },
    -- Primal Hakkari Kossack
    ["19723"] = {
        19822, -- Zandalar Vindicator's Breastplate
        20033, -- Zandalar Demoniac's Robe
        20034, -- Zandalar Illusionist's Robe
    },
    -- Primal Hakkari Girdle
    ["19719"] = {
        19823, -- Zandalar Vindicator's Belt
        19829, -- Zandalar Augur's Belt
        19835, -- Zandalar Madcap's Mantle
    },
    -- Primal Hakkari Armsplint
    ["19717"] = {
        19824, -- Zandalar Vindicator's Armguards
        19830, -- Zandalar Augur's Bracers
        19836, -- Zandalar Madcap's Bracers
    },
    -- Primal Hakkari Tabard
    ["19722"] = {
        19825, -- Zandalar Freethinker's Breastplate
        19828, -- Zandalar Augur's Hauberk
        19838, -- Zandalar Haruspex's Tunic
    },
    -- Primal Hakkari Shawl
    ["19721"] = {
        19826, -- Zandalar Freethinker's Belt
        19832, -- Zandalar Predator's Belt
        19845, -- Zandalar Illusionist's Mantle
    },
    -- Primal Hakkari Bindings
    ["19716"] = {
        19827, -- Zandalar Freethinker's Armguards
        19833, -- Zandalar Predator's Bracers
        19846, -- Zandalar Illusionist's Wraps
    },
    -- Primal Hakkari Aegis
    ["19724"] = {
        19831, -- Zandalar Predator's Mantle
        19834, -- Zandalar Madcap's Tunic
        19841, -- Zandalar Confessor's Mantle
    },
    -- Primal Hakkari Sash
    ["19720"] = {
        19839, -- Zandalar Haruspex's Belt
        19842, -- Zandalar Confessor's Bindings
        19849, -- Zandalar Demoniac's Mantle
    },
    -- Primal Hakkari Stanchion
    ["19718"] = {
        19840, -- Zandalar Haruspex's Bracers
        19843, -- Zandalar Confessor's Wraps
        19848, -- Zandalar Demoniac's Wraps
    },
    -- Heart of Hakkar
    ["19802"] = {
        19948, -- Zandalarian Hero Badge
        19949, -- Zandalarian Hero Medallion
        19950, -- Zandalarian Hero Charm
    },
    -- Vek'nilash's Circlet
    ["20926"] = {
        21329, -- Conqueror's Crown
        21337, -- Doomcaller's Circlet
        21347, -- Enigma Circlet
        21348, -- Tiara of the Oracle
    },
    -- Qiraji Bindings of Command
    ["20928"] = {
        21330, -- Conqueror's Spaulders
        21333, -- Conqueror's Greaves
        21349, -- Footwraps of the Oracle
        21350, -- Mantle of the Oracle
        21359, -- Deathdealer's Boots
        21361, -- Deathdealer's Spaulders
        21365, -- Striker's Footguards
        21367, -- Striker's Pauldrons
    },
    -- Carapace of the Old God
    ["20929"] = {
        21331, -- Conqueror's Breastplate
        21364, -- Deathdealer's Vest
        21370, -- Striker's Hauberk
        21374, -- Stormcaller's Hauberk
        21389, -- Avenger's Breastplate
    },
    -- Ouro's Intact Hide
    ["20927"] = {
        21332, -- Conqueror's Legguards
        21346, -- Enigma Leggings
        21352, -- Trousers of the Oracle
        21362, -- Deathdealer's Leggings
    },
    -- Husk of the Old God
    ["20933"] = {
        21334, -- Doomcaller's Robes
        21343, -- Enigma Robes
        21351, -- Vestments of the Oracle
        21357, -- Genesis Vest
    },
    -- Qiraji Bindings of Dominance
    ["20932"] = {
        21335, -- Doomcaller's Mantle
        21338, -- Doomcaller's Footwraps
        21344, -- Enigma Boots
        21345, -- Enigma Shoulderpads
        21354, -- Genesis Shoulderpads
        21355, -- Genesis Boots
        21373, -- Stormcaller's Footguards
        21376, -- Stormcaller's Pauldrons
        21388, -- Avenger's Greaves
        21391, -- Avenger's Pauldrons
    },
    -- Skin of the Great Sandworm
    ["20931"] = {
        21336, -- Doomcaller's Trousers
        21356, -- Genesis Trousers
        21368, -- Striker's Leggings
        21375, -- Stormcaller's Leggings
        21390, -- Avenger's Legguards
    },
    -- Vek'lor's Diadem
    ["20930"] = {
        21353, -- Genesis Helm
        21360, -- Deathdealer's Helm
        21366, -- Striker's Diadem
        21372, -- Stormcaller's Diadem
        21387, -- Avenger's Crown
    },
    -- Qiraji Spiked Hilt
    ["20886"] = {
        21392, -- Sickle of Unyielding Strength
        21395, -- Blade of Eternal Justice
        21398, -- Hammer of the Gathering Storm
        21401, -- Scythe of the Unseen Path
        21404, -- Dagger of Veiled Shadows
    },
    -- Qiraji Magisterial Ring
    ["20884"] = {
        21393, -- Signet of Unyielding Strength
        21396, -- Ring of Eternal Justice
        21399, -- Ring of the Gathering Storm
        21408, -- Band of Unending Life
        21414, -- Band of Vaulted Secrets
    },
    -- Qiraji Martial Drape
    ["20885"] = {
        21394, -- Drape of Unyielding Strength
        21406, -- Cloak of Veiled Shadows
        21412, -- Shroud of Infinite Wisdom
        21415, -- Drape of Vaulted Secrets
    },
    -- Qiraji Regal Drape
    ["20889"] = {
        21397, -- Cape of Eternal Justice
        21400, -- Cloak of the Gathering Storm
        21403, -- Cloak of the Unseen Path
        21409, -- Cloak of Unending Life
        21418, -- Shroud of Unspoken Names
    },
    -- Qiraji Ceremonial Ring
    ["20888"] = {
        21402, -- Signet of the Unseen Path
        21405, -- Band of Veiled Shadows
        21411, -- Ring of Infinite Wisdom
        21417, -- Ring of Unspoken Names
    },
    -- Qiraji Ornate Hilt
    ["20890"] = {
        21407, -- Mace of Unending Life
        21410, -- Gavel of Infinite Wisdom
        21413, -- Blade of Vaulted Secrets
        21416, -- Kris of Unspoken Names
    },
    -- Head of Ossirian the Unscarred
    ["21220"] = {
        21504, -- Charm of the Shifting Sands
        21505, -- Choker of the Shifting Sands
        21506, -- Pendant of the Shifting Sands
        21507, -- Amulet of the Shifting Sands
    },
    -- Eye of C'Thun
    ["21221"] = {
        21709, -- Ring of the Fallen God
        21710, -- Cloak of the Fallen God
        21712, -- Amulet of the Fallen God
    },
    -- Desecrated Breastplate
    ["22349"] = {
        22416, -- Dreadnaught Breastplate
        22476, -- Bonescythe Breastplate
    },
    -- Desecrated Legplates
    ["22352"] = {
        22417, -- Dreadnaught Legplates
        22477, -- Bonescythe Legplates
    },
    -- Desecrated Helmet
    ["22353"] = {
        22418, -- Dreadnaught Helmet
        22478, -- Bonescythe Helmet
    },
    -- Desecrated Pauldrons
    ["22354"] = {
        22419, -- Dreadnaught Pauldrons
        22479, -- Bonescythe Pauldrons
    },
    -- Desecrated Sabatons
    ["22358"] = {
        22420, -- Dreadnaught Sabatons
        22480, -- Bonescythe Sabatons
    },
    -- Desecrated Gauntlets
    ["22357"] = {
        22421, -- Dreadnaught Gauntlets
        22481, -- Bonescythe Gauntlets
    },
    -- Desecrated Waistguard
    ["22356"] = {
        22422, -- Dreadnaught Waistguard
        22482, -- Bonescythe Waistguard
    },
    -- Desecrated Bracers
    ["22355"] = {
        22423, -- Dreadnaught Bracers
        22483, -- Bonescythe Bracers
    },
    -- Desecrated Wristguards
    ["22362"] = {
        22424, -- Redemption Wristguards
        22443, -- Cryptstalker Wristguards
        22471, -- Earthshatter Wristguards
        22495, -- Dreamwalker Wristguards
    },
    -- Desecrated Tunic
    ["22350"] = {
        22425, -- Redemption Tunic
        22436, -- Cryptstalker Tunic
        22464, -- Earthshatter Tunic
        22488, -- Dreamwalker Tunic
    },
    -- Desecrated Handguards
    ["22364"] = {
        22426, -- Redemption Handguards
        22441, -- Cryptstalker Handguards
        22469, -- Earthshatter Handguards
        22493, -- Dreamwalker Handguards
    },
    -- Desecrated Legguards
    ["22359"] = {
        22427, -- Redemption Legguards
        22437, -- Cryptstalker Legguards
        22465, -- Earthshatter Legguards
        22489, -- Dreamwalker Legguards
    },
    -- Desecrated Headpiece
    ["22360"] = {
        22428, -- Redemption Headpiece
        22438, -- Cryptstalker Headpiece
        22466, -- Earthshatter Headpiece
        22490, -- Dreamwalker Headpiece
    },
    -- Desecrated Spaulders
    ["22361"] = {
        22429, -- Redemption Spaulders
        22439, -- Cryptstalker Spaulders
        22467, -- Earthshatter Spaulders
        22491, -- Dreamwalker Spaulders
    },
    -- Desecrated Boots
    ["22365"] = {
        22430, -- Redemption Boots
        22440, -- Cryptstalker Boots
        22468, -- Earthshatter Boots
        22492, -- Dreamwalker Boots
    },
    -- Desecrated Girdle
    ["22363"] = {
        22431, -- Redemption Girdle
        22442, -- Cryptstalker Girdle
        22470, -- Earthshatter Girdle
        22494, -- Dreamwalker Girdle
    },
    -- Desecrated Robe
    ["22351"] = {
        22496, -- Frostfire Robe
        22504, -- Plagueheart Robe
        22512, -- Robe of Faith
    },
    -- Desecrated Leggings
    ["22366"] = {
        22497, -- Frostfire Leggings
        22505, -- Plagueheart Leggings
        22513, -- Leggings of Faith
    },
    -- Desecrated Circlet
    ["22367"] = {
        22498, -- Frostfire Circlet
        22506, -- Plagueheart Circlet
        22514, -- Circlet of Faith
    },
    -- Desecrated Shoulderpads
    ["22368"] = {
        22499, -- Frostfire Shoulderpads
        22507, -- Plagueheart Shoulderpads
        22515, -- Shoulderpads of Faith
    },
    -- Desecrated Sandals
    ["22372"] = {
        22500, -- Frostfire Sandals
        22508, -- Plagueheart Sandals
        22516, -- Sandals of Faith
    },
    -- Desecrated Gloves
    ["22371"] = {
        22501, -- Frostfire Gloves
        22509, -- Plagueheart Gloves
        22517, -- Gloves of Faith
    },
    -- Desecrated Belt
    ["22370"] = {
        22502, -- Frostfire Belt
        22510, -- Plagueheart Belt
        22518, -- Belt of Faith
    },
    -- Desecrated Bindings
    ["22369"] = {
        22503, -- Frostfire Bindings
        22511, -- Plagueheart Bindings
        22519, -- Bindings of Faith
    },
    -- Splinter of Atiesh
    ["22726"] = {
        22589, -- Atiesh, Greatstaff of the Guardian (mage)
        22630, -- Atiesh, Greatstaff of the Guardian (warlock)
        22631, -- Atiesh, Greatstaff of the Guardian (priest)
        22632, -- Atiesh, Greatstaff of the Guardian (druid)
    },
    -- The Phylactery of Kel'Thuzad
    ["22520"] = {
        23206, -- Mark of the Champion
        23207, -- Mark of the Champion
    },
    -- Plans: Fel Edged Battleaxe
    ["23631"] = {
        23542, -- Fel Edged Battleaxe
    },
    -- Magtheridon's Head (Alliance)
    ["32385"] = {
        28790, -- Naaru Lightwarden's Band
        28791, -- Ring of the Recalcitrant
        28792, -- A'dal's Signet of Defense
        28793, -- Band of Crimson Fury
        32386, -- Magtheridon's Head (Horde)
    },
    -- Magtheridon's Head (Horde)
    ["32386"] = {
        28790, -- Naaru Lightwarden's Band
        28791, -- Ring of the Recalcitrant
        28792, -- A'dal's Signet of Defense
        28793, -- Band of Crimson Fury
        32385, -- Magtheridon's Head (Alliance)
    },
    -- Helm of the Fallen Hero
    ["29759"] = {
        28963, -- Voidheart Crown
        29076, -- Collar of the Aldor
        29081, -- Demon Stalker Greathelm
    },
    -- Chestguard of the Fallen Hero
    ["29755"] = {
        28964, -- Voidheart Robe
        29077, -- Vestments of the Aldor
        29082, -- Demon Stalker Harness
    },
    -- Leggings of the Fallen Hero
    ["29765"] = {
        28966, -- Voidheart Leggings
        29078, -- Legwraps of the Aldor
        29083, -- Demon Stalker Greaves
    },
    -- Pauldrons of the Fallen Hero
    ["29762"] = {
        28967, -- Voidheart Mantle
        29079, -- Pauldrons of the Aldor
        29084, -- Demon Stalker Shoulderguards
    },
    -- Gloves of the Fallen Hero
    ["29756"] = {
        28968, -- Voidheart Gloves
        29080, -- Gloves of the Aldor
        29085, -- Demon Stalker Gauntlets
    },
    -- Helm of the Fallen Defender
    ["29761"] = {
        29011, -- Warbringer Greathelm
        29021, -- Warbringer Battle-Helm
        29049, -- Light-Collar of the Incarnate
        29058, -- Soul-Collar of the Incarnate
        29086, -- Crown of Malorne
        29093, -- Antlers of Malorne
        29098, -- Stag-Helm of Malorne
    },
    -- Chestguard of the Fallen Defender
    ["29753"] = {
        29012, -- Warbringer Chestguard
        29019, -- Warbringer Breastplate
        29050, -- Robes of the Incarnate
        29056, -- Shroud of the Incarnate
        29087, -- Chestguard of Malorne
        29091, -- Chestpiece of Malorne
        29096, -- Breastplate of Malorne
    },
    -- Leggings of the Fallen Defender
    ["29767"] = {
        29015, -- Warbringer Legguards
        29022, -- Warbringer Greaves
        29053, -- Trousers of the Incarnate
        29059, -- Leggings of the Incarnate
        29088, -- Legguards of Malorne
        29094, -- Britches of Malorne
        29099, -- Greaves of Malorne
    },
    -- Pauldrons of the Fallen Defender
    ["29764"] = {
        29016, -- Warbringer Shoulderguards
        29023, -- Warbringer Shoulderplates
        29054, -- Light-Mantle of the Incarnate
        29060, -- Soul-Mantle of the Incarnate
        29089, -- Shoulderguards of Malorne
        29095, -- Pauldrons of Malorne
        29100, -- Mantle of Malorne
    },
    -- Gloves of the Fallen Defender
    ["29758"] = {
        29017, -- Warbringer Handguards
        29020, -- Warbringer Gauntlets
        29055, -- Handwraps of the Incarnate
        29057, -- Gloves of the Incarnate
        29090, -- Handguards of Malorne
        29092, -- Gloves of Malorne
        29097, -- Gauntlets of Malorne
    },
    -- Helm of the Fallen Champion
    ["29760"] = {
        29028, -- Cyclone Headdress
        29035, -- Cyclone Faceguard
        29040, -- Cyclone Helm
        29044, -- Netherblade Facemask
        29061, -- Justicar Diadem
        29068, -- Justicar Faceguard
        29073, -- Justicar Crown
    },
    -- Chestguard of the Fallen Champion
    ["29754"] = {
        29029, -- Cyclone Hauberk
        29033, -- Cyclone Chestguard
        29038, -- Cyclone Breastplate
        29045, -- Netherblade Chestpiece
        29062, -- Justicar Chestpiece
        29066, -- Justicar Chestguard
        29071, -- Justicar Breastplate
    },
    -- Leggings of the Fallen Champion
    ["29766"] = {
        29030, -- Cyclone Kilt
        29036, -- Cyclone Legguards
        29042, -- Cyclone War-Kilt
        29046, -- Netherblade Breeches
        29063, -- Justicar Leggings
        29069, -- Justicar Legguards
        29074, -- Justicar Greaves
    },
    -- Pauldrons of the Fallen Champion
    ["29763"] = {
        29031, -- Cyclone Shoulderpads
        29037, -- Cyclone Shoulderguards
        29043, -- Cyclone Shoulderplates
        29047, -- Netherblade Shoulderpads
        29064, -- Justicar Pauldrons
        29070, -- Justicar Shoulderguards
        29075, -- Justicar Shoulderplates
    },
    -- Gloves of the Fallen Champion
    ["29757"] = {
        29032, -- Cyclone Gloves
        29034, -- Cyclone Handguards
        29039, -- Cyclone Gauntlets
        29048, -- Netherblade Gloves
        29065, -- Justicar Gloves
        29067, -- Justicar Handguards
        29072, -- Justicar Gauntlets
    },
    -- Verdant Sphere
    ["32405"] = {
        30007, -- The Darkener's Grasp
        30015, -- The Sun King's Talisman
        30017, -- Telonicus's Pendant of Mayhem
        30018, -- Lord Sanguinar's Claim
    },
    -- Plans: Red Havoc Boots
    ["30324"] = {
        30031, -- Red Havoc Boots
    },
    -- Plans: Red Belt of Battle
    ["30322"] = {
        30032, -- Red Belt of Battle
    },
    -- Plans: Boots of the Protector
    ["30323"] = {
        30033, -- Boots of the Protector
    },
    -- Plans: Belt of the Guardian
    ["30321"] = {
        30034, -- Belt of the Guardian
    },
    -- Pattern: Boots of the Long Road
    ["30283"] = {
        30035, -- Boots of the Long Road
    },
    -- Pattern: Belt of the Long Road
    ["30281"] = {
        30036, -- Belt of the Long Road
    },
    -- Pattern: Boots of Blasting
    ["30282"] = {
        30037, -- Boots of Blasting
    },
    -- Pattern: Belt of Blasting
    ["30280"] = {
        30038, -- Belt of Blasting
    },
    -- Pattern: Boots of Utter Darkness
    ["30306"] = {
        30039, -- Boots of Utter Darkness
    },
    -- Pattern: Belt of Deep Shadow
    ["30302"] = {
        30040, -- Belt of Deep Shadow
    },
    -- Pattern: Boots of Natural Grace
    ["30305"] = {
        30041, -- Boots of Natural Grace
    },
    -- Pattern: Belt of Natural Power
    ["30301"] = {
        30042, -- Belt of Natural Power
    },
    -- Pattern: Hurricane Boots
    ["30308"] = {
        30043, -- Hurricane Boots
    },
    -- Pattern: Monsoon Belt
    ["30304"] = {
        30044, -- Monsoon Belt
    },
    -- Pattern: Boots of the Crimson Hawk
    ["30307"] = {
        30045, -- Boots of the Crimson Hawk
    },
    -- Pattern: Belt of the Black Eagle
    ["30303"] = {
        30046, -- Belt of the Black Eagle
    },
    -- Chestguard of the Vanquished Defender
    ["30237"] = {
        30113, -- Destroyer Chestguard
        30118, -- Destroyer Breastplate
        30150, -- Vestments of the Avatar
        30159, -- Shroud of the Avatar
        30216, -- Nordrassil Chestguard
        30222, -- Nordrassil Chestplate
        30231, -- Nordrassil Chestpiece
    },
    -- Gloves of the Vanquished Defender
    ["30240"] = {
        30114, -- Destroyer Handguards
        30119, -- Destroyer Gauntlets
        30151, -- Gloves of the Avatar
        30160, -- Handguards of the Avatar
        30217, -- Nordrassil Gloves
        30223, -- Nordrassil Handgrips
        30232, -- Nordrassil Gauntlets
    },
    -- Helm of the Vanquished Defender
    ["30243"] = {
        30115, -- Destroyer Greathelm
        30120, -- Destroyer Battle-Helm
        30152, -- Cowl of the Avatar
        30161, -- Hood of the Avatar
        30219, -- Nordrassil Headguard
        30228, -- Nordrassil Headdress
        30233, -- Nordrassil Headpiece
    },
    -- Leggings of the Vanquished Defender
    ["30246"] = {
        30116, -- Destroyer Legguards
        30121, -- Destroyer Greaves
        30153, -- Breeches of the Avatar
        30162, -- Leggings of the Avatar
        30220, -- Nordrassil Life-Kilt
        30229, -- Nordrassil Feral-Kilt
        30234, -- Nordrassil Wrath-Kilt
    },
    -- Pauldrons of the Vanquished Defender
    ["30249"] = {
        30117, -- Destroyer Shoulderguards
        30122, -- Destroyer Shoulderblades
        30154, -- Mantle of the Avatar
        30163, -- Wings of the Avatar
        30221, -- Nordrassil Life-Mantle
        30230, -- Nordrassil Feral-Mantle
        30235, -- Nordrassil Wrath-Mantle
    },
    -- Chestguard of the Vanquished Champion
    ["30236"] = {
        30123, -- Crystalforge Chestguard
        30129, -- Crystalforge Breastplate
        30134, -- Crystalforge Chestpiece
        30144, -- Deathmantle Chestguard
        30164, -- Cataclysm Chestguard
        30169, -- Cataclysm Chestpiece
        30185, -- Cataclysm Chestplate
    },
    -- Gloves of the Vanquished Champion
    ["30239"] = {
        30124, -- Crystalforge Handguards
        30130, -- Crystalforge Gauntlets
        30135, -- Crystalforge Gloves
        30145, -- Deathmantle Handguards
        30165, -- Cataclysm Gloves
        30170, -- Cataclysm Handgrips
        30189, -- Cataclysm Gauntlets
    },
    -- Helm of the Vanquished Champion
    ["30242"] = {
        30125, -- Crystalforge Faceguard
        30131, -- Crystalforge War-Helm
        30136, -- Crystalforge Greathelm
        30146, -- Deathmantle Helm
        30166, -- Cataclysm Headguard
        30171, -- Cataclysm Headpiece
        30190, -- Cataclysm Helm
    },
    -- Leggings of the Vanquished Champion
    ["30245"] = {
        30126, -- Crystalforge Legguards
        30132, -- Crystalforge Greaves
        30137, -- Crystalforge Leggings
        30148, -- Deathmantle Legguards
        30167, -- Cataclysm Legguards
        30172, -- Cataclysm Leggings
        30192, -- Cataclysm Legplates
    },
    -- Pauldrons of the Vanquished Champion
    ["30248"] = {
        30127, -- Crystalforge Shoulderguards
        30133, -- Crystalforge Shoulderbraces
        30138, -- Crystalforge Pauldrons
        30149, -- Deathmantle Shoulderpads
        30168, -- Cataclysm Shoulderguards
        30173, -- Cataclysm Shoulderpads
        30194, -- Cataclysm Shoulderplates
    },
    -- Chestguard of the Vanquished Hero
    ["30238"] = {
        30139, -- Rift Stalker Hauberk
        30196, -- Robes of Tirisfal
        30214, -- Robe of the Corruptor
    },
    -- Gloves of the Vanquished Hero
    ["30241"] = {
        30140, -- Rift Stalker Gauntlets
        30205, -- Gloves of Tirisfal
        30211, -- Gloves of the Corruptor
    },
    -- Helm of the Vanquished Hero
    ["30244"] = {
        30141, -- Rift Stalker Helm
        30206, -- Cowl of Tirisfal
        30212, -- Hood of the Corruptor
    },
    -- Leggings of the Vanquished Hero
    ["30247"] = {
        30142, -- Rift Stalker Leggings
        30207, -- Leggings of Tirisfal
        30213, -- Leggings of the Corruptor
    },
    -- Pauldrons of the Vanquished Hero
    ["30250"] = {
        30143, -- Rift Stalker Mantle
        30210, -- Mantle of Tirisfal
        30215, -- Mantle of the Corruptor
    },
    -- Gloves of the Forgotten Protector
    ["31094"] = {
        30969, -- Onslaught Gauntlets
        30970, -- Onslaught Handguards
        31001, -- Gronnstalker's Gloves
        31007, -- Skyshatter Gloves
        31008, -- Skyshatter Gauntlets
        31011, -- Skyshatter Grips
    },
    -- Helm of the Forgotten Protector
    ["31095"] = {
        30972, -- Onslaught Battle-Helm
        30974, -- Onslaught Greathelm
        31003, -- Gronnstalker's Helmet
        31012, -- Skyshatter Helmet
        31014, -- Skyshatter Headguard
        31015, -- Skyshatter Cover
    },
    -- Chestguard of the Forgotten Protector
    ["31091"] = {
        30975, -- Onslaught Breastplate
        30976, -- Onslaught Chestguard
        31004, -- Gronnstalker's Chestguard
        31016, -- Skyshatter Chestguard
        31017, -- Skyshatter Breastplate
        31018, -- Skyshatter Tunic
    },
    -- Leggings of the Forgotten Protector
    ["31100"] = {
        30977, -- Onslaught Greaves
        30978, -- Onslaught Legguards
        31005, -- Gronnstalker's Leggings
        31019, -- Skyshatter Leggings
        31020, -- Skyshatter Legguards
        31021, -- Skyshatter Pants
    },
    -- Pauldrons of the Forgotten Protector
    ["31103"] = {
        30979, -- Onslaught Shoulderblades
        30980, -- Onslaught Shoulderguards
        31006, -- Gronnstalker's Spaulders
        31022, -- Skyshatter Shoulderpads
        31023, -- Skyshatter Mantle
        31024, -- Skyshatter Pauldrons
    },
    -- Gloves of the Forgotten Conqueror
    ["31092"] = {
        30982, -- Lightbringer Gauntlets
        30983, -- Lightbringer Gloves
        30985, -- Lightbringer Handguards
        31050, -- Gloves of the Malefic
        31060, -- Gloves of Absolution
        31061, -- Handguards of Absolution
    },
    -- Helm of the Forgotten Conqueror
    ["31097"] = {
        30987, -- Lightbringer Faceguard
        30988, -- Lightbringer Greathelm
        30989, -- Lightbringer War-Helm
        31051, -- Hood of the Malefic
        31063, -- Cowl of Absolution
        31064, -- Hood of Absolution
    },
    -- Chestguard of the Forgotten Conqueror
    ["31089"] = {
        30990, -- Lightbringer Breastplate
        30991, -- Lightbringer Chestguard
        30992, -- Lightbringer Chestpiece
        31052, -- Robe of the Malefic
        31065, -- Shroud of Absolution
        31066, -- Vestments of Absolution
    },
    -- Leggings of the Forgotten Conqueror
    ["31098"] = {
        30993, -- Lightbringer Greaves
        30994, -- Lightbringer Leggings
        30995, -- Lightbringer Legguards
        31053, -- Leggings of the Malefic
        31067, -- Leggings of Absolution
        31068, -- Breeches of Absolution
    },
    -- Pauldrons of the Forgotten Conqueror
    ["31101"] = {
        30996, -- Lightbringer Pauldrons
        30997, -- Lightbringer Shoulderbraces
        30998, -- Lightbringer Shoulderguards
        31054, -- Mantle of the Malefic
        31069, -- Mantle of Absolution
        31070, -- Shoulderpads of Absolution
    },
    -- Gloves of the Forgotten Vanquisher
    ["31093"] = {
        31026, -- Slayer's Handguards
        31032, -- Thunderheart Gloves
        31034, -- Thunderheart Gauntlets
        31035, -- Thunderheart Handguards
        31055, -- Gloves of the Tempest
    },
    -- Helm of the Forgotten Vanquisher
    ["31096"] = {
        31027, -- Slayer's Helm
        31037, -- Thunderheart Helmet
        31039, -- Thunderheart Cover
        31040, -- Thunderheart Headguard
        31056, -- Cowl of the Tempest
    },
    -- Chestguard of the Forgotten Vanquisher
    ["31090"] = {
        31028, -- Slayer's Chestguard
        31041, -- Thunderheart Tunic
        31042, -- Thunderheart Chestguard
        31043, -- Thunderheart Vest
        31057, -- Robes of the Tempest
    },
    -- Leggings of the Forgotten Vanquisher
    ["31099"] = {
        31029, -- Slayer's Legguards
        31044, -- Thunderheart Leggings
        31045, -- Thunderheart Legguards
        31046, -- Thunderheart Pants
        31058, -- Leggings of the Tempest
    },
    -- Pauldrons of the Forgotten Vanquisher
    ["31102"] = {
        31030, -- Slayer's Shoulderpads
        31047, -- Thunderheart Spaulders
        31048, -- Thunderheart Pauldrons
        31049, -- Thunderheart Shoulderpads
        31059, -- Mantle of the Tempest
    },
    -- Plans: Swiftsteel Bracers
    ["32736"] = {
        32568, -- Swiftsteel Bracers
    },
    -- Plans: Swiftsteel Shoulders
    ["32737"] = {
        32570, -- Swiftsteel Shoulders
    },
    -- Plans: Dawnsteel Bracers
    ["32738"] = {
        32571, -- Dawnsteel Bracers
    },
    -- Plans: Dawnsteel Shoulders
    ["32739"] = {
        32573, -- Dawnsteel Shoulders
    },
    -- Pattern: Bindings of Lightning Reflexes
    ["32748"] = {
        32574, -- Bindings of Lightning Reflexes
    },
    -- Pattern: Shoulders of Lightning Reflexes
    ["32749"] = {
        32575, -- Shoulders of Lightning Reflexes
    },
    -- Pattern: Living Earth Bindings
    ["32750"] = {
        32577, -- Living Earth Bindings
    },
    -- Pattern: Living Earth Shoulders
    ["32751"] = {
        32579, -- Living Earth Shoulders
    },
    -- Pattern: Swiftstrike Bracers
    ["32746"] = {
        32580, -- Swiftstrike Bracers
    },
    -- Pattern: Swiftstrike Shoulders
    ["32747"] = {
        32581, -- Swiftstrike Shoulders
    },
    -- Pattern: Bracers of Renewed Life
    ["32744"] = {
        32582, -- Bracers of Renewed Life
    },
    -- Pattern: Shoulderpads of Renewed Life
    ["32745"] = {
        32583, -- Shoulderpads of Renewed Life
    },
    -- Pattern: Swiftheal Wraps
    ["32752"] = {
        32584, -- Swiftheal Wraps
    },
    -- Pattern: Swiftheal Mantle
    ["32753"] = {
        32585, -- Swiftheal Mantle
    },
    -- Pattern: Bracers of Nimble Thought
    ["32754"] = {
        32586, -- Bracers of Nimble Thought
    },
    -- Pattern: Mantle of Nimble Thought
    ["32755"] = {
        32587, -- Mantle of Nimble Thought
    },
    -- Schematic: Mayhem Projection Goggles
    ["35195"] = {
        34354, -- Mayhem Projection Goggles
    },
    -- Schematic: Lightning Etched Specs
    ["35193"] = {
        34355, -- Lightning Etched Specs
    },
    -- Schematic: Surestrike Goggles v3.0
    ["35194"] = {
        34356, -- Surestrike Goggles v3.0
    },
    -- Schematic: Hard Khorium Goggles
    ["35196"] = {
        34357, -- Hard Khorium Goggles
    },
    -- Pattern: Sunfire Robe
    ["35206"] = {
        34364, -- Sunfire Robe
    },
    -- Pattern: Robe of Eternal Light
    ["35207"] = {
        34365, -- Robe of Eternal Light
    },
    -- Pattern: Sunfire Handwraps
    ["35204"] = {
        34366, -- Sunfire Handwraps
    },
    -- Pattern: Hands of Eternal Light
    ["35205"] = {
        34367, -- Hands of Eternal Light
    },
    -- Pattern: Carapace of Sun and Shadow
    ["35218"] = {
        34369, -- Carapace of Sun and Shadow
    },
    -- Pattern: Gloves of Immortal Dusk
    ["35214"] = {
        34370, -- Gloves of Immortal Dusk
    },
    -- Pattern: Leather Chestguard of the Sun
    ["35216"] = {
        34371, -- Leather Chestguard of the Sun
    },
    -- Pattern: Leather Gauntlets of the Sun
    ["35212"] = {
        34372, -- Leather Gauntlets of the Sun
    },
    -- Pattern: Embrace of the Phoenix
    ["35217"] = {
        34373, -- Embrace of the Phoenix
    },
    -- Pattern: Fletcher's Gloves of the Phoenix
    ["35213"] = {
        34374, -- Fletcher's Gloves of the Phoenix
    },
    -- Pattern: Sun-Drenched Scale Chestguard
    ["35219"] = {
        34375, -- Sun-Drenched Scale Chestguard
    },
    -- Pattern: Sun-Drenched Scale Gloves
    ["35215"] = {
        34376, -- Sun-Drenched Scale Gloves
    },
    -- Plans: Hard Khorium Battleplate
    ["35211"] = {
        34377, -- Hard Khorium Battleplate
    },
    -- Plans: Hard Khorium Battlefists
    ["35209"] = {
        34378, -- Hard Khorium Battlefists
    },
    -- Plans: Sunblessed Breastplate
    ["35210"] = {
        34379, -- Sunblessed Breastplate
    },
    -- Plans: Sunblessed Gauntlets
    ["35208"] = {
        34380, -- Sunblessed Gauntlets
    },
    -- Felfury Legplates
    ["34180"] = {
        34381, -- Felstrength Legplates
    },
    -- Legplates of the Holy Juggernaut
    ["34167"] = {
        34382, -- Judicator's Legguards
    },
    -- Chain Links of the Tumultuous Storm
    ["34186"] = {
        34383, -- Kilt of Spiritual Reconstruction
    },
    -- Breeches of Natural Aggression
    ["34169"] = {
        34384, -- Breeches of Natural Splendor
    },
    -- Leggings of the Immortal Night
    ["34188"] = {
        34385, -- Leggings of the Immortal Beast
    },
    -- Pantaloons of Calming Strife
    ["34170"] = {
        34386, -- Pantaloons of Growing Strife
    },
    -- Pauldrons of Perseverance
    ["34192"] = {
        34388, -- Pauldrons of Berserking
    },
    -- Spaulders of the Thalassian Savior
    ["34193"] = {
        34389, -- Spaulders of the Thalassian Defender
    },
    -- Equilibrium Epaulets
    ["34208"] = {
        34390, -- Erupting Epaulets
    },
    -- Spaulders of Reclamation
    ["34209"] = {
        34391, -- Spaulders of Devastation
    },
    -- Shoulderpads of Vehemence
    ["34195"] = {
        34392, -- Demontooth Shoulderpads
    },
    -- Shawl of Wonderment
    ["34202"] = {
        34393, -- Shoulderpads of Knowledge's Pursuit
    },
    -- Warharness of Reckless Fury
    ["34215"] = {
        34394, -- Breastplate of Agony's Aversion
    },
    -- Heroic Judicator's Chestguard
    ["34216"] = {
        34395, -- Noble Judicator's Chestguard
    },
    -- Garments of Serene Shores
    ["34229"] = {
        34396, -- Garments of Crashing Shores
    },
    -- Harness of Carnal Instinct
    ["34211"] = {
        34397, -- Bladed Chaos Tunic
    },
    -- Sunglow Vest
    ["34212"] = {
        34398, -- Utopian Tunic of Elune
    },
    -- Robes of Faltered Light
    ["34233"] = {
        34399, -- Robes of Ghostly Hatred
    },
    -- Crown of Anasterian
    ["34345"] = {
        34400, -- Crown of Dath'Remar
    },
    -- Helm of Burning Righteousness
    ["34243"] = {
        34401, -- Helm of Uther's Resolve
    },
    -- Cowl of Gul'dan
    ["34332"] = {
        34402, -- Shroud of Chieftain Ner'zhul
    },
    -- Cover of Ursol the Wise
    ["34245"] = {
        34403, -- Cover of Ursoc the Mighty
    },
    -- Duplicitous Guise
    ["34244"] = {
        34404, -- Mask of the Fury Hunter
    },
    -- Cowl of Light's Purity
    ["34339"] = {
        34405, -- Helm of Arcane Purity
    },
    -- Handguards of the Dawn
    ["34342"] = {
        34406, -- Gloves of Tyri's Power
    },
    -- Tranquil Majesty Wraps
    ["34351"] = {
        34407, -- Tranquil Moonlight Wraps
    },
    -- Shadowed Gauntlets of Paroxysm
    ["34234"] = {
        34408, -- Gloves of the Forest Drifter
    },
    -- Gauntlets of the Ancient Shadowmoon
    ["34350"] = {
        34409, -- Gauntlets of the Ancient Frostwolf
    },
    -- Bracers of the Forgotten Conqueror
    ["34848"] = {
        34431, -- Lightbringer Bands
        34432, -- Lightbringer Bracers
        34433, -- Lightbringer Wristguards
        34434, -- Bracers of Absolution
        34435, -- Cuffs of Absolution
        34436, -- Bracers of the Malefic
    },
    -- Bracers of the Forgotten Protector
    ["34851"] = {
        34437, -- Skyshatter Bands
        34438, -- Skyshatter Bracers
        34439, -- Skyshatter Wristguards
        34441, -- Onslaught Bracers
        34442, -- Onslaught Wristguards
        34443, -- Gronnstalker's Bracers
    },
    -- Bracers of the Forgotten Vanquisher
    ["34852"] = {
        34444, -- Thunderheart Wristguards
        34445, -- Thunderheart Bracers
        34446, -- Thunderheart Bands
        34447, -- Bracers of the Tempest
        34448, -- Slayer's Bracers
    },
    -- Belt of the Forgotten Conqueror
    ["34853"] = {
        34485, -- Lightbringer Girdle
        34487, -- Lightbringer Belt
        34488, -- Lightbringer Waistguard
        34527, -- Belt of Absolution
        34528, -- Cord of Absolution
        34541, -- Belt of the Malefic
    },
    -- Belt of the Forgotten Protector
    ["34854"] = {
        34542, -- Skyshatter Cord
        34543, -- Skyshatter Belt
        34545, -- Skyshatter Girdle
        34546, -- Onslaught Belt
        34547, -- Onslaught Waistguard
        34549, -- Gronnstalker's Belt
    },
    -- Belt of the Forgotten Vanquisher
    ["34855"] = {
        34554, -- Thunderheart Belt
        34555, -- Thunderheart Cord
        34556, -- Thunderheart Waistguard
        34557, -- Belt of the Tempest
        34558, -- Slayer's Belt
    },
    -- Boots of the Forgotten Conqueror
    ["34856"] = {
        34559, -- Lightbringer Treads
        34560, -- Lightbringer Stompers
        34561, -- Lightbringer Boots
        34562, -- Boots of Absolution
        34563, -- Treads of Absolution
        34564, -- Boots of the Malefic
    },
    -- Boots of the Forgotten Protector
    ["34857"] = {
        34565, -- Skyshatter Boots
        34566, -- Skyshatter Treads
        34567, -- Skyshatter Greaves
        34568, -- Onslaught Boots
        34569, -- Onslaught Treads
        34570, -- Gronnstalker's Boots
    },
    -- Boots of the Forgotten Vanquisher
    ["34858"] = {
        34571, -- Thunderheart Boots
        34572, -- Thunderheart Footwraps
        34573, -- Thunderheart Treads
        34574, -- Boots of the Tempest
        34575, -- Slayer's Boots
    },
    -- Schematic: Annihilator Holo-Gogs
    ["35186"] = {
        34847, -- Annihilator Holo-Gogs
    },
    -- Schematic: Powerheal 9000 Lens
    ["35189"] = {
        35181, -- Powerheal 9000 Lens
    },
    -- Schematic: Hyper-Magnified Moon Specs
    ["35190"] = {
        35182, -- Hyper-Magnified Moon Specs
    },
    -- Schematic: Primal-Attuned Goggles
    ["35192"] = {
        35184, -- Primal-Attuned Goggles
    },
    -- Helm of the Lost Vanquisher
    ["40618"] = {
        39491, -- Heroes' Frostfire Circlet
        39531, -- Heroes' Dreamwalker Headpiece
        39545, -- Heroes' Dreamwalker Cover
        39553, -- Heroes' Dreamwalker Headguard
        39561, -- Heroes' Bonescythe Helmet
        39619, -- Heroes' Scourgeborne Helmet
        39625, -- Heroes' Scourgeborne Faceguard
    },
    -- Chestguard of the Lost Vanquisher
    ["40612"] = {
        39492, -- Heroes' Frostfire Robe
        39538, -- Heroes' Dreamwalker Robe
        39547, -- Heroes' Dreamwalker Vestments
        39554, -- Heroes' Dreamwalker Raiments
        39558, -- Heroes' Bonescythe Breastplate
        39617, -- Heroes' Scourgeborne Battleplate
        39623, -- Heroes' Scourgeborne Chestguard
    },
    -- Leggings of the Lost Vanquisher
    ["40621"] = {
        39493, -- Heroes' Frostfire Leggings
        39539, -- Heroes' Dreamwalker Leggings
        39546, -- Heroes' Dreamwalker Trousers
        39555, -- Heroes' Dreamwalker Legguards
        39564, -- Heroes' Bonescythe Legplates
        39620, -- Heroes' Scourgeborne Legplates
        39626, -- Heroes' Scourgeborne Legguards
    },
    -- Spaulders of the Lost Vanquisher
    ["40624"] = {
        39494, -- Heroes' Frostfire Shoulderpads
        39542, -- Heroes' Dreamwalker Spaulders
        39548, -- Heroes' Dreamwalker Mantle
        39556, -- Heroes' Dreamwalker Shoulderpads
        39565, -- Heroes' Bonescythe Pauldrons
        39621, -- Heroes' Scourgeborne Shoulderplates
        39627, -- Heroes' Scourgeborne Pauldrons
    },
    -- Gloves of the Lost Vanquisher
    ["40615"] = {
        39495, -- Heroes' Frostfire Gloves
        39543, -- Heroes' Dreamwalker Handguards
        39544, -- Heroes' Dreamwalker Gloves
        39557, -- Heroes' Dreamwalker Handgrips
        39560, -- Heroes' Bonescythe Gauntlets
        39618, -- Heroes' Scourgeborne Gauntlets
        39624, -- Heroes' Scourgeborne Handguards
    },
    -- Helm of the Lost Conqueror
    ["40616"] = {
        39496, -- Heroes' Plagueheart Circlet
        39514, -- Heroes' Crown of Faith
        39521, -- Heroes' Circlet of Faith
        39628, -- Heroes' Redemption Headpiece
        39635, -- Heroes' Redemption Helm
        39640, -- Heroes' Redemption Faceguard
    },
    -- Chestguard of the Lost Conqueror
    ["40610"] = {
        39497, -- Heroes' Plagueheart Robe
        39515, -- Heroes' Robe of Faith
        39523, -- Heroes' Raiments of Faith
        39629, -- Heroes' Redemption Tunic
        39633, -- Heroes' Redemption Chestpiece
        39638, -- Heroes' Redemption Breastplate
    },
    -- Leggings of the Lost Conqueror
    ["40619"] = {
        39498, -- Heroes' Plagueheart Leggings
        39517, -- Heroes' Leggings of Faith
        39528, -- Heroes' Pants of Faith
        39630, -- Heroes' Redemption Greaves
        39636, -- Heroes' Redemption Legplates
        39641, -- Heroes' Redemption Legguards
    },
    -- Spaulders of the Lost Conqueror
    ["40622"] = {
        39499, -- Heroes' Plagueheart Shoulderpads
        39518, -- Heroes' Shoulderpads of Faith
        39529, -- Heroes' Mantle of Faith
        39631, -- Heroes' Redemption Spaulders
        39637, -- Heroes' Redemption Shoulderplates
        39642, -- Heroes' Redemption Shoulderguards
    },
    -- Gloves of the Lost Conqueror
    ["40613"] = {
        39500, -- Heroes' Plagueheart Gloves
        39519, -- Heroes' Gloves of Faith
        39530, -- Heroes' Handwraps of Faith
        39632, -- Heroes' Redemption Gloves
        39634, -- Heroes' Redemption Gauntlets
        39639, -- Heroes' Redemption Handguards
    },
    -- Helm of the Lost Protector
    ["40617"] = {
        39578, -- Heroes' Cryptstalker Headpiece
        39583, -- Heroes' Earthshatter Headpiece
        39594, -- Heroes' Earthshatter Helm
        39602, -- Heroes' Earthshatter Faceguard
        39605, -- Heroes' Dreadnaught Helmet
        39610, -- Heroes' Dreadnaught Greathelm
    },
    -- Chestguard of the Lost Protector
    ["40611"] = {
        39579, -- Heroes' Cryptstalker Tunic
        39588, -- Heroes' Earthshatter Tunic
        39592, -- Heroes' Earthshatter Hauberk
        39597, -- Heroes' Earthshatter Chestguard
        39606, -- Heroes' Dreadnaught Battleplate
        39611, -- Heroes' Dreadnaught Breastplate
    },
    -- Leggings of the Lost Protector
    ["40620"] = {
        39580, -- Heroes' Cryptstalker Legguards
        39589, -- Heroes' Earthshatter Legguards
        39595, -- Heroes' Earthshatter Kilt
        39603, -- Heroes' Earthshatter War-Kilt
        39607, -- Heroes' Dreadnaught Legplates
        39612, -- Heroes' Dreadnaught Legguards
    },
    -- Spaulders of the Lost Protector
    ["40623"] = {
        39581, -- Heroes' Cryptstalker Spaulders
        39590, -- Heroes' Earthshatter Spaulders
        39596, -- Heroes' Earthshatter Shoulderpads
        39604, -- Heroes' Earthshatter Shoulderguards
        39608, -- Heroes' Dreadnaught Shoulderplates
        39613, -- Heroes' Dreadnaught Pauldrons
    },
    -- Gloves of the Lost Protector
    ["40614"] = {
        39582, -- Heroes' Cryptstalker Handguards
        39591, -- Heroes' Earthshatter Handguards
        39593, -- Heroes' Earthshatter Gloves
        39601, -- Heroes' Earthshatter Grips
        39609, -- Heroes' Dreadnaught Gauntlets
        39622, -- Heroes' Dreadnaught Handguards
    },
    -- Gauntlets of the Lost Vanquisher
    ["40630"] = {
        40415, -- Valorous Frostfire Gloves
        40460, -- Valorous Dreamwalker Handguards
        40466, -- Valorous Dreamwalker Gloves
        40472, -- Valorous Dreamwalker Handgrips
        40496, -- Valorous Bonescythe Gauntlets
        40552, -- Valorous Scourgeborne Gauntlets
        40563, -- Valorous Scourgeborne Handguards
    },
    -- Crown of the Lost Vanquisher
    ["40633"] = {
        40416, -- Valorous Frostfire Circlet
        40461, -- Valorous Dreamwalker Headpiece
        40467, -- Valorous Dreamwalker Cover
        40473, -- Valorous Dreamwalker Headguard
        40499, -- Valorous Bonescythe Helmet
        40554, -- Valorous Scourgeborne Helmet
        40565, -- Valorous Scourgeborne Faceguard
    },
    -- Legplates of the Lost Vanquisher
    ["40636"] = {
        40417, -- Valorous Frostfire Leggings
        40462, -- Valorous Dreamwalker Leggings
        40468, -- Valorous Dreamwalker Trousers
        40493, -- Valorous Dreamwalker Legguards
        40500, -- Valorous Bonescythe Legplates
        40556, -- Valorous Scourgeborne Legplates
        40567, -- Valorous Scourgeborne Legguards
    },
    -- Breastplate of the Lost Vanquisher
    ["40627"] = {
        40418, -- Valorous Frostfire Robe
        40463, -- Valorous Dreamwalker Robe
        40469, -- Valorous Dreamwalker Vestments
        40471, -- Valorous Dreamwalker Raiments
        40495, -- Valorous Bonescythe Breastplate
        40550, -- Valorous Scourgeborne Battleplate
        40559, -- Valorous Scourgeborne Chestguard
    },
    -- Mantle of the Lost Vanquisher
    ["40639"] = {
        40419, -- Valorous Frostfire Shoulderpads
        40465, -- Valorous Dreamwalker Spaulders
        40470, -- Valorous Dreamwalker Mantle
        40494, -- Valorous Dreamwalker Shoulderpads
        40502, -- Valorous Bonescythe Pauldrons
        40557, -- Valorous Scourgeborne Shoulderplates
        40568, -- Valorous Scourgeborne Pauldrons
    },
    -- Gauntlets of the Lost Conqueror
    ["40628"] = {
        40420, -- Valorous Plagueheart Gloves
        40445, -- Valorous Gloves of Faith
        40454, -- Valorous Handwraps of Faith
        40570, -- Valorous Redemption Gloves
        40575, -- Valorous Redemption Gauntlets
        40580, -- Valorous Redemption Handguards
    },
    -- Crown of the Lost Conqueror
    ["40631"] = {
        40421, -- Valorous Plagueheart Circlet
        40447, -- Valorous Crown of Faith
        40456, -- Valorous Circlet of Faith
        40571, -- Valorous Redemption Headpiece
        40576, -- Valorous Redemption Helm
        40581, -- Valorous Redemption Faceguard
    },
    -- Legplates of the Lost Conqueror
    ["40634"] = {
        40422, -- Valorous Plagueheart Leggings
        40448, -- Valorous Leggings of Faith
        40457, -- Valorous Pants of Faith
        40572, -- Valorous Redemption Greaves
        40577, -- Valorous Redemption Legplates
        40583, -- Valorous Redemption Legguards
    },
    -- Breastplate of the Lost Conqueror
    ["40625"] = {
        40423, -- Valorous Plagueheart Robe
        40449, -- Valorous Robe of Faith
        40458, -- Valorous Raiments of Faith
        40569, -- Valorous Redemption Tunic
        40574, -- Valorous Redemption Chestpiece
        40579, -- Valorous Redemption Breastplate
    },
    -- Mantle of the Lost Conqueror
    ["40637"] = {
        40424, -- Valorous Plagueheart Shoulderpads
        40450, -- Valorous Shoulderpads of Faith
        40459, -- Valorous Mantle of Faith
        40573, -- Valorous Redemption Spaulders
        40578, -- Valorous Redemption Shoulderplates
        40584, -- Valorous Redemption Shoulderguards
    },
    -- Breastplate of the Lost Protector
    ["40626"] = {
        40503, -- Valorous Cryptstalker Tunic
        40508, -- Valorous Earthshatter Tunic
        40514, -- Valorous Earthshatter Hauberk
        40523, -- Valorous Earthshatter Chestguard
        40525, -- Valorous Dreadnaught Battleplate
        40544, -- Valorous Dreadnaught Breastplate
    },
    -- Gauntlets of the Lost Protector
    ["40629"] = {
        40504, -- Valorous Cryptstalker Handguards
        40509, -- Valorous Earthshatter Handguards
        40515, -- Valorous Earthshatter Gloves
        40520, -- Valorous Earthshatter Grips
        40527, -- Valorous Dreadnaught Gauntlets
        40545, -- Valorous Dreadnaught Handguards
    },
    -- Crown of the Lost Protector
    ["40632"] = {
        40505, -- Valorous Cryptstalker Headpiece
        40510, -- Valorous Earthshatter Headpiece
        40516, -- Valorous Earthshatter Helm
        40521, -- Valorous Earthshatter Faceguard
        40528, -- Valorous Dreadnaught Helmet
        40546, -- Valorous Dreadnaught Greathelm
    },
    -- Legplates of the Lost Protector
    ["40635"] = {
        40506, -- Valorous Cryptstalker Legguards
        40512, -- Valorous Earthshatter Legguards
        40517, -- Valorous Earthshatter Kilt
        40522, -- Valorous Earthshatter War-Kilt
        40529, -- Valorous Dreadnaught Legplates
        40547, -- Valorous Dreadnaught Legguards
    },
    -- Mantle of the Lost Protector
    ["40638"] = {
        40507, -- Valorous Cryptstalker Spaulders
        40513, -- Valorous Earthshatter Spaulders
        40518, -- Valorous Earthshatter Shoulderpads
        40524, -- Valorous Earthshatter Shoulderguards
        40530, -- Valorous Dreadnaught Shoulderplates
        40548, -- Valorous Dreadnaught Pauldrons
    },
    -- Heroic Key to the Focusing Iris
    ["44577"] = {
        44581, -- Heroic Key to the Focusing Iris
        44651, -- Heart of Magic (Heroic)
        44661, -- Wyrmrest Necklace of Power
        44662, -- Life-Binder's Locket
        44664, -- Favor of the Dragon Queen
        44665, -- Nexus War Champion Beads
    },
    -- Key to the Focusing Iris
    ["44569"] = {
        44582, -- Key to the Focusing Iris
        44650, -- Heart of Magic (Normal)
        44657, -- Torque of the Red Dragonflight
        44658, -- Chain of the Ancient Wyrm
        44659, -- Pendant of the Dragonsworn
        44660, -- Drakescale Collar
    },
    -- Fragment of Val'anyr
    ["45038"] = {
        45039, -- Shattered Fragments of Val'anyr
        45896, -- Unbound Fragments of Val'anyr
        45897, -- Reforged Hammer of Ancient Kings
        46017, -- Val'anyr, Hammer of Ancient Kings
    },
    -- Chestguard of the Wayward Vanquisher
    ["45637"] = {
        45335, -- Valorous Darkruned Chestguard
        45340, -- Valorous Darkruned Battleplate
        45348, -- Valorous Nightsong Robe
        45354, -- Valorous Nightsong Vestments
        45358, -- Valorous Nightsong Raiments
        45368, -- Valorous Kirin Tor Tunic
        45396, -- Valorous Terrorblade Breastplate
    },
    -- Helm of the Wayward Vanquisher
    ["45649"] = {
        45336, -- Valorous Darkruned Faceguard
        45342, -- Valorous Darkruned Helmet
        45346, -- Valorous Nightsong Headpiece
        45356, -- Valorous Nightsong Headguard
        45365, -- Valorous Kirin Tor Hood
        45398, -- Valorous Terrorblade Helmet
        46313, -- Valorous Nightsong Cover
    },
    -- Gloves of the Wayward Vanquisher
    ["45646"] = {
        45337, -- Valorous Darkruned Handguards
        45341, -- Valorous Darkruned Gauntlets
        45345, -- Valorous Nightsong Handguards
        45351, -- Valorous Nightsong Gloves
        45355, -- Valorous Nightsong Handgrips
        45397, -- Valorous Terrorblade Gauntlets
        46131, -- Valorous Kirin Tor Gauntlets
    },
    -- Leggings of the Wayward Vanquisher
    ["45652"] = {
        45338, -- Valorous Darkruned Legguards
        45343, -- Valorous Darkruned Legplates
        45347, -- Valorous Nightsong Leggings
        45353, -- Valorous Nightsong Trousers
        45357, -- Valorous Nightsong Legguards
        45367, -- Valorous Kirin Tor Leggings
        45399, -- Valorous Terrorblade Legplates
    },
    -- Spaulders of the Wayward Vanquisher
    ["45661"] = {
        45339, -- Valorous Darkruned Pauldrons
        45344, -- Valorous Darkruned Shoulderplates
        45349, -- Valorous Nightsong Spaulders
        45352, -- Valorous Nightsong Mantle
        45359, -- Valorous Nightsong Shoulderpads
        45369, -- Valorous Kirin Tor Shoulderpads
        45400, -- Valorous Terrorblade Pauldrons
    },
    -- Gloves of the Wayward Protector
    ["45645"] = {
        45360, -- Valorous Scourgestalker Handguards
        45401, -- Valorous Worldbreaker Handguards
        45406, -- Valorous Worldbreaker Gloves
        45414, -- Valorous Worldbreaker Grips
        45426, -- Valorous Siegebreaker Handguards
        45430, -- Valorous Siegebreaker Gauntlets
    },
    -- Helm of the Wayward Protector
    ["45648"] = {
        45361, -- Valorous Scourgestalker Headpiece
        45402, -- Valorous Worldbreaker Headpiece
        45408, -- Valorous Worldbreaker Helm
        45412, -- Valorous Worldbreaker Faceguard
        45425, -- Valorous Siegebreaker Greathelm
        45431, -- Valorous Siegebreaker Helmet
    },
    -- Leggings of the Wayward Protector
    ["45651"] = {
        45362, -- Valorous Scourgestalker Legguards
        45403, -- Valorous Worldbreaker Legguards
        45409, -- Valorous Worldbreaker Kilt
        45416, -- Valorous Worldbreaker War-Kilt
        45427, -- Valorous Siegebreaker Legguards
        45432, -- Valorous Siegebreaker Legplates
    },
    -- Spaulders of the Wayward Protector
    ["45660"] = {
        45363, -- Valorous Scourgestalker Spaulders
        45404, -- Valorous Worldbreaker Spaulders
        45410, -- Valorous Worldbreaker Shoulderpads
        45415, -- Valorous Worldbreaker Shoulderguards
        45428, -- Valorous Siegebreaker Pauldrons
        45433, -- Valorous Siegebreaker Shoulderplates
    },
    -- Chestguard of the Wayward Protector
    ["45636"] = {
        45364, -- Valorous Scourgestalker Tunic
        45405, -- Valorous Worldbreaker Tunic
        45411, -- Valorous Worldbreaker Hauberk
        45413, -- Valorous Worldbreaker Chestguard
        45424, -- Valorous Siegebreaker Breastplate
        45429, -- Valorous Siegebreaker Battleplate
    },
    -- Gloves of the Wayward Conqueror
    ["45644"] = {
        45370, -- Valorous Aegis Gloves
        45376, -- Valorous Aegis Gauntlets
        45383, -- Valorous Aegis Handguards
        45387, -- Valorous Gloves of Sanctification
        45392, -- Valorous Handwraps of Sanctification
        45419, -- Valorous Deathbringer Gloves
    },
    -- Leggings of the Wayward Conqueror
    ["45650"] = {
        45371, -- Valorous Aegis Greaves
        45379, -- Valorous Aegis Legplates
        45384, -- Valorous Aegis Legguards
        45388, -- Valorous Leggings of Sanctification
        45394, -- Valorous Pants of Sanctification
        45420, -- Valorous Deathbringer Leggings
    },
    -- Helm of the Wayward Conqueror
    ["45647"] = {
        45372, -- Valorous Aegis Headpiece
        45377, -- Valorous Aegis Helm
        45382, -- Valorous Aegis Faceguard
        45386, -- Valorous Cowl of Sanctification
        45391, -- Valorous Circlet of Sanctification
        45417, -- Valorous Deathbringer Hood
    },
    -- Spaulders of the Wayward Conqueror
    ["45659"] = {
        45373, -- Valorous Aegis Spaulders
        45380, -- Valorous Aegis Shoulderplates
        45385, -- Valorous Aegis Shoulderguards
        45390, -- Valorous Shoulderpads of Sanctification
        45393, -- Valorous Mantle of Sanctification
        45422, -- Valorous Deathbringer Shoulderpads
    },
    -- Chestguard of the Wayward Conqueror
    ["45635"] = {
        45374, -- Valorous Aegis Tunic
        45375, -- Valorous Aegis Battleplate
        45381, -- Valorous Aegis Breastplate
        45389, -- Valorous Robe of Sanctification
        45395, -- Valorous Raiments of Sanctification
        45421, -- Valorous Deathbringer Robe
    },
    -- Runed Orb
    ["45087"] = {
        45550, -- Belt of the Titans
        45551, -- Indestructible Plate Girdle
        45552, -- Plate Girdle of Righteousness
        45553, -- Belt of Dragons
        45554, -- Blue Belt of Chaos
        45555, -- Death-warmed Belt
        45556, -- Belt of Arctic Life
        45557, -- Sash of Ancient Power
        45558, -- Cord of the White Dawn
        45559, -- Battlelord's Plate Boots
        45560, -- Spiked Deathdealers
        45561, -- Treads of Destiny
        45562, -- Boots of Living Scale
        45563, -- Lightning Grounded Boots
        45564, -- Footpads of Silence
        45565, -- Boots of Wintry Endurance
        45566, -- Spellslinger's Slippers
        45567, -- Savior's Slippers
    },
    -- Breastplate of the Wayward Vanquisher
    ["45634"] = {
        46111, -- Conqueror's Darkruned Battleplate
        46118, -- Conqueror's Darkruned Chestguard
        46123, -- Conqueror's Terrorblade Breastplate
        46130, -- Conqueror's Kirin Tor Tunic
        46159, -- Conqueror's Nightsong Raiments
        46186, -- Conqueror's Nightsong Robe
        46194, -- Conqueror's Nightsong Vestments
    },
    -- Gauntlets of the Wayward Vanquisher
    ["45643"] = {
        46113, -- Conqueror's Darkruned Gauntlets
        46119, -- Conqueror's Darkruned Handguards
        46124, -- Conqueror's Terrorblade Gauntlets
        46132, -- Conqueror's Kirin Tor Gauntlets
        46158, -- Conqueror's Nightsong Handgrips
        46183, -- Conqueror's Nightsong Handguards
        46189, -- Conqueror's Nightsong Gloves
    },
    -- Crown of the Wayward Vanquisher
    ["45640"] = {
        46115, -- Conqueror's Darkruned Helmet
        46120, -- Conqueror's Darkruned Faceguard
        46125, -- Conqueror's Terrorblade Helmet
        46129, -- Conqueror's Kirin Tor Hood
        46161, -- Conqueror's Nightsong Headguard
        46184, -- Conqueror's Nightsong Headpiece
        46191, -- Conqueror's Nightsong Cover
    },
    -- Legplates of the Wayward Vanquisher
    ["45655"] = {
        46116, -- Conqueror's Darkruned Legplates
        46121, -- Conqueror's Darkruned Legguards
        46126, -- Conqueror's Terrorblade Legplates
        46133, -- Conqueror's Kirin Tor Leggings
        46160, -- Conqueror's Nightsong Legguards
        46185, -- Conqueror's Nightsong Leggings
        46192, -- Conqueror's Nightsong Trousers
    },
    -- Mantle of the Wayward Vanquisher
    ["45658"] = {
        46117, -- Conqueror's Darkruned Shoulderplates
        46122, -- Conqueror's Darkruned Pauldrons
        46127, -- Conqueror's Terrorblade Pauldrons
        46134, -- Conqueror's Kirin Tor Shoulderpads
        46157, -- Conqueror's Nightsong Shoulderpads
        46187, -- Conqueror's Nightsong Spaulders
        46196, -- Conqueror's Nightsong Mantle
    },
    -- Gauntlets of the Wayward Conqueror
    ["45641"] = {
        46135, -- Conqueror's Deathbringer Gloves
        46155, -- Conqueror's Aegis Gauntlets
        46163, -- Conqueror's Handwraps of Sanctification
        46174, -- Conqueror's Aegis Handguards
        46179, -- Conqueror's Aegis Gloves
        46188, -- Conqueror's Gloves of Sanctification
    },
    -- Mantle of the Wayward Conqueror
    ["45656"] = {
        46136, -- Conqueror's Deathbringer Shoulderpads
        46152, -- Conqueror's Aegis Shoulderplates
        46165, -- Conqueror's Mantle of Sanctification
        46177, -- Conqueror's Aegis Shoulderguards
        46182, -- Conqueror's Aegis Spaulders
        46190, -- Conqueror's Shoulderpads of Sanctification
    },
    -- Breastplate of the Wayward Conqueror
    ["45632"] = {
        46137, -- Conqueror's Deathbringer Robe
        46154, -- Conqueror's Aegis Battleplate
        46168, -- Conqueror's Raiments of Sanctification
        46173, -- Conqueror's Aegis Breastplate
        46178, -- Conqueror's Aegis Tunic
        46193, -- Conqueror's Robe of Sanctification
    },
    -- Legplates of the Wayward Conqueror
    ["45653"] = {
        46139, -- Conqueror's Deathbringer Leggings
        46153, -- Conqueror's Aegis Legplates
        46170, -- Conqueror's Pants of Sanctification
        46176, -- Conqueror's Aegis Legguards
        46181, -- Conqueror's Aegis Greaves
        46195, -- Conqueror's Leggings of Sanctification
    },
    -- Crown of the Wayward Conqueror
    ["45638"] = {
        46140, -- Conqueror's Deathbringer Hood
        46156, -- Conqueror's Aegis Helm
        46172, -- Conqueror's Circlet of Sanctification
        46175, -- Conqueror's Aegis Faceguard
        46180, -- Conqueror's Aegis Headpiece
        46197, -- Conqueror's Cowl of Sanctification
    },
    -- Breastplate of the Wayward Protector
    ["45633"] = {
        46141, -- Conqueror's Scourgestalker Tunic
        46146, -- Conqueror's Siegebreaker Battleplate
        46162, -- Conqueror's Siegebreaker Breastplate
        46198, -- Conqueror's Worldbreaker Tunic
        46205, -- Conqueror's Worldbreaker Chestguard
        46206, -- Conqueror's Worldbreaker Hauberk
    },
    -- Gauntlets of the Wayward Protector
    ["45642"] = {
        46142, -- Conqueror's Scourgestalker Handguards
        46148, -- Conqueror's Siegebreaker Gauntlets
        46164, -- Conqueror's Siegebreaker Handguards
        46199, -- Conqueror's Worldbreaker Handguards
        46200, -- Conqueror's Worldbreaker Grips
        46207, -- Conqueror's Worldbreaker Gloves
    },
    -- Crown of the Wayward Protector
    ["45639"] = {
        46143, -- Conqueror's Scourgestalker Headpiece
        46151, -- Conqueror's Siegebreaker Helmet
        46166, -- Conqueror's Siegebreaker Greathelm
        46201, -- Conqueror's Worldbreaker Headpiece
        46209, -- Conqueror's Worldbreaker Helm
        46212, -- Conqueror's Worldbreaker Faceguard
    },
    -- Legplates of the Wayward Protector
    ["45654"] = {
        46144, -- Conqueror's Scourgestalker Legguards
        46150, -- Conqueror's Siegebreaker Legplates
        46169, -- Conqueror's Siegebreaker Legguards
        46202, -- Conqueror's Worldbreaker Legguards
        46208, -- Conqueror's Worldbreaker War-Kilt
        46210, -- Conqueror's Worldbreaker Kilt
    },
    -- Mantle of the Wayward Protector
    ["45657"] = {
        46145, -- Conqueror's Scourgestalker Spaulders
        46149, -- Conqueror's Siegebreaker Shoulderplates
        46167, -- Conqueror's Siegebreaker Pauldrons
        46203, -- Conqueror's Worldbreaker Shoulderguards
        46204, -- Conqueror's Worldbreaker Spaulders
        46211, -- Conqueror's Worldbreaker Shoulderpads
    },
    -- Crusader Orb
    ["47556"] = {
        47570, -- Saronite Swordbreakers
        47571, -- Saronite Swordbreakers
        47572, -- Titanium Spikeguards
        47573, -- Titanium Spikeguards
        47574, -- Sunforged Bracers
        47575, -- Sunforged Bracers
        47576, -- Crusader's Dragonscale Bracers
        47577, -- Crusader's Dragonscale Bracers
        47579, -- Black Chitin Bracers
        47580, -- Black Chitin Bracers
        47581, -- Bracers of Swift Death
        47582, -- Bracers of Swift Death
        47583, -- Moonshadow Armguards
        47584, -- Moonshadow Armguards
        47585, -- Bejeweled Wizard's Bracers
        47586, -- Bejeweled Wizard's Bracers
        47587, -- Royal Moonshroud Bracers
        47588, -- Royal Moonshroud Bracers
        47589, -- Titanium Razorplate
        47590, -- Titanium Razorplate
        47591, -- Breastplate of the White Knight
        47592, -- Breastplate of the White Knight
        47593, -- Sunforged Breastplate
        47594, -- Sunforged Breastplate
        47595, -- Crusader's Dragonscale Breastplate
        47596, -- Crusader's Dragonscale Breastplate
        47597, -- Ensorcelled Nerubian Breastplate
        47598, -- Ensorcelled Nerubian Breastplate
        47599, -- Knightbane Carapace
        47600, -- Knightbane Carapace
        47601, -- Lunar Eclipse Robes
        47602, -- Lunar Eclipse Robes
        47603, -- Merlin's Robe
        47604, -- Merlin's Robe
        47605, -- Royal Moonshroud Robe
        47606, -- Royal Moonshroud Robe
    },
    -- Trophy of the Crusade
    ["47242"] = {
        47753, -- Khadgar's Gauntlets of Triumph
        47754, -- Khadgar's Hood of Triumph
        47755, -- Khadgar's Leggings of Triumph
        47756, -- Khadgar's Robe of Triumph
        47757, -- Khadgar's Shoulderpads of Triumph
        47768, -- Sunstrider's Shoulderpads of Triumph
        47769, -- Sunstrider's Robe of Triumph
        47770, -- Sunstrider's Leggings of Triumph
        47771, -- Sunstrider's Hood of Triumph
        47772, -- Sunstrider's Gauntlets of Triumph
        47778, -- Kel'Thuzad's Hood of Triumph
        47779, -- Kel'Thuzad's Robe of Triumph
        47780, -- Kel'Thuzad's Leggings of Triumph
        47781, -- Kel'Thuzad's Shoulderpads of Triumph
        47782, -- Kel'Thuzad's Gloves of Triumph
        47803, -- Gul'dan's Gloves of Triumph
        47804, -- Gul'dan's Hood of Triumph
        47805, -- Gul'dan's Leggings of Triumph
        47806, -- Gul'dan's Robe of Triumph
        47807, -- Gul'dan's Shoulderpads of Triumph
        47983, -- Velen's Gloves of Triumph
        47984, -- Velen's Cowl of Triumph
        47985, -- Velen's Leggings of Triumph
        47986, -- Velen's Robe of Triumph
        47987, -- Velen's Shoulderpads of Triumph
        48062, -- Zabra's Shoulderpads of Triumph
        48063, -- Zabra's Robe of Triumph
        48064, -- Zabra's Leggings of Triumph
        48065, -- Zabra's Cowl of Triumph
        48066, -- Zabra's Gloves of Triumph
        48077, -- Velen's Handwraps of Triumph
        48078, -- Velen's Circlet of Triumph
        48079, -- Velen's Pants of Triumph
        48080, -- Velen's Raiments of Triumph
        48081, -- Velen's Mantle of Triumph
        48092, -- Zabra's Mantle of Triumph
        48093, -- Zabra's Raiments of Triumph
        48094, -- Zabra's Pants of Triumph
        48095, -- Zabra's Circlet of Triumph
        48096, -- Zabra's Handwraps of Triumph
        48133, -- Malfurion's Handguards of Triumph
        48134, -- Malfurion's Headpiece of Triumph
        48135, -- Malfurion's Leggings of Triumph
        48136, -- Malfurion's Robe of Triumph
        48137, -- Malfurion's Spaulders of Triumph
        48148, -- Runetotem's Spaulders of Triumph
        48149, -- Runetotem's Robe of Triumph
        48150, -- Runetotem's Leggings of Triumph
        48151, -- Runetotem's Headpiece of Triumph
        48152, -- Runetotem's Handguards of Triumph
        48163, -- Malfurion's Gloves of Triumph
        48164, -- Malfurion's Cover of Triumph
        48165, -- Malfurion's Trousers of Triumph
        48166, -- Malfurion's Vestments of Triumph
        48167, -- Malfurion's Mantle of Triumph
        48178, -- Runetotem's Mantle of Triumph
        48179, -- Runetotem's Vestments of Triumph
        48180, -- Runetotem's Trousers of Triumph
        48181, -- Runetotem's Cover of Triumph
        48182, -- Runetotem's Gloves of Triumph
        48193, -- Runetotem's Handgrips of Triumph
        48194, -- Runetotem's Headguard of Triumph
        48195, -- Runetotem's Legguards of Triumph
        48196, -- Runetotem's Raiments of Triumph
        48197, -- Runetotem's Shoulderpads of Triumph
        48208, -- Malfurion's Shoulderpads of Triumph
        48209, -- Malfurion's Raiments of Triumph
        48210, -- Malfurion's Legguards of Triumph
        48211, -- Malfurion's Headguard of Triumph
        48212, -- Malfurion's Handgrips of Triumph
        48223, -- VanCleef's Breastplate of Triumph
        48224, -- VanCleef's Gauntlets of Triumph
        48225, -- VanCleef's Helmet of Triumph
        48226, -- VanCleef's Legplates of Triumph
        48227, -- VanCleef's Pauldrons of Triumph
        48238, -- Garona's Pauldrons of Triumph
        48239, -- Garona's Legplates of Triumph
        48240, -- Garona's Helmet of Triumph
        48241, -- Garona's Gauntlets of Triumph
        48242, -- Garona's Breastplate of Triumph
        48255, -- Windrunner's Tunic of Triumph
        48256, -- Windrunner's Handguards of Triumph
        48257, -- Windrunner's Headpiece of Triumph
        48258, -- Windrunner's Legguards of Triumph
        48259, -- Windrunner's Spaulders of Triumph
        48270, -- Windrunner's Spaulders of Triumph
        48271, -- Windrunner's Legguards of Triumph
        48272, -- Windrunner's Headpiece of Triumph
        48273, -- Windrunner's Handguards of Triumph
        48274, -- Windrunner's Tunic of Triumph
        48285, -- Nobundo's Tunic of Triumph
        48286, -- Nobundo's Handguards of Triumph
        48287, -- Nobundo's Headpiece of Triumph
        48288, -- Nobundo's Legguards of Triumph
        48289, -- Nobundo's Spaulders of Triumph
        48300, -- Thrall's Tunic of Triumph
        48301, -- Thrall's Handguards of Triumph
        48302, -- Thrall's Headpiece of Triumph
        48303, -- Thrall's Legguards of Triumph
        48304, -- Thrall's Spaulders of Triumph
        48316, -- Nobundo's Hauberk of Triumph
        48317, -- Nobundo's Gloves of Triumph
        48318, -- Nobundo's Helm of Triumph
        48319, -- Nobundo's Kilt of Triumph
        48320, -- Nobundo's Shoulderpads of Triumph
        48331, -- Thrall's Shoulderpads of Triumph
        48332, -- Thrall's Kilt of Triumph
        48333, -- Thrall's Helm of Triumph
        48334, -- Thrall's Gloves of Triumph
        48335, -- Thrall's Hauberk of Triumph
        48346, -- Nobundo's Chestguard of Triumph
        48347, -- Nobundo's Grips of Triumph
        48348, -- Nobundo's Faceguard of Triumph
        48349, -- Nobundo's War-Kilt of Triumph
        48350, -- Nobundo's Shoulderguards of Triumph
        48361, -- Thrall's Shoulderguards of Triumph
        48362, -- Thrall's War-Kilt of Triumph
        48363, -- Thrall's Faceguard of Triumph
        48364, -- Thrall's Grips of Triumph
        48365, -- Thrall's Chestguard of Triumph
        48376, -- Wrynn's Battleplate of Triumph
        48377, -- Wrynn's Gauntlets of Triumph
        48378, -- Wrynn's Helmet of Triumph
        48379, -- Wrynn's Legplates of Triumph
        48380, -- Wrynn's Shoulderplates of Triumph
        48391, -- Hellscream's Battleplate of Triumph
        48392, -- Hellscream's Gauntlets of Triumph
        48393, -- Hellscream's Helmet of Triumph
        48394, -- Hellscream's Legplates of Triumph
        48395, -- Hellscream's Shoulderplates of Triumph
        48430, -- Wrynn's Greathelm of Triumph
        48446, -- Wrynn's Legguards of Triumph
        48450, -- Wrynn's Breastplate of Triumph
        48452, -- Wrynn's Handguards of Triumph
        48454, -- Wrynn's Pauldrons of Triumph
        48461, -- Hellscream's Breastplate of Triumph
        48462, -- Hellscream's Handguards of Triumph
        48463, -- Hellscream's Greathelm of Triumph
        48464, -- Hellscream's Legguards of Triumph
        48465, -- Hellscream's Pauldrons of Triumph
        48481, -- Thassarian's Battleplate of Triumph
        48482, -- Thassarian's Gauntlets of Triumph
        48483, -- Thassarian's Helmet of Triumph
        48484, -- Thassarian's Legplates of Triumph
        48485, -- Thassarian's Shoulderplates of Triumph
        48496, -- Koltira's Shoulderplates of Triumph
        48497, -- Koltira's Legplates of Triumph
        48498, -- Koltira's Helmet of Triumph
        48499, -- Koltira's Gauntlets of Triumph
        48500, -- Koltira's Battleplate of Triumph
        48538, -- Thassarian's Chestguard of Triumph
        48539, -- Thassarian's Handguards of Triumph
        48540, -- Thassarian's Faceguard of Triumph
        48541, -- Thassarian's Legguards of Triumph
        48542, -- Thassarian's Pauldrons of Triumph
        48553, -- Koltira's Pauldrons of Triumph
        48554, -- Koltira's Legguards of Triumph
        48555, -- Koltira's Faceguard of Triumph
        48556, -- Koltira's Handguards of Triumph
        48557, -- Koltira's Chestguard of Triumph
        48575, -- Turalyon's Tunic of Triumph
        48576, -- Turalyon's Gloves of Triumph
        48577, -- Turalyon's Headpiece of Triumph
        48578, -- Turalyon's Greaves of Triumph
        48579, -- Turalyon's Spaulders of Triumph
        48590, -- Liadrin's Spaulders of Triumph
        48591, -- Liadrin's Greaves of Triumph
        48592, -- Liadrin's Headpiece of Triumph
        48593, -- Liadrin's Gloves of Triumph
        48594, -- Liadrin's Tunic of Triumph
        48607, -- Turalyon's Battleplate of Triumph
        48608, -- Turalyon's Gauntlets of Triumph
        48609, -- Turalyon's Helm of Triumph
        48610, -- Turalyon's Legplates of Triumph
        48611, -- Turalyon's Shoulderplates of Triumph
        48622, -- Liadrin's Shoulderplates of Triumph
        48623, -- Liadrin's Legplates of Triumph
        48624, -- Liadrin's Helm of Triumph
        48625, -- Liadrin's Gauntlets of Triumph
        48626, -- Liadrin's Battleplate of Triumph
        48637, -- Turalyon's Shoulderguards of Triumph
        48638, -- Turalyon's Legguards of Triumph
        48639, -- Turalyon's Faceguard of Triumph
        48640, -- Turalyon's Handguards of Triumph
        48641, -- Turalyon's Breastplate of Triumph
        48657, -- Liadrin's Breastplate of Triumph
        48658, -- Liadrin's Handguards of Triumph
        48659, -- Liadrin's Faceguard of Triumph
        48660, -- Liadrin's Legguards of Triumph
        48661, -- Liadrin's Shoulderguards of Triumph
    },
    -- Regalia of the Grand Vanquisher
    ["47559"] = {
        47758, -- Khadgar's Shoulderpads of Triumph
        47759, -- Khadgar's Robe of Triumph
        47760, -- Khadgar's Leggings of Triumph
        47761, -- Khadgar's Hood of Triumph
        47762, -- Khadgar's Gauntlets of Triumph
        47763, -- Sunstrider's Gauntlets of Triumph
        47764, -- Sunstrider's Hood of Triumph
        47765, -- Sunstrider's Leggings of Triumph
        47766, -- Sunstrider's Robe of Triumph
        47767, -- Sunstrider's Shoulderpads of Triumph
        48138, -- Malfurion's Spaulders of Triumph
        48139, -- Malfurion's Robe of Triumph
        48140, -- Malfurion's Leggings of Triumph
        48141, -- Malfurion's Headpiece of Triumph
        48142, -- Malfurion's Handguards of Triumph
        48143, -- Runetotem's Handguards of Triumph
        48144, -- Runetotem's Headpiece of Triumph
        48145, -- Runetotem's Leggings of Triumph
        48146, -- Runetotem's Robe of Triumph
        48147, -- Runetotem's Spaulders of Triumph
        48168, -- Malfurion's Mantle of Triumph
        48169, -- Malfurion's Vestments of Triumph
        48170, -- Malfurion's Trousers of Triumph
        48171, -- Malfurion's Cover of Triumph
        48172, -- Malfurion's Gloves of Triumph
        48173, -- Runetotem's Gloves of Triumph
        48174, -- Runetotem's Cover of Triumph
        48175, -- Runetotem's Trousers of Triumph
        48176, -- Runetotem's Vestments of Triumph
        48177, -- Runetotem's Mantle of Triumph
        48198, -- Runetotem's Shoulderpads of Triumph
        48199, -- Runetotem's Raiments of Triumph
        48200, -- Runetotem's Legguards of Triumph
        48201, -- Runetotem's Headguard of Triumph
        48202, -- Runetotem's Handgrips of Triumph
        48203, -- Malfurion's Handgrips of Triumph
        48204, -- Malfurion's Headguard of Triumph
        48205, -- Malfurion's Legguards of Triumph
        48206, -- Malfurion's Raiments of Triumph
        48207, -- Malfurion's Shoulderpads of Triumph
        48228, -- VanCleef's Pauldrons of Triumph
        48229, -- VanCleef's Legplates of Triumph
        48230, -- VanCleef's Helmet of Triumph
        48231, -- VanCleef's Gauntlets of Triumph
        48232, -- VanCleef's Breastplate of Triumph
        48233, -- Garona's Breastplate of Triumph
        48234, -- Garona's Gauntlets of Triumph
        48235, -- Garona's Helmet of Triumph
        48236, -- Garona's Legplates of Triumph
        48237, -- Garona's Pauldrons of Triumph
        48486, -- Thassarian's Shoulderplates of Triumph
        48487, -- Thassarian's Legplates of Triumph
        48488, -- Thassarian's Helmet of Triumph
        48489, -- Thassarian's Gauntlets of Triumph
        48490, -- Thassarian's Battleplate of Triumph
        48491, -- Koltira's Battleplate of Triumph
        48492, -- Koltira's Gauntlets of Triumph
        48493, -- Koltira's Helmet of Triumph
        48494, -- Koltira's Legplates of Triumph
        48495, -- Koltira's Shoulderplates of Triumph
        48543, -- Thassarian's Pauldrons of Triumph
        48544, -- Thassarian's Legguards of Triumph
        48545, -- Thassarian's Faceguard of Triumph
        48546, -- Thassarian's Handguards of Triumph
        48547, -- Thassarian's Chestguard of Triumph
        48548, -- Koltira's Chestguard of Triumph
        48549, -- Koltira's Handguards of Triumph
        48550, -- Koltira's Faceguard of Triumph
        48551, -- Koltira's Legguards of Triumph
        48552, -- Koltira's Pauldrons of Triumph
    },
    -- Regalia of the Grand Conqueror
    ["47557"] = {
        47788, -- Kel'Thuzad's Gloves of Triumph
        47789, -- Kel'Thuzad's Hood of Triumph
        47790, -- Kel'Thuzad's Leggings of Triumph
        47791, -- Kel'Thuzad's Robe of Triumph
        47792, -- Kel'Thuzad's Shoulderpads of Triumph
        47793, -- Gul'dan's Shoulderpads of Triumph
        47794, -- Gul'dan's Robe of Triumph
        47795, -- Gul'dan's Leggings of Triumph
        47796, -- Gul'dan's Hood of Triumph
        47797, -- Gul'dan's Gloves of Triumph
        48029, -- Velen's Shoulderpads of Triumph
        48031, -- Velen's Robe of Triumph
        48033, -- Velen's Leggings of Triumph
        48035, -- Velen's Cowl of Triumph
        48037, -- Velen's Gloves of Triumph
        48057, -- Zabra's Gloves of Triumph
        48058, -- Zabra's Cowl of Triumph
        48059, -- Zabra's Leggings of Triumph
        48060, -- Zabra's Robe of Triumph
        48061, -- Zabra's Shoulderpads of Triumph
        48082, -- Velen's Mantle of Triumph
        48083, -- Velen's Raiments of Triumph
        48084, -- Velen's Pants of Triumph
        48085, -- Velen's Circlet of Triumph
        48086, -- Velen's Handwraps of Triumph
        48087, -- Zabra's Handwraps of Triumph
        48088, -- Zabra's Circlet of Triumph
        48089, -- Zabra's Pants of Triumph
        48090, -- Zabra's Raiments of Triumph
        48091, -- Zabra's Mantle of Triumph
        48580, -- Turalyon's Spaulders of Triumph
        48581, -- Turalyon's Greaves of Triumph
        48582, -- Turalyon's Headpiece of Triumph
        48583, -- Turalyon's Gloves of Triumph
        48584, -- Turalyon's Tunic of Triumph
        48585, -- Liadrin's Spaulders of Triumph
        48586, -- Liadrin's Greaves of Triumph
        48587, -- Liadrin's Headpiece of Triumph
        48588, -- Liadrin's Gloves of Triumph
        48589, -- Liadrin's Tunic of Triumph
        48612, -- Turalyon's Shoulderplates of Triumph
        48613, -- Turalyon's Legplates of Triumph
        48614, -- Turalyon's Helm of Triumph
        48615, -- Turalyon's Gauntlets of Triumph
        48616, -- Turalyon's Battleplate of Triumph
        48617, -- Liadrin's Battleplate of Triumph
        48618, -- Liadrin's Gauntlets of Triumph
        48619, -- Liadrin's Helm of Triumph
        48620, -- Liadrin's Legplates of Triumph
        48621, -- Liadrin's Shoulderplates of Triumph
        48642, -- Turalyon's Breastplate of Triumph
        48643, -- Turalyon's Handguards of Triumph
        48644, -- Turalyon's Faceguard of Triumph
        48645, -- Turalyon's Legguards of Triumph
        48646, -- Turalyon's Shoulderguards of Triumph
        48647, -- Liadrin's Shoulderguards of Triumph
        48648, -- Liadrin's Legguards of Triumph
        48649, -- Liadrin's Faceguard of Triumph
        48650, -- Liadrin's Handguards of Triumph
        48651, -- Liadrin's Breastplate of Triumph
    },
    -- Regalia of the Grand Protector
    ["47558"] = {
        48260, -- Windrunner's Spaulders of Triumph
        48261, -- Windrunner's Legguards of Triumph
        48262, -- Windrunner's Headpiece of Triumph
        48263, -- Windrunner's Handguards of Triumph
        48264, -- Windrunner's Tunic of Triumph
        48265, -- Windrunner's Tunic of Triumph
        48266, -- Windrunner's Handguards of Triumph
        48267, -- Windrunner's Headpiece of Triumph
        48268, -- Windrunner's Legguards of Triumph
        48269, -- Windrunner's Spaulders of Triumph
        48290, -- Nobundo's Spaulders of Triumph
        48291, -- Nobundo's Legguards of Triumph
        48292, -- Nobundo's Headpiece of Triumph
        48293, -- Nobundo's Handguards of Triumph
        48294, -- Nobundo's Tunic of Triumph
        48305, -- Thrall's Tunic of Triumph
        48306, -- Thrall's Handguards of Triumph
        48307, -- Thrall's Headpiece of Triumph
        48308, -- Thrall's Legguards of Triumph
        48309, -- Thrall's Spaulders of Triumph
        48321, -- Nobundo's Shoulderpads of Triumph
        48322, -- Nobundo's Kilt of Triumph
        48323, -- Nobundo's Helm of Triumph
        48324, -- Nobundo's Gloves of Triumph
        48325, -- Nobundo's Hauberk of Triumph
        48326, -- Thrall's Hauberk of Triumph
        48327, -- Thrall's Gloves of Triumph
        48328, -- Thrall's Helm of Triumph
        48329, -- Thrall's Kilt of Triumph
        48330, -- Thrall's Shoulderpads of Triumph
        48351, -- Nobundo's Shoulderguards of Triumph
        48352, -- Nobundo's War-Kilt of Triumph
        48353, -- Nobundo's Faceguard of Triumph
        48354, -- Nobundo's Grips of Triumph
        48355, -- Nobundo's Chestguard of Triumph
        48356, -- Thrall's Chestguard of Triumph
        48357, -- Thrall's Grips of Triumph
        48358, -- Thrall's Faceguard of Triumph
        48359, -- Thrall's War-Kilt of Triumph
        48360, -- Thrall's Shoulderguards of Triumph
        48381, -- Wrynn's Shoulderplates of Triumph
        48382, -- Wrynn's Legplates of Triumph
        48383, -- Wrynn's Helmet of Triumph
        48384, -- Wrynn's Gauntlets of Triumph
        48385, -- Wrynn's Battleplate of Triumph
        48396, -- Hellscream's Battleplate of Triumph
        48397, -- Hellscream's Gauntlets of Triumph
        48398, -- Hellscream's Helmet of Triumph
        48399, -- Hellscream's Legplates of Triumph
        48400, -- Hellscream's Shoulderplates of Triumph
        48433, -- Wrynn's Greathelm of Triumph
        48447, -- Wrynn's Legguards of Triumph
        48451, -- Wrynn's Breastplate of Triumph
        48453, -- Wrynn's Handguards of Triumph
        48455, -- Wrynn's Pauldrons of Triumph
        48466, -- Hellscream's Breastplate of Triumph
        48467, -- Hellscream's Handguards of Triumph
        48468, -- Hellscream's Greathelm of Triumph
        48469, -- Hellscream's Legguards of Triumph
        48470, -- Hellscream's Pauldrons of Triumph
    },
    -- Shadowfrost Shard
    ["50274"] = {
        49623, -- Shadowmourne
    },
    -- Primordial Saronite
    ["49908"] = {
        49890, -- Deathfrost Boots
        49891, -- Leggings of Woven Death
        49892, -- Lightweave Leggings
        49893, -- Sandals of Consecration
        49894, -- Blessed Cenarion Boots
        49895, -- Footpads of Impending Death
        49896, -- Earthsoul Boots
        49897, -- Rock-Steady Treads
        49898, -- Legwraps of Unleashed Nature
        49899, -- Bladeborn Leggings
        49900, -- Lightning-Infused Leggings
        49901, -- Draconic Bonesplinter Legguards
        49902, -- Puresteel Legplates
        49903, -- Legplates of Painful Death
        49904, -- Pillars of Might
        49905, -- Protectors of Life
        49906, -- Hellfrozen Bonegrinders
        49907, -- Boots of Kingly Upheaval
        49953, -- Pattern: Leggings of Woven Death
        49954, -- Pattern: Deathfrost Boots
        49955, -- Pattern: Lightweave Leggings
        49956, -- Pattern: Sandals of Consecration
        49957, -- Pattern: Legwraps of Unleashed Nature
        49958, -- Pattern: Blessed Cenarion Boots
        49959, -- Pattern: Bladeborn Leggings
        49961, -- Pattern: Footpads of Impending Death
        49962, -- Pattern: Lightning-Infused Leggings
        49963, -- Pattern: Earthsoul Boots
        49965, -- Pattern: Draconic Bonesplinter Legguards
        49966, -- Pattern: Rock-Steady Treads
        49969, -- Plans: Puresteel Legplates
        49970, -- Plans: Protectors of Life
        49971, -- Plans: Legplates of Painful Death
        49972, -- Plans: Hellfrozen Bonegrinders
        49973, -- Plans: Pillars of Might
        49974, -- Plans: Boots of Kingly Upheaval
    },
    -- Vanquisher's Mark of Sanctification
    ["52025"] = {
        51125, -- Sanctified Scourgelord Shoulderplates
        51126, -- Sanctified Scourgelord Legplates
        51127, -- Sanctified Scourgelord Helmet
        51128, -- Sanctified Scourgelord Gauntlets
        51129, -- Sanctified Scourgelord Battleplate
        51130, -- Sanctified Scourgelord Pauldrons
        51131, -- Sanctified Scourgelord Legguards
        51132, -- Sanctified Scourgelord Handguards
        51133, -- Sanctified Scourgelord Faceguard
        51134, -- Sanctified Scourgelord Chestguard
        51135, -- Sanctified Lasherweave Pauldrons
        51136, -- Sanctified Lasherweave Legplates
        51137, -- Sanctified Lasherweave Helmet
        51138, -- Sanctified Lasherweave Gauntlets
        51139, -- Sanctified Lasherweave Robes
        51140, -- Sanctified Lasherweave Shoulderpads
        51141, -- Sanctified Lasherweave Raiment
        51142, -- Sanctified Lasherweave Legguards
        51143, -- Sanctified Lasherweave Headguard
        51144, -- Sanctified Lasherweave Handgrips
        51145, -- Sanctified Lasherweave Vestment
        51146, -- Sanctified Lasherweave Trousers
        51147, -- Sanctified Lasherweave Mantle
        51148, -- Sanctified Lasherweave Gloves
        51149, -- Sanctified Lasherweave Cover
        51155, -- Sanctified Bloodmage Shoulderpads
        51156, -- Sanctified Bloodmage Robe
        51157, -- Sanctified Bloodmage Leggings
        51158, -- Sanctified Bloodmage Hood
        51159, -- Sanctified Bloodmage Gloves
        51185, -- Sanctified Shadowblade Pauldrons
        51186, -- Sanctified Shadowblade Legplates
        51187, -- Sanctified Shadowblade Helmet
        51188, -- Sanctified Shadowblade Gauntlets
        51189, -- Sanctified Shadowblade Breastplate
    },
    -- Protector's Mark of Sanctification
    ["52026"] = {
        51150, -- Sanctified Ahn'Kahar Blood Hunter's Tunic
        51151, -- Sanctified Ahn'Kahar Blood Hunter's Spaulders
        51152, -- Sanctified Ahn'Kahar Blood Hunter's Legguards
        51153, -- Sanctified Ahn'Kahar Blood Hunter's Headpiece
        51154, -- Sanctified Ahn'Kahar Blood Hunter's Handguards
        51190, -- Sanctified Frost Witch's Tunic
        51191, -- Sanctified Frost Witch's Handguards
        51192, -- Sanctified Frost Witch's Headpiece
        51193, -- Sanctified Frost Witch's Legguards
        51194, -- Sanctified Frost Witch's Spaulders
        51195, -- Sanctified Frost Witch's Chestguard
        51196, -- Sanctified Frost Witch's Grips
        51197, -- Sanctified Frost Witch's Faceguard
        51198, -- Sanctified Frost Witch's War-Kilt
        51199, -- Sanctified Frost Witch's Shoulderguards
        51200, -- Sanctified Frost Witch's Hauberk
        51201, -- Sanctified Frost Witch's Gloves
        51202, -- Sanctified Frost Witch's Helm
        51203, -- Sanctified Frost Witch's Kilt
        51204, -- Sanctified Frost Witch's Shoulderpads
        51210, -- Sanctified Ymirjar Lord's Shoulderplates
        51211, -- Sanctified Ymirjar Lord's Legplates
        51212, -- Sanctified Ymirjar Lord's Helmet
        51213, -- Sanctified Ymirjar Lord's Gauntlets
        51214, -- Sanctified Ymirjar Lord's Battleplate
        51215, -- Sanctified Ymirjar Lord's Pauldrons
        51216, -- Sanctified Ymirjar Lord's Legguards
        51217, -- Sanctified Ymirjar Lord's Handguards
        51218, -- Sanctified Ymirjar Lord's Greathelm
        51219, -- Sanctified Ymirjar Lord's Breastplate
    },
    -- Conqueror's Mark of Sanctification
    ["52027"] = {
        51160, -- Sanctified Lightsworn Shoulderplates
        51161, -- Sanctified Lightsworn Legplates
        51162, -- Sanctified Lightsworn Helmet
        51163, -- Sanctified Lightsworn Gauntlets
        51164, -- Sanctified Lightsworn Battleplate
        51165, -- Sanctified Lightsworn Tunic
        51166, -- Sanctified Lightsworn Spaulders
        51167, -- Sanctified Lightsworn Headpiece
        51168, -- Sanctified Lightsworn Greaves
        51169, -- Sanctified Lightsworn Gloves
        51170, -- Sanctified Lightsworn Shoulderguards
        51171, -- Sanctified Lightsworn Legguards
        51172, -- Sanctified Lightsworn Handguards
        51173, -- Sanctified Lightsworn Faceguard
        51174, -- Sanctified Lightsworn Chestguard
        51175, -- Sanctified Crimson Acolyte Shoulderpads
        51176, -- Sanctified Crimson Acolyte Robe
        51177, -- Sanctified Crimson Acolyte Leggings
        51178, -- Sanctified Crimson Acolyte Hood
        51179, -- Sanctified Crimson Acolyte Gloves
        51180, -- Sanctified Crimson Acolyte Raiments
        51181, -- Sanctified Crimson Acolyte Pants
        51182, -- Sanctified Crimson Acolyte Mantle
        51183, -- Sanctified Crimson Acolyte Handwraps
        51184, -- Sanctified Crimson Acolyte Cowl
        51205, -- Sanctified Dark Coven Shoulderpads
        51206, -- Sanctified Dark Coven Robe
        51207, -- Sanctified Dark Coven Leggings
        51208, -- Sanctified Dark Coven Hood
        51209, -- Sanctified Dark Coven Gloves
    },
    -- Protector's Mark of Sanctification
    ["52029"] = {
        51220, -- Sanctified Ymirjar Lord's Breastplate
        51221, -- Sanctified Ymirjar Lord's Greathelm
        51222, -- Sanctified Ymirjar Lord's Handguards
        51223, -- Sanctified Ymirjar Lord's Legguards
        51224, -- Sanctified Ymirjar Lord's Pauldrons
        51225, -- Sanctified Ymirjar Lord's Battleplate
        51226, -- Sanctified Ymirjar Lord's Gauntlets
        51227, -- Sanctified Ymirjar Lord's Helmet
        51228, -- Sanctified Ymirjar Lord's Legplates
        51229, -- Sanctified Ymirjar Lord's Shoulderplates
        51235, -- Sanctified Frost Witch's Shoulderpads
        51236, -- Sanctified Frost Witch's Kilt
        51237, -- Sanctified Frost Witch's Helm
        51238, -- Sanctified Frost Witch's Gloves
        51239, -- Sanctified Frost Witch's Hauberk
        51240, -- Sanctified Frost Witch's Shoulderguards
        51241, -- Sanctified Frost Witch's War-Kilt
        51242, -- Sanctified Frost Witch's Faceguard
        51243, -- Sanctified Frost Witch's Grips
        51244, -- Sanctified Frost Witch's Chestguard
        51245, -- Sanctified Frost Witch's Spaulders
        51246, -- Sanctified Frost Witch's Legguards
        51247, -- Sanctified Frost Witch's Headpiece
        51248, -- Sanctified Frost Witch's Handguards
        51249, -- Sanctified Frost Witch's Tunic
        51285, -- Sanctified Ahn'Kahar Blood Hunter's Handguards
        51286, -- Sanctified Ahn'Kahar Blood Hunter's Headpiece
        51287, -- Sanctified Ahn'Kahar Blood Hunter's Legguards
        51288, -- Sanctified Ahn'Kahar Blood Hunter's Spaulders
        51289, -- Sanctified Ahn'Kahar Blood Hunter's Tunic
    },
    -- Conqueror's Mark of Sanctification
    ["52030"] = {
        51230, -- Sanctified Dark Coven Gloves
        51231, -- Sanctified Dark Coven Hood
        51232, -- Sanctified Dark Coven Leggings
        51233, -- Sanctified Dark Coven Robe
        51234, -- Sanctified Dark Coven Shoulderpads
        51255, -- Sanctified Crimson Acolyte Cowl
        51256, -- Sanctified Crimson Acolyte Handwraps
        51257, -- Sanctified Crimson Acolyte Mantle
        51258, -- Sanctified Crimson Acolyte Pants
        51259, -- Sanctified Crimson Acolyte Raiments
        51260, -- Sanctified Crimson Acolyte Gloves
        51261, -- Sanctified Crimson Acolyte Hood
        51262, -- Sanctified Crimson Acolyte Leggings
        51263, -- Sanctified Crimson Acolyte Robe
        51264, -- Sanctified Crimson Acolyte Shoulderpads
        51265, -- Sanctified Lightsworn Chestguard
        51266, -- Sanctified Lightsworn Faceguard
        51267, -- Sanctified Lightsworn Handguards
        51268, -- Sanctified Lightsworn Legguards
        51269, -- Sanctified Lightsworn Shoulderguards
        51270, -- Sanctified Lightsworn Gloves
        51271, -- Sanctified Lightsworn Greaves
        51272, -- Sanctified Lightsworn Headpiece
        51273, -- Sanctified Lightsworn Spaulders
        51274, -- Sanctified Lightsworn Tunic
        51275, -- Sanctified Lightsworn Battleplate
        51276, -- Sanctified Lightsworn Gauntlets
        51277, -- Sanctified Lightsworn Helmet
        51278, -- Sanctified Lightsworn Legplates
        51279, -- Sanctified Lightsworn Shoulderplates
    },
    -- Vanquisher's Mark of Sanctification
    ["52028"] = {
        51250, -- Sanctified Shadowblade Breastplate
        51251, -- Sanctified Shadowblade Gauntlets
        51252, -- Sanctified Shadowblade Helmet
        51253, -- Sanctified Shadowblade Legplates
        51254, -- Sanctified Shadowblade Pauldrons
        51280, -- Sanctified Bloodmage Gloves
        51281, -- Sanctified Bloodmage Hood
        51282, -- Sanctified Bloodmage Leggings
        51283, -- Sanctified Bloodmage Robe
        51284, -- Sanctified Bloodmage Shoulderpads
        51290, -- Sanctified Lasherweave Cover
        51291, -- Sanctified Lasherweave Gloves
        51292, -- Sanctified Lasherweave Mantle
        51293, -- Sanctified Lasherweave Trousers
        51294, -- Sanctified Lasherweave Vestment
        51295, -- Sanctified Lasherweave Handgrips
        51296, -- Sanctified Lasherweave Headguard
        51297, -- Sanctified Lasherweave Legguards
        51298, -- Sanctified Lasherweave Raiment
        51299, -- Sanctified Lasherweave Shoulderpads
        51300, -- Sanctified Lasherweave Robes
        51301, -- Sanctified Lasherweave Gauntlets
        51302, -- Sanctified Lasherweave Helmet
        51303, -- Sanctified Lasherweave Legplates
        51304, -- Sanctified Lasherweave Pauldrons
        51305, -- Sanctified Scourgelord Chestguard
        51306, -- Sanctified Scourgelord Faceguard
        51307, -- Sanctified Scourgelord Handguards
        51308, -- Sanctified Scourgelord Legguards
        51309, -- Sanctified Scourgelord Pauldrons
        51310, -- Sanctified Scourgelord Battleplate
        51311, -- Sanctified Scourgelord Gauntlets
        51312, -- Sanctified Scourgelord Helmet
        51313, -- Sanctified Scourgelord Legplates
        51314, -- Sanctified Scourgelord Shoulderplates
    },
};