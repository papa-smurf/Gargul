---@type GL
local _, GL = ...;

---@class DB
GL.DB = {
    _initialized = false,
    AwardHistory = {},
    BoostedRolls = {},
    Cache = {},
    GDKP = {},
    LoadDetails = {},
    LootPriority = {},
    MinimapButton = {},
    PlusOnes = {},
    Settings = {},
    SoftRes = {},
    TMB = {},
};

local DB = GL.DB;

function DB:_init()
    GL:debug("DB:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    if (not GargulDB or not type(GargulDB) == "table") then
        GargulDB = {};
    end

    -- Prepare our database tables
    GargulDB.AwardHistory = GargulDB.AwardHistory or {};
    GargulDB.BoostedRolls = GargulDB.BoostedRolls or {};
    GargulDB.GDKP = GargulDB.GDKP or {};
    GargulDB.LoadDetails = GargulDB.LoadDetails or {};
    GargulDB.LootPriority = GargulDB.LootPriority or {};
    GargulDB.MinimapButton = GargulDB.MinimapButton or {};
    GargulDB.PlusOnes = GargulDB.PlusOnes or {};
    GargulDB.Settings = GargulDB.Settings or {};
    GargulDB.SoftRes = GargulDB.SoftRes or {};
    GargulDB.TMB = GargulDB.TMB or {};

    -- Provide a shortcut for each table
    self.AwardHistory = GargulDB.AwardHistory;
    self.BoostedRolls = GargulDB.BoostedRolls;
    self.GDKP = GargulDB.GDKP;
    self.LoadDetails = GargulDB.LoadDetails;
    self.LootPriority = GargulDB.LootPriority;
    self.MinimapButton = GargulDB.MinimapButton;
    self.PlusOnes = GargulDB.PlusOnes;
    self.Settings = GargulDB.Settings;
    self.SoftRes = GargulDB.SoftRes;
    self.TMB = GargulDB.TMB;

    -- Fire DB:store before every logout/reload/exit
    GL.Events:register("DBPlayerLogoutListener", "PLAYER_LOGOUT", self.store);

    self._initialized = true;

    GL.DB.GDKP = {
        activeSession = "checksum_based_on_createdAt_and_uuid",
        Ledger = {
            ["checksum_based_on_createdAt_and_uuid"] = {
                ID = "checksum_based_on_createdAt_and_uuid",
                title = "Black Temple",
                createdAt = 1659816223,
                CreatedBy = {
                    class = "rogue",
                    name = "Gargultest",
                    guild = "Gargul",
                    uuid = "Player-4467-02A4245A",
                },
                Auctions = {},
            },
        },
    };
    if (true) then return; end
    GL.DB.GDKP = {
        activeSession = "checksum_based_on_createdAt_and_uuid",
        Ledger = {
            ["checksum_based_on_createdAt_and_uuid"] = {
                ID = "checksum_based_on_createdAt_and_uuid",
                title = "Black Temple",
                createdAt = 1659816223,
                CreatedBy = {
                    class = "rogue",
                    name = "Gargultest",
                    guild = "Gargul",
                    uuid = "Player-4467-02A4245A",
                },
                Auctions = {
                    ["checksum_based_on_item_and_timestamp"] = {
                        itemID = 18608,
                        HighestBids = {
                            {
                                {
                                    name = "Zhorax",
                                    class = "druid",
                                    bid = 5500,
                                    createdAt = 1659816523,
                                },
                                {
                                    name = "Arvada",
                                    class = "warlock",
                                    bid = 5000,
                                    createdAt = 1659816511,
                                },
                                {
                                    name = "Feth",
                                    class = "warrior",
                                    bid = 3500,
                                    createdAt = 1659816507,
                                }
                            }
                        },
                        PreviousStates = {
                            ["checksum"] = {
                                createdAt = 1659817021,
                                Winner = {
                                    name = "Zhorax",
                                    class = "priest",
                                    guild = "Gargul",
                                    realm = "Firemaw",
                                },
                                price = 4000,
                                reason = "Master Looter made a mistake",
                                CreatedBy = {
                                    class = "druid",
                                    name = "Garguldruid",
                                    guild = "Gargul",
                                    uuid = "Player-4467-02A4245A",
                                },
                            }
                        },
                    },
                    ["checksum_based_on_item_and_timestamp_2"] = {
                        itemID = 18608,
                        Winner = {
                            name = "Arvada",
                            class = "Warlock",
                            guild = "Gargul",
                            realm = "Firemaw",
                        },
                        price = 3600,
                        HighestBids = {
                            {
                                {
                                    Bidder = {
                                        name = "Zhorax",
                                        class = "priest",
                                        guild = "Gargul",
                                        realm = "Firemaw",
                                    },
                                    bid = 4000,
                                    createdAt = 1659816523,
                                },
                                {
                                    Bidder = {
                                        name = "Arvada",
                                        class = "Warlock",
                                        guild = "Gargul",
                                        realm = "Firemaw",
                                    },
                                    bid = 3900,
                                    createdAt = 1659816511,
                                },
                                {
                                    Bidder = {
                                        name = "Feth",
                                        class = "warrior",
                                        guild = "Gargul",
                                        realm = "Firemaw",
                                    },
                                    bid = 3500,
                                    createdAt = 1659816507,
                                }
                            }
                        },
                        PreviousStates = {
                            ["checksum"] = {
                                createdAt = 1659817021,
                                Winner = {
                                    name = "Zhorax",
                                    class = "druid",
                                    guild = "Gargul",
                                    realm = "Firemaw",
                                },
                                price = 4000,
                                reason = "Arvada was driving up price with 0 intent to buy",
                                CreatedBy = {
                                    class = "druid",
                                    name = "Garguldruid",
                                    guild = "Gargul",
                                    uuid = "Player-4467-02A4245A",
                                },
                            }
                        },
                    },
                    ["checksum_based_on_item_and_timestamp_3"] = {
                        itemID = 33222,
                        Winner = {
                            name = "Arvada",
                            class = "warlock",
                            guild = "Gargul",
                            realm = "Firemaw",
                        },
                        price = 2500,
                        CreatedBy = {
                            class = "druid",
                            name = "Garguldruid",
                            guild = "Gargul",
                            uuid = "Player-4467-02A4245A",
                        },
                    },
                },
            },
            ["checksum_based_on_createdAt_and_uuid_2"] = {
                ID = "checksum_based_on_createdAt_and_uuid_2",
                title = "Mount Hyjal",
                createdAt = 1659816103,
                CreatedBy = {
                    class = "rogue",
                    name = "Gargultest",
                    guild = "Gargul",
                    uuid = "Player-4467-02A4245A",
                },
                Auctions = {
                    ["checksum_based_on_item_and_timestamp"] = {
                        ID = "checksum_based_on_item_and_timestamp",
                        itemID = 18608,
                        Winner = {
                            name = "Zhorax",
                            class = "druid",
                            guild = "Gargul",
                            realm = "Firemaw",
                        },
                        price = 1200,
                        HighestBids = {
                            {
                                {
                                    Bidder = {
                                        name = "Zhorax",
                                        class = "warlock",
                                        guild = "Gargul",
                                        realm = "Firemaw",
                                    },
                                    class = "druid",
                                    bid = 5500,
                                    createdAt = 1659816523,
                                },
                                {
                                    Winner = {
                                        name = "Arvada",
                                        class = "warlock",
                                        guild = "Gargul",
                                        realm = "Firemaw",
                                    },
                                    bid = 5000,
                                    createdAt = 1659816511,
                                },
                                {
                                    Winner = {
                                        name = "Feth",
                                        class = "Warrior",
                                        guild = "Gargul",
                                        realm = "Firemaw",
                                    },
                                    bid = 3500,
                                    createdAt = 1659816507,
                                }
                            }
                        }
                    },
                    ["checksum_based_on_item_and_timestamp_2"] = {
                        itemID = 18608,
                        Winner = {
                            name = "Zhorax",
                            class = "druid",
                            guild = "Gargul",
                            realm = "Firemaw",
                        },
                        price = 3800,
                        HighestBids = {
                            {
                                {
                                    Winner = {
                                        name = "Zhorax",
                                        class = "druid",
                                        guild = "Gargul",
                                        realm = "Firemaw",
                                    },
                                    bid = 4000,
                                    createdAt = 1659816523,
                                },
                                {
                                    Winner = {
                                        name = "Arvada",
                                        class = "warlock",
                                        guild = "Gargul",
                                        realm = "Firemaw",
                                    },
                                    guild = "Gargul",
                                    bid = 3900,
                                    createdAt = 1659816511,
                                },
                                {
                                    Winner = {
                                        name = "Feth",
                                        class = "warrior",
                                        guild = "Gargul",
                                        realm = "Firemaw",
                                    },
                                    bid = 3500,
                                    createdAt = 1659816507,
                                }
                            }
                        },
                        PreviousStates = {
                            ["checksum"] = {
                                createdAt = 1659817021,
                                Winner = {
                                    name = "Zhorax",
                                    class = "druid",
                                    guild = "Gargul",
                                    realm = "Firemaw",
                                },
                                price = 4000,
                                reason = "Master Looter made a mistake",
                            }
                        },
                    },
                    ["checksum_based_on_item_and_timestamp_3"] = {
                        itemID = 33222,
                        Winner = {
                            name = "Arvada",
                            class = "warlock",
                            guild = "Gargul",
                            realm = "Firemaw",
                        },
                        price = 2700,
                    },
                    ["checksum_based_on_item_and_timestamp_4"] = {
                        itemID = 33251,
                        Winner = {
                            name = "Feth",
                            class = "warrior",
                            guild = "Slow and Steady",
                            realm = "Firemaw",
                        },
                        price = 6969,
                    },
                },
            },
        },
    };

    GargulDB.GDKP = GL.DB.GDKP;
end

--- Make sure the database persists between sessions
--- This is just a safety precaution and should strictly
--- speaking not be necessary, but hey you never know!
function DB:store()
    GL:debug("DB:store");

    GargulDB.AwardHistory = GL.DB.AwardHistory;
    GargulDB.BoostedRolls = GL.DB.BoostedRolls;
    GargulDB.GDKP = GL.DB.GDKP;
    GargulDB.LoadDetails = GL.DB.LoadDetails;
    GargulDB.LootPriority = GL.DB.LootPriority;
    GargulDB.MinimapButton = GL.DB.MinimapButton;
    GargulDB.PlusOnes = GL.DB.PlusOnes;
    GargulDB.Settings = GL.Settings.Active;
    GargulDB.SoftRes = GL.DB.SoftRes;
    GargulDB.TMB = GL.DB.TMB;
end

-- Get a value from the database, or return a default if it doesn't exist
function DB:get(keyString, default)
    return GL:tableGet(DB, keyString, default);
end

-- Set a database value by a given key and value
function DB:set(keyString, value)
    return GL:tableSet(DB, keyString, value);
end

-- Reset the tables
function DB:reset()
    GL:debug("DB:reset");

    self.AwardHistory = {};
    self.BoostedRolls = {};
    self.GDKP = {};
    self.LoadDetails = {};
    self.LootPriority = {};
    self.MinimapButton = {};
    self.PlusOnes = {};
    self.Settings = {};
    self.SoftRes = {};
    self.TMB = {};

    GL:success("Tables reset");
end

GL:debug("DB.lua");