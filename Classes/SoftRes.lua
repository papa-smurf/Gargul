---@type GL
local _, GL = ...;

---@class SoftRes
GL.SoftRes = {
    _initialized = false,
    maxNumberOfSoftReservedItems = 6,
    broadcastInProgress = false,

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

    -- Bind the appendSoftReserveInfoToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendSoftReserveInfoToTooltip(tooltip);
    end);

    self:materializeData();

    self._initialized = true;
    return true;
end

--- Check whether there are soft-reserves available
---
---@return boolean
function SoftRes:available()
    return GL:higherThanZero(DB:get("SoftRes.MetaData.importedAt", 0));
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

                    -- Make sure we only store names once in the PlayerNamesByItemId array
                    if (not GL:inTable(PlayerNamesByItemId[idString], name)) then
                        tinsert(PlayerNamesByItemId[idString], name);
                    end

                    DetailsByPlayerName[name].Items[idString] = true;
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
        GL.Interface.SoftRes.Importer:draw()
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

    local ClassByPlayerName = self.MaterializedData.ClassByPlayerName or {};
    if (ClassByPlayerName[name]) then
        return ClassByPlayerName[name]
    end

    -- Classes don't change so there's nothing against
    -- storing player classes by name indefinitely for this session
    if (GL.User.isInGroup) then
        for _, Player in pairs(GL.User.groupMembers()) do
            local playerName = string.lower(Player.name);
            ClassByPlayerName[playerName] = Player.class;
        end
    end

    return ClassByPlayerName[name] or defaultClass;
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
        and not Settings:get("SoftRes.hideInfoOfPeopleNotInGroup")
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

    local ActiveReservations = {};
    local Reservations = self:byItemLink(itemLink);

    -- Make sure we only show reserves of people who are actually in the raid
    local itemHasActiveReservations = false;
    for _, playerName in pairs(Reservations) do
        local class = self:getPlayerClass(playerName);

        tinsert(ActiveReservations, string.format(
            "|cFF%s    %s|r",
            GL:classHexColor(class),
            GL:capitalize(playerName)
        ));

        itemHasActiveReservations = true;
    end

    -- No active reservations were found for this item
    if (not itemHasActiveReservations) then
        return true;
    end

    -- Add the header
    Tooltip:AddLine(string.format("\n|cFFEFB8CD%s|r", "Reserved by"));

    -- Add the actual soft reserves
    for _, line in pairs(ActiveReservations) do
        Tooltip:AddLine(line);
    end

    return true;
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

    -- A weakaura export string was provided, import it
    if (GL:strStartsWith(data, "ItemId,Name,Class,Note,Plus")
        or GL:strStartsWith(data, "Item,ItemId,From,Name,Class,Spec,Note,Plus,Date")
    ) then
        success = self:importWeakauraData(data);
    else
        -- Assume Gargul data was provided
        success = self:importGargulData(data);
    end

    if (success) then
        GL:success("Import of SoftRes data successful");

        self:materializeData();
        GL.Interface.SoftRes.Importer:close();

        if (openOverview) then
            self:draw();
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
    local discordUrl = data.metadata.discordUrl or "";
    local id = tostring(data.metadata.id) or "";
    local instance = data.metadata.instance or "";
    local note = data.metadata.note or "";
    local raidStartsAt = data.metadata.raidStartsAt or 0;

    -- Check the provided meta data to prevent any weird tampering
    if (GL:empty(id)
        or GL:empty(instance)
        or type(createdAt) ~= "number"
        or type(discordUrl) ~= "string"
        or type(note) ~= "string"
        or type(raidStartsAt) ~= "number"
    ) then
        return throwGenericInvalidDataError();
    end

    DB.SoftRes.MetaData = {
        createdAt = createdAt,
        discordUrl = discordUrl,
        id = id,
        importedAt = GetServerTime(),
        importString = importString,
        instance = instance,
        note = note,
        raidStartsAt = raidStartsAt,
        url = "https://softres.it/raid/" .. id,
    };

    local differentPlusOnes = false;
    local PlusOnes = {};
    local SoftReserveEntries = {};
    for _, Entry in pairs(data.softreserves) do
        local Items = Entry.items or false;
        local name = Entry.name or false;
        local class = Entry.class or false;
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
        GL.PlusOnes:clear();
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
function SoftRes:importWeakauraData(data)
    GL:debug("SoftRes:import");

    ---@todo make this active when the Gargul exporter is released on SoftRes.it
    -- GL:warning("The Weakaura data import is still usable but deprecated, try using the Gargul export instead!");

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
        GL.PlusOnes:clear();
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

    local channel = "PARTY";
    if (GL.User.isInRaid) then
        channel = "RAID";
    end

    GL.CommMessage.new(
        CommActions.broadcastSoftRes,
        DB:get("SoftRes.MetaData.importString"),
        channel
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
        ---@todo Replace when SoftRes.it is updated
        GL:warning("No discord URL available");
        --GL:warning("No discord URL available. Make sure you actually set one and that you exported using the 'Export Gargul Data' button on softres.it!");
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

GL:debug("SoftRes.lua");