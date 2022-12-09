---@type GL
local _, GL = ...;

---@type Data
local Constants = GL.Data.Constants or {};

---@type DB
local DB = GL.DB;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPSession
local GDKPSession = GDKP.Session;

---@type GDKPAuction
local GDKPAuction = GDKP.Auction;

---@class GDKPPot
GDKP.Pot = {
    ValidAutoApplyPlaceholders = {
        "SELF",
        "RL",
        "ML",
        "ASSIST",
        "TANK",
        "HEALER",
        "DPS",
        "DRUID",
        "HUNTER",
        "MAGE",
        "PALADIN",
        "PRIEST",
        "ROGUE",
        "SHAMAN",
        "WARLOCK",
        "WARRIOR",
        "DEATHKNIGHT",
        "DEMONHUNTER",
        "EVOKER",
        "MONK",
    },
};

---@type GDKPPot
local Pot = GDKP.Pot;

--Pot.Mutators = {
--    tank = {name="tank", percentage=2, flat=0, AutoGiveOnRolls={"TANK"}},
--    healer = {name="healer", percentage=1, flat=0, AutoGiveOnRolls={"HEALER"}},
--    utility = {name="utility", percentage=.5, flat=0, AutoGiveOnRolls={"MASTERLOOTER", "ROGUE"}},
--};

---@param sessionID string
---@param gold number
---@param player string
---@param note string
---@return boolean
function Pot:addGold(sessionID, gold, player, note)
    GL:debug("Auction:addGold");

    note = strtrim(tostring(note));
    local Instance = GDKPAuction:create(Constants.GDKP.potIncreaseItemID, gold, player, sessionID, nil, note);

    if (type(Instance) == "table") then
        return true;
    end

    return false;
end

---@param sessionID string|nil If nil use currently active session
---@return number
function Pot:total(sessionID)
    GL:debug("Pot:total");

    sessionID = sessionID or GDKPSession:getActive();

    if (not sessionID) then
        return 0;
    end

    local Session;
    if (type(sessionID) == "table") then
        Session = sessionID;
    else
        Session = GDKPSession:byID(sessionID);
    end

    if (not Session) then
        return 0;
    end

    local pot = 0;
    for _, Auction in pairs(Session.Auctions or {}) do
        if (not Auction.deletedAt and GL:higherThanZero(Auction.price)) then
            pot = pot + Auction.price;
        end
    end

    return pot;
end

---@param sessionID string
---@param Data table
---@return boolean
function Pot:addMutator(sessionID, Data)
    Data = {
        autoApplyTo = Data.autoApplyTo or "",
        flat = Data.flat or "",
        name = Data.name or "",
        percentage = Data.percentage or "",
    };

    local name = strtrim(Data.name);
    if (GL:empty(name)) then
        return false;
    end

    local percentage = strtrim(Data.percentage);
    if (not GL:empty(percentage)
        and GL:empty(tonumber(percentage))
    ) then
        return false;
    end

    local flat = strtrim(Data.flat);
    if (not GL:empty(flat)
        and GL:empty(tonumber(flat))
    ) then
        return false;
    end

    local autoApplyTo = strtrim(Data.autoApplyTo);
    local ValidPlaceholders = {};
    if (not GL:empty(autoApplyTo)) then
        local Placeholders = GL.strSplit(autoApplyTo, ",");

        for _, placeholder in pairs(Placeholders or {}) do
            placeholder = string.upper(strtrim(placeholder));

            if (not GL:empty(placeholder) and GL:inTable(self.ValidAutoApplyPlaceholders, placeholder)) then
                tinsert(ValidPlaceholders, placeholder);
            end
        end
    end

    local Instance = GDKPSession:byID(sessionID);

    if (not Instance) then
        return false;
    end

    Instance.Pot = Instance.Pot or {};
    Instance.Pot.Mutators = Instance.Pot.Mutators or {};

    Instance.Pot.Mutators[Data.name] = {
        name = Data.name,
        percentage = Data.percentage,
        flat = Data.flat,
        AutoApplyTo = ValidPlaceholders,
    };

    GDKPSession:store(Instance);

    return true;
end

---@param sessionID string
---@return table,number
function Pot:calculateCuts(sessionID)
    GL:debug("Pot:calculateCuts");

    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return false;
    end

    --GL:tableSet(Session, "Pot.DistributionDetails", {}, true);

    Session.Pot.Mutators = Session.Pot.Mutators or {};
    local Cuts = Session.Pot.Cuts or {};
    local DistributionDetails = Session.Pot.DistributionDetails or {};

    local PlayerNames = {};
    for _, Player in pairs(GL.User:groupMembers() or {}) do
        tinsert(PlayerNames, Player.name);
        if (not DistributionDetails[Player.name]) then
            DistributionDetails[Player.name] = self:determineDistributionDefaults(Player, Session);
        end
    end

    -- If there's a management cut then we remove it from the pot first
    local totalPot = self:total(sessionID);
    local managementCutPercentage = tonumber(Session.managementCut) or 0;
    local managementCut = math.floor(totalPot * (0 + managementCutPercentage / 100));
    local totalToDistribute = math.floor(totalPot - managementCut);

    local base = 0;
    local flat = 0;
    local numberOfPlayersWithBase = 0;
    local percentages = 0;

    for _, Mutators in pairs(DistributionDetails or {}) do
        for name, value in pairs(Mutators or {}) do

            -- This player receives the base cut
            if (name == Constants.GDKP.baseMutatorIdentifier) then
                if (value) then
                    numberOfPlayersWithBase = numberOfPlayersWithBase + 1;
                end

                -- This player receives a manual gold adjustment
            elseif (name == Constants.GDKP.adjustMutatorIdentifier) then
                if (tonumber(value)) then
                    flat = flat + value;
                end

            elseif (Session.Pot.Mutators[name] and value) then
                if (tonumber(Session.Pot.Mutators[name].percentage)) then
                    percentages = percentages + Session.Pot.Mutators[name].percentage;
                end

                if (tonumber(Session.Pot.Mutators[name].flat)) then
                    flat = flat + Session.Pot.Mutators[name].flat;
                end
            end
        end
    end

    local leftToDistribute = totalToDistribute - flat;
    local baseTotal = leftToDistribute - (leftToDistribute * (0 + (percentages / 100)));

    if (GL:higherThanZero(baseTotal) and GL:higherThanZero(numberOfPlayersWithBase)) then
        base = GL:round(baseTotal / numberOfPlayersWithBase, 2);
    elseif (not GL:higherThanZero(baseTotal) and GL:higherThanZero(percentages)) then
        GL:error("There's not enough gold to distribute, expect some weird cut calculations!");
    end

    local totalDistributed = 0;
    for player, Mutators in pairs(DistributionDetails or {}) do
        local playerPot = 0;
        if (Mutators[Constants.GDKP.baseMutatorIdentifier]) then
            playerPot = base;
        end

        for name, value in pairs(Mutators or {}) do
            if (name == Constants.GDKP.adjustMutatorIdentifier) then
                if (tonumber(value)) then
                    playerPot = playerPot + value;
                end

            elseif (name ~= Constants.GDKP.baseMutatorIdentifier and Session.Pot.Mutators[name] and value) then
                if (tonumber(Session.Pot.Mutators[name].percentage)) then
                    playerPot = playerPot + (leftToDistribute * (0 + Session.Pot.Mutators[name].percentage / 100));
                end

                if (tonumber(Session.Pot.Mutators[name].flat)) then
                    playerPot = playerPot + Session.Pot.Mutators[name].flat;
                end
            end
        end

        Cuts[player] = GL:round(playerPot, 0);
        totalDistributed = totalDistributed + Cuts[player];
    end

    Session.Pot.Cuts = Cuts;
    Session.Pot.DistributionDetails = DistributionDetails;

    GDKPSession:store(Session);

    return Session, totalToDistribute, totalDistributed;
end

function Pot:determineDistributionDefaults(Player, Session)
    GL:debug("Pot:determineDistributionDefaults");

    local PlayerRoles = {};
    local DistributionDetails = {};
    local ClassRoleDictionary = {
        TANK = "TANK",
        DAMAGER = "DPS",
        HEALER = "HEAL",
    };

    if (Player.class) then
        tinsert(PlayerRoles, strupper(Player.class));
    end

    local classRole = UnitGroupRolesAssigned(Player.name);
    if (classRole and ClassRoleDictionary[classRole]) then
        tinsert(PlayerRoles, classRole);
    end

    if (Player.isLeader) then
        tinsert(PlayerRoles, "LEAD");
    end

    if (Player.isML) then
        tinsert(PlayerRoles, "ML");
    end

    for _, Mutator in pairs(Session.Pot.Mutators or {}) do
        local active = false;

        if (type(Mutator.AutoGiveOnRolls) == "table") then
            for _, role in pairs(PlayerRoles or {}) do
                if (GL:inTable(Mutator.AutoGiveOnRolls, role)) then
                    active = true;
                    break;
                end
            end
        end

        DistributionDetails[Mutator.name] = active;
    end

    DistributionDetails[Constants.GDKP.baseMutatorIdentifier] = true;

    return DistributionDetails;
end

---@param sessionID string
---@return boolean
function Pot:resetCuts(sessionID)
    GL:debug("Pot:resetDistributionDetails");

    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return false;
    end

    GL:tableSet(Session, "Pot.Cuts", {});
    GL:tableSet(Session, "Pot.DistributionDetails", {});
    GDKPSession:store(Session);

    return true;
end

---@param sessionID string
---@param player string
---@param mutator string
---@param value boolean|number
---@return boolean
function Pot:setPlayerMutatorValue(sessionID, player, mutator, value)
    GL:debug("Pot:setPlayerMutatorValue");

    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return false;
    end

    ---@todo Figure out why this doesn't work
    --GL:tableSet(
    --    Session,
    --    "Pot.DistributionDetails." .. player,
    --    {},
    --    true
    --);

    Session.Pot = Session.Pot or {};
    Session.Pot.DistributionDetails = Session.Pot.DistributionDetails or {};
    Session.Pot.DistributionDetails[player] = Session.Pot.DistributionDetails[player] or {};

    Session.Pot.DistributionDetails[player][mutator] = value;

    return GDKPSession:store(Session);
end

---@param sessionID string
---@param player string
---@return boolean
function Pot:deletePlayer(sessionID, player)
    GL:debug("Pot:deletePlayer");

    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return false;
    end

    Session.Pot = Session.Pot or {};
    Session.Pot.DistributionDetails = Session.Pot.DistributionDetails or {};
    Session.Pot.DistributionDetails[player] = nil;

    local PlayerDetails = {};
    for name, Details in pairs(Session.Pot.DistributionDetails or {}) do
        if (type(Details) == "table" and not GL:empty(Details)) then
            GL:xd(name);
            PlayerDetails[name] = Details;
        end
    end

    Session.Pot.DistributionDetails = PlayerDetails;

    return GDKPSession:store(Session);
end

GL:debug("Pot.lua");