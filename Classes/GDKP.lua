---@type GL
local _, GL = ...;

---@class GDKP
GL.GDKP = {
    _initialized = false,
    broadcastInProgress = false,
    requestingData = false,
};

local DB = GL.DB; ---@type DB
local Constants = GL.Data.Constants; ---@type Data
local CommActions = Constants.Comm.Actions;
local Settings = GL.Settings; ---@type Settings
local GDKP = GL.GDKP; ---@type GDKP
local GameTooltip = GameTooltip; ---@type GameTooltip

--- @return boolean
function GDKP:_init()
    GL:debug("GDKP:_init");

    if (self._initialized) then
        return false;
    end

    GL.Interface.GDKP.Overview:draw();

    --- Register listener for whisper command
    GL.Events:register({
        {"GDKPChatMsgWhisper", "CHAT_MSG_WHISPER"},
        {"GDKPChatMsgParty", "CHAT_MSG_PARTY"},
        {"GDKPChatMsgPartyLeader", "CHAT_MSG_PARTY_LEADER"},
        {"GDKPChatMsgRaid", "CHAT_MSG_RAID"},
        {"GDKPChatMsgRaidLeader", "CHAT_MSG_RAID_LEADER"},
    }, function (event, message, sender)
        message = string.lower(message);
        message = message:gsub("%,", ".");

        -- No bid detected
        if (not message:find("(%d*%.?%d+)")) then
            return;
        end

        sender = GL:stripRealm(sender);
        local acceptClosedBids = false;

        -- We only accept bids in /w when we're accepting closed bids or when we're not in a group (e.g. testing)
        if (event == "CHAT_MSG_WHISPER"
            and not acceptClosedBids
            and GL.User.isInGroup)
        then
            local response = "I'm not accepting closed bids, use the /ra channel instead!";

            if (not GL.User.isInRaid) then
                response = "I'm not accepting closed bids, use the /gr channel instead!";
            end

            GL:sendChatMessage(response, "WHISPER", nil, sender);

            return;
        end

        local onlyAcceptRoundNumbers = true;
        local bid = tonumber(message:match("(%d*%.?%d+)"));
        local kModifier = bid < 100 or message:find("%d+k");

        if (kModifier) then
            bid = bid * 1000;
        end

        if (onlyAcceptRoundNumbers) then
            bid = GL:round(bid);
        end

        GL:dump(sender .. " bid: " .. bid);
    end);

    self._initialized = true;
    return true;
end

--- Restore the given auction
---
---@param sessionIdentifier string
---@param auctionIdentifier string
---
---@return void
function GDKP:restoreAuction(sessionIdentifier, auctionIdentifier)
    GL:debug("GDKP:restoreAuction");

    local Auction = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));

    -- The auction could not be found or is not deleted
    if (not Auction or Auction.price) then
        return false;
    end

    -- Sort the states on createdAt so that we can get the most recent state
    table.sort(Auction.PreviousStates, function (a, b)
        return a.createdAt > b.createdAt;
    end);

    local mostRecentStateIdentifier;
    local MostRecentState;
    for stateIdentifier, State in pairs(Auction.PreviousStates or {}) do
        mostRecentStateIdentifier = stateIdentifier;
        MostRecentState = State;

        break;
    end

    -- Better safe than lua error
    if (GL:empty(MostRecentState)) then
        return false;
    end

    Auction.winner = MostRecentState.winner;
    Auction.class = MostRecentState.class;
    Auction.price = MostRecentState.price;
    Auction.guild = MostRecentState.guild;

    -- Remove the restored state from the previous states table
    Auction.PreviousStates[mostRecentStateIdentifier] = nil;

    -- We don't point to Auction here, we want a copy not a pointer!
    local Before = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));
    DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier), Auction);

    GL.Events:fire("GL.GDKP_AUCTION_CHANGED", sessionIdentifier, auctionIdentifier, Before, Auction);
    GL.Events:fire("GL.GDKP_AUCTION_RESTORED", sessionIdentifier, auctionIdentifier);

    return true;
end

--- Delete the given auction
---
---@param sessionIdentifier string
---@param auctionIdentifier string
---
---@return void
function GDKP:deleteAuction(sessionIdentifier, auctionIdentifier)
    GL:debug("GDKP:deleteAuction");

    local Auction = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));

    -- The auction could not be found or is already deleted
    if (not Auction or not Auction.price) then
        return false;
    end
GL:dump("DELETE!");
    Auction.PreviousStates = Auction.PreviousStates or {};

    local PreviousState = {
        createdAt = GetServerTime(),
        winner = Auction.winner,
        class = Auction.class,
        price = Auction.price,
        guild = Auction.guild,
        CreatedBy = {
            class = GL.User.class,
            player = GL.User.name,
            guild = GL:tableGet(GL.User, "Guild.name") or nil,
            uuid = GL.User.id,
        },
    }

    -- Add a state so we can restore later if needed
    tinsert(Auction.PreviousStates, PreviousState);

    Auction.winner = nil;
    Auction.class = nil;
    Auction.price = nil;
    Auction.guild = nil;

    -- We don't point to Auction here, we want a copy not a pointer!
    local Before = DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier));
    DB:set(string.format("GDKP.Ledger.%s.Auctions.%s", sessionIdentifier, auctionIdentifier), Auction);

    GL.Events:fire("GL.GDKP_AUCTION_CHANGED", sessionIdentifier, auctionIdentifier, Before, Auction);
    GL.Events:fire("GL.GDKP_AUCTION_DELETED", sessionIdentifier, auctionIdentifier);

    return true;
end

--- Draw either the importer or overview
--- based on the current soft-reserve data
---
---@return void
function GDKP:draw()
    GL:debug("GDKP:draw");

    -- Show the soft-reserve overview after all items are loaded
    -- This is to ensure that all item data is available before we draw the UI
    GL:onItemLoadDo(
        self.MaterializedData.ReservedItemIds or {},
        function () GL.Interface.GDKP.Overview:draw(); end
    );
end

--- Check whether the current user is allowed to broadcast SoftRes data
---
---@return boolean
function GDKP:userIsAllowedToBroadcast()
    GL:debug("GDKP:userIsAllowedToBroadcast");

    return GL.User.isInGroup and (GL.User.isMasterLooter or GL.User.hasAssist);
end

GL:debug("GDKP.lua");