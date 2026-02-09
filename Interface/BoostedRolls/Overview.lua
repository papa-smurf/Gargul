local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

local AceGUI = GL.AceGUI;
local Constants = GL.Data.Constants; ---@type Data
local DB = GL.DB; ---@type DB
local ScrollingTable = GL.ScrollingTable;
local BoostedRolls = GL.BoostedRolls; ---@type BoostedRolls

GL:tableSet(GL, "Interface.BoostedRolls.Overview", {
    isVisible = false,
    selectedCharacter = nil,
    points = 0,

    ShareButton = {},
    SettingsButton = {},
});

---@class BoostedRollsOverview
local Overview = GL.Interface.BoostedRolls.Overview;

--- Draw the UI elements required to show an overview of all boosted rolls data
--- This is what this frame looks like:
---     +-----------------+
---     | Points          |
---     +-----------------+
---     | Button Frame    |
---     +-----------------+
---
function Overview:draw()
    -- The overview is already visible
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;
    self.selectedCharacter = nil;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(540);
    Window:EnableResize(false);
    Window.statustext:GetParent():Show(); -- Explicitly show the statustext bar
    Window:SetCallback("OnClose", function ()
       self:close();
    end);
    GL.Interface:set(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("BoostedRollsOverview"));

    local importedAt = GL:tableGet(DB.BoostedRolls, "MetaData.importedAt", GetServerTime());
    local updatedAt = GL:tableGet(DB.BoostedRolls, "MetaData.updatedAt", GetServerTime());
    if (GL:higherThanZero(importedAt)) then
        Window:SetStatusText((L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"]):format(
            date(L["%Y-%m-%d"], importedAt),
            date(L["%H:%M"], importedAt),
            date(L["%Y-%m-%d"], updatedAt),
            date(L["%H:%M"], updatedAt)
        ));
    end

    -- Make sure the window can be closed by pressing the escape button
    _G.GARGUL_BOOSTEDROLLS_OVERVIEW_WINDOW = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_BOOSTEDROLLS_OVERVIEW_WINDOW");

    --[[
        SHARE BUTTON
    ]]
    local ShareButton = GL.Interface:createShareButton(Window, {
        onClick = function ()
            GL.Interface.Dialogs.PopupDialog:open({
                question = L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"],
                OnYes = function ()
                    GL.BoostedRolls:broadcast();
                end,
            });
        end,
        tooltip = L["Broadcast"],
        disabledTooltip = L["You need to be the master looter or have an assist / lead role!"],
        position = "TOPRIGHT",
    });
    self.ShareButton = ShareButton;
    ShareButton:Show();

    --[[
        SETTINGS BUTTON
    ]]
    local SettingsButton = GL.UI:createSettingsButton(
        Window.frame,
        "BoostedRolls"
    );
    self.SettingsButton = SettingsButton;

    local HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL")
    HorizontalSpacer:SetWidth(500);
    HorizontalSpacer:SetHeight(16);
    Window:AddChild(HorizontalSpacer);

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

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL")
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Window:AddChild(HorizontalSpacer);

    --[[
        PLAYER FRAME
    ]]
    local step = GL.Settings:get("BoostedRolls.defaultStep", 10);

    local PlayerFrame = AceGUI:Create("SimpleGroup");
    PlayerFrame:SetLayout("FLOW")
    PlayerFrame:SetFullWidth(true);
    PlayerFrame:SetHeight(20);
    Window:AddChild(PlayerFrame);

    local PlayerNameLabel = AceGUI:Create("Label");
    PlayerNameLabel:SetFontObject(_G.GameFontNormal);
    PlayerNameLabel:SetWidth(100);
    PlayerNameLabel:SetJustifyH("LEFT");
    PlayerNameLabel:SetText(("|cff%s%s|r"):format(GL:classHexColor(), L["None"]));
    PlayerFrame:AddChild(PlayerNameLabel);
    GL.Interface:set(self, "PlayerName", PlayerNameLabel);

    local DecrementButton = AceGUI:Create("Button");
    DecrementButton:SetText(L["-"] .. step);
    DecrementButton:SetWidth(60);
    DecrementButton:SetHeight(20);
    DecrementButton:SetCallback("OnClick", function ()
        self:adjustPoints(step * -1, true);
    end);
    PlayerFrame:AddChild(DecrementButton);

    local BoostedRollsCurrentPoints = GL.AceGUI:Create("EditBox");
    BoostedRollsCurrentPoints:DisableButton(true);
    BoostedRollsCurrentPoints:SetHeight(22);
    BoostedRollsCurrentPoints:SetWidth(106);
    BoostedRollsCurrentPoints:SetCallback("OnTextChanged", function (widget)
        local value = GL.BoostedRolls:toPoints(strtrim(widget:GetText()));

        if (not value) then
            return;
        end

        -- Update
        self:setPoints(value, false);
    end);
    PlayerFrame:AddChild(BoostedRollsCurrentPoints);
    GL.Interface:set(self, "CurrentPoints", BoostedRollsCurrentPoints);

    local IncrementButton = AceGUI:Create("Button");
    IncrementButton:SetText(L["+"] .. step);
    IncrementButton:SetWidth(60);
    IncrementButton:SetHeight(20);
    IncrementButton:SetCallback("OnClick", function ()
        self:adjustPoints(step, true);
    end);
    PlayerFrame:AddChild(IncrementButton);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL")
    HorizontalSpacer:SetWidth(15);
    HorizontalSpacer:SetHeight(20);
    PlayerFrame:AddChild(HorizontalSpacer);

    local DeleteButton = AceGUI:Create("Button");
    DeleteButton:SetText(L["Delete"]);
    DeleteButton:SetWidth(120);
    DeleteButton:SetCallback("OnClick", function ()
        self:deleteEntry();
    end);
    PlayerFrame:AddChild(DeleteButton);

    local AliasesFrame = AceGUI:Create("SimpleGroup");
    AliasesFrame:SetLayout("FLOW")
    AliasesFrame:SetFullWidth(true);
    AliasesFrame:SetHeight(20);
    Window:AddChild(AliasesFrame);

    local AliasesLabel = AceGUI:Create("Label");
    AliasesLabel:SetFontObject(_G.GameFontNormalSmall);
    AliasesLabel:SetWidth(46);
    AliasesLabel:SetJustifyH("RIGHT");
    AliasesLabel:SetText(L["Aliases"]);
    AliasesFrame:AddChild(AliasesLabel);

    local AliasesEditBox = GL.AceGUI:Create("EditBox");
    AliasesEditBox:DisableButton(true);
    AliasesEditBox:SetHeight(20);
    AliasesEditBox:SetWidth(280);
    AliasesFrame:AddChild(AliasesEditBox);
    GL.Interface:set(self, "Aliases", AliasesEditBox);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL")
    HorizontalSpacer:SetWidth(15);
    HorizontalSpacer:SetHeight(20);
    AliasesFrame:AddChild(HorizontalSpacer);

    local ApplyAliasesButton = AceGUI:Create("Button");
    ApplyAliasesButton:SetText(L["Apply aliases"]);
    ApplyAliasesButton:SetWidth(120);
    ApplyAliasesButton:SetCallback("OnClick", function ()
        local text = GL.Interface:get(self, "EditBox.Aliases"):GetText();
        self:updateAliases(strtrim(text));
    end);
    AliasesFrame:AddChild(ApplyAliasesButton);

    local ProgressFrame = AceGUI:Create("SimpleGroup");
    ProgressFrame:SetLayout("FILL")
    ProgressFrame:SetFullWidth(true);
    ProgressFrame:SetHeight(35);
    Window:AddChild(ProgressFrame);

    local BroadcastProgressLabel = AceGUI:Create("Label");
    BroadcastProgressLabel:SetWidth(200);
    BroadcastProgressLabel:SetFontObject(_G.GameFontNormal);
    ProgressFrame:AddChild(BroadcastProgressLabel);
    GL.Interface:set(GL.BoostedRolls, "BroadcastProgress", BroadcastProgressLabel);

    --[[
        BUTTONS FRAME
    ]]
    --local VerticalSpacer = AceGUI:Create("SimpleGroup");
    --VerticalSpacer:SetLayout("FILL");
    --VerticalSpacer:SetFullWidth(true);
    --VerticalSpacer:SetHeight(15);
    --Window:AddChild(VerticalSpacer);

    local ButtonFrame = AceGUI:Create("SimpleGroup");
    ButtonFrame:SetLayout("FLOW")
    ButtonFrame:SetFullWidth(true);
    Window:AddChild(ButtonFrame);

    local ClearDataButton = AceGUI:Create("Button");
    ClearDataButton:SetText(L["Clear"]);
    ClearDataButton:SetWidth(102);
    ClearDataButton:SetCallback("OnClick", function ()
        GL.Interface.Dialogs.PopupDialog:open({
            question = L["Are you sure you want to clear all boosted roll data?"],
            OnYes = function ()
                GL.Interface.BoostedRolls.Overview:close();
                GL.BoostedRolls:clear();
                GL.BoostedRolls:draw();
            end,
        });
    end);
    ButtonFrame:AddChild(ClearDataButton);

    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText(L["Import"]);
    ImportButton:SetWidth(78);
    ImportButton:SetCallback("OnClick", function ()
        self:close();
        GL.Interface.BoostedRolls.Importer:draw();
    end);
    ButtonFrame:AddChild(ImportButton);

    local ExportButton = AceGUI:Create("Button");
    ExportButton:SetText(L["Export"]);
    ExportButton:SetWidth(76);
    ExportButton:SetCallback("OnClick", function ()
        BoostedRolls:export(true);
    end);
    ButtonFrame:AddChild(ExportButton);

    local AddRaidersButton = AceGUI:Create("Button");
    AddRaidersButton:SetText(L["Add missing raiders"]);
    AddRaidersButton:SetWidth(156);
    AddRaidersButton:SetCallback("OnClick", function ()
        BoostedRolls:addMissingRaiders();
        self:refreshTable();
    end);
    ButtonFrame:AddChild(AddRaidersButton);

    local AddToRaid = AceGUI:Create("Button");
    AddToRaid:SetText(L["Add points to raid"]);
    AddToRaid:SetWidth(140);
    AddToRaid:SetCallback("OnClick", function ()
        GL.Interface.Dialogs.ConfirmWithSingleInputDialog:open({
            question = L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"],
            inputValue = step,
            OnYes = function (value)
                value = tonumber(value) or 0;

                if (value < 1) then
                    GL:error(L["No point value provided!"]);
                    return;
                end

                GL:forEachGroupMember(function (Member)
                    local BRGUID = BoostedRolls:playerGUID(Member.name, Member.realm);

                    if (BoostedRolls:hasPoints(BRGUID)) then
                        BoostedRolls:addPoints(BRGUID, value);
                    end
                end);

                self:refreshTable();
            end,
            focus = true,
        });
    end);
    ButtonFrame:AddChild(AddToRaid);

    self:drawBoostedRollDataTable(DataColumn.frame);

    self:updateShareButton();

    GL.Events:register("BoostedRollsShareButtonRosterUpdatedListener", "GROUP_ROSTER_UPDATE", function () self:updateShareButton(); end);
    GL.Events:register("BoostedRollsBroadcastStartedListener", "GL.BOOSTEDROLLS_BROADCAST_STARTED", function () self:updateShareButton(); end);
    GL.Events:register("BoostedRollsBroadcastEndedListener", "GL.BOOSTEDROLLS_BROADCAST_ENDED", function () self:updateShareButton(); end);

end

--- Update the share button when the group setup changes
---
function Overview:updateShareButton()
    local ShareButton = self.ShareButton;

    if (not ShareButton) then
        return;
    end

    GL.Ace:ScheduleTimer(function ()
        -- The user doesn't have sufficient permissions to broadcast the data
        -- Or a broadcast is already in process
        if (GL.BoostedRolls.broadcastInProgress
                or not GL.BoostedRolls:userIsAllowedToBroadcast()
        ) then
            ShareButton:Disable();
            return;
        end

        ShareButton:Enable();
    end, 1.5);
end

function Overview:drawBoostedRollDataTable(Parent)
    local columns = {
        {
            name = L["Player"],
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
            name = L["Points"],
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
            name = L["Reserve"],
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
            name = L["Aliases"],
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
                    self.selectedCharacter = strlower(GL:addRealm(selected));
                    self:loadPlayer();
                end
            end
        end
    });

    GL.Interface:set(self, "Characters", Table);
    self:refreshTable();
end

function Overview:refreshTable()
    local Table = GL.Interface:get(self, "Table.Characters");
    if (not Table) then
        return;
    end

    local PlayerData = {};

    -- We can't do a direct assignment because we want to edit this table in a bit
    for playerName, Entry in pairs(BoostedRolls.MaterializedData.DetailsByPlayerName) do
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
        local rollPoints = BoostedRolls:rollPoints(Entry.points);
        local reserve = BoostedRolls:reserve(Entry.points);
        local aliases = {};
        for _, aliasName in pairs(Entry.Aliases) do
            tinsert(aliases, GL:formatPlayerName(aliasName));
        end
        aliases = table.concat(aliases, ",");

        local BoostedRollsColor = { r = 0, g = 1, b = 0, a = 1, };

        tinsert(TableData, {
            cols = {
                {
                    value = GL:formatPlayerName(playerName),
                    color = GL:classRGBAColor(Entry.class),
                },
                {
                    value = rollPoints,
                    color = BoostedRollsColor,
                },
                {
                    value = reserve,
                    color = BoostedRollsColor,
                },
                {
                    value = aliases,
                    color = { r = 1, g = 1, b = 1, a = 1, },
                },
            },
        });
    end

    Table:SetData(TableData);
    Table:SortData();
end

function Overview:deleteEntry()
    if (not self.selectedCharacter) then
        GL:warning(L["You need to select a player first"]);
        return;
    end

    return GL.Interface.Dialogs.PopupDialog:open({
        question = (L["Delete %s?"]):format(GL:formatPlayerName(self.selectedCharacter, { colorize = true, })),
        OnYes = function ()
            BoostedRolls:deletePoints(self.selectedCharacter);
            self:refreshTable();
            self.selectedCharacter = nil;
            self:loadPlayer();
        end,
    });
end

---@param points number
---@param updateEditBox? boolean
function Overview:setPoints(points, updateEditBox)
    if (not self.selectedCharacter) then
        GL:warning(L["You need to select a player first"]);
        return;
    end

    points = BoostedRolls:setPoints(self.selectedCharacter, points, not GL.User.isIngroup);

    if (updateEditBox) then
        GL.Interface:get(self, "EditBox.CurrentPoints"):SetText(points);
    end

    self:refreshTable();
end

---@param points number
---@param updateEditBox? boolean
function Overview:adjustPoints(points, updateEditBox)
    if (not self.selectedCharacter) then
        GL:warning(L["You need to select a player first"]);
        return;
    end

    points = BoostedRolls:addPoints(self.selectedCharacter, points);

    if (updateEditBox) then
        GL.Interface:get(self, "EditBox.CurrentPoints"):SetText(points);
    end
end

---@param aliases string
function Overview:updateAliases(aliases)
    if (not self.selectedCharacter) then
        GL:warning(L["You need to select a player first"]);
        return;
    end

    local Segments = GL:separateValues(aliases);
    local _, mainRealm = GL:stripRealm(self.selectedCharacter);

    --- Import segments as aliases (alts)
    local Aliases = {};
    for i = 1, #Segments do
        local alias = tostring(Segments[i]);

        -- If no realm is specified assume same realm as main
        alias = GL:addRealm(alias, mainRealm);
        --- Only set non-empty aliases
        if (not GL:empty(alias)) then
            tinsert(Aliases, strlower(alias));
        end
    end
    BoostedRolls:setAliases(self.selectedCharacter, Aliases);
    self:refreshTable();
end

function Overview:loadPlayer()
    -- Better be safe than getting a lua error
    local class = nil;
    local name = L["None"];
    local Aliases = {};

    if (self.selectedCharacter
        and BoostedRolls.MaterializedData.DetailsByPlayerName[self.selectedCharacter]
    ) then
        class = BoostedRolls.MaterializedData.DetailsByPlayerName[self.selectedCharacter].class;
        name = GL:formatPlayerName(self.selectedCharacter, { includeRealm = "never", });
        Aliases = BoostedRolls.MaterializedData.DetailsByPlayerName[self.selectedCharacter].Aliases;
    end

    GL.Interface:get(self, "EditBox.CurrentPoints"):SetText(BoostedRolls:getPoints(self.selectedCharacter));
    GL.Interface:get(self, "Label.PlayerName"):SetText(GL:formatPlayerName(name, { colorize = true, }));

    --- Aliases
    local aliases = {};
    for _, aliasName in pairs(Aliases) do
        tinsert(aliases, GL:capitalize(aliasName));
    end
    aliases = table.concat(aliases, ",");
    GL.Interface:get(self, "EditBox.Aliases"):SetText(aliases);
end

function Overview:close()
    local Window = GL.Interface:get(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    -- Store the frame's last position for future play sessions
    GL.Interface:storePosition(Window, "BoostedRollsOverview");

    -- Clear the frame and its widgets
    GL.Interface:release(Window);
    self.isVisible = false;

    -- Clean up the Character table separately
    local CharacterTable = GL.Interface:get(self, "Table.Characters");
    if (CharacterTable) then
        CharacterTable:SetData({}, true);
        CharacterTable:Hide();
    end

    if (self.ShareButton) then
        self.ShareButton:Hide();
        self.ShareButton = nil;
    end

    if (self.SettingsButton) then
        self.SettingsButton:Hide();
        self.SettingsButton = nil;
    end
end
