---@type GL
local _, GL = ...;

---@class StackedRoll
GL.StackedRoll = {
    _initialized = false,
};
local StackedRoll = GL.StackedRoll; ---@type StackedRoll

---@return boolean
function StackedRoll:_init()
    GL:debug("StackedRoll:_init");

    if (self._initialized) then
        return false;
    end

    GL.Events:register("StackedRollUserJoinedRaidListener", "GL.USER_JOINED_RAID", function () self:userJoinedRaid(); end);

    self._initialized = true;
    return true;
end

--- Check whether there is StackedRoll data available
---
---@return boolean
function StackedRoll:userJoinedRaid()
    GL:debug("StackedRoll:userJoinedRaid");
    if (GL.Settings:get("StackedRoll.enabled")
        and GL.Settings:get("StackedRoll.raidUpdateReminder")
    ) then
        GL.Commands:call("points");
    end
end

--- Check whether there is StackedRoll data available
---
---@return boolean
function StackedRoll:awardedLoot()
    GL:debug("StackedRoll:awardedLoot");
    if (GL.Settings:get("StackedRoll.enabled")
        and GL.Settings:get("StackedRoll.itemUpdateReminder")
    ) then
        GL.Commands:call("points");
    end
end

--- Format a stacked roll (can only change in increments of 10).
---
---@param points any
---@return number
function StackedRoll:toPoints(points)
    points = tonumber(points);

    if not points then
        return nil;
    end

    points = math.floor(points / 10) * 10;
    return points;
end;

--- Calculate max roll from points.
---
---@param points number
---@return number
function StackedRoll:maxStackedRoll(points)
    return math.max(1, math.min(GL.Settings:get("StackedRoll.reserveThreshold"), points));
end;

--- Calculate min roll from points.
---
---@param points number
---@return number
function StackedRoll:minStackedRoll(points)
    return math.max(1, self:maxStackedRoll(points) - 100);
end;

--- Detect stacked rolls.
---
---@param min number
---@param max number
---@return boolean
function StackedRoll:isStackedRoll(low, high)
    local threshold = GL.Settings:get("StackedRoll.reserveThreshold");
    --- Check maximum.
    if (self:maxStackedRoll(high) ~= high or high > threshold) then
        return false;
    end

    --- Check minimum.
    if (self:minStackedRoll(high) ~= low) then
        return false;
    end
    return true;
end;

GL:debug("StackedRoll.lua");