local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type Interface
local Interface = GL.Interface;

---@type Settings
local Settings = GL.Settings;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPMultiAuctionClient
local Client = GL.GDKP.MultiAuction.Client;

---@type GDKPSession
local Session = GL.GDKP.Session;

---@type GroupVersionCheckInterface
local GroupVersionCheck = GL.Interface.GroupVersionCheck;

---@class GDKPMultiAuctionAuctioneerInterface
GL:tableSet(GL, "Interface.GDKP.MultiAuction.Auctioneer", {
    windowName = "Gargul.Interface.GDKP.MultiAuction.Auctioneer.Window",

    ItemHolder = nil,
    ItemRows = {},
    Search = nil,
    SelectAll = nil,
});

---@type GDKPMultiAuctionAuctioneerInterface
local Auctioneer = GL.Interface.GDKP.MultiAuction.Auctioneer;

--[[ CONSTANTS ]]
local ITEM_ROW_HEIGHT = 20;
local WINDOW_WIDTH = 435;
local WINDOW_HEIGHT = 333;
local FONT;

---@return Frame|nil
function Auctioneer:open(keepPreviousItems)
    if (self:isShown()) then
        return;
    end

    keepPreviousItems = keepPreviousItems == true;
    if (not GL.GDKP.MultiAuction.Auctioneer:userIsAllowedToBroadcast()) then
        GL:warning(L["You need to be the master looter or have an assist / lead role!"])
        return;
    end

    local ActiveSession = Session:getActive();
    if (not ActiveSession or ActiveSession.lockedAt) then
        GL:warning(L["You need to have an active (unlocked) GDKP session!"]);
        Interface.GDKP.Overview:open();

        return;
    elseif (GL.GDKP.MultiAuction.Auctioneer:hasRunningAuctions()) then
        GL:warning(L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"]);
    end

    if (GL.Version.isOutOfDate) then
        GL:warning(L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"]);
    end

    FONT = GL.FONT;

    local Window = self:getWindow() or self:build();

    if (not keepPreviousItems) then
        self:clearItems();
        GL.GDKP.MultiAuction.Auctioneer:fillFromInventory(
            Settings:get("GDKP.MultiAuction.minimumFillQuality"),
            Settings:get("GDKP.MultiAuction.minimumFillItemLevel"),
            Settings:get("GDKP.MultiAuction.includeBOEs"),
            Settings:get("GDKP.MultiAuction.includeAwarded"),
            Settings:get("GDKP.MultiAuction.includeMaterials")
        );
    end

    -- Show the correct session details
    local guild = "";
    local CreatedBy = ActiveSession.CreatedBy or { class = "priest", name = "unknown", guild = "unknown", uuid = "unknown"};
    if (CreatedBy.guild) then
        guild = string.format(" |c001EFF00<%s>|r", CreatedBy.guild);
    end
    self.SessionDetails:SetText(string.format(
        L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"],
        ActiveSession.title,
        GL:nameFormat{ name = CreatedBy.name, realm = CreatedBy.realm, colorize = true, },
        guild,
        date(L["%Y-%m-%d"], ActiveSession.createdAt)
    ));

    return Window:Show() and Window;
end

---@return void
function Auctioneer:close()
    local Window = self:getWindow() or self:build();

    Window:Hide();
end

---@return boolean
function Auctioneer:isShown()
    local Window = self:getWindow();

    return Window and Window:IsShown();
end

---@return void
function Auctioneer:addItemByLink(itemLink)
    local Window = self:getWindow();

    if (not Window) then
        return false;
    end

    Window:addItemByLink(itemLink);
end

---@return Frame
function Auctioneer:build()
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
        { text = L["Adjust Scale"], notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end },
    }, 100);

    local HelpFrame = CreateFrame("Frame", nil, Window);
    HelpFrame:SetPoint("TOPRIGHT", Window, "TOPRIGHT", -34, -23);
    HelpFrame:SetSize(50, 20);

    ---@type Texture
    local highlight = HelpFrame:CreateTexture(nil, "HIGHLIGHT")
    highlight:SetAllPoints(HelpFrame);
    highlight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight")
    highlight:SetBlendMode("ADD");

    Interface:addTooltip(HelpFrame, (L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"]):format(GL.Settings:get("ShortcutKeys.rollOffOrAuction")), "BOTTOM");

    --[[ ICON ]]
    local texturePath = "interface/friendsframe/informationicon";

    ---@type Button
    local Icon = CreateFrame("Button",nil, Window);
    Icon:SetSize(12, 12);
    Icon:SetPoint("TOPLEFT", HelpFrame, "TOPLEFT");

    ---@type Texture
    local image = Icon:CreateTexture(nil, "BACKGROUND")
    image:SetWidth(12)
    image:SetHeight(12)
    image:SetAllPoints(Icon)
    image:SetTexture(texturePath);

    --[[ INFO ]]
    ---@type FontString
    local InfoLabel = Interface:createFontString(HelpFrame, L["Info"]);
    InfoLabel:SetPoint("TOPLEFT", HelpFrame, "TOPLEFT", 15, -1);

    ---@type Frame
    local ItemHolder

    ---@type ScrollFrame
    local ScrollFrame;

    --[[ GDKP SESSION DETAILS ]]
    ---@type FontString
    local SessionDetails = Interface:createFontString(Window);
    SessionDetails:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -24);
    SessionDetails:SetFont(.9);
    self.SessionDetails = SessionDetails;

    --[[ SELECT ALL ]]
    ---@type CheckButton
    local SelectAll = Interface:createCheckbox{
        Parent = Window,
        checked = false,
        callback = function (_, value)
            for _, Row in pairs(self.ItemRows or {}) do
                local alpha = tonumber(Row.GetAlpha and Row:GetAlpha() or 0) or 0;
                if (Row and Row._Select and alpha > 0) then
                    Row._Select:SetChecked(value);
                end
            end
        end,
    };
    SelectAll:SetPoint("TOPLEFT", SessionDetails, "BOTTOMLEFT", 0, -8);
    Interface:addTooltip(SelectAll, L["Select / Disable all"]);
    self.SelectAll = SelectAll;

    --[[ SEARCH ]]
    ---@type EditBox
    local Search = Interface:inputBox(Window, nil, L["Search name or iLVL"]);
    Search:SetWidth(150);
    Search:SetPoint("TOPLEFT", SelectAll, "TOPRIGHT", 20, 0);
    self.Search = Search;
    Interface:addTooltip(Search, L["Supports item names and iLVL e.g. '252', '<252' etc"]);

    Search:SetScript("OnTextChanged", function ()
        GL:after(.5, "GDKP_MULTI_AUCTION_AUCTIONEER_FILTER_CHANGED", function ()
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
    Interface:addTooltip(SearchClear, L["Clear"]);

    --[[ INCREMENT ]]
    ---@type FontString
    local IncLabel = Interface:createFontString(Window, L["Increment"]);
    IncLabel:SetPoint("CENTER", Search, "CENTER");
    IncLabel:SetPoint("RIGHT", Window, "RIGHT", -50, 0);

    --[[ MINIMUM BID ]]
    ---@type FontString
    local MinLabel = Interface:createFontString(Window, L["Minimum"]);
    MinLabel:SetPoint("TOPRIGHT", IncLabel, "TOPLEFT", -20, 0);

    --[[ SCROLLFRAME BOILERPLATE ]]
    ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOP", SelectAll, "BOTTOM", 0, -10);
    ScrollFrame:SetPoint("BOTTOM", Window, "BOTTOM", 0, 100);
    ScrollFrame:SetPoint("LEFT", Window, "LEFT", 16, 0);
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

    --[[ ADD AN ITEM TO THE WINDOW ]]
    Window.addItemByLink = function (_, link)
        GL:onItemLoadDo(link, function (Details)
            if (not Details) then
                return;
            end

            ---@type Frame
            local ItemRow = CreateFrame("Frame", nil, ItemHolder);
            ItemRow:EnableMouse(true);
            ItemRow._Details = Details;

            ---@type table
            local PerItemSettings = GDKP:settingsForItemID(Details.id);
            ItemRow:SetHeight(ITEM_ROW_HEIGHT);

            ItemRow:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 20, ((GL:count(self.ItemRows) * 20) * -1)  - 4);
            ItemRow:SetPoint("TOPRIGHT", ItemHolder, "TOPRIGHT", not GL.elvUILoaded and 0 or -4, 0);

            --[[ SELECT ]]
            ---@type CheckButton
            local Select = Interface:createCheckbox{
                Parent = ItemRow,
                checked = false,
            };
            ItemRow._Select = Select;
            Select:SetPoint("TOP", ItemRow, "TOP", 0, 2);
            Select:SetPoint("LEFT", SelectAll, "LEFT", 0, 0);

            ItemRow:SetScript("OnMouseUp", function ()
                Select:toggle();
            end);

            --[[ ITEM ICON ]]
            ---@type Frame
            local Icon = CreateFrame("Frame",nil, ItemRow);
            Icon:SetPoint("TOP", ItemRow, "TOP");
            Icon:SetPoint("LEFT", Search, "LEFT", -4, 0);
            Icon:SetSize(ITEM_ROW_HEIGHT - 4, ITEM_ROW_HEIGHT - 4);

            Interface:addTooltip(Icon, Details.link);

            ItemRow.Icon = Icon;

            ---@type Texture
            local Image = Icon:CreateTexture(nil, "BACKGROUND")
            Image:SetAllPoints(Icon);
            Image:SetTexture(Details.icon);

            --[[ ITEM LEVEL ]]
            if (Details.level) then
                ---@type FontString
                local ItemLevel = Interface:createFontString(Icon, Details.level);
                ItemLevel:SetPoint("BOTTOMLEFT", Icon, "BOTTOMLEFT", -3, -1);
                ItemLevel:SetFont(.8, "OUTLINE");
                ItemLevel:SetColor("ROGUE");
            end

            --[[ BOE ]]
            if (GL:inTable({ Enum.ItemBind.OnEquip, Enum.ItemBind.Quest }, Details.bindType)) then
                ---@type FontString
                local BOE = Interface:createFontString(Icon, L["BOE"]);
                BOE:SetPoint("TOPLEFT", Icon, "TOPLEFT", -3, 3);
                BOE:SetFont(.8, "OUTLINE");
                BOE:SetColor("UNCOMMON");
            end

            --[[ MINIMUM ]]
            ---@type EditBox
            local MinInput = Interface:numericInputBox(ItemRow, nil, nil, Settings:get("GDKP.precision"));
            MinInput:SetText(PerItemSettings.minimum);
            MinInput:SetWidth(42);
            MinInput:SetPoint("TOP", ItemRow, "TOP");
            MinInput:SetPoint("LEFT", MinLabel, "LEFT", 5, 0);
            MinInput:SetPoint("RIGHT", MinLabel, "RIGHT", 4, 0);
            ItemRow.MinInput = MinInput;

            --[[ INCREMENT ]]
            ---@type EditBox
            local IncInput = Interface:numericInputBox(ItemRow, nil, nil, Settings:get("GDKP.precision"));
            IncInput:SetText(PerItemSettings.increment);
            IncInput:SetWidth(36);
            IncInput:SetPoint("TOP", ItemRow, "TOP");
            IncInput:SetPoint("LEFT", IncLabel, "LEFT", 5, 0);
            IncInput:SetPoint("RIGHT", IncLabel, "RIGHT", 4, 0);
            ItemRow.IncInput = IncInput;

            ---@type FontString
            local Name = Interface:createFontString(ItemRow, Details.link);
            Name:SetPoint("CENTER", Icon);
            Name:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
            Name:SetPoint("RIGHT", MinInput, "LEFT", -6, 0);
            Name:SetHeight(20);

            tinsert(self.ItemRows, ItemRow);
        end);
    end;

    --[[ HOW TO ADD ITEMS ]]
    ---@type FontString
    local AddItemsLabel = Interface:createFontString(Window, (L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"]):format(GL.Settings:get("ShortcutKeys.rollOffOrAuction")));
    AddItemsLabel:SetFont(.8, "OUTLINE");
    AddItemsLabel:SetColor("GRAY");
    AddItemsLabel:SetPoint("TOPLEFT", ScrollFrame, "BOTTOMLEFT", 10, -10);

    --[[ TIME ]]
    ---@type FontString
    local TimeLabel = Interface:createFontString(Window, L["Auction time in seconds"]);
    TimeLabel:SetPoint("TOPLEFT", AddItemsLabel, "BOTTOMLEFT", 0, -6);

    ---@type EditBox
    local TimeInput = Interface:inputBox(Window);
    TimeInput:SetNumeric(true);
    TimeInput:SetText(Settings:get("GDKP.MultiAuction.time"));
    TimeInput:SetWidth(30);
    TimeInput:SetPoint("TOPLEFT", TimeLabel, "TOPRIGHT", 8, 4);
    Window._TimeInput = TimeInput;


    --[[ ANTI SNIPE ]]
    ---@type FontString
    local AntiSnipeLabel = Interface:createFontString(Window, L["Anti snipe in seconds"]);
    AntiSnipeLabel:SetPoint("CENTER", TimeLabel, "CENTER");
    AntiSnipeLabel:SetPoint("LEFT", TimeInput, "RIGHT", 4, 0);

    ---@type EditBox
    local AntiSnipeInput = Interface:inputBox(Window);
    AntiSnipeInput:SetNumeric(true);
    AntiSnipeInput:SetText(Settings:get("GDKP.MultiAuction.antiSnipe"));
    AntiSnipeInput:SetWidth(20);
    AntiSnipeInput:SetPoint("TOPLEFT", AntiSnipeLabel, "TOPRIGHT", 8, 4);
    Interface:addTooltip(AntiSnipeInput, L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"]);
    Window._AntiSnipeInput = AntiSnipeInput;

    --[[ CLEAR ]]
    ---@type Button
    local Clear = Interface:dynamicPanelButton(Window, L["Clear"]);
    Clear:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 30);
    Clear:SetScript("OnClick", function ()
        self:clearItems();
    end);
    Interface:addTooltip(Clear, L["Remove all items from the list"]);

    --[[ FILL FROM INVENTORY ]]
    ---@type Button
    local FillFromInventory = Interface:dynamicPanelButton(Window, L["Fill from inventory"]);
    FillFromInventory:SetPoint("TOPLEFT", Clear, "TOPRIGHT", 2, 0);
    FillFromInventory:SetScript("OnClick", function ()
        GL.Interface.GDKP.MultiAuction.FillFromInventory:open();
    end);
    Interface:addTooltip(FillFromInventory, L["Add tradeable items from your inventory to the list"]);

    --[[ NEXT STEP ]]
    ---@type Button
    local Next = Interface:dynamicPanelButton(Window, L["Next"]);
    Next:SetPoint("CENTER", FillFromInventory, "CENTER");
    Next:SetPoint("RIGHT", Window, "RIGHT", -20, 0);
    Next:SetScript("OnClick", function ()
        local itemsWereChecked = (function()
            for _, Row in pairs(self.ItemRows or {}) do
                if (Row and Row._Select) then
                    if (Row._Select:GetChecked()) then
                        return true;
                    end
                end
            end

            return false;
        end)();

        if (not itemsWereChecked) then
            GL:error(L["Select at least one item for your auction"]);

            return;
        end

        local duration = tonumber(string.trim(Window._TimeInput:GetText())) or 0;
        if (duration < 10) then
            GL:error(L["The auction time in seconds needs to be >= 10"]);

            return;
        end

        local antiSnipe = tonumber(string.trim(Window._AntiSnipeInput:GetText())) or 0;
        if (antiSnipe < 0 or (antiSnipe > 0 and antiSnipe < 5)) then
            GL:error(L["The anti snipe value needs to be 0 (empty) or >=5"]);

            return;
        end

        -- In case we already have running auctions then there's no reason to check player versions
        if (GL.GDKP.MultiAuction.Auctioneer:hasRunningAuctions()) then
            self:start();

            self:close();
            return Window;
        end

        GroupVersionCheck:open({
            {
                text = L["Cancel"],
                onClick = function ()
                    GroupVersionCheck:close();
                    self:open(true);
                end,
                tooltip = L["Go back to the item selector"],
            },
            {
                text = L["Start"],
                onClick = function (Results)
                    -- Everyone is up-to-date on Gargul, start!
                    if (GL:empty(Results.Unresponsive)) then
                        self:start();
                        GroupVersionCheck:close();

                        if (not GL:empty(Results.Outdated)) then
                            GL:warning(L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"]);
                        end

                        return;
                    end

                    -- Start after double-checking if the user is OK with people missing out
                    Interface.Dialogs.PopupDialog:open{
                        question = L["Not everyone is using Gargul, are you sure you want to start the auction?"],
                        OnYes = function ()
                            self:start();
                            GroupVersionCheck:close();
                        end,
                    };
                end,
                tooltip = L["Start"],
            },
        });

        self:close();
    end);
    Interface:addTooltip(Next, L["Next step: check raider's add-on version for compatibility"]);

    return Window;
end

---@return void
function Auctioneer:clearItems()
    local Window = self:getWindow();

    if (not Window) then
        return;
    end

    for key, Item in pairs(self.ItemRows or {}) do
        Interface:release(Item);
        self.ItemRows[key] = nil;
    end

    self.ItemRows = {};
end

--- Sort auctions, filter them by all the possible filters
---
---@return void
function Auctioneer:filterAndSort()
    self.SelectAll:SetChecked(false);

    local filterValue = self.Search:GetText();
    local rowsShown = 0;
    local ItemHolder = self.ItemHolder;
    local RowsToShow = {};
    local filterConcernsLevel = false;
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
            -- Make sure we have all the required data and the auction is still active
            if (not ItemRow._Details
                or not ItemRow._Details.level
                or not ItemRow._Details.name
                or not ItemRow._Details.quality
            ) then
                return;
            end

            local itemLevel = ItemRow._Details.level;
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
        if (a._Details.level == b._Details.level) then
            if (a._Details.quality ~= b._Details.quality) then
                return a._Details.quality > b._Details.quality;
            end

            return a._Details.name < b._Details.name;
        end

        return a._Details.level > b._Details.level;
    end);

    ---@param ItemRow Frame
    for _, ItemRow in pairs(RowsToShow or {}) do
        ItemRow:ClearAllPoints();
        ItemRow:SetAlpha(1);
        ItemRow:SetHeight(ITEM_ROW_HEIGHT);

        -- The -4 is needed to accomodate for a potential "BOE" flag on an item icon!
        ItemRow:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 20, ((rowsShown * ITEM_ROW_HEIGHT) * -1) - 4);
        ItemRow:SetPoint("RIGHT", ItemHolder, "RIGHT", not GL.elvUILoaded and 0 or -4, 0);

        rowsShown = rowsShown + 1;
    end
end

---@return void
function Auctioneer:start()
    local ItemsUpForAuction = {};

    ---@type Frame
    local Window = self:getWindow();
    if (not Window) then
        GL:error(L["Something went wrong!"]);
        return;
    end

    local duration = tonumber(string.trim(Window._TimeInput:GetText())) or 0;
    if (duration < 10) then
        GL:error(L["The auction time in seconds needs to be >= 10"]);

        return;
    end

    local antiSnipe = tonumber(string.trim(Window._AntiSnipeInput:GetText())) or 0;
    if (antiSnipe < 0 or (antiSnipe > 0 and antiSnipe < 5)) then
        GL:error(L["The anti snipe value needs to be 0 (empty) or >=5"]);

        return;
    end

    -- Check which items were selected and get their minimum/increment
    local itemsWereChecked = false;
    for _, ItemRow in pairs(self.ItemRows or {}) do
        (function()
            if (type(ItemRow) ~= "table" or not ItemRow._Details.link
                or (ItemRow._Select and not ItemRow._Select:GetChecked())
            ) then
                return;
            end

            local itemID = GL:getItemIDFromLink(ItemRow._Details.link);
            if (not itemID) then
                return;
            end

            tinsert(ItemsUpForAuction, {
                link = ItemRow._Details.link,
                minimum = tonumber(ItemRow.MinInput:GetText()) or 0,
                increment = tonumber(ItemRow.IncInput:GetText()) or 0,
            });

            itemsWereChecked = true;
        end)();
    end

    if (not itemsWereChecked) then
        GL:error(L["Select at least one item for your auction"]);

        return;
    end

    Settings:set("GDKP.MultiAuction.time", duration);
    Settings:set("GDKP.MultiAuction.antiSnipe", antiSnipe);

    -- We still have running auctions, add the selected items to our current session
    if (GL.GDKP.MultiAuction.Auctioneer:hasRunningAuctions()) then
        for _, Details in pairs(ItemsUpForAuction or {}) do
            GL.GDKP.MultiAuction.Client:addToCurrentSession{
                link = Details.link,
                duration = duration,
                minimum = Details.minimum,
                increment = Details.increment,
            };
        end

        return;
    end

    -- Make sure we're out of combat before starting the MultiAuction
    GL:afterCombatDo(function ()
        GL.GDKP.MultiAuction.Auctioneer:start(ItemsUpForAuction, duration, antiSnipe);
    end, function ()
        GL:notice(L["You are currently in combat, delaying broadcast"]);
    end);

    -- Clear the item selection window
    self:clearItems();
    self.SelectAll:SetChecked(false);
end

---@return Frame
function Auctioneer:getWindow()
    return _G[self.windowName];
end