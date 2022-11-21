--[[
    This class handles the addon's default and user settings

    The default settings are overwritten with the user's settings
    after the addon is loaded

    The showSettingsMenu function is responsible for showing the
    settings in the WoW settings menu
]]

---@type GL
local _, GL = ...;

---@class Settings
GL.Settings = {
    _initialized = false,
    Defaults = GL.Data.DefaultSettings,
    Active = {}, -- This object holds the actual setting values applicable to this runtime
};

local Settings = GL.Settings; ---@type Settings

---@return void
function Settings:_init()
    GL:debug("Settings:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- Validate the settings and adjust discrepancies
    self:sanitizeSettings();

    -- Combine defaults and user settings
    self:overrideDefaultsWithUserSettings();

    -- Prepare the options / config frame
    local Frame = CreateFrame("Frame", nil, InterfaceOptionsFramePanelContainer);
    Frame.name = "Gargul";
    Frame:SetScript("OnShow", function ()
        self:showSettingsMenu(Frame);
    end);
    InterfaceOptions_AddCategory(Frame);

    self._initialized = true;
end

--- Make sure the settings adhere to our rules
---
---@return void
function Settings:sanitizeSettings()
    GL:debug("Settings:sanitizeSettings");

    self:enforceTemporarySettings();

    -- Remove old roll data so it doesn't clog our SavedVariables
    local twoWeeksAgo = GetServerTime() - 1209600;
    for key, Award in pairs(GL.DB.AwardHistory) do
        if (Award.timestamp < twoWeeksAgo) then
            GL.DB.AwardHistory[key] = nil;
            Award = nil;
        end
    end

    -- Permanently delete soft-deleted GDKP sessions after 48 hours
    local twoDaysAgo = GetServerTime() - 172800;
    for key, Session in pairs(GL.DB.GDKP) do
        if (Session.deletedAt and Session.deletedAt < twoDaysAgo) then
            GL.DB.GDKP[key] = nil;
        end
    end
end

--- These settings are version-specific and will be removed over time!
---
---@return void
function Settings:enforceTemporarySettings()
    GL:debug("Settings:enforceTemporarySettings");

    -- This is reserved for version-based logic (e.g. cleaning up variables, settings etc.)

    -- No point enforcing these temp settings if the user has never used Gargul
    -- before or has already loaded this version before!
    if (GL.firstBoot
        or not GL.Version.firstBoot
    ) then
        return;
    end

    --- In 4.12.1 we added a concernsOS and givesPlusOne checkbox field to the roll tracking settings
    for key, RollType in pairs(GL.Settings:get("RollTracking.Brackets", {})) do
        if (RollType[5] == nil) then
            GL.DB.RollTracking.Brackets[key][5] = RollType[1] == "OS";
            GL.DB.RollTracking.Brackets[key][6] = false;
        end
    end

    --- In 4.12.0 we completely rewrote the awarded item structure
    --- If the user is now on 4.12.0 or has not used 4.12.0 then we restructure the awarded items
    ---@todo: remove if award history structure ever changes again
    if (GL.version == "4.12.0" or (
        not GL.firstBoot and not GL.DB.LoadDetails["4.12.0"])
    ) then
        GL:notice("Rewriting Gargul's award history, this could drops FPS for a second or two!");
        GL.DB.LoadDetails["4.12.0"] = GetServerTime();

        local AwardHistory = {};
        for _, AwardEntry in pairs(GL.DB.AwardHistory) do
            (function ()
                local itemIDfromItemLink = GL:getItemIDFromLink(AwardEntry.itemLink);

                -- We can't work with this record
                if (not AwardEntry.awardedTo or (
                    not AwardEntry.itemId and not itemIDfromItemLink
                )) then
                    return;
                elseif (not AwardEntry.itemId) then
                    AwardEntry.itemId = itemIDfromItemLink;
                end

                -- Make sure we always have a timestamp
                if (not AwardEntry.timestamp) then
                    AwardEntry.timestamp = AwardEntry.awardedOn;
                end

                if (not GL:higherThanZero(AwardEntry.timestamp)) then
                    AwardEntry.timestamp = 0;
                end

                -- Make sure we always have a checksum
                if (GL:empty(AwardEntry.checksum)) then
                    AwardEntry.checksum = GL:strPadRight(GL:strLimit(GL:stringHash(AwardEntry.timestamp .. AwardEntry.itemId) .. GL:stringHash(AwardEntry.awardedTo .. GL.DB:get("SoftRes.MetaData.id", "")), 20, ""), "0", 20);
                end

                local addEntryToTable = function (Entry)
                    AwardHistory[Entry.checksum] = {
                        checksum = Entry.checksum,
                        itemLink = Entry.itemLink,
                        itemID = Entry.itemId,
                        awardedTo = Entry.awardedTo,
                        timestamp = Entry.timestamp,
                        softresID = Entry.softresID,
                        received = Entry.received or false,
                        BRCost = Entry.BRCost or 0,
                        GDKPCost = Entry.BRCost or 0,
                        OS = GL:toboolean(Entry.OS),
                        Rolls = Entry.Rolls or {},
                    };
                end;

                -- We have all we need, process the entry now
                if (AwardEntry.itemLink and GL:getItemIDFromLink(AwardEntry.itemLink)) then
                    addEntryToTable(AwardEntry);

                -- We need to fetch the itemLink first before we can process
                else
                    GL:onItemLoadDo(AwardEntry.itemId, function (Items)
                        local Item = Items[1];

                        -- Better safe than lua error!
                        if (GL:empty(Item.link)) then
                            return;
                        end

                        AwardEntry.itemLink = Item.link;

                        addEntryToTable(AwardEntry);
                    end);
                end
            end)();
        end

        GL.DB.AwardHistory = AwardHistory;

        GL:notice("All done!");
    end

    ---@todo: remove >= 07-11-2022
    --- Right click shortcut keys are no longer supported
    local headerSent = false;
    for _, setting in pairs({"award", "disenchant", "rollOff"}) do
        if (string.find(GL.DB.Settings.ShortcutKeys[setting], "RIGHTCLICK")) then
            if (not headerSent) then
                GL:warning("Some Gargul shortcut keys have changed, more info below");
                headerSent = true;
            end

            local oldShortcutKey = GL.DB.Settings.ShortcutKeys[setting];
            local newShortcutKey = GL.DB.Settings.ShortcutKeys[setting]:gsub("RIGHTCLICK", "CLICK");
            GL.DB.Settings.ShortcutKeys[setting] = newShortcutKey;

            GL:message(string.format("|c00FFF569%s|r was changed from |c00FFF569%s|r to |c00FFF569%s|r",
                GL:capitalize(setting),
                oldShortcutKey,
                newShortcutKey
            ));
        end
    end
end

--- Draw a setting section
---
---@param section string|nil
---@return void
function Settings:draw(section)
    GL.Interface.Settings.Overview:draw(section);
end

---@return void
function Settings:close()
    GL.Interface.Settings.Overview:close();
end

--- Reset the addon to its default settings
---
---@return void
function Settings:resetToDefault()
    GL:debug("Settings:resetToDefault");

    self.Active = {};
    GL.DB.Settings = {};

    -- Combine defaults and user settings
    self:overrideDefaultsWithUserSettings();
end

--- Override the addon's default settings with the user's custom settings
---
---@return void
function Settings:overrideDefaultsWithUserSettings()
    GL:debug("Settings:overrideDefaultsWithUserSettings");

    -- Reset the currently active settings table
    self.Active = {};

    -- Combine the default and user's settings to one settings table
    Settings = GL:tableMerge(Settings.Defaults, GL.DB.Settings);

    -- Set the values of the settings table directly on the GL.Settings table.
    for key, value in pairs(Settings) do
        self.Active[key] = value;
    end

    GL.DB.Settings = self.Active;
end

--- We use this method to make sure that the interface is only built
--- when the user has actually accessed the settings menu, which doesn't happen every session
---
---@return void
function Settings:showSettingsMenu(Frame)
    GL:debug("Settings:showSettingsMenu");

    -- Add the addon title to the top of the settings frame
    local Title = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    Title:SetPoint("TOPLEFT", 16, -16);
    Title:SetText("Gargul");

    -- This is the "PackMule" button that opens the PackMule settings
    local SettingsButton = CreateFrame("Button", nil, Frame, "UIPanelButtonTemplate");
    SettingsButton:SetText("Settings");
    SettingsButton:SetWidth(177);
    SettingsButton:SetHeight(24);
    SettingsButton:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -8);
    SettingsButton:SetScript("OnClick", function()
        -- Make sure the vanilla interface options are closed and don't reopen automatically
        HideUIPanel(InterfaceOptionsFrame);
        HideUIPanel(GameMenuFrame);

        self:draw();
    end);
end

--- Get a setting by a given key. Use dot notation to traverse multiple levels e.g:
--- Settings.UI.Auctioneer.offsetX can be fetched using Settings:get("Settings.UI.Auctioneer.offsetX")
--- without having to worry about tables or keys existing yes or no.
---
---@param keyString string
---@param default any
---@return any
function Settings:get(keyString, default)
    -- Just in case something went wrong with merging the default settings
    if (type(default) == "nil") then
        default = GL:tableGet(GL.Data.DefaultSettings, keyString);
    end

    return GL:tableGet(self.Active, keyString, default);
end

--- Set a setting by a given key and value. Use dot notation to traverse multiple levels e.g:
--- Settings.UI.Auctioneer.offsetX can be set using Settings:set("Settings.UI.Auctioneer.offsetX", myValue)
--- without having to worry about tables or keys existing yes or no.
---
---@param keyString string
---@param value any
---@return void
function Settings:set(keyString, value)
    return GL:tableSet(self.Active, keyString, value);
end

GL:debug("Settings.lua");