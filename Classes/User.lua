local _, GL = ...;

GL.User = {
    initialized = false,
    groupSetupChangedTimer = false,
    groupSetupChangedAt = 0,
    groupMemberNamesCachedAt = -1,
    GroupMemberNames = {},

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

    -- Raid specific
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

    self.name, self.realm = UnitName("player");
    self.id = UnitGUID("player");
    User:refresh();

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
        local name, rank, _, _, _, _,
        _, _, _, role, isMasterLooter, combatRole = GetRaidRosterInfo(index);

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
            tinsert(Roster, {
                name = name,
                rank = rank,
                subgroup = subgroup,
                level = level,
                class = class,
                fileName = fileName,
                zone = zone,
                online = online,
                isDead = isDead,
                role = role,
                isML = isML,
                index = index,
            });
        end
    end

    return Roster;
end

-- Return the names of everyone in your party/raid
function User:groupMemberNames()
    GL:debug("User:groupMemberNames");

    -- The group names didn't change so there's no need to fetch them all again
    if (self.groupMemberNamesCachedAt >= self.groupSetupChangedAt) then
        return self.GroupMemberNames;
    end

    self.GroupMemberNames = {};
    -- Fetch the name of everyone currently in the raid/party
    for _, Player in pairs(self:groupMembers()) do
        tinsert(self.GroupMemberNames, string.lower(Player.name));
    end

    self.groupMemberNamesCachedAt = GetServerTime();
    return self.GroupMemberNames;
end

GL:debug("User.lua");