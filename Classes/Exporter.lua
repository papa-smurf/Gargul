local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

---@class Exporter
GL.Exporter = {
    visible = false,
    dateSelected = nil,
    UIComponents = {
        Frame = nil,
        Tables = {},
        EditBoxes = {},
    },
    disenchantedItemIdentifier = "||de||",
};

local AceGUI = GL.AceGUI;
local Exporter = GL.Exporter; ---@type Exporter
local ScrollingTable = GL.ScrollingTable;
local Settings = GL.Settings; ---@type Settings

function Exporter:draw()
    GL:debug("Exporter:draw");

    if (Exporter.visible) then
        return;
    end

    Exporter.visible = true;

    -- Fetch award history per date
    local AwardHistoryByDate = {};
    for _, AwardEntry in pairs(GL.DB.AwardHistory) do
        local date = date('%Y-%m-%d', AwardEntry.timestamp);
        local Entries = GL:tableGet(AwardHistoryByDate, date, {});

        tinsert(Entries, AwardEntry);

        AwardHistoryByDate[date] = Entries;
    end

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetStatusText("Addon v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(450);
    Window:SetCallback("OnClose", function()
        Exporter:close();
    end);
    Window:SetPoint(GL.Interface:getPosition("Exporter"));
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar

    GL.Interface:setItem(self, "Window", Window);

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_EXPORTER_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_EXPORTER_WINDOW");

    --[[
        DATES FRAME
    ]]
    local DateFrame = AceGUI:Create("SimpleGroup");
    DateFrame:SetLayout("FILL")
    DateFrame:SetWidth(200);
    DateFrame:SetHeight(350);
    Window:AddChild(DateFrame);

    -- Generate the characters table and add it to DateFrame.frame
    Exporter:drawDatesTable(Window.frame, GL:tableFlip(AwardHistoryByDate));

    -- Large edit box
    local ExportBox = AceGUI:Create("MultiLineEditBox");
    ExportBox:SetText("");
    ExportBox:SetWidth(360);
    ExportBox:SetHeight(350);
    ExportBox:DisableButton(true);
    ExportBox:SetLabel("");
    ExportBox:SetNumLines(22);
    ExportBox:SetMaxLetters(999999999);
    Window:AddChild(ExportBox);

    Exporter.UIComponents.EditBoxes.Export = ExportBox;

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    Window:AddChild(FooterFrame);

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
    GL:debug("Exporter:clearData");

    local warning;
    local onConfirm;

    -- No date is selected, delete everything!
    if (not Exporter.dateSelected) then
        warning = "Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!";
        onConfirm = function()
            GL.DB.AwardHistory = {};

            Exporter:close();
            Exporter:draw();
        end;

        -- Only delete entries on the selected date
    else
        warning = string.format("Are you sure you want to remove all data for %s? This cannot be undone!", Exporter.dateSelected);
        onConfirm = function()
            for key, AwardEntry in pairs(GL.DB.AwardHistory) do
                local dateString = date('%Y-%m-%d', AwardEntry.timestamp);

                if (dateString == Exporter.dateSelected) then
                    AwardEntry = nil;
                    GL.DB.AwardHistory[key] = nil;
                end
            end

            Exporter:close();
            Exporter:draw();
        end
    end

    -- Show a confirmation dialog before clearing entries
    GL.Interface.Dialogs.PopupDialog:open({
        question = warning,
        OnYes = onConfirm,
    });
end

function Exporter:refreshExportString()
    GL:debug("Exporter:refreshExportString");

    local exportString = "dateTime,character,itemID,offspec,ID";

    for _, AwardEntry in pairs(GL.DB.AwardHistory) do
        local dateString = date('%Y-%m-%d', AwardEntry.timestamp);
        local concernsDisenchantedItem = AwardEntry.awardedTo == self.disenchantedItemIdentifier;

        if ((not concernsDisenchantedItem or GL.Settings:get("ExportingLoot.includeDisenchantedItems")
        ) and (not Exporter.dateSelected or dateString == Exporter.dateSelected)) then
            local awardedTo = AwardEntry.awardedTo;
            if (concernsDisenchantedItem) then
                awardedTo = GL.Settings:get("ExportingLoot.disenchanterIdentifier");
            end

            -- Old entries may not possess a checksum yet
            local checksum = AwardEntry.checksum;
            if (not checksum) then
                checksum = GL:strPadRight(GL:strLimit(GL:stringHash(AwardEntry.timestamp .. AwardEntry.itemId) .. GL:stringHash(AwardEntry.winner), 20, ""), "0", 20);
            end

            exportString = string.format("%s\n%s,%s,%s,%s,%s",
                exportString,
                dateString,
                awardedTo,
                AwardEntry.itemId,
                AwardEntry.OS and 1 or 0,
                checksum
            );
        end
    end

    Exporter.UIComponents.EditBoxes.Export:SetText(exportString);
end

-- Close the exported
function Exporter:close()
    GL:debug("Exporter:close");

    if (not Exporter.visible
        or not GL.Interface:getItem(self, "Window")
    ) then
        return;
    end

    -- Store the frame's last position for future play sessions
    local point, _, relativePoint, offsetX, offsetY = GL.Interface:getItem(self, "Window"):GetPoint();
    Settings:set("UI.Exporter.Position.point", point);
    Settings:set("UI.Exporter.Position.relativePoint", relativePoint);
    Settings:set("UI.Exporter.Position.offsetX", offsetX);
    Settings:set("UI.Exporter.Position.offsetY", offsetY);

    -- Clear the frame and its widgets
    AceGUI:Release(GL.Interface:getItem(self, "Window"));
    Exporter.visible = false;

    -- Clean up the Dates table seperately
    Exporter.UIComponents.Tables.Dates:SetData({}, true);
    Exporter.UIComponents.Tables.Dates:Hide();
end

function Exporter:drawDatesTable(parent, Dates)
    GL:debug("Exporter:drawDatesTable");

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
            sort = GL.Data.Constants.ScrollingTable.descending,
        },
    };

    local table = ScrollingTable:CreateST(columns, 21, 15, nil, parent);
    table:EnableSelection(true);
    table:SetWidth(120);
    table.frame:SetPoint("BOTTOMLEFT", parent, "BOTTOMLEFT", 50, 78);

    table:RegisterEvents({
        ["OnClick"] = function()

            -- Even if we're still missing an answer from some of the group members
            -- we still want to make sure our inspection end after a set amount of time
            GL.Ace:ScheduleTimer(function()
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
        tinsert(TableData, { date });
    end

    -- The second argument refers to "isMinimalDataformat"
    -- For the full format see https://www.wowace.com/projects/lib-st/pages/set-data
    table:SetData(TableData, true);

    self.UIComponents.Tables.Dates = table;
end

function Exporter:drawDkpExport()
    GL:debug("Exporter:drawDkpExport");

    -- Create a container/parent frame
    local ExportFrame = AceGUI:Create("Frame");
    ExportFrame:SetCallback("OnClose", function(widget)
        AceGUI:Release(widget);
    end);
    ExportFrame:SetTitle("Gargul v" .. GL.version);
    ExportFrame:SetStatusText("Addon v" .. GL.version);
    ExportFrame:SetLayout("Flow");
    ExportFrame:SetWidth(600);
    ExportFrame:SetHeight(450);
    ExportFrame.statustext:GetParent():Hide(); -- Hide the statustext bar

    -- Large edit box
    local ExportBox = AceGUI:Create("MultiLineEditBox");
    ExportBox:SetText(GL.JSON:encode({
        Characters = GL.DB.Characters,
        LootHistory = GL.DB.LootHistory,
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

GL:debug("Exporter.lua");