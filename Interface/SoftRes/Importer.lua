---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

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
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(480);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("SoftReserveImport"));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_SOFTRES_IMPORTER_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_SOFTRES_IMPORTER_WINDOW");

    -- Explanation
    local Description = AceGUI:Create("Label");
    Description:SetFontObject(_G["GameFontNormal"]);
    Description:SetFullWidth(true);
    Description:SetText("In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below.");
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
    StatusMessageFrame:SetHeight(56);
    Window:AddChild(StatusMessageFrame);

    local StatusMessageLabel = AceGUI:Create("Label");
    StatusMessageLabel:SetFontObject(_G["GameFontNormal"]);
    StatusMessageLabel:SetFullWidth(true);
    StatusMessageLabel:SetColor(1, 0, 0);
    StatusMessageFrame:AddChild(StatusMessageLabel);
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
    GL.Interface:storePosition(Window, "SoftReserveImport");

    -- Clear the frame and its widgets
    AceGUI:Release(Window);
    self.isVisible = false;
end

GL:debug("Interfaces/SoftRes/Importer.lua");