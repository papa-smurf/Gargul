---@class GL : Bootstrapper
local _, GL = ...;

local Constants = GL.Data.Constants; ---@type Data

--- Print a normal message (white)
---
---@vararg string
---@return void
function GL:message(...)
    print("|cff8aecffGargul: |r" .. string.join(" ", ...));
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
    local message = string.join(" ", ...);
    tinsert(self.DebugLines, message);

    if (GL.Settings
        and GL.Settings:get("debugModeEnabled")
    ) then
        GL:coloredMessage("f7922e", ...);
    end
end

--- Print a warning message (orange)
---
---@return void
function GL:warning(...)
    GL:coloredMessage("f7922e", ...);
end

--- Print a error message (red)
---
---@return void
function GL:error(...)
    GL:coloredMessage("be3333", ...);
end

--- Capitalize a given value (e.g. gargul becomes Gargul)
---
---@param value string
---@return string
function GL:capitalize(value)
    return (value:gsub("^%l", string.upper));
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

--- Check whether a given variable is not empty
---
---@param mixed any
---@return boolean
function GL:empty(mixed)
    ---@type string
    local varType = type(mixed);

    mixed = mixed or false;

    if (varType == "boolean"
        and mixed
    ) then
        return false;
    end

    if (varType == "string"
        and strtrim(mixed) ~= ""
    ) then
        return false;
    end

    if (varType == "table") then
        for _ in pairs(mixed) do
            return false;
        end
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

--- Check whether a given variable is a number that's higher than zero
---
---@param numericValue number
---@return boolean
function GL:higherThanZero(numericValue)
    return numericValue
        and type(numericValue) == "number"
        and numericValue > 0
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

--- Print a table to the console
---
---@param t table
---@param shouldReturn boolean|nil
---@return void|string
function GL:printTable(t, shouldReturn)
    local returnString = "";

    local printTable_cache = {};

    local segment = "";
    local function sub_printTable( t, indent )
        if (printTable_cache[tostring(t)]) then
            segment = indent .. "*" .. tostring(t);
            if (shouldReturn) then
                returnString = "\n" .. returnString .. segment;
            else
                print(segment);
            end
        else
            printTable_cache[tostring(t)] = true;

            if (type(t) == "table") then
                for pos,val in pairs( t ) do
                    if (type(val)== "table") then
                        segment = indent .. "[" .. pos .. "] => " .. tostring( t ).. " {";

                        if (shouldReturn) then
                            returnString = "\n" .. returnString .. segment;
                        else
                            print(segment);
                        end

                        sub_printTable(val, indent .. string.rep( " ", string.len(pos)+8 ));

                        segment = indent .. string.rep( " ", string.len(pos)+6 ) .. "}";
                        if (shouldReturn) then
                            returnString = "\n" .. returnString .. segment;
                        else
                            print(segment);
                        end
                    elseif (type(val) == "string") then
                        segment = indent .. "[" .. pos .. '] => "' .. val .. '"';
                        if (shouldReturn) then
                            returnString = "\n" .. returnString .. segment;
                        else
                            print(segment);
                        end
                    else
                        segment = indent .. "[" .. pos .. "] => " .. tostring(val);
                        if (shouldReturn) then
                            returnString = "\n" .. returnString .. segment;
                        else
                            print(segment);
                        end
                    end
                end
            else
                segment = indent .. tostring(t);
                if (shouldReturn) then
                    returnString = "\n" .. returnString .. segment;
                else
                    print(segment);
                end
            end
        end
    end

    if (type(t) == "table") then
        segment = tostring(t) .. " {";
        if (shouldReturn) then
            returnString = "\n" .. returnString .. segment .. "\n";
        else
            print(segment);
            print();
        end

        sub_printTable(t, "  ");

        segment = "}";
        if (shouldReturn) then
            returnString = "\n" .. returnString .. segment;
        else
            print(segment);
        end
    else
        sub_printTable(t, "  ");
    end

    if (shouldReturn) then
        return returnString;
    end
end

--- Clone a table
---
---@param original table
---@return table
function GL:cloneTable(original)
    return {unpack(original)};
end

--- Display all debug lines
---
---@return void
function GL:stacktrace()
    local debugLines = "";

    for key in pairs(GL.DebugLines) do
        debugLines = string.format("%s%s\n", debugLines, GL.DebugLines[key]);
    end

    self:frameMessage(debugLines);
end

--- Clears the provided scrolling table (lib-ScrollingTable)
---
---@param ScrollingTable table
---@return void
function GL:clearScrollTable(ScrollingTable)
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
   return string.sub(str, 1, string.len(startStr)) == startStr;
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
    local StacktraceFrame = AceGUI:Create("Frame");
    StacktraceFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget); end);
    StacktraceFrame:SetTitle("Gargul v" .. GL.version);
    StacktraceFrame:SetStatusText("");
    StacktraceFrame:SetLayout("Flow");
    StacktraceFrame:SetWidth(600);
    StacktraceFrame:SetHeight(450);

    -- Large edit box
    local StacktraceBox = AceGUI:Create("MultiLineEditBox");
    StacktraceBox:SetText(message);
    StacktraceBox:SetFocus();
    StacktraceBox:SetFullWidth(true);
    StacktraceBox:DisableButton(true);
    StacktraceBox:SetNumLines(22);
    StacktraceBox:HighlightText();
    StacktraceBox:SetMaxLetters(999999999);
    StacktraceFrame:AddChild(StacktraceBox);
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
        return string.length(var);
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

--- The onItemLoadDo helper accepts one or more item ids or item links
--- The corresponding items will be loaded using Blizzard's Item API
--- After all of the files are loaded execute the provided callback function
---
---@param Items table
---@param callback function
---@param haltOnError boolean
---@return void
function GL:onItemLoadDo(Items, callback, haltOnError)
    GL:debug("GL:onItemLoadDo");

    GL.DB.Cache.ItemsById = GL.DB.Cache.ItemsById or {};
    haltOnError = haltOnError or false;

    if (type(callback) ~= "function") then
        GL:warning("Unexpected type '" .. type(callback) .. "' in GL:continueOnItemLoad, expecting type 'function'");
        return;
    end

    if (type(Items) ~= "table") then
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
        local identifierType = type(itemIdentifier);
        local identifierIsId = GL:higherThanZero(tonumber(itemIdentifier));
        local idString = "";

        -- If a number is provided we assume that it's an item ID
        if (identifierIsId) then
            -- This seems counterintuitive, but don't get me started on numeric table keys in LUA
            idString = tostring(itemIdentifier);

            -- The item already exists in our runtime item cache, return it
            if (GL.DB.Cache.ItemsById[idString] ~= nil) then
                itemsLoaded = itemsLoaded + 1;
                tinsert(ItemData, GL.DB.Cache.ItemsById[idString]);

                return;
            end

            -- The item doesn't exist yet, start loading it
            ItemResult = Item:CreateFromItemID(tonumber(itemIdentifier));

        -- If a string is provided we assume that it's an item link
        elseif (identifierType == "string") then
            ItemResult = Item:CreateFromItemLink(itemIdentifier);

        -- We can't use anything that's not an id or link so we skip it
        else
            itemsLoaded = itemsLoaded + 1;
            lastError = "Unknown identifier type in GL:onItemLoadDo:loadOrReturnItem, expecting string or number";

            return;
        end

        -- This is Blizzard's way of saying: this item don't exist fool
        if (ItemResult:IsItemEmpty()) then
            itemsLoaded = itemsLoaded + 1;
            lastError = "No item found with identifier " .. itemIdentifier;

            return;
        end

        ItemResult:ContinueOnItemLoad(function()
            itemsLoaded = itemsLoaded + 1;
            local itemId = ItemResult:GetItemID();
            idString = tostring(itemId);

            GL.DB.Cache.ItemsById[idString] = {
                id = itemId,
                name = ItemResult:GetItemName(),
                link = ItemResult:GetItemLink(),
                icon = ItemResult:GetItemIcon(),
                location = ItemResult:GetItemLocation(),
                quality = ItemResult:GetItemQuality(),
                level = ItemResult:GetCurrentItemLevel(),
                inventoryType = ItemResult:GetInventoryType(),
                GUID = ItemResult:GetItemGUID(),
            };

            tinsert(ItemData, GL.DB.Cache.ItemsById[idString]);

            if (not callbackCalled
                and itemsLoaded >= numberOfItemsToLoad
            ) then
                callbackCalled = true;
                callback(ItemData);
                return;
            end
        end)
    end

    --- This might seem like a weird construction, but LUA
    --- does not support continue statements in for loops.
    ---
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
            callback(ItemData);
            return;
        end
    end
end

--- Find the first bag id and slot for a given item id (or false)
---
---@param itemId number
---@return table
function GL:findBagIdAndSlotForItem(itemId)
    for bag = 0, 10 do
        for slot = 1, GetContainerNumSlots(bag) do
            local foundItemLink = GetContainerItemLink(bag,slot)

            if (foundItemLink) then
                local foundItemId = GL:getItemIdFromLink(foundItemLink);

                if (foundItemId and foundItemId == itemId) then
                    return {bag, slot};
                end
            end
        end
    end

    return {};
end

--- Some items have items linked to them. Example: t4 tokens have their quest reward counterpart linked to them.
---
---@param itemId number
---@return table
function GL:getLinkedItemsForId(itemId)
    -- An invalid item id was provided
    itemId = tonumber(itemId);
    if (not GL:higherThanZero(itemId)) then
        return {};
    end

    -- Gather all the item IDs that are linked to our item
    itemId = tostring(itemId);
    local AllLinkedItemIds = {itemId};
    for _, id in pairs(GL.Data.ItemLinks[itemId] or {}) do
        tinsert(AllLinkedItemIds, id);
    end

    return AllLinkedItemIds;
end

--- Return an item's ID from an item link, false if invalid itemlink is provided
---
---@param itemLink string
---@return number|boolean
function GL:getItemIdFromLink(itemLink)
    if (not itemLink
        or type(itemLink) ~= "string"
        or itemLink == ""
    ) then
        return false;
    end

    local _, itemId = strsplit(":", itemLink);
    itemId = tonumber(itemId);

    if (not itemId) then
        return false;
    end

    return itemId;
end

--- Strip the realm off of a string (usually a player name)
---
---@param str string
---@return str
function GL:stripRealm(str)
    str = tostring(str);

    if (self:empty(str)) then
        return "";
    end

    local Parts = self:strSplit(str, "-");

    return Parts[1] or "";
end

--- Check whether the given player name occurs more than once in the player's group
--- (only possible in Era because of cross-realm support)
---
---@param name string
---@return boolean
function GL:nameIsUnique(name)
    if (not GL.isEra) then
        return true;
    end

    name = string.lower(GL:stripRealm(name));
    local nameEncountered = false;
    for _, playerName in pairs(GL.User:groupMemberNames()) do
        local realmFreeName = string.lower(GL:stripRealm(playerName));

        if (realmFreeName == name) then
            if (not nameEncountered) then
                nameEncountered = true;
            else
                return false;
            end
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

--- Split a string by a given delimiter
---
---@param s string
---@param delimiter string
function GL:strSplit(s, delimiter)
    local result = {};

    for match in (s..delimiter):gmatch("(.-)%" .. delimiter) do
        tinsert(result, strtrim(match));
    end

    return result;
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
function GL:playSound(soundNameOrNumber, channel)
    -- Check if the user muted the addon
    if (GL.Settings:get("noSounds")) then
        return;
    end

    if (type(channel) ~= "string"
        or GL:empty(channel)
    ) then
        channel = "Master";
    end

    PlaySound(soundNameOrNumber, channel);
end

local gaveNoMessagesWarning = false;
---@param message string The message you'd like to send
---@param chatType string The type of message (SAY|EMOTE|YELL|PARTY|GUILD|OFFICER|RAID|RAID_WARNING|INSTANCE_CHAT|BATTLEGROUND|WHISPER|CHANNEL|AFK|DND)
---@param language string|nil The language of the message (COMMON|ORCISH|etc), if nil it's COMMON for Alliance and ORCISH for Horde
---@param channel string|nil The channel (numeric) or player (name string) receiving the message
---@return void
function GL:sendChatMessage(message, chatType, language, channel)
    -- The player enabled the noMessages setting
    if (GL.Settings:get("noMessages")) then
        if (not gaveNoMessagesWarning) then
            GL:message("A message was blocked because you have the 'No messages' setting enabled.");
            gaveNoMessagesWarning = true;
        end

        return;
    end

    SendChatMessage (
        message,
        chatType,
        language,
        channel
    );
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
    local random = math.random
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

--- Pad a string to a certain length with another string (left side)
---
---@param str string
---@param padChar string
---@param length number
---@return string
function GL:strPadLeft(str, padChar, length)
    return str .. string.rep(padChar, length - GL:count(str));
end

--- Pad a string to a certain length with another string (right side)
---
---@param str string
---@param padChar string
---@param length number
---@return string
function GL:strPadRight(str, padChar, length)
    return string.rep(padChar, length - GL:count(str)) .. str;
end

--- Get a table value by a given key. Use dot notation to traverse multiple levels e.g:
--- Settings.UI.Auctioneer.offsetX can be fetched using GL:tableGet(myTable, "Settings.UI.Auctioneer.offsetX", 0)
--- without having to worry about tables or keys existing yes or no.
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

    local keys = GL:strSplit(keyString, ".");
    local numberOfKeys = #keys;
    local firstKey = keys[1];

    if (not numberOfKeys or not firstKey) then
        return default;
    end

    if (not Table[firstKey]) then
        return default;
    end

    Table = Table[firstKey];

    -- Changed if (#keys == 1) then to below, saved this just in case we get weird behavior
    if (numberOfKeys == 1) then
        return Table;
    end

    tremove(keys, 1);
    return self:tableGet(Table, strjoin(".", unpack(keys)), default);
end

--- Set a table value by a given key and value. Use dot notation to traverse multiple levels e.g:
--- Settings.UI.Auctioneer.offsetX can be set using GL:tableSet(myTable, "Settings.UI.Auctioneer.offsetX", myValue)
--- without having to worry about tables or keys existing yes or no.
---
---@param Table table
---@param keyString string
---@param value any
---@return boolean
function GL:tableSet(Table, keyString, value)
    if (not keyString
        or type(keyString) ~= "string"
        or keyString == ""
    ) then
        GL:warning("Invalid key provided in GL:tableSet");
        return false;
    end

    local keys = GL:strSplit(keyString, ".");
    local firstKey = keys[1];

    if (#keys == 1) then
        Table[firstKey] = value;
        return true;
    elseif (not Table[firstKey]) then
        Table[firstKey] = {};
    end

    tremove(keys, 1);

    Table = Table[firstKey];
    return self:tableSet(Table, strjoin(".", unpack(keys)), value);
end

GL:debug("Helpers.lua");