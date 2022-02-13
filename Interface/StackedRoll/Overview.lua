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
    Window:SetHeight(410);
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

    --[[
        BUTTONS FRAME
    ]]
    local ButtonFrame = AceGUI:Create("SimpleGroup");
    ButtonFrame:SetLayout("FLOW")
    ButtonFrame:SetFullWidth(true);
    Window:AddChild(ButtonFrame);

    local ModifyPointsButton = AceGUI:Create("Button");
    ModifyPointsButton:SetText("Modify Points");
    ModifyPointsButton:SetWidth(141); -- Minimum is 106
    ModifyPointsButton:SetCallback("OnClick", function()
        if (self.selectedCharacter) then
            self:close();
            GL.Interface.Points:draw(self.selectedCharacter);
        end
    end);
    ButtonFrame:AddChild(ModifyPointsButton);

    local ClearDataButton = AceGUI:Create("Button");
    ClearDataButton:SetText("Clear Data");
    ClearDataButton:SetWidth(141); -- Minimum is 102
    ClearDataButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open("CLEAR_STACKEDROLL_CONFIRMATION");
    end);
    ButtonFrame:AddChild(ClearDataButton);

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
            width = 262,
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
    Table:SetWidth(490);
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

    -- Go through everyone in the raid!
    if (GL.User.isInGroup) then
        for _, Player in pairs(GL.User:groupMembers()) do
            local playerName = string.lower(Player.name);

            if (GL.isEra and not strfind(playerName, "-")) then
                playerName = string.format("%s-%s", playerName, GL.User.realm);
            end

            PlayerData[playerName] = {
                class = Player.class,
                points = 0,
                Aliases = {},
            }

            if (GL.isEra) then
                GL:tableSet(FqnNames, GL:stripRealm(playerName) .. "." .. string.lower(Player.class), playerName);
            end
        end
    end

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
        local aliases = table.concat(Entry.Aliases, ",");

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