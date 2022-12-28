---@type GL
local _, GL = ...;

---@type GDKPAuction
local GDKPAuction = GL.GDKP.Auction;

---@type Interface
local Interface = GL.Interface;

---@type Settings
local Settings = GL.Settings;

local AceGUI = GL.AceGUI;
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

GL.Interface.GDKP = GL.Interface.GDKP or {};

---@class GDKPBidderQueueInterface
GL.Interface.GDKP.BidderQueue = {
    _initialized = false,
    isVisible = false,
    QueueBidDetails = {},
    TableColumns = {
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
            width = 50,
        },
        {
            width = 0,
            sort = GL.Data.Constants.ScrollingTable.ascending,
        },
    },
};

---@type GDKPBidderQueueInterface
local BidderQueue = GL.Interface.GDKP.BidderQueue;

--[[ CONSTANTS ]]
local HEIGHT_PER_ITEM_ROW = 18;

---@return void
function BidderQueue:_init()
    GL:debug("BidderQueue:_init");

    if (self._initialized) then
        return;
    end

    self._initialized = true;

    -- Make sure the queued auction table is updated whenever something changes
    GL.Events:register("GDKPBidderQueueGDKPQueueUpdatedListener", "GL.GDKP_QUEUE_UPDATED", function ()
        BidderQueue:open();
        self:refreshTable();
    end);
end

---@return void
function BidderQueue:open()
    GL:debug("Interface.GDKP.BidderQueue:open");

    if (not Settings:get("GDKP.enableGDKPBidderQueue")) then
        return;
    end

    local Window = Interface:get(self, "Frame.GDKPBidderQueue");

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

    local Window = Interface:get(self, "Frame.GDKPBidderQueue");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    local frameIdentifier = "GDKPBidderQueue";
    local defaultWindowWidth = GL.elvUILoaded and 205 or 221;
    local minimumWindowWidth = 126;
    Window = AceGUI:Create("Frame", frameIdentifier);
    Interface:restorePosition(Window, frameIdentifier);
    Interface:restoreDimensions(Window, frameIdentifier, defaultWindowWidth, 140);
    Interface:resizeBounds(Window, minimumWindowWidth, 140);
    Window.frame:SetScale(GL.Settings:get("GDKP.bidderQueueScale", 1));

    Window:SetTitle("Upcoming items");
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Interface:set(self, "GDKPBidderQueue", Window);

    local Table = AceGUI:Create("CLMLibScrollingTable");
    Table:SetDisplayCols(self.TableColumns);
    Table:SetDisplayRows(10, 18);
    Table:EnableSelection(false);
    Table:RegisterEvents({ ["OnClick"] = function () return true; end }); -- Override the default OnClick
    Table.frame:SetParent(Window.frame);
    Table.frame:SetPoint("CENTER", Window.frame, "CENTER", 0, GL.elvUILoaded and 2 or -6);
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

            local currentValue = data[realrow].cols[3].value;
            local checksum = data[realrow].cols[4].value;

            if (currentValue == "Bid") then
                if (not GDKPAuction.Queue[checksum]) then
                    return;
                end

                local QueuedItem = GDKPAuction.Queue[checksum];
                GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open({
                    question = string.format("What's your maximum bid for %s? (Minimum %s|c00FFF569g|r)", QueuedItem.itemLink, QueuedItem.minimumBid),
                    OnYes = function (max)
                        GDKPAuction:setAutoBid(max, checksum);
                        self:refreshTable();
                    end,
                    focus = true,
                });
            else
                GDKPAuction:removeAutoBid(checksum);
                self:refreshTable();
            end
        end
    });

    Interface:set(self, "Queue", Table);

    -- Remove that pesky close button. We're not releasing the frame anyways
    -- so it shouldn't affect any other frames generated afterwards (fingers crossed)
    GL:fetchCloseButtonFromAceGUIWidget(Window):Hide();

    -- Adjust the number of table rows shown when resizing the window and store the end-result
    local originalOnHeightSet = Window.OnHeightSet;
    local onHeightSet = function ()
        Window:SetWidth(math.max(minimumWindowWidth, Window.frame:GetWidth()));
        Table:SetDisplayRows(math.floor(
                Window.frame:GetHeight() / HEIGHT_PER_ITEM_ROW - (GL.elvUILoaded and 2 or 3)
        ), HEIGHT_PER_ITEM_ROW);

        local itemLinkWidth = 90 + (Window.frame:GetWidth() - defaultWindowWidth);
        self.TableColumns[2].width = itemLinkWidth;
        Table:SetDisplayCols(self.TableColumns);

        Interface:storePosition(Window, frameIdentifier);
        Interface:storeDimensions(Window, frameIdentifier);
    end;
    Window.OnHeightSet = function (...)
        originalOnHeightSet(...);
        onHeightSet();
    end
    onHeightSet();

    -- Store the frame's position after moving it around
    local originalStopMovingOrSizing = Window.frame.StopMovingOrSizing;
    Window.frame.StopMovingOrSizing = function (...)
        originalStopMovingOrSizing(...);

        Interface:storePosition(Window, frameIdentifier);
    end;

    return Window;
end

function BidderQueue:refreshTable()
    GL:debug("BidderQueue:refreshTable");

    local Table = Interface:get(self, "Table.Queue");
    if (not Table) then
        return;
    end

    Table:SetData({}, true);

    local TableData = {};
    local queuedItems = 0;
    for checksum, QueuedItem in pairs(GDKPAuction.Queue or {}) do
        local autoBid = tonumber(GDKPAuction:getQueuedAutoBid(QueuedItem.itemID)) or 0;
        local text = "Bid";
        if (autoBid > 0) then
            text = autoBid .. "|c00FFF569g|r";
        end

        tinsert(TableData, {
            cols = {
                {
                    value = QueuedItem.itemID,
                },
                {
                    value = QueuedItem.itemLink,
                },
                {
                    value = text,
                },
                {
                    value = checksum,
                },
            },
        });

        queuedItems = queuedItems + 1;
    end

    if (queuedItems > 0) then
        Table:SetData(TableData);
        self:open();
    else
        self:close();
    end
end

---@return void
function BidderQueue:close()
    GL:debug("BidderQueue:close");

    self.isVisible = false;

    local BidderQueueWindow = Interface:get(self, "Frame.GDKPBidderQueue");
    if (BidderQueueWindow) then
        BidderQueueWindow.frame:Hide();
    end
end

GL:debug("Auctioneer.lua");