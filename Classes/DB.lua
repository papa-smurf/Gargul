--[[
    This class handles the addon's SavedVariables tables

    This class also provides functionality for
    compressing/decompressing our tables and checking their integrity
]]

local _, App = ...;

App.DB = {
    initialized = false,
    Characters = {},
    LootHistory = {},
    LootPriority = {},
    Settings = {},
    SoftReserves = {},
};

local DB = App.DB;
local Utils = App.Utils;
local Constants = App.Data.Constants;

function DB:_init()
    Utils:debug("DB:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    if (not GargulDB or not type(GargulDB) == "table") then
        -- Global SavedVariables database variable
        GargulDB = {};
    end

    -- Prepare our database tables
    GargulDB.Characters = GargulDB.Characters or {};
    GargulDB.LootHistory = GargulDB.LootHistory or {};
    GargulDB.LootPriority = GargulDB.LootPriority or {};
    GargulDB.Settings = GargulDB.Settings or {};
    GargulDB.SoftReserves = GargulDB.SoftReserves or {};

    -- Provide a shortcut for each table
    self.Characters = GargulDB.Characters;
    self.LootHistory = GargulDB.LootHistory;
    self.LootPriority = GargulDB.LootPriority;
    self.Settings = GargulDB.Settings;
    self.SoftReserves = GargulDB.SoftReserves;

    -- Fire DB:store before every logout/reload/exit
    self.logoutEvent = CreateFrame("FRAME");
    self.logoutEvent:RegisterEvent("PLAYER_LOGOUT");
    self.logoutEvent:SetScript("OnEvent", self.store);

    self._initialized = true;
end

-- Make sure the database persists between sessions
-- This is just a safety precaution and should strictly
-- speaking not be necessary, but hey you never know!
function DB:store()
    Utils:debug("DB:store");

    GargulDB.Characters = App.DB.Characters;
    GargulDB.LootHistory = App.DB.LootHistory;
    GargulDB.LootPriority = App.DB.LootPriority;
    GargulDB.Settings = App.Settings.Active;
    GargulDB.SoftReserves = App.DB.SoftReserves;
end

-- Checks if all of our tables are valid
function DB:isValid()
    Utils:debug("DB:validateTables");

    local messages = {};

    local charactersTableIsValid, message = self:charactersTableIsValid();

    if (not charactersTableIsValid) then
        messages[1] = "Your characters table is invalid with reason: '" .. message .. "'";
        return false, messages;
    end

    local lootHistoryTableIsValid, message = self:lootHistoryTableIsValid();

    if (not lootHistoryTableIsValid) then
        messages[#messages + 1] = "Your loot history table is invalid with reason: '" .. message .. "'";
        return false, messages;
    end

    return true, "";
end

-- Assert that the SavedVariables.Characters table or
-- the table provided is a valid Characters table
function DB:charactersTableIsValid(table)
    Utils:debug("DB:charactersTableIsValid");

    table = table or self.Characters;

    if (false) then
        return false, "something went wrong";
    end

    -- TODO: check
    return true, "";
end

-- Assert that the SavedVariables.LootHistory table or
-- the table provided is a valid LootHistory table
function DB:lootHistoryTableIsValid(table)
    Utils:debug("DB:lootHistoryTableIsValid");

    table = table or self.LootHistory;

    if (false) then
        return false, "something went wrong";
    end

    -- TODO: check
    return true, "";
end

-- Compress the Characters table to its bare minimum
-- Classes are replaced by numbers, see App.Data.Constants.Classes
function DB:compressCharactersTable()
    Utils:debug("DB:compressCharactersTable");

    local Characters = {};
    for name, value in pairs(self.Characters) do
        Characters[#Characters + 1] = {
            name,
            App.Data.Constants.Classes[value.class],
            value.dkp,
            value.gained,
            value.spent,
            value.raids,
        };
    end

    return Characters;
end

-- Decompress a compressed Characters table (usually provided via broadcast)
function DB:decompressCharactersTable(compressedTable)
    Utils:debug("DB:decompressCharactersTable");

    local nameIndex = 1;
    local classIndex = 2;
    local dkpIndex = 3;
    local gainedIndex = 4;
    local spentIndex = 5;
    local raidsIndex = 6;

    local classesById = {};
    for class, id in pairs(App.Data.Constants.Classes) do
        classesById[id] = class;
    end

    local Decompressed = {};
    for _, value in pairs(compressedTable) do
        Decompressed[value[nameIndex]] = {
            class = classesById[value[classIndex]],
            dkp = value[dkpIndex],
            gained = value[gainedIndex],
            spent = value[spentIndex],
            raids = value[raidsIndex],
        };
    end

    return Decompressed;
end

-- Compress a loot history table to its bare minimum
-- ItemLinks are ommited and names are only passed once with a reference number
function DB:compressLootHistoryTable()
    Utils:debug("DB:compressLootHistoryTable");

    local names = {};
    local numberOfNames = 0;
    local lootHistory = {{},{}};

    for timestamp, entry in pairs(self.LootHistory) do
        local winner = entry.player;

        if (not names[winner]) then
            numberOfNames = numberOfNames + 1;
            names[winner] = numberOfNames;
        end

        local Item = {
            entry.id,
            names[winner],
            entry.dkp,
            tonumber(timestamp), -- Number is shorter than string because of quotes
            {},
        };

        if (entry.bids) then
            local numberOfBids = 0;
            for _, bid in pairs(entry.bids) do
                -- There are no continue statements in lua and it sucks ass
                if (bid) then
                    local bidder = bid.player;
                    if (not names[bidder]) then

                        numberOfNames = numberOfNames + 1;
                        names[bidder] = numberOfNames;
                    end

                    Item[#Item][numberOfBids + 1] = {
                        names[bidder],
                        bid.dkp,
                    };

                    numberOfBids = numberOfBids + 1;
                end
            end
        end

        lootHistory[1][#lootHistory[1] + 1] = Item;
    end

    -- Revert the names table from NAME => ID to ID => NAME
    local namesByNumber = {};
    for name in pairs(names) do
        namesByNumber[names[name]] = name;
    end

    lootHistory[2] = namesByNumber;

    return lootHistory;
end

-- Decompress a compressed LootHistory table (usually provided via broadcast)
function DB:decompressLootHistoryTable(compressedTable)
    Utils:debug("DB:decompressLootHistoryTable");

    local idIndex = 1;
    local playerIndex = 2;
    local dkpIndex = 3;
    local timestampIndex = 4;
    local bidsIndex = 5;
    local bidPlayerIndex = 1;
    local bidDkpIndex = 2;

    local Decompressed = {};
    local CompressedLootHistory = compressedTable[1];
    local names = compressedTable[2];

    for item in pairs(CompressedLootHistory) do
        local timestamp = tostring(CompressedLootHistory[item][timestampIndex]);

        local Item = {
            id = CompressedLootHistory[item][idIndex],
            player = names[CompressedLootHistory[item][playerIndex]],
            dkp = CompressedLootHistory[item][dkpIndex],
            bids = {},
        };

        if (CompressedLootHistory[item][bidsIndex]) then
            local bids = CompressedLootHistory[item][bidsIndex];
            for bid in pairs(bids) do
                Item.bids[#Item.bids + 1] = {
                    player = names[bids[bid][bidPlayerIndex]],
                    dkp = bids[bid][bidDkpIndex],
                };
            end
        end

        Decompressed[timestamp] = Item;
    end

    return Decompressed;
end

-- Add the item title and link to items that don't have them yet
function DB:lootHistoryTableFillMetadata()
    Utils:debug("DB:lootHistoryTableFillMetadata");

    for key, item in pairs(self.LootHistory) do
        if (not item.title or not item.link) then
            item.title, item.link = GetItemInfo(item.id);
        end
    end
end

-- Reset the tables
function DB:resetCharactersAndLoot()
    Utils:debug("DB:resetCharactersAndLoot");

    self.Characters = {};
    self.LootHistory = {};
end

Utils:debug("DB.lua");