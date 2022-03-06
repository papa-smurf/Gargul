---@type GL
local _, GL = ...;

---@class StackedRoll
GL.StackedRoll = {
    _initialized = false,
    broadcastInProgress = false,
    requestingData = false,
    MaterializedData = {
        DetailsByPlayerName = {},
    },
};

local DB = GL.DB; ---@type DB
local CommActions = GL.Data.Constants.Comm.Actions;
local StackedRoll = GL.StackedRoll; ---@type StackedRoll

---@return boolean
function StackedRoll:_init()
    GL:debug("StackedRoll:_init");

    if (self._initialized) then
        return false;
    end

    --- Register listener for whisper command.
    GL.Events:register("StackedRollWhisperListener", "CHAT_MSG_WHISPER", function (event, message, sender)
        if (GL.Settings:get("StackedRoll.enableWhisperCommand", false)) then
            self:handleWhisperCommand(event, message, sender);
        end
    end);

    GL.Events:register("StackedRollUserJoinedGroupListener", "GL.USER_JOINED_GROUP", function () self:requestData(); end);

    self:materializeData();

    self._initialized = true;
    return true;
end

--- Check whether stacked rolls are enabled
---
---@return boolean
function StackedRoll:enabled()
    GL:debug("StackedRoll:enabled");

    return GL.Settings:get("StackedRoll.enabled", false);
end

--- Check whether there are stacked rolls available
---
---@return boolean
function StackedRoll:available()
    GL:debug("StackedRoll:available");

    return GL:higherThanZero(DB:get("StackedRoll.MetaData.importedAt", 0));
end

--- Draw either the importer or overview
--- based on the current stacked roll data
---
---@return void
function StackedRoll:draw()
    GL:debug("StackedRoll:draw");

    -- Show the stacked roll overview instead
    GL.Interface.StackedRoll.Overview:draw();
end

--- Checks and handles whisper commands if enabled.
---
---@param event string
---@param message string
---@return void
function StackedRoll:handleWhisperCommand(event, message, sender)
    if (GL:strStartsWith(message, "!rollbonus") or GL:strStartsWith(message, "!rb")) then
        local args = GL:strSplit(message, " ");
        -- See if name is given.
        if (#args > 1) then
            local name = GL:normalizedName(args[2]);
            local points = self:getPoints(name);
            local low = self:minStackedRoll(points);
            local high = self:maxStackedRoll(points);
            local ext = "";
            if (not self:hasPoints(name)) then
                ext = " (default)";
            end
            GL:sendChatMessage(
                string.format("Player %s's stacked roll is /rnd %d-%d%s", GL:capitalize(name), low, high, ext),
                "WHISPER", nil, sender
            );
            return;
        end

        local points = self:getPoints(sender);
        local low = self:minStackedRoll(points);
        local high = self:maxStackedRoll(points);
        local ext = "";
        if (not self:hasPoints(name)) then
            ext = " (default)";
        end
        GL:sendChatMessage(
            string.format("Your stacked roll is /rnd %d-%d%s", low, high, ext),
            "WHISPER", nil, sender
        );
    end
end

--- Materialize the stacked roll data to make it more accessible during runtime
---
---@return void
function StackedRoll:materializeData()
    GL:debug("StackedRoll:materializeData");

    local DetailsByPlayerName = {}; -- Details including aliases by player name
    local Aliases = {}; -- Direct access to aliases

    --- Create entries from points data
    for name, points in pairs(DB:get("StackedRoll.Points", {})) do
        local name = GL:normalizedName(name or "");
        local points = self:toPoints(points or 0);

        if (type(name) == "string"
            and not GL:empty(name)
        ) then
            if (not DetailsByPlayerName[name]) then
                GL:tableSet(DetailsByPlayerName, name .. ".Aliases", {});
                DetailsByPlayerName[name].points = points;
                DetailsByPlayerName[name].class = "";
            end
        end
    end

    --- Add aliases
    for alias, main in pairs(DB:get("StackedRoll.Aliases", {})) do
        local alias = GL:normalizedName(alias or "");
        local main = GL:normalizedName(main or "");

        if (type(alias) == "string" and type(main) == "string"
            and not GL:empty(alias) and not GL:empty(main)
        ) then
            if (DetailsByPlayerName[main] and not DetailsByPlayerName[alias]) then
                tinsert(DetailsByPlayerName[main].Aliases, alias);
            end
        end
    end

    self.MaterializedData.DetailsByPlayerName = DetailsByPlayerName;
end

--- Format a stacked roll.
---
---@param points any
---@return number if valid, else nil
function StackedRoll:toPoints(points)
    points = tonumber(points);

    if not points then
        return nil;
    end

    points = math.max(0, math.floor(points));
    return points;
end;

--- Calculate roll points from points.
---
---@param points number
---@return number
function StackedRoll:rollPoints(points)
    return math.min(GL.Settings:get("StackedRoll.reserveThreshold", 0), points);
end;

--- Calculate reserve from points.
---
---@param points number
---@return number
function StackedRoll:reserve(points)
    return math.max(0, points - GL.Settings:get("StackedRoll.reserveThreshold", 0));
end;

--- Calculate max roll from points.
---
---@param points number
---@return number
function StackedRoll:maxStackedRoll(points)
    return math.max(1, math.min(GL.Settings:get("StackedRoll.reserveThreshold", 0), points));
end;

--- Calculate min roll from points.
---
---@param points number
---@return number
function StackedRoll:minStackedRoll(points)
    return math.max(1, self:maxStackedRoll(points) - 100);
end;

--- Detect stacked rolls.
---
---@param low number
---@param high number
---@return boolean
function StackedRoll:isStackedRoll(low, high)
    local threshold = GL.Settings:get("StackedRoll.reserveThreshold", 0);
    --- Check maximum.
    if (self:maxStackedRoll(high) ~= high or high > threshold) then
        return false;
    end

    --- Check minimum.
    return self:minStackedRoll(high) == low;
end;

--- Clear all stacked roll data
---
---@return void
function StackedRoll:clear()
    DB.StackedRoll = {
        Points = {},
        Aliases = {},
        MetaData = {},
    };
    self.MaterializedData = {
        DetailsByPlayerName = {},
    };

    GL.Interface.StackedRoll.Overview:close();
    self:draw();
end

--- Set aliases
---
---@param name string
---@param aliases table
---@return void
function StackedRoll:setAliases(name, aliases)
    GL:debug("StackedRoll:setAliases");
    if (type(name) ~= "string") then
        return;
    end

    local normalizedName = GL:normalizedName(name);
    --- Follow alias table if present
    if (DB.StackedRoll.Aliases[normalizedName]) then
        normalizedName = DB.StackedRoll.Aliases[normalizedName];
    end
    if (self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        --- Reset old aliases
        for _, alias in pairs(self.MaterializedData.DetailsByPlayerName[normalizedName].Aliases) do
            DB.StackedRoll.Aliases[alias] = nil;
        end

        --- Set new aliases
        local cleanAliases = {};
        for _, alias in pairs(aliases) do
            --- Check that this alias does not yet exist, otherwise skip.
            if (not DB.StackedRoll.Aliases[alias]) then
                DB.StackedRoll.Aliases[alias] = normalizedName;
                tinsert(cleanAliases, alias);
            end
        end
        self.MaterializedData.DetailsByPlayerName[normalizedName].Aliases = cleanAliases;
        DB:set("StackedRoll.MetaData.updatedAt", GetServerTime());
        if (GL.Settings:get("StackedRoll.automaticallyShareData")) then
            self:broadcastUpdate(normalizedName, nil, aliases);
        end
    end
end

--- Determine if a player is present in the table
---
---@param name string
---@return boolean
function StackedRoll:hasPoints(name)
    GL:debug("StackedRoll:hasPoints");
    
    if (type(name) ~= "string") then
        return false;
    end

    local normalizedName = GL:normalizedName(name);
    --- Follow alias table if present
    if (DB.StackedRoll.Aliases[normalizedName]) then
        normalizedName = DB.StackedRoll.Aliases[normalizedName];
    end
    if (self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        return true;
    end

    return false;
end

--- Get a player's points
---
---@param name string
---@return void
function StackedRoll:getPoints(name)
    GL:debug("StackedRoll:getPoints");
    local default = GL.Settings:get("StackedRoll.defaultPoints", 0);

    if (type(name) ~= "string") then
        return default;
    end

    local normalizedName = GL:normalizedName(name);
    --- Follow alias table if present
    if (DB.StackedRoll.Aliases[normalizedName]) then
        normalizedName = DB.StackedRoll.Aliases[normalizedName];
    end
    if (self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        return self.MaterializedData.DetailsByPlayerName[normalizedName].points;
    end

    return default;
end

--- Set a player's points
---
---@param name string
---@param points number
---@return void
function StackedRoll:setPoints(name, points)
    GL:debug("StackedRoll:setPoints");
    if (type(name) ~= "string") then
        return;
    end

    local normalizedName = GL:normalizedName(name);
    --- Follow alias table if present
    if (DB.StackedRoll.Aliases[normalizedName]) then
        normalizedName = DB.StackedRoll.Aliases[normalizedName];
    end
    if (self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        self.MaterializedData.DetailsByPlayerName[normalizedName].points = points;
        DB:set("StackedRoll.Points."..normalizedName, points);
        DB:set("StackedRoll.MetaData.updatedAt", GetServerTime());
        if (GL.Settings:get("StackedRoll.automaticallyShareData")) then
            self:broadcastUpdate(normalizedName, points);
        end
    end
end

--- Delete an entry
---
---@param name string
---@return void
function StackedRoll:deletePoints(name)
    GL:debug("StackedRoll:deletePoints");
    if (type(name) ~= "string") then
        return;
    end

    local normalizedName = GL:normalizedName(name);
    --- Follow alias table if present
    if (DB.StackedRoll.Aliases[normalizedName]) then
        normalizedName = DB.StackedRoll.Aliases[normalizedName];
    end
    if (self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        for _, alias in pairs(self.MaterializedData.DetailsByPlayerName[normalizedName].Aliases) do
            DB.StackedRoll.Aliases[alias] = nil;
        end
        self.MaterializedData.DetailsByPlayerName[normalizedName] = nil;
        DB.StackedRoll.Points[normalizedName] = nil;
        DB:set("StackedRoll.MetaData.updatedAt", GetServerTime());
        if (GL.Settings:get("StackedRoll.automaticallyShareData")) then
            self:broadcastUpdate(normalizedName, nil, nil, true);
        end
    end
end

--- Modify a player's points
---
---@param name string
---@param points number
---@return void
function StackedRoll:modifyPoints(name, change)
    GL:debug("StackedRoll:modifyPoints");
    if (type(name) ~= "string") then
        return;
    end

    local normalizedName = GL:normalizedName(name);
    --- Follow alias table if present
    if (DB.StackedRoll.Aliases[normalizedName]) then
        normalizedName = DB.StackedRoll.Aliases[normalizedName];
    end
    if (self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        local points = self.MaterializedData.DetailsByPlayerName[normalizedName].points;
        points = self:toPoints(points + change);
        self:setPoints(normalizedName, points);
    end
end

--- Import a CSV or TSV data string
---
---@param data string
---@param openOverview boolean (optional, default: false)
---@param uuid string (optional, default: auto generate new uuid)
---@return boolean
function StackedRoll:import(data, openOverview, uuid)
    GL:debug("StackedRoll:import");

    -- Make sure all the required properties are available and of the correct type
    if (GL:empty(data)) then
        GL.Interface:getItem("StackedRoll.Importer", "Label.StatusMessage"):SetText("Invalid stacked roll data provided");
        return false;
    end

    local Points = {};
    local Aliases = {};
    
    for line in data:gmatch("[^\n]+") do
        --- We expect lines to be in the form,
        --- where the individual variables are comma, tab, or spaces separated:
        --- PlayerName,Points,Alias1,Alias2...
        --- e.g., "Foobar,240,Barfoo"
        --- This facilitates imports from CSV, TSV files or pasting from Google Docs
        local Segments = GL:separateValues(line);
        
        local playerName = tostring(Segments[1]);
        playerName = GL:normalizedName(playerName);
        local points = self:toPoints(Segments[2]);

        if (not GL:empty(playerName) and not Points[playerName] and points) then
            Points[playerName] = points;

            --- Import further segments as aliases (twink names)
            for i = 3, #Segments do
                local alias = tostring(Segments[i]);
                alias = GL:normalizedName(alias);
                if (not GL:empty(alias) and not Points[alias] and not Aliases[alias]) then
                    Aliases[alias] = playerName;
                end
            end
        end
    end

    if (GL:empty(Points)) then
        local errorMessage = "Invalid data provided. Make sure that the contents follows the required format and no header row is included.";
        GL.Interface:getItem("StackedRoll.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    uuid = uuid or GL:uuid();

    DB.StackedRoll = {
        Points = Points,
        Aliases = Aliases,
        MetaData = {
            importedAt = GetServerTime(),
            updatedAt = GetServerTime(),
            uuid = uuid,
        },
    };

    GL:success("Import of stacked roll data successful");
    GL.Events:fire("GL.STACKEDROLL_IMPORTED");

    self:materializeData();
    GL.Interface.StackedRoll.Importer:close();

    if (openOverview) then
        self:draw();

        -- The user is in charge of automatically sharing TMB data
        -- after importing it, let's get crackin'!
        if (GL.Settings:get("StackedRoll.automaticallyShareData")
            and self:userIsAllowedToBroadcast()
        ) then
            self:broadcast();
        end
    end

    return true;
end

--- Adds missing raiders with default points
---
---@return void
function StackedRoll:addMissingRaiders()
    GL:debug("StackedRoll:addMissingRaiders");

    -- Go through everyone in the raid
    if (GL.User.isInGroup) then
        local default = GL.Settings:get("StackedRoll.defaultPoints", 0);
        for _, Player in pairs(GL.User:groupMembers()) do
            local playerName = GL:normalizedName(Player.name);
            if (not self:hasPoints(playerName)) then
                DB.StackedRoll.Points[playerName] = default;
            end
        end
        DB:set("StackedRoll.MetaData.importedAt", GetServerTime());
        DB:set("StackedRoll.MetaData.updatedAt", GetServerTime());
        if (not DB:get("StackedRoll.MetaData.uuid", nil)) then
            DB:set("StackedRoll.MetaData.uuid", GL:uuid());
        end
        self:materializeData();
    end
end

--- Export to CSV
---
---@param displayFrame boolean
---@return void
function StackedRoll:export(displayFrame)
    GL:debug("StackedRoll:export");

    -- Calculate max aliases to output a CSV compliant string
    local numAliases = 0;
    for _, Entry in pairs(self.MaterializedData.DetailsByPlayerName) do
        numAliases = math.max(numAliases, #Entry.Aliases);
    end
    
    -- Create CSV string
    local csv = "";
    for name, Entry in pairs(self.MaterializedData.DetailsByPlayerName) do
        csv = csv..GL:capitalize(name)..","..Entry.points;
        
        -- Always add maximum aliases
        for i = 1,numAliases do
            csv = csv..",";
            if (Entry.Aliases[i]) then
                csv = csv..GL:capitalize(Entry.Aliases[i]);
            end
        end
        csv = csv.."\n";
    end

    if (displayFrame) then
        GL:frameMessage(csv);
    end

    return csv;
end

--- Broadcast our stacked roll data to the raid or group
---
---@return boolean
function StackedRoll:broadcast()
    GL:debug("StackedRoll:broadcast");

    if (self.broadcastInProgress) then
        GL:error("Broadcast still in progress");
        return false;
    end

    if (not GL.User.isInGroup) then
        GL:warning("No one to broadcast to, you're not in a group!");
        return false;
    end

    if (not self:userIsAllowedToBroadcast()) then
        GL:warning("Insufficient permissions to broadcast, need ML, assist or lead!");
        return false;
    end

    -- Check if there's anything to share
    if (not self:available()) then
        GL:warning("Nothing to broadcast, import StackedRoll data first!");
        return false;
    end

    self.broadcastInProgress = true;
    GL.Events:fire("GL.STACKEDROLL_BROADCAST_STARTED");

    local Broadcast = function ()
        GL:message("Broadcasting StackedRoll data...");

        local Label = GL.Interface:getItem(GL.StackedRoll, "Label.BroadcastProgress");

        if (Label) then
            Label:SetText("Broadcasting...");
        end

        GL.CommMessage.new(
            CommActions.broadcastStackedRollData,
            {
                importString = self:export(false),
                uuid = DB:get("StackedRoll.MetaData.uuid", nil),
                updatedAt = DB:get("StackedRoll.MetaData.updatedAt", nil),
            },
            "GROUP"
        ):send(function ()
            GL:success("StackedRoll broadcast finished");
            self.broadcastInProgress = false;
            GL.Events:fire("GL.STACKEDROLL_BROADCAST_ENDED");

            Label = GL.Interface:getItem(GL.StackedRoll, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText("Broadcast finished!");
            end

            -- Make sure to broadcast the loot priorities as well
            GL.LootPriority:broadcast();
        end, function (sent, total)
            Label = GL.Interface:getItem(GL.StackedRoll, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText(string.format("Sent %s of %s bytes", sent, total));
            end
        end);
    end

    -- We're about to send a lot of data which will put strain on CTL
    -- Make sure we're out of combat before doing so!
    if (UnitAffectingCombat("player")) then
        GL:message("You are currently in combat, delaying StackedRoll broadcast");

        GL.Events:register("StackedRollOutOfCombatListener", "PLAYER_REGEN_ENABLED", function ()
            GL.Events:unregister("StackedRollOutOfCombatListener");
            Broadcast();
        end);
    else
        Broadcast();
    end

    return true;
end

--- Process an incoming stacked roll broadcast
---
---@param CommMessage CommMessage
function StackedRoll:receiveBroadcast(CommMessage)
    GL:debug("StackedRoll:receiveBroadcast");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == GL.User.name) then
        GL:debug("StackedRoll:receiveBroadcast received by self, skip");
        return true;
    end

    local importString = CommMessage.content.importString or '';
    local importUuid = CommMessage.content.uuid or GL:uuid();
    local updatedAt = CommMessage.content.uuid or GL:uuid();
    local importBroadcast = (function ()
        if (not GL:empty(importString)) then
            GL:warning("Attempting to process incoming StackedRoll data from " .. CommMessage.Sender.name);
            local result = self:import(importString, false, importUuid);
            if (result) then
                GL.Interface.StackedRoll.Overview:refreshTable();
            end
            return result;
        end

        GL:warning("Couldn't process StackedRoll data received from " .. CommMessage.Sender.name);
        return false;
    end);

    local Dialog = {
        question = string.format(GL.Interface.Dialogs.PopupDialog.STACKEDROLL_RECEIVE_BROADCAST_CONFIRMATION.question,
                CommMessage.Sender.name
            ),
        OnYes = importBroadcast,
    };

    GL.Interface.Dialogs.PopupDialog:open(Dialog);
end

--- Request StackedRoll data from the person in charge (ML or Leader)
---
---@return void
function StackedRoll:requestData()
    GL:debug("StackedRoll:requestData");

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
        CommActions.requestStackedRollData,
        {
            updatedAt = DB:get('StackedRoll.MetaData.updatedAt', 0),
            uuid = DB:get('StackedRoll.MetaData.uuid', ''),
        },
        "WHISPER",
        playerToRequestFrom
    ):send();

    self.requestingData = false;
end

--- Reply to a player's StackedRoll data request
---
---@param CommMessage CommMessage
---@return void
function StackedRoll:replyToDataRequest(CommMessage)
    GL:debug("StackedRoll:replyToDataRequest");

    -- I don't have any data, leave me alone!
    if (not self:available()) then
        return;
    end

    -- We're not in a group (anymore), no need to help this person out
    if (not GL.User.isInGroup) then
        return;
    end

    -- Nice try, but we don't allow auto-sharing
    if (not GL.Settings:get("StackedRoll.automaticallyShareData")) then
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

    local uuid = CommMessage.content.uuid or '';
    local lastUpdate = CommMessage.content.updatedAt or 0;
    -- Your data is up to date, leave me alone!
    if (not GL:empty(uuid)
        and uuid == DB:get('StackedRoll.MetaData.uuid', '')
        and lastUpdate >= DB:get('StackedRoll.MetaData.updatedAt', 0)
    ) then
        return;
    end

    -- Looks like you need my data, here it is!
    GL.CommMessage.new(
        CommActions.broadcastStackedRollData,
        {
            importString = self:export(),
            uuid = DB:get('StackedRoll.MetaData.uuid', ''),
        },
        "WHISPER",
        CommMessage.Sender.name
    ):send();
end

--- Process an incoming stacked roll update
---
---@param playerName string
---@param points number
---@param aliases table
---@param delete boolean
function StackedRoll:broadcastUpdate(playerName, points, aliases, delete)
    GL:debug("StackedRoll:broadcastUpdate");

    if (self.broadcastInProgress) then
        GL:error("Broadcast still in progress");
        return false;
    end

    if (not GL.User.isInGroup) then
        GL:warning("No one to broadcast to, you're not in a group!");
        return false;
    end

    if (not self:userIsAllowedToBroadcast()) then
        GL:warning("Insufficient permissions to broadcast, need ML, assist or lead!");
        return false;
    end

    GL:message("Broadcasting StackedRoll update...");

    GL.CommMessage.new(
        CommActions.broadcastStackedRollUpdate,
        {
            playerName = playerName,
            points = points or nil,
            aliases = aliases or nil,
            delete = delete or false,
            uuid = DB:get("StackedRoll.MetaData.uuid", ""),
        },
        "GROUP"
    ):send();

    return true;
end

--- Process an incoming stacked roll update
---
---@param CommMessage CommMessage
function StackedRoll:receiveUpdate(CommMessage)
    GL:debug("StackedRoll:receiveUpdate");

    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.name == GL.User.name) then
        GL:debug("StackedRoll:receiveUpdate received by self, skip");
        return true;
    end

    local uuid = DB:get("StackedRoll.MetaData.uuid", '');

    local importUuid = CommMessage.content.uuid or GL:uuid();
    local playerName = CommMessage.content.playerName or '';
    local aliases = CommMessage.content.aliases or nil;
    local points = CommMessage.content.points or nil;
    local delete = CommMessage.content.delete or false;
    
    local importBroadcast = (function ()
        if (aliases) then
            self:setAliases(playerName, aliases);
        end

        if (points) then
            self:setPoints(playerName, points);
        end

        if (delete) then
            self:deletePoints(playerName);
        end

        GL.Interface.StackedRoll.Overview:refreshTable();
    end);

    GL:debug(importUuid, uuid);
    --- We only update if we have the same source data.
    if (importUuid == uuid) then
        importBroadcast();
    end
end

--- Check whether the current user is allowed to broadcast StackedRoll data
---
---@return boolean
function StackedRoll:userIsAllowedToBroadcast()
    return GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist);
end


GL:debug("StackedRoll.lua");