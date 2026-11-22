---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field, need-check-nil

local L = Gargul_L;

assert(GL.Tests.E2E and GL.Tests.E2E.PackMuleBase, "GL.Tests.E2E.PackMuleBase missing (TOC: Tests/E2E/PackMuleBase.lua before this file)");

local PackMuleBase = GL.Tests.E2E.PackMuleBase;
local fragment = PackMuleBase.fragment;

local TARGET = "PackMuleTarget";
local BACKUP = "PackMuleBackup";

local MUTATION_METHODS = { "queueAwardMutation", "queueEditMutation", "queueDeleteMutation", };

---@param E2E PackMuleAwardE2E
---@param _ LootFake
---@param State table
---@return string|nil failure
local function assertNotReceived(E2E, _, State)
    local Entry = E2E:awardEntry(State.checksum);
    if (not Entry) then
        return "award entry is missing";
    end

    if (Entry.received) then
        return "award was marked as received without a handout";
    end
end

local CASES = {
    {
        title = "Awarding with auto-assign hands the item to the winner",
        items = { { id = 25, }, },
        afterOpen = function (E2E, _, State)
            State.checksum = E2E:award(25, TARGET);
            if (not State.checksum) then
                return "addWinner didn't return a checksum";
            end
        end,
        expect = { handouts = { [25] = TARGET, }, },
        check = function (E2E, _, State)
            local Entry = E2E:awardEntry(State.checksum);
            if (not Entry) then
                return "award entry is missing";
            end

            if (not Entry.received) then
                return "award wasn't marked as received after the master loot handout";
            end
        end,
    },
    {
        title = "Auto-assign disabled leaves the item in the window",
        settings = { ["AwardingLoot.autoAssignAfterAwardingAnItem"] = false, },
        items = { { id = 25, }, },
        afterOpen = function (E2E, _, State)
            State.checksum = E2E:award(25, TARGET);
        end,
        expect = { untouched = { 25, }, },
        check = assertNotReceived,
    },
    {
        title = "Awarding an item that isn't in the window does nothing",
        items = { { id = 25, }, },
        cacheItems = { 35, },
        afterOpen = function (E2E, _, State)
            State.checksum = E2E:award(35, TARGET);
        end,
        expect = { untouched = { 25, }, },
        check = assertNotReceived,
    },
    {
        title = "Winner who isn't a loot candidate is skipped",
        arrange = function (_, Loot)
            Loot:setIneligible(25, TARGET);
        end,
        items = { { id = 25, }, },
        afterOpen = function (E2E, _, State)
            State.checksum = E2E:award(25, TARGET);
        end,
        expect = { untouched = { 25, }, },
        check = assertNotReceived,
    },
    {
        title = "Disenchanting sends the item to the disenchanter",
        arrange = function (E2E, Loot)
            GL.PackMule.disenchanter = E2E:playerFQN(BACKUP);
            Loot.successLatency = .3;
        end,
        items = { { id = 25, }, },
        afterOpen = function (_, Loot, State)
            GL.PackMule:disenchant(Loot:itemByID(25).link, true, function (result)
                State.callbackResult = result;
            end);
        end,
        expect = { handouts = { [25] = BACKUP, }, },
        ready = function (E2E, _, State)
            local Entry = E2E:disenchantEntry(State, 25);
            return Entry ~= nil and Entry.received == true, "the disenchant award to be marked as received";
        end,
        check = function (_, _, State)
            if (State.callbackResult ~= true) then
                return "disenchant callback didn't report success";
            end
        end,
    },
    {
        title = "Failed award handout is reported",
        arrange = function (_, Loot)
            Loot:failHandoutForItem(25, "bagsFull");
        end,
        items = { { id = 25, }, },
        afterOpen = function (E2E, _, State)
            State.checksum = E2E:award(25, TARGET);
        end,
        expect = {
            remaining = { 25, },
            errors = { { player = TARGET, reason = "bagsFull", items = 1, }, },
            messages = { { text = fragment(L["%s's bags are full (%s)"]), level = "error", count = 1, }, },
        },
        check = assertNotReceived,
    },
};

---@class PackMuleAwardE2E : PackMuleE2EBase
local E2E = PackMuleBase:extend({
    scenarioName = "PackMuleAward",
    label = "PackMule Award E2E",
    SETTINGS = { ["PackMule.enabledForMasterLoot"] = false, },
    CASES = CASES,
    SavedMutationMethods = nil,
    mutations = {},
});
GL.Tests.E2E.PackMuleAward = E2E; ---@type PackMuleAwardE2E

---@param itemID number
---@param winner string
---@return string|nil checksum
function E2E:award(itemID, winner)
    local Item = GL.Tests.Fakes.Loot:itemByID(itemID);
    local itemLink = Item and Item.link or select(2, GL.GetItemInfo(itemID));

    return GL.AwardedLoot:addWinner({
        winner = self:playerFQN(winner),
        itemLink = itemLink,
        announce = false,
        broadcast = false,
    });
end

---@param checksum? string
---@return table|nil
function E2E:awardEntry(checksum)
    return checksum and GL.DB.AwardHistory[checksum] or nil;
end

---@param State table
---@return table
function E2E:newAwardEntries(State)
    local Entries = {};
    for checksum, Entry in pairs(GL.DB.AwardHistory or {}) do
        if (not State.awardChecksumsBefore[checksum]) then
            table.insert(Entries, Entry);
        end
    end

    return Entries;
end

---@param State table
---@param itemID number
---@return table|nil
function E2E:disenchantEntry(State, itemID)
    for _, Entry in ipairs(self:newAwardEntries(State)) do
        if (Entry.awardedTo == GL.Exporter.disenchantedItemIdentifier and Entry.itemID == itemID) then
            return Entry;
        end
    end
end

--- Award comms are recorded instead of sent, the fake group doesn't exist
---@return nil
function E2E:onSetup()
    self.mutations = {};
    self.SavedMutationMethods = {};

    for _, method in ipairs(MUTATION_METHODS) do
        self.SavedMutationMethods[method] = rawget(GL.AwardedLoot, method);
        GL.AwardedLoot[method] = function (_, ...)
            table.insert(self.mutations, { method = method, args = { ... }, });
        end;
    end
end

---@return nil
function E2E:onTeardown()
    for method, func in pairs(self.SavedMutationMethods or {}) do
        GL.AwardedLoot[method] = func;
    end
    self.SavedMutationMethods = nil;
end

---@param _ table
---@param State table
---@return nil
function E2E:onCaseReset(_, State)
    State.awardChecksumsBefore = {};
    for checksum in pairs(GL.DB.AwardHistory or {}) do
        State.awardChecksumsBefore[checksum] = true;
    end
end

---@param _ table
---@param State table
---@return nil
function E2E:onCaseFinish(_, State)
    if (not State.awardChecksumsBefore) then
        return;
    end

    for _, Entry in ipairs(self:newAwardEntries(State)) do
        GL.AwardedLoot:deleteWinner(Entry.checksum, false, false);
    end
end

return E2E;
