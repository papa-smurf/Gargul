local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type GDKP
local GDKP = GL.GDKP;

---@type DB
local DB = GL.DB;

---@type Settings
local Settings = GL.Settings;

---@type Events
local Events = GL.Events;

---@type Data
local Constants = GL.Data.Constants;
local CommActions = Constants.Comm.Actions;

local SecondsAnnounced = {};

---@type GDKPAuctioneerInterface
local Auctioneer;

---@class GDKPAuction
GDKP.Auction = {
    _broadcastingDisabled = false,
    _initialized = false,
    autoBiddingIsActive = nil,
    lastBidAt = nil,
    lastBidAnnouncementAt = 0,
    lastBidReceivedAt = 0,
    maxBid = nil,
    raidWarningThrottler = nil,
    waitingForReschedule = false,
    waitingForStart = false,

    AutoBidTimer = nil,
    BidListenerCancelTimerID = nil,
    Current = {
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
    Queue = {},
    QueueBroadcastTimer = nil,
    QueuedItemAutoBids = {},
};

---@type GDKPAuction
local Auction = GDKP.Auction;

---@type GDKPSession
local GDKPSession = GDKP.Session;

--[[ CONSTANTS ]]
local AUTO_BID_THROTTLE_IN_SECONDS = .6;
local BROADCAST_QUEUE_DELAY_IN_SECONDS = 3;

---@return nil
function Auction:_init()
    if (self._initialized) then
        return false;
    end

    Auctioneer = GL.GDKP.Auctioneer or {};

    -- An event is fired whenever a bid is accepted, in which case we broadcast the latest auction details
    Events:register("GDKPAuctionBidAccepted", "GL.GDKP_BID_ACCEPTED", function ()
        Auctioneer:refreshBidsTable();
        GL.Interface.GDKP.Bidder:refresh();
    end);

    -- Whenever we were outbid we show a notification
    Events:register("GDKPAuctionUserWasOutBid", "GL.GDKP_USER_WAS_OUTBID", function ()
        self:userWasOutBidHandler();
    end);

    Events:register("GDKPAuctionFirstBidAccepted", "GL.GDKP_FIRST_BID_ACCEPTED", function ()
        self:firstBidHandler();
    end);

    -- Clear the queue when we don't have an active GDKP session
    GL.Events:register("GDKPAuctionUserLeftGroup", "GL.USER_LEFT_GROUP", function ()
        if (not GDKPSession:activeSessionID()) then
            self.Queue = {};
        end
    end);

    -- Store our queue when we reload/log out
    GL.Events:register("GDKPAuctionPlayerLogout", "PLAYER_LOGOUT", function ()
        if (not GDKPSession:activeSessionID()) then
            self.Queue = {};
        end
        DB:set("GDKP.Queue", self.Queue or {});
    end);
    self.Queue = DB:get("GDKP.Queue", {});
    GL.Ace:ScheduleTimer(function ()
        self:_initializeQueue();
    end, 1);

    self._initialized = true;
    return true;
end

--- Add items back to the queue after a reload or logout
---
---@return nil
function Auction:_initializeQueue()
    -- We're not allowed to populate the queue
    if (not Auctioneer:allowedToBroadcast()
        or (GL.User.isInGroup
            and GL.GetLootMethod() == "master"
            and not GL.User.isMasterLooter
        )
    ) then
        return;
    end

    self._broadcastingDisabled = true;
    local SortedQueue = GL:tableValues(Auction.Queue);
    table.sort(SortedQueue, function (a, b)
        if (a.order and b.order) then
            return a.order < b.order;
        end

        return false;
    end);

    local i = 1;
    self.Queue = {};
    local QueueAddTimer;
    -- Add items in intervals to alleviate UI/performance strain
    QueueAddTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        GL:debug("Run Auction._initializeQueue");
        local Queued = SortedQueue[i];
        if (not Queued) then
            GL:debug("Cancel Auction._initializeQueue");
            GL.Ace:CancelTimer(QueueAddTimer);
            SortedQueue = nil;

            self._broadcastingDisabled = false;

            GL.Events:fire("GL.GDKP_QUEUE_UPDATED");

            -- Make sure to broadcast the queue when everything's said and done
            if (i > 1) then
                self:broadcastQueue();
            end

            return;
        end

        i = i + 1;
        return Auctioneer:addToQueue(Queued.itemLink, Queued.identifier, false);
    end, .1);
end

---@return nil
function Auction:firstBidHandler()
    -- We're the top bidder, no need to panic
    if (self:userIsTopBidder()) then
        return;
    end

    self:autoBid();
end

---@return nil
function Auction:userWasOutBidHandler()
    -- Looks like we got here for no good reason
    if (self:userIsTopBidder()) then
        return;
    end

    -- No reason for panic, autobid was successful
    if (self:autoBid()) then
        return;
    end

    -- Flash the game icon in case the player alt-tabbed
    FlashClientIcon();

    -- We don't want to spam the user with alerts!
    if (self.lastOutBidNotificationShownAt
        and GetServerTime() - self.lastOutBidNotificationShownAt <= 8
    ) then
        return;
    end

    local outbidSound = GL.Settings:get("GDKP.outbidSound");
    if (not GL:empty(outbidSound)) then
        local sound = LibStub("LibSharedMedia-3.0"):Fetch("sound", outbidSound);
        GL:playSound(sound);
    end

    self.lastOutBidNotificationShownAt = GetServerTime();
    GL.Interface.Alerts:fire("GargulNotification", {
        message = "|c00BE3333" .. L["You were outbid!"] .. "|r",
    });
end

--- Create an auction
---
---@param itemLinkOrID string|number
---@param price number
---@param winner string
---@param sessionID string
---@param Bids table
---@param note string
---
---@return boolean
function Auction:create(itemLinkOrID, price, winner, sessionID, Bids, note, awardChecksum)
    if ((not sessionID
        or (sessionID and not GDKPSession:exists(sessionID))
    ) and not GDKPSession:activeSessionID()
    ) then
        GL:warning((L["Unknown sessionIdentifier in Auction:create: %s"]):format(tostring(sessionID)));
        return false;
    end

    local itemID = tonumber(itemLinkOrID);
    local itemLink = not itemID and itemLinkOrID or nil;
    itemID = itemID or GL:getItemIDFromLink(itemLink);

    if (not GL:higherThanZero(itemID)) then
        GL:warning((L["Unknown itemID in Auction:create: %s"]):format(tostring(itemID)));
        return false;
    end

    sessionID = sessionID or GDKPSession:activeSessionID();
    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning(L["The GDKP Session is not available or locked"]);
        return;
    end

    note = note and strtrim(note) or nil;
    local Instance = {
        price = price,
        itemID = itemID,
        itemLink = itemLink,
        createdAt = GetServerTime(),
        note = note ~= "" and note or nil,
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

    Instance.Winner = {
        class = Winner.class,
        guild = Winner.Guild.name,
        name = Winner.name or winner,
        race = Winner.race,
        realm = Winner.realm or GL.User.realm,
        uuid = Winner.id,
    };
    Instance.Winner.guid = GDKP:playerGUID(Instance.Winner.name, Instance.Winner.realm);

    local checksum = Instance.createdAt .. GL:stringHash{ Instance.itemID, Instance.createdAt, table.concat(Instance.CreatedBy, "."), GL:uuid() };
    Instance.ID = checksum;

    -- Something is wrong with the Auction. Tampering maybe? RETURN!
    Instance = self:sanitize(Instance);
    if (not Instance) then
        return false;
    end

    if (awardChecksum and DB:get("AwardHistory." .. awardChecksum)) then
        Instance.awardChecksum = awardChecksum;
    end

    if (not Instance.itemLink) then
        GL:onItemLoadDo(itemID, function (Details)
            if (not Details) then
                return;
            end

            Instance.itemLink = Details.link;
            GL:tableSet(Session, "Auctions." .. checksum, Instance);

            Events:fire("GL.GDKP_AUCTION_CHANGED", sessionID, checksum, {}, Instance);
            Events:fire("GL.GDKP_AUCTION_CREATED", sessionID, checksum);
        end);
    else
        GL:tableSet(Session, "Auctions." .. checksum, Instance);
        Events:fire("GL.GDKP_AUCTION_CHANGED", sessionID, checksum, {}, Instance);
        Events:fire("GL.GDKP_AUCTION_CREATED", sessionID, checksum);
    end

    -- Make sure we invalidate this item's history
    GDKPSession.ItemHistory[itemID] = nil;

    return true;
end

---@param sessionID string
---@param auctionID string
---
---@return nil
function Auction:delete(sessionID, auctionID, reason)
    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning(L["The GDKP Session is not available or locked"]);
        return;
    end

    local Instance = GL:tableGet(Session, "Auctions." .. auctionID);

    -- The auction could not be found or is already deleted
    if (not Instance or not Instance.price) then
        return false;
    end

    Instance.PreviousStates = Instance.PreviousStates or {};

    local PreviousState = {
        createdAt = GetServerTime(),
        price = Instance.price,
        CreatedBy = {
            class = GL.User.class,
            name = GL.User.name,
            guild = GL:tableGet(GL.User, "Guild.name") or nil,
            uuid = GL.User.id,
        },
        Winner = Instance.Winner,
    };

    -- Add a state so we can restore later if needed
    tinsert(Instance.PreviousStates, PreviousState);

    Instance.Winner = nil;
    Instance.price = nil;
    Instance.reason = tostring(reason);

    if (Instance.awardChecksum) then
        GL.AwardedLoot:deleteWinner(Instance.awardChecksum);
    end

    -- We don't point to Auction here, we want a copy not a pointer!
    local Before = GL:tableGet(Session, "Auctions." .. auctionID);
    GL:tableSet(Session, "Auctions." .. auctionID, Instance);

    Events:fire("GL.GDKP_AUCTION_CHANGED", sessionID, auctionID, Before, Instance);
    Events:fire("GL.GDKP_AUCTION_DELETED", sessionID, auctionID, Instance);

    return true;
end

---@param sessionID string
---@param auctionID string
---
---@return nil
function Auction:restore(sessionID, auctionID)
    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning(L["The GDKP Session is not available or locked"]);
        return;
    end

    local Instance = GL:tableGet(Session, "Auctions." .. auctionID);

    -- The auction could not be found or is not deleted
    if (not Instance or Instance.price) then
        return false;
    end

    -- Sort the states on createdAt so that we can get the most recent state
    table.sort(Instance.PreviousStates or {}, function (a, b)
        if (not tonumber(a.createdAt)
            or not tonumber(b.createdAt)
        ) then
            return true;
        end

        return tonumber(a.createdAt) > tonumber(b.createdAt);
    end);

    local mostRecentStateIdentifier;
    local MostRecentState;
    for stateIdentifier, State in pairs(Instance.PreviousStates or {}) do
        mostRecentStateIdentifier = stateIdentifier;
        MostRecentState = State;

        break;
    end

    -- Better safe than lua error
    if (GL:empty(MostRecentState)) then
        return false;
    end

    Instance.Winner = MostRecentState.Winner;
    Instance.price = MostRecentState.price;
    Instance.guild = MostRecentState.guild;

    -- Remove the restored state from the previous states table
    Instance.PreviousStates[mostRecentStateIdentifier] = nil;

    Instance.awardChecksum = GL.AwardedLoot:addWinner({
        announce = false,
        broadcast = false,
        gdkpCost = Instance.price,
        itemLink = Instance.itemLink,
        winner = Instance.Winner.guid,
    });

    -- We don't point to Auction here, we want a copy not a pointer!
    local Before = GL:tableGet(Session, "Auctions." .. auctionID);
    GL:tableSet(Session, "Auctions." .. auctionID, Instance);

    Events:fire("GL.GDKP_AUCTION_CHANGED", sessionID, auctionID, Before, Instance);
    Events:fire("GL.GDKP_AUCTION_RESTORED", sessionID, auctionID, Instance);

    return true;
end

--- Store the currently active auction in the session ledger
---
---@param winner string
---@param bid number
---@param awardChecksum string|nil
---@return boolean
function Auction:storeCurrent(winner, bid, awardChecksum)
    local Instance = GL.GDKP.Auction.Current or {};

    if (type(Instance) ~= "table"
        or GL:empty(Instance)
        or not Instance.itemLink
        or tonumber(GL:tableGet(Instance, "TopBid.bid", 0)) <= 0
        or GL:empty(GL:tableGet(Instance, "TopBid.Bidder.name"))
    ) then
        return false;
    end

    winner = winner or Instance.TopBid.Bidder.name;
    bid = bid or Instance.TopBid.bid;

    local itemID = GL:getItemIDFromLink(GL.GDKP.Auction.Current.itemLink);

    -- Make sure the item is valid
    if (not GL:higherThanZero(itemID)
        or not GL:higherThanZero(GetItemInfoInstant(GL.GDKP.Auction.Current.itemLink))
    ) then
        GL:warning((L["Unknown itemID in Auction:create: %s"]):format(tostring(itemID)));
        return false;
    end

    local HighestBidPerPlayer = {};
    for _, Bid in pairs(Instance.Bids or {}) do
        (function ()
            local bidder = GDKP:playerGUID(Bid.Bidder.name, Bid.Bidder.realm);

            if (not HighestBidPerPlayer[bidder]) then
                HighestBidPerPlayer[bidder] = {};
            end

            if (GL:lt(HighestBidPerPlayer[bidder].bid or 0, Bid.bid)) then
                HighestBidPerPlayer[bidder] = Bid;
            end
        end)();
    end

    return self:create(GL.GDKP.Auction.Current.itemLink, bid, winner, nil, HighestBidPerPlayer, nil, awardChecksum);
end

---@param Instance table
---@return nil
function Auction:sanitize(Instance)
    local SanitizedAuction = {
        itemLink = Instance.itemLink,
    };

    Instance.price = tonumber(Instance.price);

    --[[ Top level Auction check ]]
    if (not Instance
        or type(Instance) ~= "table"
        or type(Instance.CreatedBy) ~= "table"
        or (Instance.Winner and type(Instance.Winner) ~= "table")
        or (Instance.Bids and type(Instance.Bids) ~= "table")
        or date("%Y", tonumber(Instance.createdAt) or 0) == "1970"
        or not tonumber(Instance.itemID)
        or not tonumber(Instance.price)
        or not Instance.price
        or Instance.price == 0
    ) then
        GL:xd("Auction:sanitize step 1 failed, contact support!");
        return false;
    end

    --[[ Auction.CreatedBy ]]
    if (type (Instance.CreatedBy.class) ~= "string"
        or type (Instance.CreatedBy.name) ~= "string"
        or GL:empty(Instance.CreatedBy.name)
        or type (Instance.CreatedBy.race) ~= "string"
        or type (Instance.CreatedBy.uuid) ~= "string"
        or not strmatch(Instance.CreatedBy.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
        or type (Instance.CreatedBy.realm) ~= "string"
        or GL:empty(Instance.CreatedBy.realm)
    ) then
        GL:xd("Auction:sanitize step 2 failed, contact support!");
        GL:xd(Instance);
        return false;
    end

    SanitizedAuction.CreatedBy = {
        class = tostring(Instance.CreatedBy.class),
        name = tostring(Instance.CreatedBy.name),
        race = tostring(Instance.CreatedBy.race),
        realm = tostring(Instance.CreatedBy.realm),
        uuid = tostring(Instance.CreatedBy.uuid),
    };

    -- Add the winner's guild if he was part of one
    local createdByGuild = Instance.CreatedBy.guild;

    if (createdByGuild) then
        if (type(createdByGuild) ~= "string"
            or GL:empty(createdByGuild)
        ) then
            GL:xd("Auction:sanitize step 3 failed, contact support!");
            return;
        end

        SanitizedAuction.CreatedBy.guild = strtrim(createdByGuild);
    end

    --[[ Make sure the item ID is valid ]]
    SanitizedAuction.itemID = GL.GetItemInfoInstant(Instance.itemID);
    if (not tonumber(SanitizedAuction.itemID)) then
        GL:xd("Auction:sanitize step 4 failed, contact support!");
        return false;
    end

    --[[ Auction.Bids ]]
    if (Instance.Bids) then
        for key, Bid in pairs(Instance.Bids) do
            if (type(Bid) ~= "table"
                or type(Bid.Bidder) ~= "table"
                or not tonumber(Bid.bid or 0)
                or GL:lt(Bid.bid, .0001)
                or date("%Y", tonumber(Bid.createdAt) or 0) == "1970"
            ) then
                GL:xd("Auction:sanitize step 5 failed, contact support!\n" .. GL.JSON:encode(Bid));
                return false;
            end

            local Bidder = Bid.Bidder;

            -- Make sure the bidder always contains a valid realm (defaults to current player's realm)
            if (not Bidder.realm or GL:empty(Bidder.realm)) then
                Bidder.realm = GL.User.realm;
            end

            if (type (Bidder.class) ~= "string"
                or type (Bidder.name) ~= "string"
                or GL:empty(Bidder.name)
                or type (Bidder.race) ~= "string"
                or type (Bidder.uuid) ~= "string"
                or not strmatch(Bidder.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
                or type (Bidder.realm) ~= "string"
                or GL:empty(Bidder.realm)
            ) then
                GL:xd("Auction:sanitize step 6 failed, contact support!\n" .. GL.JSON:encode(Bidder));
                return false;
            end

            -- Make sure we only maintain valid keys
            SanitizedAuction.Bids = SanitizedAuction.Bids or {};
            SanitizedAuction.Bids[key] = {
                Bidder = {
                    class = tostring(Bidder.class),
                    guild = tostring(Bidder.guild),
                    name = tostring(Bidder.name),
                    race = tostring(Bidder.race),
                    realm = tostring(Bidder.realm),
                    uuid = tostring(Bidder.uuid),
                },
                bid = tonumber(Bid.bid),
                bidder = tostring(Bid.bidder),
                createdAt = tonumber(Bid.createdAt),
            };

            -- Add the player's guild if he was part of one
            local guild = Bidder.guild;

            if (guild) then
                if (type(guild) ~= "string"
                    or GL:empty(guild)
                ) then
                    GL:xd("Auction:sanitize step 7 failed, contact support!");
                    return;
                end

                SanitizedAuction.Bids[key].guild = strtrim(guild);
            end
        end
    end

    --[[ Auction.Winner ]]
    if (Instance.Winner) then
        local Winner = Instance.Winner;

        if (type(Winner) ~= "table"
            or (not GL:empty(Winner.race) and (
                type(Winner.race) ~= "string"
            ))
            or (not GL:empty(Winner.class) and (
                type(Winner.class) ~= "string"
            ))
            or (not GL:empty(Winner.uuid) and (
                type(Winner.uuid) ~= "string"
                or not strmatch(Winner.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
            ))
            or (not GL:empty(Winner.realm) and
                type(Winner.realm) ~= "string"
            )
            or type (Winner.name) ~= "string"
            or GL:empty(Winner.name)
        ) then
            GL:xd("GDKP:sanitize step 8 failed, contact support!\n" .. GL.JSON:encode(Winner));
            return;
        end

        SanitizedAuction.Winner = {
            race = tostring(Winner.race);
            name = tostring(Winner.name);
            class = tostring(Winner.class);
            uuid = tostring(Winner.uuid);
            realm = tostring(Winner.realm);
            guid = Winner.guid or GDKP:playerGUID(Winner.name, Winner.realm);
        };

        -- Add the winner's guild if he was part of one
        local guild = Winner.guild;

        if (guild) then
            if (type(guild) ~= "string"
                    or GL:empty(guild)
            ) then
                GL:xd("Auction:sanitize step 9 failed, contact support!\n" .. GL.JSON:encode(Winner));
                return;
            end

            SanitizedAuction.Winner.guild = strtrim(guild);
        end
    end

    SanitizedAuction.createdAt = tonumber(Instance.createdAt);
    SanitizedAuction.itemID = tonumber(Instance.itemID);
    SanitizedAuction.price = tonumber(Instance.price);
    SanitizedAuction.note = Instance.note;

    if (not GL:strStartsWith(Instance.ID, SanitizedAuction.createdAt)) then
        GL:xd("Auction:sanitize step 10 failed, contact support!");
        return false;
    end

    SanitizedAuction.ID = Instance.ID;
    return SanitizedAuction;
end

--- Change the recipient of an auction
---
---@param sessionID string
---@param auctionID string
---@param winner string
---
---@return boolean
function Auction:reassignAuction(sessionID, auctionID, winner)
    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning(L["The GDKP Session is not available or locked"]);
        return;
    end

    local winnerGUID = GDKP:playerGUID(winner);
    local _, winnerRealm = GL:stripRealm(winnerGUID);
    local OldAuction = GL:tableGet(Session, "Auctions." .. auctionID);

    if (not OldAuction
        or OldAuction.Winner.guid == winnerGUID
    ) then
        return false;
    end

    local Winner = GL.Player:fromName(winner) or {};
    Winner.Guild = Winner.Guild or {};
    Winner = {
        class = Winner.class,
        guild = Winner.Guild.name,
        name = Winner.name or winner,
        race = Winner.race,
        realm = Winner.realm or winnerRealm,
        uuid = Winner.id,
        guid = winnerGUID,
    };

    GL:tableSet(Session, ("Auctions.%s.Winner"):format(auctionID), Winner);

    if (OldAuction.awardChecksum) then
        GL.AwardedLoot:editWinner(OldAuction.awardChecksum, winner);
    end

    Events:fire("GL.GDKP_AUCTION_CHANGED",
        sessionID,
        auctionID,
        OldAuction,
        DB.GDKP.Ledger[sessionID].Auctions[auctionID]
    );
    Events:fire("GL.GDKP_AUCTION_REASSIGNED", sessionID, OldAuction, winnerGUID);

    return true;
end

---@param sessionID string
---@param auctionID string
---@param note string
---@return nil
function Auction:setNote(sessionID, auctionID, note)
    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning(L["The GDKP Session is not available or locked"]);
        return;
    end

    local OldAuction = GL:tableGet(Session, "Auctions." .. auctionID);

    if (not OldAuction
        or OldAuction.note == note
    ) then
        return false;
    end

    note = note and strtrim(note) or nil;
    GL:tableSet(Session, ("Auctions.%s.note"):format(auctionID), note ~= "" and note or nil);

    Events:fire("GL.GDKP_AUCTION_CHANGED",
        sessionID,
        auctionID,
        OldAuction,
        DB.GDKP.Ledger[sessionID].Auctions[auctionID]
    );

    return true;
end

---@param sessionID string
---@param auctionID string
---@param paid number
---@return nil
function Auction:setPaid(sessionID, auctionID, paid)
    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning(L["The GDKP Session is not available or locked"]);
        return;
    end

    paid = tonumber(paid);

    if (not paid) then
        GL:warning(L["Invalid number provided for 'paid'"]);
        return;
    end

    local OldAuction = GL:tableGet(Session, "Auctions." .. auctionID);

    if (not OldAuction or OldAuction.paid == paid) then
        return false;
    end

    GL:tableSet(Session, ("Auctions.%s.paid"):format(auctionID), paid);

    Events:fire("GL.GDKP_AUCTION_CHANGED",
        sessionID,
        auctionID,
        OldAuction,
        DB.GDKP.Ledger[sessionID].Auctions[auctionID]
    );

    return true;
end

--- Move an auction from one session to another
---
---@param auctionID string
---@param fromSessionID string
---@param toSessionID string
---
---@return boolean
function Auction:move(auctionID, fromSessionID, toSessionID)
    -- There's nothing to move!
    if (fromSessionID == toSessionID) then
        return false;
    end

    local FromSession = GDKPSession:byID(fromSessionID);
    if (not FromSession or FromSession.lockedAt) then
        GL:warning(L["The GDKP Session is not available or locked"]);
        return false;
    end

    local ToSession = GDKPSession:byID(toSessionID);
    if (not ToSession or ToSession.lockedAt) then
        GL:warning(L["The GDKP Session is not available or locked"]);
        return false;
    end

    local Instance = GL:tableGet(FromSession, "Auctions." .. auctionID);
    if (not Instance) then
        return false;
    end

    GL:tableSet(ToSession, "Auctions." .. auctionID, Instance);
    GL:tableSet(FromSession, "Auctions." .. auctionID, nil);

    Events:fire("GL.GDKP_AUCTION_CHANGED", toSessionID, auctionID, Instance, Instance);
    Events:fire("GL.GDKP_AUCTION_MOVED", Instance, fromSessionID, toSessionID);

    return true;
end

---@param itemLink string
---@return nil
function Auction:addToQueue(itemLink, identifier)
    GL:onItemLoadDo(itemLink, function (Details)
        if (not Details) then
            return;
        end

        local PerItemSettings = GDKP:settingsForItemID(Details.id);
        self.Queue[identifier] = {
            identifier = identifier,
            increment = PerItemSettings.increment,
            itemID = Details.id,
            itemLink = itemLink,
            minimumBid = PerItemSettings.minimum,
            order = GL:count(self.Queue) + 1,
        };

        self:broadcastQueue();
    end);
end

---@param checksum string
---@param toChecksum string
---@return boolean
function Auction:reorderQueueItem(checksum, toChecksum)
    local QueuedItem = self.Queue[checksum];
    local ToItem = self.Queue[toChecksum];

    if (not QueuedItem or not ToItem) then
        return false;
    end

    local to = ToItem.order;
    local originalPosition = QueuedItem.order;
    if (to == originalPosition) then
        return false;
    end

    if (originalPosition < to) then
        to = to + 1;
    end

    for key, Entry in pairs(self.Queue or {}) do

        -- Item moved down the list
        if (originalPosition < to) then
            if (Entry.order > originalPosition
                and Entry.order < to
            ) then
                Entry.order = Entry.order - 1;
            end

        -- Item moved up the list
        else
            if (Entry.order >= to
                and Entry.order < originalPosition
            ) then
                Entry.order = Entry.order + 1;
            end
        end

        self.Queue[key] = Entry;
    end

    if (originalPosition < to) then
        self.Queue[checksum].order = to - 1;
    else
        self.Queue[checksum].order = to;
    end

    self:broadcastQueue();

    return true;
end

---@param position number
---@return table
function Auction:QueuedItemByPosition(position)
    for _, Entry in pairs(self.Queue or {}) do
        if (Entry.order == position) then
            return Entry;
        end
    end
end

---@param checksum string
---@return boolean
function Auction:removeFromQueue(checksum)
    if (not self.Queue[checksum or 0]) then
        return false;
    end

    local removeOrder = self.Queue[checksum].order;
    for key, Entry in pairs(self.Queue or {}) do
        if (Entry.order > removeOrder) then
            Entry.order = Entry.order - 1;
            self.Queue[key] = Entry;
        end
    end

    self.Queue[checksum] = nil;
    self:broadcastQueue();

    return true;
end

---@return nil
function Auction:clearQueue()
    self.Queue = {};
    self:broadcastQueue(true);
end

---@return nil
function Auction:sanitizeQueue()
    local Sanitized = {};

    for _, QueuedItem in pairs(self.Queue or {}) do
        if (type(QueuedItem) == "table"
            and type(QueuedItem.itemLink) == "string"
        ) then
            tinsert(Sanitized, QueuedItem);
        end
    end

    --[[ MAKE SURE THE ORDER IS INCREMENTAL ]]
    table.sort(Sanitized, function (a, b)
        if (a.order and b.order) then
            return a.order < b.order;
        end

        return false;
    end);

    self.Queue = {};
    local order = 1;
    for _, Queued in pairs(Sanitized or {}) do
        Queued.order = order;
        self.Queue[Queued.identifier] = Queued;

        order = order + 1;
    end
end

--- Broadcast the first 20 items to everyone in the raid
---@return nil
function Auction:broadcastQueue(immediately)
    -- Broadcasting is
    if (self._broadcastingDisabled) then
        return;
    end

    GL.Ace:CancelTimer(self.QueueBroadcastTimer);
    self:sanitizeQueue();

    if (not Auctioneer:allowedToBroadcast()) then
        return;
    end

    -- Make sure we only broadcast the first 15 items as to not overload the system
    local SortedQueue = GL:tableValues(Auction.Queue);
    table.sort(SortedQueue, function (a, b)
        if (a.order and b.order) then
            return a.order < b.order;
        end

        return false;
    end);

    local QueueSegment = {};
    local i = 0;
    for _, Details in pairs(SortedQueue) do

        i = i + 1;

        -- Trim down the queue details in order to minimize the comm payload
        tinsert(QueueSegment, {
            Details.identifier,
            Details.itemID,
            Details.minimumBid,
            Details.order,
            Details.increment,
        });

        -- A queue of more than a 100 items makes no sense
        if (i > 100) then
            break;
        end
    end

    local broadcast = function ()
        GL.CommMessage.new({
            action = CommActions.broadcastGDKPAuctionQueue,
            content = QueueSegment or {},
            channel = "GROUP",
        }):send();
    end;

    if (immediately) then
        broadcast();
        return;
    end

    self.QueueBroadcastTimer = GL.Ace:ScheduleTimer(function ()
        broadcast();
    end, BROADCAST_QUEUE_DELAY_IN_SECONDS);
end

---@return nil
function Auction:receiveQueue(CommMessage)
    -- No need to override our own queue
    if (CommMessage.Sender.isSelf) then
        Events:fire("GL.GDKP_QUEUE_UPDATED");
        return;
    end

    if (type(CommMessage.content) ~= "table") then
        return;
    end

    if (not Auctioneer:allowedToBroadcast(CommMessage.Sender.id)) then
        return;
    end

    local Queue = {};

    -- Check if this is the old format including item links
    local itemLinksArePresent = true;
    for _, Details in pairs(CommMessage.content or {}) do
        itemLinksArePresent = not not Details.itemLink;
    end

    -- Old format, no need to continue
    if (itemLinksArePresent) then
        self.Queue = Queue;
        self:sanitizeQueue();

        Events:fire("GL.GDKP_QUEUE_UPDATED");
        return;
    end

    -- Enrich the received queue with required data
    GL:onItemLoadDo(GL:tableColumn(CommMessage.content, 2), function (Details)
        local ItemLinksByID = {};

        for _, Entry in pairs(Details) do
            ItemLinksByID[Entry.id] = Entry.link;
        end

        for _, Queued in pairs(CommMessage.content or {}) do
            local itemLink = ItemLinksByID[Queued[2]];
            if (itemLink) then
                Queue[Queued[1]] = {
                    identifier = Queued[1],
                    itemID = Queued[2],
                    minimumBid = Queued[3],
                    order = Queued[4],
                    increment = Queued[5],
                    itemLink = itemLink,
                };
            end
        end

        self.Queue = Queue;
        self:sanitizeQueue();

        Events:fire("GL.GDKP_QUEUE_UPDATED");
    end);
end

--- Announce to everyone in the raid that an auction is starting
---
---@param itemLink string
---@param minimumBid number
---@param minimumIncrement number
---@return nil
function Auction:announceStart(itemLink, minimumBid, minimumIncrement, duration, antiSnipe)
    -- There's already an auction in progress
    if (self.inProgress) then
        return;
    end

    -- We're still waiting for an auction to start
    if (self.waitingForStart
        and GetServerTime() - self.waitingForStart < 6
    ) then
        return;
    end

    if (not Auctioneer:allowedToBroadcast()) then
        self.waitingForStart = false;
        return;
    end

    self.waitingForStart = GetServerTime();
    local Bids = self.Current.Bids;
    local TopBid = self.Current.TopBid;
    duration = tonumber(duration) or 0;
    antiSnipe = tonumber(antiSnipe) or 0;
    minimumBid = tonumber(minimumBid) or 0;
    minimumIncrement = tonumber(minimumIncrement) or 0;

    if (minimumBid <= 0) then
        minimumBid = 1 / (GL:strPadRight(1, 0, Settings:get("GDKP.precision", 0)));
    end

    if (type(itemLink) ~= "string"
        or GL:empty(itemLink)
        or duration < 1
        or antiSnipe < 0
        or (minimumBid > 0 and GL:lt(minimumBid, .0001))
        or GL:lt(minimumIncrement, 0)
    ) then
        GL:warning(L["Invalid data provided for GDKP auction start!"]);
        self.waitingForStart = false;
        return false;
    end

    local itemID = GL:getItemIDFromLink(itemLink) or 0;
    if (itemID < 1 or not GL.GetItemInfoInstant(itemID)) then
        self.waitingForStart = false;
        GL:warning(L["Invalid data provided for GDKP auction start!"]);
        return false;
    end

    self:listenForBids();

    -- This is still the same item, use the previous highest bid as the starting point
    if (itemLink == self.Current.itemLink) then
        minimumBid = math.max(minimumBid, GL:tableGet(self.Current, "TopBid.bid", 0));
    end

    GL.CommMessage.new({
        action = CommActions.startGDKPAuction,
        content = {
            item = itemLink,
            minimumBid = minimumBid,
            minimumIncrement = minimumIncrement,
            duration = duration,
            antiSnipe = antiSnipe,
            bth = GL.User:bth(),
            precision = Settings:get("GDKP.precision"),
            Bids = Bids,
            TopBid = TopBid,
            Settings = {
                acceptBidsLowerThanMinimum = Settings:get("GDKP.acceptBidsLowerThanMinimum"),
            },
        },
        channel = "GROUP",
    }):send();

    return true;
end

--- Announce to everyone in the raid that the auction has ended
---
---@param forceStop boolean|nil bypass the snipe detection check
---
---@return nil
function Auction:announceStop(forceStop)
    if (not Auction:startedByMe()) then
        return;
    end

    forceStop = GL:toboolean(forceStop);

    -- Looks like we had a last-second bid and are awaiting an extension
    if (self.waitingForReschedule) then
        return;
    end

    self.waitingForStart = false;

    -- Do a final check to see if we're allowed to stop now
    if (not forceStop
        and self.lastBidReceivedAt
        and self.Current.antiSnipe
        and self.Current.antiSnipe > 0
        and GetTime() - self.lastBidReceivedAt <= self.Current.antiSnipe
        and not self.waitingForReschedule
    ) then
        self:announceReschedule(self.Current.antiSnipe);
        return;
    end

    self:stopAutoBid();
    self:stop();

    GL.CommMessage.new({
        action = CommActions.stopGDKPAuction,
        channel = "GROUP",
    }):send();
end

--- Announce to everyone in the raid that we're extending the current auction
---
---@param time number
---@return boolean
function Auction:announceExtension(time)
    self.waitingForReschedule = GetServerTime();

    time = tonumber(time) or 0
    if (time < 1) then
        self.waitingForReschedule = false;
        GL:warning(L["Invalid data provided for GDKP extension!"]);
        return false;
    end

    local secondsLeft = GL.Ace:TimeLeft(self.timerID) - GL.Settings:get("GDKP.auctionEndLeeway", 2);
    local newDuration = math.ceil(secondsLeft + time);

    if (newDuration < time) then
        newDuration = time;
    end

    return self:announceReschedule(newDuration);
end

--- Announce to everyone in the raid that we're extending the current auction
---
---@param time number
---@return boolean
function Auction:announceShortening(time)
    self.waitingForReschedule = GetServerTime();

    time = tonumber(time) or 0
    if (time < 1) then
        self.waitingForReschedule = false;
        GL:warning(L["Invalid data provided for GDKP shortening!"]);
        return false;
    end

    local secondsLeft = GL.Ace:TimeLeft(self.timerID) - GL.Settings:get("GDKP.auctionEndLeeway", 2);
    local newDuration = math.ceil(secondsLeft - time);

    -- In order to prevent funny business we won't allow anything lower than 5 for the new time
    if (newDuration <= 5) then
        newDuration = 5;
    end

    return self:announceReschedule(newDuration);
end

--- Announce a new auction time remaining to everyone in the raid
---
---@param time number
---@return boolean
function Auction:announceReschedule(time)
    if (not Auction:startedByMe()) then
        return;
    end

    self.waitingForReschedule = GetServerTime();

    time = tonumber(time) or 0
    if (time < 1) then
        self.waitingForReschedule = false;
        GL:warning(L["Invalid data provided for GDKP reschedule!"]);
        return false;
    end

    -- In order to prevent funny business we won't allow anything lower than 5 for the new time
    if (time <= 5) then
        time = 5;
    end

    GL.CommMessage.new({
        action = CommActions.rescheduleGDKPAuction,
        content = time,
        channel = "GROUP",
    }):send();

    return true;
end

---@param CommMessage CommMessage
---@return nil
function Auction:reschedule(CommMessage)
    if (not self.Current.initiatorID
        or CommMessage.Sender.id ~= self.Current.initiatorID
    ) then
        GL:debug("GDKP.Auction:reschedule received by non-initiator");
        return;
    end

    local time = tonumber(CommMessage.content) or 0;
    if (time < 1) then
        self.waitingForReschedule = false;
        return GL:error(L["Invalid time provided in Auction:reschedule"]);
    end

    self.Current.duration = time;
    GL.Interface.GDKP.Bidder:changeDuration(time);
    SecondsAnnounced = {};
    GL.Ace:CancelTimer(self.timerID);

    if (self:startedByMe()) then
        self.timerID = GL.Ace:ScheduleTimer(function ()
            self:stop();
            self:announceStop();
            Auctioneer:timeRanOut();
        end, math.ceil(time + GL.Settings:get("GDKP.auctionEndLeeway", 2)));
    end

    self.waitingForReschedule = false;
end

---@return number|boolean Time remaining in seconds or false
function Auction:timeRemaining()
    if (not self.timerID
        or not self.inProgress
    ) then
        return false;
    end

    return math.ceil(GL.Ace:TimeLeft(self.timerID) - GL.Settings:get("GDKP.auctionEndLeeway", 2));
end

--- Start an auction
--- This is done via a CommMessage even for the masterlooter to make
--- sure that the auction starts simultaneously for everyone
---
---@param CommMessage CommMessage
---@return nil
function Auction:start(CommMessage)
    if (not GL.GDKPIsAllowed) then
        return;
    end

    local content = CommMessage.content;
    self.waitingForStart = false;

    -- We already have an active auction
    if (self.inProgress) then
        return;
    end

    --[[
        MAKE SURE THE PAYLOAD IS VALID
        PROVIDE VERY SPECIFIC ERROR MESSAGE IF IT'S NOT
    ]]
    if (not content) then
        return GL:error("Missing content in Auction:start");
    end

    if (type(content) ~= "table") then
        return GL:error("Content is not a table in Auction:start");
    end

    if (not content.duration
        or type(content.duration) ~= "number"
    ) then
        return GL:error("No duration provided in Auction:start");
    end

    if (not content.item) then
        return GL:error("No item provided in Auction:start");
    end

    if (not Auctioneer:allowedToBroadcast(CommMessage.Sender.id)) then
        return GL:error((L["User '%s' is not allowed to start auctions"]):format(CommMessage.Sender.name));
    end

    --- We have to wait with starting the actual auction until
    --- the item that's up for bidding has been successfully loaded by the Item API
    ---
    ---@vararg Item
    ---@return nil
    GL:onItemLoadDo(content.item, function (Details)
        if (not Details) then
            return;
        end

        self:stopAutoBid();

        local duration = math.floor(tonumber(content.duration));
        local antiSnipe = math.floor(tonumber(content.antiSnipe));
        local precision = tonumber(content.precision) or 0;
        local minimumBid = content.minimumBid or 0;
        local minimumIncrement = content.minimumIncrement or 1;

        -- This is a new auction so clean everything
        if (Details.link ~= self.Current.itemLink
            or CommMessage.Sender.id ~= self.Current.initiatorID
        ) then
            -- This is a new item so make sure to
            -- override all previously set properties
            self.Current = {
                bth = content.bth,
                antiSnipe = antiSnipe,
                duration = duration,
                initiatorID = CommMessage.Sender.id,
                initiatorName = CommMessage.Sender.name,
                itemIcon = Details.icon,
                itemID = Details.id,
                itemLink = Details.link,
                itemName = Details.name,
                minimumBid = minimumBid,
                minimumIncrement = minimumIncrement,
                precision = precision,

                Settings = content.Settings,
                Bids = content.Bids,
                TopBid = content.TopBid,
            };
        else
            -- If we auction the same item again we do need to make sure that we update the timer
            self.Current.time = duration;
            self.Current.minimumBid = minimumBid;
            self.Current.minimumIncrement = minimumIncrement;
            self.Current.Bids = content.Bids;
            self.Current.TopBid = content.TopBid;
            self.Current.Settings = content.Settings;
        end

        self.inProgress = true;
        self:listenForBids();

        -- Don't show the bid UI if the user disabled it
        if (Settings:get("GDKP.showBidWindow")) then
            GL.Interface.GDKP.Bidder:show(duration, Details.link, Details.icon, content.bth);
        end

        -- Announce auction start and stop
        if (self:startedByMe()) then
            if (Settings:get("GDKP.announceAuctionStart")) then
                local announceMessage = (L.CHAT["Bid on %s. Minimum is %s - increment is %s. Use raid chat!"]):format(
                    Details.link,
                    GL:goldToMoney(minimumBid),
                    GL:goldToMoney(minimumIncrement)
                );

                if (GL.User.isInRaid) then
                    GL:sendChatMessage(
                        announceMessage,
                        "RAID_WARNING"
                    );
                else
                    GL:sendChatMessage(
                        announceMessage,
                        "PARTY"
                    );
                end
            end

            self.timerID = GL.Ace:ScheduleTimer(function ()
                self:stop();
                self:announceStop();
                Auctioneer:timeRanOut();
            end, math.ceil(duration + GL.Settings:get("GDKP.auctionEndLeeway", 2)));
        end

        -- Send a countdown in chat when enabled
        local numberOfSecondsToCountdown = Settings:get("GDKP.numberOfSecondsToCountdown", 5);
        local numberOfFiveSecondsToCountdown = Settings:get("GDKP.numberOfFiveSecondsToCountdown", 5);
        local FiveSecondsToAnnounce = {};

        for i = 1, math.floor(numberOfFiveSecondsToCountdown / 5) do
            tinsert(FiveSecondsToAnnounce, i * 5);
        end

        if (self:startedByMe() -- Only post a countdown if this user initiated the auction
            and (
                numberOfSecondsToCountdown > 0
                or numberOfFiveSecondsToCountdown > 0
            )
            and (
                duration >= numberOfSecondsToCountdown
                or duration >= numberOfFiveSecondsToCountdown
            )
        ) then
            self.countDownTimer = GL.Ace:ScheduleRepeatingTimer(function ()
                local secondsLeft = math.ceil(GL.Ace:TimeLeft(self.timerID) - GL.Settings:get("GDKP.auctionEndLeeway", 2));
                if ((secondsLeft <= numberOfSecondsToCountdown
                        or GL:inTable(FiveSecondsToAnnounce, secondsLeft)
                    )
                    and secondsLeft > 0
                    and not SecondsAnnounced[secondsLeft]
                ) then
                    SecondsAnnounced[secondsLeft] = true;

                    local chatType = "GROUP";
                    if (GL.User.isInRaid and Settings:get("GDKP.announceCountdownInRW")) then
                        chatType = "RAID_WARNING";
                    end

                    GL:sendChatMessage(
                        (L.CHAT["%s seconds to bid"]):format(secondsLeft),
                        chatType,
                        nil,
                        nil,
                        false
                    );
                end
            end, .2);
        end

        -- Play raid warning sound
        GL:playSound(SOUNDKIT.RAID_WARNING);

        -- Flash the game icon in case the player alt-tabbed
        FlashClientIcon();

        -- Automatically auto-bid on the item if we set an auto bid max
        if (self.QueuedItemAutoBids[Details.id]) then
            self:setAutoBid(self.QueuedItemAutoBids[Details.id]);
            self.QueuedItemAutoBids[Details.id] = nil;
        end

        -- Let the application know that an auction started
        Events:fire("GL.GDKP_AUCTION_STARTED");

        -- Items should only contain 1 item but lets add a return just in case
        return;
    end);
end

--- Check whether the current auction was started by me (the user)
---
---@return boolean
function Auction:startedByMe()
    return self.Current.initiatorID == GL.User.id;
end

---@param CommMessage string|nil
---@return boolean
function Auction:stop(CommMessage)
    self.waitingForStart = false;

    if (not self.inProgress
        or self.waitingForReschedule
    ) then
        return;
    end

    if (CommMessage) then
        -- We already stopped, no need to stop again
        if (self.Current.initiatorID == GL.User.id) then
            return;
        end

        if (CommMessage.Sender.id ~= self.Current.initiatorID) then
            if (self.Current.initiatorID) then
                GL:warning((L["User '%s' is not allowed to stop auctions"]):format(CommMessage.Sender.name));
            else
                GL:warning((L["User '%s' is not allowed to stop auction: auction invalid"]):format(CommMessage.Sender.name));
            end
        end
    end

    if (not self.inProgress) then
        return;
    end

    self:stopAutoBid();

    -- Play raid warning sound
    GL:playSound(SOUNDKIT.RAID_WARNING);

    self.inProgress = false;
    GL.Ace:CancelTimer(self.timerID);

    GL.Interface.GDKP.Bidder:hide();

    self:stopListeningForBids();

    -- If this user started the auction then we need to cancel some timers and post a message
    if (self:startedByMe()) then
        SecondsAnnounced = {};

        -- Announce that the auction has ended
        if (Settings:get("GDKP.announceBidsClosed", true)) then
            GL:sendChatMessage(
                L.CHAT["Stop your bids!"],
                "RAID_WARNING"
            );
        end
    end

    GL.Ace:CancelTimer(self.countDownTimer);
    self.countDownTimer = nil;

    Events:fire("GL.GDKP_AUCTION_STOPPED");

    return true;
end

---@return nil
function Auction:reset()
    -- Reset the last auction. This happens when the master looter
    -- awards an item or when he clicks the "clear" button in the auctioneer window

    -- All we need to do is reset the itemLink and let self:start() take care of the rest
    self.Current.itemLink = "";
    self.Current.Bids = {};
    self.Current.TopBid = {};
end

---@return nil
function Auction:listenForBids()
    if (self.listeningForBids) then
        return;
    end

    -- Make sure the timer to cancel listening for bids is cancelled
    GL.Ace:CancelTimer(self.bidListenerCancelTimerID);

    self.listeningForBids = true;
    self.lastBidReceivedAt = 0;

    local EventsToListenTo = {
        { "GDKPChatMsgPartyListener", "CHAT_MSG_PARTY", },
        { "GDKPChatMsgPartyLeaderListener", "CHAT_MSG_PARTY_LEADER", },
        { "GDKPChatMsgRaidListener", "CHAT_MSG_RAID", },
        { "GDKPChatMsgRaidLeaderListener", "CHAT_MSG_RAID_LEADER", },
    };

    -- Only listen to whispers in case the user is solo and is (most likely) testing the add-on
    if (not GL.User.isInGroup) then
        tinsert(EventsToListenTo, { "GDKPChatMsgWhisperListener", "CHAT_MSG_WHISPER", });
    end

    Events:register(EventsToListenTo, function (_, message, sender)
        self:processBid(message, sender);
        self:autoBid();
    end);
end

--- Unregister the CHAT_MSG_SYSTEM to stop listening for bids
---
---@return nil
function Auction:stopListeningForBids()
    if (self.bidListenerCancelTimerID) then
        GL.Ace:CancelTimer(self.bidListenerCancelTimerID);
    end

    self.listeningForBids = false;
    Events:unregister({
        "GDKPChatMsgWhisperListener",
        "GDKPChatMsgPartyListener",
        "GDKPChatMsgPartyLeaderListener",
        "GDKPChatMsgRaidListener",
        "GDKPChatMsgRaidLeaderListener",
    });
end

---@param message string|number
---@return nil
function Auction:bid(message)
    -- There's no auction in progress
    if (not self.inProgress) then
        return false;
    end

    if (type(message) == "number") then
        message = tostring(message);
    end

    local lowestValidBid = self:lowestValidBid();

    message = message:gsub("%,", ".");

    local bid = self:messageToBid(message, lowestValidBid);

    if (not GL:higherThanZero(bid)) then
        return false;
    end

    if (GL.User.isInGroup) then
        GL:sendChatMessage(bid, "GROUP", nil, nil, false);
    else
        GL:sendChatMessage(bid, "WHISPER", nil, self.Current.initiatorName, false);
    end

    self.lastBidAt = GetTime();

    return true;
end

---@param max string|number
---@param queuedItemChecksum string|nil
---@return boolean
function Auction:setAutoBid(max, queuedItemChecksum)
    -- The user wants to bid on a queued item
    if (queuedItemChecksum) then
        local QueuedItem = self.Queue[queuedItemChecksum];
        if (not QueuedItem) then
            return false;
        end

        self.QueuedItemAutoBids[QueuedItem.itemID] = max;
        return true;
    end

    max = tonumber(max) or 0;
    local lowestMinimumBid = self:lowestValidBid();

    if (GL:lt(max, lowestMinimumBid)) then
        return false;
    end

    self.autoBiddingIsActive = true;
    self.maxBid = max;

    -- Make sure we're the highest bidder, if not then bid
    if (GL:tableGet(self.Current, "TopBid.Bidder.name") ~= GL.User.name) then
        self:bid(lowestMinimumBid);
    end

    -- Make sure the stop auto bid button is shown on the
    if (GL.Interface.GDKP.Bidder.StopAutoBidButton and self.inProgress) then
        GL.Interface.GDKP.Bidder.AutoBidButton:Hide();
        GL.Interface.GDKP.Bidder.StopAutoBidButton:Show();
    end

    return true;
end

---@return nil
function Auction:removeAutoBid(queuedItemChecksum)
    if (not queuedItemChecksum or not self.Queue[queuedItemChecksum]) then
        return;
    end

    local QueuedItem = self.Queue[queuedItemChecksum];

    self.QueuedItemAutoBids[QueuedItem.itemID] = nil;

    self:sanitizeQueuedItemBids();
end

---@param itemID number
---@return number
function Auction:getQueuedAutoBid(itemID)
    return self.QueuedItemAutoBids[itemID] or 0;
end

---@return nil
function Auction:sanitizeQueuedItemBids()
    local QueuedItemIDs = {};
    for _, QueuedItem in pairs(self.Queue or {}) do
        if (QueuedItem) then
            QueuedItemIDs[QueuedItem.itemID] = true;
        end
    end

    local Sanitized = {};
    for itemID, max in pairs(self.QueuedItemAutoBids or {}) do
        if (QueuedItemIDs[itemID]) then
            Sanitized[itemID] = max;
        end
    end

    self.QueuedItemAutoBids = Sanitized;
end

---@return nil
function Auction:stopAutoBid()
    self.autoBiddingIsActive = nil;
    self.maxBid = nil;

    GL.Ace:CancelTimer(self.AutoBidTimer);
    self.AutoBidTimer = nil;

    GL.Interface.GDKP.Bidder:autoBidStopped();
end

--- Are we the highest bidder on the current auction?
---
---@return boolean
function Auction:userIsTopBidder()
    return self.Current.TopBid.bidder
        and (
            GL:iEquals(self.Current.TopBid.bidder, GL.User.name)
            or self.Current.TopBid.Bidder.uuid == GL.User.id
            or GL:iEquals(self.Current.TopBid.Bidder.name, GL.User.name)
        );
end

---@return boolean
function Auction:autoBid()
    -- Looks like we got back on top in the meantime
    if (self:userIsTopBidder()) then
        return;
    end

    if (not self.autoBiddingIsActive or not self.maxBid) then
        return false;
    end

    if (self:lowestValidBid() > self.maxBid) then
        self:stopAutoBid();
        return false;
    end

    -- Make sure we only bid once every Xs (spam throttle)
    if (GetTime() - self.lastBidAt < AUTO_BID_THROTTLE_IN_SECONDS) then
        GL.Ace:CancelTimer(self.AutoBidTimer);

        self.AutoBidTimer = GL.Ace:ScheduleTimer(function ()
            -- Looks like we got back on top in the meantime
            if (self:userIsTopBidder()) then
                return;
            end

            if (self:lowestValidBid() > self.maxBid) then
                return;
            end

            self:minimumBid();
        end, 1);

        return true;
    end

    self:minimumBid();
    return true;
end

---@return nil
function Auction:minimumBid()
    return self:bid(self:lowestValidBid());
end

--- Return the lowest possible valid bid based on the current bid or the minimum price
---
---@return number
function Auction:lowestValidBid()
    local currentTopBid = GL:tableGet(self.Current, "TopBid.bid", 0);
    if (GL:lt(currentTopBid, self.Current.minimumBid)) then
        return self.Current.minimumBid;
    end

    return math.max(
        GL:tableGet(self.Current, "TopBid.bid", 0) + (self.Current.minimumIncrement or 0),
        self.Current.minimumBid
    );
end

---@param event string
---@param message string
---@param bidder string
---@return nil
function Auction:processBid(message, bidder)
    local auctionWasStartedByMe = self:startedByMe();
    message = strlower(message);
    -- This is a message generated by gargul, skip it
    if (GL:strStartsWith(message, "{rt3} gargul :")) then
        return;
    end

    -- We're no longer listening for bids
    if (not self.listeningForBids
        or not self.inProgress
    ) then
        return;
    end

    local bid = self:messageToBid(message, self:lowestValidBid());
    if (not GL:higherThanZero(bid)) then
        return;
    end

    --- Make sure the person who bid is in our group
    local BidEntry = false;

    if (not GL.User:unitInGroup(bidder)) then
        return;
    end

    local Bidder = GL:iEquals(GL:formatPlayerName(bidder), GL.User.name) and GL.User or GL.Player:fromName(bidder);
    local bidderGUID = GDKP:playerGUID(Bidder.fqn);

    BidEntry = {
        Bidder = {
            class = Bidder.class,
            guild = Bidder.Guild.name,
            name = Bidder.name,
            race = Bidder.race,
            realm = Bidder.realm,
            uuid = Bidder.id,
        },
        bid = bid,
        bidder = bidderGUID,
        createdAt = GetServerTime(),
    };

    -- Determine the minimum bid
    local currentBid = GL:tableGet(self.Current, "TopBid.bid", 0);
    local minimumBid = math.max(
        self.Current.minimumBid,
        currentBid > 0 and currentBid + self.Current.minimumIncrement or 0
    );

    local bidTooLow = GL:lt(bid, minimumBid);
    if (auctionWasStartedByMe) then
        -- Notify the player via whisper if their bid is too low
        if (bidTooLow and Settings:get("GDKP.notifyIfBidTooLow")) then
            if (not Settings:get("GDKP.acceptBidsLowerThanMinimum")) then
                GL:sendChatMessage((L.CHAT["Bid denied, the minimum bid is %s"]):format(GL:goldToMoney(minimumBid)), "WHISPER", nil, bidder);
            end
        end

        -- We need to trigger the anti-snipe time
        if (self.Current and self.Current.antiSnipe and self.Current.antiSnipe > 0 and (
            not bidTooLow or Settings:get("GDKP.invalidBidsTriggerAntiSnipe")
        )) then
            self.lastBidReceivedAt = GetTime();
            local secondsLeft = math.floor(GL.Ace:TimeLeft(self.timerID) - GL.Settings:get("GDKP.auctionEndLeeway", 2));
            if (GL:lt(secondsLeft, self.Current.antiSnipe)) then
                self:announceReschedule(self.Current.antiSnipe);
            end
        end
    end

    -- This bid is too low and we don't accept that
    if (bidTooLow and (
        currentBid >= self.Current.minimumBid
        or GL:lte(bid, currentBid)
        or not self.Current.Settings.acceptBidsLowerThanMinimum
    )) then
        return;
    end

    self.lastBidReceivedAt = GetTime();

    if (GL:iEquals(Bidder.name, GL.User.name)) then
        self.Current.iBid = true;
    end

    -- Announce that we have a new leading bid
    if (auctionWasStartedByMe
        and not bidTooLow
        and Settings:get("GDKP.announceNewBid")
    ) then
        Auctioneer:announceBid(BidEntry);
    end

    tinsert(self.Current.Bids, BidEntry);

    -- We already have at least one bid
    local auctionHasBid = currentBid > 0;

    -- Check if we're currently the highest bidder
    local userWasHighestBidder = self:userIsTopBidder();

    self.Current.TopBid = BidEntry;

    Events:fire("GL.GDKP_BID_ACCEPTED", BidEntry);

    -- We're no longer the highest bidder, oh dear
    if (userWasHighestBidder and not self:userIsTopBidder()) then
        Events:fire("GL.GDKP_USER_WAS_OUTBID");
    end

    if (not auctionHasBid) then
        Events:fire("GL.GDKP_FIRST_BID_ACCEPTED");
    end
end

--- Transform a given message to a bid if possible
---
---@param message string
---@return number
function Auction:messageToBid(message, minBid)
    message = message:gsub("%,", ".");

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
        and GL:lt(bid, minBid) -- Only if the bid is lower than the minimum bid
        and GL:lte(bid, 100) -- Only if the bid is 1 through 100 (if someone wants to bid 100k then he can write 101k)
        and GL:lt((bid * 1000) / minBid, 2.5) -- Only if the bid*1000 is ste (<=) the current minimum bid x 2.5
    ) then
        kModifier = true;
    elseif (distance > 7) then
        return 0;
    end

    if (kModifier) then
        bid = bid * 1000;
    end

    bid = GL:floor(bid, self.Current.precision);

    return bid;
end
