---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

GL:tableSet(GL, "Interface.PlusOnes.Importer", {
    isVisible = false,
    plusOnesBoxContent = "",

    InterfaceItems = {
        Icons = {},
        Frames = {},
        Labels = {},
        Tables = {},
    },
});

local Importer = GL.Interface.PlusOnes.Importer;

function Importer:draw()
    GL:debug("Importer:draw");

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;
    self.plusOnesBoxContent = "";

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(530);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:set(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("PlusOnesImport"));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_PLUSONES_IMPORTER_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_PLUSONES_IMPORTER_WINDOW");

    -- Explanation
    local Description = AceGUI:Create("Label");
    Description:SetFontObject(_G["GameFontNormal"]);
    Description:SetFullWidth(true);
    Description:SetText("Here you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240");
    Window:AddChild(Description);

    -- Large edit box
    local PlusOneDataBox = AceGUI:Create("MultiLineEditBox");
    PlusOneDataBox:SetFullWidth(true);
    PlusOneDataBox:DisableButton(true);
    PlusOneDataBox:SetFocus();
    PlusOneDataBox:SetLabel("");
    PlusOneDataBox:SetNumLines(20);
    PlusOneDataBox:SetMaxLetters(999999999);
    Window:AddChild(PlusOneDataBox);

    PlusOneDataBox:SetCallback("OnTextChanged", function(_, _, text)
        self.plusOnesBoxContent = text;
    end)

    -- Status message frame
    local StatusMessageFrame = AceGUI:Create("SimpleGroup");
    StatusMessageFrame:SetLayout("FILL");
    StatusMessageFrame:SetWidth(570);
    StatusMessageFrame:SetHeight(46);
    Window:AddChild(StatusMessageFrame);

    local StatusMessageLabel = AceGUI:Create("Label");
    StatusMessageLabel:SetFontObject(_G["GameFontNormal"]);
    StatusMessageLabel:SetFullWidth(true);
    StatusMessageLabel:SetColor(1, 0, 0);
    StatusMessageFrame:AddChild(StatusMessageLabel);
    GL.Interface:set(self, "StatusMessage", StatusMessageLabel);

    -- Import button
    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText("Import");
    ImportButton:SetWidth(100);
    ImportButton:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open("NEW_PLUSONES_IMPORT_CONFIRMATION");
    end);
    Window:AddChild(ImportButton);
end

-- Import
function Importer:import()
    GL.PlusOnes:import(self.plusOnesBoxContent, true);
end

-- Close the import frame and clean up after ourselves
function Importer:close()
    GL:debug("Importer:close");

    local Window = GL.Interface:get(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    -- Store the frame's last position for future play sessions
    GL.Interface:storePosition(Window, "PlusOnesImport");

    -- Clear the frame and its widgets
    GL.Interface:release(Window);
    self.isVisible = false;
end

GL:debug("Interfaces/PlusOnes/Importer.lua");