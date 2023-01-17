---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class TMBSettings
GL.Interface.Settings.TMB = {
    description = "|cffC41E3AThese settings affect all data imported via TMB and DFT!|r\n\nType |c00a79eff/gl tmb|r or |c00a79eff/gl dft|r or click the button below to get started!",
};
local TMB = GL.Interface.Settings.TMB; ---@type TMBSettings

---@return void
function TMB:draw(Parent)
    GL:debug("TMBSettings:draw");

    local OpenTMB = GL.AceGUI:Create("Button");
    OpenTMB:SetText("TMB Data");
    OpenTMB:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("thatsmybis");
    end);
    Parent:AddChild(OpenTMB);

    Overview:drawHeader("General", Parent);

    Overview:drawCheckboxes({
        {
            label = "Automatically share data",
            description = "Automatically share data with players who join your raid or when you import new data",
            setting = "TMB.automaticallyShareData",
        },
        {
            label = "Show players in group only",
            description = "Makes sure you only see the names of players who are actually in your group",
            setting = "TMB.hideInfoOfPeopleNotInGroup",
        },
        {
            label = "Show everything when solo",
            description = "Make sure that you see all TMB/DFT data when not in a group, perfect for testing!",
            setting = "TMB.showEntriesWhenSolo",
        },
        {
            label = "Award based on drops without using Gargul UI",
            description = "Want to export items won via group loot? Want to use the native UI when master looting instead of Gargul's? Then enable this option! You can still edit entries via the award history (|c00a79eff/gl ah|r)",
            setting = "TMB.awardBasedOnDrops",
        },
        {
            label = "Hide wishlist info when priority is set",
            description = "You will only see an item's wishlist details if no priority (LC) is set for it",
            setting = "TMB.hideWishListInfoIfPriorityIsPresent",
        },
    }, Parent);

    Overview:drawHeader("Tooltips", Parent);

    Overview:drawCheckboxes({
        {
            label = "Show wishlist details",
            description = "See the names of those who have an item on their list on tooltips",
            setting = "TMB.showWishListInfoOnTooltips",
        },
        {
            label = "Show item priority details",
            description = "See the names of those who have an item prioritized to them (LC) on tooltips",
            setting = "TMB.showPrioListInfoOnTooltips",
        },
        {
            label = "Show item tier and note",
            description = "An item's guild note and item tier are shown on its tooltip",
            setting = "TMB.showItemInfoOnTooltips",
        },
        {
            label = "Give OS items a lower priority",
            description = "Items marked as OS on wishlist or priolist will be put at the bottom of the list",
            setting = "TMB.OSHasLowerPriority",
        },
    }, Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

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

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    Overview:drawHeader("Dropped loot", Parent);

    Overview:drawCheckboxes({
        {
            label = "Announce wishlist details of dropped loot",
            description = "Wishlist details of dropped loot are announced in the chat",
            setting = "TMB.includeWishListInfoInLootAnnouncement",
        },
        {
            label = "Announce priolist details of dropped loot",
            description = "Item priolist details (LC) of dropped loot are announced in the chat",
            setting = "TMB.includePrioListInfoInLootAnnouncement",
        },
    }, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local MaxLootAnnouncementEntries = GL.AceGUI:Create("Slider");
    MaxLootAnnouncementEntries:SetLabel("Maximum number of dropped loot announcement entries");
    MaxLootAnnouncementEntries.label:SetTextColor(1, .95686, .40784);
    MaxLootAnnouncementEntries:SetFullWidth(true);
    MaxLootAnnouncementEntries:SetValue(GL.Settings:get("TMB.maximumNumberOfAnnouncementEntries", 35));
    MaxLootAnnouncementEntries:SetSliderValues(1, 50, 1);
    MaxLootAnnouncementEntries:SetCallback("OnValueChanged", function(Slider)
        local value = tonumber(Slider:GetValue());

        if (GL:higherThanZero(value)) then
            GL.Settings:set("TMB.maximumNumberOfAnnouncementEntries", value);
        end
    end);
    Parent:AddChild(MaxLootAnnouncementEntries);

    Overview:drawHeader("Rolling out items", Parent);

    Overview:drawCheckboxes({
        {
            label = "Announce wishlist details when rolling out loot",
            description = "TMB wishlist details will also be included whenever you roll out an item",
            setting = "TMB.announceWishlistInfoWhenRolling",
        },
        {
            label = "Announce priolist details when rolling out loot",
            description = "TMB/DFT priolist details will also be included whenever you roll out an item",
            setting = "TMB.announcePriolistInfoWhenRolling",
        },
    }, Parent);
end

GL:debug("Interface/Settings/TMB.lua");