local _, GL = ...;

---@type Data
local CommActions = GL.Data.Constants.Comm.Actions;

---@type DB
local DB = GL.DB;

---@class AwardedLoot
GL.AwardedLoot = {
    _initialized = false,
};

---@type AwardedLoot
local AwardedLoot = GL.AwardedLoot;

---@return void
function AwardedLoot:_init()
    GL:debug("AwardedLoot:_init");

    if (self._initialized) then
        return;
    end

    -- Bind the opening of the trade window to the tradeInitiated method
    GL.Events:register("AwardedLootTradeShowListener", "GL.TRADE_SHOW", function ()
        self:tradeInitiated();
    end);

    -- Bind a successful trade to the tradeCompleted method
    GL.Events:register("AwardedLootTradeCompletedListener", "GL.TRADE_COMPLETED", function (_, Details)
        self:tradeCompleted(Details);
    end);

    -- Bind a item successfully assigned (masterlooted) to the winner to the tradeCompleted method
    GL.Events:register("AwardedLootTradeCompletedListener", "GL.ITEM_MASTER_LOOTED", function (_, player, itemID)
        -- Mimic the GL.TRADE_COMPLETED payload so we can reuse the tradeCompleted method!
        self:tradeCompleted{
            partner = player,
            MyItems = {
                {
                    itemID = itemID,
                },
            },
        };
    end);

    self._initialized = true;
end

--- Fetch all the tooltip lines that include award info, this allows for easy caching
---
---@param itemLink string
---@return table
function AwardedLoot:tooltipLines(itemLink)
    local itemID = GL:getItemIDFromLink(itemLink);

    local fiveHoursAgo = GetServerTime() - 18000;
    local loadItemsGTE = math.min(fiveHoursAgo, GL.loadedOn);
    local winnersAvailable = false;
    local Lines = { string.format("\n|c00efb8cd%s|r", "Awarded To") };
    for _, Loot in pairs(DB:get("AwardHistory")) do
        (function ()
            -- loadItemsGTE will equal five hours, or however long the players
            -- current playsession is ongoing (whichever is longest)
            if (Loot.timestamp < loadItemsGTE
                or Loot.itemID ~= itemID -- This is not the item we're looking for
            ) then
                return;
            end

            local Details = {};

            if (Loot.OS) then
                tinsert(Details, "OS");
            end

            if (GL:higherThanZero(Loot.BRCost)) then
                tinsert(Details, string.format("BR: %s", Loot.BRCost));
            end

            if (GL:higherThanZero(Loot.GDKPCost)) then
                tinsert(Details, string.format("Price: %sg", Loot.GDKPCost));
            end

            local receivedString = "Given: yes";
            if (not Loot.received) then
                receivedString = "Given: no";
            end
            tinsert(Details, receivedString);

            local line = string.format("    %s | %s",
                GL:nameFormat{ name = Loot.awardedTo, colorize = true },
                table.concat(Details, " | ")
            );
            tinsert(Lines, line);
            winnersAvailable = true;
        end)();
    end

    -- Nothing to show
    if (not winnersAvailable) then
        return {};
    end

    return Lines;
end

--- Add a winner for a specific item, on a specific date
---
---@param winner string
---@param date string
---@param itemLink string
---@return void
function AwardedLoot:addWinnerOnDate(winner, date, itemLink, announce)
    GL:debug("AwardedLoot:addWinnerOnDate");

    announce = GL:toboolean(announce);

    return AwardedLoot:addWinner(winner, itemLink, announce, date);
end

--- Remove a winner for an item
---
---@param checksum string
---@param adjustPoints boolean|nil
---@return void
function AwardedLoot:deleteWinner(checksum, adjustPoints)
    GL:debug("AwardedLoot:deleteWinner");

    -- This method can directly be accessed via a comm command, hence the double check
    if (type(checksum) ~= "string" or GL:empty(checksum)) then
        return;
    end

    if (adjustPoints == nil) then
        adjustPoints = true;
    end

    -- We don't know this entry
    if (not GL.DB.AwardHistory[checksum]) then
        return;
    end

    local AwardEntry = GL.DB.AwardHistory[checksum];

    -- Refund BR cost
    if (adjustPoints and AwardEntry.BRCost and GL:higherThanZero(AwardEntry.BRCost)) then
        GL.BoostedRolls:addPoints(AwardEntry.awardedTo, AwardEntry.BRCost);
    end

    GL.DB.AwardHistory[checksum] = nil;

    -- Let the application know that an item was unawarded (deleted)
    GL.Events:fire("GL.ITEM_UNAWARDED", AwardEntry);

    -- If the user is not in a group then there's no need
    -- to broadcast or attempt to auto assign loot to the winner
    if (GL.User.isInGroup) then
        -- Broadcast the awarded loot details to everyone in the group
        GL.CommMessage.new(CommActions.deleteAwardedItem, checksum, "GROUP"):send();
    end
end

--- Edit the winner of an item
---
---@param checksum string
---@return void
function AwardedLoot:editWinner(checksum, winner, announce)
    GL:debug("AwardedLoot:editWinner");

    local AwardEntry = DB:get("AwardHistory." .. checksum);
    if (not AwardEntry) then
        return;
    end

    winner = GL:nameFormat(winner);

    -- Nothing changed, silly player stuff
    if (GL:iEquals(winner, AwardEntry.awardedTo)) then
        return;
    end

    -- Redistribute BR cost
    if (AwardEntry.BRCost and GL:higherThanZero(AwardEntry.BRCost)) then
        GL.BoostedRolls:addPoints(AwardEntry.awardedTo, AwardEntry.BRCost);
        GL.BoostedRolls:subtractPoints(winner, AwardEntry.BRCost);
    end

    AwardEntry.received = false;
    AwardEntry.awardedTo = winner;
    AwardEntry.awardedBy = GL.User.fqn;

    -- If we awarded to ourselves then we should already have the item
    if (string.lower(winner) == string.lower(GL.User.fqn)) then
        AwardEntry.received = true;
    end

    GL.DB.AwardHistory[checksum] = AwardEntry;

    -- If announce is not provided then take the settings value
    if (announce == nil) then
        announce = GL.Settings:get("AwardingLoot.awardMessagesEnabled");
    end

    -- Do we need to announce this award?
    if (announce) then
        local channel = "GROUP";
        if (GL.User.isInRaid
            and GL.Settings:get("AwardingLoot.announceAwardMessagesInRW")
        ) then
            channel = "RAID_WARNING";
        end

        local awardMessage = "";
        if (GL.BoostedRolls:enabled() and GL:higherThanZero(AwardEntry.BRCost)) then
            awardMessage = string.format("%s was awarded to %s for %s points. Congrats!",
                AwardEntry.itemLink,
                winner,
                AwardEntry.BRCost
            );
        elseif (AwardEntry.GDKPCost and AwardEntry.GDKPCost > 0) then
            awardMessage = string.format("%s was awarded to %s for %sg. Congrats!",
                AwardEntry.itemLink,
                winner,
                AwardEntry.GDKPCost
            );
        else
            awardMessage = string.format("%s was awarded to %s. Congrats!",
                AwardEntry.itemLink,
                winner
            );

            if (GL.BoostedRolls:enabled()) then
                --- Make sure the cost is stored as the (new) default item cost
                GL.Settings:set("BoostedRolls.defaultCost", AwardEntry.BRCost);
            end
        end

        -- Announce awarded item on RAID or RAID_WARNING
        GL:sendChatMessage(
            awardMessage,
            channel
        );

        -- Announce awarded item on GUILD
        if (GL.Settings:get("AwardingLoot.announceAwardMessagesInGuildChat")
            and GL.User.Guild.name -- Make sure the loot master is actually in a guild
            and GL.User.isInGroup -- Make sure the user is in some kind of group (and not just testing)
        ) then
            local Winner = GL.Player:fromName(winner);

            -- Make sure the winner is actually in our guild before we announce him there
            if (GL:tableGet(Winner, "Guild.name") == GL.User.Guild.name) then
                GL:sendChatMessage(
                    awardMessage,
                    "GUILD"
                );
            end
        end
    end

    -- Broadcast the awarded loot details to everyone in the group
    GL.CommMessage.new(CommActions.editAwardedItem, AwardEntry, "GROUP"):send();

    -- The loot window is not active and the auto assign setting is enabled
    if (not GL.DroppedLoot.lootWindowIsOpened
        and GL.Settings:get("AwardingLoot.autoTradeAfterAwardingAnItem")
        and (GL.Settings:get("AwardingLoot.autoTradeInCombat") or
            not UnitAffectingCombat("player")
        )
        and GL.User.fqn ~= winner
    ) then
        self:initiateTrade(AwardEntry);
    end

    -- Let the application know that an item was edited
    GL.Events:fire("GL.ITEM_AWARD_EDITED", AwardEntry);
end

--- Add a winner for a specific item
---
---@param winner string
---@param itemLink string
---@param announce boolean|nil
---@param date string|nil
---@param isOS boolean|nil
---@param BRCost number|nil
---@param GDKPCost number|nil
---@param automaticallyAwarded boolean|nil Was this awarded automatically via the AwardingLoot.awardOnReceive setting?
---@param RollBracket table|nil See DefaultSettings.lua -> RollTracking.Brackets
---@return void|string
function AwardedLoot:addWinner(winner, itemLink, announce, date, isOS, BRCost, GDKPCost, Rolls, automaticallyAwarded, RollBracket)
    GL:debug("AwardedLoot:addWinner");

    -- Named parameters aren't possible, so supporting a table is the next best thing
    if (type(winner) == "table") then
        itemLink = winner.itemLink;
        announce = winner.announce;
        date = winner.date;
        isOS = winner.isOS;
        BRCost = winner.BRCost;
        GDKPCost = winner.GDKPCost;
        Rolls = winner.Rolls;
        automaticallyAwarded = winner.automaticallyAwarded;
        RollBracket = winner.RollBracket;

        -- Save this for last
        winner = winner.winner;
    end

    local isDisenchanted = winner == GL.Exporter.disenchantedItemIdentifier;
    winner = not isDisenchanted and GL:addRealm(winner) or winner;

    local broadcast = false;
    if (automaticallyAwarded) then
        if (GetLootMethod() == "master") then
            broadcast = GL.User.isMasterLooter;
        else
            broadcast = GL.User.isLead;
        end
    else
        broadcast = GL.User.isMasterLooter or GL.User.hasAssist or not GL.User.isInGroup;
    end

    -- Loot awarded automatically (when AwardingLoot.awardOnReceive is enabled)
    -- will not be broadcasted/shared in any way unless you have the required permissions!
    automaticallyAwarded = GL:toboolean(automaticallyAwarded);

    -- Determine whether the item should be flagged as off-spec
    isOS = GL:toboolean(isOS);

    local timestamp;
    local dateProvided = date and type(date) == "string";

    if (not dateProvided and type(date) == "number") then
        timestamp = date;
    else
        timestamp = GetServerTime();
    end

    if (type(winner) ~= "string"
        or GL:empty(winner)
    ) then
        GL:debug("Invalid winner provided for AwardedLoot:addWinner");
        return false;
    end

    if (type(itemLink) ~= "string"
        or GL:empty(itemLink)
    ) then
        GL:debug("Invalid itemLink provided for AwardedLoot:addWinner");
        return false;
    end

    local itemID = GL:getItemIDFromLink(itemLink);

    if (not itemID) then
        GL:debug("Invalid itemLink provided for AwardedLoot:addWinner");
        return false;
    end

    winner = not isDisenchanted and GL:nameFormat{name = winner, forceRealm = true} or winner;

    -- You can set the date for when this item was awarded, handy if you forgot an item for example
    if (dateProvided) then
        local year, month, day = string.match(date, "^(%d+)-(%d+)-(%d+)$");

        if (type(year) ~= "string" or GL:empty(year)
            or type(month) ~= "string" or GL:empty(month)
            or type(day) ~= "string" or GL:empty(day)
        ) then
            GL:error(string.format("Unknown date format '%s' expecting yy-m-d", date));
            return false;
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

    local realmLessName = string.lower(GL:stripRealm(winner));
    local isPrioritized, isWishlisted = false, false;
    local isReserved = not isDisenchanted and GL.SoftRes:itemIDIsReservedByPlayer(itemID, realmLessName) or false;

    if (not isDisenchanted) then
        for _, Entry in pairs(GL.TMB:byItemIDAndPlayer(itemID, realmLessName) or {}) do
            if (Entry.type == GL.Data.Constants.tmbTypePrio) then
                isPrioritized = true;
            elseif (Entry.type == GL.Data.Constants.tmbTypeWish) then
                isWishlisted = true;
            end
        end
    end

    local checksum = GL:strPadRight(GL:strLimit(GL:stringHash(timestamp .. itemID) .. GL:stringHash(winner .. GL.DB:get("SoftRes.MetaData.id", "")), 20, ""), "0", 20);
    local AwardEntry = {
        checksum = checksum,
        itemLink = itemLink,
        itemID = itemID,
        awardedTo = winner,
        awardedBy = GL.User.fqn,
        timestamp = timestamp,
        softresID = GL.DB:get("SoftRes.MetaData.id"),
        received = GL:iEquals(winner, GL.User.name),
        BRCost = tonumber(BRCost),
        GDKPCost = tonumber(GDKPCost),
        OS = isOS,
        SR = isReserved,
        WL = isWishlisted,
        PL = isPrioritized,
        TMB = isWishlisted or isPrioritized,
        winningRollType = RollBracket and RollBracket[1],
        Rolls = Rolls or {},
    };

    -- Insert the award in the more permanent AwardHistory table (for export / audit purposes)
    DB:set("AwardHistory." .. AwardEntry.checksum, AwardEntry)

    -- Check whether the user disabled award announcement in the settings
    if (not GL.Settings:get("AwardingLoot.awardMessagesEnabled")) then
        announce = false;
    end

    local channel = "GROUP";
    if (GL.User.isInRaid
        and GL.Settings:get("AwardingLoot.announceAwardMessagesInRW")
    ) then
        channel = "RAID_WARNING";
    end

    -- No need to mention the realm of the player unless his name is not unique
    local awardedTo = GL:disambiguateName(winner);

    if (announce) then
        local awardMessage = "";
        if (GL.BoostedRolls:enabled() and GL:higherThanZero(BRCost)) then
            awardMessage = string.format("%s was awarded to %s for %s points. Congrats!",
                itemLink,
                awardedTo,
                BRCost
            );
        elseif (GDKPCost and GDKPCost > 0) then
            awardMessage = string.format("%s was awarded to %s for %sg. Congrats!",
                itemLink,
                awardedTo,
                GDKPCost
            );
        else
            awardMessage = string.format("%s was awarded to %s. Congrats!",
                itemLink,
                awardedTo
            );

            if (GL.BoostedRolls:enabled()) then
                --- Make sure the cost is stored as the (new) default item cost
                GL.Settings:set("BoostedRolls.defaultCost", BRCost);
            end
        end

        -- Announce awarded item on RAID or RAID_WARNING
        GL:sendChatMessage(
            awardMessage,
            channel
        );

        -- Announce awarded item on GUILD
        if (GL.Settings:get("AwardingLoot.announceAwardMessagesInGuildChat")
            and GL.User.Guild.name -- Make sure the loot master is actually in a guild
            and GL.User.isInGroup -- Make sure the user is in some kind of group (and not just testing)
        ) then
            local Winner = GL.Player:fromName(winner);

            -- Make sure the winner is actually in our guild before we announce him there
            if (GL:tableGet(Winner, "Guild.name") == GL.User.Guild.name) then
                GL:sendChatMessage(
                    awardMessage,
                    "GUILD"
                );
            end
        end
    end

    if (broadcast) then
        -- Broadcast the awarded loot details to everyone in the group
        GL.CommMessage.new(CommActions.awardItem, AwardEntry, "GROUP"):send();
    end

    -- Trading players is not necessary when the item was awarded
    -- automatically via group loot or the native wow master looter UI
    if (not automaticallyAwarded) then
        -- The loot window is still active and the auto assign setting is enabled
        if (GL.DroppedLoot.lootWindowIsOpened
            and GL.User.isMasterLooter
            and GL.Settings:get("AwardingLoot.autoAssignAfterAwardingAnItem")
        ) then
            GL.PackMule:assignLootToPlayer(AwardEntry.itemID, winner);

        -- The loot window is closed and the auto trade setting is enabled
        elseif (not GL.DroppedLoot.lootWindowIsOpened

            -- No need to trade with ourselves
            and GL.User.name ~= winner

            -- Auto trading is disabled
            and GL.Settings:get("AwardingLoot.autoTradeAfterAwardingAnItem")

            -- The player doesn't want to auto trade disenchanted items
            and (GL.Settings:get("AwardingLoot.autoTradeDisenchanter") or
                winner ~= GL.Exporter.disenchantedItemIdentifier
            )

            -- The player doesn't want to trade whilst ink combat
            and (GL.Settings:get("AwardingLoot.autoTradeInCombat") or
                not UnitAffectingCombat("player")
            )
        ) then
            AwardedLoot:initiateTrade(AwardEntry);
        end
    end

    -- Let the application know that an item was awarded
    GL.Events:fire("GL.ITEM_AWARDED", AwardEntry);

    -- Send the award data along to CLM if the player has it installed
    pcall(function ()
        if (not broadcast) then
            return;
        end

        local CLMEventDispatcher = LibStub("EventDispatcher", true);

        if (not CLMEventDispatcher
            or not CLMEventDispatcher.dispatchEvent
        ) then
            return;
        end

        CLMEventDispatcher.dispatchEvent("CLM_EXTERNAL_EVENT_ITEM_AWARDED", {
            source = "Gargul",
            itemLink = itemLink,
            player = winner,
            isOffSpec = isOS,
            isWishlisted = isWishlisted,
            isPrioritized = isPrioritized,
            isReserved = isReserved,
        });
    end);

    return checksum;
end

--- Return items won by the given player (with optional `after` timestamp)
---
---@param winner string
---@param after number
---@return table
function AwardedLoot:byWinner(winner, after)
    GL:debug("AwardedLoot:byWinner");

    local Entries = {};
    for checksum, AwardEntry in pairs(DB:get("AwardHistory")) do
        if ((not after or AwardEntry.timestamp > after)
            and AwardEntry.awardedTo == winner
            and not GL:empty(AwardEntry.timestamp)
            and not GL:empty(AwardEntry.itemLink)
        ) then
            Entries[checksum] = AwardEntry;
        end
    end

    return Entries;
end

--- Attempt to initiate a trade with whomever won the item and add the items
---
---@param AwardDetails table
---@return void
function AwardedLoot:initiateTrade(AwardDetails)
    GL:debug("AwardedLoot:initiateTrade");

    local tradingPartner = AwardDetails.awardedTo;

    -- Check whether we have the item in our inventory, no point opening a trade window if not
    local itemPositionInBag = GL:findBagIdAndSlotForItem(AwardDetails.itemID);
    if (GL:empty(itemPositionInBag)) then
        return;
    end

    -- If the item is marked as disenchanted then we need to open a trade window with the disenchanter
    if (AwardDetails.awardedTo == GL.Exporter.disenchantedItemIdentifier
        and GL.PackMule.disenchanter
    ) then
        tradingPartner = GL.PackMule.disenchanter;
    end

    if (not TradeFrame:IsShown()) then
        -- Open a trade window with the winner
        GL.TradeWindow:open(tradingPartner, function ()
            self:tradeInitiated();
        end);

    -- We're already trading with the winner
    elseif (GL:tableGet(GL.TradeWindow, "State.partner") == tradingPartner) then
        -- Attempt to add the item to the trade window
        GL.TradeWindow:addItem(AwardDetails.itemID);
    end
end

--- When a trade is initiated we attempt to automatically add items that should be given to the tradee
---
---@return void
function AwardedLoot:tradeInitiated()
    -- Fetch the player name of whomever we're trading with
    local tradingPartner = GL:tableGet(GL.TradeWindow, "State.partner");

    -- The trading partner could not be determined (the trade window was closed?)
    if (GL:empty(tradingPartner)) then
        return;
    end

    -- Check whether there are any awarded items that need to be traded to your trading partner
    local threeHoursAgo = GetServerTime() - 10800;

    -- Loop through our awarded loot table in reverse
    local thereAreItemsToAdd = false;
    for _, Loot in pairs(DB:get("AwardHistory")) do
        -- Our trading partner changed in the meantime, stop!
        if (tradingPartner ~= GL:tableGet(GL.TradeWindow, "State.partner")) then
            break;
        end

        (function ()
            if (Loot.timestamp < threeHoursAgo) then
                return;
            end

            local awardedTo = GL:nameFormat(Loot.awardedTo);

            -- Check whether this item is meant for our current trading partner
            if (Loot.received -- The item was already received by the winner, no need to check further
                or (awardedTo ~= tradingPartner -- The awarded item entry is not meant for this person

                    -- The item is marked as disenchanted and our trading partner is the designated enchanter
                    and (awardedTo ~= GL.Exporter.disenchantedItemIdentifier
                        or tradingPartner ~= GL.PackMule.disenchanter
                    )
                )
            ) then
                return;
            end

            -- Attempt to add the item to the trade window
            GL.TradeWindow:addItem(Loot.itemID);

            thereAreItemsToAdd = true;
        end)();
    end
end

--- Whenever a successful trade is completed we need to check whether we need to mark awarded loot as "received"
---
---@param Details table
---@return void
function AwardedLoot:tradeCompleted(Details)
    GL:debug("AwardedLoot:tradeCompleted");

    local ItemsTradedByMe = {};
    local tradedDisenchanter = Details.partner == GL.PackMule.disenchanter;

    for _, Entry in pairs(Details.MyItems) do
        local itemID = tonumber(Entry.itemID);

        if (itemID) then
            tinsert(ItemsTradedByMe, itemID);
        end
    end

    -- We didn't give anything to the person we traded with
    if (GL:empty(ItemsTradedByMe)) then
        return;
    end

    local threeHoursAgo = GetServerTime() - 10800;

    -- Loop through our awarded loot table in reverse
    for checksum, Loot in pairs(DB:get("AwardHistory")) do
        (function ()
            -- The item was already marked as received, skip it
            if (Loot.received or Loot.timestamp < threeHoursAgo) then
                return;
            end

            -- The item is not meant for the person we traded with, skip it
            if (not GL:iEquals(Details.partner, Loot.awardedTo)
                and (not tradedDisenchanter
                    or Loot.awardedTo ~= GL.Exporter.disenchantedItemIdentifier
                )
            ) then
                return;
            end

            -- We didn't trade this item
            if (not GL:inTable(ItemsTradedByMe, Loot.itemID)) then
                return;
            end

            -- We gave this item to the user, mark it as received!
            GL.DB.AwardHistory[checksum].received = true;

            -- Remove (one of) the item ID entries. This is necessary because
            -- a person might get the same item more than once
            for key, itemID in pairs(ItemsTradedByMe) do
                if (itemID == Loot.itemID) then
                    ItemsTradedByMe[key] = nil;
                    break;
                end
            end
        end)();
    end
end

--- The loot master awarded an item to someone, add it to our list as well
---
---@param CommMessage table
---@return void
function AwardedLoot:processAwardedLoot(CommMessage)
    GL:debug("AwardedLoot:processAwardedLoot");

    local AwardEntry = CommMessage.content;

    -- Make sure all values are available
    if (GL:empty(AwardEntry.checksum)
        or GL:empty(AwardEntry.itemLink)
        or GL:empty(AwardEntry.itemID)
        or GL:empty(AwardEntry.awardedTo)
        or GL:empty(AwardEntry.timestamp)
    ) then
        return GL:warning("Couldn't process award result in AwardedLoot:processAwardedLoot");
    end

    -- Show an item won alert on TBC+
    if (not GL.isEra and GL:iEquals(AwardEntry.awardedTo, GL.User.name)) then
        GL:onItemLoadDo(AwardEntry.itemID, function (Details)
            if (not Details) then
                return;
            end

            local callback = function (...)
                _G.LootWonAlertFrame_SetUp(...);

                local Notification = ...;

                if (Notification and Notification.Label and Notification.Label.SetText) then
                    Notification.Label:SetText("You won");
                end
            end
            local LootAlertSystem = AlertFrame:AddQueuedAlertFrameSubSystem("LootWonAlertFrameTemplate", callback, 6, math.huge);
            LootAlertSystem:AddAlert(Details.link);
        end);
    end

    -- No need to add awarded loot if we broadcasted it ourselves
    if (CommMessage.Sender.isSelf) then
        GL:debug("AwardedLoot:processAwardedLoot received by self, skip");
        return;
    end

    -- There's no point to us giving the winner the item since we don't have it
    AwardEntry.received = true;

    -- Insert the award in the more permanent AwardHistory table (for export / audit purposes)
    -- We don't pass the actual AwardEntry object as-is here just in case there are some additional keys that we don't need
    GL.DB.AwardHistory[AwardEntry.checksum] = {
        checksum = AwardEntry.checksum,
        itemLink = AwardEntry.itemLink,
        itemID = AwardEntry.itemID,
        awardedTo = AwardEntry.awardedTo,
        awardedBy = CommMessage.Sender.fqn,
        timestamp = AwardEntry.timestamp,
        softresID = AwardEntry.softresID,
        received = AwardEntry.received,
        BRCost = AwardEntry.BRCost,
        GDKPCost = AwardEntry.GDKPCost,
        OS = GL:toboolean(AwardEntry.OS),
        SR = GL:toboolean(AwardEntry.SR),
        WL = GL:toboolean(AwardEntry.WL),
        PL = GL:toboolean(AwardEntry.PL),
        TMB = GL:toboolean(AwardEntry.TMB),
        Rolls = AwardEntry.Rolls,
    };

    GL.Events:fire("GL.ITEM_AWARDED", GL.DB.AwardHistory[AwardEntry.checksum]);
end

--- The loot master edited an item award, make sure our list reflect those changes
---
---@param CommMessage table
---@return void
function AwardedLoot:processEditedLoot(CommMessage)
    GL:debug("AwardedLoot:processEditedLoot");

    -- No need to do anything if we broadcasted it ourselves
    if (CommMessage.Sender.isSelf) then
        GL:debug("AwardedLoot:processEditedLoot received by self, skip");
        return;
    end

    local AwardEntry = CommMessage.content;

    -- Make sure all values are available
    if (GL:empty(AwardEntry.checksum)
        or GL:empty(AwardEntry.itemLink)
        or GL:empty(AwardEntry.itemID)
        or GL:empty(AwardEntry.awardedTo)
        or GL:empty(AwardEntry.timestamp)
    ) then
        return GL:warning("Couldn't process edit result in AwardedLoot:processEditedLoot");
    end

    -- There's no point to us giving the winner the item since we don't have it
    AwardEntry.received = true;

    local checksum;
    for index, Loot in pairs(DB:get("AwardHistory")) do
        if (Loot and index == AwardEntry.checksum) then
            checksum = index;
            break;
        end
    end

    -- We don't have any record of this item, add it instead
    if (not checksum) then
        self:processAwardedLoot(CommMessage);
        return;
    end

    -- Store the changes
    GL.DB.AwardHistory[checksum] = {
        checksum = AwardEntry.checksum,
        itemLink = AwardEntry.itemLink,
        itemID = AwardEntry.itemID,
        awardedTo = AwardEntry.awardedTo,
        awardedBy = AwardEntry.awardedBy,
        timestamp = AwardEntry.timestamp,
        softresID = AwardEntry.softresID,
        received = AwardEntry.received,
        BRCost = AwardEntry.BRCost,
        GDKPCost = AwardEntry.GDKPCost,
        OS = AwardEntry.OS,
        Rolls = AwardEntry.Rolls,
    };
end

GL:debug("AwardedLoot.lua");