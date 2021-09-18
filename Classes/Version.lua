local _, GL = ...;

GL.Version = GL.Version or {};

local Version = GL.Version;
local CommActions = GL.Data.Constants.Comm.Actions;

Version.current = GL.version;
Version.latest = GL.version;
Version.releases = {};
Version.isOutOfDate = false;

Version.GroupMembers = {};

-- Add a given version string to our knowledgebase
-- check whether it's newer than anything else we've seen
-- check whether we need to update our own addon
function Version:addRelease(versionString)
    GL:debug("Version:addRelease");

    if (type(versionString) ~= "string"
            or not string.match(versionString, "%d+%.%d+%.%d+")
    ) then
        GL:warning("Invalid version string provided in Version:addRelease");
        return false;
    end

    -- No need to process a version string that we already know
    if (self.releases[versionString]) then
        return;
    end

    self.releases[versionString] = true;
    self:checkIfNewerRelease(versionString);
end

-- Check if the given versionString is newer than our current "latest" version
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

-- Validate the version string and return all parts (major/minor/trivial) individually
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

    return true, versionParts[1], versionParts[2] or "0", versionParts[3] or "0";
end

-- Check if the versionstring passed first is older than the one passed second
function Version:leftIsOlderThanRight(left, right)
    GL:debug("Version:leftIsOlderThanRight");

    local leftSuccess, leftMajor, leftMinor, leftTrivial = self:validateAndSplit(left);
    local rightSuccess, rightMajor, rightMinor, rightTrivial = self:validateAndSplit(right);

    if (not leftSuccess
            or not rightSuccess
    ) then
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

-- Check if our current app version is higher than the given one
function Version:leftIsNewerThanOrEqualToRight(left, right)
    GL:debug("Version:leftIsNewerThanOrEqualToRight");

    return not self:leftIsOlderThanRight(left, right);
end

-- Inspect to see if the current group members have the addon and check whether it's up-to-date
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
        "RAID"
    ):send();

    -- Report back as soon as all the answers are in
    self.recurringCheckTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        -- We received an answer from everyone
        if (GL:count(CommMessage.Responses or {}) >= numberOfActiveGroupMembers) then
            self:clearTimers();
            self:finishInspectGroup(CommMessage);
        end
    end, .2);

    -- Even if we're still missing an answer from some of the group members
    -- we still want to make sure our inspection end after a set amount of time
    self.maximumCheckTimer = GL.Ace:ScheduleTimer(function ()
        self:clearTimers();
        self:finishInspectGroup(CommMessage);
    end, 5);
end

--- Clear any outstanding timers
---
---@return void
function Version:clearTimers()
    if (self.recurringCheckTimer) then
        GL.Ace:CancelTimer(self.recurringCheckTimer);
        self.recurringCheckTimer = nil;
    end

    if (self.maximumCheckTimer) then
        GL.Ace:CancelTimer(self.maximumCheckTimer);
        self.maximumCheckTimer = nil;
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
        "RAID"
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
    self.recurringCheckTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        -- We received an answer from everyone
        if (GL:count(CommMessage.Responses or {}) >= numberOfActiveGroupMembers) then
            self:clearTimers();
            handleResponses(GroupMembers, CommMessage.Responses, callback);
            return;
        end
    end, .2);

    -- Even if we're still missing an answer from some of the group members
    -- we still want to make sure our inspection end after a set amount of time
    self.maximumCheckTimer = GL.Ace:ScheduleTimer(function ()
        self:clearTimers();
        handleResponses(GroupMembers, CommMessage.Responses, callback);
        return;
    end, 5);
end

-- Inspect the raid group to see who has the addon and who doesn't and who needs to update it
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