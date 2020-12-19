local _, App = ...;

App.Bidder = App.Bidder or {};

local Bidder = App.Bidder;
local CommActions = App.Data.Constants.CommActions;

Bidder.hasEnoughDkpToBid = false;

function Bidder:startBidding(...)
    App:debug("Bidder:startBidding");

    App.BidderUI:show(...);
end

function Bidder:stopBidding()
    App:debug("Bidder:stopBidding");

    self.hasEnoughDkpToBid = false;

    App.BidderUI:hide();
end

-- Send a bid to auctioneer
function Bidder:bid(bid)
    App:debug("Bidder:bid");
    local bidIsNumerical, bid = pcall(function () return tonumber(bid); end);

    if (not bidIsNumerical or not bid) then
        App:error("Invalid bid, use numbers and periods (.) only");
    elseif (not App.Auction.inProgress) then
        App:error("There is no auction currently in progress");
    elseif (App.Auction.CurrentAuction.minimumBid > bid) then
        App:error("Your bid is lower than the minimum bid (" .. App.Auction.CurrentAuction.minimumBid .. " DKP)");
    elseif (App.User.Dkp.amount < bid) then
        App:error("You can't bid that much, you currently have " .. App.User.Dkp.amount .. " DKP");
    else
        -- Send our bid to the auctioneer
        App.CommMessage.new(
            CommActions.bid,
            {bid = bid},
            "WHISPER",
            App.Auction.CurrentAuction.auctioneer
        ):send();

        return true;
    end

    return false;
end

-- Retract your bid
function Bidder:retractBid()
    App.CommMessage.new(
        CommActions.retractBid,
        {},
        "WHISPER",
        App.Auction.CurrentAuction.auctioneer
    ):send();
end

App:debug("Bidder.lua");