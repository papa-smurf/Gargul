--[[
    This class lets the master looter keep track of
	who was awarded what item. This is especially useful
	for master looters who bring items with them and do
	the rolling along the way.
]]

local _, App = ...;

App.AwardedLoot = {
    initialized = false,

    AwardHistory = {},
};

local Utils = App.Utils;
local AwardedLoot = App.AwardedLoot;

function AwardedLoot:_init()
    Utils:debug("AwardedLoot:_init");

    if (self._initialized) then
        return;
    end

    -- Bind the appendAwardedLootToTooltip method to the OnTooltipSetItem event
    GameTooltip:HookScript("OnTooltipSetItem", function(tooltip)
        self:appendAwardedLootToTooltip(tooltip);
    end);

    self._initialized = true;
end

-- Append the players this item was awarded to to the tooltip
function AwardedLoot:appendAwardedLootToTooltip(tooltip)
    Utils:debug("AwardedLoot:appendAwardedLootToTooltip");

    -- No tooltip was provided
    if (not tooltip) then
        return;
    end

    local _, itemLink = tooltip:GetItem();

    -- We couldn't find an itemLink (this can actually happen!)
    if (not itemLink) then
        return;
    end

    local awardedTo = table.concat(Utils:tableGet(self.AwardHistory, itemLink, {}), ", ");

    if (not awardedTo
        or type(awardedTo) ~= "string"
        or awardedTo == ""
    ) then
        return;
    end

    -- Add the header
    tooltip:AddLine(string.format("\n|c00efb8cd%s|r", "Awarded To"));

    -- Add the actual award info
    tooltip:AddLine(string.format("|c008aecff %s|r", awardedTo));
end

-- Add a winner for a specific item to the AwardHistory table
function AwardedLoot:addWinner(winner, itemLink)
    Utils:debug("AwardedLoot:addWinner");

    if (not itemLink or type(itemLink) ~= "string" or itemLink == ""
        or not winner or type(winner) ~= "string" or winner == ""
    ) then
        return;
    end

    local AwardHistory = Utils:tableGet(self.AwardHistory, itemLink, {});
    tinsert(AwardHistory, winner);
    self.AwardHistory[itemLink] = AwardHistory;
end

Utils:debug("AwardedLoot.lua");