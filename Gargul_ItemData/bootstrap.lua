---@type string
local addonName;

---@class Gargul_ItemData
---@field name string
---@field DB table
---@field _items table In-memory lookup: [itemID(number)] = itemName(string)
---@field _itemCount number
---@field _dirty boolean Whether _items has changed since last serialize
---@field _populating boolean
---@field _validItemIDs table
---@field _currentIndex number
---@field _totalItems number
---@field _fetchedItems number
---@field _skippedItems number
---@field _batchesSinceSerialize number
local ItemData;

addonName, ItemData = ...;
if (not ItemData or type(ItemData) ~= "table") then
    ItemData = {};
end
_G.Gargul_ItemData = ItemData;

ItemData.name = addonName;

local GetItemInfoInstant = GetItemInfoInstant or (C_Item and C_Item.GetItemInfoInstant);
local GetItemInfo = GetItemInfo or (C_Item and C_Item.GetItemInfo);

---@return nil
local function onAddonLoaded(_, _, loadedName)
    if (loadedName ~= addonName) then
        return;
    end
    ItemData.EventFrame:UnregisterEvent("ADDON_LOADED");
    ItemData:_init();
end

--- Ensure DB is initialized (safe to call repeatedly)
---
---@return nil
function ItemData:_ensureDB()
    if (self.DB) then
        return;
    end

    self:_init();
end

--- Parse the serialized string into the in-memory _items table
--- Format: "id\tname\nid\tname\n..."
---
---@return nil
function ItemData:_deserialize()
    self._items = {};
    self._itemCount = 0;

    if (not self.DB) then
        return;
    end

    local raw = self.DB.ItemData;
    if (not raw or type(raw) ~= "string" or raw == "") then
        return;
    end

    local pos = 1;
    local len = #raw;
    while (pos <= len) do
        local nl = strfind(raw, "\n", pos, true);
        local line;
        if (nl) then
            line = strsub(raw, pos, nl - 1);
            pos = nl + 1;
        else
            line = strsub(raw, pos);
            pos = len + 1;
        end

        local tab = strfind(line, "\t", 1, true);
        if (tab) then
            local itemID = tonumber(strsub(line, 1, tab - 1));
            local itemName = strsub(line, tab + 1);
            if (itemID and itemName ~= "") then
                self._items[itemID] = itemName;
                self._itemCount = self._itemCount + 1;
            end
        end
    end
end

--- Serialize the in-memory _items table back to the DB string
---
---@return nil
function ItemData:_serialize()
    self:_ensureDB();

    local parts = {};
    local n = 0;
    for itemID, itemName in pairs(self._items) do
        n = n + 1;
        parts[n] = tostring(itemID) .. "\t" .. itemName;
    end

    self.DB.ItemData = table.concat(parts, "\n");
    self._dirty = false;
    self._itemCount = n;
end

---@return nil
function ItemData:_init()
    if (not GargulItemDataDB or type(GargulItemDataDB) ~= "table") then
        GargulItemDataDB = {};
    end
    if (not GargulItemDataDB.InterfaceVersion) then
        GargulItemDataDB.InterfaceVersion = select(4, GetBuildInfo());
    end
    if (not GargulSkippedItemDB or type(GargulSkippedItemDB) ~= "table") then
        GargulSkippedItemDB = {};
    end

    -- Migrate numeric keys to string keys (avoids WoW serializing as huge sparse array)
    for k, v in pairs(GargulSkippedItemDB) do
        if (type(k) == "number") then
            GargulSkippedItemDB[tostring(k)] = true;
            GargulSkippedItemDB[k] = nil;
        end
    end

    -- Remove legacy Items table if it exists (old format that caused constant table overflow)
    GargulItemDataDB.Items = nil;

    self.DB = GargulItemDataDB;

    -- Parse the serialized item data into memory
    self:_deserialize();

    local currentVersion = select(4, GetBuildInfo());
    if (self.DB.InterfaceVersion ~= currentVersion) then
        self.DB.InterfaceVersion = currentVersion;
    end
end

---@return number
function ItemData:countItems()
    return self._itemCount or 0;
end

---@param itemID number
---@param itemLink string
---@param quality number|nil
---@return nil
function ItemData:addItem(itemID, itemLink, quality)
    if (not itemID or not itemLink) then
        return;
    end

    -- Below rare: mark as skipped so re-populate doesn't re-fetch this ID
    if (not quality or quality < 3) then
        if (GargulSkippedItemDB) then
            GargulSkippedItemDB[tostring(itemID)] = true;
        end
        return;
    end

    local itemName = itemLink:match("%[(.-)%]");
    if (not itemName or itemName == "") then
        return;
    end

    if (not self._items[itemID]) then
        self._itemCount = (self._itemCount or 0) + 1;
    end

    self._items[itemID] = itemName;
    self._dirty = true;
end

--- Get an item link by ID (reconstructs from WoW cache)
---
---@param itemID number
---@return string|nil
function ItemData:getItem(itemID)
    if (not self._items[itemID]) then
        return nil;
    end

    local GL = _G.Gargul;
    local _, itemLink = GL.GetItemInfo(itemID);
    return itemLink;
end

---@param itemID number
---@return boolean
function ItemData:hasItem(itemID)
    return self._items[itemID] ~= nil;
end

--- Search for items by name. Results are delivered via callback because
--- item links are fetched asynchronously through onItemLoadDo.
---
---@param query string
---@param maxResults number|nil
---@param callback function Called with (results) - table of {itemID, itemLink, itemName}
---@return nil
function ItemData:search(query, maxResults, callback)
    self:_ensureDB();

    maxResults = maxResults or 10;
    query = strtrim(query or "");
    callback = callback or function () end;

    if (#query < 3) then
        callback({});
        return;
    end

    -- Require at least two non-numeric characters to avoid searching on pasted item IDs
    local nonNumericCount = 0;
    for i = 1, #query do
        local char = strsub(query, i, i);
        if (not tonumber(char)) then
            nonNumericCount = nonNumericCount + 1;
        end
    end

    if (nonNumericCount < 2) then
        callback({});
        return;
    end

    local queryLower = strlower(query);
    local candidates = {};
    local GL = _G.Gargul;

    -- Over-collect so we have enough candidates to sort before trimming to maxResults
    local collectLimit = maxResults * 10;
    for itemID, itemName in pairs(self._items) do
        if (#candidates >= collectLimit) then
            break;
        end

        local itemNameLower = strlower(itemName);
        if (strfind(itemNameLower, queryLower, 1, true)) then
            tinsert(candidates, {
                itemID = itemID,
                itemName = itemName,
                itemNameLower = itemNameLower,
            });
        end
    end

    -- Sort: exact match first, then by Levenshtein distance
    table.sort(candidates, function (a, b)
        local aExact = a.itemNameLower == queryLower;
        local bExact = b.itemNameLower == queryLower;
        if (aExact ~= bExact) then
            return aExact;
        end

        local aDist = GL:levenshtein(a.itemNameLower, queryLower);
        local bDist = GL:levenshtein(b.itemNameLower, queryLower);
        return aDist < bDist;
    end);

    -- Trim to maxResults
    local trimmed = {};
    local itemIDs = {};
    for i = 1, math.min(#candidates, maxResults) do
        tinsert(trimmed, candidates[i]);
        tinsert(itemIDs, candidates[i].itemID);
    end

    if (#itemIDs == 0) then
        callback({});
        return;
    end

    -- Async: fetch full item data (quality-colored links) from the server/cache
    GL:onItemLoadDo(itemIDs, function (ItemDetails)
        -- onItemLoadDo returns a flat table for single items, indexed table for multiple
        local linkByID = {};
        if (type(ItemDetails) == "table") then
            if (ItemDetails.id and ItemDetails.link) then
                linkByID[ItemDetails.id] = ItemDetails.link;
            else
                for _, detail in pairs(ItemDetails) do
                    if (type(detail) == "table" and detail.id and detail.link) then
                        linkByID[detail.id] = detail.link;
                    end
                end
            end
        end

        -- Build final results, falling back to a white link if the server didn't respond
        local results = {};
        for _, c in ipairs(trimmed) do
            tinsert(results, {
                itemID = c.itemID,
                itemLink = linkByID[c.itemID] or ("|cFFFFFFFF|Hitem:%d|h[%s]|h|r"):format(c.itemID, c.itemName),
                itemName = c.itemName,
            });
        end

        callback(results);
    end);
end

---@param minID number|nil
---@param maxID number|nil
---@return nil
function ItemData:populate(minID, maxID)
    if (self._populating) then
        return;
    end

    minID = minID or 1;
    maxID = maxID or 400000;

    -- Ensure DB is initialized (covers nuked SV / external reset)
    self:_ensureDB();

    -- Re-parse in case DB was reset
    if (not self._items or not next(self._items)) then
        self:_deserialize();
    end

    -- Build list of valid item IDs (skip items already fetched or known to be low quality)
    self._validItemIDs = {};
    local GL = _G.Gargul;
    local skipped = GargulSkippedItemDB or {};
    for id = minID, maxID do
        if (GL.GetItemInfoInstant(id)) then
            if (not self._items[id] and not skipped[tostring(id)]) then
                tinsert(self._validItemIDs, id);
            end
        end
    end

    self._totalItems = #self._validItemIDs;
    if (self._totalItems == 0) then
        self.DB.Populating = nil;
        GL.ItemDataManager:_fireProgress(100, true);
        return;
    end

    self._populating = true;
    self._currentIndex = 1;
    self._fetchedItems = 0;
    self._skippedItems = 0;
    self._batchesSinceSerialize = 0;
    self._retryItemIDs = {};
    self._isRetryPass = false;
    self.DB.Populating = true;

    GL.ItemDataManager:_fireProgress(0);
    self:_fetchNextBatch();
end

---@return nil
function ItemData:stopPopulate()
    self:_ensureDB();

    self._populating = false;
    self.DB.Populating = nil;
    if (self._dirty) then
        self:_serialize();
    end

    _G.Gargul.ItemDataManager:_fireProgress(100, true);
end

--- Fetch next batch: try GetItemInfo (sync) first, fall back to onItemLoadDo for uncached
---
---@return nil
function ItemData:_fetchNextBatch()
    if (not self._populating) then
        return;
    end

    self:_ensureDB();

    if (UnitAffectingCombat("player")) then
        _G.Gargul:after(1, "ItemDataCombatRetry", function ()
            ItemData:_fetchNextBatch();
        end);
        return;
    end

    local GL = _G.Gargul;

    if (self._currentIndex > self._totalItems) then
        -- If we have items that failed to load, retry them once before giving up
        if (not self._isRetryPass and self._retryItemIDs and next(self._retryItemIDs)) then
            self._validItemIDs = {};
            for id in pairs(self._retryItemIDs) do
                tinsert(self._validItemIDs, id);
            end
            self._totalItems = #self._validItemIDs;
            self._currentIndex = 1;
            self._retryItemIDs = {};
            self._isRetryPass = true;
            self:_fetchNextBatch();
            return;
        end

        self._populating = false;
        self.DB.Populating = nil;
        self:_serialize();
        GL.ItemDataManager:_fireProgress(100, true);
        return;
    end

    local scanSize = 500;
    local batchEnd = math.min(self._currentIndex + scanSize - 1, self._totalItems);
    local uncached = {};

    -- First pass: grab everything already in WoW's item cache
    for i = self._currentIndex, batchEnd do
        local itemID = self._validItemIDs[i];
        local _, itemLink, quality = GL.GetItemInfo(itemID);
        if (itemLink) then
            self:addItem(itemID, itemLink, quality);
            self._fetchedItems = self._fetchedItems + 1;
        else
            tinsert(uncached, itemID);
        end
    end

    self._currentIndex = batchEnd + 1;
    self._batchesSinceSerialize = (self._batchesSinceSerialize or 0) + 1;

    -- Serialize every 50 batches (~25k items) so reload doesn't lose all progress
    if (self._dirty and self._batchesSinceSerialize >= 50) then
        self:_serialize();
        self._batchesSinceSerialize = 0;
    end

    -- Report progress to any registered listeners via ItemDataManager
    local progress = math.floor(((self._currentIndex - 1) / self._totalItems) * 100);
    GL.ItemDataManager:_fireProgress(progress);

    if (#uncached == 0) then
        -- Everything was cached, continue immediately on next frame
        local frame = CreateFrame("FRAME");
        frame:SetScript("OnUpdate", function (f)
            f:SetScript("OnUpdate", nil);
            ItemData:_fetchNextBatch();
        end);
        return;
    end

    -- Second pass: fetch uncached items via onItemLoadDo
    GL:onItemLoadDo(uncached, function (Result)
        local seen = {};
        if (type(Result) == "table") then
            if (Result.id and Result.link) then
                ItemData:addItem(Result.id, Result.link, Result.quality);
                ItemData._fetchedItems = ItemData._fetchedItems + 1;
                seen[Result.id] = true;
            else
                for _, detail in pairs(Result) do
                    if (type(detail) == "table" and detail.id and detail.link) then
                        ItemData:addItem(detail.id, detail.link, detail.quality);
                        ItemData._fetchedItems = ItemData._fetchedItems + 1;
                        seen[detail.id] = true;
                    end
                end
            end
        end

        -- Items that failed to load are missing from Result. First failure: queue for one retry.
        -- Second failure (retry pass): assume invalid and add to skip table so we don't retry again.
        for _, itemID in ipairs(uncached) do
            if (not seen[itemID]) then
                if (ItemData._isRetryPass and GargulSkippedItemDB) then
                    GargulSkippedItemDB[tostring(itemID)] = true;
                else
                    ItemData._retryItemIDs[itemID] = true;
                end
            end
        end

        -- Schedule next batch on next frame
        local frame = CreateFrame("FRAME");
        frame:SetScript("OnUpdate", function (f)
            f:SetScript("OnUpdate", nil);
            ItemData:_fetchNextBatch();
        end);
    end);
end

ItemData._populating = false;
ItemData._validItemIDs = {};
ItemData._items = {};
ItemData._itemCount = 0;
ItemData._dirty = false;
ItemData._currentIndex = 1;
ItemData._totalItems = 0;
ItemData._fetchedItems = 0;
ItemData._skippedItems = 0;
ItemData._batchesSinceSerialize = 0;

ItemData.EventFrame = CreateFrame("FRAME", "Gargul_ItemDataEventFrame");
ItemData.EventFrame:RegisterEvent("ADDON_LOADED");
ItemData.EventFrame:SetScript("OnEvent", onAddonLoaded);
