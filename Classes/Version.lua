local _, App = ...;

App.Version = App.Version or {};

local Utils = App.Utils;
local Version = App.Version;
local CommActions = App.Data.Constants.Comm.Actions;

Version.current = App.version;
Version.latest = App.version;
Version.releases = {};
Version.isOutOfDate = false;

Version.GroupMembers = {};

-- Add a given version string to our knowledgebase
-- check whether it's newer than anything else we've seen
-- check whether we need to update our own addon
function Version:addRelease(versionString)
    Utils:debug("Version:addRelease");

    if (type(versionString) ~= "string"
            or not string.match(versionString, "%d+%.%d+%.%d+")
    ) then
        Utils:warning("Invalid version string provided in Version:addRelease");
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
    Utils:debug("Version:checkIfNewerRelease");

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
    Utils:debug("Version:validateAndSplit");

    if (not type(versionString) == "string") then
        Utils:warning("Invalid version string provided in Version:validateAndSplit");
        return false;
    end

    local versionParts = Utils:strSplit(versionString, ".");

    if (not versionParts[1]) then
        Utils:warning("Version string split failed");
        return false;
    end

    return true, versionParts[1], versionParts[2] or "0", versionParts[3] or "0";
end

-- Check if the versionstring passed first is older than the one passed second
function Version:leftIsOlderThanRight(left, right)
    Utils:debug("Version:leftIsOlderThanRight");

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
    Utils:debug("Version:leftIsNewerThanOrEqualToRight");

    return not self:leftIsOlderThanRight(left, right);
end

-- Inspect to see if the current group members have the addon and check whether it's up-to-date
function Version:inspectGroup()
    Utils:debug("Version:inspectGroup");

    if (not App.User.isInGroup) then
        return Utils:error("You're not in a group");
    end

    Utils:message("Checking group member addon versions...");

    self.GroupMembers = {}; -- Reset the self.GroupMembers object
    local numberOfGroupMembers = 0;

    -- Loop through all members of the group (party or raid)
    for _, Player in pairs(App.User:groupMembers()) do
        if (Player.online) then
            -- No need to request our own version
            if (Player.name ~= App.User.name) then
                self.GroupMembers[Player.name] = "-";
                numberOfGroupMembers = numberOfGroupMembers + 1;
            end
        end
    end

    local CommMessage = App.CommMessage.new(
        CommActions.requestAppVersion,
        nil,
        "RAID"
    ):send();

    -- Even if we're still missing an answer from some of the group members
    -- we still want to make sure our inspection end after a set amount of time
    App.Ace:ScheduleTimer(function ()
        self:finishInspectGroup(CommMessage);
    end, 5);
end

-- Inspect the raid group to see who has the addon and who doesn't and who needs to update it
function Version:finishInspectGroup(CommMessage)
    Utils:debug("Version:finishInspectGroup");

    for _, response in pairs(CommMessage.Responses) do
        local senderName = response.Sender.name;
        local versionString = response.content;

        if (self.GroupMembers[senderName]) then
            self.GroupMembers[senderName] = versionString;
            self:addRelease(versionString);
        end
    end

    local upToDate, outdated, noResponse = {}, {}, {};
    for player, version in pairs (self.GroupMembers) do
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
        Utils:error(string.format("Your addon (v%s) is out of date, v%s is out", self.current, self.latest));
    else
        Utils:success(string.format("Your addon (v%s) is up-to-date", self.current));
    end

    -- List all player that are up-to-date
    if (#upToDate >= 1) then
        Utils:message("The following players are up-to-date:");
        Utils:success(table.concat(upToDate, ", "));
    end

    -- List all player that didn't respond and most likely don't have the addon
    if (#noResponse >= 1) then
        Utils:message("The following players did not respond:");
        Utils:error(table.concat(noResponse, ", "));
    end

    -- List all player that have an out-of-date addon
    if (#outdated >= 1) then
        Utils:message("The following players need to update:");
        Utils:error(table.concat(outdated, ", "));
    end
end

Version:addRelease(Version.current);
Utils:debug("Version.lua");