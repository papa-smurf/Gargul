---@type GL
local _, GL = ...;

---@class ItemLinks : Data
GL.Data = GL.Data or {};

GL.Data.ItemLinks = {
    -- Head of Onyxia (Horde)
    ["18422"] = {
        18423, -- Head of Onyxia (Alliance)
        18403, -- Dragonslayer's Signet
        18404, -- Onyxia Tooth Pendant
        18406, -- Onyxia Blood Talisman
    },
    -- Head of Onyxia (Alliance)
    ["18423"] = {
        18422, -- Head of Onyxia (Horde)
        18403, -- Dragonslayer's Signet
        18404, -- Onyxia Tooth Pendant
        18406, -- Onyxia Blood Talisman
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
        32386, -- Magtheridon's Head (Horde)
        28790, -- Naaru Lightwarden's Band
        28791, -- Ring of the Recalcitrant
        28792, -- A'dal's Signet of Defense
        28793, -- Band of Crimson Fury
    },
    -- Magtheridon's Head (Horde)
    ["32386"] = {
        32385, -- Magtheridon's Head (Alliance)
        28790, -- Naaru Lightwarden's Band
        28791, -- Ring of the Recalcitrant
        28792, -- A'dal's Signet of Defense
        28793, -- Band of Crimson Fury
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
};