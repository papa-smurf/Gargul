---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

local AceGUI = GL.AceGUI;
local Constants = GL.Data.Constants; ---@type Data
local DB = GL.DB; ---@type DB
local ScrollingTable = GL.ScrollingTable;
local StackedRoll = GL.StackedRoll; ---@type StackedRoll

GL:tableSet(GL, "Interface.StackedRoll.Overview", {
    isVisible = false,
    selectedCharacter = nil,
    points = 0,
});

---@class StackedRollOverview
local Overview = GL.Interface.StackedRoll.Overview;

--- Draw the UI elements required to show an overview of all stacked roll data
--- This is what this frame looks like:
---     +-----------------+
---     | Points          |
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

    self.isVisible = true;
    self.selectedCharacter = nil;
    self.points = 0;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(490);
    Window:EnableResize(false);
    Window.statustext:GetParent():Show(); -- Explicitely show the statustext bar
    Window:SetCallback("OnClose", function()
       self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("StackedRollOverview"));

    local importedAt = GL:tableGet(DB.StackedRoll, "MetaData.importedAt", GetServerTime());
    if (GL:higherThanZero(importedAt)) then
        Window:SetStatusText(string.format(
            "Imported on |c00a79eff%s|r at |c00a79eff%s|r",
            date('%Y-%m-%d', importedAt),
            date('%H:%M', importedAt)
        ));
    end

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_STACKEDROLL_OVERVIEW_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_STACKEDROLL_OVERVIEW_WINDOW");

    --[[
        SHARE BUTTON
    ]]
    local ShareButton = GL.UI:createShareButton(
            Window.frame,
            function ()
                GL.Interface.Dialogs.PopupDialog:open("BROADCAST_SOFTRES_CONFIRMATION");
            end,
            "Broadcast Data",
            "To broadcast you need to be in a group and need master loot, assist or lead!"
    );
    GL.Interface:setItem(self, "ShareButton", ShareButton);
    ShareButton:Show();

    --[[
        FIRST COLUMN (character table / hard reserve counter)
    ]]
    local DataColumn = AceGUI:Create("SimpleGroup");
    DataColumn:SetLayout("FLOW")
    DataColumn:SetFullWidth(true);
    DataColumn:SetHeight(350);
    Window:AddChild(DataColumn);

    local DataColumnVerticalSpacer = AceGUI:Create("SimpleGroup");
    DataColumnVerticalSpacer:SetLayout("FILL")
    DataColumnVerticalSpacer:SetFullWidth(true);
    DataColumnVerticalSpacer:SetHeight(294);
    DataColumn:AddChild(DataColumnVerticalSpacer);

    local HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL")
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Window:AddChild(HorizontalSpacer);

    --[[
        PLAYER FRAME
    ]]
    local step = GL.Settings:get("StackedRoll.defaultStep", 10);

    local PlayerFrame = AceGUI:Create("SimpleGroup");
    PlayerFrame:SetLayout("FLOW")
    PlayerFrame:SetFullWidth(true);
    PlayerFrame:SetHeight(20);
    Window:AddChild(PlayerFrame);

    local PlayerNameLabel = AceGUI:Create("Label");
    PlayerNameLabel:SetFontObject(_G["GameFontNormal"]);
    PlayerNameLabel:SetWidth(100);
    PlayerNameLabel:SetJustifyH("LEFT");
    PlayerNameLabel:SetText(string.format(
            "|cff%s%s|r",
            GL:classHexColor(), "None"
        ));
    PlayerFrame:AddChild(PlayerNameLabel);
    GL.Interface:setItem(self, "PlayerName", PlayerNameLabel);

    local DecrementButton = AceGUI:Create("Button");
    DecrementButton:SetText("-"..step);
    DecrementButton:SetWidth(60);
    DecrementButton:SetHeight(20);
    DecrementButton:SetCallback("OnClick", function()
        self:updatePoints(self.points - step, true);
    end);
    PlayerFrame:AddChild(DecrementButton);

    local StackedRollCurrentPoints = GL.AceGUI:Create("EditBox");
    StackedRollCurrentPoints:DisableButton(true);
    StackedRollCurrentPoints:SetHeight(20);
    StackedRollCurrentPoints:SetWidth(100);
    StackedRollCurrentPoints:SetText(100);
    StackedRollCurrentPoints:SetCallback("OnTextChanged", function (widget)
        local value = GL.StackedRoll:toPoints(strtrim(widget:GetText()));

        if not value then
            return;
        end

        -- Update
        self:updatePoints(value, false);
    end);
    PlayerFrame:AddChild(StackedRollCurrentPoints);
    GL.Interface:setItem(self, "CurrentPoints", StackedRollCurrentPoints);

    local IncrementButton = AceGUI:Create("Button");
    IncrementButton:SetText("+"..step);
    IncrementButton:SetWidth(60);
    IncrementButton:SetHeight(20);
    IncrementButton:SetCallback("OnClick", function()
        self:updatePoints(self.points + step, true);
    end);
    PlayerFrame:AddChild(IncrementButton);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL")
    HorizontalSpacer:SetWidth(15);
    HorizontalSpacer:SetHeight(20);
    PlayerFrame:AddChild(HorizontalSpacer);

    local DeleteButton = AceGUI:Create("Button");
    DeleteButton:SetText("Delete entry");
    DeleteButton:SetWidth(120);
    DeleteButton:SetCallback("OnClick", function()
        self:deleteEntry();
    end);
    PlayerFrame:AddChild(DeleteButton);

    local AliasesFrame = AceGUI:Create("SimpleGroup");
    AliasesFrame:SetLayout("FLOW")
    AliasesFrame:SetFullWidth(true);
    AliasesFrame:SetHeight(20);
    Window:AddChild(AliasesFrame);

    local AliasesLabel = AceGUI:Create("Label");
    AliasesLabel:SetFontObject(_G["GameFontNormalSmall"]);
    AliasesLabel:SetWidth(100);
    AliasesLabel:SetJustifyH("RIGHT");
    AliasesLabel:SetText("Aliases: ");
    AliasesFrame:AddChild(AliasesLabel);

    local AliasesEditBox = GL.AceGUI:Create("EditBox");
    AliasesEditBox:DisableButton(true);
    AliasesEditBox:SetHeight(20);
    AliasesEditBox:SetWidth(220);
    AliasesEditBox:SetText("Test");
    AliasesEditBox:SetCallback("OnTextChanged", function (widget)
        -- Update
        self:updateAliases(strtrim(widget:GetText()));
    end);
    AliasesFrame:AddChild(AliasesEditBox);
    GL.Interface:setItem(self, "Aliases", AliasesEditBox);

    local VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(15);
    Window:AddChild(VerticalSpacer);

    --[[
        BUTTONS FRAME
    ]]
    local ButtonFrame = AceGUI:Create("SimpleGroup");
    ButtonFrame:SetLayout("FLOW")
    ButtonFrame:SetFullWidth(true);
    Window:AddChild(ButtonFrame);

    local ClearDataButton = AceGUI:Create("Button");
    ClearDataButton:SetText("Clear Data");
    ClearDataButton:SetWidth(102);
    ClearDataButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open("CLEAR_STACKEDROLL_CONFIRMATION");
    end);
    ButtonFrame:AddChild(ClearDataButton);

    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText("Import");
    ImportButton:SetWidth(80);
    ImportButton:SetCallback("OnClick", function()
        self:close();
        GL.Interface.StackedRoll.Importer:draw();
    end);
    ButtonFrame:AddChild(ImportButton);

    local ExportButton = AceGUI:Create("Button");
    ExportButton:SetText("Export");
    ExportButton:SetWidth(80);
    ExportButton:SetCallback("OnClick", function()
        StackedRoll:export();
    end);
    ButtonFrame:AddChild(ExportButton);

    local AddRaidersButton = AceGUI:Create("Button");
    AddRaidersButton:SetText("Add missing raiders");
    AddRaidersButton:SetWidth(165);
    AddRaidersButton:SetCallback("OnClick", function()
        StackedRoll:addMissingRaiders();
        self:refreshTable();
    end);
    ButtonFrame:AddChild(AddRaidersButton);

    self:drawCharacterTable(DataColumn.frame);
end

function Overview:drawCharacterTable(Parent)
    GL:debug("Overview:drawCharacterTable");

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
            name = "Points",
            width = 45,
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
            name = "Reserve",
            width = 52,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1
            },
            colorargs = nil,
            sort = Constants.ScrollingTable.descending,
            sortnext = 1,
        },
        {
            name = "Aliases",
            width = 302,
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

    local Table = ScrollingTable:CreateST(columns, 14, 20, nil, Parent);
    Table:EnableSelection(true);
    Table:SetWidth(530);
    Table.frame:SetPoint("TOPLEFT", Parent, "TOPLEFT", 0, -18);

    Table:RegisterEvents({
        OnClick = function (_, _, data, _, _, realrow, _, tbl, button)
            if (button == "LeftButton") then
                --- Unfortunately, the default handler is called *after* ours.
                --- So, we need to check whether the selection is cleared ourselves!
                local cleared = tbl:GetSelection() == realrow;
                    
                --- Make sure something is actually selected, better safe than lua error
                if (cleared
                    or not GL:higherThanZero(realrow)
                    or type(data) ~= "table"
                    or not data[realrow]
                    or not data[realrow].cols
                    or not data[realrow].cols[1]
                ) then
                    self.selectedCharacter = nil;
                    self:loadPlayer();
                    return;
                end

                -- We always select the first column of the selected row because that contains the player name
                local selected = data[realrow].cols[1].value;

                if (selected and type(selected) == "string") then
                    self.selectedCharacter = string.lower(selected);
                    self:loadPlayer();
                end
            end
        end
    });

    GL.Interface:setItem(self, "Characters", Table);
    self:refreshTable();
end

---@return void
function Overview:refreshTable()
    local Table = GL.Interface:getItem(self, "Table.Characters");
    if (not Table) then
        return;
    end

    local PlayerData = {};

    -- We can't do a direct assignment because we want to edit this table in a bit
    for playerName, Entry in pairs(StackedRoll.MaterializedData.DetailsByPlayerName) do
        -- Augment with existing class data
        local class = nil;
        if (PlayerData[playerName]) then
            class = PlayerData[playerName].class;
        end

        PlayerData[playerName] = Entry;

        if (type(class) == "string") then
            PlayerData[playerName].class = class;
        else
            PlayerData[playerName].class = GL.Player:classByName(playerName);
        end
    end

    local TableData = {};

    for playerName, Entry in pairs(PlayerData) do
        local rollPoints = StackedRoll:rollPoints(Entry.points);
        local reserve = StackedRoll:reserve(Entry.points);
        local aliases = {};
        for _, aliasName in pairs(Entry.Aliases) do
            tinsert(aliases, GL:capitalize(aliasName));
        end
        aliases = table.concat(aliases, ",");

        local StackedRollColor = {r=0,g=1,b=0,a=1};

        tinsert(TableData, {
            cols = {
                {
                    value = GL:capitalize(playerName),
                    color = GL:classRGBAColor(Entry.class),
                },
                {
                    value = tostring(rollPoints),
                    color = StackedRollColor,
                },
                {
                    value = tostring(reserve),
                    color = StackedRollColor,
                },
                {
                    value = aliases,
                    color = {r=1,g=1,b=1,a=1},
                },
            },
        });
    end

    Table:SetData(TableData);
end

---@return void
function Overview:deleteEntry()
    GL:debug("Overview:deleteEntry");

    if (not self.selectedCharacter) then
        GL:warning("You need to select a player first");
        return;
    end

    StackedRoll:deletePoints(self.selectedCharacter);
    self:refreshTable();
    self.selectedCharacter = nil;
    self:loadPlayer();
end

---@param points number 
---@return void
function Overview:updatePoints(points, updateEditBox)
    GL:debug("Overview:updatePoints");

    if (not self.selectedCharacter) then
        GL:warning("You need to select a player first");
        return;
    end

    GL:warning(self.selectedCharacter);

    self.points = points;

    -- Update points locally.
    StackedRoll:setPoints(self.selectedCharacter, points);

    -- Update interface.
    if updateEditBox then
        GL.Interface:getItem(self, "EditBox.CurrentPoints"):SetText(points);
    end

    local Table = GL.Interface:getItem(self, "Table.Characters");
    if (Table) then
        local rollPoints = StackedRoll:rollPoints(points);
        local reserve = StackedRoll:reserve(points);
        Table:GetRow(Table:GetSelection()).cols[2].value = tostring(rollPoints);
        Table:GetRow(Table:GetSelection()).cols[3].value = tostring(reserve);
        Table:Refresh();
    end
end

---@param aliases string 
---@return void
function Overview:updateAliases(aliases)
    GL:debug("Overview:updateAliases");

    if (not self.selectedCharacter) then
        GL:warning("You need to select a player first");
        return;
    end

    local Segments = GL:separateValues(aliases);

    --- Import segments as aliases (twink names)
    local Aliases = {};
    for i = 1, #Segments do
        local alias = tostring(Segments[i]);
        alias = GL:normalizedName(alias);
        --- Only set non-empty aliases
        if (not GL:empty(alias)) then
            tinsert(Aliases, alias);
        end
    end
    StackedRoll:setAliases(self.selectedCharacter, Aliases);
    self:refreshTable();
end

---@return void
function Overview:loadPlayer()
    GL:debug("Overview:loadPlayer");

    -- Better be safe than getting a lua error
    local class = nil;
    local name = "None";
    local Aliases = {};
    if (not self.selectedCharacter
        or not StackedRoll.MaterializedData.DetailsByPlayerName[self.selectedCharacter]
    ) then
        self.points = 0;
    else
        self.points = StackedRoll:getPoints(self.selectedCharacter);
        class = StackedRoll.MaterializedData.DetailsByPlayerName[self.selectedCharacter].class;
        name = GL:capitalize(GL:stripRealm(self.selectedCharacter));
        Aliases = StackedRoll.MaterializedData.DetailsByPlayerName[self.selectedCharacter].Aliases;
    end
    
    GL.Interface:getItem(self, "EditBox.CurrentPoints"):SetText(self.points);
    GL.Interface:getItem(self, "Label.PlayerName"):SetText(string.format(
            "|cff%s%s|r",
            GL:classHexColor(class), name
    ));

    --- Aliases
    local aliases = {};
    for _, aliasName in pairs(Aliases) do
        tinsert(aliases, GL:capitalize(aliasName));
    end
    aliases = table.concat(aliases, ",");
    GL.Interface:getItem(self, "EditBox.Aliases"):SetText(aliases);
end

---@return void
function Overview:close()
    GL:debug("Overview:close");

    local Window = GL.Interface:getItem(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    -- Store the frame's last position for future play sessions
    GL.Interface:storePosition(Window, "StackedRollOverview");

    -- Clear the frame and its widgets
    AceGUI:Release(Window);
    self.isVisible = false;

    -- Clean up the Character table seperately
    local CharacterTable = GL.Interface:getItem(self, "Table.Characters");
    if (CharacterTable) then
        CharacterTable:SetData({}, true);
        CharacterTable:Hide();
    end
end

GL:debug("Interfaces/StackedRoll/Overview.lua");