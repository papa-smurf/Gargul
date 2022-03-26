---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

GL:tableSet(GL, "Interface.BoostedRolls.Importer", {
    isVisible = false,
    boostedRollsBoxContent = "",

    InterfaceItems = {
        Icons = {},
        Frames = {},
        Labels = {},
        Tables = {},
    },
});

local Importer = GL.Interface.BoostedRolls.Importer;

function Importer:draw()
    GL:debug("Importer:draw");

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;
    self.boostedRollsBoxContent = "";

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(550);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetCallback("OnClose", function()
        self:close();
        GL.BoostedRolls:draw();
    end);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint(GL.Interface:getPosition("BoostedRollsImport"));

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_BOOSTEDROLLS_IMPORTER_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_BOOSTEDROLLS_IMPORTER_WINDOW");

    -- Explanation
    local Description = AceGUI:Create("Label");
    Description:SetFontObject(_G["GameFontNormal"]);
    Description:SetFullWidth(true);
    Description:SetText("Here you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo");
    Window:AddChild(Description);

    -- Large edit box
    local BoostedRollDataBox = AceGUI:Create("MultiLineEditBox");
    BoostedRollDataBox:SetFullWidth(true);
    BoostedRollDataBox:DisableButton(true);
    BoostedRollDataBox:SetFocus();
    BoostedRollDataBox:SetLabel("");
    BoostedRollDataBox:SetNumLines(20);
    BoostedRollDataBox:SetMaxLetters(999999999);
    Window:AddChild(BoostedRollDataBox);

    BoostedRollDataBox:SetCallback("OnTextChanged", function(_, _, text)
        self.boostedRollsBoxContent = text;
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
        if (GL.BoostedRolls:available()) then
            GL.Interface.Dialogs.PopupDialog:open("NEW_BOOSTEDROLLS_IMPORT_CONFIRMATION");
        else
            self:import();
        end
    end);
    Window:AddChild(ImportButton);
end

-- Import
function Importer:import()
    GL.BoostedRolls:import(self.boostedRollsBoxContent, true);
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
    GL.Interface:storePosition(Window, "BoostedRollsImport");

    -- Clear the frame and its widgets
    AceGUI:Release(Window);
    self.isVisible = false;
end

GL:debug("Interfaces/BoostedRolls/Importer.lua");