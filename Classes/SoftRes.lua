---@type GL
local _, GL = ...;

---@class SoftRes
GL.SoftRes = {
    _initialized = false,
    maxNumberOfSoftReservedItems = 6,
    broadcastInProgress = false,
    requestingData = false,

    MaterializedData = {
        ClassByPlayerName = {},
        DetailsByPlayerName = {},
        HardReserveDetailsById = {},
        PlayerNamesByItemId = {},
        ReservedItemIds = {},
        SoftReservedItemIds = {},
    },
};

local DB = GL.DB; ---@type DB
local Constants = GL.Data.Constants; ---@type Data
local CommActions = Constants.Comm.Actions;
local Settings = GL.Settings; ---@type Settings
local SoftRes = GL.SoftRes; ---@type SoftRes
local GameTooltip = GameTooltip; ---@type GameTooltip

--- @return boolean
function SoftRes:_init()
    GL:debug("SoftRes:_init");

    if (self._initialized) then
        return false;
    end

    -- Remove old SoftRes data if it's more than 10h old
    if (self:available()
        and DB:get("SoftRes.MetaData.importedAt") < GetServerTime() - 36000
    ) then
        self:clear();
    end

    -- Bind the appendSoftReserveInfoToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendSoftReserveInfoToTooltip(tooltip);
    end);

    GL.Events:register("SoftResUserJoinedGroupListener", "GL.USER_JOINED_GROUP", function () self:requestData(); end);

    self:materializeData();

    self._initialized = true;
    return true;
end

--- Check whether there are soft-reserves available
---
---@return boolean
function SoftRes:available()
    GL:debug("SoftRes:available");

    return GL:higherThanZero(DB:get("SoftRes.MetaData.importedAt", 0));
end

--- Request SoftRes data from the person in charge (ML or Leader)
---
---@return void
function SoftRes:requestData()
    GL:debug("SoftRes:requestData");

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
        CommActions.requestSoftResData,
        {
            currentSoftResID = GL.DB:get('SoftRes.MetaData.id'),
            softResDataUpdatedAt = GL.DB:get('SoftRes.MetaData.updatedAt'),
        },
        "WHISPER",
        playerToRequestFrom
    ):send();

    self.requestingData = false;
end

--- Reply to a player's SoftRes data request
---
---@param CommMessage CommMessage
---@return void
function SoftRes:replyToDataRequest(CommMessage)
    GL:debug("SoftRes:replyToDataRequest");

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

    local playerName = CommMessage.Sender.name;
    local playerSoftResID = CommMessage.content.currentSoftResID or '';
    local playerSoftResUpdatedAt = tonumber(CommMessage.content.softResDataUpdatedAt) or 0;

    -- Your data is newer that mine, leave me alone!
    if (not GL:empty(playerSoftResID)
        and playerSoftResUpdatedAt > 0
        and playerSoftResID == GL.DB:get('SoftRes.MetaData.id', '')
        and playerSoftResUpdatedAt > GL.DB:get('SoftRes.MetaData.updatedAt', 0)
    ) then
        ---@todo enable the return when softres.it fully supports the updatedAt timestamp
        --return;
    end

    -- Looks like you need my data, here it is!
    GL.CommMessage.new(
        CommActions.broadcastSoftRes,
        DB:get("SoftRes.MetaData.importString"),
        "WHISPER",
        playerName
    ):send();
end

--- Materialize the SoftRes data to make it more accessible during runtime
---
---@return void
function SoftRes:materializeData()
    GL:debug("SoftRes:materializeData");

    local ReservedItemIds = {}; -- All reserved item ids (both soft- and hard)
    local SoftReservedItemIds = {}; -- Soft-reserved item ids
    local DetailsByPlayerName = {}; -- Item ids per player name
    local PlayerNamesByItemId = {}; -- Player names per reserved item id
    local HardReserveDetailsById = {}; -- Hard reserve details per item id

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

            for _, itemId in pairs(SoftResEntry.Items or {}) do
                if (GL:higherThanZero(itemId)) then
                    -- This seems very counterintuitive, but using numeric keys
                    -- in a lua tables has some insanely annoying drawbacks
                    local idString = tostring(itemId);

                    if (not PlayerNamesByItemId[idString]) then
                        PlayerNamesByItemId[idString] = {};
                    end

                    -- It's now possible to reserve the same item multiple times so we no longer
                    -- check whether the given playername is unique!
                    tinsert(PlayerNamesByItemId[idString], name);

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
            HardReserveDetailsById[tostring(id)] = {
                id = id,
                reservedFor = reservedFor,
                note = note,
            };
        end
    end

    local reservedItemIdsIndex = 1;
    for idString in pairs(PlayerNamesByItemId) do
        SoftReservedItemIds[idString] = true;
        ReservedItemIds[idString] = reservedItemIdsIndex;

        reservedItemIdsIndex = reservedItemIdsIndex + 1;
    end

    for idString in pairs(HardReserveDetailsById) do
        if (not ReservedItemIds[idString]) then
            ReservedItemIds[idString] = reservedItemIdsIndex;
            reservedItemIdsIndex = reservedItemIdsIndex + 1;
        end
    end

    self.MaterializedData.DetailsByPlayerName = DetailsByPlayerName;
    self.MaterializedData.HardReserveDetailsById = HardReserveDetailsById;
    self.MaterializedData.PlayerNamesByItemId = PlayerNamesByItemId;
    self.MaterializedData.ReservedItemIds = GL:tableFlip(ReservedItemIds);
    self.MaterializedData.SoftReservedItemIds = SoftReservedItemIds;
end

--- Draw either the importer or overview
--- based on the current soft-reserve data
---
---@return void
function SoftRes:draw()
    GL:debug("SoftRes:draw");

    -- No data available, show importer
    if (not self:available()) then
        GL.Interface.SoftRes.Importer:draw();
        return;
    end

    -- Show the soft-reserve overview after all items are loaded
    -- This is to ensure that all item data is available before we draw the UI
    GL:onItemLoadDo(
        self.MaterializedData.ReservedItemIds or {},
        function () GL.Interface.SoftRes.Overview:draw(); end
    );
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
---@param itemId number|string
---@param inRaidOnly boolean
---@return boolean
function SoftRes:idIsReserved(itemId, inRaidOnly)
    local idString = tostring(itemId);

    if (type(inRaidOnly) ~= "boolean") then
        inRaidOnly = Settings:get("SoftRes.hideInfoOfPeopleNotInGroup");
    end

    -- The item is hard-reserved
    if (self:idIsHardReserved(idString)) then
        return true;
    end

    -- The item is not reserved at all
    if (not GL:inTable(self.MaterializedData.ReservedItemIds, idString)) then
        return false;
    end

    -- The item is reserved and the user doesn't care about whether the people reserving it
    if (not inRaidOnly) then
        return true;
    end

    -- Check whether any of the people reserving this item are actually in the raid
    local GroupMemberNames = GL.User:groupMemberNames();

    for _, playerName in pairs(GroupMemberNames) do
        if (GL:inTable(self.MaterializedData.PlayerNamesByItemId[idString], playerName)) then
            return true;
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
    return self:idIsReserved(GL:getItemIdFromLink(itemLink), inRaidOnly);
end

--- Check whether a given item id is hard-reserved
---
---@param itemId number|string
---@return boolean
function SoftRes:idIsHardReserved(itemId)
    local idString = tostring(itemId);

    return self.MaterializedData.HardReserveDetailsById[idString] ~= nil;
end

--- Check whether a given itemlink is hard-reserved
---
---@param itemLink string
---@return boolean
function SoftRes:linkIsHardReserved(itemLink)
    return self:idIsHardReserved(GL:getItemIdFromLink(itemLink));
end

--- Clear all SoftRes data
---
---@return void
function SoftRes:clear()
    DB.SoftRes = {};
    self.MaterializedData = {
        ClassByPlayerName = {},
        DetailsByPlayerName = {},
        HardReserveDetailsById = {},
        PlayerNamesByItemId = {},
        ReservedItemIds = {},
        SoftReservedItemIds = {},
    };

    GL.Interface.SoftRes.Overview:close();
end

--- Check whether the given player reserved the given item id
---
---@param itemId number|string
---@param playerName string
---@return boolean
function SoftRes:itemIdIsReservedByPlayer(itemId, playerName)
    GL:debug("SoftRes:itemIdIsReservedByPlayer");

    local SoftResData = self.MaterializedData.PlayerNamesByItemId or {};

    return GL:inTable(
        SoftResData[tostring(itemId)] or {},
        string.lower(GL:stripRealm(playerName))
    );
end

--- Fetch an item's reservations based on its ID
---
---@param itemId number|string
---@param inRaidOnly boolean
---@return table
function SoftRes:byItemId(itemId, inRaidOnly)
    GL:debug("SoftRes:byItemId");

    -- An invalid item id was provided
    itemId = tonumber(itemId);
    if (not GL:higherThanZero(itemId)) then
        return {};
    end

    if (type(inRaidOnly) ~= "boolean") then
        inRaidOnly = Settings:get("SoftRes.hideInfoOfPeopleNotInGroup");
    end

    -- The item linked to this id can have multiple IDs (head of Onyxia for example)
    local AllLinkedItemIds = GL:getLinkedItemsForId(itemId);

    local GroupMemberNames = {};
    if (inRaidOnly) then
        GroupMemberNames = GL.User:groupMemberNames();
    end

    local ActiveReservations = {};
    for _, id in pairs(AllLinkedItemIds) do
        local idString = tostring(id);

        -- If inRaidOnly is true we need to make sure we only return details of people who are actually in the raid
        for _, playerName in pairs(GL:tableGet(self.MaterializedData.PlayerNamesByItemId or {}, idString, {})) do
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
---@return table
function SoftRes:byItemLink(itemLink, inRaidOnly)
    GL:debug("SoftRes:byItemLink");

    return self:byItemId(GL:getItemIdFromLink(itemLink), inRaidOnly);
end

--- Append the soft reserves as defined in DB.SoftRes to an item's tooltip
---
---@param Tooltip GameTooltip
---@return boolean
function SoftRes:appendSoftReserveInfoToTooltip(Tooltip)
    GL:debug("SoftRes:appendSoftReserveInfoToTooltip");

    -- The player doesn't want to see softres details on tooltips
    if (not Settings:get("SoftRes.enableTooltips")) then
        return true;
    end

    -- No tooltip was provided
    if (not Tooltip) then
        GL:debug("No tooltip found in SoftRes:appendSoftReserveInfoToTooltip");
        return false;
    end

    -- If we're not in a group andd we don't want to see
    -- out-of-raid data there's no point in showing soft-reserves
    if (not GL.User.isInGroup
        and Settings:get("SoftRes.hideInfoOfPeopleNotInGroup")
    ) then
        return true;
    end

    local itemName, itemLink = Tooltip:GetItem();

    -- We couldn't find an itemName or link (this can actually happen!)
    if (not itemName or not itemLink) then
        GL:debug("No item found in SoftRes:appendSoftReserveInfoToTooltip");
        return false;
    end

    -- Check if the item is hard-reserved
    if (self:linkIsHardReserved(itemLink)) then
        Tooltip:AddLine(string.format("|cFFcc2743%s|r", "\nThis item is hard-reserved!"));

        return true;
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
        return true;
    end

    -- This is necessary so we can sort the table based on number of reserves per item
    local ActiveReservations = {};
    for playerName, reservations in pairs(ReservationsByPlayerName) do
        tinsert(ActiveReservations, {
            player = playerName,
            reservations = reservations,
        })
    end
    ReservationsByPlayerName = {}; -- We no longer need this table, clean it up!

    -- Sort the reservations based on whoever reserved it more often (highest to lowest)
    table.sort(ActiveReservations, function (a, b)
        return a.reservations > b.reservations;
    end);

    -- Add the header
    Tooltip:AddLine(string.format("\n|cFFEFB8CD%s|r", "Reserved by"));

    -- Add the reservation details to ActiveReservations (add 2x / 3x etc when same item was reserved multiple times)
    for _, Entry in pairs(ActiveReservations) do
        local class = self:getPlayerClass(Entry.player);
        local entryString = Entry.player;

        -- User reserved the same item multiple times
        if (Entry.reservations > 1) then
            entryString = string.format("%s (%sx)", Entry.player, Entry.reservations);
        end

        -- Add the actual soft reserves to the tooltip
        Tooltip:AddLine(string.format(
            "|cFF%s    %s|r",
            GL:classHexColor(class),
            GL:capitalize(entryString)
        ));
    end

    return true;
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
        itemID = GL:getItemIdFromLink(idOrLink);
    end

    return GL:tableGet(self.MaterializedData.DetailsByPlayerName, string.format(
        "%s.Items.%s",
        string.lower(playerName),
        itemID
    ), 0);
end

--- Try to import the data provided in the import window
---
---@param data string
---@return boolean
function SoftRes:import(data, openOverview)
    GL:debug("SoftRes:import");

    local success = false;

    -- Make sure all the required properties are available and of the correct type
    if (GL:empty(data)) then
        GL.Interface:getItem("SoftRes.Importer", "Label.StatusMessage"):SetText("Invalid soft-reserve data provided");
        return false;
    end

    -- A CSV string was provided, import it
    if (GL:strContains(data, ",")) then
        success = self:importCSVData(data);
    else
        -- Assume Gargul data was provided
        success = self:importGargulData(data);
    end

    if (success) then
        GL:success("Import of SoftRes data successful");
        GL.Events:fire("GL.SOFTRES_IMPORTED");

        self:materializeData();
        GL.Interface.SoftRes.Importer:close();

        if (openOverview) then
            self:draw();

            -- Automatically broadcast this data if it's not marked as "hidden" and the user has the required permissions
            if (self:userIsAllowedToBroadcast()
                and not GL.DB:get('SoftRes.MetaData.hidden', true)) then
                self:broadcast();
            end
        end

        return true;
    end

    return false;
end

--- Import a Gargul data string
---
---@param data string
---@return boolean
function SoftRes:importGargulData(data)
    GL:debug("SoftRes:importGargulData");

    local importString = data;
    local base64DecodeSucceeded;
    base64DecodeSucceeded, data = pcall(function () return GL.Base64.decode(data); end);

    -- Something went wrong while base64 decoding the payload
    if (not base64DecodeSucceeded) then
        local errorMessage = "Unable to base64 decode the data. Make sure you copy/paste it as-is from softres.it without adding any additional characters or whitespaces!";
        GL.Interface:getItem("SoftRes.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    local LibDeflate = LibStub:GetLibrary("LibDeflate");
    local zlibDecodeSucceeded;
    zlibDecodeSucceeded, data = pcall(function () return LibDeflate:DecompressZlib(data); end);

    -- Something went wrong while zlib decoding the payload
    if (not zlibDecodeSucceeded) then
        local errorMessage = "Unable to zlib decode the data. Make sure you copy/paste it as-is from softres.it without adding any additional characters or whitespaces!";
        GL.Interface:getItem("SoftRes.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    -- Something went wrong while json decoding the payload
    local jsonDecodeSucceeded;
    jsonDecodeSucceeded, data = pcall(function () return GL.JSON:decode(data); end);
    if (not jsonDecodeSucceeded) then
        local errorMessage = "Unable to json decode the data. Make sure you paste the SoftRes data as-is in the box up top without adding/removing anything! If the issue persists then hop in our Discord for support!";
        GL.Interface:getItem("SoftRes.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    local function throwGenericInvalidDataError()
        local errorMessage = "Invalid data provided. Make sure to click the 'Gargul Data Export' button on softres.it and paste the full contents here";
        GL.Interface:getItem("SoftRes.Importer", "Label.StatusMessage"):SetText(errorMessage);

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
    local createdAt = data.metadata.createdAt or 0;
    local updatedAt = data.metadata.updatedAt or 0;
    local discordUrl = data.metadata.discordUrl or "";
    local hidden = toboolean(data.metadata.hidden or false);
    local id = tostring(data.metadata.id) or "";
    local instance = data.metadata.instance or "";
    local raidNote = data.metadata.note or "";
    local raidStartsAt = data.metadata.raidStartsAt or 0;

    -- Check the provided meta data to prevent any weird tampering
    if (GL:empty(id)
        or GL:empty(instance)
        or type(createdAt) ~= "number"
        or type(discordUrl) ~= "string"
        or type(raidNote) ~= "string"
        or type(raidStartsAt) ~= "number"
    ) then
        return throwGenericInvalidDataError();
    end

    DB.SoftRes.MetaData = {
        createdAt = createdAt,
        discordUrl = discordUrl,
        hidden = hidden,
        id = id,
        importedAt = GetServerTime(),
        importString = importString,
        instance = instance,
        note = raidNote,
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

        -- Someone provided an invalid class... tamper alert!
        if (not Constants.Classes[class]) then
            class = false;
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
                local itemId = tonumber(Item.id) or 0;

                if (GL:higherThanZero(itemId)) then
                    hasItems = true;

                    tinsert(PlayerEntry.Items, itemId);
                end
            end

            local currentPlusOneValue = GL.PlusOnes:get(name);

            -- We don't simply overwrite the PlusOnes if plusone data is already present
            -- If the player doesn't have any plusones yet then we set it to whatever is provided by softres
            if (GL.isEra
                or (GL:higherThanZero(currentPlusOneValue)
                and currentPlusOneValue ~= plusOnes
            )
            ) then
                differentPlusOnes = true;
            else
                GL.PlusOnes:set(name, plusOnes);
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
    if (GL.isEra) then
        if (not GL:empty(DB.PlusOnes)) then
            GL.Interface.Dialogs.PopupDialog:open({
                question = "Do you want to clear all previous PlusOne values?",
                OnYes = function ()
                    GL.PlusOnes:clear();
                end,
            });
        end
    elseif (differentPlusOnes) then
        -- Show a confirmation dialog before overwriting the plusOnes
        GL.Interface.Dialogs.PopupDialog:open({
            question = "The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?",
            OnYes = function ()
                GL.PlusOnes:clear();
                GL.PlusOnes:set(PlusOnes);
                GL.Interface.SoftRes.Overview:close();
                self:draw();
            end,
        });
    end

    GL.Interface.SoftRes.Importer:close();

    return true;
end

--- Import a Weakaura data string (legacy)
---
---@param data string
---@return boolean
function SoftRes:importCSVData(data)
    GL:debug("SoftRes:import");

    GL:warning("The Weakaura data and CSV exports are still supported but are deprecated, try using the Gargul export instead!");

    local PlusOnes = {};
    local Columns = {};
    local differentPlusOnes = false;
    local first = true;
    local SoftReserveData = {};
    for line in data:gmatch("[^\n]+") do
        local Segments = GL:strSplit(line, ",");

        if (first) then
            Columns = GL:tableFlip(Segments);
            first = false;
        else -- The first line includes the heading, we don't need that
            local itemId = tonumber(Segments[Columns.ItemId]);
            local playerName = tostring(Segments[Columns.Name]);
            local class = tostring(Segments[Columns.Class]);
            local note = tostring(Segments[Columns.Note]);
            local plusOnes = tonumber(Segments[Columns.Plus]);

            if (GL:higherThanZero(itemId)
                and not GL:empty(playerName)
            ) then
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

                local currentPlusOneValue = GL.PlusOnes:get(playerName);

                -- We don't simply overwrite the PlusOnes if plusone data is already present
                -- If the player doesn't have any plusones yet then we set it to whatever is provided by softres
                if (GL.isEra
                    or (GL:higherThanZero(currentPlusOneValue)
                        and currentPlusOneValue ~= plusOnes
                    )
                ) then
                    differentPlusOnes = true;
                else
                    GL.PlusOnes:set(playerName, plusOnes);
                end

                PlusOnes[playerName] = plusOnes;

                tinsert(SoftReserveData[playerName].Items, itemId);
            end
        end
    end

    DB.SoftRes = {
        SoftReserves = {},
        HardReserves = {}, -- The weakaura format (CSV) doesn't include hard-reserves
        MetaData = {
            source = Constants.SoftReserveSources.weakaura,
            importedAt = GetServerTime(),
            importString = data,
        },
    };

    -- We don't care for the playerName key in our database
    for _, Entry in pairs(SoftReserveData) do
        tinsert(DB.SoftRes.SoftReserves, Entry);
    end

    -- At this point we don't really know anyone's plus one because SoftRes doesn't support realm tags (yet)
    if (GL.isEra) then
        if (not GL:empty(DB.PlusOnes)) then
            GL.Interface.Dialogs.PopupDialog:open({
                question = "Do you want to clear all previous PlusOne values?",
                OnYes = function ()
                    GL.PlusOnes:clear();
                end,
            });
        end
    elseif (differentPlusOnes) then
        -- Show a confirmation dialog before overwriting the plusOnes
        GL.Interface.Dialogs.PopupDialog:open({
            question = "The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?",
            OnYes = function ()
                GL.PlusOnes:clear();
                GL.PlusOnes:set(PlusOnes);
                GL.Interface.SoftRes.Overview:close();
                self:draw();
            end,
        });
    end

    return not GL:empty(DB.SoftRes.SoftReserves);
end

--- Broadcast our soft reserves table to the raid or group
---
---@return boolean
function SoftRes:broadcast()
    GL:debug("SoftRes:broadcast");

    if (self.broadcastInProgress) then
        GL:error("Broadcast still in progress");
        return false;
    end

    if (not GL.User.isInGroup) then
        GL:warning("No one to broadcast to, you're not in a group!");
        return false;
    end

    -- Check if there's anything to share
    if (not self:available()
        or GL:empty(DB:get("SoftRes.MetaData.importString"))
    ) then
        GL:warning("Nothing to broadcast, import SoftRes data first!");
        return false;
    end

    self.broadcastInProgress = true;

    GL.CommMessage.new(
        CommActions.broadcastSoftRes,
        DB:get("SoftRes.MetaData.importString"),
        "GROUP"
    ):send();

    GL.Ace:ScheduleTimer(function ()
        GL:success("Broadcast finished");
        self.broadcastInProgress = false;
    end, 10);

    return true;
end

--- Process an incoming soft reserve broadcast
---
---@param CommMessage CommMessage
function SoftRes:receiveSoftRes(CommMessage)
    GL:debug("SoftRes:receiveSoftRes");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == GL.User.name) then
        GL:debug("Sync:receiveSoftRes received by self, skip");
        return true;
    end

    local importString = CommMessage.content;
    if (not GL:empty(importString)) then
        GL:warning("Attempting to process incoming SoftRes data from " .. CommMessage.Sender.name);
        return self:import(importString);
    end

    GL:warning("Couldn't process SoftRes data received from " .. CommMessage.Sender.name);
    return false;
end

--- Attempt to post the softres.it link in either party or raid chat
---
---@return boolean
function SoftRes:postLink()
    GL:debug("SoftRes:postLink");

    local softResLink = DB:get("SoftRes.MetaData.url", false);

    if (not softResLink) then
        GL:warning("No softres.it URL available, make sure you exported using the 'Export Gargul Data' button on softres.it!");
        return false;
    end

    if (not GL.User.isInGroup) then
        GL:warning("You need to be in a group in order to post the link!");
        return false;
    end

    local chatChannel = "PARTY";
    if (GL.User.isInRaid) then
        chatChannel = "RAID";
    end

    -- Post the link in the chat for all group members to see
    GL:sendChatMessage(
        softResLink,
        chatChannel
    );

    return true;
end

--- Attempt to post the names of the players who didn't soft-reserve anything
---
---@return boolean
function SoftRes:postMissingSoftReserves()
    GL:debug("SoftRes:postMissingSoftReserves");

    if (not self:available()) then
        GL:warning("No softres.it data available. Import it in the import window (type /gl softreserves)");
        return false;
    end

    if (not GL.User.isInGroup) then
        GL:warning("You need to be in a group in order to post missing soft-reserves!");
        return false;
    end

    local PlayerNames = {};
    for _, playerName in pairs(GL.User:groupMemberNames()) do
        if (not self.MaterializedData.DetailsByPlayerName[playerName]) then
            tinsert(PlayerNames, GL:capitalize(playerName));
        end
    end

    if (#PlayerNames < 1) then
        GL:success("Everyone filled out their soft-reserves");
        return true;
    end

    local chatChannel = "PARTY";
    if (GL.User.isInRaid) then
        chatChannel = "RAID";
    end

    -- Post the link in the chat for all group members to see
    GL:sendChatMessage(
        "Missing soft-reserves from: " .. table.concat(PlayerNames, ", "),
        chatChannel
    );

    return true;
end

--- Attempt to post the softres.it link in either party or raid chat
---
---@return boolean
function SoftRes:postDiscordLink()
    GL:debug("SoftRes:postDiscordLink");

    local discordLink = DB:get("SoftRes.MetaData.discordUrl", false);

    if (not discordLink) then
        GL:warning("No discord URL available. Make sure you actually set one and that you exported using the Gargul export on softres.it!");
        return false;
    end

    if (not GL.User.isInGroup) then
        GL:warning("You need to be in a group in order to post the Discord link!");
        return false;
    end

    local chatChannel = "PARTY";
    if (GL.User.isInRaid) then
        chatChannel = "RAID";
    end

    -- Post the link in the chat for all group members to see
    GL:sendChatMessage(
        discordLink,
        chatChannel
    );

    return true;
end

--- Check whether the current user is allowed to broadcast SoftRes data
---
---@return boolean
function SoftRes:userIsAllowedToBroadcast()
    return GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist);
end

GL:debug("SoftRes.lua");