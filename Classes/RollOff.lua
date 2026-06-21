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
    EquippedGearByPlayer = {},
    GearWasInspectedByPlayer = {},
    gearSessionID = math.random(1, 2147483647),
    initiatorSessionIDs = {},
    GearCache = {
        hash = nil,
        initiator = nil,
        sessionID = nil,
    },
    inspectQueue = {},
    inspecting = nil,
    inspectUnit = nil,
    inspectingPlayerFQN = nil,
    inspectTimerID = nil,
    inspectDelayTimerByPlayerKey = {},
    inspectListenerRegistered = false,
    InitiateCountDownTimer = nil;
    StopRollOffTimer = nil,
    rollListenerCancelTimerID = nil,
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
    if (GL.Version.lastNotBackwardsCompatibleNotice > 0) then
        GL:error((L["Your Gargul is too outdated to work with others. Update via CurseForge/Wago and |c00%s/reload|r!"]):format(GL.Data.Constants.commandHexColor));
        return false;
    end

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
        BoostedRolls.identifier = strsub(GL.Settings:get("BoostedRolls.identifier", "BR"), 1, 3);
        BoostedRolls.RangePerPlayer = {};

        for _, Player in pairs(GL.User:groupMembers()) do
            (function ()
                local normalizedName = GL.BoostedRolls:normalizedName(Player.fqn);
                if (not GL.BoostedRolls:hasPoints(normalizedName)) then
                    return;
                end

                local points = GL.BoostedRolls:getPoints(normalizedName);
                BoostedRolls.RangePerPlayer[normalizedName] = ("%d-%d"):format(GL.BoostedRolls:minBoostedRoll(points), GL.BoostedRolls:maxBoostedRoll(points));
            end)();
        end
    end

    GL.CommMessage.new({
        action = CommActions.startRollOff,
        content = {
            item = itemLink,
            time = time,
            note = note,
            bth = GL.User:bth(),
            g = self.gearSessionID,
            SupportedRolls = GL.Settings:get("RollTracking.Brackets", {}) or {},
            BoostedRollData = BoostedRolls,
        },
        channel = "GROUP",
    }):send();

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
    GL.CommMessage.new({
        action = CommActions.stopRollOff,
        channel = "GROUP",
    }):send();
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
    ---@return nil
    GL:onItemLoadDo(content.item, function (Details)
        if (not Details) then
            return;
        end

        local time = math.floor(tonumber(content.time));
        local SupportedRolls = content.SupportedRolls or {};
        local gearSessionID = tonumber(content.g);
        if (gearSessionID) then
            if (CommMessage.Sender.id) then
                self.initiatorSessionIDs[CommMessage.Sender.id] = gearSessionID;
            end

            if (CommMessage.Sender.fqn) then
                self.initiatorSessionIDs[CommMessage.Sender.fqn] = gearSessionID;
            end
        end

        -- Add BoostedRolls to the list of SupportedRolls if data is available
        if (type(content.BoostedRollData) == "table"
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

            self:resetInspectState();

            -- Note: the auctioneer already did this on his end
            if (not CommMessage.Sender.isSelf) then
                self.CurrentRollOff.Rolls = {};
            else
                self.CurrentRollOff.Rolls = KnownRolls;
            end
        else
            -- Same item re-roll: update timer and inspect state, keep rolls until reset/new item
            self.CurrentRollOff.time = time;
            self:resetInspectState();
        end

        self.inProgress = true;
        self:listenForRolls();

        if (self:startedByMe()) then
            self:postStartMessage(Details.link, time, content.note);
            GL.MasterLooterUI:drawReopenMasterLooterUIButton();
        end

        -- Auto Roll: if we have a rule, perform the roll (or pass) and optionally skip the UI
        local autoRollHandled, autoRollAction = GL.AutoRoll:onRollStart(Details.link, Details.id, SupportedRolls);

        -- Don't show the roll UI if the user disabled it, or if Auto Roll handled it (pass always hides; roll hides when closeAfterRoll)
        if (GL.Settings:get("Rolling.showRollOffWindow"))
            and not (autoRollHandled and (autoRollAction == "passed" or GL.Settings:get("Rolling.closeAfterRoll")))
        then
            local boostedRollIdentifier = content.BoostedRollData and content.BoostedRollData.identifier or nil;
            GL.RollerUI:show(time, Details.link, Details.icon, content.note, SupportedRolls, content.bth, boostedRollIdentifier, autoRollHandled and autoRollAction == "rolled");
        elseif (autoRollHandled and autoRollAction == "rolled") then
            GL.RollerUI:showRollAcceptedNotification();
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

        self:refreshRollsTable();

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
    end

    -- We stop listening for rolls one second after the rolloff ends just in case there is server lag/jitter
    self.rollListenerCancelTimerID = GL.Ace:ScheduleTimer(function ()
        self:stopListeningForRolls();
    end, GL.Settings:get("RollTracking.rollOffEndLeeway", 1));

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
---@return nil
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
    local Rolls = type(RollOff.CurrentRollOff.Rolls) == "table" and GL:cloneTable(RollOff.CurrentRollOff.Rolls) or {};

    local identicalRollDetectedString = "";
    if (identicalRollDetected) then
        identicalRollDetectedString = ("|c00BE3333\n%s\n\n|r"):format(L["Warning: another identical roll was found which can point to a tie"]);
    end

    if (GL:nameIsUnique(roller)) then
        roller = GL:addRealm(roller);

        -- Bypass the award confirmation based on shift key status and the skipAwardConfirmationDialog setting
        if ((IsShiftKeyDown() and not GL.Settings:get("AwardingLoot.skipAwardConfirmationDialog"))
            or (not IsShiftKeyDown() and GL.Settings:get("AwardingLoot.skipAwardConfirmationDialog"))
        ) then
            -- Add the player we awarded the item to to the item's tooltip
            GL.AwardedLoot:addWinner({
                winner = roller,
                itemLink = itemLink,
                isOS = isOS,
                BRCost = BRCost,
                Rolls = Rolls,
                RollBracket = RollBracket,
            });

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
        GL.Interface.Dialogs.AwardDialog:open({
            question = ("%s" .. L["Award %s to %s?"]):format(
                identicalRollDetectedString,
                itemLink,
                GL:formatPlayerName(roller, { colorize = true, })
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

    local description = (L["The winner's name is not unique, select the player you'd like to award %s to"]):format(itemLink);

    GL.Interface.PlayerSelector:draw(description, roller, function (player)
        -- Make sure the initiator has to confirm his choices
        GL.Interface.Dialogs.AwardDialog:open({
            question = ("%s" .. L["Award %s to %s?"]):format(
                identicalRollDetectedString,
                itemLink,
                GL:formatPlayerName(player, { colorize = true, })
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
---@return nil
function RollOff:listenForRolls()
    -- Make sure the timer to cancel listening for rolls is cancelled
    if (self.rollListenerCancelTimerID) then
        GL.Ace:CancelTimer(self.rollListenerCancelTimerID);
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
---@return nil
function RollOff:stopListeningForRolls()
    if (self.rollListenerCancelTimerID) then
        GL.Ace:CancelTimer(self.rollListenerCancelTimerID);
    end

    self.listeningForRolls = false;
    Events:unregister("RollOffChatMsgSystemListener");
end

--- Process an incoming roll (if it's valid!)
---
---@param message string
---@return nil
function RollOff:processRoll(message)
    -- We only track rolls when a rollof is actually in progress
    if (not RollOff.listeningForRolls) then
        return;
    end

    local Roll = false;
    for roller, roll, low, high in string.gmatch(message, GL.RollOff.rollPattern) do
        GL:debug(("Roll detected: %s rolls %s (%s-%s)"):format(roller, roll, low, high));

        roll = tonumber(roll) or 0;
        low = tonumber(low) or 0;
        high = tonumber(high) or 0;

        local RollType = (function ()
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

        local rollerName = GL:formatPlayerName(roller);

        --- Make sure the person who rolled is in our group
        for _, Player in pairs(GL.User:groupMembers()) do
            -- Rolls don't include a realm reference of any sort sadly
            if (GL:iEquals(rollerName, Player.name)) then
                Roll = {
                    player = GL:nameIsUnique(Player.name) and GL:formatPlayerName(Player.fqn) or roller, -- Make sure to not assume the wrong realm-specific name!
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

    if (GL:iEquals(Roll.player, GL.User.fqn)
        or GL:iEquals(Roll.player, GL.User.name)
    ) then
        self:sendEquippedGearIfNeeded(self.CurrentRollOff.initiator);
    end

    local playerKey = self:gearPlayerKey(Roll.player);
    if (playerKey and self.EquippedGearByPlayer[playerKey] == nil) then
        self:queueInspectIfNeeded(Roll.player);
    end

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

--- Hash equipped gear (slot + dehydrated link) for comm deduplication.
---
---@param gear table<number, string>
---@return string
function RollOff:gearHash(gear)
    local Parts = {};

    for slot, link in pairs(gear) do
        table.insert(Parts, slot .. "=" .. link);
    end

    table.sort(Parts);

    return table.concat(Parts, ";");
end

--- Player key for EquippedGearByPlayer; nil when name-only and not unique in group.
---
---@param player string
---@return string|nil
function RollOff:gearPlayerKey(player)
    if (GL:empty(player)) then
        return nil;
    end

    if (not strfind(player, "-")
        and not GL:nameIsUnique(player)
    ) then
        return nil;
    end

    return GL:formatPlayerName(player, { includeRealm = "always", });
end

--- Send worn gear when it changed or the roll initiator changed.
---
---@param initiatorID string
---@return nil
function RollOff:sendEquippedGearIfNeeded(initiatorID)
    if (not initiatorID) then
        return;
    end

    local gear = GL:getEquippedGear(true, true);
    local hash = self:gearHash(gear);
    local knownSessionID = self.initiatorSessionIDs[initiatorID];

    -- Re-send when gear, initiator, or initiator's session changed
    local sessionChanged = knownSessionID ~= nil and knownSessionID ~= self.GearCache.sessionID;
    if (not sessionChanged
        and self.GearCache.hash == hash
        and self.GearCache.initiator == initiatorID
    ) then
        return;
    end

    GL.CommMessage.new({
        action = CommActions.broadcastEquippedGear,
        content = { s = gear, },
        channel = "GROUP",
    }):send();

    self.GearCache.hash = hash;
    self.GearCache.initiator = initiatorID;
    self.GearCache.sessionID = knownSessionID;
end

--- Store a player's worn gear from addon comm.
---
---@param CommMessage CommMessage
---@return nil
function RollOff:receiveEquippedGear(CommMessage)
    local gear = CommMessage.content and CommMessage.content.s;

    if (type(gear) ~= "table") then
        return;
    end

    local playerKey = self:gearPlayerKey(CommMessage.Sender.fqn);
    if (not playerKey) then
        return;
    end

    self.EquippedGearByPlayer[playerKey] = gear;
    self.GearWasInspectedByPlayer[playerKey] = nil;
    self:cancelInspectDelay(playerKey);

    if (self.inspecting == playerKey) then
        if (self.inspectTimerID) then
            GL:cancelTimer(self.inspectTimerID);
            self.inspectTimerID = nil;
        end

        if (ClearInspectPlayer) then
            ClearInspectPlayer();
        end

        self.inspecting = nil;
        self.inspectUnit = nil;
        self.inspectingPlayerFQN = nil;
        self:processInspectQueue();
    end

    GL.Events:fire("GL.ROLLOFF_GEAR_RECEIVED", CommMessage.Sender.fqn);
end


--- Wipe inspect queue state (e.g. on rolloff start).
---@return nil
function RollOff:resetInspectState()
    if (self.inspectTimerID) then
        GL:cancelTimer(self.inspectTimerID);
        self.inspectTimerID = nil;
    end

    if (self.inspecting and ClearInspectPlayer) then
        ClearInspectPlayer();
    end

    self.inspectQueue = {};
    self.inspecting = nil;
    self.inspectUnit = nil;
    self.inspectingPlayerFQN = nil;

    for _, timerID in pairs(self.inspectDelayTimerByPlayerKey) do
        GL:cancelTimer(timerID);
    end
    self.inspectDelayTimerByPlayerKey = {};
end

--- Cancel a pending inspect delay for a player (comm arrived first).
---
---@param playerKey string
---@return nil
function RollOff:cancelInspectDelay(playerKey)
    local timerID = self.inspectDelayTimerByPlayerKey[playerKey];
    if (not timerID) then
        return;
    end

    GL:cancelTimer(timerID);
    self.inspectDelayTimerByPlayerKey[playerKey] = nil;
end

--- Register INSPECT_READY once.
---@return nil
function RollOff:registerInspectListener()
    if (self.inspectListenerRegistered) then
        return;
    end

    self.inspectListenerRegistered = GL.Events:register("RollOffInspectReady", "INSPECT_READY", function (_, guid)
        GL.RollOff:onInspectReady(guid);
    end);
end

--- Read worn gear from a unit into dehydrated slot links (skips shirt, tabard, ammo).
---
---@param unit string
---@return table<number, string>
function RollOff:readGearFromUnit(unit)
    local cosmeticSlots = { [4] = true, [19] = true, };
    local gear = {};

    if (not unit
        or (UnitExists and not UnitExists(unit))
    ) then
        return gear;
    end

    for slot = 0, 19 do
        if (slot ~= 0 and not cosmeticSlots[slot]) then
            local itemLink = GetInventoryItemLink(unit, slot);
            if (itemLink) then
                local dehydrated = GL:dehydrateItemLink(itemLink);
                if (dehydrated) then
                    gear[slot] = dehydrated;
                end
            end
        end
    end

    return gear;
end

--- Resolve a group unit token for inspect, or "player" for self.
---
---@param playerFQN string
---@return string|nil
function RollOff:inspectUnitForPlayer(playerFQN)
    if (GL:iEquals(playerFQN, GL.User.fqn)
        or GL:iEquals(playerFQN, GL.User.name)
    ) then
        return "player";
    end

    local playerKey = self:gearPlayerKey(playerFQN);
    if (not playerKey) then
        return nil;
    end

    if (IsInRaid()) then
        for i = 1, GetNumGroupMembers() do
            local unit = "raid" .. i;
            local name, realm = UnitName(unit);

            if (name) then
                local fqn = GL:addRealm(name, realm);
                if (self:gearPlayerKey(fqn) == playerKey) then
                    if (UnitIsVisible(unit) and UnitIsConnected(unit)) then
                        return unit;
                    end

                    return nil;
                end
            end
        end
    else
        for i = 1, GetNumGroupMembers() - 1 do
            local unit = "party" .. i;
            local name, realm = UnitName(unit);

            if (name) then
                local fqn = GL:addRealm(name, realm);
                if (self:gearPlayerKey(fqn) == playerKey) then
                    if (UnitIsVisible(unit) and UnitIsConnected(unit)) then
                        return unit;
                    end

                    return nil;
                end
            end
        end
    end

    return nil;
end

--- Queue inspect when comm gear is missing (non-Gargul rollers).
--- Waits briefly so Gargul comm can arrive first.
---
---@param playerFQN string
---@return nil
function RollOff:queueInspectIfNeeded(playerFQN)
    self:registerInspectListener();

    local playerKey = self:gearPlayerKey(playerFQN);
    if (not playerKey or self.EquippedGearByPlayer[playerKey] ~= nil) then
        return;
    end

    if (self.inspecting == playerKey) then
        return;
    end

    for _, queuedFQN in ipairs(self.inspectQueue) do
        if (self:gearPlayerKey(queuedFQN) == playerKey) then
            return;
        end
    end

    if (self.inspectDelayTimerByPlayerKey[playerKey]) then
        return;
    end

    local timerID = ("RollOff.inspectDelay.%s"):format(playerKey);
    self.inspectDelayTimerByPlayerKey[playerKey] = timerID;

    GL:after(2, timerID, function ()
        self.inspectDelayTimerByPlayerKey[playerKey] = nil;

        if (self.EquippedGearByPlayer[playerKey] ~= nil) then
            return;
        end

        for _, queuedFQN in ipairs(self.inspectQueue) do
            if (self:gearPlayerKey(queuedFQN) == playerKey) then
                return;
            end
        end

        table.insert(self.inspectQueue, playerFQN);
        self:processInspectQueue();
    end);
end

--- Mark inspect failed and continue the queue.
---
---@param playerKey string
---@param playerFQN string
---@return nil
function RollOff:finishInspectUnavailable(playerKey, playerFQN)
    self.EquippedGearByPlayer[playerKey] = {};

    if (self.inspecting == playerKey) then
        if (self.inspectTimerID) then
            GL:cancelTimer(self.inspectTimerID);
            self.inspectTimerID = nil;
        end

        if (ClearInspectPlayer) then
            ClearInspectPlayer();
        end
        self.inspecting = nil;
        self.inspectUnit = nil;
        self.inspectingPlayerFQN = nil;
    end

    GL.Events:fire("GL.ROLLOFF_GEAR_RECEIVED", playerFQN);
    self:processInspectQueue();
end

--- Process the next player in the inspect queue.
---@return nil
function RollOff:processInspectQueue()
    if (self.inspecting) then
        return;
    end

    local playerFQN = table.remove(self.inspectQueue, 1);
    if (not playerFQN) then
        return;
    end

    local playerKey = self:gearPlayerKey(playerFQN);
    if (not playerKey or self.EquippedGearByPlayer[playerKey] ~= nil) then
        self:processInspectQueue();
        return;
    end

    local unit = self:inspectUnitForPlayer(playerFQN);
    if (not unit) then
        self:finishInspectUnavailable(playerKey, playerFQN);
        return;
    end

    -- Own gear: read directly, no inspect API
    if (unit == "player") then
        self.EquippedGearByPlayer[playerKey] = self:readGearFromUnit("player");
        self.GearWasInspectedByPlayer[playerKey] = true;
        GL.Events:fire("GL.ROLLOFF_GEAR_RECEIVED", playerFQN);
        self:processInspectQueue();
        return;
    end

    if (not CanInspect
        or not NotifyInspect
        or not ClearInspectPlayer
        or not CanInspect(unit)
    ) then
        self:finishInspectUnavailable(playerKey, playerFQN);
        return;
    end

    self.inspecting = playerKey;
    self.inspectUnit = unit;
    self.inspectingPlayerFQN = playerFQN;
    self.inspectTimerID = ("RollOff.inspectTimeout.%s"):format(playerKey);

    NotifyInspect(unit);

    GL:after(3, self.inspectTimerID, function ()
        if (self.inspecting ~= playerKey) then
            return;
        end

        self:finishInspectUnavailable(playerKey, playerFQN);
    end);
end

--- Store gear from a completed inspect.
---
---@param guid string
---@return nil
function RollOff:onInspectReady(guid)
    if (not self.inspecting or not self.inspectUnit) then
        return;
    end

    if (UnitGUID(self.inspectUnit) ~= guid) then
        return;
    end

    local playerKey = self.inspecting;
    local playerFQN = self.inspectingPlayerFQN;

    if (self.inspectTimerID) then
        GL:cancelTimer(self.inspectTimerID);
        self.inspectTimerID = nil;
    end

    if (self.EquippedGearByPlayer[playerKey] == nil) then
        self.EquippedGearByPlayer[playerKey] = self:readGearFromUnit(self.inspectUnit);
        self.GearWasInspectedByPlayer[playerKey] = true;
        GL.Events:fire("GL.ROLLOFF_GEAR_RECEIVED", playerFQN);
    end

    if (ClearInspectPlayer) then
        ClearInspectPlayer();
    end
    self.inspecting = nil;
    self.inspectUnit = nil;
    self.inspectingPlayerFQN = nil;

    self:processInspectQueue();
end

--- Up to two worn items relevant to the item being rolled off.
---
---@param player string
---@param itemLink string
---@return table<number, string|nil>
function RollOff:getRelevantGearForPlayer(player, itemLink)
    local relevantGear = {};
    local playerKey = self:gearPlayerKey(player);
    local gear = playerKey and self.EquippedGearByPlayer[playerKey];

    if (not gear) then
        return relevantGear;
    end

    local itemID = GL:getItemIDFromLink(itemLink) or GL:itemIDFromDehydratedLink(itemLink);
    if (not itemID) then
        return relevantGear;
    end

    local _, _, _, inventoryType = GL.GetItemInfoInstant(itemID);
    if (not inventoryType) then
        return relevantGear;
    end

    local slots = GL.Data.Constants.ItemSlotTable[inventoryType];
    if (not slots) then
        return relevantGear;
    end

    -- For any weapon-slot item always show both mainhand and offhand
    for _, s in ipairs(slots) do
        if (s == 16 or s == 17) then
            slots = { 16, 17, };
            break;
        end
    end

    for i = 1, math.min(2, #slots) do
        relevantGear[i] = gear[slots[i]];
    end

    return relevantGear;
end

--- Build an enriched, priority-sorted array of roll entries.
--- Used by both the MasterLooterUI table and the RollerUI roll tracker.
---
---@return table[] Array of { player, displayName, class, amount, plusOnes, plusOnesRaw, classification, sortPriority, rollNotes }
function RollOff:buildSortedRollData()
    local Rolls = self.CurrentRollOff.Rolls;
    local NumberOfRollsPerPlayer = {};
    local EnrichedRolls = {};

    local importedFromDFTOrRRobin = GL.TMB:wasImportedFromDFT() or GL.TMB:wasImportedFromRRobin();
    local sortByTMBWishlist = GL.Settings:get("RollTracking.sortByTMBWishlist");
    local sortByTMBPrio = GL.Settings:get("RollTracking.sortByTMBPrio");
    local sortByPlusOne = GL.Settings:get("RollTracking.sortByPlusOne");

    for _, Roll in pairs(Rolls) do
        local playerName = GL:disambiguateName(Roll.player);

        NumberOfRollsPerPlayer[playerName] = NumberOfRollsPerPlayer[playerName] or 0;
        NumberOfRollsPerPlayer[playerName] = NumberOfRollsPerPlayer[playerName] + 1;

        local numberOfTimesRolledByPlayer = NumberOfRollsPerPlayer[playerName];
        local rollPriority = (Roll.priority or 1) + 10000;

        local rollNotes = {};
        local normalizedPlayerName = strlower(GL:disambiguateName(playerName));

        if (GL.SoftRes:itemIDIsReservedByPlayer(self.CurrentRollOff.itemID, normalizedPlayerName)) then
            if (GL.Settings:get("RollTracking.sortBySoftRes")) then
                rollPriority = 1;
            end

            local numberOfReserves = GL.SoftRes:playerReservesOnItem(self.CurrentRollOff.itemID, normalizedPlayerName) or 0;

            if (numberOfReserves > 0) then
                if (numberOfReserves > 1) then
                    tinsert(rollNotes, ("|c00F48CBA" .. L["SR [%sx]"] .. "|r"):format(numberOfReserves));
                else
                    tinsert(rollNotes, ("|c00F48CBA%s|r"):format(L["SR"]));
                end
            end

            local Details = GL.SoftRes:getDetailsForPlayer(normalizedPlayerName);
            local softResNote = Details.note or "";
            if (not GL:empty(softResNote)) then
                tinsert(rollNotes, ("|cFFDDDDDD%s|r"):format(strsub(softResNote, 1, 20)));
            end
        end

        local TMBData = TMB:byItemIDAndPlayer(self.CurrentRollOff.itemID, GL:formatPlayerName(playerName, { includeRealm = "always", decorator = strlower, }));

        if (TMBData) then
            local TopEntry = false;

            for _, Entry in pairs(TMBData) do
                (function ()
                    if (not TopEntry) then
                        TopEntry = Entry;
                        return;
                    end

                    if (TopEntry.type == GL.Data.Constants.tmbTypePrio
                        and Entry.type == GL.Data.Constants.tmbTypeWish
                    ) then
                        return;
                    end

                    if (TopEntry.type == GL.Data.Constants.tmbTypeWish
                        and Entry.type == GL.Data.Constants.tmbTypePrio
                    ) then
                        TopEntry = Entry;
                        return;
                    end

                    if ((importedFromDFTOrRRobin and Entry.prio > TopEntry.prio)
                        or (not importedFromDFTOrRRobin and Entry.prio < TopEntry.prio)
                    ) then
                        TopEntry = Entry;
                        return;
                    end
                end)();
            end

            if (TopEntry) then
                if (TopEntry.type == GL.Data.Constants.tmbTypePrio) then
                    if (sortByTMBPrio) then
                        rollPriority = 2;

                        if (importedFromDFTOrRRobin) then
                            rollPriority = rollPriority - TopEntry.prio;
                        else
                            rollPriority = rollPriority + TopEntry.prio;
                        end
                    end

                    tinsert(rollNotes, ("|c00FF7C0A" .. L["Prio [%s]"] .. "|r"):format(TopEntry.prio));
                else
                    if (sortByTMBWishlist) then
                        rollPriority = 3;
                        rollPriority = rollPriority + TopEntry.prio;
                    end

                    tinsert(rollNotes, ("|c00FFFFFF" .. L["Wish [%s]"] .. "|r"):format(TopEntry.prio));
                end
            end
        end

        local class = Roll.class;
        local plusOnes = GL.PlusOnes:getPlusOnes(playerName);

        table.insert(EnrichedRolls, {
            player = Roll.player,
            displayName = self:formatRollerName(playerName, numberOfTimesRolledByPlayer),
            class = class,
            amount = Roll.amount,
            plusOnes = plusOnes,
            plusOnesRaw = plusOnes or 0,
            classification = Roll.classification,
            sortPriority = rollPriority,
            rollNotes = rollNotes,
            relevantGear = self:getRelevantGearForPlayer(Roll.player, self.CurrentRollOff.itemLink),
        });
    end

    table.sort(EnrichedRolls, function (a, b)
        if (a.sortPriority ~= b.sortPriority) then
            return a.sortPriority < b.sortPriority;
        end

        if (sortByPlusOne and sortByPlusOne ~= 0) then
            if (a.plusOnesRaw ~= b.plusOnesRaw) then
                if (sortByPlusOne == "ASC") then
                    return a.plusOnesRaw < b.plusOnesRaw;
                else
                    return a.plusOnesRaw > b.plusOnesRaw;
                end
            end
        end

        return a.amount > b.amount;
    end);

    return EnrichedRolls;
end

-- Whenever a new roll comes in we need to refresh
-- the rolls table to make sure it actually shows up
function RollOff:refreshRollsTable()
    local RollsTable = GL.Interface:get(GL.MasterLooterUI, "Table.Players");

    if (not RollsTable) then
        return;
    end

    local EnrichedRolls = self:buildSortedRollData();
    local RollTableData = {};

    for _, Entry in pairs(EnrichedRolls) do
        local gearLink1 = Entry.relevantGear and Entry.relevantGear[1];
        local gearLink2 = Entry.relevantGear and Entry.relevantGear[2];
        -- Single item: show in the right slot (col 9) so it sits next to ">>"
        if (gearLink1 and not gearLink2) then
            gearLink1, gearLink2 = nil, gearLink1;
        end
        local playerKey = self:gearPlayerKey(Entry.player);
        local playerGear = playerKey and self.EquippedGearByPlayer[playerKey];
        local gearIconAlpha = playerKey and self.GearWasInspectedByPlayer[playerKey] and .6 or 1;
        local hasGear = false;
        if (type(playerGear) == "table") then
            for _, link in pairs(playerGear) do
                if (not GL:empty(link)) then
                    hasGear = true;
                    break;
                end
            end
        end

        local Row = {
            cols = {
                {
                    value = Entry.displayName,
                    color = GL:classRGBAColor(Entry.class),
                },
                {
                    value = Entry.amount,
                    color = GL:classRGBAColor(Entry.class),
                },
                {
                    value = GL:higherThanZero(Entry.plusOnes) and L["+"] .. Entry.plusOnes or "",
                    color = GL:classRGBAColor(Entry.class),
                },
                {
                    value = Entry.classification,
                    color = GL:classRGBAColor(Entry.class),
                },
                {
                    value = self:formatRollNotes(Entry.rollNotes),
                    color = GL:classRGBAColor(Entry.class),
                },
                {
                    value = Entry.sortPriority,
                },
                {
                    value = Entry.plusOnesRaw,
                },
                {
                    value = gearLink1,
                    _alpha = gearIconAlpha,
                },
                {
                    value = gearLink2,
                    _alpha = gearIconAlpha,
                },
                {
                    value = hasGear and ">>" or "",
                    _tooltip = L["Show all worn items"],
                    _playerFQN = hasGear and Entry.player or nil,
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
