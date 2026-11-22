---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field, need-check-nil

local L = Gargul_L;

assert(GL.Tests.E2E and GL.Tests.E2E.PackMuleBase, "GL.Tests.E2E.PackMuleBase missing (TOC: Tests/E2E/PackMuleBase.lua before this file)");

local PackMuleBase = GL.Tests.E2E.PackMuleBase;
local fragment = PackMuleBase.fragment;

local TARGET = "PackMuleTarget";
local BACKUP = "PackMuleBackup";

local ITEM_IDS = {
    6948, -- Hearthstone
    25, -- Worn Shortsword
    35, -- Bent Staff
    36, -- Worn Mace
    159, -- Refreshing Spring Water
    117, -- Tough Jerky
};

local MESSAGE_BY_REASON = {
    bagsFull = L["%s's bags are full (%s)"],
    unique = L["%s already has the maximum number of: %s"],
    outOfRange = L["%s is out of range (%s)"],
    notEligible = L["%s is no longer eligible for: %s"],
    other = L["Could not give %s to %s"],
};

local COULD_NOT_GIVE = fragment(L["Could not give %s to %s"]);

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

---@param itemIDs table
---@return table
local function buildItems(itemIDs)
    local Items = {};
    for _, itemID in ipairs(itemIDs) do
        table.insert(Items, { id = itemID, });
    end

    return Items;
end

local SIX_ITEM_HANDOUTS = {};
for _, itemID in ipairs(ITEM_IDS) do
    SIX_ITEM_HANDOUTS[itemID] = TARGET;
end

local CASES = {
    --[[ SUCCESS ]]
    {
        title = "Six items over two loot pages are handed out",
        arrange = function (_, Loot)
            Loot.successLatency = .3;
        end,
        rules = itemRules(TARGET, unpack(ITEM_IDS)),
        items = buildItems(ITEM_IDS),
        afterOpen = function (_, Loot)
            if (#Loot:visibleSlots() ~= 4) then
                return "the first loot page should show four buttons";
            end

            Loot:setPage(2);
            if (#Loot:visibleSlots() ~= 2) then
                return "the second loot page should show the remaining two buttons";
            end
            Loot:setPage(1);
        end,
        settle = 1.5,
        expect = { handouts = SIX_ITEM_HANDOUTS, },
    },
    {
        title = "Slow server success doesn't report a failure",
        arrange = function (_, Loot)
            Loot.successLatency = .9;
        end,
        rules = itemRules(TARGET, 25),
        items = buildItems({ 25, }),
        settle = 2.6,
        expect = { handouts = { [25] = TARGET, }, },
    },
};

--[[ ERROR CATEGORIES ]]
for _, reason in ipairs({ "bagsFull", "unique", "outOfRange", "notEligible", "other", }) do
    table.insert(CASES, {
        title = ("Loot error '%s' is reported once"):format(reason),
        arrange = function (_, Loot)
            Loot:failHandoutForItem(117, reason);
        end,
        rules = itemRules(TARGET, 117),
        items = buildItems({ 117, }),
        expect = {
            remaining = { 117, },
            errors = { { player = TARGET, reason = reason, items = 1, }, },
            messages = {
                { text = fragment(MESSAGE_BY_REASON[reason]), level = "error", count = 1, },
                { level = "alert", count = 1, },
            },
        },
    });
end

for _, Case in ipairs({
    {
        title = "Failures for one player are batched into one message",
        arrange = function (_, Loot)
            Loot:failHandoutForItem(117, "bagsFull");
            Loot:failHandoutForItem(159, "bagsFull");
        end,
        rules = itemRules(TARGET, 117, 159),
        items = buildItems({ 117, 159, }),
        expect = {
            remaining = { 117, 159, },
            errors = { { player = TARGET, reason = "bagsFull", items = 2, }, },
            messages = { { text = fragment(MESSAGE_BY_REASON.bagsFull), level = "error", count = 1, }, },
        },
        check = function (_, Loot)
            local Message;
            for _, Entry in ipairs(Loot.messages) do
                if (Entry.level == "error") then
                    Message = Entry;
                end
            end

            for _, Item in ipairs(Loot.items) do
                if (not strfind(Message.text, Item.link, 1, true)) then
                    return ("batched message is missing %s"):format(Item.link);
                end
            end
        end,
    },
    {
        title = "A failure retried by the loot timer is reported once",
        arrange = function (_, Loot)
            Loot:failHandoutForItem(117, "bagsFull");
        end,
        rules = itemRules(TARGET, 117),
        items = buildItems({ 117, }),
        settle = 3,
        expect = {
            remaining = { 117, },
            errors = { { player = TARGET, reason = "bagsFull", items = 1, }, },
            messages = {
                { text = fragment(MESSAGE_BY_REASON.bagsFull), level = "error", count = 1, },
                { level = "alert", count = 1, },
            },
        },
        check = function (_, Loot)
            local attempts = Loot:handoutAttempts(117);
            if (attempts < 5) then
                return ("expected the loot timer to retry the handout, got %d attempts"):format(attempts);
            end
        end,
    },
    {
        title = "Delayed errors are matched to handouts in order",
        arrange = function (_, Loot)
            Loot.failureLatency = .3;
            Loot:failHandoutForItem(35, "bagsFull");
            Loot:failHandoutForItem(25, "unique");
        end,
        rules = {
            { item = "25", target = BACKUP, },
            { item = "35", target = TARGET, },
        },
        items = buildItems({ 25, 35, }),
        expect = {
            remaining = { 25, 35, },
            errors = {
                { player = TARGET, reason = "bagsFull", },
                { player = BACKUP, reason = "unique", },
            },
            messages = {
                { text = fragment(MESSAGE_BY_REASON.bagsFull), level = "error", count = 1, },
                { text = fragment(MESSAGE_BY_REASON.unique), level = "error", count = 1, },
            },
        },
    },
    {
        title = "Silent failure falls back to still-in-window",
        arrange = function (_, Loot)
            Loot:silentFailHandoutForItem(159);
        end,
        rules = itemRules(TARGET, 159),
        items = buildItems({ 159, }),
        settle = 2.5,
        expect = {
            remaining = { 159, },
            errors = { { player = TARGET, reason = "stillInWindow", }, },
            messages = { { text = COULD_NOT_GIVE, level = "error", count = 1, }, },
        },
    },
    {
        title = "Unrelated UI errors don't resolve a handout",
        arrange = function (_, Loot)
            Loot:failHandoutForItem(117, "unrelated");
        end,
        rules = itemRules(TARGET, 117),
        items = buildItems({ 117, }),
        settle = 2.5,
        expect = {
            remaining = { 117, },
            errors = { { player = TARGET, reason = "stillInWindow", }, },
            messages = { { text = COULD_NOT_GIVE, level = "error", count = 1, }, },
        },
    },

    --[[ LOOT_CLOSED ]]
    {
        title = "Closing the window cancels pending handouts",
        arrange = function (_, Loot)
            Loot:silentFailHandoutForItem(25);
        end,
        rules = itemRules(TARGET, 25),
        items = buildItems({ 25, }),
        settle = 2.6,
        poll = function (_, Loot, elapsed, State)
            if (State.closedAt or elapsed < .5) then
                return;
            end

            if (GL:empty(GL.PackMule.PendingHandouts)) then
                return;
            end

            Loot:close();
            State.closedAt = GetTime();
        end,
        ready = function (_, _, State)
            return State.closedAt ~= nil and GetTime() - State.closedAt >= 2, "2 seconds after closing with a pending handout";
        end,
        expect = { remaining = { 25, }, },
        check = function ()
            if (not GL:empty(GL.PackMule.PendingHandouts)) then
                return "pending handouts were not cleared on LOOT_CLOSED";
            end

            if (GL.PackMule.LootChangedTimer) then
                return "LootChangedTimer still running after LOOT_CLOSED";
            end
        end,
    },
    {
        title = "Closing the window flushes pending error reports",
        arrange = function (_, Loot)
            Loot:failHandoutForItem(117, "bagsFull");
        end,
        rules = itemRules(TARGET, 117),
        items = buildItems({ 117, }),
        pollInterval = .1,
        settle = 1.5,
        poll = function (_, Loot, _, State)
            if (State.closed or GL:empty(GL.PackMule.LootErrors)) then
                return;
            end

            if (Loot:countMessages(nil, "error") > 0) then
                return "the error was flushed before the window closed, can't verify the close flush";
            end

            Loot:close();
            State.closed = true;

            if (Loot:countMessages(nil, "error") ~= 1) then
                return "pending error report wasn't flushed on LOOT_CLOSED";
            end
        end,
        ready = function (_, _, State)
            return State.closed == true, "an error report to be pending";
        end,
        expect = {
            remaining = { 117, },
            messages = { { text = fragment(MESSAGE_BY_REASON.bagsFull), level = "error", count = 1, }, },
        },
        check = function ()
            if (not GL:empty(GL.PackMule.LootErrors)) then
                return "LootErrors were not wiped on LOOT_CLOSED";
            end
        end,
    },
}) do
    table.insert(CASES, Case);
end

---@class PackMuleE2E : PackMuleE2EBase
local E2E = PackMuleBase:extend({
    scenarioName = "PackMule",
    label = "PackMule Handout & Errors E2E",
    CASES = CASES,
});
GL.Tests.E2E.PackMule = E2E; ---@type PackMuleE2E

return E2E;
