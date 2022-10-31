---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

local AceGUI = GL.AceGUI;

---@class PlayerSelectorInterface
GL.Interface.PlayerSelector = {
    isVisible = false,
};
local PlayerSelector = GL.Interface.PlayerSelector; ---@type PlayerSelectorInterface
local ScrollingTable = GL.ScrollingTable;

---@param description string
---@param PlayerNames string|table
---@param callback function
---@return void
function PlayerSelector:draw(description, PlayerNames, callback)
    GL:debug("PlayerSelector:draw");

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("FLOW");
    Window:SetWidth(430);
    Window:SetHeight(282);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window:SetPoint(GL.Interface:getPosition("PlayerSelector"));
    GL.Interface:setItem(self, "Window", Window);

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_PLAYER_SELECTOR_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_PLAYER_SELECTOR_WINDOW");

    local DescriptionFrame = AceGUI:Create("SimpleGroup");
    DescriptionFrame:SetLayout("FILL");
    DescriptionFrame:SetFullWidth(true);
    DescriptionFrame:SetHeight(25);
    Window:AddChild(DescriptionFrame);

    local Description = AceGUI:Create("Label");
    Description:SetFontObject(_G["GameFontNormal"]);
    Description:SetFullWidth(true);
    Description:SetJustifyH("CENTER");
    Description:SetText("\n" .. description);
    DescriptionFrame:AddChild(Description);

    --[[
        SECOND ROW (player name box)
    ]]

    local SecondRow = AceGUI:Create("SimpleGroup");
    SecondRow:SetLayout("Flow");
    SecondRow:SetFullWidth(true);
    SecondRow:SetHeight(24);
    Window:AddChild(SecondRow);

    local Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Fill");
    Spacer:SetWidth(18);
    Spacer:SetHeight(20);
    SecondRow:AddChild(Spacer);

    local PlayerNameLabel = AceGUI:Create("Label");
    PlayerNameLabel:SetText("Type player name here");
    PlayerNameLabel:SetHeight(20);
    PlayerNameLabel:SetWidth(128); -- Minimum is 122
    SecondRow:AddChild(PlayerNameLabel);

    local ConfirmButton;
    local PlayerNameBox = AceGUI:Create("EditBox");
    PlayerNameBox:SetHeight(20);
    PlayerNameBox:SetWidth(120);
    PlayerNameBox:SetCallback("OnEnterPressed", function ()
        local player = PlayerNameBox:GetText();

        if (not GL:empty(player)) then
            callback(player);
        end
    end); -- Award
    PlayerNameBox:SetFocus();
    SecondRow:AddChild(PlayerNameBox);
    GL.Interface:setItem(self, "PlayerName", PlayerNameBox);

    Spacer = AceGUI:Create("SimpleGroup");
    Spacer:SetLayout("Fill");
    Spacer:SetWidth(6);
    Spacer:SetHeight(20);
    SecondRow:AddChild(Spacer);

    local PlayerNameLabelSuffix = AceGUI:Create("Label");
    PlayerNameLabelSuffix:SetText("or select one below");
    PlayerNameLabelSuffix:SetHeight(20);
    PlayerNameLabelSuffix:SetWidth(104); -- Minimum is 104
    SecondRow:AddChild(PlayerNameLabelSuffix);

    local TableFrame = GL.AceGUI:Create("SimpleGroup");
    TableFrame:SetLayout("FILL");
    TableFrame:SetFullWidth(true);
    TableFrame:SetHeight(156);
    Window:AddChild(TableFrame);

    ConfirmButton = AceGUI:Create("Button");
    ConfirmButton:SetText("Confirm");
    ConfirmButton:SetWidth(140);
    ConfirmButton:SetHeight(20);
    ConfirmButton:SetCallback("OnClick", function()
        local PlayersTable = GL.Interface:getItem(self, "Table.Players");
        local selected = PlayersTable:GetRow(PlayersTable:GetSelection());

        if (not selected or type(selected) ~= "table") then
            return;
        end

        local player = selected.cols[1].value;

        callback(player);
    end);

    Window:AddChild(ConfirmButton);

    if (type(PlayerNames) ~= "table") then
        PlayerNames = { PlayerNames };
    end

    self:drawPlayersTable(TableFrame.frame, PlayerNames);
end

---@return void
function PlayerSelector:close()
    GL:debug("PlayerSelector:close");

    local Window = GL.Interface:getItem(self, "Window");

    if (not Window) then
        return;
    end

    GL.Interface:storePosition(Window, "PlayerSelector");
    local PlayersTable = GL.Interface:getItem(self, "Table.Players");
    PlayersTable:ClearSelection();
    PlayersTable:SetData({}, true);
    PlayersTable:Hide();
    Window:Hide();

    self.isVisible = false;
end

---@param Parent table
---@param PlayerNames table
---@return void
function PlayerSelector:drawPlayersTable(Parent, PlayerNames)
    GL:debug("PlayerSelector:drawPlayersTable");

    -- Combined width of all colums should be 340
    local columns = {
        {
            name = "",
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

    local TableRows = {};
    for _, Player in pairs(GL.User:groupMembers()) do
        local realmFreeMemberName = string.lower(GL:stripRealm(Player.name));

        for _, playerName in pairs(PlayerNames) do
            local realmFreePlayerName = string.lower(GL:stripRealm(playerName));

            if (realmFreeMemberName == realmFreePlayerName) then
                tinsert(TableRows, {
                    cols = {
                        {
                            value = Player.name,
                            color = GL:classRGBAColor(Player.class),
                        },
                    },
                });
            end
        end
    end

    local Table = ScrollingTable:CreateST(columns, 8, 15, nil, Parent);
    Table:EnableSelection(true);
    Table.frame:SetPoint("BOTTOM", Parent, "BOTTOM", 0, 10);
    Table:SetData(TableRows);
    GL.Interface:setItem(self, "Players", Table);

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

            local selectedPlayer = data[realrow].cols[1].value;
            local EditBox = GL.Interface:getItem(self, "EditBox.PlayerName");

            if (EditBox and EditBox.SetText) then
                EditBox:SetText(GL:capitalize(selectedPlayer));
            end
        end
    });
end

GL:debug("Interfaces/PlayerSelector.lua");