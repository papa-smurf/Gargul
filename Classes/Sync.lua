--[[--
    This class is responsible for sending and receiving
    character and loot history data between players
]]

local _, App = ...;

App.Sync = {
    broadcastInProgress = false,
    characterBroadCastMessage = false,
    lootHistoryBroadCastMessage = false,
};

local Sync = App.Sync;
local CommActions = App.Data.Constants.Comm.Actions;

function Sync:broadcast()
    App:debug("Sync:broadcast");

    if (self.broadcastInProgress) then
        return App:error("Broadcast still in progress");
    end

    -- Only officers are allowed to broadcast!
    if (not App.User.isOfficer) then
        return App:warning("Only officers are allowed to use this feature");
    end

    App:success("Broadcast started");

    -- Check if the broadcaster's tables are valid
    local dbIsValid, messages = App.DB:isValid();
    if (not dbIsValid) then
        for key in pairs(messages) do
            App:error(messages[key]);
        end

        return;
    end

    self.broadcastInProgress = true;
    self:broadcastCharacters();
    self:broadcastLootHistory();

    App.Ace:ScheduleTimer(function ()
        App:success("Broadcast finished");
        self.broadcastInProgress = false;

-- TODO: WIP!
--        self:processBroadcastCharactersResponses();
--        self:processBroadcastLootHistoryResponses();
    end, 10);
end

function Sync:broadcastCharacters()
    App:debug("Sync:broadcastCharacters");

    self.charactersBroadcastInProgress = true;
    local Message = App.CommMessage.new(
        CommActions.broadcastCharacters,
        App.DB:compressCharactersTable(),
        "GUILD"
    ):send();

    self.characterBroadCastMessage = Message;
end

function Sync:broadcastLootHistory()
    App:debug("Sync:broadcastLootHistory");

    local Message = App.CommMessage.new(
        CommActions.broadcastLootHistory,
        App.DB:compressLootHistoryTable(),
        "GUILD"
    ):send();

    self.lootHistoryBroadCastMessage = Message;
end

function Sync:receiveCharacters(CommMessage)
    App:debug("Sync:receiveCharacters");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == App.User.name) then
        App:debug("Sync:receiveCharacters received by self, skip");
        return;
    end

    local CharactersTable = App.DB:decompressCharactersTable(CommMessage.content);

    if (not App.DB:charactersTableIsValid(CharactersTable)) then
        return App:error("Characters table sent by " .. CommMessage.Sender.name .. " is invalid");
    end

    App.DB.Characters = CharactersTable;
    App.User:refresh();

    App:success("Your DKP table just got updated by " .. CommMessage.Sender.name);

-- TODO: DISABLED BECAUSE WIP
    if (false and not CommMessage.Sender.id == App.User.id) then
        CommMessage:respond(App.Data.Constants.success);
    end
end

function Sync:receiveLoot(CommMessage)
    App:debug("Sync:receiveLoot");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == App.User.name) then
        App:debug("Sync:receiveLoot received by self, skip");
        return;
    end

    local LootHistoryTable = App.DB:decompressLootHistoryTable(CommMessage.content);

    if (not App.DB:lootHistoryTableIsValid(LootHistoryTable)) then
        App:error("LootHistory table sent by " .. CommMessage.Sender.name .. " is invalid");
        return CommMessage:respond(App.Data.Constants.failure);
    end

    App.DB.LootHistory = LootHistoryTable;

    App:success("Your loot history table just got updated by " .. CommMessage.Sender.name);

    -- Update the User's dashboard if it was open
    App.Dashboard:refresh();

-- TODO: DISABLED BECAUSE WIP
    if (false or not CommMessage.Sender.id == App.User.id) then
        CommMessage:respond(App.Data.Constants.success);
    end

    -- Not all metadata is passed through broadcast, fill in the gaps
    App.DB:lootHistoryTableFillMetadata();
end

function Sync:processBroadcastCharactersResponses()
    App:debug("Sync:processBroadcastCharactersResponses");

    local message = self.characterBroadCastMessage;

    -- TODO: Cross reference against raid members (see below)

    -- We no longer need the message or its responses
    App.CommMessage.Box[message.id] = nil;
end

function Sync:processBroadcastLootHistoryResponses()
    App:debug("Sync:processBroadcastLootHistoryResponses");

    local message = self.characterBroadCastMessage;
App:frameMessage(message.Responses);
    -- TODO: Cross reference against raid members (see below)

    -- We no longer need the message or its responses
    App.CommMessage.Box[message.id] = nil;

    -- name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(raidIndex);
    -- raidIndex. Number - Index of raid member between 1 and MAX_RAID_MEMBERS (40). If you specify an index that is out of bounds, the function returns nil.

    -- members = GetNumRaidMembers();
    -- Number - number of players in your raid group, including yourself; or 0 if you are not in a raid group.

    -- index = UnitInRaid("unit")
    -- Returns a number if the unit is in your raid group, nil otherwise.

    -- lootmethod, masterlooterPartyID, masterlooterRaidID = GetLootMethod()
    -- String (LootMethod) - One of 'freeforall', 'roundrobin', 'master', 'group', 'needbeforegreed'. Appears to be 'freeforall' if you are not grouped.: At least as of 7.3 the possible return values appear to be "freeforall", "master", "group" and "personalloot". "roundrobin" and "needbeforegreed" appear to be deprecated.
    -- masterlooterPartyID
    -- Number - Returns 0 if player is the mater looter, 1-4 if party member is master looter (corresponding to party1-4) and nil if the master looter isn't in the player's party or master looting is not used.
    -- masterlooterRaidID
    -- Number - Returns index of the master looter in the raid (corresponding to a raidX unit), or nil if the player is not in a raid or master looting is not used.
end

App:debug("Sync.lua");