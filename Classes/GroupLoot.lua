---@type GL
local _, GL = ...;

---@class GroupLoot
GL.GroupLoot = {
    _initialized = false,
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
    if (not GL.Settings:get("highlightsEnabled")
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

        if (not GL.isRetail) then
            LCG.PixelGlow_Stop(ItemFrame);
        end

        if (ItemFrame:IsVisible() and ItemFrame.rollID) then
            local itemLink = GetLootRollItemLink(ItemFrame.rollID);

            GL:highlightItem(ItemFrame, itemLink);
        end
    end
end

GL:debug("GroupLoot.lua");