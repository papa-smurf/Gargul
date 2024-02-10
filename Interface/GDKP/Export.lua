---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@class GDKPExport
GL.Interface.GDKP.Export = {
    isVisible = false,
    session = nil,
};

---@type GDKPExport
local Export = GL.Interface.GDKP.Export;

-- [[ CONSTANTS ]]
local CUSTOM_FORMAT = 1;
local JSON_FORMAT = 2;

---@return void
function Export:open(session)
    GL:debug("Interface.GDKP.Export:open");

    local Window = Interface:get(self, "GDKPExport");

    if (not Window) then
        Window = self:build();
    end

    if (self.isVisible) then
        self.session = session;
        self:refresh();

        return;
    end

    self.session = session;
    self.isVisible = true;

    self:refresh();
    Window:Show();
end

--- Build the GDKP export. We only do this once and reuse it when reopened
---
---@return void
function Export:build()
    GL:debug("Export:build");

    ---@type AceGUIFrame
    local Window = Interface:get(self, "GDKPExport");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    Window = AceGUI:Create("Frame");
    Window.frame:SetFrameStrata("FULLSCREEN_DIALOG");
    Interface:AceGUIDefaults(self, Window, "GDKPExport", 500, 600);
    Interface:resizeBounds(Window, 300, 300);

    local FixedHeightContentWrapper = GL.AceGUI:Create("SimpleGroup");
    FixedHeightContentWrapper:SetFullWidth(true);
    Window:AddChild(FixedHeightContentWrapper);

    ---@type AceGUILabel
    local Title = AceGUI:Create("Label");
    Title:SetFontObject(GameFontNormalLarge);
    Title:SetText("Session title");
    Title:SetFullWidth(true);
    Interface:set(self, "Title", Title);
    FixedHeightContentWrapper:AddChild(Title);

    local DropDownItems = {
        [CUSTOM_FORMAT] = "|c00FFF569Custom (create your own format)|r",
        [JSON_FORMAT] = "|c00FFF569Detailed (JSON)|r",
    };

    ---@type AceGUIEditBox
    local CustomExportFormat;

    ---@type AceGUIDropdown
    local ExportFormat = GL.AceGUI:Create("Dropdown");
    ExportFormat:SetValue(1);
    ExportFormat:SetList(DropDownItems);
    ExportFormat:SetText(DropDownItems[1]);
    ExportFormat:SetFullWidth(true);
    ExportFormat:SetCallback("OnValueChanged", function()
        GL.Settings:set("GDKP.exportFormat", ExportFormat:GetValue());
        self:refresh();
    end);
    FixedHeightContentWrapper:AddChild(ExportFormat);

    ---@type AceGUIEditBox
    local CustomExportHeader = GL.AceGUI:Create("EditBox");
    CustomExportHeader:SetHeight(20);
    CustomExportHeader:SetFullWidth(true);
    CustomExportHeader:SetText(GL.Settings:get("GDKP.customExportHeader"));
    CustomExportHeader:SetLabel("|c00FFF569Your custom header|r");
    CustomExportHeader:DisableButton(true);
    CustomExportHeader:SetCallback("OnTextChanged", function ()
        local value = CustomExportHeader:GetText();

        if (type(value) ~= "string") then
            return;
        end

        GL.Settings:set("GDKP.customExportHeader", value);
        self:refresh();
    end);
    CustomExportHeader:SetDisabled(ExportFormat:GetValue() ~= 1);
    FixedHeightContentWrapper:AddChild(CustomExportHeader);

    ---@type AceGUIEditBox
    CustomExportFormat = GL.AceGUI:Create("EditBox");
    CustomExportFormat:SetHeight(20);
    CustomExportFormat:SetFullWidth(true);
    CustomExportFormat:SetText(GL.Settings:get("GDKP.customExportFormat"));
    CustomExportFormat:SetLabel("|c00FFF569      Your custom format|r");
    CustomExportFormat:DisableButton(true);
    CustomExportFormat:SetCallback("OnTextChanged", function ()
        local value = CustomExportFormat:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        GL.Settings:set("GDKP.customExportFormat", value);
        self:refresh();
    end);
    CustomExportFormat:SetDisabled(ExportFormat:GetValue() ~= 1);
    FixedHeightContentWrapper:AddChild(CustomExportFormat);

    ---@type AceGUIIcon
    local HelpIcon = AceGUI:Create("Icon");

    ---@type Frame
    local HelpIconFrame = HelpIcon.frame;
    HelpIcon:SetWidth(24);
    HelpIcon:SetHeight(24);
    HelpIcon:SetImageSize(12, 12);
    HelpIcon:SetImage("interface/friendsframe/informationicon");
    HelpIconFrame:SetParent(CustomExportFormat.frame);
    HelpIconFrame:ClearAllPoints();
    HelpIconFrame:SetPoint("BOTTOMRIGHT", CustomExportFormat.frame, "BOTTOMLEFT", 20, 22);
    HelpIconFrame:Show();

    local showCustomFormatHelpTooltip = function ()
        GameTooltip:SetOwner(HelpIconFrame, "ANCHOR_RIGHT");
        GameTooltip:SetText("Available values:\n\n" .. table.concat({
            "@ID",
            "@LINK",
            "@ITEM",
            "@ILVL",
            "@QUALITY",
            "@GOLD",
            "@WINNER",
            "@REALM",
            "@CLASS",
            "@GUILD",
            "@YEAR",
            "@YY",
            "@MONTH",
            "@DAY",
            "@HOUR",
            "@MINUTE",
            "@DATE",
            "@TIME",
            "@ICON",
            "@WOWHEAD",
            "@CHECKSUM",
            "@TITLE - The title of the GDKP session",
            "@START - Date/time at which the first item was awarded",
            "",
            "\\t is replaced by a tab",
        }, "\n"));
        GameTooltip:Show();
    end;
    HelpIcon:SetCallback("OnEnter", function() showCustomFormatHelpTooltip() end);
    HelpIcon:SetCallback("OnLeave", function() GameTooltip:Hide(); end);

    ---@type AceGUIMultiLineEditBox
    local ExportBox = AceGUI:Create("MultiLineEditBox");
    ExportBox:SetText("");
    ExportBox:SetFullWidth(true);
    ExportBox:DisableButton(true);
    ExportBox:SetLabel("|c00FFF569Export|r");
    ExportBox:SetNumLines(1);
    ExportBox:SetMaxLetters(0);
    GL.Interface:set(self, "Export", ExportBox);

    Window:AddChild(ExportBox);
    Window:PauseLayout();
    ExportBox.frame:SetPoint("BOTTOMRIGHT", Window.frame, "BOTTOMRIGHT", -20, 40);

    return Window;
end

---@return void
function Export:close()
    GL:debug("Export:close");

    self.isVisible = false;
end

function Export:refresh()
    GL:debug("Export:refresh");

    local Session = GDKPSession:byID(self.session);

    if (type(Session) ~= "table") then
        return;
    end

    Interface:get(self, "Label.Title"):SetText(string.format("|c00FFF569%s|r", tostring(Session.title)));

    -- We can't work with this session since there are no auction attached
    if (type(Session.Auctions) ~= "table") then
        return;
    end

    local Auctions = {};
    for _, Auction in pairs(Session.Auctions) do
        if (type(Auction) == "table"
            and type(Auction.Winner) == "table"
            and type(Auction.itemID) == "number"
        ) then
            tinsert(Auctions, Auction);
        end
    end

    local exportFormat = GL.Settings:get("GDKP.exportFormat");

    if (exportFormat == CUSTOM_FORMAT) then
        self:exportAuctionsToCustomFormat(Session, Auctions);

    elseif (exportFormat == JSON_FORMAT) then
        local exportString = self:transformAuctionsToJSONFormat(Session);
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(exportString);
        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(exportString);
    end
end

---@param Session GDKPSession
---@return string
function Export:transformAuctionsToJSONFormat(Session)
    return GL.JSON:encode(Session);
end

---@param Auctions GDKPSession
---@param Auctions table
---@return string
function Export:exportAuctionsToCustomFormat(Session, Auctions)
    GL:debug("Export:transformAuctionsToCustomFormat");

    local exportString = GL.Settings:get("GDKP.customExportHeader");
    local customExportFormat = GL.Settings:get("GDKP.customExportFormat");

    -- Determine the start of the raid, determined by the item that was awarded first
    local timestamps = {};
    for _, Details in pairs(Session.Auctions or {}) do
        tinsert(timestamps, Details.createdAt);
    end
    table.sort(timestamps);
    local startedAt = timestamps[1] and date("%Y-%m-%d %H:%M", timestamps[1]) or "";

    -- Make sure that all relevant item data is cached
    local first = true;
    GL:onItemLoadDo(GL:tableColumn(Auctions, "itemID"), function (Result)
        local Details = {};
        for _, ItemDetails in pairs(Result or {}) do
            Details[ItemDetails.id] = ItemDetails;
        end
        Result = nil;

        for _, Auction in pairs(Auctions) do
            local exportEntry = customExportFormat;
            local ItemDetails = Details[Auction.itemID];
            local wowheadLink, iconLink;
            local icon = GL.Data.IconTexturePaths:byID(ItemDetails.icon);

            if (Auction.itemID == GL.Data.Constants.GDKP.potIncreaseItemID) then
                ItemDetails.name = "Pot changed";
            end

            if (GL.isEra) then
                wowheadLink = ("https://classic.wowhead.com/item=%s"):format(Auction.itemID);
            elseif (GL.isRetail) then
                wowheadLink = ("https://www.wowhead.com/item=%s"):format(Auction.itemID);
            else
                wowheadLink = ("https://www.wowhead.com/wotlk/item=%s"):format(Auction.itemID);
            end

            if (icon) then
                local lastForwardSlash = string.find(icon, "/[^/]*$");
                icon = string.sub(icon, lastForwardSlash or 1);
                iconLink = "https://wow.zamimg.com/images/wow/icons/large" .. string.lower(icon) .. ".jpg";
            else
                icon = "";
            end

            if (not GL:empty(ItemDetails)) then
                local Values = {
                    ["@ID"] = Auction.itemID,
                    ["@LINK"] = ItemDetails.link:gsub('\124','\124\124'),
                    ["@ITEM"] = ItemDetails.name,
                    ["@ILVL"] = ItemDetails.level,
                    ["@QUALITY"] = ItemDetails.quality,
                    ["@GOLD"] = Auction.price,
                    ["@CLASS"] = Auction.Winner.class,
                    ["@GUILD"] = Auction.Winner.guild,
                    ["@WINNER"] = Auction.Winner.name,
                    ["@REALM"] = Auction.Winner.realm,
                    ["@YEAR"] = date('%Y', Auction.createdAt),
                    ["@YY"] = date('%y', Auction.createdAt),
                    ["@MONTH"] = date('%m', Auction.createdAt),
                    ["@DAY"] = date('%d', Auction.createdAt),
                    ["@HOUR"] = date('%H', Auction.createdAt),
                    ["@MINUTE"] = date('%M', Auction.createdAt),
                    ["@DATE"] = date('%Y-%m-%d', Auction.createdAt),
                    ["@TIME"] = date('%H:%M', Auction.createdAt),
                    ["@TITLE"] = Session.title,
                    ["@START"] = startedAt,
                    ["@ICON"] = iconLink or "",
                    ["@WOWHEAD"] = wowheadLink,
                    ["@CHECKSUM"] = Auction.checksum,
                    ["\\t"] = "\t",
                };

                for find, replace in pairs(Values) do
                    exportEntry = exportEntry:gsub(find, replace);
                end

                -- This kicks in whenever an empty header is provided
                if (first and GL:empty(exportString)) then
                    exportString = exportEntry;
                else
                    exportString = exportString .. "\n" .. exportEntry;
                end

                first = false;
            end
        end

        GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(exportString);
    end);
end

GL:debug("Interfaces/GDKP/Export.lua");