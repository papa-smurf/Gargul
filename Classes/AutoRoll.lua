local L = Gargul_L;

---@type GL
local _, GL = ...;

---@class AutoRoll
---@field _initialized boolean
local AutoRoll = {
    _initialized = false,
};
GL.AutoRoll = AutoRoll;

local Profiles = GL.Profiles; ---@type Profiles

---@return boolean
function AutoRoll:_init()
    if (self._initialized) then
        return false;
    end

    -- Ensure a Default profile exists for new users
    local profiles = Profiles:getProfiles(Profiles.NAMESPACE_AUTOROLL);
    if (not next(profiles)) then
        Profiles:createProfile(Profiles.NAMESPACE_AUTOROLL, L["Default"], {});
    elseif (not Profiles:getActiveProfileID(Profiles.NAMESPACE_AUTOROLL)) then
        Profiles:setActiveProfile(Profiles.NAMESPACE_AUTOROLL, next(profiles));
    end

    local function onItemWon(_, AwardEntry)
        if (AwardEntry and GL:iEquals(AwardEntry.awardedTo, GL.User.fqn)) then
            local itemID = AwardEntry.itemID or GL:getItemIDFromLink(AwardEntry.itemLink);
            if (itemID) then
                self:setRule(itemID, "pass");
            end
        end
    end;
    GL.Events:register("AutoRollItemAwardedListener", "GL.ITEM_AWARDED", onItemWon);
    GL.Events:register("AutoRollItemAwardedEditedListener", "GL.ITEM_AWARD_EDITED", onItemWon);

    self._initialized = true;
    return true;
end

---@return boolean
function AutoRoll:enabled()
    return GL.Settings:get("AutoRoll.enabled", false);
end

---@param itemID number|string
---@return string|nil "need"|"greed"|"pass"
function AutoRoll:getRule(itemID)
    itemID = tonumber(itemID);
    if (not itemID) then
        return nil;
    end

    local data = Profiles:getProfileData(Profiles.NAMESPACE_AUTOROLL);
    -- SavedVariables may serialize numeric keys as strings; check both
    return data[itemID] or data[tostring(itemID)];
end

---@param itemID number|string
---@param action string "need"|"greed"|"pass"
---@return nil
function AutoRoll:setRule(itemID, action)
    itemID = tonumber(itemID);
    if (not itemID or not GL:inTable({ "need", "greed", "pass" }, action)) then
        return;
    end

    local data = Profiles:getProfileData(Profiles.NAMESPACE_AUTOROLL);
    data[itemID] = action;
    data[tostring(itemID)] = nil; -- Remove string key to avoid duplicates from SavedVariables
    Profiles:setProfileData(Profiles.NAMESPACE_AUTOROLL, data);
end

---@param itemID number|string
---@return nil
function AutoRoll:removeRule(itemID)
    itemID = tonumber(itemID);
    if (not itemID) then
        return;
    end

    local data = Profiles:getProfileData(Profiles.NAMESPACE_AUTOROLL);
    data[itemID] = nil;
    Profiles:setProfileData(Profiles.NAMESPACE_AUTOROLL, data);
end

---@return table
function AutoRoll:getAllRules()
    return Profiles:getProfileData(Profiles.NAMESPACE_AUTOROLL);
end

---@return boolean True if any profile (not just the active one) has at least one rule
function AutoRoll:hasAnyRulesInAnyProfile()
    for _, profile in pairs(Profiles:getProfiles(Profiles.NAMESPACE_AUTOROLL)) do
        if (profile and profile.data and next(profile.data)) then
            return true;
        end
    end
    return false;
end

--- Find the bracket in SupportedRolls for need (MS) or greed (OS).
--- Need = first bracket with concernsOS false; Greed = first with concernsOS true.
---
---@param SupportedRolls table
---@param action string "need"|"greed"
---@return number|nil min
---@return number|nil max
function AutoRoll:getBracketForAction(SupportedRolls, action)
    if (not SupportedRolls or #SupportedRolls == 0) then
        return nil, nil;
    end

    local wantOS = (action == "greed");

    for _, Bracket in pairs(SupportedRolls) do
        local identifier = Bracket[1];
        local min = math.floor(tonumber(Bracket[2]) or 0);
        local max = math.floor(tonumber(Bracket[3]) or 0);
        local concernsOS = Bracket[5];

        if (min and max and max >= min) then
            if (wantOS and concernsOS) then
                return min, max;
            end
            if (not wantOS and not concernsOS) then
                return min, max;
            end
        end
    end

    -- Fallback: need = first bracket, greed = second
    local first = SupportedRolls[1];
    local second = SupportedRolls[2];

    if (action == "need" and first) then
        return math.floor(tonumber(first[2]) or 1), math.floor(tonumber(first[3]) or 100);
    end
    if (action == "greed" and second) then
        return math.floor(tonumber(second[2]) or 1), math.floor(tonumber(second[3]) or 99);
    end

    return nil, nil;
end

--- Perform the roll based on the rule. Returns true if a roll was performed.
---
---@param itemLink string
---@param itemID number
---@param SupportedRolls table
---@param rule string "need"|"greed"
---@return boolean
function AutoRoll:performAutoRoll(itemLink, itemID, SupportedRolls, rule)
    if (rule ~= "need" and rule ~= "greed") then
        return false;
    end

    local min, max = self:getBracketForAction(SupportedRolls, rule);
    if (not min or not max) then
        return false;
    end

    RandomRoll(min, max);
    return true;
end

--- Check if SupportedRolls has exactly two brackets: first 1-100 (no OS), second 1-99 (OS).
--- Labels are ignored. Only RollTracking-style brackets (6 elements) count; BoostedRolls are excluded.
---
---@param SupportedRolls table
---@return boolean
function AutoRoll:areBracketsDefault(SupportedRolls)
    if (not SupportedRolls or #SupportedRolls ~= 2) then
        return false;
    end

    local rollTrackingBrackets = {};
    for _, b in ipairs(SupportedRolls) do
        if (type(b) == "table" and #b >= 6) then
            tinsert(rollTrackingBrackets, b);
        end
    end

    if (#rollTrackingBrackets ~= 2) then
        return false;
    end

    local first = rollTrackingBrackets[1];
    local second = rollTrackingBrackets[2];
    local firstMin = math.floor(tonumber(first[2]) or 0);
    local firstMax = math.floor(tonumber(first[3]) or 0);
    local firstOS = first[5];
    local secondMin = math.floor(tonumber(second[2]) or 0);
    local secondMax = math.floor(tonumber(second[3]) or 0);
    local secondOS = second[5];

    return firstMin == 1 and firstMax == 100 and not firstOS
        and secondMin == 1 and secondMax == 99 and secondOS;
end

--- Called when a roll starts. Returns handled, action. When handled is true, action is "rolled" or "passed".
---
---@param itemLink string
---@param itemID number
---@param SupportedRolls table
---@return boolean handled
---@return string|nil action "rolled"|"passed" when handled
function AutoRoll:onRollStart(itemLink, itemID, SupportedRolls)
    if (not self:enabled()) then
        return false;
    end

    if (not self:areBracketsDefault(SupportedRolls)) then
        return false;
    end

    local rule = self:getRule(itemID);
    if (not rule) then
        return false;
    end

    if (rule == "pass") then
        GL:success((L["You automatically passed on %s"]):format(itemLink));
        return true, "passed";
    end

    -- Delay the actual roll by 0.5 seconds so the automatic roll mesage doesn't preceed the raid leader's roll start message
    GL:after(0.5, "AutoRollDelay", function()
        local ok = self:performAutoRoll(itemLink, itemID, SupportedRolls, rule);
        if (ok) then
            local msg = rule == "need" and L["You automatically needed on %s"] or L["You automatically greeded on %s"];
            GL:success(msg:format(itemLink));
        end
    end);
    return true, "rolled";
end
