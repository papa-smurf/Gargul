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
    windowName = "Gargul.Interface.GDKP.MultiAuction.Client.Window",

    ItemHolder = nil,
    ItemRows = {},
    Search = nil;
});

---@type GDKPMultiAuctionClientInterface
local Client = GL.Interface.GDKP.MultiAuction.Client;

--[[ CONSTANTS ]]
local ITEM_ROW_HEIGHT = 30;
local WINDOW_WIDTH = 383;
local WINDOW_HEIGHT = 333;
local FONT;

---@return Frame|nil
function Client:open()
    FONT = GL.FONT;

    local Window = self:getWindow() or self:build();

    return Window:Show() and Window;
end

---@return void
function Client:close()
    local Window = self:getWindow() or self:build();

    Window:Hide();
end

---@return boolean
function Client:isShown()
    local Window = self:getWindow();

    return Window and Window:IsShown();
end

---@return void
function Client:addItem(itemLink)
    local Window = self:getWindow();

    if (not Window) then
        return false;
    end

    Window:addItem(itemLink);
end

---@return Frame
function Client:build()
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

    --[[ SHOW/HIDE FAVORITES ]]
    ---@type Button
    local ToggleFavorites = Interface:dynamicPanelButton(Window, "Show favorites only");
    ToggleFavorites:SetPoint("TOPLEFT", Search, "TOPRIGHT", 6, 0);
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

    --[[ ADD AN ITEM TO THE QUEUE WINDOW ]]
    Window.addItem = function (_, Details)
        local link = Details.link;
        local quality = Details.quality;
        local name = Details.name;
        local itemLevel = Details.itemLevel;
        local isBOE = Details.isBOE;

        GL:onItemLoadDo(GL:getItemIDFromLink(link), function (Item)
            if (not Item) then
                return;
            end

            local canUseItem = true;
            GL:canUserUseItem(Item.id, function (canUse)
                canUseItem = canUse;
            end);

            ---@type Frame
            local ItemRow = CreateFrame("Frame", nil, ItemHolder);
            ItemRow:SetPoint("TOPLEFT", Window, "TOPLEFT", 0, 0);
            ItemRow:SetPoint("TOPRIGHT", Window, "TOPLEFT", 0, 0);
            ItemRow:EnableMouse(true);
            ItemRow:SetHeight(0);
            ItemRow:SetAlpha(0);

            ItemRow._Details = Details;

            --ItemRow:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 20, (GL:count(self.ItemRows) * rowHeight) * -1);
            --ItemRow:SetPoint("TOPRIGHT", ItemHolder, "TOPRIGHT", not GL.elvUILoaded and 0 or -4, 0);

            --[[ FAVORITE ]]
            ---@type Frame
            local Favorite = CreateFrame("Frame",nil, ItemRow);
            Favorite:SetPoint("TOP", ItemRow, "TOP", 0, (ITEM_ROW_HEIGHT - ITEM_ROW_HEIGHT * .8) / -2);
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
            local Icon = CreateFrame("Frame",nil, ItemRow);
            Icon:SetPoint("TOP", ItemRow, "TOP");
            Icon:SetPoint("LEFT", Favorite, "RIGHT", 2, 0);
            Icon:SetSize(ITEM_ROW_HEIGHT, ITEM_ROW_HEIGHT);
            Interface:addTooltip(Icon, Item.link);
            ItemRow.Icon = Icon;

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

            --[[ BID BUTTON ]]
            ---@type Button
            local BidButton = Interface:dynamicPanelButton(ItemRow);
            BidButton:SetPoint("CENTER", ItemRow, "CENTER");
            BidButton:SetPoint("RIGHT", ItemRow, "RIGHT");
            BidButton:SetScale(.8);
            BidButton:SetText("Bid");
            BidButton:SetHeight(27);

            --[[ BID INPUT ]]
            ---@type EditBox
            local BidInput = Interface:inputBox(ItemRow, nil, 21000);
            BidInput:SetWidth(56);
            BidInput:SetPoint("CENTER", BidButton, "CENTER");
            BidInput:SetPoint("RIGHT", BidButton, "LEFT", -2, 0);

            --[[ MINIMUM ]]
            ---@type EditBox
            local MinButton = Interface:dynamicPanelButton(ItemRow);
            MinButton:SetPoint("CENTER", BidInput, "CENTER");
            MinButton:SetPoint("RIGHT", BidInput, "LEFT", -10, 0);
            MinButton:SetScale(.8);
            MinButton:SetText("Min");
            MinButton:SetHeight(27);

            --[[ AUCTION STATUS HOLDER ]]
            local StatusHolder = CreateFrame("Frame", nil, ItemRow);
            StatusHolder:SetPoint("TOP", ItemRow, "TOP");
            StatusHolder:SetPoint("BOTTOM", ItemRow, "BOTTOM");
            StatusHolder:SetPoint("RIGHT", MinButton, "LEFT", -4, 0);
            StatusHolder:SetWidth(100);

            ---@type FontString
            local StatusText = Interface:createFontString(ItemRow, "Bid 20500g\nBy Thunderthigh");
            StatusText:SetAllPoints(StatusHolder);
            StatusText:SetFont(.9);
            StatusText:SetWidth(100);

            ---@type FontString
            local Name = Interface:createFontString(ItemRow, Item.link);
            Name:SetPoint("CENTER", Icon);
            Name:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
            Name:SetPoint("RIGHT", MinButton, "LEFT", -6, 0);
            Name:SetHeight(ITEM_ROW_HEIGHT);

            local time = 300;
            local CountDownBar = LibStub("LibCandyBarGargul-3.0"):New(
                    "Interface\\AddOns\\Gargul\\Assets\\Textures\\timer-bar",
                    ItemRow:GetWidth(),
                    ITEM_ROW_HEIGHT
            );
            CountDownBar:SetParent(ItemRow);
            CountDownBar:SetPoint("TOP", ItemRow, "TOP");
            CountDownBar:SetPoint("RIGHT", ItemRow, "RIGHT");
            CountDownBar:SetPoint("BOTTOM", ItemRow, "BOTTOM");
            CountDownBar:SetPoint("LEFT", Icon, "LEFT");
            CountDownBar:SetDuration(time);
            CountDownBar:SetColor(0, 1, 0, .3); -- Reset color to green
            CountDownBar:Set("type", "GDKP_MULTI_AUCTION_COUNTDOWN");
            CountDownBar:Start();
            CountDownBar:SetFrameStrata(ItemRow:GetFrameStrata());
            CountDownBar:SetFrameLevel(ItemRow:GetFrameLevel() - 1);
            CountDownBar:SetTimeVisibility(false);
            ItemRow.CountDownBar = CountDownBar;

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

            tinsert(self.ItemRows, ItemRow);
        end);
    end;

    self:refresh();

    return Window;
end

---@return void
function Client:refresh()
    GL:forEachItemInBags(function (Location, bag, slot)
        self:addItem{
            itemLevel = C_Item.GetCurrentItemLevel(Location),
            isBOE = GL:inventoryItemTradeTimeRemaining(bag, slot) == GL.Data.Constants.itemIsNotBound,
            name = C_Item.GetItemName(Location);
            link = C_Item.GetItemLink(Location),
            quality = C_Item.GetItemQuality(Location),
        };
    end);

    Client:filterAndSort();
end

---@return void
function Client:filterAndSort()
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
    for _, ItemRow in pairs(self.ItemRows or {}) do
        ItemRow:ClearAllPoints();
        ItemRow:SetAlpha(0);
        ItemRow:SetHeight(0);

        (function()
            -- Make sure we have all the required data
            if (type(ItemRow) ~= "table"
                or not ItemRow._Details
                or not ItemRow._Details.itemLevel
                or not ItemRow._Details.name
                or not ItemRow._Details.quality
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
function Client:clear()
    ---@param ItemRow Frame
    for key, ItemRow in pairs(self.ItemRows or {}) do
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
        self.ItemRows[key] = nil;
    end

    self.ItemRows = {};
end

---@return Frame
function Client:getWindow()
    return _G[self.windowName];
end