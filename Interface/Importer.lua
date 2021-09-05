---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;
local Settings = GL.Settings; ---@type Settings

---@class ImporterInterface
GL.Interface.Importer = {
    isVisible = false,
};
local Importer = GL.Interface.Importer; ---@type ImporterInterface

function Importer:draw()
    GL:debug("Importer:draw");

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
    Window:SetHeight(150);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
       self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("Importer"));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_IMPORT_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_IMPORT_WINDOW");

    --[[
        DESCRIPTION LABEL
    ]]
    local DescriptionLabel = AceGUI:Create("InteractiveLabel");
    DescriptionLabel:SetFullWidth(true);
    DescriptionLabel:SetText("What kind of data would you like to import?\n\n");
    Window:AddChild(DescriptionLabel);

    --[[
        SOFTRES BUTTON
    ]]
    local SoftResButton = AceGUI:Create("Button");
    SoftResButton:SetText("Import SoftRes data");
    SoftResButton:SetWidth(188);
    SoftResButton:SetCallback("OnClick", function()
        if (not GL.SoftRes:available()) then
            self:close();
            return GL.SoftRes:draw();
        end

        GL.Interface.Dialogs.PopupDialog:open("NEW_SOFTRES_IMPORT_CONFIRMATION");
    end);
    Window:AddChild(SoftResButton);

    --[[
        TMB BUTTON
    ]]
    local TMBButton = AceGUI:Create("Button");
    TMBButton:SetText("Import TMB data");
    TMBButton:SetWidth(188);
    TMBButton:SetCallback("OnClick", function()
        self:close();
        GL.TMB:drawImporter();
    end);
    Window:AddChild(TMBButton);

    --[[
        LOOT PRIO BUTTON
    ]]
    local LootPrioButton = AceGUI:Create("Button");
    LootPrioButton:SetText("Import Loot Prio data");
    LootPrioButton:SetWidth(188);
    LootPrioButton:SetCallback("OnClick", function()
        self:close();
        GL.LootPriority:drawImporter();
    end);
    Window:AddChild(LootPrioButton);
end

function Importer:close()
    GL:debug("Importer:close");

    local Window = GL.Interface:getItem(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    -- Store the frame's last position for future play sessions
    local point, _, relativePoint, offsetX, offsetY = Window:GetPoint();
    Settings:set("UI.Importer.Position.point", point);
    Settings:set("UI.Importer.Position.relativePoint", relativePoint);
    Settings:set("UI.Importer.Position.offsetX", offsetX);
    Settings:set("UI.Importer.Position.offsetY", offsetY);

    -- Clear the frame and its widgets
    AceGUI:Release(Window);
    self.isVisible = false;
end

GL:debug("Importer.lua");