---@type GL
local _, GL = ...;

---@class RollOff
GL.RollOff = GL.RollOff or {
    inProgress = false,
    timerId = 0, -- ID of the timer event
    rollPattern = GL:createPattern(RANDOM_ROLL_RESULT), -- This pattern is used to validate incoming rules
    CurrentRollOff = {
        initiator = nil, -- The player who started the roll off
        time = nil, -- The amount of time players get to roll
        itemId = nil, -- The ID of the item we're rolling for
        itemName = nil, -- The name of the item we're rolling for
        itemLink = nil, -- The item link of the item we're rolling for
        itemIcon = nil, -- The icon of the item we're rolling for
        note = nil, -- The note displayed on the progress bar
        Rolls = {}, -- Player rolls
    },
    listeningForRolls = false,
    rollListenerCancelTimerId = nil,
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

    -- Make sure we don't have any funny decimal business going on
    if (time) then
        time = math.floor(time);
    else
        ---@todo check for funny business
    end

    if (type(itemLink) ~= "string"
        or GL:empty(itemLink)
        or not GL:higherThanZero(time)
    ) then
        GL:warning("Invalid data provided for roll of start!");
        return false;
    end

    self:listenForRolls();

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

    GL.Settings:set("UI.RollOff.timer", time);

    -- The user doesn't want to announce anything in chat
    if (not GL.Settings:get("MasterLooting.announceRollStart")) then
        return true;
    end

    local announceMessage = string.format(
        "You have %s seconds to roll on %s",
        time,
        itemLink
    );
    local reserveMessage = false;
    local Reserves = GL.SoftRes:byItemLink(itemLink);

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

    if (not GL:empty(Reserves)) then
        Reserves = table.concat(Reserves, ", ");
        reserveMessage = "This item has been reserved by: " .. Reserves;
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

    if (not GL:empty(reserveMessage)) then
        GL:sendChatMessage(
            reserveMessage,
            "GROUP"
        );
    end

    return true;
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
    self.rollListenerCancelTimerId = GL.Ace:ScheduleTimer(function()
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
    GL:onItemLoadDo(content.item, function (Items)
        local Entry = Items[1];

        if (GL:empty(Entry)) then
            return;
        end

        local time = math.floor(tonumber(content.time));
        local SupportedRolls = content.SupportedRolls or {};

        -- This is a new roll off so clean everything
        if (Entry.link ~= self.CurrentRollOff.itemLink
            or CommMessage.Sender.id ~= self.CurrentRollOff.initiator
        ) then
            -- This is a new item so make sure to
            -- override all previously set properties
            self.CurrentRollOff = {
                initiator = CommMessage.Sender.id,
                time = time,
                itemId = Entry.id,
                itemName = Entry.name,
                itemLink = Entry.link,
                itemIcon = Entry.icon,
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

        -- Don't show the roll UI if the user disabled it
        -- and the current user is not the one who initiated the rolloff
        if (GL.Settings:get("Rolling.showRollOffWindow")
            or self:startedByMe()
        ) then
            GL.RollerUI:show(time, Entry.id, Entry.link, Entry.icon, content.note, SupportedRolls);

            if (CommMessage.Sender.id == GL.User.id) then
                GL.MasterLooterUI:drawReopenMasterLooterUIButton();
            end
        end

        -- Make sure the rolloff stops when time is up
        self.timerId = GL.Ace:ScheduleTimer(function ()
            self:stop();
        end, time);

        -- Send a countdown in chat when enabled
        local numberOfSecondsToCountdown = GL.Settings:get("MasterLooting.numberOfSecondsToCountdown", 5);
        if (self:startedByMe() -- Only post a countdown if this user initiated the roll
            and time > numberOfSecondsToCountdown -- No point in counting down if there's hardly enough time anyways
            and GL.Settings:get("MasterLooting.doCountdown", false)
        ) then
            local SecondsAnnounced = {};
            self.countDownTimer = GL.Ace:ScheduleRepeatingTimer(function ()
                local secondsLeft = math.ceil(GL.Ace:TimeLeft(self.timerId));
                if (secondsLeft <= numberOfSecondsToCountdown
                    and secondsLeft > 0
                    and not SecondsAnnounced[secondsLeft]
                ) then
                    SecondsAnnounced[secondsLeft] = true;

                    GL:sendChatMessage(
                        string.format("%s seconds to roll", secondsLeft),
                        "GROUP"
                    );
                end
            end, 1);
        end

        -- Play raid warning sound
        GL:playSound(8959, "Master");

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
    end

    if (self.countDownTimer) then
        GL.Ace:CancelTimer(self.countDownTimer);
        self.countDownTimer = nil;
    end

    -- Play raid warning sound
    GL:playSound(8959);

    RollOff.inProgress = false;
    GL.Ace:CancelTimer(RollOff.timerId);

    GL.RollerUI:hide();

    -- If we're the initiator then we need to update our initiator UI
    if (self:startedByMe()) then
        GL.MasterLooterUI:updateWidgets();
    end

    return true;
end

-- Award the item to one of the rollers
function RollOff:award(roller, itemLink, osRoll)
    GL:debug("RollOff:award");

    -- If the roller has a roll number suffixed to his name
    -- e.g. "playerName [2]" then make sure to remove that number
    local openingBracketPosition = string.find(roller, " %[");
    if (openingBracketPosition) then
        roller = string.sub(roller, 1, openingBracketPosition - 1);
    end

    itemLink = GL:tableGet(self.CurrentRollOff, "itemLink", itemLink);

    local isOS, addPlusOne = false;

    if (GL:nameIsUnique(roller)) then
        -- Make sure the initiator has to confirm his choices
        GL.Interface.Dialogs.AwardDialog:open({
            question = string.format("Award %s to |cff%s%s|r?",
                itemLink,
                GL:classHexColor(GL.Player:classByName(roller)),
                roller
            ),
            OnYes = function ()
                local OSCheckBox = GL.Interface:getItem(GL.Interface.Dialogs.AwardDialog, "CheckBox.OffSpec");
                if (OSCheckBox) then
                    isOS = toboolean(OSCheckBox:GetValue());
                end

                local addPlusOneCheckBox = GL.Interface:getItem(GL.Interface.Dialogs.AwardDialog, "CheckBox.PlusOne");
                if (addPlusOneCheckBox) then
                    addPlusOne = toboolean(addPlusOneCheckBox:GetValue());

                    if (addPlusOne) then
                        GL.PlusOnes:add(roller);
                    end
                end

                -- Add the player we awarded the item to to the item's tooltip
                GL.AwardedLoot:addWinner(roller, itemLink, nil, nil, isOS, addPlusOneCheckBox);

                self:reset();
                GL.MasterLooterUI:reset();
                GL.MasterLooterUI:closeReopenMasterLooterUIButton();

                if (GL.Settings:get("UI.RollOff.closeOnAward")) then
                    GL.MasterLooterUI:close();
                end
            end,
            checkOS = osRoll,
        });

        return;
    end

    local description = string.format("The winner's name is not unique, select the player you'd like to award %s to", itemLink);

    GL.Interface.PlayerSelector:draw(description, roller, function (player)
        -- Make sure the initiator has to confirm his choices
        GL.Interface.Dialogs.AwardDialog:open({
            question = string.format("Award %s to |cff%s%s|r?",
                itemLink,
                GL:classHexColor(GL.Player:classByName(player)),
                player
            ),
            OnYes = function ()
                local OSCheckBox = GL.Interface:getItem(GL.Interface.Dialogs.AwardDialog, "CheckBox.OffSpec");
                if (OSCheckBox) then
                    isOS = toboolean(OSCheckBox:GetValue());
                end

                local addPlusOneCheckBox = GL.Interface:getItem(GL.Interface.Dialogs.AwardDialog, "CheckBox.PlusOne");
                if (addPlusOneCheckBox) then
                    addPlusOne = toboolean(addPlusOneCheckBox:GetValue());

                    if (addPlusOne) then
                        GL.PlusOnes:add(roller);
                    end
                end

                -- Add the player we awarded the item to to the item's tooltip
                GL.AwardedLoot:addWinner(roller, itemLink, nil, nil, isOS, addPlusOneCheckBox);

                self:reset();
                GL.MasterLooterUI:reset();
                GL.MasterLooterUI:closeReopenMasterLooterUIButton();

                if (GL.Settings:get("UI.RollOff.closeOnAward")) then
                    GL.MasterLooterUI:close();
                end

                GL.Interface.PlayerSelector:close();
            end,
            checkOS = osRoll,
        });
    end);
end

--- Start listening for rolls
---
---@return void
function RollOff:listenForRolls()
    GL:debug("RollOff:listenForRolls");

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
    GL:debug("RollOff:stopListeningForRolls");

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
    GL:debug("RollOff:processRoll");

    -- We only track rolls when a rollof is actually in progress
    if (not RollOff.inProgress) then
        return;
    end

    local Roll = false;
    for roller, roll, low, high in string.gmatch(message, GL.RollOff.rollPattern) do
        GL:debug(string.format("Roll detected: %s rolls %s (%s-%s)", roller, roll, low, high));

        roll = tonumber(roll) or 0;
        low = tonumber(low) or 0;
        high = tonumber(high) or 0;

        local rollType = (function()
            for _, RollType in pairs(GL.Settings:get("RollTracking.Brackets", {})) do
                if (low == RollType[2]
                    and high == RollType[3]
                ) then
                    return RollType[1];
                end
            end

            return false;
        end)();

        --- Invalid roll range provided
        if (not rollType
                and not GL.Settings:get("RollTracking.trackAll")
        ) then
            return;

        --- The roll type is officially supported by any of the brackets, but since
        --- the master looter allows any kind of roll we need to make sure he can tell what range was used
        elseif (not rollType) then
            rollType = string.format("%s-%s", low, high);
        end

        local rollerName = GL:stripRealm(roller);

        --- The user is not in a group and is most likely testing the add-on
        if (not GL.User.isInGroup
            and rollerName == GL.User.name
        ) then
            Roll = {
                player = GL.User.name,
                class = GL.User.class,
                amount = roll,
                time = GetServerTime(),
                rollType = rollType,
            };
        end

        for _, Player in pairs(GL.User:groupMembers()) do
            local playerName = GL:stripRealm(Player.name);
            if (rollerName == playerName) then
                Roll = {
                    player = Player.name,
                    class = Player.class,
                    amount = roll,
                    time = GetServerTime(),
                     rollType = rollType,
                };

                break;
            end
        end
    end

    if (not Roll) then
        return;
    end

    tinsert(RollOff.CurrentRollOff.Rolls, Roll);
    RollOff:refreshRollsTable();
end

-- Whenever a new roll comes in we need to refresh
-- the rolls table to make sure it actually shows up
function RollOff:refreshRollsTable()
    GL:debug("RollOff:refreshRollsTable");

    local RollTableData = {};
    local Rolls = self.CurrentRollOff.Rolls;
    local RollsTable = GL.Interface:getItem(GL.MasterLooterUI, "Table.Players");
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

        -- Check if the player reserved the current item id
        local softReservedValue = "";
        local normalizedPlayerName = string.lower(GL:stripRealm(playerName));

        if (GL.SoftRes:itemIdIsReservedByPlayer(self.CurrentRollOff.itemId, normalizedPlayerName)) then
            softReservedValue = "Reserved";
            local numberOfReserves = GL.SoftRes:playerReservesOnItem(self.CurrentRollOff.itemId, normalizedPlayerName);

            if (numberOfReserves > 1) then
                softReservedValue = string.format("%s (%sx)", softReservedValue, numberOfReserves);
            end
        end

        local rollerName = playerName;
        -- If this isn't the player's first roll for the current item
        -- then we add a number behind the players name like so: PlayerName [#]
        if (numberOfTimesRolledByPlayer > 1) then
            rollerName = string.format("%s [%s]", playerName, numberOfTimesRolledByPlayer);
        end

        local class = Roll.class;
        local plusOnes = GL.PlusOnes:get(playerName);

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
                    value = Roll.rollType,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = softReservedValue,
                    color = GL:classRGBAColor(class),
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
    GL:debug("RollOff:reset");

    -- All we need to do is reset the itemLink and let self:start() take care of the rest
    self.CurrentRollOff.itemLink = "";

    GL.MasterLooterUI:reset();
end

GL:debug("RollOff.lua");