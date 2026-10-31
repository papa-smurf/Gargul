local L = Gargul_L;

local ERR_TRADE_COMPLETE = _G.ERR_TRADE_COMPLETE;
local MAX_TRADABLE_ITEMS = _G.MAX_TRADABLE_ITEMS;
local TRADE_ENCHANT_SLOT = _G.TRADE_ENCHANT_SLOT;

local GetTime = _G.GetTime;
local InitiateTrade = _G.InitiateTrade;
local TradeFrame = _G.TradeFrame;
local GetTradePlayerItemInfo = _G.GetTradePlayerItemInfo;
local GetTradePlayerItemLink = _G.GetTradePlayerItemLink;
local GetTradeTargetItemInfo = _G.GetTradeTargetItemInfo;
local GetTradeTargetItemLink = _G.GetTradeTargetItemLink;
local GetPlayerTradeMoney = _G.GetPlayerTradeMoney;
local GetTargetTradeMoney = _G.GetTargetTradeMoney;

local TradeRecipientItem1 = _G.TradeRecipientItem1;
local TradePlayerItemsInset = _G.TradePlayerItemsInset;
local TradePlayerInputMoneyInset = _G.TradePlayerInputMoneyInset;

---@type GL
local _, GL = ...;

---@type Events
local Events = GL.Events;

--- Chat messages are capped at 255 characters, counting links as the [Name] they show
local MAX_CHAT_MESSAGE_LENGTH = 255;

--- Messages holding more item links than this don't come through
local MAX_ITEM_LINKS_PER_MESSAGE = 10;

--- Keeps the gold overlays in front of everything else
local GOLD_INSIGHT_FRAME_LEVEL = 5000;

--- An item unlocking this soon after we added it means the game bounced it back out
local ITEM_BOUNCE_WINDOW = .5;

--- Timer and listener names. Spelling one of these wrong silently skips a cancel, hence the constants
local ADD_ITEMS_TIMER_ID = "TradeWindowAddItemsInterval";
local CURSOR_CHANGED_LISTENER_ID = "TradeWindowCursorChanged";
local HIDE_GOLD_TIMER_ID = "TradeWindowHideGoldToBeTradedTimer";
local MONEY_CHANGED_TIMER_ID = "TradeWindowMoneyChangedInterval";
local TRADE_SHOW_LISTENER_ID = "TradeWindowTradeShowCallbackListener";

--- Strip the decoration retail hangs off the trade partner's name, ie "Name (*)"
---
---@param name? string
---@return string
local sanitizePartnerName = function (name)
    if (not name) then
        return "";
    end

    name = name:gsub("%-", "");
    name = name:gsub("%*", "");
    name = name:gsub("%(", "");

    return (name:gsub("%)", ""));
end;

--- The shape of a trade state, used on load and whenever we reset between trades
---
---@return table
local newState = function ()
    return {
        announce = false,
        EnchantedByMe = {},
        EnchantedByThem = {},
        myGold = 0,
        MyItems = {},
        partner = "",
        theirGold = 0,
        TheirItems = {},
    };
end;

---@class TradeWindow
local TradeWindow = {
    _initialized = false,
    manuallyChangedAnnounceCheckbox = false,

    ---@type CheckButton?
    AnnouncementCheckBox = nil,

    ---@type Frame?
    PlayerTradeMoneyInsight = nil,

    ---@type Frame?
    TradeConfirmGoldInsight = nil,

    ItemsToAdd = {},
    ItemsAdded = {},
    State = newState(),
};

---@type TradeWindow
GL.TradeWindow = TradeWindow;

--- Build one of the dark red overlays we use to spell out how much gold is on the line
---
---@return Frame
local createPlayerTradeMoneyFrame = function ()
    ---@type Frame
    local PlayerTradeMoneyFrame = CreateFrame("Frame", nil, TradeFrame, "BackdropTemplate");
    PlayerTradeMoneyFrame:Hide();
    PlayerTradeMoneyFrame:SetSize(200, 30);

    -- Hide on click
    PlayerTradeMoneyFrame:SetScript("OnMouseUp", function ()
        PlayerTradeMoneyFrame:Hide();
    end);

    PlayerTradeMoneyFrame:SetBackdrop({
        bgFile = "Interface/Buttons/WHITE8x8",
        edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
        edgeSize = 16,
        insets = { left = 4, right = 4, top = 4, bottom = 4, },
    });
    -- Red border + dark background
    PlayerTradeMoneyFrame:SetBackdropColor(0, 0, 0, 1);
    PlayerTradeMoneyFrame:SetBackdropBorderColor(1, 0, 0, 1);

    PlayerTradeMoneyFrame.text = PlayerTradeMoneyFrame:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
    PlayerTradeMoneyFrame.text:SetPoint("CENTER");
    PlayerTradeMoneyFrame.text:SetText("");

    return PlayerTradeMoneyFrame;
end;

--- Add the "Announce Trade" checkbox and its settings cogwheel to the trade window
---
---@return nil
local createAnnounceTradeCheckbox = function ()
    local self = TradeWindow;

    local CheckBox = CreateFrame("CheckButton", "GargulAnnounceTradeDetails", TradeFrame, "UICheckButtonTemplate");

    -- UICheckButtonTemplate names its label $parentText, it's a FontString and not the checkbox itself
    _G.GargulAnnounceTradeDetailsText:SetText(L["Announce Trade"]);
    CheckBox:SetChecked(self:shouldAnnounce());
    CheckBox:SetPoint("BOTTOMLEFT", "TradeFrame", "BOTTOMLEFT", 8, 6);
    CheckBox:SetWidth(20);
    CheckBox:SetHeight(20);
    CheckBox:SetScript("OnClick", function ()
        self.manuallyChangedAnnounceCheckbox = true;
    end);
    CheckBox.tooltipText = L["Announce trade details to group or in /say when not in a group"];
    self.AnnouncementCheckBox = CheckBox;

    -- Create the cogwheel that links to the announcement settings
    local Cogwheel = CreateFrame("Button", "TradeWindowAnnouncementBox", TradeFrame, nil);
    Cogwheel:Show();
    Cogwheel:SetClipsChildren(true);
    Cogwheel:SetSize(13, 13);
    Cogwheel:SetPoint("TOPRIGHT", CheckBox, "TOPRIGHT", 138, -5);

    local CogwheelTexture = Cogwheel:CreateTexture();
    CogwheelTexture:SetPoint("BOTTOMRIGHT", 0, 0);
    CogwheelTexture:SetSize(16, 16);
    CogwheelTexture:SetTexture("interface/cursor/unableinteract");
    Cogwheel.texture = CogwheelTexture;

    Cogwheel:SetScript("OnEnter", function ()
        CogwheelTexture:SetTexture("interface/cursor/interact");
    end);
    Cogwheel:SetScript("OnLeave", function ()
        CogwheelTexture:SetTexture("interface/cursor/unableinteract");
    end);

    Cogwheel:SetScript("OnClick", function (_, button)
        if (button == "LeftButton") then
            GL.Settings:draw("TradeAnnouncements");
        end
    end);
end;

--- Register all events needed to keep track of the trade window state
---
---@return nil
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

    Events:register(nil, "GL.TRADE_COMPLETED", function (_, Details)
        self:announceTradeDetails(Details);
    end);

    Events:register(nil, "SECURE_TRANSFER_CONFIRM_TRADE_ACCEPT", function ()
        self:showTradeConfirmGoldInsight(self.State);
    end);

    Events:register({ "GL.TRADE_COMPLETED", "GL.TRADE_ACCEPT_UPDATE", "TRADE_CLOSED", }, function (event)
        self:hideTradeConfirmGoldInsight();

        if (event ~= "GL.TRADE_ACCEPT_UPDATE") then
            self:hideGoldOverlay();
        end
    end);

    ---@type Frame
    local TradeConfirmGoldInsight = createPlayerTradeMoneyFrame();
    self.TradeConfirmGoldInsight = TradeConfirmGoldInsight;

    -- Tie the frame to the default StaticPopup position
    do
        TradeConfirmGoldInsight:SetPoint("BOTTOM", _G.StaticPopup1, "TOP", 0, 0);
        TradeConfirmGoldInsight:SetPoint("LEFT", _G.StaticPopup1, "LEFT", 8, 0);
        TradeConfirmGoldInsight:SetPoint("RIGHT", _G.StaticPopup1, "RIGHT", -8, 0);
    end

    ---@type Frame
    local PlayerTradeMoneyInsight = createPlayerTradeMoneyFrame();
    self.PlayerTradeMoneyInsight = PlayerTradeMoneyInsight;

    -- Make sure the insight overlay is always on top and positioned correctly
    do
        PlayerTradeMoneyInsight:SetPoint("BOTTOMLEFT", TradePlayerItemsInset, "TOPLEFT", -2, 0);
        PlayerTradeMoneyInsight:SetPoint("RIGHT", TradeRecipientItem1, "LEFT", -12, 20);
        PlayerTradeMoneyInsight:SetPoint("TOP", TradePlayerInputMoneyInset, "TOP");

        -- This is to make sure this window is always on top
        PlayerTradeMoneyInsight:SetFrameLevel(GOLD_INSIGHT_FRAME_LEVEL);
        PlayerTradeMoneyInsight:SetMovable(true);
        PlayerTradeMoneyInsight:StartMoving();
        PlayerTradeMoneyInsight:StopMovingOrSizing();
        PlayerTradeMoneyInsight:SetMovable(false);
    end

    createAnnounceTradeCheckbox();

    self._initialized = true;
end

---@param State table
---@return nil
function TradeWindow:showTradeConfirmGoldInsight(State)
    if (not State.myGold or State.myGold < 1) then
        return;
    end

    GL:after(4, HIDE_GOLD_TIMER_ID, function ()
        self:hideTradeConfirmGoldInsight();
    end);

    self.TradeConfirmGoldInsight.text:SetText(L["You are giving: %s to %s"]:format(GL:copperToMoneyTexture(State.myGold), GL:formatPlayerName(State.partner, { colorize = true, })));
    self.TradeConfirmGoldInsight:Show();

    -- This is to make sure this window is always on top
    self.TradeConfirmGoldInsight:SetFrameLevel(GOLD_INSIGHT_FRAME_LEVEL);
    self.TradeConfirmGoldInsight:SetMovable(true);
    self.TradeConfirmGoldInsight:StartMoving();
    self.TradeConfirmGoldInsight:StopMovingOrSizing();
    self.TradeConfirmGoldInsight:SetMovable(false);
end

---@return nil
function TradeWindow:hideTradeConfirmGoldInsight()
    GL:cancelTimer(HIDE_GOLD_TIMER_ID);
    self.TradeConfirmGoldInsight.text:SetText("");
    self.TradeConfirmGoldInsight:Hide();
end

--- Attempt to open a trade window with a given player name
---
---@param playerName string
---@param callback? function
---@param alwaysExecuteCallback? boolean
---@return nil
function TradeWindow:open(playerName, callback, alwaysExecuteCallback)
    playerName = GL:formatPlayerName(playerName);
    alwaysExecuteCallback = GL:toboolean(alwaysExecuteCallback);

    -- We're already trading with someone
    if (TradeFrame:IsShown()) then
        local playerNameMatches = GL:playerNamesMatch(self.State.partner, playerName) or GL:playerNamesMatch(GL:stripRealm(self.State.partner), playerName);

        if (type(callback) == "function"
            and (alwaysExecuteCallback or playerNameMatches)
        ) then
            callback(playerNameMatches);
        end

        return;
    end

    -- Make sure the callback runs when a trade window is opened
    -- with our desired target or alwaysExecuteCallback is true
    if (type(callback) == "function") then
        -- Even with jitter/lag opening a trade window should never take longer than a second
        -- If it does take longer however then we delete the eventlistener manually
        local timerID = GL.Ace:ScheduleTimer(function ()
            GL.Events:unregister(TRADE_SHOW_LISTENER_ID);

            if (alwaysExecuteCallback) then
                callback(false);
            end
        end, 1);

        GL.Events:register(TRADE_SHOW_LISTENER_ID, "GL.TRADE_SHOW", function ()
            -- Remove our trade window show event listener, we no longer need it
            GL.Events:unregister(TRADE_SHOW_LISTENER_ID);

            -- We can cancel our timer now
            GL.Ace:CancelTimer(timerID);

            -- Perform the callback
            local playerNameMatches = GL:playerNamesMatch(self.State.partner, playerName) or GL:playerNamesMatch(GL:stripRealm(self.State.partner), playerName);

            if (alwaysExecuteCallback
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

---@param copper number
---@return nil
function TradeWindow:showGoldOverlay(copper)
    local Overlay = self.PlayerTradeMoneyInsight;
    GL.Interface:addTooltip(Overlay, L["%s will be traded to %s. Click to add gold manually instead"]:format(GL:copperToMoneyTexture(copper), GL:formatPlayerName(self.State.partner, { colorize = true, })));
    Overlay.text:SetText(GL:copperToMoneyTexture(copper));
    Overlay:Show();
end

---@return nil
function TradeWindow:hideGoldOverlay()
    self.PlayerTradeMoneyInsight:Hide();
end

--- Handle trade-related events
---
---@param event string
---@param ... any
---@return nil
function TradeWindow:handleEvents(event, ...)
    -- Incoming UI_INFO_MESSAGE
    if (event == "UI_INFO_MESSAGE") then
        local _, message = ...;

        -- Trade was successful
        if (message == ERR_TRADE_COMPLETE) then
            -- Check the value of the "Announce trade" checkbox in the trade frame
            self.State.announce = self.AnnouncementCheckBox:GetChecked();

            GL.Events:fire("GL.TRADE_COMPLETED", self.State);
        else
            return;
        end
    end

    -- Trade started
    if (event == "TRADE_SHOW") then
        self.ItemsToAdd, self.ItemsAdded = {}, {};

        -- Trade window shown, show/update the announcement checkbox
        self:updateAnnouncementCheckBox();

        -- Make sure to cancel any lingering timers
        GL:cancelTimer(MONEY_CHANGED_TIMER_ID);
        GL:cancelTimer(ADD_ITEMS_TIMER_ID);

        -- Periodically add items to the trade window
        -- We don't do this instantly because that can bug out the UI
        GL:interval(0, ADD_ITEMS_TIMER_ID, function ()
            self:processItemsToAdd();
        end);

        GL:interval(.2, MONEY_CHANGED_TIMER_ID, function ()
            local myGold = GetPlayerTradeMoney();
            local theirGold = GetTargetTradeMoney();
            if (self.State.myGold ~= myGold
                or self.State.theirGold ~= theirGold
            ) then
                self.State.myGold = myGold;
                self.State.theirGold = theirGold;

                Events:fire("TRADE_MONEY_CHANGED");
            end
        end);

        -- Start listening for gold dropped via cursor
        local moneyBefore = 0;
        Events:register(CURSOR_CHANGED_LISTENER_ID, "CURSOR_CHANGED", function (_, _, newCursorType, oldCursorType)
            -- Player picked up gold
            if (oldCursorType == Enum.UICursorType.Default and newCursorType == Enum.UICursorType.Money) then
                moneyBefore = GetPlayerTradeMoney();
                return;
            end

            -- Player dropped gold
            if (oldCursorType == Enum.UICursorType.Money and newCursorType == Enum.UICursorType.Default) then
                GL:after(.1, nil, function ()
                    local copper = GetPlayerTradeMoney();
                    if (copper and copper > 0 and copper ~= moneyBefore) then
                        self:showGoldOverlay(copper);
                    end
                end);
            end
        end);
    end

    -- Trade closed
    if (event == "TRADE_CLOSED") then
        self.ItemsToAdd, self.ItemsAdded = {}, {};

        -- Make sure to cancel any lingering timers
        GL:cancelTimer(MONEY_CHANGED_TIMER_ID);
        GL:cancelTimer(ADD_ITEMS_TIMER_ID);

        -- Stop watching the cursor, there's no trade window left to drop gold into
        Events:unregister(CURSOR_CHANGED_LISTENER_ID);

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
            if (GetTime() - self.ItemsAdded[itemGUID].timestamp <= ITEM_BOUNCE_WINDOW) then
                tinsert(self.ItemsToAdd, self.ItemsAdded[itemGUID].itemLink or self.ItemsAdded[itemGUID].itemID);
            end

            self.ItemsAdded[itemGUID] = nil;
        end

        return;
    end

    self:resetState();
end

--- Keep track of the trade window's state (e.g. which items, how much money etc)
---
---@return nil
function TradeWindow:updateState()
    if (not TradeFrame:IsShown()) then
        self:resetState();
        return;
    end

    -- NPC is currently the player you're trading
    local partnerName, partnerRealm = UnitName("NPC");
    self.State.partner = GL:formatPlayerName(partnerName, { realm = partnerRealm, includeRealm = "always", });

    -- Fetch the player name of whomever we're trading with
    partnerName = strtrim(_G.TradeFrameRecipientNameText:GetText());

    -- Retail can add (*) or similar to the trade window's partner name ie "Name (*)". Hence the explode+replace
    partnerName = sanitizePartnerName(GL:explode(partnerName, " ")[1]);

    -- If the frame doesn't hold the player name that we set earlier then override it
    -- This should never happen and is nothing but a failsafe
    -- An empty frame is no reason to wipe a perfectly good partner name though
    if (not GL:empty(partnerName)
        and not GL:strStartsWith(self.State.partner, partnerName)
    ) then
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
---
---@return nil
function TradeWindow:resetState()
    self.manuallyChangedAnnounceCheckbox = false;
    self.State = newState();
end

--- Attempt to add a given itemID or itemLink to the trade window
---
---@param itemLinkOrID number|string
---@return nil
function TradeWindow:addItem(itemLinkOrID)
    tinsert(self.ItemsToAdd, itemLinkOrID);
end

--- Attempt to set a copper amount in the trade window
--- Since we use a timer here we require a target so that we can double-check
--- whether we're still trading the right person right before adding the copper
---
---@param amount number
---@param target string
---@param callback? function Receives false, we can never report success
---@return nil
---@test /script _G.Gargul.TradeWindow:setCopper(20, "Ggtest-Sen'jin");
function TradeWindow:setCopper(amount, target, callback)
    -- There are two ways to add gold to the trade window:
    -- You can use _G.MoneyInputFrame_SetCopper(_G.TradePlayerInputMoneyFrame, 10);
    -- which allows you to see how much gold you're about to trade
    --
    -- OR
    --
    -- You can use SetTradeMoney(10); which doesn't show you anything which of course is shady and dangerous
    -- and not something that I consider usuable from a user-perspective.
    --
    -- Guess which single one Blizzard blocked for "security" reasons. 100 points for Fumblepuff
    --
    -- Until that changes we always fail, and callers need to hear about it so they can tell the user
    if (type(callback) == "function") then
        callback(false);
    end
end

--- Process the ItemsToAdd table
---
---@return nil
function TradeWindow:processItemsToAdd()
    -- Make sure we don't use items if the trade window is not opened
    -- The last thing we want to do is equip an item or use a consumable by mistake!
    if (not TradeFrame:IsShown()) then
        GL:cancelTimer(ADD_ITEMS_TIMER_ID);

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
    GL.UseContainerItem(bag, slot);
end

--- Check whether we should announce trade details
---
---@return boolean
function TradeWindow:shouldAnnounce()
    -- When does the user want to announce trade details?
    local mode = GL.Settings:get("TradeAnnouncements.mode", "WHEN_MASTERLOOTER");

    -- The user manually set the announcement state for the current trade, no need to override it
    if (self.manuallyChangedAnnounceCheckbox
        and self.AnnouncementCheckBox
    ) then
        return GL:toboolean(self.AnnouncementCheckBox:GetChecked());
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
---@return nil
function TradeWindow:updateAnnouncementCheckBox()
    self.AnnouncementCheckBox:SetChecked(self:shouldAnnounce());
end

--- Length of a string the way chat counts it: hyperlink escape codes don't add up
---
---@param text string
---@return number
local visibleLength = function (text)
    text = text:gsub("|c%x%x%x%x%x%x%x%x", ""); -- |cffa335ee
    text = text:gsub("|c%w-:", ""); -- |cnIQ4:
    text = text:gsub("|H.-|h", "");
    text = text:gsub("|h", "");
    text = text:gsub("|r", "");

    return strlen(text);
end;

--- Combine identical items and sort them so our announcements keep a stable order
---
---@param Items table
---@return table
local combineItems = function (Items)
    local minimumQuality = GL.Settings:get("TradeAnnouncements.minimumQualityOfAnnouncedLoot", 0);
    local Combined, Entries = {}, {};

    for _, Entry in pairs(Items or {}) do
        local itemID = tonumber(Entry.itemID);

        if (itemID
            and (Entry.quality or 0) >= minimumQuality
        ) then
            local quantity = Entry.quantity and Entry.quantity > 1 and Entry.quantity or 1;

            if (Combined[itemID]) then
                Combined[itemID].quantity = Combined[itemID].quantity + quantity;
            else
                Combined[itemID] = {
                    itemLink = Entry.itemLink,
                    quantity = quantity,
                };

                tinsert(Entries, Combined[itemID]);
            end
        end
    end

    table.sort(Entries, function (a, b)
        return tostring(GL:getItemNameFromLink(a.itemLink)) < tostring(GL:getItemNameFromLink(b.itemLink));
    end);

    return Entries;
end;

--- Announce a single sentence, spread over multiple chat messages when it doesn't fit in one
---
--- The first message opens the sentence ("I gave [item], [item]"), the last one closes it
--- ("... to Player"). Anything in between is a bare list of items.
---
---@param Parts table Item links and gold that make up the body of the sentence
---@param Sentence table open/close/closeAlone callbacks that wrap the body in readable text
---@param channel string
---@param recipient? string
---@return nil
local announceSentence = function (Parts, Sentence, channel, recipient)
    if (GL:empty(Parts)) then
        return;
    end

    local Messages = {};
    local message = "";
    local links = 0;

    -- Gargul prefixes the opening message, which eats into our character budget
    local prefixLength = strlen(("{rt3} %s : "):format(GL.name));
    local budget = function ()
        return MAX_CHAT_MESSAGE_LENGTH - (GL:empty(Messages) and prefixLength or 0);
    end;

    for _, Part in ipairs(Parts) do
        local candidate = GL:empty(message) and Sentence.open(Part.text) or ("%s, %s"):format(message, Part.text);

        -- This part no longer fits, wrap up the current message and start a new one
        if (not GL:empty(message)
            and (visibleLength(candidate) > budget() or links >= MAX_ITEM_LINKS_PER_MESSAGE)
        ) then
            tinsert(Messages, message);
            message = Part.text;
            links = 0;
        else
            message = candidate;
        end

        links = links + (Part.isItemLink and 1 or 0);
    end

    -- Round the sentence off, giving its ending a message of its own when it no longer fits
    local closed = Sentence.close(message);
    if (visibleLength(closed) > budget()
        or (Sentence.closeHoldsItemLink and links >= MAX_ITEM_LINKS_PER_MESSAGE)
    ) then
        tinsert(Messages, message);
        tinsert(Messages, Sentence.closeAlone());
    else
        tinsert(Messages, closed);
    end

    local firstOutput = true;
    for _, chatMessage in ipairs(Messages) do
        GL:sendChatMessage(chatMessage, channel, nil, recipient, firstOutput);
        firstOutput = false;
    end
end;

--- Announce the items, gold and enchantments that changed hands in chat
---
--- Everything we handed over becomes one sentence, everything we got back another. Both are
--- built the same way, so an enchant is never dropped just because items went the other way.
---
---@param Details table
---@return nil
function TradeWindow:announceTradeDetails(Details)
    -- Check if the user wants to announce this trade
    if (not Details.announce) then
        return;
    end

    -- Announce to the group, or whisper our trade partner when we're not in one
    local channel, recipient = "GROUP", nil;
    if (not GL.User.isInGroup) then
        channel, recipient = "WHISPER", Details.partner;
    end

    local partner = Details.partner;
    local EnchantedByMe = Details.EnchantedByMe or {};
    local EnchantedByThem = Details.EnchantedByThem or {};

    local iEnchanted = GL.Settings:get("TradeAnnouncements.enchantmentGiven", true)
        and not GL:empty(EnchantedByMe.enchantment)
        and not GL:inTable(GL.Data.Constants.LockedItems, EnchantedByMe.itemID);
    local theyEnchanted = GL.Settings:get("TradeAnnouncements.enchantmentReceived", true)
        and not GL:empty(EnchantedByThem.enchantment)
        and not GL:inTable(GL.Data.Constants.LockedItems, EnchantedByThem.itemID);

    local iGaveGold = GL.Settings:get("TradeAnnouncements.goldGiven", true) and (Details.myGold or 0) > 0;
    local theyGaveGold = GL.Settings:get("TradeAnnouncements.goldReceived", true) and (Details.theirGold or 0) > 0;
    local goldGivenByMe = GL:copperToMoney(Details.myGold or 0);
    local goldGivenByThem = GL:copperToMoney(Details.theirGold or 0);

    local MyItems = GL.Settings:get("TradeAnnouncements.itemsGiven", true) and combineItems(Details.MyItems) or {};
    local TheirItems = GL.Settings:get("TradeAnnouncements.itemsReceived", true) and combineItems(Details.TheirItems) or {};

    --- Gold (if any) leads, the items follow
    local buildParts = function (gold, Items)
        local Parts = {};

        if (gold) then
            tinsert(Parts, { text = gold, });
        end

        for _, Entry in ipairs(Items) do
            tinsert(Parts, {
                text = Entry.quantity > 1 and ("%sx%s"):format(Entry.itemLink, Entry.quantity) or Entry.itemLink,
                isItemLink = true,
            });
        end

        return Parts;
    end;

    local GivenParts = buildParts(iGaveGold and goldGivenByMe or nil, MyItems);
    local ReceivedParts = buildParts(theyGaveGold and goldGivenByThem or nil, TheirItems);

    -- Paying for an enchant is by far the most common enchanter trade, keep it to one line
    if (GL:empty(MyItems)
        and GL:empty(TheirItems)
    ) then
        if (iGaveGold and theyEnchanted and not iEnchanted) then
            GL:sendChatMessage((L.CHAT["%s enchanted my %s with %s for %s"]):format(
                partner,
                EnchantedByThem.itemLink,
                EnchantedByThem.enchantment,
                goldGivenByMe
            ), channel, nil, recipient);

            return;
        end

        if (theyGaveGold and iEnchanted and not theyEnchanted) then
            GL:sendChatMessage((L.CHAT["I enchanted %s with %s for %s and received %s"]):format(
                EnchantedByMe.itemLink,
                EnchantedByMe.enchantment,
                partner,
                goldGivenByThem
            ), channel, nil, recipient);

            return;
        end
    end

    -- Everything that went their way
    if (not GL:empty(GivenParts)) then
        announceSentence(GivenParts, {
            open = function (body)
                return (L.CHAT["I gave %s"]):format(body);
            end,

            close = function (body)
                if (not iEnchanted) then
                    return (L.CHAT["%s to %s"]):format(body, partner);
                end

                return (L.CHAT["%s to %s and enchanted their %s with %s"]):format(
                    body,
                    partner,
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment
                );
            end,

            closeAlone = function ()
                if (not iEnchanted) then
                    return (L.CHAT["to %s"]):format(partner);
                end

                return (L.CHAT["to %s and enchanted their %s with %s"]):format(
                    partner,
                    EnchantedByMe.itemLink,
                    EnchantedByMe.enchantment
                );
            end,

            closeHoldsItemLink = iEnchanted,
        }, channel, recipient);

    -- We gave nothing but did enchant something for them
    elseif (iEnchanted) then
        GL:sendChatMessage((L.CHAT["I enchanted %s with %s for %s"]):format(
            EnchantedByMe.itemLink,
            EnchantedByMe.enchantment,
            partner
        ), channel, nil, recipient);
    end

    -- Everything that came our way
    if (not GL:empty(ReceivedParts)) then
        announceSentence(ReceivedParts, {
            open = function (body)
                return (L.CHAT["I received %s"]):format(body);
            end,

            close = function (body)
                if (not theyEnchanted) then
                    return (L.CHAT["%s from %s"]):format(body, partner);
                end

                return (L.CHAT["%s from %s and got my %s enchanted with %s"]):format(
                    body,
                    partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment
                );
            end,

            closeAlone = function ()
                if (not theyEnchanted) then
                    return (L.CHAT["from %s"]):format(partner);
                end

                return (L.CHAT["from %s and got my %s enchanted with %s"]):format(
                    partner,
                    EnchantedByThem.itemLink,
                    EnchantedByThem.enchantment
                );
            end,

            closeHoldsItemLink = theyEnchanted,
        }, channel, recipient);

    -- We got nothing but they did enchant something of ours
    elseif (theyEnchanted) then
        GL:sendChatMessage((L.CHAT["%s enchanted my %s with %s"]):format(
            partner,
            EnchantedByThem.itemLink,
            EnchantedByThem.enchantment
        ), channel, nil, recipient);
    end
end
