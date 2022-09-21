---@type GL
local _, GL = ...;

---@class GDKPAuctioneerInterface
GL:tableSet(GL, "Interface.GDKP.Auctioneer", {
    itemBoxHoldsValidItem = false,
    PlayersTable = {},
    Defaults = {
        itemIcon = "Interface\\Icons\\INV_Misc_QuestionMark",
        itemBoxText = "",
    },
});
local Auctioneer = GL.Interface.GDKP.Auctioneer; ---@type GDKPAuctioneerInterface
local AceGUI = GL.AceGUI;

GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

function Auctioneer:draw(itemLink)
    GL:debug("Auctioneer:draw");

    if (GL.User.isInGroup
        and not GL.User.isMasterLooter
        and not GL.User.hasAssist
    ) then
        return GL:warning("You need to be the master looter or have an assist / lead role!");
    end

    -- Close the reopen masterlooter button if it exists
    self:closeReopenAuctioneerButton();

    -- First we need to check if the frame hasn't been
    -- rendered already. If so then show it (if it's hidden)
    -- and pass the itemLink along in case one was provided
    local Window = GL.Interface:getItem(self, "Window");
    if (Window) then
        if (itemLink) then
            Auctioneer:passItemLink(itemLink);
        end

        -- If the frame is hidden we need to show it again
        if (not Window:IsShown()) then
            self:show(Window);
        end

        return;
    end

    local HorizonalSpacer, VerticalSpacer;

    -- Create a container/parent frame
    Window = AceGUI:Create("Frame", "GARGUL_AUCTIONEER_WINDOW");
    Window:SetTitle("Gargul GDKP Auction");
    Window:SetLayout("Flow");
    Window:SetWidth(430);
    Window:SetHeight(364);
    Window:EnableResize(false);
    Window.frame:SetFrameStrata("HIGH");
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    self:show(Window);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("Auctioneer"));

    --[[
        SETTINGS BUTTON
    ]]
    local SettingsButton = GL.UI:createSettingsButton(
        Window.frame,
        "GDKP"
    );
    self.SettingsButton = SettingsButton;

    --[[
        FIRST ROW (ITEM ICON AND LINK BOX)
    ]]

    local FirstRow = AceGUI:Create("SimpleGroup");
    FirstRow:SetLayout("Flow");
    FirstRow:SetFullWidth(true);
    FirstRow:SetHeight(30);
    Window:AddChild(FirstRow);

    --[[
        ITEM ICON
    ]]

    local ItemIcon = AceGUI:Create("Icon");
    ItemIcon:SetImage(Auctioneer.Defaults.itemIcon);
    ItemIcon:SetImageSize(30, 30);
    ItemIcon:SetWidth(40);
    FirstRow:AddChild(ItemIcon);
    GL.Interface:setItem(self, "Item", ItemIcon);

    --[[
        ITEM TEXTBOX
    ]]

    local ItemBox = AceGUI:Create("EditBox");

    ItemBox:DisableButton(true);
    ItemBox:SetHeight(20);
    ItemBox:SetWidth(170);
    ItemBox:SetCallback("OnTextChanged", function () Auctioneer:ItemBoxChanged() end); -- Update item info when input value changes
    ItemBox:SetCallback("OnEnterPressed", function () Auctioneer:ItemBoxChanged() end); -- Update item info when item is dragged on top (makes no sense to use OnEnterPressed I know)

    GL.Interface:setItem(self, "Item", ItemBox);

    FirstRow:AddChild(ItemBox);

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

    --[[
        BUTTON PADDER
        CONTAINER FOR PADDING PURPOSES ONLY
    ]]

    HorizonalSpacer = AceGUI:Create("SimpleGroup");
    HorizonalSpacer:SetLayout("Flow");
    HorizonalSpacer:SetWidth(14);
    HorizonalSpacer:SetHeight(30);
    FirstRow:AddChild(HorizonalSpacer);

    --[[
        START/STOP BUTTON
    ]]

    local StartButton = AceGUI:Create("Button");
    StartButton:SetText("Start");
    StartButton:SetWidth(80);
    StartButton:SetHeight(20);
    StartButton:SetDisabled(true);
    StartButton:SetCallback("OnClick", function()
        if (GL.GDKP:announceStart(
            GL.Interface:getItem(self, "EditBox.Item"):GetText(),
            GL.Interface:getItem(self, "EditBox.MinimumBid"):GetText(),
            GL.Interface:getItem(self, "EditBox.MinimumIncrement"):GetText()
        )) then
            GL.GDKP.inProgress = true;

            if (GL.Settings:get("GDKP.closeAuctioneerOnStart", true)) then
                self:close();
            end
        end;

        Auctioneer:updateWidgets();
    end);
    FirstRow:AddChild(StartButton);
    GL.Interface:setItem(self, "Start", StartButton);

    --[[
        STOP BUTTON
    ]]

    local StopButton = AceGUI:Create("Button");
    StopButton:SetText("Stop");
    StopButton:SetWidth(80);
    StopButton:SetHeight(20);
    StopButton:SetDisabled(true);
    StopButton:SetCallback("OnClick", function()
        GL.GDKP:announceStop();
    end);
    FirstRow:AddChild(StopButton);
    GL.Interface:setItem(self, "Stop", StopButton);

    --[[
        SECOND ROW
    ]]

    local SecondRow = AceGUI:Create("SimpleGroup");
    SecondRow:SetLayout("Flow");
    SecondRow:SetFullWidth(true);
    SecondRow:SetHeight(20);
    Window:AddChild(SecondRow);

    --[[
        SPACER
    ]]

    HorizonalSpacer = AceGUI:Create("SimpleGroup");
    HorizonalSpacer:SetLayout("Flow");
    HorizonalSpacer:SetWidth(8);
    HorizonalSpacer:SetHeight(20);
    SecondRow:AddChild(HorizonalSpacer);

    local MinimumBidLabel = AceGUI:Create("Label");
    MinimumBidLabel:SetText("Minimum bid");
    MinimumBidLabel:SetHeight(20);
    MinimumBidLabel:SetWidth(72); -- Minimum length 72
    SecondRow:AddChild(MinimumBidLabel);

    local MinimumBid = AceGUI:Create("EditBox");
    MinimumBid:DisableButton(true);
    MinimumBid:SetHeight(20);
    MinimumBid:SetWidth(60);
    MinimumBid:SetText(GL.Settings:get("GDKP.minimumBid", 100));
    SecondRow:AddChild(MinimumBid);
    GL.Interface:setItem(self, "MinimumBid", MinimumBid);

    HorizonalSpacer = AceGUI:Create("SimpleGroup");
    HorizonalSpacer:SetLayout("Flow");
    HorizonalSpacer:SetWidth(8);
    HorizonalSpacer:SetHeight(20);
    SecondRow:AddChild(HorizonalSpacer);

    local MinimumIncrementLabel = AceGUI:Create("Label");
    MinimumIncrementLabel:SetText("Bid increment");
    MinimumIncrementLabel:SetHeight(20);
    MinimumIncrementLabel:SetWidth(74); -- Minimum length 74
    SecondRow:AddChild(MinimumIncrementLabel);

    local MinimumIncrement = AceGUI:Create("EditBox");
    MinimumIncrement:DisableButton(true);
    MinimumIncrement:SetHeight(20);
    MinimumIncrement:SetWidth(40);
    MinimumIncrement:SetText(GL.Settings:get("GDKP.minimumIncrement", 50));
    SecondRow:AddChild(MinimumIncrement);
    GL.Interface:setItem(self, "MinimumIncrement", MinimumIncrement);

    --[[
        THIRD ROW
    ]]

    local ThirdRow = AceGUI:Create("SimpleGroup");
    ThirdRow:SetLayout("Flow");
    ThirdRow:SetFullWidth(true);
    ThirdRow:SetHeight(20);
    Window:AddChild(ThirdRow);

    --[[
        SPACER
    ]]

    VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("Flow");
    VerticalSpacer:SetWidth(8);
    VerticalSpacer:SetHeight(20);
    ThirdRow:AddChild(VerticalSpacer);

    --[[
        RESET BUTTON
    ]]
    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear");
    ClearButton:SetWidth(66);
    ClearButton:SetHeight(20);
    ClearButton:SetDisabled(false);
    ClearButton:SetCallback("OnClick", function()
        self:reset();
        GL.GDKP:resetAuction();
    end);
    ThirdRow:AddChild(ClearButton);
    GL.Interface:setItem(self, "Clear", ClearButton);

    --[[
        AWARD BUTTON
    ]]

    local AwardButton = AceGUI:Create("Button");
    AwardButton:SetText("Award");
    AwardButton:SetWidth(70);
    AwardButton:SetHeight(20);
    AwardButton:SetDisabled(true);
    AwardButton:SetCallback("OnClick", function()
        local PlayersTable = GL.Interface:getItem(self, "Table.Players");
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
                GL.GDKP.CurrentAuction.itemLink,
                GL:classHexColor(GL.Player:classByName(winner)),
                winner,
                bid
            ),
            OnYes = function ()
                GL.GDKP:createAuction(GL:getItemIdFromLink(GL.GDKP.CurrentAuction.itemLink), bid, winner);

                self:reset(); -- Reset the UI
                GL.GDKP:resetAuction(); -- Reset the actual auction object
                self:closeReopenAuctioneerButton();

                if (GL.Settings:get("GDKP.closeAuctioneerOnAward", true)) then
                    self:close();
                end

                ---@todo: add setting for this
                -- Announce awarded item on RAID or RAID_WARNING
                GL:sendChatMessage(
                    string.format("%s was awarded to %s for %sg. Congrats!",
                            itemLink,
                            winner,
                            bid
                    ),
                    "GROUP"
                );
            end,
        });
    end);
    ThirdRow:AddChild(AwardButton);
    GL.Interface:setItem(self, "Award", AwardButton);

    --[[
        DISENCHANT BUTTON
    ]]
    local DisenchantButton = AceGUI:Create("Button");
    DisenchantButton:SetText("Disenchant");
    DisenchantButton:SetWidth(98); -- Minimum length is
    DisenchantButton:SetHeight(20);
    DisenchantButton:SetDisabled(true);
    DisenchantButton:SetCallback("OnClick", function()
        itemLink = GL.Interface:getItem(self, "EditBox.Item"):GetText();

        GL.PackMule:disenchant(itemLink, true);
        self:close();
    end);
    ThirdRow:AddChild(DisenchantButton);
    GL.Interface:setItem(self, "Disenchant", DisenchantButton);

    --[[
        FOURTH ROW
    ]]

    self:drawPlayersTable(Window.frame);

    --[[
        FIFTH ROW (AUTO CLOSE CHECKBOX)
    ]]

    local FourthRow = AceGUI:Create("SimpleGroup");
    FourthRow:SetLayout("Flow");
    FourthRow:SetFullWidth(true);
    FourthRow:SetHeight(20);
    Window:AddChild(FourthRow);

    --[[
        TABLE SETTINGS BUTTON
    ]]
    local PlayersTableFrame = AceGUI:Create("SimpleGroup");
    PlayersTableFrame:SetLayout("Fill");
    PlayersTableFrame:SetFullWidth(true);
    PlayersTableFrame:SetHeight(160);
    FourthRow:AddChild(PlayersTableFrame);

    local CloseOnStart = AceGUI:Create("CheckBox");
    CloseOnStart:SetLabel("Close on start");
    CloseOnStart:SetValue(GL.Settings:get("GDKP.closeAuctioneerOnStart", true));
    CloseOnStart:SetCallback("OnValueChanged", function (widget)
        GL.Settings:set("Auctioneer.closeOnStart", GL:toboolean(widget:GetValue()));
    end);
    CloseOnStart:SetWidth(110);
    FourthRow:AddChild(CloseOnStart);

    local CloseOnAward = AceGUI:Create("CheckBox");
    CloseOnAward:SetLabel("Close on award");
    CloseOnAward:SetValue(GL.Settings:get("GDKP.closeAuctioneerOnAward", true));
    CloseOnAward:SetCallback("OnValueChanged", function (widget)
        GL.Settings:set("UI.Auctioneer.closeOnAward", GL:toboolean(widget:GetValue()));
    end);
    CloseOnAward:SetWidth(116);
    FourthRow:AddChild(CloseOnAward);

    if (itemLink
        and type(itemLink) == "string"
    ) then
        Auctioneer:passItemLink(itemLink);
    end
end

function Auctioneer:show(Window)
    local ActiveSession = GL.GDKP:getActiveSession();

    if (not ActiveSession) then
        return false;
    end

    Window:SetStatusText(string.format(
        "Session: |c00a79eff%s|r (%s)",
        ActiveSession.title,
        date('%Y-%m-%d', ActiveSession.createdAt)
    ));

    Window:Show();
end

---@return void
function Auctioneer:close()
    GL:debug("Auctioneer:close");

    -- When the master looter closes the master loot window with a master
    -- loot still in progress we show the reopen master looter button
    if (GL.GDKP.inProgress) then
        self:drawReopenAuctioneerButton();
    end

    local Window = GL.Interface:getItem(self, "Window");
    if (Window) then
        -- Store the frame's last position for future play sessions
        GL.Interface:storePosition(Window, "Auctioneer");
        Window:Hide();
    end
end

-- Close the reopen masterlooter button
function Auctioneer:closeReopenAuctioneerButton()
    -- Close the reopen masterlooter button if it exists
    local OpenMasterLooterButton = GL.Interface:getItem(self, "Frame.OpenMasterLooterButton");

    if (OpenMasterLooterButton) then
        OpenMasterLooterButton:Hide();
    end
end

-- This button allows the master looter to easily reopen the
-- master looter window when it's closed with a roll in progress
-- This is very common in hectic situations where the master looter has to participate in combat f.e.
function Auctioneer:drawReopenAuctioneerButton()
    GL:debug("Auctioneer:drawReopenAuctioneerButton");

    -- Only draw the button if the master looter window is closed
    local Window = GL.Interface:getItem(self, "Window");
    if (Window and Window:IsShown()) then
        return;
    end

    local Button = GL.Interface:getItem(self, "Frame.OpenMasterLooterButton");

    if (Button) then
        Button:SetNormalTexture(GL.GDKP.CurrentAuction.itemIcon or "Interface\\Icons\\INV_Misc_QuestionMark");
        Button:Show();
        return;
    end

    local texture = GL.GDKP.CurrentAuction.itemIcon or "Interface\\Icons\\INV_Misc_QuestionMark";
    Button = CreateFrame("Button", "ReopenMasterLooterButton", UIParent, Frame);
    Button:SetSize(44, 44);
    Button:SetNormalTexture(texture);
    Button:SetText("text");
    Button:SetPoint(GL.Interface:getPosition("ReopenAuctioneerButton"));

    Button:SetMovable(true);
    Button:EnableMouse(true);
    Button:SetClampedToScreen(true);
    Button:SetFrameStrata("HIGH");
    Button:RegisterForDrag("LeftButton");
    Button:SetScript("OnDragStart", Button.StartMoving);
    Button:SetScript("OnDragStop", function()
        Button:StopMovingOrSizing();

        -- Store the frame's last position for future play sessions
        GL.Interface:storePosition(Button, "ReopenAuctioneerButton");
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

    GL.Interface:setItem(self, "OpenMasterLooterButton", Button);
end

function Auctioneer:drawPlayersTable(parent)
    GL:debug("Auctioneer:drawPlayersTable");

    -- Combined width of all colums should be 340
    local columns = {
        --[[ Player name ]]
        {
            name = "Player",
            width = 200,
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
    Table:SetWidth(340);
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
    GL.Interface:setItem(self, "Players", Table);
end

function Auctioneer:refreshRollsTable()
    GL:debug("RollOff:refreshRollsTable");

    local BidTableData = {};
    local Bids = GL.GDKP.CurrentAuction.Bids;
    local BidsTable = GL.Interface:getItem(self, "Table.Players");

    if (not BidsTable) then
        return;
    end

    for _, Entry in pairs(Bids) do
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
end

-- The item box contents changed
function Auctioneer:ItemBoxChanged()
    GL:debug("Auctioneer:ItemBoxChanged");

    local itemLink = GL.Interface:getItem(self, "EditBox.Item"):GetText();

    Auctioneer:passItemLink(itemLink);
end

-- Pass an item link to the master looter UI
-- This method is used when alt clicking an item
-- in a loot window or when executing /gl roll [itemlink]
function Auctioneer:passItemLink(itemLink)
    GL:debug("Auctioneer:passItemLink");

    if (not GL.Interface:getItem(self, "Window")) then
        return;
    end

    if (GL.GDKP.inProgress) then
        return GL:warning("A roll is currently in progress");
    end

    GL.Interface:getItem(self, "EditBox.Item"):SetText(itemLink);
    return Auctioneer:update();
end

-- Update the master looter UI based on the value of the ItemBox input
function Auctioneer:update()
    GL:debug("Auctioneer:update");

    local IconWidget = GL.Interface:getItem(self, "Icon.Item");
    local itemLink = GL.Interface:getItem(self, "EditBox.Item"):GetText();

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
        GL.Interface:getItem(self, "Table.Players"):ClearSelection();

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

    GL.Interface:getItem(self, "Icon.Item"):SetImage(Auctioneer.Defaults.itemIcon);
    GL.Interface:getItem(self, "EditBox.Item"):SetText(Auctioneer.Defaults.itemText);
    Auctioneer.itemBoxHoldsValidItem = false;

    GL.Interface:getItem(self, "Table.Players"):ClearSelection();
    GL.Interface:getItem(self, "Table.Players"):SetData({}, true);

    Auctioneer:updateWidgets();
end

-- Update the widgets based on the current state of the roll off
function Auctioneer:updateWidgets()
    GL:debug("Auctioneer:updateWidgets");

    -- If the itembox doesn't hold a valid item link then:
    --   The start button should not be available
    --   The stop button should be available
    --   The item box should be available
    if (not Auctioneer.itemBoxHoldsValidItem) then
        GL.Interface:getItem(self, "Button.Start"):SetDisabled(true);
        GL.Interface:getItem(self, "Button.Stop"):SetDisabled(true);
        GL.Interface:getItem(self, "EditBox.Item"):SetDisabled(false);
        GL.Interface:getItem(self, "Button.Award"):SetDisabled(true);
        GL.Interface:getItem(self, "Button.Disenchant"):SetDisabled(true);

        return;
    end

    -- The value in the itembox is valid (e.g. contains a valid item link)

    -- If no roll off is currently in progress then:
    --   The start button should be available
    --   The stop button should not be available
    --   The award button should not be available
    --   The clear button should not be available
    --   The item box should be available so we can enter an item link
    if (not GL.GDKP.inProgress) then
        GL.Interface:getItem(self, "Button.Start"):SetDisabled(false);
        GL.Interface:getItem(self, "Button.Stop"):SetDisabled(true);
        GL.Interface:getItem(self, "Button.Award"):SetDisabled(false);
        GL.Interface:getItem(self, "Button.Disenchant"):SetDisabled(false);
        GL.Interface:getItem(self, "Button.Clear"):SetDisabled(false);
        GL.Interface:getItem(self, "EditBox.Item"):SetDisabled(false);

        -- If a roll off is currently in progress then:
        --   The start button should not be available
        --   The stop button should be available
        --   The award button should not be available
        --   The clear button should not be available
        --   The item box should not be available
    else
        GL.Interface:getItem(self, "Button.Start"):SetDisabled(true);
        GL.Interface:getItem(self, "Button.Stop"):SetDisabled(false);
        GL.Interface:getItem(self, "Button.Award"):SetDisabled(true);
        GL.Interface:getItem(self, "Button.Disenchant"):SetDisabled(true);
        GL.Interface:getItem(self, "Button.Clear"):SetDisabled(true);
        GL.Interface:getItem(self, "EditBox.Item"):SetDisabled(true);
    end
end

GL:debug("Auctioneer.lua");