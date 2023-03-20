local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type GDKPAuction
local Auction = GL.GDKP.Auction;

---@type Interface
local Interface = GL.Interface;

---@type Settings
local Settings = GL.Settings;

GL.Interface.GDKP = GL.Interface.GDKP or {};

---@class GDKPBidderQueueInterface
GL.Interface.GDKP.BidderQueue = {
    deletedIdentifiers = {},
    windowName = "Gargul.BidderQueue.Window",

    ItemRows = {},
};

---@type GDKPBidderQueueInterface
local BidderQueue = GL.Interface.GDKP.BidderQueue;

--[[ CONSTANTS ]]
local DEFAULT_WINDOW_WIDTH = 150;
local DEFAULT_WINDOW_HEIGHT = 170;
local QUEUE_ROW_HEIGHT = 20;
local FONT;

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

---@return Frame|nil
function BidderQueue:open()
    GL:debug("BidderQueue:open");

    if (not Settings:get("GDKP.enableBidderQueue")) then
        return;
    end

    self.isVisible = true;
    FONT = GL.FONT;

    local Window = _G[self.windowName] or self:build();

    self:refreshTable();
    Window:Show();
    return Window;
end

---@return Frame
function BidderQueue:build()
    GL:debug("BidderQueue:build");

    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    local ItemHolder, ScrollFrame;
    ---@type Frame
    local Window = Interface:createWindow(self.windowName, {
        closeWithEscape = false,
        width = DEFAULT_WINDOW_WIDTH,
        height = DEFAULT_WINDOW_HEIGHT,
        minWidth = 150,
        minHeight = 100,
        maxWidth = 500,
        maxHeight = 700,
    });

    Window:SetScript("OnHide", function ()
        self.isVisible = false;
    end);

    Window:HookScript("OnSizeChanged", function ()
        ItemHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    end);

    --[[ CUSTOM MINIMIZED FRAME ]]
    local top, left;
    local oldOnSizeChanged = Window:GetScript("OnSizeChanged");
    local oldOnDragStop = Window.MoveButton:GetScript("OnDragStop");
    Window.Minimize.MinimizeButton:SetScript("OnClick", function ()
        top, left = Window:GetTop(), Window:GetLeft();
        Window:SetScript("OnSizeChanged", function () end);
        Window.MoveButton:SetScript("OnDragStop", function ()
            Window:StopMovingOrSizing();
            Window.MoveButton:SetButtonState("NORMAL");
            top, left = Window:GetTop(), Window:GetLeft();
        end);
        Window:SetHeight(70);
        Window:ClearAllPoints();
        Window:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top);
        Window.Minimize.MinimizeButton:Hide();
        Window.Minimize.MaximizeButton:Show();
        Window.Resize:Hide();
        Window.OptionsButton:Hide();

        Settings:set("GDKP.minimizeBidderQueue", true);
    end);
    Window.Minimize.MaximizeButton:SetScript("OnClick", function ()
        Window:SetScript("OnSizeChanged", oldOnSizeChanged);
        Window.MoveButton:SetScript("OnDragStop", oldOnDragStop);
        Interface:restoreDimensions(Window);
        Window:ClearAllPoints();
        Window:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", left, top);
        Window.Minimize.MinimizeButton:Show();
        Window.Minimize.MaximizeButton:Hide();
        Window.Resize:Show();
        Window.OptionsButton:Show();

        Settings:set("GDKP.minimizeBidderQueue", false);
    end);

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L.TUTORIAL, notCheckable = true, func = function ()
            GL:popupMessage(L.TUTORIAL_BIDDER_QUEUE);
            CloseMenus();
        end },
        "divider",
        {text = L.GDKP_QUEUE_HIDE_UNUSABLE, setting = "GDKP.bidderQueueHideUnusable", func = function(Entry, _, _, checked)
            Settings:set("GDKP.bidderQueueHideUnusable", checked);
            Entry.checked = checked;
            self:refreshTable();
        end},
        {text = L.GDKP_SHOW_UPCOMING, setting = "GDKP.enableBidderQueue", func = function(Entry, _, _, checked)
            if (not checked) then
                -- Show a confirmation dialog before clearing entries
                GL.Interface.Dialogs.PopupDialog:open({
                    question = L.GDKP_HIDE_UPCOMING_CONFIRMATION,
                    OnYes = function ()
                        Settings:set("GDKP.enableBidderQueue", checked);
                        Entry.checked = checked;
                        self:close();
                    end,
                });

                CloseMenus();
                return;
            end

            Settings:set("GDKP.enableBidderQueue", checked);
            Entry.checked = checked;
        end},
        "divider",
        {text = L.WINDOW, isTitle = true, notCheckable = true },
        { text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    --[[ SCROLLFRAME BOILERPLATE ]]
    ---@type ScrollFrame
    ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOPLEFT", Window, "TOPLEFT", 10, -24);
    ScrollFrame:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -19, 24);

    ---@type Frame
    ItemHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(ItemHolder);
    ItemHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    ItemHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    ItemHolder:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");

    ---@type Frame
    local Items = CreateFrame("Frame", nil, ItemHolder);
    Items:SetAllPoints(ItemHolder);

    ---@type Frame
    local ActionButtons;

    do -- [[ ACTION BUTTONS ]]
        ---@type Frame
        ActionButtons = CreateFrame("Frame", nil, ItemHolder);
        ActionButtons:SetSize(38, 18);
        ActionButtons:Hide();

        --[[ BID BUTTON ]]
        ---@type Button
        ActionButtons.BidButton = CreateFrame("Button", nil, ActionButtons, "UIPanelButtonTemplate");
        ActionButtons.BidButton:SetSize(18, 18);
        ActionButtons.BidButton:SetPoint("TOPLEFT", ActionButtons, "TOPLEFT");

        ---@type Texture
        local NormalTexture = ActionButtons.BidButton:CreateTexture();
        NormalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/bag");
        NormalTexture:SetAllPoints(ActionButtons.BidButton);
        ActionButtons.BidButton:SetNormalTexture(NormalTexture);

        ---@type Texture
        local HighlightTexture = ActionButtons.BidButton:CreateTexture();
        HighlightTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/bag");
        NormalTexture:SetAllPoints(ActionButtons.BidButton);
        ActionButtons.BidButton:SetHighlightTexture(HighlightTexture);

        Interface:addTooltip(ActionButtons.BidButton, L.BID, "TOP");

        --[[ REMOVE BID BUTTON ]]
        ---@type Button
        ActionButtons.RemoveBidButton = CreateFrame("Button", nil, ActionButtons, "UIPanelButtonTemplate");
        ActionButtons.RemoveBidButton:SetSize(18, 18);
        ActionButtons.RemoveBidButton:SetPoint("TOPLEFT", ActionButtons.BidButton, "TOPRIGHT", 2, 0);

        ---@type Texture
        NormalTexture = ActionButtons.RemoveBidButton:CreateTexture();
        NormalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/bag");
        NormalTexture:SetAllPoints(ActionButtons.RemoveBidButton);
        ActionButtons.RemoveBidButton:SetNormalTexture(NormalTexture);

        ---@type Texture
        HighlightTexture = ActionButtons.RemoveBidButton:CreateTexture();
        HighlightTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/bag");
        NormalTexture:SetAllPoints(ActionButtons.RemoveBidButton);
        ActionButtons.RemoveBidButton:SetHighlightTexture(HighlightTexture);

        Interface:addTooltip(ActionButtons.RemoveBidButton, L.REMOVE_BID, "TOP");

        --[[ DELETE BUTTON ]]
        ---@type Button
        ActionButtons.DeleteButton = CreateFrame("Button", nil, ActionButtons, "UIPanelButtonTemplate");
        ActionButtons.DeleteButton:SetSize(18, 18);
        ActionButtons.DeleteButton:SetPoint("TOPLEFT", ActionButtons.BidButton, "TOPRIGHT", 2, 0);

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
    end

    Window.ItemHolder = ItemHolder;
    Window.ActionButtons = ActionButtons;

    if (Settings:get("GDKP.minimizeBidderQueue")) then
        Window.Minimize.MinimizeButton:Click();
    end

    _G[self.windowName] = Window;
    return Window;
end

---@return void
function BidderQueue:refreshTable()
    GL:debug("BidderQueue:refreshTable");

    if (not Settings:get("GDKP.enableBidderQueue")) then
        return;
    end

    for _, Row in pairs(self.ItemRows or {}) do
        Interface:release(Row);
    end

    ---@type Frame
    local Window = _G[self.windowName] or self:build();

    ---@type Frame
    local ItemHolder = Window.ItemHolder;

    ---@type Frame
    local ActionButtons = Window.ActionButtons;

    local SortedQueue = {};
    for _, Queued in pairs(Auction.Queue or {}) do
        if (Queued.identifier and not self.deletedIdentifiers[Queued.identifier]) then
            tinsert(SortedQueue, Queued);
        end
    end

    table.sort(SortedQueue, function (a, b)
        if (a.order and b.order) then
            return a.order < b.order;
        end

        return false;
    end);

    local order = 1;
    for _, Item in pairs(SortedQueue or {}) do
        Item.order = order;
        order = order + 1;
    end

    local itemsAdded = false;
    for _, Item in pairs(SortedQueue or {}) do
        local identifier = Item.identifier;
        GL:onItemLoadDo(GL:getItemIDFromLink(Item.itemLink), function (Details)
            local canUseItem = true;
            GL:canUserUseItem(Details.id, function (canUse)
                canUseItem = canUse;
            end);

            if (not canUseItem and Settings:get("GDKP.bidderQueueHideUnusable")) then
                return;
            end

            local autoBid = tonumber(Auction:getQueuedAutoBid(Details.id));

            ---@type Frame
            local ItemRow = CreateFrame("Frame", nil, ItemHolder);
            ItemRow:SetHeight(QUEUE_ROW_HEIGHT);
            ItemRow._itemLink = Details.itemLink;
            ItemRow._identifier = identifier;

            ItemRow:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 0, ((Item.order - 1) * 20) * -1);
            ItemRow:SetPoint("TOPRIGHT", ItemHolder, "TOPRIGHT", not GL.elvUILoaded and 0 or -4, 0);

            --[[ TOGGLE DELETE ON HOVER ]]
            ItemRow:SetScript("OnEnter", function ()
                ActionButtons:ClearAllPoints();
                ActionButtons:SetPoint("TOPRIGHT", ItemRow, "TOPRIGHT", 0, 0);
                ActionButtons:SetFrameLevel(ItemRow:GetFrameLevel() + 1);

                ActionButtons.BidButton:Hide();
                ActionButtons.RemoveBidButton:Hide();
                ActionButtons.DeleteButton:Show();
                if (autoBid > 0) then
                    ActionButtons.RemoveBidButton:Show();
                    ActionButtons.DeleteButton:Hide();
                else
                    ActionButtons.BidButton:Show();
                end

                ActionButtons:Show();

                -- Bid on this item
                ActionButtons.BidButton:SetScript("OnClick", function ()
                    local QueuedItem = Auction.Queue[ItemRow._identifier];
                    if (not QueuedItem) then
                        return;
                    end

                    GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open({
                        question = string.format("What's your maximum bid for %s? (Minimum %s|c00FFF569g|r)", QueuedItem.itemLink, QueuedItem.minimumBid),
                        OnYes = function (max)
                            Auction:setAutoBid(max, ItemRow._identifier);
                            self:refreshTable();
                        end,
                        focus = true,
                    });
                end);

                -- Remove this items bid
                ActionButtons.RemoveBidButton:SetScript("OnClick", function ()
                    Auction:removeAutoBid(ItemRow._identifier);
                    self:refreshTable();
                end);

                -- Hide this item from our queue
                ActionButtons.DeleteButton:SetScript("OnClick", function ()
                    ActionButtons:SetParent(ItemHolder);
                    ActionButtons:Hide();
                    self.deletedIdentifiers[ItemRow._identifier] = true;
                    self:refreshTable();
                end);
            end);

            ItemRow:SetScript("OnLeave", function ()
                if (not Interface:mouseIsOnFrame(ActionButtons)) then
                    ActionButtons:Hide();
                end
            end);

            ItemRow:SetScript("OnMouseUp", function (_, mouseButtonPressed)
                GL:handleItemClick(link, mouseButtonPressed);
            end);

            --[[ ITEM ICON ]]
            ---@type Frame
            local Icon = CreateFrame("Frame",nil, ItemRow);
            Icon:SetPoint("TOPLEFT", ItemRow, 2, -2);
            Icon:SetSize(QUEUE_ROW_HEIGHT - 4, QUEUE_ROW_HEIGHT - 4);

            Interface:addTooltip(Icon, Details.link);

            ---@type Texture
            local Image = Icon:CreateTexture(nil, "BACKGROUND")
            Image:SetAllPoints(Icon);
            Image:SetTexture(Details.icon);

            if (not canUseItem) then
                Image:SetVertexColor(1, 0, 0, 1);
            end

            --[[ ITEM LINK ]]
            ---@type FontString
            local Name = Interface:createFontString(ItemRow, autoBid <= 0 and Details.link or string.format(
                "|c00FFF569%sg|r",
                autoBid
            ));
            Name:SetPoint("CENTER", Icon);
            Name:SetPoint("LEFT", Image, "RIGHT", 2, 0);
            Name:SetPoint("RIGHT", ItemRow, "RIGHT", 4, 0);
            Name:SetHeight(20);

            tinsert(self.ItemRows, ItemRow);
            itemsAdded = true;
        end);
    end

    if (not itemsAdded) then
        self:close();
    end
end

---@return void
function BidderQueue:close()
    GL:debug("BidderQueue:close");

    self.isVisible = false;
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

function BidderQueue:getWindow()
    GL:debug("AuctioneerUI:getWindow");

    return _G[self.windowName];
end

GL:debug("Auctioneer.lua");