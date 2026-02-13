---@type GL
local _, GL = ...;

local LCG = LibStub("LibCustomGlowGargul-1.0");
local Constants = GL.Data.Constants;

-- Set up a table of all relevant localized time strings,
-- mapping them to their equivalent time in seconds
-- This allows us to fetch hours/minutes/seconds remaining from item tooltips
local TimeTable = {}
local TimeFormats = {
    [INT_SPELL_DURATION_HOURS] = 60 * 60,
    [INT_SPELL_DURATION_MIN] = 60,
    [INT_SPELL_DURATION_SEC] = 1,
};
for pattern, coefficient in pairs(TimeFormats) do
    local prefix = "";
    pattern = pattern:gsub("%%d(%s?)", function (s)
        prefix = "(%d+)" .. s;
        return "";
    end);

    pattern = pattern:gsub("|4", ""):gsub("[:;]", " ");

    for s in pattern:gmatch("(%S+)") do
        TimeTable[prefix .. s] = coefficient;
    end
end

local lastClickTime;

--- Return an item's ID from an item link, false if invalid itemlink is provided
--- Second parameter are item "extra's" that can be ommited in a comm-setting to save bandwidth
--- 
--- Courtesy of Lantis and the team over at Core Loot Manager: https://github.com/CoreLootManager/CoreLootManager
---
---@param itemLink string
---@param minify? boolean This will minify the 'extra' part, only viable when sending a single item link over the wire
---@return number|boolean, string?
---
---@test DevTools_Dump(_G.Gargul:getItemIDFromLink("|cnIQ5:|Hitem:19019::::::::2:1451:::::::::|h[Thunderfury, Blessed Blade of the Windseeker]|h|r"));
function GL:getItemIDFromLink(itemLink, minify)
    if (not itemLink
        or type(itemLink) ~= "string"
        or itemLink == ""
    ) then
        return false, "";
    end

    local _, _, itemID, extra = string.find(itemLink, "item:(%d+)([-?%d:]*)|h");

    if (extra and minify) then
        extra = GL:replaceColonsWithAlpha(extra);
    end

    return tonumber(itemID) or false, extra or nil;
end

--- Courtesy of Lantis and the team over at Core Loot Manager: https://github.com/CoreLootManager/CoreLootManager
---
---@param itemLink string
---@param extra? string
---@return string
function GL:enrichItemLink(itemLink, extra)
    if (not extra) then
        return itemLink;
    end

    local _, _, pre, post = string.find(itemLink, "(.*item:%d+)[-?%d:]+(|h.*)");
    if (not pre or not post) then
        return itemLink;
    end

    if (not GL:strContains(extra, ":")) then
        extra = GL:replaceAlphaWithColons(extra);
    end

    return pre .. extra .. post;
end

--- Generate an item link by a given item ID and extra ( requires callback after item load )
---
---@param itemID number
---@param extra string
---@param callback function
function GL:buildItemLink(itemID, extra, callback)
    GL:onItemLoadDo(itemID, function (Result)
        callback(GL:enrichItemLink(Result.link, extra));
    end);
end

-- Used mainly for shorting the 'extra' string from getItemIDFromLink
--
---@param str string
---@return string, number?
function GL:replaceColonsWithAlpha(str)
    return str:gsub(":+", function(c)
        return #c <= 26 and string.char(96 + #c) or c;
    end);
end

-- Used mainly for restoring the minified 'extra' string from replaceColonsWithAlpha
--
---@param str string
---@return string, number?
function GL:replaceAlphaWithColons(str)
    return str:gsub("%a", function(c)
        return string.rep(":", string.byte(c:lower(), 1) - 96);
    end);
end

--- Return an item's name from an item link
---
---@param itemLink string
---@return string|boolean
function GL:getItemNameFromLink(itemLink)
    if (type(itemLink) ~= "string"
        or self:empty(itemLink)
    ) then
        return false;
    end

    local itemName = false;
    local openingBracketPosition = strfind(itemLink, "%[");
    local closingBracketPosition = strfind(itemLink, "%]");
    if (openingBracketPosition and closingBracketPosition) then
        itemName = strsub(itemLink, openingBracketPosition + 1, closingBracketPosition - 1);
    end

    return itemName;
end

--- Checks if a given string is a properly formatted WoW item link.
---
--- A valid item link follows the standard WoW format, for example:
--- `|cffa335ee|Hitem:19019:::::::::::::|h[Thunderfury, Blessed Blade of the Windseeker]|h|r`
---
--- @param itemLink string The string to validate as an item link.
---@return boolean isValid
---
--- @test classic
--- /dump _G.Gargul:isValidItemLink('|cffa335ee|Hitem:19019:::::::::::::|h[Thunderfury, Blessed Blade of the Windseeker]|h|r')
---
--- @test retail
--- /dump _G.Gargul:isValidItemLink('|cnIQ5:|Hitem:19019:::::::::::::|h[Thunderfury, Blessed Blade of the Windseeker]|h|r')
function GL:isValidItemLink(itemLink)
    return type(itemLink) == "string" and GL.GetItemInfoInstant(itemLink) ~= nil;
end

--- Some items have items linked to them. Example: t4 tokens have their quest reward counterpart linked to them.
---
---@param itemID number
---@param forSoftRes? boolean
---@return table
---
---@test /dump _G.Gargul:getLinkedItemsForID(94955, true);
---@test /dump _G.Gargul:getLinkedItemsForID(96890, true);
function GL:getLinkedItemsForID(itemID, forSoftRes)
    forSoftRes = forSoftRes == true;

    -- An invalid item id was provided
    itemID = tonumber(itemID);
    if (not GL:higherThanZero(itemID)) then
        return {};
    end

    local Links = {};
    Links[itemID] = true;

    for _, id in pairs(GL.Data.ItemLinks[tostring(itemID)] or {}) do
        Links[id] = true;
    end

    -- Determine whether we need to link (non)heroic items
    if (not forSoftRes
        and not GL.Settings:get("MasterLooting.linkNormalAndHardModeItems")
    ) then
        return GL:tableKeys(Links);
    end

    ---@type function
    local linkItems;
    linkItems = function (ID)
        Links[ID] = true;
        local LinkedItems = GL.Data.NormalModeHardModeLinks[ID];
        local linkType = type(LinkedItems);

        if (linkType == "table") then
            for _, linkedID in pairs(LinkedItems) do
                linkItems(linkedID);
            end

            return;
        end

        if (linkType == "number") then
            local parentItemID = LinkedItems;
            Links[parentItemID] = true;
            LinkedItems = GL.Data.NormalModeHardModeLinks[parentItemID];

            if (type(LinkedItems) ~= "table") then
                LinkedItems = { LinkedItems, };
            end

            for _, linkedID in pairs(LinkedItems or {}) do
                Links[linkedID] = true;
            end
        end
    end;

    linkItems(itemID);

    return GL:tableKeys(Links);
end

--- Return an item's quality from an item link
---
---@param itemLink string
---@return number|boolean
function GL:getItemQualityFromLink(itemLink)
    if (not itemLink
        or type(itemLink) ~= "string"
        or itemLink == ""
    ) then
        return false;
    end

    local color = strsub(itemLink, 5, 10);

    if (not color) then
        return false;
    end

    return GL.Data.Constants.HexColorsToItemQuality[strupper(color)] or false;
end

--- WARNING: THIS REQUIRES THE ITEM TO BE CACHED!
---
---@param ItemMixin Item
---@return table
function GL:normalizeItem(ItemMixin)
    if (not ItemMixin
        or ItemMixin:IsItemEmpty()
    ) then
        return false;
    end

    local itemID = ItemMixin:GetItemID();
    if (not itemID) then
        return false;
    end

    -- Keep in mind that this data all refers to the base version of the item since we're using an ID
    local itemName, itemLink, itemQuality, itemLevel, _, _, _, _, itemEquipLoc,
    itemTexture, _, classID, subclassID, bindType, _, _, _ = GL.GetItemInfo(ItemMixin:GetItemLink());

    if (not itemLink) then
        return false;
    end

    return {
        id = itemID,
        bindType = bindType,
        classID = classID,
        icon = itemTexture,
        inventoryType = itemEquipLoc,
        level = ItemMixin:GetCurrentItemLevel(),
        link = itemLink,
        name = itemName,
        subclassID = subclassID,
        quality = itemQuality,
        isBOE = GL:inTable({ Enum.ItemBind.OnEquip, Enum.ItemBind.Quest, }, bindType),
    };
end

---@param itemLinkOrID string|number
---@return table|nil
function GL:getCachedItem(itemLinkOrID)
    local ItemResult;
    local itemID = tonumber(itemLinkOrID);

    if (itemID) then
        ItemResult = Item:CreateFromItemID(itemID);
    else
        itemID = GL:getItemIDFromLink(itemLinkOrID);
        ItemResult = Item:CreateFromItemLink(itemLinkOrID);
    end

    local NormalizedItem = self:normalizeItem(ItemResult);
    if (not NormalizedItem) then
        itemID = itemID or itemLinkOrID or "unknown";
        GL:debug("GetItemInfo data was not yet available for item with ID: " .. itemID);

        return;
    end

    return NormalizedItem;
end

---@param itemLinkOrID string|number
---@return table
---@test /dump _G.Gargul:itemModifiers(18608); -- Benediction
function GL:itemModifiers(itemLinkOrID)
    GL.TooltipFrame:ClearLines();

    local ItemModPatterns = {
        agility = _G.ITEM_MOD_AGILITY,
        armor_penetration_rating = _G.ITEM_MOD_ARMOR_PENETRATION_RATING,
        attack_power = _G.ITEM_MOD_ATTACK_POWER,
        block_rating = _G.ITEM_MOD_BLOCK_RATING,
        crit_melee_rating = _G.ITEM_MOD_CRIT_MELEE_RATING,
        crit_ranged_rating = _G.ITEM_MOD_CRIT_RANGED_RATING,
        crit_rating = _G.ITEM_MOD_CRIT_RATING,
        crit_spell_rating = _G.ITEM_MOD_CRIT_SPELL_RATING,
        crit_taken_melee_rating = _G.ITEM_MOD_CRIT_TAKEN_MELEE_RATING,
        crit_taken_ranged_rating = _G.ITEM_MOD_CRIT_TAKEN_RANGED_RATING,
        crit_taken_rating = _G.ITEM_MOD_CRIT_TAKEN_RATING,
        crit_taken_spell_rating = _G.ITEM_MOD_CRIT_TAKEN_SPELL_RATING,
        defense_skill_rating = _G.ITEM_MOD_DEFENSE_SKILL_RATING,
        dodge_rating = _G.ITEM_MOD_DODGE_RATING,
        expertise_rating = _G.ITEM_MOD_EXPERTISE_RATING,
        feral_attack_power = _G.ITEM_MOD_FERAL_ATTACK_POWER,
        haste_melee_rating = _G.ITEM_MOD_HASTE_MELEE_RATING,
        haste_ranged_rating = _G.ITEM_MOD_HASTE_RANGED_RATING,
        haste_rating = _G.ITEM_MOD_HASTE_RATING,
        haste_spell_rating = _G.ITEM_MOD_HASTE_SPELL_RATING,
        health = _G.ITEM_MOD_HEALTH,
        hit_melee_rating = _G.ITEM_MOD_HIT_MELEE_RATING,
        hit_ranged_rating = _G.ITEM_MOD_HIT_RANGED_RATING,
        hit_rating = _G.ITEM_MOD_HIT_RATING,
        hit_spell_rating = _G.ITEM_MOD_HIT_SPELL_RATING,
        hit_taken_melee_rating = _G.ITEM_MOD_HIT_TAKEN_MELEE_RATING,
        hit_taken_ranged_rating = _G.ITEM_MOD_HIT_TAKEN_RANGED_RATING,
        hit_taken_rating = _G.ITEM_MOD_HIT_TAKEN_RATING,
        hit_taken_spell_rating = _G.ITEM_MOD_HIT_TAKEN_SPELL_RATING,
        intellect = _G.ITEM_MOD_INTELLECT,
        mana = _G.ITEM_MOD_MANA,
        mana_regeneration = _G.ITEM_MOD_MANA_REGENERATION,
        parry_rating = _G.ITEM_MOD_PARRY_RATING,
        ranged_attack_power = _G.ITEM_MOD_RANGED_ATTACK_POWER,
        resilience_rating = _G.ITEM_MOD_RESILIENCE_RATING,
        spell_damage_done = _G.ITEM_MOD_SPELL_DAMAGE_DONE,
        spell_healing_done = _G.ITEM_MOD_SPELL_HEALING_DONE,
        spell_power = _G.ITEM_MOD_SPELL_POWER,
        spirit = _G.ITEM_MOD_SPIRIT,
        stamina = _G.ITEM_MOD_STAMINA,
        strength = _G.ITEM_MOD_STRENGTH,
    }

    local Patterns = {};
    for identifier, pattern in pairs(ItemModPatterns or {}) do
        if (pattern) then
            Patterns[identifier] = self:createPattern(pattern);
        end
    end

    if (type(itemLinkOrID) == "string") then
        GL.TooltipFrame:SetHyperlink(itemLinkOrID);
    else
        GL.TooltipFrame:SetItemByID(itemLinkOrID);
    end

    -- Attempt to find a matching item modifier
    local ModsDetected = {};
    for i = 1, GL.TooltipFrame:NumLines() do
        local line = _G["GargulTooltipFrameTextLeft" .. i];

        if (line) then
            local text = line:GetText();

            -- One line can't match more than one mod
            for mod, pattern in pairs(Patterns or {}) do
                if (strmatch(text, pattern)) then
                    ModsDetected[mod] = true;
                    break;
                end
            end
        end
    end

    GL.TooltipFrame:ClearLines();

    return ModsDetected;
end

--- Check whether a user can use the given item ID or link (callback required)
---
---@param itemLinkOrID string|number
---@param callback function
function GL:canUserUseItem(itemLinkOrID, callback)
    if (type(callback) ~= "function") then
        GL:warning("Unexpected type '" .. type(callback) .. "' in GL:canUserUseItem, expecting type 'function'");
        return;
    end

    GL:onItemLoadDo(itemLinkOrID, function (Details)
        if (not Details) then
            return callback(true);
        end

        GL.TooltipFrame:ClearLines();
        GL.TooltipFrame:SetHyperlink(Details.link);

        local IsTooltipTextRed = function (text)
            if (text and text:GetText()) then
                local r, g, b = text:GetTextColor();
                return math.floor(r * 256) >= 255 and math.floor(g * 256) == 32 and math.floor(b * 256) == 32;
            end

            return false;
        end;

        for line = 1, GL.TooltipFrame:NumLines() do
            local left = _G["GargulTooltipFrameTextLeft" .. line];
            local right = _G["GargulTooltipFrameTextRight" .. line];

            if (IsTooltipTextRed(left) or IsTooltipTextRed(right)) then
                return callback(false);
            end
        end

        return callback(true);
    end);
end

--- Read GL.TooltipFrame's tooltip and see if there's time remaining to trade the item
---
---@return number Seconds or 0
function GL:tooltipItemTradeTimeRemaining()
    local timeRemainingLine;
    local needle = self:createPattern(BIND_TRADE_TIME_REMAINING):gsub("%%s", ".*");
    local itemIsSoulBound = false;

    -- Attempt to find a tooltip line that holds the remaining trading time
    for i = 1, GL.TooltipFrame:NumLines() do
        local line = _G["GargulTooltipFrameTextLeft" .. i];

        if (line) then
            timeRemainingLine = line:GetText() or "";

            -- The item is actually soulbound!
            if (timeRemainingLine == ITEM_SOULBOUND) then
                itemIsSoulBound = true;
            end

            -- The time remaining line was found, no need to continue searching!
            if (timeRemainingLine:find(needle)) then
                break;
            end

            timeRemainingLine = nil;
        end
    end

    -- Extract each unit of time, convert it to seconds, and sum it
    if (timeRemainingLine) then
        local timeRemainingInSeconds = 0;
        for pattern, coefficient in pairs(TimeTable) do
            local timeRemainingSegment = timeRemainingLine:match(pattern);

            if timeRemainingSegment then
                timeRemainingInSeconds = timeRemainingInSeconds + timeRemainingSegment * coefficient;
            end
        end

        return timeRemainingInSeconds;
    end

    -- The item isn't soulbound at all!
    if (not itemIsSoulBound) then
        return GL.Data.Constants.itemIsNotBound;
    end

    return 0;
end

---@param itemLinkOrID string|number
function GL:itemTradeTimeRemaining(itemLinkOrID)
    local concernsLink = type(itemLinkOrID) == "string";
    local itemID = concernsLink and GL:getItemIDFromLink(itemLinkOrID) or itemLinkOrID;

    if (not itemID) then
        return;
    end

    local Results = {};
    self:forEachItemInBags(function (Location, bag, slot)
        -- This is not the item we're looking for
        if (C_Item.GetItemID(Location) ~= itemID) then
            return;
        end

        -- This is not the item variant we're looking for
        if (concernsLink and not GL:iEquals(C_Item.GetItemLink(Location), itemLinkOrID)) then
            return;
        end

        Results[C_Item.GetItemGUID(Location)] = GL:inventoryItemTradeTimeRemaining(bag, slot);
    end);

    return Results;
end

--- Check how much time to trade is remaining on the given item in our bags
---
---@param bag number
---@param slot number
---@return number Seconds or 0
function GL:inventoryItemTradeTimeRemaining(bag, slot)
    GL.TooltipFrame:ClearLines();
    GL.TooltipFrame:SetBagItem(bag, slot);

    local timeRemaining = GL:tooltipItemTradeTimeRemaining();
    GL.TooltipFrame:ClearLines();

    -- General purpose test mode is enabled
    if (GL.Interface.Settings.LootTradeTimers.testEnabled) then
        return math.random(5000, 7200);
    end

    -- Test mode is enabled for specific items
    if (GL.TradeTime) then
        local itemID = select(10, GL:getContainerItemInfo(bag, slot));
        itemID = tonumber(itemID);

        if (itemID and GL:inTable(GL.TradeTime.TestItems or {}, itemID)) then
            return math.random(5000, 7200);
        end
    end

    return timeRemaining;
end

--- The onItemLoadDo helper accepts one or more item ids or item links
--- The corresponding items will be loaded using Blizzard's Item API
--- After all of the items are loaded execute the provided callback function
---
---@param Items table
---@param callback? function
---@param haltOnError? boolean
---@param sorter? function
---@return table, string
---
--- /script _G.Gargul:onItemLoadDo(45613, function (Result) _G.Gargul:xd(Result); end);
--- /script _G.Gargul:onItemLoadDo("|cffa335ee|Hitem:68915::::::::85:::::|h[Scales of Life]|h|r", function (Result) _G.Gargul:xd(Result); end);
function GL:onItemLoadDo(Items, callback, haltOnError, sorter)
    haltOnError = haltOnError or false;
    callback = callback or function () end;

    local singleItemProvided = type(Items) ~= "table";
    if (singleItemProvided) then
        Items = { Items, };
    end;

    local itemsLoaded = 0;
    local ItemData = {};
    local lastError = nil;
    local callbackCalled = false;
    local numberOfItemsToLoad = self:count(Items);

    --- Check whether all items have been processed and fire the callback if so
    ---@return nil
    local function tryCallback()
        if (callbackCalled
            or itemsLoaded < numberOfItemsToLoad
        ) then
            return;
        end

        callbackCalled = true;

        if (type(sorter) == "function") then
            tsort(ItemData, sorter);
        end

        if (singleItemProvided) then
            ItemData = ItemData[1];
        end

        callback(ItemData, lastError);
    end

    --- We use this nasty function construct in order to be able to return out of a for loop (see below)
    ---
    ---@param itemIdentifier string|number
    local function loadOrReturnItem(itemIdentifier)
        local ItemResult = {}; ---@type Item
        local itemID = tonumber(itemIdentifier);
        local identifierIsLink = type(itemIdentifier) == "string";
        local _, itemType;

        -- A string was provided, treat it as an item link and fetch its ID
        if (not itemID
            and identifierIsLink
        ) then
            itemID = GL:getItemIDFromLink(itemIdentifier);
        end

        -- If a number is provided we assume that it's an item ID
        if (itemID) then
            _, itemType = self.GetItemInfoInstant(itemIdentifier);

            -- Start loading the item
            if (identifierIsLink) then
                ItemResult = Item:CreateFromItemLink(itemIdentifier);
            else
                ItemResult = Item:CreateFromItemID(itemID);
            end

        -- We can't use anything that's not an id or link so we skip it
        else
            itemsLoaded = itemsLoaded + 1;
            lastError = "Unknown identifier type in GL:onItemLoadDo:loadOrReturnItem, expecting string or number";

            return;
        end

        if (
            not itemType -- The item doesn't actually exist in this client
            or ItemResult:IsItemEmpty() -- This is Blizzard's way of saying: this item don't exist fool
            or not ItemResult:GetItemID() -- The item could exist, but not in this client version
        ) then
            itemsLoaded = itemsLoaded + 1;
            lastError = "No item found with identifier " .. itemIdentifier;

            return;
        end

        -- The item already exists in our runtime item cache, return it
        if (ItemResult:IsItemDataCached()) then
            local Details = GL:getCachedItem(itemIdentifier);

            if (Details) then
                itemsLoaded = itemsLoaded + 1;
                tinsert(ItemData, Details)

                return;
            end
        end

        local itemLoaded = false;
        ItemResult:ContinueOnItemLoad(function ()
            itemLoaded = true;
            itemsLoaded = itemsLoaded + 1;

            local NormalizedItem = self:normalizeItem(ItemResult);
            if (NormalizedItem) then
                tinsert(ItemData, NormalizedItem);
            else
                GL:debug("GetItemInfo data was not yet available for item with ID: " .. itemID);
                lastError = "GetItemInfo data was not yet available for item with ID: " .. itemID;
            end

            tryCallback();
        end)

        -- Safety net: if ContinueOnItemLoad never fires (e.g. item exists
        -- in client DB but server data is unavailable), don't block forever
        GL.Ace:ScheduleTimer(function ()
            if (itemLoaded) then
                return;
            end

            itemsLoaded = itemsLoaded + 1;
            lastError = "Timed out loading item with identifier " .. itemIdentifier;

            tryCallback();
        end, .5);
    end

    ---@param itemLinkOrID string|number
    for _, itemLinkOrID in pairs(Items) do

        if (haltOnError and not GL:empty(lastError)) then
            GL:warning(lastError);
            return;
        end

        loadOrReturnItem(itemLinkOrID);

        -- All items may have loaded synchronously, check if we're done
        tryCallback();
        if (callbackCalled) then
            return ItemData;
        end
    end

    -- The return value is only useful if you're 100% certain the item was already pre-loaded
    return ItemData;
end

--- Use return false; in your func if you want to break the loop early
---
---@param func function
---@test /script _G.Gargul:forEachItemInBags(function (Location) print(C_Item.GetItemID(Location)); end);
function GL:forEachItemInBags(func)
    -- Used to break out of our double loop
    local finished = false;

    for bag = Enum.BagIndex.Backpack, Enum.BagIndex.Bag_4 do
        for slot = 1, self.GetContainerNumSlots(bag) do
            (function ()
                local Location = ItemLocation:CreateFromBagAndSlot(bag, slot);

                -- Item doesn't exist
                if (not Location or not C_Item.DoesItemExist(Location)) then
                    return;
                end

                finished = func(Location, bag, slot) == false;
            end)();

            if (finished) then
                break;
            end
        end

        if (finished) then
            return;
        end
    end
end

--- Find the first bag id and slot for a given item id (or false)
---
---@param itemLinkOrID number|string
---@param skipSoulBound? boolean
---@param includeBank? boolean
---@param includeLocked? boolean
---
---@return table
---
---@test /dump _G.Gargul:findBagIdAndSlotForItem(49577);
function GL:findBagIdAndSlotForItem(itemLinkOrID, skipSoulBound, includeBank, includeLocked)
    local identifierIsLink = type(itemLinkOrID) == "string";

    includeLocked = includeLocked == true;
    skipSoulBound = skipSoulBound == true;
    includeBank = includeBank == true;

    local maxBagID = Enum.BagIndex.Bag_4;
    if (includeBank) then
        maxBagID = Enum.BagIndex.BankBag_7;
    end

    local itemID = identifierIsLink and GL:getItemIDFromLink(itemLinkOrID) or itemLinkOrID;
    for bag = Enum.BagIndex.Backpack, maxBagID do
        for slot = 1, GL.GetContainerNumSlots(bag) do
            local Result = (function ()
                local _, _, locked, _, _, _, itemLink, _, _, bagItemID = GL:getContainerItemInfo(bag, slot);

                if ((not includeLocked and locked) -- The item is locked and can not be used
                    or bagItemID ~= itemID -- This isn't the item we're looking for
                    or (identifierIsLink and not GL:iEquals(itemLinkOrID, itemLink)) -- This is not the variant we're looking for
                    or (skipSoulBound and GL:inventoryItemTradeTimeRemaining(bag, slot) <= 0) -- This item is no longer tradable
                ) then
                    return;
                end

                return { bag, slot, };
            end)();

            -- We've got a hit, return it
            if (Result) then
                return Result;
            end
        end
    end

    return {};
end

---@param itemGUID string
---@return boolean|number,boolean|number
function GL:getBagAndSlotByGUID(itemGUID)
    local itemBag = false;
    local itemSlot = false;

    self:forEachItemInBags(function (Location, bag, slot)
        -- This is not the item we're looking for
        if (C_Item.GetItemGUID(Location) ~= itemGUID) then
            return;
        end

        itemBag, itemSlot = bag, slot;
        return false;
    end);

    return itemBag, itemSlot;
end

---@param bag number
---@param slot number
---@return boolean|string
function GL:getItemGUIDByBagAndSlot(bag, slot)
    local Location = ItemLocation:CreateFromBagAndSlot(bag, slot);

    -- Item doesn't exist
    if (not Location or not C_Item.DoesItemExist(Location)) then
        return;
    end

    return C_Item.GetItemGUID(Location);
end

--- Check if the item could interest the current player based on SoftRes / TMB data
---
---@param itemIdentifier number|string
---@return boolean, number?
function GL:isItemOfInterest(itemIdentifier)
    local ItemOfInterestReasons = GL.Data.Constants.ItemOfInterestReasons;

    -- We reserved the item
    if (GL.SoftRes:itemIsReservedByMe(itemIdentifier)) then
        return true, ItemOfInterestReasons.RESERVE;
    end

    -- Check if there is relevant TMB data
    local TMBData = GL.TMB:byItemIdentifierAndPlayer(itemIdentifier, GL.User.fqn)
    if (GL:empty(TMBData)) then
        return false;
    end

    for _, Entry in pairs(TMBData) do
        -- We have the item on prio
        if (Entry.type == Constants.tmbTypePrio) then
            return true, ItemOfInterestReasons.PRIOLIST
        end

        -- We have the item on wishlist
        return true, ItemOfInterestReasons.WISHLIST;
    end

    return false;
end

---@param ItemFrame Frame
---@param itemLink string
---@param Details? table
function GL:highlightItem(ItemFrame, itemLink, Details)
    -- We can not put a highlight on this frame
    if (not ItemFrame or not ItemFrame.GetSize) then
        return;
    end

    -- There's no point highlighting something if the player
    -- is not in a group or highlights are disabled
    if (type(itemLink) ~= "string"
        or not GL.Settings:get("highlightsEnabled")
        or (
            not GL.Settings:get("highlightHardReservedItems")
            and not GL.Settings:get("highlightSoftReservedItems")
            and not GL.Settings:get("highlightWishlistedItems")
        )
    ) then
        return;
    end

    Details = Details or {};

    -- Remove any existing highlight
    GL:stopHighlight(ItemFrame);
    local enableHighlight = false;
    local BorderColor = { 1, 1, 1, 1, }; -- The default border color is priest-white and applies to wishlisted items

    -- The item is hard-reserved
    if (GL.Settings:get("highlightHardReservedItems")
        and GL.SoftRes:linkIsHardReserved(itemLink)
    ) then
        enableHighlight = true;
        BorderColor = { .77, .12, .23, 1, };  -- Make the border red for hard-reserved items

    -- The item is soft-reserved
    elseif (GL.Settings:get("highlightSoftReservedItems")
        and GL.SoftRes:linkIsReserved(itemLink)
        and not (not GL.User.isMasterLooter
            and GL.Settings:get("highlightMyItemsOnly")
            and not GL.SoftRes:itemLinkIsReservedByMe(itemLink)
        )
    ) then
        enableHighlight = true;
        BorderColor = { .95686, .5490, .72941, 1, }; -- Make the border paladin-pink for reserved items

    -- Check if it's wishlisted/priolisted
    elseif (GL.Settings:get("highlightWishlistedItems")
        or GL.Settings:get("highlightPriolistedItems")
    ) then
        local TMBInfo = {};

        -- Fetch all TMB data for this item
        if (GL.User.isMasterLooter
            or not GL.Settings:get("highlightMyItemsOnly")
        ) then
            TMBInfo = GL.TMB:byItemLink(itemLink) or {};

        -- Fetch only the current user's TMB data, he's not interested in the rest
        else
            TMBInfo = GL.TMB:byItemLinkAndPlayer(itemLink, GL.User.name) or {};
        end

        local concernsPrio = false;

        -- Check for active wishlist entries
        for _, Entry in pairs(TMBInfo) do
            BorderColor = { 1, 1, 1, 1, }; -- Make the border priest-white for TMB wishlisted items

            if (Entry.type == Constants.tmbTypePrio) then
                concernsPrio = true;
                BorderColor = { 1, .48627, .0392, 1, }; -- Make the border druid-orange for TMB character prio items
                break;
            end
        end

        if (not GL:empty(TMBInfo)
            and (
                (not concernsPrio and GL.Settings:get("highlightWishlistedItems"))
                or (concernsPrio and GL.Settings:get("highlightPriolistedItems"))
            )
        ) then
            enableHighlight = true;
        end
    end

    if (not enableHighlight) then
        return;
    end

    -- Add an animated border to indicate that this item was reserved / wishlisted
    -- function lib.PixelGlow_Start(r,color,N,frequency,length,th,xOffset,yOffset,border,key,frameLevel)
    LCG.PixelGlow_Start(ItemFrame,
        BorderColor,
        Details.dots or 10,
        Details.speed or .05,
        Details.length or 5,
        Details.width or 2,
        Details.offsetX,
        Details.offsetY,
        Details.border,
        Details.key,
        Details.level
    );
end

--- Only call this function directly if you need the callback functionality, in all other cases use
--- the native HandleModifiedItemClick method instead so that you also have support for linking items to chat for example
---@param itemLink string
---@param mouseButtonPressed string|nil
---@param callback? Some actions (like award) support a callback
function GL:handleItemClick(itemLink, mouseButtonPressed, callback)
    if (not GL:isValidItemLink(itemLink)
        or (mouseButtonPressed
            and mouseButtonPressed ~= "LeftButton"
        )
    ) then
        return;
    end

    local CLMRaidIsActive = false;
    if (GL.Settings:get("ShortcutKeys.disableWhenCLMIsActive")) then
        pcall(function ()
            local CLM = LibStub("ClassicLootManager", true);

            if (CLM
                and CLM.CLM
                and CLM.CLM.MODULES
                and CLM.CLM.MODULES.RaidManager
                and CLM.CLM.MODULES.RaidManager.IsInActiveRaid
            ) then
                CLMRaidIsActive = CLM.CLM.MODULES.RaidManager:IsInActiveRaid()
            end
        end);
    end

    -- There's an active CLM raid, disable hotkeys for now
    if (CLMRaidIsActive) then
        return;
    end

    -- Make sure item interaction elements like ah/mail/shop/bank are closed
    if (GL.auctionHouseIsShown
        or GL.bankIsShown
        or GL.guildBankIsShown
        or GL.mailIsShown
        or GL.merchantIsShown
    ) then
        return;
    end

    -- The user doesnt want to use shortcut keys when solo
    if (not GL.User.isInGroup
        and GL.Settings:get("ShortcutKeys.onlyInGroup")
    ) then
        return;
    end

    local keyPressIdentifier = GL.Events:getClickCombination(mouseButtonPressed);

    local onDoubleClick = function ()
        if (not GL.Settings:get("ShortcutKeys.doubleClickToTrade")) then
            return;
        end

        -- Open a trade window with the targeted unit if we don't have one open yet
        if (not TradeFrame:IsShown()) then
            if (not UnitIsPlayer("target") or (
                not UnitInRaid("target")
                and not UnitInParty("target")
            )) then
                local itemID = GL:getItemIDFromLink(itemLink);
                local Winners = GL.AwardedLoot:winnersToTradeForItemID(itemID);

                for _, winner in pairs(Winners or {}) do
                    if (GL:unitIsConnected(winner)
                        and GL.User:unitInGroup(winner)
                    ) then
                        GL.TradeWindow:open(winner, function ()
                            GL.TradeWindow:addItem(itemID);
                        end, true);

                        break;
                    end
                end

                return;
            end

            GL.TradeWindow:open("target", function ()
                GL.TradeWindow:addItem(GL:getItemIDFromLink(itemLink));
            end, true);

            return;
        end

        -- A trade window is open already, just add the item
        GL.TradeWindow:addItem(GL:getItemIDFromLink(itemLink));
    end;

    -- Open the auction or roll window
    if (keyPressIdentifier == GL.Settings:get("ShortcutKeys.rollOffOrAuction")) then
        -- If the GDKP multi-auction window is shown then add the item there
        if (GL.Interface.GDKP.MultiAuction.Auctioneer:isShown()) then
            local addToSelection = true;
            return GL.Interface.GDKP.MultiAuction.Auctioneer:addItemByLink(itemLink, addToSelection);

        -- If the GDKP multi-auction bidding window is shown then add the item there
        elseif (GL.Interface.GDKP.MultiAuction.Client:isShown()) then
            return GL.Interface.GDKP.MultiAuction.AddItem:open(itemLink);

        -- There's an active GDKP session, open the auction window
        elseif (GL.GDKP.Session:activeSessionID()
            and not GL.GDKP.Session:getActive().lockedAt
        ) then
            GL.GDKP.Auctioneer:addItemLink(itemLink);

        -- Open the master looter UI to roll out the item
        else
            GL.MasterLooterUI:draw(itemLink);
        end
    -- Open the roll window
    elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.rollOff")) then
        GL.MasterLooterUI:draw(itemLink);

    -- Open the auction window
    elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.auction")) then
        GL.GDKP.Auctioneer:addItemLink(itemLink);

    -- Open the award window
    elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.award")) then
        GL.Interface.Award.Award:draw(itemLink, callback);

    -- Disenchant
    elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.disenchant")) then
        GL.PackMule:disenchant(itemLink, nil, callback);

    -- Try the item on if the user does not have a CTRL_CLICK hotkey set for Gargul
    elseif (keyPressIdentifier == "CTRL_CLICK") then
        -- Version 7.6.26: This no longer seems necessary
        -- DressUpItemLink(itemLink);

    -- Check for unmodified double clicks (trade)
    elseif (keyPressIdentifier == "CLICK") then
        local currentTime = GetTime();

        -- Double click behavior detected
        if (lastClickTime and currentTime - lastClickTime <= .5) then
            onDoubleClick();
            lastClickTime = nil;
        else
            lastClickTime = currentTime;
        end
    end
end

--- Courtesy of Lantis and the team over at Classic Loot Manager: https://github.com/ClassicLootManager/ClassicLootManager
function GL.LibStItemCellUpdate (rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
    local itemID = data[realrow].cols[column].value;
    local _, _, _, _, icon = GL.GetItemInfoInstant(itemID or 0);
    if (icon) then
        frame:SetNormalTexture(icon);
        frame:Show();
        frame:SetScript("OnEnter", function ()
            GameTooltip:SetOwner(rowFrame, "ANCHOR_RIGHT");
            GameTooltip:SetHyperlink("item:" .. tostring(itemID));
            GameTooltip:Show();
        end)

        frame:SetScript("OnLeave", function () GameTooltip:Hide() end);
    else
        frame:Hide();
    end
end

function GL.LibStItemLinkCellUpdate (rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
    local value = data[realrow].cols[column].value;
    frame.text:SetText(value);

    if (value) then
        frame:Show();
        frame:SetScript("OnEnter", function ()
            GameTooltip:SetOwner(rowFrame, "ANCHOR_RIGHT");
            GameTooltip:SetHyperlink(data[realrow].cols[column].value);
            GameTooltip:Show();
        end)

        frame:SetScript("OnLeave", function () GameTooltip:Hide() end);
    else
        frame:Hide();
    end

    return true;
end
