local L = Gargul_L;

---@type GL
local _, GL = ...;

---@class TradeWindow
GL.TradeWindow = {
    _initialized = false,
    manuallyChangedAnnounceCheckbox = false,
    AnnouncementCheckBox = nil,

    ItemsToAdd = {},
    ItemsAdded = {},
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
function TradeWindow:_init()
    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    GL.Events:register({
        "ITEM_LOCKED",
        "ITEM_UNLOCKED",
        "TRADE_ACCEPT_UPDATE",
        "TRADE_MONEY_CHANGED",
        "TRADE_PLAYER_ITEM_CHANGED",
        "TRADE_TARGET_ITEM_CHANGED",
        "TRADE_SHOW",
        "TRADE_CLOSED",
        "TRADE_REQUEST_CANCEL",
        "UI_INFO_MESSAGE",
    }, function (event, ...)
        self:handleEvents(event, ...);
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
function TradeWindow:open(playerName, callback, allwaysExecuteCallback)
    playerName = GL:nameFormat(playerName);
    allwaysExecuteCallback = GL:toboolean(allwaysExecuteCallback);

    -- We're already trading with someone
    if (TradeFrame:IsShown()) then
        local playerNameMatches = GL:iEquals(self.State.partner, playerName) or GL:iEquals(GL:stripRealm(self.State.partner), playerName);

        if (type(callback) == "function"
            and (allwaysExecuteCallback or playerNameMatches)
        ) then
            callback(playerNameMatches);
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
                callback(false);
            end
        end, 1);

        GL.Events:register("TradeWindowTradeShowCallbackListener", "GL.TRADE_SHOW", function ()
            -- Remove our trade window show event listener, we no longer need it
            GL.Events:unregister("TradeWindowTradeShowCallbackListener");

            -- We can cancel our timer now
            GL.Ace:CancelTimer(timerID);

            -- Perform the callback
            local playerNameMatches = GL:iEquals(self.State.partner, playerName) or GL:iEquals(GL:stripRealm(self.State.partner), playerName);

            if (allwaysExecuteCallback
                or (TradeFrame:IsShown()
                    and playerNameMatches
                )
            ) then
                callback(playerNameMatches);
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
function TradeWindow:handleEvents(event, ...)
    -- Incoming UI_INFO_MESSAGE
    if (event == "UI_INFO_MESSAGE") then
        local _, message = ...;

        -- Trade was successful
        if (message == ERR_TRADE_COMPLETE) then
            -- Check the value of the "Announce trade" checkbox in the trade frame
            self.State.announce = self.AnnouncementCheckBox and self.AnnouncementCheckBox:GetChecked();

            GL.Events:fire("GL.TRADE_COMPLETED", self.State);
        else
            return;
        end
    end

    -- Trade started
    if (event == "TRADE_SHOW") then
        self.ItemsToAdd, self.ItemsAdded = {}, {};
        GL.Ace:CancelTimer(self.SetCopperTimer);

        -- Trade window shown, show/update the announcement checkbox
        self:updateAnnouncementCheckBox();

        -- Make sure to cancel any lingering timers
        GL:cancelTimer("TradeWindowAddItemsInterval");

        -- Periodically add items to the trade window
        -- We don't do this instantly because that can bug out the UI
        GL:interval(0, "TradeWindowAddItemsInterval", function ()
            self:processItemsToAdd();
        end);
    end

    -- Trade closed
    if (event == "TRADE_CLOSED") then
        self.ItemsToAdd, self.ItemsAdded = {}, {};
        GL.Ace:CancelTimer(self.SetCopperTimer);

        -- Make sure to cancel any lingering timers
        GL:cancelTimer("TradeWindowAddItemsInterval");

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
        GL.Events:fire("GL." .. event, self.State);

        return;
    end

    -- The game can automatically remove items at times when they
    -- are added to the trade window too rapidly. This counters that
    if (event == "ITEM_UNLOCKED") then
        local bag, slot = ...;
        local itemGUID = GL:getItemGUIDByBagAndSlot(bag, slot);

        if (itemGUID
            and type(self.ItemsAdded[itemGUID]) == "table"
        ) then
            if (GetTime() - self.ItemsAdded[itemGUID].timestamp <= .5) then
                tinsert(self.ItemsToAdd, self.ItemsAdded[itemGUID].itemLink or self.ItemsAdded[itemGUID].itemID);
            end

            self.ItemsAdded[itemGUID] = nil;
        end

        return;
    end

    self:resetState();
end

--- Keep track of the trade window's state (e.g. which items, how much money etc)
function TradeWindow:updateState()
    -- NPC is currently the player you're trading
    local partnerName, partnerRealm = UnitName("NPC", true);
    self.State.partner = GL:nameFormat{ name = partnerName, realm = partnerRealm, forceRealm = true };

    -- Fetch the player name of whomever we're trading with
    partnerName = strtrim(_G.TradeFrameRecipientNameText:GetText());

    -- Retail can add (*) or similar to the trade window's partner name ie "Name (*)". Hence the explode+replace
    partnerName = GL:explode(partnerName, " ")[1];
    local sanitizeName = function (name)
        name = name:gsub("%-", "");
        name = name:gsub("%*", "");
        name = name:gsub("%(", "");
        return name:gsub("%)", "");
    end;
    partnerName = partnerName and sanitizeName(partnerName);

    -- If the frame doesn't hold the player name that we set earlier then override it
    -- This should never happen and is nothing but a failsafe
    if (not GL:strStartsWith(self.State.partner, partnerName)) then
        self.State.partner = partnerName;
    end

    self.State.myGold = tonumber(GetPlayerTradeMoney());
    self.State.theirGold = tonumber(GetTargetTradeMoney());

    for tradeSlot = 1, MAX_TRADABLE_ITEMS do
        -- Fetch and store the items on our side of the trade window
        local name, texture, quantity, quality, isUsable, _ = GetTradePlayerItemInfo(tradeSlot);
        local itemLink = GetTradePlayerItemLink(tradeSlot);
        local itemID = GL:getItemIDFromLink(itemLink) or nil;

        self.State.MyItems[tradeSlot] = {
            name = name,
            texture = texture,
            quantity = quantity,
            quality = quality,
            isUsable = isUsable,
            enchantment = nil,
            itemLink = itemLink,
            itemID = itemID,
        };

        -- Fetch and store the items on their side of the trade window
        name, texture, quantity, quality, isUsable, _ = GetTradeTargetItemInfo(tradeSlot);
        itemLink = GetTradeTargetItemLink(tradeSlot);
        itemID = GL:getItemIDFromLink(itemLink) or nil;

        self.State.TheirItems[tradeSlot] = {
            name = name,
            texture = texture,
            quantity = quantity,
            quality = quality,
            isUsable = isUsable,
            enchantment = nil,
            itemLink = itemLink,
            itemID = itemID,
        };
    end

    do
        -- The enchantment return value is only available for slot TRADE_ENCHANT_SLOT (the "locked slot"), not the regular trade slots above
        local name, texture, quantity, quality, isUsable, enchantment = GetTradeTargetItemInfo(TRADE_ENCHANT_SLOT);
        local itemLink = GetTradeTargetItemLink(TRADE_ENCHANT_SLOT);
        local itemID = GL:getItemIDFromLink(itemLink) or nil;

        self.State.EnchantedByMe = {
            name = name,
            texture = texture,
            quantity = quantity,
            quality = quality,
            isUsable = isUsable,
            enchantment = enchantment,
            itemLink = itemLink,
            itemID = itemID,
        };

        --- NOTE HOW THE RETURN VALUE ORDER IS DIFFERENT HERE, THANK YOU BLIZZARD!
        --- Note 2: isUsable is actually canLoseTransmog, but since we don't strictly need either it doesn't matter
        name, texture, quantity, quality, enchantment, isUsable  = GetTradePlayerItemInfo(TRADE_ENCHANT_SLOT);
        itemLink = GetTradePlayerItemLink(TRADE_ENCHANT_SLOT);
        itemID = GL:getItemIDFromLink(itemLink) or nil;

        self.State.EnchantedByThem = {
            name = name,
            texture = texture,
            quantity = quantity,
            quality = quality,
            isUsable = isUsable,
            enchantment = enchantment,
            itemLink = itemLink,
            itemID = itemID,
        };
    end

    self:updateAnnouncementCheckBox();
end

--- Reset the trade state object
function TradeWindow:resetState()
    self.manuallyChangedAnnounceCheckbox = false;

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

--- Attempt to add a given itemID or itemLink to the trade window
---
---@param itemLinkOrID number|string
function TradeWindow:addItem(itemLinkOrID)
    tinsert(self.ItemsToAdd, itemLinkOrID);
end

--- Attempt to set a copper amount in the trade window
--- Since we use a timer here we require a target so that we can double-check
--- whether we're still trading the right person right before adding the copper
---
---@param amount number
---@param target string
function TradeWindow:setCopper(amount, target, callback)
    GL.Ace:CancelTimer(self.SetCopperTimer);
    self.SetCopperTimer = GL.Ace:ScheduleTimer(function ()
        -- Looks like the target changed somewhere along the way
        if (not GL:iEquals(GL:tableGet(self.State or {}, "partner"), target)) then
            return;
        end

        _G.MoneyInputFrame_SetCopper(_G.TradePlayerInputMoneyFrame, amount);

        -- Let the application know whether setting the desired amount of copper succeeded
        if (type(callback) == "function") then
            callback(_G.MoneyInputFrame_GetCopper(_G.TradePlayerInputMoneyFrame) == amount);
        end
    end, .5);
end

--- Process the ItemsToAdd table
function TradeWindow:processItemsToAdd()
    -- Make sure we don't use items if the trade window is not opened
    -- The last thing we want to do is equip an item or use a consumable by mistake!
    if (not TradeFrame:IsShown()) then
        GL:cancelTimer("TradeWindowAddItemsInterval");

        return;
    end

    -- There are no items left to add
    if (not self.ItemsToAdd[1]) then
        return;
    end

    local itemToAdd = self.ItemsToAdd[1];
    local addItemByLink = GL:getItemIDFromLink(itemToAdd);
    local itemID = addItemByLink or itemToAdd;
    local itemLink = addItemByLink and itemToAdd or nil;
    table.remove(self.ItemsToAdd, 1);

    -- Try to find the item in our bag, make sure to skip soulbound items
    local skipSoulbound = true;
    local itemPositionInBag = GL:findBagIdAndSlotForItem(itemLink or itemID, skipSoulbound);

    -- The item was not found or the trade window is not open anymore
    if (GL:empty(itemPositionInBag)
        or not TradeFrame:IsShown()
    ) then
        return;
    end

    local bag, slot = unpack(itemPositionInBag);
    local itemGUID = GL:getItemGUIDByBagAndSlot(bag, slot);

    if (itemGUID) then
        self.ItemsAdded[itemGUID] = {
            itemID = itemID,
            itemLink = itemLink,
            timestamp = GetTime(),
        };
    end

    -- Everything went well, put the item in the trade window!
    GL:useContainerItem(bag, slot);
end

--- Check whether we should announce trade details
---
---@return boolean
function TradeWindow:shouldAnnounce()
    -- When does the user want to announce trade details?
    local mode = GL.Settings:get("TradeAnnouncements.mode", "WHEN_MASTERLOOTER");

    -- The user manually set the announcement state for the current trade, no need to override it
    if (self.manuallyChangedAnnounceCheckbox
        and GargulAnnounceTradeDetailsText
    ) then
        return GargulAnnounceTradeDetailsText:GetChecked();
    end

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

    if (GL.Settings:get("TradeAnnouncements.alwaysAnnounceEnchantments", true)) then
        return not GL:empty(GL:tableGet(self.State or {}, "EnchantedByMe.enchantment"))
            or not GL:empty(GL:tableGet(self.State or {}, "EnchantedByThem.enchantment"));
    end

    return false;
end

--- Draw/Update the checkbox and settings cogwheel
function TradeWindow:updateAnnouncementCheckBox()
    -- Only create the checbox / cogwheel once
    if (not GL:empty(self.AnnouncementCheckBox)) then
        self.AnnouncementCheckBox:SetChecked(self:shouldAnnounce());
        return;
    end

    local CheckBox = CreateFrame("CheckButton", "GargulAnnounceTradeDetails", TradeFrame, "UICheckButtonTemplate");
    GargulAnnounceTradeDetailsText:SetText(L.TRADE_ANNOUNCE);
    CheckBox:SetChecked(self:shouldAnnounce());
    CheckBox:SetPoint("BOTTOMLEFT", "TradeFrame", "BOTTOMLEFT", 8, 6);
    CheckBox:SetWidth(20);
    CheckBox:SetHeight(20);
    CheckBox:SetScript("OnClick", function ()
        self.manuallyChangedAnnounceCheckbox = true;
    end);
    CheckBox.tooltipText = L.TRADE_ANNOUNCE_INFO;
    self.AnnouncementCheckBox = CheckBox;

    -- Create the cogwheel that links to the announcement settings
    local Cogwheel = CreateFrame("Button", "TradeWindowAnnouncementBox", TradeFrame, Frame);
    Cogwheel:Show();
    Cogwheel:SetClipsChildren(true);
    Cogwheel:SetSize(13, 13);
    Cogwheel:SetPoint("TOPRIGHT", CheckBox, "TOPRIGHT", 138, -5);

    local CogwheelTexture = Cogwheel:CreateTexture();
    CogwheelTexture:SetPoint("BOTTOMRIGHT", 0, 0);
    CogwheelTexture:SetSize(16,16);
    CogwheelTexture:SetTexture("interface/cursor/interact");
    CogwheelTexture:SetTexture("interface/cursor/unableinteract");
    Cogwheel.texture = CogwheelTexture;

    Cogwheel:SetScript('OnEnter', function()
        CogwheelTexture:SetTexture("interface/cursor/interact");
    end);
    Cogwheel:SetScript('OnLeave', function()
        CogwheelTexture:SetTexture("interface/cursor/unableinteract");
    end);

    Cogwheel:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            GL.Settings:draw("TradeAnnouncements");
        end
    end);
end

--- Announce the traded loot or gold in chat
---
--- This method is huge, huge, I'm aware. I might have gone a bit overboard, but this at least keeps chat clean~ish
---
---@param Details table
function TradeWindow:announceTradeDetails(Details)
    -- Check if the user wants to announce this trade
    if (not Details.announce) then
        return;
    end

    -- Find out on which channel we should post the trade details
    local channel = "GROUP";
    local recipient;
    if (not GL.User.isInGroup) then
        channel = "WHISPER";
        recipient = Details.partner;
    end

    local ItemsTradedByMe = {};
    local iTradedItems = false;
    local iTradedGold = GL.Settings:get("TradeAnnouncements.goldGiven", true) and Details.myGold > 0;
    local iEnchantedSomething = false;
    local goldTradedByMe = GL:copperToMoney(Details.myGold or 0);

    local ItemsTradedByThem = {};
    local theyTradedGold = GL.Settings:get("TradeAnnouncements.goldReceived", true) and Details.theirGold > 0;
    local theyTradedItems = false;
    local theyEnchantedSomething = false;
    local goldTradedByThem = GL:copperToMoney(Details.theirGold or 0);

    -- Normalize the items we traded (combine stacks etc)
    if (GL.Settings:get("TradeAnnouncements.itemsGiven", true)) then
        for _, Entry in pairs(Details.MyItems or {}) do
            local itemID = tonumber(Entry.itemID);
            if (itemID
                and Entry.quality >= GL.Settings:get("TradeAnnouncements.minimumQualityOfAnnouncedLoot", 0)
            ) then
                iTradedItems = true;

                local quantity = Entry.quantity > 1 and Entry.quantity or 1;
                local itemIDString = tostring(Entry.itemID); -- Should already be a string, but need to make sure

                -- Check to see if we already have a quantity of the same item available (multiple stacks?)
                if (ItemsTradedByMe[itemIDString]) then
                    quantity = quantity + ItemsTradedByMe[itemIDString].quantity;
                end
                ItemsTradedByMe[itemIDString] = {
                    itemLink = Entry.itemLink,
                    quantity = quantity,
                };
            end
        end
    end

    -- Normalize the items we received (combine stacks etc)
    if (GL.Settings:get("TradeAnnouncements.itemsReceived", true)) then
        for _, Entry in pairs(Details.TheirItems or {}) do
            local itemID = tonumber(Entry.itemID);
            if (itemID
                and Entry.quality >= GL.Settings:get("TradeAnnouncements.minimumQualityOfAnnouncedLoot", 0)
            ) then
                theyTradedItems = true;

                local quantity = Entry.quantity > 1 and Entry.quantity or 1;
                local itemIDString = tostring(Entry.itemID); -- Should already be a string, but need to make sure

                -- Check to see if we already have a quantity of the same item available (multiple stacks?)
                if (ItemsTradedByThem[itemIDString]) then
                    quantity = quantity + ItemsTradedByThem[itemIDString].quantity;
                end
                ItemsTradedByThem[itemIDString] = {
                    itemLink = Entry.itemLink,
                    quantity = quantity,
                };
            end
        end
    end

    -- Include enchantment details
    local EnchantedByMe = Details.EnchantedByMe;
    if (GL.Settings:get("TradeAnnouncements.enchantmentGiven", true)
        and EnchantedByMe.enchantment
        and not GL:inTable(GL.Data.Constants.LockedItems, EnchantedByMe.itemID)
    ) then
        iEnchantedSomething = true;
    end

    local EnchantedByThem = Details.EnchantedByThem;
    if (GL.Settings:get("TradeAnnouncements.enchantmentReceived", true)
        and EnchantedByThem.enchantment
        and not GL:inTable(GL.Data.Constants.LockedItems, EnchantedByThem.itemID)
    ) then
        theyEnchantedSomething = true;
    end

    local iDidNothing = not iTradedItems and not iTradedGold and not iEnchantedSomething;
    local theyDidNothing = not theyTradedItems and not theyTradedGold and not theyEnchantedSomething;

    -- The goals:
    -- I gave 100G 10S 10C, item1, item2 and item3 to Player and also enchanted their item with enchantment
    -- Player enchanted my Ashjre'thul, Crossbow of Smiting with Stabilized Eternium Scope for 20G
    -- I enchanted Ashjre'thul, Crossbow of Smiting with Stabilized Eternium Scope for Player and received 20G
    (function()
        --[[
            THESE ARE ALL THE POSSIBLE SCENARIOS (e.g. we only traded gold, they only enchanted something etc)
        ]]

        -- We only gave gold (and optionally received an enchantment)
        if (iTradedGold and not iTradedItems and not iEnchantedSomething) then
            -- And got nothing in return
            if (theyDidNothing) then
                return GL:sendChatMessage((L.CHAT.TRADE_GAVE_GOLD):format(goldTradedByMe, Details.partner), channel, nil, recipient);
            end

            -- We gave them gold for an enchantment (trading gold for gold is not possible, the trade won't be accepted)
            if (theyEnchantedSomething and not theyTradedItems) then
                return GL:sendChatMessage((L.CHAT.TRADE_GOT_ENCHANTMENT_FOR_GOLD):format(
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment,
                    goldTradedByMe
                ), channel, nil, recipient);
            end

            -- I gave them gold for items and potentially an enchant on top
            GL:sendChatMessage((L.CHAT.TRADE_GAVE_GOLD):format(goldTradedByMe, Details.partner), channel, nil, recipient);
        end

        -- We only received gold (and optionally enchanted something)
        if (theyTradedGold and not theyTradedItems and not theyEnchantedSomething) then
            -- And gave nothing in return
            if (iDidNothing) then
                return GL:sendChatMessage((L.CHAT.TRADE_RECEIVED_GOLD):format(goldTradedByThem, Details.partner), channel, nil, recipient);
            end

            -- We gave them an enchantment for their gold (trading gold for gold is not possible, the trade won't be accepted)
            if (iEnchantedSomething and not iTradedItems) then
                return GL:sendChatMessage((L.CHAT.TRADE_GAVE_ENCHANTMENT_FOR_GOLD):format(
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment,
                    Details.partner,
                    goldTradedByThem
                ), channel, nil, recipient);
            end

            -- I received gold for items and potentially an enchant on top
            GL:sendChatMessage((L.CHAT.TRADE_RECEIVED_GOLD):format(goldTradedByThem, Details.partner), channel, nil, recipient);
        end

        -- We enchanted an item, potentially gave gold and got nothing in return
        if (iEnchantedSomething and not iTradedItems and theyDidNothing) then
            if (not iTradedGold) then
                return GL:sendChatMessage((L.CHAT.TRADE_GAVE_ENCHANTMENT):format(
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment,
                    Details.partner
                ), channel, nil, recipient);
            else
                return GL:sendChatMessage((L.CHAT.TRADE_GAVE_ENCHANTMENT_AND_GOLD):format(
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment,
                    Details.partner,
                    goldTradedByMe
                ), channel, nil, recipient);
            end
        end

        -- We only received an enchantment, potentially received gold as well and did nothing in return
        if (theyEnchantedSomething and not theyTradedItems and iDidNothing) then
            if (not theyTradedGold) then
                return GL:sendChatMessage((L.CHAT.TRADE_GOT_ENCHANTMENT):format(
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment
                ), channel, nil, recipient);
            else
                return GL:sendChatMessage((L.CHAT.TRADE_GOT_ENCHANTMENT_AND_GOLD):format(
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment,
                    goldTradedByThem
                ), channel, nil, recipient);
            end
        end

        -- We traded enchantments. Very unusual, but hey you never know -_-'
        if (iEnchantedSomething and not iTradedItems and theyEnchantedSomething and not theyTradedItems) then
            -- We enchanted each other's items and I gave him gold
            if (iTradedGold) then
                return GL:sendChatMessage((L.CHAT.TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD):format(
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment,
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment,
                    goldTradedByMe
                ), channel, nil, recipient);
            end

            -- We enchanted each other's items and he gave me gold
            if (theyTradedGold) then
                return GL:sendChatMessage((L.CHAT.TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT):format(
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment,
                    goldTradedByThem,
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment
                ), channel, nil, recipient);
            end

            -- No money was traded in the process
            return GL:sendChatMessage((L.CHAT.TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT):format(
                Details.partner,
                EnchantedByThem.itemLink,
                EnchantedByThem.enchantment,
                EnchantedByMe.itemLink,
                EnchantedByMe.enchantment
            ), channel, nil, recipient);
        end

        -- We gave items
        if (iTradedItems) then
            local message = "";
            local messageLength = 0;
            local itemsInMessage = 0;
            local itemsProcessed = 0; -- Regardless of message length a message may only contain 5 item links!?!
            local firstOutput = true;

            -- If we gave items AND gold then we start with the gold first
            if (iTradedGold) then
                message = (L.CHAT.TRADE_GAVE):format(goldTradedByMe);
                messageLength = string.len(message);
                itemsInMessage = 1;
            end

            local newMessageLength = messageLength;
            for _, Entry in pairs(ItemsTradedByMe) do
                local itemLinkLength = string.len(GL:getItemNameFromLink(Entry.itemLink)) + 2;
                itemsProcessed = itemsProcessed + 1;

                (function()
                    if (Entry.quantity <= 1) then
                        if (messageLength < 1) then
                            message = (L.CHAT.TRADE_GAVE):format(Entry.itemLink);
                            messageLength = messageLength + string.len(L.CHAT.TRADE_GAVE) - 2 + itemLinkLength; -- -2 for the %s in TRADE_GAVE

                            return;
                        else
                            newMessageLength = messageLength + 1 + itemLinkLength; -- 1 refers to the space between items

                            -- Adding this item to the existing message would make the message too large for chat (>255)
                            -- We need to dump the existing message first before we can continue
                            if (newMessageLength >= 255 or itemsProcessed > 5) then
                                GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                                firstOutput = false;
                                message = Entry.itemLink;
                                messageLength = itemLinkLength;
                                itemsProcessed = 1;
                            else
                                message = ("%s %s"):format(message, Entry.itemLink);
                                messageLength = newMessageLength;
                            end
                        end
                    else
                        if (messageLength < 1) then
                            message = (L.CHAT.TRADE_GAVE_MULTIPLE_OF_ITEM):format(Entry.itemLink, Entry.quantity);
                            messageLength = messageLength + string.len(message) + itemLinkLength - string.len(Entry.itemLink);

                            return;
                        else
                            newMessageLength = messageLength + string.len(", x") + itemLinkLength + string.len(Entry.quantity);

                            -- Adding this item to the existing message would make the message too large for chat (>255)
                            -- We need to dump the existing message first before we can continue
                            if (newMessageLength >= 255 or itemsProcessed > 5) then
                                GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                                firstOutput = false;
                                message = string.format("%sx%s", Entry.itemLink, Entry.quantity);
                                messageLength = itemLinkLength + 1 + string.len(Entry.quantity); -- +1 for the x
                                itemsProcessed = 1;
                            else
                                message = string.format("%s, %sx%s", message, Entry.itemLink, Entry.quantity);
                                messageLength = newMessageLength;
                            end
                        end
                    end
                end)();
            end

            -- There's still some data left that needs to be announced
            -- The goal: I gave 100G 10S 10C, item1, item2 and item3 to Player and also enchanted their item with enchantment
            if (messageLength) then
                -- We enchanted something so we need to take that into account
                if (iEnchantedSomething) then
                    local itemLinkLength = string.len(GL:getItemNameFromLink(EnchantedByMe.itemLink)) + 2;
                    newMessageLength = messageLength + string.len(L.CHAT.TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART) - 6 -- 6 for 3x%s
                        + string.len(Details.partner)
                        + itemLinkLength
                        + string.len(EnchantedByMe.enchantment);

                    if (newMessageLength >= 255 or itemsProcessed >= 5) then -- The enchant also includes an item link
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                        firstOutput = false;

                        message = (L.CHAT.TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART):format(
                            Details.partner,
                            EnchantedByMe.itemLink,
                            EnchantedByMe.enchantment
                        );
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    else
                        message = (L.CHAT.TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS):format(
                            message,
                            Details.partner,
                            EnchantedByMe.itemLink,
                            EnchantedByMe.enchantment
                        );

                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    end
                else
                    newMessageLength = messageLength + string.len(L.CHAT.TRADE_TO_PART) - 1 + string.len(Details.partner);

                    if (newMessageLength >= 255) then
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                        firstOutput = false;
                        message = (L.CHAT.TRADE_TO_PART):format(Details.partner);
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    else
                        message = (L.CHAT.TRADE_TO):format(message, Details.partner);
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    end
                end
            else -- There's nothing left to announce. This happens VERY rarely
                if (iEnchantedSomething) then
                    message = string.format(L.CHAT.TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART,
                        Details.partner,
                        EnchantedByMe.itemLink,
                        EnchantedByMe.enchantment
                    );
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                else
                    message = (L.CHAT.TRADE_TO):format(message, Details.partner);
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                end
            end
        end

        -- We didn't get anything back, no need to continue
        if (not theyTradedItems) then
            return;
        end

        -- They gave us items (totally not DRY I know, but this gives us more control
        local message = "";
        local messageLength = 0;
        local itemsInMessage = 0;
        local itemsProcessed = 0; -- Regardless of message length a message may only contain 5 item links!?!
        local firstOutput = true;

        -- If we received items AND gold then we start with the gold first
        if (theyTradedGold) then
            message = (L.CHAT.TRADE_RECEIVED):format(goldTradedByThem);
            messageLength = string.len(message);
            itemsInMessage = 1;
        end

        local newMessageLength = messageLength;
        for _, Entry in pairs(ItemsTradedByThem) do
            local itemLinkLength = string.len(GL:getItemNameFromLink(Entry.itemLink)) + 2;
            itemsProcessed = itemsProcessed + 1;

            (function()
                if (Entry.quantity <= 1) then
                    if (messageLength < 1) then
                        message = (L.CHAT.TRADE_RECEIVED):format(Entry.itemLink);
                        messageLength = messageLength + string.len(L.CHAT.TRADE_RECEIVED) -2 + itemLinkLength;

                        return;
                    else
                        newMessageLength = messageLength + string.len(", ") + itemLinkLength;

                        -- Adding this item to the existing message would make the message too large for chat (>255)
                        -- We need to dump the existing message first before we can continue
                        if (newMessageLength >= 255 or itemsProcessed > 5) then
                            GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                            firstOutput = false;
                            message = Entry.itemLink;
                            messageLength = itemLinkLength;
                            itemsProcessed = 1;
                        else
                            message = string.format("%s, %s", message, Entry.itemLink);
                            messageLength = newMessageLength;
                        end
                    end
                else
                    if (messageLength < 1) then
                        message = string.format(L.CHAT.TRADE_RECEIVED_MULTIPLE_OF_ITEM, Entry.itemLink, Entry.quantity);
                        messageLength = messageLength + string.len(message) + itemLinkLength - string.len(Entry.itemLink);

                        return;
                    else
                        newMessageLength = messageLength + string.len(", x") + itemLinkLength + string.len(Entry.quantity);

                        -- Adding this item to the existing message would make the message too large for chat (>255)
                        -- We need to dump the existing message first before we can continue
                        if (newMessageLength >= 255 or itemsProcessed > 5) then
                            GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                            firstOutput = false;
                            message = Entry.itemLink;
                            messageLength = itemLinkLength;
                            itemsProcessed = 1;
                        else
                            message = string.format("%s, %sx%s", message, Entry.itemLink, Entry.quantity);
                            messageLength = newMessageLength;
                        end
                    end
                end
            end)();
        end

        -- There's still some data left that needs to be announced
        -- The goal: I gave 100G 10S 10C, item1, item2 and item3 to Player and also enchanted their item with enchantment
        if (messageLength) then
            -- We got something enchanted so we need to take that into account
            if (theyEnchantedSomething) then
                local itemLinkLength = string.len(GL:getItemNameFromLink(EnchantedByThem.itemLink)) + 2;

                newMessageLength = messageLength + string.len(" from  and got my  enchanted with ")
                    + string.len(Details.partner)
                    + itemLinkLength
                    + string.len(EnchantedByThem.enchantment);

                if (newMessageLength >= 255 or itemsProcessed >= 5) then -- The enchant also includes an item link
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    firstOutput = false;

                    message = string.format(L.CHAT.TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART,
                        Details.partner,
                        EnchantedByThem.itemLink,
                        EnchantedByThem.enchantment
                    );
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                else
                    message = string.format(L.CHAT.TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS,
                        message,
                        Details.partner,
                        EnchantedByThem.itemLink,
                        EnchantedByThem.enchantment
                    );

                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                end
            else
                newMessageLength = messageLength + string.len(L.CHAT.TRADE_FROM_PART) - 1 + string.len(Details.partner);

                if (newMessageLength >= 255) then
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    firstOutput = false;
                    message = (L.CHAT.TRADE_FROM_PART):format(Details.partner);
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                else
                    message = (L.CHAT.TRADE_FROM):format(message, Details.partner);
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                end
            end
        else -- There's nothing left to announce. This happens VERY rarely
            if (theyEnchantedSomething) then
                message = string.format(L.CHAT.TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART,
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment
                );
                GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
            else
                message = (L.CHAT.TRADE_FROM):format(message, Details.partner);
                GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
            end
        end
    end)();
end
