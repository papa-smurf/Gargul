---@type GL
local _, GL = ...;

local fontSize;

--- LUA supports tostring, tonumber etc but no toboolean, let's fix that!
---@param var any
---@return boolean
function GL:toboolean(var)
    return not GL:empty(var);
end

--- Similar to math.floor, but rounds down to a given number of decimals
---
---@param var number
---@param precision number
---@return number
---@test /dump _G.Gargul:floor(2.232323, 2);
function GL:floor(var, precision)
    var = tonumber(var);

    if (not var) then
        return 0;
    end

    if (not precision or precision == 0) then
        return math.floor(var);
    end

    return tonumber(strsub(("%." .. precision + 1 .. "f"):format(var), 1, -2));
end

---@param var number
---@param precision number
---@return number
---@test /dump _G.Gargul:round(10.2225, 3);
function GL:round(var, precision)
    var = tonumber(var);

    if (not var) then
        return 0;
    end

    if (precision and precision > 0) then
        local mult = 10^ precision;
        return math.floor(var * mult + .5) / mult;
    end

    return math.floor(var + .5);
end

--- Check whether a given variable is a number that's higher than zero
---
---@param numericValue number
---@return boolean
function GL:higherThanZero(numericValue)
    return type(numericValue) == "number"
        and numericValue > 0
end

--- Check if a reference and control are equal. Case insensitive, and whitespaces are trimmed
---
---@param reference string
---@param control string
---@return boolean
function GL:iEquals(reference, control)
    if (type(reference) ~= "string"
        or type(control) ~= "string"
    ) then
        return false
    end

    return strlower(strtrim(reference)) == strlower(strtrim(control));
end

---@param numberA number
---@param numberB number
---
---@return boolean
function GL:lt(numberA, numberB)
    return tonumber(tostring(numberA)) < tonumber(tostring(numberB));
end

---@param numberA number
---@param numberB number
---
---@return boolean
function GL:lte(numberA, numberB)
    return tonumber(tostring(numberA)) <= tonumber(tostring(numberB));
end

---@param numberA number
---@param numberB number
---
---@return boolean
function GL:gt(numberA, numberB)
    return tonumber(tostring(numberA)) > tonumber(tostring(numberB));
end

---@param numberA number
---@param numberB number
---
---@return boolean
function GL:gte(numberA, numberB)
    return tonumber(tostring(numberA)) >= tonumber(tostring(numberB));
end

---@param numberA number
---@param numberB number
---
---@return boolean
function GL:e(numberA, numberB)
    return tonumber(tostring(numberA)) == tonumber(tostring(numberB));
end

--- Generate a random (enough) uuid
---
---@return string
function GL:uuid()
    local random = math.random;
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx";

    return string.gsub(template, "[xy]", function (c)
        local v = (c == "x") and random(0, 0xf) or random(8, 0xb);
        return ("%x"):format(v);
    end)
end

--- rem stands for "root em", a unit of measurement that represents the font size of the root element
--- In our case that equals GL.Settings:get("fontSize") which defaults to 11
---
--- This means that rem(1) returns the default font size, whereas rem(.75) returns 8
---
---@param scale number
---@return number
function GL:rem(scale)
    scale = scale or 1;
    fontSize = fontSize or GL.Settings:get("fontSize");

    return scale == 1 and fontSize or self:round(fontSize * scale);
end

--- Check to see how much the font size changed based on the default of 11
---
---@return number
function GL:remOffset()
    return GL:rem() - 11;
end

--- Transform seconds to a human readable format e.g: 01:44:23
---@param seconds number
---@return string
function GL:secondsToReadable(seconds)
    local timeFormat1 = "%d:%02d:%02d"
    local timeFormat2 = "%d:%02d"
    local timeFormat3 = "%.1f"
    local timeFormat4 = "%.0f"
    local timeString;

    if (seconds > 3599.9) then -- > 1 hour
        local h = floor(seconds /3600);
        local m = floor((seconds - (h*3600))/60);
        local s = (seconds - (m*60)) - (h*3600);
        timeString = (timeFormat1):format(h, m, s);
    elseif (seconds > 59.9) then -- 1 minute to 1 hour
        local m = floor(seconds /60);
        local s = seconds - (m*60);
        timeString = (timeFormat2):format(m, s);
    elseif (seconds < 10) then -- 0 to 10 seconds
        timeString = (timeFormat3):format(seconds);
    else -- 10 seconds to one minute
        timeString = (timeFormat4):format(seconds);
    end

    return timeString;
end

--- Perform a given function when or after the user is out of combat
---
---@return any
function GL:afterCombatDo(func, whenInCombatFunc)
    if (not UnitAffectingCombat("player")) then
        return func();
    end

    if (whenInCombatFunc) then
        whenInCombatFunc();
    end

    local eventID = "afterCombat" .. self:uuid() .. GetTime() .. math.random(1, 1000);
    self.Events:register(eventID, "PLAYER_REGEN_ENABLED", function ()
        GL.Events:unregister(eventID);
        return func();
    end);
end

---@param constant string
---@param messageID number
---@return boolean
--- Era test: /script print(_G.Gargul:isGameMessageID("ERR_LOOT_CANT_LOOT_THAT_NOW", 571));
--- WotLK test: /script print(_G.Gargul:isGameMessageID("ERR_LOOT_CANT_LOOT_THAT_NOW", 579));
--- Retail test: /script print(_G.Gargul:isGameMessageID("ERR_LOOT_CANT_LOOT_THAT_NOW", 604));
function GL:isGameMessageID(constant, messageID)
    GL:debug("GL:isGameMessageID");

    if (type(constant) ~= "string"
        or GL:empty(constant)
    ) then
        return false;
    end

    local constantID = GL.DB:get(("Utility.GameMessageIDs.%s.%s"):format(
        GL.tocVersion,
        constant
    ));

    -- We haven't seen this ID yet, let's scan it!
    if (not constantID) then
        local i = 1;
        while(true) do
            local identifier = GetGameMessageInfo(i);

            if (not identifier) then
                break;
            end

            if (constant == identifier) then
                GL.DB:set(("Utility.GameMessageIDs.%s.%s"):format(
                    GL.tocVersion,
                    constant
                ), i);

                constantID = i;
                break;
            end

            i = i + 1;
        end
    end

    -- Seems like this constant simply doesn't exist
    if (constantID == nil) then
        GL.DB:set(("Utility.GameMessageIDs.%s.%s"):format(
            GL.tocVersion,
            constant
        ), -1);
    end

    return constantID == messageID;
end

--- Dump a variable (functions won't work!)
---
---@param mixed any
function GL:dump(mixed)
    local success, encoded = pcall(function () return GL.JSON:encode(mixed); end);

    if (not success) then
        GL:error("Unable to encode payload provided in GL:dump");
        return;
    end

    GL:message(encoded);
end

--- Dump all global names for API availability tracking.
--- Run /gl dumpglobals in each client, copy output, save to Data/APIAvailability/dumps/ClientName_tocVersion.json
function GL:dumpGlobals()
    local tocVersion = select(4, GetBuildInfo());
    local build = select(2, GetBuildInfo());

    local globals = {};
    for k in pairs(_G) do
        if (type(k) == "string") then
            table.insert(globals, k);
        end
    end
    table.sort(globals);

    -- Recursively collect Enum.* paths when Enum exists
    local enumPaths = {};
    if (_G.Enum and type(_G.Enum) == "table") then
        local function collect(t, prefix)
            for k, v in pairs(t) do
                if (type(k) == "string") then
                    local path = prefix and (prefix .. "." .. k) or ("Enum." .. k);
                    if (type(v) == "table" and v ~= _G) then
                        collect(v, path);
                    else
                        table.insert(enumPaths, path);
                    end
                end
            end
        end;
        collect(_G.Enum, "Enum");
        table.sort(enumPaths);
    end

    local payload = {
        tocVersion = tocVersion,
        build = build,
        globals = globals,
        enumPaths = enumPaths,
    };

    self:frameMessage(GL.JSON:encode(payload));
end

function GL:bugReport()
    local AddonData = {};
    for i = 1, GL.GetNumAddOns() do
        local name = GL.GetAddOnInfo(i);
        local version = GL.GetAddOnMetadata(i, "Version");
        local loaded = GL.GetAddOnEnableState(GL.User.name, name) == 2;

        AddonData[name] = { version, loaded, };
    end

    local oldestTimestamp = (function ()
        local now = GetServerTime();
        local oldest = now;

        local brUpdatedAt = GL.DB:get("BoostedRolls.MetaData.updatedAt", now);
        local brImportedAt = GL.DB:get("BoostedRolls.MetaData.importedAt", now);
        local poUpdatedAt = GL.DB:get("PlusOnes.MetaData.updatedAt", now);
        local srImportedAt = GL.DB:get("SoftRes.MetaData.importedAt", now);
        local tmbImportedAt = GL.DB:get("TMB.MetaData.importedAt", now);

        oldest = brUpdatedAt < oldest and brUpdatedAt or oldest;
        oldest = brImportedAt < oldest and brImportedAt or oldest;
        oldest = poUpdatedAt < oldest and poUpdatedAt or oldest;
        oldest = srImportedAt < oldest and srImportedAt or oldest;
        oldest = tmbImportedAt < oldest and tmbImportedAt or oldest;

        -- Awarded items and rolls
        for _, Details in pairs(GL.DB:get("AwardHistory") or {}) do
            for _, Roll in pairs(Details.Rolls or {}) do
                if (Roll.time and Roll.time < oldest) then
                    oldest = Roll.time;
                end
            end

            if (Details.timestamp < oldest) then
                oldest = Details.timestamp;
            end
        end

        -- GDKP Session, auctions, states and gold
        for _, Session in pairs(GL.DB:get("GDKP.Ledger") or {}) do
            for _, Auction in pairs(Session.Auctions or {}) do
                if (Auction.createdAt and Auction.createdAt < oldest) then
                    oldest = Auction.createdAt;
                end

                for _, State in pairs(Auction.PreviousStates or {}) do
                    if (State.createdAt and State.createdAt < oldest) then
                        oldest = State.createdAt;
                    end
                end
            end

            for _, Player in pairs(Session.GoldLedger or {}) do
                for _, Details in pairs(Player or {}) do
                    if (Details.createdAt and Details.createdAt < oldest) then
                        oldest = Details.createdAt;
                    end
                end
            end

            if (Session.createdAt < oldest) then
                oldest = Session.createdAt;
            end
        end

        return oldest;
    end)();

    local Settings = GL.Settings:all();
    Settings.UI = nil;

    local Payload = {
        AddonData = AddonData,
        LoadDetails = GL.DB.LoadDetails,
        Settings = Settings,
        ScriptErrors = C_CVar.GetCVar("scriptErrors"),
        client = GL.clientUIinterface,
        dataSince = oldestTimestamp,
        guid = GL.User.id,
        name = GL.User.name,
        realm = GL.User.realm,
    };

    local LibDeflate = LibStub:GetLibrary("LibDeflate");
    local zlibEncodeSucceeded;
    local data = GL.JSON:encode(Payload);
    zlibEncodeSucceeded, data = pcall(function () return LibDeflate:CompressZlib(data); end);
    data = GL.Base64.encode(data);

    self:frameMessage(data);
end

--- Remove a lib-st table's scrollbar
---
---@param Table table
function GL:LibStRemoveScrollBar(Table)
    local tableName = Table.frame:GetName();

    if (_G[tableName .. "ScrollFrameScrollBar"]) then
        _G[tableName .. "ScrollFrameScrollBar"]:Hide();
    end

    if (_G[tableName .. "ScrollTrough"]) then
        _G[tableName .. "ScrollTrough"]:Hide();
    end
end

function GL.LibStImageButtonCellUpdate (rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
    local path = data[realrow].cols[column].value

    if (path) then
        local tooltip = data[realrow].cols[column]._tooltip;
        frame:SetNormalTexture(path);
        frame:SetHighlightTexture(path);
        frame:Show();
        frame:SetScript("OnEnter", function()
            GameTooltip:SetOwner(frame, "ANCHOR_TOP")
            GameTooltip:AddDoubleLine(tooltip);
            GameTooltip:Show();
        end)

        frame:SetScript("OnLeave", function() GameTooltip:Hide() end);
    else
        frame:Hide();
    end

    local callback = data[realrow].cols[column]._OnClick;
    if (type(callback) == "function") then
        frame:SetScript("OnClick", function(self, event, ...)
            if (type(event) ~= "string"
                or not GL:inTable({ "LeftButton", "RightButton", "MiddleButton", "Button4", "Button5", }, event)
            ) then
                return;
            end

            callback(self, event, ...);
        end);
    end
end

function GL.LibStButtonCellUpdate (rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
    local buttonText = data[realrow].cols[column].value

    local buttonName = "GARGUL_" .. GL:uuid() .. GetTime();
    local Button = CreateFrame("Button", buttonName, frame, "UIPanelButtonTemplate");
    Button:SetText(buttonText);
    Button:SetSize(frame:GetWidth() - 6, frame:GetHeight() - 2);
    Button:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);

    local callback = data[realrow].cols[column]._OnClick;
    if (type(callback) == "function") then
        Button:SetScript("OnClick", function(self, event, ...)
            if (type(event) ~= "string"
                    or not GL:inTable({ "LeftButton", "RightButton", "MiddleButton", "Button4", "Button5", }, event)
            ) then
                return;
            end

            callback(self, event, ...);
        end);
    end

    -- Properly clean up the button after hiding it
    local originalOnHide = frame:GetScript("OnHide");
    frame:SetScript("OnHide", function (...)
        if (Button and Button.Hide) then
            Button:Hide();
        end

        Button = nil;
        _G[buttonName] = nil;

        frame.children = nil;
        if (type(originalOnHide) == "function") then
            originalOnHide(...);
        end
    end);
end

function GL.LibStInputCellUpdate (rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
    local inputName = "GARGUL_" .. GL:uuid() .. GetTime();
    local BidInput = CreateFrame("EditBox", inputName, frame, "InputBoxTemplate");
    BidInput:SetSize(frame:GetWidth() - 6, frame:GetHeight() - 2);
    BidInput:SetPoint("TOPLEFT", frame, "TOPLEFT", 0, 0);
    BidInput:SetAutoFocus(false);

    local default = data[realrow].cols[column]._default;
    if (default) then
        BidInput:SetText(default);
    end

    local callback = data[realrow].cols[column]._OnTextChanged;
    if (type(callback) == "function") then
        BidInput:SetScript("OnTextChanged", function()
            callback(BidInput);
        end);
    end

    -- Properly clean up the editbox after hiding it
    local originalOnHide = frame:GetScript("OnHide");
    frame:SetScript("OnHide", function (...)
        if (BidInput and BidInput.Hide) then
            BidInput:SetText("");
            BidInput:Hide();
            BidInput:SetParent(nil);
            BidInput:ClearAllPoints()
            BidInput.OnEvent = function() end;
        end

        _G[inputName] = nil;
        BidInput = nil;

        frame.children = nil;
        if (type(originalOnHide) == "function") then
            originalOnHide(...);
        end
    end);
end

--- Clears the provided scrolling table (lib-ScrollingTable)
---
---@param ScrollingTable table
function GL:clearScrollTable(ScrollingTable)
    if (type(ScrollingTable) ~= "table") then
        return;
    end

    ScrollingTable:SetData({}, true);
    ScrollingTable.frame:Hide();
    ScrollingTable:Hide();
    ScrollingTable.frame = nil;
    ScrollingTable = nil;
end

--- In some very rare cases we need to manipulate the close button on AceGUI elements
---
---@param Widget table
---@return table?
function GL:fetchCloseButtonFromAceGUIWidget(Widget)
    GL:debug("GL:fetchCloseButtonFromAceGUIWidget");

    if (not Widget or not Widget.frame) then
        return;
    end

    -- Try to locate the Close button and hide it
    for _, Child in pairs({ Widget.frame:GetChildren() }) do
        if (Child.GetText and Child:GetText() == CLOSE) then
            return Child;
        end
    end
end

--- In some very rare cases we need to manipulate the border on AceGUI Inline Group elements
---
---@param Widget table
---@return table?
function GL:fetchBorderFromAceGUIInlineGroup(Widget)
    GL:debug("GL:fetchBorderFromAceGUIInlineGroup");

    if (not Widget or not Widget.frame) then
        return;
    end

    -- Try to locate the Close button and hide it
    for _, Child in pairs({ Widget.frame:GetChildren() }) do
        if (Child.SetBackdropColor) then
            return Child;
        end
    end
end

---@param callback function
function GL:forEachGroupMember(callback)
    for _, Member in pairs(GL.User:groupMembers() or {}) do
        callback(Member);
    end
end

--- Check if the given player is online
---
---@param player string
---@return boolean
function GL:unitIsConnected(player)
    local FQN = self:addRealm(player);
    local player, realm = self:stripRealm(FQN);

    if (self:iEquals(realm, GL.User.realm)) then
        return UnitIsConnected(player);
    end

    return UnitIsConnected(FQN);
end

--- Play a sound
---
---@param soundNameOrNumber string
---@param channel string
function GL:playSound(soundNameOrNumber, channel, forceNoDuplicates, runFinishCallback)
    -- Check if the user muted the addon
    if (GL.Settings:get("noSounds")) then
        return;
    end

    if (type(channel) ~= "string"
        or GL:empty(channel)
    ) then
        channel = GL.Settings:get("soundChannel", "SFX");
    end

    local normalizedName = strtrim(strlower(tostring(soundNameOrNumber)));
    normalizedName = string.gsub(normalizedName, "\\", "/");
    pcall(function ()
        if (GL:strContains(normalizedName, "interface/addons") or normalizedName == "none") then
            PlaySoundFile(soundNameOrNumber, channel);
        else
            PlaySound(soundNameOrNumber, channel, forceNoDuplicates, runFinishCallback);
        end
    end);
end

--- Pad a string to a certain length with another string (left side)
---
---@param str string
---@param padChar string
---@param length number
---@return string
function GL:strPadLeft(str, padChar, length)
    return strrep(padChar, length - GL:count(str)) .. str;
end

--- Pad a string to a certain length with another string (right side)
---
---@param str string
---@param padChar string
---@param length number
---@return string
function GL:strPadRight(str, padChar, length)
    return str .. strrep(padChar, length - GL:count(str));
end

--- Stop the highlighting of an item frame
---
---@param ItemFrame Frame
function GL:stopHighlight(ItemFrame)
    pcall(function() LCG.PixelGlow_Stop(ItemFrame); end);
end

--- Hook into tooltip events for items
---
---@param Callback function
---@param includeItemRefTooltip? boolean
function GL:onTooltipSetItem(Callback, includeItemRefTooltip)
    includeItemRefTooltip = includeItemRefTooltip ~= false;
    includeItemRefTooltip = GL:toboolean(includeItemRefTooltip);

    -- Support native GameToolTip
    if (C_TooltipInfo and TooltipDataProcessor) then
        return TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, function (Tooltip)
            return Callback(Tooltip);
        end);
    end

    GameTooltip:HookScript("OnTooltipSetItem", function(Tooltip)
        return Callback(Tooltip);
    end);

    -- Support AceConfigDialog
    LibStub("AceConfigDialog-3.0").tooltip:HookScript("OnTooltipSetItem", Callback);

    if (includeItemRefTooltip) then
        ItemRefTooltip:HookScript("OnTooltipSetItem", function(Tooltip)
            return Callback(Tooltip);
        end);
    end
end
