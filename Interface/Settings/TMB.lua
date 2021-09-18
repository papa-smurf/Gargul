---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class TMBSettings
GL.Interface.Settings.TMB = {
    description = "Gargul allows you to import wishlist and character priority data from thatsmybis.com. Details about items will, depending on your settings, show up on your tooltips and in the group chat assuming the master looter uses Gargul. Wishlisted or prioritized items will also receive an animated border in group loot or in a killed enemy's loot window (Check the 'Loot Highlighting' section on the left!)",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Import-TMB-Data",
};
local TMB = GL.Interface.Settings.TMB; ---@type TMBSettings

---@return void
function TMB:draw(Parent)
    GL:debug("TMBSettings:draw");

    local MaxTooltipEntries = GL.AceGUI:Create("Slider");
    MaxTooltipEntries:SetLabel("Maximum number of tooltip entries");
    MaxTooltipEntries.label:SetTextColor(1, .95686, .40784);
    MaxTooltipEntries:SetFullWidth(true);
    MaxTooltipEntries:SetValue(GL.Settings:get("TMB.maximumNumberOfTooltipEntries", 35));
    MaxTooltipEntries:SetSliderValues(1, 50, 1);
    MaxTooltipEntries:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (GL:higherThanZero(value)) then
            GL.Settings:set("TMB.maximumNumberOfTooltipEntries", value);
        end
    end);
    Parent:AddChild(MaxTooltipEntries);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local MaxLootAnnouncementEntries = GL.AceGUI:Create("Slider");
    MaxLootAnnouncementEntries:SetLabel("Maximum number of dropped loot announcement entries");
    MaxLootAnnouncementEntries.label:SetTextColor(1, .95686, .40784);
    MaxLootAnnouncementEntries:SetFullWidth(true);
    MaxLootAnnouncementEntries:SetValue(GL.Settings:get("TMB.maximumNumberOfAnouncementEntries", 35));
    MaxLootAnnouncementEntries:SetSliderValues(1, 50, 1);
    MaxLootAnnouncementEntries:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (GL:higherThanZero(value)) then
            GL.Settings:set("TMB.maximumNumberOfAnouncementEntries", value);
        end
    end);
    Parent:AddChild(MaxLootAnnouncementEntries);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local Checkboxes = {
        {
            label = "Show players in group only",
            description = "Checking this will make sure that you only see the names of players who are actually in your group on item tooltips and in dropped loot announcements",
            setting = "TMB.hideInfoOfPeopleNotInGroup",
        },
        {
            label = "Show wishlist details",
            description = "Checking this will allow you to see the names of those who have an item on their TMB wishlist on tooltips",
            setting = "TMB.showWishListInfoOnTooltips",
        },
        {
            label = "Show item priority details",
            description = "Checking this will allow you to see the names of those who have an item prioritized to them (LC) in TMB on tooltips",
            setting = "TMB.showPrioListInfoOnTooltips",
        },
        {
            label = "Hide wishlist info when priority is set",
            description = "Checking this makes sure that you only see an item's wishlist details if no priority (LC) is set for it",
            setting = "TMB.hideWishListInfoIfPriorityIsPresent",
        },
        {
            label = "Announce wishlist details of dropped loot",
            description = "Checking this will make sure that TMB wishlist details of dropped loot are announced in the chat",
            setting = "TMB.includeWishListInfoInLootAnnouncement",
        },
        {
            label = "Announce item priority details of dropped loot",
            description = "Checking this will make sure that TMB item priority details of dropped loot is announced in the chat",
            setting = "TMB.includePrioListInfoInLootAnnouncement",
        },
        {
            label = "Show reminder to use Gargul",
            description = "When trying to assign loot without using Gargul a reminder is shown to use Gargul instead in order to make exporting loot possible",
            setting = "TMB.showLootAssignmentReminder",
        },
        {
            label = "Show everything when solo",
            description = "Checking this will make sure that you see all entries on tooltips when not in a group",
            setting = "TMB.showEntriesWhenSolo",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local OpenTMB = GL.AceGUI:Create("Button");
    OpenTMB:SetText("TMB Data");
    OpenTMB:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("thatsmybis");
    end);
    Parent:AddChild(OpenTMB);
end

GL:debug("Interface/Settings/TMB.lua");