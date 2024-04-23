local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type DB
local DB = GL.DB;

---@type Data
local Constants = GL.Data.Constants;

---@type Events
local Events = GL.Events;

---@type Settings
local Settings = GL.Settings;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPPot
local GDKPPot;

---@type GDKPAuction
local GDKPAuction;

---@class GDKPSession
GDKP.Session = {
    _initialized = false,
    broadcastInProgress = false,
    includeTradeInSession = true,
    inProgress = false,
    lastOutBidNotificationShownAt = 0,
    requestingData = false,
    timerId = 0, -- ID of the timer event

    ItemHistory = {}, -- Historical data for items
};

---@type GDKPSession
local Session = GDKP.Session;

---@return void
function Session:_init()
    if (self._initialized) then
        return;
    end

    GDKPPot = GL.GDKP.Pot;
    GDKPAuction = GDKP.Auction;
    self._initialized = true;

    if (not GL.GDKPIsAllowed) then
        return;
    end

    -- Make sure trades involving gold are logged
    Events:register("GDKPSessionTradeCompletedListener", "GL.TRADE_COMPLETED", function (_, Details)
        self:registerGoldTrade(Details);
    end);

    -- Add gold to the trade window and whisper outstanding balance
    Events:register("GDKPSessionTradeInitiatedListener", "GL.TRADE_SHOW", function (_, Details)
        self:tradeInitiated(Details);
    end);

    -- Post a pot update in chat after creating an auction
    Events:register("GDKPSessionAuctionCreatedListener", "GL.GDKP_AUCTION_CREATED", function (_, sessionID)
        if (Settings:get("GDKP.announcePotAfterAuction")
            and sessionID == self:activeSessionID()
        ) then
            GL:sendChatMessage((L.CHAT.GDKP_POT_UPDATED):format(GDKPPot:humanTotal()), "GROUP");
        end
    end);

    -- Post a message in chat after deleting an auction
    Events:register("GDKPSessionAuctionDeletedListener", "GL.GDKP_AUCTION_DELETED", function (_, sessionID, _, Before)
        self:announceDeletedAuction(sessionID, Before);
    end);

    -- Post a message in chat after restoring an auction
    Events:register("GDKPSessionAuctionRestoredListener", "GL.GDKP_AUCTION_RESTORED", function (_, sessionID, _, Instance)
        self:announceRestoredAuction(sessionID, Instance);
    end);

    -- Post a message in chat after creating a gold trade entry
    Events:register("GDKPSessionGoldTradeCreatedListener", "GL.GDKP_GOLD_TRADE_CREATED", function (_, sessionID, playerGUID, given, received)
        self:announceCreatedGoldTrade(sessionID, playerGUID, given, received);
    end);

    -- Post a message in chat after deleting a gold trade entry
    Events:register("GDKPSessionGoldTradeDeletedListener", "GL.GDKP_GOLD_TRADE_DELETED", function (_, sessionID, playerGUID, given, received)
        self:announceDeletedGoldTrade(sessionID, playerGUID, given, received);
    end);

    -- Post a message in chat after deleting a gold trade entry
    Events:register("GDKPSessionGoldTradeRestoredListener", "GL.GDKP_GOLD_TRADE_RESTORED", function (_, sessionID, playerGUID, given, received)
        self:announceRestoredGoldTrade(sessionID, playerGUID, given, received);
    end);

    -- Update cuts and other details when our group composition changes
    Events:register("GDKPSessionGroupRosterUpdatedListener", "GL.GROUP_ROSTER_UPDATE_THROTTLED", function ()
        GDKPPot:clearUnavailablePlayerDetails(self:activeSessionID()); -- Reset raiders who left
        GDKPPot:calculateCuts(self:activeSessionID()); -- Calculate cuts for potential new joiners
        GL.Interface.GDKP.Distribute.Overview:refresh(); -- Refresh the distribution overview in case it's opened
    end);

    -- Make sure the user is made aware that a GDKP session is still active
    local Instance = self:getActive();
    if (Instance and not Instance.lockedAt) then
        GL.Ace:ScheduleTimer(function ()
            if (not self:userIsAllowedToBroadcast()) then
                return;
            end

            GL.Interface.Alerts:fire("GargulNotification", {
                message = ("|c00BE3333%s|r"):format(L.GDKP_ACTIVATED),
                onClick = function () GL.Interface.GDKP.Overview:open(); end,
            });
        end, 5);
    end
end

---@param playerGUID string
---@param sessionID string
---@return number, number, number, number Total given, Total received, Traded, Mailed
function Session:goldTradedWithPlayer(playerGUID, sessionID)
    local Instance;
    if (not sessionID) then
        Instance = self:getActive();
    else
        Instance = self:byID(sessionID);
    end

    if (not Instance) then
        return;
    end

    local copperTraded = 0;
    local copperMailed = 0;
    local copperReceived = 0;
    for _, Entry in pairs(GL:tableGet(Instance, "GoldLedger." .. playerGUID, {})) do
        if (not Entry.deletedAt) then
            Entry.given = tonumber(Entry.given) or 0;
            Entry.received = tonumber(Entry.received) or 0;

            if (Entry.type == Constants.GDKP.tradeIdentifier
                or Entry.type == Constants.GDKP.mutationIdentifier
            ) then
                copperTraded = copperTraded + Entry.given;
            elseif (Entry.type == Constants.GDKP.mailIdentifier) then
                copperMailed = copperMailed + Entry.given;
            end

            copperReceived = copperReceived + Entry.received;
        end
    end

    return copperTraded + copperMailed, copperReceived, copperTraded, copperMailed;
end

--- Copper owed to player based on everything bought, earned, cut, etc. This is the bottom line for this session!
--- The return value can be negative, in which case it's the player who owes you money
---
---@param player string
---@param sessionID string
---@return number
function Session:copperOwedToPlayer(player, sessionID)
    local Instance = self:byID(sessionID);
    if (not Instance) then
        return;
    end

    local playerGUID = GDKP:playerGUID(player);

    -- You can't owe yourself anything
    if (GL:iEquals(playerGUID, GL.User.fqn)) then
        return 0;
    end

    local copperGiven, copperReceived = self:goldTradedWithPlayer(playerGUID, sessionID);

    local playerCutInCopper = 0;
    -- Only include the player cut if the current GDKP session is locked and ready for payout
    if (Instance.lockedAt) then
        playerCutInCopper = GL:tableGet(Instance, "Pot.Cuts." .. playerGUID, 0) * 10000;
    end

    local copperSpentByPlayer = self:goldSpentByPlayer(playerGUID, Instance.ID) * 10000;
    local copperToReceive = copperSpentByPlayer - copperReceived;
    local copperToGive = playerCutInCopper - copperToReceive - copperGiven;

    return copperToGive;
end

--- We opened a trade window
---
---@param Details table
---@return void
function Session:tradeInitiated(Details)
    if (not Details.partner) then
        return;
    end

    local Instance = self:getActive();

    -- Check if the GDKP session exists and is locked for payout
    if (not Instance) then
        return;
    end

    local message = "";
    local partnerGUID = GDKP:playerGUID(Details.partner);
    local playerCut = GDKPPot:getCut(partnerGUID);

    local copperGiven, copperReceived = self:goldTradedWithPlayer(partnerGUID);
    local playerCutInCopper = playerCut * 10000;
    local copperSpentByPlayer = self:goldSpentByPlayer(partnerGUID) * 10000;
    local balance = tonumber(self:copperOwedToPlayer(partnerGUID, Instance.ID) or 0);

    local balanceMessage = " ";
    local whisperMessage = nil;
    if (balance > 0) then
        local due = GL:copperToMoney(balance);
        balanceMessage = ("|c00F7922E" .. L.GDKP_TRADE_GOLD_TO_GIVE .. "|r"):format(due);
        whisperMessage = (L.CHAT.GDKP_I_OWE_YOU):format(due);

    elseif (balance < 0) then
        local owed = GL:copperToMoney(balance * -1);
        balanceMessage = ("|c0092FF00" .. L.GDKP_TRADE_GOLD_TO_RECEIVE .. "|r"):format(owed);
        whisperMessage = (L.CHAT.GDKP_YOU_OWE_ME):format(owed);
    end

    if (whisperMessage and Settings:get("GDKP.whisperGoldDetails")) then
        GL:sendChatMessage(whisperMessage, "WHISPER", nil, Details.partner);
    end

    message = (L.GDKP_TRADE_BALANCE_INFO):format(
        GL:copperToMoney(copperSpentByPlayer),
        GL:copperToMoney(copperGiven),
        GL:copperToMoney(copperReceived),
        GL:copperToMoney(playerCutInCopper),
        balanceMessage
    );

    -- Just to be sure!
    if (not TradeFrame:IsShown()) then
        return;
    end

    -- Show the gold details window
    do
        self.includeTradeInSession = true;

        local Window = GL.AceGUI:Create("InlineGroup");
        Window:SetLayout("Flow");
        Window:SetWidth(190);
        Window:SetHeight(30);
        Window.frame:SetParent(TradeFrame);
        Window.frame:SetScript("OnHide", function()
            GL.Interface:release(Window);
            Window.frame:Hide();
        end);
        Window:SetPoint("TOPLEFT", TradeFrame, "TOPRIGHT", 0, 9);
        Window.frame:Show();

        local DescriptionLabel = GL.AceGUI:Create("Label");
        DescriptionLabel:SetFullWidth(true);
        DescriptionLabel:SetFontObject(_G["GameFontNormalSmall"]);
        DescriptionLabel:SetText(message);
        DescriptionLabel:SetColor(1, .95686, .40784);
        Window:AddChild(DescriptionLabel);

        local IncludeTradeInSession = GL.AceGUI:Create("CheckBox");
        IncludeTradeInSession:SetValue(false);
        IncludeTradeInSession:SetLabel(L.GDKP_TRADE_EXCLUDE_GOLD);
        IncludeTradeInSession:SetDescription(L.GDKP_TRADE_EXCLUDE_GOLD_INFO);
        IncludeTradeInSession:SetFullWidth(true);
        IncludeTradeInSession.text:SetTextColor(1, .95686, .40784);
        IncludeTradeInSession:SetCallback("OnValueChanged", function()
            self.includeTradeInSession = not IncludeTradeInSession:GetValue();
        end);
        Window:AddChild(IncludeTradeInSession);

        local TradeHistoryButton = GL.AceGUI:Create("Button");
        TradeHistoryButton:SetText(L.GDKP_GOLD_TRADES);
        TradeHistoryButton:SetFullWidth(true);
        TradeHistoryButton:SetCallback("OnClick", function()
            GL.Interface.GDKP.GoldTrades.Overview:open(self:activeSessionID(), partnerGUID);
        end);
        Window:AddChild(TradeHistoryButton);
    end

    -- Add the gold to the trade window
    if (playerCutInCopper > 0
        and balance
        and Settings:get("GDKP.addGoldToTradeWindow")
    ) then
        if (balance > GetMoney()) then
            GL:error((L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS):format(Details.partner));
        else
            GL.TradeWindow:setCopper(balance, Details.partner, function(success)
                if (success) then
                    return;
                end

                GL:error(string.format(
                    L.GDKP_TRADE_GOLD_ADD_FAILED,
                    GL:copperToMoney(balance)
                ));
            end);
        end
    end
end

---@param player string
---@param sessionID string
---@return number
function Session:goldSpentByPlayer(player, sessionID)
    sessionID = sessionID or self:activeSessionID();
    local Instance = self:byID(sessionID);
    if (not Instance) then
        return 0;
    end

    local playerGUID = GDKP:playerGUID(player);
    local spent = 0;
    for _, Sale in pairs(Instance.Auctions or {}) do
        if (not Sale.deletedAt and Sale.price and Sale.Winner.guid == playerGUID and GL:higherThanZero(Sale.price)) then
            spent = spent + Sale.price;

            if (Sale.paid) then
                spent = spent - Sale.paid
            end
        end
    end

    return spent;
end

---@param player string
---@param sessionID string
---@return number
function Session:goldBidByPlayer(player, sessionID)
    sessionID = sessionID or self:activeSessionID();
    local Instance = self:byID(sessionID);
    if (not Instance) then
        return 0;
    end

    local playerGUID = GDKP:playerGUID(player);
    local bid = 0;
    for _, Sale in pairs(Instance.Auctions or {}) do
        if (not Sale.deletedAt
            and Sale.price
            and Sale.Winner.guid ~= playerGUID
            and GL:higherThanZero(Sale.price)
            and Sale.Bids
        ) then
            for bidder, Bid in pairs(Sale.Bids or {}) do
                if (type(Bid) == "table"
                    and Bid.bid
                    and bidder == playerGUID
                ) then
                    bid = bid + Bid.bid;
                    break;
                end
            end
        end
    end

    return bid;
end

---@param sessionID string
---@param playerGUID string
---@param checksum
---
---@return boolean
function Session:deleteGoldTrade(sessionID, playerGUID, checksum)
    local Instance = self:byID(sessionID);
    if (not Instance
        or Instance.deletedAt
    ) then
        return false;
    end

    local Trade = GL:tableGet(Instance, ("GoldLedger.%s.%s"):format(playerGUID, checksum));
    if (not Trade) then
        return false;
    end

    GL:tableSet(Instance, ("GoldLedger.%s.%s.deletedAt"):format(playerGUID, checksum), GetServerTime());
    Events:fire("GL.GDKP_GOLD_TRADE_DELETED", sessionID, playerGUID, Trade.given, Trade.received);

    return self:store(Instance);
end

---@param sessionID string
---@param playerGUID string
---@param checksum
---
---@return boolean
function Session:restoreGoldTrade(sessionID, playerGUID, checksum)
    local Instance = self:byID(sessionID);
    if (not Instance
        or Instance.deletedAt
    ) then
        return false;
    end

    local RawTrade = GL:tableGet(Instance, ("GoldLedger.%s.%s"):format(playerGUID, checksum));
    if (not GL:empty(RawTrade)) then
        GL:tableSet(Instance, ("GoldLedger.%s.%s"):format(playerGUID, checksum), {
            createdAt = RawTrade.createdAt,
            type = RawTrade.type,
            given = RawTrade.given,
            received = RawTrade.received,
            createdBy = RawTrade.createdBy,
            checksum = RawTrade.checksum,
        });
    end

    Events:fire("GL.GDKP_GOLD_TRADE_RESTORED", sessionID, playerGUID, RawTrade.given, RawTrade.received);

    return self:store(Instance);
end

---@param sessionID string
---@param playerGUID string
---@param given number
---@param received number
---
---@return boolean
function Session:addGoldTrade(sessionID, playerGUID, given, received)
    local Instance = self:byID(sessionID);
    if (not Instance
        or Instance.deletedAt
    ) then
        return false;
    end

    given = tonumber(given) or 0;
    received = tonumber(received) or 0;

    -- Nothing to add
    if ((given > 0 and received > 0) or (given < 1 and received < 1)) then
        return false;
    end

    local now = GetServerTime();
    local checksum = GL:stringHash{ Constants.GDKP.tradeIdentifier, given, received, playerGUID, now };
    GL:tableSet(Instance, ("GoldLedger.%s.%s"):format(playerGUID, checksum), {
        createdAt = now,
        type = Constants.GDKP.mutationIdentifier,
        given = given,
        received = received,
        createdBy = GDKP:myGUID(),
        checksum = checksum;
    });

    Events:fire("GL.GDKP_GOLD_TRADE_CREATED", sessionID, playerGUID, given, received);

    return self:store(Instance);
end

---@param Details table
---@return void
function Session:registerGoldTrade(Details)
    -- The player didn't want to include this trade
    if (not self.includeTradeInSession) then
        return;
    end

    local Instance = self:getActive();
    if (not Instance) then
        return;
    end

    local myGold = Details.myGold;
    local theirGold = Details.theirGold;

    -- No gold was involved in this trade
    if (myGold <= 0 and theirGold <= 0) then
        return;
    end

    local playerGUID = GDKP:playerGUID(Details.partner);
    local now = GetServerTime();
    local checksum = GL:stringHash{ Constants.GDKP.tradeIdentifier, myGold, theirGold, playerGUID, now };
    GL:tableSet(Instance, ("GoldLedger.%s.%s"):format(playerGUID, checksum), {
        createdAt = now,
        type = Constants.GDKP.tradeIdentifier,
        given = myGold,
        received = theirGold,
        createdBy = GDKP:myGUID(),
        checksum = checksum;
    });

    Events:fire("GL.GDKP_GOLD_TRADED");

    -- Trade announcement was disabled for some reason. Not on my watch mister!
    if (not Details.announce) then
        Events:fire("GL.GDKP_GOLD_TRADE_CREATED", Instance.ID, playerGUID, myGold, theirGold);
    end

    self:store(Instance);
end

---@param player string
---@param copper number
---@return void
function Session:registerGoldMail(player, copper)
    local Instance = self:getActive();

    if (not Instance) then
        return;
    end

    local playerGUID = GDKP:playerGUID(player);
    local now = GetServerTime();
    local checksum = GL:stringHash{ Constants.GDKP.tradeIdentifier, copper, 0, playerGUID, now };
    GL:tableSet(Instance, ("GoldLedger.%s.%s"):format(playerGUID, checksum), {
        createdAt = now,
        type = Constants.GDKP.mailIdentifier,
        given = copper,
        received = 0,
        createdBy = GDKP:myGUID(),
        checksum = checksum,
    });

    Events:fire("GL.GDKP_GOLD_MAILED");

    self:store(Instance);
end

---@param ID string
---@return table|nil
function Session:byID(ID)
    if (not ID) then
        return;
    end

    return DB:get("GDKP.Ledger." .. ID);
end

---@param itemLinkOrID string|number
---@return table
function Session:itemHistory(itemLinkOrID)
    local itemID = tonumber(itemLinkOrID) or GL:getItemIDFromLink(itemLinkOrID);
    if (not itemID) then
        return;
    end

    if (self.ItemHistory[itemID]) then
        return self.ItemHistory[itemID];
    end

    local timesSold = 0;
    local totalSaleValue = 0;
    local lastSoldTimestamp = 0;
    local lastSoldPrice = 0;
    for _, Instance in pairs(DB:get("GDKP.Ledger") or {}) do
        for _, Auction in pairs(Instance.Auctions or {}) do
            if (type(Auction) == "table"
                and Auction.itemID == itemID
                and not Auction.deletedAt
                and GL:higherThanZero(Auction.price)
            ) then
                timesSold = timesSold + 1;
                totalSaleValue = totalSaleValue + Auction.price;

                if (Auction.createdAt > lastSoldTimestamp) then
                    lastSoldTimestamp = Auction.createdAt;
                    lastSoldPrice = Auction.price;
                end
            end
        end
    end

    local averageSaleValue = 0;
    if (timesSold > 0) then
        averageSaleValue = GL:floor(totalSaleValue / timesSold, Settings:get("GDKP.precision"));
    end

    self.ItemHistory[itemID] = {
        timesSold = timesSold,
        totalSaleValue = totalSaleValue,
        averageSaleValue = averageSaleValue,
        lastSoldTimestamp = lastSoldTimestamp,
        lastSoldPrice = lastSoldPrice,
    };

    return self.ItemHistory[itemID];
end

---@param itemLink string
---@return table
function Session:tooltipLines(itemLink)
    if (not Settings:get("GDKP.showHistoryOnTooltip")) then
        return {};
    end

    local Details = self:itemHistory(itemLink);

    if (not Details
        or Details.timesSold <= 0
    ) then
        return {};
    end

    local itemID = GL:getItemIDFromLink(itemLink);

    if (itemID == Constants.GDKP.potIncreaseItemID) then
        return {};
    end

    local PerItemSettings = GDKP:settingsForItemID(itemID);
    return GL:explode((L.GDKP_ITEM_SALE_HISTORY_TOOLTIP):format(
        Details.timesSold,
        GL:goldToMoney(Details.lastSoldPrice),
        GL:goldToMoney(Details.averageSaleValue),
        GL:goldToMoney(PerItemSettings.minimum),
        GL:goldToMoney(PerItemSettings.increment)
    ), "\n");
end

---@return table|boolean
function Session:getActive()
    local activeSessionIdentifier = self:activeSessionID();

    if (not activeSessionIdentifier) then
        return false;
    end

    return DB:get("GDKP.Ledger." .. activeSessionIdentifier, false);
end

---@param SessionObj table
---@return boolean
function Session:store(SessionObj)
    if (type(SessionObj) ~= "table"
        or GL:empty(SessionObj)
        or GL:empty(SessionObj.ID)
    ) then
        return false;
    end

    DB:set("GDKP.Ledger." .. SessionObj.ID, SessionObj);

    return true;
end

---@param sessionID string
---@return boolean
function Session:setActive(sessionID)
    local Instance = self:byID(sessionID);
    if (not Instance
        or Instance.deletedAt
        or DB:get("GDKP.activeSession") == sessionID
    ) then
        return false;
    end

    DB:set("GDKP.activeSession", sessionID);

    Events:fire("GL.GDKP_SESSION_ACTIVATED", sessionID);
    Events:fire("GL.GDKP_ACTIVE_SESSION_CHANGED");

    return true;
end

---@return string|boolean
function Session:activeSessionID()
    return DB:get("GDKP.activeSession", false);
end

--- Check whether the current user owns a GDKP session
---
---@return boolean
function Session:ownedByUser()
    for _, Instance in pairs (DB:get("GDKP.Ledger") or {}) do
        if (GL:tableGet(Instance or {}, "CreatedBy.uuid") == GL.User.id) then
            return true;
        end
    end

    return false;
end

---@return boolean
function Session:exists(sessionIdentifier)
    return not not DB:get("GDKP.Ledger." .. sessionIdentifier .. ".ID");
end

---@param title string
---@param managementCut number
---@param sessionType string
---@return table|boolean
function Session:create(title, managementCut, sessionType)
    if (type(title) ~= "string" or GL:empty(title)) then
        return false;
    end

    if (managementCut) then
        managementCut = tonumber(managementCut);
        if (managementCut
                and managementCut < 0
        ) then
            return false;
        end
    end

    local Instance = {
        title = GL:capitalize(string.sub(title, 0, 30)),
        createdAt = GetServerTime(),
        managementCut = managementCut,
        type = sessionType,
        Auctions = {},
        CreatedBy = {
            class = GL.User.class,
            name = GL.User.name,
            realm = GL.User.realm,
            guild = GL.User.Guild.name,
            uuid = GL.User.id,
            guid = GDKP:myGUID(),
            bnid = GL.User:bth(),
        },
        Pot = {
            Mutators = Settings:get("GDKP.Mutators", {}),
        },
    };

    local checksum = Instance.createdAt .. GL:stringHash(Instance);
    Instance.ID = checksum;

    DB:set("GDKP.Ledger." .. checksum, Instance);
    Events:fire("GL.GDKP_SESSION_CREATED", Instance);

    return Instance;
end

---@param sessionID string
---@param title string
---@param managementCut number|nil
---@param sessionType string
---@return boolean|table
function Session:edit(sessionID, title, managementCut, sessionType)
    if (type(title) ~= "string" or GL:empty(title)) then
        return false;
    end

    local Instance = self:byID(sessionID);

    if (not Instance) then
        return false;
    end

    if (not GL:empty(managementCut)
        and tonumber(managementCut)
        and not GL:higherThanZero(tonumber(managementCut))
    ) then
        return false;
    end

    if (not GL:empty(managementCut)) then
        Instance.managementCut = tonumber(managementCut);
    else
        Instance.managementCut = 0;
    end

    Instance.type = sessionType;

    Instance.title = GL:capitalize(string.sub(title, 0, 30));
    DB:set("GDKP.Ledger." .. Instance.ID, Instance);
    Events:fire("GL.GDKP_SESSION_CHANGED", Instance, self:byID(sessionID));

    return Instance;
end

---@param sessionID string
---@return boolean
function Session:lock(sessionID)
    local Instance = self:byID(sessionID);

    if (not Instance or Instance.lockedAt) then
        return false;
    end

    Instance.lockedAt = GetServerTime();
    self:store(Instance);

    Events:fire("GL.GDKP_SESSION_LOCKED", Instance);
    return true;
end

---@param sessionID string
---@return boolean
function Session:unlock(sessionID)
    local Instance = self:byID(sessionID);
    if (not Instance or not Instance.lockedAt) then
        return false;
    end

    Instance.lockedAt = nil;
    self:store(Instance);

    Events:fire("GL.GDKP_SESSION_UNLOCKED", Instance);
    return true;
end

---@param sessionID string
---@return boolean
function Session:toggleLock(sessionID)
    local Instance = self:byID(sessionID);
    if (not Instance) then
        return false;
    end

    if (Instance.lockedAt) then
        return self:unlock(sessionID);
    end

    return self:lock(sessionID);
end

---@param sessionID string
---@return boolean
function Session:delete(sessionID)
    local Instance = self:byID(sessionID);

    if (not Instance) then
        return false;
    end

    -- This session is the currently active one, clear it
    if (DB:get("GDKP.activeSession") == sessionID) then
        self:clearActive();
    end

    -- There are no auctions attached to this session, we can safely remove it!
    if (GL:empty(Instance.Auctions)) then
        DB:set("GDKP.Ledger." .. sessionID, nil);

    -- There are auctions, mark the Session as deleted but keep it for 24h still
    else
        DB:set("GDKP.Ledger." .. sessionID .. ".deletedAt", GetServerTime());
    end

    Events:fire("GL.GDKP_SESSION_CHANGED", Instance);
    Events:fire("GL.GDKP_SESSION_DELETED", sessionID);

    return true;
end

---@param sessionID string
---@return boolean
function Session:restore(sessionID)
    local Instance = self:byID(sessionID);

    if (not Instance or not Instance.deletedAt) then
        return false;
    end

    DB:set("GDKP.Ledger." .. sessionID .. ".deletedAt", nil);

    Events:fire("GL.GDKP_SESSION_CHANGED", Instance, self:byID(sessionID));
    Events:fire("GL.GDKP_SESSION_RESTORED", sessionID);

    return true;
end

--- Clear the currently active session
---
---@return void
function Session:clearActive()
    local activeSession = DB:get("GDKP.activeSession");
    if (not activeSession) then
        return false;
    end

    DB:set("GDKP.activeSession", nil);

    Events:fire("GL.GDKP_ACTIVE_SESSION_CLEARED", activeSession);
    Events:fire("GL.GDKP_ACTIVE_SESSION_CHANGED");

    return true;
end

---@return boolean
function Session:userIsAllowedToBroadcast()
    return not GL.User.isInGroup or (
        GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist)
    );
end

---@param sessionID string
---@param Auction table
---@return void
function Session:announceDeletedAuction(sessionID, Auction)
    if (sessionID ~= self:activeSessionID()) then
        return;
    end

    local total = tonumber(GDKPPot:total()) or 0;
    if (total < 1) then
        total = 0;
    end

    if (Auction and Auction.itemLink and Auction.itemID) then
        local winner = GL:tableGet(Auction, "PreviousStates.1.Winner.name");
        local price = GL:tableGet(Auction, "PreviousStates.1.price");

        -- This was raw gold added to the pot
        if (Auction.itemID == Constants.GDKP.potIncreaseItemID) then
            GL:sendChatMessage((L.CHAT.GDKP_REMOVED_GOLD):format(GL:goldToMoney(price)), "GROUP");
            GL:sendChatMessage((L.CHAT.GDKP_POT_HOLDS):format(GDKPPot:humanTotal()), "GROUP");

            return;

            -- Just in case someone has old data still
        elseif (winner and price) then
            GL:sendChatMessage((L.CHAT.GDKP_REMOVED_AWARDED):format(Auction.itemLink, winner, GL:goldToMoney(price)), "GROUP");
            GL:sendChatMessage((L.CHAT.GDKP_POT_HOLDS):format(GDKPPot:humanTotal()), "GROUP");

            return;
        end

        GL:sendChatMessage((L.CHAT.GDKP_POT_UPDATED_AFTER_DELETE):format(GDKPPot:humanTotal()), "GROUP");
    else
        -- Should not be possible, shenanigans?
        GL:sendChatMessage((L.CHAT.GDKP_POT_UPDATED_AFTER_DELETE):format(GDKPPot:humanTotal()), "GROUP");
    end
end

---@param sessionID string
---@param Auction table
---@return void
function Session:announceRestoredAuction(sessionID, Auction)
    if (sessionID ~= self:activeSessionID()) then
        return;
    end

    local total = tonumber(GDKPPot:total()) or 0;
    if (total < 1) then
        total = 0;
    end

    if (Auction and Auction.itemLink and Auction.itemID) then
        local winner = GL:tableGet(Auction, "Winner.name");
        local price = Auction.price;

        -- This was raw gold added to the pot
        if (Auction.itemID == Constants.GDKP.potIncreaseItemID) then
            GL:sendChatMessage((L.CHAT.GDKP_RESTORED_GOLD):format(price), "GROUP");
            GL:sendChatMessage((L.CHAT.GDKP_POT_HOLDS):format(GDKPPot:humanTotal()), "GROUP");
            return;

            -- Just in case someone has old data still
        elseif (winner and price) then
            GL:sendChatMessage((L.CHAT.GDKP_RESTORED_AWARDED):format(Auction.itemLink, winner, GL:goldToMoney(price)), "GROUP");
            GL:sendChatMessage((L.CHAT.GDKP_POT_HOLDS):format(GDKPPot:humanTotal()), "GROUP");

            return;
        end

        GL:sendChatMessage(string.format(L.CHAT.GDKP_POT_UPDATED_AFTER_RESTORE, tostring(total)), "GROUP");
    else
        -- Should not be possible, shenanigans?
        GL:sendChatMessage(string.format(L.CHAT.GDKP_POT_UPDATED_AFTER_RESTORE, tostring(total)), "GROUP");
    end
end

---@param sessionID string
---@param playerGUID string
---@param given number
---@param received number
---@return void
function Session:announceCreatedGoldTrade(sessionID, playerGUID, given, received)
    if (sessionID ~= self:activeSessionID()) then
        return;
    end

    local playerName = GL:disambiguateName(playerGUID);
    if (given > 0) then
        GL:sendChatMessage((L.CHAT.GOLD_TRADE_GIVEN):format(GL:copperToMoney(given), playerName), "GROUP");
    else
        GL:sendChatMessage((L.CHAT.GOLD_TRADE_RECEIVED):format(GL:copperToMoney(received), playerName), "GROUP");
    end
end

---@param sessionID string
---@param playerGUID string
---@param given number
---@param received number
---@return void
function Session:announceDeletedGoldTrade(sessionID, playerGUID, given, received)
    if (sessionID ~= self:activeSessionID()) then
        return;
    end

    local playerName = GL:disambiguateName(playerGUID);
    if (given > 0) then
        GL:sendChatMessage((L.CHAT.GOLD_TRADE_GIVEN_DELETED):format(GL:copperToMoney(given), playerName), "GROUP");
    else
        GL:sendChatMessage((L.CHAT.GOLD_TRADE_RECEIVED_DELETED):format(GL:copperToMoney(received), playerName), "GROUP");
    end
end

---@param sessionID string
---@param playerGUID string
---@param given number
---@param received number
---@return void
function Session:announceRestoredGoldTrade(sessionID, playerGUID, given, received)
    if (sessionID ~= self:activeSessionID()) then
        return;
    end

    local playerName = GL:disambiguateName(playerGUID);
    if (given > 0) then
        GL:sendChatMessage((L.CHAT.GOLD_TRADE_GIVEN_RESTORED):format(GL:copperToMoney(given), playerName), "GROUP");
    else
        GL:sendChatMessage((L.CHAT.GOLD_TRADE_RECEIVED_RESTORED):format(GL:copperToMoney(received), playerName), "GROUP");
    end
end
