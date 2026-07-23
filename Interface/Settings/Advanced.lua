---@type GL
local _, GL = ...;

---@type SettingsOverview
local Overview = GL.Interface.Settings.Overview;

---@class AdvancedSettings
GL.Interface.Settings.Advanced = {};
local Advanced = GL.Interface.Settings.Advanced; ---@type AdvancedSettings

---@return nil
function Advanced:draw(Parent)
    GL:debug("AdvancedSettings:draw");

    Overview:drawCheckboxes({
        {
            label = "Experimental: debug mode",
            description = "Enable debug mode, showing debug info in your chatbox. This is only meant for developers actively working on the Gargul add-on",
            setting = "debugModeEnabled",
        },
        {
            label = "Experimental: comm debug mode",
            description = "Enable comm debug output, showing add-on message traffic info in your chatbox.",
            setting = "commDebugEnabled",
        },
        {
            label = "Experimental: comm session recorder (for support)",
            description = "Record all Gargul add-on communication this session (sends, receives, drops, timing, roll-off starts and queue pressure). Reproduce your issue, then run /gl commtrace to export a report you can share on Discord. Auto-disables after a while.",
            setting = "commTraceEnabled",
            callback = function ()
                GL.CommRecorder:setEnabled(GL.Settings:get("commTraceEnabled"));
            end,
        },
        {
            label = "Experimental: addon usage",
            description = "Show add-on memory usage. Warning: may cause FPS drop!",
            setting = "profilerEnabled",
            callback = function ()
                if (GL.Settings:get("profilerEnabled")) then
                    GL.Profiler:draw();
                else
                    GL.Profiler:close();
                end
            end,
        },
    }, Parent);
end

GL:debug("Interface/Settings/Advanced.lua");