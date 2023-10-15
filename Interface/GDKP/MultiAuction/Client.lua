local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type GDKP
local GDKP = GL.GDKP;

---@type GroupVersionCheckInterface
local GroupVersionCheck = GL.Interface.GroupVersionCheck;

---@class GDKPMultiAuctionClientInterface
GL:tableSet(GL, "Interface.GDKP.MultiAuction.Client", {
    adminWindowName = "Gargul.Interface.GDKP.MultiAuction.Client.AdminWindow",
    windowName = "Gargul.Interface.GDKP.MultiAuction.Client.Window",

    ItemHolder = nil,
    AuctionRows = {},
    Search = nil;
});

---@type GDKPMultiAuctionClientInterface
local ClientInterface = GL.Interface.GDKP.MultiAuction.Client;

---@type GDKPMultiAuctionAuctioneer
local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;

---@type GDKPMultiAuctionClient
local Client = GL.GDKP.MultiAuction.Client;

--[[ CONSTANTS ]]
local ITEM_ROW_HEIGHT = 30;
local WINDOW_WIDTH = 383;
local WINDOW_HEIGHT = 333;
local FONT;

---@return Frame|nil
function ClientInterface:open()
    FONT = GL.FONT;

    local Window = self:getWindow() or self:build();

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
    };

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end }
    }, 100);

    --[[ LOGO ]]
    ---@type Frame
    local Logo = CreateFrame("Frame", nil, Window, "BackdropTemplate");
    Logo:SetSize(120, 120);
    Logo:SetBackdrop(_G.BACKDROP_DARK_DIALOG_32_32);
    Logo:SetPoint("TOPRIGHT", Window, "TOPLEFT", 0, 0);
    Interface:addTooltip(Logo, "Your logo here? Click for more info!", "TOP");

    ---@type Texture
    local LogoImage = Logo:CreateTexture();
    LogoImage:SetPoint("CENTER", Logo, "CENTER", 0, 12);
    LogoImage:SetSize(60, 60);
    LogoImage:SetTexture("Interface/AddOns/Gargul/Assets/Icons/gargul");
    Logo._Image = LogoImage;

    ---@type FontString
    local LogoText = Interface:createFontString(Logo, "Gargul GDKP");
    LogoText:SetPoint("CENTER", Logo, "CENTER");
    LogoText:SetPoint("BOTTOM", Logo, "BOTTOM", 0, 20);
    LogoText:SetFont(.9);
    Logo._Text = LogoText;

    Logo:SetScript("OnMouseUp", function(_, button)
        if (button == 'LeftButton') then
            GL.Interface.Dialogs.HyperlinkDialog:open{
                description = "Visit the URL below to learn more about personalizing Gargul GDKPs",
                hyperlink = "https://discord.gg/D3mDhYPVzf",
            };
        end
    end);

    Window._Logo = Logo;

    ---@type Frame
    local ItemHolder

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
    local ToggleFavorites = Interface:dynamicPanelButton(Window, "Show favorites only");
    ToggleFavorites:SetPoint("TOPLEFT", SearchClear, "TOPRIGHT", 6, -2);
    ToggleFavorites:SetScript("OnClick", function ()
        ToggleFavorites:SetText("Show all");
    end);

    --[[ SHOW/HIDE UNUSABLE ]]
    ---@type Button
    local ToggleUnusable = Interface:dynamicPanelButton(Window, "Hide Unusable");
    ToggleUnusable:SetPoint("TOPLEFT", ToggleFavorites, "TOPRIGHT", 6, 0);
    ToggleUnusable:SetScript("OnClick", function ()
        ToggleUnusable:SetText("Show Unusable");
    end);

    --[[ SCROLLFRAME BOILERPLATE ]]
    ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOP", Search, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("BOTTOM", Window, "BOTTOM", 0, 32);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 16);
    ScrollFrame:SetPoint("RIGHT", Window, "RIGHT", -44, 0);

    ItemHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(ItemHolder);
    ItemHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    ItemHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    ItemHolder:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");
    self.ItemHolder = ItemHolder;

    ---@type Frame
    local Items = CreateFrame("Frame", nil, ItemHolder);
    Items:SetAllPoints(ItemHolder);

    --[[ ADMIN WINDOW ]]
    do
        ---@type Frame
        local AdminWindow = Interface:createWindow{
            name = self.adminWindowName,
            width = 280,
            height = 90,
            hideMinimizeButton = true,
            hideResizeButton = true,
            hideMoveButton = true,
            hideWatermark = true,
            Parent = Window,
        };
        AdminWindow:SetPoint("TOPLEFT", Window, "TOPRIGHT", 10, 0);
        AdminWindow:Hide();

        local AdminExplanation = Interface:createFontString(AdminWindow, "Click the 'Admin' button or an auction to manage it");
        AdminExplanation:SetPoint("CENTER", AdminWindow, "CENTER");
        AdminExplanation:SetPoint("TOP", AdminWindow, "TOP", 0, -30);
        AdminExplanation:SetFont(.8, "OUTLINE");
        AdminExplanation:SetColor("GRAY");
        AdminWindow.Explanation = AdminExplanation;

        local AdminWindowItemLink = Interface:createFontString(AdminWindow, "");
        AdminWindowItemLink:SetPoint("CENTER", AdminWindow, "CENTER");
        AdminWindowItemLink:SetPoint("TOP", AdminWindow, "TOP", 0, -20);
        AdminWindowItemLink:SetColor("GRAY");
        AdminWindow.AdminWindowItemLink = AdminWindowItemLink;

        local AdminButtonExplanation = Interface:createFontString(AdminWindow, "Hover over any of the buttons below for more information");
        AdminButtonExplanation:SetPoint("CENTER", AdminWindowItemLink, "CENTER");
        AdminButtonExplanation:SetPoint("TOP", AdminWindowItemLink, "BOTTOM", 0, -7);
        AdminButtonExplanation:SetFont(.8, "OUTLINE");
        AdminButtonExplanation:SetColor("GRAY");
        AdminWindow.AdminButtonExplanation = AdminButtonExplanation;

        local AdminAuctionClosedExplanation = Interface:createFontString(AdminWindow, ("This item was sold. Use ledger (|c00%s/gdkp|r) to make changes!"):format(Interface.Colors.PURPLE));
        AdminAuctionClosedExplanation:SetPoint("CENTER", AdminWindowItemLink, "CENTER");
        AdminAuctionClosedExplanation:SetPoint("TOP", AdminWindowItemLink, "BOTTOM", 0, -7);
        AdminAuctionClosedExplanation:SetFont(.8, "OUTLINE");
        AdminAuctionClosedExplanation:SetColor("GRAY");
        AdminWindow.AdminAuctionClosedExplanation = AdminAuctionClosedExplanation;

        local AdminOpenLedgerButton = Interface:dynamicPanelButton(AdminWindow, "Ledger");
        AdminOpenLedgerButton:SetScale(.8);
        AdminOpenLedgerButton:SetPoint("CENTER", AdminWindow, "CENTER");
        AdminOpenLedgerButton:SetPoint("BOTTOM", AdminWindow, "BOTTOM", 0, 25);
        AdminWindow.AdminOpenLedgerButton = AdminOpenLedgerButton;

        AdminOpenLedgerButton:SetScript("OnClick", function ()
            Interface.GDKP.Overview:open();
        end);

        local ButtonContainer = CreateFrame("Frame", nil, AdminWindow);
        ButtonContainer:SetPoint("CENTER", AdminWindow, "CENTER");
        ButtonContainer:SetPoint("BOTTOM", AdminWindow, "BOTTOM", 0, 20);
        ButtonContainer:SetWidth(5000);
        AdminWindow.ButtonContainer = ButtonContainer;

        ---@type Button
        local CloseButton = Interface:dynamicPanelButton(ButtonContainer);
        CloseButton:SetScale(.8);
        CloseButton:SetPoint("BOTTOMLEFT", ButtonContainer, "BOTTOMLEFT");
        CloseButton:SetText("Close Auction");
        CloseButton:SetScript("OnClick", function ()
            if (not AdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            Auctioneer:closeAuction(AdminWindow._auctionID);
        end);
        Interface:addTooltip(CloseButton, "Close the auction. Players can no longer bid but the highest bid remains active", "TOP");

        ---@type Button
        local FinallCallButton = Interface:dynamicPanelButton(ButtonContainer);
        FinallCallButton:SetScale(.8);
        FinallCallButton:SetPoint("TOPLEFT", CloseButton, "TOPRIGHT", 2, 0);
        FinallCallButton:SetText("Last call");
        FinallCallButton:SetScript("OnClick", function ()
            if (not AdminWindow._auctionID) then
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
                    Auctioneer:finalCall(AdminWindow._auctionID, seconds);
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
            if (not AdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            GL.Interface.Dialogs.PopupDialog:open{
                question = "Are you sure?",
                OnYes = function ()
                    Auctioneer:clearBid(AdminWindow._auctionID);
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
            if (not AdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            GL.Interface.Dialogs.PopupDialog:open{
                question = "Are you sure?",
                OnYes = function ()
                    Auctioneer:deleteAuction(AdminWindow._auctionID);
                    self:resetAdminWindow();
                end,
            };
        end);
        Interface:addTooltip(DeleteButton, "Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!", "TOP");

        -- Shadow frame used to determine the required width of the ButtonContainer
        local ShadowFrame = CreateFrame("Frame", nil, AdminWindow);
        ShadowFrame:SetPoint("TOPLEFT", CloseButton, "TOPLEFT");
        ShadowFrame:SetPoint("TOPRIGHT", DeleteButton, "TOPRIGHT");
        ShadowFrame:SetHeight(1);

        ButtonContainer:SetWidth(ShadowFrame:GetWidth());
        Interface:release(ShadowFrame);

        Window.AdminWindow = AdminWindow;
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
            end);

            ---@type Frame
            local AuctionRow = CreateFrame("Frame", nil, ItemHolder);
            AuctionRow:SetPoint("TOPLEFT", Window, "TOPLEFT", 0, 0);
            AuctionRow:SetPoint("TOPRIGHT", Window, "TOPLEFT", 0, 0);
            AuctionRow:EnableMouse(true);
            AuctionRow:SetHeight(0);
            AuctionRow:SetAlpha(0);

            AuctionRow:EnableMouse(true);
            AuctionRow:SetScript("OnMouseUp", function ()
                self:showAdminWindow(AuctionRow);
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
            FavoriteImage:SetVertexColor(.9, .9, .9, .3);

            Favorite:SetScript("OnMouseUp", function ()
                FavoriteImage:SetVertexColor(1, 1, 1, 1);
            end);

            --[[ ITEM ICON ]]
            ---@type Frame
            local Icon = CreateFrame("Frame",nil, AuctionRow);
            Icon:SetPoint("TOP", AuctionRow, "TOP");
            Icon:SetPoint("LEFT", Favorite, "RIGHT", 2, 0);
            Icon:SetSize(ITEM_ROW_HEIGHT, ITEM_ROW_HEIGHT);
            Interface:addTooltip(Icon, Item.link);
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
                    self:showAdminWindow(AuctionRow);
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
            AuctionRow.addCountDownBar(time);

            self.AuctionRows[auctionID] = AuctionRow;
            AuctionRow.updateStatus();
        end);
    end;

    self:resetAdminWindow();
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

    local AdminWindow = Window.AdminWindow;
    AdminWindow._auctionID = nil;
    AdminWindow.Explanation:Show();
    AdminWindow.AdminWindowItemLink:Hide();
    AdminWindow.AdminButtonExplanation:Hide();
    AdminWindow.ButtonContainer:Hide();
    AdminWindow.AdminAuctionClosedExplanation:Hide();
    AdminWindow.AdminOpenLedgerButton:Hide();

    if (not Auctioneer:auctionStartedByMe()) then
        AdminWindow:Hide();
    else
        AdminWindow:Show();
    end
end

--- Show the admin window which is used to manage individual auctions as the auctioneer
---
---@return void
function ClientInterface:showAdminWindow(AuctionRow)
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

    local AdminWindow = Window.AdminWindow;
    AdminWindow._auctionID = Details.auctionID;
    AdminWindow.Explanation:Hide();

    AdminWindow.AdminWindowItemLink:SetText(Details.link);
    Interface:addTooltip(AdminWindow.AdminWindowItemLink, Details.link);
    AdminWindow.AdminWindowItemLink:Show();

    local CurrentDetails = Client.AuctionDetails.Auctions[Details.auctionID or -1];
    if (CurrentDetails
        and CurrentDetails.endsAt == 0
        and CurrentDetails.CurrentBid
        and CurrentDetails.CurrentBid.amount
    ) then
        AdminWindow.AdminAuctionClosedExplanation:Show();
        AdminWindow.AdminOpenLedgerButton:Show();
    else
        AdminWindow.AdminButtonExplanation:Show();
        AdminWindow.ButtonContainer:Show();
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

    self:showAdminWindow(self.AuctionRows[Window.AdminWindow._auctionID]);
end

--- Sort auctions, filter them by all the possible filters
---
---@return void
function ClientInterface:filterAndSort()
    local rowsShown = 0;
    local ItemHolder = self.ItemHolder;
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
        ItemRow:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 20, (rowsShown * ITEM_ROW_HEIGHT) * -1);
        ItemRow:SetPoint("RIGHT", ItemHolder, "RIGHT", not GL.elvUILoaded and 0 or -4, 0);

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
    if (not self:isShown()) then
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
                    AuctionRow.CountDownBar:Stop();
                    AuctionRow.CountDownBar:Hide();
                    rowsChanged = true;
                end

                if (AuctionRow.CountDownBar
                    and AuctionRow.CountDownBar.SetDuration
                ) then
                    AuctionRow.CountDownBar:Stop();
                    AuctionRow.CountDownBar:Hide();

                    AuctionRow._Details.endsAt = Details.endsAt;

                    if (Details.endsAt > serverTime) then
                        AuctionRow.addCountDownBar(Details.endsAt - serverTime);
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
end

---@return Frame
function ClientInterface:getWindow()
    return _G[self.windowName];
end