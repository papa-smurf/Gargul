---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;
local Settings = GL.Settings; ---@type Settings

GL:tableSet(GL, "Interface.SoftRes.Importer", {
    isVisible = false,

    InterfaceItems = {
        Icons = {},
        Frames = {},
        Labels = {},
        Tables = {},
    },
});

local Importer = GL.Interface.SoftRes.Importer;

function Importer:draw()
    GL:debug("Importer:draw");

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle(GL.name .. " v" .. GL.version);
    Window:SetStatusText("Addon v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(450);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("SoftReserveImport"));

    -- Explanation
    local Description = AceGUI:Create("Label");
    Description:SetFontObject(_G["GameFontNormalSmall"]);
    Description:SetFullWidth(true);
    Description:SetText("No active soft-reserve data. Paste the data from softres.it here, then click the 'Import' button");
    Window:AddChild(Description);

    -- Large edit box
    local softReservesBoxContent = "";
    local SoftResBox = AceGUI:Create("MultiLineEditBox");
    SoftResBox:SetFullWidth(true);
    SoftResBox:DisableButton(true);
    SoftResBox:SetFocus();
    SoftResBox:SetLabel("");
    SoftResBox:SetNumLines(20);
    SoftResBox:SetMaxLetters(999999999);
    Window:AddChild(SoftResBox);

    SoftResBox:SetCallback("OnTextChanged", function(_, _, text)
        softReservesBoxContent = text;
    end)

    -- Status message frame
    local StatusMessageFrame = AceGUI:Create("SimpleGroup");
    StatusMessageFrame:SetLayout("FILL");
    StatusMessageFrame:SetWidth(570);
    StatusMessageFrame:SetHeight(60);
    Window:AddChild(StatusMessageFrame);

    local StatusMessageLabel = AceGUI:Create("Label");
    StatusMessageLabel:SetFontObject(_G["GameFontNormal"]);
    StatusMessageLabel:SetFullWidth(true);
    StatusMessageLabel:SetColor(1, 0, 0);
    StatusMessageFrame:AddChild(StatusMessageLabel);
    self.InterfaceItems.Labels.StatusMessage = Window;
    GL.Interface:setItem(self, "StatusMessage", StatusMessageLabel);

    -- Import button
    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText("Import");
    ImportButton:SetWidth(140);
    ImportButton:SetCallback("OnClick", function()
        GL.SoftRes:import(softReservesBoxContent, true);
    end);
    Window:AddChild(ImportButton);
end

-- Close the import frame and clean up after ourselves
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
    Settings:set("UI.SoftReserveImport.Position.point", point);
    Settings:set("UI.SoftReserveImport.Position.relativePoint", relativePoint);
    Settings:set("UI.SoftReserveImport.Position.offsetX", offsetX);
    Settings:set("UI.SoftReserveImport.Position.offsetY", offsetY);

    -- Clear the frame and its widgets
    AceGUI:Release(Window);
    self.isVisible = false;
end

GL:debug("Interfaces/SoftRes/Importer.lua");