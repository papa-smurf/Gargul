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

MasterLooterUI.ItemBoxHoldsValidItem = false;

MasterLooterUI.PlayersTable = {};

-- This is the UI the person who rolls off an item uses to prepare everything e.g:
-- Select an item
-- Set the duration of the roll off
-- Award the item to the winner
function MasterLooterUI:draw(itemLink)
    Utils:debug("MasterLooterUI:draw");

    if (not App.User.isMasterLooter
        and not App.User.hasAssist
    ) then
        return App:warning("You need to be the master looter or have an assist / lead role!");
    end

    -- First we need to check if the frame hasn't been
    -- rendered already. If so then show it (if it's hidden)
    -- and pass the itemLink along in case one was provided
    if (MasterLooterUI.Widgets.Frame
        and MasterLooterUI.Widgets.Frame.rendered
    ) then
        if (itemLink) then
            MasterLooterUI:passItemLink(itemLink);
        end

        -- If the frame is hidden we need to show it again
        if (not MasterLooterUI.Widgets.Frame:IsShown()) then
            MasterLooterUI.Widgets.Frame:Show();
        end

        return;
    end

    -- Create a container/parent frame
    local RollOffFrame = AceGUI:Create("Frame");
    RollOffFrame:SetTitle(App.name .. " v" .. App.version);
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

    MasterLooterUI.Widgets.Frame = RollOffFrame;

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
                    ItemIcon:SetImage(MasterLooterUI.Defaults.itemIcon);
                    ItemIcon:SetImageSize(30, 30);
                    ItemIcon:SetWidth(40);
                    FirstRow:AddChild(ItemIcon);
                    MasterLooterUI.Widgets.Icons.Item = ItemIcon;

                    --[[
                        ITEM TEXTBOX
                    ]]
                    local ItemBox = AceGUI:Create("EditBox");

                    ItemBox:DisableButton(true);
                    ItemBox:SetHeight(20);
                    ItemBox:SetWidth(170);
                    ItemBox:SetCallback("OnTextChanged", MasterLooterUI.ItemBoxChanged); -- Update item info when input value changes
                    ItemBox:SetCallback("OnEnterPressed", MasterLooterUI.ItemBoxChanged); -- Update item info when item is dragged on top (makes no sense to use OnEnterPressed I know)

                    MasterLooterUI.Widgets.EditBoxes.Item = ItemBox;

                    FirstRow:AddChild(ItemBox);

                    -- Show a gametooltip if the icon shown belongs to an item
                    ItemIcon:SetCallback("OnEnter", function()
                        if (not MasterLooterUI.ItemBoxHoldsValidItem) then
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
                    ButtonPadder:SetWidth(14);
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
                            MasterLooterUI.Widgets.EditBoxes.Item:GetText(),
                            MasterLooterUI.Widgets.EditBoxes.Timer:GetText(),
                            MasterLooterUI.Widgets.EditBoxes.ItemNote:GetText()
                        );

                        MasterLooterUI:updateWidgets();
                    end);
                    FirstRow:AddChild(StartButton);
                    MasterLooterUI.Widgets.Buttons.StartButton = StartButton;

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
                    MasterLooterUI.Widgets.Buttons.StopButton = StopButton;

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

                    local PreItemNoteLabelSpacer = AceGUI:Create("SimpleGroup");
                    PreItemNoteLabelSpacer:SetLayout("Flow");
                    PreItemNoteLabelSpacer:SetWidth(8);
                    PreItemNoteLabelSpacer:SetHeight(20);
                    SecondRow:AddChild(PreItemNoteLabelSpacer);

                    --[[
                        ITEM NOTE LABEL
                    ]]

                    local ItemNoteLabel = AceGUI:Create("Label");
                    ItemNoteLabel:SetText("NOTE");
                    ItemNoteLabel:SetHeight(20);
                    ItemNoteLabel:SetWidth(35);
                    SecondRow:AddChild(ItemNoteLabel);
                    MasterLooterUI.Widgets.EditBoxes.ItemNoteLabel = ItemNoteLabel;

                    --[[
                        ITEM NOTE
                    ]]

                    local ItemNote = AceGUI:Create("EditBox");
                    ItemNote:DisableButton(true);
                    ItemNote:SetHeight(20);
                    ItemNote:SetWidth(340);
                    SecondRow:AddChild(ItemNote);
                    MasterLooterUI.Widgets.EditBoxes.ItemNote = ItemNote;

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
                    MasterLooterUI.Widgets.Labels.TimerLabel = TimerLabel;

                    --[[
                        TIMER TEXTBOX
                    ]]

                    local TimerBox = AceGUI:Create("EditBox");
                    TimerBox:DisableButton(true);
                    TimerBox:SetHeight(20);
                    TimerBox:SetWidth(40);
                    TimerBox:SetText(Settings:get("UI.RollOff.timer"));
                    ThirdRow:AddChild(TimerBox);
                    MasterLooterUI.Widgets.EditBoxes.Timer = TimerBox;

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
                    MasterLooterUI.Widgets.Buttons.ClearButton = ClearButton;

                    --[[
                        AWARD BUTTON
                    ]]

                    local AwardButton = AceGUI:Create("Button");
                    AwardButton:SetText("Award");
                    AwardButton:SetWidth(70);
                    AwardButton:SetHeight(20);
                    AwardButton:SetDisabled(true);
                    AwardButton:SetCallback("OnClick", function()
                        local PlayersTable = MasterLooterUI.Widgets.Tables.Players;
                        local selected = PlayersTable:GetRow(PlayersTable:GetSelection());

                        if (not selected
                            or not type(selected) == "table"
                        ) then
                            return App:warning("You need to select a player first");
                        end

                        return App.RollOff:award(unpack(selected), MasterLooterUI.Widgets.EditBoxes.Item:GetText());
                    end);
                    ThirdRow:AddChild(AwardButton);
                    MasterLooterUI.Widgets.Buttons.AwardButton = AwardButton;

            --[[
                FOURTH ROW (GROUP MEMBERS)
            ]]

            local FourthRow = AceGUI:Create("SimpleGroup");
            FourthRow:SetLayout("Flow");
            FourthRow:SetFullWidth(true);
            FourthRow:SetHeight(50);
            RollOffFrame:AddChild(FourthRow);

            MasterLooterUI:drawPlayersTable(RollOffFrame.frame);

    if (itemLink
        and type(itemLink) == "string"
    ) then
        MasterLooterUI:passItemLink(itemLink);
    end
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
    MasterLooterUI.Widgets.Tables.Players = table;

    local PlayersTableData = {};

    for _, player in pairs(App.User:groupMembers()) do
        tinsert(PlayersTableData, {player});
    end

    table:SetData(PlayersTableData, true);
    table:SortData();
end

-- The item box contents changed
function MasterLooterUI:ItemBoxChanged()
    Utils:debug("MasterLooterUI:ItemBoxChanged");

    local itemLink = MasterLooterUI.Widgets.EditBoxes.Item:GetText();

    MasterLooterUI:passItemLink(itemLink);
end

-- Pass an item link to the master looter UI
-- This method is used when alt clicking an item
-- in a loot window or when executing /gl roll [itemlink]
function MasterLooterUI:passItemLink(itemLink)
    Utils:debug("MasterLooterUI:passItemLink");

    if (not MasterLooterUI.Widgets.Frame.rendered) then
        return;
    end

    if (App.RollOff.inProgress) then
        return App:warning("A roll is currently in progress");
    end

    MasterLooterUI.Widgets.EditBoxes.Item:SetText(itemLink);
    return MasterLooterUI:update();
end

-- Update the master looter UI based on the value of the ItemBox input
function MasterLooterUI:update()
    App:debug("MasterLooterUI:update");

    local IconWidget = MasterLooterUI.Widgets.Icons.Item;
    local itemLink = MasterLooterUI.Widgets.EditBoxes.Item:GetText();

    -- If the item link is not valid then
    --   Show the default question mark icon
    --   Remove the item priority string
    if (not itemLink or itemLink == "") then
        App:debug("MasterLooterUI:update. Item link is invalid");

        MasterLooterUI.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage(MasterLooterUI.Defaults.itemIcon);

        MasterLooterUI:updateItemNote();
        MasterLooterUI:updateWidgets();
        return;
    end

    -- The item's icon is in the 10th position
    local icon = select(10, GetItemInfo(itemLink));

    if (icon) then
        -- TODO: Reset players / roll table
        MasterLooterUI.Widgets.Tables.Players:ClearSelection();

        IconWidget:SetImage(icon);
        MasterLooterUI.ItemBoxHoldsValidItem = true;
    else
        MasterLooterUI.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage(MasterLooterUI.Defaults.itemIcon);
    end

    MasterLooterUI:updateItemNote();
    MasterLooterUI:updateWidgets();
end

-- Update the item priority string
function MasterLooterUI:updateItemNote()
    Utils:debug("MasterLooterUI:updateItemNote");

    local ItemNote = MasterLooterUI.Widgets.EditBoxes.ItemNote;
    local itemLink = MasterLooterUI.Widgets.EditBoxes.Item:GetText();

    -- We don't have a valid itemlink at hand, clear the note
    if (not MasterLooterUI.ItemBoxHoldsValidItem) then
        return ItemNote:SetText("");
    end

    local itemPriority = App.LootPriority:getPriorityByItemLink(itemLink);

    -- If there is no item priority then label the item with "Off spec"
    if (not itemPriority) then
        return ItemNote:SetText("Off spec");
    end

    -- There is a priority for this item
    itemPriority = table.concat(itemPriority, " > ");
    ItemNote:SetText(itemPriority);
end

-- Reset the roll off UI to its defaults
function MasterLooterUI:reset()
    MasterLooterUI.Widgets.Icons.Item:SetImage(MasterLooterUI.Defaults.itemIcon);
    MasterLooterUI.Widgets.EditBoxes.Item:SetText(MasterLooterUI.Defaults.itemText);
    MasterLooterUI.Widgets.EditBoxes.Timer:SetText(Settings:get("UI.RollOff.timer"));
    MasterLooterUI.Widgets.EditBoxes.ItemNote:SetText("");
    MasterLooterUI.ItemBoxHoldsValidItem = false;

    MasterLooterUI.Widgets.Tables.Players:ClearSelection();

    MasterLooterUI:updateWidgets();
end

-- Update the widgets based on the current state of the roll off
function MasterLooterUI:updateWidgets()
    Utils:debug("MasterLooterUI:updateWidgets");

    -- If the itembox doesn't hold a valid item link then:
    --   The start button should not be available
    --   The stop button should be available
    --   The item box should be available
    if (not MasterLooterUI.ItemBoxHoldsValidItem
        or not App.User.isInGroup
    ) then
        MasterLooterUI.Widgets.Buttons.StartButton:SetDisabled(true);
        MasterLooterUI.Widgets.Buttons.StopButton:SetDisabled(true);
        MasterLooterUI.Widgets.EditBoxes.Item:SetDisabled(false);

        return;
    end

    -- The value in the itembox is valid (e.g. contains a valid item link)

    -- If no roll off is currently in progress then:
    --   The start button should be available
    --   The stop button should not be available
    --   The award button should not be available
    --   The clear button should not be available
    --   The item box should be available so we can enter an item link
    if (not App.RollOff.inProgress) then
        MasterLooterUI.Widgets.Buttons.StartButton:SetDisabled(false);
        MasterLooterUI.Widgets.Buttons.StopButton:SetDisabled(true);
        MasterLooterUI.Widgets.Buttons.AwardButton:SetDisabled(false);
        MasterLooterUI.Widgets.Buttons.ClearButton:SetDisabled(false);
        MasterLooterUI.Widgets.EditBoxes.Item:SetDisabled(false);

    -- If a roll off is currently in progress then:
    --   The start button should not be available
    --   The stop button should be available
    --   The award button should not be available
    --   The clear button should not be available
    --   The item box should not be available
    else
        MasterLooterUI.Widgets.Buttons.StartButton:SetDisabled(true);
        MasterLooterUI.Widgets.Buttons.StopButton:SetDisabled(false);
        MasterLooterUI.Widgets.Buttons.AwardButton:SetDisabled(true);
        MasterLooterUI.Widgets.Buttons.ClearButton:SetDisabled(true);
        MasterLooterUI.Widgets.EditBoxes.Item:SetDisabled(true);
    end
end

Utils:debug("MasterLooterUI.lua");