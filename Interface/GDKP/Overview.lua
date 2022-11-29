---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");

---@type Data
local Constants = GL.Data.Constants;

---@type DB
local DB = GL.DB;

---@type Interface
local Interface = GL.Interface;

---@type Events
local Events = GL.Events;

---@type GDKP
local GDKP = GL.GDKP;

--[[ CONSTANTS ]]
local SESSION_ROWS = 22;
local HEIGHT_PER_SESSION_ROW = 16;

GL:tableSet(GL, "Interface.GDKP.Overview", {
    _initialized = false,
    isVisible = false,
    selectedSession = nil,

    -- All action buttons are stored here so we can release them properly
    ActionButtons = {},

    -- Released buttons are added to this pool so that we can reuse them later
    ButtonPool = {},
});

---@class GDKPOverview
local Overview = Interface.GDKP.Overview; ---@type GDKPOverview

---@return void
function Overview:_init()
    GL:debug("Interface.GDKP.Overview:_init");

    if (self._initialized) then
        return;
    end

    self._initialized = true;

    GL.Events:register("GDKPOverviewGDKPAuctionChangedListener", "GL.GDKP_AUCTION_CHANGED", function()
        if (not self.isVisible) then return; end
        GL.Ace:ScheduleTimer(function()
            self:updatePot();
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

    GL.Events:register({
        { "GDKPOverviewGDKPOverviewSessionChangedListener", "GL.GDKP_OVERVIEW_SESSION_CHANGED" },
        { "GDKPOverviewGDKPOverviewSessionsRefreshed", "GL.GDKP_OVERVIEW_SESSIONS_REFRESHED" }
    }, function ()
        self:sessionChanged();
    end);
end

function Overview:sessionChanged()
    GL:debug("Overview:sessionChanged");

    local Session = self:getSelectedSession();

    if (not Session) then
        return GL:debug(string.format("Unknown GDKP session '%s'", self.selectedSession));
    end

    local DeleteOrRestoreButton = Interface:get(self, "Button.DeleteRestore");
    if (DeleteOrRestoreButton) then
        if (Session.deletedAt) then
            DeleteOrRestoreButton:SetText("Restore");
            DeleteOrRestoreButton:SetWidth(78);
            DeleteOrRestoreButton.mode = "restore";
        else
            DeleteOrRestoreButton:SetText("Delete");
            DeleteOrRestoreButton:SetWidth(74);
            DeleteOrRestoreButton.mode = "delete";
        end
    end

    local EnableOrDisableButton = Interface:get(self, "Button.EnableDisable");
    if (EnableOrDisableButton) then
        if (Session.deletedAt) then
            EnableOrDisableButton:SetDisabled(true);
        else
            EnableOrDisableButton:SetDisabled(false);
        end

        if (DB.GDKP.activeSession == Session.ID) then
            EnableOrDisableButton:SetText("Disable");
            EnableOrDisableButton.mode = "disable";
        else
            EnableOrDisableButton:SetText("Enable");
            EnableOrDisableButton.mode = "enable";
        end
    end

    self:refreshLedger();
    self:updatePot();
end

---@return void
function Overview:updatePot()
    GL:debug("Overview:updatePot");

    local Session = self:getSelectedSession();

    if (not Session) then
        return;
    end

    local Pot = Interface:get(self, "Frame.Pot");

    if (not Pot) then
        return;
    end

    local pot = GDKP:pot(Session.ID);
    Pot:SetText(string.format("|cFF%s%sg|r", Constants.ClassHexColors.rogue, pot));
end

---@return void
function Overview:open()
    GL:debug("Interface.GDKP.Overview:draw");

    local Window = Interface:get(self, "GDKPOverview");

    if (not Window) then
        Window = self:build();
    end

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    self:refreshLedger();
    self:refreshSessions();
    Window:Show();
end

--- Build the GDKP overview. We only do this once and reuse it when reopened
---
---@return void
function Overview:build()
    GL:debug("Overview:build");

    local Window = Interface:get(self, "GDKPOverview");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    self:_init();

    Window = AceGUI:Create("Frame");

    ---@type Frame
    local WindowFrame = Window.frame;

    Interface:AceGUIDefaults(self, Window, "GDKPOverview", 660, 600);
    Interface:resizeBounds(Window, 660, 300);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar

    --[[ POT ICON AND VALUE ]]

    local PotIcon = AceGUI:Create("Icon");

    ---@type Frame
    local PotIconFrame = PotIcon.frame;

    PotIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/achievement_guildperk_cashflow");
    PotIcon:SetImageSize(26, 26);
    PotIcon:SetWidth(26);
    PotIcon:SetHeight(26);

    PotIconFrame:SetParent(WindowFrame);
    PotIconFrame:SetPoint("TOPRIGHT", WindowFrame, "TOPRIGHT", -56, -24);
    PotIconFrame:Show();

    PotIcon:SetCallback("OnClick", function ()
        GL.Test:simulateGroup(24) ---@todo: REMOVE!
        Interface.GDKP.Distribute:open(self.selectedSession);
        Window.frame:Hide();
    end);

    PotIcon:SetCallback("OnEnter", function ()
        local Session = GDKP:getSessionByID(self.selectedSession);
        local pot = GDKP:pot(Session.ID);
        local numberOfRaidMembers = math.max(#GL.User:groupMemberNames() - 1, 1);
        local managementCut = tonumber(Session.managementCut or 0);
        local managementPot = math.ceil(pot * (0 + managementCut / 100));

        GameTooltip:SetOwner(PotIconFrame, "ANCHOR_TOP");
        GameTooltip:AddLine(string.format("Pot: %sg", pot));
        GameTooltip:AddLine(string.format("Management cut (%s%%): %sg", managementCut, managementPot));
        GameTooltip:AddLine(string.format("Per player cut (1/%s): %sg", numberOfRaidMembers, math.floor((pot - managementPot) / numberOfRaidMembers)));
        GameTooltip:Show();
    end);
    PotIcon:SetCallback("OnLeave", function ()
        GameTooltip:Hide();
    end);

    local Pot = PotIconFrame:CreateFontString(nil, "ARTWORK", "GameFontWhite");
    Pot:SetPoint("CENTER", PotIconFrame, "CENTER");
    Pot:SetPoint("TOP", PotIconFrame, "BOTTOM", 0, -6);
    Pot:SetText();
    Interface:set(self, "Pot", Pot);

    ----[[ RAIDER ICON ]]
    --
    --local RaiderIcon = AceGUI:Create("Icon");
    --
    -----@type Frame
    --local RaiderconFrame = RaiderIcon.frame;
    --
    --RaiderIcon:SetImage("interface/icons/achievement_guildperk_everybodysfriend");
    --RaiderIcon:SetImageSize(26, 26);
    --RaiderIcon:SetWidth(26);
    --RaiderIcon:SetHeight(26);
    --
    --RaiderconFrame:SetParent(WindowFrame);
    --RaiderconFrame:SetPoint("TOPRIGHT", Pot, "TOPLEFT", -20, 32);
    --RaiderconFrame:Show();
    --
    --RaiderIcon:SetCallback("OnClick", function ()
    --    GL.Interface.GDKP.Export:open(self.selectedSession);
    --end);
    --
    --RaiderIcon:SetCallback("OnEnter", function ()
    --    GameTooltip:SetOwner(RaiderconFrame, "ANCHOR_TOP");
    --    GameTooltip:AddLine("Raiders");
    --    GameTooltip:Show();
    --end);
    --RaiderIcon:SetCallback("OnLeave", function ()
    --    GameTooltip:Hide();
    --end);

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
    Interface:createButton(ScrollFrameHolder, {
        onClick = function()
            self:closeSubWindows();
            Interface.GDKP.AddGold:toggle(self.selectedSession);
        end,
        tooltip = "Add gold to pot",
        disabledTooltip = "You need lead or master loot to add gold.\nYou can't add godl to deleted sessions",
        normalTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\create",
        disabledTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\create-disabled",
        update = function (self)
            local SelectedSession = Overview:getSelectedSession();
            self:SetEnabled(SelectedSession and not SelectedSession.deletedAt and (not GL.User.isInGroup or GL.User.hasLead or GL.User.isMasterLooter));
        end,
        updateOn = { "GROUP_ROSTER_UPDATE", "GL.GDKP_OVERVIEW_SESSION_CHANGED", "GL.GDKP_OVERVIEW_SESSION_CHANGED", "GL.GDKP_OVERVIEW_SESSIONS_REFRESHED" },
    }):SetPoint("TOP", ScrollFrameHolder.frame, "TOP", -9, -7);

    --[[ SHARE BUTTON ]]
    Interface:createShareButton(ScrollFrameHolder, {
        onClick = function() Interface.Dialogs.PopupDialog:open("BROADCAST_GDKP_CONFIRMATION"); end,
        tooltip = "Broadcast data",
        disabledTooltip = "Broadcast data: you need loot master, assist or lead!",
        position = "TOPCENTER",
        update = function (self) self:SetEnabled(GDKP:userIsAllowedToBroadcast()); end,
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
    ThirdColumn:SetWidth(500);
    ThirdColumn:SetHeight(40);

    local EnableOrDisableSession = AceGUI:Create("Button");
    EnableOrDisableSession:SetText("Enable");
    EnableOrDisableSession:SetWidth(80);
    EnableOrDisableSession:SetHeight(20);
    EnableOrDisableSession:SetCallback("OnClick", function()
        if (EnableOrDisableSession.mode == "enable") then
            GDKP:setActiveSession(self.selectedSession);
        else
            GDKP:clearActiveSession();
        end
    end);
    Interface:set(self, "EnableDisable", EnableOrDisableSession);

    local CreateSession = AceGUI:Create("Button");
    CreateSession:SetText("New");
    CreateSession:SetWidth(74);
    CreateSession:SetHeight(20);
    CreateSession:SetCallback("OnClick", function()
        self:closeSubWindows();
        Interface.GDKP.CreateSession:toggle();
    end);

    local EditSession = AceGUI:Create("Button");
    EditSession:SetText("Edit");
    EditSession:SetWidth(74);
    EditSession:SetHeight(20);
    EditSession:SetCallback("OnClick", function()
        self:closeSubWindows();
        Interface.GDKP.EditSession:toggle(self.selectedSession);
    end);

    local DeleteOrRestoreSession = AceGUI:Create("Button");
    DeleteOrRestoreSession:SetText("Delete");
    DeleteOrRestoreSession:SetWidth(74);
    DeleteOrRestoreSession:SetHeight(20);
    DeleteOrRestoreSession:SetCallback("OnClick", function()
        if (DeleteOrRestoreSession.mode == "delete") then
            GDKP:deleteSession(self.selectedSession);
        else
            GDKP:restoreSession(self.selectedSession);
        end
    end);
    Interface:set(self, "DeleteRestore", DeleteOrRestoreSession);

    local Export = AceGUI:Create("Button");
    Export:SetText("Export");
    Export:SetWidth(74);
    Export:SetHeight(20);
    Export:SetCallback("OnClick", function()
        GL.Interface.GDKP.Export:open(self.selectedSession);
    end);

    local Distribute = AceGUI:Create("Button");
    Distribute:SetText("Distribute");
    Distribute:SetWidth(90);
    Distribute:SetHeight(20);
    Distribute:SetCallback("OnClick", function()
        GL.Interface.GDKP.Distribute:open(self.selectedSession);
        Window.frame:Hide();
    end);

    ThirdColumn:AddChildren(EnableOrDisableSession, CreateSession, EditSession, DeleteOrRestoreSession, Export, Distribute);
    ThirdColumn.frame:SetParent(WindowFrame);
    ThirdColumn.frame:SetPoint("BOTTOMLEFT", WindowFrame, "BOTTOMLEFT", 20, 15);

    self:refreshSessions();

    local originalOnHeightSet = Window.OnHeightSet;
    local styleWindowAfterResize = function ()
        SecondColumn:SetWidth(math.max(WindowFrame:GetWidth() - FirstColumn.frame:GetWidth() - 50, 100));
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

    return Window;
end

---@return void
function Overview:close()
    GL:debug("Overview:close");

    self:closeSubWindows();

    self.isVisible = false;
end

---@return void
function Overview:closeSubWindows()
    GL:debug("Overview:closeSubWindows");

    Interface.GDKP.CreateSession:close();
    Interface.GDKP.EditSession:close();
    Interface.GDKP.EditAuction:close();
    Interface.GDKP.AuctionDetails:close();
    Interface.GDKP.AddGold:close();
end

--- Get the actively selected GDKP session
---
---@return table|nil
function Overview:getSelectedSession()
    GL:debug("Overview:getSelectedSession");

    local sessionIdentifier = self.selectedSession;
    if (not sessionIdentifier) then
        return;
    end

    return GDKP:getSessionByID(sessionIdentifier);
end

function Overview:refreshLedger()
    GL:debug("Overview:drawDetails");

    local Session = self:getSelectedSession();

    if (not Session) then
        return GL:warning(string.format("Unknown GDKP session '%s'", self.selectedSession));
    end

    self:clearDetailsFrame();

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
    for _, Sale in pairs(Session.Auctions or {}) do
        tinsert(ItemIDs, Sale.itemID);
    end

    GL:onItemLoadDo(ItemIDs, function ()
        local Auctions = {};
        local RawAuctions = Session.Auctions or {};

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
            local auctionWasDeleted = not GL:higherThanZero(price);
            local concernsManualAdjustment = Auction.itemID == Constants.GDKPPotIncreaseItemID;

            -- This entry should always exist, if it doesn't something went wrong (badly)
            local ItemEntry = DB.Cache.ItemsByID[tostring(Auction.itemID)];

            if (GL:empty(ItemEntry)) then
                break;
            end

            -- [[ SET DETAILS ]]
            local iconPath = ItemEntry.icon;
            local itemLabel;

            if (concernsManualAdjustment) then
                iconPath = "Interface/AddOns/Gargul/Assets/Icons/achievement_guildperk_cashflow";
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
            ItemIcon:SetImage(iconPath);
            ItemRow:AddChild(ItemIcon);
            ItemIcon:SetCallback("OnEnter", function()
                GameTooltip:SetOwner(ItemIcon.frame, "ANCHOR_TOP");
                GameTooltip:SetHyperlink(ItemEntry.link);
                GameTooltip:Show();
            end);
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
            if (not auctionWasDeleted) then
                if (concernsManualAdjustment) then
                    itemLabel = string.format("|cFF%s%sg|r added to pot by |c00%s%s|r\nNote: %s",
                        Constants.ClassHexColors.rogue,
                        price or "0",
                        GL:classHexColor(GL.Player:classByName(Auction.Winner.name, 0), GL.Data.Constants.disabledTextColor),
                        Auction.Winner.name,
                        Auction.note or ""
                    );
                else
                    itemLabel = string.format(
                        "|cFF%s%s|r paid |cFF%s%sg|r for\n%s",
                        GL:classHexColor(Auction.Winner.class),
                        Auction.Winner.name or "",
                        Constants.ClassHexColors.rogue,
                        price or "0",
                        ItemEntry.link
                    );
                end

            -- Item was deleted
            else
                local reason = Auction.reason;

                if (GL:empty(reason)) then
                    reason = "-";
                end

                itemLabel = string.format(
                    "|cFFbe3333Deleted by|r |cFF%s%s|r\nReason: %s",
                    GL:classHexColor(Auction.CreatedBy.class),
                    Auction.CreatedBy.name,
                    reason
                );
            end

            ItemLabel:SetText(itemLabel);
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

            --[[ EDIT BUTTON ]]
            local Edit = Interface:createButton(ActionButtons, {
                onClick = function()
                    self:closeSubWindows();
                    Interface.GDKP.EditAuction:draw(Session.ID, Auction.checksum);
                end,
                tooltip = "Edit",
                disabledTooltip = "You need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on deleted sessions",
                normalTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\edit",
                disabledTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\edit-disabled",
                update = function (self)
                    self:SetEnabled(not auctionWasDeleted and not Session.deletedAt);
                end,
            });
            Edit:SetPoint("TOPRIGHT", ItemRow.frame, "TOPRIGHT", -60, -10);
            self.ActionButtons[Auction.ID].EditButton = Edit;

            --[[ DELETE BUTTON ]]
            local Restore, Delete;
            if (not auctionWasDeleted) then
                Delete = Interface:createButton(ActionButtons, {
                    onClick = function()
                        -- Shift button was held, skip reason
                        if (IsShiftKeyDown()) then
                            GDKP:deleteAuction(Session.ID, Auction.ID, "-");
                            return;
                        end

                        Interface.Dialogs.ConfirmWithSingleInputDialog:open({
                            question = string.format("Provide a reason for deleting this entry"),
                            OnYes = function (reason)
                                GDKP:deleteAuction(Session.ID, Auction.ID, reason);
                            end,
                        });
                    end,
                    tooltip = "Delete",
                    disabledTooltip = "You need lead or master loot to delete entries.\nYou can't delete entries on deleted sessions",
                    normalTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\delete",
                    disabledTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\delete-disabled",
                    update = function (self)
                        self:SetEnabled(not auctionWasDeleted and not Session.deletedAt);
                    end,
                });
                Delete:SetPoint("TOPLEFT", Edit, "TOPRIGHT", 2, 0)
                self.ActionButtons[Auction.ID].DeleteButton = Delete;
            end

            --[[ RESTORE BUTTON ]]
            if (auctionWasDeleted) then
                Restore = Interface:createButton(ActionButtons, {
                    onClick = function() GDKP:restoreAuction(Session.ID, Auction.ID); end,
                    tooltip = "Restore",
                    disabledTooltip = "You need lead or master loot to restore entries.\nYou can't restore entries of deleted sessions",
                    normalTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\restore",
                    disabledTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\restore-disabled",
                    update = function (self)
                        self:SetEnabled(not Session.deletedAt);
                    end,
                });
                Restore:SetPoint("TOPLEFT", Edit, "TOPRIGHT", 2, 0);
                self.ActionButtons[Auction.ID].RestoreButton = Restore;
            end

            --[[ DETAILS BUTTON ]]
            local Eye = Interface:createButton(ActionButtons, {
                onClick = function()
                    self:closeSubWindows();
                    Interface.GDKP.AuctionDetails:draw(Session.ID, Auction.checksum);
                end,
                tooltip = "Details",
                normalTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\eye",
                disabledTexture = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\eye-disabled",
            });
            Eye:SetPoint("TOPLEFT", Delete or Restore, "TOPRIGHT", 2, 0);
            self.ActionButtons[Auction.ID].DetailsButton = Eye;
        end
    end);

    Interface:get(self, "GDKPOverview"):DoLayout();
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
            Events:fire("GL.GDKP_OVERVIEW_SESSION_CHANGED");
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
    local deletedAtPriorityModifier = 19999999999;
    local lowestPriorityTableItem = 1;
    local selectedTableItem;
    local tableItem = 1;

    for checksum, Session in pairs(DB:get("GDKP.Ledger", {})) do
        local title = Session.title;
        local priority = 99999999999 - (Session.createdAt or 0);

        local color = {r = 1, g = 1, b = 1};
        if (Session.deletedAt) then
            priority = priority + deletedAtPriorityModifier;
            color = {r = .77, g = .12, b = .23};
            title = title .. " (deleted)";
        end

        if (checksum == DB.GDKP.activeSession) then
            priority = 0;
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
        and TableData[lowestPriorityTableItem]
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

    Events:fire("GL.GDKP_OVERVIEW_SESSIONS_REFRESHED");
end

GL:debug("Interfaces/GDKP/Overview.lua");