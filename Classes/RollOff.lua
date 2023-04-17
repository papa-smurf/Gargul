local L = Gargul_L;

---@type GL
local _, GL = ...;

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
    StopListeningForRollsTimer = nil,
};
local RollOff = GL.RollOff; ---@type RollOff

local CommActions = GL.Data.Constants.Comm.Actions;
local Events = GL.Events; ---@type Events

--- Anounce to everyone in the raid that a roll off is starting
---
---@param itemLink string
---@param time number
---@param note string|nil
---@return void
function RollOff:announceStart(itemLink, time, note)
    GL:debug("RollOff:announceStart");

    time = tonumber(time);

    if (type(itemLink) ~= "string"
        or GL:empty(itemLink)
        or not GL:higherThanZero(time)
    ) then
        GL:warning("Invalid data provided for roll of start!");
        return false;
    end

    -- Clear the rolls table whenever a new item is rolled off
    if (not GL:empty(self.CurrentRollOff.itemLink)
        and self.CurrentRollOff.itemLink ~= itemLink
    ) then
        self:reset();
        GL.MasterLooterUI:reset(true);
    end

    self:listenForRolls();

    --- If boosted rolls are enabled, send individually instead.
    if (GL.BoostedRolls:enabled()
        and GL.BoostedRolls:available()
    ) then
        --- Generate generic part of message first
        local Players = GL.User:groupMembers();

        --- Create a copy of the supported rolls data
        local SupportedRolls = {};
        for _, Entry in pairs(GL.Settings:get("RollTracking.Brackets", {}) or {}) do
            tinsert(SupportedRolls, Entry);
        end

        --- Add boosted rolls
        local BoostedRollsIdentifier = string.sub(GL.Settings:get("BoostedRolls.identifier", "BR"), 1, 3);

        local boostedRollsSettings = { BoostedRollsIdentifier, 1, 1, GL.Settings:get("BoostedRolls.priority", 1) };
        tinsert(SupportedRolls, boostedRollsSettings);
        local boostedRollIndex = #SupportedRolls;

        local msg = {
            item = itemLink,
            time = time,
            note = note,
            SupportedRolls = SupportedRolls,
        };

        for _, player in pairs(Players) do
            -- Then update for each player
            local points = GL.BoostedRolls:getPoints(player.name);
            local low = GL.BoostedRolls:minBoostedRoll(points);
            local high = GL.BoostedRolls:maxBoostedRoll(points);

            --- Users always roll their current boosted roll value (/rnd 150-150 instead of 1-150)
            msg.SupportedRolls[boostedRollIndex][2] = low;
            msg.SupportedRolls[boostedRollIndex][3] = high;

            GL.CommMessage.new(
                CommActions.startRollOff,
                msg,
                "WHISPER",
                player.name
            ):send();
        end
    else
        GL.CommMessage.new(
            CommActions.startRollOff,
            {
                item = itemLink,
                time = time,
                note = note,
                SupportedRolls = GL.Settings:get("RollTracking.Brackets", {}) or {},
            },
            "GROUP"
        ):send();
    end

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

    local announceMessage = string.format(
        "You have %s seconds to roll on %s",
        time,
        itemLink
    );
    local eligiblePlayersMessage = false;
    local Reserves = GL.SoftRes:byItemLink(itemLink);
    local TMBDetails = GL.TMB:byItemLink(itemLink);

    if (type(note) == "string"
        and not GL:empty(note)
    ) then
        announceMessage = string.format(
            "You have %s seconds to roll on %s - %s",
            time,
            itemLink,
            note
        );
    end

    -- Check if this item was reserved, if so: mentioned the players who reserved it!
    if (GL.Settings:get("SoftRes.announceInfoWhenRolling")
        and not GL:empty(Reserves)
    ) then
        Reserves = table.concat(Reserves, ", ");
        eligiblePlayersMessage = "This item has been reserved by: " .. Reserves;

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
        if (not GL:empty(PrioListEntries)
            and GL.Settings:get("TMB.announcePriolistInfoWhenRolling")
        ) then
            -- Sort the PrioListEntries based on prio (lowest to highest)
            table.sort(PrioListEntries, function (a, b)
                if (a.prio and b.prio) then
                    return a.prio < b.prio;
                end

                return false;
            end);

            for _, Entry in pairs(PrioListEntries) do
                -- This is the first player in the list, add him
                if (not EligiblePlayers[1]) then
                    tinsert(EligiblePlayers, Entry);
                else
                    -- This players prio is worse than the number one, break!
                    if (Entry.prio > EligiblePlayers[1].prio) then
                        break;
                    end

                    -- This player's prio is lte to the number one
                    tinsert(EligiblePlayers, Entry);
                end
            end
        elseif (not GL:empty(WishListEntries)
            and GL.Settings:get("TMB.announceWishlistInfoWhenRolling")
        ) then
            -- Sort the PrioListEntries based on prio (lowest to highest)
            table.sort(WishListEntries, function (a, b)
                if (a.prio and b.prio) then
                    return a.prio < b.prio;
                end

                return false;
            end);

            for _, Entry in pairs(WishListEntries) do
                -- This is the first player in the list, add him
                if (not EligiblePlayers[1]) then
                    tinsert(EligiblePlayers, Entry);
                else
                    -- This players prio is worse than the number one, break!
                    if (Entry.prio > EligiblePlayers[1].prio) then
                        break;
                    end

                    -- This player's prio is lte to the number one
                    tinsert(EligiblePlayers, Entry);
                end
            end
        end

        if (not GL:empty(EligiblePlayers)) then
            local source = GL.TMB:source();

            local EligiblePlayerNames = table.concat(GL:tableColumn(EligiblePlayers, "character"), ", ");
            eligiblePlayersMessage = string.format("The following players have the highest %s prio: %s", source, EligiblePlayerNames);
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
---
---@return void
function RollOff:announceStop()
    GL:debug("RollOff:announceStop");

    GL.CommMessage.new(
        CommActions.stopRollOff,
        nil,
        "GROUP"
    ):send();

    -- We stop listening for rolls one second after the rolloff ends just in case there is server lag/jitter
    self.StopListeningForRollsTimer = GL.Ace:ScheduleTimer(function()
        self:stopListeningForRolls();
    end, 1);
end

--- Start a roll off
--- This is done via a CommMessage even for the masterlooter to make
--- sure that the roll off starts simultaneously for everyone
---
---@param CommMessage CommMessage
function RollOff:start(CommMessage)
    GL:debug("RollOff:start");

    local content = CommMessage.content;

    --[[
        MAKE SURE THE PAYLOAD IS VALID
        PROVIDE VERY SPECIFIC ERROR MESSAGE IF IT'S NOT
    ]]
    if (not content) then
        return GL:error("Missing content in RollOff:start");
    end

    if (type(content) ~= "table") then
        return GL:error("Content is not a table in RollOff:start");
    end

    if (not content.time
        or type(content.time) ~= "number"
    ) then
        return GL:error("No time provided in RollOff:start");
    end

    if (not content.item) then
        return GL:error("No item provided in RollOff:start");
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

        -- This is a new roll off so clean everything
        if (Details.link ~= self.CurrentRollOff.itemLink
            or CommMessage.Sender.id ~= self.CurrentRollOff.initiator
        ) then
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
                Rolls = {},
            };
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
            GL.RollerUI:show(time, Details.link, Details.icon, content.note, SupportedRolls);
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

                        GL:sendChatMessage(
                            string.format("%s seconds to roll", secondsLeft),
                            "GROUP"
                        );

                        if (GL.Settings:get("MasterLooting.announceCountdownOnce")) then
                            GL:debug("Cancel RollOff.CountDownTimer");

                            GL.Ace:CancelTimer(self.CountDownTimer);
                            self.CountDownTimer = nil;
                        end
                    end
                end, .2);
            end, time - numberOfSecondsToCountdown - 2);
        end

        -- Play raid warning sound
        GL:playSound(SOUNDKIT.RAID_WARNING, "SFX");

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
    GL:debug("RollOff:stop");

    if (not RollOff.inProgress) then
        return GL:warning("Can't stop roll off, no roll off in progress");
    end

    if (CommMessage
        and self.CurrentRollOff.initiator ~= GL.User.id
        and CommMessage.Sender.id ~= self.CurrentRollOff.initiator
    ) then
        if (self.CurrentRollOff.initiator) then
            GL:warning(CommMessage.Sender.name .. " is not allowed to stop roll off");
        else
            GL:warning(CommMessage.Sender.name .. " is not allowed to stop current roll off: roll off is invalid");
        end

        return false;
    end

    -- If this user started the roll then we need to cancel some timers and post a message
    if (self:startedByMe()) then
        -- Announce that the roll has ended
        if (GL.Settings:get("MasterLooting.announceRollEnd", true)) then
            GL:sendChatMessage(
                string.format("Stop your rolls!"),
                "RAID_WARNING"
            );
        end

        -- We stop listening for rolls one second after the rolloff ends just in case there is server lag/jitter
        self.rollListenerCancelTimerId = GL.Ace:ScheduleTimer(function()
            self:stopListeningForRolls();
        end, 1);
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
    GL:debug("RollOff:award");

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
        identicalRollDetectedString = "|c00BE3333Warning: another identical roll was found which can point to a tie|r\n\n"
    end

    if (GL:nameIsUnique(roller)) then
        -- Make sure the initiator has to confirm his choices
        GL.Interface.Dialogs.AwardDialog:open({
            question = string.format("%sAward %s to |cff%s%s|r?",
                identicalRollDetectedString,
                itemLink,
                GL:classHexColor(GL.Player:classByName(roller)),
                roller
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
                GL.AwardedLoot:addWinner({
                    winner = roller,
                    itemLink = itemLink,
                    isOS = isOS,
                    BRCost = BRCost,
                    Rolls = Rolls,
                    RollBracket = RollBracket,
                });

                GL.MasterLooterUI:closeReopenMasterLooterUIButton();

                if (GL.Settings:get("UI.RollOff.closeOnAward")) then
                    GL.MasterLooterUI:close();
                end
            end,
            checkOS = isOS,
            checkPlusOne = addPlusOne,
            isBR = isBR,
            boostedRollCost = BRCost,
        });

        return;
    end

    local description = string.format("The winner's name is not unique, select the player you'd like to award %s to", itemLink);

    GL.Interface.PlayerSelector:draw(description, roller, function (player)
        -- Make sure the initiator has to confirm his choices
        GL.Interface.Dialogs.AwardDialog:open({
            question = string.format("%sAward %s to |cff%s%s|r?",
                identicalRollDetectedString,
                itemLink,
                GL:classHexColor(GL.Player:classByName(player)),
                player
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
                GL.AwardedLoot:addWinner({
                    winner = roller,
                    itemLink = itemLink,
                    isOS = isOS,
                    BRCost = BRCost,
                    Rolls = Rolls,
                    RollBracket = RollBracket,
                });

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
        });
    end);
end

--- Start listening for rolls
---
---@return void
function RollOff:listenForRolls()
    GL:debug("RollOff:listenForRolls");

    -- Make sure the timer to cancel listening for rolls is cancelled
    if (self.StopListeningForRollsTimer) then
        GL.Ace:CancelTimer(self.StopListeningForRollsTimer);
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
    GL:debug("RollOff:stopListeningForRolls");

    if (self.StopListeningForRollsTimer) then
        GL.Ace:CancelTimer(self.StopListeningForRollsTimer);
    end

    self.listeningForRolls = false;
    Events:unregister("RollOffChatMsgSystemListener");
end

--- Process an incoming roll (if it's valid!)
---
---@param message string
---@return void
function RollOff:processRoll(message)
    GL:debug("RollOff:processRoll");

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
            RollType[1] = string.format("%s-%s", low, high);
            RollType[4] = 10;
        end

        local rollerName = GL:stripRealm(roller);

        --- Make sure the person who rolled is in our group
        for _, Player in pairs(GL.User:groupMembers()) do
            local playerName = GL:stripRealm(Player.name);
            if (rollerName == playerName) then
                Roll = {
                    player = Player.name,
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

    tinsert(RollOff.CurrentRollOff.Rolls, Roll);

    GL.Events:fire("GL.ROLLOFF_ROLL_ACCEPTED");

    RollOff:refreshRollsTable();
end

-- Whenever a new roll comes in we need to refresh
-- the rolls table to make sure it actually shows up
function RollOff:refreshRollsTable()
    GL:debug("RollOff:refreshRollsTable");

    local RollTableData = {};
    local Rolls = self.CurrentRollOff.Rolls;
    local RollsTable = GL.Interface:get(GL.MasterLooterUI, "Table.Players");
    local NumberOfRollsPerPlayer = {};

    if (not RollsTable) then
        return;
    end

    for _, Roll in pairs(Rolls) do
        -- Determine how many times this player rolled during the current rolloff
        NumberOfRollsPerPlayer[Roll.player] = NumberOfRollsPerPlayer[Roll.player] or 0;
        NumberOfRollsPerPlayer[Roll.player] = NumberOfRollsPerPlayer[Roll.player] + 1;

        local playerName = Roll.player;
        local numberOfTimesRolledByPlayer = NumberOfRollsPerPlayer[Roll.player];
        local rollPriority = Roll.priority or 1;

        -- This is used to free up priority slots for soft-reserved/wishlisted etc. items
        -- Think of it as a z-index in CSS: nasty but necessary
        rollPriority = rollPriority + 10000;

        -- Check if the player reserved the current item id
        local rollNote = "";
        local normalizedPlayerName = string.lower(GL:stripRealm(playerName));

        -- The item is soft-reserved, make sure we add a note to the roll
        if (GL.SoftRes:itemIDIsReservedByPlayer(self.CurrentRollOff.itemID, normalizedPlayerName)) then
            rollPriority = 1;
            rollNote = "Reserved";
            local numberOfReserves = GL.SoftRes:playerReservesOnItem(self.CurrentRollOff.itemID, normalizedPlayerName);

            if (numberOfReserves > 1) then
                rollNote = string.format("%s (%sx)", rollNote, numberOfReserves);
            end

        -- The item might be on a TMB list, make sure we add the appropriate note to the roll
        else
            local TMBData = GL.TMB:byItemIDAndPlayer(self.CurrentRollOff.itemID, normalizedPlayerName);
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

                    -- This entry and TopEntry are of the same type, but this entry has a lower prio (aka more important)
                    if (Entry.prio < TopEntry.prio) then
                        TopEntry = Entry;
                        return;
                    end
                end)();
            end

            -- The roller has this item on one of his lists, add a note and change the roll sorting!
            if (TopEntry) then

                -- Prio list entries are more important than wishlist ones (and therefore get sorted on top)
                if (TopEntry.type == GL.Data.Constants.tmbTypePrio) then
                    rollPriority = 2;
                    rollNote = "Priolist";
                else
                    rollPriority = 3;
                    rollNote = "Wishlist";
                end

                rollPriority = rollPriority + TopEntry.prio; -- Make sure rolls of identical list positions "clump" together
                rollNote = string.format("%s [%s]", rollNote, TopEntry.prio);
            end
        end

        local rollerName = playerName;
        -- If this isn't the player's first roll for the current item
        -- then we add a number behind the players name like so: PlayerName [#]
        if (numberOfTimesRolledByPlayer > 1) then
            rollerName = string.format("%s [%s]", playerName, numberOfTimesRolledByPlayer);
        end

        local class = Roll.class;
        local plusOnes = GL.PlusOnes:getPlusOnes(playerName);

        if (GL:higherThanZero(plusOnes)) then
            plusOnes = "+" .. plusOnes;
        end

        local Row = {
            cols = {
                {
                    value = rollerName,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = Roll.amount,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = plusOnes,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = Roll.classification,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = rollNote,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = rollPriority,
                };
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
    GL:debug("RollOff:reset");

    -- All we need to do is reset the itemLink and let self:start() take care of the rest
    self.CurrentRollOff.itemLink = "";
end

GL:debug("RollOff.lua");