local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type Constants
local Constants = GL.Data.Constants;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@class GDKPGoldTradesOverviewInterface
GL:tableSet(GL, "Interface.GDKP.GoldTrades.Overview", {
    playerGUID = nil,
    sessionID = nil,
    windowName = "Gargul.Interface.GDKP.GoldTrades.Overview.Window",

    TradeRows = {},
});

---@type GDKPGoldTradesOverviewInterface
local Overview = GL.Interface.GDKP.GoldTrades.Overview;

--[[ CONSTANTS ]]
local DEFAULT_WINDOW_WIDTH = 390;
local DEFAULT_WINDOW_HEIGHT = 200;
local TRADE_ENTRY_HEIGHT = 30;
local FONT;

---@return Frame|nil
function Overview:open(sessionID, playerGUID)
    self.isVisible = true;
    FONT = GL.FONT;
    self.sessionID = sessionID;
    self.playerGUID = playerGUID;

    local Window = _G[self.windowName] or self:build();

    self:refresh();
    Window:Show();
    return Window;
end

---@return Frame
function Overview:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    local TradesHolder, ScrollFrame;
    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = DEFAULT_WINDOW_WIDTH,
        height = DEFAULT_WINDOW_HEIGHT,
        minWidth = DEFAULT_WINDOW_WIDTH,
        minHeight = DEFAULT_WINDOW_HEIGHT,
        maxWidth = 500,
        maxHeight = 700,
        hideMinimizeButton = true,
    };

    Window:SetScript("OnHide", function ()
        self.isVisible = false;
    end);

    Window:HookScript("OnSizeChanged", function ()
        TradesHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    end);

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    --[[ CURRENT BALANCE ]]
    ---@type FontString
    local Balance = Interface:createFontString(Window, "");
    Balance:SetFont(1.25, "OUTLINE");
    Balance:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -30);
    Window.Balance = Balance;

    --[[ SCROLLFRAME BOILERPLATE ]]
    ---@type ScrollFrame
    ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOPLEFT", Window, "TOPLEFT", 10, -60);
    ScrollFrame:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -44, 58);

    ---@type Frame
    TradesHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(TradesHolder);
    TradesHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    TradesHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    TradesHolder:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");

    ---@type Frame
    local Trades = CreateFrame("Frame", nil, TradesHolder);
    Trades:SetAllPoints(TradesHolder);

    ---@type Frame
    local ActionButtons;

    do -- [[ ACTION BUTTONS ]]
        ---@type Frame
        ActionButtons = CreateFrame("Frame", nil, TradesHolder);
        ActionButtons:SetSize(38, 18);
        ActionButtons:Hide();

        local NormalTexture, HighlightTexture;

        --[[ DELETE BUTTON ]]
        ---@type Button
        ActionButtons.DeleteButton = CreateFrame("Button", nil, ActionButtons, "UIPanelButtonTemplate");
        ActionButtons.DeleteButton:SetSize(18, 18);
        ActionButtons.DeleteButton:SetPoint("TOPLEFT", ActionButtons, "TOPLEFT");

        ---@type Texture
        NormalTexture = ActionButtons.DeleteButton:CreateTexture();
        NormalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/delete");
        NormalTexture:SetAllPoints(ActionButtons.DeleteButton);
        ActionButtons.DeleteButton:SetNormalTexture(NormalTexture);

        ---@type Texture
        HighlightTexture = ActionButtons.DeleteButton:CreateTexture();
        HighlightTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/delete");
        NormalTexture:SetAllPoints(ActionButtons.DeleteButton);
        ActionButtons.DeleteButton:SetHighlightTexture(HighlightTexture);

        Interface:addTooltip(ActionButtons.DeleteButton, L.DELETE, "TOP");

        --[[ RESTORE BUTTON ]]
        ---@type Button
        ActionButtons.RestoreButton = CreateFrame("Button", nil, ActionButtons, "UIPanelButtonTemplate");
        ActionButtons.RestoreButton:SetSize(18, 18);
        ActionButtons.RestoreButton:SetPoint("TOPLEFT", ActionButtons, "TOPLEFT");

        ---@type Texture
        NormalTexture = ActionButtons.RestoreButton:CreateTexture();
        NormalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/restore");
        NormalTexture:SetAllPoints(ActionButtons.RestoreButton);
        ActionButtons.RestoreButton:SetNormalTexture(NormalTexture);

        ---@type Texture
        HighlightTexture = ActionButtons.RestoreButton:CreateTexture();
        HighlightTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/restore");
        NormalTexture:SetAllPoints(ActionButtons.RestoreButton);
        ActionButtons.RestoreButton:SetHighlightTexture(HighlightTexture);

        Interface:addTooltip(ActionButtons.RestoreButton, L.RESTORE, "TOP");
    end

    --[[ ADD TRADE BUTTON ]]
    ---@type Button
    local EnableQueue = Interface:dynamicPanelButton(Window, "Add Trade");
    EnableQueue:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 32);
    EnableQueue:SetPoint("RIGHT", Window, "RIGHT", -20, 0);
    EnableQueue:SetScript("OnClick", function ()
        GL.Interface.GDKP.GoldTrades.Create:open(self.sessionID, self.playerGUID);
    end);

    Window.TradesHolder = TradesHolder;
    Window.ActionButtons = ActionButtons;

    _G[self.windowName] = Window;
    return Window;
end

---@return void
function Overview:refresh()
    local sessionID = self.sessionID;
    local playerGUID = self.playerGUID;

    local Instance = GDKPSession:byID(sessionID);
    if (not Instance) then
        return;
    end

    for _, Row in pairs(self.TradeRows or {}) do
        Interface:release(Row);
    end

    ---@type Frame
    local Window = _G[self.windowName] or self:build();
    Window.Balance:SetText("");
    Window.ActionButtons:Hide();

    ---@type Frame
    local TradesHolder = Window.TradesHolder;

    ---@type Frame
    local ActionButtons = Window.ActionButtons;

    --[[ SHOW THE PLAYER BALANCE ]]
    local balance = "";
    local playerName = GL:disambiguateName(playerGUID, { colorize = true });
    local copperOwedToPLayer = GDKPSession:copperOwedToPlayer(playerGUID, sessionID);
    if (copperOwedToPLayer == 0) then
        balance = playerName;
    elseif (copperOwedToPLayer > 0) then
        balance = ("You owe %s %s"):format(playerName, GL:copperToMoney(copperOwedToPLayer));
    else
        balance = ("%s owes you %s"):format(playerName, GL:copperToMoney(copperOwedToPLayer * -1));
    end
    Window.Balance:SetText(balance);

    -- Sort from newest to oldest
    local Trades = {};
    for _, Trade in pairs(GL:tableGet(Instance, "GoldLedger." .. playerGUID, {})) do
        tinsert(Trades, Trade);
    end

    table.sort(Trades, function (a, b)
        if (a.createdAt and b.createdAt) then
            return a.createdAt > b.createdAt;
        end

        return false;
    end);

    local today = date("%d-%m-%Y");
    local tradesAdded = false;
    local i = 1;
    for _, Trade in pairs(Trades or {}) do
        Trade.given = tonumber(Trade.given) or 0;
        Trade.received = tonumber(Trade.received) or 0;

        ---@type Frame
        local TradeRow = CreateFrame("Frame", nil, TradesHolder);
        TradeRow:SetHeight(TRADE_ENTRY_HEIGHT);

        TradeRow:SetPoint("TOPLEFT", TradesHolder, "TOPLEFT", 0, ((i - 1) * TRADE_ENTRY_HEIGHT) * -1);
        TradeRow:SetPoint("TOPRIGHT", TradesHolder, "TOPRIGHT", not GL.elvUILoaded and 0 or -4, 0);

        --[[ TOGGLE DELETE ON HOVER ]]
        TradeRow:SetScript("OnEnter", function ()
            ActionButtons:ClearAllPoints();
            ActionButtons:SetPoint("CENTER", TradeRow, "CENTER");
            ActionButtons:SetPoint("RIGHT", TradeRow, "RIGHT", 18, 0);
            ActionButtons:SetFrameLevel(TradeRow:GetFrameLevel() + 1);

            if (Trade.deletedAt) then
                ActionButtons.DeleteButton:Hide();
                ActionButtons.RestoreButton:Show();
            else
                ActionButtons.DeleteButton:Show();
                ActionButtons.RestoreButton:Hide();
            end
            ActionButtons:Show();

            ActionButtons.DeleteButton:SetScript("OnClick", function ()
                GDKPSession:deleteGoldTrade(sessionID, playerGUID, Trade.checksum);
                self:refresh(sessionID, playerGUID);
            end);

            ActionButtons.RestoreButton:SetScript("OnClick", function ()
                GDKPSession:restoreGoldTrade(sessionID, playerGUID, Trade.checksum);
                self:refresh(sessionID, playerGUID);
            end);
        end);

        TradeRow:SetScript("OnLeave", function ()
            if (not Interface:mouseIsOnFrame(ActionButtons)) then
                ActionButtons:Hide();
            end
        end);

        local description = "";
        if (Trade.given > 0) then
            if (Trade.type == Constants.GDKP.tradeIdentifier) then
                description = ("Traded %s to %s"):format(GL:copperToMoney(Trade.given), playerName);
            elseif (Trade.type == Constants.GDKP.mailIdentifier) then
                description = ("Mailed %s to %s"):format(GL:copperToMoney(Trade.given), playerName);
            elseif (Trade.type == Constants.GDKP.mutationIdentifier) then
                description = ("Traded %s to %s"):format(GL:copperToMoney(Trade.given), playerName);
            end
        else
            description = ("Received %s from %s"):format(GL:copperToMoney(Trade.received), playerName);
        end

        if (Trade.type == Constants.GDKP.mutationIdentifier) then
            description = ("|c00FFF569[%s]|r  %s"):format("Manual", description);
        end

        if (Trade.deletedAt) then
            description = ("|c00BE3333[%s]|r  %s"):format("Deleted", description);
        end

        ---@type FontString
        local isToday = date("%d-%m-%Y", Trade.createdAt) == today;
        local timeString = isToday
            and ("|c00967FD2[%s]|r"):format(date("%H:%M", Trade.createdAt))
            or ("|c00967FD2[%s]|r"):format(date("%d-%m at %H:%M", Trade.createdAt))
        local Time = Interface:createFontString(TradeRow, timeString);
        Time:SetPoint("CENTER", TradeRow);
        Time:SetPoint("LEFT", TradeRow, "LEFT", 10, 0);
        Time:SetHeight(TRADE_ENTRY_HEIGHT);

        ---@type FontString
        local Name = Interface:createFontString(TradeRow, description);
        Name:SetFont(1, "OUTLINE");
        Name:SetPoint("CENTER", TradeRow);
        Name:SetPoint("LEFT", Time, "RIGHT", 4, 0);
        Name:SetHeight(TRADE_ENTRY_HEIGHT);

        tinsert(self.TradeRows, TradeRow);
        tradesAdded = true;
        i = i + 1;
    end

    if (not tradesAdded) then
        self:close();
    end
end

---@return void
function Overview:close()
    self.isVisible = false;
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

---@return Frame
function Overview:getWindow()
    return _G[self.windowName];
end

GL:debug("Auctioneer.lua");