---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field

GL.Tests = GL.Tests or {};
GL.Tests.Fakes = GL.Tests.Fakes or {};

--- Group-loot roll harness. Needs Tests/Fakes/Loot.lua installed first (item data, loot method and LootSlot shims).
---@class GroupLootFake
local GroupLoot = {
    installed = false,
    lootThreshold = 2,
    nextRollID = 1,
    Rolls = {},
    log = {},
};

GL.Tests.Fakes.GroupLoot = GroupLoot; ---@type GroupLootFake

local Loot = GL.Tests.Fakes.Loot;
local Env = GL.Tests.Fakes.Env;

local OVERRIDES = { "GetLootRollItemLink", "RollOnLoot", "ConfirmLootRoll", "StaticPopup_Hide", "GetLootThreshold", };

---@param name string
---@param data? table
---@return nil
function GroupLoot:record(name, data)
    data = data or {};
    data.action = name;
    data.time = GetTime();
    table.insert(self.log, data);
end

---@return nil
function GroupLoot:resetCase()
    self.Rolls = {};
    self.log = {};
    self.lootThreshold = 2;
    Loot.lootMethod = "group";
end

---@return nil
function GroupLoot:install()
    assert(Loot.installed, "Install Tests.Fakes.Loot before Tests.Fakes.GroupLoot");

    if (self.installed) then
        self:uninstall();
    end

    self.installed = true;
    self.nextRollID = 1;

    Env:set("GetLootRollItemLink", function (rollID)
        local Item = self.Rolls[rollID];
        if (Item) then
            return Item.link;
        end

        return GetLootRollItemLink(rollID);
    end);

    Env:set("RollOnLoot", function (rollID, roll)
        local Item = self.Rolls[rollID];
        self:record("RollOnLoot", {
            rollID = rollID,
            roll = roll,
            itemID = Item and Item.id or nil,
        });
    end);

    Env:set("ConfirmLootRoll", function (rollID, roll)
        self:record("ConfirmLootRoll", { rollID = rollID, roll = roll, });
    end);

    Env:set("StaticPopup_Hide", function (which, ...)
        if (which == "CONFIRM_LOOT_ROLL") then
            self:record("StaticPopup_Hide", { which = which, });
            return;
        end

        return StaticPopup_Hide(which, ...);
    end);

    Env:set("GetLootThreshold", function ()
        return self.lootThreshold;
    end);

    self:resetCase();
end

---@return nil
function GroupLoot:uninstall()
    if (not self.installed) then
        return;
    end

    for _, name in ipairs(OVERRIDES) do
        Env:clear(name);
    end

    self.Rolls = {};
    self.log = {};
    self.installed = false;
    Loot.lootMethod = nil;
end

---@param method string "group"|"master"|"freeforall" etc.
---@return nil
function GroupLoot:setLootMethod(method)
    Loot.lootMethod = method;
end

--- Start a roll for an item, firing START_LOOT_ROLL
---
---@param item table Same shape as Loot:open items
---@return number rollID
function GroupLoot:startRoll(item)
    local Item = Loot:registerItem(item);
    local rollID = self.nextRollID;
    self.nextRollID = self.nextRollID + 1;
    self.Rolls[rollID] = Item;

    self:record("StartLootRoll", { rollID = rollID, itemID = Item.id, });
    GL.Events:fire("START_LOOT_ROLL", rollID, 60);

    return rollID;
end

--- Fire the BoP confirmation the client shows after rolling
---
---@param rollID number
---@param roll number
---@return nil
function GroupLoot:confirmRoll(rollID, roll)
    GL.Events:fire("CONFIRM_LOOT_ROLL", rollID, roll);
end

---@param itemID number
---@return number|nil
function GroupLoot:rollFor(itemID)
    for _, Entry in ipairs(self.log) do
        if (Entry.action == "RollOnLoot" and Entry.itemID == itemID) then
            return Entry.roll;
        end
    end
end

---@param action string
---@return number
function GroupLoot:countActions(action)
    local count = 0;
    for _, Entry in ipairs(self.log) do
        if (Entry.action == action) then
            count = count + 1;
        end
    end

    return count;
end

return GroupLoot;
