local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Constants
local Constants = GL.Data.Constants;

---@type CommActions
local CommActions = Constants.Comm.Actions;

---@type Settings
local Settings = GL.Settings;

---@type Events
local Events = GL.Events;

---@class TMB
local TMB = {
    _initialized = false,
    broadcastInProgress = false,
    lastTooltipData = nil,
    lastTooltipItemLink = nil,
    lastTooltipTime = nil,
    requestingData = false,
};
GL.TMB = TMB;

local OFFSPEC_IDENTIFIER = "%(os%)";

-- Character names can include realm names, which can contain spaces and hyphens
---@param name string
---@return string
function TMB:normalizePlayerName(name)
    name = name:lower();

    -- Remove whitespaces
    name = name:gsub("%s+", "");

    -- Remove consecutive hyphens, leaving the first intact
    local firstHypenPosition = name:find("-");

    if (not firstHypenPosition) then
        return name;
    end

    local namePart = name:sub(1, firstHypenPosition);
    local realmPart = name:sub(namePart:len() + 1, name:len());

    return namePart .. realmPart:gsub("-", "");
end

---@return boolean
function TMB:_init()
    if (self._initialized) then
        return false;
    end
    self._initialized = true;

    Events:register("TMBUserJoinedGroupListener", "GL.USER_JOINED_NEW_GROUP", function () self:requestData(); end);

    -- If the user reloads instead of a login we have to wait a couple seconds for the game to update the group setup
    GL:after(5, "TMBRequestDataAfterReload", function ()
        if (not GL.User.isInGroup) then
            return;
        end

        -- Check if we need to sync up with an existing multi-auction session
        self:requestData();
    end);
end

--- Check whether TMB data is available
---@return boolean
function TMB:available()
    return GL:higherThanZero(GL.DB:get("TMB.MetaData.importedAt", 0));
end

--- Fetch an item's TMB info based on its ID
---@param itemID number
---@param raidersOnly? boolean
---@return table
function TMB:byItemID(itemID, raidersOnly)
    -- An invalid item id was provided
    itemID = tonumber(itemID);
    if (not GL:higherThanZero(itemID)) then
        return {};
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIDs = GL:getLinkedItemsForID(itemID);

    -- Fetch all entries related to this item ID
    local Entries = {};
    local Checksums = {};
    for _, id in pairs(AllLinkedItemIDs) do
        id = tostring(id);
        for _, Entry in pairs(GL.DB:get("TMB.Items." .. tostring(id), {})) do
            local checksum = ("%s|%s|%s|%s"):format(id, Entry.character, Entry.prio, Entry.type or Constants.tmbTypeWish);

            if (not Checksums[checksum] and Entry.prio ~= nil) then
                tinsert(Entries, Entry);
                Checksums[checksum] = true;
            end
        end
    end

    -- Filter players who are not in the raid
    if (self:shouldOnlyIncludeRaiders(raidersOnly)) then
        Entries = self:filterNonRaiders(Entries);
    end

    return Entries;
end

--- Fetch an item's TMB info based on its item link
---@param itemLink string
---@param inRaidOnly? boolean|nil
---@return table
function TMB:byItemLink(itemLink, inRaidOnly)
    if (GL:empty(itemLink)) then
        return {};
    end

    return self:byItemID(GL:getItemIDFromLink(itemLink), inRaidOnly);
end

--- Determine whether we should only show details for players who are currently in our raid
---@param raidersOnly? boolean
---@return boolean
function TMB:shouldOnlyIncludeRaiders(raidersOnly)
    if (type(raidersOnly) == "boolean") then
        return raidersOnly;
    end

    -- Show everything when using prio3/classicpr.io is enabled
    if (Settings:get("TMB.showEntriesWhenUsingPrio3")
        and self:wasImportedFromCPR()
    ) then
        return false;
    end

    -- User is not in group and showEntriesWhenSolo is true
    if (not GL.User.isInGroup
        and GL.Settings:get("TMB.showEntriesWhenSolo")
    ) then
        return false;
    end

    return Settings:get("TMB.hideInfoOfPeopleNotInGroup") ~= false;
end

--- Filter entries of players who are not in the raid
---@param Entries table
---@return table
function TMB:filterNonRaiders(Entries)
    for key, Entry in pairs(Entries or {}) do
        local playerName = GL:nameFormat(Entry.character):lower():gsub(OFFSPEC_IDENTIFIER, "");

        if (not GL.User:unitInGroup(playerName)) then
            Entry = nil;
            Entries[key] = nil;
        end
    end

    return GL:tableValues(Entries);
end

--- Fetch TMB info for a specific item and player
--- 
---@param itemIdentifier number|string
---@param player string
---@return table
function TMB:byItemIdentifierAndPlayer(itemIdentifier, player)
    local itemID = tonumber(itemIdentifier);
    local identifierIsLink = type(itemIdentifier) == "string";

    -- A string was provided, treat it as an item link and fetch its ID
    if (not itemID
        and identifierIsLink
    ) then
        itemID = GL:getItemIDFromLink(itemIdentifier);
    end

    if (not itemID) then
        return {};
    end

    return self:byItemIDAndPlayer(itemIdentifier, player);
end

--- Fetch TMB info for a specific item ID and player
---@param itemID number
---@param player string
---@return table
function TMB:byItemIDAndPlayer(itemID, player)
    if (type(player) ~= "string"
        or GL:empty(player)
    ) then
        return {};
    end

    local Entries = self:byItemID(itemID, false);
    if (GL:empty(Entries)) then
        return {};
    end

    local playerWithoutRealm = GL:stripRealm(player):lower();
    for key, Entry in pairs(Entries) do
        local playerName = GL:nameFormat(Entry.character):lower():gsub(OFFSPEC_IDENTIFIER, "");

        if (playerName ~= player
            and playerName ~= playerWithoutRealm
        ) then
            Entry = nil;
            Entries[key] = nil;
        end
    end

    return GL:tableValues(Entries);
end

--- Fetch TMB info for a specific item link and player
---@param itemLink string
---@param player string
---@return table
function TMB:byItemLinkAndPlayer(itemLink, player)
    if (GL:empty(itemLink)) then
        return {};
    end

    return self:byItemIDAndPlayer(GL:getItemIDFromLink(itemLink), player);
end

--- Fetch an item's TMB tier based on its item ID
---@param itemID string
---@return string
function TMB:tierByItemID(itemID)
    if (GL:empty(itemID)) then
        return "";
    end

    return GL.DB:get("TMB.Tiers." .. itemID, "");
end

--- Fetch an item's TMB tier based on its item link
---@param itemLink string
---@return string
function TMB:tierByItemLink(itemLink)
    if (GL:empty(itemLink)) then
        return "";
    end

    return self:tierByItemID(GL:getItemIDFromLink(itemLink));
end

--- Fetch an item's TMB note based on its item ID
---@param itemID string
---@return string
function TMB:noteByItemID(itemID)
    if (GL:empty(itemID)) then
        return "";
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIDs = GL:getLinkedItemsForID(itemID);

    local hasNotes = false;
    local Notes = {};
    for _, id in pairs(AllLinkedItemIDs) do
        local note = GL.DB:get("TMB.Notes." .. id);

        if (note) then
            tinsert(Notes, note);
            hasNotes = true;
        end
    end

    if (not hasNotes) then
        return "";
    end

    if (GL:count(Notes) == 1) then
        return Notes[1];
    end

    return GL:implode(Notes, "\n");
end

--- Fetch an item's TMB note based on its item link
---@param itemLink string
---@return string
function TMB:noteByItemLink(itemLink)
    if (GL:empty(itemLink)) then
        return "";
    end

    return self:noteByItemID(GL:getItemIDFromLink(itemLink));
end

--- Fetch a player's group id and name
---@param player string
---@return number, string|boolean | boolean, boolean
function TMB:groupByPlayerName(player)
    if (not GL.DB:get("TMB.RaidGroups")) then
        return false, false;
    end

    player = player:lower();
    local groupID = GL.DB:get("TMB.PlayerGroup." .. player);

    if (groupID) then
        return groupID, GL.DB:get("TMB.RaidGroups", {})[groupID] or false;
    end

    return false, false;
end

--- Add tooltip lines for RRobin entries
---@param Lines table
---@param Entries table
---@return table
function TMB:RRobinTooltipLines(Lines, Entries)
    if (GL:empty(Entries)) then
        return {};
    end

    -- Add the header
    tinsert(Lines, ("\n|c00FF7A0A%s|r"):format(self:source()));

    local topPrio = Entries[1].prio;
    local entriesAdded = 0;
    for _, Entry in pairs(Entries) do
        local priorityColor;
        if (entriesAdded == 0) then
            -- If there's only one contender, color their priority blue (RARE). Green (UNCOMMON) otherwise
            priorityColor = GL.Interface.Colors.RARE;
            if (Entries[2] and topPrio - Entries[2].prio <= 1) then
                priorityColor = GL.Interface.Colors.UNCOMMON;
            end
        elseif (topPrio - Entry.prio <= 1) then
            priorityColor = GL.Interface.Colors.UNCOMMON;
        else
            priorityColor = GL.Interface.Colors.POOR;
        end

        tinsert(Lines, ("    |c00%s%s|r: %s"):format(
            priorityColor,
            Entry.prio,
            GL:nameFormat{ name = Entry.character, colorize = true, defaultColor = Constants.disabledTextColor, }
        ));

        entriesAdded = entriesAdded + 1;
        if (entriesAdded >= GL.Settings:get("TMB.maximumNumberOfTooltipEntries")) then
            break;
        end
    end

    return Lines;
end

--- Add tooltip lines for DFT entries
---@param Lines any
---@param Entries any
---@return table
function TMB:DFTTooltipLines(Lines, Entries)
    if (GL:empty(Entries)) then
        return {};
    end

    -- Add the header
    tinsert(Lines, ("\n|c00FF7A0A%s|r"):format((L.TMB_TOOLTIP_PRIO_HEADER):format(self:source())));

    Entries = self:sortEntries(Entries, "prio");

    -- Add the entries to the tooltip
    local entriesAdded = 0;
    for _, Entry in pairs(Entries) do
        local playerName = Entry.character:lower();
        entriesAdded = entriesAdded + 1;

        local color = GL:classHexColor(GL.Player:classByName(playerName:gsub(OFFSPEC_IDENTIFIER, ""), 0), Constants.disabledTextColor);
        tinsert(Lines, ("|c00%s%s[%s]|r"):format(
            color,
            GL:nameFormat(playerName),
            Entry.prio
        ));

        -- Make sure we don't add more names to the tooltip than the user allowed
        if (entriesAdded >= GL.Settings:get("TMB.maximumNumberOfTooltipEntries")) then
            break;
        end
    end

    return Lines;
end

--- Add tooltip lines for CPR entries
---@param Lines any
---@param Entries any
---@return table
function TMB:CPRTooltipLines(Lines, Entries)
    return self:DFTTooltipLines(Lines, Entries);
end

--- Append the TMB info as defined in GL.DB.TMB.Items to an item's tooltip
---@param itemLink string
---@return table
function TMB:tooltipLines(itemLink)
    if (not self:available()) then
        return {};
    end

    -- If we're not in a group there's no point in showing anything! (unless the non-raider setting is active)
    if ((not GL.User.isInGroup and GL.Settings:get("TMB.hideInfoOfPeopleNotInGroup"))
        and (not GL.User.isInGroup and not GL.Settings:get("TMB.showEntriesWhenSolo"))
    ) then
        return {};
    end

    local itemID = GL:getItemIDFromLink(itemLink);
    if (not itemID) then
        return {};
    end

    local Lines = {};
    local Entries = self:byItemID(itemID);

    if (self:shouldOnlyIncludeRaiders()) then
        Entries = self:filterNonRaiders(Entries);
    end

    -- Show item note and tier
    if (GL.Settings:get("TMB.showItemInfoOnTooltips")) then
        local tier = self:tierByItemID(itemID);
        local note = self:noteByItemID(itemID);

        local sourceHeaderAdded = false;
        local addSourceHeader = function ()
            if (sourceHeaderAdded) then
                return;
            end

            tinsert(Lines, ("\n|c00%s%s|r"):format(
                Constants.addonHexColor,
                self:source()
            ));

            sourceHeaderAdded = true;
        end;

        -- This item has a tier, show it!
        if (not GL:empty(tier)
            and Constants.TMBTierHexColors[tier]
        ) then
            local tierString = ("|c00%s%s|r"):format(
                Constants.TMBTierHexColors[tier],
                tier
            );

            -- Add the source header (TMB/DFT etc)
            addSourceHeader();

            -- Add the tier string
            tinsert(Lines, (L.TMB_TOOLTIP_TIER):format(tierString));
        end

        -- This item has a note, show it!
        if (not GL:empty(note)) then
            -- Add the source header (TMB/DFT etc)
            addSourceHeader();

            -- Add the note
            tinsert(Lines, (L.TMB_TOOLTIP_NOTE):format(note));
        end
    end

    -- There are no player details for this item
    if (GL:empty(Entries)) then
        return Lines;
    end

    -- Sort the entries on a per-source basis
    Entries = self:sortEntries(Entries);

    -- RRobin
    if (self:wasImportedFromRRobin()) then
        return self:RRobinTooltipLines(Lines, Entries);
    end

    -- DFT
    if (self:wasImportedFromDFT()) then
        return self:DFTTooltipLines(Lines, Entries);
    end

    -- CPR
    if (self:wasImportedFromCPR()) then
        return self:CPRTooltipLines(Lines, Entries);
    end

    local showPlayerGroups = GL:count(GL.DB:get("TMB.RaidGroups", {})) > 1 and Settings:get("TMB.showRaidGroup");

    local WishListEntries = {};
    local PrioListEntries = {};
    local itemIsOnSomeonesWishlist = false;
    local itemIsOnSomeonesPriolist = false;
    local entriesAdded = 0;
    for _, Entry in pairs(Entries) do
        local playerName = Entry.character:lower();
        local playerGroup = false;

        if (showPlayerGroups) then
            _, playerGroup = self:groupByPlayerName(playerName);
        end

        local prio = Entry.prio;
        local entryType = Entry.type or Constants.tmbTypeWish;
        local isOffSpec = GL:strContains(Entry.character, OFFSPEC_IDENTIFIER);
        local prioOffset = 0;
        local sortingOrder = prio;
        local color = GL:classHexColor(GL.Player:classByName(playerName:gsub(OFFSPEC_IDENTIFIER, ""), 0), Constants.disabledTextColor);

        -- We add 100 to the prio (first key) of the object
        -- This object is used for sorting later and is not visible to the player
        if (isOffSpec and GL.Settings:get("TMB.OSHasLowerPriority")) then
            prioOffset = 100;
        end

        if (type(sortingOrder) == "number") then
            sortingOrder = prio + prioOffset;
        else
            -- If for whatever reason we can't determine the
            -- item prio then we add it to the end of the list by default
            sortingOrder = 1000;
        end

        local groupString = "";
        if (playerGroup) then
            groupString = " - " .. playerGroup;
        end

        -- TMB is not case-sensitive so people get creative with capital letters sometimes
        playerName = GL:capitalize(playerName);
        if (entryType == Constants.tmbTypePrio) then
            tinsert(PrioListEntries, { sortingOrder, ("|c00%s    %s[%s]%s|r"):format(color, playerName, prio, groupString) });
            itemIsOnSomeonesPriolist = true;
        else
            tinsert(WishListEntries, { sortingOrder, ("|c00%s    %s[%s]%s|r"):format(color, playerName, prio, groupString) });
            itemIsOnSomeonesWishlist = true;
        end
    end

    -- Only add the 'Prio List' header if the item is actually on someone's character prio list
    if (itemIsOnSomeonesPriolist
        and (GL.Settings:get("TMB.showPrioListInfoOnTooltips")
            or (not GL.User.isInGroup and GL.Settings:get("TMB.showEntriesWhenSolo"))
        )
    ) then
        -- Add the header
        local source = self:source();
        tinsert(Lines, ("\n|c00FF7A0A%s|r"):format((L.TMB_TOOLTIP_PRIO_HEADER):format(source)));

        PrioListEntries = self:sortEntries(PrioListEntries, 1);

        -- Add the entries to the tooltip
        entriesAdded = 0;
        for _, Entry in pairs(PrioListEntries) do
            entriesAdded = entriesAdded + 1;

            tinsert(Lines, string.format(
                "|c00%s%s|r",
                GL:classHexColor(GL.Player:classByName(Entry[2], 0), Constants.disabledTextColor),
                GL:capitalize(Entry[2]):gsub(OFFSPEC_IDENTIFIER, " " .. L.TMB_TOOLTIP_OFFSPEC_INDICATION)
            ));

            -- Make sure we don't add more names to the tooltip than the user allowed
            if (entriesAdded >= GL.Settings:get("TMB.maximumNumberOfTooltipEntries")) then
                break;
            end
        end
    end

    -- The item is on someone's prio list and the user is not interested in wishlist entries
    if (GL.Settings:get("TMB.hideWishListInfoIfPriorityIsPresent") and itemIsOnSomeonesPriolist)
        and (GL.User.isInGroup or not GL.Settings:get("TMB.showEntriesWhenSolo"))
    then
        return Lines;
    end

    -- Only add the 'Wish List' header if the item is actually on someone's wishlist
    if (itemIsOnSomeonesWishlist
        and (GL.Settings:get("TMB.showWishListInfoOnTooltips")
            or (not GL.User.isInGroup and GL.Settings:get("TMB.showEntriesWhenSolo"))
        )
    ) then
        -- Add the header
        tinsert(Lines, string.format("\n|c00FFFFFF%s|r", L.TMB_TOOLTIP_WISHLIST_HEADER));

        WishListEntries = self:sortEntries(WishListEntries, 1);

        -- Add the entries to the tooltip
        entriesAdded = 0;
        for _, Entry in pairs(WishListEntries) do
            entriesAdded = entriesAdded + 1;

            tinsert(Lines, string.format(
                "|c00%s%s|r",
                GL:classHexColor(GL.Player:classByName(Entry[2], 0), Constants.disabledTextColor),
                GL:capitalize(Entry[2]):gsub(OFFSPEC_IDENTIFIER, " " .. L.TMB_TOOLTIP_OFFSPEC_INDICATION)
            ));

            -- Make sure we don't add more names to the tooltip than the user allowed
            if (entriesAdded >= GL.Settings:get("TMB.maximumNumberOfTooltipEntries")) then
                break;
            end
        end
    end

    return Lines;
end

--- Draw either the importer or overview
--- based on the current TMB data
---@param source? string
function TMB:draw(source)
    -- No data available, show importer
    if (not self:available()) then
        GL.Interface.TMB.Importer:draw(source);
        return;
    end

    GL.Interface.TMB.Overview:draw();
end

--- Clear all TMB data
function TMB:clear()
    GL.DB.TMB = {};

    Events:fire("GL.TMB_CLEARED");
end

--- Check whether the current TMB data was imported from DFT
---@return boolean
function TMB:wasImportedFromDFT()
    return self:available() and GL:toboolean(GL.DB.TMB.MetaData.importedFromDFT);
end

--- Check whether the current TMB data was imported from CPR
---
---@return boolean
function TMB:wasImportedFromCPR()
    return self:available() and GL:toboolean(GL.DB.TMB.MetaData.importedFromCPR);
end

--- Check whether the current TMB data was imported from RRobin
---
---@return boolean
function TMB:wasImportedFromRRobin()
    return self:available() and GL:toboolean(GL.DB.TMB.MetaData.importedFromRRobin);
end

--- Check whether the current TMB data was imported from CSV
---
---@return boolean
function TMB:wasImportedFromCSV()
    return self:available() and GL:toboolean(GL.DB.TMB.MetaData.importedFromCSV);
end

--- Import a given tmb string
---
---@param data string
---@param triedToDecompress boolean
---@return boolean
function TMB:import(data, triedToDecompress, source)
    local jsonDecodeSucceeded;
    local WebsiteData;
    local wasImportedFromDFT = false;
    local function displayGenericException()
        GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText(L.TMB_IMPORT_INVALID_INSTRUCTIONS);
    end

    if (type(data) ~= "string"
        or GL:empty(data)
    ) then
        displayGenericException();
        return false;
    end

    -- Make sure to get rid of any leading/trailing whitespaces
    data = strtrim(data);

    -- Fetch the first line
    local firstLine = data:match("[^\n]+");

    if (GL:empty(firstLine)) then
        displayGenericException();
        return false;
    end

    -- Let's check if we're dealing with Gargul's "official" CSV format here
    if (firstLine:match("^[0-9]+,")) then
        triedToDecompress = true;
        data = self:CSVFormatToTMB(data);
        WebsiteData = data;

        if (not data) then
            return GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText(L.TMB_IMPORT_INVALID_CSV);
        end

    -- Handle the DFT format
    elseif (GL:strStartsWith(firstLine, '"')) then
        triedToDecompress = true;
        wasImportedFromDFT = true;
        data = self:DFTFormatToTMB(data);
        WebsiteData = data;

        if (not data) then
            return GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText(L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS);
        end
    -- Handle the RRobin format
    elseif (firstLine == "{") then
        jsonDecodeSucceeded, data = pcall(function () return GL.JSON:decode(data); end);
        if (jsonDecodeSucceeded
            and data
            and type(data) == "table"
            and data.reserves
        ) then
            triedToDecompress = true;
            data = self:RRobinFormatToTMB(data);
            WebsiteData = data;

            if (not data) then
                return GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText(L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS);
            end
        end
    end

    -- This is the new zlib format, attempt to decompress it!
    if (not triedToDecompress
        and not GL:strStartsWith(data, "{\"wishlists\":")
    ) then
        data = TMB:decompress(data);
        return TMB:import(data, true, source);
    end

    -- In case of a DFT or RRobin import, data will already be a table
    if (type(data) ~= "table") then
        jsonDecodeSucceeded, WebsiteData = pcall(function () return GL.JSON:decode(data); end);

        -- Make sure the given string could actually be decoded
        if (not jsonDecodeSucceeded
            or not WebsiteData
            or type(WebsiteData) ~= "table"
        ) then
            GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText(L.TMB_IMPORT_INVALID_DFT);
            return false;
        end
    end

    -- Import the actual TMB data
    local wishlistItemsWereImported = false;
    local RaidGroups, PlayerGroup = {}, {};
    if (type(WebsiteData.wishlists) == "table"
        and not GL:empty(WebsiteData.wishlists)
    ) then
        local hasGroups = not not WebsiteData.groups;
        local processedEntryCheckums = {};
        local formatDecided = false;
        local TMBData = {};
        local Keys = {
            name = 1,
            order = 2,
            type = 3,
            groupID = 4,
        };

        for itemID, WishListEntries in pairs(WebsiteData.wishlists) do
            TMBData[itemID] = {};
            for _, characterString in pairs(WishListEntries) do
                local stringParts = GL:explode(characterString, "|");

                -- Check whether the format provided is the old (deprecated) format
                if (not formatDecided) then
                    local isOldFormat = GL:count(stringParts) > 4; -- The old TMB format has more than 4 parts

                    if (isOldFormat) then
                        Keys = {
                            name = 1,
                            order = 3,
                            type = 5,
                            groupID = 7,
                        };
                    end

                    formatDecided = true;
                end

                local characterName = "";
                local order = "?";
                local raidGroupID;
                local type = Constants.tmbTypeWish;

                if (stringParts[Keys.name] and stringParts[Keys.order]) then
                    characterName = string.lower(stringParts[Keys.name]);
                    order = tonumber(stringParts[Keys.order]) or order;
                end

                if (stringParts[Keys.type]) then
                    local providedType = tonumber(stringParts[Keys.type]);

                    if (providedType == Constants.tmbTypePrio) then
                        type = Constants.tmbTypePrio;
                    end
                end

                -- Raid "group" provided, process
                if (hasGroups and Keys.groupID) then
                    local groupID = stringParts[Keys.groupID] or 0;
                    local group = WebsiteData.groups[groupID];

                    if (group) then
                        groupID = tonumber(groupID);
                        RaidGroups[groupID] = group;
                        PlayerGroup[characterName] = groupID;
                    end
                end

                if (characterName and order) then
                    local checkSum = string.format('%s||%s||%s||%s||%s', itemID, characterName, order, type, raidGroupID or 0);

                    -- Make sure to ignore duplicates
                    if (wasImportedFromDFT -- DFT can have duplicates!
                        or not processedEntryCheckums[checkSum]
                    ) then
                        tinsert(TMBData[itemID], {
                            ["character"] = characterName,
                            ["prio"] = order,
                            ["type"] = type,
                        });

                        wishlistItemsWereImported = true;
                        processedEntryCheckums[checkSum] = true;
                    end
                end
            end
        end

        GL.DB:set("TMB.Items", TMBData);
    end

    -- There are item notes available, store them
    if (WebsiteData.notes and type(WebsiteData.notes) == "table") then
        for itemID, note in pairs(WebsiteData.notes) do
            GL.DB:set("TMB.Notes." .. itemID, note);
        end
    end

    -- There is group data available, store!
    if (not GL:empty(RaidGroups) and not GL:empty(PlayerGroup)) then
        GL.DB:set("TMB.RaidGroups", RaidGroups);
        GL.DB:set("TMB.PlayerGroup", PlayerGroup);
    end

    -- There are item tiers available, store them
    if (WebsiteData.tiers and type(WebsiteData.tiers) == "table") then
        for itemID, tier in pairs(WebsiteData.tiers) do
            GL.DB:set("TMB.Tiers." .. itemID, tier);
        end
    end

    -- There is also loot priority data available, pass it to on!
    if (type(WebsiteData.loot) == "string"
        and not GL:empty(WebsiteData.loot)
    ) then
        GL.LootPriority:save(WebsiteData.loot);
    end

    -- This can happen if the user only imported item notes
    if (GL:empty(wishlistItemsWereImported)) then
        return true;
    end

    GL.DB.TMB.MetaData = {
        importedFromDFT = GL:toboolean(WebsiteData.importedFromDFT),
        importedFromCSV = GL:toboolean(WebsiteData.importedFromCSV),
        importedFromCPR = source == "cpr",
        importedFromRRobin = source == "rrobin" or GL:toboolean(WebsiteData.importedFromRRobin),
        importedAt = GetServerTime(),
        hash = GL:uuid() .. GetServerTime(),
    };

    Events:fire("GL.TMB_IMPORTED");
    GL.Interface.TMB.Importer:close();
    self:draw();

    -- The user is in charge of automatically sharing TMB data
    -- after importing it, let's get crackin'!
    if (GL.Settings:get("TMB.automaticallyShareData")
        and (GL.User.isMasterLooter
            or (GetLootMethod() ~= 'master'
                and GL.User.isLead
            )
        )
    ) then
        self:broadcast();
    end

    -- Report players without any TMB entries
    local PlayersWithoutEntries = self:playersWithoutEntries();
    if (not GL:empty(PlayersWithoutEntries)) then
        local MissingPlayers = {};
        for _, name in pairs(PlayersWithoutEntries) do
            tinsert(MissingPlayers, GL:nameFormat{ name = name, colorize = true, });
        end

        GL:warning((L.TMB_IMPORT_PLAYER_NO_DATA):format(self:source()));
        GL:message(table.concat(MissingPlayers, " "));
    end

    return true;
end

--- Where did our current TMB data come from?
---@return string
function TMB:source()
    if (self:wasImportedFromDFT()) then
        return L.DFT;
    end

    if (self:wasImportedFromRRobin()) then
        return "RRobin";
    end

    if (self:wasImportedFromCPR()) then
        return L.CLASSICPRIO_ABBR;
    end

    if (self:wasImportedFromCSV()) then
        return L.ITEM;
    end

    return L.THATSMYBIS_ABBR;
end

--- Return the names of all players that don't have any TMB details
---@return table
function TMB:playersWithoutEntries()
    local PlayersWithDetails = {};
    for _, Item in pairs(GL.DB:get("TMB.Items", {})) do
        for _, Entry in pairs(Item or {}) do
            if (Entry.character) then
                PlayersWithDetails[Entry.character] = true;
            end
        end
    end

    local PlayersWithoutEntries = {};
    for _, Details in pairs(GL.User:groupMembers() or {}) do

        local name = string.lower(GL:nameFormat(Details.name));
        local fqn = string.lower(GL:addRealm(Details.name));
        if (not PlayersWithDetails[name]
            and not PlayersWithDetails[fqn]
        ) then
            tinsert(PlayersWithoutEntries, name);
        end
    end

    return PlayersWithoutEntries;
end

--- Transform the RRobin format to a TMB format
---@param data table
---@return table
function TMB:RRobinFormatToTMB(data)
    local TMBData = {
        importedFromRRobin = true,
        wishlists = {},
    };

    for _, Entry in pairs(data.reserves or {}) do
        local WishlistData = TMBData.wishlists[tostring(Entry.itemid)] or {};
        tinsert(WishlistData, string.format("%s||%s||1||1", self:normalizePlayerName(Entry.character), Entry.priority));
        TMBData.wishlists[tostring(Entry.itemid)] = WishlistData;
    end

    return TMBData;
end

--- Transform the DFT format to a TMB format
---@param data string
---@return boolean|table Returns false when invalid data is provided
function TMB:DFTFormatToTMB(data)
    local TMBData = {
        importedFromDFT = true,
        wishlists = {},
    };

    data = data:gsub('"', "");

    local lineNumber;
    local increaseLineNumber = function ()
        lineNumber = lineNumber + 1;
    end;
    for _, entry in pairs(GL:explode(data, ";")) do
        local Priorities = {};
        local itemID;

        lineNumber = 1;
        for line in entry:gmatch("[^\n]+") do
            local validLine = true;

            (function ()
                local lineParts;

                -- The first line contains the item ID we're discussing
                if (lineNumber == 1) then
                    lineParts = GL:explode(line, "^");

                    -- Extract the item ID from the line
                    if (lineParts[1]) then
                        itemID = tonumber(lineParts[1]);
                    end

                    -- Check if the item ID we extracted (if any) is valid
                    if (not GL:higherThanZero(itemID)) then
                        validLine = false;
                    end

                    increaseLineNumber();
                    return;
                end

                -- We skip items that don't have an active priority
                if (GL:strContains(line, "Free Roll")) then
                    validLine = false;
                    return;
                end

                line = strtrim(line);
                line = string.sub(line, 12, string.len(line));
                line = line:gsub("|r: :", "");
                line = line:gsub("|r: ", "");

                lineParts = GL:explode(line, "|");

                -- We can't handle this line it seems
                if (not lineParts[2]) then
                    return;
                end

                local player = lineParts[1];
                local priority = tonumber(lineParts[2]);

                if (GL:empty(player)
                    or not priority
                ) then
                    return;
                end

                tinsert(Priorities, { player = player, priority = priority, });

                increaseLineNumber();
            end)();

            -- An invalid line was detected, break!
            if (not validLine) then
                break;
            end
        end

        -- Valid priorities were detected, add them
        if (not GL:empty(Priorities)) then
            TMBData.wishlists[tostring(itemID)] = Priorities;
        end
    end

    -- No valid data detected
    if (GL:empty(TMBData.wishlists)) then
        return false;
    end

    -- Rewrite the DFT format to TMB
    for itemID, Priorities in pairs(TMBData.wishlists) do
        for key, Priority in pairs(Priorities) do
            TMBData.wishlists[itemID][key] = string.format("%s||%s||1||1", self:normalizePlayerName(Priority.player), Priority.priority);
        end
    end

    return TMBData;
end

--- Attempt to transform the Gargul CSV format to a TMB format
---@param data string
---@return boolean|table Returns false when invalid data is provided
function TMB:CSVFormatToTMB(data)
    local TMBData = {
        importedFromCSV = true,
        wishlists = {},
    };

    --[[
6948,zhorax[1],feth[2],arvada[3],arrafart[3],ratomir[4],tonio[99]
1372,ratomir[1],zhorax[2],feth[3],arvada[4],arrafart[4],vejusatko[99]
Main:tonio,vejusatko,arvada,zhorax
Alt:ratomir,arrafart,feth

        OR

6948,vejusatko,zhorax,feth,arvada,arrafart,ratomir
1372,ratomir,tonio|zhorax,feth,arvada,arrafart
Main:tonio,vejusatko,arvada
Alt:ratomir,zhorax,feth
    ]]

    local RaidGroups, PlayerGroup = {}, {};
    local raidGroups = 0;
    for line in data:gmatch("[^\n]+") do
        local Priorities = {};
        local itemID;

        (function ()
            local priority = 1;
            local CSVParts;
            local raidGroup = string.match(line, "^(.+):");

            if (raidGroup) then
                line = line:gsub(raidGroup .. ":", "");
            end

            CSVParts = GL:explode(line, ",");

            if (raidGroup) then
                raidGroups = raidGroups + 1;
                RaidGroups[raidGroups] = raidGroup;

                -- We can't handle this line it seems (groups can't be empty)
                if (not CSVParts[1]) then
                    return;
                end

                for _, priorityEntry in pairs(CSVParts) do
                    (function ()
                        local player = self:normalizePlayerName(priorityEntry);

                        if (GL:empty(player)) then
                            return;
                        end

                        PlayerGroup[player] = raidGroups;
                    end)();
                end

                return;
            end

            -- We can't handle this line it seems
            if (not CSVParts[2]) then
                return;
            end

            itemID = tonumber(CSVParts[1]);

            if (not itemID) then
                return;
            end

            itemID = math.floor(itemID);
            if (not GL:higherThanZero(itemID)) then
                return;
            end

            table.remove(CSVParts, 1);

            for _, priorityEntry in pairs(CSVParts) do
                (function () -- Not having continue statements in LUA is getting silly at this point
                    local player = string.lower(GL:nameFormat(priorityEntry));
                    local playerPriority = player:match("(%[[0-9%.]+%])");

                    if (playerPriority) then
                        local openingBracketPosition = string.find(player, "%[");
                        player = string.sub(player, 1, openingBracketPosition - 1);
                        priority = playerPriority:match("([0-9%.]+)");
                    elseif (string.find(player, "%|")) then
                        local Players = GL:explode(player, "|");

                        for _, playerName in pairs(Players) do
                            if (not GL:empty(playerName)) then
                                tinsert(Priorities, { player = playerName, priority = priority, });
                            end
                        end

                        priority = priority + 1;
                        return;
                    end

                    tinsert(Priorities, {player = player, priority = priority});
                    priority = priority + 1;
                end)();
            end
        end)();

        -- Valid priorities were detected, add them
        if (not GL:empty(Priorities)) then
            TMBData.wishlists[tostring(itemID)] = Priorities;
        end
    end

    -- No valid data detected
    if (GL:empty(TMBData.wishlists)) then
        return false;
    end

    -- Rewrite the priorities to match TMBs format
    for itemID, Priorities in pairs(TMBData.wishlists) do
        for key, PriorityEntry in pairs(Priorities) do
            TMBData.wishlists[itemID][key] = string.format("%s||%s||1||1", self:normalizePlayerName(PriorityEntry.player), PriorityEntry.priority);
        end
    end

    -- There is group data available, store!
    if (not GL:empty(RaidGroups) and not GL:empty(PlayerGroup)) then
        GL.DB:set("TMB.RaidGroups", RaidGroups);
        GL.DB:set("TMB.PlayerGroup", PlayerGroup);
    end

    return TMBData;
end

---@param data string
---@return string
function TMB:decompress(data)
    local base64DecodeSucceeded;
    base64DecodeSucceeded, data = pcall(function () return GL.Base64.decode(data); end);

    -- Something went wrong while base64 decoding the payload
    if (not base64DecodeSucceeded) then
        local errorMessage = L.BASE64_DECODE_WARNING;
        GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return "";
    end

    local LibDeflate = LibStub:GetLibrary("LibDeflate");
    local zlibDecodeSucceeded;
    zlibDecodeSucceeded, data = pcall(function () return LibDeflate:DecompressZlib(data); end);

    -- Something went wrong while zlib decoding the payload
    if (not zlibDecodeSucceeded) then
        local errorMessage = L.ZLIB_DECOMPRESS_WARNING;
        GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText(errorMessage);
        return "";
    end

    return data;
end

--- Broadcast the TMB to the RAID / PARTY
---@param sendEmptyPayload boolean used to override your raider's TMB data
---@return boolean
function TMB:broadcast(sendEmptyPayload)
    if (self.broadcastInProgress) then
        GL:error(L.BROADCAST_IN_PROGRESS_ERROR);
        return false;
    end

    if (GL.User.isInGroup
        and not GL.User.hasAssist
        and not GL.User.isMasterLooter
    ) then
        GL:warning(L.LM_OR_ASSIST_REQUIRED);
        return false;
    end

    if (sendEmptyPayload) then
        GL.CommMessage.new{
            action = CommActions.broadcastTMBData,
            content = {
                Items = {
                    ["01"] = {
                        {
                            character = "_reset",
                            prio = 1,
                            type = 1,
                        },
                    },
                },
                MetaData = {
                    importedAt = GetServerTime(),
                },
            },
            channel = "GROUP",
        }:send();

        return;
    end

    -- Check if there's anything to share
    if (not self:available()) then
        GL:warning(L.BROADCAST_NO_DATA);
        return false;
    end

    if (not GL:empty(GL.Settings:get("TMB.shareWhitelist", ""))) then
        self:broadcastToWhitelist();
    else
        self:broadcastToGroup();
    end

    return true;
end

--- Broadcast the available data to whitelisted players only
function TMB:broadcastToWhitelist()
    if (self.broadcastInProgress) then
        GL:error(L.BROADCAST_IN_PROGRESS_ERROR);
        return false;
    end

    self.broadcastInProgress = true;

    local Whitelist = GL.Settings:get("TMB.shareWhitelist", "");
    if (type(Whitelist) ~= "string") then
        self.broadcastInProgress = false;
        return;
    end
    Whitelist = GL:explode(Whitelist, ",");

    local WhitelistedPlayersInGroup = {};
    local GroupMemberNames = GL.User:groupMemberNames();
    for _, name in pairs(Whitelist) do
        name = string.lower(name);

        if (not GL:iEquals(GL.User.name, name)
            and GL:inTable(GroupMemberNames, name)
            and GL:unitIsConnected(name) -- Only send if player is online
        ) then
            tinsert(WhitelistedPlayersInGroup, name);
        end
    end

    local numberOfPlayers = #WhitelistedPlayersInGroup;
    if (numberOfPlayers < 1) then
        GL:warning(L.TMB_NO_BROADCAST_TARGETS);
        self.broadcastInProgress = false;
        return;
    end

    local broadcastsFinished = 0;
    local broadcast = function ()
        GL.Ace:ScheduleTimer(function ()
            self.broadcastInProgress = false;
        end, 10);

        Events:fire("GL.TMB_BROADCAST_STARTED");

        for _, player in pairs(WhitelistedPlayersInGroup) do
            GL.CommMessage.new{
                action = CommActions.broadcastTMBData,
                content = GL.DB.TMB,
                channel = "WHISPER",
                recipient = player,
            }:send(function ()
                broadcastsFinished = broadcastsFinished + 1;

                if (broadcastsFinished >= numberOfPlayers) then
                    GL:success(L.BROADCAST_FINISHED);
                    self.broadcastInProgress = false;
                    Events:fire("GL.TMB_BROADCAST_ENDED");
                end
            end);
        end
    end;

    GL:afterCombatDo(function ()
        broadcast();
    end, function ()
        GL:notice(L.BROADCAST_DELAYED_BY_COMBAT);
    end);
end

--- Broadcast the available data to everyone in your raid/party
function TMB:broadcastToGroup()
    if (self.broadcastInProgress) then
        GL:error(L.BROADCAST_IN_PROGRESS_ERROR);
        return false;
    end

    self.broadcastInProgress = true;

    local broadcast = function ()
        GL.Ace:ScheduleTimer(function ()
            self.broadcastInProgress = false;
        end, 10);

        Events:fire("GL.TMB_BROADCAST_STARTED");

        GL:message(L.BROADCASTING_NOTIFICATION);

        local Label = GL.Interface:get(GL.TMB, "Label.BroadcastProgress");

        if (Label) then
            Label:SetText(L.BROADCASTING_NOTIFICATION);
        end

        GL.CommMessage.new{
            action = CommActions.broadcastTMBData,
            content = GL.DB.TMB,
            channel = "GROUP",
        }:send(function ()
            GL:success(L.BROADCAST_FINISHED);
            Events:fire("GL.TMB_BROADCAST_ENDED");
            self.broadcastInProgress = false;

            Label = GL.Interface:get(GL.TMB, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText(L.BROADCAST_FINISHED);
            end

            -- Make sure to broadcast the loot priorities as well
            GL.LootPriority:broadcast();
        end, function (sent, total)
            Label = GL.Interface:get(GL.TMB, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText(string.format(L.COMM_PROGRESS, sent, total));
            end
        end);
    end

    GL:afterCombatDo(function ()
        broadcast();
    end, function ()
        GL:notice(L.BROADCAST_DELAYED_BY_COMBAT);
    end);
end

--- Process an incoming TMB broadcast
---@param CommMessage CommMessage
function TMB:receiveBroadcast(CommMessage)
    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.isSelf) then
        GL:debug("TMB:receiveBroadcast received by self, skip");
        return true;
    end

    local Data = CommMessage.content;
    if (not GL:empty(Data)) then
        GL:warning((L.TMB_BROADCAST_PROCESS_START):format(CommMessage.Sender.name));

        if (type(Data) ~= "table" or GL:empty(Data)
            or type(Data.Items) ~= "table" or GL:empty(Data.Items)
            or GL:empty(GL:tableGet(Data, "MetaData.importedAt"))
        ) then
            GL:debug("Invalid TMB data received from " .. CommMessage.Sender.name);
            return;
        end

        -- Validate dataset
        for itemID, Entries in pairs(Data.Items) do
            itemID = tonumber(itemID);

            if (GL:empty(itemID)) then
                GL:debug("Invalid TMB data received from " .. CommMessage.Sender.name);
                return;
            end

            for _, Entry in pairs(Entries) do
                Entry.prio = tonumber(Entry.prio);

                if (GL:empty(Entry.character)
                    or GL:empty(Entry.type)
                    or not Entry.prio
                ) then
                    GL:debug("Invalid TMB data received from " .. CommMessage.Sender.name);
                    return;
                end
            end
        end

        GL:success(L.TMB_SYNCED);
        GL.DB.TMB = Data;
    end
end

--- Request TMB data from the person in charge (ML or Leader)
function TMB:requestData()
    if (self.requestingData
        or (_G.UnitInBattleground and UnitInBattleground("player"))
    ) then
        return;
    end

    self.requestingData = true;

    local playerToRequestFrom = (function()
        -- We are the ML, we need to import the data ourselves
        if (GL.User.isMasterLooter) then
            return;
        end

        local lootMethod, _, masterLooterRaidID = GetLootMethod();

        -- Master looting is not active and we are the leader, this means we should import it ourselves
        if (lootMethod ~= 'master'
            and GL.User.isLead
        ) then
            return;
        end

        -- Master looting is active, return the name of the master looter
        if (lootMethod == 'master') then
            return GetRaidRosterInfo(masterLooterRaidID);
        end

        -- Fetch the group leader
        local maximumNumberOfGroupMembers = _G.MEMBERS_PER_RAID_GROUP;
        if (GL.User.isInRaid) then
            maximumNumberOfGroupMembers = _G.MAX_RAID_MEMBERS;
        end

        for index = 1, maximumNumberOfGroupMembers do
            local name, rank = GetRaidRosterInfo(index);

            -- Rank 2 means leader
            if (name and rank == 2) then
                return name;
            end
        end
    end)();

    -- There's no one to request data from, return
    if (GL:empty(playerToRequestFrom)) then
        self.requestingData = false;
        return;
    end

    -- We send a data request to the person in charge
    -- He will compare the ID and importedAt timestamp on his end to see if we actually need his data
    GL.CommMessage.new{
        action = CommActions.requestTMBData,
        content = {
            currentHash = GL.DB:get('TMB.MetaData.hash', nil),
        },
        channel = "WHISPER",
        recipient = playerToRequestFrom,
    }:send();

    self.requestingData = false;
end

--- Reply to a player's TMB data request
---@param CommMessage CommMessage
function TMB:replyToDataRequest(CommMessage)
    -- I don't have any data, leave me alone!
    if (not self:available()) then
        return;
    end

    -- We're not in a group (anymore), no need to help this person out
    if (not GL.User.isInGroup) then
        return;
    end

    -- Nice try, but we don't allow auto-sharing
    if (not Settings:get("TMB.automaticallyShareData")) then
        return;
    end

    -- Nice try, but we're not allowed to share data
    if (not self:userIsAllowedToBroadcast()) then
        return;
    end

    -- The player is not in the same guild, this is something we won't support in data requests
    if (not GL.User:playerIsGuildMember(CommMessage.senderFqn)) then
        return;
    end

    -- This player is not on our whitelist
    local Whitelist = GL.Settings:get("TMB.shareWhitelist", "");
    if (not GL:empty(Whitelist)) then
        Whitelist = GL:explode(Whitelist, ",");

        if (not GL:empty(Whitelist)) then
            local WhitelistedPlayersInGroup = {};
            local GroupMemberNames = GL.User:groupMemberNames();
            for _, name in pairs(Whitelist) do
                name = string.lower(name);

                if (not GL:iEquals(GL.User.name, name)
                    and GL:inTable(GroupMemberNames, name)
                ) then
                    tinsert(WhitelistedPlayersInGroup, name);
                end
            end

            if (not GL:inTable(WhitelistedPlayersInGroup, CommMessage.Sender.name)) then
                return;
            end
        end
    end

    local playerTMBHash = CommMessage.content.currentHash or '';
    -- Your data is the same as mine, leave me alone!
    if (not GL:empty(playerTMBHash)
        and playerTMBHash == GL.DB:get('TMB.MetaData.hash')
    ) then
        return;
    end

    -- Looks like you need my data, here it is!
    GL.CommMessage.new{
        action = CommActions.broadcastTMBData,
        content = GL.DB.TMB,
        channel = "WHISPER",
        recipient = CommMessage.senderFqn,
    }:send(function ()
        -- Make sure to broadcast the loot priorities as well
        GL.LootPriority:broadcastToPlayer(CommMessage.Sender.name);
    end);
end

---@param Entries table
---@param key number The key that holds the item order
---@return table
function TMB:sortEntries(Entries, key)
    key = key or "prio";
    Entries = not GL:empty(Entries) and Entries or {};
    Entries = GL:tableValues(Entries);

    table.sort(Entries, function(a, b)
        if (a[key] and b[key]) then
            if (self:wasImportedFromDFT() or self:wasImportedFromRRobin()) then
                return a[key] > b[key];
            end

            return a[key] < b[key];
        end

        return false;
    end);

    return Entries;
end

--- Check whether the current user is allowed to broadcast TMB data
---@return boolean
function TMB:userIsAllowedToBroadcast()
    return GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist);
end

--- Announce TMB entry details in chat
---@param itemID number
---@param Entries? table
function TMB:announceDetailsOfItemInChat(itemID, Entries)
    local announcePrios = GL.Settings:get("TMB.includePrioListInfoInLootAnnouncement");
    local announceWishes = GL.Settings:get("TMB.includeWishListInfoInLootAnnouncement");

    -- It seems we're not interested in announcing anything TMB-related
    if (not announcePrios
        and not announceWishes
    ) then
        return;
    end

    if (self:wasImportedFromRRobin()) then
        if (not announcePrios) then
            return;
        end

        return self:RRobinAnnounceDetailsOfItemInChat(itemID, Entries);
    end

    Entries = Entries or self:byItemID(itemID);
    if (GL:empty(Entries)) then
        return;
    end

    local numberOfEntriesToAnnounce = GL.Settings:get("TMB.maximumNumberOfAnnouncementEntries", 5);
    local WishListDetails = {};
    local PrioListDetails = {};
    for _, Entry in pairs(Entries) do
        local playerName = Entry.character:gsub(OFFSPEC_IDENTIFIER, "");
        playerName = GL:disambiguateName(playerName);
        local prio = Entry.prio;
        local entryType = Entry.type or Constants.tmbTypeWish;
        local isOffSpec = GL:strContains(Entry.character, OFFSPEC_IDENTIFIER);
        local sortingOffset = 0;
        local sortingOrder = tonumber(prio);

        -- We add 100 to the prio (first key) of the object
        -- This object is used for sorting later and is not visible to the player
        if (isOffSpec) then
            sortingOffset = 100;
        end

        if (not GL:empty(sortingOrder)) then
            sortingOrder = prio + sortingOffset;
        else
            -- If for whatever reason we can't determine the
            -- item prio then we add it to the end of the list by default
            sortingOrder = 1000;
        end

        if (entryType == Constants.tmbTypePrio) then
            tinsert(PrioListDetails, {
                prio = sortingOrder,
                player = string.format("%s[%s]", playerName, prio),
            });
        else
            tinsert(WishListDetails, {
                prio = sortingOrder,
                player = string.format("%s[%s]", playerName, prio),
            });
        end
    end

    local itemIsOnSomeonesPriolist = not GL:empty(PrioListDetails);
    local itemIsOnSomeonesWishlist = not GL:empty(WishListDetails);

    --[[
        SHOW WHO HAS PRIORITY ON THIS ITEM (TMB)
    ]]
    if (itemIsOnSomeonesPriolist
        and GL.Settings:get("TMB.includePrioListInfoInLootAnnouncement")
    ) then
        PrioListDetails = TMB:sortEntries(PrioListDetails);

        local entries = 0;
        local entryString = "";
        for _, Entry in pairs(PrioListDetails) do
            entries = entries + 1;

            -- Add the player to the list (first entry should not start with a comma)
            if (GL:empty(entryString)) then
                entryString = GL:capitalize(Entry.player);
            else
                entryString = entryString .. ", " .. GL:capitalize(Entry.player);
            end

            -- The user only wants to see a limited number of entries, break!
            if (entries >= numberOfEntriesToAnnounce) then
                break;
            end
        end

        GL:sendChatMessage(
            (L.CHAT["%s Priority: %s"]):format(TMB:source(), entryString),
            "GROUP"
        );
    end

    --[[
        SHOW WHO WISHLISTED THIS ITEM (TMB)
    ]]
    if (itemIsOnSomeonesWishlist
        and GL.Settings:get("TMB.includeWishListInfoInLootAnnouncement")
        and (not itemIsOnSomeonesPriolist
            or not GL.Settings:get("TMB.hideWishListInfoIfPriorityIsPresent")
        )
    ) then
        WishListDetails = TMB:sortEntries(WishListDetails);

        local entries = 0;
        local entryString = "";
        for _, Entry in pairs(WishListDetails) do
            entries = entries + 1;

            -- Add the player to the list (first entry should not start with a comma)
            if (GL:empty(entryString)) then
                entryString = GL:capitalize(Entry.player);
            else
                entryString = entryString .. ", " .. GL:capitalize(Entry.player);
            end

            -- The user only wants to see a limited number of entries, break!
            if (entries >= numberOfEntriesToAnnounce) then
                break;
            end
        end

        GL:sendChatMessage(
            (L.CHAT["TMB Wishlist: %s"]):format(entryString),
            "GROUP"
        );
    end
end

--- Announce RRobin details in chat
---@param itemID number
---@param Entries? table
function TMB:RRobinAnnounceDetailsOfItemInChat(itemID, Entries)
    Entries = Entries or self:byItemID(itemID);
    if (GL:empty(Entries)) then
        return;
    end
    Entries = self:sortEntries(Entries)

    local EligibleEntries = {};
    local entries = 0;
    local topPrio = Entries[1].prio;
    local numberOfEntriesToAnnounce = GL.Settings:get("TMB.maximumNumberOfAnnouncementEntries", 5);
    for _, Entry in pairs(Entries) do
        -- We've reached the end of all eligible entries
        if (topPrio - Entry.prio > 1) then
            break;
        end

        tinsert(EligibleEntries, ("%s[%s]"):format(GL:disambiguateName(Entry.character), Entry.prio));
        entries = entries + 1;

        -- The user only wants to see a limited number of entries, break!
        if (entries >= numberOfEntriesToAnnounce) then
            break;
        end
    end

    local entryString = table.concat(EligibleEntries, ",");
    GL:sendChatMessage(
        (L.CHAT["%s Priority: %s"]):format(self:source(), entryString),
        "GROUP"
    );
end
