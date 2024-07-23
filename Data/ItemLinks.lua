---@type GL
local _, GL = ...;

---@class ItemLinks : Data
GL.Data = GL.Data or {};

GL.Data.ItemLinks = {
    -- Head of Onyxia (Horde)
    ["49643"] = {
        49644, -- Head of Onyxia (Alliance)
    },
    -- Head of Onyxia (Alliance)
    ["49644"] = {
        49643, -- Head of Onyxia (Horde)
    },
    -- SoD Head of Onyxia (Horde)
    ["228689"] = {
        228688, -- SoD Head of Onyxia (Alliance)
    },
    -- Head of Onyxia (Alliance)
    ["228688"] = {
        228689, -- Head of Onyxia (Horde)
    },
    -- Dragonslayer's Signet
    ["18403"] = {
        18422, -- Head of Onyxia (Horde)
    },
    -- Onyxia Tooth Pendant
    ["18404"] = {
        18422, -- Head of Onyxia (Horde)
    },
    -- Onyxia Blood Talisman
    ["18406"] = {
        18422, -- Head of Onyxia (Horde)
    },
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
    -- Master Dragonslayer's Orb
    ["19366"] = {
        19002, -- Head of Nefarian (Horde)
    },
    -- Master Dragonslayer's Medallion
    ["19383"] = {
        19002, -- Head of Nefarian (Horde)
    },
    -- Master Dragonslayer's Ring
    ["19384"] = {
        19002, -- Head of Nefarian (Horde)
    },
    -- Primal Hakkari Bindings
    ["19716"] = {
        19827, -- Zandalar Freethinker's Armguards
        19833, -- Zandalar Predator's Bracers
        19846, -- Zandalar Illusionist's Wraps
    },
    -- Primal Hakkari Armsplint
    ["19717"] = {
        19824, -- Zandalar Vindicator's Armguards
        19830, -- Zandalar Augur's Bracers
        19836, -- Zandalar Madcap's Bracers
    },
    -- Primal Hakkari Stanchion
    ["19718"] = {
        19840, -- Zandalar Haruspex's Bracers
        19843, -- Zandalar Confessor's Wraps
        19848, -- Zandalar Demoniac's Wraps
    },
    -- Primal Hakkari Girdle
    ["19719"] = {
        19823, -- Zandalar Vindicator's Belt
        19829, -- Zandalar Augur's Belt
        19835, -- Zandalar Madcap's Mantle
    },
    -- Primal Hakkari Sash
    ["19720"] = {
        19839, -- Zandalar Haruspex's Belt
        19842, -- Zandalar Confessor's Bindings
        19849, -- Zandalar Demoniac's Mantle
    },
    -- Primal Hakkari Shawl
    ["19721"] = {
        19826, -- Zandalar Freethinker's Belt
        19832, -- Zandalar Predator's Belt
        19845, -- Zandalar Illusionist's Mantle
    },
    -- Primal Hakkari Tabard
    ["19722"] = {
        19825, -- Zandalar Freethinker's Breastplate
        19828, -- Zandalar Augur's Hauberk
        19838, -- Zandalar Haruspex's Tunic
    },
    -- Primal Hakkari Kossack
    ["19723"] = {
        19822, -- Zandalar Vindicator's Breastplate
        20033, -- Zandalar Demoniac's Robe
        20034, -- Zandalar Illusionist's Robe
    },
    -- Primal Hakkari Aegis
    ["19724"] = {
        19831, -- Zandalar Predator's Mantle
        19834, -- Zandalar Madcap's Tunic
        19841, -- Zandalar Confessor's Mantle
    },
    -- Heart of Hakkar
    ["19802"] = {
        19948, -- Zandalarian Hero Badge
        19949, -- Zandalarian Hero Medallion
        19950, -- Zandalarian Hero Charm
    },
    -- Zandalar Vindicator's Breastplate
    ["19822"] = {
        19723, -- Primal Hakkari Kossack
    },
    -- Zandalar Vindicator's Belt
    ["19823"] = {
        19719, -- Primal Hakkari Girdle
    },
    -- Zandalar Vindicator's Armguards
    ["19824"] = {
        19717, -- Primal Hakkari Armsplint
    },
    -- Zandalar Freethinker's Breastplate
    ["19825"] = {
        19722, -- Primal Hakkari Tabard
    },
    -- Zandalar Freethinker's Belt
    ["19826"] = {
        19721, -- Primal Hakkari Shawl
    },
    -- Zandalar Freethinker's Armguards
    ["19827"] = {
        19716, -- Primal Hakkari Bindings
    },
    -- Zandalar Augur's Hauberk
    ["19828"] = {
        19722, -- Primal Hakkari Tabard
    },
    -- Zandalar Augur's Belt
    ["19829"] = {
        19719, -- Primal Hakkari Girdle
    },
    -- Zandalar Augur's Bracers
    ["19830"] = {
        19717, -- Primal Hakkari Armsplint
    },
    -- Zandalar Predator's Mantle
    ["19831"] = {
        19724, -- Primal Hakkari Aegis
    },
    -- Zandalar Predator's Belt
    ["19832"] = {
        19721, -- Primal Hakkari Shawl
    },
    -- Zandalar Predator's Bracers
    ["19833"] = {
        19716, -- Primal Hakkari Bindings
    },
    -- Zandalar Madcap's Tunic
    ["19834"] = {
        19724, -- Primal Hakkari Aegis
    },
    -- Zandalar Madcap's Mantle
    ["19835"] = {
        19719, -- Primal Hakkari Girdle
    },
    -- Zandalar Madcap's Bracers
    ["19836"] = {
        19717, -- Primal Hakkari Armsplint
    },
    -- Zandalar Haruspex's Tunic
    ["19838"] = {
        19722, -- Primal Hakkari Tabard
    },
    -- Zandalar Haruspex's Belt
    ["19839"] = {
        19720, -- Primal Hakkari Sash
    },
    -- Zandalar Haruspex's Bracers
    ["19840"] = {
        19718, -- Primal Hakkari Stanchion
    },
    -- Zandalar Confessor's Mantle
    ["19841"] = {
        19724, -- Primal Hakkari Aegis
    },
    -- Zandalar Confessor's Bindings
    ["19842"] = {
        19720, -- Primal Hakkari Sash
    },
    -- Zandalar Confessor's Wraps
    ["19843"] = {
        19718, -- Primal Hakkari Stanchion
    },
    -- Zandalar Illusionist's Mantle
    ["19845"] = {
        19721, -- Primal Hakkari Shawl
    },
    -- Zandalar Illusionist's Wraps
    ["19846"] = {
        19716, -- Primal Hakkari Bindings
    },
    -- Zandalar Demoniac's Wraps
    ["19848"] = {
        19718, -- Primal Hakkari Stanchion
    },
    -- Zandalar Demoniac's Mantle
    ["19849"] = {
        19720, -- Primal Hakkari Sash
    },
    -- Zandalarian Hero Badge
    ["19948"] = {
        19802, -- Heart of Hakkar
    },
    -- Zandalarian Hero Medallion
    ["19949"] = {
        19802, -- Heart of Hakkar
    },
    -- Zandalarian Hero Charm
    ["19950"] = {
        19802, -- Heart of Hakkar
    },
    -- Zandalar Demoniac's Robe
    ["20033"] = {
        19723, -- Primal Hakkari Kossack
    },
    -- Zandalar Illusionist's Robe
    ["20034"] = {
        19723, -- Primal Hakkari Kossack
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
    -- Qiraji Spiked Hilt
    ["20886"] = {
        21392, -- Sickle of Unyielding Strength
        21395, -- Blade of Eternal Justice
        21398, -- Hammer of the Gathering Storm
        21401, -- Scythe of the Unseen Path
        21404, -- Dagger of Veiled Shadows
    },
    -- Qiraji Ceremonial Ring
    ["20888"] = {
        21402, -- Signet of the Unseen Path
        21405, -- Band of Veiled Shadows
        21411, -- Ring of Infinite Wisdom
        21417, -- Ring of Unspoken Names
    },
    -- Qiraji Regal Drape
    ["20889"] = {
        21397, -- Cape of Eternal Justice
        21400, -- Cloak of the Gathering Storm
        21403, -- Cloak of the Unseen Path
        21409, -- Cloak of Unending Life
        21418, -- Shroud of Unspoken Names
    },
    -- Qiraji Ornate Hilt
    ["20890"] = {
        21407, -- Mace of Unending Life
        21410, -- Gavel of Infinite Wisdom
        21413, -- Blade of Vaulted Secrets
        21416, -- Kris of Unspoken Names
    },
    -- Vek'nilash's Circlet
    ["20926"] = {
        21329, -- Conqueror's Crown
        21337, -- Doomcaller's Circlet
        21347, -- Enigma Circlet
        21348, -- Tiara of the Oracle
    },
    -- Ouro's Intact Hide
    ["20927"] = {
        21332, -- Conqueror's Legguards
        21346, -- Enigma Leggings
        21352, -- Trousers of the Oracle
        21362, -- Deathdealer's Leggings
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
    -- Vek'lor's Diadem
    ["20930"] = {
        21353, -- Genesis Helm
        21360, -- Deathdealer's Helm
        21366, -- Striker's Diadem
        21372, -- Stormcaller's Diadem
        21387, -- Avenger's Crown
    },
    -- Skin of the Great Sandworm
    ["20931"] = {
        21336, -- Doomcaller's Trousers
        21356, -- Genesis Trousers
        21368, -- Striker's Leggings
        21375, -- Stormcaller's Leggings
        21390, -- Avenger's Legguards
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
    -- Husk of the Old God
    ["20933"] = {
        21334, -- Doomcaller's Robes
        21343, -- Enigma Robes
        21351, -- Vestments of the Oracle
        21357, -- Genesis Vest
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
    -- Conqueror's Crown
    ["21329"] = {
        20926, -- Vek'nilash's Circlet
    },
    -- Conqueror's Spaulders
    ["21330"] = {
        20928, -- Qiraji Bindings of Command
    },
    -- Conqueror's Breastplate
    ["21331"] = {
        20929, -- Carapace of the Old God
    },
    -- Conqueror's Legguards
    ["21332"] = {
        20927, -- Ouro's Intact Hide
    },
    -- Conqueror's Greaves
    ["21333"] = {
        20928, -- Qiraji Bindings of Command
    },
    -- Doomcaller's Robes
    ["21334"] = {
        20933, -- Husk of the Old God
    },
    -- Doomcaller's Mantle
    ["21335"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Doomcaller's Trousers
    ["21336"] = {
        20931, -- Skin of the Great Sandworm
    },
    -- Doomcaller's Circlet
    ["21337"] = {
        20926, -- Vek'nilash's Circlet
    },
    -- Doomcaller's Footwraps
    ["21338"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Enigma Robes
    ["21343"] = {
        20933, -- Husk of the Old God
    },
    -- Enigma Boots
    ["21344"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Enigma Shoulderpads
    ["21345"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Enigma Leggings
    ["21346"] = {
        20927, -- Ouro's Intact Hide
    },
    -- Enigma Circlet
    ["21347"] = {
        20926, -- Vek'nilash's Circlet
    },
    -- Tiara of the Oracle
    ["21348"] = {
        20926, -- Vek'nilash's Circlet
    },
    -- Footwraps of the Oracle
    ["21349"] = {
        20928, -- Qiraji Bindings of Command
    },
    -- Mantle of the Oracle
    ["21350"] = {
        20928, -- Qiraji Bindings of Command
    },
    -- Vestments of the Oracle
    ["21351"] = {
        20933, -- Husk of the Old God
    },
    -- Trousers of the Oracle
    ["21352"] = {
        20927, -- Ouro's Intact Hide
    },
    -- Genesis Helm
    ["21353"] = {
        20930, -- Vek'lor's Diadem
    },
    -- Genesis Shoulderpads
    ["21354"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Genesis Boots
    ["21355"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Genesis Trousers
    ["21356"] = {
        20931, -- Skin of the Great Sandworm
    },
    -- Genesis Vest
    ["21357"] = {
        20933, -- Husk of the Old God
    },
    -- Deathdealer's Boots
    ["21359"] = {
        20928, -- Qiraji Bindings of Command
    },
    -- Deathdealer's Helm
    ["21360"] = {
        20930, -- Vek'lor's Diadem
    },
    -- Deathdealer's Spaulders
    ["21361"] = {
        20928, -- Qiraji Bindings of Command
    },
    -- Deathdealer's Leggings
    ["21362"] = {
        20927, -- Ouro's Intact Hide
    },
    -- Deathdealer's Vest
    ["21364"] = {
        20929, -- Carapace of the Old God
    },
    -- Striker's Footguards
    ["21365"] = {
        20928, -- Qiraji Bindings of Command
    },
    -- Striker's Diadem
    ["21366"] = {
        20930, -- Vek'lor's Diadem
    },
    -- Striker's Pauldrons
    ["21367"] = {
        20928, -- Qiraji Bindings of Command
    },
    -- Striker's Leggings
    ["21368"] = {
        20931, -- Skin of the Great Sandworm
    },
    -- Striker's Hauberk
    ["21370"] = {
        20929, -- Carapace of the Old God
    },
    -- Stormcaller's Diadem
    ["21372"] = {
        20930, -- Vek'lor's Diadem
    },
    -- Stormcaller's Footguards
    ["21373"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Stormcaller's Hauberk
    ["21374"] = {
        20929, -- Carapace of the Old God
    },
    -- Stormcaller's Leggings
    ["21375"] = {
        20931, -- Skin of the Great Sandworm
    },
    -- Stormcaller's Pauldrons
    ["21376"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Avenger's Crown
    ["21387"] = {
        20930, -- Vek'lor's Diadem
    },
    -- Avenger's Greaves
    ["21388"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Avenger's Breastplate
    ["21389"] = {
        20929, -- Carapace of the Old God
    },
    -- Avenger's Legguards
    ["21390"] = {
        20931, -- Skin of the Great Sandworm
    },
    -- Avenger's Pauldrons
    ["21391"] = {
        20932, -- Qiraji Bindings of Dominance
    },
    -- Sickle of Unyielding Strength
    ["21392"] = {
        20886, -- Qiraji Spiked Hilt
    },
    -- Signet of Unyielding Strength
    ["21393"] = {
        20884, -- Qiraji Magisterial Ring
    },
    -- Drape of Unyielding Strength
    ["21394"] = {
        20885, -- Qiraji Martial Drape
    },
    -- Blade of Eternal Justice
    ["21395"] = {
        20886, -- Qiraji Spiked Hilt
    },
    -- Ring of Eternal Justice
    ["21396"] = {
        20884, -- Qiraji Magisterial Ring
    },
    -- Cape of Eternal Justice
    ["21397"] = {
        20889, -- Qiraji Regal Drape
    },
    -- Hammer of the Gathering Storm
    ["21398"] = {
        20886, -- Qiraji Spiked Hilt
    },
    -- Ring of the Gathering Storm
    ["21399"] = {
        20884, -- Qiraji Magisterial Ring
    },
    -- Cloak of the Gathering Storm
    ["21400"] = {
        20889, -- Qiraji Regal Drape
    },
    -- Scythe of the Unseen Path
    ["21401"] = {
        20886, -- Qiraji Spiked Hilt
    },
    -- Signet of the Unseen Path
    ["21402"] = {
        20888, -- Qiraji Ceremonial Ring
    },
    -- Cloak of the Unseen Path
    ["21403"] = {
        20889, -- Qiraji Regal Drape
    },
    -- Dagger of Veiled Shadows
    ["21404"] = {
        20886, -- Qiraji Spiked Hilt
    },
    -- Band of Veiled Shadows
    ["21405"] = {
        20888, -- Qiraji Ceremonial Ring
    },
    -- Cloak of Veiled Shadows
    ["21406"] = {
        20885, -- Qiraji Martial Drape
    },
    -- Mace of Unending Life
    ["21407"] = {
        20890, -- Qiraji Ornate Hilt
    },
    -- Band of Unending Life
    ["21408"] = {
        20884, -- Qiraji Magisterial Ring
    },
    -- Cloak of Unending Life
    ["21409"] = {
        20889, -- Qiraji Regal Drape
    },
    -- Gavel of Infinite Wisdom
    ["21410"] = {
        20890, -- Qiraji Ornate Hilt
    },
    -- Ring of Infinite Wisdom
    ["21411"] = {
        20888, -- Qiraji Ceremonial Ring
    },
    -- Shroud of Infinite Wisdom
    ["21412"] = {
        20885, -- Qiraji Martial Drape
    },
    -- Blade of Vaulted Secrets
    ["21413"] = {
        20890, -- Qiraji Ornate Hilt
    },
    -- Band of Vaulted Secrets
    ["21414"] = {
        20884, -- Qiraji Magisterial Ring
    },
    -- Drape of Vaulted Secrets
    ["21415"] = {
        20885, -- Qiraji Martial Drape
    },
    -- Kris of Unspoken Names
    ["21416"] = {
        20890, -- Qiraji Ornate Hilt
    },
    -- Ring of Unspoken Names
    ["21417"] = {
        20888, -- Qiraji Ceremonial Ring
    },
    -- Shroud of Unspoken Names
    ["21418"] = {
        20889, -- Qiraji Regal Drape
    },
    -- Charm of the Shifting Sands
    ["21504"] = {
        21220, -- Head of Ossirian the Unscarred
    },
    -- Choker of the Shifting Sands
    ["21505"] = {
        21220, -- Head of Ossirian the Unscarred
    },
    -- Pendant of the Shifting Sands
    ["21506"] = {
        21220, -- Head of Ossirian the Unscarred
    },
    -- Amulet of the Shifting Sands
    ["21507"] = {
        21220, -- Head of Ossirian the Unscarred
    },
    -- Ring of the Fallen God
    ["21709"] = {
        21221, -- Eye of C'Thun
    },
    -- Cloak of the Fallen God
    ["21710"] = {
        21221, -- Eye of C'Thun
    },
    -- Amulet of the Fallen God
    ["21712"] = {
        21221, -- Eye of C'Thun
    },
    -- Desecrated Breastplate
    ["22349"] = {
        22416, -- Dreadnaught Breastplate
        22476, -- Bonescythe Breastplate
    },
    -- Desecrated Tunic
    ["22350"] = {
        22425, -- Redemption Tunic
        22436, -- Cryptstalker Tunic
        22464, -- Earthshatter Tunic
        22488, -- Dreamwalker Tunic
    },
    -- Desecrated Robe
    ["22351"] = {
        22496, -- Frostfire Robe
        22504, -- Plagueheart Robe
        22512, -- Robe of Faith
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
    -- Desecrated Bracers
    ["22355"] = {
        22423, -- Dreadnaught Bracers
        22483, -- Bonescythe Bracers
    },
    -- Desecrated Waistguard
    ["22356"] = {
        22422, -- Dreadnaught Waistguard
        22482, -- Bonescythe Waistguard
    },
    -- Desecrated Gauntlets
    ["22357"] = {
        22421, -- Dreadnaught Gauntlets
        22481, -- Bonescythe Gauntlets
    },
    -- Desecrated Sabatons
    ["22358"] = {
        22420, -- Dreadnaught Sabatons
        22480, -- Bonescythe Sabatons
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
    -- Desecrated Wristguards
    ["22362"] = {
        22424, -- Redemption Wristguards
        22443, -- Cryptstalker Wristguards
        22471, -- Earthshatter Wristguards
        22495, -- Dreamwalker Wristguards
    },
    -- Desecrated Girdle
    ["22363"] = {
        22431, -- Redemption Girdle
        22442, -- Cryptstalker Girdle
        22470, -- Earthshatter Girdle
        22494, -- Dreamwalker Girdle
    },
    -- Desecrated Handguards
    ["22364"] = {
        22426, -- Redemption Handguards
        22441, -- Cryptstalker Handguards
        22469, -- Earthshatter Handguards
        22493, -- Dreamwalker Handguards
    },
    -- Desecrated Boots
    ["22365"] = {
        22430, -- Redemption Boots
        22440, -- Cryptstalker Boots
        22468, -- Earthshatter Boots
        22492, -- Dreamwalker Boots
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
    -- Desecrated Bindings
    ["22369"] = {
        22503, -- Frostfire Bindings
        22511, -- Plagueheart Bindings
        22519, -- Bindings of Faith
    },
    -- Desecrated Belt
    ["22370"] = {
        22502, -- Frostfire Belt
        22510, -- Plagueheart Belt
        22518, -- Belt of Faith
    },
    -- Desecrated Gloves
    ["22371"] = {
        22501, -- Frostfire Gloves
        22509, -- Plagueheart Gloves
        22517, -- Gloves of Faith
    },
    -- Desecrated Sandals
    ["22372"] = {
        22500, -- Frostfire Sandals
        22508, -- Plagueheart Sandals
        22516, -- Sandals of Faith
    },
    -- Dreadnaught Breastplate
    ["22416"] = {
        22349, -- Desecrated Breastplate
    },
    -- Dreadnaught Legplates
    ["22417"] = {
        22352, -- Desecrated Legplates
    },
    -- Dreadnaught Helmet
    ["22418"] = {
        22353, -- Desecrated Helmet
    },
    -- Dreadnaught Pauldrons
    ["22419"] = {
        22354, -- Desecrated Pauldrons
    },
    -- Dreadnaught Sabatons
    ["22420"] = {
        22358, -- Desecrated Sabatons
    },
    -- Dreadnaught Gauntlets
    ["22421"] = {
        22357, -- Desecrated Gauntlets
    },
    -- Dreadnaught Waistguard
    ["22422"] = {
        22356, -- Desecrated Waistguard
    },
    -- Dreadnaught Bracers
    ["22423"] = {
        22355, -- Desecrated Bracers
    },
    -- Redemption Wristguards
    ["22424"] = {
        22362, -- Desecrated Wristguards
    },
    -- Redemption Tunic
    ["22425"] = {
        22350, -- Desecrated Tunic
    },
    -- Redemption Handguards
    ["22426"] = {
        22364, -- Desecrated Handguards
    },
    -- Redemption Legguards
    ["22427"] = {
        22359, -- Desecrated Legguards
    },
    -- Redemption Headpiece
    ["22428"] = {
        22360, -- Desecrated Headpiece
    },
    -- Redemption Spaulders
    ["22429"] = {
        22361, -- Desecrated Spaulders
    },
    -- Redemption Boots
    ["22430"] = {
        22365, -- Desecrated Boots
    },
    -- Redemption Girdle
    ["22431"] = {
        22363, -- Desecrated Girdle
    },
    -- Cryptstalker Tunic
    ["22436"] = {
        22350, -- Desecrated Tunic
    },
    -- Cryptstalker Legguards
    ["22437"] = {
        22359, -- Desecrated Legguards
    },
    -- Cryptstalker Headpiece
    ["22438"] = {
        22360, -- Desecrated Headpiece
    },
    -- Cryptstalker Spaulders
    ["22439"] = {
        22361, -- Desecrated Spaulders
    },
    -- Cryptstalker Boots
    ["22440"] = {
        22365, -- Desecrated Boots
    },
    -- Cryptstalker Handguards
    ["22441"] = {
        22364, -- Desecrated Handguards
    },
    -- Cryptstalker Girdle
    ["22442"] = {
        22363, -- Desecrated Girdle
    },
    -- Cryptstalker Wristguards
    ["22443"] = {
        22362, -- Desecrated Wristguards
    },
    -- Earthshatter Tunic
    ["22464"] = {
        22350, -- Desecrated Tunic
    },
    -- Earthshatter Legguards
    ["22465"] = {
        22359, -- Desecrated Legguards
    },
    -- Earthshatter Headpiece
    ["22466"] = {
        22360, -- Desecrated Headpiece
    },
    -- Earthshatter Spaulders
    ["22467"] = {
        22361, -- Desecrated Spaulders
    },
    -- Earthshatter Boots
    ["22468"] = {
        22365, -- Desecrated Boots
    },
    -- Earthshatter Handguards
    ["22469"] = {
        22364, -- Desecrated Handguards
    },
    -- Earthshatter Girdle
    ["22470"] = {
        22363, -- Desecrated Girdle
    },
    -- Earthshatter Wristguards
    ["22471"] = {
        22362, -- Desecrated Wristguards
    },
    -- Bonescythe Breastplate
    ["22476"] = {
        22349, -- Desecrated Breastplate
    },
    -- Bonescythe Legplates
    ["22477"] = {
        22352, -- Desecrated Legplates
    },
    -- Bonescythe Helmet
    ["22478"] = {
        22353, -- Desecrated Helmet
    },
    -- Bonescythe Pauldrons
    ["22479"] = {
        22354, -- Desecrated Pauldrons
    },
    -- Bonescythe Sabatons
    ["22480"] = {
        22358, -- Desecrated Sabatons
    },
    -- Bonescythe Gauntlets
    ["22481"] = {
        22357, -- Desecrated Gauntlets
    },
    -- Bonescythe Waistguard
    ["22482"] = {
        22356, -- Desecrated Waistguard
    },
    -- Bonescythe Bracers
    ["22483"] = {
        22355, -- Desecrated Bracers
    },
    -- Dreamwalker Tunic
    ["22488"] = {
        22350, -- Desecrated Tunic
    },
    -- Dreamwalker Legguards
    ["22489"] = {
        22359, -- Desecrated Legguards
    },
    -- Dreamwalker Headpiece
    ["22490"] = {
        22360, -- Desecrated Headpiece
    },
    -- Dreamwalker Spaulders
    ["22491"] = {
        22361, -- Desecrated Spaulders
    },
    -- Dreamwalker Boots
    ["22492"] = {
        22365, -- Desecrated Boots
    },
    -- Dreamwalker Handguards
    ["22493"] = {
        22364, -- Desecrated Handguards
    },
    -- Dreamwalker Girdle
    ["22494"] = {
        22363, -- Desecrated Girdle
    },
    -- Dreamwalker Wristguards
    ["22495"] = {
        22362, -- Desecrated Wristguards
    },
    -- Frostfire Robe
    ["22496"] = {
        22351, -- Desecrated Robe
    },
    -- Frostfire Leggings
    ["22497"] = {
        22366, -- Desecrated Leggings
    },
    -- Frostfire Circlet
    ["22498"] = {
        22367, -- Desecrated Circlet
    },
    -- Frostfire Shoulderpads
    ["22499"] = {
        22368, -- Desecrated Shoulderpads
    },
    -- Frostfire Sandals
    ["22500"] = {
        22372, -- Desecrated Sandals
    },
    -- Frostfire Gloves
    ["22501"] = {
        22371, -- Desecrated Gloves
    },
    -- Frostfire Belt
    ["22502"] = {
        22370, -- Desecrated Belt
    },
    -- Frostfire Bindings
    ["22503"] = {
        22369, -- Desecrated Bindings
    },
    -- Plagueheart Robe
    ["22504"] = {
        22351, -- Desecrated Robe
    },
    -- Plagueheart Leggings
    ["22505"] = {
        22366, -- Desecrated Leggings
    },
    -- Plagueheart Circlet
    ["22506"] = {
        22367, -- Desecrated Circlet
    },
    -- Plagueheart Shoulderpads
    ["22507"] = {
        22368, -- Desecrated Shoulderpads
    },
    -- Plagueheart Sandals
    ["22508"] = {
        22372, -- Desecrated Sandals
    },
    -- Plagueheart Gloves
    ["22509"] = {
        22371, -- Desecrated Gloves
    },
    -- Plagueheart Belt
    ["22510"] = {
        22370, -- Desecrated Belt
    },
    -- Plagueheart Bindings
    ["22511"] = {
        22369, -- Desecrated Bindings
    },
    -- Robe of Faith
    ["22512"] = {
        22351, -- Desecrated Robe
    },
    -- Leggings of Faith
    ["22513"] = {
        22366, -- Desecrated Leggings
    },
    -- Circlet of Faith
    ["22514"] = {
        22367, -- Desecrated Circlet
    },
    -- Shoulderpads of Faith
    ["22515"] = {
        22368, -- Desecrated Shoulderpads
    },
    -- Sandals of Faith
    ["22516"] = {
        22372, -- Desecrated Sandals
    },
    -- Gloves of Faith
    ["22517"] = {
        22371, -- Desecrated Gloves
    },
    -- Belt of Faith
    ["22518"] = {
        22370, -- Desecrated Belt
    },
    -- Bindings of Faith
    ["22519"] = {
        22369, -- Desecrated Bindings
    },
    -- The Phylactery of Kel'Thuzad
    ["22520"] = {
        23206, -- Mark of the Champion
        23207, -- Mark of the Champion
    },
    -- Atiesh, Greatstaff of the Guardian (mage)
    ["22589"] = {
        22726, -- Splinter of Atiesh
    },
    -- Atiesh, Greatstaff of the Guardian (warlock)
    ["22630"] = {
        22726, -- Splinter of Atiesh
    },
    -- Atiesh, Greatstaff of the Guardian (priest)
    ["22631"] = {
        22726, -- Splinter of Atiesh
    },
    -- Atiesh, Greatstaff of the Guardian (druid)
    ["22632"] = {
        22726, -- Splinter of Atiesh
    },
    -- Splinter of Atiesh
    ["22726"] = {
        22589, -- Atiesh, Greatstaff of the Guardian (mage)
        22630, -- Atiesh, Greatstaff of the Guardian (warlock)
        22631, -- Atiesh, Greatstaff of the Guardian (priest)
        22632, -- Atiesh, Greatstaff of the Guardian (druid)
    },
    -- Mark of the Champion
    ["23206"] = {
        22520, -- The Phylactery of Kel'Thuzad
    },
    -- Mark of the Champion
    ["23207"] = {
        22520, -- The Phylactery of Kel'Thuzad
    },
    -- Fel Edged Battleaxe
    ["23542"] = {
        23631, -- Plans: Fel Edged Battleaxe
    },
    -- Plans: Fel Edged Battleaxe
    ["23631"] = {
        23542, -- Fel Edged Battleaxe
    },
    -- Naaru Lightwarden's Band
    ["28790"] = {
        32385, -- Magtheridon's Head (Alliance)
    },
    -- Ring of the Recalcitrant
    ["28791"] = {
        32385, -- Magtheridon's Head (Alliance)
    },
    -- A'dal's Signet of Defense
    ["28792"] = {
        32385, -- Magtheridon's Head (Alliance)
    },
    -- Band of Crimson Fury
    ["28793"] = {
        32385, -- Magtheridon's Head (Alliance)
    },
    -- Voidheart Crown
    ["28963"] = {
        29759, -- Helm of the Fallen Hero
    },
    -- Voidheart Robe
    ["28964"] = {
        29755, -- Chestguard of the Fallen Hero
    },
    -- Voidheart Leggings
    ["28966"] = {
        29765, -- Leggings of the Fallen Hero
    },
    -- Voidheart Mantle
    ["28967"] = {
        29762, -- Pauldrons of the Fallen Hero
    },
    -- Voidheart Gloves
    ["28968"] = {
        29756, -- Gloves of the Fallen Hero
    },
    -- Warbringer Greathelm
    ["29011"] = {
        29761, -- Helm of the Fallen Defender
    },
    -- Warbringer Chestguard
    ["29012"] = {
        29753, -- Chestguard of the Fallen Defender
    },
    -- Warbringer Legguards
    ["29015"] = {
        29767, -- Leggings of the Fallen Defender
    },
    -- Warbringer Shoulderguards
    ["29016"] = {
        29764, -- Pauldrons of the Fallen Defender
    },
    -- Warbringer Handguards
    ["29017"] = {
        29758, -- Gloves of the Fallen Defender
    },
    -- Warbringer Breastplate
    ["29019"] = {
        29753, -- Chestguard of the Fallen Defender
    },
    -- Warbringer Gauntlets
    ["29020"] = {
        29758, -- Gloves of the Fallen Defender
    },
    -- Warbringer Battle-Helm
    ["29021"] = {
        29761, -- Helm of the Fallen Defender
    },
    -- Warbringer Greaves
    ["29022"] = {
        29767, -- Leggings of the Fallen Defender
    },
    -- Warbringer Shoulderplates
    ["29023"] = {
        29764, -- Pauldrons of the Fallen Defender
    },
    -- Cyclone Headdress
    ["29028"] = {
        29760, -- Helm of the Fallen Champion
    },
    -- Cyclone Hauberk
    ["29029"] = {
        29754, -- Chestguard of the Fallen Champion
    },
    -- Cyclone Kilt
    ["29030"] = {
        29766, -- Leggings of the Fallen Champion
    },
    -- Cyclone Shoulderpads
    ["29031"] = {
        29763, -- Pauldrons of the Fallen Champion
    },
    -- Cyclone Gloves
    ["29032"] = {
        29757, -- Gloves of the Fallen Champion
    },
    -- Cyclone Chestguard
    ["29033"] = {
        29754, -- Chestguard of the Fallen Champion
    },
    -- Cyclone Handguards
    ["29034"] = {
        29757, -- Gloves of the Fallen Champion
    },
    -- Cyclone Faceguard
    ["29035"] = {
        29760, -- Helm of the Fallen Champion
    },
    -- Cyclone Legguards
    ["29036"] = {
        29766, -- Leggings of the Fallen Champion
    },
    -- Cyclone Shoulderguards
    ["29037"] = {
        29763, -- Pauldrons of the Fallen Champion
    },
    -- Cyclone Breastplate
    ["29038"] = {
        29754, -- Chestguard of the Fallen Champion
    },
    -- Cyclone Gauntlets
    ["29039"] = {
        29757, -- Gloves of the Fallen Champion
    },
    -- Cyclone Helm
    ["29040"] = {
        29760, -- Helm of the Fallen Champion
    },
    -- Cyclone War-Kilt
    ["29042"] = {
        29766, -- Leggings of the Fallen Champion
    },
    -- Cyclone Shoulderplates
    ["29043"] = {
        29763, -- Pauldrons of the Fallen Champion
    },
    -- Netherblade Facemask
    ["29044"] = {
        29760, -- Helm of the Fallen Champion
    },
    -- Netherblade Chestpiece
    ["29045"] = {
        29754, -- Chestguard of the Fallen Champion
    },
    -- Netherblade Breeches
    ["29046"] = {
        29766, -- Leggings of the Fallen Champion
    },
    -- Netherblade Shoulderpads
    ["29047"] = {
        29763, -- Pauldrons of the Fallen Champion
    },
    -- Netherblade Gloves
    ["29048"] = {
        29757, -- Gloves of the Fallen Champion
    },
    -- Light-Collar of the Incarnate
    ["29049"] = {
        29761, -- Helm of the Fallen Defender
    },
    -- Robes of the Incarnate
    ["29050"] = {
        29753, -- Chestguard of the Fallen Defender
    },
    -- Trousers of the Incarnate
    ["29053"] = {
        29767, -- Leggings of the Fallen Defender
    },
    -- Light-Mantle of the Incarnate
    ["29054"] = {
        29764, -- Pauldrons of the Fallen Defender
    },
    -- Handwraps of the Incarnate
    ["29055"] = {
        29758, -- Gloves of the Fallen Defender
    },
    -- Shroud of the Incarnate
    ["29056"] = {
        29753, -- Chestguard of the Fallen Defender
    },
    -- Gloves of the Incarnate
    ["29057"] = {
        29758, -- Gloves of the Fallen Defender
    },
    -- Soul-Collar of the Incarnate
    ["29058"] = {
        29761, -- Helm of the Fallen Defender
    },
    -- Leggings of the Incarnate
    ["29059"] = {
        29767, -- Leggings of the Fallen Defender
    },
    -- Soul-Mantle of the Incarnate
    ["29060"] = {
        29764, -- Pauldrons of the Fallen Defender
    },
    -- Justicar Diadem
    ["29061"] = {
        29760, -- Helm of the Fallen Champion
    },
    -- Justicar Chestpiece
    ["29062"] = {
        29754, -- Chestguard of the Fallen Champion
    },
    -- Justicar Leggings
    ["29063"] = {
        29766, -- Leggings of the Fallen Champion
    },
    -- Justicar Pauldrons
    ["29064"] = {
        29763, -- Pauldrons of the Fallen Champion
    },
    -- Justicar Gloves
    ["29065"] = {
        29757, -- Gloves of the Fallen Champion
    },
    -- Justicar Chestguard
    ["29066"] = {
        29754, -- Chestguard of the Fallen Champion
    },
    -- Justicar Handguards
    ["29067"] = {
        29757, -- Gloves of the Fallen Champion
    },
    -- Justicar Faceguard
    ["29068"] = {
        29760, -- Helm of the Fallen Champion
    },
    -- Justicar Legguards
    ["29069"] = {
        29766, -- Leggings of the Fallen Champion
    },
    -- Justicar Shoulderguards
    ["29070"] = {
        29763, -- Pauldrons of the Fallen Champion
    },
    -- Justicar Breastplate
    ["29071"] = {
        29754, -- Chestguard of the Fallen Champion
    },
    -- Justicar Gauntlets
    ["29072"] = {
        29757, -- Gloves of the Fallen Champion
    },
    -- Justicar Crown
    ["29073"] = {
        29760, -- Helm of the Fallen Champion
    },
    -- Justicar Greaves
    ["29074"] = {
        29766, -- Leggings of the Fallen Champion
    },
    -- Justicar Shoulderplates
    ["29075"] = {
        29763, -- Pauldrons of the Fallen Champion
    },
    -- Collar of the Aldor
    ["29076"] = {
        29759, -- Helm of the Fallen Hero
    },
    -- Vestments of the Aldor
    ["29077"] = {
        29755, -- Chestguard of the Fallen Hero
    },
    -- Legwraps of the Aldor
    ["29078"] = {
        29765, -- Leggings of the Fallen Hero
    },
    -- Pauldrons of the Aldor
    ["29079"] = {
        29762, -- Pauldrons of the Fallen Hero
    },
    -- Gloves of the Aldor
    ["29080"] = {
        29756, -- Gloves of the Fallen Hero
    },
    -- Demon Stalker Greathelm
    ["29081"] = {
        29759, -- Helm of the Fallen Hero
    },
    -- Demon Stalker Harness
    ["29082"] = {
        29755, -- Chestguard of the Fallen Hero
    },
    -- Demon Stalker Greaves
    ["29083"] = {
        29765, -- Leggings of the Fallen Hero
    },
    -- Demon Stalker Shoulderguards
    ["29084"] = {
        29762, -- Pauldrons of the Fallen Hero
    },
    -- Demon Stalker Gauntlets
    ["29085"] = {
        29756, -- Gloves of the Fallen Hero
    },
    -- Crown of Malorne
    ["29086"] = {
        29761, -- Helm of the Fallen Defender
    },
    -- Chestguard of Malorne
    ["29087"] = {
        29753, -- Chestguard of the Fallen Defender
    },
    -- Legguards of Malorne
    ["29088"] = {
        29767, -- Leggings of the Fallen Defender
    },
    -- Shoulderguards of Malorne
    ["29089"] = {
        29764, -- Pauldrons of the Fallen Defender
    },
    -- Handguards of Malorne
    ["29090"] = {
        29758, -- Gloves of the Fallen Defender
    },
    -- Chestpiece of Malorne
    ["29091"] = {
        29753, -- Chestguard of the Fallen Defender
    },
    -- Gloves of Malorne
    ["29092"] = {
        29758, -- Gloves of the Fallen Defender
    },
    -- Antlers of Malorne
    ["29093"] = {
        29761, -- Helm of the Fallen Defender
    },
    -- Britches of Malorne
    ["29094"] = {
        29767, -- Leggings of the Fallen Defender
    },
    -- Pauldrons of Malorne
    ["29095"] = {
        29764, -- Pauldrons of the Fallen Defender
    },
    -- Breastplate of Malorne
    ["29096"] = {
        29753, -- Chestguard of the Fallen Defender
    },
    -- Gauntlets of Malorne
    ["29097"] = {
        29758, -- Gloves of the Fallen Defender
    },
    -- Stag-Helm of Malorne
    ["29098"] = {
        29761, -- Helm of the Fallen Defender
    },
    -- Greaves of Malorne
    ["29099"] = {
        29767, -- Leggings of the Fallen Defender
    },
    -- Mantle of Malorne
    ["29100"] = {
        29764, -- Pauldrons of the Fallen Defender
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
    -- Chestguard of the Fallen Hero
    ["29755"] = {
        28964, -- Voidheart Robe
        29077, -- Vestments of the Aldor
        29082, -- Demon Stalker Harness
    },
    -- Gloves of the Fallen Hero
    ["29756"] = {
        28968, -- Voidheart Gloves
        29080, -- Gloves of the Aldor
        29085, -- Demon Stalker Gauntlets
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
    -- Helm of the Fallen Hero
    ["29759"] = {
        28963, -- Voidheart Crown
        29076, -- Collar of the Aldor
        29081, -- Demon Stalker Greathelm
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
    -- Pauldrons of the Fallen Hero
    ["29762"] = {
        28967, -- Voidheart Mantle
        29079, -- Pauldrons of the Aldor
        29084, -- Demon Stalker Shoulderguards
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
    -- Leggings of the Fallen Hero
    ["29765"] = {
        28966, -- Voidheart Leggings
        29078, -- Legwraps of the Aldor
        29083, -- Demon Stalker Greaves
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
    -- The Darkener's Grasp
    ["30007"] = {
        32405, -- Verdant Sphere
    },
    -- The Sun King's Talisman
    ["30015"] = {
        32405, -- Verdant Sphere
    },
    -- Telonicus's Pendant of Mayhem
    ["30017"] = {
        32405, -- Verdant Sphere
    },
    -- Lord Sanguinar's Claim
    ["30018"] = {
        32405, -- Verdant Sphere
    },
    -- Red Havoc Boots
    ["30031"] = {
        30324, -- Plans: Red Havoc Boots
    },
    -- Red Belt of Battle
    ["30032"] = {
        30322, -- Plans: Red Belt of Battle
    },
    -- Boots of the Protector
    ["30033"] = {
        30323, -- Plans: Boots of the Protector
    },
    -- Belt of the Guardian
    ["30034"] = {
        30321, -- Plans: Belt of the Guardian
    },
    -- Boots of the Long Road
    ["30035"] = {
        30283, -- Pattern: Boots of the Long Road
    },
    -- Belt of the Long Road
    ["30036"] = {
        30281, -- Pattern: Belt of the Long Road
    },
    -- Boots of Blasting
    ["30037"] = {
        30282, -- Pattern: Boots of Blasting
    },
    -- Belt of Blasting
    ["30038"] = {
        30280, -- Pattern: Belt of Blasting
    },
    -- Boots of Utter Darkness
    ["30039"] = {
        30306, -- Pattern: Boots of Utter Darkness
    },
    -- Belt of Deep Shadow
    ["30040"] = {
        30302, -- Pattern: Belt of Deep Shadow
    },
    -- Boots of Natural Grace
    ["30041"] = {
        30305, -- Pattern: Boots of Natural Grace
    },
    -- Belt of Natural Power
    ["30042"] = {
        30301, -- Pattern: Belt of Natural Power
    },
    -- Hurricane Boots
    ["30043"] = {
        30308, -- Pattern: Hurricane Boots
    },
    -- Monsoon Belt
    ["30044"] = {
        30304, -- Pattern: Monsoon Belt
    },
    -- Boots of the Crimson Hawk
    ["30045"] = {
        30307, -- Pattern: Boots of the Crimson Hawk
    },
    -- Belt of the Black Eagle
    ["30046"] = {
        30303, -- Pattern: Belt of the Black Eagle
    },
    -- Destroyer Chestguard
    ["30113"] = {
        30237, -- Chestguard of the Vanquished Defender
    },
    -- Destroyer Handguards
    ["30114"] = {
        30240, -- Gloves of the Vanquished Defender
    },
    -- Destroyer Greathelm
    ["30115"] = {
        30243, -- Helm of the Vanquished Defender
    },
    -- Destroyer Legguards
    ["30116"] = {
        30246, -- Leggings of the Vanquished Defender
    },
    -- Destroyer Shoulderguards
    ["30117"] = {
        30249, -- Pauldrons of the Vanquished Defender
    },
    -- Destroyer Breastplate
    ["30118"] = {
        30237, -- Chestguard of the Vanquished Defender
    },
    -- Destroyer Gauntlets
    ["30119"] = {
        30240, -- Gloves of the Vanquished Defender
    },
    -- Destroyer Battle-Helm
    ["30120"] = {
        30243, -- Helm of the Vanquished Defender
    },
    -- Destroyer Greaves
    ["30121"] = {
        30246, -- Leggings of the Vanquished Defender
    },
    -- Destroyer Shoulderblades
    ["30122"] = {
        30249, -- Pauldrons of the Vanquished Defender
    },
    -- Crystalforge Chestguard
    ["30123"] = {
        30236, -- Chestguard of the Vanquished Champion
    },
    -- Crystalforge Handguards
    ["30124"] = {
        30239, -- Gloves of the Vanquished Champion
    },
    -- Crystalforge Faceguard
    ["30125"] = {
        30242, -- Helm of the Vanquished Champion
    },
    -- Crystalforge Legguards
    ["30126"] = {
        30245, -- Leggings of the Vanquished Champion
    },
    -- Crystalforge Shoulderguards
    ["30127"] = {
        30248, -- Pauldrons of the Vanquished Champion
    },
    -- Crystalforge Breastplate
    ["30129"] = {
        30236, -- Chestguard of the Vanquished Champion
    },
    -- Crystalforge Gauntlets
    ["30130"] = {
        30239, -- Gloves of the Vanquished Champion
    },
    -- Crystalforge War-Helm
    ["30131"] = {
        30242, -- Helm of the Vanquished Champion
    },
    -- Crystalforge Greaves
    ["30132"] = {
        30245, -- Leggings of the Vanquished Champion
    },
    -- Crystalforge Shoulderbraces
    ["30133"] = {
        30248, -- Pauldrons of the Vanquished Champion
    },
    -- Crystalforge Chestpiece
    ["30134"] = {
        30236, -- Chestguard of the Vanquished Champion
    },
    -- Crystalforge Gloves
    ["30135"] = {
        30239, -- Gloves of the Vanquished Champion
    },
    -- Crystalforge Greathelm
    ["30136"] = {
        30242, -- Helm of the Vanquished Champion
    },
    -- Crystalforge Leggings
    ["30137"] = {
        30245, -- Leggings of the Vanquished Champion
    },
    -- Crystalforge Pauldrons
    ["30138"] = {
        30248, -- Pauldrons of the Vanquished Champion
    },
    -- Rift Stalker Hauberk
    ["30139"] = {
        30238, -- Chestguard of the Vanquished Hero
    },
    -- Rift Stalker Gauntlets
    ["30140"] = {
        30241, -- Gloves of the Vanquished Hero
    },
    -- Rift Stalker Helm
    ["30141"] = {
        30244, -- Helm of the Vanquished Hero
    },
    -- Rift Stalker Leggings
    ["30142"] = {
        30247, -- Leggings of the Vanquished Hero
    },
    -- Rift Stalker Mantle
    ["30143"] = {
        30250, -- Pauldrons of the Vanquished Hero
    },
    -- Deathmantle Chestguard
    ["30144"] = {
        30236, -- Chestguard of the Vanquished Champion
    },
    -- Deathmantle Handguards
    ["30145"] = {
        30239, -- Gloves of the Vanquished Champion
    },
    -- Deathmantle Helm
    ["30146"] = {
        30242, -- Helm of the Vanquished Champion
    },
    -- Deathmantle Legguards
    ["30148"] = {
        30245, -- Leggings of the Vanquished Champion
    },
    -- Deathmantle Shoulderpads
    ["30149"] = {
        30248, -- Pauldrons of the Vanquished Champion
    },
    -- Vestments of the Avatar
    ["30150"] = {
        30237, -- Chestguard of the Vanquished Defender
    },
    -- Gloves of the Avatar
    ["30151"] = {
        30240, -- Gloves of the Vanquished Defender
    },
    -- Cowl of the Avatar
    ["30152"] = {
        30243, -- Helm of the Vanquished Defender
    },
    -- Breeches of the Avatar
    ["30153"] = {
        30246, -- Leggings of the Vanquished Defender
    },
    -- Mantle of the Avatar
    ["30154"] = {
        30249, -- Pauldrons of the Vanquished Defender
    },
    -- Shroud of the Avatar
    ["30159"] = {
        30237, -- Chestguard of the Vanquished Defender
    },
    -- Handguards of the Avatar
    ["30160"] = {
        30240, -- Gloves of the Vanquished Defender
    },
    -- Hood of the Avatar
    ["30161"] = {
        30243, -- Helm of the Vanquished Defender
    },
    -- Leggings of the Avatar
    ["30162"] = {
        30246, -- Leggings of the Vanquished Defender
    },
    -- Wings of the Avatar
    ["30163"] = {
        30249, -- Pauldrons of the Vanquished Defender
    },
    -- Cataclysm Chestguard
    ["30164"] = {
        30236, -- Chestguard of the Vanquished Champion
    },
    -- Cataclysm Gloves
    ["30165"] = {
        30239, -- Gloves of the Vanquished Champion
    },
    -- Cataclysm Headguard
    ["30166"] = {
        30242, -- Helm of the Vanquished Champion
    },
    -- Cataclysm Legguards
    ["30167"] = {
        30245, -- Leggings of the Vanquished Champion
    },
    -- Cataclysm Shoulderguards
    ["30168"] = {
        30248, -- Pauldrons of the Vanquished Champion
    },
    -- Cataclysm Chestpiece
    ["30169"] = {
        30236, -- Chestguard of the Vanquished Champion
    },
    -- Cataclysm Handgrips
    ["30170"] = {
        30239, -- Gloves of the Vanquished Champion
    },
    -- Cataclysm Headpiece
    ["30171"] = {
        30242, -- Helm of the Vanquished Champion
    },
    -- Cataclysm Leggings
    ["30172"] = {
        30245, -- Leggings of the Vanquished Champion
    },
    -- Cataclysm Shoulderpads
    ["30173"] = {
        30248, -- Pauldrons of the Vanquished Champion
    },
    -- Cataclysm Chestplate
    ["30185"] = {
        30236, -- Chestguard of the Vanquished Champion
    },
    -- Cataclysm Gauntlets
    ["30189"] = {
        30239, -- Gloves of the Vanquished Champion
    },
    -- Cataclysm Helm
    ["30190"] = {
        30242, -- Helm of the Vanquished Champion
    },
    -- Cataclysm Legplates
    ["30192"] = {
        30245, -- Leggings of the Vanquished Champion
    },
    -- Cataclysm Shoulderplates
    ["30194"] = {
        30248, -- Pauldrons of the Vanquished Champion
    },
    -- Robes of Tirisfal
    ["30196"] = {
        30238, -- Chestguard of the Vanquished Hero
    },
    -- Gloves of Tirisfal
    ["30205"] = {
        30241, -- Gloves of the Vanquished Hero
    },
    -- Cowl of Tirisfal
    ["30206"] = {
        30244, -- Helm of the Vanquished Hero
    },
    -- Leggings of Tirisfal
    ["30207"] = {
        30247, -- Leggings of the Vanquished Hero
    },
    -- Mantle of Tirisfal
    ["30210"] = {
        30250, -- Pauldrons of the Vanquished Hero
    },
    -- Gloves of the Corruptor
    ["30211"] = {
        30241, -- Gloves of the Vanquished Hero
    },
    -- Hood of the Corruptor
    ["30212"] = {
        30244, -- Helm of the Vanquished Hero
    },
    -- Leggings of the Corruptor
    ["30213"] = {
        30247, -- Leggings of the Vanquished Hero
    },
    -- Robe of the Corruptor
    ["30214"] = {
        30238, -- Chestguard of the Vanquished Hero
    },
    -- Mantle of the Corruptor
    ["30215"] = {
        30250, -- Pauldrons of the Vanquished Hero
    },
    -- Nordrassil Chestguard
    ["30216"] = {
        30237, -- Chestguard of the Vanquished Defender
    },
    -- Nordrassil Gloves
    ["30217"] = {
        30240, -- Gloves of the Vanquished Defender
    },
    -- Nordrassil Headguard
    ["30219"] = {
        30243, -- Helm of the Vanquished Defender
    },
    -- Nordrassil Life-Kilt
    ["30220"] = {
        30246, -- Leggings of the Vanquished Defender
    },
    -- Nordrassil Life-Mantle
    ["30221"] = {
        30249, -- Pauldrons of the Vanquished Defender
    },
    -- Nordrassil Chestplate
    ["30222"] = {
        30237, -- Chestguard of the Vanquished Defender
    },
    -- Nordrassil Handgrips
    ["30223"] = {
        30240, -- Gloves of the Vanquished Defender
    },
    -- Nordrassil Headdress
    ["30228"] = {
        30243, -- Helm of the Vanquished Defender
    },
    -- Nordrassil Feral-Kilt
    ["30229"] = {
        30246, -- Leggings of the Vanquished Defender
    },
    -- Nordrassil Feral-Mantle
    ["30230"] = {
        30249, -- Pauldrons of the Vanquished Defender
    },
    -- Nordrassil Chestpiece
    ["30231"] = {
        30237, -- Chestguard of the Vanquished Defender
    },
    -- Nordrassil Gauntlets
    ["30232"] = {
        30240, -- Gloves of the Vanquished Defender
    },
    -- Nordrassil Headpiece
    ["30233"] = {
        30243, -- Helm of the Vanquished Defender
    },
    -- Nordrassil Wrath-Kilt
    ["30234"] = {
        30246, -- Leggings of the Vanquished Defender
    },
    -- Nordrassil Wrath-Mantle
    ["30235"] = {
        30249, -- Pauldrons of the Vanquished Defender
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
    -- Chestguard of the Vanquished Hero
    ["30238"] = {
        30139, -- Rift Stalker Hauberk
        30196, -- Robes of Tirisfal
        30214, -- Robe of the Corruptor
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
    -- Gloves of the Vanquished Hero
    ["30241"] = {
        30140, -- Rift Stalker Gauntlets
        30205, -- Gloves of Tirisfal
        30211, -- Gloves of the Corruptor
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
    -- Helm of the Vanquished Hero
    ["30244"] = {
        30141, -- Rift Stalker Helm
        30206, -- Cowl of Tirisfal
        30212, -- Hood of the Corruptor
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
    -- Leggings of the Vanquished Hero
    ["30247"] = {
        30142, -- Rift Stalker Leggings
        30207, -- Leggings of Tirisfal
        30213, -- Leggings of the Corruptor
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
    -- Pauldrons of the Vanquished Hero
    ["30250"] = {
        30143, -- Rift Stalker Mantle
        30210, -- Mantle of Tirisfal
        30215, -- Mantle of the Corruptor
    },
    -- Pattern: Belt of Blasting
    ["30280"] = {
        30038, -- Belt of Blasting
    },
    -- Pattern: Belt of the Long Road
    ["30281"] = {
        30036, -- Belt of the Long Road
    },
    -- Pattern: Boots of Blasting
    ["30282"] = {
        30037, -- Boots of Blasting
    },
    -- Pattern: Boots of the Long Road
    ["30283"] = {
        30035, -- Boots of the Long Road
    },
    -- Pattern: Belt of Natural Power
    ["30301"] = {
        30042, -- Belt of Natural Power
    },
    -- Pattern: Belt of Deep Shadow
    ["30302"] = {
        30040, -- Belt of Deep Shadow
    },
    -- Pattern: Belt of the Black Eagle
    ["30303"] = {
        30046, -- Belt of the Black Eagle
    },
    -- Pattern: Monsoon Belt
    ["30304"] = {
        30044, -- Monsoon Belt
    },
    -- Pattern: Boots of Natural Grace
    ["30305"] = {
        30041, -- Boots of Natural Grace
    },
    -- Pattern: Boots of Utter Darkness
    ["30306"] = {
        30039, -- Boots of Utter Darkness
    },
    -- Pattern: Boots of the Crimson Hawk
    ["30307"] = {
        30045, -- Boots of the Crimson Hawk
    },
    -- Pattern: Hurricane Boots
    ["30308"] = {
        30043, -- Hurricane Boots
    },
    -- Plans: Belt of the Guardian
    ["30321"] = {
        30034, -- Belt of the Guardian
    },
    -- Plans: Red Belt of Battle
    ["30322"] = {
        30032, -- Red Belt of Battle
    },
    -- Plans: Boots of the Protector
    ["30323"] = {
        30033, -- Boots of the Protector
    },
    -- Plans: Red Havoc Boots
    ["30324"] = {
        30031, -- Red Havoc Boots
    },
    -- Onslaught Gauntlets
    ["30969"] = {
        31094, -- Gloves of the Forgotten Protector
    },
    -- Onslaught Handguards
    ["30970"] = {
        31094, -- Gloves of the Forgotten Protector
    },
    -- Onslaught Battle-Helm
    ["30972"] = {
        31095, -- Helm of the Forgotten Protector
    },
    -- Onslaught Greathelm
    ["30974"] = {
        31095, -- Helm of the Forgotten Protector
    },
    -- Onslaught Breastplate
    ["30975"] = {
        31091, -- Chestguard of the Forgotten Protector
    },
    -- Onslaught Chestguard
    ["30976"] = {
        31091, -- Chestguard of the Forgotten Protector
    },
    -- Onslaught Greaves
    ["30977"] = {
        31100, -- Leggings of the Forgotten Protector
    },
    -- Onslaught Legguards
    ["30978"] = {
        31100, -- Leggings of the Forgotten Protector
    },
    -- Onslaught Shoulderblades
    ["30979"] = {
        31103, -- Pauldrons of the Forgotten Protector
    },
    -- Onslaught Shoulderguards
    ["30980"] = {
        31103, -- Pauldrons of the Forgotten Protector
    },
    -- Lightbringer Gauntlets
    ["30982"] = {
        31092, -- Gloves of the Forgotten Conqueror
    },
    -- Lightbringer Gloves
    ["30983"] = {
        31092, -- Gloves of the Forgotten Conqueror
    },
    -- Lightbringer Handguards
    ["30985"] = {
        31092, -- Gloves of the Forgotten Conqueror
    },
    -- Lightbringer Faceguard
    ["30987"] = {
        31097, -- Helm of the Forgotten Conqueror
    },
    -- Lightbringer Greathelm
    ["30988"] = {
        31097, -- Helm of the Forgotten Conqueror
    },
    -- Lightbringer War-Helm
    ["30989"] = {
        31097, -- Helm of the Forgotten Conqueror
    },
    -- Lightbringer Breastplate
    ["30990"] = {
        31089, -- Chestguard of the Forgotten Conqueror
    },
    -- Lightbringer Chestguard
    ["30991"] = {
        31089, -- Chestguard of the Forgotten Conqueror
    },
    -- Lightbringer Chestpiece
    ["30992"] = {
        31089, -- Chestguard of the Forgotten Conqueror
    },
    -- Lightbringer Greaves
    ["30993"] = {
        31098, -- Leggings of the Forgotten Conqueror
    },
    -- Lightbringer Leggings
    ["30994"] = {
        31098, -- Leggings of the Forgotten Conqueror
    },
    -- Lightbringer Legguards
    ["30995"] = {
        31098, -- Leggings of the Forgotten Conqueror
    },
    -- Lightbringer Pauldrons
    ["30996"] = {
        31101, -- Pauldrons of the Forgotten Conqueror
    },
    -- Lightbringer Shoulderbraces
    ["30997"] = {
        31101, -- Pauldrons of the Forgotten Conqueror
    },
    -- Lightbringer Shoulderguards
    ["30998"] = {
        31101, -- Pauldrons of the Forgotten Conqueror
    },
    -- Gronnstalker's Gloves
    ["31001"] = {
        31094, -- Gloves of the Forgotten Protector
    },
    -- Gronnstalker's Helmet
    ["31003"] = {
        31095, -- Helm of the Forgotten Protector
    },
    -- Gronnstalker's Chestguard
    ["31004"] = {
        31091, -- Chestguard of the Forgotten Protector
    },
    -- Gronnstalker's Leggings
    ["31005"] = {
        31100, -- Leggings of the Forgotten Protector
    },
    -- Gronnstalker's Spaulders
    ["31006"] = {
        31103, -- Pauldrons of the Forgotten Protector
    },
    -- Skyshatter Gloves
    ["31007"] = {
        31094, -- Gloves of the Forgotten Protector
    },
    -- Skyshatter Gauntlets
    ["31008"] = {
        31094, -- Gloves of the Forgotten Protector
    },
    -- Skyshatter Grips
    ["31011"] = {
        31094, -- Gloves of the Forgotten Protector
    },
    -- Skyshatter Helmet
    ["31012"] = {
        31095, -- Helm of the Forgotten Protector
    },
    -- Skyshatter Headguard
    ["31014"] = {
        31095, -- Helm of the Forgotten Protector
    },
    -- Skyshatter Cover
    ["31015"] = {
        31095, -- Helm of the Forgotten Protector
    },
    -- Skyshatter Chestguard
    ["31016"] = {
        31091, -- Chestguard of the Forgotten Protector
    },
    -- Skyshatter Breastplate
    ["31017"] = {
        31091, -- Chestguard of the Forgotten Protector
    },
    -- Skyshatter Tunic
    ["31018"] = {
        31091, -- Chestguard of the Forgotten Protector
    },
    -- Skyshatter Leggings
    ["31019"] = {
        31100, -- Leggings of the Forgotten Protector
    },
    -- Skyshatter Legguards
    ["31020"] = {
        31100, -- Leggings of the Forgotten Protector
    },
    -- Skyshatter Pants
    ["31021"] = {
        31100, -- Leggings of the Forgotten Protector
    },
    -- Skyshatter Shoulderpads
    ["31022"] = {
        31103, -- Pauldrons of the Forgotten Protector
    },
    -- Skyshatter Mantle
    ["31023"] = {
        31103, -- Pauldrons of the Forgotten Protector
    },
    -- Skyshatter Pauldrons
    ["31024"] = {
        31103, -- Pauldrons of the Forgotten Protector
    },
    -- Slayer's Handguards
    ["31026"] = {
        31093, -- Gloves of the Forgotten Vanquisher
    },
    -- Slayer's Helm
    ["31027"] = {
        31096, -- Helm of the Forgotten Vanquisher
    },
    -- Slayer's Chestguard
    ["31028"] = {
        31090, -- Chestguard of the Forgotten Vanquisher
    },
    -- Slayer's Legguards
    ["31029"] = {
        31099, -- Leggings of the Forgotten Vanquisher
    },
    -- Slayer's Shoulderpads
    ["31030"] = {
        31102, -- Pauldrons of the Forgotten Vanquisher
    },
    -- Thunderheart Gloves
    ["31032"] = {
        31093, -- Gloves of the Forgotten Vanquisher
    },
    -- Thunderheart Gauntlets
    ["31034"] = {
        31093, -- Gloves of the Forgotten Vanquisher
    },
    -- Thunderheart Handguards
    ["31035"] = {
        31093, -- Gloves of the Forgotten Vanquisher
    },
    -- Thunderheart Helmet
    ["31037"] = {
        31096, -- Helm of the Forgotten Vanquisher
    },
    -- Thunderheart Cover
    ["31039"] = {
        31096, -- Helm of the Forgotten Vanquisher
    },
    -- Thunderheart Headguard
    ["31040"] = {
        31096, -- Helm of the Forgotten Vanquisher
    },
    -- Thunderheart Tunic
    ["31041"] = {
        31090, -- Chestguard of the Forgotten Vanquisher
    },
    -- Thunderheart Chestguard
    ["31042"] = {
        31090, -- Chestguard of the Forgotten Vanquisher
    },
    -- Thunderheart Vest
    ["31043"] = {
        31090, -- Chestguard of the Forgotten Vanquisher
    },
    -- Thunderheart Leggings
    ["31044"] = {
        31099, -- Leggings of the Forgotten Vanquisher
    },
    -- Thunderheart Legguards
    ["31045"] = {
        31099, -- Leggings of the Forgotten Vanquisher
    },
    -- Thunderheart Pants
    ["31046"] = {
        31099, -- Leggings of the Forgotten Vanquisher
    },
    -- Thunderheart Spaulders
    ["31047"] = {
        31102, -- Pauldrons of the Forgotten Vanquisher
    },
    -- Thunderheart Pauldrons
    ["31048"] = {
        31102, -- Pauldrons of the Forgotten Vanquisher
    },
    -- Thunderheart Shoulderpads
    ["31049"] = {
        31102, -- Pauldrons of the Forgotten Vanquisher
    },
    -- Gloves of the Malefic
    ["31050"] = {
        31092, -- Gloves of the Forgotten Conqueror
    },
    -- Hood of the Malefic
    ["31051"] = {
        31097, -- Helm of the Forgotten Conqueror
    },
    -- Robe of the Malefic
    ["31052"] = {
        31089, -- Chestguard of the Forgotten Conqueror
    },
    -- Leggings of the Malefic
    ["31053"] = {
        31098, -- Leggings of the Forgotten Conqueror
    },
    -- Mantle of the Malefic
    ["31054"] = {
        31101, -- Pauldrons of the Forgotten Conqueror
    },
    -- Gloves of the Tempest
    ["31055"] = {
        31093, -- Gloves of the Forgotten Vanquisher
    },
    -- Cowl of the Tempest
    ["31056"] = {
        31096, -- Helm of the Forgotten Vanquisher
    },
    -- Robes of the Tempest
    ["31057"] = {
        31090, -- Chestguard of the Forgotten Vanquisher
    },
    -- Leggings of the Tempest
    ["31058"] = {
        31099, -- Leggings of the Forgotten Vanquisher
    },
    -- Mantle of the Tempest
    ["31059"] = {
        31102, -- Pauldrons of the Forgotten Vanquisher
    },
    -- Gloves of Absolution
    ["31060"] = {
        31092, -- Gloves of the Forgotten Conqueror
    },
    -- Handguards of Absolution
    ["31061"] = {
        31092, -- Gloves of the Forgotten Conqueror
    },
    -- Cowl of Absolution
    ["31063"] = {
        31097, -- Helm of the Forgotten Conqueror
    },
    -- Hood of Absolution
    ["31064"] = {
        31097, -- Helm of the Forgotten Conqueror
    },
    -- Shroud of Absolution
    ["31065"] = {
        31089, -- Chestguard of the Forgotten Conqueror
    },
    -- Vestments of Absolution
    ["31066"] = {
        31089, -- Chestguard of the Forgotten Conqueror
    },
    -- Leggings of Absolution
    ["31067"] = {
        31098, -- Leggings of the Forgotten Conqueror
    },
    -- Breeches of Absolution
    ["31068"] = {
        31098, -- Leggings of the Forgotten Conqueror
    },
    -- Mantle of Absolution
    ["31069"] = {
        31101, -- Pauldrons of the Forgotten Conqueror
    },
    -- Shoulderpads of Absolution
    ["31070"] = {
        31101, -- Pauldrons of the Forgotten Conqueror
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
    -- Chestguard of the Forgotten Vanquisher
    ["31090"] = {
        31028, -- Slayer's Chestguard
        31041, -- Thunderheart Tunic
        31042, -- Thunderheart Chestguard
        31043, -- Thunderheart Vest
        31057, -- Robes of the Tempest
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
    -- Gloves of the Forgotten Conqueror
    ["31092"] = {
        30982, -- Lightbringer Gauntlets
        30983, -- Lightbringer Gloves
        30985, -- Lightbringer Handguards
        31050, -- Gloves of the Malefic
        31060, -- Gloves of Absolution
        31061, -- Handguards of Absolution
    },
    -- Gloves of the Forgotten Vanquisher
    ["31093"] = {
        31026, -- Slayer's Handguards
        31032, -- Thunderheart Gloves
        31034, -- Thunderheart Gauntlets
        31035, -- Thunderheart Handguards
        31055, -- Gloves of the Tempest
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
    -- Helm of the Forgotten Vanquisher
    ["31096"] = {
        31027, -- Slayer's Helm
        31037, -- Thunderheart Helmet
        31039, -- Thunderheart Cover
        31040, -- Thunderheart Headguard
        31056, -- Cowl of the Tempest
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
    -- Leggings of the Forgotten Conqueror
    ["31098"] = {
        30993, -- Lightbringer Greaves
        30994, -- Lightbringer Leggings
        30995, -- Lightbringer Legguards
        31053, -- Leggings of the Malefic
        31067, -- Leggings of Absolution
        31068, -- Breeches of Absolution
    },
    -- Leggings of the Forgotten Vanquisher
    ["31099"] = {
        31029, -- Slayer's Legguards
        31044, -- Thunderheart Leggings
        31045, -- Thunderheart Legguards
        31046, -- Thunderheart Pants
        31058, -- Leggings of the Tempest
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
    -- Pauldrons of the Forgotten Conqueror
    ["31101"] = {
        30996, -- Lightbringer Pauldrons
        30997, -- Lightbringer Shoulderbraces
        30998, -- Lightbringer Shoulderguards
        31054, -- Mantle of the Malefic
        31069, -- Mantle of Absolution
        31070, -- Shoulderpads of Absolution
    },
    -- Pauldrons of the Forgotten Vanquisher
    ["31102"] = {
        31030, -- Slayer's Shoulderpads
        31047, -- Thunderheart Spaulders
        31048, -- Thunderheart Pauldrons
        31049, -- Thunderheart Shoulderpads
        31059, -- Mantle of the Tempest
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
    -- Verdant Sphere
    ["32405"] = {
        30007, -- The Darkener's Grasp
        30015, -- The Sun King's Talisman
        30017, -- Telonicus's Pendant of Mayhem
        30018, -- Lord Sanguinar's Claim
    },
    -- Swiftsteel Bracers
    ["32568"] = {
        32736, -- Plans: Swiftsteel Bracers
    },
    -- Swiftsteel Shoulders
    ["32570"] = {
        32737, -- Plans: Swiftsteel Shoulders
    },
    -- Dawnsteel Bracers
    ["32571"] = {
        32738, -- Plans: Dawnsteel Bracers
    },
    -- Dawnsteel Shoulders
    ["32573"] = {
        32739, -- Plans: Dawnsteel Shoulders
    },
    -- Bindings of Lightning Reflexes
    ["32574"] = {
        32748, -- Pattern: Bindings of Lightning Reflexes
    },
    -- Shoulders of Lightning Reflexes
    ["32575"] = {
        32749, -- Pattern: Shoulders of Lightning Reflexes
    },
    -- Living Earth Bindings
    ["32577"] = {
        32750, -- Pattern: Living Earth Bindings
    },
    -- Living Earth Shoulders
    ["32579"] = {
        32751, -- Pattern: Living Earth Shoulders
    },
    -- Swiftstrike Bracers
    ["32580"] = {
        32746, -- Pattern: Swiftstrike Bracers
    },
    -- Swiftstrike Shoulders
    ["32581"] = {
        32747, -- Pattern: Swiftstrike Shoulders
    },
    -- Bracers of Renewed Life
    ["32582"] = {
        32744, -- Pattern: Bracers of Renewed Life
    },
    -- Shoulderpads of Renewed Life
    ["32583"] = {
        32745, -- Pattern: Shoulderpads of Renewed Life
    },
    -- Swiftheal Wraps
    ["32584"] = {
        32752, -- Pattern: Swiftheal Wraps
    },
    -- Swiftheal Mantle
    ["32585"] = {
        32753, -- Pattern: Swiftheal Mantle
    },
    -- Bracers of Nimble Thought
    ["32586"] = {
        32754, -- Pattern: Bracers of Nimble Thought
    },
    -- Mantle of Nimble Thought
    ["32587"] = {
        32755, -- Pattern: Mantle of Nimble Thought
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
    -- Pattern: Bracers of Renewed Life
    ["32744"] = {
        32582, -- Bracers of Renewed Life
    },
    -- Pattern: Shoulderpads of Renewed Life
    ["32745"] = {
        32583, -- Shoulderpads of Renewed Life
    },
    -- Pattern: Swiftstrike Bracers
    ["32746"] = {
        32580, -- Swiftstrike Bracers
    },
    -- Pattern: Swiftstrike Shoulders
    ["32747"] = {
        32581, -- Swiftstrike Shoulders
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
    -- Legplates of the Holy Juggernaut
    ["34167"] = {
        34382, -- Judicator's Legguards
    },
    -- Breeches of Natural Aggression
    ["34169"] = {
        34384, -- Breeches of Natural Splendor
    },
    -- Pantaloons of Calming Strife
    ["34170"] = {
        34386, -- Pantaloons of Growing Strife
    },
    -- Felfury Legplates
    ["34180"] = {
        34381, -- Felstrength Legplates
    },
    -- Chain Links of the Tumultuous Storm
    ["34186"] = {
        34383, -- Kilt of Spiritual Reconstruction
    },
    -- Leggings of the Immortal Night
    ["34188"] = {
        34385, -- Leggings of the Immortal Beast
    },
    -- Pauldrons of Perseverance
    ["34192"] = {
        34388, -- Pauldrons of Berserking
    },
    -- Spaulders of the Thalassian Savior
    ["34193"] = {
        34389, -- Spaulders of the Thalassian Defender
    },
    -- Shoulderpads of Vehemence
    ["34195"] = {
        34392, -- Demontooth Shoulderpads
    },
    -- Shawl of Wonderment
    ["34202"] = {
        34393, -- Shoulderpads of Knowledge's Pursuit
    },
    -- Equilibrium Epaulets
    ["34208"] = {
        34390, -- Erupting Epaulets
    },
    -- Spaulders of Reclamation
    ["34209"] = {
        34391, -- Spaulders of Devastation
    },
    -- Harness of Carnal Instinct
    ["34211"] = {
        34397, -- Bladed Chaos Tunic
    },
    -- Sunglow Vest
    ["34212"] = {
        34398, -- Utopian Tunic of Elune
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
    -- Robes of Faltered Light
    ["34233"] = {
        34399, -- Robes of Ghostly Hatred
    },
    -- Shadowed Gauntlets of Paroxysm
    ["34234"] = {
        34408, -- Gloves of the Forest Drifter
    },
    -- Helm of Burning Righteousness
    ["34243"] = {
        34401, -- Helm of Uther's Resolve
    },
    -- Duplicitous Guise
    ["34244"] = {
        34404, -- Mask of the Fury Hunter
    },
    -- Cover of Ursol the Wise
    ["34245"] = {
        34403, -- Cover of Ursoc the Mighty
    },
    -- Cowl of Gul'dan
    ["34332"] = {
        34402, -- Shroud of Chieftain Ner'zhul
    },
    -- Cowl of Light's Purity
    ["34339"] = {
        34405, -- Helm of Arcane Purity
    },
    -- Handguards of the Dawn
    ["34342"] = {
        34406, -- Gloves of Tyri's Power
    },
    -- Crown of Anasterian
    ["34345"] = {
        34400, -- Crown of Dath'Remar
    },
    -- Gauntlets of the Ancient Shadowmoon
    ["34350"] = {
        34409, -- Gauntlets of the Ancient Frostwolf
    },
    -- Tranquil Majesty Wraps
    ["34351"] = {
        34407, -- Tranquil Moonlight Wraps
    },
    -- Mayhem Projection Goggles
    ["34354"] = {
        35195, -- Schematic: Mayhem Projection Goggles
    },
    -- Lightning Etched Specs
    ["34355"] = {
        35193, -- Schematic: Lightning Etched Specs
    },
    -- Surestrike Goggles v3.0
    ["34356"] = {
        35194, -- Schematic: Surestrike Goggles v3.0
    },
    -- Hard Khorium Goggles
    ["34357"] = {
        35196, -- Schematic: Hard Khorium Goggles
    },
    -- Sunfire Robe
    ["34364"] = {
        35206, -- Pattern: Sunfire Robe
    },
    -- Robe of Eternal Light
    ["34365"] = {
        35207, -- Pattern: Robe of Eternal Light
    },
    -- Sunfire Handwraps
    ["34366"] = {
        35204, -- Pattern: Sunfire Handwraps
    },
    -- Hands of Eternal Light
    ["34367"] = {
        35205, -- Pattern: Hands of Eternal Light
    },
    -- Carapace of Sun and Shadow
    ["34369"] = {
        35218, -- Pattern: Carapace of Sun and Shadow
    },
    -- Gloves of Immortal Dusk
    ["34370"] = {
        35214, -- Pattern: Gloves of Immortal Dusk
    },
    -- Leather Chestguard of the Sun
    ["34371"] = {
        35216, -- Pattern: Leather Chestguard of the Sun
    },
    -- Leather Gauntlets of the Sun
    ["34372"] = {
        35212, -- Pattern: Leather Gauntlets of the Sun
    },
    -- Embrace of the Phoenix
    ["34373"] = {
        35217, -- Pattern: Embrace of the Phoenix
    },
    -- Fletcher's Gloves of the Phoenix
    ["34374"] = {
        35213, -- Pattern: Fletcher's Gloves of the Phoenix
    },
    -- Sun-Drenched Scale Chestguard
    ["34375"] = {
        35219, -- Pattern: Sun-Drenched Scale Chestguard
    },
    -- Sun-Drenched Scale Gloves
    ["34376"] = {
        35215, -- Pattern: Sun-Drenched Scale Gloves
    },
    -- Hard Khorium Battleplate
    ["34377"] = {
        35211, -- Plans: Hard Khorium Battleplate
    },
    -- Hard Khorium Battlefists
    ["34378"] = {
        35209, -- Plans: Hard Khorium Battlefists
    },
    -- Sunblessed Breastplate
    ["34379"] = {
        35210, -- Plans: Sunblessed Breastplate
    },
    -- Sunblessed Gauntlets
    ["34380"] = {
        35208, -- Plans: Sunblessed Gauntlets
    },
    -- Felstrength Legplates
    ["34381"] = {
        34180, -- Felfury Legplates
    },
    -- Judicator's Legguards
    ["34382"] = {
        34167, -- Legplates of the Holy Juggernaut
    },
    -- Kilt of Spiritual Reconstruction
    ["34383"] = {
        34186, -- Chain Links of the Tumultuous Storm
    },
    -- Breeches of Natural Splendor
    ["34384"] = {
        34169, -- Breeches of Natural Aggression
    },
    -- Leggings of the Immortal Beast
    ["34385"] = {
        34188, -- Leggings of the Immortal Night
    },
    -- Pantaloons of Growing Strife
    ["34386"] = {
        34170, -- Pantaloons of Calming Strife
    },
    -- Pauldrons of Berserking
    ["34388"] = {
        34192, -- Pauldrons of Perseverance
    },
    -- Spaulders of the Thalassian Defender
    ["34389"] = {
        34193, -- Spaulders of the Thalassian Savior
    },
    -- Erupting Epaulets
    ["34390"] = {
        34208, -- Equilibrium Epaulets
    },
    -- Spaulders of Devastation
    ["34391"] = {
        34209, -- Spaulders of Reclamation
    },
    -- Demontooth Shoulderpads
    ["34392"] = {
        34195, -- Shoulderpads of Vehemence
    },
    -- Shoulderpads of Knowledge's Pursuit
    ["34393"] = {
        34202, -- Shawl of Wonderment
    },
    -- Breastplate of Agony's Aversion
    ["34394"] = {
        34215, -- Warharness of Reckless Fury
    },
    -- Noble Judicator's Chestguard
    ["34395"] = {
        34216, -- Heroic Judicator's Chestguard
    },
    -- Garments of Crashing Shores
    ["34396"] = {
        34229, -- Garments of Serene Shores
    },
    -- Bladed Chaos Tunic
    ["34397"] = {
        34211, -- Harness of Carnal Instinct
    },
    -- Utopian Tunic of Elune
    ["34398"] = {
        34212, -- Sunglow Vest
    },
    -- Robes of Ghostly Hatred
    ["34399"] = {
        34233, -- Robes of Faltered Light
    },
    -- Crown of Dath'Remar
    ["34400"] = {
        34345, -- Crown of Anasterian
    },
    -- Helm of Uther's Resolve
    ["34401"] = {
        34243, -- Helm of Burning Righteousness
    },
    -- Shroud of Chieftain Ner'zhul
    ["34402"] = {
        34332, -- Cowl of Gul'dan
    },
    -- Cover of Ursoc the Mighty
    ["34403"] = {
        34245, -- Cover of Ursol the Wise
    },
    -- Mask of the Fury Hunter
    ["34404"] = {
        34244, -- Duplicitous Guise
    },
    -- Helm of Arcane Purity
    ["34405"] = {
        34339, -- Cowl of Light's Purity
    },
    -- Gloves of Tyri's Power
    ["34406"] = {
        34342, -- Handguards of the Dawn
    },
    -- Tranquil Moonlight Wraps
    ["34407"] = {
        34351, -- Tranquil Majesty Wraps
    },
    -- Gloves of the Forest Drifter
    ["34408"] = {
        34234, -- Shadowed Gauntlets of Paroxysm
    },
    -- Gauntlets of the Ancient Frostwolf
    ["34409"] = {
        34350, -- Gauntlets of the Ancient Shadowmoon
    },
    -- Lightbringer Bands
    ["34431"] = {
        34848, -- Bracers of the Forgotten Conqueror
    },
    -- Lightbringer Bracers
    ["34432"] = {
        34848, -- Bracers of the Forgotten Conqueror
    },
    -- Lightbringer Wristguards
    ["34433"] = {
        34848, -- Bracers of the Forgotten Conqueror
    },
    -- Bracers of Absolution
    ["34434"] = {
        34848, -- Bracers of the Forgotten Conqueror
    },
    -- Cuffs of Absolution
    ["34435"] = {
        34848, -- Bracers of the Forgotten Conqueror
    },
    -- Bracers of the Malefic
    ["34436"] = {
        34848, -- Bracers of the Forgotten Conqueror
    },
    -- Skyshatter Bands
    ["34437"] = {
        34851, -- Bracers of the Forgotten Protector
    },
    -- Skyshatter Bracers
    ["34438"] = {
        34851, -- Bracers of the Forgotten Protector
    },
    -- Skyshatter Wristguards
    ["34439"] = {
        34851, -- Bracers of the Forgotten Protector
    },
    -- Onslaught Bracers
    ["34441"] = {
        34851, -- Bracers of the Forgotten Protector
    },
    -- Onslaught Wristguards
    ["34442"] = {
        34851, -- Bracers of the Forgotten Protector
    },
    -- Gronnstalker's Bracers
    ["34443"] = {
        34851, -- Bracers of the Forgotten Protector
    },
    -- Thunderheart Wristguards
    ["34444"] = {
        34852, -- Bracers of the Forgotten Vanquisher
    },
    -- Thunderheart Bracers
    ["34445"] = {
        34852, -- Bracers of the Forgotten Vanquisher
    },
    -- Thunderheart Bands
    ["34446"] = {
        34852, -- Bracers of the Forgotten Vanquisher
    },
    -- Bracers of the Tempest
    ["34447"] = {
        34852, -- Bracers of the Forgotten Vanquisher
    },
    -- Slayer's Bracers
    ["34448"] = {
        34852, -- Bracers of the Forgotten Vanquisher
    },
    -- Lightbringer Girdle
    ["34485"] = {
        34853, -- Belt of the Forgotten Conqueror
    },
    -- Lightbringer Belt
    ["34487"] = {
        34853, -- Belt of the Forgotten Conqueror
    },
    -- Lightbringer Waistguard
    ["34488"] = {
        34853, -- Belt of the Forgotten Conqueror
    },
    -- Belt of Absolution
    ["34527"] = {
        34853, -- Belt of the Forgotten Conqueror
    },
    -- Cord of Absolution
    ["34528"] = {
        34853, -- Belt of the Forgotten Conqueror
    },
    -- Belt of the Malefic
    ["34541"] = {
        34853, -- Belt of the Forgotten Conqueror
    },
    -- Skyshatter Cord
    ["34542"] = {
        34854, -- Belt of the Forgotten Protector
    },
    -- Skyshatter Belt
    ["34543"] = {
        34854, -- Belt of the Forgotten Protector
    },
    -- Skyshatter Girdle
    ["34545"] = {
        34854, -- Belt of the Forgotten Protector
    },
    -- Onslaught Belt
    ["34546"] = {
        34854, -- Belt of the Forgotten Protector
    },
    -- Onslaught Waistguard
    ["34547"] = {
        34854, -- Belt of the Forgotten Protector
    },
    -- Gronnstalker's Belt
    ["34549"] = {
        34854, -- Belt of the Forgotten Protector
    },
    -- Thunderheart Belt
    ["34554"] = {
        34855, -- Belt of the Forgotten Vanquisher
    },
    -- Thunderheart Cord
    ["34555"] = {
        34855, -- Belt of the Forgotten Vanquisher
    },
    -- Thunderheart Waistguard
    ["34556"] = {
        34855, -- Belt of the Forgotten Vanquisher
    },
    -- Belt of the Tempest
    ["34557"] = {
        34855, -- Belt of the Forgotten Vanquisher
    },
    -- Slayer's Belt
    ["34558"] = {
        34855, -- Belt of the Forgotten Vanquisher
    },
    -- Lightbringer Treads
    ["34559"] = {
        34856, -- Boots of the Forgotten Conqueror
    },
    -- Lightbringer Stompers
    ["34560"] = {
        34856, -- Boots of the Forgotten Conqueror
    },
    -- Lightbringer Boots
    ["34561"] = {
        34856, -- Boots of the Forgotten Conqueror
    },
    -- Boots of Absolution
    ["34562"] = {
        34856, -- Boots of the Forgotten Conqueror
    },
    -- Treads of Absolution
    ["34563"] = {
        34856, -- Boots of the Forgotten Conqueror
    },
    -- Boots of the Malefic
    ["34564"] = {
        34856, -- Boots of the Forgotten Conqueror
    },
    -- Skyshatter Boots
    ["34565"] = {
        34857, -- Boots of the Forgotten Protector
    },
    -- Skyshatter Treads
    ["34566"] = {
        34857, -- Boots of the Forgotten Protector
    },
    -- Skyshatter Greaves
    ["34567"] = {
        34857, -- Boots of the Forgotten Protector
    },
    -- Onslaught Boots
    ["34568"] = {
        34857, -- Boots of the Forgotten Protector
    },
    -- Onslaught Treads
    ["34569"] = {
        34857, -- Boots of the Forgotten Protector
    },
    -- Gronnstalker's Boots
    ["34570"] = {
        34857, -- Boots of the Forgotten Protector
    },
    -- Thunderheart Boots
    ["34571"] = {
        34858, -- Boots of the Forgotten Vanquisher
    },
    -- Thunderheart Footwraps
    ["34572"] = {
        34858, -- Boots of the Forgotten Vanquisher
    },
    -- Thunderheart Treads
    ["34573"] = {
        34858, -- Boots of the Forgotten Vanquisher
    },
    -- Boots of the Tempest
    ["34574"] = {
        34858, -- Boots of the Forgotten Vanquisher
    },
    -- Slayer's Boots
    ["34575"] = {
        34858, -- Boots of the Forgotten Vanquisher
    },
    -- Annihilator Holo-Gogs
    ["34847"] = {
        35186, -- Schematic: Annihilator Holo-Gogs
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
    -- Powerheal 9000 Lens
    ["35181"] = {
        35189, -- Schematic: Powerheal 9000 Lens
    },
    -- Hyper-Magnified Moon Specs
    ["35182"] = {
        35190, -- Schematic: Hyper-Magnified Moon Specs
    },
    -- Primal-Attuned Goggles
    ["35184"] = {
        35192, -- Schematic: Primal-Attuned Goggles
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
    -- Schematic: Lightning Etched Specs
    ["35193"] = {
        34355, -- Lightning Etched Specs
    },
    -- Schematic: Surestrike Goggles v3.0
    ["35194"] = {
        34356, -- Surestrike Goggles v3.0
    },
    -- Schematic: Mayhem Projection Goggles
    ["35195"] = {
        34354, -- Mayhem Projection Goggles
    },
    -- Schematic: Hard Khorium Goggles
    ["35196"] = {
        34357, -- Hard Khorium Goggles
    },
    -- Pattern: Sunfire Handwraps
    ["35204"] = {
        34366, -- Sunfire Handwraps
    },
    -- Pattern: Hands of Eternal Light
    ["35205"] = {
        34367, -- Hands of Eternal Light
    },
    -- Pattern: Sunfire Robe
    ["35206"] = {
        34364, -- Sunfire Robe
    },
    -- Pattern: Robe of Eternal Light
    ["35207"] = {
        34365, -- Robe of Eternal Light
    },
    -- Plans: Sunblessed Gauntlets
    ["35208"] = {
        34380, -- Sunblessed Gauntlets
    },
    -- Plans: Hard Khorium Battlefists
    ["35209"] = {
        34378, -- Hard Khorium Battlefists
    },
    -- Plans: Sunblessed Breastplate
    ["35210"] = {
        34379, -- Sunblessed Breastplate
    },
    -- Plans: Hard Khorium Battleplate
    ["35211"] = {
        34377, -- Hard Khorium Battleplate
    },
    -- Pattern: Leather Gauntlets of the Sun
    ["35212"] = {
        34372, -- Leather Gauntlets of the Sun
    },
    -- Pattern: Fletcher's Gloves of the Phoenix
    ["35213"] = {
        34374, -- Fletcher's Gloves of the Phoenix
    },
    -- Pattern: Gloves of Immortal Dusk
    ["35214"] = {
        34370, -- Gloves of Immortal Dusk
    },
    -- Pattern: Sun-Drenched Scale Gloves
    ["35215"] = {
        34376, -- Sun-Drenched Scale Gloves
    },
    -- Pattern: Leather Chestguard of the Sun
    ["35216"] = {
        34371, -- Leather Chestguard of the Sun
    },
    -- Pattern: Embrace of the Phoenix
    ["35217"] = {
        34373, -- Embrace of the Phoenix
    },
    -- Pattern: Carapace of Sun and Shadow
    ["35218"] = {
        34369, -- Carapace of Sun and Shadow
    },
    -- Pattern: Sun-Drenched Scale Chestguard
    ["35219"] = {
        34375, -- Sun-Drenched Scale Chestguard
    },
    -- Heroes' Frostfire Circlet
    ["39491"] = {
        40618, -- Helm of the Lost Vanquisher
    },
    -- Heroes' Frostfire Robe
    ["39492"] = {
        40612, -- Chestguard of the Lost Vanquisher
    },
    -- Heroes' Frostfire Leggings
    ["39493"] = {
        40621, -- Leggings of the Lost Vanquisher
    },
    -- Heroes' Frostfire Shoulderpads
    ["39494"] = {
        40624, -- Spaulders of the Lost Vanquisher
    },
    -- Heroes' Frostfire Gloves
    ["39495"] = {
        40615, -- Gloves of the Lost Vanquisher
    },
    -- Heroes' Plagueheart Circlet
    ["39496"] = {
        40616, -- Helm of the Lost Conqueror
    },
    -- Heroes' Plagueheart Robe
    ["39497"] = {
        40610, -- Chestguard of the Lost Conqueror
    },
    -- Heroes' Plagueheart Leggings
    ["39498"] = {
        40619, -- Leggings of the Lost Conqueror
    },
    -- Heroes' Plagueheart Shoulderpads
    ["39499"] = {
        40622, -- Spaulders of the Lost Conqueror
    },
    -- Heroes' Plagueheart Gloves
    ["39500"] = {
        40613, -- Gloves of the Lost Conqueror
    },
    -- Heroes' Crown of Faith
    ["39514"] = {
        40616, -- Helm of the Lost Conqueror
    },
    -- Heroes' Robe of Faith
    ["39515"] = {
        40610, -- Chestguard of the Lost Conqueror
    },
    -- Heroes' Leggings of Faith
    ["39517"] = {
        40619, -- Leggings of the Lost Conqueror
    },
    -- Heroes' Shoulderpads of Faith
    ["39518"] = {
        40622, -- Spaulders of the Lost Conqueror
    },
    -- Heroes' Gloves of Faith
    ["39519"] = {
        40613, -- Gloves of the Lost Conqueror
    },
    -- Heroes' Circlet of Faith
    ["39521"] = {
        40616, -- Helm of the Lost Conqueror
    },
    -- Heroes' Raiments of Faith
    ["39523"] = {
        40610, -- Chestguard of the Lost Conqueror
    },
    -- Heroes' Pants of Faith
    ["39528"] = {
        40619, -- Leggings of the Lost Conqueror
    },
    -- Heroes' Mantle of Faith
    ["39529"] = {
        40622, -- Spaulders of the Lost Conqueror
    },
    -- Heroes' Handwraps of Faith
    ["39530"] = {
        40613, -- Gloves of the Lost Conqueror
    },
    -- Heroes' Dreamwalker Headpiece
    ["39531"] = {
        40618, -- Helm of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Robe
    ["39538"] = {
        40612, -- Chestguard of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Leggings
    ["39539"] = {
        40621, -- Leggings of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Spaulders
    ["39542"] = {
        40624, -- Spaulders of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Handguards
    ["39543"] = {
        40615, -- Gloves of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Gloves
    ["39544"] = {
        40615, -- Gloves of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Cover
    ["39545"] = {
        40618, -- Helm of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Trousers
    ["39546"] = {
        40621, -- Leggings of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Vestments
    ["39547"] = {
        40612, -- Chestguard of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Mantle
    ["39548"] = {
        40624, -- Spaulders of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Headguard
    ["39553"] = {
        40618, -- Helm of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Raiments
    ["39554"] = {
        40612, -- Chestguard of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Legguards
    ["39555"] = {
        40621, -- Leggings of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Shoulderpads
    ["39556"] = {
        40624, -- Spaulders of the Lost Vanquisher
    },
    -- Heroes' Dreamwalker Handgrips
    ["39557"] = {
        40615, -- Gloves of the Lost Vanquisher
    },
    -- Heroes' Bonescythe Breastplate
    ["39558"] = {
        40612, -- Chestguard of the Lost Vanquisher
    },
    -- Heroes' Bonescythe Gauntlets
    ["39560"] = {
        40615, -- Gloves of the Lost Vanquisher
    },
    -- Heroes' Bonescythe Helmet
    ["39561"] = {
        40618, -- Helm of the Lost Vanquisher
    },
    -- Heroes' Bonescythe Legplates
    ["39564"] = {
        40621, -- Leggings of the Lost Vanquisher
    },
    -- Heroes' Bonescythe Pauldrons
    ["39565"] = {
        40624, -- Spaulders of the Lost Vanquisher
    },
    -- Heroes' Cryptstalker Headpiece
    ["39578"] = {
        40617, -- Helm of the Lost Protector
    },
    -- Heroes' Cryptstalker Tunic
    ["39579"] = {
        40611, -- Chestguard of the Lost Protector
    },
    -- Heroes' Cryptstalker Legguards
    ["39580"] = {
        40620, -- Leggings of the Lost Protector
    },
    -- Heroes' Cryptstalker Spaulders
    ["39581"] = {
        40623, -- Spaulders of the Lost Protector
    },
    -- Heroes' Cryptstalker Handguards
    ["39582"] = {
        40614, -- Gloves of the Lost Protector
    },
    -- Heroes' Earthshatter Headpiece
    ["39583"] = {
        40617, -- Helm of the Lost Protector
    },
    -- Heroes' Earthshatter Tunic
    ["39588"] = {
        40611, -- Chestguard of the Lost Protector
    },
    -- Heroes' Earthshatter Legguards
    ["39589"] = {
        40620, -- Leggings of the Lost Protector
    },
    -- Heroes' Earthshatter Spaulders
    ["39590"] = {
        40623, -- Spaulders of the Lost Protector
    },
    -- Heroes' Earthshatter Handguards
    ["39591"] = {
        40614, -- Gloves of the Lost Protector
    },
    -- Heroes' Earthshatter Hauberk
    ["39592"] = {
        40611, -- Chestguard of the Lost Protector
    },
    -- Heroes' Earthshatter Gloves
    ["39593"] = {
        40614, -- Gloves of the Lost Protector
    },
    -- Heroes' Earthshatter Helm
    ["39594"] = {
        40617, -- Helm of the Lost Protector
    },
    -- Heroes' Earthshatter Kilt
    ["39595"] = {
        40620, -- Leggings of the Lost Protector
    },
    -- Heroes' Earthshatter Shoulderpads
    ["39596"] = {
        40623, -- Spaulders of the Lost Protector
    },
    -- Heroes' Earthshatter Chestguard
    ["39597"] = {
        40611, -- Chestguard of the Lost Protector
    },
    -- Heroes' Earthshatter Grips
    ["39601"] = {
        40614, -- Gloves of the Lost Protector
    },
    -- Heroes' Earthshatter Faceguard
    ["39602"] = {
        40617, -- Helm of the Lost Protector
    },
    -- Heroes' Earthshatter War-Kilt
    ["39603"] = {
        40620, -- Leggings of the Lost Protector
    },
    -- Heroes' Earthshatter Shoulderguards
    ["39604"] = {
        40623, -- Spaulders of the Lost Protector
    },
    -- Heroes' Dreadnaught Helmet
    ["39605"] = {
        40617, -- Helm of the Lost Protector
    },
    -- Heroes' Dreadnaught Battleplate
    ["39606"] = {
        40611, -- Chestguard of the Lost Protector
    },
    -- Heroes' Dreadnaught Legplates
    ["39607"] = {
        40620, -- Leggings of the Lost Protector
    },
    -- Heroes' Dreadnaught Shoulderplates
    ["39608"] = {
        40623, -- Spaulders of the Lost Protector
    },
    -- Heroes' Dreadnaught Gauntlets
    ["39609"] = {
        40614, -- Gloves of the Lost Protector
    },
    -- Heroes' Dreadnaught Greathelm
    ["39610"] = {
        40617, -- Helm of the Lost Protector
    },
    -- Heroes' Dreadnaught Breastplate
    ["39611"] = {
        40611, -- Chestguard of the Lost Protector
    },
    -- Heroes' Dreadnaught Legguards
    ["39612"] = {
        40620, -- Leggings of the Lost Protector
    },
    -- Heroes' Dreadnaught Pauldrons
    ["39613"] = {
        40623, -- Spaulders of the Lost Protector
    },
    -- Heroes' Scourgeborne Battleplate
    ["39617"] = {
        40612, -- Chestguard of the Lost Vanquisher
    },
    -- Heroes' Scourgeborne Gauntlets
    ["39618"] = {
        40615, -- Gloves of the Lost Vanquisher
    },
    -- Heroes' Scourgeborne Helmet
    ["39619"] = {
        40618, -- Helm of the Lost Vanquisher
    },
    -- Heroes' Scourgeborne Legplates
    ["39620"] = {
        40621, -- Leggings of the Lost Vanquisher
    },
    -- Heroes' Scourgeborne Shoulderplates
    ["39621"] = {
        40624, -- Spaulders of the Lost Vanquisher
    },
    -- Heroes' Dreadnaught Handguards
    ["39622"] = {
        40614, -- Gloves of the Lost Protector
    },
    -- Heroes' Scourgeborne Chestguard
    ["39623"] = {
        40612, -- Chestguard of the Lost Vanquisher
    },
    -- Heroes' Scourgeborne Handguards
    ["39624"] = {
        40615, -- Gloves of the Lost Vanquisher
    },
    -- Heroes' Scourgeborne Faceguard
    ["39625"] = {
        40618, -- Helm of the Lost Vanquisher
    },
    -- Heroes' Scourgeborne Legguards
    ["39626"] = {
        40621, -- Leggings of the Lost Vanquisher
    },
    -- Heroes' Scourgeborne Pauldrons
    ["39627"] = {
        40624, -- Spaulders of the Lost Vanquisher
    },
    -- Heroes' Redemption Headpiece
    ["39628"] = {
        40616, -- Helm of the Lost Conqueror
    },
    -- Heroes' Redemption Tunic
    ["39629"] = {
        40610, -- Chestguard of the Lost Conqueror
    },
    -- Heroes' Redemption Greaves
    ["39630"] = {
        40619, -- Leggings of the Lost Conqueror
    },
    -- Heroes' Redemption Spaulders
    ["39631"] = {
        40622, -- Spaulders of the Lost Conqueror
    },
    -- Heroes' Redemption Gloves
    ["39632"] = {
        40613, -- Gloves of the Lost Conqueror
    },
    -- Heroes' Redemption Chestpiece
    ["39633"] = {
        40610, -- Chestguard of the Lost Conqueror
    },
    -- Heroes' Redemption Gauntlets
    ["39634"] = {
        40613, -- Gloves of the Lost Conqueror
    },
    -- Heroes' Redemption Helm
    ["39635"] = {
        40616, -- Helm of the Lost Conqueror
    },
    -- Heroes' Redemption Legplates
    ["39636"] = {
        40619, -- Leggings of the Lost Conqueror
    },
    -- Heroes' Redemption Shoulderplates
    ["39637"] = {
        40622, -- Spaulders of the Lost Conqueror
    },
    -- Heroes' Redemption Breastplate
    ["39638"] = {
        40610, -- Chestguard of the Lost Conqueror
    },
    -- Heroes' Redemption Handguards
    ["39639"] = {
        40613, -- Gloves of the Lost Conqueror
    },
    -- Heroes' Redemption Faceguard
    ["39640"] = {
        40616, -- Helm of the Lost Conqueror
    },
    -- Heroes' Redemption Legguards
    ["39641"] = {
        40619, -- Leggings of the Lost Conqueror
    },
    -- Heroes' Redemption Shoulderguards
    ["39642"] = {
        40622, -- Spaulders of the Lost Conqueror
    },
    -- Valorous Frostfire Gloves
    ["40415"] = {
        40630, -- Gauntlets of the Lost Vanquisher
    },
    -- Valorous Frostfire Circlet
    ["40416"] = {
        40633, -- Crown of the Lost Vanquisher
    },
    -- Valorous Frostfire Leggings
    ["40417"] = {
        40636, -- Legplates of the Lost Vanquisher
    },
    -- Valorous Frostfire Robe
    ["40418"] = {
        40627, -- Breastplate of the Lost Vanquisher
    },
    -- Valorous Frostfire Shoulderpads
    ["40419"] = {
        40639, -- Mantle of the Lost Vanquisher
    },
    -- Valorous Plagueheart Gloves
    ["40420"] = {
        40628, -- Gauntlets of the Lost Conqueror
    },
    -- Valorous Plagueheart Circlet
    ["40421"] = {
        40631, -- Crown of the Lost Conqueror
    },
    -- Valorous Plagueheart Leggings
    ["40422"] = {
        40634, -- Legplates of the Lost Conqueror
    },
    -- Valorous Plagueheart Robe
    ["40423"] = {
        40625, -- Breastplate of the Lost Conqueror
    },
    -- Valorous Plagueheart Shoulderpads
    ["40424"] = {
        40637, -- Mantle of the Lost Conqueror
    },
    -- Valorous Gloves of Faith
    ["40445"] = {
        40628, -- Gauntlets of the Lost Conqueror
    },
    -- Valorous Crown of Faith
    ["40447"] = {
        40631, -- Crown of the Lost Conqueror
    },
    -- Valorous Leggings of Faith
    ["40448"] = {
        40634, -- Legplates of the Lost Conqueror
    },
    -- Valorous Robe of Faith
    ["40449"] = {
        40625, -- Breastplate of the Lost Conqueror
    },
    -- Valorous Shoulderpads of Faith
    ["40450"] = {
        40637, -- Mantle of the Lost Conqueror
    },
    -- Valorous Handwraps of Faith
    ["40454"] = {
        40628, -- Gauntlets of the Lost Conqueror
    },
    -- Valorous Circlet of Faith
    ["40456"] = {
        40631, -- Crown of the Lost Conqueror
    },
    -- Valorous Pants of Faith
    ["40457"] = {
        40634, -- Legplates of the Lost Conqueror
    },
    -- Valorous Raiments of Faith
    ["40458"] = {
        40625, -- Breastplate of the Lost Conqueror
    },
    -- Valorous Mantle of Faith
    ["40459"] = {
        40637, -- Mantle of the Lost Conqueror
    },
    -- Valorous Dreamwalker Handguards
    ["40460"] = {
        40630, -- Gauntlets of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Headpiece
    ["40461"] = {
        40633, -- Crown of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Leggings
    ["40462"] = {
        40636, -- Legplates of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Robe
    ["40463"] = {
        40627, -- Breastplate of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Spaulders
    ["40465"] = {
        40639, -- Mantle of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Gloves
    ["40466"] = {
        40630, -- Gauntlets of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Cover
    ["40467"] = {
        40633, -- Crown of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Trousers
    ["40468"] = {
        40636, -- Legplates of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Vestments
    ["40469"] = {
        40627, -- Breastplate of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Mantle
    ["40470"] = {
        40639, -- Mantle of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Raiments
    ["40471"] = {
        40627, -- Breastplate of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Handgrips
    ["40472"] = {
        40630, -- Gauntlets of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Headguard
    ["40473"] = {
        40633, -- Crown of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Legguards
    ["40493"] = {
        40636, -- Legplates of the Lost Vanquisher
    },
    -- Valorous Dreamwalker Shoulderpads
    ["40494"] = {
        40639, -- Mantle of the Lost Vanquisher
    },
    -- Valorous Bonescythe Breastplate
    ["40495"] = {
        40627, -- Breastplate of the Lost Vanquisher
    },
    -- Valorous Bonescythe Gauntlets
    ["40496"] = {
        40630, -- Gauntlets of the Lost Vanquisher
    },
    -- Valorous Bonescythe Helmet
    ["40499"] = {
        40633, -- Crown of the Lost Vanquisher
    },
    -- Valorous Bonescythe Legplates
    ["40500"] = {
        40636, -- Legplates of the Lost Vanquisher
    },
    -- Valorous Bonescythe Pauldrons
    ["40502"] = {
        40639, -- Mantle of the Lost Vanquisher
    },
    -- Valorous Cryptstalker Tunic
    ["40503"] = {
        40626, -- Breastplate of the Lost Protector
    },
    -- Valorous Cryptstalker Handguards
    ["40504"] = {
        40629, -- Gauntlets of the Lost Protector
    },
    -- Valorous Cryptstalker Headpiece
    ["40505"] = {
        40632, -- Crown of the Lost Protector
    },
    -- Valorous Cryptstalker Legguards
    ["40506"] = {
        40635, -- Legplates of the Lost Protector
    },
    -- Valorous Cryptstalker Spaulders
    ["40507"] = {
        40638, -- Mantle of the Lost Protector
    },
    -- Valorous Earthshatter Tunic
    ["40508"] = {
        40626, -- Breastplate of the Lost Protector
    },
    -- Valorous Earthshatter Handguards
    ["40509"] = {
        40629, -- Gauntlets of the Lost Protector
    },
    -- Valorous Earthshatter Headpiece
    ["40510"] = {
        40632, -- Crown of the Lost Protector
    },
    -- Valorous Earthshatter Legguards
    ["40512"] = {
        40635, -- Legplates of the Lost Protector
    },
    -- Valorous Earthshatter Spaulders
    ["40513"] = {
        40638, -- Mantle of the Lost Protector
    },
    -- Valorous Earthshatter Hauberk
    ["40514"] = {
        40626, -- Breastplate of the Lost Protector
    },
    -- Valorous Earthshatter Gloves
    ["40515"] = {
        40629, -- Gauntlets of the Lost Protector
    },
    -- Valorous Earthshatter Helm
    ["40516"] = {
        40632, -- Crown of the Lost Protector
    },
    -- Valorous Earthshatter Kilt
    ["40517"] = {
        40635, -- Legplates of the Lost Protector
    },
    -- Valorous Earthshatter Shoulderpads
    ["40518"] = {
        40638, -- Mantle of the Lost Protector
    },
    -- Valorous Earthshatter Grips
    ["40520"] = {
        40629, -- Gauntlets of the Lost Protector
    },
    -- Valorous Earthshatter Faceguard
    ["40521"] = {
        40632, -- Crown of the Lost Protector
    },
    -- Valorous Earthshatter War-Kilt
    ["40522"] = {
        40635, -- Legplates of the Lost Protector
    },
    -- Valorous Earthshatter Chestguard
    ["40523"] = {
        40626, -- Breastplate of the Lost Protector
    },
    -- Valorous Earthshatter Shoulderguards
    ["40524"] = {
        40638, -- Mantle of the Lost Protector
    },
    -- Valorous Dreadnaught Battleplate
    ["40525"] = {
        40626, -- Breastplate of the Lost Protector
    },
    -- Valorous Dreadnaught Gauntlets
    ["40527"] = {
        40629, -- Gauntlets of the Lost Protector
    },
    -- Valorous Dreadnaught Helmet
    ["40528"] = {
        40632, -- Crown of the Lost Protector
    },
    -- Valorous Dreadnaught Legplates
    ["40529"] = {
        40635, -- Legplates of the Lost Protector
    },
    -- Valorous Dreadnaught Shoulderplates
    ["40530"] = {
        40638, -- Mantle of the Lost Protector
    },
    -- Valorous Dreadnaught Breastplate
    ["40544"] = {
        40626, -- Breastplate of the Lost Protector
    },
    -- Valorous Dreadnaught Handguards
    ["40545"] = {
        40629, -- Gauntlets of the Lost Protector
    },
    -- Valorous Dreadnaught Greathelm
    ["40546"] = {
        40632, -- Crown of the Lost Protector
    },
    -- Valorous Dreadnaught Legguards
    ["40547"] = {
        40635, -- Legplates of the Lost Protector
    },
    -- Valorous Dreadnaught Pauldrons
    ["40548"] = {
        40638, -- Mantle of the Lost Protector
    },
    -- Valorous Scourgeborne Battleplate
    ["40550"] = {
        40627, -- Breastplate of the Lost Vanquisher
    },
    -- Valorous Scourgeborne Gauntlets
    ["40552"] = {
        40630, -- Gauntlets of the Lost Vanquisher
    },
    -- Valorous Scourgeborne Helmet
    ["40554"] = {
        40633, -- Crown of the Lost Vanquisher
    },
    -- Valorous Scourgeborne Legplates
    ["40556"] = {
        40636, -- Legplates of the Lost Vanquisher
    },
    -- Valorous Scourgeborne Shoulderplates
    ["40557"] = {
        40639, -- Mantle of the Lost Vanquisher
    },
    -- Valorous Scourgeborne Chestguard
    ["40559"] = {
        40627, -- Breastplate of the Lost Vanquisher
    },
    -- Valorous Scourgeborne Handguards
    ["40563"] = {
        40630, -- Gauntlets of the Lost Vanquisher
    },
    -- Valorous Scourgeborne Faceguard
    ["40565"] = {
        40633, -- Crown of the Lost Vanquisher
    },
    -- Valorous Scourgeborne Legguards
    ["40567"] = {
        40636, -- Legplates of the Lost Vanquisher
    },
    -- Valorous Scourgeborne Pauldrons
    ["40568"] = {
        40639, -- Mantle of the Lost Vanquisher
    },
    -- Valorous Redemption Tunic
    ["40569"] = {
        40625, -- Breastplate of the Lost Conqueror
    },
    -- Valorous Redemption Gloves
    ["40570"] = {
        40628, -- Gauntlets of the Lost Conqueror
    },
    -- Valorous Redemption Headpiece
    ["40571"] = {
        40631, -- Crown of the Lost Conqueror
    },
    -- Valorous Redemption Greaves
    ["40572"] = {
        40634, -- Legplates of the Lost Conqueror
    },
    -- Valorous Redemption Spaulders
    ["40573"] = {
        40637, -- Mantle of the Lost Conqueror
    },
    -- Valorous Redemption Chestpiece
    ["40574"] = {
        40625, -- Breastplate of the Lost Conqueror
    },
    -- Valorous Redemption Gauntlets
    ["40575"] = {
        40628, -- Gauntlets of the Lost Conqueror
    },
    -- Valorous Redemption Helm
    ["40576"] = {
        40631, -- Crown of the Lost Conqueror
    },
    -- Valorous Redemption Legplates
    ["40577"] = {
        40634, -- Legplates of the Lost Conqueror
    },
    -- Valorous Redemption Shoulderplates
    ["40578"] = {
        40637, -- Mantle of the Lost Conqueror
    },
    -- Valorous Redemption Breastplate
    ["40579"] = {
        40625, -- Breastplate of the Lost Conqueror
    },
    -- Valorous Redemption Handguards
    ["40580"] = {
        40628, -- Gauntlets of the Lost Conqueror
    },
    -- Valorous Redemption Faceguard
    ["40581"] = {
        40631, -- Crown of the Lost Conqueror
    },
    -- Valorous Redemption Legguards
    ["40583"] = {
        40634, -- Legplates of the Lost Conqueror
    },
    -- Valorous Redemption Shoulderguards
    ["40584"] = {
        40637, -- Mantle of the Lost Conqueror
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
    -- Chestguard of the Lost Protector
    ["40611"] = {
        39579, -- Heroes' Cryptstalker Tunic
        39588, -- Heroes' Earthshatter Tunic
        39592, -- Heroes' Earthshatter Hauberk
        39597, -- Heroes' Earthshatter Chestguard
        39606, -- Heroes' Dreadnaught Battleplate
        39611, -- Heroes' Dreadnaught Breastplate
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
    -- Gloves of the Lost Conqueror
    ["40613"] = {
        39500, -- Heroes' Plagueheart Gloves
        39519, -- Heroes' Gloves of Faith
        39530, -- Heroes' Handwraps of Faith
        39632, -- Heroes' Redemption Gloves
        39634, -- Heroes' Redemption Gauntlets
        39639, -- Heroes' Redemption Handguards
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
    -- Helm of the Lost Protector
    ["40617"] = {
        39578, -- Heroes' Cryptstalker Headpiece
        39583, -- Heroes' Earthshatter Headpiece
        39594, -- Heroes' Earthshatter Helm
        39602, -- Heroes' Earthshatter Faceguard
        39605, -- Heroes' Dreadnaught Helmet
        39610, -- Heroes' Dreadnaught Greathelm
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
    -- Leggings of the Lost Conqueror
    ["40619"] = {
        39498, -- Heroes' Plagueheart Leggings
        39517, -- Heroes' Leggings of Faith
        39528, -- Heroes' Pants of Faith
        39630, -- Heroes' Redemption Greaves
        39636, -- Heroes' Redemption Legplates
        39641, -- Heroes' Redemption Legguards
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
    -- Spaulders of the Lost Conqueror
    ["40622"] = {
        39499, -- Heroes' Plagueheart Shoulderpads
        39518, -- Heroes' Shoulderpads of Faith
        39529, -- Heroes' Mantle of Faith
        39631, -- Heroes' Redemption Spaulders
        39637, -- Heroes' Redemption Shoulderplates
        39642, -- Heroes' Redemption Shoulderguards
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
    -- Breastplate of the Lost Conqueror
    ["40625"] = {
        40423, -- Valorous Plagueheart Robe
        40449, -- Valorous Robe of Faith
        40458, -- Valorous Raiments of Faith
        40569, -- Valorous Redemption Tunic
        40574, -- Valorous Redemption Chestpiece
        40579, -- Valorous Redemption Breastplate
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
    -- Gauntlets of the Lost Conqueror
    ["40628"] = {
        40420, -- Valorous Plagueheart Gloves
        40445, -- Valorous Gloves of Faith
        40454, -- Valorous Handwraps of Faith
        40570, -- Valorous Redemption Gloves
        40575, -- Valorous Redemption Gauntlets
        40580, -- Valorous Redemption Handguards
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
    -- Crown of the Lost Conqueror
    ["40631"] = {
        40421, -- Valorous Plagueheart Circlet
        40447, -- Valorous Crown of Faith
        40456, -- Valorous Circlet of Faith
        40571, -- Valorous Redemption Headpiece
        40576, -- Valorous Redemption Helm
        40581, -- Valorous Redemption Faceguard
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
    -- Legplates of the Lost Conqueror
    ["40634"] = {
        40422, -- Valorous Plagueheart Leggings
        40448, -- Valorous Leggings of Faith
        40457, -- Valorous Pants of Faith
        40572, -- Valorous Redemption Greaves
        40577, -- Valorous Redemption Legplates
        40583, -- Valorous Redemption Legguards
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
    -- Mantle of the Lost Conqueror
    ["40637"] = {
        40424, -- Valorous Plagueheart Shoulderpads
        40450, -- Valorous Shoulderpads of Faith
        40459, -- Valorous Mantle of Faith
        40573, -- Valorous Redemption Spaulders
        40578, -- Valorous Redemption Shoulderplates
        40584, -- Valorous Redemption Shoulderguards
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
    -- Key to the Focusing Iris
    ["44569"] = {
        44582, -- Key to the Focusing Iris
        44650, -- Heart of Magic (Normal)
        44657, -- Torque of the Red Dragonflight
        44658, -- Chain of the Ancient Wyrm
        44659, -- Pendant of the Dragonsworn
        44660, -- Drakescale Collar
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
    -- Heroic Key to the Focusing Iris
    ["44581"] = {
        44577, -- Heroic Key to the Focusing Iris
    },
    -- Key to the Focusing Iris
    ["44582"] = {
        44569, -- Key to the Focusing Iris
    },
    -- Heart of Magic (Normal)
    ["44650"] = {
        44569, -- Key to the Focusing Iris
    },
    -- Heart of Magic (Heroic)
    ["44651"] = {
        44577, -- Heroic Key to the Focusing Iris
    },
    -- Torque of the Red Dragonflight
    ["44657"] = {
        44569, -- Key to the Focusing Iris
    },
    -- Chain of the Ancient Wyrm
    ["44658"] = {
        44569, -- Key to the Focusing Iris
    },
    -- Pendant of the Dragonsworn
    ["44659"] = {
        44569, -- Key to the Focusing Iris
    },
    -- Drakescale Collar
    ["44660"] = {
        44569, -- Key to the Focusing Iris
    },
    -- Wyrmrest Necklace of Power
    ["44661"] = {
        44577, -- Heroic Key to the Focusing Iris
    },
    -- Life-Binder's Locket
    ["44662"] = {
        44577, -- Heroic Key to the Focusing Iris
    },
    -- Favor of the Dragon Queen
    ["44664"] = {
        44577, -- Heroic Key to the Focusing Iris
    },
    -- Nexus War Champion Beads
    ["44665"] = {
        44577, -- Heroic Key to the Focusing Iris
    },
    -- Fragment of Val'anyr
    ["45038"] = {
        45039, -- Shattered Fragments of Val'anyr
        45896, -- Unbound Fragments of Val'anyr
        45897, -- Reforged Hammer of Ancient Kings
        46017, -- Val'anyr, Hammer of Ancient Kings
    },
    -- Shattered Fragments of Val'anyr
    ["45039"] = {
        45038, -- Fragment of Val'anyr
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
    -- Valorous Darkruned Chestguard
    ["45335"] = {
        45637, -- Chestguard of the Wayward Vanquisher
    },
    -- Valorous Darkruned Faceguard
    ["45336"] = {
        45649, -- Helm of the Wayward Vanquisher
    },
    -- Valorous Darkruned Handguards
    ["45337"] = {
        45646, -- Gloves of the Wayward Vanquisher
    },
    -- Valorous Darkruned Legguards
    ["45338"] = {
        45652, -- Leggings of the Wayward Vanquisher
    },
    -- Valorous Darkruned Pauldrons
    ["45339"] = {
        45661, -- Spaulders of the Wayward Vanquisher
    },
    -- Valorous Darkruned Battleplate
    ["45340"] = {
        45637, -- Chestguard of the Wayward Vanquisher
    },
    -- Valorous Darkruned Gauntlets
    ["45341"] = {
        45646, -- Gloves of the Wayward Vanquisher
    },
    -- Valorous Darkruned Helmet
    ["45342"] = {
        45649, -- Helm of the Wayward Vanquisher
    },
    -- Valorous Darkruned Legplates
    ["45343"] = {
        45652, -- Leggings of the Wayward Vanquisher
    },
    -- Valorous Darkruned Shoulderplates
    ["45344"] = {
        45661, -- Spaulders of the Wayward Vanquisher
    },
    -- Valorous Nightsong Handguards
    ["45345"] = {
        45646, -- Gloves of the Wayward Vanquisher
    },
    -- Valorous Nightsong Headpiece
    ["45346"] = {
        45649, -- Helm of the Wayward Vanquisher
    },
    -- Valorous Nightsong Leggings
    ["45347"] = {
        45652, -- Leggings of the Wayward Vanquisher
    },
    -- Valorous Nightsong Robe
    ["45348"] = {
        45637, -- Chestguard of the Wayward Vanquisher
    },
    -- Valorous Nightsong Spaulders
    ["45349"] = {
        45661, -- Spaulders of the Wayward Vanquisher
    },
    -- Valorous Nightsong Gloves
    ["45351"] = {
        45646, -- Gloves of the Wayward Vanquisher
    },
    -- Valorous Nightsong Mantle
    ["45352"] = {
        45661, -- Spaulders of the Wayward Vanquisher
    },
    -- Valorous Nightsong Trousers
    ["45353"] = {
        45652, -- Leggings of the Wayward Vanquisher
    },
    -- Valorous Nightsong Vestments
    ["45354"] = {
        45637, -- Chestguard of the Wayward Vanquisher
    },
    -- Valorous Nightsong Handgrips
    ["45355"] = {
        45646, -- Gloves of the Wayward Vanquisher
    },
    -- Valorous Nightsong Headguard
    ["45356"] = {
        45649, -- Helm of the Wayward Vanquisher
    },
    -- Valorous Nightsong Legguards
    ["45357"] = {
        45652, -- Leggings of the Wayward Vanquisher
    },
    -- Valorous Nightsong Raiments
    ["45358"] = {
        45637, -- Chestguard of the Wayward Vanquisher
    },
    -- Valorous Nightsong Shoulderpads
    ["45359"] = {
        45661, -- Spaulders of the Wayward Vanquisher
    },
    -- Valorous Scourgestalker Handguards
    ["45360"] = {
        45645, -- Gloves of the Wayward Protector
    },
    -- Valorous Scourgestalker Headpiece
    ["45361"] = {
        45648, -- Helm of the Wayward Protector
    },
    -- Valorous Scourgestalker Legguards
    ["45362"] = {
        45651, -- Leggings of the Wayward Protector
    },
    -- Valorous Scourgestalker Spaulders
    ["45363"] = {
        45660, -- Spaulders of the Wayward Protector
    },
    -- Valorous Scourgestalker Tunic
    ["45364"] = {
        45636, -- Chestguard of the Wayward Protector
    },
    -- Valorous Kirin Tor Hood
    ["45365"] = {
        45649, -- Helm of the Wayward Vanquisher
    },
    -- Valorous Kirin Tor Leggings
    ["45367"] = {
        45652, -- Leggings of the Wayward Vanquisher
    },
    -- Valorous Kirin Tor Tunic
    ["45368"] = {
        45637, -- Chestguard of the Wayward Vanquisher
    },
    -- Valorous Kirin Tor Shoulderpads
    ["45369"] = {
        45661, -- Spaulders of the Wayward Vanquisher
    },
    -- Valorous Aegis Gloves
    ["45370"] = {
        45644, -- Gloves of the Wayward Conqueror
    },
    -- Valorous Aegis Greaves
    ["45371"] = {
        45650, -- Leggings of the Wayward Conqueror
    },
    -- Valorous Aegis Headpiece
    ["45372"] = {
        45647, -- Helm of the Wayward Conqueror
    },
    -- Valorous Aegis Spaulders
    ["45373"] = {
        45659, -- Spaulders of the Wayward Conqueror
    },
    -- Valorous Aegis Tunic
    ["45374"] = {
        45635, -- Chestguard of the Wayward Conqueror
    },
    -- Valorous Aegis Battleplate
    ["45375"] = {
        45635, -- Chestguard of the Wayward Conqueror
    },
    -- Valorous Aegis Gauntlets
    ["45376"] = {
        45644, -- Gloves of the Wayward Conqueror
    },
    -- Valorous Aegis Helm
    ["45377"] = {
        45647, -- Helm of the Wayward Conqueror
    },
    -- Valorous Aegis Legplates
    ["45379"] = {
        45650, -- Leggings of the Wayward Conqueror
    },
    -- Valorous Aegis Shoulderplates
    ["45380"] = {
        45659, -- Spaulders of the Wayward Conqueror
    },
    -- Valorous Aegis Breastplate
    ["45381"] = {
        45635, -- Chestguard of the Wayward Conqueror
    },
    -- Valorous Aegis Faceguard
    ["45382"] = {
        45647, -- Helm of the Wayward Conqueror
    },
    -- Valorous Aegis Handguards
    ["45383"] = {
        45644, -- Gloves of the Wayward Conqueror
    },
    -- Valorous Aegis Legguards
    ["45384"] = {
        45650, -- Leggings of the Wayward Conqueror
    },
    -- Valorous Aegis Shoulderguards
    ["45385"] = {
        45659, -- Spaulders of the Wayward Conqueror
    },
    -- Valorous Cowl of Sanctification
    ["45386"] = {
        45647, -- Helm of the Wayward Conqueror
    },
    -- Valorous Gloves of Sanctification
    ["45387"] = {
        45644, -- Gloves of the Wayward Conqueror
    },
    -- Valorous Leggings of Sanctification
    ["45388"] = {
        45650, -- Leggings of the Wayward Conqueror
    },
    -- Valorous Robe of Sanctification
    ["45389"] = {
        45635, -- Chestguard of the Wayward Conqueror
    },
    -- Valorous Shoulderpads of Sanctification
    ["45390"] = {
        45659, -- Spaulders of the Wayward Conqueror
    },
    -- Valorous Circlet of Sanctification
    ["45391"] = {
        45647, -- Helm of the Wayward Conqueror
    },
    -- Valorous Handwraps of Sanctification
    ["45392"] = {
        45644, -- Gloves of the Wayward Conqueror
    },
    -- Valorous Mantle of Sanctification
    ["45393"] = {
        45659, -- Spaulders of the Wayward Conqueror
    },
    -- Valorous Pants of Sanctification
    ["45394"] = {
        45650, -- Leggings of the Wayward Conqueror
    },
    -- Valorous Raiments of Sanctification
    ["45395"] = {
        45635, -- Chestguard of the Wayward Conqueror
    },
    -- Valorous Terrorblade Breastplate
    ["45396"] = {
        45637, -- Chestguard of the Wayward Vanquisher
    },
    -- Valorous Terrorblade Gauntlets
    ["45397"] = {
        45646, -- Gloves of the Wayward Vanquisher
    },
    -- Valorous Terrorblade Helmet
    ["45398"] = {
        45649, -- Helm of the Wayward Vanquisher
    },
    -- Valorous Terrorblade Legplates
    ["45399"] = {
        45652, -- Leggings of the Wayward Vanquisher
    },
    -- Valorous Terrorblade Pauldrons
    ["45400"] = {
        45661, -- Spaulders of the Wayward Vanquisher
    },
    -- Valorous Worldbreaker Handguards
    ["45401"] = {
        45645, -- Gloves of the Wayward Protector
    },
    -- Valorous Worldbreaker Headpiece
    ["45402"] = {
        45648, -- Helm of the Wayward Protector
    },
    -- Valorous Worldbreaker Legguards
    ["45403"] = {
        45651, -- Leggings of the Wayward Protector
    },
    -- Valorous Worldbreaker Spaulders
    ["45404"] = {
        45660, -- Spaulders of the Wayward Protector
    },
    -- Valorous Worldbreaker Tunic
    ["45405"] = {
        45636, -- Chestguard of the Wayward Protector
    },
    -- Valorous Worldbreaker Gloves
    ["45406"] = {
        45645, -- Gloves of the Wayward Protector
    },
    -- Valorous Worldbreaker Helm
    ["45408"] = {
        45648, -- Helm of the Wayward Protector
    },
    -- Valorous Worldbreaker Kilt
    ["45409"] = {
        45651, -- Leggings of the Wayward Protector
    },
    -- Valorous Worldbreaker Shoulderpads
    ["45410"] = {
        45660, -- Spaulders of the Wayward Protector
    },
    -- Valorous Worldbreaker Hauberk
    ["45411"] = {
        45636, -- Chestguard of the Wayward Protector
    },
    -- Valorous Worldbreaker Faceguard
    ["45412"] = {
        45648, -- Helm of the Wayward Protector
    },
    -- Valorous Worldbreaker Chestguard
    ["45413"] = {
        45636, -- Chestguard of the Wayward Protector
    },
    -- Valorous Worldbreaker Grips
    ["45414"] = {
        45645, -- Gloves of the Wayward Protector
    },
    -- Valorous Worldbreaker Shoulderguards
    ["45415"] = {
        45660, -- Spaulders of the Wayward Protector
    },
    -- Valorous Worldbreaker War-Kilt
    ["45416"] = {
        45651, -- Leggings of the Wayward Protector
    },
    -- Valorous Deathbringer Hood
    ["45417"] = {
        45647, -- Helm of the Wayward Conqueror
    },
    -- Valorous Deathbringer Gloves
    ["45419"] = {
        45644, -- Gloves of the Wayward Conqueror
    },
    -- Valorous Deathbringer Leggings
    ["45420"] = {
        45650, -- Leggings of the Wayward Conqueror
    },
    -- Valorous Deathbringer Robe
    ["45421"] = {
        45635, -- Chestguard of the Wayward Conqueror
    },
    -- Valorous Deathbringer Shoulderpads
    ["45422"] = {
        45659, -- Spaulders of the Wayward Conqueror
    },
    -- Valorous Siegebreaker Breastplate
    ["45424"] = {
        45636, -- Chestguard of the Wayward Protector
    },
    -- Valorous Siegebreaker Greathelm
    ["45425"] = {
        45648, -- Helm of the Wayward Protector
    },
    -- Valorous Siegebreaker Handguards
    ["45426"] = {
        45645, -- Gloves of the Wayward Protector
    },
    -- Valorous Siegebreaker Legguards
    ["45427"] = {
        45651, -- Leggings of the Wayward Protector
    },
    -- Valorous Siegebreaker Pauldrons
    ["45428"] = {
        45660, -- Spaulders of the Wayward Protector
    },
    -- Valorous Siegebreaker Battleplate
    ["45429"] = {
        45636, -- Chestguard of the Wayward Protector
    },
    -- Valorous Siegebreaker Gauntlets
    ["45430"] = {
        45645, -- Gloves of the Wayward Protector
    },
    -- Valorous Siegebreaker Helmet
    ["45431"] = {
        45648, -- Helm of the Wayward Protector
    },
    -- Valorous Siegebreaker Legplates
    ["45432"] = {
        45651, -- Leggings of the Wayward Protector
    },
    -- Valorous Siegebreaker Shoulderplates
    ["45433"] = {
        45660, -- Spaulders of the Wayward Protector
    },
    -- Belt of the Titans
    ["45550"] = {
        45087, -- Runed Orb
    },
    -- Indestructible Plate Girdle
    ["45551"] = {
        45087, -- Runed Orb
    },
    -- Plate Girdle of Righteousness
    ["45552"] = {
        45087, -- Runed Orb
    },
    -- Belt of Dragons
    ["45553"] = {
        45087, -- Runed Orb
    },
    -- Blue Belt of Chaos
    ["45554"] = {
        45087, -- Runed Orb
    },
    -- Death-warmed Belt
    ["45555"] = {
        45087, -- Runed Orb
    },
    -- Belt of Arctic Life
    ["45556"] = {
        45087, -- Runed Orb
    },
    -- Sash of Ancient Power
    ["45557"] = {
        45087, -- Runed Orb
    },
    -- Cord of the White Dawn
    ["45558"] = {
        45087, -- Runed Orb
    },
    -- Battlelord's Plate Boots
    ["45559"] = {
        45087, -- Runed Orb
    },
    -- Spiked Deathdealers
    ["45560"] = {
        45087, -- Runed Orb
    },
    -- Treads of Destiny
    ["45561"] = {
        45087, -- Runed Orb
    },
    -- Boots of Living Scale
    ["45562"] = {
        45087, -- Runed Orb
    },
    -- Lightning Grounded Boots
    ["45563"] = {
        45087, -- Runed Orb
    },
    -- Footpads of Silence
    ["45564"] = {
        45087, -- Runed Orb
    },
    -- Boots of Wintry Endurance
    ["45565"] = {
        45087, -- Runed Orb
    },
    -- Spellslinger's Slippers
    ["45566"] = {
        45087, -- Runed Orb
    },
    -- Savior's Slippers
    ["45567"] = {
        45087, -- Runed Orb
    },
    -- Drape of the Skyborn
    ["45588"] = {
        46053, -- Reply-Code Alpha
    },
    -- Brann's Signet Ring
    ["45608"] = {
        46053, -- Reply-Code Alpha
    },
    -- Starshine Circle
    ["45614"] = {
        46053, -- Reply-Code Alpha
    },
    -- Sunglimmer Cloak
    ["45618"] = {
        46053, -- Reply-Code Alpha
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
    -- Breastplate of the Wayward Protector
    ["45633"] = {
        46141, -- Conqueror's Scourgestalker Tunic
        46146, -- Conqueror's Siegebreaker Battleplate
        46162, -- Conqueror's Siegebreaker Breastplate
        46198, -- Conqueror's Worldbreaker Tunic
        46205, -- Conqueror's Worldbreaker Chestguard
        46206, -- Conqueror's Worldbreaker Hauberk
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
    -- Chestguard of the Wayward Conqueror
    ["45635"] = {
        45374, -- Valorous Aegis Tunic
        45375, -- Valorous Aegis Battleplate
        45381, -- Valorous Aegis Breastplate
        45389, -- Valorous Robe of Sanctification
        45395, -- Valorous Raiments of Sanctification
        45421, -- Valorous Deathbringer Robe
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
    -- Crown of the Wayward Conqueror
    ["45638"] = {
        46140, -- Conqueror's Deathbringer Hood
        46156, -- Conqueror's Aegis Helm
        46172, -- Conqueror's Circlet of Sanctification
        46175, -- Conqueror's Aegis Faceguard
        46180, -- Conqueror's Aegis Headpiece
        46197, -- Conqueror's Cowl of Sanctification
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
    -- Gauntlets of the Wayward Conqueror
    ["45641"] = {
        46135, -- Conqueror's Deathbringer Gloves
        46155, -- Conqueror's Aegis Gauntlets
        46163, -- Conqueror's Handwraps of Sanctification
        46174, -- Conqueror's Aegis Handguards
        46179, -- Conqueror's Aegis Gloves
        46188, -- Conqueror's Gloves of Sanctification
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
    -- Gloves of the Wayward Conqueror
    ["45644"] = {
        45370, -- Valorous Aegis Gloves
        45376, -- Valorous Aegis Gauntlets
        45383, -- Valorous Aegis Handguards
        45387, -- Valorous Gloves of Sanctification
        45392, -- Valorous Handwraps of Sanctification
        45419, -- Valorous Deathbringer Gloves
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
    -- Helm of the Wayward Conqueror
    ["45647"] = {
        45372, -- Valorous Aegis Headpiece
        45377, -- Valorous Aegis Helm
        45382, -- Valorous Aegis Faceguard
        45386, -- Valorous Cowl of Sanctification
        45391, -- Valorous Circlet of Sanctification
        45417, -- Valorous Deathbringer Hood
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
    -- Leggings of the Wayward Conqueror
    ["45650"] = {
        45371, -- Valorous Aegis Greaves
        45379, -- Valorous Aegis Legplates
        45384, -- Valorous Aegis Legguards
        45388, -- Valorous Leggings of Sanctification
        45394, -- Valorous Pants of Sanctification
        45420, -- Valorous Deathbringer Leggings
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
    -- Legplates of the Wayward Conqueror
    ["45653"] = {
        46139, -- Conqueror's Deathbringer Leggings
        46153, -- Conqueror's Aegis Legplates
        46170, -- Conqueror's Pants of Sanctification
        46176, -- Conqueror's Aegis Legguards
        46181, -- Conqueror's Aegis Greaves
        46195, -- Conqueror's Leggings of Sanctification
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
    -- Mantle of the Wayward Conqueror
    ["45656"] = {
        46136, -- Conqueror's Deathbringer Shoulderpads
        46152, -- Conqueror's Aegis Shoulderplates
        46165, -- Conqueror's Mantle of Sanctification
        46177, -- Conqueror's Aegis Shoulderguards
        46182, -- Conqueror's Aegis Spaulders
        46190, -- Conqueror's Shoulderpads of Sanctification
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
    -- Spaulders of the Wayward Conqueror
    ["45659"] = {
        45373, -- Valorous Aegis Spaulders
        45380, -- Valorous Aegis Shoulderplates
        45385, -- Valorous Aegis Shoulderguards
        45390, -- Valorous Shoulderpads of Sanctification
        45393, -- Valorous Mantle of Sanctification
        45422, -- Valorous Deathbringer Shoulderpads
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
    -- Unbound Fragments of Val'anyr
    ["45896"] = {
        45038, -- Fragment of Val'anyr
    },
    -- Reforged Hammer of Ancient Kings
    ["45897"] = {
        45038, -- Fragment of Val'anyr
    },
    -- Val'anyr, Hammer of Ancient Kings
    ["46017"] = {
        45038, -- Fragment of Val'anyr
    },
    -- Reply-Code Alpha
    ["46052"] = {
        46320, -- Drape of the Skyherald
        46321, -- Sunglimmer Drape
        46322, -- Brann's Sealing Ring
        46323, -- Starshine Signet
    },
    -- Reply-Code Alpha
    ["46053"] = {
        45588, -- Drape of the Skyborn
        45608, -- Brann's Signet Ring
        45614, -- Starshine Circle
        45618, -- Sunglimmer Cloak
    },
    -- Conqueror's Darkruned Battleplate
    ["46111"] = {
        45634, -- Breastplate of the Wayward Vanquisher
    },
    -- Conqueror's Darkruned Gauntlets
    ["46113"] = {
        45643, -- Gauntlets of the Wayward Vanquisher
    },
    -- Conqueror's Darkruned Helmet
    ["46115"] = {
        45640, -- Crown of the Wayward Vanquisher
    },
    -- Conqueror's Darkruned Legplates
    ["46116"] = {
        45655, -- Legplates of the Wayward Vanquisher
    },
    -- Conqueror's Darkruned Shoulderplates
    ["46117"] = {
        45658, -- Mantle of the Wayward Vanquisher
    },
    -- Conqueror's Darkruned Chestguard
    ["46118"] = {
        45634, -- Breastplate of the Wayward Vanquisher
    },
    -- Conqueror's Darkruned Handguards
    ["46119"] = {
        45643, -- Gauntlets of the Wayward Vanquisher
    },
    -- Conqueror's Darkruned Faceguard
    ["46120"] = {
        45640, -- Crown of the Wayward Vanquisher
    },
    -- Conqueror's Darkruned Legguards
    ["46121"] = {
        45655, -- Legplates of the Wayward Vanquisher
    },
    -- Conqueror's Darkruned Pauldrons
    ["46122"] = {
        45658, -- Mantle of the Wayward Vanquisher
    },
    -- Conqueror's Terrorblade Breastplate
    ["46123"] = {
        45634, -- Breastplate of the Wayward Vanquisher
    },
    -- Conqueror's Terrorblade Gauntlets
    ["46124"] = {
        45643, -- Gauntlets of the Wayward Vanquisher
    },
    -- Conqueror's Terrorblade Helmet
    ["46125"] = {
        45640, -- Crown of the Wayward Vanquisher
    },
    -- Conqueror's Terrorblade Legplates
    ["46126"] = {
        45655, -- Legplates of the Wayward Vanquisher
    },
    -- Conqueror's Terrorblade Pauldrons
    ["46127"] = {
        45658, -- Mantle of the Wayward Vanquisher
    },
    -- Conqueror's Kirin Tor Hood
    ["46129"] = {
        45640, -- Crown of the Wayward Vanquisher
    },
    -- Conqueror's Kirin Tor Tunic
    ["46130"] = {
        45634, -- Breastplate of the Wayward Vanquisher
    },
    -- Valorous Kirin Tor Gauntlets
    ["46131"] = {
        45646, -- Gloves of the Wayward Vanquisher
    },
    -- Conqueror's Kirin Tor Gauntlets
    ["46132"] = {
        45643, -- Gauntlets of the Wayward Vanquisher
    },
    -- Conqueror's Kirin Tor Leggings
    ["46133"] = {
        45655, -- Legplates of the Wayward Vanquisher
    },
    -- Conqueror's Kirin Tor Shoulderpads
    ["46134"] = {
        45658, -- Mantle of the Wayward Vanquisher
    },
    -- Conqueror's Deathbringer Gloves
    ["46135"] = {
        45641, -- Gauntlets of the Wayward Conqueror
    },
    -- Conqueror's Deathbringer Shoulderpads
    ["46136"] = {
        45656, -- Mantle of the Wayward Conqueror
    },
    -- Conqueror's Deathbringer Robe
    ["46137"] = {
        45632, -- Breastplate of the Wayward Conqueror
    },
    -- Conqueror's Deathbringer Leggings
    ["46139"] = {
        45653, -- Legplates of the Wayward Conqueror
    },
    -- Conqueror's Deathbringer Hood
    ["46140"] = {
        45638, -- Crown of the Wayward Conqueror
    },
    -- Conqueror's Scourgestalker Tunic
    ["46141"] = {
        45633, -- Breastplate of the Wayward Protector
    },
    -- Conqueror's Scourgestalker Handguards
    ["46142"] = {
        45642, -- Gauntlets of the Wayward Protector
    },
    -- Conqueror's Scourgestalker Headpiece
    ["46143"] = {
        45639, -- Crown of the Wayward Protector
    },
    -- Conqueror's Scourgestalker Legguards
    ["46144"] = {
        45654, -- Legplates of the Wayward Protector
    },
    -- Conqueror's Scourgestalker Spaulders
    ["46145"] = {
        45657, -- Mantle of the Wayward Protector
    },
    -- Conqueror's Siegebreaker Battleplate
    ["46146"] = {
        45633, -- Breastplate of the Wayward Protector
    },
    -- Conqueror's Siegebreaker Gauntlets
    ["46148"] = {
        45642, -- Gauntlets of the Wayward Protector
    },
    -- Conqueror's Siegebreaker Shoulderplates
    ["46149"] = {
        45657, -- Mantle of the Wayward Protector
    },
    -- Conqueror's Siegebreaker Legplates
    ["46150"] = {
        45654, -- Legplates of the Wayward Protector
    },
    -- Conqueror's Siegebreaker Helmet
    ["46151"] = {
        45639, -- Crown of the Wayward Protector
    },
    -- Conqueror's Aegis Shoulderplates
    ["46152"] = {
        45656, -- Mantle of the Wayward Conqueror
    },
    -- Conqueror's Aegis Legplates
    ["46153"] = {
        45653, -- Legplates of the Wayward Conqueror
    },
    -- Conqueror's Aegis Battleplate
    ["46154"] = {
        45632, -- Breastplate of the Wayward Conqueror
    },
    -- Conqueror's Aegis Gauntlets
    ["46155"] = {
        45641, -- Gauntlets of the Wayward Conqueror
    },
    -- Conqueror's Aegis Helm
    ["46156"] = {
        45638, -- Crown of the Wayward Conqueror
    },
    -- Conqueror's Nightsong Shoulderpads
    ["46157"] = {
        45658, -- Mantle of the Wayward Vanquisher
    },
    -- Conqueror's Nightsong Handgrips
    ["46158"] = {
        45643, -- Gauntlets of the Wayward Vanquisher
    },
    -- Conqueror's Nightsong Raiments
    ["46159"] = {
        45634, -- Breastplate of the Wayward Vanquisher
    },
    -- Conqueror's Nightsong Legguards
    ["46160"] = {
        45655, -- Legplates of the Wayward Vanquisher
    },
    -- Conqueror's Nightsong Headguard
    ["46161"] = {
        45640, -- Crown of the Wayward Vanquisher
    },
    -- Conqueror's Siegebreaker Breastplate
    ["46162"] = {
        45633, -- Breastplate of the Wayward Protector
    },
    -- Conqueror's Handwraps of Sanctification
    ["46163"] = {
        45641, -- Gauntlets of the Wayward Conqueror
    },
    -- Conqueror's Siegebreaker Handguards
    ["46164"] = {
        45642, -- Gauntlets of the Wayward Protector
    },
    -- Conqueror's Mantle of Sanctification
    ["46165"] = {
        45656, -- Mantle of the Wayward Conqueror
    },
    -- Conqueror's Siegebreaker Greathelm
    ["46166"] = {
        45639, -- Crown of the Wayward Protector
    },
    -- Conqueror's Siegebreaker Pauldrons
    ["46167"] = {
        45657, -- Mantle of the Wayward Protector
    },
    -- Conqueror's Raiments of Sanctification
    ["46168"] = {
        45632, -- Breastplate of the Wayward Conqueror
    },
    -- Conqueror's Siegebreaker Legguards
    ["46169"] = {
        45654, -- Legplates of the Wayward Protector
    },
    -- Conqueror's Pants of Sanctification
    ["46170"] = {
        45653, -- Legplates of the Wayward Conqueror
    },
    -- Conqueror's Circlet of Sanctification
    ["46172"] = {
        45638, -- Crown of the Wayward Conqueror
    },
    -- Conqueror's Aegis Breastplate
    ["46173"] = {
        45632, -- Breastplate of the Wayward Conqueror
    },
    -- Conqueror's Aegis Handguards
    ["46174"] = {
        45641, -- Gauntlets of the Wayward Conqueror
    },
    -- Conqueror's Aegis Faceguard
    ["46175"] = {
        45638, -- Crown of the Wayward Conqueror
    },
    -- Conqueror's Aegis Legguards
    ["46176"] = {
        45653, -- Legplates of the Wayward Conqueror
    },
    -- Conqueror's Aegis Shoulderguards
    ["46177"] = {
        45656, -- Mantle of the Wayward Conqueror
    },
    -- Conqueror's Aegis Tunic
    ["46178"] = {
        45632, -- Breastplate of the Wayward Conqueror
    },
    -- Conqueror's Aegis Gloves
    ["46179"] = {
        45641, -- Gauntlets of the Wayward Conqueror
    },
    -- Conqueror's Aegis Headpiece
    ["46180"] = {
        45638, -- Crown of the Wayward Conqueror
    },
    -- Conqueror's Aegis Greaves
    ["46181"] = {
        45653, -- Legplates of the Wayward Conqueror
    },
    -- Conqueror's Aegis Spaulders
    ["46182"] = {
        45656, -- Mantle of the Wayward Conqueror
    },
    -- Conqueror's Nightsong Handguards
    ["46183"] = {
        45643, -- Gauntlets of the Wayward Vanquisher
    },
    -- Conqueror's Nightsong Headpiece
    ["46184"] = {
        45640, -- Crown of the Wayward Vanquisher
    },
    -- Conqueror's Nightsong Leggings
    ["46185"] = {
        45655, -- Legplates of the Wayward Vanquisher
    },
    -- Conqueror's Nightsong Robe
    ["46186"] = {
        45634, -- Breastplate of the Wayward Vanquisher
    },
    -- Conqueror's Nightsong Spaulders
    ["46187"] = {
        45658, -- Mantle of the Wayward Vanquisher
    },
    -- Conqueror's Gloves of Sanctification
    ["46188"] = {
        45641, -- Gauntlets of the Wayward Conqueror
    },
    -- Conqueror's Nightsong Gloves
    ["46189"] = {
        45643, -- Gauntlets of the Wayward Vanquisher
    },
    -- Conqueror's Shoulderpads of Sanctification
    ["46190"] = {
        45656, -- Mantle of the Wayward Conqueror
    },
    -- Conqueror's Nightsong Cover
    ["46191"] = {
        45640, -- Crown of the Wayward Vanquisher
    },
    -- Conqueror's Nightsong Trousers
    ["46192"] = {
        45655, -- Legplates of the Wayward Vanquisher
    },
    -- Conqueror's Robe of Sanctification
    ["46193"] = {
        45632, -- Breastplate of the Wayward Conqueror
    },
    -- Conqueror's Nightsong Vestments
    ["46194"] = {
        45634, -- Breastplate of the Wayward Vanquisher
    },
    -- Conqueror's Leggings of Sanctification
    ["46195"] = {
        45653, -- Legplates of the Wayward Conqueror
    },
    -- Conqueror's Nightsong Mantle
    ["46196"] = {
        45658, -- Mantle of the Wayward Vanquisher
    },
    -- Conqueror's Cowl of Sanctification
    ["46197"] = {
        45638, -- Crown of the Wayward Conqueror
    },
    -- Conqueror's Worldbreaker Tunic
    ["46198"] = {
        45633, -- Breastplate of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Handguards
    ["46199"] = {
        45642, -- Gauntlets of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Grips
    ["46200"] = {
        45642, -- Gauntlets of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Headpiece
    ["46201"] = {
        45639, -- Crown of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Legguards
    ["46202"] = {
        45654, -- Legplates of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Shoulderguards
    ["46203"] = {
        45657, -- Mantle of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Spaulders
    ["46204"] = {
        45657, -- Mantle of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Chestguard
    ["46205"] = {
        45633, -- Breastplate of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Hauberk
    ["46206"] = {
        45633, -- Breastplate of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Gloves
    ["46207"] = {
        45642, -- Gauntlets of the Wayward Protector
    },
    -- Conqueror's Worldbreaker War-Kilt
    ["46208"] = {
        45654, -- Legplates of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Helm
    ["46209"] = {
        45639, -- Crown of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Kilt
    ["46210"] = {
        45654, -- Legplates of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Shoulderpads
    ["46211"] = {
        45657, -- Mantle of the Wayward Protector
    },
    -- Conqueror's Worldbreaker Faceguard
    ["46212"] = {
        45639, -- Crown of the Wayward Protector
    },
    -- Valorous Nightsong Cover
    ["46313"] = {
        45649, -- Helm of the Wayward Vanquisher
    },
    -- Drape of the Skyherald
    ["46320"] = {
        46052, -- Reply-Code Alpha
    },
    -- Sunglimmer Drape
    ["46321"] = {
        46052, -- Reply-Code Alpha
    },
    -- Brann's Sealing Ring
    ["46322"] = {
        46052, -- Reply-Code Alpha
    },
    -- Starshine Signet
    ["46323"] = {
        46052, -- Reply-Code Alpha
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
    -- Saronite Swordbreakers
    ["47570"] = {
        47556, -- Crusader Orb
    },
    -- Saronite Swordbreakers
    ["47571"] = {
        47556, -- Crusader Orb
    },
    -- Titanium Spikeguards
    ["47572"] = {
        47556, -- Crusader Orb
    },
    -- Titanium Spikeguards
    ["47573"] = {
        47556, -- Crusader Orb
    },
    -- Sunforged Bracers
    ["47574"] = {
        47556, -- Crusader Orb
    },
    -- Sunforged Bracers
    ["47575"] = {
        47556, -- Crusader Orb
    },
    -- Crusader's Dragonscale Bracers
    ["47576"] = {
        47556, -- Crusader Orb
    },
    -- Crusader's Dragonscale Bracers
    ["47577"] = {
        47556, -- Crusader Orb
    },
    -- Black Chitin Bracers
    ["47579"] = {
        47556, -- Crusader Orb
    },
    -- Black Chitin Bracers
    ["47580"] = {
        47556, -- Crusader Orb
    },
    -- Bracers of Swift Death
    ["47581"] = {
        47556, -- Crusader Orb
    },
    -- Bracers of Swift Death
    ["47582"] = {
        47556, -- Crusader Orb
    },
    -- Moonshadow Armguards
    ["47583"] = {
        47556, -- Crusader Orb
    },
    -- Moonshadow Armguards
    ["47584"] = {
        47556, -- Crusader Orb
    },
    -- Bejeweled Wizard's Bracers
    ["47585"] = {
        47556, -- Crusader Orb
    },
    -- Bejeweled Wizard's Bracers
    ["47586"] = {
        47556, -- Crusader Orb
    },
    -- Royal Moonshroud Bracers
    ["47587"] = {
        47556, -- Crusader Orb
    },
    -- Royal Moonshroud Bracers
    ["47588"] = {
        47556, -- Crusader Orb
    },
    -- Titanium Razorplate
    ["47589"] = {
        47556, -- Crusader Orb
    },
    -- Titanium Razorplate
    ["47590"] = {
        47556, -- Crusader Orb
    },
    -- Breastplate of the White Knight
    ["47591"] = {
        47556, -- Crusader Orb
    },
    -- Breastplate of the White Knight
    ["47592"] = {
        47556, -- Crusader Orb
    },
    -- Sunforged Breastplate
    ["47593"] = {
        47556, -- Crusader Orb
    },
    -- Sunforged Breastplate
    ["47594"] = {
        47556, -- Crusader Orb
    },
    -- Crusader's Dragonscale Breastplate
    ["47595"] = {
        47556, -- Crusader Orb
    },
    -- Crusader's Dragonscale Breastplate
    ["47596"] = {
        47556, -- Crusader Orb
    },
    -- Ensorcelled Nerubian Breastplate
    ["47597"] = {
        47556, -- Crusader Orb
    },
    -- Ensorcelled Nerubian Breastplate
    ["47598"] = {
        47556, -- Crusader Orb
    },
    -- Knightbane Carapace
    ["47599"] = {
        47556, -- Crusader Orb
    },
    -- Knightbane Carapace
    ["47600"] = {
        47556, -- Crusader Orb
    },
    -- Lunar Eclipse Robes
    ["47601"] = {
        47556, -- Crusader Orb
    },
    -- Lunar Eclipse Robes
    ["47602"] = {
        47556, -- Crusader Orb
    },
    -- Merlin's Robe
    ["47603"] = {
        47556, -- Crusader Orb
    },
    -- Merlin's Robe
    ["47604"] = {
        47556, -- Crusader Orb
    },
    -- Royal Moonshroud Robe
    ["47605"] = {
        47556, -- Crusader Orb
    },
    -- Royal Moonshroud Robe
    ["47606"] = {
        47556, -- Crusader Orb
    },
    -- Khadgar's Gauntlets of Triumph
    ["47753"] = {
        47242, -- Trophy of the Crusade
    },
    -- Khadgar's Hood of Triumph
    ["47754"] = {
        47242, -- Trophy of the Crusade
    },
    -- Khadgar's Leggings of Triumph
    ["47755"] = {
        47242, -- Trophy of the Crusade
    },
    -- Khadgar's Robe of Triumph
    ["47756"] = {
        47242, -- Trophy of the Crusade
    },
    -- Khadgar's Shoulderpads of Triumph
    ["47757"] = {
        47242, -- Trophy of the Crusade
    },
    -- Khadgar's Shoulderpads of Triumph
    ["47758"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Khadgar's Robe of Triumph
    ["47759"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Khadgar's Leggings of Triumph
    ["47760"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Khadgar's Hood of Triumph
    ["47761"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Khadgar's Gauntlets of Triumph
    ["47762"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Sunstrider's Gauntlets of Triumph
    ["47763"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Sunstrider's Hood of Triumph
    ["47764"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Sunstrider's Leggings of Triumph
    ["47765"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Sunstrider's Robe of Triumph
    ["47766"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Sunstrider's Shoulderpads of Triumph
    ["47767"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Sunstrider's Shoulderpads of Triumph
    ["47768"] = {
        47242, -- Trophy of the Crusade
    },
    -- Sunstrider's Robe of Triumph
    ["47769"] = {
        47242, -- Trophy of the Crusade
    },
    -- Sunstrider's Leggings of Triumph
    ["47770"] = {
        47242, -- Trophy of the Crusade
    },
    -- Sunstrider's Hood of Triumph
    ["47771"] = {
        47242, -- Trophy of the Crusade
    },
    -- Sunstrider's Gauntlets of Triumph
    ["47772"] = {
        47242, -- Trophy of the Crusade
    },
    -- Kel'Thuzad's Hood of Triumph
    ["47778"] = {
        47242, -- Trophy of the Crusade
    },
    -- Kel'Thuzad's Robe of Triumph
    ["47779"] = {
        47242, -- Trophy of the Crusade
    },
    -- Kel'Thuzad's Leggings of Triumph
    ["47780"] = {
        47242, -- Trophy of the Crusade
    },
    -- Kel'Thuzad's Shoulderpads of Triumph
    ["47781"] = {
        47242, -- Trophy of the Crusade
    },
    -- Kel'Thuzad's Gloves of Triumph
    ["47782"] = {
        47242, -- Trophy of the Crusade
    },
    -- Kel'Thuzad's Gloves of Triumph
    ["47788"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Kel'Thuzad's Hood of Triumph
    ["47789"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Kel'Thuzad's Leggings of Triumph
    ["47790"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Kel'Thuzad's Robe of Triumph
    ["47791"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Kel'Thuzad's Shoulderpads of Triumph
    ["47792"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Gul'dan's Shoulderpads of Triumph
    ["47793"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Gul'dan's Robe of Triumph
    ["47794"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Gul'dan's Leggings of Triumph
    ["47795"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Gul'dan's Hood of Triumph
    ["47796"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Gul'dan's Gloves of Triumph
    ["47797"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Gul'dan's Gloves of Triumph
    ["47803"] = {
        47242, -- Trophy of the Crusade
    },
    -- Gul'dan's Hood of Triumph
    ["47804"] = {
        47242, -- Trophy of the Crusade
    },
    -- Gul'dan's Leggings of Triumph
    ["47805"] = {
        47242, -- Trophy of the Crusade
    },
    -- Gul'dan's Robe of Triumph
    ["47806"] = {
        47242, -- Trophy of the Crusade
    },
    -- Gul'dan's Shoulderpads of Triumph
    ["47807"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Gloves of Triumph
    ["47983"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Cowl of Triumph
    ["47984"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Leggings of Triumph
    ["47985"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Robe of Triumph
    ["47986"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Shoulderpads of Triumph
    ["47987"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Shoulderpads of Triumph
    ["48029"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Velen's Robe of Triumph
    ["48031"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Velen's Leggings of Triumph
    ["48033"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Velen's Cowl of Triumph
    ["48035"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Velen's Gloves of Triumph
    ["48037"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Gloves of Triumph
    ["48057"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Cowl of Triumph
    ["48058"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Leggings of Triumph
    ["48059"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Robe of Triumph
    ["48060"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Shoulderpads of Triumph
    ["48061"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Shoulderpads of Triumph
    ["48062"] = {
        47242, -- Trophy of the Crusade
    },
    -- Zabra's Robe of Triumph
    ["48063"] = {
        47242, -- Trophy of the Crusade
    },
    -- Zabra's Leggings of Triumph
    ["48064"] = {
        47242, -- Trophy of the Crusade
    },
    -- Zabra's Cowl of Triumph
    ["48065"] = {
        47242, -- Trophy of the Crusade
    },
    -- Zabra's Gloves of Triumph
    ["48066"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Handwraps of Triumph
    ["48077"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Circlet of Triumph
    ["48078"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Pants of Triumph
    ["48079"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Raiments of Triumph
    ["48080"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Mantle of Triumph
    ["48081"] = {
        47242, -- Trophy of the Crusade
    },
    -- Velen's Mantle of Triumph
    ["48082"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Velen's Raiments of Triumph
    ["48083"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Velen's Pants of Triumph
    ["48084"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Velen's Circlet of Triumph
    ["48085"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Velen's Handwraps of Triumph
    ["48086"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Handwraps of Triumph
    ["48087"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Circlet of Triumph
    ["48088"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Pants of Triumph
    ["48089"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Raiments of Triumph
    ["48090"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Mantle of Triumph
    ["48091"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Zabra's Mantle of Triumph
    ["48092"] = {
        47242, -- Trophy of the Crusade
    },
    -- Zabra's Raiments of Triumph
    ["48093"] = {
        47242, -- Trophy of the Crusade
    },
    -- Zabra's Pants of Triumph
    ["48094"] = {
        47242, -- Trophy of the Crusade
    },
    -- Zabra's Circlet of Triumph
    ["48095"] = {
        47242, -- Trophy of the Crusade
    },
    -- Zabra's Handwraps of Triumph
    ["48096"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Handguards of Triumph
    ["48133"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Headpiece of Triumph
    ["48134"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Leggings of Triumph
    ["48135"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Robe of Triumph
    ["48136"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Spaulders of Triumph
    ["48137"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Spaulders of Triumph
    ["48138"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Robe of Triumph
    ["48139"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Leggings of Triumph
    ["48140"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Headpiece of Triumph
    ["48141"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Handguards of Triumph
    ["48142"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Handguards of Triumph
    ["48143"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Headpiece of Triumph
    ["48144"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Leggings of Triumph
    ["48145"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Robe of Triumph
    ["48146"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Spaulders of Triumph
    ["48147"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Spaulders of Triumph
    ["48148"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Robe of Triumph
    ["48149"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Leggings of Triumph
    ["48150"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Headpiece of Triumph
    ["48151"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Handguards of Triumph
    ["48152"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Gloves of Triumph
    ["48163"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Cover of Triumph
    ["48164"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Trousers of Triumph
    ["48165"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Vestments of Triumph
    ["48166"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Mantle of Triumph
    ["48167"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Mantle of Triumph
    ["48168"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Vestments of Triumph
    ["48169"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Trousers of Triumph
    ["48170"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Cover of Triumph
    ["48171"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Gloves of Triumph
    ["48172"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Gloves of Triumph
    ["48173"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Cover of Triumph
    ["48174"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Trousers of Triumph
    ["48175"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Vestments of Triumph
    ["48176"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Mantle of Triumph
    ["48177"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Mantle of Triumph
    ["48178"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Vestments of Triumph
    ["48179"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Trousers of Triumph
    ["48180"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Cover of Triumph
    ["48181"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Gloves of Triumph
    ["48182"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Handgrips of Triumph
    ["48193"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Headguard of Triumph
    ["48194"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Legguards of Triumph
    ["48195"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Raiments of Triumph
    ["48196"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Shoulderpads of Triumph
    ["48197"] = {
        47242, -- Trophy of the Crusade
    },
    -- Runetotem's Shoulderpads of Triumph
    ["48198"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Raiments of Triumph
    ["48199"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Legguards of Triumph
    ["48200"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Headguard of Triumph
    ["48201"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Runetotem's Handgrips of Triumph
    ["48202"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Handgrips of Triumph
    ["48203"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Headguard of Triumph
    ["48204"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Legguards of Triumph
    ["48205"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Raiments of Triumph
    ["48206"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Shoulderpads of Triumph
    ["48207"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Malfurion's Shoulderpads of Triumph
    ["48208"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Raiments of Triumph
    ["48209"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Legguards of Triumph
    ["48210"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Headguard of Triumph
    ["48211"] = {
        47242, -- Trophy of the Crusade
    },
    -- Malfurion's Handgrips of Triumph
    ["48212"] = {
        47242, -- Trophy of the Crusade
    },
    -- VanCleef's Breastplate of Triumph
    ["48223"] = {
        47242, -- Trophy of the Crusade
    },
    -- VanCleef's Gauntlets of Triumph
    ["48224"] = {
        47242, -- Trophy of the Crusade
    },
    -- VanCleef's Helmet of Triumph
    ["48225"] = {
        47242, -- Trophy of the Crusade
    },
    -- VanCleef's Legplates of Triumph
    ["48226"] = {
        47242, -- Trophy of the Crusade
    },
    -- VanCleef's Pauldrons of Triumph
    ["48227"] = {
        47242, -- Trophy of the Crusade
    },
    -- VanCleef's Pauldrons of Triumph
    ["48228"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- VanCleef's Legplates of Triumph
    ["48229"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- VanCleef's Helmet of Triumph
    ["48230"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- VanCleef's Gauntlets of Triumph
    ["48231"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- VanCleef's Breastplate of Triumph
    ["48232"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Garona's Breastplate of Triumph
    ["48233"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Garona's Gauntlets of Triumph
    ["48234"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Garona's Helmet of Triumph
    ["48235"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Garona's Legplates of Triumph
    ["48236"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Garona's Pauldrons of Triumph
    ["48237"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Garona's Pauldrons of Triumph
    ["48238"] = {
        47242, -- Trophy of the Crusade
    },
    -- Garona's Legplates of Triumph
    ["48239"] = {
        47242, -- Trophy of the Crusade
    },
    -- Garona's Helmet of Triumph
    ["48240"] = {
        47242, -- Trophy of the Crusade
    },
    -- Garona's Gauntlets of Triumph
    ["48241"] = {
        47242, -- Trophy of the Crusade
    },
    -- Garona's Breastplate of Triumph
    ["48242"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Tunic of Triumph
    ["48255"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Handguards of Triumph
    ["48256"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Headpiece of Triumph
    ["48257"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Legguards of Triumph
    ["48258"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Spaulders of Triumph
    ["48259"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Spaulders of Triumph
    ["48260"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Legguards of Triumph
    ["48261"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Headpiece of Triumph
    ["48262"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Handguards of Triumph
    ["48263"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Tunic of Triumph
    ["48264"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Tunic of Triumph
    ["48265"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Handguards of Triumph
    ["48266"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Headpiece of Triumph
    ["48267"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Legguards of Triumph
    ["48268"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Spaulders of Triumph
    ["48269"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Windrunner's Spaulders of Triumph
    ["48270"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Legguards of Triumph
    ["48271"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Headpiece of Triumph
    ["48272"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Handguards of Triumph
    ["48273"] = {
        47242, -- Trophy of the Crusade
    },
    -- Windrunner's Tunic of Triumph
    ["48274"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Tunic of Triumph
    ["48285"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Handguards of Triumph
    ["48286"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Headpiece of Triumph
    ["48287"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Legguards of Triumph
    ["48288"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Spaulders of Triumph
    ["48289"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Spaulders of Triumph
    ["48290"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Legguards of Triumph
    ["48291"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Headpiece of Triumph
    ["48292"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Handguards of Triumph
    ["48293"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Tunic of Triumph
    ["48294"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Tunic of Triumph
    ["48300"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Handguards of Triumph
    ["48301"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Headpiece of Triumph
    ["48302"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Legguards of Triumph
    ["48303"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Spaulders of Triumph
    ["48304"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Tunic of Triumph
    ["48305"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Handguards of Triumph
    ["48306"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Headpiece of Triumph
    ["48307"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Legguards of Triumph
    ["48308"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Spaulders of Triumph
    ["48309"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Hauberk of Triumph
    ["48316"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Gloves of Triumph
    ["48317"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Helm of Triumph
    ["48318"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Kilt of Triumph
    ["48319"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Shoulderpads of Triumph
    ["48320"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Shoulderpads of Triumph
    ["48321"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Kilt of Triumph
    ["48322"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Helm of Triumph
    ["48323"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Gloves of Triumph
    ["48324"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Hauberk of Triumph
    ["48325"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Hauberk of Triumph
    ["48326"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Gloves of Triumph
    ["48327"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Helm of Triumph
    ["48328"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Kilt of Triumph
    ["48329"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Shoulderpads of Triumph
    ["48330"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Shoulderpads of Triumph
    ["48331"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Kilt of Triumph
    ["48332"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Helm of Triumph
    ["48333"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Gloves of Triumph
    ["48334"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Hauberk of Triumph
    ["48335"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Chestguard of Triumph
    ["48346"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Grips of Triumph
    ["48347"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Faceguard of Triumph
    ["48348"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's War-Kilt of Triumph
    ["48349"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Shoulderguards of Triumph
    ["48350"] = {
        47242, -- Trophy of the Crusade
    },
    -- Nobundo's Shoulderguards of Triumph
    ["48351"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's War-Kilt of Triumph
    ["48352"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Faceguard of Triumph
    ["48353"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Grips of Triumph
    ["48354"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Nobundo's Chestguard of Triumph
    ["48355"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Chestguard of Triumph
    ["48356"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Grips of Triumph
    ["48357"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Faceguard of Triumph
    ["48358"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's War-Kilt of Triumph
    ["48359"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Shoulderguards of Triumph
    ["48360"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thrall's Shoulderguards of Triumph
    ["48361"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's War-Kilt of Triumph
    ["48362"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Faceguard of Triumph
    ["48363"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Grips of Triumph
    ["48364"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thrall's Chestguard of Triumph
    ["48365"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Battleplate of Triumph
    ["48376"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Gauntlets of Triumph
    ["48377"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Helmet of Triumph
    ["48378"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Legplates of Triumph
    ["48379"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Shoulderplates of Triumph
    ["48380"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Shoulderplates of Triumph
    ["48381"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Wrynn's Legplates of Triumph
    ["48382"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Wrynn's Helmet of Triumph
    ["48383"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Wrynn's Gauntlets of Triumph
    ["48384"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Wrynn's Battleplate of Triumph
    ["48385"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Battleplate of Triumph
    ["48391"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Gauntlets of Triumph
    ["48392"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Helmet of Triumph
    ["48393"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Legplates of Triumph
    ["48394"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Shoulderplates of Triumph
    ["48395"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Battleplate of Triumph
    ["48396"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Gauntlets of Triumph
    ["48397"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Helmet of Triumph
    ["48398"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Legplates of Triumph
    ["48399"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Shoulderplates of Triumph
    ["48400"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Wrynn's Greathelm of Triumph
    ["48430"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Greathelm of Triumph
    ["48433"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Wrynn's Legguards of Triumph
    ["48446"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Legguards of Triumph
    ["48447"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Wrynn's Breastplate of Triumph
    ["48450"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Breastplate of Triumph
    ["48451"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Wrynn's Handguards of Triumph
    ["48452"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Handguards of Triumph
    ["48453"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Wrynn's Pauldrons of Triumph
    ["48454"] = {
        47242, -- Trophy of the Crusade
    },
    -- Wrynn's Pauldrons of Triumph
    ["48455"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Breastplate of Triumph
    ["48461"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Handguards of Triumph
    ["48462"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Greathelm of Triumph
    ["48463"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Legguards of Triumph
    ["48464"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Pauldrons of Triumph
    ["48465"] = {
        47242, -- Trophy of the Crusade
    },
    -- Hellscream's Breastplate of Triumph
    ["48466"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Handguards of Triumph
    ["48467"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Greathelm of Triumph
    ["48468"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Legguards of Triumph
    ["48469"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Hellscream's Pauldrons of Triumph
    ["48470"] = {
        47558, -- Regalia of the Grand Protector
    },
    -- Thassarian's Battleplate of Triumph
    ["48481"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Gauntlets of Triumph
    ["48482"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Helmet of Triumph
    ["48483"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Legplates of Triumph
    ["48484"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Shoulderplates of Triumph
    ["48485"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Shoulderplates of Triumph
    ["48486"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Thassarian's Legplates of Triumph
    ["48487"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Thassarian's Helmet of Triumph
    ["48488"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Thassarian's Gauntlets of Triumph
    ["48489"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Thassarian's Battleplate of Triumph
    ["48490"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Battleplate of Triumph
    ["48491"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Gauntlets of Triumph
    ["48492"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Helmet of Triumph
    ["48493"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Legplates of Triumph
    ["48494"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Shoulderplates of Triumph
    ["48495"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Shoulderplates of Triumph
    ["48496"] = {
        47242, -- Trophy of the Crusade
    },
    -- Koltira's Legplates of Triumph
    ["48497"] = {
        47242, -- Trophy of the Crusade
    },
    -- Koltira's Helmet of Triumph
    ["48498"] = {
        47242, -- Trophy of the Crusade
    },
    -- Koltira's Gauntlets of Triumph
    ["48499"] = {
        47242, -- Trophy of the Crusade
    },
    -- Koltira's Battleplate of Triumph
    ["48500"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Chestguard of Triumph
    ["48538"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Handguards of Triumph
    ["48539"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Faceguard of Triumph
    ["48540"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Legguards of Triumph
    ["48541"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Pauldrons of Triumph
    ["48542"] = {
        47242, -- Trophy of the Crusade
    },
    -- Thassarian's Pauldrons of Triumph
    ["48543"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Thassarian's Legguards of Triumph
    ["48544"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Thassarian's Faceguard of Triumph
    ["48545"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Thassarian's Handguards of Triumph
    ["48546"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Thassarian's Chestguard of Triumph
    ["48547"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Chestguard of Triumph
    ["48548"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Handguards of Triumph
    ["48549"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Faceguard of Triumph
    ["48550"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Legguards of Triumph
    ["48551"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Pauldrons of Triumph
    ["48552"] = {
        47559, -- Regalia of the Grand Vanquisher
    },
    -- Koltira's Pauldrons of Triumph
    ["48553"] = {
        47242, -- Trophy of the Crusade
    },
    -- Koltira's Legguards of Triumph
    ["48554"] = {
        47242, -- Trophy of the Crusade
    },
    -- Koltira's Faceguard of Triumph
    ["48555"] = {
        47242, -- Trophy of the Crusade
    },
    -- Koltira's Handguards of Triumph
    ["48556"] = {
        47242, -- Trophy of the Crusade
    },
    -- Koltira's Chestguard of Triumph
    ["48557"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Tunic of Triumph
    ["48575"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Gloves of Triumph
    ["48576"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Headpiece of Triumph
    ["48577"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Greaves of Triumph
    ["48578"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Spaulders of Triumph
    ["48579"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Spaulders of Triumph
    ["48580"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Greaves of Triumph
    ["48581"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Headpiece of Triumph
    ["48582"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Gloves of Triumph
    ["48583"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Tunic of Triumph
    ["48584"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Spaulders of Triumph
    ["48585"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Greaves of Triumph
    ["48586"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Headpiece of Triumph
    ["48587"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Gloves of Triumph
    ["48588"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Tunic of Triumph
    ["48589"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Spaulders of Triumph
    ["48590"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Greaves of Triumph
    ["48591"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Headpiece of Triumph
    ["48592"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Gloves of Triumph
    ["48593"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Tunic of Triumph
    ["48594"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Battleplate of Triumph
    ["48607"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Gauntlets of Triumph
    ["48608"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Helm of Triumph
    ["48609"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Legplates of Triumph
    ["48610"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Shoulderplates of Triumph
    ["48611"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Shoulderplates of Triumph
    ["48612"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Legplates of Triumph
    ["48613"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Helm of Triumph
    ["48614"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Gauntlets of Triumph
    ["48615"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Battleplate of Triumph
    ["48616"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Battleplate of Triumph
    ["48617"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Gauntlets of Triumph
    ["48618"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Helm of Triumph
    ["48619"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Legplates of Triumph
    ["48620"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Shoulderplates of Triumph
    ["48621"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Shoulderplates of Triumph
    ["48622"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Legplates of Triumph
    ["48623"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Helm of Triumph
    ["48624"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Gauntlets of Triumph
    ["48625"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Battleplate of Triumph
    ["48626"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Shoulderguards of Triumph
    ["48637"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Legguards of Triumph
    ["48638"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Faceguard of Triumph
    ["48639"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Handguards of Triumph
    ["48640"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Breastplate of Triumph
    ["48641"] = {
        47242, -- Trophy of the Crusade
    },
    -- Turalyon's Breastplate of Triumph
    ["48642"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Handguards of Triumph
    ["48643"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Faceguard of Triumph
    ["48644"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Legguards of Triumph
    ["48645"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Turalyon's Shoulderguards of Triumph
    ["48646"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Shoulderguards of Triumph
    ["48647"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Legguards of Triumph
    ["48648"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Faceguard of Triumph
    ["48649"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Handguards of Triumph
    ["48650"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Breastplate of Triumph
    ["48651"] = {
        47557, -- Regalia of the Grand Conqueror
    },
    -- Liadrin's Breastplate of Triumph
    ["48657"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Handguards of Triumph
    ["48658"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Faceguard of Triumph
    ["48659"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Legguards of Triumph
    ["48660"] = {
        47242, -- Trophy of the Crusade
    },
    -- Liadrin's Shoulderguards of Triumph
    ["48661"] = {
        47242, -- Trophy of the Crusade
    },
    -- Shadowmourne
    ["49623"] = {
        50274, -- Shadowfrost Shard
    },
    -- Deathfrost Boots
    ["49890"] = {
        49908, -- Primordial Saronite
    },
    -- Leggings of Woven Death
    ["49891"] = {
        49908, -- Primordial Saronite
    },
    -- Lightweave Leggings
    ["49892"] = {
        49908, -- Primordial Saronite
    },
    -- Sandals of Consecration
    ["49893"] = {
        49908, -- Primordial Saronite
    },
    -- Blessed Cenarion Boots
    ["49894"] = {
        49908, -- Primordial Saronite
    },
    -- Footpads of Impending Death
    ["49895"] = {
        49908, -- Primordial Saronite
    },
    -- Earthsoul Boots
    ["49896"] = {
        49908, -- Primordial Saronite
    },
    -- Rock-Steady Treads
    ["49897"] = {
        49908, -- Primordial Saronite
    },
    -- Legwraps of Unleashed Nature
    ["49898"] = {
        49908, -- Primordial Saronite
    },
    -- Bladeborn Leggings
    ["49899"] = {
        49908, -- Primordial Saronite
    },
    -- Lightning-Infused Leggings
    ["49900"] = {
        49908, -- Primordial Saronite
    },
    -- Draconic Bonesplinter Legguards
    ["49901"] = {
        49908, -- Primordial Saronite
    },
    -- Puresteel Legplates
    ["49902"] = {
        49908, -- Primordial Saronite
    },
    -- Legplates of Painful Death
    ["49903"] = {
        49908, -- Primordial Saronite
    },
    -- Pillars of Might
    ["49904"] = {
        49908, -- Primordial Saronite
    },
    -- Protectors of Life
    ["49905"] = {
        49908, -- Primordial Saronite
    },
    -- Hellfrozen Bonegrinders
    ["49906"] = {
        49908, -- Primordial Saronite
    },
    -- Boots of Kingly Upheaval
    ["49907"] = {
        49908, -- Primordial Saronite
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
    -- Pattern: Leggings of Woven Death
    ["49953"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Deathfrost Boots
    ["49954"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Lightweave Leggings
    ["49955"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Sandals of Consecration
    ["49956"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Legwraps of Unleashed Nature
    ["49957"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Blessed Cenarion Boots
    ["49958"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Bladeborn Leggings
    ["49959"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Footpads of Impending Death
    ["49961"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Lightning-Infused Leggings
    ["49962"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Earthsoul Boots
    ["49963"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Draconic Bonesplinter Legguards
    ["49965"] = {
        49908, -- Primordial Saronite
    },
    -- Pattern: Rock-Steady Treads
    ["49966"] = {
        49908, -- Primordial Saronite
    },
    -- Plans: Puresteel Legplates
    ["49969"] = {
        49908, -- Primordial Saronite
    },
    -- Plans: Protectors of Life
    ["49970"] = {
        49908, -- Primordial Saronite
    },
    -- Plans: Legplates of Painful Death
    ["49971"] = {
        49908, -- Primordial Saronite
    },
    -- Plans: Hellfrozen Bonegrinders
    ["49972"] = {
        49908, -- Primordial Saronite
    },
    -- Plans: Pillars of Might
    ["49973"] = {
        49908, -- Primordial Saronite
    },
    -- Plans: Boots of Kingly Upheaval
    ["49974"] = {
        49908, -- Primordial Saronite
    },
    -- Shadowfrost Shard
    ["50274"] = {
        49623, -- Shadowmourne
    },
    -- Sanctified Scourgelord Shoulderplates
    ["51125"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Legplates
    ["51126"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Helmet
    ["51127"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Gauntlets
    ["51128"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Battleplate
    ["51129"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Pauldrons
    ["51130"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Legguards
    ["51131"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Handguards
    ["51132"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Faceguard
    ["51133"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Chestguard
    ["51134"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Pauldrons
    ["51135"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Legplates
    ["51136"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Helmet
    ["51137"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Gauntlets
    ["51138"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Robes
    ["51139"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Shoulderpads
    ["51140"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Raiment
    ["51141"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Legguards
    ["51142"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Headguard
    ["51143"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Handgrips
    ["51144"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Vestment
    ["51145"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Trousers
    ["51146"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Mantle
    ["51147"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Gloves
    ["51148"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Cover
    ["51149"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Tunic
    ["51150"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Spaulders
    ["51151"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Legguards
    ["51152"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Headpiece
    ["51153"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Handguards
    ["51154"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Bloodmage Shoulderpads
    ["51155"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Bloodmage Robe
    ["51156"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Bloodmage Leggings
    ["51157"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Bloodmage Hood
    ["51158"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Bloodmage Gloves
    ["51159"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lightsworn Shoulderplates
    ["51160"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Legplates
    ["51161"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Helmet
    ["51162"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Gauntlets
    ["51163"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Battleplate
    ["51164"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Tunic
    ["51165"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Spaulders
    ["51166"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Headpiece
    ["51167"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Greaves
    ["51168"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Gloves
    ["51169"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Shoulderguards
    ["51170"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Legguards
    ["51171"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Handguards
    ["51172"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Faceguard
    ["51173"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Chestguard
    ["51174"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Shoulderpads
    ["51175"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Robe
    ["51176"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Leggings
    ["51177"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Hood
    ["51178"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Gloves
    ["51179"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Raiments
    ["51180"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Pants
    ["51181"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Mantle
    ["51182"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Handwraps
    ["51183"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Cowl
    ["51184"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Shadowblade Pauldrons
    ["51185"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Shadowblade Legplates
    ["51186"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Shadowblade Helmet
    ["51187"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Shadowblade Gauntlets
    ["51188"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Shadowblade Breastplate
    ["51189"] = {
        52025, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Tunic
    ["51190"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Handguards
    ["51191"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Headpiece
    ["51192"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Legguards
    ["51193"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Spaulders
    ["51194"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Chestguard
    ["51195"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Grips
    ["51196"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Faceguard
    ["51197"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's War-Kilt
    ["51198"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Shoulderguards
    ["51199"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Hauberk
    ["51200"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Gloves
    ["51201"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Helm
    ["51202"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Kilt
    ["51203"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Shoulderpads
    ["51204"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Dark Coven Shoulderpads
    ["51205"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Dark Coven Robe
    ["51206"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Dark Coven Leggings
    ["51207"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Dark Coven Hood
    ["51208"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Dark Coven Gloves
    ["51209"] = {
        52027, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Shoulderplates
    ["51210"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Legplates
    ["51211"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Helmet
    ["51212"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Gauntlets
    ["51213"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Battleplate
    ["51214"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Pauldrons
    ["51215"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Legguards
    ["51216"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Handguards
    ["51217"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Greathelm
    ["51218"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Breastplate
    ["51219"] = {
        52026, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Breastplate
    ["51220"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Greathelm
    ["51221"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Handguards
    ["51222"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Legguards
    ["51223"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Pauldrons
    ["51224"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Battleplate
    ["51225"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Gauntlets
    ["51226"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Helmet
    ["51227"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Legplates
    ["51228"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ymirjar Lord's Shoulderplates
    ["51229"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Dark Coven Gloves
    ["51230"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Dark Coven Hood
    ["51231"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Dark Coven Leggings
    ["51232"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Dark Coven Robe
    ["51233"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Dark Coven Shoulderpads
    ["51234"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Shoulderpads
    ["51235"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Kilt
    ["51236"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Helm
    ["51237"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Gloves
    ["51238"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Hauberk
    ["51239"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Shoulderguards
    ["51240"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's War-Kilt
    ["51241"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Faceguard
    ["51242"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Grips
    ["51243"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Chestguard
    ["51244"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Spaulders
    ["51245"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Legguards
    ["51246"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Headpiece
    ["51247"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Handguards
    ["51248"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Frost Witch's Tunic
    ["51249"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Shadowblade Breastplate
    ["51250"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Shadowblade Gauntlets
    ["51251"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Shadowblade Helmet
    ["51252"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Shadowblade Legplates
    ["51253"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Shadowblade Pauldrons
    ["51254"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Cowl
    ["51255"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Handwraps
    ["51256"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Mantle
    ["51257"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Pants
    ["51258"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Raiments
    ["51259"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Gloves
    ["51260"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Hood
    ["51261"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Leggings
    ["51262"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Robe
    ["51263"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Crimson Acolyte Shoulderpads
    ["51264"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Chestguard
    ["51265"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Faceguard
    ["51266"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Handguards
    ["51267"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Legguards
    ["51268"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Shoulderguards
    ["51269"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Gloves
    ["51270"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Greaves
    ["51271"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Headpiece
    ["51272"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Spaulders
    ["51273"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Tunic
    ["51274"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Battleplate
    ["51275"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Gauntlets
    ["51276"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Helmet
    ["51277"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Legplates
    ["51278"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Lightsworn Shoulderplates
    ["51279"] = {
        52030, -- Conqueror's Mark of Sanctification
    },
    -- Sanctified Bloodmage Gloves
    ["51280"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Bloodmage Hood
    ["51281"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Bloodmage Leggings
    ["51282"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Bloodmage Robe
    ["51283"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Bloodmage Shoulderpads
    ["51284"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Handguards
    ["51285"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Headpiece
    ["51286"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Legguards
    ["51287"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Spaulders
    ["51288"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Ahn'Kahar Blood Hunter's Tunic
    ["51289"] = {
        52029, -- Protector's Mark of Sanctification
    },
    -- Sanctified Lasherweave Cover
    ["51290"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Gloves
    ["51291"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Mantle
    ["51292"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Trousers
    ["51293"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Vestment
    ["51294"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Handgrips
    ["51295"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Headguard
    ["51296"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Legguards
    ["51297"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Raiment
    ["51298"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Shoulderpads
    ["51299"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Robes
    ["51300"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Gauntlets
    ["51301"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Helmet
    ["51302"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Legplates
    ["51303"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Lasherweave Pauldrons
    ["51304"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Chestguard
    ["51305"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Faceguard
    ["51306"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Handguards
    ["51307"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Legguards
    ["51308"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Pauldrons
    ["51309"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Battleplate
    ["51310"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Gauntlets
    ["51311"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Helmet
    ["51312"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Legplates
    ["51313"] = {
        52028, -- Vanquisher's Mark of Sanctification
    },
    -- Sanctified Scourgelord Shoulderplates
    ["51314"] = {
        52028, -- Vanquisher's Mark of Sanctification
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
    -- Firelord's Hood
    ["60243"] = {
        63682, -- Helm of the Forlorn Vanquisher
    },
    -- Firelord's Mantle
    ["60246"] = {
        64314, -- Mantle of the Forlorn Vanquisher
    },
    -- Shadowflame Hood
    ["60249"] = {
        63683, -- Helm of the Forlorn Conqueror
    },
    -- Shadowflame Mantle
    ["60252"] = {
        64315, -- Mantle of the Forlorn Conqueror
    },
    -- Mercurial Shoulderwraps
    ["60253"] = {
        64315, -- Mantle of the Forlorn Conqueror
    },
    -- Mercurial Hood
    ["60256"] = {
        63683, -- Helm of the Forlorn Conqueror
    },
    -- Mercurial Cowl
    ["60258"] = {
        63683, -- Helm of the Forlorn Conqueror
    },
    -- Mercurial Mantle
    ["60262"] = {
        64315, -- Mantle of the Forlorn Conqueror
    },
    -- Stormrider's Helm
    ["60277"] = {
        63682, -- Helm of the Forlorn Vanquisher
    },
    -- Stormrider's Mantle
    ["60279"] = {
        64314, -- Mantle of the Forlorn Vanquisher
    },
    -- Stormrider's Cover
    ["60282"] = {
        63682, -- Helm of the Forlorn Vanquisher
    },
    -- Stormrider's Shoulderwraps
    ["60284"] = {
        64314, -- Mantle of the Forlorn Vanquisher
    },
    -- Stormrider's Headpiece
    ["60286"] = {
        63682, -- Helm of the Forlorn Vanquisher
    },
    -- Stormrider's Spaulders
    ["60289"] = {
        64314, -- Mantle of the Forlorn Vanquisher
    },
    -- Wind Dancer's Helmet
    ["60299"] = {
        63682, -- Helm of the Forlorn Vanquisher
    },
    -- Wind Dancer's Spaulders
    ["60302"] = {
        64314, -- Mantle of the Forlorn Vanquisher
    },
    -- Lightning-Charged Headguard
    ["60303"] = {
        63684, -- Helm of the Forlorn Protector
    },
    -- Lightning-Charged Spaulders
    ["60306"] = {
        64316, -- Mantle of the Forlorn Protector
    },
    -- Faceguard of the Raging Elements
    ["60308"] = {
        63684, -- Helm of the Forlorn Protector
    },
    -- Mantle of the Raging Elements
    ["60311"] = {
        64316, -- Mantle of the Forlorn Protector
    },
    -- Headpiece of the Raging Elements
    ["60315"] = {
        63684, -- Helm of the Forlorn Protector
    },
    -- Shoulderwraps of the Raging Elements
    ["60317"] = {
        64316, -- Mantle of the Forlorn Protector
    },
    -- Helmet of the Raging Elements
    ["60320"] = {
        63684, -- Helm of the Forlorn Protector
    },
    -- Spaulders of the Raging Elements
    ["60322"] = {
        64316, -- Mantle of the Forlorn Protector
    },
    -- Earthen Helmet
    ["60325"] = {
        63684, -- Helm of the Forlorn Protector
    },
    -- Earthen Pauldrons
    ["60327"] = {
        64316, -- Mantle of the Forlorn Protector
    },
    -- Earthen Faceguard
    ["60328"] = {
        63684, -- Helm of the Forlorn Protector
    },
    -- Earthen Shoulderguards
    ["60331"] = {
        64316, -- Mantle of the Forlorn Protector
    },
    -- Magma Plated Helmet
    ["60341"] = {
        63682, -- Helm of the Forlorn Vanquisher
    },
    -- Magma Plated Pauldrons
    ["60343"] = {
        64314, -- Mantle of the Forlorn Vanquisher
    },
    -- Reinforced Sapphirium Helmet
    ["60346"] = {
        63683, -- Helm of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Pauldrons
    ["60348"] = {
        64315, -- Mantle of the Forlorn Conqueror
    },
    -- Magma Plated Faceguard
    ["60351"] = {
        63682, -- Helm of the Forlorn Vanquisher
    },
    -- Magma Plated Shoulderguards
    ["60353"] = {
        64314, -- Mantle of the Forlorn Vanquisher
    },
    -- Reinforced Sapphirium Faceguard
    ["60356"] = {
        63683, -- Helm of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Shoulderguards
    ["60358"] = {
        64315, -- Mantle of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Headguard
    ["60359"] = {
        63683, -- Helm of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Mantle
    ["60362"] = {
        64315, -- Mantle of the Forlorn Conqueror
    },
    -- Helm of the Forlorn Vanquisher
    ["63682"] = {
        60243, -- Firelord's Hood
        60277, -- Stormrider's Helm
        60282, -- Stormrider's Cover
        60286, -- Stormrider's Headpiece
        60299, -- Wind Dancer's Helmet
        60341, -- Magma Plated Helmet
        60351, -- Magma Plated Faceguard
    },
    -- Helm of the Forlorn Conqueror
    ["63683"] = {
        60249, -- Shadowflame Hood
        60256, -- Mercurial Hood
        60258, -- Mercurial Cowl
        60346, -- Reinforced Sapphirium Helmet
        60356, -- Reinforced Sapphirium Faceguard
        60359, -- Reinforced Sapphirium Headguard
    },
    -- Helm of the Forlorn Protector
    ["63684"] = {
        60303, -- Lightning-Charged Headguard
        60308, -- Faceguard of the Raging Elements
        60315, -- Headpiece of the Raging Elements
        60320, -- Helmet of the Raging Elements
        60325, -- Earthen Helmet
        60328, -- Earthen Faceguard
    },
    -- Mantle of the Forlorn Vanquisher
    ["64314"] = {
        60246, -- Firelord's Mantle
        60279, -- Stormrider's Mantle
        60284, -- Stormrider's Shoulderwraps
        60289, -- Stormrider's Spaulders
        60302, -- Wind Dancer's Spaulders
        60343, -- Magma Plated Pauldrons
        60353, -- Magma Plated Shoulderguards
    },
    -- Mantle of the Forlorn Conqueror
    ["64315"] = {
        60252, -- Shadowflame Mantle
        60253, -- Mercurial Shoulderwraps
        60262, -- Mercurial Mantle
        60348, -- Reinforced Sapphirium Pauldrons
        60358, -- Reinforced Sapphirium Shoulderguards
        60362, -- Reinforced Sapphirium Mantle
    },
    -- Mantle of the Forlorn Protector
    ["64316"] = {
        60306, -- Lightning-Charged Spaulders
        60311, -- Mantle of the Raging Elements
        60317, -- Shoulderwraps of the Raging Elements
        60322, -- Spaulders of the Raging Elements
        60327, -- Earthen Pauldrons
        60331, -- Earthen Shoulderguards
    },
    -- Crown of the Forlorn Protector
    ["65000"] = {
        65206, -- Lightning-Charged Headguard
        65246, -- Faceguard of the Raging Elements
        65251, -- Helmet of the Raging Elements
        65256, -- Headpiece of the Raging Elements
        65266, -- Earthen Helmet
        65271, -- Earthen Faceguard
    },
    -- Crown of the Forlorn Conqueror
    ["65001"] = {
        65216, -- Reinforced Sapphirium Helmet
        65221, -- Reinforced Sapphirium Headguard
        65226, -- Reinforced Sapphirium Faceguard
        65230, -- Mercurial Cowl
        65235, -- Mercurial Hood
        65260, -- Shadowflame Hood
    },
    -- Crown of the Forlorn Vanquisher
    ["65002"] = {
        65181, -- Magma Plated Helmet
        65186, -- Magma Plated Faceguard
        65190, -- Stormrider's Headpiece
        65195, -- Stormrider's Helm
        65200, -- Stormrider's Cover
        65210, -- Firelord's Hood
        65241, -- Wind Dancer's Helmet
    },
    -- Shoulders of the Forlorn Protector
    ["65087"] = {
        65208, -- Lightning-Charged Spaulders
        65248, -- Mantle of the Raging Elements
        65253, -- Spaulders of the Raging Elements
        65258, -- Shoulderwraps of the Raging Elements
        65268, -- Earthen Pauldrons
        65273, -- Earthen Shoulderguards
    },
    -- Shoulders of the Forlorn Conqueror
    ["65088"] = {
        65218, -- Reinforced Sapphirium Pauldrons
        65223, -- Reinforced Sapphirium Mantle
        65228, -- Reinforced Sapphirium Shoulderguards
        65233, -- Mercurial Mantle
        65238, -- Mercurial Shoulderwraps
        65263, -- Shadowflame Mantle
    },
    -- Shoulders of the Forlorn Vanquisher
    ["65089"] = {
        65183, -- Magma Plated Pauldrons
        65188, -- Magma Plated Shoulderguards
        65193, -- Stormrider's Spaulders
        65198, -- Stormrider's Mantle
        65203, -- Stormrider's Shoulderwraps
        65213, -- Firelord's Mantle
        65243, -- Wind Dancer's Spaulders
    },
    -- Magma Plated Battleplate
    ["65179"] = {
        67425, -- Chest of the Forlorn Vanquisher
    },
    -- Magma Plated Gauntlets
    ["65180"] = {
        67431, -- Gauntlets of the Forlorn Vanquisher
    },
    -- Magma Plated Helmet
    ["65181"] = {
        65002, -- Crown of the Forlorn Vanquisher
    },
    -- Magma Plated Legplates
    ["65182"] = {
        67426, -- Leggings of the Forlorn Vanquisher
    },
    -- Magma Plated Pauldrons
    ["65183"] = {
        65089, -- Shoulders of the Forlorn Vanquisher
    },
    -- Magma Plated Chestguard
    ["65184"] = {
        67425, -- Chest of the Forlorn Vanquisher
    },
    -- Magma Plated Handguards
    ["65185"] = {
        67431, -- Gauntlets of the Forlorn Vanquisher
    },
    -- Magma Plated Faceguard
    ["65186"] = {
        65002, -- Crown of the Forlorn Vanquisher
    },
    -- Magma Plated Legguards
    ["65187"] = {
        67426, -- Leggings of the Forlorn Vanquisher
    },
    -- Magma Plated Shoulderguards
    ["65188"] = {
        65089, -- Shoulders of the Forlorn Vanquisher
    },
    -- Stormrider's Grips
    ["65189"] = {
        67431, -- Gauntlets of the Forlorn Vanquisher
    },
    -- Stormrider's Headpiece
    ["65190"] = {
        65002, -- Crown of the Forlorn Vanquisher
    },
    -- Stormrider's Legguards
    ["65191"] = {
        67426, -- Leggings of the Forlorn Vanquisher
    },
    -- Stormrider's Raiment
    ["65192"] = {
        67425, -- Chest of the Forlorn Vanquisher
    },
    -- Stormrider's Spaulders
    ["65193"] = {
        65089, -- Shoulders of the Forlorn Vanquisher
    },
    -- Stormrider's Handwraps
    ["65194"] = {
        67431, -- Gauntlets of the Forlorn Vanquisher
    },
    -- Stormrider's Helm
    ["65195"] = {
        65002, -- Crown of the Forlorn Vanquisher
    },
    -- Stormrider's Legwraps
    ["65196"] = {
        67426, -- Leggings of the Forlorn Vanquisher
    },
    -- Stormrider's Robes
    ["65197"] = {
        67425, -- Chest of the Forlorn Vanquisher
    },
    -- Stormrider's Mantle
    ["65198"] = {
        65089, -- Shoulders of the Forlorn Vanquisher
    },
    -- Stormrider's Gloves
    ["65199"] = {
        67431, -- Gauntlets of the Forlorn Vanquisher
    },
    -- Stormrider's Cover
    ["65200"] = {
        65002, -- Crown of the Forlorn Vanquisher
    },
    -- Stormrider's Leggings
    ["65201"] = {
        67426, -- Leggings of the Forlorn Vanquisher
    },
    -- Stormrider's Vestment
    ["65202"] = {
        67425, -- Chest of the Forlorn Vanquisher
    },
    -- Stormrider's Shoulderwraps
    ["65203"] = {
        65089, -- Shoulders of the Forlorn Vanquisher
    },
    -- Lightning-Charged Tunic
    ["65204"] = {
        67424, -- Chest of the Forlorn Protector
    },
    -- Lightning-Charged Gloves
    ["65205"] = {
        67430, -- Gauntlets of the Forlorn Protector
    },
    -- Lightning-Charged Headguard
    ["65206"] = {
        65000, -- Crown of the Forlorn Protector
    },
    -- Lightning-Charged Legguards
    ["65207"] = {
        67427, -- Leggings of the Forlorn Protector
    },
    -- Lightning-Charged Spaulders
    ["65208"] = {
        65087, -- Shoulders of the Forlorn Protector
    },
    -- Firelord's Gloves
    ["65209"] = {
        67431, -- Gauntlets of the Forlorn Vanquisher
    },
    -- Firelord's Hood
    ["65210"] = {
        65002, -- Crown of the Forlorn Vanquisher
    },
    -- Firelord's Leggings
    ["65211"] = {
        67426, -- Leggings of the Forlorn Vanquisher
    },
    -- Firelord's Robes
    ["65212"] = {
        67425, -- Chest of the Forlorn Vanquisher
    },
    -- Firelord's Mantle
    ["65213"] = {
        65089, -- Shoulders of the Forlorn Vanquisher
    },
    -- Reinforced Sapphirium Battleplate
    ["65214"] = {
        67423, -- Chest of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Gauntlets
    ["65215"] = {
        67429, -- Gauntlets of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Helmet
    ["65216"] = {
        65001, -- Crown of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Legplates
    ["65217"] = {
        67428, -- Leggings of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Pauldrons
    ["65218"] = {
        65088, -- Shoulders of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Breastplate
    ["65219"] = {
        67423, -- Chest of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Gloves
    ["65220"] = {
        67429, -- Gauntlets of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Headguard
    ["65221"] = {
        65001, -- Crown of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Greaves
    ["65222"] = {
        67428, -- Leggings of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Mantle
    ["65223"] = {
        65088, -- Shoulders of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Chestguard
    ["65224"] = {
        67423, -- Chest of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Handguards
    ["65225"] = {
        67429, -- Gauntlets of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Faceguard
    ["65226"] = {
        65001, -- Crown of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Legguards
    ["65227"] = {
        67428, -- Leggings of the Forlorn Conqueror
    },
    -- Reinforced Sapphirium Shoulderguards
    ["65228"] = {
        65088, -- Shoulders of the Forlorn Conqueror
    },
    -- Mercurial Handwraps
    ["65229"] = {
        67429, -- Gauntlets of the Forlorn Conqueror
    },
    -- Mercurial Cowl
    ["65230"] = {
        65001, -- Crown of the Forlorn Conqueror
    },
    -- Mercurial Legwraps
    ["65231"] = {
        67428, -- Leggings of the Forlorn Conqueror
    },
    -- Mercurial Robes
    ["65232"] = {
        67423, -- Chest of the Forlorn Conqueror
    },
    -- Mercurial Mantle
    ["65233"] = {
        65088, -- Shoulders of the Forlorn Conqueror
    },
    -- Mercurial Gloves
    ["65234"] = {
        67429, -- Gauntlets of the Forlorn Conqueror
    },
    -- Mercurial Hood
    ["65235"] = {
        65001, -- Crown of the Forlorn Conqueror
    },
    -- Mercurial Leggings
    ["65236"] = {
        67428, -- Leggings of the Forlorn Conqueror
    },
    -- Mercurial Vestment
    ["65237"] = {
        67423, -- Chest of the Forlorn Conqueror
    },
    -- Mercurial Shoulderwraps
    ["65238"] = {
        65088, -- Shoulders of the Forlorn Conqueror
    },
    -- Wind Dancer's Tunic
    ["65239"] = {
        67425, -- Chest of the Forlorn Vanquisher
    },
    -- Wind Dancer's Gloves
    ["65240"] = {
        67431, -- Gauntlets of the Forlorn Vanquisher
    },
    -- Wind Dancer's Helmet
    ["65241"] = {
        65002, -- Crown of the Forlorn Vanquisher
    },
    -- Wind Dancer's Legguards
    ["65242"] = {
        67426, -- Leggings of the Forlorn Vanquisher
    },
    -- Wind Dancer's Spaulders
    ["65243"] = {
        65089, -- Shoulders of the Forlorn Vanquisher
    },
    -- Tunic of the Raging Elements
    ["65244"] = {
        67424, -- Chest of the Forlorn Protector
    },
    -- Handwraps of the Raging Elements
    ["65245"] = {
        67430, -- Gauntlets of the Forlorn Protector
    },
    -- Faceguard of the Raging Elements
    ["65246"] = {
        65000, -- Crown of the Forlorn Protector
    },
    -- Legwraps of the Raging Elements
    ["65247"] = {
        67427, -- Leggings of the Forlorn Protector
    },
    -- Mantle of the Raging Elements
    ["65248"] = {
        65087, -- Shoulders of the Forlorn Protector
    },
    -- Cuirass of the Raging Elements
    ["65249"] = {
        67424, -- Chest of the Forlorn Protector
    },
    -- Grips of the Raging Elements
    ["65250"] = {
        67430, -- Gauntlets of the Forlorn Protector
    },
    -- Helmet of the Raging Elements
    ["65251"] = {
        65000, -- Crown of the Forlorn Protector
    },
    -- Legguards of the Raging Elements
    ["65252"] = {
        67427, -- Leggings of the Forlorn Protector
    },
    -- Spaulders of the Raging Elements
    ["65253"] = {
        65087, -- Shoulders of the Forlorn Protector
    },
    -- Hauberk of the Raging Elements
    ["65254"] = {
        67424, -- Chest of the Forlorn Protector
    },
    -- Gloves of the Raging Elements
    ["65255"] = {
        67430, -- Gauntlets of the Forlorn Protector
    },
    -- Headpiece of the Raging Elements
    ["65256"] = {
        65000, -- Crown of the Forlorn Protector
    },
    -- Kilt of the Raging Elements
    ["65257"] = {
        67427, -- Leggings of the Forlorn Protector
    },
    -- Shoulderwraps of the Raging Elements
    ["65258"] = {
        65087, -- Shoulders of the Forlorn Protector
    },
    -- Shadowflame Handwraps
    ["65259"] = {
        67429, -- Gauntlets of the Forlorn Conqueror
    },
    -- Shadowflame Hood
    ["65260"] = {
        65001, -- Crown of the Forlorn Conqueror
    },
    -- Shadowflame Leggings
    ["65261"] = {
        67428, -- Leggings of the Forlorn Conqueror
    },
    -- Shadowflame Robes
    ["65262"] = {
        67423, -- Chest of the Forlorn Conqueror
    },
    -- Shadowflame Mantle
    ["65263"] = {
        65088, -- Shoulders of the Forlorn Conqueror
    },
    -- Earthen Battleplate
    ["65264"] = {
        67424, -- Chest of the Forlorn Protector
    },
    -- Earthen Gauntlets
    ["65265"] = {
        67430, -- Gauntlets of the Forlorn Protector
    },
    -- Earthen Helmet
    ["65266"] = {
        65000, -- Crown of the Forlorn Protector
    },
    -- Earthen Legplates
    ["65267"] = {
        67427, -- Leggings of the Forlorn Protector
    },
    -- Earthen Pauldrons
    ["65268"] = {
        65087, -- Shoulders of the Forlorn Protector
    },
    -- Earthen Chestguard
    ["65269"] = {
        67424, -- Chest of the Forlorn Protector
    },
    -- Earthen Handguards
    ["65270"] = {
        67430, -- Gauntlets of the Forlorn Protector
    },
    -- Earthen Faceguard
    ["65271"] = {
        65000, -- Crown of the Forlorn Protector
    },
    -- Earthen Legguards
    ["65272"] = {
        67427, -- Leggings of the Forlorn Protector
    },
    -- Earthen Shoulderguards
    ["65273"] = {
        65087, -- Shoulders of the Forlorn Protector
    },
    -- Chest of the Forlorn Conqueror
    ["67423"] = {
        65214, -- Reinforced Sapphirium Battleplate
        65219, -- Reinforced Sapphirium Breastplate
        65224, -- Reinforced Sapphirium Chestguard
        65232, -- Mercurial Robes
        65237, -- Mercurial Vestment
        65262, -- Shadowflame Robes
    },
    -- Chest of the Forlorn Protector
    ["67424"] = {
        65204, -- Lightning-Charged Tunic
        65244, -- Tunic of the Raging Elements
        65249, -- Cuirass of the Raging Elements
        65254, -- Hauberk of the Raging Elements
        65264, -- Earthen Battleplate
        65269, -- Earthen Chestguard
    },
    -- Chest of the Forlorn Vanquisher
    ["67425"] = {
        65179, -- Magma Plated Battleplate
        65184, -- Magma Plated Chestguard
        65192, -- Stormrider's Raiment
        65197, -- Stormrider's Robes
        65202, -- Stormrider's Vestment
        65212, -- Firelord's Robes
        65239, -- Wind Dancer's Tunic
    },
    -- Leggings of the Forlorn Vanquisher
    ["67426"] = {
        65182, -- Magma Plated Legplates
        65187, -- Magma Plated Legguards
        65191, -- Stormrider's Legguards
        65196, -- Stormrider's Legwraps
        65201, -- Stormrider's Leggings
        65211, -- Firelord's Leggings
        65242, -- Wind Dancer's Legguards
    },
    -- Leggings of the Forlorn Protector
    ["67427"] = {
        65207, -- Lightning-Charged Legguards
        65247, -- Legwraps of the Raging Elements
        65252, -- Legguards of the Raging Elements
        65257, -- Kilt of the Raging Elements
        65267, -- Earthen Legplates
        65272, -- Earthen Legguards
    },
    -- Leggings of the Forlorn Conqueror
    ["67428"] = {
        65217, -- Reinforced Sapphirium Legplates
        65222, -- Reinforced Sapphirium Greaves
        65227, -- Reinforced Sapphirium Legguards
        65231, -- Mercurial Legwraps
        65236, -- Mercurial Leggings
        65261, -- Shadowflame Leggings
    },
    -- Gauntlets of the Forlorn Conqueror
    ["67429"] = {
        65215, -- Reinforced Sapphirium Gauntlets
        65220, -- Reinforced Sapphirium Gloves
        65225, -- Reinforced Sapphirium Handguards
        65229, -- Mercurial Handwraps
        65234, -- Mercurial Gloves
        65259, -- Shadowflame Handwraps
    },
    -- Gauntlets of the Forlorn Protector
    ["67430"] = {
        65205, -- Lightning-Charged Gloves
        65245, -- Handwraps of the Raging Elements
        65250, -- Grips of the Raging Elements
        65255, -- Gloves of the Raging Elements
        65265, -- Earthen Gauntlets
        65270, -- Earthen Handguards
    },
    -- Gauntlets of the Forlorn Vanquisher
    ["67431"] = {
        65180, -- Magma Plated Gauntlets
        65185, -- Magma Plated Handguards
        65189, -- Stormrider's Grips
        65194, -- Stormrider's Handwraps
        65199, -- Stormrider's Gloves
        65209, -- Firelord's Gloves
        65240, -- Wind Dancer's Gloves
    },
    -- Scales of Life
    ["69109"] = {
        71617, -- Crystallized Firestone
    },
    -- Apparatus of Khaz'goroth
    ["69113"] = {
        71617, -- Crystallized Firestone
    },
    -- Living Ember
    ["69237"] = {
        69936, -- Fists of Fury
        69937, -- Eternal Elementium Handguards
        69938, -- Holy Flame Gauntlets
        69939, -- Dragonfire Gloves
        69941, -- Gloves of Unforgiving Flame
        69942, -- Clutches of Evil
        69943, -- Heavenly Gloves of the Moon
        69944, -- Grips of Altered Reality
        69945, -- Don Tayo's Inferno Mittens
        69946, -- Warboots of Mighty Lords
        69947, -- Mirrored Boots
        69948, -- Emberforged Elementium Boots
        69949, -- Earthen Scale Sabatons
        69950, -- Footwraps of Quenched Fire
        69951, -- Treads of the Craft
        69952, -- Ethereal Footfalls
        69953, -- Endless Dream Walkers
        69954, -- Boots of the Black Flame
    },
    -- Branch of Nordrassil
    ["69646"] = {
        71141, -- Eternal Ember
    },
    -- Seething Cinder
    ["69815"] = {
        71085, -- Runestaff of Nordrassil
        71086, -- Dragonwrath, Tarecgosa's Rest
    },
    -- Fists of Fury
    ["69936"] = {
        69237, -- Living Ember
    },
    -- Eternal Elementium Handguards
    ["69937"] = {
        69237, -- Living Ember
    },
    -- Holy Flame Gauntlets
    ["69938"] = {
        69237, -- Living Ember
    },
    -- Dragonfire Gloves
    ["69939"] = {
        69237, -- Living Ember
    },
    -- Gloves of Unforgiving Flame
    ["69941"] = {
        69237, -- Living Ember
    },
    -- Clutches of Evil
    ["69942"] = {
        69237, -- Living Ember
    },
    -- Heavenly Gloves of the Moon
    ["69943"] = {
        69237, -- Living Ember
    },
    -- Grips of Altered Reality
    ["69944"] = {
        69237, -- Living Ember
    },
    -- Don Tayo's Inferno Mittens
    ["69945"] = {
        69237, -- Living Ember
    },
    -- Warboots of Mighty Lords
    ["69946"] = {
        69237, -- Living Ember
    },
    -- Mirrored Boots
    ["69947"] = {
        69237, -- Living Ember
    },
    -- Emberforged Elementium Boots
    ["69948"] = {
        69237, -- Living Ember
    },
    -- Earthen Scale Sabatons
    ["69949"] = {
        69237, -- Living Ember
    },
    -- Footwraps of Quenched Fire
    ["69950"] = {
        69237, -- Living Ember
    },
    -- Treads of the Craft
    ["69951"] = {
        69237, -- Living Ember
    },
    -- Ethereal Footfalls
    ["69952"] = {
        69237, -- Living Ember
    },
    -- Endless Dream Walkers
    ["69953"] = {
        69237, -- Living Ember
    },
    -- Boots of the Black Flame
    ["69954"] = {
        69237, -- Living Ember
    },
    -- Shoulderguards of the Molten Giant
    ["70941"] = {
        71688, -- Mantle of the Fiery Protector
    },
    -- Faceguard of the Molten Giant
    ["70944"] = {
        71682, -- Helm of the Fiery Protector
    },
    -- Immolation Shoulderguards
    ["70946"] = {
        71681, -- Mantle of the Fiery Conqueror
    },
    -- Immolation Faceguard
    ["70948"] = {
        71675, -- Helm of the Fiery Conqueror
    },
    -- Elementium Deathplate Shoulderguards
    ["70951"] = {
        71674, -- Mantle of the Fiery Vanquisher
    },
    -- Elementium Deathplate Faceguard
    ["70954"] = {
        71668, -- Helm of the Fiery Vanquisher
    },
    -- Dark Phoenix Helmet
    ["71047"] = {
        71668, -- Helm of the Fiery Vanquisher
    },
    -- Dark Phoenix Spaulders
    ["71049"] = {
        71674, -- Mantle of the Fiery Vanquisher
    },
    -- Flamewaker's Headguard
    ["71051"] = {
        71682, -- Helm of the Fiery Protector
    },
    -- Flamewaker's Spaulders
    ["71053"] = {
        71688, -- Mantle of the Fiery Protector
    },
    -- Elementium Deathplate Helmet
    ["71060"] = {
        71668, -- Helm of the Fiery Vanquisher
    },
    -- Elementium Deathplate Pauldrons
    ["71062"] = {
        71674, -- Mantle of the Fiery Vanquisher
    },
    -- Immolation Helmet
    ["71065"] = {
        71675, -- Helm of the Fiery Conqueror
    },
    -- Immolation Pauldrons
    ["71067"] = {
        71681, -- Mantle of the Fiery Conqueror
    },
    -- Helmet of the Molten Giant
    ["71070"] = {
        71682, -- Helm of the Fiery Protector
    },
    -- Pauldrons of the Molten Giant
    ["71072"] = {
        71688, -- Mantle of the Fiery Protector
    },
    -- Branch of Nordrassil
    ["71084"] = {
        71141, -- Eternal Ember
    },
    -- Runestaff of Nordrassil
    ["71085"] = {
        69815, -- Seething Cinder
    },
    -- Dragonwrath, Tarecgosa's Rest
    ["71086"] = {
        69815, -- Seething Cinder
    },
    -- Immolation Headguard
    ["71093"] = {
        71675, -- Helm of the Fiery Conqueror
    },
    -- Immolation Mantle
    ["71095"] = {
        71681, -- Mantle of the Fiery Conqueror
    },
    -- Obsidian Arborweave Headpiece
    ["71098"] = {
        71668, -- Helm of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Spaulders
    ["71101"] = {
        71674, -- Mantle of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Helm
    ["71103"] = {
        71668, -- Helm of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Mantle
    ["71106"] = {
        71674, -- Mantle of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Cover
    ["71108"] = {
        71668, -- Helm of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Shoulderwraps
    ["71111"] = {
        71674, -- Mantle of the Fiery Vanquisher
    },
    -- Eternal Ember
    ["71141"] = {
        69646, -- Branch of Nordrassil
        71084, -- Branch of Nordrassil
    },
    -- Cowl of the Cleansing Flame
    ["71272"] = {
        71675, -- Helm of the Fiery Conqueror
    },
    -- Mantle of the Cleansing Flame
    ["71275"] = {
        71681, -- Mantle of the Fiery Conqueror
    },
    -- Hood of the Cleansing Flame
    ["71277"] = {
        71675, -- Helm of the Fiery Conqueror
    },
    -- Shoulderwraps of the Cleansing Flame
    ["71280"] = {
        71681, -- Mantle of the Fiery Conqueror
    },
    -- Balespider's Hood
    ["71282"] = {
        71675, -- Helm of the Fiery Conqueror
    },
    -- Balespider's Mantle
    ["71285"] = {
        71681, -- Mantle of the Fiery Conqueror
    },
    -- Firehawk Hood
    ["71287"] = {
        71668, -- Helm of the Fiery Vanquisher
    },
    -- Firehawk Mantle
    ["71290"] = {
        71674, -- Mantle of the Fiery Vanquisher
    },
    -- Erupting Volcanic Headpiece
    ["71293"] = {
        71682, -- Helm of the Fiery Protector
    },
    -- Erupting Volcanic Shoulderwraps
    ["71295"] = {
        71688, -- Mantle of the Fiery Protector
    },
    -- Erupting Volcanic Faceguard
    ["71298"] = {
        71682, -- Helm of the Fiery Protector
    },
    -- Erupting Volcanic Mantle
    ["71300"] = {
        71688, -- Mantle of the Fiery Protector
    },
    -- Erupting Volcanic Helmet
    ["71303"] = {
        71682, -- Helm of the Fiery Protector
    },
    -- Erupting Volcanic Spaulders
    ["71305"] = {
        71688, -- Mantle of the Fiery Protector
    },
    -- Elementium Deathplate Breastplate
    ["71476"] = {
        71672, -- Chest of the Fiery Vanquisher
    },
    -- Elementium Deathplate Gauntlets
    ["71477"] = {
        71669, -- Gauntlets of the Fiery Vanquisher
    },
    -- Elementium Deathplate Helmet
    ["71478"] = {
        71670, -- Crown of the Fiery Vanquisher
    },
    -- Elementium Deathplate Greaves
    ["71479"] = {
        71671, -- Leggings of the Fiery Vanquisher
    },
    -- Elementium Deathplate Pauldrons
    ["71480"] = {
        71673, -- Shoulders of the Fiery Vanquisher
    },
    -- Elementium Deathplate Chestguard
    ["71481"] = {
        71672, -- Chest of the Fiery Vanquisher
    },
    -- Elementium Deathplate Handguards
    ["71482"] = {
        71669, -- Gauntlets of the Fiery Vanquisher
    },
    -- Elementium Deathplate Faceguard
    ["71483"] = {
        71670, -- Crown of the Fiery Vanquisher
    },
    -- Elementium Deathplate Legguards
    ["71484"] = {
        71671, -- Leggings of the Fiery Vanquisher
    },
    -- Elementium Deathplate Shoulderguards
    ["71485"] = {
        71673, -- Shoulders of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Raiment
    ["71486"] = {
        71672, -- Chest of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Grips
    ["71487"] = {
        71669, -- Gauntlets of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Headpiece
    ["71488"] = {
        71670, -- Crown of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Legguards
    ["71489"] = {
        71671, -- Leggings of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Spaulders
    ["71490"] = {
        71673, -- Shoulders of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Handwraps
    ["71491"] = {
        71669, -- Gauntlets of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Helm
    ["71492"] = {
        71670, -- Crown of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Legwraps
    ["71493"] = {
        71671, -- Leggings of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Mantle
    ["71495"] = {
        71673, -- Shoulders of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Gloves
    ["71496"] = {
        71669, -- Gauntlets of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Cover
    ["71497"] = {
        71670, -- Crown of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Leggings
    ["71498"] = {
        71671, -- Leggings of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Vestment
    ["71499"] = {
        71672, -- Chest of the Fiery Vanquisher
    },
    -- Obsidian Arborweave Shoulderwraps
    ["71500"] = {
        71673, -- Shoulders of the Fiery Vanquisher
    },
    -- Flamewaker's Tunic
    ["71501"] = {
        71686, -- Chest of the Fiery Protector
    },
    -- Flamewaker's Gloves
    ["71502"] = {
        71683, -- Gauntlets of the Fiery Protector
    },
    -- Flamewaker's Headguard
    ["71503"] = {
        71684, -- Crown of the Fiery Protector
    },
    -- Flamewaker's Legguards
    ["71504"] = {
        71685, -- Leggings of the Fiery Protector
    },
    -- Flamewaker's Spaulders
    ["71505"] = {
        71687, -- Shoulders of the Fiery Protector
    },
    -- Firehawk Gloves
    ["71507"] = {
        71669, -- Gauntlets of the Fiery Vanquisher
    },
    -- Firehawk Hood
    ["71508"] = {
        71670, -- Crown of the Fiery Vanquisher
    },
    -- Firehawk Leggings
    ["71509"] = {
        71671, -- Leggings of the Fiery Vanquisher
    },
    -- Firehawk Robes
    ["71510"] = {
        71672, -- Chest of the Fiery Vanquisher
    },
    -- Firehawk Mantle
    ["71511"] = {
        71673, -- Shoulders of the Fiery Vanquisher
    },
    -- Immolation Battleplate
    ["71512"] = {
        71679, -- Chest of the Fiery Conqueror
    },
    -- Immolation Gauntlets
    ["71513"] = {
        71676, -- Gauntlets of the Fiery Conqueror
    },
    -- Immolation Helmet
    ["71514"] = {
        71677, -- Crown of the Fiery Conqueror
    },
    -- Immolation Legplates
    ["71515"] = {
        71678, -- Leggings of the Fiery Conqueror
    },
    -- Immolation Pauldrons
    ["71516"] = {
        71680, -- Shoulders of the Fiery Conqueror
    },
    -- Immolation Breastplate
    ["71517"] = {
        71679, -- Chest of the Fiery Conqueror
    },
    -- Immolation Gloves
    ["71518"] = {
        71676, -- Gauntlets of the Fiery Conqueror
    },
    -- Immolation Headguard
    ["71519"] = {
        71677, -- Crown of the Fiery Conqueror
    },
    -- Immolation Greaves
    ["71520"] = {
        71678, -- Leggings of the Fiery Conqueror
    },
    -- Immolation Mantle
    ["71521"] = {
        71680, -- Shoulders of the Fiery Conqueror
    },
    -- Immolation Chestguard
    ["71522"] = {
        71679, -- Chest of the Fiery Conqueror
    },
    -- Immolation Handguards
    ["71523"] = {
        71676, -- Gauntlets of the Fiery Conqueror
    },
    -- Immolation Faceguard
    ["71524"] = {
        71677, -- Crown of the Fiery Conqueror
    },
    -- Immolation Legguards
    ["71525"] = {
        71678, -- Leggings of the Fiery Conqueror
    },
    -- Immolation Shoulderguards
    ["71526"] = {
        71680, -- Shoulders of the Fiery Conqueror
    },
    -- Handwraps of the Cleansing Flame
    ["71527"] = {
        71676, -- Gauntlets of the Fiery Conqueror
    },
    -- Cowl of the Cleansing Flame
    ["71528"] = {
        71677, -- Crown of the Fiery Conqueror
    },
    -- Legwraps of the Cleansing Flame
    ["71529"] = {
        71678, -- Leggings of the Fiery Conqueror
    },
    -- Robes of the Cleansing Flame
    ["71530"] = {
        71679, -- Chest of the Fiery Conqueror
    },
    -- Mantle of the Cleansing Flame
    ["71531"] = {
        71680, -- Shoulders of the Fiery Conqueror
    },
    -- Gloves of the Cleansing Flame
    ["71532"] = {
        71676, -- Gauntlets of the Fiery Conqueror
    },
    -- Hood of the Cleansing Flame
    ["71533"] = {
        71677, -- Crown of the Fiery Conqueror
    },
    -- Leggings of the Cleansing Flame
    ["71534"] = {
        71678, -- Leggings of the Fiery Conqueror
    },
    -- Vestment of the Cleansing Flame
    ["71535"] = {
        71679, -- Chest of the Fiery Conqueror
    },
    -- Shoulderwraps of the Cleansing Flame
    ["71536"] = {
        71680, -- Shoulders of the Fiery Conqueror
    },
    -- Dark Phoenix Tunic
    ["71537"] = {
        71672, -- Chest of the Fiery Vanquisher
    },
    -- Dark Phoenix Gloves
    ["71538"] = {
        71669, -- Gauntlets of the Fiery Vanquisher
    },
    -- Dark Phoenix Helmet
    ["71539"] = {
        71670, -- Crown of the Fiery Vanquisher
    },
    -- Dark Phoenix Legguards
    ["71540"] = {
        71671, -- Leggings of the Fiery Vanquisher
    },
    -- Dark Phoenix Spaulders
    ["71541"] = {
        71673, -- Shoulders of the Fiery Vanquisher
    },
    -- Erupting Volcanic Tunic
    ["71542"] = {
        71686, -- Chest of the Fiery Protector
    },
    -- Erupting Volcanic Handwraps
    ["71543"] = {
        71683, -- Gauntlets of the Fiery Protector
    },
    -- Erupting Volcanic Faceguard
    ["71544"] = {
        71684, -- Crown of the Fiery Protector
    },
    -- Erupting Volcanic Legwraps
    ["71545"] = {
        71685, -- Leggings of the Fiery Protector
    },
    -- Erupting Volcanic Mantle
    ["71546"] = {
        71687, -- Shoulders of the Fiery Protector
    },
    -- Erupting Volcanic Cuirass
    ["71547"] = {
        71686, -- Chest of the Fiery Protector
    },
    -- Erupting Volcanic Grips
    ["71548"] = {
        71683, -- Gauntlets of the Fiery Protector
    },
    -- Erupting Volcanic Helmet
    ["71549"] = {
        71684, -- Crown of the Fiery Protector
    },
    -- Erupting Volcanic Legguards
    ["71550"] = {
        71685, -- Leggings of the Fiery Protector
    },
    -- Erupting Volcanic Spaulders
    ["71551"] = {
        71687, -- Shoulders of the Fiery Protector
    },
    -- Erupting Volcanic Hauberk
    ["71552"] = {
        71686, -- Chest of the Fiery Protector
    },
    -- Erupting Volcanic Gloves
    ["71553"] = {
        71683, -- Gauntlets of the Fiery Protector
    },
    -- Erupting Volcanic Headpiece
    ["71554"] = {
        71684, -- Crown of the Fiery Protector
    },
    -- Erupting Volcanic Kilt
    ["71555"] = {
        71685, -- Leggings of the Fiery Protector
    },
    -- Erupting Volcanic Shoulderwraps
    ["71556"] = {
        71687, -- Shoulders of the Fiery Protector
    },
    -- Ranseur of Hatred
    ["71557"] = {
        71617, -- Crystallized Firestone
    },
    -- Lava Bolt Crossbow
    ["71558"] = {
        71617, -- Crystallized Firestone
    },
    -- Spire of Scarlet Pain
    ["71559"] = {
        71617, -- Crystallized Firestone
    },
    -- Chelley's Sterilized Scalpel
    ["71560"] = {
        71617, -- Crystallized Firestone
    },
    -- Hide-Bound Chains
    ["71561"] = {
        71617, -- Crystallized Firestone
    },
    -- Obsidium Cleaver
    ["71562"] = {
        71617, -- Crystallized Firestone
    },
    -- Firebound Gorget
    ["71563"] = {
        71617, -- Crystallized Firestone
    },
    -- Theck's Emberseal
    ["71564"] = {
        71617, -- Crystallized Firestone
    },
    -- Trail of Embers
    ["71575"] = {
        71617, -- Crystallized Firestone
    },
    -- Scorchvine Wand
    ["71579"] = {
        71617, -- Crystallized Firestone
    },
    -- Balespider's Handwraps
    ["71594"] = {
        71676, -- Gauntlets of the Fiery Conqueror
    },
    -- Balespider's Hood
    ["71595"] = {
        71677, -- Crown of the Fiery Conqueror
    },
    -- Balespider's Leggings
    ["71596"] = {
        71678, -- Leggings of the Fiery Conqueror
    },
    -- Balespider's Robes
    ["71597"] = {
        71679, -- Chest of the Fiery Conqueror
    },
    -- Balespider's Mantle
    ["71598"] = {
        71680, -- Shoulders of the Fiery Conqueror
    },
    -- Helmet of the Molten Giant
    ["71599"] = {
        71684, -- Crown of the Fiery Protector
    },
    -- Battleplate of the Molten Giant
    ["71600"] = {
        71686, -- Chest of the Fiery Protector
    },
    -- Gauntlets of the Molten Giant
    ["71601"] = {
        71683, -- Gauntlets of the Fiery Protector
    },
    -- Legplates of the Molten Giant
    ["71602"] = {
        71685, -- Leggings of the Fiery Protector
    },
    -- Pauldrons of the Molten Giant
    ["71603"] = {
        71687, -- Shoulders of the Fiery Protector
    },
    -- Chestguard of the Molten Giant
    ["71604"] = {
        71686, -- Chest of the Fiery Protector
    },
    -- Handguards of the Molten Giant
    ["71605"] = {
        71683, -- Gauntlets of the Fiery Protector
    },
    -- Faceguard of the Molten Giant
    ["71606"] = {
        71684, -- Crown of the Fiery Protector
    },
    -- Legguards of the Molten Giant
    ["71607"] = {
        71685, -- Leggings of the Fiery Protector
    },
    -- Shoulderguards of the Molten Giant
    ["71608"] = {
        71687, -- Shoulders of the Fiery Protector
    },
    -- Crystallized Firestone
    ["71617"] = {
        69109, -- Scales of Life
        69113, -- Apparatus of Khaz'goroth
        71557, -- Ranseur of Hatred
        71558, -- Lava Bolt Crossbow
        71559, -- Spire of Scarlet Pain
        71560, -- Chelley's Sterilized Scalpel
        71561, -- Hide-Bound Chains
        71562, -- Obsidium Cleaver
        71563, -- Firebound Gorget
        71564, -- Theck's Emberseal
        71575, -- Trail of Embers
        71579, -- Scorchvine Wand
        71641, -- Riplimb's Lost Collar
    },
    -- Riplimb's Lost Collar
    ["71641"] = {
        71617, -- Crystallized Firestone
    },
    -- Helm of the Fiery Vanquisher
    ["71668"] = {
        70954, -- Elementium Deathplate Faceguard
        71047, -- Dark Phoenix Helmet
        71060, -- Elementium Deathplate Helmet
        71098, -- Obsidian Arborweave Headpiece
        71103, -- Obsidian Arborweave Helm
        71108, -- Obsidian Arborweave Cover
        71287, -- Firehawk Hood
    },
    -- Gauntlets of the Fiery Vanquisher
    ["71669"] = {
        71477, -- Elementium Deathplate Gauntlets
        71482, -- Elementium Deathplate Handguards
        71487, -- Obsidian Arborweave Grips
        71491, -- Obsidian Arborweave Handwraps
        71496, -- Obsidian Arborweave Gloves
        71507, -- Firehawk Gloves
        71538, -- Dark Phoenix Gloves
    },
    -- Crown of the Fiery Vanquisher
    ["71670"] = {
        71478, -- Elementium Deathplate Helmet
        71483, -- Elementium Deathplate Faceguard
        71488, -- Obsidian Arborweave Headpiece
        71492, -- Obsidian Arborweave Helm
        71497, -- Obsidian Arborweave Cover
        71508, -- Firehawk Hood
        71539, -- Dark Phoenix Helmet
    },
    -- Leggings of the Fiery Vanquisher
    ["71671"] = {
        71479, -- Elementium Deathplate Greaves
        71484, -- Elementium Deathplate Legguards
        71489, -- Obsidian Arborweave Legguards
        71493, -- Obsidian Arborweave Legwraps
        71498, -- Obsidian Arborweave Leggings
        71509, -- Firehawk Leggings
        71540, -- Dark Phoenix Legguards
    },
    -- Chest of the Fiery Vanquisher
    ["71672"] = {
        71476, -- Elementium Deathplate Breastplate
        71481, -- Elementium Deathplate Chestguard
        71486, -- Obsidian Arborweave Raiment
        71499, -- Obsidian Arborweave Vestment
        71510, -- Firehawk Robes
        71537, -- Dark Phoenix Tunic
    },
    -- Shoulders of the Fiery Vanquisher
    ["71673"] = {
        71480, -- Elementium Deathplate Pauldrons
        71485, -- Elementium Deathplate Shoulderguards
        71490, -- Obsidian Arborweave Spaulders
        71495, -- Obsidian Arborweave Mantle
        71500, -- Obsidian Arborweave Shoulderwraps
        71511, -- Firehawk Mantle
        71541, -- Dark Phoenix Spaulders
    },
    -- Mantle of the Fiery Vanquisher
    ["71674"] = {
        70951, -- Elementium Deathplate Shoulderguards
        71049, -- Dark Phoenix Spaulders
        71062, -- Elementium Deathplate Pauldrons
        71101, -- Obsidian Arborweave Spaulders
        71106, -- Obsidian Arborweave Mantle
        71111, -- Obsidian Arborweave Shoulderwraps
        71290, -- Firehawk Mantle
    },
    -- Helm of the Fiery Conqueror
    ["71675"] = {
        70948, -- Immolation Faceguard
        71065, -- Immolation Helmet
        71093, -- Immolation Headguard
        71272, -- Cowl of the Cleansing Flame
        71277, -- Hood of the Cleansing Flame
        71282, -- Balespider's Hood
    },
    -- Gauntlets of the Fiery Conqueror
    ["71676"] = {
        71513, -- Immolation Gauntlets
        71518, -- Immolation Gloves
        71523, -- Immolation Handguards
        71527, -- Handwraps of the Cleansing Flame
        71532, -- Gloves of the Cleansing Flame
        71594, -- Balespider's Handwraps
    },
    -- Crown of the Fiery Conqueror
    ["71677"] = {
        71514, -- Immolation Helmet
        71519, -- Immolation Headguard
        71524, -- Immolation Faceguard
        71528, -- Cowl of the Cleansing Flame
        71533, -- Hood of the Cleansing Flame
        71595, -- Balespider's Hood
    },
    -- Leggings of the Fiery Conqueror
    ["71678"] = {
        71515, -- Immolation Legplates
        71520, -- Immolation Greaves
        71525, -- Immolation Legguards
        71529, -- Legwraps of the Cleansing Flame
        71534, -- Leggings of the Cleansing Flame
        71596, -- Balespider's Leggings
    },
    -- Chest of the Fiery Conqueror
    ["71679"] = {
        71512, -- Immolation Battleplate
        71517, -- Immolation Breastplate
        71522, -- Immolation Chestguard
        71530, -- Robes of the Cleansing Flame
        71535, -- Vestment of the Cleansing Flame
        71597, -- Balespider's Robes
    },
    -- Shoulders of the Fiery Conqueror
    ["71680"] = {
        71516, -- Immolation Pauldrons
        71521, -- Immolation Mantle
        71526, -- Immolation Shoulderguards
        71531, -- Mantle of the Cleansing Flame
        71536, -- Shoulderwraps of the Cleansing Flame
        71598, -- Balespider's Mantle
    },
    -- Mantle of the Fiery Conqueror
    ["71681"] = {
        70946, -- Immolation Shoulderguards
        71067, -- Immolation Pauldrons
        71095, -- Immolation Mantle
        71275, -- Mantle of the Cleansing Flame
        71280, -- Shoulderwraps of the Cleansing Flame
        71285, -- Balespider's Mantle
    },
    -- Helm of the Fiery Protector
    ["71682"] = {
        70944, -- Faceguard of the Molten Giant
        71051, -- Flamewaker's Headguard
        71070, -- Helmet of the Molten Giant
        71293, -- Erupting Volcanic Headpiece
        71298, -- Erupting Volcanic Faceguard
        71303, -- Erupting Volcanic Helmet
    },
    -- Gauntlets of the Fiery Protector
    ["71683"] = {
        71502, -- Flamewaker's Gloves
        71543, -- Erupting Volcanic Handwraps
        71548, -- Erupting Volcanic Grips
        71553, -- Erupting Volcanic Gloves
        71601, -- Gauntlets of the Molten Giant
        71605, -- Handguards of the Molten Giant
    },
    -- Crown of the Fiery Protector
    ["71684"] = {
        71503, -- Flamewaker's Headguard
        71544, -- Erupting Volcanic Faceguard
        71549, -- Erupting Volcanic Helmet
        71554, -- Erupting Volcanic Headpiece
        71599, -- Helmet of the Molten Giant
        71606, -- Faceguard of the Molten Giant
    },
    -- Leggings of the Fiery Protector
    ["71685"] = {
        71504, -- Flamewaker's Legguards
        71545, -- Erupting Volcanic Legwraps
        71550, -- Erupting Volcanic Legguards
        71555, -- Erupting Volcanic Kilt
        71602, -- Legplates of the Molten Giant
        71607, -- Legguards of the Molten Giant
    },
    -- Chest of the Fiery Protector
    ["71686"] = {
        71501, -- Flamewaker's Tunic
        71542, -- Erupting Volcanic Tunic
        71547, -- Erupting Volcanic Cuirass
        71552, -- Erupting Volcanic Hauberk
        71600, -- Battleplate of the Molten Giant
        71604, -- Chestguard of the Molten Giant
    },
    -- Shoulders of the Fiery Protector
    ["71687"] = {
        71505, -- Flamewaker's Spaulders
        71546, -- Erupting Volcanic Mantle
        71551, -- Erupting Volcanic Spaulders
        71556, -- Erupting Volcanic Shoulderwraps
        71603, -- Pauldrons of the Molten Giant
        71608, -- Shoulderguards of the Molten Giant
    },
    -- Mantle of the Fiery Protector
    ["71688"] = {
        70941, -- Shoulderguards of the Molten Giant
        71053, -- Flamewaker's Spaulders
        71072, -- Pauldrons of the Molten Giant
        71295, -- Erupting Volcanic Shoulderwraps
        71300, -- Erupting Volcanic Mantle
        71305, -- Erupting Volcanic Spaulders
    },
    -- Lavaquake Legwraps
    ["71980"] = {
        71998, -- Essence of Destruction
    },
    -- World Mender's Pants
    ["71981"] = {
        71998, -- Essence of Destruction
    },
    -- Pyrium Legplates of Purified Evil
    ["71982"] = {
        71998, -- Essence of Destruction
    },
    -- Unstoppable Destroyer's Legplates
    ["71983"] = {
        71998, -- Essence of Destruction
    },
    -- Foundations of Courage
    ["71984"] = {
        71998, -- Essence of Destruction
    },
    -- Bladeshadow Leggings
    ["71985"] = {
        71998, -- Essence of Destruction
    },
    -- Leggings of Nature's Champion
    ["71986"] = {
        71998, -- Essence of Destruction
    },
    -- Rended Earth Leggings
    ["71987"] = {
        71998, -- Essence of Destruction
    },
    -- Deathscale Leggings
    ["71988"] = {
        71998, -- Essence of Destruction
    },
    -- Bracers of Unconquered Power
    ["71989"] = {
        71998, -- Essence of Destruction
    },
    -- Dreamwraps of the Light
    ["71990"] = {
        71998, -- Essence of Destruction
    },
    -- Soul Redeemer Bracers
    ["71991"] = {
        71998, -- Essence of Destruction
    },
    -- Bracers of Destructive Strength
    ["71992"] = {
        71998, -- Essence of Destruction
    },
    -- Titanguard Wristplates
    ["71993"] = {
        71998, -- Essence of Destruction
    },
    -- Bladeshadow Wristguards
    ["71994"] = {
        71998, -- Essence of Destruction
    },
    -- Bracers of Flowing Serenity
    ["71995"] = {
        71998, -- Essence of Destruction
    },
    -- Bracers of the Hunter-Killer
    ["71996"] = {
        71998, -- Essence of Destruction
    },
    -- Thundering Deathscale Wristguards
    ["71997"] = {
        71998, -- Essence of Destruction
    },
    -- Essence of Destruction
    ["71998"] = {
        71980, -- Lavaquake Legwraps
        71981, -- World Mender's Pants
        71982, -- Pyrium Legplates of Purified Evil
        71983, -- Unstoppable Destroyer's Legplates
        71984, -- Foundations of Courage
        71985, -- Bladeshadow Leggings
        71986, -- Leggings of Nature's Champion
        71987, -- Rended Earth Leggings
        71988, -- Deathscale Leggings
        71989, -- Bracers of Unconquered Power
        71990, -- Dreamwraps of the Light
        71991, -- Soul Redeemer Bracers
        71992, -- Bracers of Destructive Strength
        71993, -- Titanguard Wristplates
        71994, -- Bladeshadow Wristguards
        71995, -- Bracers of Flowing Serenity
        71996, -- Bracers of the Hunter-Killer
        71997, -- Thundering Deathscale Wristguards
    },
    -- Time Lord's Gloves
    ["76212"] = {
        78173, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Time Lord's Hood
    ["76213"] = {
        78172, -- Crown of the Corrupted Vanquisher
    },
    -- Time Lord's Leggings
    ["76214"] = {
        78171, -- Leggings of the Corrupted Vanquisher
    },
    -- Time Lord's Robes
    ["76215"] = {
        78174, -- Chest of the Corrupted Vanquisher
    },
    -- Time Lord's Mantle
    ["76216"] = {
        78170, -- Shoulders of the Corrupted Vanquisher
    },
    -- Mantle of the Faceless Shroud
    ["76339"] = {
        78180, -- Shoulders of the Corrupted Conqueror
    },
    -- Robes of the Faceless Shroud
    ["76340"] = {
        78184, -- Chest of the Corrupted Conqueror
    },
    -- Leggings of the Faceless Shroud
    ["76341"] = {
        78181, -- Leggings of the Corrupted Conqueror
    },
    -- Hood of the Faceless Shroud
    ["76342"] = {
        78182, -- Crown of the Corrupted Conqueror
    },
    -- Gloves of the Faceless Shroud
    ["76343"] = {
        78183, -- Gauntlets of the Corrupted Conqueror
    },
    -- Mantle of Dying Light
    ["76344"] = {
        78180, -- Shoulders of the Corrupted Conqueror
    },
    -- Robes of Dying Light
    ["76345"] = {
        78184, -- Chest of the Corrupted Conqueror
    },
    -- Leggings of Dying Light
    ["76346"] = {
        78181, -- Leggings of the Corrupted Conqueror
    },
    -- Hood of Dying Light
    ["76347"] = {
        78182, -- Crown of the Corrupted Conqueror
    },
    -- Gloves of Dying Light
    ["76348"] = {
        78183, -- Gauntlets of the Corrupted Conqueror
    },
    -- Handwraps of Dying Light
    ["76357"] = {
        78183, -- Gauntlets of the Corrupted Conqueror
    },
    -- Cowl of Dying Light
    ["76358"] = {
        78182, -- Crown of the Corrupted Conqueror
    },
    -- Legwraps of Dying Light
    ["76359"] = {
        78181, -- Leggings of the Corrupted Conqueror
    },
    -- Robes of Dying Light
    ["76360"] = {
        78184, -- Chest of the Corrupted Conqueror
    },
    -- Mantle of Dying Light
    ["76361"] = {
        78180, -- Shoulders of the Corrupted Conqueror
    },
    -- Deep Earth Handwraps
    ["76749"] = {
        78173, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Deep Earth Helm
    ["76750"] = {
        78172, -- Crown of the Corrupted Vanquisher
    },
    -- Deep Earth Legwraps
    ["76751"] = {
        78171, -- Leggings of the Corrupted Vanquisher
    },
    -- Deep Earth Robes
    ["76752"] = {
        78174, -- Chest of the Corrupted Vanquisher
    },
    -- Deep Earth Mantle
    ["76753"] = {
        78170, -- Shoulders of the Corrupted Vanquisher
    },
    -- Spiritwalker's Tunic
    ["76756"] = {
        78179, -- Chest of the Corrupted Protector
    },
    -- Spiritwalker's Handwraps
    ["76757"] = {
        78178, -- Gauntlets of the Corrupted Protector
    },
    -- Spiritwalker's Faceguard
    ["76758"] = {
        78177, -- Crown of the Corrupted Protector
    },
    -- Spiritwalker's Legwraps
    ["76759"] = {
        78176, -- Leggings of the Corrupted Protector
    },
    -- Spiritwalker's Mantle
    ["76760"] = {
        78175, -- Shoulders of the Corrupted Protector
    },
    -- Breastplate of Radiant Glory
    ["76765"] = {
        78184, -- Chest of the Corrupted Conqueror
    },
    -- Gloves of Radiant Glory
    ["76766"] = {
        78183, -- Gauntlets of the Corrupted Conqueror
    },
    -- Headguard of Radiant Glory
    ["76767"] = {
        78182, -- Crown of the Corrupted Conqueror
    },
    -- Greaves of Radiant Glory
    ["76768"] = {
        78181, -- Leggings of the Corrupted Conqueror
    },
    -- Mantle of Radiant Glory
    ["76769"] = {
        78180, -- Shoulders of the Corrupted Conqueror
    },
    -- Battleplate of Radiant Glory
    ["76874"] = {
        78184, -- Chest of the Corrupted Conqueror
    },
    -- Gauntlets of Radiant Glory
    ["76875"] = {
        78183, -- Gauntlets of the Corrupted Conqueror
    },
    -- Helmet of Radiant Glory
    ["76876"] = {
        78182, -- Crown of the Corrupted Conqueror
    },
    -- Legplates of Radiant Glory
    ["76877"] = {
        78181, -- Leggings of the Corrupted Conqueror
    },
    -- Pauldrons of Radiant Glory
    ["76878"] = {
        78180, -- Shoulders of the Corrupted Conqueror
    },
    -- Necrotic Boneplate Breastplate
    ["76974"] = {
        78174, -- Chest of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Gauntlets
    ["76975"] = {
        78173, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Helmet
    ["76976"] = {
        78172, -- Crown of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Greaves
    ["76977"] = {
        78171, -- Leggings of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Pauldrons
    ["76978"] = {
        78170, -- Shoulders of the Corrupted Vanquisher
    },
    -- Colossal Dragonplate Helmet
    ["76983"] = {
        78177, -- Crown of the Corrupted Protector
    },
    -- Colossal Dragonplate Battleplate
    ["76984"] = {
        78179, -- Chest of the Corrupted Protector
    },
    -- Colossal Dragonplate Gauntlets
    ["76985"] = {
        78178, -- Gauntlets of the Corrupted Protector
    },
    -- Colossal Dragonplate Legplates
    ["76986"] = {
        78176, -- Leggings of the Corrupted Protector
    },
    -- Colossal Dragonplate Pauldrons
    ["76987"] = {
        78175, -- Shoulders of the Corrupted Protector
    },
    -- Colossal Dragonplate Chestguard
    ["76988"] = {
        78179, -- Chest of the Corrupted Protector
    },
    -- Colossal Dragonplate Handguards
    ["76989"] = {
        78178, -- Gauntlets of the Corrupted Protector
    },
    -- Colossal Dragonplate Faceguard
    ["76990"] = {
        78177, -- Crown of the Corrupted Protector
    },
    -- Colossal Dragonplate Legguards
    ["76991"] = {
        78176, -- Leggings of the Corrupted Protector
    },
    -- Colossal Dragonplate Shoulderguards
    ["76992"] = {
        78175, -- Shoulders of the Corrupted Protector
    },
    -- Chestguard of Radiant Glory
    ["77003"] = {
        78184, -- Chest of the Corrupted Conqueror
    },
    -- Handguards of Radiant Glory
    ["77004"] = {
        78183, -- Gauntlets of the Corrupted Conqueror
    },
    -- Faceguard of Radiant Glory
    ["77005"] = {
        78182, -- Crown of the Corrupted Conqueror
    },
    -- Legguards of Radiant Glory
    ["77006"] = {
        78181, -- Leggings of the Corrupted Conqueror
    },
    -- Shoulderguards of Radiant Glory
    ["77007"] = {
        78180, -- Shoulders of the Corrupted Conqueror
    },
    -- Necrotic Boneplate Chestguard
    ["77008"] = {
        78174, -- Chest of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Handguards
    ["77009"] = {
        78173, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Faceguard
    ["77010"] = {
        78172, -- Crown of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Legguards
    ["77011"] = {
        78171, -- Leggings of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Shoulderguards
    ["77012"] = {
        78170, -- Shoulders of the Corrupted Vanquisher
    },
    -- Deep Earth Raiment
    ["77013"] = {
        78174, -- Chest of the Corrupted Vanquisher
    },
    -- Deep Earth Grips
    ["77014"] = {
        78173, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Deep Earth Headpiece
    ["77015"] = {
        78172, -- Crown of the Corrupted Vanquisher
    },
    -- Deep Earth Legguards
    ["77016"] = {
        78171, -- Leggings of the Corrupted Vanquisher
    },
    -- Deep Earth Spaulders
    ["77017"] = {
        78170, -- Shoulders of the Corrupted Vanquisher
    },
    -- Deep Earth Gloves
    ["77018"] = {
        78173, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Deep Earth Cover
    ["77019"] = {
        78172, -- Crown of the Corrupted Vanquisher
    },
    -- Deep Earth Leggings
    ["77020"] = {
        78171, -- Leggings of the Corrupted Vanquisher
    },
    -- Deep Earth Vestment
    ["77021"] = {
        78174, -- Chest of the Corrupted Vanquisher
    },
    -- Deep Earth Shoulderwraps
    ["77022"] = {
        78170, -- Shoulders of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Tunic
    ["77023"] = {
        78174, -- Chest of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Gloves
    ["77024"] = {
        78173, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Helmet
    ["77025"] = {
        78172, -- Crown of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Legguards
    ["77026"] = {
        78171, -- Leggings of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Spaulders
    ["77027"] = {
        78170, -- Shoulders of the Corrupted Vanquisher
    },
    -- Wyrmstalker's Tunic
    ["77028"] = {
        78179, -- Chest of the Corrupted Protector
    },
    -- Wyrmstalker's Gloves
    ["77029"] = {
        78178, -- Gauntlets of the Corrupted Protector
    },
    -- Wyrmstalker's Headguard
    ["77030"] = {
        78177, -- Crown of the Corrupted Protector
    },
    -- Wyrmstalker's Legguards
    ["77031"] = {
        78176, -- Leggings of the Corrupted Protector
    },
    -- Wyrmstalker's Spaulders
    ["77032"] = {
        78175, -- Shoulders of the Corrupted Protector
    },
    -- Spiritwalker's Shoulderwraps
    ["77035"] = {
        78175, -- Shoulders of the Corrupted Protector
    },
    -- Spiritwalker's Kilt
    ["77036"] = {
        78176, -- Leggings of the Corrupted Protector
    },
    -- Spiritwalker's Headpiece
    ["77037"] = {
        78177, -- Crown of the Corrupted Protector
    },
    -- Spiritwalker's Gloves
    ["77038"] = {
        78178, -- Gauntlets of the Corrupted Protector
    },
    -- Spiritwalker's Hauberk
    ["77039"] = {
        78179, -- Chest of the Corrupted Protector
    },
    -- Spiritwalker's Cuirass
    ["77040"] = {
        78179, -- Chest of the Corrupted Protector
    },
    -- Spiritwalker's Grips
    ["77041"] = {
        78178, -- Gauntlets of the Corrupted Protector
    },
    -- Spiritwalker's Helmet
    ["77042"] = {
        78177, -- Crown of the Corrupted Protector
    },
    -- Spiritwalker's Legguards
    ["77043"] = {
        78176, -- Leggings of the Corrupted Protector
    },
    -- Spiritwalker's Spaulders
    ["77044"] = {
        78175, -- Shoulders of the Corrupted Protector
    },
    -- Golad, Twilight of Aspects
    ["77949"] = {
        77952, -- Elementium Gem Cluster
    },
    -- Tiriosh, Nightmare of Ages
    ["77950"] = {
        77952, -- Elementium Gem Cluster
    },
    -- Elementium Gem Cluster
    ["77952"] = {
        77949, -- Golad, Twilight of Aspects
        77950, -- Tiriosh, Nightmare of Ages
    },
    -- Shoulders of the Corrupted Vanquisher
    ["78170"] = {
        76216, -- Time Lord's Mantle
        76753, -- Deep Earth Mantle
        76978, -- Necrotic Boneplate Pauldrons
        77012, -- Necrotic Boneplate Shoulderguards
        77017, -- Deep Earth Spaulders
        77022, -- Deep Earth Shoulderwraps
        77027, -- Blackfang Battleweave Spaulders
    },
    -- Leggings of the Corrupted Vanquisher
    ["78171"] = {
        76214, -- Time Lord's Leggings
        76751, -- Deep Earth Legwraps
        76977, -- Necrotic Boneplate Greaves
        77011, -- Necrotic Boneplate Legguards
        77016, -- Deep Earth Legguards
        77020, -- Deep Earth Leggings
        77026, -- Blackfang Battleweave Legguards
    },
    -- Crown of the Corrupted Vanquisher
    ["78172"] = {
        76213, -- Time Lord's Hood
        76750, -- Deep Earth Helm
        76976, -- Necrotic Boneplate Helmet
        77010, -- Necrotic Boneplate Faceguard
        77015, -- Deep Earth Headpiece
        77019, -- Deep Earth Cover
        77025, -- Blackfang Battleweave Helmet
    },
    -- Gauntlets of the Corrupted Vanquisher
    ["78173"] = {
        76212, -- Time Lord's Gloves
        76749, -- Deep Earth Handwraps
        76975, -- Necrotic Boneplate Gauntlets
        77009, -- Necrotic Boneplate Handguards
        77014, -- Deep Earth Grips
        77018, -- Deep Earth Gloves
        77024, -- Blackfang Battleweave Gloves
    },
    -- Chest of the Corrupted Vanquisher
    ["78174"] = {
        76215, -- Time Lord's Robes
        76752, -- Deep Earth Robes
        76974, -- Necrotic Boneplate Breastplate
        77008, -- Necrotic Boneplate Chestguard
        77013, -- Deep Earth Raiment
        77021, -- Deep Earth Vestment
        77023, -- Blackfang Battleweave Tunic
    },
    -- Shoulders of the Corrupted Protector
    ["78175"] = {
        76760, -- Spiritwalker's Mantle
        76987, -- Colossal Dragonplate Pauldrons
        76992, -- Colossal Dragonplate Shoulderguards
        77032, -- Wyrmstalker's Spaulders
        77035, -- Spiritwalker's Shoulderwraps
        77044, -- Spiritwalker's Spaulders
    },
    -- Leggings of the Corrupted Protector
    ["78176"] = {
        76759, -- Spiritwalker's Legwraps
        76986, -- Colossal Dragonplate Legplates
        76991, -- Colossal Dragonplate Legguards
        77031, -- Wyrmstalker's Legguards
        77036, -- Spiritwalker's Kilt
        77043, -- Spiritwalker's Legguards
    },
    -- Crown of the Corrupted Protector
    ["78177"] = {
        76758, -- Spiritwalker's Faceguard
        76983, -- Colossal Dragonplate Helmet
        76990, -- Colossal Dragonplate Faceguard
        77030, -- Wyrmstalker's Headguard
        77037, -- Spiritwalker's Headpiece
        77042, -- Spiritwalker's Helmet
    },
    -- Gauntlets of the Corrupted Protector
    ["78178"] = {
        76757, -- Spiritwalker's Handwraps
        76985, -- Colossal Dragonplate Gauntlets
        76989, -- Colossal Dragonplate Handguards
        77029, -- Wyrmstalker's Gloves
        77038, -- Spiritwalker's Gloves
        77041, -- Spiritwalker's Grips
    },
    -- Chest of the Corrupted Protector
    ["78179"] = {
        76756, -- Spiritwalker's Tunic
        76984, -- Colossal Dragonplate Battleplate
        76988, -- Colossal Dragonplate Chestguard
        77028, -- Wyrmstalker's Tunic
        77039, -- Spiritwalker's Hauberk
        77040, -- Spiritwalker's Cuirass
    },
    -- Shoulders of the Corrupted Conqueror
    ["78180"] = {
        76339, -- Mantle of the Faceless Shroud
        76344, -- Mantle of Dying Light
        76361, -- Mantle of Dying Light
        76769, -- Mantle of Radiant Glory
        76878, -- Pauldrons of Radiant Glory
        77007, -- Shoulderguards of Radiant Glory
    },
    -- Leggings of the Corrupted Conqueror
    ["78181"] = {
        76341, -- Leggings of the Faceless Shroud
        76346, -- Leggings of Dying Light
        76359, -- Legwraps of Dying Light
        76768, -- Greaves of Radiant Glory
        76877, -- Legplates of Radiant Glory
        77006, -- Legguards of Radiant Glory
    },
    -- Crown of the Corrupted Conqueror
    ["78182"] = {
        76342, -- Hood of the Faceless Shroud
        76347, -- Hood of Dying Light
        76358, -- Cowl of Dying Light
        76767, -- Headguard of Radiant Glory
        76876, -- Helmet of Radiant Glory
        77005, -- Faceguard of Radiant Glory
    },
    -- Gauntlets of the Corrupted Conqueror
    ["78183"] = {
        76343, -- Gloves of the Faceless Shroud
        76348, -- Gloves of Dying Light
        76357, -- Handwraps of Dying Light
        76766, -- Gloves of Radiant Glory
        76875, -- Gauntlets of Radiant Glory
        77004, -- Handguards of Radiant Glory
    },
    -- Chest of the Corrupted Conqueror
    ["78184"] = {
        76340, -- Robes of the Faceless Shroud
        76345, -- Robes of Dying Light
        76360, -- Robes of Dying Light
        76765, -- Breastplate of Radiant Glory
        76874, -- Battleplate of Radiant Glory
        77003, -- Chestguard of Radiant Glory
    },
    -- Colossal Dragonplate Battleplate
    ["78657"] = {
        78848, -- Chest of the Corrupted Protector
    },
    -- Colossal Dragonplate Chestguard
    ["78658"] = {
        78848, -- Chest of the Corrupted Protector
    },
    -- Necrotic Boneplate Breastplate
    ["78659"] = {
        78849, -- Chest of the Corrupted Vanquisher
    },
    -- Deep Earth Robes
    ["78660"] = {
        78849, -- Chest of the Corrupted Vanquisher
    },
    -- Wyrmstalker's Tunic
    ["78661"] = {
        78848, -- Chest of the Corrupted Protector
    },
    -- Deep Earth Vestment
    ["78662"] = {
        78849, -- Chest of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Chestguard
    ["78663"] = {
        78849, -- Chest of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Tunic
    ["78664"] = {
        78849, -- Chest of the Corrupted Vanquisher
    },
    -- Deep Earth Raiment
    ["78665"] = {
        78849, -- Chest of the Corrupted Vanquisher
    },
    -- Spiritwalker's Gloves
    ["78666"] = {
        78854, -- Gauntlets of the Corrupted Protector
    },
    -- Spiritwalker's Grips
    ["78667"] = {
        78854, -- Gauntlets of the Corrupted Protector
    },
    -- Colossal Dragonplate Gauntlets
    ["78668"] = {
        78854, -- Gauntlets of the Corrupted Protector
    },
    -- Colossal Dragonplate Handguards
    ["78669"] = {
        78854, -- Gauntlets of the Corrupted Protector
    },
    -- Necrotic Boneplate Gauntlets
    ["78670"] = {
        78855, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Time Lord's Gloves
    ["78671"] = {
        78855, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Spiritwalker's Handwraps
    ["78672"] = {
        78854, -- Gauntlets of the Corrupted Protector
    },
    -- Gloves of Radiant Glory
    ["78673"] = {
        78853, -- Gauntlets of the Corrupted Conqueror
    },
    -- Wyrmstalker's Gloves
    ["78674"] = {
        78854, -- Gauntlets of the Corrupted Protector
    },
    -- Gauntlets of Radiant Glory
    ["78675"] = {
        78853, -- Gauntlets of the Corrupted Conqueror
    },
    -- Deep Earth Gloves
    ["78676"] = {
        78855, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Handguards of Radiant Glory
    ["78677"] = {
        78853, -- Gauntlets of the Corrupted Conqueror
    },
    -- Necrotic Boneplate Handguards
    ["78678"] = {
        78855, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Gloves
    ["78679"] = {
        78855, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Deep Earth Handwraps
    ["78680"] = {
        78855, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Gloves of the Faceless Shroud
    ["78681"] = {
        78853, -- Gauntlets of the Corrupted Conqueror
    },
    -- Gloves of Dying Light
    ["78682"] = {
        78853, -- Gauntlets of the Corrupted Conqueror
    },
    -- Handwraps of Dying Light
    ["78683"] = {
        78853, -- Gauntlets of the Corrupted Conqueror
    },
    -- Deep Earth Grips
    ["78684"] = {
        78855, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Spiritwalker's Headpiece
    ["78685"] = {
        78851, -- Crown of the Corrupted Protector
    },
    -- Spiritwalker's Helmet
    ["78686"] = {
        78851, -- Crown of the Corrupted Protector
    },
    -- Necrotic Boneplate Helmet
    ["78687"] = {
        78852, -- Crown of the Corrupted Vanquisher
    },
    -- Colossal Dragonplate Helmet
    ["78688"] = {
        78851, -- Crown of the Corrupted Protector
    },
    -- Colossal Dragonplate Faceguard
    ["78689"] = {
        78851, -- Crown of the Corrupted Protector
    },
    -- Deep Earth Helm
    ["78690"] = {
        78852, -- Crown of the Corrupted Vanquisher
    },
    -- Spiritwalker's Faceguard
    ["78691"] = {
        78851, -- Crown of the Corrupted Protector
    },
    -- Headguard of Radiant Glory
    ["78692"] = {
        78850, -- Crown of the Corrupted Conqueror
    },
    -- Helmet of Radiant Glory
    ["78693"] = {
        78850, -- Crown of the Corrupted Conqueror
    },
    -- Deep Earth Headpiece
    ["78694"] = {
        78852, -- Crown of the Corrupted Vanquisher
    },
    -- Faceguard of Radiant Glory
    ["78695"] = {
        78850, -- Crown of the Corrupted Conqueror
    },
    -- Deep Earth Cover
    ["78696"] = {
        78852, -- Crown of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Faceguard
    ["78697"] = {
        78852, -- Crown of the Corrupted Vanquisher
    },
    -- Wyrmstalker's Headguard
    ["78698"] = {
        78851, -- Crown of the Corrupted Protector
    },
    -- Blackfang Battleweave Helmet
    ["78699"] = {
        78852, -- Crown of the Corrupted Vanquisher
    },
    -- Cowl of Dying Light
    ["78700"] = {
        78850, -- Crown of the Corrupted Conqueror
    },
    -- Time Lord's Hood
    ["78701"] = {
        78852, -- Crown of the Corrupted Vanquisher
    },
    -- Hood of the Faceless Shroud
    ["78702"] = {
        78850, -- Crown of the Corrupted Conqueror
    },
    -- Hood of Dying Light
    ["78703"] = {
        78850, -- Crown of the Corrupted Conqueror
    },
    -- Spiritwalker's Legguards
    ["78704"] = {
        78857, -- Leggings of the Corrupted Protector
    },
    -- Colossal Dragonplate Legguards
    ["78705"] = {
        78857, -- Leggings of the Corrupted Protector
    },
    -- Colossal Dragonplate Legplates
    ["78706"] = {
        78857, -- Leggings of the Corrupted Protector
    },
    -- Necrotic Boneplate Greaves
    ["78707"] = {
        78858, -- Leggings of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Legguards
    ["78708"] = {
        78858, -- Leggings of the Corrupted Vanquisher
    },
    -- Wyrmstalker's Legguards
    ["78709"] = {
        78857, -- Leggings of the Corrupted Protector
    },
    -- Deep Earth Legwraps
    ["78710"] = {
        78858, -- Leggings of the Corrupted Vanquisher
    },
    -- Spiritwalker's Kilt
    ["78711"] = {
        78857, -- Leggings of the Corrupted Protector
    },
    -- Legplates of Radiant Glory
    ["78712"] = {
        78856, -- Leggings of the Corrupted Conqueror
    },
    -- Deep Earth Legguards
    ["78713"] = {
        78858, -- Leggings of the Corrupted Vanquisher
    },
    -- Deep Earth Leggings
    ["78714"] = {
        78858, -- Leggings of the Corrupted Vanquisher
    },
    -- Legguards of Radiant Glory
    ["78715"] = {
        78856, -- Leggings of the Corrupted Conqueror
    },
    -- Necrotic Boneplate Legguards
    ["78716"] = {
        78858, -- Leggings of the Corrupted Vanquisher
    },
    -- Greaves of Radiant Glory
    ["78717"] = {
        78856, -- Leggings of the Corrupted Conqueror
    },
    -- Spiritwalker's Legwraps
    ["78718"] = {
        78857, -- Leggings of the Corrupted Protector
    },
    -- Legwraps of Dying Light
    ["78719"] = {
        78856, -- Leggings of the Corrupted Conqueror
    },
    -- Time Lord's Leggings
    ["78720"] = {
        78858, -- Leggings of the Corrupted Vanquisher
    },
    -- Leggings of the Faceless Shroud
    ["78721"] = {
        78856, -- Leggings of the Corrupted Conqueror
    },
    -- Leggings of Dying Light
    ["78722"] = {
        78856, -- Leggings of the Corrupted Conqueror
    },
    -- Spiritwalker's Hauberk
    ["78723"] = {
        78848, -- Chest of the Corrupted Protector
    },
    -- Spiritwalker's Cuirass
    ["78724"] = {
        78848, -- Chest of the Corrupted Protector
    },
    -- Spiritwalker's Tunic
    ["78725"] = {
        78848, -- Chest of the Corrupted Protector
    },
    -- Breastplate of Radiant Glory
    ["78726"] = {
        78847, -- Chest of the Corrupted Conqueror
    },
    -- Battleplate of Radiant Glory
    ["78727"] = {
        78847, -- Chest of the Corrupted Conqueror
    },
    -- Robes of Dying Light
    ["78728"] = {
        78847, -- Chest of the Corrupted Conqueror
    },
    -- Time Lord's Robes
    ["78729"] = {
        78849, -- Chest of the Corrupted Vanquisher
    },
    -- Robes of the Faceless Shroud
    ["78730"] = {
        78847, -- Chest of the Corrupted Conqueror
    },
    -- Robes of Dying Light
    ["78731"] = {
        78847, -- Chest of the Corrupted Conqueror
    },
    -- Chestguard of Radiant Glory
    ["78732"] = {
        78847, -- Chest of the Corrupted Conqueror
    },
    -- Spiritwalker's Spaulders
    ["78733"] = {
        78860, -- Shoulders of the Corrupted Protector
    },
    -- Colossal Dragonplate Shoulderguards
    ["78734"] = {
        78860, -- Shoulders of the Corrupted Protector
    },
    -- Colossal Dragonplate Pauldrons
    ["78735"] = {
        78860, -- Shoulders of the Corrupted Protector
    },
    -- Necrotic Boneplate Pauldrons
    ["78736"] = {
        78861, -- Shoulders of the Corrupted Vanquisher
    },
    -- Wyrmstalker's Spaulders
    ["78737"] = {
        78860, -- Shoulders of the Corrupted Protector
    },
    -- Blackfang Battleweave Spaulders
    ["78738"] = {
        78861, -- Shoulders of the Corrupted Vanquisher
    },
    -- Spiritwalker's Mantle
    ["78739"] = {
        78860, -- Shoulders of the Corrupted Protector
    },
    -- Deep Earth Mantle
    ["78740"] = {
        78861, -- Shoulders of the Corrupted Vanquisher
    },
    -- Spiritwalker's Shoulderwraps
    ["78741"] = {
        78860, -- Shoulders of the Corrupted Protector
    },
    -- Pauldrons of Radiant Glory
    ["78742"] = {
        78859, -- Shoulders of the Corrupted Conqueror
    },
    -- Deep Earth Spaulders
    ["78743"] = {
        78861, -- Shoulders of the Corrupted Vanquisher
    },
    -- Deep Earth Shoulderwraps
    ["78744"] = {
        78861, -- Shoulders of the Corrupted Vanquisher
    },
    -- Shoulderguards of Radiant Glory
    ["78745"] = {
        78859, -- Shoulders of the Corrupted Conqueror
    },
    -- Mantle of Radiant Glory
    ["78746"] = {
        78859, -- Shoulders of the Corrupted Conqueror
    },
    -- Mantle of Dying Light
    ["78747"] = {
        78859, -- Shoulders of the Corrupted Conqueror
    },
    -- Time Lord's Mantle
    ["78748"] = {
        78861, -- Shoulders of the Corrupted Vanquisher
    },
    -- Mantle of the Faceless Shroud
    ["78749"] = {
        78859, -- Shoulders of the Corrupted Conqueror
    },
    -- Mantle of Dying Light
    ["78750"] = {
        78859, -- Shoulders of the Corrupted Conqueror
    },
    -- Necrotic Boneplate Shoulderguards
    ["78751"] = {
        78861, -- Shoulders of the Corrupted Vanquisher
    },
    -- Colossal Dragonplate Battleplate
    ["78752"] = {
        78864, -- Chest of the Corrupted Protector
    },
    -- Colossal Dragonplate Chestguard
    ["78753"] = {
        78864, -- Chest of the Corrupted Protector
    },
    -- Necrotic Boneplate Breastplate
    ["78754"] = {
        78862, -- Chest of the Corrupted Vanquisher
    },
    -- Deep Earth Robes
    ["78755"] = {
        78862, -- Chest of the Corrupted Vanquisher
    },
    -- Wyrmstalker's Tunic
    ["78756"] = {
        78864, -- Chest of the Corrupted Protector
    },
    -- Deep Earth Vestment
    ["78757"] = {
        78862, -- Chest of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Chestguard
    ["78758"] = {
        78862, -- Chest of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Tunic
    ["78759"] = {
        78862, -- Chest of the Corrupted Vanquisher
    },
    -- Deep Earth Raiment
    ["78760"] = {
        78862, -- Chest of the Corrupted Vanquisher
    },
    -- Spiritwalker's Gloves
    ["78761"] = {
        78867, -- Gauntlets of the Corrupted Protector
    },
    -- Spiritwalker's Grips
    ["78762"] = {
        78867, -- Gauntlets of the Corrupted Protector
    },
    -- Colossal Dragonplate Gauntlets
    ["78763"] = {
        78867, -- Gauntlets of the Corrupted Protector
    },
    -- Colossal Dragonplate Handguards
    ["78764"] = {
        78867, -- Gauntlets of the Corrupted Protector
    },
    -- Necrotic Boneplate Gauntlets
    ["78765"] = {
        78865, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Time Lord's Gloves
    ["78766"] = {
        78865, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Spiritwalker's Handwraps
    ["78767"] = {
        78867, -- Gauntlets of the Corrupted Protector
    },
    -- Gloves of Radiant Glory
    ["78768"] = {
        78866, -- Gauntlets of the Corrupted Conqueror
    },
    -- Wyrmstalker's Gloves
    ["78769"] = {
        78867, -- Gauntlets of the Corrupted Protector
    },
    -- Gauntlets of Radiant Glory
    ["78770"] = {
        78866, -- Gauntlets of the Corrupted Conqueror
    },
    -- Deep Earth Gloves
    ["78771"] = {
        78865, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Handguards of Radiant Glory
    ["78772"] = {
        78866, -- Gauntlets of the Corrupted Conqueror
    },
    -- Necrotic Boneplate Handguards
    ["78773"] = {
        78865, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Gloves
    ["78774"] = {
        78865, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Deep Earth Handwraps
    ["78775"] = {
        78865, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Gloves of the Faceless Shroud
    ["78776"] = {
        78866, -- Gauntlets of the Corrupted Conqueror
    },
    -- Gloves of Dying Light
    ["78777"] = {
        78866, -- Gauntlets of the Corrupted Conqueror
    },
    -- Handwraps of Dying Light
    ["78778"] = {
        78866, -- Gauntlets of the Corrupted Conqueror
    },
    -- Deep Earth Grips
    ["78779"] = {
        78865, -- Gauntlets of the Corrupted Vanquisher
    },
    -- Spiritwalker's Headpiece
    ["78780"] = {
        78870, -- Crown of the Corrupted Protector
    },
    -- Spiritwalker's Helmet
    ["78781"] = {
        78870, -- Crown of the Corrupted Protector
    },
    -- Necrotic Boneplate Helmet
    ["78782"] = {
        78868, -- Crown of the Corrupted Vanquisher
    },
    -- Colossal Dragonplate Helmet
    ["78783"] = {
        78870, -- Crown of the Corrupted Protector
    },
    -- Colossal Dragonplate Faceguard
    ["78784"] = {
        78870, -- Crown of the Corrupted Protector
    },
    -- Deep Earth Helm
    ["78785"] = {
        78868, -- Crown of the Corrupted Vanquisher
    },
    -- Spiritwalker's Faceguard
    ["78786"] = {
        78870, -- Crown of the Corrupted Protector
    },
    -- Headguard of Radiant Glory
    ["78787"] = {
        78869, -- Crown of the Corrupted Conqueror
    },
    -- Helmet of Radiant Glory
    ["78788"] = {
        78869, -- Crown of the Corrupted Conqueror
    },
    -- Deep Earth Headpiece
    ["78789"] = {
        78868, -- Crown of the Corrupted Vanquisher
    },
    -- Faceguard of Radiant Glory
    ["78790"] = {
        78869, -- Crown of the Corrupted Conqueror
    },
    -- Deep Earth Cover
    ["78791"] = {
        78868, -- Crown of the Corrupted Vanquisher
    },
    -- Necrotic Boneplate Faceguard
    ["78792"] = {
        78868, -- Crown of the Corrupted Vanquisher
    },
    -- Wyrmstalker's Headguard
    ["78793"] = {
        78870, -- Crown of the Corrupted Protector
    },
    -- Blackfang Battleweave Helmet
    ["78794"] = {
        78868, -- Crown of the Corrupted Vanquisher
    },
    -- Cowl of Dying Light
    ["78795"] = {
        78869, -- Crown of the Corrupted Conqueror
    },
    -- Time Lord's Hood
    ["78796"] = {
        78868, -- Crown of the Corrupted Vanquisher
    },
    -- Hood of the Faceless Shroud
    ["78797"] = {
        78869, -- Crown of the Corrupted Conqueror
    },
    -- Hood of Dying Light
    ["78798"] = {
        78869, -- Crown of the Corrupted Conqueror
    },
    -- Spiritwalker's Legguards
    ["78799"] = {
        78873, -- Leggings of the Corrupted Protector
    },
    -- Colossal Dragonplate Legguards
    ["78800"] = {
        78873, -- Leggings of the Corrupted Protector
    },
    -- Colossal Dragonplate Legplates
    ["78801"] = {
        78873, -- Leggings of the Corrupted Protector
    },
    -- Necrotic Boneplate Greaves
    ["78802"] = {
        78871, -- Leggings of the Corrupted Vanquisher
    },
    -- Blackfang Battleweave Legguards
    ["78803"] = {
        78871, -- Leggings of the Corrupted Vanquisher
    },
    -- Wyrmstalker's Legguards
    ["78804"] = {
        78873, -- Leggings of the Corrupted Protector
    },
    -- Deep Earth Legwraps
    ["78805"] = {
        78871, -- Leggings of the Corrupted Vanquisher
    },
    -- Spiritwalker's Kilt
    ["78806"] = {
        78873, -- Leggings of the Corrupted Protector
    },
    -- Legplates of Radiant Glory
    ["78807"] = {
        78872, -- Leggings of the Corrupted Conqueror
    },
    -- Deep Earth Legguards
    ["78808"] = {
        78871, -- Leggings of the Corrupted Vanquisher
    },
    -- Deep Earth Leggings
    ["78809"] = {
        78871, -- Leggings of the Corrupted Vanquisher
    },
    -- Legguards of Radiant Glory
    ["78810"] = {
        78872, -- Leggings of the Corrupted Conqueror
    },
    -- Necrotic Boneplate Legguards
    ["78811"] = {
        78871, -- Leggings of the Corrupted Vanquisher
    },
    -- Greaves of Radiant Glory
    ["78812"] = {
        78872, -- Leggings of the Corrupted Conqueror
    },
    -- Spiritwalker's Legwraps
    ["78813"] = {
        78873, -- Leggings of the Corrupted Protector
    },
    -- Legwraps of Dying Light
    ["78814"] = {
        78872, -- Leggings of the Corrupted Conqueror
    },
    -- Time Lord's Leggings
    ["78815"] = {
        78871, -- Leggings of the Corrupted Vanquisher
    },
    -- Leggings of the Faceless Shroud
    ["78816"] = {
        78872, -- Leggings of the Corrupted Conqueror
    },
    -- Leggings of Dying Light
    ["78817"] = {
        78872, -- Leggings of the Corrupted Conqueror
    },
    -- Spiritwalker's Hauberk
    ["78818"] = {
        78864, -- Chest of the Corrupted Protector
    },
    -- Spiritwalker's Cuirass
    ["78819"] = {
        78864, -- Chest of the Corrupted Protector
    },
    -- Spiritwalker's Tunic
    ["78820"] = {
        78864, -- Chest of the Corrupted Protector
    },
    -- Breastplate of Radiant Glory
    ["78821"] = {
        78863, -- Chest of the Corrupted Conqueror
    },
    -- Battleplate of Radiant Glory
    ["78822"] = {
        78863, -- Chest of the Corrupted Conqueror
    },
    -- Robes of Dying Light
    ["78823"] = {
        78863, -- Chest of the Corrupted Conqueror
    },
    -- Time Lord's Robes
    ["78824"] = {
        78862, -- Chest of the Corrupted Vanquisher
    },
    -- Robes of the Faceless Shroud
    ["78825"] = {
        78863, -- Chest of the Corrupted Conqueror
    },
    -- Robes of Dying Light
    ["78826"] = {
        78863, -- Chest of the Corrupted Conqueror
    },
    -- Chestguard of Radiant Glory
    ["78827"] = {
        78863, -- Chest of the Corrupted Conqueror
    },
    -- Spiritwalker's Spaulders
    ["78828"] = {
        78876, -- Shoulders of the Corrupted Protector
    },
    -- Colossal Dragonplate Shoulderguards
    ["78829"] = {
        78876, -- Shoulders of the Corrupted Protector
    },
    -- Colossal Dragonplate Pauldrons
    ["78830"] = {
        78876, -- Shoulders of the Corrupted Protector
    },
    -- Necrotic Boneplate Pauldrons
    ["78831"] = {
        78874, -- Shoulders of the Corrupted Vanquisher
    },
    -- Wyrmstalker's Spaulders
    ["78832"] = {
        78876, -- Shoulders of the Corrupted Protector
    },
    -- Blackfang Battleweave Spaulders
    ["78833"] = {
        78874, -- Shoulders of the Corrupted Vanquisher
    },
    -- Spiritwalker's Mantle
    ["78834"] = {
        78876, -- Shoulders of the Corrupted Protector
    },
    -- Deep Earth Mantle
    ["78835"] = {
        78874, -- Shoulders of the Corrupted Vanquisher
    },
    -- Spiritwalker's Shoulderwraps
    ["78836"] = {
        78876, -- Shoulders of the Corrupted Protector
    },
    -- Pauldrons of Radiant Glory
    ["78837"] = {
        78875, -- Shoulders of the Corrupted Conqueror
    },
    -- Deep Earth Spaulders
    ["78838"] = {
        78874, -- Shoulders of the Corrupted Vanquisher
    },
    -- Deep Earth Shoulderwraps
    ["78839"] = {
        78874, -- Shoulders of the Corrupted Vanquisher
    },
    -- Shoulderguards of Radiant Glory
    ["78840"] = {
        78875, -- Shoulders of the Corrupted Conqueror
    },
    -- Mantle of Radiant Glory
    ["78841"] = {
        78875, -- Shoulders of the Corrupted Conqueror
    },
    -- Mantle of Dying Light
    ["78842"] = {
        78875, -- Shoulders of the Corrupted Conqueror
    },
    -- Time Lord's Mantle
    ["78843"] = {
        78874, -- Shoulders of the Corrupted Vanquisher
    },
    -- Mantle of the Faceless Shroud
    ["78844"] = {
        78875, -- Shoulders of the Corrupted Conqueror
    },
    -- Mantle of Dying Light
    ["78845"] = {
        78875, -- Shoulders of the Corrupted Conqueror
    },
    -- Necrotic Boneplate Shoulderguards
    ["78846"] = {
        78874, -- Shoulders of the Corrupted Vanquisher
    },
    -- Chest of the Corrupted Conqueror
    ["78847"] = {
        78726, -- Breastplate of Radiant Glory
        78727, -- Battleplate of Radiant Glory
        78728, -- Robes of Dying Light
        78730, -- Robes of the Faceless Shroud
        78731, -- Robes of Dying Light
        78732, -- Chestguard of Radiant Glory
    },
    -- Chest of the Corrupted Protector
    ["78848"] = {
        78657, -- Colossal Dragonplate Battleplate
        78658, -- Colossal Dragonplate Chestguard
        78661, -- Wyrmstalker's Tunic
        78723, -- Spiritwalker's Hauberk
        78724, -- Spiritwalker's Cuirass
        78725, -- Spiritwalker's Tunic
    },
    -- Chest of the Corrupted Vanquisher
    ["78849"] = {
        78659, -- Necrotic Boneplate Breastplate
        78660, -- Deep Earth Robes
        78662, -- Deep Earth Vestment
        78663, -- Necrotic Boneplate Chestguard
        78664, -- Blackfang Battleweave Tunic
        78665, -- Deep Earth Raiment
        78729, -- Time Lord's Robes
    },
    -- Crown of the Corrupted Conqueror
    ["78850"] = {
        78692, -- Headguard of Radiant Glory
        78693, -- Helmet of Radiant Glory
        78695, -- Faceguard of Radiant Glory
        78700, -- Cowl of Dying Light
        78702, -- Hood of the Faceless Shroud
        78703, -- Hood of Dying Light
    },
    -- Crown of the Corrupted Protector
    ["78851"] = {
        78685, -- Spiritwalker's Headpiece
        78686, -- Spiritwalker's Helmet
        78688, -- Colossal Dragonplate Helmet
        78689, -- Colossal Dragonplate Faceguard
        78691, -- Spiritwalker's Faceguard
        78698, -- Wyrmstalker's Headguard
    },
    -- Crown of the Corrupted Vanquisher
    ["78852"] = {
        78687, -- Necrotic Boneplate Helmet
        78690, -- Deep Earth Helm
        78694, -- Deep Earth Headpiece
        78696, -- Deep Earth Cover
        78697, -- Necrotic Boneplate Faceguard
        78699, -- Blackfang Battleweave Helmet
        78701, -- Time Lord's Hood
    },
    -- Gauntlets of the Corrupted Conqueror
    ["78853"] = {
        78673, -- Gloves of Radiant Glory
        78675, -- Gauntlets of Radiant Glory
        78677, -- Handguards of Radiant Glory
        78681, -- Gloves of the Faceless Shroud
        78682, -- Gloves of Dying Light
        78683, -- Handwraps of Dying Light
    },
    -- Gauntlets of the Corrupted Protector
    ["78854"] = {
        78666, -- Spiritwalker's Gloves
        78667, -- Spiritwalker's Grips
        78668, -- Colossal Dragonplate Gauntlets
        78669, -- Colossal Dragonplate Handguards
        78672, -- Spiritwalker's Handwraps
        78674, -- Wyrmstalker's Gloves
    },
    -- Gauntlets of the Corrupted Vanquisher
    ["78855"] = {
        78670, -- Necrotic Boneplate Gauntlets
        78671, -- Time Lord's Gloves
        78676, -- Deep Earth Gloves
        78678, -- Necrotic Boneplate Handguards
        78679, -- Blackfang Battleweave Gloves
        78680, -- Deep Earth Handwraps
        78684, -- Deep Earth Grips
    },
    -- Leggings of the Corrupted Conqueror
    ["78856"] = {
        78712, -- Legplates of Radiant Glory
        78715, -- Legguards of Radiant Glory
        78717, -- Greaves of Radiant Glory
        78719, -- Legwraps of Dying Light
        78721, -- Leggings of the Faceless Shroud
        78722, -- Leggings of Dying Light
    },
    -- Leggings of the Corrupted Protector
    ["78857"] = {
        78704, -- Spiritwalker's Legguards
        78705, -- Colossal Dragonplate Legguards
        78706, -- Colossal Dragonplate Legplates
        78709, -- Wyrmstalker's Legguards
        78711, -- Spiritwalker's Kilt
        78718, -- Spiritwalker's Legwraps
    },
    -- Leggings of the Corrupted Vanquisher
    ["78858"] = {
        78707, -- Necrotic Boneplate Greaves
        78708, -- Blackfang Battleweave Legguards
        78710, -- Deep Earth Legwraps
        78713, -- Deep Earth Legguards
        78714, -- Deep Earth Leggings
        78716, -- Necrotic Boneplate Legguards
        78720, -- Time Lord's Leggings
    },
    -- Shoulders of the Corrupted Conqueror
    ["78859"] = {
        78742, -- Pauldrons of Radiant Glory
        78745, -- Shoulderguards of Radiant Glory
        78746, -- Mantle of Radiant Glory
        78747, -- Mantle of Dying Light
        78749, -- Mantle of the Faceless Shroud
        78750, -- Mantle of Dying Light
    },
    -- Shoulders of the Corrupted Protector
    ["78860"] = {
        78733, -- Spiritwalker's Spaulders
        78734, -- Colossal Dragonplate Shoulderguards
        78735, -- Colossal Dragonplate Pauldrons
        78737, -- Wyrmstalker's Spaulders
        78739, -- Spiritwalker's Mantle
        78741, -- Spiritwalker's Shoulderwraps
    },
    -- Shoulders of the Corrupted Vanquisher
    ["78861"] = {
        78736, -- Necrotic Boneplate Pauldrons
        78738, -- Blackfang Battleweave Spaulders
        78740, -- Deep Earth Mantle
        78743, -- Deep Earth Spaulders
        78744, -- Deep Earth Shoulderwraps
        78748, -- Time Lord's Mantle
        78751, -- Necrotic Boneplate Shoulderguards
    },
    -- Chest of the Corrupted Vanquisher
    ["78862"] = {
        78754, -- Necrotic Boneplate Breastplate
        78755, -- Deep Earth Robes
        78757, -- Deep Earth Vestment
        78758, -- Necrotic Boneplate Chestguard
        78759, -- Blackfang Battleweave Tunic
        78760, -- Deep Earth Raiment
        78824, -- Time Lord's Robes
    },
    -- Chest of the Corrupted Conqueror
    ["78863"] = {
        78821, -- Breastplate of Radiant Glory
        78822, -- Battleplate of Radiant Glory
        78823, -- Robes of Dying Light
        78825, -- Robes of the Faceless Shroud
        78826, -- Robes of Dying Light
        78827, -- Chestguard of Radiant Glory
    },
    -- Chest of the Corrupted Protector
    ["78864"] = {
        78752, -- Colossal Dragonplate Battleplate
        78753, -- Colossal Dragonplate Chestguard
        78756, -- Wyrmstalker's Tunic
        78818, -- Spiritwalker's Hauberk
        78819, -- Spiritwalker's Cuirass
        78820, -- Spiritwalker's Tunic
    },
    -- Gauntlets of the Corrupted Vanquisher
    ["78865"] = {
        78765, -- Necrotic Boneplate Gauntlets
        78766, -- Time Lord's Gloves
        78771, -- Deep Earth Gloves
        78773, -- Necrotic Boneplate Handguards
        78774, -- Blackfang Battleweave Gloves
        78775, -- Deep Earth Handwraps
        78779, -- Deep Earth Grips
    },
    -- Gauntlets of the Corrupted Conqueror
    ["78866"] = {
        78768, -- Gloves of Radiant Glory
        78770, -- Gauntlets of Radiant Glory
        78772, -- Handguards of Radiant Glory
        78776, -- Gloves of the Faceless Shroud
        78777, -- Gloves of Dying Light
        78778, -- Handwraps of Dying Light
    },
    -- Gauntlets of the Corrupted Protector
    ["78867"] = {
        78761, -- Spiritwalker's Gloves
        78762, -- Spiritwalker's Grips
        78763, -- Colossal Dragonplate Gauntlets
        78764, -- Colossal Dragonplate Handguards
        78767, -- Spiritwalker's Handwraps
        78769, -- Wyrmstalker's Gloves
    },
    -- Crown of the Corrupted Vanquisher
    ["78868"] = {
        78782, -- Necrotic Boneplate Helmet
        78785, -- Deep Earth Helm
        78789, -- Deep Earth Headpiece
        78791, -- Deep Earth Cover
        78792, -- Necrotic Boneplate Faceguard
        78794, -- Blackfang Battleweave Helmet
        78796, -- Time Lord's Hood
    },
    -- Crown of the Corrupted Conqueror
    ["78869"] = {
        78787, -- Headguard of Radiant Glory
        78788, -- Helmet of Radiant Glory
        78790, -- Faceguard of Radiant Glory
        78795, -- Cowl of Dying Light
        78797, -- Hood of the Faceless Shroud
        78798, -- Hood of Dying Light
    },
    -- Crown of the Corrupted Protector
    ["78870"] = {
        78780, -- Spiritwalker's Headpiece
        78781, -- Spiritwalker's Helmet
        78783, -- Colossal Dragonplate Helmet
        78784, -- Colossal Dragonplate Faceguard
        78786, -- Spiritwalker's Faceguard
        78793, -- Wyrmstalker's Headguard
    },
    -- Leggings of the Corrupted Vanquisher
    ["78871"] = {
        78802, -- Necrotic Boneplate Greaves
        78803, -- Blackfang Battleweave Legguards
        78805, -- Deep Earth Legwraps
        78808, -- Deep Earth Legguards
        78809, -- Deep Earth Leggings
        78811, -- Necrotic Boneplate Legguards
        78815, -- Time Lord's Leggings
    },
    -- Leggings of the Corrupted Conqueror
    ["78872"] = {
        78807, -- Legplates of Radiant Glory
        78810, -- Legguards of Radiant Glory
        78812, -- Greaves of Radiant Glory
        78814, -- Legwraps of Dying Light
        78816, -- Leggings of the Faceless Shroud
        78817, -- Leggings of Dying Light
    },
    -- Leggings of the Corrupted Protector
    ["78873"] = {
        78799, -- Spiritwalker's Legguards
        78800, -- Colossal Dragonplate Legguards
        78801, -- Colossal Dragonplate Legplates
        78804, -- Wyrmstalker's Legguards
        78806, -- Spiritwalker's Kilt
        78813, -- Spiritwalker's Legwraps
    },
    -- Shoulders of the Corrupted Vanquisher
    ["78874"] = {
        78831, -- Necrotic Boneplate Pauldrons
        78833, -- Blackfang Battleweave Spaulders
        78835, -- Deep Earth Mantle
        78838, -- Deep Earth Spaulders
        78839, -- Deep Earth Shoulderwraps
        78843, -- Time Lord's Mantle
        78846, -- Necrotic Boneplate Shoulderguards
    },
    -- Shoulders of the Corrupted Conqueror
    ["78875"] = {
        78837, -- Pauldrons of Radiant Glory
        78840, -- Shoulderguards of Radiant Glory
        78841, -- Mantle of Radiant Glory
        78842, -- Mantle of Dying Light
        78844, -- Mantle of the Faceless Shroud
        78845, -- Mantle of Dying Light
    },
    -- Shoulders of the Corrupted Protector
    ["78876"] = {
        78828, -- Spiritwalker's Spaulders
        78829, -- Colossal Dragonplate Shoulderguards
        78830, -- Colossal Dragonplate Pauldrons
        78832, -- Wyrmstalker's Spaulders
        78834, -- Spiritwalker's Mantle
        78836, -- Spiritwalker's Shoulderwraps
    },
    -- Avenger's Void Pearl
    ["211449"] = {
        211452, -- Perfect Blackfathom Pearl
    },
    -- Invoker's Void Pearl
    ["211450"] = {
        211452, -- Perfect Blackfathom Pearl
    },
    -- Acolyte's Void Pearl
    ["211451"] = {
        211452, -- Perfect Blackfathom Pearl
    },
    -- Perfect Blackfathom Pearl
    ["211452"] = {
        211449, -- Avenger's Void Pearl
        211450, -- Invoker's Void Pearl
        211451, -- Acolyte's Void Pearl
    },
    -- Hyperconductive Shimmershirt
    ["213310"] = {
        217008, -- Power Depleted Chest
    },
    -- Hyperconductive Robe
    ["213311"] = {
        217008, -- Power Depleted Chest
    },
    -- Insulated Apron
    ["213312"] = {
        217008, -- Power Depleted Chest
    },
    -- Insulated Chestguard
    ["213313"] = {
        217008, -- Power Depleted Chest
    },
    -- Electromantic Chainmail
    ["213314"] = {
        217008, -- Power Depleted Chest
    },
    -- Electromantic Chainshirt
    ["213315"] = {
        217008, -- Power Depleted Chest
    },
    -- H.A.Z.A.R.D. Breastplate
    ["213316"] = {
        217008, -- Power Depleted Chest
    },
    -- Hyperconductive Pantaloons
    ["213328"] = {
        217009, -- Power Depleted Legs
    },
    -- Hyperconductive Skirt
    ["213329"] = {
        217009, -- Power Depleted Legs
    },
    -- H.A.Z.A.R.D. Legplates
    ["213330"] = {
        217009, -- Power Depleted Legs
    },
    -- Insulated Leggings
    ["213331"] = {
        217009, -- Power Depleted Legs
    },
    -- Insulated Legguards
    ["213332"] = {
        217009, -- Power Depleted Legs
    },
    -- Electromantic Chausses
    ["213333"] = {
        217009, -- Power Depleted Legs
    },
    -- Electromantic Gambeson
    ["213334"] = {
        217009, -- Power Depleted Legs
    },
    -- H.A.Z.A.R.D. Boots
    ["213335"] = {
        217007, -- Power Depleted Boots
    },
    -- Hyperconductive Walkers
    ["213336"] = {
        217007, -- Power Depleted Boots
    },
    -- Hyperconductive Sandals
    ["213337"] = {
        217007, -- Power Depleted Boots
    },
    -- Electromantic Grounding Boots
    ["213338"] = {
        217007, -- Power Depleted Boots
    },
    -- Electromantic Grounding Sabatons
    ["213339"] = {
        217007, -- Power Depleted Boots
    },
    -- Insulated Workboots
    ["213341"] = {
        217007, -- Power Depleted Boots
    },
    -- Insulated Galoshes
    ["213342"] = {
        217007, -- Power Depleted Boots
    },
    -- Justice Badge
    ["213343"] = {
        217351, -- Thermaplugg's Engineering Notes
    },
    -- Gnomeregan Peace Officer's Torque
    ["213344"] = {
        217351, -- Thermaplugg's Engineering Notes
    },
    -- Piston Pendant
    ["213345"] = {
        217351, -- Thermaplugg's Engineering Notes
    },
    -- Pendant of Homecoming
    ["213346"] = {
        217351, -- Thermaplugg's Engineering Notes
    },
    -- Shockforged Battleboots
    ["216484"] = {
        217007, -- Power Depleted Boots
    },
    -- Shockforged Breastplate
    ["216485"] = {
        217008, -- Power Depleted Chest
    },
    -- Shockforged Legplates
    ["216486"] = {
        217009, -- Power Depleted Legs
    },
    -- Power Depleted Boots
    ["217007"] = {
        213335, -- H.A.Z.A.R.D. Boots
        213336, -- Hyperconductive Walkers
        213337, -- Hyperconductive Sandals
        213338, -- Electromantic Grounding Boots
        213339, -- Electromantic Grounding Sabatons
        213341, -- Insulated Workboots
        213342, -- Insulated Galoshes
        216484, -- Shockforged Battleboots
    },
    -- Power Depleted Chest
    ["217008"] = {
        213310, -- Hyperconductive Shimmershirt
        213311, -- Hyperconductive Robe
        213312, -- Insulated Apron
        213313, -- Insulated Chestguard
        213314, -- Electromantic Chainmail
        213315, -- Electromantic Chainshirt
        213316, -- H.A.Z.A.R.D. Breastplate
        216485, -- Shockforged Breastplate
    },
    -- Power Depleted Legs
    ["217009"] = {
        213328, -- Hyperconductive Pantaloons
        213329, -- Hyperconductive Skirt
        213330, -- H.A.Z.A.R.D. Legplates
        213331, -- Insulated Leggings
        213332, -- Insulated Legguards
        213333, -- Electromantic Chausses
        213334, -- Electromantic Gambeson
        216486, -- Shockforged Legplates
    },
    -- Thermaplugg's Engineering Notes
    ["217351"] = {
        213343, -- Justice Badge
        213344, -- Gnomeregan Peace Officer's Torque
        213345, -- Piston Pendant
        213346, -- Pendant of Homecoming
    },
    -- Drakeclaw Band of the Berserker
    ["220626"] = {
        221363, -- Scapula of the Fallen Avatar
    },
    -- Drakeclaw Band of the Stalker
    ["220627"] = {
        221363, -- Scapula of the Fallen Avatar
    },
    -- Drakeclaw Band of the Harbinger
    ["220628"] = {
        221363, -- Scapula of the Fallen Avatar
    },
    -- Drakeclaw Band of the Blood Prophet
    ["220629"] = {
        221363, -- Scapula of the Fallen Avatar
    },
    -- Drakeclaw Band of the Juggernaut
    ["220630"] = {
        221363, -- Scapula of the Fallen Avatar
    },
    -- Atal'ai Blood Icon
    ["220636"] = {
        220642, -- Banished Martyr's Plate Armor
        220643, -- Banished Martyr's Plate Legguards
        220648, -- Banished Martyr's Plate Boots
        220650, -- Obsessed Prophet's Chestplate
        220651, -- Obsessed Prophet's Legguards
        220652, -- Obsessed Prophet's Ornate Boots
        220653, -- Wailing Berserker's Chestplate
        220654, -- Wailing Berserker's Legplates
        220656, -- Wailing Berserker's Battleboots
        220657, -- Ostracized Berserker's Hauberk
        220658, -- Ostracized Berserker's Legplates
        220659, -- Ostracized Berserker's Chain Greaves
        220660, -- Shunned Devotee's Chainshirt
        220661, -- Shunned Devotee's Legguards
        220662, -- Shunned Devotee's Scale Boots
        220663, -- Corrupted Spiritweaver's Leggings
        220664, -- Corrupted Spiritweaver's Sabatons
        220665, -- Corrupted Spiritweaver's Breastplate
        220666, -- Dread Hunter's Chainmail
        220667, -- Dread Hunter's Chausses
        220668, -- Dread Hunter's Greaves
        220676, -- Blood Corrupted Tunic
        220677, -- Blood Corrupted Boots
        220678, -- Blood Corrupted Pants
    },
    -- Atal'ai Ritual Token
    ["220637"] = {
        220669, -- Exiled Prophet's Jerkin
        220670, -- Exiled Prophet's Slippers
        220671, -- Exiled Prophet's Leather Pants
        220672, -- Lost Worshipper's Harness
        220673, -- Lost Worshipper's Leggings
        220675, -- Lost Worshipper's Treads
        220679, -- Malevolent Prophet's Leggings
        220680, -- Malevolent Prophet's Vest
        220681, -- Malevolent Prophet's Sandals
        220683, -- Benevolent Prophet's Vest
        220684, -- Benevolent Prophet's Leggings
        220685, -- Benevolent Prophet's Sandals
        220778, -- Coagulated Bloodguard Pants
        220779, -- Coagulated Bloodguard Tunic
        220780, -- Coagulated Bloodguard Boots
        220781, -- Nightmare Prophet's Leggings
        220783, -- Nightmare Prophet's Vestments
        220784, -- Nightmare Prophet's Sandals
    },
    -- Banished Martyr's Plate Armor
    ["220642"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Banished Martyr's Plate Legguards
    ["220643"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Banished Martyr's Plate Boots
    ["220648"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Obsessed Prophet's Chestplate
    ["220650"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Obsessed Prophet's Legguards
    ["220651"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Obsessed Prophet's Ornate Boots
    ["220652"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Wailing Berserker's Chestplate
    ["220653"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Wailing Berserker's Legplates
    ["220654"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Wailing Berserker's Battleboots
    ["220656"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Ostracized Berserker's Hauberk
    ["220657"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Ostracized Berserker's Legplates
    ["220658"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Ostracized Berserker's Chain Greaves
    ["220659"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Shunned Devotee's Chainshirt
    ["220660"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Shunned Devotee's Legguards
    ["220661"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Shunned Devotee's Scale Boots
    ["220662"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Corrupted Spiritweaver's Leggings
    ["220663"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Corrupted Spiritweaver's Sabatons
    ["220664"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Corrupted Spiritweaver's Breastplate
    ["220665"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Dread Hunter's Chainmail
    ["220666"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Dread Hunter's Chausses
    ["220667"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Dread Hunter's Greaves
    ["220668"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Exiled Prophet's Jerkin
    ["220669"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Exiled Prophet's Slippers
    ["220670"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Exiled Prophet's Leather Pants
    ["220671"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Lost Worshipper's Harness
    ["220672"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Lost Worshipper's Leggings
    ["220673"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Lost Worshipper's Treads
    ["220675"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Blood Corrupted Tunic
    ["220676"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Blood Corrupted Boots
    ["220677"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Blood Corrupted Pants
    ["220678"] = {
        220636, -- Atal'ai Blood Icon
    },
    -- Malevolent Prophet's Leggings
    ["220679"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Malevolent Prophet's Vest
    ["220680"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Malevolent Prophet's Sandals
    ["220681"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Benevolent Prophet's Vest
    ["220683"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Benevolent Prophet's Leggings
    ["220684"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Benevolent Prophet's Sandals
    ["220685"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Coagulated Bloodguard Pants
    ["220778"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Coagulated Bloodguard Tunic
    ["220779"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Coagulated Bloodguard Boots
    ["220780"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Nightmare Prophet's Leggings
    ["220781"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Nightmare Prophet's Vestments
    ["220783"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Nightmare Prophet's Sandals
    ["220784"] = {
        220637, -- Atal'ai Ritual Token
    },
    -- Scapula of the Fallen Avatar
    ["221363"] = {
        220626, -- Drakeclaw Band of the Berserker
        220627, -- Drakeclaw Band of the Stalker
        220628, -- Drakeclaw Band of the Harbinger
        220629, -- Drakeclaw Band of the Blood Prophet
        220630, -- Drakeclaw Band of the Juggernaut
    },
};