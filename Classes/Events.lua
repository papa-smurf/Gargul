local _, App = ...;

App.Events = {
    _initialized = false,
    Frame = nil,
    Registry = {
        EventListeners = {},
        EventByIdentifier = {},
    },
};

local Utils = App.Utils;
local Events = App.Events;

function Events:_init(EventFrame)
    Utils:debug("Events:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    self.Frame = EventFrame;
    self.Frame:SetScript("OnEvent", self.listen);

    self._initialized = true;
end

-- Register an event listener
function Events:register(identifier, event, callback)
    Utils:debug("Events:register");

    -- We're not listening to this event yet, register it
    if (not self.Registry.EventListeners[event]) then
        self.Frame:RegisterEvent(event);
        self.Registry.EventListeners[event] = {};
    end

    self.Registry.EventByIdentifier[identifier] = event;
    self.Registry.EventListeners[event][identifier] = callback;
end

-- Unregister a listener based on its identifier
function Events:unregister(identifier)
    -- This is to get rid of any reference
    local event = tostring(self.Registry.EventByIdentifier[identifier]);

    self.Registry.EventListeners[event][identifier] = nil;
    self.Registry.EventByIdentifier[identifier] = nil;

    -- Check if the given event still has active listeners
    local eventStillHasListeners = false;
    for key in pairs(self.Registry.EventListeners[event]) do
        eventStillHasListeners = true;
        break;
    end

    -- There are no longer any listeners for this event
    -- so we can unregister it on our event frame
    if (not eventStillHasListeners) then
        self.Frame:UnregisterEvent(event);
    end
end

-- Fire the event listeners whenever a registered event comes in
function Events:listen(event, ...)
    for _, listener in pairs (App.Events.Registry.EventListeners[event]) do
        listener(...);
    end
end

Utils:debug("Events.lua");