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

--- Ranges of code points that fold onto plain ASCII, as { first, last, replacement }
local FoldRanges = {
    { 0xC0, 0xC5, "a", }, { 0xC6, 0xC6, "ae", }, { 0xC7, 0xC7, "c", }, { 0xC8, 0xCB, "e", },
    { 0xCC, 0xCF, "i", }, { 0xD0, 0xD0, "d", }, { 0xD1, 0xD1, "n", }, { 0xD2, 0xD6, "o", },
    { 0xD8, 0xD8, "o", }, { 0xD9, 0xDC, "u", }, { 0xDD, 0xDD, "y", }, { 0xDE, 0xDE, "th", },
    { 0xDF, 0xDF, "ss", }, { 0xE0, 0xE5, "a", }, { 0xE6, 0xE6, "ae", }, { 0xE7, 0xE7, "c", },
    { 0xE8, 0xEB, "e", }, { 0xEC, 0xEF, "i", }, { 0xF0, 0xF0, "d", }, { 0xF1, 0xF1, "n", },
    { 0xF2, 0xF6, "o", }, { 0xF8, 0xF8, "o", }, { 0xF9, 0xFC, "u", }, { 0xFD, 0xFD, "y", },
    { 0xFE, 0xFE, "th", }, { 0xFF, 0xFF, "y", },
    { 0x100, 0x105, "a", }, { 0x106, 0x10D, "c", }, { 0x10E, 0x111, "d", }, { 0x112, 0x11B, "e", },
    { 0x11C, 0x123, "g", }, { 0x124, 0x127, "h", }, { 0x128, 0x131, "i", }, { 0x132, 0x133, "ij", },
    { 0x134, 0x135, "j", }, { 0x136, 0x138, "k", }, { 0x139, 0x142, "l", }, { 0x143, 0x14B, "n", },
    { 0x14C, 0x151, "o", }, { 0x152, 0x153, "oe", }, { 0x154, 0x159, "r", }, { 0x15A, 0x161, "s", },
    { 0x162, 0x167, "t", }, { 0x168, 0x173, "u", }, { 0x174, 0x175, "w", }, { 0x176, 0x178, "y", },
    { 0x179, 0x17E, "z", }, { 0x17F, 0x17F, "s", },
    { 0x218, 0x219, "s", }, { 0x21A, 0x21B, "t", }, -- romanian comma-below
};

local NameFold = {};
for _, Range in ipairs(FoldRanges) do
    for codepoint = Range[1], Range[2] do
        NameFold[codepoint] = Range[3];
    end
end

--- Split a UTF-8 string into its unicode code points
---
---@param str string
---@return table
function GL:utf8Codepoints(str)
    local Codepoints = {};
    local position = 1;
    local length = strlen(str);

    while (position <= length) do
        local leadByte = str:byte(position);
        local codepoint, size;

        -- Anything below 0xC0 is ASCII, or a stray continuation byte we pass through as-is
        if (leadByte < 0xC0) then
            codepoint, size = leadByte, 1;
        elseif (leadByte < 0xE0) then
            codepoint, size = leadByte - 0xC0, 2;
        elseif (leadByte < 0xF0) then
            codepoint, size = leadByte - 0xE0, 3;
        else
            codepoint, size = leadByte - 0xF0, 4;
        end

        for offset = 1, size - 1 do
            codepoint = codepoint * 64 + ((str:byte(position + offset) or 0x80) - 0x80);
        end

        tinsert(Codepoints, codepoint);
        position = position + size;
    end

    return Codepoints;
end

--- Turn a unicode code point back into a UTF-8 string
---
---@param codepoint number
---@return string
function GL:utf8Char(codepoint)
    if (codepoint < 0x80) then
        return strchar(codepoint);
    end

    if (codepoint < 0x800) then
        return strchar(0xC0 + math.floor(codepoint / 0x40), 0x80 + codepoint % 0x40);
    end

    if (codepoint < 0x10000) then
        return strchar(
            0xE0 + math.floor(codepoint / 0x1000),
            0x80 + math.floor(codepoint / 0x40) % 0x40,
            0x80 + codepoint % 0x40
        );
    end

    return strchar(
        0xF0 + math.floor(codepoint / 0x40000),
        0x80 + math.floor(codepoint / 0x1000) % 0x40,
        0x80 + math.floor(codepoint / 0x40) % 0x40,
        0x80 + codepoint % 0x40
    );
end

--- Fold a player name into a plain comparable form: realm stripped, accents
--- removed, lower cased, anything that isn't a letter dropped. Names that only
--- differ in accents, capitalisation, realm or spacing fold to the same string.
---
---@param name string
---@return string
function GL:foldName(name)
    local Folded = {};

    for _, codepoint in ipairs(self:utf8Codepoints(self:stripRealm(tostring(name)))) do
        local replacement = NameFold[codepoint];

        if (replacement) then
            tinsert(Folded, replacement);
        elseif (codepoint >= 0x41 and codepoint <= 0x5A) then -- A-Z
            tinsert(Folded, strchar(codepoint + 0x20));
        elseif (codepoint >= 0x61 and codepoint <= 0x7A) then -- a-z
            tinsert(Folded, strchar(codepoint));
        elseif (codepoint == 0x401) then -- cyrillic Ё
            tinsert(Folded, self:utf8Char(0x451));
        elseif (codepoint >= 0x410 and codepoint <= 0x42F) then -- cyrillic А-Я
            tinsert(Folded, self:utf8Char(codepoint + 0x20));
        elseif (codepoint > 0x7F) then -- any other script, keep it untouched
            tinsert(Folded, self:utf8Char(codepoint));
        end

        -- ASCII digits, spaces and punctuation are dropped entirely
    end

    return table.concat(Folded);
end

--- Number of unicode characters in a string. Differs from strlen on any name
--- that isn't plain ASCII, where one character can be up to four bytes.
---
---@param str string
---@return number
function GL:utf8Length(str)
    return #self:utf8Codepoints(str);
end

--- Damerau-Levenshtein distance, counted in unicode characters instead of bytes
--- so it behaves the same on every realm. Unlike levenshtein, swapping two
--- neighbouring characters costs 1 instead of 2, which is a very common typo.
---
---@param str1 string
---@param str2 string
---@return number
function GL:nameDistance(str1, str2)
    local First = self:utf8Codepoints(str1);
    local Second = self:utf8Codepoints(str2);
    local len1, len2 = #First, #Second;

    if (len1 == 0) then
        return len2;
    end

    if (len2 == 0) then
        return len1;
    end

    local Matrix = {};
    for i = 0, len1 do
        Matrix[i] = { [0] = i, };
    end

    for j = 0, len2 do
        Matrix[0][j] = j;
    end

    for i = 1, len1 do
        for j = 1, len2 do
            local cost = First[i] == Second[j] and 0 or 1;
            Matrix[i][j] = math.min(Matrix[i - 1][j] + 1, Matrix[i][j - 1] + 1, Matrix[i - 1][j - 1] + cost);

            -- Two neighbouring characters were swapped around
            if (i > 1 and j > 1
                and First[i] == Second[j - 1]
                and First[i - 1] == Second[j]
            ) then
                Matrix[i][j] = math.min(Matrix[i][j], Matrix[i - 2][j - 2] + 1);
            end
        end
    end

    return Matrix[len1][len2];
end

--- Whether fuzzy matching makes sense for a name. Logographic and syllabic
--- scripts pack far more meaning into one character, so a single difference
--- there is a different person rather than a typo.
---
---@param name string
---@return boolean
function GL:nameIsFuzzyMatchable(name)
    for _, codepoint in ipairs(self:utf8Codepoints(name)) do
        if ((codepoint >= 0x1100 and codepoint <= 0x11FF) -- hangul jamo
            or (codepoint >= 0x3040 and codepoint <= 0x30FF) -- hiragana and katakana
            or (codepoint >= 0x3400 and codepoint <= 0x4DBF) -- cjk extension a
            or (codepoint >= 0x4E00 and codepoint <= 0x9FFF) -- cjk unified
            or (codepoint >= 0xAC00 and codepoint <= 0xD7A3) -- hangul syllables
        ) then
            return false;
        end
    end

    return true;
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

--- Turn a given wow pattern into something we can use in string.match
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
        pattern = string.gsub(pattern, "%%%d%$s", "(.-)");
    else
        pattern = string.gsub(pattern, "%%%d%$s", "(.+)");
    end

    return string.gsub(pattern, "%%%d$d", "%(%%d-%)");
end
