local _, GL = ...;

---@class User
GL.User = {
    _initialized = false,
    guildMembersCachedAt = 0,
    groupSetupChangedTimer = false,
    groupSetupChangedAt = 0,
    groupMemberNamesCachedAt = -1,
    GroupMemberNames = {},
    GuildMemberNames = {},
    GuildMembers = {},
    playerClassByName = {},

    id = UnitGUID("player"),
    name = UnitName("player"),
    level = 1,
    zone = "",
    Guild = {},
    isOfficer = false,
    isMasterLooter = false,
    isInRaid = IsInRaid(),
    isInParty = IsInGroup() and not IsInRaid(),
    isInGroup = IsInGroup(),

    -- Group specific
    raidIndex = nil,
    hasAssist = false,
    isLead = false,
    role = "",
    combatRole = "",
};

---@type User
local User = GL.User;

--- Initialize the user's more "static" details that
--- shouldn't be able to change during playtime
---@return void
function User:_init()
    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    -- Note: GetNormalizedRealmName is not available during boot (only have player login event)
    self.realm = GetRealmName():gsub("-", "");
    self.realm = self.realm:gsub("%s+", "");

    -- fqn stands for Fully Qualified Name
    self.fqn = GL:addRealm(self.name, self.realm);

    -- Keep track of when our group setup changed
    GL.Events:register("UserGroupRosterUpdatedListener", "GROUP_ROSTER_UPDATE", function () self:groupSetupChanged(); end);
end

---@return string
function User:bth()
    if (type(C_BattleNet) ~= "table" or not C_BattleNet.GetAccountInfoByGUID) then
        return "";
    end

    local bTag = GL:tableGet(C_BattleNet.GetAccountInfoByGUID(self.id) or {}, "battleTag", nil);
    if (not bTag or type(bTag) ~= "string" or GL:empty(bTag)) then
        return "";
    end

    local firtsHalf = strsub(bTag, 1, ceil(strlen(bTag) / 2));
    local secondHalf = strsub(bTag, ceil(strlen(bTag) / 2) * -1);

    return ("%s-%s"):format(GL:stringHash(bTag), GL:stringHash(secondHalf .. firtsHalf));
end

--- Refresh the User's details after the group
--- composition or loot method changes
---@return void
function User:groupSetupChanged()
    self.groupSetupChangedAt = GetServerTime();

    -- The timer throttle is necessary to prevent performance
    -- issues when an entire raid comes online after a break for example
    if (User.groupSetupChangedTimer) then
        return;
    end

    User.groupSetupChangedTimer = GL.Ace:ScheduleTimer(function ()
        User:refresh();
        User.groupSetupChangedTimer = false;
        GL.Events:fire("GL.GROUP_ROSTER_UPDATE_THROTTLED");
    end, 1);
end

--- Refresh the user's details
---@return void
function User:refresh()
    local userWasMasterLooter = self.isMasterLooter;
    local userWasLead = self.isLead;
    local userHadAssist = self.hasAssist;
    local userWasInGroup = self.isInGroup;
    local userWasInRaid = self.isInRaid;

    -- Make sure the window doesn't popup after /reload
    userWasMasterLooter = userWasMasterLooter ~= false;

    self.level = UnitLevel("player");
    self.zone = GetRealZoneText();

    self.Guild = {};
    self.Guild.name, self.Guild.rank, self.Guild.index = GetGuildInfo("player");
    self.isOfficer = C_GuildInfo.CanEditOfficerNote();
    self.isInGroup = IsInGroup();
    self.isInRaid = self.isInGroup and IsInRaid();
    self.isInParty = self.isInGroup and not self.isInRaid;
    self.hasAssist = false;
    self.isLead = false;
    self.isMasterLooter = false;
    self.raidIndex = nil;
    self.combatRole = nil;
    self.classFile = UnitClassBase("player");
    self.class = string.lower(self.classFile);
    self.localizedRace, self.race = UnitRace("player");
    self.race = string.lower(self.race);

    if (self.isInGroup) then
        -- Check if the current user is master looting
        -- And check the user's roles in the group
        for index = 1, _G.MAX_RAID_MEMBERS do
            local name, rank, _, _, _, classFile,
            _, _, _, role, isMasterLooter, combatRole = GetRaidRosterInfo(index);

            GL.Player:cacheClass(name, classFile); -- We cache player classes wherever we can

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

    -- The user joined a group
    if (not userWasInGroup
        and self.isInGroup
    ) then
        GL.Events:fire("GL.USER_JOINED_GROUP");
        GL.Events:fire("GL.USER_JOINED_NEW_GROUP");

        -- Fire a separate event for raid/party joined
        if (self.isInRaid) then
            GL.Events:fire("GL.USER_JOINED_RAID");
        else
            GL.Events:fire("GL.USER_JOINED_PARTY");
        end
    end

    -- Make sure to also fire an event upon conversion to raid
    if (userWasInGroup
        and not userWasInRaid
        and self.isInRaid
    ) then
        GL.Events:fire("GL.USER_JOINED_GROUP");
        GL.Events:fire("GL.USER_JOINED_RAID");
    end

    -- The user left a group
    if (userWasInGroup
        and not self.isInGroup
    ) then
        GL.Events:fire("GL.USER_LEFT_GROUP");

        -- Fire a separate event for raid/party joined
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

    -- The user obtained lead, fire the appropriate event
    if (not userWasLead
        and self.isLead
    ) then
        GL.Events:fire("GL.USER_OBTAINED_LEAD");
    end

    -- The user lost lead, fire the appropriate event
    if (userWasLead
        and not self.isLead
    ) then
        GL.Events:fire("GL.USER_LOST_LEAD");
    end

    -- The user obtained assist, fire the appropriate event
    if (not userHadAssist
        and self.hasAssist
    ) then
        GL.Events:fire("GL.USER_OBTAINED_ASSIST");
    end

    -- The user lost assist, fire the appropriate event
    if (userHadAssist
        and not self.hasAssist
    ) then
        GL.Events:fire("GL.USER_LOST_ASSIST");
    end
end

--- Get all of the people who are in the same guild as the current user
---
---@return table
function User:guildMembers()
    local Roster = {};

    if (GL:empty(self.Guild)) then
        return Roster;
    end

    -- We cache guild member results for 5 minutes
    if (GetServerTime() - self.guildMembersCachedAt <= 300) then
        return self.GuildMembers;
    end

    self.GuildMembers = {};
    self.GuildMemberNames = {};

    for index = 1, GetNumGuildMembers() do
        local name, rank, rankIndex, level, classDisplayName, zone, publicNote, officerNote, isOnline, status, classFile = GetGuildRosterInfo(index)

        if (name) then
            local fqn = string.lower(name);
            self.GuildMemberNames[fqn] = fqn;

            tinsert(Roster, {
                name = GL:stripRealm(fqn),
                fqn = fqn,
                rank = rank,
                rankIndex = rankIndex,
                level = level,
                classDisplayName = classDisplayName,
                zone = zone,
                publicNote = publicNote,
                officerNote = officerNote,
                isOnline = isOnline,
                status = status,
                classFile = string.lower(classFile),
            });
        end
    end

    self.GuildMembers = Roster;
    self.guildMembersCachedAt = GetServerTime();

    return Roster;
end

--- Check whether the given player is in our guild
---
---@param playerName string
---@return boolean
function User:playerIsGuildMember(playerName)
    self:guildMembers();
    self:guildMembers();

    if (not strfind(playerName, "-")) then
        playerName = string.format("%s-%s", playerName, GL.User.realm);
    end

    playerName = string.lower(playerName);
    return GL:toboolean(self.GuildMemberNames[playerName]);
end

--- Get all of the people who are
--- in the same party/raid as the current user
---@return table
function User:groupMembers()
    local Roster = {};

    if (GL.User.isInGroup) then
        local maximumNumberOfGroupMembers = _G.MEMBERS_PER_RAID_GROUP;
        if (GL.User.isInRaid) then
            maximumNumberOfGroupMembers = _G.MAX_RAID_MEMBERS;
        end

        for index = 1, maximumNumberOfGroupMembers do
            local name, rank, subgroup, level, _, classFile, zone, online, isDead, role, isML = GetRaidRosterInfo(index);

            if (name) then
                classFile = classFile or "PRIEST";
                GL.Player:cacheClass(name, classFile); -- We cache player classes wherever we can
                local realmLessName, realm = GL:stripRealm(name);
                realm = realm or self.realm;

                tinsert(Roster, {
                    name = realmLessName,
                    realm = realm,
                    fqn = GL:addRealm(name, realm),
                    rank = rank,
                    subgroup = subgroup,
                    level = level,
                    class = string.lower(classFile),
                    classFile = classFile,
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
    end

    if (not GL:empty(Roster)) then
        return Roster;
    end

    --- This is purely for add-on testing purposes
    return {
        {
            name = self.name,
            realm = self.realm,
            fqn = self.fqn,
            rank = 2,
            subgroup = 1,
            level = self.level,
            class = self.class,
            classFile = self.classFile,
            zone = "Development Land",
            online = true,
            isDead = false,
            role = "",
            isML = false,
            isLeader = true,
            hasAssist = false,
            index = 1,
        },
    };
end

--- Check if we have active (online) group members
---
---@return boolean
function User:hasActiveGroupMembers()
    local numberOfGroupMembers = 0;

    for index = 1, GL.User.isInRaid and _G.MAX_RAID_MEMBERS or _G.MEMBERS_PER_RAID_GROUP do
        if (numberOfGroupMembers >= 2) then
            return true;
        end

        local name, _, _, _, _, _, _, online = GetRaidRosterInfo(index);

        if (not name) then
            return false;
        end

        if (online) then
            numberOfGroupMembers = numberOfGroupMembers + 1;
        end
    end

    return false;
end

--- Check whether a given unit is in your raid/party
---
---@param unit string
---@return boolean
function User:unitInGroup(unit)
    -- We're clearly trying to test something, allow it
    if (not self.isInGroup) then
        return true;
    end

    return GL:toboolean(UnitInParty(GL:nameFormat(unit)));
end

--- Return the names of everyone in your party/raid
---@return table
function User:groupMemberNames(fqn)
    -- The -1 is used as an extra buffer to make sure we don't miss out on any names...
    -- Race conditions are a pain in the butt and I've seen them happen with this event
    local timestamp = GetServerTime() - 1;

    -- The group names changed
    if (self.groupMemberNamesCachedAt <= self.groupSetupChangedAt) then
        self.groupMemberNamesCachedAt = timestamp;

        local GroupMemberNames = {};
        -- Fetch the name of everyone currently in the raid/party
        for _, Player in pairs(self:groupMembers()) do
            tinsert(GroupMemberNames, Player.fqn);
        end

        self.GroupMemberNames = GroupMemberNames;
    end

    if (not GL:empty(self.GroupMemberNames)) then
        -- Remove realm tags if the FQN is not desired
        -- We build a new table here so that the original values are not affected
        if (not fqn) then
            local RealmlessNames = {};
            for _, name in pairs(self.GroupMemberNames) do
                name = GL:stripRealm(name);
                tinsert(RealmlessNames, name);
            end

            return RealmlessNames;
        end

        return self.GroupMemberNames;
    end

    return { self.name };
end

---@return boolean
function User:isDev()
    return GL:inTable({
        "54402906-2451533554",
        "4270976097-2384770663",
    }, self:bth());
end
