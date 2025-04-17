local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type Events
local Events = GL.Events;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@class MailCuts
GL.Interface.GDKP.Distribute.MailCuts = {
    _initialized = false,
    isVisible = false,
    mailErrors = 0,
    sendingMail = false,
    windowName = "Gargul.Interface.GDKP.Distribute.MailCuts.Window",

    cutMailSubject = nil,
    cutMailBody = nil,
};

---@type MailCuts
local MailCuts = GL.Interface.GDKP.Distribute.MailCuts;

--[[ CONSTANTS ]]
local MAIL_SEND_WAIT_TIMEOUT = 15;
local MAIL_COST = 30; -- Sending a mail costs 30 copper

--- Show the cut mailer window when certain events are triggered
---@return void
function MailCuts:_init()
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    local Identity = GL.Interface.Identity:build(GL.User:bth());
    self.cutMailSubject = Identity.cutMailSubject or L["Gargul GDKP: %sg"];
    self.cutMailBody = Identity.cutMailBody or L.CHAT["Hi ${player}, your ${cut} cut has arrived! - Gargul"];

    --[[ ERA HAS DIFFERENT EVENTS FOR OPENING / CLOSING THE MAILBOX ]]
    if (not GL.isEra) then
        Events:register("MailCutsPlayerInteractionShow", "PLAYER_INTERACTION_MANAGER_FRAME_SHOW", function(_, type)
            if (type == 17) then
                self:openIfCutsToMail();
            end
        end);

        Events:register("MailCutsPlayerInteractionHide", "PLAYER_INTERACTION_MANAGER_FRAME_HIDE", function(_, type)
            if (type == 17) then
                self:close();
            end
        end);

        return;
    end

    Events:register("MailCutsMailShowListener", "MAIL_SHOW", function()
        self:openIfCutsToMail();
    end);

    Events:register("MailCutsMailClosedListener", "MAIL_CLOSED", function()
        self:close();
    end);
end

---@return void
function MailCuts:openIfCutsToMail()
    local Instance = GDKPSession:getActive();

    -- Check if the GDKP session exists and is locked for payout
    if (not Instance or not Instance.lockedAt) then
        return;
    end

    self:open();
end

---@return table
function MailCuts:open()
    self.isVisible = true;

    local Window = _G[self.windowName] or self:build();

    if (self:refreshPlayerCuts()) then
        Window:Show();
    else
        Window:Hide();
    end

    return Window;
end

---@return void
function MailCuts:close()
    self.isVisible = false;
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

---@return table
function MailCuts:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = 300,
        height = 1,
        hideMoveButton = true,
        hideResizeButton = true,
        closeWithEscape = false,
    };
    Window:SetPoint("TOPLEFT", _G.MailFrame, "TOPRIGHT", 2, 2);
    Window:SetPoint("BOTTOMLEFT", _G.MailFrame, "BOTTOMRIGHT", 4, -2);

    ---@type FontString
    local Intro = Interface:createFontString(Window, L["Mail cut to players"]);
    Intro:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -24);
    Intro:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -20, 0);
    Intro:SetJustifyH("CENTER");

    --[[ SCROLLFRAME BOILERPLATE ]]
    ---@type ScrollFrame
    local ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOPLEFT", Intro, "TOPLEFT", 0, -20);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 4, 0);
    ScrollFrame:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -44, 60);

    ---@type Frame
    local PlayerHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(PlayerHolder);
    PlayerHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    PlayerHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    PlayerHolder:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");

    ---@type Button
    local MailAllCuts = Interface:dynamicPanelButton(Window, L["Mail All"]);
    MailAllCuts:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 30);
    MailAllCuts:SetPoint("RIGHT", Window, "RIGHT", -20, 0);
    MailAllCuts:SetScript("OnClick", function ()
        self:mailAllCuts();
    end);

    Window.PlayerHolder = PlayerHolder;
    _G[self.windowName] = Window;
    return Window;
end

---@return boolean Any players added?
function MailCuts:refreshPlayerCuts()
    local PlayerHolder = _G[self.windowName].PlayerHolder;
    Interface:releaseChildren(PlayerHolder);

    local Session = GDKPSession:getActive() or {};
    local PlayerNames = {};
    local OutstandingPayments = {};
    for player in pairs(GL:tableGet(Session, "Pot.Cuts", {})) do
        local outstanding = tonumber(GDKPSession:copperOwedToPlayer(player, Session.ID) or 0);

        if (outstanding and outstanding > 0) then
            OutstandingPayments[player] = outstanding;
            tinsert(PlayerNames, player);
        end
    end

    table.sort(PlayerNames, function (a, b)
        if (a and b) then
            return a < b;
        end

        return false;
    end);

    local i = 0;
    for _, player in pairs(PlayerNames) do
        local amount = OutstandingPayments[player];
        local goldOwed = amount / 10000;

        ---@type Frame
        local PlayerRow = CreateFrame("Frame", nil, PlayerHolder);
        PlayerRow:SetPoint("TOPLEFT", PlayerHolder, "TOPLEFT", 0, (i * 22) * -1);
        PlayerRow:SetPoint("TOPRIGHT", PlayerHolder, "TOPRIGHT", not GL.elvUILoaded and 0 or -4, 0);
        PlayerRow:SetHeight(20);

        local hasEntries = false;
        local Lines;
        local MailHistory = GL:tableGet(Session, "MailHistory." .. player);
        local nameFormatted = GL:nameFormat(player);
        if (MailHistory) then
            Lines = {
                string.format(L["Mail History for |c00967FD2%s"], nameFormatted),
                " ",
            };
            table.sort(MailHistory, function (a, b)
                if (a.timestamp and b.timestamp) then
                    return a.timestamp > b.timestamp;
                end

                return false;
            end);

            for _, Entry in pairs(MailHistory or {}) do
                hasEntries = true;

                tinsert(Lines, string.format("%s: %s",
                    date(L["%d-%m %H:%M"], Entry.timestamp),
                    Entry.message
                ));
            end
        end

        ---@type FontString
        local PlayerName = Interface:createFontString(PlayerRow, nameFormatted);
        PlayerName:SetPoint("TOPLEFT", PlayerRow, "TOPLEFT", 0, 0);
        PlayerName:SetWidth(80);

        ---@type FontString
        local Gold = Interface:createFontString(PlayerRow, goldOwed .. L["g"]);
        Gold:SetPoint("TOPLEFT", PlayerName, "TOPRIGHT", 4, 0);
        Gold:SetWidth(60);

        ---@type Button
        local MailCut = Interface:dynamicPanelButton(PlayerRow, L["Mail"]);
        MailCut:SetPoint("TOPLEFT", Gold, "TOPRIGHT", 4, 0);
        MailCut:SetScript("OnClick", function ()
            self:mailPlayerCut(player, function (success, copper, message)
                if (type(message) == "string") then
                    GL:tableAdd(Session, "MailHistory." .. player, {
                        timestamp = GetServerTime(),
                        message = message,
                    });
                end

                if (not success) then
                    self:refreshPlayerCuts();
                    return;
                end

                copper = tonumber(copper);
                if (not copper or copper <= 0) then
                    self:refreshPlayerCuts();
                    return;
                end

                GDKPSession:registerGoldMail(player, copper);
                local cutsLeft = self:refreshPlayerCuts();

                -- Make sure to close the window when all cuts are mailed
                if (not cutsLeft) then
                    GL:success(L["All cuts were mailed!"]);
                    self:close();
                end
            end);
        end);

        if (hasEntries) then
            Interface:addTooltip(PlayerRow, Lines);

            --[[ WARNING SIGN ]]
            local texturePath = "interface/encounterjournal/ui-ej-warningtexticon.blp";

            ---@type Frame
            local Icon = CreateFrame("Frame",nil, PlayerRow);
            Icon:SetSize(12, 12);
            Icon:SetPoint("TOPLEFT", MailCut, "TOPRIGHT", 4, -2);

            ---@type Texture
            local image = Icon:CreateTexture(nil, "BACKGROUND")
            image:SetWidth(12)
            image:SetHeight(12)
            image:SetAllPoints(Icon)
            image:SetTexture(texturePath);
        end

        i = i + 1;
    end

    _G[self.windowName].PlayerHolder = PlayerHolder;

    return i > 0;
end

function MailCuts:mailAllCuts()
    if (self.sendingMail) then
        GL:error(L["Wait a bit, we're still processing the previous mail"]);

        return;
    end

    local Session = GDKPSession:getActive() or {};
    for player in pairs(GL:tableGet(Session, "Pot.Cuts", {})) do
        local outstanding = tonumber(GDKPSession:copperOwedToPlayer(player, Session.ID));

        if (outstanding and outstanding > 0) then
            return self:mailPlayerCut(player, function (success, copper, message)
                if (type(message) == "string") then
                    GL:tableAdd(Session, "MailHistory." .. player, {
                        timestamp = GetServerTime(),
                        message = message,
                    });
                end

                if (not success) then
                    self:refreshPlayerCuts();

                    if (success == false) then
                        self.mailErrors = self.mailErrors + 1;
                    end
                end

                copper = tonumber(copper);
                if (success and copper > 0) then
                    GDKPSession:registerGoldMail(player, copper);

                    -- Make sure to close the window when all cuts are mailed
                    if (not self:refreshPlayerCuts()) then
                        GL:success(L["All cuts were mailed!"]);
                        self:close();
                        return;
                    end
                elseif (success) then
                    self:refreshPlayerCuts();
                end

                if (self.mailErrors > 1) then
                    self.mailErrors = 0;
                    return GL:error(L["Multiple mail errors detected, aborting cut distribution"]);
                end

                self:mailAllCuts();
            end);
        end
    end

    GL:success(L["All cuts were mailed!"]);
end

---@param player string
---@param callback function|nil
function MailCuts:mailPlayerCut(player, callback)
    if (self.sendingMail) then
        GL:error(L["Wait a bit, we're still processing the previous mail"]);

        return;
    end

    -- Looks like the player closed his mailbox in the meantime
    if (not GL.mailIsShown) then
        GL:error(L["Can't send mail when the mailbox is closed"]);
    end

    callback = callback or function () end;

    -- We need an active session that's locked for payout
    local Session = GDKPSession:getActive() or {};
    if (not Session or not Session.lockedAt) then
        GL:warning(L["No active GDKP session detected or session is not locked for payout!"]);
        return callback(false);
    end

    -- Check if we actually need to pay this person
    local outstandingCopper = GDKPSession:copperOwedToPlayer(player, Session.ID);
    if (outstandingCopper and outstandingCopper < 1) then
        GL:success(string.format(L["You don't owe %s any gold"], player));
        return callback(true);
    elseif (not outstandingCopper) then
        return;
    end

    -- We don't have enough gold to pay this person
    local originalCopper = GetMoney();
    local copperLeftAfterMailing = originalCopper - outstandingCopper - MAIL_COST;
    if (copperLeftAfterMailing < 0) then
        GL:warning(string.format(L["You don't have enough gold to pay %s"], player));
        return callback(false);
    end

    self.sendingMail = true;
    local gold = outstandingCopper / 10000;

    self:disableSendButton();
    local MailDisableTimer, MailTimeOutTimer, MoneyChangedTimer;

    Events:register({
        { "MailCutsMailSuccess", "MAIL_SUCCESS" },
        { "MailCutsMailFailed", "MAIL_FAILED" },
        { "MailCutsMailTimedOut", "GL.MAIL_TIMED_OUT" },
    }, function(event)
        -- Remove all event listeners and scheduled timers FIRST
        GL.Ace:CancelTimer(MailDisableTimer);
        GL.Ace:CancelTimer(MailTimeOutTimer);
        Events:unregister{"MailCutsMailSuccess", "MailCutsMailFailed", "MailCutsMailTimedOut", "MailCutsPlayerMoney", };

        local message;
        local success = false;

        -- Mail was sent according to Blizzard, wait until player gold changes
        if (event == "MAIL_SUCCESS") then
            success = true;
            self.mailErrors = 0;

            Events:register("MailCutsPlayerMoney", "PLAYER_MONEY", function ()
                GL.Ace:CancelTimer(MoneyChangedTimer);
                Events:unregister("MailCutsPlayerMoney");

                local copperLeftMatchesExpectation = GetMoney() == copperLeftAfterMailing;
                if (copperLeftMatchesExpectation) then
                    message = string.format(L["Sent %sg to %s"], gold, player);
                    GL:success(message);

                    Events:fire("GL.GDKP_CUT_MAILED");
                else
                    message = L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"];
                    GL:warning(message);
                end

                self.sendingMail = false;
                callback(success, outstandingCopper, message);
            end);

            MoneyChangedTimer = GL.Ace:ScheduleTimer(function ()
                Events:unregister("MailCutsPlayerMoney");

                message = L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"];
                GL:error(message);

                callback(success, outstandingCopper, message);
            end, 15);

            return;
        else
            self.mailErrors = self.mailErrors + 1;
        end

        -- We add a delay to further decrease chances of nasty race conditions from occurring
        GL.Ace:ScheduleTimer(function ()
            message = event == "GL.MAIL_TIMED_OUT"
                and L["Failed to send cut to %s within %s seconds. Please check your remaining gold or Blizzard mail return to determine whether it went through."]
                or L["Failed to send cut to %s"];

            message = message:format(player, MAIL_SEND_WAIT_TIMEOUT);
            GL:error(message);

            self.sendingMail = false;
            callback(success, outstandingCopper, message);

            self:enableSendButton();
        end, .5);
    end);

    ClearSendMail();
    SetSendMailMoney(outstandingCopper);

    player = GL:nameFormat(player);
    SendMail(player, (self.cutMailSubject):format(gold), GL:printfn(self.cutMailBody, {
        cut = gold,
        player = player,
    }));

    MailDisableTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        self:disableSendButton();
    end, .2);

    MailTimeOutTimer = GL.Ace:ScheduleTimer(function ()
        Events:fire("GL.MAIL_TIMED_OUT");
    end, MAIL_SEND_WAIT_TIMEOUT);
end

---@return void
function MailCuts:disableSendButton()
    if (not _G.SendMailMailButton or not _G.SendMailMailButton.SetEnabled) then
        return;
    end

    _G.SendMailMailButton:SetEnabled(false);
end

---@return void
function MailCuts:enableSendButton()
    if (not _G.SendMailMailButton or not _G.SendMailMailButton.SetEnabled) then
        return;
    end

    _G.SendMailMailButton:SetEnabled(true);
end
