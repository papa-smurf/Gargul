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
    self.isMasterLooter = self.id == select(2, GetLootMethod());
    self.isInRaid = IsInRaid();
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