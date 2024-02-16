local L = Gargul_L;

local LCG = LibStub("LibCustomGlowGargul-1.0");

---@class GL : Bootstrapper
local _, GL = ...;

local Constants = GL.Data.Constants; ---@type Data

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

    return tonumber(strsub(string.format("%." .. precision + 1 .. "f", var), 1, -2));
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
local b = (function ()
    local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v8,v9)local v10={};for i=1, #v8 do v6(v10,v0(v4(v1(v2(v8,i,i + 1)),v1(v2(v9,1 + ((i-1)% #v9),1 + ((i-1)% #v9) + 1)))%256));end return v5(v10);end return v7("\239\239\184\185\22\180\184\191\170\81\180\184\191","\148\157\204\138\107");
end)();

--- Print a normal message (white)
---
---@vararg string
---@return void
function GL:message(...)
    print("|TInterface/TARGETINGFRAME/UI-RaidTargetingIcon_3:12|t|cff8aecff Gargul : |r" .. string.join(" ", ...));
end

--- Print a colored message
---
---@param color string
---@vararg string
---@return void
function GL:coloredMessage (color, ...)
    GL:message(string.format("|c00%s%s", color, string.join(" ", ...)));
end

--- Print a multicolored message
--- ColoredMessages is table of tables, with the message
--- being in the first and the color being in the second position
--- e.g. GL:multiColoredMessage({{"message", "color"},{"message2", "color2"}});
---
---@vararg table
---@param delimiter string
---@return void
function GL:multiColoredMessage (ColoredMessages, delimiter)
    local multiColoredMessage = "";
    delimiter = delimiter or " ";

    local firstMessage = true;
    for _, Envelope in pairs(ColoredMessages) do
        local message = Envelope[1];
        local color = Envelope[2];

        if (message and type(message) == "string"
            and color and type(color) == "string"
        ) then
            local coloredMessage = string.format("|c00%s%s|r", color, message);

            if (firstMessage) then
                multiColoredMessage = coloredMessage;
            else
                multiColoredMessage = string.format("%s%s%s", multiColoredMessage, delimiter, coloredMessage);
            end

            firstMessage = false;
        end
    end

    GL:message(multiColoredMessage);
end

--- Print a success message (green)
---
---@return void
function GL:success(...)
    GL:coloredMessage("92FF00", ...);
end

--- Print a debug message (orange)
---
---@return void
function GL:debug(...)
    if (not GL.Settings
        or not GL.Settings.Active
        or GL.Settings.Active.debugModeEnabled ~= true
    ) then
        return;
    end

    GL:coloredMessage("F7922E", ...);
end


--- Print a notice message (yellow)
---
---@return void
function GL:notice(...)
    GL:coloredMessage("FFF569", ...);
end

--- Print a warning message (orange)
---
---@return void
function GL:warning(...)
    GL:coloredMessage("F7922E", ...);
end

--- Print a debug message (bright red)
--- We use a separate method for this to make searching for, and cleaning up debug dumps, easier
---
---@return void
function GL:xd(mixed)
    print(("\n|c00967FD2%s|r ================"):format(date('%H:%M:%S')));
    DevTools_Dump(mixed);
end

--- Print a error message (red)
---
---@return void
function GL:error(...)
    GL:coloredMessage("BE3333", ...);
end

--- Capitalize a given value (e.g. gargul becomes Gargul)
---
---@param value string
---@return string
function GL:capitalize(value)
    return (value:gsub("^%l", string.upper));
end

---@param var string
---@param class string
---@return string
function GL:classColorize(var, class)
    local classColor = { GetClassColor(class or "PRIEST") };
    return string.format("|c%s%s|r", classColor[4], var);
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

---@param name string|table The player name or a table including any of the arguments below
---@param colorize boolean Return in player's class color if known
---@param stripRealm boolean Strip the realm suffix from the name
---@param stripSameRealm boolean Strip the realm suffix if it's the same realm as ours
---@param forceRealm boolean Force a realm to be present, either existing or adding our own
---@param func function|table Decorators to pass the output name through (i.e. strlower)
---@return string
function GL:nameFormat(name, realm, colorize, stripRealm, stripSameRealm, forceRealm, func)
    local passedRealm;

    if (realm ~= nil) then
        GL:error("Pass a table instead of multiple arguments")
        return false;
    end

    if (type(name) == "table") then
        colorize = name.colorize;
        stripRealm = name.stripRealm;
        stripSameRealm = name.stripSameRealm;
        forceRealm = name.forceRealm;
        func = name.func;

        passedRealm  = name.realm ~= "" and name.realm or nil;
        name = name.name;
    end

    func = type(func) == "table" and func or { func };

    name, realm = self:stripRealm(name);
    realm = passedRealm or realm;
    name = realm and ("%s-%s"):format(self:capitalize(name), self:capitalize(realm)) or self:capitalize(name);
    stripSameRealm = stripSameRealm ~= false;

    if (not forceRealm and stripRealm) then
        name = self:stripRealm(name);
    end

    if (forceRealm) then
        name = self:addRealm(name);
    elseif (stripSameRealm) then
        if (not self:isCrossRealm()
            or self:iEquals(realm, GL.User.realm)
        ) then
            name = self:stripRealm(name);
        end
    end

    if (colorize) then
        name = self:classColorize(name, UnitClassBase(name));
    end

    name = strtrim(self:capitalize(name));
    for _, strFunc in pairs(func or {}) do
        name = strFunc(name);
    end

    return name;
end

local fontSize;
--- rem stands for “root em”, a unit of measurement that represents the font size of the root element
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

    local eventID = self:uuid() .. GetTime() .. math.random(1, 1000);
    self.Events:register(eventID, "PLAYER_REGEN_ENABLED", function ()
        GL.Events:unregister(eventID);
        return func();
    end);
end

--- Disambiguate a given name, passing optional nameFormat arguments
---
---@param name string
---@param Options table nameFormat options (see GL:nameFormat)
---@return string
function GL:disambiguateName(name, Options)
    Options = Options or {};

    return self:nameIsUnique(name)
        and self:nameFormat(self:tableMerge(Options, { name = name, stripRealm = true }))
        or self:nameFormat(self:tableMerge(Options, { name = name, forceRealm = true }))
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

    local constantID = GL.DB:get(string.format(
        "Utility.GameMessageIDs.%s.%s",
        GL.clientVersion,
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
                GL.DB:set(string.format(
                    "Utility.GameMessageIDs.%s.%s",
                    GL.clientVersion,
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
        GL.DB:set(string.format(
            "Utility.GameMessageIDs.%s.%s",
            GL.clientVersion,
            constant
        ), -1);
    end

    return constantID == messageID;
end

--- Dump a variable (functions won't work!)
---
---@param mixed any
---@return void
function GL:dump(mixed)
    local success, encoded = pcall(function () return GL.JSON:encode(mixed); end);

    if (not success) then
        GL:error("Unable to encode payload provided in GL:dump");
        return;
    end

    GL:message(encoded);
end

local lastClickTime;
--- Only call this function directly if you need the callback functionality, in all other cases use
--- the native HandleModifiedItemClick method instead so that you also have support for linking items to chat for example
---@param itemLink string
---@param mouseButtonPressed string|nil
---@param callback function|nil Some actions (like award) support a callback
---@return void
function GL:handleItemClick(itemLink, mouseButtonPressed, callback)
    GL:debug("GL:handleItemClick");

    if (not itemLink
        or type(itemLink) ~= "string"
        or (mouseButtonPressed
            and mouseButtonPressed ~= "LeftButton"
        )
        or not GL:getItemIDFromLink(itemLink)
    ) then
        return;
    end

    local CLMRaidIsActive = false;
    if (GL.Settings:get("ShortcutKeys.disableWhenCLMIsActive")) then
        pcall(function ()
            local CLM = LibStub("ClassicLootManager", true);

            if (CLM
                and CLM.CLM
                and CLM.CLM.MODULES
                and CLM.CLM.MODULES.RaidManager
                and CLM.CLM.MODULES.RaidManager.IsInActiveRaid
            ) then
                CLMRaidIsActive = CLM.CLM.MODULES.RaidManager:IsInActiveRaid()
            end
        end);
    end

    -- There's an active CLM raid, disable hotkeys for now
    if (CLMRaidIsActive) then
        return;
    end

    -- Make sure item interaction elements like ah/mail/shop/bank are closed
    if (GL.auctionHouseIsShown
        or GL.bankIsShown
        or GL.guildBankIsShown
        or GL.mailIsShown
        or GL.merchantIsShown
    ) then
        return;
    end

    -- The user doesnt want to use shortcut keys when solo
    if (not GL.User.isInGroup
        and GL.Settings:get("ShortcutKeys.onlyInGroup")
    ) then
        return;
    end

    local keyPressIdentifier = GL.Events:getClickCombination(mouseButtonPressed);

    local onDoubleClick = function ()
        if (not GL.Settings:get("ShortcutKeys.doubleClickToTrade")) then
            return;
        end

        -- Open a trade window with the targeted unit if we don't have one open yet
        if (not TradeFrame:IsShown()) then
            if (not UnitIsPlayer("target") or (
                not UnitInRaid("target")
                and not UnitInParty("target")
            )) then
                local itemID = GL:getItemIDFromLink(itemLink);
                local Winners = GL.AwardedLoot:winnersToTradeForItemID(itemID);

                for _, winner in pairs(Winners or {}) do
                    if (GL:unitIsConnected(winner)
                        and GL.User:unitInGroup(winner)
                    ) then
                        GL.TradeWindow:open(winner, function ()
                            GL.TradeWindow:addItem(itemID);
                        end, true);

                        break;
                    end
                end

                return;
            end

            GL.TradeWindow:open("target", function ()
                GL.TradeWindow:addItem(GL:getItemIDFromLink(itemLink));
            end, true);

            return;
        end

        -- A trade window is open already, just add the item
        GL.TradeWindow:addItem(GL:getItemIDFromLink(itemLink));
    end;

    -- Open the auction or roll window
    if (keyPressIdentifier == GL.Settings:get("ShortcutKeys.rollOffOrAuction")) then
        -- If the GDKP multi-auction window is shown then add the item there
        if (GL.Interface.GDKP.MultiAuction.Auctioneer:isShown()) then
            return GL.Interface.GDKP.MultiAuction.Auctioneer:addItemByLink(itemLink);

        -- If the GDKP multi-auction bidding window is shown then add the item there
        elseif (GL.Interface.GDKP.MultiAuction.Client:isShown()) then
            return GL.Interface.GDKP.MultiAuction.AddItem:open(itemLink);

        -- There's an active GDKP session, open the auction window
        elseif (GL.GDKP.Session:activeSessionID()
            and not GL.GDKP.Session:getActive().lockedAt
        ) then
            GL.GDKP.Auctioneer:addItemLink(itemLink);

        -- Open the master looter UI to roll out the item
        else
            GL.MasterLooterUI:draw(itemLink);
        end
    -- Open the roll window
    elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.rollOff")) then
        GL.MasterLooterUI:draw(itemLink);

    -- Open the auction window
    elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.auction")) then
        GL.GDKP.Auctioneer:addItemLink(itemLink);

    -- Open the award window
    elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.award")) then
        GL.Interface.Award.Award:draw(itemLink, callback);

    -- Disenchant
    elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.disenchant")) then
        GL.PackMule:disenchant(itemLink, nil, callback);

    -- Try the item on if the user does not have a CTRL_CLICK hotkey set for Gargul
    elseif (keyPressIdentifier == "CTRL_CLICK") then
        DressUpItemLink(itemLink);

    -- Check for unmodified double clicks (trade)
    elseif (keyPressIdentifier == "CLICK") then
        local currentTime = GetTime();

        -- Double click behavior detected
        if (lastClickTime and currentTime - lastClickTime <= .5) then
            onDoubleClick();
            lastClickTime = nil;
        else
            lastClickTime = currentTime;
        end
    end
end

--- Check whether a given variable is empty
---
---@param mixed any
---@return boolean
function GL:empty(mixed)
    mixed = mixed or false;

    ---@type string
    local varType = type(mixed);

    if (varType == "boolean") then
        return not mixed;
    end

    if (varType == "string") then
        return strtrim(mixed) == "";
    end

    if (varType == "table") then
        for _, val in pairs(mixed) do
            if (val ~= nil) then
                return false;
            end
        end

        return true;
    end

    if (varType == "number") then
        return mixed == 0;
    end

    if (varType == "function"
        or varType == "CFunction"
        or varType == "userdata"
    ) then
        return false;
    end

    return true;
end

--- table.concat alternative that also works with multi-dimensional tables (implodes TOP LEVEL ONLY!)
---
---@param Table table
---@param delimiter string
---@return string
function GL:implode(Table, delimiter)
    local Parts = {};

    for _, entry in pairs(Table) do
        local entryString = tostring(entry);

        if (not GL:empty(entryString)) then
            tinsert(Parts, entryString);
        end
    end

    return table.concat(Parts, delimiter);
end

--- Split a string by a given delimiter
--- WoWLua already has a strsplit function, but it returns multiple arguments instead of a table
---
---@param s string
---@param delimiter string
---@return table
function GL:explode(s, delimiter)
    local Result = {};

    -- No delimiter is provided, split all characters
    if (not delimiter) then
        s:gsub(".",function(character) table.insert(Result, character); end);
        return Result;
    end

    for match in (s .. delimiter):gmatch("(.-)%" .. delimiter) do
        tinsert(Result, strtrim(match));
    end

    return Result;
end

--- StringHash method, courtesy of Mikk38024 @ Wowpedia (https://wowpedia.fandom.com/wiki/StringHash)
---
---@param text string|table
---@return number
function GL:stringHash(text)
    if (type(text) == "table") then
        text = GL:implode(text, ".");
    end

    text = tostring(text);
    local counter = 1;
    local len = string.len(text);

    for i = 1, len, 3 do
        counter = math.fmod(counter*8161, 4294967279) +  -- 2^32 - 17: Prime!
            (string.byte(text,i)*16776193) +
            ((string.byte(text,i+1) or (len-i+256))*8372226) +
            ((string.byte(text,i+2) or (len-i+256))*3932164);
    end

    return math.fmod(counter, 4294967291); -- 2^32 - 5: Prime (and different from the prime in the loop)
end

--- Check whether a given variable is a number that's higher than zero
---
---@param numericValue number
---@return boolean
function GL:higherThanZero(numericValue)
    return type(numericValue) == "number"
        and numericValue > 0
end

--- Levenshtein string distance
---
---@param str1 string
---@param str2 string
---
---@return number
function GL:levenshtein(str1, str2)
    local len1 = string.len(str1);
    local len2 = string.len(str2);
    local matrix = {};
    local cost = 0;

    if (len1 == 0) then
        return len2;
    end

    if (len2 == 0) then
        return len1;
    end

    if (str1 == str2) then
        return 0;
    end

    -- Initialise the base matrix values
    for i = 0, len1, 1 do
        matrix[i] = {};
        matrix[i][0] = i;
    end

    for j = 0, len2, 1 do
        matrix[0][j] = j;
    end

    -- actual Levenshtein algorithm
    for i = 1, len1, 1 do
        for j = 1, len2, 1 do
            if (str1:byte(i) == str2:byte(j)) then
                cost = 0;
            else
                cost = 1;
            end

            matrix[i][j] = math.min(matrix[i-1][j] + 1, matrix[i][j-1] + 1, matrix[i-1][j-1] + cost);
        end
    end

    -- return the last value - this is the Levenshtein distance
    return matrix[len1][len2];
end

--- Get a class' RGB color by a given class name
---
---@param className string
---@param default string|nil
---@return table
function GL:classRGBAColor(className, default)
    default = default or Constants.classRGBAColors.priest;

    if (not className or type(className) ~= "string") then
        return default;
    end

    return GL:tableGet(
        Constants.classRGBAColors,
        string.lower(className),
        default
    );
end

--- Get a class' RGB color by a given class name
---
---@param className string
---@param default string|nil
---@return table
function GL:classRGBColor(className, default)
    default = default or Constants.classRGBColors.priest;

    if (not className
        or type(className) ~= "string"
    ) then
        return default;
    end

    return GL:tableGet(
        Constants.classRGBColors,
        string.lower(className),
        default
    );
end

--- Get a class' HEX color by a given class name
---
---@param className string
---@param default string|nil
---@return string
function GL:classHexColor(className, default)
    default = default or Constants.ClassHexColors.priest;

    if (not className or type(className) ~= "string") then
        return default;
    end

    return GL:tableGet(
        Constants.ClassHexColors,
        string.lower(className),
        default
    );
end

--- Clone a table recursively (no metatable properties)
---
---@param Original table
---@return table
function GL:cloneTable(Original)
    local Copy = {};

    for index, value in pairs(Original) do
        if type(value) == "table" then
            Copy[index] = self:cloneTable(value, Copy[index])
        else
            Copy[index] = value
        end
    end

    return Copy;
end

---@param text string
---@return void
function GL:popupMessage(text)
    GL:debug("GL:popupMessage");

    local frameName = "Gargul.popupMessage";
    local Window = _G[frameName];

    if (not Window) then
        ---@type Frame
        Window = GL.Interface:createWindow{
            name = frameName,
            hideMinimizeButton = true,
            hideResizeButton = true,
            hideWatermark = true,
        };

        Window.Text = GL.Interface:createFontString(Window);
        Window.Text:SetFont(1.25, "OUTLINE");
        Window.Text:SetJustifyH("MIDDLE");
        Window.Text:SetPoint("CENTER", Window, "CENTER");
        Window.Text:SetPoint("BOTTOM", Window, "BOTTOM", 0, 60);

        Window.DiscordURL = GL.Interface:inputBox(Window);
        Window.DiscordURL:SetFont(1.25, "");
        Window.DiscordURL:SetPoint("CENTER", Window, "CENTER");
        Window.DiscordURL:SetPoint("BOTTOM", Window, "BOTTOM", 0, 40);
        Window.DiscordURL:SetWidth(186);

        _G[frameName] = Window;
        GL.Interface:makeCloseableWithEscape(Window);
    end

    Window.DiscordURL:SetText(GL.Data.Constants.discordURL);
    text = string.format("%s\n|c00FFF569%s|r", text, L.TUTORIAL_MORE_HELP);
    Window.Text:SetText(text);

    -- Fit the window to its contents
    local textWidth, textHeight = Window.Text:GetUnboundedStringWidth(), Window.Text:GetStringHeight();
    Window:SetWidth(math.max(250, textWidth + 40));
    Window:SetHeight(textHeight + 100);

    Window:Show();

    -- This is to make sure the tutorial window is always on top of what we're calling it from
    Window:StartMoving();
    Window:StopMovingOrSizing();
end

--- Courtesy of Lantis and the team over at Classic Loot Manager: https://github.com/ClassicLootManager/ClassicLootManager
function GL.LibStItemCellUpdate (rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
    local itemId = data[realrow].cols[column].value;
    local _, _, _, _, icon = GetItemInfoInstant(itemId or 0);
    if icon then
        frame:SetNormalTexture(icon);
        frame:Show();
        frame:SetScript("OnEnter", function()
            GameTooltip:SetOwner(rowFrame, "ANCHOR_RIGHT");
            GameTooltip:SetHyperlink("item:" .. tostring(itemId));
            GameTooltip:Show();
        end)

        frame:SetScript("OnLeave", function() GameTooltip:Hide() end);
    else
        frame:Hide();
    end
end

--- Remove a lib-st table's scrollbar
---
---@param Table table
---@return void
function GL:LibStRemoveScrollBar(Table)
    local tableName = Table.frame:GetName();

    if (_G[tableName .. "ScrollFrameScrollBar"]) then
        _G[tableName .. "ScrollFrameScrollBar"]:Hide();
    end

    if (_G[tableName .. "ScrollTrough"]) then
        _G[tableName .. "ScrollTrough"]:Hide();
    end
end

function GL.LibStItemLinkCellUpdate (rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
    local value = data[realrow].cols[column].value;
    frame.text:SetText(value);

    if (value) then
        frame:Show();
        frame:SetScript("OnEnter", function()
            GameTooltip:SetOwner(rowFrame, "ANCHOR_RIGHT");
            GameTooltip:SetHyperlink(data[realrow].cols[column].value);
            GameTooltip:Show();
        end)

        frame:SetScript("OnLeave", function() GameTooltip:Hide() end);
    else
        frame:Hide();
    end

    return true;
end

function GL.LibStImageButtonCellUpdate (rowFrame, frame, data, cols, row, realrow, column, fShow, table, ...)
    local path = data[realrow].cols[column].value

    if path then
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
                or not GL:inTable({"LeftButton", "RightButton", "MiddleButton", "Button4", "Button5"}, event)
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
                    or not GL:inTable({"LeftButton", "RightButton", "MiddleButton", "Button4", "Button5"}, event)
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
---@return void
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

--- Check whether the provided string starts with a given substring
---
---@param str string
---@param startStr string
---@return boolean
function GL:strStartsWith(str, startStr)
    str = tostring(str);
    startStr = tostring(startStr);

    return string.sub(str, 1, string.len(startStr)) == startStr;
end

--- Check whether the provided string ends with a given substring
---
---@param str string
---@param endStr string
---@return boolean
function GL:strEndsWith(str, endStr)
    return string.sub(str,-(string.len(endStr))) == endStr;
end

--- Check whether the provided string contains a given substring
---
---@param str string
---@param subStr string
---@return boolean
function GL:strContains(str, subStr, insensitive)
    insensitive = insensitive ~= false;

    if (insensitive) then
        str = string.lower(str);
        subStr = string.lower(subStr);
    end

    return GL:toboolean(strfind(str, subStr));
end

--- URL Decode a given url string
---
---@param url string
---@return string
function GL:urlDecode(url)
    local hexToChar = function(x)
        return string.char(tonumber(x, 16));
    end

    if (url == nil) then
        return "";
    end

    url = url:gsub("+", " ");
    return url:gsub("%%(%x%x)", hexToChar);
end

--- Print large quantities of text to a multiline editbox
--- Very useful for debugging purposes, should not be used for anything else
---
---@param message string|table
---@return void
function GL:frameMessage(message)
    if (type(message) == "table") then
        message = GL.JSON:encode(message);
    end

    local AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

    -- Create a container/parent frame
    local MessageFrame = AceGUI:Create("Frame");
    MessageFrame:SetCallback("OnClose", function(widget) GL.Interface:release(widget); end);
    MessageFrame:SetTitle("Gargul v" .. GL.version);
    MessageFrame:SetStatusText("");
    MessageFrame:SetLayout("Flow");
    MessageFrame:SetWidth(600);
    MessageFrame:SetHeight(450);

    -- Large edit box
    local MessageBox = AceGUI:Create("MultiLineEditBox");
    MessageBox:SetText(message);
    MessageBox:SetFocus();
    MessageBox:SetFullWidth(true);
    MessageBox:DisableButton(true);
    MessageBox:SetNumLines(22);
    MessageBox:HighlightText();
    MessageBox:SetLabel();
    MessageBox:SetMaxLetters(999999999);
    MessageFrame:AddChild(MessageBox);
end

--- Counting tables (or arrays if you will) is anything but straight-forward in LUA. Examples:
--- #{["test"] = "value", ["test2"] = "value2"} -> results in 0
--- #{1 = "value", 2 = "value2"} -> results in 2
--- #{5 = "value5", 9 = "value9"} -> results in 9, not 2!
---
--- @param var string|table
--- @return number
function GL:count(var)
    if (type(var) == "string") then
        return strlen(var);
    end

    if (type(var) == "table") then
        local count = 0;
        for _ in pairs(var) do
            count = count + 1;
        end

        return count;
    end

    return 0;
end

--- Use `return false;` in your func if you want to break the loop early
---@param func function
---@return void
function GL:forEachItemInBags(func)
    -- Used to break out of our double loop
    local finished = false;

    -- Dragon Flight introduced an extra bag slot
    local numberOfBagsToCheck = self.clientIsDragonFlightOrLater and 5 or 4;

    for bag = 0, numberOfBagsToCheck do
        for slot = 1, self:getContainerNumSlots(bag) do
            (function ()
                local Location = ItemLocation:CreateFromBagAndSlot(bag, slot);

                -- Item doesn't exist
                if (not Location or not C_Item.DoesItemExist(Location)) then
                    return;
                end

                finished = func(Location, bag, slot) == false;
            end)();

            if (finished) then
                break;
            end
        end

        if (finished) then
            return;
        end
    end
end

---@param itemLinkOrID string|number
---@return table|nil
function GL:getCachedItem(itemLinkOrID)
    local ItemResult;
    local itemID = tonumber(itemLinkOrID);

    if (itemID) then
        ItemResult = Item:CreateFromItemID(itemID);
    else
        itemID = GL:getItemIDFromLink(itemLinkOrID);
        ItemResult = Item:CreateFromItemLink(itemLinkOrID);
    end

    local NormalizedItem = self:normalizeItem(ItemResult);
    if (not NormalizedItem) then
        itemID = itemID or itemLinkOrID or "unknown";
        GL:debug("GetItemInfo data was not yet available for item with ID: " .. itemID);

        return;
    end

    return NormalizedItem;
end

GL.Timers = {};
---@param seconds number
---@param identifier string
---@param func function
---@param cancel boolean Cancel any running existing timer with using the same identifier
---@return table
function GL:after(seconds, identifier, func, cancel)
    identifier = identifier or GetTime() .. GL:uuid();
    GL:debug("Schedule " .. identifier);

    cancel = cancel ~= false;
    GL:cancelTimer(identifier);

    GL.Timers[identifier] = GL.Ace:ScheduleTimer(function ()
        GL:debug("Run once " .. identifier);

        func();
    end, seconds);
    return GL.Timers[identifier];
end

---@param seconds number
---@param identifier string
---@param func function
---@return table
function GL:interval(seconds, identifier, func)
    GL:cancelTimer(identifier);
    GL:debug("Schedule recurring " .. identifier);

    GL.Timers[identifier] = GL.Ace:ScheduleRepeatingTimer(function ()
        GL:debug("Run recurring " .. identifier);

        func();
    end, seconds);

    return GL.Timers[identifier];
end

---@param identifier string
function GL:cancelTimer(identifier)
    if (not GL.Timers[identifier]) then
        return;
    end

    GL:debug("Cancelling " .. identifier);
    GL.Ace:CancelTimer(GL.Timers[identifier]);
end

--- The onItemLoadDo helper accepts one or more item ids or item links
--- The corresponding items will be loaded using Blizzard's Item API
--- After all of the items are loaded execute the provided callback function
---
---@param Items table
---@param callback function|nil
---@param haltOnError boolean
---@param sorter function
---@return table
function GL:onItemLoadDo(Items, callback, haltOnError, sorter)
    GL:debug("GL:onItemLoadDo");

    haltOnError = haltOnError or false;
    callback = callback or function () end;

    local itemsWasntATable = type(Items) ~= "table";
    if (itemsWasntATable) then
        Items = {Items};
    end;

    local itemsLoaded = 0;
    local ItemData = {};
    local lastError = "";
    local callbackCalled = false;
    local numberOfItemsToLoad = self:count(Items);

    --- We use this nasty function construct in order to be able to return out of a for loop (see below)
    ---
    ---@param itemIdentifier string|number
    ---@return void
    local function loadOrReturnItem(itemIdentifier)
        local ItemResult = {}; ---@type Item
        local itemID = tonumber(itemIdentifier);
        local identifierIsLink = type(itemIdentifier) == "string";

        -- A string was provided, treat it as an item link and fetch its ID
        if (not itemID
            and identifierIsLink
        ) then
            itemID = GL:getItemIDFromLink(itemIdentifier);
        end

        -- If a number is provided we assume that it's an item ID
        if (itemID) then
            -- Start loading the item
            if (identifierIsLink) then
                ItemResult = Item:CreateFromItemLink(itemIdentifier);
            else
                ItemResult = Item:CreateFromItemID(itemID);
            end

        -- We can't use anything that's not an id or link so we skip it
        else
            itemsLoaded = itemsLoaded + 1;
            lastError = "Unknown identifier type in GL:onItemLoadDo:loadOrReturnItem, expecting string or number";

            return;
        end

        if (
            not ItemResult.IsItemEmpty or ItemResult:IsItemEmpty() -- This is Blizzard's way of saying: this item don't exist fool
            or not ItemResult:GetItemID() -- The item does exist but not in this client version
        ) then
            itemsLoaded = itemsLoaded + 1;
            lastError = "No item found with identifier " .. itemIdentifier;

            return;
        end

        -- The item already exists in our runtime item cache, return it
        if (ItemResult:IsItemDataCached()) then
            local Details = GL:getCachedItem(itemIdentifier);

            if (Details) then
                itemsLoaded = itemsLoaded + 1;
                tinsert(ItemData, Details)

                return;
            end
        end

        ItemResult:ContinueOnItemLoad(function()
            itemsLoaded = itemsLoaded + 1;

            local NormalizedItem = self:normalizeItem(ItemResult);
            if (not NormalizedItem) then
                GL:debug("GetItemInfo data was not yet available for item with ID: " .. itemID);

                return; -- Return here so we don't cache any incomplete data
            end

            tinsert(ItemData, NormalizedItem);

            if (not callbackCalled
                and itemsLoaded >= numberOfItemsToLoad
            ) then
                callbackCalled = true;

                if (type(sorter) == "function") then
                    table.sort(ItemData, sorter);
                end

                if (itemsWasntATable) then
                    ItemData = ItemData[1];
                end

                callback(ItemData);
                return;
            end
        end)
    end

    ---@param itemIdentifier string|number
    for _, itemIdentifier in pairs(Items) do
        if (haltOnError and not GL:empty(lastError)) then
            GL:warning(lastError);
            return;
        end

        loadOrReturnItem(itemIdentifier);

        -- Make sure the callback has not yet been executed in the async onload method
        if (not callbackCalled
            and itemsLoaded >= numberOfItemsToLoad
        ) then
            callbackCalled = true;

            if (itemsWasntATable) then
                ItemData = ItemData[1];
                callback(ItemData);
                return;
            end

            if (type(sorter) == "function") then
                table.sort(ItemData, sorter);
            end

            callback(ItemData);
            return;
        end
    end

    -- The return value is only useful if you're 100% certain the item was already pre-loaded
    return ItemData;
end

--- WARNING: THIS REQUIRES THE ITEM TO BE CACHED!
---
---@param ItemMixin Item
---@return table
function GL:normalizeItem(ItemMixin)
    if (not ItemMixin
        or ItemMixin:IsItemEmpty()
    ) then
        return false;
    end

    local itemID = ItemMixin:GetItemID();
    if (not itemID) then
        return false;
    end

    -- Keep in mind that this data all refers to the base version of the item since we're using an ID
    local itemName, itemLink, itemQuality, itemLevel, _, _, _, _, itemEquipLoc,
    itemTexture, _, classID, subclassID, bindType, _, _, _ = GetItemInfo(itemID);

    if (not itemLink) then
        return false;
    end

    return {
        id = itemID,
        bindType = bindType,
        classID = classID,
        icon = itemTexture,
        inventoryType = itemEquipLoc,
        level = ItemMixin:GetCurrentItemLevel(),
        link = ItemMixin:GetItemLink(),
        name = itemName,
        subclassID = subclassID,
        quality = itemQuality,

        baseLevel = itemLevel,
        baseLink = itemLink,
    };
end

--- Check whether the player's realm is cross realm
---
--- @return boolean
function GL:isCrossRealm()
    if (GL._isCrossRealm == nil) then
        GL._isCrossRealm = not not GetAutoCompleteRealms()[2];
    end

    return GL._isCrossRealm;
end

--- Make sure era names are suffixed with a realm
---
---@param playerName string
---@return string
function GL:normalizedName(playerName)
    GL:debug("GL:normalizedName");

    if (GL.isEra and not strfind(playerName, "-")) then
        playerName = string.format("%s-%s", playerName, GL.User.realm);
    end

    return string.lower(playerName);
end

-- Set up a table of all relevant localized time strings,
-- mapping them to their equivalent time in seconds
-- This allows us to fetch hours/minutes/seconds remaining from item tooltips
local TimeTable = {}
local TimeFormats = {
    [INT_SPELL_DURATION_HOURS] = 60 * 60,
    [INT_SPELL_DURATION_MIN] = 60,
    [INT_SPELL_DURATION_SEC] = 1
};
for pattern, coefficient in pairs(TimeFormats) do
    local prefix = "";
    pattern = pattern:gsub("%%d(%s?)", function(s)
        prefix = "(%d+)" .. s;
        return "";
    end);

    pattern = pattern:gsub("|4", ""):gsub("[:;]", " ");

    for s in pattern:gmatch("(%S+)") do
        TimeTable[prefix .. s] = coefficient;
    end
end

--- Read GL.TooltipFrame's tooltip and see if there's time remaining to trade the item
---
---@return number Seconds or 0
function GL:tooltipItemTradeTimeRemaining()
    local timeRemainingLine;
    local needle = BIND_TRADE_TIME_REMAINING:gsub("%%s", ".*");
    local itemIsSoulBound = false;

    -- Attempt to find a tooltip line that holds the remaining trading time
    for i = 1, GL.TooltipFrame:NumLines() do
        local line = _G["GargulTooltipFrameTextLeft" .. i];

        if line then
            timeRemainingLine = line:GetText() or "";

            -- The item is actually soulbound!
            if (timeRemainingLine == ITEM_SOULBOUND) then
                itemIsSoulBound = true;
            end

            -- The time remaining line was found, no need to continue searching!
            if (timeRemainingLine:find(needle)) then
                break;
            end

            timeRemainingLine = nil;
        end
    end

    -- Extract each unit of time, convert it to seconds, and sum it
    if (timeRemainingLine) then
        local timeRemainingInSeconds = 0;
        for pattern, coefficient in pairs(TimeTable) do
            local timeRemainingSegment = timeRemainingLine:match(pattern);

            if timeRemainingSegment then
                timeRemainingInSeconds = timeRemainingInSeconds + timeRemainingSegment * coefficient;
            end
        end

        return timeRemainingInSeconds;
    end

    -- The item isn't soulbound at all!
    if (not itemIsSoulBound) then
        return GL.Data.Constants.itemIsNotBound;
    end

    return 0;
end

---@param itemLinkOrID string|number
---@return void
function GL:itemTradeTimeRemaining(itemLinkOrID)
    local concernsID = GL:higherThanZero(tonumber(itemLinkOrID));
    local itemID = concernsID and math.floor(tonumber(itemLinkOrID)) or GL:getItemIDFromLink(itemLinkOrID);

    if (not itemID) then
        return;
    end

    local Results = {};
    self:forEachItemInBags(function(Location, bag, slot)
        -- This is not the item we're looking for
        if (C_Item.GetItemID(Location) ~= itemID) then
            return;
        end

        Results[C_Item.GetItemGUID(Location)] = GL:inventoryItemTradeTimeRemaining(bag, slot);
    end);

    return Results;
end

---@param itemGUID string
---@return boolean,boolean|number,number
function GL:getBagAndSlotByGUID(itemGUID)
    local itemBag = false;
    local itemSlot = false;

    self:forEachItemInBags(function(Location, bag, slot)
        -- This is not the item we're looking for
        if (C_Item.GetItemGUID(Location) ~= itemGUID) then
            return;
        end

        itemBag, itemSlot = bag, slot;
        return false;
    end);

    return itemBag, itemSlot;
end

--- Check how much time to trade is remaining on the given item in our bags
---
---@param bag number
---@param slot number
---@return number Seconds or 0
function GL:inventoryItemTradeTimeRemaining(bag, slot)
    GL.TooltipFrame:ClearLines();
    GL.TooltipFrame:SetBagItem(bag, slot);

    local timeRemaining = GL:tooltipItemTradeTimeRemaining();
    GL.TooltipFrame:ClearLines();

    -- General purpose test mode is enabled
    if (GL.Interface.Settings.LootTradeTimers.testEnabled) then
        return math.random(5000, 7200);
    end

    -- Test mode is enabled for specific items
    if (GL.TradeTime) then
        local itemID = select(10, GL:getContainerItemInfo(bag, slot));
        itemID = tonumber(itemID);

        if (itemID and GL:inTable(GL.TradeTime.TestItems or {}, itemID)) then
            return math.random(5000, 7200);
        end
    end

    return timeRemaining;
end

---@param Item Frame
---@param itemLink string
---@return void
function GL:highlightItem(Item, itemLink, Details)
    GL:debug("GL:highlightItem");

    -- There's no point highlighting something if the player
    -- is not in a group or highlights are disabled
    if (type(itemLink) ~= "string"
        or not GL.Settings:get("highlightsEnabled")
        or GL.isRetail -- This doesn't work on retail sadly
        or (
            not GL.Settings:get("highlightHardReservedItems")
            and not GL.Settings:get("highlightSoftReservedItems")
            and not GL.Settings:get("highlightWishlistedItems")
        )
    ) then
        return;
    end

    Details = Details or {};

    -- Remove any existing highlight
    LCG.PixelGlow_Stop(Item);
    local enableHighlight = false;
    local BorderColor = {1, 1, 1, 1}; -- The default border color is priest-white and applies to wishlisted items

    -- The item is hard-reserved
    if (GL.Settings:get("highlightHardReservedItems")
        and GL.SoftRes:linkIsHardReserved(itemLink)
    ) then
        enableHighlight = true;
        BorderColor = {.77, .12, .23, 1};  -- Make the border red for hard-reserved items

    -- The item is soft-reserved
    elseif (GL.Settings:get("highlightSoftReservedItems")
        and GL.SoftRes:linkIsReserved(itemLink)
        and not (not GL.User.isMasterLooter
            and GL.Settings:get("highlightMyItemsOnly")
            and not GL.SoftRes:itemLinkIsReservedByMe(itemLink)
        )
    ) then
        enableHighlight = true;
        BorderColor = {.95686, .5490, .72941, 1}; -- Make the border paladin-pink for reserved items

    -- Check if it's wishlisted/priolisted
    elseif (GL.Settings:get("highlightWishlistedItems")
        or GL.Settings:get("highlightPriolistedItems")
    ) then
        local TMBInfo = {};

        -- Fetch all TMB data for this item
        if (GL.User.isMasterLooter
            or not GL.Settings:get("highlightMyItemsOnly")
        ) then
            TMBInfo = GL.TMB:byItemLink(itemLink) or {};

        -- Fetch only the current user's TMB data, he's not interested in the rest
        else
            TMBInfo = GL.TMB:byItemLinkAndPlayer(itemLink, GL.User.name) or {};
        end

        local concernsPrio = false;

        -- Check for active wishlist entries
        for _, Entry in pairs(TMBInfo) do
            BorderColor = {1, 1, 1, 1}; -- Make the border priest-white for TMB wishlisted items

            if (Entry.type == Constants.tmbTypePrio) then
                concernsPrio = true;
                BorderColor = {1, .48627, .0392, 1}; -- Make the border druid-orange for TMB character prio items
                break;
            end
        end

        if (not GL:empty(TMBInfo)
            and (
                (not concernsPrio and GL.Settings:get("highlightWishlistedItems"))
                or (concernsPrio and GL.Settings:get("highlightPriolistedItems"))
            )
        ) then
            enableHighlight = true;
        end
    end

    if (not enableHighlight) then
        return;
    end

    -- Add an animated border to indicate that this item was reserved / wishlisted
    -- function lib.PixelGlow_Start(r,color,N,frequency,length,th,xOffset,yOffset,border,key,frameLevel)
    LCG.PixelGlow_Start(Item,
        BorderColor,
        Details.dots or 10,
        Details.speed or .05,
        Details.length or 5,
        Details.width or 2,
        Details.offsetX,
        Details.offsetY,
        Details.border,
        Details.key,
        Details.level
    );
end

---@return void
function GL:bugReport()
    local AddonData = {};
    for i = 1, GetNumAddOns() do
        local name = GetAddOnInfo(i);
        local version = GetAddOnMetadata(i, "Version");
        local loaded = GetAddOnEnableState(GL.User.name, name) == 2;

        AddonData[name] = { version, loaded };
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

--- Check whether a user can use the given item ID or link (callback required)
---
---@param itemLinkOrID string|number
---@param callback function
---
---@return void
function GL:canUserUseItem(itemLinkOrID, callback)
    GL:debug("GL:canUserUseItem");

    if (type(callback) ~= "function") then
        GL:warning("Unexpected type '" .. type(callback) .. "' in GL:canUserUseItem, expecting type 'function'");
        return;
    end

    local itemID;
    local concernsID = GL:higherThanZero(tonumber(itemLinkOrID));

    if (concernsID) then
        itemID = math.floor(tonumber(itemLinkOrID));
    else
        itemID = GL:getItemIDFromLink(itemLinkOrID);
    end

    GL:onItemLoadDo(itemID, function (Details)
        if (not Details) then
            return callback(true);
        end

        GL.TooltipFrame:ClearLines();
        GL.TooltipFrame:SetHyperlink("item:" .. itemID);

        local IsTooltipTextRed = function (text)
            if (text and text:GetText()) then
                local r, g, b = text:GetTextColor();
                return math.floor(r * 256) >= 255 and math.floor(g * 256) == 32 and math.floor(b * 256) == 32;
            end

            return false;
        end;

        for line = 1, GL.TooltipFrame:NumLines() do
            local left = _G["GargulTooltipFrameTextLeft" .. line];
            local right = _G["GargulTooltipFrameTextRight" .. line];

            if (IsTooltipTextRed(left) or IsTooltipTextRed(right)) then
                return callback(false);
            end
        end

        return callback(true);
    end);
end

---@param bagID number
---@param slot number
---@return any
function GL:useContainerItem(bagID, slot)
    if (UseContainerItem) then
        return UseContainerItem(bagID, slot)
    end

    if (C_Container and C_Container.UseContainerItem) then
        return C_Container.UseContainerItem(bagID, slot);
    end

    return nil;
end

---@param bag number
---@param slot number
---@return boolean|string
function GL:getItemGUIDByBagAndSlot(bag, slot)
    local Location = ItemLocation:CreateFromBagAndSlot(bag, slot);

    -- Item doesn't exist
    if (not Location or not C_Item.DoesItemExist(Location)) then
        return;
    end

    return C_Item.GetItemGUID(Location);
end

---@param bagID number
---@param slot number
---@return any
function GL:getContainerItemInfo(bagID, slot)
    if (GetContainerItemInfo) then
        return GetContainerItemInfo(bagID, slot)
    end

    if (C_Container and C_Container.GetContainerItemInfo) then
        local Info = C_Container.GetContainerItemInfo(bagID, slot);

        if (not Info) then
            return nil;
        end

        return Info.iconFileID, Info.stackCount, Info.isLocked, Info.quality, Info.isReadable,
        Info.hasLoot, Info.hyperlink, Info.isFiltered, Info.hasNoValue, Info.itemID, Info.isBound;
    end

    return nil;
end

---@param bagID number
---@return number
function GL:getContainerNumSlots(bagID)
    local handler = GetContainerNumSlots or (C_Container and C_Container.GetContainerNumSlots);

    return handler(bagID);
end

--- Find the first bag id and slot for a given item id (or false)
---
---@param itemID number
---@param skipSoulBound boolean
---@return table
function GL:findBagIdAndSlotForItem(itemID, skipSoulBound, includeBankBags)
    skipSoulBound = GL:toboolean(skipSoulBound);
    includeBankBags = GL:toboolean(includeBankBags);

    local numberOfBagsToCheck = 4;
    if (includeBankBags) then
        numberOfBagsToCheck = 10;
    end

    -- Dragon Flight introduced an extra bag slot
    if (GL.isDragonFlightOrLater) then
        numberOfBagsToCheck = numberOfBagsToCheck + 1;
    end

    for bag = 0, numberOfBagsToCheck do
        for slot = 1, GL:getContainerNumSlots(bag) do
            local _, _, locked, _, _, _, _, _, _, bagItemID = GL:getContainerItemInfo(bag, slot);

            if (bagItemID == itemID
                and not locked -- The item is locked, aka it can not be put in the window
                and (not skipSoulBound -- We don't care about the soulbound status of the item, return the bag/slot!
                    or GL:inventoryItemTradeTimeRemaining(bag, slot) > 0 -- The item is tradeable
                )
            ) then
                return {bag, slot};
            end
        end
    end

    return {};
end

--- Dragonflight and future WoW releases no longer support OnTooltipSetItem
---
---@param Callback function
---@param includeItemRefTooltip boolean
---@return any
function GL:onTooltipSetItem(Callback, includeItemRefTooltip)
    GL:debug("GL:onTooltipSetItem");

    includeItemRefTooltip = includeItemRefTooltip ~= false;
    includeItemRefTooltip = GL:toboolean(includeItemRefTooltip);

    -- Support native GameToolTip
    if (TooltipDataProcessor) then
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

--- In some very rare cases we need to manipulate the close button on AceGUI elements
---
---@param Widget table
---@return void|table
function GL:fetchCloseButtonFromAceGUIWidget(Widget)
    GL:debug("GL:fetchCloseButtonFromAceGUIWidget");

    if (not Widget or not Widget.frame) then
        return;
    end

    -- Try to locate the Close button and hide it
    for _, Child in pairs({Widget.frame:GetChildren()}) do
        if (Child.GetText and Child:GetText() == CLOSE) then
            return Child;
        end
    end
end

--- In some very rare cases we need to manipulate the border on AceGUI Inline Group elements
---
---@param Widget table
---@return void|table
function GL:fetchBorderFromAceGUIInlineGroup(Widget)
    GL:debug("GL:fetchBorderFromAceGUIInlineGroup");

    if (not Widget or not Widget.frame) then
        return;
    end

    -- Try to locate the Close button and hide it
    for _, Child in pairs({Widget.frame:GetChildren()}) do
        if (Child.SetBackdropColor) then
            return Child;
        end
    end
end

--- Some items have items linked to them. Example: t4 tokens have their quest reward counterpart linked to them.
---
---@param itemID number
---@param linkNormalAndHardModeItems boolean
---@return table
function GL:getLinkedItemsForID(itemID, linkNormalAndHardModeItems)
    -- An invalid item id was provided
    itemID = tonumber(itemID);
    if (not GL:higherThanZero(itemID)) then
        return {};
    end

    itemID = tostring(itemID);
    local AllLinkedItemIDs = {};
    AllLinkedItemIDs[itemID] = 1;

    local i = 2;
    for _, id in pairs(GL.Data.ItemLinks[itemID] or {}) do
        AllLinkedItemIDs[id] = i;
        i = i + 1;
    end

    if (linkNormalAndHardModeItems
        or GL.Settings:get("MasterLooting.linkNormalAndHardModeItems")
    ) then
        for _, id in pairs(GL.Data.NormalModeHardModeLinks[itemID] or {}) do
            AllLinkedItemIDs[id] = i;
            i = i + 1;
        end
    end

    return GL:tableFlip(AllLinkedItemIDs);
end

--- Return an item's ID from an item link, false if invalid itemlink is provided
---
---@param itemLink string
---@return number|boolean
function GL:getItemIDFromLink(itemLink)
    if (not itemLink
        or type(itemLink) ~= "string"
        or itemLink == ""
    ) then
        return false;
    end

    local _, itemID = strsplit(":", itemLink);
    itemID = tonumber(itemID);

    if (not itemID) then
        return false;
    end

    return itemID;
end

--- Return an item's quality from an item link
---
---@param itemLink string
---@return number|boolean
function GL:getItemQualityFromLink(itemLink)
    if (not itemLink
        or type(itemLink) ~= "string"
        or itemLink == ""
    ) then
        return false;
    end

    local color = string.sub(itemLink, 5, 10);

    if (not color) then
        return false;
    end

    return GL.Data.Constants.HexColorsToItemQuality[color] or false;
end

---@param callback function
---@return void
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
    return not self:isCrossRealm() and UnitIsConnected(self:stripRealm(player)) or UnitIsConnected(self:nameFormat(player));
end

--- Add the realm name to a player name
---
---@param name string
---@param realm string
---@return string
function GL:addRealm(name, realm, fromGroup)
    realm = not self:empty(realm) and realm or nil;
    fromGroup = fromGroup ~= false;
    name = tostring(name);

    if (self:empty(name)) then
        return "";
    end

    local separator = name:match("-");

    -- A realm separator was found, return the original message
    if (separator) then
        return name;
    end

    -- This is not a cross-realm server, no need to check uniqueness etc
    if (not self:isCrossRealm()) then
        return ("%s-%s"):format(name, realm or GL.User.realm);
    end

    -- Fetch the realm name from a group member if possible
    if (fromGroup
        and not realm
        and GL.User:unitInGroup(name)
    ) then
        if (GL:nameIsUnique(name)) then
            local playerId = UnitGUID(name);

            if (playerId) then
                realm = select(7, GetPlayerInfoByGUID(playerId));

                -- Realm can be an empty string on same-realm players
                realm = realm ~= "" and realm or GL.User.realm;
            end
        end
    end

    return ("%s-%s"):format(name, realm or GL.User.realm);
end

--- Strip the realm off of a player name
---
---@param playerName string
---@return string, string str, realm
function GL:stripRealm(playerName)
    playerName = tostring(playerName);

    if (self:empty(playerName)) then
        return "";
    end

    local separator = playerName:match("-");

    -- No realm separator was found, return the original message
    if (not separator) then
        return playerName;
    end

    local Parts = self:explode(playerName, separator);
    return Parts[1], Parts[2];
end

--- Get the realm from a given player name
---
---@param playerName string
---@return string
function GL:getRealmFromName(playerName)
    playerName = tostring(playerName);

    if (self:empty(playerName)) then
        return false;
    end

    local separator = playerName:match("-");

    -- No realm separator was found, return the original message
    if (not separator) then
        return false;
    end

    local Parts = self:explode(playerName, separator);
    return Parts[2] or "";
end

--- Check whether the given player name occurs more than once in the player's group
--- (only possible in case of cross-realm support)
---
---@param playerName string
---@return boolean
function GL:nameIsUnique(playerName)
    if (not self:isCrossRealm()) then
        return true;
    end

    playerName = GL:stripRealm(playerName);
    local nameEncountered = false;
    for _, groupMemberName in pairs(GL.User:groupMemberNames()) do
        if (self:iEquals(playerName, groupMemberName)) then
            -- We already encountered this name before, NOT UNIQUE!
            if (nameEncountered) then
                return false;
            end

            nameEncountered = true;
        end
    end

    return true;
end

--- Return an item's name from an item link
---
---@param itemLink string
---@return string|boolean
function GL:getItemNameFromLink(itemLink)
    if (type(itemLink) ~= "string"
        or self:empty(itemLink)
    ) then
        return false;
    end

    local itemName = false;
    local openingBracketPosition = string.find(itemLink, "%[");
    local closingBracketPosition = string.find(itemLink, "%]");
    if (openingBracketPosition and closingBracketPosition) then
        itemName = string.sub(itemLink, openingBracketPosition + 1, closingBracketPosition - 1);
    end

    return itemName;
end

--- Strip color tags from a string
---
---@param text string
---@return string
function GL:stripColor(text)
    text = string.gsub(text or "", "|c%x%x%x%x%x%x%x%x", "" );
    text = string.gsub(text, "|c%x%x %x%x%x%x%x", "" );
    text = string.gsub(text, "|r", "" );

    return text;
end

---@see GL:copperToMoney
function GL:goldToMoney(copper, Separators, includeEmpty, separatorBeforeUnit)
    return self:copperToMoney(copper * 10000, Separators, includeEmpty, separatorBeforeUnit);
end

--- Transform a copper value to a money string
---
--- copperToMoney(125000)                    > 12G 50S
--- copperToMoney(125000, nil, true)         > 12G 50S 0C
--- copperToMoney(125000, {".","",""}, true) > 12.5000
--- copperToMoney(125000, nil, true, true)   > G12 S50 C0
---
---@param copper number
---@param Separators table|nil
---@param includeEmpty boolean|nil
---@param separatorBeforeUnit boolean|nil
---
---@return string
function GL:copperToMoney(copper, Separators, includeEmpty, separatorBeforeUnit)
    local DefaultSeparators;

    if (copper < 1) then
        return "";
    end

    copper = self:floor(copper, 4);

    if (not separatorBeforeUnit) then
        DefaultSeparators = {"g ", "s ", "c "};
    else
        DefaultSeparators = {" g", " s", " c"};
    end

    Separators = Separators or {};
    includeEmpty = GL:toboolean(includeEmpty);
    separatorBeforeUnit = GL:toboolean(separatorBeforeUnit);
    local goldSeparator = Separators[1] or DefaultSeparators[1];
    local silverSeparator = Separators[2] or DefaultSeparators[2];
    local copperSeparator = Separators[3] or DefaultSeparators[3];

    local gold = math.floor(copper / 10000);
    local silver = math.floor(copper / 100) % 100
    local copperLeft = copper % 100

    -- The user doesn't care about empty units, return as-is
    if (includeEmpty) then
        if (not separatorBeforeUnit) then
            return string.format(
                "%s%s%s%s%s%s",
                gold,
                goldSeparator,
                silver,
                silverSeparator,
                copperLeft,
                copperSeparator
            );
        else
            return string.format(
                "%s%s%s%s%s%s",
                goldSeparator,
                gold,
                silverSeparator,
                silver,
                copperSeparator,
                copperLeft
            );
        end
    end

    local money = "";

    if (gold > 0) then
        if (separatorBeforeUnit) then
            money = goldSeparator .. gold;
        else
            money = gold .. goldSeparator;
        end
    end

    if (silver > 0) then
        if (separatorBeforeUnit) then
            money = money .. silverSeparator .. silver;
        else
            money = money .. silver .. silverSeparator;
        end
    end

    if (copperLeft > 0) then
        if (separatorBeforeUnit) then
            money = money .. copperSeparator .. copperLeft;
        else
            money = money .. copperLeft .. copperSeparator;
        end
    end

    return strtrim(money);
end

--- Limit a given string to a maximum number of characters
---
---@param str string
---@param limit number
---@param append string|nil
---@return string
function GL:strLimit(str, limit, append)
    local strLength = string.len(str);

    -- The string is not too long, just return it
    if (strLength <= limit) then
        return str;
    end

    append = append or "...";
    local appendLength = string.len(append);

    -- Return the limited string with appendage
    return str:sub(1, limit - appendLength) .. append;
end

--- Insert a string in another string at a given position
---
---@param str1 string
---@param str2 string
---@param pos number
---
---@return string
function GL:strInsert(str1, str2, pos)
    return str1:sub(1,pos) .. str2 .. str1:sub(pos+1);
end

--- Split a string by any space characters or commas
--- This is useful for CSV, TSV files and pasted tables from Google Docs
---
---@param s string
---@return table
function GL:separateValues(s)
    local Segments = {};

    for match in string.gmatch(s, "[^%s,]+") do
        tinsert(Segments, match);
    end

    return Segments;
end

--- Turn a given wow pattern into something we can use in string.match
---
---@param pattern string
---@param maximize boolean|nil
---@return string
function GL:createPattern(pattern, maximize)
    pattern = string.gsub(pattern, "[%(%)%-%+%[%]]", "%%%1");

    if not maximize then
        pattern = string.gsub(pattern, "%%s", "(.-)");
    else
        pattern = string.gsub(pattern, "%%s", "(.+)");
    end

    pattern = string.gsub(pattern, "%%d", "%(%%d-%)");

    if not maximize then
        pattern = string.gsub(pattern, "%%%d%$s", "(.-)");
    else
        pattern = string.gsub(pattern, "%%%d%$s", "(.+)");
    end

    return string.gsub(pattern, "%%%d$d", "%(%%d-%)");
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

    local normalizedName = strtrim(string.lower(tostring(soundNameOrNumber)));
    normalizedName = string.gsub(normalizedName, "\\", "/");
    pcall(function ()
        if (GL:strContains(normalizedName, "interface/addons") or normalizedName == "none") then
            PlaySoundFile(soundNameOrNumber, channel);
        else
            PlaySound(soundNameOrNumber, channel, forceNoDuplicates, runFinishCallback);
        end
    end);
end

local gaveNoMessagesWarning = false;
local gaveNoAssistWarning = false;
--- Send a chat message to any given type and channel. Group defaults to raid or group depending on what you're in
--- CURRENT will send a chat message on the currently active channel
---
---@param message string The message you'd like to send
---@param chatType string The type of message (CURRENT|GROUP|SAY|EMOTE|YELL|PARTY|GUILD|OFFICER|RAID|RAID_WARNING|INSTANCE_CHAT|BATTLEGROUND|WHISPER|CHANNEL|AFK|DND)
---@param language string|nil The language of the message (COMMON|ORCISH|etc), if nil it's COMMON for Alliance and ORCISH for Horde
---@param channel string|nil The channel (numeric) or player (name string) receiving the message
---@param stw boolean|nil Important for throttling / spam prevention
---@return string
function GL:sendChatMessage(message, chatType, language, channel, stw, pretend)
    GL:debug("GL:sendChatMessage");

    stw = stw ~= false;

    -- No point sending an empty message!
    if (GL:empty(message)) then
        return;
    end

    -- No point sending an empty message!
    if (GL:empty(chatType)) then
        GL:warning("Missing 'chatType' in GL:sendChatMessage!");
        return;
    end

    -- The player enabled the noMessages setting
    if (GL.Settings:get("noMessages")) then
        pretend = true;

        if (not gaveNoMessagesWarning) then
            --GL:message("A message was blocked because you have the 'No messages' setting enabled.");
            gaveNoMessagesWarning = true;
        end
    end

    -- The user is not in a group of any kind but still wants to
    -- post a message on group or raid. Let's assume he's testing stuff
    if (not GL.User.isInGroup
        and GL:inTable({"GROUP", "PARTY", "RAID", "RAID_WARNING"}, chatType)
    ) then
        -- We never want to show this message, not even whilst solo
        if (GL.isMuted) then
            return;
        end

        return GL:coloredMessage("FF7D0A", message); -- FF7D0A is the same color as /ra text
    end

    if (stw) then
        message = string.format("{rt3} %s : %s", GL.name, message);
    end

    -- The player wants to message the group (either raid or party)
    if (chatType == "GROUP") then
        chatType = "PARTY";

        if (GL.User.isInRaid) then
            chatType = "RAID";
        end

    -- The player wants to post in RAID_WARNING but is either not in a raid or doesn't have assist
    elseif (chatType == "RAID_WARNING") then
        if (not GL.User.isInRaid) then
            chatType = "PARTY";
        elseif (not GL.User.hasAssist) then
            if (not gaveNoAssistWarning) then
                GL:warning("You need assist to use raid warnings!");
                gaveNoAssistWarning = true;
            end

            chatType = "RAID";
        end
    elseif (chatType == "CURRENT") then
        chatType = DEFAULT_CHAT_FRAME.editBox:GetAttribute("chatType");
        channel = DEFAULT_CHAT_FRAME.editBox:GetAttribute("tellTarget");

        if (not GL:inTable({"BN_WHISPER", "CHANNEL", "WHISPER"}, chatType)) then
            channel = nil;
        end
    end

    if (not pretend) then
        SendChatMessage (
            message,
            chatType,
            language,
            channel
        );
    end

    return message;
end

local previousNoMessagesWarningValue;
local previousGaveNoMessagesWarningValue;

--- Temporarily mute the add-on by not showing any messages
---
---@return void
function GL:mute()
    previousNoMessagesWarningValue = GL.Settings:get("noMessages");
    previousGaveNoMessagesWarningValue = gaveNoMessagesWarning;

    gaveNoMessagesWarning = true;

    GL.Settings:set("noMessages", true);
    GL.isMuted = true;
end

--- Unmute add-on after (temporary) mute
---
---@return void
function GL:unmute()
    -- We didn't mute the application in the first place
    if (previousGaveNoMessagesWarningValue == nil) then
        return;
    end

    gaveNoMessagesWarning = previousGaveNoMessagesWarningValue;
    GL.Settings:set("noMessages", previousNoMessagesWarningValue);
    GL.isMuted = false;

    previousNoMessagesWarningValue = nil;
    previousGaveNoMessagesWarningValue = nil;
end

--- Check whether a given value exists within a table
---
---@param array table
---@param value any
function GL:inTable(array, value)
    if (type(value) == "string") then
        value = string.lower(value);
    end

    for _, val in pairs(array) do
        if (type(val) == "string") then
            val = string.lower(val);
        end

        if value == val then
            return true
        end
    end

    return false
end

--- Generate a random (enough) uuid
---
---@return string
function GL:uuid()
    local random = math.random;
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx";

    return string.gsub(template, "[xy]", function (c)
        local v = (c == "x") and random(0, 0xf) or random(8, 0xb);
        return string.format("%x", v);
    end)
end

--- Overwrite/compliment the original table (left) with the values from the right table
---
---@param left table
---@param right table
---@return table
function GL:tableMerge(left, right)
    if (type(left) ~= "table" or type(right) ~= "table") then
        return false;
    end

    for key,value in pairs(right) do
        if (type(value) == "table") then
            if (type(left[key] or false) == "table") then
                self:tableMerge(left[key] or {}, right[key] or {});
            else
                left[key] = value;
            end
        else
            left[key] = value;
        end
    end

    return left;
end

---@param Table table
---@return table
function GL:tableUnique(Table)
    local UniqueValues = {};

    local i = 1;
    for _, value in pairs(Table or {}) do
        if ((type(value) == "string"
            or type(value) == "number"
            ) and not UniqueValues[value]
        ) then
            UniqueValues[value] = i;
            i = i + 1;
        end
    end

    return self:tableFlip(UniqueValues);
end

--- Return the values from a single column in the input table
---
---@param Table table
---@param column string
---@return table
function GL:tableColumn(Table, column)
    local Values = {};

    for _, Entry in pairs(Table) do
        if (Entry[column]) then
            tinsert(Values, Entry[column]);
        end
    end

    return Values;
end

--- Simple table flip (keys become values, values become keys)
--- (╯°□°）╯︵ ┻━┻
---
---@param Table table
function GL:tableFlip(Table)
    local Flipped = {};
    for key, value in pairs(Table) do
        Flipped[value] = key;
    end

    return Flipped;
end

--- Table slice method
---
---@param Table table
---@param offset number
---@param length number
---@param preserveKeys boolean
---@return table
function GL:tableSlice(Table, offset, length, preserveKeys)
    if (not length) then
        length = offset;
        offset = 0;
    end

    if (not offset
        or type(offset) ~= "number"
        or offset < 1
    ) then
        offset = 1;
    end

    local Slice = {};
    local last = offset + length;

    if (preserveKeys) then
        local index = 1;
        for key, value in pairs(Table) do
            if (index > last) then
                return Slice;
            end

            if (index >= offset) then
                Slice[key] = value;
            end

            index = index + 1;
        end

        return Slice;
    end

    for index = offset, last do
        if (type(Table[index]) == "nil") then
            return Slice;
        end

        tinsert(Slice, Table[index]);
    end

    return Slice;
end

---@param Table table
---@return table
function GL:tableValues(Table)
    local Values = {};
    for _, value in pairs(Table or {}) do
        tinsert(Values, value);
    end

    return Values;
end

---@param Table table
---@return table
function GL:tableKeys(Table)
    local Keys = {};
    for key in pairs(Table or {}) do
        tinsert(Keys, key);
    end

    return Keys;
end

--- Pad a string to a certain length with another string (left side)
---
---@param str string
---@param padChar string
---@param length number
---@return string
function GL:strPadLeft(str, padChar, length)
    return string.rep(padChar, length - GL:count(str)) .. str;
end

--- Pad a string to a certain length with another string (right side)
---
---@param str string
---@param padChar string
---@param length number
---@return string
function GL:strPadRight(str, padChar, length)
    return str .. string.rep(padChar, length - GL:count(str));
end

--- Get a table value by a given key. Use dot notation to traverse multiple levels e.g:
--- Settings.UI.Auctioneer.offsetX can be fetched using GL:tableGet(myTable, "Settings.UI.Auctioneer.offsetX", 0)
--- without having to worry about tables or keys existing along the way.
--- This helper is absolutely invaluable for writing error-free code!
---
---@param Table table
---@param keyString string
---@param default any
---@return any
function GL:tableGet(Table, keyString, default)
    if (type(keyString) ~= "string"
        or self:empty(keyString)
    ) then
        return default;
    end

    local keys = GL:explode(keyString, ".");
    local numberOfKeys = #keys;
    local firstKey = keys[1];

    if (not numberOfKeys or not firstKey) then
        return default;
    end

    if (type(Table) == "table") then
        if (type(Table[firstKey]) == "nil") then
            firstKey = tonumber(firstKey);

            -- Make sure we're not looking for a numeric key instead of a string
            if (not firstKey or type(Table[firstKey]) == "nil") then
                return default;
            end
        end

        Table = Table[firstKey];
    else
        return Table or default;
    end

    -- Changed if (#keys == 1) then to below, saved this just in case we get weird behavior
    if (numberOfKeys == 1) then
        default = nil;
        return Table;
    end

    tremove(keys, 1);
    return self:tableGet(Table, strjoin(".", unpack(keys)), default);
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

    return string.lower(strtrim(reference)) == string.lower(strtrim(control));
end

--- Set a table value by a given key and value. Use dot notation to traverse multiple levels e.g:
--- Settings.UI.Auctioneer.offsetX can be set using GL:tableSet(myTable, "Settings.UI.Auctioneer.offsetX", myValue)
--- without having to worry about tables or keys existing along the way.
---
---@param Table table
---@param keyString string
---@param value any
---@param ignoreIfExists boolean If the given final key exists then it will not be overwritten
---@return boolean
function GL:tableSet(Table, keyString, value, ignoreIfExists)
    if (not keyString
        or type(keyString) ~= "string"
        or keyString == ""
    ) then
        GL:warning("Invalid key provided in GL:tableSet");
        return false;
    end

    ignoreIfExists = GL:toboolean(ignoreIfExists);
    local keys = GL:explode(keyString, ".");
    local firstKey = keys[1];

    if (#keys == 1) then
        if (Table[firstKey] ~= nil or not ignoreIfExists) then
            Table[firstKey] = value;
        end

        return true;
    elseif (not Table[firstKey]) then
        Table[firstKey] = {};
    end

    tremove(keys, 1);

    Table = Table[firstKey];
    return self:tableSet(Table, strjoin(".", unpack(keys)), value);
end

--- Add a value to a table by a given key and value. Use dot notation to traverse multiple levels e.g:
--- Settings.UI.Auctioneer.offsetX can be set using GL:tableSet(myTable, "Settings.UI.Auctioneer.offsetX", myValue)
--- without having to worry about tables or keys existing along the way.
---
---@param Table table
---@param keyString string
---@param value any|nil
---@param createDestination boolean|nil
---@return boolean
function GL:tableAdd(Table, keyString, value, createDestination)
    local Destination = self:tableGet(Table, keyString, {});

    if (type(Destination) ~= "table") then
        if (not createDestination) then
            self:warning("Invalid destination GL:tableAdd, requires table");
            return false;
        end

        self:tableSet(Table, keyString, {});
        Destination = {};
    end

    tinsert(Destination, value);
    return self:tableSet(Table, keyString, Destination);
end

--- Apply a user supplied function to every member of a table
---
---@param Table table
---@param callback function
---@return void
function GL:tableWalk(Table, callback, ...)
    for key, Value in pairs(Table) do
        callback(key, Value, ...);
    end
end;

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