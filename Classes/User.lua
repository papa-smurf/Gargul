local _, GL = ...;

GL.User = {
    _initialized = false,
    groupSetupChangedTimer = false,
    groupSetupChangedAt = 0,
    groupMemberNamesCachedAt = -1,
    GroupMemberNames = {},
    playerClassByName = {},

    id = 0,
    name = "",
    level = 1,
    zone = "",
    Guild = {},
    isOfficer = false,
    isMasterLooter = false,
    isInRaid = false,
    isInParty = false,
    isInGroup = false,
    raidsAttended = 0,
    Dkp = {},

    -- Group specific
    raidIndex = nil,
    hasAssist = false,
    isLead = false,
    role = "",
    combatRole = "",
};

local User = GL.User;

-- Initialize the user's more "static" details that
-- shouldn't be able to change during playtime
function User:_init()
    GL:debug("User:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    self.name = UnitName("player");
    self.realm = GetRealmName();

    -- fqn stands for Fully Qualified Name
    self.fqn = string.format("%s-%s", self.name, self.realm);
    self.id = UnitGUID("player");

    GL.Events:register("UserGroupRosterUpdatedListener", "GROUP_ROSTER_UPDATE", function () self:groupSetupChanged(); end);
end

-- Refresh the User's details after the group
-- composition or loot method changes
function User:groupSetupChanged()
    GL:debug("User:groupSetupChanged");

    self.groupSetupChangedAt = GetServerTime();

    -- The timer throttle is necessary to prevent performance
    -- issues when an entire raid comes online after a break for example
    if (User.groupSetupChangedTimer) then
        return;
    end

    User.groupSetupChangedTimer = GL.Ace:ScheduleTimer(function ()
        User:refresh();
        User.groupSetupChangedTimer = false;
    end, 1);
end

-- Refresh the user's details
function User:refresh()
    GL:debug("User:refresh");

    local userWasMasterLooter = self.isMasterLooter;
    local userWasInGroup = self.isInGroup;
    local userWasInRaid = self.isInRaid;

    -- Make sure the window doens't popup after /reload
    if (userWasMasterLooter == nil) then
        userWasMasterLooter = true;
    end

    self.level = UnitLevel("player");
    self.zone = GetRealZoneText();

    self.Guild = {};
    self.Guild.name, self.Guild.rank, self.Guild.index = GetGuildInfo("player");
    self.isOfficer = CanEditOfficerNote();
    self.isInRaid = IsInRaid();
    self.isInParty = IsInGroup() and not self.isInRaid;
    self.isInGroup = self.isInRaid or self.isInParty;
    self.hasAssist = false;
    self.isLead = false;
    self.raidIndex = nil;

    if (not self.isInGroup) then
        return;
    end

    -- Check if the current user is master looting
    -- And check the user's roles in the group
    for index = 1, _G.MAX_RAID_MEMBERS do
        local name, rank, _, _, class, _,
        _, _, _, role, isMasterLooter, combatRole = GetRaidRosterInfo(index);

        GL.Player:cacheClass(name, class); -- We cache player classes wherever we can

        if (name == self.name) then
            self.role = role;
            self.raidIndex = index;
            self.isLead = rank == 2;
            self.hasAssist = rank >= 1;
            self.combatRole = combatRole;
            self.isMasterLooter = isMasterLooter;

            break;
        end
    end

    -- The user joined a group
    if (not userWasInGroup
        and self.isInGroup
    ) then
        GL.Events:fire("GL.USER_JOINED_GROUP");

        -- Fire a seperate event for raid/party joined
        if (self.isInRaid) then
            GL.Events:fire("GL.USER_JOINED_RAID");
        else
            GL.Events:fire("GL.USER_JOINED_PARTY");
        end
    end

    -- The user left a group
    if (userWasInGroup
        and not self.isInGroup
    ) then
        GL.Events:fire("GL.USER_LEFT_GROUP");

        -- Fire a seperate event for raid/party joined
        if (userWasInRaid) then
            GL.Events:fire("GL.USER_LEFT_RAID");
        else
            GL.Events:fire("GL.USER_LEFT_PARTY");
        end
    end

    -- The user obtained the roll of master looter, fire the appropriate event
    if (not userWasMasterLooter
        and self.isMasterLooter
    ) then
        GL.Events:fire("GL.USER_OBTAINED_MASTER_LOOTER");
    end

    -- The user lost the roll of master looter, fire the appropriate event
    if (userWasMasterLooter
        and not self.isMasterLooter
    ) then
        GL.Events:fire("GL.USER_LOST_MASTER_LOOTER");
    end
end

-- Get all of the people who are
-- in the same party/raid as the current user
function User:groupMembers()
    GL:debug("User:groupMembers");

    local Roster = {};

    if (not GL.User.isInGroup) then
        return Roster;
    end

    local maximumNumberOfGroupMembers = _G.MEMBERS_PER_RAID_GROUP;
    if (GL.User.isInRaid) then
        maximumNumberOfGroupMembers = _G.MAX_RAID_MEMBERS;
    end

    for index = 1, maximumNumberOfGroupMembers do
        local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML = GetRaidRosterInfo(index);

        if (name) then
            GL.Player:cacheClass(name, class); -- We cache player classes wherever we can

            tinsert(Roster, {
                name = name,
                rank = rank,
                subgroup = subgroup,
                level = level,
                class = string.lower(class),
                fileName = fileName,
                zone = zone,
                online = online,
                isDead = isDead,
                role = role,
                isML = isML,
                isLeader = rank == 2,
                hasAssist = rank > 0,
                index = index,
            });
        end
    end

    return Roster;
end

--- Check whether a given unit is in your raid/party
---
---@param unit string
---@return boolean
function User:unitIsInYourGroup(unit)
    if (self.isInRaid) then
        return toboolean(UnitInRaid(unit));
    end

    return toboolean(UnitInParty(unit));
end

-- Return the names of everyone in your party/raid
function User:groupMemberNames()
    GL:debug("User:groupMemberNames");

    -- The -1 is used as an extra buffer to make sure we don't miss out on any names...
    -- Race conditions are a pain in the butt and I've seen them happen with this event
    local timestamp = GetServerTime() - 1;

    -- The group names didn't change so there's no need to fetch them all again
    if (self.groupMemberNamesCachedAt > self.groupSetupChangedAt) then
        return self.GroupMemberNames;
    end

    self.groupMemberNamesCachedAt = timestamp;

    local GroupMemberNames = {};
    -- Fetch the name of everyone currently in the raid/party
    for _, Player in pairs(self:groupMembers()) do
        tinsert(GroupMemberNames, string.lower(GL:stripRealm(Player.name)));
    end

    self.GroupMemberNames = GroupMemberNames;

    return self.GroupMemberNames;
end

GL:debug("User.lua");