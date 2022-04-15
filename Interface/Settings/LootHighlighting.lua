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
            label = "Disable highlighting",
            description = "Checking this will make sure that no item will ever be highlighted, regardless of the other settings below",
            setting = "highlightsDisabled",
        },
        {
            label = "Highlight only my own items",
            description = "Checking this will make sure that, while not master looting, items will only receive a glow if they are reserved by you or on your TMB list(s)",
            setting = "highlightMyItemsOnly",
        },
        {
            label = "SoftRes: Highlight soft-reserved items",
            description = "Checking this will make sure that items that are soft-reserved are highlighted\n(yellow glow)",
            setting = "highlightSoftReservedItems",
        },
        {
            label = "SoftRes: Highlight hard-reserved items",
            description = "Checking this will make sure that items that are hard-reserved are highlighted\n(red glow)",
            setting = "highlightHardReservedItems",
        },
        {
            label = "TMB: Highlight wishlisted items",
            description = "Checking this will make sure that items that are on someone's wishlist are highlighted\n(white glow)",
            setting = "highlightWishlistedItems",
        },
        {
            label = "TMB: Highlight LC items",
            description = "Checking this will make sure that items that have a character (LC) priority are highlighted\n(orange glow)",
            setting = "highlightPriolistedItems",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);
end

GL:debug("Interface/Settings/LootHighlighting.lua");