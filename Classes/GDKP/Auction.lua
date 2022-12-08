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

---@class GDKPAuction
GDKP.Auction = {
    _initialized = false,

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
    BidListenerCancelTimerId = nil,
};

---@type GDKPAuction
local Auction = GDKP.Auction;

---@type GDKPSession
local GDKPSession = GDKP.Session;

function Auction:_init()
    GL:debug("GDKP.Auction:_init");

    if (self._initialized) then
        return false;
    end

    -- An event is fired whenever a bid is accepted, in which case we broadcast the latest auction details
    Events:register("GDKPBidAccepted", "GL.GDKP_BID_ACCEPTED", function (_, OldTopBid, NewTopBid)
        GL.CommMessage.new(
            CommActions.refreshGDKPAuction,
            self.Current,
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

--- Create an auction
---
---@param itemID number
---@param price number
---@param winner string
---@param sessionIdentifier string
---@param Bids table
---@param note string
---
---@return boolean|table
function Auction:create(itemID, price, winner, sessionIdentifier, Bids, note)
    GL:debug("Auction:create");

    if ((not sessionIdentifier
        or (sessionIdentifier and not GDKPSession:exists(sessionIdentifier))
    ) and not GDKPSession:activeSessionID()
    ) then
        GL:warning("Unknown sessionIdentifier in Auction:create: " .. tostring(sessionIdentifier));
        return false;
    end

    itemID = GetItemInfoInstant(itemID);

    if (not GL:higherThanZero(itemID)) then
        GL:warning("Unknown itemID in Auction:create: " .. tostring(itemID));
        return false;
    end

    sessionIdentifier = sessionIdentifier or DB.GDKP.activeSession;

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

    DB.GDKP.Ledger[sessionIdentifier].Auctions[checksum] = Instance;

    Events:fire("GL.GDKP_AUCTION_CHANGED", sessionIdentifier, checksum, {}, Instance);
    Events:fire("GL.GDKP_AUCTION_CREATED", sessionIdentifier, checksum);

    -- Make sure we invalidate this item's history
    GDKPSession.ItemHistory[itemID] = nil;

    return Instance;
end

---@param sessionIdentifier string
---@param auctionIdentifier string
---
---@return void
function Auction:delete(sessionIdentifier, auctionIdentifier, reason)
    GL:debug("Auction:delete");

    local Instance = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));

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

    -- We don't point to Auction here, we want a copy not a pointer!
    local Before = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));
    DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier), Instance);

    Events:fire("GL.GDKP_AUCTION_CHANGED", sessionIdentifier, auctionIdentifier, Before, Instance);
    Events:fire("GL.GDKP_AUCTION_DELETED", sessionIdentifier, auctionIdentifier, Instance);

    return true;
end

---@param sessionIdentifier string
---@param auctionIdentifier string
---
---@return void
function Auction:restore(sessionIdentifier, auctionIdentifier)
    GL:debug("Auction:restore");

    local Instance = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));

    -- The auction could not be found or is not deleted
    if (not Instance or Instance.price) then
        return false;
    end

    -- Sort the states on createdAt so that we can get the most recent state
    table.sort(Instance.PreviousStates or {}, function (a, b)
        if (not tonumber(a.createdAt or 0)
                or not tonumber(b.createdAt or 0)
        ) then
            return true;
        end

        return a.createdAt > b.createdAt;
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

    -- We don't point to Auction here, we want a copy not a pointer!
    local Before = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));
    DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier), Instance);

    Events:fire("GL.GDKP_AUCTION_CHANGED", sessionIdentifier, auctionIdentifier, Before, Instance);
    Events:fire("GL.GDKP_AUCTION_RESTORED", sessionIdentifier, auctionIdentifier);

    return true;
end

--- Store the currently active auction in the session ledger
---
---@param winner string
---@param bid number
---@return boolean
function Auction:storeCurrent(winner, bid)
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

    return self:create(itemID, bid, winner, nil, HighestBidPerPlayer);
end

function Auction:sanitize(Instance)
    local SanitizedAuction = {};

    --[[ Top level Auction check ]]
    if (not Instance
        or type(Instance) ~= "table"
        or type(Instance.CreatedBy) ~= "table"
        or (Instance.Winner and type(Instance.Winner) ~= "table")
        or (Instance.Bids and type(Instance.Bids) ~= "table")
        or date('%Y', tonumber(Instance.createdAt) or 0) == "1970"
        or not tonumber(Instance.itemID)
        or not tonumber(Instance.price or 0) or 0 > 0
    ) then
        GL:xd("Auction:sanitize step 1 failed");
        return false;
    end

    --[[ Auction.CreatedBy ]]
    if (type (Instance.CreatedBy.class) ~= "string"
        or not Constants.Classes[Instance.CreatedBy.class]
        or type (Instance.CreatedBy.name) ~= "string"
        or GL:empty(Instance.CreatedBy.name)
        or type (Instance.CreatedBy.race) ~= "string"
        or not Constants.Races[Instance.CreatedBy.race]
        or type (Instance.CreatedBy.uuid) ~= "string"
        or not string.match(Instance.CreatedBy.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
        or type (Instance.CreatedBy.realm) ~= "string"
        or GL:empty(Instance.CreatedBy.realm)
    ) then
        GL:xd("Auction:sanitize step 2 failed");
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
            GL:xd("Auction:sanitize step 3 failed");
            return;
        end

        SanitizedAuction.CreatedBy.guild = strtrim(createdByGuild);
    end

    --[[ Make sure the item ID is valid ]]
    SanitizedAuction.itemID = GetItemInfoInstant(Instance.itemID);
    if (not SanitizedAuction.itemID or 0 > 0) then
        GL:xd("Auction:sanitize step 4 failed");
        return false;
    end

    --[[ Auction.Bids ]]
    if (Instance.Bids) then
        for key, Bid in pairs(Instance.Bids) do
            if (type(Bid) ~= "table"
                or type(Bid.Bidder) ~= "table"
                or not tonumber(Bid.bid or 0) or 0 > 0
                or date('%Y', tonumber(Bid.createdAt) or 0) == "1970"
            ) then
                GL:xd("Auction:sanitize step 5 failed\n" .. GL.JSON:encode(Bid));
                return false;
            end

            local Bidder = Bid.Bidder;
            if (type (Bidder.class) ~= "string"
                or not Constants.Classes[Bidder.class]
                or type (Bidder.name) ~= "string"
                or GL:empty(Bidder.name)
                or type (Bidder.race) ~= "string"
                or not Constants.Races[Bidder.race]
                or type (Bidder.uuid) ~= "string"
                or not string.match(Bidder.uuid, "^Player%-[0-9]+%-[A-Z0-9]+$")
                or type (Bidder.realm) ~= "string"
                or GL:empty(Bidder.realm)
            ) then
                GL:xd("Auction:sanitize step 6 failed\n" .. GL.JSON:encode(Bidder));
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
                    GL:xd("Auction:sanitize step 7 failed");
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
                or not Constants.Races[Winner.race]
            ))
            or (not GL:empty(Winner.class) and (
                type(Winner.class) ~= "string"
                or not Constants.Classes[Winner.class]
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
            GL:xd("GDKP:sanitize step 8 failed\n" .. GL.JSON:encode(Winner));
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
                GL:xd("Auction:sanitize step 9 failed\n" .. GL.JSON:encode(Winner));
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
        GL:xd("Auction:sanitize step 10 failed");
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
function Auction:reassignAuction(sessionIdentifier, auctionID, winner)
    GL:debug("Auction:reassignAuction");

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
function Auction:move(auctionID, fromSession, toSession)
    GL:debug("Auction:move");

    -- There's nothing to move!
    if (fromSession == toSession) then
        return false;
    end

    local Instance = GL.DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", fromSession, auctionID));

    -- The auction doesn't exist
    if (not Instance) then
        return false;
    end

    -- The target session doesn't exist
    if (not GL.DB:get(string.format("GDKP.Ledger.%s", toSession))) then
        return false;
    end

    -- Copy the auction to its new location
    GL.DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", toSession, auctionID), Instance);

    -- Delete the original auction completely
    GL.DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", fromSession, auctionID), nil);

    Events:fire("GL.GDKP_AUCTION_CHANGED", toSession, auctionID, Instance, Instance);
    Events:fire("GL.GDKP_AUCTION_MOVED", Instance, fromSession, toSession);

    return true;
end

--- Anounce to everyone in the raid that an auction is starting
---
---@param itemLink string
---@param minimumBid number
---@param minimumIncrement number
---@return void
function Auction:announceStart(itemLink, minimumBid, minimumIncrement, duration, antiSnipe)
    GL:debug("GDKP.Auction:announceStart");

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

    if (antiSnipe > 0 and math.floor(duration / antiSnipe) < 2) then
        GL:warning("Antisnipe can be no more than half of the auction time!");
        return false;
    end

    self:listenForBids();

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
                duration = tonumber(duration),
                antiSnipe = tonumber(antiSnipe),
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

    GL:sendChatMessage(
            announceMessage,
            "GROUP"
    );

    return true;
end

--- Anounce to everyone in the raid that the auction has ended
---
---@return void
function Auction:announceStop()
    GL:debug("GDKP.Auction:announceStop");

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
function Auction:announceExtension(time)
    GL:debug("GDKP.Auction:announceExtension");

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

function Auction:extend(CommMessage)
    GL:debug("GDKP.Auction:extend");

    if (not self.Current.initiatorID
        or CommMessage.Sender.id ~= self.Current.initiatorID
    ) then
        GL:debug("GDKP.Auction:extend received by non-initiator");
        return;
    end

    local time = CommMessage.content;
    if (not tonumber(time or 0) or 0 > 0) then
        return GL:error("Invalid time provided in Auction:extend");
    end

    -- There appears to be no active auction
    if (not self.timerId) then
        return;
    end

    local secondsLeft = math.ceil(GL.Ace:TimeLeft(self.timerId) + tonumber(time));
    GL.Ace:CancelTimer(self.timerId);

    self.timerId = GL.Ace:ScheduleTimer(function ()
        self:stop();
    end, secondsLeft);

    GL.Interface.GDKP.Bidder:changeDuration(time);

    SecondsAnnounced = {};
end

--- Start an auction
--- This is done via a CommMessage even for the masterlooter to make
--- sure that the auction starts simultaneously for everyone
---
---@param CommMessage CommMessage
function Auction:start(CommMessage)
    GL:debug("GDKP.Auction:start");

    local content = CommMessage.content;

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
        if (Entry.link ~= self.Current.itemLink
                or CommMessage.Sender.id ~= self.Current.initiatorID
        ) then
            -- This is a new item so make sure to
            -- override all previously set properties
            self.Current = {
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
            self.Current.time = duration;
        end

        self.inProgress = true;

        -- Don't show the bid UI if the user disabled it
        -- and the current user is not the one who initiated the auction
        if (Settings:get("GDKP.showBidWindow")
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
        local numberOfSecondsToCountdown = Settings:get("MasterLooting.numberOfSecondsToCountdown", 5);
        if (self:startedByMe() -- Only post a countdown if this user initiated the auction
                and duration > numberOfSecondsToCountdown -- No point in counting down if there's hardly enough time anyways
                and Settings:get("MasterLooting.doCountdown", false)
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
function Auction:startedByMe()
    return self.Current.initiatorID == GL.User.id;
end

--- Stop a roll off. This method can be invoked internally when the roll
--- off time is over or when announced by the initiation of the roll off.
---
---@param CommMessage string|nil
---@return boolean
function Auction:stop(CommMessage)
    GL:debug("GDKP.Auction:stop");

    if (not self.inProgress) then
        return GL:warning("Can't stop auction, no auction in progress");
    end

    if (CommMessage
            and self.Current.initiatorID ~= GL.User.id
            and CommMessage.Sender.id ~= self.Current.initiatorID
    ) then
        if (self.Current.initiatorID) then
            GL:warning(CommMessage.Sender.name .. " is not allowed to stop auction");
        else
            GL:warning(CommMessage.Sender.name .. " is not allowed to stop current auction: auction is invalid");
        end

        return false;
    end

    -- If this user started the roll then we need to cancel some timers and post a message
    if (self:startedByMe()) then
        -- Announce that the roll has ended
        if (Settings:get("GDKP.announceBidsClosed", true)) then
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
    local NewTopBid = GL:tableGet(CommMessage, "content.TopBid" or {});
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
end

--- Start listening for rolls
---
---@return void
function Auction:listenForBids()
    GL:debug("GDKP.Auction:listenForBids");

    -- Make sure the timer to cancel listening for rolls is cancelled
    if (self.bidListenerCancelTimerId) then
        GL.Ace:CancelTimer(self.bidListenerCancelTimerId);
    end

    if (self.listeningForBids) then
        return;
    end

    self.listeningForBids = true;

    Events:register({
        {"GDKPChatMsgWhisperListener", "CHAT_MSG_WHISPER"},
        {"GDKPChatMsgPartyListener", "CHAT_MSG_PARTY"},
        {"GDKPChatMsgPartyLeaderListener", "CHAT_MSG_PARTY_LEADER"},
        {"GDKPChatMsgRaidListener", "CHAT_MSG_RAID"},
        {"GDKPChatMsgRaidLeaderListener", "CHAT_MSG_RAID_LEADER"},
    }, function (event, message, sender)
        self:processBid(event, message, sender);
    end);
end

--- Unregister the CHAT_MSG_SYSTEM to stop listening for rolls
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

function Auction:bid(message)
    GL:debug("GDKP.Auction:bid");

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
        GL:sendChatMessage(bid, "WHISPER", nil, self.Current.initiatorName, false);
    end
end

--- Return the lowest possible valid bid based on the current bid or the minimum price
---
---@return number
function Auction:lowestValidBid()
    return math.max(
            GL:tableGet(self.Current, "TopBid.bid", 0) + (self.Current.minimumIncrement or 0),
            self.Current.minimumBid
    );
end

function Auction:processBid(event, message, bidder)
    GL:debug("GDKP.Auction:processBid");

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

    if (self.Current
            and self.Current.antiSnipe
    ) then
        local secondsLeft = math.floor(GL.Ace:TimeLeft(self.timerId));

        if (secondsLeft <= self.Current.antiSnipe) then
            self:announceExtension(self.Current.antiSnipe);
        end
    end

    -- Determine the minimum bid
    local minimumBid = math.max(
            self.Current.minimumBid,
            GL:tableGet(self.Current, "TopBid.bid", 0) + self.Current.minimumIncrement
    );

    -- The bid is not high enough for us to accept
    if (BidEntry.bid < minimumBid) then
        GL:sendChatMessage(string.format("Bid denied, the minimum bid is %sg", minimumBid), "WHISPER", nil, bidder);
        return;
    end

    GL:sendChatMessage(string.format("%s is the highest bidder (%sg)", BidEntry.Bidder.name, bid), "GROUP");

    tinsert(self.Current.Bids, BidEntry);
    GL.Interface.GDKP.Auctioneer:refreshRollsTable();

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