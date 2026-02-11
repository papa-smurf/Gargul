---@type GL
local _, GL = ...;

--- Shared base for all tests: Assert helpers and generic log. Load first (TOC). E2E tests use Tests/E2E/Base.lua for Runner integration.
GL.Tests = GL.Tests or {};

---@class Assert
local Assert = {
    failures = {},
};

---@return nil
function Assert:reset()
    self.failures = {};
end

---@param condition boolean
---@param message? string
---@return nil
function Assert:assert(condition, message)
    if (not condition) then
        tinsert(self.failures, message or "Assertion failed");
        error(message or "Assertion failed");
    end
end

---@param expected any
---@param actual any
---@param message? string
---@return nil
function Assert:assertEquals(expected, actual, message)
    if (expected ~= actual) then
        local msg = ("%s: expected '%s', got '%s'"):format(
            message or "Value mismatch",
            tostring(expected),
            tostring(actual)
        );
        tinsert(self.failures, msg);
        error(msg);
    end
end

---@param value any
---@param message? string
---@return nil
function Assert:isNil(value, message)
    if (value ~= nil) then
        local msg = message or ("Expected nil, got %s"):format(tostring(value));
        tinsert(self.failures, msg);
        error(msg);
    end
end

GL.Tests.Assert = Assert;

--- Generic test log (prints to Gargul:xd). E2E scenarios use E2E Base's log which also appends to Runner.
---@param message string
---@return nil
function GL.Tests.log(message)
    Gargul:xd(message);
end
