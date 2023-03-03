---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class ShortcutKeysSettings
GL.Interface.Settings.ShortcutKeys = {
    description = "|cffC41E3AHotkeys are disabled when auction house, mail, shop or bank windows are active!|r",
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
        CTRL_CLICK = "Control + Click",
        CTRL_SHIFT_CLICK = "Control + Shift + Click",
        CTRL_ALT_CLICK = "Control + Alt + Click",
        CTRL_ALT_SHIFT_CLICK = "Control + Alt + Shift + Click",
    };
    local ItemOrder = {
        "DISABLED",
        "SHIFT_CLICK",
        "ALT_CLICK",
        "ALT_SHIFT_CLICK",
        "CTRL_CLICK",
        "CTRL_SHIFT_CLICK",
        "CTRL_ALT_CLICK",
        "CTRL_ALT_SHIFT_CLICK",
    }

    Overview:drawCheckboxes({
        {
            label = "Shortcut Keys reminder",
            description = "Show a reminder when looting an enemy that shows your current shortcut key values",
            setting = "ShortcutKeys.showLegend",
        },
        {
            label = "Hotkeys should only work when I'm in a group",
            setting = "ShortcutKeys.onlyInGroup",
        },
        {
            label = "Double click to trade",
            description = "When double clicking loot trade timers for example, attempt to trade with your current target or add the item to an active trade window (will not work from bags)",
            setting = "ShortcutKeys.doubleClickToTrade",
        },
    }, Parent);

    pcall(function ()
        if (LibStub("ClassicLootManager", true)) then
            Overview:drawCheckboxes({
                {
                    label = "Disable when CLM raid is active",
                    setting = "ShortcutKeys.disableWhenCLMIsActive",
                },
            }, Parent);
        end
    end);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    --[[ ROLLOFF OR AUCTION ]]

    local HelpIcon = AceGUI:Create("Icon");
    HelpIcon:SetWidth(24);
    HelpIcon:SetHeight(24);
    HelpIcon:SetImageSize(12, 12);
    HelpIcon:SetImage("interface/friendsframe/informationicon");
    Parent:AddChild(HelpIcon);

    HelpIcon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(HelpIcon.frame, "ANCHOR_RIGHT");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("If you own an active GDKP session then the auction window will be shown");
        GameTooltip:AddLine("If not then the roll out window will be shown instead");
        GameTooltip:AddLine(" ");
        GameTooltip:Show();
    end);

    HelpIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);

    local RollOffOrAuctionLabel = AceGUI:Create("Label");
    RollOffOrAuctionLabel:SetText("Roll out or auction an item (default alt+click)");
    RollOffOrAuctionLabel:SetColor(1, .95686, .40784);
    RollOffOrAuctionLabel:SetHeight(20);
    RollOffOrAuctionLabel:SetWidth(240);
    Parent:AddChild(RollOffOrAuctionLabel);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(1);
    Parent:AddChild(HorizontalSpacer);

    local RollOffOrAuctionHotkey = AceGUI:Create("Dropdown");
    RollOffOrAuctionHotkey:SetValue(GL.Settings:get("ShortcutKeys.rollOffOrAuction"));
    RollOffOrAuctionHotkey:SetList(DropDownItems, ItemOrder);
    RollOffOrAuctionHotkey:SetText(DropDownItems[GL.Settings:get("ShortcutKeys.rollOffOrAuction")]);
    RollOffOrAuctionHotkey:SetWidth(250);
    RollOffOrAuctionHotkey:SetCallback("OnValueChanged", function()
        GL.Settings:set("ShortcutKeys.rollOffOrAuction", RollOffOrAuctionHotkey:GetValue());
    end);
    Parent:AddChild(RollOffOrAuctionHotkey);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    --[[ AWARD ]]

    local AwardLabel = AceGUI:Create("Label");
    AwardLabel:SetText("Award an item (default alt+shift+click)");
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

    --[[ DISENCHANT ]]

    local DisenchantLabel = AceGUI:Create("Label");
    DisenchantLabel:SetText("Disenchant an item (default ctrl+shift+click)");
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

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    --[[ ROLLOFF ]]

    local RollOffLabel = AceGUI:Create("Label");
    RollOffLabel:SetText("Dedicated roll out hotkey (default disabled)");
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

    --[[ ROLLOFF ]]

    local AuctionLabel = AceGUI:Create("Label");
    AuctionLabel:SetText("Dedicated auction off hotkey (default disabled)");
    AuctionLabel:SetColor(1, .95686, .40784);
    AuctionLabel:SetHeight(20);
    AuctionLabel:SetFullWidth(true);
    Parent:AddChild(AuctionLabel);

    local AuctionHotkey = AceGUI:Create("Dropdown");
    AuctionHotkey:SetValue(GL.Settings:get("ShortcutKeys.auction"));
    AuctionHotkey:SetList(DropDownItems, ItemOrder);
    AuctionHotkey:SetText(DropDownItems[GL.Settings:get("ShortcutKeys.auction")]);
    AuctionHotkey:SetWidth(250);
    AuctionHotkey:SetCallback("OnValueChanged", function()
        GL.Settings:set("ShortcutKeys.auction", AuctionHotkey:GetValue());
    end);
    Parent:AddChild(AuctionHotkey);
end

GL:debug("Interface/Settings/ShortcutKeys.lua");