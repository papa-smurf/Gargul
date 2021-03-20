local _, App = ...;

App.User = {
    initialized = false,

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

local User = App.User;
local Utils = App.Utils;

-- Initialize the user's more "static" details that
-- shouldn't be able to change during playtime
function User:_init()
    Utils:debug("User:_init");

    self.name, self.realm = UnitName("player");
    self.id = UnitGUID("player");
    User:refresh();

    -- Fire App.bootstrap every time an addon is loaded
    self.eventFrame = CreateFrame("FRAME");
    self.eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
    self.eventFrame:SetScript("OnEvent", self.groupSetupChanged);
end

-- Refresh the User's details after the group
-- composition or loot method changes
function User:groupSetupChanged(_, event)
    User:refresh();
end

-- Refresh the user's details
function User:refresh()
    Utils:debug("User:refresh");

    local charactersTableEntry = App.DB.Characters[self.name] or {};

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

    -- Check if the current user is master looting
    if (self.isInRaid) then
        local nameOnIndex = "";

        if (self.raidIndex and self.raidIndex > 0) then
            local nameOnIndex = GetRaidRosterInfo(self.raidIndex);
        end

        if (nameOnIndex ~= self.name) then
            self.raidIndex = nil;

            for index = 1, MAX_RAID_MEMBERS do
                local name, rank, subgroup, _, _, _,
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
    else
        self.raidIndex = nil;
        self.isMasterLooter = 0 == select(2, GetLootMethod());
    end

    self.Dkp = {
        amount = charactersTableEntry.dkp or 0,
        gained = charactersTableEntry.gained or 0,
        spent = charactersTableEntry.spent or 0,
    };
    self.raidsAttended = charactersTableEntry.raids or 0;
end

-- Get all of the people who are
-- in the same party/raid as the current user
function User:groupMembers()
    local Roster = {};

    if (not App.User.isInGroup) then
        return Roster;
    end

    local maximumNumberOfGroupMembers = MEMBERS_PER_RAID_GROUP;
    if (App.User.isInRaid) then
        maximumNumberOfGroupMembers = MAX_RAID_MEMBERS;
    end

    for index = 1, maximumNumberOfGroupMembers do
        local name, rank, subgroup, level, class, fileName, zone, online, isDead, role, isML, combatRole = GetRaidRosterInfo(index);

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

Utils:debug("User.lua");