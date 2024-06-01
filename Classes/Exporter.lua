local L = Gargul_L;

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
    if (self.visible) then
        return;
    end

    self.visible = true;

    -- Fetch award history per date
    local AwardHistoryByDate = {};
    for _, AwardEntry in pairs(DB:get("AwardHistory") or {}) do
        local dateString = date(L.DATE_FORMAT, AwardEntry.timestamp);
        local Entries = GL:tableGet(AwardHistoryByDate, dateString, {});

        tinsert(Entries, AwardEntry);

        AwardHistoryByDate[dateString] = Entries;
    end

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle((L.WINDOW_HEADER):format(GL.version));
    Window:SetStatusText(L.VERSION_ABBR ..GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(600);
    Window:SetHeight(450);
    Window:EnableResize(false);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window:SetPoint(GL.Interface:getPosition("Exporter"));
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar

    GL.Interface:set(self, "Window", Window);

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_EXPORTER_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_EXPORTER_WINDOW");

    --[[ DON'T EDIT STOOPID! ]]
    local DontEditNotification = AceGUI:Create("Label");
    DontEditNotification:SetFullWidth(true);
    DontEditNotification:SetJustifyH("CENTER");
    DontEditNotification:SetText(("|c00FF0000%s|r"):format(L.EXPORT_READ_ONLY_NOTICE));
    Window:AddChild(DontEditNotification);

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

    --[[
        FOOTER BUTTON PARENT FRAME
    ]]
    local FooterFrame = AceGUI:Create("SimpleGroup");
    FooterFrame:SetLayout("Flow");
    FooterFrame:SetFullWidth(true);
    FooterFrame:SetHeight(50);
    Window:AddChild(FooterFrame);

    local ClearButton = AceGUI:Create("Button");
    ClearButton:SetText(L.CLEAR);
    ClearButton:SetWidth(140);
    ClearButton:SetCallback("OnClick", function()
        Exporter:clearData();
    end);
    FooterFrame:AddChild(ClearButton);

    local SettingsButton = AceGUI:Create("Button");
    SettingsButton:SetText(L.SETTINGS);
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
    local warning;
    local onConfirm;

    -- No date is selected, delete everything!
    if (not self.dateSelected) then
        warning = L.EXPORT_DELETE_ALL_CONFIRM;
        onConfirm = function()
            GL.Events:fire("GL.ITEM_UNAWARDED");
            DB:set("AwardHistory", {});

            Exporter:close();
            Exporter:draw();
        end;

    else -- Only delete entries on the selected date
        warning = (L.EXPORT_DELETE_DATE_CONFIRM):format(self.dateSelected);
        onConfirm = function()
            for key, AwardEntry in pairs(DB:get("AwardHistory")) do
                local dateString = date(L.DATE_FORMAT, AwardEntry.timestamp);

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
    GL.Interface.Dialogs.PopupDialog:open{
        question = warning,
        OnYes = function ()
            onConfirm();

            -- Let the application know that an item was unawarded (deleted)
            GL.Events:fire("GL.ITEM_UNAWARDED");
        end,
    };
end

--- Show the export data (either all or for the selected date)
---
---@return void
function Exporter:refreshExportString()
    local exportFormat = GL.Settings:get("ExportingLoot.format");

    if (exportFormat == Constants.ExportFormats.JSON) then
        local exportString = GL.JSON:encode(self:getLootEntries(true));
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(exportString);

        return;
    end

    local LootEntries = self:getLootEntries();
    if (exportFormat == Constants.ExportFormats.Custom) then
        local exportString = self:transformEntriesToCustomFormat(LootEntries);
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(exportString);

    elseif (exportFormat == Constants.ExportFormats.RRobin) then
        local exportString = self:transformEntriesToCustomFormat(LootEntries, "@ID,@DATE @TIME,@WINNER-@REALM");
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(exportString);

    elseif (GL:inTable({ Constants.ExportFormats.TMB, Constants.ExportFormats.TMBWithRealm }, exportFormat)) then
        local exportString = self:transformEntriesToTMBFormat(LootEntries);
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(exportString);

    elseif (GL:inTable({ Constants.ExportFormats.DFTUS, Constants.ExportFormats.DFTEU }, exportFormat)) then
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(self:transformEntriesToDFTFormat(LootEntries));
    end
end

--- Fetch export entries (either all or for the selected date)
---
---@return table
function Exporter:getLootEntries(raw)
    local Entries = {};
    raw = raw == true;

    for _, AwardEntry in pairs(DB:get("AwardHistory")) do
        (function()
            local concernsDisenchantedItem = AwardEntry.awardedTo == self.disenchantedItemIdentifier;
            local dateString = date(L.DATE_FORMAT, AwardEntry.timestamp);
            if (
                (not concernsDisenchantedItem or GL.Settings:get("ExportingLoot.includeDisenchantedItems"))
                and (not AwardEntry.OS or GL.Settings:get("ExportingLoot.includeOffspecItems"))
                and (not self.dateSelected or dateString == self.dateSelected)
                and not GL:empty(AwardEntry.timestamp)
                and not GL:empty(AwardEntry.itemLink)
                and not GL:empty(AwardEntry.awardedTo)
            ) then
                if (raw) then
                    tinsert(Entries, AwardEntry);
                    return;
                end

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
                    itemLink = AwardEntry.itemLink,
                    OS = AwardEntry.OS and 1 or 0,
                    SR = AwardEntry.SR and 1 or 0,
                    WL = AwardEntry.WL and 1 or 0,
                    PL = AwardEntry.PL and 1 or 0,
                    TMB = AwardEntry.TMB and 1 or 0,
                    winningRollType = AwardEntry.winningRollType or "-",
                    checksum = checksum,
                });
            end
        end)();
    end

    -- Sort the entries by award time
    table.sort(Entries, function (a, b)
        if (not a.timestamp or not b.timestamp) then
            return false;
        end

        return a.timestamp < b.timestamp;
    end);

    return Entries;
end

--- Transform the table of entries to the user specified (custom) format
---
---@return string
function Exporter:transformEntriesToCustomFormat(Entries, format)
    format = format or GL.Settings:get("ExportingLoot.customFormat");
    local exportString = "";

    -- Make sure that all relevant item data is cached
    GL:onItemLoadDo(GL:tableColumn(Entries, "itemLink"), function (Result)
        local Details = {};
        for _, ItemDetails in pairs(Result or {}) do
            Details[ItemDetails.id] = ItemDetails;
        end
        Result = nil;

        for _, AwardEntry in pairs(Entries) do
            local exportEntry = format;
            local ItemDetails = Details[AwardEntry.itemID];
            local wowheadLink;

            if (GL.isEra) then
                wowheadLink = ("https://classic.wowhead.com/item=%s"):format(AwardEntry.itemID);
            elseif (GL.isRetail) then
                wowheadLink = ("https://www.wowhead.com/item=%s"):format(AwardEntry.itemID);
            else
                wowheadLink = ("https://www.wowhead.com/wotlk/item=%s"):format(AwardEntry.itemID);
            end

            if (ItemDetails) then
                local Values = {
                    ["@ID"] = AwardEntry.itemID,
                    ["@LINK"] = ItemDetails.link:gsub('\124','\124\124'),
                    ["@ITEM"] = ItemDetails.name,
                    ["@ILVL"] = ItemDetails.level,
                    ["@QUALITY"] = ItemDetails.quality,
                    ["@WINNER"] = GL:nameFormat{ name = AwardEntry.awardedTo, stripRealm = true },
                    ["@REALM"] = GL:getRealmFromName(AwardEntry.awardedTo),
                    ["@OS"] = GL:toboolean(AwardEntry.OS),
                    ["@SR"] = GL:toboolean(AwardEntry.SR),
                    ["@WL"] = GL:toboolean(AwardEntry.WL),
                    ["@PL"] = GL:toboolean(AwardEntry.PL),
                    ["@TMB"] = GL:toboolean(AwardEntry.TMB),
                    ["@ROLLTYPE"] = AwardEntry.winningRollType,
                    ["@CHECKSUM"] = AwardEntry.checksum,
                    ["@YEAR"] = date('%Y', AwardEntry.timestamp),
                    ["@YY"] = date('%y', AwardEntry.timestamp),
                    ["@MONTH"] = date('%m', AwardEntry.timestamp),
                    ["@DAY"] = date('%d', AwardEntry.timestamp),
                    ["@HOUR"] = date('%H', AwardEntry.timestamp),
                    ["@MINUTE"] = date('%M', AwardEntry.timestamp),
                    ["@DATE"] = date(L.DATE_FORMAT, AwardEntry.timestamp),
                    ["@TIME"] = date('%H:%M', AwardEntry.timestamp),
                    ["@WOWHEAD"] = wowheadLink,
                    ["\\t"] = "\t",
                };

                for find, replace in pairs(Values) do
                    -- We transform booleans to 0 or 1
                    if (type(replace) == "boolean") then
                        replace = replace and 1 or 0;
                    end

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
    local ItemIDConversions = {
        [18423] = 18422, -- Head of Onyxia
        [19003] = 19002, -- Head of Nefarian
        [32386] = 32385, -- Magtheridon's Head
        [43959] = 44083, -- Reins of the Grand Black War Mammoth
        [209693] = 211452, -- Perfect Blackfathom Pearl
        [217350] = 217351, -- Thermaplugg's Engineering Notes
        [221346] = 221363, -- Scapula of the Fallen Avatar
    };

    local exportFormat = GL.Settings:get("ExportingLoot.format");
    local exportString = "dateTime,character,itemID,offspec,id";

    for _, AwardEntry in pairs(Entries) do
        exportString = string.format("%s\n%s,%s,%s,%s,%s",
            exportString,
            date(L.DATE_FORMAT, AwardEntry.timestamp),
            GL:nameFormat{
                name = AwardEntry.awardedTo,
                stripRealm = exportFormat == Constants.ExportFormats.TMB,
                forceRealm = exportFormat == Constants.ExportFormats.TMBWithRealm
            },
            ItemIDConversions[AwardEntry.itemID] and ItemIDConversions[AwardEntry.itemID] or AwardEntry.itemID, -- Convert specific item IDs for TMB compatibility
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
    -- Get the desired export format
    local exportFormat = GL.Settings:get("ExportingLoot.format");

    -- We need to load all items first to make sure the item names are available
    local exportString = "";
    for _, AwardEntry in pairs(Entries) do
        local dateString = "";

        -- Check whether the player wants an EU or US date string
        if (exportFormat == Constants.ExportFormats.DFTEU) then
            dateString = date('%d/%m/%Y', AwardEntry.timestamp);
        else
            dateString = date('%m/%d/%Y', AwardEntry.timestamp);
        end

        exportString = string.format("%s%s;[%s];%s\n",
            exportString,
            dateString,
            AwardEntry.itemID,
            GL:nameFormat(AwardEntry.awardedTo)
        );
    end;

    return exportString;
end

--- Close the export window
---
---@return void
function Exporter:close()
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
    local Dates = GL.Interface:get(self, "Table.Dates");
    if (Dates) then
        GL.Interface:get(self, "Table.Dates"):SetData({}, true);
        GL.Interface:get(self, "Table.Dates"):Hide();
    end
end

--- Draw the dates table shown on the left hand side of the window
---
---@return void
function Exporter:drawDatesTable(Parent, Dates)
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
    Table.frame:SetPoint("BOTTOMLEFT", Parent, "BOTTOMLEFT", 50, 58);

    Table:RegisterEvents{
        OnClick = function()

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
    };

    local TableData = {};
    for _, date in pairs(Dates) do
        tinsert(TableData, { date });
    end

    -- The second argument refers to "isMinimalDataformat"
    -- For the full format see https://www.wowace.com/projects/lib-st/pages/set-data
    Table:SetData(TableData, true);

    GL.Interface:set(self, "Dates", Table);
end
