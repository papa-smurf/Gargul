local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.Exporter = {};

local Utils = App.Utils;
local AceGUI = App.Ace.GUI;
local Exporter = App.Exporter;

function Exporter:draw()
    Utils:debug("Exporter:draw");

    -- Create a container/parent frame
    local ExportFrame = AceGUI:Create("Frame");
    ExportFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget); end);
    ExportFrame:SetTitle(App.name .. " v" .. App.version);
    ExportFrame:SetStatusText("Addon v" .. App.version);
    ExportFrame:SetLayout("Flow");
    ExportFrame:SetWidth(600);
    ExportFrame:SetHeight(450);
    ExportFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    local exportString = "dateTime,character,itemID";
    for _, AwardEntry in pairs(App.DB.AwardHistory) do
        Utils:printTable(AwardEntry);
        exportString = string.format("%s\n%s,%s,%s",
            exportString,
            date('%Y-%m-%d', AwardEntry.timestamp),
            AwardEntry.awardedTo,
            AwardEntry.itemId
        );
    end

    -- Large edit box
    local ExportBox = AceGUI:Create("MultiLineEditBox");
    ExportBox:SetText(exportString);
    ExportBox:HighlightText();
    ExportBox:SetFocus();
    ExportBox:SetFullWidth(true);
    ExportBox:DisableButton(true);
    ExportBox:SetLabel("");
    ExportBox:SetNumLines(22);
    ExportBox:SetMaxLetters(999999999);
    ExportFrame:AddChild(ExportBox);
end

function Exporter:drawDkpExport()
    Utils:debug("Exporter:draw");

    -- Create a container/parent frame
    local ExportFrame = AceGUI:Create("Frame");
    ExportFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget); end);
    ExportFrame:SetTitle(App.name .. " v" .. App.version);
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

Utils:debug("Exporter.lua");