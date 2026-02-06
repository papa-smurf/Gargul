---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class MinimapSettings
GL.Interface.Settings.MinimapButton = {};
local MinimapButton = GL.Interface.Settings.MinimapButton; ---@type MinimapSettings

--[[ CONSTANTS ]]
local SHORTCUTS = {
    "CLICK",
    "RIGHTCLICK",
    "MIDDLECLICK",
    "SHIFT_CLICK",
    "SHIFT_RIGHTCLICK",
    "SHIFT_MIDDLECLICK",
    "ALT_CLICK",
    "ALT_RIGHTCLICK",
    "ALT_MIDDLECLICK",
    "CTRL_CLICK",
    "CTRL_RIGHTCLICK",
    "CTRL_MIDDLECLICK",
    "ALT_SHIFT_CLICK",
    "ALT_SHIFT_RIGHTCLICK",
    "ALT_SHIFT_MIDDLECLICK",
    "CTRL_SHIFT_CLICK",
    "CTRL_SHIFT_RIGHTCLICK",
    "CTRL_SHIFT_MIDDLECLICK",
};

local ITEM_ORDER = {
    "DISABLED",
    "GARGUL",
    "SOFTRES",
    "GDKP",
    "GDKP_LEDGER",
    "GDKP_CUTS",
    "MULTIAUCTION",
    "IMPORT",
    "EXPORT",
    "AWARDHISTORY",
    "PLUS_ONE",
    "BOOSTED_ROLLS",
};

local DROPDOWN_ITEMS = {
    DISABLED = "Do nothing",
    GARGUL = "Open Gargul",
    SOFTRES = "Softres",
    GDKP = "GDKP",
    GDKP_LEDGER = "GDKP Ledger",
    GDKP_CUTS = "GDKP Cuts",
    MULTIAUCTION = "GDKP Multiauction",
    IMPORT = "Import data",
    EXPORT = "Export data",
    AWARDHISTORY = "Loot history",
    PLUS_ONE = "Manage +1",
    BOOSTED_ROLLS = "Boosted rolls",
};

---@return nil
function MinimapButton:draw(Parent)
    local HorizontalSpacer;
    local AceGUI = GL.AceGUI;

    Overview:drawCheckboxes({
        {
            label = "Enable minimap Icon",
            setting = "MinimapButton.enabled",
            callback = function()
                GL.MinimapButton:drawOrHide();
            end,
        },
    }, Parent);

    for _, shortcut in pairs(SHORTCUTS) do
        HorizontalSpacer = AceGUI:Create("SimpleGroup");
        HorizontalSpacer:SetLayout("FILL");
        HorizontalSpacer:SetFullWidth(true);
        HorizontalSpacer:SetHeight(20);
        Parent:AddChild(HorizontalSpacer);

        local Label = AceGUI:Create("Label");
        Label:SetText("On " .. shortcut);
        Label:SetColor(1, .95686, .40784);
        Label:SetHeight(20);
        Label:SetWidth(240);
        Parent:AddChild(Label);

        HorizontalSpacer = AceGUI:Create("SimpleGroup");
        HorizontalSpacer:SetLayout("FILL");
        HorizontalSpacer:SetFullWidth(true);
        HorizontalSpacer:SetHeight(1);
        Parent:AddChild(HorizontalSpacer);

        local Dropdown = AceGUI:Create("Dropdown");
        Dropdown:SetValue(GL.Settings:get("MinimapButton.Actions." .. shortcut));
        Dropdown:SetList(DROPDOWN_ITEMS, ITEM_ORDER);
        Dropdown:SetText(DROPDOWN_ITEMS[GL.Settings:get("MinimapButton.Actions." .. shortcut)]);
        Dropdown:SetWidth(250);
        Dropdown:SetCallback("OnValueChanged", function()
            GL.Settings:set("MinimapButton.Actions." .. shortcut, Dropdown:GetValue());
        end);
        Parent:AddChild(Dropdown);
    end
end

GL:debug("Interface/Settings/Minimap.lua");