local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.Exporter = {};

local Exporter = App.Exporter;
local AceGUI = App.Ace.GUI;

function Exporter:draw()
    App:debug("Exporter:draw");

    -- Create a container/parent frame
    local ExportFrame = AceGUI:Create("Frame");
    ExportFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget); end);
    ExportFrame:SetTitle("Give it a Lick v" .. App.version);
    ExportFrame:SetStatusText("Addon v" .. App.version);
    ExportFrame:SetLayout("Flow");
    ExportFrame:SetWidth(600);
    ExportFrame:SetHeight(450);
    ExportFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    -- Large edit box
    local ExportBox = AceGUI:Create("MultiLineEditBox");
    ExportBox:SetText(App.JSON:encode({
        Characters = App.DB.Characters,
        LootHistory = App.DB.LootHistory,
    }));
    ExportBox:HighlightText();
    ExportBox:SetFocus();
    ExportBox:SetFullWidth(true);
    ExportBox:DisableButton(true);
    ExportBox:SetLabel("On our website go to Events -> Select an event -> Addon Import -> Paste in there");
    ExportBox:SetNumLines(22);
    ExportBox:SetMaxLetters(999999999);
    ExportFrame:AddChild(ExportBox);
end

App:debug("Exporter.lua");