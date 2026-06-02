---@type GL
local _, GL = ...;
---@diagnostic disable: undefined-field

GL.Tests = GL.Tests or {};
GL.Tests.Fakes = GL.Tests.Fakes or {};

---@class LootFake
local Loot = {
    installed = false,
    items = {},
    itemDetails = {},
    log = {},
    page = 1,
    pageSize = 4,
    players = {},
    failuresByItemID = {},
    silentFailuresByItemID = {},
    nextFailure = nil,
    nextSilentFailure = false,
    Originals = {},
    UserState = {},
    FakeGameMessageIDs = {},
    CreatedButtons = {},
    CreatedPageControls = {},
};

GL.Tests.Fakes.Loot = Loot; ---@type LootFake

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
};

---@param name string
---@param data table|nil
---@return nil
function Loot:record(name, data)
    data = data or {};
    data.action = name;
    table.insert(self.log, data);
end

---@return nil
function Loot:reset()
    self.items = {};
    self.itemDetails = {};
    self.log = {};
    self.page = 1;
    self.players = {};
    self.failuresByItemID = {};
    self.silentFailuresByItemID = {};
    self.nextFailure = nil;
    self.nextSilentFailure = false;
    self.FakeGameMessageIDs = {};
end

---@param item table
---@return table
function Loot:normalizeItem(item)
    item = item or {};
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
        isBOE = true,
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

---@return nil
function Loot:install()
    if (self.installed) then
        self:uninstall();
    end

    self.installed = true;
    self:reset();

    self.Originals.GetNumLootItems = _G.GetNumLootItems;
    self.Originals.GetLootSlotInfo = _G.GetLootSlotInfo;
    self.Originals.GetLootSlotLink = _G.GetLootSlotLink;
    self.Originals.GetLootSlotType = _G.GetLootSlotType;
    self.Originals.GetLootSourceInfo = _G.GetLootSourceInfo;
    self.Originals.GetMasterLootCandidate = _G.GetMasterLootCandidate;
    self.Originals.GetNumGroupMembers = _G.GetNumGroupMembers;
    self.Originals.GiveMasterLoot = _G.GiveMasterLoot;
    self.Originals.LootSlot = _G.LootSlot;
    self.Originals.ConfirmLootSlot = _G.ConfirmLootSlot;
    self.Originals.IsShiftKeyDown = _G.IsShiftKeyDown;
    self.Originals.LOOTFRAME_NUMBUTTONS = _G.LOOTFRAME_NUMBUTTONS;
    self.Originals.GLGetLootMethod = GL.GetLootMethod;
    self.Originals.GLGetItemInfoInstant = GL.GetItemInfoInstant;
    self.Originals.GLOnItemLoadDo = GL.onItemLoadDo;
    self.Originals.GLIsGameMessageID = GL.isGameMessageID;
    self.Originals.LootButtons = {};
    for buttonIndex = 1, self.pageSize do
        self.Originals.LootButtons[buttonIndex] = _G["LootButton" .. buttonIndex];
    end

    _G.LOOTFRAME_NUMBUTTONS = self.pageSize;

    _G.GetNumLootItems = function ()
        Gargul:xd({
            event = "Tests.Fakes.Loot:GetNumLootItems",
            count = #self.items,
        });
        return #self.items;
    end;

    _G.GetLootSlotInfo = function (itemIndex)
        local Item = self.items[itemIndex];
        if (not Item or Item.removed) then
            Gargul:xd({
                event = "Tests.Fakes.Loot:GetLootSlotInfo",
                itemIndex = itemIndex,
                removed = Item and Item.removed or nil,
                found = Item ~= nil,
                locked = true,
            });
            return nil, nil, 0, nil, nil, true;
        end

        Gargul:xd({
            event = "Tests.Fakes.Loot:GetLootSlotInfo",
            itemIndex = itemIndex,
            itemLink = Item.link,
            quality = Item.quality,
            locked = Item.locked,
        });
        return Item.icon, Item.name, Item.quantity, nil, Item.quality, Item.locked;
    end;

    _G.GetLootSlotLink = function (itemIndex)
        local Item = self.items[itemIndex];
        if (not Item or Item.removed) then
            Gargul:xd({
                event = "Tests.Fakes.Loot:GetLootSlotLink",
                itemIndex = itemIndex,
                removed = Item and Item.removed or nil,
                found = Item ~= nil,
            });
            return nil;
        end

        Gargul:xd({
            event = "Tests.Fakes.Loot:GetLootSlotLink",
            itemIndex = itemIndex,
            itemLink = Item.link,
        });
        return Item.link;
    end;

    _G.GetLootSlotType = function (itemIndex)
        local Item = self.items[itemIndex];
        if (not Item or Item.removed) then
            return 0;
        end

        return _G.LOOT_SLOT_ITEM or (Enum and Enum.LootSlotType and Enum.LootSlotType.Item) or 1;
    end;

    _G.GetLootSourceInfo = function ()
        return "Creature-0-0-0-0-0";
    end;

    _G.GetMasterLootCandidate = function (itemIndex, playerIndex)
        local Player = self.players[playerIndex];
        local candidate = Player and GL:formatPlayerName(Player.fqn) or nil;
        Gargul:xd({
            event = "Tests.Fakes.Loot:GetMasterLootCandidate",
            itemIndex = itemIndex,
            playerIndex = playerIndex,
            rawCandidate = Player and Player.fqn or nil,
            candidate = candidate,
        });
        return candidate;
    end;

    _G.GetNumGroupMembers = function ()
        Gargul:xd({
            event = "Tests.Fakes.Loot:GetNumGroupMembers",
            count = #self.players,
        });
        return #self.players;
    end;

    _G.GiveMasterLoot = function (itemIndex, playerIndex)
        self:giveMasterLoot(itemIndex, playerIndex);
    end;

    _G.LootSlot = function (itemIndex)
        self:clearSlot(itemIndex, "LootSlot");
    end;

    _G.ConfirmLootSlot = function (itemIndex)
        self:record("ConfirmLootSlot", { itemIndex = itemIndex, });
    end;

    _G.IsShiftKeyDown = function ()
        return false;
    end;

    GL.GetLootMethod = function ()
        return "master";
    end;

    GL.GetItemInfoInstant = function (itemLinkOrID)
        local itemID = self:itemIDFromIdentifier(itemLinkOrID);
        local Details = itemID and self.itemDetails[itemID];
        if (Details) then
            Gargul:xd({
                event = "Tests.Fakes.Loot:GetItemInfoInstant",
                itemLinkOrID = itemLinkOrID,
                itemID = Details.id,
                classID = Details.classID,
                subclassID = Details.subclassID,
            });
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

    self:ensureNativeLootButtons();
end

---@return nil
function Loot:uninstall()
    if (not self.installed) then
        return;
    end

    self:close();

    _G.GetNumLootItems = self.Originals.GetNumLootItems;
    _G.GetLootSlotInfo = self.Originals.GetLootSlotInfo;
    _G.GetLootSlotLink = self.Originals.GetLootSlotLink;
    _G.GetLootSlotType = self.Originals.GetLootSlotType;
    _G.GetLootSourceInfo = self.Originals.GetLootSourceInfo;
    _G.GetMasterLootCandidate = self.Originals.GetMasterLootCandidate;
    _G.GetNumGroupMembers = self.Originals.GetNumGroupMembers;
    _G.GiveMasterLoot = self.Originals.GiveMasterLoot;
    _G.LootSlot = self.Originals.LootSlot;
    _G.ConfirmLootSlot = self.Originals.ConfirmLootSlot;
    _G.IsShiftKeyDown = self.Originals.IsShiftKeyDown;
    _G.LOOTFRAME_NUMBUTTONS = self.Originals.LOOTFRAME_NUMBUTTONS;
    for buttonIndex = 1, self.pageSize do
        local Button = self.CreatedButtons[buttonIndex];
        if (Button) then
            Button:Hide();
        end
        _G["LootButton" .. buttonIndex] = self.Originals.LootButtons and self.Originals.LootButtons[buttonIndex] or nil;
    end
    for _, Button in pairs(self.CreatedPageControls) do
        if (Button and Button.Hide) then
            Button:Hide();
        end
    end
    GL.GetLootMethod = self.Originals.GLGetLootMethod;
    GL.GetItemInfoInstant = self.Originals.GLGetItemInfoInstant;
    GL.onItemLoadDo = self.Originals.GLOnItemLoadDo;
    GL.isGameMessageID = self.Originals.GLIsGameMessageID;

    self:restoreUserState();
    self.installed = false;
    self.CreatedButtons = {};
    self.CreatedPageControls = {};
    self.Originals = {};
end

---@param players table
---@return nil
function Loot:setMasterLootGroup(players)
    self.players = players or {};

    self.UserState.isMasterLooter = GL.User.isMasterLooter;
    self.UserState.isInGroup = GL.User.isInGroup;
    self.UserState.isInRaid = GL.User.isInRaid;
    self.UserState.isInParty = GL.User.isInParty;
    self.UserState.hasAssist = GL.User.hasAssist;
    self.UserState.isLead = GL.User.isLead;
    self.UserState.groupMembers = GL.User.groupMembers;
    self.UserState.groupMemberNamesCachedAt = GL.User.groupMemberNamesCachedAt;
    self.UserState.groupSetupChangedAt = GL.User.groupSetupChangedAt;
    self.UserState.GroupMemberNames = GL.User.GroupMemberNames;

    GL.User.isMasterLooter = true;
    GL.User.isInGroup = true;
    GL.User.isInRaid = true;
    GL.User.isInParty = false;
    GL.User.hasAssist = true;
    GL.User.isLead = true;
    GL.User.groupSetupChangedAt = GetServerTime();
    GL.User.groupMemberNamesCachedAt = -1;
    GL.User.GroupMemberNames = {};
    GL.User.groupMembers = function ()
        return self.players;
    end;
end

---@return nil
function Loot:restoreUserState()
    if (not self.UserState.groupMembers) then
        return;
    end

    GL.User.isMasterLooter = self.UserState.isMasterLooter;
    GL.User.isInGroup = self.UserState.isInGroup;
    GL.User.isInRaid = self.UserState.isInRaid;
    GL.User.isInParty = self.UserState.isInParty;
    GL.User.hasAssist = self.UserState.hasAssist;
    GL.User.isLead = self.UserState.isLead;
    GL.User.groupMembers = self.UserState.groupMembers;
    GL.User.groupMemberNamesCachedAt = self.UserState.groupMemberNamesCachedAt;
    GL.User.groupSetupChangedAt = self.UserState.groupSetupChangedAt;
    GL.User.GroupMemberNames = self.UserState.GroupMemberNames;
    self.UserState = {};
end

---@param mode string|nil "auto" enables PackMule rules
---@return nil
function Loot:openPackMuleManual(mode)
    if (not self.installed) then
        self:install();
    end

    local realm = GL.User.realm or "";
    local playerName = GL.User.name or "Addontest";
    local target = GL:addRealm("PackMuleTarget", realm, false);
    local itemIDs = { 6948, 25, 35, 36, 159, 117, };
    local items = {};
    local rules = {};

    self:setMasterLootGroup({
        {
            name = playerName,
            fqn = GL:addRealm(playerName, realm, false),
            index = 1,
            isML = true,
        },
        {
            name = "PackMuleTarget",
            fqn = target,
            index = 2,
        },
        {
            name = "PackMuleBackup",
            fqn = GL:addRealm("PackMuleBackup", realm, false),
            index = 3,
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

---@param items table
---@return nil
function Loot:open(items)
    self.items = {};
    self.page = 1;
    GL.User.isMasterLooter = true;
    GL.User.isInGroup = true;
    GL.User.isInRaid = true;
    GL.User.isInParty = false;
    GL.User.hasAssist = true;
    GL.User.isLead = true;

    for _, item in ipairs(items or {}) do
        local itemID = math.floor(tonumber(item.id or item.itemID) or 0);
        if (item.allowSynthetic or item.name or item.link or self:itemHasRealData(itemID)) then
            table.insert(self.items, self:registerItem(item));
        else
            Gargul:xd({
                event = "Tests.Fakes.Loot:openSkippedUncachedItem",
                itemID = itemID,
            });
        end
    end

    self:record("OpenLoot", { itemCount = #self.items, });

    if (_G.LootFrame and _G.LootFrame.Show) then
        _G.LootFrame:Show();
    end

    self:refreshNativeLootButtons();
    GL.Events:fire("LOOT_READY");
    GL:after(.1, "Tests.Fakes.Loot.PackMuleLootReady", function ()
        if (self.installed
            and GL.PackMule
            and GL.PackMule.lootReady
            and GL.Settings:get("PackMule.enabledForMasterLoot")
        ) then
            Gargul:xd({
                event = "Tests.Fakes.Loot:directPackMuleLootReady",
                itemCount = #self.items,
                isMasterLooter = GL.User.isMasterLooter,
                enabledForMasterLoot = GL.Settings:get("PackMule.enabledForMasterLoot"),
                rules = GL.PackMule.Rules,
            });
            GL.PackMule:lootReady();
        end
    end);
end

---@return nil
function Loot:close()
    if (not self.installed) then
        return;
    end

    self:record("CloseLoot");
    if (_G.LootFrame and _G.LootFrame.Hide) then
        _G.LootFrame:Hide();
    end

    if (_G.MasterLooterFrame and _G.MasterLooterFrame.Hide) then
        _G.MasterLooterFrame:Hide();
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
    if (not _G.LootFrame) then
        return;
    end

    if (not self.CreatedPageControls.previous) then
        local Previous = CreateFrame("Button", nil, _G.LootFrame);
        Previous:SetSize(28, 24);
        Previous:SetPoint("BOTTOMLEFT", _G.LootFrame, "BOTTOMLEFT", 36, 28);
        Previous.Text = Previous:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
        Previous.Text:SetPoint("CENTER", Previous, "CENTER", 0, 0);
        Previous.Text:SetText("<");
        Previous:SetScript("OnClick", function ()
            self:setPage(self.page - 1);
        end);
        self.CreatedPageControls.previous = Previous;
    end

    if (not self.CreatedPageControls.next) then
        local Next = CreateFrame("Button", nil, _G.LootFrame);
        Next:SetSize(28, 24);
        Next:SetPoint("BOTTOMLEFT", _G.LootFrame, "BOTTOMLEFT", 72, 28);
        Next.Text = Next:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge");
        Next.Text:SetPoint("CENTER", Next, "CENTER", 0, 0);
        Next.Text:SetText(">");
        Next:SetScript("OnClick", function ()
            self:setPage(self.page + 1);
        end);
        self.CreatedPageControls.next = Next;
    end

    for buttonIndex = 1, self.pageSize do
        if (not _G["LootButton" .. buttonIndex]) then
            local Button = CreateFrame("Button", nil, _G.LootFrame);
            Button:SetSize(220, 36);
            Button:SetPoint("TOPLEFT", _G.LootFrame, "TOPLEFT", 24, -38 - ((buttonIndex - 1) * 38));

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
                if (not Item) then
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
                if (not Item) then
                    return;
                end

                Gargul:xd({
                    event = "Tests.Fakes.Loot:buttonClick",
                    slot = slot,
                    itemLink = Item.link,
                    button = mouseButtonPressed,
                    modified = IsModifiedClick and IsModifiedClick() or false,
                });

                if (IsModifiedClick and IsModifiedClick()) then
                    HandleModifiedItemClick(Item.link, mouseButtonPressed);
                    return;
                end

                self:openMasterLootList(slot);
            end);

            self.CreatedButtons[buttonIndex] = Button;
            _G["LootButton" .. buttonIndex] = Button;
        end
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
                Region:SetText(Item.link);
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
    local DebugButtons = {};
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
        local Button = _G["LootButton" .. buttonIndex];
        if (Button) then
            local slot = slots[buttonIndex];
            Button.slot = slot;
            if (slot) then
                local Item = self.items[slot];
                if (Button.SetID) then
                    Button:SetID(slot);
                end

                if (Button.Icon and Button.Icon.SetTexture) then
                    Button.Icon:SetTexture(Item.icon);
                end
                if (Button.IconTexture and Button.IconTexture.SetTexture) then
                    Button.IconTexture:SetTexture(Item.icon);
                end
                local RegionDetails = self:populateButtonRegions(Button, Item);
                if (Button.Text and Button.Text.SetText) then
                    Button.Text:SetText(Item.link);
                end
                if (Button.Name and Button.Name.SetText) then
                    Button.Name:SetText(Item.link);
                end
                if (Button.Count and Button.Count.SetText) then
                    Button.Count:SetText(Item.quantity > 1 and Item.quantity or "");
                end
                if (Button.Enable) then
                    Button:Enable();
                end

                Button:Show();
                table.insert(DebugButtons, {
                    button = "LootButton" .. buttonIndex,
                    slot = slot,
                    shown = Button.IsShown and Button:IsShown() or nil,
                    visible = Button.IsVisible and Button:IsVisible() or nil,
                    width = Button.GetWidth and Button:GetWidth() or nil,
                    height = Button.GetHeight and Button:GetHeight() or nil,
                    fontStrings = RegionDetails.fontStrings,
                    textures = RegionDetails.textures,
                    itemLink = Item.link,
                });
            else
                Button.slot = nil;
                Button:Hide();
                table.insert(DebugButtons, {
                    button = "LootButton" .. buttonIndex,
                    slot = nil,
                    shown = Button.IsShown and Button:IsShown() or nil,
                    visible = Button.IsVisible and Button:IsVisible() or nil,
                });
            end
        else
            table.insert(DebugButtons, {
                button = "LootButton" .. buttonIndex,
                missing = true,
            });
        end
    end

    Gargul:xd({
        event = "Tests.Fakes.Loot:refreshNativeLootButtons",
        page = self.page,
        lootFrameShown = _G.LootFrame and _G.LootFrame.IsShown and _G.LootFrame:IsShown() or nil,
        lootFrameVisible = _G.LootFrame and _G.LootFrame.IsVisible and _G.LootFrame:IsVisible() or nil,
        lootFrameNumButtons = _G.LOOTFRAME_NUMBUTTONS,
        maxPage = maxPage,
        slots = slots,
        buttons = DebugButtons,
        pageControls = {
            previousShown = self.CreatedPageControls.previous and self.CreatedPageControls.previous.IsShown and self.CreatedPageControls.previous:IsShown() or nil,
            nextShown = self.CreatedPageControls.next and self.CreatedPageControls.next.IsShown and self.CreatedPageControls.next:IsShown() or nil,
        },
    });
end

---@param itemIndex number
---@return nil
function Loot:openMasterLootList(itemIndex)
    self:record("OpenMasterLootList", { itemIndex = itemIndex, });

    if (_G.MasterLooterFrame and _G.MasterLooterFrame.Show) then
        _G.MasterLooterFrame:Show();
    end

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
    self:record(source or "ClearSlot", { itemIndex = itemIndex, itemLink = Item.link, });
    self:refreshNativeLootButtons();
    GL.Events:fire("LOOT_SLOT_CLEARED", itemIndex);
    GL.Events:fire("GL.LOOT_CHANGED");
end

---@param reason string
---@return number|nil
function Loot:gameMessageIDForReason(reason)
    local constant = ERROR_CONSTANT_BY_REASON[reason or "other"] or ERROR_CONSTANT_BY_REASON.other;
    local i = 1;
    while (GetGameMessageInfo) do
        local identifier = GetGameMessageInfo(i);
        if (not identifier) then
            break;
        end

        if (identifier == constant) then
            return i;
        end

        i = i + 1;
    end

    local fakeID = -1000 - GL:count(self.FakeGameMessageIDs);
    self.FakeGameMessageIDs[fakeID] = constant;
    return fakeID;
end

---@param itemIndex number
---@param playerIndex number
---@return nil
function Loot:giveMasterLoot(itemIndex, playerIndex)
    local Item = self.items[itemIndex];
    local Player = self.players[playerIndex];
    local reason = self.nextFailure;
    self.nextFailure = nil;

    if (Item and self.failuresByItemID[Item.id]) then
        reason = self.failuresByItemID[Item.id];
    end

    if (Item and self.silentFailuresByItemID[Item.id]) then
        self.nextSilentFailure = true;
    end

    if (self.nextSilentFailure) then
        self.nextSilentFailure = false;
        self:record("GiveMasterLoot", {
            itemIndex = itemIndex,
            itemLink = Item and Item.link or nil,
            playerIndex = playerIndex,
            player = Player and Player.fqn or nil,
            result = "silentFailure",
        });
        return;
    end

    if (reason) then
        self:record("GiveMasterLoot", {
            itemIndex = itemIndex,
            itemLink = Item and Item.link or nil,
            playerIndex = playerIndex,
            player = Player and Player.fqn or nil,
            result = reason,
        });

        local messageID = self:gameMessageIDForReason(reason);
        if (messageID) then
            GL.Events:fire("UI_ERROR_MESSAGE", messageID);
        end
        return;
    end

    self:record("GiveMasterLoot", {
        itemIndex = itemIndex,
        itemLink = Item and Item.link or nil,
        playerIndex = playerIndex,
        player = Player and Player.fqn or nil,
        result = "success",
    });
    Gargul:xd({
        event = "Tests.Fakes.Loot:GiveMasterLoot",
        itemIndex = itemIndex,
        playerIndex = playerIndex,
        itemLink = Item and Item.link or nil,
        player = Player and Player.fqn or nil,
        result = "success",
    });
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
