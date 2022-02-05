--[[
    This class lets the master looter appoint "pack mules"
    The pack mules (player) will automatically receive all items
    that they're eligible for according to the rules as set up by the ML
]]
local _, GL = ...;

---@class PackMule
GL.PackMule = {
    _initialized = false,
    disenchanter = false,
    processing = false,
    setupWindowIsActive = false,

    -- We ignore recipes and questitems by default
    -- since they might not always be tradably
    itemClassIdsToIgnore = {
        LE_ITEM_CLASS_RECIPE,
        LE_ITEM_CLASS_QUESTITEM,
    },

    playerIsInHeroicInstance = false,

    Rules = {},
};

local PackMule = GL.PackMule; ---@type PackMule
local Settings = GL.Settings; ---@type Settings

---@return void
function PackMule:_init()
    GL:debug("PackMule:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    -- Check whether the user is in a heroic instance
    -- More info about difficultyIDs: https://wowpedia.fandom.com/wiki/DifficultyID
    local _, _, difficultyID = GetInstanceInfo();
    self.playerIsInHeroicInstance = GL:inTable({2, 174}, difficultyID);

    -- Disable packmule if the "persist after reload" setting is not enabled
    -- This piece of logic is only run once on boot/reload hence why this works
    if (not Settings:get("PackMule.persistsAfterReload")
        and Settings:get("PackMule.enabled")
    ) then
        GL:warning("PackMule was automatically disabled after reload");
        Settings:set("PackMule.enabled", false);
    end

    self.Rules = Settings:get("PackMule.Rules");

    GL.Events:register("PackMuleZoneChangeListener", "ZONE_CHANGED_NEW_AREA", function ()
        self:zoneChanged();
    end);

    GL.Events:register("PackMuleLootLootAnnouncedListener", "GL.LOOT_ANNOUNCED", function ()
        if (self.timerId) then
            GL.Ace:CancelTimer(self.timerId);
            self.timerId = false;
        end

        -- Do nothing if packmule is not enabled or the user holds the shift key
        if (not Settings:get("PackMule.enabled")
            or IsShiftKeyDown()
        ) then
            return;
        end

        -- We keep scouring the loot window every .2 second because
        -- the loot in a loot window can change for any number of reasons:
        -- Quick loot is enabled for items
        -- There was money in the loot window
        -- The player has another weak aura or addon that distributes specific items
        self.timerId = GL.Ace:ScheduleRepeatingTimer(function ()
            self:lootReady();
        end, .2);
    end);

    -- Make sure we stop checking the loot window after the player is done looting
    GL.Events:register("PackMuleLootClosedListener", "LOOT_CLOSED", function ()
        if (self.timerId) then
            GL.Ace:CancelTimer(self.timerId);
            self.timerId = false;
        end
    end);
end

--- Check if an item ID is ignored by default by PackMule (displayed in chat)
---
---@param checkItemID number
---@return void
function PackMule:isItemIDIgnored(checkItemID)
    local itemID, _, _, _, _, itemClassID = GetItemInfoInstant(checkItemID)

    if (not itemID) then
        return GL:warning(string.format("Unknown item ID '%s'", checkItemID));
    end

    GL:onItemLoadDo(itemID, function (Items)
        local Loot = Items[1];

        if (not Loot) then
            return GL:warning(string.format("Unknown item ID '%s'", checkItemID));
        end

        local bindType = Loot.bindType or LE_ITEM_BIND_NONE;
        local bindOnPickup = GL:inTable({ LE_ITEM_BIND_ON_ACQUIRE, LE_ITEM_BIND_QUEST}, bindType);

        if (not bindOnPickup or ( -- The item is not BoP so we can safely PackMule it
                Loot.quality < 5 -- Legendary items are skipped
                and not GL:inTable(GL.Data.Constants.UntradeableItems, itemID) -- Untradable items are skipped in quality rules
                and not GL:inTable(self.itemClassIdsToIgnore, itemClassID) -- Recipes and Quest Items are skipped in quality rules
            )
        ) then
            return GL:message("This item is NOT ignored!");
        end

        GL:message("This item is ignored!");
    end);
end

--- Disable PackMule after a zone switch, unless enabled in settings
---
---@return void
function PackMule:zoneChanged()
    GL:debug("PackMule:zoneChanged");

    -- Disable packmule if the "persist after reload" setting is not enabled
    if (not Settings:get("PackMule.persistsAfterZoneChange")
        and Settings:get("PackMule.enabled")
    ) then
        GL:warning("PackMule was automatically disabled after zone change");
        Settings:set("PackMule.enabled", false);
    end

    -- Check whether the user is in a heroic instance
    -- More info about difficultyIDs: https://wowpedia.fandom.com/wiki/DifficultyID
    local _, _, difficultyID = GetInstanceInfo();
    self.playerIsInHeroicInstance = GL:inTable({2, 174}, difficultyID);
end

--- Check all loot and implement applicable rules
---
---@return void
function PackMule:lootReady()
    GL:debug("PackMule:lootReady");

    if (self.processing) then
        return;
    else
        self.processing = true;
    end

    if (not self.Rules
        or not GL.User.isMasterLooter
    ) then
        self.processing = false;
        return;
    end

    -- Make sure we only use valid rules
    local ValidRules = {};
    for _, Rule in pairs(self.Rules) do
        if (self:ruleIsValid(Rule)) then
            tinsert(ValidRules, Rule);
        end
    end

    -- There are no valid rules, no need to continue
    if (not ValidRules) then
        self.processing = false;
        return;
    end

    for itemIndex = GetNumLootItems(), 1, -1 do
        local _, itemName, _, _, itemQuality, locked = GetLootSlotInfo(itemIndex);

        local itemLink = GetLootSlotLink(itemIndex);
        local itemID, itemClassID;
        local skip = locked; -- Locked means that you aren't able to loot it (tinted red)

        -- Some items don't have an itemLink (money for example)
        if (not skip
            and itemLink
        ) then
            itemID, _, _, _, _, itemClassID = GetItemInfoInstant(itemLink);
            skip = not itemID; -- itemId can actually be nil!
        end

        if (not skip) then
            GL:onItemLoadDo(itemID, function (Items)
                local Loot = Items[1];

                if (GL:empty(Loot)) then
                    return;
                end

                local RuleThatApplies = false;

                for _, Entry in pairs(ValidRules) do
                    -- This is useful to see in which order rules are being handled
                    GL:debug(string.format(
                        "Item: %s\nOperator: %s\nQuality: %s\nTarget: %s",
                        Entry.item or "",
                        Entry.quality or "",
                        Entry.operator or "",
                        Entry.target or ""
                    ));

                    local item = Entry.item or "";
                    local target = tostring(Entry.target or "");
                    local quality = tonumber(Entry.quality or "");
                    local operator = tostring(Entry.operator or "");

                    -- The potential target replacement above requires us
                    -- To make a local copy of the current Rule entry
                    local Rule = {
                        item = item,
                        target = target,
                        quality = quality,
                        operator = operator,
                    }

                    -- This is to make sure we support item names, IDs and links
                    local ruleItemID = math.floor(tonumber(GL:getItemIdFromLink(item)) or 0);
                    if (not ruleItemID) then
                        ruleItemID = math.floor(tonumber(item) or 0);
                    end

                    local ruleConcernsItemID = GL:higherThanZero(ruleItemID);

                    -- Check if this is a non item-specific rule (aka quality based rule)
                    if (itemQuality and quality and operator and target and (
                        (operator == "=" and itemQuality == quality)
                        or (operator == ">" and itemQuality > quality)
                        or (operator == ">=" and itemQuality >= quality)
                        or (operator == "<" and itemQuality < quality)
                        or (operator == "<=" and itemQuality <= quality)
                    )) then
                        local bindType = Loot.bindType or LE_ITEM_BIND_NONE;
                        local bindOnPickup = GL:inTable({ LE_ITEM_BIND_ON_ACQUIRE, LE_ITEM_BIND_QUEST}, bindType);

                        if (not bindOnPickup or ( -- The item is not BoP so we can safely PackMule it
                            itemQuality < 5 -- Legendary items are skipped
                            and (GL.User.isInRaid -- Make sure PackMule doesn't mule BoP items when not in a raid or heroic instance
                                or self.playerIsInHeroicInstance
                            )
                            and not GL:inTable(GL.Data.Constants.UntradeableItems, itemID) -- Untradable items are skipped in quality rules
                            and not GL:inTable(self.itemClassIdsToIgnore, itemClassID) -- Recipes and Quest Items are skipped in quality rules
                        )) then
                            RuleThatApplies = Rule;
                        end
                    elseif (item and (
                        (ruleConcernsItemID and ruleItemID == itemID) -- Item is an ID and the IDs match
                        or (self:lootMatchesSpecificRule(itemName, item)) -- The rule's item name matches the loot name
                    )) then
                        -- We found an item-specific rule, we can stop checking now
                        RuleThatApplies = Rule;
                        break;
                    end
                end

                -- The rule applies, give it to the designated target
                if (RuleThatApplies
                    and RuleThatApplies.target ~= "IGNORE"
                ) then
                    local ruleTarget = strtrim(RuleThatApplies.target);
                    local Targets = {};

                    -- Check whether we need to give the item to a random player
                    if (ruleTarget == "RANDOM") then
                        --target = GL:tableGet(GroupMembers[math.random( #GroupMembers)] or {}, "name", false);
                        for _, Player in pairs(GL.User:groupMembers()) do
                            tinsert(Targets, string.lower(Player.name));
                        end
                    else
                        local RuleTargets = GL:strSplit(ruleTarget, " ");
                        local GroupMemberNames = GL.User:groupMemberNames();

                        for _, ruleTarget in pairs(RuleTargets) do
                            local targetContainsExclamationMark = strfind(ruleTarget, "!");
                            ruleTarget = strtrim(ruleTarget);
                            ruleTarget = ruleTarget:gsub("!", "");

                            -- SELF serves as a placeholder for the current player name
                            if (ruleTarget == "SELF") then
                                ruleTarget = GL.User.name;
                            end

                            -- GroupMemberNames are always in lowercase
                            if (GL:inTable(GroupMemberNames, string.lower(ruleTarget))) then
                                -- This is a high prio target, return it and stop checking
                                if (targetContainsExclamationMark) then
                                    Targets = {ruleTarget};
                                    break;
                                end

                                tinsert(Targets, ruleTarget);
                            end
                        end
                    end

                    -- Count the number of potential targets
                    local numberOfTargets = #Targets;

                    -- There is no potential target for this item!
                    if (numberOfTargets < 1) then
                        return;
                    end

                    -- Fetch a (random) target from the eligible target pool
                    local target = string.lower(Targets[math.random(numberOfTargets)] or "");

                    -- This should technically be impossible, but you never know!
                    if (GL:empty(target)) then
                        return;
                    end

                    for playerIndex = 1, GetNumGroupMembers() do
                        -- Make sure to do a case-insensitive check
                        if (string.lower(GetMasterLootCandidate(itemIndex, playerIndex) or "") == target) then
                            GiveMasterLoot(itemIndex, playerIndex);
                            return;
                        end
                    end
                end
            end);
        end
    end

    self.processing = false;
end

--- Check whether the dropped item's name matches the rule's item name
--- *ruleItemName results in GL:strEndsWith(lootName, ruleItemname
--- ruleItemName* results in GL:strStartsWith(lootName, ruleItemname
--- *ruleItemName* results in strfind(lootName, ruleItemname
---
---@param lootName string
---@param ruleItemName string
---@return boolean
function PackMule:lootMatchesSpecificRule(lootName, ruleItemName)
    if (type(lootName) ~= "string")
        or type(ruleItemName) ~= "string"
    then
        return false;
    end

    lootName = string.lower(lootName);
    ruleItemName = string.lower(ruleItemName);

    -- No need to check any further, they match
    if (lootName == ruleItemName) then
        return true;
    end

    -- Find the first asterisk in the ruleItemName
    -- When found this indicates that this is a wildcard rule
    local firstAsteriskPosition = strfind(ruleItemName, "*");

    -- No asterisk was found so we're looking for
    -- an exact match which we already checked before
    if (not firstAsteriskPosition) then
        return false;
    end

    -- Find the last asterisk
    local lastAsteriskPosition = strfind(ruleItemName, "*", firstAsteriskPosition + 1);

    -- Remove all asterisks from the ruleItemName
    ruleItemName = ruleItemName:gsub("%*", "");

    -- If there's only 1 asterisk then the name either
    -- has to start with or end with the name provided in the rule
    if (not lastAsteriskPosition) then

        if (firstAsteriskPosition == 1) then
            return GL:strEndsWith(lootName, ruleItemName);
        end

        return GL:strStartsWith(lootName, ruleItemName);
    end

    -- There are two asterisks, so check if the ruleItemName exists in the lootName
    return GL:strContains(lootName, ruleItemName);
end

--- Empty the ruleset
---
---@return void
function PackMule:resetRules()
    GL:debug("PackMule:resetRules");

    self.Rules = {};
    Settings:set("PackMule.Rules", self.Rules);
end

--- Add a rule to the ruleset
---
---@param Rule table
---@return void
function PackMule:addRule(Rule)
    GL:debug("PackMule:addRule");

    if (self:ruleIsValid(Rule)) then
        tinsert(self.Rules, Rule);
        Settings:set("PackMule.Rules", self.Rules);
    end
end

--- Check if a given rule is valid
---
---@param Rule table
---@return boolean
function PackMule:ruleIsValid(Rule)
    GL:debug("PackMule:ruleIsValid");

    -- Every rule must have a target (who to give the item to)
    if (type(Rule.target) ~= "string"
        or GL:empty(Rule.target)
    ) then
        return false;
    end

    -- If there's an operator then it has to be valid and there has to be a quality
    if (Rule.operator
        and (
            not GL:inTable({"=", "<", "<=", ">", ">="}, Rule.operator)
            or not Rule.quality
            or type(Rule.quality) ~= "number"
        )
    ) then
        return false
    end

    -- If there's no operator then we need a specific item name to continue
    if (not Rule.operator
        and (type(Rule.item) ~= "string"
            or GL:empty(Rule.item)
        )
    ) then
        return false;
    end

    return true;
end

--- Disenchant a given item, marking it as disenchanted, posting a message and sending it to the disenchanter
--- A confirmation dialog is shown by default but can be disabled using byPassConfirmationDialog = true
---
---@param itemLink string
---@param byPassConfirmationDialog boolean
---@return void
function PackMule:disenchant(itemLink, byPassConfirmationDialog)
    GL:debug("PackMule:disenchant");

    if (not GL.User.isMasterLooter
        and not GL.User.hasAssist
        and not GL.User.isLead
    ) then
        return GL:warning("You need to be the master looter or have lead/assist!");
    end

    local itemId = GL:getItemIdFromLink(itemLink);
    byPassConfirmationDialog = toboolean(byPassConfirmationDialog);

    -- Make sure an itemlink was provided
    if (not GL:higherThanZero(itemId)) then
        return;
    end

    -- We show the player selector if there is no disenchanter
    -- set yet or if the old disenchanter is not in our group
    if (GL:empty(self.disenchanter)
        or not GL.User:unitIsInYourGroup(self.disenchanter)
    ) then
        local PlayerNames = {};
        for _, Player in pairs(GL.User:groupMembers()) do
            local playerName = string.lower(Player.name);

            -- Make sure all player names include the player's realm on Era servers
            if (GL.isEra and not strfind(playerName, "-")) then
                playerName = string.format("%s-%s", playerName, GL.User.realm);
            end

            tinsert(PlayerNames, playerName);
        end

        -- Show the player selector
        GL.Interface.PlayerSelector:draw("Who is your disenchanter?", PlayerNames, function (playerName)
            GL.Interface.Dialogs.PopupDialog:open({
                question = string.format("Set |cff%s%s|r as your disenchanter?",
                    GL:classHexColor(GL.Player:classByName(playerName)),
                    playerName
                ),
                OnYes = function ()
                    self.disenchanter = playerName;
                    self:disenchant(itemLink, true);

                    GL.Interface.PlayerSelector:close();
                end,
            });
        end);

        return;
    end

    if (byPassConfirmationDialog) then
        self:assignLootToPlayer(itemId, self.disenchanter);
        GL.Interface.PlayerSelector:close();
        GL.AwardedLoot:addWinner(GL.Exporter.disenchantedItemIdentifier, itemLink, false);
        self:announceDisenchantment(itemLink);

        return;
    end

    -- Make sure the initiator confirms his choice
    GL.Interface.Dialogs.PopupDialog:open({
        question = string.format("Send %s to |cff%s%s|r? Type /gl cd to remove this disenchanter!",
            itemLink,
            GL:classHexColor(GL.Player:classByName(self.disenchanter)),
            self.disenchanter
        ),
        OnYes = function ()
            self:assignLootToPlayer(itemId, self.disenchanter);
            GL.Interface.PlayerSelector:close();
            GL.AwardedLoot:addWinner(GL.Exporter.disenchantedItemIdentifier, itemLink, false);
            self:announceDisenchantment(itemLink);
        end,
    });
end

--- Clear the disenchanter
---
---@return void
function PackMule:clearDisenchanter()
    self.disenchanter = nil;
end

--- Announce the disenchantment of an item in the group chat
---
---@param itemLink string
---@return void
function PackMule:announceDisenchantment(itemLink)
    GL:debug("PackMule:announceDisenchantment");

    if (not GL.Settings:get("PackMule.announceDisenchantedItems")) then
        return
    end

    GL:sendChatMessage(
        string.format("%s will be disenchanted by %s",
        itemLink,
        self.disenchanter
    ), "GROUP");
end

--- Assign a item to a player
---
---@param itemID number
---@param playerName string
---@return void
function PackMule:assignLootToPlayer(itemID, playerName)
    GL:debug("PackMule:assignLootToPlayer");

    -- Try to determine the loot index of the item
    local itemIndex = false;
    local itemCount = GetNumLootItems();
    for lootIndex = 1, itemCount do
        local itemLink = GetLootSlotLink(lootIndex);
        local lootItemId = GL:getItemIdFromLink(itemLink);

        if (lootItemId and lootItemId == itemID) then
            itemIndex = lootIndex;
            break;
        end
    end

    -- The item could not be found, most likely
    -- because it was handed out manually already
    if (not itemIndex) then
        GL:debug("No itemIndexOfAwardedItem found in PackMule:assignLootToPlayer");
        return;
    end

    -- Try to determine the index of the player who should receive it
    local playerIndex = false;
    for _, Player in pairs(GL.User:groupMembers()) do
        local candidate = GetMasterLootCandidate(itemIndex, Player.index);

        if (candidate and candidate == playerName) then
            playerIndex = Player.index;
            break;
        end
    end

    -- The player we want to assign the item to is not currently in the raid anymore
    -- Or is not eligible to receive the item according to the GetMasterLootCandidate API
    if (not playerIndex) then
        GL:debug("No index found in PackMule:assignLootToPlayer");
        return
    end

    -- Make sure we fire an event when the user receives the item
    local eventID = "PackMuleItemMasterLootedListener" .. GL:uuid();
    GL.Events:register(eventID, "LOOT_SLOT_CLEARED", function (_, slot)
        GL.Events:unregister(eventID);

        if (slot == itemIndex) then
            GL.Events:fire("GL.ITEM_MASTER_LOOTED", playerName, itemID);
        end
    end);

    -- Assign the item to the winner
    GiveMasterLoot(itemIndex, playerIndex);

    -- Make sure the event listener doesn't linger
    GL.Ace:ScheduleTimer(function ()
        GL.Events:unregister(eventID);
    end, 1);
end

GL:debug("PackMule.lua");