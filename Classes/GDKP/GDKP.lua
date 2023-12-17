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
    GL:debug("GDKP:settingsForItemID");

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
        local Segments = GL:explode(line, ",");

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
                local minimum = tonumber(defaultMinimum);
                local increment = tonumber(defaultIncrement);

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

                if (not minimum) then
                    GL:error(("Invalid 'Minimum' provided for item ID '%s'"):format(itemID));
                    return;
                end

                if (not increment) then
                    GL:error(("Invalid 'Increment' provided for item ID '%s'"):format(itemID));
                    return;
                end

                increment = GL:round(increment, Settings:get("GDKP.precision"));
                minimum = GL:round(minimum, Settings:get("GDKP.precision"));

                if (GL:lt(increment, .0001) or GL:lt(minimum, .0001)) then
                    GL:error("Increment or minimum can't be lower than .0001!");
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