local _, App = ...;

App.Auction = {};
local Auction = App.Auction;
local CommActions = App.Data.Constants.Comm.Actions;

Auction.CurrentAuction = {
    auctioneer = nil, -- The player who started the auction
    time = nil, -- The amount of time players get to bid
    minimumBid = nil, -- The minimum amount players need to bid
    itemId = nil, -- The ID of the item we're bidding on
    itemName = nil, -- The name of the item we're bidding on
    itemLink = nil, -- The item link of the item we're bidding on
    itemIcon = nil, -- The icon of the item we're bidding on
    Bids = {}, -- Player's bids (only filled on auctioneer's side)
};

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs["AUCTION_AWARD_CONFIRMATION"] = {
    text = "",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs["CLEAR_AUCTION_CONFIRMATION"] = {
    text = "Are you sure you want to clear everything?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function ()
        App.Auction:reset();
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

Auction.inProgress = false;
Auction.timerId = 0; -- ID of the timer event

-- Anounce to everyone in the raid that an auction is starting
function Auction:announceStart(item, minimumBid, time)
    App:debug("Auction:announceStart");

    App.CommMessage.new(
        CommActions.startAuction,
        {
            item = item,
            minimumBid = minimumBid,
            time = time,
        },
        "RAID"
    ):send();
end

-- Anounce to everyone in the raid that an auction has ended
function Auction:announceStop()
    App:debug("Auction:announceStop");

    App.CommMessage.new(
        CommActions.stopAuction,
        {},
        "RAID"
    ):send();
end

-- Start an auction
function Auction:start(CommMessage)
    App:debug("Auction:start");

    local content = CommMessage.content;
    local time, minimumBid, isValidItem, itemId, itemName, itemLink, _, itemIcon = nil;

    -- We have to wait with starting the actual bidding process until
    -- the item that's up for auction has been sucessfully loaded by the Item API
    local startAuctionSequence = function()
        isValidItem, itemId, itemName, itemLink, _, _, _, _, _, _, _, itemIcon = App:getItemInfoFromLink(content.item);
        time = tonumber(content.time);
        minimumBid = tonumber(content.minimumBid);

        if (not isValidItem) then
            return App:error("Invalid item provided in Auction:start");
        elseif (minimumBid < 0) then
            return App:error("Invalid minimum bid provided in Auction:start");
        end

        self.inProgress = true;
        App.Bidder.hasEnoughDkpToBid = App.User.Dkp.amount >= minimumBid;

        if (not self.CurrentAuction
                or itemLink ~= self.CurrentAuction.itemLink
        ) then
            -- This is a new item so make sure to
            -- override all previously set properties
            self.CurrentAuction = {
                auctioneer = CommMessage.Sender.name,
                time = time,
                minimumBid = minimumBid,
                itemId = itemId,
                itemName = itemName,
                itemLink = itemLink,
                itemIcon = itemIcon,
                Bids = {},
            };
        else
            -- If we auction the same item again we do need to make
            -- sure that we update the minimum bid and bid timer
            self.CurrentAuction.time = time;
            self.CurrentAuction.minimumBid = minimumBid;
        end

        App.Bidder:startBidding(time, minimumBid, itemId, itemName, itemLink, itemIcon);

        self.timerId = App.Ace:ScheduleTimer(function ()
            self:stop();
        end, time);

        -- Play raid warning sound
        PlaySound(8959, "Master");
    end

    --[[
        MAKE SURE THE PAYLOAD IS VALID
        PROVIDE VERY SPECIFIC ERROR MESSAGE IF IT'S NOT
    ]]
    if (not content) then
        return App:error("Missing content in Auction:start");
    elseif (not type(content) == "table") then
        return App:error("Content is not a table in Auction:start");
    elseif (not content.time) then
        return App:error("No time provided in Auction:start");
    elseif (not content.minimumBid) then
        return App:error("No minimum bid provided in Auction:start");
    elseif (not content.item) then
        return App:error("No item provided in Auction:start");
    else
        -- Load the item from the Blizzard API and start the auction after it's retreived
        Item:CreateFromItemLink(content.item):ContinueOnItemLoad(function()
            startAuctionSequence();
        end);
    end
end

-- Stop an auction
function Auction:stop(CommMessage)
    App:debug("Auction:stop");

    if (not self.inProgress) then
        return App:warning("Can't stop auction, no auction in progress");
    end

    if (not self.CurrentAuction.auctioneer == App.User.name
        and not CommMessage.Sender.name == self.auctioneer
    ) then
        return App:warning(CommMessage.Sender.name .. " is not allowed to stop auction started by " .. self.auctioneer);
    end

    -- Play raid warning sound
    PlaySound(8959, "Master");

    self.inProgress = false;
    App.Ace:CancelTimer(self.timerId);

    App.Bidder:stopBidding();

    -- If we're the auctioneer then we need to update our auctioneer UI
    if (self.CurrentAuction.auctioneer == App.User.name) then
        App.AuctioneerUI:updateWidgets();
    end
end

-- Process an incoming bid
function Auction:processBid(CommMessage)
    App:debug("Auction:processBid");

    local bidIsNumerical, bid = pcall(function () return tonumber(CommMessage.content.bid); end);
    local sendersCurrentDkp = App.DB.Characters[CommMessage.Sender.name] or {};
    sendersCurrentDkp = sendersCurrentDkp.dkp or 0;

    -- This user is not the auctioneer, should never happen but you never know
    if (not App.User.name == self.CurrentAuction.auctioneer) then
        return SendChatMessage(
            "Something went wrong: I'm not the auctioneer!",
            "WHISPER",
            "COMMON",
            CommMessage.Sender.name
        );
    elseif (not bidIsNumerical or not bid) then
        return SendChatMessage(
            "Invalid bid, use numbers and periods (.) only",
            "WHISPER",
            "COMMON",
            CommMessage.Sender.name
        );
    elseif (not self.inProgress) then
        return SendChatMessage(
            "There is no auction currently in progress",
            "WHISPER",
            "COMMON",
            CommMessage.Sender.name
        );
    elseif (self.CurrentAuction.minimumBid > bid) then
        return SendChatMessage(
            "Your bid is lower than the minimum bid (" .. self.CurrentAuction.minimumBid .. " DKP)",
            "WHISPER",
            "COMMON",
            CommMessage.Sender.name
        );
    elseif (sendersCurrentDkp < bid) then
        return SendChatMessage(
            "You can't bid that much, you currently have " .. sendersCurrentDkp .. " DKP",
            "WHISPER",
            "COMMON",
            CommMessage.Sender.name
        );
    end

    self:acceptBid(CommMessage.Sender.name, bid, sendersCurrentDkp);

    return SendChatMessage(
        "Your bid of " .. bid .. " has been accepted",
        "WHISPER",
        "COMMON",
        CommMessage.Sender.name
    );
end

-- Someone wishes to retract their bid
function Auction:processRetractBid(CommMessage)
    App:debug("Auction:processRetractBid");

    if (not self.inProgress) then
        return SendChatMessage(
            "There is no auction currently in progress",
            "WHISPER",
            "COMMON",
            CommMessage.Sender.name
        );
    end

    self:retractBid(CommMessage.Sender.name);
end

-- Accept an incoming bid
function Auction:acceptBid(bidder, bid, biddersCurrentDkp)
    App:debug("Auction:acceptBid");

    self.CurrentAuction.Bids[bidder] = {
        bid = bid,
        totalDkp = biddersCurrentDkp
    };
    self:refreshBidTable();
end

-- Retract a bidder's bids (bidder refers to a player's name)
function Auction:retractBid(bidder)
    App:debug("Auction:retractBid");

    self.CurrentAuction.Bids[bidder] = nil;

    SendChatMessage(
        "Your bid has been retracted",
        "WHISPER",
        "COMMON",
        bidder
    );

    self:refreshBidTable();
end

function Auction:refreshBidTable()
    App:debug("Auction:refreshBidTable");

    local BidTableData = {};
    local Bids = self.CurrentAuction.Bids;
    local BidsTable = App.AuctioneerUI.Widgets.Tables.Bids;

    for player, value in pairs(Bids) do
        BidTableData[#BidTableData + 1] = {player, value.bid, value.totalDkp};
    end

    BidsTable:SetData(BidTableData, true);
    BidsTable:SortData();
end

-- Award the item to one of the bidders
function Auction:award(bidder)
    local Auction = self.CurrentAuction;
    local character = App:tableGet(App.DB.Characters, bidder, {});
    local awardMessage = "";
    local confirmationMessage = "";
    local bid = App:tableGet(Auction, "Bids." .. bidder .. ".bid", 0);

    -- This item went out for free (roll), no need to get all fancy
    if (not bid) then
        self:reset();

        awardMessage = string.format("%s awarded to %s. Congrats!",
            Auction.itemLink,
            bidder
        );

        return SendChatMessage(
            awardMessage,
            "RAID",
            "COMMON"
        );
    end

    awardMessage = string.format("%s awarded to %s for %s DKP. Congrats!",
        Auction.itemLink,
        bidder,
        bid
    );

    local award = function ()
        SendChatMessage(
            awardMessage,
            "RAID",
            "COMMON"
        );

        SendChatMessage(
            awardMessage,
            "GUILD",
            "COMMON"
        );

        App.CommMessage.new(
            CommActions.auctionResult,
            {
                itemLink = Auction.itemLink,
                itemName = Auction.itemName,
                itemId = Auction.itemId,
                winner = bidder,
                Bids = Auction.Bids,
                timestamp = GetServerTime(),
            },
            "GUILD"
        ):send();

        self:reset();
        Auction = {};
    end

    -- Make sure the auctioneer has to confirm his choices
    StaticPopupDialogs["AUCTION_AWARD_CONFIRMATION"].OnAccept = award;
    StaticPopupDialogs["AUCTION_AWARD_CONFIRMATION"].text = string.format("Award %s to %s for %s DKP?",
        Auction.itemLink,
        bidder,
        bid
    );
    StaticPopup_Show("AUCTION_AWARD_CONFIRMATION");
end

function Auction:reset()
    self.CurrentAuction = {
        auctioneer = nil, -- The player who started the auction
        time = nil, -- The amount of time players get to bid
        minimumBid = nil, -- The minimum amount players need to bid
        itemId = nil, -- The ID of the item we're bidding on
        itemName = nil, -- The name of the item we're bidding on
        itemLink = nil, -- The item link of the item we're bidding on
        itemIcon = nil, -- The icon of the item we're bidding on
        Bids = {}, -- Player's bids (only filled on auctioneer's side)
    };

    App.AuctioneerUI:reset();
end

function Auction:processResult(CommMessage)
    App:debug("Auction:processResult");

    local itemLink = CommMessage.content.itemLink;
    local itemName = CommMessage.content.itemName;
    local itemId = CommMessage.content.itemId;
    local winner = CommMessage.content.winner;
    local Bids = CommMessage.content.Bids;
    local timestamp = CommMessage.content.timestamp;

    if (not itemLink
        or not winner or winner == ""
    ) then
        return App:warning("Couldn't process auction result in Auction:processResult");
    end

    -- Get the winner's DB.Characters entry or create a new one
    local Character = {};
    if (not App.DB.Characters[winner]) then
        local characterClass = App.Player.fromName(winner) or {};
        Character = App.DB.Characters[winner] or {
            gained = 0,
            raids = 0,
            dkp = 0,
            spent = 0,
            class = characterClass or "unknown",
        };
    else
        Character = App.DB.Characters[winner];
    end

    local bid = 0;
    if (Bids and Bids[winner]) then
        bid = Bids[winner].bid;
        Character.dkp = Character.dkp - bid;
        Character.spent = Character.spent + bid;
    end

    local LootHistoryEntry = {
        player = winner,
        id = itemId,
        title = itemName,
        link = itemLink,
        dkp = bid,
        bids = {},
    };

    if (Bids and type(Bids) == "table") then
        for name, value in pairs (Bids) do
            if (name ~= winner) then
                tinsert(LootHistoryEntry.bids, {
                    player = name,
                    dkp = value.bid,
                });
            end
        end
    end

    App.DB.Characters[winner] = Character;
    App.DB.LootHistory[timestamp] = LootHistoryEntry;
end

App:debug("Auction.lua");