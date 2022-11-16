---@type GL
local _, GL = ...;

---@type SettingsOverview
local Overview = GL.Interface.Settings.Overview;

---@type Interface
local Interface = GL.Interface;

local AceGUI = GL.AceGUI;

---@class LootTradeTimersSettings
Interface.Settings.LootTradeTimers = {
    description = "When obtaining items that have time left to trade, aka items that are BoP but can still be traded with raid members, Gargul can show timer bars to let you know when an item's trade window is coming to an end.",
    testEnabled = false,
};
local LootTradeTimers = Interface.Settings.LootTradeTimers; ---@type LootTradeTimersSettings

---@return void
function LootTradeTimers:draw(Parent)
    GL:debug("LootTradeTimers:draw");

    local Scale = GL.AceGUI:Create("Slider");
    Scale:SetLabel("Magnification scale of the loot trade timers window");
    Scale.label:SetTextColor(1, .95686, .40784);
    Scale:SetFullWidth(true);
    Scale:SetValue(GL.Settings:get("LootTradeTimers.scale", 35));
    Scale:SetSliderValues(.2, 1.8, .1);
    Scale:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (value) then
            GL.Settings:set("LootTradeTimers.scale", value);

            -- Change the loot trade timer window if it's active!
            if (Interface.TradeWindow.TimeLeft.Window
                and type(Interface.TradeWindow.TimeLeft.Window.SetScale == "function")
            ) then
                Interface.TradeWindow.TimeLeft.Window:SetScale(value);
            end
        end
    end);
    Parent:AddChild(Scale);

    local NumberOfTimerBars = GL.AceGUI:Create("Slider");
    NumberOfTimerBars:SetLabel("Maximum number of active countdown bars");
    NumberOfTimerBars.label:SetTextColor(1, .95686, .40784);
    NumberOfTimerBars:SetFullWidth(true);
    NumberOfTimerBars:SetValue(GL.Settings:get("LootTradeTimers.maximumNumberOfBars", 5));
    NumberOfTimerBars:SetSliderValues(1, 100, 1);
    NumberOfTimerBars:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (type(value) ~= nil) then
            GL.Settings:set("LootTradeTimers.maximumNumberOfBars", value);
            Interface.TradeWindow.TimeLeft:refreshBars();
        end
    end);
    Parent:AddChild(NumberOfTimerBars);

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
                Interface.TradeWindow.TimeLeft:refreshBars();
            end,
        },
        {
            label = "Only show bars when I'm the master looter",
            setting = "LootTradeTimers.showOnlyWhenMasterLooting",
            callback = function ()
                Interface.TradeWindow.TimeLeft:refreshBars();
            end,
        },
        {
            label = "Show hotkey reminder",
            setting = "LootTradeTimers.showHotkeyReminder",
            callback = function ()
                Interface.TradeWindow.TimeLeft:refreshBars();
            end,
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(15);
    Parent:AddChild(Spacer);

    local TrophyIcon = AceGUI:Create("Icon");
    TrophyIcon:SetWidth(30);
    TrophyIcon:SetHeight(30);
    TrophyIcon:SetImageSize(20, 20);
    TrophyIcon:SetImage("Interface\\AddOns\\Gargul\\Assets\\Icons\\trophy-white");
    Parent:AddChild(TrophyIcon);

    local TrophyExplanation = GL.AceGUI:Create("Label");
    TrophyExplanation:SetText("This icon indicates that the item was already awarded");
    Parent:AddChild(TrophyExplanation);

    local DisenchantIcon = AceGUI:Create("Icon");
    DisenchantIcon:SetWidth(30);
    DisenchantIcon:SetHeight(30);
    DisenchantIcon:SetImageSize(20, 20);
    DisenchantIcon:SetImage("Interface\\AddOns\\Gargul\\Assets\\Icons\\disenchant-white");
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
    DemoTradeTimersButton:SetCallback("OnClick", function()
        -- Disable test mode
        if (self.testEnabled) then
            self.testEnabled = false;
            DemoTradeTimersButton:SetText("Demo");
            Interface.TradeWindow.TimeLeft:refreshBars();

            return;
        end

        -- Enable test mode
        self.testEnabled = true;
        DemoTradeTimersButton:SetText("Stop");
        Interface.TradeWindow.TimeLeft:refreshBars();
    end);
    Parent:AddChild(DemoTradeTimersButton);
end

GL:debug("Interface/Settings/TMB.lua");