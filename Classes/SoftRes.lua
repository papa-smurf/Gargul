local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type DB
local DB = GL.DB;

---@type Constants
local Constants = GL.Data.Constants;

---@type CommActions
local CommActions = Constants.Comm.Actions;

---@type Settings
local Settings = GL.Settings; ---@type Settings

---@class SoftRes
local SoftRes = {
    _initialized = false,
    announcedImportSoftResAt = false,
    broadcastInProgress = false,
    maxNumberOfSoftReservedItems = 6,
    requestingData = false,
    lastTooltipData = nil,
    lastTooltipItemLink = nil,
    lastTooltipTime = nil,

    MaterializedData = {
        ClassByPlayerName = {},
        DetailsByPlayerName = {},
        HardReserveDetailsByID = {},
        PlayerNamesByItemID = {},
        ReservedItemIDs = {},
        SoftReservedItemIDs = {},
    },
};
GL.SoftRes = SoftRes;

--- @return boolean
function SoftRes:_init()
    if (self._initialized) then
        return false;
    end

    --- Connect to LootReserve
    GL.Ace:ScheduleTimer(function()
        if (type(_G.LootReserve) ~= "table"
            or type(_G.LootReserve.RegisterListener) ~= "function"
        ) then
            return;
        end

        local success, result = pcall(function()
            return _G.LootReserve:RegisterListener(
                "RESERVES",
                GL.name,
                function(Reserves)
                    self:importLootReserveData(Reserves);
                end
            );
        end);

        if (success and result) then
            _G.LootReserve:PromptListener("RESERVES", GL.name)
        else
            GL:error(L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING);
            DevTools_Dump{ success, result };
        end
    end, 5);

    --- Register listener for whisper command.
    GL.Events:register("SoftResWhisperListener", "CHAT_MSG_WHISPER", function (event, message, sender)
        if (self:available()
            and self:userIsAllowedToBroadcast()
            and GL.Settings:get("SoftRes.enableWhisperCommand", true)
        ) then
            self:handleWhisperCommand(event, message, sender);
        end
    end);

    --- Show an alert or a system message after sucessfully importing data
    GL.Events:register("AlertsSoftresImported", "GL.SOFTRES_IMPORTED", function ()
        if (not GL.Interface.Alerts:fire("GargulNotification", {
            message = "|c00BE3333" .. L.SOFTRES_IMPORT_SUCCESSFUL_ALERT .. "|r",
        })) then
            GL:success(L.SOFTRES_IMPORT_SUCCESSFUL);
        end
    end);

    -- Remove old SoftRes data if it's more than 10h old
    if (self:available()
        and DB:get("SoftRes.MetaData.importedAt") < GetServerTime() - 36000
    ) then
        self:clear();
    end

    GL.Events:register("SoftResUserJoinedGroupListener", "GL.USER_JOINED_NEW_GROUP", function () self:requestData(); end);

    -- If the user reloads instead of a login we have to wait a couple seconds for the game to update the group setup
    GL:after(5, "SoftResRequestDataAfterReload", function ()
        if (not GL.User.isInGroup) then
            return;
        end

        -- Check if we need to sync up with an existing multi-auction session
        self:requestData();
    end);
    
    local reportStatus = false; -- No need to notify of "fixed" names after every /reload
    self:materializeData(reportStatus);

    self._initialized = true;
    return true;
end

--- Checks and handles whisper commands if enabled.
---
---@param _ string
---@param message string
---@param sender string
---@return void
function SoftRes:handleWhisperCommand(_, message, sender)
    local validPrefixDetected = false;
    for _, prefix in pairs(GL:explode(L.SOFTRES_WHISPER_PREFIXES, "|") or {}) do
        if (GL:strStartsWith(message, prefix)) then
            validPrefixDetected = true;
            break;
        end
    end

    if (not validPrefixDetected) then
        return;
    end

    local name = GL:disambiguateName(sender);

    -- Fetch everything soft-reserved by the sender
    local Reserves = GL:tableGet(self.MaterializedData.DetailsByPlayerName, string.format(
        "%s.Items",
        string.lower(name)
    ), {});

    -- Nothing reserved
    if (GL:empty(Reserves)) then
        GL:sendChatMessage(
            L.CHAT.SOFTRES_NO_RESERVES_REPLY,
            "WHISPER", nil, sender
        );

        return;
    end

    -- Make sure to preload all items with their corresponding item link before moving on
    local ItemIDs = {};
    for itemID in pairs(Reserves) do
        tinsert(ItemIDs, itemID);
    end

    GL:onItemLoadDo(ItemIDs, function (Details)
        local Entries = {};

        for _, Entry in pairs(Details) do
            local itemIDString = tostring(Entry.id);
            local entryString = Entry.link;

            if (Reserves[itemIDString] > 1) then
                entryString = (L.CHAT.SOFTRES_MY_RESERVED_ITEM_REPLY):format(entryString, Reserves[itemIDString]);
            end

            tinsert(Entries, entryString);
        end

        -- Let the sender know what he/she soft-reserved
        if (not GL:empty(Entries)) then
            GL:sendChatMessage(
                (L.CHAT.SOFTRES_MY_RESERVES_REPLY):format(table.concat(Entries, " ")),
                "WHISPER", nil, sender
            );

            return;
        end
    end);
end

--- Check whether there are soft-reserves available
---
---@return boolean
function SoftRes:available()
    return GL:higherThanZero(DB:get("SoftRes.MetaData.importedAt", 0));
end

--- Request SoftRes data from the person in charge (ML or Leader)
---
---@return void
function SoftRes:requestData()
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
    -- He will compare the ID and updatedAt timestamp on his end to see if we actually need his data
    GL.CommMessage.new{
        action = CommActions.requestSoftResData,
        content = {
            currentSoftResID = GL.DB:get('SoftRes.MetaData.id'),
            softResDataUpdatedAt = GL.DB:get('SoftRes.MetaData.updatedAt'),
        },
        channel = "WHISPER",
        recipient = playerToRequestFrom,
    }:send();

    self.requestingData = false;
end

--- Reply to a player's SoftRes data request
---
---@param CommMessage CommMessage
---@return void
function SoftRes:replyToDataRequest(CommMessage)
    -- I don't have any data, leave me alone!
    if (not self:available()) then
        return;
    end

    -- We're not in a group (anymore), no need to help this person out
    if (not GL.User.isInGroup) then
        return;
    end

    -- Nice try, but our SoftRes is marked as "hidden", no data for you!
    if (GL.DB:get('SoftRes.MetaData.hidden', true)) then
        return;
    end

    local playerSoftResID = CommMessage.content.currentSoftResID or '';
    local playerSoftResUpdatedAt = tonumber(CommMessage.content.softResDataUpdatedAt) or 0;

    -- Your data is newer than mine, leave me alone!
    if (not GL:empty(playerSoftResID)
        and playerSoftResUpdatedAt > 0
        and playerSoftResID == GL.DB:get('SoftRes.MetaData.id', '')
        and playerSoftResUpdatedAt > GL.DB:get('SoftRes.MetaData.updatedAt', 0)
    ) then
        return;
    end

    -- Looks like you need my data, here it is!
    GL.CommMessage.new{
        action = CommActions.broadcastSoftRes,
        content = DB:get("SoftRes.MetaData.importString"),
        channel = "WHISPER",
        recipient = CommMessage.senderFqn,
    }:send();
end

--- Check if an item is reserved by the current player
---
---@param itemIdentifier number|string
---@return boolean
function SoftRes:itemIsReservedByMe(itemIdentifier)
    local itemID = tonumber(itemIdentifier);
    local identifierIsLink = type(itemIdentifier) == "string";

    -- A string was provided, treat it as an item link and fetch its ID
    if (not itemID
        and identifierIsLink
    ) then
        itemID = GL:getItemIDFromLink(itemIdentifier);
    end

    if (not itemID) then
        return false;
    end

    return self:itemIDIsReservedByPlayer(itemID, GL.User.fqn);
end

--- Check if an item ID is reserved by the current player
---
---@param itemID number
---@return boolean
function SoftRes:itemIDIsReservedByMe(itemID)
    return self:itemIDIsReservedByPlayer(itemID, GL.User.fqn);
end

--- Check if an itemlink is reserved by the current player
---
---@param itemLink string
---@return boolean
function SoftRes:itemLinkIsReservedByMe(itemLink)
    return self:itemIDIsReservedByMe(GL:getItemIDFromLink(itemLink));
end

--- Materialize the SoftRes data to make it more accessible during runtime
---
---@return boolean
function SoftRes:materializeData()
    local ReservedItemIDs = {}; -- All reserved item ids (both soft- and hard)
    local SoftReservedItemIDs = {}; -- Soft-reserved item ids
    local DetailsByPlayerName = {}; -- Item ids per player name
    local PlayerNamesByItemID = {}; -- Player names per reserved item id
    local HardReserveDetailsByID = {}; -- Hard reserve details per item id

    for _, SoftResEntry in pairs(DB:get("SoftRes.SoftReserves", {})) do
        local class = string.lower(SoftResEntry.class or "");
        local name = string.lower(SoftResEntry.name or "");
        local note = SoftResEntry.note or "";
        local plusOnes = SoftResEntry.plusOnes or 0;

        if (type(name) == "string"
            and not GL:empty(name)
        ) then
            if (not DetailsByPlayerName[name]) then
                GL:tableSet(DetailsByPlayerName, name .. ".Items", {});
                DetailsByPlayerName[name].note = note;
                DetailsByPlayerName[name].class = class;

                if (GL:higherThanZero(plusOnes)) then
                    DetailsByPlayerName[name].plusOnes = plusOnes;
                else
                    DetailsByPlayerName[name].plusOnes = 0;
                end
            end

            -- Store the player's class in the ClassByPlayerName array if the class is valid
            if (not GL:empty(class)
                and Constants.Classes[class]
            ) then
                self.MaterializedData.ClassByPlayerName[name] = class;
            end

            for _, itemID in pairs(SoftResEntry.Items or {}) do
                if (GL:higherThanZero(itemID)) then
                    local _, itemType = GL:getItemInfoInstant(itemID);
                    if (not itemType) then
                        self:clearCorrupted();
                        return false;
                    end

                    -- This seems very counterintuitive, but using numeric keys
                    -- in a lua tables has some insanely annoying drawbacks
                    local idString = tostring(itemID);

                    if (not PlayerNamesByItemID[idString]) then
                        PlayerNamesByItemID[idString] = {};
                    end

                    -- It's now possible to reserve the same item multiple times so we no longer
                    -- check whether the given playername is unique!
                    tinsert(PlayerNamesByItemID[idString], name);

                    if (DetailsByPlayerName[name].Items[idString]) then
                        DetailsByPlayerName[name].Items[idString] = DetailsByPlayerName[name].Items[idString] + 1;
                    else
                        DetailsByPlayerName[name].Items[idString] = 1;
                    end
                end
            end
        end
    end

    for _, HardResEntry in pairs(DB:get("SoftRes.HardReserves", {})) do
        local id = tonumber(HardResEntry.id or 0);
        local reservedFor = GL:capitalize(HardResEntry["for"] or "");
        local note = HardResEntry.note or "";

        if (GL:higherThanZero(id)) then
            HardReserveDetailsByID[tostring(id)] = {
                id = id,
                reservedFor = reservedFor,
                note = note,
            };
        end
    end

    local reservedItemIDsIndex = 1;
    for idString in pairs(PlayerNamesByItemID) do
        SoftReservedItemIDs[idString] = true;
        ReservedItemIDs[idString] = reservedItemIDsIndex;

        reservedItemIDsIndex = reservedItemIDsIndex + 1;
    end

    for idString in pairs(HardReserveDetailsByID) do
        if (not ReservedItemIDs[idString]) then
            ReservedItemIDs[idString] = reservedItemIDsIndex;
            reservedItemIDsIndex = reservedItemIDsIndex + 1;
        end
    end

    self.MaterializedData.DetailsByPlayerName = DetailsByPlayerName;
    self.MaterializedData.HardReserveDetailsByID = HardReserveDetailsByID;
    self.MaterializedData.PlayerNamesByItemID = PlayerNamesByItemID;
    self.MaterializedData.ReservedItemIDs = GL:tableFlip(ReservedItemIDs);
    self.MaterializedData.SoftReservedItemIDs = SoftReservedItemIDs;

    return true;
end

--- Draw either the importer or overview
--- based on the current soft-reserve data
function SoftRes:draw()
    -- No data available, show importer
    if (not self:available()) then
        GL.Interface.SoftRes.Importer:draw();
        return;
    end

    -- No items were reserved yet (this is possible!)
    if (GL:empty(self.MaterializedData.ReservedItemIDs)) then
        return GL.Interface.SoftRes.Overview:draw();
    end

    -- Show the soft-reserve overview after all items are loaded
    -- This is to ensure that all item data is available before we draw the UI
    GL:onItemLoadDo(
        self.MaterializedData.ReservedItemIDs or {},
        function (_, error)
            if (not error) then
                return GL.Interface.SoftRes.Overview:draw();
            end

            self:clearCorrupted();
        end
    );
end

---@param itemID number|string
---@return nil|string, nil|string
function SoftRes:getHardReserveDetailsByID(itemID)
    local Details = GL:tableGet(SoftRes, "MaterializedData.HardReserveDetailsByID." .. tostring(itemID));

    if (not Details) then
        return;
    end

    return Details.reservedFor, Details.note;
end

---@param itemLink string
---@return nil|string, nil|string
function SoftRes:getHardReserveDetailsByItemLink(itemLink)
    return self:getHardReserveDetailsByID(GL:getItemIDFromLink(itemLink));
end

--- Get soft-reserve details for a given player
---
---@param name string The name of the player
---@return table
function SoftRes:getDetailsForPlayer(name)
    name = string.lower(name);

    if (GL:empty(name)) then
        return {};
    end

    return GL:tableGet(self.MaterializedData.DetailsByPlayerName or {}, name, {});
end

--- Get a player's class by his name or return the default
---
---@param name string The name of the player
---@param defaultClass string|nil The default class in case the player's class could not be determined
function SoftRes:getPlayerClass(name, defaultClass)
    name = string.lower(name);
    defaultClass = defaultClass or "priest";

    -- We try to fetch the class from the softreserve data first
    local ClassByPlayerName = self.MaterializedData.ClassByPlayerName or {};
    if (ClassByPlayerName[name]) then
        return ClassByPlayerName[name]
    end

    return GL.Player:classByName(name, defaultClass);
end

--- Check whether a given item id is reserved (either soft or hard)
---
---@param itemID number|string
---@param inRaidOnly? boolean
---@return boolean
function SoftRes:idIsReserved(itemID, inRaidOnly)
    if (type(inRaidOnly) ~= "boolean") then
        inRaidOnly = GL.User.isInGroup and Settings:get("SoftRes.hideInfoOfPeopleNotInGroup");
    end

    -- The item is hard-reserved
    if (self:IDIsHardReserved(itemID)) then
        return true;
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIDs = GL:getLinkedItemsForID(itemID, true);

    for _, itemID in pairs(AllLinkedItemIDs or {}) do
        local idString = tostring(itemID);
        local Reserves = self.MaterializedData.PlayerNamesByItemID[idString];

        if (Reserves) then
            if (not inRaidOnly) then
                return true;
            end

            for _, name in pairs(Reserves) do
                if (GL.User:unitInGroup(name)) then
                    return true;
                end
            end
        end
    end

    return false;
end

--- Check whether a given itemLink is reserved (either soft or hard)
---
---@param itemLink string
---@param inRaidOnly boolean
---@return boolean
function SoftRes:linkIsReserved(itemLink, inRaidOnly)
    return self:idIsReserved(GL:getItemIDFromLink(itemLink), inRaidOnly);
end

--- Check whether a given item id is hard-reserved
---
---@param itemID number|string
---@return boolean
function SoftRes:IDIsHardReserved(itemID)
    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIDs = GL:getLinkedItemsForID(itemID, true);

    for _, itemID in pairs(AllLinkedItemIDs or {}) do
        if (self.MaterializedData.HardReserveDetailsByID[tostring(itemID)] ~= nil) then
            return true;
        end
    end

    return false;
end

--- Check whether a given itemlink is hard-reserved
---
---@param itemLink string
---@return boolean
function SoftRes:linkIsHardReserved(itemLink)
    return self:IDIsHardReserved(GL:getItemIDFromLink(itemLink));
end

--- Clear all SoftRes data
---
---@return void
function SoftRes:clear()
    DB:set("SoftRes", {});
    self.MaterializedData = {
        ClassByPlayerName = {},
        DetailsByPlayerName = {},
        HardReserveDetailsByID = {},
        PlayerNamesByItemID = {},
        ReservedItemIDs = {},
        SoftReservedItemIDs = {},
    };

    GL.Interface.SoftRes.Overview:close();

    GL.Events:fire("GL.SOFTRES_CLEARED");
end

--- Clear our data and let the user know that we encountered corruped data
function SoftRes:clearCorrupted()
    self:clear();
    self:draw();
    GL:error("One or more items could not be found. SoftRes was cleared. Make sure you import items that exist for this game version ( classic / SoD / retail )!");
end

--- Check whether the given player reserved the given item id
---
---@param itemID number|string
---@param playerName string
---@return boolean
function SoftRes:itemIDIsReservedByPlayer(itemID, playerName)
    local SoftResData = self.MaterializedData.PlayerNamesByItemID or {};

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIDs = GL:getLinkedItemsForID(itemID, true);

    for _, itemID in pairs(AllLinkedItemIDs or {}) do
        if (GL:inTable(
            SoftResData[tostring(itemID)] or {},
            string.lower(GL:disambiguateName(playerName))
        )) then
            return true;
        end
    end

    return false;
end

--- Fetch an item's reservations based on its ID
---
---@param itemID number|string
---@param inRaidOnly? boolean
---
---@return table
---
---@test /dump _G.Gargul.SoftRes:byItemID(52030);
function SoftRes:byItemID(itemID, inRaidOnly)
    -- An invalid item id was provided
    itemID = tonumber(itemID);
    if (not GL:higherThanZero(itemID)) then
        return {};
    end

    if (type(inRaidOnly) ~= "boolean") then
        inRaidOnly = GL.User.isInGroup and Settings:get("SoftRes.hideInfoOfPeopleNotInGroup");
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIDs = GL:getLinkedItemsForID(itemID, true);

    local GroupMemberNames = {};
    if (inRaidOnly) then
        GroupMemberNames = GL.User:groupMemberNames();
    end

    local ActiveReservations = {};
    for _, id in pairs(AllLinkedItemIDs) do
        local idString = tostring(id);

        -- If inRaidOnly is true we need to make sure we only return details of people who are actually in the raid
        for _, playerName in pairs(GL:tableGet(self.MaterializedData.PlayerNamesByItemID or {}, idString, {})) do
            if (not inRaidOnly or GL:inTable(GroupMemberNames, playerName)) then
                tinsert(ActiveReservations, playerName);
            end
        end
    end

    return ActiveReservations;
end

--- Fetch an item's soft reserves based on its item link
---
---@param itemLink string
---@param inRaidOnly boolean
---
---@return table
---
---@test /dump _G.Gargul.SoftRes:byItemLink("|cffa335ee|Hitem:52030::::::::80:::::|h[Conqueror's Mark of Sanctification]|h|r");
function SoftRes:byItemLink(itemLink, inRaidOnly)
    return self:byItemID(GL:getItemIDFromLink(itemLink), inRaidOnly);
end

--- Fetch an item's soft reserve amounts in a "Playername (x3)" format
---
---@param itemID number
---@param inRaidOnly? boolean
---@return table
function SoftRes:playerReserveAmountsByItemID(itemID, inRaidOnly)
    local SoftReserves = self:byItemID(itemID, inRaidOnly);
    local ActiveSoftResDetails = {};

    local ReservationsByPlayerName = {};
    for _, playerName in pairs(SoftReserves) do
        if (not ReservationsByPlayerName[playerName]) then
            ReservationsByPlayerName[playerName] = 1;
        else
            ReservationsByPlayerName[playerName] = ReservationsByPlayerName[playerName] + 1;
        end
    end

    -- This is necessary so we can sort the table based on number of reserves per item
    local Reservations = {};
    for playerName, reservations in pairs(ReservationsByPlayerName) do
        tinsert(Reservations, {
            player = playerName,
            reservations = reservations,
        })
    end
    ReservationsByPlayerName = {}; -- We no longer need this table, clean it up!

    -- Sort the reservations based on whoever reserved it more often (highest to lowest)
    table.sort(Reservations, function (a, b)
        if (a.reservations and b.reservations) then
            return a.reservations > b.reservations;
        end

        return false;
    end);

    -- Add the reservation details to ActiveReservations (add 2x / 3x etc when same item was reserved multiple times)
    for _, Entry in pairs(Reservations) do
        local entryString = Entry.player;

        -- User reserved the same item multiple times
        if (Entry.reservations > 1) then
            entryString = string.format("%s (%sx)", GL:nameFormat{ name = Entry.player, }, Entry.reservations);
        end

        tinsert(ActiveSoftResDetails, GL:capitalize(entryString));
    end

    return ActiveSoftResDetails;
end

--- Fetch an item's soft reserve amounts in a "Playername (x3)" format
---
---@param itemID number
---@param inRaidOnly boolean
---
---@return table
---
---@test /dump _G.Gargul.SoftRes:playerReserveAmountsByItemLink("|cffa335ee|Hitem:52030::::::::80:::::|h[Conqueror's Mark of Sanctification]|h|r");
function SoftRes:playerReserveAmountsByItemLink(itemLink, inRaidOnly)
    return self:playerReserveAmountsByItemID(GL:getItemIDFromLink(itemLink), inRaidOnly);
end

--- Append the soft reserves as defined in DB.SoftRes to an item's tooltip
---
---@param itemLink string
---@return table
function SoftRes:tooltipLines(itemLink)
    -- The player doesn't want to see softres details on tooltips
    if (not Settings:get("SoftRes.enableTooltips")) then
        return {};
    end

    local Lines = {};

    -- Check if the item is hard-reserved
    local hardReservedFor, hardReservedNote = self:getHardReserveDetailsByItemLink(itemLink);
    if (hardReservedFor or hardReservedNote) then
        tinsert(Lines, ("\n|cFFcc2743%s|r"):format(L.SOFTRES_TOOLTIP_HARD_RESERVED));
        if (hardReservedFor) then
            tinsert(Lines, ("|cFFcc2743 %s|r"):format(
                (L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR):format(GL:nameFormat{ name = hardReservedFor, colorize = true, }))
            );
        end

        if (hardReservedNote) then
            tinsert(Lines, (L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE):format(hardReservedNote));
        end

        return Lines;
    end

    local Reservations = self:byItemLink(itemLink);

    local itemHasActiveReservations = false;
    local ReservationsByPlayerName = {};
    for _, playerName in pairs(Reservations) do
        if (not ReservationsByPlayerName[playerName]) then
            ReservationsByPlayerName[playerName] = 1;
        else
            ReservationsByPlayerName[playerName] = ReservationsByPlayerName[playerName] + 1;
        end

        itemHasActiveReservations = true;
    end

    -- No active reservations were found for this item
    if (not itemHasActiveReservations) then
        return {};
    end

    -- Add the header
    tinsert(Lines, ("\n|cFFEFB8CD%s|r"):format(L.SOFTRES_TOOLTIP_RESERVED_BY));

    -- This is necessary so we can sort the table based on number of reserves per item
    local ActiveReservations = {};
    for playerName, reservations in pairs(ReservationsByPlayerName) do
        tinsert(ActiveReservations, {
            player = playerName,
            reservations = reservations,
        });
    end
    ReservationsByPlayerName = {}; -- We no longer need this table, clean it up!

    -- Sort the reservations based on whoever reserved it more often (highest to lowest)
    table.sort(ActiveReservations, function (a, b)
        if (a.reservations and b.reservations) then
            return a.reservations > b.reservations;
        end

        return false;
    end);

    -- Add the reservation details to ActiveReservations (add 2x / 3x etc when same item was reserved multiple times)
    for _, Entry in pairs(ActiveReservations) do
        local class = self:getPlayerClass(Entry.player, 0);
        local entryString = ("|c00%s%s"):format(
            GL:classHexColor(class, GL.Data.Constants.disabledTextColor),
            GL:capitalize(Entry.player)
        );

        -- User reserved the same item multiple times
        if (Entry.reservations > 1) then
            entryString = (L.SOFTRES_MULTIPLE_RESERVES):format(entryString, Entry.reservations);
        end

        -- Add the actual soft reserves to the tooltip
        tinsert(Lines, entryString);
    end

    return Lines;
end

--- How many times did the given player reserve the given item?
---
---@param idOrLink number|string
---@param playerName string
---@return number
function SoftRes:playerReservesOnItem(idOrLink, playerName)
    local concernsID = GL:higherThanZero(tonumber(idOrLink));
    local itemID;

    if (concernsID) then
        itemID = math.floor(tonumber(idOrLink));
    else
        itemID = GL:getItemIDFromLink(idOrLink);
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIDs = GL:getLinkedItemsForID(itemID, true);

    local reserved = 0;

    for _, itemID in pairs(AllLinkedItemIDs or {}) do
        reserved = reserved + GL:tableGet(self.MaterializedData.DetailsByPlayerName, string.format(
            "%s.Items.%s",
            string.lower(playerName),
            itemID
        ), 0);
    end

    return reserved;
end

--- Try to import the data provided in the import window
---
---@param data string
---@return boolean
function SoftRes:import(data, openOverview)
    openOverview = GL:toboolean(openOverview);
    local broadcast = openOverview; -- Automatically broadcast after importing?
    local reportStatus = openOverview; -- Notify of fixed names and other messages?
    local success = false;

    -- Make sure all the required properties are available and of the correct type
    if (GL:empty(data)) then
        GL.Interface:get("SoftRes.Importer", "Label.StatusMessage"):SetText(L.SOFTRES_IMPORT_INVALID);
        return false;
    end

    -- A CSV string was provided, import it
    if (GL:strContains(data, ",")) then
        success = self:importCSVData(data, reportStatus);
    else
        -- Assume Gargul data was provided
        success = self:importGargulData(data);
    end

    -- Whatever the data was, we couldn't import it
    if (not success) then
        return false;
    end

    -- Attempt to "fix" player names (e.g. people misspelling their names)
    if (Settings:get("SoftRes.fixPlayerNames", true)) then
        local RewiredNames = self:fixPlayerNames();

        if (reportStatus) then
            for softResName, playerName in pairs(RewiredNames) do
                GL:notice(string.format(
                    L.SOFTRES_IMPORT_FIXED_NAME,
                    GL:capitalize(softResName),
                    GL:nameFormat{ name = playerName, colorize = true, }
                ));
            end
        end
    end

    -- Reset the materialized data
    self.MaterializedData = {
        ClassByPlayerName = {},
        DetailsByPlayerName = {},
        HardReserveDetailsByID = {},
        PlayerNamesByItemID = {},
        ReservedItemIDs = {},
        SoftReservedItemIDs = {},
    };

    -- Materialize the data for ease of use
    if (not self:materializeData()) then
        return;
    end

    GL.Events:fire("GL.SOFTRES_IMPORTED");

    if (reportStatus) then
        -- Display missing soft-reserves
        local PlayersWhoDidntReserve = self:playersWithoutSoftReserves();
        if (not GL:empty(PlayersWhoDidntReserve)) then
            local MissingReservers = {};
            for _, name in pairs(PlayersWhoDidntReserve) do
                tinsert(MissingReservers, GL:nameFormat{ name = name, colorize = true, });
            end

            GL:warning(L.SOFTRES_IMPORT_NO_RESERVES_WARNING);
            GL:message(table.concat(MissingReservers, " "));
        end
    end

    GL.Interface.SoftRes.Importer:close();

    if (broadcast
        and self:userIsAllowedToBroadcast()
    ) then
        -- Automatically broadcast this data if it's not marked as "hidden" and the user has the required permissions
        if (not GL.DB:get('SoftRes.MetaData.hidden', true)) then
            self:broadcast();
        end
    end

    -- Yes, we need to repeat this if-statement since userIsAllowedToBroadcast includes its own isInGroup check
    if (not GL.User.isInGroup
        or (broadcast
            and self:userIsAllowedToBroadcast()
        )
    ) then
        -- Let everyone know how to double-check their soft-reserves
        if (GL.Settings:get("SoftRes.enableWhisperCommand", true)
            and (not GL.User.isInGroup
                or not self.announcedImportSoftResAt -- Hasn't been announced yet
                or self.announcedImportSoftResAt <= GetServerTime() - 300 -- Was announced 5 minutes ago or more
            )
        ) then
            GL:sendChatMessage(
                L.CHAT.SOFTRES_DATA_IMPORTED,
                "GROUP"
            );
        end
    end

    if (openOverview) then
        self:draw();
    end

    return true;
end

--- Import data from LootReserve. This happens automatically via an event listener
---
---@param Reserves table
---@return void
function SoftRes:importLootReserveData(Reserves)
    if (GL:empty(Reserves)) then
        return;
    end

    local SoftReserveData = {};
    for player, Reserved in pairs(Reserves or {}) do
        if (not GL:empty(Reserved)) then
            SoftReserveData[player] = {
                Items = Reserved,
                name = string.lower(player),
            };
        end
    end

    if (GL:empty(SoftReserveData)) then
        return;
    end

    -- Reset the materialized data
    self.MaterializedData = {
        ClassByPlayerName = {},
        DetailsByPlayerName = {},
        HardReserveDetailsByID = {},
        PlayerNamesByItemID = {},
        ReservedItemIDs = {},
        SoftReservedItemIDs = {},
    };

    DB:set("SoftRes", {
        SoftReserves = {},
        HardReserves = {}, -- The weakaura format (CSV) doesn't include hard-reserves
        MetaData = {
            source = Constants.SoftReserveSources.lootReserve,
            importedAt = GetServerTime(),
            importString = "",
        },
    });

    -- We don't care for the playerName key in our database
    for _, Entry in pairs(SoftReserveData) do
        DB:add("SoftRes.SoftReserves", Entry);
    end

    -- Materialize the data for ease of use
    self:materializeData();

    GL.Events:fire("GL.SOFTRES_IMPORTED");
end

--- Import a Gargul data string
---
---@param data string
---@return boolean
function SoftRes:importGargulData(data)
    local importString = data;
    local base64DecodeSucceeded;
    base64DecodeSucceeded, data = pcall(function () return GL.Base64.decode(data); end);

    -- Something went wrong while base64 decoding the payload
    if (not base64DecodeSucceeded) then
        local errorMessage = L.BASE64_DECODE_WARNING;
        GL.Interface:get("SoftRes.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    local LibDeflate = LibStub:GetLibrary("LibDeflate");
    local zlibDecodeSucceeded;
    zlibDecodeSucceeded, data = pcall(function () return LibDeflate:DecompressZlib(data); end);

    -- Something went wrong while zlib decoding the payload
    if (not zlibDecodeSucceeded) then
        local errorMessage = L.ZLIB_DECOMPRESS_WARNING;
        GL.Interface:get("SoftRes.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    -- Something went wrong while json decoding the payload
    local jsonDecodeSucceeded;
    jsonDecodeSucceeded, data = pcall(function () return GL.JSON:decode(data); end);
    if (not jsonDecodeSucceeded) then
        local errorMessage = L.JSON_DECODE_WARNING;
        GL.Interface:get("SoftRes.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    local function throwGenericInvalidDataError()
        local errorMessage = L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS;
        GL.Interface:get("SoftRes.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    -- Make sure all the required properties are available and of the correct type
    if (not data or type(data) ~= "table"
        or not data.softreserves or type(data.softreserves) ~= "table"
        or not GL:tableGet(data, "metadata.id", false)
    ) then
        return throwGenericInvalidDataError();
    end

    -- Store softres meta data (id, url etc)
    local createdAt = tonumber(data.metadata.createdAt) or 0;
    local updatedAt = tonumber(data.metadata.updatedAt) or 0;
    local discordUrl = tostring(data.metadata.discordUrl) or "";
    local hidden = GL:toboolean(data.metadata.hidden or false);
    local id = tostring(data.metadata.id) or "";
    local raidStartsAt = data.metadata.raidStartsAt or 0;

    DB.SoftRes.MetaData = {
        createdAt = createdAt,
        discordUrl = discordUrl,
        hidden = hidden,
        id = id,
        importedAt = GetServerTime(),
        importString = importString,
        raidStartsAt = raidStartsAt,
        updatedAt = updatedAt,
        url = "https://softres.it/raid/" .. id,
    };

    local differentPlusOnes = false;
    local PlusOnes = {};
    local SoftReserveEntries = {};
    for _, Entry in pairs(data.softreserves) do
        local Items = Entry.items or false;
        local name = Entry.name or false;
        local class = Entry.class or false;
        local note = Entry.note or "";
        local plusOnes = tonumber(Entry.plusOnes) or 0;

        -- WoW itself uses Death Knight, so let's rewrite for compatibility
        if (string.lower(class) == "deathknight") then
            class = "death knight";
        end

        -- Someone provided an invalid class...
        if (not Constants.Classes[class]) then
            class = "priest";
        end

        -- Make sure we have a name, class and some items
        if (not GL:inTable({Items, name, class}, false)
            and type(Items) == "table"
        ) then
            local hasItems = false;

            -- Tamper protection, plusOnes can't be lower than zero
            if (not GL:higherThanZero(plusOnes)) then
                plusOnes = 0;
            end

            local PlayerEntry = {
                class = class,
                name = name,
                note = note,
                plusOnes = plusOnes,
                Items = {},
            };

            for _, Item in pairs(Items) do
                local itemID = tonumber(Item.id) or 0;

                if (GL:higherThanZero(itemID)) then
                    hasItems = true;

                    tinsert(PlayerEntry.Items, itemID);
                end
            end

            local currentPlusOneValue = GL.PlusOnes:getPlusOnes(name);

            -- We don't simply overwrite the PlusOnes if plusone data is already present
            -- If the player doesn't have any plusones yet then we set it to whatever is provided by softres
            if (GL:higherThanZero(currentPlusOneValue)
                and currentPlusOneValue ~= plusOnes
            ) then
                differentPlusOnes = true;
            else
                GL.PlusOnes:setPlusOnes(name, plusOnes);
            end

            PlusOnes[name] = plusOnes;

            if (hasItems) then
                tinsert(SoftReserveEntries, PlayerEntry);
            end
        end
    end

    DB.SoftRes.SoftReserves = SoftReserveEntries;

    local HardReserveEntries = {};
    for _, Entry in pairs(data.hardreserves) do
        local HardReserveEntry = {
            id = tonumber(Entry.id) or 0,
            ["for"] = tostring(Entry["for"]) or "",
            note = tostring(Entry.note) or "",
        };

        if (GL:higherThanZero(HardReserveEntry.id)) then
            tinsert(HardReserveEntries, HardReserveEntry);
        end
    end

    DB.SoftRes.HardReserves = HardReserveEntries;

    -- At this point in Era we don't really know anyone's plus one because SoftRes doesn't support realm tags (yet)
    if (differentPlusOnes) then
        -- Show a confirmation dialog before overwriting the plusOnes
        GL.Interface.Dialogs.PopupDialog:open{
            question = L.SOFTRES_IMPORT_NEW_PLUSONES,
            OnYes = function ()
                GL.PlusOnes:clearPlusOnes();
                GL.PlusOnes:setPlusOnes(PlusOnes);
                GL.Interface.SoftRes.Overview:close();
                self:draw();
            end,
        };
    end

    GL.Interface.SoftRes.Importer:close();

    return true;
end

--- Import a Weakaura data string (legacy)
---
---@param data string
---@param reportStatus boolean
---@return boolean
function SoftRes:importCSVData(data, reportStatus)
    if (reportStatus) then
        GL:warning(L.SOFTRES_IMPORT_USE_GARGUL);
    end

    local PlusOnes = {};
    local Columns = {};
    local differentPlusOnes = false;
    local first = true;
    local SoftReserveData = {};
    for line in data:gmatch("[^\n]+") do
        local Segments = GL:explode(line, ",");

        if (first) then
            Columns = GL:tableFlip(Segments);
            first = false;
        else -- The first line includes the heading, we don't need that
            local itemID = tonumber(Segments[Columns.ItemId]);
            local playerName = tostring(Segments[Columns.Name]);
            local class = tostring(Segments[Columns.Class]);
            local note = tostring(Segments[Columns.Note]);
            local plusOnes = tonumber(Segments[Columns.Plus]);

            if (GL:higherThanZero(itemID)
                and not GL:empty(playerName)
            ) then
                -- WoW itself uses Death Knight, so let's rewrite for compatibility
                if (string.lower(class) == "deathknight") then
                    class = "death knight";
                end

                playerName = string.lower(playerName);

                if (not SoftReserveData[playerName]) then
                    SoftReserveData[playerName] = {
                        Items = {},
                        name = playerName,
                        class = class,
                        note = note,
                        plusOnes = plusOnes,
                    };
                end

                local currentPlusOneValue = GL.PlusOnes:getPlusOnes(playerName);

                -- We don't simply overwrite the PlusOnes if plusone data is already present
                -- If the player doesn't have any plusones yet then we set it to whatever is provided by softres
                if (GL:higherThanZero(currentPlusOneValue)
                    and currentPlusOneValue ~= plusOnes
                ) then
                    differentPlusOnes = true;
                else
                    GL.PlusOnes:setPlusOnes(playerName, plusOnes);
                end

                PlusOnes[playerName] = plusOnes;

                tinsert(SoftReserveData[playerName].Items, itemID);
            end
        end
    end

    -- The user attempted to import invalid data
    if (GL:empty(SoftReserveData)) then
        GL.Interface:get("SoftRes.Importer", "Label.StatusMessage"):SetText(L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS);

        return false;
    end

    DB:set("SoftRes", {
        SoftReserves = {},
        HardReserves = {}, -- The weakaura format (CSV) doesn't include hard-reserves
        MetaData = {
            source = Constants.SoftReserveSources.weakaura,
            importedAt = GetServerTime(),
            importString = data,
        },
    });

    -- We don't care for the playerName key in our database
    for _, Entry in pairs(SoftReserveData) do
        DB:add("SoftRes.SoftReserves", Entry);
    end

    if (differentPlusOnes) then
        -- Show a confirmation dialog before overwriting the plusOnes
        GL.Interface.Dialogs.PopupDialog:open{
            question = L.SOFTRES_IMPORT_NEW_PLUSONES,
            OnYes = function ()
                GL.PlusOnes:clearPlusOnes();
                GL.PlusOnes:setPlusOnes(PlusOnes);
                GL.Interface.SoftRes.Overview:close();
                self:draw();
            end,
        };
    end

    return not GL:empty(DB.SoftRes.SoftReserves);
end

--- Attempt to fix players misspelling their character name on softres
---
---@return table
function SoftRes:fixPlayerNames()
    -- Get the names of everyone in our group and lowercase them
    local GroupMemberNames = {};
    for _, playerName in pairs(GL.User:groupMemberNames()) do
        tinsert(GroupMemberNames, string.lower(playerName));
    end

    local GroupMembersThatReserved = {};
    local PlayersNotInGroup = {};

    -- Check all reservations and split them in players that are in our group, and players (+class) that aren't
    for _, Reservation in pairs(DB.SoftRes.SoftReserves or {}) do
        -- This player is actually in our group
        if (GL:inTable(GroupMemberNames, Reservation.name)) then
            tinsert(GroupMembersThatReserved, Reservation.name);

        -- We don't know this player, potentially mistyped name
        else
            PlayersNotInGroup[Reservation.name] = string.lower(Reservation.class);
        end
    end

    -- Check who's in our group and didn't reserve yet
    local PlayersWhoDidntReserve = {};
    for _, playerName in pairs(GroupMemberNames) do
        if (not GL:inTable(GroupMembersThatReserved, playerName)) then
            tinsert(PlayersWhoDidntReserve, playerName);
        end
    end

    -- Everyone reserved, great, let's move on
    if (GL:empty(PlayersWhoDidntReserve)) then
        return {};
    end

    -- Try to find matching names for players who didn't soft-reserve, which means they likely made a typo
    local NameDictionary = {};
    for _, playerWhoDidntReserve in pairs(PlayersWhoDidntReserve) do
        local playerClass = GL.Player:classByName(playerWhoDidntReserve);
        local mostSimilarName = false;
        local lastDistance = 99;

        for playerNotInGroup, class in pairs(PlayersNotInGroup) do
            local distance = GL:levenshtein(playerWhoDidntReserve, playerNotInGroup);
            local maximumDistance = 4;

            -- If the class of the player doesn't match with the class of the soft-reserve
            -- then we drastically lower the maximum distance. If both name and class are wrong, a match is unlikely!
            if (playerClass ~= class) then
                maximumDistance = 2;
            end

            if (distance <= maximumDistance
                and distance < lastDistance
            ) then
                mostSimilarName = playerNotInGroup;
            end
        end

        if (mostSimilarName) then
            NameDictionary[mostSimilarName] = playerWhoDidntReserve;
        end
    end

    -- Nothing to rewire!
    if (GL:empty(NameDictionary)) then
        return {};
    end

    -- Rewire reservations e.g. match names
    local RewiredNames = {};
    for _, Reservation in pairs(DB.SoftRes.SoftReserves or {}) do
        if (NameDictionary[Reservation.name]) then
            RewiredNames[Reservation.name] = NameDictionary[Reservation.name];
            Reservation.name = NameDictionary[Reservation.name];
        end
    end

    return RewiredNames;
end

--- Broadcast our soft reserves table to the raid or group
---
---@return boolean
function SoftRes:broadcast()
    if (self.broadcastInProgress) then
        GL:error(L.BROADCAST_IN_PROGRESS_ERROR);
        return false;
    end

    if (not self:userIsAllowedToBroadcast()) then
        GL:warning(L.LM_OR_ASSIST_REQUIRED);
        return false;
    end

    -- Check if there's anything to share
    if (not self:available()
        or GL:empty(DB:get("SoftRes.MetaData.importString"))
    ) then
        GL:warning(L.BROADCAST_NO_DATA);
        return false;
    end

    self.broadcastInProgress = true;

    GL.CommMessage.new{
        action = CommActions.broadcastSoftRes,
        content = DB:get("SoftRes.MetaData.importString"),
        channel = "GROUP",
    }:send();

    GL.Ace:ScheduleTimer(function ()
        GL:success(L.BROADCAST_FINISHED);
        self.broadcastInProgress = false;
    end, 10);

    return true;
end

--- Process an incoming soft reserve broadcast
---
---@param CommMessage CommMessage
function SoftRes:receiveSoftRes(CommMessage)
    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.isSelf) then
        GL:debug("Sync:receiveSoftRes received by self, skip");
        return true;
    end

    local importString = CommMessage.content;
    if (not GL:empty(importString)) then
        GL:warning((L.SOFTRES_PROCESS_INCOMING):format(CommMessage.Sender.name));
        return self:import(importString);
    end

    GL:warning((L.SOFTRES_BROADCAST_PROCESS_FAILED):format(CommMessage.Sender.name));
    return false;
end

--- Attempt to post the softres.it link in either party or raid chat
---
---@return boolean
function SoftRes:postLink()
    local softResLink = DB:get("SoftRes.MetaData.url", false);

    if (not softResLink) then
        GL:warning(L.SOFTRES_NO_URL_AVAILABLE);
        return false;
    end

    -- Post the link in the chat for all group members to see
    GL:sendChatMessage(
        softResLink,
        "GROUP"
    );

    return true;
end

--- Return the names of all players that didn't soft-reserve yet
---
---@return table
function SoftRes:playersWithoutSoftReserves()
    local PlayerNames = {};

    -- Materialized data is available, use it!
    if (not GL:empty(self.MaterializedData.DetailsByPlayerName)) then
        for _, playerName in pairs(GL.User:groupMemberNames()) do
            if (not self.MaterializedData.DetailsByPlayerName[string.lower(playerName)]) then
                tinsert(PlayerNames, GL:capitalize(playerName));
            end
        end

        return PlayerNames;
    end

    -- No materialized data yet, use the raw softres data instead
    local GroupMemberReserved = {};
    for _, playerName in pairs(GL.User:groupMemberNames()) do
        GroupMemberReserved[string.lower(playerName)] = false;
    end

    for _, Reservation in pairs(DB.SoftRes.SoftReserves or {}) do
        GroupMemberReserved[string.lower(Reservation.name)] = true;
    end

    for name, reserved in pairs(GroupMemberReserved) do
        if (not reserved) then
            tinsert(PlayerNames, name);
        end
    end

    return PlayerNames;
end

--- Attempt to post the names of the players who didn't soft-reserve anything
---
---@return boolean
function SoftRes:postMissingSoftReserves()
    if (not self:available()) then
        GL:warning(L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS);
        return false;
    end

    local PlayerNames = self:playersWithoutSoftReserves();

    if (#PlayerNames < 1) then
        GL:success(L.SOFTRES_EVERYONE_RESERVED);
        return true;
    end

    -- Post the link in the chat for all group members to see
    GL:sendChatMessage(
        (L.CHAT.SOFTRES_MISSING_RESERVES):format(table.concat(PlayerNames, " ")),
        "GROUP"
    );

    return true;
end

--- Check whether the current user is allowed to broadcast SoftRes data
---
---@return boolean
function SoftRes:userIsAllowedToBroadcast()
    return not GL.User.isInGroup or (GL.User.isMasterLooter or GL.User.hasAssist);
end
