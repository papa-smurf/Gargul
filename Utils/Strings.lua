---@type GL
local _, GL = ...;

--- Capitalize a given value (e.g. gargul becomes Gargul)
---
---@param value string
---@return string
function GL:capitalize(value)
    return (value:gsub("^%l", strupper));
end

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
        s:gsub(".",function (character) table.insert(Result, character); end);
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
    local len = strlen(text);

    for i = 1, len, 3 do
        counter = math.fmod(counter*8161, 4294967279) +  -- 2^32 - 17: Prime!
            (string.byte(text,i)*16776193) +
            ((string.byte(text,i+1) or (len-i+256))*8372226) +
            ((string.byte(text,i+2) or (len-i+256))*3932164);
    end

    return math.fmod(counter, 4294967291); -- 2^32 - 5: Prime (and different from the prime in the loop)
end

--- Levenshtein string distance
---
---@param str1 string
---@param str2 string
---
---@return number
function GL:levenshtein(str1, str2)
    local len1 = strlen(str1);
    local len2 = strlen(str2);
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

--- Check whether the provided string starts with a given substring
---
---@param str string
---@param startStr string
---@param insensitive boolean|nil
---@return boolean
function GL:strStartsWith(str, startStr, insensitive)
    str = tostring(str);
    startStr = tostring(startStr);

    if (insensitive ~= false) then
        str = strlower(str);
        startStr = strlower(startStr);
    end

    return strsub(str, 1, strlen(startStr)) == startStr;
end

--- Check whether the provided string ends with a given substring
---
---@param str string
---@param endStr string
---@return boolean
function GL:strEndsWith(str, endStr)
    return strsub(str,-(strlen(endStr))) == endStr;
end

---@param str string
---@param Tab table
---
---@return string
function GL:printfn(str, Tab)
    return Tab
        and str:gsub("($%b{})", function (match) return Tab[match:sub(3, -2)] or match; end)
        or str;
end

--- Check whether the provided string contains a given substring
---
---@param str string
---@param subStr string
---@param insensitive? boolean
---@return boolean
function GL:strContains(str, subStr, insensitive)
    if (insensitive ~= false) then
        str = strlower(str);
        subStr = strlower(subStr);
    end

    return GL:toboolean(strfind(str, subStr));
end

--- URL Decode a given url string
---
---@param url string
---@return string
function GL:urlDecode(url)
    local hexToChar = function (x)
        return strchar(tonumber(x, 16));
    end

    if (url == nil) then
        return "";
    end

    url = url:gsub("+", " ");
    return url:gsub("%%(%x%x)", hexToChar);
end

--- Limit a given string to a maximum number of characters
---
---@param str string
---@param limit number
---@param append string|nil
---
---@return string
function GL:strLimit(str, limit, append)
    local strLength = strlen(str);

    -- The string is not too long, just return it
    if (strLength <= limit) then
        return str;
    end

    append = append or "...";
    local appendLength = strlen(append);

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

--- Turn a given wow pattern into something we can use in strmatch
---
---@param pattern string
---@param maximize boolean|nil
---@return string
function GL:createPattern(pattern, maximize)
    pattern = string.gsub(pattern, "[%(%)%-%+%[%]]", "%%%1");

    pattern = string.gsub(pattern, "%%c", "%+");

    if (not maximize) then
        pattern = string.gsub(pattern, "%%s", "(.-)");
    else
        pattern = string.gsub(pattern, "%%s", "(.+)");
    end

    pattern = string.gsub(pattern, "%%d", "%(%%d-%)");

    if (not maximize) then
        pattern = string.gsub(pattern, "%%(%d)$s", "%(%%d-%%)");
    else
        pattern = string.gsub(pattern, "%%(%d)$s", "%(%%d+%%)");
    end

    return pattern;
end
