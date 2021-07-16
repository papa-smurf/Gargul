local _, App = ...;

App.Ace.GUI = App.Ace.GUI or LibStub("AceGUI-3.0");
App.Ace.ScrollingTable = App.Ace.ScrollingTable or LibStub("ScrollingTable");
App.Exporter = {
    visible = false,
    dateSelected = nil,
    UIComponents = {
        Frame = nil,
        Tables = {},
        EditBoxes = {},
    },
};

local Settings = App.Settings;
local Utils = App.Utils;
local AceGUI = App.Ace.GUI;
local ScrollingTable = App.Ace.ScrollingTable;
local Exporter = App.Exporter;

-- Add a resut table confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[App.name .. "_RESET_AWARD_HISTORY_CONFIRMATION"] = {
    preferredIndex = 3,
    text = "",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

function Exporter:draw()
    Utils:debug("Exporter:draw");

    if (Exporter.visible) then
        return;
    end

    Exporter.visible = true;

    -- Fetch award history per date
    local AwardHistoryByDate = {};
    for _, AwardEntry in pairs(App.DB.AwardHistory) do
        local date = date('%Y-%m-%d', AwardEntry.timestamp);
        local Entries = Utils:tableGet(AwardHistoryByDate, date, {});

        tinsert(Entries, AwardEntry);

        AwardHistoryByDate[date] = Entries;
    end

    -- Create a container/parent frame
    local ExportFrame = AceGUI:Create("Frame");
    ExportFrame:SetTitle(App.name .. " v" .. App.version);
    ExportFrame:SetStatusText("Addon v" .. App.version);
    ExportFrame:SetLayout("Flow");
    ExportFrame:SetWidth(600);
    ExportFrame:SetHeight(450);
    ExportFrame:SetCallback("OnClose", function(widget)
       Exporter:close();
   end);
   ExportFrame:SetPoint(
       Settings:get("UI.Exporter.Position.point"),
       UIParent,
       Settings:get("UI.Exporter.Position.relativePoint"),
       Settings:get("UI.Exporter.Position.offsetX"),
       Settings:get("UI.Exporter.Position.offsetY")
   );
    ExportFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    Exporter.UIComponents.Frame = ExportFrame;

    --[[
        DATES FRAME
    ]]
    local DateFrame = AceGUI:Create("SimpleGroup");
    DateFrame:SetLayout("FILL")
    DateFrame:SetWidth(200);
    DateFrame:SetHeight(350);
    ExportFrame:AddChild(DateFrame);

    -- Generate the characters table and add it to DateFrame.frame
    Exporter:drawDatesTable(ExportFrame.frame, Utils:tableFlip(AwardHistoryByDate));

    -- Large edit box
    local ExportBox = AceGUI:Create("MultiLineEditBox");
    ExportBox:SetText("");
    ExportBox:SetWidth(360);
    ExportBox:SetHeight(350);
    ExportBox:DisableButton(true);
    ExportBox:SetLabel("");
    ExportBox:SetNumLines(22);
    ExportBox:SetMaxLetters(999999999);
    ExportFrame:AddChild(ExportBox);

    Exporter.UIComponents.EditBoxes.Export = ExportBox;

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    ExportFrame:AddChild(FooterFrame);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText("Clear");
    ClearButton:SetWidth(140);
    ClearButton:SetCallback("OnClick", function()
        Exporter:clearData();
    end);
    FooterFrame:AddChild(ClearButton);

    Exporter:refreshExportString();
end

function Exporter:clearData()
    Utils:debug("Exporter:clearData");

    local warning = nil;
    local onAccept = nil;

    -- No date is selected, delete everything!
    if (not Exporter.dateSelected) then
        warning = "Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!";
        onAccept = function ()
            App.DB.AwardHistory = {};

            Exporter:close();
            Exporter:draw();
        end;

    -- Only delete entries on the selected date
    else
        warning = string.format("Are you sure you want to remove all data for %s? This cannot be undone!", Exporter.dateSelected);
        onAccept = function ()
            for key, AwardEntry in pairs(App.DB.AwardHistory) do
                local dateString = date('%Y-%m-%d', AwardEntry.timestamp);

                if (dateString == Exporter.dateSelected) then
                    AwardEntry = nil;
                    App.DB.AwardHistory[key] = nil;
                end
            end

            Exporter:close();
            Exporter:draw();
        end
    end

    -- Update and show the confirmation dialog
    StaticPopupDialogs[App.name .. "_CLEAR_SOFTRESERVES_CONFIRMATION"].text = warning;
    StaticPopupDialogs[App.name .. "_CLEAR_SOFTRESERVES_CONFIRMATION"].OnAccept = onAccept;
    StaticPopup_Show(App.name .. "_CLEAR_SOFTRESERVES_CONFIRMATION");
end

function Exporter:refreshExportString()
    Utils:debug("Exporter:refreshExportString");

    local exportString = "dateTime,character,itemID";

    for _, AwardEntry in pairs(App.DB.AwardHistory) do
        local dateString = date('%Y-%m-%d', AwardEntry.timestamp);

        if (not Exporter.dateSelected or dateString == Exporter.dateSelected) then
            exportString = string.format("%s\n%s,%s,%s",
                exportString,
                dateString,
                AwardEntry.awardedTo,
                AwardEntry.itemId
            );
        end
    end

    Exporter.UIComponents.EditBoxes.Export:SetText(exportString);
end

-- Close the exported
function Exporter:close()
    Utils:debug("Exporter:close");

    if (not Exporter.visible
        or not Exporter.UIComponents.Frame
    ) then
        return;
    end

    -- Store the frame's last position for future play sessions
    local point, _, relativePoint, offsetX, offsetY = Exporter.UIComponents.Frame:GetPoint();
    Settings:set("UI.Exporter.Position.point", point);
    Settings:set("UI.Exporter.Position.relativePoint", relativePoint);
    Settings:set("UI.Exporter.Position.offsetX", offsetX);
    Settings:set("UI.Exporter.Position.offsetY", offsetY);

    -- Clear the frame and its widgets
    AceGUI:Release(Exporter.UIComponents.Frame);
    Exporter.visible = false;

    -- Clean up the Dates table seperately
    Exporter.UIComponents.Tables.Dates:SetData({}, true);
    Exporter.UIComponents.Tables.Dates:Hide();
end

function Exporter:drawDatesTable(parent, Dates)
    Utils:debug("Exporter:drawDatesTable");

    local columns = {
        {
            name = "Date",
            width = 120,
            align = "LEFT",
            color = {
                r = 0.5,
                g = 0.5,
                b = 1.0,
                a = 1.0
            },
            colorargs = nil,
            sort = App.Data.Constants.ScrollingTable.descending,
        },
    };

    local table = ScrollingTable:CreateST(columns, 21, 15, nil, parent);
    table:EnableSelection(true);
    table:SetWidth(120);
    table.frame:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 50, 78);

    table:RegisterEvents({
        ["OnClick"] = function (rowFrame, cellFrame, data, cols, row, realrow, column, scrollingTable, ...)

            -- Even if we're still missing an answer from some of the group members
            -- we still want to make sure our inspection end after a set amount of time
            App.Ace:ScheduleTimer(function ()
                Exporter.dateSelected = nil;
                local Selected = table:GetRow(table:GetSelection());

                if (Selected and Selected[1]) then
                    Exporter.dateSelected = Selected[1];
                end

                Exporter:refreshExportString();
            end, .1);
        end
    });

    TableData = {};
    for _, date in pairs(Dates) do
        tinsert(TableData, {date});
    end

    -- The second argument refers to "isMinimalDataformat"
    -- For the full format see https://www.wowace.com/projects/lib-st/pages/set-data
    table:SetData(TableData, true);

    self.UIComponents.Tables.Dates = table;
end

function Exporter:drawDkpExport()
    Utils:debug("Exporter:drawDkpExport");

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