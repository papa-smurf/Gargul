---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

---@class TMB
GL.TMB = {
    _initialized = false,
    broadcastInProgress = false,
    lastTooltipData = nil,
    lastTooltipItemLink = nil,
    lastTooltipTime = nil,
    requestingData = false,
};
local TMB = GL.TMB; ---@type TMB

local Constants = GL.Data.Constants; ---@type Data
local CommActions = Constants.Comm.Actions;
local Settings = GL.Settings; ---@type Settings

---@return boolean
function TMB:_init()
    GL:debug("TMB:_init");

    if (self._initialized) then
        return false;
    end

    GL.Events:register("TMBUserJoinedGroupListener", "GL.USER_JOINED_GROUP", function () self:requestData(); end);

    self._initialized = true;
    return true;
end

--- Check whether there is TMB data available
---
---@return boolean
function TMB:available()
    return GL:higherThanZero(GL.DB:get("TMB.MetaData.importedAt", 0));
end

--- Fetch an item's TMB info based on its ID
---
---@param itemID number
---@param inRaidOnly boolean|nil
---@return table
function TMB:byItemID(itemID, inRaidOnly)
    GL:debug("TMB:byItemID");

    -- An invalid item id was provided
    itemID = tonumber(itemID);
    if (not GL:higherThanZero(itemID)) then
        return {};
    end

    if (type(inRaidOnly) ~= "boolean") then
        inRaidOnly = Settings:get("TMB.hideInfoOfPeopleNotInGroup");

        -- User is not in group and showEntriesWhenSolo is true
        if (inRaidOnly
            and not GL.User.isInGroup
            and GL.Settings:get("TMB.showEntriesWhenSolo")
        ) then
            inRaidOnly = false;
        end
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIDs = GL:getLinkedItemsForID(itemID);

    local GroupMemberNames = {};
    if (inRaidOnly) then
        GroupMemberNames = GL.User:groupMemberNames();
    end

    local Processed = {};
    local Wishes = {};
    for _, id in pairs(AllLinkedItemIDs) do
        id = tostring(id);
        for _, Entry in pairs(GL.DB:get("TMB.Items." .. tostring(id), {})) do
            local playerName = string.lower(GL:stripRealm(Entry.character));

            -- If inRaidOnly is true we need to make sure we only return details of people who are actually in the raid
            --- NOTE TO SELF: it's (os) because of the string.lower, if you remove the lower then change below accordingly!
            if (not inRaidOnly or GL:inTable(GroupMemberNames, string.gsub(playerName, "%(os%)", ""))) then
                local checkSum = string.format('%s||%s||%s', Entry.character, tostring(Entry.prio), tostring(Entry.type));

                -- Make sure we don't add the same player/prio combo more than once
                if (not Processed[checkSum]) then
                    Processed[checkSum] = true;
                    tinsert(Wishes, Entry);
                end
            end
        end
    end

    return Wishes;
end

--- Fetch TMB info for a specific item ID and player
---
---@param itemID number
---@param player string
---@return table
function TMB:byItemIDAndPlayer(itemID, player)
    GL:debug("TMB:byItemID");

    -- An invalid item id or name was provided
    itemID = tonumber(itemID);
    player = string.lower(strtrim(player));
    if (not GL:higherThanZero(itemID)
        or GL:empty(player)
    ) then
        return {};
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIDs = GL:getLinkedItemsForID(itemID);

    local Processed = {};
    local Entries = {};
    for _, id in pairs(AllLinkedItemIDs) do
        id = tostring(id);
        for _, Entry in pairs(GL.DB:get("TMB.Items." .. tostring(id), {})) do
            local playerName = string.lower(GL:stripRealm(Entry.character));

            --- NOTE TO SELF: it's (os) because of the string.lower, if you remove the lower then change below accordingly!
            if (player == string.gsub(playerName, "%(os%)", "")) then
                local checkSum = string.format('%s||%s||%s', player, tostring(Entry.prio), tostring(Entry.type));

                -- Make sure we don't add the same player/prio combo more than once
                if (not Processed[checkSum]) then
                    Processed[checkSum] = true;
                    tinsert(Entries, Entry);
                end
            end
        end
    end

    return Entries;
end

--- Fetch an item's TMB info based on its item link
---
---@param itemLink string
---@param inRaidOnly boolean|nil
---@return table
function TMB:byItemLinkAndPlayer(itemLink, player)
    GL:debug("TMB:byItemLink");

    if (GL:empty(itemLink)) then
        return {};
    end

    return self:byItemIDAndPlayer(GL:getItemIDFromLink(itemLink), player);
end

--- Fetch an item's TMB info based on its item link
---
---@param itemLink string
---@param inRaidOnly boolean|nil
---@return table
function TMB:byItemLink(itemLink, inRaidOnly)
    GL:debug("TMB:byItemLink");

    if (GL:empty(itemLink)) then
        return {};
    end

    return self:byItemID(GL:getItemIDFromLink(itemLink), inRaidOnly);
end

--- Fetch an item's TMB tier based on its item link
---
---@param itemLink string
---@return string
function TMB:tierByItemLink(itemLink)
    GL:debug("TMB:tierByItemLink");

    if (GL:empty(itemLink)) then
        return "";
    end

    return self:tierByItemID(GL:getItemIDFromLink(itemLink));
end

--- Fetch an item's TMB tier based on its item ID
---
---@param itemID string
---@return string
function TMB:tierByItemID(itemID)
    GL:debug("TMB:tierByItemID");

    if (GL:empty(itemID)) then
        return "";
    end

    return GL.DB:get("TMB.Tiers." .. itemID, "");
end

--- Fetch an item's TMB note based on its item link
---
---@param itemLink string
---@return string
function TMB:noteByItemLink(itemLink)
    GL:debug("TMB:noteByItemLink");

    if (GL:empty(itemLink)) then
        return "";
    end

    return self:noteByItemID(GL:getItemIDFromLink(itemLink));
end

--- Fetch an item's TMB note based on its item ID
---
---@param itemID string
---@return string
function TMB:noteByItemID(itemID)
    GL:debug("TMB:noteByItemID");

    if (GL:empty(itemID)) then
        return "";
    end

    return GL.DB:get("TMB.Notes." .. itemID, "");
end

--- Append the TMB info as defined in GL.DB.TMB.Items to an item's tooltip
---
---@param itemLink string
---@return table
function TMB:tooltipLines(itemLink)
    GL:debug("TMB:tooltipLines");

    -- If we're not in a group there's no point in showing anything! (unless the non-raider setting is active)
    if ((not GL.User.isInGroup and GL.Settings:get("TMB.hideInfoOfPeopleNotInGroup"))
        and (not GL.User.isInGroup and not GL.Settings:get("TMB.showEntriesWhenSolo"))
    ) then
        return {};
    end

    local Lines = {};
    local TMBTier = self:tierByItemLink(itemLink);
    local TMBNote = self:noteByItemLink(itemLink);
    local TMBInfo = self:byItemLink(itemLink);

    local TMBHeaderAdded = false;

    if (GL.Settings:get("TMB.showItemInfoOnTooltips")) then
        -- This item has a tier, show it!
        if (not GL:empty(TMBTier)
            and GL.Data.Constants.TMBTierHexColors[TMBTier]
        ) then
            local tierString = string.format("|cFF%s%s|r",
                GL.Data.Constants.TMBTierHexColors[TMBTier],
                TMBTier
            );

            -- Add the header
            tinsert(Lines, string.format(
                "\n|cFF%sTMB:|r",
                GL.Data.Constants.addonHexColor,
                "TMB"
            ));
            TMBHeaderAdded = true;

            -- Add the tier string
            tinsert(Lines, string.format(
                "|cFFFFFFFF    Tier:|r %s",
                tierString
            ));
        end

        -- This item has a note, show it!
        if (not GL:empty(TMBNote)) then
            if (not TMBHeaderAdded) then
                -- Add the header
                tinsert(Lines, string.format(
                    "\n|cFF%sTMB:|r",
                    GL.Data.Constants.addonHexColor,
                    "TMB"
                ));
            end

            -- Add the note
            tinsert(Lines, string.format(
                "|cFFFFFFFF    Note:|r |cFFFFF569%s|r",
                TMBNote
            ));
        end
    end

    -- No wishes defined for this item
    if (GL:empty(TMBInfo)) then
        return Lines;
    end

    local WishListEntries = {};
    local PrioListEntries = {};
    local itemIsOnSomeonesWishlist = false;
    local itemIsOnSomeonesPriolist = false;
    local entriesAdded = 0;
    for _, Entry in pairs(TMBInfo) do
        local playerName = string.lower(Entry.character);
        local prio = Entry.prio;
        local entryType = Entry.type or Constants.tmbTypeWish;
        local isOffSpec = string.find(Entry.character, "%(OS%)");
        local prioOffset = 0;
        local sortingOrder = prio;
        local color = GL:classHexColor(GL.Player:classByName(playerName:gsub("%(os%)", ""), 0), GL.Data.Constants.disabledTextColor);

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

        -- TMB is not case-sensitive so people get creative with capital letters sometimes
        playerName = GL:capitalize(playerName);
        if (entryType == Constants.tmbTypePrio) then
            tinsert(PrioListEntries, {sortingOrder, string.format("|cFF%s    %s[%s]|r", color, playerName, prio)});
            itemIsOnSomeonesPriolist = true;
        else
            tinsert(WishListEntries, {sortingOrder, string.format("|cFF%s    %s[%s]|r", color, playerName, prio)});
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
        local source = "TMB";
        if (self:wasImportedFromDFT()) then
            source = "DFT";
        elseif (self:wasImportedFromCPR()) then
            source = "CPR";
        elseif (self:wasImportedFromCSV()) then
            source = "Item";
        end
        tinsert(Lines, string.format("\n|cFFff7a0a%s|r", source .. " Prio List"));

        -- Sort the PrioListEntries based on prio (lowest to highest)
        table.sort(PrioListEntries, function (a, b)
            return a[1] < b[1];
        end);

        -- Add the entries to the tooltip
        entriesAdded = 0;
        for _, Entry in pairs(PrioListEntries) do
            entriesAdded = entriesAdded + 1;

            tinsert(Lines, string.format(
                "|cFF%s%s|r",
                GL:classHexColor(GL.Player:classByName(Entry[2], 0), GL.Data.Constants.disabledTextColor),
                GL:capitalize(Entry[2]):gsub("%(os%)", " (OS)")
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
        tinsert(Lines, string.format("\n|cFFffffff%s|r", "TMB Wish List"));

        -- Sort the WishListEntries based on prio (lowest to highest)
        table.sort(WishListEntries, function (a, b)
            return a[1] < b[1];
        end);

        -- Add the entries to the tooltip
        entriesAdded = 0;
        for _, Entry in pairs(WishListEntries) do
            entriesAdded = entriesAdded + 1;

            tinsert(Lines, string.format(
                "|cFF%s%s|r",
                GL:classHexColor(GL.Player:classByName(Entry[2], 0), GL.Data.Constants.disabledTextColor),
                GL:capitalize(Entry[2]):gsub("%(os%)", " (OS)")
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
---
---@return void
function TMB:draw(source)
    GL:debug("TMB:draw");

    -- No data available, show importer
    if (not self:available()) then
        GL.Interface.TMB.Importer:draw(source);
        return;
    end

    GL.Interface.TMB.Overview:draw();
end

--- Clear all TMB data
---
---@return void
function TMB:clear()
    GL.DB.TMB = {};

    GL.Events:fire("GL.TMB_CLEARED");
end

--- Check whether the current TMB data was imported from DFT
---
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
    GL:debug("TMB:import");

    local jsonDecodeSucceeded;
    local WebsiteData;
    local function displayGenericException()
        GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText("Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!");
    end

    if (type(data) ~= "string"
        or GL:empty(data)
    ) then
        displayGenericException();
        return false;
    end

    -- Make sure to get rid of any leadin/trailing whitespaces
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
            return GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText("Invalid CSV provided, the format is: 6948,player1,player2");
        end

    -- We might have the dft format on hands, let's check it out!
    elseif (GL:strStartsWith(firstLine, '"')) then
        triedToDecompress = true;
        data = self:DFTFormatToTMB(data);
        WebsiteData = data;

        if (not data) then
            return GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText("Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!");
        end
    end

    -- This is the new zlib format, attempt to decompress it!
    if (not triedToDecompress
        and not GL:strStartsWith(data, "{\"wishlists\":")
    ) then
        data = TMB:decompress(data);
        return TMB:import(data, true, source);
    end

    -- In case of a DFT format, data will already be a table
    if (type(data) ~= "table") then
        jsonDecodeSucceeded, WebsiteData = pcall(function () return GL.JSON:decode(data); end);

        -- Make sure the given string could actually be decoded
        if (not jsonDecodeSucceeded
            or not WebsiteData
            or type(WebsiteData) ~= "table"
        ) then
            GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText("Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!");
            return false;
        end
    end

    -- Import the actual TMB data
    local wishlistItemsWereImported = false;
    if (type(WebsiteData.wishlists) == "table"
        and not GL:empty(WebsiteData.wishlists)
    ) then
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
                local stringParts = GL:strSplit(characterString, "|");

                -- Check whether the format provided is the old (deprecated) format
                if (not formatDecided) then
                    local isOldFormat = GL:count(stringParts) > 4; -- The old TMB format has more than 4 parts

                    if (isOldFormat) then
                        Keys = {
                            name = 1,
                            order = 3,
                            type = 5,
                            groupID = nil, -- The old format doesn't support the groupID
                        };
                    end

                    formatDecided = true;
                end

                local characterName = "";
                local order = "?";
                local raidGroupID = nil;
                local type = Constants.tmbTypeWish;

                if (stringParts[Keys.name] and stringParts[Keys.order]) then
                    characterName = stringParts[Keys.name];
                    order = tonumber(stringParts[Keys.order]) or order;
                end

                if (stringParts[Keys.type]) then
                    local providedType = tonumber(stringParts[Keys.type]);

                    if (providedType == Constants.tmbTypePrio) then
                        type = Constants.tmbTypePrio;
                    end
                end

                if (Keys.groupID and stringParts[Keys.groupID]) then
                    raidGroupID = tonumber(stringParts[Keys.groupID]);
                end

                if (characterName and order) then
                    local checkSum = string.format('%s||%s||%s||%s||%s', itemID, characterName, order, type, raidGroupID or 0);

                    -- Make sure to ignore duplicates
                    if (not processedEntryCheckums[checkSum]) then
                        tinsert(TMBData[itemID], {
                            ["character"] = characterName,
                            ["prio"] = order,
                            ["type"] = type,
                            ['group'] = raidGroupID,
                        });

                        wishlistItemsWereImported = true;
                        processedEntryCheckums[checkSum] = true;
                    end
                end
            end
        end

        GL.DB.TMB.Items = TMBData;
    end

    -- There are item notes available, store them
    if (WebsiteData.notes and type(WebsiteData.notes) == "table") then
        for itemID, note in pairs(WebsiteData.notes) do
            GL.DB:set("TMB.Notes." .. itemID, note);
        end
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
        importedAt = GetServerTime(),
        hash = GL:uuid() .. GetServerTime(),
    };

    GL.Events:fire("GL.TMB_IMPORTED");
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

    return true;
end

--- Attempt to transform the DFT format to a TMB format
---
---@param data string
---@return boolean|table
function TMB:DFTFormatToTMB(data)
    GL:debug("TMB:DFTFormatToTMB");

    local TMBData = {
        importedFromDFT = true,
        wishlists = {},
    };

    data = data:gsub('"', "");

    local lineNumber;
    local increaseLineNumber = function ()
        lineNumber = lineNumber + 1;
    end;
    for _, entry in pairs(GL:strSplit(data, ";")) do
        local Priorities = {};
        local itemID;

        lineNumber = 1;
        for line in entry:gmatch("[^\n]+") do
            local validLine = true;

            (function ()
                local lineParts;

                -- The first line contains the item ID we're discussing
                if (lineNumber == 1) then
                    lineParts = GL:strSplit(line, "^");

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

                lineParts = GL:strSplit(line, "|");

                -- We can't handle this line it seems
                if (not lineParts[2]) then
                    return;
                end

                local player = lineParts[1];
                local priority = tonumber(lineParts[2]);

                if (GL:empty(player)
                    or not GL:higherThanZero(priority)
                ) then
                    return;
                end

                tinsert(Priorities, {player = player, priority = priority});

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

    -- Rewrite the priorities to match DFTs behavior
    for itemID, Priorities in pairs(TMBData.wishlists) do
        local lastPriority = 99999;
        local priorityIndex = 0;

        -- Sort the priorities (highest to lowest)
        table.sort(Priorities, function (a, b)
            return a.priority > b.priority;
        end);

        for key, Priority in pairs(Priorities) do
            if (Priority.priority < lastPriority) then
                lastPriority = Priority.priority;
                priorityIndex = priorityIndex + 1;
            end

            TMBData.wishlists[itemID][key] = string.format("%s||%s||1||1", string.lower(Priority.player), priorityIndex);
        end
    end

    return TMBData;
end

--- Attempt to transform the Gargul CSV format to a TMB format
---
---@param data string
---@return boolean|table
function TMB:CSVFormatToTMB(data)
    GL:debug("TMB:CSVFormatToTMB");

    local TMBData = {
        importedFromCSV = true,
        wishlists = {},
    };

    --[[
        6948,zhorax[1],feth[2],arvada[3],arrafart[3],ratomir[4],tonio[99]
        1372,ratomir[1],zhorax[2],feth[3],arvada[4],arrafart[4],vejusatko[99]

        OR

        6948,vejusatko,zhorax,feth,arvada,arrafart,ratomir
        1372,ratomir,tonio|zhorax,feth,arvada,arrafart
    ]]

    for line in data:gmatch("[^\n]+") do
        local Priorities = {};
        local itemID;

        (function ()
            local priority = 1;
            local CSVParts;
            CSVParts = GL:strSplit(line, ",");

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
                    local player = string.lower(GL:stripRealm(priorityEntry));
                    local playerPriority = player:match("(%[[0-9]+%])");

                    if (playerPriority) then
                        local openingBracketPosition = string.find(player, "%[");
                        player = string.sub(player, 1, openingBracketPosition - 1);
                        priority = playerPriority:match("([0-9]+)");
                    elseif (string.find(player, "%|")) then
                        local Players = GL:strSplit(player, "|");

                        for _, playerName in pairs(Players) do
                            if (not GL:empty(playerName)) then
                                tinsert(Priorities, {player = playerName, priority = priority});
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
            TMBData.wishlists[itemID][key] = string.format("%s||%s||1||1", string.lower(PriorityEntry.player), PriorityEntry.priority);
        end
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
        local errorMessage = "Unable to base64 decode the data. Make sure you copy/paste it as-is from thatsmybis.com without changing anything!";
        GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return "";
    end

    local LibDeflate = LibStub:GetLibrary("LibDeflate");
    local zlibDecodeSucceeded;
    zlibDecodeSucceeded, data = pcall(function () return LibDeflate:DecompressZlib(data); end);

    -- Something went wrong while zlib decoding the payload
    if (not zlibDecodeSucceeded) then
        local errorMessage = "Unable to zlib decode the data. Make sure you copy/paste it as-is from thatsmybis.com without changing anything!";
        GL.Interface:get("TMB.Importer", "Label.StatusMessage"):SetText(errorMessage);
        return "";
    end

    return data;
end

--- Broadcast the TMB to the RAID / PARTY
---@return boolean
function TMB:broadcast()
    GL:debug("TMB:broadcast");

    if (self.broadcastInProgress) then
        GL:error("Broadcast still in progress");
        return false;
    end

    if (not GL.User.isInGroup) then
        GL:warning("No one to broadcast to, you're not in a group!");
        return false;
    end

    if (not GL.User.hasAssist
        and not GL.User.isMasterLooter
    ) then
        GL:warning("Insufficient permissions to broadcast, need ML, assist or lead!");
        return false;
    end

    -- Check if there's anything to share
    if (not self:available()) then
        GL:warning("Nothing to broadcast, import TMB data first!");
        return false;
    end

    self.broadcastInProgress = true;
    GL.Events:fire("GL.TMB_BROADCAST_STARTED");

    local Broadcast = function ()
        GL:message("Broadcasting TMB data...");

        local Label = GL.Interface:get(GL.TMB, "Label.BroadcastProgress");

        if (Label) then
            Label:SetText("Broadcasting...");
        end

        GL.CommMessage.new(
            CommActions.broadcastTMBData,
            GL.DB.TMB,
            "GROUP"
        ):send(function ()
            GL:success("TMB broadcast finished");
            self.broadcastInProgress = false;
            GL.Events:fire("GL.TMB_BROADCAST_ENDED");

            Label = GL.Interface:get(GL.TMB, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText("Broadcast finished!");
            end

            -- Make sure to broadcast the loot priorities as well
            GL.LootPriority:broadcast();
        end, function (sent, total)
            Label = GL.Interface:get(GL.TMB, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText(string.format("Sent %s of %s bytes", sent, total));
            end
        end);
    end

    -- We're about to send a lot of data which will put strain on CTL
    -- Make sure we're out of combat before doing so!
    if (UnitAffectingCombat("player")) then
        GL:message("You are currently in combat, delaying TMB broadcast");

        GL.Events:register("TMBOutOfCombatListener", "PLAYER_REGEN_ENABLED", function ()
            GL.Events:unregister("TMBOutOfCombatListener");
            Broadcast();
        end);
    else
        Broadcast();
    end

    return true;
end

--- Process an incoming TMB broadcast
---
---@param CommMessage CommMessage
function TMB:receiveBroadcast(CommMessage)
    GL:debug("TMB:receiveBroadcast");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.id == GL.User.id) then
        GL:debug("TMB:receiveBroadcast received by self, skip");
        return true;
    end

    local Data = CommMessage.content;
    if (not GL:empty(Data)) then
        GL:warning("Attempting to process incoming TMB data from " .. CommMessage.Sender.name);

        if (type(Data) ~= "table" or GL:empty(Data)
            or type(Data.Items) ~= "table" or GL:empty(Data.Items)
            or GL:empty(GL:tableGet(Data, "MetaData.importedAt"))
        ) then
            GL:error("Invalid TMB data received from " .. CommMessage.Sender.name);
            return;
        end

        -- Validate dataset
        for itemID, Entries in pairs(Data.Items) do
            itemID = tonumber(itemID);

            if (GL:empty(itemID)) then
                GL:error("Invalid TMB data received from " .. CommMessage.Sender.name);
                return;
            end

            for _, Entry in pairs(Entries) do
                if (GL:empty(Entry.character)
                    or GL:empty(Entry.prio)
                    or GL:empty(Entry.type)
                ) then
                    GL:error("Invalid TMB data received from " .. CommMessage.Sender.name);
                    return;
                end
            end
        end

        GL:success("TMB data synced");
        GL.DB.TMB = Data;
    end
end

--- Request TMB data from the person in charge (ML or Leader)
---
---@return void
function TMB:requestData()
    GL:debug("TMB:requestData");

    if (self.requestingData) then
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
    GL.CommMessage.new(
        CommActions.requestTMBData,
        {
            currentHash = GL.DB:get('TMB.MetaData.hash', nil),
        },
        "WHISPER",
        playerToRequestFrom
    ):send();

    self.requestingData = false;
end

--- Reply to a player's TMB data request
---
---@param CommMessage CommMessage
---@return void
function TMB:replyToDataRequest(CommMessage)
    GL:debug("TMB:replyToDataRequest");

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

    local playerTMBHash = CommMessage.content.currentHash or '';
    -- Your data is the same as mine, leave me alone!
    if (not GL:empty(playerTMBHash)
        and playerTMBHash == GL.DB:get('TMB.MetaData.hash')
    ) then
        return;
    end

    -- Looks like you need my data, here it is!
    GL.CommMessage.new(
        CommActions.broadcastTMBData,
        GL.DB.TMB,
        "WHISPER",
        CommMessage.Sender.name
    ):send(function ()
        -- Make sure to broadcast the loot priorities as well
        GL.LootPriority:broadcastToPlayer(CommMessage.Sender.name);
    end);
end

--- Check whether the current user is allowed to broadcast TMB data
---
---@return boolean
function TMB:userIsAllowedToBroadcast()
    return GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist);
end

GL:debug("WishLists.lua");