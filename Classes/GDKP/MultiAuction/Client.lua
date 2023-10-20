---@type GL
local _, GL = ...;

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

---@return void
function Client:_init()
    if (self._initialized) then
        return;
    end

    UI = GL.Interface.GDKP.MultiAuction.Client;

    self._initialized = true;
end

--- This is used to determine which session to take over / participate in
--- when joining a group or logging (back) into the game
--- /dump _G.Gargul.GDKP.MultiAuction.Client:currentSessionHash();
---
---@return string
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
    if (not Auctioneer:userIsAllowedToBroadcast(GL:tableGet(Message, "Sender.id", ""))) then
        return;
    end

    self.AuctionDetails = {
        initiator = Message.Sender.fqn,
        antiSnipe = Message.content.antiSnipe,
        bth = Message.content.bth,
        Auctions = {},
    };

    local activeAuctions = false;
    local serverTime = GetServerTime();
    for _, Item in pairs(GL:tableGet(Message, "content.ItemDetails", {})) do
        self.AuctionDetails.Auctions[Item.auctionID] = Item;

        if (serverTime < Item.endsAt) then
            activeAuctions = true;
        end
    end

    UI:clear();

    UI:open();
    UI:refresh();

    GL:after(.1, nil, function ()
        UI.showFavorites = true;
        UI.showUnusable = false;
        UI.ToggleFavorites:GetScript("OnClick")();
        UI.ToggleUnusable:GetScript("OnClick")();
    end);

    -- Looks like there are no active auctions, this can happen when joining a new group with expired data
    if (not activeAuctions) then
        UI:close();
    end
end

---@param auctionID number
---@param amount number
function Client:bid(auctionID, amount)
    if (Auctioneer:auctionStartedByMe(auctionID)) then
        Auctioneer:processBid({
            Sender = {
                fqn = GL.User.fqn,
            },
            content = {
                auctionID = auctionID,
                bid = amount,
            }
        });

        return;
    end

    GL.CommMessage.new(
        GL.Data.Constants.Comm.Actions.bidOnGDKPMultiAuction,
        { auctionID = auctionID, bid = amount, },
        "WHISPER",
        self.AuctionDetails.initiator
    ):send();
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
        if (GL:tableGet(self.AuctionDetails, "Auctions." .. auctionID)) then
            if (Details.a > 0) then
                self.AuctionDetails.Auctions[auctionID].CurrentBid = {
                    amount = Details.a,
                    player = Details.p,
                };
            else
                self.AuctionDetails.Auctions[auctionID].CurrentBid = nil;
            end

            self.AuctionDetails.Auctions[auctionID].endsAt = Details.e or self.AuctionDetails.Auctions[auctionID].endsAt;
        end
    end

    UI:refresh();
end

--- Check if the given bid is valid for the given auction ID
---
---@param auctionID string
---@param bid number
---@return boolean
function Client:isBidValidForAuction(auctionID, bid)
    bid = tonumber(bid) or 0;
    if (bid < 1) then
        return false;
    end

    local Auction = GL:tableGet(self.AuctionDetails, "Auctions." .. auctionID);
    if (not Auction) then
        return false;
    end

    local currentBid = GL:tableGet(Auction, "CurrentBid.amount", 0);
    return (currentBid == 0 and bid >= Auction.minimum) or bid >= Auction.minimum + Auction.increment;
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
