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
    raidIndex = nil,
    isInParty = false,
    isInGroup = false,
    Dkp = {},
    raidsAttended = 0,
};

local User = App.User;

-- Initialize the user's more "static" details that
-- shouldn't be able to change during playtime
function User:_init()
    self.name, self.realm = UnitName("player");
    self.id = UnitGUID("player");
    User:refresh();

    -- Fire App.bootstrap every time an addon is loaded
    self.eventFrame = CreateFrame("FRAME");
    self.eventFrame:RegisterEvent("PARTY_LOOT_METHOD_CHANGED");
    self.eventFrame:RegisterEvent("GROUP_ROSTER_UPDATE");
    self.eventFrame:SetScript("OnEvent", self.lootMethodChanged);
end

-- Refresh the User's details after the group
-- composition or loot method changes
function User:lootMethodChanged(_, event)
    User:refresh();
end

-- Initialize the user's details, keep in
-- mind that these might change during playtime
function User:refresh()
    local charactersTableEntry = App.DB.Characters[self.name] or {};

    self.level = UnitLevel("player");
    self.zone = GetRealZoneText();

    self.Guild = {};
    self.Guild.name, self.Guild.rank, self.Guild.index = GetGuildInfo("player");
    self.isOfficer = CanEditOfficerNote();
    self.isMasterLooter = 0 == select(2, GetLootMethod());
    self.isInRaid = IsInRaid();
    self.raidIndex = nil;

    if (self.isInRaid) then
        for index = 1, MAX_RAID_MEMBERS do
            local name, _, _, _, _, _, _, _, _, _, isMasterLooter = GetRaidRosterInfo(raidIndex);

            if (name == self.name) then
                self.raidIndex = index;
                self.isMasterLooter = isMasterLooter;
                break;
            end
        end
    end

    self.isInParty = IsInGroup() and not self.isInRaid;
    self.isInGroup = self.isInRaid or self.isInParty;

    if (self.isInGroup) then
        self.GroupMembers = User:groupMembers();
    else
        self.groupMembers = {};
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
    for index = 1, MAX_RAID_MEMBERS do
        local name, rank, subgroup, level, class, fileName, _, _, _, role, isML = GetRaidRosterInfo(index);

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

App:debug("User.lua");