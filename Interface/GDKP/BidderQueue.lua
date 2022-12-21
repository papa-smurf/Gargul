---@type GL
local _, GL = ...;

---@type GDKPAuction
local GDKPAuction = GL.GDKP.Auction;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

---@type Settings
local Settings = GL.Settings;

---@type Interface
local Interface = GL.Interface;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

local AceGUI = GL.AceGUI;
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

GL.Interface.GDKP = GL.Interface.GDKP or {};

---@class GDKPBidderQueueInterface
GL.Interface.GDKP.BidderQueue = {
    isVisible = false,
    QueueBidDetails = {},
};

---@type GDKPBidderQueueInterface
local BidderQueue = GL.Interface.GDKP.BidderQueue;

--[[ CONSTANTS ]]
local HEIGHT_PER_ITEM_ROW = 18;

---@return void
function BidderQueue:open()
    GL:debug("Interface.GDKP.BidderQueue:open");

    local Window = Interface:get(self, "GDKPBidderQueue");

    if (not Window) then
        Window = self:build();
    end

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;
    self:refreshTable();
    Window:Show();
end

---@return void
function BidderQueue:build()
    GL:debug("BidderQueue:build");

    local Window = Interface:get(self, "GDKPBidderQueue");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    Window = AceGUI:Create("Frame");
    Window:SetHeight(140);
    Window:SetWidth(GL.elvUILoaded and 180 or 196);
    ---@todo onclose is not triggered, need alternative
    --Interface:AceGUIDefaults(self, Window, "GDKPOverview", 100, 250);
    Interface:resizeBounds(Window, 220, 140);
    Window:SetTitle("Upcoming auctions");
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar

    local columns = {
        {
            name = "test",
            width = 18,
            DoCellUpdate = GL.LibStItemCellUpdate,
        },
        {
            DoCellUpdate = GL.LibStItemLinkCellUpdate,
            width = 90,
        },
        {
            width = 25,
        },
        {
            width = 0,
        },
    };

    local Table = AceGUI:Create("CLMLibScrollingTable");
    Table:SetDisplayCols(columns);
    Table:SetDisplayRows(10, 18);
    Table:EnableSelection(false);
    Table:RegisterEvents({ ["OnClick"] = function () return true; end }); -- Override the default OnClick
    Table.frame:SetParent(Window.frame);
    Table.frame:SetPoint("CENTER", Window.frame, "CENTER", 0, -6);
    Table.frame:Show();
    Table.st.head:Hide(); -- Remove the table header

    Table:RegisterEvents({
        OnClick = function (rowFrame, cellFrame, data, cols, row, realrow, column, table, button)
            -- Make sure something is actually highlighted, better safe than lua error
            if (not GL:higherThanZero(realrow)
                or type(data) ~= "table"
                or not data[realrow]
                or not data[realrow].cols
                or not data[realrow].cols[4]
                or GL:empty(data[realrow].cols[4].value)
            ) then
                return;
            end

            local queuedItem = data[realrow].cols[4].value;
        end
    });

    Interface:set(self, "Queue", Table);

    -- Remove that pesky close button. We're not releasing the frame anyways!
    GL:fetchCloseButtonFromAceGUIWidget(Window):Hide();

    local originalOnHeightSet = Window.OnHeightSet;
    local onHeightSet = function ()
        Window:SetWidth(GL.elvUILoaded and 180 or 196);
        Table:SetDisplayRows(math.floor(
            Window.frame:GetHeight() / HEIGHT_PER_ITEM_ROW - (GL.elvUILoaded and 2 or 2)
        ), HEIGHT_PER_ITEM_ROW);
    end;
    Window.OnHeightSet = function (...)
        originalOnHeightSet(...);
        onHeightSet();
    end
    onHeightSet();

    return Window;
end

function BidderQueue:refreshTable()
    GL:debug("BidderQueue:refreshTable");

    local Table = Interface:get(self, "Table.Queue");
    if (not Table) then
        return;
    end

    local TableData = {};
    for i = 1, 10 do
        tinsert(TableData, {
            cols = {
                {
                    value = 18608,
                },
                {
                    value = "|cffa335ee|Hitem:18608::::::::70:::::|h[Benediction]|h|r",
                },
                {
                    value = "Bid",
                    OnClick = function ()
                        GL:xd("Bid " .. i);
                    end,
                },
                {
                    value = "135135412313as1d4a4sd45q42r3saxz",
                },
            },
        });
    end

    if (not GL:empty(TableData)) then
        Table:SetData(TableData);
    else
        Table:SetData({}, true);
    end
end

GL:debug("Auctioneer.lua");