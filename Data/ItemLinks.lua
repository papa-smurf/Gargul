---@type GL
local _, GL = ...;

---@class ItemLinks : Data
GL.Data = GL.Data or {};

GL.Data.SoftResSpecificItemLinks = {};

-- [[ MOLTEN/SHADOWFLAME/BLOODIED ITEMS THAT ARE NOT PROVIDED BY TMB
---@type table
GL.Data.SkinnedItemLinks = {
    --[[ MOLTEN ]]
    -- Included in TMB now    

    --[[ SHADOWFLAME ]]
    -- Included in TMB now

    --[[ BLOODIED ]]
    -- Included in TMB now
};

GL.Data.ItemLinks = {
    --[[ <<< NOT INCLUDED BY TMB ]]

    -- Head of Onyxia (Horde)
    ["49643"] = {
        49644, -- Head of Onyxia (Alliance)
    },
    -- Head of Onyxia (Alliance)
    ["49644"] = {
        49643, -- Head of Onyxia (Horde)
    },
    ["68915"] = {
        69109, -- Scales of Life
    },
    ["69109"] = {
        68915, -- Scales of Life
    },
    ["68972"] = {
        69113, -- Apparatus of Khaz'goroth
    },
    ["69113"] = {
        68972, -- Apparatus of Khaz'goroth
    },
    ["71361"] = {
        71557, -- Ranseur of Hatred
    },
    ["71557"] = {
        71361, -- Ranseur of Hatred
    },
    ["71366"] = {
        71558, -- Lava Bolt Crossbow
    },
    ["71558"] = {
        71366, -- Lava Bolt Crossbow
    },
    ["71360"] = {
        71559, -- Spire of Scarlet Pain
    },
    ["71559"] = {
        71360, -- Spire of Scarlet Pain
    },
    ["71359"] = {
        71560, -- Chelley's Sterilized Scalpel
    },
    ["71560"] = {
        71359, -- Chelley's Sterilized Scalpel
    },
    ["71365"] = {
        71561, -- Hide-Bound Chains
    },
    ["71561"] = {
        71365, -- Hide-Bound Chains
    },
    ["71362"] = {
        71562, -- Obsidium Cleaver
    },
    ["71562"] = {
        71362, -- Obsidium Cleaver
    },
    ["70929"] = {
        71563, -- Firebound Gorget
    },
    ["71563"] = {
        70929, -- Firebound Gorget
    },
    ["71367"] = {
        71564, -- Theck's Emberseal
    },
    ["71564"] = {
        71367, -- Theck's Emberseal
    },
    ["71640"] = {
        71641, -- Riplimb's Lost Collar
    },
    ["71641"] = {
        71640, -- Riplimb's Lost Collar
    },
    ["71147"] = {
        71587, -- Relic of the Elemental Lords
    },
    ["71587"] = {
        71147, -- Relic of the Elemental Lords
    },
    ["71151"] = {
        71575, -- Trail of Embers
    },
    ["71575"] = {
        71151, -- Trail of Embers
    },
    ["71150"] = {
        71579, -- Scorchvine Wand
    },
    ["71579"] = {
        71150, -- Scorchvine Wand
    },
    ["71146"] = {
        71567, -- Covenant of the Flame
    },
    ["71567"] = {
        71146, -- Covenant of the Flame
    },
    ["70939"] = {
        71590, -- Deathclutch Figurine
    },
    ["71590"] = {
        70939, -- Deathclutch Figurine
    },
    ["71152"] = {
        71568, -- Morningstar Shard
    },
    ["71568"] = {
        71152, -- Morningstar Shard
    },
    ["71218"] = {
        71592, -- Deflecting Star
    },
    ["71592"] = {
        71218, -- Deflecting Star
    },
    ["71154"] = {
        71593, -- Giantslicer
    },
    ["71593"] = {
        71154, -- Giantslicer
    },
    ["71149"] = {
        71577, -- Singed Plume of Aviana
    },
    ["71577"] = {
        71149, -- Singed Plume of Aviana
    },
    ["71148"] = {
        71580, -- Soulflame Vial
    },
    ["71580"] = {
        71148, -- Soulflame Vial
    },

    --[[ NOT INCLUDED BY TMB >>> ]]

    -- Sturdy Lunchbox
    ["1652"] = {
        221498, -- Sturdy Lunchbox
    },
    -- Greater Healing Potion
    ["1710"] = {
        223914, -- Greater Healing Potion
    },
    -- Blade of Hanna
    ["2801"] = {
        227691, -- Blade of Hanna
    },
    -- Golden Scale Coif
    ["3837"] = {
        217279, -- Golden Scale Coif
    },
    -- Golden Scale Shoulders
    ["3841"] = {
        217283, -- Golden Scale Shoulders
    },
    -- Golden Scale Leggings
    ["3843"] = {
        217285, -- Golden Scale Leggings
    },
    -- Golden Scale Cuirass
    ["3845"] = {
        217277, -- Golden Scale Cuirass
    },
    -- Golden Scale Boots
    ["3847"] = {
        217275, -- Golden Scale Boots
    },
    -- Moonsteel Broadsword
    ["3853"] = {
        217281, -- Moonsteel Broadsword
    },
    -- Plans: Golden Scale Shoulders
    ["3871"] = {
        217284, -- Plans: Golden Scale Shoulders
    },
    -- Plans: Golden Scale Leggings
    ["3872"] = {
        217286, -- Plans: Golden Scale Leggings
    },
    -- Plans: Golden Scale Cuirass
    ["3873"] = {
        217278, -- Plans: Golden Scale Cuirass
    },
    -- Plans: Golden Scale Boots
    ["3875"] = {
        217276, -- Plans: Golden Scale Boots
    },
    -- Guardian Belt
    ["4258"] = {
        217265, -- Guardian Belt
    },
    -- Guardian Leather Bracers
    ["4260"] = {
        217263, -- Guardian Leather Bracers
    },
    -- Pattern: Guardian Belt
    ["4298"] = {
        217266, -- Pattern: Guardian Belt
    },
    -- Pattern: Guardian Leather Bracers
    ["4300"] = {
        217264, -- Pattern: Guardian Leather Bracers
    },
    -- Enchanter's Cowl
    ["4322"] = {
        217257, -- Enchanter's Cowl
    },
    -- Boots of the Enchanter
    ["4325"] = {
        217253, -- Boots of the Enchanter
    },
    -- Long Silken Cloak
    ["4326"] = {
        217252, -- Long Silken Cloak
    },
    -- Pattern: Boots of the Enchanter
    ["4352"] = {
        217254, -- Pattern: Boots of the Enchanter
    },
    -- Moonsight Rifle
    ["4383"] = {
        217314, -- Moonsight Rifle
    },
    -- Guardian Pants
    ["5962"] = {
        217267, -- Guardian Pants
    },
    -- Plans: Golden Scale Coif
    ["6047"] = {
        217280, -- Plans: Golden Scale Coif
    },
    -- Earthen Vest
    ["7051"] = {
        217256, -- Earthen Vest
    },
    -- Crimson Silk Belt
    ["7055"] = {
        217255, -- Crimson Silk Belt
    },
    -- Crimson Silk Shoulders
    ["7059"] = {
        217250, -- Crimson Silk Shoulders
    },
    -- Earthen Silk Belt
    ["7061"] = {
        217248, -- Earthen Silk Belt
    },
    -- Crimson Silk Robe
    ["7063"] = {
        217245, -- Crimson Silk Robe
    },
    -- Pattern: Crimson Silk Shoulders
    ["7084"] = {
        217251, -- Pattern: Crimson Silk Shoulders
    },
    -- Pattern: Earthen Silk Belt
    ["7086"] = {
        217249, -- Pattern: Earthen Silk Belt
    },
    -- Pattern: Crimson Silk Robe
    ["7088"] = {
        217244, -- Pattern: Crimson Silk Robe
    },
    -- Schematic: Goblin Rocket Boots
    ["7192"] = {
        221339, -- Schematic: Goblin Rocket Boots
    },
    -- Embalmed Shroud
    ["7691"] = {
        217294, -- Embalmed Shroud
    },
    -- Necrotic Wand
    ["7708"] = {
        217295, -- Necrotic Wand
    },
    -- Robe of Doan
    ["7711"] = {
        217297, -- Robe of Doan
    },
    -- Mantle of Doan
    ["7712"] = {
        217298, -- Mantle of Doan
    },
    -- Illusionary Rod
    ["7713"] = {
        217299, -- Illusionary Rod
    },
    -- Whitemane's Chapeau
    ["7720"] = {
        217300, -- Whitemane's Chapeau
    },
    -- Triune Amulet
    ["7722"] = {
        217301, -- Triune Amulet
    },
    -- Mograine's Might
    ["7723"] = {
        217302, -- Mograine's Might
    },
    -- Ghostshard Talisman
    ["7731"] = {
        217296, -- Ghostshard Talisman
    },
    -- Precision Bow
    ["8183"] = {
        217315, -- Precision Bow
    },
    -- Turtle Scale Gloves
    ["8187"] = {
        217270, -- Turtle Scale Gloves
    },
    -- Turtle Scale Breastplate
    ["8189"] = {
        217268, -- Turtle Scale Breastplate
    },
    -- Big Voodoo Robe
    ["8200"] = {
        217261, -- Big Voodoo Robe
    },
    -- Big Voodoo Mask
    ["8201"] = {
        217259, -- Big Voodoo Mask
    },
    -- Pattern: Turtle Scale Gloves
    ["8385"] = {
        217271, -- Pattern: Turtle Scale Gloves
    },
    -- Pattern: Big Voodoo Robe
    ["8386"] = {
        217262, -- Pattern: Big Voodoo Robe
    },
    -- Pattern: Big Voodoo Mask
    ["8387"] = {
        217260, -- Pattern: Big Voodoo Mask
    },
    -- Reins of the Bengal Tiger
    ["8630"] = {
        216549, -- Reins of the Bengal Tiger
    },
    -- Invisibility Potion
    ["9172"] = {
        217693, -- Invisibility Potion
    },
    -- Grime-Encrusted Ring
    ["9326"] = {
        216661, -- Grime-Encrusted Ring
    },
    -- Brilliant Gold Ring
    ["9362"] = {
        216662, -- Brilliant Gold Ring
    },
    -- Golden Scale Gauntlets
    ["9366"] = {
        217273, -- Golden Scale Gauntlets
    },
    -- Plans: Golden Scale Gauntlets
    ["9367"] = {
        217274, -- Plans: Golden Scale Gauntlets
    },
    -- Sul'thraze the Lasher
    ["9372"] = {
        223526, -- Sul'thraze the Lasher
    },
    -- Revelosh's Boots
    ["9387"] = {
        217306, -- Revelosh's Boots
    },
    -- Revelosh's Armguards
    ["9388"] = {
        217305, -- Revelosh's Armguards
    },
    -- Revelosh's Spaulders
    ["9389"] = {
        217307, -- Revelosh's Spaulders
    },
    -- Revelosh's Gloves
    ["9390"] = {
        217304, -- Revelosh's Gloves
    },
    -- Stoneweaver Leggings
    ["9407"] = {
        217303, -- Stoneweaver Leggings
    },
    -- Ironshod Bludgeon
    ["9408"] = {
        217704, -- Ironshod Bludgeon
    },
    -- Grimlok's Tribal Vestments
    ["9415"] = {
        223535, -- Grimlok's Tribal Vestments
    },
    -- Grimlok's Charge
    ["9416"] = {
        223536, -- Grimlok's Charge
    },
    -- Skullplate Bracers
    ["9432"] = {
        223537, -- Skullplate Bracers
    },
    -- Gahz'rilla Fang
    ["9467"] = {
        223527, -- Gahz'rilla Fang
    },
    -- Gahz'rilla Scale Armor
    ["9469"] = {
        223528, -- Gahz'rilla Scale Armor
    },
    -- Jinxed Hoodoo Skin
    ["9473"] = {
        223529, -- Jinxed Hoodoo Skin
    },
    -- Jinxed Hoodoo Kilt
    ["9474"] = {
        223530, -- Jinxed Hoodoo Kilt
    },
    -- Big Bad Pauldrons
    ["9476"] = {
        223531, -- Big Bad Pauldrons
    },
    -- Embrace of the Lycan
    ["9479"] = {
        223963, -- Embrace of the Lycan
    },
    -- Mechbuilder's Overalls
    ["9508"] = {
        213298, -- Mechbuilder's Overalls
    },
    -- Mechanic's Pipehammer
    ["9604"] = {
        217006, -- Mechanic's Pipehammer
    },
    -- Repairman's Cape
    ["9605"] = {
        217005, -- Repairman's Cape
    },
    -- Lifeblood Amulet
    ["9641"] = {
        223532, -- Lifeblood Amulet
    },
    -- Black Mageweave Vest
    ["9998"] = {
        217246, -- Black Mageweave Vest
    },
    -- Black Mageweave Leggings
    ["9999"] = {
        217247, -- Black Mageweave Leggings
    },
    -- Essence of Eranikus
    ["10454"] = {
        221475, -- Essence of Eranikus
    },
    -- Chained Essence of Eranikus
    ["10455"] = {
        221474, -- Chained Essence of Eranikus
    },
    -- Avenguard Helm
    ["10749"] = {
        221781, -- Avenguard Helm
    },
    -- Lifeforce Dirk
    ["10750"] = {
        223329, -- Lifeforce Dirk
    },
    -- Gemburst Circlet
    ["10751"] = {
        223328, -- Gemburst Circlet
    },
    -- Robes of the Lich
    ["10762"] = {
        217288, -- Robes of the Lich
    },
    -- Deathchill Armor
    ["10764"] = {
        217289, -- Deathchill Armor
    },
    -- Glowing Eye of Mordresh
    ["10769"] = {
        217290, -- Glowing Eye of Mordresh
    },
    -- Mordresh's Lifeless Skull
    ["10770"] = {
        217291, -- Mordresh's Lifeless Skull
    },
    -- Deathmage Sash
    ["10771"] = {
        217292, -- Deathmage Sash
    },
    -- Silky Spider Cape
    ["10776"] = {
        217293, -- Silky Spider Cape
    },
    -- Mark of Hakkar
    ["10780"] = {
        223327, -- Mark of Hakkar
    },
    -- Hakkari Breastplate
    ["10781"] = {
        223325, -- Hakkari Breastplate
    },
    -- Hakkari Shroud
    ["10782"] = {
        223326, -- Hakkari Shroud
    },
    -- Rainstrider Leggings
    ["11123"] = {
        223324, -- Rainstrider Leggings
    },
    -- Helm of Exile
    ["11124"] = {
        221782, -- Helm of Exile
    },
    -- Greater Mystic Wand
    ["11290"] = {
        217287, -- Greater Mystic Wand
    },
    -- Enthralled Sphere
    ["11625"] = {
        223539, -- Enthralled Sphere
    },
    -- Houndmaster's Bow
    ["11628"] = {
        223540, -- Houndmaster's Bow
    },
    -- Houndmaster's Rifle
    ["11629"] = {
        223982, -- Houndmaster's Rifle
    },
    -- Silkweb Gloves
    ["11634"] = {
        223984, -- Silkweb Gloves
    },
    -- Naglering
    ["11669"] = {
        227966, -- Naglering
    },
    -- Graverot Cape
    ["11677"] = {
        223986, -- Graverot Cape
    },
    -- Ironfoe
    ["11684"] = {
        227991, -- Ironfoe
    },
    -- Splinthide Shoulders
    ["11685"] = {
        223987, -- Splinthide Shoulders
    },
    -- Dregmetal Spaulders
    ["11722"] = {
        223544, -- Dregmetal Spaulders
    },
    -- Savage Gladiator Chain
    ["11726"] = {
        227952, -- Savage Gladiator Chain
    },
    -- Savage Gladiator Helm
    ["11729"] = {
        227955, -- Savage Gladiator Helm
    },
    -- Savage Gladiator Grips
    ["11730"] = {
        227961, -- Savage Gladiator Grips
    },
    -- Savage Gladiator Greaves
    ["11731"] = {
        227957, -- Savage Gladiator Greaves
    },
    -- Rockfist
    ["11743"] = {
        227968, -- Rockfist
    },
    -- Bloodfist
    ["11744"] = {
        227951, -- Bloodfist
    },
    -- Golem Skull Helm
    ["11746"] = {
        227975, -- Golem Skull Helm
    },
    -- Flamestrider Robes
    ["11747"] = {
        223981, -- Flamestrider Robes
    },
    -- Searingscale Leggings
    ["11749"] = {
        223980, -- Searingscale Leggings
    },
    -- Kindling Stave
    ["11750"] = {
        223538, -- Kindling Stave
    },
    -- Verek's Collar
    ["11755"] = {
        227943, -- Verek's Collar
    },
    -- Boreal Mantle
    ["11782"] = {
        227954, -- Boreal Mantle
    },
    -- Arbiter's Blade
    ["11784"] = {
        223983, -- Arbiter's Blade
    },
    -- Stone of the Earth
    ["11786"] = {
        227950, -- Stone of the Earth
    },
    -- Force of Magma
    ["11803"] = {
        227949, -- Force of Magma
    },
    -- Rubidium Hammer
    ["11805"] = {
        227946, -- Rubidium Hammer
    },
    -- Circle of Flame
    ["11808"] = {
        227973, -- Circle of Flame
    },
    -- Flame Wrath
    ["11809"] = {
        227934, -- Flame Wrath
    },
    -- Cape of the Fire Salamander
    ["11812"] = {
        227970, -- Cape of the Fire Salamander
    },
    -- Molten Fists
    ["11814"] = {
        227971, -- Molten Fists
    },
    -- Hand of Justice
    ["11815"] = {
        228722, -- Hand of Justice
    },
    -- Angerforge's Battle Axe
    ["11816"] = {
        227948, -- Angerforge's Battle Axe
    },
    -- Lord General's Sword
    ["11817"] = {
        227940, -- Lord General's Sword
    },
    -- Second Wind
    ["11819"] = {
        227967, -- Second Wind
    },
    -- Omnicast Boots
    ["11822"] = {
        227965, -- Omnicast Boots
    },
    -- Luminary Kilt
    ["11823"] = {
        227964, -- Luminary Kilt
    },
    -- Cyclopean Band
    ["11824"] = {
        223985, -- Cyclopean Band
    },
    -- Burst of Knowledge
    ["11832"] = {
        227972, -- Burst of Knowledge
    },
    -- Chief Architect's Monocle
    ["11839"] = {
        227969, -- Chief Architect's Monocle
    },
    -- Wraith Scythe
    ["11920"] = {
        227941, -- Wraith Scythe
    },
    -- Impervious Giant
    ["11921"] = {
        227960, -- Impervious Giant
    },
    -- Blood-etched Blade
    ["11922"] = {
        227963, -- Blood-etched Blade
    },
    -- The Hammer of Grace
    ["11923"] = {
        227953, -- The Hammer of Grace
    },
    -- Robes of the Royal Crown
    ["11924"] = {
        227980, -- Robes of the Royal Crown
    },
    -- Ghostshroud
    ["11925"] = {
        227958, -- Ghostshroud
    },
    -- Deathdealer Breastplate
    ["11926"] = {
        227956, -- Deathdealer Breastplate
    },
    -- Legplates of the Eternal Guardian
    ["11927"] = {
        227959, -- Legplates of the Eternal Guardian
    },
    -- Thaurissan's Royal Scepter
    ["11928"] = {
        227984, -- Thaurissan's Royal Scepter
    },
    -- The Emperor's New Cape
    ["11930"] = {
        227985, -- The Emperor's New Cape
    },
    -- Dreadforge Retaliator
    ["11931"] = {
        227981, -- Dreadforge Retaliator
    },
    -- Guiding Stave of Wisdom
    ["11932"] = {
        227982, -- Guiding Stave of Wisdom
    },
    -- Imperial Jewel
    ["11933"] = {
        227988, -- Imperial Jewel
    },
    -- Magmus Stone
    ["11935"] = {
        227978, -- Magmus Stone
    },
    -- Star of Mystaria
    ["12103"] = {
        228536, -- Star of Mystaria
    },
    -- Plans: Moonsteel Broadsword
    ["12163"] = {
        217282, -- Plans: Moonsteel Broadsword
    },
    -- Reins of the Golden Sabercat
    ["12327"] = {
        216570, -- Reins of the Golden Sabercat
    },
    -- Key to the City
    ["12382"] = {
        228166, -- Key to the City
    },
    -- Sandstalker Ankleguards
    ["12470"] = {
        223962, -- Sandstalker Ankleguards
    },
    -- Desertwalker Cane
    ["12471"] = {
        223533, -- Desertwalker Cane
    },
    -- Hands of the Exalted Herald
    ["12554"] = {
        227979, -- Hands of the Exalted Herald
    },
    -- Blackhand Doomsaw
    ["12583"] = {
        228603, -- Blackhand Doomsaw
    },
    -- Grand Marshal's Longsword
    ["12584"] = {
        234578, -- Grand Marshal's Longsword
    },
    -- Eye of Rend
    ["12587"] = {
        228604, -- Eye of Rend
    },
    -- Bonespike Shoulder
    ["12588"] = {
        228605, -- Bonespike Shoulder
    },
    -- Dustfeather Sash
    ["12589"] = {
        228578, -- Dustfeather Sash
    },
    -- Felstriker
    ["12590"] = {
        228757, -- Felstriker
    },
    -- Blackblade of Shahram
    ["12592"] = {
        228606, -- Blackblade of Shahram
    },
    -- Starfire Tiara
    ["12604"] = {
        228566, -- Starfire Tiara
    },
    -- Serpentine Skuller
    ["12605"] = {
        227942, -- Serpentine Skuller
    },
    -- Crystallized Girdle
    ["12606"] = {
        228579, -- Crystallized Girdle
    },
    -- Butcher's Apron
    ["12608"] = {
        228556, -- Butcher's Apron
    },
    -- Funeral Cuffs
    ["12626"] = {
        228558, -- Funeral Cuffs
    },
    -- Head of Rend Blackhand
    ["12630"] = {
        227911, -- Head of Rend Blackhand
    },
    -- Chiselbrand Girdle
    ["12634"] = {
        228567, -- Chiselbrand Girdle
    },
    -- Backusarian Gauntlets
    ["12637"] = {
        228568, -- Backusarian Gauntlets
    },
    -- Blackcrow
    ["12651"] = {
        228559, -- Blackcrow
    },
    -- Truestrike Shoulders
    ["12927"] = {
        228583, -- Truestrike Shoulders
    },
    -- Emberfury Talisman
    ["12929"] = {
        228584, -- Emberfury Talisman
    },
    -- Warmaster Legguards
    ["12935"] = {
        228650, -- Warmaster Legguards
    },
    -- Battleborn Armbraces
    ["12936"] = {
        228651, -- Battleborn Armbraces
    },
    -- Dal'Rend's Tribal Guardian
    ["12939"] = {
        228652, -- Dal'Rend's Tribal Guardian
    },
    -- Dal'Rend's Sacred Charge
    ["12940"] = {
        228653, -- Dal'Rend's Sacred Charge
    },
    -- Blademaster Leggings
    ["12963"] = {
        228660, -- Blademaster Leggings
    },
    -- Tristam Legguards
    ["12964"] = {
        228661, -- Tristam Legguards
    },
    -- Blackmist Armguards
    ["12966"] = {
        228662, -- Blackmist Armguards
    },
    -- Bloodmoon Cloak
    ["12967"] = {
        228663, -- Bloodmoon Cloak
    },
    -- Frostweaver Cape
    ["12968"] = {
        228664, -- Frostweaver Cape
    },
    -- Seeping Willow
    ["12969"] = {
        228666, -- Seeping Willow
    },
    -- Painweaver Band
    ["13098"] = {
        228667, -- Painweaver Band
    },
    -- Dreamwalker Armor
    ["13123"] = {
        236209, -- Dreamwalker Armor
    },
    -- Tooth of Gnarr
    ["13141"] = {
        228669, -- Tooth of Gnarr
    },
    -- Brigam Girdle
    ["13142"] = {
        228670, -- Brigam Girdle
    },
    -- Mark of the Dragon Lord
    ["13143"] = {
        228585, -- Mark of the Dragon Lord
    },
    -- Chillpike
    ["13148"] = {
        228586, -- Chillpike
    },
    -- Trindlehaven Staff
    ["13161"] = {
        228587, -- Trindlehaven Staff
    },
    -- Reiver Claws
    ["13162"] = {
        228588, -- Reiver Claws
    },
    -- Relentless Scythe
    ["13163"] = {
        228601, -- Relentless Scythe
    },
    -- Heart of the Scale
    ["13164"] = {
        228589, -- Heart of the Scale
    },
    -- Fist of Omokk
    ["13167"] = {
        228570, -- Fist of Omokk
    },
    -- Plate of the Shaman King
    ["13168"] = {
        228571, -- Plate of the Shaman King
    },
    -- Talisman of Evasion
    ["13177"] = {
        228574, -- Talisman of Evasion
    },
    -- Brazecore Armguards
    ["13179"] = {
        228572, -- Brazecore Armguards
    },
    -- Demonskin Gloves
    ["13181"] = {
        228554, -- Demonskin Gloves
    },
    -- Phase Blade
    ["13182"] = {
        228555, -- Phase Blade
    },
    -- Venomspitter
    ["13183"] = {
        228573, -- Venomspitter
    },
    -- Sunderseer Mantle
    ["13185"] = {
        228590, -- Sunderseer Mantle
    },
    -- Rhombeard Protector
    ["13205"] = {
        228591, -- Rhombeard Protector
    },
    -- Slashclaw Bracers
    ["13211"] = {
        228575, -- Slashclaw Bracers
    },
    -- Smolderweb's Eye
    ["13213"] = {
        228576, -- Smolderweb's Eye
    },
    -- Fang of the Crystal Spider
    ["13218"] = {
        228592, -- Fang of the Crystal Spider
    },
    -- Gilded Gauntlets
    ["13244"] = {
        228577, -- Gilded Gauntlets
    },
    -- Trueaim Gauntlets
    ["13255"] = {
        228561, -- Trueaim Gauntlets
    },
    -- Demonic Runed Spaulders
    ["13257"] = {
        228562, -- Demonic Runed Spaulders
    },
    -- Wind Dancer Boots
    ["13260"] = {
        228593, -- Wind Dancer Boots
    },
    -- Globe of D'sak
    ["13261"] = {
        228563, -- Globe of D'sak
    },
    -- Ogreseer Tower Boots
    ["13282"] = {
        228564, -- Ogreseer Tower Boots
    },
    -- Magus Ring
    ["13283"] = {
        228565, -- Magus Ring
    },
    -- Swiftdart Battleboots
    ["13284"] = {
        228557, -- Swiftdart Battleboots
    },
    -- Alanna's Embrace
    ["13314"] = {
        228023, -- Alanna's Embrace
    },
    -- Fluorescent Green Mechanostrider
    ["13325"] = {
        228746, -- Fluorescent Green Mechanostrider
    },
    -- Dracorian Gauntlets
    ["13344"] = {
        228537, -- Dracorian Gauntlets
    },
    -- Seal of Rivendare
    ["13345"] = {
        228538, -- Seal of Rivendare
    },
    -- Book of the Dead
    ["13353"] = {
        228539, -- Book of the Dead
    },
    -- Crown of Tyranny
    ["13359"] = {
        228540, -- Crown of Tyranny
    },
    -- Gift of the Elven Magi
    ["13360"] = {
        228541, -- Gift of the Elven Magi
    },
    -- Skullforge Reaver
    ["13361"] = {
        228542, -- Skullforge Reaver
    },
    -- Soulstealer Mantle
    ["13374"] = {
        228520, -- Soulstealer Mantle
    },
    -- Royal Tribunal Cloak
    ["13376"] = {
        228505, -- Royal Tribunal Cloak
    },
    -- Songbird Blouse
    ["13378"] = {
        228501, -- Songbird Blouse
    },
    -- Piccolo of the Flaming Fire
    ["13379"] = {
        228502, -- Piccolo of the Flaming Fire
    },
    -- Willey's Portable Howitzer
    ["13380"] = {
        228522, -- Willey's Portable Howitzer
    },
    -- Cannonball Runner
    ["13382"] = {
        228523, -- Cannonball Runner
    },
    -- Woollies of the Prancing Minstrel
    ["13383"] = {
        228503, -- Woollies of the Prancing Minstrel
    },
    -- Rainbow Girdle
    ["13384"] = {
        228504, -- Rainbow Girdle
    },
    -- The Postmaster's Tunic
    ["13388"] = {
        228525, -- The Postmaster's Tunic
    },
    -- The Postmaster's Trousers
    ["13389"] = {
        228527, -- The Postmaster's Trousers
    },
    -- The Postmaster's Band
    ["13390"] = {
        228528, -- The Postmaster's Band
    },
    -- The Postmaster's Treads
    ["13391"] = {
        228529, -- The Postmaster's Treads
    },
    -- The Postmaster's Seal
    ["13392"] = {
        228524, -- The Postmaster's Seal
    },
    -- Boots of the Shrieker
    ["13398"] = {
        228043, -- Boots of the Shrieker
    },
    -- Vambraces of the Sadist
    ["13400"] = {
        228513, -- Vambraces of the Sadist
    },
    -- Timmy's Galoshes
    ["13402"] = {
        228514, -- Timmy's Galoshes
    },
    -- Grimgore Noose
    ["13403"] = {
        228515, -- Grimgore Noose
    },
    -- Mask of the Unforgiven
    ["13404"] = {
        228500, -- Mask of the Unforgiven
    },
    -- Major Healing Potion
    ["13446"] = {
        223913, -- Major Healing Potion
    },
    -- Purification Potion
    ["13462"] = {
        223912, -- Purification Potion
    },
    -- Handcrafted Mastersmith Girdle
    ["13502"] = {
        228672, -- Handcrafted Mastersmith Girdle
    },
    -- Runeblade of Baron Rivendare
    ["13505"] = {
        228543, -- Runeblade of Baron Rivendare
    },
    -- Headmaster's Charge
    ["13937"] = {
        228022, -- Headmaster's Charge
    },
    -- Tombstone Breastplate
    ["13944"] = {
        228025, -- Tombstone Breastplate
    },
    -- Detention Strap
    ["13950"] = {
        228042, -- Detention Strap
    },
    -- Iceblade Hacker
    ["13952"] = {
        228027, -- Iceblade Hacker
    },
    -- Silent Fang
    ["13953"] = {
        228024, -- Silent Fang
    },
    -- Stoneform Shoulders
    ["13955"] = {
        228001, -- Stoneform Shoulders
    },
    -- Clutch of Andros
    ["13956"] = {
        228005, -- Clutch of Andros
    },
    -- Gargoyle Slashers
    ["13957"] = {
        228007, -- Gargoyle Slashers
    },
    -- Heart of the Fiend
    ["13960"] = {
        228019, -- Heart of the Fiend
    },
    -- Witchblade
    ["13964"] = {
        228021, -- Witchblade
    },
    -- Windreaver Greaves
    ["13967"] = {
        228004, -- Windreaver Greaves
    },
    -- Gravestone War Axe
    ["13983"] = {
        228029, -- Gravestone War Axe
    },
    -- Frightalon
    ["14024"] = {
        228015, -- Frightalon
    },
    -- Bottomless Bag
    ["14156"] = {
        228994, -- Bottomless Bag
    },
    -- Geomancer's Cord
    ["14217"] = {
        223173, -- Geomancer's Cord
    },
    -- Geomancer's Boots
    ["14218"] = {
        223174, -- Geomancer's Boots
    },
    -- Geomancer's Cloak
    ["14219"] = {
        223175, -- Geomancer's Cloak
    },
    -- Geomancer's Cap
    ["14220"] = {
        223177, -- Geomancer's Cap
    },
    -- Geomancer's Bracers
    ["14221"] = {
        223178, -- Geomancer's Bracers
    },
    -- Geomancer's Gloves
    ["14222"] = {
        223180, -- Geomancer's Gloves
    },
    -- Geomancer's Spaulders
    ["14223"] = {
        223181, -- Geomancer's Spaulders
    },
    -- Geomancer's Trousers
    ["14224"] = {
        223182, -- Geomancer's Trousers
    },
    -- Geomancer's Wraps
    ["14225"] = {
        223183, -- Geomancer's Wraps
    },
    -- Death's Clutch
    ["14503"] = {
        228036, -- Death's Clutch
    },
    -- Pattern: Bottomless Bag
    ["14510"] = {
        228993, -- Pattern: Bottomless Bag
    },
    -- Maelstrom Leggings
    ["14522"] = {
        228044, -- Maelstrom Leggings
    },
    -- Rattlecage Buckler
    ["14528"] = {
        228037, -- Rattlecage Buckler
    },
    -- Frightskull Shaft
    ["14531"] = {
        227994, -- Frightskull Shaft
    },
    -- Bone Ring Helm
    ["14539"] = {
        228032, -- Bone Ring Helm
    },
    -- Barovian Family Sword
    ["14541"] = {
        227997, -- Barovian Family Sword
    },
    -- Darkshade Gloves
    ["14543"] = {
        228031, -- Darkshade Gloves
    },
    -- Ghostloom Leggings
    ["14545"] = {
        228040, -- Ghostloom Leggings
    },
    -- Ebon Hilt of Marduk
    ["14576"] = {
        227993, -- Ebon Hilt of Marduk
    },
    -- Skullsmoke Pants
    ["14577"] = {
        228017, -- Skullsmoke Pants
    },
    -- Bloodmail Hauberk
    ["14611"] = {
        228012, -- Bloodmail Hauberk
    },
    -- Bloodmail Legguards
    ["14612"] = {
        228003, -- Bloodmail Legguards
    },
    -- Bloodmail Belt
    ["14614"] = {
        228014, -- Bloodmail Belt
    },
    -- Bloodmail Gauntlets
    ["14615"] = {
        228020, -- Bloodmail Gauntlets
    },
    -- Bloodmail Boots
    ["14616"] = {
        227998, -- Bloodmail Boots
    },
    -- Deathbone Girdle
    ["14620"] = {
        228002, -- Deathbone Girdle
    },
    -- Deathbone Sabatons
    ["14621"] = {
        227999, -- Deathbone Sabatons
    },
    -- Deathbone Gauntlets
    ["14622"] = {
        228006, -- Deathbone Gauntlets
    },
    -- Deathbone Legguards
    ["14623"] = {
        228008, -- Deathbone Legguards
    },
    -- Deathbone Chestplate
    ["14624"] = {
        228000, -- Deathbone Chestplate
    },
    -- Necropile Robe
    ["14626"] = {
        228013, -- Necropile Robe
    },
    -- Necropile Cuffs
    ["14629"] = {
        228011, -- Necropile Cuffs
    },
    -- Pattern: Enchanter's Cowl
    ["14630"] = {
        217258, -- Pattern: Enchanter's Cowl
    },
    -- Necropile Boots
    ["14631"] = {
        228009, -- Necropile Boots
    },
    -- Necropile Leggings
    ["14632"] = {
        228018, -- Necropile Leggings
    },
    -- Necropile Mantle
    ["14633"] = {
        228010, -- Necropile Mantle
    },
    -- Cadaverous Armor
    ["14637"] = {
        227995, -- Cadaverous Armor
    },
    -- Mortar and Pestle
    ["15454"] = {
        206176, -- Mortar and Pestle
    },
    -- Ancient Belt
    ["15606"] = {
        231725, -- Ancient Belt
    },
    -- High Warlord's Blade
    ["16345"] = {
        234552, -- High Warlord's Blade
    },
    -- Knight-Lieutenant's Silk Gloves
    ["16391"] = {
        227116, -- Knight-Lieutenant's Silk Gloves
    },
    -- Knight-Lieutenant's Dragonhide Gloves
    ["16397"] = {
        227193, -- Knight-Lieutenant's Dragonhide Gloves
    },
    -- Knight-Lieutenant's Plate Gauntlets
    ["16406"] = {
        227053, -- Knight-Lieutenant's Plate Gauntlets
    },
    -- Knight-Lieutenant's Lamellar Sabatons
    ["16409"] = {
        227146, -- Knight-Lieutenant's Lamellar Sabatons
    },
    -- Knight-Lieutenant's Lamellar Gauntlets
    ["16410"] = {
        227147, -- Knight-Lieutenant's Lamellar Gauntlets
    },
    -- Knight-Captain's Leather Legguards
    ["16419"] = {
        227061, -- Knight-Captain's Leather Legguards
    },
    -- Knight-Captain's Dragonhide Tunic
    ["16421"] = {
        227196, -- Knight-Captain's Dragonhide Tunic
    },
    -- Knight-Captain's Dragonhide Leggings
    ["16422"] = {
        227178, -- Knight-Captain's Dragonhide Leggings
    },
    -- Knight-Captain's Chain Hauberk
    ["16425"] = {
        227070, -- Knight-Captain's Chain Hauberk
    },
    -- Lieutenant Commander's Chain Pauldrons
    ["16427"] = {
        227084, -- Lieutenant Commander's Chain Pauldrons
    },
    -- Lieutenant Commander's Plate Helm
    ["16429"] = {
        227044, -- Lieutenant Commander's Plate Helm
    },
    -- Knight-Captain's Plate Leggings
    ["16431"] = {
        227047, -- Knight-Captain's Plate Leggings
    },
    -- Knight-Captain's Lamellar Breastplate
    ["16433"] = {
        227142, -- Knight-Captain's Lamellar Breastplate
    },
    -- Lieutenant Commander's Lamellar Headguard
    ["16434"] = {
        227144, -- Lieutenant Commander's Lamellar Headguard
    },
    -- Knight-Captain's Lamellar Leggings
    ["16435"] = {
        227143, -- Knight-Captain's Lamellar Leggings
    },
    -- Lieutenant Commander's Lamellar Shoulders
    ["16436"] = {
        227145, -- Lieutenant Commander's Lamellar Shoulders
    },
    -- Marshal's Silk Footwraps
    ["16437"] = {
        231606, -- Marshal's Silk Footwraps
    },
    -- Marshal's Silk Gloves
    ["16440"] = {
        231607, -- Marshal's Silk Gloves
    },
    -- Field Marshal's Coronet
    ["16441"] = {
        231604, -- Field Marshal's Coronet
    },
    -- Marshal's Silk Leggings
    ["16442"] = {
        231605, -- Marshal's Silk Leggings
    },
    -- Field Marshal's Silk Vestments
    ["16443"] = {
        231603, -- Field Marshal's Silk Vestments
    },
    -- Field Marshal's Silk Spaulders
    ["16444"] = {
        231602, -- Field Marshal's Silk Spaulders
    },
    -- Marshal's Leather Footguards
    ["16446"] = {
        231546, -- Marshal's Leather Footguards
    },
    -- Marshal's Dragonhide Gauntlets
    ["16448"] = {
        231706, -- Marshal's Dragonhide Gauntlets
    },
    -- Field Marshal's Dragonhide Spaulders
    ["16449"] = {
        231699, -- Field Marshal's Dragonhide Spaulders
    },
    -- Marshal's Dragonhide Legguards
    ["16450"] = {
        231703, -- Marshal's Dragonhide Legguards
    },
    -- Field Marshal's Leather Chestpiece
    ["16453"] = {
        231543, -- Field Marshal's Leather Chestpiece
    },
    -- Marshal's Leather Handgrips
    ["16454"] = {
        231544, -- Marshal's Leather Handgrips
    },
    -- Field Marshal's Leather Mask
    ["16455"] = {
        231545, -- Field Marshal's Leather Mask
    },
    -- Marshal's Leather Leggings
    ["16456"] = {
        231548, -- Marshal's Leather Leggings
    },
    -- Field Marshal's Leather Epaulets
    ["16457"] = {
        231547, -- Field Marshal's Leather Epaulets
    },
    -- Marshal's Dragonhide Boots
    ["16459"] = {
        231698, -- Marshal's Dragonhide Boots
    },
    -- Marshal's Chain Grips
    ["16463"] = {
        231560, -- Marshal's Chain Grips
    },
    -- Field Marshal's Chain Helm
    ["16465"] = {
        231580, -- Field Marshal's Chain Helm
    },
    -- Marshal's Chain Legguards
    ["16467"] = {
        231577, -- Marshal's Chain Legguards
    },
    -- Marshal's Lamellar Gloves
    ["16471"] = {
        231643, -- Marshal's Lamellar Gloves
    },
    -- Field Marshal's Lamellar Chestplate
    ["16473"] = {
        231641, -- Field Marshal's Lamellar Chestplate
    },
    -- Field Marshal's Lamellar Pauldrons
    ["16476"] = {
        231645, -- Field Marshal's Lamellar Pauldrons
    },
    -- Field Marshal's Plate Armor
    ["16477"] = {
        231536, -- Field Marshal's Plate Armor
    },
    -- Field Marshal's Plate Helm
    ["16478"] = {
        231538, -- Field Marshal's Plate Helm
    },
    -- Marshal's Plate Legguards
    ["16479"] = {
        231540, -- Marshal's Plate Legguards
    },
    -- Field Marshal's Plate Shoulderguards
    ["16480"] = {
        231537, -- Field Marshal's Plate Shoulderguards
    },
    -- Marshal's Plate Boots
    ["16483"] = {
        231539, -- Marshal's Plate Boots
    },
    -- Marshal's Plate Gauntlets
    ["16484"] = {
        231541, -- Marshal's Plate Gauntlets
    },
    -- First Sergeant's Silk Cuffs
    ["16486"] = {
        216707, -- First Sergeant's Silk Cuffs
    },
    -- Blood Guard's Silk Gloves
    ["16487"] = {
        227117, -- Blood Guard's Silk Gloves
    },
    -- Blood Guard's Dragonhide Boots
    ["16494"] = {
        227188, -- Blood Guard's Dragonhide Boots
    },
    -- Blood Guard's Dragonhide Gauntlets
    ["16496"] = {
        227204, -- Blood Guard's Dragonhide Gauntlets
    },
    -- First Sergeant's Leather Armguards
    ["16497"] = {
        216706, -- First Sergeant's Leather Armguards
    },
    -- Champion's Dragonhide Spaulders
    ["16501"] = {
        227184, -- Champion's Dragonhide Spaulders
    },
    -- Champion's Dragonhide Helm
    ["16503"] = {
        227186, -- Champion's Dragonhide Helm
    },
    -- Champion's Mail Helm
    ["16521"] = {
        227162, -- Champion's Mail Helm
    },
    -- Legionnaire's Mail Leggings
    ["16523"] = {
        227161, -- Legionnaire's Mail Leggings
    },
    -- Champion's Chain Pauldrons
    ["16528"] = {
        227078, -- Champion's Chain Pauldrons
    },
    -- First Sergeant's Mail Wristguards
    ["16532"] = {
        216703, -- First Sergeant's Mail Wristguards
    },
    -- Warlord's Silk Cowl
    ["16533"] = {
        231601, -- Warlord's Silk Cowl
    },
    -- General's Silk Trousers
    ["16534"] = {
        231595, -- General's Silk Trousers
    },
    -- Warlord's Silk Raiment
    ["16535"] = {
        231596, -- Warlord's Silk Raiment
    },
    -- Warlord's Silk Amice
    ["16536"] = {
        231594, -- Warlord's Silk Amice
    },
    -- General's Silk Boots
    ["16539"] = {
        231597, -- General's Silk Boots
    },
    -- Warlord's Plate Armor
    ["16541"] = {
        231530, -- Warlord's Plate Armor
    },
    -- Warlord's Plate Headpiece
    ["16542"] = {
        231535, -- Warlord's Plate Headpiece
    },
    -- General's Plate Leggings
    ["16543"] = {
        231533, -- General's Plate Leggings
    },
    -- Warlord's Plate Shoulders
    ["16544"] = {
        231534, -- Warlord's Plate Shoulders
    },
    -- General's Plate Boots
    ["16545"] = {
        231531, -- General's Plate Boots
    },
    -- General's Plate Gauntlets
    ["16548"] = {
        231532, -- General's Plate Gauntlets
    },
    -- General's Dragonhide Leggings
    ["16552"] = {
        231685, -- General's Dragonhide Leggings
    },
    -- General's Dragonhide Boots
    ["16554"] = {
        231682, -- General's Dragonhide Boots
    },
    -- General's Dragonhide Gloves
    ["16555"] = {
        231677, -- General's Dragonhide Gloves
    },
    -- General's Leather Treads
    ["16558"] = {
        231552, -- General's Leather Treads
    },
    -- General's Leather Mitts
    ["16560"] = {
        231555, -- General's Leather Mitts
    },
    -- Warlord's Leather Helm
    ["16561"] = {
        231553, -- Warlord's Leather Helm
    },
    -- Warlord's Leather Spaulders
    ["16562"] = {
        231551, -- Warlord's Leather Spaulders
    },
    -- Warlord's Leather Breastplate
    ["16563"] = {
        231549, -- Warlord's Leather Breastplate
    },
    -- General's Leather Legguards
    ["16564"] = {
        231554, -- General's Leather Legguards
    },
    -- General's Chain Legguards
    ["16567"] = {
        231574, -- General's Chain Legguards
    },
    -- Warlord's Chain Shoulders
    ["16568"] = {
        231572, -- Warlord's Chain Shoulders
    },
    -- General's Mail Boots
    ["16573"] = {
        231667, -- General's Mail Boots
    },
    -- General's Mail Gauntlets
    ["16574"] = {
        231660, -- General's Mail Gauntlets
    },
    -- Warlord's Mail Helm
    ["16578"] = {
        231663, -- Warlord's Mail Helm
    },
    -- General's Mail Leggings
    ["16579"] = {
        231664, -- General's Mail Leggings
    },
    -- Warlord's Mail Spaulders
    ["16580"] = {
        231659, -- Warlord's Mail Spaulders
    },
    -- Vest of Elements
    ["16666"] = {
        226749, -- Vest of Elements
    },
    -- Coif of Elements
    ["16667"] = {
        226755, -- Coif of Elements
    },
    -- Kilt of Elements
    ["16668"] = {
        226750, -- Kilt of Elements
    },
    -- Pauldrons of Elements
    ["16669"] = {
        226753, -- Pauldrons of Elements
    },
    -- Boots of Elements
    ["16670"] = {
        226752, -- Boots of Elements
    },
    -- Bindings of Elements
    ["16671"] = {
        226751, -- Bindings of Elements
    },
    -- Gauntlets of Elements
    ["16672"] = {
        226748, -- Gauntlets of Elements
    },
    -- Cord of Elements
    ["16673"] = {
        226754, -- Cord of Elements
    },
    -- Beaststalker's Tunic
    ["16674"] = {
        226723, -- Beaststalker's Tunic
    },
    -- Beaststalker's Boots
    ["16675"] = {
        226722, -- Beaststalker's Boots
    },
    -- Beaststalker's Gloves
    ["16676"] = {
        226721, -- Beaststalker's Gloves
    },
    -- Beaststalker's Cap
    ["16677"] = {
        226720, -- Beaststalker's Cap
    },
    -- Beaststalker's Pants
    ["16678"] = {
        226719, -- Beaststalker's Pants
    },
    -- Beaststalker's Mantle
    ["16679"] = {
        226716, -- Beaststalker's Mantle
    },
    -- Beaststalker's Belt
    ["16680"] = {
        226718, -- Beaststalker's Belt
    },
    -- Beaststalker's Bindings
    ["16681"] = {
        226717, -- Beaststalker's Bindings
    },
    -- Magister's Boots
    ["16682"] = {
        226730, -- Magister's Boots
    },
    -- Magister's Bindings
    ["16683"] = {
        226725, -- Magister's Bindings
    },
    -- Magister's Gloves
    ["16684"] = {
        226731, -- Magister's Gloves
    },
    -- Magister's Belt
    ["16685"] = {
        226724, -- Magister's Belt
    },
    -- Magister's Crown
    ["16686"] = {
        226728, -- Magister's Crown
    },
    -- Magister's Leggings
    ["16687"] = {
        226727, -- Magister's Leggings
    },
    -- Magister's Robes
    ["16688"] = {
        226729, -- Magister's Robes
    },
    -- Magister's Mantle
    ["16689"] = {
        226726, -- Magister's Mantle
    },
    -- Devout Robe
    ["16690"] = {
        226745, -- Devout Robe
    },
    -- Devout Sandals
    ["16691"] = {
        226743, -- Devout Sandals
    },
    -- Devout Gloves
    ["16692"] = {
        226740, -- Devout Gloves
    },
    -- Devout Crown
    ["16693"] = {
        226746, -- Devout Crown
    },
    -- Devout Skirt
    ["16694"] = {
        226747, -- Devout Skirt
    },
    -- Devout Mantle
    ["16695"] = {
        226741, -- Devout Mantle
    },
    -- Devout Belt
    ["16696"] = {
        226744, -- Devout Belt
    },
    -- Devout Bracers
    ["16697"] = {
        226742, -- Devout Bracers
    },
    -- Dreadmist Mask
    ["16698"] = {
        226762, -- Dreadmist Mask
    },
    -- Dreadmist Leggings
    ["16699"] = {
        226760, -- Dreadmist Leggings
    },
    -- Dreadmist Robe
    ["16700"] = {
        226757, -- Dreadmist Robe
    },
    -- Dreadmist Mantle
    ["16701"] = {
        226756, -- Dreadmist Mantle
    },
    -- Dreadmist Belt
    ["16702"] = {
        226761, -- Dreadmist Belt
    },
    -- Dreadmist Bracers
    ["16703"] = {
        226759, -- Dreadmist Bracers
    },
    -- Dreadmist Sandals
    ["16704"] = {
        226763, -- Dreadmist Sandals
    },
    -- Dreadmist Wraps
    ["16705"] = {
        226758, -- Dreadmist Wraps
    },
    -- Wildheart Vest
    ["16706"] = {
        226715, -- Wildheart Vest
    },
    -- Shadowcraft Cap
    ["16707"] = {
        226707, -- Shadowcraft Cap
    },
    -- Shadowcraft Spaulders
    ["16708"] = {
        226706, -- Shadowcraft Spaulders
    },
    -- Shadowcraft Pants
    ["16709"] = {
        226705, -- Shadowcraft Pants
    },
    -- Shadowcraft Bracers
    ["16710"] = {
        226704, -- Shadowcraft Bracers
    },
    -- Shadowcraft Boots
    ["16711"] = {
        226703, -- Shadowcraft Boots
    },
    -- Shadowcraft Gloves
    ["16712"] = {
        226702, -- Shadowcraft Gloves
    },
    -- Shadowcraft Belt
    ["16713"] = {
        226701, -- Shadowcraft Belt
    },
    -- Wildheart Bracers
    ["16714"] = {
        226714, -- Wildheart Bracers
    },
    -- Wildheart Boots
    ["16715"] = {
        226713, -- Wildheart Boots
    },
    -- Wildheart Belt
    ["16716"] = {
        226712, -- Wildheart Belt
    },
    -- Wildheart Gloves
    ["16717"] = {
        226711, -- Wildheart Gloves
    },
    -- Wildheart Spaulders
    ["16718"] = {
        226710, -- Wildheart Spaulders
    },
    -- Wildheart Kilt
    ["16719"] = {
        226709, -- Wildheart Kilt
    },
    -- Wildheart Cowl
    ["16720"] = {
        226708, -- Wildheart Cowl
    },
    -- Shadowcraft Tunic
    ["16721"] = {
        226700, -- Shadowcraft Tunic
    },
    -- Lightforge Bracers
    ["16722"] = {
        226739, -- Lightforge Bracers
    },
    -- Lightforge Belt
    ["16723"] = {
        226732, -- Lightforge Belt
    },
    -- Lightforge Gauntlets
    ["16724"] = {
        226737, -- Lightforge Gauntlets
    },
    -- Lightforge Boots
    ["16725"] = {
        226738, -- Lightforge Boots
    },
    -- Lightforge Breastplate
    ["16726"] = {
        226734, -- Lightforge Breastplate
    },
    -- Lightforge Helm
    ["16727"] = {
        226733, -- Lightforge Helm
    },
    -- Lightforge Legplates
    ["16728"] = {
        226736, -- Lightforge Legplates
    },
    -- Lightforge Spaulders
    ["16729"] = {
        226735, -- Lightforge Spaulders
    },
    -- Breastplate of Valor
    ["16730"] = {
        226770, -- Breastplate of Valor
    },
    -- Helm of Valor
    ["16731"] = {
        226769, -- Helm of Valor
    },
    -- Legplates of Valor
    ["16732"] = {
        226767, -- Legplates of Valor
    },
    -- Spaulders of Valor
    ["16733"] = {
        226768, -- Spaulders of Valor
    },
    -- Boots of Valor
    ["16734"] = {
        226764, -- Boots of Valor
    },
    -- Bracers of Valor
    ["16735"] = {
        226766, -- Bracers of Valor
    },
    -- Belt of Valor
    ["16736"] = {
        226765, -- Belt of Valor
    },
    -- Gauntlets of Valor
    ["16737"] = {
        226771, -- Gauntlets of Valor
    },
    -- Fathom Core
    ["16762"] = {
        204270, -- Fathom Core
    },
    -- Furbolg Medicine Pouch
    ["16768"] = {
        227812, -- Furbolg Medicine Pouch
    },
    -- Strange Water Globe
    ["16782"] = {
        211454, -- Strange Water Globe
    },
    -- Arcanist Crown
    ["16795"] = {
        226562, -- Arcanist Crown
    },
    -- Arcanist Leggings
    ["16796"] = {
        226561, -- Arcanist Leggings
    },
    -- Arcanist Mantle
    ["16797"] = {
        226560, -- Arcanist Mantle
    },
    -- Arcanist Robes
    ["16798"] = {
        226559, -- Arcanist Robes
    },
    -- Arcanist Bindings
    ["16799"] = {
        226558, -- Arcanist Bindings
    },
    -- Arcanist Boots
    ["16800"] = {
        226557, -- Arcanist Boots
    },
    -- Arcanist Gloves
    ["16801"] = {
        226556, -- Arcanist Gloves
    },
    -- Arcanist Belt
    ["16802"] = {
        226555, -- Arcanist Belt
    },
    -- Felheart Slippers
    ["16803"] = {
        226554, -- Felheart Slippers
    },
    -- Felheart Bracers
    ["16804"] = {
        226553, -- Felheart Bracers
    },
    -- Felheart Gloves
    ["16805"] = {
        226552, -- Felheart Gloves
    },
    -- Felheart Belt
    ["16806"] = {
        226551, -- Felheart Belt
    },
    -- Felheart Shoulder Pads
    ["16807"] = {
        226550, -- Felheart Shoulder Pads
    },
    -- Felheart Horns
    ["16808"] = {
        226549, -- Felheart Horns
    },
    -- Felheart Robes
    ["16809"] = {
        226548, -- Felheart Robes
    },
    -- Felheart Pants
    ["16810"] = {
        226547, -- Felheart Pants
    },
    -- Boots of Prophecy
    ["16811"] = {
        226571, -- Boots of Prophecy
    },
    -- Gloves of Prophecy
    ["16812"] = {
        226572, -- Gloves of Prophecy
    },
    -- Circlet of Prophecy
    ["16813"] = {
        226573, -- Circlet of Prophecy
    },
    -- Pants of Prophecy
    ["16814"] = {
        226574, -- Pants of Prophecy
    },
    -- Robes of Prophecy
    ["16815"] = {
        226575, -- Robes of Prophecy
    },
    -- Mantle of Prophecy
    ["16816"] = {
        226576, -- Mantle of Prophecy
    },
    -- Girdle of Prophecy
    ["16817"] = {
        226577, -- Girdle of Prophecy
    },
    -- Netherwind Belt
    ["16818"] = {
        231100, -- Netherwind Belt
    },
    -- Vambraces of Prophecy
    ["16819"] = {
        226578, -- Vambraces of Prophecy
    },
    -- Nightslayer Chestpiece
    ["16820"] = {
        226447, -- Nightslayer Chestpiece
    },
    -- Nightslayer Cover
    ["16821"] = {
        226446, -- Nightslayer Cover
    },
    -- Nightslayer Pants
    ["16822"] = {
        226445, -- Nightslayer Pants
    },
    -- Nightslayer Shoulder Pads
    ["16823"] = {
        226444, -- Nightslayer Shoulder Pads
    },
    -- Nightslayer Boots
    ["16824"] = {
        226443, -- Nightslayer Boots
    },
    -- Nightslayer Bracelets
    ["16825"] = {
        226442, -- Nightslayer Bracelets
    },
    -- Nightslayer Gloves
    ["16826"] = {
        226441, -- Nightslayer Gloves
    },
    -- Nightslayer Belt
    ["16827"] = {
        226440, -- Nightslayer Belt
    },
    -- Cenarion Belt
    ["16828"] = {
        226650, -- Cenarion Belt
    },
    -- Cenarion Boots
    ["16829"] = {
        226645, -- Cenarion Boots
    },
    -- Cenarion Bracers
    ["16830"] = {
        226649, -- Cenarion Bracers
    },
    -- Cenarion Gloves
    ["16831"] = {
        226648, -- Cenarion Gloves
    },
    -- Bloodfang Spaulders
    ["16832"] = {
        231039, -- Bloodfang Spaulders
    },
    -- Cenarion Vestments
    ["16833"] = {
        221785, -- Cenarion Vestments
    },
    -- Cenarion Helm
    ["16834"] = {
        226647, -- Cenarion Helm
    },
    -- Cenarion Leggings
    ["16835"] = {
        226646, -- Cenarion Leggings
    },
    -- Cenarion Spaulders
    ["16836"] = {
        226644, -- Cenarion Spaulders
    },
    -- Earthfury Boots
    ["16837"] = {
        226613, -- Earthfury Boots
    },
    -- Earthfury Belt
    ["16838"] = {
        226616, -- Earthfury Belt
    },
    -- Earthfury Gauntlets
    ["16839"] = {
        226615, -- Earthfury Gauntlets
    },
    -- Earthfury Bracers
    ["16840"] = {
        226618, -- Earthfury Bracers
    },
    -- Earthfury Vestments
    ["16841"] = {
        226617, -- Earthfury Vestments
    },
    -- Earthfury Helmet
    ["16842"] = {
        226612, -- Earthfury Helmet
    },
    -- Earthfury Legguards
    ["16843"] = {
        226614, -- Earthfury Legguards
    },
    -- Earthfury Epaulets
    ["16844"] = {
        226611, -- Earthfury Epaulets
    },
    -- Giantstalker's Breastplate
    ["16845"] = {
        226534, -- Giantstalker's Breastplate
    },
    -- Giantstalker's Helmet
    ["16846"] = {
        226533, -- Giantstalker's Helmet
    },
    -- Giantstalker's Leggings
    ["16847"] = {
        226532, -- Giantstalker's Leggings
    },
    -- Giantstalker's Epaulets
    ["16848"] = {
        226527, -- Giantstalker's Epaulets
    },
    -- Giantstalker's Boots
    ["16849"] = {
        226531, -- Giantstalker's Boots
    },
    -- Giantstalker's Bracers
    ["16850"] = {
        226530, -- Giantstalker's Bracers
    },
    -- Giantstalker's Belt
    ["16851"] = {
        226529, -- Giantstalker's Belt
    },
    -- Giantstalker's Gloves
    ["16852"] = {
        226528, -- Giantstalker's Gloves
    },
    -- Lawbringer Chestguard
    ["16853"] = {
        226595, -- Lawbringer Chestguard
    },
    -- Lawbringer Helm
    ["16854"] = {
        226590, -- Lawbringer Helm
    },
    -- Lawbringer Legplates
    ["16855"] = {
        226594, -- Lawbringer Legplates
    },
    -- Lawbringer Spaulders
    ["16856"] = {
        226588, -- Lawbringer Spaulders
    },
    -- Lawbringer Bracers
    ["16857"] = {
        226589, -- Lawbringer Bracers
    },
    -- Lawbringer Belt
    ["16858"] = {
        226592, -- Lawbringer Belt
    },
    -- Lawbringer Boots
    ["16859"] = {
        226593, -- Lawbringer Boots
    },
    -- Lawbringer Gauntlets
    ["16860"] = {
        226591, -- Lawbringer Gauntlets
    },
    -- Bracers of Might
    ["16861"] = {
        226484, -- Bracers of Might
    },
    -- Sabatons of Might
    ["16862"] = {
        226487, -- Sabatons of Might
    },
    -- Gauntlets of Might
    ["16863"] = {
        226486, -- Gauntlets of Might
    },
    -- Belt of Might
    ["16864"] = {
        226485, -- Belt of Might
    },
    -- Breastplate of Might
    ["16865"] = {
        226489, -- Breastplate of Might
    },
    -- Helm of Might
    ["16866"] = {
        226488, -- Helm of Might
    },
    -- Legplates of Might
    ["16867"] = {
        226490, -- Legplates of Might
    },
    -- Pauldrons of Might
    ["16868"] = {
        226492, -- Pauldrons of Might
    },
    -- Stormrage Chestguard
    ["16897"] = {
        231230, -- Stormrage Chestguard
    },
    -- Stormrage Boots
    ["16898"] = {
        231231, -- Stormrage Boots
    },
    -- Stormrage Handguards
    ["16899"] = {
        231232, -- Stormrage Handguards
    },
    -- Stormrage Cover
    ["16900"] = {
        231233, -- Stormrage Cover
    },
    -- Stormrage Legguards
    ["16901"] = {
        231234, -- Stormrage Legguards
    },
    -- Stormrage Pauldrons
    ["16902"] = {
        231235, -- Stormrage Pauldrons
    },
    -- Stormrage Belt
    ["16903"] = {
        231236, -- Stormrage Belt
    },
    -- Stormrage Bracers
    ["16904"] = {
        231237, -- Stormrage Bracers
    },
    -- Bloodfang Chestpiece
    ["16905"] = {
        231040, -- Bloodfang Chestpiece
    },
    -- Bloodfang Boots
    ["16906"] = {
        231041, -- Bloodfang Boots
    },
    -- Bloodfang Gloves
    ["16907"] = {
        231042, -- Bloodfang Gloves
    },
    -- Bloodfang Hood
    ["16908"] = {
        231043, -- Bloodfang Hood
    },
    -- Bloodfang Pants
    ["16909"] = {
        231044, -- Bloodfang Pants
    },
    -- Bloodfang Belt
    ["16910"] = {
        231045, -- Bloodfang Belt
    },
    -- Bloodfang Bracers
    ["16911"] = {
        231046, -- Bloodfang Bracers
    },
    -- Netherwind Boots
    ["16912"] = {
        231101, -- Netherwind Boots
    },
    -- Netherwind Gloves
    ["16913"] = {
        231102, -- Netherwind Gloves
    },
    -- Netherwind Crown
    ["16914"] = {
        231103, -- Netherwind Crown
    },
    -- Netherwind Pants
    ["16915"] = {
        231104, -- Netherwind Pants
    },
    -- Netherwind Robes
    ["16916"] = {
        231105, -- Netherwind Robes
    },
    -- Netherwind Mantle
    ["16917"] = {
        231106, -- Netherwind Mantle
    },
    -- Netherwind Bindings
    ["16918"] = {
        231107, -- Netherwind Bindings
    },
    -- Boots of Transcendence
    ["16919"] = {
        231155, -- Boots of Transcendence
    },
    -- Handguards of Transcendence
    ["16920"] = {
        231156, -- Handguards of Transcendence
    },
    -- Halo of Transcendence
    ["16921"] = {
        231157, -- Halo of Transcendence
    },
    -- Leggings of Transcendence
    ["16922"] = {
        231158, -- Leggings of Transcendence
    },
    -- Robes of Transcendence
    ["16923"] = {
        231159, -- Robes of Transcendence
    },
    -- Pauldrons of Transcendence
    ["16924"] = {
        231160, -- Pauldrons of Transcendence
    },
    -- Belt of Transcendence
    ["16925"] = {
        231161, -- Belt of Transcendence
    },
    -- Bindings of Transcendence
    ["16926"] = {
        231162, -- Bindings of Transcendence
    },
    -- Nemesis Boots
    ["16927"] = {
        231072, -- Nemesis Boots
    },
    -- Nemesis Gloves
    ["16928"] = {
        231073, -- Nemesis Gloves
    },
    -- Nemesis Skullcap
    ["16929"] = {
        231074, -- Nemesis Skullcap
    },
    -- Nemesis Leggings
    ["16930"] = {
        231075, -- Nemesis Leggings
    },
    -- Nemesis Robes
    ["16931"] = {
        231076, -- Nemesis Robes
    },
    -- Nemesis Spaulders
    ["16932"] = {
        231077, -- Nemesis Spaulders
    },
    -- Nemesis Belt
    ["16933"] = {
        231078, -- Nemesis Belt
    },
    -- Nemesis Bracers
    ["16934"] = {
        231079, -- Nemesis Bracers
    },
    -- Dragonstalker's Bracers
    ["16935"] = {
        231055, -- Dragonstalker's Bracers
    },
    -- Dragonstalker's Belt
    ["16936"] = {
        231056, -- Dragonstalker's Belt
    },
    -- Dragonstalker's Spaulders
    ["16937"] = {
        231057, -- Dragonstalker's Spaulders
    },
    -- Dragonstalker's Legguards
    ["16938"] = {
        231058, -- Dragonstalker's Legguards
    },
    -- Dragonstalker's Helm
    ["16939"] = {
        231059, -- Dragonstalker's Helm
    },
    -- Dragonstalker's Gauntlets
    ["16940"] = {
        231060, -- Dragonstalker's Gauntlets
    },
    -- Dragonstalker's Greaves
    ["16941"] = {
        231061, -- Dragonstalker's Greaves
    },
    -- Dragonstalker's Breastplate
    ["16942"] = {
        231062, -- Dragonstalker's Breastplate
    },
    -- Bracers of Ten Storms
    ["16943"] = {
        231199, -- Bracers of Ten Storms
    },
    -- Belt of Ten Storms
    ["16944"] = {
        231200, -- Belt of Ten Storms
    },
    -- Epaulets of Ten Storms
    ["16945"] = {
        231201, -- Epaulets of Ten Storms
    },
    -- Legplates of Ten Storms
    ["16946"] = {
        231202, -- Legplates of Ten Storms
    },
    -- Helmet of Ten Storms
    ["16947"] = {
        231203, -- Helmet of Ten Storms
    },
    -- Gauntlets of Ten Storms
    ["16948"] = {
        231198, -- Gauntlets of Ten Storms
    },
    -- Greaves of Ten Storms
    ["16949"] = {
        232213, -- Greaves of Ten Storms
    },
    -- Breastplate of Ten Storms
    ["16950"] = {
        231205, -- Breastplate of Ten Storms
    },
    -- Judgement Bindings
    ["16951"] = {
        231174, -- Judgement Bindings
    },
    -- Judgement Belt
    ["16952"] = {
        231175, -- Judgement Belt
    },
    -- Judgement Spaulders
    ["16953"] = {
        231176, -- Judgement Spaulders
    },
    -- Judgement Legplates
    ["16954"] = {
        231177, -- Judgement Legplates
    },
    -- Judgement Crown
    ["16955"] = {
        231178, -- Judgement Crown
    },
    -- Judgement Gauntlets
    ["16956"] = {
        231179, -- Judgement Gauntlets
    },
    -- Judgement Sabatons
    ["16957"] = {
        231180, -- Judgement Sabatons
    },
    -- Judgement Breastplate
    ["16958"] = {
        231181, -- Judgement Breastplate
    },
    -- Bracelets of Wrath
    ["16959"] = {
        231715, -- Primeval Bindings
    },
    -- Waistband of Wrath
    ["16960"] = {
        231716, -- Primeval Belt
    },
    -- Pauldrons of Wrath
    ["16961"] = {
        231025, -- Pauldrons of Wrath
    },
    -- Legplates of Wrath
    ["16962"] = {
        231034, -- Legplates of Wrath
    },
    -- Helm of Wrath
    ["16963"] = {
        231035, -- Helm of Wrath
    },
    -- Gauntlets of Wrath
    ["16964"] = {
        231036, -- Gauntlets of Wrath
    },
    -- Sabatons of Wrath
    ["16965"] = {
        231029, -- Sabatons of Wrath
    },
    -- Breastplate of Wrath
    ["16966"] = {
        231038, -- Breastplate of Wrath
    },
    -- Band of Accuria
    ["17063"] = {
        228286, -- Band of Accuria
    },
    -- Shard of the Scale
    ["17064"] = {
        228298, -- Shard of the Scale
    },
    -- Medallion of Steadfast Might
    ["17065"] = {
        228249, -- Medallion of Steadfast Might
    },
    -- Drillborer Disk
    ["17066"] = {
        228702, -- Drillborer Disk
    },
    -- Ancient Cornerstone Grimoire
    ["17067"] = {
        228955, -- Ancient Cornerstone Grimoire
    },
    -- Striker's Mark
    ["17069"] = {
        228252, -- Striker's Mark
    },
    -- Fang of the Mystics
    ["17070"] = {
        228382, -- Fang of the Mystics
    },
    -- Gutgore Ripper
    ["17071"] = {
        228267, -- Gutgore Ripper
    },
    -- Blastershot Launcher
    ["17072"] = {
        228270, -- Blastershot Launcher
    },
    -- Earthshaker
    ["17073"] = {
        228248, -- Earthshaker
    },
    -- Shadowstrike
    ["17074"] = {
        228272, -- Shadowstrike
    },
    -- Bonereaver's Edge
    ["17076"] = {
        228461, -- Bonereaver's Edge
    },
    -- Crimson Shocker
    ["17077"] = {
        228262, -- Crimson Shocker
    },
    -- Shard of the Flame
    ["17082"] = {
        228297, -- Shard of the Flame
    },
    -- Cloak of the Shrouded Mists
    ["17102"] = {
        228290, -- Cloak of the Shrouded Mists
    },
    -- Azuresong Mageblade
    ["17103"] = {
        228269, -- Azuresong Mageblade
    },
    -- Spinal Reaper
    ["17104"] = {
        228299, -- Spinal Reaper
    },
    -- Aurastone Hammer
    ["17105"] = {
        228462, -- Aurastone Hammer
    },
    -- Malistar's Defender
    ["17106"] = {
        228294, -- Malistar's Defender
    },
    -- Dragon's Blood Cape
    ["17107"] = {
        228292, -- Dragon's Blood Cape
    },
    -- Choker of Enlightenment
    ["17109"] = {
        228247, -- Choker of Enlightenment
    },
    -- Seal of the Archmagus
    ["17110"] = {
        228268, -- Seal of the Archmagus
    },
    -- Blazefury Medallion
    ["17111"] = {
        228354, -- Blazefury Medallion
    },
    -- Empyrean Demolisher
    ["17112"] = {
        228397, -- Empyrean Demolisher
    },
    -- Amberseal Keeper
    ["17113"] = {
        228356, -- Amberseal Keeper
    },
    -- Sulfuras, Hand of Ragnaros
    ["17182"] = {
        17204, -- Eye of Sulfuras
    },
    -- Sulfuron Hammer
    ["17193"] = {
        227684, -- Sulfuron Hammer
    },
    -- Eye of Sulfuras
    ["17204"] = {
        17182, -- Sulfuras, Hand of Ragnaros
    },
    -- Thunderstrike
    ["17223"] = {
        228273, -- Thunderstrike
    },
    -- Field Marshal's Coronal
    ["17578"] = {
        231584, -- Field Marshal's Coronal
    },
    -- Marshal's Dreadweave Leggings
    ["17579"] = {
        231587, -- Marshal's Dreadweave Leggings
    },
    -- Field Marshal's Dreadweave Shoulders
    ["17580"] = {
        231583, -- Field Marshal's Dreadweave Shoulders
    },
    -- Field Marshal's Dreadweave Robe
    ["17581"] = {
        231582, -- Field Marshal's Dreadweave Robe
    },
    -- Marshal's Dreadweave Boots
    ["17583"] = {
        231585, -- Marshal's Dreadweave Boots
    },
    -- Marshal's Dreadweave Gloves
    ["17584"] = {
        231586, -- Marshal's Dreadweave Gloves
    },
    -- General's Dreadweave Boots
    ["17586"] = {
        231593, -- General's Dreadweave Boots
    },
    -- General's Dreadweave Gloves
    ["17588"] = {
        231589, -- General's Dreadweave Gloves
    },
    -- Warlord's Dreadweave Mantle
    ["17590"] = {
        231592, -- Warlord's Dreadweave Mantle
    },
    -- Warlord's Dreadweave Hood
    ["17591"] = {
        231590, -- Warlord's Dreadweave Hood
    },
    -- Warlord's Dreadweave Robe
    ["17592"] = {
        231591, -- Warlord's Dreadweave Robe
    },
    -- General's Dreadweave Pants
    ["17593"] = {
        231588, -- General's Dreadweave Pants
    },
    -- Knight-Captain's Satin Leggings
    ["17599"] = {
        227137, -- Knight-Captain's Satin Leggings
    },
    -- Field Marshal's Satin Mantle
    ["17604"] = {
        231628, -- Field Marshal's Satin Mantle
    },
    -- Warlord's Satin Mantle
    ["17622"] = {
        231631, -- Warlord's Satin Mantle
    },
    -- Warlord's Satin Robes
    ["17624"] = {
        231612, -- Warlord's Satin Robes
    },
    -- General's Satin Leggings
    ["17625"] = {
        231614, -- General's Satin Leggings
    },
    -- Gemshard Heart
    ["17707"] = {
        223541, -- Gemshard Heart
    },
    -- Charstone Dirk
    ["17710"] = {
        223518, -- Charstone Dirk
    },
    -- Eye of Theradras
    ["17715"] = {
        223519, -- Eye of Theradras
    },
    -- Megashot Rifle
    ["17717"] = {
        223542, -- Megashot Rifle
    },
    -- Gizlock's Hypertech Buckler
    ["17718"] = {
        223545, -- Gizlock's Hypertech Buckler
    },
    -- Inventor's Focal Sword
    ["17719"] = {
        223520, -- Inventor's Focal Sword
    },
    -- Rotgrip Mantle
    ["17732"] = {
        223521, -- Rotgrip Mantle
    },
    -- Fist of Stone
    ["17733"] = {
        223524, -- Fist of Stone
    },
    -- Helm of the Mountain
    ["17734"] = {
        223522, -- Helm of the Mountain
    },
    -- Cloud Stone
    ["17737"] = {
        223523, -- Cloud Stone
    },
    -- Soothsayer's Headdress
    ["17740"] = {
        223525, -- Soothsayer's Headdress
    },
    -- Vinerot Sandals
    ["17748"] = {
        223543, -- Vinerot Sandals
    },
    -- Princess Theradras' Scepter
    ["17766"] = {
        221780, -- Princess Theradras' Scepter
    },
    -- Blade of Eternal Darkness
    ["17780"] = {
        223964, -- Blade of Eternal Darkness
    },
    -- Fist of Stone
    ["17943"] = {
        223524, -- Fist of Stone
    },
    -- Onyxia Hide Backpack
    ["17966"] = {
        228992, -- Onyxia Hide Backpack
    },
    -- Flame Walkers
    ["18047"] = {
        228602, -- Flame Walkers
    },
    -- Jumanza Grips
    ["18083"] = {
        223534, -- Jumanza Grips
    },
    -- Band of Rumination
    ["18103"] = {
        228675, -- Band of Rumination
    },
    -- Feralsurge Girdle
    ["18104"] = {
        228676, -- Feralsurge Girdle
    },
    -- Eskhandar's Left Claw
    ["18202"] = {
        228349, -- Eskhandar's Left Claw
    },
    -- Eskhandar's Right Claw
    ["18203"] = {
        228350, -- Eskhandar's Right Claw
    },
    -- Eskhandar's Pelt
    ["18204"] = {
        228360, -- Eskhandar's Pelt
    },
    -- Eskhandar's Collar
    ["18205"] = {
        228759, -- Eskhandar's Collar
    },
    -- Drape of Benediction
    ["18208"] = {
        228389, -- Drape of Benediction
    },
    -- Fiendish Machete
    ["18310"] = {
        228056, -- Fiendish Machete
    },
    -- Quel'dorai Channeling Rod
    ["18311"] = {
        228051, -- Quel'dorai Channeling Rod
    },
    -- Energized Chestplate
    ["18312"] = {
        228055, -- Energized Chestplate
    },
    -- Ring of Demonic Guile
    ["18314"] = {
        228699, -- Ring of Demonic Guile
    },
    -- Ring of Demonic Potency
    ["18315"] = {
        228057, -- Ring of Demonic Potency
    },
    -- Tempest Talisman
    ["18317"] = {
        228054, -- Tempest Talisman
    },
    -- Fervent Helm
    ["18319"] = {
        228053, -- Fervent Helm
    },
    -- Satyr's Bow
    ["18323"] = {
        228050, -- Satyr's Bow
    },
    -- Waveslicer
    ["18324"] = {
        228052, -- Waveslicer
    },
    -- Quel'Serrar
    ["18348"] = {
        228679, -- Quel'Serrar
    },
    -- Garona: A Study on Stealth and Treachery
    ["18356"] = {
        228691, -- Garona: A Study on Stealth and Treachery
    },
    -- Codex of Defense
    ["18357"] = {
        228692, -- Codex of Defense
    },
    -- The Arcanist's Cookbook
    ["18358"] = {
        228693, -- The Arcanist's Cookbook
    },
    -- The Light and How to Swing It
    ["18359"] = {
        228690, -- The Light and How to Swing It
    },
    -- Silvermoon Leggings
    ["18378"] = {
        228470, -- Silvermoon Leggings
    },
    -- Eldritch Reinforced Legplates
    ["18380"] = {
        228069, -- Eldritch Reinforced Legplates
    },
    -- Brightspark Gloves
    ["18387"] = {
        228061, -- Brightspark Gloves
    },
    -- Stoneshatter
    ["18388"] = {
        228471, -- Stoneshatter
    },
    -- Tanglemoss Leggings
    ["18390"] = {
        228468, -- Tanglemoss Leggings
    },
    -- Distracting Dagger
    ["18392"] = {
        228472, -- Distracting Dagger
    },
    -- Warpwood Binding
    ["18393"] = {
        228063, -- Warpwood Binding
    },
    -- Elder Magus Pendant
    ["18397"] = {
        228067, -- Elder Magus Pendant
    },
    -- Tidal Loop
    ["18398"] = {
        227454, -- Tidal Loop
    },
    -- Ocean's Breeze
    ["18399"] = {
        227455, -- Ocean's Breeze
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
    -- First Sergeant's Plate Bracers
    ["18429"] = {
        216705, -- First Sergeant's Plate Bracers
    },
    -- First Sergeant's Plate Bracers
    ["18430"] = {
        216705, -- First Sergeant's Plate Bracers
    },
    -- First Sergeant's Mail Wristguards
    ["18432"] = {
        216703, -- First Sergeant's Mail Wristguards
    },
    -- First Sergeant's Dragonhide Armguards
    ["18434"] = {
        216704, -- First Sergeant's Dragonhide Armguards
    },
    -- First Sergeant's Leather Armguards
    ["18435"] = {
        216706, -- First Sergeant's Leather Armguards
    },
    -- First Sergeant's Dragonhide Armguards
    ["18436"] = {
        216704, -- First Sergeant's Dragonhide Armguards
    },
    -- First Sergeant's Silk Cuffs
    ["18437"] = {
        216707, -- First Sergeant's Silk Cuffs
    },
    -- Sergeant Major's Plate Wristguards
    ["18445"] = {
        216701, -- Sergeant Major's Plate Wristguards
    },
    -- Sergeant Major's Plate Wristguards
    ["18447"] = {
        216701, -- Sergeant Major's Plate Wristguards
    },
    -- Sergeant Major's Chain Armguards
    ["18448"] = {
        216699, -- Sergeant Major's Chain Armguards
    },
    -- Sergeant Major's Chain Armguards
    ["18449"] = {
        216699, -- Sergeant Major's Chain Armguards
    },
    -- Sergeant Major's Leather Armsplints
    ["18452"] = {
        216700, -- Sergeant Major's Leather Armsplints
    },
    -- Sergeant Major's Leather Armsplints
    ["18453"] = {
        216700, -- Sergeant Major's Leather Armsplints
    },
    -- Sergeant Major's Dragonhide Armsplints
    ["18454"] = {
        216698, -- Sergeant Major's Dragonhide Armsplints
    },
    -- Sergeant Major's Dragonhide Armsplints
    ["18455"] = {
        216698, -- Sergeant Major's Dragonhide Armsplints
    },
    -- Sergeant Major's Silk Cuffs
    ["18456"] = {
        216702, -- Sergeant Major's Silk Cuffs
    },
    -- Sergeant Major's Silk Cuffs
    ["18457"] = {
        216702, -- Sergeant Major's Silk Cuffs
    },
    -- Royal Seal of Eldre'Thalas
    ["18465"] = {
        228467, -- Royal Seal of Eldre'Thalas
    },
    -- Royal Seal of Eldre'Thalas
    ["18466"] = {
        228467, -- Royal Seal of Eldre'Thalas
    },
    -- Royal Seal of Eldre'Thalas
    ["18467"] = {
        228467, -- Royal Seal of Eldre'Thalas
    },
    -- Royal Seal of Eldre'Thalas
    ["18468"] = {
        228467, -- Royal Seal of Eldre'Thalas
    },
    -- Royal Seal of Eldre'Thalas
    ["18469"] = {
        228467, -- Royal Seal of Eldre'Thalas
    },
    -- Royal Seal of Eldre'Thalas
    ["18470"] = {
        228467, -- Royal Seal of Eldre'Thalas
    },
    -- Royal Seal of Eldre'Thalas
    ["18471"] = {
        228467, -- Royal Seal of Eldre'Thalas
    },
    -- Royal Seal of Eldre'Thalas
    ["18472"] = {
        228467, -- Royal Seal of Eldre'Thalas
    },
    -- Royal Seal of Eldre'Thalas
    ["18473"] = {
        228467, -- Royal Seal of Eldre'Thalas
    },
    -- Observer's Shield
    ["18485"] = {
        228064, -- Observer's Shield
    },
    -- Heated Ancient Blade
    ["18488"] = {
        228696, -- Heated Ancient Blade
    },
    -- Insightful Hood
    ["18490"] = {
        228062, -- Insightful Hood
    },
    -- Treated Ancient Blade
    ["18492"] = {
        228697, -- Treated Ancient Blade
    },
    -- Bulky Iron Spaulders
    ["18493"] = {
        228058, -- Bulky Iron Spaulders
    },
    -- Denwatcher's Shoulders
    ["18494"] = {
        228059, -- Denwatcher's Shoulders
    },
    -- Heliotrope Cloak
    ["18496"] = {
        228060, -- Heliotrope Cloak
    },
    -- Tarnished Elven Ring
    ["18500"] = {
        228469, -- Tarnished Elven Ring
    },
    -- Mugger's Belt
    ["18505"] = {
        228068, -- Mugger's Belt
    },
    -- A Dull and Flat Elven Blade
    ["18513"] = {
        228695, -- A Dull and Flat Elven Blade
    },
    -- Barbarous Blade
    ["18520"] = {
        228478, -- Barbarous Blade
    },
    -- Leggings of Destruction
    ["18524"] = {
        228479, -- Leggings of Destruction
    },
    -- Crown of the Ogre King
    ["18526"] = {
        228480, -- Crown of the Ogre King
    },
    -- Cyclone Spaulders
    ["18528"] = {
        228065, -- Cyclone Spaulders
    },
    -- Ogre Forged Hauberk
    ["18530"] = {
        228070, -- Ogre Forged Hauberk
    },
    -- Unyielding Maul
    ["18531"] = {
        228473, -- Unyielding Maul
    },
    -- Mindsurge Robe
    ["18532"] = {
        228474, -- Mindsurge Robe
    },
    -- Rod of the Ogre Magi
    ["18534"] = {
        228484, -- Rod of the Ogre Magi
    },
    -- Treant's Bane
    ["18538"] = {
        228486, -- Treant's Bane
    },
    -- Puissant Cape
    ["18541"] = {
        228383, -- Puissant Cape
    },
    -- Typhoon
    ["18542"] = {
        228347, -- Typhoon
    },
    -- Ring of Entropy
    ["18543"] = {
        228359, -- Ring of Entropy
    },
    -- Doomhide Gauntlets
    ["18544"] = {
        228351, -- Doomhide Gauntlets
    },
    -- Leggings of Arcane Supremacy
    ["18545"] = {
        228345, -- Leggings of Arcane Supremacy
    },
    -- Infernal Headcage
    ["18546"] = {
        228353, -- Infernal Headcage
    },
    -- Unmelting Ice Girdle
    ["18547"] = {
        228340, -- Unmelting Ice Girdle
    },
    -- Bindings of the Windseeker
    ["18564"] = {
        19019, -- Thunderfury, Blessed Blade of the Windseeker
    },
    -- Plans: Sulfuron Hammer
    ["18592"] = {
        227727, -- Plans: Sulfuron Hammer
    },
    -- Benediction
    ["18608"] = {
        18646, -- The Eye of Divinity
    },
    -- Anathema
    ["18609"] = {
        18646, -- The Eye of Divinity
    },
    -- Thorium Brotherhood Contract
    ["18628"] = {
        227730, -- Thorium Brotherhood Contract
    },
    -- The Eye of Divinity
    ["18646"] = {
        18608, -- Benediction
        18609, -- Anathema
        228335, -- Benediction
        228336, -- Anathema
    },
    -- Splinter of Nordrassil
    ["18659"] = {
        228749, -- Splinter of Nordrassil
    },
    -- Ancient Bone Bow
    ["18680"] = {
        227996, -- Ancient Bone Bow
    },
    -- Dimly Opalescent Ring
    ["18684"] = {
        228016, -- Dimly Opalescent Ring
    },
    -- Wraithplate Leggings
    ["18690"] = {
        228041, -- Wraithplate Leggings
    },
    -- Death Knight Sabatons
    ["18692"] = {
        227992, -- Death Knight Sabatons
    },
    -- Shivery Handwraps
    ["18693"] = {
        228034, -- Shivery Handwraps
    },
    -- Spellbound Tome
    ["18695"] = {
        228039, -- Spellbound Tome
    },
    -- Coldstone Slippers
    ["18697"] = {
        228703, -- Coldstone Slippers
    },
    -- Tattered Leather Hood
    ["18698"] = {
        228704, -- Tattered Leather Hood
    },
    -- Ancient Petrified Leaf
    ["18703"] = {
        18713, -- Rhok'delar, Longbow of the Ancient Keepers
        18714, -- Ancient Sinew Wrapped Lamina
        18715, -- Lok'delar, Stave of the Ancient Keepers
        228332, -- Lok'delar, Stave of the Ancient Keepers
        228334, -- Rhok'delar, Longbow of the Ancient Keepers
    },
    -- Ancient Rune Etched Stave
    ["18707"] = {
        228659, -- Ancient Rune Etched Stave
    },
    -- Rhok'delar, Longbow of the Ancient Keepers
    ["18713"] = {
        18703, -- Ancient Petrified Leaf
    },
    -- Ancient Sinew Wrapped Lamina
    ["18714"] = {
        18703, -- Ancient Petrified Leaf
    },
    -- Lok'delar, Stave of the Ancient Keepers
    ["18715"] = {
        18703, -- Ancient Petrified Leaf
    },
    -- Hammer of the Grand Crusader
    ["18717"] = {
        228544, -- Hammer of the Grand Crusader
    },
    -- Grand Crusader's Helm
    ["18718"] = {
        228545, -- Grand Crusader's Helm
    },
    -- Shroud of the Nathrezim
    ["18720"] = {
        228546, -- Shroud of the Nathrezim
    },
    -- Peacemaker
    ["18725"] = {
        228516, -- Peacemaker
    },
    -- Magistrate's Cuffs
    ["18726"] = {
        228518, -- Magistrate's Cuffs
    },
    -- Shadowy Laced Handwraps
    ["18730"] = {
        228521, -- Shadowy Laced Handwraps
    },
    -- Plaguehound Leggings
    ["18736"] = {
        228534, -- Plaguehound Leggings
    },
    -- Bone Slicing Hatchet
    ["18737"] = {
        228535, -- Bone Slicing Hatchet
    },
    -- Chitinous Plate Legguards
    ["18739"] = {
        228530, -- Chitinous Plate Legguards
    },
    -- Thuzadin Sash
    ["18740"] = {
        228531, -- Thuzadin Sash
    },
    -- Morlune's Bracer
    ["18741"] = {
        228532, -- Morlune's Bracer
    },
    -- Diabolic Mantle
    ["18757"] = {
        228475, -- Diabolic Mantle
    },
    -- Malicious Axe
    ["18759"] = {
        228030, -- Malicious Axe
    },
    -- Necromantic Band
    ["18760"] = {
        228045, -- Necromantic Band
    },
    -- Hyperthermically Insulated Lava Dredger
    ["18803"] = {
        228278, -- Hyperthermically Insulated Lava Dredger
    },
    -- Core Hound Tooth
    ["18805"] = {
        228277, -- Core Hound Tooth
    },
    -- Core Forged Greaves
    ["18806"] = {
        228275, -- Core Forged Greaves
    },
    -- Gloves of the Hypnotic Flame
    ["18808"] = {
        228281, -- Gloves of the Hypnotic Flame
    },
    -- Sash of Whispered Secrets
    ["18809"] = {
        228282, -- Sash of Whispered Secrets
    },
    -- Wild Growth Spaulders
    ["18810"] = {
        228283, -- Wild Growth Spaulders
    },
    -- Fireproof Cloak
    ["18811"] = {
        228280, -- Fireproof Cloak
    },
    -- Wristguards of True Flight
    ["18812"] = {
        228284, -- Wristguards of True Flight
    },
    -- Choker of the Fire Lord
    ["18814"] = {
        228289, -- Choker of the Fire Lord
    },
    -- Essence of the Pure Flame
    ["18815"] = {
        228293, -- Essence of the Pure Flame
    },
    -- Perdition's Blade
    ["18816"] = {
        228296, -- Perdition's Blade
    },
    -- Crown of Destruction
    ["18817"] = {
        228291, -- Crown of Destruction
    },
    -- Talisman of Ephemeral Power
    ["18820"] = {
        228255, -- Talisman of Ephemeral Power
    },
    -- Quick Strike Ring
    ["18821"] = {
        228261, -- Quick Strike Ring
    },
    -- Obsidian Edged Blade
    ["18822"] = {
        228459, -- Obsidian Edged Blade
    },
    -- Aged Core Leather Gloves
    ["18823"] = {
        228257, -- Aged Core Leather Gloves
    },
    -- Magma Tempered Boots
    ["18824"] = {
        228254, -- Magma Tempered Boots
    },
    -- Grand Marshal's Aegis
    ["18825"] = {
        234588, -- Grand Marshal's Aegis
    },
    -- High Warlord's Shield Wall
    ["18826"] = {
        234562, -- High Warlord's Shield Wall
    },
    -- Grand Marshal's Handaxe
    ["18827"] = {
        234580, -- Grand Marshal's Handaxe
    },
    -- High Warlord's Cleaver
    ["18828"] = {
        234554, -- High Warlord's Cleaver
    },
    -- Deep Earth Spaulders
    ["18829"] = {
        228258, -- Deep Earth Spaulders
    },
    -- Grand Marshal's Sunderer
    ["18830"] = {
        234566, -- Grand Marshal's Sunderer
    },
    -- High Warlord's Battle Axe
    ["18831"] = {
        234543, -- High Warlord's Battle Axe
    },
    -- Brutality Blade
    ["18832"] = {
        228265, -- Brutality Blade
    },
    -- Grand Marshal's Bullseye
    ["18833"] = {
        234585, -- Grand Marshal's Bullseye
    },
    -- High Warlord's Recurve
    ["18835"] = {
        234559, -- High Warlord's Recurve
    },
    -- Grand Marshal's Repeater
    ["18836"] = {
        234586, -- Grand Marshal's Repeater
    },
    -- High Warlord's Crossbow
    ["18837"] = {
        234560, -- High Warlord's Crossbow
    },
    -- Grand Marshal's Dirk
    ["18838"] = {
        234582, -- Grand Marshal's Dirk
    },
    -- High Warlord's Razor
    ["18840"] = {
        234556, -- High Warlord's Razor
    },
    -- Staff of Dominance
    ["18842"] = {
        228271, -- Staff of Dominance
    },
    -- Grand Marshal's Right Hand Blade
    ["18843"] = {
        234583, -- Grand Marshal's Right Hand Blade
    },
    -- High Warlord's Right Claw
    ["18844"] = {
        234557, -- High Warlord's Right Claw
    },
    -- Grand Marshal's Left Hand Blade
    ["18847"] = {
        234584, -- Grand Marshal's Left Hand Blade
    },
    -- High Warlord's Left Claw
    ["18848"] = {
        234558, -- High Warlord's Left Claw
    },
    -- Grand Marshal's Hand Cannon
    ["18855"] = {
        234587, -- Grand Marshal's Hand Cannon
    },
    -- High Warlord's Street Sweeper
    ["18860"] = {
        234561, -- High Warlord's Street Sweeper
    },
    -- Flamewaker Legplates
    ["18861"] = {
        228240, -- Flamewaker Legplates
    },
    -- Grand Marshal's Punisher
    ["18865"] = {
        234581, -- Grand Marshal's Punisher
    },
    -- High Warlord's Bludgeon
    ["18866"] = {
        234555, -- High Warlord's Bludgeon
    },
    -- Grand Marshal's Battle Hammer
    ["18867"] = {
        234567, -- Grand Marshal's Battle Hammer
    },
    -- High Warlord's Pulverizer
    ["18868"] = {
        234545, -- High Warlord's Pulverizer
    },
    -- Grand Marshal's Glaive
    ["18869"] = {
        234569, -- Grand Marshal's Glaive
    },
    -- Helm of the Lifegiver
    ["18870"] = {
        228285, -- Helm of the Lifegiver
    },
    -- High Warlord's Pig Sticker
    ["18871"] = {
        234547, -- High Warlord's Pig Sticker
    },
    -- Manastorm Leggings
    ["18872"] = {
        228244, -- Manastorm Leggings
    },
    -- Grand Marshal's Stave
    ["18873"] = {
        234571, -- Grand Marshal's Stave
    },
    -- High Warlord's War Staff
    ["18874"] = {
        234549, -- High Warlord's War Staff
    },
    -- Salamander Scale Pants
    ["18875"] = {
        228245, -- Salamander Scale Pants
    },
    -- Grand Marshal's Claymore
    ["18876"] = {
        234565, -- Grand Marshal's Claymore
    },
    -- High Warlord's Greatsword
    ["18877"] = {
        234542, -- High Warlord's Greatsword
    },
    -- Sorcerous Dagger
    ["18878"] = {
        228263, -- Sorcerous Dagger
    },
    -- Heavy Dark Iron Ring
    ["18879"] = {
        228242, -- Heavy Dark Iron Ring
    },
    -- Head of Nefarian
    ["19002"] = {
        19003, -- Head of Nefarian (Alliance)
        19366, -- Master Dragonslayer's Orb
        19383, -- Master Dragonslayer's Medallion
        19384, -- Master Dragonslayer's Ring
        230839, -- Master Dragonslayer's Ring
        230840, -- Master Dragonslayer's Medallion
        230841, -- Master Dragonslayer's Orb
    },
    -- Head of Nefarian (Alliance)
    ["19003"] = {
        19002, -- Head of Nefarian (Horde)
        19366, -- Master Dragonslayer's Orb
        19383, -- Master Dragonslayer's Medallion
        19384, -- Master Dragonslayer's Ring
    },
    -- Vessel of Rebirth
    ["19016"] = {
        231382, -- Vessel of Rebirth
    },
    -- Dormant Wind Kissed Blade
    ["19018"] = {
        232018, -- Dormant Wind Kissed Blade
    },
    -- Thunderfury, Blessed Blade of the Windseeker
    ["19019"] = {
        18564, -- Bindings of the Windseeker
    },
    -- Wisdom of the Timbermaw
    ["19047"] = {
        227806, -- Wisdom of the Timbermaw
    },
    -- Cold Snap
    ["19130"] = {
        228381, -- Cold Snap
    },
    -- Snowblind Shoes
    ["19131"] = {
        228384, -- Snowblind Shoes
    },
    -- Crystal Adorned Crown
    ["19132"] = {
        228385, -- Crystal Adorned Crown
    },
    -- Fel Infused Leggings
    ["19133"] = {
        228352, -- Fel Infused Leggings
    },
    -- Flayed Doomguard Belt
    ["19134"] = {
        228355, -- Flayed Doomguard Belt
    },
    -- Blacklight Bracer
    ["19135"] = {
        228357, -- Blacklight Bracer
    },
    -- Mana Igniting Cord
    ["19136"] = {
        228256, -- Mana Igniting Cord
    },
    -- Onslaught Girdle
    ["19137"] = {
        228295, -- Onslaught Girdle
    },
    -- Band of Sulfuras
    ["19138"] = {
        228287, -- Band of Sulfuras
    },
    -- Fireguard Shoulders
    ["19139"] = {
        228279, -- Fireguard Shoulders
    },
    -- Cauterizing Band
    ["19140"] = {
        228274, -- Cauterizing Band
    },
    -- Fire Runed Grimoire
    ["19142"] = {
        228259, -- Fire Runed Grimoire
    },
    -- Flameguard Gauntlets
    ["19143"] = {
        228260, -- Flameguard Gauntlets
    },
    -- Sabatons of the Flamewalker
    ["19144"] = {
        228253, -- Sabatons of the Flamewalker
    },
    -- Robe of Volatile Power
    ["19145"] = {
        228239, -- Robe of Volatile Power
    },
    -- Wristguards of Stability
    ["19146"] = {
        228246, -- Wristguards of Stability
    },
    -- Ring of Spell Power
    ["19147"] = {
        228243, -- Ring of Spell Power
    },
    -- Pattern: Argent Boots
    ["19216"] = {
        227896, -- Pattern: Argent Boots
    },
    -- Pattern: Argent Shoulders
    ["19217"] = {
        227897, -- Pattern: Argent Shoulders
    },
    -- Beasts Deck
    ["19228"] = {
        235278, -- Beasts Deck
    },
    -- Warlords Deck
    ["19257"] = {
        235277, -- Warlords Deck
    },
    -- Elementals Deck
    ["19267"] = {
        235276, -- Elementals Deck
    },
    -- Portals Deck
    ["19277"] = {
        235275, -- Portals Deck
    },
    -- Darkmoon Card: Heroism
    ["19287"] = {
        234176, -- Darkmoon Card: Heroism
    },
    -- Darkmoon Card: Blue Dragon
    ["19288"] = {
        234177, -- Darkmoon Card: Blue Dragon
    },
    -- Darkmoon Card: Maelstrom
    ["19289"] = {
        234178, -- Darkmoon Card: Maelstrom
    },
    -- Darkmoon Card: Twisting Nether
    ["19290"] = {
        234179, -- Darkmoon Card: Twisting Nether
    },
    -- Pattern: Golden Mantle of the Dawn
    ["19329"] = {
        227895, -- Pattern: Golden Mantle of the Dawn
    },
    -- The Untamed Blade
    ["19334"] = {
        230242, -- The Untamed Blade
    },
    -- Spineshatter
    ["19335"] = {
        230241, -- Spineshatter
    },
    -- Arcane Infused Gem
    ["19336"] = {
        230237, -- Arcane Infused Gem
    },
    -- The Black Book
    ["19337"] = {
        230238, -- The Black Book
    },
    -- Mind Quickening Gem
    ["19339"] = {
        230243, -- Mind Quickening Gem
    },
    -- Rune of Metamorphosis
    ["19340"] = {
        210980, -- Rune of Metamorphosis
    },
    -- Lifegiving Gem
    ["19341"] = {
        230249, -- Lifegiving Gem
    },
    -- Venomous Totem
    ["19342"] = {
        230250, -- Venomous Totem
    },
    -- Scrolls of Blinding Light
    ["19343"] = {
        230272, -- Scrolls of Blinding Light
    },
    -- Natural Alignment Crystal
    ["19344"] = {
        230273, -- Natural Alignment Crystal
    },
    -- Aegis of Preservation
    ["19345"] = {
        230280, -- Aegis of Preservation
    },
    -- Dragonfang Blade
    ["19346"] = {
        230247, -- Dragonfang Blade
    },
    -- Claw of Chromaggus
    ["19347"] = {
        230794, -- Claw of Chromaggus
    },
    -- Red Dragonscale Protector
    ["19348"] = {
        230248, -- Red Dragonscale Protector
    },
    -- Elementium Reinforced Bulwark
    ["19349"] = {
        230802, -- Elementium Reinforced Bulwark
    },
    -- Heartstriker
    ["19350"] = {
        230253, -- Heartstriker
    },
    -- Maladath, Runed Blade of the Black Flight
    ["19351"] = {
        230254, -- Maladath, Runed Blade of the Black Flight
    },
    -- Chromatically Tempered Sword
    ["19352"] = {
        230747, -- Chromatically Tempered Sword
    },
    -- Drake Talon Cleaver
    ["19353"] = {
        230271, -- Drake Talon Cleaver
    },
    -- Draconic Avenger
    ["19354"] = {
        232357, -- Draconic Avenger
    },
    -- Shadow Wing Focus Staff
    ["19355"] = {
        230270, -- Shadow Wing Focus Staff
    },
    -- Staff of the Shadow Flame
    ["19356"] = {
        230813, -- Staff of the Shadow Flame
    },
    -- Herald of Woe
    ["19357"] = {
        230738, -- Herald of Woe
    },
    -- Draconic Maul
    ["19358"] = {
        230844, -- Draconic Maul
    },
    -- Lok'amir il Romathis
    ["19360"] = {
        230838, -- Lok'amir il Romathis
    },
    -- Ashjre'thul, Crossbow of Smiting
    ["19361"] = {
        230801, -- Ashjre'thul, Crossbow of Smiting
    },
    -- Doom's Edge
    ["19362"] = {
        230845, -- Doom's Edge
    },
    -- Crul'shorukh, Edge of Chaos
    ["19363"] = {
        230837, -- Crul'shorukh, Edge of Chaos
    },
    -- Ashkandi, Greatsword of the Brotherhood
    ["19364"] = {
        230818, -- Ashkandi, Greatsword of the Brotherhood
    },
    -- Claw of the Black Drake
    ["19365"] = {
        230276, -- Claw of the Black Drake
    },
    -- Master Dragonslayer's Orb
    ["19366"] = {
        19002, -- Head of Nefarian
    },
    -- Dragon's Touch
    ["19367"] = {
        230737, -- Dragon's Touch
    },
    -- Dragonbreath Hand Cannon
    ["19368"] = {
        230726, -- Dragonbreath Hand Cannon
    },
    -- Gloves of Rapid Evolution
    ["19369"] = {
        230239, -- Gloves of Rapid Evolution
    },
    -- Mantle of the Blackwing Cabal
    ["19370"] = {
        230240, -- Mantle of the Blackwing Cabal
    },
    -- Pendant of the Fallen Dragon
    ["19371"] = {
        230245, -- Pendant of the Fallen Dragon
    },
    -- Helm of Endless Rage
    ["19372"] = {
        230246, -- Helm of Endless Rage
    },
    -- Black Brood Pauldrons
    ["19373"] = {
        230251, -- Black Brood Pauldrons
    },
    -- Bracers of Arcane Accuracy
    ["19374"] = {
        230252, -- Bracers of Arcane Accuracy
    },
    -- Mish'undare, Circlet of the Mind Flayer
    ["19375"] = {
        230812, -- Mish'undare, Circlet of the Mind Flayer
    },
    -- Archimtiros' Ring of Reckoning
    ["19376"] = {
        230808, -- Archimtiros' Ring of Reckoning
    },
    -- Prestor's Talisman of Connivery
    ["19377"] = {
        231803, -- Prestor's Talisman of Connivery
    },
    -- Cloak of the Brood Lord
    ["19378"] = {
        230804, -- Cloak of the Brood Lord
    },
    -- Neltharion's Tear
    ["19379"] = {
        230810, -- Neltharion's Tear
    },
    -- Therazane's Link
    ["19380"] = {
        230806, -- Therazane's Link
    },
    -- Boots of the Shadow Flame
    ["19381"] = {
        230805, -- Boots of the Shadow Flame
    },
    -- Pure Elementium Band
    ["19382"] = {
        230811, -- Pure Elementium Band
    },
    -- Master Dragonslayer's Medallion
    ["19383"] = {
        19002, -- Head of Nefarian
    },
    -- Master Dragonslayer's Ring
    ["19384"] = {
        19002, -- Head of Nefarian
    },
    -- Empowered Leggings
    ["19385"] = {
        230746, -- Empowered Leggings
    },
    -- Elementium Threaded Cloak
    ["19386"] = {
        230744, -- Elementium Threaded Cloak
    },
    -- Chromatic Boots
    ["19387"] = {
        230741, -- Chromatic Boots
    },
    -- Angelista's Grasp
    ["19388"] = {
        230739, -- Angelista's Grasp
    },
    -- Taut Dragonhide Shoulderpads
    ["19389"] = {
        230740, -- Taut Dragonhide Shoulderpads
    },
    -- Taut Dragonhide Gloves
    ["19390"] = {
        230742, -- Taut Dragonhide Gloves
    },
    -- Shimmering Geta
    ["19391"] = {
        230743, -- Shimmering Geta
    },
    -- Girdle of the Fallen Crusader
    ["19392"] = {
        230745, -- Girdle of the Fallen Crusader
    },
    -- Primalist's Linked Waistguard
    ["19393"] = {
        230800, -- Primalist's Linked Waistguard
    },
    -- Drake Talon Pauldrons
    ["19394"] = {
        230256, -- Drake Talon Pauldrons
    },
    -- Rejuvenating Gem
    ["19395"] = {
        230269, -- Rejuvenating Gem
    },
    -- Taut Dragonhide Belt
    ["19396"] = {
        230255, -- Taut Dragonhide Belt
    },
    -- Ring of Blackrock
    ["19397"] = {
        230257, -- Ring of Blackrock
    },
    -- Cloak of Firemaw
    ["19398"] = {
        230277, -- Cloak of Firemaw
    },
    -- Black Ash Robe
    ["19399"] = {
        230274, -- Black Ash Robe
    },
    -- Firemaw's Clutch
    ["19400"] = {
        230275, -- Firemaw's Clutch
    },
    -- Primalist's Linked Legguards
    ["19401"] = {
        230279, -- Primalist's Linked Legguards
    },
    -- Legguards of the Fallen Crusader
    ["19402"] = {
        230278, -- Legguards of the Fallen Crusader
    },
    -- Band of Forced Concentration
    ["19403"] = {
        230281, -- Band of Forced Concentration
    },
    -- Malfurion's Blessed Bulwark
    ["19405"] = {
        230725, -- Malfurion's Blessed Bulwark
    },
    -- Drake Fang Talisman
    ["19406"] = {
        230282, -- Drake Fang Talisman
    },
    -- Ebony Flame Gloves
    ["19407"] = {
        230723, -- Ebony Flame Gloves
    },
    -- Shroud of Pure Thought
    ["19430"] = {
        230733, -- Shroud of Pure Thought
    },
    -- Styleen's Impeding Scarab
    ["19431"] = {
        230736, -- Styleen's Impeding Scarab
    },
    -- Circle of Applied Force
    ["19432"] = {
        230734, -- Circle of Applied Force
    },
    -- Emberweave Leggings
    ["19433"] = {
        230735, -- Emberweave Leggings
    },
    -- Band of Dark Dominion
    ["19434"] = {
        230846, -- Band of Dark Dominion
    },
    -- Essence Gatherer
    ["19435"] = {
        230847, -- Essence Gatherer
    },
    -- Cloak of Draconic Might
    ["19436"] = {
        230842, -- Cloak of Draconic Might
    },
    -- Boots of Pure Thought
    ["19437"] = {
        230843, -- Boots of Pure Thought
    },
    -- Ringo's Blizzard Boots
    ["19438"] = {
        230849, -- Ringo's Blizzard Boots
    },
    -- Interlaced Shadow Jerkin
    ["19439"] = {
        230848, -- Interlaced Shadow Jerkin
    },
    -- Rage of Mugamba
    ["19577"] = {
        231350, -- Rage of Mugamba
    },
    -- Hero's Brand
    ["19588"] = {
        231328, -- Hero's Brand
    },
    -- The All-Seeing Eye of Zuldazar
    ["19594"] = {
        231332, -- The All-Seeing Eye of Zuldazar
    },
    -- Jewel of Kajaro
    ["19601"] = {
        231324, -- Jewel of Kajaro
    },
    -- Kezan's Unstoppable Taint
    ["19605"] = {
        231346, -- Kezan's Unstoppable Taint
    },
    -- Unmarred Vision of Voodress
    ["19609"] = {
        231340, -- Unmarred Vision of Voodress
    },
    -- Pristine Enchanted South Seas Kelp
    ["19613"] = {
        231316, -- Pristine Enchanted South Seas Kelp
    },
    -- Zandalarian Shadow Mastery Talisman
    ["19617"] = {
        231336, -- Zandalarian Shadow Mastery Talisman
    },
    -- Maelstrom's Wrath
    ["19621"] = {
        231320, -- Maelstrom's Wrath
    },
    -- Primal Hakkari Bindings
    ["19716"] = {
        19827, -- Zandalar Freethinker's Armguards
        19833, -- Zandalar Predator's Bracers
        19846, -- Zandalar Illusionist's Wraps
        231323, -- Zandalar Predator's Bracers
        231326, -- Zandalar Illusionist's Wraps
        231331, -- Zandalar Freethinker's Armguards
    },
    -- Primal Hakkari Armsplint
    ["19717"] = {
        19824, -- Zandalar Vindicator's Armguards
        19830, -- Zandalar Augur's Bracers
        19836, -- Zandalar Madcap's Bracers
        231339, -- Zandalar Madcap's Bracers
        231343, -- Zandalar Augur's Bracers
        231351, -- Zandalar Vindicator's Armguards
    },
    -- Primal Hakkari Stanchion
    ["19718"] = {
        19840, -- Zandalar Haruspex's Bracers
        19843, -- Zandalar Confessor's Wraps
        19848, -- Zandalar Demoniac's Wraps
        231319, -- Zandalar Haruspex's Bracers
        231335, -- Zandalar Confessor's Wraps
        231347, -- Zandalar Demoniac's Wraps
    },
    -- Primal Hakkari Girdle
    ["19719"] = {
        19823, -- Zandalar Vindicator's Belt
        19829, -- Zandalar Augur's Belt
        19835, -- Zandalar Madcap's Mantle
        231338, -- Zandalar Madcap's Mantle
        231342, -- Zandalar Augur's Belt
        231352, -- Zandalar Vindicator's Belt
    },
    -- Primal Hakkari Sash
    ["19720"] = {
        19839, -- Zandalar Haruspex's Belt
        19842, -- Zandalar Confessor's Bindings
        19849, -- Zandalar Demoniac's Mantle
        231318, -- Zandalar Haruspex's Belt
        231334, -- Zandalar Confessor's Bindings
        231349, -- Zandalar Demoniac's Mantle
    },
    -- Primal Hakkari Shawl
    ["19721"] = {
        19826, -- Zandalar Freethinker's Belt
        19832, -- Zandalar Predator's Belt
        19845, -- Zandalar Illusionist's Mantle
        231322, -- Zandalar Predator's Belt
        231325, -- Zandalar Illusionist's Mantle
        231330, -- Zandalar Freethinker's Belt
    },
    -- Primal Hakkari Tabard
    ["19722"] = {
        19825, -- Zandalar Freethinker's Breastplate
        19828, -- Zandalar Augur's Hauberk
        19838, -- Zandalar Haruspex's Tunic
        231317, -- Zandalar Haruspex's Tunic
        231329, -- Zandalar Freethinker's Breastplate
        231341, -- Zandalar Augur's Hauberk
    },
    -- Primal Hakkari Kossack
    ["19723"] = {
        19822, -- Zandalar Vindicator's Breastplate
        20033, -- Zandalar Demoniac's Robe
        20034, -- Zandalar Illusionist's Robe
        231327, -- Zandalar Illusionist's Robe
        231348, -- Zandalar Demoniac's Robe
        231353, -- Zandalar Vindicator's Breastplate
    },
    -- Primal Hakkari Aegis
    ["19724"] = {
        19831, -- Zandalar Predator's Mantle
        19834, -- Zandalar Madcap's Tunic
        19841, -- Zandalar Confessor's Mantle
        231321, -- Zandalar Predator's Mantle
        231333, -- Zandalar Confessor's Mantle
        231337, -- Zandalar Madcap's Tunic
    },
    -- Presence of Might
    ["19782"] = {
        231379, -- Presence of Might
    },
    -- Syncretist's Sigil
    ["19783"] = {
        231362, -- Syncretist's Sigil
    },
    -- Death's Embrace
    ["19784"] = {
        231368, -- Death's Embrace
    },
    -- Falcon's Call
    ["19785"] = {
        231359, -- Falcon's Call
    },
    -- Vodouisant's Vigilant Embrace
    ["19786"] = {
        231512, -- Primal Hakkari Idol
    },
    -- Presence of Sight
    ["19787"] = {
        231383, -- Presence of Sight
    },
    -- Hoodoo Hex
    ["19788"] = {
        231376, -- Hoodoo Hex
    },
    -- Prophetic Aura
    ["19789"] = {
        231366, -- Prophetic Aura
    },
    -- Animist's Caress
    ["19790"] = {
        231354, -- Animist's Caress
    },
    -- Heart of Hakkar
    ["19802"] = {
        19948, -- Zandalarian Hero Badge
        19949, -- Zandalarian Hero Medallion
        19950, -- Zandalarian Hero Charm
    },
    -- Punctured Voodoo Doll
    ["19813"] = {
        231523, -- Punctured Voodoo Doll
    },
    -- Punctured Voodoo Doll
    ["19814"] = {
        231523, -- Punctured Voodoo Doll
    },
    -- Punctured Voodoo Doll
    ["19815"] = {
        231523, -- Punctured Voodoo Doll
    },
    -- Punctured Voodoo Doll
    ["19816"] = {
        231523, -- Punctured Voodoo Doll
    },
    -- Punctured Voodoo Doll
    ["19817"] = {
        231523, -- Punctured Voodoo Doll
    },
    -- Punctured Voodoo Doll
    ["19818"] = {
        231523, -- Punctured Voodoo Doll
    },
    -- Punctured Voodoo Doll
    ["19819"] = {
        231523, -- Punctured Voodoo Doll
    },
    -- Punctured Voodoo Doll
    ["19820"] = {
        231523, -- Punctured Voodoo Doll
    },
    -- Punctured Voodoo Doll
    ["19821"] = {
        231523, -- Punctured Voodoo Doll
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
    -- Ancient Hakkari Manslayer
    ["19852"] = {
        231293, -- Ancient Hakkari Manslayer
    },
    -- Gurubashi Dwarf Destroyer
    ["19853"] = {
        231302, -- Gurubashi Dwarf Destroyer
    },
    -- Zin'rokh, Destroyer of Worlds
    ["19854"] = {
        231854, -- Zin'rokh, Destroyer of Worlds
    },
    -- Bloodsoaked Legplates
    ["19855"] = {
        231299, -- Bloodsoaked Legplates
    },
    -- The Eye of Hakkar
    ["19856"] = {
        231307, -- The Eye of Hakkar
    },
    -- Cloak of Consumption
    ["19857"] = {
        231300, -- Cloak of Consumption
    },
    -- Fang of the Faceless
    ["19859"] = {
        231855, -- Fang of the Faceless
    },
    -- Touch of Chaos
    ["19861"] = {
        231308, -- Touch of Chaos
    },
    -- Aegis of the Blood God
    ["19862"] = {
        231289, -- Aegis of the Blood God
    },
    -- Primalist's Seal
    ["19863"] = {
        231000, -- Primalist's Seal
    },
    -- Bloodcaller
    ["19864"] = {
        231296, -- Bloodcaller
    },
    -- Warblade of the Hakkari
    ["19865"] = {
        231309, -- Warblade of the Hakkari
    },
    -- Warblade of the Hakkari
    ["19866"] = {
        231309, -- Warblade of the Hakkari
    },
    -- Bloodlord's Defender
    ["19867"] = {
        230989, -- Bloodlord's Defender
    },
    -- Blooddrenched Grips
    ["19869"] = {
        230995, -- Blooddrenched Grips
    },
    -- Hakkari Loa Cloak
    ["19870"] = {
        230998, -- Hakkari Loa Cloak
    },
    -- Talisman of Protection
    ["19871"] = {
        230922, -- Talisman of Protection
    },
    -- Overlord's Crimson Band
    ["19873"] = {
        230999, -- Overlord's Crimson Band
    },
    -- Halberd of Smiting
    ["19874"] = {
        230991, -- Halberd of Smiting
    },
    -- Bloodstained Coif
    ["19875"] = {
        231007, -- Bloodstained Coif
    },
    -- Soul Corrupter's Necklace
    ["19876"] = {
        231306, -- Soul Corrupter's Necklace
    },
    -- Animist's Leggings
    ["19877"] = {
        230994, -- Animist's Leggings
    },
    -- Bloodsoaked Pauldrons
    ["19878"] = {
        230996, -- Bloodsoaked Pauldrons
    },
    -- Jin'do's Judgement
    ["19884"] = {
        231004, -- Jin'do's Judgement
    },
    -- Jin'do's Evil Eye
    ["19885"] = {
        231003, -- Jin'do's Evil Eye
    },
    -- The Hexxer's Cover
    ["19886"] = {
        231013, -- The Hexxer's Cover
    },
    -- Bloodstained Legplates
    ["19887"] = {
        231008, -- Bloodstained Legplates
    },
    -- Overlord's Embrace
    ["19888"] = {
        231012, -- Overlord's Embrace
    },
    -- Blooddrenched Leggings
    ["19889"] = {
        231009, -- Blooddrenched Leggings
    },
    -- Jin'do's Hexxer
    ["19890"] = {
        231002, -- Jin'do's Hexxer
    },
    -- Jin'do's Bag of Whammies
    ["19891"] = {
        231005, -- Jin'do's Bag of Whammies
    },
    -- Animist's Boots
    ["19892"] = {
        231006, -- Animist's Boots
    },
    -- Zanzil's Seal
    ["19893"] = {
        231001, -- Zanzil's Seal
    },
    -- Bloodsoaked Gauntlets
    ["19894"] = {
        231010, -- Bloodsoaked Gauntlets
    },
    -- Bloodtinged Kilt
    ["19895"] = {
        230997, -- Bloodtinged Kilt
    },
    -- Thekal's Grasp
    ["19896"] = {
        230925, -- Thekal's Grasp
    },
    -- Betrayer's Boots
    ["19897"] = {
        230923, -- Betrayer's Boots
    },
    -- Seal of Jin
    ["19898"] = {
        230929, -- Seal of Jin
    },
    -- Ritualistic Legguards
    ["19899"] = {
        230927, -- Ritualistic Legguards
    },
    -- Zulian Stone Axe
    ["19900"] = {
        230868, -- Zulian Stone Axe
    },
    -- Zulian Slicer
    ["19901"] = {
        230930, -- Zulian Slicer
    },
    -- Fang of Venoxis
    ["19903"] = {
        230865, -- Fang of Venoxis
    },
    -- Runed Bloodstained Hauberk
    ["19904"] = {
        230864, -- Runed Bloodstained Hauberk
    },
    -- Zanzil's Band
    ["19905"] = {
        230867, -- Zanzil's Band
    },
    -- Blooddrenched Footpads
    ["19906"] = {
        230866, -- Blooddrenched Footpads
    },
    -- Zulian Tigerhide Cloak
    ["19907"] = {
        232311, -- Zulian Tigerhide Cloak
    },
    -- Will of Arlokk
    ["19909"] = {
        230939, -- Will of Arlokk
    },
    -- Arlokk's Grasp
    ["19910"] = {
        231851, -- Arlokk's Grasp
    },
    -- Overlord's Onyx Band
    ["19912"] = {
        230943, -- Overlord's Onyx Band
    },
    -- Bloodsoaked Greaves
    ["19913"] = {
        230942, -- Bloodsoaked Greaves
    },
    -- Panther Hide Sack
    ["19914"] = {
        230944, -- Panther Hide Sack
    },
    -- Zulian Defender
    ["19915"] = {
        232299, -- Zulian Defender
    },
    -- Jeklik's Crusher
    ["19918"] = {
        230911, -- Jeklik's Crusher
    },
    -- Bloodstained Greaves
    ["19919"] = {
        230919, -- Bloodstained Greaves
    },
    -- Primalist's Band
    ["19920"] = {
        230915, -- Primalist's Band
    },
    -- Arlokk's Hoodoo Stick
    ["19922"] = {
        230941, -- Arlokk's Hoodoo Stick
    },
    -- Jeklik's Opaline Talisman
    ["19923"] = {
        230913, -- Jeklik's Opaline Talisman
    },
    -- Band of Jin
    ["19925"] = {
        230921, -- Band of Jin
    },
    -- Mar'li's Touch
    ["19927"] = {
        231866, -- Mar'li's Touch
    },
    -- Animist's Spaulders
    ["19928"] = {
        230912, -- Animist's Spaulders
    },
    -- Bloodtinged Gloves
    ["19929"] = {
        231011, -- Bloodtinged Gloves
    },
    -- Mar'li's Eye
    ["19930"] = {
        230920, -- Mar'li's Eye
    },
    -- Gri'lek's Blood
    ["19939"] = {
        231513, -- Gri'lek's Blood
    },
    -- Renataki's Tooth
    ["19940"] = {
        231514, -- Renataki's Tooth
    },
    -- Wushoolay's Mane
    ["19941"] = {
        231515, -- Wushoolay's Mane
    },
    -- Hazza'rah's Dream Thread
    ["19942"] = {
        231516, -- Hazza'rah's Dream Thread
    },
    -- Nat Pagle's Fish Terminator
    ["19944"] = {
        231016, -- Nat Pagle's Fish Terminator
    },
    -- Tigule's Harpoon
    ["19946"] = {
        231272, -- Tigule's Harpoon
    },
    -- Nat Pagle's Broken Reel
    ["19947"] = {
        231271, -- Nat Pagle's Broken Reel
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
    -- Gri'lek's Charm of Might
    ["19951"] = {
        231286, -- Gri'lek's Charm of Might
    },
    -- Gri'lek's Charm of Valor
    ["19952"] = {
        231285, -- Gri'lek's Charm of Valor
    },
    -- Renataki's Charm of Trickery
    ["19954"] = {
        231287, -- Renataki's Charm of Trickery
    },
    -- Wushoolay's Charm of Nature
    ["19955"] = {
        231280, -- Wushoolay's Charm of Nature
    },
    -- Wushoolay's Charm of Spirits
    ["19956"] = {
        231281, -- Wushoolay's Charm of Spirits
    },
    -- Hazza'rah's Charm of Destruction
    ["19957"] = {
        231284, -- Hazza'rah's Charm of Destruction
    },
    -- Gri'lek's Grinder
    ["19961"] = {
        231274, -- Gri'lek's Grinder
    },
    -- Gri'lek's Carver
    ["19962"] = {
        231273, -- Gri'lek's Carver
    },
    -- Pitchfork of Madness
    ["19963"] = {
        231277, -- Pitchfork of Madness
    },
    -- Renataki's Soul Conduit
    ["19964"] = {
        232309, -- Renataki's Soul Conduit
    },
    -- Wushoolay's Poker
    ["19965"] = {
        231871, -- Wushoolay's Poker
    },
    -- Thoughtblighter
    ["19967"] = {
        231863, -- Thoughtblighter
    },
    -- Fishing Tournament!
    ["19978"] = {
        217017, -- Fishing Tournament!
    },
    -- Hoodoo Hunting Bow
    ["19993"] = {
        231278, -- Hoodoo Hunting Bow
    },
    -- Flowing Ritual Robes
    ["20032"] = {
        230917, -- Flowing Ritual Robes
    },
    -- Zandalar Demoniac's Robe
    ["20033"] = {
        19723, -- Primal Hakkari Kossack
    },
    -- Zandalar Illusionist's Robe
    ["20034"] = {
        19723, -- Primal Hakkari Kossack
    },
    -- Mandokir's Sting
    ["20038"] = {
        231868, -- Mandokir's Sting
    },
    -- Seafury Gauntlets
    ["20257"] = {
        231305, -- Seafury Gauntlets
    },
    -- Seafury Leggings
    ["20260"] = {
        230928, -- Seafury Leggings
    },
    -- Seafury Boots
    ["20262"] = {
        230916, -- Seafury Boots
    },
    -- Peacekeeper Gauntlets
    ["20264"] = {
        231303, -- Peacekeeper Gauntlets
    },
    -- Peacekeeper Boots
    ["20265"] = {
        230914, -- Peacekeeper Boots
    },
    -- Peacekeeper Leggings
    ["20266"] = {
        230926, -- Peacekeeper Leggings
    },
    -- Dreamscale Breastplate
    ["20380"] = {
        234324, -- Dreamscale Breastplate
    },
    -- Pattern: Dreamscale Breastplate
    ["20382"] = {
        234325, -- Pattern: Dreamscale Breastplate
    },
    -- Sandstalker Bracers
    ["20476"] = {
        234294, -- Sandstalker Bracers
    },
    -- Sandstalker Gauntlets
    ["20477"] = {
        234296, -- Sandstalker Gauntlets
    },
    -- Sandstalker Breastplate
    ["20478"] = {
        234298, -- Sandstalker Breastplate
    },
    -- Spitfire Breastplate
    ["20479"] = {
        234304, -- Spitfire Breastplate
    },
    -- Spitfire Gauntlets
    ["20480"] = {
        234302, -- Spitfire Gauntlets
    },
    -- Spitfire Bracers
    ["20481"] = {
        234300, -- Spitfire Bracers
    },
    -- Pattern: Spitfire Bracers
    ["20506"] = {
        234301, -- Pattern: Spitfire Bracers
    },
    -- Pattern: Spitfire Gauntlets
    ["20507"] = {
        234303, -- Pattern: Spitfire Gauntlets
    },
    -- Pattern: Spitfire Breastplate
    ["20508"] = {
        234305, -- Pattern: Spitfire Breastplate
    },
    -- Pattern: Sandstalker Bracers
    ["20509"] = {
        234295, -- Pattern: Sandstalker Bracers
    },
    -- Pattern: Sandstalker Gauntlets
    ["20510"] = {
        234297, -- Pattern: Sandstalker Gauntlets
    },
    -- Pattern: Sandstalker Breastplate
    ["20511"] = {
        234299, -- Pattern: Sandstalker Breastplate
    },
    -- Scroll: Create Signet of Beckoning
    ["20531"] = {
        229897, -- Scroll: Create Signet of Beckoning
    },
    -- Scroll: Create Signet of Beckoning
    ["20532"] = {
        229897, -- Scroll: Create Signet of Beckoning
    },
    -- Scroll: Create Signet of Beckoning
    ["20533"] = {
        229897, -- Scroll: Create Signet of Beckoning
    },
    -- Scroll: Create Signet of Beckoning
    ["20535"] = {
        229897, -- Scroll: Create Signet of Beckoning
    },
    -- Nightmare Blade
    ["20577"] = {
        234170, -- Nightmare Blade
    },
    -- Emerald Dragonfang
    ["20578"] = {
        234172, -- Emerald Dragonfang
    },
    -- Green Dragonskin Cloak
    ["20579"] = {
        234151, -- Green Dragonskin Cloak
    },
    -- Hammer of Bestial Fury
    ["20580"] = {
        234152, -- Hammer of Bestial Fury
    },
    -- Staff of Rampant Growth
    ["20581"] = {
        234153, -- Staff of Rampant Growth
    },
    -- Trance Stone
    ["20582"] = {
        234154, -- Trance Stone
    },
    -- Polished Ironwood Crossbow
    ["20599"] = {
        234159, -- Polished Ironwood Crossbow
    },
    -- Malfurion's Signet Ring
    ["20600"] = {
        234155, -- Malfurion's Signet Ring
    },
    -- Dragonspur Wraps
    ["20615"] = {
        234149, -- Dragonspur Wraps
    },
    -- Dragonbone Wristguards
    ["20616"] = {
        234148, -- Dragonbone Wristguards
    },
    -- Ancient Corroded Leggings
    ["20617"] = {
        234147, -- Ancient Corroded Leggings
    },
    -- Gloves of Delusional Power
    ["20618"] = {
        234150, -- Gloves of Delusional Power
    },
    -- Acid Inscribed Greaves
    ["20619"] = {
        234146, -- Acid Inscribed Greaves
    },
    -- Boots of the Endless Moor
    ["20621"] = {
        234156, -- Boots of the Endless Moor
    },
    -- Dragonheart Necklace
    ["20622"] = {
        234158, -- Dragonheart Necklace
    },
    -- Circlet of Restless Dreams
    ["20623"] = {
        234157, -- Circlet of Restless Dreams
    },
    -- Ring of the Unliving
    ["20624"] = {
        234160, -- Ring of the Unliving
    },
    -- Belt of the Dark Bog
    ["20625"] = {
        234161, -- Belt of the Dark Bog
    },
    -- Black Bark Wristbands
    ["20626"] = {
        234162, -- Black Bark Wristbands
    },
    -- Dark Heart Pants
    ["20627"] = {
        234163, -- Dark Heart Pants
    },
    -- Deviate Growth Cap
    ["20628"] = {
        234164, -- Deviate Growth Cap
    },
    -- Malignant Footguards
    ["20629"] = {
        234166, -- Malignant Footguards
    },
    -- Gauntlets of the Shining Light
    ["20630"] = {
        234165, -- Gauntlets of the Shining Light
    },
    -- Mendicant's Slippers
    ["20631"] = {
        234168, -- Mendicant's Slippers
    },
    -- Mindtear Band
    ["20632"] = {
        234169, -- Mindtear Band
    },
    -- Unnatural Leather Spaulders
    ["20633"] = {
        234171, -- Unnatural Leather Spaulders
    },
    -- Boots of Fright
    ["20634"] = {
        234167, -- Boots of Fright
    },
    -- Jade Inlaid Vestments
    ["20635"] = {
        234962, -- Jade Inlaid Vestments
    },
    -- Hibernation Crystal
    ["20636"] = {
        234175, -- Hibernation Crystal
    },
    -- Acid Inscribed Pauldrons
    ["20637"] = {
        234174, -- Acid Inscribed Pauldrons
    },
    -- Leggings of the Demented Mind
    ["20638"] = {
        234173, -- Leggings of the Demented Mind
    },
    -- Strangely Glyphed Legplates
    ["20639"] = {
        234963, -- Strangely Glyphed Legplates
    },
    -- Nightmare Engulfed Object
    ["20644"] = {
        235049, -- Nightmare Engulfed Object
    },
    -- Formula: Enchant Cloak - Greater Fire Resistance
    ["20732"] = {
        229008, -- Formula: Enchant Cloak - Greater Fire Resistance
    },
    -- Formula: Enchant Cloak - Greater Nature Resistance
    ["20733"] = {
        229009, -- Formula: Enchant Cloak - Greater Nature Resistance
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
    -- Death's Sting
    ["21126"] = {
        234984, -- Death's Sting
    },
    -- Staff of the Qiraji Prophets
    ["21128"] = {
        233509, -- Staff of the Qiraji Prophets
    },
    -- Dark Edge of Insanity
    ["21134"] = {
        234985, -- Dark Edge of Insanity
    },
    -- Gloves of Earthen Power
    ["21178"] = {
        234785, -- Gloves of Earthen Power
    },
    -- Band of Earthen Wrath
    ["21179"] = {
        234786, -- Band of Earthen Wrath
    },
    -- Earthstrike
    ["21180"] = {
        234462, -- Earthstrike
    },
    -- Grace of Earth
    ["21181"] = {
        234779, -- Grace of Earth
    },
    -- Band of Earthen Might
    ["21182"] = {
        234780, -- Band of Earthen Might
    },
    -- Earthpower Vest
    ["21183"] = {
        234782, -- Earthpower Vest
    },
    -- Deeprock Bracers
    ["21184"] = {
        234748, -- Deeprock Bracers
    },
    -- Earthcalm Orb
    ["21185"] = {
        234749, -- Earthcalm Orb
    },
    -- Rockfury Bracers
    ["21186"] = {
        234760, -- Rockfury Bracers
    },
    -- Earthweave Cloak
    ["21187"] = {
        234788, -- Earthweave Cloak
    },
    -- Fist of Cenarius
    ["21188"] = {
        234747, -- Fist of Cenarius
    },
    -- Might of Cenarius
    ["21189"] = {
        234761, -- Might of Cenarius
    },
    -- Wrath of Cenarius
    ["21190"] = {
        234463, -- Wrath of Cenarius
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21196"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21197"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21198"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21199"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21200"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21201"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21202"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21203"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21204"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21205"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21206"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21207"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21208"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21209"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
    },
    -- Signet Ring of the Bronze Dragonflight
    ["21210"] = {
        234034, -- Signet Ring of the Bronze Dragonflight
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
        234801, -- Amulet of the Fallen God
        234802, -- Cloak of the Fallen God
        234803, -- Ring of the Fallen God
    },
    -- Imperial Qiraji Armaments
    ["21232"] = {
        21242, -- Blessed Qiraji War Axe
        21244, -- Blessed Qiraji Pugio
        21269, -- Blessed Qiraji Bulwark
        21272, -- Blessed Qiraji Musket
    },
    -- Imperial Qiraji Regalia
    ["21237"] = {
        21268, -- Blessed Qiraji War Hammer
        21273, -- Blessed Qiraji Acolyte Staff
        21275, -- Blessed Qiraji Augur Staff
    },
    -- Blessed Qiraji War Axe
    ["21242"] = {
        21232, -- Imperial Qiraji Armaments
    },
    -- Blessed Qiraji Pugio
    ["21244"] = {
        21232, -- Imperial Qiraji Armaments
    },
    -- Logistics Task Briefing VI
    ["21260"] = {
        232549, -- Logistics Task Briefing VI
    },
    -- Logistics Task Briefing VI
    ["21261"] = {
        232549, -- Logistics Task Briefing VI
    },
    -- Blessed Qiraji War Hammer
    ["21268"] = {
        21237, -- Imperial Qiraji Regalia
    },
    -- Blessed Qiraji Bulwark
    ["21269"] = {
        21232, -- Imperial Qiraji Armaments
    },
    -- Blessed Qiraji Musket
    ["21272"] = {
        21232, -- Imperial Qiraji Armaments
    },
    -- Blessed Qiraji Acolyte Staff
    ["21273"] = {
        21237, -- Imperial Qiraji Regalia
    },
    -- Blessed Qiraji Augur Staff
    ["21275"] = {
        21237, -- Imperial Qiraji Regalia
    },
    -- Defender of the Timbermaw
    ["21326"] = {
        227811, -- Defender of the Timbermaw
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
        233442, -- Sickle of Unyielding Strength
    },
    -- Signet of Unyielding Strength
    ["21393"] = {
        233443, -- Signet of Unyielding Strength
    },
    -- Drape of Unyielding Strength
    ["21394"] = {
        233441, -- Drape of Unyielding Strength
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
        233427, -- Cape of Eternal Justice
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
        233422, -- Signet of the Unseen Path
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
    -- Staff of the Ruins
    ["21452"] = {
        234115, -- Staff of the Ruins
    },
    -- Mantle of the Horusath
    ["21453"] = {
        234109, -- Mantle of the Horusath
    },
    -- Runic Stone Shoulders
    ["21454"] = {
        234111, -- Runic Stone Shoulders
    },
    -- Southwind Helm
    ["21455"] = {
        234084, -- Southwind Helm
    },
    -- Sandstorm Cloak
    ["21456"] = {
        234113, -- Sandstorm Cloak
    },
    -- Bracers of Brutality
    ["21457"] = {
        234103, -- Bracers of Brutality
    },
    -- Gauntlets of New Life
    ["21458"] = {
        234105, -- Gauntlets of New Life
    },
    -- Crossbow of Imminent Doom
    ["21459"] = {
        234104, -- Crossbow of Imminent Doom
    },
    -- Helm of Domination
    ["21460"] = {
        234107, -- Helm of Domination
    },
    -- Leggings of the Black Blizzard
    ["21461"] = {
        234108, -- Leggings of the Black Blizzard
    },
    -- Gloves of Dark Wisdom
    ["21462"] = {
        234106, -- Gloves of Dark Wisdom
    },
    -- Ossirian's Binding
    ["21463"] = {
        234110, -- Ossirian's Binding
    },
    -- Shackles of the Unscarred
    ["21464"] = {
        234114, -- Shackles of the Unscarred
    },
    -- Stinger of Ayamiss
    ["21466"] = {
        234097, -- Stinger of Ayamiss
    },
    -- Thick Silithid Chestguard
    ["21467"] = {
        234077, -- Thick Silithid Chestguard
    },
    -- Mantle of Maz'Nadir
    ["21468"] = {
        234082, -- Mantle of Maz'Nadir
    },
    -- Gauntlets of Southwind
    ["21469"] = {
        234081, -- Gauntlets of Southwind
    },
    -- Cloak of the Savior
    ["21470"] = {
        234079, -- Cloak of the Savior
    },
    -- Talon of Furious Concentration
    ["21471"] = {
        234076, -- Talon of Furious Concentration
    },
    -- Dustwind Turban
    ["21472"] = {
        234073, -- Dustwind Turban
    },
    -- Eye of Moam
    ["21473"] = {
        234080, -- Eye of Moam
    },
    -- Chitinous Shoulderguards
    ["21474"] = {
        234078, -- Chitinous Shoulderguards
    },
    -- Legplates of the Destroyer
    ["21475"] = {
        234088, -- Legplates of the Destroyer
    },
    -- Obsidian Scaled Leggings
    ["21476"] = {
        234087, -- Obsidian Scaled Leggings
    },
    -- Ring of Fury
    ["21477"] = {
        234083, -- Ring of Fury
    },
    -- Bow of Taut Sinew
    ["21478"] = {
        234096, -- Bow of Taut Sinew
    },
    -- Gauntlets of the Immovable
    ["21479"] = {
        234075, -- Gauntlets of the Immovable
    },
    -- Scaled Silithid Gauntlets
    ["21480"] = {
        234102, -- Scaled Silithid Gauntlets
    },
    -- Boots of the Desert Protector
    ["21481"] = {
        234098, -- Boots of the Desert Protector
    },
    -- Boots of the Fiery Sands
    ["21482"] = {
        234099, -- Boots of the Fiery Sands
    },
    -- Ring of the Desert Winds
    ["21483"] = {
        234101, -- Ring of the Desert Winds
    },
    -- Helm of Regrowth
    ["21484"] = {
        234100, -- Helm of Regrowth
    },
    -- Buru's Skull Fragment
    ["21485"] = {
        234089, -- Buru's Skull Fragment
    },
    -- Gloves of the Swarm
    ["21486"] = {
        234090, -- Gloves of the Swarm
    },
    -- Slimy Scaled Gauntlets
    ["21487"] = {
        234091, -- Slimy Scaled Gauntlets
    },
    -- Fetish of Chitinous Spikes
    ["21488"] = {
        234092, -- Fetish of Chitinous Spikes
    },
    -- Quicksand Waders
    ["21489"] = {
        234093, -- Quicksand Waders
    },
    -- Slime Kickers
    ["21490"] = {
        234095, -- Slime Kickers
    },
    -- Scaled Bracers of the Gorger
    ["21491"] = {
        234094, -- Scaled Bracers of the Gorger
    },
    -- Manslayer of the Qiraji
    ["21492"] = {
        234067, -- Manslayer of the Qiraji
    },
    -- Boots of the Vanguard
    ["21493"] = {
        234068, -- Boots of the Vanguard
    },
    -- Southwind's Grasp
    ["21494"] = {
        234072, -- Southwind's Grasp
    },
    -- Legplates of the Qiraji Command
    ["21495"] = {
        234071, -- Legplates of the Qiraji Command
    },
    -- Bracers of Qiraji Command
    ["21496"] = {
        234070, -- Bracers of Qiraji Command
    },
    -- Boots of the Qiraji General
    ["21497"] = {
        234069, -- Boots of the Qiraji General
    },
    -- Qiraji Sacrificial Dagger
    ["21498"] = {
        234061, -- Qiraji Sacrificial Dagger
    },
    -- Vestments of the Shifting Sands
    ["21499"] = {
        234062, -- Vestments of the Shifting Sands
    },
    -- Belt of the Inquisition
    ["21500"] = {
        234064, -- Belt of the Inquisition
    },
    -- Toughened Silithid Hide Gloves
    ["21501"] = {
        234066, -- Toughened Silithid Hide Gloves
    },
    -- Sand Reaver Wristguards
    ["21502"] = {
        234065, -- Sand Reaver Wristguards
    },
    -- Belt of the Sand Reaver
    ["21503"] = {
        234063, -- Belt of the Sand Reaver
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
    -- Gnomish Turban of Psychic Might
    ["21517"] = {
        234134, -- Gnomish Turban of Psychic Might
    },
    -- Ravencrest's Legacy
    ["21520"] = {
        234139, -- Ravencrest's Legacy
    },
    -- Runesword of the Red
    ["21521"] = {
        234141, -- Runesword of the Red
    },
    -- Shadowsong's Sorrow
    ["21522"] = {
        234138, -- Shadowsong's Sorrow
    },
    -- Fang of Korialstrasz
    ["21523"] = {
        234137, -- Fang of Korialstrasz
    },
    -- Band of Icy Depths
    ["21526"] = {
        234135, -- Band of Icy Depths
    },
    -- Darkwater Robes
    ["21527"] = {
        234136, -- Darkwater Robes
    },
    -- Amulet of Shadow Shielding
    ["21529"] = {
        234130, -- Amulet of Shadow Shielding
    },
    -- Onyx Embedded Leggings
    ["21530"] = {
        234129, -- Onyx Embedded Leggings
    },
    -- Drake Tooth Necklace
    ["21531"] = {
        234132, -- Drake Tooth Necklace
    },
    -- Drudge Boots
    ["21532"] = {
        234133, -- Drudge Boots
    },
    -- Vanquished Tentacle of C'Thun
    ["21579"] = {
        233639, -- Vanquished Tentacle of C'Thun
    },
    -- Gauntlets of Annihilation
    ["21581"] = {
        233637, -- Gauntlets of Annihilation
    },
    -- Grasp of the Old God
    ["21582"] = {
        233632, -- Grasp of the Old God
    },
    -- Cloak of Clarity
    ["21583"] = {
        233641, -- Cloak of Clarity
    },
    -- Dark Storm Gauntlets
    ["21585"] = {
        233631, -- Dark Storm Gauntlets
    },
    -- Belt of Never-ending Agony
    ["21586"] = {
        233635, -- Belt of Never-ending Agony
    },
    -- Ring of the Godslayer
    ["21596"] = {
        233638, -- Ring of the Godslayer
    },
    -- Royal Scepter of Vek'lor
    ["21597"] = {
        233616, -- Royal Scepter of Vek'lor
    },
    -- Royal Qiraji Belt
    ["21598"] = {
        233614, -- Royal Qiraji Belt
    },
    -- Vek'lor's Gloves of Devastation
    ["21599"] = {
        233613, -- Vek'lor's Gloves of Devastation
    },
    -- Boots of Epiphany
    ["21600"] = {
        233611, -- Boots of Epiphany
    },
    -- Ring of Emperor Vek'lor
    ["21601"] = {
        233615, -- Ring of Emperor Vek'lor
    },
    -- Qiraji Execution Bracers
    ["21602"] = {
        233612, -- Qiraji Execution Bracers
    },
    -- Wand of Qiraji Nobility
    ["21603"] = {
        234976, -- Wand of Qiraji Nobility
    },
    -- Bracelets of Royal Redemption
    ["21604"] = {
        233617, -- Bracelets of Royal Redemption
    },
    -- Gloves of the Hidden Temple
    ["21605"] = {
        233618, -- Gloves of the Hidden Temple
    },
    -- Belt of the Fallen Emperor
    ["21606"] = {
        233623, -- Belt of the Fallen Emperor
    },
    -- Grasp of the Fallen Emperor
    ["21607"] = {
        233622, -- Grasp of the Fallen Emperor
    },
    -- Amulet of Vek'nilash
    ["21608"] = {
        233620, -- Amulet of Vek'nilash
    },
    -- Regenerating Belt of Vek'nilash
    ["21609"] = {
        233619, -- Regenerating Belt of Vek'nilash
    },
    -- Wormscale Blocker
    ["21610"] = {
        233629, -- Wormscale Blocker
    },
    -- Burrower Bracers
    ["21611"] = {
        233625, -- Burrower Bracers
    },
    -- Don Rigoberto's Lost Hat
    ["21615"] = {
        233624, -- Don Rigoberto's Lost Hat
    },
    -- Huhuran's Stinger
    ["21616"] = {
        233605, -- Huhuran's Stinger
    },
    -- Wasphide Gauntlets
    ["21617"] = {
        233608, -- Wasphide Gauntlets
    },
    -- Hive Defiler Wristguards
    ["21618"] = {
        233610, -- Hive Defiler Wristguards
    },
    -- Gloves of the Messiah
    ["21619"] = {
        233607, -- Gloves of the Messiah
    },
    -- Ring of the Martyr
    ["21620"] = {
        233609, -- Ring of the Martyr
    },
    -- Cloak of the Golden Hive
    ["21621"] = {
        233606, -- Cloak of the Golden Hive
    },
    -- Sharpened Silithid Femur
    ["21622"] = {
        233599, -- Sharpened Silithid Femur
    },
    -- Gauntlets of the Righteous Champion
    ["21623"] = {
        233603, -- Gauntlets of the Righteous Champion
    },
    -- Gauntlets of Kalimdor
    ["21624"] = {
        233604, -- Gauntlets of Kalimdor
    },
    -- Scarab Brooch
    ["21625"] = {
        233601, -- Scarab Brooch
    },
    -- Slime-coated Leggings
    ["21626"] = {
        233598, -- Slime-coated Leggings
    },
    -- Cloak of Untold Secrets
    ["21627"] = {
        233588, -- Cloak of Untold Secrets
    },
    -- Pauldrons of the Unrelenting
    ["21639"] = {
        233593, -- Pauldrons of the Unrelenting
    },
    -- Hive Tunneler's Boots
    ["21645"] = {
        233590, -- Hive Tunneler's Boots
    },
    -- Fetish of the Sand Reaver
    ["21647"] = {
        233589, -- Fetish of the Sand Reaver
    },
    -- Recomposed Boots
    ["21648"] = {
        233573, -- Recomposed Boots
    },
    -- Ancient Qiraji Ripper
    ["21650"] = {
        234650, -- Ancient Qiraji Ripper
    },
    -- Scaled Sand Reaver Leggings
    ["21651"] = {
        233595, -- Scaled Sand Reaver Leggings
    },
    -- Silithid Carapace Chestguard
    ["21652"] = {
        233591, -- Silithid Carapace Chestguard
    },
    -- Robes of the Guardian Saint
    ["21663"] = {
        233594, -- Robes of the Guardian Saint
    },
    -- Barbed Choker
    ["21664"] = {
        233587, -- Barbed Choker
    },
    -- Mantle of Wicked Revenge
    ["21665"] = {
        233592, -- Mantle of Wicked Revenge
    },
    -- Sartura's Might
    ["21666"] = {
        233581, -- Sartura's Might
    },
    -- Legplates of Blazing Light
    ["21667"] = {
        233583, -- Legplates of Blazing Light
    },
    -- Scaled Leggings of Qiraji Fury
    ["21668"] = {
        233584, -- Scaled Leggings of Qiraji Fury
    },
    -- Creeping Vine Helm
    ["21669"] = {
        233578, -- Creeping Vine Helm
    },
    -- Badge of the Swarmguard
    ["21670"] = {
        233580, -- Badge of the Swarmguard
    },
    -- Robes of the Battleguard
    ["21671"] = {
        233575, -- Robes of the Battleguard
    },
    -- Gloves of Enforcement
    ["21672"] = {
        233579, -- Gloves of Enforcement
    },
    -- Silithid Claw
    ["21673"] = {
        233576, -- Silithid Claw
    },
    -- Gauntlets of Steadfast Determination
    ["21674"] = {
        233582, -- Gauntlets of Steadfast Determination
    },
    -- Thick Qirajihide Belt
    ["21675"] = {
        233577, -- Thick Qirajihide Belt
    },
    -- Leggings of the Festering Swarm
    ["21676"] = {
        233574, -- Leggings of the Festering Swarm
    },
    -- Ring of the Qiraji Fury
    ["21677"] = {
        233600, -- Ring of the Qiraji Fury
    },
    -- Necklace of Purity
    ["21678"] = {
        233572, -- Necklace of Purity
    },
    -- Kalimdor's Revenge
    ["21679"] = {
        233621, -- Kalimdor's Revenge
    },
    -- Vest of Swift Execution
    ["21680"] = {
        233568, -- Vest of Swift Execution
    },
    -- Ring of the Devoured
    ["21681"] = {
        233569, -- Ring of the Devoured
    },
    -- Bile-Covered Gauntlets
    ["21682"] = {
        233564, -- Bile-Covered Gauntlets
    },
    -- Mantle of the Desert Crusade
    ["21683"] = {
        233567, -- Mantle of the Desert Crusade
    },
    -- Mantle of the Desert's Fury
    ["21684"] = {
        233566, -- Mantle of the Desert's Fury
    },
    -- Petrified Scarab
    ["21685"] = {
        233570, -- Petrified Scarab
    },
    -- Mantle of Phrenic Power
    ["21686"] = {
        233563, -- Mantle of Phrenic Power
    },
    -- Ukko's Ring of Darkness
    ["21687"] = {
        233565, -- Ukko's Ring of Darkness
    },
    -- Boots of the Fallen Hero
    ["21688"] = {
        233561, -- Boots of the Fallen Hero
    },
    -- Gloves of Ebru
    ["21689"] = {
        233559, -- Gloves of Ebru
    },
    -- Angelista's Charm
    ["21690"] = {
        233562, -- Angelista's Charm
    },
    -- Ooze-ridden Gauntlets
    ["21691"] = {
        233560, -- Ooze-ridden Gauntlets
    },
    -- Triad Girdle
    ["21692"] = {
        233523, -- Triad Girdle
    },
    -- Guise of the Devourer
    ["21693"] = {
        233522, -- Guise of the Devourer
    },
    -- Ternary Mantle
    ["21694"] = {
        233521, -- Ternary Mantle
    },
    -- Angelista's Touch
    ["21695"] = {
        233524, -- Angelista's Touch
    },
    -- Robes of the Triumvirate
    ["21696"] = {
        233520, -- Robes of the Triumvirate
    },
    -- Cape of the Trinity
    ["21697"] = {
        233519, -- Cape of the Trinity
    },
    -- Leggings of Immersion
    ["21698"] = {
        233505, -- Leggings of Immersion
    },
    -- Barrage Shoulders
    ["21699"] = {
        233496, -- Barrage Shoulders
    },
    -- Pendant of the Qiraji Guardian
    ["21700"] = {
        233503, -- Pendant of the Qiraji Guardian
    },
    -- Cloak of Concentrated Hatred
    ["21701"] = {
        233504, -- Cloak of Concentrated Hatred
    },
    -- Amulet of Foul Warding
    ["21702"] = {
        233502, -- Amulet of Foul Warding
    },
    -- Hammer of Ji'zhi
    ["21703"] = {
        233515, -- Hammer of Ji'zhi
    },
    -- Boots of the Redeemed Prophecy
    ["21704"] = {
        233517, -- Boots of the Redeemed Prophecy
    },
    -- Boots of the Fallen Prophet
    ["21705"] = {
        233518, -- Boots of the Fallen Prophet
    },
    -- Boots of the Unwavering Will
    ["21706"] = {
        233514, -- Boots of the Unwavering Will
    },
    -- Ring of Swarming Thought
    ["21707"] = {
        233507, -- Ring of Swarming Thought
    },
    -- Beetle Scaled Wristguards
    ["21708"] = {
        233506, -- Beetle Scaled Wristguards
    },
    -- Ring of the Fallen God
    ["21709"] = {
        234803, -- Ring of the Fallen God
    },
    -- Cloak of the Fallen God
    ["21710"] = {
        21221, -- Eye of C'Thun
    },
    -- Amulet of the Fallen God
    ["21712"] = {
        21221, -- Eye of C'Thun
    },
    -- Sand Polished Hammer
    ["21715"] = {
        234112, -- Sand Polished Hammer
    },
    -- Silithid Husked Launcher
    ["21800"] = {
        234121, -- Silithid Husked Launcher
    },
    -- Antenna of Invigoration
    ["21801"] = {
        234119, -- Antenna of Invigoration
    },
    -- The Lost Kris of Zedd
    ["21802"] = {
        234122, -- The Lost Kris of Zedd
    },
    -- Helm of the Holy Avenger
    ["21803"] = {
        234120, -- Helm of the Holy Avenger
    },
    -- Coif of Elemental Fury
    ["21804"] = {
        234123, -- Coif of Elemental Fury
    },
    -- Gavel of Qiraji Authority
    ["21806"] = {
        234118, -- Gavel of Qiraji Authority
    },
    -- Fury of the Forgotten Swarm
    ["21809"] = {
        234116, -- Fury of the Forgotten Swarm
    },
    -- Treads of the Wandering Nomad
    ["21810"] = {
        234117, -- Treads of the Wandering Nomad
    },
    -- Breastplate of Annihilation
    ["21814"] = {
        233516, -- Breastplate of Annihilation
    },
    -- Ritssyn's Ring of Chaos
    ["21836"] = {
        233648, -- Ritssyn's Ring of Chaos
    },
    -- Anubisath Warhammer
    ["21837"] = {
        234986, -- Anubisath Warhammer
    },
    -- Garb of Royal Ascension
    ["21838"] = {
        233644, -- Garb of Royal Ascension
    },
    -- Scepter of the False Prophet
    ["21839"] = {
        233636, -- Scepter of the False Prophet
    },
    -- Neretzek, The Blood Drinker
    ["21856"] = {
        234987, -- Neretzek, The Blood Drinker
    },
    -- Gloves of the Immortal
    ["21888"] = {
        233645, -- Gloves of the Immortal
    },
    -- Gloves of the Redeemed Prophecy
    ["21889"] = {
        233646, -- Gloves of the Redeemed Prophecy
    },
    -- Gloves of the Fallen Prophet
    ["21890"] = {
        235047, -- Gloves of the Fallen Prophet
    },
    -- Shard of the Fallen Star
    ["21891"] = {
        233649, -- Shard of the Fallen Star
    },
    -- Belt of Heroism
    ["21994"] = {
        226864, -- Belt of Heroism
    },
    -- Boots of Heroism
    ["21995"] = {
        226879, -- Boots of Heroism
    },
    -- Bracers of Heroism
    ["21996"] = {
        226863, -- Bracers of Heroism
    },
    -- Breastplate of Heroism
    ["21997"] = {
        226862, -- Breastplate of Heroism
    },
    -- Gauntlets of Heroism
    ["21998"] = {
        226861, -- Gauntlets of Heroism
    },
    -- Helm of Heroism
    ["21999"] = {
        226877, -- Helm of Heroism
    },
    -- Legplates of Heroism
    ["22000"] = {
        226859, -- Legplates of Heroism
    },
    -- Spaulders of Heroism
    ["22001"] = {
        226858, -- Spaulders of Heroism
    },
    -- Darkmantle Belt
    ["22002"] = {
        226832, -- Darkmantle Belt
    },
    -- Darkmantle Boots
    ["22003"] = {
        226851, -- Darkmantle Boots
    },
    -- Darkmantle Bracers
    ["22004"] = {
        226830, -- Darkmantle Bracers
    },
    -- Darkmantle Cap
    ["22005"] = {
        226829, -- Darkmantle Cap
    },
    -- Darkmantle Gloves
    ["22006"] = {
        226850, -- Darkmantle Gloves
    },
    -- Darkmantle Pants
    ["22007"] = {
        226827, -- Darkmantle Pants
    },
    -- Darkmantle Spaulders
    ["22008"] = {
        226826, -- Darkmantle Spaulders
    },
    -- Darkmantle Tunic
    ["22009"] = {
        226825, -- Darkmantle Tunic
    },
    -- Beastmaster's Belt
    ["22010"] = {
        226888, -- Beastmaster's Belt
    },
    -- Beastmaster's Bindings
    ["22011"] = {
        226885, -- Beastmaster's Bindings
    },
    -- Beastmaster's Cap
    ["22013"] = {
        226887, -- Beastmaster's Cap
    },
    -- Beastmaster's Gloves
    ["22015"] = {
        226902, -- Beastmaster's Gloves
    },
    -- Beastmaster's Mantle
    ["22016"] = {
        226884, -- Beastmaster's Mantle
    },
    -- Beastmaster's Pants
    ["22017"] = {
        226882, -- Beastmaster's Pants
    },
    -- Beastmaster's Tunic
    ["22060"] = {
        226886, -- Beastmaster's Tunic
    },
    -- Beastmaster's Boots
    ["22061"] = {
        226903, -- Beastmaster's Boots
    },
    -- Sorcerer's Belt
    ["22062"] = {
        226934, -- Sorcerer's Belt
    },
    -- Sorcerer's Bindings
    ["22063"] = {
        226929, -- Sorcerer's Bindings
    },
    -- Sorcerer's Boots
    ["22064"] = {
        226943, -- Sorcerer's Boots
    },
    -- Sorcerer's Crown
    ["22065"] = {
        226935, -- Sorcerer's Crown
    },
    -- Sorcerer's Gloves
    ["22066"] = {
        226942, -- Sorcerer's Gloves
    },
    -- Sorcerer's Leggings
    ["22067"] = {
        226933, -- Sorcerer's Leggings
    },
    -- Sorcerer's Mantle
    ["22068"] = {
        226936, -- Sorcerer's Mantle
    },
    -- Sorcerer's Robes
    ["22069"] = {
        226932, -- Sorcerer's Robes
    },
    -- Deathmist Belt
    ["22070"] = {
        226905, -- Deathmist Belt
    },
    -- Deathmist Bracers
    ["22071"] = {
        226907, -- Deathmist Bracers
    },
    -- Deathmist Leggings
    ["22072"] = {
        226910, -- Deathmist Leggings
    },
    -- Deathmist Mantle
    ["22073"] = {
        226912, -- Deathmist Mantle
    },
    -- Deathmist Mask
    ["22074"] = {
        226909, -- Deathmist Mask
    },
    -- Deathmist Robe
    ["22075"] = {
        226906, -- Deathmist Robe
    },
    -- Deathmist Sandals
    ["22076"] = {
        226908, -- Deathmist Sandals
    },
    -- Deathmist Wraps
    ["22077"] = {
        226911, -- Deathmist Wraps
    },
    -- Virtuous Belt
    ["22078"] = {
        226948, -- Virtuous Belt
    },
    -- Virtuous Bracers
    ["22079"] = {
        226949, -- Virtuous Bracers
    },
    -- Virtuous Crown
    ["22080"] = {
        226947, -- Virtuous Crown
    },
    -- Virtuous Gloves
    ["22081"] = {
        226966, -- Virtuous Gloves
    },
    -- Virtuous Mantle
    ["22082"] = {
        226951, -- Virtuous Mantle
    },
    -- Virtuous Robe
    ["22083"] = {
        226945, -- Virtuous Robe
    },
    -- Virtuous Sandals
    ["22084"] = {
        226952, -- Virtuous Sandals
    },
    -- Virtuous Skirt
    ["22085"] = {
        226946, -- Virtuous Skirt
    },
    -- Soulforge Belt
    ["22086"] = {
        226971, -- Soulforge Belt
    },
    -- Soulforge Boots
    ["22087"] = {
        226999, -- Soulforge Boots
    },
    -- Soulforge Bracers
    ["22088"] = {
        226970, -- Soulforge Bracers
    },
    -- Soulforge Breastplate
    ["22089"] = {
        226973, -- Soulforge Breastplate
    },
    -- Soulforge Gauntlets
    ["22090"] = {
        226975, -- Soulforge Gauntlets
    },
    -- Soulforge Helm
    ["22091"] = {
        226997, -- Soulforge Helm
    },
    -- Soulforge Legplates
    ["22092"] = {
        226972, -- Soulforge Legplates
    },
    -- Soulforge Spaulders
    ["22093"] = {
        226969, -- Soulforge Spaulders
    },
    -- Bindings of The Five Thunders
    ["22095"] = {
        227001, -- Bindings of The Five Thunders
    },
    -- Boots of The Five Thunders
    ["22096"] = {
        227039, -- Boots of The Five Thunders
    },
    -- Coif of The Five Thunders
    ["22097"] = {
        227002, -- Coif of The Five Thunders
    },
    -- Cord of The Five Thunders
    ["22098"] = {
        227008, -- Cord of The Five Thunders
    },
    -- Gauntlets of The Five Thunders
    ["22099"] = {
        227006, -- Gauntlets of The Five Thunders
    },
    -- Kilt of The Five Thunders
    ["22100"] = {
        227005, -- Kilt of The Five Thunders
    },
    -- Pauldrons of The Five Thunders
    ["22101"] = {
        227003, -- Pauldrons of The Five Thunders
    },
    -- Vest of The Five Thunders
    ["22102"] = {
        227004, -- Vest of The Five Thunders
    },
    -- Feralheart Boots
    ["22107"] = {
        226821, -- Feralheart Boots
    },
    -- Feralheart Cowl
    ["22109"] = {
        226773, -- Feralheart Cowl
    },
    -- Feralheart Gloves
    ["22110"] = {
        226820, -- Feralheart Gloves
    },
    -- Feralheart Kilt
    ["22111"] = {
        226779, -- Feralheart Kilt
    },
    -- Feralheart Spaulders
    ["22112"] = {
        226778, -- Feralheart Spaulders
    },
    -- Feralheart Vest
    ["22113"] = {
        226776, -- Feralheart Vest
    },
    -- Obsidian Mail Tunic
    ["22191"] = {
        234460, -- Obsidian Mail Tunic
    },
    -- Black Grasp of the Destroyer
    ["22194"] = {
        234086, -- Black Grasp of the Destroyer
    },
    -- Light Obsidian Belt
    ["22195"] = {
        234321, -- Light Obsidian Belt
    },
    -- Thick Obsidian Breastplate
    ["22196"] = {
        235040, -- Thick Obsidian Breastplate
    },
    -- Heavy Obsidian Belt
    ["22197"] = {
        234319, -- Heavy Obsidian Belt
    },
    -- Jagged Obsidian Shield
    ["22198"] = {
        234459, -- Jagged Obsidian Shield
    },
    -- Wristguards of Renown
    ["22204"] = {
        227986, -- Wristguards of Renown
    },
    -- Sash of the Grand Hunt
    ["22207"] = {
        227987, -- Sash of the Grand Hunt
    },
    -- Lavastone Hammer
    ["22208"] = {
        227974, -- Lavastone Hammer
    },
    -- Plans: Heavy Obsidian Belt
    ["22209"] = {
        234320, -- Plans: Heavy Obsidian Belt
    },
    -- Golem Fitted Pauldrons
    ["22212"] = {
        227947, -- Golem Fitted Pauldrons
    },
    -- Plans: Light Obsidian Belt
    ["22214"] = {
        234322, -- Plans: Light Obsidian Belt
    },
    -- Plans: Jagged Obsidian Shield
    ["22219"] = {
        234458, -- Plans: Jagged Obsidian Shield
    },
    -- Plans: Black Grasp of the Destroyer
    ["22220"] = {
        234085, -- Plans: Black Grasp of the Destroyer
    },
    -- Plans: Obsidian Mail Tunic
    ["22221"] = {
        234461, -- Plans: Obsidian Mail Tunic
    },
    -- Plans: Thick Obsidian Breastplate
    ["22222"] = {
        235039, -- Plans: Thick Obsidian Breastplate
    },
    -- Kayser's Boots of Precision
    ["22231"] = {
        228594, -- Kayser's Boots of Precision
    },
    -- Marksman's Girdle
    ["22232"] = {
        228595, -- Marksman's Girdle
    },
    -- Verek's Leash
    ["22242"] = {
        227944, -- Verek's Leash
    },
    -- Soot Encrusted Footwear
    ["22245"] = {
        227945, -- Soot Encrusted Footwear
    },
    -- Flarethorn
    ["22266"] = {
        227962, -- Flarethorn
    },
    -- Spellweaver's Turban
    ["22267"] = {
        228677, -- Spellweaver's Turban
    },
    -- Draconic Infused Emblem
    ["22268"] = {
        228678, -- Draconic Infused Emblem
    },
    -- Ironweave Robe
    ["22301"] = {
        228547, -- Ironweave Robe
    },
    -- Ironweave Cowl
    ["22302"] = {
        228681, -- Ironweave Cowl
    },
    -- Ironweave Pants
    ["22303"] = {
        228038, -- Ironweave Pants
    },
    -- Ironweave Gloves
    ["22304"] = {
        228066, -- Ironweave Gloves
    },
    -- Ironweave Mantle
    ["22305"] = {
        228700, -- Ironweave Mantle
    },
    -- Ironweave Belt
    ["22306"] = {
        228596, -- Ironweave Belt
    },
    -- Ironweave Boots
    ["22311"] = {
        228597, -- Ironweave Boots
    },
    -- Ironweave Bracers
    ["22313"] = {
        228598, -- Ironweave Bracers
    },
    -- Heart of Wyrmthalak
    ["22321"] = {
        228599, -- Heart of Wyrmthalak
    },
    -- The Jaw Breaker
    ["22322"] = {
        228600, -- The Jaw Breaker
    },
    -- Amalgam's Band
    ["22326"] = {
        228047, -- Amalgam's Band
    },
    -- Scepter of Interminable Focus
    ["22329"] = {
        228548, -- Scepter of Interminable Focus
    },
    -- Blade of Necromancy
    ["22332"] = {
        228028, -- Blade of Necromancy
    },
    -- Hammer of Divine Might
    ["22333"] = {
        228033, -- Hammer of Divine Might
    },
    -- Lord Valthalak's Staff of Command
    ["22335"] = {
        228682, -- Lord Valthalak's Staff of Command
    },
    -- Rune Band of Wizardry
    ["22339"] = {
        228683, -- Rune Band of Wizardry
    },
    -- Pendant of Celerity
    ["22340"] = {
        228684, -- Pendant of Celerity
    },
    -- Fahrad's Reloading Repeater
    ["22347"] = {
        234799, -- Fahrad's Reloading Repeater
    },
    -- Doomulus Prime
    ["22348"] = {
        234798, -- Doomulus Prime
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
    -- The Thunderwood Poker
    ["22377"] = {
        234797, -- The Thunderwood Poker
    },
    -- Ravenholdt Slicer
    ["22378"] = {
        234792, -- Ravenholdt Slicer
    },
    -- Shivsprocket's Shiv
    ["22379"] = {
        234793, -- Shivsprocket's Shiv
    },
    -- Simone's Cultivating Hammer
    ["22380"] = {
        234800, -- Simone's Cultivating Hammer
    },
    -- Totem of Rage
    ["22395"] = {
        227977, -- Totem of Rage
    },
    -- Totem of Life
    ["22396"] = {
        233597, -- Totem of Life
    },
    -- Idol of Health
    ["22399"] = {
        233602, -- Idol of Health
    },
    -- Libram of Truth
    ["22400"] = {
        227976, -- Libram of Truth
    },
    -- Nacreous Shell Necklace
    ["22403"] = {
        228533, -- Nacreous Shell Necklace
    },
    -- Tunic of the Crescent Moon
    ["22409"] = {
        228551, -- Tunic of the Crescent Moon
    },
    -- Gauntlets of Deftness
    ["22410"] = {
        228552, -- Gauntlets of Deftness
    },
    -- Helm of the Executioner
    ["22411"] = {
        228553, -- Helm of the Executioner
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
    -- Don Mauricio's Band of Domination
    ["22433"] = {
        228046, -- Don Mauricio's Band of Domination
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
        236081, -- Frostfire Robe
    },
    -- Frostfire Leggings
    ["22497"] = {
        236079, -- Frostfire Leggings
    },
    -- Frostfire Circlet
    ["22498"] = {
        236083, -- Frostfire Circlet
    },
    -- Frostfire Shoulderpads
    ["22499"] = {
        236084, -- Frostfire Shoulderpads
    },
    -- Frostfire Sandals
    ["22500"] = {
        236080, -- Frostfire Sandals
    },
    -- Frostfire Gloves
    ["22501"] = {
        236082, -- Frostfire Gloves
    },
    -- Frostfire Belt
    ["22502"] = {
        236078, -- Frostfire Belt
    },
    -- Frostfire Bindings
    ["22503"] = {
        236077, -- Frostfire Bindings
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
    -- Primal Hakkari Idol
    ["22637"] = {
        231512, -- Primal Hakkari Idol
    },
    -- Glacial Vest
    ["22652"] = {
        236694, -- Glacial Vest
    },
    -- Glacial Gloves
    ["22654"] = {
        236692, -- Glacial Gloves
    },
    -- Glacial Wrists
    ["22655"] = {
        236693, -- Glacial Wrists
    },
    -- The Purifier
    ["22656"] = {
        237278, -- The Purifier
    },
    -- Amulet of the Dawn
    ["22657"] = {
        237279, -- Amulet of the Dawn
    },
    -- Glacial Cloak
    ["22658"] = {
        236690, -- Glacial Cloak
    },
    -- Medallion of the Dawn
    ["22659"] = {
        237280, -- Medallion of the Dawn
    },
    -- Polar Tunic
    ["22661"] = {
        236702, -- Polar Tunic
    },
    -- Polar Gloves
    ["22662"] = {
        236703, -- Polar Gloves
    },
    -- Polar Bracers
    ["22663"] = {
        236701, -- Polar Bracers
    },
    -- Icy Scale Breastplate
    ["22664"] = {
        236699, -- Icy Scale Breastplate
    },
    -- Icy Scale Bracers
    ["22665"] = {
        236698, -- Icy Scale Bracers
    },
    -- Icy Scale Gauntlets
    ["22666"] = {
        236700, -- Icy Scale Gauntlets
    },
    -- Bracers of Hope
    ["22667"] = {
        237281, -- Bracers of Hope
    },
    -- Bracers of Subterfuge
    ["22668"] = {
        237282, -- Bracers of Subterfuge
    },
    -- Icebane Breastplate
    ["22669"] = {
        236695, -- Icebane Breastplate
    },
    -- Icebane Gauntlets
    ["22670"] = {
        236697, -- Icebane Gauntlets
    },
    -- Icebane Bracers
    ["22671"] = {
        236696, -- Icebane Bracers
    },
    -- Talisman of Ascendance
    ["22678"] = {
        237283, -- Talisman of Ascendance
    },
    -- Supply Bag
    ["22679"] = {
        217014, -- Supply Bag
    },
    -- Band of Resolution
    ["22680"] = {
        237285, -- Band of Resolution
    },
    -- Band of Piety
    ["22681"] = {
        237286, -- Band of Piety
    },
    -- Frozen Rune
    ["22682"] = {
        236656, -- Frozen Rune
    },
    -- Verimonde's Last Resort
    ["22688"] = {
        237287, -- Verimonde's Last Resort
    },
    -- Sanctified Leather Helm
    ["22689"] = {
        237288, -- Sanctified Leather Helm
    },
    -- Leggings of the Plague Hunter
    ["22690"] = {
        237289, -- Leggings of the Plague Hunter
    },
    -- Corrupted Ashbringer
    ["22691"] = {
        236317, -- Corrupted Ashbringer
    },
    -- Icebane Leggings
    ["22699"] = {
        237290, -- Icebane Leggings
    },
    -- Glacial Leggings
    ["22700"] = {
        237291, -- Glacial Leggings
    },
    -- Polar Leggings
    ["22701"] = {
        237292, -- Polar Leggings
    },
    -- Icy Scale Leggings
    ["22702"] = {
        237293, -- Icy Scale Leggings
    },
    -- Ramaladni's Icy Grasp
    ["22707"] = {
        237294, -- Ramaladni's Icy Grasp
    },
    -- Cloak of the Hakkari Worshipers
    ["22711"] = {
        230858, -- Cloak of the Hakkari Worshipers
    },
    -- Might of the Tribe
    ["22712"] = {
        230860, -- Might of the Tribe
    },
    -- Zulian Scepter of Rites
    ["22713"] = {
        230863, -- Zulian Scepter of Rites
    },
    -- Sacrificial Gauntlets
    ["22714"] = {
        230861, -- Sacrificial Gauntlets
    },
    -- Gloves of the Tormented
    ["22715"] = {
        230859, -- Gloves of the Tormented
    },
    -- Belt of Untapped Power
    ["22716"] = {
        230856, -- Belt of Untapped Power
    },
    -- Blooddrenched Mask
    ["22718"] = {
        230857, -- Blooddrenched Mask
    },
    -- Zulian Headdress
    ["22720"] = {
        230862, -- Zulian Headdress
    },
    -- Band of Servitude
    ["22721"] = {
        230854, -- Band of Servitude
    },
    -- Seal of the Gurubashi Berserker
    ["22722"] = {
        230855, -- Seal of the Gurubashi Berserker
    },
    -- Splinter of Atiesh
    ["22726"] = {
        22589, -- Atiesh, Greatstaff of the Guardian (mage)
        22630, -- Atiesh, Greatstaff of the Guardian (warlock)
        22631, -- Atiesh, Greatstaff of the Guardian (priest)
        22632, -- Atiesh, Greatstaff of the Guardian (druid)
        22727, -- Frame of Atiesh
        22733, -- Staff Head of Atiesh
        22734, -- Base of Atiesh
        22737, -- Atiesh, Greatstaff of the Guardian
        236398, -- Atiesh, Greatstaff of the Guardian (Warlock)
        236399, -- Atiesh, Greatstaff of the Guardian (Priest)
        236400, -- Atiesh, Greatstaff of the Guardian (Mage)
        236401, -- Atiesh, Greatstaff of the Guardian (Druid)
    },
    -- Frame of Atiesh
    ["22727"] = {
        22726, -- Splinter of Atiesh
    },
    -- Eyestalk Waist Cord
    ["22730"] = {
        233633, -- Eyestalk Waist Cord
    },
    -- Cloak of the Devoured
    ["22731"] = {
        233630, -- Cloak of the Devoured
    },
    -- Mark of C'Thun
    ["22732"] = {
        233642, -- Mark of C'Thun
    },
    -- Staff Head of Atiesh
    ["22733"] = {
        22726, -- Splinter of Atiesh
    },
    -- Base of Atiesh
    ["22734"] = {
        22726, -- Splinter of Atiesh
    },
    -- Atiesh, Greatstaff of the Guardian
    ["22737"] = {
        22726, -- Splinter of Atiesh
    },
    -- Sylvan Vest
    ["22756"] = {
        234317, -- Sylvan Vest
    },
    -- Sylvan Crown
    ["22757"] = {
        234315, -- Sylvan Crown
    },
    -- Sylvan Shoulders
    ["22758"] = {
        234312, -- Sylvan Shoulders
    },
    -- Bramblewood Helm
    ["22759"] = {
        234310, -- Bramblewood Helm
    },
    -- Bramblewood Boots
    ["22760"] = {
        234308, -- Bramblewood Boots
    },
    -- Bramblewood Belt
    ["22761"] = {
        234306, -- Bramblewood Belt
    },
    -- Ironvine Breastplate
    ["22762"] = {
        234292, -- Ironvine Breastplate
    },
    -- Ironvine Gloves
    ["22763"] = {
        234290, -- Ironvine Gloves
    },
    -- Ironvine Belt
    ["22764"] = {
        234288, -- Ironvine Belt
    },
    -- Plans: Ironvine Breastplate
    ["22766"] = {
        234293, -- Plans: Ironvine Breastplate
    },
    -- Plans: Ironvine Gloves
    ["22767"] = {
        234291, -- Plans: Ironvine Gloves
    },
    -- Plans: Ironvine Belt
    ["22768"] = {
        234289, -- Plans: Ironvine Belt
    },
    -- Pattern: Bramblewood Belt
    ["22769"] = {
        234307, -- Pattern: Bramblewood Belt
    },
    -- Pattern: Bramblewood Boots
    ["22770"] = {
        234309, -- Pattern: Bramblewood Boots
    },
    -- Pattern: Bramblewood Helm
    ["22771"] = {
        234311, -- Pattern: Bramblewood Helm
    },
    -- Pattern: Sylvan Shoulders
    ["22772"] = {
        234314, -- Pattern: Sylvan Shoulders
    },
    -- Pattern: Sylvan Crown
    ["22773"] = {
        234316, -- Pattern: Sylvan Crown
    },
    -- Pattern: Sylvan Vest
    ["22774"] = {
        234318, -- Pattern: Sylvan Vest
    },
    -- Might of Menethil
    ["22798"] = {
        236340, -- Might of Menethil
    },
    -- Soulseeker
    ["22799"] = {
        236346, -- Soulseeker
    },
    -- Brimstone Staff
    ["22800"] = {
        236284, -- Brimstone Staff
    },
    -- Spire of Twilight
    ["22801"] = {
        236305, -- Spire of Twilight
    },
    -- Kingsfall
    ["22802"] = {
        236343, -- Kingsfall
    },
    -- Midnight Haze
    ["22803"] = {
        236292, -- Midnight Haze
    },
    -- Maexxna's Fang
    ["22804"] = {
        236269, -- Maexxna's Fang
    },
    -- Widow's Remorse
    ["22806"] = {
        236263, -- Widow's Remorse
    },
    -- Wraith Blade
    ["22807"] = {
        236265, -- Wraith Blade
    },
    -- The Castigator
    ["22808"] = {
        236306, -- The Castigator
    },
    -- Maul of the Redeemed Crusader
    ["22809"] = {
        236321, -- Maul of the Redeemed Crusader
    },
    -- Toxin Injector
    ["22810"] = {
        236293, -- Toxin Injector
    },
    -- Soulstring
    ["22811"] = {
        236322, -- Soulstring
    },
    -- Nerubian Slavemaker
    ["22812"] = {
        236344, -- Nerubian Slavemaker
    },
    -- Claymore of Unholy Might
    ["22813"] = {
        236299, -- Claymore of Unholy Might
    },
    -- Severance
    ["22815"] = {
        236287, -- Severance
    },
    -- Hatchet of Sundered Bone
    ["22816"] = {
        236270, -- Hatchet of Sundered Bone
    },
    -- The Plague Bearer
    ["22818"] = {
        236288, -- The Plague Bearer
    },
    -- Shield of Condemnation
    ["22819"] = {
        236347, -- Shield of Condemnation
    },
    -- Wand of Fates
    ["22820"] = {
        236290, -- Wand of Fates
    },
    -- Doomfinger
    ["22821"] = {
        236349, -- Doomfinger
    },
    -- Blood Guard's Chain Greaves
    ["22843"] = {
        227074, -- Blood Guard's Chain Greaves
    },
    -- Blood Guard's Dragonhide Treads
    ["22852"] = {
        227181, -- Blood Guard's Dragonhide Treads
    },
    -- Blood Guard's Dreadweave Walkers
    ["22855"] = {
        227098, -- Blood Guard's Dreadweave Walkers
    },
    -- Blood Guard's Leather Walkers
    ["22856"] = {
        227062, -- Blood Guard's Leather Walkers
    },
    -- Blood Guard's Mail Greaves
    ["22857"] = {
        227158, -- Blood Guard's Mail Greaves
    },
    -- Blood Guard's Plate Greaves
    ["22858"] = {
        227051, -- Blood Guard's Plate Greaves
    },
    -- Blood Guard's Satin Walkers
    ["22859"] = {
        227127, -- Blood Guard's Satin Walkers
    },
    -- Blood Guard's Silk Walkers
    ["22860"] = {
        227110, -- Blood Guard's Silk Walkers
    },
    -- Blood Guard's Chain Vices
    ["22862"] = {
        227075, -- Blood Guard's Chain Vices
    },
    -- Blood Guard's Dragonhide Grips
    ["22863"] = {
        227180, -- Blood Guard's Dragonhide Grips
    },
    -- Blood Guard's Leather Grips
    ["22864"] = {
        227063, -- Blood Guard's Leather Grips
    },
    -- Blood Guard's Dreadweave Handwraps
    ["22865"] = {
        227099, -- Blood Guard's Dreadweave Handwraps
    },
    -- Blood Guard's Mail Vices
    ["22867"] = {
        227159, -- Blood Guard's Mail Vices
    },
    -- Blood Guard's Plate Gauntlets
    ["22868"] = {
        227050, -- Blood Guard's Plate Gauntlets
    },
    -- Blood Guard's Satin Handwraps
    ["22869"] = {
        227126, -- Blood Guard's Satin Handwraps
    },
    -- Blood Guard's Silk Handwraps
    ["22870"] = {
        227111, -- Blood Guard's Silk Handwraps
    },
    -- Legionnaire's Plate Hauberk
    ["22872"] = {
        227049, -- Legionnaire's Plate Hauberk
    },
    -- Legionnaire's Plate Leggings
    ["22873"] = {
        227048, -- Legionnaire's Plate Leggings
    },
    -- Legionnaire's Chain Hauberk
    ["22874"] = {
        227071, -- Legionnaire's Chain Hauberk
    },
    -- Legionnaire's Chain Legguards
    ["22875"] = {
        227073, -- Legionnaire's Chain Legguards
    },
    -- Legionnaire's Mail Hauberk
    ["22876"] = {
        227157, -- Legionnaire's Mail Hauberk
    },
    -- Legionnaire's Dragonhide Chestpiece
    ["22877"] = {
        227179, -- Legionnaire's Dragonhide Chestpiece
    },
    -- Legionnaire's Dragonhide Leggings
    ["22878"] = {
        227177, -- Legionnaire's Dragonhide Leggings
    },
    -- Legionnaire's Leather Chestpiece
    ["22879"] = {
        227060, -- Legionnaire's Leather Chestpiece
    },
    -- Legionnaire's Leather Legguards
    ["22880"] = {
        227059, -- Legionnaire's Leather Legguards
    },
    -- Legionnaire's Dreadweave Legguards
    ["22881"] = {
        227097, -- Legionnaire's Dreadweave Legguards
    },
    -- Legionnaire's Satin Legguards
    ["22882"] = {
        227123, -- Legionnaire's Satin Legguards
    },
    -- Legionnaire's Silk Legguards
    ["22883"] = {
        227107, -- Legionnaire's Silk Legguards
    },
    -- Legionnaire's Dreadweave Tunic
    ["22884"] = {
        227094, -- Legionnaire's Dreadweave Tunic
    },
    -- Legionnaire's Satin Tunic
    ["22885"] = {
        227124, -- Legionnaire's Satin Tunic
    },
    -- Legionnaire's Silk Tunic
    ["22886"] = {
        227106, -- Legionnaire's Silk Tunic
    },
    -- Legionnaire's Mail Legguards
    ["22887"] = {
        227156, -- Legionnaire's Mail Legguards
    },
    -- Touch of Frost
    ["22935"] = {
        236256, -- Touch of Frost
    },
    -- Wristguards of Vengeance
    ["22936"] = {
        236255, -- Wristguards of Vengeance
    },
    -- Gem of Nerubis
    ["22937"] = {
        236257, -- Gem of Nerubis
    },
    -- Cryptfiend Silk Cloak
    ["22938"] = {
        236258, -- Cryptfiend Silk Cloak
    },
    -- Band of Unanswered Prayers
    ["22939"] = {
        236259, -- Band of Unanswered Prayers
    },
    -- Icebane Pauldrons
    ["22940"] = {
        236260, -- Icebane Pauldrons
    },
    -- Polar Shoulder Pads
    ["22941"] = {
        236262, -- Polar Shoulder Pads
    },
    -- The Widow's Embrace
    ["22942"] = {
        236264, -- The Widow's Embrace
    },
    -- Malice Stone Pendant
    ["22943"] = {
        236261, -- Malice Stone Pendant
    },
    -- Pendant of Forgotten Names
    ["22947"] = {
        236266, -- Pendant of Forgotten Names
    },
    -- Kiss of the Spider
    ["22954"] = {
        236268, -- Kiss of the Spider
    },
    -- Cloak of Suturing
    ["22960"] = {
        236289, -- Cloak of Suturing
    },
    -- Band of Reanimation
    ["22961"] = {
        236291, -- Band of Reanimation
    },
    -- Icy Scale Spaulders
    ["22967"] = {
        236294, -- Icy Scale Spaulders
    },
    -- Glacial Mantle
    ["22968"] = {
        236295, -- Glacial Mantle
    },
    -- Gluth's Missing Collar
    ["22981"] = {
        236300, -- Gluth's Missing Collar
    },
    -- Rime Covered Mantle
    ["22983"] = {
        236298, -- Rime Covered Mantle
    },
    -- The End of Dreams
    ["22988"] = {
        236297, -- The End of Dreams
    },
    -- Digested Hand of Power
    ["22994"] = {
        236301, -- Digested Hand of Power
    },
    -- Plated Abomination Ribcage
    ["23000"] = {
        236304, -- Plated Abomination Ribcage
    },
    -- Eye of Diminution
    ["23001"] = {
        236302, -- Eye of Diminution
    },
    -- Idol of Longevity
    ["23004"] = {
        236308, -- Idol of Longevity
    },
    -- Totem of Flowing Water
    ["23005"] = {
        236276, -- Totem of Flowing Water
    },
    -- Libram of Light
    ["23006"] = {
        236271, -- Libram of Light
    },
    -- Wand of the Whispering Dead
    ["23009"] = {
        236310, -- Wand of the Whispering Dead
    },
    -- Iblis, Blade of the Fallen Seraph
    ["23014"] = {
        236312, -- Iblis, Blade of the Fallen Seraph
    },
    -- Veil of Eclipse
    ["23017"] = {
        236307, -- Veil of Eclipse
    },
    -- Signet of the Fallen Defender
    ["23018"] = {
        236311, -- Signet of the Fallen Defender
    },
    -- Icebane Helmet
    ["23019"] = {
        237275, -- Icebane Helmet
    },
    -- Polar Helmet
    ["23020"] = {
        236315, -- Polar Helmet
    },
    -- The Soul Harvester's Bindings
    ["23021"] = {
        236313, -- The Soul Harvester's Bindings
    },
    -- Sadist's Collar
    ["23023"] = {
        236316, -- Sadist's Collar
    },
    -- Seal of the Damned
    ["23025"] = {
        236318, -- Seal of the Damned
    },
    -- Warmth of Forgiveness
    ["23027"] = {
        236320, -- Warmth of Forgiveness
    },
    -- Hailstone Band
    ["23028"] = {
        236274, -- Hailstone Band
    },
    -- Noth's Frigid Heart
    ["23029"] = {
        236275, -- Noth's Frigid Heart
    },
    -- Cloak of the Scourge
    ["23030"] = {
        236272, -- Cloak of the Scourge
    },
    -- Band of the Inevitable
    ["23031"] = {
        236273, -- Band of the Inevitable
    },
    -- Glacial Headdress
    ["23032"] = {
        236278, -- Glacial Headdress
    },
    -- Icy Scale Coif
    ["23033"] = {
        236281, -- Icy Scale Coif
    },
    -- Preceptor's Hat
    ["23035"] = {
        236279, -- Preceptor's Hat
    },
    -- Necklace of Necropsy
    ["23036"] = {
        236277, -- Necklace of Necropsy
    },
    -- Ring of Spiritual Fervor
    ["23037"] = {
        236283, -- Ring of Spiritual Fervor
    },
    -- Band of Unnatural Forces
    ["23038"] = {
        236286, -- Band of Unnatural Forces
    },
    -- The Eye of Nerub
    ["23039"] = {
        236285, -- The Eye of Nerub
    },
    -- Glyph of Deflection
    ["23040"] = {
        236337, -- Glyph of Deflection
    },
    -- Slayer's Crest
    ["23041"] = {
        236334, -- Slayer's Crest
    },
    -- Loatheb's Reflection
    ["23042"] = {
        236282, -- Loatheb's Reflection
    },
    -- The Face of Death
    ["23043"] = {
        236336, -- The Face of Death
    },
    -- Harbinger of Doom
    ["23044"] = {
        236219, -- Harbinger of Doom
    },
    -- Shroud of Dominion
    ["23045"] = {
        236333, -- Shroud of Dominion
    },
    -- The Restrained Essence of Sapphiron
    ["23046"] = {
        236331, -- The Restrained Essence of Sapphiron
    },
    -- Eye of the Dead
    ["23047"] = {
        236329, -- Eye of the Dead
    },
    -- Sapphiron's Right Eye
    ["23048"] = {
        236330, -- Sapphiron's Right Eye
    },
    -- Sapphiron's Left Eye
    ["23049"] = {
        236328, -- Sapphiron's Left Eye
    },
    -- Cloak of the Necropolis
    ["23050"] = {
        236327, -- Cloak of the Necropolis
    },
    -- Stormrage's Talisman of Seething
    ["23053"] = {
        236342, -- Stormrage's Talisman of Seething
    },
    -- Gressil, Dawn of Ruin
    ["23054"] = {
        236339, -- Gressil, Dawn of Ruin
    },
    -- Hammer of the Twisting Nether
    ["23056"] = {
        236348, -- Hammer of the Twisting Nether
    },
    -- Gem of Trapped Innocents
    ["23057"] = {
        236345, -- Gem of Trapped Innocents
    },
    -- Ring of the Dreadnaught
    ["23059"] = {
        236013, -- Ring of the Dreadnaught
    },
    -- Bonescythe Ring
    ["23060"] = {
        236031, -- Bonescythe Ring
    },
    -- Ring of Faith
    ["23061"] = {
        236105, -- Ring of Faith
    },
    -- Frostfire Ring
    ["23062"] = {
        236085, -- Frostfire Ring
    },
    -- Plagueheart Ring
    ["23063"] = {
        236067, -- Plagueheart Ring
    },
    -- Ring of The Dreamwalker
    ["23064"] = {
        236190, -- Ring of the Dreamwalker
    },
    -- Ring of the Earthshatterer
    ["23065"] = {
        236150, -- Ring of the Earthshatterer
    },
    -- Ring of Redemption
    ["23066"] = {
        236116, -- Ring of Redemption
    },
    -- Ring of the Cryptstalker
    ["23067"] = {
        236041, -- Ring of the Cryptstalker
    },
    -- Legplates of Carnage
    ["23068"] = {
        236280, -- Legplates of Carnage
    },
    -- Necro-Knight's Garb
    ["23069"] = {
        236220, -- Necro-Knight's Garb
    },
    -- Leggings of Polarity
    ["23070"] = {
        236303, -- Leggings of Polarity
    },
    -- Leggings of Apocalypse
    ["23071"] = {
        236319, -- Leggings of Apocalypse
    },
    -- Fists of the Unrelenting
    ["23072"] = {
        236335, -- Fists of the Unrelenting
    },
    -- Boots of Displacement
    ["23073"] = {
        236314, -- Boots of Displacement
    },
    -- Death's Bargain
    ["23075"] = {
        236296, -- Death's Bargain
    },
    -- Gauntlets of Undead Slaying
    ["23078"] = {
        236714, -- Gauntlets of Undead Slaying
    },
    -- Handwraps of Undead Slaying
    ["23081"] = {
        236713, -- Handwraps of Undead Slaying
    },
    -- Handguards of Undead Slaying
    ["23082"] = {
        236715, -- Handguards of Undead Slaying
    },
    -- Gloves of Undead Cleansing
    ["23084"] = {
        236717, -- Gloves of Undead Cleansing
    },
    -- Robe of Undead Cleansing
    ["23085"] = {
        236718, -- Robe of Undead Cleansing
    },
    -- Breastplate of Undead Slaying
    ["23087"] = {
        236708, -- Breastplate of Undead Slaying
    },
    -- Chestguard of Undead Slaying
    ["23088"] = {
        236709, -- Chestguard of Undead Slaying
    },
    -- Tunic of Undead Slaying
    ["23089"] = {
        236707, -- Tunic of Undead Slaying
    },
    -- Bracers of Undead Slaying
    ["23090"] = {
        236712, -- Bracers of Undead Slaying
    },
    -- Bracers of Undead Cleansing
    ["23091"] = {
        236716, -- Bracers of Undead Cleansing
    },
    -- Wristguards of Undead Slaying
    ["23092"] = {
        236710, -- Wristguards of Undead Slaying
    },
    -- Wristwraps of Undead Slaying
    ["23093"] = {
        236711, -- Wristwraps of Undead Slaying
    },
    -- Lord Blackwood's Buckler
    ["23139"] = {
        228035, -- Lord Blackwood's Buckler
    },
    -- Totem of Sustaining
    ["23200"] = {
        228049, -- Totem of Sustaining
    },
    -- Libram of Divinity
    ["23201"] = {
        228048, -- Libram of Divinity
    },
    -- Mark of the Champion
    ["23206"] = {
        22520, -- The Phylactery of Kel'Thuzad
    },
    -- Mark of the Champion
    ["23207"] = {
        22520, -- The Phylactery of Kel'Thuzad
    },
    -- Girdle of the Mentor
    ["23219"] = {
        236309, -- Girdle of the Mentor
    },
    -- Crystal Webbed Robe
    ["23220"] = {
        236267, -- Crystal Webbed Robe
    },
    -- Misplaced Servo Arm
    ["23221"] = {
        236221, -- Misplaced Servo Arm
    },
    -- Ghoul Skin Tunic
    ["23226"] = {
        236222, -- Ghoul Skin Tunic
    },
    -- Ring of the Eternal Flame
    ["23237"] = {
        236223, -- Ring of the Eternal Flame
    },
    -- Stygian Buckler
    ["23238"] = {
        236224, -- Stygian Buckler
    },
    -- Claw of the Frost Wyrm
    ["23242"] = {
        236338, -- Claw of the Frost Wyrm
    },
    -- Champion's Plate Shoulders
    ["23243"] = {
        227042, -- Champion's Plate Shoulders
    },
    -- Champion's Plate Helm
    ["23244"] = {
        227043, -- Champion's Plate Helm
    },
    -- Champion's Chain Helm
    ["23251"] = {
        227067, -- Champion's Chain Helm
    },
    -- Champion's Chain Shoulders
    ["23252"] = {
        227069, -- Champion's Chain Shoulders
    },
    -- Champion's Dragonhide Headguard
    ["23253"] = {
        227174, -- Champion's Dragonhide Headguard
    },
    -- Champion's Dragonhide Shoulders
    ["23254"] = {
        227175, -- Champion's Dragonhide Shoulders
    },
    -- Champion's Dreadweave Cowl
    ["23255"] = {
        227090, -- Champion's Dreadweave Cowl
    },
    -- Champion's Dreadweave Spaulders
    ["23256"] = {
        227092, -- Champion's Dreadweave Spaulders
    },
    -- Champion's Leather Helm
    ["23257"] = {
        227057, -- Champion's Leather Helm
    },
    -- Champion's Leather Shoulders
    ["23258"] = {
        227056, -- Champion's Leather Shoulders
    },
    -- Champion's Mail Headguard
    ["23259"] = {
        227155, -- Champion's Mail Headguard
    },
    -- Champion's Mail Pauldrons
    ["23260"] = {
        227154, -- Champion's Mail Pauldrons
    },
    -- Champion's Satin Hood
    ["23261"] = {
        227118, -- Champion's Satin Hood
    },
    -- Champion's Satin Mantle
    ["23262"] = {
        227120, -- Champion's Satin Mantle
    },
    -- Champion's Silk Cowl
    ["23263"] = {
        227105, -- Champion's Silk Cowl
    },
    -- Champion's Silk Mantle
    ["23264"] = {
        227104, -- Champion's Silk Mantle
    },
    -- Knight-Captain's Lamellar Breastplate
    ["23272"] = {
        227142, -- Knight-Captain's Lamellar Breastplate
    },
    -- Knight-Captain's Lamellar Leggings
    ["23273"] = {
        227143, -- Knight-Captain's Lamellar Leggings
    },
    -- Knight-Lieutenant's Lamellar Gauntlets
    ["23274"] = {
        227147, -- Knight-Lieutenant's Lamellar Gauntlets
    },
    -- Knight-Lieutenant's Lamellar Sabatons
    ["23275"] = {
        227146, -- Knight-Lieutenant's Lamellar Sabatons
    },
    -- Lieutenant Commander's Lamellar Headguard
    ["23276"] = {
        227144, -- Lieutenant Commander's Lamellar Headguard
    },
    -- Lieutenant Commander's Lamellar Shoulders
    ["23277"] = {
        227145, -- Lieutenant Commander's Lamellar Shoulders
    },
    -- Knight-Lieutenant's Chain Greaves
    ["23278"] = {
        227076, -- Knight-Lieutenant's Chain Greaves
    },
    -- Knight-Lieutenant's Chain Vices
    ["23279"] = {
        227077, -- Knight-Lieutenant's Chain Vices
    },
    -- Knight-Lieutenant's Dragonhide Grips
    ["23280"] = {
        227183, -- Knight-Lieutenant's Dragonhide Grips
    },
    -- Knight-Lieutenant's Dragonhide Treads
    ["23281"] = {
        227182, -- Knight-Lieutenant's Dragonhide Treads
    },
    -- Knight-Lieutenant's Dreadweave Handwraps
    ["23282"] = {
        227100, -- Knight-Lieutenant's Dreadweave Handwraps
    },
    -- Knight-Lieutenant's Dreadweave Walkers
    ["23283"] = {
        227101, -- Knight-Lieutenant's Dreadweave Walkers
    },
    -- Knight-Lieutenant's Leather Grips
    ["23284"] = {
        227065, -- Knight-Lieutenant's Leather Grips
    },
    -- Knight-Lieutenant's Leather Walkers
    ["23285"] = {
        227064, -- Knight-Lieutenant's Leather Walkers
    },
    -- Knight-Lieutenant's Plate Gauntlets
    ["23286"] = {
        227053, -- Knight-Lieutenant's Plate Gauntlets
    },
    -- Knight-Lieutenant's Plate Greaves
    ["23287"] = {
        227052, -- Knight-Lieutenant's Plate Greaves
    },
    -- Knight-Lieutenant's Satin Handwraps
    ["23288"] = {
        227128, -- Knight-Lieutenant's Satin Handwraps
    },
    -- Knight-Lieutenant's Satin Walkers
    ["23289"] = {
        227129, -- Knight-Lieutenant's Satin Walkers
    },
    -- Knight-Lieutenant's Silk Handwraps
    ["23290"] = {
        227113, -- Knight-Lieutenant's Silk Handwraps
    },
    -- Knight-Lieutenant's Silk Walkers
    ["23291"] = {
        227112, -- Knight-Lieutenant's Silk Walkers
    },
    -- Knight-Captain's Chain Hauberk
    ["23292"] = {
        227070, -- Knight-Captain's Chain Hauberk
    },
    -- Knight-Captain's Chain Legguards
    ["23293"] = {
        227072, -- Knight-Captain's Chain Legguards
    },
    -- Knight-Captain's Dragonhide Chestpiece
    ["23294"] = {
        227176, -- Knight-Captain's Dragonhide Chestpiece
    },
    -- Knight-Captain's Dragonhide Leggings
    ["23295"] = {
        227178, -- Knight-Captain's Dragonhide Leggings
    },
    -- Knight-Captain's Dreadweave Legguards
    ["23296"] = {
        227095, -- Knight-Captain's Dreadweave Legguards
    },
    -- Knight-Captain's Dreadweave Tunic
    ["23297"] = {
        227096, -- Knight-Captain's Dreadweave Tunic
    },
    -- Knight-Captain's Leather Chestpiece
    ["23298"] = {
        227058, -- Knight-Captain's Leather Chestpiece
    },
    -- Knight-Captain's Leather Legguards
    ["23299"] = {
        227061, -- Knight-Captain's Leather Legguards
    },
    -- Knight-Captain's Plate Hauberk
    ["23300"] = {
        227046, -- Knight-Captain's Plate Hauberk
    },
    -- Knight-Captain's Plate Leggings
    ["23301"] = {
        227047, -- Knight-Captain's Plate Leggings
    },
    -- Knight-Captain's Satin Legguards
    ["23302"] = {
        227125, -- Knight-Captain's Satin Legguards
    },
    -- Knight-Captain's Satin Tunic
    ["23303"] = {
        227122, -- Knight-Captain's Satin Tunic
    },
    -- Knight-Captain's Silk Legguards
    ["23304"] = {
        227109, -- Knight-Captain's Silk Legguards
    },
    -- Knight-Captain's Silk Tunic
    ["23305"] = {
        227108, -- Knight-Captain's Silk Tunic
    },
    -- Lieutenant Commander's Chain Helm
    ["23306"] = {
        227066, -- Lieutenant Commander's Chain Helm
    },
    -- Lieutenant Commander's Chain Shoulders
    ["23307"] = {
        227068, -- Lieutenant Commander's Chain Shoulders
    },
    -- Lieutenant Commander's Dragonhide Headguard
    ["23308"] = {
        227173, -- Lieutenant Commander's Dragonhide Headguard
    },
    -- Lieutenant Commander's Dragonhide Shoulders
    ["23309"] = {
        227172, -- Lieutenant Commander's Dragonhide Shoulders
    },
    -- Lieutenant Commander's Dreadweave Cowl
    ["23310"] = {
        227093, -- Lieutenant Commander's Dreadweave Cowl
    },
    -- Lieutenant Commander's Dreadweave Spaulders
    ["23311"] = {
        227091, -- Lieutenant Commander's Dreadweave Spaulders
    },
    -- Lieutenant Commander's Leather Helm
    ["23312"] = {
        227055, -- Lieutenant Commander's Leather Helm
    },
    -- Lieutenant Commander's Leather Shoulders
    ["23313"] = {
        227054, -- Lieutenant Commander's Leather Shoulders
    },
    -- Lieutenant Commander's Plate Helm
    ["23314"] = {
        227044, -- Lieutenant Commander's Plate Helm
    },
    -- Lieutenant Commander's Plate Shoulders
    ["23315"] = {
        227045, -- Lieutenant Commander's Plate Shoulders
    },
    -- Lieutenant Commander's Satin Hood
    ["23316"] = {
        227121, -- Lieutenant Commander's Satin Hood
    },
    -- Lieutenant Commander's Satin Mantle
    ["23317"] = {
        227119, -- Lieutenant Commander's Satin Mantle
    },
    -- Lieutenant Commander's Silk Cowl
    ["23318"] = {
        227103, -- Lieutenant Commander's Silk Cowl
    },
    -- Lieutenant Commander's Silk Mantle
    ["23319"] = {
        227102, -- Lieutenant Commander's Silk Mantle
    },
    -- Grand Marshal's Mageblade
    ["23451"] = {
        234574, -- Grand Marshal's Mageblade
    },
    -- Grand Marshal's Tome of Power
    ["23452"] = {
        234589, -- Grand Marshal's Tome of Power
    },
    -- Grand Marshal's Tome of Restoration
    ["23453"] = {
        234590, -- Grand Marshal's Tome of Restoration
    },
    -- Grand Marshal's Warhammer
    ["23454"] = {
        234576, -- Grand Marshal's Warhammer
    },
    -- Grand Marshal's Demolisher
    ["23455"] = {
        234568, -- Grand Marshal's Demolisher
    },
    -- Grand Marshal's Swiftblade
    ["23456"] = {
        234579, -- Grand Marshal's Swiftblade
    },
    -- High Warlord's Battle Mace
    ["23464"] = {
        234551, -- High Warlord's Battle Mace
    },
    -- High Warlord's Destroyer
    ["23465"] = {
        234546, -- High Warlord's Destroyer
    },
    -- High Warlord's Spellblade
    ["23466"] = {
        234550, -- High Warlord's Spellblade
    },
    -- High Warlord's Quickblade
    ["23467"] = {
        234553, -- High Warlord's Quickblade
    },
    -- High Warlord's Tome of Destruction
    ["23468"] = {
        234563, -- High Warlord's Tome of Destruction
    },
    -- High Warlord's Tome of Mending
    ["23469"] = {
        234564, -- High Warlord's Tome of Mending
    },
    -- Fel Edged Battleaxe
    ["23542"] = {
        23631, -- Plans: Fel Edged Battleaxe
    },
    -- Power of the Scourge
    ["23545"] = {
        236324, -- Power of the Scourge
    },
    -- Resilience of the Scourge
    ["23547"] = {
        236323, -- Resilience of the Scourge
    },
    -- Might of the Scourge
    ["23548"] = {
        236326, -- Might of the Scourge
    },
    -- Fortitude of the Scourge
    ["23549"] = {
        236325, -- Fortitude of the Scourge
    },
    -- Larvae of the Great Worm
    ["23557"] = {
        233626, -- Larvae of the Great Worm
    },
    -- The Burrower's Shell
    ["23558"] = {
        233628, -- The Burrower's Shell
    },
    -- Jom Gabbar
    ["23570"] = {
        233627, -- Jom Gabbar
    },
    -- The Hungering Cold
    ["23577"] = {
        236341, -- The Hungering Cold
    },
    -- Plans: Fel Edged Battleaxe
    ["23631"] = {
        23542, -- Fel Edged Battleaxe
    },
    -- Girdle of Elemental Fury
    ["23663"] = {
        236225, -- Girdle of Elemental Fury
    },
    -- Pauldrons of Elemental Fury
    ["23664"] = {
        236226, -- Pauldrons of Elemental Fury
    },
    -- Leggings of Elemental Fury
    ["23665"] = {
        236230, -- Leggings of Elemental Fury
    },
    -- Belt of the Grand Crusader
    ["23666"] = {
        236227, -- Belt of the Grand Crusader
    },
    -- Spaulders of the Grand Crusader
    ["23667"] = {
        236228, -- Spaulders of the Grand Crusader
    },
    -- Leggings of the Grand Crusader
    ["23668"] = {
        236229, -- Leggings of the Grand Crusader
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
    -- Theck's Emberseal
    ["71367"] = {
        71564, -- Theck's Emberseal
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
    -- Obsidian Arborweave Robes
    ["71494"] = {
        71672, -- Chest of the Fiery Vanquisher
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
        71367, -- Theck's Emberseal
    },
    -- Covenant of the Flame
    ["71567"] = {
        71617, -- Crystallized Firestone
    },
    -- Morningstar Shard
    ["71568"] = {
        71617, -- Crystallized Firestone
    },
    -- Trail of Embers
    ["71575"] = {
        71617, -- Crystallized Firestone
    },
    -- Singed Plume of Aviana
    ["71577"] = {
        71617, -- Crystallized Firestone
    },
    -- Scorchvine Wand
    ["71579"] = {
        71617, -- Crystallized Firestone
    },
    -- Soulflame Vial
    ["71580"] = {
        71617, -- Crystallized Firestone
    },
    -- Relic of the Elemental Lords
    ["71587"] = {
        71617, -- Crystallized Firestone
    },
    -- Deathclutch Figurine
    ["71590"] = {
        71617, -- Crystallized Firestone
    },
    -- Deflecting Star
    ["71592"] = {
        71617, -- Crystallized Firestone
    },
    -- Giantslicer
    ["71593"] = {
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
        71567, -- Covenant of the Flame
        71568, -- Morningstar Shard
        71575, -- Trail of Embers
        71577, -- Singed Plume of Aviana
        71579, -- Scorchvine Wand
        71580, -- Soulflame Vial
        71587, -- Relic of the Elemental Lords
        71590, -- Deathclutch Figurine
        71592, -- Deflecting Star
        71593, -- Giantslicer
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
        71494, -- Obsidian Arborweave Robes
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
    -- Fathom Core
    ["204270"] = {
        16762, -- Fathom Core
    },
    -- Mortar and Pestle
    ["206176"] = {
        15454, -- Mortar and Pestle
    },
    -- Rune of Metamorphosis
    ["210980"] = {
        19340, -- Rune of Metamorphosis
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
    -- Strange Water Globe
    ["211454"] = {
        16782, -- Strange Water Globe
    },
    -- Mechbuilder's Overalls
    ["213298"] = {
        9508, -- Mechbuilder's Overalls
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
    -- Reins of the Bengal Tiger
    ["216549"] = {
        8630, -- Reins of the Bengal Tiger
    },
    -- Reins of the Golden Sabercat
    ["216570"] = {
        12327, -- Reins of the Golden Sabercat
    },
    -- Grime-Encrusted Ring
    ["216661"] = {
        9326, -- Grime-Encrusted Ring
    },
    -- Brilliant Gold Ring
    ["216662"] = {
        9362, -- Brilliant Gold Ring
    },
    -- Sergeant Major's Dragonhide Armsplints
    ["216698"] = {
        18454, -- Sergeant Major's Dragonhide Armsplints
        18455, -- Sergeant Major's Dragonhide Armsplints
    },
    -- Sergeant Major's Chain Armguards
    ["216699"] = {
        18448, -- Sergeant Major's Chain Armguards
        18449, -- Sergeant Major's Chain Armguards
    },
    -- Sergeant Major's Leather Armsplints
    ["216700"] = {
        18452, -- Sergeant Major's Leather Armsplints
        18453, -- Sergeant Major's Leather Armsplints
    },
    -- Sergeant Major's Plate Wristguards
    ["216701"] = {
        18445, -- Sergeant Major's Plate Wristguards
        18447, -- Sergeant Major's Plate Wristguards
    },
    -- Sergeant Major's Silk Cuffs
    ["216702"] = {
        18456, -- Sergeant Major's Silk Cuffs
        18457, -- Sergeant Major's Silk Cuffs
    },
    -- First Sergeant's Mail Wristguards
    ["216703"] = {
        16532, -- First Sergeant's Mail Wristguards
        18432, -- First Sergeant's Mail Wristguards
    },
    -- First Sergeant's Dragonhide Armguards
    ["216704"] = {
        18434, -- First Sergeant's Dragonhide Armguards
        18436, -- First Sergeant's Dragonhide Armguards
    },
    -- First Sergeant's Plate Bracers
    ["216705"] = {
        18429, -- First Sergeant's Plate Bracers
        18430, -- First Sergeant's Plate Bracers
    },
    -- First Sergeant's Leather Armguards
    ["216706"] = {
        16497, -- First Sergeant's Leather Armguards
        18435, -- First Sergeant's Leather Armguards
    },
    -- First Sergeant's Silk Cuffs
    ["216707"] = {
        16486, -- First Sergeant's Silk Cuffs
        18437, -- First Sergeant's Silk Cuffs
    },
    -- Repairman's Cape
    ["217005"] = {
        9605, -- Repairman's Cape
    },
    -- Mechanic's Pipehammer
    ["217006"] = {
        9604, -- Mechanic's Pipehammer
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
    -- Supply Bag
    ["217014"] = {
        22679, -- Supply Bag
    },
    -- Fishing Tournament!
    ["217017"] = {
        19978, -- Fishing Tournament!
    },
    -- Pattern: Crimson Silk Robe
    ["217244"] = {
        7088, -- Pattern: Crimson Silk Robe
    },
    -- Crimson Silk Robe
    ["217245"] = {
        7063, -- Crimson Silk Robe
    },
    -- Black Mageweave Vest
    ["217246"] = {
        9998, -- Black Mageweave Vest
    },
    -- Black Mageweave Leggings
    ["217247"] = {
        9999, -- Black Mageweave Leggings
    },
    -- Earthen Silk Belt
    ["217248"] = {
        7061, -- Earthen Silk Belt
    },
    -- Pattern: Earthen Silk Belt
    ["217249"] = {
        7086, -- Pattern: Earthen Silk Belt
    },
    -- Crimson Silk Shoulders
    ["217250"] = {
        7059, -- Crimson Silk Shoulders
    },
    -- Pattern: Crimson Silk Shoulders
    ["217251"] = {
        7084, -- Pattern: Crimson Silk Shoulders
    },
    -- Long Silken Cloak
    ["217252"] = {
        4326, -- Long Silken Cloak
    },
    -- Boots of the Enchanter
    ["217253"] = {
        4325, -- Boots of the Enchanter
    },
    -- Pattern: Boots of the Enchanter
    ["217254"] = {
        4352, -- Pattern: Boots of the Enchanter
    },
    -- Crimson Silk Belt
    ["217255"] = {
        7055, -- Crimson Silk Belt
    },
    -- Earthen Vest
    ["217256"] = {
        7051, -- Earthen Vest
    },
    -- Enchanter's Cowl
    ["217257"] = {
        4322, -- Enchanter's Cowl
    },
    -- Pattern: Enchanter's Cowl
    ["217258"] = {
        14630, -- Pattern: Enchanter's Cowl
    },
    -- Big Voodoo Mask
    ["217259"] = {
        8201, -- Big Voodoo Mask
    },
    -- Pattern: Big Voodoo Mask
    ["217260"] = {
        8387, -- Pattern: Big Voodoo Mask
    },
    -- Big Voodoo Robe
    ["217261"] = {
        8200, -- Big Voodoo Robe
    },
    -- Pattern: Big Voodoo Robe
    ["217262"] = {
        8386, -- Pattern: Big Voodoo Robe
    },
    -- Guardian Leather Bracers
    ["217263"] = {
        4260, -- Guardian Leather Bracers
    },
    -- Pattern: Guardian Leather Bracers
    ["217264"] = {
        4300, -- Pattern: Guardian Leather Bracers
    },
    -- Guardian Belt
    ["217265"] = {
        4258, -- Guardian Belt
    },
    -- Pattern: Guardian Belt
    ["217266"] = {
        4298, -- Pattern: Guardian Belt
    },
    -- Guardian Pants
    ["217267"] = {
        5962, -- Guardian Pants
    },
    -- Turtle Scale Breastplate
    ["217268"] = {
        8189, -- Turtle Scale Breastplate
    },
    -- Turtle Scale Gloves
    ["217270"] = {
        8187, -- Turtle Scale Gloves
    },
    -- Pattern: Turtle Scale Gloves
    ["217271"] = {
        8385, -- Pattern: Turtle Scale Gloves
    },
    -- Golden Scale Gauntlets
    ["217273"] = {
        9366, -- Golden Scale Gauntlets
    },
    -- Plans: Golden Scale Gauntlets
    ["217274"] = {
        9367, -- Plans: Golden Scale Gauntlets
    },
    -- Golden Scale Boots
    ["217275"] = {
        3847, -- Golden Scale Boots
    },
    -- Plans: Golden Scale Boots
    ["217276"] = {
        3875, -- Plans: Golden Scale Boots
    },
    -- Golden Scale Cuirass
    ["217277"] = {
        3845, -- Golden Scale Cuirass
    },
    -- Plans: Golden Scale Cuirass
    ["217278"] = {
        3873, -- Plans: Golden Scale Cuirass
    },
    -- Golden Scale Coif
    ["217279"] = {
        3837, -- Golden Scale Coif
    },
    -- Plans: Golden Scale Coif
    ["217280"] = {
        6047, -- Plans: Golden Scale Coif
    },
    -- Moonsteel Broadsword
    ["217281"] = {
        3853, -- Moonsteel Broadsword
    },
    -- Plans: Moonsteel Broadsword
    ["217282"] = {
        12163, -- Plans: Moonsteel Broadsword
    },
    -- Golden Scale Shoulders
    ["217283"] = {
        3841, -- Golden Scale Shoulders
    },
    -- Plans: Golden Scale Shoulders
    ["217284"] = {
        3871, -- Plans: Golden Scale Shoulders
    },
    -- Golden Scale Leggings
    ["217285"] = {
        3843, -- Golden Scale Leggings
    },
    -- Plans: Golden Scale Leggings
    ["217286"] = {
        3872, -- Plans: Golden Scale Leggings
    },
    -- Greater Mystic Wand
    ["217287"] = {
        11290, -- Greater Mystic Wand
    },
    -- Robes of the Lich
    ["217288"] = {
        10762, -- Robes of the Lich
    },
    -- Deathchill Armor
    ["217289"] = {
        10764, -- Deathchill Armor
    },
    -- Glowing Eye of Mordresh
    ["217290"] = {
        10769, -- Glowing Eye of Mordresh
    },
    -- Mordresh's Lifeless Skull
    ["217291"] = {
        10770, -- Mordresh's Lifeless Skull
    },
    -- Deathmage Sash
    ["217292"] = {
        10771, -- Deathmage Sash
    },
    -- Silky Spider Cape
    ["217293"] = {
        10776, -- Silky Spider Cape
    },
    -- Embalmed Shroud
    ["217294"] = {
        7691, -- Embalmed Shroud
    },
    -- Necrotic Wand
    ["217295"] = {
        7708, -- Necrotic Wand
    },
    -- Ghostshard Talisman
    ["217296"] = {
        7731, -- Ghostshard Talisman
    },
    -- Robe of Doan
    ["217297"] = {
        7711, -- Robe of Doan
    },
    -- Mantle of Doan
    ["217298"] = {
        7712, -- Mantle of Doan
    },
    -- Illusionary Rod
    ["217299"] = {
        7713, -- Illusionary Rod
    },
    -- Whitemane's Chapeau
    ["217300"] = {
        7720, -- Whitemane's Chapeau
    },
    -- Triune Amulet
    ["217301"] = {
        7722, -- Triune Amulet
    },
    -- Mograine's Might
    ["217302"] = {
        7723, -- Mograine's Might
    },
    -- Stoneweaver Leggings
    ["217303"] = {
        9407, -- Stoneweaver Leggings
    },
    -- Revelosh's Gloves
    ["217304"] = {
        9390, -- Revelosh's Gloves
    },
    -- Revelosh's Armguards
    ["217305"] = {
        9388, -- Revelosh's Armguards
    },
    -- Revelosh's Boots
    ["217306"] = {
        9387, -- Revelosh's Boots
    },
    -- Revelosh's Spaulders
    ["217307"] = {
        9389, -- Revelosh's Spaulders
    },
    -- Moonsight Rifle
    ["217314"] = {
        4383, -- Moonsight Rifle
    },
    -- Precision Bow
    ["217315"] = {
        8183, -- Precision Bow
    },
    -- Thermaplugg's Engineering Notes
    ["217351"] = {
        213343, -- Justice Badge
        213344, -- Gnomeregan Peace Officer's Torque
        213345, -- Piston Pendant
        213346, -- Pendant of Homecoming
    },
    -- Invisibility Potion
    ["217693"] = {
        9172, -- Invisibility Potion
    },
    -- Ironshod Bludgeon
    ["217704"] = {
        9408, -- Ironshod Bludgeon
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
    -- Schematic: Goblin Rocket Boots
    ["221339"] = {
        7192, -- Schematic: Goblin Rocket Boots
    },
    -- Scapula of the Fallen Avatar
    ["221363"] = {
        220626, -- Drakeclaw Band of the Berserker
        220627, -- Drakeclaw Band of the Stalker
        220628, -- Drakeclaw Band of the Harbinger
        220629, -- Drakeclaw Band of the Blood Prophet
        220630, -- Drakeclaw Band of the Juggernaut
    },
    -- Chained Essence of Eranikus
    ["221474"] = {
        10455, -- Chained Essence of Eranikus
    },
    -- Essence of Eranikus
    ["221475"] = {
        10454, -- Essence of Eranikus
    },
    -- Sturdy Lunchbox
    ["221498"] = {
        1652, -- Sturdy Lunchbox
    },
    -- Princess Theradras' Scepter
    ["221780"] = {
        17766, -- Princess Theradras' Scepter
    },
    -- Avenguard Helm
    ["221781"] = {
        10749, -- Avenguard Helm
    },
    -- Helm of Exile
    ["221782"] = {
        11124, -- Helm of Exile
    },
    -- Lawbringer Shoulderplates
    ["221783"] = {
        227752, -- Molten Scaled Shoulderpads
    },
    -- Cenarion Vestments
    ["221785"] = {
        16833, -- Cenarion Vestments
    },
    -- Geomancer's Cord
    ["223173"] = {
        14217, -- Geomancer's Cord
    },
    -- Geomancer's Boots
    ["223174"] = {
        14218, -- Geomancer's Boots
    },
    -- Geomancer's Cloak
    ["223175"] = {
        14219, -- Geomancer's Cloak
    },
    -- Geomancer's Cap
    ["223177"] = {
        14220, -- Geomancer's Cap
    },
    -- Geomancer's Bracers
    ["223178"] = {
        14221, -- Geomancer's Bracers
    },
    -- Geomancer's Gloves
    ["223180"] = {
        14222, -- Geomancer's Gloves
    },
    -- Geomancer's Spaulders
    ["223181"] = {
        14223, -- Geomancer's Spaulders
    },
    -- Geomancer's Trousers
    ["223182"] = {
        14224, -- Geomancer's Trousers
    },
    -- Geomancer's Wraps
    ["223183"] = {
        14225, -- Geomancer's Wraps
    },
    -- Rainstrider Leggings
    ["223324"] = {
        11123, -- Rainstrider Leggings
    },
    -- Hakkari Breastplate
    ["223325"] = {
        10781, -- Hakkari Breastplate
    },
    -- Hakkari Shroud
    ["223326"] = {
        10782, -- Hakkari Shroud
    },
    -- Mark of Hakkar
    ["223327"] = {
        10780, -- Mark of Hakkar
    },
    -- Gemburst Circlet
    ["223328"] = {
        10751, -- Gemburst Circlet
    },
    -- Lifeforce Dirk
    ["223329"] = {
        10750, -- Lifeforce Dirk
    },
    -- Charstone Dirk
    ["223518"] = {
        17710, -- Charstone Dirk
    },
    -- Eye of Theradras
    ["223519"] = {
        17715, -- Eye of Theradras
    },
    -- Inventor's Focal Sword
    ["223520"] = {
        17719, -- Inventor's Focal Sword
    },
    -- Rotgrip Mantle
    ["223521"] = {
        17732, -- Rotgrip Mantle
    },
    -- Helm of the Mountain
    ["223522"] = {
        17734, -- Helm of the Mountain
    },
    -- Cloud Stone
    ["223523"] = {
        17737, -- Cloud Stone
    },
    -- Fist of Stone
    ["223524"] = {
        17733, -- Fist of Stone
        17943, -- Fist of Stone
    },
    -- Soothsayer's Headdress
    ["223525"] = {
        17740, -- Soothsayer's Headdress
    },
    -- Sul'thraze the Lasher
    ["223526"] = {
        9372, -- Sul'thraze the Lasher
    },
    -- Gahz'rilla Fang
    ["223527"] = {
        9467, -- Gahz'rilla Fang
    },
    -- Gahz'rilla Scale Armor
    ["223528"] = {
        9469, -- Gahz'rilla Scale Armor
    },
    -- Jinxed Hoodoo Skin
    ["223529"] = {
        9473, -- Jinxed Hoodoo Skin
    },
    -- Jinxed Hoodoo Kilt
    ["223530"] = {
        9474, -- Jinxed Hoodoo Kilt
    },
    -- Big Bad Pauldrons
    ["223531"] = {
        9476, -- Big Bad Pauldrons
    },
    -- Lifeblood Amulet
    ["223532"] = {
        9641, -- Lifeblood Amulet
    },
    -- Desertwalker Cane
    ["223533"] = {
        12471, -- Desertwalker Cane
    },
    -- Jumanza Grips
    ["223534"] = {
        18083, -- Jumanza Grips
    },
    -- Grimlok's Tribal Vestments
    ["223535"] = {
        9415, -- Grimlok's Tribal Vestments
    },
    -- Grimlok's Charge
    ["223536"] = {
        9416, -- Grimlok's Charge
    },
    -- Skullplate Bracers
    ["223537"] = {
        9432, -- Skullplate Bracers
    },
    -- Kindling Stave
    ["223538"] = {
        11750, -- Kindling Stave
    },
    -- Enthralled Sphere
    ["223539"] = {
        11625, -- Enthralled Sphere
    },
    -- Houndmaster's Bow
    ["223540"] = {
        11628, -- Houndmaster's Bow
    },
    -- Gemshard Heart
    ["223541"] = {
        17707, -- Gemshard Heart
    },
    -- Megashot Rifle
    ["223542"] = {
        17717, -- Megashot Rifle
    },
    -- Vinerot Sandals
    ["223543"] = {
        17748, -- Vinerot Sandals
    },
    -- Dregmetal Spaulders
    ["223544"] = {
        11722, -- Dregmetal Spaulders
    },
    -- Gizlock's Hypertech Buckler
    ["223545"] = {
        17718, -- Gizlock's Hypertech Buckler
    },
    -- Purification Potion
    ["223912"] = {
        13462, -- Purification Potion
    },
    -- Major Healing Potion
    ["223913"] = {
        13446, -- Major Healing Potion
    },
    -- Greater Healing Potion
    ["223914"] = {
        1710, -- Greater Healing Potion
    },
    -- Sandstalker Ankleguards
    ["223962"] = {
        12470, -- Sandstalker Ankleguards
    },
    -- Embrace of the Lycan
    ["223963"] = {
        9479, -- Embrace of the Lycan
    },
    -- Blade of Eternal Darkness
    ["223964"] = {
        17780, -- Blade of Eternal Darkness
    },
    -- Searingscale Leggings
    ["223980"] = {
        11749, -- Searingscale Leggings
    },
    -- Flamestrider Robes
    ["223981"] = {
        11747, -- Flamestrider Robes
    },
    -- Houndmaster's Rifle
    ["223982"] = {
        11629, -- Houndmaster's Rifle
    },
    -- Arbiter's Blade
    ["223983"] = {
        11784, -- Arbiter's Blade
    },
    -- Silkweb Gloves
    ["223984"] = {
        11634, -- Silkweb Gloves
    },
    -- Cyclopean Band
    ["223985"] = {
        11824, -- Cyclopean Band
    },
    -- Graverot Cape
    ["223986"] = {
        11677, -- Graverot Cape
    },
    -- Splinthide Shoulders
    ["223987"] = {
        11685, -- Splinthide Shoulders
    },
    -- Dream Eater
    ["224122"] = {
        229352, -- Intelligence Findings
    },
    -- Suzerain, Defender of the Dragonflights
    ["224280"] = {
        231378, -- Shimmering Golden Disk
    },
    -- Gla'sir
    ["224281"] = {
        231814, -- Chromatic Heart
    },
    -- Rae'lar
    ["224282"] = {
        231814, -- Chromatic Heart
    },
    -- Nightslayer Belt
    ["226440"] = {
        16827, -- Nightslayer Belt
    },
    -- Nightslayer Gloves
    ["226441"] = {
        16826, -- Nightslayer Gloves
    },
    -- Nightslayer Bracelets
    ["226442"] = {
        16825, -- Nightslayer Bracelets
    },
    -- Nightslayer Boots
    ["226443"] = {
        16824, -- Nightslayer Boots
    },
    -- Nightslayer Shoulder Pads
    ["226444"] = {
        16823, -- Nightslayer Shoulder Pads
    },
    -- Nightslayer Pants
    ["226445"] = {
        16822, -- Nightslayer Pants
    },
    -- Nightslayer Cover
    ["226446"] = {
        16821, -- Nightslayer Cover
    },
    -- Nightslayer Chestpiece
    ["226447"] = {
        16820, -- Nightslayer Chestpiece
    },
    -- Nightslayer Cuirass
    ["226473"] = {
        227766, -- Scorched Core Chest
    },
    -- Nightslayer Waistguard
    ["226474"] = {
        227761, -- Scorched Core Belt
    },
    -- Nightslayer Handguards
    ["226475"] = {
        227759, -- Scorched Core Gloves
    },
    -- Nightslayer Bracers
    ["226476"] = {
        227760, -- Scorched Core Bindings
    },
    -- Nightslayer Tabi
    ["226477"] = {
        227765, -- Scorched Core Boots
    },
    -- Nightslayer Pauldrons
    ["226478"] = {
        227762, -- Scorched Core Shoulderpads
    },
    -- Nightslayer Legguards
    ["226479"] = {
        227763, -- Scorched Core Leggings
    },
    -- Nightslayer Hood
    ["226480"] = {
        227764, -- Scorched Core Helm
    },
    -- Bracers of Might
    ["226484"] = {
        16861, -- Bracers of Might
    },
    -- Belt of Might
    ["226485"] = {
        16864, -- Belt of Might
    },
    -- Gauntlets of Might
    ["226486"] = {
        16863, -- Gauntlets of Might
    },
    -- Sabatons of Might
    ["226487"] = {
        16862, -- Sabatons of Might
    },
    -- Helm of Might
    ["226488"] = {
        16866, -- Helm of Might
    },
    -- Breastplate of Might
    ["226489"] = {
        16865, -- Breastplate of Might
    },
    -- Legplates of Might
    ["226490"] = {
        16867, -- Legplates of Might
    },
    -- Shoulderplates of Might
    ["226491"] = {
        227762, -- Scorched Core Shoulderpads
    },
    -- Pauldrons of Might
    ["226492"] = {
        16868, -- Pauldrons of Might
    },
    -- Leggings of Might
    ["226493"] = {
        227763, -- Scorched Core Leggings
    },
    -- Hauberk of Might
    ["226494"] = {
        227766, -- Scorched Core Chest
    },
    -- Jaws of Might
    ["226495"] = {
        227764, -- Scorched Core Helm
    },
    -- Treads of Might
    ["226496"] = {
        227765, -- Scorched Core Boots
    },
    -- Hands of Might
    ["226497"] = {
        227759, -- Scorched Core Gloves
    },
    -- Sash of Might
    ["226498"] = {
        227761, -- Scorched Core Belt
    },
    -- Armguards of Might
    ["226499"] = {
        227760, -- Scorched Core Bindings
    },
    -- Giantstalker's Epaulets
    ["226527"] = {
        16848, -- Giantstalker's Epaulets
    },
    -- Giantstalker's Gloves
    ["226528"] = {
        16852, -- Giantstalker's Gloves
    },
    -- Giantstalker's Belt
    ["226529"] = {
        16851, -- Giantstalker's Belt
    },
    -- Giantstalker's Bracers
    ["226530"] = {
        16850, -- Giantstalker's Bracers
    },
    -- Giantstalker's Boots
    ["226531"] = {
        16849, -- Giantstalker's Boots
    },
    -- Giantstalker's Leggings
    ["226532"] = {
        16847, -- Giantstalker's Leggings
    },
    -- Giantstalker's Helmet
    ["226533"] = {
        16846, -- Giantstalker's Helmet
    },
    -- Giantstalker's Breastplate
    ["226534"] = {
        16845, -- Giantstalker's Breastplate
    },
    -- Giantstalker's Chainmail
    ["226535"] = {
        227758, -- Molten Scaled Chest
    },
    -- Giantstalker's Guise
    ["226536"] = {
        227755, -- Molten Scaled Helm
    },
    -- Giantstalker's Chain Leggings
    ["226537"] = {
        227754, -- Molten Scaled Leggings
    },
    -- Giantstalker's Sabatons
    ["226538"] = {
        227757, -- Molten Scaled Boots
    },
    -- Giantstalker's Handguards
    ["226540"] = {
        227756, -- Molten Scaled Gloves
    },
    -- Giantstalker's Wristguards
    ["226541"] = {
        227750, -- Molten Scaled Bindings
    },
    -- Giantstalker's Girdle
    ["226542"] = {
        227751, -- Molten Scaled Belt
    },
    -- Giantstalker's Spauldrons
    ["226543"] = {
        227752, -- Molten Scaled Shoulderpads
    },
    -- Felheart Pants
    ["226547"] = {
        16810, -- Felheart Pants
    },
    -- Felheart Robes
    ["226548"] = {
        16809, -- Felheart Robes
    },
    -- Felheart Horns
    ["226549"] = {
        16808, -- Felheart Horns
    },
    -- Felheart Shoulder Pads
    ["226550"] = {
        16807, -- Felheart Shoulder Pads
    },
    -- Felheart Belt
    ["226551"] = {
        16806, -- Felheart Belt
    },
    -- Felheart Gloves
    ["226552"] = {
        16805, -- Felheart Gloves
    },
    -- Felheart Bracers
    ["226553"] = {
        16804, -- Felheart Bracers
    },
    -- Felheart Slippers
    ["226554"] = {
        16803, -- Felheart Slippers
    },
    -- Arcanist Belt
    ["226555"] = {
        16802, -- Arcanist Belt
    },
    -- Arcanist Gloves
    ["226556"] = {
        16801, -- Arcanist Gloves
    },
    -- Arcanist Boots
    ["226557"] = {
        16800, -- Arcanist Boots
    },
    -- Arcanist Bindings
    ["226558"] = {
        16799, -- Arcanist Bindings
    },
    -- Arcanist Robes
    ["226559"] = {
        16798, -- Arcanist Robes
    },
    -- Arcanist Mantle
    ["226560"] = {
        16797, -- Arcanist Mantle
    },
    -- Arcanist Leggings
    ["226561"] = {
        16796, -- Arcanist Leggings
    },
    -- Arcanist Crown
    ["226562"] = {
        16795, -- Arcanist Crown
    },
    -- Arcanist Garments
    ["226563"] = {
        227535, -- Incandescent Robe
    },
    -- Arcanist Headdress
    ["226564"] = {
        227532, -- Incandescent Hood
    },
    -- Arcanist Pants
    ["226565"] = {
        227534, -- Incandescent Leggings
    },
    -- Arcanist Shoulders
    ["226566"] = {
        227537, -- Incandescent Shoulderpads
    },
    -- Arcanist Wristwraps
    ["226567"] = {
        227531, -- Incandescent Bindings
    },
    -- Arcanist Sandals
    ["226568"] = {
        227536, -- Incandescent Boots
    },
    -- Arcanist Handguards
    ["226569"] = {
        227533, -- Incandescent Gloves
    },
    -- Arcanist Cord
    ["226570"] = {
        227530, -- Incandescent Belt
    },
    -- Boots of Prophecy
    ["226571"] = {
        16811, -- Boots of Prophecy
    },
    -- Gloves of Prophecy
    ["226572"] = {
        16812, -- Gloves of Prophecy
    },
    -- Circlet of Prophecy
    ["226573"] = {
        16813, -- Circlet of Prophecy
    },
    -- Pants of Prophecy
    ["226574"] = {
        16814, -- Pants of Prophecy
    },
    -- Robes of Prophecy
    ["226575"] = {
        16815, -- Robes of Prophecy
    },
    -- Mantle of Prophecy
    ["226576"] = {
        16816, -- Mantle of Prophecy
    },
    -- Girdle of Prophecy
    ["226577"] = {
        16817, -- Girdle of Prophecy
    },
    -- Vambraces of Prophecy
    ["226578"] = {
        16819, -- Vambraces of Prophecy
    },
    -- Wristwraps of Prophecy
    ["226579"] = {
        227531, -- Incandescent Bindings
    },
    -- Belt of Prophecy
    ["226580"] = {
        227530, -- Incandescent Belt
    },
    -- Shoulderpads of Prophecy
    ["226581"] = {
        227537, -- Incandescent Shoulderpads
    },
    -- Garments of Prophecy
    ["226582"] = {
        227535, -- Incandescent Robe
    },
    -- Leggings of Prophecy
    ["226583"] = {
        227534, -- Incandescent Leggings
    },
    -- Crown of Prophecy
    ["226584"] = {
        227532, -- Incandescent Hood
    },
    -- Hands of Prophecy
    ["226585"] = {
        227533, -- Incandescent Gloves
    },
    -- Sandals of Prophecy
    ["226586"] = {
        227536, -- Incandescent Boots
    },
    -- Lawbringer Spaulders
    ["226588"] = {
        16856, -- Lawbringer Spaulders
    },
    -- Lawbringer Bracers
    ["226589"] = {
        16857, -- Lawbringer Bracers
    },
    -- Lawbringer Helm
    ["226590"] = {
        16854, -- Lawbringer Helm
    },
    -- Lawbringer Gauntlets
    ["226591"] = {
        16860, -- Lawbringer Gauntlets
    },
    -- Lawbringer Belt
    ["226592"] = {
        16858, -- Lawbringer Belt
    },
    -- Lawbringer Boots
    ["226593"] = {
        16859, -- Lawbringer Boots
    },
    -- Lawbringer Legplates
    ["226594"] = {
        16855, -- Lawbringer Legplates
    },
    -- Lawbringer Chestguard
    ["226595"] = {
        16853, -- Lawbringer Chestguard
    },
    -- Lawbringer Warbands
    ["226596"] = {
        227750, -- Molten Scaled Bindings
    },
    -- Lawbringer Girdle
    ["226597"] = {
        227751, -- Molten Scaled Belt
    },
    -- Lawbringer Leggings
    ["226598"] = {
        227754, -- Molten Scaled Leggings
    },
    -- Lawbringer Crown
    ["226599"] = {
        227755, -- Molten Scaled Helm
    },
    -- Lawbringer Grips
    ["226600"] = {
        227756, -- Molten Scaled Gloves
    },
    -- Lawbringer Battleboots
    ["226601"] = {
        227757, -- Molten Scaled Boots
    },
    -- Lawbringer Breastplate
    ["226602"] = {
        227758, -- Molten Scaled Chest
    },
    -- Lawbringer Vambraces
    ["226603"] = {
        227750, -- Molten Scaled Bindings
    },
    -- Lawbringer Battlebelt
    ["226604"] = {
        227751, -- Molten Scaled Belt
    },
    -- Lawbringer Pauldrons
    ["226605"] = {
        227752, -- Molten Scaled Shoulderpads
    },
    -- Lawbringer Legguards
    ["226606"] = {
        227754, -- Molten Scaled Leggings
    },
    -- Lawbringer Headguard
    ["226607"] = {
        227755, -- Molten Scaled Helm
    },
    -- Lawbringer Handguards
    ["226608"] = {
        227756, -- Molten Scaled Gloves
    },
    -- Lawbringer Sabatons
    ["226609"] = {
        227757, -- Molten Scaled Boots
    },
    -- Lawbringer Chestplate
    ["226610"] = {
        227758, -- Molten Scaled Chest
    },
    -- Earthfury Epaulets
    ["226611"] = {
        16844, -- Earthfury Epaulets
    },
    -- Earthfury Helmet
    ["226612"] = {
        16842, -- Earthfury Helmet
    },
    -- Earthfury Boots
    ["226613"] = {
        16837, -- Earthfury Boots
    },
    -- Earthfury Legguards
    ["226614"] = {
        16843, -- Earthfury Legguards
    },
    -- Earthfury Gauntlets
    ["226615"] = {
        16839, -- Earthfury Gauntlets
    },
    -- Earthfury Belt
    ["226616"] = {
        16838, -- Earthfury Belt
    },
    -- Earthfury Vestments
    ["226617"] = {
        16841, -- Earthfury Vestments
    },
    -- Earthfury Bracers
    ["226618"] = {
        16840, -- Earthfury Bracers
    },
    -- Earthfury Ringmail
    ["226619"] = {
        227758, -- Molten Scaled Chest
    },
    -- Earthfury Walkers
    ["226620"] = {
        227757, -- Molten Scaled Boots
    },
    -- Earthfury Hands
    ["226621"] = {
        227756, -- Molten Scaled Gloves
    },
    -- Earthfury Visor
    ["226622"] = {
        227755, -- Molten Scaled Helm
    },
    -- Earthfury Leggings
    ["226623"] = {
        227754, -- Molten Scaled Leggings
    },
    -- Earthfury Mantle
    ["226624"] = {
        227752, -- Molten Scaled Shoulderpads
    },
    -- Earthfury Cord
    ["226625"] = {
        227751, -- Molten Scaled Belt
    },
    -- Earthfury Wristbands
    ["226626"] = {
        227750, -- Molten Scaled Bindings
    },
    -- Earthfury Scalemail
    ["226627"] = {
        227758, -- Molten Scaled Chest
    },
    -- Earthfury Sabatons
    ["226628"] = {
        227757, -- Molten Scaled Boots
    },
    -- Earthfury Handguards
    ["226629"] = {
        227756, -- Molten Scaled Gloves
    },
    -- Earthfury Greathelm
    ["226630"] = {
        227755, -- Molten Scaled Helm
    },
    -- Earthfury Scaled Leggings
    ["226631"] = {
        227754, -- Molten Scaled Leggings
    },
    -- Earthfury Pauldrons
    ["226632"] = {
        227752, -- Molten Scaled Shoulderpads
    },
    -- Earthfury Waistguard
    ["226633"] = {
        227751, -- Molten Scaled Belt
    },
    -- Earthfury Wristguards
    ["226634"] = {
        227750, -- Molten Scaled Bindings
    },
    -- Earthfury Chainmail
    ["226635"] = {
        227758, -- Molten Scaled Chest
    },
    -- Earthfury Battleboots
    ["226636"] = {
        227757, -- Molten Scaled Boots
    },
    -- Earthfury Grips
    ["226637"] = {
        227756, -- Molten Scaled Gloves
    },
    -- Earthfury Headpiece
    ["226638"] = {
        227755, -- Molten Scaled Helm
    },
    -- Earthfury Chain Leggings
    ["226639"] = {
        227754, -- Molten Scaled Leggings
    },
    -- Earthfury Spaulders
    ["226640"] = {
        227752, -- Molten Scaled Shoulderpads
    },
    -- Earthfury Girdle
    ["226641"] = {
        227751, -- Molten Scaled Belt
    },
    -- Earthfury Bindings
    ["226642"] = {
        227750, -- Molten Scaled Bindings
    },
    -- Cenarion Spaulders
    ["226644"] = {
        16836, -- Cenarion Spaulders
    },
    -- Cenarion Boots
    ["226645"] = {
        16829, -- Cenarion Boots
    },
    -- Cenarion Leggings
    ["226646"] = {
        16835, -- Cenarion Leggings
    },
    -- Cenarion Helm
    ["226647"] = {
        16834, -- Cenarion Helm
    },
    -- Cenarion Gloves
    ["226648"] = {
        16831, -- Cenarion Gloves
    },
    -- Cenarion Bracers
    ["226649"] = {
        16830, -- Cenarion Bracers
    },
    -- Cenarion Belt
    ["226650"] = {
        16828, -- Cenarion Belt
    },
    -- Cenarion Pants
    ["226651"] = {
        227763, -- Scorched Core Leggings
    },
    -- Cenarion Sandals
    ["226652"] = {
        227765, -- Scorched Core Boots
    },
    -- Cenarion Mantle
    ["226653"] = {
        227762, -- Scorched Core Shoulderpads
    },
    -- Cenarion Gauntlets
    ["226654"] = {
        227759, -- Scorched Core Gloves
    },
    -- Cenarion Wrists
    ["226655"] = {
        227760, -- Scorched Core Bindings
    },
    -- Cenarion Embrace
    ["226656"] = {
        227766, -- Scorched Core Chest
    },
    -- Cenarion Cord
    ["226657"] = {
        227761, -- Scorched Core Belt
    },
    -- Cenarion Antlers
    ["226658"] = {
        227764, -- Scorched Core Helm
    },
    -- Cenarion Horns
    ["226659"] = {
        227764, -- Scorched Core Helm
    },
    -- Cenarion Girdle
    ["226660"] = {
        227761, -- Scorched Core Belt
    },
    -- Cenarion Tunic
    ["226661"] = {
        227766, -- Scorched Core Chest
    },
    -- Cenarion Bands
    ["226662"] = {
        227760, -- Scorched Core Bindings
    },
    -- Cenarion Treads
    ["226663"] = {
        227765, -- Scorched Core Boots
    },
    -- Cenarion Fists
    ["226664"] = {
        227759, -- Scorched Core Gloves
    },
    -- Cenarion Shoulders
    ["226665"] = {
        227762, -- Scorched Core Shoulderpads
    },
    -- Cenarion Trousers
    ["226666"] = {
        227763, -- Scorched Core Leggings
    },
    -- Cenarion Waistguard
    ["226667"] = {
        227761, -- Scorched Core Belt
    },
    -- Cenarion Wristguards
    ["226668"] = {
        227760, -- Scorched Core Bindings
    },
    -- Cenarion Grips
    ["226669"] = {
        227759, -- Scorched Core Gloves
    },
    -- Cenarion Crown
    ["226670"] = {
        227764, -- Scorched Core Helm
    },
    -- Cenarion Legguards
    ["226671"] = {
        227763, -- Scorched Core Leggings
    },
    -- Cenarion Walkers
    ["226673"] = {
        227765, -- Scorched Core Boots
    },
    -- Cenarion Pauldrons
    ["226674"] = {
        227762, -- Scorched Core Shoulderpads
    },
    -- Cenarion Armor
    ["226675"] = {
        227766, -- Scorched Core Chest
    },
    -- Shadowcraft Tunic
    ["226700"] = {
        16721, -- Shadowcraft Tunic
    },
    -- Shadowcraft Belt
    ["226701"] = {
        16713, -- Shadowcraft Belt
    },
    -- Shadowcraft Gloves
    ["226702"] = {
        16712, -- Shadowcraft Gloves
    },
    -- Shadowcraft Boots
    ["226703"] = {
        16711, -- Shadowcraft Boots
    },
    -- Shadowcraft Bracers
    ["226704"] = {
        16710, -- Shadowcraft Bracers
    },
    -- Shadowcraft Pants
    ["226705"] = {
        16709, -- Shadowcraft Pants
    },
    -- Shadowcraft Spaulders
    ["226706"] = {
        16708, -- Shadowcraft Spaulders
    },
    -- Shadowcraft Cap
    ["226707"] = {
        16707, -- Shadowcraft Cap
    },
    -- Wildheart Cowl
    ["226708"] = {
        16720, -- Wildheart Cowl
    },
    -- Wildheart Kilt
    ["226709"] = {
        16719, -- Wildheart Kilt
    },
    -- Wildheart Spaulders
    ["226710"] = {
        16718, -- Wildheart Spaulders
    },
    -- Wildheart Gloves
    ["226711"] = {
        16717, -- Wildheart Gloves
    },
    -- Wildheart Belt
    ["226712"] = {
        16716, -- Wildheart Belt
    },
    -- Wildheart Boots
    ["226713"] = {
        16715, -- Wildheart Boots
    },
    -- Wildheart Bracers
    ["226714"] = {
        16714, -- Wildheart Bracers
    },
    -- Wildheart Vest
    ["226715"] = {
        16706, -- Wildheart Vest
    },
    -- Beaststalker's Mantle
    ["226716"] = {
        16679, -- Beaststalker's Mantle
    },
    -- Beaststalker's Bindings
    ["226717"] = {
        16681, -- Beaststalker's Bindings
    },
    -- Beaststalker's Belt
    ["226718"] = {
        16680, -- Beaststalker's Belt
    },
    -- Beaststalker's Pants
    ["226719"] = {
        16678, -- Beaststalker's Pants
    },
    -- Beaststalker's Cap
    ["226720"] = {
        16677, -- Beaststalker's Cap
    },
    -- Beaststalker's Gloves
    ["226721"] = {
        16676, -- Beaststalker's Gloves
    },
    -- Beaststalker's Boots
    ["226722"] = {
        16675, -- Beaststalker's Boots
    },
    -- Beaststalker's Tunic
    ["226723"] = {
        16674, -- Beaststalker's Tunic
    },
    -- Magister's Belt
    ["226724"] = {
        16685, -- Magister's Belt
    },
    -- Magister's Bindings
    ["226725"] = {
        16683, -- Magister's Bindings
    },
    -- Magister's Mantle
    ["226726"] = {
        16689, -- Magister's Mantle
    },
    -- Magister's Leggings
    ["226727"] = {
        16687, -- Magister's Leggings
    },
    -- Magister's Crown
    ["226728"] = {
        16686, -- Magister's Crown
    },
    -- Magister's Robes
    ["226729"] = {
        16688, -- Magister's Robes
    },
    -- Magister's Boots
    ["226730"] = {
        16682, -- Magister's Boots
    },
    -- Magister's Gloves
    ["226731"] = {
        16684, -- Magister's Gloves
    },
    -- Lightforge Belt
    ["226732"] = {
        16723, -- Lightforge Belt
    },
    -- Lightforge Helm
    ["226733"] = {
        16727, -- Lightforge Helm
    },
    -- Lightforge Breastplate
    ["226734"] = {
        16726, -- Lightforge Breastplate
    },
    -- Lightforge Spaulders
    ["226735"] = {
        16729, -- Lightforge Spaulders
    },
    -- Lightforge Legplates
    ["226736"] = {
        16728, -- Lightforge Legplates
    },
    -- Lightforge Gauntlets
    ["226737"] = {
        16724, -- Lightforge Gauntlets
    },
    -- Lightforge Boots
    ["226738"] = {
        16725, -- Lightforge Boots
    },
    -- Lightforge Bracers
    ["226739"] = {
        16722, -- Lightforge Bracers
    },
    -- Devout Gloves
    ["226740"] = {
        16692, -- Devout Gloves
    },
    -- Devout Mantle
    ["226741"] = {
        16695, -- Devout Mantle
    },
    -- Devout Bracers
    ["226742"] = {
        16697, -- Devout Bracers
    },
    -- Devout Sandals
    ["226743"] = {
        16691, -- Devout Sandals
    },
    -- Devout Belt
    ["226744"] = {
        16696, -- Devout Belt
    },
    -- Devout Robe
    ["226745"] = {
        16690, -- Devout Robe
    },
    -- Devout Crown
    ["226746"] = {
        16693, -- Devout Crown
    },
    -- Devout Skirt
    ["226747"] = {
        16694, -- Devout Skirt
    },
    -- Gauntlets of Elements
    ["226748"] = {
        16672, -- Gauntlets of Elements
    },
    -- Vest of Elements
    ["226749"] = {
        16666, -- Vest of Elements
    },
    -- Kilt of Elements
    ["226750"] = {
        16668, -- Kilt of Elements
    },
    -- Bindings of Elements
    ["226751"] = {
        16671, -- Bindings of Elements
    },
    -- Boots of Elements
    ["226752"] = {
        16670, -- Boots of Elements
    },
    -- Pauldrons of Elements
    ["226753"] = {
        16669, -- Pauldrons of Elements
    },
    -- Cord of Elements
    ["226754"] = {
        16673, -- Cord of Elements
    },
    -- Coif of Elements
    ["226755"] = {
        16667, -- Coif of Elements
    },
    -- Dreadmist Mantle
    ["226756"] = {
        16701, -- Dreadmist Mantle
    },
    -- Dreadmist Robe
    ["226757"] = {
        16700, -- Dreadmist Robe
    },
    -- Dreadmist Wraps
    ["226758"] = {
        16705, -- Dreadmist Wraps
    },
    -- Dreadmist Bracers
    ["226759"] = {
        16703, -- Dreadmist Bracers
    },
    -- Dreadmist Leggings
    ["226760"] = {
        16699, -- Dreadmist Leggings
    },
    -- Dreadmist Belt
    ["226761"] = {
        16702, -- Dreadmist Belt
    },
    -- Dreadmist Mask
    ["226762"] = {
        16698, -- Dreadmist Mask
    },
    -- Dreadmist Sandals
    ["226763"] = {
        16704, -- Dreadmist Sandals
    },
    -- Boots of Valor
    ["226764"] = {
        16734, -- Boots of Valor
    },
    -- Belt of Valor
    ["226765"] = {
        16736, -- Belt of Valor
    },
    -- Bracers of Valor
    ["226766"] = {
        16735, -- Bracers of Valor
    },
    -- Legplates of Valor
    ["226767"] = {
        16732, -- Legplates of Valor
    },
    -- Spaulders of Valor
    ["226768"] = {
        16733, -- Spaulders of Valor
    },
    -- Helm of Valor
    ["226769"] = {
        16731, -- Helm of Valor
    },
    -- Breastplate of Valor
    ["226770"] = {
        16730, -- Breastplate of Valor
    },
    -- Gauntlets of Valor
    ["226771"] = {
        16737, -- Gauntlets of Valor
    },
    -- Feralheart Cowl
    ["226773"] = {
        22109, -- Feralheart Cowl
    },
    -- Feralheart Vest
    ["226776"] = {
        22113, -- Feralheart Vest
    },
    -- Feralheart Spaulders
    ["226778"] = {
        22112, -- Feralheart Spaulders
    },
    -- Feralheart Kilt
    ["226779"] = {
        22111, -- Feralheart Kilt
    },
    -- Feralheart Gloves
    ["226820"] = {
        22110, -- Feralheart Gloves
    },
    -- Feralheart Boots
    ["226821"] = {
        22107, -- Feralheart Boots
    },
    -- Darkmantle Tunic
    ["226825"] = {
        22009, -- Darkmantle Tunic
    },
    -- Darkmantle Spaulders
    ["226826"] = {
        22008, -- Darkmantle Spaulders
    },
    -- Darkmantle Pants
    ["226827"] = {
        22007, -- Darkmantle Pants
    },
    -- Darkmantle Cap
    ["226829"] = {
        22005, -- Darkmantle Cap
    },
    -- Darkmantle Bracers
    ["226830"] = {
        22004, -- Darkmantle Bracers
    },
    -- Darkmantle Belt
    ["226832"] = {
        22002, -- Darkmantle Belt
    },
    -- Darkmantle Gloves
    ["226850"] = {
        22006, -- Darkmantle Gloves
    },
    -- Darkmantle Boots
    ["226851"] = {
        22003, -- Darkmantle Boots
    },
    -- Spaulders of Heroism
    ["226858"] = {
        22001, -- Spaulders of Heroism
    },
    -- Legplates of Heroism
    ["226859"] = {
        22000, -- Legplates of Heroism
    },
    -- Gauntlets of Heroism
    ["226861"] = {
        21998, -- Gauntlets of Heroism
    },
    -- Breastplate of Heroism
    ["226862"] = {
        21997, -- Breastplate of Heroism
    },
    -- Bracers of Heroism
    ["226863"] = {
        21996, -- Bracers of Heroism
    },
    -- Belt of Heroism
    ["226864"] = {
        21994, -- Belt of Heroism
    },
    -- Helm of Heroism
    ["226877"] = {
        21999, -- Helm of Heroism
    },
    -- Boots of Heroism
    ["226879"] = {
        21995, -- Boots of Heroism
    },
    -- Beastmaster's Pants
    ["226882"] = {
        22017, -- Beastmaster's Pants
    },
    -- Beastmaster's Mantle
    ["226884"] = {
        22016, -- Beastmaster's Mantle
    },
    -- Beastmaster's Bindings
    ["226885"] = {
        22011, -- Beastmaster's Bindings
    },
    -- Beastmaster's Tunic
    ["226886"] = {
        22060, -- Beastmaster's Tunic
    },
    -- Beastmaster's Cap
    ["226887"] = {
        22013, -- Beastmaster's Cap
    },
    -- Beastmaster's Belt
    ["226888"] = {
        22010, -- Beastmaster's Belt
    },
    -- Beastmaster's Gloves
    ["226902"] = {
        22015, -- Beastmaster's Gloves
    },
    -- Beastmaster's Boots
    ["226903"] = {
        22061, -- Beastmaster's Boots
    },
    -- Deathmist Belt
    ["226905"] = {
        22070, -- Deathmist Belt
    },
    -- Deathmist Robe
    ["226906"] = {
        22075, -- Deathmist Robe
    },
    -- Deathmist Bracers
    ["226907"] = {
        22071, -- Deathmist Bracers
    },
    -- Deathmist Sandals
    ["226908"] = {
        22076, -- Deathmist Sandals
    },
    -- Deathmist Mask
    ["226909"] = {
        22074, -- Deathmist Mask
    },
    -- Deathmist Leggings
    ["226910"] = {
        22072, -- Deathmist Leggings
    },
    -- Deathmist Wraps
    ["226911"] = {
        22077, -- Deathmist Wraps
    },
    -- Deathmist Mantle
    ["226912"] = {
        22073, -- Deathmist Mantle
    },
    -- Sorcerer's Bindings
    ["226929"] = {
        22063, -- Sorcerer's Bindings
    },
    -- Sorcerer's Robes
    ["226932"] = {
        22069, -- Sorcerer's Robes
    },
    -- Sorcerer's Leggings
    ["226933"] = {
        22067, -- Sorcerer's Leggings
    },
    -- Sorcerer's Belt
    ["226934"] = {
        22062, -- Sorcerer's Belt
    },
    -- Sorcerer's Crown
    ["226935"] = {
        22065, -- Sorcerer's Crown
    },
    -- Sorcerer's Mantle
    ["226936"] = {
        22068, -- Sorcerer's Mantle
    },
    -- Sorcerer's Gloves
    ["226942"] = {
        22066, -- Sorcerer's Gloves
    },
    -- Sorcerer's Boots
    ["226943"] = {
        22064, -- Sorcerer's Boots
    },
    -- Virtuous Robe
    ["226945"] = {
        22083, -- Virtuous Robe
    },
    -- Virtuous Skirt
    ["226946"] = {
        22085, -- Virtuous Skirt
    },
    -- Virtuous Crown
    ["226947"] = {
        22080, -- Virtuous Crown
    },
    -- Virtuous Belt
    ["226948"] = {
        22078, -- Virtuous Belt
    },
    -- Virtuous Bracers
    ["226949"] = {
        22079, -- Virtuous Bracers
    },
    -- Virtuous Mantle
    ["226951"] = {
        22082, -- Virtuous Mantle
    },
    -- Virtuous Sandals
    ["226952"] = {
        22084, -- Virtuous Sandals
    },
    -- Virtuous Gloves
    ["226966"] = {
        22081, -- Virtuous Gloves
    },
    -- Soulforge Spaulders
    ["226969"] = {
        22093, -- Soulforge Spaulders
    },
    -- Soulforge Bracers
    ["226970"] = {
        22088, -- Soulforge Bracers
    },
    -- Soulforge Belt
    ["226971"] = {
        22086, -- Soulforge Belt
    },
    -- Soulforge Legplates
    ["226972"] = {
        22092, -- Soulforge Legplates
    },
    -- Soulforge Breastplate
    ["226973"] = {
        22089, -- Soulforge Breastplate
    },
    -- Soulforge Gauntlets
    ["226975"] = {
        22090, -- Soulforge Gauntlets
    },
    -- Soulforge Helm
    ["226997"] = {
        22091, -- Soulforge Helm
    },
    -- Soulforge Boots
    ["226999"] = {
        22087, -- Soulforge Boots
    },
    -- Bindings of The Five Thunders
    ["227001"] = {
        22095, -- Bindings of The Five Thunders
    },
    -- Coif of The Five Thunders
    ["227002"] = {
        22097, -- Coif of The Five Thunders
    },
    -- Pauldrons of The Five Thunders
    ["227003"] = {
        22101, -- Pauldrons of The Five Thunders
    },
    -- Vest of The Five Thunders
    ["227004"] = {
        22102, -- Vest of The Five Thunders
    },
    -- Kilt of The Five Thunders
    ["227005"] = {
        22100, -- Kilt of The Five Thunders
    },
    -- Gauntlets of The Five Thunders
    ["227006"] = {
        22099, -- Gauntlets of The Five Thunders
    },
    -- Cord of The Five Thunders
    ["227008"] = {
        22098, -- Cord of The Five Thunders
    },
    -- Boots of The Five Thunders
    ["227039"] = {
        22096, -- Boots of The Five Thunders
    },
    -- Champion's Plate Shoulders
    ["227042"] = {
        23243, -- Champion's Plate Shoulders
    },
    -- Champion's Plate Helm
    ["227043"] = {
        23244, -- Champion's Plate Helm
    },
    -- Lieutenant Commander's Plate Helm
    ["227044"] = {
        16429, -- Lieutenant Commander's Plate Helm
        23314, -- Lieutenant Commander's Plate Helm
    },
    -- Lieutenant Commander's Plate Shoulders
    ["227045"] = {
        23315, -- Lieutenant Commander's Plate Shoulders
    },
    -- Knight-Captain's Plate Hauberk
    ["227046"] = {
        23300, -- Knight-Captain's Plate Hauberk
    },
    -- Knight-Captain's Plate Leggings
    ["227047"] = {
        16431, -- Knight-Captain's Plate Leggings
        23301, -- Knight-Captain's Plate Leggings
    },
    -- Legionnaire's Plate Leggings
    ["227048"] = {
        22873, -- Legionnaire's Plate Leggings
    },
    -- Legionnaire's Plate Hauberk
    ["227049"] = {
        22872, -- Legionnaire's Plate Hauberk
    },
    -- Blood Guard's Plate Gauntlets
    ["227050"] = {
        22868, -- Blood Guard's Plate Gauntlets
    },
    -- Blood Guard's Plate Greaves
    ["227051"] = {
        22858, -- Blood Guard's Plate Greaves
    },
    -- Knight-Lieutenant's Plate Greaves
    ["227052"] = {
        23287, -- Knight-Lieutenant's Plate Greaves
    },
    -- Knight-Lieutenant's Plate Gauntlets
    ["227053"] = {
        16406, -- Knight-Lieutenant's Plate Gauntlets
        23286, -- Knight-Lieutenant's Plate Gauntlets
    },
    -- Lieutenant Commander's Leather Shoulders
    ["227054"] = {
        23313, -- Lieutenant Commander's Leather Shoulders
    },
    -- Lieutenant Commander's Leather Helm
    ["227055"] = {
        23312, -- Lieutenant Commander's Leather Helm
    },
    -- Champion's Leather Shoulders
    ["227056"] = {
        23258, -- Champion's Leather Shoulders
    },
    -- Champion's Leather Helm
    ["227057"] = {
        23257, -- Champion's Leather Helm
    },
    -- Knight-Captain's Leather Chestpiece
    ["227058"] = {
        23298, -- Knight-Captain's Leather Chestpiece
    },
    -- Legionnaire's Leather Legguards
    ["227059"] = {
        22880, -- Legionnaire's Leather Legguards
    },
    -- Legionnaire's Leather Chestpiece
    ["227060"] = {
        22879, -- Legionnaire's Leather Chestpiece
    },
    -- Knight-Captain's Leather Legguards
    ["227061"] = {
        16419, -- Knight-Captain's Leather Legguards
        23299, -- Knight-Captain's Leather Legguards
    },
    -- Blood Guard's Leather Walkers
    ["227062"] = {
        22856, -- Blood Guard's Leather Walkers
    },
    -- Blood Guard's Leather Grips
    ["227063"] = {
        22864, -- Blood Guard's Leather Grips
    },
    -- Knight-Lieutenant's Leather Walkers
    ["227064"] = {
        23285, -- Knight-Lieutenant's Leather Walkers
    },
    -- Knight-Lieutenant's Leather Grips
    ["227065"] = {
        23284, -- Knight-Lieutenant's Leather Grips
    },
    -- Lieutenant Commander's Chain Helm
    ["227066"] = {
        23306, -- Lieutenant Commander's Chain Helm
    },
    -- Champion's Chain Helm
    ["227067"] = {
        23251, -- Champion's Chain Helm
    },
    -- Lieutenant Commander's Chain Shoulders
    ["227068"] = {
        23307, -- Lieutenant Commander's Chain Shoulders
    },
    -- Champion's Chain Shoulders
    ["227069"] = {
        23252, -- Champion's Chain Shoulders
    },
    -- Knight-Captain's Chain Hauberk
    ["227070"] = {
        16425, -- Knight-Captain's Chain Hauberk
        23292, -- Knight-Captain's Chain Hauberk
    },
    -- Legionnaire's Chain Hauberk
    ["227071"] = {
        22874, -- Legionnaire's Chain Hauberk
    },
    -- Knight-Captain's Chain Legguards
    ["227072"] = {
        23293, -- Knight-Captain's Chain Legguards
    },
    -- Legionnaire's Chain Legguards
    ["227073"] = {
        22875, -- Legionnaire's Chain Legguards
    },
    -- Blood Guard's Chain Greaves
    ["227074"] = {
        22843, -- Blood Guard's Chain Greaves
    },
    -- Blood Guard's Chain Vices
    ["227075"] = {
        22862, -- Blood Guard's Chain Vices
    },
    -- Knight-Lieutenant's Chain Greaves
    ["227076"] = {
        23278, -- Knight-Lieutenant's Chain Greaves
    },
    -- Knight-Lieutenant's Chain Vices
    ["227077"] = {
        23279, -- Knight-Lieutenant's Chain Vices
    },
    -- Champion's Chain Pauldrons
    ["227078"] = {
        16528, -- Champion's Chain Pauldrons
    },
    -- Lieutenant Commander's Chain Pauldrons
    ["227084"] = {
        16427, -- Lieutenant Commander's Chain Pauldrons
    },
    -- Champion's Dreadweave Cowl
    ["227090"] = {
        23255, -- Champion's Dreadweave Cowl
    },
    -- Lieutenant Commander's Dreadweave Spaulders
    ["227091"] = {
        23311, -- Lieutenant Commander's Dreadweave Spaulders
    },
    -- Champion's Dreadweave Spaulders
    ["227092"] = {
        23256, -- Champion's Dreadweave Spaulders
    },
    -- Lieutenant Commander's Dreadweave Cowl
    ["227093"] = {
        23310, -- Lieutenant Commander's Dreadweave Cowl
    },
    -- Legionnaire's Dreadweave Tunic
    ["227094"] = {
        22884, -- Legionnaire's Dreadweave Tunic
    },
    -- Knight-Captain's Dreadweave Legguards
    ["227095"] = {
        23296, -- Knight-Captain's Dreadweave Legguards
    },
    -- Knight-Captain's Dreadweave Tunic
    ["227096"] = {
        23297, -- Knight-Captain's Dreadweave Tunic
    },
    -- Legionnaire's Dreadweave Legguards
    ["227097"] = {
        22881, -- Legionnaire's Dreadweave Legguards
    },
    -- Blood Guard's Dreadweave Walkers
    ["227098"] = {
        22855, -- Blood Guard's Dreadweave Walkers
    },
    -- Blood Guard's Dreadweave Handwraps
    ["227099"] = {
        22865, -- Blood Guard's Dreadweave Handwraps
    },
    -- Knight-Lieutenant's Dreadweave Handwraps
    ["227100"] = {
        23282, -- Knight-Lieutenant's Dreadweave Handwraps
    },
    -- Knight-Lieutenant's Dreadweave Walkers
    ["227101"] = {
        23283, -- Knight-Lieutenant's Dreadweave Walkers
    },
    -- Lieutenant Commander's Silk Mantle
    ["227102"] = {
        23319, -- Lieutenant Commander's Silk Mantle
    },
    -- Lieutenant Commander's Silk Cowl
    ["227103"] = {
        23318, -- Lieutenant Commander's Silk Cowl
    },
    -- Champion's Silk Mantle
    ["227104"] = {
        23264, -- Champion's Silk Mantle
    },
    -- Champion's Silk Cowl
    ["227105"] = {
        23263, -- Champion's Silk Cowl
    },
    -- Legionnaire's Silk Tunic
    ["227106"] = {
        22886, -- Legionnaire's Silk Tunic
    },
    -- Legionnaire's Silk Legguards
    ["227107"] = {
        22883, -- Legionnaire's Silk Legguards
    },
    -- Knight-Captain's Silk Tunic
    ["227108"] = {
        23305, -- Knight-Captain's Silk Tunic
    },
    -- Knight-Captain's Silk Legguards
    ["227109"] = {
        23304, -- Knight-Captain's Silk Legguards
    },
    -- Blood Guard's Silk Walkers
    ["227110"] = {
        22860, -- Blood Guard's Silk Walkers
    },
    -- Blood Guard's Silk Handwraps
    ["227111"] = {
        22870, -- Blood Guard's Silk Handwraps
    },
    -- Knight-Lieutenant's Silk Walkers
    ["227112"] = {
        23291, -- Knight-Lieutenant's Silk Walkers
    },
    -- Knight-Lieutenant's Silk Handwraps
    ["227113"] = {
        23290, -- Knight-Lieutenant's Silk Handwraps
    },
    -- Knight-Lieutenant's Silk Gloves
    ["227116"] = {
        16391, -- Knight-Lieutenant's Silk Gloves
    },
    -- Blood Guard's Silk Gloves
    ["227117"] = {
        16487, -- Blood Guard's Silk Gloves
    },
    -- Champion's Satin Hood
    ["227118"] = {
        23261, -- Champion's Satin Hood
    },
    -- Lieutenant Commander's Satin Mantle
    ["227119"] = {
        23317, -- Lieutenant Commander's Satin Mantle
    },
    -- Champion's Satin Mantle
    ["227120"] = {
        23262, -- Champion's Satin Mantle
    },
    -- Lieutenant Commander's Satin Hood
    ["227121"] = {
        23316, -- Lieutenant Commander's Satin Hood
    },
    -- Knight-Captain's Satin Tunic
    ["227122"] = {
        23303, -- Knight-Captain's Satin Tunic
    },
    -- Legionnaire's Satin Legguards
    ["227123"] = {
        22882, -- Legionnaire's Satin Legguards
    },
    -- Legionnaire's Satin Tunic
    ["227124"] = {
        22885, -- Legionnaire's Satin Tunic
    },
    -- Knight-Captain's Satin Legguards
    ["227125"] = {
        23302, -- Knight-Captain's Satin Legguards
    },
    -- Blood Guard's Satin Handwraps
    ["227126"] = {
        22869, -- Blood Guard's Satin Handwraps
    },
    -- Blood Guard's Satin Walkers
    ["227127"] = {
        22859, -- Blood Guard's Satin Walkers
    },
    -- Knight-Lieutenant's Satin Handwraps
    ["227128"] = {
        23288, -- Knight-Lieutenant's Satin Handwraps
    },
    -- Knight-Lieutenant's Satin Walkers
    ["227129"] = {
        23289, -- Knight-Lieutenant's Satin Walkers
    },
    -- Knight-Captain's Satin Leggings
    ["227137"] = {
        17599, -- Knight-Captain's Satin Leggings
    },
    -- Knight-Captain's Lamellar Breastplate
    ["227142"] = {
        16433, -- Knight-Captain's Lamellar Breastplate
        23272, -- Knight-Captain's Lamellar Breastplate
    },
    -- Knight-Captain's Lamellar Leggings
    ["227143"] = {
        16435, -- Knight-Captain's Lamellar Leggings
        23273, -- Knight-Captain's Lamellar Leggings
    },
    -- Lieutenant Commander's Lamellar Headguard
    ["227144"] = {
        16434, -- Lieutenant Commander's Lamellar Headguard
        23276, -- Lieutenant Commander's Lamellar Headguard
    },
    -- Lieutenant Commander's Lamellar Shoulders
    ["227145"] = {
        16436, -- Lieutenant Commander's Lamellar Shoulders
        23277, -- Lieutenant Commander's Lamellar Shoulders
    },
    -- Knight-Lieutenant's Lamellar Sabatons
    ["227146"] = {
        16409, -- Knight-Lieutenant's Lamellar Sabatons
        23275, -- Knight-Lieutenant's Lamellar Sabatons
    },
    -- Knight-Lieutenant's Lamellar Gauntlets
    ["227147"] = {
        16410, -- Knight-Lieutenant's Lamellar Gauntlets
        23274, -- Knight-Lieutenant's Lamellar Gauntlets
    },
    -- Champion's Mail Pauldrons
    ["227154"] = {
        23260, -- Champion's Mail Pauldrons
    },
    -- Champion's Mail Headguard
    ["227155"] = {
        23259, -- Champion's Mail Headguard
    },
    -- Legionnaire's Mail Legguards
    ["227156"] = {
        22887, -- Legionnaire's Mail Legguards
    },
    -- Legionnaire's Mail Hauberk
    ["227157"] = {
        22876, -- Legionnaire's Mail Hauberk
    },
    -- Blood Guard's Mail Greaves
    ["227158"] = {
        22857, -- Blood Guard's Mail Greaves
    },
    -- Blood Guard's Mail Vices
    ["227159"] = {
        22867, -- Blood Guard's Mail Vices
    },
    -- Legionnaire's Mail Leggings
    ["227161"] = {
        16523, -- Legionnaire's Mail Leggings
    },
    -- Champion's Mail Helm
    ["227162"] = {
        16521, -- Champion's Mail Helm
    },
    -- Lieutenant Commander's Dragonhide Shoulders
    ["227172"] = {
        23309, -- Lieutenant Commander's Dragonhide Shoulders
    },
    -- Lieutenant Commander's Dragonhide Headguard
    ["227173"] = {
        23308, -- Lieutenant Commander's Dragonhide Headguard
    },
    -- Champion's Dragonhide Headguard
    ["227174"] = {
        23253, -- Champion's Dragonhide Headguard
    },
    -- Champion's Dragonhide Shoulders
    ["227175"] = {
        23254, -- Champion's Dragonhide Shoulders
    },
    -- Knight-Captain's Dragonhide Chestpiece
    ["227176"] = {
        23294, -- Knight-Captain's Dragonhide Chestpiece
    },
    -- Legionnaire's Dragonhide Leggings
    ["227177"] = {
        22878, -- Legionnaire's Dragonhide Leggings
    },
    -- Knight-Captain's Dragonhide Leggings
    ["227178"] = {
        16422, -- Knight-Captain's Dragonhide Leggings
        23295, -- Knight-Captain's Dragonhide Leggings
    },
    -- Legionnaire's Dragonhide Chestpiece
    ["227179"] = {
        22877, -- Legionnaire's Dragonhide Chestpiece
    },
    -- Blood Guard's Dragonhide Grips
    ["227180"] = {
        22863, -- Blood Guard's Dragonhide Grips
    },
    -- Blood Guard's Dragonhide Treads
    ["227181"] = {
        22852, -- Blood Guard's Dragonhide Treads
    },
    -- Knight-Lieutenant's Dragonhide Treads
    ["227182"] = {
        23281, -- Knight-Lieutenant's Dragonhide Treads
    },
    -- Knight-Lieutenant's Dragonhide Grips
    ["227183"] = {
        23280, -- Knight-Lieutenant's Dragonhide Grips
    },
    -- Champion's Dragonhide Spaulders
    ["227184"] = {
        16501, -- Champion's Dragonhide Spaulders
    },
    -- Champion's Dragonhide Helm
    ["227186"] = {
        16503, -- Champion's Dragonhide Helm
    },
    -- Blood Guard's Dragonhide Boots
    ["227188"] = {
        16494, -- Blood Guard's Dragonhide Boots
    },
    -- Knight-Lieutenant's Dragonhide Gloves
    ["227193"] = {
        16397, -- Knight-Lieutenant's Dragonhide Gloves
    },
    -- Knight-Captain's Dragonhide Tunic
    ["227196"] = {
        16421, -- Knight-Captain's Dragonhide Tunic
    },
    -- Blood Guard's Dragonhide Gauntlets
    ["227204"] = {
        16496, -- Blood Guard's Dragonhide Gauntlets
    },
    -- Tidal Loop
    ["227454"] = {
        18398, -- Tidal Loop
    },
    -- Ocean's Breeze
    ["227455"] = {
        18399, -- Ocean's Breeze
    },
    -- Incandescent Belt
    ["227530"] = {
        226551, -- Felheart Belt
        226555, -- Arcanist Belt
        226570, -- Arcanist Cord
        226577, -- Girdle of Prophecy
        226580, -- Belt of Prophecy
    },
    -- Incandescent Bindings
    ["227531"] = {
        226553, -- Felheart Bracers
        226558, -- Arcanist Bindings
        226567, -- Arcanist Wristwraps
        226578, -- Vambraces of Prophecy
        226579, -- Wristwraps of Prophecy
    },
    -- Incandescent Hood
    ["227532"] = {
        226549, -- Felheart Horns
        226562, -- Arcanist Crown
        226564, -- Arcanist Headdress
        226573, -- Circlet of Prophecy
        226584, -- Crown of Prophecy
    },
    -- Incandescent Gloves
    ["227533"] = {
        226552, -- Felheart Gloves
        226556, -- Arcanist Gloves
        226569, -- Arcanist Handguards
        226572, -- Gloves of Prophecy
        226585, -- Hands of Prophecy
    },
    -- Incandescent Leggings
    ["227534"] = {
        226547, -- Felheart Pants
        226561, -- Arcanist Leggings
        226565, -- Arcanist Pants
        226574, -- Pants of Prophecy
        226583, -- Leggings of Prophecy
    },
    -- Incandescent Robe
    ["227535"] = {
        226548, -- Felheart Robes
        226559, -- Arcanist Robes
        226563, -- Arcanist Garments
        226575, -- Robes of Prophecy
        226582, -- Garments of Prophecy
    },
    -- Incandescent Boots
    ["227536"] = {
        226554, -- Felheart Slippers
        226557, -- Arcanist Boots
        226568, -- Arcanist Sandals
        226571, -- Boots of Prophecy
        226586, -- Sandals of Prophecy
    },
    -- Incandescent Shoulderpads
    ["227537"] = {
        226550, -- Felheart Shoulder Pads
        226560, -- Arcanist Mantle
        226566, -- Arcanist Shoulders
        226576, -- Mantle of Prophecy
        226581, -- Shoulderpads of Prophecy
    },
    -- Sulfuras, Hand of Ragnaros
    ["227683"] = {
        17182, -- Sulfuras, Hand of Ragnaros
    },
    -- Sulfuron Hammer
    ["227684"] = {
        17193, -- Sulfuron Hammer
    },
    -- Blade of Hanna
    ["227691"] = {
        2801, -- Blade of Hanna
    },
    -- Plans: Sulfuron Hammer
    ["227727"] = {
        18592, -- Plans: Sulfuron Hammer
    },
    -- Eye of Sulfuras
    ["227728"] = {
        17204, -- Eye of Sulfuras
        227683, -- Sulfuras, Hand of Ragnaros
    },
    -- Thorium Brotherhood Contract
    ["227730"] = {
        18628, -- Thorium Brotherhood Contract
    },
    -- Molten Scaled Bindings
    ["227750"] = {
        226530, -- Giantstalker's Bracers
        226541, -- Giantstalker's Wristguards
        226589, -- Lawbringer Bracers
        226596, -- Lawbringer Warbands
        226603, -- Lawbringer Vambraces
        226618, -- Earthfury Bracers
        226626, -- Earthfury Wristbands
        226634, -- Earthfury Wristguards
        226642, -- Earthfury Bindings
    },
    -- Molten Scaled Belt
    ["227751"] = {
        226529, -- Giantstalker's Belt
        226542, -- Giantstalker's Girdle
        226592, -- Lawbringer Belt
        226597, -- Lawbringer Girdle
        226604, -- Lawbringer Battlebelt
        226616, -- Earthfury Belt
        226625, -- Earthfury Cord
        226633, -- Earthfury Waistguard
        226641, -- Earthfury Girdle
    },
    -- Molten Scaled Shoulderpads
    ["227752"] = {
        221783, -- Lawbringer Shoulderplates
        226527, -- Giantstalker's Epaulets
        226543, -- Giantstalker's Spauldrons
        226588, -- Lawbringer Spaulders
        226605, -- Lawbringer Pauldrons
        226611, -- Earthfury Epaulets
        226624, -- Earthfury Mantle
        226632, -- Earthfury Pauldrons
        226640, -- Earthfury Spaulders
    },
    -- Molten Scaled Leggings
    ["227754"] = {
        226532, -- Giantstalker's Leggings
        226537, -- Giantstalker's Chain Leggings
        226594, -- Lawbringer Legplates
        226598, -- Lawbringer Leggings
        226606, -- Lawbringer Legguards
        226614, -- Earthfury Legguards
        226623, -- Earthfury Leggings
        226631, -- Earthfury Scaled Leggings
        226639, -- Earthfury Chain Leggings
    },
    -- Molten Scaled Helm
    ["227755"] = {
        226533, -- Giantstalker's Helmet
        226536, -- Giantstalker's Guise
        226590, -- Lawbringer Helm
        226599, -- Lawbringer Crown
        226607, -- Lawbringer Headguard
        226612, -- Earthfury Helmet
        226622, -- Earthfury Visor
        226630, -- Earthfury Greathelm
        226638, -- Earthfury Headpiece
    },
    -- Molten Scaled Gloves
    ["227756"] = {
        226528, -- Giantstalker's Gloves
        226540, -- Giantstalker's Handguards
        226591, -- Lawbringer Gauntlets
        226600, -- Lawbringer Grips
        226608, -- Lawbringer Handguards
        226615, -- Earthfury Gauntlets
        226621, -- Earthfury Hands
        226629, -- Earthfury Handguards
        226637, -- Earthfury Grips
    },
    -- Molten Scaled Boots
    ["227757"] = {
        226531, -- Giantstalker's Boots
        226538, -- Giantstalker's Sabatons
        226593, -- Lawbringer Boots
        226601, -- Lawbringer Battleboots
        226609, -- Lawbringer Sabatons
        226613, -- Earthfury Boots
        226620, -- Earthfury Walkers
        226628, -- Earthfury Sabatons
        226636, -- Earthfury Battleboots
    },
    -- Molten Scaled Chest
    ["227758"] = {
        226534, -- Giantstalker's Breastplate
        226535, -- Giantstalker's Chainmail
        226595, -- Lawbringer Chestguard
        226602, -- Lawbringer Breastplate
        226610, -- Lawbringer Chestplate
        226617, -- Earthfury Vestments
        226619, -- Earthfury Ringmail
        226627, -- Earthfury Scalemail
        226635, -- Earthfury Chainmail
    },
    -- Scorched Core Gloves
    ["227759"] = {
        226441, -- Nightslayer Gloves
        226475, -- Nightslayer Handguards
        226486, -- Gauntlets of Might
        226497, -- Hands of Might
        226648, -- Cenarion Gloves
        226654, -- Cenarion Gauntlets
        226664, -- Cenarion Fists
        226669, -- Cenarion Grips
    },
    -- Scorched Core Bindings
    ["227760"] = {
        226442, -- Nightslayer Bracelets
        226476, -- Nightslayer Bracers
        226484, -- Bracers of Might
        226499, -- Armguards of Might
        226649, -- Cenarion Bracers
        226655, -- Cenarion Wrists
        226662, -- Cenarion Bands
        226668, -- Cenarion Wristguards
    },
    -- Scorched Core Belt
    ["227761"] = {
        226440, -- Nightslayer Belt
        226474, -- Nightslayer Waistguard
        226485, -- Belt of Might
        226498, -- Sash of Might
        226650, -- Cenarion Belt
        226657, -- Cenarion Cord
        226660, -- Cenarion Girdle
        226667, -- Cenarion Waistguard
    },
    -- Scorched Core Shoulderpads
    ["227762"] = {
        226444, -- Nightslayer Shoulder Pads
        226478, -- Nightslayer Pauldrons
        226491, -- Shoulderplates of Might
        226492, -- Pauldrons of Might
        226644, -- Cenarion Spaulders
        226653, -- Cenarion Mantle
        226665, -- Cenarion Shoulders
        226674, -- Cenarion Pauldrons
    },
    -- Scorched Core Leggings
    ["227763"] = {
        226445, -- Nightslayer Pants
        226479, -- Nightslayer Legguards
        226490, -- Legplates of Might
        226493, -- Leggings of Might
        226646, -- Cenarion Leggings
        226651, -- Cenarion Pants
        226666, -- Cenarion Trousers
        226671, -- Cenarion Legguards
    },
    -- Scorched Core Helm
    ["227764"] = {
        226446, -- Nightslayer Cover
        226480, -- Nightslayer Hood
        226488, -- Helm of Might
        226495, -- Jaws of Might
        226647, -- Cenarion Helm
        226658, -- Cenarion Antlers
        226659, -- Cenarion Horns
        226670, -- Cenarion Crown
    },
    -- Scorched Core Boots
    ["227765"] = {
        226443, -- Nightslayer Boots
        226477, -- Nightslayer Tabi
        226487, -- Sabatons of Might
        226496, -- Treads of Might
        226645, -- Cenarion Boots
        226652, -- Cenarion Sandals
        226663, -- Cenarion Treads
        226673, -- Cenarion Walkers
    },
    -- Scorched Core Chest
    ["227766"] = {
        221785, -- Cenarion Vestments
        226447, -- Nightslayer Chestpiece
        226473, -- Nightslayer Cuirass
        226489, -- Breastplate of Might
        226494, -- Hauberk of Might
        226656, -- Cenarion Embrace
        226661, -- Cenarion Tunic
        226675, -- Cenarion Armor
    },
    -- Wisdom of the Timbermaw
    ["227806"] = {
        19047, -- Wisdom of the Timbermaw
    },
    -- Defender of the Timbermaw
    ["227811"] = {
        21326, -- Defender of the Timbermaw
    },
    -- Furbolg Medicine Pouch
    ["227812"] = {
        16768, -- Furbolg Medicine Pouch
    },
    -- Pattern: Golden Mantle of the Dawn
    ["227895"] = {
        19329, -- Pattern: Golden Mantle of the Dawn
    },
    -- Pattern: Argent Boots
    ["227896"] = {
        19216, -- Pattern: Argent Boots
    },
    -- Pattern: Argent Shoulders
    ["227897"] = {
        19217, -- Pattern: Argent Shoulders
    },
    -- Head of Rend Blackhand
    ["227911"] = {
        12630, -- Head of Rend Blackhand
    },
    -- Flame Wrath
    ["227934"] = {
        11809, -- Flame Wrath
    },
    -- Lord General's Sword
    ["227940"] = {
        11817, -- Lord General's Sword
    },
    -- Wraith Scythe
    ["227941"] = {
        11920, -- Wraith Scythe
    },
    -- Serpentine Skuller
    ["227942"] = {
        12605, -- Serpentine Skuller
    },
    -- Verek's Collar
    ["227943"] = {
        11755, -- Verek's Collar
    },
    -- Verek's Leash
    ["227944"] = {
        22242, -- Verek's Leash
    },
    -- Soot Encrusted Footwear
    ["227945"] = {
        22245, -- Soot Encrusted Footwear
    },
    -- Rubidium Hammer
    ["227946"] = {
        11805, -- Rubidium Hammer
    },
    -- Golem Fitted Pauldrons
    ["227947"] = {
        22212, -- Golem Fitted Pauldrons
    },
    -- Angerforge's Battle Axe
    ["227948"] = {
        11816, -- Angerforge's Battle Axe
    },
    -- Force of Magma
    ["227949"] = {
        11803, -- Force of Magma
    },
    -- Stone of the Earth
    ["227950"] = {
        11786, -- Stone of the Earth
    },
    -- Bloodfist
    ["227951"] = {
        11744, -- Bloodfist
    },
    -- Savage Gladiator Chain
    ["227952"] = {
        11726, -- Savage Gladiator Chain
    },
    -- The Hammer of Grace
    ["227953"] = {
        11923, -- The Hammer of Grace
    },
    -- Boreal Mantle
    ["227954"] = {
        11782, -- Boreal Mantle
    },
    -- Savage Gladiator Helm
    ["227955"] = {
        11729, -- Savage Gladiator Helm
    },
    -- Deathdealer Breastplate
    ["227956"] = {
        11926, -- Deathdealer Breastplate
    },
    -- Savage Gladiator Greaves
    ["227957"] = {
        11731, -- Savage Gladiator Greaves
    },
    -- Ghostshroud
    ["227958"] = {
        11925, -- Ghostshroud
    },
    -- Legplates of the Eternal Guardian
    ["227959"] = {
        11927, -- Legplates of the Eternal Guardian
    },
    -- Impervious Giant
    ["227960"] = {
        11921, -- Impervious Giant
    },
    -- Savage Gladiator Grips
    ["227961"] = {
        11730, -- Savage Gladiator Grips
    },
    -- Flarethorn
    ["227962"] = {
        22266, -- Flarethorn
    },
    -- Blood-etched Blade
    ["227963"] = {
        11922, -- Blood-etched Blade
    },
    -- Luminary Kilt
    ["227964"] = {
        11823, -- Luminary Kilt
    },
    -- Omnicast Boots
    ["227965"] = {
        11822, -- Omnicast Boots
    },
    -- Naglering
    ["227966"] = {
        11669, -- Naglering
    },
    -- Second Wind
    ["227967"] = {
        11819, -- Second Wind
    },
    -- Rockfist
    ["227968"] = {
        11743, -- Rockfist
    },
    -- Chief Architect's Monocle
    ["227969"] = {
        11839, -- Chief Architect's Monocle
    },
    -- Cape of the Fire Salamander
    ["227970"] = {
        11812, -- Cape of the Fire Salamander
    },
    -- Molten Fists
    ["227971"] = {
        11814, -- Molten Fists
    },
    -- Burst of Knowledge
    ["227972"] = {
        11832, -- Burst of Knowledge
    },
    -- Circle of Flame
    ["227973"] = {
        11808, -- Circle of Flame
    },
    -- Lavastone Hammer
    ["227974"] = {
        22208, -- Lavastone Hammer
    },
    -- Golem Skull Helm
    ["227975"] = {
        11746, -- Golem Skull Helm
    },
    -- Libram of Truth
    ["227976"] = {
        22400, -- Libram of Truth
    },
    -- Totem of Rage
    ["227977"] = {
        22395, -- Totem of Rage
    },
    -- Magmus Stone
    ["227978"] = {
        11935, -- Magmus Stone
    },
    -- Hands of the Exalted Herald
    ["227979"] = {
        12554, -- Hands of the Exalted Herald
    },
    -- Robes of the Royal Crown
    ["227980"] = {
        11924, -- Robes of the Royal Crown
    },
    -- Dreadforge Retaliator
    ["227981"] = {
        11931, -- Dreadforge Retaliator
    },
    -- Guiding Stave of Wisdom
    ["227982"] = {
        11932, -- Guiding Stave of Wisdom
    },
    -- Thaurissan's Royal Scepter
    ["227984"] = {
        11928, -- Thaurissan's Royal Scepter
    },
    -- The Emperor's New Cape
    ["227985"] = {
        11930, -- The Emperor's New Cape
    },
    -- Wristguards of Renown
    ["227986"] = {
        22204, -- Wristguards of Renown
    },
    -- Sash of the Grand Hunt
    ["227987"] = {
        22207, -- Sash of the Grand Hunt
    },
    -- Imperial Jewel
    ["227988"] = {
        11933, -- Imperial Jewel
    },
    -- Ironfoe
    ["227991"] = {
        11684, -- Ironfoe
    },
    -- Death Knight Sabatons
    ["227992"] = {
        18692, -- Death Knight Sabatons
    },
    -- Ebon Hilt of Marduk
    ["227993"] = {
        14576, -- Ebon Hilt of Marduk
    },
    -- Frightskull Shaft
    ["227994"] = {
        14531, -- Frightskull Shaft
    },
    -- Cadaverous Armor
    ["227995"] = {
        14637, -- Cadaverous Armor
    },
    -- Ancient Bone Bow
    ["227996"] = {
        18680, -- Ancient Bone Bow
    },
    -- Barovian Family Sword
    ["227997"] = {
        14541, -- Barovian Family Sword
    },
    -- Bloodmail Boots
    ["227998"] = {
        14616, -- Bloodmail Boots
    },
    -- Deathbone Sabatons
    ["227999"] = {
        14621, -- Deathbone Sabatons
    },
    -- Deathbone Chestplate
    ["228000"] = {
        14624, -- Deathbone Chestplate
    },
    -- Stoneform Shoulders
    ["228001"] = {
        13955, -- Stoneform Shoulders
    },
    -- Deathbone Girdle
    ["228002"] = {
        14620, -- Deathbone Girdle
    },
    -- Bloodmail Legguards
    ["228003"] = {
        14612, -- Bloodmail Legguards
    },
    -- Windreaver Greaves
    ["228004"] = {
        13967, -- Windreaver Greaves
    },
    -- Clutch of Andros
    ["228005"] = {
        13956, -- Clutch of Andros
    },
    -- Deathbone Gauntlets
    ["228006"] = {
        14622, -- Deathbone Gauntlets
    },
    -- Gargoyle Slashers
    ["228007"] = {
        13957, -- Gargoyle Slashers
    },
    -- Deathbone Legguards
    ["228008"] = {
        14623, -- Deathbone Legguards
    },
    -- Necropile Boots
    ["228009"] = {
        14631, -- Necropile Boots
    },
    -- Necropile Mantle
    ["228010"] = {
        14633, -- Necropile Mantle
    },
    -- Necropile Cuffs
    ["228011"] = {
        14629, -- Necropile Cuffs
    },
    -- Bloodmail Hauberk
    ["228012"] = {
        14611, -- Bloodmail Hauberk
    },
    -- Necropile Robe
    ["228013"] = {
        14626, -- Necropile Robe
    },
    -- Bloodmail Belt
    ["228014"] = {
        14614, -- Bloodmail Belt
    },
    -- Frightalon
    ["228015"] = {
        14024, -- Frightalon
    },
    -- Dimly Opalescent Ring
    ["228016"] = {
        18684, -- Dimly Opalescent Ring
    },
    -- Skullsmoke Pants
    ["228017"] = {
        14577, -- Skullsmoke Pants
    },
    -- Necropile Leggings
    ["228018"] = {
        14632, -- Necropile Leggings
    },
    -- Heart of the Fiend
    ["228019"] = {
        13960, -- Heart of the Fiend
    },
    -- Bloodmail Gauntlets
    ["228020"] = {
        14615, -- Bloodmail Gauntlets
    },
    -- Witchblade
    ["228021"] = {
        13964, -- Witchblade
    },
    -- Headmaster's Charge
    ["228022"] = {
        13937, -- Headmaster's Charge
    },
    -- Alanna's Embrace
    ["228023"] = {
        13314, -- Alanna's Embrace
    },
    -- Silent Fang
    ["228024"] = {
        13953, -- Silent Fang
    },
    -- Tombstone Breastplate
    ["228025"] = {
        13944, -- Tombstone Breastplate
    },
    -- Iceblade Hacker
    ["228027"] = {
        13952, -- Iceblade Hacker
    },
    -- Blade of Necromancy
    ["228028"] = {
        22332, -- Blade of Necromancy
    },
    -- Gravestone War Axe
    ["228029"] = {
        13983, -- Gravestone War Axe
    },
    -- Malicious Axe
    ["228030"] = {
        18759, -- Malicious Axe
    },
    -- Darkshade Gloves
    ["228031"] = {
        14543, -- Darkshade Gloves
    },
    -- Bone Ring Helm
    ["228032"] = {
        14539, -- Bone Ring Helm
    },
    -- Hammer of Divine Might
    ["228033"] = {
        22333, -- Hammer of Divine Might
    },
    -- Shivery Handwraps
    ["228034"] = {
        18693, -- Shivery Handwraps
    },
    -- Lord Blackwood's Buckler
    ["228035"] = {
        23139, -- Lord Blackwood's Buckler
    },
    -- Death's Clutch
    ["228036"] = {
        14503, -- Death's Clutch
    },
    -- Rattlecage Buckler
    ["228037"] = {
        14528, -- Rattlecage Buckler
    },
    -- Ironweave Pants
    ["228038"] = {
        22303, -- Ironweave Pants
    },
    -- Spellbound Tome
    ["228039"] = {
        18695, -- Spellbound Tome
    },
    -- Ghostloom Leggings
    ["228040"] = {
        14545, -- Ghostloom Leggings
    },
    -- Wraithplate Leggings
    ["228041"] = {
        18690, -- Wraithplate Leggings
    },
    -- Detention Strap
    ["228042"] = {
        13950, -- Detention Strap
    },
    -- Boots of the Shrieker
    ["228043"] = {
        13398, -- Boots of the Shrieker
    },
    -- Maelstrom Leggings
    ["228044"] = {
        14522, -- Maelstrom Leggings
    },
    -- Necromantic Band
    ["228045"] = {
        18760, -- Necromantic Band
    },
    -- Don Mauricio's Band of Domination
    ["228046"] = {
        22433, -- Don Mauricio's Band of Domination
    },
    -- Amalgam's Band
    ["228047"] = {
        22326, -- Amalgam's Band
    },
    -- Libram of Divinity
    ["228048"] = {
        23201, -- Libram of Divinity
    },
    -- Totem of Sustaining
    ["228049"] = {
        23200, -- Totem of Sustaining
    },
    -- Satyr's Bow
    ["228050"] = {
        18323, -- Satyr's Bow
    },
    -- Quel'dorai Channeling Rod
    ["228051"] = {
        18311, -- Quel'dorai Channeling Rod
    },
    -- Waveslicer
    ["228052"] = {
        18324, -- Waveslicer
    },
    -- Fervent Helm
    ["228053"] = {
        18319, -- Fervent Helm
    },
    -- Tempest Talisman
    ["228054"] = {
        18317, -- Tempest Talisman
    },
    -- Energized Chestplate
    ["228055"] = {
        18312, -- Energized Chestplate
    },
    -- Fiendish Machete
    ["228056"] = {
        18310, -- Fiendish Machete
    },
    -- Ring of Demonic Potency
    ["228057"] = {
        18315, -- Ring of Demonic Potency
    },
    -- Bulky Iron Spaulders
    ["228058"] = {
        18493, -- Bulky Iron Spaulders
    },
    -- Denwatcher's Shoulders
    ["228059"] = {
        18494, -- Denwatcher's Shoulders
    },
    -- Heliotrope Cloak
    ["228060"] = {
        18496, -- Heliotrope Cloak
    },
    -- Brightspark Gloves
    ["228061"] = {
        18387, -- Brightspark Gloves
    },
    -- Insightful Hood
    ["228062"] = {
        18490, -- Insightful Hood
    },
    -- Warpwood Binding
    ["228063"] = {
        18393, -- Warpwood Binding
    },
    -- Observer's Shield
    ["228064"] = {
        18485, -- Observer's Shield
    },
    -- Cyclone Spaulders
    ["228065"] = {
        18528, -- Cyclone Spaulders
    },
    -- Ironweave Gloves
    ["228066"] = {
        22304, -- Ironweave Gloves
    },
    -- Elder Magus Pendant
    ["228067"] = {
        18397, -- Elder Magus Pendant
    },
    -- Mugger's Belt
    ["228068"] = {
        18505, -- Mugger's Belt
    },
    -- Eldritch Reinforced Legplates
    ["228069"] = {
        18380, -- Eldritch Reinforced Legplates
    },
    -- Ogre Forged Hauberk
    ["228070"] = {
        18530, -- Ogre Forged Hauberk
    },
    -- Hammer of The Black Anvil
    ["228128"] = {
        228508, -- Hammer of The Black Anvil
    },
    -- Shadowflame Skull
    ["228129"] = {
        228143, -- Shadowflame Sword
    },
    -- Fist of the Firesworn
    ["228139"] = {
        229374, -- Fist of the Firesworn
    },
    -- Shadowflame Sword
    ["228143"] = {
        228129, -- Shadowflame Skull
    },
    -- Magmadar's Right Claw
    ["228145"] = {
        229378, -- Magmadar's Right Claw
    },
    -- Magmadar's Left Claw
    ["228146"] = {
        229377, -- Magmadar's Left Claw
    },
    -- Faithbringer
    ["228160"] = {
        229373, -- Faithbringer
    },
    -- Key to the City
    ["228166"] = {
        12382, -- Key to the City
    },
    -- Obsidian Edged Blade
    ["228229"] = {
        228459, -- Obsidian Edged Blade
    },
    -- Robe of Volatile Power
    ["228239"] = {
        19145, -- Robe of Volatile Power
    },
    -- Flamewaker Legplates
    ["228240"] = {
        18861, -- Flamewaker Legplates
    },
    -- Heavy Dark Iron Ring
    ["228242"] = {
        18879, -- Heavy Dark Iron Ring
    },
    -- Ring of Spell Power
    ["228243"] = {
        19147, -- Ring of Spell Power
    },
    -- Manastorm Leggings
    ["228244"] = {
        18872, -- Manastorm Leggings
    },
    -- Salamander Scale Pants
    ["228245"] = {
        18875, -- Salamander Scale Pants
    },
    -- Wristguards of Stability
    ["228246"] = {
        19146, -- Wristguards of Stability
    },
    -- Choker of Enlightenment
    ["228247"] = {
        17109, -- Choker of Enlightenment
    },
    -- Earthshaker
    ["228248"] = {
        17073, -- Earthshaker
        228463, -- Earthshaker
    },
    -- Medallion of Steadfast Might
    ["228249"] = {
        17065, -- Medallion of Steadfast Might
    },
    -- Striker's Mark
    ["228252"] = {
        17069, -- Striker's Mark
        228519, -- Striker's Mark
    },
    -- Sabatons of the Flamewalker
    ["228253"] = {
        19144, -- Sabatons of the Flamewalker
    },
    -- Magma Tempered Boots
    ["228254"] = {
        18824, -- Magma Tempered Boots
    },
    -- Talisman of Ephemeral Power
    ["228255"] = {
        18820, -- Talisman of Ephemeral Power
    },
    -- Mana Igniting Cord
    ["228256"] = {
        19136, -- Mana Igniting Cord
    },
    -- Aged Core Leather Gloves
    ["228257"] = {
        18823, -- Aged Core Leather Gloves
    },
    -- Deep Earth Spaulders
    ["228258"] = {
        18829, -- Deep Earth Spaulders
    },
    -- Fire Runed Grimoire
    ["228259"] = {
        19142, -- Fire Runed Grimoire
    },
    -- Flameguard Gauntlets
    ["228260"] = {
        19143, -- Flameguard Gauntlets
    },
    -- Quick Strike Ring
    ["228261"] = {
        18821, -- Quick Strike Ring
    },
    -- Crimson Shocker
    ["228262"] = {
        17077, -- Crimson Shocker
    },
    -- Sorcerous Dagger
    ["228263"] = {
        18878, -- Sorcerous Dagger
        229376, -- Sorcerous Dagger
    },
    -- Aurastone Hammer
    ["228264"] = {
        228462, -- Aurastone Hammer
    },
    -- Brutality Blade
    ["228265"] = {
        18832, -- Brutality Blade
        228506, -- Brutality Blade
    },
    -- Drillborer Disk
    ["228266"] = {
        228702, -- Drillborer Disk
    },
    -- Gutgore Ripper
    ["228267"] = {
        17071, -- Gutgore Ripper
        229372, -- Gutgore Ripper
    },
    -- Seal of the Archmagus
    ["228268"] = {
        17110, -- Seal of the Archmagus
    },
    -- Azuresong Mageblade
    ["228269"] = {
        17103, -- Azuresong Mageblade
        228517, -- Azuresong Mageblade
    },
    -- Blastershot Launcher
    ["228270"] = {
        17072, -- Blastershot Launcher
    },
    -- Staff of Dominance
    ["228271"] = {
        18842, -- Staff of Dominance
        228922, -- Staff of Dominance
    },
    -- Shadowstrike
    ["228272"] = {
        17074, -- Shadowstrike
        229380, -- Shadowstrike
    },
    -- Thunderstrike
    ["228273"] = {
        17223, -- Thunderstrike
        229381, -- Thunderstrike
    },
    -- Cauterizing Band
    ["228274"] = {
        19140, -- Cauterizing Band
    },
    -- Core Forged Greaves
    ["228275"] = {
        18806, -- Core Forged Greaves
    },
    -- Core Hound Tooth
    ["228277"] = {
        18805, -- Core Hound Tooth
        228701, -- Core Hound Tooth
    },
    -- Hyperthermically Insulated Lava Dredger
    ["228278"] = {
        18803, -- Hyperthermically Insulated Lava Dredger
        229382, -- Hyperthermically Insulated Lava Dredger
    },
    -- Fireguard Shoulders
    ["228279"] = {
        19139, -- Fireguard Shoulders
    },
    -- Fireproof Cloak
    ["228280"] = {
        18811, -- Fireproof Cloak
    },
    -- Gloves of the Hypnotic Flame
    ["228281"] = {
        18808, -- Gloves of the Hypnotic Flame
    },
    -- Sash of Whispered Secrets
    ["228282"] = {
        18809, -- Sash of Whispered Secrets
    },
    -- Wild Growth Spaulders
    ["228283"] = {
        18810, -- Wild Growth Spaulders
    },
    -- Wristguards of True Flight
    ["228284"] = {
        18812, -- Wristguards of True Flight
    },
    -- Helm of the Lifegiver
    ["228285"] = {
        18870, -- Helm of the Lifegiver
    },
    -- Band of Accuria
    ["228286"] = {
        17063, -- Band of Accuria
    },
    -- Band of Sulfuras
    ["228287"] = {
        19138, -- Band of Sulfuras
    },
    -- Bonereaver's Edge
    ["228288"] = {
        228461, -- Bonereaver's Edge
    },
    -- Choker of the Fire Lord
    ["228289"] = {
        18814, -- Choker of the Fire Lord
    },
    -- Cloak of the Shrouded Mists
    ["228290"] = {
        17102, -- Cloak of the Shrouded Mists
    },
    -- Crown of Destruction
    ["228291"] = {
        18817, -- Crown of Destruction
    },
    -- Dragon's Blood Cape
    ["228292"] = {
        17107, -- Dragon's Blood Cape
    },
    -- Essence of the Pure Flame
    ["228293"] = {
        18815, -- Essence of the Pure Flame
    },
    -- Malistar's Defender
    ["228294"] = {
        17106, -- Malistar's Defender
    },
    -- Onslaught Girdle
    ["228295"] = {
        19137, -- Onslaught Girdle
    },
    -- Perdition's Blade
    ["228296"] = {
        18816, -- Perdition's Blade
        228511, -- Perdition's Blade
    },
    -- Shard of the Flame
    ["228297"] = {
        17082, -- Shard of the Flame
    },
    -- Shard of the Scale
    ["228298"] = {
        17064, -- Shard of the Scale
    },
    -- Spinal Reaper
    ["228299"] = {
        17104, -- Spinal Reaper
        228460, -- Spinal Reaper
    },
    -- Lok'delar, Stave of the Ancient Keepers
    ["228332"] = {
        18715, -- Lok'delar, Stave of the Ancient Keepers
    },
    -- Rhok'delar, Longbow of the Ancient Keepers
    ["228334"] = {
        18713, -- Rhok'delar, Longbow of the Ancient Keepers
    },
    -- Benediction
    ["228335"] = {
        18608, -- Benediction
    },
    -- Anathema
    ["228336"] = {
        18609, -- Anathema
    },
    -- Unmelting Ice Girdle
    ["228340"] = {
        18547, -- Unmelting Ice Girdle
    },
    -- Leggings of Arcane Supremacy
    ["228345"] = {
        18545, -- Leggings of Arcane Supremacy
    },
    -- Typhoon
    ["228347"] = {
        18542, -- Typhoon
    },
    -- Eskhandar's Left Claw
    ["228349"] = {
        18202, -- Eskhandar's Left Claw
    },
    -- Eskhandar's Right Claw
    ["228350"] = {
        18203, -- Eskhandar's Right Claw
        229379, -- Eskhandar's Right Claw
    },
    -- Doomhide Gauntlets
    ["228351"] = {
        18544, -- Doomhide Gauntlets
    },
    -- Fel Infused Leggings
    ["228352"] = {
        19133, -- Fel Infused Leggings
    },
    -- Infernal Headcage
    ["228353"] = {
        18546, -- Infernal Headcage
    },
    -- Blazefury Medallion
    ["228354"] = {
        17111, -- Blazefury Medallion
    },
    -- Flayed Doomguard Belt
    ["228355"] = {
        19134, -- Flayed Doomguard Belt
    },
    -- Amberseal Keeper
    ["228356"] = {
        17113, -- Amberseal Keeper
    },
    -- Blacklight Bracer
    ["228357"] = {
        19135, -- Blacklight Bracer
    },
    -- Ring of Entropy
    ["228359"] = {
        18543, -- Ring of Entropy
    },
    -- Eskhandar's Pelt
    ["228360"] = {
        18204, -- Eskhandar's Pelt
    },
    -- Cold Snap
    ["228381"] = {
        19130, -- Cold Snap
    },
    -- Fang of the Mystics
    ["228382"] = {
        17070, -- Fang of the Mystics
    },
    -- Puissant Cape
    ["228383"] = {
        18541, -- Puissant Cape
    },
    -- Snowblind Shoes
    ["228384"] = {
        19131, -- Snowblind Shoes
    },
    -- Crystal Adorned Crown
    ["228385"] = {
        19132, -- Crystal Adorned Crown
    },
    -- Drape of Benediction
    ["228389"] = {
        18208, -- Drape of Benediction
    },
    -- Empyrean Demolisher
    ["228397"] = {
        17112, -- Empyrean Demolisher
    },
    -- Obsidian Edged Blade
    ["228459"] = {
        18822, -- Obsidian Edged Blade
        228229, -- Obsidian Edged Blade
    },
    -- Spinal Reaper
    ["228460"] = {
        228299, -- Spinal Reaper
    },
    -- Bonereaver's Edge
    ["228461"] = {
        17076, -- Bonereaver's Edge
        228288, -- Bonereaver's Edge
    },
    -- Aurastone Hammer
    ["228462"] = {
        17105, -- Aurastone Hammer
        228264, -- Aurastone Hammer
    },
    -- Earthshaker
    ["228463"] = {
        228248, -- Earthshaker
    },
    -- Royal Seal of Eldre'Thalas
    ["228467"] = {
        18465, -- Royal Seal of Eldre'Thalas
        18466, -- Royal Seal of Eldre'Thalas
        18467, -- Royal Seal of Eldre'Thalas
        18468, -- Royal Seal of Eldre'Thalas
        18469, -- Royal Seal of Eldre'Thalas
        18470, -- Royal Seal of Eldre'Thalas
        18471, -- Royal Seal of Eldre'Thalas
        18472, -- Royal Seal of Eldre'Thalas
        18473, -- Royal Seal of Eldre'Thalas
    },
    -- Tanglemoss Leggings
    ["228468"] = {
        18390, -- Tanglemoss Leggings
    },
    -- Tarnished Elven Ring
    ["228469"] = {
        18500, -- Tarnished Elven Ring
    },
    -- Silvermoon Leggings
    ["228470"] = {
        18378, -- Silvermoon Leggings
    },
    -- Stoneshatter
    ["228471"] = {
        18388, -- Stoneshatter
    },
    -- Distracting Dagger
    ["228472"] = {
        18392, -- Distracting Dagger
    },
    -- Unyielding Maul
    ["228473"] = {
        18531, -- Unyielding Maul
    },
    -- Mindsurge Robe
    ["228474"] = {
        18532, -- Mindsurge Robe
    },
    -- Diabolic Mantle
    ["228475"] = {
        18757, -- Diabolic Mantle
    },
    -- Barbarous Blade
    ["228478"] = {
        18520, -- Barbarous Blade
    },
    -- Leggings of Destruction
    ["228479"] = {
        18524, -- Leggings of Destruction
    },
    -- Crown of the Ogre King
    ["228480"] = {
        18526, -- Crown of the Ogre King
    },
    -- Rod of the Ogre Magi
    ["228484"] = {
        18534, -- Rod of the Ogre Magi
    },
    -- Treant's Bane
    ["228486"] = {
        18538, -- Treant's Bane
    },
    -- Mask of the Unforgiven
    ["228500"] = {
        13404, -- Mask of the Unforgiven
    },
    -- Songbird Blouse
    ["228501"] = {
        13378, -- Songbird Blouse
    },
    -- Piccolo of the Flaming Fire
    ["228502"] = {
        13379, -- Piccolo of the Flaming Fire
    },
    -- Woollies of the Prancing Minstrel
    ["228503"] = {
        13383, -- Woollies of the Prancing Minstrel
    },
    -- Rainbow Girdle
    ["228504"] = {
        13384, -- Rainbow Girdle
    },
    -- Royal Tribunal Cloak
    ["228505"] = {
        13376, -- Royal Tribunal Cloak
    },
    -- Brutality Blade
    ["228506"] = {
        228265, -- Brutality Blade
    },
    -- Hammer of The Black Anvil
    ["228508"] = {
        228128, -- Hammer of The Black Anvil
    },
    -- Perdition's Blade
    ["228511"] = {
        228296, -- Perdition's Blade
    },
    -- Vambraces of the Sadist
    ["228513"] = {
        13400, -- Vambraces of the Sadist
    },
    -- Timmy's Galoshes
    ["228514"] = {
        13402, -- Timmy's Galoshes
    },
    -- Grimgore Noose
    ["228515"] = {
        13403, -- Grimgore Noose
    },
    -- Peacemaker
    ["228516"] = {
        18725, -- Peacemaker
    },
    -- Azuresong Mageblade
    ["228517"] = {
        228269, -- Azuresong Mageblade
    },
    -- Magistrate's Cuffs
    ["228518"] = {
        18726, -- Magistrate's Cuffs
    },
    -- Striker's Mark
    ["228519"] = {
        228252, -- Striker's Mark
    },
    -- Soulstealer Mantle
    ["228520"] = {
        13374, -- Soulstealer Mantle
    },
    -- Shadowy Laced Handwraps
    ["228521"] = {
        18730, -- Shadowy Laced Handwraps
    },
    -- Willey's Portable Howitzer
    ["228522"] = {
        13380, -- Willey's Portable Howitzer
    },
    -- Cannonball Runner
    ["228523"] = {
        13382, -- Cannonball Runner
    },
    -- The Postmaster's Seal
    ["228524"] = {
        13392, -- The Postmaster's Seal
    },
    -- The Postmaster's Tunic
    ["228525"] = {
        13388, -- The Postmaster's Tunic
    },
    -- The Postmaster's Trousers
    ["228527"] = {
        13389, -- The Postmaster's Trousers
    },
    -- The Postmaster's Band
    ["228528"] = {
        13390, -- The Postmaster's Band
    },
    -- The Postmaster's Treads
    ["228529"] = {
        13391, -- The Postmaster's Treads
    },
    -- Chitinous Plate Legguards
    ["228530"] = {
        18739, -- Chitinous Plate Legguards
    },
    -- Thuzadin Sash
    ["228531"] = {
        18740, -- Thuzadin Sash
    },
    -- Morlune's Bracer
    ["228532"] = {
        18741, -- Morlune's Bracer
    },
    -- Nacreous Shell Necklace
    ["228533"] = {
        22403, -- Nacreous Shell Necklace
    },
    -- Plaguehound Leggings
    ["228534"] = {
        18736, -- Plaguehound Leggings
    },
    -- Bone Slicing Hatchet
    ["228535"] = {
        18737, -- Bone Slicing Hatchet
    },
    -- Star of Mystaria
    ["228536"] = {
        12103, -- Star of Mystaria
    },
    -- Dracorian Gauntlets
    ["228537"] = {
        13344, -- Dracorian Gauntlets
    },
    -- Seal of Rivendare
    ["228538"] = {
        13345, -- Seal of Rivendare
    },
    -- Book of the Dead
    ["228539"] = {
        13353, -- Book of the Dead
    },
    -- Crown of Tyranny
    ["228540"] = {
        13359, -- Crown of Tyranny
    },
    -- Gift of the Elven Magi
    ["228541"] = {
        13360, -- Gift of the Elven Magi
    },
    -- Skullforge Reaver
    ["228542"] = {
        13361, -- Skullforge Reaver
    },
    -- Runeblade of Baron Rivendare
    ["228543"] = {
        13505, -- Runeblade of Baron Rivendare
    },
    -- Hammer of the Grand Crusader
    ["228544"] = {
        18717, -- Hammer of the Grand Crusader
    },
    -- Grand Crusader's Helm
    ["228545"] = {
        18718, -- Grand Crusader's Helm
    },
    -- Shroud of the Nathrezim
    ["228546"] = {
        18720, -- Shroud of the Nathrezim
    },
    -- Ironweave Robe
    ["228547"] = {
        22301, -- Ironweave Robe
    },
    -- Scepter of Interminable Focus
    ["228548"] = {
        22329, -- Scepter of Interminable Focus
    },
    -- Tunic of the Crescent Moon
    ["228551"] = {
        22409, -- Tunic of the Crescent Moon
    },
    -- Gauntlets of Deftness
    ["228552"] = {
        22410, -- Gauntlets of Deftness
    },
    -- Helm of the Executioner
    ["228553"] = {
        22411, -- Helm of the Executioner
    },
    -- Demonskin Gloves
    ["228554"] = {
        13181, -- Demonskin Gloves
    },
    -- Phase Blade
    ["228555"] = {
        13182, -- Phase Blade
    },
    -- Butcher's Apron
    ["228556"] = {
        12608, -- Butcher's Apron
    },
    -- Swiftdart Battleboots
    ["228557"] = {
        13284, -- Swiftdart Battleboots
    },
    -- Funeral Cuffs
    ["228558"] = {
        12626, -- Funeral Cuffs
    },
    -- Blackcrow
    ["228559"] = {
        12651, -- Blackcrow
    },
    -- Trueaim Gauntlets
    ["228561"] = {
        13255, -- Trueaim Gauntlets
    },
    -- Demonic Runed Spaulders
    ["228562"] = {
        13257, -- Demonic Runed Spaulders
    },
    -- Globe of D'sak
    ["228563"] = {
        13261, -- Globe of D'sak
    },
    -- Ogreseer Tower Boots
    ["228564"] = {
        13282, -- Ogreseer Tower Boots
    },
    -- Magus Ring
    ["228565"] = {
        13283, -- Magus Ring
    },
    -- Starfire Tiara
    ["228566"] = {
        12604, -- Starfire Tiara
    },
    -- Chiselbrand Girdle
    ["228567"] = {
        12634, -- Chiselbrand Girdle
    },
    -- Backusarian Gauntlets
    ["228568"] = {
        12637, -- Backusarian Gauntlets
    },
    -- Fist of Omokk
    ["228570"] = {
        13167, -- Fist of Omokk
    },
    -- Plate of the Shaman King
    ["228571"] = {
        13168, -- Plate of the Shaman King
    },
    -- Brazecore Armguards
    ["228572"] = {
        13179, -- Brazecore Armguards
    },
    -- Venomspitter
    ["228573"] = {
        13183, -- Venomspitter
    },
    -- Talisman of Evasion
    ["228574"] = {
        13177, -- Talisman of Evasion
    },
    -- Slashclaw Bracers
    ["228575"] = {
        13211, -- Slashclaw Bracers
    },
    -- Smolderweb's Eye
    ["228576"] = {
        13213, -- Smolderweb's Eye
    },
    -- Gilded Gauntlets
    ["228577"] = {
        13244, -- Gilded Gauntlets
    },
    -- Dustfeather Sash
    ["228578"] = {
        12589, -- Dustfeather Sash
    },
    -- Crystallized Girdle
    ["228579"] = {
        12606, -- Crystallized Girdle
    },
    -- Truestrike Shoulders
    ["228583"] = {
        12927, -- Truestrike Shoulders
    },
    -- Emberfury Talisman
    ["228584"] = {
        12929, -- Emberfury Talisman
    },
    -- Mark of the Dragon Lord
    ["228585"] = {
        13143, -- Mark of the Dragon Lord
    },
    -- Chillpike
    ["228586"] = {
        13148, -- Chillpike
    },
    -- Trindlehaven Staff
    ["228587"] = {
        13161, -- Trindlehaven Staff
    },
    -- Reiver Claws
    ["228588"] = {
        13162, -- Reiver Claws
    },
    -- Heart of the Scale
    ["228589"] = {
        13164, -- Heart of the Scale
    },
    -- Sunderseer Mantle
    ["228590"] = {
        13185, -- Sunderseer Mantle
    },
    -- Rhombeard Protector
    ["228591"] = {
        13205, -- Rhombeard Protector
    },
    -- Fang of the Crystal Spider
    ["228592"] = {
        13218, -- Fang of the Crystal Spider
    },
    -- Wind Dancer Boots
    ["228593"] = {
        13260, -- Wind Dancer Boots
    },
    -- Kayser's Boots of Precision
    ["228594"] = {
        22231, -- Kayser's Boots of Precision
    },
    -- Marksman's Girdle
    ["228595"] = {
        22232, -- Marksman's Girdle
    },
    -- Ironweave Belt
    ["228596"] = {
        22306, -- Ironweave Belt
    },
    -- Ironweave Boots
    ["228597"] = {
        22311, -- Ironweave Boots
    },
    -- Ironweave Bracers
    ["228598"] = {
        22313, -- Ironweave Bracers
    },
    -- Heart of Wyrmthalak
    ["228599"] = {
        22321, -- Heart of Wyrmthalak
    },
    -- The Jaw Breaker
    ["228600"] = {
        22322, -- The Jaw Breaker
    },
    -- Relentless Scythe
    ["228601"] = {
        13163, -- Relentless Scythe
    },
    -- Flame Walkers
    ["228602"] = {
        18047, -- Flame Walkers
    },
    -- Blackhand Doomsaw
    ["228603"] = {
        12583, -- Blackhand Doomsaw
    },
    -- Eye of Rend
    ["228604"] = {
        12587, -- Eye of Rend
    },
    -- Bonespike Shoulder
    ["228605"] = {
        12588, -- Bonespike Shoulder
    },
    -- Blackblade of Shahram
    ["228606"] = {
        12592, -- Blackblade of Shahram
    },
    -- Warmaster Legguards
    ["228650"] = {
        12935, -- Warmaster Legguards
    },
    -- Battleborn Armbraces
    ["228651"] = {
        12936, -- Battleborn Armbraces
    },
    -- Dal'Rend's Tribal Guardian
    ["228652"] = {
        12939, -- Dal'Rend's Tribal Guardian
    },
    -- Dal'Rend's Sacred Charge
    ["228653"] = {
        12940, -- Dal'Rend's Sacred Charge
    },
    -- Ancient Rune Etched Stave
    ["228659"] = {
        18707, -- Ancient Rune Etched Stave
    },
    -- Blademaster Leggings
    ["228660"] = {
        12963, -- Blademaster Leggings
    },
    -- Tristam Legguards
    ["228661"] = {
        12964, -- Tristam Legguards
    },
    -- Blackmist Armguards
    ["228662"] = {
        12966, -- Blackmist Armguards
    },
    -- Bloodmoon Cloak
    ["228663"] = {
        12967, -- Bloodmoon Cloak
    },
    -- Frostweaver Cape
    ["228664"] = {
        12968, -- Frostweaver Cape
    },
    -- Seeping Willow
    ["228666"] = {
        12969, -- Seeping Willow
    },
    -- Painweaver Band
    ["228667"] = {
        13098, -- Painweaver Band
    },
    -- Tooth of Gnarr
    ["228669"] = {
        13141, -- Tooth of Gnarr
    },
    -- Brigam Girdle
    ["228670"] = {
        13142, -- Brigam Girdle
    },
    -- Handcrafted Mastersmith Girdle
    ["228672"] = {
        13502, -- Handcrafted Mastersmith Girdle
    },
    -- Band of Rumination
    ["228675"] = {
        18103, -- Band of Rumination
    },
    -- Feralsurge Girdle
    ["228676"] = {
        18104, -- Feralsurge Girdle
    },
    -- Spellweaver's Turban
    ["228677"] = {
        22267, -- Spellweaver's Turban
    },
    -- Draconic Infused Emblem
    ["228678"] = {
        22268, -- Draconic Infused Emblem
    },
    -- Quel'Serrar
    ["228679"] = {
        18348, -- Quel'Serrar
    },
    -- Ironweave Cowl
    ["228681"] = {
        22302, -- Ironweave Cowl
    },
    -- Lord Valthalak's Staff of Command
    ["228682"] = {
        22335, -- Lord Valthalak's Staff of Command
    },
    -- Rune Band of Wizardry
    ["228683"] = {
        22339, -- Rune Band of Wizardry
    },
    -- Pendant of Celerity
    ["228684"] = {
        22340, -- Pendant of Celerity
    },
    -- Onyxia Tooth Pendant
    ["228685"] = {
        18404, -- Onyxia Tooth Pendant
    },
    -- Onyxia Blood Talisman
    ["228686"] = {
        18406, -- Onyxia Blood Talisman
        18423, -- Head of Onyxia (Alliance)
    },
    -- Dragonslayer's Signet
    ["228687"] = {
        18403, -- Dragonslayer's Signet
    },
    -- Head of Onyxia
    ["228689"] = {
        18422, -- Head of Onyxia (Horde)
        228685, -- Onyxia Tooth Pendant
        228686, -- Onyxia Blood Talisman
        228687, -- Dragonslayer's Signet
    },
    -- The Light and How to Swing It
    ["228690"] = {
        18359, -- The Light and How to Swing It
    },
    -- Garona: A Study on Stealth and Treachery
    ["228691"] = {
        18356, -- Garona: A Study on Stealth and Treachery
    },
    -- Codex of Defense
    ["228692"] = {
        18357, -- Codex of Defense
    },
    -- The Arcanist's Cookbook
    ["228693"] = {
        18358, -- The Arcanist's Cookbook
    },
    -- A Dull and Flat Elven Blade
    ["228695"] = {
        18513, -- A Dull and Flat Elven Blade
    },
    -- Heated Ancient Blade
    ["228696"] = {
        18488, -- Heated Ancient Blade
    },
    -- Treated Ancient Blade
    ["228697"] = {
        18492, -- Treated Ancient Blade
    },
    -- Ring of Demonic Guile
    ["228699"] = {
        18314, -- Ring of Demonic Guile
    },
    -- Ironweave Mantle
    ["228700"] = {
        22305, -- Ironweave Mantle
    },
    -- Core Hound Tooth
    ["228701"] = {
        228277, -- Core Hound Tooth
    },
    -- Drillborer Disk
    ["228702"] = {
        17066, -- Drillborer Disk
        228266, -- Drillborer Disk
    },
    -- Coldstone Slippers
    ["228703"] = {
        18697, -- Coldstone Slippers
    },
    -- Tattered Leather Hood
    ["228704"] = {
        18698, -- Tattered Leather Hood
    },
    -- Hand of Justice
    ["228722"] = {
        11815, -- Hand of Justice
    },
    -- Fluorescent Green Mechanostrider
    ["228746"] = {
        13325, -- Fluorescent Green Mechanostrider
    },
    -- Splinter of Nordrassil
    ["228749"] = {
        18659, -- Splinter of Nordrassil
    },
    -- Felstriker
    ["228757"] = {
        12590, -- Felstriker
    },
    -- Eskhandar's Collar
    ["228759"] = {
        18205, -- Eskhandar's Collar
    },
    -- Staff of Dominance
    ["228922"] = {
        228271, -- Staff of Dominance
    },
    -- Ancient Cornerstone Grimoire
    ["228955"] = {
        17067, -- Ancient Cornerstone Grimoire
    },
    -- Onyxia Hide Backpack
    ["228992"] = {
        17966, -- Onyxia Hide Backpack
    },
    -- Pattern: Bottomless Bag
    ["228993"] = {
        14510, -- Pattern: Bottomless Bag
    },
    -- Bottomless Bag
    ["228994"] = {
        14156, -- Bottomless Bag
    },
    -- Formula: Enchant Cloak - Greater Fire Resistance
    ["229008"] = {
        20732, -- Formula: Enchant Cloak - Greater Fire Resistance
    },
    -- Formula: Enchant Cloak - Greater Nature Resistance
    ["229009"] = {
        20733, -- Formula: Enchant Cloak - Greater Nature Resistance
    },
    -- Intelligence Findings
    ["229352"] = {
        224122, -- Dream Eater
    },
    -- Gutgore Ripper
    ["229372"] = {
        228267, -- Gutgore Ripper
    },
    -- Faithbringer
    ["229373"] = {
        228160, -- Faithbringer
    },
    -- Fist of the Firesworn
    ["229374"] = {
        228139, -- Fist of the Firesworn
    },
    -- Sorcerous Dagger
    ["229376"] = {
        228263, -- Sorcerous Dagger
    },
    -- Magmadar's Left Claw
    ["229377"] = {
        228146, -- Magmadar's Left Claw
    },
    -- Magmadar's Right Claw
    ["229378"] = {
        228145, -- Magmadar's Right Claw
    },
    -- Eskhandar's Right Claw
    ["229379"] = {
        228350, -- Eskhandar's Right Claw
    },
    -- Shadowstrike
    ["229380"] = {
        228272, -- Shadowstrike
    },
    -- Thunderstrike
    ["229381"] = {
        228273, -- Thunderstrike
    },
    -- Hyperthermically Insulated Lava Dredger
    ["229382"] = {
        228278, -- Hyperthermically Insulated Lava Dredger
    },
    -- Truthbearer
    ["229749"] = {
        231452, -- Blood of the Lightbringer
    },
    -- Truthbearer
    ["229806"] = {
        231452, -- Blood of the Lightbringer
    },
    -- Scroll: Create Signet of Beckoning
    ["229897"] = {
        20531, -- Scroll: Create Signet of Beckoning
        20532, -- Scroll: Create Signet of Beckoning
        20533, -- Scroll: Create Signet of Beckoning
        20535, -- Scroll: Create Signet of Beckoning
    },
    -- Tarnished Bronze Scale
    ["229906"] = {
        231509, -- Cassandra's Tome
    },
    -- Staff of Order
    ["229909"] = {
        230904, -- Scroll: SEENECS FO RIEF
    },
    -- Scythe of Chaos
    ["229910"] = {
        231722, -- Depleted Scythe of Chaos
    },
    -- Staff of Inferno
    ["229971"] = {
        230904, -- Scroll: SEENECS FO RIEF
    },
    -- Staff of Rime
    ["229972"] = {
        230904, -- Scroll: SEENECS FO RIEF
    },
    -- Thunderfury, Blessed Blade of the Windseeker
    ["230224"] = {
        19019, -- Thunderfury, Blessed Blade of the Windseeker
    },
    -- Arcane Infused Gem
    ["230237"] = {
        19336, -- Arcane Infused Gem
    },
    -- The Black Book
    ["230238"] = {
        19337, -- The Black Book
    },
    -- Gloves of Rapid Evolution
    ["230239"] = {
        19369, -- Gloves of Rapid Evolution
    },
    -- Mantle of the Blackwing Cabal
    ["230240"] = {
        19370, -- Mantle of the Blackwing Cabal
    },
    -- Spineshatter
    ["230241"] = {
        19335, -- Spineshatter
        232567, -- Spineshatter
    },
    -- The Untamed Blade
    ["230242"] = {
        19334, -- The Untamed Blade
        232566, -- The Untamed Blade
    },
    -- Mind Quickening Gem
    ["230243"] = {
        19339, -- Mind Quickening Gem
    },
    -- Pendant of the Fallen Dragon
    ["230245"] = {
        19371, -- Pendant of the Fallen Dragon
    },
    -- Helm of Endless Rage
    ["230246"] = {
        19372, -- Helm of Endless Rage
    },
    -- Dragonfang Blade
    ["230247"] = {
        19346, -- Dragonfang Blade
        232565, -- Dragonfang Blade
    },
    -- Red Dragonscale Protector
    ["230248"] = {
        19348, -- Red Dragonscale Protector
    },
    -- Lifegiving Gem
    ["230249"] = {
        19341, -- Lifegiving Gem
    },
    -- Venomous Totem
    ["230250"] = {
        19342, -- Venomous Totem
    },
    -- Black Brood Pauldrons
    ["230251"] = {
        19373, -- Black Brood Pauldrons
    },
    -- Bracers of Arcane Accuracy
    ["230252"] = {
        19374, -- Bracers of Arcane Accuracy
    },
    -- Heartstriker
    ["230253"] = {
        19350, -- Heartstriker
        232607, -- Heartstriker
    },
    -- Maladath, Runed Blade of the Black Flight
    ["230254"] = {
        19351, -- Maladath, Runed Blade of the Black Flight
        232564, -- Maladath, Runed Blade of the Black Flight
    },
    -- Taut Dragonhide Belt
    ["230255"] = {
        19396, -- Taut Dragonhide Belt
    },
    -- Drake Talon Pauldrons
    ["230256"] = {
        19394, -- Drake Talon Pauldrons
    },
    -- Ring of Blackrock
    ["230257"] = {
        19397, -- Ring of Blackrock
    },
    -- Rejuvenating Gem
    ["230269"] = {
        19395, -- Rejuvenating Gem
    },
    -- Shadow Wing Focus Staff
    ["230270"] = {
        19355, -- Shadow Wing Focus Staff
        232563, -- Shadow Wing Focus Staff
    },
    -- Drake Talon Cleaver
    ["230271"] = {
        19353, -- Drake Talon Cleaver
        232562, -- Drake Talon Cleaver
    },
    -- Scrolls of Blinding Light
    ["230272"] = {
        19343, -- Scrolls of Blinding Light
    },
    -- Natural Alignment Crystal
    ["230273"] = {
        19344, -- Natural Alignment Crystal
    },
    -- Black Ash Robe
    ["230274"] = {
        19399, -- Black Ash Robe
    },
    -- Firemaw's Clutch
    ["230275"] = {
        19400, -- Firemaw's Clutch
    },
    -- Claw of the Black Drake
    ["230276"] = {
        19365, -- Claw of the Black Drake
        232561, -- Claw of the Black Drake
    },
    -- Cloak of Firemaw
    ["230277"] = {
        19398, -- Cloak of Firemaw
    },
    -- Legguards of the Fallen Crusader
    ["230278"] = {
        19402, -- Legguards of the Fallen Crusader
    },
    -- Primalist's Linked Legguards
    ["230279"] = {
        19401, -- Primalist's Linked Legguards
    },
    -- Aegis of Preservation
    ["230280"] = {
        19345, -- Aegis of Preservation
    },
    -- Band of Forced Concentration
    ["230281"] = {
        19403, -- Band of Forced Concentration
    },
    -- Drake Fang Talisman
    ["230282"] = {
        19406, -- Drake Fang Talisman
    },
    -- Ebony Flame Gloves
    ["230723"] = {
        19407, -- Ebony Flame Gloves
    },
    -- Malfurion's Blessed Bulwark
    ["230725"] = {
        19405, -- Malfurion's Blessed Bulwark
    },
    -- Dragonbreath Hand Cannon
    ["230726"] = {
        19368, -- Dragonbreath Hand Cannon
        232608, -- Dragonbreath Hand Cannon
    },
    -- Shroud of Pure Thought
    ["230733"] = {
        19430, -- Shroud of Pure Thought
    },
    -- Circle of Applied Force
    ["230734"] = {
        19432, -- Circle of Applied Force
    },
    -- Emberweave Leggings
    ["230735"] = {
        19433, -- Emberweave Leggings
    },
    -- Styleen's Impeding Scarab
    ["230736"] = {
        19431, -- Styleen's Impeding Scarab
    },
    -- Dragon's Touch
    ["230737"] = {
        19367, -- Dragon's Touch
    },
    -- Herald of Woe
    ["230738"] = {
        19357, -- Herald of Woe
        232559, -- Herald of Woe
    },
    -- Angelista's Grasp
    ["230739"] = {
        19388, -- Angelista's Grasp
    },
    -- Taut Dragonhide Shoulderpads
    ["230740"] = {
        19389, -- Taut Dragonhide Shoulderpads
    },
    -- Chromatic Boots
    ["230741"] = {
        19387, -- Chromatic Boots
    },
    -- Taut Dragonhide Gloves
    ["230742"] = {
        19390, -- Taut Dragonhide Gloves
    },
    -- Shimmering Geta
    ["230743"] = {
        19391, -- Shimmering Geta
    },
    -- Elementium Threaded Cloak
    ["230744"] = {
        19386, -- Elementium Threaded Cloak
    },
    -- Girdle of the Fallen Crusader
    ["230745"] = {
        19392, -- Girdle of the Fallen Crusader
    },
    -- Empowered Leggings
    ["230746"] = {
        19385, -- Empowered Leggings
    },
    -- Chromatically Tempered Sword
    ["230747"] = {
        19352, -- Chromatically Tempered Sword
        232558, -- Chromatically Tempered Sword
    },
    -- Claw of Chromaggus
    ["230794"] = {
        19347, -- Claw of Chromaggus
        232557, -- Claw of Chromaggus
    },
    -- Primalist's Linked Waistguard
    ["230800"] = {
        19393, -- Primalist's Linked Waistguard
    },
    -- Ashjre'thul, Crossbow of Smiting
    ["230801"] = {
        19361, -- Ashjre'thul, Crossbow of Smiting
        232606, -- Ashjre'thul, Crossbow of Smiting
    },
    -- Elementium Reinforced Bulwark
    ["230802"] = {
        19349, -- Elementium Reinforced Bulwark
    },
    -- Cloak of the Brood Lord
    ["230804"] = {
        19378, -- Cloak of the Brood Lord
    },
    -- Boots of the Shadow Flame
    ["230805"] = {
        19381, -- Boots of the Shadow Flame
    },
    -- Therazane's Link
    ["230806"] = {
        19380, -- Therazane's Link
    },
    -- Archimtiros' Ring of Reckoning
    ["230808"] = {
        19376, -- Archimtiros' Ring of Reckoning
    },
    -- Neltharion's Tear
    ["230810"] = {
        19379, -- Neltharion's Tear
    },
    -- Pure Elementium Band
    ["230811"] = {
        19382, -- Pure Elementium Band
    },
    -- Mish'undare, Circlet of the Mind Flayer
    ["230812"] = {
        19375, -- Mish'undare, Circlet of the Mind Flayer
    },
    -- Staff of the Shadow Flame
    ["230813"] = {
        19356, -- Staff of the Shadow Flame
        232556, -- Staff of the Shadow Flame
    },
    -- Ashkandi, Greatsword of the Brotherhood
    ["230818"] = {
        19364, -- Ashkandi, Greatsword of the Brotherhood
        232550, -- Ashkandi, Greatsword of the Brotherhood
    },
    -- Crul'shorukh, Edge of Chaos
    ["230837"] = {
        19363, -- Crul'shorukh, Edge of Chaos
        232555, -- Crul'shorukh, Edge of Chaos
    },
    -- Lok'amir il Romathis
    ["230838"] = {
        19360, -- Lok'amir il Romathis
        232552, -- Lok'amir il Romathis
    },
    -- Master Dragonslayer's Ring
    ["230839"] = {
        19384, -- Master Dragonslayer's Ring
    },
    -- Master Dragonslayer's Medallion
    ["230840"] = {
        19383, -- Master Dragonslayer's Medallion
    },
    -- Master Dragonslayer's Orb
    ["230841"] = {
        19003, -- Head of Nefarian (Alliance)
        19366, -- Master Dragonslayer's Orb
    },
    -- Cloak of Draconic Might
    ["230842"] = {
        19436, -- Cloak of Draconic Might
    },
    -- Boots of Pure Thought
    ["230843"] = {
        19437, -- Boots of Pure Thought
    },
    -- Draconic Maul
    ["230844"] = {
        19358, -- Draconic Maul
        232551, -- Draconic Maul
    },
    -- Doom's Edge
    ["230845"] = {
        19362, -- Doom's Edge
        232577, -- Doom's Edge
    },
    -- Band of Dark Dominion
    ["230846"] = {
        19434, -- Band of Dark Dominion
    },
    -- Essence Gatherer
    ["230847"] = {
        19435, -- Essence Gatherer
    },
    -- Interlaced Shadow Jerkin
    ["230848"] = {
        19439, -- Interlaced Shadow Jerkin
    },
    -- Ringo's Blizzard Boots
    ["230849"] = {
        19438, -- Ringo's Blizzard Boots
    },
    -- Band of Servitude
    ["230854"] = {
        22721, -- Band of Servitude
    },
    -- Seal of the Gurubashi Berserker
    ["230855"] = {
        22722, -- Seal of the Gurubashi Berserker
    },
    -- Belt of Untapped Power
    ["230856"] = {
        22716, -- Belt of Untapped Power
    },
    -- Blooddrenched Mask
    ["230857"] = {
        22718, -- Blooddrenched Mask
    },
    -- Cloak of the Hakkari Worshipers
    ["230858"] = {
        22711, -- Cloak of the Hakkari Worshipers
    },
    -- Gloves of the Tormented
    ["230859"] = {
        22715, -- Gloves of the Tormented
    },
    -- Might of the Tribe
    ["230860"] = {
        22712, -- Might of the Tribe
    },
    -- Sacrificial Gauntlets
    ["230861"] = {
        22714, -- Sacrificial Gauntlets
    },
    -- Zulian Headdress
    ["230862"] = {
        22720, -- Zulian Headdress
    },
    -- Zulian Scepter of Rites
    ["230863"] = {
        22713, -- Zulian Scepter of Rites
        231865, -- Zulian Scepter of Rites
    },
    -- Runed Bloodstained Hauberk
    ["230864"] = {
        19904, -- Runed Bloodstained Hauberk
    },
    -- Fang of Venoxis
    ["230865"] = {
        19903, -- Fang of Venoxis
        231874, -- Fang of Venoxis
    },
    -- Blooddrenched Footpads
    ["230866"] = {
        19906, -- Blooddrenched Footpads
    },
    -- Zanzil's Band
    ["230867"] = {
        19905, -- Zanzil's Band
    },
    -- Zulian Stone Axe
    ["230868"] = {
        19900, -- Zulian Stone Axe
        231873, -- Zulian Stone Axe
    },
    -- Scroll: SEENECS FO RIEF
    ["230904"] = {
        229909, -- Staff of Order
        229971, -- Staff of Inferno
        229972, -- Staff of Rime
    },
    -- Jeklik's Crusher
    ["230911"] = {
        19918, -- Jeklik's Crusher
        231861, -- Jeklik's Crusher
    },
    -- Animist's Spaulders
    ["230912"] = {
        19928, -- Animist's Spaulders
    },
    -- Jeklik's Opaline Talisman
    ["230913"] = {
        19923, -- Jeklik's Opaline Talisman
    },
    -- Peacekeeper Boots
    ["230914"] = {
        20265, -- Peacekeeper Boots
    },
    -- Primalist's Band
    ["230915"] = {
        19920, -- Primalist's Band
    },
    -- Seafury Boots
    ["230916"] = {
        20262, -- Seafury Boots
    },
    -- Flowing Ritual Robes
    ["230917"] = {
        20032, -- Flowing Ritual Robes
    },
    -- Mar'li's Touch
    ["230918"] = {
        231866, -- Mar'li's Touch
    },
    -- Bloodstained Greaves
    ["230919"] = {
        19919, -- Bloodstained Greaves
    },
    -- Mar'li's Eye
    ["230920"] = {
        19930, -- Mar'li's Eye
    },
    -- Band of Jin
    ["230921"] = {
        19925, -- Band of Jin
    },
    -- Talisman of Protection
    ["230922"] = {
        19871, -- Talisman of Protection
    },
    -- Betrayer's Boots
    ["230923"] = {
        19897, -- Betrayer's Boots
    },
    -- Thekal's Grasp
    ["230925"] = {
        19896, -- Thekal's Grasp
        231875, -- Thekal's Grasp
    },
    -- Peacekeeper Leggings
    ["230926"] = {
        20266, -- Peacekeeper Leggings
    },
    -- Ritualistic Legguards
    ["230927"] = {
        19899, -- Ritualistic Legguards
    },
    -- Seafury Leggings
    ["230928"] = {
        20260, -- Seafury Leggings
    },
    -- Seal of Jin
    ["230929"] = {
        19898, -- Seal of Jin
    },
    -- Zulian Slicer
    ["230930"] = {
        19901, -- Zulian Slicer
        231876, -- Zulian Slicer
    },
    -- Arlokk's Grasp
    ["230934"] = {
        231851, -- Arlokk's Grasp
    },
    -- Will of Arlokk
    ["230939"] = {
        19909, -- Will of Arlokk
        231850, -- Will of Arlokk
    },
    -- Arlokk's Hoodoo Stick
    ["230941"] = {
        19922, -- Arlokk's Hoodoo Stick
    },
    -- Bloodsoaked Greaves
    ["230942"] = {
        19913, -- Bloodsoaked Greaves
    },
    -- Overlord's Onyx Band
    ["230943"] = {
        19912, -- Overlord's Onyx Band
    },
    -- Panther Hide Sack
    ["230944"] = {
        19914, -- Panther Hide Sack
    },
    -- Bloodlord's Defender
    ["230989"] = {
        19867, -- Bloodlord's Defender
        231867, -- Bloodlord's Defender
    },
    -- Halberd of Smiting
    ["230991"] = {
        19874, -- Halberd of Smiting
        231870, -- Halberd of Smiting
    },
    -- Warblade of the Hakkari
    ["230992"] = {
        231869, -- Warblade of the Hakkari
    },
    -- Mandokir's Sting
    ["230993"] = {
        231868, -- Mandokir's Sting
    },
    -- Animist's Leggings
    ["230994"] = {
        19877, -- Animist's Leggings
    },
    -- Blooddrenched Grips
    ["230995"] = {
        19869, -- Blooddrenched Grips
    },
    -- Bloodsoaked Pauldrons
    ["230996"] = {
        19878, -- Bloodsoaked Pauldrons
    },
    -- Bloodtinged Kilt
    ["230997"] = {
        19895, -- Bloodtinged Kilt
    },
    -- Hakkari Loa Cloak
    ["230998"] = {
        19870, -- Hakkari Loa Cloak
    },
    -- Overlord's Crimson Band
    ["230999"] = {
        19873, -- Overlord's Crimson Band
    },
    -- Primalist's Seal
    ["231000"] = {
        19863, -- Primalist's Seal
    },
    -- Zanzil's Seal
    ["231001"] = {
        19893, -- Zanzil's Seal
    },
    -- Jin'do's Hexxer
    ["231002"] = {
        19890, -- Jin'do's Hexxer
        231859, -- Jin'do's Hexxer
    },
    -- Jin'do's Evil Eye
    ["231003"] = {
        19885, -- Jin'do's Evil Eye
    },
    -- Jin'do's Judgement
    ["231004"] = {
        19884, -- Jin'do's Judgement
        231860, -- Jin'do's Judgement
    },
    -- Jin'do's Bag of Whammies
    ["231005"] = {
        19891, -- Jin'do's Bag of Whammies
    },
    -- Animist's Boots
    ["231006"] = {
        19892, -- Animist's Boots
    },
    -- Bloodstained Coif
    ["231007"] = {
        19875, -- Bloodstained Coif
    },
    -- Bloodstained Legplates
    ["231008"] = {
        19887, -- Bloodstained Legplates
    },
    -- Blooddrenched Leggings
    ["231009"] = {
        19889, -- Blooddrenched Leggings
    },
    -- Bloodsoaked Gauntlets
    ["231010"] = {
        19894, -- Bloodsoaked Gauntlets
    },
    -- Bloodtinged Gloves
    ["231011"] = {
        19929, -- Bloodtinged Gloves
    },
    -- Overlord's Embrace
    ["231012"] = {
        19888, -- Overlord's Embrace
    },
    -- The Hexxer's Cover
    ["231013"] = {
        19886, -- The Hexxer's Cover
    },
    -- Nat Pagle's Fish Terminator
    ["231016"] = {
        19944, -- Nat Pagle's Fish Terminator
        231848, -- Nat Pagle's Fish Terminator
    },
    -- Wristguards of Wrath
    ["231023"] = {
        231715, -- Primeval Bindings
    },
    -- Waistguard of Wrath
    ["231024"] = {
        231716, -- Primeval Belt
    },
    -- Pauldrons of Wrath
    ["231025"] = {
        16961, -- Pauldrons of Wrath
    },
    -- Legguards of Wrath
    ["231026"] = {
        231718, -- Primeval Leggings
    },
    -- Faceguard of Wrath
    ["231027"] = {
        231719, -- Primeval Helm
    },
    -- Handguards of Wrath
    ["231028"] = {
        231720, -- Primeval Gloves
    },
    -- Sabatons of Wrath
    ["231029"] = {
        16965, -- Sabatons of Wrath
    },
    -- Chestguard of Wrath
    ["231030"] = {
        231723, -- Primeval Chest
    },
    -- Bracers of Wrath
    ["231031"] = {
        231715, -- Primeval Bindings
    },
    -- Belt of Wrath
    ["231032"] = {
        231716, -- Primeval Belt
    },
    -- Shoulders of Wrath
    ["231033"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Legplates of Wrath
    ["231034"] = {
        16962, -- Legplates of Wrath
    },
    -- Helm of Wrath
    ["231035"] = {
        16963, -- Helm of Wrath
    },
    -- Gauntlets of Wrath
    ["231036"] = {
        16964, -- Gauntlets of Wrath
    },
    -- Greaves of Wrath
    ["231037"] = {
        231721, -- Primeval Boots
    },
    -- Breastplate of Wrath
    ["231038"] = {
        16966, -- Breastplate of Wrath
    },
    -- Bloodfang Spaulders
    ["231039"] = {
        16832, -- Bloodfang Spaulders
    },
    -- Bloodfang Chestpiece
    ["231040"] = {
        16905, -- Bloodfang Chestpiece
    },
    -- Bloodfang Boots
    ["231041"] = {
        16906, -- Bloodfang Boots
    },
    -- Bloodfang Gloves
    ["231042"] = {
        16907, -- Bloodfang Gloves
    },
    -- Bloodfang Hood
    ["231043"] = {
        16908, -- Bloodfang Hood
    },
    -- Bloodfang Pants
    ["231044"] = {
        16909, -- Bloodfang Pants
    },
    -- Bloodfang Belt
    ["231045"] = {
        16910, -- Bloodfang Belt
    },
    -- Bloodfang Bracers
    ["231046"] = {
        16911, -- Bloodfang Bracers
    },
    -- Bloodfang Shoulderpads
    ["231047"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Bloodfang Chestguard
    ["231048"] = {
        231723, -- Primeval Chest
    },
    -- Bloodfang Footpads
    ["231049"] = {
        231721, -- Primeval Boots
    },
    -- Bloodfang Handguards
    ["231050"] = {
        231720, -- Primeval Gloves
    },
    -- Bloodfang Cowl
    ["231051"] = {
        231719, -- Primeval Helm
    },
    -- Bloodfang Legguards
    ["231052"] = {
        231718, -- Primeval Leggings
    },
    -- Bloodfang Waistguard
    ["231053"] = {
        231716, -- Primeval Belt
    },
    -- Bloodfang Wristguards
    ["231054"] = {
        231715, -- Primeval Bindings
    },
    -- Dragonstalker's Bracers
    ["231055"] = {
        16935, -- Dragonstalker's Bracers
    },
    -- Dragonstalker's Belt
    ["231056"] = {
        16936, -- Dragonstalker's Belt
    },
    -- Dragonstalker's Spaulders
    ["231057"] = {
        16937, -- Dragonstalker's Spaulders
    },
    -- Dragonstalker's Legguards
    ["231058"] = {
        16938, -- Dragonstalker's Legguards
    },
    -- Dragonstalker's Helm
    ["231059"] = {
        16939, -- Dragonstalker's Helm
    },
    -- Dragonstalker's Gauntlets
    ["231060"] = {
        16940, -- Dragonstalker's Gauntlets
    },
    -- Dragonstalker's Greaves
    ["231061"] = {
        16941, -- Dragonstalker's Greaves
    },
    -- Dragonstalker's Breastplate
    ["231062"] = {
        16942, -- Dragonstalker's Breastplate
    },
    -- Dragonstalker's Vambraces
    ["231063"] = {
        231724, -- Ancient Bindings
    },
    -- Dragonstalker's Girdle
    ["231065"] = {
        231725, -- Ancient Belt
    },
    -- Dragonstalker's Pauldrons
    ["231066"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Dragonstalker's Pants
    ["231067"] = {
        231727, -- Ancient Leggings
    },
    -- Dragonstalker's Skullcap
    ["231068"] = {
        231728, -- Ancient Helm
    },
    -- Dragonstalker's Grips
    ["231069"] = {
        231729, -- Ancient Gloves
    },
    -- Dragonstalker's Sabatons
    ["231070"] = {
        231730, -- Ancient Boots
    },
    -- Dragonstalker's Armor
    ["231071"] = {
        231731, -- Ancient Chest
    },
    -- Nemesis Boots
    ["231072"] = {
        16927, -- Nemesis Boots
    },
    -- Nemesis Gloves
    ["231073"] = {
        16928, -- Nemesis Gloves
    },
    -- Nemesis Skullcap
    ["231074"] = {
        16929, -- Nemesis Skullcap
    },
    -- Nemesis Leggings
    ["231075"] = {
        16930, -- Nemesis Leggings
    },
    -- Nemesis Robes
    ["231076"] = {
        16931, -- Nemesis Robes
    },
    -- Nemesis Spaulders
    ["231077"] = {
        16932, -- Nemesis Spaulders
    },
    -- Nemesis Belt
    ["231078"] = {
        16933, -- Nemesis Belt
    },
    -- Nemesis Bracers
    ["231079"] = {
        16934, -- Nemesis Bracers
    },
    -- Nemesis Treads
    ["231090"] = {
        231713, -- Draconian Boots
    },
    -- Nemesis Handguards
    ["231091"] = {
        231712, -- Draconian Gloves
    },
    -- Nemesis Cowl
    ["231092"] = {
        231711, -- Draconian Hood
    },
    -- Nemesis Pants
    ["231093"] = {
        231710, -- Draconian Leggings
    },
    -- Nemesis Garb
    ["231095"] = {
        231714, -- Draconian Robe
    },
    -- Nemesis Shoulderpads
    ["231096"] = {
        231709, -- Draconian Shoulderpads
    },
    -- Nemesis Cord
    ["231097"] = {
        231708, -- Draconian Belt
    },
    -- Nemesis Wraps
    ["231098"] = {
        231707, -- Draconian Bindings
    },
    -- Netherwind Belt
    ["231100"] = {
        16818, -- Netherwind Belt
    },
    -- Netherwind Boots
    ["231101"] = {
        16912, -- Netherwind Boots
    },
    -- Netherwind Gloves
    ["231102"] = {
        16913, -- Netherwind Gloves
    },
    -- Netherwind Crown
    ["231103"] = {
        16914, -- Netherwind Crown
    },
    -- Netherwind Pants
    ["231104"] = {
        16915, -- Netherwind Pants
    },
    -- Netherwind Robes
    ["231105"] = {
        16916, -- Netherwind Robes
    },
    -- Netherwind Mantle
    ["231106"] = {
        16917, -- Netherwind Mantle
    },
    -- Netherwind Bindings
    ["231107"] = {
        16918, -- Netherwind Bindings
    },
    -- Netherwind Sash
    ["231108"] = {
        231708, -- Draconian Belt
    },
    -- Netherwind Slippers
    ["231109"] = {
        231713, -- Draconian Boots
    },
    -- Netherwind Mitts
    ["231110"] = {
        231712, -- Draconian Gloves
    },
    -- Netherwind Mask
    ["231111"] = {
        231711, -- Draconian Hood
    },
    -- Netherwind Leggings
    ["231112"] = {
        231710, -- Draconian Leggings
    },
    -- Netherwind Vestments
    ["231113"] = {
        231714, -- Draconian Robe
    },
    -- Netherwind Shoulders
    ["231114"] = {
        231709, -- Draconian Shoulderpads
    },
    -- Netherwind Wraps
    ["231115"] = {
        231707, -- Draconian Bindings
    },
    -- Boots of Transcendence
    ["231155"] = {
        16919, -- Boots of Transcendence
    },
    -- Handguards of Transcendence
    ["231156"] = {
        16920, -- Handguards of Transcendence
    },
    -- Halo of Transcendence
    ["231157"] = {
        16921, -- Halo of Transcendence
    },
    -- Leggings of Transcendence
    ["231158"] = {
        16922, -- Leggings of Transcendence
    },
    -- Robes of Transcendence
    ["231159"] = {
        16923, -- Robes of Transcendence
    },
    -- Pauldrons of Transcendence
    ["231160"] = {
        16924, -- Pauldrons of Transcendence
    },
    -- Belt of Transcendence
    ["231161"] = {
        16925, -- Belt of Transcendence
    },
    -- Bindings of Transcendence
    ["231162"] = {
        16926, -- Bindings of Transcendence
    },
    -- Treads of Transcendence
    ["231165"] = {
        231713, -- Draconian Boots
    },
    -- Gloves of Transcendence
    ["231166"] = {
        231712, -- Draconian Gloves
    },
    -- Crown of Transcendence
    ["231167"] = {
        231711, -- Draconian Hood
    },
    -- Pants of Transcendence
    ["231168"] = {
        231710, -- Draconian Leggings
    },
    -- Garb of Transcendence
    ["231169"] = {
        231714, -- Draconian Robe
    },
    -- Mantle of Transcendence
    ["231170"] = {
        231709, -- Draconian Shoulderpads
    },
    -- Cord of Transcendence
    ["231171"] = {
        231708, -- Draconian Belt
    },
    -- Bracers of Transcendence
    ["231172"] = {
        231707, -- Draconian Bindings
    },
    -- Judgement Bindings
    ["231174"] = {
        16951, -- Judgement Bindings
    },
    -- Judgement Belt
    ["231175"] = {
        16952, -- Judgement Belt
    },
    -- Judgement Spaulders
    ["231176"] = {
        16953, -- Judgement Spaulders
    },
    -- Judgement Legplates
    ["231177"] = {
        16954, -- Judgement Legplates
    },
    -- Judgement Crown
    ["231178"] = {
        16955, -- Judgement Crown
    },
    -- Judgement Gauntlets
    ["231179"] = {
        16956, -- Judgement Gauntlets
    },
    -- Judgement Sabatons
    ["231180"] = {
        16957, -- Judgement Sabatons
    },
    -- Judgement Breastplate
    ["231181"] = {
        16958, -- Judgement Breastplate
    },
    -- Judgement Vambraces
    ["231182"] = {
        231724, -- Ancient Bindings
    },
    -- Judgement Waistguard
    ["231183"] = {
        231725, -- Ancient Belt
    },
    -- Judgement Pauldrons
    ["231184"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Judgement Legguards
    ["231185"] = {
        231727, -- Ancient Leggings
    },
    -- Judgement Great Helm
    ["231186"] = {
        231728, -- Ancient Helm
    },
    -- Judgement Chestguard
    ["231187"] = {
        231731, -- Ancient Chest
    },
    -- Judgement Handguards
    ["231188"] = {
        231729, -- Ancient Gloves
    },
    -- Judgement Greaves
    ["231189"] = {
        231730, -- Ancient Boots
    },
    -- Judgement Bracers
    ["231190"] = {
        231724, -- Ancient Bindings
    },
    -- Judgement Girdle
    ["231191"] = {
        231725, -- Ancient Belt
    },
    -- Judgement Mantle
    ["231192"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Judgement Plate Skirt
    ["231193"] = {
        231727, -- Ancient Leggings
    },
    -- Judgement Helm
    ["231194"] = {
        231728, -- Ancient Helm
    },
    -- Judgement Gloves
    ["231195"] = {
        231729, -- Ancient Gloves
    },
    -- Judgement Treads
    ["231196"] = {
        231730, -- Ancient Boots
    },
    -- Judgement Cuirass
    ["231197"] = {
        231731, -- Ancient Chest
    },
    -- Gauntlets of Ten Storms
    ["231198"] = {
        16948, -- Gauntlets of Ten Storms
    },
    -- Bracers of Ten Storms
    ["231199"] = {
        16943, -- Bracers of Ten Storms
    },
    -- Belt of Ten Storms
    ["231200"] = {
        16944, -- Belt of Ten Storms
    },
    -- Epaulets of Ten Storms
    ["231201"] = {
        16945, -- Epaulets of Ten Storms
    },
    -- Legplates of Ten Storms
    ["231202"] = {
        16946, -- Legplates of Ten Storms
    },
    -- Helmet of Ten Storms
    ["231203"] = {
        16947, -- Helmet of Ten Storms
    },
    -- Greaves of Ten Storms
    ["231204"] = {
        231730, -- Ancient Boots
    },
    -- Breastplate of Ten Storms
    ["231205"] = {
        16950, -- Breastplate of Ten Storms
    },
    -- Handguards of Ten Storms
    ["231206"] = {
        231729, -- Ancient Gloves
    },
    -- Wristguards of Ten Storms
    ["231207"] = {
        231724, -- Ancient Bindings
    },
    -- Waistguard of Ten Storms
    ["231208"] = {
        231725, -- Ancient Belt
    },
    -- Pauldrons of Ten Storms
    ["231209"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Legguards of Ten Storms
    ["231210"] = {
        231727, -- Ancient Leggings
    },
    -- Faceguard of Ten Storms
    ["231211"] = {
        231728, -- Ancient Helm
    },
    -- Sabatons of Ten Storms
    ["231212"] = {
        231730, -- Ancient Boots
    },
    -- Chestguard of Ten Storms
    ["231213"] = {
        231731, -- Ancient Chest
    },
    -- Gloves of Ten Storms
    ["231214"] = {
        231729, -- Ancient Gloves
    },
    -- Bindings of Ten Storms
    ["231215"] = {
        231724, -- Ancient Bindings
    },
    -- Cord of Ten Storms
    ["231216"] = {
        231725, -- Ancient Belt
    },
    -- Mantle of Ten Storms
    ["231217"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Kilt of Ten Storms
    ["231218"] = {
        231727, -- Ancient Leggings
    },
    -- Headdress of Ten Storms
    ["231219"] = {
        231728, -- Ancient Helm
    },
    -- Boots of Ten Storms
    ["231220"] = {
        231730, -- Ancient Boots
    },
    -- Embrace of Ten Storms
    ["231221"] = {
        231731, -- Ancient Chest
    },
    -- Grips of Ten Storms
    ["231222"] = {
        231729, -- Ancient Gloves
    },
    -- Vambraces of Ten Storms
    ["231223"] = {
        231724, -- Ancient Bindings
    },
    -- Girdle of Ten Storms
    ["231224"] = {
        231725, -- Ancient Belt
    },
    -- Spaulders of Ten Storms
    ["231225"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Leggings of Ten Storms
    ["231226"] = {
        231727, -- Ancient Leggings
    },
    -- Crown of Ten Storms
    ["231227"] = {
        231728, -- Ancient Helm
    },
    -- Treads of Ten Storms
    ["231228"] = {
        231730, -- Ancient Boots
    },
    -- Armor of Ten Storms
    ["231229"] = {
        231731, -- Ancient Chest
    },
    -- Stormrage Chestguard
    ["231230"] = {
        16897, -- Stormrage Chestguard
    },
    -- Stormrage Boots
    ["231231"] = {
        16898, -- Stormrage Boots
    },
    -- Stormrage Handguards
    ["231232"] = {
        16899, -- Stormrage Handguards
    },
    -- Stormrage Cover
    ["231233"] = {
        16900, -- Stormrage Cover
    },
    -- Stormrage Legguards
    ["231234"] = {
        16901, -- Stormrage Legguards
    },
    -- Stormrage Pauldrons
    ["231235"] = {
        16902, -- Stormrage Pauldrons
    },
    -- Stormrage Belt
    ["231236"] = {
        16903, -- Stormrage Belt
    },
    -- Stormrage Bracers
    ["231237"] = {
        16904, -- Stormrage Bracers
    },
    -- Stormrage Armor
    ["231238"] = {
        231723, -- Primeval Chest
    },
    -- Stormrage Treads
    ["231239"] = {
        231721, -- Primeval Boots
    },
    -- Stormrage Gauntlets
    ["231240"] = {
        231720, -- Primeval Gloves
    },
    -- Stormrage Headdress
    ["231241"] = {
        231719, -- Primeval Helm
    },
    -- Stormrage Leggings
    ["231242"] = {
        231718, -- Primeval Leggings
    },
    -- Stormrage Spaulders
    ["231243"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Stormrage Waistguard
    ["231244"] = {
        231716, -- Primeval Belt
    },
    -- Stormrage Wristguards
    ["231245"] = {
        231715, -- Primeval Bindings
    },
    -- Stormrage Leathers
    ["231246"] = {
        231723, -- Primeval Chest
    },
    -- Stormrage Sandals
    ["231247"] = {
        231721, -- Primeval Boots
    },
    -- Stormrage Mitts
    ["231248"] = {
        231720, -- Primeval Gloves
    },
    -- Stormrage Antlers
    ["231249"] = {
        231719, -- Primeval Helm
    },
    -- Stormrage Kilt
    ["231250"] = {
        231718, -- Primeval Leggings
    },
    -- Stormrage Mantle
    ["231251"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Stormrage Cord
    ["231252"] = {
        231716, -- Primeval Belt
    },
    -- Stormrage Bindings
    ["231253"] = {
        231715, -- Primeval Bindings
    },
    -- Stormrage Vest
    ["231254"] = {
        231723, -- Primeval Chest
    },
    -- Stormrage Stompers
    ["231255"] = {
        231721, -- Primeval Boots
    },
    -- Stormrage Grips
    ["231256"] = {
        231720, -- Primeval Gloves
    },
    -- Stormrage Cowl
    ["231257"] = {
        231719, -- Primeval Helm
    },
    -- Stormrage Trousers
    ["231258"] = {
        231718, -- Primeval Leggings
    },
    -- Stormrage Shoulderpads
    ["231259"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Stormrage Sash
    ["231260"] = {
        231716, -- Primeval Belt
    },
    -- Stormrage Wraps
    ["231261"] = {
        231715, -- Primeval Bindings
    },
    -- Nat Pagle's Broken Reel
    ["231271"] = {
        19947, -- Nat Pagle's Broken Reel
    },
    -- Tigule's Harpoon
    ["231272"] = {
        19946, -- Tigule's Harpoon
        231849, -- Tigule's Harpoon
    },
    -- Gri'lek's Carver
    ["231273"] = {
        19962, -- Gri'lek's Carver
        231846, -- Gri'lek's Carver
    },
    -- Gri'lek's Grinder
    ["231274"] = {
        19961, -- Gri'lek's Grinder
        231847, -- Gri'lek's Grinder
    },
    -- Blazefury Retributer
    ["231275"] = {
        231862, -- Blazefury Retributer
    },
    -- Thoughtblighter
    ["231276"] = {
        231863, -- Thoughtblighter
    },
    -- Pitchfork of Madness
    ["231277"] = {
        19963, -- Pitchfork of Madness
        231864, -- Pitchfork of Madness
    },
    -- Hoodoo Hunting Bow
    ["231278"] = {
        19993, -- Hoodoo Hunting Bow
        231872, -- Hoodoo Hunting Bow
    },
    -- Wushoolay's Poker
    ["231279"] = {
        231871, -- Wushoolay's Poker
    },
    -- Wushoolay's Charm of Nature
    ["231280"] = {
        19955, -- Wushoolay's Charm of Nature
    },
    -- Wushoolay's Charm of Spirits
    ["231281"] = {
        19956, -- Wushoolay's Charm of Spirits
    },
    -- Hazza'rah's Charm of Chilled Magic
    ["231282"] = {
        231513, -- Gri'lek's Blood
    },
    -- Hazza'rah's Charm of Warding
    ["231283"] = {
        231513, -- Gri'lek's Blood
    },
    -- Hazza'rah's Charm of Destruction
    ["231284"] = {
        19957, -- Hazza'rah's Charm of Destruction
    },
    -- Gri'lek's Charm of Valor
    ["231285"] = {
        19952, -- Gri'lek's Charm of Valor
    },
    -- Gri'lek's Charm of Might
    ["231286"] = {
        19951, -- Gri'lek's Charm of Might
    },
    -- Renataki's Charm of Trickery
    ["231287"] = {
        19954, -- Renataki's Charm of Trickery
    },
    -- Renataki's Charm of Ravaging
    ["231288"] = {
        231513, -- Gri'lek's Blood
    },
    -- Aegis of the Blood God
    ["231289"] = {
        19862, -- Aegis of the Blood God
    },
    -- Ancient Hakkari Manslayer
    ["231293"] = {
        19852, -- Ancient Hakkari Manslayer
        231856, -- Ancient Hakkari Manslayer
    },
    -- Bloodcaller
    ["231296"] = {
        19864, -- Bloodcaller
        231858, -- Bloodcaller
    },
    -- Bloodsoaked Legplates
    ["231299"] = {
        19855, -- Bloodsoaked Legplates
    },
    -- Cloak of Consumption
    ["231300"] = {
        19857, -- Cloak of Consumption
    },
    -- Fang of the Faceless
    ["231301"] = {
        231855, -- Fang of the Faceless
    },
    -- Gurubashi Dwarf Destroyer
    ["231302"] = {
        19853, -- Gurubashi Dwarf Destroyer
        231852, -- Gurubashi Dwarf Destroyer
    },
    -- Peacekeeper Gauntlets
    ["231303"] = {
        20264, -- Peacekeeper Gauntlets
    },
    -- Seafury Gauntlets
    ["231305"] = {
        20257, -- Seafury Gauntlets
    },
    -- Soul Corrupter's Necklace
    ["231306"] = {
        19876, -- Soul Corrupter's Necklace
    },
    -- The Eye of Hakkar
    ["231307"] = {
        19856, -- The Eye of Hakkar
    },
    -- Touch of Chaos
    ["231308"] = {
        19861, -- Touch of Chaos
        231857, -- Touch of Chaos
    },
    -- Warblade of the Hakkari
    ["231309"] = {
        19865, -- Warblade of the Hakkari
        19866, -- Warblade of the Hakkari
        231853, -- Warblade of the Hakkari
    },
    -- Zin'rokh, Destroyer of Worlds
    ["231315"] = {
        231854, -- Zin'rokh, Destroyer of Worlds
    },
    -- Pristine Enchanted South Seas Kelp
    ["231316"] = {
        19613, -- Pristine Enchanted South Seas Kelp
    },
    -- Zandalar Haruspex's Tunic
    ["231317"] = {
        19838, -- Zandalar Haruspex's Tunic
    },
    -- Zandalar Haruspex's Belt
    ["231318"] = {
        19839, -- Zandalar Haruspex's Belt
    },
    -- Zandalar Haruspex's Bracers
    ["231319"] = {
        19840, -- Zandalar Haruspex's Bracers
    },
    -- Maelstrom's Wrath
    ["231320"] = {
        19621, -- Maelstrom's Wrath
    },
    -- Zandalar Predator's Mantle
    ["231321"] = {
        19831, -- Zandalar Predator's Mantle
    },
    -- Zandalar Predator's Belt
    ["231322"] = {
        19832, -- Zandalar Predator's Belt
    },
    -- Zandalar Predator's Bracers
    ["231323"] = {
        19833, -- Zandalar Predator's Bracers
    },
    -- Jewel of Kajaro
    ["231324"] = {
        19601, -- Jewel of Kajaro
    },
    -- Zandalar Illusionist's Mantle
    ["231325"] = {
        19845, -- Zandalar Illusionist's Mantle
    },
    -- Zandalar Illusionist's Wraps
    ["231326"] = {
        19846, -- Zandalar Illusionist's Wraps
    },
    -- Zandalar Illusionist's Robe
    ["231327"] = {
        20034, -- Zandalar Illusionist's Robe
    },
    -- Hero's Brand
    ["231328"] = {
        19588, -- Hero's Brand
    },
    -- Zandalar Freethinker's Breastplate
    ["231329"] = {
        19825, -- Zandalar Freethinker's Breastplate
    },
    -- Zandalar Freethinker's Belt
    ["231330"] = {
        19826, -- Zandalar Freethinker's Belt
    },
    -- Zandalar Freethinker's Armguards
    ["231331"] = {
        19827, -- Zandalar Freethinker's Armguards
    },
    -- The All-Seeing Eye of Zuldazar
    ["231332"] = {
        19594, -- The All-Seeing Eye of Zuldazar
    },
    -- Zandalar Confessor's Mantle
    ["231333"] = {
        19841, -- Zandalar Confessor's Mantle
    },
    -- Zandalar Confessor's Bindings
    ["231334"] = {
        19842, -- Zandalar Confessor's Bindings
    },
    -- Zandalar Confessor's Wraps
    ["231335"] = {
        19843, -- Zandalar Confessor's Wraps
    },
    -- Zandalarian Shadow Mastery Talisman
    ["231336"] = {
        19617, -- Zandalarian Shadow Mastery Talisman
    },
    -- Zandalar Madcap's Tunic
    ["231337"] = {
        19834, -- Zandalar Madcap's Tunic
    },
    -- Zandalar Madcap's Mantle
    ["231338"] = {
        19835, -- Zandalar Madcap's Mantle
    },
    -- Zandalar Madcap's Bracers
    ["231339"] = {
        19836, -- Zandalar Madcap's Bracers
    },
    -- Unmarred Vision of Voodress
    ["231340"] = {
        19609, -- Unmarred Vision of Voodress
    },
    -- Zandalar Augur's Hauberk
    ["231341"] = {
        19828, -- Zandalar Augur's Hauberk
    },
    -- Zandalar Augur's Belt
    ["231342"] = {
        19829, -- Zandalar Augur's Belt
    },
    -- Zandalar Augur's Bracers
    ["231343"] = {
        19830, -- Zandalar Augur's Bracers
    },
    -- Kezan's Unstoppable Taint
    ["231346"] = {
        19605, -- Kezan's Unstoppable Taint
    },
    -- Zandalar Demoniac's Wraps
    ["231347"] = {
        19848, -- Zandalar Demoniac's Wraps
    },
    -- Zandalar Demoniac's Robe
    ["231348"] = {
        20033, -- Zandalar Demoniac's Robe
    },
    -- Zandalar Demoniac's Mantle
    ["231349"] = {
        19849, -- Zandalar Demoniac's Mantle
    },
    -- Rage of Mugamba
    ["231350"] = {
        19577, -- Rage of Mugamba
    },
    -- Zandalar Vindicator's Armguards
    ["231351"] = {
        19824, -- Zandalar Vindicator's Armguards
    },
    -- Zandalar Vindicator's Belt
    ["231352"] = {
        19823, -- Zandalar Vindicator's Belt
    },
    -- Zandalar Vindicator's Breastplate
    ["231353"] = {
        19822, -- Zandalar Vindicator's Breastplate
    },
    -- Animist's Caress
    ["231354"] = {
        19790, -- Animist's Caress
    },
    -- Falcon's Call
    ["231359"] = {
        19785, -- Falcon's Call
    },
    -- Syncretist's Sigil
    ["231362"] = {
        19783, -- Syncretist's Sigil
    },
    -- Prophetic Aura
    ["231366"] = {
        19789, -- Prophetic Aura
    },
    -- Death's Embrace
    ["231368"] = {
        19784, -- Death's Embrace
    },
    -- Vodouisant's Charm
    ["231373"] = {
        231512, -- Primal Hakkari Idol
    },
    -- Hoodoo Hex
    ["231376"] = {
        19788, -- Hoodoo Hex
    },
    -- Shimmering Golden Disk
    ["231378"] = {
        224280, -- Suzerain, Defender of the Dragonflights
    },
    -- Presence of Might
    ["231379"] = {
        19782, -- Presence of Might
    },
    -- Vessel of Rebirth
    ["231382"] = {
        19016, -- Vessel of Rebirth
    },
    -- Presence of Sight
    ["231383"] = {
        19787, -- Presence of Sight
    },
    -- Blood of the Lightbringer
    ["231452"] = {
        229749, -- Truthbearer
        229806, -- Truthbearer
        231902, -- Ada's Amulet
    },
    -- Cassandra's Tome
    ["231509"] = {
        229906, -- Tarnished Bronze Scale
    },
    -- Primal Hakkari Idol
    ["231512"] = {
        19786, -- Vodouisant's Vigilant Embrace
        22637, -- Primal Hakkari Idol
        231354, -- Animist's Caress
        231359, -- Falcon's Call
        231362, -- Syncretist's Sigil
        231366, -- Prophetic Aura
        231368, -- Death's Embrace
        231373, -- Vodouisant's Charm
        231376, -- Hoodoo Hex
        231379, -- Presence of Might
        231383, -- Presence of Sight
    },
    -- Gri'lek's Blood
    ["231513"] = {
        19939, -- Gri'lek's Blood
        231280, -- Wushoolay's Charm of Nature
        231281, -- Wushoolay's Charm of Spirits
        231282, -- Hazza'rah's Charm of Chilled Magic
        231283, -- Hazza'rah's Charm of Warding
        231284, -- Hazza'rah's Charm of Destruction
        231285, -- Gri'lek's Charm of Valor
        231286, -- Gri'lek's Charm of Might
        231287, -- Renataki's Charm of Trickery
        231288, -- Renataki's Charm of Ravaging
    },
    -- Renataki's Tooth
    ["231514"] = {
        19940, -- Renataki's Tooth
    },
    -- Wushoolay's Mane
    ["231515"] = {
        19941, -- Wushoolay's Mane
    },
    -- Hazza'rah's Dream Thread
    ["231516"] = {
        19942, -- Hazza'rah's Dream Thread
    },
    -- Punctured Voodoo Doll
    ["231523"] = {
        19813, -- Punctured Voodoo Doll
        19814, -- Punctured Voodoo Doll
        19815, -- Punctured Voodoo Doll
        19816, -- Punctured Voodoo Doll
        19817, -- Punctured Voodoo Doll
        19818, -- Punctured Voodoo Doll
        19819, -- Punctured Voodoo Doll
        19820, -- Punctured Voodoo Doll
        19821, -- Punctured Voodoo Doll
    },
    -- Warlord's Plate Armor
    ["231530"] = {
        16541, -- Warlord's Plate Armor
    },
    -- General's Plate Boots
    ["231531"] = {
        16545, -- General's Plate Boots
    },
    -- General's Plate Gauntlets
    ["231532"] = {
        16548, -- General's Plate Gauntlets
    },
    -- General's Plate Leggings
    ["231533"] = {
        16543, -- General's Plate Leggings
    },
    -- Warlord's Plate Shoulders
    ["231534"] = {
        16544, -- Warlord's Plate Shoulders
    },
    -- Warlord's Plate Headpiece
    ["231535"] = {
        16542, -- Warlord's Plate Headpiece
    },
    -- Field Marshal's Plate Armor
    ["231536"] = {
        16477, -- Field Marshal's Plate Armor
    },
    -- Field Marshal's Plate Shoulderguards
    ["231537"] = {
        16480, -- Field Marshal's Plate Shoulderguards
    },
    -- Field Marshal's Plate Helm
    ["231538"] = {
        16478, -- Field Marshal's Plate Helm
    },
    -- Marshal's Plate Boots
    ["231539"] = {
        16483, -- Marshal's Plate Boots
    },
    -- Marshal's Plate Legguards
    ["231540"] = {
        16479, -- Marshal's Plate Legguards
    },
    -- Marshal's Plate Gauntlets
    ["231541"] = {
        16484, -- Marshal's Plate Gauntlets
    },
    -- Field Marshal's Leather Chestpiece
    ["231543"] = {
        16453, -- Field Marshal's Leather Chestpiece
    },
    -- Marshal's Leather Handgrips
    ["231544"] = {
        16454, -- Marshal's Leather Handgrips
    },
    -- Field Marshal's Leather Mask
    ["231545"] = {
        16455, -- Field Marshal's Leather Mask
    },
    -- Marshal's Leather Footguards
    ["231546"] = {
        16446, -- Marshal's Leather Footguards
    },
    -- Field Marshal's Leather Epaulets
    ["231547"] = {
        16457, -- Field Marshal's Leather Epaulets
    },
    -- Marshal's Leather Leggings
    ["231548"] = {
        16456, -- Marshal's Leather Leggings
    },
    -- Warlord's Leather Breastplate
    ["231549"] = {
        16563, -- Warlord's Leather Breastplate
    },
    -- Warlord's Leather Spaulders
    ["231551"] = {
        16562, -- Warlord's Leather Spaulders
    },
    -- General's Leather Treads
    ["231552"] = {
        16558, -- General's Leather Treads
    },
    -- Warlord's Leather Helm
    ["231553"] = {
        16561, -- Warlord's Leather Helm
    },
    -- General's Leather Legguards
    ["231554"] = {
        16564, -- General's Leather Legguards
    },
    -- General's Leather Mitts
    ["231555"] = {
        16560, -- General's Leather Mitts
    },
    -- Marshal's Chain Grips
    ["231560"] = {
        16463, -- Marshal's Chain Grips
    },
    -- Warlord's Chain Shoulders
    ["231572"] = {
        16568, -- Warlord's Chain Shoulders
    },
    -- General's Chain Legguards
    ["231574"] = {
        16567, -- General's Chain Legguards
    },
    -- Marshal's Chain Legguards
    ["231577"] = {
        16467, -- Marshal's Chain Legguards
    },
    -- Field Marshal's Chain Helm
    ["231580"] = {
        16465, -- Field Marshal's Chain Helm
    },
    -- Field Marshal's Dreadweave Robe
    ["231582"] = {
        17581, -- Field Marshal's Dreadweave Robe
    },
    -- Field Marshal's Dreadweave Shoulders
    ["231583"] = {
        17580, -- Field Marshal's Dreadweave Shoulders
    },
    -- Field Marshal's Coronal
    ["231584"] = {
        17578, -- Field Marshal's Coronal
    },
    -- Marshal's Dreadweave Boots
    ["231585"] = {
        17583, -- Marshal's Dreadweave Boots
    },
    -- Marshal's Dreadweave Gloves
    ["231586"] = {
        17584, -- Marshal's Dreadweave Gloves
    },
    -- Marshal's Dreadweave Leggings
    ["231587"] = {
        17579, -- Marshal's Dreadweave Leggings
    },
    -- General's Dreadweave Pants
    ["231588"] = {
        17593, -- General's Dreadweave Pants
    },
    -- General's Dreadweave Gloves
    ["231589"] = {
        17588, -- General's Dreadweave Gloves
    },
    -- Warlord's Dreadweave Hood
    ["231590"] = {
        17591, -- Warlord's Dreadweave Hood
    },
    -- Warlord's Dreadweave Robe
    ["231591"] = {
        17592, -- Warlord's Dreadweave Robe
    },
    -- Warlord's Dreadweave Mantle
    ["231592"] = {
        17590, -- Warlord's Dreadweave Mantle
    },
    -- General's Dreadweave Boots
    ["231593"] = {
        17586, -- General's Dreadweave Boots
    },
    -- Warlord's Silk Amice
    ["231594"] = {
        16536, -- Warlord's Silk Amice
    },
    -- General's Silk Trousers
    ["231595"] = {
        16534, -- General's Silk Trousers
    },
    -- Warlord's Silk Raiment
    ["231596"] = {
        16535, -- Warlord's Silk Raiment
    },
    -- General's Silk Boots
    ["231597"] = {
        16539, -- General's Silk Boots
    },
    -- Warlord's Silk Cowl
    ["231601"] = {
        16533, -- Warlord's Silk Cowl
    },
    -- Field Marshal's Silk Spaulders
    ["231602"] = {
        16444, -- Field Marshal's Silk Spaulders
    },
    -- Field Marshal's Silk Vestments
    ["231603"] = {
        16443, -- Field Marshal's Silk Vestments
    },
    -- Field Marshal's Coronet
    ["231604"] = {
        16441, -- Field Marshal's Coronet
    },
    -- Marshal's Silk Leggings
    ["231605"] = {
        16442, -- Marshal's Silk Leggings
    },
    -- Marshal's Silk Footwraps
    ["231606"] = {
        16437, -- Marshal's Silk Footwraps
    },
    -- Marshal's Silk Gloves
    ["231607"] = {
        16440, -- Marshal's Silk Gloves
    },
    -- Warlord's Satin Robes
    ["231612"] = {
        17624, -- Warlord's Satin Robes
    },
    -- General's Satin Leggings
    ["231614"] = {
        17625, -- General's Satin Leggings
    },
    -- Field Marshal's Satin Mantle
    ["231628"] = {
        17604, -- Field Marshal's Satin Mantle
    },
    -- Warlord's Satin Mantle
    ["231631"] = {
        17622, -- Warlord's Satin Mantle
    },
    -- Field Marshal's Lamellar Chestplate
    ["231641"] = {
        16473, -- Field Marshal's Lamellar Chestplate
    },
    -- Marshal's Lamellar Gloves
    ["231643"] = {
        16471, -- Marshal's Lamellar Gloves
    },
    -- Field Marshal's Lamellar Pauldrons
    ["231645"] = {
        16476, -- Field Marshal's Lamellar Pauldrons
    },
    -- Warlord's Mail Spaulders
    ["231659"] = {
        16580, -- Warlord's Mail Spaulders
    },
    -- General's Mail Gauntlets
    ["231660"] = {
        16574, -- General's Mail Gauntlets
    },
    -- Warlord's Mail Helm
    ["231663"] = {
        16578, -- Warlord's Mail Helm
    },
    -- General's Mail Leggings
    ["231664"] = {
        16579, -- General's Mail Leggings
    },
    -- General's Mail Boots
    ["231667"] = {
        16573, -- General's Mail Boots
    },
    -- General's Dragonhide Gloves
    ["231677"] = {
        16555, -- General's Dragonhide Gloves
    },
    -- General's Dragonhide Boots
    ["231682"] = {
        16554, -- General's Dragonhide Boots
    },
    -- General's Dragonhide Leggings
    ["231685"] = {
        16552, -- General's Dragonhide Leggings
    },
    -- Marshal's Dragonhide Boots
    ["231698"] = {
        16459, -- Marshal's Dragonhide Boots
    },
    -- Field Marshal's Dragonhide Spaulders
    ["231699"] = {
        16449, -- Field Marshal's Dragonhide Spaulders
    },
    -- Marshal's Dragonhide Legguards
    ["231703"] = {
        16450, -- Marshal's Dragonhide Legguards
    },
    -- Marshal's Dragonhide Gauntlets
    ["231706"] = {
        16448, -- Marshal's Dragonhide Gauntlets
    },
    -- Draconian Bindings
    ["231707"] = {
        231079, -- Nemesis Bracers
        231098, -- Nemesis Wraps
        231107, -- Netherwind Bindings
        231115, -- Netherwind Wraps
        231162, -- Bindings of Transcendence
        231172, -- Bracers of Transcendence
        232127, -- Netherwind Bindings
        232135, -- Netherwind Wraps
        232167, -- Bracers of Transcendence
        232175, -- Bindings of Transcendence
        232231, -- Nemesis Bracers
        232239, -- Nemesis Wraps
    },
    -- Draconian Belt
    ["231708"] = {
        231078, -- Nemesis Belt
        231097, -- Nemesis Cord
        231100, -- Netherwind Belt
        231108, -- Netherwind Sash
        231161, -- Belt of Transcendence
        231171, -- Cord of Transcendence
        232128, -- Netherwind Belt
        232136, -- Netherwind Sash
        232168, -- Cord of Transcendence
        232176, -- Belt of Transcendence
        232232, -- Nemesis Belt
        232240, -- Nemesis Cord
    },
    -- Draconian Shoulderpads
    ["231709"] = {
        231077, -- Nemesis Spaulders
        231096, -- Nemesis Shoulderpads
        231106, -- Netherwind Mantle
        231114, -- Netherwind Shoulders
        231160, -- Pauldrons of Transcendence
        231170, -- Mantle of Transcendence
        232129, -- Netherwind Mantle
        232137, -- Netherwind Shoulders
        232169, -- Mantle of Transcendence
        232177, -- Pauldrons of Transcendence
        232233, -- Nemesis Spaulders
        232241, -- Nemesis Shoulderpads
    },
    -- Draconian Leggings
    ["231710"] = {
        231075, -- Nemesis Leggings
        231093, -- Nemesis Pants
        231104, -- Netherwind Pants
        231112, -- Netherwind Leggings
        231158, -- Leggings of Transcendence
        231168, -- Pants of Transcendence
        232130, -- Netherwind Pants
        232138, -- Netherwind Leggings
        232170, -- Pants of Transcendence
        232178, -- Leggings of Transcendence
        232234, -- Nemesis Leggings
        232242, -- Nemesis Pants
    },
    -- Draconian Hood
    ["231711"] = {
        231074, -- Nemesis Skullcap
        231092, -- Nemesis Cowl
        231103, -- Netherwind Crown
        231111, -- Netherwind Mask
        231157, -- Halo of Transcendence
        231167, -- Crown of Transcendence
        232131, -- Netherwind Crown
        232139, -- Netherwind Mask
        232171, -- Crown of Transcendence
        232179, -- Halo of Transcendence
        232235, -- Nemesis Skullcap
        232243, -- Nemesis Cowl
    },
    -- Draconian Gloves
    ["231712"] = {
        231073, -- Nemesis Gloves
        231091, -- Nemesis Handguards
        231102, -- Netherwind Gloves
        231110, -- Netherwind Mitts
        231156, -- Handguards of Transcendence
        231166, -- Gloves of Transcendence
        232132, -- Netherwind Gloves
        232140, -- Netherwind Mitts
        232172, -- Gloves of Transcendence
        232180, -- Handguards of Transcendence
        232236, -- Nemesis Gloves
        232244, -- Nemesis Handguards
    },
    -- Draconian Boots
    ["231713"] = {
        231072, -- Nemesis Boots
        231090, -- Nemesis Treads
        231101, -- Netherwind Boots
        231109, -- Netherwind Slippers
        231155, -- Boots of Transcendence
        231165, -- Treads of Transcendence
        232133, -- Netherwind Boots
        232141, -- Netherwind Slippers
        232173, -- Treads of Transcendence
        232181, -- Boots of Transcendence
        232237, -- Nemesis Boots
        232245, -- Nemesis Treads
    },
    -- Draconian Robe
    ["231714"] = {
        231076, -- Nemesis Robes
        231095, -- Nemesis Garb
        231105, -- Netherwind Robes
        231113, -- Netherwind Vestments
        231159, -- Robes of Transcendence
        231169, -- Garb of Transcendence
        232134, -- Netherwind Robes
        232142, -- Netherwind Vestments
        232174, -- Garb of Transcendence
        232182, -- Robes of Transcendence
        232238, -- Nemesis Robes
        232246, -- Nemesis Garb
    },
    -- Primeval Bindings
    ["231715"] = {
        16959, -- Bracelets of Wrath
        231023, -- Wristguards of Wrath
        231031, -- Bracers of Wrath
        231046, -- Bloodfang Bracers
        231054, -- Bloodfang Wristguards
        231237, -- Stormrage Bracers
        231245, -- Stormrage Wristguards
        231253, -- Stormrage Bindings
        231261, -- Stormrage Wraps
        232079, -- Stormrage Bindings
        232087, -- Stormrage Bracers
        232095, -- Stormrage Wraps
        232103, -- Stormrage Wristguards
        232183, -- Bloodfang Bracers
        232191, -- Bloodfang Wristguards
        232247, -- Bracers of Wrath
        232255, -- Wristguards of Wrath
    },
    -- Primeval Belt
    ["231716"] = {
        16960, -- Waistband of Wrath
        231024, -- Waistguard of Wrath
        231032, -- Belt of Wrath
        231045, -- Bloodfang Belt
        231053, -- Bloodfang Waistguard
        231236, -- Stormrage Belt
        231244, -- Stormrage Waistguard
        231252, -- Stormrage Cord
        231260, -- Stormrage Sash
        232080, -- Stormrage Cord
        232088, -- Stormrage Belt
        232096, -- Stormrage Sash
        232104, -- Stormrage Waistguard
        232184, -- Bloodfang Belt
        232192, -- Bloodfang Waistguard
        232248, -- Belt of Wrath
        232256, -- Waistguard of Wrath
    },
    -- Primeval Shoulderpads
    ["231717"] = {
        231025, -- Pauldrons of Wrath
        231033, -- Shoulders of Wrath
        231039, -- Bloodfang Spaulders
        231047, -- Bloodfang Shoulderpads
        231235, -- Stormrage Pauldrons
        231243, -- Stormrage Spaulders
        231251, -- Stormrage Mantle
        231259, -- Stormrage Shoulderpads
        232081, -- Stormrage Mantle
        232089, -- Stormrage Pauldrons
        232097, -- Stormrage Shoulderpads
        232105, -- Stormrage Spaulders
        232185, -- Bloodfang Spaulders
        232193, -- Bloodfang Shoulderpads
        232249, -- Shoulders of Wrath
        232257, -- Pauldrons of Wrath
    },
    -- Primeval Leggings
    ["231718"] = {
        231026, -- Legguards of Wrath
        231034, -- Legplates of Wrath
        231044, -- Bloodfang Pants
        231052, -- Bloodfang Legguards
        231234, -- Stormrage Legguards
        231242, -- Stormrage Leggings
        231250, -- Stormrage Kilt
        231258, -- Stormrage Trousers
        232082, -- Stormrage Kilt
        232090, -- Stormrage Legguards
        232098, -- Stormrage Trousers
        232106, -- Stormrage Leggings
        232186, -- Bloodfang Pants
        232194, -- Bloodfang Legguards
        232250, -- Legplates of Wrath
        232258, -- Legguards of Wrath
    },
    -- Primeval Helm
    ["231719"] = {
        231027, -- Faceguard of Wrath
        231035, -- Helm of Wrath
        231043, -- Bloodfang Hood
        231051, -- Bloodfang Cowl
        231233, -- Stormrage Cover
        231241, -- Stormrage Headdress
        231249, -- Stormrage Antlers
        231257, -- Stormrage Cowl
        232083, -- Stormrage Antlers
        232091, -- Stormrage Cover
        232099, -- Stormrage Cowl
        232107, -- Stormrage Headdress
        232187, -- Bloodfang Hood
        232195, -- Bloodfang Cowl
        232251, -- Helm of Wrath
        232259, -- Faceguard of Wrath
    },
    -- Primeval Gloves
    ["231720"] = {
        231028, -- Handguards of Wrath
        231036, -- Gauntlets of Wrath
        231042, -- Bloodfang Gloves
        231050, -- Bloodfang Handguards
        231232, -- Stormrage Handguards
        231240, -- Stormrage Gauntlets
        231248, -- Stormrage Mitts
        231256, -- Stormrage Grips
        232084, -- Stormrage Mitts
        232092, -- Stormrage Handguards
        232100, -- Stormrage Grips
        232108, -- Stormrage Gauntlets
        232188, -- Bloodfang Gloves
        232196, -- Bloodfang Handguards
        232252, -- Gauntlets of Wrath
        232260, -- Handguards of Wrath
    },
    -- Primeval Boots
    ["231721"] = {
        231029, -- Sabatons of Wrath
        231037, -- Greaves of Wrath
        231041, -- Bloodfang Boots
        231049, -- Bloodfang Footpads
        231231, -- Stormrage Boots
        231239, -- Stormrage Treads
        231247, -- Stormrage Sandals
        231255, -- Stormrage Stompers
        232085, -- Stormrage Sandals
        232093, -- Stormrage Boots
        232101, -- Stormrage Stompers
        232109, -- Stormrage Treads
        232189, -- Bloodfang Boots
        232197, -- Bloodfang Footpads
        232253, -- Greaves of Wrath
        232261, -- Sabatons of Wrath
    },
    -- Depleted Scythe of Chaos
    ["231722"] = {
        229910, -- Scythe of Chaos
    },
    -- Primeval Chest
    ["231723"] = {
        231030, -- Chestguard of Wrath
        231038, -- Breastplate of Wrath
        231040, -- Bloodfang Chestpiece
        231048, -- Bloodfang Chestguard
        231230, -- Stormrage Chestguard
        231238, -- Stormrage Armor
        231246, -- Stormrage Leathers
        231254, -- Stormrage Vest
        232086, -- Stormrage Leathers
        232094, -- Stormrage Chestguard
        232102, -- Stormrage Vest
        232110, -- Stormrage Armor
        232190, -- Bloodfang Chestpiece
        232198, -- Bloodfang Chestguard
        232254, -- Breastplate of Wrath
        232262, -- Chestguard of Wrath
    },
    -- Ancient Bindings
    ["231724"] = {
        231055, -- Dragonstalker's Bracers
        231063, -- Dragonstalker's Vambraces
        231174, -- Judgement Bindings
        231182, -- Judgement Vambraces
        231190, -- Judgement Bracers
        231199, -- Bracers of Ten Storms
        231207, -- Wristguards of Ten Storms
        231215, -- Bindings of Ten Storms
        231223, -- Vambraces of Ten Storms
        232111, -- Dragonstalker's Vambraces
        232119, -- Dragonstalker's Bracers
        232143, -- Judgement Bindings
        232151, -- Judgement Bracers
        232159, -- Judgement Vambraces
        232199, -- Bindings of Ten Storms
        232207, -- Bracers of Ten Storms
        232215, -- Vambraces of Ten Storms
        232223, -- Wristguards of Ten Storms
    },
    -- Ancient Belt
    ["231725"] = {
        15606, -- Ancient Belt
        231056, -- Dragonstalker's Belt
        231065, -- Dragonstalker's Girdle
        231175, -- Judgement Belt
        231183, -- Judgement Waistguard
        231191, -- Judgement Girdle
        231200, -- Belt of Ten Storms
        231208, -- Waistguard of Ten Storms
        231216, -- Cord of Ten Storms
        231224, -- Girdle of Ten Storms
        232112, -- Dragonstalker's Girdle
        232120, -- Dragonstalker's Belt
        232144, -- Judgement Belt
        232152, -- Judgement Girdle
        232160, -- Judgement Waistguard
        232200, -- Cord of Ten Storms
        232208, -- Belt of Ten Storms
        232216, -- Girdle of Ten Storms
        232224, -- Waistguard of Ten Storms
    },
    -- Ancient Shoulderpads
    ["231726"] = {
        231057, -- Dragonstalker's Spaulders
        231066, -- Dragonstalker's Pauldrons
        231176, -- Judgement Spaulders
        231184, -- Judgement Pauldrons
        231192, -- Judgement Mantle
        231201, -- Epaulets of Ten Storms
        231209, -- Pauldrons of Ten Storms
        231217, -- Mantle of Ten Storms
        231225, -- Spaulders of Ten Storms
        232113, -- Dragonstalker's Pauldrons
        232121, -- Dragonstalker's Spaulders
        232145, -- Judgement Spaulders
        232153, -- Judgement Mantle
        232161, -- Judgement Pauldrons
        232201, -- Mantle of Ten Storms
        232209, -- Epaulets of Ten Storms
        232217, -- Spaulders of Ten Storms
        232225, -- Pauldrons of Ten Storms
    },
    -- Ancient Leggings
    ["231727"] = {
        231058, -- Dragonstalker's Legguards
        231067, -- Dragonstalker's Pants
        231177, -- Judgement Legplates
        231185, -- Judgement Legguards
        231193, -- Judgement Plate Skirt
        231202, -- Legplates of Ten Storms
        231210, -- Legguards of Ten Storms
        231218, -- Kilt of Ten Storms
        231226, -- Leggings of Ten Storms
        232114, -- Dragonstalker's Pants
        232122, -- Dragonstalker's Legguards
        232146, -- Judgement Legplates
        232154, -- Judgement Plate Skirt
        232162, -- Judgement Legguards
        232202, -- Kilt of Ten Storms
        232210, -- Legplates of Ten Storms
        232218, -- Leggings of Ten Storms
        232226, -- Legguards of Ten Storms
    },
    -- Ancient Helm
    ["231728"] = {
        231059, -- Dragonstalker's Helm
        231068, -- Dragonstalker's Skullcap
        231178, -- Judgement Crown
        231186, -- Judgement Great Helm
        231194, -- Judgement Helm
        231203, -- Helmet of Ten Storms
        231211, -- Faceguard of Ten Storms
        231219, -- Headdress of Ten Storms
        231227, -- Crown of Ten Storms
        232115, -- Dragonstalker's Skullcap
        232123, -- Dragonstalker's Helm
        232147, -- Judgement Crown
        232155, -- Judgement Helm
        232163, -- Judgement Great Helm
        232203, -- Headdress of Ten Storms
        232211, -- Helmet of Ten Storms
        232219, -- Crown of Ten Storms
        232227, -- Faceguard of Ten Storms
    },
    -- Ancient Gloves
    ["231729"] = {
        231060, -- Dragonstalker's Gauntlets
        231069, -- Dragonstalker's Grips
        231179, -- Judgement Gauntlets
        231188, -- Judgement Handguards
        231195, -- Judgement Gloves
        231198, -- Gauntlets of Ten Storms
        231206, -- Handguards of Ten Storms
        231214, -- Gloves of Ten Storms
        231222, -- Grips of Ten Storms
        232116, -- Dragonstalker's Grips
        232124, -- Dragonstalker's Gauntlets
        232148, -- Judgement Gauntlets
        232156, -- Judgement Gloves
        232164, -- Judgement Handguards
        232204, -- Gloves of Ten Storms
        232212, -- Gauntlets of Ten Storms
        232220, -- Grips of Ten Storms
        232228, -- Handguards of Ten Storms
    },
    -- Ancient Boots
    ["231730"] = {
        231061, -- Dragonstalker's Greaves
        231070, -- Dragonstalker's Sabatons
        231180, -- Judgement Sabatons
        231189, -- Judgement Greaves
        231196, -- Judgement Treads
        231204, -- Greaves of Ten Storms
        231212, -- Sabatons of Ten Storms
        231220, -- Boots of Ten Storms
        231228, -- Treads of Ten Storms
        232117, -- Dragonstalker's Sabatons
        232125, -- Dragonstalker's Greaves
        232149, -- Judgement Sabatons
        232157, -- Judgement Treads
        232165, -- Judgement Greaves
        232205, -- Boots of Ten Storms
        232213, -- Greaves of Ten Storms
        232221, -- Treads of Ten Storms
        232229, -- Sabatons of Ten Storms
    },
    -- Ancient Chest
    ["231731"] = {
        231062, -- Dragonstalker's Breastplate
        231071, -- Dragonstalker's Armor
        231181, -- Judgement Breastplate
        231187, -- Judgement Chestguard
        231197, -- Judgement Cuirass
        231205, -- Breastplate of Ten Storms
        231213, -- Chestguard of Ten Storms
        231221, -- Embrace of Ten Storms
        231229, -- Armor of Ten Storms
        232118, -- Dragonstalker's Armor
        232126, -- Dragonstalker's Breastplate
        232150, -- Judgement Breastplate
        232158, -- Judgement Cuirass
        232166, -- Judgement Chestguard
        232206, -- Embrace of Ten Storms
        232214, -- Breastplate of Ten Storms
        232222, -- Armor of Ten Storms
        232230, -- Chestguard of Ten Storms
    },
    -- Kestrel
    ["231754"] = {
        231882, -- Suppression Device Receipt
    },
    -- Peregrine
    ["231755"] = {
        231882, -- Suppression Device Receipt
    },
    -- Prestor's Talisman of Connivery
    ["231803"] = {
        19377, -- Prestor's Talisman of Connivery
    },
    -- Chromatic Heart
    ["231814"] = {
        224281, -- Gla'sir
        224282, -- Rae'lar
    },
    -- Gri'lek's Carver
    ["231846"] = {
        231273, -- Gri'lek's Carver
    },
    -- Gri'lek's Grinder
    ["231847"] = {
        231274, -- Gri'lek's Grinder
    },
    -- Nat Pagle's Fish Terminator
    ["231848"] = {
        231016, -- Nat Pagle's Fish Terminator
    },
    -- Tigule's Harpoon
    ["231849"] = {
        231272, -- Tigule's Harpoon
    },
    -- Will of Arlokk
    ["231850"] = {
        230939, -- Will of Arlokk
    },
    -- Arlokk's Grasp
    ["231851"] = {
        19910, -- Arlokk's Grasp
        230934, -- Arlokk's Grasp
    },
    -- Gurubashi Dwarf Destroyer
    ["231852"] = {
        231302, -- Gurubashi Dwarf Destroyer
    },
    -- Warblade of the Hakkari
    ["231853"] = {
        231309, -- Warblade of the Hakkari
    },
    -- Zin'rokh, Destroyer of Worlds
    ["231854"] = {
        19854, -- Zin'rokh, Destroyer of Worlds
        231315, -- Zin'rokh, Destroyer of Worlds
    },
    -- Fang of the Faceless
    ["231855"] = {
        19859, -- Fang of the Faceless
        231301, -- Fang of the Faceless
    },
    -- Ancient Hakkari Manslayer
    ["231856"] = {
        231293, -- Ancient Hakkari Manslayer
    },
    -- Touch of Chaos
    ["231857"] = {
        231308, -- Touch of Chaos
    },
    -- Bloodcaller
    ["231858"] = {
        231296, -- Bloodcaller
    },
    -- Jin'do's Hexxer
    ["231859"] = {
        231002, -- Jin'do's Hexxer
    },
    -- Jin'do's Judgement
    ["231860"] = {
        231004, -- Jin'do's Judgement
    },
    -- Jeklik's Crusher
    ["231861"] = {
        230911, -- Jeklik's Crusher
    },
    -- Blazefury Retributer
    ["231862"] = {
        231275, -- Blazefury Retributer
    },
    -- Thoughtblighter
    ["231863"] = {
        19967, -- Thoughtblighter
        231276, -- Thoughtblighter
    },
    -- Pitchfork of Madness
    ["231864"] = {
        231277, -- Pitchfork of Madness
    },
    -- Zulian Scepter of Rites
    ["231865"] = {
        230863, -- Zulian Scepter of Rites
    },
    -- Mar'li's Touch
    ["231866"] = {
        19927, -- Mar'li's Touch
        230918, -- Mar'li's Touch
    },
    -- Bloodlord's Defender
    ["231867"] = {
        230989, -- Bloodlord's Defender
    },
    -- Mandokir's Sting
    ["231868"] = {
        20038, -- Mandokir's Sting
        230993, -- Mandokir's Sting
    },
    -- Warblade of the Hakkari
    ["231869"] = {
        230992, -- Warblade of the Hakkari
    },
    -- Halberd of Smiting
    ["231870"] = {
        230991, -- Halberd of Smiting
    },
    -- Wushoolay's Poker
    ["231871"] = {
        19965, -- Wushoolay's Poker
        231279, -- Wushoolay's Poker
    },
    -- Hoodoo Hunting Bow
    ["231872"] = {
        231278, -- Hoodoo Hunting Bow
    },
    -- Zulian Stone Axe
    ["231873"] = {
        230868, -- Zulian Stone Axe
    },
    -- Fang of Venoxis
    ["231874"] = {
        230865, -- Fang of Venoxis
    },
    -- Thekal's Grasp
    ["231875"] = {
        230925, -- Thekal's Grasp
    },
    -- Zulian Slicer
    ["231876"] = {
        230930, -- Zulian Slicer
    },
    -- Suppression Device Receipt
    ["231882"] = {
        231754, -- Kestrel
        231755, -- Peregrine
    },
    -- Terrestris
    ["231890"] = {
        231995, -- Hardened Elementium Slag
    },
    -- Ada's Amulet
    ["231902"] = {
        231452, -- Blood of the Lightbringer
    },
    -- Hardened Elementium Slag
    ["231995"] = {
        231890, -- Terrestris
    },
    -- Dormant Wind Kissed Blade
    ["232018"] = {
        19018, -- Dormant Wind Kissed Blade
        230224, -- Thunderfury, Blessed Blade of the Windseeker
    },
    -- Stormrage Bindings
    ["232079"] = {
        231715, -- Primeval Bindings
    },
    -- Stormrage Cord
    ["232080"] = {
        231716, -- Primeval Belt
    },
    -- Stormrage Mantle
    ["232081"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Stormrage Kilt
    ["232082"] = {
        231718, -- Primeval Leggings
    },
    -- Stormrage Antlers
    ["232083"] = {
        231719, -- Primeval Helm
    },
    -- Stormrage Mitts
    ["232084"] = {
        231720, -- Primeval Gloves
    },
    -- Stormrage Sandals
    ["232085"] = {
        231721, -- Primeval Boots
    },
    -- Stormrage Leathers
    ["232086"] = {
        231723, -- Primeval Chest
    },
    -- Stormrage Bracers
    ["232087"] = {
        231715, -- Primeval Bindings
    },
    -- Stormrage Belt
    ["232088"] = {
        231716, -- Primeval Belt
    },
    -- Stormrage Pauldrons
    ["232089"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Stormrage Legguards
    ["232090"] = {
        231718, -- Primeval Leggings
    },
    -- Stormrage Cover
    ["232091"] = {
        231719, -- Primeval Helm
    },
    -- Stormrage Handguards
    ["232092"] = {
        231720, -- Primeval Gloves
    },
    -- Stormrage Boots
    ["232093"] = {
        231721, -- Primeval Boots
    },
    -- Stormrage Chestguard
    ["232094"] = {
        231723, -- Primeval Chest
    },
    -- Stormrage Wraps
    ["232095"] = {
        231715, -- Primeval Bindings
    },
    -- Stormrage Sash
    ["232096"] = {
        231716, -- Primeval Belt
    },
    -- Stormrage Shoulderpads
    ["232097"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Stormrage Trousers
    ["232098"] = {
        231718, -- Primeval Leggings
    },
    -- Stormrage Cowl
    ["232099"] = {
        231719, -- Primeval Helm
    },
    -- Stormrage Grips
    ["232100"] = {
        231720, -- Primeval Gloves
    },
    -- Stormrage Stompers
    ["232101"] = {
        231721, -- Primeval Boots
    },
    -- Stormrage Vest
    ["232102"] = {
        231723, -- Primeval Chest
    },
    -- Stormrage Wristguards
    ["232103"] = {
        231715, -- Primeval Bindings
    },
    -- Stormrage Waistguard
    ["232104"] = {
        231716, -- Primeval Belt
    },
    -- Stormrage Spaulders
    ["232105"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Stormrage Leggings
    ["232106"] = {
        231718, -- Primeval Leggings
    },
    -- Stormrage Headdress
    ["232107"] = {
        231719, -- Primeval Helm
    },
    -- Stormrage Gauntlets
    ["232108"] = {
        231720, -- Primeval Gloves
    },
    -- Stormrage Treads
    ["232109"] = {
        231721, -- Primeval Boots
    },
    -- Stormrage Armor
    ["232110"] = {
        231723, -- Primeval Chest
    },
    -- Dragonstalker's Vambraces
    ["232111"] = {
        231724, -- Ancient Bindings
    },
    -- Dragonstalker's Girdle
    ["232112"] = {
        231725, -- Ancient Belt
    },
    -- Dragonstalker's Pauldrons
    ["232113"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Dragonstalker's Pants
    ["232114"] = {
        231727, -- Ancient Leggings
    },
    -- Dragonstalker's Skullcap
    ["232115"] = {
        231728, -- Ancient Helm
    },
    -- Dragonstalker's Grips
    ["232116"] = {
        231729, -- Ancient Gloves
    },
    -- Dragonstalker's Sabatons
    ["232117"] = {
        231730, -- Ancient Boots
    },
    -- Dragonstalker's Armor
    ["232118"] = {
        231731, -- Ancient Chest
    },
    -- Dragonstalker's Bracers
    ["232119"] = {
        231724, -- Ancient Bindings
    },
    -- Dragonstalker's Belt
    ["232120"] = {
        231725, -- Ancient Belt
    },
    -- Dragonstalker's Spaulders
    ["232121"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Dragonstalker's Legguards
    ["232122"] = {
        231727, -- Ancient Leggings
    },
    -- Dragonstalker's Helm
    ["232123"] = {
        231728, -- Ancient Helm
    },
    -- Dragonstalker's Gauntlets
    ["232124"] = {
        231729, -- Ancient Gloves
    },
    -- Dragonstalker's Greaves
    ["232125"] = {
        231730, -- Ancient Boots
    },
    -- Dragonstalker's Breastplate
    ["232126"] = {
        231731, -- Ancient Chest
    },
    -- Netherwind Bindings
    ["232127"] = {
        231707, -- Draconian Bindings
    },
    -- Netherwind Belt
    ["232128"] = {
        231708, -- Draconian Belt
    },
    -- Netherwind Mantle
    ["232129"] = {
        231709, -- Draconian Shoulderpads
    },
    -- Netherwind Pants
    ["232130"] = {
        231710, -- Draconian Leggings
    },
    -- Netherwind Crown
    ["232131"] = {
        231711, -- Draconian Hood
    },
    -- Netherwind Gloves
    ["232132"] = {
        231712, -- Draconian Gloves
    },
    -- Netherwind Boots
    ["232133"] = {
        231713, -- Draconian Boots
    },
    -- Netherwind Robes
    ["232134"] = {
        231714, -- Draconian Robe
    },
    -- Netherwind Wraps
    ["232135"] = {
        231707, -- Draconian Bindings
    },
    -- Netherwind Sash
    ["232136"] = {
        231708, -- Draconian Belt
    },
    -- Netherwind Shoulders
    ["232137"] = {
        231709, -- Draconian Shoulderpads
    },
    -- Netherwind Leggings
    ["232138"] = {
        231710, -- Draconian Leggings
    },
    -- Netherwind Mask
    ["232139"] = {
        231711, -- Draconian Hood
    },
    -- Netherwind Mitts
    ["232140"] = {
        231712, -- Draconian Gloves
    },
    -- Netherwind Slippers
    ["232141"] = {
        231713, -- Draconian Boots
    },
    -- Netherwind Vestments
    ["232142"] = {
        231714, -- Draconian Robe
    },
    -- Judgement Bindings
    ["232143"] = {
        231724, -- Ancient Bindings
    },
    -- Judgement Belt
    ["232144"] = {
        231725, -- Ancient Belt
    },
    -- Judgement Spaulders
    ["232145"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Judgement Legplates
    ["232146"] = {
        231727, -- Ancient Leggings
    },
    -- Judgement Crown
    ["232147"] = {
        231728, -- Ancient Helm
    },
    -- Judgement Gauntlets
    ["232148"] = {
        231729, -- Ancient Gloves
    },
    -- Judgement Sabatons
    ["232149"] = {
        231730, -- Ancient Boots
    },
    -- Judgement Breastplate
    ["232150"] = {
        231731, -- Ancient Chest
    },
    -- Judgement Bracers
    ["232151"] = {
        231724, -- Ancient Bindings
    },
    -- Judgement Girdle
    ["232152"] = {
        231725, -- Ancient Belt
    },
    -- Judgement Mantle
    ["232153"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Judgement Plate Skirt
    ["232154"] = {
        231727, -- Ancient Leggings
    },
    -- Judgement Helm
    ["232155"] = {
        231728, -- Ancient Helm
    },
    -- Judgement Gloves
    ["232156"] = {
        231729, -- Ancient Gloves
    },
    -- Judgement Treads
    ["232157"] = {
        231730, -- Ancient Boots
    },
    -- Judgement Cuirass
    ["232158"] = {
        231731, -- Ancient Chest
    },
    -- Judgement Vambraces
    ["232159"] = {
        231724, -- Ancient Bindings
    },
    -- Judgement Waistguard
    ["232160"] = {
        231725, -- Ancient Belt
    },
    -- Judgement Pauldrons
    ["232161"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Judgement Legguards
    ["232162"] = {
        231727, -- Ancient Leggings
    },
    -- Judgement Great Helm
    ["232163"] = {
        231728, -- Ancient Helm
    },
    -- Judgement Handguards
    ["232164"] = {
        231729, -- Ancient Gloves
    },
    -- Judgement Greaves
    ["232165"] = {
        231730, -- Ancient Boots
    },
    -- Judgement Chestguard
    ["232166"] = {
        231731, -- Ancient Chest
    },
    -- Bracers of Transcendence
    ["232167"] = {
        231707, -- Draconian Bindings
    },
    -- Cord of Transcendence
    ["232168"] = {
        231708, -- Draconian Belt
    },
    -- Mantle of Transcendence
    ["232169"] = {
        231709, -- Draconian Shoulderpads
    },
    -- Pants of Transcendence
    ["232170"] = {
        231710, -- Draconian Leggings
    },
    -- Crown of Transcendence
    ["232171"] = {
        231711, -- Draconian Hood
    },
    -- Gloves of Transcendence
    ["232172"] = {
        231712, -- Draconian Gloves
    },
    -- Treads of Transcendence
    ["232173"] = {
        231713, -- Draconian Boots
    },
    -- Garb of Transcendence
    ["232174"] = {
        231714, -- Draconian Robe
    },
    -- Bindings of Transcendence
    ["232175"] = {
        231707, -- Draconian Bindings
    },
    -- Belt of Transcendence
    ["232176"] = {
        231708, -- Draconian Belt
    },
    -- Pauldrons of Transcendence
    ["232177"] = {
        231709, -- Draconian Shoulderpads
    },
    -- Leggings of Transcendence
    ["232178"] = {
        231710, -- Draconian Leggings
    },
    -- Halo of Transcendence
    ["232179"] = {
        231711, -- Draconian Hood
    },
    -- Handguards of Transcendence
    ["232180"] = {
        231712, -- Draconian Gloves
    },
    -- Boots of Transcendence
    ["232181"] = {
        231713, -- Draconian Boots
    },
    -- Robes of Transcendence
    ["232182"] = {
        231714, -- Draconian Robe
    },
    -- Bloodfang Bracers
    ["232183"] = {
        231715, -- Primeval Bindings
    },
    -- Bloodfang Belt
    ["232184"] = {
        231716, -- Primeval Belt
    },
    -- Bloodfang Spaulders
    ["232185"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Bloodfang Pants
    ["232186"] = {
        231718, -- Primeval Leggings
    },
    -- Bloodfang Hood
    ["232187"] = {
        231719, -- Primeval Helm
    },
    -- Bloodfang Gloves
    ["232188"] = {
        231720, -- Primeval Gloves
    },
    -- Bloodfang Boots
    ["232189"] = {
        231721, -- Primeval Boots
    },
    -- Bloodfang Chestpiece
    ["232190"] = {
        231723, -- Primeval Chest
    },
    -- Bloodfang Wristguards
    ["232191"] = {
        231715, -- Primeval Bindings
    },
    -- Bloodfang Waistguard
    ["232192"] = {
        231716, -- Primeval Belt
    },
    -- Bloodfang Shoulderpads
    ["232193"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Bloodfang Legguards
    ["232194"] = {
        231718, -- Primeval Leggings
    },
    -- Bloodfang Cowl
    ["232195"] = {
        231719, -- Primeval Helm
    },
    -- Bloodfang Handguards
    ["232196"] = {
        231720, -- Primeval Gloves
    },
    -- Bloodfang Footpads
    ["232197"] = {
        231721, -- Primeval Boots
    },
    -- Bloodfang Chestguard
    ["232198"] = {
        231723, -- Primeval Chest
    },
    -- Bindings of Ten Storms
    ["232199"] = {
        231724, -- Ancient Bindings
    },
    -- Cord of Ten Storms
    ["232200"] = {
        231725, -- Ancient Belt
    },
    -- Mantle of Ten Storms
    ["232201"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Kilt of Ten Storms
    ["232202"] = {
        231727, -- Ancient Leggings
    },
    -- Headdress of Ten Storms
    ["232203"] = {
        231728, -- Ancient Helm
    },
    -- Gloves of Ten Storms
    ["232204"] = {
        231729, -- Ancient Gloves
    },
    -- Boots of Ten Storms
    ["232205"] = {
        231730, -- Ancient Boots
    },
    -- Embrace of Ten Storms
    ["232206"] = {
        231731, -- Ancient Chest
    },
    -- Bracers of Ten Storms
    ["232207"] = {
        231724, -- Ancient Bindings
    },
    -- Belt of Ten Storms
    ["232208"] = {
        231725, -- Ancient Belt
    },
    -- Epaulets of Ten Storms
    ["232209"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Legplates of Ten Storms
    ["232210"] = {
        231727, -- Ancient Leggings
    },
    -- Helmet of Ten Storms
    ["232211"] = {
        231728, -- Ancient Helm
    },
    -- Gauntlets of Ten Storms
    ["232212"] = {
        231729, -- Ancient Gloves
    },
    -- Greaves of Ten Storms
    ["232213"] = {
        16949, -- Greaves of Ten Storms
    },
    -- Breastplate of Ten Storms
    ["232214"] = {
        231731, -- Ancient Chest
    },
    -- Vambraces of Ten Storms
    ["232215"] = {
        231724, -- Ancient Bindings
    },
    -- Girdle of Ten Storms
    ["232216"] = {
        231725, -- Ancient Belt
    },
    -- Spaulders of Ten Storms
    ["232217"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Leggings of Ten Storms
    ["232218"] = {
        231727, -- Ancient Leggings
    },
    -- Crown of Ten Storms
    ["232219"] = {
        231728, -- Ancient Helm
    },
    -- Grips of Ten Storms
    ["232220"] = {
        231729, -- Ancient Gloves
    },
    -- Treads of Ten Storms
    ["232221"] = {
        231730, -- Ancient Boots
    },
    -- Armor of Ten Storms
    ["232222"] = {
        231731, -- Ancient Chest
    },
    -- Wristguards of Ten Storms
    ["232223"] = {
        231724, -- Ancient Bindings
    },
    -- Waistguard of Ten Storms
    ["232224"] = {
        231725, -- Ancient Belt
    },
    -- Pauldrons of Ten Storms
    ["232225"] = {
        231726, -- Ancient Shoulderpads
    },
    -- Legguards of Ten Storms
    ["232226"] = {
        231727, -- Ancient Leggings
    },
    -- Faceguard of Ten Storms
    ["232227"] = {
        231728, -- Ancient Helm
    },
    -- Handguards of Ten Storms
    ["232228"] = {
        231729, -- Ancient Gloves
    },
    -- Sabatons of Ten Storms
    ["232229"] = {
        231730, -- Ancient Boots
    },
    -- Chestguard of Ten Storms
    ["232230"] = {
        231731, -- Ancient Chest
    },
    -- Nemesis Bracers
    ["232231"] = {
        231707, -- Draconian Bindings
    },
    -- Nemesis Belt
    ["232232"] = {
        231708, -- Draconian Belt
    },
    -- Nemesis Spaulders
    ["232233"] = {
        231709, -- Draconian Shoulderpads
    },
    -- Nemesis Leggings
    ["232234"] = {
        231710, -- Draconian Leggings
    },
    -- Nemesis Skullcap
    ["232235"] = {
        231711, -- Draconian Hood
    },
    -- Nemesis Gloves
    ["232236"] = {
        231712, -- Draconian Gloves
    },
    -- Nemesis Boots
    ["232237"] = {
        231713, -- Draconian Boots
    },
    -- Nemesis Robes
    ["232238"] = {
        231714, -- Draconian Robe
    },
    -- Nemesis Wraps
    ["232239"] = {
        231707, -- Draconian Bindings
    },
    -- Nemesis Cord
    ["232240"] = {
        231708, -- Draconian Belt
    },
    -- Nemesis Shoulderpads
    ["232241"] = {
        231709, -- Draconian Shoulderpads
    },
    -- Nemesis Pants
    ["232242"] = {
        231710, -- Draconian Leggings
    },
    -- Nemesis Cowl
    ["232243"] = {
        231711, -- Draconian Hood
    },
    -- Nemesis Handguards
    ["232244"] = {
        231712, -- Draconian Gloves
    },
    -- Nemesis Treads
    ["232245"] = {
        231713, -- Draconian Boots
    },
    -- Nemesis Garb
    ["232246"] = {
        231714, -- Draconian Robe
    },
    -- Bracers of Wrath
    ["232247"] = {
        231715, -- Primeval Bindings
    },
    -- Belt of Wrath
    ["232248"] = {
        231716, -- Primeval Belt
    },
    -- Shoulders of Wrath
    ["232249"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Legplates of Wrath
    ["232250"] = {
        231718, -- Primeval Leggings
    },
    -- Helm of Wrath
    ["232251"] = {
        231719, -- Primeval Helm
    },
    -- Gauntlets of Wrath
    ["232252"] = {
        231720, -- Primeval Gloves
    },
    -- Greaves of Wrath
    ["232253"] = {
        231721, -- Primeval Boots
    },
    -- Breastplate of Wrath
    ["232254"] = {
        231723, -- Primeval Chest
    },
    -- Wristguards of Wrath
    ["232255"] = {
        231715, -- Primeval Bindings
    },
    -- Waistguard of Wrath
    ["232256"] = {
        231716, -- Primeval Belt
    },
    -- Pauldrons of Wrath
    ["232257"] = {
        231717, -- Primeval Shoulderpads
    },
    -- Legguards of Wrath
    ["232258"] = {
        231718, -- Primeval Leggings
    },
    -- Faceguard of Wrath
    ["232259"] = {
        231719, -- Primeval Helm
    },
    -- Handguards of Wrath
    ["232260"] = {
        231720, -- Primeval Gloves
    },
    -- Sabatons of Wrath
    ["232261"] = {
        231721, -- Primeval Boots
    },
    -- Chestguard of Wrath
    ["232262"] = {
        231723, -- Primeval Chest
    },
    -- Zulian Defender
    ["232299"] = {
        19915, -- Zulian Defender
    },
    -- Renataki's Soul Conduit
    ["232309"] = {
        19964, -- Renataki's Soul Conduit
        232310, -- Renataki's Soul Conduit
    },
    -- Renataki's Soul Conduit
    ["232310"] = {
        232309, -- Renataki's Soul Conduit
    },
    -- Zulian Tigerhide Cloak
    ["232311"] = {
        19907, -- Zulian Tigerhide Cloak
    },
    -- Draconic Avenger
    ["232357"] = {
        19354, -- Draconic Avenger
        232576, -- Draconic Avenger
    },
    -- Logistics Task Briefing VI
    ["232549"] = {
        21260, -- Logistics Task Briefing VI
        21261, -- Logistics Task Briefing VI
    },
    -- Ashkandi, Greatsword of the Brotherhood
    ["232550"] = {
        230818, -- Ashkandi, Greatsword of the Brotherhood
    },
    -- Draconic Maul
    ["232551"] = {
        230844, -- Draconic Maul
    },
    -- Lok'amir il Romathis
    ["232552"] = {
        230838, -- Lok'amir il Romathis
    },
    -- Crul'shorukh, Edge of Chaos
    ["232555"] = {
        230837, -- Crul'shorukh, Edge of Chaos
    },
    -- Staff of the Shadow Flame
    ["232556"] = {
        230813, -- Staff of the Shadow Flame
    },
    -- Claw of Chromaggus
    ["232557"] = {
        230794, -- Claw of Chromaggus
    },
    -- Chromatically Tempered Sword
    ["232558"] = {
        230747, -- Chromatically Tempered Sword
    },
    -- Herald of Woe
    ["232559"] = {
        230738, -- Herald of Woe
    },
    -- Claw of the Black Drake
    ["232561"] = {
        230276, -- Claw of the Black Drake
    },
    -- Drake Talon Cleaver
    ["232562"] = {
        230271, -- Drake Talon Cleaver
    },
    -- Shadow Wing Focus Staff
    ["232563"] = {
        230270, -- Shadow Wing Focus Staff
    },
    -- Maladath, Runed Blade of the Black Flight
    ["232564"] = {
        230254, -- Maladath, Runed Blade of the Black Flight
    },
    -- Dragonfang Blade
    ["232565"] = {
        230247, -- Dragonfang Blade
    },
    -- The Untamed Blade
    ["232566"] = {
        230242, -- The Untamed Blade
    },
    -- Spineshatter
    ["232567"] = {
        230241, -- Spineshatter
    },
    -- Draconic Avenger
    ["232576"] = {
        232357, -- Draconic Avenger
    },
    -- Doom's Edge
    ["232577"] = {
        230845, -- Doom's Edge
    },
    -- Ashjre'thul, Crossbow of Smiting
    ["232606"] = {
        230801, -- Ashjre'thul, Crossbow of Smiting
    },
    -- Heartstriker
    ["232607"] = {
        230253, -- Heartstriker
    },
    -- Dragonbreath Hand Cannon
    ["232608"] = {
        230726, -- Dragonbreath Hand Cannon
    },
    -- Husk of the Old God
    ["233362"] = {
        20933, -- Husk of the Old God
        233386, -- Stormcaller's Hauberk
        233397, -- Avenger's Breastplate
        233415, -- Genesis Vest
        233688, -- Avenger's Cuirass
        233693, -- Avenger's Chestguard
        233694, -- Stormcaller's Chestguard
        233699, -- Stormcaller's Breastplate
        233704, -- Stormcaller's Embrace
        233711, -- Genesis Armor
        233715, -- Genesis Leathers
        233720, -- Genesis Chestguard
    },
    -- Carapace of the Old God
    ["233363"] = {
        20929, -- Carapace of the Old God
        233373, -- Conqueror's Breastplate
        233402, -- Enigma Robes
        233411, -- Striker's Hauberk
        233651, -- Conqueror's Cuirass
        233664, -- Striker's Ringmail
        233678, -- Enigma Garb
    },
    -- Skin of the Old God
    ["233364"] = {
        233380, -- Doomcaller's Robes
        233389, -- Deathdealer's Vest
        233395, -- Vestments of the Oracle
        233659, -- Deathdealer's Chestguard
        233670, -- Doomcaller's Garb
        233680, -- Robes of the Oracle
    },
    -- Intact Viscera
    ["233365"] = {
        20931, -- Skin of the Great Sandworm
        233382, -- Stormcaller's Leggings
        233385, -- Stormcaller's Diadem
        233398, -- Avenger's Crown
        233400, -- Avenger's Legguards
        233412, -- Genesis Helm
        233416, -- Genesis Trousers
        233685, -- Avenger's Plate Pants
        233687, -- Avenger's Helm
        233690, -- Avenger's Tassets
        233692, -- Avenger's Great Helm
        233695, -- Stormcaller's Faceguard
        233698, -- Stormcaller's Legplates
        233700, -- Stormcaller's Crown
        233703, -- Stormcaller's Chain Leggings
        233705, -- Stormcaller's Headdress
        233708, -- Stormcaller's Mail Leggings
        233709, -- Genesis Cowl
        233710, -- Genesis Leather Pants
        233714, -- Genesis Leggings
        233718, -- Genesis Headdress
        233719, -- Genesis Breeches
        233723, -- Genesis Mask
    },
    -- Intact Peritoneum
    ["233367"] = {
        20927, -- Ouro's Intact Hide
        233374, -- Conqueror's Legguards
        233375, -- Conqueror's Crown
        233404, -- Enigma Circlet
        233406, -- Enigma Leggings
        233408, -- Striker's Leggings
        233410, -- Striker's Diadem
        233653, -- Conqueror's Helm
        233654, -- Conqueror's Tassets
        233666, -- Striker's Visor
        233667, -- Striker's Chain Legplates
        233674, -- Enigma Pant
        233676, -- Enigma Diadem
    },
    -- Intact Entrails
    ["233368"] = {
        233378, -- Doomcaller's Trousers
        233381, -- Doomcaller's Circlet
        233388, -- Deathdealer's Helm
        233390, -- Deathdealer's Leggings
        233393, -- Tiara of the Oracle
        233396, -- Trousers of the Oracle
        233661, -- Deathdealer's Visor
        233662, -- Deathdealer's Pants
        233669, -- Doomcaller's Headguard
        233672, -- Doomcaller's Pants
        233679, -- Leggings of the Oracle
        233682, -- Crown of the Oracle
    },
    -- Qiraji Bindings of Dominance
    ["233369"] = {
        20932, -- Qiraji Bindings of Dominance
        233383, -- Stormcaller's Pauldrons
        233384, -- Stormcaller's Footguards
        233399, -- Avenger's Greaves
        233401, -- Avenger's Pauldrons
        233413, -- Genesis Shoulderpads
        233414, -- Genesis Boots
        233684, -- Avenger's Mantle
        233686, -- Avenger's Treads
        233689, -- Avenger's Spaulders
        233691, -- Avenger's Sabatons
        233696, -- Stormcaller's Sabatons
        233697, -- Stormcaller's Spaulders
        233701, -- Stormcaller's Treads
        233702, -- Stormcaller's Mantle
        233706, -- Stormcaller's Greaves
        233707, -- Stormcaller's Epaulets
        233712, -- Genesis Stompers
        233713, -- Genesis Spaulders
        233716, -- Genesis Treads
        233717, -- Genesis Mantle
        233721, -- Genesis Greaves
        233722, -- Genesis Pauldrons
    },
    -- Qiraji Bindings of Command
    ["233370"] = {
        20928, -- Qiraji Bindings of Command
        233372, -- Conqueror's Greaves
        233376, -- Conqueror's Spaulders
        233403, -- Enigma Shoulderpads
        233405, -- Enigma Boots
        233407, -- Striker's Footguards
        233409, -- Striker's Pauldrons
        233652, -- Conqueror's Sabatons
        233658, -- Conqueror's Pauldrons
        233665, -- Striker's Treads
        233668, -- Striker's Spaulders
        233675, -- Enigma Slippers
        233677, -- Enigma Mantle
    },
    -- Qiraji Bindings of Sovereignty
    ["233371"] = {
        233377, -- Doomcaller's Footwraps
        233379, -- Doomcaller's Mantle
        233387, -- Deathdealer's Spaulders
        233391, -- Deathdealer's Boots
        233392, -- Footwraps of the Oracle
        233394, -- Mantle of the Oracle
        233660, -- Deathdealer's Treads
        233663, -- Deathdealer's Pauldrons
        233671, -- Doomcaller's Shoulderpads
        233673, -- Doomcaller's Treads
        233681, -- Shoulderpads of the Oracle
        233683, -- Slippers of the Oracle
    },
    -- Conqueror's Greaves
    ["233372"] = {
        21333, -- Conqueror's Greaves
    },
    -- Conqueror's Breastplate
    ["233373"] = {
        21331, -- Conqueror's Breastplate
    },
    -- Conqueror's Legguards
    ["233374"] = {
        21332, -- Conqueror's Legguards
    },
    -- Conqueror's Crown
    ["233375"] = {
        21329, -- Conqueror's Crown
    },
    -- Conqueror's Spaulders
    ["233376"] = {
        21330, -- Conqueror's Spaulders
    },
    -- Doomcaller's Footwraps
    ["233377"] = {
        21338, -- Doomcaller's Footwraps
    },
    -- Doomcaller's Trousers
    ["233378"] = {
        21336, -- Doomcaller's Trousers
    },
    -- Doomcaller's Mantle
    ["233379"] = {
        21335, -- Doomcaller's Mantle
    },
    -- Doomcaller's Robes
    ["233380"] = {
        21334, -- Doomcaller's Robes
    },
    -- Doomcaller's Circlet
    ["233381"] = {
        21337, -- Doomcaller's Circlet
    },
    -- Stormcaller's Leggings
    ["233382"] = {
        21375, -- Stormcaller's Leggings
    },
    -- Stormcaller's Pauldrons
    ["233383"] = {
        21376, -- Stormcaller's Pauldrons
    },
    -- Stormcaller's Footguards
    ["233384"] = {
        21373, -- Stormcaller's Footguards
    },
    -- Stormcaller's Diadem
    ["233385"] = {
        21372, -- Stormcaller's Diadem
    },
    -- Stormcaller's Hauberk
    ["233386"] = {
        21374, -- Stormcaller's Hauberk
    },
    -- Deathdealer's Spaulders
    ["233387"] = {
        21361, -- Deathdealer's Spaulders
    },
    -- Deathdealer's Helm
    ["233388"] = {
        21360, -- Deathdealer's Helm
    },
    -- Deathdealer's Vest
    ["233389"] = {
        21364, -- Deathdealer's Vest
    },
    -- Deathdealer's Leggings
    ["233390"] = {
        21362, -- Deathdealer's Leggings
    },
    -- Deathdealer's Boots
    ["233391"] = {
        21359, -- Deathdealer's Boots
    },
    -- Footwraps of the Oracle
    ["233392"] = {
        21349, -- Footwraps of the Oracle
    },
    -- Tiara of the Oracle
    ["233393"] = {
        21348, -- Tiara of the Oracle
    },
    -- Mantle of the Oracle
    ["233394"] = {
        21350, -- Mantle of the Oracle
    },
    -- Vestments of the Oracle
    ["233395"] = {
        21351, -- Vestments of the Oracle
    },
    -- Trousers of the Oracle
    ["233396"] = {
        21352, -- Trousers of the Oracle
    },
    -- Avenger's Breastplate
    ["233397"] = {
        21389, -- Avenger's Breastplate
    },
    -- Avenger's Crown
    ["233398"] = {
        21387, -- Avenger's Crown
    },
    -- Avenger's Greaves
    ["233399"] = {
        21388, -- Avenger's Greaves
    },
    -- Avenger's Legguards
    ["233400"] = {
        21390, -- Avenger's Legguards
    },
    -- Avenger's Pauldrons
    ["233401"] = {
        21391, -- Avenger's Pauldrons
    },
    -- Enigma Robes
    ["233402"] = {
        21343, -- Enigma Robes
    },
    -- Enigma Shoulderpads
    ["233403"] = {
        21345, -- Enigma Shoulderpads
    },
    -- Enigma Circlet
    ["233404"] = {
        21347, -- Enigma Circlet
    },
    -- Enigma Boots
    ["233405"] = {
        21344, -- Enigma Boots
    },
    -- Enigma Leggings
    ["233406"] = {
        21346, -- Enigma Leggings
    },
    -- Striker's Footguards
    ["233407"] = {
        21365, -- Striker's Footguards
    },
    -- Striker's Leggings
    ["233408"] = {
        21368, -- Striker's Leggings
    },
    -- Striker's Pauldrons
    ["233409"] = {
        21367, -- Striker's Pauldrons
    },
    -- Striker's Diadem
    ["233410"] = {
        21366, -- Striker's Diadem
    },
    -- Striker's Hauberk
    ["233411"] = {
        21370, -- Striker's Hauberk
    },
    -- Genesis Helm
    ["233412"] = {
        21353, -- Genesis Helm
    },
    -- Genesis Shoulderpads
    ["233413"] = {
        21354, -- Genesis Shoulderpads
    },
    -- Genesis Boots
    ["233414"] = {
        21355, -- Genesis Boots
    },
    -- Genesis Vest
    ["233415"] = {
        21357, -- Genesis Vest
    },
    -- Genesis Trousers
    ["233416"] = {
        21356, -- Genesis Trousers
    },
    -- Mace of Unending Life
    ["233417"] = {
        21407, -- Mace of Unending Life
    },
    -- Cloak of Unending Life
    ["233418"] = {
        21409, -- Cloak of Unending Life
    },
    -- Band of Unending Life
    ["233419"] = {
        21408, -- Band of Unending Life
    },
    -- Cloak of the Unseen Path
    ["233420"] = {
        21403, -- Cloak of the Unseen Path
    },
    -- Scythe of the Unseen Path
    ["233421"] = {
        21401, -- Scythe of the Unseen Path
    },
    -- Signet of the Unseen Path
    ["233422"] = {
        21402, -- Signet of the Unseen Path
    },
    -- Blade of Vaulted Secrets
    ["233423"] = {
        21413, -- Blade of Vaulted Secrets
    },
    -- Drape of Vaulted Secrets
    ["233424"] = {
        21415, -- Drape of Vaulted Secrets
    },
    -- Band of Vaulted Secrets
    ["233425"] = {
        21414, -- Band of Vaulted Secrets
    },
    -- Blade of Eternal Justice
    ["233426"] = {
        21395, -- Blade of Eternal Justice
    },
    -- Cape of Eternal Justice
    ["233427"] = {
        21397, -- Cape of Eternal Justice
    },
    -- Ring of Eternal Justice
    ["233428"] = {
        21396, -- Ring of Eternal Justice
    },
    -- Gavel of Infinite Wisdom
    ["233429"] = {
        21410, -- Gavel of Infinite Wisdom
    },
    -- Shroud of Infinite Wisdom
    ["233430"] = {
        21412, -- Shroud of Infinite Wisdom
    },
    -- Ring of Infinite Wisdom
    ["233431"] = {
        21411, -- Ring of Infinite Wisdom
    },
    -- Cloak of Veiled Shadows
    ["233432"] = {
        21406, -- Cloak of Veiled Shadows
    },
    -- Dagger of Veiled Shadows
    ["233433"] = {
        21404, -- Dagger of Veiled Shadows
    },
    -- Band of Veiled Shadows
    ["233434"] = {
        21405, -- Band of Veiled Shadows
    },
    -- Hammer of the Gathering Storm
    ["233435"] = {
        21398, -- Hammer of the Gathering Storm
    },
    -- Cloak of the Gathering Storm
    ["233436"] = {
        21400, -- Cloak of the Gathering Storm
    },
    -- Ring of the Gathering Storm
    ["233437"] = {
        21399, -- Ring of the Gathering Storm
    },
    -- Shroud of Unspoken Names
    ["233438"] = {
        21418, -- Shroud of Unspoken Names
    },
    -- Kris of Unspoken Names
    ["233439"] = {
        21416, -- Kris of Unspoken Names
    },
    -- Ring of Unspoken Names
    ["233440"] = {
        21417, -- Ring of Unspoken Names
    },
    -- Drape of Unyielding Strength
    ["233441"] = {
        21394, -- Drape of Unyielding Strength
    },
    -- Sickle of Unyielding Strength
    ["233442"] = {
        21392, -- Sickle of Unyielding Strength
    },
    -- Signet of Unyielding Strength
    ["233443"] = {
        21393, -- Signet of Unyielding Strength
    },
    -- Barrage Shoulders
    ["233496"] = {
        21699, -- Barrage Shoulders
    },
    -- Amulet of Foul Warding
    ["233502"] = {
        21702, -- Amulet of Foul Warding
    },
    -- Pendant of the Qiraji Guardian
    ["233503"] = {
        21700, -- Pendant of the Qiraji Guardian
    },
    -- Cloak of Concentrated Hatred
    ["233504"] = {
        21701, -- Cloak of Concentrated Hatred
    },
    -- Leggings of Immersion
    ["233505"] = {
        21698, -- Leggings of Immersion
    },
    -- Beetle Scaled Wristguards
    ["233506"] = {
        21708, -- Beetle Scaled Wristguards
    },
    -- Ring of Swarming Thought
    ["233507"] = {
        21707, -- Ring of Swarming Thought
    },
    -- Staff of the Qiraji Prophets
    ["233509"] = {
        21128, -- Staff of the Qiraji Prophets
        234974, -- Staff of the Qiraji Prophets
    },
    -- Boots of the Unwavering Will
    ["233514"] = {
        21706, -- Boots of the Unwavering Will
    },
    -- Hammer of Ji'zhi
    ["233515"] = {
        21703, -- Hammer of Ji'zhi
        234975, -- Hammer of Ji'zhi
    },
    -- Breastplate of Annihilation
    ["233516"] = {
        21814, -- Breastplate of Annihilation
    },
    -- Boots of the Redeemed Prophecy
    ["233517"] = {
        21704, -- Boots of the Redeemed Prophecy
    },
    -- Boots of the Fallen Prophet
    ["233518"] = {
        21705, -- Boots of the Fallen Prophet
    },
    -- Cape of the Trinity
    ["233519"] = {
        21697, -- Cape of the Trinity
    },
    -- Robes of the Triumvirate
    ["233520"] = {
        21696, -- Robes of the Triumvirate
    },
    -- Ternary Mantle
    ["233521"] = {
        21694, -- Ternary Mantle
    },
    -- Guise of the Devourer
    ["233522"] = {
        21693, -- Guise of the Devourer
    },
    -- Triad Girdle
    ["233523"] = {
        21692, -- Triad Girdle
    },
    -- Angelista's Touch
    ["233524"] = {
        21695, -- Angelista's Touch
    },
    -- Gloves of Ebru
    ["233559"] = {
        21689, -- Gloves of Ebru
    },
    -- Ooze-ridden Gauntlets
    ["233560"] = {
        21691, -- Ooze-ridden Gauntlets
    },
    -- Boots of the Fallen Hero
    ["233561"] = {
        21688, -- Boots of the Fallen Hero
    },
    -- Angelista's Charm
    ["233562"] = {
        21690, -- Angelista's Charm
    },
    -- Mantle of Phrenic Power
    ["233563"] = {
        21686, -- Mantle of Phrenic Power
    },
    -- Bile-Covered Gauntlets
    ["233564"] = {
        21682, -- Bile-Covered Gauntlets
    },
    -- Ukko's Ring of Darkness
    ["233565"] = {
        21687, -- Ukko's Ring of Darkness
    },
    -- Mantle of the Desert's Fury
    ["233566"] = {
        21684, -- Mantle of the Desert's Fury
    },
    -- Mantle of the Desert Crusade
    ["233567"] = {
        21683, -- Mantle of the Desert Crusade
    },
    -- Vest of Swift Execution
    ["233568"] = {
        21680, -- Vest of Swift Execution
    },
    -- Ring of the Devoured
    ["233569"] = {
        21681, -- Ring of the Devoured
    },
    -- Petrified Scarab
    ["233570"] = {
        21685, -- Petrified Scarab
    },
    -- Wand of Qiraji Nobility
    ["233571"] = {
        234976, -- Wand of Qiraji Nobility
    },
    -- Necklace of Purity
    ["233572"] = {
        21678, -- Necklace of Purity
    },
    -- Recomposed Boots
    ["233573"] = {
        21648, -- Recomposed Boots
    },
    -- Leggings of the Festering Swarm
    ["233574"] = {
        21676, -- Leggings of the Festering Swarm
    },
    -- Robes of the Battleguard
    ["233575"] = {
        21671, -- Robes of the Battleguard
    },
    -- Silithid Claw
    ["233576"] = {
        21673, -- Silithid Claw
        234977, -- Silithid Claw
    },
    -- Thick Qirajihide Belt
    ["233577"] = {
        21675, -- Thick Qirajihide Belt
    },
    -- Creeping Vine Helm
    ["233578"] = {
        21669, -- Creeping Vine Helm
    },
    -- Gloves of Enforcement
    ["233579"] = {
        21672, -- Gloves of Enforcement
    },
    -- Badge of the Swarmguard
    ["233580"] = {
        21670, -- Badge of the Swarmguard
    },
    -- Sartura's Might
    ["233581"] = {
        21666, -- Sartura's Might
    },
    -- Gauntlets of Steadfast Determination
    ["233582"] = {
        21674, -- Gauntlets of Steadfast Determination
    },
    -- Legplates of Blazing Light
    ["233583"] = {
        21667, -- Legplates of Blazing Light
    },
    -- Scaled Leggings of Qiraji Fury
    ["233584"] = {
        21668, -- Scaled Leggings of Qiraji Fury
    },
    -- Ancient Qiraji Ripper
    ["233585"] = {
        234650, -- Ancient Qiraji Ripper
    },
    -- Jaw of the Sand Reaver
    ["233586"] = {
        234978, -- Jaw of the Sand Reaver
    },
    -- Barbed Choker
    ["233587"] = {
        21664, -- Barbed Choker
    },
    -- Cloak of Untold Secrets
    ["233588"] = {
        21627, -- Cloak of Untold Secrets
    },
    -- Fetish of the Sand Reaver
    ["233589"] = {
        21647, -- Fetish of the Sand Reaver
    },
    -- Hive Tunneler's Boots
    ["233590"] = {
        21645, -- Hive Tunneler's Boots
    },
    -- Silithid Carapace Chestguard
    ["233591"] = {
        21652, -- Silithid Carapace Chestguard
    },
    -- Mantle of Wicked Revenge
    ["233592"] = {
        21665, -- Mantle of Wicked Revenge
    },
    -- Pauldrons of the Unrelenting
    ["233593"] = {
        21639, -- Pauldrons of the Unrelenting
    },
    -- Robes of the Guardian Saint
    ["233594"] = {
        21663, -- Robes of the Guardian Saint
    },
    -- Scaled Sand Reaver Leggings
    ["233595"] = {
        21651, -- Scaled Sand Reaver Leggings
    },
    -- Totem of Life
    ["233597"] = {
        22396, -- Totem of Life
    },
    -- Slime-coated Leggings
    ["233598"] = {
        21626, -- Slime-coated Leggings
    },
    -- Sharpened Silithid Femur
    ["233599"] = {
        21622, -- Sharpened Silithid Femur
        234979, -- Sharpened Silithid Femur
    },
    -- Ring of the Qiraji Fury
    ["233600"] = {
        21677, -- Ring of the Qiraji Fury
    },
    -- Scarab Brooch
    ["233601"] = {
        21625, -- Scarab Brooch
    },
    -- Idol of Health
    ["233602"] = {
        22399, -- Idol of Health
    },
    -- Gauntlets of the Righteous Champion
    ["233603"] = {
        21623, -- Gauntlets of the Righteous Champion
    },
    -- Gauntlets of Kalimdor
    ["233604"] = {
        21624, -- Gauntlets of Kalimdor
    },
    -- Huhuran's Stinger
    ["233605"] = {
        21616, -- Huhuran's Stinger
        234980, -- Huhuran's Stinger
    },
    -- Cloak of the Golden Hive
    ["233606"] = {
        21621, -- Cloak of the Golden Hive
    },
    -- Gloves of the Messiah
    ["233607"] = {
        21619, -- Gloves of the Messiah
    },
    -- Wasphide Gauntlets
    ["233608"] = {
        21617, -- Wasphide Gauntlets
    },
    -- Ring of the Martyr
    ["233609"] = {
        21620, -- Ring of the Martyr
    },
    -- Hive Defiler Wristguards
    ["233610"] = {
        21618, -- Hive Defiler Wristguards
    },
    -- Boots of Epiphany
    ["233611"] = {
        21600, -- Boots of Epiphany
    },
    -- Qiraji Execution Bracers
    ["233612"] = {
        21602, -- Qiraji Execution Bracers
    },
    -- Vek'lor's Gloves of Devastation
    ["233613"] = {
        21599, -- Vek'lor's Gloves of Devastation
    },
    -- Royal Qiraji Belt
    ["233614"] = {
        21598, -- Royal Qiraji Belt
    },
    -- Ring of Emperor Vek'lor
    ["233615"] = {
        21601, -- Ring of Emperor Vek'lor
    },
    -- Royal Scepter of Vek'lor
    ["233616"] = {
        21597, -- Royal Scepter of Vek'lor
    },
    -- Bracelets of Royal Redemption
    ["233617"] = {
        21604, -- Bracelets of Royal Redemption
    },
    -- Gloves of the Hidden Temple
    ["233618"] = {
        21605, -- Gloves of the Hidden Temple
    },
    -- Regenerating Belt of Vek'nilash
    ["233619"] = {
        21609, -- Regenerating Belt of Vek'nilash
    },
    -- Amulet of Vek'nilash
    ["233620"] = {
        21608, -- Amulet of Vek'nilash
    },
    -- Kalimdor's Revenge
    ["233621"] = {
        21679, -- Kalimdor's Revenge
        234981, -- Kalimdor's Revenge
    },
    -- Grasp of the Fallen Emperor
    ["233622"] = {
        21607, -- Grasp of the Fallen Emperor
    },
    -- Belt of the Fallen Emperor
    ["233623"] = {
        21606, -- Belt of the Fallen Emperor
    },
    -- Don Rigoberto's Lost Hat
    ["233624"] = {
        21615, -- Don Rigoberto's Lost Hat
    },
    -- Burrower Bracers
    ["233625"] = {
        21611, -- Burrower Bracers
    },
    -- Larvae of the Great Worm
    ["233626"] = {
        23557, -- Larvae of the Great Worm
        234983, -- Larvae of the Great Worm
    },
    -- Jom Gabbar
    ["233627"] = {
        23570, -- Jom Gabbar
    },
    -- The Burrower's Shell
    ["233628"] = {
        23558, -- The Burrower's Shell
    },
    -- Wormscale Blocker
    ["233629"] = {
        21610, -- Wormscale Blocker
    },
    -- Cloak of the Devoured
    ["233630"] = {
        22731, -- Cloak of the Devoured
    },
    -- Dark Storm Gauntlets
    ["233631"] = {
        21585, -- Dark Storm Gauntlets
    },
    -- Grasp of the Old God
    ["233632"] = {
        21582, -- Grasp of the Old God
    },
    -- Eyestalk Waist Cord
    ["233633"] = {
        22730, -- Eyestalk Waist Cord
    },
    -- Death's Sting
    ["233634"] = {
        234984, -- Death's Sting
    },
    -- Belt of Never-ending Agony
    ["233635"] = {
        21586, -- Belt of Never-ending Agony
    },
    -- Scepter of the False Prophet
    ["233636"] = {
        21839, -- Scepter of the False Prophet
        235014, -- Scepter of the False Prophet
    },
    -- Gauntlets of Annihilation
    ["233637"] = {
        21581, -- Gauntlets of Annihilation
    },
    -- Ring of the Godslayer
    ["233638"] = {
        21596, -- Ring of the Godslayer
    },
    -- Vanquished Tentacle of C'Thun
    ["233639"] = {
        21579, -- Vanquished Tentacle of C'Thun
    },
    -- Dark Edge of Insanity
    ["233640"] = {
        234985, -- Dark Edge of Insanity
    },
    -- Cloak of Clarity
    ["233641"] = {
        21583, -- Cloak of Clarity
    },
    -- Mark of C'Thun
    ["233642"] = {
        22732, -- Mark of C'Thun
    },
    -- Anubisath Warhammer
    ["233643"] = {
        234986, -- Anubisath Warhammer
    },
    -- Garb of Royal Ascension
    ["233644"] = {
        21838, -- Garb of Royal Ascension
    },
    -- Gloves of the Immortal
    ["233645"] = {
        21888, -- Gloves of the Immortal
    },
    -- Gloves of the Redeemed Prophecy
    ["233646"] = {
        21889, -- Gloves of the Redeemed Prophecy
    },
    -- Neretzek, The Blood Drinker
    ["233647"] = {
        234987, -- Neretzek, The Blood Drinker
    },
    -- Ritssyn's Ring of Chaos
    ["233648"] = {
        21836, -- Ritssyn's Ring of Chaos
    },
    -- Shard of the Fallen Star
    ["233649"] = {
        21891, -- Shard of the Fallen Star
    },
    -- Conqueror's Cuirass
    ["233651"] = {
        233363, -- Carapace of the Old God
    },
    -- Conqueror's Sabatons
    ["233652"] = {
        233370, -- Qiraji Bindings of Command
    },
    -- Conqueror's Helm
    ["233653"] = {
        233367, -- Intact Peritoneum
    },
    -- Conqueror's Tassets
    ["233654"] = {
        233367, -- Intact Peritoneum
    },
    -- Conqueror's Pauldrons
    ["233658"] = {
        233370, -- Qiraji Bindings of Command
    },
    -- Deathdealer's Chestguard
    ["233659"] = {
        233364, -- Skin of the Old God
    },
    -- Deathdealer's Treads
    ["233660"] = {
        233371, -- Qiraji Bindings of Sovereignty
    },
    -- Deathdealer's Visor
    ["233661"] = {
        233368, -- Intact Entrails
    },
    -- Deathdealer's Pants
    ["233662"] = {
        233368, -- Intact Entrails
    },
    -- Deathdealer's Pauldrons
    ["233663"] = {
        233371, -- Qiraji Bindings of Sovereignty
    },
    -- Striker's Ringmail
    ["233664"] = {
        233363, -- Carapace of the Old God
    },
    -- Striker's Treads
    ["233665"] = {
        233370, -- Qiraji Bindings of Command
    },
    -- Striker's Visor
    ["233666"] = {
        233367, -- Intact Peritoneum
    },
    -- Striker's Chain Legplates
    ["233667"] = {
        233367, -- Intact Peritoneum
    },
    -- Striker's Spaulders
    ["233668"] = {
        233370, -- Qiraji Bindings of Command
    },
    -- Doomcaller's Headguard
    ["233669"] = {
        233368, -- Intact Entrails
    },
    -- Doomcaller's Garb
    ["233670"] = {
        233364, -- Skin of the Old God
    },
    -- Doomcaller's Shoulderpads
    ["233671"] = {
        233371, -- Qiraji Bindings of Sovereignty
    },
    -- Doomcaller's Pants
    ["233672"] = {
        233368, -- Intact Entrails
    },
    -- Doomcaller's Treads
    ["233673"] = {
        233371, -- Qiraji Bindings of Sovereignty
    },
    -- Enigma Pant
    ["233674"] = {
        233367, -- Intact Peritoneum
    },
    -- Enigma Slippers
    ["233675"] = {
        233370, -- Qiraji Bindings of Command
    },
    -- Enigma Diadem
    ["233676"] = {
        233367, -- Intact Peritoneum
    },
    -- Enigma Mantle
    ["233677"] = {
        233370, -- Qiraji Bindings of Command
    },
    -- Enigma Garb
    ["233678"] = {
        233363, -- Carapace of the Old God
    },
    -- Leggings of the Oracle
    ["233679"] = {
        233368, -- Intact Entrails
    },
    -- Robes of the Oracle
    ["233680"] = {
        233364, -- Skin of the Old God
    },
    -- Shoulderpads of the Oracle
    ["233681"] = {
        233371, -- Qiraji Bindings of Sovereignty
    },
    -- Crown of the Oracle
    ["233682"] = {
        233368, -- Intact Entrails
    },
    -- Slippers of the Oracle
    ["233683"] = {
        233371, -- Qiraji Bindings of Sovereignty
    },
    -- Avenger's Mantle
    ["233684"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Avenger's Plate Pants
    ["233685"] = {
        233365, -- Intact Viscera
    },
    -- Avenger's Treads
    ["233686"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Avenger's Helm
    ["233687"] = {
        233365, -- Intact Viscera
    },
    -- Avenger's Cuirass
    ["233688"] = {
        233362, -- Husk of the Old God
    },
    -- Avenger's Spaulders
    ["233689"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Avenger's Tassets
    ["233690"] = {
        233365, -- Intact Viscera
    },
    -- Avenger's Sabatons
    ["233691"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Avenger's Great Helm
    ["233692"] = {
        233365, -- Intact Viscera
    },
    -- Avenger's Chestguard
    ["233693"] = {
        233362, -- Husk of the Old God
    },
    -- Stormcaller's Chestguard
    ["233694"] = {
        233362, -- Husk of the Old God
    },
    -- Stormcaller's Faceguard
    ["233695"] = {
        233365, -- Intact Viscera
    },
    -- Stormcaller's Sabatons
    ["233696"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Stormcaller's Spaulders
    ["233697"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Stormcaller's Legplates
    ["233698"] = {
        233365, -- Intact Viscera
    },
    -- Stormcaller's Breastplate
    ["233699"] = {
        233362, -- Husk of the Old God
    },
    -- Stormcaller's Crown
    ["233700"] = {
        233365, -- Intact Viscera
    },
    -- Stormcaller's Treads
    ["233701"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Stormcaller's Mantle
    ["233702"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Stormcaller's Chain Leggings
    ["233703"] = {
        233365, -- Intact Viscera
    },
    -- Stormcaller's Embrace
    ["233704"] = {
        233362, -- Husk of the Old God
    },
    -- Stormcaller's Headdress
    ["233705"] = {
        233365, -- Intact Viscera
    },
    -- Stormcaller's Greaves
    ["233706"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Stormcaller's Epaulets
    ["233707"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Stormcaller's Mail Leggings
    ["233708"] = {
        233365, -- Intact Viscera
    },
    -- Genesis Cowl
    ["233709"] = {
        233365, -- Intact Viscera
    },
    -- Genesis Leather Pants
    ["233710"] = {
        233365, -- Intact Viscera
    },
    -- Genesis Armor
    ["233711"] = {
        233362, -- Husk of the Old God
    },
    -- Genesis Stompers
    ["233712"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Genesis Spaulders
    ["233713"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Genesis Leggings
    ["233714"] = {
        233365, -- Intact Viscera
    },
    -- Genesis Leathers
    ["233715"] = {
        233362, -- Husk of the Old God
    },
    -- Genesis Treads
    ["233716"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Genesis Mantle
    ["233717"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Genesis Headdress
    ["233718"] = {
        233365, -- Intact Viscera
    },
    -- Genesis Breeches
    ["233719"] = {
        233365, -- Intact Viscera
    },
    -- Genesis Chestguard
    ["233720"] = {
        233362, -- Husk of the Old God
    },
    -- Genesis Greaves
    ["233721"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Genesis Pauldrons
    ["233722"] = {
        233369, -- Qiraji Bindings of Dominance
    },
    -- Genesis Mask
    ["233723"] = {
        233365, -- Intact Viscera
    },
    -- Signet Ring of the Bronze Dragonflight
    ["234034"] = {
        21196, -- Signet Ring of the Bronze Dragonflight
        21197, -- Signet Ring of the Bronze Dragonflight
        21198, -- Signet Ring of the Bronze Dragonflight
        21199, -- Signet Ring of the Bronze Dragonflight
        21200, -- Signet Ring of the Bronze Dragonflight
        21201, -- Signet Ring of the Bronze Dragonflight
        21202, -- Signet Ring of the Bronze Dragonflight
        21203, -- Signet Ring of the Bronze Dragonflight
        21204, -- Signet Ring of the Bronze Dragonflight
        21205, -- Signet Ring of the Bronze Dragonflight
        21206, -- Signet Ring of the Bronze Dragonflight
        21207, -- Signet Ring of the Bronze Dragonflight
        21208, -- Signet Ring of the Bronze Dragonflight
        21209, -- Signet Ring of the Bronze Dragonflight
        21210, -- Signet Ring of the Bronze Dragonflight
    },
    -- Qiraji Sacrificial Dagger
    ["234061"] = {
        21498, -- Qiraji Sacrificial Dagger
        234989, -- Qiraji Sacrificial Dagger
    },
    -- Vestments of the Shifting Sands
    ["234062"] = {
        21499, -- Vestments of the Shifting Sands
    },
    -- Belt of the Sand Reaver
    ["234063"] = {
        21503, -- Belt of the Sand Reaver
    },
    -- Belt of the Inquisition
    ["234064"] = {
        21500, -- Belt of the Inquisition
    },
    -- Sand Reaver Wristguards
    ["234065"] = {
        21502, -- Sand Reaver Wristguards
    },
    -- Toughened Silithid Hide Gloves
    ["234066"] = {
        21501, -- Toughened Silithid Hide Gloves
    },
    -- Manslayer of the Qiraji
    ["234067"] = {
        21492, -- Manslayer of the Qiraji
        234990, -- Manslayer of the Qiraji
    },
    -- Boots of the Vanguard
    ["234068"] = {
        21493, -- Boots of the Vanguard
    },
    -- Boots of the Qiraji General
    ["234069"] = {
        21497, -- Boots of the Qiraji General
    },
    -- Bracers of Qiraji Command
    ["234070"] = {
        21496, -- Bracers of Qiraji Command
    },
    -- Legplates of the Qiraji Command
    ["234071"] = {
        21495, -- Legplates of the Qiraji Command
    },
    -- Southwind's Grasp
    ["234072"] = {
        21494, -- Southwind's Grasp
    },
    -- Dustwind Turban
    ["234073"] = {
        21472, -- Dustwind Turban
    },
    -- Gauntlets of the Immovable
    ["234075"] = {
        21479, -- Gauntlets of the Immovable
    },
    -- Talon of Furious Concentration
    ["234076"] = {
        21471, -- Talon of Furious Concentration
    },
    -- Thick Silithid Chestguard
    ["234077"] = {
        21467, -- Thick Silithid Chestguard
    },
    -- Chitinous Shoulderguards
    ["234078"] = {
        21474, -- Chitinous Shoulderguards
    },
    -- Cloak of the Savior
    ["234079"] = {
        21470, -- Cloak of the Savior
    },
    -- Eye of Moam
    ["234080"] = {
        21473, -- Eye of Moam
    },
    -- Gauntlets of Southwind
    ["234081"] = {
        21469, -- Gauntlets of Southwind
    },
    -- Mantle of Maz'Nadir
    ["234082"] = {
        21468, -- Mantle of Maz'Nadir
    },
    -- Ring of Fury
    ["234083"] = {
        21477, -- Ring of Fury
    },
    -- Southwind Helm
    ["234084"] = {
        21455, -- Southwind Helm
    },
    -- Plans: Black Grasp of the Destroyer
    ["234085"] = {
        22220, -- Plans: Black Grasp of the Destroyer
    },
    -- Black Grasp of the Destroyer
    ["234086"] = {
        22194, -- Black Grasp of the Destroyer
    },
    -- Obsidian Scaled Leggings
    ["234087"] = {
        21476, -- Obsidian Scaled Leggings
    },
    -- Legplates of the Destroyer
    ["234088"] = {
        21475, -- Legplates of the Destroyer
    },
    -- Buru's Skull Fragment
    ["234089"] = {
        21485, -- Buru's Skull Fragment
    },
    -- Gloves of the Swarm
    ["234090"] = {
        21486, -- Gloves of the Swarm
    },
    -- Slimy Scaled Gauntlets
    ["234091"] = {
        21487, -- Slimy Scaled Gauntlets
    },
    -- Fetish of Chitinous Spikes
    ["234092"] = {
        21488, -- Fetish of Chitinous Spikes
    },
    -- Quicksand Waders
    ["234093"] = {
        21489, -- Quicksand Waders
    },
    -- Scaled Bracers of the Gorger
    ["234094"] = {
        21491, -- Scaled Bracers of the Gorger
    },
    -- Slime Kickers
    ["234095"] = {
        21490, -- Slime Kickers
    },
    -- Bow of Taut Sinew
    ["234096"] = {
        21478, -- Bow of Taut Sinew
        234991, -- Bow of Taut Sinew
    },
    -- Stinger of Ayamiss
    ["234097"] = {
        21466, -- Stinger of Ayamiss
        234992, -- Stinger of Ayamiss
    },
    -- Boots of the Desert Protector
    ["234098"] = {
        21481, -- Boots of the Desert Protector
    },
    -- Boots of the Fiery Sands
    ["234099"] = {
        21482, -- Boots of the Fiery Sands
    },
    -- Helm of Regrowth
    ["234100"] = {
        21484, -- Helm of Regrowth
    },
    -- Ring of the Desert Winds
    ["234101"] = {
        21483, -- Ring of the Desert Winds
    },
    -- Scaled Silithid Gauntlets
    ["234102"] = {
        21480, -- Scaled Silithid Gauntlets
    },
    -- Bracers of Brutality
    ["234103"] = {
        21457, -- Bracers of Brutality
    },
    -- Crossbow of Imminent Doom
    ["234104"] = {
        21459, -- Crossbow of Imminent Doom
        234993, -- Crossbow of Imminent Doom
    },
    -- Gauntlets of New Life
    ["234105"] = {
        21458, -- Gauntlets of New Life
    },
    -- Gloves of Dark Wisdom
    ["234106"] = {
        21462, -- Gloves of Dark Wisdom
    },
    -- Helm of Domination
    ["234107"] = {
        21460, -- Helm of Domination
    },
    -- Leggings of the Black Blizzard
    ["234108"] = {
        21461, -- Leggings of the Black Blizzard
    },
    -- Mantle of the Horusath
    ["234109"] = {
        21453, -- Mantle of the Horusath
    },
    -- Ossirian's Binding
    ["234110"] = {
        21463, -- Ossirian's Binding
    },
    -- Runic Stone Shoulders
    ["234111"] = {
        21454, -- Runic Stone Shoulders
    },
    -- Sand Polished Hammer
    ["234112"] = {
        21715, -- Sand Polished Hammer
        234994, -- Sand Polished Hammer
    },
    -- Sandstorm Cloak
    ["234113"] = {
        21456, -- Sandstorm Cloak
    },
    -- Shackles of the Unscarred
    ["234114"] = {
        21464, -- Shackles of the Unscarred
    },
    -- Staff of the Ruins
    ["234115"] = {
        21452, -- Staff of the Ruins
        234995, -- Staff of the Ruins
    },
    -- Fury of the Forgotten Swarm
    ["234116"] = {
        21809, -- Fury of the Forgotten Swarm
    },
    -- Treads of the Wandering Nomad
    ["234117"] = {
        21810, -- Treads of the Wandering Nomad
    },
    -- Gavel of Qiraji Authority
    ["234118"] = {
        21806, -- Gavel of Qiraji Authority
        234996, -- Gavel of Qiraji Authority
    },
    -- Antenna of Invigoration
    ["234119"] = {
        21801, -- Antenna of Invigoration
        235282, -- Antenna of Invigoration
    },
    -- Helm of the Holy Avenger
    ["234120"] = {
        21803, -- Helm of the Holy Avenger
    },
    -- Silithid Husked Launcher
    ["234121"] = {
        21800, -- Silithid Husked Launcher
        234997, -- Silithid Husked Launcher
    },
    -- The Lost Kris of Zedd
    ["234122"] = {
        21802, -- The Lost Kris of Zedd
        234998, -- The Lost Kris of Zedd
    },
    -- Coif of Elemental Fury
    ["234123"] = {
        21804, -- Coif of Elemental Fury
    },
    -- Onyx Embedded Leggings
    ["234129"] = {
        21530, -- Onyx Embedded Leggings
    },
    -- Amulet of Shadow Shielding
    ["234130"] = {
        21529, -- Amulet of Shadow Shielding
    },
    -- Drake Tooth Necklace
    ["234132"] = {
        21531, -- Drake Tooth Necklace
    },
    -- Drudge Boots
    ["234133"] = {
        21532, -- Drudge Boots
    },
    -- Gnomish Turban of Psychic Might
    ["234134"] = {
        21517, -- Gnomish Turban of Psychic Might
    },
    -- Band of Icy Depths
    ["234135"] = {
        21526, -- Band of Icy Depths
    },
    -- Darkwater Robes
    ["234136"] = {
        21527, -- Darkwater Robes
    },
    -- Fang of Korialstrasz
    ["234137"] = {
        21523, -- Fang of Korialstrasz
    },
    -- Shadowsong's Sorrow
    ["234138"] = {
        21522, -- Shadowsong's Sorrow
    },
    -- Ravencrest's Legacy
    ["234139"] = {
        21520, -- Ravencrest's Legacy
    },
    -- Runesword of the Red
    ["234141"] = {
        21521, -- Runesword of the Red
    },
    -- Acid Inscribed Greaves
    ["234146"] = {
        20619, -- Acid Inscribed Greaves
    },
    -- Ancient Corroded Leggings
    ["234147"] = {
        20617, -- Ancient Corroded Leggings
    },
    -- Dragonbone Wristguards
    ["234148"] = {
        20616, -- Dragonbone Wristguards
    },
    -- Dragonspur Wraps
    ["234149"] = {
        20615, -- Dragonspur Wraps
    },
    -- Gloves of Delusional Power
    ["234150"] = {
        20618, -- Gloves of Delusional Power
    },
    -- Green Dragonskin Cloak
    ["234151"] = {
        20579, -- Green Dragonskin Cloak
    },
    -- Hammer of Bestial Fury
    ["234152"] = {
        20580, -- Hammer of Bestial Fury
    },
    -- Staff of Rampant Growth
    ["234153"] = {
        20581, -- Staff of Rampant Growth
    },
    -- Trance Stone
    ["234154"] = {
        20582, -- Trance Stone
    },
    -- Malfurion's Signet Ring
    ["234155"] = {
        20600, -- Malfurion's Signet Ring
    },
    -- Boots of the Endless Moor
    ["234156"] = {
        20621, -- Boots of the Endless Moor
    },
    -- Circlet of Restless Dreams
    ["234157"] = {
        20623, -- Circlet of Restless Dreams
    },
    -- Dragonheart Necklace
    ["234158"] = {
        20622, -- Dragonheart Necklace
    },
    -- Polished Ironwood Crossbow
    ["234159"] = {
        20599, -- Polished Ironwood Crossbow
    },
    -- Ring of the Unliving
    ["234160"] = {
        20624, -- Ring of the Unliving
    },
    -- Belt of the Dark Bog
    ["234161"] = {
        20625, -- Belt of the Dark Bog
    },
    -- Black Bark Wristbands
    ["234162"] = {
        20626, -- Black Bark Wristbands
    },
    -- Dark Heart Pants
    ["234163"] = {
        20627, -- Dark Heart Pants
    },
    -- Deviate Growth Cap
    ["234164"] = {
        20628, -- Deviate Growth Cap
    },
    -- Gauntlets of the Shining Light
    ["234165"] = {
        20630, -- Gauntlets of the Shining Light
    },
    -- Malignant Footguards
    ["234166"] = {
        20629, -- Malignant Footguards
    },
    -- Boots of Fright
    ["234167"] = {
        20634, -- Boots of Fright
    },
    -- Mendicant's Slippers
    ["234168"] = {
        20631, -- Mendicant's Slippers
    },
    -- Mindtear Band
    ["234169"] = {
        20632, -- Mindtear Band
    },
    -- Nightmare Blade
    ["234170"] = {
        20577, -- Nightmare Blade
    },
    -- Unnatural Leather Spaulders
    ["234171"] = {
        20633, -- Unnatural Leather Spaulders
    },
    -- Emerald Dragonfang
    ["234172"] = {
        20578, -- Emerald Dragonfang
    },
    -- Leggings of the Demented Mind
    ["234173"] = {
        20638, -- Leggings of the Demented Mind
    },
    -- Acid Inscribed Pauldrons
    ["234174"] = {
        20637, -- Acid Inscribed Pauldrons
    },
    -- Hibernation Crystal
    ["234175"] = {
        20636, -- Hibernation Crystal
    },
    -- Darkmoon Card: Heroism
    ["234176"] = {
        19287, -- Darkmoon Card: Heroism
    },
    -- Darkmoon Card: Blue Dragon
    ["234177"] = {
        19288, -- Darkmoon Card: Blue Dragon
    },
    -- Darkmoon Card: Maelstrom
    ["234178"] = {
        19289, -- Darkmoon Card: Maelstrom
    },
    -- Darkmoon Card: Twisting Nether
    ["234179"] = {
        19290, -- Darkmoon Card: Twisting Nether
    },
    -- Ironvine Belt
    ["234288"] = {
        22764, -- Ironvine Belt
    },
    -- Plans: Ironvine Belt
    ["234289"] = {
        22768, -- Plans: Ironvine Belt
    },
    -- Ironvine Gloves
    ["234290"] = {
        22763, -- Ironvine Gloves
    },
    -- Plans: Ironvine Gloves
    ["234291"] = {
        22767, -- Plans: Ironvine Gloves
    },
    -- Ironvine Breastplate
    ["234292"] = {
        22762, -- Ironvine Breastplate
    },
    -- Plans: Ironvine Breastplate
    ["234293"] = {
        22766, -- Plans: Ironvine Breastplate
    },
    -- Sandstalker Bracers
    ["234294"] = {
        20476, -- Sandstalker Bracers
    },
    -- Pattern: Sandstalker Bracers
    ["234295"] = {
        20509, -- Pattern: Sandstalker Bracers
    },
    -- Sandstalker Gauntlets
    ["234296"] = {
        20477, -- Sandstalker Gauntlets
    },
    -- Pattern: Sandstalker Gauntlets
    ["234297"] = {
        20510, -- Pattern: Sandstalker Gauntlets
    },
    -- Sandstalker Breastplate
    ["234298"] = {
        20478, -- Sandstalker Breastplate
    },
    -- Pattern: Sandstalker Breastplate
    ["234299"] = {
        20511, -- Pattern: Sandstalker Breastplate
    },
    -- Spitfire Bracers
    ["234300"] = {
        20481, -- Spitfire Bracers
    },
    -- Pattern: Spitfire Bracers
    ["234301"] = {
        20506, -- Pattern: Spitfire Bracers
    },
    -- Spitfire Gauntlets
    ["234302"] = {
        20480, -- Spitfire Gauntlets
    },
    -- Pattern: Spitfire Gauntlets
    ["234303"] = {
        20507, -- Pattern: Spitfire Gauntlets
    },
    -- Spitfire Breastplate
    ["234304"] = {
        20479, -- Spitfire Breastplate
    },
    -- Pattern: Spitfire Breastplate
    ["234305"] = {
        20508, -- Pattern: Spitfire Breastplate
    },
    -- Bramblewood Belt
    ["234306"] = {
        22761, -- Bramblewood Belt
    },
    -- Pattern: Bramblewood Belt
    ["234307"] = {
        22769, -- Pattern: Bramblewood Belt
    },
    -- Bramblewood Boots
    ["234308"] = {
        22760, -- Bramblewood Boots
    },
    -- Pattern: Bramblewood Boots
    ["234309"] = {
        22770, -- Pattern: Bramblewood Boots
    },
    -- Bramblewood Helm
    ["234310"] = {
        22759, -- Bramblewood Helm
    },
    -- Pattern: Bramblewood Helm
    ["234311"] = {
        22771, -- Pattern: Bramblewood Helm
    },
    -- Sylvan Shoulders
    ["234312"] = {
        22758, -- Sylvan Shoulders
    },
    -- Pattern: Sylvan Shoulders
    ["234314"] = {
        22772, -- Pattern: Sylvan Shoulders
    },
    -- Sylvan Crown
    ["234315"] = {
        22757, -- Sylvan Crown
    },
    -- Pattern: Sylvan Crown
    ["234316"] = {
        22773, -- Pattern: Sylvan Crown
    },
    -- Sylvan Vest
    ["234317"] = {
        22756, -- Sylvan Vest
    },
    -- Pattern: Sylvan Vest
    ["234318"] = {
        22774, -- Pattern: Sylvan Vest
    },
    -- Heavy Obsidian Belt
    ["234319"] = {
        22197, -- Heavy Obsidian Belt
    },
    -- Plans: Heavy Obsidian Belt
    ["234320"] = {
        22209, -- Plans: Heavy Obsidian Belt
    },
    -- Light Obsidian Belt
    ["234321"] = {
        22195, -- Light Obsidian Belt
    },
    -- Plans: Light Obsidian Belt
    ["234322"] = {
        22214, -- Plans: Light Obsidian Belt
    },
    -- Dreamscale Breastplate
    ["234324"] = {
        20380, -- Dreamscale Breastplate
    },
    -- Pattern: Dreamscale Breastplate
    ["234325"] = {
        20382, -- Pattern: Dreamscale Breastplate
    },
    -- Plans: Jagged Obsidian Shield
    ["234458"] = {
        22219, -- Plans: Jagged Obsidian Shield
    },
    -- Jagged Obsidian Shield
    ["234459"] = {
        22198, -- Jagged Obsidian Shield
    },
    -- Obsidian Mail Tunic
    ["234460"] = {
        22191, -- Obsidian Mail Tunic
    },
    -- Plans: Obsidian Mail Tunic
    ["234461"] = {
        22221, -- Plans: Obsidian Mail Tunic
    },
    -- Earthstrike
    ["234462"] = {
        21180, -- Earthstrike
    },
    -- Wrath of Cenarius
    ["234463"] = {
        21190, -- Wrath of Cenarius
    },
    -- High Warlord's Greatsword
    ["234542"] = {
        18877, -- High Warlord's Greatsword
    },
    -- High Warlord's Battle Axe
    ["234543"] = {
        18831, -- High Warlord's Battle Axe
    },
    -- High Warlord's Pulverizer
    ["234545"] = {
        18868, -- High Warlord's Pulverizer
    },
    -- High Warlord's Destroyer
    ["234546"] = {
        23465, -- High Warlord's Destroyer
    },
    -- High Warlord's Pig Sticker
    ["234547"] = {
        18871, -- High Warlord's Pig Sticker
    },
    -- High Warlord's War Staff
    ["234549"] = {
        18874, -- High Warlord's War Staff
    },
    -- High Warlord's Spellblade
    ["234550"] = {
        23466, -- High Warlord's Spellblade
    },
    -- High Warlord's Battle Mace
    ["234551"] = {
        23464, -- High Warlord's Battle Mace
    },
    -- High Warlord's Blade
    ["234552"] = {
        16345, -- High Warlord's Blade
    },
    -- High Warlord's Quickblade
    ["234553"] = {
        23467, -- High Warlord's Quickblade
    },
    -- High Warlord's Cleaver
    ["234554"] = {
        18828, -- High Warlord's Cleaver
    },
    -- High Warlord's Bludgeon
    ["234555"] = {
        18866, -- High Warlord's Bludgeon
    },
    -- High Warlord's Razor
    ["234556"] = {
        18840, -- High Warlord's Razor
    },
    -- High Warlord's Right Claw
    ["234557"] = {
        18844, -- High Warlord's Right Claw
    },
    -- High Warlord's Left Claw
    ["234558"] = {
        18848, -- High Warlord's Left Claw
    },
    -- High Warlord's Recurve
    ["234559"] = {
        18835, -- High Warlord's Recurve
    },
    -- High Warlord's Crossbow
    ["234560"] = {
        18837, -- High Warlord's Crossbow
    },
    -- High Warlord's Street Sweeper
    ["234561"] = {
        18860, -- High Warlord's Street Sweeper
    },
    -- High Warlord's Shield Wall
    ["234562"] = {
        18826, -- High Warlord's Shield Wall
    },
    -- High Warlord's Tome of Destruction
    ["234563"] = {
        23468, -- High Warlord's Tome of Destruction
    },
    -- High Warlord's Tome of Mending
    ["234564"] = {
        23469, -- High Warlord's Tome of Mending
    },
    -- Grand Marshal's Claymore
    ["234565"] = {
        18876, -- Grand Marshal's Claymore
    },
    -- Grand Marshal's Sunderer
    ["234566"] = {
        18830, -- Grand Marshal's Sunderer
    },
    -- Grand Marshal's Battle Hammer
    ["234567"] = {
        18867, -- Grand Marshal's Battle Hammer
    },
    -- Grand Marshal's Demolisher
    ["234568"] = {
        23455, -- Grand Marshal's Demolisher
    },
    -- Grand Marshal's Glaive
    ["234569"] = {
        18869, -- Grand Marshal's Glaive
    },
    -- Grand Marshal's Stave
    ["234571"] = {
        18873, -- Grand Marshal's Stave
    },
    -- Grand Marshal's Mageblade
    ["234574"] = {
        23451, -- Grand Marshal's Mageblade
    },
    -- Grand Marshal's Warhammer
    ["234576"] = {
        23454, -- Grand Marshal's Warhammer
    },
    -- Grand Marshal's Longsword
    ["234578"] = {
        12584, -- Grand Marshal's Longsword
    },
    -- Grand Marshal's Swiftblade
    ["234579"] = {
        23456, -- Grand Marshal's Swiftblade
    },
    -- Grand Marshal's Handaxe
    ["234580"] = {
        18827, -- Grand Marshal's Handaxe
    },
    -- Grand Marshal's Punisher
    ["234581"] = {
        18865, -- Grand Marshal's Punisher
    },
    -- Grand Marshal's Dirk
    ["234582"] = {
        18838, -- Grand Marshal's Dirk
    },
    -- Grand Marshal's Right Hand Blade
    ["234583"] = {
        18843, -- Grand Marshal's Right Hand Blade
    },
    -- Grand Marshal's Left Hand Blade
    ["234584"] = {
        18847, -- Grand Marshal's Left Hand Blade
    },
    -- Grand Marshal's Bullseye
    ["234585"] = {
        18833, -- Grand Marshal's Bullseye
    },
    -- Grand Marshal's Repeater
    ["234586"] = {
        18836, -- Grand Marshal's Repeater
    },
    -- Grand Marshal's Hand Cannon
    ["234587"] = {
        18855, -- Grand Marshal's Hand Cannon
    },
    -- Grand Marshal's Aegis
    ["234588"] = {
        18825, -- Grand Marshal's Aegis
    },
    -- Grand Marshal's Tome of Power
    ["234589"] = {
        23452, -- Grand Marshal's Tome of Power
    },
    -- Grand Marshal's Tome of Restoration
    ["234590"] = {
        23453, -- Grand Marshal's Tome of Restoration
    },
    -- Ancient Qiraji Ripper
    ["234650"] = {
        21650, -- Ancient Qiraji Ripper
        233585, -- Ancient Qiraji Ripper
    },
    -- Fist of Cenarius
    ["234747"] = {
        21188, -- Fist of Cenarius
    },
    -- Deeprock Bracers
    ["234748"] = {
        21184, -- Deeprock Bracers
    },
    -- Earthcalm Orb
    ["234749"] = {
        21185, -- Earthcalm Orb
    },
    -- Rockfury Bracers
    ["234760"] = {
        21186, -- Rockfury Bracers
    },
    -- Might of Cenarius
    ["234761"] = {
        21189, -- Might of Cenarius
    },
    -- Grace of Earth
    ["234779"] = {
        21181, -- Grace of Earth
    },
    -- Band of Earthen Might
    ["234780"] = {
        21182, -- Band of Earthen Might
    },
    -- Earthpower Vest
    ["234782"] = {
        21183, -- Earthpower Vest
    },
    -- Gloves of Earthen Power
    ["234785"] = {
        21178, -- Gloves of Earthen Power
    },
    -- Band of Earthen Wrath
    ["234786"] = {
        21179, -- Band of Earthen Wrath
    },
    -- Earthweave Cloak
    ["234788"] = {
        21187, -- Earthweave Cloak
    },
    -- Ravenholdt Slicer
    ["234792"] = {
        22378, -- Ravenholdt Slicer
    },
    -- Shivsprocket's Shiv
    ["234793"] = {
        22379, -- Shivsprocket's Shiv
    },
    -- The Thunderwood Poker
    ["234797"] = {
        22377, -- The Thunderwood Poker
    },
    -- Doomulus Prime
    ["234798"] = {
        22348, -- Doomulus Prime
    },
    -- Fahrad's Reloading Repeater
    ["234799"] = {
        22347, -- Fahrad's Reloading Repeater
    },
    -- Simone's Cultivating Hammer
    ["234800"] = {
        22380, -- Simone's Cultivating Hammer
    },
    -- Amulet of the Fallen God
    ["234801"] = {
        21712, -- Amulet of the Fallen God
    },
    -- Cloak of the Fallen God
    ["234802"] = {
        21710, -- Cloak of the Fallen God
    },
    -- Ring of the Fallen God
    ["234803"] = {
        21709, -- Ring of the Fallen God
    },
    -- Blessed Qiraji War Axe
    ["234804"] = {
        235046, -- Imperial Qiraji Armaments
    },
    -- Blessed Qiraji Musket
    ["234805"] = {
        235046, -- Imperial Qiraji Armaments
    },
    -- Blessed Qiraji Pugio
    ["234806"] = {
        235046, -- Imperial Qiraji Armaments
    },
    -- Blessed Qiraji Bulwark
    ["234807"] = {
        21269, -- Blessed Qiraji Bulwark
    },
    -- Blessed Qiraji Acolyte Staff
    ["234808"] = {
        21273, -- Blessed Qiraji Acolyte Staff
    },
    -- Blessed Qiraji Augur Staff
    ["234809"] = {
        235045, -- Imperial Qiraji Regalia
    },
    -- Blessed Qiraji War Hammer
    ["234810"] = {
        235045, -- Imperial Qiraji Regalia
    },
    -- Charm of the Shifting Sands
    ["234811"] = {
        21504, -- Charm of the Shifting Sands
    },
    -- Amulet of the Shifting Sands
    ["234812"] = {
        21507, -- Amulet of the Shifting Sands
    },
    -- Choker of the Shifting Sands
    ["234813"] = {
        21505, -- Choker of the Shifting Sands
    },
    -- Pendant of the Shifting Sands
    ["234814"] = {
        21506, -- Pendant of the Shifting Sands
    },
    -- Jade Inlaid Vestments
    ["234962"] = {
        20635, -- Jade Inlaid Vestments
    },
    -- Strangely Glyphed Legplates
    ["234963"] = {
        20639, -- Strangely Glyphed Legplates
    },
    -- Staff of the Qiraji Prophets
    ["234974"] = {
        233509, -- Staff of the Qiraji Prophets
    },
    -- Hammer of Ji'zhi
    ["234975"] = {
        233515, -- Hammer of Ji'zhi
    },
    -- Wand of Qiraji Nobility
    ["234976"] = {
        21603, -- Wand of Qiraji Nobility
        233571, -- Wand of Qiraji Nobility
    },
    -- Silithid Claw
    ["234977"] = {
        233576, -- Silithid Claw
    },
    -- Jaw of the Sand Reaver
    ["234978"] = {
        233586, -- Jaw of the Sand Reaver
    },
    -- Sharpened Silithid Femur
    ["234979"] = {
        233599, -- Sharpened Silithid Femur
    },
    -- Huhuran's Stinger
    ["234980"] = {
        233605, -- Huhuran's Stinger
    },
    -- Kalimdor's Revenge
    ["234981"] = {
        233621, -- Kalimdor's Revenge
    },
    -- Larvae of the Great Worm
    ["234983"] = {
        233626, -- Larvae of the Great Worm
    },
    -- Death's Sting
    ["234984"] = {
        21126, -- Death's Sting
        233634, -- Death's Sting
    },
    -- Dark Edge of Insanity
    ["234985"] = {
        21134, -- Dark Edge of Insanity
        233640, -- Dark Edge of Insanity
    },
    -- Anubisath Warhammer
    ["234986"] = {
        21837, -- Anubisath Warhammer
        233643, -- Anubisath Warhammer
    },
    -- Neretzek, The Blood Drinker
    ["234987"] = {
        21856, -- Neretzek, The Blood Drinker
        233647, -- Neretzek, The Blood Drinker
    },
    -- Qiraji Sacrificial Dagger
    ["234989"] = {
        234061, -- Qiraji Sacrificial Dagger
    },
    -- Manslayer of the Qiraji
    ["234990"] = {
        234067, -- Manslayer of the Qiraji
    },
    -- Bow of Taut Sinew
    ["234991"] = {
        234096, -- Bow of Taut Sinew
    },
    -- Stinger of Ayamiss
    ["234992"] = {
        234097, -- Stinger of Ayamiss
    },
    -- Crossbow of Imminent Doom
    ["234993"] = {
        234104, -- Crossbow of Imminent Doom
    },
    -- Sand Polished Hammer
    ["234994"] = {
        234112, -- Sand Polished Hammer
    },
    -- Staff of the Ruins
    ["234995"] = {
        234115, -- Staff of the Ruins
    },
    -- Gavel of Qiraji Authority
    ["234996"] = {
        234118, -- Gavel of Qiraji Authority
    },
    -- Silithid Husked Launcher
    ["234997"] = {
        234121, -- Silithid Husked Launcher
    },
    -- The Lost Kris of Zedd
    ["234998"] = {
        234122, -- The Lost Kris of Zedd
    },
    -- Blessed Qiraji War Hammer
    ["234999"] = {
        21268, -- Blessed Qiraji War Hammer
    },
    -- Blessed Qiraji Augur Staff
    ["235000"] = {
        21275, -- Blessed Qiraji Augur Staff
    },
    -- Blessed Qiraji Pugio
    ["235002"] = {
        21244, -- Blessed Qiraji Pugio
    },
    -- Blessed Qiraji War Axe
    ["235003"] = {
        21242, -- Blessed Qiraji War Axe
    },
    -- Blessed Qiraji Musket
    ["235004"] = {
        21272, -- Blessed Qiraji Musket
    },
    -- Scepter of the False Prophet
    ["235014"] = {
        233636, -- Scepter of the False Prophet
    },
    -- Plans: Thick Obsidian Breastplate
    ["235039"] = {
        22222, -- Plans: Thick Obsidian Breastplate
    },
    -- Thick Obsidian Breastplate
    ["235040"] = {
        22196, -- Thick Obsidian Breastplate
    },
    -- Imperial Qiraji Regalia
    ["235045"] = {
        21237, -- Imperial Qiraji Regalia
        234808, -- Blessed Qiraji Acolyte Staff
        234809, -- Blessed Qiraji Augur Staff
        234810, -- Blessed Qiraji War Hammer
    },
    -- Imperial Qiraji Armaments
    ["235046"] = {
        21232, -- Imperial Qiraji Armaments
        234804, -- Blessed Qiraji War Axe
        234805, -- Blessed Qiraji Musket
        234806, -- Blessed Qiraji Pugio
        234807, -- Blessed Qiraji Bulwark
    },
    -- Gloves of the Fallen Prophet
    ["235047"] = {
        21890, -- Gloves of the Fallen Prophet
    },
    -- Head of Ossirian the Unscarred
    ["235048"] = {
        21220, -- Head of Ossirian the Unscarred
        234811, -- Charm of the Shifting Sands
        234812, -- Amulet of the Shifting Sands
        234813, -- Choker of the Shifting Sands
        234814, -- Pendant of the Shifting Sands
    },
    -- Nightmare Engulfed Object
    ["235049"] = {
        20644, -- Nightmare Engulfed Object
    },
    -- Portals Deck
    ["235275"] = {
        19277, -- Portals Deck
    },
    -- Elementals Deck
    ["235276"] = {
        19267, -- Elementals Deck
    },
    -- Warlords Deck
    ["235277"] = {
        19257, -- Warlords Deck
    },
    -- Beasts Deck
    ["235278"] = {
        19228, -- Beasts Deck
    },
    -- Antenna of Invigoration
    ["235282"] = {
        234119, -- Antenna of Invigoration
    },
    -- Dreadnaught Breastplate
    ["236005"] = {
        22416, -- Dreadnaught Breastplate
    },
    -- Dreadnaught Legplates
    ["236006"] = {
        22417, -- Dreadnaught Legplates
    },
    -- Dreadnaught Helmet
    ["236007"] = {
        22418, -- Dreadnaught Helmet
    },
    -- Dreadnaught Pauldrons
    ["236008"] = {
        22419, -- Dreadnaught Pauldrons
    },
    -- Dreadnaught Sabatons
    ["236009"] = {
        22420, -- Dreadnaught Sabatons
    },
    -- Dreadnaught Gauntlets
    ["236010"] = {
        22421, -- Dreadnaught Gauntlets
    },
    -- Dreadnaught Waistguard
    ["236011"] = {
        22422, -- Dreadnaught Waistguard
    },
    -- Dreadnaught Bracers
    ["236012"] = {
        22423, -- Dreadnaught Bracers
    },
    -- Ring of the Dreadnaught
    ["236013"] = {
        23059, -- Ring of the Dreadnaught
    },
    -- Dreadnaught Cuirass
    ["236014"] = {
        236231, -- Desecrated Breastplate
    },
    -- Dreadnaught Tassets
    ["236015"] = {
        236238, -- Desecrated Legplates
    },
    -- Dreadnaught Horns
    ["236016"] = {
        236236, -- Desecrated Helmet
    },
    -- Dreadnaught Shoulders
    ["236017"] = {
        236237, -- Desecrated Pauldrons
    },
    -- Dreadnaught Greaves
    ["236018"] = {
        236234, -- Desecrated Sabatons
    },
    -- Dreadnaught Grips
    ["236019"] = {
        236233, -- Desecrated Gauntlets
    },
    -- Dreadnaught Belt
    ["236020"] = {
        236232, -- Desecrated Waistguard
    },
    -- Dreadnaught Wrists
    ["236021"] = {
        236235, -- Desecrated Bracers
    },
    -- Band of the Dreadnaught
    ["236022"] = {
        237381, -- Desecrated Ring
    },
    -- Bonescythe Breastplate
    ["236023"] = {
        22476, -- Bonescythe Breastplate
    },
    -- Bonescythe Legplates
    ["236024"] = {
        22477, -- Bonescythe Legplates
    },
    -- Bonescythe Helmet
    ["236025"] = {
        22478, -- Bonescythe Helmet
    },
    -- Bonescythe Pauldrons
    ["236026"] = {
        22479, -- Bonescythe Pauldrons
    },
    -- Bonescythe Sabatons
    ["236027"] = {
        22480, -- Bonescythe Sabatons
    },
    -- Bonescythe Gauntlets
    ["236028"] = {
        22481, -- Bonescythe Gauntlets
    },
    -- Bonescythe Waistguard
    ["236029"] = {
        22482, -- Bonescythe Waistguard
    },
    -- Bonescythe Bracers
    ["236030"] = {
        22483, -- Bonescythe Bracers
    },
    -- Bonescythe Ring
    ["236031"] = {
        23060, -- Bonescythe Ring
    },
    -- Bonescythe Belt
    ["236032"] = {
        236244, -- Desecrated Belt
    },
    -- Bonescythe Treads
    ["236033"] = {
        236239, -- Desecrated Sandals
    },
    -- Bonescythe Band
    ["236034"] = {
        237381, -- Desecrated Ring
    },
    -- Bonescythe Mantle
    ["236035"] = {
        236240, -- Desecrated Shoulderpads
    },
    -- Bonescythe Leggings
    ["236036"] = {
        236246, -- Desecrated Leggings
    },
    -- Bonescythe Mask
    ["236037"] = {
        236241, -- Desecrated Circlet
    },
    -- Bonescythe Grips
    ["236038"] = {
        236243, -- Desecrated Gloves
    },
    -- Bonescythe Chestguard
    ["236039"] = {
        236242, -- Desecrated Robe
    },
    -- Bonescythe Wristguards
    ["236040"] = {
        236245, -- Desecrated Bindings
    },
    -- Ring of the Cryptstalker
    ["236041"] = {
        23067, -- Ring of the Cryptstalker
    },
    -- Cryptstalker Wristguards
    ["236042"] = {
        22443, -- Cryptstalker Wristguards
    },
    -- Cryptstalker Tunic
    ["236043"] = {
        22436, -- Cryptstalker Tunic
    },
    -- Cryptstalker Spaulders
    ["236044"] = {
        22439, -- Cryptstalker Spaulders
    },
    -- Cryptstalker Legguards
    ["236045"] = {
        22437, -- Cryptstalker Legguards
    },
    -- Cryptstalker Headpiece
    ["236046"] = {
        22438, -- Cryptstalker Headpiece
    },
    -- Cryptstalker Handguards
    ["236047"] = {
        22441, -- Cryptstalker Handguards
    },
    -- Cryptstalker Girdle
    ["236048"] = {
        22442, -- Cryptstalker Girdle
    },
    -- Cryptstalker Boots
    ["236049"] = {
        22440, -- Cryptstalker Boots
    },
    -- Cryptstalker Vambraces
    ["236050"] = {
        236235, -- Desecrated Bracers
    },
    -- Cryptstalker Belt
    ["236051"] = {
        236232, -- Desecrated Waistguard
    },
    -- Cryptstalker Pauldrons
    ["236052"] = {
        236237, -- Desecrated Pauldrons
    },
    -- Cryptstalker Leggings
    ["236053"] = {
        236238, -- Desecrated Legplates
    },
    -- Cryptstalker Visor
    ["236054"] = {
        236236, -- Desecrated Helmet
    },
    -- Cryptstalker Gauntlets
    ["236055"] = {
        236233, -- Desecrated Gauntlets
    },
    -- Band of the Cryptstalker
    ["236056"] = {
        237381, -- Desecrated Ring
    },
    -- Cryptstalker Greaves
    ["236057"] = {
        236234, -- Desecrated Sabatons
    },
    -- Cryptstalker Breastplate
    ["236058"] = {
        236231, -- Desecrated Breastplate
    },
    -- Plagueheart Sandals
    ["236059"] = {
        22508, -- Plagueheart Sandals
    },
    -- Plagueheart Leggings
    ["236060"] = {
        22505, -- Plagueheart Leggings
    },
    -- Plagueheart Bindings
    ["236061"] = {
        22511, -- Plagueheart Bindings
    },
    -- Plagueheart Robe
    ["236062"] = {
        22504, -- Plagueheart Robe
    },
    -- Plagueheart Gloves
    ["236063"] = {
        22509, -- Plagueheart Gloves
    },
    -- Plagueheart Circlet
    ["236064"] = {
        22506, -- Plagueheart Circlet
    },
    -- Plagueheart Shoulderpads
    ["236065"] = {
        22507, -- Plagueheart Shoulderpads
    },
    -- Plagueheart Belt
    ["236066"] = {
        22510, -- Plagueheart Belt
    },
    -- Plagueheart Ring
    ["236067"] = {
        23063, -- Plagueheart Ring
    },
    -- Plagueheart Wristguards
    ["236068"] = {
        236245, -- Desecrated Bindings
    },
    -- Plagueheart Waistguard
    ["236069"] = {
        236244, -- Desecrated Belt
    },
    -- Plagueheart Mantle
    ["236070"] = {
        236240, -- Desecrated Shoulderpads
    },
    -- Plagueheart Pants
    ["236071"] = {
        236246, -- Desecrated Leggings
    },
    -- Plagueheart Crown
    ["236072"] = {
        236241, -- Desecrated Circlet
    },
    -- Plagueheart Handguards
    ["236073"] = {
        236243, -- Desecrated Gloves
    },
    -- Plagueheart Loop
    ["236074"] = {
        237381, -- Desecrated Ring
    },
    -- Plagueheart Boots
    ["236075"] = {
        236239, -- Desecrated Sandals
    },
    -- Plagueheart Garb
    ["236076"] = {
        236242, -- Desecrated Robe
    },
    -- Frostfire Bindings
    ["236077"] = {
        22503, -- Frostfire Bindings
    },
    -- Frostfire Belt
    ["236078"] = {
        22502, -- Frostfire Belt
    },
    -- Frostfire Leggings
    ["236079"] = {
        22497, -- Frostfire Leggings
    },
    -- Frostfire Sandals
    ["236080"] = {
        22500, -- Frostfire Sandals
    },
    -- Frostfire Robe
    ["236081"] = {
        22496, -- Frostfire Robe
    },
    -- Frostfire Gloves
    ["236082"] = {
        22501, -- Frostfire Gloves
    },
    -- Frostfire Circlet
    ["236083"] = {
        22498, -- Frostfire Circlet
    },
    -- Frostfire Shoulderpads
    ["236084"] = {
        22499, -- Frostfire Shoulderpads
    },
    -- Frostfire Ring
    ["236085"] = {
        23062, -- Frostfire Ring
    },
    -- Frostfire Wristwraps
    ["236087"] = {
        236235, -- Desecrated Bracers
    },
    -- Frostfire Waistguard
    ["236088"] = {
        236232, -- Desecrated Waistguard
    },
    -- Frostfire Mantle
    ["236089"] = {
        236237, -- Desecrated Pauldrons
    },
    -- Frostfire Pants
    ["236090"] = {
        236238, -- Desecrated Legplates
    },
    -- Frostfire Hood
    ["236091"] = {
        236236, -- Desecrated Helmet
    },
    -- Frostfire Mitts
    ["236092"] = {
        236233, -- Desecrated Gauntlets
    },
    -- Frostfire Band
    ["236093"] = {
        237381, -- Desecrated Ring
    },
    -- Frostfire Boots
    ["236094"] = {
        236234, -- Desecrated Sabatons
    },
    -- Frostfire Garb
    ["236095"] = {
        236231, -- Desecrated Breastplate
    },
    -- Robe of Faith
    ["236097"] = {
        22512, -- Robe of Faith
    },
    -- Belt of Faith
    ["236098"] = {
        22518, -- Belt of Faith
    },
    -- Sandals of Faith
    ["236099"] = {
        22516, -- Sandals of Faith
    },
    -- Bindings of Faith
    ["236100"] = {
        22519, -- Bindings of Faith
    },
    -- Leggings of Faith
    ["236101"] = {
        22513, -- Leggings of Faith
    },
    -- Shoulderpads of Faith
    ["236102"] = {
        22515, -- Shoulderpads of Faith
    },
    -- Circlet of Faith
    ["236103"] = {
        22514, -- Circlet of Faith
    },
    -- Gloves of Faith
    ["236104"] = {
        22517, -- Gloves of Faith
    },
    -- Ring of Faith
    ["236105"] = {
        23061, -- Ring of Faith
    },
    -- Wrists of Faith
    ["236106"] = {
        236245, -- Desecrated Bindings
    },
    -- Girdle of Faith
    ["236107"] = {
        236244, -- Desecrated Belt
    },
    -- Mantle of Faith
    ["236108"] = {
        236240, -- Desecrated Shoulderpads
    },
    -- Pants of Faith
    ["236109"] = {
        236246, -- Desecrated Leggings
    },
    -- Hands of Faith
    ["236111"] = {
        236243, -- Desecrated Gloves
    },
    -- Band of Faith
    ["236112"] = {
        237381, -- Desecrated Ring
    },
    -- Boots of Faith
    ["236113"] = {
        236239, -- Desecrated Sandals
    },
    -- Garb of Faith
    ["236114"] = {
        236242, -- Desecrated Robe
    },
    -- Redemption Tunic
    ["236115"] = {
        22425, -- Redemption Tunic
    },
    -- Ring of Redemption
    ["236116"] = {
        23066, -- Ring of Redemption
    },
    -- Redemption Headpiece
    ["236117"] = {
        22428, -- Redemption Headpiece
    },
    -- Redemption Handguards
    ["236118"] = {
        22426, -- Redemption Handguards
    },
    -- Redemption Wristguards
    ["236119"] = {
        22424, -- Redemption Wristguards
    },
    -- Redemption Girdle
    ["236120"] = {
        22431, -- Redemption Girdle
    },
    -- Redemption Legguards
    ["236121"] = {
        22427, -- Redemption Legguards
    },
    -- Redemption Spaulders
    ["236122"] = {
        22429, -- Redemption Spaulders
    },
    -- Redemption Boots
    ["236123"] = {
        22430, -- Redemption Boots
    },
    -- Redemption Vambraces
    ["236124"] = {
        236247, -- Desecrated Wristguards
    },
    -- Redemption Belt
    ["236125"] = {
        236252, -- Desecrated Girdle
    },
    -- Redemption Shoulderplates
    ["236126"] = {
        236254, -- Desecrated Spaulders
    },
    -- Redemption Leggings
    ["236127"] = {
        236253, -- Desecrated Legguards
    },
    -- Redemption Helmet
    ["236128"] = {
        236249, -- Desecrated Headpiece
    },
    -- Redemption Gloves
    ["236129"] = {
        236250, -- Desecrated Handguards
    },
    -- Band of Redemption
    ["236130"] = {
        237381, -- Desecrated Ring
    },
    -- Redemption Greaves
    ["236131"] = {
        236248, -- Desecrated Boots
    },
    -- Redemption Breastplate
    ["236132"] = {
        236251, -- Desecrated Tunic
    },
    -- Redemption Bracers
    ["236133"] = {
        236247, -- Desecrated Wristguards
    },
    -- Redemption Waistguard
    ["236134"] = {
        236252, -- Desecrated Girdle
    },
    -- Redemption Pauldrons
    ["236135"] = {
        236254, -- Desecrated Spaulders
    },
    -- Redemption Legplates
    ["236136"] = {
        236253, -- Desecrated Legguards
    },
    -- Redemption Crown
    ["236137"] = {
        236249, -- Desecrated Headpiece
    },
    -- Redemption Gauntlets
    ["236138"] = {
        236250, -- Desecrated Handguards
    },
    -- Loop of Redemption
    ["236139"] = {
        237381, -- Desecrated Ring
    },
    -- Redemption Sabatons
    ["236140"] = {
        236248, -- Desecrated Boots
    },
    -- Redemption Chestguard
    ["236141"] = {
        236251, -- Desecrated Tunic
    },
    -- Earthshatter Handguards
    ["236142"] = {
        22469, -- Earthshatter Handguards
    },
    -- Earthshatter Legguards
    ["236143"] = {
        22465, -- Earthshatter Legguards
    },
    -- Earthshatter Headpiece
    ["236144"] = {
        22466, -- Earthshatter Headpiece
    },
    -- Earthshatter Spaulders
    ["236145"] = {
        22467, -- Earthshatter Spaulders
    },
    -- Earthshatter Boots
    ["236146"] = {
        22468, -- Earthshatter Boots
    },
    -- Earthshatter Tunic
    ["236147"] = {
        22464, -- Earthshatter Tunic
    },
    -- Earthshatter Girdle
    ["236148"] = {
        22470, -- Earthshatter Girdle
    },
    -- Earthshatter Wristguards
    ["236149"] = {
        22471, -- Earthshatter Wristguards
    },
    -- Ring of the Earthshatterer
    ["236150"] = {
        23065, -- Ring of the Earthshatterer
    },
    -- Earthshatter Bindings
    ["236151"] = {
        236247, -- Desecrated Wristguards
    },
    -- Earthshatter Cord
    ["236152"] = {
        236252, -- Desecrated Girdle
    },
    -- Earthshatter Mantle
    ["236153"] = {
        236254, -- Desecrated Spaulders
    },
    -- Earthshatter Kilt
    ["236154"] = {
        236253, -- Desecrated Legguards
    },
    -- Earthshatter Crown
    ["236155"] = {
        236249, -- Desecrated Headpiece
    },
    -- Earthshatter Mitts
    ["236156"] = {
        236250, -- Desecrated Handguards
    },
    -- Earthshatter Greaves
    ["236158"] = {
        236248, -- Desecrated Boots
    },
    -- Earthshatter Embrace
    ["236159"] = {
        236251, -- Desecrated Tunic
    },
    -- Earthshatter Bracers
    ["236160"] = {
        236247, -- Desecrated Wristguards
    },
    -- Earthshatter Waistguard
    ["236162"] = {
        236252, -- Desecrated Girdle
    },
    -- Earthshatter Pauldrons
    ["236163"] = {
        236254, -- Desecrated Spaulders
    },
    -- Earthshatter Legplates
    ["236164"] = {
        236253, -- Desecrated Legguards
    },
    -- Earthshatter Faceguard
    ["236165"] = {
        236249, -- Desecrated Headpiece
    },
    -- Earthshatter Gloves
    ["236166"] = {
        236250, -- Desecrated Handguards
    },
    -- Earthshatter Sabatons
    ["236168"] = {
        236248, -- Desecrated Boots
    },
    -- Earthshatter Chestguard
    ["236169"] = {
        236251, -- Desecrated Tunic
    },
    -- Earthshatter Vambraces
    ["236170"] = {
        236247, -- Desecrated Wristguards
    },
    -- Earthshatter Belt
    ["236171"] = {
        236252, -- Desecrated Girdle
    },
    -- Earthshatter Epaulets
    ["236172"] = {
        236254, -- Desecrated Spaulders
    },
    -- Earthshatter Leggings
    ["236173"] = {
        236253, -- Desecrated Legguards
    },
    -- Earthshatter Helmet
    ["236174"] = {
        236249, -- Desecrated Headpiece
    },
    -- Earthshatter Grips
    ["236175"] = {
        236250, -- Desecrated Handguards
    },
    -- Earthshatter Treads
    ["236177"] = {
        236248, -- Desecrated Boots
    },
    -- Earthshatter Armor
    ["236179"] = {
        236251, -- Desecrated Tunic
    },
    -- Dreamwalker Headpiece
    ["236182"] = {
        22490, -- Dreamwalker Headpiece
    },
    -- Dreamwalker Wristguards
    ["236183"] = {
        22495, -- Dreamwalker Wristguards
    },
    -- Dreamwalker Handguards
    ["236184"] = {
        22493, -- Dreamwalker Handguards
    },
    -- Dreamwalker Boots
    ["236185"] = {
        22492, -- Dreamwalker Boots
    },
    -- Dreamwalker Tunic
    ["236186"] = {
        22488, -- Dreamwalker Tunic
    },
    -- Dreamwalker Girdle
    ["236187"] = {
        22494, -- Dreamwalker Girdle
    },
    -- Dreamwalker Legguards
    ["236188"] = {
        22489, -- Dreamwalker Legguards
    },
    -- Dreamwalker Spaulders
    ["236189"] = {
        22491, -- Dreamwalker Spaulders
    },
    -- Ring of the Dreamwalker
    ["236190"] = {
        23064, -- Ring of The Dreamwalker
    },
    -- Dreamwalker Bindings
    ["236192"] = {
        236247, -- Desecrated Wristguards
    },
    -- Dreamwalker Cord
    ["236193"] = {
        236252, -- Desecrated Girdle
    },
    -- Dreamwalker Mantle
    ["236194"] = {
        236254, -- Desecrated Spaulders
    },
    -- Dreamwalker Kilt
    ["236195"] = {
        236253, -- Desecrated Legguards
    },
    -- Dreamwalker Mitts
    ["236197"] = {
        236250, -- Desecrated Handguards
    },
    -- Band of the Dreamwalker
    ["236198"] = {
        237381, -- Desecrated Ring
    },
    -- Dreamwalker Sandals
    ["236199"] = {
        236248, -- Desecrated Boots
    },
    -- Dreamwalker Leathers
    ["236200"] = {
        236251, -- Desecrated Tunic
    },
    -- Dreamwalker Bracers
    ["236201"] = {
        236247, -- Desecrated Wristguards
    },
    -- Dreamwalker Waistguard
    ["236202"] = {
        236252, -- Desecrated Girdle
    },
    -- Dreamwalker Pauldrons
    ["236203"] = {
        236254, -- Desecrated Spaulders
    },
    -- Dreamwalker Leggings
    ["236204"] = {
        236253, -- Desecrated Legguards
    },
    -- Dreamwalker Headdress
    ["236205"] = {
        236249, -- Desecrated Headpiece
    },
    -- Dreamwalker Gauntlets
    ["236206"] = {
        236250, -- Desecrated Handguards
    },
    -- Loop of the Dreamwalker
    ["236207"] = {
        237381, -- Desecrated Ring
    },
    -- Dreamwalker Sabatons
    ["236208"] = {
        236248, -- Desecrated Boots
    },
    -- Dreamwalker Armor
    ["236209"] = {
        13123, -- Dreamwalker Armor
    },
    -- Dreamwalker Wraps
    ["236210"] = {
        236247, -- Desecrated Wristguards
    },
    -- Dreamwalker Sash
    ["236211"] = {
        236252, -- Desecrated Girdle
    },
    -- Dreamwalker Shoulderpads
    ["236212"] = {
        236254, -- Desecrated Spaulders
    },
    -- Dreamwalker Trousers
    ["236213"] = {
        236253, -- Desecrated Legguards
    },
    -- Dreamwalker Cowl
    ["236214"] = {
        236249, -- Desecrated Headpiece
    },
    -- Dreamwalker Grips
    ["236215"] = {
        236250, -- Desecrated Handguards
    },
    -- Signet of the Dreamwalker
    ["236216"] = {
        237381, -- Desecrated Ring
    },
    -- Dreamwalker Stompers
    ["236217"] = {
        236248, -- Desecrated Boots
    },
    -- Dreamwalker Vest
    ["236218"] = {
        236251, -- Desecrated Tunic
    },
    -- Harbinger of Doom
    ["236219"] = {
        23044, -- Harbinger of Doom
    },
    -- Necro-Knight's Garb
    ["236220"] = {
        23069, -- Necro-Knight's Garb
    },
    -- Misplaced Servo Arm
    ["236221"] = {
        23221, -- Misplaced Servo Arm
    },
    -- Ghoul Skin Tunic
    ["236222"] = {
        23226, -- Ghoul Skin Tunic
    },
    -- Ring of the Eternal Flame
    ["236223"] = {
        23237, -- Ring of the Eternal Flame
    },
    -- Stygian Buckler
    ["236224"] = {
        23238, -- Stygian Buckler
    },
    -- Girdle of Elemental Fury
    ["236225"] = {
        23663, -- Girdle of Elemental Fury
    },
    -- Pauldrons of Elemental Fury
    ["236226"] = {
        23664, -- Pauldrons of Elemental Fury
    },
    -- Belt of the Grand Crusader
    ["236227"] = {
        23666, -- Belt of the Grand Crusader
    },
    -- Spaulders of the Grand Crusader
    ["236228"] = {
        23667, -- Spaulders of the Grand Crusader
    },
    -- Leggings of the Grand Crusader
    ["236229"] = {
        23668, -- Leggings of the Grand Crusader
    },
    -- Leggings of Elemental Fury
    ["236230"] = {
        23665, -- Leggings of Elemental Fury
    },
    -- Desecrated Breastplate
    ["236231"] = {
        22349, -- Desecrated Breastplate
        236005, -- Dreadnaught Breastplate
        236014, -- Dreadnaught Cuirass
        236043, -- Cryptstalker Tunic
        236058, -- Cryptstalker Breastplate
        236081, -- Frostfire Robe
        236095, -- Frostfire Garb
    },
    -- Desecrated Waistguard
    ["236232"] = {
        22356, -- Desecrated Waistguard
        236011, -- Dreadnaught Waistguard
        236020, -- Dreadnaught Belt
        236048, -- Cryptstalker Girdle
        236051, -- Cryptstalker Belt
        236078, -- Frostfire Belt
        236088, -- Frostfire Waistguard
    },
    -- Desecrated Gauntlets
    ["236233"] = {
        22357, -- Desecrated Gauntlets
        236010, -- Dreadnaught Gauntlets
        236019, -- Dreadnaught Grips
        236047, -- Cryptstalker Handguards
        236055, -- Cryptstalker Gauntlets
        236082, -- Frostfire Gloves
        236092, -- Frostfire Mitts
    },
    -- Desecrated Sabatons
    ["236234"] = {
        22358, -- Desecrated Sabatons
        236009, -- Dreadnaught Sabatons
        236018, -- Dreadnaught Greaves
        236049, -- Cryptstalker Boots
        236057, -- Cryptstalker Greaves
        236080, -- Frostfire Sandals
        236094, -- Frostfire Boots
    },
    -- Desecrated Bracers
    ["236235"] = {
        22355, -- Desecrated Bracers
        236012, -- Dreadnaught Bracers
        236021, -- Dreadnaught Wrists
        236042, -- Cryptstalker Wristguards
        236050, -- Cryptstalker Vambraces
        236077, -- Frostfire Bindings
        236087, -- Frostfire Wristwraps
    },
    -- Desecrated Helmet
    ["236236"] = {
        22353, -- Desecrated Helmet
        236007, -- Dreadnaught Helmet
        236016, -- Dreadnaught Horns
        236046, -- Cryptstalker Headpiece
        236054, -- Cryptstalker Visor
        236083, -- Frostfire Circlet
        236091, -- Frostfire Hood
    },
    -- Desecrated Pauldrons
    ["236237"] = {
        22354, -- Desecrated Pauldrons
        236008, -- Dreadnaught Pauldrons
        236017, -- Dreadnaught Shoulders
        236044, -- Cryptstalker Spaulders
        236052, -- Cryptstalker Pauldrons
        236084, -- Frostfire Shoulderpads
        236089, -- Frostfire Mantle
    },
    -- Desecrated Legplates
    ["236238"] = {
        22352, -- Desecrated Legplates
        236006, -- Dreadnaught Legplates
        236015, -- Dreadnaught Tassets
        236045, -- Cryptstalker Legguards
        236053, -- Cryptstalker Leggings
        236079, -- Frostfire Leggings
        236090, -- Frostfire Pants
    },
    -- Desecrated Sandals
    ["236239"] = {
        22372, -- Desecrated Sandals
        236027, -- Bonescythe Sabatons
        236033, -- Bonescythe Treads
        236059, -- Plagueheart Sandals
        236075, -- Plagueheart Boots
        236099, -- Sandals of Faith
        236113, -- Boots of Faith
    },
    -- Desecrated Shoulderpads
    ["236240"] = {
        22368, -- Desecrated Shoulderpads
        236026, -- Bonescythe Pauldrons
        236035, -- Bonescythe Mantle
        236065, -- Plagueheart Shoulderpads
        236070, -- Plagueheart Mantle
        236102, -- Shoulderpads of Faith
        236108, -- Mantle of Faith
    },
    -- Desecrated Circlet
    ["236241"] = {
        22367, -- Desecrated Circlet
        236025, -- Bonescythe Helmet
        236037, -- Bonescythe Mask
        236064, -- Plagueheart Circlet
        236072, -- Plagueheart Crown
        236103, -- Circlet of Faith
    },
    -- Desecrated Robe
    ["236242"] = {
        22351, -- Desecrated Robe
        236023, -- Bonescythe Breastplate
        236039, -- Bonescythe Chestguard
        236062, -- Plagueheart Robe
        236076, -- Plagueheart Garb
        236097, -- Robe of Faith
        236114, -- Garb of Faith
    },
    -- Desecrated Gloves
    ["236243"] = {
        22371, -- Desecrated Gloves
        236028, -- Bonescythe Gauntlets
        236038, -- Bonescythe Grips
        236063, -- Plagueheart Gloves
        236073, -- Plagueheart Handguards
        236104, -- Gloves of Faith
        236111, -- Hands of Faith
    },
    -- Desecrated Belt
    ["236244"] = {
        22370, -- Desecrated Belt
        236029, -- Bonescythe Waistguard
        236032, -- Bonescythe Belt
        236066, -- Plagueheart Belt
        236069, -- Plagueheart Waistguard
        236098, -- Belt of Faith
        236107, -- Girdle of Faith
    },
    -- Desecrated Bindings
    ["236245"] = {
        22369, -- Desecrated Bindings
        236030, -- Bonescythe Bracers
        236040, -- Bonescythe Wristguards
        236061, -- Plagueheart Bindings
        236068, -- Plagueheart Wristguards
        236100, -- Bindings of Faith
        236106, -- Wrists of Faith
    },
    -- Desecrated Leggings
    ["236246"] = {
        22366, -- Desecrated Leggings
        236024, -- Bonescythe Legplates
        236036, -- Bonescythe Leggings
        236060, -- Plagueheart Leggings
        236071, -- Plagueheart Pants
        236101, -- Leggings of Faith
        236109, -- Pants of Faith
    },
    -- Desecrated Wristguards
    ["236247"] = {
        22362, -- Desecrated Wristguards
        236119, -- Redemption Wristguards
        236124, -- Redemption Vambraces
        236133, -- Redemption Bracers
        236149, -- Earthshatter Wristguards
        236151, -- Earthshatter Bindings
        236160, -- Earthshatter Bracers
        236170, -- Earthshatter Vambraces
        236183, -- Dreamwalker Wristguards
        236192, -- Dreamwalker Bindings
        236201, -- Dreamwalker Bracers
        236210, -- Dreamwalker Wraps
    },
    -- Desecrated Boots
    ["236248"] = {
        22365, -- Desecrated Boots
        236123, -- Redemption Boots
        236131, -- Redemption Greaves
        236140, -- Redemption Sabatons
        236146, -- Earthshatter Boots
        236158, -- Earthshatter Greaves
        236168, -- Earthshatter Sabatons
        236177, -- Earthshatter Treads
        236185, -- Dreamwalker Boots
        236199, -- Dreamwalker Sandals
        236208, -- Dreamwalker Sabatons
        236217, -- Dreamwalker Stompers
    },
    -- Desecrated Headpiece
    ["236249"] = {
        22360, -- Desecrated Headpiece
        236117, -- Redemption Headpiece
        236128, -- Redemption Helmet
        236137, -- Redemption Crown
        236144, -- Earthshatter Headpiece
        236155, -- Earthshatter Crown
        236165, -- Earthshatter Faceguard
        236174, -- Earthshatter Helmet
        236182, -- Dreamwalker Headpiece
        236205, -- Dreamwalker Headdress
        236214, -- Dreamwalker Cowl
    },
    -- Desecrated Handguards
    ["236250"] = {
        22364, -- Desecrated Handguards
        236118, -- Redemption Handguards
        236129, -- Redemption Gloves
        236138, -- Redemption Gauntlets
        236142, -- Earthshatter Handguards
        236156, -- Earthshatter Mitts
        236166, -- Earthshatter Gloves
        236175, -- Earthshatter Grips
        236184, -- Dreamwalker Handguards
        236197, -- Dreamwalker Mitts
        236206, -- Dreamwalker Gauntlets
        236215, -- Dreamwalker Grips
    },
    -- Desecrated Tunic
    ["236251"] = {
        22350, -- Desecrated Tunic
        236115, -- Redemption Tunic
        236132, -- Redemption Breastplate
        236141, -- Redemption Chestguard
        236147, -- Earthshatter Tunic
        236159, -- Earthshatter Embrace
        236169, -- Earthshatter Chestguard
        236179, -- Earthshatter Armor
        236186, -- Dreamwalker Tunic
        236200, -- Dreamwalker Leathers
        236209, -- Dreamwalker Armor
        236218, -- Dreamwalker Vest
    },
    -- Desecrated Girdle
    ["236252"] = {
        22363, -- Desecrated Girdle
        236120, -- Redemption Girdle
        236125, -- Redemption Belt
        236134, -- Redemption Waistguard
        236148, -- Earthshatter Girdle
        236152, -- Earthshatter Cord
        236162, -- Earthshatter Waistguard
        236171, -- Earthshatter Belt
        236187, -- Dreamwalker Girdle
        236193, -- Dreamwalker Cord
        236202, -- Dreamwalker Waistguard
        236211, -- Dreamwalker Sash
    },
    -- Desecrated Legguards
    ["236253"] = {
        22359, -- Desecrated Legguards
        236121, -- Redemption Legguards
        236127, -- Redemption Leggings
        236136, -- Redemption Legplates
        236143, -- Earthshatter Legguards
        236154, -- Earthshatter Kilt
        236164, -- Earthshatter Legplates
        236173, -- Earthshatter Leggings
        236188, -- Dreamwalker Legguards
        236195, -- Dreamwalker Kilt
        236204, -- Dreamwalker Leggings
        236213, -- Dreamwalker Trousers
    },
    -- Desecrated Spaulders
    ["236254"] = {
        22361, -- Desecrated Spaulders
        236122, -- Redemption Spaulders
        236126, -- Redemption Shoulderplates
        236135, -- Redemption Pauldrons
        236145, -- Earthshatter Spaulders
        236153, -- Earthshatter Mantle
        236163, -- Earthshatter Pauldrons
        236172, -- Earthshatter Epaulets
        236189, -- Dreamwalker Spaulders
        236194, -- Dreamwalker Mantle
        236203, -- Dreamwalker Pauldrons
        236212, -- Dreamwalker Shoulderpads
    },
    -- Wristguards of Vengeance
    ["236255"] = {
        22936, -- Wristguards of Vengeance
    },
    -- Touch of Frost
    ["236256"] = {
        22935, -- Touch of Frost
    },
    -- Gem of Nerubis
    ["236257"] = {
        22937, -- Gem of Nerubis
    },
    -- Cryptfiend Silk Cloak
    ["236258"] = {
        22938, -- Cryptfiend Silk Cloak
    },
    -- Band of Unanswered Prayers
    ["236259"] = {
        22939, -- Band of Unanswered Prayers
    },
    -- Icebane Pauldrons
    ["236260"] = {
        22940, -- Icebane Pauldrons
    },
    -- Malice Stone Pendant
    ["236261"] = {
        22943, -- Malice Stone Pendant
    },
    -- Polar Shoulder Pads
    ["236262"] = {
        22941, -- Polar Shoulder Pads
    },
    -- Widow's Remorse
    ["236263"] = {
        22806, -- Widow's Remorse
    },
    -- The Widow's Embrace
    ["236264"] = {
        22942, -- The Widow's Embrace
    },
    -- Wraith Blade
    ["236265"] = {
        22807, -- Wraith Blade
    },
    -- Pendant of Forgotten Names
    ["236266"] = {
        22947, -- Pendant of Forgotten Names
    },
    -- Crystal Webbed Robe
    ["236267"] = {
        23220, -- Crystal Webbed Robe
    },
    -- Kiss of the Spider
    ["236268"] = {
        22954, -- Kiss of the Spider
    },
    -- Maexxna's Fang
    ["236269"] = {
        22804, -- Maexxna's Fang
    },
    -- Hatchet of Sundered Bone
    ["236270"] = {
        22816, -- Hatchet of Sundered Bone
    },
    -- Libram of Light
    ["236271"] = {
        23006, -- Libram of Light
    },
    -- Cloak of the Scourge
    ["236272"] = {
        23030, -- Cloak of the Scourge
    },
    -- Band of the Inevitable
    ["236273"] = {
        23031, -- Band of the Inevitable
    },
    -- Hailstone Band
    ["236274"] = {
        23028, -- Hailstone Band
    },
    -- Noth's Frigid Heart
    ["236275"] = {
        23029, -- Noth's Frigid Heart
    },
    -- Totem of Flowing Water
    ["236276"] = {
        23005, -- Totem of Flowing Water
    },
    -- Necklace of Necropsy
    ["236277"] = {
        23036, -- Necklace of Necropsy
    },
    -- Glacial Headdress
    ["236278"] = {
        23032, -- Glacial Headdress
    },
    -- Preceptor's Hat
    ["236279"] = {
        23035, -- Preceptor's Hat
    },
    -- Legplates of Carnage
    ["236280"] = {
        23068, -- Legplates of Carnage
    },
    -- Icy Scale Coif
    ["236281"] = {
        23033, -- Icy Scale Coif
    },
    -- Loatheb's Reflection
    ["236282"] = {
        23042, -- Loatheb's Reflection
    },
    -- Ring of Spiritual Fervor
    ["236283"] = {
        23037, -- Ring of Spiritual Fervor
    },
    -- Brimstone Staff
    ["236284"] = {
        22800, -- Brimstone Staff
    },
    -- The Eye of Nerub
    ["236285"] = {
        23039, -- The Eye of Nerub
    },
    -- Band of Unnatural Forces
    ["236286"] = {
        23038, -- Band of Unnatural Forces
    },
    -- Severance
    ["236287"] = {
        22815, -- Severance
    },
    -- The Plague Bearer
    ["236288"] = {
        22818, -- The Plague Bearer
    },
    -- Cloak of Suturing
    ["236289"] = {
        22960, -- Cloak of Suturing
    },
    -- Wand of Fates
    ["236290"] = {
        22820, -- Wand of Fates
    },
    -- Band of Reanimation
    ["236291"] = {
        22961, -- Band of Reanimation
    },
    -- Midnight Haze
    ["236292"] = {
        22803, -- Midnight Haze
    },
    -- Toxin Injector
    ["236293"] = {
        22810, -- Toxin Injector
    },
    -- Icy Scale Spaulders
    ["236294"] = {
        22967, -- Icy Scale Spaulders
    },
    -- Glacial Mantle
    ["236295"] = {
        22968, -- Glacial Mantle
    },
    -- Death's Bargain
    ["236296"] = {
        23075, -- Death's Bargain
    },
    -- The End of Dreams
    ["236297"] = {
        22988, -- The End of Dreams
    },
    -- Rime Covered Mantle
    ["236298"] = {
        22983, -- Rime Covered Mantle
    },
    -- Claymore of Unholy Might
    ["236299"] = {
        22813, -- Claymore of Unholy Might
    },
    -- Gluth's Missing Collar
    ["236300"] = {
        22981, -- Gluth's Missing Collar
    },
    -- Digested Hand of Power
    ["236301"] = {
        22994, -- Digested Hand of Power
    },
    -- Eye of Diminution
    ["236302"] = {
        23001, -- Eye of Diminution
    },
    -- Leggings of Polarity
    ["236303"] = {
        23070, -- Leggings of Polarity
    },
    -- Plated Abomination Ribcage
    ["236304"] = {
        23000, -- Plated Abomination Ribcage
    },
    -- Spire of Twilight
    ["236305"] = {
        22801, -- Spire of Twilight
    },
    -- The Castigator
    ["236306"] = {
        22808, -- The Castigator
    },
    -- Veil of Eclipse
    ["236307"] = {
        23017, -- Veil of Eclipse
    },
    -- Idol of Longevity
    ["236308"] = {
        23004, -- Idol of Longevity
    },
    -- Girdle of the Mentor
    ["236309"] = {
        23219, -- Girdle of the Mentor
    },
    -- Wand of the Whispering Dead
    ["236310"] = {
        23009, -- Wand of the Whispering Dead
    },
    -- Signet of the Fallen Defender
    ["236311"] = {
        23018, -- Signet of the Fallen Defender
    },
    -- Iblis, Blade of the Fallen Seraph
    ["236312"] = {
        23014, -- Iblis, Blade of the Fallen Seraph
    },
    -- The Soul Harvester's Bindings
    ["236313"] = {
        23021, -- The Soul Harvester's Bindings
    },
    -- Boots of Displacement
    ["236314"] = {
        23073, -- Boots of Displacement
    },
    -- Polar Helmet
    ["236315"] = {
        23020, -- Polar Helmet
    },
    -- Sadist's Collar
    ["236316"] = {
        23023, -- Sadist's Collar
    },
    -- Corrupted Ashbringer
    ["236317"] = {
        22691, -- Corrupted Ashbringer
    },
    -- Seal of the Damned
    ["236318"] = {
        23025, -- Seal of the Damned
    },
    -- Leggings of Apocalypse
    ["236319"] = {
        23071, -- Leggings of Apocalypse
    },
    -- Warmth of Forgiveness
    ["236320"] = {
        23027, -- Warmth of Forgiveness
    },
    -- Maul of the Redeemed Crusader
    ["236321"] = {
        22809, -- Maul of the Redeemed Crusader
    },
    -- Soulstring
    ["236322"] = {
        22811, -- Soulstring
    },
    -- Resilience of the Scourge
    ["236323"] = {
        23547, -- Resilience of the Scourge
    },
    -- Power of the Scourge
    ["236324"] = {
        23545, -- Power of the Scourge
    },
    -- Fortitude of the Scourge
    ["236325"] = {
        23549, -- Fortitude of the Scourge
    },
    -- Might of the Scourge
    ["236326"] = {
        23548, -- Might of the Scourge
    },
    -- Cloak of the Necropolis
    ["236327"] = {
        23050, -- Cloak of the Necropolis
    },
    -- Sapphiron's Left Eye
    ["236328"] = {
        23049, -- Sapphiron's Left Eye
    },
    -- Eye of the Dead
    ["236329"] = {
        23047, -- Eye of the Dead
    },
    -- Sapphiron's Right Eye
    ["236330"] = {
        23048, -- Sapphiron's Right Eye
    },
    -- The Restrained Essence of Sapphiron
    ["236331"] = {
        23046, -- The Restrained Essence of Sapphiron
    },
    -- Shroud of Dominion
    ["236333"] = {
        23045, -- Shroud of Dominion
    },
    -- Slayer's Crest
    ["236334"] = {
        23041, -- Slayer's Crest
    },
    -- Fists of the Unrelenting
    ["236335"] = {
        23072, -- Fists of the Unrelenting
    },
    -- The Face of Death
    ["236336"] = {
        23043, -- The Face of Death
    },
    -- Glyph of Deflection
    ["236337"] = {
        23040, -- Glyph of Deflection
    },
    -- Claw of the Frost Wyrm
    ["236338"] = {
        23242, -- Claw of the Frost Wyrm
    },
    -- Gressil, Dawn of Ruin
    ["236339"] = {
        23054, -- Gressil, Dawn of Ruin
    },
    -- Might of Menethil
    ["236340"] = {
        22798, -- Might of Menethil
    },
    -- The Hungering Cold
    ["236341"] = {
        23577, -- The Hungering Cold
    },
    -- Stormrage's Talisman of Seething
    ["236342"] = {
        23053, -- Stormrage's Talisman of Seething
    },
    -- Kingsfall
    ["236343"] = {
        22802, -- Kingsfall
    },
    -- Nerubian Slavemaker
    ["236344"] = {
        22812, -- Nerubian Slavemaker
    },
    -- Gem of Trapped Innocents
    ["236345"] = {
        23057, -- Gem of Trapped Innocents
    },
    -- Soulseeker
    ["236346"] = {
        22799, -- Soulseeker
    },
    -- Shield of Condemnation
    ["236347"] = {
        22819, -- Shield of Condemnation
    },
    -- Hammer of the Twisting Nether
    ["236348"] = {
        23056, -- Hammer of the Twisting Nether
    },
    -- Doomfinger
    ["236349"] = {
        22821, -- Doomfinger
    },
    -- The Phylactery of Kel'Thuzad
    ["236350"] = {
        22520, -- The Phylactery of Kel'Thuzad
        236351, -- Mark of the Champion
        236352, -- Mark of the Champion
    },
    -- Mark of the Champion
    ["236351"] = {
        23206, -- Mark of the Champion
        23207, -- Mark of the Champion
    },
    -- Mark of the Champion
    ["236352"] = {
        236350, -- The Phylactery of Kel'Thuzad
    },
    -- Atiesh, Greatstaff of the Guardian (Warlock)
    ["236398"] = {
        22726, -- Splinter of Atiesh
    },
    -- Atiesh, Greatstaff of the Guardian (Priest)
    ["236399"] = {
        22726, -- Splinter of Atiesh
    },
    -- Atiesh, Greatstaff of the Guardian (Mage)
    ["236400"] = {
        22726, -- Splinter of Atiesh
    },
    -- Atiesh, Greatstaff of the Guardian (Druid)
    ["236401"] = {
        22726, -- Splinter of Atiesh
    },
    -- Frozen Rune
    ["236656"] = {
        22682, -- Frozen Rune
    },
    -- Glacial Cloak
    ["236690"] = {
        22658, -- Glacial Cloak
    },
    -- Glacial Gloves
    ["236692"] = {
        22654, -- Glacial Gloves
    },
    -- Glacial Wrists
    ["236693"] = {
        22655, -- Glacial Wrists
    },
    -- Glacial Vest
    ["236694"] = {
        22652, -- Glacial Vest
    },
    -- Icebane Breastplate
    ["236695"] = {
        22669, -- Icebane Breastplate
    },
    -- Icebane Bracers
    ["236696"] = {
        22671, -- Icebane Bracers
    },
    -- Icebane Gauntlets
    ["236697"] = {
        22670, -- Icebane Gauntlets
    },
    -- Icy Scale Bracers
    ["236698"] = {
        22665, -- Icy Scale Bracers
    },
    -- Icy Scale Breastplate
    ["236699"] = {
        22664, -- Icy Scale Breastplate
    },
    -- Icy Scale Gauntlets
    ["236700"] = {
        22666, -- Icy Scale Gauntlets
    },
    -- Polar Bracers
    ["236701"] = {
        22663, -- Polar Bracers
    },
    -- Polar Tunic
    ["236702"] = {
        22661, -- Polar Tunic
    },
    -- Polar Gloves
    ["236703"] = {
        22662, -- Polar Gloves
    },
    -- Tunic of Undead Slaying
    ["236707"] = {
        23089, -- Tunic of Undead Slaying
    },
    -- Breastplate of Undead Slaying
    ["236708"] = {
        23087, -- Breastplate of Undead Slaying
    },
    -- Chestguard of Undead Slaying
    ["236709"] = {
        23088, -- Chestguard of Undead Slaying
    },
    -- Wristguards of Undead Slaying
    ["236710"] = {
        23092, -- Wristguards of Undead Slaying
    },
    -- Wristwraps of Undead Slaying
    ["236711"] = {
        23093, -- Wristwraps of Undead Slaying
    },
    -- Bracers of Undead Slaying
    ["236712"] = {
        23090, -- Bracers of Undead Slaying
    },
    -- Handwraps of Undead Slaying
    ["236713"] = {
        23081, -- Handwraps of Undead Slaying
    },
    -- Gauntlets of Undead Slaying
    ["236714"] = {
        23078, -- Gauntlets of Undead Slaying
    },
    -- Handguards of Undead Slaying
    ["236715"] = {
        23082, -- Handguards of Undead Slaying
    },
    -- Bracers of Undead Cleansing
    ["236716"] = {
        23091, -- Bracers of Undead Cleansing
    },
    -- Gloves of Undead Cleansing
    ["236717"] = {
        23084, -- Gloves of Undead Cleansing
    },
    -- Robe of Undead Cleansing
    ["236718"] = {
        23085, -- Robe of Undead Cleansing
    },
    -- Icebane Helmet
    ["237275"] = {
        23019, -- Icebane Helmet
    },
    -- The Purifier
    ["237278"] = {
        22656, -- The Purifier
    },
    -- Amulet of the Dawn
    ["237279"] = {
        22657, -- Amulet of the Dawn
    },
    -- Medallion of the Dawn
    ["237280"] = {
        22659, -- Medallion of the Dawn
    },
    -- Bracers of Hope
    ["237281"] = {
        22667, -- Bracers of Hope
    },
    -- Bracers of Subterfuge
    ["237282"] = {
        22668, -- Bracers of Subterfuge
    },
    -- Talisman of Ascendance
    ["237283"] = {
        22678, -- Talisman of Ascendance
    },
    -- Band of Resolution
    ["237285"] = {
        22680, -- Band of Resolution
    },
    -- Band of Piety
    ["237286"] = {
        22681, -- Band of Piety
    },
    -- Verimonde's Last Resort
    ["237287"] = {
        22688, -- Verimonde's Last Resort
    },
    -- Sanctified Leather Helm
    ["237288"] = {
        22689, -- Sanctified Leather Helm
    },
    -- Leggings of the Plague Hunter
    ["237289"] = {
        22690, -- Leggings of the Plague Hunter
    },
    -- Icebane Leggings
    ["237290"] = {
        22699, -- Icebane Leggings
    },
    -- Glacial Leggings
    ["237291"] = {
        22700, -- Glacial Leggings
    },
    -- Polar Leggings
    ["237292"] = {
        22701, -- Polar Leggings
    },
    -- Icy Scale Leggings
    ["237293"] = {
        22702, -- Icy Scale Leggings
    },
    -- Ramaladni's Icy Grasp
    ["237294"] = {
        22707, -- Ramaladni's Icy Grasp
    },
    -- Desecrated Ring
    ["237381"] = {
        236013, -- Ring of the Dreadnaught
        236022, -- Band of the Dreadnaught
        236031, -- Bonescythe Ring
        236034, -- Bonescythe Band
        236041, -- Ring of the Cryptstalker
        236056, -- Band of the Cryptstalker
        236067, -- Plagueheart Ring
        236074, -- Plagueheart Loop
        236085, -- Frostfire Ring
        236093, -- Frostfire Band
        236105, -- Ring of Faith
        236112, -- Band of Faith
        236116, -- Ring of Redemption
        236130, -- Band of Redemption
        236139, -- Loop of Redemption
        236190, -- Ring of the Dreamwalker
        236198, -- Band of the Dreamwalker
        236207, -- Loop of the Dreamwalker
        236216, -- Signet of the Dreamwalker
    },
};