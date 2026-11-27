---@type GL
local _, GL = ...;

---@class LootCouncil
local LootCouncil = {
    _initialized = false,

    ---@type table|nil
    Session = nil,
};
GL.LootCouncil = LootCouncil; ---@type LootCouncil

local CommActions = GL.Data.Constants.Comm.Actions;

--- Stable key for comparing player names
---
---@param name string
---@return string
local function nameKey(name)
    return strlower(GL:formatPlayerName(name, { includeRealm = "always", }));
end

---@return nil
function LootCouncil:_init()
    if (self._initialized) then
        return;
    end

    -- Votes can come in at any moment (even after the roll ended), keep everything in sync
    GL.Events:register("LootCouncilVotesChangedListener", "GL.LOOT_COUNCIL_VOTES_CHANGED", function ()
        GL:after(.05, "LootCouncilRefresh", function ()
            GL.RollOff:refreshRollsTable();
            GL.RollerUI:refreshRollTracker();
        end);
    end);

    -- Stop voting once the loot master awarded the item
    GL.Events:register("LootCouncilItemAwardedListener", "GL.ITEM_AWARDED", function (_, AwardEntry)
        local Session = self.Session;

        if (Session
            and type(AwardEntry) == "table"
            and AwardEntry.itemID == GL:getItemIDFromLink(Session.itemLink)
            and (tonumber(AwardEntry.timestamp) or 0) >= Session.startedAt
            and GL:playerNamesMatch(AwardEntry.awardedBy, Session.initiatorFqn)
        ) then
            self:endSession();
        end
    end);

    self._initialized = true;
end

--- Is loot council enabled in the settings?
---
---@return boolean
function LootCouncil:enabled()
    return GL.Settings:get("LootCouncil.enabled", false) == true;
end

--- Should this item be voted on by the council?
---
---@param itemLink string
---@return boolean
function LootCouncil:appliesTo(itemLink)
    if (not self:enabled()) then
        return false;
    end

    local quality = select(3, GL.GetItemInfo(itemLink));
    if (quality and quality < (tonumber(GL.Settings:get("LootCouncil.minimumQuality", 0)) or 0)) then
        return false;
    end

    if (GL.Settings:get("LootCouncil.guildRunsOnly", false)) then
        local total, inGuild = 0, 0;

        for _, Player in pairs(GL.User:groupMembers()) do
            total = total + 1;

            if (GL.User:playerIsGuildMember(Player.fqn)) then
                inGuild = inGuild + 1;
            end
        end

        if (total < 1
            or (inGuild / total) * 100 < (tonumber(GL.Settings:get("LootCouncil.guildRunThreshold", 50)) or 50)
        ) then
            return false;
        end
    end

    return true;
end

--- The council for a new roll: listed names, selected guild ranks and ourselves (the loot master)
---
---@return table
function LootCouncil:resolveMembers()
    local Names = GL.Settings:get("LootCouncil.Members", {}) or {};
    local Ranks = GL.Settings:get("LootCouncil.GuildRanks", {}) or {};
    local RankByPlayer = {};

    if (next(Ranks)) then
        for _, Member in pairs(GL.User:guildMembers()) do
            if (Ranks[Member.rankIndex]) then
                RankByPlayer[Member.fqn] = true;
            end
        end
    end

    local Members, Seen = {}, {};
    local add = function (name)
        local key = nameKey(name);

        if (not Seen[key]) then
            Seen[key] = true;
            table.insert(Members, name);
        end
    end;

    add(GL.User.fqn);

    for _, Player in pairs(GL.User:groupMembers()) do
        local isListed = false;

        for _, name in pairs(Names) do
            if (GL:playerNamesMatch(name, Player.fqn) or GL:playerNamesMatch(name, Player.name)) then
                isListed = true;
                break;
            end
        end

        if (isListed or RankByPlayer[strlower(GL:storedPlayerName(Player.fqn))]) then
            add(Player.fqn);
        end
    end

    return Members;
end

--- Build the payload that goes out with a roll start (nil when loot council doesn't apply)
---
---@param itemLink string
---@return table|nil
function LootCouncil:payloadForStart(itemLink)
    if (not self:appliesTo(itemLink)) then
        return nil;
    end

    local Session = self.Session;
    local sessionID = (Session
        and GL:getItemIDFromLink(Session.itemLink) == GL:getItemIDFromLink(itemLink)
        and Session.initiator == GL.User.id)
        and Session.id
        or math.random(1, 2147483647);

    return {
        i = sessionID,
        m = self:resolveMembers(),
        n = math.max(1, math.floor(tonumber(GL.Settings:get("LootCouncil.votesPerMember", 1)) or 1)),
        s = GL.Settings:get("LootCouncil.sortByVotes", true) and 1 or 0,
    };
end

--- Start (or keep) the voting session for a roll
---
---@param Payload table|nil
---@param Sender table
---@param itemLink string
---@return nil
function LootCouncil:beginSession(Payload, Sender, itemLink)
    if (type(Payload) ~= "table"
        or not tonumber(Payload.i)
        or type(Payload.m) ~= "table"
    ) then
        return self:endSession();
    end

    if (self.Session and self.Session.id == Payload.i) then
        self.Session.Members = Payload.m;
        self.Session.itemLink = itemLink;
    else
        self.Session = {
            id = Payload.i,
            initiator = Sender.id,
            initiatorFqn = Sender.fqn,
            startedAt = GetServerTime(),
            itemLink = itemLink,
            Members = Payload.m,
            Votes = {},
            VoterNames = {},
        };
    end

    self.Session.votesPerMember = math.max(1, math.floor(tonumber(Payload.n) or 1));
    self.Session.sortByVotes = Payload.s == 1;

    GL.Events:fire("GL.LOOT_COUNCIL_VOTES_CHANGED");
end

---@return nil
function LootCouncil:endSession()
    if (not self.Session) then
        return;
    end

    self.Session = nil;
    GL.Events:fire("GL.LOOT_COUNCIL_VOTES_CHANGED");
end

---@return boolean
function LootCouncil:active()
    return self.Session ~= nil;
end

---@param name string
---@return boolean
function LootCouncil:isMember(name)
    if (not self.Session) then
        return false;
    end

    for _, member in pairs(self.Session.Members) do
        if (type(member) == "string" and GL:playerNamesMatch(member, name)) then
            return true;
        end
    end

    return false;
end

---@return boolean
function LootCouncil:userIsMember()
    return self:isMember(GL.User.fqn);
end

---@return boolean
function LootCouncil:sortByVotes()
    return self.Session ~= nil and self.Session.sortByVotes == true;
end

--- Players the current user voted for
---
---@return table
function LootCouncil:myVotes()
    if (not self.Session) then
        return {};
    end

    return self.Session.Votes[nameKey(GL.User.fqn)] or {};
end

---@return number
function LootCouncil:votesLeft()
    if (not self.Session) then
        return 0;
    end

    return math.max(0, self.Session.votesPerMember - GL:count(self:myVotes()));
end

---@return number
function LootCouncil:votesPerMember()
    return self.Session and self.Session.votesPerMember or 0;
end

---@param player string
---@return boolean
function LootCouncil:iVotedFor(player)
    return self:myVotes()[nameKey(player)] ~= nil;
end

--- Names of everyone who voted for a player
---
---@param player string
---@return table
function LootCouncil:votersFor(player)
    local Voters = {};

    if (not self.Session) then
        return Voters;
    end

    local key = nameKey(player);
    for voterKey, Votes in pairs(self.Session.Votes) do
        if (Votes[key]) then
            table.insert(Voters, GL:disambiguateName(self.Session.VoterNames[voterKey] or voterKey));
        end
    end

    table.sort(Voters);

    return Voters;
end

---@param player string
---@return number
function LootCouncil:votesFor(player)
    if (not self.Session) then
        return 0;
    end

    local key = nameKey(player);
    local votes = 0;
    for _, Votes in pairs(self.Session.Votes) do
        if (Votes[key]) then
            votes = votes + 1;
        end
    end

    return votes;
end

--- Everyone with at least one vote, highest first
---
---@return table
function LootCouncil:tallies()
    local Tallies, Counts, Names = {}, {}, {};

    if (not self.Session) then
        return Tallies;
    end

    for _, Votes in pairs(self.Session.Votes) do
        for key, name in pairs(Votes) do
            Counts[key] = (Counts[key] or 0) + 1;
            Names[key] = name;
        end
    end

    for key, count in pairs(Counts) do
        table.insert(Tallies, { name = GL:disambiguateName(Names[key]), votes = count, });
    end

    table.sort(Tallies, function (a, b)
        if (a.votes ~= b.votes) then
            return a.votes > b.votes;
        end

        return a.name < b.name;
    end);

    return Tallies;
end

---@return boolean
function LootCouncil:anyVotesCast()
    if (not self.Session) then
        return false;
    end

    for _, Votes in pairs(self.Session.Votes) do
        if (next(Votes)) then
            return true;
        end
    end

    return false;
end

--- Vote details for an awarded player
---
---@param player string
---@return table|nil
function LootCouncil:awardDetails(player)
    if (not self.Session or not self:anyVotesCast()) then
        return nil;
    end

    return {
        cast = true,
        votes = self:votesFor(player),
        Voters = self:votersFor(player),
    };
end

--- Cast or retract our vote for a player
---
---@param player string
---@param cast boolean
---@return nil
function LootCouncil:toggleVote(player, cast)
    if (not self.Session or not self:userIsMember() or GL:empty(player)) then
        return;
    end

    local myKey = nameKey(GL.User.fqn);
    local Votes = self.Session.Votes[myKey] or {};
    local key = nameKey(player);

    if (cast) then
        if (Votes[key] or self:votesLeft() < 1) then
            return;
        end

        Votes[key] = player;
    else
        if (not Votes[key]) then
            return;
        end

        Votes[key] = nil;
    end

    self.Session.Votes[myKey] = Votes;
    self.Session.VoterNames[myKey] = GL.User.fqn;

    -- Always send the complete set, that way lost or reordered messages don't matter
    local Players = {};
    for _, name in pairs(Votes) do
        table.insert(Players, name);
    end

    GL.CommMessage.new({
        action = CommActions.broadcastLootCouncilVotes,
        content = { i = self.Session.id, P = Players, },
        channel = "GROUP",
    }):send();

    GL.Events:fire("GL.LOOT_COUNCIL_VOTES_CHANGED");
end

--- Process votes sent by a council member
---
---@param CommMessage CommMessage
---@return nil
function LootCouncil:receiveVotes(CommMessage)
    local Session = self.Session;
    local content = CommMessage.content;

    if (not Session
        or type(content) ~= "table"
        or content.i ~= Session.id
        or type(content.P) ~= "table"
        or not self:isMember(CommMessage.Sender.fqn)
    ) then
        return;
    end

    local voterKey = nameKey(CommMessage.Sender.fqn);
    local Votes, count = {}, 0;

    for _, name in ipairs(content.P) do
        if (type(name) == "string" and count < Session.votesPerMember) then
            local key = nameKey(name);

            if (not Votes[key]) then
                Votes[key] = name;
                count = count + 1;
            end
        end
    end

    Session.Votes[voterKey] = Votes;
    Session.VoterNames[voterKey] = CommMessage.Sender.fqn;

    GL.Events:fire("GL.LOOT_COUNCIL_VOTES_CHANGED");
end

GL:registerForInit(LootCouncil);
