---@type GL
local _, GL = ...;

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

--- Format player name with optional styling and realm handling.
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

        if (not class) then
            name = ("|c00%s%s|r"):format(defaultColor or "FFFFFF", name);
        else
            name = self:classColorize(name, class);
        end
    end

    name = strtrim(self:capitalize(name));
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

    local separator = playerName:match("-");

    -- No realm separator was found, return the original message
    if (not separator) then
        return playerName;
    end

    local Parts = self:explode(playerName, separator);
    return Parts[1], Parts[2];
end

--- Add a realm to a player name if one isn't present
---
---@param name string
---@param realm? string
---@param fromGroup? boolean
---@return string, string?
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

--- Normalize a player name (add realm if Era, lowercase)
---
---@param playerName string
---@return string
function GL:normalizedName(playerName)
    GL:debug("GL:normalizedName");

    if (GL.isEra and not strfind(playerName, "-")) then
        playerName = ("%s-%s"):format(playerName, GL.User.realm);
    end

    return strlower(playerName);
end

--- Get a player's class by name
---
---@param name string
---@param default? string Default class if not found (default: "PRIEST")
---@return string
function GL:playerClassByName(name, default)
    local class = UnitClassBase(name);

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
---
---@return boolean
function GL:isCrossRealm()
    -- With almost everything being connected nowadays we're doing a trial
    -- run with always assuming that we're on a connected realm
    ---@TODO: REMOVE IN >= 7.7.0
    if (true) then
        return true;
    end

    if (GL._isCrossRealm == nil) then
        GL._isCrossRealm = GL.isRetail or not not GetAutoCompleteRealms()[2];
    end

    return GL._isCrossRealm;
end
