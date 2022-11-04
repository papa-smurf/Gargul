---@type GL
local _, GL = ...;

GL.RollOff = GL.RollOff or {}; ---@type RollOff
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

---@todo Refactor to interface
---@class MasterLooterUI
GL.MasterLooterUI = {
    ItemBoxHoldsValidItem = false,
    PlayersTable = {},
    Defaults = {
        itemIcon = "Interface\\Icons\\INV_Misc_QuestionMark",
        itemBoxText = "",
    },
};

local AceGUI = GL.AceGUI;
local MasterLooterUI = GL.MasterLooterUI; ---@type MasterLooterUI
local ScrollingTable = GL.ScrollingTable;

--- This is the UI the person who rolls off an item uses to prepare everything e.g:
--- Select an item
--- Set the duration of the roll off
--- Award the item to the winner
---
---@param itemLink string|nil
---@return void
function MasterLooterUI:draw(itemLink)
    GL:debug("MasterLooterUI:draw");

    if (GL.User.isInGroup
        and not GL.User.isMasterLooter
        and not GL.User.hasAssist
    ) then
        return GL:warning("You need to be the master looter or have an assist / lead role!");
    end

    -- Close the reopen masterlooter button if it exists
    self:closeReopenMasterLooterUIButton();

    -- First we need to check if the frame hasn't been
    -- rendered already. If so then show it (if it's hidden)
    -- and pass the itemLink along in case one was provided
    local Window = GL.Interface:getItem(self, "Window");
    if (Window) then
        if (itemLink) then
            MasterLooterUI:passItemLink(itemLink);
        end

        -- If the frame is hidden we need to show it again
        if (not Window:IsShown()) then
            Window:Show();
        end

        return;
    end

    local HorizonalSpacer, VerticalSpacer;

    -- Create a container/parent frame
    Window = AceGUI:Create("Frame", "GARGUL_MASTERLOOTERUI_WINDOW");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(430);
    Window:SetHeight(350);
    Window:EnableResize(false);
    Window.frame:SetFrameStrata("HIGH");
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function(widget)
        self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);
    GL.Interface:restorePosition(Window, "MasterLooterUI");

    --[[
        SETTINGS BUTTON
    ]]
    local SettingsButton = GL.UI:createSettingsButton(
        Window.frame,
        "MasterLooting"
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
                ItemIcon:SetImage(MasterLooterUI.Defaults.itemIcon);
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
                ItemBox:SetCallback("OnTextChanged", function () MasterLooterUI:ItemBoxChanged() end); -- Update item info when input value changes
                ItemBox:SetCallback("OnEnterPressed", function () MasterLooterUI:ItemBoxChanged() end); -- Update item info when item is dragged on top (makes no sense to use OnEnterPressed I know)

                GL.Interface:setItem(self, "Item", ItemBox);

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
                    if (GL.RollOff:announceStart(
                        GL.Interface:getItem(self, "EditBox.Item"):GetText(),
                        GL.Interface:getItem(self, "EditBox.Duration"):GetText(),
                        GL.Interface:getItem(self, "EditBox.ItemNote"):GetText()
                    )) then
                        GL.RollOff.inProgress = true;

                        if (GL.Settings:get("UI.RollOff.closeOnStart")) then
                            self:close();
                        end
                    end;

                    MasterLooterUI:updateWidgets();
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
                    GL.RollOff:announceStop();
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

                VerticalSpacer = AceGUI:Create("SimpleGroup");
                VerticalSpacer:SetLayout("Flow");
                VerticalSpacer:SetWidth(8);
                VerticalSpacer:SetHeight(20);
                SecondRow:AddChild(VerticalSpacer);

                --[[
                    ITEM NOTE LABEL
                ]]

                local ItemNoteLabel = AceGUI:Create("Label");
                ItemNoteLabel:SetText("NOTE");
                ItemNoteLabel:SetHeight(20);
                ItemNoteLabel:SetWidth(35);
                SecondRow:AddChild(ItemNoteLabel);

                --[[
                    ITEM NOTE
                ]]

                local ItemNote = AceGUI:Create("EditBox");
                ItemNote:DisableButton(true);
                ItemNote:SetHeight(20);
                ItemNote:SetWidth(340);
                SecondRow:AddChild(ItemNote);
                GL.Interface:setItem(self, "ItemNote", ItemNote);

        --[[
            THID ROW (ROLL TIMER)
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
                    TIMER LABEL
                ]]

                local TimerLabel = AceGUI:Create("Label");
                TimerLabel:SetText("TIMER (s)");
                TimerLabel:SetHeight(20);
                TimerLabel:SetWidth(55);
                ThirdRow:AddChild(TimerLabel);

                --[[
                    TIMER TEXTBOX
                ]]

                local Duration = AceGUI:Create("EditBox");
                Duration:DisableButton(true);
                Duration:SetHeight(20);
                Duration:SetWidth(40);
                Duration:SetText(GL.Settings:get("UI.RollOff.timer", 15));
                ThirdRow:AddChild(Duration);
                GL.Interface:setItem(self, "Duration", Duration);

                --[[
                    SPACER
                ]]

                VerticalSpacer = AceGUI:Create("SimpleGroup");
                VerticalSpacer:SetLayout("Flow");
                VerticalSpacer:SetWidth(20);
                VerticalSpacer:SetHeight(30);
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
                    MasterLooterUI:reset();
                    GL.RollOff:reset();
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
                        return GL:warning("You need to select a player first");
                    end

                    local RollType = (function()
                        for _, RollType in pairs(GL.Settings:get("RollTracking.Brackets", {})) do
                            if (RollType[1] == selected.cols[4].value) then
                                return RollType;
                            end
                        end

                        return {};
                    end)();
                    local osRoll = GL:toboolean(RollType[5]);
                    local plusOneRoll = GL:toboolean(RollType[6]);
                    local boostedRoll = selected.cols[4].value == GL.Settings:get("BoostedRolls.identifier", "BR");
                    return GL.RollOff:award(selected.cols[1].value, GL.Interface:getItem(self, "EditBox.Item"):GetText(), osRoll, boostedRoll, plusOneRoll);
                end);
                ThirdRow:AddChild(AwardButton);
                GL.Interface:setItem(self, "Award", AwardButton);

                HorizonalSpacer = AceGUI:Create("SimpleGroup");
                HorizonalSpacer:SetLayout("Flow");
                HorizonalSpacer:SetWidth(24);
                HorizonalSpacer:SetHeight(20);
                ThirdRow:AddChild(HorizonalSpacer);

                --[[
                    AWARD HISTORY BUTTON
                ]]

                local AwardHistoryButton = GL.UI:createFrame("Button", "MasterLooterUIAwardHistoryButton" .. GL:uuid(), Window.frame, "UIPanelButtonTemplate");
                AwardHistoryButton:SetSize(22, 20);
                AwardHistoryButton:SetPoint("TOPLEFT", AwardButton.frame, "TOPRIGHT", 1, 0);
                AwardHistoryButton:SetMotionScriptsWhileDisabled(true); -- Make sure tooltip still shows even when button is disabled

                local AwardHistoryButtonHighlight = AwardHistoryButton:CreateTexture();
                AwardHistoryButtonHighlight:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\award");
                AwardHistoryButtonHighlight:SetPoint("CENTER", AwardHistoryButton, "CENTER", 0, 0);
                AwardHistoryButtonHighlight:SetSize(22, 20);

                AwardHistoryButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\award");
                AwardHistoryButton:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\award-disabled");
                AwardHistoryButton:SetHighlightTexture(AwardHistoryButtonHighlight);

                AwardHistoryButton:SetScript("OnEnter", function()
                    GameTooltip:SetOwner(AwardHistoryButton, "ANCHOR_TOP");
                    GameTooltip:SetText("Award history");
                    GameTooltip:Show();
                end);

                AwardHistoryButton:SetScript("OnLeave", function()
                    GameTooltip:Hide();
                end);

                AwardHistoryButton:SetScript("OnClick", function()
                    GL.Interface.AwardHistory:toggle();
                end);

                --[[
                    DISENCHANT BUTTON
                ]]
                local DisenchantButton = AceGUI:Create("Button");
                DisenchantButton:SetText("Disenchant");
                DisenchantButton:SetWidth(100);
                DisenchantButton:SetHeight(20);
                DisenchantButton:SetDisabled(true);
                DisenchantButton:SetCallback("OnClick", function()
                    local itemLink = GL.Interface:getItem(self, "EditBox.Item"):GetText();

                    GL.PackMule:disenchant(itemLink, true);
                    self:close();
                end);
                ThirdRow:AddChild(DisenchantButton);
                GL.Interface:setItem(self, "Disenchant", DisenchantButton);
        --[[
            FOURTH ROW (GROUP MEMBERS)
        ]]

        local FourthRow = AceGUI:Create("SimpleGroup");
        FourthRow:SetLayout("Flow");
        FourthRow:SetFullWidth(true);
        FourthRow:SetHeight(50);
        Window:AddChild(FourthRow);

        MasterLooterUI:drawPlayersTable(Window.frame);

        --[[
            FIFTH ROW (AUTO CLOSE CHECKBOX)
        ]]

        local FifthRow = AceGUI:Create("SimpleGroup");
        FifthRow:SetLayout("Flow");
        FifthRow:SetFullWidth(true);
        FifthRow:SetHeight(20);
        Window:AddChild(FifthRow);

        --[[
            TABLE SETTINGS BUTTON
        ]]
        local RollTrackingSettingsButton = GL.UI:createSettingsButton(
            FifthRow.frame,
            "RollTracking",
            nil,
            nil,
            true
        );
        RollTrackingSettingsButton:SetPoint("TOPRIGHT", FifthRow.frame, "TOPRIGHT", -10, -8);
        self.RollTrackingSettingsButton = RollTrackingSettingsButton;

        local PlayersTableFrame = AceGUI:Create("SimpleGroup");
        PlayersTableFrame:SetLayout("fixed");
        PlayersTableFrame:SetFullWidth(true);
        PlayersTableFrame:SetHeight(158);
        FifthRow:AddChild(PlayersTableFrame);

        local CloseOnStart = AceGUI:Create("CheckBox");
        CloseOnStart:SetLabel("Close on start");
        CloseOnStart:SetValue(GL.Settings:get("UI.RollOff.closeOnStart", true));
        CloseOnStart:SetCallback("OnValueChanged", function (widget)
            GL.Settings:set("UI.RollOff.closeOnStart", GL:toboolean(widget:GetValue()));
        end);
        CloseOnStart:SetWidth(150);
        FifthRow:AddChild(CloseOnStart);

        local CloseOnAward = AceGUI:Create("CheckBox");
        CloseOnAward:SetLabel("Close on award");
        CloseOnAward:SetValue(GL.Settings:get("UI.RollOff.closeOnAward", true));
        CloseOnAward:SetCallback("OnValueChanged", function (widget)
            GL.Settings:set("UI.RollOff.closeOnAward", GL:toboolean(widget:GetValue()));
        end);
        CloseOnAward:SetWidth(150);
        FifthRow:AddChild(CloseOnAward);

    if (itemLink
        and type(itemLink) == "string"
    ) then
        MasterLooterUI:passItemLink(itemLink);
    end
end

---@return void
function MasterLooterUI:close()
    GL:debug("MasterLooterUI:close");

    -- When the master looter closes the master loot window with a master
    -- loot still in progress we show the reopen master looter button
    if (GL.RollOff.inProgress) then
        self:drawReopenMasterLooterUIButton();
    end

    local Window = GL.Interface:getItem(self, "Window");
    if (Window) then
        -- Store the frame's last position for future play sessions
        GL.Interface:storePosition(Window, "MasterLooterUI");
        Window:Hide();
    end
end

-- Close the reopen masterlooter button
function MasterLooterUI:closeReopenMasterLooterUIButton()
    -- Close the reopen masterlooter button if it exists
    local OpenMasterLooterButton = GL.Interface:getItem(self, "Frame.OpenMasterLooterButton");

    if (OpenMasterLooterButton) then
        OpenMasterLooterButton:Hide();
    end
end

-- This button allows the master looter to easily reopen the
-- master looter window when it's closed with a roll in progress
-- This is very common in hectic situations where the master looter has to participate in combat f.e.
function MasterLooterUI:drawReopenMasterLooterUIButton()
    GL:debug("MasterLooterUI:drawReopenMasterLooterUIButton");

    -- Only draw the button if the master looter window is closed
    local Window = GL.Interface:getItem(self, "Window");
    if (Window and Window:IsShown()) then
        return;
    end

    local Button = GL.Interface:getItem(self, "Frame.OpenMasterLooterButton");

    if (Button) then
        Button:SetNormalTexture(GL.RollOff.CurrentRollOff.itemIcon or "Interface\\Icons\\INV_Misc_QuestionMark");
        Button:Show();
        return;
    end

    local texture = GL.RollOff.CurrentRollOff.itemIcon or "Interface\\Icons\\INV_Misc_QuestionMark";
    Button = CreateFrame("Button", "ReopenMasterLooterButton", UIParent, Frame);
    Button:SetSize(44, 44);
    Button:SetNormalTexture(texture);
    Button:SetText("text");
    Button:SetPoint(GL.Interface:getPosition("ReopenMasterLooterUIButton"));

    Button:SetMovable(true);
    Button:EnableMouse(true);
    Button:SetClampedToScreen(true);
    Button:SetFrameStrata("HIGH");
    Button:RegisterForDrag("LeftButton");
    Button:SetScript("OnDragStart", Button.StartMoving);
    Button:SetScript("OnDragStop", function()
        Button:StopMovingOrSizing();

        -- Store the frame's last position for future play sessions
        GL.Interface:storePosition(Button, "ReopenMasterLooterUIButton");
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
        GameTooltip:SetText("Open master looter window");
        GameTooltip:Show();
    end);

    Button:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    GL.Interface:setItem(self, "OpenMasterLooterButton", Button);
end

function MasterLooterUI:drawPlayersTable(parent)
    GL:debug("MasterLooterUI:drawPlayersTable");

    -- Combined width of all colums should be 340
    local columns = {
        --[[ Player name ]]
        {
            name = "Player",
            width = 120,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        },
        --[[ Roll ]]
        {
            name = "Roll",
            width = 35,
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
        --[[ +1 ]]
        {
            name = "+1",
            width = 35,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        },
        --[[ ROLL TYPE: MS/OS etc ]]
        {
            name = "Type",
            width = 63,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        },
        --[[ Reserved / TMB etc ]]
        {
            name = "Note",
            width = 88,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
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

    local Table = ScrollingTable:CreateST(columns, 8, 15, nil, parent);
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

            for _, Entry in pairs(ItemsWonByRollerInTheLast8Hours) do
                local receivedString = " (received)";
                if (not Entry.received) then
                    receivedString = " (not received yet)";
                end

                local OSString = "";
                if (Entry.OS) then
                    OSString = " (OS)"
                end

                local BRString = "";
                if (GL:higherThanZero(Entry.BRCost)) then
                    BRString = string.format(" (BR: %s)", Entry.BRCost);
                end

                local line = string.format("%s%s%s%s",
                    Entry.itemLink,
                    OSString,
                    BRString,
                    receivedString
                );

                GameTooltip:AddLine(line);
            end

            GameTooltip:Show();
        end,
        OnLeave = function ()
            GameTooltip:Hide();
        end,
    });

    Table.frame:SetPoint("BOTTOM", parent, "BOTTOM", 0, 50);
    GL.Interface:setItem(self, "Players", Table);
end

-- The item box contents changed
function MasterLooterUI:ItemBoxChanged()
    GL:debug("MasterLooterUI:ItemBoxChanged");

    local itemLink = GL.Interface:getItem(self, "EditBox.Item"):GetText();

    MasterLooterUI:passItemLink(itemLink);
end

-- Pass an item link to the master looter UI
-- This method is used when alt clicking an item
-- in a loot window or when executing /gl roll [itemlink]
function MasterLooterUI:passItemLink(itemLink)
    GL:debug("MasterLooterUI:passItemLink");

    if (not GL.Interface:getItem(self, "Window")) then
        return;
    end

    if (GL.RollOff.inProgress) then
        return GL:warning("A roll is currently in progress");
    end

    GL.Interface:getItem(self, "EditBox.Item"):SetText(itemLink);
    return MasterLooterUI:update();
end

-- Update the master looter UI based on the value of the ItemBox input
function MasterLooterUI:update()
    GL:debug("MasterLooterUI:update");

    local IconWidget = GL.Interface:getItem(self, "Icon.Item");
    local itemLink = GL.Interface:getItem(self, "EditBox.Item"):GetText();

    -- If the item link is not valid then
    --   Show the default question mark icon
    --   Remove the item priority string
    if (not itemLink or itemLink == "") then
        GL:debug("MasterLooterUI:update. Item link is invalid");

        MasterLooterUI.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage(MasterLooterUI.Defaults.itemIcon);

        MasterLooterUI:updateItemNote();
        MasterLooterUI:updateWidgets();
        return;
    end

    -- The item's icon is in the 10th position
    local icon = select(10, GetItemInfo(itemLink));

    if (icon) then
        GL.Interface:getItem(self, "Table.Players"):ClearSelection();

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
    GL:debug("MasterLooterUI:updateItemNote");

    local defaultNote = GL.Settings:get("MasterLooting.defaultRollOffNote", "/roll 100 for MS or /roll 99 for OS");
    local ItemNote = GL.Interface:getItem(self, "EditBox.ItemNote");
    local itemLink = GL.Interface:getItem(self, "EditBox.Item"):GetText();

    -- We don't have a valid itemlink at hand, clear the note
    if (not MasterLooterUI.ItemBoxHoldsValidItem) then
        return ItemNote:SetText(defaultNote);
    end

    local itemPriority = GL.LootPriority:getPriority(itemLink);

    -- If there is no item priority then keep the item label as-is
    if (not itemPriority
        or GL.Settings:get("MasterLooting.alwaysUseDefaultNote", false)
    ) then
        return ItemNote:SetText(defaultNote);
    end

    -- There is a priority for this item
    itemPriority = table.concat(itemPriority, " > ");
    ItemNote:SetText(itemPriority);
end

-- Reset the roll off UI to its defaults
function MasterLooterUI:reset(keepItem)
    GL:debug("MasterLooterUI:reset");

    keepItem = GL:toboolean(keepItem);

    if (not keepItem) then
        GL.Interface:getItem(self, "Icon.Item"):SetImage(MasterLooterUI.Defaults.itemIcon);
        GL.Interface:getItem(self, "EditBox.Item"):SetText(MasterLooterUI.Defaults.itemText);
        GL.Interface:getItem(self, "EditBox.Duration"):SetText(GL.Settings:get("UI.RollOff.timer"));
        GL.Interface:getItem(self, "EditBox.ItemNote"):SetText("");
        MasterLooterUI.ItemBoxHoldsValidItem = false;
    end

    GL.Interface:getItem(self, "Table.Players"):ClearSelection();
    GL.Interface:getItem(self, "Table.Players"):ClearSelection();
    GL.Interface:getItem(self, "Table.Players"):SetData({}, true);

    MasterLooterUI:updateWidgets();
end

-- Update the widgets based on the current state of the roll off
function MasterLooterUI:updateWidgets()
    GL:debug("MasterLooterUI:updateWidgets");

    -- If the itembox doesn't hold a valid item link then:
    --   The start button should not be available
    --   The stop button should be available
    --   The item box should be available
    if (not MasterLooterUI.ItemBoxHoldsValidItem) then
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
    if (not GL.RollOff.inProgress) then
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

GL:debug("MasterLooterUI.lua");