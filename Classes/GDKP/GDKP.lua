local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type DB
local DB = GL.DB;

---@type Settings
local Settings = GL.Settings;

---@class GDKP
GL.GDKP = {};

---@type GDKP
local GDKP = GL.GDKP;

---@param player string
---@return string
function GDKP:playerGUID(player, realm)
    return strlower(GL:addRealm(player, realm));
end

---@return string
function GDKP:myGUID()
    return strlower(GL.User.fqn);
end

---@return table|boolean
function GDKP:settingsForItemID(itemID)
    itemID = tonumber(itemID);
    if (not itemID) then
        return false;
    end

    local defaultMinimum = Settings:get("GDKP.defaultMinimumBid");
    local defaultIncrement = Settings:get("GDKP.defaultIncrement");
    if (GL:count(Settings:get("GDKP.ItemLevelDetails")) > 0) then
        local itemLevel = tonumber(GetDetailedItemLevelInfo(itemID) or 0);

        -- If there are item level specific settings then use them
        if (itemLevel > 0) then
            defaultMinimum = Settings:get(("GDKP.ItemLevelDetails.%s.minimum"):format(tostring(itemLevel)), defaultMinimum);
            defaultIncrement = Settings:get(("GDKP.ItemLevelDetails.%s.increment"):format(tostring(itemLevel)), defaultIncrement);
        end
    end

    if (not Settings:get("GDKP.storeMinimumAndIncrementPerItem")) then
        return {
            minimum = defaultMinimum,
            increment = defaultIncrement,
        }
    end

    local PerItemSettings = DB:get("GDKP.SettingsPerItem." .. itemID, {});

    PerItemSettings.minimum = PerItemSettings.minimum or defaultMinimum;
    PerItemSettings.increment = PerItemSettings.increment or defaultIncrement;

    return PerItemSettings;
end

---@return void
function GDKP:resetPerItemSettings()
    DB:set("GDKP.SettingsPerItem", {});
end

---@param data string
---@return void
function GDKP:importPerItemSettings(data)
    if (type(data) ~= "string" or GL:empty(data)) then
        GL:error("Nothing to import!");
        return;
    end

    local defaultMinimum = Settings:get("GDKP.defaultMinimumBid");
    local defaultIncrement = Settings:get("GDKP.defaultIncrement");

    local first = true;
    local imported = 0;
    local Columns = {};
    for line in data:gmatch("[^\n]+") do
        local Segments = GL:explode(line, ",");

        if (first) then
            Columns = GL:tableFlip(Segments);
            first = false;

            if (not Columns.ItemID or (not Columns.Minimum and not Columns.Increment)) then
                GL:error(L.GDKP_PRICE_IMPORT_MISSING_HEADER);
                return;
            end
        else -- The first line includes the heading, we don't need that
            (function()
                local itemID = tonumber(strtrim(Segments[Columns.ItemID]));
                local minimum = tonumber(defaultMinimum);
                local increment = tonumber(defaultIncrement);

                if (not itemID or not GL:getItemInfoInstant(itemID)) then
                    GL:error((L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM):format(tostring(itemID or "")));
                    return;
                end

                if (not Segments[Columns.Minimum] and not Segments[Columns.Increment]) then
                    GL:error((L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED):format(tostring(itemID)));
                    return;
                end

                if (Columns.Minimum) then
                    minimum = tonumber(strtrim(Segments[Columns.Minimum]));
                end

                if (Columns.Increment) then
                    increment = tonumber(strtrim(Segments[Columns.Increment]));
                end

                if (not minimum) then
                    GL:error((L.GDKP_PRICE_IMPORT_INVALID_MIN):format(itemID));
                    return;
                end

                if (not increment) then
                    GL:error((L.GDKP_PRICE_IMPORT_INVALID_INC):format(itemID));
                    return;
                end

                increment = GL:round(increment, Settings:get("GDKP.precision"));
                minimum = GL:round(minimum, Settings:get("GDKP.precision"));

                if (GL:lt(increment, .0001) or GL:lt(minimum, .0001)) then
                    GL:error(L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW);
                    return;
                end

                -- Everything looks good, store!
                DB:set("GDKP.SettingsPerItem." .. itemID, {
                    minimum = minimum,
                    increment = increment,
                });

                imported = imported + 1;
            end)();
        end
    end

    if (imported > 0) then
        GL:success(string.format(L.GDKP_PRICE_IMPORT_SUCCESSFUL, tostring(imported)));
    end
end
