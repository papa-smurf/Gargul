local _, App = ...;

App.DroppedLoot = {
    lootWindowIsOpened = false,
    initialized = false,
    eventsHooked = false,
    Announced = {},
}

local Constants = App.Data.Constants;
local Utils = App.Utils;
local DroppedLoot = App.DroppedLoot;

function DroppedLoot:_init()
    Utils:debug("DroppedLoot:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- Fire DroppedLoot:lootReady every time a loot window is opened
    App.Events:register("DroppedLootLootReadyListener", "LOOT_OPENED", DroppedLoot.lootOpened);

    -- Make sure to keep track of the loot window status
    App.Events:register("DroppedLootLootClosedListener", "LOOT_CLOSED", function ()
        DroppedLoot.lootWindowIsOpened = false;
    end);

    self._initialized = true;
end

-- Fired when a loot window is opened
function DroppedLoot:lootOpened()
    Utils:debug("DroppedLoot:lootOpened");

    DroppedLoot.lootWindowIsOpened = true;

    if (not App.User.isInGroup
        or not (App.User.isMasterLooter)
    ) then
        return;
    end

    DroppedLoot:hookClickEvents();

    -- Only announce loot in chat if the setting is enabled
    if (App.Settings:get("announceLootToChat")) then
        -- We give the announcing of loot some time
        -- in case the master looter set up a packmule
        App.Ace:ScheduleTimer(function ()
            DroppedLoot:announce();
        end, .5);
    end
end

-- Hook click events to the item buttons in the
-- loot window (name LootButton1 through LoootButton4)
-- Only 4 buttons will be used regardless of number of drops
-- Alt click opens the roll window, alt + shift opens the auctioneer window
function DroppedLoot:hookClickEvents()
    Utils:debug("DroppedLoot:hookClickEvents");

    if (DroppedLoot.eventsHooked) then
        return;
    end

    -- 4 is the max since buttons seem to be reused
    -- throughout loot pages... thanks Blizzard
    for buttonIndex = 1, LOOTFRAME_NUMBUTTONS do
        local Button = getglobal("LootButton" .. buttonIndex);

        Button:HookScript("OnClick", function()
            if (IsAltKeyDown()) then
                Utils:debug("DroppedLoot:hookClickEvents. Alt click LootButton");

                local itemLink = GetLootSlotLink(Button.slot);

                if (not itemLink or type(itemLink) ~= "string") then
                    return;
                end

                -- Open the award window if both alt and shift are pressed
                if (IsShiftKeyDown()) then
                    App.AwardUI:draw(itemLink);

                -- Open the default roll window
                else
                    App.MasterLooterUI:draw(itemLink);
                end
            end
        end);
    end

    DroppedLoot.eventsHooked = true;
end

-- Announce the loot that dropped in the party or raid chat
function DroppedLoot:announce()
    Utils:debug("DroppedLoot:announce");

    local playersInRaids = {};
    -- Fetch the name of everyone currently in the raid/party
    for _, player in pairs(App.User:groupMembers()) do
        tinsert(playersInRaids, player.name);
    end

    -- Get the total number of items that dropped
    local sourceGUID;
    local itemCount = GetNumLootItems();
    for lootIndex = 1, itemCount do
        local itemLink = GetLootSlotLink(lootIndex);
        local softReserves = App.SoftReserves:getSoftReservesByItemLink(itemLink);
        local TMBInfo = App.TMB:getTMBInfoByItemLink(itemLink);

        local quality = select(5, GetLootSlotInfo(lootIndex));
        sourceGUID = GetLootSourceInfo(lootIndex);

        if (itemLink
            and (
                sourceGUID
                and not DroppedLoot.Announced[sourceGUID]
            ) and (
                (quality and quality >= App.Settings:get("minimumQualityOfAnnouncedLoot", 4))
                or softReserves
                or TMBInfo
            )
        ) then
            local activeSoftReserves = {};
            local activeWishListDetails = {};
            local activePrioListDetails = {};
            local hasSoftReserves = false;
            local itemIsOnSomeonesPriolist = false;
            local itemIsOnSomeonesWishlist = false;

            if (softReserves
                and App.Settings:get("TMB.includeSoftReservesInLootAnnouncement")
            ) then
                -- Make sure we only show shoft reserves of people
                -- Who are actually in the raid
                for _, player in pairs(softReserves) do
                    if (Utils:inArray(playersInRaids, player)) then
                        tinsert(activeSoftReserves, player);
                        hasSoftReserves = true;
                    end
                end
            end

            if (TMBInfo
                and (
                    App.Settings:get("TMB.includePrioListInfoInLootAnnouncement")
                    or App.Settings:get("TMB.includeWishListInfoInLootAnnouncement")
                )
            ) then

                -- Make sure we only show wishlist details of people
                -- Who are actually in the raid
                for _, Entry in pairs(TMBInfo) do
                    local playerName = Entry.character;

                    if (Utils:inArray(playersInRaids, string.gsub(playerName, "(OS)", ""))) then
                        local prio = Entry.prio;
                        local type = Entry.type or Constants.tmbTypeWish;
                        local isOffSpec = string.find(playerName, "(OS)");
                        local prioOffset = 0;

                        -- We add 100 to the prio (first key) of the object
                        -- This object is used for sorting later and is not visible to the player
                        if (isOffSpec) then
                            prioOffset = 100;
                        end

                        if (type == Constants.tmbTypePrio) then
                            tinsert(activePrioListDetails, {prio + prioOffset, string.format("%s[%s]", playerName, prio)});
                            itemIsOnSomeonesPriolist = true;
                        else
                            tinsert(activeWishListDetails, {prio + prioOffset, string.format("%s[%s]", playerName, prio)});
                            itemIsOnSomeonesWishlist = true;
                        end
                    end
                end
            end

            local chatChannel = "PARTY";
            if (App.User.isInRaid) then
                chatChannel = "RAID";
            end

            -- Link the item in the chat for
            -- all group members to see
            SendChatMessage(
                itemLink,
                chatChannel,
                "COMMON"
            );

            -- Show who softreserved this item
            if (hasSoftReserves) then
                SendChatMessage(
                    "Reserved by: " .. table.concat(activeSoftReserves, ", "),
                    chatChannel,
                    "COMMON"
                );
            end

            -- Show who has priority on this item
            if (itemIsOnSomeonesPriolist
                and App.Settings:get("TMB.includePrioListInfoInLootAnnouncement")
            ) then
                -- Sort the PrioListEntries based on prio (lowest to highest)
                table.sort(activePrioListDetails, function (a, b)
                    return a[1] < b[1];
                end);

                local PrioData = {};
                for _, Entry in pairs(activePrioListDetails) do
                    tinsert(PrioData, Entry[2]);
                end

                SendChatMessage(
                    "TMB Priority: " .. table.concat(PrioData, ", "),
                    chatChannel,
                    "COMMON"
                );
            end

            -- Show who wishlisted this item
            if (itemIsOnSomeonesWishlist
                and App.Settings:get("TMB.includeWishListInfoInLootAnnouncement")
                and (not itemIsOnSomeonesPriolist
                    or not App.Settings:get("TMB.hideWishListInfoIfPriorityIsPresent")
                )
            ) then
                -- Sort the WishListEntries based on prio (lowest to highest)
                table.sort(activeWishListDetails, function (a, b)
                    return a[1] < b[1];
                end);

                local WishListData = {};
                for _, Entry in pairs(activeWishListDetails) do
                    tinsert(WishListData, Entry[2]);
                end

                SendChatMessage(
                    "TMB Wishlist: " .. table.concat(WishListData, ", "),
                    chatChannel,
                    "COMMON"
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

Utils:debug("DroppedLoot.lua");