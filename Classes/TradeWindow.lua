---@type GL
local _, GL = ...;

---@class TradeWindow
GL.TradeWindow = {
    _initialized = false,
    numberOfTradeSlots = 6,

    AddItemsTimer = {},
    ItemsToAdd = {},
    State = {
        partner = "",
        MyItems = {},
        myGold = 0,
        TheirItems = {},
        theirGold = 0,
        itemLink = nil,
        itemID = nil,
    }
};

local TradeWindow = GL.TradeWindow; ---@type TradeWindow

--- Register all events needed to keep track of the trade window state
---
---@return void
function TradeWindow:_init()
    GL:debug("TradeWindow:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    GL.Events:register({
        {"TradeWindowItemLockedListener", "ITEM_LOCKED"},
        {"TradeWindowTradeAcceptUpdateListener", "TRADE_ACCEPT_UPDATE"},
        {"TradeWindowTradeMoneyChangedListener", "TRADE_MONEY_CHANGED"},
        {"TradeWindowTradePlayerItemChangedListener", "TRADE_PLAYER_ITEM_CHANGED"},
        {"TradeWindowTradeShowListener", "TRADE_SHOW"},
        {"TradeWindowTradeTargetItemChangedListener", "TRADE_TARGET_ITEM_CHANGED"},
        {"TradeWindowUIInfoMessageListener", "UI_INFO_MESSAGE"},
        {"TradeWindowUIInfoMessageListener", "UI_ERROR_MESSAGE"},
    }, function (event, _, message)
        self:handleEvents(event, message);
    end);

    self._initialized = true;
end

--- Attempt to open a trade window with a given player name
---
---@param playerName string
---@param callback function
---@param allwaysExecuteCallback boolean
---@return void
function TradeWindow:open(playerName, callback, allwaysExecuteCallback)
    GL:debug("TradeWindow:open");

    playerName = GL:normalizedName(playerName);
    allwaysExecuteCallback = GL:toboolean(allwaysExecuteCallback);

    -- Make sure the callback runs when a trade window is opened
    -- with our desired target or allwaysExecuteCallback is true
    if (type(callback) == "function") then
        -- Even with jitter/lag opening a trade window should never take longer than a second
        -- If it does take longer however then we delete the eventlistener manually
        local timerID = GL.Ace:ScheduleTimer(function ()
            GL.Events:unregister("TradeWindowTradeShowCallbackListener");

            if (allwaysExecuteCallback) then
                callback();
            end
        end, 1);

        GL.Events:register("TradeWindowTradeShowCallbackListener", "TRADE_SHOW", function ()
            -- Remove our trade window show eventlistener, we no longer need it
            GL.Events:unregister("TradeWindowTradeShowCallbackListener");

            -- We can cancel our timer now
            GL.Ace:CancelTimer(timerID);

            -- Perform the callback
            if (allwaysExecuteCallback
                or (
                    TradeFrame:IsShown()
                    and self.Sate.partner == playerName
                )
            ) then
                callback();
            end
        end);
    end

    -- Attempt to open a trade window with the given player
    InitiateTrade(playerName);
end

--- Handle trade-related events
---
---@param event string
---@param message string
---@return void
function TradeWindow:handleEvents(event, message)
    GL:debug("TradeWindow:handleEvents");

    -- Trade started
    if (event == "TRADE_SHOW") then
        self.ItemsToAdd = {};

        -- Make sure to cancel any lingering timers
        GL.Ace:CancelTimer(self.AddItemsTimer);

        -- Periodically add items to the trade window
        -- We don't do this instantly because that can bug out the UI
        self.AddItemsTimer = GL.Ace:ScheduleRepeatingTimer(function ()
            self:processItemsToAdd();
        end, .3);
    end

    -- Trade cancelled
    if (event == "TRADE_CLOSED") then
        self.ItemsToAdd = {};

        -- Make sure to cancel any lingering timers
        GL.Ace:CancelTimer(self.AddItemsTimer);
    end

    -- Something changed regarding the trade, update our trade state
    if (GL:inTable({
        "TRADE_PLAYER_ITEM_CHANGED",
        "TRADE_TARGET_ITEM_CHANGED",
        "TRADE_MONEY_CHANGED",
        "TRADE_ACCEPT_UPDATE",
        "TRADE_SHOW",
        "ITEM_LOCKED",
    }, event)) then
        self:updateState();

        -- Fire a custom GL event. This ensures that the listeners have access to the data set in self.State
        GL.Events:fire("GL." .. event);

        return;
    end

    -- Trade was successfull
    if (event == "UI_INFO_MESSAGE"
        and message == ERR_TRADE_COMPLETE
    ) then
        GL.Events:fire("GL.TRADE_COMPLETED", self.State);
    end

    self:resetState();
end

--- Keep track of the trade window's state (e.g. which items, how much money etc)
---
---@return void
function TradeWindow:updateState()
    GL:debug("TradeWindow:updateState");

    -- Fetch the player name of whomever we're trading with
    self.State.partner = _G.TradeFrameRecipientNameText:GetText();

    -- If the frame doesn't hold the playername then try fetching it using less conventional methods
    if (GL:empty(self.State.partner)) then
        self.State.partner = UnitName("NPC");
    end

    self.State.myGold = tonumber(GetPlayerTradeMoney());
    self.State.theirGold = tonumber(GetTargetTradeMoney());

    for tradeSlot = 1, self.numberOfTradeSlots do
        -- Fetch and store the items on our side of the trade window
        local name, texture, quantity, isUsable, enchantment  = GetTradePlayerItemInfo(tradeSlot);
        local itemLink = GetTradePlayerItemLink(tradeSlot);
        local itemID = GL:getItemIdFromLink(itemLink) or nil;

        self.State.MyItems[tradeSlot] = {
            name = name,
            texture = texture,
            quantity = quantity,
            isUsable = isUsable,
            enchantment = enchantment,
            itemLink = itemLink,
            itemID = itemID,
        };

        -- Fetch and store the items on their side of the trade window
        name, texture, quantity, isUsable, enchantment  = GetTradeTargetItemInfo(tradeSlot);
        itemLink = GetTradeTargetItemLink(tradeSlot);
        itemID = GL:getItemIdFromLink(itemLink) or nil;

        self.State.TheirItems[tradeSlot] = {
            name = name,
            texture = texture,
            quantity = quantity,
            isUsable = isUsable,
            enchantment = enchantment,
            itemLink = itemLink,
            itemID = itemID,
        };
    end
end

--- Reset the trade state object
---
---@return void
function TradeWindow:resetState()
    GL:debug("TradeWindow:resetState");

    self.State = {
        MyItems = {},
        myGold = 0,
        TheirItems = {},
        theirGold = 0,
        partner = "",
        itemLink = nil,
        itemID = nil,
    };
end

--- Attempt to add a given itemID to the trade window
---
---@param itemID number
---@return void
function TradeWindow:addItem(itemID)
    GL:debug("TradeWindow:addItem");

    tinsert(self.ItemsToAdd, itemID);
end

--- Process the ItemsToAdd table
---
---@return void
function TradeWindow:processItemsToAdd()
    GL:debug("TradeWindow:processItemsToAdd");

    -- Make sure we don't use items if the trade window is not opened
    -- The last thing we want to do is equip an item or use a consumable by mistake!
    if (not TradeFrame:IsShown()) then
        return;
    end

    -- There are no items left to add
    if (not self.ItemsToAdd[1]) then
        return;
    end

    local itemID = self.ItemsToAdd[1];
    table.remove(self.ItemsToAdd, 1);

    -- Try to find the item in our bag, make sure to skip soulbound items
    local skipSoulbound = true;
    local itemPositionInBag = GL:findBagIdAndSlotForItem(itemID, skipSoulbound);

    -- The item was not found or the trade window is not open anymore
    if (GL:empty(itemPositionInBag)
        or not TradeFrame:IsShown()
    ) then
        return;
    end

    -- Everything went well, put the item in the trade window!
    UseContainerItem(unpack(itemPositionInBag));
end

GL:debug("TradeWindow.lua");