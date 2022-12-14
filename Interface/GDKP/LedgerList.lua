---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

---@class GDKPLedgerList
GL.Interface.GDKP.LedgerList = {
    isVisible = false,
    sessionID = nil,
};

---@type GDKPLedgerList
local LedgerList = GL.Interface.GDKP.LedgerList;

--[[ CONSTANTS ]]
local SESSION_ROWS = 22;
local HEIGHT_PER_SESSION_ROW = 16;

---@param sessionID string
---@return void
function LedgerList:toggle(sessionID)
    GL:debug("GDKP.LedgerList:toggle");

    if (self.sessionID == sessionID) then
        return self:close();
    end

    self:open(sessionID);
end

---@return void
function LedgerList:open(sessionID)
    GL:debug("Interface.GDKP.LedgerList:open");

    local Window = Interface:get(self, "GDKPLedgerList");

    if (not Window) then
        Window = self:build();
    end

    if (self.isVisible) then
        self.sessionID = sessionID;
        self:refresh();

        return;
    end

    self.sessionID = sessionID;
    self.isVisible = true;

    self:refresh();
    Window:Show();
end

--- Build the GDKP export. We only do this once and reuse it when reopened
---
---@return void
function LedgerList:build()
    GL:debug("LedgerList:build");

    ---@type AceGUIFrame
    local Window = Interface:get(self, "GDKPLedgerList");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    Window = AceGUI:Create("Frame");
    Window.frame:SetFrameStrata("FULLSCREEN_DIALOG");
    Interface:AceGUIDefaults(self, Window, "GDKPLedgerList", 440, 700);

    local originalOnHeightSet = Window.OnHeightSet;
    Window.OnHeightSet = function (...)
        originalOnHeightSet(...);

        Window:SetWidth(440);
        Interface:get(self, "Table.Auctions"):SetDisplayRows(math.floor(Window.frame:GetHeight() / HEIGHT_PER_SESSION_ROW - 6), HEIGHT_PER_SESSION_ROW);
    end

    local columns = {
        {
            width = HEIGHT_PER_SESSION_ROW,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1
            },
            colorargs = nil,
            DoCellUpdate = GL.LibStItemCellUpdate,
        },
        {
            width = 200,
            colorargs = nil,
        },
        {
            width = 160,
            align = "RIGHT",
        },
    };

    local Table = AceGUI:Create("CLMLibScrollingTable");
    Table:SetDisplayCols(columns);
    Table:SetDisplayRows(SESSION_ROWS, HEIGHT_PER_SESSION_ROW);
    Table:EnableSelection(false);
    Interface:set(self, "Auctions", Table);

    Window:AddChild(Table);

    return Window;
end

---@return void
function LedgerList:close()
    GL:debug("LedgerList:close");

    self.isVisible = false;
    self.sessionID = nil;
    Interface:get(self, "Table.Auctions"):SetData({}, true);

    local Window = Interface:get(self, "GDKPLedgerList");

    if (Window and Window.frame) then
        Window.frame:Hide();
    end
end

function LedgerList:refresh()
    GL:debug("LedgerList:refresh");

    local Session = GDKPSession:byID(self.sessionID);

    if (type(Session) ~= "table") then
        return;
    end

    -- We can't work with this session since there are no auction attached
    if (type(Session.Auctions) ~= "table") then
        return;
    end

    local totalPot = GDKPPot:total(self.sessionID);
    local managementCutPercentage = tonumber(Session.managementCut) or 0;
    local managementCut = math.floor(totalPot * (0 + managementCutPercentage / 100));
    Interface:get(self, "GDKPLedgerList"):SetStatusText(string.format(
        "To distribute: %sg",
        math.floor(totalPot - managementCut)
    ));

    local Auctions = {};
    for _, Auction in pairs(Session.Auctions) do
        if (type(Auction) == "table"
            and type(Auction.Winner) == "table"
            and type(Auction.itemID) == "number"
        ) then
            if (Auction.itemID == GL.Data.Constants.GDKP.potIncreaseItemID) then
                Auction.itemLink = "Gold added to pot by";
            end

            tinsert(Auctions, Auction);
        end
    end

    local TableData = {};
    local Table = Interface:get(self, "Table.Auctions");
    GL:onItemLoadDo(GL:tableColumn(Auctions, "itemID") or {}, function (Result)
        for _, Auction in pairs(Auctions) do
            (function ()
                tinsert(TableData, {
                    cols = {
                        {
                            value = Auction.itemID,
                        },
                        {
                            value = Auction.itemLink,
                        },
                        {
                            value = string.format("|c00%s%s|r (|c00FFFFFF%s|r|c00FFF569g|r)",
                                GL:classHexColor(Auction.Winner.class),
                                Auction.Winner.name,
                                Auction.price
                            ),
                        },
                    },
                });
            end)()
        end

        Table:SetData(TableData);
    end);
end

GL:debug("Interfaces/GDKP/LedgerList.lua");