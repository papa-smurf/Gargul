---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

---@class PointsInterface
GL.Interface.Points = {
    isVisible = false,
    points = 0,
    playerName = nil,
};
local Points = GL.Interface.Points; ---@type PointsInterface
local StackedRoll = GL.StackedRoll; ---@type StackedRoll

---@return void
function Points:draw(playerName)
    GL:debug("Points:draw");

    if (self.isVisible or not playerName) then
        return;
    end

    self.isVisible = true;
    self.playerName = string.lower(playerName);
    self.points = StackedRoll:getPoints(playerName, 0);
    local points = self.points;
    local rollPoints = StackedRoll:rollPoints(points);
    local reserve = StackedRoll:reserve(points);

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul Update Points");
    Window:SetLayout("FLOW");
    Window:SetWidth(430);
    Window:SetHeight(180);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window:SetPoint(GL.Interface:getPosition("Points"));
    GL.Interface:setItem(self, "Window", Window);

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_POINTS_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_POINTS_WINDOW");

    local PrevDescriptionFrame = AceGUI:Create("SimpleGroup");
    PrevDescriptionFrame:SetLayout("FILL");
    PrevDescriptionFrame:SetFullWidth(true);
    PrevDescriptionFrame:SetHeight(25);
    Window:AddChild(PrevDescriptionFrame);

    local PrevDescription = AceGUI:Create("Label");
    PrevDescription:SetFontObject(_G["GameFontNormal"]);
    PrevDescription:SetFullWidth(true);
    PrevDescription:SetJustifyH("CENTER");
    if (not playerName) then
        PrevDescription:SetText(string.format(
            "Previous Points: |cff%s%s|r Previous Reserve: |cff%s%s|r",
            GL:classHexColor("paladin"), rollPoints, GL:classHexColor("paladin"), reserve
        ));
    else
        PrevDescription:SetText(string.format(
            "Player Name: |cff%s%s|r\nPrevious Points: |cff%s%s|r Previous Reserve: |cff%s%s|r",
            GL:classHexColor("paladin"), GL:capitalize(playerName), GL:classHexColor("paladin"), rollPoints, GL:classHexColor("paladin"), reserve
        ));
    end
    PrevDescriptionFrame:AddChild(PrevDescription);

    local UpdateFrame = AceGUI:Create("SimpleGroup");
    UpdateFrame:SetLayout("FLOW");
    UpdateFrame:SetFullWidth(true);
    UpdateFrame:SetHeight(25);
    Window:AddChild(UpdateFrame);

    local VerticalSpacer = AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetWidth(20);
    VerticalSpacer:SetHeight(20);
    UpdateFrame:AddChild(VerticalSpacer);

    local DecrementButton = AceGUI:Create("Button");
    DecrementButton:SetText("-10");
    DecrementButton:SetWidth(80);
    DecrementButton:SetHeight(20);
    DecrementButton:SetCallback("OnClick", function()
        self:updatePoints(self.points - 10, true);
    end);
    UpdateFrame:AddChild(DecrementButton);

    local StackedRollCurrentPoints = GL.AceGUI:Create("EditBox");
    StackedRollCurrentPoints:DisableButton(true);
    StackedRollCurrentPoints:SetHeight(20);
    StackedRollCurrentPoints:SetWidth(200);
    StackedRollCurrentPoints:SetText(points);
    StackedRollCurrentPoints:SetLabel(string.format(
        "|cff%sUpdated points:|r",
        GL:classHexColor("rogue")
    ));
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
    UpdateFrame:AddChild(StackedRollCurrentPoints);
    GL.Interface:setItem(self, "CurrentPoints", StackedRollCurrentPoints);

    local IncrementButton = AceGUI:Create("Button");
    IncrementButton:SetText("+10");
    IncrementButton:SetWidth(80);
    IncrementButton:SetHeight(20);
    IncrementButton:SetCallback("OnClick", function()
        self:updatePoints(self.points + 10, true);
    end);
    UpdateFrame:AddChild(IncrementButton);

    local DescriptionFrame = AceGUI:Create("SimpleGroup");
    DescriptionFrame:SetLayout("FILL");
    DescriptionFrame:SetFullWidth(true);
    DescriptionFrame:SetHeight(25);
    Window:AddChild(DescriptionFrame);

    local Description = AceGUI:Create("Label");
    Description:SetFontObject(_G["GameFontNormal"]);
    Description:SetFullWidth(true);
    Description:SetJustifyH("CENTER");
    Description:SetText(string.format(
        "Points: |cff%s%s|r Reserve: |cff%s%s|r",
        GL:classHexColor("rogue"), rollPoints, GL:classHexColor("rogue"), reserve
    ));
    DescriptionFrame:AddChild(Description);
    GL.Interface:setItem(self, "Description", Description);

    local ConfirmButton = AceGUI:Create("Button");
    ConfirmButton:SetText("Confirm");
    ConfirmButton:SetWidth(140);
    ConfirmButton:SetHeight(20);
    ConfirmButton:SetCallback("OnClick", function()
        GL.StackedRoll:setPoints(self.playerName, self.points);
        self:close();
        GL.StackedRoll:draw();
    end);

    Window:AddChild(ConfirmButton);
end

---@return void
function Points:close()
    GL:debug("Points:close");

    local Window = GL.Interface:getItem(self, "Window");

    if (not Window) then
        return;
    end

    GL.Interface:storePosition(Window, "Points");
    Window:Hide();

    self.isVisible = false;
end

---@param points number 
---@return void
function Points:updatePoints(points, updateEditBox)
    GL:debug("Points:updatePoints");

    -- Update points locally.
    self.points = points;

    -- Update interface.
    local rollPoints = StackedRoll:rollPoints(points);
    local reserve = StackedRoll:reserve(points);

    if updateEditBox then
        GL.Interface:getItem(self, "EditBox.CurrentPoints"):SetText(points);
    end
    GL.Interface:getItem(self, "Label.Description"):SetText(string.format(
        "Points: |cff%s%s|r Reserve: |cff%s%s|r",
        GL:classHexColor("rogue"), rollPoints, GL:classHexColor("rogue"), reserve
    ));
end

GL:debug("Interfaces/Points.lua");