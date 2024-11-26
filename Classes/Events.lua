---@type GL
local _, GL = ...;

---@class Events
local Events = {
    ---@type boolean
    _initialized = false,

    ---@type Frame
    Frame = nil,

    ---@type table
    Registry = {
        ---@type table
        EventListeners = {},

        ---@type table
        EventByIdentifier = {},
    },
};
GL.Events = Events;

--- Prepare the event frame for future use
---@param EventFrame Frame
function Events:_init(EventFrame)
    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end
    self._initialized = true;

    self.Frame = EventFrame;
    self.Frame:SetScript("OnEvent", self.listen);
end

--- Helper function that turns the mouse button pressed and modifier keys held into a identifier string
---@param mouseButtonPressed string
---@return string
function Events:getClickCombination(mouseButtonPressed)
    local ShortcutKeySegments = {};

    if (IsControlKeyDown()) then
        tinsert(ShortcutKeySegments, "CTRL");
    end

    if (IsAltKeyDown()) then
        tinsert(ShortcutKeySegments, "ALT");
    end

    if (IsShiftKeyDown()) then
        tinsert(ShortcutKeySegments, "SHIFT");
    end

    if (not mouseButtonPressed
        or mouseButtonPressed == "LeftButton"
    ) then
        tinsert(ShortcutKeySegments, "CLICK");
    elseif (mouseButtonPressed == "RightButton") then
        tinsert(ShortcutKeySegments, "RIGHTCLICK");
    elseif (mouseButtonPressed == "MiddleButton") then
        tinsert(ShortcutKeySegments, "MIDDLECLICK");
    end

    return table.concat(ShortcutKeySegments, "_");
end

--- Register an event listener
---@param identifier? string|table
---@param event string|function
---@param callback? function
---@return boolean
function Events:register(identifier, event, callback)
    -- The user is attempting a mass assignment, pass it on!
    if (type(identifier) == "table") then
        return self:massRegister(identifier, event);
    end

    -- Events only require an identifier if the event needs to
    -- be unregistered at some point during runtime
    if (identifier == nil) then
        identifier = event .. "Listener" .. GL:uuid();
    end

    if (GL:empty(event)
        or type(callback) ~= "function"
    ) then
        return false;
    end

    -- We're not listening to this event yet, register it
    if (GL:empty(self.Registry.EventListeners[event])) then
        -- We exclude internal events (prefixed with GL.) since we fire
        -- those manually from within the codebase without relying on a frame
        if (not GL:strStartsWith(event, "GL.")) then
            self.Frame:RegisterEvent(event);
        end

        self.Registry.EventListeners[event] = {};
    end

    identifier = identifier or string.format("%s.%s.%s",
        event,
        GetTime(),
        GL:uuid()
    );

    self.Registry.EventByIdentifier[identifier] = event;
    self.Registry.EventListeners[event][identifier] = callback;

    return true;
end

--- Unregister a listener based on its identifier
---@param identifier string|table
function Events:unregister(identifier)
    if (type(identifier) == "table") then
        for _, event in pairs(identifier) do
            self:unregister(event);
        end

        return;
    end

    -- This is to get rid of any reference
    local event = tostring(self.Registry.EventByIdentifier[identifier]);

    -- Make sure the event still exists
    if (GL:empty(event)
        or not self.Registry.EventByIdentifier[identifier]
    ) then
        return;
    end

    self.Registry.EventListeners[event][identifier] = nil;
    self.Registry.EventByIdentifier[identifier] = nil;

    -- Check if the given event still has active listeners
    local eventStillHasListeners = false;
    if (not GL:empty(self.Registry.EventListeners[event])) then
        eventStillHasListeners = true;
    end

    -- There are no longer any listeners for this event
    -- so we can unregister it on our event frame
    if (not eventStillHasListeners) then
        self.Registry.EventListeners[event] = nil;

        -- We exclude internal events (prefixed with GL.) since we fire
        -- those manually from within the codebase without relying on a frame
        if (not GL:strStartsWith(event, "GL.")) then
            self.Frame:UnregisterEvent(event);
        end
    end
end

--- Fire the event listeners whenever a registered event comes in
---@param event string
---@param ... any
function Events:listen(event, ...)
    local args = {...};

    for _, listener in pairs(GL.Events.Registry.EventListeners[event] or {}) do
        pcall(function () listener(event, unpack(args)); end);
    end
end

--- Register multiple event listeners
---@param EventDetails table
---@param callback function
---@return boolean
function Events:massRegister(EventDetails, callback)
    for _, Entry in pairs(EventDetails) do
        local identifier, event;

        if (type(Entry) == "table") then
            identifier = Entry[1];
            event = Entry[2];
        elseif (type(Entry) == "string") then
            event = Entry;
        else
            return false;
        end

        self:register(identifier, event, callback);
    end
end

--- Fire an event manually (assuming there's a listener for it)
---@param event string
---@param ... any
function Events:fire(event, ...)
    self:listen(event, ...);
end
