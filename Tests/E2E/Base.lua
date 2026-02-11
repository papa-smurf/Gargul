---@type GL
local _, GL = ...;

--- Shared helpers for E2E scenario tests. Scenarios set metatable __index to this table,
--- implement stop(), start(), and set self.steps (array of { title, fn }) before runStep(1).
--- runStep, next, retry are defined here; steps use self:next(delay) or self:retry(delay).
GL.Tests.E2E = GL.Tests.E2E or {};

---@class E2EBase
---@field stop fun(self: E2EBase) Implemented by each scenario.
---@field scenarioName string|nil Set by each scenario.
---@field steps table|nil Array of { title = string, fn = string }; set by scenario before runStep(1).
local Base = GL.Tests.E2E.Base or {};
GL.Tests.E2E.Base = Base; ---@type E2EBase

---@param message string
---@return nil
function Base:log(message)
    Gargul:xd(("[E2E] %s"):format(message));
    local runner = GL.Interface.Tests.Runner;
    if (runner and runner.isVisible and self.runnerStep and self.runnerStep > 0) then
        runner:appendStepLog(self.runnerStep, message);
    end
end

---@param message string
---@return nil
function Base:success(message)
    Gargul:xd(("[E2E] [OK] %s"):format(message));
    local runner = GL.Interface.Tests.Runner;
    if (runner and runner.isVisible and self.runnerStep and self.runnerStep > 0) then
        runner:setStepStatus(self.runnerStep, "success", message);
    end
end

---@param message string
---@return nil
function Base:error(message)
    Gargul:xd(("[E2E] [FAIL] ERROR: %s"):format(message));
    local runner = GL.Interface.Tests.Runner;
    if (runner and runner.isVisible and self.runnerStep and self.runnerStep > 0) then
        runner:setStepStatus(self.runnerStep, "fail", message);
    end
    self:stop();
end

---@param delay number
---@param callback function
---@return nil
function Base:scheduleNext(delay, callback)
    local name = self.scenarioName or "E2E";
    local step = (self.runnerStep and self.runnerStep > 0) and self.runnerStep or 1;
    GL:after(delay, ("E2E.%s.Step%d"):format(name, step), callback);
end

--- Reset common runner state. Call at the start of scenario stop() before scenario-specific cleanup.
---@return nil
function Base:resetRunnerState()
    self.isRunning = false;
    self.runnerStep = 0;
end

--- Run step i (1-based). Uses self.steps; each entry is { title = string, fn = string method name }.
---@param i number
---@return nil
function Base:runStep(i)
    local steps = self.steps or {};
    if (i < 1 or i > #steps) then
        return;
    end
    self.runnerStep = i;
    local step = steps[i];
    local fn = self[step.fn];
    if (type(fn) == "function") then
        fn(self);
    end
end

--- Advance to the next step after delay (default 1). Stop if no more steps.
---@param delay number|nil Seconds before next step (nil = 1, 0 = immediate)
---@return nil
function Base:next(delay)
    local steps = self.steps or {};
    self.runnerStep = self.runnerStep + 1;
    if (self.runnerStep > #steps) then
        self:stop();
        return;
    end
    delay = delay == nil and 1 or delay;
    if (delay > 0) then
        self:scheduleNext(delay, function () self:runStep(self.runnerStep); end);
    else
        self:runStep(self.runnerStep);
    end
end

--- Re-run the current step after delay (default 1). For retry/polling.
---@param delay number|nil
---@return nil
function Base:retry(delay)
    self:scheduleNext(delay or 1, function () self:runStep(self.runnerStep); end);
end

--- Return step title strings for the Runner. Override in scenario to use local E2E_STEPS (needed when Launcher opens Runner before start()).
---@return table Array of step title strings
function Base:getStepTitles()
    if (self.steps) then
        local t = {};
        for _, s in ipairs(self.steps) do
            tinsert(t, s.title);
        end
        return t;
    end
    return {};
end

--- Open Runner UI and set state. Scenario then sets self.steps and calls runStep(1).
---@param title string
---@param scenarios table Array of { name = string, steps = table } (steps = array of title strings)
---@return nil
function Base:startWith(title, scenarios)
    if (self.isRunning) then
        self:log(("Test already running. Use /run Gargul.Tests.E2E.%s:stop() to stop it first."):format(self.scenarioName or "E2E"));
        return;
    end

    self.isRunning = true;
    self.runnerStep = 0;

    GL.Interface.Tests.Runner:open(title, scenarios);
    self:log("========== Starting Visual E2E Test ==========");
end
