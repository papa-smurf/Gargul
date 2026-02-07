---@type GL
local _, GL = ...;

GL.Timers = {};

---@param seconds number
---@param identifier string
---@param func function
---@param cancel? boolean
---@return table
function GL:after(seconds, identifier, func, cancel)
    identifier = identifier or GetTime() .. GL:uuid();
    GL:debug("Schedule " .. identifier);

    cancel = cancel ~= false;
    GL:cancelTimer(identifier);

    GL.Timers[identifier] = GL.Ace:ScheduleTimer(function ()
        GL:debug("Run once " .. identifier);

        func();
    end, seconds);
    return GL.Timers[identifier];
end

---@param seconds number
---@param identifier string
---@param func function
---@return table
function GL:interval(seconds, identifier, func)
    GL:cancelTimer(identifier);
    GL:debug("Schedule recurring " .. identifier);

    GL.Timers[identifier] = GL.Ace:ScheduleRepeatingTimer(function ()
        GL:debug("Run recurring " .. identifier);

        func(identifier);
    end, seconds);

    return GL.Timers[identifier];
end

---@param identifier string|string[]
---@return nil
function GL:cancelTimer(identifier)
    if (type(identifier) == "table") then
        for _, timerID in pairs(identifier) do
            GL:cancelTimer(timerID);
        end

        return;
    end

    if (not GL.Timers
        or type(GL.Timers) ~= "table"
        or not GL.Timers[identifier]
    ) then
        return;
    end

    GL:debug("Cancel timer " .. identifier);
    GL.Ace:CancelTimer(GL.Timers[identifier]);
    GL.Timers[identifier] = nil;
end
