---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class LootTradeTimersSettings
GL.Interface.Settings.LootTradeTimers = {
    description = "When obtaining items that have time left to trade, aka items that are BoP but can still be traded with raid members, Gargul can show timer bars to let you know when an item's trade window is coming to an end.",
    testEnabled = false,
};
local LootTradeTimers = GL.Interface.Settings.LootTradeTimers; ---@type LootTradeTimersSettings

---@return void
function LootTradeTimers:draw(Parent)
    GL:debug("LootTradeTimers:draw");

    local NumberOfTimerBars = GL.AceGUI:Create("Slider");
    NumberOfTimerBars:SetLabel("Maximum number of active countdown bars");
    NumberOfTimerBars.label:SetTextColor(1, .95686, .40784);
    NumberOfTimerBars:SetFullWidth(true);
    NumberOfTimerBars:SetValue(GL.Settings:get("LootTradeTimers.maximumNumberOfBars", 5));
    NumberOfTimerBars:SetSliderValues(1, 25, 1);
    NumberOfTimerBars:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (type(value) ~= nil) then
            GL.Settings:set("LootTradeTimers.maximumNumberOfBars", value);
            GL.Interface.TradeWindow.TimeLeft:refreshBars();
        end
    end);
    Parent:AddChild(NumberOfTimerBars);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local Checkboxes = {
        {
            label = "Timer bars",
            description = "Show timer bars for BoP items that can still be traded for a limited time",
            setting = "LootTradeTimers.enabled",
            callback = function ()
                GL.Interface.TradeWindow.TimeLeft:refreshBars();
            end,
        },
        {
            label = "Only show bars when I'm master looting",
            description = "Only show countdown bars when you're actively master looting",
            setting = "LootTradeTimers.showOnlyWhenMasterLooting",
            callback = function ()
                GL.Interface.TradeWindow.TimeLeft:refreshBars();
            end,
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(15);
    Parent:AddChild(HorizontalSpacer);

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
            GL.Interface.TradeWindow.TimeLeft:refreshBars();

            return;
        end

        -- Enable test mode
        self.testEnabled = true;
        DemoTradeTimersButton:SetText("Stop");
        GL.Interface.TradeWindow.TimeLeft:refreshBars();
    end);
    Parent:AddChild(DemoTradeTimersButton);
end

GL:debug("Interface/Settings/TMB.lua");