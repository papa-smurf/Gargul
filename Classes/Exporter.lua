local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
GL.ScrollingTable = GL.ScrollingTable or LibStub("ScrollingTable");

local AceGUI = GL.AceGUI;
local ScrollingTable = GL.ScrollingTable;

---@type Data
local Constants = GL.Data.Constants;

---@type DB
local DB = GL.DB;

---@class Exporter
GL.Exporter = {
    visible = false,
    dateSelected = nil,
    disenchantedItemIdentifier = "||de||",
};

---@type Exporter
local Exporter = GL.Exporter;

--- Show the export window
---
---@return void
function Exporter:draw()
    GL:debug("Exporter:draw");

    if (self.visible) then
        return;
    end

    self.visible = true;

    -- Fetch award history per date
    local AwardHistoryByDate = {};
    for _, AwardEntry in pairs(DB:get("AwardHistory")) do
        local dateString = date('%Y-%m-%d', AwardEntry.timestamp);
        local Entries = GL:tableGet(AwardHistoryByDate, dateString, {});

        tinsert(Entries, AwardEntry);

        AwardHistoryByDate[dateString] = Entries;
    end

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetStatusText("Addon v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(450);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window:SetPoint(GL.Interface:getPosition("Exporter"));
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar

    GL.Interface:set(self, "Window", Window);

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
    GL.Interface:set(self, "Export", ExportBox);

    GL.Interface:set(self, "Export", ExportBox);

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

    local SettingsButton = AceGUI:Create("Button");
    SettingsButton:SetText("Settings");
    SettingsButton:SetWidth(140);
    SettingsButton:SetCallback("OnClick", function()
        GL.Settings:draw("ExportingLoot");
    end);
    FooterFrame:AddChild(SettingsButton);

    Exporter:refreshExportString();
end

--- Clear export data, either for a specific date or everything
---
---@return void
function Exporter:clearData()
    GL:debug("Exporter:clearData");

    local warning;
    local onConfirm;

    -- No date is selected, delete everything!
    if (not self.dateSelected) then
        warning = "Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!";
        onConfirm = function()
            DB:set("AwardHistory", {});

            Exporter:close();
            Exporter:draw();
        end;

    else -- Only delete entries on the selected date
        warning = string.format("Are you sure you want to remove all data for %s? This cannot be undone!", self.dateSelected);
        onConfirm = function()
            for key, AwardEntry in pairs(DB:get("AwardHistory")) do
                local dateString = date('%Y-%m-%d', AwardEntry.timestamp);

                if (dateString == self.dateSelected) then
                    AwardEntry = nil;
                    DB:set("AwardHistory." .. key, nil);
                end
            end

            Exporter:close();
            Exporter:draw();
        end
    end

    -- Show a confirmation dialog before clearing entries
    GL.Interface.Dialogs.PopupDialog:open({
        question = warning,
        OnYes = function ()
            onConfirm();

            -- Let the application know that an item was unawarded (deleted)
            GL.Events:fire("GL.ITEM_UNAWARDED");
        end,
    });
end

--- Show the export data (either all or for the selected date)
---
---@return void
function Exporter:refreshExportString()
    GL:debug("Exporter:refreshExportString");

    local LootEntries = self:getLootEntries();
    local exportFormat = GL.Settings:get("ExportingLoot.format", Constants.ExportFormats.TMB);

    if (exportFormat == Constants.ExportFormats.TMB) then
        local exportString = self:transformEntriesToTMBFormat(LootEntries);
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(exportString);

    elseif (exportFormat == Constants.ExportFormats.Custom) then
        local exportString = self:transformEntriesToCustomFormat(LootEntries);
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(exportString);

    elseif (GL:inTable({Constants.ExportFormats.DFTUS, Constants.ExportFormats.DFTEU}, exportFormat)) then
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(self:transformEntriesToDFTFormat(LootEntries));
    end
end

--- Fetch export entries (either all or for the selected date)
---
---@return table
function Exporter:getLootEntries()
    GL:debug("Exporter:getLootEntries");

    local Entries = {};

    for _, AwardEntry in pairs(DB:get("AwardHistory")) do
        local concernsDisenchantedItem = AwardEntry.awardedTo == self.disenchantedItemIdentifier;
        local dateString = date('%Y-%m-%d', AwardEntry.timestamp);

        if (
            (not concernsDisenchantedItem or GL.Settings:get("ExportingLoot.includeDisenchantedItems"))
            and (not AwardEntry.OS or GL.Settings:get("ExportingLoot.includeOffspecItems"))
            and (not self.dateSelected or dateString == self.dateSelected)
            and not GL:empty(AwardEntry.timestamp)
            and not GL:empty(AwardEntry.itemLink)
            and not GL:empty(AwardEntry.awardedTo)
        ) then
            local awardedTo = AwardEntry.awardedTo;

            if (concernsDisenchantedItem) then
                awardedTo = GL.Settings:get("ExportingLoot.disenchanterIdentifier");
            end

            -- Just in case an itemID is not available we will extract it from the item link
            local itemID = AwardEntry.itemID or GL:getItemIDFromLink(AwardEntry.itemLink);

            local checksum = AwardEntry.checksum; -- Old entries may not possess a checksum yet
            if (not checksum) then
                checksum = GL:strPadRight(GL:strLimit(GL:stringHash(AwardEntry.timestamp .. itemID) .. GL:stringHash(awardedTo), 20, ""), "0", 20);
            end

            tinsert(Entries, {
                timestamp = AwardEntry.timestamp,
                awardedTo = awardedTo,
                itemID = itemID,
                OS = AwardEntry.OS and 1 or 0,
                checksum = checksum,
            });
        end
    end

    return Entries;
end

--- Transform the table of entries to the user specified (custom) format
---
---@return string
function Exporter:transformEntriesToCustomFormat(Entries)
    GL:debug("Exporter:transformEntriesToCustomFormat");

    local exportString = "";

    -- Make sure that all relevant item data is cached
    GL:onItemLoadDo(GL:tableColumn(Entries, "itemID"), function ()
        for _, AwardEntry in pairs(Entries) do
            local exportEntry = GL.Settings:get("ExportingLoot.customFormat");
            local ItemDetails = GL.DB.Cache.ItemsByID[tostring(AwardEntry.itemID)];
            local wowheadLink;

            if (GL.isEra) then
                wowheadLink = string.format("https://classic.wowhead.com/item=%s", AwardEntry.itemID );
            else
                wowheadLink = string.format("https://www.wowhead.com/wotlk/item=%s", AwardEntry.itemID );
            end

            if (not GL:empty(ItemDetails)) then
                local Values = {
                    ["@ID"] = AwardEntry.itemID,
                    ["@LINK"] = ItemDetails.link:gsub('\124','\124\124'),
                    ["@ITEM"] = ItemDetails.name,
                    ["@ILVL"] = ItemDetails.level,
                    ["@QUALITY"] = ItemDetails.quality,
                    ["@WINNER"] = AwardEntry.awardedTo,
                    ["@OS"] = tostring(AwardEntry.OS),
                    ["@CHECKSUM"] = AwardEntry.checksum,
                    ["@YEAR"] = date('%Y', AwardEntry.timestamp),
                    ["@YY"] = date('%y', AwardEntry.timestamp),
                    ["@MONTH"] = date('%m', AwardEntry.timestamp),
                    ["@DAY"] = date('%d', AwardEntry.timestamp),
                    ["@HOUR"] = date('%H', AwardEntry.timestamp),
                    ["@MINUTE"] = date('%M', AwardEntry.timestamp),
                    ["@DATE"] = date('%Y-%m-%d', AwardEntry.timestamp),
                    ["@TIME"] = date('%H:%M', AwardEntry.timestamp),
                    ["@WOWHEAD"] = wowheadLink,
                    ["\\t"] = "\t",
                };

                for find, replace in pairs(Values) do
                    exportEntry = exportEntry:gsub(find, replace);
                end

                exportString = exportString .. "\n" .. exportEntry;
            end

        end
    end);

    return strtrim(exportString);
end

--- Transform the table of entries to the TMB CSV format
---
---@return string
function Exporter:transformEntriesToTMBFormat(Entries)
    GL:debug("Exporter:transformEntriesToTMBFormat");

    local exportString = "dateTime,character,itemID,offspec,id";

    for _, AwardEntry in pairs(Entries) do
        exportString = string.format("%s\n%s,%s,%s,%s,%s",
            exportString,
            date('%Y-%m-%d', AwardEntry.timestamp),
            GL:stripRealm(AwardEntry.awardedTo),
            AwardEntry.itemID,
            AwardEntry.OS,
            AwardEntry.checksum
        );
    end

    return exportString;
end

--- Transform the table of entries to the DFT sheet format
---
---@return string
function Exporter:transformEntriesToDFTFormat(Entries)
    GL:debug("Exporter:transformEntriesToDFTFormat");

    -- Get the desired export format
    local exportFormat = GL.Settings:get("ExportingLoot.format", Constants.ExportFormats.TMB);

    -- We need to load all items first to make sure the item names are available
    local exportString = "";
    for _, Entry in pairs(Entries) do
        local dateString = "";

        -- Check whether the player wants an EU or US date string
        if (exportFormat == Constants.ExportFormats.DFTEU) then
            dateString = date('%d/%m/%Y', Entry.timestamp);
        else
            dateString = date('%m/%d/%Y', Entry.timestamp);
        end

        exportString = string.format("%s%s;[%s];%s\n",
            exportString,
            dateString,
            Entry.itemID,
            Entry.awardedTo
        );
    end;

    return exportString;
end

--- Close the export window
---
---@return void
function Exporter:close()
    GL:debug("Exporter:close");

    if (not self.visible) then
        return;
    end

    self.visible = false;
    local Window = GL.Interface:get(self, "Window");

    if (not Window) then
        return;
    end

    -- Store the frame's last position for future play sessions
    GL.Interface:storePosition(Window, "Exporter");
    Window:Hide();

    -- Clean up the Dates table separately
    GL.Interface:get(self, "Table.Dates"):SetData({}, true);
    GL.Interface:get(self, "Table.Dates"):Hide();
end

--- Draw the dates table shown on the left hand side of the window
---
---@return void
function Exporter:drawDatesTable(Parent, Dates)
    GL:debug("Exporter:drawDatesTable");

    local Columns = {
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

    local Table = ScrollingTable:CreateST(Columns, 21, 15, nil, Parent);
    Table:EnableSelection(true);
    Table:SetWidth(120);
    Table.frame:SetPoint("BOTTOMLEFT", Parent, "BOTTOMLEFT", 50, 78);

    Table:RegisterEvents({
        ["OnClick"] = function()

            -- Even if we're still missing an answer from some of the group members
            -- we still want to make sure our inspection end after a set amount of time
            GL.Ace:ScheduleTimer(function()
                self.dateSelected = nil;
                local Selected = Table:GetRow(Table:GetSelection());

                if (Selected and Selected[1]) then
                    self.dateSelected = Selected[1];
                end

                Exporter:refreshExportString();
            end, .1);
        end
    });

    local TableData = {};
    for _, date in pairs(Dates) do
        tinsert(TableData, { date });
    end

    -- The second argument refers to "isMinimalDataformat"
    -- For the full format see https://www.wowace.com/projects/lib-st/pages/set-data
    Table:SetData(TableData, true);

    GL.Interface:set(self, "Dates", Table);
end

GL:debug("Exporter.lua");