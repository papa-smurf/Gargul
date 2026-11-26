---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field

GL.Tests = GL.Tests or {};
GL.Tests.Fakes = GL.Tests.Fakes or {};

---@class LootFake
local Loot = {
    installed = false,
    verbose = false,
    directLootReady = false,
    passthroughMessages = false,
    successLatency = 0,
    failureLatency = 0,
    shiftDown = false,
    lootMethod = nil,
    unitShimsInstalled = false,
    items = {},
    itemDetails = {},
    log = {},
    messages = {},
    page = 1,
    pageSize = 4,
    players = {},
    UserFlags = {},
    ineligible = {},
    failuresByItemID = {},
    silentFailuresByItemID = {},
    nextFailure = nil,
    nextSilentFailure = false,
    PendingTimerIDs = {},
    QueuedErrors = {},
    MessageIDByConstant = {},
    Originals = {},
    UserState = {},
    FakeGameMessageIDs = {},
    Frame = nil,
    CreatedButtons = {},
    CreatedPageControls = {},
};

GL.Tests.Fakes.Loot = Loot; ---@type LootFake

assert(GL.Tests.Fakes.Env, "GL.Tests.Fakes.Env missing (TOC: Tests/Fakes/Env.lua before this file)");
local Env = GL.Tests.Fakes.Env;

local QUALITY_COLOR = {
    [0] = "9D9D9D",
    [1] = "FFFFFF",
    [2] = "1EFF00",
    [3] = "0070DD",
    [4] = "A335EE",
    [5] = "FF8000",
};

local ERROR_CONSTANT_BY_REASON = {
    bagsFull = "ERR_LOOT_MASTER_INV_FULL",
    unique = "ERR_LOOT_MASTER_UNIQUE_ITEM",
    outOfRange = "ERR_LOOT_TOO_FAR",
    notEligible = "ERR_LOOT_PLAYER_NOT_FOUND",
    other = "ERR_LOOT_MASTER_OTHER",
    unrelated = "GARGUL_TEST_UNRELATED_ERROR",
};

local DEFAULT_USER_FLAGS = {
    isMasterLooter = true,
    isInGroup = true,
    isInRaid = true,
    isInParty = false,
    hasAssist = true,
    isLead = true,
};

local DIRECT_LOOT_READY_TIMER_ID = "Tests.Fakes.Loot.PackMuleLootReady";

--- Dump harness internals, only when Loot.verbose is enabled (the PackMule timer polls every .2s)
---
---@param Data table
---@return nil
function Loot:trace(Data)
    if (self.verbose) then
        Gargul:xd(Data);
    end
end

---@param name string
---@param data table|nil
---@return nil
function Loot:record(name, data)
    data = data or {};
    data.action = name;
    data.time = GetTime();
    table.insert(self.log, data);
end

--- Run a callback later, cancelled automatically by resetCase/uninstall
---
---@param delay number
---@param callback function
---@return nil
function Loot:schedule(delay, callback)
    local timerID = "Tests.Fakes.Loot." .. GL:uuid();
    self.PendingTimerIDs[timerID] = true;

    GL:after(delay, timerID, function ()
        self.PendingTimerIDs[timerID] = nil;

        if (self.installed) then
            callback();
        end
    end);
end

---@return nil
function Loot:cancelPendingTimers()
    for timerID in pairs(self.PendingTimerIDs) do
        GL:cancelTimer(timerID);
    end

    self.PendingTimerIDs = {};
    self.QueuedErrors = {};
    GL:cancelTimer(DIRECT_LOOT_READY_TIMER_ID);
end

--- Clear everything a single test case touches, keeping the shims and group installed
---@return nil
function Loot:resetCase()
    self:cancelPendingTimers();
    self.items = {};
    self.itemDetails = {};
    self.log = {};
    self.messages = {};
    self.page = 1;
    self.ineligible = {};
    self.failuresByItemID = {};
    self.silentFailuresByItemID = {};
    self.nextFailure = nil;
    self.nextSilentFailure = false;
    self.successLatency = 0;
    self.failureLatency = 0;
    self.shiftDown = false;

    if (self.installed) then
        self:refreshNativeLootButtons();
    end
end

---@return nil
function Loot:reset()
    self:resetCase();
    self.players = {};
    self.UserFlags = {};
    self.FakeGameMessageIDs = {};
    self.MessageIDByConstant = {};
end

---@param item table
---@return table
function Loot:normalizeItem(item)
    item = item or {};

    if (item.money) then
        return {
            money = true,
            id = 0,
            itemID = 0,
            name = item.name or "1 Silver",
            quality = 0,
            quantity = 0,
            icon = item.icon or 133784,
            locked = item.locked == true,
            removed = false,
            source = item.source,
        };
    end

    local itemID = math.floor(tonumber(item.id or item.itemID) or 0);
    local realName, realLink, realQuality, realLevel, _, _, _, _, realInventoryType, realIcon, _, realClassID, realSubclassID, realBindType = GL.GetItemInfo(itemID);
    local _, _, _, _, instantIcon, instantClassID, instantSubclassID = GL.GetItemInfoInstant(itemID);
    local name = item.name or realName or ("Item " .. tostring(itemID));
    local quality = item.quality or realQuality or 4;
    local color = QUALITY_COLOR[quality] or QUALITY_COLOR[1];
    local link = item.link or realLink or ("|cff%s|Hitem:%d:::::::::::::|h[%s]|h|r"):format(color, itemID, name);

    return {
        id = itemID,
        itemID = itemID,
        name = name,
        link = link,
        quality = quality,
        quantity = item.quantity or 1,
        icon = item.icon or realIcon or instantIcon or 134400,
        locked = item.locked == true,
        classID = item.classID or realClassID or instantClassID or GL.LE_ITEM_CLASS_MISCELLANEOUS,
        subclassID = item.subclassID or realSubclassID or instantSubclassID or 0,
        bindType = item.bindType or realBindType or GL.LE_ITEM_BIND_NONE,
        inventoryType = item.inventoryType or realInventoryType or "",
        level = item.level or realLevel or 1,
        removed = item.removed == true,
        source = item.source,
    };
end

---@param itemID number
---@return boolean
function Loot:itemHasRealData(itemID)
    local name, link = GL.GetItemInfo(itemID);
    return name ~= nil and link ~= nil;
end

---@param item table
---@return table
function Loot:registerItem(item)
    local Item = self:normalizeItem(item);
    if (Item.money) then
        return Item;
    end

    self.itemDetails[Item.id] = {
        id = Item.id,
        bindType = Item.bindType,
        classID = Item.classID,
        icon = Item.icon,
        inventoryType = Item.inventoryType,
        level = Item.level,
        link = Item.link,
        name = Item.name,
        subclassID = Item.subclassID,
        quality = Item.quality,
        isBOE = Item.bindType ~= GL.LE_ITEM_BIND_ON_ACQUIRE,
    };
    return Item;
end

---@param itemLinkOrID string|number
---@return number|nil
function Loot:itemIDFromIdentifier(itemLinkOrID)
    local itemID = tonumber(itemLinkOrID);
    if (itemID) then
        return math.floor(itemID);
    end

    itemID = GL:getItemIDFromLink(itemLinkOrID);
    if (itemID) then
        return math.floor(itemID);
    end
end

---@param itemLinkOrID string|number
---@return boolean
function Loot:isFakeItem(itemLinkOrID)
    local itemID = self:itemIDFromIdentifier(itemLinkOrID);
    return itemID ~= nil and self.itemDetails[itemID] ~= nil;
end

---@param items any
---@return boolean
function Loot:allItemsAreFake(items)
    if (type(items) ~= "table") then
        return self:isFakeItem(items);
    end

    for _, item in pairs(items) do
        if (not self:isFakeItem(item)) then
            return false;
        end
    end

    return true;
end

---@param items table|string|number
---@param callback function
---@param sorter function|nil
---@return nil
function Loot:loadFakeItems(items, callback, sorter)
    local singleItemProvided = type(items) ~= "table";
    if (singleItemProvided) then
        items = { items, };
    end
    ---@cast items table

    local Details = {};
    for _, item in pairs(items) do
        local itemID = self:itemIDFromIdentifier(item);
        if (itemID and self.itemDetails[itemID]) then
            table.insert(Details, self.itemDetails[itemID]);
        end
    end

    if (type(sorter) == "function") then
        table.sort(Details, sorter);
    end

    if (singleItemProvided) then
        callback(Details[1]);
        return;
    end

    callback(Details);
end

---@param Player table
---@param playerName string
---@return boolean
local function playerMatchesName(Player, playerName)
    if (type(playerName) ~= "string" or playerName == "") then
        return false;
    end

    local key = strlower(GL:storedPlayerName(playerName));
    return key == strlower(Player.fqn or "")
        or key == strlower(Player.name or "")
        or key == strlower(GL:stripRealm(Player.fqn or ""));
end

---@param playerName string
---@return table|nil
function Loot:playerByName(playerName)
    for _, Player in ipairs(self.players) do
        if (playerMatchesName(Player, playerName)) then
            return Player;
        end
    end
end

--- Make GetMasterLootCandidate return nil for this player on slots holding itemID
---
---@param itemID number
---@param playerName string
---@return nil
function Loot:setIneligible(itemID, playerName)
    itemID = math.floor(tonumber(itemID) or 0);
    self.ineligible[itemID] = self.ineligible[itemID] or {};
    table.insert(self.ineligible[itemID], playerName);
end

---@param itemID number
---@param Player table
---@return boolean
function Loot:playerIsIneligible(itemID, Player)
    for _, playerName in ipairs(self.ineligible[itemID] or {}) do
        if (playerMatchesName(Player, playerName)) then
            return true;
        end
    end

    return false;
end

---@param down boolean
---@return nil
function Loot:setShiftDown(down)
    self.shiftDown = down == true;
end

---@param level string "error"|"warning"|"alert"
---@vararg any
---@return nil
function Loot:captureMessage(level, ...)
    local Parts = {};
    for i = 1, select("#", ...) do
        local value = select(i, ...);
        if (type(value) == "table") then
            value = value.message or "";
        end
        table.insert(Parts, tostring(value));
    end

    table.insert(self.messages, {
        level = level,
        text = table.concat(Parts, " "),
        time = GetTime(),
    });
end

---@param text? string Plain substring
---@param level? string
---@return number
function Loot:countMessages(text, level)
    local count = 0;
    for _, Message in ipairs(self.messages) do
        if ((not level or Message.level == level)
            and (not text or strfind(Message.text, text, 1, true))
        ) then
            count = count + 1;
        end
    end

    return count;
end

---@return nil
function Loot:install()
    if (self.installed) then
        self:uninstall();
    end

    self:reset();
    self.installed = true;

    self.Originals.GLGetLootMethod = GL.GetLootMethod;
    self.Originals.GLGetItemInfoInstant = GL.GetItemInfoInstant;
    self.Originals.GLOnItemLoadDo = GL.onItemLoadDo;
    self.Originals.GLIsGameMessageID = GL.isGameMessageID;
    self.Originals.GLError = GL.error;
    self.Originals.GLWarning = GL.warning;
    self.Originals.GLLootFrameNumButtons = GL.LOOTFRAME_NUMBUTTONS;
    self.Originals.AlertsFire = GL.Interface.Alerts and GL.Interface.Alerts.fire;

    Env:activate();
    GL.LOOTFRAME_NUMBUTTONS = self.pageSize;

    Env:set("GetNumLootItems", function ()
        self:trace({ event = "Tests.Fakes.Loot:GetNumLootItems", count = #self.items, });
        return #self.items;
    end);

    Env:set("GetLootSlotInfo", function (itemIndex)
        local Item = self.items[itemIndex];
        if (not Item or Item.removed) then
            return nil, nil, 0, nil, nil, true;
        end

        self:trace({
            event = "Tests.Fakes.Loot:GetLootSlotInfo",
            itemIndex = itemIndex,
            itemLink = Item.link,
            quality = Item.quality,
            locked = Item.locked,
        });
        return Item.icon, Item.name, Item.quantity, nil, Item.quality, Item.locked;
    end);

    Env:set("GetLootSlotLink", function (itemIndex)
        local Item = self.items[itemIndex];
        if (not Item or Item.removed or Item.money) then
            return nil;
        end

        return Item.link;
    end);

    Env:set("GetLootSlotType", function (itemIndex)
        local Item = self.items[itemIndex];
        if (not Item or Item.removed) then
            return 0;
        end

        if (Item.money) then
            return GL.LOOT_SLOT_MONEY;
        end

        return LOOT_SLOT_ITEM or (Enum and Enum.LootSlotType and Enum.LootSlotType.Item) or 1;
    end);

    Env:set("GetLootSourceInfo", function (itemIndex)
        local Item = self.items[itemIndex];
        return Item and Item.source or "Creature-0-0-0-0-0";
    end);

    Env:set("GetMasterLootCandidate", function (itemIndex, playerIndex)
        local Player = self.players[playerIndex];
        local Item = self.items[itemIndex];
        if (not Player or (Item and self:playerIsIneligible(Item.id, Player))) then
            return nil;
        end

        local candidate = Player.candidateName or GL:formatPlayerName(Player.fqn);
        self:trace({
            event = "Tests.Fakes.Loot:GetMasterLootCandidate",
            itemIndex = itemIndex,
            playerIndex = playerIndex,
            candidate = candidate,
        });
        return candidate;
    end);

    Env:set("GetNumGroupMembers", function ()
        return #self.players;
    end);

    Env:set("GiveMasterLoot", function (itemIndex, playerIndex)
        self:giveMasterLoot(itemIndex, playerIndex);
    end);

    Env:set("LootSlot", function (itemIndex)
        self:clearSlot(itemIndex, "LootSlot");
    end);

    Env:set("ConfirmLootSlot", function (itemIndex)
        self:record("ConfirmLootSlot", { itemIndex = itemIndex, });
    end);

    Env:set("IsShiftKeyDown", function ()
        return self.shiftDown == true;
    end);

    GL.GetLootMethod = function ()
        return self.lootMethod or "master";
    end;

    GL.GetItemInfoInstant = function (itemLinkOrID)
        local itemID = self:itemIDFromIdentifier(itemLinkOrID);
        local Details = itemID and self.itemDetails[itemID];
        if (Details) then
            return Details.id, "Armor", "Miscellaneous", Details.inventoryType, Details.icon, Details.classID, Details.subclassID;
        end

        if (type(self.Originals.GLGetItemInfoInstant) == "function") then
            return self.Originals.GLGetItemInfoInstant(itemLinkOrID);
        end
    end;

    GL.onItemLoadDo = function (_, items, callback, haltOnError, sorter)
        if (self:allItemsAreFake(items)) then
            self:loadFakeItems(items, callback or function () end, sorter);
            return;
        end

        return self.Originals.GLOnItemLoadDo(GL, items, callback, haltOnError, sorter);
    end;

    GL.isGameMessageID = function (_, constant, messageID)
        if (self.FakeGameMessageIDs[messageID] == constant) then
            return true;
        end

        return self.Originals.GLIsGameMessageID(GL, constant, messageID);
    end;

    GL.error = function (_, ...)
        self:captureMessage("error", ...);
        if (self.passthroughMessages) then
            self.Originals.GLError(GL, ...);
        end
    end;

    GL.warning = function (_, ...)
        self:captureMessage("warning", ...);
        if (self.passthroughMessages) then
            self.Originals.GLWarning(GL, ...);
        end
    end;

    if (GL.Interface.Alerts) then
        GL.Interface.Alerts.fire = function (Alerts, frameType, ...)
            self:captureMessage("alert", ...);
            if (self.passthroughMessages and self.Originals.AlertsFire) then
                return self.Originals.AlertsFire(Alerts, frameType, ...);
            end
            return true;
        end;
    end

    self:ensureNativeLootButtons();
end

--- Opt-in: resolve raidN/partyN units to fake players so groupMemberIdentity can see them (Forever)
---@return nil
function Loot:installUnitShims()
    if (self.unitShimsInstalled) then
        return;
    end

    self.unitShimsInstalled = true;

    Env:set("UnitName", function (unit)
        local index = type(unit) == "string" and tonumber(strmatch(unit, "^raid(%d+)$") or strmatch(unit, "^party(%d+)$"));
        local Player = index and self.players[index];
        if (Player) then
            local fullName = GL:storedPlayerName(Player.fqn);
            local firstName, lastName = strmatch(fullName, "^(%S+)%s+(.+)$");
            return firstName or fullName, lastName;
        end

        return UnitName(unit);
    end);

    Env:set("IsInRaid", function (...)
        if (self.UserFlags.isInGroup ~= nil) then
            return self.UserFlags.isInRaid == true;
        end

        return IsInRaid(...);
    end);
end

---@return nil
function Loot:uninstallUnitShims()
    if (not self.unitShimsInstalled) then
        return;
    end

    Env:clear("UnitName");
    Env:clear("IsInRaid");
    self.unitShimsInstalled = false;
end

---@return nil
function Loot:uninstall()
    if (not self.installed) then
        return;
    end

    self:close();
    self:cancelPendingTimers();
    self:uninstallUnitShims();

    if (self.Frame) then
        self.Frame:Hide();
    end

    GL.GetLootMethod = self.Originals.GLGetLootMethod;
    GL.GetItemInfoInstant = self.Originals.GLGetItemInfoInstant;
    GL.onItemLoadDo = self.Originals.GLOnItemLoadDo;
    GL.isGameMessageID = self.Originals.GLIsGameMessageID;
    GL.error = self.Originals.GLError;
    GL.warning = self.Originals.GLWarning;
    GL.LOOTFRAME_NUMBUTTONS = self.Originals.GLLootFrameNumButtons;
    if (GL.Interface.Alerts and self.Originals.AlertsFire) then
        GL.Interface.Alerts.fire = self.Originals.AlertsFire;
    end

    self:restoreUserState();
    Env:deactivate();
    self.installed = false;
    self.lootMethod = nil;
    self.Originals = {};
end

---@return nil
function Loot:applyUserFlags()
    for key, value in pairs(self.UserFlags) do
        GL.User[key] = value;
    end
end

--- Install a fake group. Flags override the default master looter state (see DEFAULT_USER_FLAGS)
---
---@param players table
---@param Flags? table
---@return nil
function Loot:setGroup(players, Flags)
    self.players = players or {};

    if (not self.UserState.saved) then
        self.UserState = {
            saved = true,
            isMasterLooter = GL.User.isMasterLooter,
            isInGroup = GL.User.isInGroup,
            isInRaid = GL.User.isInRaid,
            isInParty = GL.User.isInParty,
            hasAssist = GL.User.hasAssist,
            isLead = GL.User.isLead,
            groupMembers = rawget(GL.User, "groupMembers"),
            unitInGroup = rawget(GL.User, "unitInGroup"),
            groupMemberNamesCachedAt = GL.User.groupMemberNamesCachedAt,
            groupSetupChangedAt = GL.User.groupSetupChangedAt,
            GroupMemberNames = GL.User.GroupMemberNames,
        };
    end

    self.UserFlags = {};
    for key, value in pairs(DEFAULT_USER_FLAGS) do
        self.UserFlags[key] = value;
    end
    for key, value in pairs(Flags or {}) do
        self.UserFlags[key] = value;
    end
    self:applyUserFlags();

    GL.User.groupSetupChangedAt = GetServerTime();
    GL.User.groupMemberNamesCachedAt = -1;
    GL.User.GroupMemberNames = {};
    GL.User.groupMembers = function ()
        return self.players;
    end;
    GL.User.unitInGroup = function (_, unit)
        return self:playerByName(unit) ~= nil;
    end;
end

---@param players table
---@return nil
function Loot:setMasterLootGroup(players)
    self:setGroup(players);
end

---@return nil
function Loot:restoreUserState()
    if (not self.UserState.saved) then
        return;
    end

    GL.User.isMasterLooter = self.UserState.isMasterLooter;
    GL.User.isInGroup = self.UserState.isInGroup;
    GL.User.isInRaid = self.UserState.isInRaid;
    GL.User.isInParty = self.UserState.isInParty;
    GL.User.hasAssist = self.UserState.hasAssist;
    GL.User.isLead = self.UserState.isLead;
    GL.User.groupMembers = self.UserState.groupMembers;
    GL.User.unitInGroup = self.UserState.unitInGroup;
    GL.User.groupMemberNamesCachedAt = self.UserState.groupMemberNamesCachedAt;
    GL.User.groupSetupChangedAt = self.UserState.groupSetupChangedAt;
    GL.User.GroupMemberNames = self.UserState.GroupMemberNames;
    self.UserState = {};
    self.UserFlags = {};
end

---@param mode string|nil "auto" enables PackMule rules
---@return nil
function Loot:openPackMuleManual(mode)
    if (not self.installed) then
        self:install();
    end

    local realm = GL.User.realm or "";
    local target = GL:addRealm("PackMuleTarget", realm, false);
    local itemIDs = { 6948, 25, 35, 36, 159, 117, };
    local items = {};
    local rules = {};

    self:setGroup({
        {
            name = GL.User.name,
            fqn = GL.User.fqn,
            index = 1,
            online = true,
            isML = true,
        },
        {
            name = "PackMuleTarget",
            fqn = target,
            index = 2,
            online = true,
        },
        {
            name = "PackMuleBackup",
            fqn = GL:addRealm("PackMuleBackup", realm, false),
            index = 3,
            online = true,
        },
    });

    for _, itemID in ipairs(itemIDs) do
        table.insert(items, { id = itemID, });
        table.insert(rules, {
            item = tostring(itemID),
            target = target,
        });
    end

    GL.Settings:set("PackMule.enabledForMasterLoot", mode == "auto", true);
    GL.PackMule.Rules = mode == "auto" and rules or {};
    GL.Settings:set("PackMule.Rules", GL.PackMule.Rules, true);
    GL.PackMule.LootErrors = {};
    GL.PackMule.PendingHandouts = {};
    GL.PackMule.processing = false;

    self:open(items);
end

--- Open a loot window. Fires LOOT_READY and LOOT_OPENED like the client does.
---
---@param items table
---@return table skipped Item IDs that were left out because they weren't cached
function Loot:open(items)
    self.items = {};
    self.page = 1;
    self:applyUserFlags();

    local Skipped = {};
    for _, item in ipairs(items or {}) do
        local itemID = math.floor(tonumber(item.id or item.itemID) or 0);
        if (item.money or item.allowSynthetic or item.name or item.link or self:itemHasRealData(itemID)) then
            table.insert(self.items, self:registerItem(item));
        else
            table.insert(Skipped, itemID);
        end
    end

    self:record("OpenLoot", { itemCount = #self.items, skipped = Skipped, });

    self:refreshNativeLootButtons();
    self.Frame:Show();
    GL.Events:fire("LOOT_READY");
    GL.Events:fire("LOOT_OPENED");

    if (self.directLootReady) then
        GL:after(.1, DIRECT_LOOT_READY_TIMER_ID, function ()
            if (self.installed
                and GL.PackMule
                and GL.PackMule.lootReady
                and GL.Settings:get("PackMule.enabledForMasterLoot")
            ) then
                GL.PackMule:lootReady();
            end
        end);
    end

    return Skipped;
end

--- Add an item to the open loot window (e.g. another addon or the server updating the window)
---
---@param item table
---@return table
function Loot:addItem(item)
    local Item = self:registerItem(item);
    table.insert(self.items, Item);
    self:record("AddItem", { itemIndex = #self.items, itemID = Item.id, });
    self:refreshNativeLootButtons();
    GL.Events:fire("GL.LOOT_CHANGED");
    return Item;
end

---@param itemIndex number
---@param locked boolean
---@return nil
function Loot:setLocked(itemIndex, locked)
    local Item = self.items[itemIndex];
    if (not Item) then
        return;
    end

    Item.locked = locked == true;
    self:record("SetLocked", { itemIndex = itemIndex, locked = Item.locked, });
end

---@return nil
function Loot:close()
    if (not self.installed) then
        return;
    end

    GL:cancelTimer(DIRECT_LOOT_READY_TIMER_ID);
    self:record("CloseLoot");
    if (self.Frame) then
        self.Frame:Hide();
    end

    GL.Events:fire("LOOT_CLOSED");
    GL:cancelTimer("DroppedLootLootChanged");
    GL:cancelTimer("DroppedLootShowLegend");
    GL:cancelTimer("DroppedLootHookEvents");
end

---@param page number
---@return nil
function Loot:setPage(page)
    local maxPage = math.max(1, math.ceil(#self.items / self.pageSize));
    page = math.max(1, math.min(maxPage, math.floor(tonumber(page) or 1)));
    self.page = page;
    self:record("SetLootPage", { page = page, });
    self:refreshNativeLootButtons();
    GL.Events:fire("GL.LOOT_CHANGED");
end

---@return table
function Loot:visibleSlots()
    local slots = {};
    local firstSlot = ((self.page - 1) * self.pageSize) + 1;
    local lastSlot = math.min(firstSlot + self.pageSize - 1, #self.items);

    for slot = firstSlot, lastSlot do
        if (self.items[slot] and not self.items[slot].removed) then
            table.insert(slots, slot);
        end
    end

    return slots;
end

---@return nil
function Loot:ensureNativeLootButtons()
    -- Our own frame: showing or writing into Blizzard's LootFrame/LootButtonN from addon code would taint it
    if (not self.Frame) then
        local Frame = CreateFrame("Frame", "GargulTestsLootFrame", UIParent);
        Frame:SetSize(268, 74 + (self.pageSize * 38));
        Frame:SetPoint("LEFT", UIParent, "LEFT", 100, 0);
        Frame:SetFrameStrata("DIALOG");

        local Background = Frame:CreateTexture(nil, "BACKGROUND");
        Background:SetAllPoints(Frame);
        Background:SetColorTexture(0, 0, 0, .75);

        local Title = Frame:CreateFontString(nil, "OVERLAY", "GameFontNormal");
        Title:SetPoint("TOP", Frame, "TOP", 0, -12);
        Title:SetText("Gargul test loot");

        Frame:Hide();
        self.Frame = Frame;
    end

    if (not self.CreatedPageControls.previous) then
        local Previous = CreateFrame("Button", nil, self.Frame);
        Previous:SetSize(28, 24);
        Previous:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMLEFT", 24, 8);
        Previous.Text = Previous:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
        Previous.Text:SetPoint("CENTER", Previous, "CENTER", 0, 0);
        Previous.Text:SetText("<");
        Previous:SetScript("OnClick", function ()
            self:setPage(self.page - 1);
        end);
        self.CreatedPageControls.previous = Previous;
    end

    if (not self.CreatedPageControls.next) then
        local Next = CreateFrame("Button", nil, self.Frame);
        Next:SetSize(28, 24);
        Next:SetPoint("BOTTOMLEFT", self.Frame, "BOTTOMLEFT", 60, 8);
        Next.Text = Next:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
        Next.Text:SetPoint("CENTER", Next, "CENTER", 0, 0);
        Next.Text:SetText(">");
        Next:SetScript("OnClick", function ()
            self:setPage(self.page + 1);
        end);
        self.CreatedPageControls.next = Next;
    end

    for buttonIndex = 1, self.pageSize do
        if (not self.CreatedButtons[buttonIndex]) then
            local Button = CreateFrame("Button", nil, self.Frame);
            Button:SetSize(220, 36);
            Button:SetPoint("TOPLEFT", self.Frame, "TOPLEFT", 24, -34 - ((buttonIndex - 1) * 38));

            Button.Icon = Button:CreateTexture(nil, "ARTWORK");
            Button.Icon:SetSize(30, 30);
            Button.Icon:SetPoint("LEFT", Button, "LEFT", 0, 0);

            Button.Text = Button:CreateFontString(nil, "OVERLAY", "GameFontNormal");
            Button.Text:SetPoint("LEFT", Button.Icon, "RIGHT", 8, 0);
            Button.Text:SetPoint("RIGHT", Button, "RIGHT", -4, 0);
            Button.Text:SetJustifyH("LEFT");

            Button.Count = Button:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall");
            Button.Count:SetPoint("BOTTOMRIGHT", Button.Icon, "BOTTOMRIGHT", 0, 0);

            Button:SetScript("OnEnter", function (button)
                local slot = button.slot;
                local Item = slot and self.items[slot];
                if (not Item or not Item.link) then
                    return;
                end
                button:LockHighlight();
                GameTooltip:SetOwner(button, "ANCHOR_RIGHT");
                GameTooltip:SetHyperlink(Item.link);
                GameTooltip:Show();
            end);
            Button:SetScript("OnLeave", function (button)
                button:UnlockHighlight();
                GameTooltip:Hide();
            end);
            Button:SetScript("OnMouseUp", function (button, mouseButtonPressed)
                local slot = button.slot;
                local Item = slot and self.items[slot];
                if (not Item or not Item.link) then
                    return;
                end

                if (IsModifiedClick and IsModifiedClick()) then
                    HandleModifiedItemClick(Item.link, mouseButtonPressed);
                    return;
                end

                self:openMasterLootList(slot);
            end);

            self.CreatedButtons[buttonIndex] = Button;
        end

        -- Gargul's DroppedLoot finds loot buttons by global name
        Env:set("LootButton" .. buttonIndex, self.CreatedButtons[buttonIndex]);
    end
end

---@param Button Button
---@param Item table
---@return table
function Loot:populateButtonRegions(Button, Item)
    local Details = {
        fontStrings = 0,
        textures = 0,
    };

    if (not Button or not Button.GetRegions) then
        return Details;
    end

    for i = 1, select("#", Button:GetRegions()) do
        local Region = select(i, Button:GetRegions());
        if (Region and Region.GetObjectType) then
            local objectType = Region:GetObjectType();
            if (objectType == "FontString" and Region.SetText) then
                Region:SetText(Item.link or Item.name);
                Details.fontStrings = Details.fontStrings + 1;
            elseif (objectType == "Texture" and Region.SetTexture and Details.textures == 0) then
                Region:SetTexture(Item.icon);
                Details.textures = Details.textures + 1;
            end
        end
    end

    return Details;
end

---@return nil
function Loot:refreshNativeLootButtons()
    self:ensureNativeLootButtons();
    local slots = self:visibleSlots();
    local maxPage = math.max(1, math.ceil(#self.items / self.pageSize));

    if (self.CreatedPageControls.previous) then
        if (self.page > 1) then
            self.CreatedPageControls.previous:Show();
        else
            self.CreatedPageControls.previous:Hide();
        end
    end

    if (self.CreatedPageControls.next) then
        if (self.page < maxPage) then
            self.CreatedPageControls.next:Show();
        else
            self.CreatedPageControls.next:Hide();
        end
    end

    for buttonIndex = 1, self.pageSize do
        local Button = self.CreatedButtons[buttonIndex];
        if (Button) then
            local slot = slots[buttonIndex];
            Button.slot = slot;
            if (slot) then
                local Item = self.items[slot];
                local label = Item.link or Item.name;
                if (Button.SetID) then
                    Button:SetID(slot);
                end

                if (Button.Icon and Button.Icon.SetTexture) then
                    Button.Icon:SetTexture(Item.icon);
                end
                if (Button.IconTexture and Button.IconTexture.SetTexture) then
                    Button.IconTexture:SetTexture(Item.icon);
                end
                self:populateButtonRegions(Button, Item);
                if (Button.Text and Button.Text.SetText) then
                    Button.Text:SetText(label);
                end
                if (Button.Name and Button.Name.SetText) then
                    Button.Name:SetText(label);
                end
                if (Button.Count and Button.Count.SetText) then
                    Button.Count:SetText(Item.quantity > 1 and Item.quantity or "");
                end
                if (Button.Enable) then
                    Button:Enable();
                end

                Button:Show();
            else
                Button.slot = nil;
                Button:Hide();
            end
        end
    end

    self:trace({
        event = "Tests.Fakes.Loot:refreshNativeLootButtons",
        page = self.page,
        maxPage = maxPage,
        slots = slots,
    });
end

---@param itemIndex number
---@return nil
function Loot:openMasterLootList(itemIndex)
    self:record("OpenMasterLootList", { itemIndex = itemIndex, });
    GL.Events:fire("OPEN_MASTER_LOOT_LIST", itemIndex);
end

---@param reason string
---@return nil
function Loot:failNextHandout(reason)
    self.nextFailure = reason or "other";
end

---@return nil
function Loot:silentFailNextHandout()
    self.nextSilentFailure = true;
end

---@param itemID number
---@return nil
function Loot:silentFailHandoutForItem(itemID)
    self.silentFailuresByItemID[math.floor(tonumber(itemID) or 0)] = true;
end

--- Every handout of itemID fails with reason. "unrelated" fires a UI error PackMule doesn't know.
---
---@param itemID number
---@param reason string
---@return nil
function Loot:failHandoutForItem(itemID, reason)
    self.failuresByItemID[math.floor(tonumber(itemID) or 0)] = reason or "other";
end

---@param itemIndex number
---@param source string
---@return nil
function Loot:clearSlot(itemIndex, source)
    local Item = self.items[itemIndex];
    if (not Item or Item.removed) then
        return;
    end

    Item.removed = true;
    self:record(source or "ClearSlot", { itemIndex = itemIndex, itemID = Item.id, itemLink = Item.link, });
    self:refreshNativeLootButtons();
    GL.Events:fire("LOOT_SLOT_CLEARED", itemIndex);
    GL.Events:fire("GL.LOOT_CHANGED");
end

---@param reason string
---@return number
function Loot:gameMessageIDForReason(reason)
    local constant = ERROR_CONSTANT_BY_REASON[reason or "other"] or ERROR_CONSTANT_BY_REASON.other;
    if (self.MessageIDByConstant[constant]) then
        return self.MessageIDByConstant[constant];
    end

    local messageID;
    local i = 1;
    while (GetGameMessageInfo) do
        local identifier = GetGameMessageInfo(i);
        if (not identifier) then
            break;
        end

        if (identifier == constant) then
            messageID = i;
            break;
        end

        i = i + 1;
    end

    if (not messageID) then
        messageID = -1000 - GL:count(self.FakeGameMessageIDs);
        self.FakeGameMessageIDs[messageID] = constant;
    end

    self.MessageIDByConstant[constant] = messageID;
    return messageID;
end

--- Fire a UI error now, or after failureLatency. Delayed errors arrive in the order they were caused.
---
---@param messageID number
---@return nil
function Loot:fireLootError(messageID)
    if (self.failureLatency <= 0) then
        GL.Events:fire("UI_ERROR_MESSAGE", messageID, "Gargul test loot error");
        return;
    end

    table.insert(self.QueuedErrors, messageID);
    self:schedule(self.failureLatency, function ()
        local queuedMessageID = table.remove(self.QueuedErrors, 1);
        if (queuedMessageID) then
            GL.Events:fire("UI_ERROR_MESSAGE", queuedMessageID, "Gargul test loot error");
        end
    end);
end

---@param itemIndex number
---@param playerIndex number
---@return nil
function Loot:giveMasterLoot(itemIndex, playerIndex)
    local Item = self.items[itemIndex];
    local Player = self.players[playerIndex];
    local Entry = {
        itemIndex = itemIndex,
        itemID = Item and Item.id or nil,
        itemLink = Item and Item.link or nil,
        playerIndex = playerIndex,
        player = Player and Player.fqn or nil,
    };

    if (not Item or Item.removed) then
        Entry.result = "emptySlot";
        self:record("GiveMasterLoot", Entry);
        return;
    end

    local reason = self.failuresByItemID[Item.id] or self.nextFailure;
    self.nextFailure = nil;

    local silent = self.nextSilentFailure or self.silentFailuresByItemID[Item.id];
    self.nextSilentFailure = false;

    if (silent) then
        Entry.result = "silentFailure";
        self:record("GiveMasterLoot", Entry);
        return;
    end

    if (reason) then
        Entry.result = reason;
        self:record("GiveMasterLoot", Entry);
        self:fireLootError(self:gameMessageIDForReason(reason));
        return;
    end

    Entry.result = "success";
    self:record("GiveMasterLoot", Entry);
    self:trace({ event = "Tests.Fakes.Loot:GiveMasterLoot", entry = Entry, });

    if (self.successLatency > 0) then
        self:schedule(self.successLatency, function ()
            self:clearSlot(itemIndex, "GiveMasterLootSuccess");
        end);
        return;
    end

    self:clearSlot(itemIndex, "GiveMasterLootSuccess");
end

---@return number
function Loot:remainingItemCount()
    local count = 0;
    for _, Item in ipairs(self.items) do
        if (not Item.removed) then
            count = count + 1;
        end
    end

    return count;
end

---@param itemID number
---@return table|nil
function Loot:itemByID(itemID)
    for _, Item in ipairs(self.items) do
        if (Item.id == itemID) then
            return Item;
        end
    end
end

---@param itemID number
---@return boolean
function Loot:itemIsInWindow(itemID)
    for _, Item in ipairs(self.items) do
        if (Item.id == itemID and not Item.removed) then
            return true;
        end
    end

    return false;
end

---@return boolean
function Loot:moneyLooted()
    for _, Item in ipairs(self.items) do
        if (Item.money and Item.removed) then
            return true;
        end
    end

    return false;
end

---@param itemID number
---@return number
function Loot:handoutAttempts(itemID)
    local count = 0;
    for _, Entry in ipairs(self.log) do
        if (Entry.action == "GiveMasterLoot" and Entry.itemID == itemID) then
            count = count + 1;
        end
    end

    return count;
end

---@return table<number, table[]>
function Loot:handoutsByItemID()
    local Handouts = {};
    for _, Entry in ipairs(self.log) do
        if (Entry.action == "GiveMasterLoot" and Entry.itemID) then
            Handouts[Entry.itemID] = Handouts[Entry.itemID] or {};
            table.insert(Handouts[Entry.itemID], {
                player = Entry.player,
                result = Entry.result,
                itemIndex = Entry.itemIndex,
            });
        end
    end

    return Handouts;
end

---@param action string
---@return number
function Loot:countActions(action)
    local count = 0;
    for _, Entry in ipairs(self.log) do
        if (Entry.action == action) then
            count = count + 1;
        end
    end

    return count;
end

---@param result string
---@return number
function Loot:countHandoutsByResult(result)
    local count = 0;
    for _, Entry in ipairs(self.log) do
        if (Entry.action == "GiveMasterLoot"
            and Entry.result == result
        ) then
            count = count + 1;
        end
    end

    return count;
end

return Loot;
