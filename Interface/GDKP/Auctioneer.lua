---@type GL
local _, GL = ...;

---@type GDKP
local GDKP = GL.GDKP;

---@type GDKPAuction
local GDKPAuction = GDKP.Auction;

---@type Settings
local Settings = GL.Settings;

---@type Interface
local Interface = GL.Interface;

---@type GDKPSession
local GDKPSession = GDKP.Session;

local AceGUI = GL.AceGUI;
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

GL.Interface.GDKP = GL.Interface.GDKP or {};

---@class GDKPAuctioneerInterface
GL.Interface.GDKP.Auctioneer = {
    isVisible = false,
    itemBoxHoldsValidItem = false,
    queueModeActivated = false,

    Defaults = {
        itemIcon = "Interface\\Icons\\INV_Misc_QuestionMark",
        itemBoxText = "",
    },
    PlayersTable = {},
    PopTimer = nil,
};

---@type GDKPAuctioneerInterface
local Auctioneer = GL.Interface.GDKP.Auctioneer;

--[[ CONSTANTS ]]
local QUEUE_MAX_ITEMS = 18;

function Auctioneer:draw(itemLink)
    GL:debug("Auctioneer:draw");

    if (GL.User.isInGroup
        and not GL.User.isMasterLooter
        and not GL.User.hasAssist
    ) then
        return GL:warning("You need to be the master looter or have an assist / lead role!");
    end

    -- Close the reopen auctioneer button if it exists
    self:closeReopenAuctioneerButton();

    -- First we need to check if the frame hasn't been
    -- rendered already. If so then show it (if it's hidden)
    -- and pass the itemLink along in case one was provided
    local Window = Interface:get(self, "Window");
    if (Window) then
        if (itemLink) then
            Auctioneer:passItemLink(itemLink);
        end

        -- If the frame is hidden we need to show it again
        if (not self.isVisible) then
            self:refreshQueueTable();
            Interface:get(self, "Frame.QueueWindow").frame:Show();
            self:show(Window);
        end

        return;
    end

    self.isVisible = true;
    self.queueModeActivated = Settings:get("GDKP.enableGDKPQueuesByDefault");

    local HelpIcon;

    -- Create a container/parent frame
    Window = AceGUI:Create("Frame", "GARGUL_AUCTIONEER_WINDOW");
    Window:SetTitle("Gargul GDKP Auction");
    Window:SetLayout("Flow");
    Window:SetWidth(410);
    Window:SetHeight(416);
    Window:EnableResize(false);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    self:show(Window);
    Interface:set(self, "Window", Window);
    Interface:restorePosition(Window, "Auctioneer");

    --[[ QUEUE STUFF === ]]

    do
        local QueueWindow = AceGUI:Create("InlineGroup");
        QueueWindow:SetLayout("Flow");
        QueueWindow:SetWidth(290);
        QueueWindow:SetHeight(300);
        QueueWindow:SetPoint("TOPLEFT", Window.frame, "TOPRIGHT", 2, 16);
        QueueWindow:SetPoint("BOTTOMLEFT", Window.frame, "BOTTOMLEFT", 2);
        Interface:set(self, "QueueWindow", QueueWindow);
        QueueWindow.frame:SetFrameStrata("FULLSCREEN_DIALOG");
        QueueWindow.frame:SetParent(Window.frame);
        QueueWindow.frame:Show();

        local columns = {
            {
                name = "",
                width = 18,
                DoCellUpdate = GL.LibStImageButtonCellUpdate,
            },
            {
                name = "Queued Items",
                width = 132,
            },
            {
                name = "Min",
                width = 50,
                DoCellUpdate = GL.LibStInputCellUpdate,
            },
            {
                name = "Inc",
                width = 40,
                DoCellUpdate = GL.LibStInputCellUpdate,
            },
            {
                name = "",
                width = 0,
                sort = GL.Data.Constants.ScrollingTable.ascending,
            },
        };

        local Table = AceGUI:Create("CLMLibScrollingTable");
        Table:SetDisplayCols(columns);
        Table:SetDisplayRows(QUEUE_MAX_ITEMS, 18);
        Table:EnableSelection(false);
        Table:RegisterEvents({ ["OnClick"] = function () return true; end }); -- Override the default OnClick
        Interface:set(self, "Queue", Table);
        QueueWindow:AddChild(Table);

        local HowToAddToQueueLabel = AceGUI:Create("Label");
        HowToAddToQueueLabel:SetText(string.format(
            "|c00a79eff%s|r items to add them to the queue click start on the left when you're ready to go. While a queue is active you can keep adding items!",
            Settings:get("ShortcutKeys.rollOffOrAuction")
        ));
        HowToAddToQueueLabel:SetWidth(Table.frame:GetWidth() - 40);
        HowToAddToQueueLabel:SetJustifyH("MIDDLE");
        HowToAddToQueueLabel.frame:SetParent(Table.frame);
        HowToAddToQueueLabel.frame:SetPoint("TOP", Table.frame, "TOP", -10, -40);
        Interface:set(self, "HowToAddToQueueLabel", HowToAddToQueueLabel);

        local NewQueueInfoLabel = AceGUI:Create("Label");
        NewQueueInfoLabel:SetText(string.format(
            "You can start a new queue and queue up multiple items for auction\n\nRaiders with Gargul can immediately see these items and bid already, making runs much faster!\n\nWant to go even faster? Enable 'Auto award' and pick a default action for unwanted items in the GDKP settings menu"
        ));
        NewQueueInfoLabel:SetWidth(Table.frame:GetWidth() - 40);
        NewQueueInfoLabel:SetJustifyH("MIDDLE");
        NewQueueInfoLabel.frame:SetParent(Table.frame);
        NewQueueInfoLabel.frame:SetPoint("TOP", Table.frame, "TOP", -10, -40);
        NewQueueInfoLabel.frame:Show();
        Interface:set(self, "NewQueueInfoLabel", NewQueueInfoLabel);

        local ClearOrNewQueueButton = AceGUI:Create("Button");
        ClearOrNewQueueButton:SetText("New Queue");
        ClearOrNewQueueButton:SetFullWidth(true);
        ClearOrNewQueueButton:SetHeight(20);
        ClearOrNewQueueButton:SetDisabled(false);
        ClearOrNewQueueButton:SetCallback("OnClick", function()
            if (self.queueModeActivated) then
                self.queueModeActivated = false;
                ClearOrNewQueueButton:SetText("New Queue");
                self:clearQueue();
                self:refreshQueueTable();

                return;
            end

            self.queueModeActivated = true;
            ClearOrNewQueueButton:SetText("Clear");
            self:refreshQueueTable();
        end);
        if (self.queueModeActivated) then
            ClearOrNewQueueButton:SetText("Clear");
        end
        QueueWindow:AddChild(ClearOrNewQueueButton);
    end

    --[[
        SETTINGS BUTTON
    ]]
    local Cogwheel = GL.UI:createSettingsButton(
        Window.frame,
        "GDKP"
    );
    Cogwheel:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            self:close();

            GL.Settings:draw("GDKP", function ()
                self:draw();
            end);
        end
    end);

    --[[ ROWS ]]

    local FirstRow = AceGUI:Create("SimpleGroup");
    FirstRow:SetLayout("Flow");
    FirstRow:SetFullWidth(true);
    FirstRow:SetHeight(30);
    Window:AddChild(FirstRow);

    local SecondRow = AceGUI:Create("SimpleGroup");
    SecondRow:SetLayout("Flow");
    SecondRow:SetFullWidth(true);
    SecondRow:SetHeight(20);
    Window:AddChild(SecondRow);

    local ThirdRow = AceGUI:Create("SimpleGroup");
    ThirdRow:SetLayout("Flow");
    ThirdRow:SetFullWidth(true);
    ThirdRow:SetHeight(20);
    Window:AddChild(ThirdRow);

    local FifthRow = AceGUI:Create("SimpleGroup");
    FifthRow:SetLayout("Flow");
    FifthRow:SetFullWidth(true);
    FifthRow:SetHeight(20);
    Window:AddChild(FifthRow);

    local FourthRow = AceGUI:Create("SimpleGroup");
    FourthRow:SetLayout("Flow");
    FourthRow:SetFullWidth(true);
    FourthRow:SetHeight(20);
    Window:AddChild(FourthRow);

    --[[ AUCTION SETTINGS ]]

    local MinimumBidLabel = AceGUI:Create("Label");
    MinimumBidLabel:SetText("Minimum bid ");
    MinimumBidLabel:SetHeight(20);
    MinimumBidLabel:SetWidth(74); -- Minimum length 72
    FirstRow:AddChild(MinimumBidLabel);

    local MinimumBid = AceGUI:Create("EditBox");
    MinimumBid:DisableButton(true);
    MinimumBid:SetHeight(20);
    MinimumBid:SetWidth(70);
    MinimumBid:SetText(GL.Settings:get("GDKP.defaultMinimumBid"));
    FirstRow:AddChild(MinimumBid);
    Interface:set(self, "MinimumBid", MinimumBid);

    local MinimumIncrementLabel = AceGUI:Create("Label");
    MinimumIncrementLabel:SetText(" Bid increment ");
    MinimumIncrementLabel:SetHeight(20);
    MinimumIncrementLabel:SetWidth(80); -- Minimum length 74
    FirstRow:AddChild(MinimumIncrementLabel);

    local MinimumIncrement = AceGUI:Create("EditBox");
    MinimumIncrement:DisableButton(true);
    MinimumIncrement:SetHeight(20);
    MinimumIncrement:SetWidth(70);
    MinimumIncrement:SetText(GL.Settings:get("GDKP.defaultIncrement"));
    FirstRow:AddChild(MinimumIncrement);
    Interface:set(self, "MinimumIncrement", MinimumIncrement);

    HelpIcon = AceGUI:Create("Icon");
    HelpIcon:SetWidth(24);
    HelpIcon:SetHeight(24);
    HelpIcon:SetImageSize(12, 12);
    HelpIcon:SetImage("interface/friendsframe/informationicon");
    FirstRow:AddChild(HelpIcon);

    HelpIcon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(HelpIcon.frame, "ANCHOR_RIGHT");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("Note: the increment may not be higher than the minimum bid");
        GameTooltip:AddLine(" ");
        GameTooltip:Show();
    end);

    HelpIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end);

    local AuctionTimeLabel = AceGUI:Create("Label");
    AuctionTimeLabel:SetText("Auction length in seconds");
    AuctionTimeLabel:SetHeight(20);
    AuctionTimeLabel:SetWidth(142); -- Minimum length 74
    SecondRow:AddChild(AuctionTimeLabel);

    local AuctionTime = AceGUI:Create("EditBox");
    AuctionTime:DisableButton(true);
    AuctionTime:SetHeight(20);
    AuctionTime:SetWidth(40);
    AuctionTime:SetText(Settings:get("GDKP.time"));
    SecondRow:AddChild(AuctionTime);
    Interface:set(self, "Time", AuctionTime);

    local AntiSnipeLabel = AceGUI:Create("Label");
    AntiSnipeLabel:SetText(" Anti Snipe ");
    AntiSnipeLabel:SetHeight(20);
    AntiSnipeLabel:SetWidth(62); -- Minimum length 74
    SecondRow:AddChild(AntiSnipeLabel);

    local AntiSnipe = AceGUI:Create("EditBox");
    AntiSnipe:DisableButton(true);
    AntiSnipe:SetHeight(20);
    AntiSnipe:SetWidth(40);
    AntiSnipe:SetText(Settings:get("GDKP.antiSnipe"));
    SecondRow:AddChild(AntiSnipe);
    Interface:set(self, "AntiSnipe", AntiSnipe);

    HelpIcon = AceGUI:Create("Icon");
    HelpIcon:SetWidth(24);
    HelpIcon:SetHeight(24);
    HelpIcon:SetImageSize(12, 12);
    HelpIcon:SetImage("interface/friendsframe/informationicon");
    SecondRow:AddChild(HelpIcon);

    HelpIcon:SetCallback("OnEnter", function()
        GameTooltip:SetOwner(HelpIcon.frame, "ANCHOR_RIGHT");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("An Anti Snipe value of 10 means that 10 seconds will be added");
        GameTooltip:AddLine("to the auction if someone bids within the last 10 seconds");
        GameTooltip:AddLine(" ");
        GameTooltip:AddLine("You can leave this empty or set to 0 to disable Anti Snipe completely");
        GameTooltip:AddLine(" ");
        GameTooltip:Show();
    end)

    HelpIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end)

    --[[ ITEM ICON ]]

    local ItemIcon = AceGUI:Create("Icon");
    ItemIcon:SetImage(Auctioneer.Defaults.itemIcon);
    ItemIcon:SetImageSize(30, 30);
    ItemIcon:SetWidth(40);
    ThirdRow:AddChild(ItemIcon);
    Interface:set(self, "Item", ItemIcon);

    --[[ ITEM TEXTBOX ]]
    local ItemBox = AceGUI:Create("EditBox");
    ItemBox:DisableButton(true);
    ItemBox:SetHeight(20);
    --ItemBox:SetWidth(120);
    ItemBox:SetWidth(320);
    ItemBox:SetCallback("OnTextChanged", function () Auctioneer:ItemBoxChanged() end); -- Update item info when input value changes
    ItemBox:SetCallback("OnEnterPressed", function () Auctioneer:ItemBoxChanged() end); -- Update item info when item is dragged on top (makes no sense to use OnEnterPressed I know)
    Interface:set(self, "Item", ItemBox);
    ThirdRow:AddChild(ItemBox);

    -- Show a gametooltip if the icon shown belongs to an item
    ItemIcon:SetCallback("OnEnter", function()
        if (not Auctioneer.itemBoxHoldsValidItem) then
            return;
        end

        itemLink = ItemBox:GetText();
        GameTooltip:SetOwner(ItemIcon.frame, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(itemLink);
        GameTooltip:Show();
    end)

    ItemIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end)

    --[[ START/STOP BUTTON ]]

    local StartButton = AceGUI:Create("Button");
    StartButton:SetText("Start");
    StartButton:SetWidth(72);
    StartButton:SetHeight(20);
    StartButton:SetCallback("OnClick", function()
        if (not self.itemBoxHoldsValidItem) then
            return self:popFromQueue();
        end

        if (GDKPAuction:announceStart(
            Interface:get(self, "EditBox.Item"):GetText(),
            Interface:get(self, "EditBox.MinimumBid"):GetText(),
            Interface:get(self, "EditBox.MinimumIncrement"):GetText(),
            Interface:get(self, "EditBox.Time"):GetText(),
            Interface:get(self, "EditBox.AntiSnipe"):GetText(),
            GDKPAuction.Current.Bids,
            GDKPAuction.Current.TopBid
        )) then
            GDKPAuction.inProgress = true;

            if (Settings:get("GDKP.closeAuctioneerOnStart", true)) then
                self:close();
            end
        end;

        Auctioneer:updateWidgets();
    end);
    FifthRow:AddChild(StartButton);
    Interface:set(self, "Start", StartButton);

    --[[ STOP BUTTON ]]
    local StopButton = AceGUI:Create("Button");
    StopButton:SetText("Stop");
    StopButton:SetWidth(72);
    StopButton:SetHeight(20);
    StopButton:SetDisabled(true);
    StopButton:SetCallback("OnClick", function()
        GL.Ace:CancelTimer(self.PopTimer);
        GDKPAuction:announceStop(true);
    end);
    FifthRow:AddChild(StopButton);
    Interface:set(self, "Stop", StopButton);

    --[[ ADD TIME BUTTON ]]
    local ProlongButton = AceGUI:Create("Button");
    ProlongButton:SetText("+ 10");
    ProlongButton:SetWidth(72);
    ProlongButton:SetHeight(20);
    ProlongButton:SetDisabled(true);
    ProlongButton:SetCallback("OnClick", function()
        GDKPAuction:announceExtension(10);
        ProlongButton:SetDisabled(true);
        GL.Ace:ScheduleTimer(function ()
            self:updateWidgets();
        end, 3);
    end);
    FifthRow:AddChild(ProlongButton);
    Interface:set(self, "Prolong", ProlongButton);

    --[[ CLEAR BUTTON ]]
    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear");
    ClearButton:SetWidth(72);
    ClearButton:SetHeight(20);
    ClearButton:SetDisabled(false);
    ClearButton:SetCallback("OnClick", function()
        self:reset();
        GDKPAuction:reset();
    end);
    FifthRow:AddChild(ClearButton);
    Interface:set(self, "Clear", ClearButton);

    --[[ NEXT ITEM BUTTON ]]
    local NextItemButton = AceGUI:Create("Button");
    NextItemButton:SetText("Next");
    NextItemButton:SetWidth(72);
    NextItemButton:SetHeight(20);
    NextItemButton:SetCallback("OnClick", function()
        self:popFromQueue();
    end);
    FifthRow:AddChild(NextItemButton);
    Interface:set(self, "Next", NextItemButton);

    --[[ AWARD BUTTON ]]
    local AwardButton = AceGUI:Create("Button");
    AwardButton:SetText("Award");
    AwardButton:SetWidth(112);
    AwardButton:SetHeight(20);
    AwardButton:SetDisabled(true);
    AwardButton:SetCallback("OnClick", function()
        local PlayersTable = Interface:get(self, "Table.Players");
        local selected = PlayersTable:GetRow(PlayersTable:GetSelection());

        if (not selected
            or not type(selected) == "table"
        ) then
            return GL.Interface.Award:draw(ItemBox:GetText());
        end

        local winner = selected.cols[1].value;
        local bid = selected.cols[2].value;

        GL.Interface.Dialogs.PopupDialog:open({
            question = string.format("Award %s to |cff%s%s|r for %s|c00FFF569g|r?",
                GDKP.Auction.Current.itemLink,
                GL:classHexColor(GL.Player:classByName(winner)),
                winner,
                bid
            ),
            OnYes = function ()
                local isOS, addPlusOne;
                local OSCheckBox = Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.OffSpec");
                if (OSCheckBox) then
                    isOS = GL:toboolean(OSCheckBox:GetValue());
                end

                local addPlusOneCheckBox = Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.PlusOne");
                if (addPlusOneCheckBox) then
                    addPlusOne = GL:toboolean(addPlusOneCheckBox:GetValue());

                    if (addPlusOne) then
                        GL.PlusOnes:add(winner);
                    end
                end

                local awardChecksum = GL.AwardedLoot:addWinner(winner, GDKPAuction.Current.itemLink, nil, nil, isOS, nil, bid, nil);

                if (not GDKPAuction:storeCurrent(winner, bid, awardChecksum)) then
                    return;
                end

                self:reset(); -- Reset the UI
                GDKPAuction:reset(); -- Reset the actual auction object
                self:closeReopenAuctioneerButton();

                self:popFromQueue();

                if (Settings:get("GDKP.closeAuctioneerOnAward")) then
                    self:close();
                end
            end,
        });
    end);
    FourthRow:AddChild(AwardButton);
    Interface:set(self, "Award", AwardButton);

    --[[ DISENCHANT BUTTON ]]
    local DisenchantButton = AceGUI:Create("Button");
    DisenchantButton:SetText("Disenchant");
    DisenchantButton:SetWidth(112);
    DisenchantButton:SetHeight(20);
    DisenchantButton:SetDisabled(true);
    DisenchantButton:SetCallback("OnClick", function()
        itemLink = Interface:get(self, "EditBox.Item"):GetText();
        GL.PackMule:disenchant(itemLink, true);

        if (Settings:get("GDKP.closeAuctioneerOnAward")) then
            self:close();
        end

        self:popFromQueue();
    end);
    FourthRow:AddChild(DisenchantButton);
    Interface:set(self, "Disenchant", DisenchantButton);

    --[[ REMOVE LAST BID BUTTON ]]
    local DeleteLastBid = AceGUI:Create("Button");
    DeleteLastBid:SetText("Remove last bid");
    DeleteLastBid:SetWidth(136);
    DeleteLastBid:SetHeight(20);
    DeleteLastBid:SetDisabled(true);
    DeleteLastBid:SetCallback("OnClick", function()
        tremove(GDKPAuction.Current.Bids); -- We don't want to store this
        local PreviousBid = tremove(GDKPAuction.Current.Bids);

        tinsert(GDKPAuction.Current.Bids, PreviousBid);
        GDKPAuction.Current.TopBid = PreviousBid;
        self:refreshBidsTable();
    end);
    FourthRow:AddChild(DeleteLastBid);
    Interface:set(self, "DeleteLastBid", DeleteLastBid);

    --[[ FOURTH ROW ]]

    self:drawPlayersTable(Window.frame);

    --[[ FIFTH ROW (AUTO CLOSE CHECKBOX) ]]

    local FifthRow = AceGUI:Create("SimpleGroup");
    FifthRow:SetLayout("Flow");
    FifthRow:SetFullWidth(true);
    FifthRow:SetHeight(20);
    Window:AddChild(FifthRow);

    --[[
        TABLE SETTINGS BUTTON
    ]]
    local PlayersTableFrame = AceGUI:Create("SimpleGroup");
    PlayersTableFrame:SetLayout("Fill");
    PlayersTableFrame:SetFullWidth(true);
    PlayersTableFrame:SetHeight(160);
    FifthRow:AddChild(PlayersTableFrame);

    local CloseOnStart = AceGUI:Create("CheckBox");
    CloseOnStart:SetLabel("Close on start");
    CloseOnStart:SetValue(Settings:get("GDKP.closeAuctioneerOnStart"));
    CloseOnStart:SetCallback("OnValueChanged", function (widget)
        Settings:set("GDKP.closeAuctioneerOnStart", GL:toboolean(widget:GetValue()));
    end);
    CloseOnStart:SetWidth(110);
    FifthRow:AddChild(CloseOnStart);

    local CloseOnAward = AceGUI:Create("CheckBox");
    CloseOnAward:SetLabel("Close on award");
    CloseOnAward:SetValue(Settings:get("GDKP.closeAuctioneerOnAward"));
    CloseOnAward:SetCallback("OnValueChanged", function (widget)
        Settings:set("GDKP.closeAuctioneerOnAward", GL:toboolean(widget:GetValue()));
    end);
    CloseOnAward:SetWidth(116);
    FifthRow:AddChild(CloseOnAward);

    local AutoAward = AceGUI:Create("CheckBox");
    AutoAward:SetLabel("Auto award");
    AutoAward:SetValue(Settings:get("GDKP.autoAwardViaAuctioneer"));
    AutoAward:SetCallback("OnValueChanged", function (widget)
        Settings:set("GDKP.autoAwardViaAuctioneer", GL:toboolean(widget:GetValue()));
    end);
    AutoAward:SetWidth(116);
    FifthRow:AddChild(AutoAward);

    if (itemLink
        and type(itemLink) == "string"
    ) then
        Auctioneer:passItemLink(itemLink);
    end
end

--- We run this method when an auction ran out "naturally", aka wasn't stopped by the auctioneer
function Auctioneer:timeRanOut()
    GL:debug("Auctioneer:timeRanOut");

    if (not Settings:get("GDKP.autoAwardViaAuctioneer")
        or GDKPAuction.inProgress
    ) then
        return;
    end

    local delayBetweenQueuedAuctions = tonumber(Settings:get("GDKP.delayBetweenQueuedAuctions")) or 0;

    if (not GL:tableGet(GDKPAuction.Current, "TopBid.Bidder.name")) then
        local actionWhenNoBidsArePresent = Settings:get("GDKP.queuedAuctionNoBidsAction");

        if (actionWhenNoBidsArePresent ~= GL.Data.Constants.GDKP.QueuedAuctionNoBidsActions.NOTHING) then
            if (actionWhenNoBidsArePresent == "DISENCHANT") then
                GL.PackMule:disenchant(GDKPAuction.Current.itemLink, true);
            end

            self:reset(); -- Reset the UI
            GDKPAuction:reset(); -- Reset the actual auction object
            self:closeReopenAuctioneerButton();

            GL.Ace:CancelTimer(self.PopTimer);
            if (delayBetweenQueuedAuctions > 0) then
                self.PopTimer = GL.Ace:ScheduleTimer(function ()
                    self:popFromQueue();
                end, delayBetweenQueuedAuctions);
            else
                self:popFromQueue();
            end

            return;
        end

        if (not self.isVisible) then
            GL.Interface.Alerts:fire("GargulNotification", {
                message = string.format("|c00BE3333No bids!|r"),
            });
        end

        return;
    end

    local bid = GDKPAuction.Current.TopBid.bid;
    local minimumBid = GDKPAuction.Current.minimumBid;

    -- We don't auto-award unless the bid is equal to or higher than the minimum bid
    if (bid < minimumBid) then
        return;
    end

    local winner = GDKPAuction.Current.TopBid.Bidder.name;
    local awardChecksum = GL.AwardedLoot:addWinner(winner, GDKPAuction.Current.itemLink, nil, nil, nil, nil, bid, nil);
    if (not GDKPAuction:storeCurrent(winner, bid, awardChecksum)) then
        return;
    end

    self:reset(); -- Reset the UI
    GDKPAuction:reset(); -- Reset the actual auction object
    self:closeReopenAuctioneerButton();

    GL.Ace:CancelTimer(self.PopTimer);
    if (delayBetweenQueuedAuctions > 0) then
        self.PopTimer = GL.Ace:ScheduleTimer(function ()
            self:popFromQueue();
        end, delayBetweenQueuedAuctions);
    else
        self:popFromQueue();
    end
end

--[[
/script _G.Gargul.Interface.GDKP.Auctioneer:popFromQueue()
]]
function Auctioneer:popFromQueue()
    GL:debug("Auctioneer:popFromQueue");

    if (not self.queueModeActivated) then
        return;
    end

    local NextInLine = nil;

    for _, QueuedItem in pairs(GDKPAuction.Queue or {}) do
        (function ()
            -- Looks like the item was removed in the meantime. Race condition?
            if (not tonumber(QueuedItem.addedAt) or (
                NextInLine and not tonumber(NextInLine.addedAt)
            )) then
                return;
            end

            if (not NextInLine or NextInLine.addedAt > QueuedItem.addedAt) then
                NextInLine = QueuedItem;
            end
        end)();
    end

    if (not NextInLine
        or not NextInLine.addedAt
        or not GDKPAuction.Queue[tostring(NextInLine.addedAt)]
    ) then
        return;
    end

    GDKPAuction:removeFromQueue(NextInLine.addedAt);
    self:refreshQueueTable();

    local windowWasClosed = not self.isVisible;
    self:passItemLink(NextInLine.itemLink, true);
    Interface:get(self, "EditBox.MinimumBid"):SetText(NextInLine.minimumBid);
    Interface:get(self, "EditBox.MinimumIncrement"):SetText(NextInLine.increment);
    Interface:get(self, "Button.Start"):Fire("OnClick");

    if (windowWasClosed) then
        self:close();
    end
end

function Auctioneer:addToQueue(itemLink)
    GL:debug("Auctioneer:addToQueue");

    if (not self.queueModeActivated) then
        return;
    end

    if (GL:count(GDKPAuction.Queue) >= QUEUE_MAX_ITEMS) then
        GL.Interface.Alerts:fire("GargulNotification", {
            message = string.format("|c00BE3333Max reached!|r"),
        });

        return;
    end

    GDKPAuction:addToQueue(itemLink);

    self:refreshQueueTable();
end

---@return void
function Auctioneer:clearQueue()
    GL:debug("Auctioneer:clearQueue");

    GDKPAuction:clearQueue();

    local Table = Interface:get(self, "Table.Queue");
    if (Table) then
        Table:SetData({}, true);
    end
end

---@return void
function Auctioneer:refreshQueueTable()
    GL:debug("Auctioneer:refreshQueueTable");

    local Table = Interface:get(self, "Table.Queue");

    if (not Table) then
        return;
    end

    local TableData = {};
    for key, QueuedItem in pairs(GDKPAuction.Queue or {}) do
        (function()
            if (not QueuedItem or not QueuedItem.itemLink) then
                return;
            end

            tinsert(TableData, {
                cols = {
                    {
                        value = "Interface/AddOns/Gargul/Assets/Buttons/delete", _OnClick = function ()
                        GDKPAuction:removeFromQueue(key);
                        self:refreshQueueTable();
                    end,
                    },
                    {
                        value = " " .. QueuedItem.itemLink },
                    {
                        _OnTextChanged = function (Input)
                            GDKPAuction.Queue[key] = GDKPAuction.Queue[key] or {};
                            GDKPAuction.Queue[key].minimumBid = tonumber(Input:GetText()) or 500;
                        end,
                        _default = QueuedItem.minimumBid
                    },
                    {
                        _OnTextChanged = function (Input)
                            GDKPAuction.Queue[key] = GDKPAuction.Queue[key] or {};
                            GDKPAuction.Queue[key].increment = tonumber(Input:GetText()) or 500;
                        end,
                        _default = QueuedItem.increment
                    },
                    {
                        value = key,
                    }
                },
            });
        end)();
    end

    Table:SetData({}, true);
    if (self.queueModeActivated) then
        Interface:get(self, "Label.NewQueueInfoLabel").frame:Hide();
        Interface:get(self, "Label.HowToAddToQueueLabel").frame:Hide();

        if (not GL:empty(TableData)) then
            if (Table) then
                Table:SetData(TableData);
            end
        else
            self:clearQueue();
            Interface:get(self, "Label.HowToAddToQueueLabel").frame:Show();
        end
    else
        Interface:get(self, "Label.NewQueueInfoLabel").frame:Show();
        Interface:get(self, "Label.HowToAddToQueueLabel").frame:Hide();
    end
end

---@param Window table
---@return boolean
function Auctioneer:show(Window)
    GL:debug("Auctioneer:show");

    local ActiveSession = GDKPSession:getActive();
    if (not ActiveSession) then
        GL:error("No active GDKP session, you have to create one first in /gl gdkp");
        return false;
    end

    Window:SetStatusText(string.format(
        "Session: |c00a79eff%s|r (%s)",
        ActiveSession.title,
        date('%Y-%m-%d', ActiveSession.createdAt)
    ));

    self.isVisible = true;
    Window:Show();

    return true;
end

---@return void
function Auctioneer:close()
    GL:debug("Auctioneer:close");

    self.isVisible = false;

    -- When the master looter closes the auctioneer window with an auction
    -- still in progress we show the reopen auctioneer button
    if (GDKPAuction.inProgress) then
        self:drawReopenAuctioneerButton();
    end

    local Window = Interface:get(self, "Window");
    if (Window) then
        -- Store the frame's last position for future play sessions
        Interface:storePosition(Window, "Auctioneer");
        Window:Hide();
        Interface:get(self, "Frame.QueueWindow").frame:Hide();
    end
end

---@return void
function Auctioneer:closeReopenAuctioneerButton()
    -- Close the reopen auctioneer button if it exists
    local OpenAuctioneerButton = Interface:get(self, "Frame.OpenAuctioneerButton");

    if (OpenAuctioneerButton) then
        OpenAuctioneerButton:Hide();
    end
end

--- This button allows the master looter to easily reopen the
--- auctioneer window when it's closed with a roll in progress
--- This is very common in hectic situations where the master looter has to participate in combat f.e.
---@return void
function Auctioneer:drawReopenAuctioneerButton()
    GL:debug("Auctioneer:drawReopenAuctioneerButton");

    -- Only draw the button if the master looter window is closed
    local Window = Interface:get(self, "Window");
    if (Window and Window:IsShown()) then
        return;
    end

    local Button = Interface:get(self, "Frame.OpenAuctioneerButton");

    if (Button) then
        Button:SetNormalTexture(GDKP.Auction.Current.itemIcon or "Interface\\Icons\\INV_Misc_QuestionMark");
        Button:Show();
        return;
    end

    local texture = GDKP.Auction.Current.itemIcon or "Interface\\Icons\\INV_Misc_QuestionMark";
    Button = CreateFrame("Button", "GargulReopenAuctioneerButton", UIParent, Frame);
    Button:SetSize(42, 42);
    Button:SetNormalTexture(texture);
    Button:SetText("text");
    Button:SetPoint(Interface:getPosition("ReopenAuctioneerButton"));

    Button:SetMovable(true);
    Button:EnableMouse(true);
    Button:SetClampedToScreen(true);
    Button:SetFrameStrata("FULLSCREEN_DIALOG");
    Button:RegisterForDrag("LeftButton");
    Button:SetScript("OnDragStart", Button.StartMoving);
    Button:SetScript("OnDragStop", function()
        Button:StopMovingOrSizing();

        -- Store the frame's last position for future play sessions
        Interface:storePosition(Button, "ReopenAuctioneerButton");
    end);

    local ButtonBackground = Button:CreateTexture(nil, "BACKGROUND");
    ButtonBackground:SetAllPoints(Button);
    ButtonBackground:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark");
    ButtonBackground:SetTexCoord(0, 1, 0.23, 0.77);
    ButtonBackground:SetBlendMode("ADD");
    Button.ButtonBackground = ButtonBackground;

    local ButtonHighlight = Button:CreateTexture(nil, "HIGHLIGHT");
    ButtonHighlight:SetAllPoints(Button);
    ButtonHighlight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight");
    ButtonHighlight:SetTexCoord(0, 1, 0.23, 0.77);
    ButtonHighlight:SetBlendMode("ADD");
    Button.ButtonHighlight = ButtonHighlight;

    Button:SetScript("OnMouseUp", function (_, button)
        if (button == "LeftButton") then
            self:draw();
        end
    end);

    Button:SetScript("OnEnter", function()
        GameTooltip:SetOwner(Button, "ANCHOR_TOP");
        GameTooltip:SetText("Open auctioneer window");
        GameTooltip:Show();
    end);

    Button:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    Interface:set(self, "OpenAuctioneerButton", Button);
end

function Auctioneer:drawPlayersTable(parent)
    GL:debug("Auctioneer:drawPlayersTable");

    -- Combined width of all colums should be 340
    local columns = {
        --[[ Player name ]]
        {
            name = "Player",
            width = 180,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        },
        --[[ Bid ]]
        {
            name = "Bid",
            width = 141,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
            defaultsort = GL.Data.Constants.ScrollingTable.descending,
        },
        --[[ PRIORITY (NOT VISIBLE, FOR SORTING ONLY! ]]
        {
            name = "",
            width = 1,
            align = "LEFT",
            color = {
                r = 0,
                g = 0,
                b = 0,
                a = 0
            },
            colorargs = nil,
            sort = GL.Data.Constants.ScrollingTable.ascending,
            sortnext = 2,
        },
    };

    local Table = GL.ScrollingTable:CreateST(columns, 8, 15, nil, parent);
    Table:EnableSelection(true);

    Table:RegisterEvents({
        -- Show a tooltip that contains the items that the roller already won so far
        OnEnter = function (rowFrame, _, data, _, _, realrow)
            -- Make sure something is actually highlighted, better safe than lua error
            if (not GL:higherThanZero(realrow)
                or type(data) ~= "table"
                or not data[realrow]
                or not data[realrow].cols
                or not data[realrow].cols[1]
            ) then
                return;
            end

            local roller = data[realrow].cols[1].value;

            -- If the roller has a roll number suffixed to his name
            -- e.g. "playerName [2]" then make sure to remove that number
            local openingBracketPosition = string.find(roller, " %[");
            if (openingBracketPosition) then
                roller = string.sub(roller, 1, openingBracketPosition - 1);
            end

            local ItemsWonByRollerInTheLast8Hours = GL.AwardedLoot:byWinner(roller, GetServerTime() - (8 * 60 * 60));

            if (GL:empty(ItemsWonByRollerInTheLast8Hours)) then
                return;
            end

            GameTooltip:ClearLines();
            GameTooltip:SetOwner(rowFrame, "ANCHOR_RIGHT");
            GameTooltip:AddLine(string.format("Items won by %s:", roller));
            GameTooltip:AddLine(" ");

            for _, itemLink in pairs(ItemsWonByRollerInTheLast8Hours) do
                GameTooltip:AddLine(itemLink);
            end

            GameTooltip:Show();
        end,
        OnLeave = function ()
            GameTooltip:Hide();
        end,
    });

    Table.frame:SetPoint("BOTTOM", parent, "BOTTOM", 0, 76);
    Interface:set(self, "Players", Table);
end

function Auctioneer:refreshBidsTable()
    GL:debug("RollOff:refreshBidsTable");

    local BidTableData = {};
    local Bids = GDKP.Auction.Current.Bids;
    local BidsTable = Interface:get(self, "Table.Players");

    if (not BidsTable) then
        return;
    end

    local row = 0;
    for _, Entry in pairs(Bids) do
        row = row + 1;
        local bidder = Entry.Bidder.name;
        local class = Entry.Bidder.class;
        local priority = 1;

        local Row = {
            cols = {
                {
                    value = bidder,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = Entry.bid,
                    color = GL:classRGBAColor(class),
                },
                {
                    value = priority,
                },
            },
        };
        tinsert(BidTableData, Row);
    end

    BidsTable:SetData(BidTableData);
    BidsTable:SortData();

    if (row > 0) then
        BidsTable:SetSelection(row);
    end
end

-- The item box contents changed
function Auctioneer:ItemBoxChanged()
    GL:debug("Auctioneer:ItemBoxChanged");

    local itemLink = Interface:get(self, "EditBox.Item"):GetText();

    Auctioneer:passItemLink(itemLink);
end

function Auctioneer:passItemLink(itemLink, setAsActiveItem)
    GL:debug("Auctioneer:passItemLink");

    setAsActiveItem = GL:toboolean(setAsActiveItem);

    if (not setAsActiveItem and self.queueModeActivated) then
        return self:addToQueue(itemLink);
    end

    if (not Interface:get(self, "Window")) then
        return;
    end

    if (GDKPAuction.inProgress) then
        return GL:warning("An auction is currently in progress");
    end

    local itemID = tonumber(GL:getItemIDFromLink(itemLink)) or 0;

    if (itemID < 1) then
        return GL:warning("Invalid item provided");
    end

    local PerItemSettings = GDKP:settingsForItemID(GL:getItemIDFromLink(itemLink));
    Interface:get(self, "EditBox.MinimumBid"):SetText(PerItemSettings.minimum);
    Interface:get(self, "EditBox.MinimumIncrement"):SetText(PerItemSettings.increment);

    Interface:get(self, "EditBox.Item"):SetText(itemLink);

    return Auctioneer:update();
end

--- Update the auctioneer based on the value of the ItemBox input
function Auctioneer:update()
    GL:debug("Auctioneer:update");

    local IconWidget = Interface:get(self, "Icon.Item");
    local itemLink = Interface:get(self, "EditBox.Item"):GetText();

    -- If the item link is not valid then
    --   Show the default question mark icon
    --   Remove the item priority string
    if (not itemLink or itemLink == "") then
        GL:debug("Auctioneer:update. Item link is invalid");

        Auctioneer.itemBoxHoldsValidItem = false;
        IconWidget:SetImage(Auctioneer.Defaults.itemIcon);

        Auctioneer:updateWidgets();
        return;
    end

    -- The item's icon is in the 10th position
    local icon = select(10, GetItemInfo(itemLink));

    if (icon) then
        Interface:get(self, "Table.Players"):ClearSelection();

        IconWidget:SetImage(icon);
        Auctioneer.itemBoxHoldsValidItem = true;
    else
        Auctioneer.itemBoxHoldsValidItem = false;
        IconWidget:SetImage(Auctioneer.Defaults.itemIcon);
    end

    Auctioneer:updateWidgets();
end

-- Reset the roll off UI to its defaults
function Auctioneer:reset()
    GL:debug("Auctioneer:reset");

    Interface:get(self, "Icon.Item"):SetImage(Auctioneer.Defaults.itemIcon);
    Interface:get(self, "EditBox.Item"):SetText(Auctioneer.Defaults.itemText);
    Auctioneer.itemBoxHoldsValidItem = false;

    Interface:get(self, "Table.Players"):ClearSelection();
    Interface:get(self, "Table.Players"):SetData({}, true);

    Auctioneer:updateWidgets();
end

-- Update the widgets based on the current state of the roll off
function Auctioneer:updateWidgets()
    GL:debug("Auctioneer:updateWidgets");

    local Next = Interface:get(self, "Button.Next");
    local Stop = Interface:get(self, "Button.Stop");
    local DeleteLastBid = Interface:get(self, "Button.DeleteLastBid");
    local Item = Interface:get(self, "EditBox.Item");
    local Award = Interface:get(self, "Button.Award");
    local Disenchant = Interface:get(self, "Button.Disenchant");
    local Prolong = Interface:get(self, "Button.Prolong");
    local Clear = Interface:get(self, "Button.Clear");

    if (not Auctioneer.itemBoxHoldsValidItem
        and not (self.queueModeActivated and not GL:empty(GDKPAuction.Queue))
    ) then
        Next:SetDisabled(false);
        Stop:SetDisabled(true);
        DeleteLastBid:SetDisabled(true);
        Prolong:SetDisabled(true);
        Item:SetDisabled(false);
        Award:SetDisabled(true);
        Disenchant:SetDisabled(true);

        return;
    end

    if (not GDKPAuction.inProgress) then
        Next:SetDisabled(false);
        Stop:SetDisabled(true);
        DeleteLastBid:SetDisabled(false);
        Prolong:SetDisabled(true);
        Item:SetDisabled(false);
        Award:SetDisabled(false);
        Disenchant:SetDisabled(false);
        Clear:SetDisabled(false);

    else
        Next:SetDisabled(true);
        Stop:SetDisabled(false);
        DeleteLastBid:SetDisabled(true);
        Prolong:SetDisabled(false);
        Item:SetDisabled(true);
        Award:SetDisabled(true);
        Disenchant:SetDisabled(true);
        Clear:SetDisabled(true);
    end
end

GL:debug("Auctioneer.lua");