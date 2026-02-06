---@type GL
local _, GL = ...;

---@type SettingsOverview
local Overview = GL.Interface.Settings.Overview;

---@class GDKPCommunicationSettings
GL.Interface.Settings.GDKPCommunication = {
    InputElements = {},
    ItemLevelElements = {},
};

---@type GDKPCommunicationSettings
local GDKPCommunication = GL.Interface.Settings.GDKPCommunication;

---@return nil
function GDKPCommunication:draw(Parent)
    local Spacer;

    Overview:drawCheckboxes({
        {
            label = "Announce auction start",
            setting = "GDKP.announceAuctionStart",
        },
        {
            label = "Announce pot after awarding item",
            setting = "GDKP.announcePotAfterAuction",
        },
        {
            label = "Whisper bidder if bid is too low",
            setting = "GDKP.notifyIfBidTooLow",
        },
        {
            label = "Announce countdown in raid warning",
            description = "Announce countdown in /rw instead of /ra",
            setting = "GDKP.announceCountdownInRW",
        },
        {
            label = "Announce incoming bids",
            description = "Announce all accepted bids in group chat",
            setting = "GDKP.announceNewBid",
        },
        {
            label = "Announce incoming bids in raid warning",
            description = "Announce bids in /rw instead of /ra. Requires |c00967FD2Announce incoming bids|r to be enabled!|r",
            setting = "GDKP.announceNewBidInRW",
        },
        {
            label = "Announce final call",
            setting = "GDKP.announceFinalCall",
        },
    }, Parent);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local NumberOfSecondsToCountdown = GL.AceGUI:Create("Slider");
    NumberOfSecondsToCountdown:SetLabel("Countdown every second starting from (0 to disable)");
    NumberOfSecondsToCountdown.label:SetTextColor(1, .95686, .40784);
    NumberOfSecondsToCountdown:SetFullWidth(true);
    NumberOfSecondsToCountdown:SetValue(GL.Settings:get("GDKP.numberOfSecondsToCountdown", 5));
    NumberOfSecondsToCountdown:SetSliderValues(0, 25, 1);
    NumberOfSecondsToCountdown:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));

        if (value >= 0) then
            GL.Settings:set("GDKP.numberOfSecondsToCountdown", value);
        end
    end);
    Parent:AddChild(NumberOfSecondsToCountdown);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local NumberOfFiveSecondsToCountdown = GL.AceGUI:Create("Slider");
    NumberOfFiveSecondsToCountdown:SetLabel("Countdown every 5 seconds starting from (0 to disable)");
    NumberOfFiveSecondsToCountdown.label:SetTextColor(1, .95686, .40784);
    NumberOfFiveSecondsToCountdown:SetFullWidth(true);
    NumberOfFiveSecondsToCountdown:SetValue(GL.Settings:get("GDKP.numberOfFiveSecondsToCountdown", 15));
    NumberOfFiveSecondsToCountdown:SetSliderValues(0, 30, 5);
    NumberOfFiveSecondsToCountdown:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));

        if (value >= 0) then
            GL.Settings:set("GDKP.numberOfFiveSecondsToCountdown", value);
        end
    end);
    Parent:AddChild(NumberOfFiveSecondsToCountdown);

    Spacer = GL.AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("FILL");
    Spacer:SetFullWidth(true);
    Spacer:SetHeight(20);
    Parent:AddChild(Spacer);

    local FinalCallTime = GL.AceGUI:Create("Slider");
    FinalCallTime:SetLabel("Final call jumps to");
    FinalCallTime.label:SetTextColor(1, .95686, .40784);
    FinalCallTime:SetFullWidth(true);
    FinalCallTime:SetValue(GL.Settings:get("GDKP.finalCallTime", 15));
    FinalCallTime:SetSliderValues(5, 30, 1);
    FinalCallTime:SetCallback("OnValueChanged", function(Slider)
        local value = math.floor(tonumber(Slider:GetValue()));

        if (value >= 0) then
            GL.Settings:set("GDKP.finalCallTime", value);
        end
    end);
    Parent:AddChild(FinalCallTime);
end

GL:debug("Interface/Settings/GDKP.lua");