local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type Version
local Version = GL.Version;

---@class GroupVersionCheckInterface
local GroupVersionCheck = {
    windowName = "Gargul.Interface.GroupVersionCheck",

    ActionButtons = {},
    PlayerRows = {},
    Results = {
        Ignored = {},
        UpToDate = {},
        Outdated = {},
        Unresponsive = {},
        Offline = {},
    },
    Timers = {},
};

---@type GroupVersionCheckInterface
GL.Interface.GroupVersionCheck = GroupVersionCheck;

--[[ CONSTANTS ]]
local WINDOW_WIDTH = 360;
local WINDOW_HEIGHT = 401;

---@return Frame|nil
function GroupVersionCheck:open(ActionButtons)
    local Window = self:getWindow() or self:build();

    self:refresh();
    self:setActionButtons(ActionButtons);

    return Window:Show() and Window;
end

function GroupVersionCheck:close()
    local Window = self:getWindow() or self:build();
    Window:Hide();
end

---@return Frame
function GroupVersionCheck:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = WINDOW_WIDTH,
        height = WINDOW_HEIGHT,
        hideMinimizeButton = true,
    };

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L["Adjust Scale"], notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    ---@type Frame
    local PlayerHolder

    ---@type ScrollFrame
    local ScrollFrame;

    --[[ PLAYER LABEL ]]
    ---@type FontString
    local PlayerLabel = Interface:createFontString(Window, L["Player"]);
    PlayerLabel:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -20);

    --[[ STATUS / VERSION ]]
    ---@type FontString
    local StatusLabel = Interface:createFontString(Window, L["Gargul status"]);
    StatusLabel:SetPoint("TOPLEFT", PlayerLabel, "TOPRIGHT", 120, 0);

    do --[[ HELP ICON ]]
        local texturePath = "interface/friendsframe/informationicon";

        ---@type Frame
        local Icon = CreateFrame("Button","Gargul.Interface.GDKP.Auctioneer.HelpIcon", Window);
        Icon:SetSize(12, 12);
        Icon:SetPoint("TOPLEFT", StatusLabel, "TOPRIGHT", 4, 0);

        ---@type Texture
        local image = Icon:CreateTexture(nil, "BACKGROUND")
        image:SetWidth(12)
        image:SetHeight(12)
        image:SetAllPoints(Icon)
        image:SetTexture(texturePath);

        ---@type Texture
        local highlight = Icon:CreateTexture(nil, "HIGHLIGHT")
        highlight:SetAllPoints(Icon);
        highlight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
        highlight:SetTexCoord(0, 1, 0.23, 0.77);
        highlight:SetBlendMode("ADD");

        Interface:addTooltip(Icon, (L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"]):format(GL.version, GL.version, L["No response"], L["Offline"], L["PLAYER IGNORED!"]));
        Interface:addTooltip(StatusLabel, (L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"]):format(GL.version, GL.version, L["No response"], L["Offline"], L["PLAYER IGNORED!"]));
    end

    --[[ SCROLLFRAME BOILERPLATE ]]
    ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOP", PlayerLabel, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("BOTTOM", Window, "BOTTOM", 0, 80);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 16);
    ScrollFrame:SetPoint("RIGHT", Window, "RIGHT", -44, 0);

    PlayerHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(PlayerHolder);
    PlayerHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    PlayerHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    PlayerHolder:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");

    ---@type Frame
    local Items = CreateFrame("Frame", nil, PlayerHolder);
    Items:SetAllPoints(PlayerHolder);

    local rowHeight = 20;
    Window.addPlayer = function (_, Player)
        ---@type Frame
        local PlayerRow = CreateFrame("Frame", nil, PlayerHolder);

        PlayerRow:SetPoint("TOPLEFT", PlayerHolder, "TOPLEFT", 20, (GL:count(self.PlayerRows) * 20) * -1);
        PlayerRow:SetPoint("RIGHT", PlayerHolder, "RIGHT", not GL.elvUILoaded and 0 or -4, 0);
        PlayerRow:SetHeight(rowHeight);

        local Left = CreateFrame("Frame", nil, PlayerRow);
        Left:SetHeight(1);
        Left:SetWidth(1);
        Left:SetPoint("TOPLEFT", PlayerRow, "TOPLEFT", -1, 0);

        local Anchor = Left;

        if (Player.isLeader) then
            ---@type Frame
            local Icon = CreateFrame("Frame",nil, PlayerRow);
            Icon:SetSize(12, 12);
            Icon:SetPoint("TOPLEFT", Anchor, "TOPRIGHT", 4, 0);

            ---@type Texture
            local image = Icon:CreateTexture(nil, "BACKGROUND")
            image:SetWidth(12)
            image:SetHeight(12)
            image:SetAllPoints(Icon)
            image:SetTexture("Interface/GroupFrame/UI-Group-LeaderIcon");

            Interface:addTooltip(Icon, "Leader");

            Anchor = Icon;
        end

        if (Player.isML) then
            ---@type Frame
            local Icon = CreateFrame("Frame",nil, PlayerRow);
            Icon:SetSize(12, 12);
            Icon:SetPoint("TOPLEFT", Anchor, "TOPRIGHT", 4, 0);

            ---@type Texture
            local image = Icon:CreateTexture(nil, "BACKGROUND")
            image:SetWidth(12)
            image:SetHeight(12)
            image:SetAllPoints(Icon)
            image:SetTexture("Interface/GroupFrame/UI-Group-MasterLooter");

            Interface:addTooltip(Icon, "Loot Master");

            Anchor = Icon;
        end

        if (Player.hasAssist and not Player.isLeader) then
            ---@type Frame
            local Icon = CreateFrame("Frame",nil, PlayerRow);
            Icon:SetSize(12, 12);
            Icon:SetPoint("TOPLEFT", Anchor, "TOPRIGHT", 4, 0);

            ---@type Texture
            local image = Icon:CreateTexture(nil, "BACKGROUND")
            image:SetWidth(12)
            image:SetHeight(12)
            image:SetAllPoints(Icon)
            image:SetTexture("Interface/GroupFrame/UI-Group-AssistantIcon");

            Interface:addTooltip(Icon, "Assist");

            Anchor = Icon;
        end

        ---@type FontString
        local Name = Interface:createFontString(PlayerRow, GL:nameFormat(Player.name));
        Name:SetColor(string.upper(Player.class));
        Name:SetPoint("TOPLEFT", Anchor, "TOPRIGHT", 4, -2);

        ---@type FontString
        local Status = Interface:createFontString(PlayerRow, "");

        Status:SetPoint("TOP", Left, "TOP");
        Status:SetPoint("LEFT", StatusLabel, "LEFT");
        PlayerRow._Status = Status;

        self.PlayerRows[Player.fqn] = PlayerRow;
    end;

    --[[ UP-TO-DATE ]]
    ---@type FontString
    local UpToDateLabel = Interface:createFontString(Window, L["Up-to-date:"]);
    UpToDateLabel:SetColor("SUCCESS");
    UpToDateLabel:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 22, 58);

    --[[ UP-TO-DATE COUNTER ]]
    ---@type FontString
    local UpToDateCountLabel = Interface:createFontString(Window, "0");
    UpToDateCountLabel:SetPoint("TOPLEFT", UpToDateLabel, "TOPRIGHT", 2, 0);
    Window._UpToDateCountLabel = UpToDateCountLabel;

    --[[ OUTDATED ]]
    ---@type FontString
    local OutdatedLabel = Interface:createFontString(Window, L["Outdated:"]);
    OutdatedLabel:SetColor("WARNING");
    OutdatedLabel:SetPoint("TOPLEFT", UpToDateCountLabel, "TOPRIGHT", 6, 0);

    --[[ OUTDATED COUNTER ]]
    ---@type FontString
    local OutdatedCountLabel = Interface:createFontString(Window, "0");
    OutdatedCountLabel:SetPoint("TOPLEFT", OutdatedLabel, "TOPRIGHT", 2, 0);
    Window._OutdatedCountLabel = OutdatedCountLabel;

    --[[ NO RESPONSE ]]
    ---@type FontString
    local UnresponsiveLabel = Interface:createFontString(Window, L["No response:"]);
    UnresponsiveLabel:SetColor("ERROR");
    UnresponsiveLabel:SetPoint("TOPLEFT", OutdatedCountLabel, "TOPRIGHT", 6, 0);

    --[[ NO RESPONSE COUNTER ]]
    ---@type FontString
    local UnresponsiveCountLabel = Interface:createFontString(Window, "0");
    UnresponsiveCountLabel:SetPoint("TOPLEFT", UnresponsiveLabel, "TOPRIGHT", 2, 0);
    Window._UnresponsiveCountLabel = UnresponsiveCountLabel;

    --[[ OFFLINE ]]
    ---@type FontString
    local OfflineLabel = Interface:createFontString(Window, L["Offline:"]);
    OfflineLabel:SetColor("GRAY");
    OfflineLabel:SetPoint("TOPLEFT", UnresponsiveCountLabel, "TOPRIGHT", 6, 0);

    --[[ OFFLINE COUNTER ]]
    ---@type FontString
    local OfflineCountLabel = Interface:createFontString(Window, "0");
    OfflineCountLabel:SetPoint("TOPLEFT", OfflineLabel, "TOPRIGHT", 2, 0);
    Window._OfflineCountLabel = OfflineCountLabel;

    --[[ ACTION BUTTONS ]]
    ---@type Button
    local ReportButton = Interface:dynamicPanelButton(Window, L["Report"]);
    ReportButton:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 30);
    ReportButton:SetScript("OnClick", function ()
        if (not GL:empty(self.Results.Unresponsive)) then
            GL:sendChatMessage(L.CHAT["Gargul missing for:"], "GROUP", nil, nil, false);
            for _, player in pairs(self.Results.Unresponsive) do
                GL:sendChatMessage(player, "GROUP", nil, nil, false);
            end
        end

        if (not GL:empty(self.Results.Outdated)) then
            GL:sendChatMessage(L.CHAT["Gargul outdated for:"], "GROUP", nil, nil, false);
            for _, player in pairs(self.Results.Outdated) do
                GL:sendChatMessage(player, "GROUP", nil, nil, false);
            end
        end

        if (not GL:empty(self.Results.Offline)) then
            GL:sendChatMessage(L.CHAT["The following players were offline:"], "GROUP");
            for _, player in pairs(self.Results.Offline) do
                GL:sendChatMessage(player, "GROUP", nil, nil, false);
            end
        end
    end);
    Interface:addTooltip(ReportButton, L["Report outdated results in group chat"]);
    Window._ReportButton = ReportButton;

    return Window;
end

function GroupVersionCheck:refresh()
    ---@type Frame
    local Window = self:getWindow() or self:build();

    self.Results = {
        Ignored = {},
        UpToDate = {},
        Outdated = {},
        Unresponsive = {},
        Offline = {},
    };

    Window._UpToDateCountLabel:SetText(0);
    Window._OutdatedCountLabel:SetText(0);
    Window._UnresponsiveCountLabel:SetText(0);
    Window._OfflineCountLabel:SetText(0);

    -- No point checking anyone else if we're negligent ourselves
    if (Version.lastNotBackwardsCompatibleNotice > 0) then
        GL.Interface.Alerts:fire("GargulNotification", {
            message = ("|c00BE3333%s|r"):format(L["Update Gargul!"]),
            onClick = function ()
                GL.Interface.Dialogs.HyperlinkDialog:open{
                    description = L["Download on CurseForge"],
                    hyperlink = L["https://addons.wago.io/addons/gargul/versions?stability=stable"],
                };
            end,
        });

        return;
    end

    -- Cancel all running timers
    for _, timer in pairs(self.Timers or {}) do
        GL:cancelTimer(timer);
    end

    -- Check if there are any players in our raid that we have on our ignore list
    if (GL.User.isInGroup) then
        local numberOfIgnoredPlayers = C_FriendList.GetNumIgnores();
        if (numberOfIgnoredPlayers > 0) then
            for i = 1, numberOfIgnoredPlayers do
                local player = C_FriendList.GetIgnoreName(i);

                if (player and GL.User:unitInGroup(player)) then
                    tinsert(self.Results.Ignored, GL:nameFormat{ name = player, forceRealm = true, func = strlower, });
                end
            end
        end
    end

    for key, ItemRow in pairs(self.PlayerRows or {}) do
        Interface:release(ItemRow);
        self.PlayerRows[key] = nil;
    end

    local upToDate, outdated, unresponsive, offline = 0, 0, 0, 0;

    local addUpToDate = function(player)
        upToDate = upToDate + 1;
        tinsert(self.Results.UpToDate, GL:nameFormat(player));
        Window._UpToDateCountLabel:SetText(upToDate);
    end

    local addOutdated = function(player)
        outdated = outdated + 1;
        tinsert(self.Results.Outdated, GL:nameFormat(player));
        Window._OutdatedCountLabel:SetText(outdated);
    end

    local addUnresponsive = function(player)
        unresponsive = unresponsive + 1;
        tinsert(self.Results.Unresponsive, GL:nameFormat(player));
        Window._UnresponsiveCountLabel:SetText(unresponsive);
    end

    local addOffline = function(player)
        offline = offline + 1;
        tinsert(self.Results.Offline, GL:nameFormat(player));
        Window._OfflineCountLabel:SetText(offline);
    end

    -- Loop through all members of the group (party or raid)
    GL:forEachGroupMember(function(Member)
        Window:addPlayer(Member);
        local PlayerRow = self.PlayerRows[Member.fqn];

        -- Looks like this row got deleted in the meanwhile
        if (not PlayerRow) then
            return;
        end

        local Status = PlayerRow._Status;

        -- This person is offline, no need to check his version
        if (not Member.online) then
            addOffline(Member.name);

            Status:SetText(L["Offline"]);
            Status:SetColor("GRAY");
            return;

        -- This person is on our ignore list so we can't check his version
        elseif (GL:inTable(self.Results.Ignored, Member.fqn)) then
            Status:SetText(L["PLAYER IGNORED!"]);
            Status:SetColor("AQUA");

            addUnresponsive(Member.name);
            return;
        end

        if (Member.name == GL.User.name) then
            Status:SetText(L["v"] .. GL.version);

            if (Version.isOutOfDate) then
                addOutdated(Member.name);

                Status:SetColor("NOTICE");
            else
                addUpToDate(Member.name);

                Status:SetColor("SUCCESS");
            end

            return;
        end

        Status:SetText(L["Checking version ..."]);
        Status:SetColor("NOTICE");

        -- Assume the player doesn't have Gargul or is too outdated after 5 seconds of inactivity
        local timerIdentifier = ("GroupVersionCheck.%s"):format(Member.fqn);
        GL:after(5, timerIdentifier, function ()
            addUnresponsive(Member.name);

            Status:SetText(L["No response"]);
            Status:SetColor("ERROR");
        end);
        tinsert(self.Timers, timerIdentifier);

        GL.CommMessage.new{
            action = GL.Data.Constants.Comm.Actions.requestAppVersion,
            channel = "WHISPER",
            recipient = Member.fqn,

            -- A response came in, HANDLE IT!
            onResponse = function (Response)
                GL:cancelTimer(timerIdentifier);

                -- An invalid version string was provided
                if (not Response.version
                    or not Version:validateAndSplit(Response.version)
                ) then
                    addUnresponsive(Member.name);

                    Status:SetColor("ERROR");
                    Status:SetText(L["No response"]);

                    return;
                end

                -- Check if the player is up-to-date or not
                Status:SetText(L["v"] .. Response.version);

                if (Version:isUpToDate(Response.version)) then
                    addUpToDate(Member.name);
                    Status:SetColor("SUCCESS");
                else
                    addOutdated(Member.name);
                    Status:SetColor("WARNING");
                end
            end,
        }:send();
    end);

    self.ItemRows = {};
end

---@param Buttons table Expected properties: text, onClick, tooltip
function GroupVersionCheck:setActionButtons(Buttons)
    for key, Button in pairs(self.ActionButtons) do
        Interface:release(Button);
        self.ActionButtons[key] = nil;
    end

    local Window = self:getWindow();
    self.ActionButtons = {};

    local Anchor = Window._ReportButton;
    for _, Button in pairs(Buttons or {}) do
        ---@type Button
        local ActionButton = Interface:dynamicPanelButton(Window, Button.text);
        ActionButton:SetPoint("TOPLEFT", Anchor, "TOPRIGHT", 4, 0);
        ActionButton:SetScript("OnClick", function () Button.onClick(self.Results) end);
        if (Button.tooltip) then
            Interface:addTooltip(ActionButton, Button.tooltip);
        end

        tinsert(self.ActionButtons, ActionButton);
        Anchor = ActionButton;
    end
end

---@return Frame|nil
function GroupVersionCheck:getWindow()
    return _G[self.windowName];
end