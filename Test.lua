---@type GL
local _, GL = ...;

---@class Test
GL.Test = {
    TradeState = {
        _initialized = false,
        Items = {},
    },
    PackMule = {},
};

local Test = GL.Test;

function Test.TradeState:_init(callback)
    if (self._initialized) then
        if (callback and type(callback) == "function") then
            return callback();
        end

        return;
    end

    self._initialized = true;
    local ItemIds = {};

    local ItemIDSources = {
        GL.Data.Constants.ItemsThatSouldntBeAnnounced,
        GL.Data.Constants.TradeableItems,
        GL.Data.Constants.UntradeableItems,
    };

    for _, itemIDSource in pairs(ItemIDSources) do
        for _, itemID in pairs(itemIDSource) do
            tinsert(ItemIds, itemID);
        end
    end

    -- Preload items
    GL:onItemLoadDo(ItemIds, function (ResultSet)
        self.Items = ResultSet;

        if (callback and type(callback) == "function") then
            callback();
        end
    end);
end

--- Build a default, fully decked out trade state
---
---@return table
function Test.TradeState:defaultState()
    local Details = {
        partner = GL.User.name,
        myGold = math.random(9999999),
        theirGold = math.random(9999999),
        MyItems = {},
        TheirItems = {},
        EnchantedByMe = {},
        EnchantedByThem = {},
    };

    local itemEnchantedByMe = self.Items[math.random(#self.Items)];
    Details.EnchantedByMe = {
        itemID = itemEnchantedByMe.id,
        quantity = 1,
        name = itemEnchantedByMe.name,
        itemLink = itemEnchantedByMe.link,
        enchantment = "Enchant Bracer - Minor Deflection",
        quality = 1,
        isUsable = true,
    };

    local itemEnchantedByThem = self.Items[math.random(#self.Items)];
    Details.EnchantedByThem = {
        itemID = itemEnchantedByThem.id,
        quantity = 1,
        name = itemEnchantedByThem.name,
        itemLink = itemEnchantedByThem.link,
        enchantment = "Enchant Bracer - Minor Deflection",
        quality = 1,
        isUsable = true,
    };

    for i = 1, 6 do
        local ItemEntry = self.Items[math.random(#self.Items)];

        Details.MyItems[i] = {
            quantity = math.random(20),
            name = ItemEntry.name,
            itemID = ItemEntry.id,
            quality = ItemEntry.quality,
            itemLink = ItemEntry.link,
        };
    end

    for i = 1, 6 do
        local ItemEntry = self.Items[math.random(#self.Items)];

        Details.TheirItems[i] = {
            quantity = math.random(20),
            name = ItemEntry.name,
            itemID = ItemEntry.id,
            quality = ItemEntry.quality,
            itemLink = ItemEntry.link,
        };
    end

    return Details;
end

--[[ Announce the default, decked out, trade state
/script _G.Gargul.Test.TradeState:announce()
]]
function Test.TradeState:announce()
    GL:success("Running Test.TradeState:announce() ...");

    self:_init(function ()
        local State = self:defaultState();

        -- It's not possible to trade gold against gold so one has to be disabled
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you give money to a player
/script _G.Gargul.Test.TradeState:iGaveGold()
]]
function Test.TradeState:iGaveGold()
    GL:success("Running Test.TradeState:iGaveGold() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.TheirItems = {};
        State.EnchantedByMe = {};
        State.EnchantedByThem = {};
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you receive money from a player
/script _G.Gargul.Test.TradeState:iReceivedGold()
]]
function Test.TradeState:iReceivedGold()
    GL:success("Running Test.TradeState:iReceivedGold() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.TheirItems = {};
        State.EnchantedByMe = {};
        State.EnchantedByThem = {};
        State.myGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you give an enchant for free
/script _G.Gargul.Test.TradeState:iEnchantedForFree()
]]
function Test.TradeState:iEnchantedForFree()
    GL:success("Running Test.TradeState:iEnchantedForFree() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.TheirItems = {};
        State.EnchantedByThem = {};
        State.myGold = 0;
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you receive an enchant for free
/script _G.Gargul.Test.TradeState:theyEnchantedForFree()
]]
function Test.TradeState:theyEnchantedForFree()
    GL:success("Running Test.TradeState:theyEnchantedForFree() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.TheirItems = {};
        State.EnchantedByMe = {};
        State.myGold = 0;
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you give an enchant and get a fee
/script _G.Gargul.Test.TradeState:iEnchantedForFee()
]]
function Test.TradeState:iEnchantedForFee(feeInCopper)
    GL:success("Running Test.TradeState:iEnchantedForFee() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.TheirItems = {};
        State.EnchantedByThem = {};
        State.myGold = 0;
        State.theirGold = feeInCopper or State.theirGold;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you give an enchant and get a fee
/script _G.Gargul.Test.TradeState:theyEnchantedForFee()
]]
function Test.TradeState:theyEnchantedForFee(feeInCopper)
    GL:success("Running Test.TradeState:theyEnchantedForFee() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.TheirItems = {};
        State.EnchantedByMe = {};
        State.myGold = feeInCopper or State.myGold;
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you give an enchant and give gold
/script _G.Gargul.Test.TradeState:iEnchantedIGaveGold()
]]
function Test.TradeState:iEnchantedIGaveGold(feeInCopper)
    GL:success("Running Test.TradeState:iEnchantedIGaveGold() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.TheirItems = {};
        State.EnchantedByThem = {};
        State.myGold = feeInCopper or State.myGold;
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you get an enchant and get gold
/script _G.Gargul.Test.TradeState:theyEnchantedTheyGaveGold()
]]
function Test.TradeState:theyEnchantedTheyGaveGold(feeInCopper)
    GL:success("Running Test.TradeState:theyEnchantedTheyGaveGold() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.TheirItems = {};
        State.EnchantedByMe = {};
        State.theirGold = feeInCopper or State.myGold;
        State.myGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if only you traded items
/script _G.Gargul.Test.TradeState:iTradedItems()
]]
function Test.TradeState:iTradedItems()
    GL:success("Running Test.TradeState:iTradedItems() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.TheirItems = {};
        State.EnchantedByMe = {};
        State.EnchantedByThem = {};
        State.myGold = 0;
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if only you received items
/script _G.Gargul.Test.TradeState:theyTradedItems()
]]
function Test.TradeState:theyTradedItems()
    GL:success("Running Test.TradeState:theyTradedItems() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.EnchantedByMe = {};
        State.EnchantedByThem = {};
        State.myGold = 0;
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you received items you paid for
/script _G.Gargul.Test.TradeState:iGaveGoldTheyTradedItems()
]]
function Test.TradeState:iGaveGoldTheyTradedItems()
    GL:success("Running Test.TradeState:iGaveGoldTheyTradedItems() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.EnchantedByMe = {};
        State.EnchantedByThem = {};
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you gave and received items
/script _G.Gargul.Test.TradeState:iTradedItemstheyTradedItems()
]]
function Test.TradeState:iTradedItemstheyTradedItems()
    GL:success("Running Test.TradeState:iTradedItemstheyTradedItems() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.EnchantedByMe = {};
        State.EnchantedByThem = {};
        State.myGold = 0;
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you get gold for items
/script _G.Gargul.Test.TradeState:theyGaveGoldITradedItems()
]]
function Test.TradeState:theyGaveGoldITradedItems()
    GL:success("Running Test.TradeState:theyGaveGoldITradedItems() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.TheirItems = {};
        State.EnchantedByMe = {};
        State.EnchantedByThem = {};
        State.myGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you give items and gold
/script _G.Gargul.Test.TradeState:iGaveGoldAndItems()
]]
function Test.TradeState:iGaveGoldAndItems()
    GL:success("Running Test.TradeState:iGaveGoldAndItems() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.TheirItems = {};
        State.EnchantedByMe = {};
        State.EnchantedByThem = {};
        State.theirGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Show what happens if you receive items and gold
/script _G.Gargul.Test.TradeState:theyGaveGoldAndItems()
]]
function Test.TradeState:theyGaveGoldAndItems()
    GL:success("Running Test.TradeState:theyGaveGoldAndItems() ...");

    self:_init(function ()
        local State = self:defaultState();

        State.MyItems = {};
        State.EnchantedByMe = {};
        State.EnchantedByThem = {};
        State.myGold = 0;

        GL.TradeWindow:announceTradeDetails(State);
    end);
end

--[[ Test all TradeState methods. Warning: this will get your chat messy!
/script _G.Gargul.Test.TradeState:all()
]]
function Test.TradeState:all()
    GL:success("Running Test.TradeState:all() ...");

    local timeout = .8;
    for name, Entry in pairs(Test.TradeState) do
        if (type(Entry) == "function"
            and name ~= "all"
            and name ~= "_init"
        ) then
            GL.Ace:ScheduleTimer(function ()
                Entry(Test.TradeState);
            end, timeout);

            timeout = timeout * 1.3;
        end
    end

    GL.Ace:ScheduleTimer(function ()
        GL:success("Done with Test.TradeState:all()!");
    end, timeout + 1);
end

--[[ Show who's eligible to get an item by it's ID (if any)
/script _G.Gargul.Test.PackMule:whoReceivesItem(18608, "group")
]]
function Test.PackMule:whoReceivesItem(itemID, lootMethod)
    GL:success("Running Test.PackMule:whoReceivesItem() ...");

    local oldGetLootMethod = GetLootMethod;
    local oldIsMasterLooter = GL:toboolean(GL.User.isMasterLooter);
    local oldIsInGroup = GL:toboolean(GL.User.isInGroup);
    local oldIsInParty = GL:toboolean(GL.User.isInParty);
    local oldIsInRaid = GL:toboolean(GL.User.isInRaid);
    GetLootMethod = function () return lootMethod; end;

    if (lootMethod == "master") then
        GL.User.isMasterLooter = true;
        GL.User.isInGroup = true;
        GL.User.isInRaid = true;
        GL.User.isInParty = false;
    elseif (lootMethod == "group") then
        GL.User.isMasterLooter = false;
        GL.User.isInGroup = true;
        GL.User.isInRaid = false;
        GL.User.isInParty = true;
    end

    GL.PackMule:getTargetForItem(itemID, function(target)
        if (not target) then
            return GL:error("No target for item ID: " .. itemID);
        end

        GetLootMethod = oldGetLootMethod;
        GL.User.isMasterLooter = oldIsMasterLooter;
        GL.User.isInGroup = oldIsInGroup;
        GL.User.isInRaid = oldIsInRaid;
        GL.User.isInParty = oldIsInParty;

        return GL:success("Item ID " .. itemID .. " will go to " .. target);
    end);

    -- Just in case the callback fails
    GL.Ace:ScheduleTimer(function()
        GetLootMethod = oldGetLootMethod;
        GL.User.isMasterLooter = oldIsMasterLooter;
        GL.User.isInGroup = oldIsInGroup;
        GL.User.isInRaid = oldIsInRaid;
        GL.User.isInParty = oldIsInParty;
    end, 1);
end