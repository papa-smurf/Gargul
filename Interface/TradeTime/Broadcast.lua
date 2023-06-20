local L = Gargul_L;

---@type GL
local _, GL = ...;
GL.Interface.TradeTime = GL.Interface and GL.Interface.TradeTime or {};

---@type DB
local DB = GL.DB;

---@type Settings
local Settings = GL.Settings;

---@type TradeTime
local TradeTime = GL.TradeTime;

---@type Interface
local Interface = GL.Interface;

---@type TradeTimeOverviewInterface
local TradeTimeOverview = GL.Interface.TradeTime.Overview;

---@class TradeTimeBroadcastInterface
GL.Interface.TradeTime.Broadcast = {
    ---@type string
    windowName = "Gargul.Interface.TradeTime.Broadcast.Window",
};

---@type TradeTimeBroadcastInterface
local Broadcast = GL.Interface.TradeTime.Broadcast;

--[[ CONSTANTS ]]
local CHANNEL_GROUP = 1;
local CHANNEL_RAID_WARNING = 2;
local CHANNEL_WHISPER = 3;
local CHANNEL_OFFICER = 4;
local INTERVAL_IDENTIFIER = "TRADETIME_BROADCAST";

---@return Frame
function Broadcast:open()
    local Window = _G[self.windowName] or self:build();

    Window:Show();
    return Window;
end

---@return void
function Broadcast:close()
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

---@return Frame
function Broadcast:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = 244,
        height = 490,
        minWidth = 244,
        minHeight = 490,
        maxWidth = 1600,
        maxHeight = 900,
        hideMinimizeButton = true,
    };

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    --[[ CHANNEL ]]
    ---@type FontString
    local ChannelLabel = Interface:createFontString(Window, L.CHANNEL);
    ChannelLabel:SetPoint("TOP", Window, "TOP", 20, -30);
    ChannelLabel:SetPoint("LEFT", Window, "LEFT", 20, 0);

    ---@type Frame
    local Channel = Interface:createDropdown{
        Parent = Window,
        Options = {
            [CHANNEL_GROUP] = L.GROUP,
            [CHANNEL_RAID_WARNING] = L.CHANNEL_RAID_WARNING,
            [CHANNEL_WHISPER] = L.CHANNEL_WHISPER,
            [CHANNEL_OFFICER] = L.CHANNEL_OFFICER,
        },
        value = Settings:get("LootTradeTimers.Broadcast.channel"),
        callback = function (_, value)
            Settings:set("LootTradeTimers.Broadcast.channel", value);
        end
    };
    Channel:SetPoint("TOP", ChannelLabel, "BOTTOM", 0, -6);
    Channel:SetPoint("LEFT", Window, "LEFT");

    --[[ TARGET PLAYER ]]
    ---@type FontString
    local TargetPlayerLabel = Interface:createFontString(Window, L.BROADCAST_TARGET_PLAYER);
    TargetPlayerLabel:SetPoint("TOP", Channel, "BOTTOM", 20, -6);
    TargetPlayerLabel:SetPoint("LEFT", Window, "LEFT", 20, 0);

    ---@type Frame
    local TargetPlayer = Interface:inputBox(Window);
    TargetPlayer:SetPoint("TOP", TargetPlayerLabel, "BOTTOM", 0, -6);
    TargetPlayer:SetPoint("LEFT", Window, "LEFT", 26, 0);
    TargetPlayer:SetPoint("RIGHT", Window, "RIGHT", -26, 0);
    TargetPlayer:SetScript("OnTextChanged", function ()
        Settings:set("LootTradeTimers.Broadcast.target", TargetPlayer:GetText());
    end);
    TargetPlayer:SetText(Settings:get("LootTradeTimers.Broadcast.target", ""));

    --[[ MINIMUM QUALITY ]]
    ---@type FontString
    local MinimumQualityLabel = Interface:createFontString(Window, L.MINIMUM_QUALITY);
    MinimumQualityLabel:SetPoint("TOP", TargetPlayer, "BOTTOM", 0, -10);
    MinimumQualityLabel:SetPoint("LEFT", Window, "LEFT", 20, 0);

    ---@type Frame
    local MinimumQuality = Interface:createDropdown{
        Parent = Window,
        Options = {
            [3] = ("|c000070dd%s|r"):format(L.QUALITY_RARE),
            [4] = ("|c00a335ee%s|r"):format(L.QUALITY_EPIC),
        },
        value = Settings:get("LootTradeTimers.Broadcast.minimumQuality"),
        callback = function (_, value)
            Settings:set("LootTradeTimers.Broadcast.minimumQuality", value);
        end
    };
    MinimumQuality:SetPoint("TOP", MinimumQualityLabel, "BOTTOM", 0, -6);
    MinimumQuality:SetPoint("LEFT", Window, "LEFT");

    --[[ MAXIMUM TRADE TIME LEFT ]]
    ---@type FontString
    local MaximumTradeTimeLeftLabel = Interface:createFontString(Window, L.BROADCAST_TRADE_TIME_LEFT);
    MaximumTradeTimeLeftLabel:SetPoint("TOP", MinimumQuality, "BOTTOM", 0, -10);
    MaximumTradeTimeLeftLabel:SetPoint("LEFT", Window, "LEFT", 20, 0);

    ---@type Frame
    local MaximumTradeTimeLeft = Interface:createSlider{
        Parent = Window,
        min = 0,
        max = 120,
        step = 1,
        value = Settings:get("LootTradeTimers.Broadcast.maximumTradeTimeLeft"),
        callback = function (_, value)
            Settings:set("LootTradeTimers.Broadcast.maximumTradeTimeLeft", value);
        end
    };
    MaximumTradeTimeLeft:SetPoint("TOPLEFT", MaximumTradeTimeLeftLabel, "BOTTOMLEFT", 0, -6);

    --[[ NUMBER OF ITEMS ]]
    ---@type FontString
    local NumberOfItemsLabel = Interface:createFontString(Window, L.BROADCAST_NUMBER_OF_ITEMS);
    NumberOfItemsLabel:SetPoint("TOP", MaximumTradeTimeLeft, "BOTTOM", 0, -30);
    NumberOfItemsLabel:SetPoint("LEFT", Window, "LEFT", 20, 0);

    ---@type Frame
    local NumberOfItems = Interface:createSlider{
        Parent = Window,
        min = 1,
        max = 50,
        step = 1,
        value = Settings:get("LootTradeTimers.Broadcast.numberOfItems"),
        callback = function (_, value)
            Settings:set("LootTradeTimers.Broadcast.numberOfItems", value);
        end
    };
    NumberOfItems:SetPoint("TOPLEFT", NumberOfItemsLabel, "BOTTOMLEFT", 0, -6);

    --[[ INCLUDE TIME LEFT ]]
    ---@type CheckButton
    local IncludeTimeLeft = Interface:createCheckbox{
        Parent = Window,
        checked = Settings:get("LootTradeTimers.Broadcast.includeTimeLeft"),
        label = L.BROADCAST_INC_TIME_LEFT,
        callback = function (_, value)
            Settings:set("LootTradeTimers.Broadcast.includeTimeLeft", value)
        end,
    };
    IncludeTimeLeft:SetPoint("TOP", NumberOfItems, "BOTTOM", 0, -30);
    IncludeTimeLeft:SetPoint("LEFT", Window, "LEFT", 20, 0);

    --[[ INCLUDE AWARDED ITEMS ]]
    ---@type CheckButton
    local IncludeAwardedItems = Interface:createCheckbox{
        Parent = Window,
        checked = Settings:get("LootTradeTimers.Broadcast.includeAwardedItems"),
        label = L.BROADCAST_INC_AWARDED,
        callback = function (_, value)
            Settings:set("LootTradeTimers.Broadcast.includeAwardedItems", value)
        end,
    };
    IncludeAwardedItems:SetPoint("TOP", IncludeTimeLeft, "BOTTOM", 0, -6);
    IncludeAwardedItems:SetPoint("LEFT", Window, "LEFT", 20, 0);

    --[[ INCLUDE DISENCHANTED ITEMS ]]
    ---@type CheckButton
    local IncludeDisenchantedItems = Interface:createCheckbox{
        Parent = Window,
        checked = Settings:get("LootTradeTimers.Broadcast.includeDisenchantedItems"),
        label = L.BROADCAST_INC_DISENCHANTED,
        callback = function (_, value)
            Settings:set("LootTradeTimers.Broadcast.includeDisenchantedItems", value)
        end,
    };
    IncludeDisenchantedItems:SetPoint("TOP", IncludeAwardedItems, "BOTTOM", 0, -6);
    IncludeDisenchantedItems:SetPoint("LEFT", Window, "LEFT", 20, 0);

    --[[ INCLUDE HIDDEN ITEMS ]]
    ---@type CheckButton
    local IncludeHiddenItems = Interface:createCheckbox{
        Parent = Window,
        checked = Settings:get("LootTradeTimers.Broadcast.includeHiddenItems"),
        label = L.BROADCAST_INC_HIDDEN,
        callback = function (_, value)
            Settings:set("LootTradeTimers.Broadcast.includeHiddenItems", value)
        end,
    };
    IncludeHiddenItems:SetPoint("TOP", IncludeDisenchantedItems, "BOTTOM", 0, -6);
    IncludeHiddenItems:SetPoint("LEFT", Window, "LEFT", 20, 0);

    --[[ BROADCAST BUTTON ]]
    ---@type Button
    local BroadcastButton = Interface:dynamicPanelButton(Window, L.BROADCAST);
    BroadcastButton:SetPoint("TOP", IncludeHiddenItems, "BOTTOM", 0, -10);
    BroadcastButton:SetPoint("LEFT", Window, "LEFT", 20, 0);
    BroadcastButton:SetPoint("RIGHT", Window, "RIGHT", -20, 0);
    BroadcastButton:SetScript("OnClick", function ()
        local target;
        local channel = Settings:get("LootTradeTimers.Broadcast.channel");

        if (channel == CHANNEL_WHISPER) then
            channel = "WHISPER";
            target = Settings:get("LootTradeTimers.Broadcast.target");

            if (GL:empty(target)) then
                GL:error(L.BROADCAST_TARGET_REQUIRED);
                return;
            end
        elseif (channel == CHANNEL_GROUP) then
            channel = "GROUP";
        elseif (channel == CHANNEL_RAID_WARNING) then
            channel = "RAID_WARNING";
        elseif (channel == CHANNEL_OFFICER) then
            if (not C_GuildInfo.CanEditOfficerNote()) then
                GL:error(L.NO_OFFICER_PRIVILEGES);
                return;
            end

            channel = "OFFICER";
        end

        local includeAwarded = IncludeAwardedItems:GetChecked();
        local includeDisenchanted = IncludeDisenchantedItems:GetChecked();
        local includeHidden = IncludeHiddenItems:GetChecked();
        local includeTimeLeft = IncludeTimeLeft:GetChecked();
        local maximumTradeTime = MaximumTradeTimeLeft:GetValue();
        maximumTradeTime = tonumber(maximumTradeTime) or 120;

        -- Max trade time is provided in minutes, we need seconds
        maximumTradeTime = maximumTradeTime and maximumTradeTime * 60 or nil;

        local State = self:getTradeTimeDetails(includeAwarded, includeDisenchanted, includeHidden, maximumTradeTime);
        if (GL:empty(State)) then
            GL:notice(L.BROADCAST_NO_DATA);
            return;
        end

        GL:sendChatMessage(L.BROADCAST_PREFIX, channel, nil, target);

        table.sort(State, function (a, b)
            if (a.secondsRemaining and b.secondsRemaining) then
                return a.secondsRemaining < b.secondsRemaining;
            end

            return false;
        end);

        local i = 1;
        GL:interval(.25, INTERVAL_IDENTIFIER, function ()
            local Details = State[i];

            if (GL:empty(Details)) then
                return GL:cancelTimer(INTERVAL_IDENTIFIER)
            end

            local timeString = includeTimeLeft and (" [%s]"):format(GL:secondsToReadable(Details.secondsRemaining)) or "";
            GL:sendChatMessage(("%s%s"):format(Details.itemLink, timeString), channel, nil, target, false);

            i = i + 1;
        end);
    end);

    _G[self.windowName] = Window;
    return Window;
end

---@param includeAwarded boolean
---@param includeDisenchanted boolean
---@param includeHidden boolean
---@param maximumTradeTime number
---@return table
function Broadcast:getTradeTimeDetails(includeAwarded, includeDisenchanted, includeHidden, maximumTradeTime)
    local State = TradeTime:getState();
    local Filtered = {};
    local now = GetServerTime();

    for _, Details in pairs(State or {}) do
        local secondsRemaining = (now - (Details.measuredAt + Details.secondsRemaining)) * -1;

        (function()
            -- This item is "too fresh", don't broadcast
            if (maximumTradeTime) then
                if (secondsRemaining > maximumTradeTime) then
                    return;
                end
            end

            -- The player hid this item and doesn't want to broadcast it
            if (not includeHidden
                and GL:tableGet(TradeTimeOverview, "HiddenItems." .. Details.itemGUID)
            ) then
                return;
            end

            local AwardDetails = DB:get("RecentlyAwardedItems." .. Details.itemGUID);
            if (AwardDetails) then
                if (AwardDetails.awardedTo == GL.Exporter.disenchantedItemIdentifier) then
                    if (not includeDisenchanted) then
                        return;
                    end
                else
                    if (not includeAwarded) then
                        return;
                    end
                end
            end

            tinsert(Filtered, {
                itemLink = Details.itemLink,
                secondsRemaining = secondsRemaining,
            });
        end)();
    end

    return Filtered;
end
