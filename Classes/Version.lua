local L = Gargul_L;

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
};

---@type Version
local Version = GL.Version;

---@type Data
local CommActions = GL.Data.Constants.Comm.Actions;

--[[ CONSTANTS ]]
local THIRTY_MINUTES = 1800;

---@return nil
function Version:_init()
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
                L["|c00%sGargul is now updated to |c00%sv%s"],
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

    -- 25 seconds after logging in we will check if Gargul is up to date
    -- If it is, we'll check periodically (once every 30 minutes) if it is
    -- On top of that we also check on every ready check event
    GL:after(25, nil, function ()
        if (self.isOutOfDate) then
            return;
        end

        self:checkForUpdate();

        GL:interval(THIRTY_MINUTES, "VersionUpdateCheckTimer", function (timer)
            if (self.isOutOfDate) then
                GL:cancelTimer(timer);
                return;
            end

            self:checkForUpdate();
        end);
    end);

    self._initialized = true;
end

---@test /dump _G.Gargul.Version:getInterface();
function Version:getInterface()
    return _G.select(4, _G.GetBuildInfo());
end

--- Check with GROUP and GUILD members whether we need to update our add-ons or not
---
--- We check GROUP first, wait 15 seconds for responses, then check GUILD* if no one had a newer version yet
--- * GUILD checking will only occur when the player is not in combat
---
---@param byReadyCheck boolean
---@return nil
function Version:checkForUpdate(byReadyCheck)
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
        GL.CommMessage.new{
            action = CommActions.checkForUpdate,
            content = self.latest ~= self.current and self.latest or nil,
            channel = "GROUP",
            acceptsResponse = true,
        }:send();
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

        GL.CommMessage.new{
            action = CommActions.checkForUpdate,
            channel = "GUILD",
            acceptsResponse = true,
        }:send();

        GL.Ace:ScheduleTimer(function ()
            self.checkingForUpdate = false;
        end, 15);
    end, 15);
end

---@param Message CommMessage
---@return nil
function Version:replyToUpdateCheck(Message)
    if (Message.Sender.isSelf) then
        return;
    end

    -- We don't handle too many of these messages
    local serverTime = GetServerTime();
    if (serverTime - self.lastUpdateCheckReplyAt < 20) then
        return;
    end

    self.lastUpdateCheckReplyAt = serverTime;

    local senderVersionToCheckAgainst = Message.content or Message.version;
    -- Only send a response if the latest known version of the sender differs from ours
    if (senderVersionToCheckAgainst ~= Version.latest) then
        -- Only include the latest known version if it differs from ours
        -- otherwise the comm message's version will be the exact same
        Message:respond(Version.current ~= Version.latest and Version.latest or nil);
    end
end

--- Add a given version string to our knowledgebase
--- check whether it's newer than anything else we've seen
--- check whether we need to update our own addon
---
---@param versionString string
---@param quietly boolean
---@return nil
function Version:addRelease(versionString, quietly)
    if (type(versionString) ~= "string"
        or not string.match(versionString, "%d+%.%d+%.%d+")
    ) then
        if (not quietly) then
            GL:warning(L["Invalid version string provided in Version:addRelease"]);
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
---@return nil
function Version:checkIfNewerRelease(versionString)
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
---@return nil
function Version:notBackwardsCompatibleNotice()
    local serverTime = GetServerTime();

    if (not self.lastNotBackwardsCompatibleNotice) then
        self.lastNotBackwardsCompatibleNotice = serverTime;
        GL:error(L["Gargul is out of date and won't work until you update!"]);
    end
end

---@return nil
function Version:notifyOfLatestVersion()
    if (self.lastNotBackwardsCompatibleNotice > 0) then -- The user is already chewed out by the incompatibility notifier
        return;
    end

    -- Only show the update alert once per session
    if (self.lastUpdateNotice > 0) then
        return;
    end

    self.lastUpdateNotice = GetServerTime();

    local notify = function ()
        GL:warning((L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"]):format(self.latest));

        -- Only show if the user didn't update for at least two trivial or one minor/major version
        if (self.versionDifference < 2) then
            return;
        end

        if (not GL.Settings:get("showUpdateAlert")) then
            return;
        end

        GL.Interface.Alerts:fire("GargulNotification", {
            message = ("|c00BE3333%s|r"):format(L["Update Gargul!"]),
        });
    end

    -- Make sure to not annoy Sjniekel when in combat
    GL:afterCombatDo(function ()
        notify();
    end);
end

--- Validate the version string and return all parts (major/minor/trivial) individually
---
---@param versionString string
---@return any
function Version:validateAndSplit(versionString)
    if (type(versionString) ~= "string"
        or GL:empty(versionString)
    ) then
        return false;
    end

    local versionParts = GL:explode(versionString, ".");

    if (not versionParts[1]) then
        GL:debug("Version string split failed");
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
--- of the version check or its results, but both sender and receiver(s)
--- will receive warnings/errors in case their addon version is outdated
---
---@return nil
function Version:inspectQuietly()
    if (self.isOutOfDate
        or not GL.User.isInGroup
    ) then
        return;
    end

    GL.CommMessage.new{
        action = CommActions.requestAppVersion,
        channel = "GROUP",
        acceptsResponse = true,
    }:send();
end

Version:addRelease(Version.current);
