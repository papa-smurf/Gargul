local _, GL = ...;

---@type Events
local Events = GL.Events;

local Constants = GL.Data.Constants;

---@class TradeTime
GL.TradeTime = {
    _initialized = false,

    State = {},
    TestItems = {},
};

---@type TradeTime
local TradeTime = GL.TradeTime;

---@return void
function TradeTime:_init()
    if (self._initialized
        or not C_Item
        or not C_Item.GetItemGUID -- This adaptation only works on newer game versions
    ) then
        return;
    end

    self._initialized = true;

    Events:register({
        { "TradeTimeBagUpdateDelayedListener", "BAG_UPDATE_DELAYED" },
        { "TradeTimePlayerEnteringWorldListener", "PLAYER_ENTERING_WORLD" },
        { "TradeTimeZoneChangedListener", "ZONE_CHANGED" },
        { "TradeTimePlayerAliveListener", "PLAYER_ALIVE" },
        { "TradeTimePlayerUnghostListener", "PLAYER_UNGHOST" },
        { "TradeTimeBagMasterLooterLostListener", "GL.USER_LOST_MASTER_LOOTER" },
        { "TradeTimeBagMasterLooterObtainedListener", "GL.USER_OBTAINED_MASTER_LOOTER" },
    }, function ()
        TradeTime:process();
    end);

    -- Initialize the TradeTime UI
    GL.Interface.TradeTime.Overview:_init();
end

---@return void
function TradeTime:process()
    -- We don't do this during combat just in case it causes a hiccup
    if (UnitAffectingCombat("player")) then
        return;
    end

    local Details = {};
    local somethingChanged = false;
    GL:forEachItemInBags(function (Location, bag, slot)
        -- Item is not soulbound or does not have any trade time remaining
        local timeRemaining = GL:inventoryItemTradeTimeRemaining(bag, slot);
        if (timeRemaining < 1 or timeRemaining == Constants.itemIsNotBound) then
            return;
        end

        local itemGUID = C_Item.GetItemGUID(Location);
        Details[itemGUID] = {
            itemIcon = C_Item.GetItemIcon(Location),
            itemID = C_Item.GetItemID(Location),
            itemGUID = itemGUID,
            itemLink = C_Item.GetItemLink(Location),
            secondsRemaining = timeRemaining,
            measuredAt = GetServerTime(),
        };

        -- Seems like we received a new item with a trade time remaining
        if (not self.State.itemGUID) then
            somethingChanged = true;
        end
    end);

    -- We didn't gain any new items, lets see if we lost some
    if (not somethingChanged) then
        for itemGUID in pairs(self.State) do
            if (not Details[itemGUID]) then
                somethingChanged = true;
                break;
            end
        end
    end

    -- Nothing changed, nothing to report
    if (not somethingChanged) then
        return;
    end

    self.State = Details;
    Events:fire("GL.TRADE_TIME_DURATIONS_CHANGED", Details);
end

---@return table
function TradeTime:getState()
    return self.State;
end
