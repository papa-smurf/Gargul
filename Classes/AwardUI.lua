local _, GL = ...;

GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

GL.AwardUI = {
    ItemBoxHoldsValidItem = false,
    PlayersTable = {},
    UIComponents = {
        Frame = {},
        Buttons = {},
        EditBoxes = {},
        Labels = {},
        Tables = {},
        Icons = {},
    },
    Defaults = {
        itemIcon = "Interface\\Icons\\INV_Misc_QuestionMark",
        itemBoxText = "",
    },
};

local AceGUI = GL.AceGUI;
local Settings = GL.Settings;
local AwardUI = GL.AwardUI;
local ScrollingTable = GL.ScrollingTable;

-- This is the UI the person who rolls off an item uses to prepare everything e.g:
-- Select an item
-- Set the duration of the roll off
-- Award the item to the winner
function AwardUI:draw(itemLink)
    GL:debug("AwardUI:draw");

    -- First we need to check if the frame hasn't been
    -- rendered already. If so then show it (if it's hidden)
    -- and pass the itemLink along in case one was provided
    if (AwardUI.UIComponents.Frame
        and AwardUI.UIComponents.Frame.rendered
    ) then
        if (itemLink) then
            AwardUI:passItemLink(itemLink);
        end

        -- If the frame is hidden we need to show it again
        if (not AwardUI.UIComponents.Frame:IsShown()) then
            AwardUI.UIComponents.Frame:Show();
        end

        AwardUI:populatePlayersTable();
        return;
    end

    -- Create a container/parent frame
    local AwardFrame = AceGUI:Create("Frame");
    AwardFrame:SetTitle(GL.name .. " v" .. GL.version);
    AwardFrame:SetLayout("Flow");
    AwardFrame:SetWidth(430);
    AwardFrame:SetHeight(290);
    AwardFrame:EnableResize(false);
    AwardFrame.rendered = true;
    AwardFrame.frame:SetFrameStrata("HIGH");
    AwardFrame.statustext:GetParent():Hide(); -- Hide the statustext bar
    AwardFrame:SetCallback("OnClose", function(widget)
        self:close(widget);
    end);
    AwardFrame:SetPoint(GL.Interface:getPosition("Award"));

    AwardUI.UIComponents.Frame = AwardFrame;

            --[[
                FIRST ROW (ITEM AND BUTTONS)
            ]]

            local FirstRow = AceGUI:Create("SimpleGroup");
            FirstRow:SetLayout("Flow");
            FirstRow:SetFullWidth(true);
            FirstRow:SetHeight(30);
            AwardFrame:AddChild(FirstRow);

                    --[[
                        ITEM ICON
                    ]]

                    local ItemIcon = AceGUI:Create("Icon");
                    ItemIcon:SetImage(AwardUI.Defaults.itemIcon);
                    ItemIcon:SetImageSize(30, 30);
                    ItemIcon:SetWidth(40);
                    FirstRow:AddChild(ItemIcon);
                    AwardUI.UIComponents.Icons.Item = ItemIcon;

                    --[[
                        ITEM TEXTBOX
                    ]]
                    local ItemBox = AceGUI:Create("EditBox");

                    ItemBox:DisableButton(true);
                    ItemBox:SetHeight(20);
                    ItemBox:SetWidth(170);
                    ItemBox:SetCallback("OnTextChanged", AwardUI.ItemBoxChanged); -- Update item info when input value changes
                    ItemBox:SetCallback("OnEnterPressed", AwardUI.ItemBoxChanged); -- Update item info when item is dragged on top (makes no sense to use OnEnterPressed I know)

                    AwardUI.UIComponents.EditBoxes.Item = ItemBox;

                    FirstRow:AddChild(ItemBox);

                    -- Show a gametooltip if the icon shown belongs to an item
                    ItemIcon:SetCallback("OnEnter", function()
                        if (not AwardUI.ItemBoxHoldsValidItem) then
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
                        SPACER
                    ]]

                    local PreClearButtonSpacer = AceGUI:Create("SimpleGroup");
                    PreClearButtonSpacer:SetLayout("Flow");
                    PreClearButtonSpacer:SetWidth(8);
                    PreClearButtonSpacer:SetHeight(20);
                    FirstRow:AddChild(PreClearButtonSpacer);

                    --[[
                        RESET BUTTON
                    ]]
                    local ClearButton = AceGUI:Create("Button");
                    ClearButton:SetText("Clear");
                    ClearButton:SetWidth(66);
                    ClearButton:SetHeight(20);
                    ClearButton:SetDisabled(false);
                    ClearButton:SetCallback("OnClick", function()
                        AwardUI:reset();
                    end);
                    FirstRow:AddChild(ClearButton);
                    AwardUI.UIComponents.Buttons.ClearButton = ClearButton;

                    --[[
                        AWARD BUTTON
                    ]]

                    local AwardButton = AceGUI:Create("Button");
                    AwardButton:SetText("Award");
                    AwardButton:SetWidth(70);
                    AwardButton:SetHeight(20);
                    AwardButton:SetDisabled(true);
                    AwardButton:SetCallback("OnClick", function()
                        local PlayersTable = AwardUI.UIComponents.Tables.Players;
                        local selected = PlayersTable:GetRow(PlayersTable:GetSelection());

                        if (not selected or type(selected) ~= "table") then
                            return;
                        end

                        local winner = selected.cols[1].value;
                        local itemLink = AwardUI.UIComponents.EditBoxes.Item:GetText();

                        if (not selected
                            or not type(selected) == "table"
                        ) then
                            return GL:warning("You need to select a player first");
                        end

                        local award = function ()
                            -- Add the player we awarded the item to to the item's tooltip
                            GL.AwardedLoot:addWinner(winner, itemLink);

                            RollOff = {};
                            GL.AwardUI:reset();
                        end

                        -- Make sure the initiator has to confirm his choices
                        StaticPopupDialogs[GL.name .. "_AWARD_CONFIRMATION"].OnAccept = award;
                        StaticPopupDialogs[GL.name .. "_AWARD_CONFIRMATION"].text = string.format("Award %s to %s?",
                            itemLink,
                            winner
                        );
                        StaticPopup_Show(GL.name .. "_AWARD_CONFIRMATION");
                    end);
                    FirstRow:AddChild(AwardButton);
                    AwardUI.UIComponents.Buttons.AwardButton = AwardButton;


            --[[
                SECOND ROW (GROUP MEMBERS)
            ]]

            local SecondRow = AceGUI:Create("SimpleGroup");
            SecondRow:SetLayout("Flow");
            SecondRow:SetFullWidth(true);
            SecondRow:SetHeight(50);
            AwardFrame:AddChild(SecondRow);

            AwardUI:drawPlayersTable(AwardFrame.frame);


    if (itemLink
        and type(itemLink) == "string"
    ) then
        AwardUI:passItemLink(itemLink);
    end
end

function AwardUI:close(Frame)
    GL:debug("AwardUI:close");

    local point, _, relativePoint, offsetX, offsetY = Frame:GetPoint();

    -- Store the frame's last position for future play sessions
    Settings:set("UI.Award.Position.point", point);
    Settings:set("UI.Award.Position.relativePoint", relativePoint);
    Settings:set("UI.Award.Position.offsetX", offsetX);
    Settings:set("UI.Award.Position.offsetY", offsetY);
end

function AwardUI:drawPlayersTable(parent)
    GL:debug("AwardUI:drawPlayersTable");

    -- Combined width of all colums should be 340
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
        },
    };

    local table = ScrollingTable:CreateST(columns, 8, 15, nil, parent);
    table:EnableSelection(true);
    table.frame:SetPoint("BOTTOM", parent, "BOTTOM", 0, 60);
    AwardUI.UIComponents.Tables.Players = table;

    AwardUI:populatePlayersTable();
end

-- Populate the players table with your current group members
function AwardUI:populatePlayersTable()
    if (not AwardUI.UIComponents.Tables.Players) then
        return;
    end

    AwardUI.UIComponents.Tables.Players:ClearSelection();

    if (not GL.User.isInGroup) then
        return AwardUI.UIComponents.Tables.Players:SetData({}, true);
    end

    local TableData = {};
    for _, Player in pairs(GL.User:groupMembers()) do
        local name = Player.name;

        tinsert(TableData, {
            cols = {
                {
                    value = name,
                    color = GL:classRGBAColor(Player.class),
                },
            },
        });
    end

    AwardUI.UIComponents.Tables.Players:SetData(TableData);
end

-- The item box contents changed
function AwardUI:ItemBoxChanged()
    GL:debug("AwardUI:ItemBoxChanged");

    local itemLink = AwardUI.UIComponents.EditBoxes.Item:GetText();

    AwardUI:passItemLink(itemLink);
end

-- Pass an item link to the master looter UI
-- This method is used when alt clicking an item
-- in a loot window or when executing /gl roll [itemlink]
function AwardUI:passItemLink(itemLink)
    GL:debug("AwardUI:passItemLink");

    if (not AwardUI.UIComponents.Frame.rendered) then
        return;
    end

    AwardUI.UIComponents.EditBoxes.Item:SetText(itemLink);
    return AwardUI:update();
end

-- Update the master looter UI based on the value of the ItemBox input
function AwardUI:update()
    GL:debug("AwardUI:update");

    local IconWidget = AwardUI.UIComponents.Icons.Item;
    local itemLink = AwardUI.UIComponents.EditBoxes.Item:GetText();

    -- If the item link is not valid then
    --   Show the default question mark icon
    if (not itemLink or itemLink == "") then
        GL:debug("AwardUI:update. Item link is invalid");

        AwardUI.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage(AwardUI.Defaults.itemIcon);

        AwardUI:updateWidgets();
        return;
    end

    -- The item's icon is in the 10th position
    local icon = select(10, GetItemInfo(itemLink));

    if (icon) then
        AwardUI.UIComponents.Tables.Players:ClearSelection();

        IconWidget:SetImage(icon);
        AwardUI.ItemBoxHoldsValidItem = true;
    else
        AwardUI.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage(AwardUI.Defaults.itemIcon);
    end

    AwardUI:updateWidgets();
end

-- Reset the roll off UI to its defaults
function AwardUI:reset()
    GL:debug("AwardUI:reset");

    AwardUI.UIComponents.Icons.Item:SetImage(AwardUI.Defaults.itemIcon);
    AwardUI.UIComponents.EditBoxes.Item:SetText(AwardUI.Defaults.itemText);
    AwardUI.ItemBoxHoldsValidItem = false;

    AwardUI:populatePlayersTable();

    AwardUI:updateWidgets();
end

-- Update the widgets based on the current state of the roll off
function AwardUI:updateWidgets()
    GL:debug("AwardUI:updateWidgets");

    -- If the itembox doesn't hold a valid item link then:
    --   The start button should not be available
    --   The stop button should be available
    --   The item box should be available
    if (not AwardUI.ItemBoxHoldsValidItem) then
        AwardUI.UIComponents.Buttons.AwardButton:SetDisabled(true);
    else
        AwardUI.UIComponents.Buttons.AwardButton:SetDisabled(false);
    end
end

GL:debug("AwardUI.lua");