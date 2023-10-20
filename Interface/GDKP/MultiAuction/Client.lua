local L = Gargul_L;
local LCG = LibStub("LibCustomGlowGargul-1.0");

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type Constants
local Constants = GL.Data.Constants;

---@type GDKPMultiAuctionAuctioneer
local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;

---@type GDKPMultiAuctionClient
local Client = GL.GDKP.MultiAuction.Client;

---@class GDKPMultiAuctionClientInterface
GL:tableSet(GL, "Interface.GDKP.MultiAuction.Client", {
    adminWindowName = "Gargul.Interface.GDKP.MultiAuction.Client.AdminWindow",
    auctionAdminWindowName = "Gargul.Interface.GDKP.MultiAuction.Client.AuctionAdminWindow",
    windowName = "Gargul.Interface.GDKP.MultiAuction.Client.Window",

    showFavorites = false,
    showUnusable = true,

    AuctionHolder = nil,
    AuctionRows = {},
    Search = nil;
});

---@type GDKPMultiAuctionClientInterface
local ClientInterface = GL.Interface.GDKP.MultiAuction.Client;

--[[ CONSTANTS ]]
local ITEM_ROW_HEIGHT = 30;
local WINDOW_WIDTH = 575;
local WINDOW_HEIGHT = 355;
local FONT;

---@return Frame|nil
function ClientInterface:open()
    FONT = GL.FONT;

    local Window = self:getWindow() or self:build();

    self:resetAdminWindow();
    self:refreshIdentity();
    return Window:Show() and Window;
end

---@return void
function ClientInterface:close()
    local Window = self:getWindow() or self:build();

    Window:Hide();
end

---@return boolean
function ClientInterface:isShown()
    local Window = self:getWindow();

    return Window and Window:IsShown();
end

---@return void
function ClientInterface:addAuction(auctionID, isBOE, itemLevel, name, quality, link, minimum, increment, endsAt, CurrentBid)
    if (isBOE ~= nil or type(auctionID) ~= "table") then
        GL:error("Pass a table instead of multiple arguments")
        return;
    end

    -- The multi-auction client window is not currently shown
    if (not self:isShown()) then
        return;
    end

    local Window = self:getWindow();

    endsAt = auctionID.endsAt;
    increment = math.floor(tonumber(auctionID.increment) or 0);
    isBOE = auctionID.isBOE;
    itemLevel = auctionID.itemLevel;
    link = auctionID.link;
    minimum = math.floor(tonumber(auctionID.minimum) or 0);
    name = auctionID.name;
    quality = auctionID.quality;
    auctionID = auctionID.auctionID;

    if (minimum < 1) then
        return;
    end

    if (increment < 1) then
        return;
    end

    GL:onItemLoadDo(link, function (Item)
        local Details = {
            auctionID = auctionID,
            endsAt = endsAt,
            increment = increment,
            isBOE = GL:inTable({LE_ITEM_BIND_ON_ACQUIRE, LE_ITEM_BIND_QUEST}, Item.bindType),
            itemLevel = Item.level,
            link = Item.link,
            minimum = minimum,
            name = Item.name,
            quality = Item.quality,
            CurrentBid = CurrentBid,
        };

        Window:addAuction(Details);
    end);
end

---@return Frame
function ClientInterface:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = WINDOW_WIDTH,
        minWidth = WINDOW_WIDTH,
        height = WINDOW_HEIGHT,
        minHeight = WINDOW_HEIGHT,
        hideMinimizeButton = true,
        OnClose = function ()
            local unfinishedBusiness = false;

            for _, Details in pairs(Client.AuctionDetails.Auctions or {}) do
                if (Details.endsAt > 0) then
                    unfinishedBusiness = true;
                    break;
                end
            end

            if (not unfinishedBusiness) then
                return;
            end

            GL:notice("Bidding window closed, use |c00a79eff/gl bid|r to reopen it!")
        end,
    };

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    ---@type Frame
    local AuctionHolder

    ---@type ScrollFrame
    local ScrollFrame;

    --[[ SEARCH ]]
    ---@type EditBox
    local Search = Interface:inputBox(Window, nil, "Search name or iLVL");
    Search:SetWidth(150);
    Search:SetPoint("TOPLEFT", Window, "TOPLEFT", 28, -24);
    Search:SetPoint("TOPLEFT", Window, "TOPLEFT", 28, -24);
    self.Search = Search;
    Interface:addTooltip(Search, "Supports item names and iLVL e.g. \"252\", \"<252\" etc", "TOP");

    Search:SetScript("OnTextChanged", function ()
        GL:after(.5, "GDKP_MULTI_AUCTION_CLIENT_FILTER_CHANGED", function ()
            self:filterAndSort();
        end);
    end);

    ---@type Button
    local SearchClear = CreateFrame("Button", nil, Window, "UIPanelCloseButton");
    SearchClear:SetPoint("TOPLEFT", Search, "TOPRIGHT", -1, 2);
    SearchClear:SetSize(26, 26);
    SearchClear:SetScript("OnClick", function ()
        Search:Clear();
    end);
    Interface:addTooltip(SearchClear, L.CLEAR, "TOP");

    --[[ SHOW/HIDE FAVORITES ]]
    ---@type Button
    local ToggleFavorites = Interface:dynamicPanelButton(Window, "Show favorites");
    ToggleFavorites:SetPoint("TOPLEFT", SearchClear, "TOPRIGHT", 6, -2);
    ToggleFavorites:SetScript("OnClick", function ()
        self.showFavorites = not self.showFavorites;
        ToggleFavorites:SetText(self.showFavorites and "Show all" or "Show favorites");
        self:filterAndSort();
    end);

    --[[ SHOW/HIDE UNUSABLE ]]
    ---@type Button
    local ToggleUnusable = Interface:dynamicPanelButton(Window, "Hide Unusable");
    ToggleUnusable:SetPoint("TOPLEFT", ToggleFavorites, "TOPRIGHT", 6, 0);
    ToggleUnusable:SetScript("OnClick", function ()
        self.showUnusable = not self.showUnusable;
        ToggleUnusable:SetText(self.showUnusable and "Hide unusable" or "Show unusable");
        self:filterAndSort();
    end);

    --[[ SCROLLFRAME BOILERPLATE ]]
    ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOP", Search, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("BOTTOM", Window, "BOTTOM", 0, 40);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 16);
    ScrollFrame:SetPoint("RIGHT", Window, "RIGHT", -44, 0);

    AuctionHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(AuctionHolder);
    AuctionHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    AuctionHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    AuctionHolder:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");
    self.AuctionHolder = AuctionHolder;

    ---@type Frame
    local Auctions = CreateFrame("Frame", nil, AuctionHolder);
    Auctions:SetAllPoints(AuctionHolder);

    --[[ BID DETAILS ]]
    local BidDetails = Interface:createFontString(Window, "");
    BidDetails:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -30, 20);
    self.BidDetails = BidDetails;

    --[[ MAIN ADMIN WINDOW (FOOTER) ]]
    do
        ---@type Frame
        local AdminWindow = Interface:createWindow{
            name = self.adminWindowName,
            height = 60,
            hideAllButtons = true,
            hideWatermark = true,
            Parent = Window,
        };
        AdminWindow:SetPoint("TOPLEFT", Window, "BOTTOMLEFT", 0, 4);
        AdminWindow:SetPoint("RIGHT", Window, "RIGHT");
        AdminWindow:Hide();
        Window.AdminWindow = AdminWindow;

        local ButtonContainer = CreateFrame("Frame", nil, AdminWindow);
        ButtonContainer:SetPoint("CENTER", AdminWindow, "CENTER");
        ButtonContainer:SetPoint("BOTTOM", AdminWindow, "BOTTOM", 0, 20);
        ButtonContainer:SetWidth(5000);
        AdminWindow.ButtonContainer = ButtonContainer;

        ---@type Button
        local CloseAllButton = Interface:dynamicPanelButton(ButtonContainer);
        CloseAllButton:SetPoint("BOTTOMLEFT", ButtonContainer, "BOTTOMLEFT");
        CloseAllButton:SetText("Close all");
        CloseAllButton:SetScript("OnClick", function ()
            GL.Interface.Dialogs.PopupDialog:open{
                question = "Close ALL actions?",
                OnYes = function ()
                    for auctionID in pairs(Client.AuctionDetails.Auctions or {}) do
                        Auctioneer:closeAuction(auctionID);
                    end
                end,
            };
        end);
        Interface:addTooltip(CloseAllButton, {
            "Close ALL auctions",
            " ",
            "Auctions with active bids on them will be sold and can not receive new bids!",
        }, "TOP");

        ---@type Button
        local FinalCallButton = Interface:dynamicPanelButton(ButtonContainer);
        FinalCallButton:SetPoint("TOPLEFT", CloseAllButton, "TOPRIGHT", 4, 0);
        FinalCallButton:SetText("Final call");
        FinalCallButton:SetScript("OnClick", function ()
            GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open{
                question = "Give a final call timer of how many seconds?",
                inputValue = GL.Settings:get("GDKP.finalCallTime"),
                OnYes = function (seconds)
                    seconds = floor(tonumber(strtrim(seconds)) or 0);
                    if (seconds < 5) then
                        return GL:error("The minimum amount of seconds is 5");
                    end

                    GL.Settings:set("GDKP.finalCallTime", seconds);

                    for auctionID in pairs(Client.AuctionDetails.Auctions or {}) do
                        Auctioneer:finalCall(auctionID, seconds);
                    end
                end,
                focus = true,
            };
        end);
        Interface:addTooltip(FinalCallButton, {
            "Final call on ALL auctions",
            " ",
            "Start a final call on all auctions that haven't sold yet!",
        }, "TOP");

        ---@type Button
        local FinishButton = Interface:dynamicPanelButton(ButtonContainer);
        FinishButton:SetPoint("TOPLEFT", FinalCallButton, "TOPRIGHT", 4, 0);
        FinishButton:SetText("Finish");
        FinishButton:SetScript("OnClick", function ()
            local unfinishedBusiness = false;

            for _, Details in pairs(Client.AuctionDetails.Auctions or {}) do
                if (Details.endsAt > 0) then
                    unfinishedBusiness = true;
                    break;
                end
            end

            -- Looks like all auctions were finalized, no need to ask anything
            if (not unfinishedBusiness) then
                Auctioneer:finish();
                self:close();
                return;
            end

            GL.Interface.Dialogs.PopupDialog:open{
                question = "Close ALL auctions and wrap up this multi-auction session?",
                OnYes = function ()
                    Auctioneer:finish();
                    self:close();
                end,
            };
        end);
        Interface:addTooltip(FinishButton, {
            "Finish Multi-Auction session",
            " ",
            "This will close all auctions and announce the total pot in chat",
            "Auctions with active bids on them will be sold and can not receive new bids!",
        }, "TOP");

        ---@type Button
        local TerminateButton = Interface:dynamicPanelButton(ButtonContainer);
        TerminateButton:SetPoint("TOPLEFT", FinishButton, "TOPRIGHT", 4, 0);
        TerminateButton:SetText("Terminate");
        TerminateButton:SetScript("OnClick", function ()
            GL.Interface.Dialogs.PopupDialog:open{
                question = "Remove all bids and close all auctions?",
                OnYes = function ()
                    Auctioneer:terminate();
                end,
            };
        end);
        Interface:addTooltip(TerminateButton, {
            "Terminate Multi-Auction session",
            " ",
            "This will delete all bids on items that haven't sold yet and close all auctions!",
        }, "TOP");

        -- Shadow frame used to determine the required width of the ButtonContainer
        local ShadowFrame = CreateFrame("Frame", nil, AdminWindow);
        ShadowFrame:SetPoint("TOPLEFT", CloseAllButton, "TOPLEFT");
        ShadowFrame:SetPoint("TOPRIGHT", TerminateButton, "TOPRIGHT");
        ShadowFrame:SetHeight(1);

        ButtonContainer:SetWidth(ShadowFrame:GetWidth());
        Interface:release(ShadowFrame);
    end

    --[[ AUCTION ADMIN WINDOW ]]
    do
        ---@type Frame
        local AuctionAdminWindow = Interface:createWindow{
            name = self.auctionAdminWindowName,
            width = 300,
            height = 90,
            hideMinimizeButton = true,
            hideResizeButton = true,
            hideMoveButton = true,
            hideWatermark = true,
            Parent = Window,
        };
        AuctionAdminWindow:SetPoint("TOPLEFT", Window, "TOPRIGHT", 10, 0);
        AuctionAdminWindow:Hide();

        local AdminExplanation = Interface:createFontString(AuctionAdminWindow, "Click the 'Admin' button or an auction to manage it");
        AdminExplanation:SetPoint("CENTER", AuctionAdminWindow, "CENTER");
        AdminExplanation:SetPoint("TOP", AuctionAdminWindow, "TOP", 0, -30);
        AdminExplanation:SetFont(.8, "OUTLINE");
        AdminExplanation:SetColor("GRAY");
        AuctionAdminWindow.Explanation = AdminExplanation;

        local AdminWindowItemLink = Interface:createFontString(AuctionAdminWindow, "");
        AdminWindowItemLink:SetPoint("CENTER", AuctionAdminWindow, "CENTER");
        AdminWindowItemLink:SetPoint("TOP", AuctionAdminWindow, "TOP", 0, -20);
        AdminWindowItemLink:SetColor("GRAY");
        AuctionAdminWindow.AdminWindowItemLink = AdminWindowItemLink;

        local AdminButtonExplanation = Interface:createFontString(AuctionAdminWindow, "Hover over any of the buttons below for more information");
        AdminButtonExplanation:SetPoint("CENTER", AdminWindowItemLink, "CENTER");
        AdminButtonExplanation:SetPoint("TOP", AdminWindowItemLink, "BOTTOM", 0, -7);
        AdminButtonExplanation:SetFont(.8, "OUTLINE");
        AdminButtonExplanation:SetColor("GRAY");
        AuctionAdminWindow.AdminButtonExplanation = AdminButtonExplanation;

        local AdminAuctionClosedExplanation = Interface:createFontString(AuctionAdminWindow, ("This item was sold. Use ledger (|c00%s/gdkp|r) to make changes!"):format(Interface.Colors.PURPLE));
        AdminAuctionClosedExplanation:SetPoint("CENTER", AdminWindowItemLink, "CENTER");
        AdminAuctionClosedExplanation:SetPoint("TOP", AdminWindowItemLink, "BOTTOM", 0, -7);
        AdminAuctionClosedExplanation:SetFont(.8, "OUTLINE");
        AdminAuctionClosedExplanation:SetColor("GRAY");
        AuctionAdminWindow.AdminAuctionClosedExplanation = AdminAuctionClosedExplanation;

        local AdminOpenLedgerButton = Interface:dynamicPanelButton(AuctionAdminWindow, "Ledger");
        AdminOpenLedgerButton:SetScale(.8);
        AdminOpenLedgerButton:SetPoint("CENTER", AuctionAdminWindow, "CENTER");
        AdminOpenLedgerButton:SetPoint("BOTTOM", AuctionAdminWindow, "BOTTOM", 0, 25);
        AuctionAdminWindow.AdminOpenLedgerButton = AdminOpenLedgerButton;

        AdminOpenLedgerButton:SetScript("OnClick", function ()
            Interface.GDKP.Overview:open();
        end);

        local ButtonContainer = CreateFrame("Frame", nil, AuctionAdminWindow);
        ButtonContainer:SetPoint("CENTER", AuctionAdminWindow, "CENTER");
        ButtonContainer:SetPoint("BOTTOM", AuctionAdminWindow, "BOTTOM", 0, 20);
        ButtonContainer:SetWidth(5000);
        AuctionAdminWindow.ButtonContainer = ButtonContainer;

        ---@type Button
        local CloseButton = Interface:dynamicPanelButton(ButtonContainer);
        CloseButton:SetScale(.8);
        CloseButton:SetPoint("BOTTOMLEFT", ButtonContainer, "BOTTOMLEFT");
        CloseButton:SetText("Close Auction");
        CloseButton:SetScript("OnClick", function ()
            if (not AuctionAdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            Auctioneer:closeAuction(AuctionAdminWindow._auctionID);
        end);
        Interface:addTooltip(CloseButton, "Close the auction. Players can no longer bid but the highest bid remains active", "TOP");

        ---@type Button
        local FinallCallButton = Interface:dynamicPanelButton(ButtonContainer);
        FinallCallButton:SetScale(.8);
        FinallCallButton:SetPoint("TOPLEFT", CloseButton, "TOPRIGHT", 2, 0);
        FinallCallButton:SetText("Final call");
        FinallCallButton:SetScript("OnClick", function ()
            if (not AuctionAdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open{
                question = "Give a final call timer of how many seconds?",
                inputValue = GL.Settings:get("GDKP.finalCallTime"),
                OnYes = function (seconds)
                    seconds = floor(tonumber(strtrim(seconds)) or 0);
                    if (seconds < 5) then
                        return GL:error("The minimum amount of seconds is 5");
                    end

                    GL.Settings:set("GDKP.finalCallTime", seconds);
                    Auctioneer:finalCall(AuctionAdminWindow._auctionID, seconds);
                end,
                focus = true,
            };
        end);
        Interface:addTooltip(FinallCallButton, "Start a final call for this auction by giving a (usually shorter) bid timer", "TOP");

        ---@type Button
        local ClearButton = Interface:dynamicPanelButton(ButtonContainer);
        ClearButton:SetScale(.8);
        ClearButton:SetPoint("TOPLEFT", FinallCallButton, "TOPRIGHT", 2, 0);
        ClearButton:SetText("Clear bids");
        ClearButton:SetScript("OnClick", function ()
            if (not AuctionAdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            GL.Interface.Dialogs.PopupDialog:open{
                question = "Are you sure?",
                OnYes = function ()
                    Auctioneer:clearBid(AuctionAdminWindow._auctionID);
                end,
            };
        end);
        Interface:addTooltip(ClearButton, "Remove all bids from the auction", "TOP");

        ---@type Button
        local DeleteButton = Interface:dynamicPanelButton(ButtonContainer);
        DeleteButton:SetScale(.8);
        DeleteButton:SetPoint("TOPLEFT", ClearButton, "TOPRIGHT", 2, 0);
        DeleteButton:SetText("Delete");
        DeleteButton:SetScript("OnClick", function ()
            if (not AuctionAdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            GL.Interface.Dialogs.PopupDialog:open{
                question = "Are you sure?",
                OnYes = function ()
                    Auctioneer:deleteAuction(AuctionAdminWindow._auctionID);
                    self:resetAdminWindow();
                end,
            };
        end);
        Interface:addTooltip(DeleteButton, "Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!", "TOP");

        -- Shadow frame used to determine the required width of the ButtonContainer
        local ShadowFrame = CreateFrame("Frame", nil, AuctionAdminWindow);
        ShadowFrame:SetPoint("TOPLEFT", CloseButton, "TOPLEFT");
        ShadowFrame:SetPoint("TOPRIGHT", DeleteButton, "TOPRIGHT");
        ShadowFrame:SetHeight(1);

        ButtonContainer:SetWidth(ShadowFrame:GetWidth());
        Interface:release(ShadowFrame);

        Window.AuctionAdminWindow = AuctionAdminWindow;
    end

    --[[ ADD AN AUCTION TO WINDOW ]]
    Window.addAuction = function (_, Details)
        local link = Details.link;
        local quality = Details.quality;
        local name = Details.name;
        local itemLevel = Details.itemLevel;
        local isBOE = Details.isBOE;
        local minimum = Details.minimum;
        local increment = Details.increment;
        local CurrentBid = Details.CurrentBid;
        local auctionID = Details.auctionID;
        local time = Details.endsAt - GetServerTime();

        GL:onItemLoadDo(GL:getItemIDFromLink(link), function (Item)
            if (not Item) then
                return;
            end

            local canUseItem = true;
            GL:canUserUseItem(Item.id, function (canUse)
                canUseItem = canUse;
                Details.canUseItem = canUseItem;
            end);

            ---@type Frame
            local AuctionRow = CreateFrame("Frame", nil, AuctionHolder);
            AuctionRow:SetPoint("TOPLEFT", Window, "TOPLEFT", 0, 0);
            AuctionRow:SetPoint("TOPRIGHT", Window, "TOPLEFT", 0, 0);
            AuctionRow:EnableMouse(true);
            AuctionRow:SetHeight(0);
            AuctionRow:SetAlpha(0);

            AuctionRow:EnableMouse(true);
            AuctionRow:SetScript("OnMouseUp", function ()
                self:showAuctionAdminWindow(AuctionRow);
            end);

            AuctionRow._Details = Details;

            --[[ FAVORITE ]]
            ---@type Frame
            local Favorite = CreateFrame("Frame",nil, AuctionRow);
            Favorite:SetPoint("TOP", AuctionRow, "TOP", 0, (ITEM_ROW_HEIGHT - ITEM_ROW_HEIGHT * .8) / -2);
            Favorite:SetPoint("LEFT", Window, "LEFT", ITEM_ROW_HEIGHT / 2, 0);
            Favorite:SetSize(ITEM_ROW_HEIGHT * .8, ITEM_ROW_HEIGHT * .8);
            Interface:addTooltip(Favorite, "Favorite this item", "TOP");

            ---@type Texture
            local FavoriteImage = Favorite:CreateTexture(nil, "BACKGROUND")
            FavoriteImage:SetAllPoints(Favorite);
            FavoriteImage:SetTexture("Interface/common/friendship-heart");
            FavoriteImage:SetVertexColor(.9, .9, .9, .25);

            AuctionRow.toggleFavorite = function ()
                AuctionRow._Details.isFavorite = not AuctionRow._Details.isFavorite;

                if (AuctionRow._Details.isFavorite) then
                    FavoriteImage:SetVertexColor(1, 1, 1, 1);
                else
                    FavoriteImage:SetVertexColor(.9, .9, .9, .25);
                end
            end
            Favorite:SetScript("OnMouseUp", function ()
                AuctionRow.toggleFavorite();
            end);

            --[[ ITEM ICON ]]
            ---@type Frame
            local Icon = CreateFrame("Frame",nil, AuctionRow);
            Icon:SetPoint("TOP", AuctionRow, "TOP");
            Icon:SetPoint("LEFT", Favorite, "RIGHT", 2, 0);
            Icon:SetSize(ITEM_ROW_HEIGHT, ITEM_ROW_HEIGHT);
            Interface:addTooltip(Icon, Item.link, "RIGHT");
            AuctionRow.Icon = Icon;

            ---@type Texture
            local IconImage = Icon:CreateTexture(nil, "BACKGROUND")
            IconImage:SetAllPoints(Icon);
            IconImage:SetTexture(Item.icon);

            if (not canUseItem) then
                IconImage:SetVertexColor(1, 0, 0, 1);
            end

            --[[ ITEM LEVEL ]]
            if (itemLevel) then
                ---@type FontString
                local ItemLevel = Interface:createFontString(Icon, itemLevel);
                ItemLevel:SetPoint("BOTTOMLEFT", Icon, "BOTTOMLEFT", -3, 2);
                ItemLevel:SetFont(.8, "OUTLINE");
                ItemLevel:SetColor("ROGUE");
            end

            --[[ BOE ]]
            if (isBOE) then
                ---@type FontString
                local BOE = Interface:createFontString(Icon, "BOE");
                BOE:SetPoint("TOPLEFT", Icon, "TOPLEFT", -3, -2);
                BOE:SetFont(.8, "OUTLINE");
                BOE:SetColor("UNCOMMON");
            end

            local BidInput, AdminButton;
            if (Auctioneer:auctionStartedByMe()) then
                --[[ ACTION BUTTON ]]
                ---@type Button
                AdminButton = Interface:dynamicPanelButton(AuctionRow);
                AdminButton:SetPoint("CENTER", AuctionRow, "CENTER");
                AdminButton:SetPoint("RIGHT", AuctionRow, "RIGHT");
                AdminButton:SetScale(.8);
                AdminButton:SetText("Admin");
                AdminButton:SetHeight(27);
                AdminButton:SetScript("OnClick", function ()
                    self:showAuctionAdminWindow(AuctionRow);
                end);
            end

            --[[ BID BUTTON ]]
            ---@type Button
            local BidButton = Interface:dynamicPanelButton(AuctionRow);

            if (not AdminButton) then
                BidButton:SetPoint("CENTER", AuctionRow, "CENTER");
                BidButton:SetPoint("RIGHT", AuctionRow, "RIGHT");
            else
                BidButton:SetPoint("RIGHT", AdminButton, "LEFT", -2, 0);
            end

            BidButton:SetScale(.8);
            BidButton:SetText("Bid");
            BidButton:SetHeight(27);
            BidButton:SetScript("OnClick", function ()
                local bid = tonumber(BidInput:GetText()) or 0;

                if (not Client:isBidValidForAuction(auctionID, bid)) then
                    return GL:error(("Invalid bid or bid is too low! The minimum is %sg"):format(Client:minimumBidForAuction(auctionID)));
                end

                BidInput:SetText("");
                GL.GDKP.MultiAuction.Client:bid(auctionID, bid);

                if (not AuctionRow._Details.isFavorite) then
                    AuctionRow.toggleFavorite();
                end
            end);

            --[[ BID INPUT ]]
            ---@type EditBox
            BidInput = Interface:inputBox(AuctionRow);
            BidInput:SetNumeric(true)
            BidInput:SetWidth(56);
            BidInput:SetPoint("CENTER", BidButton, "CENTER");
            BidInput:SetPoint("RIGHT", BidButton, "LEFT", -2, 0);
            AuctionRow.BidInput = BidInput;

            --[[ MINIMUM ]]
            ---@type EditBox
            local MinButton = Interface:dynamicPanelButton(AuctionRow);
            MinButton:SetPoint("CENTER", BidInput, "CENTER");
            MinButton:SetPoint("RIGHT", BidInput, "LEFT", -10, 0);
            MinButton:SetScale(.8);
            MinButton:SetText("Min");
            MinButton:SetHeight(27);
            MinButton:SetScript("OnClick", function ()
                BidInput:SetText(Client:minimumBidForAuction(auctionID));
           end);

            --[[ AUCTION STATUS HOLDER ]]
            local StatusHolder = CreateFrame("Frame", nil, AuctionRow);
            StatusHolder:SetPoint("TOP", AuctionRow, "TOP");
            StatusHolder:SetPoint("BOTTOM", AuctionRow, "BOTTOM");
            StatusHolder:SetPoint("RIGHT", MinButton, "LEFT", -4, 0);
            StatusHolder:SetWidth(100);

            ---@type FontString
            local StatusText = Interface:createFontString(AuctionRow, "");
            StatusText:SetAllPoints(StatusHolder);
            StatusText:SetFont(.9);
            StatusText:SetWidth(100);
            AuctionRow.StatusText = StatusText;

            AuctionRow.updateStatus = function()
                local AuctionDetails = Client.AuctionDetails.Auctions[Details.auctionID];
                local hasBid = AuctionDetails.CurrentBid and AuctionDetails.CurrentBid.amount;
                local statusText;

                if (AuctionDetails.endsAt == 0) then
                    if (hasBid) then
                        statusText = ("|c00%sSOLD|r to\n%s for |c00%s%sg|r"):format(
                            Interface.Colors.SUCCESS,
                            GL:disambiguateName(AuctionDetails.CurrentBid.player, { colorize = true, }),
                            Interface.Colors.YELLOW,
                            AuctionDetails.CurrentBid.amount
                        );
                    else
                        statusText = ("|c00%sCLOSED\nNo bids|r"):format(Interface.Colors.GRAY);
                    end
                elseif (hasBid) then
                    local bidByMe = GL:iEquals(AuctionDetails.CurrentBid.player, GL.User.fqn);

                    if (bidByMe) then
                        statusText = ("Bid |c00%s%sg|r\nBy |c0092FF00YOU!|r"):format(
                            Interface.Colors.YELLOW,
                            AuctionDetails.CurrentBid.amount
                        );
                    else
                        statusText = ("Bid |c00%s%sg|r\nBy %s"):format(
                            Interface.Colors.YELLOW,
                            AuctionDetails.CurrentBid.amount,
                            GL:disambiguateName(AuctionDetails.CurrentBid.player, { colorize = true, })
                        );
                    end
                else
                    statusText = ("Minimum is |c00%s%sg|r"):format(Interface.Colors.YELLOW, minimum);
                end

                AuctionRow.StatusText:SetText(statusText);
            end

            ---@type FontString
            local Name = Interface:createFontString(AuctionRow, Item.link);
            Name:SetPoint("CENTER", Icon);
            Name:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
            Name:SetPoint("RIGHT", MinButton, "LEFT", -6, 0);
            Name:SetHeight(ITEM_ROW_HEIGHT);

            AuctionRow.addCountDownBar = function (time)
                local CountDownBar = LibStub("LibCandyBarGargul-3.0"):New(
                    "Interface\\AddOns\\Gargul\\Assets\\Textures\\timer-bar",
                    AuctionRow:GetWidth(),
                    ITEM_ROW_HEIGHT
                );
                CountDownBar:SetParent(AuctionRow);
                CountDownBar:SetPoint("TOP", AuctionRow, "TOP");
                CountDownBar:SetPoint("RIGHT", AuctionRow, "RIGHT");
                CountDownBar:SetPoint("BOTTOM", AuctionRow, "BOTTOM");
                CountDownBar:SetPoint("LEFT", Icon, "LEFT");
                CountDownBar:SetDuration(time);
                CountDownBar:SetColor(0, 1, 0, .3); -- Reset color to green
                CountDownBar:Set("type", "GDKP_MULTI_AUCTION_COUNTDOWN");
                CountDownBar:Start();
                CountDownBar:SetFrameStrata(AuctionRow:GetFrameStrata());
                CountDownBar:SetFrameLevel(AuctionRow:GetFrameLevel() - 1);
                CountDownBar:SetTimeVisibility(false);
                AuctionRow.CountDownBar = CountDownBar;

                -- Make the bar turn green/yellow/red based on time left
                CountDownBar:AddUpdateFunction(function (Bar)
                    local percentageLeft = 100 / (time / Bar.remaining);

                    if (percentageLeft >= 60) then
                        Bar:SetColor(0, 1, 0, .3);
                    elseif (percentageLeft >= 30) then
                        Bar:SetColor(1, 1, 0, .3);
                    else
                        Bar:SetColor(1, 0, 0, .3);
                    end
                end);
            end

            AuctionRow.stopCountdown = function()
                local CountDownBar = AuctionRow.CountDownBar;
                if (type(CountDownBar) == "table"
                    and CountDownBar.Get
                    and CountDownBar:Get("type") == "GDKP_MULTI_AUCTION_COUNTDOWN"
                    and not CountDownBar:Get("stopping")
                ) then
                    CountDownBar:SetParent(UIParent);
                    CountDownBar:Set("stopping", true);

                    if (CountDownBar.running) then
                        CountDownBar:Stop();
                    end
                end
            end

            AuctionRow.addCountDownBar(time);

            self.AuctionRows[auctionID] = AuctionRow;
            AuctionRow.updateStatus();
        end);
    end;

    self:resetAdminWindow();
    self:updateBidDetails();
    return Window;
end

--- Reset the admin window, used to manage individual auctions as the auctioneer, to its initial state
---
---@return void
function ClientInterface:resetAdminWindow()
    local Window = self:getWindow();

    if (not Window) then
        return;
    end

    local AuctionAdminWindow = Window.AuctionAdminWindow;
    AuctionAdminWindow._auctionID = nil;
    AuctionAdminWindow.Explanation:Show();
    AuctionAdminWindow.AdminWindowItemLink:Hide();
    AuctionAdminWindow.AdminButtonExplanation:Hide();
    AuctionAdminWindow.ButtonContainer:Hide();
    AuctionAdminWindow.AdminAuctionClosedExplanation:Hide();
    AuctionAdminWindow.AdminOpenLedgerButton:Hide();

    if (not Auctioneer:auctionStartedByMe()) then
        Window.AdminWindow:Hide();
        AuctionAdminWindow:Hide();
    else
        Window.AdminWindow:Show();
        AuctionAdminWindow:Show();
    end
end

--- Make sure the organizer's identity is shown for everyone
function ClientInterface:refreshIdentity()
    -- Determine which identity to activate
    Client.AuctionDetails.bth = Interface.Identity:getForMethod(Client.AuctionDetails.bth, "multiAuctionClient");

    -- Nothing changed since the last time we checked, return!
    if (self.currentIdentity == Client.AuctionDetails.bth) then
        return;
    end

    -- The client is not visible, no need to show anything now
    if (not self:isShown()) then
        return;
    end
    self.currentIdentity = Client.AuctionDetails.bth;

    -- A previous (different) identity exists, release it!
    if (self.Identity) then
        Interface:release(self.Identity);
    end

    ---@type Frame
    local Window = self:getWindow();

    ---@type Frame
    local IdentityWindow = Interface.Identity:buildForMultiAuctionClient(Client.AuctionDetails.bth);
    IdentityWindow:SetParent(Window);
    IdentityWindow:SetPoint("TOPRIGHT", Window, "TOPLEFT");

    self.Identity = IdentityWindow;
end

--- Show bidding details in the footer
---
---@return void
function ClientInterface:updateBidDetails()
    local items, noBids, totalBid, totalSold, bidByMe, boughtByMe = 0, 0, 0, 0, 0, 0;

    for _, Details in pairs(Client.AuctionDetails.Auctions or {}) do
        local AuctionDetails = Client.AuctionDetails.Auctions[Details.auctionID or -1];
        local endsAt = AuctionDetails.endsAt;
        local hasBid = AuctionDetails.CurrentBid and AuctionDetails.CurrentBid.amount;

        (function()
            local byMe = hasBid and GL:iEquals(AuctionDetails.CurrentBid.player, GL.User.fqn) or false;

            -- The auction was deleted by the LM
            if (endsAt == -1) then
                return;
            end

            items = items + 1;

            if (not hasBid) then
                noBids = noBids + 1;
                return;
            end

            if (endsAt == 0) then
                totalSold = totalSold + AuctionDetails.CurrentBid.amount;

                if (byMe) then
                    boughtByMe = boughtByMe + AuctionDetails.CurrentBid.amount;
                end

                return;
            end

            totalBid = totalBid + AuctionDetails.CurrentBid.amount;
            if (byMe) then
                bidByMe = bidByMe + AuctionDetails.CurrentBid.amount;
            end
        end)();
    end

    self.BidDetails:SetText(("Total sold: %sg  -  Pledged by me: %sg"):format(totalSold, boughtByMe + bidByMe));
    self.BidDetails:SetColor("GRAY");
    Interface:addTooltip(self.BidDetails, {
        ("Items with bids: %s/%s"):format(items - noBids, items),
        ("Total sold: %sg"):format(totalSold),
        ("Bought by me: %sg"):format(boughtByMe),
        ("Total bid (does not include sold): %sg"):format(totalBid),
        ("Bid by me (does not include sold): %sg"):format(bidByMe),
    }, "TOP");
end

--- Show the admin window which is used to manage individual auctions as the auctioneer
---
---@return void
function ClientInterface:showAuctionAdminWindow(AuctionRow)
    local Window = self:getWindow();

    if (not Window) then
        return;
    end

    local Details = GL:tableGet(AuctionRow or {}, "_Details", nil);
    if (not Details) then
        return;
    end

    if (not Auctioneer:auctionStartedByMe(Details.auctionID)) then
        return;
    end

    self:resetAdminWindow();

    local AuctionAdminWindow = Window.AuctionAdminWindow;
    AuctionAdminWindow._auctionID = Details.auctionID;
    AuctionAdminWindow.Explanation:Hide();

    AuctionAdminWindow.AdminWindowItemLink:SetText(Details.link);
    Interface:addTooltip(AuctionAdminWindow.AdminWindowItemLink, Details.link);
    AuctionAdminWindow.AdminWindowItemLink:Show();

    local CurrentDetails = Client.AuctionDetails.Auctions[Details.auctionID or -1];
    if (CurrentDetails
        and CurrentDetails.endsAt == 0
        and CurrentDetails.CurrentBid
        and CurrentDetails.CurrentBid.amount
    ) then
        AuctionAdminWindow.AdminAuctionClosedExplanation:Show();
        AuctionAdminWindow.AdminOpenLedgerButton:Show();
    else
        AuctionAdminWindow.AdminButtonExplanation:Show();
        AuctionAdminWindow.ButtonContainer:Show();
    end
end

--- Reset the admin window for the currently selected auction
---
---@return void
function ClientInterface:refreshAdminWindow()
    local Window = self:getWindow();

    if (not Window) then
        return;
    end

    self:showAuctionAdminWindow(self.AuctionRows[Window.AuctionAdminWindow._auctionID]);
end

--- Sort auctions, filter them by all the possible filters
---
---@return void
function ClientInterface:filterAndSort()
    local rowsShown = 0;
    local showUnusable = self.showUnusable;
    local showFavorites = self.showFavorites;
    local AuctionHolder = self.AuctionHolder;
    local RowsToShow = {};
    local filterConcernsLevel = false;
    local filterValue = self.Search:GetText();
    local operator = filterValue:match('\>=') or nil;
    operator = operator and operator or filterValue:match('\<=');
    operator = operator and operator or filterValue:match('\>');
    operator = operator and operator or filterValue:match('\<');

    if (operator) then
        filterValue = filterValue:gsub(operator, "");
        filterValue = filterValue:gsub(" ", "");
    end

    if (GL:higherThanZero(tonumber(filterValue))) then
        filterValue = tonumber(filterValue);
        filterConcernsLevel = true;
    end

    ---@param ItemRow Frame
    for auctionID, ItemRow in pairs(self.AuctionRows or {}) do
        ItemRow:ClearAllPoints();
        ItemRow:SetAlpha(0);
        ItemRow:SetHeight(0);

        (function()
            -- Make sure we have all the required data and the auction is still active
            if (not auctionID
                or type(ItemRow) ~= "table"
                or not ItemRow._Details
                or not ItemRow._Details.itemLevel
                or not ItemRow._Details.name
                or not ItemRow._Details.quality
                or not ItemRow._Details.auctionID

                -- These mean that the auction was deleted
                or not Client.AuctionDetails.Auctions[auctionID]
                or Client.AuctionDetails.Auctions[auctionID].endsAt <= -1

                -- Hide unusable items
                or (not showUnusable and not ItemRow._Details.canUseItem)

                -- Hide unusable items
                or (showFavorites and not ItemRow._Details.isFavorite)
            ) then
                return;
            end

            local itemLevel = ItemRow._Details.itemLevel;
            local name = ItemRow._Details.name;

            -- An item level was provided, filter!
            if (filterConcernsLevel) then
                if ((not operator and itemLevel ~= filterValue)
                    or (operator == "<=" and itemLevel > filterValue)
                    or (operator == ">=" and itemLevel < filterValue)
                    or (operator == ">" and itemLevel <= filterValue)
                    or (operator == "<" and itemLevel >= filterValue)
                ) then
                    return;
                end

            -- A (partial) item name was provided, filter!
            elseif (not GL:empty(filterValue)
                and not GL:strContains(name, filterValue)
            ) then
                return;
            end

            tinsert(RowsToShow, ItemRow);
        end)();
    end

    -- Sort the items by item level > quality > name
    table.sort(RowsToShow, function (a, b)
        if (a._Details.itemLevel == b._Details.itemLevel) then
            if (a._Details.quality ~= b._Details.quality) then
                return a._Details.quality > b._Details.quality;
            end

            return a._Details.name < b._Details.name;
        end

        return a._Details.itemLevel > b._Details.itemLevel;
    end);

    ---@param ItemRow Frame
    for _, ItemRow in pairs(RowsToShow or {}) do
        ItemRow:ClearAllPoints();
        ItemRow:SetAlpha(1);
        ItemRow:SetHeight(ITEM_ROW_HEIGHT);
        ItemRow:SetPoint("TOPLEFT", AuctionHolder, "TOPLEFT", 20, (rowsShown * ITEM_ROW_HEIGHT) * -1);
        ItemRow:SetPoint("RIGHT", AuctionHolder, "RIGHT", not GL.elvUILoaded and 0 or -4, 0);

        rowsShown = rowsShown + 1;
    end
end

---@return void
function ClientInterface:clear()
    ---@param ItemRow Frame
    for key, ItemRow in pairs(self.AuctionRows or {}) do
        local CountDownBar = ItemRow.CountDownBar;
        if (type(CountDownBar) == "table"
            and CountDownBar.Get
            and CountDownBar:Get("type") == "GDKP_MULTI_AUCTION_COUNTDOWN"
            and not CountDownBar:Get("stopping")
        ) then
            CountDownBar:SetParent(UIParent);
            CountDownBar:Set("stopping", true);

            if (CountDownBar.running) then
                CountDownBar:Stop();
            end
        end

        Interface:release(ItemRow);
        self.AuctionRows[key] = nil;
    end

    self.AuctionRows = {};
end

--- Update countdown bars when anti snipes hit, when the auctioneer changes something or when the auction starts
---
---@return void
function ClientInterface:refresh()
    if (not self:getWindow()) then
        return;
    end

    local rowsChanged = false;
    local serverTime = GetServerTime();
    for _, Details in pairs(Client.AuctionDetails.Auctions or {}) do
        (function()
            local AuctionRow = self.AuctionRows[Details.auctionID];

            if (not AuctionRow) then
                rowsChanged = true;

                return self:addAuction(Details);
            end

            --- We need to update the timer bar
            if (AuctionRow._Details.endsAt ~= Details.endsAt) then
                if (Details.endsAt <= -1) then
                    rowsChanged = true;
                end

                if (AuctionRow.CountDownBar
                    and AuctionRow.CountDownBar.SetDuration
                ) then
                    AuctionRow.stopCountdown();
                    AuctionRow._Details.endsAt = Details.endsAt;

                    if (Details.endsAt > serverTime) then
                        -- The .1 second delay is necessary since stopping the bar can sometimes occur after creating a new one
                        GL:after(.1, "GDKP_MULTI_AUCTION_CLIENT_ADD_BAR_FOR_" .. Details.auctionID, function ()
                            AuctionRow.addCountDownBar(Details.endsAt - serverTime);
                        end);
                    end
                end
            end

            AuctionRow.updateStatus();
        end)();
    end

    if (rowsChanged) then
        self:filterAndSort();
    end

    self:refreshAdminWindow();
    self:updateBidDetails();
end

---@return Frame
function ClientInterface:getWindow()
    return _G[self.windowName];
end