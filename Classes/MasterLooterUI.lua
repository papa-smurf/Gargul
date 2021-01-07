local _, App = ...;

App.RollOff = App.RollOff or {};
App.MasterLooterUI = App.MasterLooterUI or {};
App.Ace.ScrollingTable = App.Ace.ScrollingTable or LibStub("ScrollingTable");

local Settings = App.Settings;
local AceGUI = App.Ace.GUI;
local MasterLooterUI = App.MasterLooterUI;
local ScrollingTable = App.Ace.ScrollingTable;

MasterLooterUI.Defaults = {
    itemIcon = "Interface\\Icons\\INV_Misc_QuestionMark",
    itemBoxText = "",
};

MasterLooterUI.Widgets = {
    Frame = {},
    Buttons = {},
    EditBoxes = {},
    Labels = {},
    Tables = {},
    Icons = {},
};
MasterLooterUI.ItemPriorityBox = {};
MasterLooterUI.ItemBoxHoldsValidItem = false;

MasterLooterUI.PlayersTable = {};

-- This is the UI the person who rolls off an item uses to prepare everything e.g:
-- Select an item
-- Set the duration of the roll off
-- Award the item to the winner
function MasterLooterUI:draw(itemLink)
    App:debug("MasterLooterUI:draw");

    local isValidItem, itemId, itemName, itemLink = App:getItemInfoFromLink(itemLink);

    if (self.Widgets.Frame
        and self.Widgets.Frame.rendered
    ) then
        return self.Widgets.Frame:Show();
    end

    -- Create a container/parent frame
    local RollOffFrame = AceGUI:Create("Frame");
    RollOffFrame:SetTitle("Gargul v" .. App.version);
    RollOffFrame:SetLayout("Flow");
    RollOffFrame:SetWidth(430);
    RollOffFrame:SetHeight(350);
    RollOffFrame:EnableResize(false);
    RollOffFrame.rendered = true;
    RollOffFrame.frame:SetFrameStrata("HIGH");
    RollOffFrame.statustext:GetParent():Hide(); -- Hide the statustext bar
    RollOffFrame:SetCallback("OnClose", function(widget)
        local point, _, relativePoint, offsetX, offsetY = RollOffFrame:GetPoint();

        -- Store the frame's last position for future play sessions
        Settings:set("UI.RollOff.Position.point", point);
        Settings:set("UI.RollOff.Position.relativePoint", relativePoint);
        Settings:set("UI.RollOff.Position.offsetX", offsetX);
        Settings:set("UI.RollOff.Position.offsetY", offsetY);
    end);
    RollOffFrame:SetPoint(
        Settings:get("UI.RollOff.Position.point"),
        UIParent,
        Settings:get("UI.RollOff.Position.relativePoint"),
        Settings:get("UI.RollOff.Position.offsetX"),
        Settings:get("UI.RollOff.Position.offsetY")
    );

    self.Widgets.Frame = RollOffFrame;

            --[[
                FIRST ROW (ITEM ICON AND LINK BOX)
            ]]

            local FirstRow = AceGUI:Create("SimpleGroup");
            FirstRow:SetLayout("Flow");
            FirstRow:SetFullWidth(true);
            FirstRow:SetHeight(30);
            RollOffFrame:AddChild(FirstRow);

                    --[[
                        ITEM ICON
                    ]]

                    local ItemIcon = AceGUI:Create("Icon");
                    ItemIcon:SetImage("Interface\\Icons\\INV_Misc_QuestionMark");
                    ItemIcon:SetImageSize(30, 30);
                    ItemIcon:SetWidth(40);
                    FirstRow:AddChild(ItemIcon);
                    self.Widgets.Icons.Item = ItemIcon;

                    --[[
                        ITEM TEXTBOX
                    ]]
                    local ItemBox = AceGUI:Create("EditBox");

                    local updateItemInfo = function()
                        MasterLooterUI:updateItemIcon();
                        MasterLooterUI:updateItemPriority();
                        MasterLooterUI:updateWidgets();

                        if (isValidItem) then
                            ItemBox:SetText(itemLink);
                        end
                    end;

                    ItemBox:DisableButton(true);
                    ItemBox:SetHeight(20);
                    ItemBox:SetWidth(170);
                    ItemBox:SetCallback("OnTextChanged", updateItemInfo); -- Update item info when input value changes
                    ItemBox:SetCallback("OnEnterPressed", updateItemInfo); -- Update item info when item is dragged on top (makes no sense to use OnEnterPressed I know)

                    self.Widgets.EditBoxes.Item = ItemBox;

                    FirstRow:AddChild(ItemBox);

                    -- Show a gametooltip if the icon shown belongs to an item
                    ItemIcon:SetCallback("OnEnter", function()
                        if (not self.ItemBoxHoldsValidItem) then
                            return;
                        end

                        local itemLink = ItemBox:GetText();
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

                    local ButtonPadder = AceGUI:Create("SimpleGroup");
                    ButtonPadder:SetLayout("Flow");
                    ButtonPadder:SetWidth(20);
                    ButtonPadder:SetHeight(30);
                    FirstRow:AddChild(ButtonPadder);

                    --[[
                        START/STOP BUTTON
                    ]]

                    local StartButton = AceGUI:Create("Button");
                    StartButton:SetText("Start");
                    StartButton:SetWidth(80);
                    StartButton:SetHeight(20);
                    StartButton:SetDisabled(true);
                    StartButton:SetCallback("OnClick", function()
                        App.RollOff.inProgress = true;

                        App.RollOff:announceStart(
                            self.Widgets.EditBoxes.Item:GetText(),
                            self.Widgets.EditBoxes.Timer:GetText()
                        );

                        self:updateWidgets();
                    end);
                    FirstRow:AddChild(StartButton);
                    self.Widgets.Buttons.StartButton = StartButton;

                    --[[
                        STOP BUTTON
                    ]]

                    local StopButton = AceGUI:Create("Button");
                    StopButton:SetText("Stop");
                    StopButton:SetWidth(80);
                    StopButton:SetHeight(20);
                    StopButton:SetDisabled(true);
                    StopButton:SetCallback("OnClick", function()
                        App.RollOff:announceStop();
                    end);
                    FirstRow:AddChild(StopButton);
                    self.Widgets.Buttons.StopButton = StopButton;

            --[[
                SECOND ROW
            ]]

            local SecondRow = AceGUI:Create("SimpleGroup");
            SecondRow:SetLayout("Flow");
            SecondRow:SetFullWidth(true);
            SecondRow:SetHeight(20);
            RollOffFrame:AddChild(SecondRow);

                    --[[
                        SPACER
                    ]]

                    local PreItemPrioSpacer = AceGUI:Create("SimpleGroup");
                    PreItemPrioSpacer:SetLayout("Flow");
                    PreItemPrioSpacer:SetWidth(8);
                    PreItemPrioSpacer:SetHeight(20);
                    SecondRow:AddChild(PreItemPrioSpacer);

                    --[[
                        ITEM PRIO
                    ]]

                    local ItemPrio = AceGUI:Create("Label");
                    ItemPrio:SetColor(.94, .72, .8);
                    ItemPrio:SetHeight(20);
                    ItemPrio:SetWidth(150);
                    SecondRow:AddChild(ItemPrio);
                    self.Widgets.Labels.ItemPriority = ItemPrio;

            --[[
                THID ROW (ROLL TIMER)
            ]]

            local ThirdRow = AceGUI:Create("SimpleGroup");
            ThirdRow:SetLayout("Flow");
            ThirdRow:SetFullWidth(true);
            ThirdRow:SetHeight(20);
            RollOffFrame:AddChild(ThirdRow);

                    --[[
                        SPACER
                    ]]

                    local PreTimerLabelSpacer = AceGUI:Create("SimpleGroup");
                    PreTimerLabelSpacer:SetLayout("Flow");
                    PreTimerLabelSpacer:SetWidth(8);
                    PreTimerLabelSpacer:SetHeight(20);
                    ThirdRow:AddChild(PreTimerLabelSpacer);

                    --[[
                        TIMER LABEL
                    ]]

                    local TimerLabel = AceGUI:Create("Label");
                    TimerLabel:SetText("TIMER (s)");
                    TimerLabel:SetHeight(20);
                    TimerLabel:SetWidth(55);
                    ThirdRow:AddChild(TimerLabel);
                    self.Widgets.Labels.TimerLabel = TimerLabel;

                    --[[
                        TIMER TEXTBOX
                    ]]

                    local TimerBox = AceGUI:Create("EditBox");
                    TimerBox:DisableButton(true);
                    TimerBox:SetHeight(20);
                    TimerBox:SetWidth(40);
                    TimerBox:SetText(Settings:get("UI.RollOff.timer"));
                    ThirdRow:AddChild(TimerBox);
                    self.Widgets.EditBoxes.Timer = TimerBox;

                    --[[
                        SPACER
                    ]]

                    local TimerAndAwardSpacer = AceGUI:Create("SimpleGroup");
                    TimerAndAwardSpacer:SetLayout("Flow");
                    TimerAndAwardSpacer:SetWidth(20);
                    TimerAndAwardSpacer:SetHeight(30);
                    ThirdRow:AddChild(TimerAndAwardSpacer);

                    --[[
                        RESET BUTTON
                    ]]
                    local ClearButton = AceGUI:Create("Button");
                    ClearButton:SetText("Clear");
                    ClearButton:SetWidth(66);
                    ClearButton:SetHeight(20);
                    ClearButton:SetDisabled(false);
                    ClearButton:SetCallback("OnClick", function()
                        MasterLooterUI:reset();
                    end);
                    ThirdRow:AddChild(ClearButton);
                    self.Widgets.Buttons.ClearButton = ClearButton;

                    --[[
                        AWARD BUTTON
                    ]]

                    local AwardButton = AceGUI:Create("Button");
                    AwardButton:SetText("Award");
                    AwardButton:SetWidth(70);
                    AwardButton:SetHeight(20);
                    AwardButton:SetDisabled(true);
                    AwardButton:SetCallback("OnClick", function()
                        local PlayersTable = self.Widgets.Tables.Players;
                        local selected = PlayersTable:GetRow(PlayersTable:GetSelection());

                        if (not selected
                            or not type(selected) == "table"
                        ) then
                            return App:warning("You need to select a player first");
                        end

                        return App.RollOff:award(unpack(selected), self.Widgets.EditBoxes.Item:GetText());
                    end);
                    ThirdRow:AddChild(AwardButton);
                    self.Widgets.Buttons.AwardButton = AwardButton;

            --[[
                FOURTH ROW (GROUP MEMBERS)
            ]]

            local FourthRow = AceGUI:Create("SimpleGroup");
            FourthRow:SetLayout("Flow");
            FourthRow:SetFullWidth(true);
            FourthRow:SetHeight(50);
            RollOffFrame:AddChild(FourthRow);

            self:drawPlayersTable(RollOffFrame.frame);

    if (isValidItem) then
        MasterLooterUI:updateItemIcon();
        MasterLooterUI:updateItemPriority();
        MasterLooterUI:updateWidgets();
    end;
end

function MasterLooterUI:drawPlayersTable(parent)
    App:debug("MasterLooterUI:drawPlayersTable");

    local columns = {
        {
            name = "Player",
            width = 340,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
            sort = App.Data.Constants.ScrollingTable.ascending,
        },
    };

    local table = ScrollingTable:CreateST(columns, 8, 15, nil, parent);
    table:EnableSelection(true);
    table.frame:SetPoint("BOTTOM", parent, "BOTTOM", 0, 50);
    self.Widgets.Tables.Players = table;

    local GroupMembers = {};
    local PlayersTableData = {};

    -- Loop through all members of the group (party or raid)
    for index = 1, MAX_RAID_MEMBERS do
        local name = GetRaidRosterInfo(index);

        if (name) then
            tinsert(GroupMembers, name);
        end
    end

    for _, player in pairs(GroupMembers) do
        tinsert(PlayersTableData, {player});
    end

    table:SetData(PlayersTableData, true);
    table:SortData();
end

-- Update the icon box based on the value of the ItemBox input
function MasterLooterUI:updateItemIcon()
    App:debug("MasterLooterUI:updateItemIcon");

    local IconWidget = self.Widgets.Icons.Item;
    local itemLink = self.Widgets.EditBoxes.Item:GetText();

    if (not itemLink or itemLink == "") then
        self.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage("Interface\\Icons\\INV_Misc_QuestionMark");
        return;
    end

    -- The item's icon is in the 10th position
    local icon = select(10, GetItemInfo(itemLink));

    if (icon) then
        if (App.RollOff.CurrentRollOff.itemLink
                and itemLink ~= App.RollOff.CurrentRollOff.itemLink
        ) then
            MasterLooterUI.Widgets.Tables.Players:ClearSelection();
        end

        IconWidget:SetImage(icon);
        self.ItemBoxHoldsValidItem = true;
    else
        self.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage("Interface\\Icons\\INV_Misc_QuestionMark");
    end
end

-- Update the item priority string
function MasterLooterUI:updateItemPriority(ItemPriorityBox, itemLink)
    local ItemPriorityBox = self.Widgets.Labels.ItemPriority;
    local itemLink = self.Widgets.EditBoxes.Item:GetText();

    App:debug("MasterLooterUI:updateItemPriority");

    if (not self.ItemBoxHoldsValidItem) then
        ItemPriorityBox:SetText("");
        return;
    end

    local itemPriority = App.LootPriority:getPriorityByItemLink(itemLink);

    if (not itemPriority) then
        ItemPriorityBox:SetText("Off spec");
    else
        itemPriority = table.concat(itemPriority, " > ");
        ItemPriorityBox:SetText(itemPriority);
    end
end

-- Reset the roll off UI to its defaults
function MasterLooterUI:reset()
    self.Widgets.Icons.Item:SetImage(self.Defaults.itemIcon);
    self.Widgets.EditBoxes.Item:SetText(self.Defaults.itemText);
    self.Widgets.EditBoxes.Timer:SetText(Settings:get("UI.RollOff.timer"));
    self.Widgets.Labels.ItemPriority:SetText("");
    self.ItemBoxHoldsValidItem = false;

    MasterLooterUI.Widgets.Tables.Players:ClearSelection();

    self:updateWidgets();
end

-- Update the widgets based on the current state of the roll off
function MasterLooterUI:updateWidgets()
    App:debug("MasterLooterUI:updateWidgets");

    -- If the itembox doesn't hold a valid item link then
    -- The start button should not be available
    -- The stop button should be available
    -- The item box should be available
    if (not self.ItemBoxHoldsValidItem or not App.User.isInGroup) then
        self.Widgets.Buttons.StartButton:SetDisabled(true);
        self.Widgets.Buttons.StartButton:SetDisabled(true);
        self.Widgets.Buttons.StopButton:SetDisabled(true);
        self.Widgets.EditBoxes.Item:SetDisabled(false);

        return;
    end

    -- The value in the itembox is valid (e.g. contains a valid item link)

    -- If no roll off is currently in progress then:
    -- The start button should be available
    -- The stop button should not be available
    -- The item box should be available so we can enter an item link
    if (not App.RollOff.inProgress) then
        self.Widgets.Buttons.StartButton:SetDisabled(false);
        self.Widgets.Buttons.AwardButton:SetDisabled(false);
        self.Widgets.Buttons.StopButton:SetDisabled(true);
        self.Widgets.Buttons.ClearButton:SetDisabled(false);
        self.Widgets.EditBoxes.Item:SetDisabled(false);

    -- If an roll off is currently in progress then:
        -- The start button should not be available
        -- The stop button should be available
        -- The item box should not be available
    else
        self.Widgets.Buttons.StartButton:SetDisabled(true);
        self.Widgets.Buttons.AwardButton:SetDisabled(true);
        self.Widgets.Buttons.StopButton:SetDisabled(false);
        self.Widgets.Buttons.ClearButton:SetDisabled(true);
        self.Widgets.EditBoxes.Item:SetDisabled(true);
    end
end

App:debug("MasterLooterUI.lua");