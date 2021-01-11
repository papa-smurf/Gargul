local _, App = ...;

App.DroppedLoot = {
    initialized = false,
    Announced = {},
}

local DroppedLoot = App.DroppedLoot;

function DroppedLoot:_init()
    App:debug("DroppedLoot:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- Fire DroppedLoot:announce every time a loot window is opened
    DroppedLoot.eventFrame = CreateFrame("FRAME");
    DroppedLoot.eventFrame:RegisterEvent("LOOT_OPENED");
    DroppedLoot.eventFrame:SetScript("OnEvent", DroppedLoot.announce);

    self._initialized = true;
end

function DroppedLoot:announce()
    App:debug("DroppedLoot:announce");

    -- Only announce loot if the current user
    -- is in a group and is the master looter
    if (not App.User.isInGroup
        or not (App.User.isMasterLooter)
    ) then
        return;
    end

    local playersInRaids = {};
    -- Fetch the name of everyone currently in the raid/party
    for _, player in pairs(App.User.GroupMembers) do
        tinsert(playersInRaids, player.name);
    end

    -- Get the total number of item that dropped
    local itemCount = GetNumLootItems();
    for lootIndex = 1, itemCount do
        local itemLink = GetLootSlotLink(lootIndex);
        local softReserves = App.SoftReserves:getSoftReservesByItemLink(itemLink);

        local quality = select(5, GetLootSlotInfo(lootIndex));
        local sourceGUID = GetLootSourceInfo(lootIndex);

        if (itemLink
            and not DroppedLoot.Announced[sourceGUID]
            and (
                (quality and quality >= 4)
                or softReserves
            )
        ) then
            local activeReserves = {};

            -- Make sure we only show shoft reserves of people
            -- Who are actually in the raid
            for _, player in pairs(softReserves) do
                if (App:inArray(playersInRaids, player)) then
                    tinsert(activeReserves, player);
                end
            end

            if (App.User.isInRaid) then
                SendChatMessage(
                    itemLink,
                    "RAID",
                    "COMMON"
                );

                if (activeReserves) then
                    SendChatMessage(
                        "Reserved by: " .. table.concat(activeReserves, ", "),
                        "RAID",
                        "COMMON"
                    );
                end
            else
                SendChatMessage(
                    itemLink,
                    "PARTY",
                    "COMMON"
                );

                if (activeReserves) then
                    SendChatMessage(
                        "Reserved by: " .. table.concat(activeReserves, ", "),
                        "PARTY",
                        "COMMON"
                    );
                end
            end
        end

        -- This ensures that we don't announced the same loot multiple times!
        DroppedLoot.Announced[sourceGUID] = true;
    end
end

App:debug("DroppedLoot.lua");