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
};

---@type MailCuts
local MailCuts = GL.Interface.GDKP.Distribute.MailCuts;

--- Show the cut mailer window when certain events are triggered
---@return void
function MailCuts:_init()
    GL:debug("MailCuts:_init");

    if (self._initialized) then
        return;
    end

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
    GL:debug("MailCuts:openIfCutsToMail");

    local Instance = GDKPSession:getActive();

    -- Check if the GDKP session exists and is locked for payout
    if (not Instance or not Instance.lockedAt) then
        return;
    end

    self:open();
end

---@return table
function MailCuts:open()
    GL:debug("MailCuts:open");

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
    GL:debug("MailCuts:close");

    self.isVisible = false;
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

---@return table
function MailCuts:build()
    GL:debug("MailCuts:build");

    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow(self.windowName, {
        width = 260,
        height = 1,
        hideMinimizeButton = true,
        hideMoveButton = true,
        hideResizeButton = true,
        closeWithEscape = false,
    });
    Window:SetPoint("TOPLEFT", _G.MailFrame, "TOPRIGHT", 2, 2);
    Window:SetPoint("BOTTOMLEFT", _G.MailFrame, "BOTTOMRIGHT", 4, -2);

    ---@type FontString
    local Intro = Interface:createFontString(Window, L.MAIL_CUTS_EXPLANATION);
    Intro:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -24);
    Intro:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -20, 0);
    Intro:SetJustifyH("MIDDLE");

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
    local MailAllCuts = Interface:dynamicPanelButton(Window, "Mail All");
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
    GL:debug("MailCuts:refreshPlayerCuts");

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
        return a < b;
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

        ---@type FontString
        local PlayerName = Interface:createFontString(PlayerRow, player);
        PlayerName:SetPoint("TOPLEFT", PlayerRow, "TOPLEFT", 0, 0);
        PlayerName:SetWidth(80);

        ---@type FontString
        local Gold = Interface:createFontString(PlayerRow, goldOwed .. "g");
        Gold:SetPoint("TOPLEFT", PlayerName, "TOPRIGHT", 4, 0);
        Gold:SetWidth(60);

        ---@type Button
        local MailCut = Interface:dynamicPanelButton(PlayerRow, L.MAIL);
        MailCut:SetPoint("TOPLEFT", Gold, "TOPRIGHT", 4, 0);
        MailCut:SetScript("OnClick", function ()
            self:mailPlayerCut(player, function (success, copper)
                if (not success) then
                    return;
                end

                copper = tonumber(copper);
                if (not copper or copper <= 0) then
                    return;
                end

                GDKPSession:registerGoldMail(player, copper);
                local cutsLeft = self:refreshPlayerCuts();

                -- Make sure to close the window when all cuts are mailed
                if (not cutsLeft) then
                    GL:success(L.ALL_CUTS_MAILED);
                    self:close();
                end
            end);
        end);

        i = i + 1;
    end

    _G[self.windowName].PlayerHolder = PlayerHolder;

    return i > 0;
end

---@return void
function MailCuts:mailAllCuts()
    GL:debug("MailCuts:mailingAllCuts");

    if (self.sendingMail) then
        GL:error(L.CUT_MAIL_IN_PROGRESS);

        return;
    end

    local Session = GDKPSession:getActive() or {};
    for player in pairs(GL:tableGet(Session, "Pot.Cuts", {})) do
        local outstanding = tonumber(GDKPSession:copperOwedToPlayer(player, Session.ID));
        if (outstanding and outstanding > 0) then
            return self:mailPlayerCut(player, function (success, copper)
                if (not success) then
                    self.mailErrors = self.mailErrors + 1;
                end

                copper = tonumber(copper);
                if (copper > 0) then
                    GDKPSession:registerGoldMail(player, copper);

                    -- Make sure to close the window when all cuts are mailed
                    if (not self:refreshPlayerCuts()) then
                        GL:success(L.CUTS_MAILED);
                        self:close();
                    end
                end

                if (self.mailErrors > 1) then
                    return GL:error(L.CUT_MAILS_FAILED);
                end

                self:mailAllCuts();
            end);
        end
    end

    GL:success(L.CUTS_MAILED);
end

---@param player string
---@param callback function|nil
function MailCuts:mailPlayerCut(player, callback)
    GL:debug("MailCuts:mailPlayerCut");

    if (self.sendingMail) then
        GL:error(L.CUT_MAIL_IN_PROGRESS);

        return;
    end

    -- Looks like the player closed his mailbox in the meantime
    if (not GL.mailIsShown) then
        GL:error(L.CUT_MAILBOX_CLOSED);
    end

    callback = callback or function () end;

    local Session = GDKPSession:getActive() or {};
    if (not Session) then
        return callback(false);
    end

    local outstandingCopper = GDKPSession:copperOwedToPlayer(player, Session.ID);
    if (not outstandingCopper) then
        return callback(true);
    end

    if (outstandingCopper > GetMoney()) then
        GL:warning(string.format(L.CUT_MAIL_INSUFFICIENT_FUNDS, player));

        return callback(false);
    end

    self.sendingMail = true;
    local gold = outstandingCopper / 10000;

    self:disableSendButton();
    local MailDisableTimer, MailTimeOutTimer;

    Events:register({
        { "MailCutsMailSuccess", "MAIL_SUCCESS" },
        { "MailCutsMailFailed", "MAIL_FAILED" },
        { "MailCutsMailTimedOut", "GL.MAIL_TIMED_OUT" },
    }, function(event)
        local success = false;
        if (event == "MAIL_SUCCESS") then
            self.mailErrors = 0;
            success = true;
        end

        GL.Ace:CancelTimer(MailDisableTimer);
        GL.Ace:CancelTimer(MailTimeOutTimer);
        Events:unregister({"MailCutsMailSuccess", "MailCutsMailFailed", "MailCutsMailTimedOut" });
        self:enableSendButton();

        -- We add a delay to further decrease chances of nasty race conditions from occurring
        GL.Ace:ScheduleTimer(function ()
            if (success) then
                GL:success(string.format(L.CUT_SENT, gold, player));
            end

            self.sendingMail = false;
            callback(success, outstandingCopper);
        end, .3);
    end);

    ClearSendMail();
    SetSendMailMoney(outstandingCopper);

    SendMail(player, string.format(L.CUT_MAIL_SUBJECT, gold), L.CUT_MAIL_BODY);

    MailDisableTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        self:disableSendButton();
    end, .2);

    MailTimeOutTimer = GL.Ace:ScheduleTimer(function ()
        Events:fire("GL.MAIL_TIMED_OUT");
    end, 5);
end

---@return void
function MailCuts:disableSendButton()
    GL:debug("MailCuts:disableSendButton");

    if (not _G.SendMailMailButton or not _G.SendMailMailButton.SetEnabled) then
        return;
    end

    _G.SendMailMailButton:SetEnabled(false);
end

---@return void
function MailCuts:enableSendButton()
    GL:debug("MailCuts:enableSendButton");

    if (not _G.SendMailMailButton or not _G.SendMailMailButton.SetEnabled) then
        return;
    end

    _G.SendMailMailButton:SetEnabled(true);
end

GL:debug("Importer.lua");