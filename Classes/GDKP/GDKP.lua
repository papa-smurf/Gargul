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

---@return table|boolean
function GDKP:settingsForItemID(itemID)
    GL:debug("GDKP:settingsForItemID");

    itemID = tonumber(itemID);
    if (not itemID) then
        return false;
    end

    local defaultMinimum = Settings:get("GDKP.defaultMinimumBid");
    local defaultIncrement = Settings:get("GDKP.defaultIncrement");
    if (GL:count(Settings:get("GDKP.ItemLevelDetails")) > 0) then
        local itemLevel = tonumber(GetDetailedItemLevelInfo(itemID) or 0);

        -- If there are item level specific settings and we
        -- can't find the item level then we need to notifiy the player
        if (itemLevel < 1) then
            GL:warning(("Could not determine item level for item with ID %s, check minimum price and increment!"):format(itemID));
        else
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
    PerItemSettings.minimum = PerItemSettings.minimum or Settings:get("GDKP.defaultMinimumBid");
    PerItemSettings.increment = PerItemSettings.increment or Settings:get("GDKP.defaultIncrement");

    return PerItemSettings;
end

---@return void
function GDKP:resetPerItemSettings()
    GL:debug("GDKP:resetPerItemSettings");

    DB:set("GDKP.SettingsPerItem", {});
end

---@param data string
---@return void
function GDKP:importPerItemSettings(data)
    GL:debug("GDKP:importItemSettings");

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
        local Segments = GL:strSplit(line, ",");

        if (first) then
            Columns = GL:tableFlip(Segments);
            first = false;

            if (not Columns.ItemID or (not Columns.Minimum and not Columns.Increment)) then
                GL:error("Missing header, note: it's case-sensitive!");
                return;
            end
        else -- The first line includes the heading, we don't need that
            (function()
                local itemID = tonumber(strtrim(Segments[Columns.ItemID]));
                local minimum = defaultMinimum;
                local increment = defaultIncrement;

                if (not itemID or not GetItemInfoInstant(itemID)) then
                    if (itemID) then
                        GL:error("Unknown item ID: " .. tostring(itemID));
                        return;
                    end

                    GL:error("Unknown item ID");
                    return;
                end

                if (not Segments[Columns.Minimum] and not Segments[Columns.Increment]) then
                    GL:error("Either minimum or increment is required for item ID: " .. tostring(itemID));
                    return;
                end

                if (Columns.Minimum) then
                    minimum = tonumber(strtrim(Segments[Columns.Minimum]));
                end

                if (Columns.Increment) then
                    increment = tonumber(strtrim(Segments[Columns.Increment]));
                end

                increment = GL:round(increment);
                minimum = GL:round(minimum);

                if (increment < 1 or minimum < 1) then
                    GL:error("Increment or minimum can't be lower than 1!");
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
        GL:success(string.format("Successfully imported data for %s items", tostring(imported)));
    end
end

GL:debug("GDKP.lua");