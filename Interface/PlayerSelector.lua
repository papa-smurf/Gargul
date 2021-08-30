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
    Window:SetHeight(290);
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

    --[[
        FIRST ROW (ITEM AND BUTTONS)
    ]]
    local Description = AceGUI:Create("Label");
    Description:SetFontObject(_G["GameFontNormal"]);
    Description:SetFullWidth(true);
    Description:SetText(description);
    Window:AddChild(Description);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(184);
    Window:AddChild(HorizontalSpacer);

    local AwardButton = AceGUI:Create("Button");
    AwardButton:SetText("Award");
    AwardButton:SetWidth(70);
    AwardButton:SetHeight(20);
    AwardButton:SetCallback("OnClick", function()
        local PlayersTable = GL.Interface:getItem(self, "Table.Players");
        local selected = PlayersTable:GetRow(PlayersTable:GetSelection());

        if (not selected or type(selected) ~= "table") then
            return;
        end

        local player = selected.cols[1].value;

        callback(player);
    end);
    Window:AddChild(AwardButton);

    if (type(PlayerNames) ~= "table") then
        PlayerNames = { PlayerNames };
    end

    self:drawPlayersTable(Window.frame, PlayerNames);
end

---@return void
function PlayerSelector:close()
    GL:debug("PlayerSelector:close");

    local Window = GL.Interface:getItem(self, "Window");

    GL.Interface:storePosition(Window, "PlayerSelector");
    local PlayersTable = GL.Interface:getItem(self, "Table.Players");
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
            name = "Player",
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
        local realmFreeMemberName = GL:stripRealm(Player.name);

        for _, playerName in pairs(PlayerNames) do
            local realmFreePlayerName = GL:stripRealm(playerName);

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
    Table.frame:SetPoint("BOTTOM", Parent, "BOTTOM", 0, 60);
    Table:SetData(TableRows);
    GL.Interface:setItem(self, "Players", Table);
end

GL:debug("Interfaces/PlayerSelector.lua");