---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");
local Constants = GL.Data.Constants;
local DB = GL.DB;
local Interface = GL.Interface;

--[[ CONSTANTS ]]
local SESSION_ROWS = 22;
local HEIGHT_PER_SESSION_ROW = 16;

GL:tableSet(GL, "Interface.GDKP.Overview", {
    _initialized = false,
    isVisible = false,
    selectedSession = nil,

    -- All action buttons are stored here so we can release them properly
    ActionButtons = {},

    -- Hidden buttons are added to this pool so that we can reuse them later
    ButtonPool = {},

    Window = nil,
});

---@class GDKPOverview
local Overview = Interface.GDKP.Overview; ---@type GDKPOverview

function Overview:_init()
    GL:debug("Overview:_init");

    if (self._initialized) then
        return;
    end

    self._initialized = true;

    GL.Events:register("GDKPOverviewGDKPAuctionChangedListener", "GL.GDKP_AUCTION_CHANGED", function()
        if (not self.isVisible) then return; end
        GL.Ace:ScheduleTimer(function()
            self:refreshLedger();
        end, .1);
    end);

    GL.Events:register({
        { "GDKPOverviewGDKPActiveSessionChangedListener", "GL.GDKP_ACTIVE_SESSION_CHANGED" },
        { "GDKPOverviewGDKPSessionChangedListener", "GL.GDKP_SESSION_CHANGED" }
    }, function()
        if (not self.isVisible) then return; end
        self:refreshSessions();
    end);
end

function Overview:draw()
    GL:debug("Overview:draw");

    if (not self.Window) then
        self:create();
    end

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    self:refreshLedger();
    self:refreshSessions();
    self.Window:Show();
end

function Overview:create()
    GL:debug("Overview:create");

    -- Looks like we already created the overview before
    if (self.Window) then
        return;
    end

    self:_init();

    local Window = AceGUI:Create("Frame");
    Interface:AceGUIDefaults(self, Window, "GDKPOverview", 400, 600);
    Interface:resizeBounds(Window, 444, 300);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    self.Window = Window;

    --[[ FIRST COLUMN: sessions ]]
    local FirstColumn = AceGUI:Create("SimpleGroup");
    FirstColumn:SetLayout("FILL")
    FirstColumn:SetWidth(200);
    FirstColumn:SetFullHeight(true);

    self.SessionsTable = self:createSessionsTable(Window);
    FirstColumn:AddChild(self.SessionsTable);

    --[[ SECOND COLUMN: ledger ]]
    local SecondColumn = AceGUI:Create("SimpleGroup");
    SecondColumn:SetLayout("FLOW")
    SecondColumn:SetFullHeight(true);

    local Title = AceGUI:Create("Label");
    Title:SetFontObject(_G["GameFontNormalLarge"]);
    Title:SetFullWidth(true);
    SecondColumn:AddChild(Title);

    local Note = AceGUI:Create("Label");
    Note:SetFontObject(_G["GameFontNormalSmall"]);
    Note:SetFullWidth(true);
    SecondColumn:AddChild(Note);

    local ScrollFrameHolder = AceGUI:Create("InlineGroup");
    ScrollFrameHolder:SetLayout("FILL")
    ScrollFrameHolder:SetFullWidth(true)
    ScrollFrameHolder:SetFullHeight(true)
    SecondColumn:AddChild(ScrollFrameHolder);

    --[[ CREATE BUTTON ]]
    GL.Interface:createButton(ScrollFrameHolder, {
        onClick = function() Interface.Award:draw(); end,
        tooltip = "Add entry",
        disabledTooltip = "You need lead or master loot to add entries.\nYou can't add entries to deleted sessions",
        normalTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\create",
        highlightTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\create-highlighted",
        disabledTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\create-disabled",
        update = function (self)
            self:SetEnabled(not GL.User.isInGroup or GL.User.hasLead or GL.User.isMasterLooter);
        end,
        updateOn = { "GROUP_ROSTER_UPDATE", "GL.GDKP_SESSION_CHANGED" },
    }):SetPoint("TOP", ScrollFrameHolder.frame, "TOP", -9, -7);

    --[[ SHARE BUTTON ]]
    Interface:createShareButton(ScrollFrameHolder, {
        onClick = function() Interface.Dialogs.PopupDialog:open("BROADCAST_GDKP_CONFIRMATION"); end,
        tooltip = "Broadcast data",
        disabledTooltip = "Broadcast data: you need loot master, assist or lead!",
        position = "TOPCENTER",
        update = function (self) self:SetEnabled(GL.GDKP:userIsAllowedToBroadcast()); end,
        updateOn = "GROUP_ROSTER_UPDATE",
        x = 16,
    });

    Interface:set(self, "Title", Title);
    Interface:set(self, "Note", Note);
    Interface:set(self, "SectionWrapper", ScrollFrameHolder);

    Window:AddChildren(FirstColumn, SecondColumn);

    --[[ FOOTER BUTTONS ]]
    local ThirdColumn = AceGUI:Create("SimpleGroup");
    ThirdColumn:SetLayout("FLOW");
    ThirdColumn:SetWidth(580);
    ThirdColumn:SetHeight(40);

    local EnableSession = AceGUI:Create("Button");
    EnableSession:SetText("Enable");
    EnableSession:SetWidth(74);
    EnableSession:SetHeight(20);
    EnableSession:SetCallback("OnClick", function()
        GL:dump("Enable");
    end);

    local CreateSession = AceGUI:Create("Button");
    CreateSession:SetText("New");
    CreateSession:SetWidth(74);
    CreateSession:SetHeight(20);
    CreateSession:SetCallback("OnClick", function()
        Interface.GDKP.CreateSession:draw();
    end);

    local EditSession = AceGUI:Create("Button");
    EditSession:SetText("Edit");
    EditSession:SetWidth(74);
    EditSession:SetHeight(20);
    EditSession:SetCallback("OnClick", function()
        GL:dump("Edit");
    end);

    local DeleteSession = AceGUI:Create("Button");
    DeleteSession:SetText("Delete");
    DeleteSession:SetWidth(74);
    DeleteSession:SetHeight(20);
    DeleteSession:SetCallback("OnClick", function()
        GL.GDKP:deleteSession(self.activeSession);
        Interface:get(self, "Window"):Hide();
        self:draw();
    end);

    ThirdColumn:AddChildren(EnableSession, CreateSession, EditSession, DeleteSession);
    ThirdColumn.frame:SetParent(Window.frame);
    ThirdColumn.frame:SetPoint("BOTTOMLEFT", Window.frame, "BOTTOMLEFT", 20, 17);

    self:refreshSessions();

    local originalOnHeightSet = Window.OnHeightSet;
    local styleWindowAfterResize = function ()
        SecondColumn:SetWidth(math.max(Window.frame:GetWidth() - FirstColumn.frame:GetWidth() - 50, 100));
        ScrollFrameHolder:DoLayout();
        SecondColumn:DoLayout();
        Window:DoLayout();

        self.SessionsTable:SetDisplayRows(math.floor(FirstColumn.frame:GetHeight() / HEIGHT_PER_SESSION_ROW - 1), HEIGHT_PER_SESSION_ROW);
    end;
    Window.OnHeightSet = function (...)
        originalOnHeightSet(...);
        styleWindowAfterResize();
    end

    GL.Ace:ScheduleTimer(function()
        self:refreshLedger();
        styleWindowAfterResize();
    end, .05);
end

function Overview:close()
    Interface.GDKP.EditAuction:close(); -- Close the edit window
    Interface.GDKP.CreateSession:close(); -- Close the edit window

    self.isVisible = false;
end

function Overview:refreshLedger()
    GL:debug("Overview:drawDetails");

    self:clearDetailsFrame();

    local sessionIdentifier = self.selectedSession;
    if (not sessionIdentifier) then
        return;
    end

    local Session = DB:get("GDKP.Ledger." .. sessionIdentifier, false);

    if (not Session) then
        return GL:warning(string.format("Unknown GDKP session '%s'", sessionIdentifier));
    end

    self.activeSession = sessionIdentifier;

    local Wrapper = Interface:get(self, "Frame.SectionWrapper");
    local Details = GL.AceGUI:Create("ScrollFrame");
    Details:SetLayout("Flow");
    Interface:set(self, "SessionDetails", Details);
    Wrapper:AddChild(Details);

    local Title = Interface:get(self, "Label.Title");
    Title:SetText(string.format("\n|c00%s%s|r", Constants.addonHexColor, Session.title));

    local Note = Interface:get(self, "Label.Note");
    local CreatedBy = Session.CreatedBy or {class = "priest", name = "unknown", guild = "unknown", uuid = "unknown"};
    Note:SetText(string.format(
        "Created by |c00%s%s|r |c001eff00<%s>|r on |c00%s%s|r",
        GL:classHexColor(CreatedBy.class),
        CreatedBy.name,
        CreatedBy.guild or "",
        Constants.addonHexColor,
        date('%Y-%m-%d', Session.createdAt)
    ));

    local ItemIDs = {};
    for _, Sale in pairs(DB:get("GDKP.Ledger." .. sessionIdentifier .. ".Auctions") or {}) do
        tinsert(ItemIDs, Sale.itemID);
    end

    GL:onItemLoadDo(ItemIDs, function ()
        local Auctions = {};
        local RawAuctions = DB:get("GDKP.Ledger." .. sessionIdentifier .. ".Auctions") or {};

        -- RawAuctions is an associative table, which does not work with table.sort
        for checksum, Entry in pairs(RawAuctions) do
            Entry.checksum = checksum; -- We need this step because the table.sort will remove the keys
            tinsert(Auctions, Entry);
        end

        -- Sort the auctions based on date/time (highest to lowest)
        table.sort(Auctions, function (a, b)
            return a.createdAt > b.createdAt;
        end);

        -- Add placeholders for all the item icons and labels
        for _, Auction in pairs(Auctions) do
            local price = Auction.price or 0;
            local saleWasDeleted = price <= 0;

            -- This entry should always exist, if it doesn't something went wrong (badly)
            local ItemEntry = DB.Cache.ItemsByID[tostring(Auction.itemID)];

            if (GL:empty(ItemEntry)) then
                break;
            end

            local ItemRow = AceGUI:Create("SimpleGroup");
            ItemRow:SetLayout("FLOW")
            ItemRow:SetHeight(30);
            ItemRow:SetFullWidth(true);
            Details:AddChild(ItemRow);

            --[[
                ITEM ICON
            ]]
            local ItemIcon = AceGUI:Create("Icon");
            ItemIcon:SetWidth(30);
            ItemIcon:SetHeight(30);
            ItemIcon:SetImageSize(30, 30);
            ItemIcon:SetImage(ItemEntry.icon);
            ItemRow:AddChild(ItemIcon);
            ItemIcon:SetCallback("OnLeave", function()
                GameTooltip:Hide();
            end);

            --[[
               ITEM ICON/LABEL SPACER
           ]]
            local ItemSpacer = AceGUI:Create("SimpleGroup");
            ItemSpacer:SetLayout("FILL")
            ItemSpacer:SetWidth(10);
            ItemSpacer:SetHeight(30);
            ItemRow:AddChild(ItemSpacer);

            --[[
                ITEM LABEL
            ]]
            local ItemLabel = AceGUI:Create("Label");
            ItemLabel:SetFontObject(_G["GameFontNormalSmall"]);
            ItemLabel:SetWidth(268);

            -- Item was sold
            if (not saleWasDeleted) then
                ItemLabel:SetText(string.format(
                    "|cFF%s%s|r paid |cFF%s%sg|r for\n%s",
                    GL:classHexColor(Auction.Winner.class),
                    Auction.Winner.name or "",
                    Constants.ClassHexColors.rogue,
                    price or "0",
                    ItemEntry.link
                ));

            -- Item was deleted
            else
                local reason = Auction.reason;

                if (GL:empty(reason)) then
                    reason = "-";
                end

                ItemLabel:SetText(string.format(
                    "|cFFbe3333Deleted by|r |cFF%s%s|r\nReason: %s",
                    GL:classHexColor(Auction.CreatedBy.class),
                    Auction.CreatedBy.name,
                    reason
                ));
            end

            ItemRow:AddChild(ItemLabel);

            --[[
                ACTION BUTTONS
            ]]
            -- We need a holder first because we're not using acegui
            local ActionButtons = AceGUI:Create("SimpleGroup");
            ActionButtons:SetLayout("FILL")
            ActionButtons:SetWidth(50);
            ActionButtons:SetHeight(30);
            ItemRow:AddChild(ActionButtons);

            self.ActionButtons[Auction.ID] = {};

            --[[
                EDIT BUTTON
            ]]
            local EditButton = self:newTableButton(ActionButtons.frame);
            EditButton:Show();
            EditButton:SetSize(24, 24);
            EditButton:ClearAllPoints();
            EditButton:SetPoint("TOPRIGHT", ItemRow.frame, "TOPRIGHT", -60, -10);
            EditButton:SetMotionScriptsWhileDisabled(true); -- Make sure tooltip still shows even when button is disabled

            if (saleWasDeleted) then
                EditButton:Disable();
            end

            local HighlightTexture = EditButton:CreateTexture();
            HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\edit-highlighted");
            HighlightTexture:SetPoint("CENTER", EditButton, "CENTER", 0, 0);
            HighlightTexture:SetSize(24, 24);

            EditButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\edit");
            EditButton:SetHighlightTexture(HighlightTexture);
            EditButton:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\edit-disabled");

            EditButton:SetScript("OnEnter", function()
                GameTooltip:SetOwner(EditButton, "ANCHOR_TOP");

                if (not saleWasDeleted) then
                    GameTooltip:AddLine("Edit");
                else
                    GameTooltip:AddLine("Can't edit deleted entry");
                end

                GameTooltip:Show();
            end);

            EditButton:SetScript("OnLeave", function()
                GameTooltip:Hide();
            end);


            EditButton:SetScript("OnClick", function(_, button)
                if (button == 'LeftButton') then
                    Interface.GDKP.EditAuction:draw(sessionIdentifier, Auction.checksum);
                end
            end);

            self.ActionButtons[Auction.ID].EditButton = EditButton;

            --[[
                DELETE BUTTON
            ]]
            local DeleteButton = GL.UI:createFrame("Button", "GDKPActionButton" .. GL:uuid(), ActionButtons.frame, "UIPanelButtonTemplate");
            DeleteButton:SetSize(24, 24);
            DeleteButton:ClearAllPoints();
            DeleteButton:SetPoint("TOPLEFT", EditButton, "TOPRIGHT", 2, 0);
            DeleteButton:SetMotionScriptsWhileDisabled(true); -- Make sure tooltip still shows even when button is disabled

            HighlightTexture = DeleteButton:CreateTexture();
            HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\delete-highlighted");
            HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\delete-highlighted");
            HighlightTexture:SetPoint("CENTER", DeleteButton, "CENTER", 0, 0);
            HighlightTexture:SetSize(24, 24);

            DeleteButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\delete");
            DeleteButton:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\delete-disabled");
            DeleteButton:SetHighlightTexture(HighlightTexture);

            DeleteButton:SetScript("OnEnter", function()
                GameTooltip:SetOwner(DeleteButton, "ANCHOR_TOP");
                GameTooltip:AddLine("Delete (hold shift to bypass reason)");
                GameTooltip:Show();
            end);

            DeleteButton:SetScript("OnLeave", function()
                GameTooltip:Hide();
            end);

            DeleteButton:SetScript("OnClick", function(_, button)
                if (button == 'LeftButton') then
                    if (IsShiftKeyDown()) then
                        ---@todo Skip the reason dialog when holding the shift key
                        GL.GDKP:deleteAuction(sessionIdentifier, Auction.ID, "-")
                    else
                        Interface.Dialogs.ConfirmWithSingleInputDialog:open({
                            question = string.format("Provide a reason for deleting this entry"),
                            OnYes = function (reason)
                                GL.GDKP:deleteAuction(sessionIdentifier, Auction.ID, reason);
                            end,
                        });
                    end

                    self:refreshLedger();
                end
            end);

            if (saleWasDeleted) then
                DeleteButton:Hide();
            end

            self.ActionButtons[Auction.ID].DeleteButton = DeleteButton;

            --[[
                RESTORE BUTTON
            ]]
            local RestoreButton = GL.UI:createFrame("Button", "GDKPActionButton" .. GL:uuid(), ActionButtons.frame, "UIPanelButtonTemplate");
            RestoreButton:SetSize(24, 24);
            RestoreButton:SetPoint("TOPLEFT", EditButton, "TOPRIGHT", 2, 0);
            RestoreButton:SetMotionScriptsWhileDisabled(true); -- Make sure tooltip still shows even when button is disabled

            HighlightTexture = RestoreButton:CreateTexture();
            HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\restore-highlighted");
            HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\restore-highlighted");
            HighlightTexture:SetPoint("CENTER", RestoreButton, "CENTER", 0, 0);
            HighlightTexture:SetSize(24, 24);

            RestoreButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\restore");
            RestoreButton:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\restore-disabled");
            RestoreButton:SetHighlightTexture(HighlightTexture);

            RestoreButton:SetScript("OnEnter", function()
                GameTooltip:SetOwner(RestoreButton, "ANCHOR_TOP");
                GameTooltip:AddLine("Restore");
                GameTooltip:Show();
            end);

            RestoreButton:SetScript("OnLeave", function()
                GameTooltip:Hide();
            end);

            RestoreButton:SetScript("OnClick", function(_, button)
                if (button == 'LeftButton'
                    and GL.GDKP:restoreAuction(sessionIdentifier, Auction.ID)
                ) then
                    self:refreshLedger();
                end
            end);

            if (not saleWasDeleted) then
                RestoreButton:Hide();
            end

            self.ActionButtons[Auction.ID].RestoreButton = RestoreButton;
        end
    end);

    self.Window:DoLayout();
end

--- Update the share button when the group setup changes
---
---@return void
function Overview:updateShareButton()
    local ShareButton = Interface:get(self, "Frame.ShareButton")

    GL.Ace:ScheduleTimer(function ()
        -- The user doesn't have sufficient permissions to broadcast the data
        if (not GL.GDKP:userIsAllowedToBroadcast()) then
            ShareButton:Disable();
            return;
        end

        ShareButton:Enable();
    end, 1.5);
end

--- Make sure we re-use button frames whenever possible
---
---@param parent table
---@return table
function Overview:newTableButton(parent)
    GL:debug("Overview:newTableButton");

    local Button = table.remove(self.ButtonPool, 1);

    if (Button) then
        Button:SetParent(parent);
        return Button;
    end

    return GL.UI:createFrame("Button", "GDKPActionButton" .. GL:uuid(), parent, "UIPanelButtonTemplate");
end

-- Clear the details frame
function Overview:clearDetailsFrame()
    GL:debug("GDKP:clearDetailsFrame");

    -- Release all of the action buttons into our pool so that we can reuse them later
    for _, Buttons in pairs(self.ActionButtons or {}) do
        for _, Button in pairs(Buttons) do
            Button:Enable();
            Button:Hide();
            tinsert(self.ButtonPool, Button);
        end
    end

    self.ActionButtons = {};

    local Title = Interface:get(self, "Label.Title");
    local Note = Interface:get(self, "Label.Note");

    if (Title) then
        Title:SetText("");
    end

    if (Note) then
        Note:SetText("");
    end

    Interface:release(self, "ScrollFrame.SessionDetails");
end

--- Draw the GDKP sessions table (left-hand side of the overview)
---
---@return void
function Overview:createSessionsTable()
    GL:debug("GDKP:createSessionsTable");

    local columns = {
        {
            name = "",
            width = 130,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1
            },
            colorargs = nil,
            defaultsort = GL.Data.Constants.ScrollingTable.ascending,
        },
        {
            name = "checksum",
            width = 0,
            colorargs = nil,
        },
        {
            name = "priority",
            width = 30,
            sort = GL.Data.Constants.ScrollingTable.ascending,
            sortnext = 1,
        },
    };

    local Table = AceGUI:Create("CLMLibScrollingTable");
    self.SessionsTable = Table;
    Table:SetDisplayCols(columns);
    Table:SetDisplayRows(SESSION_ROWS, HEIGHT_PER_SESSION_ROW);
    Table:EnableSelection(true);
    Table:GetScrollingTable().multiselection = false;

    Table:RegisterEvents({
        OnClick = function (_, _, data, _, _, realrow)
            -- Make sure something is actually selected, better safe than lua error
            if (not GL:higherThanZero(realrow)
                or type(data) ~= "table"
                or not data[realrow]
                or not data[realrow].cols
                or not data[realrow].cols[2]
            ) then
                return;
            end

            -- We always select the first column of the selected row because that contains the player name
            self.selectedSession = data[realrow].cols[2].value;
            self:refreshLedger();
        end
    });

    return Table;
end

--- Refresh the sessions table
---
---@return void
function Overview:refreshSessions()
    GL:debug("Overview:refreshSessions");

    -- If there's no sessions table then there's nothing to refresh
    if (not self.SessionsTable) then
        return;
    end

    local Table = self.SessionsTable;
    local TableData = {};

    local lowestPriority = 99999999999;
    local lowestPriorityTableItem = 1;
    local selectedTableItem = nil;
    local tableItem = 1;
    for checksum, Session in pairs(DB:get("GDKP.Ledger", {})) do
        local title = Session.title;
        local priority = 99999999999 - (Session.createdAt or 0);

        if (checksum == DB.GDKP.activeSession) then
            title = Session.title .. " (active)";
        end

        -- Make sure we select the currently selected session by default
        if (self.selectedSession
            and self.selectedSession == checksum
        ) then
            selectedTableItem = tableItem;
        end

        if (priority < lowestPriority) then
            lowestPriority = priority;
            lowestPriorityTableItem = tableItem;
        end

        local color = {r = 1, g = 1, b = 1};
        if (Session.deletedAt) then
            color = {r = .77, g = .12, b = .23};
            title = title .. " (deleted)";
        end

        tinsert(TableData, {
            cols = {
                { value = title, color = color, },
                { value = checksum, color = color, },
                { value = priority, color = color, }
            },
        });

        tableItem = tableItem + 1;
    end

    if (not selectedTableItem
        and lowestPriorityTableItem
    ) then
        selectedTableItem = lowestPriorityTableItem;
        self.selectedSession = TableData[lowestPriorityTableItem].cols[2].value;
    end
    Table:SetData(TableData);

    -- Highlight the correct section in the table on the left
    -- This nasty delay is necessary because of how lib-st handles click and selection events
    Table:ClearSelection();
    GL.Ace:ScheduleTimer(function ()
        if (Table and Table:GetSelection() ~= selectedTableItem) then
            Table:SetSelection(selectedTableItem);
        end
    end, .1);
end

GL:debug("Interfaces/GDKP/Overview.lua");