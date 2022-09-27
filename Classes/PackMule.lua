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
    noDisenchanterSetWarningGiving = false,
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
        and (
            Settings:get("PackMule.enabledForMasterLoot")
            or Settings:get("PackMule.enabledForGroupLoot")
        )
    ) then
        GL:warning("PackMule was automatically disabled after reload");
        Settings:set("PackMule.enabledForMasterLoot", false);
        Settings:set("PackMule.enabledForGroupLoot", false);
    end

    self.Rules = Settings:get("PackMule.Rules");

    GL.Events:register("PackMuleZoneChangeListener", "ZONE_CHANGED_NEW_AREA", function ()
        self:zoneChanged();
    end);

    -- Whenever an item drops that is eligible for rolling trigger the highlighter and packmule rules
    GL.Events:register("GroupLootStartLootRollListener", "START_LOOT_ROLL", function (_, rollID)
        self:processGroupLootItems(rollID);
    end);

    GL.Events:register("PackMuleLootLootAnnouncedListener", "GL.LOOT_ANNOUNCED", function ()
        if (self.timerId) then
            GL.Ace:CancelTimer(self.timerId);
            self.timerId = false;
        end

        -- Do nothing if packmule is not enabled or the user holds the shift key
        if (not Settings:get("PackMule.enabledForMasterLoot")
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

    -- Make sure to auto accept BoP loot when rolling on items
    GL.Events:register("PackMuleConfirmLootRollListener", "CONFIRM_LOOT_ROLL", function (_, rollID, roll)
        if (not GL.Settings:get("PackMule.autoConfirmGroup")) then
            return;
        end

        ConfirmLootRoll(rollID, roll);
    end);

    -- Make sure to auto accept BoP loot when opening containers
    GL.Events:register("PackMuleLootOpenedListener", "LOOT_OPENED", function ()
        if (not GL.Settings:get("PackMule.autoConfirmSolo")) then
            return;
        end

        -- Auto confirm loot you open (lockbox etc)
        for itemIndex = 1, GetNumLootItems() do
            LootSlot(itemIndex);
            ConfirmLootSlot(itemIndex);
        end
    end);

    -- Make sure we stop checking the loot window after the player is done looting
    GL.Events:register("PackMuleLootClosedListener", "LOOT_CLOSED", function ()
        if (self.timerId) then
            GL.Ace:CancelTimer(self.timerId);
            self.timerId = false;
        end
    end);
end

--- PASS/NEED/GREED on group loot items based on PackMule rules
---
---@param rollID number
---@return void
function PackMule:processGroupLootItems(rollID)
    GL:debug("PackMule:processGroupLootItems");

    if (not rollID) then
        return;
    end

    -- This should not be possible, just double checking!
    if (GetLootMethod() == "master") then
        return;
    end

    -- Check if the user has PackMule enabled for group loot
    if (not GL.Settings:get("PackMule.enabledForGroupLoot")) then
        return;
    end

    -- Shouldn't be possible, but you never know
    local itemLink = GetLootRollItemLink(rollID);
    if (not itemLink) then
        return;
    end

    -- See if there's a PackMule target, if so hand it out
    self:getTargetForItem(itemLink, function(target)
        if (not target) then
            return;
        end

        -- PackMule treats everything as a player name and returns a string.lower
        target = string.upper(target);
        if (GL.Data.Constants.GroupLootActions[target]) then
            RollOnLoot(rollID, GL.Data.Constants.GroupLootActions[target]);
        end
    end);
end

--- Check if an item ID is ignored by default by PackMule (displayed in chat)
---
---@param itemID number
---@param callback function
---@return void
function PackMule:isItemIDIgnored(itemID, callback)
    GL:debug("PackMule:isItemIDIgnored");

    itemID = math.floor(tonumber(itemID));
    if (not GL:higherThanZero(itemID)) then
        return;
    end

    if (type(callback) ~= "function") then
        return;
    end

    --- Down below we override the getValidRules and GetLootMethod function and some
    --- user profile properties. This looks extremely nasty, but is the only surefire
    --- way of replicating in-raid/group PackMule behavior and test it properly!

    local OriginalGetValidRulesFunction = self.getValidRules;

    -- Make sure items of every quality have one valid rule
    self.getValidRules = function ()
        return {
            {
                target = "SELF NEED",
                quality = 1,
                operator = ">=",
            }
        };
    end;

    local oldGetLootMethod = GetLootMethod;
    local oldIsMasterLooter = GL:toboolean(GL.User.isMasterLooter);
    local oldIsInGroup = GL:toboolean(GL.User.isInGroup);
    local oldIsInParty = GL:toboolean(GL.User.isInParty);
    local oldIsInRaid = GL:toboolean(GL.User.isInRaid);

    -- We test the item against PackMule in a loot master setting first
    GetLootMethod = function () return "master"; end;
    GL.User.isMasterLooter = true;
    GL.User.isInGroup = true;
    GL.User.isInRaid = true;
    GL.User.isInParty = false;

    self:getTargetForItem(itemID, function(masterTarget)
        local itemIDisIgnoredForMaster = GL:empty(masterTarget);
        local Loot = GL.DB.Cache.ItemsById[tostring(itemID)] or {}; -- This is 100% set at this point

        -- We now test the item against PackMule in a group loot setting
        GetLootMethod = function () return "group"; end;
        GL.User.isMasterLooter = false;
        GL.User.isInGroup = true;
        GL.User.isInRaid = false;
        GL.User.isInParty = true;

        self:getTargetForItem(itemID, function(groupTarget)
            local itemIDisIgnoredForGroup = GL:empty(groupTarget);

            -- Reset everything
            self.getValidRules = OriginalGetValidRulesFunction;
            GetLootMethod = oldGetLootMethod;
            GL.User.isMasterLooter = oldIsMasterLooter;
            GL.User.isInGroup = oldIsInGroup;
            GL.User.isInRaid = oldIsInRaid;
            GL.User.isInParty = oldIsInParty;

            callback(Loot, itemIDisIgnoredForMaster, itemIDisIgnoredForGroup);
        end);
    end);

    -- Just in case the callback fails
    GL.Ace:ScheduleTimer(function()
        self.getValidRules = OriginalGetValidRulesFunction;
        GetLootMethod = oldGetLootMethod;
        GL.User.isMasterLooter = oldIsMasterLooter;
        GL.User.isInGroup = oldIsInGroup;
        GL.User.isInRaid = oldIsInRaid;
        GL.User.isInParty = oldIsInParty;
    end, 2);
end

--- Disable PackMule after a zone switch, unless enabled in settings
---
---@return void
function PackMule:zoneChanged()
    GL:debug("PackMule:zoneChanged");

    -- Disable packmule if the "persist after reload" setting is not enabled
    if (not Settings:get("PackMule.persistsAfterZoneChange")
        and Settings:get("PackMule.enabledForMasterLoot")
    ) then
        GL:warning("PackMule was automatically disabled after zone change");
        Settings:set("PackMule.enabledForMasterLoot", false);
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
    end
    self.processing = true;

    if (not self.Rules
        or not GL.User.isMasterLooter
    ) then
        self.processing = false;
        return;
    end

    for itemIndex = GetNumLootItems(), 1, -1 do
        (function()
            local _, _, _, _, _, locked = GetLootSlotInfo(itemIndex);

            -- Locked means that you aren't able to loot it (tinted red)
            if (locked) then
                return;
            end

            local itemLink = GetLootSlotLink(itemIndex);

            -- Some items don't have an itemLink (money for example)
            if (not itemLink) then
                return;
            end

            local itemID = GetItemInfoInstant(itemLink);
            if (not itemID) then -- Should not be possible, but better safe than lua error
                return;
            end

            -- Check if there is a preferred target for this item and if so: hand it out!
            self:getTargetForItem(itemID, function(target)
                if (not target) then
                    self.processing = false;
                    return;
                end

                -- These are group loot targets that don't apply when master looting
                if (GL:inTable({"PASS", "GREED", "NEED"}, target)) then
                    return;
                end

                for playerIndex = 1, GetNumGroupMembers() do
                    -- Make sure to do a case-insensitive check
                    if (string.lower(GetMasterLootCandidate(itemIndex, playerIndex) or "") == target) then
                        GiveMasterLoot(itemIndex, playerIndex);
                        return;
                    end
                end
            end);
        end)();

        -- Just a fail-safe to make sure processing doesn't end up in a stale mode
        GL.Ace:ScheduleTimer(function ()
            self.processing = false;
        end, 1);
    end
end

--- Return all valid rules from the PackMule configuration
---
---@return table
function PackMule:getValidRules()
    GL:debug("PackMule:getValidRules");

    local ValidRules = {};
    for _, Rule in pairs(self.Rules) do
        if (self:ruleIsValid(Rule)) then
            tinsert(ValidRules, Rule);
        end
    end

    return ValidRules;
end

--- Get the designated PackMule target for an item ID or link (no return, callback is needed because of async item lookup)
---
---@param itemLinkOrId string|number
---@param callback function
---@return void
function PackMule:getTargetForItem(itemLinkOrId, callback)
    GL:debug("PackMule:getTargetForItem");

    -- This method has no value without a callback
    if (type(callback) ~= "function") then
        return;
    end

    local concernsID = GL:higherThanZero(tonumber(itemLinkOrId));
    local itemID;

    if (concernsID) then
        itemID = math.floor(tonumber(itemLinkOrId));
    else
        itemID = GL:getItemIdFromLink(itemLinkOrId);
    end

    -- We can't work without an item ID!
    if (not GL:higherThanZero(itemID)) then
        return;
    end

    -- Load the item details first and then call the callback with the player target (only if any)
    GL:onItemLoadDo(itemID, function (Items)
        local Loot = Items[1];

        if (GL:empty(Loot)) then
            return;
        end

        local RuleThatApplies = false;

        for _, Entry in pairs(self:getValidRules()) do
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
            if (Loot.quality and quality and operator and target and (
                (operator == "=" and Loot.quality == quality)
                or (operator == ">" and Loot.quality > quality)
                or (operator == ">=" and Loot.quality >= quality)
                or (operator == "<" and Loot.quality < quality)
                or (operator == "<=" and Loot.quality <= quality)
            )) then
                local bindType = Loot.bindType or LE_ITEM_BIND_NONE;
                local bindOnPickup = GL:inTable({LE_ITEM_BIND_ON_ACQUIRE, LE_ITEM_BIND_QUEST}, bindType);

                local ruleApplies = (function ()
                    -- Check whether the item is whitelisted
                    if (GL:inTable(GL.Data.Constants.TradeableItems, itemID)) then
                        return true;
                    end

                    -- We ignore legendary+ loot for obvious reasons
                    if (Loot.quality >= 5) then
                        return false;
                    end

                    -- When group looting we have some additional rules
                    if (not GL.User.isMasterLooter) then
                        -- Skip companion pets in group loot even if they're BoE!
                        if (Loot.classID == LE_ITEM_CLASS_MISCELLANEOUS
                            and Loot.subclassID == Enum.ItemMiscellaneousSubclass.CompanionPet
                        ) then
                            return false;
                        end

                        -- Always skip recipes and quest items
                        if (GL:inTable(self.itemClassIdsToIgnore, Loot.classID)) then
                            return false;
                        end
                    end

                    -- Untradable items are skipped in quality rules whether they're BoP or not!
                    if (GL:inTable(GL.Data.Constants.UntradeableItems, itemID)) then
                        return false;
                    end

                    -- The item is not BoP so we can safely PackMule it
                    if (not bindOnPickup) then
                        return true;
                    end

                    -- When in group loot never auto loot anything that's BoP!
                    if (not GL.User.isMasterLooter) then
                        return false;
                    end

                    -- Recipes and Quest Items are skipped in quality rules
                    if (GL:inTable(self.itemClassIdsToIgnore, Loot.classID)) then
                        return false;
                    end

                    -- When masterloot is active PackMule doesn't mule BoP items unless in a raid or heroic instance
                    if (GL.User.isMasterLooter
                        and not GL.User.isInRaid
                        and not self.playerIsInHeroicInstance
                    ) then
                        return false;
                    end

                    return true;
                end)();

                if (ruleApplies) then
                    RuleThatApplies = Rule;
                end
            elseif (item and (
                (ruleConcernsItemID and ruleItemID == itemID) -- Item is an ID and the IDs match
                or (self:lootMatchesSpecificRule(Loot.name, item)) -- The rule's item name matches the loot name
            )) then
                -- We found an item-specific rule, we can stop checking now
                RuleThatApplies = Rule;
                break;
            end
        end

        -- There is no rule or we specifically want to ignore it
        if (not RuleThatApplies
            or RuleThatApplies.target == "IGNORE"
        ) then
            return callback(false);
        end

        local ruleTarget = strtrim(RuleThatApplies.target);
        local Targets = {};

        local RuleTargets = GL:strSplit(ruleTarget, " ");
        local GroupMemberNames = GL.User:groupMemberNames(true);

        for _, ruleTarget in pairs(RuleTargets) do
            local targetContainsExclamationMark = strfind(ruleTarget, "!");
            ruleTarget = strtrim(ruleTarget);
            ruleTarget = ruleTarget:gsub("!", "");

            if (not GL.User.isMasterLooter) then
                if (GL:inTable({"PASS", "GREED", "NEED"}, ruleTarget)) then
                    Targets = {ruleTarget};
                    break;
                end
            else
                -- SELF serves as a placeholder for the current player name
                if (ruleTarget == "SELF") then
                    ruleTarget = GL.User.name;

                -- DE serves as a placeholder for the registered disenchanter
                elseif (ruleTarget == "DE") then
                    ruleTarget = self.disenchanter;

                    if (GL:empty(self.disenchanter)) then
                        if (not self.noDisenchanterSetWarningGiving) then
                            GL:warning("No disenchanter set, use /gl sd [mydisenchanter] to set one");
                            self.noDisenchanterSetWarningGiving = true;
                        end

                        return callback(false); -- No point continuing, don't want the item to end up in the wrong hands!
                    end

                -- Check whether we need to give the item to a random player
                elseif (ruleTarget == "RANDOM") then
                    for _, Player in pairs(GL.User:groupMembers()) do
                        tinsert(Targets, string.lower(Player.name));
                    end

                    -- No need to continue, if a ML sets up RANDOM and something else
                    -- at the same time then he can expect some weird behavior.
                    break;
                end

                if (not GL:inTable({"PASS", "GREED", "NEED"}, ruleTarget)) then
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
        end

        -- Count the number of potential targets
        local numberOfTargets = #Targets;

        -- There is no potential target for this item!
        if (numberOfTargets < 1) then
            return callback(false);
        end

        -- Fetch a (random) target from the eligible target pool
        local target = string.lower(Targets[math.random(numberOfTargets)] or "");

        -- This should technically be impossible, but you never know!
        if (GL:empty(target)) then
            return callback(false);
        end

        return callback(target);
    end);
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
    GL:debug("PackMule:lootMatchesSpecificRule");

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
    byPassConfirmationDialog = GL:toboolean(byPassConfirmationDialog);

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
    GL:debug("PackMule:clearDisenchanter");

    self.disenchanter = nil;
end

--- sets the disenchanter
---
---@param disenchanter string
---@return void
function PackMule:setDisenchanter(disenchanter)
    GL:debug("PackMule:setDisenchanter");

    -- Better safe than lua error
    disenchanter = tostring(disenchanter);
    if (GL:empty(disenchanter)) then
        return;
    end

    if (not GL.User.isInGroup) then
        return GL:warning("You're not currently in a group");
    end

    self.disenchanter = disenchanter;

    GL:sendChatMessage(
        string.format("%s was set as disenchanter",
        self.disenchanter
    ), "GROUP");
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