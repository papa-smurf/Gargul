local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
local AceGUI = App.Ace.GUI;

-- Print a normal message (white)
function App:message(...)
    print("|cff8aecffGargul: |r" .. string.join(" ", ...));
end

-- Print a colored message
function App:coloredMessage (color, ...)
    App:message(string.format("|c00%s%s", color, string.join(" ", ...)));
end

-- Print a multicolored message
-- ColoredMessages is an array of arrays, with the message
-- being in the first and the color being in the second position
-- e.g. App:multiColoredMessage({{"message", "color"},{"message2", "color2"}});
function App:multiColoredMessage (ColoredMessages, delimiter)
    local multiColoredMessage = "";
    delimiter = delimiter or " ";

    local firstMessage = true;
    for _, envelope in pairs(ColoredMessages) do
        local message = envelope[1];
        local color = envelope[2];

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

    App:message(multiColoredMessage);
end

-- Print a success message (green)
function App:success(...)
    App:coloredMessage("92FF00", ...);
end

-- Print a debug message (orange)
function App:debug(...)
    local message = string.join(" ", ...);
    tinsert(App.DebugLines, message);

    if (App.Settings
        and App.Settings:get("debugModeEnabled")
    ) then
        App:coloredMessage("f7922e", ...);
    end
end

-- Print a warning message (orange)
function App:warning(...)
    App:coloredMessage("f7922e", ...);
end

-- Print a error message (red)
function App:error(...)
    App:coloredMessage("be3333", ...);
end

function App:capitalize(value)
    return (value:gsub("^%l", string.upper));
end

-- Dump a variable (functions won't work!)
function App:dump(mixed)
    local success, encoded = pcall(function () return App.JSON:encode(mixed); end);

    if (not success) then
        App:error("Unable to encode payload provided in App:dump");
        return;
    end

    App:message(encoded);
end

-- Print a table to the console
function App:printTable( t )
    local printTable_cache = {}

    local function sub_printTable( t, indent )
        if ( printTable_cache[tostring(t)] ) then
            print( indent .. "*" .. tostring(t) )
        else
            printTable_cache[tostring(t)] = true
            if ( type( t ) == "table" ) then
                for pos,val in pairs( t ) do
                    if ( type(val) == "table" ) then
                        print( indent .. "[" .. pos .. "] => " .. tostring( t ).. " {" )
                        sub_printTable( val, indent .. string.rep( " ", string.len(pos)+8 ) )
                        print( indent .. string.rep( " ", string.len(pos)+6 ) .. "}" )
                    elseif ( type(val) == "string" ) then
                        print( indent .. "[" .. pos .. '] => "' .. val .. '"' )
                    else
                        print( indent .. "[" .. pos .. "] => " .. tostring(val) )
                    end
                end
            else
                print( indent..tostring(t) )
            end
        end
    end

    if ( type(t) == "table" ) then
        print( tostring(t) .. " {" )
        sub_printTable( t, "  " )
        print( "}" )
    else
        sub_printTable( t, "  " )
    end
end

-- Clone a table
function App:cloneTable(original)
    return {unpack(original)};
end

-- Display all debug lines
function App:stacktrace()
    local debugLines = "";

    for key in pairs(App.DebugLines) do
        debugLines = debugLines .. App.DebugLines[key] .. "\r\n";
    end

    return self:frameMessage(debugLines);
end

-- Clears the provided scrolling table (lib-ScrollingTable)
function App:clearScrollTable(ScrollingTable)
    ScrollingTable:SetData({}, true);
    ScrollingTable.frame:Hide();
    ScrollingTable:Hide();
    ScrollingTable.frame = nil;
    ScrollingTable = nil;
end

-- Check if a player with a given player name is
-- in the same group as the current App.User
function App:playerIsInSameGroup(playerName)
    if (not playerName
        or not App.User.isInGroup
        or type(playerName) ~= "string"
        or playerName == ""
    ) then
        return false
    end

    -- Loop through all members of the group (party or raid)
    for index = 1, MAX_RAID_MEMBERS do
        local name, _, _, _, _, _,
        _, online = GetRaidRosterInfo(index);

        if (name and online) then
            if (name == playerName) then
                return true;
            end
        end
    end

    return false;
end

-- Print large quantities of text to a multiline editbox
-- Very useful for debugging purposes, should not be used for anything else
function App:frameMessage(message)
    if (type(message) == "table") then
        message = App.JSON:encode(message);
    end

    -- Create a container/parent frame
    local StacktraceFrame = AceGUI:Create("Frame");
    StacktraceFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget); end);
    StacktraceFrame:SetTitle(App.name .. " v" .. App.version);
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
    StacktraceBox:SetMaxLetters(999999999);
    StacktraceFrame:AddChild(StacktraceBox);
end

local ItemsFetchedForLocalCache = {};
function App:getItemInfoFromLink(rawItemLink)
    App:debug("App:getItemInfoFromLink");

    if (not rawItemLink
        or not type(rawItemLink) == "string"
        or rawItemLink == ""
    ) then
        App:debug("itemLink is invalid in App:getItemInfoFromLink");
        return false;
    end

    local itemId = self:getItemIdFromLink(rawItemLink);

    if (not itemId) then
        App:debug("itemLink is invalid in App:getItemInfoFromLink");
        return false;
    end

    local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
    itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID,
    isCraftingReagent = GetItemInfo('"' .. rawItemLink .. '"');

    if (not itemName) then
        App:debug("Couldn't retrieve item name in App:getItemInfoFromLink using " .. rawItemLink);
        return false;
    end

    return true, itemId, itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount,
    itemEquipLoc, itemIcon, itemSellPrice, itemClassID, itemSubClassID, bindType, expacID, itemSetID,
    isCraftingReagent;
end

-- Return an item's ID from an item link
function App:getItemIdFromLink(itemLink)
    if (not itemLink or itemLink == "") then
        return false;
    end

    local itemId = strsub(itemLink, string.find(itemLink, 'Hitem:') + 6, string.find(itemLink, ':', string.find(itemLink, 'Hitem:') + 6) -1);

    if (not itemId) then
        return false;
    end

    return itemId;
end

-- Check whether a given string
function App:strIsItemLink(s)
    return not App:getItemIdFromLink(s) == false;
end

-- Split a string by a given delimiter
function App:strSplit(s, delimiter)
    local result = {};

    for match in (s..delimiter):gmatch("(.-)%" .. delimiter) do
        tinsert(result, strtrim(match));
    end

    return result;
end

-- Play a sound
function App:playSound(soundName, channel)
    -- Check if the user muted the addon
    if (App.Settings:get("muted")) then
        return;
    end

    PlaySound(soundName, channel);
end

-- Check if a given array contains a given value
function App:inArray(array, value)
    local lowerValue = string.lower(value);

    for index, val in ipairs(array) do
        local lowerVal = string.lower(val);

        if lowerValue == lowerVal then
            return true
        end
    end

    return false
end

-- Generate a random (enough) uuid
function App:uuid()
    local random = math.random
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx";

    return string.gsub(template, "[xy]", function (c)
        local v = (c == "x") and random(0, 0xf) or random(8, 0xb);
        return string.format("%x", v);
    end)
end

-- Overwrite/compliment the original table (left) with the values from the right table
function App:tableMerge(left, right)
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

-- Simple table flip
function App:tableFlip(Table)
    local Flipped = {};
    for key, value in pairs(Table) do
        Flipped[value] = key;
    end

    return Flipped;
end

-- Table slice method
function App:tableSlice(tbl, offset, length, preserveKeys)
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
        for key, value in pairs(tbl) do
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
        if (type(tbl[index]) == "nil") then
            return Slice;
        end

        tinsert(Slice, tbl[index]);
    end

    return Slice;
end

-- Get a table value by a given key. Use dot notation to traverse multiple levels e.g:
-- Settings.UI.Auctioneer.offsetX can be fetched using App:tableGet(myTable, "Settings.UI.Auctioneer.offsetX", 0)
-- without having to worry about tables or keys existing yes or no.
function App:tableGet(table, keyString, default)
    if (not keyString
            or type(keyString) ~= "string"
            or keyString == ""
    ) then
        App:warning("Invalid key provided in App:tableGet");
        return default;
    end

    local keys = App:strSplit(keyString, ".");
    local numberOfKeys = #keys;
    local firstKey = keys[1];

    if (not numberOfKeys or not firstKey) then
        App:warning("Invalid key provided in App:tableGet");
        return default;
    end

    if (not table[firstKey]) then
        return default;
    end

    table = table[firstKey];

    if (#keys == 1) then
        return table;
    end

    tremove(keys, 1);

    return self:tableGet(table, strjoin(".", unpack(keys)), default);
end

-- Set a table value by a given key and value. Use dot notation to traverse multiple levels e.g:
-- Settings.UI.Auctioneer.offsetX can be set using App:tableSet(myTable, "Settings.UI.Auctioneer.offsetX", myValue)
-- without having to worry about tables or keys existing yes or no.
function App:tableSet(table, keyString, value)
    if (not keyString
            or type(keyString) ~= "string"
            or keyString == ""
    ) then
        App:warning("Invalid key provided in App:tableSet");
        return false;
    end

    local keys = App:strSplit(keyString, ".");
    local firstKey = keys[1];

    if (#keys == 1) then
        table[firstKey] = value;
        return true;
    elseif (not table[firstKey]) then
        table[firstKey] = {};
    end

    tremove(keys, 1);

    table = table[firstKey];
    return self:tableSet(table, strjoin(".", unpack(keys)), value);
end

App:debug("Helpers.lua");