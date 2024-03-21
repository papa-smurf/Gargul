local L = Gargul_L;

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
local HEIGHT_PER_SESSION_ROW = 18;

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
    if (self._initialized) then
        return;
    end

    self._initialized = true;

    GL.Events:register({
        {"GDKPOverviewGDKPAuctionChangedListener", "GL.GDKP_AUCTION_CHANGED"},
        {"GDKPOverviewGDKPSessionLockedListener", "GL.GDKP_SESSION_LOCKED"},
        {"GDKPOverviewGDKPSessionUnlockedListener", "GL.GDKP_SESSION_UNLOCKED"},
    }, function()
        GL.Ace:ScheduleTimer(function()
            self:updatePot();

            if (not self.isVisible) then return; end
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

---@return void
function Overview:sessionChanged()
    local Session = self:getSelectedSession();

    if (not Session) then
        return GL:debug(("Unknown GDKP session '%s'"):format(self.selectedSession));
    end

    local DeleteOrRestoreButton = Interface:get(self, "Button.DeleteRestore");
    if (DeleteOrRestoreButton) then
        if (Session.deletedAt) then
            DeleteOrRestoreButton:SetText(L.RESTORE);
            DeleteOrRestoreButton:SetWidth(78);
            DeleteOrRestoreButton.mode = "restore";
        else
            DeleteOrRestoreButton:SetText(L.DELETE);
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
            EnableOrDisableButton:SetText(L.DISABLE);
            EnableOrDisableButton.mode = "disable";
        else
            EnableOrDisableButton:SetText(L.ENABLE);
            EnableOrDisableButton.mode = "enable";
        end
    end

    self:refreshLedger();
    self:updatePot();
end

---@return void
function Overview:updatePot()
    local Session = self:getSelectedSession();

    if (not Session) then
        return;
    end

    local Pot = Interface:get(self, "Frame.Pot");

    if (not Pot) then
        return;
    end

    local pot = GDKPPot:humanTotal(Session.ID);
    Pot:SetText(string.format("|cFF%s%s|r", Interface.Colors.ROGUE, pot));
end

---@return void
function Overview:open()
    if (not GL.GDKPIsAllowed) then
        return GL:error(L.GDKPS_ARE_NOT_ALLOWED);
    end

    local Window = Interface:get(self, "GDKPOverview");

    if (not Window) then
        Window = self:build();
    end

    self:updatePot();
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
    local Cogwheel = GL.UI:createSettingsButton(
        Window.frame,
        "GDKP"
    );
    Cogwheel:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            Interface:get(self, "GDKPOverview"):Hide();

            GL.Settings:draw("GDKP", function ()
                self:open();
            end);
        end
    end);

    --[[ POT ICON AND VALUE ]]
    local PotIcon = AceGUI:Create("Icon");

    ---@type Frame
    local PotIconFrame = PotIcon.frame;

    PotIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/achievement_guildperk_cashflow");
    PotIcon:SetImageSize(26, 26);
    PotIcon:SetWidth(26);
    PotIcon:SetHeight(26);

    PotIconFrame:SetParent(WindowFrame);
    PotIconFrame:SetPoint("TOPRIGHT", WindowFrame, "TOPRIGHT", -42, GL.elvUILoaded and -14 or -20);
    PotIconFrame:Show();

    PotIcon:SetCallback("OnClick", function ()
        local Session = GDKPSession:byID(self.selectedSession);

        if (Session and not GL:empty(Session.Auctions)) then
            Interface.GDKP.Distribute.Overview:open(self.selectedSession, true);
            Window.frame:Hide();
        end
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

        Interface:addTooltip(PotIcon, (L.GDKP_OVERVIEW_POT_TOOLTIP):format(
            GL:goldToMoney(pot),
            managementCut,
            managementPot,
            numberOfRaidMembers,
            GL:floor((pot - managementPot) / numberOfRaidMembers, Settings:get("GDKP.precision"))
        ), "TOP");
    end);

    local Pot = PotIconFrame:CreateFontString(nil, "ARTWORK", "GameFontWhite");
    Pot:SetPoint("CENTER", PotIconFrame, "CENTER");
    Pot:SetPoint("TOP", PotIconFrame, "BOTTOM", 0, -6);
    Pot:SetText();
    Interface:set(self, "Pot", Pot);

    --[[ MULTI AUCTION ICON ]]
    local MultiAuctionIcon = AceGUI:Create("Icon");

    ---@type Frame
    local MultiAuctionFrame = MultiAuctionIcon.frame;

    MultiAuctionIcon:SetImage("Interface/icons/ACHIEVEMENT_Guildperk_Everybodysfriend");
    MultiAuctionIcon:SetImageSize(26, 26);
    MultiAuctionIcon:SetWidth(26);
    MultiAuctionIcon:SetHeight(26);

    MultiAuctionFrame:SetParent(WindowFrame);
    MultiAuctionFrame:SetPoint("TOPRIGHT", Pot, "TOPLEFT", -16, 32);
    MultiAuctionFrame:Show();

    Interface:addTooltip(MultiAuctionFrame, L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP, "TOP")

    MultiAuctionIcon:SetCallback("OnClick", function()
        self:close();
        Interface.GDKP.MultiAuction.Auctioneer:open();
    end);

    --[[ LOCK STATUS ICON ]]
    local LockIcon = AceGUI:Create("Icon");

    ---@type Frame
    local LockIconFrame = LockIcon.frame;

    LockIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/unlocked");
    LockIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/locked");
    LockIcon:SetImageSize(26, 26);
    LockIcon:SetWidth(26);
    LockIcon:SetHeight(26);
    Interface:set(self, "LockIcon", LockIcon);

    LockIconFrame:SetParent(WindowFrame);
    LockIconFrame:SetPoint("TOPRIGHT", MultiAuctionFrame, "TOPLEFT", -20, 0);
    LockIconFrame:Show();

    Interface:addTooltip(LockIcon, function ()
        local Session = self:getSelectedSession();
        if (not Session) then
            return L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP;
        end

        return Session.lockedAt and L.GDKP_OVERVIEW_UNLOCK_TOOLTIP or L.GDKP_OVERVIEW_LOCK_TOOLTIP;
    end, "TOP");

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

    --[[ ADD GOLD BUTTON ]]
    local AddGoldButton = Interface:createButton(ScrollFrameHolder, {
        onClick = function()
            self:closeSubWindows();
            Interface.GDKP.AddGold:toggle(self.selectedSession);
        end,
        tooltip = L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP,
        disabledTooltip = L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP,
        normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/bag",
        update = function (self)
            local SelectedSession = Overview:getSelectedSession();

            self:SetEnabled(SelectedSession and SelectedSession.deletedAt == nil and SelectedSession.lockedAt == nil and (not GL.User.isInGroup or GL.User.isLead or GL.User.isMasterLooter));
        end,
        updateOnCreate = false,
        updateOn = {
            "GROUP_ROSTER_UPDATE",
            "GL.GDKP_OVERVIEW_SESSION_CHANGED",
            "GL.GDKP_OVERVIEW_SESSION_CHANGED",
            "GL.GDKP_OVERVIEW_SESSIONS_REFRESHED",
            "GL.GDKP_SESSION_CHANGED",
            "GL.GDKP_SESSION_LOCKED",
            "GL.GDKP_SESSION_UNLOCKED",
        },
    });
    AddGoldButton:SetPoint("TOP", ScrollFrameHolder.frame, "TOP", -9, -7);

    ----[[ LIST VIEW BUTTON ]]
    local ListViewButton = Interface:createButton(ScrollFrameHolder, {
        onClick = function()
            Window:Hide();
            GL.Interface.GDKP.LedgerList:open(self.selectedSession);
        end,
        tooltip = L.GDKP_OVERVIEW_LEDGER_TOOLTIP,
        normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/eye",
        updateOn = { "GL.GDKP_OVERVIEW_SESSION_CHANGED", "GL.GDKP_OVERVIEW_SESSION_CHANGED", "GL.GDKP_OVERVIEW_SESSIONS_REFRESHED", "GL.GDKP_AUCTION_CHANGED", },
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
    ThirdColumn:SetWidth(600);
    ThirdColumn:SetHeight(40);

    local EnableOrDisableSession = AceGUI:Create("Button");
    EnableOrDisableSession:SetText(L.ENABLE);
    EnableOrDisableSession:SetWidth(74); --TODO:TOO SHORT FOR FR
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
    CreateSession:SetText(L.NEW); 
    CreateSession:SetWidth(64); --TODO:TOO SHORT FOR FR
    CreateSession:SetHeight(20);
    CreateSession:SetCallback("OnClick", function()
        self:closeSubWindows();
        Interface.GDKP.CreateSession:toggle();
    end);

    local EditSession = AceGUI:Create("Button");
    EditSession:SetText(L.EDIT); 
    EditSession:SetWidth(60); --TODO:TOO SHORT FOR FR
    EditSession:SetHeight(20);
    EditSession:SetCallback("OnClick", function()
        self:closeSubWindows();
        Interface.GDKP.EditSession:toggle(self.selectedSession);
    end);

    local DeleteOrRestoreSession = AceGUI:Create("Button");
    DeleteOrRestoreSession:SetText(L.DELETE);
    DeleteOrRestoreSession:SetWidth(72); --TODO:TOO SHORT FOR FR
    DeleteOrRestoreSession:SetHeight(20);
    DeleteOrRestoreSession:SetCallback("OnClick", function()
        if (DeleteOrRestoreSession.mode == "delete") then
            GDKPSession:delete(self.selectedSession);
        else
            GDKPSession:restore(self.selectedSession);
        end
    end);
    Interface:set(self, "DeleteRestore", DeleteOrRestoreSession);
    GL.Interface:addTooltip(DeleteOrRestoreSession.frame, L.GDKP_OVERVIEW_DELETE_TOOLTIP);

    local Import = AceGUI:Create("Button");
    Import:SetText(L.IMPORT);
    Import:SetWidth(76);
    Import:SetHeight(20);
    Import:SetCallback("OnClick", function()
        GL.Interface.GDKP.Import:open();
    end);
    GL.Interface:addTooltip(Import, L.GDKP_OVERVIEW_IMPORT_TOOLTIP);

    local Export = AceGUI:Create("Button");
    Export:SetText(L.EXPORT);
    Export:SetWidth(72); --TODO:TOO SHORT FOR FR
    Export:SetHeight(20);
    Export:SetCallback("OnClick", function()
        GL.Interface.GDKP.Export:open(self.selectedSession);
    end);
    GL.Interface:addTooltip(Export, L.GDKP_OVERVIEW_EXPORT_TOOLTIP);

    local Cuts = AceGUI:Create("Button");
    Cuts:SetText(L.CUTS);
    Cuts:SetWidth(90);
    Cuts:SetHeight(20);
    Cuts:SetCallback("OnClick", function()
        GL.Interface.GDKP.Distribute.Overview:open(self.selectedSession, true);
        Window.frame:Hide();
    end);

    ThirdColumn:AddChildren(EnableOrDisableSession, CreateSession, EditSession, DeleteOrRestoreSession, Import, Export, Cuts);
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
    local Window = Interface:get(self, "GDKPOverview");

    if (Window and Window.Hide) then
        Window:Hide();
    end

    self:closeSubWindows();
    self:clearDetailsFrame();

    self.isVisible = false;
end

---@return void
function Overview:closeSubWindows()
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
    local sessionIdentifier = self.selectedSession;
    if (not sessionIdentifier) then
        return;
    end

    return GDKPSession:byID(sessionIdentifier);
end

---@return void
function Overview:refreshLedger()
    local LockIcon = Interface:get(self, "Icon.LockIcon");
    LockIcon.frame:Show();

    if (not self.selectedSession) then
        LockIcon.frame:Hide();
        return self:showTutorial();
    end

    local Session = self:getSelectedSession();

    if (not Session) then
        return;
    end

    local question;
    if (Session.lockedAt) then
        LockIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/locked");
        question = L.GDKP_OVERVIEW_UNLOCK_CONFIRM;
    else
        LockIcon:SetImage("Interface/AddOns/Gargul/Assets/Icons/unlocked");
        question = L.GDKP_OVERVIEW_LOCK_CONFIRM;
    end
    LockIcon:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open{
            question = question,
            OnYes = function ()
                GDKPSession:toggleLock(self.selectedSession);
            end,
        };
    end);

    if (GL:empty(Session.Auctions)) then
        LockIcon.frame:Hide();
        return self:showTutorial();
    end

    local Wrapper = Interface:get(self, "Frame.SectionWrapper");
    local Details = Interface:get(self, "ScrollFrame.SessionDetails") or GL.AceGUI:Create("ScrollFrame");
    Interface:set(self, "SessionDetails", Details);
    Details:SetLayout("Flow");
    Wrapper:AddChild(Details);

    local Title = Interface:get(self, "Label.Title");
    Title:SetText(string.format("\n|c00%s%s|r", Constants.addonHexColor, Session.title));

    local Note = Interface:get(self, "Label.Note");
    local CreatedBy = Session.CreatedBy or { class = "priest", name = L.UNKNOWN, guild = L.UNKNOWN, uuid = L.UNKNOWN, };
    local managementCut = "";
    local guild = "";

    if (Session.managementCut) then
        managementCut = (" | %s |c00%s%s%%|r"):format(L.CUT, Constants.addonHexColor, Session.managementCut);
    end

    if (CreatedBy.guild) then
        guild = string.format(" |c001EFF00<%s>|r", CreatedBy.guild);
    end

    Note:SetText((L.GDKP_OVERVIEW_SESSION_DETAILS):format(
        GL:nameFormat{ name = CreatedBy.name, realm = CreatedBy.realm, colorize = true, },
        guild,
        Constants.addonHexColor,
        date(L.DATE_FORMAT, Session.createdAt),
        managementCut
    ));

    GL:onItemLoadDo(GL:tableColumn(Session.Auctions, "itemLink"), function ()
        self:clearDetailsFrame();
        local Auctions = {};
        local RawAuctions = Session.Auctions or {};

        -- RawAuctions is an associative table, which does not work with table.sort
        for checksum, Entry in pairs(RawAuctions) do
            Entry.checksum = checksum; -- We need this step because the table.sort will remove the keys
            tinsert(Auctions, Entry);
        end

        -- Sort the auctions based on date/time (highest to lowest)
        table.sort(Auctions, function (a, b)
            local aCreatedAt = tonumber(a.createdAt);
            local bCreatedAt = tonumber(b.createdAt);

            if (aCreatedAt and bCreatedAt) then
                return aCreatedAt > bCreatedAt;
            end

            return false;
        end);

        -- Add placeholders for all the item icons and labels
        for _, Auction in pairs(Auctions) do
            local price = Auction.price or 0;
            local auctionWasDeleted = not Auction.price;
            local concernsManualAdjustment = Auction.itemID == Constants.GDKP.potIncreaseItemID;

            -- This entry should always exist, if it doesn't something went wrong (badly)
            local ItemEntry = GL:getCachedItem(Auction.itemLink);

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
            ItemIcon:SetCallback("OnClick", function (_, _, mouseButtonPressed)
                HandleModifiedItemClick(ItemEntry.link, mouseButtonPressed);
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
                price = price or 0;
                if (concernsManualAdjustment) then
                    local mutator = L.GDKP_OVERVIEW_MUTATION_ADDED;
                    if (price < 0) then
                        mutator = L.GDKP_OVERVIEW_MUTATION_REMOVED;
                    end

                    itemLabel = (L.GDKP_OVERVIEW_MUTATION_ENTRY):format(
                        Interface.Colors.ROGUE,
                        GL:goldToMoney(price),
                        mutator,
                        GL:nameFormat{ name = Auction.Winner.name, class = Auction.Winner.class, colorize = true, },
                        Auction.note or ""
                    );
                else
                    itemLabel = (L.GDKP_OVERVIEW_AUCTION_ENTRY):format(
                        GL:nameFormat{ name = Auction.Winner.name, class = Auction.Winner.class, colorize = true, },
                        Interface.Colors.ROGUE,
                        GL:goldToMoney(price),
                        ItemEntry.link
                    );
                end

            -- Item was deleted
            else
                local reason = Auction.reason;

                if (GL:empty(reason)) then
                    reason = "-";
                end

                itemLabel = (L.GDKP_OVERVIEW_DELETED_ENTRY):format(
                    GL:nameFormat{ name = Auction.CreatedBy.name, class = Auction.CreatedBy.class, colorize = true, },
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
                tooltip = L.DETAILS,
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/eye",
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
                            question = L.GDKP_OVERVIEW_DELETE_ENTRY_REASON,
                            OnYes = function (reason)
                                GDKPAuction:delete(Session.ID, Auction.ID, reason);
                            end,
                        });
                    end,
                    tooltip = L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP,
                    disabledTooltip = L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP,
                    normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/delete",
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
                    tooltip = L.RESTORE,
                    disabledTooltip = L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP,
                    normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/restore",
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
                tooltip = L.EDIT,
                disabledTooltip = L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP,
                normalTexture = "Interface/AddOns/Gargul/Assets/Buttons/edit",
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
    self:clearDetailsFrame();

    local Wrapper = Interface:get(self, "Frame.SectionWrapper");
    local Details = Interface:get(self, "ScrollFrame.SessionDetails") or GL.AceGUI:Create("ScrollFrame");
    Details:SetLayout("Flow");
    Interface:set(self, "SessionDetails", Details);
    Wrapper:AddChild(Details);

    local Title = Interface:get(self, "Label.Title");
    Title:SetText(("\n|c00FFF569%s|r"):format(L.GDKP_TUTORIAL_TITLE));

    local Note = Interface:get(self, "Label.Note");
    Note:SetText(("|c00A79EFF%s|r"):format(L.GDKP_TUTORIAL_INFO));

    local Steps;
    if (GL:empty(DB:get("GDKP.Ledger"))) then
        Steps = {
            {1, ("|c00A79EFF%s|r"):format(L.GDKP_TUTORIAL_STEP_NEW), },
        };
    elseif (not GDKPSession:activeSessionID()
        or GDKPSession:activeSessionID() ~= self.selectedSession
    ) then
        Steps = {
            {1, ("|c00A79EFF%s|r"):format(L.GDKP_TUTORIAL_STEP_ACTIVATE), },
        };
    else
        Steps = {
            {1, ("|c00A79EFF%s|r"):format(L.GDKP_TUTORIAL_STEP_READY), },
            {2, ("|c00A79EFF%s|r"):format((L.GDKP_TUTORIAL_STEP_AUCTION):format(GL.Settings:get("ShortcutKeys.rollOffOrAuction"))), },
            {3, ("|c00A79EFF%s|r"):format(L.GDKP_TUTORIAL_STEP_MULTI_AUCTION), },
            {4, ("|c00A79EFF%s|r"):format((L.GDKP_TUTORIAL_STEP_SELL):format(GL.Settings:get("ShortcutKeys.award"))), },
            {5, ("|c00A79EFF%s|r"):format(L.GDKP_TUTORIAL_STEP_DONE), },
            {6, ("|c00A79EFF%s|r"):format(L.GDKP_TUTORIAL_STEP_COMMANDS), },
        };
    end

    table.sort(Steps, function (a, b)
        if (a[1] and b[1]) then
            return a[1] < b[1];
        end

        return false;
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
    -- Release all of the action buttons into our pool so that we can reuse them later
    for _, Buttons in pairs(self.ActionButtons or {}) do
        for _, Button in pairs(Buttons) do
            Interface:releaseButton(Button);
        end
    end

    self.ActionButtons = {};

    local ScrollFrame = Interface:get(self, "ScrollFrame.SessionDetails");
    if (ScrollFrame) then
        GL.Interface:releaseChildren(ScrollFrame);
    end
end

--- Draw the GDKP sessions table (left-hand side of the overview)
---
---@return void
function Overview:createSessionsTable()
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
            title = ("%s " .. L.GDKP_OVERVIEW_DELETED_SESSION):format(title);
        end

        if (checksum == DB.GDKP.activeSession) then
            priority = 0;
            title = ("%s " .. L.GDKP_OVERVIEW_ACTIVE_SESSION):format(title);
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
