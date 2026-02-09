---@type GL
local _, GL = ...;

---@type SettingsOverview
local Overview = GL.Interface.Settings.Overview;

---@type Interface
local Interface = GL.Interface;

local AceGUI = GL.AceGUI;

---@class LootTradeTimersSettings
Interface.Settings.LootTradeTimers = {
    description = "When obtaining items that have time left to trade, Gargul can show timer to let you know when an item's trade window is coming to an end. You can use these bars to directly roll out or award loot!",
    testEnabled = false,
};
local LootTradeTimers = Interface.Settings.LootTradeTimers; ---@type LootTradeTimersSettings

---@return nil
function LootTradeTimers:draw(Parent)
    GL:debug("LootTradeTimers:draw");

    local NumberOfTimerBars = GL.AceGUI:Create("Slider");
    NumberOfTimerBars:SetLabel("Maximum number of active countdown bars");
    NumberOfTimerBars.label:SetTextColor(1, .95686, .40784);
    NumberOfTimerBars:SetFullWidth(true);
    NumberOfTimerBars:SetValue(min(GL.Settings:get("LootTradeTimers.maximumNumberOfBars", 12), 12));
    NumberOfTimerBars:SetSliderValues(1, 12, 1);
    NumberOfTimerBars:SetCallback("OnValueChanged", function (Slider)
        local value = tonumber(Slider:GetValue());

        if (type(value) ~= nil) then
            GL.Settings:set("LootTradeTimers.maximumNumberOfBars", min(value, 12));
            Interface.TradeTime.Overview:refresh();
        end
    end);
    Parent:AddChild(NumberOfTimerBars);

    local Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local MaximumTradeTimeLeft = GL.AceGUI:Create("Slider");
    MaximumTradeTimeLeft:SetLabel("Maximum trade time left before showing (in minutes)");
    MaximumTradeTimeLeft.label:SetTextColor(1, .95686, .40784);
    MaximumTradeTimeLeft:SetFullWidth(true);
    MaximumTradeTimeLeft:SetValue(GL.Settings:get("LootTradeTimers.maximumTradeTimeLeft", 120));
    MaximumTradeTimeLeft:SetSliderValues(1, 120, 1);
    MaximumTradeTimeLeft:SetCallback("OnValueChanged", function (Slider)
        local value = tonumber(Slider:GetValue());

        if (type(value) ~= nil) then
            GL.Settings:set("LootTradeTimers.maximumTradeTimeLeft", value);
            Interface.TradeTime.Overview:refresh();
        end
    end);
    Parent:AddChild(MaximumTradeTimeLeft);

    local Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local Checkboxes = {
        {
            label = "Timer bars",
            description = "Show timer bars for BoP items that can still be traded for a limited time",
            setting = "LootTradeTimers.enabled",
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            label = "Only show bars when I'm the master looter",
            setting = "LootTradeTimers.showOnlyWhenMasterLooting",
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            label = "Hide all awarded items",
            setting = "LootTradeTimers.hideAwarded",
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            label = "Hide items awarded to self",
            setting = "LootTradeTimers.hideAwardedToSelf",
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            label = "Hide disenchanted items",
            setting = "LootTradeTimers.hideDisenchanted",
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(15);
    Parent:AddChild(Spacer);

    local BarColorExplanation = GL.AceGUI:Create("Label");
    BarColorExplanation:SetText("Trade timer bars will turn black and get one of the icons listed below when processed\n\n");
    BarColorExplanation:SetFullWidth(true);
    Parent:AddChild(BarColorExplanation);

    local TrophyIcon = AceGUI:Create("Icon");
    TrophyIcon:SetWidth(30);
    TrophyIcon:SetHeight(30);
    TrophyIcon:SetImageSize(20, 20);
    TrophyIcon:SetImage("Interface\\AddOns\\Gargul\\Assets\\Icons\\trophy");
    Parent:AddChild(TrophyIcon);

    local TrophyExplanation = GL.AceGUI:Create("Label");
    TrophyExplanation:SetText("This icon indicates that the item was already awarded");
    Parent:AddChild(TrophyExplanation);

    local DisenchantIcon = AceGUI:Create("Icon");
    DisenchantIcon:SetWidth(30);
    DisenchantIcon:SetHeight(30);
    DisenchantIcon:SetImageSize(20, 20);
    DisenchantIcon:SetImage("Interface\\AddOns\\Gargul\\Assets\\Icons\\disenchant");
    Parent:AddChild(DisenchantIcon);

    local DisenchantExplanation = GL.AceGUI:Create("Label");
    DisenchantExplanation:SetText("This icon indicates that the item was marked for disenchantment");
    Parent:AddChild(DisenchantExplanation);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(15);
    Parent:AddChild(Spacer);

    local ButtonText = "Demo";
    if (self.testEnabled == true) then
        ButtonText = "Stop";
    end

    local DemoTradeTimersButton = GL.AceGUI:Create("Button");
    DemoTradeTimersButton:SetText(ButtonText);
    DemoTradeTimersButton:SetCallback("OnClick", function ()
        -- Disable test mode
        if (self.testEnabled) then
            self.testEnabled = false;
            DemoTradeTimersButton:SetText("Demo");
            Interface.TradeTime.Overview:refresh();

            return;
        end

        -- Enable test mode
        self.testEnabled = true;
        DemoTradeTimersButton:SetText("Stop");
        Interface.TradeTime.Overview:refresh();
        GL.Events:fire("BAG_UPDATE_DELAYED");
    end);
    Parent:AddChild(DemoTradeTimersButton);
end

GL:debug("Interface/Settings/TMB.lua");