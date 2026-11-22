---@type GL
local _, GL = ...;

GL.Tests = GL.Tests or {};
GL.Tests.Fakes = GL.Tests.Fakes or {};

--- Private global environment for Gargul's own code while a fake is installed.
---
--- Fakes must never write to _G: any addon write to a Blizzard global taints it for the rest of the
--- session, even when the original value is put back. Tainted Blizzard UI then errors on secret values (Forever).
--- Instead, Gargul's functions get a proxy environment that serves overrides first and falls back to _G.
---@class TestsEnvFake
local Env = {
    active = false,
    Overrides = {},
    SwappedFunctions = {},
};

GL.Tests.Fakes.Env = Env; ---@type TestsEnvFake

--- Shallow namespaces (functions only) whose code reads the faked APIs.
--- Embedded libraries (GL.Ace etc.) are shared with other addons and must never be swapped.
local NAMESPACES = { "PackMule", "DroppedLoot", "AwardedLoot", "User", "Events", };

local realGetglobal = getglobal;

local Builtins = {
    -- DroppedLoot looks up loot buttons with getglobal, which reads the real _G
    getglobal = function (name)
        local value = Env.Overrides[name];
        if (value ~= nil) then
            return value;
        end

        return realGetglobal(name);
    end,
};

local Proxy = setmetatable({}, {
    __index = function (_, key)
        local value = Env.Overrides[key];
        if (value ~= nil) then
            return value;
        end

        if (Env.active and Builtins[key] ~= nil) then
            return Builtins[key];
        end

        return _G[key];
    end,
    __newindex = function (_, key, value)
        _G[key] = value;
    end,
});

---@param func function
---@return nil
function Env:swap(func)
    if (type(func) ~= "function" or self.SwappedFunctions[func]) then
        return;
    end

    -- C functions and functions with their own environment are left alone
    local ok, previous = pcall(getfenv, func);
    if (not ok or previous ~= _G) then
        return;
    end

    if (pcall(setfenv, func, Proxy)) then
        self.SwappedFunctions[func] = previous;
    end
end

---@param Namespace table|nil
---@return nil
function Env:swapNamespace(Namespace)
    if (type(Namespace) ~= "table") then
        return;
    end

    for _, value in pairs(Namespace) do
        if (type(value) == "function") then
            self:swap(value);
        end
    end
end

--- Point Gargul's functions and event listeners at the proxy environment.
--- Closures created by swapped functions (timers, one-off listeners) inherit the proxy automatically.
---@return nil
function Env:activate()
    if (self.active) then
        return;
    end

    self.active = true;
    self:swapNamespace(GL);
    for _, namespace in ipairs(NAMESPACES) do
        self:swapNamespace(GL[namespace]);
    end

    for _, Listeners in pairs(GL.Events.Registry.EventListeners or {}) do
        self:swapNamespace(Listeners);
    end
end

---@return nil
function Env:deactivate()
    for func, previous in pairs(self.SwappedFunctions) do
        pcall(setfenv, func, previous);
    end

    self.SwappedFunctions = {};
    self.Overrides = {};
    self.active = false;
end

--- Closures created while active keep the proxy, which forwards everything to _G once the overrides are gone.
---@param name string
---@param value any
---@return nil
function Env:set(name, value)
    self.Overrides[name] = value;
end

---@param name string
---@return nil
function Env:clear(name)
    self.Overrides[name] = nil;
end

return Env;
