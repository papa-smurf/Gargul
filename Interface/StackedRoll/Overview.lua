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

    Window:SetStatusText(string.format(
        "Imported on |c00a79eff%s|r at |c00a79eff%s|r",
        date('%Y-%m-%d', GL:tableGet(DB.StackedRoll, "MetaData.importedAt", GetServerTime())),
        date('%H:%M', GL:tableGet(DB.StackedRoll, "MetaData.importedAt", GetServerTime()))
    ));

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
            GL:classHexColor("paladin"), "Someone"
        ));
    PlayerFrame:AddChild(PlayerNameLabel);

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
    StackedRollCurrentPoints:SetCallback("OnEnterPressed", function (widget)
        local value = GL.StackedRoll:toPoints(strtrim(widget:GetText()));

        if not value then
            return;
        end

        -- Update
        self:updatePoints(value, true);
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
        self:updatePoints(self.points + step, true);
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
    AliasesFrame:AddChild(AliasesEditBox);

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
        if (self.selectedCharacter) then
            self:close();
            GL.Interface.Points:draw(self.selectedCharacter);
        end
    end);
    ButtonFrame:AddChild(ImportButton);

    local AddRaidersButton = AceGUI:Create("Button");
    AddRaidersButton:SetText("Add missing raiders");
    AddRaidersButton:SetWidth(165);
    AddRaidersButton:SetCallback("OnClick", function()
        if (self.selectedCharacter) then
            self:close();
            GL.Interface.Points:draw(self.selectedCharacter);
        end
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
        end
    });

    local PlayerData = {};
    local FqnNames = {};

    -- We can't do a direct assignment because we want to edit this table in a bit
    for playerName, Entry in pairs(StackedRoll.MaterializedData.DetailsByPlayerName) do

        if (GL.isEra) then
            playerName = GL:tableGet(FqnNames, string.lower(playerName) .. "." .. Entry.class, playerName);
        end

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
    GL.Interface:setItem(self, "Characters", Table);
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