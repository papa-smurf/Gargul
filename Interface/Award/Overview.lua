local L = Gargul_L;

---@type GL
local _, GL = ...;

---@type DB
local DB = GL.DB;

---@type Interface
local Interface = GL.Interface;

---@type Constants
local Constants = GL.Data.Constants;

GL.Interface.Award = GL.Interface.Award or {};
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

---@class AwardOverviewInterface
GL.Interface.Award.Overview = {
    ---@type string
    phrase = "",

    ---@type string
    windowName = "Gargul.Interface.Award.Overview.Window",

    ---@type table
    DatesTable = {},

    ---@type Frame|nil
    ItemHolder = nil,

    ---@type table
    ItemRows = {},

    ---@type table|nil
    RefreshTimer = nil,

    ---@type table
    SelectedDates = {},
};
local Overview = GL.Interface.Award.Overview;

--[[ CONSTANTS ]]
local DEFAULT_WINDOW_HEIGHT = 406;
local DEFAULT_WINDOW_WIDTH = 660;
local DEFAULT_TABLE_ROWS = 18;
local HEIGHT_PER_TABLE_ROW = 18;
local ITEM_ROW_HEIGHT = 24;

---@return table|nil
function Overview:open()
    local Window = _G[self.windowName] or self:build();
    self:refreshDatesTable();
    self:refreshItems();

    Window:Show();
    return Window;
end

---@return void
function Overview:close()
    return _G[self.windowName] and _G[self.windowName]:Hide();
end

---@return Frame
function Overview:build()
    if (_G[self.windowName]) then
        return _G[self.windowName];
    end

    ---@type Frame
    local Window = Interface:createWindow{
        name = self.windowName,
        width = DEFAULT_WINDOW_WIDTH,
        height = DEFAULT_WINDOW_HEIGHT,
        minWidth = 500,
        minHeight = 239,
        maxWidth = DEFAULT_WINDOW_WIDTH,
        maxHeight = 700,
        hideMinimizeButton = true,
    };

    --[[ ADD THE SETTINGS MENU IN THE TOP LEFT OF THE WINDOW ]]
    Interface:addWindowOptions(Window, {
        { text = L.TUTORIAL, notCheckable = true, func = function ()
            GL:popupMessage(L.TUTORIAL_AWARD_OVERVIEW, Window);
            CloseMenus();
        end },
        "divider",
        { text = L.WINDOW, isTitle = true, notCheckable = true },
        { text = L.CHANGE_SCALE, notCheckable = true, func = function ()
            Interface:openScaler(Window);
            CloseMenus();
        end },
    });

    --[[ DATE TABLE ]]
    local Table = self:buildDatesTable(Window);
    Table.frame:SetPoint("TOPLEFT", Window, "TOPLEFT", 20, -20);
    self.DatesTable = Table;

    do --[[ DATE TOGGLER BUTTON ]]
        local originalTableWidth = Table.frame:GetWidth();
        local shown = true;
        local closedCoords = { 0.03125, 0.46875, 0.0078125, 0.9921875 };
        local openedCoords = { 0.53125, 0.96875, 0.0078125, 0.9921875 };

        ---@type Button
        local ToggleDates = CreateFrame("Button", "Gargul.Interface.Award.Overview.ToggleQueue", Window);
        ToggleDates:SetSize(14,66);
        ToggleDates:SetPoint("CENTER", Table.frame);
        ToggleDates:SetPoint("LEFT", Table.frame, "LEFT", -24, 0);
        ToggleDates:SetScript("OnClick", function ()
            if (shown) then
                Table.frame:SetWidth(.1);
                Table.frame:SetAlpha(0);
                ToggleDates.texture:SetTexCoord(unpack(closedCoords));
                shown = false;
            else
                Table.frame:SetWidth(originalTableWidth);
                Table.frame:SetAlpha(1);
                ToggleDates.texture:SetTexCoord(unpack(openedCoords));
                shown = true;
            end
        end);

        ToggleDates.texture = ToggleDates:CreateTexture();
        ToggleDates.texture:SetAllPoints(ToggleDates)
        ToggleDates.texture:SetTexture("interface/raidframe/raidpanel-toggle");
        ToggleDates.texture:SetTexCoord(unpack(closedCoords));

        if (Table.frame:IsShown()) then
            ToggleDates.texture:SetTexCoord(unpack(openedCoords));
        end

        ToggleDates.highlightTexture = ToggleDates:CreateTexture(nil, "HIGHLIGHT");
        ToggleDates.highlightTexture:SetPoint("TOPLEFT", ToggleDates, "TOPLEFT", 3, -10);
        ToggleDates.highlightTexture:SetPoint("BOTTOMRIGHT", ToggleDates, "BOTTOMRIGHT", 2, 10);
        ToggleDates.highlightTexture:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight");
        ToggleDates.highlightTexture:SetTexCoord(0, 1, 0.23, 0.77);
        ToggleDates.highlightTexture:SetBlendMode("ADD");
        ToggleDates:SetHighlightTexture(ToggleDates.highlightTexture);

        Interface:addTooltip(ToggleDates, L.TOGGLE_DATES, "BOTTOMRIGHT");
    end

    --[[ SEARCH ]]
    ---@type EditBox
    local Search = Interface:inputBox(Window, nil, "Search by item or player name");
    Search:SetWidth(150);
    Search:SetPoint("TOPLEFT", Table.frame, "TOPRIGHT", 16, 0);
    self.Search = Search;

    Search:SetScript("OnTextChanged", function ()
        GL:after(.5, "AWARDED_LOOT_FILTER_CHANGED", function ()
            self.phrase = Search:GetText();
            self:refreshItems();
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


    --[[ SCROLLFRAME BOILERPLATE ]]
    local ScrollFrame = CreateFrame("ScrollFrame", nil, Window, "UIPanelScrollFrameTemplate")
    ScrollFrame:SetPoint("TOPLEFT", Table.frame, "TOPRIGHT", 16, -24);
    ScrollFrame:SetPoint("BOTTOMRIGHT", Window, "BOTTOMRIGHT", -44, 54);

    local ItemHolder = CreateFrame("Frame");
    ScrollFrame:SetScrollChild(ItemHolder);
    ItemHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    ItemHolder:SetPoint("TOPLEFT", ScrollFrame, "TOPLEFT");
    ItemHolder:SetPoint("BOTTOMRIGHT", ScrollFrame, "BOTTOMRIGHT");
    self.ItemHolder = ItemHolder;

    ---@type Frame
    local Items = CreateFrame("Frame", nil, ItemHolder);
    Items:SetAllPoints(ItemHolder);

    do --[[ DELETE BUTTON ]]
        ---@type Frame
        local DeleteButton = CreateFrame("Button", nil, ItemHolder, "UIPanelButtonTemplate");
        DeleteButton:SetSize(18, 18);

        ---@type Texture
        local NormalTexture = DeleteButton.normalTexture or DeleteButton:CreateTexture();
        NormalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/delete");
        NormalTexture:SetAllPoints(DeleteButton);
        DeleteButton:SetNormalTexture(NormalTexture);

        ---@type Texture
        local HighlightTexture = DeleteButton:CreateTexture();
        HighlightTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/delete");
        NormalTexture:SetAllPoints(DeleteButton);
        DeleteButton:SetHighlightTexture(HighlightTexture);

        Interface:addTooltip(DeleteButton, L.DELETE);

        self.DeleteButton = DeleteButton;
    end

    do --[[ DISENCHANT BUTTON ]]
        ---@type Frame
        local DisenchantButton = CreateFrame("Button", nil, ItemHolder, "UIPanelButtonTemplate");
        DisenchantButton:SetSize(18, 18);

        ---@type Texture
        local NormalTexture = DisenchantButton.normalTexture or DisenchantButton:CreateTexture();
        NormalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/disenchant");
        NormalTexture:SetAllPoints(DisenchantButton);
        DisenchantButton:SetNormalTexture(NormalTexture);

        ---@type Texture
        local HighlightTexture = DisenchantButton:CreateTexture();
        HighlightTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/disenchant");
        NormalTexture:SetAllPoints(DisenchantButton);
        DisenchantButton:SetHighlightTexture(HighlightTexture);

        Interface:addTooltip(DisenchantButton, L.DISENCHANT);

        self.DisenchantButton = DisenchantButton;
    end

    do --[[ EDIT BUTTON ]]
        ---@type Frame
        local EditButton = CreateFrame("Button", nil, ItemHolder, "UIPanelButtonTemplate");
        EditButton:SetSize(18, 18);

        ---@type Texture
        local NormalTexture = EditButton.normalTexture or EditButton:CreateTexture();
        NormalTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/edit");
        NormalTexture:SetAllPoints(EditButton);
        EditButton:SetNormalTexture(NormalTexture);

        ---@type Texture
        local HighlightTexture = EditButton:CreateTexture();
        HighlightTexture:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/edit");
        NormalTexture:SetAllPoints(EditButton);
        EditButton:SetHighlightTexture(HighlightTexture);

        Interface:addTooltip(EditButton, L.EDIT);

        self.EditButton = EditButton;
    end

    --[[ FOOTER BUTTONS ]]
    do
        local Export = Interface:dynamicPanelButton(Window, L.EXPORT);
        Export:SetPoint("BOTTOMLEFT", Window, "BOTTOMLEFT", 20, 28);

        Export:SetScript("OnClick", function ()
            self:close();
            GL.Exporter:draw();
        end);

        local Clear = Interface:dynamicPanelButton(Window, L.CLEAR);
        Clear:SetPoint("TOPLEFT", Export, "TOPRIGHT", 2, 0);

        Clear:SetScript("OnClick", function()
            -- No date is selected, delete everything!
            local warning, onConfirm;
            if (GL:empty(self.SelectedDates)) then
                warning = L.EXPORT_DELETE_ALL_CONFIRM;
                onConfirm = function()
                    DB:set("AwardHistory", {});
                    GL.Events:fire("GL.ITEM_UNAWARDED");

                    self:open();
                end;

            else -- Only delete entries on the selected date(s)
                warning = (L.EXPORT_DELETE_DATE_CONFIRM):format(
                    table.concat(self.SelectedDates, "|c00FFFFFF, |r")
                );
                onConfirm = function()
                    local SelectedDates = GL:tableFlip(self.SelectedDates);

                    for key, AwardEntry in pairs(DB:get("AwardHistory")) do
                        local dateString = date(L.DATE_FORMAT, AwardEntry.timestamp);

                        if (SelectedDates[dateString]) then
                            AwardEntry = nil;
                            DB:set("AwardHistory." .. key, nil);
                            GL.Events:fire("GL.ITEM_UNAWARDED");
                        end
                    end

                    self:open();
                end
            end

            -- Show a confirmation dialog before clearing entries
            GL.Interface.Dialogs.PopupDialog:open{
                question = warning,
                OnYes = function ()
                    onConfirm();

                    -- Let the application know that an item was unawarded (deleted)
                    GL.Events:fire("GL.ITEM_UNAWARDED");
                end,
            };
        end);
    end

    --[[ ADJUST COMPONENTS AFTER WINDOW RESIZE ]]
    Window:HookScript("OnSizeChanged", function (...)
        local extraVerticalRoomForTable = Window:GetHeight() - DEFAULT_WINDOW_HEIGHT;
        local additionalRows = math.floor(extraVerticalRoomForTable / HEIGHT_PER_TABLE_ROW);

        --[[ ADJUST ROWS ]]
        Table:SetDisplayRows(additionalRows + DEFAULT_TABLE_ROWS, HEIGHT_PER_TABLE_ROW);

        --[[ ADJUST ITEM LIST ]]
        ItemHolder:SetSize(ScrollFrame:GetWidth(), ( ScrollFrame:GetHeight() * 2 ));
    end);
    Window:GetScript("OnSizeChanged")();

    -- Make sure that the window is updated whenever an award changes
    GL.Events:register({
        {"AwardOverviewItemAwardedListener", "GL.ITEM_AWARDED" },
        {"AwardOverviewItemUnAwardedListener", "GL.ITEM_UNAWARDED" },
        {"AwardOverviewItemEditedListener", "GL.ITEM_AWARD_EDITED" },
        {"AwardOverviewItemEditedListener", "GL.ITEM_UNAWARDED" },
    }, function()
        GL.Ace:CancelTimer(self.RefreshTimer);
        self.RefreshTimer = GL.Ace:ScheduleTimer(function ()
            self:refreshItems();
        end, .3);
    end);

    return Window;
end

---@param Window Frame
---@return table
function Overview:buildDatesTable(Window)
    local Table = GL.ScrollingTable:CreateST({
        {
            width = 90,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        },
        {
            width = 0,
            sort = Constants.ScrollingTable.descending,
        }
    }, DEFAULT_TABLE_ROWS, HEIGHT_PER_TABLE_ROW, nil, Window, true);
    Table:EnableSelection(true);
    Table.head:Hide(); -- Remove the table header

    Table:RegisterEvents{
        OnClick = function(rowFrame, cellFrame, data, cols, row, realrow, column, table, button, ...)
            -- Even if we're still missing an answer from some of the group members
            -- we still want to make sure our inspection end after a set amount of time
            GL.Ace:ScheduleTimer(function()
                self.SelectedDates = {};
                for _, row in pairs(Table:GetSelection() or {}) do
                    local Row = Table:GetRow(row) or {};

                    if (Row["cols"]) then
                        local date = GL:tableGet(Row, "cols.1.value");

                        if (date) then
                            tinsert(self.SelectedDates, date);
                        end
                    end
                end

                self:refreshItems();
            end, .1);
        end
    };

    return Table;
end

---@return void
function Overview:refreshDatesTable()
    -- Fetch award history per date
    local AwardHistoryByDate = {};
    for _, AwardEntry in pairs(DB:get("AwardHistory") or {}) do
        local dateString = date(L.DATE_FORMAT, AwardEntry.timestamp);
        AwardHistoryByDate[dateString] = AwardEntry.timestamp;
    end

    local TableData = {};
    for date, timestamp in pairs(AwardHistoryByDate or {}) do
        local Row = {
            cols = {
                {
                    value = date,
                },
                {
                    value = timestamp,
                },
            },
        };

        --- Can't use simple format because it's not supported by multiselection
        tinsert(TableData, Row);
    end

    table.sort(TableData, function (a, b)
        return GL:tableGet(a, "cols.2.value", 0) > GL:tableGet(b, "cols.2.value", 0);
    end);

    self.DatesTable:SetData(TableData);

    if (GL:empty(self.SelectedDates)) then
        self.DatesTable:SetSelection(1);
        self.SelectedDates = { GL:tableGet(TableData, "1.cols.1.value") };
    end
end

function Overview:refreshItems()
    local phraseDefined = self.phrase and not GL:empty(self.phrase);
    local fiveHoursAgo = GetServerTime() - 18000;

    for key, ItemRow in pairs(self.ItemRows or {}) do
        Interface:release(ItemRow);
        self.ItemRows[key] = nil;
    end

    self.ItemRows = {};

    -- Nothing selected, nothing to show
    if (GL:empty(self.SelectedDates)) then
        return;
    end

    local SelectedDates = GL:tableFlip(self.SelectedDates);
    local Entries = {};
    for _, AwardEntry in pairs(DB:get("AwardHistory")) do
        local dateString = date(L.DATE_FORMAT, AwardEntry.timestamp);

        if (SelectedDates[dateString]
            and (not phraseDefined or (
                GL:strContains(AwardEntry.itemLink, self.phrase)
                or GL:strContains(AwardEntry.awardedTo, self.phrase)
            ))
        ) then
            local checksum = AwardEntry.checksum; -- Old entries may not possess a checksum yet
            if (not checksum) then
                checksum = GL:strPadRight(GL:strLimit(GL:stringHash(AwardEntry.timestamp .. AwardEntry.itemID) .. GL:stringHash(AwardEntry.awardedTo), 20, ""), "0", 20);
            end

            tinsert(Entries, {
                timestamp = AwardEntry.timestamp,
                awardedTo = AwardEntry.awardedTo,
                awardedBy = AwardEntry.awardedBy,
                BRCost = AwardEntry.BRCost,
                itemID = AwardEntry.itemID,
                itemLink = AwardEntry.itemLink,
                winnerClass = AwardEntry.winnerClass,
                winningRollType = AwardEntry.winningRollType,
                OS = AwardEntry.OS and 1 or 0,
                SR = AwardEntry.SR and 1 or 0,
                WL = AwardEntry.WL and 1 or 0,
                PL = AwardEntry.PL and 1 or 0,
                TMB = AwardEntry.TMB and 1 or 0,
                checksum = AwardEntry.checksum,
                received = AwardEntry.received,
                Rolls = AwardEntry.Rolls,
            });
        end
    end

    -- No entries found with the user's filters
    if (GL:empty(Entries)) then
        return;
    end

    GL:onItemLoadDo(GL:tableColumn(Entries, "itemLink"), function (Result)
        if (not Result) then
            return;
        end

        local ItemDetails = {};
        for _, Details in pairs(Result or {}) do
            ItemDetails[Details.id] = Details;
        end
        Result = nil;

        -- Sort newest to oldest
        table.sort(Entries, function (a, b)
            if (a.timestamp and b.timestamp) then
                return a.timestamp > b.timestamp;
            end

            return false;
        end);

        local ItemHolder = self.ItemHolder;
        local DeleteButton = self.DeleteButton;
        local EditButton = self.EditButton;
        local DisenchantButton = self.DisenchantButton;
        local classFilesByID = GL:tableFlip(Constants.UnitClasses);
        for _, Entry in pairs (Entries or {}) do
            (function ()
                local Item = ItemDetails[Entry.itemID];

                if (not Item) then
                    return;
                end

                -- Was this item disenchanted?
                local itemWasDisenchanted = Entry.awardedTo == GL.Exporter.disenchantedItemIdentifier;

                --[[ ADD THE ITEM TO THE UI ]]
                ---@type Frame
                local ItemRow = CreateFrame("Frame", nil, ItemHolder);
                ItemRow:SetHeight(ITEM_ROW_HEIGHT);
                ItemRow:SetPoint("TOPLEFT", ItemHolder, "TOPLEFT", 0, (#self.ItemRows * ITEM_ROW_HEIGHT) * -1);
                ItemRow:SetPoint("TOPRIGHT", ItemHolder, "TOPRIGHT", not GL.elvUILoaded and 0 or -4, 0);

                --[[ ITEM ICON ]]
                ---@type Frame
                local Icon = CreateFrame("Frame",nil, ItemRow);
                Icon:SetPoint("TOPLEFT", ItemRow, 0, -2);
                Icon:SetSize(ITEM_ROW_HEIGHT - 4, ITEM_ROW_HEIGHT - 4);

                ---@type Texture
                local Image = Icon:CreateTexture(nil, "BACKGROUND")
                Image:SetAllPoints(Icon);
                Image:SetTexture(Item.icon);

                Interface:addTooltip(Icon, Item.link);

                --[[ ITEM LINK ]]
                ---@type FontString
                local ItemLink = Interface:createFontString(ItemRow, Item.link);
                ItemLink:SetPoint("CENTER", ItemRow);
                ItemLink:SetPoint("LEFT", Icon, "RIGHT", 4, 0);
                ItemLink:SetWidth(180);
                ItemLink:SetHeight(ITEM_ROW_HEIGHT);

                --[[ AWARDED TO ]]
                local awardedToString = "";
                if (not itemWasDisenchanted) then
                    awardedToString = GL:nameFormat{ name = Entry.awardedTo, colorize = true, class = Entry.winnerClass and classFilesByID[Entry.winnerClass] or nil, };
                else
                    awardedToString = "DISENCHANTED";
                end

                ---@type FontString
                local AwardedTo = Interface:createFontString(ItemRow, awardedToString);
                AwardedTo:SetPoint("TOPLEFT", ItemLink, "TOPRIGHT", 4, 0);
                AwardedTo:SetWidth(80);
                AwardedTo:SetHeight(ITEM_ROW_HEIGHT);

                --[[ AWARD DETAILS ]]
                local AwardDetails = {};

                if (Entry.OS > 0) then
                    tinsert(AwardDetails, L.OFFSPEC_ABBR);
                end
                if (Entry.SR > 0) then
                    tinsert(AwardDetails, L.SOFTRES_ABBR);
                end
                if (Entry.WL > 0) then
                    tinsert(AwardDetails, L.WISHLIST_ABBR);
                end
                if (Entry.PL > 0) then
                    tinsert(AwardDetails, L.PRIOLIST_ABBR);
                end
                if (Entry.winningRollType) then
                    tinsert(AwardDetails, Entry.winningRollType);
                end
                if (Entry.OS == 0 and not Entry.winningRollType) then
                    tinsert(AwardDetails, L.MAINSPEC_ABBR);
                end

                ---@type FontString
                local DetailString = Interface:createFontString(ItemRow, table.concat(AwardDetails, " | "));
                DetailString:SetPoint("TOPLEFT", AwardedTo, "TOPRIGHT", 4, 0);
                DetailString:SetWidth(100);
                DetailString:SetHeight(ITEM_ROW_HEIGHT);

                --[[ MAKE AWARDING / DISENCHANTING ETC POSSIBLE ON CLICK ]]
                ItemRow:SetScript("OnMouseUp", function (_, mouseButtonPressed)
                    HandleModifiedItemClick(Item.link, mouseButtonPressed);
                end);

                --[[ DETAILS TOOLTIP ]]
                -- Show player details on hover
                local ItemsWonByRollerInTheLastFiveHours;
                ItemRow:SetScript("OnEnter", function()
                    local linesAdded = false;
                    GameTooltip:ClearLines();
                    GameTooltip:SetOwner(ItemHolder, "ANCHOR_NONE");
                    GameTooltip:SetPoint("TOPLEFT", ItemHolder, "TOPRIGHT", 30, 0);

                    if (not ItemsWonByRollerInTheLastFiveHours) then
                        ItemsWonByRollerInTheLastFiveHours = GL.AwardedLoot:byWinner(Entry.awardedTo, fiveHoursAgo);
                    end

                    if (not GL:empty(Entry.Rolls)) then
                        local rollsPerPlayer = {};

                        table.sort(Entry.Rolls, function (a, b)
                            if (a.time and b.time) then
                                return a.time < b.time;
                            end

                            return false;
                        end);

                        GameTooltip:AddLine("Rolls");
                        linesAdded = true;

                        for _, Roll in pairs (Entry.Rolls or {}) do
                            local rollCount = "";
                            if (not rollsPerPlayer[Roll.player]) then
                                rollsPerPlayer[Roll.player] = 1;
                            else
                                rollsPerPlayer[Roll.player] = rollsPerPlayer[Roll.player] + 1;
                                rollCount = string.format("[%s]", rollsPerPlayer[Roll.player]);
                            end

                            GameTooltip:AddLine(string.format("|c00%s%s|r: %s%s (%s)",
                                GL:classHexColor(Roll.class),
                                Roll.player,
                                Roll.amount,
                                rollCount,
                                Roll.classification
                            ));
                        end
                    end

                    if (not GL:empty(ItemsWonByRollerInTheLastFiveHours)) then
                        if (linesAdded) then
                            GameTooltip:AddLine(" ");
                        end

                        linesAdded = true;
                        local header = string.format(L.PLAYER_ITEM_WON_COUNT, GL:nameFormat(Entry.awardedTo));
                        if (itemWasDisenchanted) then
                            header = L.AWARD_TOOLTIP_DISENCHANTED_ITEMS
                        end

                        GameTooltip:AddLine(header);
                        GameTooltip:AddLine(" ");

                        for _, Entry in pairs(ItemsWonByRollerInTheLastFiveHours) do
                            local receivedString = " " .. L.AWARD_TOOLTIP_GIVEN;
                            if (not Entry.received) then
                                receivedString = " " .. L.AWARD_TOOLTIP_NOT_GIVEN;
                            end

                            local OSString = "";
                            if (Entry.OS) then
                                OSString = " " .. L.AWARD_TOOLTIP_OFFSPEC_INDICATION;
                            end

                            local BRString = "";
                            if (GL:higherThanZero(Entry.BRCost)) then
                                BRString = (" " .. L.AWARD_TOOLTIP_BR_INDICATION):format(Entry.BRCost);
                            end

                            local line = string.format("%s%s%s%s",
                                Entry.itemLink,
                                OSString,
                                BRString,
                                receivedString
                            );

                            GameTooltip:AddLine(line);
                        end
                    end

                    if (linesAdded) then
                        GameTooltip:Show();
                    end
                end);
                ItemRow:SetScript("OnLeave", function()
                    GameTooltip:Hide();
                end);

                --[[ DELETE / EDIT / DISENCHANT BUTTON BEHAVIOR ]]
                ItemRow:HookScript("OnEnter", function ()
                    DeleteButton:SetFrameLevel(ItemRow:GetFrameLevel() + 1);
                    DeleteButton:ClearAllPoints();
                    DeleteButton:SetPoint("TOPRIGHT", ItemRow, "TOPRIGHT", -2, 0);
                    DeleteButton:Show();

                    DisenchantButton:SetFrameLevel(ItemRow:GetFrameLevel() + 1);
                    DisenchantButton:ClearAllPoints();
                    DisenchantButton:SetPoint("TOPRIGHT", DeleteButton, "TOPLEFT", -2, 0);
                    DisenchantButton:Show();

                    EditButton:SetFrameLevel(ItemRow:GetFrameLevel() + 1);
                    EditButton:ClearAllPoints();
                    EditButton:SetPoint("TOPRIGHT", DisenchantButton, "TOPLEFT", -2, 0);
                    EditButton:Show();

                    DeleteButton:SetScript("OnClick", function (_, button)
                        if (button ~= 'LeftButton') then
                            return;
                        end

                        if (GL.User.isInGroup
                            and not GL.User.isMasterLooter
                            and not GL.User.hasAssist
                            and not GL.User.isLead
                        ) then
                            return GL:warning(L.LM_OR_ASSIST_REQUIRED);
                        end

                        DeleteButton:SetParent(ItemHolder);
                        DeleteButton:Hide();

                        local BRString = "";
                        if (GL:higherThanZero(Entry.BRCost)) then
                            BRString = (" " .. L.AWARD_UNDO_BR_REFUND):format(tostring(Entry.BRCost));
                        end

                        GL.Interface.Dialogs.PopupDialog:open{
                            question = string.format(
                                L.AWARD_UNDO_CONFIRM,
                                Entry.itemLink,
                                Entry.awardedTo,
                                BRString
                            ),
                            OnYes = function ()
                                GL.AwardedLoot:deleteWinner(Entry.checksum);
                                EditButton:Hide();
                                DeleteButton:Hide();
                            end,
                        };
                    end);

                    EditButton:SetScript("OnClick", function(_, button)
                        if (button ~= 'LeftButton') then
                            return;
                        end

                        if (GL.User.isInGroup
                            and not GL.User.isMasterLooter
                            and not GL.User.hasAssist
                            and not GL.User.isLead
                        ) then
                            return GL:warning(L.LM_OR_ASSIST_REQUIRED);
                        end

                        -- Show the player selector
                        local question = (L.AWARD_NEW_WINNER_CONFIRMATION):format(Entry.itemLink);
                        GL.Interface.PlayerSelector:draw(question, GL.User:groupMemberNames(), function (playerName)
                            GL.Interface.Dialogs.PopupDialog:open{
                                question = (L.ROLLING_AWARD_CONFIRM):format(
                                    Entry.itemLink,
                                    GL:nameFormat{ name = playerName, colorize = true }
                                ),
                                OnYes = function ()
                                    if (not playerName or type(playerName) ~= "string") then
                                        return;
                                    end

                                    playerName = GL:capitalize(string.trim(string.lower(GL:stripRealm(playerName))));
                                    GL.AwardedLoot:editWinner(Entry.checksum, playerName);

                                    GL.Interface.PlayerSelector:close();
                                end,
                            };
                        end);
                    end);

                    DisenchantButton:SetScript("OnClick", function(_, button)
                        if (button ~= 'LeftButton') then
                            return;
                        end

                        if (GL.User.isInGroup
                            and not GL.User.isMasterLooter
                            and not GL.User.hasAssist
                            and not GL.User.isLead
                        ) then
                            return GL:warning(L.LM_OR_ASSIST_REQUIRED);
                        end

                        -- Show a specific dialog when boosted roll points are involved
                        if (GL:higherThanZero(Entry.BRCost)) then
                            GL.Interface.Dialogs.PopupDialog:open{
                                question = (L.AWARD_DISENCHANT_BR_CONFIRMATION):format(Entry.itemLink, tostring(Entry.BRCost)),
                                OnYes = function ()
                                    GL.AwardedLoot:deleteWinner(Entry.checksum);
                                    GL.PackMule:disenchant(Entry.itemLink, true);
                                end,
                            };

                            return;
                        end

                        -- Show the generic disenchant confirmation + selector dialog if applicable
                        GL.PackMule:disenchant(Entry.itemLink, false, function ()
                            GL.AwardedLoot:deleteWinner(Entry.checksum);
                        end);
                    end);
                end);

                ItemRow:HookScript("OnLeave", function ()
                    if (not Interface:mouseIsOnFrame(DeleteButton)
                        and not Interface:mouseIsOnFrame(EditButton)
                        and not Interface:mouseIsOnFrame(DisenchantButton)
                    ) then
                        DeleteButton:Hide();
                        EditButton:Hide();
                        DisenchantButton:Hide();
                    end
                end);

                -- Add the row to our collection so we can clean it up later
                tinsert(self.ItemRows, ItemRow);
            end)();
        end
    end);
end
