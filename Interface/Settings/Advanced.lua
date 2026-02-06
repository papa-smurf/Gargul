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