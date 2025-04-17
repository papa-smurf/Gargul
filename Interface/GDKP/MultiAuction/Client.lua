local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type Settings
local Settings = GL.Settings;

---@type GDKPMultiAuctionAuctioneer
local Auctioneer = GL.GDKP.MultiAuction.Auctioneer;

---@type GDKPMultiAuctionClient
local Client = GL.GDKP.MultiAuction.Client;

---@class GDKPMultiAuctionClientInterface
GL:tableSet(GL, "Interface.GDKP.MultiAuction.Client", {
    adminWindowName = "Gargul.Interface.GDKP.MultiAuction.Client.AdminWindow",
    auctionAdminWindowName = "Gargul.Interface.GDKP.MultiAuction.Client.AuctionAdminWindow",
    windowName = "Gargul.Interface.GDKP.MultiAuction.Client.Window",

    enableFilters = true,
    showFavorites = false,
    showInactive = true,

    AuctionHolder = nil,
    AuctionRows = {},
    Search = nil;
    ToggleFavorites = nil,
});

---@type GDKPMultiAuctionClientInterface
local ClientInterface = GL.Interface.GDKP.MultiAuction.Client;

--[[ CONSTANTS ]]
local ITEM_ROW_HEIGHT = 30;
local WINDOW_WIDTH = 625;
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
    increment = GL:floor(tonumber(auctionID.increment) or 0, Client.AuctionDetails.precision or 0);
    isBOE = auctionID.isBOE;
    itemLevel = auctionID.itemLevel;
    link = auctionID.link;
    minimum = GL:floor(tonumber(auctionID.minimum) or 0, Client.AuctionDetails.precision or 0);
    name = auctionID.name;
    quality = auctionID.quality;
    auctionID = auctionID.auctionID;

    if (GL:lt(minimum, .0001)) then
        return;
    end

    if (GL:lt(increment, .0001)) then
        return;
    end

    GL:onItemLoadDo(link, function (Item)
        if (not Item) then
            return;
        end

        local Details = Item;
        Details.itemLevel = Details.level;
        Details.auctionID = auctionID;
        Details.CurrentBid = CurrentBid;
        Details.endsAt = endsAt;
        Details.increment = increment;
        Details.minimum = minimum;

        Window:addAuction(Details);
    end);
end

---@return Frame
function ClientInterface:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    local filter = function ()
        self:filterAndSort();
        self:resetScroll();
    end;

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

            GL:notice(L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO)
        end,
    };

    local SoundOptions = {{
        text = "Gargul: uh-oh",
        hideOnClick = true,
        isRadio = true,
        checked = function ()
            return GL.Settings:get("GDKP.outbidSound") == "Gargul: uh-oh";
        end,
        func = function (Entry)
            Entry.checked = true;
            GL.Settings:set("GDKP.outbidSound", "Gargul: uh-oh");
        end,
    }, {
        text = L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS,
        hideOnClick = true,
        isRadio = true,
        checked = false,
        func = function ()
            GL.Settings:draw("GDKP");
            CloseMenus();
        end,
    }, {
        text = L.NONE,
        hideOnClick = true,
        isRadio = true,
        checked = function ()
            return GL.Settings:get("GDKP.outbidSound") == L.NONE;
        end,
        func = function (Entry)
            Entry.checked = true;
            GL.Settings:set("GDKP.outbidSound", "None");
        end,
    }};

    --[[ THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        {text = L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES, setting = "GDKP.MultiAuction.awardNotice" },
        {text = L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND, notCheckable = true, SubMenu = SoundOptions, },
        "divider",
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
    local Search = Interface:inputBox(Window, nil, L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL);
    Search:SetWidth(150);
    Search:SetPoint("TOPLEFT", Window, "TOPLEFT", 28, -24);
    Search:SetPoint("TOPLEFT", Window, "TOPLEFT", 28, -24);
    self.Search = Search;
    Interface:addTooltip(Search, L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP);

    Search:SetScript("OnTextChanged", function ()
        GL:after(.5, "GDKP_MULTI_AUCTION_CLIENT_FILTER_CHANGED", function ()
            filter();
        end);
    end);

    ---@type Button
    local SearchClear = CreateFrame("Button", nil, Window, "UIPanelCloseButton");
    SearchClear:SetPoint("TOPLEFT", Search, "TOPRIGHT", -1, 2);
    SearchClear:SetSize(26, 26);
    SearchClear:SetScript("OnClick", function ()
        Search:Clear();
    end);
    Interface:addTooltip(SearchClear, L.CLEAR);

    --[[ SHOW/HIDE FAVORITES ]]
    ---@type Button
    local ToggleFavorites = Interface:dynamicPanelButton(Window, L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES);
    ToggleFavorites:SetPoint("TOPLEFT", SearchClear, "TOPRIGHT", 6, -2);
    ToggleFavorites:SetScript("OnClick", function ()
        self.showFavorites = not self.showFavorites;
        ToggleFavorites:SetText(self.showFavorites and L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL or L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES);
        filter();
    end);
    self.ToggleFavorites = ToggleFavorites;

    --[[ SHOW/HIDE ACTIVE ]]
    ---@type Button
    local ToggleActive = Interface:dynamicPanelButton(Window, L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE);
    ToggleActive:SetPoint("TOPLEFT", ToggleFavorites, "TOPRIGHT", 6, 0);
    ToggleActive:SetScript("OnClick", function ()
        self.showInactive = not self.showInactive;
        ToggleActive:SetText(self.showInactive and L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE or L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE);
        filter();
    end);
    self.ToggleActive = ToggleActive;
    Interface:addTooltip(ToggleActive, L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP);

    --[[ FILTER ]]
    local Filters = Interface:multiSelect(Window, L.GDKP_MULTIAUCTION_CLIENT_HIDE_ITEMS, {
        {
            text = "Unusable",
            checked = function ()
                return Settings:get("GDKP.MultiAuction." .. GL.User.id .. ".Filters.unusable", false);
            end,
            func = function (Entry)
                Settings:set("GDKP.MultiAuction." .. GL.User.id .. ".Filters.unusable", Entry.checked);
                filter();
            end,
        },
        "divider",
        {text = ARMOR, isTitle = true, notCheckable = true },
        {
            text = "Cloth",
            checked = function ()
                return Settings:get(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Cloth));
            end,
            func = function (Entry)
                Settings:set(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Cloth), Entry.checked);
                filter();
            end,
        },
        {
            text = "Leather",
            checked = function ()
                return Settings:get(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Leather));
            end,
            func = function (Entry)
                Settings:set(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Leather), Entry.checked);
                filter();
            end,
        },
        {
            text = "Mail",
            checked = function ()
                return Settings:get(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Mail));
            end,
            func = function (Entry)
                Settings:set(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Mail), Entry.checked);
                filter();
            end,
        },
        {
            text = "Plate",
            checked = function ()
                return Settings:get(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Plate));
            end,
            func = function (Entry)
                Settings:set(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Plate), Entry.checked);
                filter();
            end,
        },
        "divider",
        {text = string.sub(MODIFIERS_COLON or "Modifiers:", 1, -2), isTitle = true, notCheckable = true },
        {
            text = ITEM_MOD_AGILITY_SHORT,
            checked = function ()
                return Settings:get("GDKP.MultiAuction." .. GL.User.id .. ".Filters.Mods.agility");
            end,
            func = function (Entry)
                Settings:set("GDKP.MultiAuction." .. GL.User.id .. ".Filters.Mods.agility", Entry.checked or nil);

                filter();
            end,
        },
        {
            text = ITEM_MOD_INTELLECT_SHORT,
            checked = function ()
                return Settings:get("GDKP.MultiAuction." .. GL.User.id .. ".Filters.Mods.intellect");
            end,
            func = function (Entry)
                Settings:set("GDKP.MultiAuction." .. GL.User.id .. ".Filters.Mods.intellect", Entry.checked or nil);

                filter();
            end,
        },
        {
            text = ITEM_MOD_SPIRIT_SHORT,
            checked = function ()
                return Settings:get("GDKP.MultiAuction." .. GL.User.id .. ".Filters.Mods.spirit");
            end,
            func = function (Entry)
                Settings:set("GDKP.MultiAuction." .. GL.User.id .. ".Filters.Mods.spirit", Entry.checked or nil);

                filter();
            end,
        },
        {
            text = ITEM_MOD_STRENGTH_SHORT,
            checked = function ()
                return Settings:get("GDKP.MultiAuction." .. GL.User.id .. ".Filters.Mods.strength");
            end,
            func = function (Entry)
                Settings:set("GDKP.MultiAuction." .. GL.User.id .. ".Filters.Mods.strength", Entry.checked or nil);

                filter();
            end,
        },
        "divider",
        {
            text = L.BIND_ON_EQUIP_ABBR,
            checked = function ()
                return Settings:get("GDKP.MultiAuction." .. GL.User.id .. ".Filters.BOE");
            end,
            func = function (Entry)
                Settings:set("GDKP.MultiAuction." .. GL.User.id .. ".Filters.BOE", Entry.checked);
                filter();
            end,
        },
        {
            text = "Shields",
            checked = function ()
                return Settings:get(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Shield));
            end,
            func = function (Entry)
                Settings:set(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, Enum.ItemArmorSubclass.Shield), Entry.checked);
                filter();
            end,
        },
    }, 120);
    Filters:SetPoint("TOPLEFT", ToggleActive, "TOPRIGHT", -10, 2);

    --[[ SELECT ALL ]]
    ---@type CheckButton
    local ToggleFilters = Interface:createCheckbox{
        Parent = Window,
        checked = ClientInterface.enableFilters,
        callback = function (_, value)
            ClientInterface.enableFilters = value;
            filter();
        end,
    };
    ToggleFilters:SetPoint("TOPLEFT", Filters, "TOPRIGHT", -12, -4);
    Interface:addTooltip(ToggleFilters, L.GDKP_MULTIAUCTION_CLIENT_HIDE_ITEMS_TOOLTIP);

    --[[ SCROLLFRAME BOILERPLATE ]]
    ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate");
    ScrollFrame:SetPoint("TOP", Search, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("BOTTOM", Window, "BOTTOM", 0, 40);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 16);
    ScrollFrame:SetPoint("RIGHT", Window, "RIGHT", -44, 0);
    self.ScrollFrame = ScrollFrame;

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
            height = 80,
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
        ButtonContainer:SetPoint("TOP", AdminWindow, "TOP", 0, -40);
        ButtonContainer:SetWidth(5000);
        AdminWindow.ButtonContainer = ButtonContainer;

        ---@type Button
        local CloseAllButton = Interface:dynamicPanelButton(ButtonContainer);
        CloseAllButton:SetPoint("BOTTOMLEFT", ButtonContainer, "BOTTOMLEFT");
        CloseAllButton:SetText(L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL);
        CloseAllButton:SetScript("OnClick", function ()
            GL.Interface.Dialogs.PopupDialog:open{
                question = L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM,
                OnYes = function ()
                    for auctionID in pairs(Client.AuctionDetails.Auctions or {}) do
                        Auctioneer:closeAuction(auctionID);
                    end
                end,
            };
        end);
        Interface:addTooltip(CloseAllButton, L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP);

        ---@type Button
        local FinalCallButton = Interface:dynamicPanelButton(ButtonContainer);
        FinalCallButton:SetPoint("TOPLEFT", CloseAllButton, "TOPRIGHT", 4, 0);
        FinalCallButton:SetText(L.FINAL_CALL);
        FinalCallButton:SetScript("OnClick", function ()
            GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open{
                question = L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG,
                inputValue = GL.Settings:get("GDKP.finalCallTime"),
                OnYes = function (seconds)
                    seconds = floor(tonumber(strtrim(seconds)) or 0);
                    if (seconds < 5) then
                        return GL:error(L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5);
                    end

                    GL.Settings:set("GDKP.finalCallTime", seconds);

                    for auctionID in pairs(Client.AuctionDetails.Auctions or {}) do
                        Auctioneer:finalCall(auctionID, seconds);
                    end
                end,
                focus = true,
            };
        end);
        Interface:addTooltip(FinalCallButton, L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP);

        ---@type Button
        local FinishButton = Interface:dynamicPanelButton(ButtonContainer);
        FinishButton:SetPoint("TOPLEFT", FinalCallButton, "TOPRIGHT", 4, 0);
        FinishButton:SetText(L.FINISH);
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
                question = L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM,
                OnYes = function ()
                    Auctioneer:finish();
                    self:close();
                end,
            };
        end);
        Interface:addTooltip(FinishButton, L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP);

        ---@type Button
        local TerminateButton = Interface:dynamicPanelButton(ButtonContainer);
        TerminateButton:SetPoint("TOPLEFT", FinishButton, "TOPRIGHT", 4, 0);
        TerminateButton:SetText(L.GDKP_MULTIAUCTION_CLIENT_TERMINATE);
        TerminateButton:SetScript("OnClick", function ()
            GL.Interface.Dialogs.PopupDialog:open{
                question = L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM,
                OnYes = function ()
                    Auctioneer:terminate();
                end,
            };
        end);
        Interface:addTooltip(TerminateButton, L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP);

        ---@type Button
        local DisenchantButton = Interface:dynamicPanelButton(ButtonContainer);
        DisenchantButton:SetPoint("TOPLEFT", TerminateButton, "TOPRIGHT", 4, 0);
        DisenchantButton:SetText(L.DISENCHANT);
        DisenchantButton:SetScript("OnClick", function ()
            GL.Interface.Dialogs.PopupDialog:open{
                question = L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM,
                OnYes = function ()
                    Auctioneer:disenchant();
                end,
            };
        end);
        Interface:addTooltip(DisenchantButton, L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP);

        --[[ HOW TO ADD ITEMS ]]
        ---@type FontString
        local AddItemsLabel = Interface:createFontString(AdminWindow, (L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM):format(GL.Settings:get("ShortcutKeys.rollOffOrAuction")));
        AddItemsLabel:SetFont(.8, "OUTLINE");
        AddItemsLabel:SetColor("GRAY");
        AddItemsLabel:SetPoint("CENTER", AdminWindow, "CENTER");
        AddItemsLabel:SetPoint("BOTTOM", AdminWindow, "BOTTOM", 0, 20);

        -- Shadow frame used to determine the required width of the ButtonContainer
        local ShadowFrame = CreateFrame("Frame", nil, AdminWindow);
        ShadowFrame:SetPoint("TOPLEFT", CloseAllButton, "TOPLEFT");
        ShadowFrame:SetPoint("TOPRIGHT", DisenchantButton, "TOPRIGHT");
        ShadowFrame:SetHeight(1);

        ButtonContainer:SetWidth(ShadowFrame:GetWidth());
        Interface:release(ShadowFrame);
    end

    --[[ AUCTION ADMIN WINDOW ]]
    do
        ---@type Frame
        local AuctionAdminWindow = Interface:createWindow{
            name = self.auctionAdminWindowName,
            width = 320,
            height = 90,
            hideMinimizeButton = true,
            hideResizeButton = true,
            hideMoveButton = true,
            hideWatermark = true,
            Parent = Window,
        };
        AuctionAdminWindow:SetPoint("TOPLEFT", Window, "TOPRIGHT", 10, 0);
        AuctionAdminWindow:Hide();

        local AdminExplanation = Interface:createFontString(AuctionAdminWindow, L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO);
        AdminExplanation:SetPoint("CENTER", AuctionAdminWindow, "CENTER");
        AdminExplanation:SetPoint("TOP", AuctionAdminWindow, "TOP", 0, -30);
        AdminExplanation:SetFont(1, "OUTLINE");
        AdminExplanation:SetColor("GRAY");
        AuctionAdminWindow.Explanation = AdminExplanation;

        local AdminWindowItemLink = Interface:createFontString(AuctionAdminWindow, "");
        AdminWindowItemLink:SetPoint("CENTER", AuctionAdminWindow, "CENTER");
        AdminWindowItemLink:SetPoint("TOP", AuctionAdminWindow, "TOP", 0, -20);
        AdminWindowItemLink:SetColor("GRAY");
        AuctionAdminWindow.AdminWindowItemLink = AdminWindowItemLink;

        local AdminButtonExplanation = Interface:createFontString(AuctionAdminWindow, L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO);
        AdminButtonExplanation:SetPoint("CENTER", AdminWindowItemLink, "CENTER");
        AdminButtonExplanation:SetPoint("TOP", AdminWindowItemLink, "BOTTOM", 0, -7);
        AdminButtonExplanation:SetFont(1, "OUTLINE");
        AdminButtonExplanation:SetColor("GRAY");
        AuctionAdminWindow.AdminButtonExplanation = AdminButtonExplanation;

        local AdminAuctionClosedExplanation = Interface:createFontString(AuctionAdminWindow, (L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO):format(Interface.Colors.PURPLE));
        AdminAuctionClosedExplanation:SetPoint("CENTER", AdminWindowItemLink, "CENTER");
        AdminAuctionClosedExplanation:SetPoint("TOP", AdminWindowItemLink, "BOTTOM", 0, -7);
        AdminAuctionClosedExplanation:SetFont(1, "OUTLINE");
        AdminAuctionClosedExplanation:SetColor("GRAY");
        AuctionAdminWindow.AdminAuctionClosedExplanation = AdminAuctionClosedExplanation;

        local AdminOpenLedgerButton = Interface:dynamicPanelButton(AuctionAdminWindow, L.LEDGER);
        AdminOpenLedgerButton:SetScale(.9);
        AdminOpenLedgerButton:SetPoint("CENTER", AuctionAdminWindow, "CENTER");
        AdminOpenLedgerButton:SetPoint("BOTTOM", AuctionAdminWindow, "BOTTOM", 0, 18);
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
        CloseButton:SetScale(.9);
        CloseButton:SetPoint("BOTTOMLEFT", ButtonContainer, "BOTTOMLEFT", 0, -4);
        CloseButton:SetText(L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION);
        CloseButton:SetScript("OnClick", function ()
            if (not AuctionAdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            GL.Interface.Dialogs.PopupDialog:open{
                question = L.ARE_YOU_SURE,
                OnYes = function ()
                    Auctioneer:closeAuction(AuctionAdminWindow._auctionID);
                end,
            };
        end);
        Interface:addTooltip(CloseButton, L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP);

        ---@type Button
        local FinallCallButton = Interface:dynamicPanelButton(ButtonContainer);
        FinallCallButton:SetScale(.9);
        FinallCallButton:SetPoint("TOPLEFT", CloseButton, "TOPRIGHT", 2, 0);
        FinallCallButton:SetText(L.FINAL_CALL);
        FinallCallButton:SetScript("OnClick", function ()
            if (not AuctionAdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open{
                question = L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG,
                inputValue = GL.Settings:get("GDKP.finalCallTime"),
                OnYes = function (seconds)
                    seconds = floor(tonumber(strtrim(seconds)) or 0);
                    if (seconds < 5) then
                        return GL:error(L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5);
                    end

                    GL.Settings:set("GDKP.finalCallTime", seconds);
                    Auctioneer:finalCall(AuctionAdminWindow._auctionID, seconds);
                end,
                focus = true,
            };
        end);
        Interface:addTooltip(FinallCallButton, L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP);

        ---@type Button
        local ClearButton = Interface:dynamicPanelButton(ButtonContainer);
        ClearButton:SetScale(.9);
        ClearButton:SetPoint("TOPLEFT", FinallCallButton, "TOPRIGHT", 2, 0);
        ClearButton:SetText(L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS);
        ClearButton:SetScript("OnClick", function ()
            if (not AuctionAdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            GL.Interface.Dialogs.PopupDialog:open{
                question = L.ARE_YOU_SURE,
                OnYes = function ()
                    Auctioneer:clearBid(AuctionAdminWindow._auctionID);
                end,
            };
        end);
        Interface:addTooltip(ClearButton, L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP);

        ---@type Button
        local DeleteButton = Interface:dynamicPanelButton(ButtonContainer);
        DeleteButton:SetScale(.9);
        DeleteButton:SetPoint("TOPLEFT", ClearButton, "TOPRIGHT", 2, 0);
        DeleteButton:SetText(L.DELETE);
        DeleteButton:SetScript("OnClick", function ()
            if (not AuctionAdminWindow._auctionID) then
                return self:resetAdminWindow();
            end

            GL.Interface.Dialogs.PopupDialog:open{
                question = L.ARE_YOU_SURE,
                OnYes = function ()
                    Auctioneer:deleteAuction(AuctionAdminWindow._auctionID);
                    self:resetAdminWindow();
                end,
            };
        end);
        Interface:addTooltip(DeleteButton, L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP);

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
        local itemLevel = Details.itemLevel;
        local isBOE = Details.isBOE;
        local minimum = Details.minimum;
        local increment = Details.increment;
        local auctionID = Details.auctionID;
        local time = Details.endsAt - GetServerTime();

        GL:onItemLoadDo(link, function (Item)
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
            Interface:addTooltip(Favorite, L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP);

            ---@type Texture
            local FavoriteImage = Favorite:CreateTexture(nil, "BACKGROUND")
            FavoriteImage:SetAllPoints(Favorite);
            FavoriteImage:SetTexture("Interface/common/friendship-heart");
            FavoriteImage:SetVertexColor(.9, .9, .9, .25);

            AuctionRow.toggleFavorite = function (favorite, bubble)
                bubble = bubble ~= false;

                if (favorite ~= nil) then
                    AuctionRow._Details.isFavorite = favorite;
                else
                    AuctionRow._Details.isFavorite = not AuctionRow._Details.isFavorite;
                end

                if (AuctionRow._Details.isFavorite) then
                    FavoriteImage:SetVertexColor(1, 1, 1, 1);
                else
                    FavoriteImage:SetVertexColor(.9, .9, .9, .25);
                end

                if (not bubble) then
                    return;
                end

                ---@param ItemRow Frame
                for _, ItemRow in pairs(self.AuctionRows or {}) do
                    (function()
                        if (type(ItemRow) ~= "table"
                            or not ItemRow._Details
                            or not ItemRow._Details.link
                            or ItemRow._Details.link ~= AuctionRow._Details.link
                        ) then
                            return
                        end

                        ItemRow.toggleFavorite(AuctionRow._Details.isFavorite, false);
                    end)();
                end
            end
            Favorite:SetScript("OnMouseUp", function ()
                AuctionRow.toggleFavorite();
            end);

            --[[ ITEM ICON ]]
            ---@type Frame
            local Icon = CreateFrame("Frame", nil, AuctionRow);
            Icon:SetPoint("TOP", AuctionRow, "TOP");
            Icon:SetPoint("LEFT", Favorite, "RIGHT", 2, 0);
            Icon:SetSize(ITEM_ROW_HEIGHT, ITEM_ROW_HEIGHT);
            Interface:addTooltip(Icon, Item.link, "RIGHT");
            AuctionRow.Icon = Icon;

            Icon:SetScript("OnMouseUp", function (_, mouseButtonPressed)
                HandleModifiedItemClick(Item.link, mouseButtonPressed);
            end);

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
                local BOE = Interface:createFontString(Icon, L.BIND_ON_EQUIP_ABBR);
                BOE:SetPoint("TOPLEFT", Icon, "TOPLEFT", -3, -2);
                BOE:SetFont(.8, "OUTLINE");
                BOE:SetColor("UNCOMMON");
            end

            local BidInput, AdminButton;
            if (Auctioneer:auctionStartedByMe()) then
                --[[ ACTION BUTTON ]]
                ---@type Button
                AdminButton = CreateFrame("Button", nil, AuctionRow);
                AdminButton:SetNormalTexture("Interface/AddOns/Gargul/Assets/Buttons/panel-cogwheel-up");
                AdminButton:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight", "ADD");
                AdminButton:SetPushedTexture("Interface/AddOns/Gargul/Assets/Buttons/panel-cogwheel-down");
                AdminButton:SetSize(27, 27);
                AdminButton:SetPoint("CENTER", AuctionRow, "CENTER");
                AdminButton:SetPoint("RIGHT", AuctionRow, "RIGHT");
                AdminButton:SetScript("OnClick", function ()
                    self:showAuctionAdminWindow(AuctionRow);
                end);
                Interface:addTooltip(AdminButton, L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION);
            end

            --[[ AUTO BID BUTTON ]]
            ---@type Button
            local AutoBidButton = Interface:dynamicPanelButton(AuctionRow);

            AutoBidButton:SetScale(.8);
            AutoBidButton.currentAmount = false;

            AutoBidButton.updateText = function ()
                if (AutoBidButton.currentAmount) then
                    AutoBidButton:SetText(L.STOP);
                else
                    AutoBidButton:SetText(L.AUTO);
                end

                AutoBidButton:SetHeight(27);
            end;
            AutoBidButton.updateText();

            Interface:addTooltip(AutoBidButton, function ()
                if (AutoBidButton.currentAmount) then
                    return (L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP):format(AutoBidButton.currentAmount);
                end

                local bid = tonumber(BidInput:GetText()) or 0;
                if (GL:lt(bid, .0002)) then
                    return L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE;
                end

                return (L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN):format(bid);
            end);

            local lockRow, unlockRow, lastBid = nil, nil, 0;
            AutoBidButton:SetScript("OnClick", function ()
                if (AutoBidButton.currentAmount) then
                    lockRow();
                    GL.GDKP.MultiAuction.Client:stopAutobid(auctionID, function (confirmed)
                        unlockRow();

                        if (not confirmed) then
                            return GL:notice((L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED):format(Item.link));
                        end

                        AutoBidButton.currentAmount = false;
                        AutoBidButton.updateText();
                    end);

                    return;
                end

                local bid = tonumber(BidInput:GetText()) or 0;
                bid = Client:roundBidToClosestIncrement(auctionID, bid);
                if (not Client:isBidValidForAuction(auctionID, bid)) then
                    return GL:error((L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID):format(Client:minimumBidForAuction(auctionID)));
                end

                lockRow();
                GL.GDKP.MultiAuction.Client:autobid(auctionID, bid, function (success)
                    unlockRow();

                    -- Apparently something went wrong whilst sending our previous bid
                    if (not success) then
                        GL:notice((L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED):format(Item.link));
                    end
                end);
                if (not AuctionRow._Details.isFavorite) then
                    AuctionRow.toggleFavorite();
                end

                AutoBidButton.currentAmount = bid;
                AutoBidButton.updateText();
            end);

            if (not AdminButton) then
                AutoBidButton:SetPoint("CENTER", AuctionRow, "CENTER");
                AutoBidButton:SetPoint("RIGHT", AuctionRow, "RIGHT");
            else
                AutoBidButton:SetPoint("RIGHT", AdminButton, "LEFT", -10, 0);
            end

            AuctionRow.AutoBidButton = AutoBidButton;

            --[[ BID BUTTON ]]
            ---@type Button
            local BidButton = Interface:dynamicPanelButton(AuctionRow);
            BidButton:SetScale(.8);
            BidButton:SetText(L.BID);
            BidButton:SetHeight(27);
            BidButton:SetPoint("RIGHT", AutoBidButton, "LEFT", -2, 0);

            BidButton:SetScript("OnClick", function ()
                local bid = tonumber(BidInput:GetText()) or 0;
                bid = Client:roundBidToClosestIncrement(auctionID, bid);
                if (not Client:isBidValidForAuction(auctionID, bid)) then
                    return GL:error((L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID):format(Client:minimumBidForAuction(auctionID)));
                end

                -- Crude throttle
                if (GL:lt(GetTime() - lastBid, 2)) then
                    return GL:notice(L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE);
                end

                lockRow();
                GL.GDKP.MultiAuction.Client:bid(
                    auctionID,
                    bid,
                    function (success)
                        unlockRow();

                        -- Apparently something went wrong whilst sending our previous bid
                        if (not success) then
                            GL:notice((L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED):format(Item.link));

                            return;
                        end

                        -- If we currently have a autobid that's lower than the amount we just bid then our autobid is no longer valid
                        if (AuctionRow.AutoBidButton.currentAmount
                            and GL:lte(AuctionRow.AutoBidButton.currentAmount, bid)
                        ) then
                            AutoBidButton.currentAmount = false;
                            AutoBidButton.updateText();
                        end
                    end
                );

                if (not AuctionRow._Details.isFavorite) then
                    AuctionRow.toggleFavorite();
                end
            end);

            --[[ BID INPUT ]]
            ---@type EditBox
            BidInput = Interface:numericInputBox(AuctionRow, nil, minimum, Client.AuctionDetails.precision or 0);
            BidInput:SetJustifyH("CENTER");
            BidInput:SetMaxLetters(7);
            BidInput:SetTextInsets(0, 14, 0, 0);
            BidInput:SetWidth(56);
            BidInput:SetPoint("CENTER", BidButton, "CENTER");
            BidInput:SetPoint("RIGHT", BidButton, "LEFT", -2, 0);
            AuctionRow.BidInput = BidInput;

            -- Gold Icon
            local BidInputGoldIcon = BidInput:CreateTexture(nil, "OVERLAY");
            BidInputGoldIcon:SetTexture("Interface/MoneyFrame/UI-GoldIcon");
            BidInputGoldIcon:SetPoint("RIGHT", -3, 0);
            BidInputGoldIcon:SetSize(11, 11);

            --[[ BID MINIMUM BUTTON ]]
            ---@type EditBox
            local BidMinimumButton = Interface:dynamicPanelButton(AuctionRow);
            BidMinimumButton:SetPoint("CENTER", BidInput, "CENTER");
            BidMinimumButton:SetPoint("RIGHT", BidInput, "LEFT", -10, 0);
            BidMinimumButton:SetScale(.8);
            BidMinimumButton:SetText(L.MIN);
            BidMinimumButton:SetHeight(27);
            BidMinimumButton:SetScript("OnClick", function ()
                BidInput:Clear();
                BidInput:ClearFocus();

                -- Player is already top bidder
                if (GL:iEquals(GL:tableGet(Client.AuctionDetails.Auctions[auctionID] or {}, "CurrentBid.player"), GL.User.fqn)) then
                    GL:notice((L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP):format(Client.AuctionDetails.Auctions[auctionID].link));

                    return;
                end

                -- Crude throttle
                if (GL:lt(GetTime() - lastBid, 2)) then
                    return GL:notice(L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE);
                end

                lockRow();
                local bid = Client:minimumBidForAuction(auctionID);
                GL.GDKP.MultiAuction.Client:bid(
                    auctionID,
                    bid,
                    function (success)
                        unlockRow();

                        -- Apparently something went wrong whilst sending our previous bid
                        if (not success) then
                            GL:notice((L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED):format(Item.link));

                            return;
                        end

                        -- If we currently have a autobid that's lower than the amount we just bid then our autobid is no longer valid
                        if (AuctionRow.AutoBidButton.currentAmount
                            and GL:lte(AuctionRow.AutoBidButton.currentAmount, bid)
                        ) then
                            AutoBidButton.currentAmount = false;
                            AutoBidButton.updateText();
                        end
                    end
                );

                if (not AuctionRow._Details.isFavorite) then
                    AuctionRow.toggleFavorite();
                end
            end);
            Interface:addTooltip(BidMinimumButton, L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP);

            lockRow = function ()
                lastBid = GetTime();
                BidButton:SetEnabled(false);
                BidMinimumButton:SetEnabled(false);
                AutoBidButton:SetEnabled(false);
                BidInput:Clear();
                BidInput:ClearFocus();
            end;

            unlockRow = function ()
                lastBid = GetTime(),
                BidButton:SetEnabled(true);
                BidMinimumButton:SetEnabled(true);
                AutoBidButton:SetEnabled(true);
            end;

            --[[ AUCTION STATUS HOLDER ]]
            local StatusHolder = CreateFrame("Frame", nil, AuctionRow);
            StatusHolder:SetPoint("TOP", AuctionRow, "TOP");
            StatusHolder:SetPoint("BOTTOM", AuctionRow, "BOTTOM");
            StatusHolder:SetPoint("RIGHT", BidMinimumButton, "LEFT", -4, 0);
            StatusHolder:SetWidth(100);

            Interface:addTooltip(StatusHolder, function()
                local TopBids = Client.AuctionDetails.Auctions[auctionID].BidsPerPlayer;
                if (GL:empty(TopBids)) then
                    return;
                end

                local Bids = {};
                for player, bid in pairs(TopBids) do
                    tinsert(Bids, {
                        player = GL:disambiguateName(player, { colorize = true, }),
                        amount = bid,
                    });
                end

                table.sort(Bids, function (a, b)
                    return a.amount > b.amount;
                end);

                local Lines = { L.BIDS };
                for _, Bid in pairs(Bids) do
                    tinsert(Lines, ("%s - %s%s"):format(Bid.player, Bid.amount, L.GOLD_INDICATOR));
                end

                return Lines;
            end);

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
                        statusText = (L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD):format(
                            Interface.Colors.SUCCESS,
                            GL:disambiguateName(AuctionDetails.CurrentBid.player, { colorize = true, }),
                            Interface.Colors.YELLOW,
                            AuctionDetails.CurrentBid.amount
                        );
                    else
                        statusText = (L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED):format(Interface.Colors.GRAY);
                    end
                elseif (hasBid) then
                    local bidByMe = GL:iEquals(AuctionDetails.CurrentBid.player, GL.User.fqn);

                    if (bidByMe) then
                        statusText = (L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID):format(
                            Interface.Colors.YELLOW,
                            AuctionDetails.CurrentBid.amount
                        );
                    else
                        statusText = (L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID):format(
                            Interface.Colors.YELLOW,
                            AuctionDetails.CurrentBid.amount,
                            GL:disambiguateName(AuctionDetails.CurrentBid.player, { colorize = true, })
                        );
                    end
                else
                    statusText = (L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID):format(Interface.Colors.YELLOW, minimum, Interface.Colors.YELLOW, increment);
                end

                AuctionRow.BidInput.updatePlaceholder(Client:minimumBidForAuction(auctionID));
                AuctionRow.StatusText:SetText(statusText);
            end

            ---@type FontString
            local Name = Interface:createFontString(AuctionRow, Item.link);
            Name:SetPoint("CENTER", Icon);
            Name:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
            Name:SetPoint("RIGHT", BidMinimumButton, "LEFT", -6, 0);
            Name:SetHeight(ITEM_ROW_HEIGHT);

            AuctionRow.addCountDownBar = function (time)
                local CountDownBar = LibStub("LibCandyBarGargul-3.0"):New(
                    "Interface/AddOns/Gargul/Assets/Textures/timer-bar",
                    AuctionRow:GetWidth(),
                    ITEM_ROW_HEIGHT
                );
                CountDownBar:SetParent(AuctionRow);
                CountDownBar:SetPoint("TOP", AuctionRow, "TOP");
                CountDownBar:SetPoint("RIGHT", AuctionRow, "RIGHT");
                CountDownBar:SetPoint("BOTTOM", AuctionRow, "BOTTOM");
                CountDownBar:SetPoint("LEFT", Icon, "RIGHT", 2, 0);
                CountDownBar:SetDuration(time);
                CountDownBar:SetColor(.8, .8, .8, .3); -- Reset color to gray
                CountDownBar:Set("type", "GDKP_MULTI_AUCTION_COUNTDOWN");
                --CountDownBar:Set("originalDuration", time);
                CountDownBar:Start();
                CountDownBar:SetFrameStrata(AuctionRow:GetFrameStrata());
                CountDownBar:SetFrameLevel(AuctionRow:GetFrameLevel() - 1);
                CountDownBar:SetTimeVisibility(false);
                AuctionRow.CountDownBar = CountDownBar;
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

                    CountDownBar = nil;
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

    self.BidDetails:SetText((L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL):format(GL:count(Client.AuctionDetails.Auctions), totalSold, boughtByMe + bidByMe));
    self.BidDetails:SetColor("GRAY");
    Interface:addTooltip(self.BidDetails, (L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP):format(
        items - noBids,
        items,
        totalSold,
        boughtByMe,
        totalBid,
        bidByMe
    ));
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

--- Reset the vertical scroll of the auction frame
---
---@return void
function ClientInterface:resetScroll()
    return self.ScrollFrame and self.ScrollFrame:SetVerticalScroll(0) or nil;
end

--- Sort auctions, filter them by all the possible filters
---
---@return void
function ClientInterface:filterAndSort()
    local rowsShown = 0;
    local showInactive = self.showInactive;
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
        ItemRow:SetAlpha(0);
        ItemRow:SetHeight(1);
        ItemRow.Icon:SetSize(1, 1);
        ItemRow:ClearAllPoints();
        ItemRow:SetPoint("BOTTOMRIGHT", AuctionHolder, "BOTTOMRIGHT");

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

                -- Hide inactive items
                or (not showInactive and ItemRow._Details.endsAt <= 0)

                -- Only show favorited items
                or (showFavorites and not ItemRow._Details.isFavorite)
            ) then
                return;
            end

            -- Item filters
            if (self.enableFilters) then
                -- Hide unusable items
                if (not ItemRow._Details.canUseItem
                    and Settings:get("GDKP.MultiAuction." .. GL.User.id .. ".Filters.unusable") == true
                ) then
                    return;
                end

                -- Hide BOEs
                if (ItemRow._Details.isBOE
                    and Settings:get("GDKP.MultiAuction." .. GL.User.id .. ".Filters.BOE") == true
                ) then
                    return;
                end

                -- Hide unwanted armor types
                if (ItemRow._Details.classID == Enum.ItemClass.Armor
                    and ItemRow._Details.inventoryType ~= "INVTYPE_CLOAK"
                    and Settings:get(("GDKP.MultiAuction." .. GL.User.id .. ".Filters.%s-%s"):format(Enum.ItemClass.Armor, ItemRow._Details.subclassID)) == true
                ) then
                    return;
                end

                -- Hide unwanted item modifiers
                local FilteredMods = Settings:get("GDKP.MultiAuction." .. GL.User.id .. ".Filters.Mods");
                if (not GL:empty(FilteredMods)) then
                    local ItemMods = GL:itemModifiers(ItemRow._Details.link);

                    if (ItemMods) then
                        for filteredMod in pairs(FilteredMods or {}) do
                            if (ItemMods[filteredMod]) then
                                return;
                            end
                        end
                    end
                end
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
        ItemRow.Icon:SetSize(ITEM_ROW_HEIGHT, ITEM_ROW_HEIGHT);
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
    self:resetScroll();
end

--- Update countdown bars when anti snipes hit, when the auctioneer changes something or when the auction starts
---
---@return void
function ClientInterface:refresh(forceFilterAndSort)
    if (not self:getWindow()) then
        return;
    end

    forceFilterAndSort = forceFilterAndSort == true;
    local rowsChanged = false;
    local serverTime = GetServerTime();
    for auctionID, Details in pairs(Client.AuctionDetails.Auctions or {}) do
        local AuctionRow = self.AuctionRows[auctionID];

        (function()

            if (not AuctionRow) then
                rowsChanged = true;

                return self:addAuction(Details);
            end

            --- We need to update the timer bar
            if (AuctionRow._Details.endsAt ~= Details.endsAt) then
                AuctionRow._Details.endsAt = Details.endsAt;

                -- The auction was deleted, stop the countdown and remove the auction row
                if (Details.endsAt <= -1) then
                    rowsChanged = true;
                    AuctionRow.stopCountdown();
                    return;
                end

                -- The auction was closed, stop the countdown
                if (Details.endsAt == 0) then
                    AuctionRow.stopCountdown();
                    return;
                end

                -- Shouldn't be possible, but still stop the countdown
                if (Details.endsAt <= serverTime) then
                    AuctionRow.stopCountdown();
                    return;
                end

                local CountDownBar = AuctionRow.CountDownBar;

                -- Make absolutely sure the bar is not stopped or stopping before we increase its duration
                if (type(CountDownBar) == "table"
                    and CountDownBar.Get
                    and CountDownBar:Get("type") == "GDKP_MULTI_AUCTION_COUNTDOWN"
                    and not CountDownBar:Get("stopping")
                    and CountDownBar.running
                    and CountDownBar.remaining > 0
                ) then
                    local duration = Details.endsAt - serverTime;
                    CountDownBar:SetDuration(duration);
                    CountDownBar:Start();

                    -- Use this if you want to keep the original bar length as reference
                    --CountDownBar:Start(CountDownBar:Get("originalDuration") or duration);
                    self:setAuctionBarColor(AuctionRow, Details);
                elseif (not self.AuctionRows[auctionID].addingBar) then
                    AuctionRow.stopCountdown();

                    self.AuctionRows[auctionID].addingBar = true;
                    GL:after(.5, "GDKP_MULTI_AUCTION_CLIENT_ADD_BAR_FOR_" .. auctionID, function ()
                        AuctionRow.addCountDownBar(Client.AuctionDetails.Auctions[auctionID].endsAt - GetServerTime());
                        self:setAuctionBarColor(AuctionRow, Details);

                        GL:after(.2, "GDKP_MULTI_AUCTION_CLIENT_STOP_ADDING_BAR_FOR_" .. auctionID, function ()
                            self.AuctionRows[auctionID].addingBar = false;
                        end);
                    end);
                end
            else
                self:setAuctionBarColor(AuctionRow, Details);
            end

        end)();

        if (AuctionRow and AuctionRow.updateStatus) then
            AuctionRow.updateStatus();
        end
    end

    if (rowsChanged or forceFilterAndSort) then
        self:filterAndSort();
    end

    self:refreshAdminWindow();
    self:updateBidDetails();
end

--- Update the color of the countdown bar to reflect the player's bidding status
---
---@param AuctionRow Frame
---@oaram Details table
---
---@return void
function ClientInterface:setAuctionBarColor(AuctionRow, Details)
    if (AuctionRow.CountDownBar and AuctionRow.CountDownBar.SetColor) then
        if (GL:iEquals(GL:tableGet(Details, "CurrentBid.player"), GL.User.fqn)) then
            AuctionRow.CountDownBar:SetColor(0, 1, 0, .5); -- Set to green
        elseif (Details.iWasOutBid) then
            AuctionRow.AutoBidButton.currentAmount = false;
            AuctionRow.CountDownBar:SetColor(1, 0, 0, .5); -- Set to red
        else
            AuctionRow.AutoBidButton.currentAmount = false;
            AuctionRow.CountDownBar:SetColor(.8, .8, .8, .3); -- Set to gray
        end

        AuctionRow.AutoBidButton.updateText();
    end
end

---@return Frame
function ClientInterface:getWindow()
    return _G[self.windowName];
end