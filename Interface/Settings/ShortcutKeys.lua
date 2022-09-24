---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class ShortcutKeysSettings
GL.Interface.Settings.ShortcutKeys = {
    description = "By default Gargul offers 3 shortcut keys that you can use when clicking items in your bag, an enemy's loot window or the trade timers",
};
local ShortcutKeys = GL.Interface.Settings.ShortcutKeys; ---@type ShortcutKeysSettings

---@return void
function ShortcutKeys:draw(Parent)
    GL:debug("ShortcutKeys:draw");

    local HorizontalSpacer;
    local AceGUI = GL.AceGUI;
    local DropDownItems = {
        DISABLED = "Disable",
        SHIFT_CLICK = "Shift + Click",
        ALT_CLICK = "Alt + Click",
        ALT_SHIFT_CLICK = "Alt + Shift + Click",
        ALT_RIGHTCLICK = "Alt + Right Click",
        ALT_SHIFT_RIGHTCLICK = "Alt + Shift + Right Click",
        CTRL_CLICK = "Control + Click",
        CTRL_SHIFT_CLICK = "Control + Shift + Click",
        CTRL_RIGHTCLICK = "Control + Right Click",
        CTRL_SHIFT_RIGHTCLICK = "Control + Shift + Right Click",
        CTRL_ALT_CLICK = "Control + Alt + Click",
        CTRL_ALT_SHIFT_CLICK = "Control + Alt + Shift + Click",
        CTRL_ALT_RIGHTCLICK = "Control + Alt + Right Click",
        CTRL_ALT_SHIFT_RIGHTCLICK = "Control + Alt + Shift + Right Click",
    };
    local ItemOrder = {
        "DISABLED",
        "SHIFT_CLICK",
        "ALT_CLICK",
        "ALT_SHIFT_CLICK",
        "ALT_RIGHTCLICK",
        "ALT_SHIFT_RIGHTCLICK",
        "CTRL_CLICK",
        "CTRL_SHIFT_CLICK",
        "CTRL_RIGHTCLICK",
        "CTRL_SHIFT_RIGHTCLICK",
        "CTRL_ALT_CLICK",
        "CTRL_ALT_SHIFT_CLICK",
        "CTRL_ALT_RIGHTCLICK",
        "CTRL_ALT_SHIFT_RIGHTCLICK",
    }

    local Checkboxes = {
        {
            label = "Shortcut Keys reminder",
            description = "Show a reminder when looting an enemy that shows your current shortcut key values",
            setting = "ShortcutKeys.showLegend",
        },
    }

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local RollOffLabel = AceGUI:Create("Label");
    RollOffLabel:SetText("Set the hotkey for opening the master loot window where you can start a roll (default alt+click)");
    RollOffLabel:SetColor(1, .95686, .40784);
    RollOffLabel:SetHeight(20);
    RollOffLabel:SetFullWidth(true);
    Parent:AddChild(RollOffLabel);

    local RollOffHotkey = AceGUI:Create("Dropdown");
    RollOffHotkey:SetValue(GL.Settings:get("ShortcutKeys.rollOff"));
    RollOffHotkey:SetList(DropDownItems, ItemOrder);
    RollOffHotkey:SetText(DropDownItems[GL.Settings:get("ShortcutKeys.rollOff")]);
    RollOffHotkey:SetWidth(250);
    RollOffHotkey:SetCallback("OnValueChanged", function()
        GL.Settings:set("ShortcutKeys.rollOff", RollOffHotkey:GetValue());
    end);
    Parent:AddChild(RollOffHotkey);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local AwardLabel = AceGUI:Create("Label");
    AwardLabel:SetText("Set the hotkey for opening the item award window (default alt+shift+click)");
    AwardLabel:SetColor(1, .95686, .40784);
    AwardLabel:SetHeight(20);
    AwardLabel:SetFullWidth(true);
    Parent:AddChild(AwardLabel);

    local AwardHotkey = AceGUI:Create("Dropdown");
    AwardHotkey:SetValue(GL.Settings:get("ShortcutKeys.award"));
    AwardHotkey:SetList(DropDownItems, ItemOrder);
    AwardHotkey:SetText(DropDownItems[GL.Settings:get("ShortcutKeys.award")]);
    AwardHotkey:SetWidth(250);
    AwardHotkey:SetCallback("OnValueChanged", function()
        GL.Settings:set("ShortcutKeys.award", AwardHotkey:GetValue());
    end);
    Parent:AddChild(AwardHotkey);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local DisenchantLabel = AceGUI:Create("Label");
    DisenchantLabel:SetText("Set the hotkey for disenchanting an item from an enemy's loot window (default ctrl+shift+click)");
    DisenchantLabel:SetColor(1, .95686, .40784);
    DisenchantLabel:SetHeight(20);
    DisenchantLabel:SetFullWidth(true);
    Parent:AddChild(DisenchantLabel);

    local DisenchantHotkey = AceGUI:Create("Dropdown");
    DisenchantHotkey:SetValue(GL.Settings:get("ShortcutKeys.disenchant"));
    DisenchantHotkey:SetList(DropDownItems, ItemOrder);
    DisenchantHotkey:SetText(DropDownItems[GL.Settings:get("ShortcutKeys.disenchant")]);
    DisenchantHotkey:SetWidth(250);
    DisenchantHotkey:SetCallback("OnValueChanged", function()
        GL.Settings:set("ShortcutKeys.disenchant", DisenchantHotkey:GetValue());
    end);
    Parent:AddChild(DisenchantHotkey);
end

GL:debug("Interface/Settings/ShortcutKeys.lua");