local L = Gargul_L;

---@type GL
local _, GL = ...;

---@class BoostedRolls
GL.BoostedRolls = {
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
local BoostedRolls = GL.BoostedRolls; ---@type BoostedRolls

---@return boolean
function BoostedRolls:_init()
    if (self._initialized) then
        return false;
    end

    --- Register listener for whisper command.
    GL.Events:register("BoostedRollsWhisperListener", "CHAT_MSG_WHISPER", function (event, message, sender)
        if (GL.Settings:get("BoostedRolls.enableWhisperCommand", true)) then
            self:handleWhisperCommand(event, message, sender);
        end
    end);

    GL.Events:register("BoostedRollsUserJoinedGroupListener", "GL.USER_JOINED_NEW_GROUP", function () self:requestData(); end);

    -- Make sure BoostedRoll changes are only broadcasted once every 3 seconds
    GL.Events:register("BoostedRollsUpdateQueuedListener", "GL.BOOSTED_ROLLS_UPDATE_QUEUED", function ()
        GL.Interface.BoostedRolls.Overview:refreshTable();
        GL.Ace:CancelTimer(self.QueuedUpdateBroadcastTimer);

        self.QueuedUpdateBroadcastTimer = GL.Ace:ScheduleTimer(function ()
            self:broadcastQueuedUpdates();
        end, 3);
    end);

    self:materializeData();

    self._initialized = true;
    return true;
end

---@param player string
---@return string
function BoostedRolls:playerGUID(player, realm)
    return strlower(GL:addRealm(player, realm));
end

---@return string
function BoostedRolls:myGUID()
    return strlower(GL.User.fqn);
end

--- Get the normalized player name (or alias parent if available)
---
---@param playerName string
---@return string
function BoostedRolls:normalizedName(playerName)
    local normalizedName = strlower(GL:addRealm(playerName));

    --- Follow alias table if present
    return GL.DB:get("BoostedRolls.Aliases." .. normalizedName, normalizedName);
end

--- Check whether we trust the given player (currently used to auto-accept incoming broadcasts)
---
---@param playerName string
---@return boolean
function BoostedRolls:playerIsTrusted(playerName)
    if (not playerName) then
        return false;
    end

    local trustedPlayerCSV = GL.Settings:get("BoostedRolls.automaticallyAcceptDataFrom", "");
    local TrustedPlayers = GL:explode(trustedPlayerCSV, ",");
    for _, player in pairs(TrustedPlayers) do
        if (GL:iEquals(player, GL:nameFormat(playerName))) then
            return true;
        end
    end

    return false;
end

--- Mark a given player as "trusted"
---
---@param playerName string
---@return void
function BoostedRolls:markPlayerAsTrusted(playerName)
    playerName = strtrim(playerName);

    if (GL:empty(playerName)
        or self:playerIsTrusted(playerName)
    ) then
        return;
    end

    local trustedPlayerCSV = GL.Settings:get("BoostedRolls.automaticallyAcceptDataFrom", "");
    local TrustedPlayers = GL:explode(trustedPlayerCSV, ",");

    tinsert(TrustedPlayers, playerName);
    GL.Settings:set("BoostedRolls.automaticallyAcceptDataFrom", table.concat(TrustedPlayers, ","));
end

--- Remove a player from the list of "trusted" players
---
---@param playerName string
---@return void
function BoostedRolls:removePlayerFromTrusted(playerName)
    playerName = strtrim(playerName);

    -- No point removing the player if he's not trusted in the first place
    if (GL:empty(playerName)
        or not self:playerIsTrusted(playerName)
    ) then
        return;
    end

    local trustedPlayerCSV = GL.Settings:get("BoostedRolls.automaticallyAcceptDataFrom", "");
    local TrustedPlayers = GL:explode(trustedPlayerCSV, ",");
    local NewTrustedPlayers = {};
    local nameFormatted = GL:nameFormat(playerName);
    local fqn = GL:addRealm(playerName);

    for _, trustedPlayer in pairs(TrustedPlayers) do
        if (not GL:iEquals(trustedPlayer, nameFormatted)
            and not GL:iEquals(trustedPlayer, fqn)
        ) then
            tinsert(NewTrustedPlayers, trustedPlayer);
        end
    end

    GL.Settings:set("BoostedRolls.automaticallyAcceptDataFrom", table.concat(NewTrustedPlayers, ","));
end

--- Check whether boosted rolls are enabled
---
---@return boolean
function BoostedRolls:enabled()
    return GL.Settings:get("BoostedRolls.enabled", false);
end

--- Check whether there are boosted rolls available
---
---@return boolean
function BoostedRolls:available()
    return GL:higherThanZero(DB:get("BoostedRolls.MetaData.importedAt", 0));
end

--- Draw either the importer or overview
--- based on the current boosted roll data
---
---@return void
function BoostedRolls:draw()
    -- Show the boosted rolls overview instead
    GL.Interface.BoostedRolls.Overview:draw();
end

--- Checks and handles whisper commands if enabled.
---
---@param _ string
---@param message string
---@param sender string
---@return void
function BoostedRolls:handleWhisperCommand(_, message, sender)
    local validPrefixDetected = false;
    for _, prefix in pairs(GL:explode(L["!bonus|!rb|!br"], "|") or {}) do
        if (GL:strStartsWith(message, prefix)) then
            validPrefixDetected = true;
            break;
        end
    end

    if (not validPrefixDetected) then
        return;
    end

    local args = GL:explode(message, " ");

    -- See if name is given.
    if (#args > 1) then
        local name = self:normalizedName(args[2]);
        local points = self:getPoints(name);
        local low = self:minBoostedRoll(points);
        local high = self:maxBoostedRoll(points);
        local ext = "";
        if (not self:hasPoints(name)) then
            ext = " " .. L.CHAT["(default)"];
        end
        GL:sendChatMessage(
            (L.CHAT["Player %s's %s roll is /rnd %d-%d%s"]):format(GL:capitalize(name), GL.Settings:get("BoostedRolls.identifier", "BR"), low, high, ext),
            "WHISPER", nil, sender
        );
        return;
    end

    local name = GL:nameFormat(sender);
    name = self:normalizedName(name);

    local points = self:getPoints(name);
    local low = self:minBoostedRoll(points);
    local high = self:maxBoostedRoll(points);
    local ext = "";
    if (not self:hasPoints(name)) then
        ext = " " .. L.CHAT["(default)"];
    end
    GL:sendChatMessage(
        (L.CHAT["Your %s roll is /rnd %d-%d%s"]):format(GL.Settings:get("BoostedRolls.identifier", "BR"), low, high, ext),
        "WHISPER", nil, sender
    );
end

--- Materialize the boosted roll data to make it more accessible during runtime
---
---@return void
function BoostedRolls:materializeData()
    local Aliases = {}; -- Direct access to aliases
    local DetailsByPlayerName = {}; -- Details including aliases by player name

    --- Create entries from points data
    for name, points in pairs(DB:get("BoostedRolls.Points", {})) do
        name = self:playerGUID(name);
        points = self:toPoints(points or 0);

        if (type(name) == "string"
            and not GL:empty(name)
            and not DetailsByPlayerName[name]
        ) then
            GL:tableSet(DetailsByPlayerName, name .. ".Aliases", {});
            DetailsByPlayerName[name].points = points;
            DetailsByPlayerName[name].class = "";
        end
    end

    --- Add aliases
    for alias, main in pairs(DB:get("BoostedRolls.Aliases", {})) do
        alias = self:playerGUID(alias or "");
        main = self:playerGUID(main or "");

        if (type(alias) == "string" and type(main) == "string"
            and not GL:empty(alias) and not GL:empty(main)
        ) then
            if (DetailsByPlayerName[main] and not DetailsByPlayerName[alias]) then
                tinsert(DetailsByPlayerName[main].Aliases, alias);
            end
        end
    end

    self.MaterializedData.Aliases = Aliases;
    self.MaterializedData.DetailsByPlayerName = DetailsByPlayerName;
end

--- Format a boosted roll.
---
---@param points any
---@return number if valid, else nil
function BoostedRolls:toPoints(points)
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
function BoostedRolls:rollPoints(points)
    return math.min(GL.Settings:get("BoostedRolls.reserveThreshold", 0), points);
end;

--- Calculate reserve from points.
---
---@param points number
---@return number
function BoostedRolls:reserve(points)
    return math.max(0, points - GL.Settings:get("BoostedRolls.reserveThreshold", 0));
end;

--- Calculate max roll from points.
---
---@param points number
---@return number
function BoostedRolls:maxBoostedRoll(points)
    return math.max(1, math.min(GL.Settings:get("BoostedRolls.reserveThreshold", 0), points));
end;

--- Calculate min roll from points.
---
---@param points number
---@return number
function BoostedRolls:minBoostedRoll(points)
    local Systems = GL.Data.Constants.BoostedRollSystems;
    local system = GL.Settings:get("BoostedRolls.system", Systems.INCREASED_BOTH);

    -- Fixed will result in player with 140 points rolling /rnd 140-140
    if (system == Systems.FIXED) then
        return math.max(1, math.min(GL.Settings:get("BoostedRolls.reserveThreshold", 0), points));
    end

    -- Increased max will result in player with 140 points rolling /rnd 1-140
    if (system == Systems.INCREASED_MAX) then
        return 1;
    end

    -- /rnd 1-100 yields 100 possible numbers
    -- /rnd 60-160 (60 points) yields 101 possible numbers which would give an undesired disadvantage,
    -- hence the -99 which effectively turns it into /rnd 61-160 instead
    return math.max(1, self:maxBoostedRoll(points) - 99);
end;

--- Detect boosted rolls.
---
---@param low number
---@param high number
---@return boolean
function BoostedRolls:isBoostedRoll(low, high)
    local threshold = GL.Settings:get("BoostedRolls.reserveThreshold", 0);

    --- Check maximum.
    if (self:maxBoostedRoll(high) ~= high or high > threshold) then
        return false;
    end

    --- Check minimum.
    return self:minBoostedRoll(high) == low;
end;

--- Clear all boosted roll data
---
---@return void
function BoostedRolls:clear()
    DB.BoostedRolls = {
        Points = {},
        Aliases = {},
        MetaData = {},
    };
    self.MaterializedData = {
        Aliases = {},
        DetailsByPlayerName = {},
    };

    GL.Interface.BoostedRolls.Overview:close();
    self:draw();
end

--- Set aliases
---
---@param name string
---@param aliases table
---@param dontBroadcast boolean
---@return void
function BoostedRolls:setAliases(name, aliases, dontBroadcast)
    if (type(name) ~= "string") then
        return;
    end

    dontBroadcast = GL:toboolean(dontBroadcast);

    local mainGUID = self:playerGUID(name);
    local _, mainRealm = GL:stripRealm(mainGUID);

    if (self.MaterializedData.DetailsByPlayerName[mainGUID]) then
        --- Reset old aliases
        for _, alias in pairs(self.MaterializedData.DetailsByPlayerName[mainGUID].Aliases) do
            DB.BoostedRolls.Aliases[alias] = nil;
        end

        --- Set new aliases
        local cleanAliases = {};
        for _, alias in pairs(aliases) do
            alias = self:playerGUID(alias, mainRealm);

            --- Check that this alias does not yet exist, otherwise skip.
            if (not DB.BoostedRolls.Aliases[alias]) then
                DB.BoostedRolls.Aliases[alias] = mainGUID;
                tinsert(cleanAliases, alias);
            end
        end
        self.MaterializedData.DetailsByPlayerName[mainGUID].Aliases = cleanAliases;
        DB:set("BoostedRolls.MetaData.updatedAt", GetServerTime());

        if (not dontBroadcast
            and GL.Settings:get("BoostedRolls.automaticallyShareData")
        ) then
            self:broadcastUpdate(mainGUID, nil, aliases);
        end
    end
end

--- Determine if a player is present in the table
---
---@param name string
---@return boolean
function BoostedRolls:hasPoints(name)
    if (type(name) ~= "string") then
        return false;
    end

    local normalizedName = self:normalizedName(name);

    if (self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        return true;
    end

    return false;
end

--- Get a player's points
---
---@param name string
---@return void
function BoostedRolls:getPoints(name)
    local default = GL.Settings:get("BoostedRolls.defaultPoints", 0);

    if (type(name) ~= "string") then
        return default;
    end

    local normalizedName = self:normalizedName(name);

    return GL:tableGet(self.MaterializedData or {}, "DetailsByPlayerName." .. normalizedName .. ".points", default);
end

--- Set a player's points
---
---@param name string
---@param points number
---@param dontBroadcast boolean
---@return void
function BoostedRolls:setPoints(name, points, dontBroadcast)
    if (type(name) ~= "string") then
        return;
    end

    dontBroadcast = GL:toboolean(dontBroadcast);

    local normalizedName = self:normalizedName(name);

    if (not self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        return;
    end

    points = min(GL.Settings:get("BoostedRolls.maxmimumPoints", points), points);
    self.MaterializedData.DetailsByPlayerName[normalizedName].points = points;
    DB:set("BoostedRolls.Points." .. normalizedName, points);
    DB:set("BoostedRolls.MetaData.updatedAt", GetServerTime());

    if (not dontBroadcast
        and GL.Settings:get("BoostedRolls.automaticallyShareData")
    ) then
        self:broadcastUpdate(normalizedName, points);
    end

    return points;
end

--- Delete an entry
---
---@param name string
---@return void
function BoostedRolls:deletePoints(name, dontBroadcast)
    if (type(name) ~= "string") then
        return;
    end

    dontBroadcast = GL:toboolean(dontBroadcast);

    local normalizedName = self:normalizedName(name);

    if (not self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        return;
    end

    for _, alias in pairs(self.MaterializedData.DetailsByPlayerName[normalizedName].Aliases or {}) do
        DB.BoostedRolls.Aliases[alias] = nil;
    end

    self.MaterializedData.DetailsByPlayerName[normalizedName] = nil;
    DB.BoostedRolls.Points[normalizedName] = nil;
    DB:set("BoostedRolls.MetaData.updatedAt", GetServerTime());

    if (not dontBroadcast
        and GL.Settings:get("BoostedRolls.automaticallyShareData")
    ) then
        self:broadcastUpdate(normalizedName, nil, nil, true);
    end
end

--- Modify a player's points
---
---@param name string
---@param points number
---@return void
function BoostedRolls:modifyPoints(name, change)
    if (type(name) ~= "string") then
        return;
    end

    local normalizedName = self:normalizedName(name);
    if (not self.MaterializedData.DetailsByPlayerName[normalizedName]) then
        return;
    end

    local points = self.MaterializedData.DetailsByPlayerName[normalizedName].points;
    points = self:toPoints(points + change);

    self:queueUpdate(normalizedName, points);
end

--- Import a CSV or TSV data string
---
---@param data string
---@param openOverview boolean (optional, default: false)
---@param MetaData table (optional, default: auto generate new metadata)
---@return boolean
function BoostedRolls:import(data, openOverview, MetaData)
    -- Make sure all the required properties are available and of the correct type
    if (GL:empty(data)) then
        GL.Interface:get("BoostedRolls.Importer", "Label.StatusMessage"):SetText(L["Invalid data supplied"]);
        return false;
    end

    local Points = {};
    local Aliases = {};

    -- If the user copy/pasted from google sheets there will be addition quotes that need to be removed
    data = data:gsub("\"", "");

    for line in data:gmatch("[^\n]+") do
        --- We expect lines to be in the form,
        --- where the individual variables are comma, tab, or spaces separated:
        --- PlayerName,Points,Alias1,Alias2...
        --- e.g., "Foobar,240,Barfoo"
        --- This facilitates imports from CSV, TSV files or pasting from Google Docs
        local Segments = GL:separateValues(line);
        
        local playerName = tostring(Segments[1]);
        playerName = self:playerGUID(playerName);
        local points = self:toPoints(Segments[2]);

        if (not GL:empty(playerName) and not Points[playerName] and points) then
            Points[playerName] = points;

            --- Import further segments as aliases (alts)
            for i = 3, #Segments do
                local alias = tostring(Segments[i]);
                alias = self:playerGUID(alias);
                if (not GL:empty(alias) and not Points[alias] and not Aliases[alias]) then
                    Aliases[alias] = playerName;
                end
            end
        end
    end

    if (GL:empty(Points)) then
        local errorMessage = L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"];
        GL.Interface:get("BoostedRolls.Importer", "Label.StatusMessage"):SetText(errorMessage);

        return false;
    end

    local MetaData = MetaData or {};

    DB.BoostedRolls = {
        Points = Points,
        Aliases = Aliases,
        MetaData = {
            importedAt = MetaData.importedAt or GetServerTime(),
            updatedAt = MetaData.updatedAt or GetServerTime(),
            uuid = MetaData.uuid or GL:uuid(),
        },
    };

    GL:success(L["Import of boosted roll data successful"]);
    GL.Events:fire("GL.BOOSTEDROLLS_IMPORTED");

    self:materializeData();
    GL.Interface.BoostedRolls.Importer:close();

    if (openOverview) then
        self:draw();

        -- The user is in charge of automatically sharing TMB data
        -- after importing it, let's get crackin'!
        if (GL.Settings:get("BoostedRolls.automaticallyShareData")
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
function BoostedRolls:addMissingRaiders()
    local default = GL.Settings:get("BoostedRolls.defaultPoints", 0);

    -- Not in a group, add the current player
    if (not GL.User.isInGroup) then
        if (not self:hasPoints(BoostedRolls:myGUID())) then
            DB:set("BoostedRolls.Points." .. BoostedRolls:myGUID(), default);
        end

    -- Go through everyone in the raid
    else
        for _, Player in pairs(GL.User:groupMembers()) do
            local normalizedName = self:normalizedName(Player.fqn);
            if (not self:hasPoints(normalizedName)) then
                DB:set("BoostedRolls.Points." .. normalizedName, default);
            end
        end
    end

    DB:set("BoostedRolls.MetaData.importedAt", GetServerTime());
    DB:set("BoostedRolls.MetaData.updatedAt", GetServerTime());

    if (not DB:get("BoostedRolls.MetaData.uuid")) then
        DB:set("BoostedRolls.MetaData.uuid", GL:uuid());
    end

    self:materializeData();
end

--- Export to CSV
---
---@param displayFrame boolean
---@return void
function BoostedRolls:export(displayFrame)
    -- Calculate max aliases to output a CSV compliant string
    local numAliases = 0;
    for _, Entry in pairs(self.MaterializedData.DetailsByPlayerName) do
        numAliases = math.max(numAliases, #Entry.Aliases);
    end
    
    -- Create CSV string
    local csv = "";
    for name, Entry in pairs(self.MaterializedData.DetailsByPlayerName) do
        csv = ("%s%s,%s"):format(csv, name, Entry.points);
        
        -- Always add maximum aliases
        for i = 1,numAliases do
            csv = csv .. ",";
            if (Entry.Aliases[i]) then
                csv = ("%s%s"):format(csv, Entry.Aliases[i]);
            end
        end
        csv = csv .. "\n";
    end

    if (displayFrame) then
        GL:frameMessage(csv);
    end

    return csv;
end

--- Broadcast our boosted roll data to the raid or group
---
---@return boolean
function BoostedRolls:broadcast()
    if (self.broadcastInProgress) then
        GL:error(L["Broadcast still in progress"]);
        return false;
    end

    -- No need to broadcast anything when not in a group, this also doesn't warrent a warning
    if (not GL.User.isInGroup) then
        return false;
    end

    if (not self:userIsAllowedToBroadcast()) then
        GL:warning(L["You need to be the master looter or have an assist / lead role!"]);
        return false;
    end

    -- Check if there's anything to share
    if (not self:available()) then
        GL:warning(L["Nothing to broadcast, import Boosted Rolls data first!"]);
        return false;
    end

    -- No need to keep any queued updates, we're doing a full broadcast now anyways
    self.QueuedUpdates = {};

    self.broadcastInProgress = true;
    GL.Events:fire("GL.BOOSTEDROLLS_BROADCAST_STARTED");

    local Broadcast = function ()
        GL:message(L["Broadcasting..."]);

        local Label = GL.Interface:get(GL.BoostedRolls, "Label.BroadcastProgress");

        if (Label) then
            Label:SetText(L["Broadcasting..."]);
        end

        GL.CommMessage.new{
            action = CommActions.broadcastBoostedRollsData,
            content = {
                importString = self:export(false),
                MetaData = DB:get("BoostedRolls.MetaData", {}),
            },
            channel = "GROUP",
        }:send(function ()
            GL:success(L["Broadcast finished!"]);

            --- Broadcast updates before we reset the flag.
            self:broadcastQueuedUpdates();

            self.broadcastInProgress = false;
            GL.Events:fire("GL.BOOSTEDROLLS_BROADCAST_ENDED");

            Label = GL.Interface:get(GL.BoostedRolls, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText(L["Broadcast finished!"]);
            end

            -- Make sure to broadcast the loot priorities as well
            GL.LootPriority:broadcast();
        end, function (sent, total)
            Label = GL.Interface:get(GL.BoostedRolls, "Label.BroadcastProgress");
            if (Label) then
                Label:SetText(string.format(L["Sent %s of %s bytes"], sent, total));
            end
        end);
    end

    -- We're about to send a lot of data which will put strain on CTL
    -- Make sure we're out of combat before doing so!
    GL:afterCombatDo(function ()
        Broadcast();
    end, function ()
        GL:notice(L["You are currently in combat, delaying broadcast"]);
    end);

    return true;
end

--- Process an incoming boosted roll broadcast
---
---@param CommMessage CommMessage
function BoostedRolls:receiveBroadcast(CommMessage)
    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.isSelf) then
        return true;
    end

    local importString = CommMessage.content.importString or '';
    local MetaData = CommMessage.content.MetaData or {};
    local importBroadcast = (function ()
        if (GL:empty(importString)) then
            GL:warning((L["Attempting to process incoming BoostedRolls data from %s"]):format(CommMessage.Sender.name));

            return false;
        end

        GL:warning((L["Couldn't process BoostedRolls data received from %s"]):format(CommMessage.Sender.name) .. CommMessage.Sender.name);

        local result = self:import(importString, false, MetaData);
        if (result) then
            GL.Interface.BoostedRolls.Overview:refreshTable();
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
    local uuid = DB:get("BoostedRolls.MetaData.uuid", '');
    local updatedAt = DB:get("BoostedRolls.MetaData.updatedAt", 0);
    local question;
    if (MetaData.uuid and uuid == MetaData.uuid) then -- This is an update to our dataset
        question = (L[ [[
Are you sure you want to update your existing boosted rolls with data from %s?

Your latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s.]]]):format(
            GL:nameFormat{ name = CommMessage.Sender.name, colorize = true, },
            date(L["%Y-%m-%d %H:%M"], updatedAt),
            date(L["%Y-%m-%d %H:%M"], MetaData.updatedAt or 0)
        );
    elseif (not GL:empty(uuid)) then -- This is a different dataset, not an update
        question = (L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"]):format(CommMessage.Sender.name);
    else -- We don't have a dataset yet, import!
        return importBroadcast();
    end

    local Dialog = {
        question = question,
        OnYes = importBroadcast,
        sender = CommMessage.Sender.name,
    };

    GL.Interface.Dialogs.IncomingBoostedRollDataDialog:open(Dialog);
end

--- Request BoostedRolls data from the person in charge (ML or Leader)
---
---@return void
function BoostedRolls:requestData()
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
        action = CommActions.requestBoostedRollsData,
        content = DB:get('BoostedRolls.MetaData', {}),
        channel = "WHISPER",
        recipient = playerToRequestFrom,
    }:send();

    self.requestingData = false;
end

--- Reply to a player's BoostedRolls data request
---
---@param CommMessage CommMessage
---@return void
function BoostedRolls:replyToDataRequest(CommMessage)
    -- I don't have boosted rolls enabled, leave me alone!
    if (not self:enabled()) then
        return;
    end

    -- I don't have any data, leave me alone!
    if (not self:available()) then
        return;
    end

    -- We're not in a group (anymore), no need to help this person out
    if (not GL.User.isInGroup) then
        return;
    end

    -- Nice try, but we don't allow auto-sharing
    if (not GL.Settings:get("BoostedRolls.automaticallyShareData")) then
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
        and uuid == DB:get('BoostedRolls.MetaData.uuid', '')
        and lastUpdate >= DB:get('BoostedRolls.MetaData.updatedAt', 0)
    ) then
        return;
    end

    -- Looks like you need my data, here it is!
    GL.CommMessage.new{
        action = CommActions.broadcastBoostedRollsData,
        content = {
            importString = self:export(false),
            MetaData = DB:get("BoostedRolls.MetaData", {}),
        },
        channel = "WHISPER",
        recipient = CommMessage.senderFqn,
    }:send();
end

--- Add points to a give user's balance
---
---@param playerName string
---@param points number
---
---@return number
function BoostedRolls:addPoints(playerName, points)
    playerName = self:normalizedName(playerName);
    local currentPoints = self:getPoints(playerName) or 0;

    return self:queueUpdate(playerName, currentPoints + points);
end

--- Subtract points from a give user's balance
---
---@param playerName string
---@param points number
function BoostedRolls:subtractPoints(playerName, points)
    if (points <= 0) then
        return;
    end

    playerName = self:normalizedName(playerName);
    local currentPoints = self:getPoints(playerName) or 0;

    self:queueUpdate(playerName, currentPoints - points);
end

--- Queue an update until broadcast is finished
---
---@param playerName string
---@param points number
---@param aliases table
---@param delete boolean
function BoostedRolls:queueUpdate(playerName, points, aliases, delete)
    local dontBroadcast = true;
    if (aliases) then
        self:setAliases(playerName, aliases, dontBroadcast);
    end

    if (points) then
        self:setPoints(playerName, points, dontBroadcast);
    end

    if (delete) then
        self:deletePoints(playerName, dontBroadcast);
    end

    local Update = {
        playerName = playerName,
        points = points or nil,
        aliases = aliases or nil,
        delete = delete or false,
    };

    tinsert(self.QueuedUpdates, Update);

    -- Fire an event to let the application know that an update was queued
    GL.Events:fire("GL.BOOSTED_ROLLS_UPDATE_QUEUED");

    -- Return the BR points after sanitation
    return self:getPoints(playerName);
end

--- Send out the queued updates
---
---@return void
function BoostedRolls:broadcastQueuedUpdates()
    if (not GL.User.isInGroup) then
        return false;
    end

    if (not self:userIsAllowedToBroadcast()) then
        GL:warning(L["You need to be the master looter or have an assist / lead role!"]);
        return false;
    end

    GL.CommMessage.new{
        action = CommActions.broadcastBoostedRollsMutation,
        content = {
            updates = self.QueuedUpdates,
            uuid = DB:get("BoostedRolls.MetaData.uuid", ""),
        },
        channel = "GROUP",
    }:send();

    self.QueuedUpdates = {};
end

--- Process an incoming boosted roll update
---
---@param playerName string
---@param points number
---@param aliases table
---@param delete boolean
function BoostedRolls:broadcastUpdate(playerName, points, aliases, delete)
    if (not self:userIsAllowedToBroadcast()) then
        GL:warning(L["You need to be the master looter or have an assist / lead role!"]);
        return false;
    end

    if (self.broadcastInProgress) then
        GL:error(L["Broadcast still in progress"]);
        self:queueUpdate(playerName, points, aliases, delete);
        return false;
    end

    GL:message(L["Broadcasting..."]);

    GL.CommMessage.new{
        action = CommActions.broadcastBoostedRollsMutation,
        content = {
            updates = {
                playerName = playerName,
                points = points or nil,
                aliases = aliases or nil,
                delete = delete or false,
            },
            uuid = DB:get("BoostedRolls.MetaData.uuid", ""),
        },
        channel = "GROUP",
    }:send();

    return true;
end

--- Process an incoming boosted roll update
---
---@param CommMessage CommMessage
function BoostedRolls:receiveUpdate(CommMessage)
    -- No need to update our tables if we broadcasted them ourselves
    if (CommMessage.Sender.isSelf) then
        GL.Interface.BoostedRolls.Overview:refreshTable();
        return true;
    end

    local uuid = DB:get("BoostedRolls.MetaData.uuid", '');

    local importUuid = CommMessage.content.uuid or GL:uuid();
    local updates = CommMessage.content.updates or {};

    local importBroadcast = (function (update)
        if (type(update) ~= "table") then
            return;
        end

        local playerName = update.playerName or '';
        local aliases = update.aliases or nil;
        local points = update.points or nil;
        local delete = update.delete or false;
        local dontBroadcast = true;

        if (aliases) then
            self:setAliases(playerName, aliases, dontBroadcast);
        end

        if (points) then
            self:setPoints(playerName, points, dontBroadcast);
        end

        if (delete) then
            self:deletePoints(playerName, dontBroadcast);
        end

        GL.Interface.BoostedRolls.Overview:refreshTable();
    end);

    --- We only update if we have the same source data.
    if (importUuid == uuid) then
        for _, update in pairs(updates) do
            importBroadcast(update);
        end
    end
end

--- Check whether the current user is allowed to broadcast BoostedRolls data
---
---@return boolean
function BoostedRolls:userIsAllowedToBroadcast()
    return GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist);
end
