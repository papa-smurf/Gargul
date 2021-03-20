local _, App = ...;

App.DroppedLoot = {
    initialized = false,
    eventsHooked = false,
    Announced = {},
}

local Utils = App.Utils;
local DroppedLoot = App.DroppedLoot;

function DroppedLoot:_init()
    Utils:debug("DroppedLoot:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- Fire DroppedLoot:lootReady every time a loot window is opened
    App.Events:register("DroppedLootLootReadyListener", "LOOT_OPENED", DroppedLoot.LOOT_OPENED);

    self._initialized = true;
end

-- Fired when a loot window is opened
function DroppedLoot:LOOT_OPENED()
    Utils:debug("DroppedLoot:LOOT_OPENED");

    if (not App.User.isInGroup
            or not (App.User.isMasterLooter)
    ) then
        return;
    end

    DroppedLoot:hookClickEvents();

    -- Only announce loot in chat if the setting is enabled
    if (App.Settings:get("announceLootToChat")) then
        DroppedLoot:announce();
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

                -- Open the auctioneer window if both alt and shift are pressed
                if (IsShiftKeyDown()) then
                    App.AuctioneerUI:draw(itemLink);
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

        local quality = select(5, GetLootSlotInfo(lootIndex));
        sourceGUID = GetLootSourceInfo(lootIndex);

        if (itemLink
            and (
                sourceGUID
                and not DroppedLoot.Announced[sourceGUID]
            ) and (
                (quality and quality >= 4)
                or softReserves
            )
        ) then
            local activeSoftReserves = {};
            local hasSoftReserves = false;

            if (softReserves
                and App.Settings:get("includeSoftReservesInLootAnnouncement")
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
        end
    end

    -- This ensures that we don't announce the same loot multiple times!
    -- Keep in mind that sourceGUID can be empty for some items!
    if (sourceGUID) then
        DroppedLoot.Announced[sourceGUID] = true;
    end
end

Utils:debug("DroppedLoot.lua");