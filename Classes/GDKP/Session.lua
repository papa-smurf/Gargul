---@type GL
local _, GL = ...;

---@type DB
local DB = GL.DB;

---@type Data
local Constants = GL.Data.Constants;
local CommActions = Constants.Comm.Actions;

---@type Events
local Events = GL.Events;

---@type Settings
local Settings = GL.Settings;

---@class GDKP
GL.GDKP = GL.GDKP or {};

---@type GDKP
local GDKP = GL.GDKP;

---@class GDKPSession
GDKP.Session = {
    _initialized = false,
    broadcastInProgress = false,
    inProgress = false,
    lastOutBidNotificationShownAt = nil,
    listeningForBids = false,
    requestingData = false,
    timerId = 0, -- ID of the timer event

    ItemHistory = {}, -- Historical data for items
};

---@type GDKPSession
local Session = GDKP.Session;

function Session:_init()
    GL:debug("Session:_init");

    if (self._initialized) then
        return;
    end

    self._initialized = true;

    Events:register("GDKPSessionTradeCompletedListener", "GL.TRADE_COMPLETED", function (_, Details)
        self:registerGoldTrade(Details);
    end);
end

---@param Details table
---@return void
function Session:registerGoldTrade(Details)
    GL:debug("Session:registerTrade");

    local Instance = self:getActive();

    if (not Instance) then
        return;
    end

    local myGold = Details.myGold;
    local theirGold = Details.theirGold;

    -- No gold was involved in this trade
    if (myGold <= 0 and theirGold <=0) then
        return;
    end

    Instance.GoldTrades = Instance.GoldTrades or {};
    Instance.GoldTrades[Details.partner] = Instance.GoldTrades[Details.partner] or {
        to = 0,
        from = 0,
    };

    Instance.GoldTrades[Details.partner].from = Instance.GoldTrades[Details.partner].from + theirGold;
    Instance.GoldTrades[Details.partner].to = Instance.GoldTrades[Details.partner].to + myGold;

    self:store(Instance);
end

---@param ID string
---@return table|nil
function Session:byID(ID)
    GL:debug("Session:sessionByID");

    if (not ID) then
        return;
    end

    return DB:get("GDKP.Ledger." .. ID);
end

---@param itemLinkOrID string|number
---@return table
function Session:itemHistory(itemLinkOrID)
    GL:debug("Session:itemHistory");

    local itemID;
    local concernsID = GL:higherThanZero(tonumber(itemLinkOrID));

    if (concernsID) then
        itemID = tonumber(itemLinkOrID or 0) or 0
    else
        itemID = GL:getItemIDFromLink(itemLinkOrID);
    end

    if (itemID <= 0) then
        return;
    end

    if (self.ItemHistory[itemID]) then
        return self.ItemHistory[itemID];
    end

    local timesSold = 0;
    local totalSaleValue = 0;
    local lastSoldTimestamp = 0;
    local lastSoldPrice = 0;
    for _, Instance in pairs(DB.GDKP.Ledger or {}) do
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
        averageSaleValue = math.floor(totalSaleValue / timesSold);
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
    GL:debug("Session:tooltipLines");

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

    local PerItemSettings = Settings:get("GDKP.SettingsPerItem", {})[itemID] or {};
    PerItemSettings.minimumBid = PerItemSettings.minimumBid or Settings:get("GDKP.minimumBid");
    PerItemSettings.minimumIncrement = PerItemSettings.minimumIncrement or Settings:get("GDKP.minimumIncrement");

    local Lines = {
        string.format("\n|c00967FD2GDKP Data (sold %sx)|r", Details.timesSold),
        string.format("Last sold for: %sg", Details.lastSoldPrice),
        string.format("Average price: %sg ", Details.averageSaleValue),
        string.format("Minimum bid: %sg", PerItemSettings.minimumBid),
        string.format("Increment: %sg", PerItemSettings.minimumIncrement),
    };

    return Lines;
end

---@return table|boolean
function Session:getActive()
    GL:debug("Session:getActiveSession");

    local activeSessionIdentifier = DB:get("GDKP.activeSession", false);

    if (not activeSessionIdentifier) then
        return false;
    end

    return DB:get("GDKP.Ledger." .. activeSessionIdentifier, false);
end

---@param SessionObj table
---@return boolean
function Session:store(SessionObj)
    GL:debug("Session:store");

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
    GL:debug("Session:setActive");

    local Instance = self:byID(sessionID);
    if (not Instance
        or Instance.deletedAt
        or DB.GDKP.activeSession == sessionID
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
    GL:debug("Session:ownedByUser");

    for _, Instance in pairs (DB.GDKP.Ledger or {}) do
        if (GL:tableGet(Instance or {}, "CreatedBy.uuid") == GL.User.id) then
            return true;
        end
    end

    return false;
end

---@return boolean
function Session:exists(sessionIdentifier)
    GL:debug("Session:exists");

    return DB.GDKP.Ledger[sessionIdentifier] and not GL:empty(DB.GDKP.Ledger[sessionIdentifier].ID);
end

---@param title string
---@param managementCut number
---@return table|boolean
function Session:create(title, managementCut)
    GL:debug("Session:createSession");

    if (type(title) ~= "string" or GL:empty(title)) then
        return false;
    end

    managementCut = strtrim(managementCut);
    if (not GL:empty(managementCut)
        and tonumber(managementCut)
        and not GL:higherThanZero(tonumber(managementCut))
    ) then
        return false;
    end

    local Instance = {
        title = GL:capitalize(string.sub(title, 0, 30)),
        createdAt = GetServerTime(),
        managementCut = managementCut,
        Auctions = {},
        CreatedBy = {
            class = GL.User.class,
            name = GL.User.name,
            guild = GL.User.Guild.name,
            uuid = GL.User.id,
        },
        Pot = {
            Mutators = Settings:get("GDKP.Mutators", {}),
        },
        Raiders = {},
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
---@return boolean|table
function Session:edit(sessionID, title, managementCut)
    GL:debug("Session:createSession");

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

    Instance.title = GL:capitalize(string.sub(title, 0, 30));
    DB:set("GDKP.Ledger." .. Instance.ID, Instance);
    Events:fire("GL.GDKP_SESSION_CHANGED", Instance, self:byID(sessionID));

    return Instance;
end

---@param sessionID string
---@return boolean
function Session:lock(sessionID)
    GL:debug("Session:lock");

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
    GL:debug("Session:lock");

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
    GL:debug("Session:toggleLock");

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
    GL:debug("Session:delete");

    local Instance = self:byID(sessionID);

    if (not Instance) then
        return false;
    end

    -- This session is the currently active one, clear it
    if (DB.GDKP.activeSession == sessionID) then
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
    GL:debug("Session:restore");

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
    GL:debug("Session:clearActive");

    if (not DB.GDKP.activeSession) then
        return false;
    end

    local activeSession = DB.GDKP.activeSession;
    DB.GDKP.activeSession = nil;

    Events:fire("GL.GDKP_ACTIVE_SESSION_CLEARED", activeSession);
    Events:fire("GL.GDKP_ACTIVE_SESSION_CHANGED");

    return true;
end

---@return boolean
function Session:userIsAllowedToBroadcast()
    GL:debug("Session:userIsAllowedToBroadcast");

    return GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist);
end

GL:debug("GDKP.lua");