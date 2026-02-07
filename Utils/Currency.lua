---@type GL
local _, GL = ...;

local L = Gargul_L;

---@param copper number
---@return number
function GL:goldToCopper(copper)
    return math.floor(copper * 10000);
end

---@see GL:copperToMoney
function GL:goldToMoney(copper, Separators, includeEmpty, separatorBeforeUnit)
    copper = tonumber(copper) or 0;

    return self:copperToMoney(self:goldToCopper(copper), Separators, includeEmpty, separatorBeforeUnit);
end

--- Transform a copper value to a money string
---
--- copperToMoney(125000)                    > 12G 50S
--- copperToMoney(125000, nil, true)         > 12G 50S 0C
--- copperToMoney(125000, {".","",""}, true) > 12.5000
--- copperToMoney(125000, nil, true, true)   > G12 S50 C0
---
---@param copper number
---@param Separators table|nil
---
---@return string
function GL:copperToMoney(copper, Separators, includeEmpty, separatorBeforeUnit)
    local DefaultSeparators;

    if (copper < 1) then
        return "";
    end

    copper = self:floor(copper, 4);

    if (not separatorBeforeUnit) then
        DefaultSeparators = { L["g"] .. " ", L["s"] .. " ", L["c"] .. " ", };
    else
        DefaultSeparators = { " " .. L["g"], " " .. L["s"], " " .. L["c"], };
    end

    Separators = Separators or {};
    includeEmpty = GL:toboolean(includeEmpty);
    separatorBeforeUnit = GL:toboolean(separatorBeforeUnit);
    local goldSeparator = Separators[1] or DefaultSeparators[1];
    local silverSeparator = Separators[2] or DefaultSeparators[2];
    local copperSeparator = Separators[3] or DefaultSeparators[3];

    local gold = math.floor(copper / 10000);
    local silver = math.floor(copper / 100) % 100
    local copperLeft = copper % 100

    -- The user doesn't care about empty units, return as-is
    if (includeEmpty) then
        if (not separatorBeforeUnit) then
            return ("%s%s%s%s%s%s"):format(
                gold,
                goldSeparator,
                silver,
                silverSeparator,
                copperLeft,
                copperSeparator
            );
        else
            return ("%s%s%s%s%s%s"):format(
                goldSeparator,
                gold,
                silverSeparator,
                silver,
                copperSeparator,
                copperLeft
            );
        end
    end

    local money = "";

    if (gold > 0) then
        if (separatorBeforeUnit) then
            money = goldSeparator .. gold;
        else
            money = gold .. goldSeparator;
        end
    end

    if (silver > 0) then
        if (separatorBeforeUnit) then
            money = money .. silverSeparator .. silver;
        else
            money = money .. silver .. silverSeparator;
        end
    end

    if (copperLeft > 0) then
        if (separatorBeforeUnit) then
            money = money .. copperSeparator .. copperLeft;
        else
            money = money .. copperLeft .. copperSeparator;
        end
    end

    return strtrim(money);
end

---@param copper number
---@return string
---@see GL:copperToMoneyTexture
function GL:goldToMoneyTexture(copper)
    copper = tonumber(copper) or 0;

    return self:copperToMoneyTexture(self:goldToCopper(copper));
end

---@param copper number
---@return string
function GL:copperToMoneyTexture(copper)
    -- Make sure to account for negative numbers
    copper = math.abs(copper);

    return GL.GetCoinTextureString(copper);
end
