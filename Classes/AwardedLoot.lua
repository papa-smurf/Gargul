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
local CommActions = App.Data.Constants.Comm.Actions;

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
    if (type(tooltip) ~= "table" or not App.User.isInGroup) then
        return;
    end

    local _, itemLink = tooltip:GetItem();

    -- We couldn't find an itemLink (this can actually happen!)
    if (not itemLink) then
        return;
    end

    local awardedTo = table.concat(Utils:tableGet(AwardedLoot.AwardedThisSession, itemLink, {}), ", ");

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

function AwardedLoot:addWinnerOnDate(winner, date, itemLink)
    Utils:debug("AwardedLoot:addWinnerOnDate");

    return AwardedLoot:addWinner(winner, itemLink, nil, nil, date)
end

-- Add a winner for a specific item to the SessionHistory table
function AwardedLoot:addWinner(winner, itemLink, dkp, announce, date)
    Utils:debug("AwardedLoot:addWinner");

    local dateProvided = date and type(date) == "string";
    local timestamp = GetServerTime();

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

    -- You can set the date for when this item was awarded, handy if you forgot an item for example
    if (dateProvided) then
        local year, month, day = string.match(date, "^(%d+)-(%d+)-(%d+)$");

        if (
            not year or not month or not day
            or type(year) ~= "string" or type(month) ~= "string" or type(day) ~= "string"
            or year == "" or month == "" or day == ""
        ) then
            return Utils:error(string.format("Unknown date format '%s' expecting yy-m-d", date));
        end

        if (string.len(year) == 2) then
            year = "20" .. year;
        end

        local Date = {
            year = year,
            month = Utils:strPadLeft(month, 0, 2),
            day = Utils:strPadLeft(day, 0, 2),
        }

        timestamp = time(Date);
    end

    -- Enable the announce switch by default
    if (type(announce) ~= "boolean") then
        announce = true;
    end

    -- No need to announce if the player is not in a group of any kind
    if (not App.User.isInGroup) then
        announce = false;
    end

    -- Insert the award in the SessionHistory table used for rendering tooltips
    local SessionHistory = Utils:tableGet(AwardedLoot.AwardedThisSession, itemLink, {});
    tinsert(SessionHistory, winner);
    AwardedLoot.AwardedThisSession[itemLink] = SessionHistory;

    local AwardEntry = {
        itemLink = itemLink,
        itemId = itemId,
        awardedTo = winner,
        timestamp = timestamp,
    };

    -- Insert the award in the more permanent AwardHistory table (for export / audit purposes)
    tinsert(App.DB.AwardHistory, AwardEntry);

    local channel = "PARTY";
    if (App.User.isInRaid) then
        channel = "RAID";
    end

    if (announce) then
        awardMessage = string.format("%s was awarded to %s. Congrats!",
            itemLink,
            winner,
            dkp
        );

        if (type(dkp) == 'number' and dkp > 0) then
            awardMessage = string.format("%s awarded to %s for %s DKP. Congrats!",
                itemLink,
                winner,
                dkp
            );

            SendChatMessage(
                awardMessage,
                channel,
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
            channel,
            "COMMON"
        );
    end

    -- We have to provide some feedback that it all worked out
    -- in case the loot will not be announce in the player's group
    if (not announce) then
        Utils:success(itemLink .. " was successfully awarded!");
    end

    if (App.User.isInGroup) then
        App.CommMessage.new(
            CommActions.awardItem,
            {
                itemLink = itemLink,
                winner = winner,
                timestamp = timestamp,
            },
            channel
        ):send();
    end
end

function AwardedLoot:processAwardedLoot(CommMessage)
    Utils:debug("AwardedLoot:processAwardedLoot");

    -- No need to add awawarded loot if we broadcasted it ourselves
    if (CommMessage.Sender.name == App.User.name) then
        Utils:debug("AwardedLoot:processAwardedLoot received by self, skip");
        return;
    end

    local itemLink = CommMessage.content.itemLink;
    local winner = CommMessage.content.winner;
    local timestamp = CommMessage.content.timestamp;
    local itemId = Utils:getItemIdFromLink(itemLink);

    if (not itemLink
        or not winner or winner == ""
        or not timestamp or timestamp == ""
        or not itemId
    ) then
        return Utils:warning("Couldn't process auction result in Auction:processResult");
    end

    local AwardEntry = {
        itemLink = itemLink,
        itemId = itemId,
        awardedTo = winner,
        timestamp = timestamp,
    };

    -- Insert the award in the more permanent AwardHistory table (for export / audit purposes)
    tinsert(App.DB.AwardHistory, AwardEntry);
end

Utils:debug("AwardedLoot.lua");