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
            setting = "SoftRes.announceInfoInChat",
        },
        {
            label = "Announce details when rolling for loot",
            description = "Checking this will make sure that SoftRes details will also be included whenever you roll off an item",
            setting = "SoftRes.announceInfoWhenRolling",
        },
        {
            label = "Enable whisper command",
            description = string.format(
                    "When enabled, players can whisper '|cff%s!sr|r' or '|cff%s!softres|r' to you to double-check their soft-reserves",
                    GL:classHexColor("rogue"),
                    GL:classHexColor("rogue")
            ),
            setting = "SoftRes.enableWhisperCommand",
        },
        {
            label = "Fix character names",
            description = "Players tend to misspell their character names on soft-res. Gargul will attempt to fix those when importing soft-reserves",
            setting = "SoftRes.fixPlayerNames",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    local OpenSoftRes = GL.AceGUI:Create("Button");
    OpenSoftRes:SetText("SoftRes Data");
    OpenSoftRes:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("softreserves");
    end);
    Parent:AddChild(OpenSoftRes);
end

GL:debug("Interface/Settings/SoftRes.lua");