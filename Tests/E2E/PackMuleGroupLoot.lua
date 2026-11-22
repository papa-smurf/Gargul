---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field, need-check-nil

local L = Gargul_L;

assert(GL.Tests.E2E and GL.Tests.E2E.PackMuleBase, "GL.Tests.E2E.PackMuleBase missing (TOC: Tests/E2E/PackMuleBase.lua before this file)");
assert(GL.Tests.Fakes and GL.Tests.Fakes.GroupLoot, "GL.Tests.Fakes.GroupLoot missing (TOC: Tests/Fakes/GroupLoot.lua before this file)");

local PackMuleBase = GL.Tests.E2E.PackMuleBase;
local GroupLoot = GL.Tests.Fakes.GroupLoot;
local Actions = GL.Data.Constants.GroupLootActions;

local BIND_NONE = GL.LE_ITEM_BIND_NONE;
local BIND_PICKUP = GL.LE_ITEM_BIND_ON_ACQUIRE;
local SOLO = { isInGroup = false, isInRaid = false, isInParty = false, };

---@param itemID number
---@param quality number
---@param Extra? table
---@return table
local function item(itemID, quality, Extra)
    local Item = { id = itemID, quality = quality, bindType = BIND_NONE, };
    for key, value in pairs(Extra or {}) do
        Item[key] = value;
    end

    return Item;
end

---@param target string
---@return table
local function anyQuality(target)
    return { { operator = ">=", quality = 0, target = target, }, };
end

---@param title string
---@param Item table
---@param Rules table
---@param roll? number Expected RollOnLoot value, nil when PackMule shouldn't roll
---@param Extra? table
---@return table
local function rollCase(title, Item, Rules, roll, Extra)
    local Case = {
        title = title,
        rules = Rules,
        cacheItems = { Item.id, },
        settle = .6,
        start = function (_, _, State)
            State.rollID = GroupLoot:startRoll(Item);
        end,
        expect = { rolls = roll and { [Item.id] = roll, } or nil, },
    };

    for key, value in pairs(Extra or {}) do
        Case[key] = value;
    end

    return Case;
end

---@param autoDisable boolean
---@return function
local function leaveGroup(autoDisable)
    return function ()
        local Listener = (GL.Events.Registry.EventListeners["GL.USER_LEFT_GROUP"] or {}).PackMuleUserLeftGroupListener;
        if (type(Listener) ~= "function") then
            return "PackMuleUserLeftGroupListener isn't registered";
        end

        -- Only PackMule's listener: the GDKP listeners would act on a real auction
        Listener("GL.USER_LEFT_GROUP");

        local enabled = GL.Settings:get("PackMule.enabledForGroupLoot");
        if (autoDisable and enabled) then
            return "group-loot PackMule is still enabled after leaving the group";
        elseif (not autoDisable and not enabled) then
            return "group-loot PackMule was disabled even though auto-disable is off";
        end
    end;
end

local CASES = {
    --[[ ROLLS ]]
    rollCase("NEED rule rolls need", item(25, 2), anyQuality(L["NEED"]), Actions.NEED),
    rollCase("GREED rule rolls greed", item(25, 2), anyQuality(L["GREED"]), Actions.GREED),
    rollCase("PASS rule passes", item(25, 2), anyQuality(L["PASS"]), Actions.PASS),

    --[[ GUARDS ]]
    rollCase("Nothing happens when group-loot PackMule is disabled", item(25, 2), anyQuality(L["NEED"]), nil, {
        settings = { ["PackMule.enabledForGroupLoot"] = false, },
    }),
    rollCase("Nothing happens when the loot method is master loot", item(25, 2), anyQuality(L["NEED"]), nil, {
        arrange = function ()
            GroupLoot:setLootMethod("master");
        end,
    }),

    --[[ BIND ON PICKUP ]]
    rollCase("BoP NEED is skipped without assist", item(25, 2, { bindType = BIND_PICKUP, }), anyQuality(L["NEED"]), nil),
    rollCase("BoP NEED rolls with assist", item(25, 2, { bindType = BIND_PICKUP, }), anyQuality(L["NEED"]), Actions.NEED, {
        user = { hasAssist = true, },
    }),
    rollCase("BoP NEED rolls with needWithoutAssist", item(25, 2, { bindType = BIND_PICKUP, }), anyQuality(L["NEED"]), Actions.NEED, {
        settings = { ["PackMule.needWithoutAssist"] = true, },
    }),
    rollCase("BoP GREED doesn't need assist", item(25, 2, { bindType = BIND_PICKUP, }), anyQuality(L["GREED"]), Actions.GREED),
    rollCase("BoP is skipped outside a raid", item(25, 2, { bindType = BIND_PICKUP, }), anyQuality(L["NEED"]), nil, {
        user = { isInRaid = false, isInParty = true, hasAssist = true, },
    }),

    --[[ FILTERS ]]
    rollCase("Companion pets are skipped", item(25, 2, {
        classID = GL.LE_ITEM_CLASS_MISCELLANEOUS,
        subclassID = GL.LE_ITEM_MISCELLANEOUS_SUBCLASS_COMPANION_PET,
    }), anyQuality(L["NEED"]), nil),
    rollCase("Recipes are skipped", item(25, 2, { classID = GL.LE_ITEM_CLASS_RECIPE, }), anyQuality(L["NEED"]), nil),
    rollCase("Quest items are skipped", item(25, 2, { classID = GL.LE_ITEM_CLASS_QUESTITEM, }), anyQuality(L["NEED"]), nil),
    rollCase("Item-ID rule bypasses group-loot filters", item(25, 2, { classID = GL.LE_ITEM_CLASS_RECIPE, }), {
        { item = "25", target = L["NEED"], },
    }, Actions.NEED),

    --[[ CONFIRM LOOT ROLL ]]
    {
        title = "BoP roll confirmation is accepted when enabled",
        settings = { ["PackMule.autoConfirmGroup"] = true, },
        settle = .4,
        start = function ()
            GroupLoot:confirmRoll(7, Actions.NEED);
        end,
        ready = function ()
            return GroupLoot:countActions("ConfirmLootRoll") > 0, "ConfirmLootRoll";
        end,
        check = function ()
            for _, Entry in ipairs(GroupLoot.log) do
                if (Entry.action == "ConfirmLootRoll" and (Entry.rollID ~= 7 or Entry.roll ~= Actions.NEED)) then
                    return ("confirmed roll %s/%s, expected 7/%d"):format(tostring(Entry.rollID), tostring(Entry.roll), Actions.NEED);
                end
            end

            if (GroupLoot:countActions("StaticPopup_Hide") ~= 1) then
                return "the confirmation popup wasn't hidden";
            end
        end,
    },
    {
        title = "BoP roll confirmation is left alone when disabled",
        settle = .4,
        start = function ()
            GroupLoot:confirmRoll(7, Actions.NEED);
        end,
        check = function ()
            if (GroupLoot:countActions("ConfirmLootRoll") > 0) then
                return "the roll was confirmed";
            end
        end,
    },

    --[[ CONTAINERS (LOOT_OPENED) ]]
    {
        title = "Solo containers are auto-looted when enabled",
        user = SOLO,
        players = {},
        settings = { ["PackMule.autoConfirmSolo"] = true, },
        items = { { id = 25, }, { id = 35, }, { id = 36, locked = true, }, },
        settle = .4,
        expect = { removed = { 25, 35, }, remaining = { 36, }, },
        check = function (_, Loot)
            if (Loot:countActions("ConfirmLootSlot") ~= 2) then
                return ("expected 2 confirmed slots, got %d"):format(Loot:countActions("ConfirmLootSlot"));
            end
        end,
    },
    {
        title = "Solo containers are left when disabled",
        user = SOLO,
        players = {},
        items = { { id = 25, }, { id = 35, }, },
        settle = .4,
        expect = { remaining = { 25, 35, }, },
        check = function (_, Loot)
            if (Loot:countActions("ConfirmLootSlot") > 0) then
                return "a slot was confirmed";
            end
        end,
    },
    {
        title = "Group containers respect the loot threshold",
        settings = { ["PackMule.autoConfirmGroup"] = true, },
        items = { item(25, 1), item(35, 3), },
        settle = .4,
        expect = { removed = { 25, }, remaining = { 35, }, },
    },

    --[[ LEAVING THE GROUP ]]
    {
        title = "Leaving the group disables group-loot PackMule",
        settings = { ["PackMule.autoDisableForGroupLoot"] = true, },
        settle = .2,
        start = leaveGroup(true),
    },
    {
        title = "Leaving the group keeps group-loot PackMule when auto-disable is off",
        settle = .2,
        start = leaveGroup(false),
    },
};

---@class PackMuleGroupLootE2E : PackMuleE2EBase
local E2E = PackMuleBase:extend({
    scenarioName = "PackMuleGroupLoot",
    label = "PackMule Group Loot E2E",
    SETTINGS = {
        ["PackMule.enabledForMasterLoot"] = false,
        ["PackMule.enabledForGroupLoot"] = true,
    },
    USER = {
        isMasterLooter = false,
        isInGroup = true,
        isInRaid = true,
        isInParty = false,
        hasAssist = false,
        isLead = false,
    },
    CASES = CASES,
});
GL.Tests.E2E.PackMuleGroupLoot = E2E; ---@type PackMuleGroupLootE2E

---@return nil
function E2E:onSetup()
    GroupLoot:install();
end

---@return nil
function E2E:onTeardown()
    GroupLoot:uninstall();
end

return E2E;
