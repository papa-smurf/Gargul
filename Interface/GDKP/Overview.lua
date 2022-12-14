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

---@type Settings
local Settings = GL.Settings;

---@type GDKPPot
local GDKPPot = GL.GDKP.Pot;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@type GDKPAuction
local GDKPAuction = GL.GDKP.Auction;

--[[ CONSTANTS ]]
local SESSION_ROWS = 22;
local HEIGHT_PER_SESSION_ROW = 16;

GL:tableSet(GL, "Interface.GDKP.Overview", {
    _initialized = false,
    isVisible = false,
    selectedSession = nil,
    styleWindowAfterResize = nil,

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

    GL.Events:register({
        {"GDKPOverviewGDKPAuctionChangedListener", "GL.GDKP_AUCTION_CHANGED"},
        {"GDKPOverviewGDKPSessionLockedListener", "GL.GDKP_SESSION_LOCKED"},
        {"GDKPOverviewGDKPSessionUnlockedListener", "GL.GDKP_SESSION_UNLOCKED"},
    }, function(e)
        if (not self.isVisible) then return; end
        GL.Ace:ScheduleTimer(function()
            self:updatePot();
            self:refreshLedger();
            self.styleWindowAfterResize();
        end, .1);
    end);

    GL.Events:register({
        { "GDKPOverviewGDKPActiveSessionChangedListener", "GL.GDKP_ACTIVE_SESSION_CHANGED" },
        { "GDKPOverviewGDKPSessionChangedListener", "GL.GDKP_SESSION_CHANGED" },
        { "GDKPOverviewGDKPSessionChangedListener", "GL.GDKP_SESSION_CREATED" }
    }, function()
        if (not self.isVisible) then return; end
        self:refreshSessions();
        self.styleWindowAfterResize();
    end);

    GL.Events:register({
        { "GDKPOverviewGDKPOverviewSessionChangedListener", "GL.GDKP_OVERVIEW_SESSION_CHANGED" },
        { "GDKPOverviewGDKPOverviewSessionsRefreshed", "GL.GDKP_OVERVIEW_SESSIONS_REFRESHED" }
    }, function ()
        self:sessionChanged();
        self.styleWindowAfterResize();
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

    local pot = GDKPPot:total(Session.ID);
    Pot:SetText(string.format("|cFF%s%sg|r", Constants.ClassHexColors.rogue, pot));
end

---@return void
function Overview:open()
    GL:debug("Interface.GDKP.Overview:draw");

    local Window = Interface:get(self, "GDKPOverview");

    if (not Window) then
        Window = self:build();
    end

    self:refreshLedger();

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

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

    Interface:AceGUIDefaults(self, Window, "GDKPOverview", 660, 410);
    Interface:resizeBounds(Window, 680, 300);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar

    --[[
        SETTINGS BUTTON
    ]]
    GL.UI:createSettingsButton(
        Window.frame,
        "GDKP"
    );

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
        Interface.GDKP.Distribute.Overview:open(self.selectedSession, true);
        Window.frame:Hide();
    end);

    PotIcon:SetCallback("OnEnter", function ()
        if (not self.selectedSession) then
            return;
        end

        local Session = GDKPSession:byID(self.selectedSession);
        local pot = GDKPPot:total(Session.ID);
        local numberOfRaidMembers = math.max(#GL.User:groupMemberNames(), 1);
        local managementCut = tonumber(Session.managementCut or 0) or 0;
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

    ---@todo add all items icon here (with loot tracked for this session)

    ----[[ LOCK STATUS ICON ]]

    local LockIcon = AceGUI:Create("Icon");

    ---@type Frame
    local RaiderconFrame = LockIcon.frame;

    LockIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/unlocked");
    LockIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/locked");
    LockIcon:SetImageSize(26, 26);
    LockIcon:SetWidth(26);
    LockIcon:SetHeight(26);
    Interface:set(self, "LockIcon", LockIcon);

    RaiderconFrame:SetParent(WindowFrame);
    RaiderconFrame:SetPoint("TOPRIGHT", Pot, "TOPLEFT", -20, 32);
    RaiderconFrame:Show();

    LockIcon:SetCallback("OnEnter", function ()
        GameTooltip:SetOwner(RaiderconFrame, "ANCHOR_TOP");
        GameTooltip:AddLine("Lock or unlock the session");
        GameTooltip:Show();
    end);
    LockIcon:SetCallback("OnLeave", function ()
        GameTooltip:Hide();
    end);

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
    Title:SetText("\n ");
    SecondColumn:AddChild(Title);

    local Note = AceGUI:Create("Label");
    Note:SetFontObject(_G["GameFontNormalSmall"]);
    Note:SetFullWidth(true);
    Note:SetText("\n ");
    SecondColumn:AddChild(Note);

    local ScrollFrameHolder = AceGUI:Create("InlineGroup");
    ScrollFrameHolder:SetLayout("FILL")
    ScrollFrameHolder:SetFullWidth(true)
    ScrollFrameHolder:SetFullHeight(true)
    SecondColumn:AddChild(ScrollFrameHolder);

    --[[ ALD GOLD BUTTON ]]
    local AddGoldButton = Interface:createButton(ScrollFrameHolder, {
        onClick = function()
            self:closeSubWindows();
            Interface.GDKP.AddGold:toggle(self.selectedSession);
        end,
        tooltip = "Add gold to pot",
        disabledTooltip = "You need lead or master loot to add gold.\nYou can't add gold to locked/deleted sessions",
        normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/create",
        disabledTexture = "Interface/AddOns/Gargul/Assets/Buttons/create-disabled",
        update = function (self)
            local SelectedSession = Overview:getSelectedSession();

            self:SetEnabled(SelectedSession and SelectedSession.deletedAt == nil and SelectedSession.lockedAt == nil and (not GL.User.isInGroup or GL.User.isLead or GL.User.isMasterLooter));
        end,
        updateOnCreate = false,
        updateOn = { "GROUP_ROSTER_UPDATE", "GL.GDKP_OVERVIEW_SESSION_CHANGED", "GL.GDKP_OVERVIEW_SESSION_CHANGED", "GL.GDKP_OVERVIEW_SESSIONS_REFRESHED" },
    });
    AddGoldButton:SetPoint("TOP", ScrollFrameHolder.frame, "TOP", -9, -7);

    ----[[ SHARE BUTTON ]]
    --Interface:createShareButton(ScrollFrameHolder, {
    --    onClick = function() Interface.Dialogs.PopupDialog:open("BROADCAST_GDKP_CONFIRMATION"); end,
    --    tooltip = "Broadcast data",
    --    disabledTooltip = "Broadcast data: you need loot master, assist or lead!",
    --    position = "TOPCENTER",
    --    update = function (self) self:SetEnabled(self.selectedSession and GDKP:userIsAllowedToBroadcast()); end,
    --    updateOn = "GROUP_ROSTER_UPDATE",
    --    x = 16,
    --});

    ----[[ LIST VIEW BUTTON ]]
    local ListViewButton = Interface:createButton(ScrollFrameHolder, {
        onClick = function()
            GL.Interface.GDKP.LedgerList:toggle(self.selectedSession);
        end,
        tooltip = "Show a condensed view of the ledger,\nideal for screenshotting purposes!",
        normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/eye",
        disabledTexture = "Interface/AddOns/Gargul/Assets/Buttons/eye-disabled",
        updateOn = { "GL.GDKP_OVERVIEW_SESSION_CHANGED", "GL.GDKP_OVERVIEW_SESSION_CHANGED", "GL.GDKP_OVERVIEW_SESSIONS_REFRESHED", "GL.GDKP_AUCTION_CHANGED" },
        update = function (self)
            self:SetEnabled(not GL:empty(GL:tableGet(Overview:getSelectedSession() or {}, "Auctions")));
        end,
    });
    ListViewButton:SetPoint("TOPLEFT", AddGoldButton, "TOPRIGHT", 2, 0);

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
            GDKPSession:setActive(self.selectedSession);
        else
            GDKPSession:clearActive();
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
            GDKPSession:delete(self.selectedSession);
        else
            GDKPSession:restore(self.selectedSession);
        end
    end);
    Interface:set(self, "DeleteRestore", DeleteOrRestoreSession);

    DeleteOrRestoreSession:SetCallback("OnEnter", function ()
        GameTooltip:SetOwner(DeleteOrRestoreSession.frame, "ANCHOR_TOP");
        GameTooltip:AddLine("Sessions with auctions attached to them will be deleted after 48 hours");
        GameTooltip:Show();
    end);
    DeleteOrRestoreSession:SetCallback("OnLeave", function ()
        GameTooltip:Hide();
    end);

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
        GL.Interface.GDKP.Distribute.Overview:open(self.selectedSession, true);
        Window.frame:Hide();
    end);

    ThirdColumn:AddChildren(EnableOrDisableSession, CreateSession, EditSession, DeleteOrRestoreSession, Export, Distribute);
    ThirdColumn.frame:SetParent(WindowFrame);
    ThirdColumn.frame:SetPoint("BOTTOMLEFT", WindowFrame, "BOTTOMLEFT", 20, 15);

    self:refreshSessions();

    local originalOnHeightSet = Window.OnHeightSet;
    self.styleWindowAfterResize = function ()
        SecondColumn:SetWidth(math.max(WindowFrame:GetWidth() - FirstColumn.frame:GetWidth() - 50, 100));
        ScrollFrameHolder:DoLayout();
        SecondColumn:DoLayout();
        Window:DoLayout();

        self.SessionsTable:SetDisplayRows(math.floor(FirstColumn.frame:GetHeight() / HEIGHT_PER_SESSION_ROW - 1), HEIGHT_PER_SESSION_ROW);
    end;
    Window.OnHeightSet = function (...)
        originalOnHeightSet(...);
        self.styleWindowAfterResize();
    end

    GL.Ace:ScheduleTimer(function()
        self.styleWindowAfterResize();
    end, .05);

    return Window;
end

---@return void
function Overview:close()
    GL:debug("Overview:close");

    self:closeSubWindows();
    self:clearDetailsFrame();

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

    return GDKPSession:byID(sessionIdentifier);
end

---@return void
function Overview:refreshLedger()
    GL:debug("Overview:drawDetails");

    local LockIcon = Interface:get(self, "Icon.LockIcon");
    LockIcon.frame:Show();

    if (not self.selectedSession) then
        LockIcon.frame:Hide();
        return self:showTutorial();
    end

    local Session = self:getSelectedSession();

    if (not Session) then
        return GL:warning(string.format("Unknown GDKP session '%s'", self.selectedSession));
    end

    local question;
    if (Session.lockedAt) then
        LockIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/locked");
        question = "Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?";
    else
        LockIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/unlocked");
        question = "Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?";
    end
    LockIcon:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open({
            question = question,
            OnYes = function ()
                GDKPSession:toggleLock(self.selectedSession);
            end,
        });
    end);

    if (GL:empty(Session.Auctions)) then
        LockIcon.frame:Hide();
        return self:showTutorial();
    end

    self:clearDetailsFrame();

    local Wrapper = Interface:get(self, "Frame.SectionWrapper");
    local Details = Interface:get(self, "ScrollFrame.SessionDetails") or GL.AceGUI:Create("ScrollFrame");
    Details:SetLayout("Flow");
    Interface:set(self, "SessionDetails", Details);
    Wrapper:AddChild(Details);

    local Title = Interface:get(self, "Label.Title");
    Title:SetText(string.format("\n|c00%s%s|r", Constants.addonHexColor, Session.title));

    local Note = Interface:get(self, "Label.Note");
    local CreatedBy = Session.CreatedBy or {class = "priest", name = "unknown", guild = "unknown", uuid = "unknown"};
    local managementCut = "";
    local guild = "";

    if (Session.managementCut) then
        managementCut = string.format(" | Cut |c00%s%s%%|r", Constants.addonHexColor, Session.managementCut);
    end

    if (CreatedBy.guild) then
        guild = string.format(" |c001eff00<%s>|r", CreatedBy.guild);
    end

    Note:SetText(string.format(
        "By |c00%s%s|r%s | On |c00%s%s|r%s",
        GL:classHexColor(CreatedBy.class),
        CreatedBy.name,
        guild,
        Constants.addonHexColor,
        date('%Y-%m-%d', Session.createdAt),
        managementCut
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
            local concernsManualAdjustment = Auction.itemID == Constants.GDKP.potIncreaseItemID;

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
            ItemRow:SetHeight(Settings:get("GDKP.ledgerAuctionScale"));
            ItemRow:SetFullWidth(true);
            Details:AddChild(ItemRow);

            --[[
                ITEM ICON
            ]]
            local ItemIcon = AceGUI:Create("Icon");
            ItemIcon:SetWidth(Settings:get("GDKP.ledgerAuctionScale"));
            ItemIcon:SetHeight(Settings:get("GDKP.ledgerAuctionScale"));
            ItemIcon:SetImageSize(Settings:get("GDKP.ledgerAuctionScale"), Settings:get("GDKP.ledgerAuctionScale"));
            ItemIcon:SetImage(iconPath);
            ItemRow:AddChild(ItemIcon);
            ItemIcon:SetCallback("OnEnter", function()
                if (concernsManualAdjustment) then
                    return;
                end

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
            ItemSpacer:SetHeight(Settings:get("GDKP.ledgerAuctionScale"));
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

            self.ActionButtons[Auction.ID] = {};

            --[[ DETAILS BUTTON ]]
            local Eye = Interface:createButton(ItemRow.frame, {
                onClick = function()
                    Interface.GDKP.AuctionDetails:toggle(Session.ID, Auction.checksum);
                end,
                tooltip = "Details",
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/eye",
                disabledTexture = "Interface/AddOns/Gargul/Assets/Buttons/eye-disabled",
            });
            Eye:SetPoint("CENTER", ItemRow.frame, "CENTER");
            Eye:SetPoint("RIGHT", ItemRow.frame, "RIGHT", 0, 0);
            self.ActionButtons[Auction.ID].DetailsButton = Eye;

            --[[ DELETE BUTTON ]]
            local Restore, Delete;
            if (not auctionWasDeleted) then
                Delete = Interface:createButton(ItemRow.frame, {
                    onClick = function()
                        -- Shift button was held, skip reason
                        if (IsShiftKeyDown()) then
                            GDKPAuction:delete(Session.ID, Auction.ID, "-");
                            return;
                        end

                        Interface.Dialogs.ConfirmWithSingleInputDialog:open({
                            question = string.format("Provide a reason for deleting this entry"),
                            OnYes = function (reason)
                                GDKPAuction:delete(Session.ID, Auction.ID, reason);
                            end,
                        });
                    end,
                    tooltip = "Delete. Hold shift to bypass note",
                    disabledTooltip = "You need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions",
                    normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/delete",
                    disabledTexture = "Interface/AddOns/Gargul/Assets/Buttons/delete-disabled",
                    update = function (self)
                        self:SetEnabled(not auctionWasDeleted and not Session.deletedAt and not Session.lockedAt);
                    end,
                });
                Delete:SetPoint("TOPRIGHT", Eye, "TOPLEFT", -2, 0);
                self.ActionButtons[Auction.ID].DeleteButton = Delete;
            end

            --[[ RESTORE BUTTON ]]
            if (auctionWasDeleted) then
                Restore = Interface:createButton(ItemRow.frame, {
                    onClick = function() GDKPAuction:restore(Session.ID, Auction.ID); end,
                    tooltip = "Restore",
                    disabledTooltip = "You need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions",
                    normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/restore",
                    disabledTexture = "Interface/AddOns/Gargul/Assets/Buttons/restore-disabled",
                    update = function (self)
                        self:SetEnabled(not Session.deletedAt and not Session.lockedAt);
                    end,
                });
                Restore:SetPoint("TOPRIGHT", Eye, "TOPLEFT", -2, 0);
                self.ActionButtons[Auction.ID].RestoreButton = Restore;
            end

            --[[ EDIT BUTTON ]]
            local Edit = Interface:createButton(ItemRow.frame, {
                onClick = function()
                    self:closeSubWindows();
                    Interface.GDKP.EditAuction:draw(Session.ID, Auction.checksum);
                end,
                tooltip = "Edit",
                disabledTooltip = "You need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions",
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/edit",
                disabledTexture = "Interface/AddOns/Gargul/Assets/Buttons/edit-disabled",
                update = function (self)
                    self:SetEnabled(not auctionWasDeleted and not Session.deletedAt and not Session.lockedAt);
                end,
            });
            Edit:SetPoint("TOPRIGHT", Delete or Restore, "TOPLEFT", -2, 0);
            self.ActionButtons[Auction.ID].EditButton = Edit;
        end
    end);

    Interface:get(self, "GDKPOverview"):DoLayout();
end

---@return void
function Overview:showTutorial()
    GL:debug("Overview:drawDetails");

    self:clearDetailsFrame();

    local Wrapper = Interface:get(self, "Frame.SectionWrapper");
    local Details = Interface:get(self, "ScrollFrame.SessionDetails") or GL.AceGUI:Create("ScrollFrame");
    Details:SetLayout("Flow");
    Interface:set(self, "SessionDetails", Details);
    Wrapper:AddChild(Details);

    local Title = Interface:get(self, "Label.Title");
    Title:SetText("\n|c00FFF569Getting started|r");

    local Note = Interface:get(self, "Label.Note");
    Note:SetText("|c00a79effFollow the steps below to quickly get started with Gargul GDKP!|r");

    local Steps = {
        {1, "|c00a79effGargul's GDKP module is |c00FFF569currently in beta, use at your own risk|r and record the raid/keep track of sales manually just in case!|r"},
        {2, "|c00a79effClick the |c00FFF569New|r button below to create a GDKP session. It will show on the left when done.|r"},
        {3, "|c00a79effMake sure your session says |c00FFF569(active)|r. If that's not the case then click the |c00a79effEnable|r button below!|r"},
        {4, string.format("|c00a79effYou can now start auctioning off items. Open your inventory, |c00FFF569%s|r an item and start. Don't forget to award the item when you're done!|r", GL.Settings:get("ShortcutKeys.rollOffOrAuction"))},
        {5, "|c00a79effIf all went well then, instead of this tutorial, you should see your freshly auctioned item(s) here!|r"},
    };

    table.sort(Steps, function (a, b)
        return a[1] < b[1];
    end);

    -- Add placeholders for all the item icons and labels
    for order, Step in pairs(Steps) do
        local step = Step[2];
        local iconPath = "Interface/AddOns/Gargul/Assets/Icons/" .. order;

        local ItemRow = AceGUI:Create("SimpleGroup");
        ItemRow:SetLayout("FLOW")
        ItemRow:SetHeight(Settings:get("GDKP.ledgerAuctionScale"));
        ItemRow:SetFullWidth(true);
        Details:AddChild(ItemRow);

        --[[
            ITEM ICON
        ]]
        local ItemIcon = AceGUI:Create("Icon");
        ItemIcon:SetWidth(Settings:get("GDKP.ledgerAuctionScale"));
        ItemIcon:SetHeight(Settings:get("GDKP.ledgerAuctionScale"));
        ItemIcon:SetImageSize(Settings:get("GDKP.ledgerAuctionScale"), Settings:get("GDKP.ledgerAuctionScale"));
        ItemIcon:SetImage(iconPath);
        ItemRow:AddChild(ItemIcon);

        if (order == 1) then
            local BorderColor = {.77, .12, .23, 1};
            local LCG = LibStub("LibCustomGlowGargul-1.0");
            LCG.PixelGlow_Start(ItemRow.frame, BorderColor, 70, .05, 5, 3, 10);
        end

        --[[
           ITEM ICON/LABEL SPACER
        ]]
        local ItemSpacer = AceGUI:Create("SimpleGroup");
        ItemSpacer:SetLayout("FILL")
        ItemSpacer:SetWidth(10);
        ItemSpacer:SetHeight(Settings:get("GDKP.ledgerAuctionScale"));
        ItemRow:AddChild(ItemSpacer);

        --[[
            ITEM LABEL
        ]]
        local ItemLabel = AceGUI:Create("Label");
        ItemLabel:SetFontObject(_G["GameFontNormalSmall"]);
        ItemLabel:SetWidth(268);
        ItemLabel:SetText(step);
        ItemRow:AddChild(ItemLabel);
    end

    self.styleWindowAfterResize();
    Interface:get(self, "GDKPOverview"):DoLayout();
end

-- Clear the details frame
function Overview:clearDetailsFrame()
    GL:debug("GDKP:clearDetailsFrame");

    -- Release all of the action buttons into our pool so that we can reuse them later
    for _, Buttons in pairs(self.ActionButtons or {}) do
        for _, Button in pairs(Buttons) do
            Interface:releaseButton(Button);
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

    local ScrollFrame = Interface:get(self, "ScrollFrame.SessionDetails");
    if (ScrollFrame) then
        local children = ScrollFrame.children or {};
        for i = 1,#children do
            children[i].frame:Hide();
            children[i] = nil;
        end
    end
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