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

---@type GDKP
local GDKP = GL.GDKP;

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
local UPDATE_INTERVAL = 2;

---@return void
function Auctioneer:_init()
    if (self._initialized) then
        return;
    end

    UI = GL.Interface.GDKP.MultiAuction.Auctioneer;
    Client  = GL.GDKP.MultiAuction.Client;

    -- If the user reloads instead of a login we have to wait a couple seconds for the game to update the group setup
    GL:after(5, "GDKP.MultiAuction.syncWithRunningSession", function ()
        if (not self:auctionStartedByMe()) then
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
        if (itemQuality < minimumQuality) then
            return;
        end

        -- Check if we consider this a sellable item
        local itemID = C_Item.GetItemID(Location);
        if (GL:inTable(Constants.ItemsThatShouldntBeAnnounced, itemID)) then
            return;
        end

        -- Exclude projectiles (bullets and arrows)
        local classID = select(12, GL:getItemInfo(itemID));
        if (classID == Enum.ItemClass.Projectile) then
            return;
        end

        -- Exclude enchantments (Eternal Belt Buckle, Frosthide Leg Armor, Greater Inscription of the Axe etc)
        if (classID == Enum.ItemClass.Consumable
            and itemQuality > 2
        ) then
            return;
        end

        -- Check if we need to exclude reagents
        if (not includeMaterials) then
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
---@param player string Player name or GUID
---@return boolean
function Auctioneer:userIsAllowedToBroadcast(player)
    -- If no player is given we assume self
    if (type(player) ~= "string"
        or player == GL.User.id
    ) then
        return not GL.User.isInGroup or (
            -- If the user is severely outdated we won't let him broadcast
            GL.Version.lastNotBackwardsCompatibleNotice < 1 and (
                GL.User.isLead
                or GL.User.isMasterLooter
            )
        );
    end

    return GL.Player:isMasterLooter(player)
        or GL.Player:hasAssist(player);
end

---@param ItemDetails table table objects should contain link, minimum and increment
---@param duration number
---@param antiSnipe number
---
---@return void
function Auctioneer:start(ItemDetails, duration, antiSnipe)
    local ItemsUpForAuction = {};
    local MinAndIncrementPerLink = {};
    local precision = Settings:get("GDKP.precision");

    for _, Item in pairs(ItemDetails or {}) do
        MinAndIncrementPerLink[Item.link] = {
            minimum = GL:floor(Item.minimum, precision),
            increment = GL:floor(Item.increment, precision),
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
                isBOE = GL:inTable({ LE_ITEM_BIND_ON_EQUIP, LE_ITEM_BIND_QUEST, }, Item.bindType),
                itemLevel = Item.level,
                name = Item.name,
                quality = Item.quality,
                link = Item.link,
                minimum = MinAndIncrementPerLink[Item.link].minimum,
                increment = MinAndIncrementPerLink[Item.link].increment,
            });

            auctionID = auctionID + 1;
        end

        if (not self:announceStart(ItemsUpForAuction, duration, antiSnipe, precision)) then
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
        for _, response in pairs(CommMessage.Responses or {}) do
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

        GL.CommMessage.new{
            action = CommActions.requestRunningGDKPMultiAuctionDetails,
            channel = "WHISPER",
            recipient = playerToFetchDataFrom,
            onResponse = function (Response)
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

                -- We didn't initiate this running auction so just join it
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

                    return;
                end

                -- We initiated this running auction so we'll have to take over by setting a new timer for remaining items
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
                            and GL:gt(bid, 0)
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
                    question = L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION,
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
                        GL:sendChatMessage(L.CHAT.MULTIAUCTION_RESUMED, "GROUP");
                    end,
                    focus = true,
                };
            end,
        }:send();
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
    local CommMessage = GL.CommMessage.new{
        action = CommActions.requestRunningGDKPMultiAuctionHash,
        channel = "GROUP",
        acceptsResponse = true,
    }:send();

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

---@param Message CommMessage
---@return void
function Auctioneer:respondToDetailsRequest(Message)
    if (Message.Sender.isSelf) then
        return;
    end

    -- This person just got online, make sure to delete all his auto bids
    if (self:auctionStartedByMe()) then
        self:clearAutoBidsForPlayer(Message.Sender.fqn);
    end

    local AuctionDetails = GL.GDKP.MultiAuction.Client.AuctionDetails or {};
    if (GL:empty(AuctionDetails.Auctions)) then
        return;
    end

    Message:respond{
        Auctions = AuctionDetails.Auctions,
        antiSnipe = AuctionDetails.antiSnipe,
        bth = AuctionDetails.bth,
        initiator = AuctionDetails.initiator,
    };
end

--- Announce to everyone in the raid that a MultiAuction is starting
---
---@param ItemDetails table
---@param duration number
---@param antiSnipe number
---@param precision number
---@return boolean
function Auctioneer:announceStart(ItemDetails, duration, antiSnipe, precision)
    local serverTime = GetServerTime();

    -- We're still waiting for a MultiAuction to start
    if (self.waitingForAuctionStart
        and serverTime - self.waitingForAuctionStart < 10
    ) then
        GL:error((L.WAIT_SECONDS_BEFORE_RETRY):format(10 - (serverTime - self.waitingForAuctionStart)));
        return false;
    end

    if (not self:userIsAllowedToBroadcast()) then
        GL:error(L.LM_OR_ASSIST_REQUIRED);
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
        GL:warning(L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START);
        self.waitingForAuctionStart = false;
        return false;
    end

    local endsAt = math.ceil(serverTime + duration);
    local defaultMinimumBid = DB:get("GDKP.defaultMinimumBid");
    local defaultIncrement = DB:get("GDKP.defaultIncrement");
    for _, Details in pairs(ItemDetails or {}) do
        Details.minimum = GL:gte(Details.minimum, 0) and Details.minimum or defaultMinimumBid;
        Details.increment = GL:gte(Details.increment, 0) and Details.increment or defaultIncrement;
        Details.endsAt = Details.endsAt and Details.endsAt <= 0 and Details.endsAt or endsAt;
    end

    self.waitingForAuctionStart = serverTime;

    ProgressBar = LibStub("LibCandyBarGargul-3.0"):New(
        "Interface/AddOns/Gargul/Assets/Textures/timer-bar",
        max(UIParent:GetWidth() / 4, 250),
        30
    );
    ProgressBar:SetParent(UIParent);
    ProgressBar:SetPoint("CENTER", UIParent, "CENTER");
    ProgressBar:SetPoint("BOTTOM", UIParent, "BOTTOM", 0, 100);
    ProgressBar:SetDuration(100 * 1000000);
    ProgressBar:SetColor(0, 1, 0, .3);
    ProgressBar:SetTimeVisibility(false);
    ProgressBar:SetFill(true);
    ProgressBar:Start();
    ProgressBar:SetLabel(GL:printfn(L.BROADCAST_PROGRESS, { percentage = 0, }));

    GL.CommMessage.new{
        action = CommActions.startGDKPMultiAuction,
        content = {
            ItemDetails = ItemDetails,
            endsAt = endsAt,
            antiSnipe = antiSnipe,
            bth = GL.User:bth(),
            precision = precision,
        },
        channel = "GROUP",
    }:send(function ()
        ProgressBar:Stop();

        self:scheduleUpdater();

        -- Let people know that we've started a multi-auction
        GL:sendChatMessage(L.CHAT.MULTIAUCTION_STARTED, "RAID_WARNING");

        self.waitingForAuctionStart = false;
    end, function (sent, total)
        local progressPercentage = ceil(100 / (total / sent));

        ProgressBar:SetLabel(GL:printfn(L.BROADCAST_PROGRESS, { percentage = progressPercentage, }));
        ProgressBar:SetDuration((100 * 1000000) - (progressPercentage * 1000000));
        ProgressBar:Start(100 * 1000000);
    end);

    return true;
end

--- Send all top bids to the group
---
---@return void
function Auctioneer:scheduleUpdater()
    GL:interval(UPDATE_INTERVAL, "GDKP.MultiAuction.auctionUpdated", function ()
        if (not self:auctionStartedByMe()) then
            GL:cancelTimer("GDKP.MultiAuction.auctionUpdated");
            return;
        end

        -- Check if there are newly closed auctions
        local activeAuctions = false;
        local serverTime = GetServerTime();
        for auctionID, Details in pairs(Client.AuctionDetails.Auctions or {}) do
            (function()
                if (Details.endsAt <= 0) then
                    return;
                end

                -- We check all this separately in order to improve performance
                local lastBidAt = self.LastBidAt[auctionID] or serverTime - BIDDING_LEEWAY - 1;

                if (serverTime - Details.endsAt > BIDDING_LEEWAY
                    and serverTime - lastBidAt > BIDDING_LEEWAY
                ) then
                    return self:closeAuction(auctionID);
                end

                activeAuctions = true;
            end)();
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

        GL.CommMessage.new{
            action = CommActions.announceChangesForGDKPMultiAuction,
            content = Changes,
            channel = "GROUP",
        }:send();
    end);
end

---@param player string
---@return void
function Auctioneer:clearAutoBidsForPlayer(player)
    player = GDKP:playerGUID(player);

    for _, Auction in pairs(Client.AuctionDetails.Auctions) do
        if (Auction.AutoBids
            and Auction.AutoBids[player]
        ) then
            Auction.AutoBids[player] = nil;
        end
    end
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

    GL.CommMessage.new{
        action = CommActions.announceChangesForGDKPMultiAuction,
        content = Changes,
        channel = "GROUP",
    }:send();

    GL:sendChatMessage(
        (L.CHAT.MULTIAUCTION_ITEMS_ADDED):format(numberOfChanges, GL:count(Client.AuctionDetails.Auctions)),
        "GROUP"
    );
end

--- Process all known auto bids for the given auction
---
--- If a manualBid is provided as well then we'll return true or false based on whether the
--- provided bid would be the top bid, trumping all auto bids
---
---@param auctionID number
---
---@return boolean
function Auctioneer:processAutoBids(auctionID)
    local ValidOutstandingAutoBids = {};
    local AutoBids = GL:tableGet(Client, ("AuctionDetails.Auctions.%s.AutoBids"):format(auctionID));

    if (not AutoBids) then
        return true;
    end

    -- Check all auto bids for validity. If they're valid then they will contribute
    -- to the current top bid
    local highestAutoBid = 0;
    for player, Details in pairs(Client.AuctionDetails.Auctions[auctionID].AutoBids) do
        (function()
            local bid = Details.bid or 0;
            bid = tonumber(bid) or 0;

            if (GL:lt(bid, .0002) or not Client:isBidValidForAuction(auctionID, bid)
                or not GL.User:unitInGroup(player)
                or not GL:unitIsConnected(player)
            ) then
                Client.AuctionDetails.Auctions[auctionID].AutoBids[player] = nil;
                return;
            end

            tinsert(ValidOutstandingAutoBids, {
                player = player,
                bid = bid,
                at = Details.at,
            });

            if (GL:gt(bid, highestAutoBid)) then
                highestAutoBid = bid;
            end
        end)();
    end

    -- Sort the auto bids lowest to highest and keep the bid time in mind
    table.sort(ValidOutstandingAutoBids, function (a, b)
        if (a.bid ~= b.bid) then
            return GL:lt(a.bid, b.bid);
        end

        return a.at > b.at;
    end);

    local numberOfValidOutstandingAutoBids = #ValidOutstandingAutoBids;
    for index = 1, numberOfValidOutstandingAutoBids do
        (function()
            local minimumBid = Client:minimumBidForAuction(auctionID);
            local Details = ValidOutstandingAutoBids[index];

            -- Check if the next minimum bid is within the player's budget
            if (GL:lt(Details.bid, minimumBid)) then
                Client.AuctionDetails.Auctions[auctionID].AutoBids[Details.player] = nil;
                return;
            end

            if (index < numberOfValidOutstandingAutoBids) then
                -- There's an earlier auto bid with the exact same max, he got here first!
                if (Details.bid == highestAutoBid) then
                    Details.bid = highestAutoBid - Client.AuctionDetails.Auctions[auctionID].increment;
                end

                self:setBid(auctionID, Details.player, Details.bid);

            -- We've reached the last (the highest) auto bidder. Bid minimum over previous auto bidder unless we're already top bid!
            elseif (not GL:iEquals(
                GL:tableGet(Client.AuctionDetails.Auctions[auctionID], "CurrentBid.player", ""),
                Details.player
            )) then
                self:setBid(auctionID, Details.player, min(highestAutoBid, Client:minimumBidForAuction(auctionID)));
            end
        end)();
    end
end

--- Attempt to process an incoming bid
---
---@param Message CommMessage
---@return void
function Auctioneer:processBid(Message)
    if (not self:auctionStartedByMe()) then
        return;
    end

    local auctionID, bid, auto = strsplit("|", Message.content or "");

    auctionID = tonumber(auctionID);
    auto = auto == "1";
    bid = tonumber(bid or 0) or 0;

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
    if (not GL.User:unitInGroup(Message.Sender.fqn)
        or not GL:unitIsConnected(Message.Sender.fqn)
    ) then
        return;
    end

    local playerGUID = GDKP:playerGUID(Message.Sender.fqn);
    local userGUID = GDKP:myGUID();

    -- This is a user cancelling his auto bid on a specific auction
    if (bid == -1) then
        Client.AuctionDetails.Auctions[auctionID].AutoBids = Client.AuctionDetails.Auctions[auctionID].AutoBids or {};
        Client.AuctionDetails.Auctions[auctionID].AutoBids[playerGUID] = nil;

        return;
    end

    -- The anti snipe will kick in
    if (secondsLeft <= Client.AuctionDetails.antiSnipe) then
        Client.AuctionDetails.Auctions[auctionID].endsAt = serverTime + Client.AuctionDetails.antiSnipe;
        tinsert(self.IDsChangedSinceLastSync, auctionID);
    end

    -- Make sure the bid is actually valid
    bid = Client:roundBidToClosestIncrement(auctionID, bid);
    if (not Client:isBidValidForAuction(auctionID, bid)) then
        return;
    end

    local auctioneerWasTopBidder = GL:iEquals(
        GL:tableGet(Client.AuctionDetails.Auctions[auctionID], "CurrentBid.player", ""),
        userGUID
    );

    -- This is an auto bid
    if (auto) then
        Client.AuctionDetails.Auctions[auctionID].AutoBids = Client.AuctionDetails.Auctions[auctionID].AutoBids or {};
        Client.AuctionDetails.Auctions[auctionID].AutoBids[playerGUID] = {
            bid = bid,
            at = GetTime(),
        };

        return self:processAutoBids(auctionID);
    end

    local highestAutoBid = self:highestAutoBid(auctionID);
    if (bid == highestAutoBid) then
        bid = highestAutoBid - Client.AuctionDetails.Auctions[auctionID].increment;
        self:setBid(auctionID, playerGUID, bid);
    else
        self:setBid(auctionID, playerGUID, bid);
    end

    self:processAutoBids(auctionID);

    -- LastBidAt functions as an extra anti-snipe failsafe
    self.LastBidAt[auctionID] = GetServerTime();

    local auctioneerIsTopBidder = GL:iEquals(
        GL:tableGet(Client.AuctionDetails.Auctions[auctionID], "CurrentBid.player", ""),
        userGUID
    );

    if (auctioneerWasTopBidder and not auctioneerIsTopBidder) then
        Client.AuctionDetails.Auctions[auctionID].iWasOutBid = true;
        Client:outbidNotification();
    elseif (auctioneerIsTopBidder) then
        Client.AuctionDetails.Auctions[auctionID].iWasOutBid = false;
    end
end

function Auctioneer:setBid(auctionID, player, bid)
    local playerGUID = GDKP:playerGUID(player);
    GL:tableSet(Client.AuctionDetails.Auctions[auctionID], ("BidsPerPlayer.%s"):format(playerGUID), bid);

    Client.AuctionDetails.Auctions[auctionID].CurrentBid = {
        amount = bid,
        player = playerGUID,
    };
    tinsert(self.IDsChangedSinceLastSync, auctionID);
end

---@param auctionID number
---@return number
function Auctioneer:highestAutoBid(auctionID)
    local highestAutoBid = 0;
    for _, Details in pairs(Client.AuctionDetails.Auctions[auctionID].AutoBids or {}) do
        if (GL:gt(Details.bid, highestAutoBid)) then
            highestAutoBid = Details.bid;
        end
    end

    return highestAutoBid;
end

--- Was the given auction ID (or current multi-auction as a whole) started by us
---
---@return boolean
function Auctioneer:auctionStartedByMe(auctionID)
    if (auctionID and not GL:tableGet(Client, "AuctionDetails.Auctions." .. auctionID)) then
        return false;
    end

    return Client.AuctionDetails and GL:iEquals(Client.AuctionDetails.initiator, GL.User.fqn);
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
        local HighestBidPerPlayer = {};
        local TopBids = Client.AuctionDetails.Auctions[auctionID].BidsPerPlayer;
        for player, bid in pairs(TopBids or {}) do
            bid = tonumber(bid) or 0;

            if (GL:gt(bid, 0)) then
                local Player = GL.Player:fromName(player);

                HighestBidPerPlayer[player] = {
                    bid = bid,
                    createdAt = GetServerTime(),
                    bidder = player,
                    Bidder = {
                        name = Player.name,
                        uuid = Player.id,
                        realm = Player.realm,
                        race = Player.race,
                        class = Player.class,
                    },
                };
            end
        end

        GL:mute(); -- We don't want an announcement for every awarded item since people can see it for themselves in /gl bid
        local awardChecksum = GL.AwardedLoot:addWinner{
            broadcast = false,
            gdkpCost = BidDetails.amount,
            itemLink = itemLink,
            winner = BidDetails.player,
        };
        GDKPAuction:create(itemLink, BidDetails.amount, BidDetails.player, nil, HighestBidPerPlayer, nil, awardChecksum);
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

    Client.AuctionDetails.Auctions[auctionID].AutoBids = {};
    Client.AuctionDetails.Auctions[auctionID].CurrentBid = nil;
    Client.AuctionDetails.Auctions[auctionID].iWasOutBid = false;
    Client.AuctionDetails.Auctions[auctionID].BidsPerPlayer = {};

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

--- Check if there are any running auctions
---
---@return boolean
function Auctioneer:hasRunningAuctions()
    for _, Details in pairs(Client.AuctionDetails.Auctions or {}) do
        if (Details.endsAt > 0) then
            return true;
        end
    end

    return false;
end

--- Check if there are any unfinalized auctions
---
---@return boolean
function Auctioneer:hasUnfinalizedAuctions()
    for _, Details in pairs(Client.AuctionDetails.Auctions or {}) do
        if (Details.endsAt ~= -1 -- Auction was deleted
            and Details.endsAt == 0 -- Auction closed
            and GL:empty(Details.CurrentBid) -- without winning bid
        ) then
            return true;
        end
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
        GL:sendChatMessage((L.CHAT.MULTIAUCTION_FINISHED):format(GL:goldToMoney(totalPot)), "GROUP");
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

--- Disenchant all stopped and unsold items
---
---@return void
function Auctioneer:disenchant()
    local disenchantNextItem;
    local AuctionsToDisenchant = {};
    local announceDisenchantedSetting = GL.Settings:get("PackMule.announceDisenchantedItems");

    for _, Auction in pairs(Client.AuctionDetails.Auctions or {}) do
        -- Auction closed without winning bid
        if (Auction.endsAt == 0 and not Auction.CurrentBid) then
            tinsert(AuctionsToDisenchant, Auction);
        end
    end

    -- Recursively disenchant items (in case there is no disenchanter set yet)
    disenchantNextItem = function ()
        if (not AuctionsToDisenchant[1]) then
            GL.Settings:set("PackMule.announceDisenchantedItems", announceDisenchantedSetting);
            return;
        end

        local Auction = AuctionsToDisenchant[1];
        tremove(AuctionsToDisenchant, 1);

        -- Attempt to mark the item as disenchanted
        GL.PackMule:disenchant(Auction.link, true, function (success)
            -- We're done, remove the auction from the overview
            if (success) then
                self:deleteAuction(Auction.auctionID);
            end

            disenchantNextItem();
        end);
    end;

    -- Make sure to not flood chat with all these items being disenchanted
    GL.Settings:set("PackMule.announceDisenchantedItems", false);

    disenchantNextItem();
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
        minimum = GL:floor(minimum, Settings:get("GDKP.precision"));

        if (GL:lt(minimum, .0001)) then
            minimum = DB:get("GDKP.defaultMinimumBid");
        end

        local increment = tonumber(Details.increment) or 0;
        increment = GL:floor(increment, Settings:get("GDKP.precision"));

        if (GL:lt(increment, .0001)) then
            increment = DB:get("GDKP.defaultIncrement");
        end

        DB:set("GDKP.SettingsPerItem." .. itemID, {
            minimum = minimum,
            increment = increment
        });
    end
end
