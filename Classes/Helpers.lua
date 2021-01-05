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

-- Print a success message (green)
function App:success(...)
    App:coloredMessage("92FF00", ...);
end

-- Print a debug message (orange)
function App:debug(...)
    local message = string.join(" ", ...);
    App.DebugLines[#App.DebugLines + 1] = message;

    if (App.debugEnabled) then
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

-- Print large quantities of text to a multiline editbox
-- Very useful for debugging purposes, should not be used for anything else
function App:frameMessage(message)
    if (type(message) == "table") then
        message = App.JSON:encode(message);
    end

    -- Create a container/parent frame
    local StacktraceFrame = AceGUI:Create("Frame");
    StacktraceFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget); end);
    StacktraceFrame:SetTitle("Gargul v" .. App.version);
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

-- Serialize and compress a payload
function App:compress(payload)
--    local serialized = App.JSON:encode(payload);
    local serialized = App.Ace:Serialize(payload);
    local compressed = App.Compressor:CompressHuffman(serialized);
    local encoded = App.Compressor.EncodeTable:Encode(compressed);

    return encoded;
end

-- Decompress and deserialize a payload
function App:decompress(encoded)
    local compressed = App.Compressor.EncodeTable:Decode(encoded);

    if (not compressed) then
        App:warning("Something went wrong while decoding the COMM payload");
        return;
    end

    local serialized = App.Compressor:DecompressHuffman(compressed);

    if (not serialized) then
        App:warning("Something went wrong while decompressing the COMM payload");
        return;
    end

    local success, payload = App.Ace:Deserialize(serialized);

    if (not success) then
        App:warning("Something went wrong while deserializing the COMM payload");
        return;
    elseif (not payload) then
        App:warning("The COMM payload appears to be empty");
        return;
    end

    return payload;
end

-- Split a string by a given delimiter
function App:strSplit(s, delimiter)
    local result = {};

    for match in (s..delimiter):gmatch("(.-)%" .. delimiter) do
        result[#result + 1] = match;
    end

    return result;
end

-- Generate a random (enough) uuid
local random = math.random
function App:uuid()
    local template = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx";
    return string.gsub(template, "[xy]", function (c)
        local v = (c == "x") and random(0, 0xf) or random(8, 0xb);
        return string.format("%x", v);
    end)
end

-- Pattern generator
-- Useful for transforming wow api constants
-- to patterns suitable for string matching etc
function App:createPattern(pattern, maximize)
    pattern = string.gsub(pattern, "[%(%)%-%+%[%]]", "%%%1");

    if not maximize then
        pattern = string.gsub(pattern, "%%s", "(.-)");
    else
        pattern = string.gsub(pattern, "%%s", "(.+)");
    end

    pattern = string.gsub(pattern, "%%d", "%(%%d-%)");
    if not maximize then
        pattern = string.gsub(pattern, "%%%d%$s", "(.-)")
    else
        pattern = string.gsub(pattern, "%%%d%$s", "(.+)")
    end

    return string.gsub(pattern, "%%%d$d", "%(%%d-%)");
end

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
function App:flipTable(Table)
    local Flipped = {};
    for key, value in pairs(Table) do
        Flipped[value] = key;
    end

    return Flipped;
end

-- Get a table value by a given key. Use dot notation to traverse multiple levels e.g:
-- Settings.UI.Auctioneer.offsetX can be fetched using App:tableGet(myTable, "Settings.UI.Auctioneer.offsetX", 0)
-- without having to worry about tables or keys existing yes or no.
function App:tableGet(table, keyString, default)
    if (not keyString
            or type(keyString) ~= "string"
            or keyString == ""
    ) then
        return App:warning("Invalid key provided in App:tableGet");
    end

    local keys = App:strSplit(keyString, ".");
    local numberOfKeys = #keys;
    local firstKey = keys[1];

    if (not numberOfKeys or not firstKey) then
        return App:warning("Invalid key provided in App:tableGet");
    end

    if (not table[firstKey]) then
        return nil;
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