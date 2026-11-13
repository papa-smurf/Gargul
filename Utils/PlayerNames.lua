---@type GL
local _, GL = ...;

-- Forever has no realms, every character has a last name instead: "Cline Gloomhaunt".
-- UnitName returns the last name where the realm normally goes, GetRealmName() is just a server label.
-- Gargul stores "Cline Gloomhaunt". Whispers, invites and mail get "Cline-Gloomhaunt" (see unitPlayerName),
-- Unit* functions and anything that targets a group member (SetLootMethod, UninviteUnit) only resolve "Cline Gloomhaunt".

local function capitalizeWords(value)
    local Words = {};

    for word in tostring(value):gmatch("%S+") do
        table.insert(Words, (word:gsub("^%l", strupper)));
    end

    return table.concat(Words, " ");
end

--- Is this the server label GetRealmName() returns (spaces and hyphens ignored)?
---
---@param value? string
---@return boolean
local function isRealmName(value)
    if (type(value) ~= "string" or value == "") then
        return false;
    end

    local realm = (GetRealmName() or ""):gsub("[%s%-]", "");

    return realm ~= "" and GL:iEquals(value:gsub("[%s%-]", ""), realm);
end

--- "Cline", "Gloomhaunt" becomes "Cline Gloomhaunt". A server label instead of a last name is dropped.
---
---@param firstName? string
---@param lastName? string
---@return string
local function combineFirstAndLastName(firstName, lastName)
    if (type(firstName) ~= "string" or firstName == "") then
        return "";
    end

    if (type(lastName) == "string"
        and lastName ~= ""
        and not isRealmName(lastName)
        and not strfind(firstName, " ", 1, true)
        and not strfind(firstName, "-", 1, true)
    ) then
        return firstName .. " " .. lastName;
    end

    return firstName;
end

--- The spelling Gargul stores, e.g. "Cline-Gloomhaunt-ClassicBetaPvP2" becomes "Cline Gloomhaunt". No-op outside Forever.
---
---@param playerName? string
---@return string
function GL:storedPlayerName(playerName)
    if (type(playerName) ~= "string" or playerName == "") then
        return "";
    end

    if (not GL.isForever) then
        return playerName;
    end

    playerName = strtrim(playerName);

    local beforeHyphen, afterHyphen = strmatch(playerName, "^(.*)%-(.+)$");

    if (beforeHyphen and beforeHyphen ~= "" and isRealmName(afterHyphen)) then
        playerName = beforeHyphen;
    end

    if (not strfind(playerName, " ", 1, true)) then
        local firstName, lastName = strmatch(playerName, "^([^%-]+)%-(.+)$");

        if (firstName and lastName) then
            playerName = firstName .. " " .. lastName;
        end
    end

    return playerName;
end

--- The spelling whisper, invite and mail functions want, e.g. "Cline Gloomhaunt" becomes "Cline-Gloomhaunt". No-op outside Forever.
--- Never pass this to Unit* functions, those need the stored spelling (see storedPlayerName).
---
---@param playerName? string
---@return string?
function GL:unitPlayerName(playerName)
    if (not GL.isForever or type(playerName) ~= "string" or playerName == "") then
        return playerName;
    end

    local storedName = self:storedPlayerName(playerName);
    local firstName, lastName = strmatch(storedName, "^(%S+)%s+(.+)$");

    if (firstName and lastName) then
        return firstName .. "-" .. lastName;
    end

    return storedName;
end

--- A unit's name, including the last name on Forever
---
---@param unit string
---@return string?
function GL:playerNameFromUnit(unit)
    local firstName, lastName = UnitName(unit);

    if (not firstName or firstName == "") then
        return nil;
    end

    if (not GL.isForever) then
        return firstName;
    end

    return self:storedPlayerName(combineFirstAndLastName(firstName, lastName));
end

--- A player's name by GUID, including the last name on Forever
---
---@param GUID string
---@return string?
function GL:playerNameFromGUID(GUID)
    if (type(GUID) ~= "string" or GUID == "") then
        return nil;
    end

    -- GetPlayerInfoByGUID isn't guaranteed to return the last name, a unit's UnitName is
    if (GL.isForever) then
        if (UnitGUID("player") == GUID) then
            return self:playerNameFromUnit("player");
        end

        local unitPrefix = IsInRaid() and "raid" or "party";
        for index = 1, GetNumGroupMembers() do
            local unit = unitPrefix .. index;

            if (UnitGUID(unit) == GUID) then
                return self:playerNameFromUnit(unit);
            end
        end
    end

    local _, _, _, _, _, name, realm = GetPlayerInfoByGUID(GUID);

    if (type(name) ~= "string" or name == "") then
        return nil;
    end

    return self:formatPlayerName(name, { realm = realm, });
end

--- Use this instead of iEquals when comparing player names
---
---@param left? string
---@param right? string
---@return boolean
function GL:playerNamesMatch(left, right)
    if (not GL.isForever) then
        return self:iEquals(left, right);
    end

    if (type(left) ~= "string" or type(right) ~= "string") then
        return false;
    end

    return self:iEquals(self:storedPlayerName(left), self:storedPlayerName(right));
end

--- On Forever, turn a first name like "Cline" into "Cline Gloomhaunt" if exactly one group member is called Cline
---
---@param rosterName? string
---@return string?
function GL:groupMemberIdentity(rosterName)
    if (not GL.isForever or type(rosterName) ~= "string" or rosterName == "") then
        return rosterName;
    end

    local storedName = self:storedPlayerName(rosterName);

    if (strfind(storedName, " ", 1, true)) then
        return storedName;
    end

    local Matches = {};
    local function consider(unit)
        local fullName = self:playerNameFromUnit(unit);

        if (fullName
            and strfind(fullName, " ", 1, true)
            and self:playerNamesMatch(UnitName(unit), rosterName)
        ) then
            Matches[strlower(fullName)] = fullName;
        end
    end

    consider("player");

    local unitPrefix = IsInRaid() and "raid" or "party";
    for index = 1, GetNumGroupMembers() do
        consider(unitPrefix .. index);
    end

    local match, numberOfMatches = nil, 0;
    for _, fullName in pairs(Matches) do
        match = fullName;
        numberOfMatches = numberOfMatches + 1;
    end

    return numberOfMatches == 1 and match or storedName;
end

---@class FormatPlayerNameOptions
---@field realm? string Override the realm value
---@field includeRealm? "always"|"never"|"auto" Realm inclusion (default: "auto")
---  - "always": Always include realm (e.g., "Player-Realm")
---  - "never": Never include realm (e.g., "Player")
---  - "auto": Include only when different from yours (e.g., "Player-OtherRealm")
---@field colorize? boolean Use class color (default: false)
---@field defaultColor? string Hex color when class unknown
---@field class? string Class file for colorizing (e.g. "DRUID")
---@field decorator? function|function[] Post-process functions (e.g. strlower)

--- Format player name with optional styling and realm handling (on Forever Options.realm is treated as a last name).
--- Usage: GL:formatPlayerName("PlayerName") or GL:formatPlayerName("PlayerName", { colorize = true, })
---
---@param name string Required player name
---@param Options? FormatPlayerNameOptions Optional overrides
---@return string
function GL:formatPlayerName(name, Options)
    if (not name or type(name) ~= "string" or name == "") then
        return "";
    end

    Options = Options or {};

    local realmOverride = Options.realm ~= "" and Options.realm or nil;
    local includeRealm = Options.includeRealm or "auto";
    local colorize = Options.colorize;
    local defaultColor = Options.defaultColor;
    local class = Options.class;
    local Decorators = Options.decorator;
    Decorators = (type(Decorators) == "table" and Decorators) or (Decorators and { Decorators } or {});

    if (GL.isForever) then
        name = capitalizeWords(self:storedPlayerName(combineFirstAndLastName(name, realmOverride)));

        if (colorize) then
            class = class or UnitClassBase(name);
        end
    else
        local realm;
        name, realm = self:stripRealm(name);
        local nameWithoutRealm = name;
        realm = realmOverride or realm;
        name = realm and ("%s-%s"):format(self:capitalize(name), self:capitalize(realm)) or self:capitalize(name);

        -- Handle realm inclusion mode
        if (includeRealm == "never") then
            name = self:stripRealm(name);
        elseif (includeRealm == "always") then
            name, realm = self:addRealm(name);
        elseif (includeRealm == "auto") then
            -- Include realm only if different from ours
            if (realm and self:iEquals(realm, GL.User.realm)) then
                name = self:stripRealm(name);
            end
        end

        if (colorize) then
            class = class or UnitClassBase(name);

            -- UnitClassBase doesn't work on FQNs on the same realm
            if (not class and realm and self:iEquals(realm, GL.User.realm)) then
                class = UnitClassBase(nameWithoutRealm);
            end
        end

        name = self:capitalize(name);
    end

    if (colorize) then
        if (not class) then
            name = ("|c00%s%s|r"):format(defaultColor or "FFFFFF", name);
        else
            name = self:classColorize(name, class);
        end
    end

    name = strtrim(name);
    for _, strFunc in pairs(Decorators) do
        if (strFunc) then
            name = strFunc(name);
        end
    end

    return name;
end

--- Disambiguate a given name, passing optional formatPlayerName arguments
---
---@param name string
---@param Options? FormatPlayerNameOptions formatPlayerName options (see GL:formatPlayerName)
---@return string
function GL:disambiguateName(name, Options)
    Options = Options or {};

    return self:nameIsUnique(name)
        and self:formatPlayerName(name, self:tableMerge(Options, { includeRealm = "never", }))
        or self:formatPlayerName(name, self:tableMerge(Options, { includeRealm = "always", }))
end

--- Strip the realm off of a player name
---
---@param playerName string
---@return string, string?
function GL:stripRealm(playerName)
    playerName = tostring(playerName);

    if (self:empty(playerName)) then
        return "";
    end

    -- On Forever "Cline-Gloomhaunt" is a last name, not a realm
    if (GL.isForever) then
        return self:storedPlayerName(playerName), nil;
    end

    local separator = playerName:match("-");

    -- No realm separator was found, return the original message
    if (not separator) then
        return playerName;
    end

    local Parts = self:explode(playerName, separator);
    return Parts[1], Parts[2];
end

--- Add a realm to a player name if one isn't present (on Forever only a last name is added, never the server label)
---
---@param name string
---@param realm? string
---@param fromGroup? boolean
---@return string, string?
function GL:addRealm(name, realm, fromGroup)
    if (GL.isForever) then
        return self:storedPlayerName(combineFirstAndLastName(name, realm)), nil;
    end

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

    -- Fetch the realm name from a group member if possible
    if (fromGroup
        and not realm
        and GL.User:unitInGroup(name)
    ) then
        if (GL:nameIsUnique(name)) then
            local playerID = UnitGUID(name);

            if (playerID) then
                realm = select(7, GetPlayerInfoByGUID(playerID));

                -- Realm can be an empty string on same-realm players
                realm = realm ~= "" and realm or GL.User.realm;
            end
        end
    end

    realm = realm or GL.User.realm;
    return ("%s-%s"):format(name, realm), realm;
end

--- Get the realm from a given player name
---
---@param playerName string
---@return string|boolean
function GL:getRealmFromName(playerName)
    playerName = tostring(playerName);

    if (self:empty(playerName)) then
        return false;
    end

    -- On Forever "Cline-Gloomhaunt" is a last name, only a trailing server label counts
    if (GL.isForever) then
        local _, afterHyphen = strmatch(playerName, "^(.*)%-(.+)$");

        return isRealmName(afterHyphen) and afterHyphen or false;
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
    playerName = GL:stripRealm(playerName);
    local nameEncountered = false;
    for _, groupMemberName in pairs(GL.User:groupMemberNames()) do
        if (self:playerNamesMatch(playerName, groupMemberName)) then
            -- We already encountered this name before, NOT UNIQUE!
            if (nameEncountered) then
                return false;
            end

            nameEncountered = true;
        end
    end

    return true;
end

--- Normalize a player name (add realm if Era, lowercase)
---
---@param playerName string
---@return string
function GL:normalizedName(playerName)
    GL:debug("GL:normalizedName");

    if (GL.isForever) then
        return strlower(self:storedPlayerName(playerName));
    end

    if (GL.isEra and not strfind(playerName, "-")) then
        playerName = ("%s-%s"):format(playerName, GL.User.realm);
    end

    return strlower(playerName);
end

--- Lowercased stored spelling, use this for table keys so "Cline-Gloomhaunt" and "Cline Gloomhaunt" share one on Forever. Plain strlower elsewhere.
---
---@param playerName? string
---@return string
function GL:playerNameKey(playerName)
    return strlower(self:storedPlayerName(playerName));
end

--- Get a player's class by name
---
---@param name string
---@param default? string Default class if not found (default: "PRIEST")
---@return string
function GL:playerClassByName(name, default)
    local class = UnitClassBase(self:storedPlayerName(name));

    if (class) then
        return class;
    end

    -- UnitClassBase doesn't work on same-realm FQNs
    local nameWithoutRealm, realm = GL:stripRealm(name);

    if (realm and GL:iEquals(realm, GL.User.realm)) then
        class = UnitClassBase(nameWithoutRealm);
    end

    if (class) then
        return class;
    end

    -- The player's class could not be determined, return default
    return default ~= nil and default or "PRIEST";
end

--- Check if player is on a cross-realm / connected realm
--- Everything is considered crossrealm now, keeping func for backwards compatibility
---
---@return boolean
function GL:isCrossRealm()
    if (true) then
        return true;
    end

    if (GL._isCrossRealm == nil) then
        GL._isCrossRealm = GL.isRetail or not not GetAutoCompleteRealms()[2];
    end

    return GL._isCrossRealm;
end
