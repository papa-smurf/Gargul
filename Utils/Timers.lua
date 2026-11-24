---@type GL
local _, GL = ...;

GL.Timers = {};

---@param seconds number
---@return number
local function minimumDelay(seconds)
    if (seconds < .01) then
        return .01;
    end

    return seconds;
end

---@param Timer table
---@return boolean
local function isTimer(Timer)
    return type(Timer) == "table"
        and type(Timer.identifier) == "string"
        and Timer.handle;
end

---@param seconds number
---@param identifier? string
---@param func function
---@return table
function GL:after(seconds, identifier, func)
    identifier = identifier or GetTime() .. GL:uuid();
    GL:debug("Schedule " .. identifier);

    seconds = minimumDelay(seconds);
    GL:cancelTimer(identifier);

    local Timer = {
        identifier = identifier,
        ends = GetTime() + seconds,
    };

    Timer.handle = C_Timer.NewTimer(seconds, function ()
        GL:debug("Run once " .. identifier);

        if (GL.Timers[identifier] == Timer) then
            GL.Timers[identifier] = nil;
        end

        func();
    end);

    GL.Timers[identifier] = Timer;
    return Timer;
end

---@param seconds number
---@param identifier string
---@param func function
---@return table
function GL:interval(seconds, identifier, func)
    seconds = minimumDelay(seconds);
    GL:cancelTimer(identifier);
    GL:debug("Schedule recurring " .. identifier);

    local Timer = {
        identifier = identifier,
        repeating = true,
        started = GetTime(),
        startedAt = date("%H:%M:%S"),
        ends = GetTime() + seconds,
    };

    Timer.handle = C_Timer.NewTicker(seconds, function ()
        GL:debug("Run recurring " .. identifier);

        func(identifier);

        if (GL.Timers[identifier] == Timer) then
            Timer.ends = GetTime() + seconds;
        end
    end);

    GL.Timers[identifier] = Timer;
    return Timer;
end

---@param identifier string|table
---@return number
function GL:timeLeft(identifier)
    local Timer;

    if (isTimer(identifier)) then
        if (GL.Timers[identifier.identifier] ~= identifier) then
            return 0;
        end

        Timer = identifier;
    else
        Timer = GL.Timers and GL.Timers[identifier];
    end

    if (not isTimer(Timer)) then
        return 0;
    end

    return Timer.ends - GetTime();
end

---@param minSeconds? number
---@return nil
---
--- /script Gargul:xdIntervals(30)
function GL:xdIntervals(minSeconds)
    minSeconds = tonumber(minSeconds) or 0;

    if (minSeconds < 0) then
        minSeconds = 0;
    end

    local now = GetTime();
    local Rows = {};

    for identifier, Timer in pairs(GL.Timers or {}) do
        if (isTimer(Timer) and Timer.repeating and Timer.started) then
            local running = now - Timer.started;

            if (running >= minSeconds) then
                table.insert(Rows, {
                    running = running,
                    line = ("%s  started=%s  running=%ss"):format(
                        identifier,
                        Timer.startedAt,
                        ("%.1f"):format(running)
                    ),
                });
            end
        end
    end

    table.sort(Rows, function (Left, Right)
        return Left.running > Right.running;
    end);

    local Lines = {};

    for _, Row in ipairs(Rows) do
        table.insert(Lines, Row.line);
    end

    if (#Lines == 0) then
        GL:xd(("No interval timers running for %ss or more"):format(minSeconds));
    else
        GL:xd(Lines);
    end

    GL:xda();
end

---@param identifier string|string[]|table
---@return nil
function GL:cancelTimer(identifier)
    if (isTimer(identifier)) then
        if (GL.Timers[identifier.identifier] == identifier) then
            GL:cancelTimer(identifier.identifier);
        end

        return;
    end

    if (type(identifier) == "table") then
        for _, timerID in pairs(identifier) do
            GL:cancelTimer(timerID);
        end

        return;
    end

    if (not GL.Timers
        or type(GL.Timers) ~= "table"
        or not isTimer(GL.Timers[identifier])
    ) then
        return;
    end

    GL:debug("Cancel timer " .. identifier);
    GL.Timers[identifier].handle:Cancel();
    GL.Timers[identifier] = nil;
end
