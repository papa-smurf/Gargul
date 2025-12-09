---@type GL
local _, GL = ...;

---@class NormalModeHardModeLinks : Data
GL.Data = GL.Data or {};

local NormalModeHardModeLinks = {
    -- Cobra-Lash Boots
    [30104] = 33482,
    -- Gladiator's Felweave Amice
    [30186] = 42718,
    -- Gladiator's Felweave Cowl
    [30187] = 42719,
    -- Gladiator's Felweave Handguards
    [30188] = 42720,
    -- Gladiator's Felweave Raiment
    [30200] = 42721,
    -- Gladiator's Felweave Trousers
    [30201] = 42722,
    -- Reckless Fire Opal
    [30547] = 30551,
    -- Shifting Tanzanite
    [30549] = 30574,
    -- Misty Chrysoprase
    [30550] = 30560,
    -- Glinting Tanzanite
    [30553] = 30556,
    -- Stalwart Fire Opal
    [30554] = 30558,
    -- Nimble Chrysoprase
    [30575] = 30605,
    -- Potent Fire Opal
    [30588] = 30593,
    -- Steady Chrysoprase
    [30592] = 30601,
    -- Gladiator's Kodohide Gloves
    [31375] = 42680,
    -- Gladiator's Kodohide Helm
    [31376] = 42681,
    -- Gladiator's Kodohide Legguards
    [31377] = 42682,
    -- Gladiator's Kodohide Spaulders
    [31378] = 42683,
    -- Gladiator's Ringmail Armor
    [31396] = 42664,
    -- Gladiator's Ringmail Gauntlets
    [31397] = 42665,
    -- Gladiator's Ringmail Helm
    [31400] = 42666,
    -- Gladiator's Ringmail Leggings
    [31406] = 42667,
    -- Gladiator's Ringmail Spaulders
    [31407] = 42668,
    -- Gladiator's Mooncloth Gloves
    [31409] = 42703,
    -- Gladiator's Mooncloth Hood
    [31410] = 42704,
    -- Gladiator's Mooncloth Leggings
    [31411] = 42705,
    -- Gladiator's Mooncloth Mantle
    [31412] = 42706,
    -- Gladiator's Mooncloth Robe
    [31413] = 42707,
    -- Gladiator's Ornamented Chestguard
    [31613] = 42635,
    -- Gladiator's Ornamented Gloves
    [31614] = 42636,
    -- Gladiator's Ornamented Headcover
    [31616] = 42637,
    -- Gladiator's Ornamented Legplates
    [31618] = 42638,
    -- Gladiator's Ornamented Spaulders
    [31619] = 42639,
    -- Reins of the Cobalt Riding Talbuk
    [31829] = 31830,
    -- Reins of the Silver Riding Talbuk
    [31831] = 31832,
    -- Reins of the Tan Riding Talbuk
    [31833] = 31834,
    -- Reins of the White Riding Talbuk
    [31835] = 31836,
    -- Teardrop Crimson Spinel
    [32195] = 35489,
    -- Runed Crimson Spinel
    [32196] = 35488,
    -- Bright Crimson Spinel
    [32197] = 35487,
    -- Subtle Lionseye
    [32198] = 32208,
    -- Sparkling Empyrean Sapphire
    [32201] = 32202,
    -- Smooth Lionseye
    [32205] = 32207,
    -- Rigid Empyrean Sapphire
    [32206] = 32210,
    -- Shifting Shadowsong Amethyst
    [32212] = 32213,
    -- Glinting Shadowsong Amethyst
    [32214] = 32220,
    -- Design: Delicate Crimson Spinel
    [32277] = 32283,
    -- Design: Subtle Lionseye
    [32284] = 32294,
    -- Design: Sparkling Empyrean Sapphire
    [32287] = 32288,
    -- Design: Smooth Lionseye
    [32291] = 32293,
    -- Design: Rigid Empyrean Sapphire
    [32292] = 32296,
    -- Design: Shifting Shadowsong Amethyst
    [32298] = 32299,
    -- Design: Glinting Shadowsong Amethyst
    [32300] = 32306,
    -- Design: Purified Shadowsong Amethyst
    [32302] = 32311,
    -- Magtheridon's Head
    [32385] = 32386,
    -- Bland Blade
    [32466] = 90118,
    -- Plans: Swiftsteel Bracers
    [32736] = 35531,
    -- Plans: Swiftsteel Shoulders
    [32737] = 35532,
    -- Plans: Dawnsteel Bracers
    [32738] = 35529,
    -- Plans: Dawnsteel Shoulders
    [32739] = 35530,
    -- Pattern: Bracers of Renewed Life
    [32744] = 35519,
    -- Pattern: Shoulderpads of Renewed Life
    [32745] = 35523,
    -- Pattern: Swiftstrike Bracers
    [32746] = 35527,
    -- Pattern: Swiftstrike Shoulders
    [32747] = 35528,
    -- Pattern: Bindings of Lightning Reflexes
    [32748] = 35517,
    -- Pattern: Shoulders of Lightning Reflexes
    [32749] = 35524,
    -- Pattern: Living Earth Bindings
    [32750] = 35520,
    -- Pattern: Living Earth Shoulders
    [32751] = 35521,
    -- Pattern: Swiftheal Wraps
    [32752] = 35526,
    -- Pattern: Swiftheal Mantle
    [32753] = 35525,
    -- Pattern: Bracers of Nimble Thought
    [32754] = 35518,
    -- Pattern: Mantle of Nimble Thought
    [32755] = 35522,
    -- Warglaive of Azzinoth
    [32837] = 32838,
    -- Rigid Bladestone
    [33142] = 33141,
    -- Battlemaster's Determination
    [33832] = 34578,
    -- Battlemaster's Audacity
    [34049] = 34579,
    -- Battlemaster's Perseverance
    [34050] = 34580,
    -- The Horseman's Signet Ring
    [34073] = 33958,
    -- Witches Band
    [34074] = 33957,
    -- Ring of Ghoulish Delight
    [34075] = 33959,
    -- Battlemaster's Depravity
    [34162] = 34577,
    -- Battlemaster's Cruelty
    [34163] = 34576,
    -- Design: Loop of Forged Power
    [35198] = 35536,
    -- Design: Ring of Flowing Life
    [35199] = 35538,
    -- Design: Hard Khorium Band
    [35200] = 35534,
    -- Design: Pendant of Sunfire
    [35201] = 35537,
    -- Design: Amulet of Flowing Life
    [35202] = 35533,
    -- Design: Hard Khorium Choker
    [35203] = 35535,
    -- Pattern: Sunfire Handwraps
    [35204] = 35551,
    -- Pattern: Hands of Eternal Light
    [35205] = 35544,
    -- Pattern: Sunfire Robe
    [35206] = 35552,
    -- Pattern: Robe of Eternal Light
    [35207] = 35548,
    -- Plans: Sunblessed Gauntlets
    [35208] = 35556,
    -- Plans: Hard Khorium Battlefists
    [35209] = 35553,
    -- Plans: Sunblessed Breastplate
    [35210] = 35555,
    -- Plans: Hard Khorium Battleplate
    [35211] = 35554,
    -- Pattern: Leather Gauntlets of the Sun
    [35212] = 35546,
    -- Pattern: Fletcher's Gloves of the Phoenix
    [35213] = 35541,
    -- Pattern: Gloves of Immortal Dusk
    [35214] = 35542,
    -- Pattern: Sun-Drenched Scale Gloves
    [35215] = 35550,
    -- Pattern: Leather Chestguard of the Sun
    [35216] = 35545,
    -- Pattern: Embrace of the Phoenix
    [35217] = 35540,
    -- Pattern: Carapace of Sun and Shadow
    [35218] = 35539,
    -- Pattern: Sun-Drenched Scale Chestguard
    [35219] = 35549,
    -- X-51 Nether-Rocket X-TREME
    [35226] = 49286,
    -- Battlemaster's Alacrity
    [35326] = 35327,
    -- Reckless Pyrestone
    [35760] = 32219,
    -- Design: Quick Lionseye
    [35763] = 35768,
    -- Design: Steady Seaspray Emerald
    [35764] = 35766,
    -- Design: Forceful Seaspray Emerald
    [35765] = 35769,
    -- Dragonscale Leg Armor
    [38377] = 56550,
    -- Smooth Ornate Dawnstone
    [38550] = 38546,
    -- Big Battle Bear
    [38576] = 49282,
    -- Delicate Cardinal Ruby
    [40112] = 40114,
    -- Brilliant Cardinal Ruby
    [40113] = 40123,
    -- Subtle King's Amber
    [40115] = 40126,
    -- Sparkling Majestic Zircon
    [40120] = 40121,
    -- Smooth King's Amber
    [40124] = 40117,
    -- Shifting Dreadstone
    [40130] = 40136,
    -- Timeless Dreadstone
    [40132] = 40164,
    -- Regal Eye of Zul
    [40138] = 40167,
    -- Deadly Ametrine
    [40147] = 40156,
    -- Lucent Ametrine
    [40149] = 40158,
    -- Deft Ametrine
    [40150] = 40159,
    -- Stalwart Ametrine
    [40160] = 40161,
    -- Jagged Eye of Zul
    [40165] = 40140,
    -- Misty Eye of Zul
    [40171] = 40176,
    -- Lightning Eye of Zul
    [40172] = 40177,
    -- Turbid Eye of Zul
    [40173] = 40178,
    -- Energized Eye of Zul
    [40179] = 40174,
    -- Radiant Eye of Zul
    [40180] = 40181,
    -- Delicate Dragon's Eye
    [42143] = 36766,
    -- Sparkling Dragon's Eye
    [42145] = 42146,
    -- Brilliant Dragon's Eye
    [42148] = 42144,
    -- Smooth Dragon's Eye
    [42149] = 42153,
    -- Subtle Dragon's Eye
    [42151] = 42157,
    -- Furious Gladiator's Fleshslicer
    [42271] = 45963,
    -- Relentless Gladiator's Fleshslicer
    [42272] = 48432,
    -- Bonescythe Breastplate
    [43727] = 236023,
    -- Bonescythe Gauntlets
    [43728] = 236028,
    -- Bonescythe Helmet
    [43729] = 236025,
    -- Bonescythe Legplates
    [43730] = 236024,
    -- Bonescythe Pauldrons
    [43731] = 236026,
    -- Circlet of Faith
    [43732] = 236103,
    -- Crown of Faith
    [43733] = 236110,
    -- Cryptstalker Handguards
    [43734] = 236047,
    -- Cryptstalker Headpiece
    [43735] = 236046,
    -- Cryptstalker Legguards
    [43736] = 236045,
    -- Cryptstalker Spaulders
    [43737] = 236044,
    -- Cryptstalker Tunic
    [43738] = 236043,
    -- Dreadnaught Breastplate
    [43740] = 236005,
    -- Dreadnaught Gauntlets
    [43741] = 236010,
    -- Dreadnaught Helmet
    [43744] = 236007,
    -- Dreadnaught Legplates
    [43746] = 236006,
    -- Dreadnaught Pauldrons
    [43747] = 236008,
    -- Dreamwalker Handguards
    [43752] = 236184,
    -- Dreamwalker Headpiece
    [43754] = 236182,
    -- Dreamwalker Leggings
    [43755] = 236204,
    -- Dreamwalker Legguards
    [43756] = 236188,
    -- Dreamwalker Mantle
    [43757] = 236194,
    -- Dreamwalker Shoulderpads
    [43758] = 236212,
    -- Dreamwalker Spaulders
    [43759] = 236189,
    -- Dreamwalker Trousers
    [43760] = 236213,
    -- Earthshatter Chestguard
    [43762] = 236169,
    -- Earthshatter Faceguard
    [43763] = 236165,
    -- Earthshatter Gloves
    [43764] = 236166,
    -- Earthshatter Grips
    [43765] = 236175,
    -- Earthshatter Handguards
    [43766] = 236142,
    -- Earthshatter Headpiece
    [43768] = 236144,
    -- Earthshatter Kilt
    [43770] = 236154,
    -- Earthshatter Legguards
    [43771] = 236143,
    -- Earthshatter Spaulders
    [43774] = 236145,
    -- Earthshatter Tunic
    [43775] = 236147,
    -- Frostfire Circlet
    [43777] = 236083,
    -- Frostfire Gloves
    [43778] = 236082,
    -- Frostfire Leggings
    [43779] = 236079,
    -- Frostfire Robe
    [43780] = 236081,
    -- Frostfire Shoulderpads
    [43781] = 236084,
    -- Gloves of Faith
    [43782] = 236104,
    -- Leggings of Faith
    [43784] = 236101,
    -- Mantle of Faith
    [43785] = 236108,
    -- Pants of Faith
    [43786] = 236109,
    -- Plagueheart Circlet
    [43787] = 236064,
    -- Plagueheart Gloves
    [43788] = 236063,
    -- Plagueheart Leggings
    [43789] = 236060,
    -- Plagueheart Robe
    [43790] = 236062,
    -- Plagueheart Shoulderpads
    [43791] = 236065,
    -- Redemption Breastplate
    [43793] = 236132,
    -- Redemption Gauntlets
    [43796] = 236138,
    -- Redemption Gloves
    [43797] = 236129,
    -- Redemption Greaves
    [43798] = 236131,
    -- Redemption Handguards
    [43799] = 236118,
    -- Redemption Headpiece
    [43800] = 236117,
    -- Redemption Legguards
    [43802] = 236121,
    -- Redemption Legplates
    [43803] = 236136,
    -- Redemption Shoulderplates
    [43805] = 236126,
    -- Redemption Spaulders
    [43806] = 236122,
    -- Redemption Tunic
    [43807] = 236115,
    -- Robe of Faith
    [43808] = 236097,
    -- Shoulderpads of Faith
    [43810] = 236102,
    -- Reins of the Black War Mammoth
    [43956] = 44077,
    -- Reins of the Ice Mammoth
    [43958] = 44080,
    -- Reins of the Grand Ice Mammoth
    [43961] = 44086,
    -- Frenzyheart Insignia of Fury
    [44073] = 44869,
    -- Oracle Talisman of Ablution
    [44074] = 44870,
    -- Reins of the Grand Black War Mammoth
    [44083] = 43959,
    -- Arcanum of Torment
    [44149] = 50367,
    -- Arcanum of the Stalwart Protector
    [44150] = 50369,
    -- Arcanum of Blissful Mending
    [44152] = 50370,
    -- Arcanum of Burning Mysteries
    [44159] = 50368,
    -- Reins of the Black War Bear
    [44223] = 44224,
    -- Reins of the Armored Brown Bear
    [44225] = 44226,
    -- Reins of the Wooly Mammoth
    [44230] = 44231,
    -- Reins of the Traveler's Tundra Mammoth
    [44234] = 44235,
    -- Key to the Focusing Iris
    [44569] = 44582,
    -- Heroic Key to the Focusing Iris
    [44577] = 44581,
    -- Archivum Data Disc
    [45506] = 45857,
    -- Brilliant Stormjewel
    [45882] = 45883,
    -- Reply-Code Alpha
    [46052] = 46053,
    -- Aegis Legguards
    [46222] = 46223,
    -- Swift Purple Raptor
    [46743] = 46760,
    -- Swift Moonsaber
    [46744] = 46759,
    -- Great Red Elekk
    [46745] = 46756,
    -- White Skeletal Warhorse
    [46746] = 46764,
    -- Turbostrider
    [46747] = 46763,
    -- Swift Violet Ram
    [46748] = 46762,
    -- Swift Burgundy Wolf
    [46749] = 46757,
    -- Great Golden Kodo
    [46750] = 46755,
    -- Swift Red Hawkstrider
    [46751] = 46761,
    -- Swift Gray Steed
    [46752] = 46758,
    -- Crystal Plated Vanguard
    [46964] = 46963,
    -- Breastplate of Cruel Intent
    [46965] = 46960,
    -- Band of the Violent Temperment
    [46966] = 46959,
    -- Boneshatter Armplates
    [46967] = 46961,
    -- Chestplate of the Towering Monstrosity
    [46968] = 46962,
    -- Steel Bladebreaker
    [46969] = 46958,
    -- Drape of the Untamed Predator
    [46971] = 46970,
    -- Cord of the Tenebrous Mist
    [46973] = 46972,
    -- Leggings of the Broken Beast
    [46975] = 46974,
    -- Shawl of the Refreshing Winds
    [46977] = 46976,
    -- Blade of Tarasque
    [46979] = 46980,
    -- Boots of the Courageous
    [46986] = 46985,
    -- Boots of the Unrelenting Storm
    [46989] = 46988,
    -- Belt of the Ice Burrower
    [46991] = 46990,
    -- Flowing Vestments of Ascent
    [46993] = 46992,
    -- Talonstrike
    [46995] = 46994,
    -- Cuirass of Calamitous Fate
    [47000] = 47004,
    -- Lionhead Slasher
    [47001] = 46996,
    -- Bloodbath Belt
    [47002] = 46999,
    -- Dawnbreaker Greaves
    [47003] = 46997,
    -- Solace of the Defeated
    [47059] = 47041,
    -- Charge of the Demon Lord
    [47060] = 47043,
    -- Legguards of Feverish Dedication
    [47061] = 47052,
    -- Leggings of the Soothing Touch
    [47062] = 47051,
    -- Pride of the Eredar
    [47063] = 47042,
    -- Symbol of Transgression
    [47064] = 47053,
    -- Bracers of the Autumn Willow
    [47066] = 47055,
    -- Legplates of Failing Light
    [47067] = 47057,
    -- Bracers of Cloudy Omen
    [47068] = 47056,
    -- Bracers of the Untold Massacre
    [47074] = 47073,
    -- Ring of Callous Aggression
    [47075] = 47070,
    -- Girdle of Bloodied Scars
    [47076] = 47072,
    -- Treads of the Icewalker
    [47077] = 47071,
    -- Justicebringer
    [47078] = 47069,
    -- Cord of Biting Cold
    [47084] = 47081,
    -- Bastion of Purity
    [47085] = 47079,
    -- Chestplate of the Frostborn Hero
    [47086] = 47082,
    -- Legguards of Concealed Hatred
    [47087] = 47083,
    -- Satrina's Impeding Scarab
    [47088] = 47080,
    -- Cloak of Displacement
    [47089] = 47095,
    -- Boots of Tremoring Earth
    [47090] = 47099,
    -- Vestments of the Shattered Fellowship
    [47096] = 47094,
    -- Boots of the Mourning Widow
    [47097] = 47092,
    -- Vambraces of the Broken Bond
    [47098] = 47093,
    -- Sabatons of Ruthless Judgment
    [47109] = 47106,
    -- The Executioner's Malice
    [47110] = 47105,
    -- Bracers of the Shieldmaiden
    [47111] = 47108,
    -- Belt of the Merciless Killer
    [47112] = 47107,
    -- Twin Spike
    [47113] = 47104,
    -- Skyweaver Robes
    [47129] = 47126,
    -- Lupine Longstaff
    [47130] = 47114,
    -- Death's Verdict
    [47131] = 47115,
    -- Legguards of Ascension
    [47132] = 47121,
    -- The Arbiter's Muse
    [47133] = 47116,
    -- Bindings of Dark Essence
    [47143] = 47141,
    -- Wail of the Val'kyr
    [47144] = 47139,
    -- Cord of Pale Thorns
    [47145] = 47140,
    -- Chalice of Searing Light
    [47146] = 47138,
    -- Breastplate of the Frozen Lake
    [47147] = 47142,
    -- Belt of Deathly Dominion
    [47153] = 47152,
    -- Greaves of the 7th Legion
    [47154] = 47150,
    -- Bracers of Dark Determination
    [47155] = 47151,
    -- Stormpike Cleaver
    [47156] = 47148,
    -- Signet of the Traitor King
    [47157] = 47149,
    -- Reign of the Unliving
    [47188] = 47182,
    -- Leggings of the Deepening Void
    [47189] = 47187,
    -- Legwraps of the Awakening
    [47190] = 47186,
    -- Legguards of the Lurking Threat
    [47191] = 47184,
    -- Strength of the Nerub
    [47192] = 47183,
    -- Footpads of the Icy Floe
    [47205] = 47194,
    -- Misery's End
    [47206] = 47193,
    -- Belt of the Forgotten Martyr
    [47207] = 47195,
    -- Armbands of the Ashen Saint
    [47208] = 47203,
    -- Chestguard of Flowing Elements
    [47209] = 47204,
    -- Ring of the Darkmender
    [47224] = 47223,
    -- Gloves of the Lifeless Touch
    [47236] = 47235,
    -- Band of Deplorable Violence
    [47237] = 47054,
    -- Maiden's Favor
    [47238] = 47225,
    -- Archon Glaive
    [47239] = 47233,
    -- Gloves of Bitter Reprisal
    [47240] = 47234,
    -- Cuirass of Cruel Intent
    [47251] = 47412,
    -- Ring of the Violent Temperament
    [47252] = 47413,
    -- Boneshatter Vambraces
    [47253] = 47414,
    -- Hauberk of the Towering Monstrosity
    [47254] = 47415,
    -- Stygian Bladebreaker
    [47255] = 47416,
    -- Drape of the Refreshing Winds
    [47256] = 47417,
    -- Cloak of the Untamed Predator
    [47257] = 47418,
    -- Belt of the Tenebrous Mist
    [47258] = 47419,
    -- Legwraps of the Broken Beast
    [47259] = 47420,
    -- Forlorn Barrier
    [47260] = 47421,
    -- Barb of Tarasque
    [47261] = 47422,
    -- Boots of the Harsh Winter
    [47262] = 47423,
    -- Sabatons of the Courageous
    [47263] = 47424,
    -- Flowing Robes of Ascent
    [47264] = 47425,
    -- Binding of the Ice Burrower
    [47265] = 47426,
    -- Blood Fury
    [47266] = 47427,
    -- Death's Head Crossbow
    [47267] = 47428,
    -- Bloodbath Girdle
    [47268] = 47429,
    -- Dawnbreaker Sabatons
    [47269] = 47430,
    -- Solace of the Fallen
    [47271] = 47432,
    -- Charge of the Eredar
    [47272] = 47433,
    -- Legplates of Feverish Dedication
    [47273] = 47434,
    -- Pants of the Soothing Touch
    [47274] = 47435,
    -- Pride of the Demon Lord
    [47275] = 47436,
    -- Talisman of Heedless Sins
    [47276] = 47437,
    -- Bindings of the Autumn Willow
    [47277] = 47438,
    -- Circle of the Darkmender
    [47278] = 47439,
    -- Leggings of Failing Light
    [47279] = 47440,
    -- Wristwraps of Cloudy Omen
    [47280] = 47441,
    -- Bracers of the Silent Massacre
    [47281] = 47442,
    -- Band of Callous Aggression
    [47282] = 47443,
    -- Belt of Bloodied Scars
    [47283] = 47444,
    -- Icewalker Treads
    [47284] = 47445,
    -- Dual-blade Butcher
    [47285] = 47446,
    -- Belt of Biting Cold
    [47286] = 47447,
    -- Bastion of Resolve
    [47287] = 47448,
    -- Chestplate of the Frostwolf Hero
    [47288] = 47449,
    -- Leggings of Concealed Hatred
    [47289] = 47450,
    -- Juggernaut's Vitality
    [47290] = 47451,
    -- Shroud of Displacement
    [47291] = 47452,
    -- Robes of the Shattered Fellowship
    [47292] = 47453,
    -- Sandals of the Mourning Widow
    [47293] = 47454,
    -- Bracers of the Broken Bond
    [47294] = 47455,
    -- Sabatons of Tremoring Earth
    [47295] = 47456,
    -- Greaves of Ruthless Judgment
    [47296] = 47457,
    -- The Executioner's Vice
    [47297] = 47458,
    -- Armguards of the Shieldmaiden
    [47298] = 47459,
    -- Belt of the Pitiless Killer
    [47299] = 47460,
    -- Gouge of the Frigid Heart
    [47300] = 47461,
    -- Skyweaver Vestments
    [47301] = 47462,
    -- Twin's Pact
    [47302] = 47463,
    -- Death's Choice
    [47303] = 47464,
    -- Legplates of Ascension
    [47304] = 47465,
    -- Legionnaire's Gorget
    [47305] = 47466,
    -- Dark Essence Bindings
    [47306] = 47467,
    -- Cry of the Val'kyr
    [47307] = 47468,
    -- Belt of Pale Thorns
    [47308] = 47469,
    -- Mystifying Charm
    [47309] = 47470,
    -- Chestplate of the Frozen Lake
    [47310] = 47471,
    -- Waistguard of Deathly Dominion
    [47311] = 47472,
    -- Greaves of the Saronite Citadel
    [47312] = 47473,
    -- Armbands of Dark Determination
    [47313] = 47474,
    -- Hellscream Slicer
    [47314] = 47475,
    -- Band of the Traitor King
    [47315] = 47476,
    -- Reign of the Dead
    [47316] = 47477,
    -- Breeches of the Deepening Void
    [47317] = 47478,
    -- Leggings of the Awakening
    [47318] = 47479,
    -- Leggings of the Lurking Threat
    [47319] = 47480,
    -- Might of the Nerub
    [47320] = 47481,
    -- Boots of the Icy Floe
    [47321] = 47482,
    -- Suffering's End
    [47322] = 47483,
    -- Girdle of the Forgotten Martyr
    [47323] = 47484,
    -- Bindings of the Ashen Saint
    [47324] = 47485,
    -- Cuirass of Flowing Elements
    [47325] = 47486,
    -- Handwraps of the Lifeless Touch
    [47326] = 47487,
    -- Lurid Manifestation
    [47327] = 47489,
    -- Maiden's Adoration
    [47328] = 47490,
    -- Hellion Glaive
    [47329] = 47491,
    -- Gauntlets of Bitter Reprisal
    [47330] = 47492,
    -- Vest of Calamitous Fate
    [47431] = 47270,
    -- Saronite Swordbreakers
    [47571] = 47570,
    -- Titanium Spikeguards
    [47573] = 47572,
    -- Sunforged Bracers
    [47575] = 47574,
    -- Crusader's Dragonscale Bracers
    [47577] = 47576,
    -- Black Chitin Bracers
    [47580] = 47579,
    -- Bracers of Swift Death
    [47582] = 47581,
    -- Moonshadow Armguards
    [47583] = 47584,
    -- Bejeweled Wizard's Bracers
    [47586] = 47585,
    -- Royal Moonshroud Bracers
    [47588] = 47587,
    -- Titanium Razorplate
    [47590] = 47589,
    -- Breastplate of the White Knight
    [47592] = 47591,
    -- Sunforged Breastplate
    [47594] = 47593,
    -- Crusader's Dragonscale Breastplate
    [47595] = 47596,
    -- Ensorcelled Nerubian Breastplate
    [47597] = 47598,
    -- Knightbane Carapace
    [47599] = 47600,
    -- Lunar Eclipse Robes
    [47602] = 47601,
    -- Merlin's Robe
    [47604] = 47603,
    -- Royal Moonshroud Robe
    [47605] = 47606,
    -- Gauntlets of Rising Anger
    [47609] = 47917,
    -- Girdle of the Impaler
    [47614] = 47925,
    -- Shoulderguards of the Spirit Walker
    [47616] = 47926,
    -- Firestorm Ring
    [47618] = 47928,
    -- Amulet of Binding Elements
    [47619] = 47930,
    -- Leggings of the Demonic Messenger
    [47620] = 47931,
    -- Girdle of the Farseer
    [47621] = 47932,
    -- Plans: Breastplate of the White Knight
    [47622] = 47640,
    -- Plans: Saronite Swordbreakers
    [47623] = 47641,
    -- Plans: Titanium Razorplate
    [47624] = 47644,
    -- Plans: Titanium Spikeguards
    [47625] = 47645,
    -- Plans: Sunforged Breastplate
    [47626] = 47643,
    -- Plans: Sunforged Bracers
    [47627] = 47642,
    -- Pattern: Ensorcelled Nerubian Breastplate
    [47628] = 47650,
    -- Pattern: Black Chitin Bracers
    [47629] = 47646,
    -- Pattern: Crusader's Dragonscale Breastplate
    [47630] = 47649,
    -- Pattern: Crusader's Dragonscale Bracers
    [47631] = 47648,
    -- Pattern: Lunar Eclipse Robes
    [47632] = 47652,
    -- Pattern: Moonshadow Armguards
    [47633] = 47653,
    -- Pattern: Knightbane Carapace
    [47634] = 47651,
    -- Pattern: Bracers of Swift Death
    [47635] = 47647,
    -- Pattern: Bejeweled Wizard's Bracers
    [47654] = 47639,
    -- Pattern: Merlin's Robe
    [47655] = 47638,
    -- Pattern: Royal Moonshroud Bracers
    [47656] = 47637,
    -- Pattern: Royal Moonshroud Robe
    [47657] = 47636,
    -- Felspark Bindings
    [47663] = 47927,
    -- Belt of the Winter Solstice
    [47669] = 47929,
    -- Dirk of the Night Watch
    [47676] = 47938,
    -- Endurance of the Infernal
    [47679] = 47939,
    -- Armguards of the Nether Lord
    [47680] = 47935,
    -- Sentinel Scouting Greaves
    [47683] = 47933,
    -- Loop of the Twin Val'kyr
    [47700] = 47955,
    -- Planestalker Signet
    [47703] = 47934,
    -- Girdle of the Nether Champion
    [47711] = 47937,
    -- Binding Light
    [47728] = 47947,
    -- Icefall Blade
    [47736] = 47953,
    -- Reckoning
    [47737] = 47951,
    -- Sabatons of the Lingering Vortex
    [47738] = 47952,
    -- Armor of Shifting Shadows
    [47739] = 47954,
    -- The Diplomat
    [47740] = 47950,
    -- Baelgun's Heavy Crossbow
    [47741] = 47975,
    -- Chalice of Benedictus
    [47742] = 47958,
    -- Enlightenment
    [47743] = 47960,
    -- Gloves of the Azure Prophet
    [47744] = 47961,
    -- Gloves of Looming Shadow
    [47745] = 47956,
    -- Helm of the Snowy Grotto
    [47746] = 47959,
    -- Darkbane Pendant
    [47747] = 47957,
    -- Khadgar's Gauntlets of Triumph
    [47753] = 47762,
    -- Khadgar's Hood of Triumph
    [47754] = 47761,
    -- Khadgar's Leggings of Triumph
    [47755] = 47760,
    -- Khadgar's Robe of Triumph
    [47756] = 47759,
    -- Khadgar's Shoulderpads of Triumph
    [47757] = 47758,
    -- Sunstrider's Shoulderpads of Triumph
    [47768] = 47767,
    -- Sunstrider's Robe of Triumph
    [47769] = 47766,
    -- Sunstrider's Leggings of Triumph
    [47770] = 47765,
    -- Sunstrider's Hood of Triumph
    [47771] = 47764,
    -- Sunstrider's Gauntlets of Triumph
    [47772] = 47763,
    -- Kel'Thuzad's Hood of Triumph
    [47778] = 47789,
    -- Kel'Thuzad's Robe of Triumph
    [47779] = 47791,
    -- Kel'Thuzad's Leggings of Triumph
    [47780] = 47790,
    -- Kel'Thuzad's Shoulderpads of Triumph
    [47781] = 47792,
    -- Kel'Thuzad's Gloves of Triumph
    [47782] = 47788,
    -- Gul'dan's Gloves of Triumph
    [47803] = 47797,
    -- Gul'dan's Hood of Triumph
    [47804] = 47796,
    -- Gul'dan's Leggings of Triumph
    [47805] = 47795,
    -- Gul'dan's Robe of Triumph
    [47806] = 47794,
    -- Gul'dan's Shoulderpads of Triumph
    [47807] = 47793,
    -- The Lion's Maw
    [47808] = 47966,
    -- Argent Resolve
    [47809] = 47962,
    -- Crusader's Glory
    [47810] = 47967,
    -- Chestguard of the Warden
    [47811] = 47964,
    -- Vigilant Ward
    [47812] = 47963,
    -- Helmet of the Crypt Lord
    [47813] = 47965,
    -- Westfall Saber
    [47814] = 47971,
    -- Cold Convergence
    [47815] = 47968,
    -- The Grinder
    [47816] = 47973,
    -- Pauldrons of the Timeless Hunter
    [47829] = 47969,
    -- Legplates of the Silver Hand
    [47830] = 47970,
    -- Spaulders of the Snow Bandit
    [47832] = 47972,
    -- Fordragon Blades
    [47834] = 47979,
    -- Bulwark of the Royal Guard
    [47835] = 47978,
    -- Legplates of the Immortal Spider
    [47836] = 47976,
    -- Cinch of the Undying
    [47837] = 47977,
    -- Vestments of the Sleepless
    [47838] = 47974,
    -- Collar of Unending Torment
    [47849] = 47988,
    -- Bracers of the Northern Stalker
    [47850] = 47989,
    -- Gauntlets of Mounting Anger
    [47851] = 47990,
    -- Dreadscale Bracers
    [47852] = 47991,
    -- Acidmaw Treads
    [47853] = 47992,
    -- Gormok's Band
    [47854] = 47993,
    -- Icehowl Binding
    [47855] = 47994,
    -- Scepter of Imprisoned Souls
    [47856] = 47995,
    -- Pauldrons of the Glacial Wilds
    [47857] = 47996,
    -- Girdle of the Frozen Reach
    [47858] = 47997,
    -- Belt of the Impaler
    [47859] = 47998,
    -- Pauldrons of the Spirit Walker
    [47860] = 47999,
    -- Felspark Bracers
    [47861] = 48000,
    -- Firestorm Band
    [47862] = 48001,
    -- Belt of the Bloodhoof Emissary
    [47863] = 48002,
    -- Pendant of Binding Elements
    [47864] = 48003,
    -- Legwraps of the Demonic Messenger
    [47865] = 48004,
    -- Darkspear Ritual Binding
    [47866] = 48005,
    -- Warsong Poacher's Greaves
    [47867] = 48006,
    -- Planestalker Band
    [47868] = 48007,
    -- Armplates of the Nether Lord
    [47869] = 48008,
    -- Belt of the Nether Champion
    [47870] = 48009,
    -- Orcish Deathblade
    [47871] = 48010,
    -- Fortitude of the Infernal
    [47872] = 48011,
    -- Sunreaver Magus' Sandals
    [47873] = 48012,
    -- Sunreaver Disciple's Blade
    [47874] = 48013,
    -- Sunreaver Ranger's Helm
    [47875] = 48014,
    -- Sunreaver Champion's Faceplate
    [47876] = 48015,
    -- Sunreaver Defender's Pauldrons
    [47877] = 48016,
    -- Sunreaver Assassin's Gloves
    [47878] = 48017,
    -- Fetish of Volatile Power
    [47879] = 48018,
    -- Binding Stone
    [47880] = 48019,
    -- Vengeance of the Forsaken
    [47881] = 48020,
    -- Eitrigg's Oath
    [47882] = 48021,
    -- Widebarrel Flintlock
    [47883] = 48022,
    -- Edge of Agony
    [47884] = 48023,
    -- Greaves of the Lingering Vortex
    [47885] = 48024,
    -- Nemesis Blade
    [47886] = 48025,
    -- Vest of Shifting Shadows
    [47887] = 48026,
    -- Band of the Twin Val'kyr
    [47888] = 48027,
    -- Looming Shadow Wraps
    [47889] = 48028,
    -- Darkbane Amulet
    [47890] = 48030,
    -- Helm of the High Mesa
    [47891] = 48034,
    -- Illumination
    [47892] = 48036,
    -- Sen'jin Ritualist Gloves
    [47893] = 48038,
    -- Mace of the Earthborn Chieftain
    [47894] = 48039,
    -- Pride of the Kor'kron
    [47895] = 48040,
    -- Stoneskin Chestplate
    [47896] = 48041,
    -- Helm of the Crypt Lord
    [47897] = 48042,
    -- Frostblade Hatchet
    [47898] = 48043,
    -- Ardent Guard
    [47899] = 48044,
    -- Perdition
    [47900] = 48045,
    -- Pauldrons of the Shadow Hunter
    [47901] = 48046,
    -- Forsaken Bonecarver
    [47903] = 48048,
    -- Shoulderpads of the Snow Bandit
    [47904] = 48049,
    -- Blackhorn Bludgeon
    [47905] = 48050,
    -- Robes of the Sleepless
    [47906] = 48051,
    -- Darkmaw Crossbow
    [47907] = 48052,
    -- Sunwalker Legguards
    [47908] = 48053,
    -- Belt of the Eternal
    [47909] = 48054,
    -- Aegis of the Coliseum
    [47910] = 48055,
    -- Lightbane Focus
    [47913] = 48032,
    -- Collar of Ceaseless Torment
    [47915] = 47607,
    -- Armbands of the Northern Stalker
    [47916] = 47610,
    -- Dreadscale Armguards
    [47918] = 47611,
    -- Acidmaw Boots
    [47919] = 47608,
    -- Carnivorous Band
    [47920] = 47578,
    -- Icehowl Cinch
    [47921] = 47617,
    -- Rod of Imprisoned Souls
    [47922] = 47612,
    -- Shoulderpads of the Glacial Wilds
    [47923] = 47613,
    -- Belt of the Frozen Reach
    [47924] = 47615,
    -- Sandals of the Silver Magus
    [47940] = 47721,
    -- Blade of the Silver Disciple
    [47941] = 47724,
    -- Helm of the Silver Ranger
    [47942] = 47718,
    -- Faceplate of the Silver Champion
    [47943] = 47717,
    -- Pauldrons of the Silver Defender
    [47944] = 47720,
    -- Gloves of the Silver Assassin
    [47945] = 47719,
    -- Talisman of Volatile Power
    [47946] = 47726,
    -- Victor's Call
    [47948] = 47725,
    -- Fervor of the Frostborn
    [47949] = 47727,
    -- Velen's Gloves of Triumph
    [47983] = 48037,
    -- Velen's Cowl of Triumph
    [47984] = 48035,
    -- Velen's Leggings of Triumph
    [47985] = 48033,
    -- Velen's Robe of Triumph
    [47986] = 48031,
    -- Velen's Shoulderpads of Triumph
    [47987] = 48029,
    -- Anguish
    [48056] = 47911,
    -- Zabra's Shoulderpads of Triumph
    [48062] = 48061,
    -- Zabra's Robe of Triumph
    [48063] = 48060,
    -- Zabra's Leggings of Triumph
    [48064] = 48059,
    -- Zabra's Cowl of Triumph
    [48065] = 48058,
    -- Zabra's Gloves of Triumph
    [48066] = 48057,
    -- Velen's Handwraps of Triumph
    [48077] = 48086,
    -- Velen's Circlet of Triumph
    [48078] = 48085,
    -- Velen's Pants of Triumph
    [48079] = 48084,
    -- Velen's Raiments of Triumph
    [48080] = 48083,
    -- Velen's Mantle of Triumph
    [48081] = 48082,
    -- Zabra's Mantle of Triumph
    [48092] = 48091,
    -- Zabra's Raiments of Triumph
    [48093] = 48090,
    -- Zabra's Pants of Triumph
    [48094] = 48089,
    -- Zabra's Circlet of Triumph
    [48095] = 48088,
    -- Zabra's Handwraps of Triumph
    [48096] = 48087,
    -- Malfurion's Handguards of Triumph
    [48133] = 48142,
    -- Malfurion's Headpiece of Triumph
    [48134] = 48141,
    -- Malfurion's Leggings of Triumph
    [48135] = 48140,
    -- Malfurion's Robe of Triumph
    [48136] = 48139,
    -- Malfurion's Spaulders of Triumph
    [48137] = 48138,
    -- Runetotem's Spaulders of Triumph
    [48148] = 48147,
    -- Runetotem's Robe of Triumph
    [48149] = 48146,
    -- Runetotem's Leggings of Triumph
    [48150] = 48145,
    -- Runetotem's Headpiece of Triumph
    [48151] = 48144,
    -- Runetotem's Handguards of Triumph
    [48152] = 48143,
    -- Malfurion's Gloves of Triumph
    [48163] = 48172,
    -- Malfurion's Cover of Triumph
    [48164] = 48171,
    -- Malfurion's Trousers of Triumph
    [48165] = 48170,
    -- Malfurion's Vestments of Triumph
    [48166] = 48169,
    -- Malfurion's Mantle of Triumph
    [48167] = 48168,
    -- Runetotem's Mantle of Triumph
    [48178] = 48177,
    -- Runetotem's Vestments of Triumph
    [48179] = 48176,
    -- Runetotem's Trousers of Triumph
    [48180] = 48175,
    -- Runetotem's Cover of Triumph
    [48181] = 48174,
    -- Runetotem's Gloves of Triumph
    [48182] = 48173,
    -- Runetotem's Handgrips of Triumph
    [48193] = 48202,
    -- Runetotem's Headguard of Triumph
    [48194] = 48201,
    -- Runetotem's Legguards of Triumph
    [48195] = 48200,
    -- Runetotem's Raiments of Triumph
    [48196] = 48199,
    -- Runetotem's Shoulderpads of Triumph
    [48197] = 48198,
    -- Malfurion's Shoulderpads of Triumph
    [48208] = 48207,
    -- Malfurion's Raiments of Triumph
    [48209] = 48206,
    -- Malfurion's Legguards of Triumph
    [48210] = 48205,
    -- Malfurion's Headguard of Triumph
    [48211] = 48204,
    -- Malfurion's Handgrips of Triumph
    [48212] = 48203,
    -- VanCleef's Breastplate of Triumph
    [48223] = 48232,
    -- VanCleef's Gauntlets of Triumph
    [48224] = 48231,
    -- VanCleef's Helmet of Triumph
    [48225] = 48230,
    -- VanCleef's Legplates of Triumph
    [48226] = 48229,
    -- VanCleef's Pauldrons of Triumph
    [48227] = 48228,
    -- Garona's Pauldrons of Triumph
    [48238] = 48237,
    -- Garona's Legplates of Triumph
    [48239] = 48236,
    -- Garona's Helmet of Triumph
    [48240] = 48235,
    -- Garona's Gauntlets of Triumph
    [48241] = 48234,
    -- Garona's Breastplate of Triumph
    [48242] = 48233,
    -- Windrunner's Tunic of Conquest
    [48275] = 48251,
    -- Windrunner's Handguards of Conquest
    [48276] = 48254,
    -- Windrunner's Headpiece of Conquest
    [48277] = 48250,
    -- Windrunner's Legguards of Conquest
    [48278] = 48252,
    -- Windrunner's Spaulders of Conquest
    [48279] = 48253,
    -- Nobundo's Tunic of Triumph
    [48285] = 48294,
    -- Nobundo's Handguards of Triumph
    [48286] = 48293,
    -- Nobundo's Headpiece of Triumph
    [48287] = 48292,
    -- Nobundo's Legguards of Triumph
    [48288] = 48291,
    -- Nobundo's Spaulders of Triumph
    [48289] = 48290,
    -- Thrall's Tunic of Triumph
    [48300] = 48305,
    -- Thrall's Handguards of Triumph
    [48301] = 48306,
    -- Thrall's Headpiece of Triumph
    [48302] = 48307,
    -- Thrall's Legguards of Triumph
    [48303] = 48308,
    -- Thrall's Spaulders of Triumph
    [48304] = 48309,
    -- Nobundo's Hauberk of Triumph
    [48316] = 48325,
    -- Nobundo's Gloves of Triumph
    [48317] = 48324,
    -- Nobundo's Helm of Triumph
    [48318] = 48323,
    -- Nobundo's Kilt of Triumph
    [48319] = 48322,
    -- Nobundo's Shoulderpads of Triumph
    [48320] = 48321,
    -- Thrall's Shoulderpads of Triumph
    [48331] = 48330,
    -- Thrall's Kilt of Triumph
    [48332] = 48329,
    -- Thrall's Helm of Triumph
    [48333] = 48328,
    -- Thrall's Gloves of Triumph
    [48334] = 48327,
    -- Thrall's Hauberk of Triumph
    [48335] = 48326,
    -- Nobundo's Chestguard of Triumph
    [48346] = 48355,
    -- Nobundo's Grips of Triumph
    [48347] = 48354,
    -- Nobundo's Faceguard of Triumph
    [48348] = 48353,
    -- Nobundo's War-Kilt of Triumph
    [48349] = 48352,
    -- Nobundo's Shoulderguards of Triumph
    [48350] = 48351,
    -- Thrall's Shoulderguards of Triumph
    [48361] = 48360,
    -- Thrall's War-Kilt of Triumph
    [48362] = 48359,
    -- Thrall's Faceguard of Triumph
    [48363] = 48358,
    -- Thrall's Grips of Triumph
    [48364] = 48357,
    -- Thrall's Chestguard of Triumph
    [48365] = 48356,
    -- Wrynn's Battleplate of Triumph
    [48376] = 48385,
    -- Wrynn's Gauntlets of Triumph
    [48377] = 48384,
    -- Wrynn's Helmet of Triumph
    [48378] = 48383,
    -- Wrynn's Legplates of Triumph
    [48379] = 48382,
    -- Wrynn's Shoulderplates of Triumph
    [48380] = 48381,
    -- Hellscream's Battleplate of Triumph
    [48391] = 48396,
    -- Hellscream's Gauntlets of Triumph
    [48392] = 48397,
    -- Hellscream's Helmet of Triumph
    [48393] = 48398,
    -- Hellscream's Legplates of Triumph
    [48394] = 48399,
    -- Hellscream's Shoulderplates of Triumph
    [48395] = 48400,
    -- Wrynn's Greathelm of Triumph
    [48430] = 48433,
    -- Wrynn's Legguards of Triumph
    [48446] = 48447,
    -- Wrynn's Breastplate of Triumph
    [48450] = 48451,
    -- Wrynn's Handguards of Triumph
    [48452] = 48453,
    -- Wrynn's Pauldrons of Triumph
    [48454] = 48455,
    -- Hellscream's Breastplate of Triumph
    [48461] = 48466,
    -- Hellscream's Handguards of Triumph
    [48462] = 48467,
    -- Hellscream's Greathelm of Triumph
    [48463] = 48468,
    -- Hellscream's Legguards of Triumph
    [48464] = 48469,
    -- Hellscream's Pauldrons of Triumph
    [48465] = 48470,
    -- Thassarian's Battleplate of Triumph
    [48481] = 48490,
    -- Thassarian's Gauntlets of Triumph
    [48482] = 48489,
    -- Thassarian's Helmet of Triumph
    [48483] = 48488,
    -- Thassarian's Legplates of Triumph
    [48484] = 48487,
    -- Thassarian's Shoulderplates of Triumph
    [48485] = 48486,
    -- Koltira's Shoulderplates of Triumph
    [48496] = 48495,
    -- Koltira's Legplates of Triumph
    [48497] = 48494,
    -- Koltira's Helmet of Triumph
    [48498] = 48493,
    -- Koltira's Gauntlets of Triumph
    [48499] = 48492,
    -- Koltira's Battleplate of Triumph
    [48500] = 48491,
    -- Thassarian's Chestguard of Triumph
    [48538] = 48547,
    -- Thassarian's Handguards of Triumph
    [48539] = 48546,
    -- Thassarian's Faceguard of Triumph
    [48540] = 48545,
    -- Thassarian's Legguards of Triumph
    [48541] = 48544,
    -- Thassarian's Pauldrons of Triumph
    [48542] = 48543,
    -- Koltira's Pauldrons of Triumph
    [48553] = 48552,
    -- Koltira's Legguards of Triumph
    [48554] = 48551,
    -- Koltira's Faceguard of Triumph
    [48555] = 48550,
    -- Koltira's Handguards of Triumph
    [48556] = 48549,
    -- Koltira's Chestguard of Triumph
    [48557] = 48548,
    -- Turalyon's Tunic of Triumph
    [48575] = 48584,
    -- Turalyon's Gloves of Triumph
    [48576] = 48583,
    -- Turalyon's Headpiece of Triumph
    [48577] = 48582,
    -- Turalyon's Greaves of Triumph
    [48578] = 48581,
    -- Turalyon's Spaulders of Triumph
    [48579] = 48580,
    -- Liadrin's Spaulders of Triumph
    [48590] = 48585,
    -- Liadrin's Greaves of Triumph
    [48591] = 48586,
    -- Liadrin's Headpiece of Triumph
    [48592] = 48587,
    -- Liadrin's Gloves of Triumph
    [48593] = 48588,
    -- Liadrin's Tunic of Triumph
    [48594] = 48589,
    -- Turalyon's Battleplate of Triumph
    [48607] = 48616,
    -- Turalyon's Gauntlets of Triumph
    [48608] = 48615,
    -- Turalyon's Helm of Triumph
    [48609] = 48614,
    -- Turalyon's Legplates of Triumph
    [48610] = 48613,
    -- Turalyon's Shoulderplates of Triumph
    [48611] = 48612,
    -- Liadrin's Shoulderplates of Triumph
    [48622] = 48621,
    -- Liadrin's Legplates of Triumph
    [48623] = 48620,
    -- Liadrin's Helm of Triumph
    [48624] = 48619,
    -- Liadrin's Gauntlets of Triumph
    [48625] = 48618,
    -- Liadrin's Battleplate of Triumph
    [48626] = 48617,
    -- Turalyon's Shoulderguards of Triumph
    [48637] = 48646,
    -- Turalyon's Legguards of Triumph
    [48638] = 48645,
    -- Turalyon's Faceguard of Triumph
    [48639] = 48644,
    -- Turalyon's Handguards of Triumph
    [48640] = 48643,
    -- Turalyon's Breastplate of Triumph
    [48641] = 48642,
    -- Liadrin's Breastplate of Triumph
    [48657] = 48651,
    -- Liadrin's Handguards of Triumph
    [48658] = 48650,
    -- Liadrin's Faceguard of Triumph
    [48659] = 48649,
    -- Liadrin's Legguards of Triumph
    [48660] = 48648,
    -- Liadrin's Shoulderguards of Triumph
    [48661] = 48647,
    -- Windrunner's Handguards 
    [48814] = 48819,
    -- Windrunner's Headpiece 
    [48815] = 48820,
    -- Windrunner's Legguards 
    [48816] = 48821,
    -- Windrunner's Spaulders 
    [48817] = 48822,
    -- Windrunner's Tunic 
    [48818] = 48823,
    -- Boots of the Grieving Soul
    [49231] = 49234,
    -- Sandals of the Grieving Soul
    [49232] = 49233,
    -- Boots of Tortured Space
    [49235] = 49238,
    -- Sabatons of Tortured Space
    [49236] = 49237,
    -- Magic Rooster Egg
    [49290] = 46778,
    -- Sparkling Onyxia Tooth Pendant
    [49485] = 49314,
    -- Polished Dragonslayer's Signet
    [49486] = 49313,
    -- Purified Onyxia Blood Talisman
    [49487] = 49312,
    -- Cryptmaker
    [49919] = 50603,
    -- Band of the Bone Colossus
    [49949] = 50604,
    -- Frostbitten Fur Boots
    [49950] = 50607,
    -- Gendarme's Cuirass
    [49951] = 50606,
    -- Snowserpent Mail Helm
    [49952] = 50605,
    -- Bracers of Dark Reckoning
    [49960] = 50611,
    -- Legguards of Lost Hope
    [49964] = 50612,
    -- Marrowgar's Frigid Eye
    [49967] = 50610,
    -- Frozen Bonespike
    [49968] = 50608,
    -- Bone Sentinel's Amulet
    [49975] = 50609,
    -- Bulwark of Smouldering Steel
    [49976] = 50616,
    -- Loop of the Endless Labyrinth
    [49977] = 50614,
    -- Crushing Coldwraith Belt
    [49978] = 50613,
    -- Handguards of Winter's Respite
    [49979] = 50615,
    -- Rusted Bonespike Pauldrons
    [49980] = 50617,
    -- Fal'inrush, Defender of Quel'thalas
    [49981] = 50733,
    -- Heartpierce
    [49982] = 50641,
    -- Blood-Soaked Saronite Stompers
    [49983] = 50639,
    -- Juggernaut Band
    [49985] = 50642,
    -- Broken Ram Skull Helm
    [49986] = 50640,
    -- Cultist's Bloodsoaked Spaulders
    [49987] = 50646,
    -- Leggings of Northern Lights
    [49988] = 50645,
    -- Ahn'kahar Onyx Neckguard
    [49989] = 50647,
    -- Ring of Maddening Whispers
    [49990] = 50644,
    -- Shoulders of Mercy Killing
    [49991] = 50643,
    -- Nibelung
    [49992] = 50648,
    -- Necrophotic Greaves
    [49993] = 50652,
    -- The Lady's Brittle Bracers
    [49994] = 50651,
    -- Fallen Lord's Handguards
    [49995] = 50650,
    -- Deathwhisper Raiment
    [49996] = 50649,
    -- Mithrios, Bronzebeard's Legacy
    [49997] = 50738,
    -- Shadowvault Slayer's Cloak
    [49998] = 50653,
    -- Skeleton Lord's Circle
    [49999] = 50657,
    -- Scourge Hunter's Vambraces
    [50000] = 50655,
    -- Ikfirus's Sack of Wonder
    [50001] = 50656,
    -- Ikfirus' Sack of Wonder
    [50001] = 50656,
    -- Polar Bear Claw Bracers
    [50002] = 50659,
    -- Boneguard Commander's Pauldrons
    [50003] = 50660,
    -- Amulet of the Silent Eulogy
    [50005] = 50658,
    -- Corp'rethar Ceremonial Crown
    [50006] = 50661,
    -- Ring of Rapid Ascent
    [50008] = 50664,
    -- Boots of Unnatural Growth
    [50009] = 50665,
    -- Waistband of Righteous Fury
    [50010] = 50667,
    -- Gunship Captain's Mittens
    [50011] = 50663,
    -- Havoc's Call, Blade of Lordaeron Kings
    [50012] = 50737,
    -- Greatcloak of the Turned Champion
    [50014] = 50668,
    -- Belt of the Blood Nova
    [50015] = 50671,
    -- Rib Spreader
    [50016] = 50676,
    -- Winding Sheet
    [50019] = 50677,
    -- Raging Behemoth's Shoulderplates
    [50020] = 50674,
    -- Aldriana's Gloves of Secrecy
    [50021] = 50675,
    -- Dual-Bladed Pauldrons
    [50022] = 50673,
    -- Bile-Encrusted Medallion
    [50023] = 50682,
    -- Blightborne Warplate
    [50024] = 50681,
    -- Seal of Many Mouths
    [50025] = 50678,
    -- Helm of the Elder Moon
    [50026] = 50679,
    -- Rot-Resistant Breastplate
    [50027] = 50680,
    -- Trauma
    [50028] = 50685,
    -- Bloodsunder's Bracers
    [50030] = 50687,
    -- Death Surgeon's Sleeves
    [50032] = 50686,
    -- Corpse-Impaling Spike
    [50033] = 50684,
    -- Zod's Repeating Longbow
    [50034] = 50638,
    -- Black Bruise
    [50035] = 50692,
    -- Fleshrending Gauntlets
    [50037] = 50690,
    -- Carapace of Forgotten Kings
    [50038] = 50689,
    -- Distant Land
    [50040] = 50695,
    -- Leather of Stitched Scourge Parts
    [50041] = 50696,
    -- Gangrenous Leggings
    [50042] = 50697,
    -- Plaguebringer's Stained Pants
    [50056] = 50694,
    -- Horrific Flesh Epaulets
    [50059] = 50698,
    -- Faceplate of the Forgotten
    [50060] = 50701,
    -- Holiday's Grace
    [50061] = 50700,
    -- Plague Scientist's Boots
    [50062] = 50699,
    -- Lingering Illness
    [50063] = 50702,
    -- Unclean Surgical Gloves
    [50064] = 50703,
    -- Icecrown Glacial Wall
    [50065] = 50729,
    -- Astrylian's Sutured Cinch
    [50067] = 50707,
    -- Rigormortis
    [50068] = 50704,
    -- Professor's Bloodied Smock
    [50069] = 50705,
    -- Treads of the Wasteland
    [50071] = 50711,
    -- Landsoul's Horned Greathelm
    [50072] = 50712,
    -- Geistlord's Punishment Sack
    [50073] = 50713,
    -- Royal Crimson Cloak
    [50074] = 50718,
    -- Taldaram's Plated Fists
    [50075] = 50716,
    -- Shadowblade Breastplate
    [50087] = 51743,
    -- Shadowblade Gauntlets
    [50088] = 51742,
    -- Shadowblade Helmet
    [50089] = 51745,
    -- Shadowblade Legplates
    [50090] = 51744,
    -- Scourgelord Battleplate
    [50094] = 51686,
    -- Scourgelord Gauntlets
    [50095] = 51685,
    -- Scourgelord Helmet
    [50096] = 51684,
    -- Scourgelord Legplates
    [50097] = 51683,
    -- Scourgelord Shoulderplates
    [50098] = 51682,
    -- Shadowblade Pauldrons
    [50105] = 51746,
    -- Lasherweave Robes
    [50106] = 51696,
    -- Lasherweave Gauntlets
    [50107] = 51695,
    -- Lasherweave Helmet
    [50108] = 51694,
    -- Lasherweave Legplates
    [50109] = 51693,
    -- Lasherweave Pauldrons
    [50113] = 51692,
    -- Ahn'Kahar Blood Hunter's Handguards
    [50114] = 51711,
    -- Ahn'Kahar Blood Hunter's Headpiece
    [50115] = 51710,
    -- Ahn'Kahar Blood Hunter's Legguards
    [50116] = 51709,
    -- Ahn'Kahar Blood Hunter's Spaulders
    [50117] = 51708,
    -- Ahn'Kahar Blood Hunter's Tunic
    [50118] = 51707,
    -- Valanar's Other Signet Ring
    [50170] = 50714,
    -- Shoulders of Frost-Tipped Thorns
    [50171] = 50715,
    -- Sanguine Silk Robes
    [50172] = 50717,
    -- Shadow Silk Spindle
    [50173] = 50719,
    -- Incarnadine Band of Mending
    [50174] = 50720,
    -- Crypt Keeper's Bracers
    [50175] = 50721,
    -- San'layn Ritualist Gloves
    [50176] = 50722,
    -- Mail of Crimson Coins
    [50177] = 50723,
    -- Bloodfall
    [50178] = 50727,
    -- Last Word
    [50179] = 50708,
    -- Lana'thel's Chain of Flagellation
    [50180] = 50728,
    -- Dying Light
    [50181] = 50725,
    -- Blood Queen's Crimson Choker
    [50182] = 50724,
    -- Lungbreaker
    [50183] = 50621,
    -- Keleseth's Seducer
    [50184] = 50710,
    -- Devium's Eternally Cold Ring
    [50185] = 50622,
    -- Frostbrood Sapphire Ring
    [50186] = 50618,
    -- Coldwraith Links
    [50187] = 50620,
    -- Anub'ar Stalker's Gloves
    [50188] = 50619,
    -- Scourge Reaver's Legplates
    [50192] = 50624,
    -- Noose of Malachite
    [50195] = 50627,
    -- Leggings of Dying Candles
    [50199] = 50623,
    -- Snowstorm Helm
    [50202] = 50626,
    -- Frostbinder's Shredded Cape
    [50205] = 50628,
    -- Dark Coven Gloves
    [50240] = 51766,
    -- Dark Coven Hood
    [50241] = 51765,
    -- Dark Coven Leggings
    [50242] = 51764,
    -- Dark Coven Robe
    [50243] = 51763,
    -- Dark Coven Shoulderpads
    [50244] = 51762,
    -- Bloodmage Gloves
    [50275] = 51716,
    -- Bloodmage Hood
    [50276] = 51715,
    -- Bloodmage Leggings
    [50277] = 51714,
    -- Bloodmage Robe
    [50278] = 51713,
    -- Bloodmage Shoulderpads
    [50279] = 51712,
    -- Lightsworn Shoulderplates
    [50324] = 51721,
    -- Lightsworn Legplates
    [50325] = 51720,
    -- Lightsworn Helmet
    [50326] = 51719,
    -- Lightsworn Gauntlets
    [50327] = 51718,
    -- Lightsworn Battleplate
    [50328] = 51717,
    -- Toskk's Maximized Wristguards
    [50333] = 50670,
    -- Sliver of Pure Ice
    [50339] = 50346,
    -- Muradin's Spyglass
    [50340] = 50345,
    -- Unidentifiable Organ
    [50341] = 50344,
    -- Whispering Fanged Skull
    [50342] = 50343,
    -- Tiny Abomination in a Jar
    [50351] = 50706,
    -- Corpse Tongue Coin
    [50352] = 50349,
    -- Dislodged Foreign Object
    [50353] = 50348,
    -- Bauble of True Blood
    [50354] = 50726,
    -- Maghia's Misguided Quill
    [50357] = 49686,
    -- Althor's Abacus
    [50359] = 50366,
    -- Phylactery of the Nameless Lich
    [50360] = 50365,
    -- Sindragosa's Flawless Fang
    [50361] = 50364,
    -- Deathbringer's Will
    [50362] = 50363,
    -- Battered Hilt
    [50380] = 50379,
    -- Crimson Acolyte Handwraps
    [50391] = 51738,
    -- Crimson Acolyte Cowl
    [50392] = 51737,
    -- Crimson Acolyte Pants
    [50393] = 51741,
    -- Crimson Acolyte Raiments
    [50394] = 51740,
    -- Crimson Acolyte Mantle
    [50396] = 51739,
    -- Scourgeborne Waraxe
    [50411] = 50654,
    -- Bloodvenom Blade
    [50412] = 50672,
    -- Nerub'ar Stalker's Cord
    [50413] = 50688,
    -- Might of Blight
    [50414] = 50693,
    -- Bryntroll, the Bone Arbiter
    [50415] = 50709,
    -- Boots of the Funeral March
    [50416] = 50632,
    -- Bracers of Eternal Dreaming
    [50417] = 50630,
    -- Robe of the Waking Nightmare
    [50418] = 50629,
    -- Sindragosa's Cruel Claw
    [50421] = 50633,
    -- Sundial of Eternal Dusk
    [50423] = 50635,
    -- Memory of Malygos
    [50424] = 50636,
    -- Oathbinder, Charge of the Ranger-General
    [50425] = 50735,
    -- Heaven's Fall, Kryss of a Thousand Lies
    [50426] = 50736,
    -- Bloodsurge, Kel'Thuzad's Blade of Agony
    [50427] = 50732,
    -- Royal Scepter of Terenas II
    [50428] = 50734,
    -- Archus, Greatstaff of Antonidas
    [50429] = 50731,
    -- Nightmare Ender
    [50472] = 50631,
    -- Bone Warden's Splitter
    [50759] = 51938,
    -- Bonebreaker Scepter
    [50760] = 51937,
    -- Citadel Enforcer's Claymore
    [50761] = 51936,
    -- Linked Scourge Vertebrae
    [50762] = 51935,
    -- Marrowgar's Scratching Choker
    [50763] = 51934,
    -- Shawl of Nerubian Silk
    [50764] = 51933,
    -- Crimson Acolyte Hood
    [50765] = 51736,
    -- Crimson Acolyte Gloves
    [50766] = 51735,
    -- Crimson Acolyte Shoulderpads
    [50767] = 51734,
    -- Crimson Acolyte Robe
    [50768] = 51733,
    -- Crimson Acolyte Leggings
    [50769] = 51732,
    -- Frost Needle
    [50771] = 51932,
    -- Ancient Skeletal Boots
    [50772] = 51931,
    -- Cord of the Patronizing Practitioner
    [50773] = 51930,
    -- Coldwraith Bracers
    [50774] = 51929,
    -- Corrupted Silverplate Leggings
    [50775] = 51928,
    -- Njorndar Bone Bow
    [50776] = 51927,
    -- Handgrips of Frost and Sleet
    [50777] = 51926,
    -- Soulthief's Braided Belt
    [50778] = 51925,
    -- Deathspeaker Zealot's Helm
    [50779] = 51924,
    -- Chestguard of the Frigid Noose
    [50780] = 51923,
    -- Scourgelord's Baton
    [50781] = 51922,
    -- Sister's Handshrouds
    [50782] = 51921,
    -- Boots of the Frozen Seed
    [50783] = 51920,
    -- Deathspeaker Disciple's Belt
    [50784] = 51919,
    -- Bracers of Dark Blessings
    [50785] = 51918,
    -- Ghoul Commander's Cuirass
    [50786] = 51917,
    -- Frost Giant's Cleaver
    [50787] = 51916,
    -- Bone Drake's Enameled Boots
    [50788] = 51915,
    -- Icecrown Rampart Bracers
    [50789] = 51914,
    -- Abomination's Bloody Ring
    [50790] = 51913,
    -- Saronite Gargoyle Cloak
    [50791] = 51912,
    -- Pauldrons of Lost Hope
    [50792] = 51911,
    -- Midnight Sun
    [50793] = 51910,
    -- Neverending Winter
    [50794] = 51909,
    -- Cord of Dark Suffering
    [50795] = 51908,
    -- Bracers of Pale Illumination
    [50796] = 51907,
    -- Ice-Reinforced Vrykul Helm
    [50797] = 51906,
    -- Ramaladni's Blade of Culling
    [50798] = 51905,
    -- Scourge Stranglers
    [50799] = 51904,
    -- Hauberk of a Thousand Cuts
    [50800] = 51903,
    -- Blade-Scored Carapace
    [50801] = 51902,
    -- Gargoyle Spit Bracers
    [50802] = 51901,
    -- Saurfang's Cold-Forged Band
    [50803] = 51900,
    -- Icecrown Spire Sandals
    [50804] = 51899,
    -- Mag'hari Chieftain's Staff
    [50805] = 51898,
    -- Leggings of Unrelenting Blood
    [50806] = 51897,
    -- Thaumaturge's Crackling Cowl
    [50807] = 51896,
    -- Deathforged Legplates
    [50808] = 51895,
    -- Soulcleave Pendant
    [50809] = 51894,
    -- Gutbuster
    [50810] = 51893,
    -- Festering Fingerguards
    [50811] = 51892,
    -- Taldron's Long Neglected Boots
    [50812] = 51891,
    -- Lasherweave Mantle
    [50819] = 51706,
    -- Lasherweave Trousers
    [50820] = 51705,
    -- Lasherweave Cover
    [50821] = 51704,
    -- Lasherweave Gloves
    [50822] = 51703,
    -- Lasherweave Vestment
    [50823] = 51702,
    -- Lasherweave Shoulderpads
    [50824] = 51701,
    -- Lasherweave Legguards
    [50825] = 51700,
    -- Lasherweave Headguard
    [50826] = 51699,
    -- Lasherweave Handgrips
    [50827] = 51698,
    -- Lasherweave Raiment
    [50828] = 51697,
    -- Frost Witch's Chestguard
    [50830] = 51752,
    -- Frost Witch's Grips
    [50831] = 51753,
    -- Frost Witch's Faceguard
    [50832] = 51754,
    -- Frost Witch's War-Kilt
    [50833] = 51755,
    -- Frost Witch's Shoulderguards
    [50834] = 51756,
    -- Frost Witch's Tunic
    [50835] = 51747,
    -- Frost Witch's Handguards
    [50836] = 51748,
    -- Frost Witch's Headpiece
    [50837] = 51749,
    -- Frost Witch's Legguards
    [50838] = 51750,
    -- Frost Witch's Spaulders
    [50839] = 51751,
    -- Frost Witch's Hauberk
    [50841] = 51757,
    -- Frost Witch's Gloves
    [50842] = 51758,
    -- Frost Witch's Helm
    [50843] = 51759,
    -- Frost Witch's Kilt
    [50844] = 51760,
    -- Frost Witch's Shoulderpads
    [50845] = 51761,
    -- Ymirjar Lord's Pauldrons
    [50846] = 51776,
    -- Ymirjar Lord's Legguards
    [50847] = 51775,
    -- Ymirjar Lord's Greathelm
    [50848] = 51774,
    -- Ymirjar Lord's Handguards
    [50849] = 51773,
    -- Ymirjar Lord's Breastplate
    [50850] = 51772,
    -- Precious's Putrid Collar
    [50852] = 51890,
    -- Precious' Putrid Collar
    [50852] = 51890,
    -- Scourgelord Pauldrons
    [50853] = 51691,
    -- Scourgelord Legguards
    [50854] = 51690,
    -- Scourgelord Faceguard
    [50855] = 51689,
    -- Scourgelord Handguards
    [50856] = 51688,
    -- Scourgelord Chestguard
    [50857] = 51687,
    -- Plague-Soaked Leather Leggings
    [50858] = 51889,
    -- Cloak of Many Skins
    [50859] = 51888,
    -- Lightsworn Shoulderguards
    [50860] = 51731,
    -- Lightsworn Legguards
    [50861] = 51730,
    -- Lightsworn Faceguard
    [50862] = 51729,
    -- Lightsworn Handguards
    [50863] = 51728,
    -- Lightsworn Chestguard
    [50864] = 51727,
    -- Lightsworn Spaulders
    [50865] = 51726,
    -- Lightsworn Greaves
    [50866] = 51725,
    -- Lightsworn Headpiece
    [50867] = 51724,
    -- Lightsworn Gloves
    [50868] = 51723,
    -- Lightsworn Tunic
    [50869] = 51722,
    -- Abracadaver
    [50966] = 51887,
    -- Festergut's Gaseous Gloves
    [50967] = 51886,
    -- Wrists of Septic Shock
    [50985] = 51885,
    -- Signet of Putrefaction
    [50986] = 51884,
    -- Bloodstained Surgeon's Shoulderguards
    [50988] = 51883,
    -- Kilt of Untreated Wounds
    [50990] = 51882,
    -- Shaft of Glacial Ice
    [50998] = 51881,
    -- Gluth's Fetching Knife
    [50999] = 51880,
    -- Flesh-Shaper's Gurney Strap
    [51000] = 51879,
    -- Rotface's Rupturing Ring
    [51001] = 51878,
    -- Taldron's Short-Sighted Helm
    [51002] = 51877,
    -- Abomination Knuckles
    [51003] = 51876,
    -- Lockjaw
    [51004] = 51875,
    -- Gloves of Broken Fingers
    [51005] = 51874,
    -- Shuffling Shoes
    [51006] = 51873,
    -- Ether-Soaked Bracers
    [51007] = 51872,
    -- Choker of Filthy Diamonds
    [51008] = 51871,
    -- Chestguard of the Failed Experiment
    [51009] = 51870,
    -- The Facelifter
    [51010] = 51869,
    -- Flesh-Carving Scalpel
    [51011] = 51868,
    -- Infected Choker
    [51012] = 51867,
    -- Discarded Bag of Entrails
    [51013] = 51866,
    -- Scalpel-Sharpening Shoulderguards
    [51014] = 51865,
    -- Shoulderpads of the Morbid Ritual
    [51015] = 51864,
    -- Pendant of Split Veins
    [51016] = 51863,
    -- Cauterized Cord
    [51017] = 51862,
    -- Chestplate of Septic Stitches
    [51018] = 51861,
    -- Rippling Flesh Kilt
    [51019] = 51860,
    -- Shoulders of Ruinous Senility
    [51020] = 51859,
    -- Soulbreaker
    [51021] = 51858,
    -- Hersir's Greatspear
    [51022] = 51857,
    -- Taldaram's Soft Slippers
    [51023] = 51856,
    -- Thrice Fanged Signet
    [51024] = 51855,
    -- Battle-Maiden's Legguards
    [51025] = 51854,
    -- Sanctified Scourgelord Shoulderplates
    [51125] = 51314,
    -- Sanctified Scourgelord Legplates
    [51126] = 51313,
    -- Sanctified Scourgelord Helmet
    [51127] = 51312,
    -- Sanctified Scourgelord Gauntlets
    [51128] = 51311,
    -- Sanctified Scourgelord Battleplate
    [51129] = 51310,
    -- Sanctified Scourgelord Pauldrons
    [51130] = 51309,
    -- Sanctified Scourgelord Legguards
    [51131] = 51308,
    -- Sanctified Scourgelord Handguards
    [51132] = 51307,
    -- Sanctified Scourgelord Faceguard
    [51133] = 51306,
    -- Sanctified Scourgelord Chestguard
    [51134] = 51305,
    -- Sanctified Lasherweave Pauldrons
    [51135] = 51304,
    -- Sanctified Lasherweave Legplates
    [51136] = 51303,
    -- Sanctified Lasherweave Helmet
    [51137] = 51302,
    -- Sanctified Lasherweave Gauntlets
    [51138] = 51301,
    -- Sanctified Lasherweave Robes
    [51139] = 51300,
    -- Sanctified Lasherweave Shoulderpads
    [51140] = 51299,
    -- Sanctified Lasherweave Raiment
    [51141] = 51298,
    -- Sanctified Lasherweave Legguards
    [51142] = 51297,
    -- Sanctified Lasherweave Headguard
    [51143] = 51296,
    -- Sanctified Lasherweave Handgrips
    [51144] = 51295,
    -- Sanctified Lasherweave Vestment
    [51145] = 51294,
    -- Sanctified Lasherweave Trousers
    [51146] = 51293,
    -- Sanctified Lasherweave Mantle
    [51147] = 51292,
    -- Sanctified Lasherweave Gloves
    [51148] = 51291,
    -- Sanctified Lasherweave Cover
    [51149] = 51290,
    -- Sanctified Ahn'Kahar Blood Hunter's Tunic
    [51150] = 51289,
    -- Sanctified Ahn'Kahar Blood Hunter's Spaulders
    [51151] = 51288,
    -- Sanctified Ahn'Kahar Blood Hunter's Legguards
    [51152] = 51287,
    -- Sanctified Ahn'Kahar Blood Hunter's Headpiece
    [51153] = 51286,
    -- Sanctified Ahn'Kahar Blood Hunter's Handguards
    [51154] = 51285,
    -- Sanctified Bloodmage Shoulderpads
    [51155] = 51284,
    -- Sanctified Bloodmage Robe
    [51156] = 51283,
    -- Sanctified Bloodmage Leggings
    [51157] = 51282,
    -- Sanctified Bloodmage Hood
    [51158] = 51281,
    -- Sanctified Bloodmage Gloves
    [51159] = 51280,
    -- Sanctified Crimson Acolyte Shoulderpads
    [51175] = 51264,
    -- Sanctified Crimson Acolyte Robe
    [51176] = 51263,
    -- Sanctified Crimson Acolyte Leggings
    [51177] = 51262,
    -- Sanctified Crimson Acolyte Hood
    [51178] = 51261,
    -- Sanctified Crimson Acolyte Gloves
    [51179] = 51260,
    -- Sanctified Crimson Acolyte Raiments
    [51180] = 51259,
    -- Sanctified Crimson Acolyte Pants
    [51181] = 51258,
    -- Sanctified Crimson Acolyte Mantle
    [51182] = 51257,
    -- Sanctified Crimson Acolyte Handwraps
    [51183] = 51256,
    -- Sanctified Crimson Acolyte Cowl
    [51184] = 51255,
    -- Sanctified Shadowblade Pauldrons
    [51185] = 51254,
    -- Sanctified Shadowblade Legplates
    [51186] = 51253,
    -- Sanctified Shadowblade Helmet
    [51187] = 51252,
    -- Sanctified Shadowblade Gauntlets
    [51188] = 51251,
    -- Sanctified Shadowblade Breastplate
    [51189] = 51250,
    -- Sanctified Frost Witch's Tunic
    [51190] = 51249,
    -- Sanctified Frost Witch's Handguards
    [51191] = 51248,
    -- Sanctified Frost Witch's Headpiece
    [51192] = 51247,
    -- Sanctified Frost Witch's Legguards
    [51193] = 51246,
    -- Sanctified Frost Witch's Spaulders
    [51194] = 51245,
    -- Sanctified Frost Witch's Chestguard
    [51195] = 51244,
    -- Sanctified Frost Witch's Grips
    [51196] = 51243,
    -- Sanctified Frost Witch's Faceguard
    [51197] = 51242,
    -- Sanctified Frost Witch's War-Kilt
    [51198] = 51241,
    -- Sanctified Frost Witch's Shoulderguards
    [51199] = 51240,
    -- Sanctified Frost Witch's Hauberk
    [51200] = 51239,
    -- Sanctified Frost Witch's Gloves
    [51201] = 51238,
    -- Sanctified Frost Witch's Helm
    [51202] = 51237,
    -- Sanctified Frost Witch's Kilt
    [51203] = 51236,
    -- Sanctified Frost Witch's Shoulderpads
    [51204] = 51235,
    -- Sanctified Dark Coven Shoulderpads
    [51205] = 51234,
    -- Sanctified Dark Coven Robe
    [51206] = 51233,
    -- Sanctified Dark Coven Leggings
    [51207] = 51232,
    -- Sanctified Dark Coven Hood
    [51208] = 51231,
    -- Sanctified Dark Coven Gloves
    [51209] = 51230,
    -- Sanctified Ymirjar Lord's Shoulderplates
    [51210] = 51229,
    -- Sanctified Ymirjar Lord's Legplates
    [51211] = 51228,
    -- Sanctified Ymirjar Lord's Helmet
    [51212] = 51227,
    -- Sanctified Ymirjar Lord's Gauntlets
    [51213] = 51226,
    -- Sanctified Ymirjar Lord's Battleplate
    [51214] = 51225,
    -- Sanctified Ymirjar Lord's Pauldrons
    [51215] = 51224,
    -- Sanctified Ymirjar Lord's Legguards
    [51216] = 51223,
    -- Sanctified Ymirjar Lord's Handguards
    [51217] = 51222,
    -- Sanctified Ymirjar Lord's Greathelm
    [51218] = 51221,
    -- Sanctified Ymirjar Lord's Breastplate
    [51219] = 51220,
    -- Sanctified Lightsworn Chestguard
    [51265] = 51174,
    -- Sanctified Lightsworn Faceguard
    [51266] = 51173,
    -- Sanctified Lightsworn Handguards
    [51267] = 51172,
    -- Sanctified Lightsworn Legguards
    [51268] = 51171,
    -- Sanctified Lightsworn Shoulderguards
    [51269] = 51170,
    -- Sanctified Lightsworn Gloves
    [51270] = 51169,
    -- Sanctified Lightsworn Greaves
    [51271] = 51168,
    -- Sanctified Lightsworn Headpiece
    [51272] = 51167,
    -- Sanctified Lightsworn Spaulders
    [51273] = 51166,
    -- Sanctified Lightsworn Tunic
    [51274] = 51165,
    -- Sanctified Lightsworn Battleplate
    [51275] = 51164,
    -- Sanctified Lightsworn Gauntlets
    [51276] = 51163,
    -- Sanctified Lightsworn Helmet
    [51277] = 51162,
    -- Sanctified Lightsworn Legplates
    [51278] = 51161,
    -- Sanctified Lightsworn Shoulderplates
    [51279] = 51160,
    -- Blood-Drinker's Girdle
    [51325] = 51853,
    -- Wand of Ruby Claret
    [51326] = 51852,
    -- Bloodsoul Raiment
    [51379] = 51851,
    -- Pale Corpse Boots
    [51380] = 51850,
    -- Cerise Coiled Ring
    [51381] = 51849,
    -- Heartsick Mender's Cape
    [51382] = 51848,
    -- Spaulders of the Blood Princes
    [51383] = 51847,
    -- Bloodsipper
    [51384] = 51846,
    -- Stakethrower
    [51385] = 51845,
    -- Throatrender Handguards
    [51386] = 51844,
    -- Seal of the Twilight Queen
    [51387] = 51843,
    -- Collar of Haughty Disdain
    [51548] = 51842,
    -- Ivory-Inlaid Leggings
    [51550] = 51841,
    -- Chestguard of Siphoned Elements
    [51551] = 51840,
    -- Shoulderpads of the Searing Kiss
    [51552] = 51839,
    -- Lana'thel's Bloody Nail
    [51553] = 51838,
    -- Cowl of Malefic Repose
    [51554] = 51837,
    -- Tightening Waistband
    [51555] = 51836,
    -- Veincrusher Gauntlets
    [51556] = 51835,
    -- Dreamhunter's Carbine
    [51561] = 51834,
    -- Oxheart
    [51562] = 51833,
    -- Taiga Bindings
    [51563] = 51832,
    -- Ironrope Belt of Ymirjar
    [51564] = 51831,
    -- Skinned Whelp Shoulders
    [51565] = 51830,
    -- Legguards of the Twisted Dream
    [51566] = 51829,
    -- Sister Svalna's Aether Staff
    [51582] = 51828,
    -- Stormbringer Gloves
    [51583] = 51827,
    -- Lich Wrappings
    [51584] = 51826,
    -- Sister Svalna's Spangenhelm
    [51585] = 51825,
    -- Emerald Saint's Spaulders
    [51586] = 51824,
    -- Leggings of the Refracted Mind
    [51777] = 51823,
    -- Rimetooth Pendant
    [51779] = 51822,
    -- Etched Dragonbone Girdle
    [51782] = 51821,
    -- Vambraces of the Frost Wyrm Queen
    [51783] = 51820,
    -- Splintershard
    [51784] = 51819,
    -- Wyrmwing Treads
    [51785] = 51818,
    -- Legplates of Aetheric Strife
    [51786] = 51817,
    -- Scourge Fanged Stompers
    [51787] = 51816,
    -- Bleak Coldarra Carver
    [51788] = 51815,
    -- Icicle Shapers
    [51789] = 51814,
    -- Robes of Azure Downfall
    [51790] = 51813,
    -- Lost Pavise of the Blue Flight
    [51791] = 51812,
    -- Shoulderguards of Crystalline Bone
    [51792] = 51811,
    -- Troggbane, Axe of the Frostborne King
    [51795] = 51947,
    -- Warmace of Menethil
    [51796] = 51946,
    -- Tainted Twig of Nordrassil
    [51797] = 51945,
    -- Valius, Gavel of the Lightbringer
    [51798] = 51944,
    -- Halion, Staff of Forgotten Love
    [51799] = 51943,
    -- Stormfury, Black Blade of the Betrayer
    [51800] = 51942,
    -- Pugius, Fist of Defiance
    [51801] = 51941,
    -- Windrunner's Heartseeker
    [51802] = 51940,
    -- Tel'thas, Dagger of the Blood King
    [51803] = 51939,
    -- Winking Eye of Love
    [51804] = 93392,
    -- Heartbreak Charm
    [51805] = 93391,
    -- Shard of Pirouetting Happiness
    [51806] = 93395,
    -- Sweet Perfume Broach
    [51807] = 93393,
    -- Choker of the Pure Heart
    [51808] = 93394,
    -- Vanquisher's Mark of Sanctification
    [52025] = 52028,
    -- Protector's Mark of Sanctification
    [52026] = 52029,
    -- Conqueror's Mark of Sanctification
    [52027] = 52030,
    -- Jaina's Locket
    [52251] = 51318,
    -- Blazing Hippogryph
    [54069] = 74269,
    -- Abduction's Cover
    [54556] = 53115,
    -- Baltharus' Gift
    [54557] = 53103,
    -- Boots of Divided Being
    [54558] = 53119,
    -- Bracers of the Heir
    [54559] = 53112,
    -- Changeling Gloves
    [54560] = 53117,
    -- Gloaming Sark
    [54561] = 53114,
    -- Misbegotten Belt
    [54562] = 53118,
    -- Saviana's Tribute
    [54563] = 53116,
    -- Scion's Treads
    [54564] = 53111,
    -- Surrogate Belt
    [54565] = 53121,
    -- Twilight Scale Shoulders
    [54566] = 53113,
    -- Zarithrian's Offering
    [54567] = 53110,
    -- Signet of Twilight
    [54576] = 53133,
    -- Returning Footfalls
    [54577] = 53127,
    -- Apocalypse's Advance
    [54578] = 53125,
    -- Treads of Impending Resurrection
    [54579] = 53129,
    -- Umbrage Armbands
    [54580] = 53126,
    -- Penumbra Pendant
    [54581] = 53132,
    -- Bracers of Fiery Night
    [54582] = 53486,
    -- Cloak of Burning Dusk
    [54583] = 53489,
    -- Phaseshifter's Bracers
    [54584] = 53134,
    -- Ring of Phased Regeneration
    [54585] = 53490,
    -- Foreshadow Steps
    [54586] = 53487,
    -- Split Shape Belt
    [54587] = 53488,
    -- Charred Twilight Scale
    [54588] = 54572,
    -- Glowing Twilight Scale
    [54589] = 54573,
    -- Sharpened Twilight Scale
    [54590] = 54569,
    -- Petrified Twilight Scale
    [54591] = 54571,
    -- Jumbotron Power Belt
    [59117] = 65086,
    -- Electron Inductor Coils
    [59118] = 65085,
    -- Voltage Source Chestguard
    [59119] = 65084,
    -- Poison Protocol Pauldrons
    [59120] = 65083,
    -- Lightning Conductor Band
    [59121] = 65082,
    -- Organic Lifeform Inverter
    [59122] = 65081,
    -- Life Force Chargers
    [59216] = 65080,
    -- X-Tron Duct Tape
    [59217] = 65079,
    -- Passive Resistor Spaulders
    [59218] = 65078,
    -- Power Generator Hood
    [59219] = 65077,
    -- Security Measure Alpha
    [59220] = 65076,
    -- Massacre Treads
    [59221] = 65075,
    -- Spaulders of the Scarred Lady
    [59222] = 65074,
    -- Double Attack Handguards
    [59223] = 65073,
    -- Heart of Rage
    [59224] = 65072,
    -- Plated Fists of Provocation
    [59225] = 65071,
    -- Bile-O-Tron Nut
    [59233] = 65070,
    -- Quickstep Galoshes
    [59234] = 65069,
    -- Chaos Beast Bracers
    [59310] = 65068,
    -- Burden of Mortality
    [59311] = 65067,
    -- Helm of the Blind Seer
    [59312] = 65066,
    -- Brackish Gloves
    [59313] = 65065,
    -- Pip's Solution Agitator
    [59314] = 65064,
    -- Boots of Vertigo
    [59315] = 65063,
    -- Battleplate of Ancient Kings
    [59316] = 65062,
    -- Legguards of the Unseeing
    [59317] = 65061,
    -- Sark of the Unwatched
    [59318] = 65060,
    -- Ironstar Amulet
    [59319] = 65059,
    -- Themios the Darkbringer
    [59320] = 65058,
    -- Belt of the Nightmare
    [59321] = 65057,
    -- Bracers of the Burningeye
    [59322] = 65056,
    -- Gloves of Cacophony
    [59324] = 65055,
    -- Mantle of Roaring Flames
    [59325] = 65054,
    -- Bell of Enraging Resonance
    [59326] = 65053,
    -- Kingdom's Heart
    [59327] = 65052,
    -- Molten Tantrum Boots
    [59328] = 65051,
    -- Parasitic Bands
    [59329] = 65050,
    -- Shalug'doom, the Axe of Unmaking
    [59330] = 65145,
    -- Leggings of Lethal Force
    [59331] = 65049,
    -- Symbiotic Worm
    [59332] = 65048,
    -- Lava Spine
    [59333] = 65047,
    -- Lifecycle Waistguard
    [59334] = 65046,
    -- Scorched Wormling Vest
    [59335] = 65045,
    -- Flame Pillar Leggings
    [59336] = 65044,
    -- Mantle of Nefarius
    [59337] = 65043,
    -- Breastplate of Avenging Flame
    [59340] = 65042,
    -- Incineratus
    [59341] = 65041,
    -- Belt of Absolute Zero
    [59342] = 65040,
    -- Aberration's Leggings
    [59343] = 65039,
    -- Dragon Bone Warhelm
    [59344] = 65038,
    -- Tunic of Failed Experiments
    [59346] = 65037,
    -- Mace of Acrid Death
    [59347] = 65036,
    -- Cloak of Biting Chill
    [59348] = 65035,
    -- Belt of Arcane Storms
    [59349] = 65034,
    -- Treads of Flawless Creation
    [59350] = 65033,
    -- Legwraps of the Greatest Son
    [59351] = 65032,
    -- Flash Freeze Gauntlets
    [59352] = 65031,
    -- Leggings of Consuming Flames
    [59353] = 65030,
    -- Jar of Ancient Remedies
    [59354] = 65029,
    -- Chimaeron Armguards
    [59355] = 65028,
    -- Pauldrons of the Apocalypse
    [59356] = 65027,
    -- Prestor's Talisman of Machination
    [59441] = 65026,
    -- Rage of Ages
    [59442] = 65025,
    -- Crul'korak, the Lightning's Arc
    [59443] = 65024,
    -- Akmin-Kurai, Dominion's Shield
    [59444] = 65023,
    -- Belt of the Blackhand
    [59450] = 65022,
    -- Manacles of the Sleeping Beast
    [59451] = 65021,
    -- Crown of Burning Waters
    [59452] = 65020,
    -- Shadowblaze Robes
    [59454] = 65019,
    -- Shadow of Dread
    [59457] = 65018,
    -- Andoros, Fist of the Dragon King
    [59459] = 65017,
    -- Theresa's Booklight
    [59460] = 65016,
    -- Maimgor's Bite
    [59462] = 65014,
    -- Maldo's Sword Cane
    [59463] = 65013,
    -- Treads of Savage Beatings
    [59464] = 65012,
    -- Corehammer's Riveted Girdle
    [59465] = 65011,
    -- Ironstar's Impenetrable Cover
    [59466] = 65010,
    -- Hide of Chromaggus
    [59467] = 65009,
    -- Shadowforge's Lightbound Smock
    [59468] = 65008,
    -- Storm Rider's Boots
    [59469] = 65144,
    -- Bracers of Impossible Strength
    [59470] = 65143,
    -- Pauldrons of the Great Ettin
    [59471] = 65142,
    -- Proto-Handler's Gauntlets
    [59472] = 65141,
    -- Essence of the Cyclone
    [59473] = 65140,
    -- Malevolence
    [59474] = 65139,
    -- Bracers of the Bronze Flight
    [59475] = 65138,
    -- Legguards of the Emerald Brood
    [59476] = 65137,
    -- Helm of the Nether Scion
    [59481] = 65136,
    -- Robes of the Burning Acolyte
    [59482] = 65135,
    -- Wyrmbreaker's Amulet
    [59483] = 65134,
    -- Book of Binding Will
    [59484] = 65133,
    -- Coil of Ten-Thousand Screams
    [59485] = 65132,
    -- Battleplate of the Apocalypse
    [59486] = 65131,
    -- Helm of Maddening Whispers
    [59487] = 65130,
    -- Membrane of C'Thun
    [59490] = 65129,
    -- Akirus the Worm-Breaker
    [59492] = 65007,
    -- Uhn'agh Fash, the Darkest Betrayal
    [59494] = 68600,
    -- Treads of Hideous Transformation
    [59495] = 65128,
    -- Shackles of the End of Days
    [59497] = 65127,
    -- Hands of the Twilight Council
    [59498] = 65126,
    -- Kilt of the Forgotten Battle
    [59499] = 65125,
    -- Fall of Mortality
    [59500] = 65124,
    -- Signet of the Fifth Circle
    [59501] = 65123,
    -- Dispersing Belt
    [59502] = 65122,
    -- Terrastra's Legguards
    [59503] = 65121,
    -- Arion's Crown
    [59504] = 65120,
    -- Gravitational Pull
    [59505] = 65119,
    -- Crushing Weight
    [59506] = 65118,
    -- Glittering Epidermis
    [59507] = 65117,
    -- Treads of Liquid Ice
    [59508] = 65116,
    -- Glaciated Helm
    [59509] = 65115,
    -- Feludius' Mantle
    [59510] = 65114,
    -- Hydrolance Gloves
    [59511] = 65113,
    -- Valiona's Medallion
    [59512] = 65112,
    -- Scepter of Ice
    [59513] = 65111,
    -- Heart of Ignacious
    [59514] = 65110,
    -- Vial of Stolen Memories
    [59515] = 65109,
    -- Drape of the Twins
    [59516] = 65108,
    -- Necklace of Strife
    [59517] = 65107,
    -- Ring of Rivalry
    [59518] = 65106,
    -- Theralion's Mirror
    [59519] = 65105,
    -- Soul Blade
    [59521] = 65103,
    -- Chelley's Staff of Dark Mending
    [59525] = 65102,
    -- Heaving Plates of Protection
    [59901] = 65101,
    -- Phase-Twister Leggings
    [60201] = 65100,
    -- Crossfire Carbine
    [60210] = 65098,
    -- Bracers of the Dark Pool
    [60211] = 65097,
    -- Firelord's Hood
    [60243] = 65210,
    -- Firelord's Robes
    [60244] = 65212,
    -- Firelord's Leggings
    [60245] = 65211,
    -- Firelord's Mantle
    [60246] = 65213,
    -- Firelord's Gloves
    [60247] = 65209,
    -- Shadowflame Handwraps
    [60248] = 65259,
    -- Shadowflame Hood
    [60249] = 65260,
    -- Shadowflame Leggings
    [60250] = 65261,
    -- Shadowflame Robes
    [60251] = 65262,
    -- Shadowflame Mantle
    [60252] = 65263,
    -- Mercurial Shoulderwraps
    [60253] = 65238,
    -- Mercurial Vestment
    [60254] = 65237,
    -- Mercurial Leggings
    [60255] = 65236,
    -- Mercurial Hood
    [60256] = 65235,
    -- Mercurial Gloves
    [60257] = 65234,
    -- Mercurial Cowl
    [60258] = 65230,
    -- Mercurial Robes
    [60259] = 65232,
    -- Mercurial Legwraps
    [60261] = 65231,
    -- Mercurial Mantle
    [60262] = 65233,
    -- Mercurial Handwraps
    [60275] = 65229,
    -- Stormrider's Robes
    [60276] = 65197,
    -- Stormrider's Helm
    [60277] = 65195,
    -- Stormrider's Legwraps
    [60278] = 65196,
    -- Stormrider's Mantle
    [60279] = 65198,
    -- Stormrider's Handwraps
    [60280] = 65194,
    -- Stormrider's Vestment
    [60281] = 65202,
    -- Stormrider's Cover
    [60282] = 65200,
    -- Stormrider's Leggings
    [60283] = 65201,
    -- Stormrider's Shoulderwraps
    [60284] = 65203,
    -- Stormrider's Gloves
    [60285] = 65199,
    -- Stormrider's Headpiece
    [60286] = 65190,
    -- Stormrider's Raiment
    [60287] = 65192,
    -- Stormrider's Legguards
    [60288] = 65191,
    -- Stormrider's Spaulders
    [60289] = 65193,
    -- Stormrider's Grips
    [60290] = 65189,
    -- Wind Dancer's Gloves
    [60298] = 65240,
    -- Wind Dancer's Helmet
    [60299] = 65241,
    -- Wind Dancer's Legguards
    [60300] = 65242,
    -- Wind Dancer's Tunic
    [60301] = 65239,
    -- Wind Dancer's Spaulders
    [60302] = 65243,
    -- Lightning-Charged Headguard
    [60303] = 65206,
    -- Lightning-Charged Tunic
    [60304] = 65204,
    -- Lightning-Charged Legguards
    [60305] = 65207,
    -- Lightning-Charged Spaulders
    [60306] = 65208,
    -- Lightning-Charged Gloves
    [60307] = 65205,
    -- Faceguard of the Raging Elements
    [60308] = 65246,
    -- Tunic of the Raging Elements
    [60309] = 65244,
    -- Legwraps of the Raging Elements
    [60310] = 65247,
    -- Mantle of the Raging Elements
    [60311] = 65248,
    -- Handwraps of the Raging Elements
    [60312] = 65245,
    -- Hauberk of the Raging Elements
    [60313] = 65254,
    -- Gloves of the Raging Elements
    [60314] = 65255,
    -- Headpiece of the Raging Elements
    [60315] = 65256,
    -- Kilt of the Raging Elements
    [60316] = 65257,
    -- Shoulderwraps of the Raging Elements
    [60317] = 65258,
    -- Cuirass of the Raging Elements
    [60318] = 65249,
    -- Grips of the Raging Elements
    [60319] = 65250,
    -- Helmet of the Raging Elements
    [60320] = 65251,
    -- Legguards of the Raging Elements
    [60321] = 65252,
    -- Spaulders of the Raging Elements
    [60322] = 65253,
    -- Earthen Battleplate
    [60323] = 65264,
    -- Earthen Legplates
    [60324] = 65267,
    -- Earthen Helmet
    [60325] = 65266,
    -- Earthen Gauntlets
    [60326] = 65265,
    -- Earthen Pauldrons
    [60327] = 65268,
    -- Earthen Faceguard
    [60328] = 65271,
    -- Earthen Chestguard
    [60329] = 65269,
    -- Earthen Legguards
    [60330] = 65272,
    -- Earthen Shoulderguards
    [60331] = 65273,
    -- Earthen Handguards
    [60332] = 65270,
    -- Magma Plated Battleplate
    [60339] = 65179,
    -- Magma Plated Gauntlets
    [60340] = 65180,
    -- Magma Plated Helmet
    [60341] = 65181,
    -- Magma Plated Legplates
    [60342] = 65182,
    -- Magma Plated Pauldrons
    [60343] = 65183,
    -- Reinforced Sapphirium Battleplate
    [60344] = 65214,
    -- Reinforced Sapphirium Gauntlets
    [60345] = 65215,
    -- Reinforced Sapphirium Helmet
    [60346] = 65216,
    -- Reinforced Sapphirium Legplates
    [60347] = 65217,
    -- Reinforced Sapphirium Pauldrons
    [60348] = 65218,
    -- Magma Plated Chestguard
    [60349] = 65184,
    -- Magma Plated Handguards
    [60350] = 65185,
    -- Magma Plated Faceguard
    [60351] = 65186,
    -- Magma Plated Legguards
    [60352] = 65187,
    -- Magma Plated Shoulderguards
    [60353] = 65188,
    -- Reinforced Sapphirium Chestguard
    [60354] = 65224,
    -- Reinforced Sapphirium Handguards
    [60355] = 65225,
    -- Reinforced Sapphirium Faceguard
    [60356] = 65226,
    -- Reinforced Sapphirium Legguards
    [60357] = 65227,
    -- Reinforced Sapphirium Shoulderguards
    [60358] = 65228,
    -- Reinforced Sapphirium Headguard
    [60359] = 65221,
    -- Reinforced Sapphirium Breastplate
    [60360] = 65219,
    -- Reinforced Sapphirium Greaves
    [60361] = 65222,
    -- Reinforced Sapphirium Mantle
    [60362] = 65223,
    -- Reinforced Sapphirium Gloves
    [60363] = 65220,
    -- Vicious Gladiator's Clasp of Cruelty
    [60505] = 70540,
    -- Vicious Gladiator's Greaves of Salvation
    [60506] = 60519,
    -- Vicious Gladiator's Bracers of Salvation
    [60507] = 60515,
    -- Vicious Gladiator's Girdle of Cruelty
    [60508] = 70573,
    -- Vicious Gladiator's Armplates of Alacrity
    [60512] = 70513,
    -- Vicious Gladiator's Girdle of Salvation
    [60517] = 60518,
    -- Vicious Gladiator's Bracers of Prowess
    [60520] = 70530,
    -- Vicious Gladiator's Girdle of Prowess
    [60521] = 70574,
    -- Vicious Gladiator's Armplates of Proficiency
    [60523] = 70514,
    -- Vicious Gladiator's Waistguard of Meditation
    [60533] = 70666,
    -- Vicious Gladiator's Armbands of Meditation
    [60535] = 70511,
    -- Vicious Gladiator's Waistguard of Cruelty
    [60536] = 70665,
    -- Vicious Gladiator's Clasp of Meditation
    [60539] = 70541,
    -- Vicious Gladiator's Bracers of Meditation
    [60541] = 70529,
    -- Vicious Gladiator's Links of Cruelty
    [60555] = 70596,
    -- Vicious Gladiator's Wristguards of Alacrity
    [60559] = 70670,
    -- Vicious Gladiator's Links of Accuracy
    [60564] = 70595,
    -- Vicious Gladiator's Wristguards of Accuracy
    [60565] = 70669,
    -- Vicious Gladiator's Waistguard of Salvation
    [60566] = 60571,
    -- Vicious Gladiator's Armbands of Prowess
    [60569] = 70512,
    -- Vicious Gladiator's Belt of Meditation
    [60580] = 70524,
    -- Vicious Gladiator's Bindings of Meditation
    [60582] = 70525,
    -- Vicious Gladiator's Belt of Cruelty
    [60583] = 70523,
    -- Vicious Gladiator's Boots of Dominance
    [60584] = 60610,
    -- Vicious Gladiator's Armwraps of Dominance
    [60585] = 60608,
    -- Vicious Gladiator's Waistband of Cruelty
    [60586] = 70664,
    -- Vicious Gladiator's Waistband of Accuracy
    [60589] = 70663,
    -- Vicious Gladiator's Armwraps of Accuracy
    [60591] = 70515,
    -- Vicious Gladiator's Armwraps of Alacrity
    [60594] = 70516,
    -- Vicious Gladiator's Belt of Dominance
    [60606] = 60609,
    -- Vicious Gladiator's Bindings of Prowess
    [60611] = 70526,
    -- Vicious Gladiator's Cord of Cruelty
    [60612] = 70545,
    -- Vicious Gladiator's Cuffs of Dominance
    [60614] = 60629,
    -- Vicious Gladiator's Cord of Accuracy
    [60626] = 70544,
    -- Vicious Gladiator's Treads of Dominance
    [60627] = 60633,
    -- Vicious Gladiator's Cuffs of Accuracy
    [60628] = 70547,
    -- Vicious Gladiator's Cord of Dominance
    [60631] = 60632,
    -- Vicious Gladiator's Cuffs of Prowess
    [60634] = 70549,
    -- Vicious Gladiator's Cuffs of Meditation
    [60635] = 70548,
    -- Vicious Gladiator's Cord of Meditation
    [60637] = 70546,
    -- Vicious Gladiator's Band of Cruelty
    [60645] = 70521,
    -- Vicious Gladiator's Band of Accuracy
    [60647] = 70520,
    -- Vicious Gladiator's Band of Dominance
    [60649] = 70522,
    -- Vicious Gladiator's Band of Meditation
    [60649] = 70522,
    -- Vicious Gladiator's Signet of Cruelty
    [60650] = 70654,
    -- Vicious Gladiator's Signet of Accuracy
    [60651] = 70653,
    -- Vicious Gladiator's Ring of Accuracy
    [60658] = 70637,
    -- Vicious Gladiator's Ring of Cruelty
    [60659] = 70638,
    -- Vicious Gladiator's Pendant of Diffusion
    [60661] = 70621,
    -- Vicious Gladiator's Pendant of Alacrity
    [60662] = 70620,
    -- Vicious Gladiator's Pendant of Meditation
    [60664] = 70622,
    -- Vicious Gladiator's Necklace of Prowess
    [60668] = 70614,
    -- Vicious Gladiator's Necklace of Proficiency
    [60669] = 70613,
    -- Vicious Gladiator's Choker of Proficiency
    [60670] = 70539,
    -- Vicious Gladiator's Choker of Accuracy
    [60673] = 70538,
    -- Vicious Gladiator's Cloak of Alacrity
    [60776] = 70542,
    -- Vicious Gladiator's Cloak of Prowess
    [60778] = 70543,
    -- Vicious Gladiator's Cape of Prowess
    [60779] = 70532,
    -- Vicious Gladiator's Cape of Cruelty
    [60783] = 70531,
    -- Vicious Gladiator's Cloak of Dominance
    [60784] = 60785,
    -- Vicious Gladiator's Drape of Diffusion
    [60786] = 70555,
    -- Vicious Gladiator's Drape of Prowess
    [60787] = 70557,
    -- Vicious Gladiator's Drape of Meditation
    [60788] = 70556,
    -- Fortune Card
    [60840] = 60844,
    -- Vicious Gladiator's Emblem of Cruelty
    [61026] = 70563,
    -- Vicious Gladiator's Emblem of Meditation
    [61031] = 70564,
    -- Vicious Gladiator's Emblem of Tenacity
    [61032] = 70565,
    -- Vicious Gladiator's Badge of Conquest
    [61033] = 70517,
    -- Vicious Gladiator's Badge of Victory
    [61034] = 70519,
    -- Vicious Gladiator's Badge of Dominance
    [61035] = 70518,
    -- Vicious Gladiator's Insignia of Dominance
    [61045] = 70578,
    -- Vicious Gladiator's Insignia of Victory
    [61046] = 70579,
    -- Vicious Gladiator's Insignia of Conquest
    [61047] = 70577,
    -- Vicious Gladiator's Cleaver
    [61324] = 67474,
    -- Vicious Gladiator's Hacker
    [61325] = 67473,
    -- Vicious Gladiator's Decapitator
    [61326] = 67453,
    -- Vicious Gladiator's Shanker
    [61327] = 67472,
    -- Vicious Gladiator's Shiv
    [61328] = 67460,
    -- Vicious Gladiator's Spellblade
    [61329] = 67457,
    -- Vicious Gladiator's Right Ripper
    [61330] = 67456,
    -- Vicious Gladiator's Ripper
    [61330] = 67456,
    -- Vicious Gladiator's Fleshslicer
    [61331] = 67459,
    -- Vicious Gladiator's Left Ripper
    [61331] = 67459,
    -- Vicious Gladiator's Slasher
    [61332] = 67458,
    -- Vicious Gladiator's Left Render
    [61332] = 67458,
    -- Vicious Gladiator's Right Render
    [61333] = 67455,
    -- Vicious Gladiator's Pummeler
    [61335] = 67471,
    -- Vicious Gladiator's Bonecracker
    [61336] = 67470,
    -- Vicious Gladiator's Gavel
    [61338] = 67454,
    -- Vicious Gladiator's Bonegrinder
    [61339] = 67452,
    -- Vicious Gladiator's Pike
    [61340] = 67451,
    -- Vicious Gladiator's Battle Staff
    [61341] = 67450,
    -- Vicious Gladiator's Energy Staff
    [61342] = 67449,
    -- Vicious Gladiator's Staff
    [61343] = 67448,
    -- Vicious Gladiator's Slicer
    [61344] = 67469,
    -- Vicious Gladiator's Quickblade
    [61345] = 67468,
    -- Vicious Gladiator's Greatsword
    [61346] = 67447,
    -- Vicious Gladiator's War Edge
    [61347] = 67467,
    -- Vicious Gladiator's Hatchet
    [61348] = 67466,
    -- Vicious Gladiator's Touch of Defeat
    [61350] = 67465,
    -- Vicious Gladiator's Baton of Light
    [61351] = 67464,
    -- Vicious Gladiator's Longbow
    [61353] = 67461,
    -- Vicious Gladiator's Rifle
    [61354] = 67463,
    -- Vicious Gladiator's Heavy Crossbow
    [61355] = 67462,
    -- Vicious Gladiator's Endgame
    [61357] = 67479,
    -- Vicious Gladiator's Reprieve
    [61358] = 67478,
    -- Vicious Gladiator's Shield Wall
    [61359] = 67477,
    -- Vicious Gladiator's Barrier
    [61360] = 67476,
    -- Vicious Gladiator's Redoubt
    [61361] = 67475,
    -- Vicious Gladiator's Relic of Dominance
    [61388] = 70629,
    -- Vicious Gladiator's Relic of Salvation
    [61389] = 70630,
    -- Vicious Gladiator's Relic of Triumph
    [61390] = 70631,
    -- Vicious Gladiator's Relic of Conquest
    [61391] = 70628,
    -- QA PVP Test CC Break Trinket Crit
    [61818] = 61819,
    -- QA PVP Test CC Break Trinket Expertise
    [61820] = 61821,
    -- QA PVP Test CC Break Trinket Haste
    [61822] = 61823,
    -- QA PVP Test CC Break Trinket Hit
    [61824] = 61825,
    -- QA PVP Test CC Break Trinket Mastery
    [61826] = 61827,
    -- QA PVP Test CC Break Trinket Resilience
    [61828] = 61829,
    -- QA PVP Test CC Break Trinket Spirit
    [61830] = 61831,
    -- Darkmoon Card: Hurricane
    [62049] = 62051,
    -- Guild Vault Voucher (8th Slot)
    [62287] = 68136,
    -- Greater Inscription of Unbreakable Quartz
    [62333] = 68717,
    -- Greater Inscription of Charged Lodestone
    [62343] = 68715,
    -- Greater Inscription of Jagged Stone
    [62345] = 68716,
    -- Greater Inscription of Shattered Crystal
    [62346] = 68714,
    -- Reins of the Drake of the West Wind
    [63039] = 65356,
    -- Mistral Circle
    [63488] = 65367,
    -- Permafrost Signet
    [63489] = 65372,
    -- Sky Strider Belt
    [63490] = 65369,
    -- Thunder Wall Belt
    [63491] = 65370,
    -- Star Chaser Belt
    [63492] = 65368,
    -- Wind Stalker Belt
    [63493] = 65371,
    -- Planetary Band
    [63494] = 65373,
    -- Tempest Keeper Belt
    [63495] = 65375,
    -- Lightning Well Belt
    [63496] = 65377,
    -- Gale Rouser Belt
    [63497] = 65374,
    -- Soul Breath Belt
    [63498] = 65376,
    -- Cloudburst Ring
    [63499] = 65382,
    -- Sky Strider Greaves
    [63500] = 65379,
    -- Thunder Wall Greaves
    [63501] = 65380,
    -- Star Chaser Legguards
    [63502] = 65378,
    -- Wind Stalker Leggings
    [63503] = 65381,
    -- Tempest Keeper Leggings
    [63504] = 65385,
    -- Lightning Well Legguards
    [63505] = 65386,
    -- Gale Rouser Leggings
    [63506] = 65384,
    -- Soul Breath Leggings
    [63507] = 65383,
    -- Daybreaker Helm
    [63531] = 65096,
    -- Dragonheart Piercer
    [63532] = 65095,
    -- Fang of Twilight
    [63533] = 65094,
    -- Helm of Eldritch Authority
    [63534] = 65093,
    -- Waistguard of Hatred
    [63535] = 65092,
    -- Blade of the Witching Hour
    [63536] = 65091,
    -- Claws of Torment
    [63537] = 65006,
    -- Claws of Agony
    [63538] = 65005,
    -- Circuit Design Breastplate
    [63540] = 65004,
    -- Reclaimed Ashkandi, Greatsword of the Brotherhood
    [63679] = 65003,
    -- Twilight's Hammer
    [63680] = 65090,
    -- Battle Standard of Coordination
    [64399] = 64402,
    -- Cloak of Coordination
    [65274] = 65360,
    -- Miniature Winter Veil Tree
    [66540] = 93625,
    -- Scales of Life
    [68915] = 69109,
    -- Variable Pulse Lightning Capacitor
    [68925] = 69110,
    -- Jaws of Defeat
    [68926] = 69111,
    -- The Hungerer
    [68927] = 69112,
    -- Apparatus of Khaz'goroth
    [68972] = 69113,
    -- Spidersilk Spindle
    [68981] = 69138,
    -- Necromantic Focus
    [68982] = 69139,
    -- Eye of Blazing Power
    [68983] = 69149,
    -- Matrix Restabilizer
    [68994] = 69150,
    -- Vessel of Acceleration
    [68995] = 69167,
    -- Stay of Execution
    [68996] = 69184,
    -- Rune of Zeth
    [68998] = 69185,
    -- Fiery Quintessence
    [69000] = 69198,
    -- Ancient Petrified Seed
    [69001] = 69199,
    -- Essence of the Eternal Flame
    [69002] = 69200,
    -- Timeless Eye
    [69238] = 69245,
    -- Twinblade of the Hakkari
    [69620] = 69621,
    -- Branch of Nordrassil
    [69646] = 71084,
    -- Mistral Pendant
    [69827] = 69880,
    -- Permafrost Choker
    [69828] = 69883,
    -- Cloudburst Necklace
    [69829] = 69885,
    -- Planetary Amulet
    [69830] = 69882,
    -- Mistral Drape
    [69831] = 69884,
    -- Permafrost Cape
    [69833] = 69878,
    -- Cloudburst Cloak
    [69834] = 69879,
    -- Planetary Drape
    [69835] = 69881,
    -- Fandral's Flamescythe
    [69897] = 71466,
    -- Ruthless Gladiator's Greatsword
    [70178] = 70231,
    -- Ruthless Gladiator's Staff
    [70179] = 70228,
    -- Ruthless Gladiator's Energy Staff
    [70180] = 70227,
    -- Ruthless Gladiator's Battle Staff
    [70181] = 70226,
    -- Ruthless Gladiator's Pike
    [70182] = 70225,
    -- Ruthless Gladiator's Bonegrinder
    [70183] = 70224,
    -- Ruthless Gladiator's Decapitator
    [70184] = 70213,
    -- Ruthless Gladiator's Gavel
    [70185] = 70223,
    -- Ruthless Gladiator's Right Render
    [70186] = 70220,
    -- Ruthless Gladiator's Right Ripper
    [70187] = 70217,
    -- Ruthless Gladiator's Ripper
    [70187] = 70217,
    -- Ruthless Gladiator's Spellblade
    [70188] = 70216,
    -- Ruthless Gladiator's Slasher
    [70189] = 70219,
    -- Ruthless Gladiator's Left Render
    [70189] = 70219,
    -- Ruthless Gladiator's Fleshslicer
    [70190] = 70218,
    -- Ruthless Gladiator's Left Ripper
    [70190] = 70218,
    -- Ruthless Gladiator's Shiv
    [70191] = 70215,
    -- Ruthless Gladiator's Longbow
    [70192] = 70236,
    -- Ruthless Gladiator's Heavy Crossbow
    [70193] = 70238,
    -- Ruthless Gladiator's Rifle
    [70194] = 70237,
    -- Ruthless Gladiator's Baton of Light
    [70195] = 70235,
    -- Ruthless Gladiator's Touch of Defeat
    [70196] = 70234,
    -- Ruthless Gladiator's Hatchet
    [70197] = 70233,
    -- Ruthless Gladiator's War Edge
    [70198] = 70232,
    -- Ruthless Gladiator's Quickblade
    [70199] = 70230,
    -- Ruthless Gladiator's Slicer
    [70200] = 70229,
    -- Ruthless Gladiator's Bonecracker
    [70201] = 70222,
    -- Ruthless Gladiator's Pummeler
    [70202] = 70221,
    -- Ruthless Gladiator's Shanker
    [70203] = 70214,
    -- Ruthless Gladiator's Hacker
    [70204] = 70212,
    -- Ruthless Gladiator's Cleaver
    [70205] = 70211,
    -- Ruthless Gladiator's Redoubt
    [70206] = 70243,
    -- Ruthless Gladiator's Barrier
    [70207] = 70242,
    -- Ruthless Gladiator's Shield Wall
    [70208] = 70241,
    -- Ruthless Gladiator's Reprieve
    [70209] = 70240,
    -- Ruthless Gladiator's Endgame
    [70210] = 70239,
    -- Ruthless Gladiator's Clasp of Cruelty
    [70319] = 72383,
    -- Ruthless Gladiator's Girdle of Cruelty
    [70320] = 72394,
    -- Ruthless Gladiator's Armplates of Alacrity
    [70322] = 72399,
    -- Ruthless Gladiator's Bracers of Prowess
    [70325] = 72387,
    -- Ruthless Gladiator's Girdle of Prowess
    [70326] = 72395,
    -- Ruthless Gladiator's Armplates of Proficiency
    [70327] = 72398,
    -- Ruthless Gladiator's Waistguard of Meditation
    [70328] = 72427,
    -- Ruthless Gladiator's Armbands of Meditation
    [70330] = 72431,
    -- Ruthless Gladiator's Waistguard of Cruelty
    [70331] = 72442,
    -- Ruthless Gladiator's Clasp of Meditation
    [70332] = 72384,
    -- Ruthless Gladiator's Bracers of Meditation
    [70334] = 72388,
    -- Ruthless Gladiator's Links of Cruelty
    [70336] = 72362,
    -- Ruthless Gladiator's Wristguards of Alacrity
    [70338] = 72366,
    -- Ruthless Gladiator's Links of Accuracy
    [70339] = 72363,
    -- Ruthless Gladiator's Wristguards of Accuracy
    [70340] = 72367,
    -- Ruthless Gladiator's Armbands of Prowess
    [70342] = 72430,
    -- Ruthless Gladiator's Belt of Meditation
    [70343] = 72342,
    -- Ruthless Gladiator's Bindings of Meditation
    [70345] = 72344,
    -- Ruthless Gladiator's Belt of Cruelty
    [70346] = 72350,
    -- Ruthless Gladiator's Waistband of Cruelty
    [70347] = 72416,
    -- Ruthless Gladiator's Waistband of Accuracy
    [70349] = 72417,
    -- Ruthless Gladiator's Armwraps of Accuracy
    [70350] = 72421,
    -- Ruthless Gladiator's Armwraps of Alacrity
    [70352] = 72420,
    -- Ruthless Gladiator's Bindings of Prowess
    [70359] = 72352,
    -- Ruthless Gladiator's Cord of Cruelty
    [70360] = 72313,
    -- Ruthless Gladiator's Cord of Accuracy
    [70362] = 72314,
    -- Ruthless Gladiator's Cuffs of Accuracy
    [70363] = 72319,
    -- Ruthless Gladiator's Cuffs of Prowess
    [70365] = 72320,
    -- Ruthless Gladiator's Cuffs of Meditation
    [70366] = 72321,
    -- Ruthless Gladiator's Cord of Meditation
    [70368] = 72315,
    -- Ruthless Gladiator's Band of Cruelty
    [70369] = 72329,
    -- Ruthless Gladiator's Band of Accuracy
    [70370] = 72330,
    -- Ruthless Gladiator's Signet of Cruelty
    [70372] = 72457,
    -- Ruthless Gladiator's Signet of Accuracy
    [70373] = 72458,
    -- Ruthless Gladiator's Ring of Accuracy
    [70374] = 72312,
    -- Ruthless Gladiator's Ring of Cruelty
    [70375] = 72311,
    -- Ruthless Gladiator's Pendant of Diffusion
    [70376] = 72326,
    -- Ruthless Gladiator's Pendant of Alacrity
    [70377] = 72325,
    -- Ruthless Gladiator's Pendant of Meditation
    [70378] = 72327,
    -- Ruthless Gladiator's Necklace of Prowess
    [70379] = 72308,
    -- Ruthless Gladiator's Necklace of Proficiency
    [70380] = 72307,
    -- Ruthless Gladiator's Choker of Proficiency
    [70381] = 72453,
    -- Ruthless Gladiator's Choker of Accuracy
    [70382] = 72454,
    -- Ruthless Gladiator's Cloak of Alacrity
    [70383] = 72451,
    -- Ruthless Gladiator's Cloak of Prowess
    [70384] = 72452,
    -- Ruthless Gladiator's Cape of Prowess
    [70385] = 72306,
    -- Ruthless Gladiator's Cape of Cruelty
    [70386] = 72305,
    -- Ruthless Gladiator's Drape of Diffusion
    [70387] = 72323,
    -- Ruthless Gladiator's Drape of Prowess
    [70388] = 72322,
    -- Ruthless Gladiator's Drape of Meditation
    [70389] = 72324,
    -- Ruthless Gladiator's Emblem of Cruelty
    [70396] = 72359,
    -- Ruthless Gladiator's Emblem of Meditation
    [70397] = 72361,
    -- Ruthless Gladiator's Emblem of Tenacity
    [70398] = 72360,
    -- Ruthless Gladiator's Badge of Conquest
    [70399] = 72304,
    -- Ruthless Gladiator's Badge of Victory
    [70400] = 72450,
    -- Ruthless Gladiator's Badge of Dominance
    [70401] = 72448,
    -- Ruthless Gladiator's Insignia of Dominance
    [70402] = 72449,
    -- Ruthless Gladiator's Insignia of Victory
    [70403] = 72455,
    -- Ruthless Gladiator's Insignia of Conquest
    [70404] = 72309,
    -- Ruthless Gladiator's Relic of Dominance
    [70405] = 72328,
    -- Ruthless Gladiator's Relic of Salvation
    [70406] = 72358,
    -- Ruthless Gladiator's Relic of Triumph
    [70407] = 72310,
    -- Ruthless Gladiator's Relic of Conquest
    [70408] = 72456,
    -- Sulfuras, The Extinguished Hand
    [70723] = 71352,
    -- Alysra's Razor
    [70733] = 71427,
    -- Greathelm of the Voracious Maw
    [70734] = 71430,
    -- Flickering Wristbands
    [70735] = 71428,
    -- Moltenfeather Leggings
    [70736] = 71429,
    -- Spaulders of Recurring Flame
    [70737] = 71432,
    -- Alysrazor's Band
    [70738] = 71433,
    -- Lavaworm Legplates
    [70739] = 71431,
    -- Cracked Obsidian Stompers
    [70912] = 71420,
    -- Legplates of Frenzied Devotion
    [70913] = 71444,
    -- Carapace of Imbibed Flame
    [70914] = 71405,
    -- Shard of Torment
    [70915] = 71460,
    -- Helm of Blazing Glory
    [70916] = 71459,
    -- Flickering Handguards
    [70917] = 71458,
    -- Bracers of the Fiery Path
    [70920] = 71470,
    -- Pauldrons of Roaring Flame
    [70921] = 71612,
    -- Mandible of Beth'tilac
    [70922] = 71406,
    -- Firebound Gorget
    [70929] = 71563,
    -- Durable Flamewrath Greatcloak
    [70930] = 71392,
    -- Girdle of the Indomitable Flame
    [70933] = 71400,
    -- Stoneheart Necklace
    [70935] = 71589,
    -- Bracers of Regal Force
    [70937] = 71585,
    -- Deathclutch Figurine
    [70939] = 71590,
    -- Deflecting Brimstone Band
    [70940] = 71591,
    -- Shoulderguards of the Molten Giant
    [70941] = 71608,
    -- Legguards of the Molten Giant
    [70942] = 71607,
    -- Handguards of the Molten Giant
    [70943] = 71605,
    -- Faceguard of the Molten Giant
    [70944] = 71606,
    -- Chestguard of the Molten Giant
    [70945] = 71604,
    -- Immolation Shoulderguards
    [70946] = 71526,
    -- Immolation Legguards
    [70947] = 71525,
    -- Immolation Faceguard
    [70948] = 71524,
    -- Immolation Handguards
    [70949] = 71523,
    -- Immolation Chestguard
    [70950] = 71522,
    -- Elementium Deathplate Shoulderguards
    [70951] = 71485,
    -- Elementium Deathplate Legguards
    [70952] = 71484,
    -- Elementium Deathplate Handguards
    [70953] = 71482,
    -- Elementium Deathplate Faceguard
    [70954] = 71483,
    -- Elementium Deathplate Chestguard
    [70955] = 71481,
    -- Craterflame Spaulders
    [70985] = 71438,
    -- Clawshaper Gauntlets
    [70986] = 71437,
    -- Phoenix-Down Treads
    [70987] = 71436,
    -- Clutch of the Firemother
    [70988] = 71439,
    -- Leggings of Billowing Fire
    [70989] = 71435,
    -- Wings of Flame
    [70990] = 71434,
    -- Arbalest of Erupting Fury
    [70991] = 71414,
    -- Dreadfire Drape
    [70992] = 71415,
    -- Fireskin Gauntlets
    [70993] = 71419,
    -- Hood of Rampant Disdain
    [71003] = 71416,
    -- Earthcrack Bracers
    [71004] = 71418,
    -- Flaming Core Chestguard
    [71005] = 71417,
    -- Volcanospike
    [71006] = 71422,
    -- Grips of the Raging Giant
    [71007] = 71426,
    -- Lava Line Wristbands
    [71009] = 71425,
    -- Incendic Chestguard
    [71010] = 71424,
    -- Flickering Cowl
    [71011] = 71421,
    -- Heartstone of Rhyolith
    [71012] = 71423,
    -- Feeding Frenzy
    [71013] = 71441,
    -- Skullstealer Greataxe
    [71014] = 71445,
    -- Scalp of the Bandit Prince
    [71018] = 71442,
    -- Necklace of Fetishes
    [71019] = 71446,
    -- Gloves of Dissolving Smoke
    [71020] = 71440,
    -- Uncrushable Belt of Fury
    [71021] = 71443,
    -- Goblet of Anger
    [71022] = 71448,
    -- Coalwalker Sandals
    [71023] = 71447,
    -- Crystal Prison Band
    [71024] = 71449,
    -- Flickering Shoulderpads
    [71025] = 71450,
    -- Bracers of the Dread Hunter
    [71026] = 71452,
    -- Treads of Implicit Obedience
    [71027] = 71451,
    -- Legplates of Absolute Control
    [71028] = 71453,
    -- Arachnaflame Treads
    [71029] = 71404,
    -- Flickering Shoulders
    [71030] = 71403,
    -- Cinderweb Leggings
    [71031] = 71402,
    -- Widow's Kiss
    [71032] = 71401,
    -- Ward of the Red Widow
    [71038] = 71408,
    -- Funeral Pyre
    [71039] = 71409,
    -- Cowl of the Clicking Menace
    [71040] = 71411,
    -- Robes of Smoldering Devastation
    [71041] = 71407,
    -- Thoracic Flame Kilt
    [71042] = 71412,
    -- Spaulders of Manifold Eyes
    [71043] = 71413,
    -- Cindersilk Gloves
    [71044] = 71410,
    -- Dark Phoenix Tunic
    [71045] = 71537,
    -- Dark Phoenix Gloves
    [71046] = 71538,
    -- Dark Phoenix Helmet
    [71047] = 71539,
    -- Dark Phoenix Legguards
    [71048] = 71540,
    -- Dark Phoenix Spaulders
    [71049] = 71541,
    -- Flamewaker's Gloves
    [71050] = 71502,
    -- Flamewaker's Headguard
    [71051] = 71503,
    -- Flamewaker's Legguards
    [71052] = 71504,
    -- Flamewaker's Spaulders
    [71053] = 71505,
    -- Flamewaker's Tunic
    [71054] = 71501,
    -- Elementium Deathplate Breastplate
    [71058] = 71476,
    -- Elementium Deathplate Gauntlets
    [71059] = 71477,
    -- Elementium Deathplate Helmet
    [71060] = 71478,
    -- Elementium Deathplate Greaves
    [71061] = 71479,
    -- Elementium Deathplate Pauldrons
    [71062] = 71480,
    -- Immolation Battleplate
    [71063] = 71512,
    -- Immolation Gauntlets
    [71064] = 71513,
    -- Immolation Helmet
    [71065] = 71514,
    -- Immolation Legplates
    [71066] = 71515,
    -- Immolation Pauldrons
    [71067] = 71516,
    -- Battleplate of the Molten Giant
    [71068] = 71600,
    -- Gauntlets of the Molten Giant
    [71069] = 71601,
    -- Helmet of the Molten Giant
    [71070] = 71599,
    -- Legplates of the Molten Giant
    [71071] = 71602,
    -- Pauldrons of the Molten Giant
    [71072] = 71603,
    -- Immolation Breastplate
    [71091] = 71517,
    -- Immolation Gloves
    [71092] = 71518,
    -- Immolation Headguard
    [71093] = 71519,
    -- Immolation Greaves
    [71094] = 71520,
    -- Immolation Mantle
    [71095] = 71521,
    -- Obsidian Arborweave Grips
    [71097] = 71487,
    -- Obsidian Arborweave Headpiece
    [71098] = 71488,
    -- Obsidian Arborweave Legguards
    [71099] = 71489,
    -- Obsidian Arborweave Raiment
    [71100] = 71486,
    -- Obsidian Arborweave Spaulders
    [71101] = 71490,
    -- Obsidian Arborweave Handwraps
    [71102] = 71491,
    -- Obsidian Arborweave Helm
    [71103] = 71492,
    -- Obsidian Arborweave Legwraps
    [71104] = 71493,
    -- Obsidian Arborweave Tunic
    [71105] = 71494,
    -- Obsidian Arborweave Robes
    [71105] = 71494,
    -- Obsidian Arborweave Mantle
    [71106] = 71495,
    -- Obsidian Arborweave Gloves
    [71107] = 71496,
    -- Obsidian Arborweave Cover
    [71108] = 71497,
    -- Obsidian Arborweave Leggings
    [71109] = 71498,
    -- Obsidian Arborweave Vestment
    [71110] = 71499,
    -- Obsidian Arborweave Shoulderwraps
    [71111] = 71500,
    -- Necklace of Smoke Signals
    [71129] = 71565,
    -- Flamebinder Bracers
    [71130] = 71569,
    -- Flamebinding Girdle
    [71131] = 71394,
    -- Covenant of the Flame
    [71146] = 71567,
    -- Relic of the Elemental Lords
    [71147] = 71587,
    -- Soulflame Vial
    [71148] = 71580,
    -- Singed Plume of Aviana
    [71149] = 71577,
    -- Scorchvine Wand
    [71150] = 71579,
    -- Trail of Embers
    [71151] = 71575,
    -- Morningstar Shard
    [71152] = 71568,
    -- Giantslicer
    [71154] = 71593,
    -- Serrated Brimstone Signet
    [71208] = 71588,
    -- Splintered Brimstone Seal
    [71209] = 71566,
    -- Crystalline Brimstone Ring
    [71210] = 71574,
    -- Soothing Brimstone Circle
    [71211] = 71578,
    -- Stoneheart Choker
    [71212] = 71586,
    -- Amulet of Burning Brilliance
    [71213] = 71573,
    -- Firemind Pendant
    [71214] = 71576,
    -- Deflecting Star
    [71218] = 71592,
    -- Bladed Flamewrath Cover
    [71227] = 71391,
    -- Sleek Flamewrath Cloak
    [71228] = 71388,
    -- Flowing Flamewrath Cape
    [71229] = 71390,
    -- Rippling Flamewrath Drape
    [71230] = 71389,
    -- Firescar Sash
    [71249] = 71395,
    -- Cinch of the Flaming Ember
    [71250] = 71399,
    -- Belt of the Seven Seals
    [71253] = 71398,
    -- Firemend Cinch
    [71254] = 71397,
    -- Firearrow Belt
    [71255] = 71396,
    -- Embereye Belt
    [71258] = 71393,
    -- Bracers of Imperious Truths
    [71260] = 71583,
    -- Gigantiform Bracers
    [71261] = 71584,
    -- Smolderskull Bindings
    [71262] = 71581,
    -- Bracers of Misting Ash
    [71263] = 71582,
    -- Bracers of Forked Lightning
    [71264] = 71570,
    -- Emberflame Bracers
    [71265] = 71571,
    -- Firesoul Wristguards
    [71266] = 71572,
    -- Handwraps of the Cleansing Flame
    [71271] = 71527,
    -- Cowl of the Cleansing Flame
    [71272] = 71528,
    -- Legwraps of the Cleansing Flame
    [71273] = 71529,
    -- Robes of the Cleansing Flame
    [71274] = 71530,
    -- Mantle of the Cleansing Flame
    [71275] = 71531,
    -- Gloves of the Cleansing Flame
    [71276] = 71532,
    -- Hood of the Cleansing Flame
    [71277] = 71533,
    -- Leggings of the Cleansing Flame
    [71278] = 71534,
    -- Vestment of the Cleansing Flame
    [71279] = 71535,
    -- Shoulderwraps of the Cleansing Flame
    [71280] = 71536,
    -- Balespider's Handwraps
    [71281] = 71594,
    -- Balespider's Hood
    [71282] = 71595,
    -- Balespider's Leggings
    [71283] = 71596,
    -- Balespider's Robes
    [71284] = 71597,
    -- Balespider's Mantle
    [71285] = 71598,
    -- Firehawk Gloves
    [71286] = 71507,
    -- Firehawk Hood
    [71287] = 71508,
    -- Firehawk Leggings
    [71288] = 71509,
    -- Firehawk Robes
    [71289] = 71510,
    -- Firehawk Mantle
    [71290] = 71511,
    -- Erupting Volcanic Hauberk
    [71291] = 71552,
    -- Erupting Volcanic Gloves
    [71292] = 71553,
    -- Erupting Volcanic Headpiece
    [71293] = 71554,
    -- Erupting Volcanic Kilt
    [71294] = 71555,
    -- Erupting Volcanic Shoulderwraps
    [71295] = 71556,
    -- Erupting Volcanic Tunic
    [71296] = 71542,
    -- Erupting Volcanic Handwraps
    [71297] = 71543,
    -- Erupting Volcanic Faceguard
    [71298] = 71544,
    -- Erupting Volcanic Legwraps
    [71299] = 71545,
    -- Erupting Volcanic Mantle
    [71300] = 71546,
    -- Erupting Volcanic Cuirass
    [71301] = 71547,
    -- Erupting Volcanic Grips
    [71302] = 71548,
    -- Erupting Volcanic Helmet
    [71303] = 71549,
    -- Erupting Volcanic Legguards
    [71304] = 71550,
    -- Erupting Volcanic Spaulders
    [71305] = 71551,
    -- Gatecrasher
    [71312] = 71454,
    -- Sandals of Leaping Coals
    [71313] = 71467,
    -- Breastplate of the Incendiary Soul
    [71314] = 71455,
    -- Decimation Treads
    [71315] = 71457,
    -- Molten Scream
    [71323] = 71462,
    -- Direbrew's Bloodied Shanker
    [71331] = 107217,
    -- Tremendous Tankard O' Terror
    [71332] = 107218,
    -- Gatekeeper's Embrace
    [71340] = 71464,
    -- Glowing Wing Bracers
    [71341] = 71463,
    -- Casque of Flame
    [71342] = 71465,
    -- Mantle of Closed Doors
    [71343] = 71461,
    -- Breastplate of Shifting Visions
    [71344] = 71469,
    -- Shoulderpads of the Forgotten Gate
    [71345] = 71456,
    -- Grips of Unerring Precision
    [71346] = 71468,
    -- Stinger of the Flaming Scorpion
    [71347] = 71473,
    -- Flowform Choker
    [71348] = 71472,
    -- Firecat Leggings
    [71349] = 71474,
    -- Wristwraps of Arrogant Doom
    [71350] = 71471,
    -- Treads of the Penitent Man
    [71351] = 71475,
    -- Arathar, the Eye of Flame
    [71353] = 71611,
    -- Choker of the Vanquished Lord
    [71354] = 71610,
    -- Ko'gun, Hammer of the Firelord
    [71355] = 71615,
    -- Crown of Flame
    [71356] = 71616,
    -- Majordomo's Chain of Office
    [71357] = 71613,
    -- Fingers of Incineration
    [71358] = 71614,
    -- Chelley's Sterilized Scalpel
    [71359] = 71560,
    -- Spire of Scarlet Pain
    [71360] = 71559,
    -- Ranseur of Hatred
    [71361] = 71557,
    -- Obsidium Cleaver
    [71362] = 71562,
    -- Hide-Bound Chains
    [71365] = 71561,
    -- Lava Bolt Crossbow
    [71366] = 71558,
    -- Theck's Emberseal
    [71367] = 71564,
    -- Riplimb's Lost Collar
    [71640] = 71641,
    -- Smoldering Censer of Purity
    [71774] = 71775,
    -- Eye of Purification
    [71776] = 71777,
    -- Avool's Incendiary Shanker
    [71778] = 71779,
    -- Zoid's Firelit Greatsword
    [71780] = 71781,
    -- Shatterskull Bonecrusher
    [71782] = 71783,
    -- Firethorn Mindslicer
    [71784] = 71785,
    -- Entrail Disgorger
    [71786] = 71787,
    -- Sho'ravon, Greatstaff of Annihilation
    [71797] = 71798,
    -- Stormy Deepholm Iolite
    [71818] = 77140,
    -- Infused Elven Peridot
    [71826] = 77131,
    -- Balanced Elven Peridot
    [71828] = 77130,
    -- Vivid Elven Peridot
    [71829] = 77143,
    -- Turbid Elven Peridot
    [71830] = 77142,
    -- Radiant Elven Peridot
    [71831] = 77154,
    -- Shattered Elven Peridot
    [71832] = 77137,
    -- Steady Elven Peridot
    [71839] = 77139,
    -- Lucent Lava Coral
    [71857] = 77132,
    -- Tenuous Lava Coral
    [71858] = 77141,
    -- Willful Lava Coral
    [71859] = 77144,
    -- Splendid Lava Coral
    [71860] = 77138,
    -- Resplendent Lava Coral
    [71861] = 77136,
    -- Mysterious Shadow Spinel
    [71867] = 77133,
    -- Mystic Lightstone
    [71878] = 77134,
    -- Ruthless Gladiator's Band of Meditation
    [72331] = 70371,
    -- Cataclysmic Gladiator's War Edge
    [73412] = 73445,
    -- Cataclysmic Gladiator's Shield Wall
    [73413] = 73446,
    -- Cataclysmic Gladiator's Slicer
    [73414] = 73447,
    -- Cataclysmic Gladiator's Bonecracker
    [73415] = 73448,
    -- Cataclysmic Gladiator's Hacker
    [73416] = 73449,
    -- Cataclysmic Gladiator's Baton of Light
    [73417] = 73450,
    -- Cataclysmic Gladiator's Slasher
    [73418] = 73451,
    -- Cataclysmic Gladiator's Left Render
    [73418] = 73451,
    -- Cataclysmic Gladiator's Right Render
    [73419] = 73452,
    -- Cataclysmic Gladiator's Fleshslicer
    [73420] = 73453,
    -- Cataclysmic Gladiator's Left Ripper
    [73420] = 73453,
    -- Cataclysmic Gladiator's Right Ripper
    [73421] = 73454,
    -- Cataclysmic Gladiator's Ripper
    [73421] = 73454,
    -- Cataclysmic Gladiator's Shanker
    [73422] = 73455,
    -- Cataclysmic Gladiator's Pike
    [73423] = 73456,
    -- Cataclysmic Gladiator's Energy Staff
    [73424] = 73457,
    -- Cataclysmic Gladiator's Redoubt
    [73425] = 73458,
    -- Cataclysmic Gladiator's Gavel
    [73426] = 73459,
    -- Cataclysmic Gladiator's Rifle
    [73427] = 73460,
    -- Cataclysmic Gladiator's Shiv
    [73428] = 73461,
    -- Cataclysmic Gladiator's Staff
    [73429] = 73462,
    -- Cataclysmic Gladiator's Heavy Crossbow
    [73430] = 73463,
    -- Cataclysmic Gladiator's Touch of Defeat
    [73431] = 73464,
    -- Cataclysmic Gladiator's Reprieve
    [73432] = 73465,
    -- Cataclysmic Gladiator's Battle Staff
    [73433] = 73466,
    -- Cataclysmic Gladiator's Spellblade
    [73434] = 73467,
    -- Cataclysmic Gladiator's Barrier
    [73435] = 73468,
    -- Cataclysmic Gladiator's Endgame
    [73436] = 73469,
    -- Cataclysmic Gladiator's Longbow
    [73437] = 73470,
    -- Cataclysmic Gladiator's Hatchet
    [73438] = 73471,
    -- Cataclysmic Gladiator's Quickblade
    [73439] = 73472,
    -- Cataclysmic Gladiator's Pummeler
    [73440] = 73473,
    -- Cataclysmic Gladiator's Cleaver
    [73441] = 73474,
    -- Cataclysmic Gladiator's Greatsword
    [73442] = 73475,
    -- Cataclysmic Gladiator's Bonegrinder
    [73443] = 73476,
    -- Cataclysmic Gladiator's Decapitator
    [73444] = 73477,
    -- Cataclysmic Gladiator's Plate Shoulders
    [73478] = 73651,
    -- Cataclysmic Gladiator's Plate Legguards
    [73479] = 73652,
    -- Cataclysmic Gladiator's Plate Helm
    [73480] = 73653,
    -- Cataclysmic Gladiator's Plate Gauntlets
    [73481] = 73654,
    -- Cataclysmic Gladiator's Plate Chestpiece
    [73482] = 73655,
    -- Cataclysmic Gladiator's Felweave Amice
    [73483] = 73656,
    -- Cataclysmic Gladiator's Felweave Raiment
    [73484] = 73657,
    -- Cataclysmic Gladiator's Felweave Trousers
    [73485] = 73658,
    -- Cataclysmic Gladiator's Felweave Cowl
    [73486] = 73659,
    -- Cataclysmic Gladiator's Felweave Handguards
    [73487] = 73660,
    -- Cataclysmic Gladiator's Relic of Conquest
    [73490] = 74783,
    -- Cataclysmic Gladiator's Mail Spaulders
    [73502] = 73661,
    -- Cataclysmic Gladiator's Mail Leggings
    [73503] = 73662,
    -- Cataclysmic Gladiator's Mail Helm
    [73504] = 73663,
    -- Cataclysmic Gladiator's Mail Gauntlets
    [73505] = 73664,
    -- Cataclysmic Gladiator's Mail Armor
    [73506] = 73665,
    -- Cataclysmic Gladiator's Linked Spaulders
    [73508] = 73666,
    -- Cataclysmic Gladiator's Linked Leggings
    [73509] = 73667,
    -- Cataclysmic Gladiator's Linked Helm
    [73510] = 73668,
    -- Cataclysmic Gladiator's Linked Gauntlets
    [73511] = 73669,
    -- Cataclysmic Gladiator's Linked Armor
    [73512] = 73670,
    -- Cataclysmic Gladiator's Ringmail Spaulders
    [73513] = 73671,
    -- Cataclysmic Gladiator's Ringmail Leggings
    [73514] = 73672,
    -- Cataclysmic Gladiator's Ringmail Helm
    [73515] = 73673,
    -- Cataclysmic Gladiator's Ringmail Gauntlets
    [73516] = 73674,
    -- Cataclysmic Gladiator's Ringmail Armor
    [73517] = 73675,
    -- Cataclysmic Gladiator's Sabatons of Meditation
    [73520] = 73676,
    -- Cataclysmic Gladiator's Leather Spaulders
    [73523] = 73678,
    -- Cataclysmic Gladiator's Leather Legguards
    [73524] = 73679,
    -- Cataclysmic Gladiator's Leather Helm
    [73525] = 73680,
    -- Cataclysmic Gladiator's Leather Gloves
    [73526] = 73681,
    -- Cataclysmic Gladiator's Leather Tunic
    [73527] = 73682,
    -- Cataclysmic Gladiator's Boots of Alacrity
    [73530] = 73683,
    -- Cataclysmic Gladiator's Boots of Cruelty
    [73531] = 73684,
    -- Cataclysmic Gladiator's Medallion of Meditation
    [73534] = 73535,
    -- Cataclysmic Gladiator's Medallion of Tenacity
    [73536] = 73537,
    -- Cataclysmic Gladiator's Medallion of Cruelty
    [73538] = 73539,
    -- Cataclysmic Gladiator's Satin Mantle
    [73540] = 73685,
    -- Cataclysmic Gladiator's Satin Robe
    [73541] = 73686,
    -- Cataclysmic Gladiator's Satin Leggings
    [73542] = 73687,
    -- Cataclysmic Gladiator's Satin Hood
    [73543] = 73688,
    -- Cataclysmic Gladiator's Satin Gloves
    [73544] = 73689,
    -- Cataclysmic Gladiator's Mooncloth Mantle
    [73545] = 73690,
    -- Cataclysmic Gladiator's Mooncloth Robe
    [73546] = 73691,
    -- Cataclysmic Gladiator's Mooncloth Leggings
    [73547] = 73692,
    -- Cataclysmic Gladiator's Mooncloth Helm
    [73548] = 73693,
    -- Cataclysmic Gladiator's Mooncloth Gloves
    [73549] = 73694,
    -- Cataclysmic Gladiator's Warboots of Alacrity
    [73552] = 73695,
    -- Cataclysmic Gladiator's Warboots of Cruelty
    [73553] = 73696,
    -- Cataclysmic Gladiator's Ornamented Spaulders
    [73556] = 73697,
    -- Cataclysmic Gladiator's Ornamented Legplates
    [73557] = 73698,
    -- Cataclysmic Gladiator's Ornamented Headcover
    [73558] = 73699,
    -- Cataclysmic Gladiator's Ornamented Gloves
    [73559] = 73700,
    -- Cataclysmic Gladiator's Ornamented Chestguard
    [73560] = 73701,
    -- Cataclysmic Gladiator's Greaves of Meditation
    [73563] = 73702,
    -- Cataclysmic Gladiator's Greaves of Alacrity
    [73564] = 73703,
    -- Cataclysmic Gladiator's Scaled Shoulders
    [73567] = 73704,
    -- Cataclysmic Gladiator's Scaled Legguards
    [73568] = 73705,
    -- Cataclysmic Gladiator's Scaled Helm
    [73569] = 73706,
    -- Cataclysmic Gladiator's Scaled Gauntlets
    [73570] = 73707,
    -- Cataclysmic Gladiator's Scaled Chestpiece
    [73571] = 73708,
    -- Cataclysmic Gladiator's Silk Amice
    [73572] = 73709,
    -- Cataclysmic Gladiator's Silk Robe
    [73573] = 73710,
    -- Cataclysmic Gladiator's Silk Trousers
    [73574] = 73711,
    -- Cataclysmic Gladiator's Silk Cowl
    [73575] = 73712,
    -- Cataclysmic Gladiator's Silk Handguards
    [73576] = 73713,
    -- Cataclysmic Gladiator's Chain Spaulders
    [73580] = 73714,
    -- Cataclysmic Gladiator's Chain Leggings
    [73581] = 73715,
    -- Cataclysmic Gladiator's Chain Helm
    [73582] = 73716,
    -- Cataclysmic Gladiator's Chain Gauntlets
    [73583] = 73717,
    -- Cataclysmic Gladiator's Chain Armor
    [73584] = 73718,
    -- Cataclysmic Gladiator's Sabatons of Cruelty
    [73588] = 73720,
    -- Cataclysmic Gladiator's Relic of Salvation
    [73594] = 74784,
    -- Cataclysmic Gladiator's Wyrmhide Spaulders
    [73595] = 73721,
    -- Cataclysmic Gladiator's Wyrmhide Robes
    [73596] = 73722,
    -- Cataclysmic Gladiator's Wyrmhide Legguards
    [73597] = 73723,
    -- Cataclysmic Gladiator's Wyrmhide Helm
    [73598] = 73724,
    -- Cataclysmic Gladiator's Wyrmhide Gloves
    [73599] = 73725,
    -- Cataclysmic Gladiator's Footguards of Alacrity
    [73601] = 73726,
    -- Cataclysmic Gladiator's Kodohide Spaulders
    [73603] = 73727,
    -- Cataclysmic Gladiator's Kodohide Robes
    [73604] = 73728,
    -- Cataclysmic Gladiator's Kodohide Legguards
    [73605] = 73729,
    -- Cataclysmic Gladiator's Kodohide Helm
    [73606] = 73730,
    -- Cataclysmic Gladiator's Kodohide Gloves
    [73607] = 73731,
    -- Cataclysmic Gladiator's Footguards of Meditation
    [73609] = 73732,
    -- Cataclysmic Gladiator's Dragonhide Spaulders
    [73611] = 73733,
    -- Cataclysmic Gladiator's Dragonhide Robes
    [73612] = 73734,
    -- Cataclysmic Gladiator's Dragonhide Legguards
    [73613] = 73735,
    -- Cataclysmic Gladiator's Dragonhide Helm
    [73614] = 73736,
    -- Cataclysmic Gladiator's Dragonhide Gloves
    [73615] = 73737,
    -- Cataclysmic Gladiator's Dreadplate Shoulders
    [73616] = 73738,
    -- Cataclysmic Gladiator's Dreadplate Legguards
    [73617] = 73739,
    -- Cataclysmic Gladiator's Dreadplate Helm
    [73618] = 73740,
    -- Cataclysmic Gladiator's Dreadplate Gauntlets
    [73619] = 73741,
    -- Cataclysmic Gladiator's Dreadplate Chestpiece
    [73620] = 73742,
    -- Cataclysmic Gladiator's Relic of Dominance
    [73624] = 74785,
    -- Cataclysmic Gladiator's Treads of Meditation
    [73634] = 73743,
    -- Cataclysmic Gladiator's Treads of Alacrity
    [73635] = 73744,
    -- Cataclysmic Gladiator's Treads of Cruelty
    [73636] = 73745,
    -- Cataclysmic Gladiator's Relic of Triumph
    [73642] = 74786,
    -- Grand Marshal's Demolisher
    [77549] = 234568,
    -- Grand Marshal's Swiftblade
    [77550] = 234579,
    -- Grand Marshal's Dirk
    [77551] = 234582,
    -- Grand Marshal's Mageblade
    [77552] = 234574,
    -- Grand Marshal's Warhammer
    [77553] = 234576,
    -- Grand Marshal's Sunderer
    [77554] = 234566,
    -- Grand Marshal's Hand Cannon
    [77555] = 234587,
    -- Grand Marshal's Stave
    [77556] = 234571,
    -- Grand Marshal's Right Hand Blade
    [77557] = 234583,
    -- Grand Marshal's Punisher
    [77558] = 234581,
    -- Grand Marshal's Left Hand Blade
    [77559] = 234584,
    -- Grand Marshal's Claymore
    [77560] = 234565,
    -- Grand Marshal's Longsword
    [77561] = 234578,
    -- Grand Marshal's Handaxe
    [77562] = 234580,
    -- Grand Marshal's Battle Hammer
    [77563] = 234567,
    -- Grand Marshal's Glaive
    [77564] = 234569,
    -- Grand Marshal's Bullseye
    [77565] = 234585,
    -- Grand Marshal's Repeater
    [77566] = 234586,
    -- Replica High Warlord's Battle Mace
    [77567] = 77570,
    -- Replica High Warlord's Spellblade
    [77568] = 77586,
    -- Replica High Warlord's Quickblade
    [77569] = 77588,
    -- Replica High Warlord's Destroyer
    [77571] = 77587,
    -- High Warlord's Pig Sticker
    [77572] = 234547,
    -- High Warlord's Pulverizer
    [77573] = 234545,
    -- High Warlord's Battle Axe
    [77574] = 234543,
    -- High Warlord's Right Claw
    [77575] = 234557,
    -- High Warlord's Greatsword
    [77577] = 234542,
    -- High Warlord's Recurve
    [77578] = 234559,
    -- High Warlord's Street Sweeper
    [77579] = 234561,
    -- High Warlord's Cleaver
    [77580] = 234554,
    -- High Warlord's War Staff
    [77581] = 234549,
    -- High Warlord's Blade
    [77582] = 234552,
    -- High Warlord's Left Claw
    [77583] = 234558,
    -- High Warlord's Bludgeon
    [77584] = 234555,
    -- High Warlord's Crossbow
    [77585] = 234560,
    -- High Warlord's Tome of Mending
    [77592] = 234564,
    -- High Warlord's Tome of Destruction
    [77593] = 234563,
    -- Grand Marshal's Tome of Restoration
    [77594] = 234590,
    -- Grand Marshal's Tome of Power
    [77595] = 234589,
    -- Grand Marshal's Aegis
    [77596] = 234588,
    -- High Warlord's Shield Wall
    [77597] = 234562,
    -- Marshal's Dragonhide Gauntlets
    [77666] = 231706,
    -- Field Marshal's Dragonhide Spaulders
    [77667] = 231699,
    -- Marshal's Dragonhide Legguards
    [77668] = 231703,
    -- Marshal's Dragonhide Boots
    [77669] = 231698,
    -- Marshal's Chain Legguards
    [77675] = 231577,
    -- Field Marshal's Chain Helm
    [77676] = 231580,
    -- Marshal's Chain Grips
    [77677] = 231560,
    -- Field Marshal's Silk Vestments
    [77678] = 231603,
    -- Field Marshal's Silk Spaulders
    [77679] = 231602,
    -- Marshal's Silk Leggings
    [77680] = 231605,
    -- Marshal's Silk Gloves
    [77681] = 231607,
    -- Field Marshal's Coronet
    [77682] = 231604,
    -- Marshal's Silk Footwraps
    [77683] = 231606,
    -- Marshal's Lamellar Gloves
    [77685] = 231643,
    -- Field Marshal's Lamellar Chestplate
    [77687] = 231641,
    -- Field Marshal's Lamellar Pauldrons
    [77689] = 231645,
    -- Field Marshal's Satin Mantle
    [77692] = 231628,
    -- Marshal's Leather Leggings
    [77696] = 231548,
    -- Field Marshal's Leather Epaulets
    [77697] = 231547,
    -- Marshal's Leather Handgrips
    [77698] = 231544,
    -- Marshal's Leather Footguards
    [77699] = 231546,
    -- Field Marshal's Leather Mask
    [77700] = 231545,
    -- Field Marshal's Leather Chestpiece
    [77701] = 231543,
    -- Marshal's Dreadweave Boots
    [77708] = 231585,
    -- Field Marshal's Dreadweave Shoulders
    [77709] = 231583,
    -- Field Marshal's Coronal
    [77710] = 231584,
    -- Marshal's Dreadweave Leggings
    [77711] = 231587,
    -- Field Marshal's Dreadweave Robe
    [77712] = 231582,
    -- Marshal's Dreadweave Gloves
    [77713] = 231586,
    -- Field Marshal's Plate Armor
    [77714] = 231536,
    -- Field Marshal's Plate Helm
    [77715] = 231538,
    -- Marshal's Plate Gauntlets
    [77716] = 231541,
    -- Marshal's Plate Legguards
    [77717] = 231540,
    -- Field Marshal's Plate Shoulderguards
    [77718] = 231537,
    -- Marshal's Plate Boots
    [77719] = 231539,
    -- General's Dragonhide Boots
    [77875] = 231682,
    -- General's Dragonhide Leggings
    [77877] = 231685,
    -- General's Dragonhide Gloves
    [77879] = 231677,
    -- Warlord's Chain Shoulders
    [77880] = 231572,
    -- General's Chain Legguards
    [77881] = 231574,
    -- Warlord's Silk Cowl
    [77886] = 231601,
    -- General's Silk Boots
    [77888] = 231597,
    -- Warlord's Silk Raiment
    [77889] = 231596,
    -- Warlord's Silk Amice
    [77890] = 231594,
    -- General's Silk Trousers
    [77891] = 231595,
    -- Warlord's Satin Mantle
    [77899] = 231631,
    -- Warlord's Satin Robes
    [77901] = 231612,
    -- General's Satin Leggings
    [77902] = 231614,
    -- General's Leather Treads
    [77904] = 231552,
    -- General's Leather Mitts
    [77905] = 231555,
    -- General's Leather Legguards
    [77906] = 231554,
    -- Warlord's Leather Spaulders
    [77907] = 231551,
    -- Warlord's Leather Breastplate
    [77908] = 231549,
    -- Warlord's Leather Helm
    [77909] = 231553,
    -- Warlord's Mail Spaulders
    [77910] = 231659,
    -- General's Mail Boots
    [77911] = 231667,
    -- General's Mail Gauntlets
    [77912] = 231660,
    -- Warlord's Mail Helm
    [77913] = 231663,
    -- General's Mail Leggings
    [77915] = 231664,
    -- General's Dreadweave Gloves
    [77916] = 231589,
    -- Warlord's Dreadweave Hood
    [77917] = 231590,
    -- General's Dreadweave Boots
    [77918] = 231593,
    -- Warlord's Dreadweave Robe
    [77919] = 231591,
    -- Warlord's Dreadweave Mantle
    [77920] = 231592,
    -- General's Dreadweave Pants
    [77921] = 231588,
    -- General's Plate Boots
    [77922] = 231531,
    -- Warlord's Plate Shoulders
    [77923] = 231534,
    -- Warlord's Plate Armor
    [77924] = 231530,
    -- General's Plate Gauntlets
    [77925] = 231532,
    -- General's Plate Leggings
    [77926] = 231533,
    -- Warlord's Plate Headpiece
    [77927] = 231535,
    -- Relic of Xuen
    [79327] = 79328,
    -- Pandaren Kite String
    [81559] = 89785,
    -- Malevolent Gladiator's Drape of Cruelty
    [84801] = 91477,
    -- Malevolent Gladiator's Drape of Meditation
    [84802] = 91479,
    -- Malevolent Gladiator's Cape of Cruelty
    [84804] = 91453,
    -- Malevolent Gladiator's Cape of Prowess
    [84805] = 91454,
    -- Malevolent Gladiator's Cloak of Prowess
    [84806] = 91765,
    -- Malevolent Gladiator's Cloak of Alacrity
    [84807] = 91764,
    -- Malevolent Gladiator's Band of Meditation
    [84825] = 91493,
    -- Malevolent Gladiator's Ring of Cruelty
    [84826] = 91458,
    -- Malevolent Gladiator's Ring of Accuracy
    [84827] = 91459,
    -- Malevolent Gladiator's Signet of Cruelty
    [84828] = 91769,
    -- Malevolent Gladiator's Signet of Accuracy
    [84829] = 91770,
    -- Malevolent Gladiator's Pendant of Alacrity
    [84886] = 91489,
    -- Malevolent Gladiator's Pendant of Meditation
    [84888] = 91490,
    -- Malevolent Gladiator's Necklace of Proficiency
    [84889] = 91455,
    -- Malevolent Gladiator's Necklace of Prowess
    [84890] = 91456,
    -- Malevolent Gladiator's Choker of Proficiency
    [84891] = 91766,
    -- Malevolent Gladiator's Choker of Accuracy
    [84892] = 91767,
    -- Malevolent Gladiator's Badge of Conquest
    [84934] = 91452,
    -- Malevolent Gladiator's Insignia of Conquest
    [84935] = 91457,
    -- Malevolent Gladiator's Emblem of Cruelty
    [84936] = 91562,
    -- Malevolent Gladiator's Insignia of Victory
    [84937] = 91768,
    -- Malevolent Gladiator's Emblem of Tenacity
    [84938] = 91563,
    -- Malevolent Gladiator's Emblem of Meditation
    [84939] = 91564,
    -- Malevolent Gladiator's Insignia of Dominance
    [84941] = 91754,
    -- Malevolent Gladiator's Badge of Victory
    [84942] = 91763,
    -- Malevolent Gladiator's Armwraps of Alacrity
    [84972] = 91692,
    -- Malevolent Gladiator's Armwraps of Accuracy
    [84973] = 91599,
    -- Malevolent Gladiator's Bracers of Prowess
    [84974] = 91638,
    -- Malevolent Gladiator's Bracers of Meditation
    [84975] = 91639,
    -- Malevolent Gladiator's Bindings of Meditation
    [84976] = 91524,
    -- Malevolent Gladiator's Cuffs of Prowess
    [84978] = 91475,
    -- Malevolent Gladiator's Wristguards of Alacrity
    [84980] = 91573,
    -- Malevolent Gladiator's Wristguards of Accuracy
    [84981] = 91574,
    -- Malevolent Gladiator's Bindings of Prowess
    [84982] = 91541,
    -- Malevolent Gladiator's Armbands of Prowess
    [84983] = 91709,
    -- Malevolent Gladiator's Armbands of Meditation
    [84984] = 91710,
    -- Malevolent Gladiator's Armplates of Proficiency
    [84985] = 91658,
    -- Malevolent Gladiator's Armplates of Alacrity
    [84986] = 91659,
    -- Mysterious Note
    [87261] = 87262,
    -- Tolakesh, Horn of the Black Ox
    [87547] = 100966,
    -- Reins of the Great Green Dragon Turtle
    [87801] = 91012,
    -- Reins of the Great Black Dragon Turtle
    [87802] = 91011,
    -- Reins of the Great Blue Dragon Turtle
    [87803] = 91013,
    -- Reins of the Great Brown Dragon Turtle
    [87804] = 91014,
    -- Reins of the Great Purple Dragon Turtle
    [87805] = 91015,
    -- Minh's Beaten Bracers
    [88893] = 98069,
    -- Simple Harmonius Ring
    [89072] = 98048,
    -- Leggings of the Poisoned Soul
    [89088] = 98073,
    -- Sky-Sear Cowl
    [90409] = 98064,
    -- Sandals of the Shadow
    [90913] = 98047,
    -- The Brassiest Knuckle
    [95050] = 95051,
    -- Shan'ze Scholar's Girdle
    [95517] = 95526,
    -- Pain-Binder Girdle
    [95518] = 95527,
    -- Skumblade-Tooth Girdle
    [95519] = 95528,
    -- Girdle of Shan'ze Glory
    [95520] = 95529,
    -- Cinch of the Dead Forest's Vigil
    [95521] = 95530,
    -- Rotting Bog Cinch
    [95522] = 95531,
    -- Belt of Loa Charms
    [95523] = 95532,
    -- Thunder Caressed Waistguard
    [95524] = 95533,
    -- Skumblade Ritualist Links
    [95525] = 95534,
    -- Refurbished Band of Jin
    [97187] = 97192,
    -- Restored Hexxer's Signet
    [97188] = 97193,
    -- Ancient Primalist's Seal
    [97189] = 97194,
    -- Refurbished Seal of Jin
    [97190] = 97195,
    -- Ancient Overlord's Onyx Band
    [97191] = 97196,
    -- Thunder-Chaser Cloak
    [97203] = 97208,
    -- Static-Collecting Cloak
    [97204] = 97209,
    -- Shan'ze Gravetender Cloak
    [97205] = 97210,
    -- Shan'ze Partisan's Greatcloak
    [97206] = 97211,
    -- Cloak of the Immortal Guardian
    [97207] = 97212,
    -- Unclaimed Black Market Container
    [97565] = 102137,
    -- Unbending Spirit Coif
    [97625] = 97774,
    -- Unbending Spirit Gauntlets
    [97626] = 97773,
    -- Unbending Spirit Boots
    [97627] = 97772,
    -- Unbending Spirit Vest
    [97628] = 97771,
    -- Unbending Spirit Cord
    [97629] = 97770,
    -- Unbending Spirit Pauldrons
    [97630] = 97769,
    -- Unbending Spirit Kilt
    [97631] = 97768,
    -- Insurrection Breastplate
    [97632] = 97766,
    -- Malcontent's Vest
    [97635] = 97746,
    -- Insurrection Boots
    [97637] = 97767,
    -- Malcontent's Boots
    [97644] = 97743,
    -- Insurrection Gauntlets
    [97645] = 97763,
    -- Malcontent's Gloves
    [97652] = 97744,
    -- Insurrection Helm
    [97654] = 97764,
    -- Malcontent's Cowl
    [97660] = 97745,
    -- Insurrection Legplates
    [97661] = 97765,
    -- Malcontent's Kilt
    [97668] = 97741,
    -- Insurrection Spaulders
    [97672] = 97761,
    -- Malcontent's Spaulders
    [97679] = 97742,
    -- Insurrection Belt
    [97680] = 97762,
    -- Malcontent's Belt
    [97687] = 97740,
    -- Insubordination Breastplate
    [97722] = 97738,
    -- Insubordination Boots
    [97723] = 97739,
    -- Insubordination Gauntlets
    [97724] = 97733,
    -- Insubordination Helm
    [97725] = 97734,
    -- Insubordination Legplates
    [97726] = 97735,
    -- Insubordination Shoulderpads
    [97727] = 97736,
    -- Insubordination Belt
    [97728] = 97737,
    -- Saurok Collection
    [98001] = 98005,
    -- Immaculate Pandaren Greatsword
    [98262] = 98312,
    -- Immaculate Pandaren Hammer
    [98263] = 98313,
    -- Immaculate Pandaren Broadaxe
    [98265] = 98314,
    -- Immaculate Pandaren Wand
    [98268] = 98320,
    -- Immaculate Pandaren Spellblade
    [98270] = 98321,
    -- Immaculate Pandaren Mace
    [98271] = 98274,
    -- Fire-Chanter Bindings
    [101781] = 101870,
    -- Fire-Chanter Boots
    [101782] = 101871,
    -- Fire-Chanter Britches
    [101783] = 101872,
    -- Fire-Chanter Gloves
    [101784] = 101873,
    -- Fire-Chanter Hood
    [101785] = 101874,
    -- Fire-Chanter Jerkin
    [101786] = 101875,
    -- Fire-Chanter Shoulders
    [101787] = 101876,
    -- Fire-Chanter Waistband
    [101788] = 101877,
    -- Cliffbreaker Breastplate
    [101789] = 101878,
    -- Cliffbreaker Drape
    [101790] = 101879,
    -- Cliffbreaker Gauntlets
    [101791] = 101880,
    -- Cliffbreaker Girdle
    [101792] = 101881,
    -- Cliffbreaker Helm
    [101793] = 101882,
    -- Cliffbreaker Legplates
    [101794] = 101883,
    -- Cliffbreaker Pauldrons
    [101796] = 101885,
    -- Cliffbreaker Sabatons
    [101797] = 101886,
    -- Cliffbreaker Seal
    [101798] = 101887,
    -- Cliffbreaker Vambraces
    [101799] = 101888,
    -- Amaranthine Cloak
    [101800] = 101889,
    -- Amaranthine Cord
    [101801] = 101890,
    -- Amaranthine Cowl
    [101802] = 101891,
    -- Amaranthine Handwraps
    [101803] = 101892,
    -- Amaranthine Leggings
    [101804] = 101893,
    -- Amaranthine Necklace
    [101805] = 101894,
    -- Amaranthine Robe
    [101806] = 101895,
    -- Amaranthine Sandals
    [101807] = 101896,
    -- Amaranthine Shoulderpads
    [101808] = 101897,
    -- Amaranthine Signet
    [101809] = 101898,
    -- Amaranthine Wristwraps
    [101810] = 101899,
    -- Cloudscorcher Belt
    [101811] = 101900,
    -- Cloudscorcher Cowl
    [101812] = 101901,
    -- Cloudscorcher Handwraps
    [101813] = 101902,
    -- Cloudscorcher Leggings
    [101814] = 101903,
    -- Cloudscorcher Robe
    [101815] = 101904,
    -- Cloudscorcher Sandals
    [101816] = 101905,
    -- Cloudscorcher Shoulderpads
    [101817] = 101906,
    -- Cloudscorcher Wristwraps
    [101818] = 101907,
    -- Everbright Breastplate
    [101819] = 101908,
    -- Everbright Gauntlets
    [101820] = 101909,
    -- Everbright Girdle
    [101821] = 101910,
    -- Everbright Helm
    [101822] = 101911,
    -- Everbright Legplates
    [101823] = 101912,
    -- Everbright Pauldrons
    [101824] = 101913,
    -- Everbright Sabatons
    [101825] = 101914,
    -- Everbright Vambraces
    [101826] = 101915,
    -- Warmsun Choker
    [101827] = 101916,
    -- Warmsun Cloak
    [101828] = 101917,
    -- Warmsun Ring
    [101829] = 101918,
    -- Ordon Legend-Keeper Belt
    [101830] = 101919,
    -- Ordon Legend-Keeper Bracers
    [101831] = 101920,
    -- Ordon Legend-Keeper Gauntlets
    [101832] = 101921,
    -- Ordon Legend-Keeper Greaves
    [101833] = 101922,
    -- Ordon Legend-Keeper Helm
    [101834] = 101923,
    -- Ordon Legend-Keeper Legguards
    [101835] = 101924,
    -- Ordon Legend-Keeper Spaulders
    [101836] = 101925,
    -- Ordon Legend-Keeper Vest
    [101837] = 101926,
    -- Crimsonscale Belt
    [101838] = 101927,
    -- Crimsonscale Bracers
    [101839] = 101928,
    -- Crimsonscale Gauntlets
    [101840] = 101929,
    -- Crimsonscale Greaves
    [101841] = 101930,
    -- Crimsonscale Helm
    [101842] = 101931,
    -- Crimsonscale Legguards
    [101843] = 101932,
    -- Crimsonscale Spaulders
    [101844] = 101933,
    -- Crimsonscale Vest
    [101845] = 101934,
    -- Kiln-Stoker Cloak
    [101848] = 101935,
    -- Kiln-Stoker Collar
    [101849] = 101936,
    -- Kiln-Stoker Ring
    [101850] = 101937,
    -- Elder Tortoiseshell Breastplate
    [101851] = 101938,
    -- Elder Tortoiseshell Drape
    [101852] = 101939,
    -- Elder Tortoiseshell Gauntlets
    [101853] = 101940,
    -- Elder Tortoiseshell Girdle
    [101854] = 101941,
    -- Elder Tortoiseshell Helm
    [101855] = 101942,
    -- Elder Tortoiseshell Legplates
    [101856] = 101943,
    -- Elder Tortoiseshell Pauldrons
    [101858] = 101945,
    -- Elder Tortoiseshell Sabatons
    [101859] = 101946,
    -- Elder Tortoiseshell Seal
    [101860] = 101947,
    -- Elder Tortoiseshell Vambraces
    [101861] = 101948,
    -- Cranefeather Bindings
    [101862] = 101949,
    -- Cranefeather Boots
    [101863] = 101950,
    -- Cranefeather Britches
    [101864] = 101951,
    -- Cranefeather Gloves
    [101865] = 101952,
    -- Cranefeather Hood
    [101866] = 101953,
    -- Cranefeather Jerkin
    [101867] = 101954,
    -- Cranefeather Shoulders
    [101868] = 101955,
    -- Cranefeather Waistband
    [101869] = 101956,
    -- Prideful Gladiator's Emblem of Meditation
    [102616] = 103409,
    -- Prideful Gladiator's Links of Cruelty
    [102617] = 103410,
    -- Prideful Gladiator's Treads of Alacrity
    [102620] = 103355,
    -- Prideful Gladiator's Armbands of Meditation
    [102624] = 103484,
    -- Prideful Gladiator's Medallion of Meditation
    [102625] = 103532,
    -- Prideful Gladiator's Badge of Dominance
    [102633] = 103505,
    -- Prideful Gladiator's Badge of Victory
    [102636] = 103511,
    -- Prideful Gladiator's Greaves of Alacrity
    [102638] = 103446,
    -- Prideful Gladiator's Greaves of Meditation
    [102639] = 103447,
    -- Prideful Gladiator's Girdle of Accuracy
    [102640] = 103455,
    -- Prideful Gladiator's Choker of Accuracy
    [102641] = 103515,
    -- Prideful Gladiator's Cape of Prowess
    [102642] = 103344,
    -- Prideful Gladiator's Insignia of Conquest
    [102643] = 103347,
    -- Prideful Gladiator's Ring of Cruelty
    [102644] = 103348,
    -- Prideful Gladiator's Links of Accuracy
    [102645] = 103411,
    -- Prideful Gladiator's Sabatons of Alacrity
    [102646] = 103413,
    -- Prideful Gladiator's Waistband of Cruelty
    [102647] = 103426,
    -- Prideful Gladiator's Band of Accuracy
    [102649] = 103371,
    -- Prideful Gladiator's Badge of Conquest
    [102659] = 103342,
    -- Prideful Gladiator's Boots of Cruelty
    [102660] = 103473,
    -- Prideful Gladiator's Cord of Accuracy
    [102662] = 103352,
    -- Prideful Gladiator's Armbands of Prowess
    [102665] = 103483,
    -- Prideful Gladiator's Cuffs of Meditation
    [102666] = 103359,
    -- Prideful Gladiator's Waistguard of Meditation
    [102668] = 103480,
    -- Prideful Gladiator's Drape of Cruelty
    [102669] = 103360,
    -- Prideful Gladiator's Medallion of Tenacity
    [102672] = 103530,
    -- Prideful Gladiator's Band of Cruelty
    [102674] = 103370,
    -- Prideful Gladiator's Waistguard of Cruelty
    [102677] = 103495,
    -- Prideful Gladiator's Necklace of Proficiency
    [102678] = 103345,
    -- Prideful Gladiator's Necklace of Prowess
    [102679] = 103346,
    -- Prideful Gladiator's Emblem of Cruelty
    [102680] = 103407,
    -- Prideful Gladiator's Ring of Accuracy
    [102683] = 103349,
    -- Prideful Gladiator's Cord of Cruelty
    [102684] = 103351,
    -- Prideful Gladiator's Treads of Cruelty
    [102686] = 103354,
    -- Prideful Gladiator's Cuffs of Accuracy
    [102687] = 103357,
    -- Prideful Gladiator's Wristguards of Alacrity
    [102688] = 103414,
    -- Prideful Gladiator's Bindings of Meditation
    [102691] = 103388,
    -- Prideful Gladiator's Belt of Cruelty
    [102694] = 103395,
    -- Prideful Gladiator's Bracers of Prowess
    [102695] = 103448,
    -- Prideful Gladiator's Warboots of Cruelty
    [102698] = 103457,
    -- Prideful Gladiator's Insignia of Victory
    [102699] = 103516,
    -- Prideful Gladiator's Signet of Cruelty
    [102701] = 103517,
    -- Prideful Gladiator's Armplates of Proficiency
    [102702] = 103459,
    -- Prideful Gladiator's Cape of Cruelty
    [102705] = 103343,
    -- Prideful Gladiator's Emblem of Tenacity
    [102706] = 103408,
    -- Prideful Gladiator's Waistband of Accuracy
    [102708] = 103472,
    -- Prideful Gladiator's Cord of Meditation
    [102709] = 103353,
    -- Prideful Gladiator's Armwraps of Accuracy
    [102711] = 103428,
    -- Prideful Gladiator's Boots of Alacrity
    [102716] = 103427,
    -- Prideful Gladiator's Bindings of Prowess
    [102723] = 103397,
    -- Prideful Gladiator's Girdle of Prowess
    [102724] = 103456,
    -- Prideful Gladiator's Sabatons of Cruelty
    [102729] = 103412,
    -- Prideful Gladiator's Cuffs of Prowess
    [102733] = 103358,
    -- Prideful Gladiator's Pendant of Meditation
    [102736] = 103369,
    -- Prideful Gladiator's Medallion of Cruelty
    [102738] = 103531,
    -- Prideful Gladiator's Warboots of Alacrity
    [102745] = 103458,
    -- Prideful Gladiator's Signet of Accuracy
    [102746] = 103518,
    -- Prideful Gladiator's Clasp of Meditation
    [102748] = 103445,
    -- Prideful Gladiator's Choker of Proficiency
    [102749] = 103514,
    -- Prideful Gladiator's Treads of Meditation
    [102752] = 103356,
    -- Prideful Gladiator's Wristguards of Accuracy
    [102753] = 103415,
    -- Prideful Gladiator's Armwraps of Alacrity
    [102754] = 103474,
    -- Prideful Gladiator's Drape of Meditation
    [102756] = 103362,
    -- Prideful Gladiator's Pendant of Alacrity
    [102757] = 103368,
    -- Prideful Gladiator's Band of Meditation
    [102758] = 103372,
    -- Prideful Gladiator's Clasp of Cruelty
    [102764] = 103444,
    -- Prideful Gladiator's Bracers of Meditation
    [102765] = 103449,
    -- Prideful Gladiator's Insignia of Dominance
    [102766] = 103506,
    -- Prideful Gladiator's Cloak of Alacrity
    [102769] = 103512,
    -- Prideful Gladiator's Cloak of Prowess
    [102770] = 103513,
    -- Prideful Gladiator's Armplates of Alacrity
    [102771] = 103460,
    -- Prideful Gladiator's Drape of Prowess
    [102772] = 103361,
    -- Prideful Gladiator's Pendant of Cruelty
    [102773] = 103367,
    -- Prideful Gladiator's Belt of Meditation
    [102775] = 103386,
    -- Discipline of Xuen
    [103686] = 103986,
    -- Yu'lon's Bite
    [103687] = 103987,
    -- Contemplation of Chi-Ji
    [103688] = 103988,
    -- Alacrity of Xuen
    [103689] = 103989,
    -- Resolve of Niuzao
    [103690] = 103990,
    -- Coalesced Turmoil
    [104271] = 105714,
    -- Twisted Treasures of the Vale
    [104275] = 105713,
    -- Knife_1h_firelandsraid_d_01
    [104300] = 104301,
    -- Plans: Stronger-hold Gauntlets
    [228118] = 228250,
    -- Hammer of The Black Anvil
    [228128] = 228508,
    -- Fist of the Firesworn
    [228139] = 229374,
    -- Magmadar's Right Claw
    [228145] = 229378,
    -- Magmadar's Left Claw
    [228146] = 229377,
    -- Faithbringer
    [228160] = 229373,
    -- Earthshaker
    [228248] = 228463,
    -- Striker's Mark
    [228252] = 228519,
    -- Sorcerous Dagger
    [228263] = 229376,
    -- Brutality Blade
    [228265] = 228506,
    -- Gutgore Ripper
    [228267] = 229372,
    -- Azuresong Mageblade
    [228269] = 228517,
    -- Staff of Dominance
    [228271] = 228922,
    -- Shadowstrike
    [228272] = 229380,
    -- Thunderstrike
    [228273] = 229381,
    -- Core Hound Tooth
    [228277] = 228701,
    -- Hyperthermically Insulated Lava Dredger
    [228278] = 229382,
    -- Perdition's Blade
    [228296] = 228511,
    -- Spinal Reaper
    [228299] = 228460,
    -- Eskhandar's Right Claw
    [228350] = 229379,
    -- Dreadblade of the Destructor
    [228410] = 228498,
    -- Obsidian Edged Blade
    [228459] = 228229,
    -- Bonereaver's Edge
    [228461] = 228288,
    -- Aurastone Hammer
    [228462] = 228264,
    -- Drillborer Disk
    [228702] = 228266,
    -- Spineshatter
    [230241] = 232567,
    -- The Untamed Blade
    [230242] = 232566,
    -- Dragonfang Blade
    [230247] = 232565,
    -- Heartstriker
    [230253] = 232607,
    -- Maladath, Runed Blade of the Black Flight
    [230254] = 232564,
    -- Shadow Wing Focus Staff
    [230270] = 232563,
    -- Drake Talon Cleaver
    [230271] = 232562,
    -- Claw of the Black Drake
    [230276] = 232561,
    -- Dragonbreath Hand Cannon
    [230726] = 232608,
    -- Herald of Woe
    [230738] = 232559,
    -- Chromatically Tempered Sword
    [230747] = 232558,
    -- Claw of Chromaggus
    [230794] = 232557,
    -- Ashjre'thul, Crossbow of Smiting
    [230801] = 232606,
    -- Staff of the Shadow Flame
    [230813] = 232556,
    -- Ashkandi, Greatsword of the Brotherhood
    [230818] = 232550,
    -- Crul'shorukh, Edge of Chaos
    [230837] = 232555,
    -- Lok'amir il Romathis
    [230838] = 232552,
    -- Draconic Maul
    [230844] = 232551,
    -- Doom's Edge
    [230845] = 232577,
    -- Zulian Scepter of Rites
    [230863] = 231865,
    -- Fang of Venoxis
    [230865] = 231874,
    -- Zulian Stone Axe
    [230868] = 231873,
    -- Jeklik's Crusher
    [230911] = 231861,
    -- Thekal's Grasp
    [230925] = 231875,
    -- Zulian Slicer
    [230930] = 231876,
    -- Will of Arlokk
    [230939] = 231850,
    -- Bloodlord's Defender
    [230989] = 231867,
    -- Halberd of Smiting
    [230991] = 231870,
    -- Jin'do's Hexxer
    [231002] = 231859,
    -- Jin'do's Judgement
    [231004] = 231860,
    -- Nat Pagle's Fish Terminator
    [231016] = 231848,
    -- Wristguards of Wrath
    [231023] = 232255,
    -- Waistguard of Wrath
    [231024] = 232256,
    -- Pauldrons of Wrath
    [231025] = 232257,
    -- Legguards of Wrath
    [231026] = 232258,
    -- Handguards of Wrath
    [231028] = 232260,
    -- Sabatons of Wrath
    [231029] = 232261,
    -- Chestguard of Wrath
    [231030] = 232262,
    -- Bracers of Wrath
    [231031] = 232247,
    -- Belt of Wrath
    [231032] = 232248,
    -- Shoulders of Wrath
    [231033] = 232249,
    -- Legplates of Wrath
    [231034] = 232250,
    -- Gauntlets of Wrath
    [231036] = 232252,
    -- Greaves of Wrath
    [231037] = 232253,
    -- Breastplate of Wrath
    [231038] = 232254,
    -- Bloodfang Spaulders
    [231039] = 232185,
    -- Bloodfang Chestpiece
    [231040] = 232190,
    -- Bloodfang Boots
    [231041] = 232189,
    -- Bloodfang Gloves
    [231042] = 232188,
    -- Bloodfang Pants
    [231044] = 232186,
    -- Bloodfang Belt
    [231045] = 232184,
    -- Bloodfang Bracers
    [231046] = 232183,
    -- Bloodfang Shoulderpads
    [231047] = 232193,
    -- Bloodfang Chestguard
    [231048] = 232198,
    -- Bloodfang Footpads
    [231049] = 232197,
    -- Bloodfang Handguards
    [231050] = 232196,
    -- Bloodfang Cowl
    [231051] = 232195,
    -- Bloodfang Legguards
    [231052] = 232194,
    -- Bloodfang Waistguard
    [231053] = 232192,
    -- Bloodfang Wristguards
    [231054] = 232191,
    -- Dragonstalker's Bracers
    [231055] = 232119,
    -- Dragonstalker's Belt
    [231056] = 232120,
    -- Dragonstalker's Spaulders
    [231057] = 232121,
    -- Dragonstalker's Legguards
    [231058] = 232122,
    -- Dragonstalker's Gauntlets
    [231060] = 232124,
    -- Dragonstalker's Greaves
    [231061] = 232125,
    -- Dragonstalker's Breastplate
    [231062] = 232126,
    -- Dragonstalker's Vambraces
    [231063] = 232111,
    -- Dragonstalker's Girdle
    [231065] = 232112,
    -- Dragonstalker's Pauldrons
    [231066] = 232113,
    -- Dragonstalker's Pants
    [231067] = 232114,
    -- Dragonstalker's Skullcap
    [231068] = 232115,
    -- Dragonstalker's Grips
    [231069] = 232116,
    -- Dragonstalker's Sabatons
    [231070] = 232117,
    -- Dragonstalker's Armor
    [231071] = 232118,
    -- Nemesis Boots
    [231072] = 232237,
    -- Nemesis Gloves
    [231073] = 232236,
    -- Nemesis Leggings
    [231075] = 232234,
    -- Nemesis Robes
    [231076] = 232238,
    -- Nemesis Spaulders
    [231077] = 232233,
    -- Nemesis Belt
    [231078] = 232232,
    -- Nemesis Bracers
    [231079] = 232231,
    -- Nemesis Treads
    [231090] = 232245,
    -- Nemesis Handguards
    [231091] = 232244,
    -- Nemesis Cowl
    [231092] = 232243,
    -- Nemesis Pants
    [231093] = 232242,
    -- Nemesis Garb
    [231095] = 232246,
    -- Nemesis Shoulderpads
    [231096] = 232241,
    -- Nemesis Cord
    [231097] = 232240,
    -- Nemesis Wraps
    [231098] = 232239,
    -- Netherwind Belt
    [231100] = 232128,
    -- Netherwind Boots
    [231101] = 232133,
    -- Netherwind Gloves
    [231102] = 232132,
    -- Netherwind Pants
    [231104] = 232130,
    -- Netherwind Robes
    [231105] = 232134,
    -- Netherwind Mantle
    [231106] = 232129,
    -- Netherwind Bindings
    [231107] = 232127,
    -- Netherwind Sash
    [231108] = 232136,
    -- Netherwind Slippers
    [231109] = 232141,
    -- Netherwind Mitts
    [231110] = 232140,
    -- Netherwind Mask
    [231111] = 232139,
    -- Netherwind Leggings
    [231112] = 232138,
    -- Netherwind Vestments
    [231113] = 232142,
    -- Netherwind Shoulders
    [231114] = 232137,
    -- Netherwind Wraps
    [231115] = 232135,
    -- Boots of Transcendence
    [231155] = 232181,
    -- Handguards of Transcendence
    [231156] = 232180,
    -- Leggings of Transcendence
    [231158] = 232178,
    -- Robes of Transcendence
    [231159] = 232182,
    -- Pauldrons of Transcendence
    [231160] = 232177,
    -- Belt of Transcendence
    [231161] = 232176,
    -- Bindings of Transcendence
    [231162] = 232175,
    -- Treads of Transcendence
    [231165] = 232173,
    -- Gloves of Transcendence
    [231166] = 232172,
    -- Crown of Transcendence
    [231167] = 232171,
    -- Pants of Transcendence
    [231168] = 232170,
    -- Garb of Transcendence
    [231169] = 232174,
    -- Mantle of Transcendence
    [231170] = 232169,
    -- Cord of Transcendence
    [231171] = 232168,
    -- Bracers of Transcendence
    [231172] = 232167,
    -- Judgement Bindings
    [231174] = 232143,
    -- Judgement Belt
    [231175] = 232144,
    -- Judgement Spaulders
    [231176] = 232145,
    -- Judgement Legplates
    [231177] = 232146,
    -- Judgement Gauntlets
    [231179] = 232148,
    -- Judgement Sabatons
    [231180] = 232149,
    -- Judgement Breastplate
    [231181] = 232150,
    -- Judgement Vambraces
    [231182] = 232159,
    -- Judgement Waistguard
    [231183] = 232160,
    -- Judgement Pauldrons
    [231184] = 232161,
    -- Judgement Legguards
    [231185] = 232162,
    -- Judgement Great Helm
    [231186] = 232163,
    -- Judgement Chestguard
    [231187] = 232166,
    -- Judgement Handguards
    [231188] = 232164,
    -- Judgement Greaves
    [231189] = 232165,
    -- Judgement Bracers
    [231190] = 232151,
    -- Judgement Girdle
    [231191] = 232152,
    -- Judgement Mantle
    [231192] = 232153,
    -- Judgement Plate Skirt
    [231193] = 232154,
    -- Judgement Gloves
    [231195] = 232156,
    -- Judgement Treads
    [231196] = 232157,
    -- Judgement Cuirass
    [231197] = 232158,
    -- Gauntlets of Ten Storms
    [231198] = 232212,
    -- Bracers of Ten Storms
    [231199] = 232207,
    -- Belt of Ten Storms
    [231200] = 232208,
    -- Epaulets of Ten Storms
    [231201] = 232209,
    -- Legplates of Ten Storms
    [231202] = 232210,
    -- Breastplate of Ten Storms
    [231205] = 232214,
    -- Handguards of Ten Storms
    [231206] = 232228,
    -- Wristguards of Ten Storms
    [231207] = 232223,
    -- Waistguard of Ten Storms
    [231208] = 232224,
    -- Pauldrons of Ten Storms
    [231209] = 232225,
    -- Legguards of Ten Storms
    [231210] = 232226,
    -- Faceguard of Ten Storms
    [231211] = 232227,
    -- Sabatons of Ten Storms
    [231212] = 232229,
    -- Chestguard of Ten Storms
    [231213] = 232230,
    -- Gloves of Ten Storms
    [231214] = 232204,
    -- Bindings of Ten Storms
    [231215] = 232199,
    -- Cord of Ten Storms
    [231216] = 232200,
    -- Mantle of Ten Storms
    [231217] = 232201,
    -- Kilt of Ten Storms
    [231218] = 232202,
    -- Headdress of Ten Storms
    [231219] = 232203,
    -- Boots of Ten Storms
    [231220] = 232205,
    -- Embrace of Ten Storms
    [231221] = 232206,
    -- Grips of Ten Storms
    [231222] = 232220,
    -- Vambraces of Ten Storms
    [231223] = 232215,
    -- Girdle of Ten Storms
    [231224] = 232216,
    -- Spaulders of Ten Storms
    [231225] = 232217,
    -- Leggings of Ten Storms
    [231226] = 232218,
    -- Treads of Ten Storms
    [231228] = 232221,
    -- Armor of Ten Storms
    [231229] = 232222,
    -- Stormrage Chestguard
    [231230] = 232094,
    -- Stormrage Boots
    [231231] = 232093,
    -- Stormrage Handguards
    [231232] = 232092,
    -- Stormrage Legguards
    [231234] = 232090,
    -- Stormrage Pauldrons
    [231235] = 232089,
    -- Stormrage Belt
    [231236] = 232088,
    -- Stormrage Bracers
    [231237] = 232087,
    -- Stormrage Armor
    [231238] = 232110,
    -- Stormrage Treads
    [231239] = 232109,
    -- Stormrage Gauntlets
    [231240] = 232108,
    -- Stormrage Headdress
    [231241] = 232107,
    -- Stormrage Leggings
    [231242] = 232106,
    -- Stormrage Spaulders
    [231243] = 232105,
    -- Stormrage Waistguard
    [231244] = 232104,
    -- Stormrage Wristguards
    [231245] = 232103,
    -- Stormrage Leathers
    [231246] = 232086,
    -- Stormrage Sandals
    [231247] = 232085,
    -- Stormrage Mitts
    [231248] = 232084,
    -- Stormrage Kilt
    [231250] = 232082,
    -- Stormrage Mantle
    [231251] = 232081,
    -- Stormrage Cord
    [231252] = 232080,
    -- Stormrage Bindings
    [231253] = 232079,
    -- Stormrage Vest
    [231254] = 232102,
    -- Stormrage Stompers
    [231255] = 232101,
    -- Stormrage Cowl
    [231257] = 232099,
    -- Stormrage Trousers
    [231258] = 232098,
    -- Stormrage Shoulderpads
    [231259] = 232097,
    -- Stormrage Sash
    [231260] = 232096,
    -- Stormrage Wraps
    [231261] = 232095,
    -- Tigule's Harpoon
    [231272] = 231849,
    -- Gri'lek's Carver
    [231273] = 231846,
    -- Gri'lek's Grinder
    [231274] = 231847,
    -- Blazefury Retributer
    [231275] = 231862,
    -- Pitchfork of Madness
    [231277] = 231864,
    -- Hoodoo Hunting Bow
    [231278] = 231872,
    -- Ancient Hakkari Manslayer
    [231293] = 231856,
    -- Bloodcaller
    [231296] = 231858,
    -- Gurubashi Dwarf Destroyer
    [231302] = 231852,
    -- Touch of Chaos
    [231308] = 231857,
    -- Arlokk's Grasp
    [231851] = 230934,
    -- Fang of the Faceless
    [231855] = 231301,
    -- Thoughtblighter
    [231863] = 231276,
    -- Mar'li's Touch
    [231866] = 230918,
    -- Mandokir's Sting
    [231868] = 230993,
    -- Wushoolay's Poker
    [231871] = 231279,
    -- Terrestris
    [231890] = 224279,
    -- Stormrage Grips
    [232100] = 231256,
    -- Greaves of Ten Storms
    [232213] = 231204,
    -- Renataki's Soul Conduit
    [232309] = 232310,
    -- Draconic Avenger
    [232357] = 232576,
    -- Mace of Unending Life
    [233417] = 235012,
    -- Scythe of the Unseen Path
    [233421] = 235007,
    -- Blade of Vaulted Secrets
    [233423] = 235013,
    -- Blade of Eternal Justice
    [233426] = 235011,
    -- Gavel of Infinite Wisdom
    [233429] = 235010,
    -- Dagger of Veiled Shadows
    [233433] = 235006,
    -- Hammer of the Gathering Storm
    [233435] = 235009,
    -- Kris of Unspoken Names
    [233439] = 235008,
    -- Sickle of Unyielding Strength
    [233442] = 235005,
    -- Staff of the Qiraji Prophets
    [233509] = 234974,
    -- Hammer of Ji'zhi
    [233515] = 234975,
    -- Silithid Claw
    [233576] = 234977,
    -- Jaw of the Sand Reaver
    [233586] = 234978,
    -- Sharpened Silithid Femur
    [233599] = 234979,
    -- Huhuran's Stinger
    [233605] = 234980,
    -- Kalimdor's Revenge
    [233621] = 234981,
    -- Larvae of the Great Worm
    [233626] = 234983,
    -- Scepter of the False Prophet
    [233636] = 235014,
    -- Battle Hardened Plate Girdle
    [233724] = 233725,
    -- Battle Hardened Plate Armguards
    [233727] = 233726,
    -- Battle Hardened Chain Girdle
    [233751] = 233752,
    -- Battle Hardened Chain Belt
    [233754] = 233753,
    -- Battle Hardened Chain Wristguards
    [233755] = 233756,
    -- Battle Hardened Chain Bracers
    [233757] = 233758,
    -- Battle Hardened Dragonhide Bracers
    [233759] = 233760,
    -- Battle Hardened Dragonhide Belt
    [233761] = 233762,
    -- Battle Hardened Dragonhide Waistguard
    [233764] = 233763,
    -- Battle Hardened Dragonhide Cord
    [233765] = 233766,
    -- Battle Hardened Dragonhide Wrists
    [233768] = 233767,
    -- Battle Hardened Dragonhide Armbands
    [233769] = 233770,
    -- Battle Hardened Leather Girdle
    [233772] = 233771,
    -- Battle Hardened Leather Armsplints
    [233774] = 233773,
    -- Battle Hardened Silk Cuffs
    [233775] = 233776,
    -- Battle Hardened Silk Sash
    [233778] = 233777,
    -- Battle Hardened Satin Bracers
    [233779] = 233780,
    -- Battle Hardened Satin Wrists
    [233781] = 233782,
    -- Battle Hardened Satin Sash
    [233784] = 233783,
    -- Battle Hardened Satin Cinch
    [233785] = 233786,
    -- Battle Hardened Dreadweave Cuffs
    [233787] = 233788,
    -- Battle Hardened Dreadweave Belt
    [233790] = 233789,
    -- Qiraji Sacrificial Dagger
    [234061] = 234989,
    -- Manslayer of the Qiraji
    [234067] = 234990,
    -- Bow of Taut Sinew
    [234096] = 234991,
    -- Stinger of Ayamiss
    [234097] = 234992,
    -- Crossbow of Imminent Doom
    [234104] = 234993,
    -- Sand Polished Hammer
    [234112] = 234994,
    -- Staff of the Ruins
    [234115] = 234995,
    -- Gavel of Qiraji Authority
    [234118] = 234996,
    -- Antenna of Invigoration
    [234119] = 235282,
    -- Silithid Husked Launcher
    [234121] = 234997,
    -- The Lost Kris of Zedd
    [234122] = 234998,
    -- Ancient Qiraji Ripper
    [234650] = 233585,
    -- Blessed Qiraji Acolyte Staff
    [234808] = 235001,
    -- Wand of Qiraji Nobility
    [234976] = 233571,
    -- Death's Sting
    [234984] = 233634,
    -- Dark Edge of Insanity
    [234985] = 233640,
    -- Anubisath Warhammer
    [234986] = 233643,
    -- Neretzek, The Blood Drinker
    [234987] = 233647,
    -- Blessed Qiraji War Hammer
    [234999] = 234810,
    -- Blessed Qiraji Augur Staff
    [235000] = 234809,
    -- Blessed Qiraji Pugio
    [235002] = 234806,
    -- Blessed Qiraji War Axe
    [235003] = 234804,
    -- Blessed Qiraji Musket
    [235004] = 234805,
    -- Mark of the Champion
    [236351] = 236352,
    -- Caladbolg
    [238961] = 244460,
    -- Ruined Lightforged Blade
    [239196] = 243230,
    -- Hilt of the Ashbringer
    [239696] = 239010,
    -- Inert Ashbringer
    [240936] = 241654,
    -- Ashbringer
    [241082] = 50442,
    -- Reborn Dagger
    [241123] = 241121,
    -- Poultry Precision Scope
    [243198] = 244353,
    -- Timeless Tanzanite
    [30552] = {30555, 30583, },
    -- Regal Chrysoprase
    [30563] = {30590, 30594, },
    -- Jagged Chrysoprase
    [30602] = {30548, 30565, },
    -- Delicate Crimson Spinel
    [32194] = {32197, 35487, },
    -- Design: Brilliant Crimson Spinel
    [32281] = {32282, 32290, },
    -- Reins of the Swift Spectral Tiger
    [33225] = {49284, 234465, },
    -- Frostmourne
    [33475] = {36942, 231885, },
    -- Design: Reckless Pyrestone
    [35762] = {35767, 32305, },
    -- Purified Shadowsong Amethyst
    [37503] = {32216, 32225, },
    -- Greater Inscription of the Axe
    [44133] = {50335, 44871, },
    -- Greater Inscription of the Crag
    [44134] = {50336, 44872, },
    -- Greater Inscription of the Storm 
    [44135] = {50338, 44874, },
    -- Greater Inscription of the Pinnacle
    [44136] = {50337, 44873, },
    -- Faceguard of Wrath
    [49320] = {231027, 232259, },
    -- Judgement Helm
    [49325] = {231194, 232155, },
    -- Stormrage Antlers
    [49327] = {231249, 232083, },
    -- Crown of Ten Storms
    [49469] = {231227, 232219, },
    -- Helmet of Ten Storms
    [49470] = {231203, 232211, },
    -- Stormrage Cover
    [49473] = {231233, 232091, },
    -- Judgement Crown
    [49476] = {231178, 232147, },
    -- Bloodfang Hood
    [49477] = {231043, 232187, },
    -- Helm of Wrath
    [49479] = {231035, 232251, },
    -- Dragonstalker's Helm
    [49480] = {231059, 232123, },
    -- Netherwind Crown
    [49481] = {231103, 232131, },
    -- Halo of Transcendence
    [49483] = {231157, 232179, },
    -- Nemesis Skullcap
    [49484] = {231074, 232235, },
    -- Head of Onyxia
    [49644] = {49643, 228689, },
    -- Belt of Broken Bones
    [50036] = {50691, 81709, },
    -- Glorenzelg, High-Blade of the Silver Hand
    [50070] = {50730, 81703, },
    -- Ymirjar Lord's Battleplate
    [50078] = {51771, 81704, },
    -- Ymirjar Lord's Gauntlets
    [50079] = {51770, 81705, },
    -- Ymirjar Lord's Helmet
    [50080] = {51769, 81706, },
    -- Ymirjar Lord's Legplates
    [50081] = {51768, 81707, },
    -- Ymirjar Lord's Shoulderplates
    [50082] = {51767, 81708, },
    -- Grinning Skull Greatboots
    [50190] = {50625, 81710, },
    -- Wrathful Gladiator's Razor
    [51444] = {105955, 105956, },
    -- The Frost Lord's Battle Shroud
    [54803] = {69767, 95429, },
    -- Vicious Gladiator's Dreadplate Chestpiece
    [60408] = {65597, 70558, },
    -- Vicious Gladiator's Dreadplate Gauntlets
    [60409] = {65596, 70559, },
    -- Vicious Gladiator's Dreadplate Helm
    [60410] = {65595, 70560, },
    -- Vicious Gladiator's Dreadplate Legguards
    [60411] = {65594, 70561, },
    -- Vicious Gladiator's Dreadplate Shoulders
    [60412] = {65593, 70562, },
    -- Vicious Gladiator's Scaled Chestpiece
    [60413] = {65592, 70648, },
    -- Vicious Gladiator's Scaled Gauntlets
    [60414] = {65591, 70649, },
    -- Vicious Gladiator's Scaled Helm
    [60415] = {65590, 70650, },
    -- Vicious Gladiator's Scaled Legguards
    [60416] = {65586, 70651, },
    -- Vicious Gladiator's Scaled Shoulders
    [60417] = {65585, 70652, },
    -- Vicious Gladiator's Plate Chestpiece
    [60418] = {65584, 70623, },
    -- Vicious Gladiator's Plate Gauntlets
    [60419] = {65583, 70624, },
    -- Vicious Gladiator's Plate Helm
    [60420] = {65582, 70625, },
    -- Vicious Gladiator's Plate Legguards
    [60421] = {65581, 70626, },
    -- Vicious Gladiator's Plate Shoulders
    [60422] = {65580, 70627, },
    -- Vicious Gladiator's Chain Armor
    [60423] = {65579, 70533, },
    -- Vicious Gladiator's Chain Gauntlets
    [60424] = {65544, 70534, },
    -- Vicious Gladiator's Chain Helm
    [60425] = {65543, 70535, },
    -- Vicious Gladiator's Chain Leggings
    [60426] = {65538, 70536, },
    -- Vicious Gladiator's Chain Spaulders
    [60427] = {65537, 70537, },
    -- Vicious Gladiator's Ringmail Armor
    [60428] = {65536, 70632, },
    -- Vicious Gladiator's Ringmail Gauntlets
    [60429] = {65570, 70633, },
    -- Vicious Gladiator's Ringmail Helm
    [60430] = {65569, 70634, },
    -- Vicious Gladiator's Ringmail Leggings
    [60431] = {65568, 70635, },
    -- Vicious Gladiator's Ringmail Spaulders
    [60432] = {65567, 70636, },
    -- Vicious Gladiator's Linked Armor
    [60433] = {65563, 70590, },
    -- Vicious Gladiator's Linked Gauntlets
    [60434] = {65562, 70591, },
    -- Vicious Gladiator's Linked Helm
    [60435] = {65561, 70592, },
    -- Vicious Gladiator's Linked Leggings
    [60436] = {65560, 70593, },
    -- Vicious Gladiator's Linked Spaulders
    [60437] = {65559, 70594, },
    -- Vicious Gladiator's Mail Armor
    [60438] = {65527, 70597, },
    -- Vicious Gladiator's Mail Gauntlets
    [60439] = {65526, 70598, },
    -- Vicious Gladiator's Mail Helm
    [60440] = {65525, 70599, },
    -- Vicious Gladiator's Mail Leggings
    [60441] = {65524, 70600, },
    -- Vicious Gladiator's Mail Spaulders
    [60442] = {65523, 70601, },
    -- Vicious Gladiator's Dragonhide Gloves
    [60443] = {65589, 70550, },
    -- Vicious Gladiator's Dragonhide Helm
    [60444] = {65588, 70551, },
    -- Vicious Gladiator's Dragonhide Legguards
    [60445] = {65587, 70552, },
    -- Vicious Gladiator's Dragonhide Robes
    [60446] = {65542, 70553, },
    -- Vicious Gladiator's Dragonhide Spaulders
    [60447] = {65541, 70554, },
    -- Vicious Gladiator's Kodohide Gloves
    [60448] = {65540, 70580, },
    -- Vicious Gladiator's Kodohide Helm
    [60449] = {65539, 70581, },
    -- Vicious Gladiator's Kodohide Legguards
    [60450] = {65535, 70582, },
    -- Vicious Gladiator's Kodohide Robes
    [60451] = {65534, 70583, },
    -- Vicious Gladiator's Kodohide Spaulders
    [60452] = {65533, 70584, },
    -- Vicious Gladiator's Wyrmhide Gloves
    [60453] = {65532, 70671, },
    -- Vicious Gladiator's Wyrmhide Helm
    [60454] = {65531, 70672, },
    -- Vicious Gladiator's Wyrmhide Legguards
    [60455] = {65552, 70673, },
    -- Vicious Gladiator's Wyrmhide Robes
    [60456] = {65551, 70674, },
    -- Vicious Gladiator's Wyrmhide Spaulders
    [60457] = {65550, 70675, },
    -- Vicious Gladiator's Leather Tunic
    [60458] = {65549, 70589, },
    -- Vicious Gladiator's Leather Gloves
    [60459] = {65548, 70585, },
    -- Vicious Gladiator's Leather Helm
    [60460] = {65547, 70586, },
    -- Vicious Gladiator's Leather Legguards
    [60461] = {65546, 70587, },
    -- Vicious Gladiator's Leather Spaulders
    [60462] = {65545, 70588, },
    -- Vicious Gladiator's Silk Handguards
    [60463] = {65566, 70657, },
    -- Vicious Gladiator's Silk Cowl
    [60464] = {65565, 70656, },
    -- Vicious Gladiator's Silk Trousers
    [60465] = {65564, 70659, },
    -- Vicious Gladiator's Silk Robe
    [60466] = {65558, 70658, },
    -- Vicious Gladiator's Silk Amice
    [60467] = {65557, 70655, },
    -- Vicious Gladiator's Mooncloth Gloves
    [60468] = {65556, 70608, },
    -- Vicious Gladiator's Mooncloth Helm
    [60469] = {65555, 70609, },
    -- Vicious Gladiator's Mooncloth Leggings
    [60470] = {65554, 70610, },
    -- Vicious Gladiator's Mooncloth Robe
    [60471] = {65553, 70612, },
    -- Vicious Gladiator's Mooncloth Mantle
    [60472] = {65578, 70611, },
    -- Vicious Gladiator's Satin Gloves
    [60473] = {65577, 70643, },
    -- Vicious Gladiator's Satin Hood
    [60474] = {65576, 70644, },
    -- Vicious Gladiator's Satin Leggings
    [60475] = {65575, 70645, },
    -- Vicious Gladiator's Satin Robe
    [60476] = {65574, 70647, },
    -- Vicious Gladiator's Satin Mantle
    [60477] = {65573, 70646, },
    -- Vicious Gladiator's Felweave Handguards
    [60478] = {65572, 70568, },
    -- Vicious Gladiator's Felweave Cowl
    [60479] = {65571, 70567, },
    -- Vicious Gladiator's Felweave Trousers
    [60480] = {65530, 70570, },
    -- Vicious Gladiator's Felweave Raiment
    [60481] = {65529, 70569, },
    -- Vicious Gladiator's Felweave Amice
    [60482] = {65528, 70566, },
    -- Vicious Gladiator's Warboots of Cruelty
    [60509] = {65607, 70668, },
    -- Vicious Gladiator's Bracers of Triumph
    [60510] = {60524, 60529, },
    -- Vicious Gladiator's Warboots of Alacrity
    [60513] = {65608, 70667, },
    -- Vicious Gladiator's Girdle of Triumph
    [60514] = {60526, 60527, },
    -- Vicious Gladiator's Greaves of Alacrity
    [60516] = {65605, 70575, },
    -- Vicious Gladiator's Greaves of Triumph
    [60522] = {60525, 60528, },
    -- Vicious Gladiator's Sabatons of Meditation
    [60534] = {65612, 70642, },
    -- Vicious Gladiator's Greaves of Meditation
    [60540] = {65606, 70576, },
    -- Vicious Gladiator's Waistguard of Triumph
    [60551] = {60558, 60561, },
    -- Vicious Gladiator's Sabatons of Triumph
    [60552] = {60562, 60563, },
    -- Vicious Gladiator's Wristguards of Triumph
    [60553] = {60556, 60560, },
    -- Vicious Gladiator's Sabatons of Cruelty
    [60554] = {65603, 70641, },
    -- Vicious Gladiator's Footguards of Meditation
    [60581] = {65601, 70572, },
    -- Vicious Gladiator's Boots of Cruelty
    [60587] = {65609, 70528, },
    -- Vicious Gladiator's Armwraps of Triumph
    [60588] = {60597, 60598, },
    -- Vicious Gladiator's Boots of Triumph
    [60590] = {60596, 60599, },
    -- Vicious Gladiator's Belt of Triumph
    [60592] = {60595, 60600, },
    -- Vicious Gladiator's Boots of Alacrity
    [60593] = {65610, 70527, },
    -- Vicious Gladiator's Ornamented Chestguard
    [60601] = {65522, 70615, },
    -- Vicious Gladiator's Ornamented Gloves
    [60602] = {65521, 70616, },
    -- Vicious Gladiator's Ornamented Headcover
    [60603] = {65520, 70617, },
    -- Vicious Gladiator's Ornamented Legplates
    [60604] = {65519, 70618, },
    -- Vicious Gladiator's Ornamented Spaulders
    [60605] = {65518, 70619, },
    -- Vicious Gladiator's Footguards of Alacrity
    [60607] = {65602, 70571, },
    -- Vicious Gladiator's Treads of Cruelty
    [60613] = {65598, 70661, },
    -- Vicious Gladiator's Treads of Alacrity
    [60630] = {65599, 70660, },
    -- Vicious Gladiator's Treads of Meditation
    [60636] = {65600, 70662, },
    -- Arcanum of the Earthen Ring
    [62366] = {68718, 68764, },
    -- Arcanum of Hyjal
    [62367] = {68719, 68765, },
    -- Arcanum of the Dragonmaw
    [62368] = {68720, 68763, },
    -- Arcanum of the Ramkahen
    [62369] = {68721, 68766, },
    -- Arcanum of the Wildhammer
    [62422] = {68722, 68767, },
    -- Unsolvable Riddle
    [62463] = {62468, 68709, },
    -- Impatience of Youth
    [62464] = {62469, 68712, },
    -- Stump of Time
    [62465] = {62470, 68710, },
    -- Mirror of Broken Images
    [62466] = {62471, 68713, },
    -- Mandala of Stirring Patterns
    [62467] = {62472, 68711, },
    -- Zin'rokh, Destroyer of Worlds
    [64377] = {231854, 231315, },
    -- Ruthless Gladiator's Dreadplate Chestpiece
    [70244] = {70494, 72332, },
    -- Ruthless Gladiator's Dreadplate Gauntlets
    [70245] = {70493, 72333, },
    -- Ruthless Gladiator's Dreadplate Helm
    [70246] = {70492, 72334, },
    -- Ruthless Gladiator's Dreadplate Legguards
    [70247] = {70491, 72335, },
    -- Ruthless Gladiator's Dreadplate Shoulders
    [70248] = {70490, 72336, },
    -- Ruthless Gladiator's Scaled Chestpiece
    [70249] = {70489, 72378, },
    -- Ruthless Gladiator's Scaled Gauntlets
    [70250] = {70488, 72379, },
    -- Ruthless Gladiator's Scaled Helm
    [70251] = {70487, 72380, },
    -- Ruthless Gladiator's Scaled Legguards
    [70252] = {70483, 72381, },
    -- Ruthless Gladiator's Scaled Shoulders
    [70253] = {70482, 72382, },
    -- Ruthless Gladiator's Plate Chestpiece
    [70254] = {70481, 72464, },
    -- Ruthless Gladiator's Plate Gauntlets
    [70255] = {70480, 72465, },
    -- Ruthless Gladiator's Plate Helm
    [70256] = {70479, 72466, },
    -- Ruthless Gladiator's Plate Legguards
    [70257] = {70478, 72467, },
    -- Ruthless Gladiator's Plate Shoulders
    [70258] = {70477, 72468, },
    -- Ruthless Gladiator's Chain Armor
    [70259] = {70476, 72368, },
    -- Ruthless Gladiator's Chain Gauntlets
    [70260] = {70441, 72369, },
    -- Ruthless Gladiator's Chain Helm
    [70261] = {70440, 72370, },
    -- Ruthless Gladiator's Chain Leggings
    [70262] = {70435, 72371, },
    -- Ruthless Gladiator's Chain Spaulders
    [70263] = {70434, 72372, },
    -- Ruthless Gladiator's Ringmail Armor
    [70264] = {70433, 72432, },
    -- Ruthless Gladiator's Ringmail Gauntlets
    [70265] = {70467, 72433, },
    -- Ruthless Gladiator's Ringmail Helm
    [70266] = {70466, 72434, },
    -- Ruthless Gladiator's Ringmail Leggings
    [70267] = {70465, 72435, },
    -- Ruthless Gladiator's Ringmail Spaulders
    [70268] = {70464, 72436, },
    -- Ruthless Gladiator's Linked Armor
    [70269] = {70460, 72437, },
    -- Ruthless Gladiator's Linked Gauntlets
    [70270] = {70459, 72438, },
    -- Ruthless Gladiator's Linked Helm
    [70271] = {70458, 72439, },
    -- Ruthless Gladiator's Linked Leggings
    [70272] = {70457, 72440, },
    -- Ruthless Gladiator's Linked Spaulders
    [70273] = {70456, 72441, },
    -- Ruthless Gladiator's Mail Armor
    [70274] = {70424, 72443, },
    -- Ruthless Gladiator's Mail Gauntlets
    [70275] = {70423, 72444, },
    -- Ruthless Gladiator's Mail Helm
    [70276] = {70422, 72445, },
    -- Ruthless Gladiator's Mail Leggings
    [70277] = {70421, 72446, },
    -- Ruthless Gladiator's Mail Spaulders
    [70278] = {70420, 72447, },
    -- Ruthless Gladiator's Dragonhide Gloves
    [70279] = {70486, 72337, },
    -- Ruthless Gladiator's Dragonhide Helm
    [70280] = {70485, 72338, },
    -- Ruthless Gladiator's Dragonhide Legguards
    [70281] = {70484, 72339, },
    -- Ruthless Gladiator's Dragonhide Robes
    [70282] = {70439, 72340, },
    -- Ruthless Gladiator's Dragonhide Spaulders
    [70283] = {70438, 72341, },
    -- Ruthless Gladiator's Kodohide Gloves
    [70284] = {70437, 72345, },
    -- Ruthless Gladiator's Kodohide Helm
    [70285] = {70436, 72346, },
    -- Ruthless Gladiator's Kodohide Legguards
    [70286] = {70432, 72347, },
    -- Ruthless Gladiator's Kodohide Robes
    [70287] = {70431, 72348, },
    -- Ruthless Gladiator's Kodohide Spaulders
    [70288] = {70430, 72349, },
    -- Ruthless Gladiator's Wyrmhide Gloves
    [70289] = {70429, 72353, },
    -- Ruthless Gladiator's Wyrmhide Helm
    [70290] = {70428, 72354, },
    -- Ruthless Gladiator's Wyrmhide Legguards
    [70291] = {70449, 72355, },
    -- Ruthless Gladiator's Wyrmhide Robes
    [70292] = {70448, 72356, },
    -- Ruthless Gladiator's Wyrmhide Spaulders
    [70293] = {70447, 72357, },
    -- Ruthless Gladiator's Leather Tunic
    [70294] = {70446, 72422, },
    -- Ruthless Gladiator's Leather Gloves
    [70295] = {70445, 72423, },
    -- Ruthless Gladiator's Leather Helm
    [70296] = {70444, 72424, },
    -- Ruthless Gladiator's Leather Legguards
    [70297] = {70443, 72425, },
    -- Ruthless Gladiator's Leather Spaulders
    [70298] = {70442, 72426, },
    -- Ruthless Gladiator's Silk Handguards
    [70299] = {70463, 72373, },
    -- Ruthless Gladiator's Silk Cowl
    [70300] = {70462, 72374, },
    -- Ruthless Gladiator's Silk Trousers
    [70301] = {70461, 72375, },
    -- Ruthless Gladiator's Silk Robe
    [70302] = {70455, 72376, },
    -- Ruthless Gladiator's Silk Amice
    [70303] = {70454, 72377, },
    -- Ruthless Gladiator's Mooncloth Gloves
    [70304] = {70453, 72400, },
    -- Ruthless Gladiator's Mooncloth Helm
    [70305] = {70452, 72401, },
    -- Ruthless Gladiator's Mooncloth Leggings
    [70306] = {70451, 72402, },
    -- Ruthless Gladiator's Mooncloth Robe
    [70307] = {70450, 72403, },
    -- Ruthless Gladiator's Mooncloth Mantle
    [70308] = {70475, 72404, },
    -- Ruthless Gladiator's Satin Gloves
    [70309] = {70474, 72405, },
    -- Ruthless Gladiator's Satin Hood
    [70310] = {70473, 72406, },
    -- Ruthless Gladiator's Satin Leggings
    [70311] = {70472, 72407, },
    -- Ruthless Gladiator's Satin Robe
    [70312] = {70471, 72408, },
    -- Ruthless Gladiator's Satin Mantle
    [70313] = {70470, 72409, },
    -- Ruthless Gladiator's Felweave Handguards
    [70314] = {70469, 72459, },
    -- Ruthless Gladiator's Felweave Cowl
    [70315] = {70468, 72460, },
    -- Ruthless Gladiator's Felweave Trousers
    [70316] = {70427, 72461, },
    -- Ruthless Gladiator's Felweave Raiment
    [70317] = {70426, 72462, },
    -- Ruthless Gladiator's Felweave Amice
    [70318] = {70425, 72463, },
    -- Ruthless Gladiator's Warboots of Cruelty
    [70321] = {70504, 72396, },
    -- Ruthless Gladiator's Warboots of Alacrity
    [70323] = {70505, 72397, },
    -- Ruthless Gladiator's Greaves of Alacrity
    [70324] = {70502, 72385, },
    -- Ruthless Gladiator's Sabatons of Meditation
    [70329] = {70509, 72429, },
    -- Ruthless Gladiator's Greaves of Meditation
    [70333] = {70503, 72386, },
    -- Ruthless Gladiator's Sabatons of Cruelty
    [70335] = {70500, 72364, },
    -- Ruthless Gladiator's Footguards of Meditation
    [70344] = {70498, 72343, },
    -- Ruthless Gladiator's Boots of Cruelty
    [70348] = {70506, 72418, },
    -- Ruthless Gladiator's Boots of Alacrity
    [70351] = {70507, 72419, },
    -- Ruthless Gladiator's Ornamented Chestguard
    [70353] = {70419, 72389, },
    -- Ruthless Gladiator's Ornamented Gloves
    [70354] = {70418, 72390, },
    -- Ruthless Gladiator's Ornamented Headcover
    [70355] = {70417, 72391, },
    -- Ruthless Gladiator's Ornamented Legplates
    [70356] = {70416, 72392, },
    -- Ruthless Gladiator's Ornamented Spaulders
    [70357] = {70415, 72393, },
    -- Ruthless Gladiator's Footguards of Alacrity
    [70358] = {70499, 72351, },
    -- Ruthless Gladiator's Treads of Cruelty
    [70361] = {70495, 72316, },
    -- Ruthless Gladiator's Treads of Alacrity
    [70364] = {70496, 72317, },
    -- Ruthless Gladiator's Treads of Meditation
    [70367] = {70497, 72318, },
    -- Time Lord's Gloves
    [76212] = {78671, 78766, },
    -- Time Lord's Hood
    [76213] = {78701, 78796, },
    -- Time Lord's Leggings
    [76214] = {78720, 78815, },
    -- Time Lord's Robes
    [76215] = {78729, 78824, },
    -- Time Lord's Mantle
    [76216] = {78748, 78843, },
    -- Mantle of the Faceless Shroud
    [76339] = {78749, 78844, },
    -- Robes of the Faceless Shroud
    [76340] = {78730, 78825, },
    -- Leggings of the Faceless Shroud
    [76341] = {78721, 78816, },
    -- Hood of the Faceless Shroud
    [76342] = {78702, 78797, },
    -- Gloves of the Faceless Shroud
    [76343] = {78681, 78776, },
    -- Leggings of Dying Light
    [76346] = {78722, 78817, },
    -- Hood of Dying Light
    [76347] = {78703, 78798, },
    -- Gloves of Dying Light
    [76348] = {78682, 78777, },
    -- Handwraps of Dying Light
    [76357] = {78683, 78778, },
    -- Cowl of Dying Light
    [76358] = {78700, 78795, },
    -- Legwraps of Dying Light
    [76359] = {78719, 78814, },
    -- Deep Earth Handwraps
    [76749] = {78680, 78775, },
    -- Deep Earth Helm
    [76750] = {78690, 78785, },
    -- Deep Earth Legwraps
    [76751] = {78710, 78805, },
    -- Deep Earth Robes
    [76752] = {78660, 78755, },
    -- Deep Earth Mantle
    [76753] = {78740, 78835, },
    -- Spiritwalker's Tunic
    [76756] = {78725, 78820, },
    -- Spiritwalker's Handwraps
    [76757] = {78672, 78767, },
    -- Spiritwalker's Faceguard
    [76758] = {78691, 78786, },
    -- Spiritwalker's Legwraps
    [76759] = {78718, 78813, },
    -- Spiritwalker's Mantle
    [76760] = {78739, 78834, },
    -- Breastplate of Radiant Glory
    [76765] = {78726, 78821, },
    -- Gloves of Radiant Glory
    [76766] = {78673, 78768, },
    -- Headguard of Radiant Glory
    [76767] = {78692, 78787, },
    -- Greaves of Radiant Glory
    [76768] = {78717, 78812, },
    -- Mantle of Radiant Glory
    [76769] = {78746, 78841, },
    -- Battleplate of Radiant Glory
    [76874] = {78727, 78822, },
    -- Gauntlets of Radiant Glory
    [76875] = {78675, 78770, },
    -- Helmet of Radiant Glory
    [76876] = {78693, 78788, },
    -- Legplates of Radiant Glory
    [76877] = {78712, 78807, },
    -- Pauldrons of Radiant Glory
    [76878] = {78742, 78837, },
    -- Necrotic Boneplate Breastplate
    [76974] = {78659, 78754, },
    -- Necrotic Boneplate Gauntlets
    [76975] = {78670, 78765, },
    -- Necrotic Boneplate Helmet
    [76976] = {78687, 78782, },
    -- Necrotic Boneplate Greaves
    [76977] = {78707, 78802, },
    -- Necrotic Boneplate Pauldrons
    [76978] = {78736, 78831, },
    -- Colossal Dragonplate Helmet
    [76983] = {78688, 78783, },
    -- Colossal Dragonplate Battleplate
    [76984] = {78657, 78752, },
    -- Colossal Dragonplate Gauntlets
    [76985] = {78668, 78763, },
    -- Colossal Dragonplate Legplates
    [76986] = {78706, 78801, },
    -- Colossal Dragonplate Pauldrons
    [76987] = {78735, 78830, },
    -- Colossal Dragonplate Chestguard
    [76988] = {78658, 78753, },
    -- Colossal Dragonplate Handguards
    [76989] = {78669, 78764, },
    -- Colossal Dragonplate Faceguard
    [76990] = {78689, 78784, },
    -- Colossal Dragonplate Legguards
    [76991] = {78705, 78800, },
    -- Colossal Dragonplate Shoulderguards
    [76992] = {78734, 78829, },
    -- Chestguard of Radiant Glory
    [77003] = {78732, 78827, },
    -- Handguards of Radiant Glory
    [77004] = {78677, 78772, },
    -- Faceguard of Radiant Glory
    [77005] = {78695, 78790, },
    -- Legguards of Radiant Glory
    [77006] = {78715, 78810, },
    -- Shoulderguards of Radiant Glory
    [77007] = {78745, 78840, },
    -- Necrotic Boneplate Chestguard
    [77008] = {78663, 78758, },
    -- Necrotic Boneplate Handguards
    [77009] = {78678, 78773, },
    -- Necrotic Boneplate Faceguard
    [77010] = {78697, 78792, },
    -- Necrotic Boneplate Legguards
    [77011] = {78716, 78811, },
    -- Necrotic Boneplate Shoulderguards
    [77012] = {78751, 78846, },
    -- Deep Earth Raiment
    [77013] = {78665, 78760, },
    -- Deep Earth Grips
    [77014] = {78684, 78779, },
    -- Deep Earth Headpiece
    [77015] = {78694, 78789, },
    -- Deep Earth Legguards
    [77016] = {78713, 78808, },
    -- Deep Earth Gloves
    [77018] = {78676, 78771, },
    -- Deep Earth Cover
    [77019] = {78696, 78791, },
    -- Deep Earth Leggings
    [77020] = {78714, 78809, },
    -- Deep Earth Vestment
    [77021] = {78662, 78757, },
    -- Deep Earth Shoulderwraps
    [77022] = {78744, 78839, },
    -- Blackfang Battleweave Tunic
    [77023] = {78664, 78759, },
    -- Blackfang Battleweave Gloves
    [77024] = {78679, 78774, },
    -- Blackfang Battleweave Helmet
    [77025] = {78699, 78794, },
    -- Blackfang Battleweave Legguards
    [77026] = {78708, 78803, },
    -- Blackfang Battleweave Spaulders
    [77027] = {78738, 78833, },
    -- Wyrmstalker's Tunic
    [77028] = {78661, 78756, },
    -- Wyrmstalker's Gloves
    [77029] = {78674, 78769, },
    -- Wyrmstalker's Headguard
    [77030] = {78698, 78793, },
    -- Wyrmstalker's Legguards
    [77031] = {78709, 78804, },
    -- Wyrmstalker's Spaulders
    [77032] = {78737, 78832, },
    -- Spiritwalker's Shoulderwraps
    [77035] = {78741, 78836, },
    -- Spiritwalker's Kilt
    [77036] = {78711, 78806, },
    -- Spiritwalker's Headpiece
    [77037] = {78685, 78780, },
    -- Spiritwalker's Gloves
    [77038] = {78666, 78761, },
    -- Spiritwalker's Hauberk
    [77039] = {78723, 78818, },
    -- Spiritwalker's Cuirass
    [77040] = {78724, 78819, },
    -- Spiritwalker's Grips
    [77041] = {78667, 78762, },
    -- Spiritwalker's Helmet
    [77042] = {78686, 78781, },
    -- Spiritwalker's Legguards
    [77043] = {78704, 78799, },
    -- Spiritwalker's Spaulders
    [77044] = {78733, 78828, },
    -- Scintillating Rods
    [77078] = {78549, 78628, },
    -- Hungermouth Wand
    [77079] = {78548, 78627, },
    -- Ripfang Relic
    [77080] = {78554, 78633, },
    -- Gutripper Shard
    [77081] = {78550, 78629, },
    -- Mindbender Lens
    [77082] = {78553, 78630, },
    -- Lightning Spirit in a Bottle
    [77083] = {78552, 78631, },
    -- Stoutheart Talisman
    [77084] = {78551, 78632, },
    -- Unexpected Backup
    [77085] = {78557, 78636, },
    -- Windslicer Boomerang
    [77086] = {78559, 78637, },
    -- Darting Chakram
    [77087] = {78558, 78638, },
    -- Opal of the Secret Order
    [77088] = {78547, 78624, },
    -- Threadlinked Chain
    [77089] = {78545, 78626, },
    -- Necklace of Black Dragon's Teeth
    [77090] = {78543, 78625, },
    -- Cameo of Terrible Memories
    [77091] = {78546, 78622, },
    -- Guardspike Choker
    [77092] = {78544, 78623, },
    -- Batwing Cloak
    [77095] = {78509, 78587, },
    -- Woundlicker Cover
    [77096] = {78508, 78585, },
    -- Dreamcrusher Drape
    [77097] = {78506, 78586, },
    -- Nanoprecise Cape
    [77098] = {78510, 78588, },
    -- Indefatigable Greatcloak
    [77099] = {78507, 78589, },
    -- Seal of the Grand Architect
    [77108] = {78522, 78600, },
    -- Band of Reconstruction
    [77109] = {78523, 78601, },
    -- Ring of Torn Flesh
    [77110] = {78520, 78603, },
    -- Emergency Descent Loop
    [77111] = {78524, 78599, },
    -- Signet of the Resolute
    [77112] = {78521, 78602, },
    -- Kiroptyric Sigil
    [77113] = {77984, 78004, },
    -- Bottled Wishes
    [77114] = {77985, 78005, },
    -- Reflection of the Light
    [77115] = {77986, 78006, },
    -- Rotting Skull
    [77116] = {77987, 78007, },
    -- Fire of the Deep
    [77117] = {77988, 78008, },
    -- Bones of the Damned
    [77119] = {78499, 78583, },
    -- Chestplate of the Unshakable Titan
    [77120] = {78500, 78584, },
    -- Lightwarper Vestments
    [77121] = {78556, 78635, },
    -- Robes of Searing Shadow
    [77122] = {78555, 78634, },
    -- Shining Carapace of Glory
    [77123] = {78503, 78578, },
    -- Dragonflayer Vest
    [77124] = {78501, 78579, },
    -- Ghostworld Chestguard
    [77125] = {78502, 78580, },
    -- Shadowbinder Chestguard
    [77126] = {78504, 78581, },
    -- Decaying Herbalist's Robes
    [77127] = {78505, 78582, },
    -- Soulgaze Cowl
    [77146] = {78542, 78620, },
    -- Hood of Hidden Flesh
    [77147] = {78541, 78616, },
    -- Nocturnal Gaze
    [77148] = {78539, 78617, },
    -- Helmet of Perpetual Rebirth
    [77149] = {78540, 78618, },
    -- Zeherah's Dragonskull Crown
    [77150] = {78536, 78619, },
    -- Wolfdream Circlet
    [77151] = {78537, 78613, },
    -- Glowing Wings of Hope
    [77153] = {78538, 78621, },
    -- Visage of Petrification
    [77155] = {78534, 78614, },
    -- Jaw of Repudiation
    [77156] = {78535, 78615, },
    -- The Hands of Gilly
    [77157] = {78533, 78607, },
    -- Clockwinder's Immaculate Gloves
    [77159] = {78532, 78608, },
    -- Fungus-Born Gloves
    [77160] = {78531, 78604, },
    -- Lightfinger Handwraps
    [77161] = {78530, 78609, },
    -- Arrowflick Gauntlets
    [77162] = {78527, 78610, },
    -- Gloves of Ghostly Dreams
    [77163] = {78528, 78611, },
    -- Gleaming Grips of Mending
    [77164] = {78529, 78612, },
    -- Grimfist Crushers
    [77165] = {78525, 78605, },
    -- Gauntlets of Feathery Blows
    [77166] = {78526, 78606, },
    -- Silver Sabatons of Fury
    [77169] = {78514, 78593, },
    -- Kneebreaker Boots
    [77170] = {78515, 78590, },
    -- Bladeshatter Treads
    [77171] = {78511, 78591, },
    -- Boots of Fungoid Growth
    [77172] = {78517, 78592, },
    -- Rooftop Griptoes
    [77173] = {78516, 78594, },
    -- Sabatons of the Graceful Spirit
    [77174] = {78513, 78595, },
    -- Boneshard Boots
    [77175] = {78512, 78596, },
    -- Kavan's Forsaken Treads
    [77176] = {78518, 78597, },
    -- Splinterfoot Sandals
    [77177] = {78519, 78598, },
    -- Tentacular Belt
    [77179] = {78567, 78639, },
    -- Belt of Hidden Keys
    [77180] = {78565, 78640, },
    -- Belt of Universal Curing
    [77181] = {78566, 78641, },
    -- Cord of Dragon Sinew
    [77182] = {78561, 78642, },
    -- Girdle of Shamanic Fury
    [77183] = {78562, 78643, },
    -- Blinding Girdle of Truth
    [77184] = {78563, 78644, },
    -- Demonbone Waistguard
    [77185] = {78564, 78645, },
    -- Forgesmelter Waistplate
    [77186] = {78560, 78646, },
    -- Vestal's Irrepressible Girdle
    [77187] = {78568, 78647, },
    -- No'Kaled, the Elements of Death
    [77188] = {78472, 78481, },
    -- Blade of the Unmaker
    [77189] = {78474, 78483, },
    -- Ti'tahk, the Steps of Time
    [77190] = {78477, 78486, },
    -- Gurthalak, Voice of the Deeps
    [77191] = {78478, 78487, },
    -- Souldrinker
    [77193] = {78479, 78488, },
    -- Kiril, Fury of Beasts
    [77194] = {78473, 78482, },
    -- Rathrak, the Poisonous Mind
    [77195] = {78475, 78484, },
    -- Maw of the Dragonlord
    [77196] = {78476, 78485, },
    -- Wrath of Unchaining
    [77197] = {77974, 77994, },
    -- Will of Unbinding
    [77198] = {77975, 77995, },
    -- Heart of Unliving
    [77199] = {77976, 77996, },
    -- Eye of Unmaking
    [77200] = {77977, 77997, },
    -- Resolve of Undying
    [77201] = {77978, 77998, },
    -- Starcatcher Compass
    [77202] = {77973, 77993, },
    -- Insignia of the Corrupted Mind
    [77203] = {77971, 77991, },
    -- Seal of the Seven Signs
    [77204] = {77969, 77989, },
    -- Creche of the Final Dragon
    [77205] = {77972, 77992, },
    -- Soulshifter Vortex
    [77206] = {77970, 77990, },
    -- Vial of Shadows
    [77207] = {77979, 77999, },
    -- Cunning of the Cruel
    [77208] = {77980, 78000, },
    -- Windward Heart
    [77209] = {77981, 78001, },
    -- Bone-Link Fetish
    [77210] = {77982, 78002, },
    -- Indomitable Pride
    [77211] = {77983, 78003, },
    -- Hand of Morchok
    [77212] = {78371, 78379, },
    -- Razor Saronite Chip
    [77213] = {78369, 78374, },
    -- Vagaries of Time
    [77214] = {78363, 78383, },
    -- Horrifying Horn Arbalest
    [77215] = {78387, 78394, },
    -- Finger of Zon'ozz
    [77216] = {78392, 78399, },
    -- Experimental Specimen Slicer
    [77217] = {78403, 78409, },
    -- Spire of Coagulated Globules
    [77218] = {78401, 78407, },
    -- Scalpel of Unrelenting Agony
    [77219] = {78404, 78410, },
    -- Electrowing Dagger
    [77220] = {78414, 78422, },
    -- Lightning Rod
    [77221] = {78418, 78426, },
    -- Morningstar of Heroic Will
    [77223] = {78429, 78437, },
    -- Ataraxis, Cudgel of the Warmaster
    [77224] = {78445, 78453, },
    -- Visage of the Destroyer
    [77225] = {78451, 78459, },
    -- Blackhorn's Mighty Bulwark
    [77226] = {78448, 78456, },
    -- Timepiece of the Bronze Flight
    [77227] = {78450, 78458, },
    -- Infinite Loop
    [77228] = {78490, 78495, },
    -- Signet of Suturing
    [77229] = {78491, 78496, },
    -- Breathstealer Band
    [77230] = {78492, 78497, },
    -- Seal of Primordial Shadow
    [77231] = {78489, 78494, },
    -- Hardheart Ring
    [77232] = {78493, 78498, },
    -- Janglespur Jackboots
    [77234] = {78449, 78457, },
    -- Gauntlets of the Golden Thorn
    [77235] = {78464, 78469, },
    -- Backbreaker Spaulders
    [77236] = {78465, 78470, },
    -- Belt of Shattered Elementium
    [77237] = {78463, 78468, },
    -- Molten Blood Footpads
    [77238] = {78462, 78467, },
    -- Goriona's Collar
    [77239] = {78452, 78460, },
    -- Shadow Wing Armbands
    [77240] = {78446, 78454, },
    -- Belt of the Beloved Companion
    [77241] = {78447, 78455, },
    -- Imperfect Specimens 27 and 28
    [77242] = {78435, 78443, },
    -- Treads of Sordid Screams
    [77243] = {78434, 78442, },
    -- Dragonfracture Belt
    [77244] = {78436, 78444, },
    -- Ledger of Revolting Rituals
    [77245] = {78433, 78441, },
    -- Stillheart Warboots
    [77246] = {78431, 78439, },
    -- Bracers of Looming Darkness
    [77247] = {78430, 78438, },
    -- Girdle of the Grotesque
    [77248] = {78420, 78428, },
    -- Bracers of the Banished
    [77249] = {78417, 78425, },
    -- Runescriven Demon Collar
    [77250] = {78416, 78424, },
    -- Treads of Dormant Dreams
    [77251] = {78415, 78423, },
    -- Mindstrainer Treads
    [77252] = {78405, 78411, },
    -- Heartblood Wristplates
    [77253] = {78406, 78412, },
    -- Interrogator's Bloody Footpads
    [77254] = {78402, 78408, },
    -- Cord of the Slain Champion
    [77255] = {78391, 78398, },
    -- Grotesquely Writhing Bracers
    [77257] = {78393, 78400, },
    -- Graveheart Bracers
    [77258] = {78390, 78397, },
    -- Treads of Crushed Flesh
    [77259] = {78389, 78396, },
    -- Belt of Flayed Skin
    [77260] = {78388, 78395, },
    -- Mycosynth Wristguards
    [77261] = {78372, 78384, },
    -- Petrified Fungal Heart
    [77262] = {78364, 78382, },
    -- Robe of Glowing Stone
    [77263] = {78365, 78380, },
    -- Pillarfoot Greaves
    [77265] = {78361, 78386, },
    -- Girdle of Shattered Stone
    [77266] = {78370, 78385, },
    -- Mosswrought Shoulderguards
    [77267] = {78366, 78381, },
    -- Brackenshell Shoulderplates
    [77268] = {78367, 78378, },
    -- Sporebeard Gauntlets
    [77269] = {78362, 78376, },
    -- Rockhide Bracers
    [77270] = {78373, 78377, },
    -- Underdweller's Spaulders
    [77271] = {78368, 78375, },
    -- Flashing Bracers of Warmth
    [77316] = {78573, 78648, },
    -- Heartcrusher Wristplates
    [77317] = {78569, 78649, },
    -- Bracers of Unrelenting Excellence
    [77318] = {78570, 78650, },
    -- Bracers of the Spectral Wolf
    [77319] = {78572, 78651, },
    -- Luminescent Bracers
    [77320] = {78575, 78652, },
    -- Dragonbelly Bracers
    [77321] = {78571, 78653, },
    -- Bracers of Manifold Pockets
    [77322] = {78574, 78654, },
    -- Bracers of the Black Dream
    [77323] = {78577, 78655, },
    -- Chronoboost Bracers
    [77324] = {78576, 78656, },
    -- High Warlord's Battle Mace
    [77567] = {77570, 234551, },
    -- High Warlord's Spellblade
    [77568] = {77586, 234550, },
    -- High Warlord's Quickblade
    [77569] = {77588, 234553, },
    -- High Warlord's Destroyer
    [77571] = {77587, 234546, },
    -- High Warlord's Razor
    [77576] = {234556, 90819, },
    -- Signet of Grasping Mouths
    [78011] = {78413, 78421, },
    -- Ring of the Riven
    [78012] = {78419, 78427, },
    -- Curled Twilight Claw
    [78013] = {78432, 78440, },
    -- Shoulders of the Corrupted Vanquisher
    [78170] = {78861, 78874, },
    -- Leggings of the Corrupted Vanquisher
    [78171] = {78858, 78871, },
    -- Crown of the Corrupted Vanquisher
    [78172] = {78852, 78868, },
    -- Gauntlets of the Corrupted Vanquisher
    [78173] = {78855, 78865, },
    -- Chest of the Corrupted Vanquisher
    [78174] = {78849, 78862, },
    -- Shoulders of the Corrupted Protector
    [78175] = {78860, 78876, },
    -- Leggings of the Corrupted Protector
    [78176] = {78857, 78873, },
    -- Crown of the Corrupted Protector
    [78177] = {78851, 78870, },
    -- Gauntlets of the Corrupted Protector
    [78178] = {78854, 78867, },
    -- Chest of the Corrupted Protector
    [78179] = {78848, 78864, },
    -- Shoulders of the Corrupted Conqueror
    [78180] = {78859, 78875, },
    -- Leggings of the Corrupted Conqueror
    [78181] = {78856, 78872, },
    -- Crown of the Corrupted Conqueror
    [78182] = {78850, 78869, },
    -- Gauntlets of the Corrupted Conqueror
    [78183] = {78853, 78866, },
    -- Chest of the Corrupted Conqueror
    [78184] = {78847, 78863, },
    -- Gloves of Liquid Smoke
    [78357] = {78461, 78466, },
    -- Vishanka, Jaws of the Earth
    [78359] = {78471, 78480, },
    -- Reins of the Great Red Dragon Turtle
    [82811] = {91010, 91016, },
    -- Malevolent Gladiator's Bonegrinder
    [84785] = {85107, 91442, },
    -- Malevolent Gladiator's Pike
    [84786] = {85108, 91660, },
    -- Malevolent Gladiator's Battle Staff
    [84787] = {85109, 91486, },
    -- Malevolent Gladiator's Energy Staff
    [84788] = {85110, 91560, },
    -- Malevolent Gladiator's Staff
    [84789] = {85111, 91535, },
    -- Malevolent Gladiator's Greatsword
    [84790] = {85112, 91444, },
    -- Malevolent Gladiator's Decapitator
    [84791] = {85113, 91440, },
    -- Malevolent Gladiator's Leather Tunic
    [84792] = {84995, 91693, },
    -- Malevolent Gladiator's Ornamented Chestguard
    [84793] = {84991, 91640, },
    -- Malevolent Gladiator's Scaled Chestpiece
    [84794] = {84992, 91620, },
    -- Malevolent Gladiator's Dreadplate Chestpiece
    [84795] = {84993, 91500, },
    -- Malevolent Gladiator's Chain Armor
    [84796] = {84994, 91575, },
    -- Malevolent Gladiator's Plate Chestpiece
    [84797] = {84987, 91783, },
    -- Malevolent Gladiator's Mail Armor
    [84798] = {84988, 91733, },
    -- Malevolent Gladiator's Linked Armor
    [84799] = {84989, 91721, },
    -- Malevolent Gladiator's Ringmail Armor
    [84800] = {84990, 91711, },
    -- Malevolent Gladiator's Boots of Cruelty
    [84808] = {85009, 91690, },
    -- Malevolent Gladiator's Boots of Alacrity
    [84809] = {85010, 91597, },
    -- Malevolent Gladiator's Warboots of Cruelty
    [84810] = {85000, 91654, },
    -- Malevolent Gladiator's Greaves of Alacrity
    [84811] = {85001, 91634, },
    -- Malevolent Gladiator's Greaves of Meditation
    [84812] = {85002, 91636, },
    -- Malevolent Gladiator's Treads of Meditation
    [84816] = {85006, 91472, },
    -- Malevolent Gladiator's Sabatons of Cruelty
    [84817] = {85007, 91569, },
    -- Malevolent Gladiator's Sabatons of Alacrity
    [84818] = {85008, 91571, },
    -- Malevolent Gladiator's Warboots of Alacrity
    [84822] = {84999, 91656, },
    -- Malevolent Gladiator's Leather Gloves
    [84830] = {85023, 91695, },
    -- Malevolent Gladiator's Ornamented Gloves
    [84831] = {85024, 91642, },
    -- Malevolent Gladiator's Dragonhide Gloves
    [84832] = {85025, 91510, },
    -- Malevolent Gladiator's Kodohide Gloves
    [84833] = {85026, 91525, },
    -- Malevolent Gladiator's Scaled Gauntlets
    [84834] = {85027, 91622, },
    -- Malevolent Gladiator's Dreadplate Gauntlets
    [84835] = {85028, 91502, },
    -- Malevolent Gladiator's Copperskin Gloves
    [84836] = {85015, 91610, },
    -- Malevolent Gladiator's Ironskin Gloves
    [84839] = {85018, 91600, },
    -- Malevolent Gladiator's Plate Gauntlets
    [84840] = {85019, 91785, },
    -- Malevolent Gladiator's Chain Gauntlets
    [84841] = {85020, 91577, },
    -- Malevolent Gladiator's Felweave Handguards
    [84842] = {85021, 91773, },
    -- Malevolent Gladiator's Wyrmhide Gloves
    [84843] = {85022, 91542, },
    -- Malevolent Gladiator's Linked Gauntlets
    [84844] = {85011, 91723, },
    -- Malevolent Gladiator's Mail Gauntlets
    [84845] = {85012, 91735, },
    -- Malevolent Gladiator's Mooncloth Gloves
    [84846] = {85013, 91662, },
    -- Malevolent Gladiator's Ringmail Gauntlets
    [84847] = {85014, 91713, },
    -- Malevolent Gladiator's Leather Helm
    [84848] = {85041, 91697, },
    -- Malevolent Gladiator's Ornamented Headcover
    [84849] = {85042, 91644, },
    -- Malevolent Gladiator's Kodohide Helm
    [84850] = {85043, 91527, },
    -- Malevolent Gladiator's Scaled Helm
    [84851] = {85044, 91624, },
    -- Malevolent Gladiator's Dragonhide Helm
    [84852] = {85045, 91512, },
    -- Malevolent Gladiator's Dreadplate Helm
    [84853] = {85046, 91504, },
    -- Malevolent Gladiator's Copperskin Helm
    [84854] = {85030, 91612, },
    -- Malevolent Gladiator's Plate Helm
    [84856] = {85032, 91787, },
    -- Malevolent Gladiator's Ironskin Helm
    [84857] = {85033, 91602, },
    -- Malevolent Gladiator's Chain Helm
    [84858] = {85034, 91579, },
    -- Malevolent Gladiator's Felweave Cowl
    [84859] = {85035, 91775, },
    -- Malevolent Gladiator's Mail Helm
    [84860] = {85036, 91737, },
    -- Malevolent Gladiator's Wyrmhide Helm
    [84861] = {85037, 91544, },
    -- Malevolent Gladiator's Linked Helm
    [84862] = {85038, 91725, },
    -- Malevolent Gladiator's Satin Hood
    [84864] = {85040, 91674, },
    -- Malevolent Gladiator's Ringmail Helm
    [84865] = {85029, 91715, },
    -- Malevolent Gladiator's Reprieve
    [84867] = {85115, 91494, },
    -- Malevolent Gladiator's Leather Legguards
    [84868] = {85055, 91699, },
    -- Malevolent Gladiator's Ornamented Legplates
    [84869] = {85056, 91646, },
    -- Malevolent Gladiator's Scaled Legguards
    [84870] = {85057, 91626, },
    -- Malevolent Gladiator's Dragonhide Legguards
    [84871] = {85058, 91514, },
    -- Malevolent Gladiator's Dreadplate Legguards
    [84872] = {85059, 91506, },
    -- Malevolent Gladiator's Copperskin Legguards
    [84873] = {85060, 91614, },
    -- Malevolent Gladiator's Chain Leggings
    [84874] = {85061, 91581, },
    -- Malevolent Gladiator's Plate Legguards
    [84876] = {85063, 91789, },
    -- Malevolent Gladiator's Ironskin Legguards
    [84877] = {85064, 91604, },
    -- Malevolent Gladiator's Felweave Trousers
    [84878] = {85047, 91777, },
    -- Malevolent Gladiator's Mail Leggings
    [84879] = {85048, 91739, },
    -- Malevolent Gladiator's Wyrmhide Legguards
    [84880] = {85049, 91546, },
    -- Malevolent Gladiator's Linked Leggings
    [84881] = {85050, 91727, },
    -- Malevolent Gladiator's Kodohide Legguards
    [84882] = {85051, 91529, },
    -- Malevolent Gladiator's Mooncloth Leggings
    [84883] = {85052, 91666, },
    -- Malevolent Gladiator's Ringmail Leggings
    [84885] = {85054, 91717, },
    -- Malevolent Gladiator's Fleshslicer
    [84893] = {85116, 91747, },
    -- Malevolent Gladiator's Slasher
    [84894] = {85117, 91751, },
    -- Malevolent Gladiator's Shiv
    [84895] = {85118, 91552, },
    -- Malevolent Gladiator's Longbow
    [84896] = {85119, 91460, },
    -- Malevolent Gladiator's Heavy Crossbow
    [84897] = {85120, 91498, },
    -- Malevolent Gladiator's Touch of Defeat
    [84898] = {85121, 91496, },
    -- Malevolent Gladiator's Baton of Light
    [84899] = {85122, 91755, },
    -- Malevolent Gladiator's Rifle
    [84900] = {85123, 91554, },
    -- Malevolent Gladiator's Dragonhide Robes
    [84901] = {85065, 91516, },
    -- Malevolent Gladiator's Ironskin Tunic
    [84902] = {85066, 91608, },
    -- Malevolent Gladiator's Copperskin Tunic
    [84903] = {85067, 91618, },
    -- Malevolent Gladiator's Felweave Raiment
    [84905] = {85069, 91779, },
    -- Malevolent Gladiator's Wyrmhide Robes
    [84906] = {85070, 91548, },
    -- Malevolent Gladiator's Kodohide Robes
    [84907] = {85071, 91531, },
    -- Malevolent Gladiator's Mooncloth Robe
    [84908] = {85072, 91668, },
    -- Malevolent Gladiator's Shield Wall
    [84910] = {85124, 91771, },
    -- Malevolent Gladiator's Barrier
    [84911] = {85125, 91482, },
    -- Malevolent Gladiator's Redoubt
    [84912] = {85126, 91558, },
    -- Malevolent Gladiator's Leather Spaulders
    [84913] = {85089, 91701, },
    -- Malevolent Gladiator's Ornamented Spaulders
    [84914] = {85090, 91648, },
    -- Malevolent Gladiator's Scaled Shoulders
    [84915] = {85091, 91628, },
    -- Malevolent Gladiator's Dragonhide Spaulders
    [84916] = {85084, 91518, },
    -- Malevolent Gladiator's Dreadplate Shoulders
    [84918] = {85086, 91508, },
    -- Malevolent Gladiator's Ironskin Spaulders
    [84919] = {85087, 91606, },
    -- Malevolent Gladiator's Copperskin Spaulders
    [84920] = {85088, 91616, },
    -- Malevolent Gladiator's Chain Spaulders
    [84921] = {85076, 91583, },
    -- Malevolent Gladiator's Plate Shoulders
    [84922] = {85077, 91791, },
    -- Malevolent Gladiator's Felweave Amice
    [84923] = {85078, 91781, },
    -- Malevolent Gladiator's Mail Spaulders
    [84924] = {85079, 91741, },
    -- Malevolent Gladiator's Wyrmhide Spaulders
    [84925] = {85080, 91550, },
    -- Malevolent Gladiator's Linked Spaulders
    [84926] = {85081, 91729, },
    -- Malevolent Gladiator's Kodohide Spaulders
    [84927] = {85082, 91533, },
    -- Malevolent Gladiator's Mooncloth Mantle
    [84928] = {85083, 91670, },
    -- Malevolent Gladiator's Ringmail Spaulders
    [84930] = {85075, 91719, },
    -- Malevolent Gladiator's Waistguard of Meditation
    [84946] = {85099, 91703, },
    -- Malevolent Gladiator's Waistband of Cruelty
    [84947] = {85100, 91595, },
    -- Malevolent Gladiator's Waistband of Accuracy
    [84948] = {85101, 91688, },
    -- Malevolent Gladiator's Girdle of Accuracy
    [84949] = {85102, 91650, },
    -- Malevolent Gladiator's Girdle of Prowess
    [84950] = {85103, 91652, },
    -- Malevolent Gladiator's Clasp of Cruelty
    [84951] = {85104, 91630, },
    -- Malevolent Gladiator's Clasp of Meditation
    [84952] = {85105, 91632, },
    -- Malevolent Gladiator's Belt of Meditation
    [84953] = {85106, 91520, },
    -- Malevolent Gladiator's Cord of Meditation
    [84956] = {85094, 91466, },
    -- Malevolent Gladiator's Links of Accuracy
    [84957] = {85095, 91567, },
    -- Malevolent Gladiator's Links of Cruelty
    [84958] = {85096, 91565, },
    -- Malevolent Gladiator's Waistguard of Cruelty
    [84959] = {85097, 91731, },
    -- Malevolent Gladiator's Belt of Cruelty
    [84960] = {85098, 91537, },
    -- Malevolent Gladiator's Ripper
    [84962] = {85128, 91745, },
    -- Malevolent Gladiator's Render
    [84963] = {85129, 91749, },
    -- Malevolent Gladiator's Pummeler
    [84964] = {85130, 91448, },
    -- Malevolent Gladiator's Cleaver
    [84965] = {85131, 91446, },
    -- Malevolent Gladiator's Hacker
    [84966] = {85132, 91757, },
    -- Malevolent Gladiator's Shanker
    [84967] = {85133, 91743, },
    -- Malevolent Gladiator's Slicer
    [84968] = {85134, 91761, },
    -- Malevolent Gladiator's Quickblade
    [84969] = {85135, 91450, },
    -- Malevolent Gladiator's Bonecracker
    [84970] = {85136, 91759, },
    -- Malevolent Gladiator's Gavel
    [84971] = {85137, 91556, },
    -- Malevolent Gladiator's Cuffs of Meditation
    [84979] = {91476, 97521, },
    -- Firebird's Spaulders
    [85284] = {86624, 87138, },
    -- Firebird's Legguards
    [85285] = {86625, 87137, },
    -- Firebird's Helmet
    [85286] = {86626, 87136, },
    -- Firebird's Grips
    [85287] = {86627, 87135, },
    -- Firebird's Cuirass
    [85288] = {86628, 87134, },
    -- Firebird's Hauberk
    [85289] = {86629, 87139, },
    -- Firebird's Gloves
    [85290] = {86630, 87140, },
    -- Firebird's Headpiece
    [85291] = {86631, 87141, },
    -- Firebird's Kilt
    [85292] = {86632, 87142, },
    -- Firebird's Shoulderwraps
    [85293] = {86633, 87143, },
    -- Yaungol Slayer's Spaulders
    [85294] = {86634, 87006, },
    -- Yaungol Slayer's Legguards
    [85295] = {86635, 87005, },
    -- Yaungol Slayer's Headguard
    [85296] = {86636, 87004, },
    -- Yaungol Slayer's Gloves
    [85297] = {86637, 87003, },
    -- Yaungol Slayer's Tunic
    [85298] = {86638, 87002, },
    -- Spaulders of the Thousandfold Blades
    [85299] = {86639, 87128, },
    -- Legguards of the Thousandfold Blades
    [85300] = {86640, 87127, },
    -- Helmet of the Thousandfold Blades
    [85301] = {86641, 87126, },
    -- Gloves of the Thousandfold Blades
    [85302] = {86642, 87125, },
    -- Tunic of the Thousandfold Blades
    [85303] = {86643, 87124, },
    -- Eternal Blossom Shoulderwraps
    [85304] = {86644, 86937, },
    -- Eternal Blossom Vestment
    [85305] = {86645, 86936, },
    -- Eternal Blossom Leggings
    [85306] = {86646, 86935, },
    -- Eternal Blossom Cover
    [85307] = {86647, 86934, },
    -- Eternal Blossom Gloves
    [85308] = {86648, 86933, },
    -- Eternal Blossom Spaulders
    [85309] = {86649, 86927, },
    -- Eternal Blossom Legguards
    [85310] = {86650, 86926, },
    -- Eternal Blossom Headpiece
    [85311] = {86651, 86925, },
    -- Eternal Blossom Grips
    [85312] = {86652, 86924, },
    -- Eternal Blossom Raiment
    [85313] = {86653, 86923, },
    -- Shoulderguards of the Lost Catacomb
    [85314] = {86654, 86922, },
    -- Legguards of the Lost Catacomb
    [85315] = {86655, 86921, },
    -- Faceguard of the Lost Catacomb
    [85316] = {86656, 86920, },
    -- Handguards of the Lost Catacomb
    [85317] = {86657, 86919, },
    -- Chestguard of the Lost Catacomb
    [85318] = {86658, 86918, },
    -- White Tiger Shoulderguards
    [85319] = {86659, 87113, },
    -- White Tiger Legguards
    [85320] = {86660, 87112, },
    -- White Tiger Faceguard
    [85321] = {86661, 87111, },
    -- White Tiger Handguards
    [85322] = {86662, 87110, },
    -- White Tiger Chestguard
    [85323] = {86663, 87109, },
    -- Shoulderguards of Resounding Rings
    [85324] = {86664, 87201, },
    -- Legguards of Resounding Rings
    [85325] = {86665, 87200, },
    -- Faceguard of Resounding Rings
    [85326] = {86666, 87199, },
    -- Handguards of Resounding Rings
    [85327] = {86667, 87198, },
    -- Chestguard of Resounding Rings
    [85328] = {86668, 87197, },
    -- Pauldrons of Resounding Rings
    [85329] = {86669, 87196, },
    -- Legplates of Resounding Rings
    [85330] = {86670, 87195, },
    -- Gauntlets of Resounding Rings
    [85331] = {86671, 87194, },
    -- Battleplate of Resounding Rings
    [85332] = {86672, 87193, },
    -- Helmet of Resounding Rings
    [85333] = {86673, 87192, },
    -- Pauldrons of the Lost Catacomb
    [85334] = {86674, 86917, },
    -- Greaves of the Lost Catacomb
    [85335] = {86675, 86916, },
    -- Helmet of the Lost Catacomb
    [85336] = {86676, 86915, },
    -- Gauntlets of the Lost Catacomb
    [85337] = {86677, 86914, },
    -- Breastplate of the Lost Catacomb
    [85338] = {86678, 86913, },
    -- White Tiger Pauldrons
    [85339] = {86679, 87103, },
    -- White Tiger Legplates
    [85340] = {86680, 87102, },
    -- White Tiger Helmet
    [85341] = {86681, 87101, },
    -- White Tiger Gauntlets
    [85342] = {86682, 87100, },
    -- White Tiger Battleplate
    [85343] = {86683, 87099, },
    -- White Tiger Mantle
    [85344] = {86684, 87108, },
    -- White Tiger Greaves
    [85345] = {86685, 87107, },
    -- White Tiger Headguard
    [85346] = {86686, 87106, },
    -- White Tiger Gloves
    [85347] = {86687, 87105, },
    -- White Tiger Breastplate
    [85348] = {86688, 87104, },
    -- Firebird's Mantle
    [85349] = {86689, 87133, },
    -- Firebird's Legwraps
    [85350] = {86690, 87132, },
    -- Firebird's Faceguard
    [85351] = {86691, 87131, },
    -- Firebird's Handwraps
    [85352] = {86692, 87130, },
    -- Firebird's Tunic
    [85353] = {86693, 87129, },
    -- Eternal Blossom Mantle
    [85354] = {86694, 86932, },
    -- Eternal Blossom Robes
    [85355] = {86695, 86931, },
    -- Eternal Blossom Legwraps
    [85356] = {86696, 86930, },
    -- Eternal Blossom Helm
    [85357] = {86697, 86929, },
    -- Eternal Blossom Handwraps
    [85358] = {86698, 86928, },
    -- Guardian Serpent Mantle
    [85359] = {86699, 87118, },
    -- Guardian Serpent Robes
    [85360] = {86700, 87117, },
    -- Guardian Serpent Legwraps
    [85361] = {86701, 87116, },
    -- Guardian Serpent Cowl
    [85362] = {86702, 87115, },
    -- Guardian Serpent Handwraps
    [85363] = {86703, 87114, },
    -- Guardian Serpent Gloves
    [85364] = {86704, 87119, },
    -- Guardian Serpent Hood
    [85365] = {86705, 87120, },
    -- Guardian Serpent Leggings
    [85366] = {86706, 87121, },
    -- Guardian Serpent Raiment
    [85367] = {86707, 87122, },
    -- Guardian Serpent Shoulderguards
    [85368] = {86708, 87123, },
    -- Sha-Skin Gloves
    [85369] = {86709, 87187, },
    -- Sha-Skin Hood
    [85370] = {86710, 87188, },
    -- Sha-Skin Leggings
    [85371] = {86711, 87189, },
    -- Sha-Skin Robes
    [85372] = {86712, 87190, },
    -- Sha-Skin Mantle
    [85373] = {86713, 87191, },
    -- Eternal Blossom Tunic
    [85379] = {86719, 86938, },
    -- Eternal Blossom Handguards
    [85380] = {86720, 86939, },
    -- Eternal Blossom Headguard
    [85381] = {86721, 86940, },
    -- Eternal Blossom Breeches
    [85382] = {86722, 86941, },
    -- Eternal Blossom Shoulderguards
    [85383] = {86723, 86942, },
    -- Red Crane Shoulderguards
    [85384] = {86724, 87098, },
    -- Red Crane Legguards
    [85385] = {86725, 87097, },
    -- Red Crane Crown
    [85386] = {86726, 87096, },
    -- Red Crane Gauntlets
    [85387] = {86727, 87095, },
    -- Red Crane Chestguard
    [85388] = {86728, 87094, },
    -- Red Crane Handwraps
    [85389] = {86729, 87089, },
    -- Red Crane Helm
    [85390] = {86730, 87090, },
    -- Red Crane Legwraps
    [85391] = {86731, 87091, },
    -- Red Crane Vest
    [85392] = {86732, 87092, },
    -- Red Crane Mantle
    [85393] = {86733, 87093, },
    -- Red Crane Tunic
    [85394] = {86734, 87084, },
    -- Red Crane Grips
    [85395] = {86735, 87085, },
    -- Red Crane Headpiece
    [85396] = {86736, 87086, },
    -- Red Crane Leggings
    [85397] = {86737, 87087, },
    -- Red Crane Spaulders
    [85398] = {86738, 87088, },
    -- Beads of the Mogu'shi
    [85922] = {86739, 87016, },
    -- Stonemaw Armguards
    [85923] = {86740, 87014, },
    -- Dagger of the Seven Stars
    [85924] = {86741, 87012, },
    -- Jasper Clawfeet
    [85925] = {86742, 87015, },
    -- Stoneflesh Leggings
    [85926] = {86743, 87013, },
    -- Heavenly Jade Greatboots
    [85975] = {86744, 87021, },
    -- Sixteen-Fanged Crown
    [85976] = {86745, 87020, },
    -- Stonebound Cinch
    [85977] = {86746, 87019, },
    -- Cape of Three Lanterns
    [85979] = {86748, 87018, },
    -- Wildfire Worldwalkers
    [85980] = {86749, 87023, },
    -- Tomb Raider's Girdle
    [85982] = {86750, 87022, },
    -- Bracers of Six Oxen
    [85983] = {86751, 87025, },
    -- Nullification Greathelm
    [85984] = {86752, 87024, },
    -- Cloak of Peacock Feathers
    [85985] = {86753, 87026, },
    -- Chain of Shadow
    [85987] = {86755, 87030, },
    -- Legplates of Sagacious Shadows
    [85988] = {86756, 87031, },
    -- Hood of Cursed Dreams
    [85989] = {86757, 87029, },
    -- Soulgrasp Choker
    [85991] = {86759, 87036, },
    -- Sollerets of Spirit Splitting
    [85992] = {86760, 87035, },
    -- Fetters of Death
    [85993] = {86761, 87034, },
    -- Gara'kal, Fist of the Spiritbinder
    [85994] = {86762, 87032, },
    -- Netherrealm Shoulderpads
    [85995] = {86763, 87033, },
    -- Eye of the Ancient Spirit
    [85996] = {86764, 87039, },
    -- Sandals of the Severed Soul
    [85997] = {86765, 87037, },
    -- Bindings of Ancient Spirits
    [86027] = {86766, 87043, },
    -- Spaulders of the Divided Mind
    [86039] = {86768, 87041, },
    -- Leggings of Imprisoned Will
    [86040] = {86769, 87042, },
    -- Jade Charioteer Figurine
    [86042] = {86771, 87082, },
    -- Jade Bandit Figurine
    [86043] = {86772, 87079, },
    -- Jade Magistrate Figurine
    [86044] = {86773, 87080, },
    -- Jade Warlord Figurine
    [86046] = {86775, 87083, },
    -- Amulet of the Hidden Kings
    [86047] = {86776, 87045, },
    -- Screaming Tiger, Qiang's Unbreakable Polearm
    [86071] = {86777, 87046, },
    -- Steelskin, Qiang's Impervious Shield
    [86075] = {86778, 87050, },
    -- Breastplate of the Kings' Guard
    [86076] = {86779, 87048, },
    -- Shoulderguards of the Unflanked
    [86080] = {86780, 87049, },
    -- Subetai's Pillaging Leggings
    [86081] = {86781, 87047, },
    -- Arrow Breaking Windcloak
    [86082] = {86782, 87044, },
    -- Zian's Choker of Coalesced Shadow
    [86083] = {86783, 87053, },
    -- Meng's Treads of Insanity
    [86084] = {86784, 87055, },
    -- Girdle of Delirious Visions
    [86086] = {86785, 87056, },
    -- Bracers of Dark Thoughts
    [86127] = {86786, 87054, },
    -- Undying Shadow Grips
    [86128] = {86787, 87052, },
    -- Hood of Blind Eyes
    [86129] = {86788, 87051, },
    -- Elegion, the Fanged Crescent
    [86130] = {86789, 87062, },
    -- Vial of Dragon's Blood
    [86131] = {86790, 87063, },
    -- Bottle of Infinite Stars
    [86132] = {86791, 87057, },
    -- Star-Stealer Waistguard
    [86134] = {86793, 87060, },
    -- Starcrusher Gauntlets
    [86135] = {86794, 87059, },
    -- Chestguard of Total Annihilation
    [86136] = {86795, 87058, },
    -- Torch of the Celestial Spark
    [86137] = {86796, 87066, },
    -- Phasewalker Striders
    [86138] = {86797, 87067, },
    -- Starshatter
    [86140] = {86799, 87061, },
    -- Shoulders of Empyreal Focus
    [86141] = {86800, 87068, },
    -- Fang Kung, Spark of Titans
    [86142] = {86801, 87069, },
    -- Lei Shen's Final Orders
    [86144] = {86802, 87072, },
    -- Jang-xi's Devastating Legplates
    [86145] = {86803, 87071, },
    -- Crown of Opportunistic Strikes
    [86146] = {86804, 87070, },
    -- Qin-xi's Polarizing Seal
    [86147] = {86805, 87075, },
    -- Tihan, Scepter of the Sleeping Emperor
    [86148] = {86806, 87074, },
    -- Spaulders of the Emperor's Rage
    [86149] = {86807, 87078, },
    -- Magnetized Leggings
    [86150] = {86808, 87077, },
    -- Hood of Focused Energy
    [86151] = {86809, 87073, },
    -- Worldwaker Cabochon
    [86152] = {86810, 87076, },
    -- Boots of the Still Breath
    [86153] = {86811, 86943, },
    -- Hisek's Chrysanthemum Cape
    [86154] = {86812, 86945, },
    -- Vizier's Ruby Signet
    [86155] = {86813, 86946, },
    -- Chestplate of the Forbidden Tower
    [86158] = {86816, 86952, },
    -- Gauntlets of Undesired Gifts
    [86159] = {86817, 86950, },
    -- Mail of Screaming Secrets
    [86160] = {86818, 86951, },
    -- Ring of the Bladed Tempest
    [86162] = {86820, 86957, },
    -- Bracers of Unseen Strikes
    [86163] = {86821, 86954, },
    -- Waistplate of Overwhelming Assault
    [86164] = {86822, 86955, },
    -- Windblade Talons
    [86165] = {86823, 86956, },
    -- Choker of the Unleashed Storm
    [86166] = {86824, 86953, },
    -- Boots of the Blowing Wind
    [86167] = {86825, 86959, },
    -- Bracers of Tempestuous Fury
    [86168] = {86826, 86962, },
    -- Tornado-Summoning Censer
    [86171] = {86829, 86960, },
    -- Ring of the Shattered Shell
    [86172] = {86830, 86968, },
    -- Legbreaker Greatcloak
    [86173] = {86831, 86963, },
    -- Garalon's Hollow Skull
    [86174] = {86832, 86966, },
    -- Grips of the Leviathan
    [86175] = {86833, 86965, },
    -- Bonebreaker Gauntlets
    [86176] = {86834, 86964, },
    -- Necklace of Congealed Weaknesses
    [86177] = {86835, 86967, },
    -- Grasps of Panic
    [86179] = {86837, 86973, },
    -- Robes of Eighty Lights
    [86180] = {86838, 86972, },
    -- Xaril's Hood of Intoxicating Vapors
    [86181] = {86839, 86970, },
    -- Shining Cicada Bracers
    [86183] = {86841, 86992, },
    -- Luminescent Firefly Wristguards
    [86184] = {86842, 86998, },
    -- Smooth Beetle Wristbands
    [86185] = {86843, 86995, },
    -- Gleaming Moth Cuffs
    [86186] = {86844, 86994, },
    -- Pearlescent Butterfly Wristbands
    [86187] = {86845, 86996, },
    -- Inlaid Cricket Bracers
    [86188] = {86846, 86999, },
    -- Jagged Hornet Bracers
    [86189] = {86847, 86997, },
    -- Serrated Wasp Bracers
    [86190] = {86848, 87001, },
    -- Plated Locust Bracers
    [86191] = {86849, 87000, },
    -- Painful Thorned Ring
    [86200] = {86851, 86974, },
    -- Impaling Treads
    [86201] = {86852, 86979, },
    -- Cloak of Raining Blades
    [86202] = {86853, 86980, },
    -- Articulated Legplates
    [86203] = {86854, 86944, },
    -- Wingslasher Pauldrons
    [86204] = {86855, 86978, },
    -- Belt of Malleable Amber
    [86210] = {86857, 86981, },
    -- Seal of the Profane
    [86211] = {86858, 86982, },
    -- Treads of Deadly Secretions
    [86212] = {86859, 86984, },
    -- Shoulderpads of Misshapen Life
    [86213] = {86860, 86986, },
    -- Monstrous Stompers
    [86214] = {86861, 86985, },
    -- Un'sok's Amber Scalpel
    [86217] = {86862, 86983, },
    -- Scimitar of Seven Stars
    [86219] = {86863, 86987, },
    -- Claws of Shek'zeer
    [86226] = {86864, 86988, },
    -- Crown of the Doomed Empress
    [86228] = {86866, 86991, },
    -- Leggings of Shadow Infestation
    [86229] = {86867, 86989, },
    -- Gao-Rei, Staff of the Legendary Protector
    [86321] = {86879, 87156, },
    -- Dread Shadow Ring
    [86322] = {86880, 87158, },
    -- Stuff of Nightmares
    [86323] = {86881, 87160, },
    -- Sunwrought Mail Hauberk
    [86324] = {86882, 87157, },
    -- Daybreak Drape
    [86325] = {86883, 87159, },
    -- Spirits of the Sun
    [86327] = {86885, 87163, },
    -- Loshan, Terror Incarnate
    [86328] = {86886, 87164, },
    -- Sollerets of Instability
    [86329] = {86887, 87165, },
    -- Sandals of the Blackest Night
    [86330] = {86888, 87162, },
    -- Taoren, the Soul Burner
    [86331] = {86889, 87168, },
    -- Terror in the Mists
    [86332] = {86890, 87167, },
    -- Cuirass of the Animated Protector
    [86333] = {86891, 87171, },
    -- Robes of the Unknown Fear
    [86334] = {86892, 87169, },
    -- Darkmist Vortex
    [86336] = {86894, 87172, },
    -- Healer's Belt of Final Winter
    [86337] = {86895, 87178, },
    -- Invoker's Belt of Final Winter
    [86338] = {86896, 87177, },
    -- Sorcerer's Belt of Final Winter
    [86339] = {86897, 87179, },
    -- Weaver's Cord of Eternal Autumn
    [86340] = {86898, 87181, },
    -- Stalker's Cord of Eternal Autumn
    [86341] = {86899, 87180, },
    -- Binder's Chain of Unending Summer
    [86342] = {86900, 87183, },
    -- Ranger's Chain of Unending Summer
    [86343] = {86901, 87182, },
    -- Mender's Girdle of Endless Spring
    [86383] = {86902, 87184, },
    -- Protector's Girdle of Endless Spring
    [86384] = {86903, 87185, },
    -- Patroller's Girdle of Endless Spring
    [86385] = {86904, 87186, },
    -- Shin'ka, Execution of Dominion
    [86386] = {86905, 87176, },
    -- Kilrak, Jaws of Terror
    [86387] = {86906, 87173, },
    -- Spiritsever
    [86391] = {86910, 87166, },
    -- Robes of Torn Nightmares
    [86513] = {86911, 86975, },
    -- Clutches of Dying Hope
    [86514] = {86912, 86977, },
    -- Zor'lok's Fizzing Chestguard
    [87822] = {87823, 87824, },
    -- Grips of Terra Cotta
    [87825] = {87826, 87827, },
    -- Helm of the Shadowy Vanquisher
    [89234] = {89258, 89273, },
    -- Helm of the Shadowy Conqueror
    [89235] = {89259, 89274, },
    -- Helm of the Shadowy Protector
    [89236] = {89260, 89275, },
    -- Chest of the Shadowy Conqueror
    [89237] = {89250, 89265, },
    -- Chest of the Shadowy Protector
    [89238] = {89251, 89266, },
    -- Chest of the Shadowy Vanquisher
    [89239] = {89249, 89264, },
    -- Gauntlets of the Shadowy Conqueror
    [89240] = {89256, 89271, },
    -- Gauntlets of the Shadowy Protector
    [89241] = {89257, 89272, },
    -- Gauntlets of the Shadowy Vanquisher
    [89242] = {89255, 89270, },
    -- Leggings of the Shadowy Conqueror
    [89243] = {89253, 89268, },
    -- Leggings of the Shadowy Protector
    [89244] = {89254, 89269, },
    -- Leggings of the Shadowy Vanquisher
    [89245] = {89252, 89267, },
    -- Shoulders of the Shadowy Conqueror
    [89246] = {89262, 89277, },
    -- Shoulders of the Shadowy Protector
    [89247] = {89263, 89278, },
    -- Shoulders of the Shadowy Vanquisher
    [89248] = {89261, 89276, },
    -- Stonefang Chestguard
    [89766] = {89929, 89964, },
    -- Ruby-Linked Girdle
    [89767] = {89930, 89965, },
    -- Claws of Amethyst
    [89768] = {89931, 89966, },
    -- Feng's Seal of Binding
    [89802] = {89932, 89967, },
    -- Feng's Ring of Dreams
    [89803] = {89933, 89968, },
    -- Bonded Soul Bracers
    [89817] = {89934, 89969, },
    -- Bracers of Violent Meditation
    [89818] = {89935, 89970, },
    -- Mindshard Drape
    [89819] = {89936, 89971, },
    -- Dreadeye Gaze
    [89820] = {89940, 89975, },
    -- Crown of Keening Stars
    [89821] = {89939, 89974, },
    -- Galaxyfire Girdle
    [89822] = {89938, 89973, },
    -- Chestguard of Eternal Vigilance
    [89823] = {89941, 89976, },
    -- Band of Bursting Novas
    [89824] = {89937, 89972, },
    -- Enameled Grips of Solemnity
    [89825] = {89942, 89977, },
    -- Warbelt of Sealed Pods
    [89826] = {89919, 89954, },
    -- Pheromone-Coated Choker
    [89827] = {89917, 89952, },
    -- Pauldrons of the Broken Blade
    [89828] = {89921, 89956, },
    -- Scent-Soaked Sandals
    [89829] = {89918, 89953, },
    -- Sword Dancer's Leggings
    [89830] = {89920, 89955, },
    -- Hood of Stilled Winds
    [89831] = {89922, 89957, },
    -- Garalon's Graven Carapace
    [89832] = {89923, 89958, },
    -- Shoulders of Foaming Fluids
    [89833] = {89924, 89959, },
    -- Vestments of Steaming Ichor
    [89834] = {89925, 89960, },
    -- Hood of Dark Dreams
    [89835] = {89927, 89962, },
    -- Shadow Heart Spaulders
    [89836] = {89926, 89961, },
    -- Legplates of Regal Reinforcement
    [89837] = {89928, 89963, },
    -- Shadowgrip Girdle
    [89839] = {89951, 89986, },
    -- Gauntlets of the Shadow's Caress
    [89842] = {89945, 89980, },
    -- Grasps of Serpentine Might
    [89843] = {89946, 89981, },
    -- Shoulderpads of Twisted Fate
    [89883] = {89947, 89982, },
    -- Fear-Blackened Leggings
    [89884] = {89948, 89983, },
    -- Wrap of Instant Petrification
    [89886] = {89950, 89985, },
    -- Robes of Pinioned Eyes
    [89887] = {89949, 89984, },
    -- Kaz'tik's Stormseizer Gauntlets
    [90738] = {90739, 90740, },
    -- Breastplate of the All-Consuming Maw
    [95225] = {95825, 96569, },
    -- Gauntlets of the All-Consuming Maw
    [95226] = {95826, 96570, },
    -- Helmet of the All-Consuming Maw
    [95227] = {95827, 96571, },
    -- Greaves of the All-Consuming Maw
    [95228] = {95828, 96572, },
    -- Pauldrons of the All-Consuming Maw
    [95229] = {95829, 96573, },
    -- Chestguard of the All-Consuming Maw
    [95230] = {95830, 96574, },
    -- Handguards of the All-Consuming Maw
    [95231] = {95831, 96575, },
    -- Faceguard of the All-Consuming Maw
    [95232] = {95832, 96576, },
    -- Legguards of the All-Consuming Maw
    [95233] = {95833, 96577, },
    -- Shoulderguards of the All-Consuming Maw
    [95234] = {95834, 96578, },
    -- Raiment of the Haunted Forest
    [95235] = {95835, 96579, },
    -- Grips of the Haunted Forest
    [95236] = {95836, 96580, },
    -- Headpiece of the Haunted Forest
    [95237] = {95837, 96581, },
    -- Legguards of the Haunted Forest
    [95238] = {95838, 96582, },
    -- Spaulders of the Haunted Forest
    [95239] = {95839, 96583, },
    -- Handwraps of the Haunted Forest
    [95240] = {95840, 96584, },
    -- Helm of the Haunted Forest
    [95241] = {95841, 96585, },
    -- Legwraps of the Haunted Forest
    [95242] = {95842, 96586, },
    -- Robes of the Haunted Forest
    [95243] = {95843, 96587, },
    -- Mantle of the Haunted Forest
    [95244] = {95844, 96588, },
    -- Gloves of the Haunted Forest
    [95245] = {95845, 96589, },
    -- Cover of the Haunted Forest
    [95246] = {95846, 96590, },
    -- Leggings of the Haunted Forest
    [95247] = {95847, 96591, },
    -- Vestment of the Haunted Forest
    [95248] = {95848, 96592, },
    -- Shoulderwraps of the Haunted Forest
    [95249] = {95849, 96593, },
    -- Tunic of the Haunted Forest
    [95250] = {95850, 96594, },
    -- Handguards of the Haunted Forest
    [95251] = {95851, 96595, },
    -- Headguard of the Haunted Forest
    [95252] = {95852, 96596, },
    -- Breeches of the Haunted Forest
    [95253] = {95853, 96597, },
    -- Shoulderguards of the Haunted Forest
    [95254] = {95854, 96598, },
    -- Saurok Stalker's Tunic
    [95255] = {95882, 96626, },
    -- Saurok Stalker's Gloves
    [95256] = {95883, 96627, },
    -- Saurok Stalker's Headguard
    [95257] = {95884, 96628, },
    -- Saurok Stalker's Legguards
    [95258] = {95885, 96629, },
    -- Saurok Stalker's Spaulders
    [95259] = {95886, 96630, },
    -- Gloves of the Chromatic Hydra
    [95260] = {95890, 96634, },
    -- Hood of the Chromatic Hydra
    [95261] = {95891, 96635, },
    -- Leggings of the Chromatic Hydra
    [95262] = {95892, 96636, },
    -- Robes of the Chromatic Hydra
    [95263] = {95893, 96637, },
    -- Mantle of the Chromatic Hydra
    [95264] = {95894, 96638, },
    -- Fire-Charm Tunic
    [95265] = {95895, 96639, },
    -- Fire-Charm Grips
    [95266] = {95896, 96640, },
    -- Fire-Charm Headpiece
    [95267] = {95897, 96641, },
    -- Fire-Charm Leggings
    [95268] = {95898, 96642, },
    -- Fire-Charm Spaulders
    [95269] = {95899, 96643, },
    -- Fire-Charm Handwraps
    [95270] = {95900, 96644, },
    -- Fire-Charm Helm
    [95271] = {95901, 96645, },
    -- Fire-Charm Legwraps
    [95272] = {95902, 96646, },
    -- Fire-Charm Vest
    [95273] = {95903, 96647, },
    -- Fire-Charm Mantle
    [95274] = {95904, 96648, },
    -- Fire-Charm Chestguard
    [95275] = {95905, 96649, },
    -- Fire-Charm Gauntlets
    [95276] = {95906, 96650, },
    -- Fire-Charm Crown
    [95277] = {95907, 96651, },
    -- Fire-Charm Legguards
    [95278] = {95908, 96652, },
    -- Fire-Charm Shoulderguards
    [95279] = {95909, 96653, },
    -- Lightning Emperor's Battleplate
    [95280] = {95910, 96654, },
    -- Lightning Emperor's Gauntlets
    [95281] = {95911, 96655, },
    -- Lightning Emperor's Helmet
    [95282] = {95912, 96656, },
    -- Lightning Emperor's Legplates
    [95283] = {95913, 96657, },
    -- Lightning Emperor's Pauldrons
    [95284] = {95914, 96658, },
    -- Lightning Emperor's Breastplate
    [95285] = {95915, 96659, },
    -- Lightning Emperor's Gloves
    [95286] = {95916, 96660, },
    -- Lightning Emperor's Headguard
    [95287] = {95917, 96661, },
    -- Lightning Emperor's Greaves
    [95288] = {95918, 96662, },
    -- Lightning Emperor's Mantle
    [95289] = {95919, 96663, },
    -- Lightning Emperor's Chestguard
    [95290] = {95920, 96664, },
    -- Lightning Emperor's Handguards
    [95291] = {95921, 96665, },
    -- Lightning Emperor's Faceguard
    [95292] = {95922, 96666, },
    -- Lightning Emperor's Legguards
    [95293] = {95923, 96667, },
    -- Lightning Emperor's Shoulderguards
    [95294] = {95924, 96668, },
    -- Handwraps of the Exorcist
    [95295] = {95925, 96669, },
    -- Cowl of the Exorcist
    [95296] = {95926, 96670, },
    -- Legwraps of the Exorcist
    [95297] = {95927, 96671, },
    -- Robes of the Exorcist
    [95298] = {95928, 96672, },
    -- Mantle of the Exorcist
    [95299] = {95929, 96673, },
    -- Gloves of the Exorcist
    [95300] = {95930, 96674, },
    -- Hood of the Exorcist
    [95301] = {95931, 96675, },
    -- Leggings of the Exorcist
    [95302] = {95932, 96676, },
    -- Raiment of the Exorcist
    [95303] = {95933, 96677, },
    -- Shoulderguards of the Exorcist
    [95304] = {95934, 96678, },
    -- Nine-Tailed Tunic
    [95305] = {95935, 96679, },
    -- Nine-Tailed Gloves
    [95306] = {95936, 96680, },
    -- Nine-Tailed Helmet
    [95307] = {95937, 96681, },
    -- Nine-Tailed Legguards
    [95308] = {95938, 96682, },
    -- Nine-Tailed Spaulders
    [95309] = {95939, 96683, },
    -- Tunic of the Witch Doctor
    [95310] = {95940, 96684, },
    -- Handwraps of the Witch Doctor
    [95311] = {95941, 96685, },
    -- Faceguard of the Witch Doctor
    [95312] = {95942, 96686, },
    -- Legwraps of the Witch Doctor
    [95313] = {95943, 96687, },
    -- Mantle of the Witch Doctor
    [95314] = {95944, 96688, },
    -- Cuirass of the Witch Doctor
    [95315] = {95945, 96689, },
    -- Grips of the Witch Doctor
    [95316] = {95946, 96690, },
    -- Helmet of the Witch Doctor
    [95317] = {95947, 96691, },
    -- Legguards of the Witch Doctor
    [95318] = {95948, 96692, },
    -- Spaulders of the Witch Doctor
    [95319] = {95949, 96693, },
    -- Hauberk of the Witch Doctor
    [95320] = {95950, 96694, },
    -- Gloves of the Witch Doctor
    [95321] = {95951, 96695, },
    -- Headpiece of the Witch Doctor
    [95322] = {95952, 96696, },
    -- Kilt of the Witch Doctor
    [95323] = {95953, 96697, },
    -- Shoulderwraps of the Witch Doctor
    [95324] = {95954, 96698, },
    -- Gloves of the Thousandfold Hells
    [95325] = {95981, 96725, },
    -- Hood of the Thousandfold Hells
    [95326] = {95982, 96726, },
    -- Leggings of the Thousandfold Hells
    [95327] = {95983, 96727, },
    -- Robes of the Thousandfold Hells
    [95328] = {95984, 96728, },
    -- Mantle of the Thousandfold Hells
    [95329] = {95985, 96729, },
    -- Helmet of the Last Mogu
    [95330] = {95986, 96730, },
    -- Battleplate of the Last Mogu
    [95331] = {95987, 96731, },
    -- Gauntlets of the Last Mogu
    [95332] = {95988, 96732, },
    -- Legplates of the Last Mogu
    [95333] = {95989, 96733, },
    -- Pauldrons of the Last Mogu
    [95334] = {95990, 96734, },
    -- Chestguard of the Last Mogu
    [95335] = {95991, 96735, },
    -- Handguards of the Last Mogu
    [95336] = {95992, 96736, },
    -- Faceguard of the Last Mogu
    [95337] = {95993, 96737, },
    -- Legguards of the Last Mogu
    [95338] = {95994, 96738, },
    -- Shoulderguards of the Last Mogu
    [95339] = {95995, 96739, },
    -- Secessionist's Breastplate
    [97634] = {97777, 97782, },
    -- Secessionist's Boots
    [97640] = {97778, 97783, },
    -- Secessionist's Gauntlets
    [97650] = {97775, 97784, },
    -- Secessionist's Helm
    [97656] = {97776, 97785, },
    -- Secessionist's Legplates
    [97665] = {97780, 97786, },
    -- Secessionist's Spaulders
    [97676] = {97781, 97787, },
    -- Secessionist's Belt
    [97684] = {97779, 97788, },
    -- Crimson Schism Chestpiece
    [97688] = {97747, 97754, },
    -- Crimson Schism Pauldrons
    [97689] = {97752, 97759, },
    -- Crimson Schism Leggings
    [97690] = {97751, 97758, },
    -- Crimson Schism Cord
    [97691] = {97753, 97760, },
    -- Crimson Schism Headpiece
    [97692] = {97750, 97757, },
    -- Crimson Schism Mitts
    [97693] = {97749, 97756, },
    -- Crimson Schism Slippers
    [97696] = {97748, 97755, },
    -- Immaculate Pandaren Spear
    [98260] = {98266, 98315, },
    -- Immaculate Pandaren Staff
    [98261] = {98264, 98319, },
    -- Immaculate Pandaren Sword
    [98272] = {98273, 98316, },
    -- Immaculate Pandaren Knuckles
    [98277] = {98280, 98317, },
    -- Immaculate Pandaren Axe
    [98278] = {98279, 98318, },
    -- Prideful Gladiator's Gavel
    [102590] = {103030, 103404, },
    -- Prideful Gladiator's Longbow
    [102591] = {102990, 103350, },
    -- Prideful Gladiator's Pummeler
    [102592] = {102988, 103340, },
    -- Prideful Gladiator's Touch of Defeat
    [102593] = {103002, 103374, },
    -- Prideful Gladiator's Spellblade
    [102594] = {102999, 103365, },
    -- Prideful Gladiator's Staff
    [102595] = {103021, 103394, },
    -- Prideful Gladiator's Baton of Light
    [102596] = {103118, 103507, },
    -- Prideful Gladiator's Rifle
    [102597] = {103029, 103403, },
    -- Prideful Gladiator's Mageblade
    [102598] = {103117, 103504, },
    -- Prideful Gladiator's Greatsword
    [102599] = {102986, 103338, },
    -- Prideful Gladiator's Cleaver
    [102600] = {102987, 103339, },
    -- Prideful Gladiator's Battle Staff
    [102601] = {103000, 103366, },
    -- Prideful Gladiator's Shanker
    [102602] = {103114, 103501, },
    -- Prideful Gladiator's Ripper
    [102603] = {103115, 103502, },
    -- Prideful Gladiator's Hacker
    [102604] = {103119, 103508, },
    -- Prideful Gladiator's Slicer
    [102605] = {103121, 103510, },
    -- Prideful Gladiator's Pike
    [102606] = {103077, 103461, },
    -- Prideful Gladiator's Energy Staff
    [102607] = {103032, 103406, },
    -- Prideful Gladiator's Render
    [102608] = {103116, 103503, },
    -- Prideful Gladiator's Bonecracker
    [102609] = {103120, 103509, },
    -- Prideful Gladiator's Decapitator
    [102610] = {102984, 103336, },
    -- Prideful Gladiator's Bonegrinder
    [102611] = {102985, 103337, },
    -- Prideful Gladiator's Quickblade
    [102612] = {102989, 103341, },
    -- Prideful Gladiator's Heavy Crossbow
    [102613] = {103003, 103375, },
    -- Prideful Gladiator's Wyrmhide Robes
    [102614] = {103027, 103401, },
    -- Prideful Gladiator's Mooncloth Gloves
    [102615] = {103078, 103462, },
    -- Prideful Gladiator's Plate Gauntlets
    [102618] = {103129, 103526, },
    -- Prideful Gladiator's Plate Helm
    [102619] = {103130, 103527, },
    -- Prideful Gladiator's Satin Leggings
    [102621] = {103085, 103469, },
    -- Prideful Gladiator's Satin Robe
    [102622] = {103086, 103470, },
    -- Prideful Gladiator's Ironskin Spaulders
    [102626] = {103052, 103432, },
    -- Prideful Gladiator's Copperskin Gloves
    [102627] = {103054, 103434, },
    -- Prideful Gladiator's Copperskin Helm
    [102628] = {103055, 103435, },
    -- Prideful Gladiator's Linked Spaulders
    [102629] = {103107, 103494, },
    -- Prideful Gladiator's Scaled Gauntlets
    [102630] = {103060, 103440, },
    -- Prideful Gladiator's Ornamented Chestguard
    [102632] = {103068, 103450, },
    -- Prideful Gladiator's Wyrmhide Helm
    [102634] = {103025, 103399, },
    -- Prideful Gladiator's Ornamented Headcover
    [102635] = {103070, 103452, },
    -- Prideful Gladiator's Mail Spaulders
    [102637] = {103113, 103500, },
    -- Prideful Gladiator's Silk Trousers
    [102648] = {103044, 103423, },
    -- Prideful Gladiator's Dreadplate Gauntlets
    [102650] = {103005, 103377, },
    -- Prideful Gladiator's Dreadplate Legguards
    [102651] = {103007, 103379, },
    -- Prideful Gladiator's Dreadplate Shoulders
    [102652] = {103008, 103380, },
    -- Prideful Gladiator's Dragonhide Helm
    [102653] = {103010, 103382, },
    -- Prideful Gladiator's Dragonhide Legguards
    [102654] = {103011, 103383, },
    -- Prideful Gladiator's Ringmail Spaulders
    [102655] = {103102, 103489, },
    -- Prideful Gladiator's Ironskin Legguards
    [102656] = {103051, 103431, },
    -- Prideful Gladiator's Kodohide Gloves
    [102657] = {103016, 103389, },
    -- Prideful Gladiator's Kodohide Spaulders
    [102658] = {103020, 103393, },
    -- Prideful Gladiator's Felweave Raiment
    [102661] = {103126, 103523, },
    -- Prideful Gladiator's Leather Gloves
    [102663] = {103091, 103476, },
    -- Prideful Gladiator's Silk Cowl
    [102667] = {103043, 103422, },
    -- Prideful Gladiator's Chain Leggings
    [102670] = {103040, 103419, },
    -- Prideful Gladiator's Satin Mantle
    [102671] = {103087, 103471, },
    -- Prideful Gladiator's Silk Amice
    [102673] = {103046, 103425, },
    -- Prideful Gladiator's Ironskin Gloves
    [102675] = {103049, 103429, },
    -- Prideful Gladiator's Dreadplate Chestpiece
    [102676] = {103004, 103376, },
    -- Prideful Gladiator's Mooncloth Robe
    [102681] = {103081, 103465, },
    -- Prideful Gladiator's Felweave Amice
    [102682] = {103127, 103524, },
    -- Prideful Gladiator's Plate Shoulders
    [102685] = {103132, 103529, },
    -- Prideful Gladiator's Chain Armor
    [102689] = {103037, 103416, },
    -- Prideful Gladiator's Chain Helm
    [102690] = {103039, 103418, },
    -- Prideful Gladiator's Mail Gauntlets
    [102692] = {103110, 103497, },
    -- Prideful Gladiator's Mail Helm
    [102693] = {103111, 103498, },
    -- Prideful Gladiator's Wyrmhide Gloves
    [102696] = {103024, 103398, },
    -- Prideful Gladiator's Ornamented Spaulders
    [102697] = {103072, 103454, },
    -- Prideful Gladiator's Wyrmhide Spaulders
    [102700] = {103028, 103402, },
    -- Prideful Gladiator's Mooncloth Helm
    [102703] = {103079, 103463, },
    -- Prideful Gladiator's Mooncloth Leggings
    [102704] = {103080, 103464, },
    -- Prideful Gladiator's Satin Gloves
    [102707] = {103083, 103467, },
    -- Prideful Gladiator's Leather Helm
    [102710] = {103092, 103477, },
    -- Prideful Gladiator's Ironskin Helm
    [102712] = {103050, 103430, },
    -- Prideful Gladiator's Dreadplate Helm
    [102713] = {103006, 103378, },
    -- Prideful Gladiator's Linked Helm
    [102714] = {103105, 103492, },
    -- Prideful Gladiator's Silk Robe
    [102715] = {103045, 103424, },
    -- Prideful Gladiator's Ringmail Armor
    [102717] = {103098, 103485, },
    -- Prideful Gladiator's Ringmail Helm
    [102718] = {103100, 103487, },
    -- Prideful Gladiator's Ringmail Leggings
    [102719] = {103101, 103488, },
    -- Prideful Gladiator's Ironskin Tunic
    [102720] = {103053, 103433, },
    -- Prideful Gladiator's Kodohide Robes
    [102721] = {103019, 103392, },
    -- Prideful Gladiator's Ornamented Gloves
    [102722] = {103069, 103451, },
    -- Prideful Gladiator's Felweave Handguards
    [102725] = {103123, 103520, },
    -- Prideful Gladiator's Felweave Cowl
    [102726] = {103124, 103521, },
    -- Prideful Gladiator's Leather Tunic
    [102727] = {103090, 103475, },
    -- Prideful Gladiator's Plate Chestpiece
    [102728] = {103128, 103525, },
    -- Prideful Gladiator's Leather Legguards
    [102730] = {103093, 103478, },
    -- Prideful Gladiator's Leather Spaulders
    [102731] = {103094, 103479, },
    -- Prideful Gladiator's Plate Legguards
    [102732] = {103131, 103528, },
    -- Prideful Gladiator's Chain Spaulders
    [102734] = {103041, 103420, },
    -- Prideful Gladiator's Silk Handguards
    [102735] = {103042, 103421, },
    -- Prideful Gladiator's Chain Gauntlets
    [102737] = {103038, 103417, },
    -- Prideful Gladiator's Dragonhide Gloves
    [102739] = {103009, 103381, },
    -- Prideful Gladiator's Dragonhide Robes
    [102740] = {103012, 103384, },
    -- Prideful Gladiator's Dragonhide Spaulders
    [102741] = {103013, 103385, },
    -- Prideful Gladiator's Linked Gauntlets
    [102742] = {103104, 103491, },
    -- Prideful Gladiator's Mail Armor
    [102743] = {103109, 103496, },
    -- Prideful Gladiator's Scaled Shoulders
    [102744] = {103063, 103443, },
    -- Prideful Gladiator's Scaled Chestpiece
    [102747] = {103059, 103439, },
    -- Prideful Gladiator's Mooncloth Mantle
    [102750] = {103082, 103466, },
    -- Prideful Gladiator's Satin Hood
    [102751] = {103084, 103468, },
    -- Prideful Gladiator's Felweave Trousers
    [102755] = {103125, 103522, },
    -- Prideful Gladiator's Linked Armor
    [102759] = {103103, 103490, },
    -- Prideful Gladiator's Kodohide Legguards
    [102761] = {103018, 103391, },
    -- Prideful Gladiator's Copperskin Legguards
    [102762] = {103056, 103436, },
    -- Prideful Gladiator's Copperskin Tunic
    [102763] = {103058, 103438, },
    -- Prideful Gladiator's Wyrmhide Legguards
    [102767] = {103026, 103400, },
    -- Prideful Gladiator's Ornamented Legplates
    [102768] = {103071, 103453, },
    -- Prideful Gladiator's Ringmail Gauntlets
    [102774] = {103099, 103486, },
    -- Prideful Gladiator's Kodohide Helm
    [102776] = {103017, 103390, },
    -- Prideful Gladiator's Copperskin Spaulders
    [102777] = {103057, 103437, },
    -- Prideful Gladiator's Linked Leggings
    [102778] = {103106, 103493, },
    -- Prideful Gladiator's Scaled Helm
    [102779] = {103061, 103441, },
    -- Prideful Gladiator's Scaled Legguards
    [102780] = {103062, 103442, },
    -- Prideful Gladiator's Mail Leggings
    [102781] = {103112, 103499, },
    -- Prideful Gladiator's Redoubt
    [102782] = {103031, 103405, },
    -- Prideful Gladiator's Reprieve
    [102783] = {103001, 103373, },
    -- Prideful Gladiator's Shield Wall
    [102784] = {103122, 103519, },
    -- Prideful Gladiator's Barrier
    [102785] = {102998, 103364, },
    -- Prideful Gladiator's Endgame
    [102786] = {102997, 103363, },
    -- Hellscream's Warbow
    [104399] = {105670, 105683, },
    -- Hellscream's Razor
    [104400] = {105671, 105684, },
    -- Hellscream's Doomblade
    [104401] = {105678, 105691, },
    -- Hellscream's Warmace
    [104402] = {105675, 105688, },
    -- Hellscream's Pig Sticker
    [104403] = {105673, 105686, },
    -- Hellscream's Cleaver
    [104404] = {105672, 105685, },
    -- Hellscream's Decapitator
    [104405] = {105679, 105692, },
    -- Hellscream's War Staff
    [104406] = {105677, 105690, },
    -- Hellscream's Shield Wall
    [104407] = {105680, 105693, },
    -- Hellscream's Tome of Destruction
    [104408] = {105676, 105689, },
    -- Hellscream's Barrier
    [104409] = {105674, 105687, },
    -- Truthbearer
    [229749] = {229806, 231901, },
    -- Blood of the Lightbringer
    [232312] = {231452, 231841, },
    -- Commander's Seal of the Dawn
    [236363] = {236374, 236388, },
    -- Highlord's Seal of the Dawn
    [236364] = {236375, 236386, },
    -- Crusader's Seal of the Dawn
    [236376] = {236362, 236389, },
    -- Corrupted Ashbringer
    [239301] = {241081, 243010, },
    -- Shroud of Winter's Chill
    [35494] = {54804, 69768, 95428, },
    -- The Frost Lord's War Cloak
    [35495] = {54802, 69766, 95430, },
    -- Icebound Cloak
    [35496] = {54801, 69770, 95427, },
    -- Cloak of the Frigid Winds
    [35497] = {54805, 69769, 95425, },
    -- Frostscythe of Lord Ahune
    [35514] = {54806, 69771, 95426, },
    -- Medallion of the Alliance
    [37864] = {42123, 42124, 51377, },
    -- Medallion of the Horde
    [37865] = {42122, 42126, 51378, },
    -- Glinting Dreadstone
    [40131] = {40137, 40148, 40157, },
    -- Darkmoon Card: Greatness
    [42987] = {44253, 44254, 44255, },
    -- Arcanum of the Savage Gladiator
    [44701] = {50373, 50372, 44702, },
    -- Windrunner's Spaulders of Triumph
    [48270] = {48269, 48259, 48260, },
    -- Windrunner's Legguards of Triumph
    [48271] = {48268, 48258, 48261, },
    -- Windrunner's Headpiece of Triumph
    [48272] = {48267, 48257, 48262, },
    -- Windrunner's Handguards of Triumph
    [48273] = {48266, 48256, 48263, },
    -- Windrunner's Tunic of Triumph
    [48274] = {48265, 48255, 48264, },
    -- Vicious Gladiator's Medallion of Cruelty
    [60794] = {60801, 70602, 70603, },
    -- Vicious Gladiator's Medallion of Meditation
    [60799] = {60806, 70604, 70605, },
    -- Vicious Gladiator's Medallion of Tenacity
    [60800] = {60807, 70606, 70607, },
    -- Ruthless Gladiator's Medallion of Cruelty
    [70390] = {70393, 72410, 72411, },
    -- Ruthless Gladiator's Medallion of Meditation
    [70391] = {70394, 72414, 72415, },
    -- Ruthless Gladiator's Medallion of Tenacity
    [70392] = {70395, 72412, 72413, },
    -- Cataclysmic Gladiator's Sabatons of Alacrity
    [73521] = {73587, 73677, 73719, },
    -- Deep Earth Spaulders
    [77017] = {78743, 78838, 228258, },
    -- Malevolent Gladiator's Drape of Prowess
    [84803] = {91478, 97836, 97926, },
    -- Malevolent Gladiator's Treads of Alacrity
    [84815] = {85005, 91470, 97526, },
    -- Malevolent Gladiator's Band of Accuracy
    [84824] = {91492, 97844, 97934, },
    -- Malevolent Gladiator's Satin Gloves
    [84838] = {85017, 91672, 97522, },
    -- Malevolent Gladiator's Mooncloth Helm
    [84863] = {85039, 91664, 97515, },
    -- Malevolent Gladiator's Satin Leggings
    [84884] = {85053, 91676, 97525, },
    -- Malevolent Gladiator's Pendant of Cruelty
    [84887] = {91488, 97834, 97924, },
    -- Malevolent Gladiator's Satin Robe
    [84909] = {85073, 91678, 97520, },
    -- Malevolent Gladiator's Satin Mantle
    [84929] = {85074, 91680, 97517, },
    -- Malevolent Gladiator's Medallion of Meditation
    [84932] = {84933, 91686, 91687, },
    -- Malevolent Gladiator's Cord of Cruelty
    [84954] = {85092, 91462, 97523, },
    -- Malevolent Gladiator's Cuffs of Accuracy
    [84977] = {91474, 97838, 97928, },
    -- Mantle of the Burning Scroll
    [85374] = {86714, 87011, 98008, },
    -- Robes of the Burning Scroll
    [85375] = {86715, 87010, 98010, },
    -- Leggings of the Burning Scroll
    [85376] = {86716, 87009, 98015, },
    -- Hood of the Burning Scroll
    [85377] = {86717, 87008, 98006, },
    -- Jade Dust Leggings
    [85978] = {86747, 87017, 97300, },
    -- Amulet of Seven Curses
    [85986] = {86754, 87028, 98029, },
    -- Imperial Ghostbinder's Robes
    [85990] = {86758, 87027, 98068, },
    -- Circuit of the Frail Soul
    [86038] = {86767, 87040, 97303, },
    -- Shadowsummoner Spaulders
    [86041] = {86770, 87038, 98066, },
    -- Jade Courtesan Figurine
    [86045] = {86774, 87081, 97305, },
    -- Orbital Belt
    [86139] = {86798, 87064, 98072, },
    -- Attenuating Bracers
    [86157] = {86815, 86948, 98011, },
    -- Gloves of Grasping Claws
    [86161] = {86819, 86947, 97298, },
    -- Drape of Gathering Clouds
    [86169] = {86827, 86961, 97293, },
    -- Twisting Wind Bracers
    [86170] = {86828, 86958, 98042, },
    -- Sandals of the Unbidden
    [86178] = {86836, 86969, 98016, },
    -- Darting Damselfly Cuffs
    [86192] = {86850, 86993, 97295, },
    -- Korven's Amber-Sealed Beetle
    [86205] = {86856, 86976, 97291, },
    -- Kri'tak, Imperial Scepter of the Swarm
    [86227] = {86865, 86990, 97296, },
    -- Belt of Embodied Terror
    [86326] = {86884, 87161, 97299, },
    -- Dreadwoven Leggings of Failure
    [86389] = {86908, 87174, 98046, },
    -- Fan of Fiery Winds
    [89424] = {89425, 89426, 97297, },
    -- Tyrannical Gladiator's Badge of Conquest
    [91099] = {94373, 99772, 100043, },
    -- Tyrannical Gladiator's Cape of Cruelty
    [91100] = {94421, 99773, 100091, },
    -- Tyrannical Gladiator's Cape of Prowess
    [91101] = {94355, 99774, 100025, },
    -- Tyrannical Gladiator's Necklace of Proficiency
    [91102] = {94394, 99775, 100064, },
    -- Tyrannical Gladiator's Necklace of Prowess
    [91103] = {94395, 99776, 100065, },
    -- Tyrannical Gladiator's Insignia of Conquest
    [91104] = {94356, 99777, 100026, },
    -- Tyrannical Gladiator's Ring of Cruelty
    [91105] = {94357, 99778, 100027, },
    -- Tyrannical Gladiator's Ring of Accuracy
    [91106] = {94399, 99779, 100069, },
    -- Tyrannical Gladiator's Cuffs of Accuracy
    [91121] = {94403, 99787, 100073, },
    -- Tyrannical Gladiator's Cuffs of Prowess
    [91122] = {94449, 99788, 100119, },
    -- Tyrannical Gladiator's Cuffs of Meditation
    [91123] = {94380, 99789, 100050, },
    -- Tyrannical Gladiator's Drape of Cruelty
    [91124] = {94383, 99790, 100053, },
    -- Tyrannical Gladiator's Drape of Prowess
    [91125] = {94488, 99791, 100158, },
    -- Tyrannical Gladiator's Drape of Meditation
    [91126] = {94472, 99792, 100142, },
    -- Tyrannical Gladiator's Pendant of Cruelty
    [91135] = {94489, 99797, 100159, },
    -- Tyrannical Gladiator's Pendant of Alacrity
    [91136] = {94473, 99798, 100143, },
    -- Tyrannical Gladiator's Pendant of Meditation
    [91137] = {94452, 99799, 100122, },
    -- Tyrannical Gladiator's Band of Cruelty
    [91138] = {94390, 99800, 100060, },
    -- Tyrannical Gladiator's Band of Accuracy
    [91139] = {94363, 99801, 100033, },
    -- Tyrannical Gladiator's Band of Meditation
    [91140] = {94474, 99802, 100144, },
    -- Tyrannical Gladiator's Bindings of Meditation
    [91171] = {94407, 99818, 100077, },
    -- Tyrannical Gladiator's Bindings of Prowess
    [91188] = {94439, 99827, 100109, },
    -- Tyrannical Gladiator's Emblem of Cruelty
    [91209] = {94396, 99838, 100066, },
    -- Tyrannical Gladiator's Emblem of Tenacity
    [91210] = {94422, 99839, 100092, },
    -- Tyrannical Gladiator's Emblem of Meditation
    [91211] = {94329, 99840, 99990, },
    -- Tyrannical Gladiator's Wristguards of Alacrity
    [91220] = {94404, 99845, 100074, },
    -- Tyrannical Gladiator's Wristguards of Accuracy
    [91221] = {94469, 99846, 100139, },
    -- Tyrannical Gladiator's Armwraps of Accuracy
    [91246] = {94427, 99859, 100097, },
    -- Tyrannical Gladiator's Bracers of Prowess
    [91285] = {94411, 99879, 100081, },
    -- Tyrannical Gladiator's Bracers of Meditation
    [91286] = {94481, 99880, 100151, },
    -- Tyrannical Gladiator's Armplates of Proficiency
    [91305] = {94418, 99890, 100088, },
    -- Tyrannical Gladiator's Armplates of Alacrity
    [91306] = {94487, 99891, 100157, },
    -- Tyrannical Gladiator's Armwraps of Alacrity
    [91339] = {94470, 99905, 100140, },
    -- Tyrannical Gladiator's Armbands of Prowess
    [91356] = {94379, 99914, 100049, },
    -- Tyrannical Gladiator's Armbands of Meditation
    [91357] = {94337, 99915, 100004, },
    -- Tyrannical Gladiator's Badge of Dominance
    [91400] = {94346, 99937, 100016, },
    -- Tyrannical Gladiator's Insignia of Dominance
    [91401] = {94482, 99938, 100152, },
    -- Tyrannical Gladiator's Badge of Victory
    [91410] = {94349, 99943, 100019, },
    -- Tyrannical Gladiator's Cloak of Alacrity
    [91411] = {94485, 99944, 100155, },
    -- Tyrannical Gladiator's Cloak of Prowess
    [91412] = {94486, 99945, 100156, },
    -- Tyrannical Gladiator's Choker of Proficiency
    [91413] = {94465, 99946, 100135, },
    -- Tyrannical Gladiator's Choker of Accuracy
    [91414] = {94354, 99947, 100024, },
    -- Tyrannical Gladiator's Insignia of Victory
    [91415] = {94415, 99948, 100085, },
    -- Tyrannical Gladiator's Signet of Cruelty
    [91416] = {94417, 99949, 100087, },
    -- Tyrannical Gladiator's Signet of Accuracy
    [91417] = {94462, 99950, 100132, },
    -- Tyrannical Gladiator's Medallion of Meditation
    [94338] = {94388, 100006, 100058, },
    -- Tyrannical Gladiator's Medallion of Tenacity
    [94361] = {94387, 100031, 100057, },
    -- Tyrannical Gladiator's Medallion of Cruelty
    [94386] = {94454, 100056, 100124, },
    -- Wu-Lai, Bladed Fan of the Consorts
    [95791] = {96163, 96535, 96907, },
    -- Spaulders of Celestial Harmony
    [98977] = {99105, 99343, 99663, },
    -- Shoulderguards of the Shattered Vale
    [98978] = {99166, 99423, 99664, },
    -- Headguard of Winged Triumph
    [98979] = {99135, 99376, 99665, },
    -- Greaves of Winged Triumph
    [98980] = {99124, 99377, 99666, },
    -- Breeches of the Shattered Vale
    [98981] = {99165, 99422, 99610, },
    -- Gloves of Winged Triumph
    [98982] = {99134, 99375, 99648, },
    -- Helmet of Celestial Harmony
    [98983] = {99103, 99341, 99649, },
    -- Legguards of Celestial Harmony
    [98984] = {99104, 99342, 99650, },
    -- Helmet of Winged Triumph
    [98985] = {99138, 99379, 99651, },
    -- Legplates of Winged Triumph
    [98986] = {99139, 99372, 99661, },
    -- Pauldrons of Winged Triumph
    [98987] = {99132, 99373, 99662, },
    -- Handwraps of Celestial Harmony
    [98988] = {99108, 99352, 99611, },
    -- Faceguard of Celestial Harmony
    [98989] = {99109, 99353, 99612, },
    -- Legwraps of Celestial Harmony
    [98990] = {99099, 99354, 99613, },
    -- Mantle of Celestial Harmony
    [98991] = {99100, 99346, 99614, },
    -- Cuirass of Celestial Harmony
    [98992] = {99101, 99347, 99615, },
    -- Grips of Celestial Harmony
    [98993] = {99102, 99340, 99616, },
    -- Gloves of the Shattered Vale
    [98994] = {99174, 99432, 99617, },
    -- Cover of the Shattered Vale
    [98995] = {99175, 99433, 99618, },
    -- Leggings of the Shattered Vale
    [98996] = {99176, 99434, 99619, },
    -- Vestment of the Shattered Vale
    [98997] = {99177, 99427, 99620, },
    -- Shoulderwraps of the Shattered Vale
    [98998] = {99169, 99428, 99621, },
    -- Tunic of the Shattered Vale
    [98999] = {99170, 99419, 99622, },
    -- Handguards of the Shattered Vale
    [99000] = {99163, 99420, 99623, },
    -- Headguard of the Shattered Vale
    [99001] = {99164, 99421, 99624, },
    -- Gauntlets of Winged Triumph
    [99002] = {99137, 99380, 99625, },
    -- Breastplate of Winged Triumph
    [99003] = {99133, 99374, 99626, },
    -- Raiment of the Ternion Glory
    [99004] = {99110, 99362, 99627, },
    -- Shoulderguards of the Ternion Glory
    [99005] = {99111, 99363, 99628, },
    -- Tunic of the Barbed Assassin
    [99006] = {99112, 99356, 99629, },
    -- Gloves of the Barbed Assassin
    [99007] = {99113, 99355, 99630, },
    -- Helmet of the Barbed Assassin
    [99008] = {99114, 99348, 99631, },
    -- Legguards of the Barbed Assassin
    [99009] = {99115, 99349, 99634, },
    -- Spaulders of the Barbed Assassin
    [99010] = {99116, 99350, 99635, },
    -- Tunic of Celestial Harmony
    [99011] = {99107, 99351, 99636, },
    -- Handwraps of the Shattered Vale
    [99012] = {99185, 99435, 99637, },
    -- Helm of the Shattered Vale
    [99013] = {99178, 99436, 99638, },
    -- Legwraps of the Shattered Vale
    [99014] = {99171, 99429, 99581, },
    -- Robes of the Shattered Vale
    [99015] = {99172, 99430, 99582, },
    -- Mantle of the Shattered Vale
    [99016] = {99173, 99431, 99583, },
    -- Robes of the Ternion Glory
    [99017] = {99119, 99357, 99584, },
    -- Mantle of the Ternion Glory
    [99018] = {99120, 99358, 99585, },
    -- Gloves of the Ternion Glory
    [99019] = {99121, 99359, 99586, },
    -- Hood of the Ternion Glory
    [99020] = {99122, 99360, 99587, },
    -- Leggings of the Ternion Glory
    [99021] = {99123, 99361, 99588, },
    -- Spaulders of the Shattered Vale
    [99022] = {99184, 99322, 99589, },
    -- Handwraps of the Ternion Glory
    [99023] = {99131, 99365, 99590, },
    -- Cowl of the Ternion Glory
    [99024] = {99117, 99366, 99591, },
    -- Legwraps of the Ternion Glory
    [99025] = {99118, 99367, 99592, },
    -- Legguards of Winged Triumph
    [99026] = {99129, 99371, 99593, },
    -- Shoulderguards of Winged Triumph
    [99027] = {99130, 99364, 99594, },
    -- Handguards of Winged Triumph
    [99028] = {99127, 99369, 99595, },
    -- Faceguard of Winged Triumph
    [99029] = {99128, 99370, 99596, },
    -- Shoulderguards of the Prehistoric Marauder
    [99030] = {99196, 99407, 99597, },
    -- Chestguard of Winged Triumph
    [99031] = {99126, 99368, 99598, },
    -- Faceguard of the Prehistoric Marauder
    [99032] = {99203, 99409, 99557, },
    -- Legguards of the Prehistoric Marauder
    [99033] = {99195, 99410, 99558, },
    -- Gauntlets of the Prehistoric Marauder
    [99034] = {99198, 99412, 99559, },
    -- Legplates of the Prehistoric Marauder
    [99035] = {99199, 99413, 99560, },
    -- Pauldrons of the Prehistoric Marauder
    [99036] = {99200, 99414, 99561, },
    -- Chestguard of the Prehistoric Marauder
    [99037] = {99201, 99415, 99562, },
    -- Handguards of the Prehistoric Marauder
    [99038] = {99202, 99408, 99563, },
    -- Legguards of Cyclopean Dread
    [99039] = {99191, 99324, 99564, },
    -- Shoulderguards of Cyclopean Dread
    [99040] = {99179, 99325, 99652, },
    -- Raiment of the Shattered Vale
    [99041] = {99180, 99326, 99632, },
    -- Grips of the Shattered Vale
    [99042] = {99181, 99327, 99633, },
    -- Headpiece of the Shattered Vale
    [99043] = {99182, 99328, 99599, },
    -- Legguards of the Shattered Vale
    [99044] = {99183, 99329, 99600, },
    -- Mantle of the Horned Nightmare
    [99045] = {99205, 99417, 99601, },
    -- Helmet of the Prehistoric Marauder
    [99046] = {99206, 99418, 99602, },
    -- Battleplate of the Prehistoric Marauder
    [99047] = {99197, 99411, 99603, },
    -- Handguards of Cyclopean Dread
    [99048] = {99189, 99331, 99604, },
    -- Faceguard of Cyclopean Dread
    [99049] = {99190, 99323, 99605, },
    -- Legguards of Seven Sacred Seals
    [99050] = {99143, 99385, 99606, },
    -- Shoulderguards of Seven Sacred Seals
    [99051] = {99144, 99386, 99565, },
    -- Battleplate of Winged Triumph
    [99052] = {99136, 99387, 99566, },
    -- Gloves of the Horned Nightmare
    [99053] = {99096, 99424, 99567, },
    -- Hood of the Horned Nightmare
    [99054] = {99097, 99425, 99568, },
    -- Leggings of the Horned Nightmare
    [99055] = {99098, 99426, 99569, },
    -- Robes of the Horned Nightmare
    [99056] = {99204, 99416, 99570, },
    -- Helmet of Cyclopean Dread
    [99057] = {99194, 99337, 99571, },
    -- Greaves of Cyclopean Dread
    [99058] = {99186, 99338, 99572, },
    -- Pauldrons of Cyclopean Dread
    [99059] = {99187, 99339, 99639, },
    -- Chestguard of Cyclopean Dread
    [99060] = {99188, 99330, 99640, },
    -- Vest of Seven Sacred Seals
    [99061] = {99150, 99391, 99641, },
    -- Mantle of Seven Sacred Seals
    [99062] = {99151, 99381, 99642, },
    -- Chestguard of Seven Sacred Seals
    [99063] = {99140, 99382, 99643, },
    -- Gauntlets of Seven Sacred Seals
    [99064] = {99141, 99383, 99644, },
    -- Crown of Seven Sacred Seals
    [99065] = {99142, 99384, 99607, },
    -- Breastplate of Cyclopean Dread
    [99066] = {99192, 99335, 99608, },
    -- Gauntlets of Cyclopean Dread
    [99067] = {99193, 99336, 99609, },
    -- Handwraps of Seven Sacred Seals
    [99068] = {99147, 99388, 99552, },
    -- Helm of Seven Sacred Seals
    [99069] = {99148, 99389, 99553, },
    -- Legwraps of Seven Sacred Seals
    [99070] = {99149, 99390, 99554, },
    -- Tunic of Seven Sacred Seals
    [99071] = {99154, 99396, 99555, },
    -- Grips of Seven Sacred Seals
    [99072] = {99155, 99392, 99556, },
    -- Headpiece of Seven Sacred Seals
    [99073] = {99156, 99393, 99653, },
    -- Leggings of Seven Sacred Seals
    [99074] = {99145, 99394, 99654, },
    -- Spaulders of Seven Sacred Seals
    [99075] = {99146, 99395, 99655, },
    -- Mantle of Winged Triumph
    [99076] = {99125, 99378, 99656, },
    -- Chronomancer Leggings
    [99077] = {99162, 99399, 99657, },
    -- Chronomancer Robes
    [99078] = {99152, 99400, 99658, },
    -- Chronomancer Mantle
    [99079] = {99153, 99401, 99659, },
    -- Headguard of the Unblinking Vigil
    [99080] = {99157, 99402, 99660, },
    -- Legguards of the Unblinking Vigil
    [99081] = {99158, 99403, 99573, },
    -- Spaulders of the Unblinking Vigil
    [99082] = {99159, 99404, 99574, },
    -- Chronomancer Gloves
    [99083] = {99160, 99397, 99575, },
    -- Chronomancer Hood
    [99084] = {99161, 99398, 99576, },
    -- Tunic of the Unblinking Vigil
    [99085] = {99167, 99405, 99577, },
    -- Gloves of the Unblinking Vigil
    [99086] = {99168, 99406, 99578, },
    -- Hauberk of Celestial Harmony
    [99087] = {99106, 99344, 99579, },
    -- Gloves of Celestial Harmony
    [99088] = {99092, 99345, 99580, },
    -- Headpiece of Celestial Harmony
    [99089] = {99093, 99332, 99645, },
    -- Leggings of Celestial Harmony
    [99090] = {99094, 99333, 99646, },
    -- Shoulderwraps of Celestial Harmony
    [99091] = {99095, 99334, 99647, },
    -- Grievous Gladiator's Badge of Conquest
    [100195] = {100603, 102856, 103145, },
    -- Grievous Gladiator's Cape of Cruelty
    [100196] = {100651, 102902, 103146, },
    -- Grievous Gladiator's Cape of Prowess
    [100197] = {100585, 102839, 103147, },
    -- Grievous Gladiator's Necklace of Proficiency
    [100198] = {100624, 102875, 103148, },
    -- Grievous Gladiator's Necklace of Prowess
    [100199] = {100625, 102876, 103149, },
    -- Grievous Gladiator's Insignia of Conquest
    [100200] = {100586, 102840, 103150, },
    -- Grievous Gladiator's Ring of Cruelty
    [100201] = {100587, 102841, 103151, },
    -- Grievous Gladiator's Ring of Accuracy
    [100202] = {100629, 102880, 103152, },
    -- Grievous Gladiator's Cord of Cruelty
    [100205] = {100630, 102881, 103154, },
    -- Grievous Gladiator's Cord of Accuracy
    [100207] = {100606, 102859, 103155, },
    -- Grievous Gladiator's Cord of Meditation
    [100209] = {100655, 102906, 103156, },
    -- Grievous Gladiator's Treads of Cruelty
    [100211] = {100632, 102883, 103157, },
    -- Grievous Gladiator's Treads of Alacrity
    [100213] = {100563, 102817, 103158, },
    -- Grievous Gladiator's Treads of Meditation
    [100215] = {100698, 102949, 103159, },
    -- Grievous Gladiator's Cuffs of Accuracy
    [100217] = {100633, 102884, 103160, },
    -- Grievous Gladiator's Cuffs of Prowess
    [100218] = {100679, 102930, 103161, },
    -- Grievous Gladiator's Cuffs of Meditation
    [100219] = {100610, 102863, 103162, },
    -- Grievous Gladiator's Drape of Cruelty
    [100220] = {100613, 102866, 103163, },
    -- Grievous Gladiator's Drape of Prowess
    [100221] = {100718, 102969, 103164, },
    -- Grievous Gladiator's Drape of Meditation
    [100222] = {100702, 102953, 103165, },
    -- Grievous Gladiator's Pendant of Cruelty
    [100231] = {100719, 102970, 103170, },
    -- Grievous Gladiator's Pendant of Alacrity
    [100232] = {100703, 102954, 103171, },
    -- Grievous Gladiator's Pendant of Meditation
    [100233] = {100682, 102933, 103172, },
    -- Grievous Gladiator's Band of Cruelty
    [100234] = {100620, 102871, 103173, },
    -- Grievous Gladiator's Band of Accuracy
    [100235] = {100593, 102846, 103174, },
    -- Grievous Gladiator's Band of Meditation
    [100236] = {100704, 102955, 103175, },
    -- Grievous Gladiator's Belt of Meditation
    [100263] = {100721, 102972, 103189, },
    -- Grievous Gladiator's Bindings of Meditation
    [100267] = {100637, 102888, 103191, },
    -- Grievous Gladiator's Belt of Cruelty
    [100280] = {100640, 102891, 103198, },
    -- Grievous Gladiator's Bindings of Prowess
    [100284] = {100669, 102920, 103200, },
    -- Grievous Gladiator's Emblem of Cruelty
    [100305] = {100626, 102877, 103210, },
    -- Grievous Gladiator's Emblem of Tenacity
    [100306] = {100652, 102903, 103211, },
    -- Grievous Gladiator's Emblem of Meditation
    [100307] = {100559, 102813, 103212, },
    -- Grievous Gladiator's Links of Cruelty
    [100308] = {100560, 102814, 103213, },
    -- Grievous Gladiator's Links of Accuracy
    [100310] = {100588, 102842, 103214, },
    -- Grievous Gladiator's Sabatons of Cruelty
    [100312] = {100675, 102926, 103215, },
    -- Grievous Gladiator's Sabatons of Alacrity
    [100314] = {100589, 102843, 103216, },
    -- Grievous Gladiator's Wristguards of Alacrity
    [100316] = {100634, 102885, 103217, },
    -- Grievous Gladiator's Wristguards of Accuracy
    [100317] = {100699, 102950, 103218, },
    -- Grievous Gladiator's Waistband of Cruelty
    [100338] = {100590, 102844, 103229, },
    -- Grievous Gladiator's Boots of Alacrity
    [100340] = {100662, 102913, 103230, },
    -- Grievous Gladiator's Armwraps of Accuracy
    [100342] = {100657, 102908, 103231, },
    -- Grievous Gladiator's Clasp of Cruelty
    [100373] = {100710, 102961, 103247, },
    -- Grievous Gladiator's Clasp of Meditation
    [100375] = {100694, 102945, 103248, },
    -- Grievous Gladiator's Greaves of Alacrity
    [100377] = {100581, 102835, 103249, },
    -- Grievous Gladiator's Greaves of Meditation
    [100379] = {100582, 102836, 103250, },
    -- Grievous Gladiator's Bracers of Prowess
    [100381] = {100641, 102892, 103251, },
    -- Grievous Gladiator's Bracers of Meditation
    [100382] = {100711, 102962, 103252, },
    -- Grievous Gladiator's Girdle of Accuracy
    [100393] = {100583, 102837, 103258, },
    -- Grievous Gladiator's Girdle of Prowess
    [100395] = {100670, 102921, 103259, },
    -- Grievous Gladiator's Warboots of Cruelty
    [100397] = {100644, 102895, 103260, },
    -- Grievous Gladiator's Warboots of Alacrity
    [100399] = {100691, 102942, 103261, },
    -- Grievous Gladiator's Armplates of Proficiency
    [100401] = {100648, 102899, 103262, },
    -- Grievous Gladiator's Armplates of Alacrity
    [100402] = {100717, 102968, 103263, },
    -- Grievous Gladiator's Waistband of Accuracy
    [100425] = {100654, 102905, 103275, },
    -- Grievous Gladiator's Boots of Cruelty
    [100427] = {100604, 102857, 103276, },
    -- Grievous Gladiator's Armwraps of Alacrity
    [100429] = {100700, 102951, 103277, },
    -- Grievous Gladiator's Waistguard of Meditation
    [100440] = {100612, 102865, 103283, },
    -- Grievous Gladiator's Armbands of Prowess
    [100446] = {100609, 102862, 103286, },
    -- Grievous Gladiator's Armbands of Meditation
    [100447] = {100567, 102821, 103287, },
    -- Grievous Gladiator's Waistguard of Cruelty
    [100468] = {100623, 102874, 103298, },
    -- Grievous Gladiator's Badge of Dominance
    [100490] = {100576, 102830, 103308, },
    -- Grievous Gladiator's Insignia of Dominance
    [100491] = {100712, 102963, 103309, },
    -- Grievous Gladiator's Badge of Victory
    [100500] = {100579, 102833, 103314, },
    -- Grievous Gladiator's Cloak of Alacrity
    [100501] = {100715, 102966, 103315, },
    -- Grievous Gladiator's Cloak of Prowess
    [100502] = {100716, 102967, 103316, },
    -- Grievous Gladiator's Choker of Proficiency
    [100503] = {100695, 102946, 103317, },
    -- Grievous Gladiator's Choker of Accuracy
    [100504] = {100584, 102838, 103318, },
    -- Grievous Gladiator's Insignia of Victory
    [100505] = {100645, 102896, 103319, },
    -- Grievous Gladiator's Signet of Cruelty
    [100506] = {100647, 102898, 103320, },
    -- Grievous Gladiator's Signet of Accuracy
    [100507] = {100692, 102943, 103321, },
    -- Grievous Gladiator's Medallion of Meditation
    [100568] = {100618, 102822, 103335, },
    -- Grievous Gladiator's Medallion of Tenacity
    [100591] = {100617, 102869, 103333, },
    -- Grievous Gladiator's Medallion of Cruelty
    [100616] = {100684, 102935, 103334, },
    -- Prideful Gladiator's Footguards of Meditation
    [102623] = {102760, 103387, 103482, },
    -- Prideful Gladiator's Footguards of Alacrity
    [102631] = {102664, 103396, 103481, },
    -- Zoid's Molten Gauntlets
    [103734] = {105822, 105836, 105850, },
    -- Seebo's Sainted Touch
    [103753] = {105814, 105828, 105842, },
    -- Marco's Crackling Gloves
    [103764] = {105820, 105834, 105848, },
    -- Drape of the Omega
    [103770] = {105815, 105829, 105843, },
    -- Keengrip Arrowpullers
    [103781] = {105819, 105833, 105847, },
    -- Tusks of Mannoroth
    [103785] = {104646, 105393, 105642, },
    -- Gauntlets of Discarded Time
    [103791] = {105823, 105837, 105851, },
    -- Turtleshell Greatcloak
    [103800] = {105825, 105839, 105853, },
    -- Romy's Reliable Grips
    [103818] = {105821, 105835, 105849, },
    -- Siid's Silent Stranglers
    [103832] = {105817, 105831, 105845, },
    -- Aeth's Swiftcinder Cloak
    [103846] = {105824, 105838, 105852, },
    -- Kalaena's Arcane Handwraps
    [103854] = {105813, 105827, 105841, },
    -- Crimson Gauntlets of Death
    [103859] = {105818, 105832, 105846, },
    -- Cape of the Alpha
    [103935] = {105812, 105826, 105840, },
    -- Brave Niunai's Cloak
    [103960] = {105816, 105830, 105844, },
    -- Essence of the Cursed Protector
    [105857] = {105860, 105863, 105866, },
    -- Essence of the Cursed Conqueror
    [105858] = {105861, 105864, 105867, },
    -- Essence of the Cursed Vanquisher
    [105859] = {105862, 105865, 105868, },
    -- Warblade of the Hakkari
    [231309] = {230992, 231853, 231869, },
    -- Purified Tanzanite
    [30572] = {30586, 30589, 30600, 30603, },
    -- Brilliant Crimson Spinel
    [32195] = {32196, 32204, 35488, 35489, },
    -- Purified Dreadstone
    [40133] = {40134, 40151, 40170, 40175, },
    -- Malevolent Gladiator's Treads of Cruelty
    [84814] = {85004, 91468, 97842, 97932, },
    -- Malevolent Gladiator's Band of Cruelty
    [84823] = {91491, 97528, 97843, 97933, },
    -- Malevolent Gladiator's Silk Handguards
    [84837] = {85016, 91585, 97839, 97929, },
    -- Malevolent Gladiator's Silk Cowl
    [84855] = {85031, 91587, 97833, 97923, },
    -- Malevolent Gladiator's Endgame
    [84866] = {85114, 91480, 97847, 97945, },
    -- Malevolent Gladiator's Silk Trousers
    [84875] = {85062, 91589, 97841, 97931, },
    -- Malevolent Gladiator's Silk Robe
    [84904] = {85068, 91591, 97837, 97927, },
    -- Malevolent Gladiator's Silk Amice
    [84917] = {85085, 91593, 97835, 97925, },
    -- Malevolent Gladiator's Badge of Dominance
    [84940] = {91753, 97531, 97532, 97936, },
    -- Malevolent Gladiator's Medallion of Cruelty
    [84943] = {84944, 91682, 91683, 97533, },
    -- Malevolent Gladiator's Cord of Accuracy
    [84955] = {85093, 91464, 97840, 97930, },
    -- Malevolent Gladiator's Spellblade
    [84961] = {85127, 91484, 97846, 97944, },
    -- Gloves of the Burning Scroll
    [85378] = {86718, 87007, 98044, 98071, },
    -- Light of the Cosmos
    [86133] = {86792, 87065, 98019, 98050, },
    -- Fragment of Fear Made Flesh
    [86156] = {86814, 86949, 98018, 98074, },
    -- Stormwake Mistcloak
    [86182] = {86840, 86971, 98009, 98067, },
    -- Bracers of Defiled Earth
    [86230] = {86868, 87145, 90506, 90520, },
    -- Regail's Band of the Endless
    [86231] = {86869, 87144, 90503, 90517, },
    -- Deepwater Greatboots
    [86232] = {86870, 87146, 90507, 90521, },
    -- Shackle of Eversparks
    [86233] = {86871, 87147, 90508, 90522, },
    -- Kaolan's Withering Necklace
    [86234] = {86872, 87148, 90509, 90523, },
    -- Watersoul Signet
    [86315] = {86873, 87151, 90511, 90525, },
    -- Cuffs of the Corrupted Waters
    [86317] = {86875, 87149, 90510, 90524, },
    -- Casque of Expelled Corruption
    [86318] = {86876, 87155, 90516, 90530, },
    -- Lightning Prisoner's Boots
    [86319] = {86877, 87154, 90515, 90529, },
    -- Asani's Uncleansed Sandals
    [86320] = {86878, 87153, 90514, 90528, },
    -- Jin'ya, Orb of the Waterspeaker
    [86335] = {86893, 87170, 98043, 98070, },
    -- Essence of Terror
    [86388] = {86907, 87175, 98020, 98076, },
    -- Regail's Crackling Dagger
    [86390] = {86909, 87152, 90513, 90527, },
    -- Legguards of Failing Purification
    [89841] = {89943, 89978, 90504, 90518, },
    -- Waterborne Shoulderguards
    [89885] = {89944, 89979, 90505, 90519, },
    -- Tyrannical Gladiator's Decapitator
    [91087] = {91088, 94323, 99766, 99984, },
    -- Tyrannical Gladiator's Bonegrinder
    [91089] = {91090, 94324, 99767, 99985, },
    -- Tyrannical Gladiator's Greatsword
    [91091] = {91092, 94311, 99768, 99972, },
    -- Tyrannical Gladiator's Cleaver
    [91093] = {91094, 94312, 99769, 99973, },
    -- Tyrannical Gladiator's Pummeler
    [91095] = {91096, 94304, 99770, 99965, },
    -- Tyrannical Gladiator's Quickblade
    [91097] = {91098, 94325, 99771, 99986, },
    -- Tyrannical Gladiator's Longbow
    [91107] = {91108, 94303, 99780, 99964, },
    -- Tyrannical Gladiator's Cord of Cruelty
    [91109] = {91110, 94400, 99781, 100070, },
    -- Tyrannical Gladiator's Cord of Accuracy
    [91111] = {91112, 94376, 99782, 100046, },
    -- Tyrannical Gladiator's Cord of Meditation
    [91113] = {91114, 94425, 99783, 100095, },
    -- Tyrannical Gladiator's Treads of Cruelty
    [91115] = {91116, 94402, 99784, 100072, },
    -- Tyrannical Gladiator's Treads of Alacrity
    [91117] = {91118, 94333, 99785, 99994, },
    -- Tyrannical Gladiator's Treads of Meditation
    [91119] = {91120, 94468, 99786, 100138, },
    -- Tyrannical Gladiator's Endgame
    [91127] = {91128, 94502, 99793, 100172, },
    -- Tyrannical Gladiator's Barrier
    [91129] = {91130, 94501, 99794, 100171, },
    -- Tyrannical Gladiator's Spellblade
    [91131] = {91132, 94306, 99795, 99967, },
    -- Tyrannical Gladiator's Battle Staff
    [91133] = {91134, 94313, 99796, 99974, },
    -- Tyrannical Gladiator's Reprieve
    [91141] = {91142, 94499, 99803, 100169, },
    -- Tyrannical Gladiator's Touch of Defeat
    [91143] = {91144, 94305, 99804, 99966, },
    -- Tyrannical Gladiator's Heavy Crossbow
    [91145] = {91146, 94326, 99805, 99987, },
    -- Tyrannical Gladiator's Dreadplate Chestpiece
    [91147] = {91148, 94392, 99806, 100062, },
    -- Tyrannical Gladiator's Dreadplate Gauntlets
    [91149] = {91150, 94364, 99807, 100034, },
    -- Tyrannical Gladiator's Dreadplate Helm
    [91151] = {91152, 94429, 99808, 100099, },
    -- Tyrannical Gladiator's Dreadplate Legguards
    [91153] = {91154, 94365, 99809, 100035, },
    -- Tyrannical Gladiator's Dreadplate Shoulders
    [91155] = {91156, 94366, 99810, 100036, },
    -- Tyrannical Gladiator's Dragonhide Gloves
    [91157] = {91158, 94455, 99811, 100125, },
    -- Tyrannical Gladiator's Dragonhide Helm
    [91159] = {91160, 94367, 99812, 100037, },
    -- Tyrannical Gladiator's Dragonhide Legguards
    [91161] = {91162, 94368, 99813, 100038, },
    -- Tyrannical Gladiator's Dragonhide Robes
    [91163] = {91164, 94456, 99814, 100126, },
    -- Tyrannical Gladiator's Dragonhide Spaulders
    [91165] = {91166, 94457, 99815, 100127, },
    -- Tyrannical Gladiator's Belt of Meditation
    [91167] = {91168, 94491, 99816, 100161, },
    -- Tyrannical Gladiator's Kodohide Gloves
    [91172] = {91173, 94371, 99819, 100041, },
    -- Tyrannical Gladiator's Kodohide Helm
    [91174] = {91175, 94492, 99820, 100162, },
    -- Tyrannical Gladiator's Kodohide Legguards
    [91176] = {91177, 94477, 99821, 100147, },
    -- Tyrannical Gladiator's Kodohide Robes
    [91178] = {91179, 94437, 99822, 100107, },
    -- Tyrannical Gladiator's Kodohide Spaulders
    [91180] = {91181, 94372, 99823, 100042, },
    -- Tyrannical Gladiator's Staff
    [91182] = {91183, 94307, 99824, 99968, },
    -- Tyrannical Gladiator's Belt of Cruelty
    [91184] = {91185, 94410, 99825, 100080, },
    -- Tyrannical Gladiator's Wyrmhide Gloves
    [91189] = {91190, 94412, 99828, 100082, },
    -- Tyrannical Gladiator's Wyrmhide Helm
    [91191] = {91192, 94347, 99829, 100017, },
    -- Tyrannical Gladiator's Wyrmhide Legguards
    [91193] = {91194, 94483, 99830, 100153, },
    -- Tyrannical Gladiator's Wyrmhide Robes
    [91195] = {91196, 94327, 99831, 99988, },
    -- Tyrannical Gladiator's Wyrmhide Spaulders
    [91197] = {91198, 94416, 99832, 100086, },
    -- Tyrannical Gladiator's Shiv
    [91199] = {91200, 94301, 99833, 99962, },
    -- Tyrannical Gladiator's Rifle
    [91201] = {91202, 94309, 99834, 99970, },
    -- Tyrannical Gladiator's Gavel
    [91203] = {91204, 94302, 99835, 99963, },
    -- Tyrannical Gladiator's Redoubt
    [91205] = {91206, 94498, 99836, 100168, },
    -- Tyrannical Gladiator's Energy Staff
    [91207] = {91208, 94320, 99837, 99981, },
    -- Tyrannical Gladiator's Links of Cruelty
    [91212] = {91213, 94330, 99841, 99991, },
    -- Tyrannical Gladiator's Links of Accuracy
    [91214] = {91215, 94358, 99842, 100028, },
    -- Tyrannical Gladiator's Sabatons of Cruelty
    [91216] = {91217, 94445, 99843, 100115, },
    -- Tyrannical Gladiator's Sabatons of Alacrity
    [91218] = {91219, 94359, 99844, 100029, },
    -- Tyrannical Gladiator's Chain Armor
    [91222] = {91223, 94405, 99847, 100075, },
    -- Tyrannical Gladiator's Chain Gauntlets
    [91224] = {91225, 94453, 99848, 100123, },
    -- Tyrannical Gladiator's Chain Helm
    [91226] = {91227, 94406, 99849, 100076, },
    -- Tyrannical Gladiator's Chain Leggings
    [91228] = {91229, 94384, 99850, 100054, },
    -- Tyrannical Gladiator's Chain Spaulders
    [91230] = {91231, 94450, 99851, 100120, },
    -- Tyrannical Gladiator's Silk Handguards
    [91232] = {91233, 94451, 99852, 100121, },
    -- Tyrannical Gladiator's Silk Cowl
    [91234] = {91235, 94381, 99853, 100051, },
    -- Tyrannical Gladiator's Silk Trousers
    [91236] = {91237, 94362, 99854, 100032, },
    -- Tyrannical Gladiator's Silk Robe
    [91238] = {91239, 94431, 99855, 100101, },
    -- Tyrannical Gladiator's Silk Amice
    [91240] = {91241, 94389, 99856, 100059, },
    -- Tyrannical Gladiator's Waistband of Cruelty
    [91242] = {91243, 94360, 99857, 100030, },
    -- Tyrannical Gladiator's Boots of Alacrity
    [91244] = {91245, 94432, 99858, 100102, },
    -- Tyrannical Gladiator's Ironskin Gloves
    [91247] = {91248, 94391, 99860, 100061, },
    -- Tyrannical Gladiator's Ironskin Helm
    [91249] = {91250, 94428, 99861, 100098, },
    -- Tyrannical Gladiator's Ironskin Legguards
    [91251] = {91252, 94370, 99862, 100040, },
    -- Tyrannical Gladiator's Ironskin Spaulders
    [91253] = {91254, 94339, 99863, 100009, },
    -- Tyrannical Gladiator's Ironskin Tunic
    [91255] = {91256, 94436, 99864, 100106, },
    -- Tyrannical Gladiator's Copperskin Gloves
    [91257] = {91258, 94340, 99865, 100010, },
    -- Tyrannical Gladiator's Copperskin Helm
    [91259] = {91260, 94341, 99866, 100011, },
    -- Tyrannical Gladiator's Copperskin Legguards
    [91261] = {91262, 94478, 99867, 100148, },
    -- Tyrannical Gladiator's Copperskin Spaulders
    [91263] = {91264, 94493, 99868, 100163, },
    -- Tyrannical Gladiator's Copperskin Tunic
    [91265] = {91266, 94479, 99869, 100149, },
    -- Tyrannical Gladiator's Scaled Chestpiece
    [91267] = {91268, 94463, 99870, 100133, },
    -- Tyrannical Gladiator's Scaled Gauntlets
    [91269] = {91270, 94343, 99871, 100013, },
    -- Tyrannical Gladiator's Scaled Helm
    [91271] = {91272, 94495, 99872, 100165, },
    -- Tyrannical Gladiator's Scaled Legguards
    [91273] = {91274, 94496, 99873, 100166, },
    -- Tyrannical Gladiator's Scaled Shoulders
    [91275] = {91276, 94460, 99874, 100130, },
    -- Tyrannical Gladiator's Clasp of Cruelty
    [91277] = {91278, 94480, 99875, 100150, },
    -- Tyrannical Gladiator's Clasp of Meditation
    [91279] = {91280, 94464, 99876, 100134, },
    -- Tyrannical Gladiator's Greaves of Alacrity
    [91281] = {91282, 94351, 99877, 100021, },
    -- Tyrannical Gladiator's Greaves of Meditation
    [91283] = {91284, 94352, 99878, 100022, },
    -- Tyrannical Gladiator's Ornamented Chestguard
    [91287] = {91288, 94345, 99881, 100015, },
    -- Tyrannical Gladiator's Ornamented Gloves
    [91289] = {91290, 94438, 99882, 100108, },
    -- Tyrannical Gladiator's Ornamented Headcover
    [91291] = {91292, 94348, 99883, 100018, },
    -- Tyrannical Gladiator's Ornamented Legplates
    [91293] = {91294, 94484, 99884, 100154, },
    -- Tyrannical Gladiator's Ornamented Spaulders
    [91295] = {91296, 94413, 99885, 100083, },
    -- Tyrannical Gladiator's Girdle of Accuracy
    [91297] = {91298, 94353, 99886, 100023, },
    -- Tyrannical Gladiator's Girdle of Prowess
    [91299] = {91300, 94440, 99887, 100110, },
    -- Tyrannical Gladiator's Warboots of Cruelty
    [91301] = {91302, 94414, 99888, 100084, },
    -- Tyrannical Gladiator's Warboots of Alacrity
    [91303] = {91304, 94461, 99889, 100131, },
    -- Tyrannical Gladiator's Pike
    [91307] = {91308, 94319, 99892, 99980, },
    -- Tyrannical Gladiator's Mooncloth Gloves
    [91309] = {91310, 94328, 99893, 99989, },
    -- Tyrannical Gladiator's Mooncloth Helm
    [91311] = {91312, 94419, 99894, 100089, },
    -- Tyrannical Gladiator's Mooncloth Leggings
    [91313] = {91314, 94420, 99895, 100090, },
    -- Tyrannical Gladiator's Mooncloth Robe
    [91315] = {91316, 94397, 99896, 100067, },
    -- Tyrannical Gladiator's Mooncloth Mantle
    [91317] = {91318, 94466, 99897, 100136, },
    -- Tyrannical Gladiator's Satin Gloves
    [91319] = {91320, 94423, 99898, 100093, },
    -- Tyrannical Gladiator's Satin Hood
    [91321] = {91322, 94467, 99899, 100137, },
    -- Tyrannical Gladiator's Satin Leggings
    [91323] = {91324, 94334, 99900, 99996, },
    -- Tyrannical Gladiator's Satin Robe
    [91325] = {91326, 94335, 99901, 99998, },
    -- Tyrannical Gladiator's Satin Mantle
    [91327] = {91328, 94385, 99902, 100055, },
    -- Tyrannical Gladiator's Waistband of Accuracy
    [91335] = {91336, 94424, 99903, 100094, },
    -- Tyrannical Gladiator's Boots of Cruelty
    [91337] = {91338, 94374, 99904, 100044, },
    -- Tyrannical Gladiator's Leather Tunic
    [91340] = {91341, 94443, 99906, 100113, },
    -- Tyrannical Gladiator's Leather Gloves
    [91342] = {91343, 94377, 99907, 100047, },
    -- Tyrannical Gladiator's Leather Helm
    [91344] = {91345, 94426, 99908, 100096, },
    -- Tyrannical Gladiator's Leather Legguards
    [91346] = {91347, 94446, 99909, 100116, },
    -- Tyrannical Gladiator's Leather Spaulders
    [91348] = {91349, 94447, 99910, 100117, },
    -- Tyrannical Gladiator's Waistguard of Meditation
    [91350] = {91351, 94382, 99911, 100052, },
    -- Tyrannical Gladiator's Ringmail Armor
    [91358] = {91359, 94433, 99916, 100103, },
    -- Tyrannical Gladiator's Ringmail Gauntlets
    [91360] = {91361, 94490, 99917, 100160, },
    -- Tyrannical Gladiator's Ringmail Helm
    [91362] = {91363, 94434, 99918, 100104, },
    -- Tyrannical Gladiator's Ringmail Leggings
    [91364] = {91365, 94435, 99919, 100105, },
    -- Tyrannical Gladiator's Ringmail Spaulders
    [91366] = {91367, 94369, 99920, 100039, },
    -- Tyrannical Gladiator's Linked Armor
    [91368] = {91369, 94475, 99921, 100145, },
    -- Tyrannical Gladiator's Linked Gauntlets
    [91370] = {91371, 94458, 99922, 100128, },
    -- Tyrannical Gladiator's Linked Helm
    [91372] = {91373, 94430, 99923, 100100, },
    -- Tyrannical Gladiator's Linked Leggings
    [91374] = {91375, 94494, 99924, 100164, },
    -- Tyrannical Gladiator's Linked Spaulders
    [91376] = {91377, 94342, 99925, 100012, },
    -- Tyrannical Gladiator's Waistguard of Cruelty
    [91378] = {91379, 94393, 99926, 100063, },
    -- Tyrannical Gladiator's Mail Armor
    [91380] = {91381, 94459, 99927, 100129, },
    -- Tyrannical Gladiator's Mail Gauntlets
    [91382] = {91383, 94408, 99928, 100078, },
    -- Tyrannical Gladiator's Mail Helm
    [91384] = {91385, 94409, 99929, 100079, },
    -- Tyrannical Gladiator's Mail Leggings
    [91386] = {91387, 94497, 99930, 100167, },
    -- Tyrannical Gladiator's Mail Spaulders
    [91388] = {91389, 94350, 99931, 100020, },
    -- Tyrannical Gladiator's Shanker
    [91390] = {91391, 94315, 99932, 99976, },
    -- Tyrannical Gladiator's Ripper
    [91392] = {91393, 94316, 99933, 99977, },
    -- Tyrannical Gladiator's Fleshslicer
    [91394] = {91395, 94314, 99934, 99975, },
    -- Tyrannical Gladiator's Render
    [91396] = {91397, 94321, 99935, 99982, },
    -- Tyrannical Gladiator's Mageblade
    [91398] = {91399, 94310, 99936, 99971, },
    -- Tyrannical Gladiator's Baton of Light
    [91402] = {91403, 94308, 99939, 99969, },
    -- Tyrannical Gladiator's Hacker
    [91404] = {91405, 94317, 99940, 99978, },
    -- Tyrannical Gladiator's Bonecracker
    [91406] = {91407, 94322, 99941, 99983, },
    -- Tyrannical Gladiator's Slicer
    [91408] = {91409, 94318, 99942, 99979, },
    -- Tyrannical Gladiator's Shield Wall
    [91418] = {91419, 94500, 99951, 100170, },
    -- Tyrannical Gladiator's Felweave Handguards
    [91420] = {91421, 94441, 99952, 100111, },
    -- Tyrannical Gladiator's Felweave Cowl
    [91422] = {91423, 94442, 99953, 100112, },
    -- Tyrannical Gladiator's Felweave Trousers
    [91424] = {91425, 94471, 99954, 100141, },
    -- Tyrannical Gladiator's Felweave Raiment
    [91426] = {91427, 94375, 99955, 100045, },
    -- Tyrannical Gladiator's Felweave Amice
    [91428] = {91429, 94398, 99956, 100068, },
    -- Tyrannical Gladiator's Plate Chestpiece
    [91430] = {91431, 94444, 99957, 100114, },
    -- Tyrannical Gladiator's Plate Gauntlets
    [91432] = {91433, 94331, 99958, 99992, },
    -- Tyrannical Gladiator's Plate Helm
    [91434] = {91435, 94332, 99959, 99993, },
    -- Tyrannical Gladiator's Plate Legguards
    [91436] = {91437, 94448, 99960, 100118, },
    -- Tyrannical Gladiator's Plate Shoulders
    [91438] = {91439, 94401, 99961, 100071, },
    -- Renataki's Soul Charm
    [94512] = {95625, 95997, 96369, 96741, },
    -- Wushoolay's Final Choice
    [94513] = {95669, 96041, 96413, 96785, },
    -- Horridon's Last Gasp
    [94514] = {95641, 96013, 96385, 96757, },
    -- Fabled Feather of Ji-Kun
    [94515] = {95726, 96098, 96470, 96842, },
    -- Fortitude of the Zandalari
    [94516] = {95677, 96049, 96421, 96793, },
    -- Delicate Vial of the Sanguinaire
    [94518] = {95779, 96151, 96523, 96895, },
    -- Primordius' Talisman of Rage
    [94519] = {95757, 96129, 96501, 96873, },
    -- Inscribed Bag of Hydra-Spawn
    [94520] = {95712, 96084, 96456, 96828, },
    -- Breath of the Hydra
    [94521] = {95711, 96083, 96455, 96827, },
    -- Talisman of Bloodlust
    [94522] = {95748, 96120, 96492, 96864, },
    -- Bad Juju
    [94523] = {95665, 96037, 96409, 96781, },
    -- Unerring Vision of Lei Shen
    [94524] = {95814, 96186, 96558, 96930, },
    -- Stolen Relic of Zuldazar
    [94525] = {95763, 96135, 96507, 96879, },
    -- Spark of Zandalar
    [94526] = {95654, 96026, 96398, 96770, },
    -- Ji-Kun's Rising Winds
    [94527] = {95727, 96099, 96471, 96843, },
    -- Soul Barrier
    [94528] = {95811, 96183, 96555, 96927, },
    -- Gaze of the Twins
    [94529] = {95799, 96171, 96543, 96915, },
    -- Lightning-Imbued Chalice
    [94530] = {95817, 96189, 96561, 96933, },
    -- Cha-Ye's Essence of Brilliance
    [94531] = {95772, 96144, 96516, 96888, },
    -- Rune of Re-Origination
    [94532] = {95802, 96174, 96546, 96918, },
    -- Worldbreaker's Stormscythe
    [94722] = {95632, 96004, 96376, 96748, },
    -- Chestplate of Violent Detonation
    [94723] = {95630, 96002, 96374, 96746, },
    -- Lightning-Eye Hood
    [94724] = {95626, 95998, 96370, 96742, },
    -- Static-Shot Shoulderguards
    [94725] = {95628, 96000, 96372, 96744, },
    -- Cloudbreaker Greatbelt
    [94726] = {95629, 96001, 96373, 96745, },
    -- Bracers of Constant Implosion
    [94727] = {95631, 96003, 96375, 96747, },
    -- Spearman's Jingling Leggings
    [94728] = {95627, 95999, 96371, 96743, },
    -- Jin'rokh's Soulcrystal
    [94729] = {95633, 96005, 96377, 96749, },
    -- Soulblade of the Breaking Storm
    [94730] = {95640, 96012, 96384, 96756, },
    -- Robes of Static Bursts
    [94731] = {95637, 96009, 96381, 96753, },
    -- Infinitely Conducting Bracers
    [94732] = {95642, 96014, 96386, 96758, },
    -- Fissure-Split Shoulderwraps
    [94733] = {95636, 96008, 96380, 96752, },
    -- Ionized Yojamban Carapace
    [94734] = {95644, 96016, 96388, 96760, },
    -- Drape of Booming Nights
    [94735] = {95639, 96011, 96383, 96755, },
    -- Ghostbinder Greatboots
    [94736] = {95643, 96015, 96387, 96759, },
    -- Lightningweaver Gauntlets
    [94737] = {95634, 96006, 96378, 96750, },
    -- Jin'rokh's Dreamshard
    [94738] = {95638, 96010, 96382, 96754, },
    -- Al'set's Tormented Leggings
    [94739] = {95635, 96007, 96379, 96751, },
    -- Jalak's Maelstrom Staff
    [94740] = {95647, 96019, 96391, 96763, },
    -- Sul'lithuz Sandmail
    [94741] = {95649, 96021, 96393, 96765, },
    -- Frozen Warlord's Bracers
    [94742] = {95650, 96022, 96394, 96766, },
    -- Bindings of Multiplicative Strikes
    [94743] = {95648, 96020, 96392, 96764, },
    -- Puncture-Proof Greathelm
    [94744] = {95652, 96024, 96396, 96768, },
    -- Horn-Rimmed Doomcloak
    [94745] = {95653, 96025, 96397, 96769, },
    -- Talisman of Living Poison
    [94746] = {95646, 96018, 96390, 96762, },
    -- Bloodlord's Bloodsoaked Legplates
    [94747] = {95651, 96023, 96395, 96767, },
    -- Wastewalker's Sandblasted Drape
    [94748] = {95645, 96017, 96389, 96761, },
    -- Vaccinator's Armwraps
    [94750] = {95656, 96028, 96400, 96772, },
    -- Armplates of the Vanquished Abomination
    [94751] = {95664, 96036, 96408, 96780, },
    -- Flamecaster's Burning Crown
    [94752] = {95655, 96027, 96399, 96771, },
    -- Spaulders of Dinomancy
    [94753] = {95662, 96034, 96406, 96778, },
    -- Horridon's Tusk Fragment
    [94754] = {95658, 96030, 96402, 96774, },
    -- Venomlord's Totemic Wand
    [94755] = {95660, 96032, 96404, 96776, },
    -- Roots of Rampaging Earth
    [94756] = {95661, 96033, 96405, 96777, },
    -- Fingers of the Night
    [94757] = {95801, 96173, 96545, 96917, },
    -- Zerat, Malakk's Soulburning Greatsword
    [94758] = {95675, 96047, 96419, 96791, },
    -- Kura-Kura, Kazra'jin's Skullcleaver
    [94759] = {95666, 96038, 96410, 96782, },
    -- Amun-Thoth, Sul's Spiritrending Talons
    [94760] = {95670, 96042, 96414, 96786, },
    -- Zandalari Robes of the Final Rite
    [94761] = {95668, 96040, 96412, 96784, },
    -- Mar'li's Bloodstained Sandals
    [94762] = {95667, 96039, 96411, 96783, },
    -- Gaze of Gara'jal
    [94763] = {95672, 96044, 96416, 96788, },
    -- Overloaded Bladebreaker Cuirass
    [94764] = {95674, 96046, 96418, 96790, },
    -- Robes of Treacherous Ground
    [94765] = {95671, 96043, 96415, 96787, },
    -- Talisman of Angry Spirits
    [94766] = {95676, 96048, 96420, 96792, },
    -- Loa-Ridden Bracers
    [94767] = {95673, 96045, 96417, 96789, },
    -- Shellsplitter Greataxe
    [94768] = {95686, 96058, 96430, 96802, },
    -- Shattered Tortoiseshell Longbow
    [94769] = {95678, 96050, 96422, 96794, },
    -- Rockfall Ribwraps
    [94770] = {95679, 96051, 96423, 96795, },
    -- Shell-Coated Wristplates
    [94771] = {95684, 96056, 96428, 96800, },
    -- Quakestompers
    [94772] = {95682, 96054, 96426, 96798, },
    -- Shoulderguards of Centripetal Destruction
    [94773] = {95683, 96055, 96427, 96799, },
    -- Beakbreaker Greatcloak
    [94774] = {95687, 96059, 96431, 96803, },
    -- Beady-Eye Bracers
    [94775] = {95681, 96053, 96425, 96797, },
    -- Amulet of the Primal Turtle
    [94776] = {95685, 96057, 96429, 96801, },
    -- Grips of Vampiric Cruelty
    [94777] = {95680, 96052, 96424, 96796, },
    -- Tortos' Discarded Shell
    [94778] = {95692, 96064, 96436, 96808, },
    -- Robes of Concussive Shocks
    [94779] = {95694, 96066, 96438, 96810, },
    -- Azure Shell Bracers
    [94781] = {95688, 96060, 96432, 96804, },
    -- Stonegaze Hood
    [94782] = {95689, 96061, 96433, 96805, },
    -- Spaulders of Quaking Fear
    [94783] = {95695, 96067, 96439, 96811, },
    -- Refreshing Abalone Girdle
    [94784] = {95696, 96068, 96440, 96812, },
    -- Shimmershell Cape
    [94785] = {95691, 96063, 96435, 96807, },
    -- Vampire Bat-Hide Bracers
    [94786] = {95693, 96065, 96437, 96809, },
    -- Tortos' Shellseizers
    [94787] = {95697, 96069, 96441, 96813, },
    -- Megaera's Poisoned Fang
    [94788] = {95698, 96070, 96442, 96814, },
    -- Rot-Proof Greatplate
    [94789] = {95703, 96075, 96447, 96819, },
    -- Grips of Cinderflesh
    [94790] = {95701, 96073, 96445, 96817, },
    -- Poisonblood Bladeshoulders
    [94791] = {95700, 96072, 96444, 96816, },
    -- Plated Toothbreaker Girdle
    [94792] = {95702, 96074, 96446, 96818, },
    -- Hydraskull Choker
    [94793] = {95705, 96077, 96449, 96821, },
    -- Quadra-Head Brooch
    [94794] = {95699, 96071, 96443, 96815, },
    -- Spinescale Seal
    [94795] = {95704, 96076, 96448, 96820, },
    -- Fetish of the Hydra
    [94796] = {95710, 96082, 96454, 96826, },
    -- Chain of Consuming Magic
    [94797] = {95715, 96087, 96459, 96831, },
    -- Ice-Scored Treads
    [94798] = {95716, 96088, 96460, 96832, },
    -- Sandals of Arcane Fury
    [94799] = {95706, 96078, 96450, 96822, },
    -- Hood of Smoldering Flesh
    [94800] = {95713, 96085, 96457, 96829, },
    -- Gleaming-Eye Shoulderpads
    [94801] = {95707, 96079, 96451, 96823, },
    -- Links of the Bifurcated Tongue
    [94802] = {95714, 96086, 96458, 96830, },
    -- Frostborn Wristwraps
    [94804] = {95708, 96080, 96452, 96824, },
    -- Giorgio's Caduceus of Pure Moods
    [94805] = {95720, 96092, 96464, 96836, },
    -- Robe of Midnight Down
    [94806] = {95719, 96091, 96463, 96835, },
    -- Egg-Shard Grips
    [94807] = {95725, 96097, 96469, 96841, },
    -- Grasp of the Ruthless Mother
    [94808] = {95722, 96094, 96466, 96838, },
    -- Crown of Potentiated Birth
    [94809] = {95723, 96095, 96467, 96839, },
    -- Talonrender Chestplate
    [94810] = {95724, 96096, 96468, 96840, },
    -- Featherflight Belt
    [94811] = {95721, 96093, 96465, 96837, },
    -- Pinionfeather Greatcloak
    [94812] = {95717, 96089, 96461, 96833, },
    -- Cord of Cacophonous Cawing
    [94813] = {95718, 96090, 96462, 96834, },
    -- Durumu's Baleful Gaze
    [94814] = {95728, 96100, 96472, 96844, },
    -- Legplates of the Dark Parasite
    [94815] = {95733, 96105, 96477, 96849, },
    -- Crimson Bloom Legguards
    [94816] = {95729, 96101, 96473, 96845, },
    -- Treads of the Blind Eye
    [94817] = {95734, 96106, 96478, 96850, },
    -- Aberrant Chestguard of Torment
    [94818] = {95731, 96103, 96475, 96847, },
    -- Links of the Disintegrator
    [94819] = {95730, 96102, 96474, 96846, },
    -- Caustic Spike Bracers
    [94820] = {95732, 96104, 96476, 96848, },
    -- Artery Rippers
    [94821] = {95735, 96107, 96479, 96851, },
    -- Reinforced Mirror-Sheen Cloak
    [94822] = {95736, 96108, 96480, 96852, },
    -- Ritual Dagger of the Mind's Eye
    [94922] = {95743, 96115, 96487, 96859, },
    -- Leggings of Pulsing Blood
    [94923] = {95739, 96111, 96483, 96855, },
    -- Iceshatter Gauntlets
    [94924] = {95746, 96118, 96490, 96862, },
    -- Lifedrainer's Sordid Grip
    [94925] = {95738, 96110, 96482, 96854, },
    -- Vein-Cover Bracers
    [94926] = {95745, 96117, 96489, 96861, },
    -- Sandals of the Starving Eye
    [94927] = {95744, 96116, 96488, 96860, },
    -- Chilblain Spaulders
    [94928] = {95740, 96112, 96484, 96856, },
    -- Deadly Glare Cape
    [94929] = {95741, 96113, 96485, 96857, },
    -- Legplates of Re-Emergence
    [94930] = {95747, 96119, 96491, 96863, },
    -- Durumu's Captive Eyeball
    [94931] = {95742, 96114, 96486, 96858, },
    -- Acid-Spine Bonemace
    [94937] = {95758, 96130, 96502, 96874, },
    -- Pathogenic Gauntlets
    [94938] = {95752, 96124, 96496, 96868, },
    -- Gloves of Cushioned Air
    [94939] = {95749, 96121, 96493, 96865, },
    -- Bracers of Mutagenic Fervor
    [94940] = {95750, 96122, 96494, 96866, },
    -- Metabolically Boosted Shoulderplates
    [94941] = {95754, 96126, 96498, 96870, },
    -- Hydra-Scale Bloodcloak
    [94942] = {95755, 96127, 96499, 96871, },
    -- Synapse-String Handguards
    [94943] = {95751, 96123, 96495, 96867, },
    -- Black Blood Legplates
    [94944] = {95753, 96125, 96497, 96869, },
    -- Greatshield of the Gloaming
    [94945] = {95768, 96140, 96512, 96884, },
    -- Leggings of the Malformed Sapling
    [94946] = {95764, 96136, 96508, 96880, },
    -- Helix-Breaker Gloves
    [94947] = {95760, 96132, 96504, 96876, },
    -- Bracers of Fragile Bone
    [94948] = {95762, 96134, 96506, 96878, },
    -- Clear-Mind Helm
    [94949] = {95765, 96137, 96509, 96881, },
    -- Spaulders of Primordial Growth
    [94950] = {95767, 96139, 96511, 96883, },
    -- Robes of Mutagenic Blood
    [94951] = {95759, 96131, 96503, 96875, },
    -- Bonemender Bracers
    [94952] = {95766, 96138, 96510, 96882, },
    -- Leggings of Ebon Veins
    [94953] = {95761, 96133, 96505, 96877, },
    -- Hand of the Dark Animus
    [94954] = {95770, 96142, 96514, 96886, },
    -- Athame of the Sanguine Ritual
    [94955] = {95774, 96146, 96518, 96890, },
    -- Matter-Swapped Legplates
    [94956] = {95777, 96149, 96521, 96893, },
    -- Anima-Ringed Fingers
    [94957] = {95776, 96148, 96520, 96892, },
    -- Crown of the Golden Golem
    [94958] = {95778, 96150, 96522, 96894, },
    -- Hood of the Crimson Wake
    [94959] = {95771, 96143, 96515, 96887, },
    -- Constantly Accelerating Cloak
    [94960] = {95773, 96145, 96517, 96889, },
    -- Gore-Soaked Gear
    [94961] = {95769, 96141, 96513, 96885, },
    -- Worldbinder Leggings
    [94962] = {95775, 96147, 96519, 96891, },
    -- Voice of the Quilen
    [94963] = {95781, 96153, 96525, 96897, },
    -- Qon's Flaming Scimitar
    [94964] = {95790, 96162, 96534, 96906, },
    -- Orb of Arcing Lightning
    [94965] = {95786, 96158, 96530, 96902, },
    -- Saddle-Scarred Leggings
    [94966] = {95783, 96155, 96527, 96899, },
    -- Spurs of the Storm Cavalry
    [94967] = {95787, 96159, 96531, 96903, },
    -- Dam'ren's Frozen Footguards
    [94968] = {95784, 96156, 96528, 96900, },
    -- Ro'shak's Molten Chain
    [94969] = {95788, 96160, 96532, 96904, },
    -- Quet'zal's Crackling Cord
    [94970] = {95782, 96154, 96526, 96898, },
    -- Iron Qon's Boot Knife
    [94971] = {95780, 96152, 96524, 96896, },
    -- Rein-Binder's Fists
    [94972] = {95789, 96161, 96533, 96905, },
    -- Suen-Wo, Spire of the Falling Sun
    [94974] = {95795, 96167, 96539, 96911, },
    -- Legguards of Scintillating Scales
    [94975] = {95663, 96035, 96407, 96779, },
    -- Tidal Force Treads
    [94976] = {95798, 96170, 96542, 96914, },
    -- Robes of the Moon Lotus
    [94977] = {95792, 96164, 96536, 96908, },
    -- Girdle of Night and Day
    [94978] = {95797, 96169, 96541, 96913, },
    -- Bracers of the Midnight Comet
    [94979] = {95796, 96168, 96540, 96912, },
    -- Passionfire Choker
    [94980] = {95793, 96165, 96537, 96909, },
    -- Moonjade Necklace
    [94981] = {95800, 96172, 96544, 96916, },
    -- Uroe, Harbinger of Terror
    [94982] = {95809, 96181, 96553, 96925, },
    -- Shan-Dun, Breaker of Hope
    [94983] = {95803, 96175, 96547, 96919, },
    -- Doomed Crown of Lei Shen
    [94984] = {95806, 96178, 96550, 96922, },
    -- Legplates of Whipping Ionization
    [94985] = {95808, 96180, 96552, 96924, },
    -- Conduit-Breaker Chain Leggings
    [94986] = {95805, 96177, 96549, 96921, },
    -- Fusion Slasher Chestguard
    [94987] = {95804, 96176, 96548, 96920, },
    -- Torall, Rod of the Shattered Throne
    [94988] = {95815, 96187, 96559, 96931, },
    -- Lei Shen's Grounded Carapace
    [94989] = {95821, 96193, 96565, 96937, },
    -- Legwraps of Cardinality
    [94990] = {95812, 96184, 96556, 96928, },
    -- Grips of Slicing Electricity
    [94991] = {95819, 96191, 96563, 96935, },
    -- Leggings of the Violent Gale
    [94992] = {95820, 96192, 96564, 96936, },
    -- Gloves of the Maimed Vizier
    [94993] = {95813, 96185, 96557, 96929, },
    -- Soul Prism of Lei Shen
    [94994] = {95816, 96188, 96560, 96932, },
    -- Abandoned Spaulders of Arrowflight
    [95060] = {95870, 96242, 96614, 96986, },
    -- Lost Shoulders of Fire
    [95061] = {95863, 96235, 96607, 96979, },
    -- Forgotten Mantle of the Sun
    [95062] = {95869, 96241, 96613, 96985, },
    -- Reconstructed Furious Shoulderplates
    [95063] = {95873, 96245, 96617, 96989, },
    -- Abandoned Spaulders of Renewal
    [95064] = {95871, 96243, 96615, 96987, },
    -- Forgotten Mantle of the Moon
    [95065] = {95868, 96240, 96612, 96984, },
    -- Lost Shoulders of Healing
    [95066] = {95864, 96236, 96608, 96980, },
    -- Lost Shoulders of Fluidity
    [95067] = {95865, 96237, 96609, 96981, },
    -- Reconstructed Bloody Shoulderplates
    [95068] = {95874, 96246, 96618, 96990, },
    -- Reconstructed Holy Shoulderplates
    [95069] = {95872, 96244, 96616, 96988, },
    -- Necklace of the Terra-Cotta Archer
    [95202] = {95958, 96330, 96702, 97074, },
    -- Necklace of the Terra-Cotta Invoker
    [95203] = {95964, 96336, 96708, 97080, },
    -- Necklace of the Terra-Cotta Mender
    [95204] = {95969, 96341, 96713, 97085, },
    -- Necklace of the Terra-Cotta Vanquisher
    [95205] = {95977, 96349, 96721, 97093, },
    -- Necklace of the Terra-Cotta Protector
    [95206] = {95980, 96352, 96724, 97096, },
    -- Abandoned Zandalari Firecord
    [95207] = {95961, 96333, 96705, 97077, },
    -- Abandoned Zandalari Shadowgirdle
    [95208] = {95962, 96334, 96706, 97078, },
    -- Abandoned Zandalari Silentbelt
    [95209] = {95970, 96342, 96714, 97086, },
    -- Abandoned Zandalari Moonstrap
    [95210] = {95971, 96343, 96715, 97087, },
    -- Abandoned Zandalari Arrowlinks
    [95211] = {95972, 96344, 96716, 97088, },
    -- Abandoned Zandalari Waterchain
    [95212] = {95973, 96345, 96717, 97089, },
    -- Abandoned Zandalari Greatbelt
    [95213] = {95974, 96346, 96718, 97090, },
    -- Abandoned Zandalari Goreplate
    [95214] = {95975, 96347, 96719, 97091, },
    -- Abandoned Zandalari Bucklebreaker
    [95215] = {95976, 96348, 96720, 97092, },
    -- Vaultwalker Sabatons
    [95216] = {95968, 96340, 96712, 97084, },
    -- Locksmasher Greaves
    [95217] = {95978, 96350, 96722, 97094, },
    -- Columnbreaker Stompers
    [95218] = {95979, 96351, 96723, 97095, },
    -- Spiderweb Tabi
    [95219] = {95959, 96331, 96703, 97075, },
    -- Scalehide Spurs
    [95220] = {95960, 96332, 96704, 97076, },
    -- Deeproot Treads
    [95221] = {95966, 96338, 96710, 97082, },
    -- Spiritbound Boots
    [95222] = {95967, 96339, 96711, 97083, },
    -- Silentflame Sandals
    [95223] = {95963, 96335, 96707, 97079, },
    -- Home-Warding Slippers
    [95224] = {95965, 96337, 96709, 97081, },
    -- Ultimate Protection of the Emperor
    [95472] = {95810, 96182, 96554, 96926, },
    -- Lei Shen's Orb of Command
    [95473] = {95818, 96190, 96562, 96934, },
    -- Bo-Ris, Horror in the Night
    [95498] = {95877, 96249, 96621, 96993, },
    -- Invocation of the Dawn
    [95499] = {95858, 96230, 96602, 96974, },
    -- Jerthud, Graceful Hand of the Savior
    [95500] = {95867, 96239, 96611, 96983, },
    -- Fyn's Flickering Dagger
    [95501] = {95860, 96232, 96604, 96976, },
    -- Do-tharak, the Swordbreaker
    [95502] = {95876, 96248, 96620, 96992, },
    -- Miracoran, the Vehement Chord
    [95503] = {95859, 96231, 96603, 96975, },
    -- Zeeg's Ancient Kegsmasher
    [95504] = {95861, 96233, 96605, 96977, },
    -- Greatsword of Frozen Hells
    [95505] = {95875, 96247, 96619, 96991, },
    -- Nadagast's Exsanguinator
    [95506] = {95866, 96238, 96610, 96982, },
    -- Darkwood Spiritstaff
    [95507] = {95862, 96234, 96606, 96978, },
    -- Sign of the Bloodied God
    [95510] = {95624, 95996, 96368, 96740, },
    -- Durumu's Severed Tentacle
    [95511] = {95737, 96109, 96481, 96853, },
    -- Ro'shak's Remembrance
    [95512] = {95785, 96157, 96529, 96901, },
    -- Band of the Scaled Tyrant
    [95513] = {95756, 96128, 96500, 96872, },
    -- Petrified Eye of the Basilisk
    [95514] = {95659, 96031, 96403, 96775, },
    -- Shield of Twinned Despair
    [95515] = {95794, 96166, 96538, 96910, },
    -- Visage of the Doomed
    [95516] = {95878, 96250, 96622, 96994, },
    -- Legplates of the Lightning Throne
    [95535] = {95807, 96179, 96551, 96923, },
    -- Chest of the Crackling Vanquisher
    [95569] = {95822, 96194, 96566, 96938, },
    -- Gauntlets of the Crackling Vanquisher
    [95570] = {95855, 96227, 96599, 96971, },
    -- Helm of the Crackling Vanquisher
    [95571] = {95879, 96251, 96623, 96995, },
    -- Leggings of the Crackling Vanquisher
    [95572] = {95887, 96259, 96631, 97003, },
    -- Shoulders of the Crackling Vanquisher
    [95573] = {95955, 96327, 96699, 97071, },
    -- Chest of the Crackling Conqueror
    [95574] = {95823, 96195, 96567, 96939, },
    -- Gauntlets of the Crackling Conqueror
    [95575] = {95856, 96228, 96600, 96972, },
    -- Leggings of the Crackling Conqueror
    [95576] = {95888, 96260, 96632, 97004, },
    -- Helm of the Crackling Conqueror
    [95577] = {95880, 96252, 96624, 96996, },
    -- Shoulders of the Crackling Conqueror
    [95578] = {95956, 96328, 96700, 97072, },
    -- Chest of the Crackling Protector
    [95579] = {95824, 96196, 96568, 96940, },
    -- Gauntlets of the Crackling Protector
    [95580] = {95857, 96229, 96601, 96973, },
    -- Leggings of the Crackling Protector
    [95581] = {95889, 96261, 96633, 97005, },
    -- Helm of the Crackling Protector
    [95582] = {95881, 96253, 96625, 96997, },
    -- Shoulders of the Crackling Protector
    [95583] = {95957, 96329, 96701, 97073, },
    -- Tia-Tia, the Scything Star
    [97126] = {97127, 97128, 97129, 97130, },
    -- Grievous Gladiator's Decapitator
    [100183] = {100184, 100553, 102807, 103139, },
    -- Grievous Gladiator's Bonegrinder
    [100185] = {100186, 100554, 102808, 103140, },
    -- Grievous Gladiator's Greatsword
    [100187] = {100188, 100541, 102796, 103141, },
    -- Grievous Gladiator's Cleaver
    [100189] = {100190, 100542, 102797, 103142, },
    -- Grievous Gladiator's Pummeler
    [100191] = {100192, 100534, 102789, 103143, },
    -- Grievous Gladiator's Quickblade
    [100193] = {100194, 100555, 102809, 103144, },
    -- Grievous Gladiator's Longbow
    [100203] = {100204, 100533, 102788, 103153, },
    -- Grievous Gladiator's Endgame
    [100223] = {100224, 100732, 102983, 103166, },
    -- Grievous Gladiator's Barrier
    [100225] = {100226, 100731, 102982, 103167, },
    -- Grievous Gladiator's Spellblade
    [100227] = {100228, 100536, 102791, 103168, },
    -- Grievous Gladiator's Battle Staff
    [100229] = {100230, 100543, 102798, 103169, },
    -- Grievous Gladiator's Reprieve
    [100237] = {100238, 100729, 102980, 103176, },
    -- Grievous Gladiator's Touch of Defeat
    [100239] = {100240, 100535, 102790, 103177, },
    -- Grievous Gladiator's Heavy Crossbow
    [100241] = {100242, 100556, 102810, 103178, },
    -- Grievous Gladiator's Dreadplate Chestpiece
    [100243] = {100244, 100622, 102873, 103179, },
    -- Grievous Gladiator's Dreadplate Gauntlets
    [100245] = {100246, 100594, 102847, 103180, },
    -- Grievous Gladiator's Dreadplate Helm
    [100247] = {100248, 100659, 102910, 103181, },
    -- Grievous Gladiator's Dreadplate Legguards
    [100249] = {100250, 100595, 102848, 103182, },
    -- Grievous Gladiator's Dreadplate Shoulders
    [100251] = {100252, 100596, 102849, 103183, },
    -- Grievous Gladiator's Dragonhide Gloves
    [100253] = {100254, 100685, 102936, 103184, },
    -- Grievous Gladiator's Dragonhide Helm
    [100255] = {100256, 100597, 102850, 103185, },
    -- Grievous Gladiator's Dragonhide Legguards
    [100257] = {100258, 100598, 102851, 103186, },
    -- Grievous Gladiator's Dragonhide Robes
    [100259] = {100260, 100686, 102937, 103187, },
    -- Grievous Gladiator's Dragonhide Spaulders
    [100261] = {100262, 100687, 102938, 103188, },
    -- Grievous Gladiator's Kodohide Gloves
    [100268] = {100269, 100601, 102854, 103192, },
    -- Grievous Gladiator's Kodohide Helm
    [100270] = {100271, 100722, 102973, 103193, },
    -- Grievous Gladiator's Kodohide Legguards
    [100272] = {100273, 100707, 102958, 103194, },
    -- Grievous Gladiator's Kodohide Robes
    [100274] = {100275, 100667, 102918, 103195, },
    -- Grievous Gladiator's Kodohide Spaulders
    [100276] = {100277, 100602, 102855, 103196, },
    -- Grievous Gladiator's Staff
    [100278] = {100279, 100537, 102792, 103197, },
    -- Grievous Gladiator's Wyrmhide Gloves
    [100285] = {100286, 100642, 102893, 103201, },
    -- Grievous Gladiator's Wyrmhide Helm
    [100287] = {100288, 100577, 102831, 103202, },
    -- Grievous Gladiator's Wyrmhide Legguards
    [100290] = {100289, 100713, 102964, 103203, },
    -- Grievous Gladiator's Wyrmhide Robes
    [100291] = {100292, 100557, 102811, 103204, },
    -- Grievous Gladiator's Wyrmhide Spaulders
    [100293] = {100294, 100646, 102897, 103205, },
    -- Grievous Gladiator's Rifle
    [100297] = {100298, 100539, 102794, 103206, },
    -- Grievous Gladiator's Gavel
    [100299] = {100300, 100532, 102787, 103207, },
    -- Grievous Gladiator's Redoubt
    [100301] = {100302, 100728, 102979, 103208, },
    -- Grievous Gladiator's Energy Staff
    [100303] = {100304, 100550, 102804, 103209, },
    -- Grievous Gladiator's Chain Armor
    [100318] = {100319, 100635, 102886, 103219, },
    -- Grievous Gladiator's Chain Gauntlets
    [100320] = {100321, 100683, 102934, 103220, },
    -- Grievous Gladiator's Chain Helm
    [100322] = {100323, 100636, 102887, 103221, },
    -- Grievous Gladiator's Chain Leggings
    [100324] = {100325, 100614, 102867, 103222, },
    -- Grievous Gladiator's Chain Spaulders
    [100326] = {100327, 100680, 102931, 103223, },
    -- Grievous Gladiator's Silk Handguards
    [100328] = {100329, 100681, 102932, 103224, },
    -- Grievous Gladiator's Silk Cowl
    [100330] = {100331, 100611, 102864, 103225, },
    -- Grievous Gladiator's Silk Trousers
    [100332] = {100333, 100592, 102845, 103226, },
    -- Grievous Gladiator's Silk Robe
    [100334] = {100335, 100661, 102912, 103227, },
    -- Grievous Gladiator's Silk Amice
    [100336] = {100337, 100619, 102870, 103228, },
    -- Grievous Gladiator's Ironskin Gloves
    [100343] = {100344, 100621, 102872, 103232, },
    -- Grievous Gladiator's Ironskin Helm
    [100345] = {100346, 100658, 102909, 103233, },
    -- Grievous Gladiator's Ironskin Legguards
    [100347] = {100348, 100600, 102853, 103234, },
    -- Grievous Gladiator's Ironskin Spaulders
    [100349] = {100350, 100569, 102823, 103235, },
    -- Grievous Gladiator's Ironskin Tunic
    [100351] = {100352, 100666, 102917, 103236, },
    -- Grievous Gladiator's Copperskin Gloves
    [100353] = {100354, 100570, 102824, 103237, },
    -- Grievous Gladiator's Copperskin Helm
    [100355] = {100356, 100571, 102825, 103238, },
    -- Grievous Gladiator's Copperskin Legguards
    [100357] = {100358, 100708, 102959, 103239, },
    -- Grievous Gladiator's Copperskin Spaulders
    [100359] = {100360, 100723, 102974, 103240, },
    -- Grievous Gladiator's Copperskin Tunic
    [100361] = {100362, 100709, 102960, 103241, },
    -- Grievous Gladiator's Scaled Chestpiece
    [100363] = {100364, 100693, 102944, 103242, },
    -- Grievous Gladiator's Scaled Gauntlets
    [100365] = {100366, 100573, 102827, 103243, },
    -- Grievous Gladiator's Scaled Helm
    [100367] = {100368, 100725, 102976, 103244, },
    -- Grievous Gladiator's Scaled Legguards
    [100369] = {100370, 100726, 102977, 103245, },
    -- Grievous Gladiator's Scaled Shoulders
    [100371] = {100372, 100690, 102941, 103246, },
    -- Grievous Gladiator's Ornamented Chestguard
    [100383] = {100384, 100575, 102829, 103253, },
    -- Grievous Gladiator's Ornamented Gloves
    [100385] = {100386, 100668, 102919, 103254, },
    -- Grievous Gladiator's Ornamented Headcover
    [100387] = {100388, 100578, 102832, 103255, },
    -- Grievous Gladiator's Ornamented Legplates
    [100389] = {100390, 100714, 102965, 103256, },
    -- Grievous Gladiator's Ornamented Spaulders
    [100391] = {100392, 100643, 102894, 103257, },
    -- Grievous Gladiator's Pike
    [100403] = {100404, 100549, 102803, 103264, },
    -- Grievous Gladiator's Mooncloth Gloves
    [100405] = {100406, 100558, 102812, 103265, },
    -- Grievous Gladiator's Mooncloth Helm
    [100407] = {100408, 100649, 102900, 103266, },
    -- Grievous Gladiator's Mooncloth Leggings
    [100409] = {100410, 100650, 102901, 103267, },
    -- Grievous Gladiator's Mooncloth Robe
    [100411] = {100412, 100627, 102878, 103268, },
    -- Grievous Gladiator's Mooncloth Mantle
    [100413] = {100414, 100696, 102947, 103269, },
    -- Grievous Gladiator's Satin Gloves
    [100415] = {100416, 100653, 102904, 103270, },
    -- Grievous Gladiator's Satin Hood
    [100417] = {100418, 100697, 102948, 103271, },
    -- Grievous Gladiator's Satin Leggings
    [100419] = {100420, 100564, 102818, 103272, },
    -- Grievous Gladiator's Satin Robe
    [100421] = {100422, 100565, 102819, 103273, },
    -- Grievous Gladiator's Satin Mantle
    [100423] = {100424, 100615, 102868, 103274, },
    -- Grievous Gladiator's Leather Tunic
    [100430] = {100431, 100673, 102924, 103278, },
    -- Grievous Gladiator's Leather Gloves
    [100432] = {100433, 100607, 102860, 103279, },
    -- Grievous Gladiator's Leather Helm
    [100434] = {100435, 100656, 102907, 103280, },
    -- Grievous Gladiator's Leather Legguards
    [100436] = {100437, 100676, 102927, 103281, },
    -- Grievous Gladiator's Leather Spaulders
    [100438] = {100439, 100677, 102928, 103282, },
    -- Grievous Gladiator's Ringmail Armor
    [100448] = {100449, 100663, 102914, 103288, },
    -- Grievous Gladiator's Ringmail Gauntlets
    [100450] = {100451, 100720, 102971, 103289, },
    -- Grievous Gladiator's Ringmail Helm
    [100452] = {100453, 100664, 102915, 103290, },
    -- Grievous Gladiator's Ringmail Leggings
    [100454] = {100455, 100665, 102916, 103291, },
    -- Grievous Gladiator's Ringmail Spaulders
    [100456] = {100457, 100599, 102852, 103292, },
    -- Grievous Gladiator's Linked Armor
    [100458] = {100459, 100705, 102956, 103293, },
    -- Grievous Gladiator's Linked Gauntlets
    [100460] = {100461, 100688, 102939, 103294, },
    -- Grievous Gladiator's Linked Helm
    [100462] = {100463, 100660, 102911, 103295, },
    -- Grievous Gladiator's Linked Leggings
    [100464] = {100465, 100724, 102975, 103296, },
    -- Grievous Gladiator's Linked Spaulders
    [100466] = {100467, 100572, 102826, 103297, },
    -- Grievous Gladiator's Mail Armor
    [100470] = {100471, 100689, 102940, 103299, },
    -- Grievous Gladiator's Mail Gauntlets
    [100472] = {100473, 100638, 102889, 103300, },
    -- Grievous Gladiator's Mail Helm
    [100474] = {100475, 100639, 102890, 103301, },
    -- Grievous Gladiator's Mail Leggings
    [100476] = {100477, 100727, 102978, 103302, },
    -- Grievous Gladiator's Mail Spaulders
    [100478] = {100479, 100580, 102834, 103303, },
    -- Grievous Gladiator's Shanker
    [100480] = {100481, 100545, 102799, 103304, },
    -- Grievous Gladiator's Ripper
    [100482] = {100483, 100546, 102800, 103305, },
    -- Grievous Gladiator's Render
    [100486] = {100487, 100551, 102805, 103306, },
    -- Grievous Gladiator's Mageblade
    [100488] = {100489, 100540, 102795, 103307, },
    -- Grievous Gladiator's Baton of Light
    [100492] = {100493, 100538, 102793, 103310, },
    -- Grievous Gladiator's Hacker
    [100494] = {100495, 100547, 102801, 103311, },
    -- Grievous Gladiator's Bonecracker
    [100496] = {100497, 100552, 102806, 103312, },
    -- Grievous Gladiator's Slicer
    [100498] = {100499, 100548, 102802, 103313, },
    -- Grievous Gladiator's Shield Wall
    [100508] = {100509, 100730, 102981, 103322, },
    -- Grievous Gladiator's Felweave Handguards
    [100510] = {100511, 100671, 102922, 103323, },
    -- Grievous Gladiator's Felweave Cowl
    [100512] = {100513, 100672, 102923, 103324, },
    -- Grievous Gladiator's Felweave Trousers
    [100514] = {100515, 100701, 102952, 103325, },
    -- Grievous Gladiator's Felweave Raiment
    [100516] = {100517, 100605, 102858, 103326, },
    -- Grievous Gladiator's Felweave Amice
    [100518] = {100519, 100628, 102879, 103327, },
    -- Grievous Gladiator's Plate Chestpiece
    [100520] = {100521, 100674, 102925, 103328, },
    -- Grievous Gladiator's Plate Gauntlets
    [100522] = {100523, 100561, 102815, 103329, },
    -- Grievous Gladiator's Plate Helm
    [100524] = {100525, 100562, 102816, 103330, },
    -- Grievous Gladiator's Plate Legguards
    [100526] = {100527, 100678, 102929, 103331, },
    -- Grievous Gladiator's Plate Shoulders
    [100528] = {100529, 100631, 102882, 103332, },
    -- Vicious Gladiator's Sabatons of Alacrity
    [60557] = {60567, 65604, 65611, 70639, 70640, },
    -- Stormwake, the Tempest's Reach
    [68127] = {68128, 68129, 68130, 68131, 68132, },
    -- Ruthless Gladiator's Sabatons of Alacrity
    [70337] = {70341, 70501, 70508, 72365, 72428, },
    -- Mantle of Dying Light
    [76344] = {76361, 78747, 78750, 78842, 78845, },
    -- Robes of Dying Light
    [76345] = {76360, 78728, 78731, 78823, 78826, },
    -- Malevolent Gladiator's Footguards of Meditation
    [84813] = {84821, 84998, 85003, 91522, 91707, },
    -- Malevolent Gladiator's Footguards of Alacrity
    [84819] = {84820, 84996, 84997, 91539, 91705, },
    -- Malevolent Gladiator's Medallion of Tenacity
    [84931] = {84945, 91684, 91685, 97845, 97935, },
    -- Cloak of Overwhelming Corruption
    [86316] = {86874, 87150, 90512, 90526, 98030, },
    -- Dinomancer's Spiritbinding Spire
    [94749] = {95657, 96029, 96401, 96773, 98012, },
    -- Crystal-Claw Gloves
    [94780] = {95690, 96062, 96434, 96806, 98013, },
    -- Megaera's Shining Eye
    [94803] = {95709, 96081, 96453, 96825, 98007, },
    -- Gauntlets of the Cursed Protector
    [99667] = {99692, 99704, 99722, 99733, 99747, },
    -- Shoulders of the Cursed Vanquisher
    [99668] = {99685, 99701, 99717, 99730, 99754, },
    -- Shoulders of the Cursed Conqueror
    [99669] = {99690, 99707, 99718, 99731, 99755, },
    -- Shoulders of the Cursed Protector
    [99670] = {99695, 99708, 99719, 99732, 99756, },
    -- Helm of the Cursed Vanquisher
    [99671] = {99683, 99705, 99723, 99734, 99748, },
    -- Helm of the Cursed Conqueror
    [99672] = {99689, 99706, 99724, 99735, 99749, },
    -- Helm of the Cursed Protector
    [99673] = {99694, 99697, 99725, 99736, 99750, },
    -- Leggings of the Cursed Vanquisher
    [99674] = {99684, 99698, 99726, 99737, 99751, },
    -- Leggings of the Cursed Conqueror
    [99675] = {99688, 99699, 99712, 99738, 99752, },
    -- Leggings of the Cursed Protector
    [99676] = {99693, 99700, 99713, 99739, 99753, },
    -- Chest of the Cursed Vanquisher
    [99677] = {99696, 99709, 99714, 99727, 99742, },
    -- Chest of the Cursed Conqueror
    [99678] = {99686, 99710, 99715, 99728, 99743, },
    -- Chest of the Cursed Protector
    [99679] = {99691, 99711, 99716, 99729, 99744, },
    -- Gauntlets of the Cursed Vanquisher
    [99680] = {99682, 99702, 99720, 99740, 99745, },
    -- Gauntlets of the Cursed Conqueror
    [99681] = {99687, 99703, 99721, 99741, 99746, },
    -- Assurance of Consequence
    [102292] = {104476, 104725, 104974, 105223, 105472, },
    -- Purified Bindings of Immerseus
    [102293] = {104426, 104675, 104924, 105173, 105422, },
    -- Nazgrim's Burnished Insignia
    [102294] = {104553, 104802, 105051, 105300, 105549, },
    -- Fusion-Fire Core
    [102295] = {104463, 104712, 104961, 105210, 105459, },
    -- Rook's Unlucky Talisman
    [102296] = {104442, 104691, 104940, 105189, 105438, },
    -- Juggernaut's Focusing Crystal
    [102297] = {104518, 104767, 105016, 105265, 105514, },
    -- Evil Eye of Galakras
    [102298] = {104495, 104744, 104993, 105242, 105491, },
    -- Prismatic Prison of Pride
    [102299] = {104478, 104727, 104976, 105225, 105474, },
    -- Kardris' Toxic Totem
    [102300] = {104544, 104793, 105042, 105291, 105540, },
    -- Haromm's Talisman
    [102301] = {104531, 104780, 105029, 105278, 105527, },
    -- Sigil of Rampage
    [102302] = {104584, 104833, 105082, 105331, 105580, },
    -- Frenzied Crystal of Rage
    [102303] = {104576, 104825, 105074, 105323, 105572, },
    -- Thok's Acid-Grooved Tooth
    [102304] = {104611, 104860, 105109, 105358, 105607, },
    -- Thok's Tail Tip
    [102305] = {104613, 104862, 105111, 105360, 105609, },
    -- Vial of Living Corruption
    [102306] = {104572, 104821, 105070, 105319, 105568, },
    -- Curse of Hubris
    [102307] = {104649, 104898, 105147, 105396, 105645, },
    -- Skeer's Bloodsoaked Talisman
    [102308] = {104636, 104885, 105134, 105383, 105632, },
    -- Dysmorphic Samophlange of Discontinuity
    [102309] = {104619, 104868, 105117, 105366, 105615, },
    -- Black Blood of Y'Shaarj
    [102310] = {104652, 104901, 105150, 105399, 105648, },
    -- Ticking Ebon Detonator
    [102311] = {104616, 104865, 105114, 105363, 105612, },
    -- Xal'atoh, Desecrated Image of Gorehowl
    [103649] = {104648, 104897, 105146, 105395, 105644, },
    -- Trident of Corrupted Waters
    [103726] = {104412, 104661, 104910, 105159, 105408, },
    -- Encapsulated Essence of Immerseus
    [103727] = {104421, 104670, 104919, 105168, 105417, },
    -- Hood of Blackened Tears
    [103728] = {104413, 104662, 104911, 105160, 105409, },
    -- Kor'kron Elite Skullmask
    [103729] = {104640, 104889, 105138, 105387, 105636, },
    -- Puddle Punishers
    [103730] = {104414, 104663, 104912, 105161, 105410, },
    -- Minelayer's Padded Boots
    [103731] = {104511, 104760, 105009, 105258, 105507, },
    -- Ravager's Pathwalkers
    [103732] = {104557, 104806, 105055, 105304, 105553, },
    -- Corruption-Rotted Gauntlets
    [103733] = {104417, 104666, 104915, 105164, 105413, },
    -- Tar-Coated Gauntlets
    [103735] = {104515, 104764, 105013, 105262, 105511, },
    -- Chestplate of Congealed Corrosion
    [103736] = {104416, 104665, 104914, 105163, 105412, },
    -- Breastplate of Shamanic Mirrors
    [103737] = {104536, 104785, 105034, 105283, 105532, },
    -- Bubble-Burst Bracers
    [103738] = {104415, 104664, 104913, 105162, 105411, },
    -- Wall-Borer Bracers
    [103739] = {104514, 104763, 105012, 105261, 105510, },
    -- Bracers of Blind Hatred
    [103740] = {104460, 104709, 104958, 105207, 105456, },
    -- Bracers of Sordid Sleep
    [103741] = {104419, 104668, 104917, 105166, 105415, },
    -- Blood Rage Bracers
    [103742] = {104568, 104817, 105066, 105315, 105564, },
    -- Arcsmasher Bracers
    [103743] = {104493, 104742, 104991, 105240, 105489, },
    -- Treads of Unchained Hate
    [103744] = {104418, 104667, 104916, 105165, 105414, },
    -- Ominous Mogu Greatboots
    [103745] = {104592, 104841, 105090, 105339, 105588, },
    -- Pauldrons of Violent Eruption
    [103747] = {104420, 104669, 104918, 105167, 105416, },
    -- Krugruk's Rigid Shoulderplates
    [103748] = {104494, 104743, 104992, 105241, 105490, },
    -- Immerseus' Crystalline Eye
    [103749] = {104411, 104660, 104909, 105158, 105407, },
    -- Gleaming Eye of the Devilsaur
    [103750] = {104606, 104855, 105104, 105353, 105602, },
    -- Hood of Swirling Senses
    [103751] = {104424, 104673, 104922, 105171, 105420, },
    -- Bolt-Burster Grips
    [103752] = {104422, 104671, 104920, 105169, 105418, },
    -- Earthripper Gloves
    [103754] = {104522, 104771, 105020, 105269, 105518, },
    -- Ichor-Dripping Shoulderpads
    [103755] = {104423, 104672, 104921, 105170, 105419, },
    -- Shoulderpads of Pulsing Protection
    [103756] = {104501, 104750, 104999, 105248, 105497, },
    -- Bracers of Purified Spirit
    [103757] = {104429, 104678, 104927, 105176, 105425, },
    -- Bracers of Averted Fatality
    [103758] = {104581, 104830, 105079, 105328, 105577, },
    -- Castlebreaker Bracers
    [103759] = {104526, 104775, 105024, 105273, 105522, },
    -- Salt Water Sandals
    [103760] = {104428, 104677, 104926, 105175, 105424, },
    -- Boots of Perilous Infusion
    [103761] = {104580, 104829, 105078, 105327, 105576, },
    -- Boots of Broken Reliance
    [103762] = {104471, 104720, 104969, 105218, 105467, },
    -- Soul-Soaked Gloves
    [103763] = {104430, 104679, 104928, 105177, 105426, },
    -- Grips of Tidal Force
    [103765] = {104505, 104754, 105003, 105252, 105501, },
    -- Waterwalker Greatboots
    [103766] = {104432, 104681, 104930, 105179, 105428, },
    -- Borer Drill Boots
    [103767] = {104529, 104778, 105027, 105276, 105525, },
    -- Mogu Mindbender's Greaves
    [103768] = {104604, 104853, 105102, 105351, 105600, },
    -- Cloak of Misguided Power
    [103769] = {104425, 104674, 104923, 105172, 105421, },
    -- Seal of Eternal Sorrow
    [103771] = {104427, 104676, 104925, 105174, 105423, },
    -- Seal of Sullen Fury
    [103772] = {104578, 104827, 105076, 105325, 105574, },
    -- Laser-Slice Signet
    [103773] = {104524, 104773, 105022, 105271, 105520, },
    -- Signet of the Dinomancers
    [103774] = {104610, 104859, 105108, 105357, 105606, },
    -- Softfoot's Last Resort
    [103775] = {104434, 104683, 104932, 105181, 105430, },
    -- Death Lotus Crossbow
    [103776] = {104433, 104682, 104931, 105180, 105429, },
    -- Stonetoe's Tormented Treads
    [103777] = {104435, 104684, 104933, 105182, 105431, },
    -- Unrepentant Heels
    [103778] = {104488, 104737, 104986, 105235, 105484, },
    -- Pandaren Roofsprinters
    [103779] = {104586, 104835, 105084, 105333, 105582, },
    -- Grips of Unending Anguish
    [103780] = {104436, 104685, 104934, 105183, 105432, },
    -- Precision Cutters
    [103782] = {104512, 104761, 105010, 105259, 105508, },
    -- Darkfallen Shoulderplates
    [103783] = {104438, 104687, 104936, 105185, 105434, },
    -- Spaulders of the Fallen Warchief
    [103784] = {104645, 104894, 105143, 105392, 105641, },
    -- Poisonbinder Girth
    [103787] = {104437, 104686, 104935, 105184, 105433, },
    -- Demolisher's Reinforced Belt
    [103788] = {104513, 104762, 105011, 105260, 105509, },
    -- Shockstriker Gauntlets
    [103790] = {104439, 104688, 104937, 105186, 105435, },
    -- Calixian Bladebreakers
    [103792] = {104623, 104872, 105121, 105370, 105619, },
    -- Sorrowpath Signet
    [103793] = {104440, 104689, 104938, 105187, 105436, },
    -- Asgorathian Blood Seal
    [103794] = {104624, 104873, 105122, 105371, 105620, },
    -- Seal of the Forgotten Kings
    [103796] = {104593, 104842, 105091, 105340, 105589, },
    -- Bloodclaw Band
    [103798] = {104538, 104787, 105036, 105285, 105534, },
    -- Gloomwrap Greatcloak
    [103799] = {104441, 104690, 104939, 105188, 105437, },
    -- Purehearted Cricket Cage
    [103801] = {104448, 104697, 104946, 105195, 105444, },
    -- Robes of the Tendered Heart
    [103802] = {104444, 104693, 104942, 105191, 105440, },
    -- Mantid Vizier's Robes
    [103803] = {104596, 104845, 105094, 105343, 105592, },
    -- Sha-Seared Sandals
    [103804] = {104443, 104692, 104941, 105190, 105439, },
    -- Bone-Inlaid Sandals
    [103805] = {104497, 104746, 104995, 105244, 105493, },
    -- Toxic Tornado Treads
    [103806] = {104541, 104790, 105039, 105288, 105537, },
    -- Shoulderpads of Dou Dou Chong
    [103807] = {104445, 104694, 104943, 105192, 105441, },
    -- Spaulders of Kor'kron Fealty
    [103808] = {104561, 104810, 105059, 105308, 105557, },
    -- Lifebane Bracers
    [103809] = {104446, 104695, 104944, 105193, 105442, },
    -- Bracers of Sonic Projection
    [103810] = {104630, 104879, 105128, 105377, 105626, },
    -- Bracers of the Broken Fault
    [103811] = {104521, 104770, 105019, 105268, 105517, },
    -- Sabatons of Defilement
    [103812] = {104450, 104699, 104948, 105197, 105446, },
    -- Treads of Autonomic Motion
    [103813] = {104527, 104776, 105025, 105274, 105523, },
    -- Powder-Stained Totemic Treads
    [103814] = {104622, 104871, 105120, 105369, 105618, },
    -- Shoulderguards of Dark Meditations
    [103815] = {104451, 104700, 104949, 105198, 105447, },
    -- Shoulderguards of Foul Streams
    [103816] = {104548, 104797, 105046, 105295, 105544, },
    -- Grips of the Fallen Council
    [103817] = {104452, 104701, 104950, 105199, 105448, },
    -- Gauntlets of Insane Calculations
    [103819] = {104635, 104884, 105133, 105382, 105631, },
    -- Gaze of Echoing Despair
    [103820] = {104453, 104702, 104951, 105200, 105449, },
    -- Crown of Boastful Words
    [103821] = {104481, 104730, 104979, 105228, 105477, },
    -- Petrified Pennyroyal Ring
    [103822] = {104447, 104696, 104945, 105194, 105443, },
    -- Extinguished Ember of Galakras
    [103823] = {104502, 104751, 105000, 105249, 105498, },
    -- Iyyokuk's Hereditary Seal
    [103824] = {104632, 104881, 105130, 105379, 105628, },
    -- Xifeng, Longblade of the Titanic Guardian
    [103826] = {104464, 104713, 104962, 105211, 105460, },
    -- Norushen's Shortblade
    [103827] = {104454, 104703, 104952, 105201, 105450, },
    -- Hvitserk's Formidable Shanker
    [103828] = {104605, 104854, 105103, 105352, 105601, },
    -- Nazgrim's Gutripper
    [103829] = {104551, 104800, 105049, 105298, 105547, },
    -- Gloves of the Golden Protector
    [103830] = {104457, 104706, 104955, 105204, 105453, },
    -- Korgra's Venom-Soaked Gauntlets
    [103831] = {104489, 104738, 104987, 105236, 105485, },
    -- Robes of the Blackened Watcher
    [103834] = {104456, 104705, 104954, 105203, 105452, },
    -- Lazahk's Lost Shadowrap
    [103835] = {104565, 104814, 105063, 105312, 105561, },
    -- Quarantine Shoulderguards
    [103836] = {104459, 104708, 104957, 105206, 105455, },
    -- Shoulderguards of Intended Power
    [103837] = {104643, 104892, 105141, 105390, 105639, },
    -- Leggings of Unabashed Anger
    [103838] = {104458, 104707, 104956, 105205, 105454, },
    -- Rage-Blind Greathelm
    [103839] = {104461, 104710, 104959, 105208, 105457, },
    -- Greathelm of the Warchief
    [103840] = {104647, 104896, 105145, 105394, 105643, },
    -- Reality Ripper Ring
    [103841] = {104455, 104704, 104953, 105202, 105451, },
    -- Swift Serpent Signet
    [103842] = {104487, 104736, 104985, 105234, 105483, },
    -- Ring of Restless Energy
    [103843] = {104562, 104811, 105060, 105309, 105558, },
    -- Kil'ruk's Band of Ascendancy
    [103844] = {104628, 104877, 105126, 105375, 105624, },
    -- Drape of the Despairing Pit
    [103845] = {104462, 104711, 104960, 105209, 105458, },
    -- Norushen's Enigmatic Barrier
    [103847] = {104470, 104719, 104968, 105217, 105466, },
    -- Visage of the Monstrous
    [103848] = {104579, 104828, 105077, 105326, 105575, },
    -- Bracers of Broken Causation
    [103849] = {104465, 104714, 104963, 105212, 105461, },
    -- Scalebane Bracers
    [103850] = {104498, 104747, 104996, 105245, 105494, },
    -- Avool's Ancestral Bracers
    [103851] = {104595, 104844, 105093, 105342, 105591, },
    -- Blight Hurlers
    [103852] = {104466, 104715, 104964, 105213, 105462, },
    -- Montak's Grips of Scorching Breath
    [103853] = {104607, 104856, 105105, 105354, 105603, },
    -- Sash of the Last Guardian
    [103855] = {104467, 104716, 104965, 105214, 105463, },
    -- Belt of the Broken Pact
    [103856] = {104650, 104899, 105148, 105397, 105646, },
    -- Rime-Rift Shoulders
    [103857] = {104468, 104717, 104966, 105215, 105464, },
    -- Confident Grips
    [103858] = {104472, 104721, 104970, 105219, 105468, },
    -- Klaxxi Grips of Rejuvenation
    [103860] = {104599, 104848, 105097, 105346, 105595, },
    -- Bracers of Final Serenity
    [103861] = {104473, 104722, 104971, 105220, 105469, },
    -- Bracers of the Pristine Purifier
    [103862] = {104602, 104851, 105100, 105349, 105598, },
    -- Cavemaker Wristguards
    [103863] = {104528, 104777, 105026, 105275, 105524, },
    -- Wristplates of Broken Doubt
    [103864] = {104475, 104724, 104973, 105222, 105471, },
    -- Smoldering Drakescale Bracers
    [103865] = {104506, 104755, 105004, 105253, 105502, },
    -- Shackles of Stinking Slime
    [103866] = {104549, 104798, 105047, 105296, 105545, },
    -- Untainted Guardian's Chain
    [103867] = {104469, 104718, 104967, 105216, 105465, },
    -- Ashflare Pendant
    [103868] = {104543, 104792, 105041, 105290, 105539, },
    -- Greatsword of Pride's Fall
    [103869] = {104483, 104732, 104981, 105230, 105479, },
    -- Shield of Mockery
    [103870] = {104485, 104734, 104983, 105232, 105481, },
    -- Ancient Mogu Tower Shield
    [103871] = {104594, 104843, 105092, 105341, 105590, },
    -- Bulwark of the Fallen General
    [103872] = {104560, 104809, 105058, 105307, 105556, },
    -- Gaze of Arrogance
    [103873] = {104479, 104728, 104977, 105226, 105475, },
    -- Lever of the Megantholithic Apparatus
    [103874] = {104618, 104867, 105116, 105365, 105614, },
    -- Drakebinder Greatstaff
    [103875] = {104503, 104752, 105001, 105250, 105499, },
    -- Self-Reflecting Mask
    [103876] = {104480, 104729, 104978, 105227, 105476, },
    -- Darkfang Mask
    [103877] = {104546, 104795, 105044, 105293, 105542, },
    -- Greaves of Sublime Superiority
    [103878] = {104482, 104731, 104980, 105229, 105478, },
    -- Malkorok's Giant Stompers
    [103879] = {104567, 104816, 105065, 105314, 105563, },
    -- Wolf-Rider Spurs
    [103880] = {104535, 104784, 105033, 105282, 105531, },
    -- Necklace of Fading Light
    [103881] = {104477, 104726, 104975, 105224, 105473, },
    -- Lost Necklace of the Mogu Empress
    [103882] = {104597, 104846, 105095, 105344, 105593, },
    -- Choker of the Final Word
    [103883] = {104484, 104733, 104982, 105231, 105480, },
    -- Blackfuse's Blasting Cord
    [103884] = {104626, 104875, 105124, 105373, 105622, },
    -- Dagryn's Discarded Longbow
    [103885] = {104486, 104735, 104984, 105233, 105482, },
    -- Hisek's Reserve Longbow
    [103886] = {104627, 104876, 105125, 105374, 105623, },
    -- Cannoneer's Multipocket Gunbelt
    [103887] = {104490, 104739, 104988, 105237, 105486, },
    -- Arrowflight Girdle
    [103888] = {104588, 104837, 105086, 105335, 105584, },
    -- Dagryn's Fuselight Bracers
    [103889] = {104491, 104740, 104989, 105238, 105487, },
    -- Wristguards of Ruination
    [103890] = {104566, 104815, 105064, 105313, 105562, },
    -- Bracers of Infinite Pipes
    [103891] = {104621, 104870, 105119, 105368, 105617, },
    -- Thranok's Shattering Helm
    [103892] = {104492, 104741, 104990, 105239, 105488, },
    -- Helm of the Night Watchman
    [103893] = {104590, 104839, 105088, 105337, 105586, },
    -- Galakrond Control Band
    [103894] = {104496, 104745, 104994, 105243, 105492, },
    -- Ring of the Iron Tomb
    [103895] = {104540, 104789, 105038, 105287, 105536, },
    -- Devilfang Band
    [103896] = {104615, 104864, 105113, 105362, 105611, },
    -- Belt of Ominous Trembles
    [103898] = {104519, 104768, 105017, 105266, 105515, },
    -- Miasmic Skullbelt
    [103899] = {104573, 104822, 105071, 105320, 105569, },
    -- Flameslinger's Fiery Cowl
    [103900] = {104499, 104748, 104997, 105246, 105495, },
    -- Ebon Ritual Hood
    [103901] = {104651, 104900, 105149, 105398, 105647, },
    -- Skydancer Boots
    [103902] = {104500, 104749, 104998, 105247, 105496, },
    -- Sandals of Two Little Bees
    [103904] = {104552, 104801, 105050, 105299, 105548, },
    -- Dragonmaw Emergency Strap
    [103905] = {104504, 104753, 105002, 105251, 105500, },
    -- Seal of Karmic Return
    [103906] = {104655, 104904, 105153, 105402, 105651, },
    -- Windfire Legplates
    [103907] = {104507, 104756, 105005, 105254, 105503, },
    -- Seismic Bore
    [103908] = {104508, 104757, 105006, 105255, 105504, },
    -- Laser Burn Bracers
    [103909] = {104509, 104758, 105007, 105256, 105505, },
    -- Bomber's Blackened Wristwatch
    [103910] = {104620, 104869, 105118, 105367, 105616, },
    -- Mantid Carapace Augments
    [103911] = {104587, 104836, 105085, 105334, 105583, },
    -- Ricocheting Shoulderguards
    [103912] = {104510, 104759, 105008, 105257, 105506, },
    -- Shoulderguards of the Righteous Stand
    [103913] = {104555, 104804, 105053, 105302, 105551, },
    -- Earthbreaker's Steaming Chestplate
    [103914] = {104516, 104765, 105014, 105263, 105512, },
    -- Icy Blood Chestplate
    [103915] = {104612, 104861, 105110, 105359, 105608, },
    -- Juggernaut's Ignition Keys
    [103916] = {104517, 104766, 105015, 105264, 105513, },
    -- Malkorok's Tainted Dog Tags
    [103917] = {104570, 104819, 105068, 105317, 105566, },
    -- Juggernaut's Power Core
    [103918] = {104525, 104774, 105023, 105272, 105521, },
    -- Festering Primordial Globule
    [103919] = {104609, 104858, 105107, 105356, 105605, },
    -- Revelations of Y'Shaarj
    [103920] = {104654, 104903, 105152, 105401, 105650, },
    -- Leggings of Furious Flame
    [103921] = {104520, 104769, 105018, 105267, 105516, },
    -- Shock Pulse Robes
    [103922] = {104523, 104772, 105021, 105270, 105519, },
    -- Robes of Riven Dreams
    [103923] = {104575, 104824, 105073, 105322, 105571, },
    -- Shoulders of the Roiling Inferno
    [103924] = {104449, 104698, 104947, 105196, 105445, },
    -- Hopeglow Spaulders
    [103925] = {104656, 104905, 105154, 105403, 105652, },
    -- Haromm's Frozen Crescent
    [103926] = {104539, 104788, 105037, 105286, 105535, },
    -- Damron's Belt of Darkness
    [103927] = {104532, 104781, 105030, 105279, 105528, },
    -- Cord of Black Dreams
    [103928] = {104639, 104888, 105137, 105386, 105635, },
    -- Riou's Vigilant Leggings
    [103929] = {104533, 104782, 105031, 105280, 105529, },
    -- Haromm's Horrifying Helm
    [103930] = {104534, 104783, 105032, 105281, 105530, },
    -- Penetrating Gaze of Y'Shaarj
    [103931] = {104642, 104891, 105140, 105389, 105638, },
    -- Ashen Wall Girdle
    [103932] = {104537, 104786, 105035, 105284, 105533, },
    -- Untarnishable Greatbelt
    [103933] = {104591, 104840, 105089, 105338, 105587, },
    -- Poisonmist Nightcloak
    [103934] = {104530, 104779, 105028, 105277, 105526, },
    -- Kardris' Scepter
    [103936] = {104545, 104794, 105043, 105292, 105541, },
    -- Horned Mace of the Old Ones
    [103937] = {104653, 104902, 105151, 105400, 105649, },
    -- Iron Wolf Hood
    [103938] = {104542, 104791, 105040, 105289, 105538, },
    -- Hood of Perpetual Implosion
    [103939] = {104574, 104823, 105072, 105321, 105570, },
    -- Belt of the Iron Prison
    [103940] = {104547, 104796, 105045, 105294, 105543, },
    -- Chitin-Link Chain Belt
    [103941] = {104601, 104850, 105099, 105348, 105597, },
    -- Shadow-Binder's Kilt
    [103942] = {104474, 104723, 104972, 105221, 105470, },
    -- Shoulderplates of Gushing Geysers
    [103943] = {104550, 104799, 105048, 105297, 105546, },
    -- Mantle of Looming Darkness
    [103944] = {104659, 104908, 105157, 105406, 105655, },
    -- Gar'tok, Strength of the Faithful
    [103945] = {104559, 104808, 105057, 105306, 105555, },
    -- Arcweaver Spell Sword
    [103946] = {104554, 104803, 105052, 105301, 105550, },
    -- Robes of the Warrior's Fall
    [103947] = {104556, 104805, 105054, 105303, 105552, },
    -- Amber Parasite Wraps
    [103948] = {104633, 104882, 105131, 105380, 105629, },
    -- Crown of Tragic Truth
    [103949] = {104558, 104807, 105056, 105305, 105554, },
    -- Cowl of Smoking Dreams
    [103950] = {104657, 104906, 105155, 105404, 105653, },
    -- Malkorok's Skullcleaver
    [103951] = {104571, 104820, 105069, 105318, 105567, },
    -- Halberd of Inner Shadows
    [103952] = {104564, 104813, 105062, 105311, 105560, },
    -- Kor'kron Hand Cannon
    [103953] = {104563, 104812, 105061, 105310, 105559, },
    -- Legplates of Willful Doom
    [103954] = {104569, 104818, 105067, 105316, 105565, },
    -- Ebon Blood Chestguard
    [103955] = {104582, 104831, 105080, 105329, 105578, },
    -- Chestguard of Toxic Injections
    [103956] = {104634, 104883, 105132, 105381, 105630, },
    -- Terrorguard Chestplate
    [103957] = {104583, 104832, 105081, 105330, 105579, },
    -- Chestplate of Fallen Passion
    [103958] = {104658, 104907, 105156, 105405, 105654, },
    -- Black-Blooded Drape
    [103959] = {104577, 104826, 105075, 105324, 105573, },
    -- Enchanted Shao-Tien Saber
    [103961] = {104585, 104834, 105083, 105332, 105581, },
    -- Ancient Archer's Chestguard
    [103962] = {104589, 104838, 105087, 105336, 105585, },
    -- Chestguard of Relentless Tyranny
    [103963] = {104641, 104890, 105139, 105388, 105637, },
    -- Immaculately Preserved Wand
    [103964] = {104598, 104847, 105096, 105345, 105594, },
    -- Plate Belt of the War-Healer
    [103965] = {104603, 104852, 105101, 105350, 105599, },
    -- Greatbelt of Living Waters
    [103966] = {104431, 104680, 104929, 105178, 105427, },
    -- Shado-Pan Reliquary Kilt
    [103967] = {104600, 104849, 105098, 105347, 105596, },
    -- Britomart's Jagged Pike
    [103968] = {104614, 104863, 105112, 105361, 105610, },
    -- Siegecrafter's Forge Hammer
    [103969] = {104625, 104874, 105123, 105372, 105621, },
    -- Fusespark Gloves
    [103970] = {104617, 104866, 105115, 105364, 105613, },
    -- Korven's Crimson Crescent
    [103971] = {104629, 104878, 105127, 105376, 105625, },
    -- Kil'ruk's Furious Blade
    [103972] = {104637, 104886, 105135, 105384, 105633, },
    -- Rik'kal's Bloody Scalpel
    [103973] = {104631, 104880, 105129, 105378, 105627, },
    -- Kor'kron Spire of Supremacy
    [103974] = {104638, 104887, 105136, 105385, 105634, },
    -- Akolik's Acid-Soaked Robes
    [104308] = {104608, 104857, 105106, 105355, 105604, },
    -- Legplates of Unthinking Strife
    [104311] = {104644, 104893, 105142, 105391, 105640, },
    -- Vision of Time
    [105930] = {105931, 105932, 105933, 105934, 105935, },
    -- Putress' Diary
    [242436] = {242435, 242427, 242432, 242429, 242434, },
    -- Tempered Dark Iron Boots
    [227841] = {228929, 228924, 228927, 228926, 228925, 228928, },
    -- Grievous Gladiator's Footguards of Meditation
    [100265] = {100444, 100566, 100706, 102820, 102957, 103190, 103285, },
    -- Grievous Gladiator's Footguards of Alacrity
    [100282] = {100442, 100574, 100608, 102828, 102861, 103199, 103284, },
    -- Tyrannical Gladiator's Footguards of Meditation
    [91169] = {91170, 91354, 91355, 94336, 94476, 99817, 99913, 100001, 100146, },
    -- Tyrannical Gladiator's Footguards of Alacrity
    [91186] = {91187, 91352, 91353, 94344, 94378, 99826, 99912, 100014, 100048, },
    -- Signet Ring of the Bronze Dragonflight
    [234034] = {234032, 234033, 234017, 234035, 234436, 234016, 234202, 234018, 234198, 234440, 234019, 234026, 234964, 234968, 234438, 234030, 234028, 234031, 234024, 234201, 234965, 234023, 234025, 234020, 234437, 234199, 234021, 234200, 234027, 234029, 234439, 234967, 234022, 234966, },
};

GL.Data.NormalModeHardModeLinks = NormalModeHardModeLinks;

-- Materialize data for ease of use during runtime
--- @test /dump _G.Gargul.Data.NormalModeHardModeLinks[94955];
--- @test /dump _G.Gargul.Data.NormalModeHardModeLinks[96890];
_G.C_Timer.After(8, function ()
    GL:afterCombatDo(function ()
        local AdditionalEntries = {};
        for ID, LinkedIDs in pairs(NormalModeHardModeLinks) do

            if (type(LinkedIDs) == "number") then
                LinkedIDs = { LinkedIDs, };
            end

            for _, linkedID in pairs(LinkedIDs) do
                AdditionalEntries[linkedID] = ID;
            end
        end

        for ID, linkedID in pairs(AdditionalEntries) do
            NormalModeHardModeLinks[ID] = linkedID;
        end
        AdditionalEntries = {};
    end);
end);
