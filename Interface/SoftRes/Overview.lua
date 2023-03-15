---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

local AceGUI = GL.AceGUI;
local Constants = GL.Data.Constants; ---@type Data
local DB = GL.DB; ---@type DB
local ScrollingTable = GL.ScrollingTable;
local SoftRes = GL.SoftRes; ---@type SoftRes

GL:tableSet(GL, "Interface.SoftRes.Overview", {
    isVisible = false,
    selectedCharacter = nil,
});

---@class SoftResOverview
local Overview = GL.Interface.SoftRes.Overview;

--- Draw the UI elements required to show an overview of all soft-reserve data
--- This is what this frame looks like:
---     +-------+---------+
---     | Col1  |  Col2   |
---     +-----------------+
---     | Button Frame    |
---     +-----------------+
---
---@return void
function Overview:draw()
    GL:debug("Overview:draw");

    -- The overview is already visible
    if (self.isVisible) then
        return;
    end

    GL.Events:register("SoftResShareButtonRosterUpdatedListener", "GROUP_ROSTER_UPDATE", function () self:updateShareButton(); end);

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    GL.Interface:AceGUIDefaults(self, Window, "SoftReserveOverview", 600, 470);
    Window:EnableResize(false);

    Window:SetStatusText(string.format(
        "Imported on |c00a79eff%s|r at |c00a79eff%s|r",
        date('%Y-%m-%d', GL:tableGet(DB.SoftRes, "MetaData.importedAt", GetServerTime())),
        date('%H:%M', GL:tableGet(DB.SoftRes, "MetaData.importedAt", GetServerTime()))
    ));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_SOFTRES_OVERVIEW_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_SOFTRES_OVERVIEW_WINDOW");

    --[[
        SHARE BUTTON
    ]]
    local ShareButton = GL.Interface:createShareButton(Window, {
        onClick = function() GL.Interface.Dialogs.PopupDialog:open("BROADCAST_SOFTRES_CONFIRMATION"); end,
        tooltip = "Broadcast SoftRes Data",
        disabledTooltip = "To broadcast you need to be in a group and need master loot, assist or lead!",
        position = "TOPRIGHT",
    });
    GL.Interface:set(self, "ShareButton", ShareButton);

    -- The user doesn't have sufficient permissions to broadcast the data
    if (not GL.SoftRes:userIsAllowedToBroadcast()) then
        ShareButton:Disable();
    else
        ShareButton:Enable();
    end

    --[[
        FIRST COLUMN (character table / hard reserve counter)
    ]]
    local FirstColumn = AceGUI:Create("SimpleGroup");
    FirstColumn:SetLayout("FLOW")
    FirstColumn:SetWidth(240);
    FirstColumn:SetHeight(350);
    Window:AddChild(FirstColumn);

    local FirstColumnVerticalSpacer = AceGUI:Create("SimpleGroup");
    FirstColumnVerticalSpacer:SetLayout("FILL")
    FirstColumnVerticalSpacer:SetWidth(200);
    FirstColumnVerticalSpacer:SetHeight(294);
    FirstColumn:AddChild(FirstColumnVerticalSpacer);

    --[[
        HR FRAME
    ]]
    local HardReserveFrame = AceGUI:Create("InlineGroup");
    HardReserveFrame:SetLayout("FILL")
    HardReserveFrame:SetHeight(50);
    HardReserveFrame:SetWidth(250);
    FirstColumn:AddChild(HardReserveFrame);

    --[[
        HR LABEL
    ]]
    local HardReservesLabel = AceGUI:Create("InteractiveLabel");
    HardReservesLabel:SetText("         No hard-reserve info available");
    HardReservesLabel:SetFontObject(_G["GameFontNormalSmall"]);
    GL.Interface:set(self, "HardReserves", HardReservesLabel);
    HardReserveFrame:AddChild(HardReservesLabel);

    --[[
        COLUMN SPACER
    ]]
    local ColumnSpacer = AceGUI:Create("SimpleGroup");
    ColumnSpacer:SetLayout("FILL")
    ColumnSpacer:SetWidth(25);
    ColumnSpacer:SetHeight(350);
    Window:AddChild(ColumnSpacer);

    --[[
        SECOND COLUMN (Character / Hard-reserve details)
    ]]
    local SecondColumn = AceGUI:Create("InlineGroup");
    SecondColumn:SetLayout("FILL")
    SecondColumn:SetWidth(300);
    SecondColumn:SetHeight(350);
    GL.Interface:set(self, "SecondColumn", SecondColumn);
    Window:AddChild(SecondColumn);

    -- This "Details" frame is necessary to
    -- make the SecondColumn frame fixed width/height
    local Details = AceGUI:Create("SimpleGroup");
    Details:SetLayout("FLOW")
    Details:SetFullWidth(true);
    Details:SetFullHeight(true);
    SecondColumn:AddChild(Details);

    local Title = AceGUI:Create("Label");
    Title:SetFontObject(_G["GameFontNormalLarge"]);
    Title:SetFullWidth(true);
    Title:SetText(" ");
    Details:AddChild(Title);

    local Note = AceGUI:Create("Label");
    Note:SetFontObject(_G["GameFontNormalSmall"]);
    Note:SetFullWidth(true);
    Note:SetText(" \n \n ");
    -- The tripple newline is actually used for spacing, so keep it!
    Details:AddChild(Note);

    -- Add placeholders for all the item icons and labels
    for index = 1, SoftRes.maxNumberOfSoftReservedItems do

        --[[
            ITEM ICON
        ]]
        local ItemIcon = AceGUI:Create("Icon");
        ItemIcon:SetWidth(30);
        ItemIcon:SetHeight(30);
        ItemIcon:SetImageSize(30, 30);
        Details:AddChild(ItemIcon);
        ItemIcon:SetCallback("OnLeave", function()
            GameTooltip:Hide();
        end);

         --[[
            ITEM ICON/LABEL SPACER
        ]]
        local ItemSpacer = AceGUI:Create("SimpleGroup");
        ItemSpacer:SetLayout("FILL")
        ItemSpacer:SetWidth(10);
        ItemSpacer:SetHeight(30);
        Details:AddChild(ItemSpacer);

        --[[
            ITEM LABEL
        ]]
        local ItemLabel = AceGUI:Create("Label");
        ItemLabel:SetFontObject(_G["GameFontNormalSmall"]);
        ItemLabel:SetWidth(220);
        Details:AddChild(ItemLabel);
        ItemLabel:SetText(" \n ");

        -- Add interface items to the Overview class so we can manipulate them later
        GL.Interface:set(self, "Item" .. index, ItemIcon);
        GL.Interface:set(self, "Item" .. index, ItemLabel);
    end

    --[[
        BUTTONS FRAME
    ]]
    local ButtonFrame = AceGUI:Create("SimpleGroup");
    ButtonFrame:SetLayout("FLOW")
    ButtonFrame:SetFullWidth(true);
    Window:AddChild(ButtonFrame);

    local PostSoftReserveLinkButton = AceGUI:Create("Button");
    PostSoftReserveLinkButton:SetText("Post SR URL");
    PostSoftReserveLinkButton:SetWidth(104); -- Minimum is 104
    PostSoftReserveLinkButton:SetCallback("OnClick", function()
        SoftRes:postLink();
    end);
    ButtonFrame:AddChild(PostSoftReserveLinkButton);
    PostSoftReserveLinkButton:ClearAllPoints();

    local PostMissingSoftReserveInfoButton = AceGUI:Create("Button");
    PostMissingSoftReserveInfoButton:SetText("Post missing SRs");
    PostMissingSoftReserveInfoButton:SetWidth(130); -- Minimum is 130
    PostMissingSoftReserveInfoButton:SetCallback("OnClick", function()
        SoftRes:postMissingSoftReserves();
    end);
    ButtonFrame:AddChild(PostMissingSoftReserveInfoButton);

    local ClearDataButton = AceGUI:Create("Button");
    ClearDataButton:SetText("Clear Data");
    ClearDataButton:SetWidth(100); -- Minimum is 102
    ClearDataButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open("CLEAR_SOFTRES_CONFIRMATION");
    end);
    ButtonFrame:AddChild(ClearDataButton);

    local SettingsButton = AceGUI:Create("Button");
    SettingsButton:SetText("Settings");
    SettingsButton:SetWidth(84); -- Minimum is 102
    SettingsButton:SetCallback("OnClick", function()
        GL.Settings:draw("SoftRes");
    end);
    ButtonFrame:AddChild(SettingsButton);

    self:drawCharacterTable(FirstColumn.frame);

    -- Add interface items to the Overview class so we can manipulate them later
    GL.Interface:set(self, "Title", Title);
    GL.Interface:set(self, "Note", Note);

    if (DB.SoftRes.MetaData.source == Constants.SoftReserveSources.weakaura) then
        -- Show a game tooltip that explains the question mark
        HardReservesLabel:SetCallback("OnEnter", function()
            GameTooltip:SetOwner(HardReservesLabel.frame, "ANCHOR_CURSOR");
            GameTooltip:AddLine("Hard-reserve information is not available because the softres.it information\nprovided was not generated using the 'Gargul Data Export' button.");
            GameTooltip:Show();
        end)

        HardReservesLabel:SetCallback("OnLeave", function()
            GameTooltip:Hide();
        end)
    else
        local somethingWasHardReserved = false;

        HardReservesLabel:SetCallback("OnEnter", function() return end);

        -- Add interface items to the Overview class so we can manipulate them later
        for _ in pairs(SoftRes.MaterializedData.HardReserveDetailsByID or {}) do
            somethingWasHardReserved = true;
            HardReservesLabel:SetText("     Click here to see hard-reserve info");
            HardReservesLabel:SetCallback("OnClick", function()
                self:showHardReserves();
            end);
            break;
        end

        if (not somethingWasHardReserved) then
            HardReservesLabel:SetText("         No items are hard-reserved");
        end
    end
end

--- Update the share button when the group setup changes
---
---@return void
function Overview:updateShareButton()
    local ShareButton = GL.Interface:get(self, "Frame.ShareButton")

    GL.Ace:ScheduleTimer(function ()
        -- The user doesn't have sufficient permissions to broadcast the data
        if (not GL.SoftRes:userIsAllowedToBroadcast()) then
            ShareButton:Disable();
            return;
        end

        ShareButton:Enable();
    end, 1.5);
end

--- Update the SoftRes details frame to show the information of the selected player
---
---@return void
function Overview:refreshDetailsFrame()
    GL:debug("SoftRes:refreshDetailsFrame");

    -- Clear the details frame first
    self:clearDetailsFrame();

    if (not self.selectedCharacter) then
        return;
    end

    local Title = GL.Interface:get(self, "Label.Title");
    local Note = GL.Interface:get(self, "Label.Note");
    local titleText = GL:capitalize(self.selectedCharacter);

    local SoftResDetails = SoftRes:getDetailsForPlayer(GL:stripRealm(self.selectedCharacter));
    local plusOnes = GL.PlusOnes:getPlusOnes(self.selectedCharacter);
    local class = GL:tableGet(SoftResDetails, "class", SoftRes:getPlayerClass(self.selectedCharacter));

    if (GL:higherThanZero(plusOnes)) then
        titleText = string.format("%s (+%s)", titleText, plusOnes);
    end

    Title:SetText(titleText);
    Title:SetColor(unpack(GL:classRGBColor(class)));

    if (GL:empty(SoftResDetails)) then
        Note:SetText("This player did not reserve anything!");
        Note:SetColor(1, 0, 0);

        return;
    end

    local note = GL:tableGet(SoftResDetails, "note", "This player didn't set a note");
    local Items = GL:tableGet(SoftResDetails, "Items", {});
    Note:SetText(note);

    -- Display the items reserved by the player
    local processedItems = 0;
    for itemID, numberOfReservations in pairs(Items) do
        local index = processedItems + 1;

        if (processedItems >= SoftRes.maxNumberOfSoftReservedItems) then
            break;
        end

        local idString = tostring(itemID);

        -- This item has to exist in our cache because we ALWAYS populate it before opening the overview
        local Item = GL.DB.Cache.ItemsByID[idString];

        -- This should never be possible, but you never know what those weirdos are up to nowadays
        if (not Item) then
            GL:error("Something went wrong while parsing your SoftRes data. Please perform a fresh import from SoftRes.it");
            return false;
        end

        local ItemIcon = GL.Interface:get(self, "Icon.Item" .. index);
        local ItemLabel = GL.Interface:get(self, "Label.Item" .. index);

        if (ItemIcon) then
            ItemIcon:SetImage(Item.icon);
            ItemIcon:SetCallback("OnEnter", function()
                GameTooltip:SetOwner(ItemIcon.frame, "ANCHOR_CURSOR");
                GameTooltip:SetHyperlink(Item.link);
                GameTooltip:Show();
            end)
            ItemIcon:SetCallback("OnClick", function()
                HandleModifiedItemClick(Item.link);
            end);
            ItemIcon.frame:Show();
        end

        if (ItemLabel) then
            local labelString = Item.link;

            -- The user reserved this item multiple times
            if (numberOfReservations > 1) then
                labelString = string.format("%s (%sx)", Item.link, numberOfReservations);
            end

            ItemLabel:SetText(labelString);
            ItemLabel.frame:Show();
        end

        processedItems = processedItems + 1;
    end
end

-- Clear the details frame
function Overview:clearDetailsFrame()
    GL:debug("SoftRes:clearDetailsFrame");

    local Title = GL.Interface:get(self, "Label.Title");
    local Note = GL.Interface:get(self, "Label.Note");

    if (Title) then
        Title:SetColor(1, 1, 1);
        Title:SetText("");
    end

    if (Note) then
        Note:SetText("");
        Note:SetColor(1, 1, 1);
    end

    for index = 1, SoftRes.maxNumberOfSoftReservedItems do
        local ItemIcon = GL.Interface:get(self, "Icon.Item" .. index);
        local ItemLabel = GL.Interface:get(self, "Label.Item" .. index);

        if (ItemIcon) then
            ItemIcon:SetImage("");
            ItemIcon.frame:Hide();
        end

        if (ItemLabel) then
            ItemLabel:SetText("");
            ItemLabel.frame:Hide();
        end
    end

    -- This table only exists if the player clicked on the hard-reserve info label
    local HardReservesTable = GL.Interface:get(self, "Table.HardReserves");
    if (HardReservesTable) then
        HardReservesTable:SetData({}, true);
        HardReservesTable:Hide();
    end
end

function Overview:showHardReserves()
    self:clearDetailsFrame();
    self:drawHardReservesTable(GL.Interface:get(self, "Frame.SecondColumn").frame);
end

function Overview:drawCharacterTable(Parent)
    GL:debug("SoftRes:drawCharacterTable");

    local columns = {
        {
            name = "Player",
            width = 131,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1
            },
            colorargs = nil,
            defaultsort = Constants.ScrollingTable.ascending,
        },
        {
            name = "Rolls",
            width = 37,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1
            },
            colorargs = nil,
        },
        {
            name = "#SR",
            width = 37,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1
            },
            colorargs = nil,
            sort = Constants.ScrollingTable.ascending,
            sortnext = 1,
        },
    };

    local Table = ScrollingTable:CreateST(columns, 14, 20, nil, Parent);
    Table:EnableSelection(true);
    Table:SetWidth(205);
    Table.frame:SetPoint("TOPLEFT", Parent, "TOPLEFT", 0, -18);

    Table:RegisterEvents({
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

            -- We always select the first column of the selected row because that contains the player name
            local selected = data[realrow].cols[1].value;

            if (selected and type(selected) == "string") then
                self.selectedCharacter = string.lower(selected);
            end

            self:refreshDetailsFrame();
        end
    });

    local PlayerData = {};
    local FqnNames = {};

    -- Go through everyone in the raid so that you can immediately tell who forgot to soft-reserve!
    if (GL.User.isInGroup) then
        for _, Player in pairs(GL.User:groupMembers()) do
            local playerName = string.lower(Player.name);

            if (GL.isEra and not strfind(playerName, "-")) then
                playerName = string.format("%s-%s", playerName, GL.User.realm);
            end

            PlayerData[playerName] = {
                class = Player.class,
                note = "",
                plusOnes = 0,
                Items = {},
            }

            if (GL.isEra) then
                GL:tableSet(FqnNames, GL:stripRealm(playerName) .. "." .. string.lower(Player.class), playerName);
            end
        end
    end

    -- We can't do a direct assignment because we want to edit this table in a bit
    for playerName, Entry in pairs(SoftRes.MaterializedData.DetailsByPlayerName) do

        if (GL.isEra) then
            playerName = GL:tableGet(FqnNames, string.lower(playerName) .. "." .. Entry.class, playerName);
        end

        PlayerData[playerName] = Entry;
    end

    local TableData = {};

    for playerName, Entry in pairs(PlayerData) do
        local plusOnes = GL.PlusOnes:getPlusOnes(playerName);
        local numberOfSoftReservedItems = 0;

        for _, numberOfReserves in pairs(Entry.Items) do
            numberOfSoftReservedItems = numberOfSoftReservedItems + numberOfReserves;
        end

        local SoftReserveColor = {r=0,g=1,b=0,a=1};

        if (numberOfSoftReservedItems < 1) then
            SoftReserveColor = {r=1,g=0,b=0,a=1};
        end

        if (GL:higherThanZero(plusOnes)) then
            plusOnes = "+" .. plusOnes;
        end

        tinsert(TableData, {
            cols = {
                {
                    value = GL:capitalize(playerName),
                    color = GL:classRGBAColor(Entry.class),
                },
                {
                    value = plusOnes,
                    color = GL:classRGBAColor(Entry.class),
                },
                {
                    value = numberOfSoftReservedItems,
                    color = SoftReserveColor,
                },
            },
        });
    end

    Table:SetData(TableData);
    GL.Interface:set(self, "Characters", Table);
end

---@param Parent table
---@return void
function Overview:drawHardReservesTable(Parent)
    GL:debug("SoftRes:drawHardReservesTable");

    local columns = {
        {
            name = " ",
            width = 266,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1
            },
            colorargs = nil,
        },
    };

    local Table = ScrollingTable:CreateST(columns, 16, 20, nil, Parent);
    Table:SetWidth(266);
    Table.frame:SetPoint("TOPLEFT", Parent, "TOPLEFT", 0, -18);

    Table:RegisterEvents({
        OnEnter = function (rowFrame, _, data, _, _, realrow)
            local HardReservesLabel = GL.Interface:get(self, "Label.HardReserves");

            -- Make sure that all data is available, better safe than lua error
            if (not HardReservesLabel
                or not GL:higherThanZero(realrow)
                or type(data) ~= "table"
                or not data[realrow]
                or not data[realrow].cols
                or not data[realrow].cols[1]
            ) then
                return;
            end

            -- We always select the first column of the selected row because that contains the player name
            local selected = data[realrow].cols[1].value;
            local itemID = GL:getItemIDFromLink(selected);
            local IDString = tostring(itemID);
            local hardReserveDetails = SoftRes.MaterializedData.HardReserveDetailsByID[IDString];

            if (not hardReserveDetails
                or (not hardReserveDetails.reservedFor
                    and not hardReserveDetails.note
                )
            ) then
                return;
            end

            GameTooltip:SetOwner(rowFrame, "ANCHOR_CURSOR");
            GameTooltip:SetHyperlink(selected);
            GameTooltip:Show();
        end,

        OnLeave = function ()
            GameTooltip:Hide();
        end,

        OnClick = function (rowFrame, _, data, _, _, realrow)
            -- Make sure that all data is available, better safe than lua error
            if (not GL:higherThanZero(realrow)
                or type(data) ~= "table"
                or not data[realrow]
                or not data[realrow].cols
                or not data[realrow].cols[1]
            ) then
                return;
            end

            -- We always select the first column of the selected row because that contains the player name
            local selected = data[realrow].cols[1].value;
            HandleModifiedItemClick(selected);
        end,
    });

    local TableData = {};
    for _, Entry in pairs(DB.SoftRes.HardReserves) do
        local idString = tostring(Entry.id);
        local Item = GL.DB.Cache.ItemsByID[idString];

        if (Item) then
            tinsert(TableData, {
                cols = {
                    {
                        value = Item.link,
                    },
                },
            });
        end
    end

    Table:SetData(TableData);
    GL.Interface:set(self, "HardReserves", Table);
end

---@return void
function Overview:close()
    GL:debug("Overview:close");

    local Window = GL.Interface:get(self, "SoftReserveOverview");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    GL.Events:unregister("SoftResShareButtonRosterUpdatedListener");

    -- Clear the frame and its widgets
    GL.Interface:release(Window);
    self.isVisible = false;

    local ShareButton = GL.Interface:get(self, "Frame.ShareButton");
    if (ShareButton) then
        ShareButton:Hide();
    end

    -- Clean up the Character table separately
    local CharacterTable = GL.Interface:get(self, "Table.Characters");
    if (CharacterTable) then
        CharacterTable:SetData({}, true);
        CharacterTable:Hide();
    end
end

GL:debug("Interfaces/SoftRes/Overview.lua");