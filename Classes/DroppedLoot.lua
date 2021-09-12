---@type GL
local _, GL = ...;

---@class DroppedLoot
GL.DroppedLoot = {
    Announced = {},
    initialized = false,
    eventsHooked = false,
    LootButtonItemLinkCache = {},
    lootChangedTimer = 0,
    lootWindowIsOpened = false,
}

local Constants = GL.Data.Constants; ---@type Data
local DroppedLoot = GL.DroppedLoot; ---@type DroppedLoot
local Events = GL.Events; ---@type Events
local SoftRes = GL.SoftRes; ---@type SoftRes
local LCG = LibStub("LibCustomGlow-1.0");

---@return boolean
function DroppedLoot:_init()
    GL:debug("DroppedLoot:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return false;
    end

    -- Fire DroppedLoot:lootReady every time a loot window is opened
    Events:register("DroppedLootLootOpenedListener", "LOOT_OPENED", function () self:lootOpened(); end);

    -- Make sure to keep track of the loot window status
    Events:register("DroppedLootLootClosedListener", "LOOT_CLOSED", function ()
        DroppedLoot.lootWindowIsOpened = false;

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
function DroppedLoot:lootOpened()
    GL:debug("DroppedLoot:lootOpened");

    self.lootWindowIsOpened = true;

    self:lootChanged();
    Events:fire("GL.LOOT_CHANGED");
    self:hookClickEvents();

    -- Periodically check if the loot changed because the internal WoW events are not
    -- comprehensive enough to detect things like the player moving to the next page of items.
    self.lootChangedTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        if (self:lootChanged()) then
            Events:fire("GL.LOOT_CHANGED");
        end
    end, .1);

    -- Only announce loot in chat if the setting is enabled
    if (GL.User.isMasterLooter
        and GL.Settings:get("announceLootToChat")
    ) then
        -- We give the announcing of loot some time
        -- in case the master looter set up a packmule
        GL.Ace:ScheduleTimer(function ()
            self:announce();
        end, .5);
    end
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
                    ) then
                        enableHighlight = true;
                        BorderColor = {.95686, .5490, .72941, 1}; -- Make the border paladin-pink for reserved items

                    -- Check if it's wishlisted/priolisted
                    elseif (GL.Settings:get("highlightWishlistedItems")
                        or GL.Settings:get("highlightPriolistedItems")
                    ) then
                        local TMBInfo = GL.TMB:byItemLink(itemLink) or {};
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

    if (DroppedLoot.eventsHooked) then
        return;
    end

    -- 4 is the max since buttons seem to be reused
    -- throughout loot pages... thanks Blizzard
    for buttonIndex = 1, _G.LOOTFRAME_NUMBUTTONS do
        local Button = getglobal("LootButton" .. buttonIndex);

        Button:HookScript("OnClick", function(_, mouseButtonPressed)
            local itemLink = GetLootSlotLink(Button.slot);

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
    end

    DroppedLoot.eventsHooked = true;
end

-- Announce the loot that dropped in the party or raid chat
function DroppedLoot:announce()
    GL:debug("DroppedLoot:announce");

    -- Fetch the name of everyone currently in the raid/party
    local PlayersInRaid = GL.User:groupMemberNames();

    -- Get the total number of items that dropped
    local sourceGUID;
    local itemCount = GetNumLootItems();
    for lootIndex = 1, itemCount do
        local itemLink = GetLootSlotLink(lootIndex);
        local itemIsHardReserved = false;
        local SoftReserves = SoftRes:byItemLink(itemLink);
        local TMBInfo = GL.TMB:byItemLink(itemLink);

        local quality = select(5, GetLootSlotInfo(lootIndex));
        sourceGUID = GetLootSourceInfo(lootIndex);

        if (itemLink
            and (sourceGUID
                and not DroppedLoot.Announced[sourceGUID] -- This is to make sure we didn't announce the items already
            ) and (
                (quality and quality >= GL.Settings:get("minimumQualityOfAnnouncedLoot", 4))
                or not GL:empty(SoftReserves)
                or not GL:empty(TMBInfo)
            )
        ) then
            itemIsHardReserved = SoftRes:linkIsHardReserved(itemLink);
            local ActiveSoftResDetails = {};
            local ActiveWishListDetails = {};
            local ActivePrioListDetails = {};
            local itemIsOnSomeonesPriolist = false;
            local itemIsOnSomeonesWishlist = false;

            if (not itemIsHardReserved
                and SoftReserves
                and GL.Settings:get("SoftRes.announceInfoInChat")
            ) then
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
            end

            if (TMBInfo
                and (
                    GL.Settings:get("TMB.includePrioListInfoInLootAnnouncement")
                    or GL.Settings:get("TMB.includeWishListInfoInLootAnnouncement")
                )
            ) then
                -- Make sure we only show wishlist details of people
                -- Who are actually in the raid
                for _, Entry in pairs(TMBInfo) do
                    local playerName = string.lower(Entry.character);

                    --- NOTE TO SELF: it's (os) because of the string.lower, if you remove the lower then change below accordingly!
                    if (GL:inTable(PlayersInRaid, string.gsub(playerName, "%(os%)", ""))) then
                        local prio = Entry.prio;
                        local entryType = Entry.type or Constants.tmbTypeWish;
                        local isOffSpec = string.find(playerName, "(os)");
                        local prioOffset = 0;
                        local sortingOrder = prio;

                        -- We add 100 to the prio (first key) of the object
                        -- This object is used for sorting later and is not visible to the player
                        if (isOffSpec) then
                            prioOffset = 100;
                        end

                        if (type(sortingOrder) == "number") then
                            sortingOrder = prio + prioOffset;
                        else
                            -- If for whatever reason we can't determine the
                            -- item prio then we add it to the end of the list by default
                            sortingOrder = 1000;
                        end

                        if (entryType == Constants.tmbTypePrio) then
                            tinsert(ActivePrioListDetails, { sortingOrder, string.format("%s[%s]", playerName, prio)});
                            itemIsOnSomeonesPriolist = true;
                        else
                            tinsert(ActiveWishListDetails, { sortingOrder, string.format("%s[%s]", playerName, prio)});
                            itemIsOnSomeonesWishlist = true;
                        end
                    end
                end
            end

            local chatChannel = "PARTY";
            if (GL.User.isInRaid) then
                chatChannel = "RAID";
            end

            if (itemIsHardReserved
                and GL.Settings:get("SoftRes.announceInfoInChat")
            ) then
                GL:sendChatMessage(
                    itemLink .. " (This item is hard-reserved!)",
                    chatChannel
                );
            else
                -- Link the item in the chat for
                -- all group members to see
                GL:sendChatMessage(
                    itemLink,
                    chatChannel
                );
            end

            -- Show who reserved this item
            if (not GL:empty(ActiveSoftResDetails)) then
                GL:sendChatMessage(
                    "Reserved by: " .. table.concat(ActiveSoftResDetails, ", "),
                    chatChannel
                );
            end

            -- Show who has priority on this item
            if (itemIsOnSomeonesPriolist
                and GL.Settings:get("TMB.includePrioListInfoInLootAnnouncement")
            ) then
                -- Sort the PrioListEntries based on prio (lowest to highest)
                table.sort(ActivePrioListDetails, function (a, b)
                    return a[1] < b[1];
                end);

                local PrioData = {};
                for _, Entry in pairs(ActivePrioListDetails) do
                    tinsert(PrioData, GL:capitalize(Entry[2]));
                end

                GL:sendChatMessage(
                    "TMB Priority: " .. table.concat(PrioData, ", "),
                    chatChannel
                );
            end

            -- Show who wishlisted this item
            if (itemIsOnSomeonesWishlist
                and GL.Settings:get("TMB.includeWishListInfoInLootAnnouncement")
                and (not itemIsOnSomeonesPriolist
                    or not GL.Settings:get("TMB.hideWishListInfoIfPriorityIsPresent")
                )
            ) then
                -- Sort the WishListEntries based on prio (lowest to highest)
                table.sort(ActiveWishListDetails, function (a, b)
                    return a[1] < b[1];
                end);

                local WishListData = {};
                for _, Entry in pairs(ActiveWishListDetails) do
                    tinsert(WishListData, GL:capitalize(Entry[2]));
                end

                GL:sendChatMessage(
                    "TMB Wishlist: " .. table.concat(WishListData, ", "),
                    chatChannel
                );
            end
        end
    end

    -- This ensures that we don't announce the same loot multiple times!
    -- Keep in mind that sourceGUID can be empty for some items!
    if (sourceGUID) then
        DroppedLoot.Announced[sourceGUID] = true;
    end
end

GL:debug("DroppedLoot.lua");