---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class LootHighlightingSettings
GL.Interface.Settings.LootHighlighting = {
    description = "By default Gargul will highlight items by applying an animated border, both in a boss' loot window as well as on items that pop up when group loot is active. The settings below allow you to change this behaviour or disable it entirely.",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Item-Highlighting",
};
local LootHighlighting = GL.Interface.Settings.LootHighlighting; ---@type LootHighlightingSettings

---@return void
function LootHighlighting:draw(Parent)
    GL:debug("LootHighlightingSettings:draw");

    local Checkboxes = {
        {
            label = "Highlight items",
            description = "Enable or disable all highlighting, regardless of the settings below",
            setting = "highlightsEnabled",
        },
        {
            label = "Highlight only my own items",
            description = "Items will only receive a glow if they are reserved by you or on your TMB list(s)",
            setting = "highlightMyItemsOnly",
        },
        {
            label = "SoftRes: Highlight soft-reserved items",
            description = "Soft-reserved are highlighted\n(yellow glow)",
            setting = "highlightSoftReservedItems",
        },
        {
            label = "SoftRes: Highlight hard-reserved items",
            description = "Hard-reserved are highlighted\n(red glow)",
            setting = "highlightHardReservedItems",
        },
        {
            label = "TMB/DFT: Highlight wishlisted items",
            description = "Wishlisted items are highlighted\n(white glow)",
            setting = "highlightWishlistedItems",
        },
        {
            label = "TMB/DFT: Highlight LC items",
            description = "Items that have a character (LC) priority are highlighted\n(orange glow)",
            setting = "highlightPriolistedItems",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/LootHighlighting.lua");