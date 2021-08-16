--[[
    This class lets the master looter appoint "pack mules"
    The pack mules (player) will automatically receive all items
    that they're eligible for according to the rules as set up by the ML
]]
local _, GL = ...;

GL.PackMule = {
    _initialized = false,
    processing = false,
    Rules = {},
    setupWindowIsActive = false,
};

local PackMule = GL.PackMule;
local Settings = GL.Settings;

function PackMule:_init()
    GL:debug("PackMule:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- Disable packmule if the "persist after reload" setting is not enabled
    -- This piece of logic is only run once on boot/reload hence why this works
    if (not Settings:get("PackMule.persistsAfterReload")
        and Settings:get("PackMule.enabled")
    ) then
        GL:warning("PackMule was automatically disabled after reload");
        Settings:set("PackMule.enabled", false);
    end

    self.Rules = Settings:get("PackMule.Rules");

    GL.Events:register("PackMuleZoneChangeListener", "ZONE_CHANGED_NEW_AREA", self.zoneChanged);

    GL.Events:register("PackMuleLootLootReadyListener", "LOOT_READY", function ()
        if (self.timerId) then
            GL.Ace:CancelTimer(self.timerId);
            self.timerId = false;
        end

        if (not Settings:get("PackMule.enabled")) then
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

    self._initialized = true;
end

-- Disable PackMule after a zone switch, unless enabled in settings
function PackMule:zoneChanged()
    GL:debug("PackMule:zoneChanged");

    -- Disable packmule if the "persist after reload" setting is not enabled
    if (not Settings:get("PackMule.persistsAfterZoneChange")
        and Settings:get("PackMule.enabled")
    ) then
        GL:warning("PackMule was automatically disabled after zone change");
        Settings:set("PackMule.enabled", false);
    end
end

-- Check all loot and implement applicable rules
function PackMule:lootReady()
    GL:debug("PackMule:lootReady");

    self = PackMule;

    if (self.processing) then
        return;
    else
        self.processing = true;
    end

    if (not self.Rules
        or not GL.User.isInRaid
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
        local itemName, _, _, itemQuality, locked = select(2, GetLootSlotInfo(itemIndex));
        local itemLink = GetLootSlotLink(itemIndex);
        local RuleThatApplies = false;

        -- If the item is locked or doesn't have an item link (money or other currency) then we can safely skip it
        if (not locked and itemLink) then
            for _, Rule in pairs(ValidRules) do
                -- This is useful to see in which order rules are being handled
                GL:debug(string.format(
                    "Item: %s\nOperator: %s\nQuality: %s\nTarget: %s",
                    Rule.item or "",
                    Rule.quality or "",
                    Rule.operator or "",
                    Rule.target or ""
                ));

                local target = tostring(Rule.target or "");
                local quality = tonumber(Rule.quality or "");
                local operator = tostring(Rule.operator or "");

                if (itemQuality and quality and operator and target and (
                    (operator == "=" and itemQuality == quality)
                    or (operator == ">" and itemQuality > quality)
                    or (operator == "<" and itemQuality < quality)
                )) then
                    -- Non-tradeable items will only be handed out if there's a specific rule for it
                    if (GL:inTable(GL.Data.Constants.UntradeableItems, itemName)) then
                        GL:warning(string.format(
                            "%s can not be traded after pickup and will not be handed out based on quality alone",
                            itemName
                        ));
                    else
                        RuleThatApplies = Rule;
                    end
                elseif (Rule.item and Rule.item == itemName) then
                    -- We found an item-specific rule, we can stop checking now
                    RuleThatApplies = Rule;
                    break;
                end
            end

            -- The rule applies, give it to the designated target
            if (RuleThatApplies) then
                for playerIndex = 1, GetNumGroupMembers() do
                    if (GetMasterLootCandidate(itemIndex, playerIndex) == RuleThatApplies.target) then
                        GiveMasterLoot(itemIndex, playerIndex);
                        break;
                    end
                end
            end
        end
    end

    self.processing = false;
end

-- Empty the ruleset
function PackMule:resetRules()
    GL:debug("PackMule:resetRules");

    self.Rules = {};
    Settings:set("PackMule.Rules", self.Rules);
end

-- Add a rule to the ruleset
function PackMule:addRule(Rule)
    GL:debug("PackMule:addRule");

    if (self:ruleIsValid(Rule)) then
        tinsert(self.Rules, Rule);
        Settings:set("PackMule.Rules", self.Rules);
    end
end

-- Check if a given rule is valid
function PackMule:ruleIsValid(Rule)
    GL:debug("PackMule:ruleIsValid");

    -- Every rule must have a target (who to give the item to)
    if (not Rule.target
        or type(Rule.target) ~= "string"
        or Rule.target == ""
    ) then
        return false;
    end

    -- If there's an operator then it has to be valid and there has to be a quality
    if (Rule.operator
        and (
            not GL:inTable({"=", "<", ">"}, Rule.operator)
            or not Rule.quality
            or type(Rule.quality) ~= "number"
        )
    ) then
        return false
    end

    -- If there's no operator then we need a specific item name to continue
    if (not Rule.operator
        and (
            not Rule.item
            or type(Rule.item) ~= "string"
            or Rule.item == ""
        )
    ) then
        return false;
    end

    return true;
end

GL:debug("PackMule.lua");