local _, App = ...;

App.RollOff = {};
local RollOff = App.RollOff;
local CommActions = App.Data.Constants.Comm.Actions;

RollOff.CurrentRollOff = {
    initiator = nil, -- The player who started the roll off
    time = nil, -- The amount of time players get to roll
    itemId = nil, -- The ID of the item we're rolling for
    itemName = nil, -- The name of the item we're rolling for
    itemLink = nil, -- The item link of the item we're rolling for
    itemIcon = nil, -- The icon of the item we're rolling for
    Rolls = {}, -- Player rolls
};

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs["AWARD_CONFIRMATION"] = {
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
StaticPopupDialogs["CLEAR_CONFIRMATION"] = {
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
function RollOff:announceStart(item, time)
    App:debug("RollOff:announceStart");

    App.CommMessage.new(
        CommActions.startRollOff,
        {
            item = item,
            time = time,
        },
        "RAID"
    ):send();

    local announceMessage = string.format("You have %s seconds to roll on %s", time, item);
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
    App:debug("RollOff:announceStop");

    App.CommMessage.new(
        CommActions.stopRollOff,
        {},
        "RAID"
    ):send();
end

-- Start a roll off
function RollOff:start(CommMessage)
    App:debug("RollOff:start");

    local content = CommMessage.content;
    local time, isValidItem, itemId, itemName, itemLink, itemIcon;

    -- We have to wait with starting the actual roll off process until
    -- the item that's up for rolling has been sucessfully loaded by the Item API
    local startRollOffSequence = function()
        isValidItem, itemId, itemName, itemLink, _, _, _, _, _, _, _, itemIcon = App:getItemInfoFromLink(content.item);
        time = tonumber(content.time);

        if (not isValidItem) then
            return App:error("Invalid item provided in RollOff:start");
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
                Rolls = {},
            };
        else
            -- If we roll the same item again we do need to make
            -- sure that we update the roll timer
            self.CurrentRollOff.time = time;
        end

        App.RollerUI:show(time, itemId, itemName, itemLink, itemIcon);

        self.timerId = App.Ace:ScheduleTimer(function ()
            self:stop();
        end, time);

        -- Play raid warning sound
        PlaySound(8959, "Master");
    end

    --[[
        MAKE SURE THE PAYLOAD IS VALID
        PROVIDE VERY SPECIFIC ERROR MESSAGE IF IT'S NOT
    ]]
    if (not content) then
        return App:error("Missing content in RollOff:start");
    elseif (not type(content) == "table") then
        return App:error("Content is not a table in RollOff:start");
    elseif (not content.time) then
        return App:error("No time provided in RollOff:start");
    elseif (not content.item) then
        return App:error("No item provided in RollOff:start");
    else
        -- Load the item from the Blizzard API and start the roll off after it's retreived
        Item:CreateFromItemLink(content.item):ContinueOnItemLoad(function()
            startRollOffSequence();
        end);
    end
end

-- Stop a roll off
function RollOff:stop(CommMessage)
    App:debug("RollOff:stop");

    if (not RollOff.inProgress) then
        return App:warning("Can't stop roll off, no roll off in progress");
    end

    if (not self.CurrentRollOff.initiator == App.User.name
        and not CommMessage.Sender.name == self.initiator
    ) then
        return App:warning(CommMessage.Sender.name .. " is not allowed to stop roll off started by " .. self.initiator);
    end

    -- Play raid warning sound
    PlaySound(8959, "Master");

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
    local RollOff = self.CurrentRollOff;
    local character = App:tableGet(App.DB.Characters, roller, {});
    local awardMessage = "";
    local confirmationMessage = "";
    itemLink = App:tableGet(self.CurrentRollOff, "itemLink", itemLink);

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

        RollOff = {};
        App.MasterLooterUI:reset();
    end

    -- Make sure the initiator has to confirm his choices
    StaticPopupDialogs["AWARD_CONFIRMATION"].OnAccept = award;
    StaticPopupDialogs["AWARD_CONFIRMATION"].text = string.format("Award %s to %s?",
        itemLink,
        roller
    );
    StaticPopup_Show("AWARD_CONFIRMATION");
end

function RollOff:reset()
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

App:debug("RollOff.lua");