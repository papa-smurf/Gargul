local L = Gargul_L;

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

    ---@test /dump _G.Gargul.PackMule.processing
    processing = false,
    setupWindowIsActive = false,

    -- We ignore recipes and questitems by default
    -- since they might not always be tradably
    itemClassIDsToIgnore = {
        LE_ITEM_CLASS_RECIPE,
        LE_ITEM_CLASS_QUESTITEM,
    },

    playerIsInHeroicInstance = false,

    LootChangedTimer = nil,
    Rules = {},
    RoundRobinItems = {},
};

local PackMule = GL.PackMule; ---@type PackMule
local Settings = GL.Settings; ---@type Settings

--[[ CONSTANTS ]]
local LOOT_SLOT_MONEY = GL:tableGet(Enum or {}, "LootSlotType.Money", LOOT_SLOT_MONEY);

---@return void
function PackMule:_init()
    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    -- Check whether the user is in a heroic instance
    -- More info about difficultyIDs: https://wowpedia.fandom.com/wiki/DifficultyID
    local _, _, difficultyID = GetInstanceInfo();
    self.playerIsInHeroicInstance = GL:inTable({2, 174}, difficultyID);

    self.Rules = Settings:get("PackMule.Rules");

    GL.Events:register("PackMuleZoneChangeListener", "ZONE_CHANGED_NEW_AREA", function ()
        self:zoneChanged();

        -- Race conditions can cause initial GetInstanceInfo calls to return the previous instance
        GL:after(2, "PackMuleZoneChanged", function ()
            self:zoneChanged();
        end);
    end);

    GL.Events:register("PackMuleUserLeftGroupListener", "GL.USER_LEFT_GROUP", function ()
        self:leftGroup();
    end);

    -- Whenever an item drops that is eligible for rolling trigger the highlighter and packmule rules
    GL.Events:register("PackMuleStartLootRollListener", "START_LOOT_ROLL", function (_, rollID)
        self:processGroupLootItems(rollID);
    end);

    GL.Events:register("PackMuleLootLootAnnouncedListener", "GL.LOOT_ANNOUNCED", function ()
        if (self.LootChangedTimer) then
            GL:debug("Cancel PackMule.LootChangedTimer");

            GL.Ace:CancelTimer(self.LootChangedTimer);
            self.LootChangedTimer = nil;
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
        GL:debug("Schedule new PackMule.LootChangedTimer");
        self.LootChangedTimer = GL.Ace:ScheduleRepeatingTimer(function ()
            GL:debug("Run PackMule.LootChangedTimer");

            self:lootReady();
        end, .2);
    end);

    -- Make sure to auto accept BoP loot when rolling on items
    GL.Events:register("PackMuleConfirmLootRollListener", "CONFIRM_LOOT_ROLL", function (_, rollID, roll)
        if (not GL.Settings:get("PackMule.autoConfirmGroup")) then
            return;
        end

        ConfirmLootRoll(rollID, roll);
        StaticPopup_Hide("CONFIRM_LOOT_ROLL");
    end);

    -- Always auto loot gold
    GL.Events:register("PackMuleLootReadyListener", "LOOT_READY", function ()
        -- Shift should disable this
        if (IsShiftKeyDown()
            or not Settings:get("PackMule.lootGold")
        ) then
            return;
        end

        local slotType = GetLootSlotType(1);
        if (slotType == LOOT_SLOT_MONEY) then
            local guid = GetLootSourceInfo(1);

            -- Exclude gold from items (lockboxes etc)
            if (GL:strStartsWith(guid, "Item-")) then
                return;
            end

            LootSlot(1);
        end
    end);

    -- Make sure to auto accept BoP loot when opening containers
    GL.Events:register("PackMuleLootOpenedListener", "LOOT_OPENED", function ()
        if (IsShiftKeyDown() -- Shift should disable this
            or (GL.User.isInGroup and not GL.Settings:get("PackMule.autoConfirmGroup"))
            or (not GL.User.isInGroup and not GL.Settings:get("PackMule.autoConfirmSolo"))
        ) then
            return;
        end

        -- Auto confirm loot you open (lockbox etc)
        local lootThreshold = GetLootThreshold();
        for itemIndex = GetNumLootItems(), 1, -1 do
            local itemLink = GetLootSlotLink(itemIndex);
            local _, _, _, _, quality, locked = GetLootSlotInfo(itemIndex);

            -- We have to make sure that the item is lootable before we attempt to
            if (itemLink and not locked and quality and (not GL.User.isInGroup or quality < lootThreshold)) then
                LootSlot(itemIndex);
                ConfirmLootSlot(itemIndex);
            end
        end
    end);

    -- Make sure we stop checking the loot window after the player is done looting
    GL.Events:register("PackMuleLootClosedListener", "LOOT_CLOSED", function ()
        if (self.LootChangedTimer) then
            GL:debug("Cancel PackMule.LootChangedTimer");

            GL.Ace:CancelTimer(self.LootChangedTimer);
            self.LootChangedTimer = nil;
        end
    end);
end

--- PASS/NEED/GREED on group loot items based on PackMule rules
---
---@param rollID number
---@return void
function PackMule:processGroupLootItems(rollID)
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
                target = L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER .. " " .. L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER,
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
        local Loot = GL:getCachedItem(itemID) or {}; -- This should be 100% set at this point

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

---@param itemID number
---@param callback function
---@return void
function PackMule:currentTargetForItemForGroupOrMaster(itemID, callback)
    itemID = math.floor(tonumber(itemID));
    if (not GL:higherThanZero(itemID)) then
        return;
    end

    if (type(callback) ~= "function") then
        return;
    end

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
        local Loot = GL:getCachedItem(itemID) or {}; -- This should be 100% set at this point

        -- We now test the item against PackMule in a group loot setting
        GetLootMethod = function () return "group"; end;
        GL.User.isMasterLooter = false;
        GL.User.isInGroup = true;
        GL.User.isInRaid = false;
        GL.User.isInParty = true;

        self:getTargetForItem(itemID, function(groupTarget)
            -- Reset everything
            GetLootMethod = oldGetLootMethod;
            GL.User.isMasterLooter = oldIsMasterLooter;
            GL.User.isInGroup = oldIsInGroup;
            GL.User.isInRaid = oldIsInRaid;
            GL.User.isInParty = oldIsInParty;

            callback(Loot, masterTarget, groupTarget);
        end);
    end);

    -- Just in case the callback fails
    GL.Ace:ScheduleTimer(function()
        GetLootMethod = oldGetLootMethod;
        GL.User.isMasterLooter = oldIsMasterLooter;
        GL.User.isInGroup = oldIsInGroup;
        GL.User.isInRaid = oldIsInRaid;
        GL.User.isInParty = oldIsInParty;
    end, 2);
end

--- Disable PackMule after leaving a group
---
---@return void
function PackMule:leftGroup()
    if (Settings:get("PackMule.autoDisableForGroupLoot")) then
        Settings:set("PackMule.enabledForGroupLoot", false);
    end
end

--- Check whether the user is in a heroic instance
---
---@return void
function PackMule:zoneChanged()
    -- Check whether the user is in a heroic instance
    -- More info about difficultyIDs: https://wowpedia.fandom.com/wiki/DifficultyID
    local _, _, difficultyID = GetInstanceInfo();
    self.playerIsInHeroicInstance = GL:inTable({2, 174}, difficultyID);
end

--- Check all loot and implement applicable rules
---
---@return void
function PackMule:lootReady()
    if (self.processing) then
        return;
    end

    self.processing = true;

    -- Safety feature to make sure we can't end up in a locked state
    GL:after(.5, "PackMuleResetProcessingFlag", function ()
        self.processing = false;
    end);

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

            local itemID = GL:getItemInfoInstant(itemLink);
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
                if (GL:inTable({ L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER, L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER, L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER }, target)) then
                    return;
                end

                target = GL:nameFormat(target);
                for playerIndex = 1, GetNumGroupMembers() do
                    if (GL:iEquals(GetMasterLootCandidate(itemIndex, playerIndex) or "", target)) then
                        GiveMasterLoot(itemIndex, playerIndex);
                        return;
                    end
                end
            end);
        end)();
    end

    self.processing = false;
end

--- Return all valid rules from the PackMule configuration
---
---@return table
---@test /dump _G.Gargul.PackMule:getValidRules();
function PackMule:getValidRules()
    local ValidRules = {};
    for _, Rule in pairs(self.Rules) do
        if (self:ruleIsValid(Rule)) then
            tinsert(ValidRules, Rule);
        end
    end

    -- Sort the rules, item ID specific rules first
    table.sort(ValidRules, function (a, b)
        aItem = a and a.item or false;
        bItem = b and b.item or false;

        -- This is to make sure we support item names, IDs and links
        local ruleAConcernsItemID = false;
        local ruleAItemID = tonumber(aItem) or GL:getItemIDFromLink(aItem);
        if (ruleAItemID) then
            ruleAItemID = math.floor(ruleAItemID);
            ruleAConcernsItemID = GL:higherThanZero(ruleAItemID);
        end

        local ruleBConcernsItemID = false;
        local ruleBItemID = tonumber(bItem) or GL:getItemIDFromLink(bItem);
        if (ruleBItemID) then
            ruleBItemID = math.floor(ruleBItemID);
            ruleBConcernsItemID = GL:higherThanZero(ruleBItemID);
        end

        aNum = ruleAConcernsItemID and ruleAItemID or 999999999999;
        bNum = ruleBConcernsItemID and ruleBItemID or 999999999999;

        return aNum < bNum;
    end);

    return ValidRules;
end

--- Get the designated PackMule target for an item ID or link (no return, callback is needed because of async item lookup)
---
---@param itemLinkOrId string|number
---@param callback function
---@return void
function PackMule:getTargetForItem(itemLinkOrId, callback)
    -- This method has no value without a callback
    if (type(callback) ~= "function") then
        return;
    end

    local concernsID = GL:higherThanZero(tonumber(itemLinkOrId));
    local itemID;

    if (concernsID) then
        itemID = math.floor(tonumber(itemLinkOrId));
    else
        itemID = GL:getItemIDFromLink(itemLinkOrId);
    end

    -- We can't work without an item ID!
    if (not GL:higherThanZero(itemID)) then
        return;
    end

    -- Load the item details first and then call the callback with the player target (only if any)
    local ValidRules = self:getValidRules();
    GL:onItemLoadDo(itemLinkOrId, function (Details)
        if (not Details) then
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
            local target = strtrim(tostring(Entry.target or ""));
            local quality = tonumber(Entry.quality or "");
            local operator = tostring(Entry.operator or "");

            -- The potential target replacement above requires us
            -- To make a local copy of the current Rule entry
            local Rule = {
                item = item,
                target = target,
                quality = quality,
                operator = operator,
            };

            -- This is to make sure we support item names, IDs and links
            local ruleConcernsItemID = false;
            local ruleItemID = tonumber(item) or GL:getItemIDFromLink(item);
            if (ruleItemID) then
                ruleItemID = math.floor(ruleItemID);
                ruleConcernsItemID = GL:higherThanZero(ruleItemID);
            end

            -- Check if this is a non item-specific rule (aka quality based rule)
            if (Details.quality and quality and operator and target and (
                (operator == "=" and Details.quality == quality)
                or (operator == ">" and Details.quality > quality)
                or (operator == ">=" and Details.quality >= quality)
                or (operator == "<" and Details.quality < quality)
                or (operator == "<=" and Details.quality <= quality)
            )) then
                local bindType = Details.bindType or Enum.ItemBind.None;
                local bindOnPickup = GL:inTable({ Enum.ItemBind.OnAcquire, Enum.ItemBind.Quest }, bindType);

                local ruleApplies = (function ()
                    -- Check whether the item is whitelisted
                    if (GL:inTable(GL.Data.Constants.TradableItems, itemID)) then
                        return true;
                    end

                    -- We ignore legendary+ loot for obvious reasons
                    if (Details.quality >= 5) then
                        return false;
                    end

                    -- When group looting we have some additional rules
                    if (not GL.User.isMasterLooter) then
                        -- Skip companion pets in group loot even if they're BoE!
                        if (Details.classID == LE_ITEM_CLASS_MISCELLANEOUS
                            and Details.subclassID == Enum.ItemMiscellaneousSubclass.CompanionPet
                        ) then
                            return false;
                        end

                        -- Always skip recipes and quest items
                        if (GL:inTable(self.itemClassIDsToIgnore, Details.classID)) then
                            return false;
                        end
                    end

                    -- Untradable items are skipped in quality rules whether they're BoP or not!
                    if (GL:inTable(GL.Data.Constants.UntradableItems, itemID)) then
                        return false;
                    end

                    -- The item is not BoP so we can safely PackMule it
                    if (not bindOnPickup) then
                        return true;
                    end

                    -- When in group loot never auto need anything that's BoP unless you have lead or assist!
                    if (not GL.User.isMasterLooter
                        and not GL.User.hasAssist
                        and not GL.Settings:get("PackMule.needWithoutAssist")
                        and strfind(target, L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER)
                    ) then
                        return false;
                    end

                    -- Recipes and Quest Items are skipped in quality rules
                    if (GL:inTable(self.itemClassIDsToIgnore, Details.classID)) then
                        return false;
                    end

                    -- PackMule doesn't pack BoP items unless in a raid or heroic instance
                    if (not GL.User.isInRaid
                        and not self.playerIsInHeroicInstance ---@todo: ADD ALL RAID FORMS TO THIS TO REPLACE isInRaid
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
                or (self:lootMatchesSpecificRule(Details.name, item)) -- The rule's item name matches the loot name
            )) then
                -- We found an item-specific rule, we can stop checking now
                RuleThatApplies = Rule;
                break;
            end
        end

        -- There is no rule or we specifically want to ignore it
        if (not RuleThatApplies
            or RuleThatApplies.target == L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER
        ) then
            return callback(false);
        end

        local ruleTarget = strtrim(RuleThatApplies.target);
        local Targets = {};

        local RuleTargets = GL:explode(ruleTarget, " ");
        local GroupMemberNames = GL.User:groupMemberNames(true);

        for _, ruleTarget in pairs(RuleTargets) do
            local targetContainsExclamationMark = strfind(ruleTarget, "!");
            ruleTarget = strtrim(ruleTarget);
            ruleTarget = ruleTarget:gsub("!", "");


            if (not GL.User.isMasterLooter) then
                if (GL:inTable({ L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER, L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER, L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER }, ruleTarget)) then
                    Targets = {ruleTarget};
                    break;
                end
            else
                -- SELF serves as a placeholder for the current player name
                if (ruleTarget == L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER) then
                    ruleTarget = GL.User.fqn;

                -- DE serves as a placeholder for the registered disenchanter
                elseif (ruleTarget == L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER) then
                    ruleTarget = self.disenchanter;

                    if (GL:empty(self.disenchanter)) then
                        if (not self.noDisenchanterSetWarningGiving) then
                            GL:warning(L.PACKMULE_NO_DISENCHANTER_WARNING);
                            self.noDisenchanterSetWarningGiving = true;
                        end

                        return callback(false); -- No point continuing, don't want the item to end up in the wrong hands!
                    end

                -- RR placeholder represents the next player in a round robin scheme for this rule
                elseif (ruleTarget == L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER) then
                    ruleTarget = self:roundRobinTargetForRule(RuleThatApplies);

                -- Check whether we need to give the item to a random player
                elseif (ruleTarget == L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER) then
                    for _, Player in pairs(GL.User:groupMembers()) do
                        -- No need giving items to a random who's offline
                        if (Player.online) then
                            tinsert(Targets, GL:nameFormat(Player.fqn));
                        end
                    end

                    -- No need to continue, if a ML sets up RANDOM and something else
                    -- at the same time then he can expect some weird behavior.
                    break;
                end

                if (not GL:inTable({ L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER, L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER, L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER }, ruleTarget)) then
                    ruleTarget = GL:addRealm(ruleTarget);

                    -- GroupMemberNames are always in lowercase
                    if (GL:inTable(GroupMemberNames, ruleTarget)) then
                        -- This is a high prio target, return it and stop checking
                        if (targetContainsExclamationMark) then
                            Targets = { ruleTarget };
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
    self.Rules = {};
    Settings:set("PackMule.Rules", self.Rules);
end

--- Add a rule to the ruleset
---
---@param Rule table
---@return void
function PackMule:addRule(Rule)
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
---@param callback function
---@return void
function PackMule:disenchant(itemLink, byPassConfirmationDialog, callback)
    if (GL.User.isInGroup
        and not GL.User.isMasterLooter
        and not GL.User.hasAssist
        and not GL.User.isLead
    ) then
        return GL:warning(L.LM_OR_ASSIST_REQUIRED);
    end

    if (type(callback) ~= "function") then
        callback = function () end;
    end

    local itemID = GL:getItemIDFromLink(itemLink);
    byPassConfirmationDialog = GL:toboolean(byPassConfirmationDialog);

    -- Make sure an itemlink was provided
    if (not GL:higherThanZero(itemID)) then
        callback(false);
        return;
    end

    -- We show the player selector if there is no disenchanter
    -- set yet or if the old disenchanter is not in our group
    if (GL:empty(self.disenchanter)
        or not GL.User:unitInGroup(self.disenchanter)
    ) then
        local PlayerNames = {};
        for _, Player in pairs(GL.User:groupMembers()) do
            tinsert(PlayerNames, Player.fqn);
        end

        -- Show the player selector
        GL.Interface.PlayerSelector:draw(L.PACKMULE_WHO_IS_DISENCHANTER, PlayerNames, function (playerName)
            GL.Interface.Dialogs.PopupDialog:open{
                question = (L.PACKMULE_CONFIRM_DISENCHANTER):format(GL:nameFormat{ name = playerName, colorize = true, }),
                OnYes = function ()
                    self:setDisenchanter(playerName);
                    self:disenchant(itemLink, true, callback);

                    GL.Interface.PlayerSelector:close();
                end,
            };
        end);

        return;
    end

    if (byPassConfirmationDialog) then
        self:assignLootToPlayer(itemID, self.disenchanter);
        GL.Interface.PlayerSelector:close();
        GL.AwardedLoot:addWinner{
            winner = GL.Exporter.disenchantedItemIdentifier,
            itemLink = itemLink,
            announce = false,
        };
        self:announceDisenchantment(itemLink);
        callback(true);

        return;
    end

    -- Make sure the initiator confirms his choice
    GL.Interface.Dialogs.PopupDialog:open{
        question = (L.PACKMULE_CONFIRM_DISENCHANTMENT):format(
            itemLink,
            GL:nameFormat{ name = self.disenchanter, colorize = true, }
        ),
        OnYes = function ()
            self:assignLootToPlayer(itemID, self.disenchanter);
            GL.Interface.PlayerSelector:close();
            GL.AwardedLoot:addWinner{
                winner = GL.Exporter.disenchantedItemIdentifier,
                itemLink = itemLink,
                announce = false,
            };
            self:announceDisenchantment(itemLink);
            callback(true);
        end,
    };
end

--- Clear the disenchanter
---
---@return void
function PackMule:clearDisenchanter()
    self.disenchanter = nil;
end

--- sets the disenchanter
---
---@param disenchanter string
---@return void
function PackMule:setDisenchanter(disenchanter)
    -- Better safe than lua error
    disenchanter = tostring(disenchanter);
    if (GL:empty(disenchanter)) then
        return;
    end

    self.disenchanter = GL:addRealm(disenchanter);

    GL:sendChatMessage(
        (L.CHAT.PACKMULE_DISENCHANTER_SET):format(GL:nameFormat(self.disenchanter)),
        "GROUP"
    );
end

--- Announce the disenchantment of an item in the group chat
---
---@param itemLink string
---@return void
function PackMule:announceDisenchantment(itemLink)
    if (not GL.Settings:get("PackMule.announceDisenchantedItems")) then
        return
    end

    GL:sendChatMessage(
        (L.CHAT.PACKMULE_DISENCHANTMENT_NOTICE):format(itemLink, GL:disambiguateName(self.disenchanter)),
        "GROUP"
    );
end

--- Returns next target player in a round robin fashion for a particular rule item
---
---@param Rule string
---@return string?
function PackMule:roundRobinTargetForRule(Rule)
    local ruleId = Rule.quality;
    if (not GL:empty(Rule.item)) then
        ruleId = Rule.item;
    end

    -- This is apparently possible?
    if (not ruleId) then
        return;
    end

    -- first time we've seen this item
    if (not self.RoundRobinItems[ruleId]) then
        self.RoundRobinItems[ruleId] = {};
    end

    local EligiblePlayers = {};
    for _, Player in pairs(GL.User:groupMembers()) do
        local player = string.lower(Player.fqn);

        -- this player hasn't received one of these items yet
        if (Player.online and not self.RoundRobinItems[ruleId][player]) then
            tinsert(EligiblePlayers, player);
        end
    end

    -- Count the number of potential targets
    local numberOfTargets = #EligiblePlayers;

    if (numberOfTargets < 1) then
        -- everyone has received one of these, start over
        GL:debug("PackMule:roundRobinTargetForRule - starting over");
        self.RoundRobinItems[ruleId] = {};

        return self:roundRobinTargetForRule(Rule);
    end

    -- Fetch a (random) target from the eligible target pool
    local targetPlayer = EligiblePlayers[math.random(numberOfTargets)] or false;

    -- Something else went wrong, this shouldn't be possible!
    if (not targetPlayer) then
        return GL:error("Something went wrong determining a target in 'roundRobinTargetForRule'. Contact support!");
    end

    self.RoundRobinItems[ruleId][targetPlayer] = 1;
    return targetPlayer;
end

--- Assign a item to a player
---
---@param itemID number
---@param playerName string
---@return void
function PackMule:assignLootToPlayer(itemID, playerName)
    -- Try to determine the loot index of the item
    local itemIndex = false;
    local itemCount = GetNumLootItems();
    for lootIndex = 1, itemCount do
        local itemLink = GetLootSlotLink(lootIndex);
        local lootItemID = GL:getItemIDFromLink(itemLink);

        if (lootItemID and lootItemID == itemID) then
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

        if (candidate) then
            candidate = GL:addRealm(candidate);

            if (candidate and GL:iEquals(candidate, playerName)) then
                playerIndex = Player.index;
                break;
            end
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
