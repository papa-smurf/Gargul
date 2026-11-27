local L = Gargul_L;

---@type GL
local _, GL = ...;

---@class Profiler
GL.Profiler = {
    addonIndex = nil,
    isVisible = false,
    updateRateInSeconds = 5,
    RefreshTimer = nil,
    Window = nil,

    -- CPU tracking of Gargul's own code, toggled with /gl perf
    tracking = false,
    trackingStartedAt = nil,
    Stats = {},
    Spikes = {},
}

local Profiler = GL.Profiler; ---@type Profiler

local SPIKE_THRESHOLD_IN_MS = 10;
local MAXIMUM_NUMBER_OF_SPIKES = 50;
local NUMBER_OF_REPORT_ROWS = 30;

--- Start tracking how long Gargul's own code takes, or stop and show the results
---
---@return nil
function Profiler:togglePerformanceTracking()
    if (self.tracking) then
        self.tracking = false;
        self:showPerformanceReport();

        return;
    end

    self.Stats = {};
    self.Spikes = {};
    self.trackingStartedAt = GetTime();
    self.tracking = true;

    GL:notice(L["Tracking Gargul's CPU usage. Type /gl perf again to stop and see the results"]);
end

---@param label string
---@param startedAt number
---@return any
local function finishMeasurement(label, startedAt, ...)
    Profiler:record(label, debugprofilestop() - startedAt);

    return ...;
end

--- Call func and, while tracking, record how long it took
---
---@param label string
---@param func function
---@return any
function Profiler:measure(label, func, ...)
    if (not self.tracking) then
        return func(...);
    end

    local startedAt = debugprofilestop();

    return finishMeasurement(label, startedAt, func(...));
end

---@param label string
---@param milliseconds number
---@return nil
function Profiler:record(label, milliseconds)
    local Entry = self.Stats[label];

    if (not Entry) then
        Entry = { calls = 0, total = 0, max = 0, };
        self.Stats[label] = Entry;
    end

    Entry.calls = Entry.calls + 1;
    Entry.total = Entry.total + milliseconds;

    if (milliseconds > Entry.max) then
        Entry.max = milliseconds;
        Entry.maxAt = date("%H:%M:%S");
    end

    if (milliseconds >= SPIKE_THRESHOLD_IN_MS) then
        table.insert(self.Spikes, { at = date("%H:%M:%S"), label = label, milliseconds = milliseconds, });

        if (#self.Spikes > MAXIMUM_NUMBER_OF_SPIKES) then
            table.remove(self.Spikes, 1);
        end
    end
end

--- Show the slowest calls recorded since tracking started
---
---@return nil
function Profiler:showPerformanceReport()
    local Rows = {};

    for label, Entry in pairs(self.Stats) do
        table.insert(Rows, { label = label, Entry = Entry, });
    end

    table.sort(Rows, function (a, b)
        return a.Entry.max > b.Entry.max;
    end);

    local Lines = {
        ("Gargul v%s, tracked for %d seconds. Times are in ms, a call's time includes any Gargul calls it made."):format(
            GL.version,
            math.floor(GetTime() - (self.trackingStartedAt or GetTime()))
        ),
        "",
        ("Calls that took %dms or longer (last %d):"):format(SPIKE_THRESHOLD_IN_MS, MAXIMUM_NUMBER_OF_SPIKES),
    };

    if (#self.Spikes == 0) then
        table.insert(Lines, "  None");
    end

    for _, Spike in ipairs(self.Spikes) do
        table.insert(Lines, ("  %s  %.1f  %s"):format(Spike.at, Spike.milliseconds, Spike.label));
    end

    table.insert(Lines, "");
    table.insert(Lines, ("Slowest %d by worst call (max at time | avg | total | calls | label):"):format(NUMBER_OF_REPORT_ROWS));

    for index = 1, math.min(#Rows, NUMBER_OF_REPORT_ROWS) do
        local Row = Rows[index];
        local Entry = Row.Entry;

        table.insert(Lines, ("  %.1f at %s | %.2f | %.1f | %d | %s"):format(
            Entry.max,
            Entry.maxAt or "-",
            Entry.total / Entry.calls,
            Entry.total,
            Entry.calls,
            Row.label
        ));
    end

    GL:frameMessage(table.concat(Lines, "\n"));
end

--- Draw the profiler window and keep it updated
---
---@return nil
function Profiler:draw()
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    local Window = GL.AceGUI:Create("Frame");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetLayout("Flow");
    Window:SetWidth(180);
    Window:SetHeight(60);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetPoint(GL.Interface:getPosition("Profiler"));
    Window.frame:SetScale(.8);
    Window:SetCallback("OnClose", function ()
        self:close();
    end);
    Window.frame:SetScript("OnLeave", function ()
        self:storePosition();
    end);
    self.Window = Window;

    -- Remove the close button
    local CloseButton = GL:fetchCloseButtonFromAceGUIWidget(Window);
    if (CloseButton) then
        CloseButton:Hide();
    end

    local VerticalSpacer = GL.AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(4);
    Window:AddChild(VerticalSpacer);

    local Usage = GL.AceGUI:Create("Label");
    Usage:SetFontObject(_G.GameFontNormal);
    Usage:SetFullWidth(true);
    Usage:SetJustifyH("CENTER");
    Window:AddChild(Usage);
    self.Usage = Usage;

    local updateMemoryUsage = function ()
        local memory = self:getMemoryUsage();

        -- Use color to indicate the severety of the memory usage
        local function memoryColor(number)
            local color = "92FF00";
            if (number >= 8000) then
                color = "FFF569";
            elseif (number >= 15000) then
                color = "F7922E";
            elseif (number >= 30000) then
                color = "BE3333";
            end

            return color;
        end

        Usage:SetText(("MEM: |c00%s%s|rk"):format(
            memoryColor(memory),
            self:humanReadableNumber(memory)
        ));
    end;

    -- Make sure the usage gets updated every X seconds
    GL:cancelTimer(self.RefreshTimer); -- Just in case
    self.RefreshTimer = GL:interval(self.updateRateInSeconds, "Profiler.RefreshTimer", function ()
        updateMemoryUsage();
    end);

    updateMemoryUsage();
end

--- Make large numbers human readble
---
---@param number number
---
---@return string
function Profiler:humanReadableNumber(number)
    local pattern = "%.1f";
    local numberString = (pattern):format(number);

    if (number >= 1000) then
        local subCount;
        repeat
            numberString, subCount = numberString:gsub("^(-?%d+)(%d%d%d)","%1,%2");
        until subCount == 0
    end

    return numberString;
end

--- Close the profile, cancel the refreshtimer
---
---@return nil
function Profiler:close()
    if (not self.isVisible) then
        return;
    end

    GL:cancelTimer(self.RefreshTimer);
    self:storePosition();
    self.Window:Hide();
    self.isVisible = false;
end

--- Store the profiler's position so it persists between playsessions
---
---@return nil
function Profiler:storePosition()
    GL.Interface:storePosition(self.Window, "Profiler");
end

--- Get the memory usage for Gargul in bytes
---
---@return number
function Profiler:getMemoryUsage()
    UpdateAddOnMemoryUsage();

    local usage = GetAddOnMemoryUsage("Gargul");

    return usage;
end
