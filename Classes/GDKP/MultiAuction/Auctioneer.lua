local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Data
local Constants = GL.Data.Constants;
local CommActions = Constants.Comm.Actions;

---@type GDKPMultiAuctionClient
local Client;

---@type DB
local DB = GL.DB;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

---@type Settings
local Settings = GL.Settings;

---@class GDKPMultiAuctionAuctioneer
GL:tableSet(GL, "GDKP.MultiAuction.Auctioneer", {
    _initialized = false,
    waitingForAuctionStart = false,
    LastBidAt = {},

    IDsChangedSinceLastSync = {},
    IDsToAnnounce = {},
});

---@type GDKPMultiAuctionAuctioneer
local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;

---@type GDKPAuction
local GDKPAuction = GL.GDKP.Auction;

---@type GDKPMultiAuctionAuctioneerInterface
local UI;

--[[ CONSTANTS ]]
local ENDS_AT_OFFSET = 1697932800;
local BIDDING_LEEWAY = 3;

---@return void
function Auctioneer:_init()
    if (self._initialized) then
        return;
    end

    UI = GL.Interface.GDKP.MultiAuction.Auctioneer;
    Client  = GL.GDKP.MultiAuction.Client;

    -- Keep track of when our group setup changed (happens on initial log in only)
    local synced = false;
    GL.Events:register("GDKPMultiAuctionAuctioneerGroupUpdateListener", "GL.GROUP_ROSTER_UPDATE_THROTTLED", function ()
        synced = true;

        -- Check if we need to sync up with an existing multi-auction session
        self:syncWithRunningSession();
    end);

    -- If the user reloads instead of a login we have to wait a couple seconds for the game to update the group setup
    GL:after(5, "GDKP.MultiAuction.syncWithRunningSession", function ()
        if (not synced or self:auctionStartedByMe()) then
            synced = true;

            -- Check if we need to sync up with an existing multi-auction session
            self:syncWithRunningSession();
        end
    end);

    self._initialized = true;
end

---@param minimumQuality number
---@param includeBOEs boolean
---@param includeAwarded boolean
---@param includeMaterials boolean
---@return void
function Auctioneer:fillFromInventory(minimumQuality, includeBOEs, includeAwarded, includeMaterials)
    includeBOEs = includeBOEs ~= false;
    includeMaterials = includeMaterials == true;
    includeAwarded = includeAwarded == true;

    GL:forEachItemInBags(function (Location, bag, slot)
        local itemQuality = tonumber(C_Item.GetItemQuality(Location));
        if (not itemQuality) then
            return;
        end

        -- The item doesn't have the required minimum
        if (C_Item.GetItemQuality(Location) < minimumQuality) then
            return;
        end

        -- Check if we need to exclude reagents
        if (not includeMaterials) then
            local classID = select(12, GetItemInfo(C_Item.GetItemID(Location)));

            -- We don't need trade goods / crafting reagents
            if (classID == Enum.ItemClass.Tradegoods
                or classID == Enum.ItemClass.Gem
            ) then
                return;
            end
        end

        -- Item is not soulbound or does not have any trade time remaining
        local timeRemaining = GL:inventoryItemTradeTimeRemaining(bag, slot);
        if (timeRemaining < 15 or ( -- 15 seconds is the absolute minimum, anything less than that simply doesn't make sense
            not includeBOEs
            and timeRemaining == Constants.itemIsNotBound)
        ) then
            return;
        end

        -- Check if we want to include previously awarded items
        local itemGUID = C_Item.GetItemGUID(Location);
        if (itemGUID and not includeAwarded and DB:get("RecentlyAwardedItems." .. itemGUID)) then
            return;
        end

        local itemLink = C_Item.GetItemLink(Location);

        UI:addItemByLink(itemLink, itemGUID);
    end);

    UI:filterAndSort();
end

--- Check whether the given or current user is allowed to broadcast
---
---@return boolean
function Auctioneer:userIsAllowedToBroadcast(playerID)
    -- If no player is given we assume self
    if (type(playerID) ~= "string"
        or playerID == GL.User.id
    ) then
        return not GL.User.isInGroup or (
            -- If the user is severely outdated we won't let him broadcast
            GL.Version.lastNotBackwardsCompatibleNotice < 1 and (
                GL.User.isLead
                or GL.User.isMasterLooter
            )
        );
    end

    if (self.inProgress) then
        return self.initiatorID == playerID;
    end

    return GL.Player:isMasterLooter(playerID)
        or GL.Player:hasAssist(playerID);
end

---@return void
function Auctioneer:disenchant(itemLink)
    GL.PackMule:disenchant(itemLink, true, function ()
        if (Settings:get("GDKP.minimizeAuctioneerOnAward")) then
            UI = UI or GL.Interface.GDKP.Auctioneer;
            local Window = UI:getWindow();

            if (not Window) then
                return;
            end

            Window.Minimize.MinimizeButton:Click();
        end

        self:clear();
        Auctioneer:start();
    end);
end

---@param ItemDetails table table objects should contain link, minimum and increment
---@param duration number
---@param antiSnipe number
---@return void
function Auctioneer:start(ItemDetails, duration, antiSnipe)
    local ItemsUpForAuction = {};
    local MinAndIncrementPerLink = {};

    for _, Item in pairs(ItemDetails or {}) do
        MinAndIncrementPerLink[Item.link] = {
            minimum = Item.minimum,
            increment = Item.increment,
        };

        self:storeDetailsForFutureAuctions{
            link = Item.link,
            minimum = Item.minimum,
            increment = Item.increment,
        };
    end

    -- Prepare all item data needed to start the multi-auction
    local auctionID = 1;
    GL:onItemLoadDo(GL:tableColumn(ItemDetails, "link"), function (Items)
        for _, Item in pairs(Items or {}) do
            tinsert(ItemsUpForAuction, {
                auctionID = auctionID,
                isBOE = GL:inTable({ LE_ITEM_BIND_ON_EQUIP, LE_ITEM_BIND_QUEST }, Item.bindType),
                itemLevel = Item.level,
                name = Item.name,
                quality = Item.quality,
                link = Item.link,
                minimum = MinAndIncrementPerLink[Item.link].minimum,
                increment = MinAndIncrementPerLink[Item.link].increment,
            });

            auctionID = auctionID + 1;
        end

        if (not self:announceStart(ItemsUpForAuction, duration, antiSnipe)) then
            return;
        end
    end);
end

--- We just came back online, check and see if there's an active MultiAuction session
--- that we need to sync with or have to take over in case we were the organizer
---
---@return void
function Auctioneer:syncWithRunningSession()
    if (not GL.User.isInGroup or not GL:empty(Client.AuctionDetails)) then
        return;
    end

    local numberOfActiveGroupMembers = 0;
    local HashOccurrences = {};
    local PlayersPerHash = {};
    local processResults = function(CommMessage)
        local CheckedHashed = {};
        for _, response in pairs(CommMessage.Responses) do
            (function()
                -- No need to check our own data
                if (response.Sender.isSelf) then
                    return;
                end

                -- check if the given session hash is valid
                local sessionHash = response.content;
                if (type(sessionHash) ~= "string"
                    or GL:empty(sessionHash)
                ) then
                    return;
                end

                -- This is a new hash, check if the initiator is a group member
                if (not HashOccurrences[sessionHash]) then
                    -- We already checked this hash and deemed it useless, skip!
                    if (CheckedHashed[sessionHash]) then
                        return;
                    end

                    -- Determine the session initiator, which is part of the session hash
                    local initiator = GL:explode(sessionHash, ".")[2];
                    if (type(initiator) ~= "string"
                        or GL:empty(initiator)
                    ) then
                        return;
                    end

                    -- If we're not the initiator then make sure the initiator is in our group and online
                    local initiatedBySelf = GL:iEquals(GL.User.fqn, initiator);
                    if (not initiatedBySelf and (
                        -- The organizer is not part of our group, this is probably deprecated data
                        not GL.User:unitInGroup(initiator)

                        -- The initiator is not online so there's no point continuing
                        -- If he does come online at some point then he'll automatically share his data with us
                        or not GL:unitIsConnected(initiator)
                    )) then
                        CheckedHashed[sessionHash] = true;
                        return;
                    end
                end

                CheckedHashed[sessionHash] = true;
                HashOccurrences[sessionHash] = HashOccurrences[sessionHash] and HashOccurrences[sessionHash] + 1 or 1;
                PlayersPerHash[sessionHash] = PlayersPerHash[sessionHash] or {};
                tinsert(PlayersPerHash[sessionHash], response.Sender.fqn);
            end)();
        end

        -- No data available
        if (GL:empty(HashOccurrences)) then
            return;
        end

        -- Check which hash is most common and therefore most likely correct
        local mostCommonHash;
        local highestCount = 0;
        for hash, count in pairs(HashOccurrences or {}) do
            if (count > highestCount) then
                highestCount = count;
                mostCommonHash = hash;
            end
        end

        -- This is a failsafe to make sure a single person can't wreak havoc (except when testing with a single friend)
        if (numberOfActiveGroupMembers > 1
            and highestCount < 2
        ) then
            return;
        end

        -- Request an update from the initiator
        local playerToFetchDataFrom = GL:explode(mostCommonHash, ".")[2];
        local initiatedBySelf = GL:iEquals(GL.User.fqn, playerToFetchDataFrom);

        -- We can't fetch the data from ourselves, try and find a suitable target!
        if (initiatedBySelf) then
            playerToFetchDataFrom = nil;
            local activeSessionID = GL.GDKP.Session:activeSessionID();

            -- If there's no session then there's nothing we can do for now sadly
            if (not activeSessionID) then
                return;
            end

            for _, player in pairs(PlayersPerHash[mostCommonHash]) do
                if (GL.User:unitInGroup(player) and GL:unitIsConnected(player)) then
                    playerToFetchDataFrom = player;
                    break;
                end
            end
        end

        -- Technically impossible, but better safe than lua error
        if (not playerToFetchDataFrom) then
            return;
        end

        GL.CommMessage.new(
            CommActions.requestRunningGDKPMultiAuctionDetails,
            nil,
            "WHISPER",
            playerToFetchDataFrom,
            function (Response)
                Response = Response.content;
                if (type(Response) ~= "table"
                    or type(Response.initiator) ~= "string"
                    or GL:empty(Response.initiator)
                    or type(Response.bth) ~= "string"
                    or GL:empty(Response.bth)
                    or type(Response.Auctions) ~= "table"
                    or GL:empty(Response.Auctions)
                ) then
                    return;
                end

                if (not initiatedBySelf) then
                    Client:start({
                        Sender = {
                            id = Response.initiator,
                            fqn = Response.initiator,
                        },
                        content = {
                            antiSnipe = Response.antiSnipe,
                            bth = Response.bth,
                            ItemDetails = Response.Auctions,
                        },
                    });
                else
                    local KnownAwardHashes = {};
                    for _, Auction in pairs(GL.GDKP.Session:getActive().Auctions or {}) do
                        if (type(Auction.Winner) == "table"
                            and Auction.itemID
                            and Auction.Winner.guid
                        ) then
                            KnownAwardHashes[GL:stringHash{
                                Auction.itemID,
                                Auction.Winner.guid,
                                Auction.price
                            }] = true;
                        end
                    end ;

                    local ExtendIDs = {};

                    -- Check if there are any auctions worth resuming
                    local anHourAgo = GetServerTime() - 3600;
                    for auctionID, Auction in pairs(Response.Auctions) do
                        (function()
                            -- This auction was deleted or otherwise made unavailable
                            -- There's also no point in trying to continue ancient auctions
                            if (Auction.endsAt < 0
                                or Auction.endsAt < anHourAgo
                            ) then
                                return;
                            end

                            ---@todo: check if needed or ID is available
                            local itemID = GL:getItemIDFromLink(Auction.link);
                            local bid = tonumber(Auction.CurrentBid and Auction.CurrentBid.amount or 0) or 0;

                            -- There weren't any bids on this auction yet so we can safely extend it
                            if (not bid) then
                                tinsert(ExtendIDs, auctionID);
                                return;
                            end

                            -- It looks like this auction ran out while we were away and already had a bid
                            -- Check to see if we can extend it or whether it was already sold
                            if (Auction.endsAt == 0
                                and bid > 0
                                and KnownAwardHashes[GL:stringHash{
                                    itemID,
                                    strlower(Auction.CurrentBid.player),
                                    bid,
                                }]
                            ) then
                                return;
                            end

                            tinsert(ExtendIDs, auctionID);
                        end)();
                    end

                    -- There's nothing we need to do at this point
                    if (GL:empty(ExtendIDs)) then
                        return;
                    end

                    -- There are active auctions already, no need to resume anything
                    for _, Details in pairs(Client.AuctionDetails.Auctions or {}) do
                        if (Details.endsAt > 0) then
                            return;
                        end
                    end

                    GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open{
                        question = "You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items",
                        inputValue = 60,
                        OnYes = function (duration)
                            duration = tonumber(duration) or 5;

                            local endsAt = GetServerTime() + duration;
                            for _, auctionID in pairs(ExtendIDs) do
                                Response.Auctions[auctionID].endsAt = endsAt;
                            end

                            GL:mute();
                            self:announceStart(Response.Auctions, duration, Response.antiSnipe);
                            GL:unmute();
                            GL:sendChatMessage("I resumed a previous bidding session, double check your bids!", "GROUP");
                        end,
                        focus = true,
                    };
                end
            end
        ):send();
    end;

    -- Check how many answers we're expecting on our next comm message
    GL:forEachGroupMember(function (Member)
        if (Member.online
            and not GL:iEquals(Member.fqn, GL.User.fqn)
        ) then
            numberOfActiveGroupMembers = numberOfActiveGroupMembers + 1;
        end
    end);

    -- It doesn't look like anyone is online
    if (numberOfActiveGroupMembers < 1) then
        return;
    end

    -- Get a current session hash from users so we can figure out which data to request
    local CommMessage = GL.CommMessage.new(
        CommActions.requestRunningGDKPMultiAuctionHash,
        nil,
        "GROUP"
    ):send();

    local cancelTimers = function()
        GL:cancelTimer("GDKP.MultiAuction.requestRunningGDKPMultiAuctionHash");
        GL:cancelTimer("GDKP.MultiAuction.requestRunningGDKPMultiAuctionHashInterval");
    end;

    -- Report back as soon as all the answers are in
    self.RecurringCheckTimer = GL:interval(.2, "GDKP.MultiAuction.requestRunningGDKPMultiAuctionHashInterval", function ()
        -- We received an answer from everyone
        if (GL:count(CommMessage.Responses or {}) >= numberOfActiveGroupMembers) then
            cancelTimers();
            processResults(CommMessage);
        end
    end, .2);

    -- Even if we're still missing an answer from some of the group members
    -- we still want to make sure our inspection end after a set amount of time
    GL:after(3, "GDKP.MultiAuction.requestRunningGDKPMultiAuctionHash", function ()
        cancelTimers();
        processResults(CommMessage);
    end);
end

--- Announce to everyone in the raid that a MultiAuction is starting
---
---@param ItemDetails table
---@param duration number
---@param antiSnipe number
---@return boolean
function Auctioneer:announceStart(ItemDetails, duration, antiSnipe)
    local serverTime = GetServerTime();

    -- We're still waiting for a MultiAuction to start
    if (self.waitingForAuctionStart
        and serverTime - self.waitingForAuctionStart < 6
    ) then
        return false;
    end

    if (not Auctioneer:userIsAllowedToBroadcast()) then
        self.waitingForAuctionStart = false;
        return false;
    end

    self.LastBidAt = {};
    self.waitingForAuctionStart = serverTime;
    duration = tonumber(duration) or 0;
    antiSnipe = tonumber(antiSnipe) or 0;

    if (duration < 1
        or antiSnipe < 0
    ) then
        GL:warning("Invalid data provided for GDKP auction start!");
        self.waitingForAuctionStart = false;
        return false;
    end

    local endsAt = math.ceil(serverTime + duration);
    local defaultMinimumBid = DB:get("GDKP.defaultMinimumBid");
    local defaultIncrement = DB:get("GDKP.defaultIncrement");
    for _, Details in pairs(ItemDetails or {}) do
        Details.minimum = Details.minimum >= 0 and Details.minimum or defaultMinimumBid;
        Details.increment = Details.increment >= 0 and Details.increment or defaultIncrement;
        Details.endsAt = Details.endsAt and Details.endsAt <= 0 and Details.endsAt or endsAt;
    end

    self:scheduleUpdater();

    GL.CommMessage.new(
        CommActions.startGDKPMultiAuction,
        {
            ItemDetails = ItemDetails,
            endsAt = endsAt,
            antiSnipe = antiSnipe,
            bth = GL.User:bth(),
        },
        "GROUP"
    ):send();

    local channel = "GROUP";
    if (GL.User.isInRaid and GL.User.hasAssist) then
        channel = "RAID_WARNING";
    end

    GL:sendChatMessage("I started a bidding session. Can't see it? Make sure to download/update Gargul!", channel);

    return true;
end

--- Send all top bids to the group
---
---@return void
function Auctioneer:scheduleUpdater()
    GL:interval(.8, "GDKP.MultiAuction.auctionUpdated", function ()
        local serverTime = GetServerTime();
        -- Check if there are newly closed auctions
        for auctionID, Details in pairs(Client.AuctionDetails.Auctions or {}) do
            local lastBidAt = self.LastBidAt[auctionID] or serverTime - BIDDING_LEEWAY - 1;

            if (Details.endsAt > 0
                and serverTime - Details.endsAt > BIDDING_LEEWAY
                and serverTime - lastBidAt > BIDDING_LEEWAY
            ) then
                self:closeAuction(auctionID);
            end
        end

        -- No need to broadcast if nothing changed
        if (GL:empty(self.IDsChangedSinceLastSync)) then
            return;
        end

        local changesAvailable = false;
        local Changes = {};
        local UniqueIDs = GL:tableUnique(self.IDsChangedSinceLastSync);
        self.IDsChangedSinceLastSync = {};
        for _, auctionID in pairs(UniqueIDs or {}) do
            (function()
                local Details = Client.AuctionDetails.Auctions[auctionID];
                if (not Details) then
                    return;
                end

                auctionID = math.floor(tonumber(auctionID) or 0);
                if (auctionID < 1 or self.IDsToAnnounce[auctionID]) then
                    return;
                end

                local bid = tonumber(GL:tableGet(Details, "CurrentBid.amount", 0)) or 0;
                Changes[auctionID] = {
                    p = GL:tableGet(Details, "CurrentBid.player"),
                    a = bid / 1000,
                    e = Details.endsAt > 0 and Details.endsAt - ENDS_AT_OFFSET or Details.endsAt,
                };

                changesAvailable = true;
            end)();
        end

        if (not changesAvailable) then
            return;
        end

        GL.CommMessage.new(
            CommActions.announceChangesForGDKPMultiAuction,
            Changes,
            "GROUP"
        ):send();
    end);
end

---@return void
function Auctioneer:syncNewItems()
    local Changes = {};
    for id, announce in pairs(self.IDsToAnnounce or {}) do
        if (announce
            and Client.AuctionDetails.Auctions[id]
        ) then
            local Details = Client.AuctionDetails.Auctions[id];

            Changes[id] = {
                I = Details,
                p = GL:tableGet(Details, "CurrentBid.player"),
                a = tonumber(GL:tableGet(Details, "CurrentBid.amount", 0)) or 0,
                e = Details.endsAt,
            };
        end

        self.IDsToAnnounce[id] = nil;
    end

    self.IDsToAnnounce = {};
    local numberOfChanges = GL:count(Changes);
    if (numberOfChanges < 1) then
        return;
    end

    GL.CommMessage.new(
        CommActions.announceChangesForGDKPMultiAuction,
        Changes,
        "GROUP"
    ):send();

    GL:sendChatMessage(
        ("I added %s item(s) to the auction for a total of %s"):format(numberOfChanges, GL:count(Client.AuctionDetails.Auctions)),
        "GROUP"
    );
end

--- Attempt to process an incoming bid
---
---@param Message CommMessage
---@return void
function Auctioneer:processBid(Message)
    if (not self:auctionStartedByMe()) then
        return;
    end

    local auctionID = GL:tableGet(Message, "content.auctionID");

    -- The given auction doesn't exist
    if (not auctionID or not GL:tableGet(Client, "AuctionDetails.Auctions." .. auctionID)) then
        return;
    end

    -- Regardless of what happens make sure to extend the auction if needed
    local serverTime = GetServerTime();
    local secondsLeft = Client.AuctionDetails.Auctions[auctionID].endsAt - serverTime;

    -- This auction has "long" ended
    if (secondsLeft <= (BIDDING_LEEWAY * -1)) then
        return;
    end

    -- This user is not in our group
    if (not GL.User:unitInGroup(Message.Sender.fqn) or not GL:unitIsConnected(Message.Sender.fqn)) then
        return;
    end

    if (secondsLeft <= Client.AuctionDetails.antiSnipe) then
        -- Make sure we spread the news about this reschedule
        Client.AuctionDetails.Auctions[auctionID].endsAt = serverTime + Client.AuctionDetails.antiSnipe;

        tinsert(self.IDsChangedSinceLastSync, auctionID);
    end

    local bid = tonumber(GL:tableGet(Message, "content.bid", 0)) or 0;

    -- Make sure the bid is actually valid
    if (not Client:isBidValidForAuction(auctionID, bid)) then
        return;
    end

    -- We're top bidder again
    if (Client.AuctionDetails.Auctions[auctionID].iWasOutBid
        and Message.Sender.isSelf
    ) then
        Client.AuctionDetails.Auctions[auctionID].iWasOutBid = false;

    -- We were top bidder but not anymore
    elseif (not Client.AuctionDetails.Auctions[auctionID].iWasOutBid
        and not Message.Sender.isSelf
        and GL:iEquals(GL:tableGet(Client.AuctionDetails.Auctions[auctionID], "CurrentBid.player", ""), GL.User.fqn)
    ) then
        Client:outbidNotification();

        Client.AuctionDetails.Auctions[auctionID].iWasOutBid = true;
    end

    self.LastBidAt[auctionID] = GetServerTime();

    tinsert(self.IDsChangedSinceLastSync, auctionID);
    Client.AuctionDetails.Auctions[auctionID].CurrentBid = {
        amount = bid,
        player = Message.Sender.fqn,
    };
end

--- Was the given auction ID (or current multi-auction as a whole) started by us
---
---@return boolean
function Auctioneer:auctionStartedByMe(auctionID)
    if (auctionID and not GL:tableGet(Client, "AuctionDetails.Auctions." .. auctionID)) then
        return false;
    end

    return Client.AuctionDetails and Client.AuctionDetails.initiator == GL.User.fqn;
end

--- Mark an auction as deleted
---
---@param auctionID string
---@return void
function Auctioneer:deleteAuction(auctionID)
    if (self:auctionIsFinalized(auctionID)) then
        return;
    end

    Client.AuctionDetails.Auctions[auctionID].endsAt = -1;

    if (Client.AuctionDetails.Auctions[auctionID].CurrentBid) then
        Client.AuctionDetails.Auctions[auctionID].CurrentBid = nil;
    end

    self.LastBidAt[auctionID] = nil;
    tinsert(self.IDsChangedSinceLastSync, auctionID);
end

--- Close an auction
---
---@param auctionID string
---@return void
function Auctioneer:closeAuction(auctionID)
    if (self:auctionIsFinalized(auctionID)) then
        return;
    end

    local BidDetails = GL:tableGet(Client, ("AuctionDetails.Auctions.%s.CurrentBid"):format(auctionID));
    if (BidDetails) then
        local itemLink = Client.AuctionDetails.Auctions[auctionID].link;

        GL:mute(); -- We don't want an announcement for every awarded item since people can see it for themselves in /gl bid
        local awardChecksum = GL.AwardedLoot:addWinner(BidDetails.player, itemLink, nil, nil, nil, nil, BidDetails.amount);
        GDKPAuction:create(GL:getItemIDFromLink(itemLink), BidDetails.amount, BidDetails.player, nil, nil, nil, awardChecksum);
        GL:unmute();
    end

    self.LastBidAt[auctionID] = nil;
    Client.AuctionDetails.Auctions[auctionID].endsAt = 0;
    tinsert(self.IDsChangedSinceLastSync, auctionID);
end

--- Clear an auction's current bid
---
---@param auctionID string
---@return void
function Auctioneer:clearBid(auctionID)
    if (self:auctionIsFinalized(auctionID)
        or GL:empty(Client.AuctionDetails.Auctions[auctionID].CurrentBid)
    ) then
        return;
    end

    Client.AuctionDetails.Auctions[auctionID].CurrentBid = nil;
    Client.AuctionDetails.Auctions[auctionID].iWasOutBid = false;

    self.LastBidAt[auctionID] = nil;
    tinsert(self.IDsChangedSinceLastSync, auctionID);
end

--- Check if we're still allowed to edit this auction
---
---@return boolean
function Auctioneer:auctionIsFinalized(auctionID)
    if (not GL:tableGet(Client, "AuctionDetails.Auctions." .. auctionID) -- Auction doesn't exist
        or Client.AuctionDetails.Auctions[auctionID].endsAt == -1 -- Auction was deleted
        or (Client.AuctionDetails.Auctions[auctionID].endsAt == 0 -- Auction closed with winning bid
            and Client.AuctionDetails.Auctions[auctionID].CurrentBid
        )
    ) then
        return true;
    end

    return false;
end

--- Give a last 10 second timer for the given auction
---
---@param auctionID string
---@return void
function Auctioneer:finalCall(auctionID, seconds)
    if (self:auctionIsFinalized(auctionID)) then
        return;
    end

    seconds = seconds or GL.Settings:get("GDKP.finalCallTime");
    Client.AuctionDetails.Auctions[auctionID].endsAt = GetServerTime() + seconds;
    tinsert(self.IDsChangedSinceLastSync, auctionID);
end

--- Wrap up the current multi-auction session
---
---@param announcePot boolean
---@return void
function Auctioneer:finish(announcePot)
    announcePot = announcePot ~= false;

    for auctionID in pairs(Client.AuctionDetails.Auctions or {}) do
        self:closeAuction(auctionID);
    end

    if (not announcePot) then
        return;
    end

    local totalPot = GDKPPot:total();
    if (totalPot) then
        GL:sendChatMessage(("Multi-auction finished. " .. L.POT_HOLDS):format(tostring(totalPot)), "GROUP");
    end
end

--- Terminate the current multi-auction session by removing all bids and closing everything
---
---@return void
function Auctioneer:terminate()
    for auctionID in pairs(Client.AuctionDetails.Auctions or {}) do
        self:clearBid(auctionID);
        self:closeAuction(auctionID);
    end
end

--- Store auction details for future use (increment, minimum)
---
---@param Details table
---@return void
function Auctioneer:storeDetailsForFutureAuctions(Details)
    local itemID = GL:getItemIDFromLink(Details.link);

    if (not itemID) then
        return;
    end

    -- [[ MINIMUM AND INCREMENT ]]
    if (Settings:get("GDKP.storeMinimumAndIncrementPerItem")) then
        local minimum = tonumber(Details.minimum) or 0;
        minimum = math.floor(minimum);

        if (minimum < 1) then
            minimum = DB:get("GDKP.defaultMinimumBid");
        end

        local increment = tonumber(Details.increment) or 0;
        increment = math.floor(increment);

        if (increment < 1) then
            increment = DB:get("GDKP.defaultIncrement");
        end

        DB:set("GDKP.SettingsPerItem." .. itemID, {
            minimum = minimum,
            increment = increment
        });
    end
end
