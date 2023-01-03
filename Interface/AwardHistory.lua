---@type GL
local _, GL = ...;

GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

---@class AwardHistoryInterface
GL.Interface.AwardHistory = {
    isVisible = false,
    eventListenersSet = false,
    showingItemsAwardedSince = nil,
    RefreshTimer = nil,
    ChecksumsToShow = nil,
    PreviousAnchors = {},
    Window = nil,
};

---@type AwardHistoryInterface
local AwardHistory = GL.Interface.AwardHistory;

--- Determine which checksums should be shown in the awardhistory window
---
---@return void
function AwardHistory:populateChecksumsToShow()
    self.ChecksumsToShow = {};
    local fiveHoursAgo = GetServerTime() - 18000;
    local loadItemsGTE = math.min(fiveHoursAgo, GL.loadedOn);

    self.showingItemsAwardedSince = loadItemsGTE;

    for checksum, Entry in pairs(GL.DB.AwardHistory) do
        if (checksum and Entry.timestamp and Entry.timestamp >= loadItemsGTE) then
            tinsert(self.ChecksumsToShow, {checksum, Entry.timestamp});
        end
    end

    local sortChecksumsNewestToOldest = function ()
        table.sort(self.ChecksumsToShow, function (a, b)
            return a[2] > b[2];
        end);
    end;

    sortChecksumsNewestToOldest();

    if (not self.eventListenersSet) then
        self.eventListenersSet = true;

        GL.Events:register("AwardHistoryItemAwardedInstantListener", "GL.ITEM_AWARDED", function (_, Entry)
            if (not Entry.checksum or not Entry.timestamp) then
                return;
            end

            tinsert(self.ChecksumsToShow, {Entry.checksum, Entry.timestamp});
            sortChecksumsNewestToOldest();
        end);
    end
end

--- Toggle the award history window
---
---@return void
function AwardHistory:toggle()
    if (self.isVisible) then
        return self:close();
    end

    self:draw();
end

--- Draw the award history window
---
---@return void
function AwardHistory:draw()
    GL:debug("AwardHistory:draw");

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Cache the items we need to show first
    if (not self.ChecksumsToShow) then
        self:populateChecksumsToShow();
    end

    local Window;
    local WindowWidth;

    WindowWidth = 430;
    Window = GL.AceGUI:Create("Frame");
    Window:SetTitle("Award History");
    Window:SetStatusText("Items awarded since " .. date('%d-%m-%Y %H:%M', self.showingItemsAwardedSince));
    Window:SetLayout("FILL");
    Window:SetWidth(WindowWidth);
    GL.Interface:restorePosition(Window, "AwardHistory");
    GL.Interface:restoreDimensions(Window, "AwardHistory", WindowWidth, 420);
    Window:SetCallback("OnClose", function()
        self:close();
    end);

    self.Window = Window;

    local ScrollFrameHolder = GL.AceGUI:Create("SimpleGroup");
    ScrollFrameHolder:SetLayout("FILL")
    ScrollFrameHolder:SetFullWidth(true);
    ScrollFrameHolder:SetFullHeight(true);
    Window:AddChild(ScrollFrameHolder);

    local ScrollFrame = GL.AceGUI:Create("ScrollFrame");
    ScrollFrame:SetLayout("Flow");
    ScrollFrameHolder:AddChild(ScrollFrame);

    local fiveHoursAgo = GetServerTime() - 18000;
    local loadItemsGTE = math.min(fiveHoursAgo, GL.loadedOn);
    local AwardedItemsToShow = {};
    local thereAreItemsToShow = false;

    for _, Entry in pairs(self.ChecksumsToShow) do
        local Loot = GL.DB.AwardHistory[Entry[1]];

        -- This item should no longer be shown
        if (not Loot or not Loot.timestamp or Loot.timestamp < loadItemsGTE) then
            GL.DB.AwardHistory[Entry[1]] = nil;
        else
            tinsert(AwardedItemsToShow, Loot);
            thereAreItemsToShow = true;
        end
    end

    if (thereAreItemsToShow) then
        Window.frame:SetAlpha(1);
    end

    --local itemLinkLabelWidth = math.max(160, 160 + (WindowWidth - 430));
    local itemLinkLabelWidth = math.max(150, 150 + (WindowWidth - 430));
    GL:onItemLoadDo(GL:tableColumn(AwardedItemsToShow, "itemID"), function()
        for _, Award in pairs(AwardedItemsToShow) do
            (function ()
                local ItemDetails = GL.DB.Cache.ItemsByID[tostring(Award.itemID)];

                -- Item was not found, better safe than lua error
                if (not ItemDetails) then
                    return;
                end

                -- Was this item disenchanted?
                local itemWasDisenchanted = Award.awardedTo == GL.Exporter.disenchantedItemIdentifier;

                local ItemRow = GL.AceGUI:Create("SimpleGroup");
                ItemRow:SetLayout("FLOW");
                ItemRow:SetFullWidth(true);
                ScrollFrame:AddChild(ItemRow);

                -- Show player details on hover
                local ItemsWonByRollerInTheLastFiveHours;
                ItemRow.frame:SetScript("OnEnter", function()
                    local linesAdded = false;
                    GameTooltip:ClearLines();
                    GameTooltip:SetOwner(ItemRow.frame, "ANCHOR_RIGHT");

                    if (not ItemsWonByRollerInTheLastFiveHours) then
                        ItemsWonByRollerInTheLastFiveHours = GL.AwardedLoot:byWinner(Award.awardedTo, fiveHoursAgo);
                    end

                    if (not GL:empty(ItemsWonByRollerInTheLastFiveHours)) then
                        linesAdded = true;
                        local header = string.format("Items won by %s:", Award.awardedTo);
                        if (itemWasDisenchanted) then
                            header = "Disenchanted items:"
                        end

                        GameTooltip:AddLine(header);

                        for _, Entry in pairs(ItemsWonByRollerInTheLastFiveHours) do
                            local receivedString = " (item given: yes)";
                            if (not Entry.received) then
                                receivedString = " (item given: no)";
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
                    end

                    if (not GL:empty(Award.Rolls)) then
                        local rollsPerPlayer = {};

                        -- Sort the PrioListEntries based on prio (lowest to highest)
                        table.sort(Award.Rolls, function (a, b)
                            if (a.time and b.time) then
                                return a.time < b.time;
                            end

                            return false;
                        end);

                        if (linesAdded) then
                            GameTooltip:AddLine(" ");
                        end

                        GameTooltip:AddLine("Rolls");
                        linesAdded = true;

                        for _, Roll in pairs (Award.Rolls or {}) do
                            local rollCount = "";
                            if (not rollsPerPlayer[Roll.player]) then
                                rollsPerPlayer[Roll.player] = 1;
                            else
                                rollsPerPlayer[Roll.player] = rollsPerPlayer[Roll.player] + 1;
                                rollCount = string.format("[%s]", rollsPerPlayer[Roll.player]);
                            end

                            GameTooltip:AddLine(string.format("|c00%s%s|r: %s%s (%s)",
                                GL:classHexColor(Roll.class),
                                Roll.player,
                                Roll.amount,
                                rollCount,
                                Roll.classification
                            ));
                        end
                    end

                    if (linesAdded) then
                        GameTooltip:Show();
                    end
                end);
                ItemRow.frame:SetScript("OnLeave", function()
                    GameTooltip:Hide();
                end);

                local ItemIcon = GL.AceGUI:Create("Icon");
                ItemIcon:SetWidth(30);
                ItemIcon:SetHeight(30);
                ItemIcon:SetImageSize(30, 30);
                ItemIcon:SetImage(ItemDetails.icon);
                ItemRow:AddChild(ItemIcon);
                ItemIcon:SetCallback("OnLeave", function()
                    GameTooltip:Hide();
                end);

                -- Show a gametooltip if the icon shown belongs to an item
                ItemIcon:SetCallback("OnEnter", function()
                    GameTooltip:SetOwner(ItemIcon.frame, "ANCHOR_TOP");
                    GameTooltip:SetHyperlink(ItemDetails.link);
                    GameTooltip:Show();
                end)

                local VerticalSpacer = GL.AceGUI:Create("SimpleGroup");
                VerticalSpacer:SetLayout("FILL");
                VerticalSpacer:SetWidth(8);
                VerticalSpacer:SetHeight(1);
                ItemRow:AddChild(VerticalSpacer);

                local ItemLinkLabel = GL.AceGUI:Create("Label");
                ItemLinkLabel:SetText(ItemDetails.link);
                ItemLinkLabel:SetWidth(itemLinkLabelWidth);
                ItemRow:AddChild(ItemLinkLabel);

                local PlayerLabel = GL.AceGUI:Create("Label");
                if (not itemWasDisenchanted) then
                    PlayerLabel:SetText(string.format("|c00%s%s|r",
                        GL:classHexColor(GL.Player:classByName(Award.awardedTo, 0), "5f5f5f"),
                        Award.awardedTo
                    ));
                else
                    PlayerLabel:SetText("Disenchanted!");
                end

                PlayerLabel:SetWidth(100);
                ItemRow:AddChild(PlayerLabel);

                local ActionButtonFrame = GL.AceGUI:Create("SimpleGroup");
                ActionButtonFrame:SetLayout("FILL");

                local elvUIStupendousScalingCrapModifier = 0;
                if (GL.elvUILoaded) then
                    elvUIStupendousScalingCrapModifier = 10;
                end

                ActionButtonFrame:SetWidth(WindowWidth - 30 - itemLinkLabelWidth - 100 - 50 - 16 - elvUIStupendousScalingCrapModifier);
                ActionButtonFrame:SetHeight(30);
                ItemRow:AddChild(ActionButtonFrame);

                if (not GL.User.isInGroup or GL.User.hasAssist or GL.User.isMasterLooter) then
                    local DeleteButton = GL.UI:createFrame("Button", "AwardHistoryActionButton" .. GL:uuid(), ActionButtonFrame.frame, "UIPanelButtonTemplate");
                    DeleteButton:SetSize(24, 24);
                    DeleteButton:SetPoint("TOPRIGHT", ActionButtonFrame.frame, "TOPRIGHT", 0, 0);
                    DeleteButton:SetMotionScriptsWhileDisabled(true); -- Make sure tooltip still shows even when button is disabled

                    local HighlightTexture = DeleteButton:CreateTexture();
                    HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\delete-highlighted");
                    HighlightTexture:SetPoint("CENTER", DeleteButton, "CENTER", 0, 0);
                    HighlightTexture:SetSize(24, 24);

                    DeleteButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\delete");
                    DeleteButton:SetHighlightTexture(HighlightTexture);

                    DeleteButton:SetScript("OnClick", function(_, button)
                        if (button == 'LeftButton') then
                            local BRString = "";
                            if (GL:higherThanZero(Award.BRCost)) then
                                BRString = " " .. tostring(Award.BRCost) .. " boosted roll points will be refunded!";
                            end

                            GL.Interface.Dialogs.PopupDialog:open({
                                question = string.format(
                                        "Are you sure you want to undo %s awarded to %s?%s",
                                        Award.itemLink,
                                        Award.awardedTo,
                                        BRString
                                ),
                                OnYes = function ()
                                    GL.AwardedLoot:deleteWinner(Award.checksum);
                                end,
                            });
                        end
                    end);

                    local EditButton = GL.UI:createFrame("Button", "AwardHistoryActionButton" .. GL:uuid(), ActionButtonFrame.frame, "UIPanelButtonTemplate");
                    EditButton:SetSize(24, 24);
                    EditButton:SetPoint("TOPRIGHT", DeleteButton, "TOPLEFT", -3, 0);

                    HighlightTexture = EditButton:CreateTexture();
                    HighlightTexture:SetTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\edit-highlighted");
                    HighlightTexture:SetPoint("CENTER", EditButton, "CENTER", 0, 0);
                    HighlightTexture:SetSize(24, 24);

                    EditButton:SetNormalTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\edit");
                    EditButton:SetHighlightTexture(HighlightTexture);
                    EditButton:SetDisabledTexture("Interface\\AddOns\\Gargul\\Assets\\Buttons\\edit-disabled");

                    EditButton:SetScript("OnClick", function(_, button)
                        if (button == 'LeftButton') then
                            -- Show the player selector
                            local question = string.format("Who should %s go to instead?", Award.itemLink);
                            GL.Interface.PlayerSelector:draw(question, GL.User:groupMemberNames(), function (playerName)
                                GL.Interface.Dialogs.PopupDialog:open({
                                    question = string.format("Award %s to |cff%s%s|r?",
                                            Award.itemLink,
                                            GL:classHexColor(GL.Player:classByName(playerName)),
                                            playerName
                                    ),
                                    OnYes = function ()
                                        if (not playerName or type(playerName) ~= "string") then
                                            return;
                                        end

                                        playerName = GL:capitalize(string.trim(string.lower(GL:stripRealm(playerName))));
                                        GL.AwardedLoot:editWinner(Award.checksum, playerName);

                                        GL.Interface.PlayerSelector:close();
                                    end,
                                });
                            end);
                        end
                    end);
                end
            end)();
        end

        local ItemRow = GL.AceGUI:Create("SimpleGroup");
        ItemRow:SetLayout("FLOW");
        ItemRow:SetFullWidth(true);
        ScrollFrame:AddChild(ItemRow);
    end);

    -- Make sure that the window is updated whenever an award changes
    GL.Events:register({
        {"AwardHistoryItemAwardedListener", "GL.ITEM_AWARDED" },
        {"AwardHistoryItemUnAwardedListener", "GL.ITEM_UNAWARDED" },
        {"AwardHistoryItemEditedListener", "GL.ITEM_AWARD_EDITED" },
    }, function()
        GL:debug("AwardHistory:refresh");

        GL.Ace:CancelTimer(self.RefreshTimer);
        self.RefreshTimer = GL.Ace:ScheduleTimer(function ()
            self:refresh();
        end, .3);
    end);
end

---@return void
function AwardHistory:close()
    GL:debug("AwardHistory:close");

    if (not self.isVisible) then
        return;
    end

    self.isVisible = false;

    if (self.Window
        and self.Window.frame
        and self.Window.frame.Hide
    ) then
        GL.Interface:storePosition(self.Window, "AwardHistory");
        GL.Interface:storeDimensions(self.Window, "AwardHistory");
        self.Window.frame:Hide();
    end

    self.Window = nil;

    GL.Events:unregister({
        "AwardHistoryItemAwardedListener",
        "AwardHistoryItemUnAwardedListener",
        "AwardHistoryItemEditedListener",
    });
end

--- Refresh
---
---@param AnchorTo table|nil
---@return void
function AwardHistory:refresh(AnchorTo)
    GL:debug("AwardHistory:refresh");

    if (not self.isVisible) then
        return;
    end

    self:close();
    self:draw(AnchorTo);
end

GL:debug("Interface/AwardHistory.lua");