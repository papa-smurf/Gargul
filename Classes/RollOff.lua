local _, App = ...;

App.RollOff = {
    EventFrame = false,
};

local Utils = App.Utils;
local RollOff = App.RollOff;
local CommActions = App.Data.Constants.Comm.Actions;

RollOff.rollPattern = Utils:createPattern(RANDOM_ROLL_RESULT);

RollOff.CurrentRollOff = {
    initiator = nil, -- The player who started the roll off
    time = nil, -- The amount of time players get to roll
    itemId = nil, -- The ID of the item we're rolling for
    itemName = nil, -- The name of the item we're rolling for
    itemLink = nil, -- The item link of the item we're rolling for
    itemIcon = nil, -- The icon of the item we're rolling for
    note = nil, -- The note displayed on the progress bar
    Rolls = {}, -- Player rolls
};

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[App.name .. "_ROLLOFF_AWARD_CONFIRMATION"] = {
    text = "",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[App.name .. "_CLEAR_ROLLOFF_CONFIRMATION"] = {
    text = "Are you sure you want to clear everything?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function ()
        App.RollOff:reset();
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

RollOff.inProgress = false;
RollOff.timerId = 0; -- ID of the timer event

-- Anounce to everyone in the raid that a roll off is starting
function RollOff:announceStart(item, time, note)
    Utils:debug("RollOff:announceStart");

    self:listenForRolls();

    self.CurrentRollOff = {
        initiator = nil, -- The player who started the roll off
        time = nil, -- The amount of time players get to roll
        itemId = nil, -- The ID of the item we're rolling for
        itemName = nil, -- The name of the item we're rolling for
        itemLink = nil, -- The item link of the item we're rolling for
        itemIcon = nil, -- The icon of the item we're rolling for
        note = nil, -- The note displayed on the progress bar
        Rolls = {}, -- Player rolls
    };

    App.CommMessage.new(
        CommActions.startRollOff,
        {
            item = item,
            time = time,
            note = note,
        },
        "RAID"
    ):send();

    local announceMessage = string.format("You have %s seconds to roll on %s - %s", time, item, note);
    local reserveMessage = "";
    local reserves = App.SoftReserves:getSoftReservesByItemLink(item);

    if (reserves) then
        reserves = table.concat(reserves, ", ");
        reserveMessage = "This item has been reserved by: " .. reserves;
    end

    if (App.User.isInRaid) then
        SendChatMessage(
            announceMessage,
            "RAID_WARNING",
            "COMMON"
        );

        if (reserveMessage) then
            SendChatMessage(
                reserveMessage,
                "RAID",
                "COMMON"
            );
        end
    else
        SendChatMessage(
            announceMessage,
            "PARTY",
            "COMMON"
        );
    end
end

-- Anounce to everyone in the raid that a roll off has ended
function RollOff:announceStop()
    Utils:debug("RollOff:announceStop");

    App.CommMessage.new(
        CommActions.stopRollOff,
        nil,
        "RAID"
    ):send();

    self:stopListeningForRolls();
end

-- Start a roll off
function RollOff:start(CommMessage)
    Utils:debug("RollOff:start");

    if (not App.Settings:get("showRollOffWindow")) then
        return;
    end

    local content = CommMessage.content;
    local time, isValidItem, itemId, itemName, itemLink, itemIcon, note;

    -- We have to wait with starting the actual roll off process until
    -- the item that's up for rolling has been successfully loaded by the Item API
    local startRollOffSequence = function()
        isValidItem, itemId, itemName, itemLink, _, _, _, _, _, _, _, itemIcon = Utils:getItemInfoFromLink(content.item);
        time = tonumber(content.time);
        note = content.note;

        if (not isValidItem) then
            return Utils:error("Invalid item provided in RollOff:start");
        end

        self.inProgress = true;

        if (not self.CurrentRollOff
                or itemLink ~= self.CurrentRollOff.itemLink
        ) then
            -- This is a new item so make sure to
            -- override all previously set properties
            self.CurrentRollOff = {
                initiator = CommMessage.Sender.name,
                time = time,
                itemId = itemId,
                itemName = itemName,
                itemLink = itemLink,
                itemIcon = itemIcon,
                note = note,
                Rolls = {},
            };
        else
            -- If we roll the same item again we do need to make
            -- sure that we update the roll timer
            self.CurrentRollOff.time = time;
        end

        App.RollerUI:show(time, itemId, itemName, itemLink, itemIcon, note);

        self.timerId = App.Ace:ScheduleTimer(function ()
            self:stop();
        end, time);

        -- Play raid warning sound
        Utils:playSound(8959, "Master");
    end

    --[[
        MAKE SURE THE PAYLOAD IS VALID
        PROVIDE VERY SPECIFIC ERROR MESSAGE IF IT'S NOT
    ]]
    if (not content) then
        return Utils:error("Missing content in RollOff:start");
    elseif (not type(content) == "table") then
        return Utils:error("Content is not a table in RollOff:start");
    elseif (not content.time) then
        return Utils:error("No time provided in RollOff:start");
    elseif (not content.item) then
        return Utils:error("No item provided in RollOff:start");
    else
        -- Load the item from the Blizzard API and start the roll off after it's retreived
        Item:CreateFromItemLink(content.item):ContinueOnItemLoad(function()
            startRollOffSequence();
        end);
    end
end

-- Stop a roll off
function RollOff:stop(CommMessage)
    Utils:debug("RollOff:stop");

    if (not RollOff.inProgress) then
        return Utils:warning("Can't stop roll off, no roll off in progress");
    end

    if (not self.CurrentRollOff.initiator == App.User.name
        and not CommMessage.Sender.name == self.initiator
    ) then
        return Utils:warning(CommMessage.Sender.name .. " is not allowed to stop roll off started by " .. self.initiator);
    end

    -- Play raid warning sound
    Utils:playSound(8959, "Master");

    RollOff.inProgress = false;
    App.Ace:CancelTimer(RollOff.timerId);

    App.RollerUI:hide();

    -- If we're the initiator then we need to update our initiator UI
    if (RollOff.CurrentRollOff.initiator == App.User.name) then
        App.MasterLooterUI:updateWidgets();
    end
end

-- Award the item to one of the rollers
function RollOff:award(roller, itemLink)
    Utils:debug("RollOff:award");

    -- If the roller has a roll number suffixed to his name
    -- e.g. "playerName [2]" then make sure to remove that number
    local openingBracketPosition = string.find(roller, " %[");
    if (openingBracketPosition) then
        roller = string.sub(roller, 1, openingBracketPosition - 1);
    end

    local RollOff = self.CurrentRollOff;
    local character = Utils:tableGet(App.DB.Characters, roller, {});
    local awardMessage = "";
    local confirmationMessage = "";
    itemLink = Utils:tableGet(self.CurrentRollOff, "itemLink", itemLink);

    awardMessage = string.format("%s awarded to %s. Congrats!",
        itemLink,
        roller
    );

    local award = function ()
        if (App.User.isInRaid) then
            SendChatMessage(
                awardMessage,
                "RAID",
                "COMMON"
            );
        else
            SendChatMessage(
                awardMessage,
                "PARTY",
                "COMMON"
            );
        end

        -- Add the player we awarded the item to to the item's tooltip
        App.AwardedLoot:addWinner(roller, itemLink);

        RollOff = {};
        App.MasterLooterUI:reset();
    end

    -- Make sure the initiator has to confirm his choices
    StaticPopupDialogs[App.name .. "_ROLLOFF_AWARD_CONFIRMATION"].OnAccept = award;
    StaticPopupDialogs[App.name .. "_ROLLOFF_AWARD_CONFIRMATION"].text = string.format("Award %s to %s?",
        itemLink,
        roller
    );
    StaticPopup_Show(App.name .. "_ROLLOFF_AWARD_CONFIRMATION");
end

-- Start listening for rolls
function RollOff:listenForRolls()
    Utils:debug("RollOff:listenForRolls");

    App.Events:register("RollOffChatMsgSystemListener", "CHAT_MSG_SYSTEM", function (message)
        self:processRoll(message);
    end);
end

-- Process an incoming roll (if it's valid!)
function RollOff:processRoll(message)
    Utils:debug("RollOff:processRoll");

    -- We only track rolls when a rollof is actually in progress
    if (not RollOff.inProgress) then
        return;
    end

    local Roll = false;
    for roller, roll, low, high in string.gmatch(message, App.RollOff.rollPattern) do
        Utils:debug(string.format("Roll detected: %s rolls %s (%s-%s)", roller, roll, low, high));

        roll = tonumber(roll) or 0;
        low = tonumber(low) or 0;
        high = tonumber(high) or 0;

        if (low ~= 1 or high ~= 100) then
            return;
        else
            local maximumNumberOfGroupMembers = MEMBERS_PER_RAID_GROUP;
            if (App.User.isInRaid) then
                maximumNumberOfGroupMembers = MAX_RAID_MEMBERS;
            end

            -- This is to fetch the roller's class and to make sure
            -- that the person rolling is actually part of our group/raid
            for index = 1, maximumNumberOfGroupMembers do
                local player, _, _, _, class = GetRaidRosterInfo(index);

                if (roller == player) then
                    Roll = {
                        player = player,
                        class = class,
                        amount = roll,
                        time = GetServerTime(),
                    };

                    break;
                end
            end
        end
    end

    if (not Roll) then
        return;
    end

    tinsert(RollOff.CurrentRollOff.Rolls, Roll);
    RollOff:refreshRollsTable();
end

-- Unregister the CHAT_MSG_SYSTEM to stop listening for rolls
function RollOff:stopListeningForRolls()
    Utils:debug("RollOff:stopListeningForRolls");

    if (not self.EventFrame) then
        return;
    end

    App.Events:unregister("RollOffChatMsgSystemListener");
end

-- Whenever a new roll comes in we need to refresh
-- the rolls table to make sure it actually shows up
function RollOff:refreshRollsTable()
    Utils:debug("RollOff:refreshRollsTable");

    local RollTableData = {};
    local Rolls = self.CurrentRollOff.Rolls;
    local ClassColors = App.Data.Constants.ClassRgbColors;
    local RollsTable = App.MasterLooterUI.UIComponents.Tables.Players;
    local NumberOfRollsPerPlayer = {};

    for _, Roll in pairs(Rolls) do
        -- Determine how many times this player rolled during the current rolloff
        NumberOfRollsPerPlayer[Roll.player] = NumberOfRollsPerPlayer[Roll.player] or 0;
        NumberOfRollsPerPlayer[Roll.player] = NumberOfRollsPerPlayer[Roll.player] + 1;

        local playerName = Roll.player;
        local numberOfTimesRolledByPlayer = NumberOfRollsPerPlayer[Roll.player];

        -- Check if the player reserved the current item id
        local softReservedValue = "";
        if (App.SoftReserves:itemIdIsReservedByPlayer(self.CurrentRollOff.itemId, playerName)) then
            softReservedValue = "reserved";
        end

        -- If this isn't the player's first roll for the current item
        -- then we add a number behind the players name like so: PlayerName [#]
        if (numberOfTimesRolledByPlayer > 1) then
            playerName = string.format("%s [%s]", playerName, numberOfTimesRolledByPlayer);
        end

        local class = string.lower(Roll.class);
        local Row = {
            cols = {
                {
                    value = playerName,
                    color = ClassColors[class],
                },
                {
                    value = Roll.amount,
                    color = ClassColors[class],
                },
                {
                    value = softReservedValue,
                    color = ClassColors[class],
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
    Utils:debug("RollOff:reset");

    self.CurrentRollOff = {
        initiator = nil, -- The player who started the roll off
        time = nil, -- The amount of time players get to roll
        itemId = nil, -- The ID of the item we're rolling on
        itemName = nil, -- The name of the item we're rolling on
        itemLink = nil, -- The item link of the item we're rolling on
        itemIcon = nil, -- The icon of the item we're rolling on
        Rolls = {}, -- Player's rolls (only filled on initiator's side)
    };

    App.MasterLooterUI:reset();
end

Utils:debug("RollOff.lua");