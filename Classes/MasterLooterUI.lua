local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

---@type Dialog
local Dialog = GL.Dialog;

local AceGUI = GL.AceGUI;
local ScrollingTable = GL.ScrollingTable;

---@class MasterLooterUI
local MasterLooterUI = {
    ItemBoxHoldsValidItem = false,
    PlayersTable = {},
    Defaults = {
        itemIcon = "Interface/Icons/INV_Misc_QuestionMark",
        itemBoxText = "",
    },
    awardedCurrentItem = true,
};

---@type MasterLooterUI
GL.MasterLooterUI = MasterLooterUI;

local AwardReminderDialog = Dialog.new("NEW_ROLL_WITHOUT_AWARDING_PREVIOUS")
    :setMessage(L["Are you sure you want to start a new roll?\n\nYou still need to award ${item} by selecting a roll and clicking the 'Award' button."])
    :setPaddingBottom(2)
    :setButtons({
        {
            label = L["New roll"],
            onClick = function (self, Data)
                GL.Settings:set("UI.RollOff.warnWhenNotAwarded", self.AppendedFrame:GetChecked());
                Data.onAccept();
            end
        },
        {
            label = L["Cancel"],
            onClick = function (self)
                GL.Settings:set("UI.RollOff.warnWhenNotAwarded", self.AppendedFrame:GetChecked());
            end
        },
    })
    :appendFrame(
        (function()
            local checkBoxName = "GARGUL_NEW_ROLL_WITHOUT_AWARDING_PREVIOUS_DIALOG_CHECKBOX";
            local Checkbox = _G[checkBoxName] or CreateFrame("CheckButton", "GARGUL_NEW_ROLL_WITHOUT_AWARDING_PREVIOUS_DIALOG_CHECKBOX", nil, "UICheckButtonTemplate");
            Checkbox:SetChecked(true);
            _G[checkBoxName .. "Text"]:SetText(L["Remind me to award"]);

            return Checkbox;
        end)()
    )
    :setOnShow(function(Dialog, DialogFrame)
        GL.Interface:get(MasterLooterUI, "Button.Start"):SetDisabled(true);
        Dialog.AppendedFrame:SetPoint("LEFT", _G[DialogFrame:GetName() .. "Button1"], "LEFT", 0, 0); -- Align with leftmost button
    end)
    :setOnHide(function()
        GL.Interface:get(MasterLooterUI, "Button.Start"):SetDisabled(false);
    end)

--- This is the UI the person who rolls off an item uses to prepare everything e.g:
--- Select an item
--- Set the duration of the roll off
--- Award the item to the winner
---
---@param itemLink string|nil
function MasterLooterUI:draw(itemLink)
    if (GL.User.isInGroup
        and not GL.User.isMasterLooter
        and not GL.User.hasAssist
    ) then
        return GL:warning(L["You need to be the master looter or have an assist / lead role!"]);
    end

    -- Close the reopen masterlooter button if it exists
    self:closeReopenMasterLooterUIButton();

    -- First we need to check if the frame hasn't been
    -- rendered already. If so then show it (if it's hidden)
    -- and pass the itemLink along in case one was provided
    local Window = GL.Interface:get(self, "Window");
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

    -- Make sure the table sorting details get updated
    -- when the user changes their settings
    GL.Events:register("MasterLooterUISortByPlusOneChanged", "GL.SETTING_CHANGED.RollTracking.sortByPlusOne", function ()
        local PlayersTable = GL.Interface:get(self, "Table.Players");

        if (not PlayersTable) then
            return;
        end

        PlayersTable:SetDisplayCols(self:tableColumns());
        PlayersTable:SortData();
    end);

    local HorizonalSpacer, VerticalSpacer;

    -- Create a container/parent frame
    Window = AceGUI:Create("Frame", "GARGUL_MASTERLOOTERUI_WINDOW");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetLayout("Flow");
    Window:SetWidth(460);
    Window:SetHeight(350);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:set(self, "Window", Window);
    GL.Interface:restorePosition(Window, "MasterLooterUI");

    --[[
        SETTINGS BUTTON
    ]]
    local SettingsButton = GL.UI:createSettingsButton(
        Window.frame,
        "MasterLooting"
    );
    SettingsButton:SetScript("OnClick", function(_, button)
        if (button == 'LeftButton') then
            self:close();

            GL.Settings:draw("MasterLooting", function ()
                self:draw();
            end);
        end
    end);
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
            GL.Interface:set(self, "Item", ItemIcon);

            --[[
                ITEM TEXTBOX
            ]]
            local ItemBox = AceGUI:Create("EditBox");

            ItemBox:DisableButton(true);
            ItemBox:SetHeight(20);
            ItemBox:SetWidth(170);
            ItemBox:SetCallback("OnTextChanged", function () MasterLooterUI:ItemBoxChanged() end); -- Update item info when input value changes
            ItemBox:SetCallback("OnEnterPressed", function () MasterLooterUI:ItemBoxChanged() end); -- Update item info when item is dragged on top (makes no sense to use OnEnterPressed I know)

            GL.Interface:set(self, "Item", ItemBox);

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

            ItemIcon:SetCallback("OnClick", function (_, _, mouseButtonPressed)
                if (not MasterLooterUI.ItemBoxHoldsValidItem) then
                    return;
                end

                local itemLink = ItemBox:GetText();
                HandleModifiedItemClick(itemLink, mouseButtonPressed);
            end);

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
            StartButton:SetText(L["Start"]);
            StartButton:SetWidth(60); ---@TODO: TOO SHORT FOR FR
            StartButton:SetHeight(20);
            StartButton:SetDisabled(true);
            StartButton:SetCallback("OnClick", function()
                if (GL.RollOff:announceStart(
                    GL.Interface:get(self, "EditBox.Item"):GetText(),
                    GL.Interface:get(self, "EditBox.Duration"):GetText(),
                    GL.Interface:get(self, "EditBox.ItemNote"):GetText()
                )) then
                    GL.RollOff.inProgress = true;

                    if (GL.Settings:get("UI.RollOff.closeOnStart")) then
                        self:close();
                    end
                end;

                MasterLooterUI:updateWidgets();
            end);
            FirstRow:AddChild(StartButton);
            GL.Interface:set(self, "Start", StartButton);

            --[[
                STOP BUTTON
            ]]

            local StopButton = AceGUI:Create("Button");
            StopButton:SetText(L["Stop"]);
            StopButton:SetWidth(60);
            StopButton:SetHeight(20);
            StopButton:SetDisabled(true);
            StopButton:SetCallback("OnClick", function()
                GL.RollOff:announceStop();
            end);
            FirstRow:AddChild(StopButton);
            GL.Interface:set(self, "Stop", StopButton);

            local ButtonPadder = AceGUI:Create("SimpleGroup");
            ButtonPadder:SetLayout("Flow");
            ButtonPadder:SetWidth(8);
            ButtonPadder:SetHeight(30);
            FirstRow:AddChild(ButtonPadder);


            --[[
                +1 BUTTON
            ]]

            local PlusOneButton = AceGUI:Create("Button");
            PlusOneButton:SetText(L["+1"]);
            PlusOneButton:SetWidth(48);
            PlusOneButton:SetHeight(20);
            PlusOneButton:SetCallback("OnClick", function()
                GL.Commands:call("+1");
            end);
            FirstRow:AddChild(PlusOneButton);

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
            ItemNoteLabel:SetText(L["NOTE"]);
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
            GL.Interface:set(self, "ItemNote", ItemNote);

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
            TimerLabel:SetText(L["TIMER (s)"]);
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
            GL.Interface:set(self, "Duration", Duration);

            --[[
                SPACER
            ]]

            VerticalSpacer = AceGUI:Create("SimpleGroup");
            VerticalSpacer:SetLayout("Flow");
            VerticalSpacer:SetWidth(10);
            VerticalSpacer:SetHeight(30);
            ThirdRow:AddChild(VerticalSpacer);

            --[[
                RESET BUTTON
            ]]
            local ClearButton = AceGUI:Create("Button");
            ClearButton:SetText(L["Clear"]);
            ClearButton:SetWidth(80);
            ClearButton:SetHeight(20);
            ClearButton:SetDisabled(false);
            ClearButton:SetCallback("OnClick", function()
                MasterLooterUI:reset();
                GL.RollOff:reset();
                GL.RollOff.CurrentRollOff.Rolls = {};
            end);
            ThirdRow:AddChild(ClearButton);
            GL.Interface:set(self, "Clear", ClearButton);

            --[[
                AWARD BUTTON
            ]]

            local AwardButton = AceGUI:Create("Button");
            AwardButton:SetText(L["Award"]);
            AwardButton:SetWidth(90); ---@TODO: TOO SHORT FOR FR
            AwardButton:SetHeight(20);
            AwardButton:SetDisabled(true);
            AwardButton:SetCallback("OnClick", function()
                local PlayersTable = GL.Interface:get(self, "Table.Players");
                local selected = PlayersTable:GetRow(PlayersTable:GetSelection());

                if (not selected
                    or not type(selected) == "table"
                ) then
                    return GL:warning(L["You need to select a player first"]);
                end

                local selectedPlayer = GL:tableGet(selected, "cols.1.value");
                local selectedRollAmount = GL:tableGet(selected, "cols.2.value");
                local selectedRollType = GL:tableGet(selected, "cols.4.value");

                if (not selectedPlayer
                    or not selectedRollAmount
                    or not selectedRollType
                ) then
                    return GL:warning(L["You need to select a player first"]);
                end

                -- If the roller has a roll number suffixed to his name
                -- e.g. "playerName [2]" then make sure to remove that number
                local openingBracketPosition = string.find(selectedPlayer, " %[");
                if (openingBracketPosition) then
                    selectedPlayer = string.sub(selectedPlayer, 1, openingBracketPosition - 1);
                end

                local RollBracket = (function()
                    -- Boosted rolls don't have a defined bracket (roll ranges are dynamic!)
                    if (selected.cols[4].value == GL.Settings:get("BoostedRolls.identifier", "BR")) then
                        return {
                            [1] = selected.cols[4].value,
                            [2] = false,
                            [3] = false,
                            [4] = false,
                            [5] = false,
                        };
                    end

                    for _, Bracket in pairs(GL.Settings:get("RollTracking.Brackets", {})) do
                        if (Bracket[1] == selected.cols[4].value) then
                            return Bracket;
                        end
                    end

                    return {};
                end)();

                local identicalRollDetected = false;
                for _, Roll in pairs(GL.RollOff.CurrentRollOff.Rolls or {}) do
                    if (Roll
                        and Roll.player
                        and not GL:iEquals(GL:stripRealm(Roll.player), selectedPlayer)
                        and Roll.amount == selectedRollAmount
                        and Roll.classification == selectedRollType
                    ) then
                        identicalRollDetected = true;
                    end
                end

                self.awardedCurrentItem = true;
                GL.RollOff:award(selectedPlayer, GL.Interface:get(self, "EditBox.Item"):GetText(), RollBracket, identicalRollDetected);
            end);
            GL.Interface:addTooltip(AwardButton, function ()
                if (GL.Settings:get("AwardingLoot.skipAwardConfirmationDialog")) then
                    return L["Hold shift to show the award confirmation"];
                end

                return L["Hold shift to bypass the award confirmation"];
            end);
            ThirdRow:AddChild(AwardButton);
            GL.Interface:set(self, "Award", AwardButton);

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
            AwardHistoryButtonHighlight:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/award");
            AwardHistoryButtonHighlight:SetPoint("CENTER", AwardHistoryButton, "CENTER", 0, 0);
            AwardHistoryButtonHighlight:SetSize(22, 20);

            AwardHistoryButton:SetNormalTexture("Interface/AddOns/Gargul/Assets/Buttons/award");
            AwardHistoryButton:SetDisabledTexture("Interface/AddOns/Gargul/Assets/Buttons/award-disabled");
            AwardHistoryButton:SetHighlightTexture(AwardHistoryButtonHighlight);

            AwardHistoryButton:SetScript("OnEnter", function()
                GameTooltip:SetOwner(AwardHistoryButton, "ANCHOR_TOP");
                GameTooltip:SetText(L["Award history"]);
                GameTooltip:Show();
            end);

            AwardHistoryButton:SetScript("OnLeave", function()
                GameTooltip:Hide();
            end);

            AwardHistoryButton:SetScript("OnClick", function()
                GL.Interface.Award.Overview:open();
            end);

            --[[
                DISENCHANT BUTTON
            ]]
            local DisenchantButton = AceGUI:Create("Button");
            DisenchantButton:SetText(L["Disenchant"]);
            DisenchantButton:SetWidth(100);
            DisenchantButton:SetHeight(20);
            DisenchantButton:SetDisabled(true);
            DisenchantButton:SetCallback("OnClick", function()
                local itemLink = GL.Interface:get(self, "EditBox.Item"):GetText();

                GL.PackMule:disenchant(itemLink, true);
                self:close();
            end);
            ThirdRow:AddChild(DisenchantButton);
            GL.Interface:set(self, "Disenchant", DisenchantButton);
            
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
        CloseOnStart:SetLabel(L["Close on start"]);
        CloseOnStart:SetValue(GL.Settings:get("UI.RollOff.closeOnStart", true));
        CloseOnStart:SetCallback("OnValueChanged", function (widget)
            GL.Settings:set("UI.RollOff.closeOnStart", GL:toboolean(widget:GetValue()));
        end);
        CloseOnStart:SetWidth(150);
        FifthRow:AddChild(CloseOnStart);

        local CloseOnAward = AceGUI:Create("CheckBox");
        CloseOnAward:SetLabel(L["Close on award"]);
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

function MasterLooterUI:close()
    -- When the master looter closes the master loot window with a master
    -- loot still in progress we show the reopen master looter button
    if (GL.RollOff.inProgress) then
        self:drawReopenMasterLooterUIButton();
    end

    local Window = GL.Interface:get(self, "Window");
    if (Window) then
        -- Store the frame's last position for future play sessions
        GL.Interface:storePosition(Window, "MasterLooterUI");
        Window:Hide();
    end
end

-- Close the reopen masterlooter button
function MasterLooterUI:closeReopenMasterLooterUIButton()
    -- Close the reopen masterlooter button if it exists
    local OpenMasterLooterButton = GL.Interface:get(self, "Frame.OpenMasterLooterButton");

    if (OpenMasterLooterButton) then
        OpenMasterLooterButton:Hide();
    end
end

-- This button allows the master looter to easily reopen the
-- master looter window when it's closed with a roll in progress
-- This is very common in hectic situations where the master looter has to participate in combat f.e.
function MasterLooterUI:drawReopenMasterLooterUIButton()
    -- Only draw the button if the master looter window is closed
    local Window = GL.Interface:get(self, "Window");
    if (Window and Window:IsShown()) then
        return;
    end

    local Button = GL.Interface:get(self, "Frame.OpenMasterLooterButton");

    if (Button) then
        Button:SetNormalTexture(GL.RollOff.CurrentRollOff.itemIcon or "Interface/Icons/INV_Misc_QuestionMark");
        Button:Show();
        return;
    end

    local texture = GL.RollOff.CurrentRollOff.itemIcon or "Interface/Icons/INV_Misc_QuestionMark";
    Button = CreateFrame("Button", "ReopenMasterLooterButton", UIParent, Frame);
    Button:SetSize(44, 44);
    Button:SetNormalTexture(texture);
    Button:SetText(" ");
    Button:SetPoint(GL.Interface:getPosition("ReopenMasterLooterUIButton"));

    Button:SetMovable(true);
    Button:EnableMouse(true);
    Button:SetClampedToScreen(true);
    Button:SetFrameStrata("FULLSCREEN_DIALOG");
    Button:RegisterForDrag("LeftButton");
    Button:SetScript("OnDragStart", Button.StartMoving);
    Button:SetScript("OnDragStop", function()
        Button:StopMovingOrSizing();

        -- Store the frame's last position for future play sessions
        GL.Interface:storePosition(Button, "ReopenMasterLooterUIButton");
    end);

    local ButtonBackground = Button:CreateTexture(nil, "BACKGROUND");
    ButtonBackground:SetAllPoints(Button);
    ButtonBackground:SetTexture("Interface/Icons/INV_Misc_QuestionMark");
    ButtonBackground:SetTexCoord(0, 1, 0.23, 0.77);
    ButtonBackground:SetBlendMode("ADD");
    Button.ButtonBackground = ButtonBackground;

    local ButtonHighlight = Button:CreateTexture(nil, "HIGHLIGHT");
    ButtonHighlight:SetAllPoints(Button);
    ButtonHighlight:SetTexture("Interface/PaperDollInfoFrame/UI-Character-Tab-Highlight");
    ButtonHighlight:SetTexCoord(0, 1, 0.23, 0.77);
    ButtonHighlight:SetBlendMode("ADD");
    Button.ButtonHighlight = ButtonHighlight;

    local RollCountLabel = CreateFrame("Frame","ReopenMasterLooterRollCount", Button);
    RollCountLabel:SetSize(22, 22);
    RollCountLabel:SetPoint("BOTTOMLEFT", Button, "BOTTOMLEFT", 2, 2);

    local RollCountText = RollCountLabel:CreateFontString(nil, "OVERLAY", "GameFontNormal");
    RollCountText:SetFont(STANDARD_TEXT_FONT, 10, "OUTLINE");
    RollCountText:SetPoint("BOTTOMLEFT", RollCountLabel, "BOTTOMLEFT");

    Button:SetScript("OnMouseUp", function (_, button)
        if (button == "LeftButton") then
            self:draw();
        end
    end);

    Button:SetScript("OnEnter", function()
        GameTooltip:SetOwner(Button, "ANCHOR_TOP");
        GameTooltip:SetText(L["Open master looter window"]);
        GameTooltip:Show();
    end);

    Button:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    --[[
        PAUSE / PLAY BUTTON
    ]]

    local PlayStopButton = GL.UI:createFrame("Button", "ReopenMasterLooterPlayStopButton" .. GL:uuid(), Button, "UIPanelButtonTemplate");
    PlayStopButton:SetSize(20, 20);
    PlayStopButton:SetPoint("TOPLEFT", Button, "TOPRIGHT", 2, -1);

    local PlayStopButtonHighlight = PlayStopButton:CreateTexture();
    PlayStopButtonHighlight:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/play");
    PlayStopButtonHighlight:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/stop");
    PlayStopButtonHighlight:SetPoint("CENTER", PlayStopButton, "CENTER", 0, 0);
    PlayStopButtonHighlight:SetSize(20, 20);

    PlayStopButton:SetNormalTexture("Interface/AddOns/Gargul/Assets/Buttons/play");
    PlayStopButton:SetNormalTexture("Interface/AddOns/Gargul/Assets/Buttons/stop");
    PlayStopButton:SetHighlightTexture(PlayStopButtonHighlight);

    GL.Interface:addTooltip(PlayStopButton, ("%s / %s"):format(L["Start"], L["Stop"]), "TOP");

    PlayStopButton:SetScript("OnClick", function()
        local StartButton = GL.Interface:get(self, "Button.Start");
        local StopButton = GL.Interface:get(self, "Button.Stop");

        if (GL.RollOff.inProgress) then
            StopButton.frame:Click();
        else
            StartButton.frame:Click();
        end
    end);

    --[[
        DISENCHANT BUTTON
    ]]

    local DisenchantButton = GL.UI:createFrame("Button", "ReopenMasterLooterDisenchantButton" .. GL:uuid(), Button, "UIPanelButtonTemplate");
    DisenchantButton:SetSize(20, 20);
    DisenchantButton:SetPoint("TOPLEFT", PlayStopButton, "BOTTOMLEFT", 0, -2);
    DisenchantButton:SetMotionScriptsWhileDisabled(true); -- Make sure tooltip still shows even when button is disabled

    local DisenchantButtonHighlight = DisenchantButton:CreateTexture();
    DisenchantButtonHighlight:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/disenchant");
    DisenchantButtonHighlight:SetPoint("CENTER", DisenchantButton, "CENTER", 0, 0);
    DisenchantButtonHighlight:SetSize(20, 20);

    DisenchantButton:SetNormalTexture("Interface/AddOns/Gargul/Assets/Buttons/disenchant");
    DisenchantButton:SetDisabledTexture("Interface/AddOns/Gargul/Assets/Buttons/disenchant-disabled");
    DisenchantButton:SetHighlightTexture(DisenchantButtonHighlight);

    DisenchantButton:SetScript("OnEnter", function()
        GameTooltip:SetOwner(DisenchantButton, "ANCHOR_TOP");
        GameTooltip:SetText(L["Disenchant"]);
        GameTooltip:Show();
    end);

    DisenchantButton:SetScript("OnLeave", function()
        GameTooltip:Hide();
    end);

    DisenchantButton:SetScript("OnClick", function()
        local MLUIDisenchantButton = GL.Interface:get(self, "Button.Disenchant");

        if (MLUIDisenchantButton) then
            pcall(function ()
                MLUIDisenchantButton.frame:Click();
                self:closeReopenMasterLooterUIButton();
            end);
        end
    end);

    local refreshWidget = function()
        RollCountText:SetText((L["rolls: %s"]):format(#GL.RollOff.CurrentRollOff.Rolls));

        if (GL.RollOff.inProgress) then
            DisenchantButton:Disable();

            PlayStopButton:SetNormalTexture("Interface/AddOns/Gargul/Assets/Buttons/stop");
            PlayStopButtonHighlight:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/stop");
        else
            DisenchantButton:Enable();

            PlayStopButton:SetNormalTexture("Interface/AddOns/Gargul/Assets/Buttons/play");
            PlayStopButtonHighlight:SetTexture("Interface/AddOns/Gargul/Assets/Buttons/play");
        end
    end;
    refreshWidget();

    GL.Events:register({
        { "MasterLooterUIRolloffRollAcceptedListener", "GL.ROLLOFF_ROLL_ACCEPTED" },
        { "MasterLooterUIRolloffRollStartListener", "GL.ROLLOFF_STARTED" },
        { "MasterLooterUIRolloffRollStartListener", "GL.ROLLOFF_STOPPED" },
    }, refreshWidget);

    GL.Interface:set(self, "OpenMasterLooterButton", Button);
end

function MasterLooterUI:drawPlayersTable(parent)
    local Columns = self:tableColumns();

    local Table = ScrollingTable:CreateST(Columns, 8, 15, nil, parent);
    Table:SetWidth(340);
    Table:EnableSelection(true);

    Table:RegisterEvents{
        OnClick = function(rowFrame, cellFrame, data, cols, row, realrow, column, table, button, ...)
            if not (row or realrow) then return true end -- Disable sort
        end,
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

            local ItemsWonByRollerInTheLast8Hours = GL.AwardedLoot:byWinner(GL:addRealm(roller), GetServerTime() - (8 * 60 * 60)) or {};
            local wonItems = not GL:empty(ItemsWonByRollerInTheLast8Hours);
            local showPlayerGroups = GL:count(GL.DB:get("TMB.RaidGroups", {})) > 1
                and GL.Settings:get("TMB.showRaidGroup");

            if (not wonItems and not showPlayerGroups) then
                return;
            end

            GameTooltip:ClearLines();
            GameTooltip:SetOwner(rowFrame, "ANCHOR_RIGHT");

            if (showPlayerGroups) then
                local _, playerGroup = GL.TMB:groupByPlayerName(string.lower(roller));

                if (playerGroup) then
                    GameTooltip:AddLine(playerGroup);

                    if (wonItems) then
                        GameTooltip:AddLine(" ");
                    end
                end
            end

            if (wonItems) then
                GameTooltip:AddLine((L["Items won by %s:"]):format(roller));
                GameTooltip:AddLine(" ");

                for _, Entry in pairs(ItemsWonByRollerInTheLast8Hours or {}) do
                    local receivedString = " " .. L["(item given: yes)"];
                    if (not Entry.received) then
                        receivedString = " " .. L["(item given: no)"];
                    end

                    local OSString = "";
                    if (Entry.OS) then
                        OSString = " " .. L["(OS)"]
                    end

                    local BRString = "";
                    if (GL:higherThanZero(Entry.BRCost)) then
                        BRString = (" " .. L["(BR: %s)"]):format(Entry.BRCost);
                    end

                    local line = string.format("%s%s%s%s",
                        Entry.itemLink,
                        OSString,
                        BRString,
                        receivedString
                    );

                    GameTooltip:AddLine(line);
                end
            end

            GameTooltip:Show();
        end,
        OnLeave = function ()
            GameTooltip:Hide();
        end,
    };

    Table.frame:SetPoint("BOTTOM", parent, "BOTTOM", 0, 50);
    GL.Interface:set(self, "Players", Table);
end

function MasterLooterUI:tableColumns()
    local sortByPlusOne = GL.Settings:get("RollTracking.sortByPlusOne");

    if (sortByPlusOne ~= 0) then
        sortByPlusOne = sortByPlusOne == "ASC" and "ASC" or "DESC";
    end

    -- Combined width of all columns should be 340
    return {
        --[[ 1. Player name ]]
        {
            name = L["Player"],
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
        --[[ 2. Roll ]]
        {
            name = L["Roll"],
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
        --[[ 3. +1 ]]
        {
            name = L["+1"],
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
        --[[ 4. ROLL TYPE: MS/OS etc ]]
        {
            name = L["Type"],
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
        --[[ 5. Reserved / TMB etc ]]
        {
            name = L["Note"],
            width = 118,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
        },
        --[[ 6. PRIORITY (NOT VISIBLE, FOR SORTING ONLY! ]]
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
            sortnext = sortByPlusOne ~= 0 and 7 or 2,
        },
        --[[ 7. PLUSONES (NOT VISIBLE, FOR SORTING ONLY! ]]
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
            defaultsort = sortByPlusOne == "ASC" and GL.Data.Constants.ScrollingTable.ascending or GL.Data.Constants.ScrollingTable.descending,
            sortnext = 2,
        },
    };
end

-- The item box contents changed
function MasterLooterUI:ItemBoxChanged()
    local itemLink = GL.Interface:get(self, "EditBox.Item"):GetText();

    MasterLooterUI:passItemLink(itemLink);
end

-- Pass an item link to the master looter UI
-- This method is used when alt clicking an item
-- in a loot window or when executing /gl roll [itemlink]
function MasterLooterUI:passItemLink(itemLink)
    if (not GL.Interface:get(self, "Window")) then
        return;
    end

    if (GL.RollOff.inProgress) then
        return GL:warning(L["A roll is currently in progress"]);
    end

    local ItemBox = GL.Interface:get(self, "EditBox.Item");
    local currentItemLink = ItemBox:GetText();
    if (currentItemLink == itemLink) then
        return;
    end

    local setItem = function ()
        self.awardedCurrentItem = false;

        GL.Interface:get(self, "EditBox.Item"):SetText(itemLink);
        return MasterLooterUI:update();
    end

    -- Show a warning when a player forgets to award an item
    if (not GL:empty(GL.RollOff.CurrentRollOff.Rolls)
        and not self.awardedCurrentItem
        and GL.Settings:get("UI.RollOff.warnWhenNotAwarded", true)
    ) then
        AwardReminderDialog
            :setItemLink(currentItemLink)
            :replace{
                item = currentItemLink,
            }
            :show{
                onAccept = function ()
                    GL.RollOff.CurrentRollOff.Rolls = {};
                    MasterLooterUI:reset();
                    setItem();
                end,
            };
    else
        setItem();
    end
end

-- Update the master looter UI based on the value of the ItemBox input
function MasterLooterUI:update()
    local IconWidget = GL.Interface:get(self, "Icon.Item");
    local itemLink = GL.Interface:get(self, "EditBox.Item"):GetText();

    -- If the item link is not valid then
    --   Show the default question mark icon
    --   Remove the item priority string
    if (not itemLink or itemLink == "") then
        MasterLooterUI.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage(MasterLooterUI.Defaults.itemIcon);

        MasterLooterUI:updateItemNote();
        MasterLooterUI:updateWidgets();
        return;
    end

    -- The item's icon is in the 10th position
    local icon = select(10, GL:getItemInfo(itemLink));

    if (icon) then
        GL.Interface:get(self, "Table.Players"):ClearSelection();

        IconWidget:SetImage(icon);
        MasterLooterUI.ItemBoxHoldsValidItem = true;
    else
        MasterLooterUI.ItemBoxHoldsValidItem = false;
        IconWidget:SetImage(MasterLooterUI.Defaults.itemIcon);
    end

    MasterLooterUI:updateItemNote();
    MasterLooterUI:updateWidgets();
end

---@return boolean
function MasterLooterUI:isShown()
    local Window = GL.Interface:get(self, "Window");

    return Window and Window:IsShown() or false;
end

-- Update the item priority string
function MasterLooterUI:updateItemNote()
    local defaultNote = GL.Settings:get("MasterLooting.defaultRollOffNote", "");
    local ItemNote = GL.Interface:get(self, "EditBox.ItemNote");
    local itemLink = GL.Interface:get(self, "EditBox.Item"):GetText();

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
    keepItem = GL:toboolean(keepItem);

    if (not keepItem) then
        self.awardedCurrentItem = true;
        GL.Interface:get(self, "Icon.Item"):SetImage(MasterLooterUI.Defaults.itemIcon);
        GL.Interface:get(self, "EditBox.Item"):SetText(MasterLooterUI.Defaults.itemText);
        GL.Interface:get(self, "EditBox.Duration"):SetText(GL.Settings:get("UI.RollOff.timer"));
        GL.Interface:get(self, "EditBox.ItemNote"):SetText("");
        MasterLooterUI.ItemBoxHoldsValidItem = false;
    end

    GL.Interface:get(self, "Table.Players"):ClearSelection();
    GL.Interface:get(self, "Table.Players"):ClearSelection();
    GL.Interface:get(self, "Table.Players"):SetData({}, true);

    MasterLooterUI:updateWidgets();
end

-- Update the widgets based on the current state of the roll off
function MasterLooterUI:updateWidgets()
    -- If the itembox doesn't hold a valid item link then:
    --   The start button should not be available
    --   The stop button should be available
    --   The item box should be available
    if (not MasterLooterUI.ItemBoxHoldsValidItem) then
        GL.Interface:get(self, "Button.Start"):SetDisabled(true);
        GL.Interface:get(self, "Button.Stop"):SetDisabled(true);
        GL.Interface:get(self, "EditBox.Item"):SetDisabled(false);
        GL.Interface:get(self, "EditBox.Item"):SetDisabled(false);
        GL.Interface:get(self, "Button.Award"):SetDisabled(true);
        GL.Interface:get(self, "Button.Disenchant"):SetDisabled(true);

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
        GL.Interface:get(self, "Button.Start"):SetDisabled(false);
        GL.Interface:get(self, "Button.Stop"):SetDisabled(true);
        GL.Interface:get(self, "Button.Award"):SetDisabled(false);
        GL.Interface:get(self, "Button.Disenchant"):SetDisabled(false);
        GL.Interface:get(self, "Button.Clear"):SetDisabled(false);
        GL.Interface:get(self, "EditBox.Item"):SetDisabled(false);

    -- If a roll off is currently in progress then:
    --   The start button should not be available
    --   The stop button should be available
    --   The award button should not be available
    --   The clear button should not be available
    --   The item box should not be available
    else
        GL.Interface:get(self, "Button.Start"):SetDisabled(true);
        GL.Interface:get(self, "Button.Stop"):SetDisabled(false);
        GL.Interface:get(self, "Button.Award"):SetDisabled(true);
        GL.Interface:get(self, "Button.Disenchant"):SetDisabled(true);
        GL.Interface:get(self, "Button.Clear"):SetDisabled(true);
        GL.Interface:get(self, "EditBox.Item"):SetDisabled(true);
    end
end
