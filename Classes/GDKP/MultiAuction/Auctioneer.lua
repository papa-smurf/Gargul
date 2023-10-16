local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Data
local Constants = GL.Data.Constants;
local CommActions = Constants.Comm.Actions;

---@type Settings
local Settings = GL.Settings;

---@type DB
local DB = GL.DB;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

---@type GDKPMultiAuctionClient
local Client;

---@class GDKPMultiAuctionAuctioneer
GL:tableSet(GL, "GDKP.MultiAuction.Auctioneer", {
    _initialized = false,
    auctionIsInProgress = false,
    waitingForAuctionStart = false,
});

---@type GDKPMultiAuctionAuctioneer
local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;

---@type GDKPAuction
local GDKPAuction = GL.GDKP.Auction;

---@type GDKPMultiAuctionAuctioneerInterface
local UI;

--[[ CONSTANTS ]]
local DEFAULT_AUCTION_EXTENSION = 10;
local DEFAULT_AUCTION_SHORTENING = 10;

---@return void
function Auctioneer:_init()
    if (self._initialized) then
        return;
    end

    UI = GL.Interface.GDKP.MultiAuction.Auctioneer;
    Client  = GL.GDKP.MultiAuction.Client;

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
            if (classID == Enum.ItemClass.Tradegoods) then
                return;
            end
        end

        -- Item is not soulbound or does not have any trade time remaining
        local timeRemaining = GL:inventoryItemTradeTimeRemaining(bag, slot);
        if (timeRemaining < 1 or (
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
            GL.User.isLead
            or GL.User.isMasterLooter
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
            itemLink = Item.link,
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
                isBOE = GL:inTable({LE_ITEM_BIND_ON_ACQUIRE, LE_ITEM_BIND_QUEST}, Item.bindType),
                itemLevel = Item.level,
                name = Item.name,
                quality = Item.quality,
                link = Item.link,
                minimum = MinAndIncrementPerLink[Item.link].minimum,
                increment = MinAndIncrementPerLink[Item.link].increment,
            });

            auctionID = auctionID + 1;
        end

        self:scheduleInspection();

        if (not self:announceStart(ItemsUpForAuction, duration, antiSnipe)) then
            return;
        end
    end);
end

--- Send all top bids to the group
---
---@return void
function Auctioneer:scheduleInspection()
    GL:interval(.2, "GDKP.MultiAuction.scheduleInspection", function ()
        local serverTime = GetServerTime();
        local signedLeeway = GL.Settings:get("GDKP.auctionEndLeeway", 2) * -1;

        -- Check if there are newly closed auctions
        for auctionID, Details in pairs(Client.AuctionDetails.Auctions or {}) do
            if (Details.endsAt > 0
                and Details.endsAt - serverTime <= signedLeeway
            ) then
                self:closeAuction(auctionID);
            end
        end

        -- No need to broadcast if nothing changed
        if (not self.detailsChanged) then
            return;
        end

        local bidsAvailable = false;
        local Changes = {};
        for auctionID, Details in pairs(Client.AuctionDetails.Auctions or {}) do
            (function()
                auctionID = math.floor(tonumber(auctionID) or 0);
                if (auctionID < 1) then
                    return;
                end

                Changes[auctionID] = {
                    p = GL:tableGet(Details, "CurrentBid.player"),
                    a = tonumber(GL:tableGet(Details, "CurrentBid.amount", 0)) or 0,
                    e = Details.endsAt,
                };
                bidsAvailable = true;
            end)();
        end

        -- Store this multi-auction's details in case the loot master is disconnected for example
        DB:set("GDKP.MultiAuction.Details", Client.AuctionDetails);

        GL.CommMessage.new(
            CommActions.announceChangesForGDKPMultiAuction,
            Changes,
            "GROUP"
        ):send();

        self.detailsChanged = false;
    end);
end

--- Announce to everyone in the raid that a MultiAuction is starting
---
---@param ItemDetails table
---@param duration number
---@param antiSnipe number
---@return boolean
function Auctioneer:announceStart(ItemDetails, duration, antiSnipe)
    -- There's already a MultiAuction in progress
    if (self.auctionIsInProgress) then
        return false;
    end

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
        Details.endsAt = endsAt;
    end

    GL.CommMessage.new(
        CommActions.startGDKPMultiAuction,
        {
            ItemDetails = ItemDetails,
            endsAt = endsAt,
            antiSnipe = antiSnipe,
            bth = GL.User.bth,
        },
        "GROUP"
    ):send();

    return true;
end

--- Attempt to process an incoming bid
---
---@param Message CommMessage
---@return void
function Auctioneer:processBid(Message)
    if (Message.Sender.isSelf or not self:auctionStartedByMe()) then
        return;
    end

    local auctionID = GL:tableGet(Message, "content.auctionID");

    -- The given auction doesn't exist
    if (not auctionID or not GL:tableGet(Client, "AuctionDetails.Auctions." .. auctionID)) then
        ---@todo: CHECK WITH OTHER PLAYERS TO SEE IF THERE'S AN ONGOING MULTI-AUCTION
        return;
    end

    -- Regardless of what happens make sure to extend the auction of needed
    local serverTime = GetServerTime();
    local secondsLeft = Client.AuctionDetails.Auctions[auctionID].endsAt - serverTime;

    -- This auction as "long" ended
    if (secondsLeft <= GL.Settings:get("GDKP.auctionEndLeeway", 2) * -1) then
        return;
    end

    if (secondsLeft <= Client.AuctionDetails.antiSnipe) then
        -- Make sure we spread the news about this reschedule
        Client.AuctionDetails.Auctions[auctionID].endsAt = serverTime + Client.AuctionDetails.antiSnipe;

        self.detailsChanged = true;
    end

    local bid = tonumber(GL:tableGet(Message, "content.bid", 0)) or 0;

    -- Make sure the bid is actually valid
    if (not Client:isBidValidForAuction(auctionID, bid)) then
        return;
    end

    Client.AuctionDetails.Auctions[auctionID].CurrentBid = {
        amount = bid,
        player = Message.Sender.fqn,
    };

    -- Make sure we spread the news about the new top bidder
    self.detailsChanged = true;
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

    self.detailsChanged = true;
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

        GL:mute();
        local awardChecksum = GL.AwardedLoot:addWinner(BidDetails.player, itemLink, nil, nil, nil, nil, BidDetails.amount);
        GDKPAuction:create(GL:getItemIDFromLink(itemLink), BidDetails.amount, BidDetails.player, nil, nil, nil, awardChecksum);
        GL:unmute();
    end

    Client.AuctionDetails.Auctions[auctionID].endsAt = 0;
    self.detailsChanged = true;
end

--- Clear an auction's current bid
---
---@param auctionID string
---@return void
function Auctioneer:clearBid(auctionID)
    if (self:auctionIsFinalized(auctionID)) then
        return;
    end

    Client.AuctionDetails.Auctions[auctionID].CurrentBid = nil;
    self.detailsChanged = true;
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
    self.detailsChanged = true;
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

---@param bidder string
---@param bid number
---@return void
function Auctioneer:removePlayerBid (bidder, bid)
    local Bids = Auction.Current.Bids or {};

    local bidRemoved = false;
    for key, Bid in pairs(Bids) do
        if (Bid.bid == bid and GL:iEquals(Bid.bidder, bidder)) then
            Bids[key] = nil;
            bidRemoved = true;
            break;
        end
    end

    local HighestBid = tremove(Auction.Current.Bids);
    tinsert(Auction.Current.Bids, HighestBid);
    Auction.Current.TopBid = HighestBid;

    if (HighestBid and HighestBid.bid <= bid) then
        self:announceBid(HighestBid);
    end

    self:refreshBidsTable();
end

---@return void
function Auctioneer:award()
    UI = UI or GL.Interface.GDKP.Auctioneer;

    if (not UI.itemLink) then
        return;
    end

    local BidsTable = UI:getBidsTable();
    local selected = BidsTable:GetRow(BidsTable:GetSelection());

    -- No bid is selected, open the direct award window
    if (not selected
            or not type(selected) == "table"
    ) then
        return GL.Interface.Award.Award:draw(UI.itemLink, function ()
            if (Settings:get("GDKP.minimizeAuctioneerOnAward")) then
                local Window = UI:getWindow();

                if (not Window) then
                    return;
                end

                Window.Minimize.MinimizeButton:Click();
            end
        end);
    end

    local winner = selected.cols[4].value;
    local bid = selected.cols[2].value;

    GL.Interface.Dialogs.PopupDialog:open{
        question = string.format(L.AWARD_ITEM_CONFIRMATION,
                Auction.Current.itemLink,
                GL:nameFormat{name = winner, colorize = true},
                bid
        ),
        OnYes = function ()
            local isOS, addPlusOne;
            local OSCheckBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.OffSpec");
            if (OSCheckBox) then
                isOS = GL:toboolean(OSCheckBox:GetValue());
            end

            local addPlusOneCheckBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.PlusOne");
            if (addPlusOneCheckBox) then
                addPlusOne = GL:toboolean(addPlusOneCheckBox:GetValue());

                if (addPlusOne) then
                    GL.PlusOnes:addPlusOne(winner);
                end
            end

            local awardChecksum = GL.AwardedLoot:addWinner(winner, Auction.Current.itemLink, nil, nil, isOS, nil, bid, nil);

            if (not Auction:storeCurrent(winner, bid, awardChecksum)) then
                return;
            end

            Auction:reset(); -- Reset the actual auction object
            UI:closeAuctioneerShortcut();

            self:clear();
            self:start();

            if (Settings:get("GDKP.minimizeAuctioneerOnAward")) then
                local Window = UI:getWindow();

                if (not Window) then
                    return;
                end

                Window.Minimize.MinimizeButton:Click();
            end
        end,
    };
end