--[[
    This class lets the master looter keep track of
	who was awarded what item. This is especially useful
	for master looters who bring items with them and do
	the rolling along the way.
]]

local _, GL = ...;

---@class AwardedLoot
GL.AwardedLoot = {
    initialized = false,
    AwardedThisSession = {},
};

local AwardedLoot = GL.AwardedLoot; ---@type AwardedLoot
local PackMule = GL.PackMule; ---@type PackMule
local CommActions = GL.Data.Constants.Comm.Actions;

function AwardedLoot:_init()
    GL:debug("AwardedLoot:_init");

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
    GL:debug("AwardedLoot:appendAwardedLootToTooltip");

    -- No tooltip was provided or the user is not in a party/raid
    if (type(tooltip) ~= "table" or not GL.User.isInGroup) then
        return;
    end

    local _, itemLink = tooltip:GetItem();

    -- We couldn't find an itemLink (this can actually happen!)
    if (not itemLink) then
        return;
    end

    local awardedTo = table.concat(GL:tableGet(AwardedLoot.AwardedThisSession, itemLink, {}), ", ");

    if (not awardedTo
        or type(awardedTo) ~= "string"
        or awardedTo == ""
    ) then
        return;
    end

    -- Add the header
    tooltip:AddLine(string.format("\n|c00efb8cd%s|r", "Awarded To"));

    -- Add the actual award info
    tooltip:AddLine(string.format("|c008aecff    %s|r", awardedTo));
end

function AwardedLoot:addWinnerOnDate(winner, date, itemLink)
    GL:debug("AwardedLoot:addWinnerOnDate");

    return AwardedLoot:addWinner(winner, itemLink, nil, date)
end

--- Add a winner for a specific item to the SessionHistory table
---
---@param winner string
---@param itemLink string
---@param announce boolean|nil
---@param date string|nil
---@param isOS boolean|nil
---@param addPlusOne boolean|nil
---@return void
function AwardedLoot:addWinner(winner, itemLink, announce, date, isOS)
    GL:debug("AwardedLoot:addWinner");

    isOS = toboolean(isOS);

    local dateProvided = date and type(date) == "string";
    local timestamp = GetServerTime();

    if (not winner or type(winner) ~= "string" or winner == "") then
        return GL:debug("Invalid winner provided for AwardedLoot:addWinner");
    end

    if (not itemLink or type(itemLink) ~= "string" or itemLink == "") then
        return GL:debug("Invalid itemLink provided for AwardedLoot:addWinner");
    end

    local itemId = GL:getItemIdFromLink(itemLink);

    if (not itemId) then
        return GL:debug("Invalid itemLink provided for AwardedLoot:addWinner");
    end

    -- You can set the date for when this item was awarded, handy if you forgot an item for example
    if (dateProvided) then
        local year, month, day = string.match(date, "^(%d+)-(%d+)-(%d+)$");

        if (not GL:allOfType("string", year, month, day)
            or GL:anyEmpty(year, month, day)
        ) then
            return GL:error(string.format("Unknown date format '%s' expecting yy-m-d", date));
        end

        if (string.len(year) == 2) then
            year = "20" .. year;
        end

        local Date = {
            year = year,
            month = GL:strPadLeft(month, 0, 2),
            day = GL:strPadLeft(day, 0, 2),
        }

        timestamp = time(Date);
    end

    -- Enable the announce switch by default
    if (type(announce) ~= "boolean") then
        announce = true;
    end

    -- No need to announce if the player is not in a group of any kind
    if (not GL.User.isInGroup) then
        announce = false;
    end

    -- Insert the award in the SessionHistory table used for rendering tooltips
    if (winner ~= GL.Exporter.disenchantedItemIdentifier) then
        local SessionHistory = GL:tableGet(AwardedLoot.AwardedThisSession, itemLink, {});
        tinsert(SessionHistory, winner);
        AwardedLoot.AwardedThisSession[itemLink] = SessionHistory;
    end

    local AwardEntry = {
        checksum = GL:strPadRight(GL:strLimit(GL:stringHash(timestamp .. itemId) .. GL:stringHash(winner .. GL.DB:get("SoftRes.MetaData.id", "")), 20, ""), "0", 20),
        itemLink = itemLink,
        itemId = itemId,
        awardedTo = winner,
        timestamp = timestamp,
        softresid = GL.DB:get("SoftRes.MetaData.id"),
        OS = isOS,
    };

    -- Insert the award in the more permanent AwardHistory table (for export / audit purposes)
    tinsert(GL.DB.AwardHistory, AwardEntry);

    -- Check whether the user disabled award announcement in the settings
    if (GL.Settings:get("AwardingLoot.awardMessagesDisabled")) then
        announce = false;
    end

    local channel = "PARTY";
    if (GL.User.isInRaid) then
        channel = "RAID";

        if (GL.Settings:get("AwardingLoot.announceAwardMessagesInRW")) then
            channel = "RAID_WARNING";
        end
    end

    if (announce) then
        local awardMessage = string.format("%s was awarded to %s. Congrats!",
            itemLink,
            winner
        );

        GL:sendChatMessage(
            awardMessage,
            channel
        );
    end

    -- If the user is not in a group then there's no need
    -- to broadcast or attempt to auto assign loot to the winner
    if (not GL.User.isInGroup) then
        return;
    end

    -- Broadcast the awarded loot details to everyone in the group
    GL.CommMessage.new(
        CommActions.awardItem,
        {
            itemLink = itemLink,
            winner = winner,
            timestamp = timestamp,
            OS = isOS,
        },
        channel
    ):send();

    -- The loot window is still active and the auto assign setting is enabled
    if (GL.DroppedLoot.lootWindowIsOpened
        and GL.Settings:get("AwardingLoot.autoAssignAfterAwardingAnItem")
    ) then
        GL.PackMule:assignLootToPlayer(AwardEntry.itemId, winner);

    -- The loot window is closed and the auto trade setting is enabled
    -- Also skip this part if you yourself won the item
    elseif (not GL.DroppedLoot.lootWindowIsOpened
        and GL.Settings:get("AwardingLoot.autoTradeAfterAwardingAnItem")
        and GL.User.name ~= winner
    ) then
        AwardedLoot:initiateTrade(AwardEntry);
    end
end

-- Attempt to initiate a trade with whomever won the item
function AwardedLoot:initiateTrade(AwardDetails)
    GL:debug("AwardedLoot:initiateTrade");

    local itemPositionInBag = GL:findBagIdAndSlotForItem(AwardDetails.itemId);

    -- Check whether we have the item in our inventory and didn't just close the loot window
    if (GL:empty(itemPositionInBag)) then
        return;
    end

    -- Open a trade window with the winner
    InitiateTrade(AwardDetails.awardedTo);

    -- Try to trade the item to the winner if it's in your inventory
    -- The delay is necessary because of server lag etc.
    self.timerId = GL.Ace:ScheduleTimer(function ()
        if (not TradeFrame:IsShown()) then
            return;
        end

        itemPositionInBag = GL:findBagIdAndSlotForItem(AwardDetails.itemId);

        if (not GL:empty(itemPositionInBag)
            and TradeFrame:IsShown()
        ) then
            UseContainerItem(unpack(itemPositionInBag));
        end
    end, .5);
end

function AwardedLoot:processAwardedLoot(CommMessage)
    GL:debug("AwardedLoot:processAwardedLoot");

    -- No need to add awarded loot if we broadcasted it ourselves
    if (CommMessage.Sender.name == GL.User.name) then
        GL:debug("AwardedLoot:processAwardedLoot received by self, skip");
        return;
    end

    local itemLink = CommMessage.content.itemLink;
    local winner = CommMessage.content.winner;
    local timestamp = CommMessage.content.timestamp;
    local itemId = GL:getItemIdFromLink(itemLink);

    if (not itemLink
        or not winner or winner == ""
        or not timestamp or timestamp == ""
        or not itemId
    ) then
        return GL:warning("Couldn't process auction result in Auction:processResult");
    end

    local AwardEntry = {
        itemLink = itemLink,
        itemId = itemId,
        awardedTo = winner,
        timestamp = timestamp,
    };

    -- Insert the award in the more permanent AwardHistory table (for export / audit purposes)
    tinsert(GL.DB.AwardHistory, AwardEntry);
end

GL:debug("AwardedLoot.lua");