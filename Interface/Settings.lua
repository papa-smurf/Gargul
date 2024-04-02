local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

--[[ CONSTANTS ]]
local BUTTON_WIDTH = 200;
local DEFAULT_SECTION = L.SETTINGS_SECTION_GENERAL;
local MENU_ROW_HEIGHT = 22;
local MENU_FONT_SIZE = 1.1;
local SUBJECT_FONT_SIZE = 1.5;
local SECTION_MARGIN_LEFT = 10;
local SECTION_MARGIN_TOP = 40;
local SECTION_MARGIN_BOTTOM = 30;
local SECTION_HOVER_PADDING_TOP = 5;
local SUB_SECTION_MARGIN_LEFT = 20;
local SUB_SECTION_MARGIN_TOP = 30;
local SUB_SECTION_MARGIN_BOTTOM = 10;
local SETTING_COLOR = "EDC507";
local SETTING_MARGIN_BOTTOM = 10;
local SETTING_MARGIN_LEFT = 30;
local SLIDER_MARGIN_BOTTOM = 20;
local SLIDER_MARGIN_TOP = 10;

local RESET_CONFIRMATION_DIALOG_NAME = "GL.Interface.Settings.ResetToDefaults";
local ALL_SETTINGS = 0;
local SHOWN_SETTINGS = 1;

--- Section types
local SECTION = 0;
local SUB_SECTION = 1;
local CHECKBOX = 2;
local BUTTON = 3;
local DROPDOWN = 4;
local MINIMAP_HOTKEY_DROPDOWN = 5;
local CUSTOM = 6;
local LABEL = 7;
local INPUT = 8;
local LOOT_QUALITY_DROPDOWN = 9;
local SLIDER = 10;
local INDIRECT_INPUT = 11; -- This input is not directly linked to a setting

local MINIMAP_HOTKEY_ACTIONS = {
    "DISABLED",
    "GARGUL",
    "SOFTRES",
    "GDKP",
    "GDKP_LEDGER",
    "GDKP_CUTS",
    "MULTIAUCTION",
    "IMPORT",
    "EXPORT",
    "AWARDHISTORY",
    "PLUS_ONE",
    "BOOSTED_ROLLS",
};

local SECTION_ORDER = {
    L.SETTINGS_SECTION_GETTING_STARTED,
    L.SETTINGS_SECTION_GENERAL,
    L.SETTINGS_SECTION_SOFTRES,
    L.SETTINGS_SECTION_TMB,
    L.SETTINGS_SECTION_GDKP,
    L.SETTINGS_SECTION_PACKMULE,
    -- L.SETTINGS_SECTION_ANNOUNCE_LOOT,
    L.SETTINGS_SECTION_EXPORT_LOOT,
    L.SETTINGS_SECTION_LOOT_TRADE_TIMERS,
    L.SETTINGS_SECTION_MASTER_LOOTING,
};
local SECTION_INDEXES = GL:tableFlip(SECTION_ORDER);

GL.Interface.Settings = GL.Interface.Settings or {
    FramePool = {},
    MenuFrames = {},

    activeSection = nil,
    inSearchMode = false,
    windowName = "GL.Interface.Settings",
};
local Settings = GL.Interface.Settings;

---@class SettingsInterface
local SettingEntries = {
    [L.SETTINGS_SECTION_GETTING_STARTED] = {
        {
            ID = "gettingStartedView",
            type = CUSTOM,
            build = function (Parent)
                local SettingFrame = CreateFrame("Frame", nil, Parent);
                SettingFrame:SetWidth(1);
                SettingFrame:SetHeight(1);

                local Intro = Interface:createFontString(SettingFrame, (L.SETTINGS_SECTION_GETTING_STARTED_INTRO):format(
                    GL.Settings:get("ShortcutKeys.rollOffOrAuction"),
                    GL.Settings:get("ShortcutKeys.award")
                ));
                Intro:SetColor(SETTING_COLOR);
                Intro:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

                ---@type Button
                local OpenBonusFeatures = Interface:dynamicPanelButton(SettingFrame, L.SETTINGS_SECTION_GETTING_STARTED_INTRO_BONUS_FEATURES);
                OpenBonusFeatures:SetScript("OnClick", function ()
                    GL.Interface.BonusFeatures:open();
                end);
                OpenBonusFeatures:SetPoint("LEFT", Parent, "LEFT", SUB_SECTION_MARGIN_LEFT, 0);
                OpenBonusFeatures:SetPoint("TOP", Intro, "BOTTOM", 0, SUB_SECTION_MARGIN_BOTTOM);

                ---[[ PATRONS ]]
                local Colors = {
                    contributors = "FFFFFF",
                    common = Interface.Colors.COMMON,
                    uncommon = Interface.Colors.UNCOMMON,
                    rare = Interface.Colors.RARE,
                    epic = Interface.Colors.EPIC,
                    legendary = Interface.Colors.LEGENDARY,
                };

                local PatronNames = {};
                for _, name in pairs(GL.Data.Constants.Vips.Legendary or {}) do
                    tinsert(PatronNames, ("|c00%s%s|r"):format(Colors.legendary, name));
                end

                for _, name in pairs(GL.Data.Constants.Vips.Epic or {}) do
                    tinsert(PatronNames, ("|c00%s%s|r"):format(Colors.epic, name));
                end

                for _, name in pairs(GL.Data.Constants.Vips.Rare or {}) do
                    tinsert(PatronNames, ("|c00%s%s|r"):format(Colors.rare, name));
                end

                for _, name in pairs(GL.Data.Constants.Vips.Uncommon or {}) do
                    tinsert(PatronNames, ("|c00%s%s|r"):format(Colors.uncommon, name));
                end

                local patronString = "";
                local lastColor = "";
                local first = true;
                for _, patron in pairs (PatronNames) do
                    local color = string.sub(patron, 1, 10);

                    if (not first and color ~= lastColor) then
                        patronString = ("%s%s%s"):format(
                            patronString,
                            "\n\n",
                            patron
                        );
                    elseif (not first) then
                        patronString = ("%s, %s"):format(
                            patronString,
                            patron
                        );
                    else
                        patronString = patron;
                    end

                    first = false;
                    lastColor = color;
                end

                local PatronsTitle = Interface:createFontString(SettingFrame, L.SETTINGS_SECTION_GETTING_STARTED_PATRONS);
                PatronsTitle:SetPoint("LEFT", Parent, "LEFT", SUB_SECTION_MARGIN_LEFT, 0);
                PatronsTitle:SetPoint("TOP", OpenBonusFeatures, "BOTTOM", 0, SUB_SECTION_MARGIN_TOP * -1);
                PatronsTitle:SetFont(SUBJECT_FONT_SIZE);
                
                local Patrons = Interface:createFontString(SettingFrame, patronString);
                Patrons:SetPoint("LEFT", Parent, "Left", SETTING_MARGIN_LEFT, 0);
                Patrons:SetPoint("TOP", PatronsTitle, "BOTTOM", 0, SETTING_MARGIN_BOTTOM * -1);

                ---@type Button
                local MoreInfo = Interface:dynamicPanelButton(SettingFrame, L.SETTINGS_SECTION_GETTING_STARTED_MORE_INFO);
                MoreInfo:SetScript("OnClick", function ()
                    GL.Interface.Dialogs.HyperlinkDialog:open{
                        description = L.SETTINGS_SECTION_GETTING_STARTED_MORE_INFO_DIALOG,
                        hyperlink = L.DISCORD_URL,
                    };
                end);
                MoreInfo:SetPoint("LEFT", Parent, "LEFT", SUB_SECTION_MARGIN_LEFT, 0);
                MoreInfo:SetPoint("TOP", Patrons, "BOTTOM", 0, SUB_SECTION_MARGIN_BOTTOM * -1);

                SettingFrame.type = CUSTOM;
                return SettingFrame;
            end,
        },
    },
    [L.SETTINGS_SECTION_GENERAL] =
        (function ()
            local userIsDev = GL.User:isDev();

            local Entries = {
                {
                    ID = "openChatLocale",
                    type = BUTTON,
                    action = function () GL.Commands:call("locale"); end,
                },
                --- Dev only
                userIsDev and {
                    ID = "debugModeEnabled",
                    type = CHECKBOX,
                    label = "|c00F7922EDev only: debug mode|r",
                } or nil,
                --- Dev only
                userIsDev and {
                    ID = "profilerEnabled",
                    type = CHECKBOX,
                    label = "|c00F7922EDev only: addon usage|r",
                    callback = function ()
                        if (GL.Settings:get("profilerEnabled")) then
                            GL.Profiler:draw();
                        else
                            GL.Profiler:close();
                        end
                    end,
                } or nil,
                {
                    ID = "welcomeMessage",
                    type = CHECKBOX,
                },
                --- WotLK only
                GL.isClassic and {
                    ID = "MasterLooting.linkNormalAndHardModeItems",
                    type = CHECKBOX,
                } or nil,
                {
                    ID = "changeLog",
                    type = CHECKBOX,
                },
                {
                    ID = "showUpdateAlert",
                    type = CHECKBOX,
                },
                {
                    ID = "noSounds",
                    type = CHECKBOX,
                },
                {
                    ID = "soundChannel",
                    type = DROPDOWN,
                    Options = {
                        Master = "Master",
                        Music = "Music",
                        SFX = "SFX",
                        Ambience = "Ambience",
                        Dialog = "Dialog",
                    }
                },
                {
                    ID = L.SETTINGS_SUBSECTION_MINIMAP,
                    type = SUB_SECTION,
                },{
                    ID = "MinimapButton.enabled",
                    type = CHECKBOX,
                    callback = function()
                        GL.MinimapButton:drawOrHide();
                    end,
                },
            };

            local Hotkeys = {
                "CLICK", "RIGHTCLICK", "MIDDLECLICK", "SHIFT_CLICK", "SHIFT_RIGHTCLICK", "SHIFT_MIDDLECLICK",
                "ALT_CLICK", "ALT_RIGHTCLICK", "ALT_MIDDLECLICK", "CTRL_CLICK", "CTRL_RIGHTCLICK", "CTRL_MIDDLECLICK",
                "ALT_SHIFT_CLICK", "ALT_SHIFT_RIGHTCLICK", "ALT_SHIFT_MIDDLECLICK", "CTRL_SHIFT_CLICK",
                "CTRL_SHIFT_RIGHTCLICK", "CTRL_SHIFT_MIDDLECLICK",
            };

            for _, action in pairs(Hotkeys) do
                tinsert(Entries, {
                    ID = "MinimapButton.Actions." .. action,
                    type = MINIMAP_HOTKEY_DROPDOWN,
                });
            end

            return Entries;
        end)()
    ,
    [L.SETTINGS_SECTION_SOFTRES] = {
        {
            ID = "settingsSectionSoftresExplanation",
            type = LABEL,
        },
        {
            ID = "SoftRes.enableTooltips",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.hideInfoOfPeopleNotInGroup",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.announceInfoInChat",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.announceInfoWhenRolling",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.enableWhisperCommand",
            type = CHECKBOX,
        },
        {
            ID = "SoftRes.fixPlayerNames",
            type = CHECKBOX,
        },
        {
            ID = L.SETTINGS_SUBSECTION_SOFTRES_SUPPORTED_SERVICES,
            type = SUB_SECTION,
        },
        {
            ID = "softResOpen",
            type = BUTTON,
            action = function ()
                GL.Interface.Dialogs.HyperlinkDialog:open{
                    description = L.SETTINGS_OPEN_SOFT_RES_DESCRIPTION,
                    hyperlink = "https://softres.it/",
                };
            end,
        },
        {
            ID = "softResOpenCPR",
            label = L.CLASSICPRIO_ABBR,
            type = BUTTON,
            action = function ()
                GL.Interface.Dialogs.HyperlinkDialog:open{
                    description = L.SETTINGS_OPEN_CPR_DESCRIPTION,
                    hyperlink = "https://classicpr.io/",
                };
            end,
        },
    },
    [L.SETTINGS_SECTION_TMB] = {
        {
            ID = "settingsSectionTMbExplanation",
            type = LABEL,
        },
        {
            ID = "TMB.automaticallyShareData",
            type = CHECKBOX,
        },
        {
            ID = "TMB.shareWhitelist",
            type = INPUT,
            placeholder = ("%s, %s"):format(GL.User.name, L.GARGUL),
        },
        {
            ID = "TMB.hideInfoOfPeopleNotInGroup",
            type = CHECKBOX,
        },
        {
            ID = "TMB.showEntriesWhenSolo",
            type = CHECKBOX,
        },
        {
            ID = "TMB.showEntriesWhenUsingPrio3",
            type = CHECKBOX,
        },
        {
            ID = "TMB.hideWishListInfoIfPriorityIsPresent",
            type = CHECKBOX,
        },
        --- WotLK only
        GL.isClassic and {
            ID = "MasterLooting.linkNormalAndHardModeItems",
            type = CHECKBOX,
        } or nil,
        {
            ID = "AwardingLoot.awardOnReceive",
            type = CHECKBOX,
        },
        {
            ID = "AwardingLoot.awardOnReceiveMinimumQuality",
            type = LOOT_QUALITY_DROPDOWN,
        },
        {
            ID = L.SETTINGS_SUBSECTION_TMB_TOOLTIPS,
            type = SUB_SECTION,
        },
        {
            type = CHECKBOX,
            ID = "TMB.showWishListInfoOnTooltips",
        },
        {
            type = CHECKBOX,
            ID = "TMB.showPrioListInfoOnTooltips",
        },
        {
            type = CHECKBOX,
            ID = "TMB.showItemInfoOnTooltips",
        },
        {
            type = CHECKBOX,
            ID = "TMB.showRaidGroup",
        },
        {
            type = CHECKBOX,
            ID = "TMB.OSHasLowerPriority",
        },
        {
            type = SLIDER,
            ID = "TMB.maximumNumberOfTooltipEntries",
            min = 1,
            max = 50,
            step = 1,
        },
        {
            ID = L.SETTINGS_SUBSECTION_TMB_DROPPED_LOOT,
            type = SUB_SECTION,
        },
        {
            type = CHECKBOX,
            ID = "TMB.includeWishListInfoInLootAnnouncement",
        },
        {
            type = CHECKBOX,
            ID = "TMB.includePrioListInfoInLootAnnouncement",
        },
        {
            type = SLIDER,
            ID = "TMB.maximumNumberOfAnnouncementEntries",
            min = 1,
            max = 15,
            step = 1,
        },
        {
            ID = L.SETTINGS_SUBSECTION_TMB_ROLLING_LOOT,
            type = SUB_SECTION,
        },
        {
            type = CHECKBOX,
            ID = "TMB.announceWishlistInfoWhenRolling",
        },
        {
            type = CHECKBOX,
            ID = "TMB.announcePriolistInfoWhenRolling",
        },
    },
    [L.SETTINGS_SECTION_GDKP] = {
        {
            ID = "settingsSectionGDKpExplanation",
            type = LABEL,
        },
        {
            ID = L.SETTINGS_SUBSECTION_GDKP_RAIDERS,
            type = SUB_SECTION,
        },
        {
            ID = "GDKP.showBidWindow",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.enableBidderQueue",
            type = CHECKBOX,
            callback = function(enableBidderQueue)
                local BidderQueue = GL.Interface.GDKP.BidderQueue;

                if (enableBidderQueue) then
                    BidderQueue:close();
                else
                    BidderQueue:open();
                    BidderQueue:refreshTable();
                end
            end,
        },
        {
            type = SLIDER,
            ID = "GDKP.bidderScale",
            min = .8,
            max = 1.8,
            step = .1,
            callback = function(scale)
                -- Change the existing bidder window if it's active!
                if (GL.Interface.GDKP.Bidder.Window
                    and type(GL.Interface.GDKP.Bidder.Window.SetScale == "function")
                ) then
                    GL.Interface.GDKP.Bidder.Window:SetScale(scale);
                end
            end,
        },
        {
            ID = "GDKP.outbidSound",
            type = DROPDOWN,
            Options = LibStub("LibSharedMedia-3.0"):List("sound")
        },
        {
            ID = L.SETTINGS_SUBSECTION_GDKP_ORGANIZER,
            type = SUB_SECTION,
        },
        {
            type = SLIDER,
            ID = "GDKP.precision",
            min = 0,
            max = 4,
            step = 2,
        },
        {
            ID = "GDKP.showHistoryOnTooltip",
            type = CHECKBOX,
        },
        {
            type = CHECKBOX,
            ID = "GDKP.acceptBidsLowerThanMinimum",
        },
        {
            type = CHECKBOX,
            ID = "GDKP.invalidBidsTriggerAntiSnipe",
        },
        {
            type = CHECKBOX,
            ID = "GDKP.autoAwardViaAuctioneer",
        },
        {
            type = SLIDER,
            ID = "GDKP.auctionEndLeeway",
            min = 1,
            max = 5,
            step = .5,
        },
        {
            type = SLIDER,
            ID = "GDKP.ledgerAuctionScale",
            min = 11,
            max = 50,
            step = 1,
            callback = function (value, valueChanged)
                if (not valueChanged
                    or not GL.Interface.GDKP.Overview.isVisible
                ) then
                    return;
                end

                GL.Interface.GDKP.Overview:refreshLedger();
            end,
        },
        {
            ID = L.SETTINGS_SUBSECTION_GDKP_ANNOUNCEMENTS,
            type = SUB_SECTION,
        },
        {
            ID = "GDKP.announceAuctionStart",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.announcePotAfterAuction",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.notifyIfBidTooLow",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.announceCountdownInRW",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.announceNewBid",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.announceNewBidInRW",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.announceFinalCall",
            type = CHECKBOX,
        },
        {
            type = SLIDER,
            ID = "GDKP.numberOfSecondsToCountdown",
            min = 0,
            max = 25,
            step = 1,
        },
        {
            type = SLIDER,
            ID = "GDKP.numberOfFiveSecondsToCountdown",
            min = 0,
            max = 30,
            step = 5,
        },
        {
            type = SLIDER,
            ID = "GDKP.finalCallTime",
            min = 5,
            max = 30,
            step = 1,
        },
        {
            ID = L.SETTINGS_SUBSECTION_GDKP_PRICES,
            type = SUB_SECTION,
        },
        {
            ID = "settingsSectionGDKpPricesExplanation",
            type = LABEL,
        },
        {
            type = CHECKBOX,
            ID = "GDKP.storeMinimumAndIncrementPerItem",
        },
        {
            ID = "GDKP.defaultMinimumBid",
            type = INPUT,
        },
        {
            ID = "GDKP.defaultIncrement",
            type = INPUT,
        },
        {
            ID = "openPriceImporter",
            type = BUTTON,
            action = function () GL.Commands:call("locale"); end,
        },
        {
            ID = "openLevelRangePrices",
            type = BUTTON,
            action = function () GL.Commands:call("locale"); end,
        },
        {
            ID = L.SETTINGS_SUBSECTION_GDKP_TRADING,
            type = SUB_SECTION,
        },
        {
            ID = "GDKP.whisperGoldDetails",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.addGoldToTradeWindow",
            type = CHECKBOX,
        },
        {
            ID = L.SETTINGS_SUBSECTION_GDKP_QUEUES,
            type = SUB_SECTION,
        },
        {
            ID = "GDKP.disableQueues",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.addDropsToQueue",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.addBOEDropsToQueue",
            type = CHECKBOX,
        },
        {
            ID = "GDKP.minimumDropQuality",
            type = LOOT_QUALITY_DROPDOWN,
        },
        {
            ID = "GDKP.queuedAuctionNoBidsAction",
            type = DROPDOWN,
            Options = GL.Data.Constants.GDKP.QueuedAuctionNoBidsActions,
        },
        {
            type = SLIDER,
            ID = "GDKP.delayBetweenQueuedAuctions",
            min = 1,
            max = 30,
            step = 1,
        },
        {
            ID = ("|c00%s%s|r"):format(Interface.Colors.ERROR, L.SETTINGS_SUBSECTION_GDKP_DANGER),
            type = SUB_SECTION,
        },
        {
            ID = "gdkpResetPrices",
            type = BUTTON,
            action = function ()
                GL.Interface.Dialogs.PopupDialog:open{
                    question = L.SETTINGS_GDKP_RESET_PRICES_CONFIRMATION,
                    OnYes = function ()
                        GL.GDKP:resetPerItemSettings();
                    end,
                };
            end,
        },
        {
            ID = "gdkpResetSessions",
            type = BUTTON,
            action = function ()
                GL.Interface.Dialogs.PopupDialog:open{
                    question = L.SETTINGS_GDKP_RESET_SESSIONS_CONFIRMATION,
                    OnYes = function ()
                        GL.DB:set("GDKP", {});
                        C_UI.Reload();
                    end,
                };
            end,
        },
    },
    -- [L.SETTINGS_SECTION_ANNOUNCE_LOOT] = {
    --     {
    --         ID = "settingsSectionAnnounceLootExplanation",
    --         type = LABEL,
    --     },
    --     {
    --         ID = "DroppedLoot.announceLootToChat",
    --         type = CHECKBOX,
    --     },
    --     {
    --         ID = "DroppedLoot.announceDroppedLootInRW",
    --         type = CHECKBOX,
    --     },
    --     {
    --         ID = "DroppedLoot.minimumQualityOfAnnouncedLoot",
    --         type = LOOT_QUALITY_DROPDOWN,
    --     },
    --     {
    --         ID = "DroppedLootTestAnnouncementInput",
    --         type = INPUT,
    --         label = (L.SETTINGS_DROPPED_LOOT_TEST_ANNOUNCEMENT_INPUT_LABEL):format(L.SETTINGS_DROPPED_LOOT_TEST_ANNOUNCEMENT_BUTTON_LABEL)
    --     },
    --     {
    --         ID = "DroppedLootTestAnnouncementButton",
    --         type = BUTTON,
    --         action = function ()
    --             local Input = Settings.FramePool["DroppedLootTestAnnouncementInput"].Input;
    --             GL.DroppedLoot:announceTest(GL:explode(Input:GetText(), ","));
    --         end,
    --     },
    -- },
    [L.SETTINGS_SECTION_EXPORT_LOOT] = {
        {
            ID = "settingsSectionExportLootExplanation",
            type = LABEL,
        },
        {
            ID = "ExportingLoot.includeDisenchantedItems",
            type = CHECKBOX,
            callback = function ()
                -- Refresh the export window if it's open
                if (GL.Exporter.visible) then
                    GL.Exporter:refreshExportString();
                end
            end,
        },
        {
            ID = "ExportingLoot.includeOffspecItems",
            type = CHECKBOX,
            callback = function ()
                -- Refresh the export window if it's open
                if (GL.Exporter.visible) then
                    GL.Exporter:refreshExportString();
                end
            end,
        },
        {
            ID = "ExportingLoot.showLootAssignmentReminder",
            type = CHECKBOX,
        },
        {
            ID = "ExportingLoot.format",
            type = DROPDOWN,
            Options = {
                [1] = "Thatsmybis TMB (default)",
                [2] = "DFT-Fight-Club (US date format)",
                [3] = "DFT-Fight-Club (EU date format)",
                [4] = "Custom (create your own format)",
                [5] = "Thatsmybis TMB with player realm",
            },
            Order = { 1, 5, 2, 3, 4, },
            callback = function ()
                -- Refresh the export window if it's open
                if (GL.Exporter.visible) then
                    GL.Exporter:refreshExportString();
                end
            end,
        },
        {
            ID = "ExportingLoot.customFormat",
            type = INPUT,
            placeholder = GL.Data.DefaultSettings.ExportingLoot.customFormat,
        },
    },
    [L.SETTINGS_SECTION_LOOT_TRADE_TIMERS] = {
        {
            ID = "settingsSectionLootTradeTimersExplanation",
            type = LABEL,
            label = GL:printfn(L.SETTINGS_SECTION_LOOT_TRADE_TIMERS_EXPLANATION, {
                roll = "|c00A79EFF" .. GL.Settings:get("ShortcutKeys.rollOffOrAuction") .. "|r",
                award = "|c00A79EFF" .. GL.Settings:get("ShortcutKeys.award") .. "|r",
            }),
        },
        {
            ID = "LootTradeTimers.enabled",
            type = CHECKBOX,
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            ID = "LootTradeTimers.showOnlyWhenMasterLooting",
            type = CHECKBOX,
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            ID = "LootTradeTimers.hideAwarded",
            type = CHECKBOX,
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            ID = "LootTradeTimers.hideAwardedToSelf",
            type = CHECKBOX,
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            ID = "LootTradeTimers.hideDisenchanted",
            type = CHECKBOX,
            callback = function ()
                Interface.TradeTime.Overview:close();
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            type = SLIDER,
            ID = "LootTradeTimers.maximumNumberOfBars",
            min = 1,
            max = 100,
            step = 1,
            callback = function ()
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            type = SLIDER,
            ID = "LootTradeTimers.maximumTradeTimeLeft",
            min = 1,
            max = 120,
            step = 1,
            callback = function ()
                Interface.TradeTime.Overview:refresh();
            end,
        },
        {
            ID = "LootTradeTimersDemo",
            type = BUTTON,
            label = L.DEMO,
            action = function (self)
                GL.lootTradeTimersDemoEnabled = not GL.lootTradeTimersDemoEnabled;

                if (GL.lootTradeTimersDemoEnabled) then
                    self:SetText(L.CANCEL);
                else
                    self:SetText(L.DEMO);
                end

                self:SetWidth(BUTTON_WIDTH);
                Interface.TradeTime.Overview:refresh();
                GL.Events:fire("BAG_UPDATE_DELAYED");
            end,
        },
        {
            ID = "LootTradeTimersIconLegend",
            type = CUSTOM,
            build = function (Parent)
                local SettingFrame = CreateFrame("Frame", nil, Parent);
                SettingFrame:SetWidth(1);
                SettingFrame:SetHeight(1);

                AwardedIcon = SettingFrame:CreateTexture(nil, "ARTWORK");
                AwardedIcon:SetTexture("Interface/AddOns/Gargul/Assets/Icons/trophy");
                AwardedIcon:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT", 0, -20);
                AwardedIcon:SetSize(20, 20);

                AwardedIconLabel = Interface:createFontString(SettingFrame, L.SETTINGS_LOOT_TRADE_TIMERS_AWARDED_ICON_LABEL);
                AwardedIconLabel:SetColor(SETTING_COLOR);
                AwardedIconLabel:SetPoint("TOPLEFT", AwardedIcon, "TOPRIGHT", 10, -5);

                DisenchantedIcon = SettingFrame:CreateTexture(nil, "ARTWORK");
                DisenchantedIcon:SetTexture("Interface/AddOns/Gargul/Assets/Icons/disenchant");
                DisenchantedIcon:SetPoint("TOPLEFT", AwardedIcon, "BOTTOMLEFT", 0, -10);
                DisenchantedIcon:SetSize(20, 20);

                DisenchantedIconLabel = Interface:createFontString(SettingFrame, L.SETTINGS_LOOT_TRADE_TIMERS_DISENCHANTED_ICON_LABEL);
                DisenchantedIconLabel:SetColor(SETTING_COLOR);
                DisenchantedIconLabel:SetPoint("TOPLEFT", DisenchantedIcon, "TOPRIGHT", 10, -5);

                return SettingFrame;
            end
        }
    },
    [L.SETTINGS_SECTION_PACKMULE] = {
        {
            ID = "settingsSectionPackMuleExplanation",
            type = LABEL,
            label = (L.SETTINGS_SECTION_PACK_MULE_EXPLANATION):format(L.SETTINGS_PACK_MULE_OPEN_ITEM_RULES_LABEL);
        },
        {
            ID = "packMuleOpenItemRules",
            type = BUTTON,
            action = function () GL.Commands:call("locale"); end,
        },
        {
            ID = "PackMule.enabledForMasterLoot",
            type = CHECKBOX,
        },
        {
            ID = "PackMule.enabledForGroupLoot",
            type = CHECKBOX,
        },
        {
            ID = "PackMule.needWithoutAssist",
            type = CHECKBOX,
        },
        {
            ID = "PackMule.autoDisableForGroupLoot",
            type = CHECKBOX,
        },
        {
            ID = "PackMule.autoConfirmSolo",
            type = CHECKBOX,
        },
        {
            ID = "PackMule.autoConfirmGroup",
            type = CHECKBOX,
        },
        {
            ID = "PackMule.lootGold",
            type = CHECKBOX,
        },
        {
            ID = "SettingsSectionPackMuleTestExplanation",
            type = LABEL,
        },
        {
            ID = "SettingsSectionPackMuleTestInput",
            type = INDIRECT_INPUT,
            label = (L.SETTINGS_SECTION_PACK_MULE_TEST_INPUT_LABEL):format(L.DEMO),
        },
        {
            ID = "SettingsSectionPackMuleTestButton",
            type = BUTTON,
            label = L.DEMO,
            action = function ()
                ---@type EditBox
                local Input = Settings.FramePool["SettingsSectionPackMuleTestInput"].Input;
                Input:ClearFocus();

                GL.Events:fire("GL.SETTING_PACKMULE_TEST_UPDATE_RESULTS", Input:GetText());
            end,
        },
        {
            ID = "SettingsSectionPackMuleTestResult",
            type = CUSTOM,
            build = function (Parent)
                local SettingFrame = CreateFrame("Frame", nil, Parent);
                SettingFrame:SetWidth(1);
                SettingFrame:SetHeight(1);

                ResultLabel = Interface:createFontString(SettingFrame, "");
                ResultLabel:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

                GL.Events:register(nil, "GL.SETTING_PACKMULE_TEST_UPDATE_RESULTS", function (_, value)
                    ResultLabel:SetText("");
                    if (GL:empty(value)) then
                        return;
                    end

                    local itemID = GL:getItemIDFromLink(value) or tonumber(value);
                    if (not itemID) then
                        return;
                    end

                    GL.PackMule:isItemIDIgnored(itemID, function (Loot, itemIDisIgnoredForMaster, itemIDisIgnoredForGroup)
                        if (not Loot) then
                            return;
                        end

                        GL.PackMule:currentTargetForItemForGroupOrMaster(itemID, function (_, masterTarget, groupTarget)
                            ResultLabel:SetText(GL:printfn(L.SETTINGS_SECTION_PACK_MULE_TEST_RESULT_LABEL, {
                                item = Loot.link,
                                item_id = Loot.id,
                                ignored_in_master_loot = itemIDisIgnoredForMaster and GL:colorize(L.YES, "92FF00") or GL:colorize(L.NO, "F7922E"),
                                ignored_in_group_loot = itemIDisIgnoredForGroup and GL:colorize(L.YES, "92FF00") or GL:colorize(L.NO, "F7922E"),
                                master_loot_target = name and GL:nameFormat{ name = masterTarget, colorize = true, } or "-",
                                group_loot_target = name and GL:nameFormat{ name = groupTarget, colorize = true, } or "-",
                            }));
                            ResultLabel:SetColor(SETTING_COLOR);
                        end);
                    end);
                end);

                return SettingFrame;
            end,
        },
    },
    [L.SETTINGS_SECTION_MASTER_LOOTING] = {
        {
            ID = L.SETTINGS_SUBSECTION_MASTER_LOOTING,
            type = SUB_SECTION,
        },
        --- GL.isEra
        GL.isEra and {
            ID = "MasterLooting.preferredMasterLootingThreshold",
            type = LOOT_QUALITY_DROPDOWN,
            description = (L.SETTINGS_MASTER_LOOTING_PREFERRED_MASTER_LOOTING_THRESHOLD_DESCRIPTION):format(GL:colorize(L.ITEM_QUALITY_UNCOMMON, Interface.Colors.UNCOMMON)),
        } or nil,
        GL.isEra and {
            ID = "MasterLootingApplyMasterLootingThreshold",
            type = BUTTON,
            action = function ()
                SetLootMethod('Master', GL.User.name, GL.Settings:get("MasterLooting.preferredMasterLootingThreshold", ""));
            end
        } or nil,
        {
            ID = "MasterLooting.autoOpenMasterLooterDialog",
            type = CHECKBOX,
        },
        {
            ID = "MasterLooting.announceMasterLooter",
            type = CHECKBOX,
        },
        {
            ID = L.SETTINGS_SUBSECTION_ROLLING_LOOT,
            type = SUB_SECTION,
        },
        {
            ID = "MasterLooting.announceRollStart",
            type = CHECKBOX,
        },
        {
            ID = "MasterLooting.doCountdown",
            type = CHECKBOX,
        },
        {
            ID = "MasterLooting.announceCountdownOnce",
            type = CHECKBOX,
        },
        {
            ID = "MasterLooting.announceRollEnd",
            type = CHECKBOX,
        },
        {
            type = SLIDER,
            ID = "MasterLooting.numberOfSecondsToCountdown",
            min = 3,
            max = 25,
            step = 1,
        },
        {
            ID = "MasterLooting.defaultRollOffNote",
            type = INPUT,
            placeholder = L.LOOTMASTER_DEFAULT_NOTE,
        },
        {
            ID = "MasterLooting.alwaysUseDefaultNote",
            type = CHECKBOX,
            callback = function ()
                if (GL.MasterLooterUI:isShown()) then
                    GL.MasterLooterUI:updateItemNote();
                end
            end,
        },
        {
            ID = "RollTracking.trackAll",
            type = CHECKBOX,
        },
        {
            ID = "RollTracking.sortBySoftRes",
            type = CHECKBOX,
        },
        {
            ID = "RollTracking.sortByTMBWishlist",
            type = CHECKBOX,
        },
        {
            ID = "RollTracking.sortByTMBPrio",
            type = CHECKBOX,
        },
        {
            ID = L.SETTINGS_SUBSECTION_ANNOUNCING_LOOT,
            type = SUB_SECTION,
        },
        {
            ID = "settingsSectionAnnounceLootExplanation",
            type = LABEL,
        },
        {
            ID = "DroppedLoot.announceLootToChat",
            type = CHECKBOX,
        },
        {
            ID = "DroppedLoot.announceDroppedLootInRW",
            type = CHECKBOX,
        },
        {
            ID = "DroppedLoot.minimumQualityOfAnnouncedLoot",
            type = LOOT_QUALITY_DROPDOWN,
        },
        {
            ID = "DroppedLootTestAnnouncementInput",
            type = INDIRECT_INPUT,
            label = (L.SETTINGS_DROPPED_LOOT_TEST_ANNOUNCEMENT_INPUT_LABEL):format(L.SETTINGS_DROPPED_LOOT_TEST_ANNOUNCEMENT_BUTTON_LABEL),
            placeholder = "6948",
            value = "6948",
        },
        {
            ID = "DroppedLootTestAnnouncementButton",
            type = BUTTON,
            action = function ()
                local Input = Settings.FramePool["DroppedLootTestAnnouncementInput"].Input;
                GL.DroppedLoot:announceTest(GL:explode(Input:GetText(), ","));
            end,
        },
    },
};

---@return table|nil
function Settings:open(section)
    FONT = GL.FONT;

    local Window = _G[self.windowName] or self:build();

    self:showSection(section or DEFAULT_SECTION);

    Window:Show();
    return Window;
end

---@return void
function Settings:lock()
    local Window = _G[self.windowName];

    if (not Window or not Window:IsShown()) then
        return;
    end

    -- Just a fail-safe so we don't end up with multiple lockscreens
    if (Window.Lock) then
        Interface:release(Window.Lock);
        Window.Lock = nil;
    end

    -- local Lock = CreateFrame("Frame", nil, UIParent);
    local Lock = CreateFrame("Frame", nil, UIParent, BackdropTemplateMixin and "BackdropTemplate");
    Lock:SetBackdrop{
        bgFile = "Interface/DialogFrame/UI-DialogBox-Background",
     };
    Lock:SetAllPoints(UIParent);

    -- This is to make sure this window is shown on top
    Lock:SetFrameStrata("FULLSCREEN_DIALOG");
    Lock:EnableMouse(true);
    Lock:SetToplevel(true);
    Lock:SetFrameLevel(5000);
    Lock:SetMovable(true);
    Lock:StartMoving();
    Lock:StopMovingOrSizing();
    Lock:SetMovable(false);
    Lock:SetToplevel(false);

    Window.Lock = Lock;
end

---@return void
function Settings:unlock()
    local Window = _G[self.windowName];

    if (not Window or not Window:IsShown()) then
        return;
    end

    if (Window.Lock) then
        Interface:release(Window.Lock);
        Window.Lock = nil;
    end
end

---@return Frame
function Settings:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    StaticPopupDialogs[RESET_CONFIRMATION_DIALOG_NAME] = {
        text = L.SETTINGS_DEFAULTS_CONFIRM,
        button1 = L.SETTINGS_DEFAULTS_ALL,
        button2 = L.CANCEL,
        button3 = L.SETTINGS_DEFAULTS_SHOWN,
        cancels = RESET_CONFIRMATION_DIALOG_NAME,
        exclusive = true,
        OnButton1 = function ()
            self:resetToDefaults(ALL_SETTINGS);
        end,
        OnAlt = function ()
            self:resetToDefaults(SHOWN_SETTINGS);
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        OnShow = function (Window)
            self:lock();

            -- This is to make sure this window is always on top
            Window:SetFrameStrata("FULLSCREEN_DIALOG");
            Window:EnableMouse(true);
            Window:SetToplevel(true);
            Window:SetFrameLevel(5000);
            Window:SetMovable(true);
            Window:StartMoving();
            Window:StopMovingOrSizing();
            Window:SetMovable(false);
        end,
        OnHide = function ()
            self:unlock();
        end,
    };

    ---@type Frame
    local Window = Interface:createWindow({
        name = self.windowName,
        width = 700,
        height = 500,
        hideResizeButton = true,
        hideMinimizeButton = true,
    });
    Window:Hide();

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        {text = L.WINDOW, isTitle = true, notCheckable = true },
        {text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
    });

    ---@type EditBox
    local Search = Interface:inputBox(Window, nil, SEARCH);
    Search:SetWidth(400);
    Search:SetPoint("TOPLEFT", Window, "TOPLEFT", 70, -26);
    Window.Search = Search;

    local phraseBefore = "";
    Search:SetScript("OnTextChanged", function ()
        GL:after(.5, "SETTINGS_SEARCH_CHANGED", function ()
            local phrase = Search:GetText();

            if (phrase == phraseBefore) then
                return;
            end
            phraseBefore = phrase;

            local phraseLength = strlen(phrase);
            if (phraseLength > 0 and phraseLength < 2) then
                return;
            end

            local Entries = self:search(phrase);

            if (not Entries) then
                self:showSection(self.activeSection);

                return;
            end

            self.inSearchMode = true;
            self:hideAllSettings();
            self:showSettings(Window.SettingsFrame, Entries);
            self:resetScroll();
        end);
    end);

    ---@type Button
    local SearchClear = CreateFrame("Button", nil, Window, "UIPanelCloseButton");
    SearchClear:SetPoint("TOPLEFT", Search, "TOPRIGHT", -1, 2);
    SearchClear:SetSize(26, 26);
    SearchClear:SetScript("OnClick", function ()
        GL:cancelTimer("SETTINGS_SEARCH_CHANGED");
        Search:Clear();
        self:showSection(self.activeSection);
    end);
    Interface:addTooltip(SearchClear, L.CLEAR);

    ---@type Button
    local Defaults = Interface:dynamicPanelButton(Window, L.SETTINGS_DEFAULTS);
    Defaults:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -44, -26);
    Defaults:SetPoint("LEFT", SearchClear, "RIGHT", 30, 0);
    Defaults:SetScript("OnClick", function ()
        StaticPopup_Show(RESET_CONFIRMATION_DIALOG_NAME);
    end);


    Window.Logo = Window:CreateTexture(nil, "ARTWORK")
    Window.Logo:SetTexture("Interface/AddOns/Gargul/Assets/Icons/Gargul");
    Window.Logo:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -20);
    Window.Logo:SetSize(32, 32);

    Interface:addTooltip(Window.Logo, L.SETTINGS_SECTION_GETTING_STARTED_MORE_INFO);
    Window.Logo:SetScript("OnMouseUp", function ()
        GL.Interface.Dialogs.HyperlinkDialog:open{
            description = L.SETTINGS_SECTION_GETTING_STARTED_MORE_INFO_DIALOG,
            hyperlink = L.DISCORD_URL,
        };
    end);

    self:injectSectionsMenu(Window);

    --[[ SCROLLFRAME BOILERPLATE ]]
    ---@type ScrollFrame
    local ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate");
    ScrollFrame:SetPoint("TOPLEFT", Window, "TOPLEFT", 166, -70);
    ScrollFrame:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -40, 30);
    Window.ScrollFrame = ScrollFrame;

    ---@type Frame
    Window.SettingsFrame = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(Window.SettingsFrame);
    Window.SettingsFrame:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    Window.SettingsFrame:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    Window.SettingsFrame:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");

    _G[self.windowName] = Window;
    return Window;
end

---@param Parent Frame
---
---@return Frame
function Settings:injectSectionsMenu(Parent)
    for position, section in pairs(SECTION_ORDER) do
        local Item = CreateFrame("Frame", nil, Parent);
        Item:EnableMouse(true);
        Item:SetSize(128, MENU_ROW_HEIGHT);
        Item:SetPoint("TOPLEFT", Parent.Logo, "BOTTOMLEFT", 0, (position * MENU_ROW_HEIGHT) * -1 + 10);

        Item.Highlight = Item:CreateTexture(nil, "BACKGROUND");
        Item.Highlight:SetTexture("interface/buttons/ui-listbox-highlight.blp");
        Item.Highlight:SetAllPoints(Item);
        Item.Highlight:Hide();

        Item.Hover = Item:CreateTexture(nil, "BACKGROUND");
        Item.Hover:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
        Item.Hover:SetAllPoints(Item);
        Item.Hover:Hide();

        Item.text = Interface:createFontString(Item, "  " .. section);
        Item.text:SetFont(MENU_FONT_SIZE, "OUTLINE");
        Item.text:SetPoint("CENTER", Item);
        Item.text:SetPoint("LEFT", Item);

        Item:SetScript("OnMouseUp", function ()
            self:showSection(section);
        end);

        Item:SetScript("OnEnter", function ()
            if (Item.Highlight:IsShown()) then
                return;
            end

            Item.Hover:Show();
        end);

        Item:SetScript("OnLeave", function ()
            if (Item.Highlight:IsShown()) then
                return;
            end

            Item.Hover:Hide();
        end);

        self.MenuFrames[position] = Item;
    end

    return Parent;
end

---@param section string
---@return void
function Settings:showSection(section)
    self.inSearchMode = false;

    if (not SettingEntries[section]) then
        return;
    end

    self:hideAllSettings();

    local Window = self:build();
    local Parent = Window.SettingsFrame;
    self:disableMenuHighlights();

    local MenuEntry = self.MenuFrames[SECTION_INDEXES[section]];
    MenuEntry.Hover:Hide();
    MenuEntry.Highlight:Show();

    local order = 2;
    local Results = {
        [1] = self:buildHeaderForSection(Parent, section),
    };
    for _, Details in pairs(SettingEntries[section] or {}) do
        Results[order] = self:buildFrameForSetting(Parent, Details);
        order = order + 1;
    end

    self:showSettings(Parent, Results);
    self:resetScroll();

    Window.Search:Clear();

    self.activeSection = section;
end

---@return void
function Settings:hideAllSettings()
    for _, SettingFrame in pairs(self.FramePool or {}) do
        if (SettingFrame:IsVisible()) then
            SettingFrame:Hide();
        end
    end
end

---@return void
function Settings:disableMenuHighlights()
    for _, Frame in pairs(self.MenuFrames or {}) do
        Frame.Highlight:Hide();
    end
end

---@param Parent Frame
---@param SettingFrames Frame[]
---
---@return void
function Settings:showSettings(Parent, SettingFrames)
    if (not SettingFrames) then
        return;
    end

    local anchorIsParent = true;
    local Anchor = Parent;
    local yOffset = 0;
    local IDsHandled = {};
    for _, Entry in pairs(SettingFrames or {}) do
        (function ()
            -- In case we have the same setting in multiple sections we only want to render it once
            if (IDsHandled[Entry.ID]) then
                return;
            end

            Entry:ClearAllPoints();
            Entry:Show();

            if (Entry.type == SECTION) then
                Entry:SetPoint("LEFT", Parent, "LEFT", SECTION_MARGIN_LEFT, 0);
                Entry:SetPoint("TOP", Anchor, anchorIsParent and "TOP" or "BOTTOM", 0, anchorIsParent and SECTION_HOVER_PADDING_TOP * -1 or SECTION_MARGIN_TOP * -1);

                yOffset = SECTION_MARGIN_BOTTOM;
            elseif (Entry.type == SUB_SECTION) then
                Entry:SetPoint("LEFT", Parent, "LEFT", SUB_SECTION_MARGIN_LEFT, 0);
                Entry:SetPoint("TOP", Anchor, "BOTTOM", 0, SUB_SECTION_MARGIN_TOP * -1);

                yOffset = SUB_SECTION_MARGIN_BOTTOM;
            elseif (Entry.type == SLIDER) then
                Entry:SetPoint("LEFT", Parent, "LEFT", SETTING_MARGIN_LEFT, 0);
                Entry:SetPoint("TOP", Anchor, "BOTTOM", 0, yOffset * -1 - SLIDER_MARGIN_TOP);

                yOffset = SLIDER_MARGIN_BOTTOM;
            else
                Entry:SetPoint("LEFT", Parent, "LEFT", SETTING_MARGIN_LEFT, 0);
                Entry:SetPoint("TOP", Anchor, "BOTTOM", 0, yOffset * -1);

                yOffset = SETTING_MARGIN_BOTTOM;
            end

            Anchor = Entry;
            anchorIsParent = false;
            IDsHandled[Entry.ID] = true;
        end)();
    end
end

---@param Parent Frame
---@param section string
---
---@return Frame
function Settings:buildHeaderForSection(Parent, section)
    local SectionFrame = self.FramePool[section];
    if (SectionFrame) then
        return SectionFrame;
    end

    ---@type Frame
    SectionFrame = CreateFrame("Frame", nil, Parent);
    SectionFrame:SetWidth(300);
    SectionFrame:SetHeight(20);
    SectionFrame:EnableMouse(true);

    ---@type FontString
    local SectionHeader = Interface:createFontString(SectionFrame, section);
    SectionHeader:SetFont(1.8, "OUTLINE");
    SectionHeader:SetPoint("TOPLEFT", SectionFrame, "TOPLEFT");

    ---@type Line
    local Line = SectionFrame:CreateLine();
    Line:SetThickness(1);
    Line:SetColorTexture(.9, .9, .9, .5);
    Line:SetStartPoint("TOPLEFT", SectionFrame, 0, -30);
    Line:SetEndPoint("TOPRIGHT", SectionFrame, 20, -30);

    SectionFrame.Hover = SectionFrame:CreateTexture(nil, "BACKGROUND");
    SectionFrame.Hover:SetTexture("interface/buttons/ui-listbox-highlight2.blp");
    SectionFrame.Hover:SetPoint("BOTTOMLEFT", Line, "TOPLEFT");
    SectionFrame.Hover:SetPoint("RIGHT", Line, "RIGHT");
    SectionFrame.Hover:SetPoint("TOP", SectionFrame, "TOP", 0, SECTION_HOVER_PADDING_TOP);
    SectionFrame.Hover:Hide();

    SectionFrame:SetScript("OnMouseUp", function ()
        self:showSection(section);
    end);

    SectionFrame:SetScript("OnEnter", function ()
        if (not self.inSearchMode) then
            return;
        end

        SectionFrame.Hover:Show();
    end);

    SectionFrame:SetScript("OnLeave", function ()
        SectionFrame.Hover:Hide();
    end);

    SectionFrame.type = SECTION;
    SectionFrame.label = section;
    SectionFrame.ID = section;

    self.FramePool[SectionFrame.ID] = SectionFrame;
    return SectionFrame;
end

---@param Parent Frame
---@param Details table
---
---@return Frame
function Settings:buildFrameForSetting(Parent, Details)
    local settingID = Details.ID;

    if (self.FramePool[settingID]) then
        return self.FramePool[settingID];
    end

    ---@type Frame
    local SettingFrame;

    ---@type string
    local label;

    ---@type string
    local description;

    if (Details.type == CUSTOM) then
        label = settingID;
        SettingFrame = Details.build(Parent);

    elseif (Details.type == SUB_SECTION) then
        label = settingID;

        ---@type FontString
        SettingFrame = Interface:createFontString(Parent, Details.ID);
        SettingFrame:SetFont(SUBJECT_FONT_SIZE, "OUTLINE");

    elseif (Details.type == LABEL) then
        label = Details.label or L[GL:camelToSnake(Details.ID)];

        ---@type FontString
        SettingFrame = Interface:createFontString(Parent, label);
        SettingFrame:SetColor(SETTING_COLOR);

    elseif (Details.type == INPUT) then
        label = Details.label or self:getLabel(settingID);
        description = self:getDescription(settingID);

        ---@type Frame
        SettingFrame = CreateFrame("Frame", nil, Parent);
        SettingFrame:SetWidth(300);
        SettingFrame:SetHeight(40);

        ---@type FontString
        local InputLabel = Interface:createFontString(SettingFrame, label);
        InputLabel:SetColor(SETTING_COLOR);
        InputLabel:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

        local Input = Interface:inputBox(SettingFrame, nil, Details.placeholder);
        Input:SetPoint("TOPLEFT", InputLabel, "BOTTOMLEFT", 2, -2);
        Input:SetWidth(200);

        local value = GL.Settings:get(settingID);
        if (value) then
            Input:SetText(value);
        end

        Input:SetScript("OnTextChanged", function ()
            GL.Settings:set(settingID, Input:GetText());
        end);

        if (description) then
            local tooltip = ("|c00FFFFFF%s|r\n\n%s"):format(label, description);

            Interface:addTooltip(SettingFrame, tooltip);
            Interface:addTooltip(Input, tooltip, "TOP", SettingFrame);
        end

        SettingFrame.Input = Input;
    elseif (Details.type == INDIRECT_INPUT) then
        label = Details.label or self:getLabel(settingID);
        description = self:getDescription(settingID);

        ---@type Frame
        SettingFrame = CreateFrame("Frame", nil, Parent);
        SettingFrame:SetWidth(300);
        SettingFrame:SetHeight(40);

        ---@type FontString
        local InputLabel = Interface:createFontString(SettingFrame, label);
        InputLabel:SetColor(SETTING_COLOR);
        InputLabel:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

        local Input = Interface:inputBox(SettingFrame, nil, Details.placeholder);
        Input:SetPoint("TOPLEFT", InputLabel, "BOTTOMLEFT", 2, -2);
        Input:SetWidth(200);
        
        if (Details.value) then
            Input:SetText(Details.value);
        end

        if (description) then
            local tooltip = ("|c00FFFFFF%s|r\n\n%s"):format(label, description);

            Interface:addTooltip(SettingFrame, tooltip);
            Interface:addTooltip(Input, tooltip, "TOP", SettingFrame);
        end

        SettingFrame.Input = Input;

    elseif (Details.type == CHECKBOX) then
        label = Details.label or self:getLabel(settingID);
        description = self:getDescription(settingID);

        ---@type string
        local tooltip = description and ("|c00FFFFFF%s|r\n\n%s"):format(label, description) or nil;

        ---@type Frame
        SettingFrame = Interface:createCheckbox{
            Parent = Parent,
            name = ("GL.Interface.Settings.Wrappers.%s"):format(settingID),
            checked = GL.Settings:get(settingID),
            label = label,
            tooltip = tooltip,
            callback = function (_, value)
                GL.Settings:set(settingID, value);

                if (Details.callback) then
                    Details.callback(value);
                end
            end,
        };

        SettingFrame.Label:SetColor(SETTING_COLOR);

        if (tooltip) then
            Interface:addTooltip(SettingFrame, tooltip, "TOP", SettingFrame.Label);
        end

        GL.Settings:onChange(settingID, function ()
            SettingFrame:SetChecked(GL.Settings:get(settingID));
        end);

    elseif (Details.type == BUTTON) then
        label = Details.label or self:getLabel(settingID);
        description = self:getDescription(settingID);

        ---@type Button
        SettingFrame = Interface:dynamicPanelButton(Parent, label);
        SettingFrame:SetWidth(BUTTON_WIDTH);
        SettingFrame:SetScript("OnClick", Details.action);

        if (description) then
            Interface:addTooltip(SettingFrame, ("|c00FFFFFF%s|r\n\n%s"):format(label, description));
        end

    elseif (Details.type == DROPDOWN) then
        label = self:getLabel(settingID);
        description = self:getDescription(settingID);

        ---@type string
        local tooltip = description and ("|c00FFFFFF%s|r\n\n%s"):format(label, description) or nil;

        ---@type Frame
        SettingFrame = CreateFrame("Frame", nil, Parent);
        SettingFrame:SetWidth(300);
        SettingFrame:SetHeight(40);

        ---@type FontString
        local Label = Interface:createFontString(SettingFrame, label);
        Label:SetColor(SETTING_COLOR);
        Label:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

        ---@type Frame
        local DropDown = Interface:createDropdown{
            Parent = SettingFrame,
            Options = Details.Options,
            Order = Details.Order,
            value = GL.Settings:get(settingID),
            callback = function (_, value)
                GL.Settings:set(settingID, value);
            end
        };
        DropDown:SetPoint("TOPLEFT", Label, "BOTTOMLEFT", -20, -2);

        if (tooltip) then
            Interface:addTooltip(Label, tooltip);
            Interface:addTooltip(DropDown, tooltip, "TOP", Label);
        end

    elseif (Details.type == MINIMAP_HOTKEY_DROPDOWN) then
        ---@type string
        local hotkey = GL:explode(Details.ID, ".")[3];

        label = L["HOTKEYS_" .. hotkey];
        
        ---@type Frame
        SettingFrame = CreateFrame("Frame", nil, Parent);
        SettingFrame:SetWidth(300);
        SettingFrame:SetHeight(40);

        ---@type FontString
        local ChannelLabel = Interface:createFontString(SettingFrame, label);
        ChannelLabel:SetColor(SETTING_COLOR);
        ChannelLabel:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");
  
        ---@type Frame
        local DropDown = Interface:createDropdown{
            Parent = SettingFrame,
            Options = MINIMAP_HOTKEY_ACTIONS,
            value = GL.Settings:get("MinimapButton.Actions." .. hotkey),
            callback = function (_, value)
                GL.Settings:set("MinimapButton.Actions." .. hotkey, value);
            end
        };
        DropDown:SetPoint("TOPLEFT", ChannelLabel, "BOTTOMLEFT", -20, -2);

    elseif (Details.type == LOOT_QUALITY_DROPDOWN) then
        label = Details.label or self:getLabel(settingID);
        description = Details.description or self:getDescription(settingID);

        ---@type string
        local tooltip = description and ("|c00FFFFFF%s|r\n\n%s"):format(label, description) or nil;

        local Options = {};
        local ItemQualityColors = GL.Data.Constants.ItemQualityColors;
        for i = 0, #ItemQualityColors do
            Options[i] = ("|c00%s%s|r"):format(ItemQualityColors[i].hex, ItemQualityColors[i].description);
        end

        ---@type Frame
        SettingFrame = CreateFrame("Frame", nil, Parent);
        SettingFrame:SetWidth(300);
        SettingFrame:SetHeight(40);

        ---@type FontString
        local Label = Interface:createFontString(SettingFrame, label);
        Label:SetColor(SETTING_COLOR);
        Label:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

        ---@type Frame
        local DropDown = Interface:createDropdown{
            Parent = SettingFrame,
            Options = Options,
            value = GL.Settings:get(settingID),
            callback = function (_, value)
                GL.Settings:set(settingID, value);
            end
        };
        DropDown:SetPoint("TOPLEFT", Label, "BOTTOMLEFT", -20, -2);

        if (tooltip) then
            Interface:addTooltip(Label, tooltip);
            Interface:addTooltip(DropDown, tooltip, "TOP", Label);
        end

    elseif (Details.type == SLIDER) then
        label = self:getLabel(settingID);
        description = self:getDescription(settingID);

        ---@type string
        local tooltip = description and ("|c00FFFFFF%s|r\n\n%s"):format(label, description) or nil;

        ---@type Frame
        SettingFrame = CreateFrame("Frame", nil, Parent);
        SettingFrame:SetWidth(300);
        SettingFrame:SetHeight(40);

        ---@type FontString
        local Label = Interface:createFontString(SettingFrame, label);
        Label:SetColor(SETTING_COLOR);
        Label:SetPoint("TOPLEFT", SettingFrame, "TOPLEFT");

        ---@type Frame
        local Slider = Interface:createSlider{
            Parent = SettingFrame,
            min = Details.min,
            max = Details.max,
            step = Details.step,
            value = GL.Settings:get(settingID),
            callback = function (_, value)
                local currentValue = GL.Settings:get(settingID);
                GL.Settings:set(settingID, value);

                if (Details.callback) then
                    Details.callback(value, currentValue ~= value);
                end
            end
        };
        Slider:SetPoint("TOPLEFT", Label, "BOTTOMLEFT", 0, -6);

        if (tooltip) then
            Interface:addTooltip(Label, tooltip);
            Interface:addTooltip(Slider, tooltip, "TOP", Label);
        end
    end

    SettingFrame.label = label;
    SettingFrame.description = description;
    SettingFrame.type = Details.type;
    SettingFrame.ID = Details.ID;

    self.FramePool[settingID] = SettingFrame;
    return self.FramePool[settingID];
end

---@param settingID string
---
---@return string|nil
function Settings:getLabel(settingID)
    return L["SETTINGS_" .. GL:camelToSnake(settingID) .. "_LABEL"];
end

---@param settingID string
---
---@return string|false
function Settings:getDescription(settingID)
    local translationID = "SETTINGS_" .. GL:camelToSnake(settingID) .. "_DESCRIPTION";
    local value = L[translationID];

    return translationID ~= value and value or false;
end

---@param settingID string
---
---@return string|false
function Settings:getTags(settingID)
    local translationID = "SETTINGS_" .. GL:camelToSnake(settingID) .. "_TAGS";
    local value = L[translationID];

    return translationID ~= value and value or false;
end

---@param phrase string
---
---@return table|false
function Settings:search(phrase)
    if (GL:empty(phrase)) then
        return false;
    end

    ---@type Frame
    local Parent = self:build().SettingsFrame;
    local TypesToSkip = {
        CUSTOM,
        LABEL,
    };

    local Results = {};

    local order = 1;
    local addResult = function (Result)
        Results[order] = Result;
        order = order + 1;
    end;

    local potentiallyIrrelevant = nil;
    local removeThePotentiallyIrrelevant = function ()
        if (potentiallyIrrelevant == nil) then
            return;
        end

        for i = order, 1, -1 do
            Results[i] = nil;

            if (i <= potentiallyIrrelevant) then
                order = i;
                break;
            end
        end

        potentiallyIrrelevant = nil;
    end;

    local addEntireSection = false;
    local addEntireSubSection = false;
    for _, section in pairs(SECTION_ORDER) do
        removeThePotentiallyIrrelevant();

        addEntireSection = GL:strContains(section, phrase);
        potentiallyIrrelevant = not addEntireSection and order or nil;

        addResult(self:buildHeaderForSection(Parent, section));

        for _, Setting in pairs(SettingEntries[section] or {}) do
            (function ()
                if (not Setting or GL:inTable(TypesToSkip, Setting.type)) then
                    return;
                end

                local SettingFrame = self:buildFrameForSetting(Parent, Setting);

                -- We're adding this entire section, no need to do any further checks
                if (addEntireSection) then
                    addResult(SettingFrame);
                    return;
                end

                if (Setting.type == SUB_SECTION) then
                    -- Don't remove the parent section since we might still have relevant entries to add
                    if (potentiallyIrrelevant and Results[potentiallyIrrelevant].type ~= SECTION) then
                        -- The last entry could be an empty sub section
                        removeThePotentiallyIrrelevant();
                    end

                    addEntireSubSection = GL:strContains(Setting.ID, phrase);
                    addResult(SettingFrame);

                    -- If we only add relevant settings within this subsection then we might
                    -- be dealing with an empty subsection here that will need removing later
                    if (not addEntireSubSection) then
                        potentiallyIrrelevant = potentiallyIrrelevant or order - 1; -- -1 because we already created the Frame at this point
                    else
                        potentiallyIrrelevant = nil;
                    end

                    return;
                end

                -- We're adding this entire subsection, no need to do any further checks
                if (addEntireSubSection) then
                    addResult(SettingFrame);
                    return;
                end

                -- There's nothing to match the phrase against
                if (not SettingFrame.label
                    and not SettingFrame.description
                ) then
                    return;
                end

                local tags = self:getTags(Setting.ID) or "";

                -- The setting doesn't have anything to do with the search phrase
                if ((not SettingFrame.label or not GL:strContains(SettingFrame.label .. " " .. tags, phrase))
                    and (not SettingFrame.description or not GL:strContains(SettingFrame.description .. " " .. tags, phrase))
                ) then
                    return;
                end

                addResult(SettingFrame);

                -- There was a match within the subsection so it's not irrelevant
                potentiallyIrrelevant = nil;
            end)();
        end
    end

    -- Remove potentially lingering irrelevant subsection
    removeThePotentiallyIrrelevant();

    return Results;
end

---@return void
function Settings:resetToDefaults(mode)
    GL:xd{
        mode = mode,
    };
end

--- Reset the vertical scroll of the settings frame
---
---@return void
function Settings:resetScroll()
    local Window = _G[self.windowName];
    if (not Window) then
        return;
    end

    Window.ScrollFrame:SetVerticalScroll(0);
    Window.ScrollFrame:SetHorizontalScroll(0);
end
