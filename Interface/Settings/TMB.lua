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

    local MaximumNumberOfNames = GL.AceGUI:Create("Slider");
    MaximumNumberOfNames:SetLabel("Maximum number of tooltip entries");
    MaximumNumberOfNames.label:SetTextColor(1, .95686, .40784);
    MaximumNumberOfNames:SetFullWidth(true);
    MaximumNumberOfNames:SetValue(GL.Settings:get("TMB.maximumNumberOfTooltipEntries"));
    MaximumNumberOfNames:SetSliderValues(1, 50, 1);
    MaximumNumberOfNames:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (GL:higherThanZero(value)) then
            GL.Settings:set("TMB.maximumNumberOfTooltipEntries", value);
        end
    end);
    Parent:AddChild(MaximumNumberOfNames);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
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
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local OpenTMB = GL.AceGUI:Create("Button");
    OpenTMB:SetText("Open TMB");
    OpenTMB:SetCallback("OnClick", function()
        GL.Commands:call("thatsmybis");
    end);
    Parent:AddChild(OpenTMB);
end

GL:debug("Interface/Settings/TMB.lua");