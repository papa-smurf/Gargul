---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

local AceGUI = GL.AceGUI;
local Constants = GL.Data.Constants; ---@type Data
local DB = GL.DB; ---@type DB
local ScrollingTable = GL.ScrollingTable;
local GDKP = GL.GDKP; ---@type GDKP

GL:tableSet(GL, "Interface.GDKP.Overview", {
    _initialized = false,
    isVisible = false,
    selectedSession = nil,

    -- All action buttons are stored here so we can release them properly
    ActionButtons = {},

    -- Hidden buttons are added to this pool so that we can reuse them later
    ButtonPool = {},
});

---@class GDKPOverview
local Overview = GL.Interface.GDKP.Overview;

function Overview:_init()
    GL:debug("Overview:_init");

    self._initialized = true;

    GL.Events:register("GDKPOverviewGDKPAuctionChangedListener", "GL.GDKP_AUCTION_CHANGED", function(_, sessionIdentifier)
        if (not self.isVisible
            or self.selectedSession ~= sessionIdentifier
        ) then
            --return;
        end

        self:drawDetails(sessionIdentifier);
    end);
end

--- Draw the UI elements required to show an overview of all gdkp data
--- This is what this frame looks like:
---     +-------+---------+
---     | Col1  |  Col2   |
---     +-----------------+
---     | Button Frame    |
---     +-----------------+
---
---@return void
function Overview:draw()
    self:_init();

    GL:debug("Overview:draw");

    -- The overview is already visible
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;
    self.activeSession = DB:get("GDKP.activeSession", self.activeSession);

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(640);
    Window:SetWidth(642);
    Window:SetHeight(500);
    Window:EnableResize(false);
    Window.statustext:GetParent():Show(); -- Explicitely show the statustext bar
    Window:SetCallback("OnClose", function()
        self.isVisible = false;
    end);
    GL.Interface:setItem(self, "Window", Window);
    Window:SetPoint(GL.Interface:getPosition("GDKPOverview"));
    Window.frame:SetFrameStrata("HIGH");

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_GDKP_OVERVIEW_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_GDKP_OVERVIEW_WINDOW");

    --[[
        FIRST COLUMN (session table)
    ]]
    local FirstColumn = AceGUI:Create("SimpleGroup");
    FirstColumn:SetLayout("FLOW")
    FirstColumn:SetWidth(190);
    FirstColumn:SetHeight(350);
    Window:AddChild(FirstColumn);

    --[[
        COLUMN SPACER
    ]]
    local ColumnSpacer = AceGUI:Create("SimpleGroup");
    ColumnSpacer:SetLayout("FILL")
    ColumnSpacer:SetWidth(10);
    ColumnSpacer:SetHeight(350);
    Window:AddChild(ColumnSpacer);

    --[[
        SECOND COLUMN (GDKP ledger)
    ]]
    local SecondColumn = AceGUI:Create("SimpleGroup");
    SecondColumn:SetLayout("FLOW")
    SecondColumn:SetWidth(406);
    GL.Interface:setItem(self, "SecondColumn", SecondColumn);
    Window:AddChild(SecondColumn);

    local SectionTitle = AceGUI:Create("Label");
    SectionTitle:SetFontObject(_G["GameFontNormalLarge"]);
    SectionTitle:SetFullWidth(true);
    SectionTitle:SetText("BWL something");
    SecondColumn:AddChild(SectionTitle);

    local SectionNote = AceGUI:Create("Label");
    SectionNote:SetFontObject(_G["GameFontNormalSmall"]);
    SectionNote:SetFullWidth(true);
    SectionNote:SetText("Some note here");
    SecondColumn:AddChild(SectionNote);

    local ScrollFrameHolder = AceGUI:Create("InlineGroup");
    ScrollFrameHolder:SetLayout("FILL")
    ScrollFrameHolder:SetWidth(400);
    ScrollFrameHolder:SetHeight(350);
    SecondColumn:AddChild(ScrollFrameHolder);

    --[[
        CREATE BUTTON
    ]]
    local CreateButton = GL.UI:createFrame("Button", "GDKPActionButton" .. GL:uuid(), ScrollFrameHolder.frame, "UIPanelButtonTemplate");
    CreateButton:Show();
    CreateButton:SetSize(24, 24);
    CreateButton:SetPoint("TOPLEFT", ScrollFrameHolder.frame, "TOPLEFT", 164, -7);
    CreateButton:SetMotionScriptsWhileDisabled(true); -- Make sure tooltip still shows even when button is disabled

    local HighlightTexture = CreateButton:CreateTexture();
    HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\create-highlighted");
    HighlightTexture:SetPoint("CENTER", CreateButton, "CENTER", 0, 0);
    HighlightTexture:SetSize(24, 24);

    CreateButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\create");
    CreateButton:SetHighlightTexture(HighlightTexture);
    CreateButton:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\create-disabled");

    CreateButton:SetScript("OnEnter", function()
        GameTooltip:SetOwner(CreateButton, "ANCHOR_TOP");
        GameTooltip:AddLine("Add entry");
        GameTooltip:Show();
    end);

    CreateButton:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    CreateButton:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            GL.Interface.Award:draw();
        end
    end);

    --[[
        SHARE BUTTON
    ]]
    local ShareButton = GL.UI:createShareButton(
        ScrollFrameHolder.frame,
        function ()
            GL.Interface.Dialogs.PopupDialog:open("BROADCAST_GDKP_CONFIRMATION");
        end,
        "Broadcast data",
        "Broadcast data: you need loot master, assist or lead!",
        true
    );
    ShareButton:SetPoint("TOPLEFT", ScrollFrameHolder.frame, "TOPLEFT", 190, -7);
    GL.Interface:setItem(self, "ShareButton", ShareButton);
    ShareButton:Show();

    -- The user doesn't have sufficient permissions to broadcast the data
    if (not GL.GDKP:userIsAllowedToBroadcast()) then
        ShareButton:Disable();
    else
        ShareButton:Enable();
    end

    GL.Interface:setItem(self, "Title", SectionTitle);
    GL.Interface:setItem(self, "Note", SectionNote);
    GL.Interface:setItem(self, "SectionWrapper", ScrollFrameHolder);

    --[[
        BUTTONS FRAME
    ]]
    local ButtonFrame = AceGUI:Create("SimpleGroup");
    ButtonFrame:SetLayout("FLOW")
    ButtonFrame:SetFullWidth(true);
    Window:AddChild(ButtonFrame);

    local SetActiveSessionButton = AceGUI:Create("Button");
    SetActiveSessionButton:SetText("Set Active");
    SetActiveSessionButton:SetWidth(92); -- Minimum is 92
    SetActiveSessionButton:SetCallback("OnClick", function()
        GL:dump("Set Active");
    end);
    ButtonFrame:AddChild(SetActiveSessionButton);
    SetActiveSessionButton:ClearAllPoints();

    local CreateSessionButton = AceGUI:Create("Button");
    CreateSessionButton:SetText("New Session");
    CreateSessionButton:SetWidth(106); -- Minimum is 106
    CreateSessionButton:SetCallback("OnClick", function()
        GL:dump("New Session");
    end);
    ButtonFrame:AddChild(CreateSessionButton);

    local EditSessionButton = AceGUI:Create("Button");
    EditSessionButton:SetText("Edit Session");
    EditSessionButton:SetWidth(102); -- Minimum is 102
    EditSessionButton:SetCallback("OnClick", function()
        GL:dump("Edit Session");
    end);
    ButtonFrame:AddChild(EditSessionButton);

    local DeleteButton = AceGUI:Create("Button");
    DeleteButton:SetText("Delete Session");
    DeleteButton:SetWidth(120); -- Minimum is 120
    DeleteButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open("CLEAR_GDKP_CONFIRMATION");
    end);
    ButtonFrame:AddChild(DeleteButton);

    self:drawSessionsTable(FirstColumn.frame);
    self:drawDetails(self.activeSession);
end

function Overview:drawDetails(sessionIdentifier)
    GL:debug("Overview:drawDetails");

    self:clearDetailsFrame();

    if (not sessionIdentifier) then
        return;
    end

    local Session = DB:get("GDKP.Ledger." .. sessionIdentifier, false);

    if (not Session) then
        return GL:warning(string.format("Unknown GDKP session '%s'", sessionIdentifier));
    end

    self.activeSession = sessionIdentifier;

    local Wrapper = GL.Interface:getItem(self, "Frame.SectionWrapper");
    local Details = GL.AceGUI:Create("ScrollFrame");
    Details:SetLayout("Flow");
    GL.Interface:setItem(self, "SessionDetails", Details);
    Wrapper:AddChild(Details);

    local Title = GL.Interface:getItem(self, "Label.Title");
    Title:SetText(string.format("|c00%s%s|r", Constants.addonHexColor, Session.title));

    local Note = GL.Interface:getItem(self, "Label.Note");
    local CreatedBy = Session.CreatedBy or {class = "priest", name = "unknown", guild = "unknown", uuid = "unknown"};
    Note:SetText(string.format(
        "Created by |c00%s%s|r |c001eff00<%s>|r on |c00%s%s|r",
        GL:classHexColor(CreatedBy.class),
        CreatedBy.name,
        CreatedBy.guild or "",
        Constants.addonHexColor,
        date('%Y-%m-%d', Session.createdAt)
    ));

    local Window = GL.Interface:getItem(self, "Window");
    Window:SetStatusText(string.format(
        "Active session: |c00%s%s|r, which started on |c00%s%s|r",
        Constants.addonHexColor,
        Session.title,
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
        for _, Entry in pairs(RawAuctions) do
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
            local ItemEntry = DB.Cache.ItemsById[tostring(Auction.itemID)];

            if (GL:empty(ItemEntry)) then
                break;
            end

            --[[
                ITEM ICON
            ]]
            local ItemIcon = AceGUI:Create("Icon");
            ItemIcon:SetWidth(30);
            ItemIcon:SetHeight(30);
            ItemIcon:SetImageSize(30, 30);
            ItemIcon:SetImage(ItemEntry.icon);
            Details:AddChild(ItemIcon);
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
            Details:AddChild(ItemSpacer);

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
                    Auction.Winner.name,
                    GL:classHexColor("rogue"),
                    price,
                    ItemEntry.link
                ));

            -- Item was deleted
            else
                ItemLabel:SetText(string.format(
                    "|cFFbe3333Deleted by|r |cFF%s%s|r\nReason: %s",
                    GL:classHexColor("druid"),
                    "Garguldruid",
                    "Master Looter made a mistake"
                ));
            end

            Details:AddChild(ItemLabel);

            --[[
                ACTION BUTTONS
            ]]
            -- We need a holder first because we're not using acegui
            local ActionButtons = AceGUI:Create("SimpleGroup");
            ActionButtons:SetLayout("FILL")
            ActionButtons:SetWidth(50);
            ActionButtons:SetHeight(30);
            Details:AddChild(ActionButtons);

            self.ActionButtons[Auction.ID] = {};

            --[[
                EDIT BUTTON
            ]]
            local EditButton = self:newTableButton(ActionButtons.frame);
            EditButton:Show();
            EditButton:SetSize(24, 24);
            EditButton:SetPoint("TOPLEFT", ActionButtons.frame, "TOPLEFT", 0, -4);
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
                    GL:dump("EDIT!");
                end
            end);

            self.ActionButtons[Auction.ID].EditButton = EditButton;

            --[[
                DELETE BUTTON
            ]]
            local DeleteButton = GL.UI:createFrame("Button", "GDKPActionButton" .. GL:uuid(), ActionButtons.frame, "UIPanelButtonTemplate");
            DeleteButton:SetSize(24, 24);
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
                        GL.GDKP:deleteAuction(sessionIdentifier, Auction.ID, true)
                    end
                        GL.GDKP:deleteAuction(sessionIdentifier, Auction.ID)
                    else

                    self:drawDetails(sessionIdentifier);
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
                    self:drawDetails(sessionIdentifier);
                end
            end);

            if (not saleWasDeleted) then
                RestoreButton:Hide();
            end

            self.ActionButtons[Auction.ID].RestoreButton = RestoreButton;
        end
    end);
end

--- Update the share button when the group setup changes
---
---@return void
function Overview:updateShareButton()
    local ShareButton = GL.Interface:getItem(self, "Frame.ShareButton")

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

    local Title = GL.Interface:getItem(self, "Label.Title");
    local Note = GL.Interface:getItem(self, "Label.Note");

    if (Title) then
        Title:SetText("");
    end

    if (Note) then
        Note:SetText("");
    end

    GL.Interface:release(self, "ScrollFrame.SessionDetails");
end

--- Draw the GDKP sessions table (left-hand side of the overview)
---
---@param Parent table
---@return void
function Overview:drawSessionsTable(Parent)
    GL:debug("GDKP:drawCharacterTable");

    local columns = {
        {
            name = "Sessions",
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

    local Table = ScrollingTable:CreateST(columns, 22, 16, nil, Parent);
    Table:EnableSelection(true);
    Table:SetWidth(160);
    Table.frame:SetPoint("TOPLEFT", Parent, "TOPLEFT", 0, -3);
    GL.Interface:setItem(self, "Sessions", Table);

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
            local selected = data[realrow].cols[2].value;

            if (selected and type(selected) == "string") then
                GL:dump(string.lower(selected));
            end

            self:drawDetails(selected);
        end
    });

    local TableData = {};

    local lowestPriority = 99999999999;
    local lowestPrioritySession = "";
    local lowestPriorityTableItem = 1;
    local tableItem = 1;
    for checksum, Session in pairs(DB:get("GDKP.Ledger", {})) do
        local title = Session.title;
        local priority = 99999999999 - Session.createdAt or 0;

        if (checksum == DB:get("GDKP.activeSession")) then
            title = Session.title .. " (active)";
        end

        if (priority < lowestPriority) then
            lowestPriority = priority;
            lowestPrioritySessio= checksum;
            lowestPriorityTableItem = tableItem;
        end

        tinsert(TableData, {
            cols = {
                {
                    value = title,
                    color = GL:classRGBAColor("priest"),
                },
                {
                    value = checksum,
                    color = GL:classRGBAColor("priest"),
                },
                {
                    value = priority,
                    color = GL:classRGBAColor("priest"),
                }
            },
        });

        tableItem = tableItem + 1;
    end

    self.selectedSession = lowestPrioritySession;
    Table:SetData(TableData);

    -- Highlight the correct section in the table on the left
    -- This nasty delay is necessary because of how lib-st handles click and selection events
    GL.Ace:ScheduleTimer(function ()
        if (Table and Table:GetSelection() ~= lowestPriorityTableItem) then
            Table:SetSelection(lowestPriorityTableItem);
        end
    end, .1);
end

GL:debug("Interfaces/GDKP/Overview.lua");