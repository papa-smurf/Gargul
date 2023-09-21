local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Data
local Constants = GL.Data.Constants;

---@type Settings
local Settings = GL.Settings;

---@type DB
local DB = GL.DB;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPAuction
local Auction = GDKP.Auction;

---@class GDKPMultiAuctionAuctioneer
GL:tableSet(GL, "GDKP.MultiAuction.Auctioneer", {
    _initialized = false,
});

---@type GDKPMultiAuctionAuctioneer
local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;

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

    self._initialized = true;
end

---@param minimumQuality number
---@param includeBOEs boolean
---@param includeMaterials boolean
---@return void
function Auctioneer:fillFromInventory(minimumQuality, includeBOEs, includeMaterials)
    includeBOEs = includeBOEs ~= false;
    includeMaterials = includeMaterials == true;

    ---@todo: REMOVE!
    --minimumQuality = 0;

    GL:forEachItemInBags(function (Location, bag, slot)
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

        local itemGUID = C_Item.GetItemGUID(Location);
        local itemLink = C_Item.GetItemLink(Location);

        UI:addItemByLink(itemLink, itemGUID);
    end);
end

--- Check whether the given or current user is allowed to broadcast
---
---@return boolean
function Auctioneer:allowedToBroadcast(playerID)
    -- If no player is given we assume self
    if (type(playerID) ~= "string"
        or playerID == GL.User.id
    ) then
        return not GL.User.isInGroup or (
            GL.User.hasAssist
            or GL.User.isMasterLooter
        );
    end

    if (Auction.inProgress) then
        return Auction.Current.initiatorID == playerID;
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

---@param force boolean
---@param triedQueue boolean
---@return void
function Auctioneer:start(force, triedQueue)
    UI = UI or GL.Interface.GDKP.Auctioneer;

    -- There is no active item, see if we can pop one from the queue
    if (not UI.itemLink) then
        if (not triedQueue) then
            self:popFromQueue(force);
            return self:start(force, true);
        else
            return;
        end
    end

    if (Auction:announceStart(
            UI.itemLink,
            UI.minimumBid,
            UI.increment,
            UI.time,
            UI.antiSnipe
    )) then
        self:storeDetailsForFutureAuctions{
            itemLink = UI.itemLink,
            minimumBid = UI.minimumBid,
            increment = UI.increment,
            time = UI.time,
            antiSnipe = UI.antiSnipe,
        };
    end;
end

---@return void
function Auctioneer:stop()
    GL.Ace:CancelTimer(self.PopTimer);
    Auction:announceStop(true);
end

---@return boolean
function Auctioneer:extend()
    return Auction:announceExtension(DEFAULT_AUCTION_EXTENSION);
end

---@return boolean
function Auctioneer:shorten()
    return Auction:announceShortening(DEFAULT_AUCTION_SHORTENING);
end

---@return boolean
function Auctioneer:finalCall()
    local time = Settings:get("GDKP.finalCallTime");

    if (not Auction:announceReschedule(time)) then
        return false;
    end

    if(Settings:get("GDKP.announceFinalCall")) then
        GL:sendChatMessage((L.FINAL_CALL_ANNOUNCEMENT):format(Auction.Current.itemLink, time), "RAID_WARNING", nil, nil, false);
    end

    return true;
end

---@return void
function Auctioneer:timeRanOut()
    if (Auction.inProgress) then
        return;
    end

    UI = UI or GL.Interface.GDKP.Auctioneer;
    local delayBetweenQueuedAuctions = tonumber(Settings:get("GDKP.delayBetweenQueuedAuctions")) or 0;

    if (not GL:tableGet(Auction.Current, "TopBid.Bidder.name")) then
        local actionWhenNoBidsArePresent = Settings:get("GDKP.queuedAuctionNoBidsAction");

        if (actionWhenNoBidsArePresent ~= GL.Data.Constants.GDKP.QueuedAuctionNoBidsActions.NOTHING) then
            local next = function ()
                if (Auction.inProgress) then
                    return;
                end

                self:clear();
                Auction:reset(); -- Reset the actual auction object
                UI:closeAuctioneerShortcut();

                GL.Ace:CancelTimer(self.PopTimer);
                if (delayBetweenQueuedAuctions > 0) then
                    self.PopTimer = GL.Ace:ScheduleTimer(function ()
                        self:start();
                    end, delayBetweenQueuedAuctions);
                else
                    self:start();
                end
            end;

            -- This is to make sure that we only start a new auction after
            -- the item was successfully marked as disenchanted
            if (actionWhenNoBidsArePresent == "DISENCHANT") then
                local quality = tonumber(GL:getItemQualityFromLink(Auction.Current.itemLink));

                if (quality and quality >= 5) then
                    GL:warning("No bids on Legendary+ item detected, continue manually!");
                    return;
                end

                return GL.PackMule:disenchant(Auction.Current.itemLink, true, function ()
                    next();
                end);
            end

            next();
            return;
        end

        if (not UI.isVisible) then
            GL.Interface.Alerts:fire("GargulNotification", {
                message = string.format("|c00BE3333No bids!|r"),
            });
        end

        return;
    end

    -- Auto awarding is disabled
    if (not Settings:get("GDKP.autoAwardViaAuctioneer")) then
        return;
    end

    local bid = Auction.Current.TopBid.bid;
    local minimumBid = Auction.Current.minimumBid;

    -- We don't auto-award unless the bid is equal to or higher than the minimum bid
    if (bid < minimumBid) then
        return;
    end

    local winner = Auction.Current.TopBid.Bidder.name;
    local awardChecksum = GL.AwardedLoot:addWinner(winner, Auction.Current.itemLink, nil, nil, nil, nil, bid, nil);
    if (not Auction:storeCurrent(winner, bid, awardChecksum)) then
        return;
    end

    self:clear();
    Auction:reset(); -- Reset the actual auction object
    UI:closeAuctioneerShortcut();

    GL.Ace:CancelTimer(self.PopTimer);
    if (delayBetweenQueuedAuctions > 0) then
        self.PopTimer = GL.Ace:ScheduleTimer(function ()
            self:start();
        end, delayBetweenQueuedAuctions);
    else
        self:start();
    end
end

--- Store auction details for future use (time, increment, minimum bid etc)
---
---@param Details table
---@return void
function Auctioneer:storeDetailsForFutureAuctions(Details)
    local itemID = GL:getItemIDFromLink(Details.itemLink);

    if (not itemID) then
        return;
    end

    do --[[ TIME ]]
        local time = tonumber(Details.time) or 0;
        time = math.floor(time);

        if (time < 1) then
            time = GL:tableGet(GL.Data.DefaultSettings, "GDKP.time", 30);
        end

        Settings:set("GDKP.time", time);
    end

    do --[[ ANTI SNIPE ]]
        local antiSnipe = tonumber(Details.antiSnipe) or 0;
        antiSnipe = math.floor(antiSnipe);

        if (antiSnipe < 0) then
            antiSnipe = GL:tableGet(GL.Data.DefaultSettings, "GDKP.antiSnipe", 30);
        end

        Settings:set("GDKP.antiSnipe", antiSnipe);
    end

    -- [[ MINIMUM AND INCREMENT ]]
    if (Settings:get("GDKP.storeMinimumAndIncrementPerItem")) then
        local minimumBid = tonumber(Details.minimumBid) or 0;
        minimumBid = math.floor(minimumBid);

        if (minimumBid < 1) then
            minimumBid = DB:get("GDKP.defaultMinimumBid");
        end

        local increment = tonumber(Details.increment) or 0;
        increment = math.floor(increment);

        if (increment < 1) then
            increment = DB:get("GDKP.defaultIncrement");
        end

        DB:set("GDKP.SettingsPerItem." .. itemID, {
            minimum = minimumBid,
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

---@param Bid table
---@return void
function Auctioneer:announceBid(Bid)
    local bidApprovedMessage = string.format(L.HIGHEST_BIDDER_CONFIRMATION, Bid.Bidder.name, Bid.bid);

    GL.Ace:CancelTimer(self.BidAnnouncementThrottler);

    if (not GL.User.isInRaid or not Settings:get("GDKP.announceNewBidInRW")) then
        return GL:sendChatMessage(bidApprovedMessage, "GROUP", nil, nil, false);
    end

    --[[ THE LAST BID ANNOUNCEMENT WAS A WHILE AGO, ANNOUNCE IMMEDIATELY ]]
    if (GetTime() - self.lastBidAnnouncementAt >= 1.2) then
        bidApprovedMessage = string.format(bidApprovedMessage, Bid.Bidder.name, Bid.bid);
        GL:sendChatMessage(bidApprovedMessage, "RAID_WARNING", nil, nil, false);
        self.lastBidAnnouncementAt = GetTime();

        return;
    end

    --[[ WE NEED TO WAIT BEFORE WE CAN ANNOUNCE AGAIN ]]
    self.BidAnnouncementThrottler = GL.Ace:ScheduleTimer(function ()
        local currentTopBid = GL:tableGet(Auction.Current, "TopBid.bid");
        local bidder = GL:tableGet(Auction.Current, "TopBid.Bidder.name");

        if (not currentTopBid or not bidder) then
            return;
        end

        bidApprovedMessage = string.format(bidApprovedMessage, bidder, currentTopBid);
        GL:sendChatMessage(bidApprovedMessage, "RAID_WARNING", nil, nil, false);
        self.lastBidAnnouncementAt = GetTime();
    end, 1);
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