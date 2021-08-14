---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class SoftResSettings
GL.Interface.Settings.SoftRes = {
    description = "Gargul allows you to import data from soft-reserve sheets create on softres.it. Details about reservations will, depending on your settings, show up on: your tooltips, in chat and in your roll window.",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Importing-Soft-Reserves",
};
local SoftRes = GL.Interface.Settings.SoftRes; ---@type SoftResSettings

---@return void
function SoftRes:draw(Parent)
    GL:debug("SoftResSettings:draw");

    local Checkboxes = {
        {
            label = "Enable",
            description = "Show SoftRes data on tooltips",
            setting = "SoftRes.enableTooltips",
        },
        {
            label = "Show players in group only",
            description = "Checking this will make sure that you only see the names of players who are actually in your group on item tooltips and in dropped loot announcements",
            setting = "SoftRes.hideInfoOfPeopleNotInGroup",
        },
        {
            label = "Announce details of dropped loot",
            description = "Checking this will make sure that SoftRes details of dropped loot are also announced in the chat",
            setting = "includeSoftResInLootAnnouncement",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local OpenSoftRes = GL.AceGUI:Create("Button");
    OpenSoftRes:SetText("Open SoftRes");
    OpenSoftRes:SetCallback("OnClick", function()
        GL.Commands:call("softreserves");
    end);
    Parent:AddChild(OpenSoftRes);
end

GL:debug("Interface/Settings/SoftRes.lua");