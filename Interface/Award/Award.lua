local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.Interface.Award = GL.Interface.Award or {};
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

local AceGUI = GL.AceGUI;
local ScrollingTable = GL.ScrollingTable;

---@type Settings
local Settings = GL.Settings;

---@type TMB
local TMB = GL.TMB;

---@type GDKPAuction
local GDKPAuction = GL.GDKP.Auction;

---@class AwardInterface
GL.Interface.Award.Award = {
    ItemBoxHoldsValidItem = false,
    PlayersTable = {},
    Defaults = {
        itemIcon = "Interface/Icons/INV_Misc_QuestionMark",
        itemBoxText = "",
    },
};

---@type AwardInterface
local Award = GL.Interface.Award.Award;

---@param itemLink string
---@param callback function
---@return void
function Award:draw(itemLink, callback)
    local itemID = GL:getItemIDFromLink(itemLink);

    -- First we need to check if the frame hasn't been
    -- rendered already. If so then show it (if it's hidden)
    -- and pass the itemLink along in case one was provided
    if (GL.Interface:get(self, "Window")
        and GL.Interface:get(self, "Window").rendered
    ) then
        local PlayerNameBox = GL.Interface:get(self, "EditBox.PlayerName");
        local Window = GL.Interface:get(self, "Window");
        Window.callback = callback or function () end;

        if (itemLink) then
            Award:passItemLink(itemLink);
        end

        -- If the frame is hidden we need to show it again
        if (not Window:IsShown()) then
            Window:Show();
        end

        -- Reset the player name box (BEFORE POPULATING THE TABLE!)
        if (PlayerNameBox) then
            PlayerNameBox:SetText("");
        end

        Award:populatePlayersTable(itemID or nil);

        return;
    end

    local Spacer;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetLayout("Flow");
    Window:SetWidth(430);
    Window:SetHeight(300);
    Window:EnableResize(false);
    Window.rendered = true;
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window._callback = callback or function () end;
    GL.Interface:restorePosition(Window, "Award");
    GL.Interface:set(self, "Window", Window);

    --[[
        SETTINGS BUTTON
    ]]
    local SettingsButton = GL.UI:createSettingsButton(
        Window.frame,
        "AwardingLoot"
    );
    self.SettingsButton = SettingsButton;

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_AWARD_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_AWARD_WINDOW");

    --[[
        FIRST ROW (ITEM AND BUTTONS)
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
    ItemIcon:SetImage(Award.Defaults.itemIcon);
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
    ItemBox:SetWidth(150);
    ItemBox:SetCallback("OnTextChanged", function () self:ItemBoxChanged() end); -- Update item info when input value changes
    ItemBox:SetCallback("OnEnterPressed", function () self:ItemBoxChanged() end); -- Update item info when item is dragged on top (makes no sense to use OnEnterPressed I know)
    GL.Interface:set(self, "Item", ItemBox);

    FirstRow:AddChild(ItemBox);

    -- Show a gametooltip if the icon shown belongs to an item
    ItemIcon:SetCallback("OnEnter", function()
        if (not Award.ItemBoxHoldsValidItem) then
            GameTooltip:SetOwner(ItemIcon.frame, "ANCHOR_TOP");
            GameTooltip:AddLine(L["Drag and drop or shift+click an item in the box on the right"]);
            GameTooltip:Show();
            return;
        end

        local tooltipItemLink = ItemBox:GetText();
        GameTooltip:SetOwner(ItemIcon.frame, "ANCHOR_TOP");
        GameTooltip:SetHyperlink(tooltipItemLink);
        GameTooltip:Show();
    end)

    ItemIcon:SetCallback("OnLeave", function()
        GameTooltip:Hide();
    end)

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetWidth(4);
    Spacer:SetHeight(20);
    FirstRow:AddChild(Spacer);

    --[[
        AWARD BUTTON
    ]]

    local PlayerNameBox;
    local AwardButton = AceGUI:Create("Button");
    AwardButton:SetText(L["Award"]);
    AwardButton:SetWidth(70); ---@TODO: TOO SHORT FOR FR
    AwardButton:SetHeight(20);
    AwardButton:SetDisabled(true);
    AwardButton:SetCallback("OnClick", function()
        local PlayersTable = GL.Interface:get(self, "Table.Players");
        local selected = PlayersTable:GetRow(PlayersTable:GetSelection());
        itemLink = GL.Interface:get(self, "EditBox.Item"):GetText();
        local winner = false;

        local award = function (random)
            winner = GL:addRealm(winner);

            local isOS, addPlusOne = false;
            local boostedRollCost = nil;
            local GDKPPrice = nil;

            local OSCheckBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.OffSpec");
            if (OSCheckBox) then
                isOS = GL:toboolean(OSCheckBox:GetValue());
            end

            local addPlusOneCheckBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "CheckBox.PlusOne");
            if (not random and addPlusOneCheckBox) then
                addPlusOne = GL:toboolean(addPlusOneCheckBox:GetValue());

                if (addPlusOne) then
                    GL.PlusOnes:addPlusOnes(winner);
                end
            end

            local BoostedRollCostEditBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "EditBox.Cost");
            if (BoostedRollCostEditBox) then
                boostedRollCost = GL.BoostedRolls:toPoints(BoostedRollCostEditBox:GetText());

                if (boostedRollCost) then
                    GL.BoostedRolls:modifyPoints(winner, -boostedRollCost);
                end
            end

            local GDKPPriceEditBox = GL.Interface:get(GL.Interface.Dialogs.AwardDialog, "EditBox.GDKPPrice");
            local added = false;
            if (GDKPPriceEditBox) then
                GDKPPrice = tonumber(GDKPPriceEditBox:GetText());

                if (GL:higherThanZero(GDKPPrice)) then
                    local awardChecksum = GL.AwardedLoot:addWinner{
                        brCost = boostedRollCost,
                        gdkpCost = GDKPPrice,
                        isOS = isOS,
                        itemLink = itemLink,
                        winner = winner,
                    };

                    GDKPAuction:create(itemLink, GDKPPrice, winner, nil, nil, nil, awardChecksum);
                    added = true;
                end
            end

            if (not added) then
                -- Add the player we awarded the item to to the item's tooltip
                GL.AwardedLoot:addWinner{
                    brCost = boostedRollCost,
                    isOS = isOS,
                    itemLink = itemLink,
                    winner = winner,
                };
            end

            GL.Interface.Award.Award:reset();

            if (Settings:get("UI.Award.closeOnAward", true)) then
                self:close();
            end

            Window._callback();
        end

        -- No player was selected, check if the ML wants to award this item to a random player
        if (not selected or type(selected) ~= "table") then
            winner = PlayerNameBox:GetText();

            if (GL:empty(winner)) then
                -- Show a confirmation dialog asking whether we should award this to a random person
                return GL.Interface.Dialogs.PopupDialog:open{
                    question = (L["Do you want to award %s to a random player?"]):format(itemLink),
                    OnYes = function ()
                        local GroupMembers = GL.User:groupMembers();

                        -- Pick a random winner
                        winner = GL:tableGet(GroupMembers[math.random( #GroupMembers)] or {}, "name", false);

                        -- We couldn't find any winner (shouldn't be possible, just a safety check)
                        if (not winner) then
                            return;
                        end

                        GL:sendChatMessage((L.CHAT["Random winner for %s selected (%s)"]):format(itemLink, winner), "GROUP");
                        award(true);
                    end,
                };
            end
        else
            winner = selected.cols[1].value;
        end

        -- Make sure the initiator has to confirm his choices
        GL.Interface.Dialogs.AwardDialog:open{
            question = (L["Award %s to %s?"]):format(itemLink, GL:nameFormat{ name = winner, colorize = true }),
            OnYes = award,
        };
    end);
    FirstRow:AddChild(AwardButton);
    GL.Interface:set(self, "Award", AwardButton);

    --[[
        AWARD HISTORY BUTTON
    ]]

    local AwardHistoryButton = GL.UI:createFrame("Button", "MasterLooterUIAwardOverviewButton" .. GL:uuid(), Window.frame, "UIPanelButtonTemplate");
    AwardHistoryButton:SetSize(22, 20);
    AwardHistoryButton:SetPoint("TOPLEFT", AwardButton.frame, "TOPRIGHT", 0, 0);
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

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Flow");
    Spacer:SetWidth(22);
    Spacer:SetHeight(20);
    FirstRow:AddChild(Spacer);

    --[[
        DISENCHANT BUTTON
    ]]
    local DisenchantButton = AceGUI:Create("Button");
    DisenchantButton:SetText(L["Disenchant"]);
    DisenchantButton:SetWidth(100);
    DisenchantButton:SetHeight(20);
    DisenchantButton:SetDisabled(false);
    DisenchantButton:SetCallback("OnClick", function()
        itemLink = GL.Interface:get(self, "EditBox.Item"):GetText();

        if (GL.PackMule.disenchanter) then
            GL.PackMule:disenchant(itemLink);

            if (Settings:get("UI.Award.closeOnAward", true)) then
                self:close();
            end

            return;
        end

        local PlayersTable = GL.Interface:get(self, "Table.Players");
        local selected = PlayersTable:GetRow(PlayersTable:GetSelection());

        if (not selected or type(selected) ~= "table") then
            return GL:warning(L["You need to select a player first"]);
        end

        local disenchanter = selected.cols[1].value;

        -- No disenchanter was set yet
        GL.Interface.Dialogs.PopupDialog:open{
            question = string.format(L["Set %s as your disenchanter?"],
                    GL:nameFormat{ name = disenchanter, colorize = true, },
                    disenchanter
            ),
            OnYes = function ()
                GL.PackMule:setDisenchanter(disenchanter);
                GL.PackMule:disenchant(itemLink, true);

                if (Settings:get("UI.Award.closeOnAward", true)) then
                    self:close();
                end
            end,
        };
    end);
    FirstRow:AddChild(DisenchantButton);
    GL.Interface:set(self, "Disenchant", DisenchantButton);

    --[[
        SECOND ROW (player name box)
    ]]

    local SecondRow = AceGUI:Create("SimpleGroup");
    SecondRow:SetLayout("Flow");
    SecondRow:SetFullWidth(true);
    SecondRow:SetHeight(24);
    Window:AddChild(SecondRow);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Fill");
    Spacer:SetWidth(4);
    Spacer:SetHeight(20);
    SecondRow:AddChild(Spacer);

    local PlayerNameLabel = AceGUI:Create("Label");
    PlayerNameLabel:SetText(L["Type player name here"]);
    PlayerNameLabel:SetHeight(20);
    PlayerNameLabel:SetWidth(128); -- Minimum is 122
    SecondRow:AddChild(PlayerNameLabel);

    PlayerNameBox = AceGUI:Create("EditBox");
    PlayerNameBox:SetHeight(20);
    PlayerNameBox:SetWidth(120);
    PlayerNameBox:SetCallback("OnEnterPressed", function ()
        -- Remove table selection because we're awarding from the player name field
        local PlayersTable = GL.Interface:get(self, "Table.Players");

        if (PlayersTable) then
            PlayersTable:ClearSelection();
        end

        AwardButton:Fire("OnClick");
    end); -- Award
    SecondRow:AddChild(PlayerNameBox);
    GL.Interface:set(self, "PlayerName", PlayerNameBox);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Fill");
    Spacer:SetWidth(6);
    Spacer:SetHeight(20);
    SecondRow:AddChild(Spacer);

    local PlayerNameLabelSuffix = AceGUI:Create("Label");
    PlayerNameLabelSuffix:SetText(L["or select one below"]);
    PlayerNameLabelSuffix:SetHeight(20);
    PlayerNameLabelSuffix:SetWidth(104); -- Minimum is 104
    SecondRow:AddChild(PlayerNameLabelSuffix);

    local ThirdRow = AceGUI:Create("SimpleGroup");
    ThirdRow:SetLayout("FILL");
    ThirdRow:SetFullWidth(true);
    ThirdRow:SetHeight(150);
    Window:AddChild(ThirdRow);

    Award:drawPlayersTable();

    --[[
        THIRD ROW (AUTO CLOSE CHECKBOX)
    ]]

    local FourthRow = AceGUI:Create("SimpleGroup");
    FourthRow:SetLayout("Flow");
    FourthRow:SetFullWidth(true);
    FourthRow:SetHeight(50);
    Window:AddChild(FourthRow);

    local CloseOnAward = AceGUI:Create("CheckBox");
    CloseOnAward:SetLabel(L["Close on award"]);
    CloseOnAward:SetValue(Settings:get("UI.Award.closeOnAward", true));
    CloseOnAward:SetCallback("OnValueChanged", function (widget)
        Settings:set("UI.Award.closeOnAward", widget:GetValue());
    end);
    CloseOnAward:SetWidth(150);
    FourthRow:AddChild(CloseOnAward);

    self:draw(itemLink);
end

---@return void
function Award:close()
    local Window = GL.Interface:get(self, "Window");

    if (not Window) then
        return;
    end

    local EditBox = GL.Interface:get(self, "EditBox.PlayerName");

    if (EditBox and EditBox.SetText) then
        EditBox:SetText("");
    end

    GL.Interface:storePosition(Window, "Award");
    Window:Hide();
end

---@return void
function Award:drawPlayersTable()
    local Parent = GL.Interface:get(self, "Window").frame;

    -- Combined width of all columns should be 340
    local columns = {
        {
            name = L["In Group"],
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

    local Table = ScrollingTable:CreateST(columns, 8, 15, nil, Parent);
    Table:EnableSelection(true);
    Table.frame:SetPoint("BOTTOM", Parent, "BOTTOM", 0, 46);
    GL.Interface:set(self, "Players", Table);

    Table:RegisterEvents{
        OnClick = function (_, _, data, _, _, realrow)
            -- Make sure something is actually selected, better safe than lua error
            if (not GL:higherThanZero(realrow)
                    or type(data) ~= "table"
                    or not data[realrow]
                    or not data[realrow].cols
                    or not data[realrow].cols[1]
            ) then
                return;
            end

            local selectedPlayer = data[realrow].cols[1].value;
            local EditBox = GL.Interface:get(self, "EditBox.PlayerName");

            if (EditBox and EditBox.SetText) then
                EditBox:SetText(GL:capitalize(selectedPlayer));
            end
        end
    };

    Award:populatePlayersTable();
end

--- Check if a single player is top prio on a given item ID
---
---@param itemID
---@return nil|string
function Award:topPrioForItem(itemID)
    -- This item was only reserved by one player
    if (GL.SoftRes:available()) then
        local lastPlayerName = false;
        local moreThanOnePersonReservedThisItem = false;
        for _, playerName in pairs(GL.SoftRes:byItemID(itemID, true)) do
            if (not lastPlayerName) then
                lastPlayerName = playerName;
            end

            if (playerName ~= lastPlayerName) then
                moreThanOnePersonReservedThisItem = true;
                break;
            end
        end

        if (lastPlayerName
            and not moreThanOnePersonReservedThisItem
        ) then
            return lastPlayerName;
        end
    end

    local PrioListEntries = {};
    local WishListEntries = {};
    for _, Entry in pairs(TMB:byItemID(itemID, true)) do
        -- Priolist entry
        if (Entry.type == 1) then
            tinsert(PrioListEntries, Entry);

            -- Wishlist entry
        elseif (Entry.type == 2) then
            tinsert(WishListEntries, Entry);
        end
    end

    -- There are prio list entries available, use them
    if (not GL:empty(PrioListEntries)) then
        if (GL:count(PrioListEntries) == 1) then
            return PrioListEntries[1].character;
        end

        PrioListEntries = TMB:sortEntries(PrioListEntries);

        -- There's more than 1 person with top prio
        if (PrioListEntries[1].prio == PrioListEntries[2].prio) then
            return;
        end

        return PrioListEntries[1].character;
    end

    -- Return a sanitized name variant to ensure proper name matching
    local sanitizePlayerName = function(name)
        name = name:gsub("%(os%)", "");
        name = string.lower(GL:disambiguateName(name));
        return name;
    end;

    -- There are wish list entries available, use them
    if (not GL:empty(WishListEntries)) then
        if (GL:count(WishListEntries) == 1) then
            return sanitizePlayerName(WishListEntries[1].character);
        end

        WishListEntries = TMB:sortEntries(WishListEntries);

        -- There's more than 1 person with top prio
        if (WishListEntries[1].prio == WishListEntries[2].prio) then
            return;
        end

        return sanitizePlayerName(WishListEntries[1].character);
    end
end

-- Populate the players table with your current group members
function Award:populatePlayersTable(itemID)
    local PlayersTable = GL.Interface:get(self, "Table.Players");

    if (not PlayersTable) then
        return;
    end

    PlayersTable:ClearSelection();

    -- See if there's a top player for this item that we can preselect
    local topPrioForItem = self:topPrioForItem(itemID);
    if (topPrioForItem) then
        topPrioForItem = string.lower(GL:stripRealm(topPrioForItem));
    end

    local TableData = {};
    local row = 1;
    for _, Player in pairs(GL.User:groupMembers()) do
        tinsert(TableData, {
            cols = {
                {
                    value = GL:nameFormat(Player.fqn),
                    color = GL:classRGBAColor(Player.class),
                },
            },
        });

        if (topPrioForItem and topPrioForItem == string.lower(Player.name)) then
            PlayersTable:SetSelection(row);
            local EditBox = GL.Interface:get(self, "EditBox.PlayerName");

            if (EditBox and EditBox.SetText) then
                EditBox:SetText(GL:capitalize(topPrioForItem));
            end
        end

        row = row + 1;
    end

    PlayersTable:SetData(TableData);
end

--- The item box contents changed
---@return void
function Award:ItemBoxChanged()
    local itemLink = GL.Interface:get(self, "EditBox.Item"):GetText();

    Award:passItemLink(itemLink);
end

--- Pass an item link to the master looter UI
--- This method is used when alt clicking an item
--- in a loot window or when executing /gl roll [itemlink]
---
---@param itemLink string
---@return void
function Award:passItemLink(itemLink)
    if (not GL.Interface:get(self, "Window").rendered) then
        return;
    end

    GL.Interface:get(self, "EditBox.Item"):SetText(itemLink);
    Award:update();
end

--- Update the master looter UI based on the value of the ItemBox input
---
---@return void
function Award:update()
    local IconWidget = GL.Interface:get(self, "Icon.Item");
    local itemLink = GL.Interface:get(self, "EditBox.Item"):GetText();

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
    local icon = select(10, GL.GetItemInfo(itemLink));

    if (icon) then
        GL.Interface:get(self, "Table.Players"):ClearSelection();

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
    GL.Interface:get(self, "Icon.Item"):SetImage(Award.Defaults.itemIcon);
    GL.Interface:get(self, "EditBox.Item"):SetText(Award.Defaults.itemText);
    Award.ItemBoxHoldsValidItem = false;

    Award:updateWidgets();
end

--- Update the widgets based on the current state of the roll off
---
---@return void
function Award:updateWidgets()
    -- If the itembox doesn't hold a valid item link then:
    --   The start button should not be available
    --   The stop button should be available
    --   The item box should be available
    if (not Award.ItemBoxHoldsValidItem) then
        GL.Interface:get(self, "Button.Award"):SetDisabled(true);
        GL.Interface:get(self, "Button.Disenchant"):SetDisabled(true);
    else
        GL.Interface:get(self, "Button.Award"):SetDisabled(false);
        GL.Interface:get(self, "Button.Disenchant"):SetDisabled(false);
    end
end
