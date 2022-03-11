---@type GL
local _, GL = ...;

---@class GroupLoot
GL.GroupLoot = {
    _initialized = false,
    ProcessedRollIds = {},
}

local Constants = GL.Data.Constants; ---@type Data
local LCG = LibStub("LibCustomGlowGargul-1.0");
local SoftRes = GL.SoftRes; ---@type SoftRes

local GroupLoot = GL.GroupLoot; ---@type GroupLoot

---@return boolean
function GroupLoot:_init()
    GL:debug("GroupLoot:_init");

    if (self._initialized) then
        return false;
    end

    -- Whenever an item drops that is eligible for rolling on we trigger the highlighter method
    GL.Events:register("GroupLootStartLootRollListener", "START_LOOT_ROLL", function () self:highlightItemsOfInterest(); end);

    self._initialized = true;
    return true;
end

--- Fired whenever a loot roll is started (only applicable to group loot)
--- The purpose of this handler is to add a glowing border to the item frames
--- of dropped loot in case it's SRed or otherwise marked on someone's list
---
---@return void
function GroupLoot:highlightItemsOfInterest()
    GL:debug("GroupLoot:highlightItemsOfInterest");

    -- Check if the player disabled the highlighting of items
    if (GL.Settings:get("highlightsDisabled")
        or (
            not GL.Settings:get("highlightHardReservedItems")
            and not GL.Settings:get("highlightSoftReservedItems")
            and not GL.Settings:get("highlightWishlistedItems")
            and not GL.Settings:get("highlightPriolistedItems")
        )
    ) then
        return;
    end

    for itemIndex = 1, _G.NUM_GROUP_LOOT_FRAMES do
        local ItemFrame = getglobal("GroupLootFrame" .. itemIndex);
        LCG.PixelGlow_Stop(ItemFrame);

        if (ItemFrame:IsVisible()) then
            local rollId = ItemFrame.rollID;
            local itemLink = GetLootRollItemLink(rollId);

            if (itemLink) then
                local enableHighlight = false;
                local BorderColor = {1, .95686, .40784, 1}; -- The default border color is rogue-yellow and applies to wishlisted items

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

                -- Check if it's wishlisted
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
                    LCG.PixelGlow_Start(ItemFrame, BorderColor, 32, .05, 10, 4);
                end
            end
        end
    end
end

GL:debug("GroupLoot.lua");