---@type GL
local _, GL = ...;

GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

---@class AwardInterface
GL.Interface.Award = {
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
local Settings = GL.Settings; ---@type Settings
local Award = GL.Interface.Award; ---@type AwardInterface
local ScrollingTable = GL.ScrollingTable;

--- This is the UI the person who rolls off an item uses to prepare everything e.g:
--- Select an item
--- Set the duration of the roll off
--- Award the item to the winner
---
---@param itemLink string
---@return void
function Award:draw(itemLink)
    GL:debug("Award:draw");

    -- First we need to check if the frame hasn't been
    -- rendered already. If so then show it (if it's hidden)
    -- and pass the itemLink along in case one was provided
    if (Award.UIComponents.Frame
        and Award.UIComponents.Frame.rendered
    ) then
        if (itemLink) then
            Award:passItemLink(itemLink);
        end

        -- If the frame is hidden we need to show it again
        if (not Award.UIComponents.Frame:IsShown()) then
            Award.UIComponents.Frame:Show();
        end

        Award:populatePlayersTable();
        return;
    end

    -- Create a container/parent frame
    local AwardFrame = AceGUI:Create("Frame");
    AwardFrame:SetTitle("Gargul v" .. GL.version);
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

    Award.UIComponents.Frame = AwardFrame;

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
    ItemIcon:SetImage(Award.Defaults.itemIcon);
    ItemIcon:SetImageSize(30, 30);
    ItemIcon:SetWidth(40);
    FirstRow:AddChild(ItemIcon);
    Award.UIComponents.Icons.Item = ItemIcon;

    --[[
        ITEM TEXTBOX
    ]]
    local ItemBox = AceGUI:Create("EditBox");

    ItemBox:DisableButton(true);
    ItemBox:SetHeight(20);
    ItemBox:SetWidth(170);
    ItemBox:SetCallback("OnTextChanged", Award.ItemBoxChanged); -- Update item info when input value changes
    ItemBox:SetCallback("OnEnterPressed", Award.ItemBoxChanged); -- Update item info when item is dragged on top (makes no sense to use OnEnterPressed I know)

    Award.UIComponents.EditBoxes.Item = ItemBox;

    FirstRow:AddChild(ItemBox);

    -- Show a gametooltip if the icon shown belongs to an item
    ItemIcon:SetCallback("OnEnter", function()
        if (not Award.ItemBoxHoldsValidItem) then
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
        Award:reset();
    end);
    FirstRow:AddChild(ClearButton);
    Award.UIComponents.Buttons.ClearButton = ClearButton;

    --[[
        AWARD BUTTON
    ]]

    local AwardButton = AceGUI:Create("Button");
    AwardButton:SetText("Award");
    AwardButton:SetWidth(70);
    AwardButton:SetHeight(20);
    AwardButton:SetDisabled(true);
    AwardButton:SetCallback("OnClick", function()
        local PlayersTable = Award.UIComponents.Tables.Players;
        local selected = PlayersTable:GetRow(PlayersTable:GetSelection());

        if (not selected or type(selected) ~= "table") then
            return;
        end

        local winner = selected.cols[1].value;
        local itemLink = Award.UIComponents.EditBoxes.Item:GetText();

        if (not selected
                or not type(selected) == "table"
        ) then
            return GL:warning("You need to select a player first");
        end

        local award = function ()
            -- Add the player we awarded the item to to the item's tooltip
            GL.AwardedLoot:addWinner(winner, itemLink);

            RollOff = {};
            GL.Interface.Award:reset();
        end

        -- Make sure the initiator has to confirm his choices
        GL.Interface.PopupDialog:open({
            question = string.format("Award %s to %s?",
                itemLink,
                winner
            ),
            OnYes = award,
        });
    end);
    FirstRow:AddChild(AwardButton);
    Award.UIComponents.Buttons.AwardButton = AwardButton;


    --[[
        SECOND ROW (GROUP MEMBERS)
    ]]

    local SecondRow = AceGUI:Create("SimpleGroup");
    SecondRow:SetLayout("Flow");
    SecondRow:SetFullWidth(true);
    SecondRow:SetHeight(50);
    AwardFrame:AddChild(SecondRow);

    Award:drawPlayersTable(AwardFrame.frame);


    if (itemLink
            and type(itemLink) == "string"
    ) then
        Award:passItemLink(itemLink);
    end
end

---@param Frame table
---@return void
function Award:close(Frame)
    GL:debug("Award:close");

    local point, _, relativePoint, offsetX, offsetY = Frame:GetPoint();

    -- Store the frame's last position for future play sessions
    Settings:set("UI.Award.Position.point", point);
    Settings:set("UI.Award.Position.relativePoint", relativePoint);
    Settings:set("UI.Award.Position.offsetX", offsetX);
    Settings:set("UI.Award.Position.offsetY", offsetY);
end

---@param Parent table
---@return void
function Award:drawPlayersTable(Parent)
    GL:debug("Award:drawPlayersTable");

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
            sort = GL.Data.Constants.ScrollingTable.ascending,
        },
    };

    local table = ScrollingTable:CreateST(columns, 8, 15, nil, Parent);
    table:EnableSelection(true);
    table.frame:SetPoint("BOTTOM", Parent, "BOTTOM", 0, 60);
    Award.UIComponents.Tables.Players = table;

    Award:populatePlayersTable();
end

-- Populate the players table with your current group members
function Award:populatePlayersTable()
    if (not Award.UIComponents.Tables.Players) then
        return;
    end

    Award.UIComponents.Tables.Players:ClearSelection();

    if (not GL.User.isInGroup) then
        return Award.UIComponents.Tables.Players:SetData({}, true);
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

    Award.UIComponents.Tables.Players:SetData(TableData);
end

--- The item box contents changed
---@return void
function Award:ItemBoxChanged()
    GL:debug("Award:ItemBoxChanged");

    local itemLink = Award.UIComponents.EditBoxes.Item:GetText();

    Award:passItemLink(itemLink);
end

--- Pass an item link to the master looter UI
--- This method is used when alt clicking an item
--- in a loot window or when executing /gl roll [itemlink]
---
---@param itemLink string
---@return void
function Award:passItemLink(itemLink)
    GL:debug("Award:passItemLink");

    if (not Award.UIComponents.Frame.rendered) then
        return;
    end

    Award.UIComponents.EditBoxes.Item:SetText(itemLink);
    Award:update();
end

--- Update the master looter UI based on the value of the ItemBox input
---
---@return void
function Award:update()
    GL:debug("Award:update");

    local IconWidget = Award.UIComponents.Icons.Item;
    local itemLink = Award.UIComponents.EditBoxes.Item:GetText();

    -- If the item link is not valid then
    --   Show the default question mark icon
    if (not itemLink or itemLink == "") then
        GL:debug("Award:update. Item link is invalid");

        Award.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage(Award.Defaults.itemIcon);

        Award:updateWidgets();
        return;
    end

    -- The item's icon is in the 10th position
    local icon = select(10, GetItemInfo(itemLink));

    if (icon) then
        Award.UIComponents.Tables.Players:ClearSelection();

        IconWidget:SetImage(icon);
        Award.ItemBoxHoldsValidItem = true;
    else
        Award.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage(Award.Defaults.itemIcon);
    end

    Award:updateWidgets();
end

--- Reset the roll off UI to its defaults
---
---@return void
function Award:reset()
    GL:debug("Award:reset");

    Award.UIComponents.Icons.Item:SetImage(Award.Defaults.itemIcon);
    Award.UIComponents.EditBoxes.Item:SetText(Award.Defaults.itemText);
    Award.ItemBoxHoldsValidItem = false;

    Award:populatePlayersTable();

    Award:updateWidgets();
end

--- Update the widgets based on the current state of the roll off
---
---@return void
function Award:updateWidgets()
    GL:debug("Award:updateWidgets");

    -- If the itembox doesn't hold a valid item link then:
    --   The start button should not be available
    --   The stop button should be available
    --   The item box should be available
    if (not Award.ItemBoxHoldsValidItem) then
        Award.UIComponents.Buttons.AwardButton:SetDisabled(true);
    else
        Award.UIComponents.Buttons.AwardButton:SetDisabled(false);
    end
end

GL:debug("Award.lua");