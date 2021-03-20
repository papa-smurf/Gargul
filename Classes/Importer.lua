local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.Importer = {};

local Utils = App.Utils;
local AceGUI = App.Ace.GUI;
local Importer = App.Importer;

function Importer:draw()
    Utils:debug("Importer:draw");

    -- Create a container/parent frame
    local ImportFrame = AceGUI:Create("Frame");
    ImportFrame:SetCallback("OnClose", function(widget) AceGUI:Release(widget) end);
    ImportFrame:SetTitle(App.name .. " v" .. App.version);
    ImportFrame:SetStatusText("Addon v" .. App.version);
    ImportFrame:SetLayout("Flow");
    ImportFrame:SetWidth(600);
    ImportFrame:SetHeight(450);
    ImportFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    -- Large edit box
    local importBoxContent = "";
    local ImportBox = AceGUI:Create("MultiLineEditBox");
    ImportBox:SetFullWidth(true);
    ImportBox:DisableButton(true);
    ImportBox:SetFocus();
    ImportBox:SetLabel("On our website go to Utilities -> Export for Gargul -> [CLICK TO COPY] -> Paste in here");
    ImportBox:SetNumLines(22);
    ImportBox:SetMaxLetters(999999999);
    ImportFrame:AddChild(ImportBox);

    ImportBox:SetCallback("OnTextChanged", function(_, _, text)
        importBoxContent = text;
    end)

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    ImportFrame:AddChild(FooterFrame);

    local ImportButton = AceGUI:Create("Button");
    ImportButton:SetText("Import");
    ImportButton:SetWidth(140);
    ImportButton:SetCallback("OnClick", function()
        if (self:import(importBoxContent)) then
            -- Close the import window
            ImportFrame:Hide();

            -- Open the Dashboard
            App.Dashboard:draw();
            App.Dashboard:refresh();
        end
    end);
    FooterFrame:AddChild(ImportButton);
end

function Importer:import(data, sender)
    Utils:debug("Importer:import");

    -- Try to decode data, pcall makes sure this won't throw an error
    local status, data = pcall(function () return App.JSON:decode(data); end);

    -- Make sure all the required properties are available and of the correct type
    if (not status -- The decoding was unsuccessful
            or not data or type(data) ~= "table"
            or not data.Characters  or type(data.Characters) ~= "table"
            or not data.LootHistory or type(data.LootHistory) ~= "table"
    ) then
        Utils:warning("Invalid data provided");
        return false;
    end

    -- Update our saved variables to represent the freshly imported data
    App.DB.Characters = data.Characters;
    App.DB.LootHistory = data.LootHistory;

    App.User:refresh();

    Utils:success("Import successful");
    return true;
end

Utils:debug("Importer.lua");