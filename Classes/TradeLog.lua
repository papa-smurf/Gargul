---@type GL
local _, GL = ...;

---@class TradeLog
GL.TradeLog = {};

---@type TradeLog
local TradeLog = GL.TradeLog;

local DB = GL.DB;

--- Log all trades with partner/gold/enchant flags to make searching easier
---
---@param Details table
---
---@return void
function TradeLog:log(Details)
    DB.TradeLog.Trades = DB.TradeLog.Trades or {};
    DB.TradeLog.TradesByItem = DB.TradeLog.TradesByItem or {};
    DB.TradeLog.TradesWithPartner = DB.TradeLog.TradesWithPartner or {};
    DB.TradeLog.TradesInvolvingGold = DB.TradeLog.TradesInvolvingGold or {};
    DB.TradeLog.TradesInvolvingEnchant = DB.TradeLog.TradesInvolvingEnchant or {};

    local checksum = GetServerTime() + math.random(1, 9999) / 10000;
    Details.checksum = checksum;
    DB.TradeLog.Trades[checksum] = Details;

    -- Create a flag for this trade partner
    DB.TradeLog.TradesWithPartner[Details.partner] = DB.TradeLog.TradesWithPartner[Details.partner] or {};
    tinsert(DB.TradeLog.TradesWithPartner[Details.partner], checksum);

    -- Create item property flags
    for _, Entry in pairs(Details.myItems) do
        DB.TradeLog.TradesByItem[Entry.itemID] = DB.TradeLog.TradesByItem[Entry.itemID] or {};
        tinsert(DB.TradeLog.TradesByItem[Entry.itemID], checksum);
    end

    for _, Entry in pairs(Details.theirItems) do
        DB.TradeLog.TradesByItem[Entry.itemID] = DB.TradeLog.TradesByItem[Entry.itemID] or {};
        tinsert(DB.TradeLog.TradesByItem[Entry.itemID], checksum);
    end

    -- Create a flag for trades that involve gold
    if (Details.myGold > 0 or Details.theirGold > 0) then
        tinsert(DB.TradeLog.TradesInvolvingGold, checksum);
    end

    -- Create a flag for trades that involve enchants
    if (Details.EnchantedByMe.itemID or Details.EnchantedByThem.itemID) then
        tinsert(DB.TradeLog.TradesInvolvingEnchant, checksum);
    end
end

--- Fetch all trades that included the given item link or ID
---
---@param itemLinkOrID string|number
---
---@return table
function TradeLog:tradesByItem(itemLinkOrID)
    local itemID;
    local concernsID = GL:higherThanZero(tonumber(itemLinkOrID));

    if (concernsID) then
        itemID = math.floor(tonumber(itemLinkOrID));
    else
        itemID = GL:getItemIdFromLink(itemLinkOrID);
    end

    local Trades = {};
    for _, checksum in pairs(DB.TradeLog.TradesByItem) do
        tinsert(Trades, DB.TradeLog.Trades[checksum]);
    end
end

--- Fetch all trades with a given player
---
---@param player string
---@param exact nil|boolean
---@param fuzzy nil|boolean
---
---@return table
function TradeLog:tradesByPlayer(player, exact, fuzzy)
    player = string.lower(string.trim(player));
    exact = GL:toboolean(exact);
    fuzzy = GL:toboolean(fuzzy);

    local MatchingChecksums = {};
    for partner, Checksums in pairs(DB.TradeLog.TradesWithPartner) do
        (function()
            if (exact) then
                if (string.lower(partner) == player) then
                    GL:tableMerge(MatchingChecksums, Checksums);
                    return;
                end
            else
                if (fuzzy) then
                    if (GL:strStartsWith(partner, player)
                        or GL:levenshtein(partner, player) <= 5
                    ) then
                        GL:tableMerge(MatchingChecksums, Checksums);
                    end
                else
                    if (GL:strStartsWith(partner, player)) then
                        GL:tableMerge(MatchingChecksums, Checksums);
                        return;
                    end
                end
            end
        end)();
    end

    local Trades = {};
    for _, checksum in pairs(MatchingChecksums) do
        tinsert(Trades, DB.TradeLog.Trades[checksum]);
    end

    return Trades;
end

--- Simulate a trade
---
---@param Trade table
---
---@return void
function TradeLog:simulateTrade(Trade)
--[[
/script _G.Gargul.TradeLog:simulateTrade();
]]

    GL:error("HERE");

    GargulTradeFrame:Show();
    GargulTradeFrame:SetPoint("CENTER", UIParent, "CENTER");
    GargulTradeFrame:Show();
    print(GargulTradeFrame);

    if (true) then return; end

    TradeFrame:Show();

    --TradeFrame_OnLoad(TradeFrame);
    --TradeFrame_OnLoad(TradeFrame);
    ShowUIPanel(TradeFrame, 1);
    TradeFrameTradeButton_Enable();
    TradeFrame_Update(TradeFrame);
end

GL:debug("TradeLog.lua");