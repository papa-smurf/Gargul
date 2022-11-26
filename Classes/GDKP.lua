---@type GL
local _, GL = ...;

---@type DB
local DB = GL.DB;

---@type Data
local Constants = GL.Data.Constants;
local CommActions = Constants.Comm.Actions;

---@type Events
local Events = GL.Events;

---@class GDKP
GL.GDKP = {
    _initialized = false,
    broadcastInProgress = false,
    requestingData = false,

    inProgress = false,
    timerId = 0, -- ID of the timer event
    CurrentAuction = {
        antiSnipe = nil, -- The anti snipe time
        duration = nil, -- The amount of time players get to bid
        initiatorID = nil, -- The ID of the player who started the auction
        initiatorName = nil, -- The name of the player who started the auction
        itemIcon = nil, -- The icon of the item we're bidding on
        itemID = nil, -- The ID of the item we're bidding on
        itemLink = nil, -- The item link of the item we're bidding on
        itemName = nil, -- The name of the item we're bidding on
        minimumBid = nil, -- The minimum amount players need to bid
        minimumIncrement = nil, -- The minimum amount between two player bids
        Bids = {}, -- Player bids
        TopBid = {}, -- Top bid
    },
    lastOutBidNotificationShownAt = nil,
    listeningForBids = false,
    BidListenerCancelTimerId = nil,
};

---@type GDKP
local GDKP = GL.GDKP;

---@type table
local SecondsAnnounced = {};

--- @return boolean
function GDKP:_init()
    GL:debug("GDKP:_init");

    if (self._initialized) then
        return false;
    end

    -- An event is fired whenever a bid is accepted, in which case we broadcast the latest auction details
    Events:register("GDKPBidAccepted", "GL.GDKP_BID_ACCEPTED", function (_, OldTopBid, NewTopBid)
        GL.CommMessage.new(
            CommActions.refreshGDKPAuction,
            self.CurrentAuction,
            "GROUP"
        ):send();

        if (GL:tableGet(OldTopBid or {}, "Bidder.name") == GL.User.name and NewTopBid.Bidder.name ~= GL.User.name) then
            Events:fire("GL.GDKP_USER_WAS_OUTBID", OldTopBid, NewTopBid);
        end

        GL.Interface.GDKP.Bidder:refresh();
    end);

    -- Whenever we were outbid we show a notification
    Events:register("GDKPGDKPUserWasOutBid", "GL.GDKP_USER_WAS_OUTBID", function (_, NewTopBid)
        -- We don't want to spam the user with alerts!
        if (self.lastOutBidNotificationShownAt
            and GetServerTime() - self.lastOutBidNotificationShownAt <= 8
        ) then
            return;
        end

        self.lastOutBidNotificationShownAt = GetServerTime();
        GL.Interface.Alerts:fire("GargulNotification", {
            message = string.format("|c00BE3333You were outbid!|r", NewTopBid.Bidder.name),
        });
    end);

    self._initialized = true;
    return true;
end

---@param sessionID string|nil If nil use currently active session
---@return number
function GDKP:pot(sessionID)
    GL:debug("GDKP:pot");

    sessionID = sessionID or DB.GDKP.activeSession;

    if (not sessionID) then
        return 0;
    end

    local Session = self:getSessionByID(sessionID);

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

--- Return the currently active GDKP session
---
---@return table|boolean
function GDKP:getActiveSession()
    GL:debug("GDKP:getActiveSession");

    local activeSessionIdentifier = DB.GDKP.activeSession or false;

    if (not activeSessionIdentifier) then
        return false;
    end

    return DB:get("GDKP.Ledger." .. activeSessionIdentifier, false);
end

--- Change the active session
---
---@param sessionID string
---@return boolean
function GDKP:setActiveSession(sessionID)
    GL:debug("GDKP:setActiveSession");

    local Session = self:getSessionByID(sessionID);
    if (not Session
        or Session.deletedAt
        or DB.GDKP.activeSession == sessionID
    ) then
        return false;
    end

    DB.GDKP.activeSession = sessionID;

    Events:fire("GL.GDKP_SESSION_ACTIVATED", sessionID);
    Events:fire("GL.GDKP_ACTIVE_SESSION_CHANGED");

    return true;
end

--- Return whether we have an active GDKP session
---
---@return boolean
function GDKP:hasActiveSession()
    GL:debug("GDKP:hasActiveSession");

    return self:getActiveSession() ~= false;
end

--- Return whether we the session identifier exists
---
---@return boolean
function GDKP:sessionExists(sessionIdentifier)
    GL:debug("GDKP:sessionExists");

    return DB.GDKP.Ledger[sessionIdentifier] and not GL:empty(DB.GDKP.Ledger[sessionIdentifier].ID);
end

--- Create a new GDKP session
---
---@param title string
---@return table|boolean
function GDKP:createSession(title)
    GL:debug("GDKP:createSession");

    if (type(title) ~= "string" or GL:empty(title)) then
        return false;
    end

    local Session = {
        title = GL:capitalize(string.sub(title, 0, 30)),
        createdAt = GetServerTime(),
        CreatedBy = {
            class = GL.User.class,
            name = GL.User.name,
            guild = GL.User.Guild.name,
            uuid = GL.User.id,
        },
        Auctions = {},
    };

    local checksum = Session.createdAt .. GL:stringHash(Session);
    Session.ID = checksum;

    DB:set("GDKP.Ledger." .. checksum, Session);
    Events:fire("GL.GDKP_SESSION_CREATED", Session);

    return Session;
end

--- Create a new GDKP session
---
---@param sessionID string
---@param title string
---@return boolean|table
function GDKP:editSession(sessionID, title)
    GL:debug("GDKP:createSession");

    if (type(title) ~= "string" or GL:empty(title)) then
        return false;
    end

    local Session = self:getSessionByID(sessionID);

    if (not Session) then
        return false;
    end

    Session.title = GL:capitalize(string.sub(title, 0, 30));
    DB:set("GDKP.Ledger." .. Session.ID, Session);
    Events:fire("GL.GDKP_SESSION_CHANGED", Session, self:getSessionByID(sessionID));

    return Session;
end

--- Delete, or soft-delete a session depending on whether or not it has auctions attached to it
---
---@param sessionID string
---@return boolean
function GDKP:deleteSession(sessionID)
    GL:debug("GDKP:deleteSession");

    local Session = self:getSessionByID(sessionID);

    if (not Session) then
        return false;
    end

    -- This session is the currently active one, clear it
    if (DB.GDKP.activeSession == sessionID) then
        self:clearActiveSession();
    end

    -- There are no auctions attached to this session, we can safely remove it!
    if (GL:empty(Session.Auctions)) then
        DB:set("GDKP.Ledger." .. sessionID, nil);

        -- There are auctions, mark the Session as deleted but keep it for 24h still
    else
        DB:set("GDKP.Ledger." .. sessionID .. ".deletedAt", GetServerTime());
    end

    Events:fire("GL.GDKP_SESSION_CHANGED", Session);
    Events:fire("GL.GDKP_SESSION_DELETED", sessionID);

    return true;
end

--- Restore a deleted session
---
---@param sessionID string
---@return boolean
function GDKP:restoreSession(sessionID)
    GL:debug("GDKP:restoreSession");

    local Session = self:getSessionByID(sessionID);

    if (not Session or not Session.deletedAt) then
        return false;
    end

    DB:set("GDKP.Ledger." .. sessionID .. ".deletedAt", nil);

    Events:fire("GL.GDKP_SESSION_CHANGED", Session, self:getSessionByID(sessionID));
    Events:fire("GL.GDKP_SESSION_RESTORED", sessionID);

    return true;
end

--- Clear the currently active session
---
---@return void
function GDKP:clearActiveSession()
    GL:debug("GDKP:clearActiveSession");

    if (not DB.GDKP.activeSession) then
        return false;
    end

    local activeSession = DB.GDKP.activeSession;
    DB.GDKP.activeSession = nil;

    Events:fire("GL.GDKP_ACTIVE_SESSION_CLEARED", activeSession);
    Events:fire("GL.GDKP_ACTIVE_SESSION_CHANGED");

    return true;
end

--- Restore the given auction
---
---@param sessionIdentifier string
---@param auctionIdentifier string
---
---@return void
function GDKP:restoreAuction(sessionIdentifier, auctionIdentifier)
    GL:debug("GDKP:restoreAuction");

    local Auction = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));

    -- The auction could not be found or is not deleted
    if (not Auction or Auction.price) then
        return false;
    end

    -- Sort the states on createdAt so that we can get the most recent state
    table.sort(Auction.PreviousStates, function (a, b)
        return a.createdAt > b.createdAt;
    end);

    local mostRecentStateIdentifier;
    local MostRecentState;
    for stateIdentifier, State in pairs(Auction.PreviousStates or {}) do
        mostRecentStateIdentifier = stateIdentifier;
        MostRecentState = State;

        break;
    end

    -- Better safe than lua error
    if (GL:empty(MostRecentState)) then
        return false;
    end

    Auction.Winner = MostRecentState.Winner;
    Auction.price = MostRecentState.price;
    Auction.guild = MostRecentState.guild;

    -- Remove the restored state from the previous states table
    Auction.PreviousStates[mostRecentStateIdentifier] = nil;

    -- We don't point to Auction here, we want a copy not a pointer!
    local Before = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));
    DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier), Auction);

    Events:fire("GL.GDKP_AUCTION_CHANGED", sessionIdentifier, auctionIdentifier, Before, Auction);
    Events:fire("GL.GDKP_AUCTION_RESTORED", sessionIdentifier, auctionIdentifier);

    return true;
end

--- Delete the given auction
---
---@param sessionIdentifier string
---@param auctionIdentifier string
---
---@return void
function GDKP:deleteAuction(sessionIdentifier, auctionIdentifier, reason)
    GL:debug("GDKP:deleteAuction");

    local Auction = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));

    -- The auction could not be found or is already deleted
    if (not Auction or not Auction.price) then
        return false;
    end

    Auction.PreviousStates = Auction.PreviousStates or {};

    local PreviousState = {
        createdAt = GetServerTime(),
        price = Auction.price,
        CreatedBy = {
            class = GL.User.class,
            name = GL.User.name,
            guild = GL:tableGet(GL.User, "Guild.name") or nil,
            uuid = GL.User.id,
        },
        Winner = Auction.Winner,
    };

    -- Add a state so we can restore later if needed
    tinsert(Auction.PreviousStates, PreviousState);

    Auction.Winner = nil;
    Auction.price = nil;
    Auction.reason = tostring(reason);

    -- We don't point to Auction here, we want a copy not a pointer!
    local Before = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));
    DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier), Auction);

    Events:fire("GL.GDKP_AUCTION_CHANGED", sessionIdentifier, auctionIdentifier, Before, Auction);
    Events:fire("GL.GDKP_AUCTION_DELETED", sessionIdentifier, auctionIdentifier, Auction);

    return true;
end

--- Create an auction
---
---@param itemID number
---@param price number
---@param winner string
---@param sessionIdentifier string
---
---@return boolean
function GDKP:createAuction(itemID, price, winner, sessionIdentifier, Bids)
    GL:debug("GDKP:createAuction");

    if ((not sessionIdentifier
            or (sessionIdentifier and not self:sessionExists(sessionIdentifier))
        ) and not self:hasActiveSession()
    ) then
        GL:warning("Unknown sessionIdentifier in GDKP:createAuction: " .. tostring(sessionIdentifier));
        return false;
    end

    itemID = GetItemInfoInstant(itemID);

    if (not GL:higherThanZero(itemID)) then
        GL:warning("Unknown itemID in GDKP:createAuction: " .. tostring(itemID));
        return false;
    end

    sessionIdentifier = sessionIdentifier or DB.GDKP.activeSession;

    local Auction = {
        price = price,
        itemID = itemID,
        createdAt = GetServerTime(),
        CreatedBy = {
            class = GL.User.class,
            guild = GL.User.Guild.name,
            name = GL.User.name,
            race = GL.User.race,
            realm = GL.User.realm,
            uuid = GL.User.id,
        },
        Bids = Bids or {},
    };

    local Winner = GL.Player:fromName(winner) or {};
    Winner.Guild = Winner.Guild or {};

    Auction.Winner = {
        class = Winner.class,
        guild = Winner.Guild.name,
        name = Winner.name or winner,
        race = Winner.race,
        realm = Winner.realm or GL.User.realm,
        uuid = Winner.id,
    };

    local checksum = Auction.createdAt .. GL:stringHash({ Auction.itemID, Auction.createdAt, table.concat(Auction.CreatedBy, ".") });
    Auction.ID = checksum;

    -- Something is wrong with the Auction. Tampering maybe? RETURN!
    Auction = self:sanitizeAuction(Auction);
    if (not Auction) then
        return false;
    end

    DB.GDKP.Ledger[sessionIdentifier].Auctions[checksum] = Auction;

    Events:fire("GL.GDKP_AUCTION_CHANGED", sessionIdentifier, checksum, {}, Auction);
    Events:fire("GL.GDKP_AUCTION_CREATED", sessionIdentifier, checksum);

    return true;
end

function GDKP:sanitizeAuction(Auction)
    local SanitizedAuction = {};

    --[[ Top level Auction check ]]
    if (not Auction
        or type(Auction) ~= "table"
        or type(Auction.CreatedBy) ~= "table"
        or (Auction.Winner and type(Auction.Winner) ~= "table")
        or (Auction.Bids and type(Auction.Bids) ~= "table")
        or date('%Y', tonumber(Auction.createdAt) or 0) == "1970"
        or not tonumber(Auction.itemID)
        or not tonumber(Auction.price or 0) or 0 > 0
    ) then
        return false;
    end

    --[[ Auction.CreatedBy ]]
    if (type (Auction.CreatedBy.class) ~= "string"
        or not Constants.Classes[Auction.CreatedBy.class]
        or type (Auction.CreatedBy.name) ~= "string"
        or GL:empty(Auction.CreatedBy.name)
        or type (Auction.CreatedBy.race) ~= "string"
        or not GL:inTable(Constants.Races, Auction.CreatedBy.race)
        or type (Auction.CreatedBy.uuid) ~= "string"
        or not string.match(Auction.CreatedBy.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
        or type (Auction.CreatedBy.realm) ~= "string"
        or GL:empty(Auction.CreatedBy.realm)
    ) then
        return false;
    end

    SanitizedAuction.CreatedBy = {
        class = Auction.CreatedBy.class,
        name = Auction.CreatedBy.name,
        race = Auction.CreatedBy.race,
        realm = Auction.CreatedBy.realm,
        uuid = Auction.CreatedBy.uuid,
    };

    -- Add the winner's guild if he was part of one
    local createdByGuild = Auction.CreatedBy.guild;

    if (createdByGuild) then
        if (type(createdByGuild) ~= "string"
            or GL:empty(createdByGuild)
        ) then
            return;
        end

        SanitizedAuction.CreatedBy.guild = strtrim(createdByGuild);
    end

    --[[ Make sure the item ID is valid ]]
    SanitizedAuction.itemID = GetItemInfoInstant(Auction.itemID);
    if (not SanitizedAuction.itemID or 0 > 0) then
        return false;
    end

    --[[ Auction.Bids ]]
    if (Auction.Bids) then
        for key, Bid in pairs(Auction.Bids) do
            if (type(Bid) ~= "table"
                or type(Bid.Bidder) ~= "table"
                or not tonumber(Bid.bid or 0) or 0 > 0
                or date('%Y', tonumber(Bid.createdAt) or 0) == "1970"
            ) then
                return false;
            end

            local Bidder = Bid.Bidder;
            if (type (Bidder.class) ~= "string"
                or not Constants.Classes[Bidder.class]
                or type (Bidder.name) ~= "string"
                or GL:empty(Bidder.name)
                or type (Bidder.race) ~= "string"
                or not GL:inTable(Constants.Races, Bidder.race)
                or type (Bidder.uuid) ~= "string"
                or not string.match(Bidder.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
                or type (Bidder.realm) ~= "string"
                or GL:empty(Bidder.realm)
            ) then
                return false;
            end

            -- Make sure we only maintain valid keys
            SanitizedAuction.Bids = SanitizedAuction.Bids or {};
            SanitizedAuction.Bids[key] = {
                Bidder = {
                    class = Bidder.class,
                    guild = Bidder.guild,
                    name = Bidder.name,
                    race = Bidder.race,
                    realm = Bidder.realm,
                    uuid = Bidder.uuid,
                },
                bid = tonumber(Bid.bid),
                createdAt = tonumber(Bid.createdAt),
            };

            -- Add the player's guild if he was part of one
            local guild = Bidder.guild;

            if (guild) then
                if (type(guild) ~= "string"
                    or GL:empty(guild)
                ) then
                    return;
                end

                SanitizedAuction.Bids[key].guild = strtrim(guild);
            end
        end
    end

    --[[ Auction.Winner ]]
    if (Auction.Winner) then
        local Winner = Auction.Winner;

        if (type(Winner) ~= "table"
            or type (Winner.race) ~= "string"
            or not GL:inTable(Constants.Races, Winner.race)
            or type (Winner.class) ~= "string"
            or not Constants.Classes[Winner.class]
            or type (Winner.name) ~= "string"
            or GL:empty(Winner.name)
            or type (Winner.uuid) ~= "string"
            or not string.match(Winner.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
            or type (Winner.realm) ~= "string"
            or GL:empty(Winner.realm)
        ) then
            return;
        end

        SanitizedAuction.Winner = {
            race = Winner.race;
            name = Winner.name;
            class = Winner.class;
            uuid = Winner.uuid;
            realm = Winner.realm;
        };

        -- Add the winner's guild if he was part of one
        local guild = Winner.guild;

        if (guild) then
            if (type(guild) ~= "string"
                or GL:empty(guild)
            ) then
                return;
            end

            SanitizedAuction.Winner.guild = strtrim(guild);
        end
    end

    SanitizedAuction.createdAt = tonumber(Auction.createdAt);
    SanitizedAuction.itemID = tonumber(Auction.itemID);
    SanitizedAuction.price = Auction.price;

    --[[ Make sure the checksum is valid ]]
    local checksum = SanitizedAuction.createdAt .. GL:stringHash({ SanitizedAuction.itemID, SanitizedAuction.createdAt, table.concat(SanitizedAuction.CreatedBy, ".") });

    if (checksum ~= Auction.ID) then
        return false;
    end

    SanitizedAuction.ID = checksum;

    return SanitizedAuction;
end

--- Change the recipient of an auction
---
---@param sessionIdentifier string
---@param auctionID string
---@param winner string
---
---@return boolean
function GDKP:reassignAuction(sessionIdentifier, auctionID, winner)
    GL:debug("GDKP:reassignAuction");

    local OldAuction = GL.DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionID));

    if (not OldAuction
        or OldAuction.Winner.name == winner
    ) then
        return false;
    end

    winner = GL:capitalize(string.lower(winner));
    DB.GDKP.Ledger[sessionIdentifier].Auctions[auctionID].Winner.name = winner;

    Events:fire("GL.GDKP_AUCTION_CHANGED",
        sessionIdentifier,
        auctionID,
        OldAuction,
        DB.GDKP.Ledger[sessionIdentifier].Auctions[auctionID]
    );
    Events:fire("GL.GDKP_AUCTION_REASSIGNED", sessionIdentifier, OldAuction, winner);

    return true;
end

--- Move an auction from one session to another
---
---@param auctionID string
---@param fromSession string
---@param toSession string
---
---@return boolean
function GDKP:moveAuction(auctionID, fromSession, toSession)
    GL:debug("GDKP:moveAuction");

    -- There's nothing to move!
    if (fromSession == toSession) then
        return false;
    end

    local Auction = GL.DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", fromSession, auctionID));

    -- The auction doesn't exist
    if (not Auction) then
        return false;
    end

    -- The target session doesn't exist
    if (not GL.DB:get(string.format("GDKP.Ledger.%s", toSession))) then
        return false;
    end

    -- Copy the auction to its new location
    GL.DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", toSession, auctionID), Auction);

    -- Delete the original auction completely
    GL.DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", fromSession, auctionID), nil);

    Events:fire("GL.GDKP_AUCTION_CHANGED", toSession, auctionID, Auction, Auction);
    Events:fire("GL.GDKP_AUCTION_MOVED", Auction, fromSession, toSession);

    return true;
end

--- Check whether the current user is allowed to broadcast SoftRes data
---
---@return boolean
function GDKP:userIsAllowedToBroadcast()
    GL:debug("GDKP:userIsAllowedToBroadcast");

    return GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist);
end

--- Anounce to everyone in the raid that an auction is starting
---
---@param itemLink string
---@param minimumBid number
---@param minimumIncrement number
---@return void
function GDKP:announceStart(itemLink, minimumBid, minimumIncrement, duration, antiSnipe)
    GL:debug("GDKP:announceStart");

    duration = tonumber(duration or 0) or 0 > 0;
    antiSnipe = tonumber(antiSnipe or 0) or 0 > 0

    if (type(itemLink) ~= "string"
        or GL:empty(itemLink)
        or not GL:higherThanZero(duration)
        or antiSnipe < 0
    ) then
        GL:warning("Invalid data provided for GDKP auction start!");
        return false;
    end

    local itemID = GL:getItemIDFromLink(itemLink);
    if (not tonumber(itemID or 0) or 0 > 0
        or not GetItemInfoInstant(itemID)
    ) then
        GL:warning("Invalid item provided for GDKP auction start!");
        return false;
    end

    self:listenForBids();

    minimumBid = math.max(minimumBid, GL:tableGet(self.CurrentAuction, "TopBid.bid", 0));

    GL.CommMessage.new(
        CommActions.startGDKPAuction,
        {
            item = itemLink,
            minimumBid = minimumBid,
            minimumIncrement = minimumIncrement,
            duration = tonumber(duration),
            antiSnipe = tonumber(antiSnipe),
        },
        "GROUP"
    ):send();

    -- The user doesn't want to announce anything in chat
    if (not GL.Settings:get("GDKP.announceAuctionStart")) then
        return true;
    end

    local announceMessage = string.format("Bidding starts on %s. Minimum is %sg, increment is %sg. Use raid chat!",
        itemLink,
        minimumBid,
        minimumIncrement
    );

    GL:sendChatMessage(
        announceMessage,
        "GROUP"
    );

    return true;
end

--- Anounce to everyone in the raid that the auction has ended
---
---@return void
function GDKP:announceStop()
    GL:debug("GDKP:announceStop");

    GL.CommMessage.new(
        CommActions.stopGDKPAuction,
        nil,
        "GROUP"
    ):send();
end

--- Anounce to everyone in the raid that were extending the current auction
---
---@param time number
---@return void
function GDKP:announceExtension(time)
    GL:debug("GDKP:announceExtension");

    if (not tonumber(time or 0) or 0 > 0) then
        GL:warning("Invalid data provided for GDKP extension!");
        return false;
    end

    GL.CommMessage.new(
        CommActions.extendGDKPAuction,
        time,
        "GROUP"
    ):send();

    return true;
end

function GDKP:extend(CommMessage)
    GL:debug("GDKP:extend");

    if (not self.CurrentAuction.initiatorID
        or CommMessage.Sender.id ~= self.CurrentAuction.initiatorID
    ) then
        GL:debug("GDKP:extend received by non-initiator");
        return;
    end

    local time = CommMessage.content;

    if (not tonumber(time or 0) or 0 > 0) then
        return GL:error("Invalid time provided in GDKP:extend");
    end

    -- There appears to be no active auction
    if (not self.timerId) then
        return;
    end

    local secondsLeft = math.ceil(GL.Ace:TimeLeft(self.timerId) + tonumber(time));

    -- Make sure the extended time doesn't exceed the original duration
    secondsLeft = math.min(secondsLeft, self.CurrentAuction.duration),
    GL.Ace:CancelTimer(self.timerId);

    self.timerId = GL.Ace:ScheduleTimer(function ()
        self:stop();
    end, secondsLeft);

    GL.Interface.GDKP.Bidder:changeDuration(secondsLeft);

    SecondsAnnounced = {};
end

--- Start an auction
--- This is done via a CommMessage even for the masterlooter to make
--- sure that the auction starts simultaneously for everyone
---
---@param CommMessage CommMessage
function GDKP:start(CommMessage)
    GL:debug("GDKP:start");

    local content = CommMessage.content;

    --[[
        MAKE SURE THE PAYLOAD IS VALID
        PROVIDE VERY SPECIFIC ERROR MESSAGE IF IT'S NOT
    ]]
    if (not content) then
        return GL:error("Missing content in GDKP:start");
    end

    if (type(content) ~= "table") then
        return GL:error("Content is not a table in GDKP:start");
    end

    if (not content.duration
        or type(content.duration) ~= "number"
    ) then
        return GL:error("No duration provided in GDKP:start");
    end

    if (not content.item) then
        return GL:error("No item provided in GDKP:start");
    end

    --- We have to wait with starting the actual auction until
    --- the item that's up for bidding has been successfully loaded by the Item API
    ---
    ---@vararg Item
    ---@return void
    GL:onItemLoadDo(content.item, function (Items)
        local Entry = Items[1];

        if (GL:empty(Entry)) then
            return;
        end

        local duration = math.floor(tonumber(content.duration));
        local antiSnipe = math.floor(tonumber(content.antiSnipe));
        local SupportedBids = content.SupportedBids or {};
        local minimumBid = content.minimumBid or 0;
        local minimumIncrement = content.minimumIncrement or 1;

        -- This is a new auction so clean everything
        if (Entry.link ~= self.CurrentAuction.itemLink
            or CommMessage.Sender.id ~= self.CurrentAuction.initiatorID
        ) then
            -- This is a new item so make sure to
            -- override all previously set properties
            self.CurrentAuction = {
                antiSnipe = antiSnipe,
                duration = duration,
                initiatorID = CommMessage.Sender.id,
                initiatorName = CommMessage.Sender.name,
                itemIcon = Entry.icon,
                itemID = Entry.id,
                itemLink = Entry.link,
                itemName = Entry.name,
                minimumBid = minimumBid,
                minimumIncrement = minimumIncrement,

                Bids = {},
                TopBid = {},
            };
        else
            -- If we roll the same item again we do need to make
            -- sure that we update the roll timer
            self.CurrentAuction.time = duration;
        end

        self.inProgress = true;

        -- Don't show the bid UI if the user disabled it
        -- and the current user is not the one who initiated the auction
        if (GL.Settings:get("GDKP.showBidWindow")
            or self:startedByMe()
        ) then
            GL.Interface.GDKP.Bidder:show(duration, Entry.link, Entry.icon, content.note, SupportedBids);

            if (CommMessage.Sender.id == GL.User.id) then
                GL.Interface.GDKP.Auctioneer:drawReopenAuctioneerButton();
            end
        end

        -- Make sure the rolloff stops when time is up
        self.timerId = GL.Ace:ScheduleTimer(function ()
            self:stop();
        end, duration);

        -- Send a countdown in chat when enabled
        local numberOfSecondsToCountdown = GL.Settings:get("MasterLooting.numberOfSecondsToCountdown", 5);
        if (self:startedByMe() -- Only post a countdown if this user initiated the auction
            and duration > numberOfSecondsToCountdown -- No point in counting down if there's hardly enough time anyways
            and GL.Settings:get("MasterLooting.doCountdown", false)
        ) then
            self.countDownTimer = GL.Ace:ScheduleRepeatingTimer(function ()
                local secondsLeft = math.ceil(GL.Ace:TimeLeft(self.timerId));
                if (secondsLeft <= numberOfSecondsToCountdown
                    and secondsLeft > 0
                    and not SecondsAnnounced[secondsLeft]
                ) then
                    SecondsAnnounced[secondsLeft] = true;

                    GL:sendChatMessage(
                        string.format("%s seconds to roll", secondsLeft),
                        "GROUP"
                    );
                end
            end, 1);
        end

        -- Play raid warning sound
        GL:playSound(SOUNDKIT.RAID_WARNING, "SFX");

        -- Flash the game icon in case the player alt-tabbed
        FlashClientIcon();

        -- Items should only contain 1 item but lets add a return just in case
        return;
    end);
end

--- Check whether the current rolloff was started by me (the user)
---
---@return boolean
function GDKP:startedByMe()
    return self.CurrentAuction.initiatorID == GL.User.id;
end

--- Stop a roll off. This method can be invoked internally when the roll
--- off time is over or when announced by the initiation of the roll off.
---
---@param CommMessage string|nil
---@return boolean
function GDKP:stop(CommMessage)
    GL:debug("GDKP:stop");

    if (not self.inProgress) then
        return GL:warning("Can't stop auction, no auction in progress");
    end

    if (CommMessage
        and self.CurrentAuction.initiatorID ~= GL.User.id
        and CommMessage.Sender.id ~= self.CurrentAuction.initiatorID
    ) then
        if (self.CurrentAuction.initiatorID) then
            GL:warning(CommMessage.Sender.name .. " is not allowed to stop auction");
        else
            GL:warning(CommMessage.Sender.name .. " is not allowed to stop current auction: auction is invalid");
        end

        return false;
    end

    -- If this user started the roll then we need to cancel some timers and post a message
    if (self:startedByMe()) then
        -- Announce that the roll has ended
        if (GL.Settings:get("GDKP.announceBidsClosed", true)) then
            GL:sendChatMessage(
                string.format("Stop your bids!"),
                "RAID_WARNING"
            );
        end

        -- We stop listening for bids one second after the rolloff ends just in case there is server lag/jitter
        GL.Ace:ScheduleTimer(function()
            self:stopListeningForBids();
        end, 1);
    end

    if (self.countDownTimer) then
        GL.Ace:CancelTimer(self.countDownTimer);
        self.countDownTimer = nil;
    end

    -- Play raid warning sound
    GL:playSound(SOUNDKIT.RAID_WARNING, "SFX");

    self.inProgress = false;
    GL.Ace:CancelTimer(self.timerId);

    GL.Interface.GDKP.Bidder:hide();

    -- If we're the initiatorID then we need to update our initiatorID UI
    if (self:startedByMe()) then
        GL.Interface.GDKP.Auctioneer:updateWidgets();
    end

    return true;
end

--- Something changed, see if we need to change anything (UI elements, top bid etc)
---
---@param CommMessage string|nil
---@return void
function GDKP:refresh(CommMessage)
    -- Even if the auction is over we still want to update UI elements
    -- if needed, this is why we don't use self.inProgress here!
    if (GL:empty(self.CurrentAuction)) then
        return;
    end

    -- The user who sent the refresh our way is not permitted to do so
    if (CommMessage
        and CommMessage.Sender.id ~= self.CurrentAuction.initiatorID
    ) then
        return;
    end

    -- Check if there's a new highest bid
    local NewTopBid = GL:tableGet(CommMessage, "content.TopBid" or {});
    local OldTopBid = self.CurrentAuction.TopBid or {};

    if (GL:empty(OldTopBid.bid)) then
        OldTopBid = false;
    end

    -- Payload seems invalid, abort!
    if (GL:empty(NewTopBid)
        or not GL:higherThanZero(NewTopBid.bid)
    ) then
        return;
    end

    -- Valid bid, act accordingly!
    if (not OldTopBid or NewTopBid.bid > OldTopBid.bid) then
        -- It seems like we were outbid!
        if (OldTopBid and OldTopBid.Bidder.name
            and GL.User.name == OldTopBid.Bidder.name
            and OldTopBid.Bidder.name ~= NewTopBid.Bidder.name
        ) then
            Events:fire("GL.GDKP_USER_WAS_OUTBID", OldTopBid, NewTopBid);
        end

        self.CurrentAuction.TopBid = NewTopBid;
        GL.Interface.GDKP.Bidder:refresh();
    end
end

function GDKP:resetAuction()
    -- Reset the last auction. This happens when the master looter
    -- awards an item or when he clicks the "clear" button in the auctioneer window
    GL:debug("GDKP:resetAuction");

    -- All we need to do is reset the itemLink and let self:start() take care of the rest
    self.CurrentAuction.itemLink = "";
end

--- Start listening for rolls
---
---@return void
function GDKP:listenForBids()
    GL:debug("GDKP:listenForBids");

    -- Make sure the timer to cancel listening for rolls is cancelled
    if (self.bidListenerCancelTimerId) then
        GL.Ace:CancelTimer(self.bidListenerCancelTimerId);
    end

    if (self.listeningForBids) then
        return;
    end

    self.listeningForBids = true;

    Events:register({
        {"GDKPChatMsgWhisper", "CHAT_MSG_WHISPER"},
        {"GDKPChatMsgParty", "CHAT_MSG_PARTY"},
        {"GDKPChatMsgPartyLeader", "CHAT_MSG_PARTY_LEADER"},
        {"GDKPChatMsgRaid", "CHAT_MSG_RAID"},
        {"GDKPChatMsgRaidLeader", "CHAT_MSG_RAID_LEADER"},
    }, function (event, message, sender)
        self:processBid(event, message, sender);
    end);
end

--- Unregister the CHAT_MSG_SYSTEM to stop listening for rolls
---
---@return void
function GDKP:stopListeningForBids()
    GL:debug("GDKP:stopListeningForBids");

    if (self.bidListenerCancelTimerId) then
        GL.Ace:CancelTimer(self.bidListenerCancelTimerId);
    end

    self.listeningForBids = false;
    Events:unregister({
        "GDKPChatMsgWhisper",
        "GDKPChatMsgParty",
        "GDKPChatMsgPartyLeader",
        "GDKPChatMsgRaid",
        "GDKPChatMsgRaidLeader",
    });
end

--- Fetch a GDKP session by its identifier
---
---@param ID string
---@return table|nil
function GDKP:getSessionByID(ID)
    GL:debug("GDKP:sessionByID");

    if (not ID) then
        return;
    end

    return DB:get("GDKP.Ledger." .. ID);
end

function GDKP:bid(message)
    GL:debug("GDKP:bid");

    -- There's no auction in progress
    if (not self.inProgress) then
        return false;
    end

    local lowestValidBid = self:lowestValidBid();

    message = message:gsub("%,", ".");

    local bid = self:messageToBid(message, lowestValidBid);

    if (not GL:higherThanZero(bid)) then
        return false;
    end

    -- The given bid is invalid or not higher than the highest known bid
    if (not GL:higherThanZero(bid)
        or bid < lowestValidBid
    ) then
        return false;
    end

    if (GL.User.isInGroup) then
        GL:sendChatMessage(bid, "GROUP", nil, nil, false);
    else
        GL:sendChatMessage(bid, "WHISPER", nil, self.CurrentAuction.initiatorName, false);
    end
end

--- Return the lowest possible valid bid based on the current bid or the minimum price
---
---@return number
function GDKP:lowestValidBid()
    return math.max(
        GL:tableGet(self.CurrentAuction, "TopBid.bid", 0) + (self.CurrentAuction.minimumIncrement or 0),
        self.CurrentAuction.minimumBid
    );
end

function GDKP:processBid(event, message, bidder)
    GL:debug("GDKP:processBid");

    message = string.lower(message);

    -- This is a message generated by gargul, skip it
    if (GL:strStartsWith(message, "{rt3} gargul :")) then
        return;
    end

    ---@todo set to false
    --local acceptClosedBids = false;
    local acceptClosedBids = true;

    -- We only accept bids in /w when we're accepting closed bids or when we're not in a group (e.g. testing)
    if (event == "CHAT_MSG_WHISPER"
        and not acceptClosedBids
        and GL.User.isInGroup)
    then
        local response = "I'm not accepting closed bids, use the /ra channel instead!";

        if (not GL.User.isInRaid) then
            response = "I'm not accepting closed bids, use the /gr channel instead!";
        end

        GL:sendChatMessage(response, "WHISPER", nil, bidder);

        return;
    end

    local bid = self:messageToBid(message, self:lowestValidBid());

    if (not GL:higherThanZero(bid)) then
        return;
    end

    --- Make sure the person who bid is in our group
    local BidEntry = false;
    for _, Member in pairs(GL.User:groupMembers(true)) do
        if (GL:stripRealm(bidder) == GL:stripRealm(Member.name)) then
            local Player = GL.Player:fromName(Member.name);
            local playerName, realm = GL:stripRealm(bidder);

            BidEntry = {
                Bidder = {
                    class = Player.class,
                    guild = Player.Guild.name,
                    name = playerName,
                    race = Player.race,
                    realm = realm,
                    uuid = Player.id,
                },
                bid = bid,
                createdAt = GetServerTime(),
            };

            break;
        end
    end

    if (not BidEntry) then
        return;
    end

    if (self.CurrentAuction
        and self.CurrentAuction.antiSnipe
    ) then
        local secondsLeft = math.floor(GL.Ace:TimeLeft(self.timerId));

        if (secondsLeft <= self.CurrentAuction.antiSnipe) then
            self:announceExtension(self.CurrentAuction.antiSnipe);
        end
    end

    -- Determine the minimum bid
    local minimumBid = math.max(
        self.CurrentAuction.minimumBid,
        GL:tableGet(self.CurrentAuction, "TopBid.bid", 0) + self.CurrentAuction.minimumIncrement
    );

    -- The bid is not high enough for us to accept
    if (BidEntry.bid < minimumBid) then
        GL:sendChatMessage(string.format("Bid denied, the minimum bid is %sg", minimumBid), "WHISPER", nil, bidder);
        return;
    end

    GL:sendChatMessage(string.format("%s is the highest bidder (%sg)", BidEntry.Bidder.name, bid), "GROUP");

    tinsert(self.CurrentAuction.Bids, BidEntry);
    GL.Interface.GDKP.Auctioneer:refreshRollsTable();

    local OldTopBid = self.CurrentAuction.TopBid;
    self.CurrentAuction.TopBid = BidEntry;
    Events:fire("GL.GDKP_BID_ACCEPTED", OldTopBid, BidEntry);
end

--- Transform a given message to a bid if possible
---
---@param message string
---@return number
function GDKP:messageToBid(message, minBid)
    message = message:gsub("%,", ".");

    local onlyAcceptRoundNumbers = true;
    local match = message:match("(%d*%.?%d+)");

    if (GL:empty(match)) then
        return 0;
    end

    local bid = tonumber(match);
    local kModifier = message:find("%d+k");

    local distance = GL:levenshtein(match, message);

    -- Determine whether someone meant to add "k" after a message
    if (distance == 0
        and minBid >= 500 -- Only if the minimum bid is 500 or more
        and bid < minBid -- Only if the bid is lower than the minimum bid
        and bid <= 100 -- Only if the bid is 1 through 100 (if someone wants to bid 100k then he can write 101k)
        and (bid * 1000) / minBid <= 2.5 -- Only if the bid*1000 is ste (<=) the current minimum bid x 2.5
    ) then
        kModifier = true;
    elseif (distance > 7) then
        return 0;
    end

    if (kModifier) then
        bid = bid * 1000;
    end

    if (onlyAcceptRoundNumbers) then
        bid = GL:round(bid);
    end

    return bid;
end

GL:debug("GDKP.lua");