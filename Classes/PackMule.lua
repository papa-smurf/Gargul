--[[
    This class lets the master looter appoint "pack mules"
    The pack mules (player) will automatically receive all items
    that they're eligible for according to the rules as set up by the ML
]]
local _, App = ...;

App.PackMule = {
    _initialized = false,
    Rules = {},
    setupWindowIsActive = false,
};

local Utils = App.Utils;
local AceGUI = App.Ace.GUI;
local PackMule = App.PackMule;
local Settings = App.Settings;

function PackMule:_init()
    Utils:debug("PackMule:_init");

    -- No need to initialize this class twice
    if (self._initialized) then
        return;
    end

    -- Disable packmule if the "perist after reload" setting is not enabled
    if (not Settings:get("PackMule.persistsAfterReload")
        and Settings:get("PackMule.enabled")
    ) then
        Utils:warning("PackMule was automatically disabled after reload");
        Settings:set("PackMule.enabled", false);
    end

    self.Rules = Settings:get("PackMule.Rules");

    App.Events:register("PackMuleZoneChangeListener", "ZONE_CHANGED_NEW_AREA", self.zoneChanged);
    App.Events:register("DroppedLootLootReadyListener", "LOOT_READY", self.lootReady);

    self._initialized = true;
end

-- Disable PackMule after a zone switch, unless enabled in settings
function PackMule:zoneChanged()
    Utils:debug("PackMule:zoneChanged");

    -- Disable packmule if the "perist after reload" setting is not enabled
    if (not Settings:get("PackMule.persistsAfterZoneChange")
        and Settings:get("PackMule.enabled")
    ) then
        Utils:warning("PackMule was automatically disabled after zone change");
        Settings:set("PackMule.enabled", false);
    end
end

function PackMule:lootReady()
    Utils:debug("PackMule:lootReady");

    self = PackMule;

    if (not self.Rules) then
        return;
    end

    -- Make sure we only use valid rules
    local ValidRules = {};
    for key, Rule in pairs(self.Rules) do
        if (self:ruleIsValid(Rule)) then
            tinsert(ValidRules, Rule);
        end
    end

    -- There are no valid rules, no need to continue
    if (not ValidRules) then
        return;
    end

    local itemsLeft = false;
    for itemIndex = GetNumLootItems(), 1, -1 do
        local itemName, _, _, itemQuality, locked = select(2, GetLootSlotInfo(itemIndex));
        local itemLink = GetLootSlotLink(itemIndex);
        local RuleThatApplies = false;

        -- If the item is locked or doesn't have an item link (money or other currency) then we can safely skip it
        if (not locked and itemLink) then
            itemsLeft = true;

            for key, Rule in pairs(ValidRules) do
                local ruleApplies = false;
                local target = tostring(Rule.target or "");
                local operator = tostring(Rule.operator or "");
                local quality = tonumber(Rule.quality or "");

                if (quality and operator and target and (
                    (operator == "=" and itemQuality == quality)
                    or (operator == ">" and itemQuality > quality)
                    or (operator == "<" and itemQuality < quality)
                )) then
                    -- Non-tradeable items will only be handed out if there's a specific rule for it
                    if (Utils:inArray(App.Data.Constants.UntradeableItems, itemName)) then
                        Utils:warning(string.format(
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

    if (itemsLeft) then
        return self:lootReady();
    end
end

function PackMule:resetRules()
    Utils:debug("PackMule:resetRules");

    self.Rules = {};
    Settings:set("PackMule.Rules", self.Rules);
end

function PackMule:addRule(Rule)
    Utils:debug("PackMule:addRule");

    if (self:ruleIsValid(Rule)) then
        tinsert(self.Rules, Rule);
        Settings:set("PackMule.Rules", self.Rules);
    end
end

-- Check if a given rule is valid
function PackMule:ruleIsValid(Rule)
    Utils:debug("PackMule:ruleIsValid");

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
            not Utils:inArray({"=", "<", ">"}, Rule.operator)
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

Utils:debug("PackMule.lua");

-- ====================

--Made by Anilusion @ Gehennas EU
--function()
--local lootMethod, _, masterIndex = GetLootMethod()
--    if masterIndex then
--        local masterName = GetRaidRosterInfo(masterIndex)
--        if masterName == UnitName("player") then
--            for i = GetNumLootItems(), 1, -1 do
--                local itemName, _, _, itemQuality  = select(2, GetLootSlotInfo(i))
--                if string.match(itemName, "Splinter of Atiesh") then
--                    for ci = 1, GetNumGroupMembers() do
--                        if (GetMasterLootCandidate(i, ci) == aura_env.config.SplintersTarget) then
--                            GiveMasterLoot(i, ci);
--                        end
--                    end
--                elseif string.match(itemName, "Scrap") and itemQuality == 3 then
--                    for ci = 1, GetNumGroupMembers() do
--                        if (GetMasterLootCandidate(i, ci) == aura_env.config.ScrapsTarget) then
--                            GiveMasterLoot(i, ci);
--                        end
--                    end
--                elseif string.match(itemName, "Word of Thawing") then
--                    for ci = 1, GetNumGroupMembers() do
--                        if (GetMasterLootCandidate(i, ci) == aura_env.config.WordsTarget) then
--                            GiveMasterLoot(i, ci);
--                        end
--                    end
--                elseif string.match(itemName, "Frozen Rune") then
--                    for ci = 1, GetNumGroupMembers() do
--                        if (GetMasterLootCandidate(i, ci) == aura_env.config.RunesTarget) then
--                            GiveMasterLoot(i, ci);
--                        end
--                    end
--                elseif itemName == "Major Mana Potion" then
--                    for ci = 1, GetNumGroupMembers() do
--                        if (GetMasterLootCandidate(i, ci) == aura_env.config.ManaPotionTarget) then
--                            GiveMasterLoot(i, ci);
--                        end
--                    end
--                elseif itemName == "Major Healing Potion" then
--                    for ci = 1, GetNumGroupMembers() do
--                        if (GetMasterLootCandidate(i, ci) == aura_env.config.HealingPotionTarget) then
--                            GiveMasterLoot(i, ci);
--                        end
--                    end
--                elseif itemQuality == 2 then
--                    for ci = 1, GetNumGroupMembers() do
--                        if (GetMasterLootCandidate(i, ci) == aura_env.config.GreensTarget) then
--                            GiveMasterLoot(i, ci);
--                        end
--                    end
--                elseif itemQuality <= 1 then
--                    for ci = 1, GetNumGroupMembers() do
--                        if (GetMasterLootCandidate(i, ci) == aura_env.config.TrashTarget) then
--                            GiveMasterLoot(i, ci);
--                        end
--                    end
--                end
--            end
--        end
--    end
--end
--Made by Anilusion @ Gehennas EU

