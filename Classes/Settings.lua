--[[
    This class handles the addon's default and user settings

    The default settings are overwritten with the user's settings
    after the addon is loaded

    The showSettingsMenu function is responsible for showing the
    settings in the WoW settings menu
]]
local _, App = ...;

App.Settings = {
    _initialized = false,
    Defaults = App.Data.DefaultSettings,
    Active = {}, -- This object holds the actual setting values applicable to this runtime
};

local UI = App.UI;
local Utils = App.Utils;
local Settings = App.Settings;

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[App.name .. "_RESET_TO_DEFAULTS_CONFIRMATION"] = {
    text = string.format("Are you sure you want to reset %s to its default settings? DKP, Soft reserves and loot priorities will remain untouched!", App.name),
    button1 = "Yes",
    button2 = "No",
    OnAccept = App.Settings.resetToDefault,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

function Settings:_init()
    Utils:debug("Settings:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- Combine defaults and user settings
    self:overrideDefaultsWithUserSettings();

    -- Prepare the options / config frame
    local Frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer);
    Frame.name = App.name;
    Frame:SetScript("OnShow", function ()
        self:showSettingsMenu(Frame);
    end);
    InterfaceOptions_AddCategory(Frame);

    self._initialized = true;
end

-- Reset the addon to its default settings
function Settings:resetToDefault()
    Utils:debug("Settings:resetToDefault");

    self.Active = {};
    App.DB.Settings = {};

    -- Combine defaults and user settings
    self:overrideDefaultsWithUserSettings();
end

-- Override the addon's default settings with the user's custom settings
function Settings:overrideDefaultsWithUserSettings()
    Utils:debug("Settings:overrideDefaultsWithUserSettings");

    -- Reset the currently active settings table
    self.Active = {};

    -- Combine the default and user's settings to one settings table
    Settings = Utils:tableMerge(Settings.Defaults, App.DB.Settings);

    -- Set the values of the settings table directly on the App.Settings table.
    for key, value in pairs(Settings) do
        self.Active[key] = value;
    end

    App.DB.Settings = self.Active;
end

-- We use this method to make sure that the interface is only built
-- when the user has actually accessed the settings menu, which doesn't happen every session
function Settings:showSettingsMenu(Frame)
    Utils:debug("Settings:showSettingsMenu");

    -- Add the addon title to the top of the settings frame
    local Title = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    Title:SetPoint("TOPLEFT", 16, -16);
    Title:SetText(App.name);

    -- Do you want to announce dropped loot in chat?
    local AnnounceLootToChatCheckbox = UI:createSettingCheckbox(
        Frame,
        "Announce loot to chat",
        "Checking this will make sure that dropped loot of a given minimum quality (see the minimum announce quality setting) is announced to the party or raid chat",
        function (_, checked)
            self:set("announceLootToChat", checked);
        end
    );
    AnnounceLootToChatCheckbox:SetChecked(self:get("announceLootToChat"));
    AnnounceLootToChatCheckbox:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -8);

    -- Title for the minimum quality loot announcement dropdown
    local AnnounceMinimumQualityTitle = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormal");
    AnnounceMinimumQualityTitle:SetPoint("TOPLEFT", AnnounceLootToChatCheckbox, "BOTTOMLEFT", 16, -16);
    AnnounceMinimumQualityTitle:SetText("Minimum announce quality");

    -- What is the minimum quality of items you want to announce in chat?
    local info = {}
    local AnnounceMinimumQualityDropdown = CreateFrame("Frame", "AnnounceMinimumQuality", Frame, "UIDropDownMenuTemplate")
    AnnounceMinimumQualityDropdown:SetPoint("TOPLEFT", AnnounceMinimumQualityTitle, "BOTTOMLEFT", -15, -10)
    AnnounceMinimumQualityDropdown.initialize = function()
        wipe(info);
        local qualityLevels = {0, 1, 2, 3, 4, 5};
        local names = {
            "0 - Poor",
            "1 - Common",
            "2 - Uncommon",
            "3 - Rare",
            "4 - Epic",
            "5 - Legendary"
        };

        for i, qualityLevel in next, qualityLevels do
            info.text = names[i];
            info.value = i - 1;

            info.func = function(self)
                App.Settings:set("minimumQualityOfAnnouncedLoot", self.value);
                AnnounceMinimumQualityText:SetText(self:GetText());
            end

            info.checked = qualityLevel == App.Settings:get("minimumQualityOfAnnouncedLoot");
            UIDropDownMenu_AddButton(info);
        end
    end
    AnnounceMinimumQualityText:SetText(App.Settings:get("minimumQualityOfAnnouncedLoot"));

    -- Do you want to include softreserve details on dropped loot?
    local IncludeSoftReservesInLootAnnouncementCheckbox = UI:createSettingCheckbox(
        Frame,
        "Include soft reserves in loot announcement",
        "Checking this will make sure that soft reserves of dropped loot are announced in the chat (if any)",
        function (_, checked)
            self:set("includeSoftReservesInLootAnnouncement", checked);
        end
    );
    IncludeSoftReservesInLootAnnouncementCheckbox:SetChecked(self:get("includeSoftReservesInLootAnnouncement"));
    IncludeSoftReservesInLootAnnouncementCheckbox:SetPoint("TOPLEFT", AnnounceMinimumQualityDropdown, "BOTTOMLEFT", 0, -8);

    -- Do you want to include softreserve details on dropped loot?
    local IncludeWishlistsInLootAnnouncementCheckbox = UI:createSettingCheckbox(
        Frame,
        "Include wishlist details in loot announcement",
        "Checking this will make sure that wishlist details of dropped loot are announced in the chat (if any)",
        function (_, checked)
            self:set("includeWishlistsInLootAnnouncement", checked);
        end
    );
    IncludeWishlistsInLootAnnouncementCheckbox:SetChecked(self:get("includeWishlistsInLootAnnouncement"));
    IncludeWishlistsInLootAnnouncementCheckbox:SetPoint("TOPLEFT", IncludeSoftReservesInLootAnnouncementCheckbox, "BOTTOMLEFT", 0, -8);

    -- Do you want to include wishlist details on dropped loot?
    local HideWishListsOfPeopleNotInraid = UI:createSettingCheckbox(
        Frame,
        "Hide wishlist of people not in raid",
        "Checking this will make sure that you only see the names of players who are actually in your raid",
        function (_, checked)
            self:set("hideWishListsOfPeopleNotInraid", checked);
        end
    );
    HideWishListsOfPeopleNotInraid:SetChecked(self:get("hideWishListsOfPeopleNotInraid"));
    HideWishListsOfPeopleNotInraid:SetPoint("TOPLEFT", IncludeWishlistsInLootAnnouncementCheckbox, "BOTTOMLEFT", 0, -8);

    -- Do you want to see the countdown window with roll button when a rolloff starts?
    local ShowRollOffWindowCheckbox = UI:createSettingCheckbox(
        Frame,
        "Enable roll window",
        "Checking this will make sure that you see the roll window with timer and roll button whenever the master looter starts a roll",
        function (_, checked)
            self:set("showRollOffWindow", checked);
        end
    );
    ShowRollOffWindowCheckbox:SetChecked(self:get("showRollOffWindow"));
    ShowRollOffWindowCheckbox:SetPoint("TOPLEFT", HideWishListsOfPeopleNotInraid, "BOTTOMLEFT", 0, -8);

    -- Do you want this addon to operate quietly? Aka no sounds when auction starts/ends etc?
    local MuteAddonCheckbox = UI:createSettingCheckbox(
        Frame,
        "Mute addon",
        "Checking this will make sure that the addon will not play ANY sounds (auction start/end for example)",
        function (_, checked)
            self:set("muted", checked);
        end
    );
    MuteAddonCheckbox:SetChecked(self:get("muted"));
    MuteAddonCheckbox:SetPoint("TOPLEFT", ShowRollOffWindowCheckbox, "BOTTOMLEFT", 0, -8);

    -- Enable debug mode
    local EnableDebugModeCheckbox = UI:createSettingCheckbox(
        Frame,
        "Enable debug mode",
        "Checking this will enable debug mode, showing debug info in your chatbox",
        function (_, checked)
            self:set("debugModeEnabled", checked);
        end
    );
    EnableDebugModeCheckbox:SetChecked(self:get("debugModeEnabled"));
    EnableDebugModeCheckbox:SetPoint("TOPLEFT", MuteAddonCheckbox, "BOTTOMLEFT", 0, -8);

    -- This is the "PackMule" button that opens the PackMule settings
    local PackMuleSettings = CreateFrame("Button", nil, Frame, "UIPanelButtonTemplate");
    PackMuleSettings:SetText("PackMule");
    PackMuleSettings:SetWidth(177);
    PackMuleSettings:SetHeight(24);
    PackMuleSettings:SetPoint("TOPLEFT", EnableDebugModeCheckbox, "BOTTOMLEFT", -2, -16);
    PackMuleSettings:SetScript("OnClick", function()
        App.Commands.packmule();
        InterfaceOptionsFrame_Show();
    end);

    -- This is the "Reset to defaults" button that resets all settings
    local ResetToDefaultSettings = CreateFrame("Button", nil, Frame, "UIPanelButtonTemplate");
    ResetToDefaultSettings:SetText("Reset to defaults");
    ResetToDefaultSettings:SetWidth(177);
    ResetToDefaultSettings:SetHeight(24);
    ResetToDefaultSettings:SetPoint("TOPLEFT", PackMuleSettings, "BOTTOMLEFT", -2, -16);
    ResetToDefaultSettings:SetScript("OnClick", function()
        StaticPopup_Show(App.name .. "_RESET_TO_DEFAULTS_CONFIRMATION");
    end);

    Frame:SetScript("OnShow", nil);
end

-- Get a setting by a given key. Use dot notation to traverse multiple levels e.g:
-- Settings.UI.Auctioneer.offsetX can be fetched using Settings:get("Settings.UI.Auctioneer.offsetX")
-- without having to worry about tables or keys existing yes or no.
function Settings:get(keyString, default)
    return Utils:tableGet(self.Active, keyString, default);
end

-- Set a setting by a given key and value. Use dot notation to traverse multiple levels e.g:
-- Settings.UI.Auctioneer.offsetX can be set using Settings:set("Settings.UI.Auctioneer.offsetX", myValue)
-- without having to worry about tables or keys existing yes or no.
function Settings:set(keyString, value)
    return Utils:tableSet(self.Active, keyString, value);
end

Utils:debug("Settings.lua");