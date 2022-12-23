---@type GL
local _, GL = ...;

---@class PlusOnes
GL.PlusOnes = {
    _initialized = false,
    broadcastInProgress = false,
    requestingData = false,
    ImportDialog = false,
    MaterializedData = {
        DetailsByPlayerName = {},
    },
    QueuedUpdates = {},
    QueuedUpdateBroadcastTimer = false,
};

local DB = GL.DB; ---@type DB
local CommActions = GL.Data.Constants.Comm.Actions;
local PlusOnes = GL.PlusOnes; ---@type PlusOnes

---@return boolean
function PlusOnes:_init()
    GL:debug("PlusOnes:_init");

    if (self._initialized) then
        return false;
    end

    --- Register listener for whisper command.
    GL.Events:register("PlusOnesWhisperListener", "CHAT_MSG_WHISPER", function (event, message, sender)
        if (GL.Settings:get("PlusOnes.enableWhisperCommand", true)) then
            self:handleWhisperCommand(event, message, sender);
        end
    end);

    GL.Events:register("PlusOnesUserJoinedGroupListener", "GL.USER_JOINED_GROUP", function () self:requestData(); end);

    -- Make sure PlusOnes changes are only broadcasted once every 3 seconds
    GL.Events:register("PlusOnesUpdateQueuedListener", "GL.PLUSONES_UPDATE_QUEUED", function ()
        GL.Ace:CancelTimer(self.QueuedUpdateBroadcastTimer);

        self.QueuedUpdateBroadcastTimer = GL.Ace:ScheduleTimer(function ()
            self:broadcastQueuedUpdates();
        end, 3);
    end);

    self:materializeData();

    self._initialized = true;
    return true;
end

--- Get the normalized player name (or alias parent if available)
---
---@param playerName string
---@return string
function PlusOnes:normalizedName(playerName)
    local normalizedName = GL:normalizedName(playerName);
    return normalizedName;
end

--- Check whether we trust the given player (currently used to auto-accept incoming broadcasts)
---
---@param playerName string
---@return boolean
function PlusOnes:playerIsTrusted(playerName)
    GL:debug("PlusOnes:playerIsTrusted");

    if (not playerName) then
        return false;
    end

    local normalizedName = self:normalizedName(playerName);

    local trustedPlayerCSV = GL.Settings:get("PlusOnes.automaticallyAcceptDataFrom", "");
    local TrustedPlayers = GL:strSplit(trustedPlayerCSV, ",");
    for _, player in pairs(TrustedPlayers) do
        if (GL:normalizedName(player) == normalizedName) then
            return true;
        end
    end

    return false;
end

--- Mark a given player as "trusted"
---
---@param playerName string
---@return void
function PlusOnes:markPlayerAsTrusted(playerName)
    playerName = strtrim(playerName);

    if (GL:empty(playerName)
        or self:playerIsTrusted(playerName)
    ) then
        return;
    end

    local trustedPlayerCSV = GL.Settings:get("PlusOnes.automaticallyAcceptDataFrom", "");
    if (GL:empty(trustedPlayerCSV)) then
        GL.Settings:set("PlusOnes.automaticallyAcceptDataFrom", playerName);
        return
    else
        local TrustedPlayers = GL:strSplit(trustedPlayerCSV, ",");
        tinsert(TrustedPlayers, playerName);
        GL.Settings:set("PlusOnes.automaticallyAcceptDataFrom", table.concat(TrustedPlayers, ","));
    end
end

--- Remove a player from the list of "trusted" players
---
---@param playerName string
---@return void
function PlusOnes:removePlayerFromTrusted(playerName)
    playerName = strtrim(playerName);

    -- No point removing the player if he's not trusted in the first place
    if (GL:empty(playerName)
        or not self:playerIsTrusted(playerName)
    ) then
        return;
    end

    local trustedPlayerCSV = GL.Settings:get("PlusOnes.automaticallyAcceptDataFrom", "");
    local TrustedPlayers = GL:strSplit(trustedPlayerCSV, ",");
    local NewTrustedPlayers = {};
    local normalizedName = GL:normalizedName(playerName);

    for _, trustedPlayer in pairs(TrustedPlayers) do
        if (GL:normalizedName(trustedPlayer) ~= normalizedName) then
            tinsert(NewTrustedPlayers, trustedPlayer);
        end
    end

    GL.Settings:set("PlusOnes.automaticallyAcceptDataFrom", table.concat(NewTrustedPlayers, ","));
end

--- Check whether plus ones are enabled
---
---@return boolean
function PlusOnes:enabled()
    GL:debug("PlusOnes:enabled");

    return GL.Settings:get("PlusOnes.enabled", false);
end

--- Check whether there are plus ones available
---
---@return boolean
function PlusOnes:available()
    GL:debug("PlusOnes:available");

    --return GL:higherThanZero(DB:get("PlusOnes.MetaData.updatedAt", 0)); --not sure this check is even needed for plus ones
    return true;
end

--- Draw either the importer or overview
--- based on the current boosted roll data
---
---@return void
function PlusOnes:draw()
    GL:debug("PlusOnes:draw");

    -- Show the plus ones overview instead
    GL.Interface.PlusOnes.Overview:draw();
end

--- Checks and handles whisper commands if enabled.
---
---@param _ string
---@param message string
---@param sender string
---@return void
function PlusOnes:handleWhisperCommand(_, message, sender)
    GL:debug("PlusOnes:handleWhisperCommand");

    -- Only listen to the following messages
    if (not GL:strStartsWith(message, "!plusone")
        and not GL:strStartsWith(message, "!PLUSONE")
        and not GL:strStartsWith(message, "!po")
        and not GL:strStartsWith(message, "!PO")
        and not GL:strStartsWith(message, "!+1")
    ) then
        return;
    end

    local args = GL:strSplit(message, " ");

    -- See if name is given.
    if (#args > 1) then
        local name = self:normalizedName(args[2]);
        local plusOne = self:getPlusOnes(name);
        GL:sendChatMessage(
            string.format("Player %s's %s total is %d", GL:capitalize(name), GL.Settings:get("PlusOnes.identifier", "PO"), plusOne),
            "WHISPER", nil, sender
        );
        return;
    end

    local name = sender;
    if (not GL.isEra) then
        name = GL:stripRealm(name);
    end

    name = self:normalizedName(name);
    local plusOne = self:getPlusOnes(name);
    GL:sendChatMessage(
        string.format("Your %s total is %d", GL.Settings:get("PlusOnes.identifier", "PO"), plusOne),
        "WHISPER", nil, sender
    );
end

--- Materialize the plus one data to make it more accessible during runtime
---
---@return void
function PlusOnes:materializeData()
    GL:debug("PlusOnes:materializeData");

    local DetailsByPlayerName = {}; -- Details including aliases by player name

    --- Create entries from Totals data
    for name, plusOne in pairs(DB:get("PlusOnes.Totals", {})) do
        name = GL:normalizedName(name or "");
        plusOne = self:toPlusOne(plusOne or 0);

        if (type(name) == "string"
            and not GL:empty(name)
        ) then
            if (not DetailsByPlayerName[name]) then
                GL:tableSet(DetailsByPlayerName, name .. ".total", plusOne);
            end
        end
    end

    self.MaterializedData.DetailsByPlayerName = DetailsByPlayerName;
end

--- Format a plus one.
---
---@param plusOne any
---@return number if valid, else nil
function PlusOnes:toPlusOne(plusOne)
    plusOne = tonumber(plusOne);

    if not plusOne then
        return nil;
    end

    plusOne = math.max(0, math.floor(plusOne));
    return plusOne;
end;

--- Clear all plus one data
---
---@return void
function PlusOnes:clearPlusOnes()
    DB.PlusOnes = {
        Totals = {},
        MetaData = {},
    };
    self.MaterializedData = {
        DetailsByPlayerName = {},
    };
    
    ---added this code below to broadcast when the ML clears all the plus one data.
    if (GL.Settings:get("PlusOnes.automaticallyShareData")
    and self:userIsAllowedToBroadcast()) then
        self:broadcast(); 
    end
    ---

    self:triggerChangeEvent();
end

--[[--- Determine if a player is present in the table --- not sure if this is even called elsewhere
---
---@param name string
---@return boolean
function PlusOnes:hasPlusOnes(name)
    GL:debug("PlusOnes:hasPlusOnes");

    if (type(name) ~= "string") then
        return false;
    end

    local normalizedName = self:normalizedName(name);

    if (self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        return true;
    end

    return false;
end]]--

--- Get a player's plus one
---
---@param name string
---@return void
function PlusOnes:getPlusOnes(name)
    GL:debug("PlusOnes:getPlusOnes");

    if (type(name) ~= "string") then
        return 0;
    end

    local normalizedName = self:normalizedName(name);

    return GL:tableGet(self.MaterializedData or {}, "DetailsByPlayerName." .. normalizedName .. ".total", 0);
end

--- Set a player's plus one
---
---@param name string
---@param plusOne number
---@param dontBroadcast boolean
---@return void
function PlusOnes:setPlusOnes(name, plusOne, dontBroadcast)
    GL:debug("PlusOnes:setPlusOnes");
    if (type(name) ~= "string") then
        return;
    end

    dontBroadcast = GL:toboolean(dontBroadcast);

    local normalizedName = self:normalizedName(name);

    if (not self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        GL:tableSet(self.MaterializedData or {}, "DetailsByPlayerName." .. normalizedName .. ".total", plusOne);
    else
        self.MaterializedData.DetailsByPlayerName[normalizedName].total = plusOne;
    end
    DB:set("PlusOnes.Totals." .. normalizedName, plusOne);
    DB:set("PlusOnes.MetaData.updatedAt", GetServerTime());

    if (not dontBroadcast
        and GL.Settings:get("PlusOnes.automaticallyShareData")
    ) then
        self:broadcastUpdate(normalizedName, plusOne);
    end
    self:triggerChangeEvent();
end

--- Delete an entry --- not sure where this would be needed since the player list is generated based on the group/raid members
---
---@param name string
---@return void
function PlusOnes:deletePlusOnes(name, dontBroadcast)
    GL:debug("PlusOnes:deletePlusOnes");
    if (type(name) ~= "string") then
        return;
    end

    dontBroadcast = GL:toboolean(dontBroadcast);

    local normalizedName = self:normalizedName(name);

    if (not self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        return;
    end

    self.MaterializedData.DetailsByPlayerName[normalizedName] = nil;
    DB.PlusOnes.Totals[normalizedName] = nil;
    DB:set("PlusOnes.MetaData.updatedAt", GetServerTime());

    if (not dontBroadcast
        and GL.Settings:get("PlusOnes.automaticallyShareData")
    ) then
        self:broadcastUpdate(normalizedName, nil, nil, true);
    end
end

--- Modify a player's plus one -- don't know if this is needed since numbers are increased or decreased and not set directly
---
---@param name string
---@param change number
---@return void
function PlusOnes:modifyPlusOnes(name, change)
    GL:debug("PlusOnes:modifyPlusOnes");
    if (type(name) ~= "string") then
        return;
    end

    local normalizedName = self:normalizedName(name);
    if (not self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        return;
    end

    local plusOne = self.MaterializedData.DetailsByPlayerName[normalizedName].total;
    plusOne = self:toPlusOne(plusOne + change);
    self:setPlusOnes(normalizedName, plusOne);
end

--- Import a CSV or TSV data string
---
---@param data string
---@param openOverview boolean (optional, default: false)
---@param MetaData table (optional, default: auto generate new metadata)
---@return boolean
function PlusOnes:import(data, openOverview, MetaData)
    GL:debug("PlusOnes:import");
    -- Make sure all the required properties are available and of the correct type
    if (GL:empty(data)) then
        GL.Interface:get("PlusOnes.Importer", "Label.StatusMessage"):SetText("Invalid plus one data provided");
        return false;
    end

    local Totals = {};

    -- If the user copy/pasted from google sheets there will be addition quotes that need to be removed
    data = data:gsub("\"", "");

    for line in data:gmatch("[^\n]+") do
        --- We expect lines to be in the form,
        --- where the individual variables are comma, tab, or spaces separated:
        --- PlayerName,Points
        --- This facilitates imports from CSV, TSV files or pasting from Google Docs
        local Segments = GL:separateValues(line);
        
        local playerName = tostring(Segments[1]);
        playerName = GL:normalizedName(playerName);
        local plusOne = self:toPlusOne(Segments[2]);

        if (not GL:empty(playerName) and not Totals[playerName] and plusOne) then
            Totals[playerName] = plusOne;
        end
    end

    if (GL:empty(Totals)) then
        local errorMessage = "Invalid data provided. Make sure that the contents follows the required format and no header row is included.";
        GL.Interface:get("PlusOnes.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    local MetaData = MetaData or {};

    DB.PlusOnes = {
        Totals = Totals,
        MetaData = {
            importedAt = MetaData.importedAt or GetServerTime(),
            updatedAt = MetaData.updatedAt or GetServerTime(),
            uuid = MetaData.uuid or GL:uuid(),
        },
    };

    GL:success("Import of plus one data successful");
    GL.Events:fire("GL.PLUSONES_IMPORTED");

    self:materializeData();
    GL.Interface.PlusOnes.Importer:close();

    if (openOverview) then
        self:draw();

        -- The user is in charge of automatically sharing TMB data
        -- after importing it, let's get crackin'!
        if (GL.Settings:get("PlusOnes.automaticallyShareData")
            and self:userIsAllowedToBroadcast()
        ) then
            self:broadcast();
        end
    end

    return true;
end

--- Export to CSV
---
---@param displayFrame boolean
---@return void
function PlusOnes:export(displayFrame)
    GL:debug("PlusOnes:export");
    
    -- Create CSV string
    local csv = "";
    for name, Entry in pairs(self.MaterializedData.DetailsByPlayerName) do
        csv = csv..GL:capitalize(name)..","..Entry.total;
        csv = csv.."\n";
    end

    if (displayFrame) then
        GL:frameMessage(csv);
    end
    return csv;
end

--- Broadcast our plus one data to the raid or group
---
---@return boolean
function PlusOnes:broadcast()
    GL:debug("PlusOnes:broadcast");
    if (self.broadcastInProgress) then
        GL:error("Broadcast still in progress");
        return false;
    end

    -- No need to broadcast anything when not in a group, this also doesn't warrent a warning
    if (not GL.User.isInGroup) then
        return false;
    end

    if (not self:userIsAllowedToBroadcast()) then
        GL:warning("Insufficient permissions to broadcast, need ML, assist or lead!");
        return false;
    end

    -- Check if there's anything to share
    if (not self:available()) then
        GL:warning("Nothing to broadcast, import Plus Ones data first!");
        return false;
    end

    -- No need to keep any queued updates, we're doing a full broadcast now anyways
    self.QueuedUpdates = {};

    self.broadcastInProgress = true;
    GL.Events:fire("GL.PLUSONES_BROADCAST_STARTED");

    local Broadcast = function ()
        GL:message("Broadcasting PlusOnes data...");

        local Label = GL.Interface:get(GL.PlusOnes, "Label.BroadcastProgress");

        if (Label) then
            Label:SetText("Broadcasting...");
        end

        GL.CommMessage.new(
            CommActions.broadcastPlusOnesData,
            {
                importString = self:export(false),
                MetaData = DB:get("PlusOnes.MetaData", {}),
            },
            "GROUP"
        ):send(function ()
            GL:success("PlusOnes broadcast finished");

            --- Broadcast updates before we reset the flag. Enabling this ends up calling receiveUpdate before receiveBroadcast and breaks the code
           -- self:broadcastQueuedUpdates();

            self.broadcastInProgress = false;
            GL.Events:fire("GL.PLUSONES_BROADCAST_ENDED");

            Label = GL.Interface:get(GL.PlusOnes, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText("Broadcast finished!");
            end
        end, function (sent, plusOne)
            Label = GL.Interface:get(GL.PlusOnes, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText(string.format("Sent %s of %s bytes", sent, plusOne));
            end
        end);
    end

    -- We're about to send a lot of data which will put strain on CTL
    -- Make sure we're out of combat before doing so!
    if (UnitAffectingCombat("player")) then
        GL:message("You are currently in combat, delaying PlusOnes broadcast");

        GL.Events:register("PlusOnesOutOfCombatListener", "PLAYER_REGEN_ENABLED", function ()
            GL.Events:unregister("PlusOnesOutOfCombatListener");
            Broadcast();
        end);
    else
        Broadcast();
    end

    return true;
end

--- Process an incoming plus one broadcast
---
---@param CommMessage CommMessage
function PlusOnes:receiveBroadcast(CommMessage)
    GL:debug("PlusOnes:receiveBroadcast");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == GL.User.name) then
        GL:debug("PlusOnes:receiveBroadcast received by self, skip");
        return true;
    end
    local importString = CommMessage.content.importString or '';
    local MetaData = CommMessage.content.MetaData or {};
    local importBroadcast = (function ()
        if (GL:empty(importString)) then
            self:clearPlusOnes();
            return;
            --GL:warning("Couldn't process PlusOnes data received from " .. CommMessage.Sender.name);
            --return false;
        end

        GL:warning("Attempting to process incoming PlusOnes data from " .. CommMessage.Sender.name);

        local result = self:import(importString, false, MetaData);
        if (result) then
            self:triggerChangeEvent();
        end

        return result;
    end);

    --- Check whether we can trust this sender (and as such immediately accept the incoming broadcast)
    if (self:playerIsTrusted(CommMessage.Sender.name)
        or self:playerIsTrusted(CommMessage.senderFqn)
    ) then
        importBroadcast();
        return;
    end
    --- Display different messages depending on whether it is an update of the same import or completely new data.
    local uuid = DB:get("PlusOnes.MetaData.uuid", '');
    local updatedAt = DB:get("PlusOnes.MetaData.updatedAt", 0);
    local question;
    
    if (GL:empty(importString)) then
    question = string.format(
        "%s wants to clear all your plus one data. Clear all plus one data?",
        CommMessage.Sender.name
    );
    elseif (MetaData.uuid and uuid == MetaData.uuid) then -- This is an update to our dataset
        question = string.format(
            "Are you sure you want to update your existing plus ones with data from |c00%s%s|r?\n\nYour latest update was on |c00a79eff%s|r, theirs on |c00a79eff%s|r.",
            GL:classHexColor(GL.Player:classByName(CommMessage.Sender.name)),
            CommMessage.Sender.name,
            date("%Y-%m-%d %H:%M", updatedAt),
            date("%Y-%m-%d %H:%M", MetaData.updatedAt or 0)
        );
    elseif (not GL:empty(uuid)) then -- This is a different dataset, not an update
        question = string.format(
            "Are you sure you want to clear your existing plus one data and import new data broadcasted by %s?",
            CommMessage.Sender.name
        );
    else
        question = string.format(
            "Are you sure you want to import new data broadcasted by %s?",
            CommMessage.Sender.name
        );
    end

    local Dialog = {
        question = question,
        OnYes = importBroadcast,
        sender = CommMessage.Sender.name,
    };

    GL.Interface.Dialogs.IncomingPlusOneDataDialog:open(Dialog);
end

--- Request PlusOnes data from the person in charge (ML or Leader).
---
---@return void
function PlusOnes:requestData()
    GL:debug("PlusOnes:requestData");

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
        CommActions.requestPlusOnesData,
        DB:get('PlusOnes.MetaData', {}),
        "WHISPER",
        playerToRequestFrom
    ):send();

    self.requestingData = false;
end

--- Reply to a player's PlusOnes data request.
---
---@param CommMessage CommMessage
---@return void
function PlusOnes:replyToDataRequest(CommMessage)
    GL:debug("PlusOnes:replyToDataRequest");

    -- I don't have any data, leave me alone!
    if (not self:available()) then
        return;
    end

    -- We're not in a group (anymore), no need to help this person out
    if (not GL.User.isInGroup) then
        return;
    end

    -- Nice try, but we don't allow auto-sharing
    if (not GL.Settings:get("PlusOnes.automaticallyShareData")) then
        return;
    end

    -- Nice try, but we're not allowed to share data
    if (not self:userIsAllowedToBroadcast()) then
        return;
    end

    local uuid = CommMessage.content.uuid or '';
    local lastUpdate = CommMessage.content.updatedAt or 0;
    -- Your data is up to date, leave me alone!
    if (not GL:empty(uuid)
        and uuid == DB:get('PlusOnes.MetaData.uuid', '')
        and lastUpdate >= DB:get('PlusOnes.MetaData.updatedAt', 0)
    ) then
        return;
    end

    -- Looks like you need my data, here it is!
    GL.CommMessage.new(
        CommActions.broadcastPlusOnesData,
        {
            importString = self:export(false),
            MetaData = DB:get("PlusOnes.MetaData", {}),
        },
        "WHISPER",
        CommMessage.Sender.name
    ):send();
end

--- Add points to a give user's balance
---
---@param playerName string
function PlusOnes:addPlusOnes(playerName)
    GL:debug("PlusOnes:addPlusOnes")

    local currentPoints = self:getPlusOnes(playerName) or 0;
    self:queueUpdate(playerName, currentPoints + 1);
end

--- Subtract points from a given user's balance
---
---@param playerName string
function PlusOnes:subtractPlusOnes(playerName)
    GL:debug("PlusOnes:subtractPlusOnes");

    local currentPoints = self:getPlusOnes(playerName) or 0;

    self:queueUpdate(playerName, max(currentPoints - 1, 0));
end

--- Queue an update until broadcast is finished
---
---@param playerName string
---@param plusOne number
---@param delete boolean
function PlusOnes:queueUpdate(playerName, plusOne, delete)
    local dontBroadcast = true;

    if (plusOne) then
        self:setPlusOnes(playerName, plusOne, dontBroadcast);
    end

    if (delete) then
        self:deletePlusOnes(playerName, dontBroadcast);
    end

    local Update = {
        playerName = playerName,
        plusOne = plusOne or nil,
        delete = delete or false,
    };

    tinsert(self.QueuedUpdates, Update);

    -- Fire an event to let the application know that an update was queued
    GL.Events:fire("GL.PLUSONES_UPDATE_QUEUED");
end

--- Send out the queued updates
---
---@return void
function PlusOnes:broadcastQueuedUpdates()
    GL:debug("PlusOnes:broadcastQueuedUpdates");

    if (not GL.User.isInGroup) then
        return false;
    end

    --if (not self:userIsAllowedToBroadcast()) then
    --    GL:warning("Insufficient permissions to broadcast, need ML, assist or lead!");
    --    return false;
    --end

    if (GL.Settings:get("PlusOnes.automaticallyShareData")
    and self:userIsAllowedToBroadcast()) then
        GL:message("Broadcasting PlusOnes updates...");
        GL.CommMessage.new(
            CommActions.broadcastPlusOnesMutation,
            {
                updates = self.QueuedUpdates,
                uuid = DB:get("PlusOnes.MetaData.uuid", ""),
            },
            "GROUP"
        ):send(function ()
            GL:success("PlusOnes updates finished");

            --self.broadcastInProgress = false;
            --GL.Events:fire("GL.PLUSONES_BROADCAST_ENDED");
        end);
    end

    self.QueuedUpdates = {};
end

--- Process an outgoing plus one update
---
---@param playerName string
---@param plusOne number
---@param delete boolean
function PlusOnes:broadcastUpdate(playerName, plusOne, delete)
    GL:debug("PlusOnes:broadcastUpdate");

    if (not GL.User.isInGroup) then
        GL:warning("No one to broadcast to, you're not in a group!");
        return false;
    end

    if (not self:userIsAllowedToBroadcast()) then
        GL:warning("Insufficient permissions to broadcast, need ML, assist or lead!");
        return false;
    end

    if (self.broadcastInProgress) then
        GL:error("Broadcast still in progress");
        self:queueUpdate(playerName, plusOne, delete);
        return false;
    end

    GL:message("Broadcasting PlusOnes update...");

    GL.CommMessage.new(
        CommActions.broadcastPlusOnesMutation,
        {
            updates = {{
                playerName = playerName,
                plusOne = plusOne or nil,
                delete = delete or false,
            }},
            uuid = DB:get("PlusOnes.MetaData.uuid", ""),
        },
        "GROUP"
    ):send();

    return true;
end

--- Process an incoming plus one update
---
---@param CommMessage CommMessage
function PlusOnes:receiveUpdate(CommMessage)
    GL:debug("PlusOnes:receiveUpdate");
    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == GL.User.name) then
        GL:debug("PlusOnes:receiveUpdate received by self, skip");
        return true;
    end

    local uuid = DB:get("PlusOnes.MetaData.uuid", '');

    local importUuid = CommMessage.content.uuid or GL:uuid();
    local importUpdatedAt = CommMessage.content.updatedAt;
    local updates = CommMessage.content.updates or {};
    local importBroadcast = (function (update)
        local playerName = update.playerName or '';
        local plusOne = update.plusOne or nil;
        local delete = update.delete or false;
        local dontBroadcast = true;

        if (plusOne) then
            self:setPlusOnes(playerName, plusOne, dontBroadcast);
        end

        if (delete) then
            self:deletePlusOnes(playerName, dontBroadcast);
        end

    end);
    local processUpdates = (function ()
        for _, update in pairs(CommMessage.content.updates or {}) do
            importBroadcast(update);
        end
    end);

    --- Check whether we can trust this sender (and as such immediately accept the incoming broadcast)
    if (self:playerIsTrusted(CommMessage.Sender.name)
        or self:playerIsTrusted(CommMessage.senderFqn)
    ) then
        processUpdates();
        return;
    end

    --- Display different messages depending on whether it is an update of the same import or completely new data.
    local updatedAt = DB:get("PlusOnes.MetaData.updatedAt", 0);
    local question;
    if (importUuid and uuid == importUuid) then -- This is an update to our dataset
        question = string.format(
            "Are you sure you want to update your existing plus one with data from |c00%s%s|r?\n\nYour latest update was on |c00a79eff%s|r, theirs on |c00a79eff%s|r.",
            GL:classHexColor(GL.Player:classByName(CommMessage.Sender.name)),
            CommMessage.Sender.name,
            date("%Y-%m-%d %H:%M", updatedAt),
            date("%Y-%m-%d %H:%M", importUpdatedAt or 0)
        );
    elseif (not GL:empty(uuid)) then-- This is a different dataset, not an update
        question = string.format(
            "Are you sure you want to clear your existing plus one data and import new data broadcasted by %s?",
            CommMessage.Sender.name
        );
    end

    local Dialog = {
        question = question,
        OnYes = processUpdates,
        sender = CommMessage.Sender.name,
    };

    GL.Interface.Dialogs.IncomingPlusOneDataDialog:open(Dialog);

end

--- Check whether the current user is allowed to broadcast PlusOnes data
---
---@return boolean
function PlusOnes:userIsAllowedToBroadcast()
    return GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist);
end

--- Trigger the PLUSONES_CHANGED event
---
---@return void
function PlusOnes:triggerChangeEvent()
    GL:debug("PlusOnes:triggerChangeEvent");

    GL.Events:fire("GL.PLUSONES_CHANGED");
end

GL:debug("PlusOnes.lua");