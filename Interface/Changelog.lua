---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;
local Settings = GL.Settings; ---@type Settings

---@class ChangelogInterface
GL.Interface.Changelog = {
    isVisible = false,

    History = {
        {
            version = "4.12.13",
            date = "November 29th, 2022",
            Changes = {
                "Auto looting now also works for group loot in raids/heroics, even on BoP items in a safe and secure way! Check it out in |c00a79eff/gl pm|r!",
            },
        },
        {
            version = "4.12.8",
            date = "November 16th, 2022",
            Changes = {
                "Loot trade timers change icon and color after awarding or disenchanting an item. That way you can easily tell which items still need to be rolled out!",
            },
        },
        {
            version = "4.12.5",
            date = "November 9th, 2022",
            Changes = {
                "Master looters! Closing the auction/rolloff window now presents you with a roll counter and two quick access buttons: one for stopping/starting the rolls and one for disenchanting the item",
                "You can now also see all rolls on an awarded item, by opening the award history window and hovering your mouse over an entry",
            },
        },
        {
            version = "4.12.2",
            date = "November 4th, 2022",
            Changes = {
                "Awarded loot history is moved to a separate window, click the trophy icon in your rolloff or award window",
                "You can now mark rolls as +1 or OS in your settings so that the checkboxes will be checked automatically when awarding an item based on the type of roll",
                "Gargul's hotkeys are now inactive when the auction house, mailbox, shop or bank are active",
            },
        },
        {
            version = "4.12.0",
            date = "October 31th, 2022",
            Changes = {
                "|c00BE3333Important:|r This version introduces a complete rewrite of the awarded loot structure, making it incompatible with older versions of Gargul. Encourage your fellow raiders to update!",
                "Hold shift on the roll window to compare the item with what you have equipped!",
                "Notable bugfix: Edited and deleted awarded items are now broadcast to the entire raid properly",
            },
        },
        {
            version = "4.11.0",
            date = "October 27th, 2022",
            Changes = {
                "Player passed on an item? Did you assign an item to the wrong player? No worries, you can edit all that now!",
                "You can now change the size of the Loot trade timers window in |c00a79eff/gl|r -> |c00a79effLoot trade timers|r",
                "Improved performance greatly and prepared Gargul for Dragonflight",
                "Changed the Gargul master looter message and made sure it doens't spam the raid on /reload",
            },
        },
        {
            version = "4.10.1",
            date = "October 19th, 2022",
            Changes = {
                "You can now add up to 10 roll buttons with unlimited characters!",
                "Gargul shortcut keys no longer support the right mouse button for technical reasons",
                "Updated the DFT loot export format to now use item IDs instead of names",
                "You can now exclude offspec items when exporting loot via |c00a79eff/gl export|r -> |c00a79effMaster Looting|r",
                "Item tooltips now include more details of (recent) winners",
            },
        },
        {
            version = "4.10.0",
            date = "October 16th, 2022",
            Changes = {
                "When enabled, PackMule will now always stay enabled even after a zone switch/reload",
                "Only want to announce the seconds left to roll once? Check |c00a79eff/gl|r -> |c00a79effMaster Looting|r",
                "Accessibility: you can now increase the rolling window's size via |c00a79eff/gl|r -> |c00a79effRolling|r",
            },
        },
        {
            version = "4.9.0",
            date = "October 10th, 2022",
            Changes = {
                "When your master looter rolls out an item, you can now immediately tell whether it's something your class can use or not! You can also disable the roll window entirely in such cases if you prefer, type |c00a79eff/gl|r and check out the |c00a79effRolling|r section!",
                "Tooltips are now fully cross-item, where priorities and reservations show on both the tier/quest items, and the items they reward (and vice versa!)",
                "The exporter now supports a 2 digit year format (@YY), check it out with |c00a79eff/gl export|r",
                "Gargul commands are no longer case sensitive"
            },
        },
        {
            version = "4.8.4",
            date = "October 3rd, 2022",
            Changes = {
                "PackMule now supports round robin! Type |c00a79eff/gl pm|r and check it out!",
            },
        },
        {
            version = "4.8.0",
            date = "September 26th, 2022",
            Changes = {
                "|c00f7922eNEED|r? |c00f7922eGREED|r? |c00f7922ePASS|r?! PackMule's auto looting now also works in group loot: safe auto looting for everyone without any downtime! Type |c00a79eff/gl pm|r to speed up your raids!",
                "Tired of those 'Are you sure you want to bind this item to you' messages when farming or raiding? We got you! Type |c00a79eff/gl pm|r and check the auto confirm settings!",
            },
        },
        {
            version = "4.7.1",
            date = "September 12th, 2022",
            Changes = {
                "TMB and DFT data is now included in the raid warning when rolling off items, that way players know who is allowed to roll which recudes confusion and spam!",
                "When awarding an item the top prio player (if any) is selected by default, this will speed up awarding reserved loot or TMB/DFT loot for sure!",
            },
        },
        {
            version = "4.6.0",
            date = "September 3rd, 2022",
            Changes = {
                "Custom export format: you can now export awarded loot to any format you want! Go to /gl export to check it out!"
            },
        },
        {
            version = "4.5.0",
            date = "August 31st, 2022",
            Changes = {
                "Gargul now supports the DFT WotLK sheet! Are you a fan of the DFT-Fight-Club loot system? Gargul has you covered! Type /gl dft to get started"
            },
        },
        {
            version = "4.3.1",
            date = "May 29th, 2022",
            Changes = {
                "Having issues with players misspelling their character names on |c00a79effsoftres.it|r? Gargul now automatically attempts to \"fix\" typos in character names when importing soft-reserves",
                "When using soft-reserves, a player can now whisper |c00a79eff!sr|r to the master looter to double check his soft-reserves",
                "You can now set a default raid warning / group message that shows when you roll off items. Want to let players know how to roll for MS or OS? Easy: open Gargul using |c00a79eff/gl|r and go to |c00a79effMaster Looting|r to set your message!"
            },
        },
        {
            version = "4.3.0",
            date = "May 10th, 2022",
            Changes = {
                "Do you want to reward regulars? Give something extra to players reserving the same item(s) multiple times in a row? Awesome, that's what boosted rolls are for! Open Gargul using |c00a79eff/gl|r and go to |c00a79effBoosted Rolls|r to get started!",
            },
        },
        {
            version = "4.1.8",
            date = "April 15th, 2022",
            Changes = {
                "Gargul can now announce loot and money traded in chat for full transparency",
            },
        },
        {
            version = "4.1.3",
            date = "February 7th, 2022",
            Changes = {
                "Completely revamped the PackMule auto looter, go check out PackMule at |c00a79eff/gl pm|r!",
            },
        },
        {
            version = "4.1.2",
            date = "January 26th, 2022",
            Changes = {
                "Gargul now supports the raid roster tool of the raid-helper discord bot. Make your roster and auto-invite, sort groups and more using |c00a79eff/gl gr|r!",
            },
        },
        {
            version = "4.1.1",
            date = "January 24th, 2022",
            Changes = {
                string.format(
                    "You can now award an item to a random player by not selecting a player and clicking the award button in the award window (|c00a79eff%s|r)",
                    GL.Settings:get("ShortcutKeys.award")
                ),
                "Hovering over a player's roll in the roll tracking window will now show you all the items they've won today",
            },
        },
        {
            version = "4.1.0",
            date = "January 15th, 2022",
            Changes = {
                "Gargul now supports custom roll ranges! Don't want to use |c00a79eff/rnd|r for main spec or |c00a79eff/rnd 99|r for off spec? Not a problem: you can now define your own roll types! Open Gargul using |c00a79eff/gl|r and go to |c00a79effRoll Tracking|r to set up your rolls!",
            },
        },
        {
            version = "4.0.0",
            date = "December 12th, 2021",
            Changes = {
                "Added automatic |c00a79effsoftres.it|r data sharing. When a player enters your raid or when you import soft-reserves it's automatically shared",
                "Added the same sharing feature for |c00a79effTMB|r but it's disabled by default. Open Gargul using |c00a79eff/gl|r and go to |c00a79effTMB|r to enable!",
            },
        },
        {
            version = "3.6.0",
            date = "November 14th, 2021",
            Changes = {
                "Loot priorities can now be shared with the raid, type |c00a79eff/gl lo|r to get started!",
            },
        },
        {
            version = "3.5.3",
            date = "November 10th, 2021",
            Changes = {
                "Gargul will now show for how long soulbound items can still be traded within the two hour trade window, forgetting to roll out items is now a thing of the past!",
            },
        },
        {
            version = "3.5.0",
            date = "October 30th, 2021",
            Changes = {
                "Gargul now automatically adds all awarded items to the trade window when trading with the winner, making master looting as you go easier than ever!",
            },
        }
    }
};
local Changelog = GL.Interface.Changelog; ---@type ChangelogInterface

--- Report version changes if needed
---
---@return void
function Changelog:reportChanges()
    GL:debug("Changelog:reportChanges");

    if (not GL.Version.firstBoot -- This is not this version's first boot, no need to report
        or not GL.Settings:get("changeLog", true) -- The user is not interested in the changelog
    ) then
        return;
    end

    local latestVersionChangesShown = GL.DB.LoadDetails.latestVersionChangesShown or 0;
    local latestChangelogVersion = self.History[1].version;

    -- There are no changes to display between this version and the last, skip!
    if (not GL.Version:leftIsOlderThanRight(latestVersionChangesShown, latestChangelogVersion)) then
        return;
    end

    -- Make sure we store the latest changelog shown for future reference
    GL.DB.LoadDetails.latestVersionChangesShown = latestChangelogVersion;

    self:draw();
end

--- Draw the changelog window
---
---@return void
function Changelog:draw()
    GL:debug("Changelog:draw");

    -- The changelog is already visible
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(400);
    Window:SetHeight(500);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:set(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("Changelog"));

    local ScrollFrameHolder = GL.AceGUI:Create("ScrollFrame");
    ScrollFrameHolder:SetLayout("Fill");
    ScrollFrameHolder:SetWidth(400);
    ScrollFrameHolder:SetHeight(428);
    Window:AddChild(ScrollFrameHolder);

    local ScrollFrame = GL.AceGUI:Create("ScrollFrame");
    ScrollFrame:SetLayout("Flow");
    ScrollFrameHolder:AddChild(ScrollFrame);

    local WhatIsGargul = GL.AceGUI:Create("Label");
    WhatIsGargul:SetText("Gargul makes handing out loot super easy, click the button below to get started!");
    WhatIsGargul:SetFontObject(_G["GameFontNormal"]);
    WhatIsGargul:SetFullWidth(true);
    ScrollFrame:AddChild(WhatIsGargul);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(8);
    ScrollFrame:AddChild(HorizontalSpacer);

    local OpenGargul = GL.AceGUI:Create("Button");
    OpenGargul:SetText("Open Gargul");
    OpenGargul:SetCallback("OnClick", function()
        self:close();
        return GL.Commands:call("settings");
    end);
    OpenGargul:SetFullWidth(true);
    ScrollFrame:AddChild(OpenGargul);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(8);
    ScrollFrame:AddChild(HorizontalSpacer);

    local DiscordLabel = GL.AceGUI:Create("Label");
    DiscordLabel:SetText("|c00a79effGet support and involved on our Discord|r");
    DiscordLabel:SetFontObject(_G["GameFontNormal"]);
    DiscordLabel:SetFullWidth(true);
    ScrollFrame:AddChild(DiscordLabel);

    local DiscordBox = GL.AceGUI:Create("EditBox");
    DiscordBox:DisableButton(true);
    DiscordBox:SetHeight(20);
    DiscordBox:SetFullWidth(true);
    DiscordBox:SetText("https://discord.gg/D3mDhYPVzf");
    ScrollFrame:AddChild(DiscordBox);

    for _, LogEntry in pairs(self.History) do
        -- Add some whitespace between this and the previous entry
        if (not firstEntry) then
            HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
            HorizontalSpacer:SetLayout("FILL");
            HorizontalSpacer:SetFullWidth(true);
            HorizontalSpacer:SetHeight(16);
            ScrollFrame:AddChild(HorizontalSpacer);
        end

        -- Version label
        local VersionLabel = AceGUI:Create("Label");
        VersionLabel:SetText(string.format("|c00a79effv%s - |r%s", LogEntry.version, LogEntry.date));
        VersionLabel:SetFontObject(_G["GameFontNormal"]);
        VersionLabel:SetHeight(10);
        VersionLabel:SetFullWidth(true);
        ScrollFrame:AddChild(VersionLabel);

        local firstChange = true;
        for _, change in pairs(LogEntry.Changes) do
            if (not firstChange) then
                HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
                HorizontalSpacer:SetLayout("FILL");
                HorizontalSpacer:SetFullWidth(true);
                HorizontalSpacer:SetHeight(6);
                ScrollFrame:AddChild(HorizontalSpacer);
            end

            -- Changes
            local ChangeLabel = AceGUI:Create("Label");
            ChangeLabel:SetText(string.format("|c00a79eff-|r|c00FFF569 %s|r", change));
            ChangeLabel:SetFontObject(_G["GameFontNormal"]);
            ChangeLabel:SetHeight(20);
            ChangeLabel:SetFullWidth(true);
            ScrollFrame:AddChild(ChangeLabel);

            firstChange = false;
        end
    end

    local Checkbox = AceGUI:Create("CheckBox");
    Checkbox:SetValue(GL.Settings:get("changeLog"));
    Checkbox:SetLabel("Enable changelog");
    Checkbox:SetDescription("");
    Checkbox:SetWidth(220);
    Checkbox:SetCallback("OnValueChanged", function()
        GL.Settings:set("changeLog", Checkbox:GetValue());
    end);
    Window:AddChild(Checkbox);
end

--- Store the changelog window's position for future reference
---
---@return void
function Changelog:close()
    GL:debug("Changelog:close");

    local Window = GL.Interface:get(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    -- Store the frame's last position for future play sessions
    local point, _, relativePoint, offsetX, offsetY = Window:GetPoint();
    Settings:set("UI.Changelog.Position.point", point);
    Settings:set("UI.Changelog.Position.relativePoint", relativePoint);
    Settings:set("UI.Changelog.Position.offsetX", offsetX);
    Settings:set("UI.Changelog.Position.offsetY", offsetY);

    -- Clear the frame and its widgets
    AceGUI:Release(Window);
    self.isVisible = false;
end

GL:debug("Changelog.lua");