---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field, need-check-nil

local L = Gargul_L;

assert(GL.Tests.E2E and GL.Tests.E2E.PackMuleBase, "GL.Tests.E2E.PackMuleBase missing (TOC: Tests/E2E/PackMuleBase.lua before this file)");

local PackMuleBase = GL.Tests.E2E.PackMuleBase;

local TARGET = "PackMuleTarget";
local BACKUP = "PackMuleBackup";
local OFFLINE = { name = "PackMuleOffline", online = false, };
local BIND_NONE = GL.LE_ITEM_BIND_NONE;
local BIND_PICKUP = GL.LE_ITEM_BIND_ON_ACQUIRE;
local RAID = { isInRaid = true, isInParty = false, };
local PARTY = { isInRaid = false, isInParty = true, };

---@param itemID number
---@param quality number
---@param Extra? table
---@return table
local function boe(itemID, quality, Extra)
    local Item = { id = itemID, quality = quality, bindType = BIND_NONE, };
    for key, value in pairs(Extra or {}) do
        Item[key] = value;
    end

    return Item;
end

---@param target string
---@vararg number
---@return table
local function itemRules(target, ...)
    local Rules = {};
    for _, itemID in ipairs({ ... }) do
        table.insert(Rules, { item = tostring(itemID), target = target, });
    end

    return Rules;
end

---@param operator string
---@param quality number
---@param target string
---@return table
local function qualityRule(operator, quality, target)
    return { operator = operator, quality = quality, target = target, };
end

local NAMED_ITEMS = {
    { id = 25, name = "Worn Test Blade", },
    { id = 35, name = "Bent Test Staff", },
    { id = 117, name = "Tough Test Jerky", },
    { id = 159, name = "Fresh Spring Water", },
};

local CASES = {
    --[[ RULE TYPES ]]
    {
        title = "Item-ID rule hands out the matching item",
        rules = itemRules(TARGET, 25),
        items = { { id = 25, }, { id = 35, }, },
        expect = { handouts = { [25] = TARGET, }, untouched = { 35, }, },
    },
    {
        title = "Item-name rule matches case-insensitively",
        rules = { { item = "worn TEST blade", target = TARGET, }, },
        items = NAMED_ITEMS,
        expect = { handouts = { [25] = TARGET, }, untouched = { 35, 117, 159, }, },
    },
    {
        title = "Wildcard Worn* matches names starting with Worn",
        rules = { { item = "Worn*", target = TARGET, }, },
        items = NAMED_ITEMS,
        expect = { handouts = { [25] = TARGET, }, untouched = { 35, 117, 159, }, },
    },
    {
        title = "Wildcard *Jerky matches names ending in Jerky",
        rules = { { item = "*Jerky", target = TARGET, }, },
        items = NAMED_ITEMS,
        expect = { handouts = { [117] = TARGET, }, untouched = { 25, 35, 159, }, },
    },
    {
        title = "Wildcard *Spring* matches names containing Spring",
        rules = { { item = "*Spring*", target = TARGET, }, },
        items = NAMED_ITEMS,
        expect = { handouts = { [159] = TARGET, }, untouched = { 25, 35, 117, }, },
    },
};

--[[ QUALITY OPERATORS ]]
local QUALITY_ITEMS = { boe(25, 0), boe(35, 1), boe(36, 2), boe(117, 3), boe(159, 4), };
for _, Operator in ipairs({
    { operator = "=", handed = { 36, }, },
    { operator = ">", handed = { 117, 159, }, },
    { operator = ">=", handed = { 36, 117, 159, }, },
    { operator = "<", handed = { 25, 35, }, },
    { operator = "<=", handed = { 25, 35, 36, }, },
}) do
    local Handouts, Untouched = {}, {};
    for _, Item in ipairs(QUALITY_ITEMS) do
        if (GL:inTable(Operator.handed, Item.id)) then
            Handouts[Item.id] = TARGET;
        else
            table.insert(Untouched, Item.id);
        end
    end

    table.insert(CASES, {
        title = ("Quality rule %s uncommon"):format(Operator.operator),
        rules = { qualityRule(Operator.operator, 2, TARGET), },
        items = QUALITY_ITEMS,
        expect = { handouts = Handouts, untouched = Untouched, },
    });
end

for _, Case in ipairs({
    --[[ PRECEDENCE ]]
    {
        title = "Item-ID rule beats a quality rule",
        rules = { qualityRule(">=", 0, TARGET), { item = "25", target = BACKUP, }, },
        items = { boe(25, 2), boe(35, 2), },
        expect = { handouts = { [25] = BACKUP, [35] = TARGET, }, },
    },
    {
        title = "IGNORE item rule suppresses a quality rule",
        rules = { qualityRule(">=", 0, TARGET), { item = "25", target = L["IGNORE"], }, },
        items = { boe(25, 2), boe(35, 2), },
        expect = { handouts = { [35] = TARGET, }, untouched = { 25, }, },
    },

    --[[ TARGETS ]]
    {
        title = "Comma-separated targets hand out to any of them",
        rules = itemRules(("%s, %s"):format(TARGET, BACKUP), 25, 35, 36),
        items = { { id = 25, }, { id = 35, }, { id = 36, }, },
        expect = { handouts = { [25] = { TARGET, BACKUP, }, [35] = { TARGET, BACKUP, }, [36] = { TARGET, BACKUP, }, }, },
    },
    {
        title = "Comma-separated targets skip players outside the group",
        rules = itemRules(("PackMuleStranger, %s"):format(TARGET), 25, 35),
        items = { { id = 25, }, { id = 35, }, },
        expect = { handouts = { [25] = TARGET, [35] = TARGET, }, },
    },
    {
        title = "Priority target (!) always wins",
        rules = itemRules(("%s, %s!"):format(TARGET, BACKUP), 25, 35, 36),
        items = { { id = 25, }, { id = 35, }, { id = 36, }, },
        expect = { handouts = { [25] = BACKUP, [35] = BACKUP, [36] = BACKUP, }, },
    },
    {
        title = "Space-separated targets (legacy rules) hand out to any of them",
        requires = function () return not GL.isForever; end,
        skipReason = "Forever treats a comma-less rule as one name (see PackMule Forever E2E)",
        rules = itemRules(("%s %s"):format(TARGET, BACKUP), 25, 35),
        items = { { id = 25, }, { id = 35, }, },
        expect = { handouts = { [25] = { TARGET, BACKUP, }, [35] = { TARGET, BACKUP, }, }, },
    },
    {
        title = "SELF goes to the master looter",
        rules = itemRules(L["SELF"], 25),
        items = { { id = 25, }, },
        expect = { handouts = { [25] = "SELF", }, },
    },
    {
        title = "DE goes to the disenchanter",
        arrange = function (E2E)
            GL.PackMule.disenchanter = E2E:playerFQN(BACKUP);
        end,
        rules = itemRules(L["DE"], 25),
        items = { { id = 25, }, },
        expect = { handouts = { [25] = BACKUP, }, },
    },
    {
        title = "DE without a disenchanter leaves the item and warns once",
        rules = itemRules(L["DE"], 25),
        items = { { id = 25, }, },
        settle = 1.5,
        expect = {
            untouched = { 25, },
            messages = { { text = L["No disenchanter set, use /gl sd [mydisenchanter] to set one"], level = "warning", count = 1, }, },
        },
    },
    {
        title = "RR spreads identical items over online players",
        players = { TARGET, BACKUP, OFFLINE, },
        rules = itemRules(L["RR"], 25),
        items = { { id = 25, }, { id = 25, }, { id = 25, }, },
        expect = { handouts = { [25] = { "SELF", TARGET, BACKUP, }, }, },
        check = function (_, Loot)
            local Seen = {};
            for _, Handout in ipairs(Loot:handoutsByItemID()[25] or {}) do
                if (Handout.result == "success") then
                    if (Seen[Handout.player]) then
                        return ("%s received more than one item"):format(Handout.player);
                    end
                    Seen[Handout.player] = true;
                end
            end

            if (GL:count(Seen) ~= 3) then
                return ("expected 3 different players, got %d"):format(GL:count(Seen));
            end
        end,
    },
    {
        title = "RANDOM never picks an offline player",
        players = { TARGET, BACKUP, OFFLINE, },
        rules = { qualityRule(">=", 0, L["RANDOM"]), },
        items = QUALITY_ITEMS,
        expect = {
            handouts = {
                [25] = { "SELF", TARGET, BACKUP, },
                [35] = { "SELF", TARGET, BACKUP, },
                [36] = { "SELF", TARGET, BACKUP, },
                [117] = { "SELF", TARGET, BACKUP, },
                [159] = { "SELF", TARGET, BACKUP, },
            },
        },
    },
    {
        title = "Target outside the group is skipped",
        rules = itemRules("PackMuleStranger", 25),
        items = { { id = 25, }, },
        expect = { untouched = { 25, }, },
    },
    {
        title = "Target that isn't a loot candidate is skipped",
        arrange = function (_, Loot)
            Loot:setIneligible(25, TARGET);
        end,
        rules = itemRules(TARGET, 25, 35),
        items = { { id = 25, }, { id = 35, }, },
        expect = { handouts = { [35] = TARGET, }, untouched = { 25, }, },
    },

    --[[ FILTERS ]]
    {
        title = "Bind-on-pickup is skipped in a party",
        user = PARTY,
        rules = { qualityRule(">=", 0, TARGET), },
        items = { boe(25, 2, { bindType = BIND_PICKUP, }), boe(35, 2), },
        expect = { handouts = { [35] = TARGET, }, untouched = { 25, }, },
    },
    {
        title = "Bind-on-pickup is handed out in a raid",
        user = RAID,
        rules = { qualityRule(">=", 0, TARGET), },
        items = { boe(25, 2, { bindType = BIND_PICKUP, }), boe(35, 2), },
        expect = { handouts = { [25] = TARGET, [35] = TARGET, }, },
    },
    {
        title = "Legendary: skipped by quality rule, handed out by item-ID rule",
        rules = { qualityRule(">=", 0, TARGET), { item = "35", target = BACKUP, }, },
        items = { boe(25, 5), boe(35, 5), },
        expect = { handouts = { [35] = BACKUP, }, untouched = { 25, }, },
    },
    {
        title = "Untradable item is skipped by a quality rule",
        rules = { qualityRule(">=", 0, TARGET), },
        items = { boe(22726, 4, { name = "Splinter of Atiesh", }), boe(25, 2), },
        expect = { handouts = { [25] = TARGET, }, untouched = { 22726, }, },
    },
    {
        title = "Tradable whitelist overrides bind-on-pickup in a party",
        user = PARTY,
        rules = { qualityRule(">=", 0, TARGET), },
        items = { boe(19716, 4, { name = "Primal Hakkari Bindings", bindType = BIND_PICKUP, }), },
        expect = { handouts = { [19716] = TARGET, }, },
    },
    {
        title = "Bind-on-pickup recipe is skipped, BoE recipe is not",
        user = RAID,
        rules = { qualityRule(">=", 0, TARGET), },
        items = {
            boe(25, 2, { bindType = BIND_PICKUP, classID = GL.LE_ITEM_CLASS_RECIPE, }),
            boe(35, 2, { classID = GL.LE_ITEM_CLASS_RECIPE, }),
        },
        expect = { handouts = { [35] = TARGET, }, untouched = { 25, }, },
    },

    --[[ GUARDS ]]
    {
        title = "Nothing happens when PackMule is disabled",
        settings = { ["PackMule.enabledForMasterLoot"] = false, },
        rules = itemRules(TARGET, 25),
        items = { { id = 25, }, },
        expect = { untouched = { 25, }, },
    },
    {
        title = "Holding Shift pauses PackMule",
        arrange = function (_, Loot)
            Loot:setShiftDown(true);
        end,
        rules = itemRules(TARGET, 25),
        items = { { id = 25, }, },
        expect = { untouched = { 25, }, },
    },
    {
        title = "Only the master looter hands out loot",
        user = { isMasterLooter = false, },
        rules = itemRules(TARGET, 25),
        items = { { id = 25, }, },
        expect = { untouched = { 25, }, },
    },
    {
        title = "Locked slots are skipped",
        rules = itemRules(TARGET, 25, 35, 36),
        items = { { id = 25, }, { id = 35, locked = true, }, { id = 36, }, },
        expect = { handouts = { [25] = TARGET, [36] = TARGET, }, untouched = { 35, }, },
    },

    --[[ GOLD ]]
    {
        title = "Gold is looted when lootGold is enabled",
        settings = { ["PackMule.lootGold"] = true, },
        items = { { money = true, name = "12 Silver", }, { id = 25, }, },
        ready = function (_, Loot)
            return Loot:moneyLooted(), "the gold to be looted";
        end,
        expect = { untouched = { 25, }, },
    },
    {
        title = "Gold is left when lootGold is disabled",
        items = { { money = true, name = "12 Silver", }, },
        check = function (_, Loot)
            if (Loot:moneyLooted()) then
                return "gold was looted";
            end
        end,
    },
    {
        title = "Gold from a lockbox is left alone",
        settings = { ["PackMule.lootGold"] = true, },
        items = { { money = true, name = "12 Silver", source = "Item-0-0-0-0000000000", }, },
        check = function (_, Loot)
            if (Loot:moneyLooted()) then
                return "lockbox gold was looted";
            end
        end,
    },

    --[[ LOOT TIMER ]]
    {
        title = "Loot timer runs while looting and stops on close",
        rules = itemRules(TARGET, 25),
        items = { { id = 25, }, },
        afterOpen = function ()
            if (not GL.PackMule.LootChangedTimer) then
                return "LootChangedTimer wasn't scheduled after LOOT_READY";
            end
        end,
        expect = { handouts = { [25] = TARGET, }, },
        check = function (_, Loot)
            if (not GL.PackMule.LootChangedTimer) then
                return "LootChangedTimer stopped while the loot window was open";
            end

            Loot:close();
            if (GL.PackMule.LootChangedTimer) then
                return "LootChangedTimer still running after LOOT_CLOSED";
            end
        end,
    },
    {
        title = "A slot that unlocks later is picked up",
        rules = itemRules(TARGET, 25),
        items = { { id = 25, locked = true, }, },
        settle = 1.6,
        poll = function (_, Loot, elapsed, State)
            if (State.unlocked or elapsed < .8) then
                return;
            end

            if (Loot:handoutAttempts(25) > 0) then
                return "the locked item was handed out";
            end

            Loot:setLocked(1, false);
            State.unlocked = true;
        end,
        ready = function (_, _, State)
            return State.unlocked == true, "the slot to unlock";
        end,
        expect = { handouts = { [25] = TARGET, }, },
    },
    {
        title = "An item added to an open window is picked up",
        rules = itemRules(TARGET, 25, 35),
        items = { { id = 25, }, },
        cacheItems = { 35, },
        settle = 1.6,
        poll = function (_, Loot, elapsed, State)
            if (State.added or elapsed < .8) then
                return;
            end

            Loot:addItem({ id = 35, });
            State.added = true;
        end,
        ready = function (_, _, State)
            return State.added == true, "the item to be added";
        end,
        expect = { handouts = { [25] = TARGET, [35] = TARGET, }, },
    },
}) do
    table.insert(CASES, Case);
end

---@class PackMuleRulesE2E : PackMuleE2EBase
local E2E = PackMuleBase:extend({
    scenarioName = "PackMuleRules",
    label = "PackMule Rules E2E",
    CASES = CASES,
});
GL.Tests.E2E.PackMuleRules = E2E; ---@type PackMuleRulesE2E

return E2E;
