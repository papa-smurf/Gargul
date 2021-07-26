local _, App = ...;

App.GroupLoot = {
    _initialized = false,
    ProcessedRollIds = {},
}

local LCG = LibStub("LibCustomGlow-1.0");
local User = App.User;
local Utils = App.Utils;

local GroupLoot = App.GroupLoot;

function GroupLoot:_init()
    Utils:debug("GroupLoot:_init");

    if (self._initialized) then
        return;
    end

    App.Events:register("GroupLootStartLootRollListener", "START_LOOT_ROLL", GroupLoot.highlightItemsOfInterest);

    self._initialized = true;
end

-- Fired whenever a loot roll is started (only applicable to group loot)
-- The purpose of this handler is to add a glowing border to the item
-- frames of dropped loot in case it's SRed or otherwise marked on someone's list
function GroupLoot:highlightItemsOfInterest()
    Utils:debug("GroupLoot:highlightItemsOfInterest");

    for itemIndex = 1, _G.NUM_GROUP_LOOT_FRAMES do
        local ItemFrame = getglobal("GroupLootFrame" .. itemIndex);
        LCG.PixelGlow_Stop(ItemFrame);

        if (ItemFrame:IsVisible()) then
            local rollId = ItemFrame.rollID;
            local itemLink = GetLootRollItemLink(rollId);

            if (itemLink) then
                local SoftReserves = App.SoftReserves:getSoftReservesByItemLink(itemLink);
                local TMBInfo = App.TMB:getTMBInfoByItemLink(itemLink);

                if (SoftReserves or TMBInfo) then
                    -- Add an animated border to indicate that this item was reserved / wishlisted
                    LCG.PixelGlow_Start(ItemFrame, {0.95, 0.95, 0.32, 1}, 32, .05, 10, 4);
                end
            end
        end
    end
end

Utils:debug("GroupLoot.lua");