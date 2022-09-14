---@type GL
local _, GL = ...;

---@class DroppedLoot
GL.DroppedLoot = {
    Announced = {},
    initialized = false,
    ButtonsHooked = {},
    allButtonsHooked = false,
    LootButtonItemLinkCache = {},
    lootChangedTimer = 0,
    lootWindowIsOpened = false,
};

local Constants = GL.Data.Constants; ---@type Data
local DroppedLoot = GL.DroppedLoot; ---@type DroppedLoot
local Events = GL.Events; ---@type Events
local SoftRes = GL.SoftRes; ---@type SoftRes
local LCG = LibStub("LibCustomGlowGargul-1.0");

---@return boolean
function DroppedLoot:_init()
    GL:debug("DroppedLoot:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return false;
    end

    -- Fire DroppedLoot:lootReady every time a loot window is opened
    Events:register("DroppedLootLootOpenedListener", "LOOT_READY", function () self:lootReady(); end);

    -- Show a reminder window to use Gargul when trying to assign using native loot assignment
    Events:register("DroppedLootOpenMasterLooterListListener", "OPEN_MASTER_LOOT_LIST", function ()
        if (GL.User.isMasterLooter
            and GL.Settings:get("TMB.showLootAssignmentReminder")
            and GL.TMB:available()
        ) then
            GL.Interface.ReminderToAssignLootUsingGargul:draw();
        end
    end);

    MasterLooterFrame:HookScript("OnHide", function()
        GL.Interface.ReminderToAssignLootUsingGargul:close();
    end);

    -- Make sure to keep track of the loot window status
    Events:register("DroppedLootLootClosedListener", "LOOT_CLOSED", function ()
        DroppedLoot.lootWindowIsOpened = false;

        GL.Interface.ShortcutKeysLegend:close();

        -- Stop the timer responsible for trigger the GL.LOOT_CHANGED event
        if (self.lootChangedTimer) then
            GL.Ace:CancelTimer(self.lootChangedTimer);
        end
    end);

    -- Remove highlight on loot buttons when closing the loot window
    Events:register("DroppedLootLootClosedHighlighterListener", "LOOT_CLOSED",
        function ()
            self:removeHighlights();
            self.DroppedLoot.LootButtonItemLinkCache = {};
        end
    );

    -- Highlight items that are soft-reserved or have TMB details
    Events:register("DroppedLootLootSlotChangedHighlighterListener", "GL.LOOT_CHANGED", function () self:highlightItemsOfInterest() end);

    self._initialized = true;
    return true;
end

--- Fired when a loot window is opened
---
---@return void
function DroppedLoot:lootReady()
    GL:debug("DroppedLoot:lootOpened");

    self.lootWindowIsOpened = true;

    self:lootChanged();
    Events:fire("GL.LOOT_CHANGED");

    -- Periodically check if the loot changed because the internal WoW events are not
    -- comprehensive enough to detect things like the player moving to the next page of items.
    self.lootChangedTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        if (self:lootChanged()) then
            Events:fire("GL.LOOT_CHANGED");
        end
    end, .1);

    -- Only announce loot in chat if the setting is enabled
    if (GL.User.isMasterLooter
        and GL.Settings:get("DroppedLoot.announceLootToChat")
    ) then
        self:announce();
    end

    if (GL.User.isMasterLooter
        and GL.Settings:get("ShortcutKeys.showLegend", true)
    ) then
        GL.Ace:ScheduleTimer(function ()
            if (self.lootWindowIsOpened) then
                GL.Interface.ShortcutKeysLegend:draw();
            end
        end, 1.4);
    end

    -- Let the rest of the application know we're done announcing the items
    GL.Events:fire("GL.LOOT_ANNOUNCED");

    -- We need to delay the hooking of click events because some add-ons
    -- are slow when it comes to adding their custom buttons (looking at you XLoot)
    GL.Ace:ScheduleTimer(function ()
        self:hookClickEvents();
    end, .4);
end

-- Check whether the loot in the loot window changed in any way e.g:
-- An item was taken from the window
-- The player navigated to a different page in the loot window
function DroppedLoot:lootChanged()
    local lootChanged = false;
    for buttonIndex = 1, _G.LOOTFRAME_NUMBUTTONS do
        local buttonName = "LootButton" .. buttonIndex;
        local Button = getglobal("LootButton" .. buttonIndex);
        local itemLink = "";

        if (Button
            and Button:IsVisible()
            and Button.slot
        ) then
            itemLink = GetLootSlotLink(Button.slot);

            if (GL:empty(itemLink)) then
                itemLink = "";
            end
        end

        if (GL:tableGet(self.LootButtonItemLinkCache, buttonName, -1) ~= itemLink) then
            lootChanged = true;
        end

        self.LootButtonItemLinkCache[buttonName] = itemLink;
    end

    return lootChanged;
end

-- Remove the highlights on all loot buttons
function DroppedLoot:removeHighlights()
    for buttonIndex = 1, _G.LOOTFRAME_NUMBUTTONS do
        local Button = getglobal("LootButton" .. buttonIndex);

        if (Button) then
            LCG.PixelGlow_Stop(getglobal("LootButton" .. buttonIndex));
        end
    end
end

-- Highlight items that are soft-reserved or otherwise need extra attention
function DroppedLoot:highlightItemsOfInterest()
    GL:debug("DroppedLoot:highlightItemsOfInterest");

    -- There's no point highlighting loot if the player
    -- is not in a group or highlights are disabled
    if (not GL.User.isInGroup
        or GL.Settings:get("highlightsDisabled")
        or (
            not GL.Settings:get("highlightHardReservedItems")
            and not GL.Settings:get("highlightSoftReservedItems")
            and not GL.Settings:get("highlightWishlistedItems")
        )
    ) then
        return;
    end

    -- 4 is the max since buttons seem to be reused
    -- throughout loot pages... thanks Blizzard
    for buttonIndex = 1, _G.LOOTFRAME_NUMBUTTONS do
        local Button = getglobal("LootButton" .. buttonIndex);

        if (Button) then
            -- Remove the button's highlight
            LCG.PixelGlow_Stop(Button);
            if (Button:IsVisible() and Button.slot) then
                local itemLink = GetLootSlotLink(Button.slot);

                if (itemLink) then
                    local enableHighlight = false;
                    local BorderColor = {1, 1, 1, 1}; -- The default border color is priest-white and applies to wishlisted items

                    -- The item is hard-reserved
                    if (GL.Settings:get("highlightHardReservedItems")
                        and SoftRes:linkIsHardReserved(itemLink)
                    ) then
                        enableHighlight = true;
                        BorderColor = {.77, .12, .23, 1};  -- Make the border red for hard-reserved items

                    -- The item is soft-reserved
                    elseif (GL.Settings:get("highlightSoftReservedItems")
                        and SoftRes:linkIsReserved(itemLink)
                        and not (not GL.User.isMasterLooter
                            and GL.Settings:get("highlightMyItemsOnly")
                            and not SoftRes:itemLinkIsReservedByMe(itemLink)
                        )
                    ) then
                        enableHighlight = true;
                        BorderColor = {.95686, .5490, .72941, 1}; -- Make the border paladin-pink for reserved items

                    -- Check if it's wishlisted/priolisted
                    elseif (GL.Settings:get("highlightWishlistedItems")
                        or GL.Settings:get("highlightPriolistedItems")
                    ) then
                        local TMBInfo = {};

                        -- Fetch all TMB data for this item
                        if (GL.User.isMasterLooter
                            or not GL.Settings:get("highlightMyItemsOnly")
                        ) then
                            TMBInfo = GL.TMB:byItemLink(itemLink) or {};

                        -- Fetch only the current user's TMB data, he's not interested in the rest
                        else
                            TMBInfo = GL.TMB:byItemLinkAndPlayer(itemLink, GL.User.name) or {};
                        end

                        local concernsPrio = false;

                        -- Check for active wishlist entries
                        for _, Entry in pairs(TMBInfo) do
                            BorderColor = {1, 1, 1, 1}; -- Make the border priest-white for TMB wishlisted items

                            if (Entry.type == Constants.tmbTypePrio) then
                                concernsPrio = true;
                                BorderColor = {1, .48627, .0392, 1}; -- Make the border druid-orange for TMB character prio items
                                break;
                            end
                        end

                        if (not GL:empty(TMBInfo)
                            and (
                                (not concernsPrio and GL.Settings:get("highlightWishlistedItems"))
                                or (concernsPrio and GL.Settings:get("highlightPriolistedItems"))
                            )
                        ) then
                            enableHighlight = true;
                        end
                    end

                    if (enableHighlight) then
                        -- Add an animated border to indicate that this item was reserved / wishlisted
                        LCG.PixelGlow_Start(Button, BorderColor, 10, .05, 5, 3);
                    end
                end
            end
        end
    end
end

-- Hook click events to the item buttons in the
-- loot window (name LootButton1 through LootButton4)
-- Only 4 buttons will be used regardless of number of drops
-- Alt click opens the roll window, alt + shift opens the auctioneer window
function DroppedLoot:hookClickEvents()
    GL:debug("DroppedLoot:hookClickEvents");

    -- The first loot button should always exist,
    -- that way we can determine the button provider for all future buttons
    local buttonProvider = (function ()
        --- ElvUI support
        if (getglobal("ElvLootSlot1")) then
            return "ElvUI";
        end

        --- XLoot 1.0 support
        if (getglobal("XLootFrameButton1")) then
            return "XLoot1";
        end

        --- XLoot support
        if (getglobal("XLootButton1")) then
            return "XLoot";
        end

        --- default (vanilla) UI
        return "default";
    end)();

    --- The default UI only supports 4 buttons, but add-ons like XLoot
    --- support a potentially unlimited number of loot buttons, hence the 99
    ---@todo Some add-ons support more than 4 loot buttons (XLoot specifically), this needs to be fixed at some point
    for buttonIndex = 1, _G.LOOTFRAME_NUMBUTTONS do
        self.ButtonsHooked[buttonProvider] = self.ButtonsHooked[buttonProvider] or {};

        if (not self.ButtonsHooked[buttonProvider][buttonIndex]) then
            local Button;
            if (buttonProvider == "ElvUI") then
                Button = getglobal("ElvLootSlot" .. buttonIndex);
            elseif (buttonProvider == "XLoot1") then
                Button = getglobal("XLootFrameButton" .. buttonIndex);
            elseif (buttonProvider == "XLoot") then
                Button = getglobal("XLootButton" .. buttonIndex);
            else
                Button = getglobal("LootButton" .. buttonIndex);
            end

            --- No button with this index was found, no need to look further
            if (not Button) then
                break;
            end

            Button:HookScript("OnClick", function(_, mouseButtonPressed)
                local slot = Button.slot or buttonIndex;

                if (not slot) then
                    return;
                end

                local itemLink = GetLootSlotLink(slot);

                if (not itemLink or type(itemLink) ~= "string") then
                    return;
                end

                local keyPressIdentifier = GL.Events:getClickCombination(mouseButtonPressed);

                -- Open the roll window
                if (keyPressIdentifier == GL.Settings:get("ShortcutKeys.rollOff")) then
                    GL.MasterLooterUI:draw(itemLink);

                    -- Open the award window
                elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.award")) then
                    GL.Interface.Award:draw(itemLink);

                    -- Disenchant the item
                elseif (keyPressIdentifier == GL.Settings:get("ShortcutKeys.disenchant")) then
                    GL.PackMule:disenchant(itemLink);
                end
            end);

            self.ButtonsHooked[buttonProvider][buttonIndex] = true;
        end
    end
end

-- Announce the loot that dropped in the party or raid chat
function DroppedLoot:announce(Modifiers)
    GL:debug("DroppedLoot:announce");

    Modifiers = Modifiers or {};
    local Functions = Modifiers.Functions or {
        GetNumLootItems = GetNumLootItems,
        GetLootSlotInfo = GetLootSlotInfo,
        GetLootSlotLink = GetLootSlotLink,
        GetLootSlotType = GetLootSlotType,
        GetLootSourceInfo = GetLootSourceInfo,
    };

    -- The sourceGUID is something we use to make sure
    -- we don't announce the same loot multiple times
    local sourceGUID = false;

    -- Fetch the name of everyone currently in the raid/party
    local PlayersInRaid = GL.User:groupMemberNames();

    -- Get the total number of items that dropped
    local itemCount = Functions.GetNumLootItems();

    -- Loop through every item in the loot window
    for lootIndex = 1, itemCount do
        local itemLink = Functions.GetLootSlotLink(lootIndex);

        -- This self-executing anonymous function gives us a bit more control
        (function ()
            local itemIsHardReserved = false;

            -- We need an itemLink to work with. If an item doesn't have it that means:
            --     It's not a "real" item but gold/silver/copper
            --     The item no longer exists in the loot window
            --     The data is not yet available
            if (not itemLink) then
                return;
            end

            -- Make sure we don't override sourceGUID with false/nil if it was already set!
            sourceGUID = sourceGUID or Functions.GetLootSourceInfo(lootIndex);

            -- We're missing crucial data, skip!
            if (GL:empty(sourceGUID) -- Make sure we have a sourceGUID
                or DroppedLoot.Announced[sourceGUID] -- We apparently already announced these items
            ) then
                return;
            end

            local quality = select(5, Functions.GetLootSlotInfo(lootIndex)) or 0;
            local lootType = Functions.GetLootSlotType(lootIndex);
            local SoftReserves = SoftRes:byItemLink(itemLink);
            local TMBInfo = GL.TMB:byItemLink(itemLink);

            -- Check if we need to announce this item
            local itemId = tonumber(GL:getItemIdFromLink(itemLink)) or 0;

            -- Double checking just in case!
            if (not GL:higherThanZero(itemId)) then
                return;
            end

            -- Make sure we're dealing with an actual item here, not currency for example
            if (lootType ~= LOOT_SLOT_ITEM) then
                return;
            end

            if ((
                    quality < GL.Settings:get("DroppedLoot.minimumQualityOfAnnouncedLoot", 4) -- Quality is lower than our set minimum
                    or GL:inTable(Constants.ItemsThatSouldntBeAnnounced, itemId) -- We don't want to announce this item
                )
                and GL:empty(SoftReserves) -- No one (hard)reserved it
                and GL:empty(TMBInfo) -- No one has it on his wishlist and it's not a prio item
            ) then
                return;
            end

            -- Fetch the applicable SoftRes data (if any)
            local ActiveSoftResDetails = {};
            itemIsHardReserved = SoftRes:linkIsHardReserved(itemLink);
            if (not itemIsHardReserved -- Only fetch the SoftRes data if the item isn't hard-reserved
                and not GL:empty(SoftReserves) -- This item wasn't reserved
                and GL.Settings:get("SoftRes.announceInfoInChat") -- The player isn't interested in SoftRes data
            ) then
                ActiveSoftResDetails = self:getSoftResDetails(SoftReserves);
            end

            -- Determine the correct channel for announcing the loot
            -- Both GROUP and RAID_WARNING will default to PARTY if not in a raid or if you don't have assist
            local channel = "GROUP";
            if (GL.Settings:get("DroppedLoot.announceDroppedLootInRW")) then
                channel = "RAID_WARNING";
            end

            -- Either announce the item by itself or state that it's hard-reserved!
            if (itemIsHardReserved
                and GL.Settings:get("SoftRes.announceInfoInChat")
            ) then
                GL:sendChatMessage(
                    itemLink .. " (This item is hard-reserved!)",
                    channel
                );
            else
                -- Link the item in the chat for
                -- all group members to see
                GL:sendChatMessage(
                    itemLink,
                    channel
                );
            end

            --[[
                SHOW WHO RESERVED THIS ITEM (SOFTRES)
            ]]
            -- * This data is only available if the user has the announce SoftRes setting enabled
            if (not GL:empty(ActiveSoftResDetails)) then
                GL:sendChatMessage(
                    "Reserved by: " .. table.concat(ActiveSoftResDetails, ", "),
                    "GROUP"
                );
            end

            -- Fetch the applicable TMB data (if any)
            local ActiveWishListDetails = {};
            local ActivePrioListDetails = {};
            local maximumNumberOfAnnouncementEntries = GL.Settings:get("TMB.maximumNumberOfAnnouncementEntries", 5);
            if (TMBInfo and (
                GL.Settings:get("TMB.includePrioListInfoInLootAnnouncement")
                or GL.Settings:get("TMB.includeWishListInfoInLootAnnouncement")
            )) then
                ActivePrioListDetails, ActiveWishListDetails = self:getTMBDetails(TMBInfo, PlayersInRaid);
            end
            local itemIsOnSomeonesPriolist = not GL:empty(ActivePrioListDetails);
            local itemIsOnSomeonesWishlist = not GL:empty(ActiveWishListDetails);

            --[[
                SHOW WHO HAS PRIORITY ON THIS ITEM (TMB)
            ]]
            if (itemIsOnSomeonesPriolist
                and GL.Settings:get("TMB.includePrioListInfoInLootAnnouncement")
            ) then
                -- Sort the PrioListEntries based on prio (lowest to highest)
                table.sort(ActivePrioListDetails, function (a, b)
                    return a.order < b.order;
                end);

                local entries = 0;
                local entryString = "";
                for _, Entry in pairs(ActivePrioListDetails) do
                    entries = entries + 1;

                    -- Add the player to the list (first entry should not start with a comma)
                    if (GL:empty(entryString)) then
                        entryString = GL:capitalize(Entry.player);
                    else
                        entryString = entryString .. ", " .. GL:capitalize(Entry.player);
                    end

                    -- The user only wants to see a limited number of entries, break!
                    if (entries >= maximumNumberOfAnnouncementEntries) then
                        break;
                    end
                end

                local source = "TMB";
                if (GL.TMB:wasImportedFromDFT()) then
                    source = "DFT";
                end

                GL:sendChatMessage(
                    source .. " Priority: " .. entryString,
                    "GROUP"
                );
            end

            --[[
                SHOW WHO WISHLISTED THIS ITEM (TMB)
            ]]
            if (itemIsOnSomeonesWishlist
                and GL.Settings:get("TMB.includeWishListInfoInLootAnnouncement")
                and (not itemIsOnSomeonesPriolist
                    or not GL.Settings:get("TMB.hideWishListInfoIfPriorityIsPresent")
                )
            ) then
                -- Sort the WishListEntries based on prio (lowest to highest)
                table.sort(ActiveWishListDetails, function (a, b)
                    return a.order < b.order;
                end);

                local entries = 0;
                local entryString = "";
                for _, Entry in pairs(ActiveWishListDetails) do
                    entries = entries + 1;

                    -- Add the player to the list (first entry should not start with a comma)
                    if (GL:empty(entryString)) then
                        entryString = GL:capitalize(Entry.player);
                    else
                        entryString = entryString .. ", " .. GL:capitalize(Entry.player);
                    end

                    -- The user only wants to see a limited number of entries, break!
                    if (entries >= maximumNumberOfAnnouncementEntries) then
                        break;
                    end
                end

                GL:sendChatMessage(
                    "TMB Wishlist: " .. entryString,
                    "GROUP"
                );
            end
        end)();
    end

    -- This ensures that we don't announce the same loot multiple times!
    -- Keep in mind that sourceGUID can be empty!
    if (sourceGUID) then
        DroppedLoot.Announced[sourceGUID] = true;
    end
end

--- Get all SoftRes details
---
---@return table
function DroppedLoot:getSoftResDetails(SoftReserves)
    local ActiveSoftResDetails = {};

    local ReservationsByPlayerName = {};
    for _, playerName in pairs(SoftReserves) do
        if (not ReservationsByPlayerName[playerName]) then
            ReservationsByPlayerName[playerName] = 1;
        else
            ReservationsByPlayerName[playerName] = ReservationsByPlayerName[playerName] + 1;
        end
    end

    -- This is necessary so we can sort the table based on number of reserves per item
    local Reservations = {};
    for playerName, reservations in pairs(ReservationsByPlayerName) do
        tinsert(Reservations, {
            player = playerName,
            reservations = reservations,
        })
    end
    ReservationsByPlayerName = {}; -- We no longer need this table, clean it up!

    -- Sort the reservations based on whoever reserved it more often (highest to lowest)
    table.sort(Reservations, function (a, b)
        return a.reservations > b.reservations;
    end);

    -- Add the reservation details to ActiveReservations (add 2x / 3x etc when same item was reserved multiple times)
    for _, Entry in pairs(Reservations) do
        local entryString = Entry.player;

        -- User reserved the same item multiple times
        if (Entry.reservations > 1) then
            entryString = string.format("%s (%sx)", Entry.player, Entry.reservations);
        end

        tinsert(ActiveSoftResDetails, GL:capitalize(entryString));
    end

    return ActiveSoftResDetails;
end

--- Get all TMB details
---
---@return table, table
function DroppedLoot:getTMBDetails(TMBInfo, PlayersInRaid)
    local ActivePrioListDetails = {};
    local ActiveWishListDetails = {};

    -- Make sure we only show wishlist details of people
    -- Who are actually in the raid
    for _, Entry in pairs(TMBInfo) do
        local playerName = string.lower(Entry.character);

        --- NOTE TO SELF: it's (os) because of the string.lower, if you remove the lower then change below accordingly!
        if (GL:inTable(PlayersInRaid, string.gsub(playerName, "%(os%)", ""))) then
            local prio = Entry.prio;
            local entryType = Entry.type or Constants.tmbTypeWish;
            local isOffSpec = string.find(playerName, "%(os%)");
            local prioOffset = 0;
            local sortingOrder = tonumber(prio);

            -- We add 100 to the prio (first key) of the object
            -- This object is used for sorting later and is not visible to the player
            if (isOffSpec) then
                prioOffset = 100;
            end

            if (not GL:empty(sortingOrder)) then
                sortingOrder = prio + prioOffset;
            else
                -- If for whatever reason we can't determine the
                -- item prio then we add it to the end of the list by default
                sortingOrder = 1000;
            end

            if (entryType == Constants.tmbTypePrio) then
                tinsert(ActivePrioListDetails, {
                    order = sortingOrder,
                    player = string.format("%s[%s]", playerName, prio),
                });
            else
                tinsert(ActiveWishListDetails, {
                    order = sortingOrder,
                    player = string.format("%s[%s]", playerName, prio),
                });
            end
        end
    end

    return ActivePrioListDetails, ActiveWishListDetails;
end

--- This function allows me to test the loot announcement without actually having to kill bosses in raids
--- It also enables me to debug issues other players may have using their actual TMB/SoftRes data
---
---@return void
function DroppedLoot:announceTest(...)
    local itemIDs = ...;

    if (type(itemIDs) ~= "table") then
        itemIDs = {itemIDs};
    end

    -- Make sure all item links are translated to IDs
    for key, value in pairs(itemIDs) do
        value = string.trim(value);
        local concernsID = GL:higherThanZero(tonumber(value));

        if (not concernsID) then
            value = GL:getItemIdFromLink(value) or 0;
        end

        itemIDs[key] = value;
    end

    GL:onItemLoadDo(itemIDs, function (Items)
        self:announce({
            Functions = {
                GetNumLootItems = function () return GL:count(Items); end,
                GetLootSlotInfo = function (slot)
                    local SlotItem = Items[slot];

                    return SlotItem.icon, SlotItem.name, 1, nil, SlotItem.quality, false, false, nil, true;
                end,
                GetLootSlotLink = function (slot)
                    return Items[slot].link or nil;
                end,
                GetLootSlotType = function(slot)
                    local itemLink = Items[slot].link or "";

                    if (GL:strContains(itemLink, "Hcurrency:")) then
                        return LOOT_SLOT_CURRENCY;
                    end

                    return LOOT_SLOT_ITEM;
                end,
                GetLootSourceInfo = function() return GL:uuid() end,
            }
        });
    end);
end

GL:debug("DroppedLoot.lua");