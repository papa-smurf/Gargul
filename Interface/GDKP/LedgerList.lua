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

    SalesTables = {},
};

---@type GDKPLedgerList
local LedgerList = GL.Interface.GDKP.LedgerList;

--[[ CONSTANTS ]]
local TABLE_ROWS = 40;
local DEFAULT_PLAYER_COLUMN_WIDTH = 90;
local HEIGHT_PER_ROW = 16;

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

---@return table
function LedgerList:open(sessionID)
    self.sessionID = sessionID;

    local Window = _G[self.windowName] or self:build();

    self:refresh();

    Window:SetFrameLevel(5000);
    Window:Show();

    -- This is to make sure this window is always on top
    Window:SetMovable(true);
    Window:StartMoving();
    Window:StopMovingOrSizing();
    Window:SetMovable(false);

    return Window;
end

---@return nil
function LedgerList:close()
    if (_G[self.windowName]) then
        _G[self.windowName]:Hide();
    end

    GL.Interface.GDKP.Overview:open();
end

---@return table
function LedgerList:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = 1,
        height = 1,
        hideMinimizeButton = true,
        hideMoveButton = true,
        hideResizeButton = true,
        OnClose = function ()
            self:close();
        end,
    };

    Window:SetClampedToScreen(false);
    Window:SetPoint("TOPLEFT", UIParent, "TOPLEFT", -2, 2);
    Window:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 2, -2);
    Window.Watermark:SetFont(1.75, "OUTLINE");

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        {text = L["Window"], isTitle = true, notCheckable = true },
        {text = L["Adjust Scale"], notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end},
    });

    local PlayersTable = GL.ScrollingTable:CreateST(PLAYERS_TABLE_COLUMNS, TABLE_ROWS, HEIGHT_PER_ROW, nil, Window);
    PlayersTable:EnableSelection(false);
    GL:LibStRemoveScrollBar(PlayersTable);
    self.PlayersTable = PlayersTable;

    --[[ GENERATE AS MANY SALES TABLES AS POSSIBLE ]]
    local widthLeft = UIParent:GetWidth() - PlayersTable.frame:GetWidth();
    local LastTable = PlayersTable;
    local count = 0;
    while(true) do
        count = count + 1;
        local marginLeft = 6;
        local Table = GL.ScrollingTable:CreateST(SALES_TABLE_COLUMNS, TABLE_ROWS, HEIGHT_PER_ROW, nil, Window);
        Table:EnableSelection(false);
        Table.head:Hide(); -- Remove the table header
        Table.frame:SetPoint("TOPLEFT", LastTable.frame, "TOPRIGHT", marginLeft, 0);
        local tableWidth = Table.frame:GetWidth();

        if (widthLeft - tableWidth <= 0) then
            Table.frame:Hide();
            Table = nil;
            break;
        end

        --[[ JUST IN CASE WE RUN INTO SOME WEIRD ENDLESS LOOP TYPE OF SITUATION ]]
        if (count > 10) then
            break;
        end

        widthLeft = widthLeft - tableWidth - marginLeft;
        LastTable = Table;
        GL:LibStRemoveScrollBar(Table);

        tinsert(self.SalesTables, Table);
    end

    PlayersTable.frame:SetPoint("TOP", Window, "TOP", 0, (Window:GetHeight() - PlayersTable.frame:GetHeight()) / 2 * -1 - 30);
    PlayersTable.frame:SetPoint("LEFT", Window, "LEFT", widthLeft / 2, 0);

    ---@type FontString
    local PotDetails = Interface:createFontString(Window, "");
    PotDetails:SetPoint("BOTTOMLEFT", PlayersTable.frame, "TOPLEFT", 0, 60);
    PotDetails:SetFont(1.75, "OUTLINE");
    self.PotDetails = PotDetails;

    ---@type FontString
    local SessionDetails = Interface:createFontString(Window);
    SessionDetails:SetPoint("BOTTOMLEFT", PotDetails, "TOPLEFT", 0, 5);
    self.SessionDetails = SessionDetails;

    local colorizedUser = GL:nameFormat{ name = GL.User.name, class = GL.User.class, colorize = true, };

    --[[ DRAW LEGEND ]]
    ---@type FontString
    local Paid = Interface:createFontString(Window, (L["Gold paid to %s"]):format(
        colorizedUser
    ));
    Paid:SetPoint("BOTTOMLEFT", PlayersTable.frame, "TOPLEFT", 0, 40);

    do --[[ PAID LINES ]]
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

    do --[[ RECEIVED LINES ]]
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

    do --[[ MAILED LINES ]]
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

    do --[[ BALANCE LINES ]]
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

    --[[ SHOW THE IDENTITY OF THE ORGANIZER ]]
    -- Determine which identity to activate
    local Identity = Interface.Identity:buildForLedger(GL.User:bth());
    Identity:SetParent(Window);
    Identity:SetPoint("CENTER", Balance, "CENTER");
    Identity:SetPoint("LEFT", Balance, "RIGHT", 60, 0);

    _G[self.windowName] = Window;
    return Window;
end

---@return nil
function LedgerList:refresh()
    local Session = GDKPSession:byID(self.sessionID);

    if (type(Session) ~= "table") then
        return;
    end

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
        guild = string.format(" |c001EFF00<%s>|r", CreatedBy.guild);
    end
    self.SessionDetails:SetText(string.format(
        L["|c00967FD2%s | By %s%s | On |c00967FD2%s"],
        Session.title,
        GL:nameFormat{ name = CreatedBy.name, realm = CreatedBy.realm, colorize = true, },
        guild,
        date(L["%Y-%m-%d"], Session.createdAt)
    ));

    -- Clear all table data
    self.PlayersTable:SetData({}, true);
    for _, Table in pairs(self.SalesTables or {}) do
        Table:SetData({}, true);
    end

    -- We can't work with this session since there are no auctions attached
    local Cuts = GL:tableGet(Session, "Pot.Cuts", {});
    if (type(Cuts) == "table") then
        local PlayerNames = {};
        for player in pairs(Cuts) do
            if (GL:tableGet(Session, "Pot.DistributionDetails." .. player)) then
                tinsert(PlayerNames, player);
            end
        end

        table.sort(PlayerNames, function (a, b)
            if (a and b) then
                return a < b;
            end

            return false;
        end);

        local PlayerData = {};
        for _, player in pairs(PlayerNames or {}) do
            local playerGUID = GDKP:playerGUID(player);
            local _, copperReceived, copperTraded, copperMailed = GDKPSession:goldTradedWithPlayer(playerGUID, Session.ID);
            local spent = GDKPSession:goldSpentByPlayer(player, self.sessionID);
            local bid = GDKPSession:goldBidByPlayer(player, self.sessionID);

            local copperToGive = GDKPSession:copperOwedToPlayer(player, Session.ID);

            local balanceText;
            if (player ~= GL.User.name) then
                if (copperToGive > 0) then
                    balanceText = string.format("|c00F7922E%s|r", copperToGive / 10000);
                elseif (copperToGive < 0) then
                    balanceText = string.format("|c00BE3333%s|r", (copperToGive * -1) / 10000);
                else
                    balanceText = string.format("|c0092FF000|r");
                end
            else
                balanceText = string.format("|c0092FF000|r");
            end

            tinsert(PlayerData, {
                balance = balanceText,
                bid = bid,
                cut = Cuts[player],
                given = copperTraded / 10000,
                mailed = copperMailed / 10000,
                name = player,
                received = copperReceived / 10000,
                spent = spent,
            });
        end

        local TableData = {};
        for _, Player in pairs(PlayerData or {}) do
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

        self.PlayersTable:SetData(TableData);
    end

    -- There are no sales
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

    local SalesData = {}, {};
    local count = 0;
    for _, Auction in pairs(Auctions) do
        if (type(Auction) == "table"
            and type(Auction.Winner) == "table"
            and type(Auction.itemID) == "number"
        ) then
            count = count + 1;

            local jar = math.ceil(count / TABLE_ROWS);

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
                mutation = string.format(L["Gold %s by"], Auction.price < 0 and "removed" or "added");
            end

            tinsert(TableData, {
                cols = {
                    { value = Auction.itemID, },
                    { value = mutation and mutation or Auction.itemLink, },
                    {
                        value = string.format("|c00%s%s|r",
                            GL:classHexColor(Auction.Winner.class),
                            Auction.Winner.name
                        ),
                    },
                    {
                        value = string.format("|c00FFFFFF%s|r|c00FFF569|r",
                            Auction.price
                        ),
                    },
                },
            });
        end

        Table:SetData(TableData);
    end

    for jar, Sales in pairs(SalesData or {}) do
        if (self.SalesTables[jar]) then
            setTableData(self.SalesTables[jar], Sales);
        end
    end
end
