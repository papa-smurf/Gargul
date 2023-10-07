---@type GL
local _, GL = ...;

---@type Data
local Constants = GL.Data.Constants or {};

---@type GDKP
local GDKP = GL.GDKP;

---@type Settings
local Settings = GL.Settings;

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

---@param sessionID string
---@param gold number
---@param player string
---@param note string
---@return boolean
function Pot:addGold(sessionID, gold, player, note)
    GL:debug("Auction:addGold");

    return GDKPAuction:create(Constants.GDKP.potIncreaseItemID, gold, player, sessionID, nil, note);
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
        if (not Auction.deletedAt and Auction.price and Auction.price ~= 0) then
            pot = pot + Auction.price;
        end
    end

    return pot;
end

---@param sessionID string
---@param Data table
---@return boolean
function Pot:addMutator(sessionID, Data)
    GL:debug("Pot:addMutator");

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

    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return false;
    end

    Session.Pot = Session.Pot or {};
    Session.Pot.Mutators = Session.Pot.Mutators or {};

    Session.Pot.Mutators[Data.name] = {
        name = Data.name,
        percentage = Data.percentage,
        flat = Data.flat,
        autoApplyTo = Data.autoApplyTo,
    };

    -- Make sure this new mutator gets applied to everyone eligible
    self:applyMutator(sessionID, Data.name);

    return true;
end

---@param sessionID string
---@param name string
---@return void
function Pot:applyMutator(sessionID, name)
    GL:debug("Pot:applyMutator");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        return;
    end

    local Mutator = Session.Pot.Mutators[name];
    if (not Mutator or not Mutator.autoApplyTo) then
        return;
    end

    local AutoGiveOnRoles = GL:strSplit(Mutator.autoApplyTo, ",");
    if (GL:empty(AutoGiveOnRoles)) then
        return;
    end

    for playerName in pairs(Session.Pot.DistributionDetails or {}) do
        local Player = GL.Player:fromName(playerName);

        local PlayerRoles = { GL:disambiguateName(playerName) };
        if (Player) then
            PlayerRoles = self:getPlayerRoles(Player);
        end

        for _, role in pairs(PlayerRoles or {}) do
            if (GL:inTable(AutoGiveOnRoles, role)) then
                Session.Pot.DistributionDetails[playerName][name] = true;
                break;
            end
        end
    end
end

---@param sessionID string
---@param Data table
---@return boolean
function Pot:editMutator(originalName, Data, sessionID)
    GL:debug("Pot:editMutator");

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

    -- If a sessionID is provided then we only want to edit it for a specific session
    if (sessionID) then
        local Session = GDKPSession:byID(sessionID);
        if (not Session) then
            return false;
        end

        Session.Pot = Session.Pot or {};
        Session.Pot.Mutators = Session.Pot.Mutators or {};

        if (not Session.Pot.Mutators[originalName]) then
            return false;
        end

        Session.Pot.Mutators[originalName] = nil;
        Session.Pot.Mutators[Data.name] = Data;
        local ValidMutators = {};
        for mutatorName, Details in pairs(Session.Pot.Mutators or {}) do
            if (Details) then
                ValidMutators[mutatorName] = Details;
            end
        end
        Session.Pot.Mutators = ValidMutators;

        local DistributionDetails = Session.Pot.DistributionDetails or {};
        for player, Mutators in pairs(DistributionDetails or {}) do
            if (Mutators.originalName) then
                DistributionDetails[player][originalName] = nil;
                DistributionDetails[player][Data.name] = Data;

                ValidMutators = {};
                for mutatorName, value in pairs(Mutators or {}) do
                    if (type(value) ~= "nil") then
                        ValidMutators[mutatorName] = value;
                    end
                end

                Session.Pot.DistributionDetails[player] = ValidMutators;
            end
        end
    end

    return true;
end

---@param name string
---@param sessionID string
---@return boolean
function Pot:removeMutator(name, sessionID)
    GL:debug("Pot:removeMutator");

    -- If a sessionID is provided then we only want to remove it from a specific session
    if (sessionID) then
        local Session = GDKPSession:byID(sessionID);
        if (not Session) then
            return false;
        end

        Session.Pot = Session.Pot or {};
        Session.Pot.Mutators = Session.Pot.Mutators or {};
        Session.Pot.Mutators[name] = nil;
        local ValidMutators = {};
        for mutatorName, Details in pairs(Session.Pot.Mutators or {}) do
            if (Details) then
                ValidMutators[mutatorName] = Details;
            end
        end
        Session.Pot.Mutators = ValidMutators;

        local DistributionDetails = Session.Pot.DistributionDetails or {};
        for player, Mutators in pairs(DistributionDetails or {}) do
            DistributionDetails[player][name] = nil;

            ValidMutators = {};
            for mutatorName, value in pairs(Mutators or {}) do
                if (type(value) ~= "nil") then
                    ValidMutators[mutatorName] = value;
                end
            end

            Session.Pot.DistributionDetails[player] = ValidMutators;
        end

        return true;
    end

    local Mutators = Settings:get("GDKP.Mutators", {});
    Mutators[name] = nil;
    local ValidMutators = {};
    for mutatorName, Details in pairs(Mutators or {}) do
        if (Details) then
            ValidMutators[mutatorName] = Details;
        end
    end

    Settings:set("GDKP.Mutators", ValidMutators);

    return true;
end

---@param sessionID string
---@return table,number
function Pot:calculateCuts(sessionID)
    GL:debug("Pot:calculateCuts");

    if (not sessionID) then
        return false;
    end

    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return false;
    end

    Session.Pot.Mutators = Session.Pot.Mutators or {};
    local Cuts = Session.Pot.Cuts or {};
    local DistributionDetails = Session.Pot.DistributionDetails or {};

    -- This player hasn't had any pot or mutator calculations done for him yet
    -- Figure out which mutators to assign to him
    if (not Session.lockedAt) then
        for _, Player in pairs(GL.User:groupMembers() or {}) do
            local playerDetailsID = strlower(Player.fqn);
            if (GL:empty(DistributionDetails[playerDetailsID])) then
                DistributionDetails[playerDetailsID] = self:determineDistributionDefaults(Player, Session);
            end
        end
    end

    -- If there's a management cut then we remove it from the pot first
    local totalPot = self:total(sessionID);
    local managementCutPercentage = tonumber(Session.managementCut) or 0;
    local managementCut = math.floor(totalPot * (0 + managementCutPercentage / 100));
    local totalToDistribute = math.floor(totalPot - managementCut);

    local flat = 0; -- The total amount of gold given to a person as a flat gold rate
    local baseParts = 0; -- The total number of bases (25 if there are 25 people all getting a base cut, none getting a cut/bonus)
    local percentages = 0;

    -- Calculate the total number of base cuts, flat gold, and mutator percentages
    for _, Mutators in pairs(DistributionDetails or {}) do
        for name, value in pairs(Mutators or {}) do
            -- This player receives the base cut
            if (name == Constants.GDKP.baseMutatorIdentifier) then
                if (value) then
                    baseParts = baseParts + 1;
                end

            -- This player receives a manual gold adjustment
            elseif (name == Constants.GDKP.adjustMutatorIdentifier) then
                if (tonumber(value)) then
                    flat = flat + value;
                end

            -- This player receives a base % bonus or dock (example: 50 translates to adding .5 to the baseParts)
            elseif (name == Constants.GDKP.adjustPercentageMutatorIdentifier) then
                if (tonumber(value)) then
                    baseParts = baseParts + (tonumber(value) / 100);
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

    -- The total amount of gold that will be divided between all base parts (pot - flat - mutator percentages)
    local base = leftToDistribute - (leftToDistribute * (0 + (percentages / 100)));

    if (GL:higherThanZero(base) and GL:higherThanZero(baseParts)) then
        base = base / baseParts;
    elseif (Session.lockedAt and not GL:higherThanZero(base) and GL:higherThanZero(percentages)) then
        GL:error("There's not enough gold to distribute, expect some weird cut calculations!");
    end

    Session.lastAvailableBase = base;

    local totalDistributed = 0;
    for player, Mutators in pairs(DistributionDetails or {}) do
        local playerPot = 0;
        if (Mutators[Constants.GDKP.baseMutatorIdentifier]) then
            playerPot = base;
        end

        for name, value in pairs(Mutators or {}) do
            -- A value was entered in the `adjust [g]` editbox for this player
            if (name == Constants.GDKP.adjustMutatorIdentifier) then
                if (tonumber(value)) then
                    playerPot = playerPot + value;
                end

            -- A value was entered in the `adjust [%]` editbox for this player
            elseif (name == Constants.GDKP.adjustPercentageMutatorIdentifier) then
                if (tonumber(value)) then
                    value = tonumber(value);

                    local percentage = value / 100;
                    playerPot = playerPot + (base * percentage);
                end

            -- One of the other mutators was enabled for this user
            elseif (Session.Pot.Mutators[name] and value) then
                if (tonumber(Session.Pot.Mutators[name].percentage)) then
                    playerPot = playerPot + (leftToDistribute * (0 + Session.Pot.Mutators[name].percentage / 100));
                end

                if (tonumber(Session.Pot.Mutators[name].flat)) then
                    playerPot = playerPot + Session.Pot.Mutators[name].flat;
                end
            end
        end

        Cuts[player] = math.floor(playerPot);
        totalDistributed = totalDistributed + Cuts[player];
    end

    Session.Pot.Cuts = Cuts;
    Session.Pot.DistributionDetails = DistributionDetails;

    return Session, totalToDistribute, totalDistributed;
end

---@param Player Player
---@return table
function Pot:getPlayerRoles(Player)
    local nameFormatted = GL:nameFormat(Player.fqn);
    local PlayerRoles = {};
    local ClassRoleDictionary = {
        TANK = "TANK",
        DAMAGER = "DPS",
        HEALER = "HEAL",
    };

    if (Player.class) then
        tinsert(PlayerRoles, strupper(Player.class));
    end

    local classRole = UnitGroupRolesAssigned(nameFormatted);
    if (classRole and ClassRoleDictionary[classRole]) then
        tinsert(PlayerRoles, classRole);
    end

    if (Player.isLeader) then
        tinsert(PlayerRoles, "LEAD");
    end

    if (Player.isML) then
        tinsert(PlayerRoles, "ML");
    end

    tinsert(PlayerRoles, strupper(GL:disambiguateName(Player.fqn)));

    if (GL:iEquals(Player.fqn, GL.User.fqn)) then
        tinsert(PlayerRoles, "SELF");
    end

    return PlayerRoles;
end

--- Determine what mutators apply to someone joining the raid
---
---@param Player Player
---@param Session table
---@param enforceLock boolean|nil
function Pot:determineDistributionDefaults(Player, Session, enforceLock)
    GL:debug("Pot:determineDistributionDefaults");

    enforceLock = enforceLock ~= false;
    -- The session is locked and we're not taking on new customers
    if (enforceLock and Session.lockedAt) then
        return {};
    end

    local DistributionDetails = {};
    local PlayerRoles = self:getPlayerRoles(Player);

    for _, Mutator in pairs(GL:tableGet(Session, "Pot.Mutators", {})) do
        local AutoGiveOnRoles = GL:strSplit(Mutator.autoApplyTo, ",");
        local active = false;

        if (type(AutoGiveOnRoles) == "table") then
            for _, role in pairs(PlayerRoles or {}) do
                if (GL:inTable(AutoGiveOnRoles, role)) then
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

    GL:tableSet(Session, ("Pot.DistributionDetails.%s.%s"):format(player, mutator), value);

    return true;
end

---@param sessionID number
---@param player string
---@return boolean
function Pot:addPlayer(sessionID, player)
    GL:debug("Pot:addPlayer");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        return false;
    end

    -- Player names shouldn't include numbers
    if (string.match(player,"%d+")) then
        return false;
    end

    local Player = GL.Player:fromName(player);

    if (not Player) then
        Player = {
            name = player,
            realm = GL.User.realm,
       };
    end

    local playerGUID = GDKP:playerGUID(Player.name, Player.realm);
    Session.Pot = Session.Pot or {};
    Session.Pot.DistributionDetails = Session.Pot.DistributionDetails or {};

    Session.Pot.DistributionDetails[playerGUID] = {};
    Session.Pot.DistributionDetails[playerGUID] = self:determineDistributionDefaults(Player, Session);

    GDKPSession:store(Session);

    return true;
end

---@param sessionID string
---@param player string
---@return boolean
function Pot:deletePlayer(sessionID, player)
    GL:debug("Pot:deletePlayer");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        return false;
    end

    local playerGUID = GDKP:playerGUID(player);
    local DistributionDetails = GL:tableGet(Session, "Pot.DistributionDetails", {});
    DistributionDetails[playerGUID] = nil;

    local PlayerDetails = {};
    for name, Details in pairs(Session.Pot.DistributionDetails or {}) do
        if (type(Details) == "table" and Details ~= nil) then
            PlayerDetails[name] = Details;
        end
    end

    GL:tableSet(Session, "Pot.DistributionDetails", PlayerDetails);

    return true;
end

---@param sessionID string
---@param playerOld string
---@param playerNew string
---@return boolean
function Pot:renamePlayer(sessionID, playerOld, playerNew)
    GL:debug("Pot:renamePlayer");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        return false;
    end

    local _, oldRealm = GL:stripRealm(playerOld);
    playerNew = GL:addRealm(playerNew, oldRealm); -- Add the original realm if none is provided
    playerNew = GDKP:playerGUID(playerNew);

    Session.Pot = Session.Pot or {};
    Session.Pot.DistributionDetails = Session.Pot.DistributionDetails or {};
    Session.Pot.DistributionDetails[playerNew] = Session.Pot.DistributionDetails[playerOld];
    Session.Pot.DistributionDetails[playerOld] = nil;

    local PlayerDetails = {};
    for name, Details in pairs(Session.Pot.DistributionDetails or {}) do
        if (type(Details) == "table" and not GL:empty(Details)) then
            PlayerDetails[name] = Details;
        end
    end

    Session.Pot.DistributionDetails = PlayerDetails;
    GDKPSession:store(Session);

    return true;
end

--- Remove cut details from players who are no longer in the raid and have no specific mutators set besides the base
---
---@param sessionID string
---
---@return boolean Did something get cleared?
function Pot:clearUnavailablePlayerDetails(sessionID)
    GL:debug("Pot:clearUnavailablePlayerDetails");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        return false;
    end

    local somethingChanged = false;
    for player in pairs(Session.Pot.DistributionDetails or {}) do
        if (self:clearPlayerDetails(sessionID, player)) then
            somethingChanged = true;
        end
    end

    return somethingChanged;
end

---@param sessionID string
---@param player string
---@param keepAdjusted boolean|nil By default we keep the adjusted entries (ones with more than just a base cut)
---
---@return boolean Did something get cleared?
function Pot:clearPlayerDetails(sessionID, player, keepAdjusted)
    GL:debug("Pot:clearPlayerDetails");

    keepAdjusted = keepAdjusted ~= false;
    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        return false;
    end

    player = GDKP:playerGUID(player);
    if (GL:empty(Session.Pot.DistributionDetails[player])) then
        return false;
    end

    if (not keepAdjusted) then
        Session.Pot.DistributionDetails[player] = {};
        return true;
    end

    -- Check to see if any manual adjustments were made to this player, if so: ignore and return false
    local baseIdentifier = Constants.GDKP.baseMutatorIdentifier;
    for mutator, value in pairs(Session.Pot.DistributionDetails[player]) do
        if (mutator ~= baseIdentifier and not GL:empty(value)) then
            return false;
        end
    end

    Session.Pot.DistributionDetails[player] = {};
    return true;
end

---@param player string
---@param sessionID string
---@return number
function Pot:getCut(player, sessionID)
    local Session = sessionID and GDKPSession:byID(sessionID) or GDKPSession:getActive();

    if (not Session.lockedAt) then
        return 0;
    end

    local playerGUID = GDKP:playerGUID(player);
    return GL:tableGet(Session, "Pot.Cuts." .. playerGUID, 0) or 0;
end

---@param sessionID string
---@param callback function
---@return void
function Pot:announce(sessionID, callback)
    GL:debug("Pot:announce");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or not Session.lastAvailableBase or not tonumber(Session.lastAvailableBase)) then
        return false;
    end

    -- If there's a management cut then we remove it from the pot first
    local totalPot = self:total(sessionID);
    local managementCutPercentage = tonumber(Session.managementCut) or 0;
    local managementCut = math.floor(totalPot * (0 + managementCutPercentage / 100));
    local totalToDistribute = math.floor(totalPot - managementCut);

    local message = string.format("Total Pot: %sg", totalToDistribute);
    GL:sendChatMessage(message, "GROUP");

    message = string.format("Base cut: %sg", math.floor(Session.lastAvailableBase));
    GL:sendChatMessage(message, "GROUP");

    ---@todo: polish up the announcement at some point
    if (true) then
        return;
    end

    Session.Pot = Session.Pot or {};
    Session.Pot.DistributionDetails = Session.Pot.DistributionDetails or {};
    Session.Pot.Cuts = Session.Pot.Cuts or {};

    -- Make sure we sort by name (asc)
    local Players = {};
    for player in pairs(Session.Pot.DistributionDetails or {}) do
        tinsert(Players, player);
    end

    table.sort(Players, function(a, b)
        if (a and b) then
            return a < b;
        end

        return false;
    end);

    local playerIndex = 1;
    local broadcastPlayerCut;
    broadcastPlayerCut = function ()
        local player = Players[playerIndex];

        if (GL:empty(player)) then
            if (type(callback) == "function") then
                callback();
            end

            return;
        end

        local ActiveMutators = {};
        for mutator, value in pairs(Session.Pot.DistributionDetails[player] or {}) do
            if (value
                and mutator ~= Constants.GDKP.baseMutatorIdentifier
                and mutator ~= Constants.GDKP.adjustMutatorIdentifier
            ) then
                tinsert(ActiveMutators, mutator);
            end
        end

        local message;
        if (GL:empty(ActiveMutators)) then
            message = string.format("%s: %sg",
                player,
                Session.Pot.Cuts[player] or 0
            );
        else
            message = string.format("%s: %sg (%s)",
                player,
                Session.Pot.Cuts[player] or 0,
                table.concat(ActiveMutators, ", ")
            );
        end

        if (Session.Pot.Cuts[player] > 0) then
            GL:sendChatMessage(message, "GROUP");
        end

        playerIndex = playerIndex + 1;
        GL.Ace:ScheduleTimer(function ()
            broadcastPlayerCut();
        end, .5);
    end;

    broadcastPlayerCut();
end

---@param sessionID string
---@param data string
---@return boolean
function Pot:importCuts(sessionID, data)
    GL:debug("Pot:importCuts");

    local Session = GDKPSession:byID(sessionID);
    if (not Session) then
        return false;
    end

    local first = true;
    local Columns = {};
    local Cuts = {};
    for line in data:gmatch("[^\n]+") do
        local Segments = GL:strSplit(line, ",");

        if (first) then
            Columns = GL:tableFlip(Segments);
            first = false;

            if (not Columns.Player or not Columns.Gold) then
                GL:error("Missing header, note: it's case-sensitive!");
                return;
            end
        else -- The first line includes the heading, we don't need that
            local error = false;
            local playerGUID = GDKP:playerGUID(tostring(Segments[Columns.Player]));
            local gold = tonumber(Segments[Columns.Gold]);

            if (not gold) then
                error = true;

                if (not GL:empty(playerGUID)) then
                    GL:warning("Missing gold for player " .. playerGUID);
                end
            elseif (GL:empty(playerGUID) and gold) then
                error = true;

                GL:warning("Missing player name");
            end

            if (not error) then
                Cuts[playerGUID] = GL:round(gold, 2);
            end
        end
    end

    if (GL:empty(Cuts)) then
        GL:warning("Nothing to import, double check your CSV");

        return false;
    end

    Session.Pot = Session.Pot or {};
    Session.Pot.DistributionDetails = {};
    Session.Pot.Cuts = {};

    for _, Player in pairs(GL.User:groupMembers() or {}) do
        local playerGUID = GDKP:playerGUID(Player.fqn);
        Session.Pot.DistributionDetails[playerGUID] = {};
        Session.Pot.Cuts[playerGUID] = 0;
    end

    for player, cut in pairs(Cuts or {}) do
        Session.Pot.DistributionDetails[player] = Session.Pot.DistributionDetails[player] or {};
        Session.Pot.DistributionDetails[player][Constants.GDKP.adjustMutatorIdentifier] = tostring(cut);
        Session.Pot.Cuts[player] = cut;
    end

    GL.Events:fire("GL.GDKP_CUTS_IMPORTED");
    return true;
end

GL:debug("Pot.lua");