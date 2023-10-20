local _, GL = ...;

---@class Version
GL.Version = GL.Version or {
    _initialized = false,

    checkingForUpdate = false,
    current = GL.version,
    latest = GL.version,
    lastUpdateCheckReplyAt = 0,
    releases = {},
    isOutOfDate = false,
    firstBoot = false,
    latestPriorVersionBooted = nil,
    lastNotBackwardsCompatibleNotice = 0,
    lastUpdateNotice = 0,
    versionDifference = 0,

    GroupMembers = {},
    RecurringCheckTimer = nil,
    UpdateCheckTimer = nil;
};

---@type Version
local Version = GL.Version;

---@type Data
local CommActions = GL.Data.Constants.Comm.Actions;

--[[ CONSTANTS ]]
local THIRTY_MINUTES = 1800;

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
            ));
        end
    end

    -- Check which version we last loaded before this one
    self.latestPriorVersionBooted = nil;
    for version in pairs(GL.DB.LoadDetails or {}) do
        local major = string.sub(version, 1, 1);
        major = tonumber(major);

        if (major) then
            if (not self.latestPriorVersionBooted or self:leftIsOlderThanRight(self.latestPriorVersionBooted, version)) then
                self.latestPriorVersionBooted = version;
            end
        end
    end

    local now = GetServerTime();
    GL.DB.LoadDetails.lastLoadedOn = now;
    GL.DB.LoadDetails[self.current] = GL.DB.LoadDetails[self.current] or now;

    --[[ CHECK FOR GARGUL UPDATES ]]

    -- 5 seconds after logging in we will check if Gargul is up to date
    -- If it is, we'll check periodically (once every 30 minutes) if it is
    -- On top of that we also check on every ready check event
    GL.Ace:ScheduleTimer(function ()
        if (self.isOutOfDate) then
            return;
        end

        self:checkForUpdate();

        self.UpdateCheckTimer = GL.Ace:ScheduleRepeatingTimer(function ()
            GL:debug("Run Version.UpdateCheckTimer");

            if (self.isOutOfDate) then
                GL:debug("Cancel Version.UpdateCheckTimer");

                GL.Ace:CancelTimer(self.UpdateCheckTimer);
                return;
            end

            self:checkForUpdate();
        end, THIRTY_MINUTES);
    end, 5);

    -- Check our version whenever there's a ready check
    GL.Events:register("VersionReadyCheck", "READY_CHECK", function ()
        if (self.isOutOfDate) then
            GL.Events:unregister("VersionReadyCheck");
            return;
        end

        self:checkForUpdate(true);
    end);

    self._initialized = true;
end

--- Check with GROUP and GUILD members whether we need to update our add-ons or not
---
--- We check GROUP first, wait 15 seconds for responses, then check GUILD* if no one had a newer version yet
--- * GUILD checking will only occur when the player is not in combat
---
---@param byReadyCheck boolean
---@return void
function Version:checkForUpdate(byReadyCheck)
    GL:debug("Version:checkForUpdate");

    if (self.checkingForUpdate -- We're already checking
        or self.isOutOfDate -- We already know we're out of date

        -- We're not in a group or guild and have nowhere to check
        or (not GL.User.isInGroup
            and not GL.User.Guild.name
        )
    ) then
        return;
    end

    self.checkingForUpdate = true;

    if (GL.User.isInGroup) then
        GL.CommMessage.new(
            CommActions.checkForUpdate,
            nil,
            "GROUP"
        ):send();
    end

    -- We're not in a guild, no need to check
    if (not GL.User.Guild.name) then
        return;
    end

    GL.Ace:ScheduleTimer(function ()
        if (self.isOutOfDate
            or UnitAffectingCombat("player") -- We don't check guild in combat, can't risk hiccups
            or byReadyCheck -- We don't check the guild after a ready check: we're about to FIGHT!
        ) then
            self.checkingForUpdate = false;

            return;
        end

        GL.CommMessage.new(
            CommActions.checkForUpdate,
            nil,
            "GUILD"
        ):send();

        GL.Ace:ScheduleTimer(function ()
            self.checkingForUpdate = false;
        end, 15);
    end, 15);
end

---@param Message CommMessage
---@return void
function Version:replyToUpdateCheck(Message)
    GL:debug("Version:replyToUpdateCheck");

    if (Message.Sender.isSelf) then
        return;
    end

    -- We don't handle too many of these messages
    local serverTime = GetServerTime();
    if (serverTime - self.lastUpdateCheckReplyAt < 20) then
        return;
    end

    self.lastUpdateCheckReplyAt = serverTime;

    if (Message.version
        and not Version:leftIsNewerThanOrEqualToRight(Message.version, Version.latest)
    ) then
        Message:respond(Version.latest);
    end
end

--- Add a given version string to our knowledgebase
--- check whether it's newer than anything else we've seen
--- check whether we need to update our own addon
---
---@param versionString string
---@param quietly boolean
---@return void
function Version:addRelease(versionString, quietly)
    GL:debug("Version:addRelease");

    if (type(versionString) ~= "string"
        or not string.match(versionString, "%d+%.%d+%.%d+")
    ) then
        if (not quietly) then
            GL:warning("Invalid version string provided in Version:addRelease");
        end

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

    local outDated, versionDifference = self:leftIsOlderThanRight(self.latest, versionString);
    if (not outDated) then
        return;
    end

    self.latest = versionString;

    if (self.latest ~= self.current) then
        versionDifference = tonumber(versionDifference);
        self.isOutOfDate = true;

        if (versionDifference and versionDifference > self.versionDifference) then
            self.versionDifference = versionDifference;
        end

        self:notifyOfLatestVersion();
    end
end

--- Gargul is out of date in a manner that makes it incompatible with new(er) versions
---
---@return void
function Version:notBackwardsCompatibleNotice()
    GL:debug("Version:notBackwardsCompatibleNotice");

    local serverTime = GetServerTime();

    if (serverTime - self.lastNotBackwardsCompatibleNotice >= 30) then
        self.lastNotBackwardsCompatibleNotice = serverTime;
        GL:error("Gargul is out of date and won't work properly until you update!");
    end
end

---@return void
function Version:notifyOfLatestVersion()
    GL:debug("Version:notifyOfLatestVersion");

    if (self.lastNotBackwardsCompatibleNotice > 0) then -- The user is already chewed out by the incompatibility notifier
        return;
    end

    -- Only show the update alert once per session
    if (self.lastUpdateNotice > 0) then
        return;
    end

    self.lastUpdateNotice = GetServerTime();

    local notify = function ()
        GL:error("Your version of |c00a79effGargul|r is outdated");
        GL:warning(("Version |c00a79effv%s|r is available on CurseForge and Wago"):format(self.latest));

        -- Only show if the user didn't update for at least two trivial or one minor/major version
        if (self.versionDifference < 2) then
            return;
        end

        if (not GL.Settings:get("showUpdateAlert")) then
            return;
        end

        GL.Interface.Alerts:fire("GargulNotification", {
            message = string.format("|c00BE3333Update Gargul!|r"),
        });
    end

    -- Make sure to not annoy Sjniekel when in combat
    if (UnitAffectingCombat("player")) then
        GL.Events:register("VersionOutOfCombatListener", "PLAYER_REGEN_ENABLED", function ()
            GL.Events:unregister("VersionOutOfCombatListener");
            notify();
        end);
    else
        notify();
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

    local versionParts = GL:explode(versionString, ".");

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
---@return boolean, number
---
--- /script DevTools_Dump({_G.Gargul.Version:leftIsOlderThanRight("5.3.0", "5.3.3")});
function Version:leftIsOlderThanRight(left, right)
    GL:debug("Version:leftIsOlderThanRight");

    local leftSuccess, leftMajor, leftMinor, leftTrivial = self:validateAndSplit(left);
    local rightSuccess, rightMajor, rightMinor, rightTrivial = self:validateAndSplit(right);

    if (not leftSuccess or not rightSuccess) then
        return;
    end

    if (rightMajor < leftMajor) then
        return false, (leftMajor - rightMajor) * 100; -- Major of addon is higher
    elseif (rightMajor > leftMajor) then
        return true, (rightMajor - leftMajor) * 100; -- Major of versionstring is higher
    end

    if (rightMinor < leftMinor) then
        return false, (leftMinor - rightMinor) * 10; -- Minor of addon is higher
    elseif (rightMinor > leftMinor) then
        return true, (rightMinor - leftMinor) * 10; -- Minor of versionstring is higher
    end

    if (rightTrivial < leftTrivial) then
        return false, leftTrivial - rightTrivial; -- Trivial of addon is higher
    elseif (rightTrivial > leftTrivial) then
        return true, rightTrivial - leftTrivial; -- Trivial of versionstring is higher
    end

    return false, 0;
end

--- Check if our current app version is higher than the given one
---
---@param left string
---@param right string
---@return boolean
function Version:leftIsNewerThanOrEqualToRight(left, right)
    GL:debug("Version:leftIsNewerThanOrEqualToRight");

    local older, versionDifference = self:leftIsOlderThanRight(left, right);
    local newerOrEqual = not older;

    return newerOrEqual, versionDifference;
end

--- Check if the given version string is an up-to-date version
---
---@param version string
---@return boolean
function Version:isUpToDate(version)
    return self:leftIsNewerThanOrEqualToRight(version, self.latest);
end

--- Inspect quietly, meaning there will be no visual feedback
--- of the version check or its results, but both send and receiver(s)
--- will receive warnings/errors in case their addon version is outdated
---
---@return void
function Version:inspectQuietly()
    if (self.isOutOfDate
        or not GL.User.isInGroup
    ) then
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
                self.GroupMembers[GL:disambiguateName(Player.fqn)] = "-";
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
        callback{};
        return;
    end

    local GroupMembers = {};
    local numberOfActiveGroupMembers = 0;

    -- Loop through all members of the group (party or raid)
    for _, Player in pairs(GL.User:groupMembers()) do
        if (Player.online) then
            -- No need to request our own version
            if (Player.id ~= GL.User.id) then
                GroupMembers[GL:disambiguateName(Player.fqn)] = false;
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