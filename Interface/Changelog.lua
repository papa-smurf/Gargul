local L = Gargul_L;

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
            version = "7.4.0",
            date = "March 19th, 2024",
            Changes = {
                "We're in the process of translating Gargul, check the welcome channel in our discord for more info if you'd like to help out!",
            },
        },{
            version = "7.3.2",
            date = "March 12th, 2024",
            Changes = {
                "Cross-realm GDKP multi-auctions and other group activities should now work as expected",
            },
        },
        {
            version = "7.2.4",
            date = "December 12th, 2023",
            Changes = {
                "Gargul now supports silver/copper in GDKP sessions (useful in Era/SoD). Check the |c00A79EFF/gl|r -> |c00A79EFFGDKP|r -> |c00A79EFFSupport decimals|r slider",
                "SoD fixes to auto looting with PackMule",
            },
        },
        {
            version = "7.1.0",
            date = "November 7th, 2023",
            Changes = {
                "GDKP Multi/Batch auctions now support auto bidding",
                "Major performance improvements across the board",
            },
        },
        {
            version = "7.0.0",
            date = "October 21st, 2023",
            Changes = {
                "GDKP Multi-Auctions (batch auctions) are finally here! Create a new gdkp session (|c00A79EFF/gdkp|r) and follow the instructions!\n\nWith multi auctions you can auction off as many items as you want at once! This speeds up your raid nights immensely and makes for a seamless experience for your raiders. Give it a shot!\n\nAs an organizer you can now also personalize your raids, show your own logo and other credentials to your raiders. Check out the Gargul discord for more info! <3",
            },
        },
        {
            version = "6.2.0",
            date = "August 7th, 2023",
            Changes = {
                "You can now add and deduct percentages to a player's cut. Want to give a half cut? Use -50 in the cuts window",
                "Don't want rolls to be sorted on TMB/DFT status? Check the settings to disable it!",
                "Added a button to /gl tmb that allows you to reset your raider's TMB data in case you accidentally sent it to them",
                "Did you know that |c00BE3333multiple item bidding|r is currently in the works? Join our discord to get in on the conversation!",
            },
        },
        {
            version = "6.1.6",
            date = "June 26th, 2023",
            Changes = {
                "Items can now be sold directly from the trade timer bars. Right click them when at a vendor!",
                "Trade timer bars will now be colorized when they are reserved or wishlisted",
                "Greatly improved the performance of automated item trading",
                "Soft-reserves will show up on both normal and heroic mode items (soft-reserve sheets show normal items only)",
                "You can now link normal and heroic mode TotC items to one another for TMB and DFT. Check |c00A79EFF/gl|r -> |c00A79EFFGeneral|r",
                "Please include a bug report from now on when reporting bugs or odd behavior (|c00A79EFF/gl bug|r)",
            },
        },
        {
            version = "6.1.2",
            date = "June 21nd, 2023",
            Changes = {
                "Welcome, Trial of the Crusader! We've worked hard on making Gargul 3.4.2-ready, with notable changes to the Softres and TMB module, trade timer bars, auto trading and necessary item linking.",
                "Happy looting, and as always: spot something fishy? Join our discord and be sure to report it!",
            },
        },
        {
            version = "6.1.0",
            date = "June 18th, 2023",
            Changes = {
[[With this version come all new trade timer bars:
* Awarded / disenchanted to self is marked properly
* Settings to filter out items based on status or time remaining
* Bars can be resized / rescaled as desired]],
                "An all new broadcast feature to let people know what items you still have on you is also included",
            },
        },
        {
            version = "6.0.4",
            date = "June 4th, 2023",
            Changes = {
                "Gargul, including its GDKP and rolling modules, are now cross-realm compatible for those playing on Era or Retail!",
                "GDKP organizers can now check and manage gold trades in case something went wrong (|c00A79EFF/gdkp|r -> |c00A79EFFCuts|r -> Bag icon left of player name)",
            },
        },
        {
            version = "5.4.1",
            date = "May 7th, 2023",
            Changes = {
                "Raid on PTR? Gargul has been updated for Trial of the Crusader (|c00A79EFF3.4.2|r)",
                "A |c00A79EFFFinal Call|r button was added to the GDKP auctioneer window, useful for instantly shortening auctions of less desirable items!",
            },
        },
        {
            version = "5.3.20",
            date = "April 30th, 2023",
            Changes = {
                "|c00A79EFFCTRL_CLICK|r the roll, bid or queue window to preview an item",
                "A raid leader deleting and restoring GDKP auctions is now displayed in group chat for improved transparency",
                "Gold is now auto looted from corpses (not containers). Go to |c00A79EFF/gl|r -> |c00A79EFFAutoloot with PackMule|r to disable",
            },
        },
        {
            version = "5.3.12",
            date = "April 1st, 2023",
            Changes = {
                "You can now set a minimum price and increment per item level (check |c00A79EFF/gl|r -> GDKP)",
            },
        },{
            version = "5.3.4",
            date = "March 3rd, 2023",
            Changes = {
                "You can now provide a list of players to share TMB/DFT data with in case you run a closed system (check |c00A79EFF/gl|r -> TMB and DFT)",
            },
        },
        {
            version = "5.3.0",
            date = "February 8th, 2023",
            Changes = {
                "Mailing GDKP cuts has arrived! Lock a GDKP session for payout and walk to a mailbox! There are many safety features in place to account for insufficient funds, mail cap reached, etc. Go check it out!",
                "The GDKP ledger overview has received a complete rework, open your GDKP session (|c00A79EFF/gdkp|r) and click the eye-shaped icon at the top of the ledger!",
                "Gargul now listens in on reserves placed via LootReserve. Do you like LootReserve and would you like to add Gargul's soft-res features (like highlighting, auto looting etc.) on top of that? We got your covered!",
            },
        },
        {
            version = "5.2.0",
            date = "February 4th, 2023",
            Changes = {
                "|c00BE3333Important:|r This update changes the raid leader's experience in GDKP sessions and queues. Please familiarize yourself with it before setting foot in a raid. Get started using |c00A79EFF/gl gdkp|r or |c00A79EFF/gdkp|r",
                "Use TMB and would like to run with group loot? You can now enable the 'Award based on drops' setting in |c00A79EFF/gl|r > |c00A79EFFTMB and DFT|r to automatically track items won via group loot for exporting to TMB/DFT",
                "There's a 'Bonus Features' section in |c00A79EFF/gl|r now, go check it out!",
            },
        },
    }
};
local Changelog = GL.Interface.Changelog; ---@type ChangelogInterface

--- Report version changes if needed
---
---@return void
function Changelog:reportChanges()
    -- This is not this version's first boot, no need to report
    if (not GL.Version.firstBoot) then
        return;
    end

    local latestVersionChangesShown = GL.DB.LoadDetails.latestVersionChangesShown or 0;
    local latestChangelogVersion = self.History[1].version;

    -- If changelog is disabled and there are no pressing matters, then return
    if (not GL.Settings:get("changeLog", true)
        and GL.Version:leftIsOlderThanRight("5.0.4", latestVersionChangesShown)
    ) then
        return;
    end

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
    -- The changelog is already visible
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L.WINDOW_HEADER):format(GL.version));
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

    --[[ CHRISTMAS HOLIDAYS SANTA HAT ]]
    local month, day = tonumber(date('%m')), tonumber(date('%d'));
    if (month and day
        and ((month == 12 and day >= 3)
            or (month == 1 and day <= 12)
        )
    ) then
        local SantaHat = GL.AceGUI:Create("Icon");
        SantaHat:SetWidth(83);
        SantaHat:SetHeight(81);
        SantaHat:SetImage("Interface/AddOns/Gargul/Assets/Icons/santa_hat");
        SantaHat.frame:SetParent(Window.frame);
        SantaHat.frame:SetPoint("TOPLEFT", Window.frame, "TOPLEFT", -26, 36);
        SantaHat.frame:Show();
    end

    local ScrollFrameHolder = GL.AceGUI:Create("ScrollFrame");
    ScrollFrameHolder:SetLayout("Fill");
    ScrollFrameHolder:SetWidth(400);
    ScrollFrameHolder:SetHeight(428);
    Window:AddChild(ScrollFrameHolder);

    local ScrollFrame = GL.AceGUI:Create("ScrollFrame");
    ScrollFrame:SetLayout("Flow");
    ScrollFrameHolder:AddChild(ScrollFrame);

    local WhatIsGargul = GL.AceGUI:Create("Label");
    WhatIsGargul:SetText(L.CHANGELOG_GETTING_STARTED);
    WhatIsGargul:SetFontObject(_G["GameFontNormal"]);
    WhatIsGargul:SetFullWidth(true);
    ScrollFrame:AddChild(WhatIsGargul);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(8);
    ScrollFrame:AddChild(HorizontalSpacer);

    local OpenGargul = GL.AceGUI:Create("Button");
    OpenGargul:SetText(L.CHANGELOG_OPEN_GARGUL);
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
    DiscordLabel:SetText(("|c00A79EFF%s|r"):format(L.CHANGELOG_CONTRIBUTE));
    DiscordLabel:SetFontObject(_G["GameFontNormal"]);
    DiscordLabel:SetFullWidth(true);
    ScrollFrame:AddChild(DiscordLabel);

    local DiscordBox = GL.AceGUI:Create("EditBox");
    DiscordBox:DisableButton(true);
    DiscordBox:SetHeight(20);
    DiscordBox:SetFullWidth(true);
    DiscordBox:SetText(L.DISCORD_URL);
    ScrollFrame:AddChild(DiscordBox);

    for _, LogEntry in pairs(self.History) do
        -- Add some whitespace between this and the previous entry
        HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
        HorizontalSpacer:SetLayout("FILL");
        HorizontalSpacer:SetFullWidth(true);
        HorizontalSpacer:SetHeight(16);
        ScrollFrame:AddChild(HorizontalSpacer);

        -- Version label
        local VersionLabel = AceGUI:Create("Label");
        VersionLabel:SetText(string.format("|c00A79EFFv%s - |r%s", LogEntry.version or "", LogEntry.date or ""));
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

            -- Highlight GDKP update
            if (LogEntry.version == "7.0.0" and not GL.isRetail) then
            --if (false and not GL.isRetail) then
                HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
                HorizontalSpacer:SetLayout("FILL");
                HorizontalSpacer:SetFullWidth(true);
                HorizontalSpacer:SetHeight(6);
                ScrollFrame:AddChild(HorizontalSpacer);

                local ChangeLabel = AceGUI:Create("Label");
                ChangeLabel:SetText(string.format("\n|c00FFF569%s|r\n \n", change));
                ChangeLabel:SetFontObject(_G["GameFontNormal"]);
                ChangeLabel:SetHeight(20);
                ChangeLabel:SetFullWidth(true);
                ScrollFrame:AddChild(ChangeLabel);

                local LCG = LibStub("LibCustomGlowGargul-1.0");
                local BorderColor = {1, 1, 1, 1};
                LCG.PixelGlow_Start(ChangeLabel.frame, BorderColor, 140, 0, 5, 3, 10, 2, false, 2);
                BorderColor = {.77, .12, .23, 1};
                LCG.PixelGlow_Start(ChangeLabel.frame, BorderColor, 70, .02, 5, 3, 10, 2, false, 1);
            else
                local ChangeLabel = AceGUI:Create("Label");
                ChangeLabel:SetText(string.format("|c00A79EFF-|r|c00FFF569 %s|r", change));
                ChangeLabel:SetFontObject(_G["GameFontNormal"]);
                ChangeLabel:SetHeight(20);
                ChangeLabel:SetFullWidth(true);
                ScrollFrame:AddChild(ChangeLabel);
            end

            firstChange = false;
        end
    end

    local Checkbox = AceGUI:Create("CheckBox");
    Checkbox:SetValue(GL.Settings:get("changeLog"));
    Checkbox:SetLabel(L.CHANGELOG_ENABLE_LABEL);
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
    GL.Interface:release(Window);
    self.isVisible = false;
end

