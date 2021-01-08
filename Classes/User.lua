local _, App = ...;

App.User = {
    initialized = false,
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
            local name = GetRaidRosterInfo(index);

            if (name == self.name) then
                self.raidIndex = index;
                break;
            end
        end

        self.isMasterLooter = self.raidIndex == select(3, GetLootMethod());
    end

    self.isInParty = IsInGroup() and not self.isInRaid;
    self.isInGroup = self.isInRaid or self.isInParty;

    self.Dkp = {
        amount = charactersTableEntry.dkp or 0,
        gained = charactersTableEntry.gained or 0,
        spent = charactersTableEntry.spent or 0,
    };
    self.raidsAttended = charactersTableEntry.raids or 0;
end

App:debug("User.lua");