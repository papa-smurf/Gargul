---@type GL
local _, GL = ...;

--- Overwrite/compliment the original table (left) with the values from the right table
---
---@param left table
---@param right table
---@return table
function GL:tableMerge(left, right)
    if (type(left) ~= "table" or type(right) ~= "table") then
        return {};
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

--- Concat two non-associative tables to one another
---
---@param Table table
---@param Concat table
---@return table
function GL:tableConcat(Table, Concat)
    if (type(Table) ~= "table" or type(Concat) ~= "table") then
        return {};
    end

    for i = 1, #Concat do
        Table[#Table+1] = Concat[i];
    end

    return Table
end

--- Clone a table recursively (no metatable properties)
---
---@param Original table
---@return table
function GL:cloneTable(Original)
    local Copy = {};

    for index, value in pairs(Original or {}) do
        if (type(value) == "table") then
            Copy[index] = self:cloneTable(value, Copy[index])
        else
            Copy[index] = value
        end
    end

    return Copy;
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

--- Check whether a given value exists within a table
---
---@param array table
---@param value any
function GL:inTable(array, value)
    if (type(value) == "string") then
        value = strtrim(strlower(value));
    end

    for _, val in pairs(array) do
        if (type(val) == "string") then
            val = strtrim(strlower(val));
        end

        if value == val then
            return true
        end
    end

    return false
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

--- Apply a user supplied function to every member of a table
---
---@param Table table
---@param callback function
---@return nil
function GL:tableWalk(Table, callback, ...)
    for key, Value in pairs(Table) do
        callback(key, Value, ...);
    end
end;

--- Counting tables (or arrays if you will) is anything but straight-forward in LUA. Examples:
--- #{test = "value", test2 = "value2"} -> results in 0
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
