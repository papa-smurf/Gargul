---@type GL
local _, GL = ...;

---@class TradeWindow
GL.TradeWindow = {
    _initialized = false,
    manuallyChangedAnnounceCheckbox = false,
    AnnouncementCheckBox = nil,

    AddItemsTimer = nil,
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
        {"TradeWindowTradeTargetItemChangedListener", "TRADE_TARGET_ITEM_CHANGED"},
        {"TradeWindowTradeShowListener", "TRADE_SHOW"},
        {"TradeWindowTradeCloseListener", "TRADE_CLOSED"},
        {"TradeWindowTradeRequestCancelListener", "TRADE_REQUEST_CANCEL"},
        {"TradeWindowUIInfoMessageListener", "UI_INFO_MESSAGE"},
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

    -- ERA is an odd duck. It requires a realm, but only if the trade partner's realm differs from ours
    if (GL.isEra) then
        local playerRealm = GL:getRealmFromName(playerName);

        if (string.lower(playerRealm) == string.lower(GL.User.realm)) then
            playerName = GL:stripRealm(playerName);
        end
    end

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
        GL:debug("Cancel TradeWindow.AddItemsTimer");
        GL.Ace:CancelTimer(self.AddItemsTimer);
        self.AddItemsTimer = nil;

        -- Periodically add items to the trade window
        -- We don't do this instantly because that can bug out the UI
        GL:debug("Schedule new TradeWindow.AddItemsTimer");
        self.AddItemsTimer = GL.Ace:ScheduleRepeatingTimer(function ()
            GL:debug("Run TradeWindow.AddItemsTimer");

            self:processItemsToAdd();
        end, .5);
    end

    -- Trade closed
    if (event == "TRADE_CLOSED") then
        self.ItemsToAdd = {};

        -- Make sure to cancel any lingering timers
        GL:debug("Cancel TradeWindow.AddItemsTimer");
        GL.Ace:CancelTimer(self.AddItemsTimer);
        self.AddItemsTimer = nil;

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
---
---@return void
function TradeWindow:resetState()
    GL:debug("TradeWindow:resetState");

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
        GL:debug("Cancel TradeWindow.AddItemsTimer");
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
---
---@return void
function TradeWindow:updateAnnouncementCheckBox()
    GL:debug("TradeWindow:updateAnnouncementCheckBox");

    -- Only create the checbox / cogwheel once
    if (not GL:empty(self.AnnouncementCheckBox)) then
        self.AnnouncementCheckBox:SetChecked(self:shouldAnnounce());
        return;
    end

    local CheckBox = CreateFrame("CheckButton", "GargulAnnounceTradeDetails", TradeFrame, "OptionsCheckButtonTemplate");
    GargulAnnounceTradeDetailsText:SetText("Announce Trade");
    CheckBox:SetChecked(self:shouldAnnounce());
    CheckBox:SetPoint("BOTTOMLEFT", "TradeFrame", "BOTTOMLEFT", 8, 6);
    CheckBox:SetWidth(20);
    CheckBox:SetHeight(20);
    CheckBox:SetScript("OnClick", function ()
        self.manuallyChangedAnnounceCheckbox = true;
    end);
    CheckBox.tooltipText = "Announce trade details to group or in /say when not in a group";
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
--- This method is huge, huge, I'm aware. I might have gone a bit overboard, but this at least keeps chat clean~ish
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

                if (Entry.quantity > 1) then
                    local quantity = Entry.quantity;
                    local itemIDString = tostring(Entry.itemID); -- Should already be a string, but need to make sure

                    -- Check to see if we already have a quantity of the same item available (multiple stacks?)
                    if (ItemsTradedByMe[itemIDString]) then
                        quantity = quantity + ItemsTradedByMe[itemIDString].quantity;
                    end
                    ItemsTradedByMe[itemIDString] = {
                        itemLink = Entry.itemLink,
                        quantity = quantity,
                    };
                else
                    tinsert(ItemsTradedByMe, {
                        itemLink = Entry.itemLink,
                        quantity = 1,
                    });
                end
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

                if (Entry.quantity > 1) then
                    local quantity = Entry.quantity;
                    local itemIDString = tostring(Entry.itemID); -- Should already be a string, but need to make sure

                    -- Check to see if we already have a quantity of the same item available (multiple stacks?)
                    if (ItemsTradedByThem[itemIDString]) then
                        quantity = quantity + ItemsTradedByThem[itemIDString].quantity;
                    end
                    ItemsTradedByThem[itemIDString] = {
                        itemLink = Entry.itemLink,
                        quantity = quantity,
                    };
                else
                    tinsert(ItemsTradedByThem, {
                        itemLink = Entry.itemLink,
                        quantity = 1,
                    });
                end
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
                return GL:sendChatMessage(string.format("I gave %s to %s", goldTradedByMe, Details.partner), channel, nil, recipient);
            end

            -- We gave them gold for an enchantment (trading gold for gold is not possible, the trade won't be accepted)
            if (theyEnchantedSomething and not theyTradedItems) then
                return GL:sendChatMessage(string.format("%s enchanted my %s with %s for %s",
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment,
                    goldTradedByMe
                ), channel, nil, recipient);
            end

            -- I gave them gold for items and potentially an enchant on top
            GL:sendChatMessage(string.format("I gave %s to %s", goldTradedByMe, Details.partner), channel, nil, recipient);
        end

        -- We only received gold (and optionally enchanted something)
        if (theyTradedGold and not theyTradedItems and not theyEnchantedSomething) then
            -- And gave nothing in return
            if (iDidNothing) then
                return GL:sendChatMessage(string.format("I received %s from %s", goldTradedByThem, Details.partner), channel, nil, recipient);
            end

            -- We gave them an enchantment for their gold (trading gold for gold is not possible, the trade won't be accepted)
            if (iEnchantedSomething and not iTradedItems) then
                return GL:sendChatMessage(string.format("I enchanted %s with %s for %s and received %s",
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment,
                    Details.partner,
                    goldTradedByThem
                ), channel, nil, recipient);
            end

            -- I received gold for items and potentially an enchant on top
            GL:sendChatMessage(string.format("I received %s from %s", goldTradedByThem, Details.partner), channel, nil, recipient);
        end

        -- We enchanted an item, potentially gave gold and got nothing in return
        if (iEnchantedSomething and not iTradedItems and theyDidNothing) then
            if (not iTradedGold) then
                return GL:sendChatMessage(string.format("I enchanted %s with %s for %s",
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment,
                    Details.partner
                ), channel, nil, recipient);
            else
                return GL:sendChatMessage(string.format("I enchanted %s with %s for %s and gave %s",
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
                return GL:sendChatMessage(string.format("%s enchanted my %s with %s",
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment
                ), channel, nil, recipient);
            else
                return GL:sendChatMessage(string.format("%s enchanted my %s with %s and gave me %s",
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
                return GL:sendChatMessage(string.format("%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s",
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
                return GL:sendChatMessage(string.format("%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s.",
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment,
                    goldTradedByThem,
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment,
                    goldTradedByThem
                ), channel, nil, recipient);
            end

            -- No money was traded in the process
            return GL:sendChatMessage(string.format("%s enchanted my %s with %s and I enchanted their %s with %s",
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
                message = string.format("I gave %s", goldTradedByMe);
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
                            message = string.format("I gave %s", Entry.itemLink);
                            messageLength = messageLength + string.len("I gave ") + itemLinkLength;

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
                            message = string.format("I gave %sx%s", Entry.itemLink, Entry.quantity);
                            messageLength = messageLength + string.len("I gave x") + itemLinkLength + string.len(Entry.quantity);

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
                -- We enchanted something so we need to take that into account
                if (iEnchantedSomething) then
                    local itemLinkLength = string.len(GL:getItemNameFromLink(EnchantedByMe.itemLink)) + 2;
                    newMessageLength = messageLength + string.len(" to  and enchanted their  with ")
                        + string.len(Details.partner)
                        + itemLinkLength
                        + string.len(EnchantedByMe.enchantment);

                    if (newMessageLength >= 255 or itemsProcessed >= 5) then -- The enchant also includes an item link
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                        firstOutput = false;

                        message = string.format("to %s and enchanted their %s with %s",
                            Details.partner,
                            EnchantedByMe.itemLink,
                            EnchantedByMe.enchantment
                        );
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    else
                        message = string.format("%s to %s and enchanted their %s with %s",
                            message,
                            Details.partner,
                            EnchantedByMe.itemLink,
                            EnchantedByMe.enchantment
                        );

                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    end
                else
                    newMessageLength = messageLength + string.len(" to ") + string.len(Details.partner);

                    if (newMessageLength >= 255) then
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                        firstOutput = false;
                        message = string.format("to %s", Details.partner);
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    else
                        message = string.format("%s to %s", message, Details.partner);
                        GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    end
                end
            else -- There's nothing left to announce. This happens VERY rarely
                if (iEnchantedSomething) then
                    message = string.format("to %s and enchanted their %s with %s",
                        Details.partner,
                        EnchantedByMe.itemLink,
                        EnchantedByMe.enchantment
                    );
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                else
                    message = string.format("%s to %s", message, Details.partner);
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
            message = string.format("I received %s", goldTradedByThem);
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
                        message = string.format("I received %s", Entry.itemLink);
                        messageLength = messageLength + string.len("I received ") + itemLinkLength;

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
                        message = string.format("I received %sx%s", Entry.itemLink, Entry.quantity);
                        messageLength = messageLength + string.len("I received x") + itemLinkLength + string.len(Entry.quantity);

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

                    message = string.format("from %s and got my %s enchanted with %s",
                        Details.partner,
                        EnchantedByThem.itemLink,
                        EnchantedByThem.enchantment
                    );
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                else
                    message = string.format("%s from %s and got my %s enchanted with %s",
                        message,
                        Details.partner,
                        EnchantedByThem.itemLink,
                        EnchantedByThem.enchantment
                    );

                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                end
            else
                newMessageLength = messageLength + string.len(" from ") + string.len(Details.partner);

                if (newMessageLength >= 255) then
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                    firstOutput = false;
                    message = string.format("from %s", Details.partner);
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                else
                    message = string.format("%s from %s", message, Details.partner);
                    GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
                end
            end
        else -- There's nothing left to announce. This happens VERY rarely
            if (theyEnchantedSomething) then
                message = string.format("from %s and got my %s enchanted with %s",
                    Details.partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment
                );
                GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
            else
                message = string.format("%s from %s", message, Details.partner);
                GL:sendChatMessage(message, channel, nil, recipient, firstOutput);
            end
        end
    end)();
end

GL:debug("TradeWindow.lua");