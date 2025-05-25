---@type GL
local _, GL = ...;

local deformat = LibStub("LibDeformat-3.0");

---@type Settings
local Settings = GL.Settings;

---@type DB
local DB = GL.DB;

---@type User
local User = GL.User;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@type Events
local Events = GL.Events;

---@type Data
local Constants = GL.Data.Constants;
local Bosses = GL.Data.Bosses;
--local Instances = GL.Data.Instances;
--local ItemSources = GL.Data.ItemSources;
local CommActions = Constants.Comm.Actions;

---@class DroppedLootLedger
GL.DroppedLootLedger = {
    _initialized = false,
    tracking = false,
    minimumQuality = nil,
    trackItems = false,
    ProcessedNPCIDs = {},
    BroadcastedNPCIDs = {},
    KilledBosses = {},
    Dropped = {},
    Received = {},
};

---@type DroppedLootLedger
local DroppedLootLedger = GL.DroppedLootLedger;

--[[ CONSTANTS ]]
-- See Constants.DroppedLoot.WhenToLogLoot for details
local WHENGROUP = 1;
local WHENRAID = 2;
local WHENHASML = 3;
local WHENISML = 4;
local WHENRL = 5;

---@return void
function DroppedLootLedger:_init()
    if (self._initialized) then
        return;
    end

    self._initialized = true;
    self.minimumQuality = Settings:get("DroppedLoot.minimumQualityOfLoggedLoot", 4);

    Events:register({
            {"DroppedLootGroupRosterUpdateThrottled", "GL.GROUP_ROSTER_UPDATE_THROTTLED"},
            {"DroppedLootSettingChanged", "GL.SETTING_CHANGED"},
        },
        function ()
            self:startOrStopTracking();
        end
    );
end

--- Start or stop tracking loot based on group and add-on settings
---
---@return void
function DroppedLootLedger:startOrStopTracking()
    self.trackItems = self:_shouldTrackItems();
    if (not self.trackItems) then
        self:stopTracking();
    else
        self:startTracking();
    end
end

---@return boolean
function DroppedLootLedger:_shouldTrackItems()
    if (not User.isInRaid) then
        return false;
    end

    if (GL.Settings:get("AwardingLoot.awardOnReceive")) then
        return true;
    end

    if (GDKPSession:activeSessionID()
        and GL.Settings:get("GDKP.addDropsToQueue")
        and not GL.Settings:get("GDKP.disableQueues")
    ) then
        return true;
    end

    local whenToLog = GL.Settings:get("DroppedLoot.whenToLogLoot");

    if (whenToLog == WHENGROUP) then
        return true;
    end

    if (whenToLog == WHENRAID) then
        return User.isInRaid;
    end

    if (whenToLog == WHENHASML) then
        return GetLootMethod() == "master";
    end

    if (whenToLog == WHENISML) then
        return User.isMasterLooter;
    end

    if (whenToLog == WHENRL) then
        return User.isLead;
    end

    return false;
end

---@return void
function DroppedLootLedger:startTracking()
    if (self.tracking) then
        return;
    end

    self.tracking = true;

    -- Just in case the event listeners already exist we remove them
    Events:unregister{
        "DroppedLootLedgerChatMSGLootListener",
        "DroppedLootLedgerLootReadyListener",
        "DroppedLootLedgerCombatLogEventUnfilteredListener",
    };

    -- Item received message detected in chat
    Events:register("DroppedLootLedgerChatMSGLootListener", "CHAT_MSG_LOOT", function(_, message)
        self:processReceivedItem(message);
    end);

    -- Loot window opened
    --Events:register("DroppedLootLedgerLootReadyListener", "LOOT_OPENED", function()
    --    self:lootOpened();
    --end);

    -- Check if a unit was killed
    --Events:register("DroppedLootLedgerCombatLogEventUnfilteredListener", "COMBAT_LOG_EVENT_UNFILTERED", function()
    --    self:processCombatLog(CombatLogGetCurrentEventInfo());
    --end);
end

---@return void
function DroppedLootLedger:stopTracking()
    Events:unregister{
        "DroppedLootLedgerChatMSGLootListener",
        "DroppedLootLedgerLootReadyListener",
        "DroppedLootLedgerCombatLogEventUnfilteredListener",
    };

    self.tracking = false;
end

---@param quality number
---@return void
function DroppedLootLedger:setMinimumQuality(quality)
    self.minimumQuality = quality;
end

---@return void
function DroppedLootLedger:lootOpened()
    local unitName = UnitName("target");

    -- Get the total number of items that dropped
    local itemCount = GetNumLootItems();
    if (itemCount < 1) then
        return;
    end

    -- Loop through every item in the loot window
    local sourceGUID;
    local Drops = {};
    for lootIndex = 1, GetNumLootItems() do
        local result = (function()
            -- Make sure we don't override sourceGUID with false/nil if it was already set!
            sourceGUID = sourceGUID or GetLootSourceInfo(lootIndex);

            -- We've already fully processed this mop
            if (not sourceGUID or self.ProcessedNPCIDs[sourceGUID]) then
                return false;
            end

            local itemLink = GetLootSlotLink(lootIndex);
            if (not itemLink) then
                return;
            end

            local itemID = GL.GetItemInfoInstant(itemLink);
            if (not itemID) then
                return;
            end

            self.Dropped[itemID] = self.Dropped[itemID] or {};

            -- Store for future use
            local quality = GL:getItemQualityFromLink(itemLink);
            if (quality and quality >= self.minimumQuality) then
                tinsert(self.Dropped[itemID], {
                    at = GetServerTime(),
                    source = sourceGUID,
                    unitName = unitName,
                });
            end

            tinsert(Drops, {
                at = GetServerTime(),
                source = sourceGUID,
                itemLink = itemLink,
            });
        end)();

        if (result == false) then
            return;
        end
    end

    self.ProcessedNPCIDs[sourceGUID] = true;
    --self:broadcastDrops(sourceGUID, Drops);
end

---@param Drops table
---@return void
function DroppedLootLedger:broadcastDrops(sourceGUID, Drops)
    -- No need to broadcast twice for the same unit
    if (self.BroadcastedNPCIDs[sourceGUID]) then
        return;
    end

    GL.CommMessage.new{
        action = CommActions.broadcastDrops,
        content = Drops,
        channel = "GROUP",
    }:send();
end

---@param CommMessage table
---@return void
function DroppedLootLedger:receiveDrops(CommMessage)
    -- No need to process our own findings
    if (CommMessage.Sender.isSelf) then
        return;
    end

    if (type(CommMessage.content) ~= "table") then
        return;
    end

    for _, Drop in pairs(CommMessage.content or {}) do
        (function ()
            if (type(Drop) ~= "table"
                or not tonumber(Drop.at)
                or not Drop.source
                or not Drop.itemLink
            ) then
                return;
            end

            local itemID = GL:getItemIDFromLink(Drop.itemLink);
            if (not itemID) then
                return;
            end

            local quality = GL:getItemQualityFromLink(Drop.itemLink);
            if (not quality or quality < self.minimumQuality) then
                return;
            end

            -- We already know about this itme
            if (self.Dropped[itemID][Drop.source]) then
                return;
            end

            tinsert(self.Dropped[itemID], {
                at = tonumber(Drop.at),
                source = Drop.source,
                --unitName = GL:unitNameByID(), ---@todo fix
            });
        end)();
    end
end

---@param GUID string
---@return number|boolean
function DroppedLootLedger:getNPCIDFromSourceGUID(GUID)
    local NPCID = select(6, strsplit("-", GUID));
    NPCID = tonumber(NPCID);

    return NPCID;
end

---@return void
function DroppedLootLedger:processCombatLog(...)
    local timestamp, event, _, _, _, _, _, unitGUID, unitName = ...;

    if (event ~= "UNIT_DIED" or self.KilledBosses[unitGUID]) then
        return;
    end

    local NPCID = self:getNPCIDFromSourceGUID(unitGUID);
    if (not NPCID or not Bosses[NPCID]) then
        --return;
    end

    DB:add("KilledBosses", {
        timestamp = timestamp,
        uuid = unitGUID,
        NPCID = NPCID,
        localizedName = unitName,
        name = Bosses[NPCID],
    });
    -- /script _G.Gargul:xd(_G.Gargul.DB:get("KilledBosses"));
end

---@param message string
---@return table|nil
function DroppedLootLedger:processReceivedItem(message)
    local itemLink, playerName = self:receivedItemDetails(message);
    if (not itemLink) then
        return;
    end

    local itemID = GL:getItemIDFromLink(itemLink);
    if (not itemID) then
        return;
    end

    local itemQuality = GL:getItemQualityFromLink(itemLink);

    local Details = {
        itemID = itemID,
        itemLink = itemLink,
        droppedOn = GetTime(),
        quality = itemQuality,
        playerName = playerName,
    };

    -- Store the item in our dropped loot ledger
    --self:storeReceivedItem(Details);

    Events:fire("GL.ITEM_RECEIVED", Details);

    return Details;
end

---@return void
function DroppedLootLedger:storeReceivedItem(Details)
    -- We don't want to keep track of this quality
    if (not Details.itemQuality
        or Details.itemQuality < self.minimumQuality
    ) then
        return;
    end

    DB:add("DroppedLoot", {
        i = Details.itemID,
        t = Details.droppedOn,
        p = Details.playerName,
    });
end

---@return any
function DroppedLootLedger:receivedItemDetails(message)
    --- Did someone else receive multiple items?
    local playerName, itemLink, itemCount = deformat(message, LOOT_ITEM_MULTIPLE);

    --- Did someone else receive a single item?
    if (not playerName) then
        itemCount = 1;
        playerName, itemLink = deformat(message, LOOT_ITEM);
    end

    --- Did we receive multiple items?
    if (not playerName) then
        playerName = User.name;
        itemLink, itemCount = deformat(message, LOOT_ITEM_SELF_MULTIPLE);
    end

    --- Did we receive a single item?
    if (not itemLink) then
        itemCount = 1;
        itemLink = deformat(message, LOOT_ITEM_SELF);
    end

    --- No valid item detected
    if (not itemLink) then
        return false;
    end

    itemCount = tonumber(itemCount) or 1;
    return itemLink, playerName, itemCount;
end
