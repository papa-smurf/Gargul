---@type GL
local _, GL = ...;

---@type Settings
local Settings = GL.Settings;

---@class GDKPMultiAuctionClient
GL:tableSet(GL, "GDKP.MultiAuction.Client", {
    _initialized = false,
    detailsChanged = false,

    AuctionDetails = {},
});

---@type GDKPMultiAuctionClient
local Client = GL.GDKP.MultiAuction.Client;

---@type GDKPMultiAuctionAuctioneer
local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;

---@type GDKPMultiAuctionClientInterface
local UI;

--[[ CONSTANTS ]]
local ENDS_AT_OFFSET = 1697932800;

---@return void
function Client:_init()
    if (self._initialized) then
        return;
    end

    UI = GL.Interface.GDKP.MultiAuction.Client;

    self._initialized = true;

    -- Clear any running multi auctions when leaving a group
    GL.Events:register("GDKPMultiAuctionClientUserLeftGroupListener", "GL.USER_LEFT_GROUP", function ()
        if (Auctioneer:auctionStartedByMe()) then
            return;
        end

        UI:clear();
        UI:close();
        self.AuctionDetails = {};
    end);
end

--- This is used to determine which session to take over / participate in
--- when joining a group or logging (back) into the game
---
---@return string
---@test /dump _G.Gargul.GDKP.MultiAuction.Client:currentSessionHash();
function Client:currentSessionHash()
    if (type(self.AuctionDetails.Auctions) ~= "table"
        or GL:empty(self.AuctionDetails.Auctions)
    ) then
        return;
    end

    local BidDetails = (function()
        local Result = {};

        for id, Details in pairs(self.AuctionDetails.Auctions or {}) do
            Result[id] = GL:implode({
                Details.link,
                GL:tableGet(Details, "CurrentBid.amount"),
                GL:tableGet(Details, "CurrentBid.player"),
            }, "-");
        end

        return Result;
    end)();

    return GL:implode({
        tonumber(self.AuctionDetails.antiSnipe) or 0,
        strlower(self.AuctionDetails.initiator),
        GL:stringHash(BidDetails)
    }, ".");
end

---@return void
function Client:start(Message)
    -- Make sure that whoever sent us this message is actually allowed to start a multi-auction
    if (not Auctioneer:userIsAllowedToBroadcast(GL:tableGet(Message, "Sender.id", Message.Sender.name))) then
        return;
    end

    if (not GL.Version:leftIsNewerThanOrEqualToRight(Message.version, "7.2.2")) then
        GL:error(("The loot master (%s) is outdated, this can cause bids to fail!"):format(GL:nameFormat(Message.Sender.fqn)));
    end

    self.AuctionDetails = {
        initiator = Message.Sender.fqn,
        antiSnipe = Message.content.antiSnipe,
        bth = Message.content.bth,
        precision = Message.content.precision or 0,
        Auctions = {},
    };

    local runningAuctions = false;
    local serverTime = GetServerTime();
    for _, Item in pairs(GL:tableGet(Message, "content.ItemDetails", {})) do
        self.AuctionDetails.Auctions[Item.auctionID] = Item;

        if (serverTime < Item.endsAt) then
            runningAuctions = true;
        end
    end

    UI:clear();

    UI:open();
    UI:refresh();

    GL:after(.2, nil, function ()
        UI.showFavorites = true;
        UI.showUnusable = false;
        UI.showInactive = false;
        UI.ToggleFavorites:GetScript("OnClick")();
        UI.ToggleUnusable:GetScript("OnClick")();
        UI.ToggleActive:GetScript("OnClick")();
    end);

    -- Looks like there are no active auctions, this can happen when joining a new group with expired data
    if (not runningAuctions) then
        UI:close();
    end
end

---@param link table|string item link
---@param duration number
---@param minimum number
---@param increment number
---@return void
function Client:addToCurrentSession(link, duration, minimum, increment)
    if (duration ~= nil or type(link) ~= "table") then
        GL:error("Pass a table instead of multiple arguments")
        return;
    end

    if (not Auctioneer:auctionStartedByMe()
        or GL:empty(self.AuctionDetails.Auctions)
    ) then
        return;
    end

    duration = link.duration;
    minimum = link.minimum;
    increment = link.increment;

    link = link.link;

    local lastAuctionID = 0;
    for id in pairs(GL:tableColumn(self.AuctionDetails.Auctions, "auctionID") or {}) do
        if (id > lastAuctionID) then
            lastAuctionID = lastAuctionID + 1;
        end
    end
    lastAuctionID = lastAuctionID + 1;

    GL:onItemLoadDo(link, function (Item)
        if (not Item) then
            return;
        end

        self.AuctionDetails.Auctions[lastAuctionID] = {
            auctionID = lastAuctionID,
            isBOE = GL:inTable({ LE_ITEM_BIND_ON_EQUIP, LE_ITEM_BIND_QUEST }, Item.bindType),
            itemLevel = Item.level,
            name = Item.name,
            quality = Item.quality,
            link = Item.link,
            minimum = minimum,
            increment = increment,
            endsAt = GetServerTime() + duration,
        };

        Auctioneer.IDsToAnnounce[lastAuctionID] = true;
        Auctioneer.detailsChanged = true;

        GL:after(1.15, "GDKP.MultiAuction.syncNewItems", function ()
            Auctioneer:syncNewItems();
        end);
    end);
end

---@param auctionID number
---@param amount number
---@param onConfirm function|nil
---
---@return void
function Client:autobid(auctionID, amount, onConfirm)
    if (Auctioneer:auctionStartedByMe(auctionID)) then
        Auctioneer:processBid({
            Sender = {
                fqn = GL.User.fqn,
                isSelf = true,
            },
            content = GL:implode({ auctionID, amount, 1, }, "|"),
        });

        return onConfirm and onConfirm(true) or nil;
    end

    GL.CommMessage.new{
        action = GL.Data.Constants.Comm.Actions.bidOnGDKPMultiAuction,
        content = GL:implode({ auctionID, amount, 1, }, "|"),
        channel = "WHISPER",
        recipient = self.AuctionDetails.initiator,
        onConfirm = onConfirm,
    }:send();
end

---@param auctionID number
---@param onConfirm function|nil
---
---@return void
function Client:stopAutobid(auctionID, onConfirm)
    return self:bid(auctionID, -1, onConfirm);
end

---@param auctionID number
---@param amount number
---@param onConfirm function|nil
---
---@return void
function Client:bid(auctionID, amount, onConfirm)

    if (Auctioneer:auctionStartedByMe(auctionID)) then
        Auctioneer:processBid({
            Sender = {
                fqn = GL.User.fqn,
                isSelf = true,
            },
            content = GL:implode({ auctionID, amount, }, "|"),
        });

        return onConfirm and onConfirm(true) or nil;
    end

    GL.CommMessage.new{
        action = GL.Data.Constants.Comm.Actions.bidOnGDKPMultiAuction,
        content = GL:implode ({ auctionID, amount, }, "|"),
        channel = "WHISPER",
        recipient = self.AuctionDetails.initiator,
        onConfirm = onConfirm,
    }:send();
end

--- The loot master sent us an update of all top bids, refresh our UI
---
---@param Message CommMessage
---@return void
function Client:updateBids(Message)
    if (not self.AuctionDetails
        or self.AuctionDetails.initiator ~= Message.Sender.fqn
    ) then
        return;
    end

    for auctionID, Details in pairs(Message.content or {}) do
        (function()
            -- This is a new item, add it to the auction
            if (not Message.Sender.isSelf and Details.I) then
                self.AuctionDetails.Auctions[auctionID] = Details.I;
                self.AuctionDetails.Auctions[auctionID].CurrentBid = Details.CurrentBid or {};

                GL:after(.2, "GDKP.MultiAuction.refreshUI", function ()
                    UI:refresh(true);
                end);
            end

            if (not GL:tableGet(self.AuctionDetails, "Auctions." .. auctionID)) then
                return;
            end

            local amount = Details.a * 1000;
            local bidder = Details.p;
            local bidderIsMe = GL:iEquals(bidder, GL.User.fqn);

            -- The auctioneer already did this on his end before sending it to us
            if (not Message.Sender.isSelf) then
                ---@todo: maybe in the future when this data is available to everyone
                -- Store the highest bid for this player to show in the bid history
                --if (bidder) then
                    --self.AuctionDetails.Auctions[auctionID].BidsPerPlayer = self.AuctionDetails.Auctions[auctionID].BidsPerPlayer or {};
                    --self.AuctionDetails.Auctions[auctionID].BidsPerPlayer[bidder] = amount;
                --end

                -- There are no bids
                if (GL:lt(amount, .0001)) then
                    Client.AuctionDetails.Auctions[auctionID].iWasOutBid = false;

                -- We're top bidder again
                elseif (Client.AuctionDetails.Auctions[auctionID].iWasOutBid
                    and bidderIsMe
                ) then
                    Client.AuctionDetails.Auctions[auctionID].iWasOutBid = false;

                -- We were top bidder but not anymore
                elseif (not Client.AuctionDetails.Auctions[auctionID].iWasOutBid
                    and not bidderIsMe
                    and GL:iEquals(GL:tableGet(Client.AuctionDetails.Auctions[auctionID], "CurrentBid.player", ""), GL.User.fqn)
                ) then
                    Client:outbidNotification();

                    Client.AuctionDetails.Auctions[auctionID].iWasOutBid = true;
                end
            end

            if (GL:gt(amount, 0)) then
                self.AuctionDetails.Auctions[auctionID].CurrentBid = {
                    amount = amount,
                    player = bidder,
                };
            else
                self.AuctionDetails.Auctions[auctionID].CurrentBid = nil;
            end

            if (Details.e) then
                self.AuctionDetails.Auctions[auctionID].endsAt = Details.e > 0 and Details.e + ENDS_AT_OFFSET or Details.e;

                if (self.AuctionDetails.Auctions[auctionID].endsAt == 0
                    and GL:gt(amount, 0)
                    and GL.Settings:get("GDKP.MultiAuction.awardNotice")
                ) then
                    print(("|c00FFF569%s bought %s for %sg|r"):format(
                        GL:nameFormat{ name = bidder, colorize = true, },
                        self.AuctionDetails.Auctions[auctionID].link,
                        amount
                    ));
                end
            end
        end)();
    end

    UI:refresh();
end

---@param auctionID number
---@param bid number
---@return number
---@test /dump _G.Gargul.GDKP.MultiAuction.Client:roundBidToClosestIncrement(1, 1399);
function Client:roundBidToClosestIncrement(auctionID, bid)
    bid = tonumber(bid) or 0;
    local Auction = GL:tableGet(self.AuctionDetails, "Auctions." .. auctionID);

    if (not Auction
        or GL:lt(bid, Auction.minimum)
    ) then
        return bid;
    end

    return bid == Auction.minimum and bid
        or Auction.minimum + GL:floor((bid - Auction.minimum) / Auction.increment, Settings:get("GDKP.precision")) * Auction.increment;
end

--- Check if the given bid is valid for the given auction ID
---
---@param auctionID string
---@param bid number
---@return boolean
function Client:isBidValidForAuction(auctionID, bid)
    bid = tonumber(bid) or 0;
    if (GL:lt(bid, .0001)) then
        return false;
    end

    local Auction = GL:tableGet(self.AuctionDetails, "Auctions." .. auctionID);
    if (not Auction) then
        return false;
    end

    local currentBid = GL:tableGet(Auction, "CurrentBid.amount", 0);
    return (GL:e(currentBid, 0) and GL:gte(bid, Auction.minimum)) or GL:gte(bid, currentBid + Auction.increment);
end

--- Return the minimum bid for the give auction
---
---@param auctionID number
---@return number
function Client:minimumBidForAuction(auctionID)
    local Auction = GL:tableGet(self.AuctionDetails, "Auctions." .. auctionID);
    if (not Auction) then
        return 0;
    end

    local currentBid = GL:tableGet(Auction, "CurrentBid.amount");
    return currentBid and currentBid + Auction.increment or Auction.minimum;
end

--- Let the user know that he was outbid
---
---@return void
function Client:outbidNotification()
    -- Flash the game icon in case the player alt-tabbed
    FlashClientIcon();

    GL:after(2, "GDKP.MultiAuction.OutbidNotification", function ()
        -- Play a sound if the user enabled it
        local outbidSound = GL.Settings:get("GDKP.outbidSound");
        if (not GL:empty(outbidSound)) then
            local sound = LibStub("LibSharedMedia-3.0"):Fetch("sound", outbidSound);
            GL:playSound(sound);
        end

        -- Provide visual feedback when you are outbid and the bidding window is closed
        if (not UI:isShown()) then
            if (UnitAffectingCombat("player")) then
                GL:info("You were outbid!");
            else
                GL.Interface.Alerts:fire("GargulNotification", {
                    message = string.format("|c00BE3333You were outbid!|r"),
                });
            end
        end
    end);
end