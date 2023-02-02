--[[ TEST MACROS
    Add an item link to the queue or set it as the active item to be auctioned off (depends on whether queue is active)
    /script _G.Gargul.GDKP.Auctioneer:addItemLink("|cffa335ee|Hitem:40388::::::::80:::::|h[Journey's End]|h|r");

    Set an item as the active item to be auctioned off
    /script _G.Gargul.GDKP.Auctioneer:setItemByLink("|cffa335ee|Hitem:40388::::::::80:::::|h[Journey's End]|h|r");

    Add an item link to the queue
    /script _G.Gargul.GDKP.Auctioneer:addToQueue("|cffa335ee|Hitem:40388::::::::80:::::|h[Journey's End]|h|r");

    Pop the top item from the queue
    /script _G.Gargul.GDKP.Auctioneer:popFromQueue();

    Clear the currently active item
    /script _G.Gargul.GDKP.Auctioneer:clear();

    Start!
    /script _G.Gargul.GDKP.Auctioneer:start();
]]

local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Data
local Constants = GL.Data.Constants;

---@type Settings
local Settings = GL.Settings;

---@type Events
local Events = GL.Events;

---@type DB
local DB = GL.DB;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPAuction
local Auction = GDKP.Auction;

---@class GDKPAuctioneer
GL.GDKP.Auctioneer = {
    _initialized = false,
    queueModeActivated = false,
    lastBidAnnouncementAt= nil,

    PopTimer = nil,
    BidAnnouncementThrottler = nil,
};

---@type GDKPAuctioneer
local Auctioneer = GL.GDKP.Auctioneer;

---@type GDKPAuctioneerInterface
local AuctioneerUI;

--[[ CONSTANTS ]]
local DEFAULT_AUCTION_EXTENSION = 10;
local DEFAULT_AUCTION_SHORTENING = 10;

---@return void
function Auctioneer:_init()
    GL:debug("Auctioneer:_init");

    if (self._initialized) then
        return;
    end

    self._initialized = true;

    -- Update the bids table when a new bid comes in
    Events:register("AuctioneerBidAccepted", "GL.GDKP_BID_ACCEPTED", function ()
        self:refreshBidsTable();
    end);

    -- Close the auctioneer window on auction start
    Events:register("AuctioneerAuctionStarted", "GL.GDKP_AUCTION_STARTED", function ()
        AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;
        local Window = AuctioneerUI:getWindow();

        if (Window) then
            Window:start();
        end

        -- Make sure the reopen shortcut button is drawn
        if (not AuctioneerUI.isVisible) then
            AuctioneerUI:openAuctioneerShortcut();
        end

        if (Settings:get("GDKP.minimizeAuctioneerOnStart")) then
            Window.Minimize.MinimizeButton:Click();
        end
    end);

    -- Auction stopped, update the minimized auctioneer frame
    Events:register("AuctioneerAuctionStopped", "GL.GDKP_AUCTION_STOPPED", function ()
        AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;
        local Window = AuctioneerUI:getWindow();

        if (Window) then
            Window:stop();
            Window.Minimized.StopButton:Hide();
            Window.Minimized.OpenButton:Show();
        end
    end);

    -- An item dropped, add it to the queue
    Events:register("AuctioneerItemReceived", "GL.ITEM_RECEIVED", function (_, Details)
        -- We don't want to automatically add loot
        if (not Settings:get("GKDP.addDropsToQueue")) then
            return;
        end

        -- We're only interested in items that we received
        if (not GL:iEquals(Details.playerName, GL.User.name)) then
            return;
        end

        -- This isn't an item we should put up for display
        if (GL:inTable(Constants.ItemsThatSouldntBeAnnounced, Details.itemID)) then
            return;
        end

        -- Check if we want this quality
        if (Details.quality < Settings:get("GDKP.minimumDropValue")) then
            return;
        end

        self:addToQueue(Details.itemLink);
    end);

    -- Softres/TMB details changed, update the icon glows if needed
    Events:register({
        "GL.SOFTRES_IMPORTED",
        "GL.SOFTRES_CLEARED",
        "GL.TMB_IMPORTED",
        "GL.TMB_CLEARED",
    }, function ()
        AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;
        AuctioneerUI:refreshIconGlows();
    end);
end

---@return void
function Auctioneer:toggleQueueStatus()
    GL:debug("Auctioneer:toggleQueueStatus");
    local halted = not Settings:get("GDKP.queueIsHalted");

    Settings:set("GDKP.queueIsHalted", halted);

    if (not halted
        and not Auction.inProgress
    ) then
        self:start();
    end
end

--- Add an item link to the queue or set it as the active item to be auctioned off
---
---@param itemLink string
---@return void
function Auctioneer:addItemLink(itemLink)
    GL:debug("Auctioneer:addItemLink");

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;

    if (AuctioneerUI.itemLink) then
        self:addToQueue(itemLink);
        return;
    end

    self:setItemByLink(itemLink);
end

---@param itemLink string
---@param identifier string
---@return void
function Auctioneer:addToQueue(itemLink, identifier)
    GL:debug("Auctioneer:addToQueue");

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;

    local Queue = AuctioneerUI:getQueueWindow(true);
    Queue:addItemByLink(itemLink, identifier, function (newIdentifier)
        Auction:addToQueue(itemLink, identifier or newIdentifier);
    end);

    AuctioneerUI:open();
end

--- Check whether the given or current user is allowed to broadcast
---
---@return boolean
function Auctioneer:allowedToBroadcast(playerID)
    GL:debug("Auction:allowedToBroadcast");

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
function Auctioneer:populateQueueFromUI()
    GL:debug("Auctioneer:populateQueueFromUI");

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;
    local ItemRows = AuctioneerUI.ItemRows;

    if (not ItemRows) then
        return;
    end

    Auction.Queue = {};
    for _, Row in pairs(ItemRows or {}) do
        if (Row._itemLink and Row._identifier) then
            Auction:addToQueue(Row._itemLink, Row._identifier);
        end
    end
end

---@param itemLink string
---@param fromQueue boolean
---@return void
function Auctioneer:setItemByLink(itemLink, fromQueue)
    GL:debug("Auctioneer:setItemByLink");

    if (GL.User.isInGroup
        and not GL.User.isMasterLooter
        and not GL.User.hasAssist
    ) then
        return GL:warning("You need to be the master looter or have an assist / lead role!");
    end

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;

    if (fromQueue) then
        AuctioneerUI:build():setItemByLink(itemLink);
    else
        AuctioneerUI:open():setItemByLink(itemLink);
    end
end

---@return void
function Auctioneer:clear()
    GL:debug("Auctioneer:clear");

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;
    local Window = AuctioneerUI:getWindow();
    local BidsTable = AuctioneerUI:getBidsTable();

    -- Nothing is built yet, so there's nothing to remove
    if (not Window) then
        return;
    end

    Window:clearItem();
    BidsTable:SetData({}, true);
    Auction:reset();
end

---@return void
function Auctioneer:disenchant(itemLink)
    GL:debug("Auctioneer:disenchant");

    GL.PackMule:disenchant(itemLink, true, function ()
        if (Settings:get("GDKP.minimizeAuctioneerOnAward")) then
            AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;
            local Window = AuctioneerUI:getWindow();

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
---@return
function Auctioneer:popFromQueue(force)
    GL:debug("Auctioneer:popFromQueue");

    -- The user halted the queue
    if (not force and Settings:get("GDKP.queueIsHalted")) then
        return;
    end

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;

    for key, Row in pairs(AuctioneerUI.ItemRows or {}) do
        if (Row._identifier and Row._itemLink) then
            self:setItemByLink(Row._itemLink, true);
            Auction:removeFromQueue(Row._identifier);
            AuctioneerUI:deleteRowFromQueue(Row);
            break;
        else
            AuctioneerUI.ItemRows[key] = nil;
        end
    end
end

---@return void
function Auctioneer:clearQueue()
    GL:debug("Auctioneer:clearQueue");

    Auction:clearQueue();
end

---@param force boolean
---@param triedQueue boolean
---@return void
function Auctioneer:start(force, triedQueue)
    GL:debug("Auctioneer:start");

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;

    -- There is no active item, see if we can pop one from the queue
    if (not AuctioneerUI.itemLink) then
        if (not triedQueue) then
            self:popFromQueue(force);
            return self:start(force, true);
        else
            return;
        end
    end

    if (Auction:announceStart(
        AuctioneerUI.itemLink,
        AuctioneerUI.minimumBid,
        AuctioneerUI.increment,
        AuctioneerUI.time,
        AuctioneerUI.antiSnipe
    )) then
        self:storeDetailsForFutureAuctions({
            itemLink = AuctioneerUI.itemLink,
            minimumBid = AuctioneerUI.minimumBid,
            increment = AuctioneerUI.increment,
            time = AuctioneerUI.time,
            antiSnipe = AuctioneerUI.antiSnipe,
        });
    end;
end

---@return void
function Auctioneer:stop()
    GL:debug("Auctioneer:stop");

    GL.Ace:CancelTimer(self.PopTimer);
    Auction:announceStop(true);
end

---@return boolean
function Auctioneer:extend()
    GL:debug("Auctioneer:extend");

    return Auction:announceExtension(DEFAULT_AUCTION_EXTENSION);
end

---@return boolean
function Auctioneer:shorten()
    GL:debug("Auctioneer:shorten");

    return Auction:announceShortening(DEFAULT_AUCTION_SHORTENING);
end

---@return void
function Auctioneer:timeRanOut()
    GL:debug("Auctioneer:timeRanOut");

    if (Auction.inProgress) then
        return;
    end

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;
    local delayBetweenQueuedAuctions = tonumber(Settings:get("GDKP.delayBetweenQueuedAuctions")) or 0;

    if (not GL:tableGet(Auction.Current, "TopBid.Bidder.name")) then
        local actionWhenNoBidsArePresent = Settings:get("GDKP.queuedAuctionNoBidsAction");

        if (actionWhenNoBidsArePresent ~= GL.Data.Constants.GDKP.QueuedAuctionNoBidsActions.NOTHING) then
            local next = function ()
                self:clear();
                Auction:reset(); -- Reset the actual auction object
                AuctioneerUI:closeAuctioneerShortcut();

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
                return GL.PackMule:disenchant(Auction.Current.itemLink, true, function ()
                    next();
                end);
            end

            next();
            return;
        end

        if (not AuctioneerUI.isVisible) then
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
    AuctioneerUI:closeAuctioneerShortcut();

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
    GL:debug("Auctioneer:storeDetailsForFutureAuctions");

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

---@return void
function Auctioneer:refreshBidsTable()
    GL:debug("Auctioneer:refreshBidsTable");

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;
    local BidsTable = AuctioneerUI:getBidsTable();

    -- Nothing is built yet, so there's nothing to refresh
    if (not BidsTable) then
        return;
    end

    local BidTableData = {};
    local Bids = GDKP.Auction.Current.Bids;

    local row = 0;
    for _, Entry in pairs(Bids) do
        row = row + 1;
        local bidder = Entry.Bidder.name;
        local class = Entry.Bidder.class;
        local priority = 1;

        local Row = {
            cols = {
                {
                    value = bidder,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = Entry.bid,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = "Interface/AddOns/Gargul/Assets/Buttons/delete", _OnClick = function ()
                        if (not Auction.inProgress) then
                            self:removePlayerBid(bidder, Entry.bid);
                        else
                            GL.Interface.Alerts:fire("GargulNotification", {
                                message = string.format("|c00BE3333Stop the auction first!|r"),
                            });
                        end
                    end,
                    _tooltip = L.DELETE_BID_TOOLTIP,
                },
                {
                    value = priority,
                },
            },
        };
        tinsert(BidTableData, Row);
    end

    BidsTable:SetData(BidTableData);
    BidsTable:SortData();

    if (row > 0) then
        BidsTable:SetSelection(row);
    end
end

---@param bidder string
---@param bid number
---@return void
function Auctioneer:removePlayerBid (bidder, bid)
    GL:debug("Auctioneer:removePlayerBid");

    local Bids = Auction.Current.Bids or {};

    local bidRemoved = false;
    for key, Bid in pairs(Bids) do
        if (Bid.bid == bid and GL:iEquals(Bid.Bidder.name, bidder)) then
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
    GL:debug("Auctioneer:announceBid");

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

        if (not currentTopBid.bid or not bidder) then
            return;
        end

        bidApprovedMessage = string.format(bidApprovedMessage, bidder, currentTopBid);
        GL:sendChatMessage(bidApprovedMessage, "RAID_WARNING", nil, nil, false);
        self.lastBidAnnouncementAt = GetTime();
    end, 1);
end

---@return void
function Auctioneer:award()
    GL:debug("Auctioneer:award");

    AuctioneerUI = AuctioneerUI or GL.Interface.GDKP.Auctioneer;

    if (not AuctioneerUI.itemLink) then
        return;
    end

    local BidsTable = AuctioneerUI:getBidsTable();
    local selected = BidsTable:GetRow(BidsTable:GetSelection());

    -- No bid is selected, open the direct award window
    if (not selected
        or not type(selected) == "table"
    ) then
        return GL.Interface.Award:draw(AuctioneerUI.itemLink, function ()
            if (Settings:get("GDKP.minimizeAuctioneerOnAward")) then
                local Window = AuctioneerUI:getWindow();

                if (not Window) then
                    return;
                end

                Window.Minimize.MinimizeButton:Click();
            end
        end);
    end

    local winner = selected.cols[1].value;
    local bid = selected.cols[2].value;

    GL.Interface.Dialogs.PopupDialog:open({
        question = string.format(L.AWARD_ITEM_CONFIRMATION,
            Auction.Current.itemLink,
            GL:classHexColor(GL.Player:classByName(winner)),
            winner,
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
            AuctioneerUI:closeAuctioneerShortcut();

            self:clear();
            self:start();

            if (Settings:get("GDKP.minimizeAuctioneerOnAward")) then
                local Window = AuctioneerUI:getWindow();

                if (not Window) then
                    return;
                end

                Window.Minimize.MinimizeButton:Click();
            end
        end,
    });
end

GL:debug("GDKP/Auctioneer.lua");