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
    _initialized = false,
    autoBiddingIsActive = nil,
    lastBidAt = nil,
    lastBidAnnouncementAt = 0,
    lastBidReceivedAt = 0,
    maxBid = nil,
    raidWarningThrottler = nil,
    waitingForReshedule = false,
    waitingForStart = false,

    AutoBidTimer = nil,
    BidListenerCancelTimerId = nil,
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
local AUTO_BID_THROTTLE_IN_SECONDS = .8;
local BROADCAST_QUEUE_DELAY_IN_SECONDS = 2;

function Auction:_init()
    GL:debug("GDKP.Auction:_init");

    if (self._initialized) then
        return false;
    end

    Auctioneer = GL.GDKP.Auctioneer or {};

    -- An event is fired whenever a bid is accepted, in which case we broadcast the latest auction details
    Events:register("GDKPBidAccepted", "GL.GDKP_BID_ACCEPTED", function (_, OldTopBid, NewTopBid)
        if (GL:tableGet(OldTopBid or {}, "Bidder.uuid") == GL.User.id
            and NewTopBid.Bidder.uuid ~= GL.User.id
        ) then
            Events:fire("GL.GDKP_USER_WAS_OUTBID", OldTopBid, NewTopBid);
        end

        GL.Interface.GDKP.Bidder:refresh();
    end);

    -- Whenever we were outbid we show a notification
    Events:register("GDKPGDKPUserWasOutBid", "GL.GDKP_USER_WAS_OUTBID", function ()
        self:userWasOutBidHandler();
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
---@return void
function Auction:_initializeQueue()
    local QueueCopy = {};
    for _, Entry in pairs(self.Queue) do
        tinsert(QueueCopy, Entry);
    end
    table.sort(QueueCopy, function (a, b)
        return a.identifier < b.identifier;
    end);

    local i = 1;
    self.Queue = {};
    local QueueAddTimer;
    -- Add items in intervals to alleviate UI/performance strain
    QueueAddTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        GL:debug("Run Auction._initializeQueue");
        local Queued = QueueCopy[i];
        if (not Queued) then
            GL:debug("Cancel Auction._initializeQueue");
            GL.Ace:CancelTimer(QueueAddTimer);
            QueueCopy = nil;

            GL.Events:fire("GL.GDKP_QUEUE_UPDATED");
            return;
        end

        i = i + 1;
        return Auctioneer:addToQueue(Queued.itemLink, Queued.identifier);
    end, .2);
end

---@return void
function Auction:userWasOutBidHandler()
    GL:debug("Auction:userWasOutBidHandler");

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
        message = string.format("|c00BE3333You were outbid!|r"),
    });
end

--- Create an auction
---
---@param itemID number
---@param price number
---@param winner string
---@param sessionID string
---@param Bids table
---@param note string
---
---@return boolean
function Auction:create(itemID, price, winner, sessionID, Bids, note, awardChecksum)
    GL:debug("Auction:create");

    if ((not sessionID
        or (sessionID and not GDKPSession:exists(sessionID))
    ) and not GDKPSession:activeSessionID()
    ) then
        GL:warning("Unknown sessionIdentifier in Auction:create: " .. tostring(sessionID));
        return false;
    end

    itemID = GetItemInfoInstant(itemID);
    if (not GL:higherThanZero(itemID)) then
        GL:warning("Unknown itemID in Auction:create: " .. tostring(itemID));
        return false;
    end

    sessionID = sessionID or GDKPSession:activeSessionID();
    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning("The GDKP Session is not available or locked");
        return;
    end

    local Instance = {
        price = price,
        itemID = itemID,
        createdAt = GetServerTime(),
        note = strtrim(tostring(note)),
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

    local checksum = Instance.createdAt .. GL:stringHash({ Instance.itemID, Instance.createdAt, table.concat(Instance.CreatedBy, ".") });
    Instance.ID = checksum;

    -- Something is wrong with the Auction. Tampering maybe? RETURN!
    Instance = self:sanitize(Instance);
    if (not Instance) then
        return false;
    end

    if (awardChecksum and DB:get("AwardHistory." .. awardChecksum)) then
        Instance.awardChecksum = awardChecksum;
    end

    GL:onItemLoadDo(itemID, function (Details)
        if (not Details) then
            return;
        end

        Instance.itemLink = Details.link;
        GL:tableSet(Session, "Auctions." .. checksum, Instance);

        Events:fire("GL.GDKP_AUCTION_CHANGED", sessionID, checksum, {}, Instance);
        Events:fire("GL.GDKP_AUCTION_CREATED", sessionID, checksum);
    end);

    -- Make sure we invalidate this item's history
    GDKPSession.ItemHistory[itemID] = nil;

    return true;
end

---@param sessionID string
---@param auctionID string
---
---@return void
function Auction:delete(sessionID, auctionID, reason)
    GL:debug("Auction:delete");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning("The GDKP Session is not available or locked");
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
---@return void
function Auction:restore(sessionID, auctionID)
    GL:debug("Auction:restore");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning("The GDKP Session is not available or locked");
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

    Instance.awardChecksum = GL.AwardedLoot:addWinner(Instance.Winner.name, Instance.itemLink, false, nil, nil, nil, Instance.price, nil);

    -- We don't point to Auction here, we want a copy not a pointer!
    local Before = GL:tableGet(Session, "Auctions." .. auctionID);
    GL:tableSet(Session, "Auctions." .. auctionID, Instance);

    Events:fire("GL.GDKP_AUCTION_CHANGED", sessionID, auctionID, Before, Instance);
    Events:fire("GL.GDKP_AUCTION_RESTORED", sessionID, auctionID);

    return true;
end

--- Store the currently active auction in the session ledger
---
---@param winner string
---@param bid number
---@param awardChecksum string|nil
---@return boolean
function Auction:storeCurrent(winner, bid, awardChecksum)
    GL:debug("Auction:storeCurrent");

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

    local itemID = GL:getItemIDFromLink(GL.GDKP.Auction.Current.itemLink)

    -- Make sure the item is valid
    if (not GL:higherThanZero(itemID)
        or not GL:higherThanZero(GetItemInfoInstant(itemID))
    ) then
        GL:warning("Unknown itemID in Auction:create: " .. tostring(itemID));
        return false;
    end

    local HighestBidPerPlayer = {};
    for _, Bid in pairs(Instance.Bids or {}) do
        (function ()
            local bidder = strtrim(tostring(Bid.Bidder.name));

            if (not HighestBidPerPlayer[bidder]) then
                HighestBidPerPlayer[bidder] = {};
            end

            if (HighestBidPerPlayer[bidder].bid or 0 < Bid.bid) then
                HighestBidPerPlayer[bidder] = Bid;
            end
        end)();
    end

    return self:create(itemID, bid, winner, nil, HighestBidPerPlayer, nil, awardChecksum);
end

---@param Instance table
function Auction:sanitize(Instance)
    local SanitizedAuction = {};

    Instance.price = tonumber(Instance.price);

    --[[ Top level Auction check ]]
    if (not Instance
        or type(Instance) ~= "table"
        or type(Instance.CreatedBy) ~= "table"
        or (Instance.Winner and type(Instance.Winner) ~= "table")
        or (Instance.Bids and type(Instance.Bids) ~= "table")
        or date('%Y', tonumber(Instance.createdAt) or 0) == "1970"
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
        --or not Constants.Classes[Instance.CreatedBy.class]
        or type (Instance.CreatedBy.name) ~= "string"
        or GL:empty(Instance.CreatedBy.name)
        or type (Instance.CreatedBy.race) ~= "string"
        --or not Constants.Races[Instance.CreatedBy.race]
        or type (Instance.CreatedBy.uuid) ~= "string"
        or not string.match(Instance.CreatedBy.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
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
    SanitizedAuction.itemID = GetItemInfoInstant(Instance.itemID);
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
                or Bid.bid < 1
                or date('%Y', tonumber(Bid.createdAt) or 0) == "1970"
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
                ---@todo: issue here, got deathknight, constant is death_knight
                --or not Constants.Classes[Bidder.class]
                or type (Bidder.name) ~= "string"
                or GL:empty(Bidder.name)
                or type (Bidder.race) ~= "string"
                --or not Constants.Races[Bidder.race]
                or type (Bidder.uuid) ~= "string"
                or not string.match(Bidder.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
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
                --or not Constants.Races[Winner.race]
            ))
            or (not GL:empty(Winner.class) and (
                type(Winner.class) ~= "string"
                --or not Constants.Classes[Winner.class]
            ))
            or (not GL:empty(Winner.uuid) and (
                type(Winner.uuid) ~= "string"
                or not string.match(Winner.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
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
    SanitizedAuction.note = strtrim(tostring(Instance.note));

    --[[ Make sure the checksum is valid ]]
    local checksum = SanitizedAuction.createdAt .. GL:stringHash({ SanitizedAuction.itemID, SanitizedAuction.createdAt, table.concat(SanitizedAuction.CreatedBy, ".") });

    if (checksum ~= Instance.ID) then
        GL:xd("Auction:sanitize step 10 failed, contact support!");
        return false;
    end

    SanitizedAuction.ID = checksum;

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
    GL:debug("Auction:reassignAuction");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning("The GDKP Session is not available or locked");
        return;
    end

    local OldAuction = GL:tableGet(Session, "Auctions." .. auctionID);

    if (not OldAuction
        or OldAuction.Winner.name == winner
    ) then
        return false;
    end

    winner = GL:capitalize(string.lower(winner));
    GL:tableSet(Session, string.format("Auctions.%s.Winner.name", auctionID), winner);

    if (OldAuction.awardChecksum) then
        GL.AwardedLoot:editWinner(OldAuction.awardChecksum, winner);
    end

    Events:fire("GL.GDKP_AUCTION_CHANGED",
        sessionID,
        auctionID,
        OldAuction,
        DB.GDKP.Ledger[sessionID].Auctions[auctionID]
    );
    Events:fire("GL.GDKP_AUCTION_REASSIGNED", sessionID, OldAuction, winner);

    return true;
end

---@param sessionID string
---@param auctionID string
---@param note string
function Auction:setNote(sessionID, auctionID, note)
    GL:debug("Auction:setNote");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning("The GDKP Session is not available or locked");
        return;
    end

    local OldAuction = GL:tableGet(Session, "Auctions." .. auctionID);

    if (not OldAuction
        or OldAuction.note == note
    ) then
        return false;
    end

    GL:tableSet(Session, string.format("Auctions.%s.note", auctionID), note);

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
function Auction:setPaid(sessionID, auctionID, paid)
    GL:debug("Auction:setPaid");

    local Session = GDKPSession:byID(sessionID);
    if (not Session or Session.lockedAt) then
        GL:warning("The GDKP Session is not available or locked");
        return;
    end

    paid = tonumber(paid);

    if (not paid) then
        GL:warning("Invalid number provided for 'paid'");
        return;
    end

    local OldAuction = GL:tableGet(Session, "Auctions." .. auctionID);

    if (not OldAuction or OldAuction.paid == paid) then
        return false;
    end

    GL:tableSet(Session, string.format("Auctions.%s.paid", auctionID), paid);

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
    GL:debug("Auction:move");

    -- There's nothing to move!
    if (fromSessionID == toSessionID) then
        return false;
    end

    local FromSession = GDKPSession:byID(fromSessionID);
    if (not FromSession or FromSession.lockedAt) then
        GL:warning("The GDKP Session is not available or locked");
        return false;
    end

    local ToSession = GDKPSession:byID(toSessionID);
    if (not ToSession or ToSession.lockedAt) then
        GL:warning("The GDKP Session is not available or locked");
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
---@return void
function Auction:addToQueue(itemLink, identifier)
    GL:debug("Auction:addToQueue");

    local itemID = GL:getItemIDFromLink(itemLink);
    if (not itemID) then
        return;
    end

    local addedAt = GetTime();
    local PerItemSettings = GDKP:settingsForItemID(GL:getItemIDFromLink(itemLink));
    self.Queue[identifier] = {
        itemLink = itemLink,
        itemID = itemID,
        minimumBid = PerItemSettings.minimum,
        increment = PerItemSettings.increment,
        addedAt = addedAt,
        identifier = identifier,
    };

    self:broadcastQueue();

    Events:fire("GL.GDKP_QUEUE_UPDATED");
end

---@param checksum string
---@return void
function Auction:removeFromQueue(checksum)
    GL:debug("Auction:removeFromQueue");

    checksum = tostring(checksum or 0);

    if (self.Queue[checksum]) then
        self.Queue[checksum] = nil;
        self:broadcastQueue();
    end

    Events:fire("GL.GDKP_QUEUE_UPDATED");
end

---@return void
function Auction:clearQueue()
    GL:debug("Auction:clearQueue");

    self.Queue = {};
    self:broadcastQueue(true);

    Events:fire("GL.GDKP_QUEUE_UPDATED");
end

---@return void
function Auction:sanitizeQueue()
    GL:debug("Auction:sanitizeQueue");

    local Sanitized = {};

    for checksum, QueuedItem in pairs(self.Queue or {}) do
        if (type(QueuedItem) == "table"
            and type(QueuedItem.itemLink) == "string"
        ) then
            Sanitized[checksum] = QueuedItem;
        end
    end

    self.Queue = Sanitized;
end

---@return void
function Auction:broadcastQueue(immediately)
    GL:debug("Auction:broadcastQueue");

    GL.Ace:CancelTimer(self.QueueBroadcastTimer);
    self:sanitizeQueue();

    if (not Auctioneer:allowedToBroadcast()) then
        return;
    end

    local broadcast = function ()
        GL.CommMessage.new(
            CommActions.broadcastGDKPAuctionQueue,
            self.Queue or {},
            "GROUP"
        ):send();
    end;

    if (immediately) then
        broadcast();
        return;
    end

    self.QueueBroadcastTimer = GL.Ace:ScheduleTimer(function ()
        broadcast();
    end, BROADCAST_QUEUE_DELAY_IN_SECONDS);
end

---@return void
function Auction:receiveQueue(CommMessage)
    GL:debug("Auction:receiveQueue");

    -- No need to override our own queue
    if (CommMessage.Sender.isSelf) then
        return;
    end

    if (type(CommMessage.content) ~= "table") then
        return;
    end

    if (not Auctioneer:allowedToBroadcast(CommMessage.Sender.id)) then
        return;
    end

    self.Queue = CommMessage.content;
    self:sanitizeQueue();

    Events:fire("GL.GDKP_QUEUE_UPDATED");
end

--- Announce to everyone in the raid that an auction is starting
---
---@param itemLink string
---@param minimumBid number
---@param minimumIncrement number
---@return void
function Auction:announceStart(itemLink, minimumBid, minimumIncrement, duration, antiSnipe)
    GL:debug("GDKP.Auction:announceStart");

    if (self.waitingForStart) then
        return;
    end

    if (not Auctioneer:allowedToBroadcast()) then
        return;
    end

    self.waitingForStart = true;
    local Bids = self.Current.Bids;
    local TopBid = self.Current.TopBid;
    duration = tonumber(duration) or 0;
    antiSnipe = tonumber(antiSnipe) or 0;
    minimumBid = tonumber(minimumBid) or 1;
    minimumIncrement = tonumber(minimumIncrement) or 0;

    if (type(itemLink) ~= "string"
        or GL:empty(itemLink)
        or duration < 1
        or antiSnipe < 0
        or minimumBid < 1
        or minimumIncrement < 0
    ) then
        GL:warning("Invalid data provided for GDKP auction start!");
        return false;
    end

    local itemID = GL:getItemIDFromLink(itemLink) or 0;
    if (itemID < 1 or not GetItemInfoInstant(itemID)) then
        GL:warning("Invalid item provided for GDKP auction start!");
        return false;
    end

    self.inProgress = true;

    self:listenForBids();

    self:broadcastQueue(true);

    -- This is still the same item, use the previous highest bid as the starting point
    if (itemLink == self.Current.itemLink) then
        minimumBid = math.max(minimumBid, GL:tableGet(self.Current, "TopBid.bid", 0));
    end

    GL.CommMessage.new(
        CommActions.startGDKPAuction,
        {
            item = itemLink,
            minimumBid = minimumBid,
            minimumIncrement = minimumIncrement,
            duration = duration,
            antiSnipe = antiSnipe,
            Bids = Bids,
            TopBid = TopBid,
            Settings = {
                acceptBidsLowerThanMinimum = Settings:get("GDKP.acceptBidsLowerThanMinimum"),
            },
        },
        "GROUP"
    ):send();

    -- The user doesn't want to announce anything in chat
    if (not Settings:get("GDKP.announceAuctionStart")) then
        return true;
    end

    local announceMessage = string.format("Bidding starts on %s. Minimum is %sg, increment is %sg. Use raid chat!",
        itemLink,
        minimumBid,
        minimumIncrement
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

    return true;
end

--- Anounce to everyone in the raid that the auction has ended
---
---@param forceStop boolean|nil bypass the snipe detection check
---
---@return void
function Auction:announceStop(forceStop)
    GL:debug("GDKP.Auction:announceStop");

    forceStop = GL:toboolean(forceStop);

    -- Looks like we had a last-second bid and are awaiting an extension
    if (self.waitingForReshedule) then
        return;
    end

    -- Do a final check to see if we're allowed to stop now
    if (not forceStop
        and self.lastBidReceivedAt
        and self.Current.antiSnipe
        and self.Current.antiSnipe > 0
        and GetTime() - self.lastBidReceivedAt <= self.Current.antiSnipe
        and not self.waitingForReshedule
    ) then
        self:announceExtension(self.Current.antiSnipe);
        return;
    end

    self:stop();

    GL.CommMessage.new(
        CommActions.stopGDKPAuction,
        nil,
        "GROUP"
    ):send();
end

--- Anounce to everyone in the raid that we're extending the current auction
---
---@param time number
---@return void
function Auction:announceExtension(time)
    GL:debug("GDKP.Auction:announceExtension");

    self.waitingForReshedule = true;

    time = tonumber(time) or 0
    if (time < 1) then
        GL:warning("Invalid data provided for GDKP extension!");
        return false;
    end

    local secondsLeft = GL.Ace:TimeLeft(self.timerId) - GL.Settings:get("GDKP.auctionEndLeeway", 2);

    local newDuration = math.ceil(secondsLeft + time);

    if (newDuration < time) then
        newDuration = time;
    end

    GL.CommMessage.new(
        CommActions.rescheduleGDKPAuction,
        newDuration,
        "GROUP"
    ):send();

    return true;
end

--- Anounce to everyone in the raid that we're extending the current auction
---
---@param time number
---@return void
function Auction:announceShortening(time)
    GL:debug("GDKP.Auction:announceShortening");

    self.waitingForReshedule = true;

    time = tonumber(time) or 0
    if (time < 1) then
        GL:warning("Invalid data provided for GDKP shortening!");
        return false;
    end

    local secondsLeft = GL.Ace:TimeLeft(self.timerId) - GL.Settings:get("GDKP.auctionEndLeeway", 2);
    local newDuration = math.ceil(secondsLeft - time);

    -- In order to prevent funny business we won't allow anything lower than 5 for the new time
    if (newDuration <= 5) then
        newDuration = 5;
    end

    GL.CommMessage.new(
        CommActions.rescheduleGDKPAuction,
        newDuration,
        "GROUP"
    ):send();

    return true;
end

function Auction:extend(CommMessage)
    GL:debug("GDKP.Auction:extend");

    if (not self.Current.initiatorID
        or CommMessage.Sender.id ~= self.Current.initiatorID
    ) then
        GL:debug("GDKP.Auction:extend received by non-initiator");
        return;
    end

    local time = tonumber(CommMessage.content) or 0;
    if (time < 1) then
        self.waitingForReshedule = false;
        return GL:error("Invalid time provided in Auction:extend");
    end

    self.Current.duration = time;
    GL.Interface.GDKP.Bidder:changeDuration(time);
    SecondsAnnounced = {};
    GL.Ace:CancelTimer(self.timerId);

    if (self:startedByMe()) then
        self.timerId = GL.Ace:ScheduleTimer(function ()
            self:stop();
            self:announceStop();
            Auctioneer:timeRanOut();
        end, math.ceil(time + GL.Settings:get("GDKP.auctionEndLeeway", 2)));
    end

    self.waitingForReshedule = false;
end

---@return number|boolean Time remaining in seconds or false
function Auction:timeRemaining()
    if (not self.timerId
        or not self.inProgress
    ) then
        return false;
    end

    return math.ceil(GL.Ace:TimeLeft(self.timerId) - GL.Settings:get("GDKP.auctionEndLeeway", 2));
end

--- Start an auction
--- This is done via a CommMessage even for the masterlooter to make
--- sure that the auction starts simultaneously for everyone
---
---@param CommMessage CommMessage
function Auction:start(CommMessage)
    GL:debug("GDKP.Auction:start");

    local content = CommMessage.content;

    self.waitingForStart = false;

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
        return GL:error(string.format("User '%s' is not allowed to start auctions", CommMessage.Sender.name));
    end

    --- We have to wait with starting the actual auction until
    --- the item that's up for bidding has been successfully loaded by the Item API
    ---
    ---@vararg Item
    ---@return void
    GL:onItemLoadDo(content.item, function (Details)
        if (not Details) then
            return;
        end

        self:stopAutoBid();

        local duration = math.floor(tonumber(content.duration));
        local antiSnipe = math.floor(tonumber(content.antiSnipe));
        local SupportedBids = content.SupportedBids or {};
        local minimumBid = content.minimumBid or 0;
        local minimumIncrement = content.minimumIncrement or 1;

        -- This is a new auction so clean everything
        if (Details.link ~= self.Current.itemLink
            or CommMessage.Sender.id ~= self.Current.initiatorID
        ) then
            -- This is a new item so make sure to
            -- override all previously set properties
            self.Current = {
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
            GL.Interface.GDKP.Bidder:show(duration, Details.link, Details.icon, content.note, SupportedBids);
        end

        -- Make sure to announce the auction stop when time is up
        if (self:startedByMe()) then
            self.timerId = GL.Ace:ScheduleTimer(function ()
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
                local secondsLeft = math.ceil(GL.Ace:TimeLeft(self.timerId) - GL.Settings:get("GDKP.auctionEndLeeway", 2));
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
                        string.format("%s seconds to bid", secondsLeft),
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

        -- Let the application know that an auction started
        Events:fire("GL.GDKP_AUCTION_STARTED");

        -- Automatically auto-bid on the item if we set an auto bid max
        if (self.QueuedItemAutoBids[Details.id]) then
            self:setAutoBid(self.QueuedItemAutoBids[Details.id]);
            self.QueuedItemAutoBids[Details.id] = nil;
        end

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
    GL:debug("GDKP.Auction:stop");

    if (not self.inProgress
        or self.waitingForReshedule
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
                GL:warning(CommMessage.Sender.name .. " is not allowed to stop auction");
            else
                GL:warning(CommMessage.Sender.name .. " is not allowed to stop current auction: auction is invalid");
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
    GL.Ace:CancelTimer(self.timerId);

    GL.Interface.GDKP.Bidder:hide();

    self:stopListeningForBids();

    -- If this user started the auction then we need to cancel some timers and post a message
    if (self:startedByMe()) then
        SecondsAnnounced = {};

        -- Announce that the auction has ended
        if (Settings:get("GDKP.announceBidsClosed", true)) then
            GL:sendChatMessage(
                string.format("Stop your bids!"),
                "RAID_WARNING"
            );
        end
    end

    GL.Ace:CancelTimer(self.countDownTimer);
    self.countDownTimer = nil;

    Events:fire("GL.GDKP_AUCTION_STOPPED");

    return true;
end

--- Something changed, see if we need to change anything (UI elements, top bid etc)
---
---@param CommMessage string|nil
---@return void
function Auction:refresh(CommMessage)
    -- Even if the auction is over we still want to update UI elements
    -- if needed, this is why we don't use self.inProgress here!
    if (GL:empty(self.Current)) then
        return;
    end

    -- The user who sent the refresh our way is not permitted to do so
    if (CommMessage
        and CommMessage.Sender.id ~= self.Current.initiatorID
    ) then
        return;
    end

    -- Check if there's a new highest bid
    local NewTopBid = CommMessage.content;
    local OldTopBid = self.Current.TopBid or {};

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

        self.Current.TopBid = NewTopBid;
        GL.Interface.GDKP.Bidder:refresh();
    end
end

function Auction:reset()
    GL:debug("GDKP.Auction:reset");

    -- Reset the last auction. This happens when the master looter
    -- awards an item or when he clicks the "clear" button in the auctioneer window

    -- All we need to do is reset the itemLink and let self:start() take care of the rest
    self.Current.itemLink = "";
    self.Current.Bids = {};
    self.Current.TopBid = {};
end

---@return void
function Auction:listenForBids()
    GL:debug("GDKP.Auction:listenForBids");

    if (self.listeningForBids) then
        return;
    end

    -- Make sure the timer to cancel listening for bids is cancelled
    GL.Ace:CancelTimer(self.bidListenerCancelTimerId);

    self.listeningForBids = true;
    self.lastBidReceivedAt = 0;

    local EventsToListenTo = {
        {"GDKPChatMsgPartyListener", "CHAT_MSG_PARTY"},
        {"GDKPChatMsgPartyLeaderListener", "CHAT_MSG_PARTY_LEADER"},
        {"GDKPChatMsgRaidListener", "CHAT_MSG_RAID"},
        {"GDKPChatMsgRaidLeaderListener", "CHAT_MSG_RAID_LEADER"},
    };

    -- Only listen to whispers in case the user is solo and is (most likely) testing the add-on
    if (not GL.User.isInGroup) then
        tinsert(EventsToListenTo, {"GDKPChatMsgWhisperListener", "CHAT_MSG_WHISPER"});
    end

    Events:register(EventsToListenTo, function (event, message, sender)
        self:processBid(message, sender);
    end);
end

--- Unregister the CHAT_MSG_SYSTEM to stop listening for bids
---
---@return void
function Auction:stopListeningForBids()
    GL:debug("GDKP.Auction:stopListeningForBids");

    if (self.bidListenerCancelTimerId) then
        GL.Ace:CancelTimer(self.bidListenerCancelTimerId);
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
function Auction:bid(message)
    GL:debug("GDKP.Auction:bid");

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
    GL:debug("Auction:autoBid");

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

    if (max < lowestMinimumBid) then
        return false;
    end

    self.autoBiddingIsActive = true;
    self.maxBid = max;

    -- Make sure we're the highest bidder, if not then bid
    if (GL:tableGet(self.Current, "TopBid.Bidder.name") ~= GL.User.name) then
        self:bid(lowestMinimumBid);
    end

    return true;
end

---@return void
function Auction:removeAutoBid(queuedItemChecksum)
    GL:debug("Auction:removeAutoBid");

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

---@return void
function Auction:sanitizeQueuedItemBids()
    GL:debug("Auction:sanitizeQueuedItemBids");

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

---@return void
function Auction:stopAutoBid()
    GL:debug("Auction:stopAutoBid");

    self.autoBiddingIsActive = nil;
    self.maxBid = nil;

    GL.Ace:CancelTimer(self.AutoBidTimer);
    self.AutoBidTimer = nil;

    GL.Interface.GDKP.Bidder:autoBidStopped();
end

---@return boolean
function Auction:autoBid()
    GL:debug("Auction:autoBid");

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

---@return void
function Auction:minimumBid()
    GL:debug("Auction:minimumBid");

    return self:bid(self:lowestValidBid());
end

--- Return the lowest possible valid bid based on the current bid or the minimum price
---
---@return number
function Auction:lowestValidBid()
    GL:debug("Auction:lowestValidBid");

    local currentTopBid = GL:tableGet(self.Current, "TopBid.bid", 0);
    if (currentTopBid < self.Current.minimumBid) then
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
---@return void
function Auction:processBid(message, bidder)
    GL:debug("GDKP.Auction:processBid");

    local auctionWasStartedByMe = self:startedByMe();
    message = string.lower(message);

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

    -- Determine the minimum bid
    local currentBid = GL:tableGet(self.Current, "TopBid.bid", 0)
    local minimumBid = math.max(
        self.Current.minimumBid,
        currentBid + self.Current.minimumIncrement
    );

    local bidTooLow = bid < minimumBid;
    if (auctionWasStartedByMe) then
        -- Notify the player via whisper if their bid is too low
        if (bidTooLow and Settings:get("GDKP.notifyIfBidTooLow")) then
            if (not Settings:get("GDKP.acceptBidsLowerThanMinimum")) then
                GL:sendChatMessage(string.format(L.BID_DENIED_WHISPER, minimumBid), "WHISPER", nil, bidder);
            end
        end

        -- We need to trigger the anti-snipe time
        if (self.Current and self.Current.antiSnipe and self.Current.antiSnipe > 0 and (
            not bidTooLow or Settings:get("GDKP.invalidBidsTriggerAntiSnipe")
        )) then
            self.lastBidReceivedAt = GetTime();
            local secondsLeft = math.floor(GL.Ace:TimeLeft(self.timerId) - GL.Settings:get("GDKP.auctionEndLeeway", 2));
            if (secondsLeft <= self.Current.antiSnipe) then
                self:announceExtension(self.Current.antiSnipe);
            end
        end
    end

    -- This bid is too low and we don't accept that
    if (bidTooLow and (
        currentBid >= self.Current.minimumBid
        or bid <= currentBid
        or not self.Current.Settings.acceptBidsLowerThanMinimum
    )) then
        return;
    end

    self.lastBidReceivedAt = GetTime();

    -- Announce that we have a new leading bid
    if (auctionWasStartedByMe
        and not bidTooLow
        and Settings:get("GDKP.announceNewBid")
    ) then
        Auctioneer:announceBid(BidEntry);
    end

    tinsert(self.Current.Bids, BidEntry);

    local OldTopBid = self.Current.TopBid;
    self.Current.TopBid = BidEntry;

    Events:fire("GL.GDKP_BID_ACCEPTED", OldTopBid, BidEntry);
end

--- Transform a given message to a bid if possible
---
---@param message string
---@return number
function Auction:messageToBid(message, minBid)
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
        and (bid * 1000) / minBid < 2.5 -- Only if the bid*1000 is ste (<=) the current minimum bid x 2.5
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

GL:debug("Auction.lua");