local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type TMB
local TMB = GL.TMB;

---@class RollOff
GL.RollOff = GL.RollOff or {
    inProgress = false,
    listeningForRolls = false,
    rollPattern = GL:createPattern(RANDOM_ROLL_RESULT), -- This pattern is used to validate incoming rules
    CountDownTimer = nil,
    CurrentRollOff = {
        initiator = nil, -- The player who started the roll off
        time = nil, -- The amount of time players get to roll
        itemID = nil, -- The ID of the item we're rolling for
        itemName = nil, -- The name of the item we're rolling for
        itemLink = nil, -- The item link of the item we're rolling for
        itemIcon = nil, -- The icon of the item we're rolling for
        note = nil, -- The note displayed on the progress bar
        Rolls = {}, -- Player rolls
    },
    InitiateCountDownTimer = nil;
    StopRollOffTimer = nil,
    rollListenerCancelTimerId = nil,
};
local RollOff = GL.RollOff; ---@type RollOff

local CommActions = GL.Data.Constants.Comm.Actions;
local Events = GL.Events; ---@type Events

--- Announce to everyone in the raid that a roll off is starting
---
---@param itemLink string
---@param time number
---@param note string|nil
---@return boolean
function RollOff:announceStart(itemLink, time, note)
    time = tonumber(time);

    if (not GL:isValidItemLink(itemLink)) then
        GL:warning(L["Invalid data provided for roll start!"]);
        return false;
    end

    if (not GL:gte(time, 5)) then
        GL:warning(L["Timer needs to be 5 seconds or more"]);
        return false;
    end

    -- Clear the rolls table whenever a new item is rolled off
    if (not GL:empty(self.CurrentRollOff.itemLink)
        and self.CurrentRollOff.itemLink ~= itemLink
    ) then
        self:reset();
        GL.MasterLooterUI:reset(true);

        -- This is a new item so make sure to
        -- override all previously set properties
        self.CurrentRollOff = self.CurrentRollOff or {};
        self.CurrentRollOff.Rolls = {};
    end

    self:stopListeningForRolls();
    self:listenForRolls();

    --- If boosted rolls are enabled, sending additional data is required
    local BoostedRolls;

    if (GL.BoostedRolls:enabled()
        and GL.BoostedRolls:available()
    ) then
        BoostedRolls = {};
        BoostedRolls.identifier = string.sub(GL.Settings:get("BoostedRolls.identifier", "BR"), 1, 3);
        BoostedRolls.RangePerPlayer = {};

        for _, Player in pairs(GL.User:groupMembers()) do
            (function()
                local normalizedName = GL.BoostedRolls:normalizedName(Player.fqn);
                if (not GL.BoostedRolls:hasPoints(normalizedName)) then
                    return;
                end

                local points = GL.BoostedRolls:getPoints(normalizedName);
                BoostedRolls.RangePerPlayer[normalizedName] = ("%d-%d"):format(GL.BoostedRolls:minBoostedRoll(points), GL.BoostedRolls:maxBoostedRoll(points));
            end)();
        end
    end

    GL.CommMessage.new{
        action = CommActions.startRollOff,
        content = {
            item = itemLink,
            time = time,
            note = note,
            bth = GL.User:bth(),
            SupportedRolls = GL.Settings:get("RollTracking.Brackets", {}) or {},
            BoostedRollData = BoostedRolls,
        },
        channel = "GROUP",
    }:send();

    GL.Settings:set("UI.RollOff.timer", time);

    return true;
end

---@param itemLink string
---@param time number
---@param note string|nil
function RollOff:postStartMessage(itemLink, time, note)
    -- The user doesn't want to announce anything in chat
    if (not GL.Settings:get("MasterLooting.announceRollStart")) then
        return true;
    end

    local announceMessage = (L.CHAT["You have %s seconds to roll on %s"]):format(
        time,
        itemLink
    );
    local eligiblePlayersMessage = false;
    local Reserves = GL.SoftRes:playerReserveAmountsByItemLink(itemLink);
    local TMBDetails = TMB:byItemLink(itemLink);

    if (type(note) == "string"
        and not GL:empty(note)
    ) then
        announceMessage = (L.CHAT["You have %s seconds to roll on %s"] .. " - " .. note):format(
            time,
            itemLink
        );
    end

    -- Check if this item was reserved, if so: mentioned the players who reserved it!
    if (GL.Settings:get("SoftRes.announceInfoWhenRolling")
        and not GL:empty(Reserves)
    ) then
        Reserves = table.concat(Reserves, ", ");
        eligiblePlayersMessage = (L.CHAT["This item was reserved by: %s"]):format(Reserves);

    -- Check if this item is on someone's TMB wish/prio list, if so: mention the player(s) first in line!
    elseif ((GL.Settings:get("TMB.announceWishlistInfoWhenRolling")
            or GL.Settings:get("TMB.announcePriolistInfoWhenRolling")
        )
        and not GL:empty(TMBDetails)
    ) then
        local WishListEntries = {};
        local PrioListEntries = {};

        for _, Entry in pairs(TMBDetails) do
            -- Priolist entry
            if (Entry.type == 1) then
                tinsert(PrioListEntries, Entry);

            -- Wishlist entry
            elseif (Entry.type == 2) then
                tinsert(WishListEntries, Entry);
            end
        end

        local EligiblePlayers = {};
        local wasImportedFromRRobin = TMB:wasImportedFromRRobin();
        if (not GL:empty(PrioListEntries)
            and GL.Settings:get("TMB.announcePriolistInfoWhenRolling")
        ) then
            PrioListEntries = TMB:sortEntries(PrioListEntries);
            local topPrio = PrioListEntries[1].prio;

            for _, Entry in pairs(PrioListEntries) do
                -- This is the first player in the list, add him
                if (not EligiblePlayers[1]) then
                    tinsert(EligiblePlayers, Entry);
                else
                    -- RRobin works slightly differently from normal TMB-compatible loot systems
                    if (wasImportedFromRRobin and topPrio - Entry.prio > 1) then
                        break;
                    end

                    -- This player's prio is worse than the number one, break!
                    if (not wasImportedFromRRobin and Entry.prio ~= topPrio) then
                        break;
                    end

                    -- This player's prio is the same, add it.
                    tinsert(EligiblePlayers, Entry);
                end
            end
        elseif (not GL:empty(WishListEntries)
            and GL.Settings:get("TMB.announceWishlistInfoWhenRolling")
        ) then
            WishListEntries = TMB:sortEntries(WishListEntries);
            local topPrio = WishListEntries[1].prio;

            for _, Entry in pairs(WishListEntries) do
                -- This is the first player in the list, add him
                if (not EligiblePlayers[1]) then
                    tinsert(EligiblePlayers, Entry);
                else
                    -- This players position is worse than the number one, break!
                    if (Entry.prio ~= topPrio) then
                        break;
                    end

                    -- This player's prio is the same, add it.
                    tinsert(EligiblePlayers, Entry);
                end
            end
        end

        if (not GL:empty(EligiblePlayers)) then
            local PlayerNames = GL:tableColumn(EligiblePlayers, "character");
            local source = TMB:source();

            local EligiblePlayerNames = GL:tableUnique(PlayerNames);
            for key, name in pairs(EligiblePlayerNames or {}) do
                EligiblePlayerNames[key] = GL:disambiguateName(name);
            end

            EligiblePlayerNames = table.concat(EligiblePlayerNames, ", ");
            eligiblePlayersMessage = (L.CHAT["These players have the highest %s prio: %s"]):format(source, EligiblePlayerNames);
        end
    end

    if (GL.User.isInRaid) then
        GL:sendChatMessage(
            announceMessage,
            "RAID_WARNING"
        );
    else
        GL:sendChatMessage(
            announceMessage,
            "PARTY"
        );
    end

    if (not GL:empty(eligiblePlayersMessage)) then
        GL:sendChatMessage(
            eligiblePlayersMessage,
            "GROUP"
        );
    end
end

--- Anounce to everyone in the raid that a roll off has ended
function RollOff:announceStop()
    GL.CommMessage.new{
        action = CommActions.stopRollOff,
        channel = "GROUP",
    }:send();
end

--- Start a roll off
--- This is done via a CommMessage even for the masterlooter to make
--- sure that the roll off starts simultaneously for everyone
---
---@param CommMessage CommMessage
function RollOff:start(CommMessage)
    local content = CommMessage.content;

    --[[
        MAKE SURE THE PAYLOAD IS VALID
        PROVIDE VERY SPECIFIC ERROR MESSAGE IF IT'S NOT
    ]]
    if (not content) then
        return GL:debug("Missing content in RollOff:start");
    end

    if (type(content) ~= "table") then
        return GL:debug("Content is not a table in RollOff:start");
    end

    if (not content.time
        or type(content.time) ~= "number"
    ) then
        return GL:debug("No time provided in RollOff:start");
    end

    if (not content.item) then
        return GL:debug("No item provided in RollOff:start");
    end

    --- We have to wait with starting the actual roll off process until
    --- the item that's up for rolling has been successfully loaded by the Item API
    ---
    ---@vararg Item
    ---@return void
    GL:onItemLoadDo(content.item, function (Details)
        if (not Details) then
            return;
        end

        local time = math.floor(tonumber(content.time));
        local SupportedRolls = content.SupportedRolls or {};

        -- Add BoostedRolls to the list of SupportedRolls if data is available
        if (type(content.BoostedRollData) == 'table'
            and not GL:empty(content.BoostedRollData.identifier)
            and not GL:empty(content.BoostedRollData.RangePerPlayer)
        ) then
            local myNormalizedName = GL.BoostedRolls:normalizedName(GL.User.fqn);
            local myRange = content.BoostedRollData.RangePerPlayer[myNormalizedName];

            if (myRange) then
                local low, high = myRange:match("^(%d+)-(%d+)$");
                table.insert(SupportedRolls, {
                    content.BoostedRollData.identifier,
                    low,
                    high,
                });
            end
        end

        -- This is a new roll off so clean everything
        if (Details.link ~= self.CurrentRollOff.itemLink
            or CommMessage.Sender.id ~= self.CurrentRollOff.initiator
        ) then
            local KnownRolls = self.CurrentRollOff.Rolls or {};

            -- This is a new item so make sure to
            -- override all previously set properties
            self.CurrentRollOff = {
                initiator = CommMessage.Sender.id,
                time = time,
                itemID = Details.id,
                itemName = Details.name,
                itemLink = Details.link,
                itemIcon = Details.icon,
                SupportedRolls = SupportedRolls,
                note = content.note,
            };

            -- Note: the auctioneer already did this on his end
            if (not CommMessage.Sender.isSelf) then
                self.CurrentRollOff.Rolls = {};
            else
                self.CurrentRollOff.Rolls = KnownRolls;
            end
        else
            -- If we roll the same item again we do need to make
            -- sure that we update the roll timer
            self.CurrentRollOff.time = time;
        end

        self.inProgress = true;

        if (self:startedByMe()) then
            self:postStartMessage(Details.link, time, content.note);
            GL.MasterLooterUI:drawReopenMasterLooterUIButton();
        end

        -- Don't show the roll UI if the user disabled it
        if (GL.Settings:get("Rolling.showRollOffWindow")) then
            GL.RollerUI:show(time, Details.link, Details.icon, content.note, SupportedRolls, content.bth);
        end

        -- Make sure the rolloff stops when time is up
        self.StopRollOffTimer = GL.Ace:ScheduleTimer(function ()
            self:stop();
        end, time);

        -- Send a countdown in chat when enabled
        local numberOfSecondsToCountdown = GL.Settings:get("MasterLooting.numberOfSecondsToCountdown", 5);
        if (self:startedByMe() -- Only post a countdown if this user initiated the roll
            and time - numberOfSecondsToCountdown > 2-- No point in counting down if there's hardly enough time anyways
            and GL.Settings:get("MasterLooting.doCountdown")
        ) then
            local SecondsAnnounced = {};

            self.InitiateCountDownTimer = GL.Ace:ScheduleTimer(function ()
                self.CountDownTimer = GL.Ace:ScheduleRepeatingTimer(function ()
                    GL:debug("Run RollOff.CountDownTimer");

                    local secondsLeft = math.ceil(GL.Ace:TimeLeft(self.StopRollOffTimer));
                    if (secondsLeft <= numberOfSecondsToCountdown
                        and secondsLeft > 0
                        and not SecondsAnnounced[secondsLeft]
                    ) then
                        SecondsAnnounced[secondsLeft] = true;

                        GL:sendChatMessage((L.CHAT["%s seconds to roll"]):format(secondsLeft), "GROUP");

                        if (GL.Settings:get("MasterLooting.announceCountdownOnce")) then
                            GL:debug("Cancel RollOff.CountDownTimer");

                            GL.Ace:CancelTimer(self.CountDownTimer);
                            self.CountDownTimer = nil;
                        end
                    end
                end, .2);
            end, time - numberOfSecondsToCountdown - 2);
        end

        local notifyOnItemOfInterest = GL.Settings:get("Rolling.notifyOnItemOfInterest");
        local itemOfInterestSound = GL.Settings:get("Rolling.itemOfInterestSound");
        
        -- Play a raid warning sound
        GL:playSound(SOUNDKIT.RAID_WARNING);

        -- If this is an item of interest, play a different sound and post a message
        local isItemOfInterest, reason = GL:isItemOfInterest(Details.id);
        if (isItemOfInterest) then
            local message = "";
            local ItemOfInterestReasons = GL.Data.Constants.ItemOfInterestReasons;
            local sound = LibStub("LibSharedMedia-3.0"):Fetch("sound", itemOfInterestSound);

            -- We reserved there item
            if (reason == ItemOfInterestReasons.RESERVE) then
                message = L["You reserved %s!"];
            end

            -- We have the item on prio
            if (reason == ItemOfInterestReasons.PRIOLIST) then
                message = L["You have %s on prio!"];
            end

            -- We have the item on wishlist
            if (reason == ItemOfInterestReasons.WISHLIST) then
                message = L["You have %s on wishlist!"];
            end

            if (notifyOnItemOfInterest) then
                GL:success((message):format(Details.link));
            end

            -- Play the notification sound after the raid warning has ended
            GL:after(.8, nil, function ()
                GL:playSound(sound);
            end);

            GL.Interface.Alerts:fire("GargulNotification", {
                message = ("|c00BE3333%s|r"):format(L["Item of interest!"]),
            });
        end

        -- Flash the game icon in case the player alt-tabbed
        FlashClientIcon();

        -- Flash the game icon in case the player alt-tabbed
        FlashClientIcon();

        -- Let the application know that a rolloff has started
        GL.Events:fire("GL.ROLLOFF_STARTED");

        -- Items should only contain 1 item but lets add a return just in case
        return;
    end);
end

--- Check whether the current rolloff was started by me (the user)
---
---@return boolean
function RollOff:startedByMe()
    return self.CurrentRollOff.initiator == GL.User.id;
end

--- Stop a roll off. This method can be invoked internally when the roll
--- off time is over or when announced by the initiation of the roll off.
---
---@param CommMessage string|nil
---@return boolean
function RollOff:stop(CommMessage)
    if (not RollOff.inProgress) then
        return GL:warning(L["Can't stop roll off, no roll off in progress"]);
    end

    if (CommMessage
        and self.CurrentRollOff.initiator ~= GL.User.id
        and CommMessage.Sender.id ~= self.CurrentRollOff.initiator
    ) then
        if (self.CurrentRollOff.initiator) then
            GL:debug(CommMessage.Sender.name .. " is not allowed to stop roll off");
        else
            GL:debug(CommMessage.Sender.name .. " is not allowed to stop current roll off: roll off is invalid");
        end

        return false;
    end

    -- If this user started the roll then we need to cancel some timers and post a message
    if (self:startedByMe()) then
        -- Announce that the roll has ended
        if (GL.Settings:get("MasterLooting.announceRollEnd", true)) then
            GL:sendChatMessage(L.CHAT["Stop your rolls!"], "RAID_WARNING");
        end

        -- We stop listening for rolls one second after the rolloff ends just in case there is server lag/jitter
        self.rollListenerCancelTimerId = GL.Ace:ScheduleTimer(function()
            self:stopListeningForRolls();
        end, GL.Settings:get("RollTracking.rollOffEndLeeway", 1));
    end

    if (self.InitiateCountDownTimer) then
        GL.Ace:CancelTimer(self.InitiateCountDownTimer);
        self.InitiateCountDownTimer = nil;
    end

    if (self.CountDownTimer) then
        GL:debug("Cancel RollOff.CountDownTimer");

        GL.Ace:CancelTimer(self.CountDownTimer);
        self.CountDownTimer = nil;
    end

    -- Play raid warning sound
    GL:playSound(SOUNDKIT.RAID_WARNING, "SFX");

    RollOff.inProgress = false;
    GL.Ace:CancelTimer(RollOff.StopRollOffTimer);

    GL.RollerUI:hide();

    -- If we're the initiator then we need to update our initiator UI
    if (self:startedByMe()) then
        GL.MasterLooterUI:updateWidgets();
    end

    -- Let the application know that a rolloff has ended
    GL.Events:fire("GL.ROLLOFF_STOPPED");

    return true;
end

--- Award the item to one of the rollers
---
---@param roller string Name of the player
---@param itemLink string
---@param RollBracket table See DefaultSettings.lua -> RollTracking.Brackets. Can be empty when allowing all rolls!
---@param identicalRollDetected boolean Was there another roll identical to the winning one?
---@return void
function RollOff:award(roller, itemLink, RollBracket, identicalRollDetected)
    identicalRollDetected = GL:toboolean(identicalRollDetected);
    itemLink = itemLink or GL:tableGet(self.CurrentRollOff, "itemLink");

    if (GL:empty(roller)
        or GL:empty(itemLink)
    ) then
        return;
    end

    if (GL:empty(RollBracket)) then
        RollBracket = {
            [1] = "",
            [5] = false,
            [6] = false,
        };
    end

    local rollIdentifier = RollBracket[1];
    local isBR = rollIdentifier == GL.Settings:get("BoostedRolls.identifier", "BR");
    local BRCost = isBR and GL.Settings:get("BoostedRolls.defaultCost", 0) or nil;
    local isOS, addPlusOne = GL:toboolean(RollBracket[5]), GL:toboolean(RollBracket[6]);

    local Rolls = RollOff.CurrentRollOff.Rolls;
    if (type(Rolls) ~= "table") then
        Rolls = {};
    end

    local identicalRollDetectedString = "";
    if (identicalRollDetected) then
        identicalRollDetectedString = ("|c00BE3333%s|r"):format(L["\nWarning: another identical roll was found which can point to a tie\n\n"]);
    end

    if (GL:nameIsUnique(roller)) then
        roller = GL:addRealm(roller);

        -- Bypass the award confirmation based on shift key status and the skipAwardConfirmationDialog setting
        if ((IsShiftKeyDown() and not GL.Settings:get("AwardingLoot.skipAwardConfirmationDialog"))
            or (not IsShiftKeyDown() and GL.Settings:get("AwardingLoot.skipAwardConfirmationDialog"))
        ) then
            -- Add the player we awarded the item to to the item's tooltip
            GL.AwardedLoot:addWinner{
                winner = roller,
                itemLink = itemLink,
                isOS = isOS,
                BRCost = BRCost,
                Rolls = Rolls,
                RollBracket = RollBracket,
            };

            -- Add a +1 if that's expected for this roll bracket
            if (addPlusOne) then
                GL.PlusOnes:addPlusOnes(roller);
            end

            -- Deduct Boosted Roll points if needed
            BRCost = tonumber(BRCost);
            if (BRCost and GL:gt(BRCost, 0)) then
                GL.BoostedRolls:modifyPoints(roller, -BRCost);
                GL.Interface.BoostedRolls.Overview:refreshTable();
            end

            if (GL.Settings:get("UI.RollOff.closeOnAward")) then
                GL.MasterLooterUI:close();
            end

            return;
        end

        -- Make sure the initiator has to confirm his choices
        GL.Interface.Dialogs.AwardDialog:open{
            question = string.format("%s" .. L["Award %s to %s?"],
                identicalRollDetectedString,
                itemLink,
                GL:nameFormat{ name = roller, colorize = true, }
            ),
            OnYes = function ()
                local OSCheckBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.OffSpec");
                if (OSCheckBox) then
                    isOS = GL:toboolean(OSCheckBox:GetValue());
                end

                local addPlusOneCheckBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.PlusOne");
                if (addPlusOneCheckBox) then
                    addPlusOne = GL:toboolean(addPlusOneCheckBox:GetValue());

                    if (addPlusOne) then
                        GL.PlusOnes:addPlusOnes(roller);
                    end
                end

                local BoostedRollCostEditBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "EditBox.Cost");
                if (BoostedRollCostEditBox) then
                    BRCost = GL.BoostedRolls:toPoints(BoostedRollCostEditBox:GetText());

                    if (BRCost) then
                        GL.BoostedRolls:modifyPoints(roller, -BRCost);
                        GL.Interface.BoostedRolls.Overview:refreshTable();
                    end
                end

                -- Add the player we awarded the item to to the item's tooltip
                GL.AwardedLoot:addWinner{
                    winner = roller,
                    itemLink = itemLink,
                    isOS = isOS,
                    BRCost = BRCost,
                    Rolls = Rolls,
                    RollBracket = RollBracket,
                };

                GL.MasterLooterUI:closeReopenMasterLooterUIButton();

                if (GL.Settings:get("UI.RollOff.closeOnAward")) then
                    GL.MasterLooterUI:close();
                end
            end,
            checkOS = isOS,
            checkPlusOne = addPlusOne,
            isBR = isBR,
            boostedRollCost = BRCost,
        };

        return;
    end

    local description = (L["The winner's name is not unique, select the player you'd like to award %s to"]):format(itemLink);

    GL.Interface.PlayerSelector:draw(description, roller, function (player)
        -- Make sure the initiator has to confirm his choices
        GL.Interface.Dialogs.AwardDialog:open{
            question = string.format("%s" .. L["Award %s to %s?"],
                identicalRollDetectedString,
                itemLink,
                GL:nameFormat{ name = player, colorize = true, }
            ),
            OnYes = function ()
                local OSCheckBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.OffSpec");
                if (OSCheckBox) then
                    isOS = GL:toboolean(OSCheckBox:GetValue());
                end

                local addPlusOneCheckBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.PlusOne");
                if (addPlusOneCheckBox) then
                    addPlusOne = GL:toboolean(addPlusOneCheckBox:GetValue());

                    if (addPlusOne) then
                        GL.PlusOnes:addPlusOnes(roller);
                    end
                end

                local boostedRollCostEditBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "EditBox.Cost");
                if (boostedRollCostEditBox) then
                    BRCost = GL.BoostedRolls:toPoints(boostedRollCostEditBox:GetText());

                    if (BRCost) then
                        GL.BoostedRolls:modifyPoints(roller, -BRCost);
                        GL.Interface.BoostedRolls.Overview:refreshTable();
                    end
                end

                -- Add the player we awarded the item to to the item's tooltip
                GL.AwardedLoot:addWinner{
                    winner = roller,
                    itemLink = itemLink,
                    isOS = isOS,
                    BRCost = BRCost,
                    Rolls = Rolls,
                    RollBracket = RollBracket,
                };

                GL.MasterLooterUI:closeReopenMasterLooterUIButton();

                if (GL.Settings:get("UI.RollOff.closeOnAward")) then
                    GL.MasterLooterUI:close();
                end

                GL.Interface.PlayerSelector:close();
            end,
            checkOS = isOS,
            checkPlusOne = addPlusOne,
            isBR = isBR,
            boostedRollCost = BRCost,
        };
    end);
end

--- Start listening for rolls
---
---@return void
function RollOff:listenForRolls()
    -- Make sure the timer to cancel listening for rolls is cancelled
    if (self.rollListenerCancelTimerId) then
        GL.Ace:CancelTimer(self.rollListenerCancelTimerId);
    end

    if (self.listeningForRolls) then
        return;
    end

    self.listeningForRolls = true;

    Events:register("RollOffChatMsgSystemListener", "CHAT_MSG_SYSTEM", function (_, message)
        self:processRoll(message);
    end);
end

--- Unregister the CHAT_MSG_SYSTEM to stop listening for rolls
---
---@return void
function RollOff:stopListeningForRolls()
    if (self.rollListenerCancelTimerId) then
        GL.Ace:CancelTimer(self.rollListenerCancelTimerId);
    end

    self.listeningForRolls = false;
    Events:unregister("RollOffChatMsgSystemListener");
end

--- Process an incoming roll (if it's valid!)
---
---@param message string
---@return void
function RollOff:processRoll(message)
    -- We only track rolls when a rollof is actually in progress
    if (not RollOff.listeningForRolls) then
        return;
    end

    local Roll = false;
    for roller, roll, low, high in string.gmatch(message, GL.RollOff.rollPattern) do
        GL:debug(string.format("Roll detected: %s rolls %s (%s-%s)", roller, roll, low, high));

        roll = tonumber(roll) or 0;
        low = tonumber(low) or 0;
        high = tonumber(high) or 0;

        local RollType = (function()
            for _, RollType in pairs(GL.Settings:get("RollTracking.Brackets", {})) do
                if (low == RollType[2]
                    and high == RollType[3]
                ) then
                    return RollType;
                end
            end

            return false;
        end)();

        --- Check for boosted rolls
        if (not RollType
            and GL.BoostedRolls:enabled()
            and GL.BoostedRolls:available()
            and GL.BoostedRolls:isBoostedRoll(low, high)
        ) then
            local points = GL.BoostedRolls:getPoints(roller);
            local allowedMinimumRoll = GL.BoostedRolls:minBoostedRoll(points);
            local allowedMaximumRoll = GL.BoostedRolls:maxBoostedRoll(points);

            if (low == allowedMinimumRoll and high == allowedMaximumRoll) then
                RollType = {
                    [1] = GL.Settings:get("BoostedRolls.identifier", "BR"),
                    [4] = GL.Settings:get("BoostedRolls.priority", 1),
                };
            end
        end

        --- Invalid roll range provided
        if (not RollType
            and not GL.Settings:get("RollTracking.trackAll")
        ) then
            return;

        --- The roll type is not officially supported by any of the brackets, but since
        --- the master looter allows any kind of roll we need to make sure he can tell what range was used
        elseif (not RollType) then
            RollType = {};
            RollType[1] = ("%s-%s"):format(low, high);
            RollType[4] = 10;
        end

        local rollerName = GL:nameFormat(roller);

        --- Make sure the person who rolled is in our group
        for _, Player in pairs(GL.User:groupMembers()) do
            -- Rolls don't include a realm reference of any sort sadly
            if (GL:iEquals(rollerName, Player.name)) then
                Roll = {
                    player = GL:nameIsUnique(Player.name) and GL:nameFormat(Player.fqn) or roller, -- Make sure to not assume the wrong realm-specific name!
                    class = Player.class,
                    amount = roll,
                    time = GetServerTime(),
                    classification = RollType[1],
                    priority = RollType[4],
                };

                break;
            end
        end
    end

    if (not Roll) then
        return;
    end

    tinsert(self.CurrentRollOff.Rolls, Roll);

    GL.Events:fire("GL.ROLLOFF_ROLL_ACCEPTED");

    self:refreshRollsTable();
end

--- Format roller name to display in the rolls table
---
---@param playerName string
---@param numberOfTimesRolledByPlayer int
---@return string
function RollOff:formatRollerName(playerName, numberOfTimesRolledByPlayer)
    -- If this isn't the player's first roll for the current item then
    -- we add a number behind the players name like so: PlayerName [#]
    if (numberOfTimesRolledByPlayer > 1) then
        playerName = ("%s [%s]"):format(playerName, numberOfTimesRolledByPlayer);
    end

    return playerName;
end

--- Format roll notes for the rolls table
---
---@param rollNotes table
---@return string
function RollOff:formatRollNotes(rollNotes)
    return table.concat(rollNotes, ", ");
end

-- Whenever a new roll comes in we need to refresh
-- the rolls table to make sure it actually shows up
function RollOff:refreshRollsTable()
    local RollTableData = {};
    local Rolls = self.CurrentRollOff.Rolls;
    local RollsTable = GL.Interface:get(GL.MasterLooterUI, "Table.Players");
    local NumberOfRollsPerPlayer = {};

    if (not RollsTable) then
        return;
    end

    local importedFromDFTOrRRobin = GL.TMB:wasImportedFromDFT() or GL.TMB:wasImportedFromRRobin(); -- These two go high > low whereas the rest goes low > high
    local sortByTMBWishlist = GL.Settings:get("RollTracking.sortByTMBWishlist");
    local sortByTMBPrio = GL.Settings:get("RollTracking.sortByTMBPrio");

    for _, Roll in pairs(Rolls) do
        local playerName = GL:disambiguateName(Roll.player);

        -- Determine how many times this player rolled during the current rolloff
        NumberOfRollsPerPlayer[playerName] = NumberOfRollsPerPlayer[playerName] or 0;
        NumberOfRollsPerPlayer[playerName] = NumberOfRollsPerPlayer[playerName] + 1;

        local numberOfTimesRolledByPlayer = NumberOfRollsPerPlayer[playerName];
        local rollPriority = Roll.priority or 1;

        -- This is used to free up priority slots for soft-reserved/wishlisted etc. items
        -- Think of it as a z-index in CSS: nasty but necessary
        rollPriority = rollPriority + 10000;

        local rollNotes = {};

        -- If the player name is unique in the group then use their fqn to match against TMB/Softres entries
        local normalizedPlayerName = string.lower(GL:disambiguateName(playerName));

        -- Check if the player reserved the current item id
        if (GL.SoftRes:itemIDIsReservedByPlayer(self.CurrentRollOff.itemID, normalizedPlayerName)) then
            if (GL.Settings:get("RollTracking.sortBySoftRes")) then
                rollPriority = 1;
            end

            local numberOfReserves = GL.SoftRes:playerReservesOnItem(self.CurrentRollOff.itemID, normalizedPlayerName) or 0;

            if (numberOfReserves > 0) then
                if (numberOfReserves > 1) then
                    tinsert(rollNotes, ("|c00F48CBA" .. L["SR [%sx]"] .. "|r"):format(numberOfReserves));
                else
                    tinsert(rollNotes, ("|c00F48CBA%s|r"):format(L["SR"] ));
                end
            end
        end

        local TMBData = TMB:byItemIDAndPlayer(self.CurrentRollOff.itemID, GL:nameFormat{ name = playerName, forceRealm = true, func = strlower, });

        -- The item might be on a TMB list, make sure we add the appropriate note to the roll
        if (TMBData) then
            local TopEntry = false;

            for _, Entry in pairs(TMBData) do
                (function ()
                    -- We don't have a #1 entry yet, so take this one
                    if (not TopEntry) then
                        TopEntry = Entry;
                        return;
                    end

                    -- This entry is a wishlist entry, whereas TopEntry is a prio entry (aka more important)
                    if (TopEntry.type == GL.Data.Constants.tmbTypePrio
                        and Entry.type == GL.Data.Constants.tmbTypeWish
                    ) then
                        return;
                    end

                    -- This entry is a prio entry, whereas TopEntry is a wishlist entry: override it
                    if (TopEntry.type == GL.Data.Constants.tmbTypeWish
                        and Entry.type == GL.Data.Constants.tmbTypePrio
                    ) then
                        TopEntry = Entry;
                        return;
                    end

                    -- This entry and TopEntry are of the same type, but this entry has better prio (aka more important)
                    if ((importedFromDFTOrRRobin and Entry.prio > TopEntry.prio)
                        or (not importedFromDFTOrRRobin and Entry.prio < TopEntry.prio)
                    ) then
                        TopEntry = Entry;
                        return;
                    end
                end)();
            end

            -- The roller has this item on one of his lists, add a note and change the roll sorting!
            if (TopEntry) then
                -- Prio list entries are more important than wishlist ones (and therefore get sorted on top)
                if (TopEntry.type == GL.Data.Constants.tmbTypePrio) then
                    if (sortByTMBPrio) then
                        rollPriority = 2;

                        -- Make sure rolls of identical list positions "clump" together
                        if (importedFromDFTOrRRobin) then
                            rollPriority = rollPriority - TopEntry.prio;
                        else
                            rollPriority = rollPriority + TopEntry.prio;
                        end
                    end

                    tinsert(rollNotes, string.format("|c00FF7C0A" .. L["Prio [%s]"] .. "|r", TopEntry.prio));
                else
                    if (sortByTMBWishlist) then
                        rollPriority = 3;
                        rollPriority = rollPriority + TopEntry.prio; -- Make sure rolls of identical list positions "clump" together
                    end

                    tinsert(rollNotes, string.format("|c00FFFFFF" .. L["Wish [%s]"] .. "|r", TopEntry.prio));
                end
            end
        end

        local class = Roll.class;
        local plusOnes = GL.PlusOnes:getPlusOnes(playerName);

        local Row = {
            cols = {
                {
                    value = self:formatRollerName(playerName, numberOfTimesRolledByPlayer),
                    color = GL:classRGBAColor(class),
                },
                {
                    value = Roll.amount,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = GL:higherThanZero(plusOnes) and L["+"] .. plusOnes or "",
                    color = GL:classRGBAColor(class),
                },
                {
                    value = Roll.classification,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = self:formatRollNotes(rollNotes),
                    color = GL:classRGBAColor(class),
                },
                {
                    value = rollPriority,
                },
                {
                    value = plusOnes or 0,
                },
            },
        };
        tinsert(RollTableData, Row);
    end

    RollsTable:SetData(RollTableData);
    RollsTable:SortData();
end

-- Reset the last rolloff. This happens when the master looter
-- awards an item or when he clicks the "clear" button in the UI
function RollOff:reset()
    -- All we need to do is reset the itemLink and let self:start() take care of the rest
    self.CurrentRollOff.itemLink = "";
end
