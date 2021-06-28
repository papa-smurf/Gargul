--[[
    This class lets the master looter keep track of
	who was awarded what item. This is especially useful
	for master looters who bring items with them and do
	the rolling along the way.
]]

local _, App = ...;

App.AwardedLoot = {
    initialized = false,
    AwardedThisSession = {},
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

    -- No tooltip was provided or the user is not in a party/raid
    if (not tooltip or not App.User.isInParty) then
        return;
    end

    local _, itemLink = tooltip:GetItem();

    -- We couldn't find an itemLink (this can actually happen!)
    if (not itemLink) then
        return;
    end

    local awardedTo = table.concat(AwardedLoot.AwardedThisSession, ", ");

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

-- Add a winner for a specific item to the SessionHistory table
function AwardedLoot:addWinner(winner, itemLink, dkp, announce)
    Utils:debug("AwardedLoot:addWinner");

    if (not winner or type(winner) ~= "string" or winner == "") then
        return Utils:debug("Invalid winner provided for AwardedLoot:addWinner");
    end

    if (not itemLink or type(itemLink) ~= "string" or itemLink == "") then
        return Utils:debug("Invalid itemLink provided for AwardedLoot:addWinner");
    end

    local itemId = Utils:getItemIdFromLink(itemLink);

    if (not itemId) then
        return Utils:debug("Invalid itemLink provided for AwardedLoot:addWinner");
    end

    -- Enable the announce switch by default
    if (type(announce) ~= "boolean") then
        announce = true;
    end

    -- Insert the award in the SessionHistory table used for rendering tooltips
    local SessionHistory = Utils:tableGet(AwardedLoot.AwardedThisSession, itemLink, {});
    tinsert(SessionHistory, winner);
    AwardedLoot.AwardedThisSession[itemLink] = winner;

    local AwardEntry = {
            itemLink = itemLink,
            itemId = itemId,
            awardedTo = winner,
            timestamp = GetServerTime()
        };

    -- Insert the award in the more permanent AwardHistory table (for export / audit purposes)
    tinsert(App.DB.AwardHistory, AwardEntry);

    if (announce) then
        awardMessage = string.format("%s was awarded to %s. Congrats!",
            itemLink,
            winner,
            dkp
        );

        local publicChannel = "PARTY";
        if (App.User.isInRaid) then
            publicChannel = "RAID";
        end

        if (type(dkp) == 'number' and dkp > 0) then
            awardMessage = string.format("%s awarded to %s for %s DKP. Congrats!",
                itemLink,
                winner,
                dkp
            );

            SendChatMessage(
                awardMessage,
                publicChannel,
                "COMMON"
            );

            SendChatMessage(
                awardMessage,
                "GUILD",
                "COMMON"
            );

            return;
        end

        SendChatMessage(
            awardMessage,
            publicChannel,
            "COMMON"
        );
    end
end

Utils:debug("AwardedLoot.lua");