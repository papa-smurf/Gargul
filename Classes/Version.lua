local _, GL = ...;

GL.Version = GL.Version or {
    RecurringCheckTimer = nil,
};

local Version = GL.Version;
local CommActions = GL.Data.Constants.Comm.Actions;

Version._initialized = false;
Version.current = GL.version;
Version.latest = GL.version;
Version.releases = {};
Version.isOutOfDate = false;
Version.firstBoot = false;

Version.GroupMembers = {};

---@return void
function Version:_init()
    GL:debug("Version:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- The user has never used the add-on before (or cleared all SavedVariables)
    if (not GL.DB.LoadDetails.lastLoadedOn) then
        GL.firstBoot = true;
    end

    -- This is the first time the user loads this version
    if (not GL.DB.LoadDetails[self.current]) then
        self.firstBoot = true;

        if (not GL.firstBoot) then
            print(string.format(
                "|cff%sGargul|r is now updated to |cff%sv%s|r",
                GL.Data.Constants.addonHexColor,
                GL.Data.Constants.addonHexColor,
                self.current
            ))
        end
    end

    local now = GetServerTime();
    GL.DB.LoadDetails.lastLoadedOn = now;
    GL.DB.LoadDetails[self.current] = now;

    self._initialized = true;
end

--- Add a given version string to our knowledgebase
--- check whether it's newer than anything else we've seen
--- check whether we need to update our own addon
---
---@param versionString string
---@return void
function Version:addRelease(versionString)
    GL:debug("Version:addRelease");

    if (type(versionString) ~= "string"
        or not string.match(versionString, "%d+%.%d+%.%d+")
    ) then
        GL:warning("Invalid version string provided in Version:addRelease");
        return;
    end

    -- No need to process a version string that we already know
    if (self.releases[versionString]) then
        return;
    end

    self.releases[versionString] = true;
    self:checkIfNewerRelease(versionString);
end

--- Check if the given versionString is newer than our current "latest" version
--- If so, mark our addon as "out of date"
---
---@param versionString string
---@return void
function Version:checkIfNewerRelease(versionString)
    GL:debug("Version:checkIfNewerRelease");

    if (not self:leftIsOlderThanRight(self.latest, versionString)) then
        return;
    end

    self.latest = versionString;

    if (self.latest ~= self.current) then
        self.isOutOfDate = true;
    end
end

--- Validate the version string and return all parts (major/minor/trivial) individually
---
---@param versionString string
---@return any
function Version:validateAndSplit(versionString)
    GL:debug("Version:validateAndSplit");

    if (not type(versionString) == "string") then
        GL:warning("Invalid version string provided in Version:validateAndSplit");
        return false;
    end

    local versionParts = GL:strSplit(versionString, ".");

    if (not versionParts[1]) then
        GL:warning("Version string split failed");
        return false;
    end

    return true, tonumber(versionParts[1]), tonumber(versionParts[2]) or "0", tonumber(versionParts[3]) or "0";
end

--- Check if the versionstring passed first is older than the one passed second
---
---@param left string
---@param right string
---@return boolean
function Version:leftIsOlderThanRight(left, right)
    GL:debug("Version:leftIsOlderThanRight");

    local leftSuccess, leftMajor, leftMinor, leftTrivial = self:validateAndSplit(left);
    local rightSuccess, rightMajor, rightMinor, rightTrivial = self:validateAndSplit(right);

    if (not leftSuccess or not rightSuccess) then
        return;
    end

    if (rightMajor < leftMajor) then
        return false; -- Major of addon is higher
    elseif (rightMajor > leftMajor) then
        return true; -- Major of versionstring is higher
    end

    if (rightMinor < leftMinor) then
        return false; -- Minor of addon is higher
    elseif (rightMinor > leftMinor) then
        return true; -- Minor of versionstring is higher
    end

    if (rightTrivial < leftTrivial) then
        return false; -- Trivial of addon is higher
    elseif (rightTrivial > leftTrivial) then
        return true; -- Trivial of versionstring is higher
    end

    return false;
end

--- Check if our current app version is higher than the given one
---
---@param left string
---@param right string
---@return boolean
function Version:leftIsNewerThanOrEqualToRight(left, right)
    GL:debug("Version:leftIsNewerThanOrEqualToRight");

    return not self:leftIsOlderThanRight(left, right);
end

--- Inspect quietly, meaning there will be no visual feedback
--- of the version check or its results, but both send and receiver(s)
--- will receive warnings/errors in case their addon version is outdated
---
---@return void
function Version:inspectQuietly()
    if (not GL.User.isInGroup) then
        return;
    end

    GL.CommMessage.new(
        CommActions.requestAppVersion,
        nil,
        "GROUP"
    ):send();
end

--- Inspect to see if the current group members have the addon and check whether it's up-to-date
---
---@return void
function Version:inspectGroup()
    GL:debug("Version:inspectGroup");

    if (not GL.User.isInGroup) then
        return GL:error("You're not in a group");
    end

    GL:message("Checking group member addon versions...");

    self.GroupMembers = {}; -- Reset the self.GroupMembers object
    local numberOfActiveGroupMembers = 0;

    -- Loop through all members of the group (party or raid)
    for _, Player in pairs(GL.User:groupMembers()) do
        if (Player.online) then
            -- No need to request our own version
            if (Player.name ~= GL.User.name) then
                self.GroupMembers[GL:stripRealm(Player.name)] = "-";
                numberOfActiveGroupMembers = numberOfActiveGroupMembers + 1;
            end
        end
    end

    local CommMessage = GL.CommMessage.new(
        CommActions.requestAppVersion,
        nil,
        "GROUP"
    ):send();

    -- Report back as soon as all the answers are in
    GL:debug("Schedule new Version.RecurringCheckTimer");
    self.RecurringCheckTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        GL:debug("Run Version.RecurringCheckTimer");

        -- We received an answer from everyone
        if (GL:count(CommMessage.Responses or {}) >= numberOfActiveGroupMembers) then
            self:clearTimers();
            self:finishInspectGroup(CommMessage);
        end
    end, .2);

    -- Even if we're still missing an answer from some of the group members
    -- we still want to make sure our inspection end after a set amount of time
    self.MaximumCheckTimer = GL.Ace:ScheduleTimer(function ()
        self:clearTimers();
        self:finishInspectGroup(CommMessage);
    end, 5);
end

--- Clear any outstanding timers
---
---@return void
function Version:clearTimers()
    if (self.RecurringCheckTimer) then
        GL:debug("Cancel Version.RecurringCheckTimer");

        GL.Ace:CancelTimer(self.RecurringCheckTimer);
        self.RecurringCheckTimer = nil;
    end

    if (self.MaximumCheckTimer) then
        GL.Ace:CancelTimer(self.MaximumCheckTimer);
        self.MaximumCheckTimer = nil;
    end
end

--- Check which players are using the addon and send the results to a given callback
---
---@param callback function
---@return void
function Version:playersUsingAddon(callback)
    GL:debug("Version:inspectGroup");

    if (not GL.User.isInGroup
        or not callback
        or type(callback) ~= "function"
    ) then
        callback({});
        return;
    end

    local GroupMembers = {};
    local numberOfActiveGroupMembers = 0;

    -- Loop through all members of the group (party or raid)
    for _, Player in pairs(GL.User:groupMembers()) do
        if (Player.online) then
            -- No need to request our own version
            if (Player.name ~= GL.User.name) then
                GroupMembers[GL:stripRealm(Player.name)] = false;
                numberOfActiveGroupMembers = numberOfActiveGroupMembers + 1;
            end
        end
    end

    local CommMessage = GL.CommMessage.new(
        CommActions.requestAppVersion,
        nil,
        "GROUP"
    ):send();

    local function handleResponses(GroupMembers, Responses, callback)
        for _, Response in pairs(Responses) do
            local senderName = Response.Sender.name;

            if (GroupMembers[senderName] ~= nil) then
                GroupMembers[senderName] = true;
            end
        end

        callback(GroupMembers);
    end

    -- Report back as soon as all the answers are in
    if (not self.RecurringCheckTimer) then
        GL:debug("Schedule new Version.RecurringCheckTimer");
        self.RecurringCheckTimer = GL.Ace:ScheduleRepeatingTimer(function ()
            GL:debug("Run Version.RecurringCheckTimer");

            -- We received an answer from everyone
            if (GL:count(CommMessage.Responses or {}) >= numberOfActiveGroupMembers) then
                self:clearTimers();
                handleResponses(GroupMembers, CommMessage.Responses, callback);
                return;
            end
        end, .2);
    end

    -- Even if we're still missing an answer from some of the group members
    -- we still want to make sure our inspection end after a set amount of time
    self.MaximumCheckTimer = GL.Ace:ScheduleTimer(function ()
        self:clearTimers();
        handleResponses(GroupMembers, CommMessage.Responses, callback);
        return;
    end, 5);
end

--- Inspect the raid group to see who has the addon and who doesn't and who needs to update it
---
---@param CommMessage CommMessage
---@return void
function Version:finishInspectGroup(CommMessage)
    GL:debug("Version:finishInspectGroup");

    for _, response in pairs(CommMessage.Responses) do
        local senderName = response.Sender.name;
        local versionString = response.content;

        if (self.GroupMembers[senderName]) then
            self.GroupMembers[senderName] = versionString;
            self:addRelease(versionString);
        end
    end

    local upToDate, outdated, noResponse = {}, {}, {};
    for player, version in pairs(self.GroupMembers) do
        if (version == "-") then
            tinsert(noResponse, player)
        elseif (self:leftIsOlderThanRight(version, self.latest)) then
            tinsert(outdated, player);
        else
            tinsert(upToDate, player);
        end
    end

    -- Start out with checking our own addon version
    if (self.isOutOfDate) then
        GL:error(string.format("Your addon (v%s) is out of date, v%s is out", self.current, self.latest));
    else
        GL:success(string.format("Your addon (v%s) is up-to-date", self.current));
    end

    -- List all player that are up-to-date
    if (#upToDate >= 1) then
        GL:message("The following players are up-to-date:");
        GL:success(table.concat(upToDate, ", "));
    end

    -- List all player that didn't respond and most likely don't have the addon
    if (#noResponse >= 1) then
        GL:message("The following players did not respond:");
        GL:error(table.concat(noResponse, ", "));
    end

    -- List all player that have an out-of-date addon
    if (#outdated >= 1) then
        GL:message("The following players need to update:");
        GL:error(table.concat(outdated, ", "));
    end
end

Version:addRelease(Version.current);
GL:debug("Version.lua");