---@type GL
local _, GL = ...;

---@class TradeWindow
GL.TradeWindow = {
    _initialized = false,
    numberOfTradeSlots = 6,
    AnnouncementCheckBox = nil,

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
        {"TradeWindowTradeCloseListener", "TRADE_CLOSED"},
        {"TradeWindowUIInfoMessageListener", "UI_INFO_MESSAGE"},
        {"TradeWindowUIInfoMessageListener", "UI_ERROR_MESSAGE"},
    }, function (event, _, message)
        self:handleEvents(event, message);
    end);

    GL.Events:register("TradeWindowTradeCompleted", "GL.TRADE_COMPLETED", function (_, Details)
        self:announceTradeDetails(Details);
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

    -- We're already trading with someone
    if (TradeFrame:IsShown()) then
        if (type(callback) == "function"
            and (allwaysExecuteCallback or self.Sate.partner == playerName)
        ) then
            callback();
        end

        return;
    end

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

    -- Incoming UI_INFO_MESSAGE
    if (event == "UI_INFO_MESSAGE") then
        -- Trade was successful
        if (message == ERR_TRADE_COMPLETE) then
            GL.Events:fire("GL.TRADE_COMPLETED", self.State);
        else
            return;
        end
    end

    -- Trade started
    if (event == "TRADE_SHOW") then
        self.ItemsToAdd = {};

        -- Trade window shown, show/update the announcement checkbox
        self:updateAnnouncementCheckBox();

        -- Make sure to cancel any lingering timers
        GL.Ace:CancelTimer(self.AddItemsTimer);

        -- Periodically add items to the trade window
        -- We don't do this instantly because that can bug out the UI
        self.AddItemsTimer = GL.Ace:ScheduleRepeatingTimer(function ()
            self:processItemsToAdd();
        end, .5);
    end

    -- Trade cancelled
    if (event == "TRADE_CLOSED") then
        self.ItemsToAdd = {};

        -- Make sure to cancel any lingering timers
        GL.Ace:CancelTimer(self.AddItemsTimer);

        -- We don't want resetState to trigger since TRADE_CLOSED is fired before TRADE_COMPLETED
        return;
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
        -- We only need to update the state if the trade frame is actually shown
        if (TradeFrame:IsShown()) then
            self:updateState();
        end

        -- Fire a custom GL event. This ensures that the listeners have access to the data set in self.State
        GL.Events:fire("GL." .. event);

        return;
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
        GL.Ace:CancelTimer(self.AddItemsTimer);
        self.AddItemsTimer = nil;

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

--- Check whether we should announce trade details
---
---@return boolean
function TradeWindow:shouldAnnounce()
    -- When does the user want to announce trade details?
    local mode = GL.Settings:get("TradeAnnouncements.mode", "WHEN_MASTERLOOTER");

    if (mode == "ALWAYS") then
        return true;
    end

    if (mode == "WHEN_IN_GROUP" and GL.User.isInGroup) then
        return true;
    end

    if (mode == "WHEN_ASSIST" and GL.User.hasAssist) then
        return true;
    end

    if (mode == "WHEN_MASTERLOOTER" and GL.User.isMasterLooter) then
        return true;
    end

    return false;
end

--- Draw/Update the checkbox and settings cogwheel
---
---@return void
function TradeWindow:updateAnnouncementCheckBox()
    GL:debug("TradeWindow:updateAnnouncementCheckBox");

    -- Only create the checbox / cogwheel once
    if (not GL:empty(self.AnnouncementCheckBox)) then
        self.AnnouncementCheckBox:SetChecked(self:shouldAnnounce());
        return;
    end

    -- Create a container/parent frame
    local Window = GL.AceGUI:Create("SimpleGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(150);
    Window:SetHeight(15);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window.frame:SetParent(TradeFrame);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint("BOTTOMLEFT", TradeFrame, "BOTTOMLEFT", 8, 22);

    local CheckBox = CreateFrame("CheckButton", "GargulAnnounceTradeDetails", Window.frame, "OptionsCheckButtonTemplate");
    GargulAnnounceTradeDetailsText:SetText("Announce Trade");
    CheckBox:SetChecked(self:shouldAnnounce());
    CheckBox:SetPoint("TOPLEFT", Window.frame, "TOPLEFT");
    CheckBox:SetWidth(20);
    CheckBox:SetHeight(20);
    CheckBox.tooltipText = "Announce trade details to group or in /say when not in a group";
    self.AnnouncementCheckBox = CheckBox;

    -- Create the cogwheel that links to the announcement settings
    local Cogwheel = CreateFrame("Button", "TradeWindowAnnouncementBox", Window.frame, Frame);
    Cogwheel:Show();
    Cogwheel:SetClipsChildren(true);
    Cogwheel:SetSize(13, 13);
    Cogwheel:SetPoint("TOPRIGHT", Window.frame, "TOPRIGHT", 0, -4);

    local CogwheelTexture = Cogwheel:CreateTexture();
    CogwheelTexture:SetPoint("BOTTOMRIGHT", 0, 0);
    CogwheelTexture:SetSize(16,16);
    CogwheelTexture:SetTexture("interface\\cursor\\interact");
    CogwheelTexture:SetTexture("interface\\cursor\\unableinteract");
    Cogwheel.texture = CogwheelTexture;

    Cogwheel:SetScript('OnEnter', function()
        CogwheelTexture:SetTexture("interface\\cursor\\interact");
    end);
    Cogwheel:SetScript('OnLeave', function()
        CogwheelTexture:SetTexture("interface\\cursor\\unableinteract");
    end);

    Cogwheel:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            GL.Settings:draw("TradeAnnouncements");
        end
    end);
end

--- Announce the traded loot or gold in chat
---
---@param Details table
---@return void
function TradeWindow:announceTradeDetails(Details)
    GL:debug("TradeWindow:announceTradeDetails");

    -- Check the value of the "Announce trade" checkbox in the trade frame
    if (self.AnnouncementCheckBox
        and not self.AnnouncementCheckBox:GetChecked()
    ) then
        return;
    end

    -- Found out on which channel we should post the trade details
    local channel = "GROUP";
    if (not GL.User.isInGroup) then
        channel = "SAY";
    end

    local tradeString = "I gave ";
    local TradeEntries = {};
    if (Details.myGold > 0 and GL.Settings:get("TradeAnnouncements.goldGiven", true)) then
        tinsert(TradeEntries, GL:copperToMoney(Details.myGold));
    end

    if (GL.Settings:get("TradeAnnouncements.itemsGiven", true)) then
        for _, Entry in pairs(Details.MyItems or {}) do
            local itemID = tonumber(Entry.itemID);

            if (itemID) then
                if (Entry.quantity > 1) then
                    tinsert(TradeEntries, string.format("%sx%s", Entry.itemLink, Entry.quantity));
                else
                    tinsert(TradeEntries, Entry.itemLink);
                end
            end
        end
    end

    if (not GL:empty(TradeEntries)) then
        local EntriesProcessed = 0;
        for _, entry in pairs(TradeEntries) do
            if (EntriesProcessed == 0) then
                tradeString = tradeString .. entry;
            else
                tradeString = tradeString .. " and " .. entry;
            end

            EntriesProcessed = EntriesProcessed + 1;
            if (EntriesProcessed % 5 == 0) then
                -- This is not the last entry (item/gold) that we need to display
                if (TradeEntries[EntriesProcessed + 1] ~= nil) then
                    GL:sendChatMessage(tradeString, channel);

                -- This is the last entry, include the "to" part
                else
                    GL:sendChatMessage(tradeString .. " to " .. Details.partner, channel);
                end
                tradeString = "";
            end
        end
    else
        tradeString = "";
    end

    if (not GL:empty(tradeString)) then
        GL:sendChatMessage(tradeString .. " to " .. Details.partner, channel);
        tradeString = "";
    end

    tradeString = "I received ";
    TradeEntries = {};
    if (Details.theirGold > 0 and GL.Settings:get("TradeAnnouncements.goldReceived", true)) then
        tinsert(TradeEntries, GL:copperToMoney(Details.theirGold));
    end

    if (GL.Settings:get("TradeAnnouncements.itemsReceived", true)) then
        for _, Entry in pairs(Details.TheirItems or {}) do
            local itemID = tonumber(Entry.itemID);

            if (itemID) then
                if (Entry.quantity > 1) then
                    tinsert(TradeEntries, string.format("%sx%s", Entry.itemLink, Entry.quantity));
                else
                    tinsert(TradeEntries, Entry.itemLink);
                end
            end
        end
    end

    if (not GL:empty(TradeEntries)) then
        local EntriesProcessed = 0;
        for _, entry in pairs(TradeEntries) do
            if (EntriesProcessed == 0) then
                tradeString = tradeString .. entry;
            else
                tradeString = tradeString .. " and " .. entry;
            end

            EntriesProcessed = EntriesProcessed + 1;
            if (EntriesProcessed % 5 == 0) then
                -- This is not the last entry (item/gold) that we need to display
                if (TradeEntries[EntriesProcessed + 1] ~= nil) then
                    GL:sendChatMessage(tradeString, channel);

                    -- This is the last entry, include the "to" part
                else
                    GL:sendChatMessage(tradeString .. " to " .. Details.partner, channel);
                end
                tradeString = "";
            end
        end
    else
        tradeString = "";
    end

    if (not GL:empty(tradeString)) then
        GL:sendChatMessage(tradeString .. " from " .. Details.partner, channel);
        tradeString = "";
    end
end

GL:debug("TradeWindow.lua");