local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

---@type Constants
local Constants = GL.Data.Constants;

---@type Settings
local Settings = GL.Settings;

---@type Interface
local Interface = GL.Interface;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

---@class GDKPLedgerList
GL.Interface.GDKP.LedgerList = {
    isVisible = false,
    sessionID = nil,
    windowName = "Gargul.Interface.GDKP.LedgerList.Window",

    PlayersTables = {},
    SalesTables = {},
};

---@type GDKPLedgerList
local LedgerList = GL.Interface.GDKP.LedgerList;

local DEFAULT_PLAYER_COLUMN_WIDTH = 90;
local HEIGHT_PER_ROW = 15;
-- Space above the tables (title, session/pot, legend)
local HEADER_HEIGHT = 110;
-- lib-st header row + frame padding
local TABLE_OVERHEAD = HEIGHT_PER_ROW + 10;
local MAX_PLAYER_COLS = 3;
local PLAYER_COL_MARGIN = 6;

local PLAYERS_TABLE_COLUMNS = {
    { name = L["Player"], width = DEFAULT_PLAYER_COLUMN_WIDTH, },
    --{ name = "Bid", width = 60, },
    --{ name = "Spent", width = 60, },
    { name = L["Paid"], width = 60, },
    { name = L["Cut"], width = 60, },
    { name = L["Given"], width = 60, },
    { name = L["Mailed"], width = 60, },
    { name = L["Balance"], width = 60, },
};

local SALES_TABLE_COLUMNS = {
    { -- Icon
        width = HEIGHT_PER_ROW,
        align = "LEFT",
        DoCellUpdate = GL.LibStItemCellUpdate,
    },
    { width = 140, }, -- Item
    { width = 80, }, -- Player
    { width = 60, align = "RIGHT", }, -- Price
};

--- Tear down the current window for a fresh build
---@return nil
function LedgerList:destroy()
    local Window = self._currentWindow;
    self._currentWindow = nil;

    if (Window) then
        Window:SetScript("OnHide", nil);
        Window:Hide();

        -- Drop stale _G and UISpecialFrames entries
        local name = Window:GetName();
        if (name) then
            _G[name] = nil;
            for i = #UISpecialFrames, 1, -1 do
                if (UISpecialFrames[i] == name) then
                    table.remove(UISpecialFrames, i);
                    break;
                end
            end
        end
    end

    _G[self.windowName] = nil;
    self.PlayersTable = nil;
    self.PlayersTables = {};
    self.SalesTables = {};
    self.PotDetails = nil;
    self.SessionDetails = nil;
    self.PlayerOverflow = nil;
    self.SalesOverflow = nil;
end

---@return table
function LedgerList:open(sessionID)
    self:destroy();
    self.sessionID = sessionID;

    local Window = self:build();

    self:refresh();

    Window:SetFrameLevel(5000);
    Window:Show();

    -- Keep the window on top
    Window:SetMovable(true);
    Window:StartMoving();
    Window:StopMovingOrSizing();
    Window:SetMovable(false);

    self._currentWindow = Window;
    return Window;
end

---@return nil
function LedgerList:close()
    if (self._currentWindow) then
        self._currentWindow:Hide();
    end

    GL.Interface.GDKP.Overview:open();
end

---@return table
function LedgerList:build()
    -- Unique frame name per build
    self._buildCount = (self._buildCount or 0) + 1;
    local windowName = self.windowName .. "." .. self._buildCount;

    -- Row count fits below HEADER_HEIGHT and TABLE_OVERHEAD
    local tableRows = math.max(10, math.floor((UIParent:GetHeight() - HEADER_HEIGHT - TABLE_OVERHEAD) / HEIGHT_PER_ROW));
    self.tableRows = tableRows;

    -- Count players so we can pre-build the right number of player columns
    local Session = GDKPSession:byID(self.sessionID);
    local playerCount = 0;
    if (Session) then
        local Cuts = GL:tableGet(Session, "Pot.Cuts", {});
        for player in pairs(Cuts) do
            if (GL:tableGet(Session, "Pot.DistributionDetails." .. player)) then
                playerCount = playerCount + 1;
            end
        end
    end
    local numPlayerCols = math.min(MAX_PLAYER_COLS, math.max(1, math.ceil(playerCount / tableRows)));

    ---@type Frame
    local Window = Interface:createWindow({
        name = windowName,
        width = 1,
        height = 1,
        hideMinimizeButton = true,
        hideMoveButton = true,
        hideResizeButton = true,
        hideWatermark = true,
        OnClose = function ()
            self:close();
        end,
    });

    Window:SetClampedToScreen(false);
    Window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -2, 2);
    Window:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 2, -2);

    ---@type FontString
    local Watermark = Interface:createFontString(Window, GL.name .. " v" .. GL.version);
    Watermark:SetFont(2, "OUTLINE");
    Watermark:SetColor("GRAY");
    Watermark:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -30, -30);


    self.PlayersTables = {};
    for i = 1, numPlayerCols do
        local T = GL.ScrollingTable:CreateST(PLAYERS_TABLE_COLUMNS, tableRows, HEIGHT_PER_ROW, nil, Window);
        T:EnableSelection(false);
        GL:LibStRemoveScrollBar(T);
        if (i > 1) then
            T.head:Hide();
            T.frame:SetPoint("TOPLEFT", self.PlayersTables[i - 1].frame, "TOPRIGHT", PLAYER_COL_MARGIN, 0);
        end
        tinsert(self.PlayersTables, T);
    end
    self.PlayersTable = self.PlayersTables[1];

    local playerColWidth = self.PlayersTables[1].frame:GetWidth();
    local totalPlayerWidth = playerColWidth * numPlayerCols + PLAYER_COL_MARGIN * (numPlayerCols - 1);
    local widthLeft = UIParent:GetWidth() - totalPlayerWidth;
    local LastTable = self.PlayersTables[numPlayerCols];

    local count = 0;
    while (true) do
        count = count + 1;
        local marginLeft = 6;
        local Table = GL.ScrollingTable:CreateST(SALES_TABLE_COLUMNS, tableRows, HEIGHT_PER_ROW, nil, Window);
        Table:EnableSelection(false);
        Table.head:Hide();
        Table.frame:SetPoint("TOPLEFT", LastTable.frame, "TOPRIGHT", marginLeft, 0);
        local tableWidth = Table.frame:GetWidth();

        if (widthLeft - tableWidth <= 0) then
            Table.frame:Hide();
            Table = nil;
            break;
        end

        if (count > 10) then
            break;
        end

        widthLeft = widthLeft - tableWidth - marginLeft;
        LastTable = Table;
        GL:LibStRemoveScrollBar(Table);

        tinsert(self.SalesTables, Table);
    end

    self.PlayersTables[1].frame:SetPoint("TOP", Window, "TOP", 0, -HEADER_HEIGHT);
    self.PlayersTables[1].frame:SetPoint("LEFT", Window, "LEFT", widthLeft / 2, 0);

    local PlayersTable = self.PlayersTable;

    ---@type FontString
    local PotDetails = Interface:createFontString(Window, "");
    PotDetails:SetPoint("BOTTOMLEFT", PlayersTable.frame, "TOPLEFT", 0, 60);
    PotDetails:SetFont(1.75, "OUTLINE");
    self.PotDetails = PotDetails;

    ---@type FontString
    local SessionDetails = Interface:createFontString(Window);
    SessionDetails:SetPoint("BOTTOMLEFT", PotDetails, "TOPLEFT", 0, 5);
    self.SessionDetails = SessionDetails;

    local colorizedUser = GL:formatPlayerName(GL.User.name, { class = GL.User.class, colorize = true, });

    ---@type FontString
    local Paid = Interface:createFontString(Window, (L["Gold paid to %s"]):format(
        colorizedUser
    ));
    Paid:SetPoint("BOTTOMLEFT", PlayersTable.frame, "TOPLEFT", 0, 40);

    do
        local Line = Window:CreateLine();
        Line:SetThickness(2);
        Line:SetColorTexture(.6, .5, .82, 1);
        Line:SetStartPoint("BOTTOMLEFT", Paid, 0, -4);
        Line:SetEndPoint("BOTTOMRIGHT", Paid, 0, -4);

        Line = Window:CreateLine();
        Line:SetThickness(1);
        Line:SetColorTexture(.6, .5, .82, 1);
        Line:SetStartPoint("CENTER", Paid, 0, -10);
        Line:SetEndPoint("TOPLEFT", PlayersTable.head.cols[2], 0, 0);
    end

    ---@type FontString
    local Received = Interface:createFontString(Window, (L["Gold received from %s"]):format(
        colorizedUser
    ));
    Received:SetPoint("TOPLEFT", Paid, "TOPRIGHT", 20, 0);

    do
        local Line = Window:CreateLine();
        Line:SetThickness(2);
        Line:SetColorTexture(.6, .5, .82, 1);
        Line:SetStartPoint("BOTTOMLEFT", Received, 0, -4);
        Line:SetEndPoint("BOTTOMRIGHT", Received, 0, -4);

        Line = Window:CreateLine();
        Line:SetThickness(1);
        Line:SetColorTexture(.6, .5, .82, 1);
        Line:SetStartPoint("CENTER", Received, 0, -10);
        Line:SetEndPoint("TOPLEFT", PlayersTable.head.cols[4], 10, 0);
    end

    ---@type FontString
    local Mailed = Interface:createFontString(Window, (L["Gold mailed to you by %s"]):format(
        colorizedUser
    ));
    Mailed:SetPoint("TOPLEFT", Received, "TOPRIGHT", 20, 0);

    do
        local Line = Window:CreateLine();
        Line:SetThickness(2);
        Line:SetColorTexture(.6, .5, .82, 1);
        Line:SetStartPoint("BOTTOMLEFT", Mailed, 0, -4);
        Line:SetEndPoint("BOTTOMRIGHT", Mailed, 0, -4);

        Line = Window:CreateLine();
        Line:SetThickness(1);
        Line:SetColorTexture(.6, .5, .82, 1);
        Line:SetStartPoint("CENTER", Mailed, 0, -10);
        Line:SetEndPoint("TOPLEFT", PlayersTable.head.cols[5], 20, 0);
    end

    ---@type FontString
    local Balance = Interface:createFontString(Window, (L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"]):format(
        colorizedUser,
        colorizedUser
    ));
    Balance:SetPoint("TOPLEFT", Mailed, "TOPRIGHT", 20, 0);

    do
        local Line = Window:CreateLine();
        Line:SetThickness(2);
        Line:SetColorTexture(.6, .5, .82, 1);
        Line:SetStartPoint("BOTTOMLEFT", Balance, 0, -4);
        Line:SetEndPoint("BOTTOMRIGHT", Balance, 0, -4);

        Line = Window:CreateLine();
        Line:SetThickness(1);
        Line:SetColorTexture(.6, .5, .82, 1);
        Line:SetStartPoint("BOTTOMRIGHT", PlayersTable.head.cols[6], 0, 8);
        Line:SetEndPoint("BOTTOMRIGHT", PlayersTable.head.cols[6], 200, 8);
        local PreviousLine = Line;

        Line = Window:CreateLine();
        Line:SetThickness(1);
        Line:SetColorTexture(.6, .5, .82, 1);
        Line:SetStartPoint("RIGHT", PreviousLine, 0, 0);
        Line:SetEndPoint("BOTTOM", Balance, 0, -4);
    end

    local LastPlayerTable = self.PlayersTables[numPlayerCols];
    local PlayerOverflow = Interface:createFontString(Window, "");
    PlayerOverflow:SetPoint("TOPLEFT", LastPlayerTable.frame, "BOTTOMLEFT", 0, -4);
    PlayerOverflow:Hide();
    self.PlayerOverflow = PlayerOverflow;

    if (self.SalesTables[1]) then
        local LastSalesTable = self.SalesTables[#self.SalesTables];
        local SalesOverflow = Interface:createFontString(Window, "");
        SalesOverflow:SetPoint("TOPLEFT", LastSalesTable.frame, "BOTTOMLEFT", 0, -4);
        SalesOverflow:Hide();
        self.SalesOverflow = SalesOverflow;
    end

    -- Global alias for tests
    _G[self.windowName] = Window;

    return Window;
end

---@return nil
function LedgerList:refresh()
    local Session = GDKPSession:byID(self.sessionID);

    if (type(Session) ~= "table") then
        return;
    end

    local tableRows = self.tableRows;

    local totalPot = GDKPPot:total(Session.ID);
    local managementCutPercentage = tonumber(Session.managementCut) or 0;
    local managementCut = GL:floor(totalPot * (0 + managementCutPercentage / 100), Settings:get("GDKP.precision"));
    self.PotDetails:SetText((L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"]):format(
        totalPot,
        managementCut,
        managementCutPercentage,
        GL:floor(totalPot - managementCut, Settings:get("GDKP.precision"))
    ));

    local guild = "";
    local CreatedBy = Session.CreatedBy or { class = "priest", name = "unknown", guild = "unknown", uuid = "unknown", };
    if (CreatedBy.guild) then
        guild = (" |c001EFF00<%s>|r"):format(CreatedBy.guild);
    end
    self.SessionDetails:SetText((L["|c00967FD2%s | By %s%s | On |c00967FD2%s"]):format(
        Session.title,
        GL:formatPlayerName(CreatedBy.name, { realm = CreatedBy.realm, colorize = true, }),
        guild,
        date(L["%Y-%m-%d"], Session.createdAt)
    ));

    for _, T in pairs(self.PlayersTables or {}) do
        T:SetData({}, true);
    end
    for _, Table in pairs(self.SalesTables or {}) do
        Table:SetData({}, true);
    end

    local Cuts = GL:tableGet(Session, "Pot.Cuts", {});
    if (type(Cuts) == "table") then
        local PlayerNames = {};
        for player in pairs(Cuts) do
            if (GL:tableGet(Session, "Pot.DistributionDetails." .. player)) then
                tinsert(PlayerNames, player);
            end
        end

        local PlayerData = {};
        for _, player in pairs(PlayerNames) do
            local playerGUID = GDKP:playerGUID(player);
            local _, copperReceived, copperTraded, copperMailed = GDKPSession:goldTradedWithPlayer(playerGUID, Session.ID);
            local spent = GDKPSession:goldSpentByPlayer(player, self.sessionID);
            local bid = GDKPSession:goldBidByPlayer(player, self.sessionID);

            local copperToGive = GDKPSession:copperOwedToPlayer(player, Session.ID);

            local balanceText;
            if (player ~= GL.User.name) then
                if (copperToGive > 0) then
                    balanceText = ("|c00F7922E%s|r"):format(copperToGive / 10000);
                elseif (copperToGive < 0) then
                    balanceText = ("|c00BE3333%s|r"):format((copperToGive * -1) / 10000);
                else
                    balanceText = ("|c0092FF00%s|r"):format(0);
                end
            else
                balanceText = ("|c0092FF00%s|r"):format(0);
            end

            tinsert(PlayerData, {
                balance = balanceText,
                balanceCopper = copperToGive,
                bid = bid,
                cut = Cuts[player],
                given = copperTraded / 10000,
                mailed = copperMailed / 10000,
                name = player,
                received = copperReceived / 10000,
                spent = spent,
            });
        end

        local function playerHasLedgerActivity(Player)
            return (Player.cut or 0) ~= 0
                or (Player.spent or 0) ~= 0
                or (Player.given or 0) ~= 0
                or (Player.received or 0) ~= 0
                or (Player.mailed or 0) ~= 0
                or (Player.balanceCopper or 0) ~= 0;
        end

        -- Players with ledger activity first, then alpha within each group.
        table.sort(PlayerData, function (a, b)
            local aActive = playerHasLedgerActivity(a);
            local bActive = playerHasLedgerActivity(b);
            if (aActive ~= bActive) then
                return aActive;
            end
            return a.name < b.name;
        end);

        local TableData = {};
        for _, Player in pairs(PlayerData) do
            tinsert(TableData, {
                cols = {
                    { value = GL:disambiguateName(Player.name, { colorize = true, }), },
                    --{ value = Player.bid, },
                    --{ value = Player.spent, },
                    { value = Player.received, },
                    { value = Player.cut, },
                    { value = Player.given, },
                    { value = Player.mailed, },
                    { value = Player.balance, },
                },
            });
        end

        for i, T in pairs(self.PlayersTables) do
            local startIdx = (i - 1) * tableRows + 1;
            local chunk = {};
            for j = startIdx, math.min(startIdx + tableRows - 1, #TableData) do
                tinsert(chunk, TableData[j]);
            end
            T:SetData(chunk);
        end

        if (self.PlayerOverflow) then
            local maxPlayers = #self.PlayersTables * tableRows;
            if (#TableData > maxPlayers) then
                self.PlayerOverflow:SetText(("|c00BE3333+%d not shown|r"):format(#TableData - maxPlayers));
                self.PlayerOverflow:Show();
            else
                self.PlayerOverflow:Hide();
            end
        end
    end

    if (type(Session.Auctions) ~= "table") then
        return;
    end

    local Auctions = GL:tableValues(Session.Auctions);
    table.sort(Auctions, function (a, b)
        local aCreatedAt = tonumber(a.createdAt);
        local bCreatedAt = tonumber(b.createdAt);

        if (aCreatedAt and bCreatedAt) then
            return aCreatedAt < bCreatedAt;
        end

        return false;
    end);

    local SalesData = {};
    local saleCount = 0;
    for _, Auction in pairs(Auctions) do
        if (type(Auction) == "table"
            and type(Auction.Winner) == "table"
            and type(Auction.itemID) == "number"
        ) then
            saleCount = saleCount + 1;

            local jar = math.ceil(saleCount / tableRows);

            if (self.SalesTables[jar]) then
                SalesData[jar] = SalesData[jar] or {};
                tinsert(SalesData[jar], Auction);
            end
        end
    end

    local function setTableData(Table, Data)
        local TableData = {};
        for _, Auction in pairs(Data) do
            local mutation;
            if (Auction.itemID == Constants.GDKP.potIncreaseItemID) then
                mutation = (L["Gold %s by"]):format(Auction.price < 0 and "removed" or "added");
            end

            tinsert(TableData, {
                cols = {
                    { value = Auction.itemLink, },
                    { value = mutation and mutation or Auction.itemLink, },
                    {
                        value = ("|c00%s%s|r"):format(
                            GL:classHexColor(Auction.Winner.class),
                            Auction.Winner.name
                        ),
                    },
                    {
                        value = ("|c00FFFFFF%s|r|c00FFF569|r"):format(
                            Auction.price
                        ),
                    },
                },
            });
        end

        Table:SetData(TableData);
    end

    for jar, Sales in pairs(SalesData) do
        if (self.SalesTables[jar]) then
            setTableData(self.SalesTables[jar], Sales);
        end
    end

    if (self.SalesOverflow) then
        local maxSales = #self.SalesTables * tableRows;
        if (saleCount > maxSales) then
            self.SalesOverflow:SetText(("|c00BE3333+%d not shown|r"):format(saleCount - maxSales));
            self.SalesOverflow:Show();
        else
            self.SalesOverflow:Hide();
        end
    end
end
