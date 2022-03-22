---@type GL
local _, GL = ...;

---@class PlusOnes
GL.PlusOnes = {};

local DB = GL.DB; ---@type DB
local PlusOnes = GL.PlusOnes; ---@type PlusOnes

--- Add a plus one for the given player name and return the current plusOne value
---
---@param playerName string
---@return number
function PlusOnes:add(playerName)
    GL:debug("PlusOnes:add");

    playerName = GL:normalizedName(playerName);

    if (not DB.PlusOnes[playerName]) then
        DB.PlusOnes[playerName] = 1;
    else
        DB.PlusOnes[playerName] = DB.PlusOnes[playerName] + 1;
    end

    self:triggerChangeEvent();

    return DB.PlusOnes[playerName];
end

--- Deduct a plus one for the given player name and return the current plusOne value
---
---@param playerName string
---@return number
function PlusOnes:deduct(playerName)
    GL:debug("PlusOnes:deduct");

    playerName = GL:normalizedName(playerName);

    if (not DB.PlusOnes[playerName]) then
        DB.PlusOnes[playerName] = 0;
    else
        -- Make sure the plusOne doesn't end up below 0
        DB.PlusOnes[playerName] = max(DB.PlusOnes[playerName] - 1, 0);
    end

    self:triggerChangeEvent();

    return DB.PlusOnes[playerName];
end

--- Set a given player's plusOne value to 0
---
---@param playerName string
---@return number
function PlusOnes:setToZero(playerName)
    GL:debug("PlusOnes:setToZero");

    playerName = GL:normalizedName(playerName);

    if (not DB.PlusOnes[playerName]) then
        DB.PlusOnes[playerName] = 0;
    end

    DB.PlusOnes[playerName] = 0;
    self:triggerChangeEvent();

    return 0;
end

--- Clear all plusOnes
---
---@return void
function PlusOnes:clear()
    GL:debug("PlusOnes:clear");

    DB.PlusOnes = {};

    self:triggerChangeEvent();
end

--- Get a player's PlusOnes value
---
---@param playerName string
---@return number
function PlusOnes:get(playerName)
    GL:debug("PlusOnes:get");

    playerName = GL:normalizedName(playerName);

    return DB.PlusOnes[playerName] or 0;
end

--- Set a player's PlusOnes value
---
---@param playerName string
---@param value number
---@return void
function PlusOnes:set(playerName, value)
    GL:debug("PlusOnes:set");

    -- A table was provided, treat it as a mass assignment
    if (type(playerName) == "table") then
        return self:massSet(playerName);
    end

    playerName = GL:normalizedName(playerName);

    DB.PlusOnes[playerName] = GL:round(value);
end

--- Assign PlusOne values en masse
---
---@param plusOnesByPlayerName table
---@return void
function PlusOnes:massSet(plusOnesByPlayerName)
    GL:debug("PlusOnes:massSet");

    for playerName, value in pairs(plusOnesByPlayerName) do
        playerName = GL:normalizedName(playerName);

        DB.PlusOnes[playerName] = GL:round(value);
    end

    self:triggerChangeEvent();
end

--- Trigger the PLUSONES_CHANGED event
---
---@return void
function PlusOnes:triggerChangeEvent()
    GL:debug("PlusOnes:triggerChangeEvent");

    GL.Events:fire("GL.PLUSONES_CHANGED");
end

GL:debug("PlusOnes.lua");