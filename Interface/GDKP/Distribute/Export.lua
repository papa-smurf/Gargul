---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@class GDKPDistributeExport
GL.Interface.GDKP.Distribute.Export = {
    isVisible = false,
    sessionID = nil,
};

---@type GDKPExport
local Export = GL.Interface.GDKP.Distribute.Export;

-- [[ CONSTANTS ]]
local CUSTOM_FORMAT = 1;
local SOFTRES_FORMAT = 2;

---@return void
function Export:open(sessionID)
    GL:debug("Interface.GDKP.Distribute.Export:open");

    local Window = Interface:get(self, "GDKPPotExport");

    if (not Window) then
        Window = self:build();
    end

    if (self.isVisible) then
        self.sessionID = sessionID;
        self:refresh();

        return;
    end

    self.sessionID = sessionID;
    self.isVisible = true;

    self:refresh();
    Window:Show();
end

---@return void
function Export:build()
    GL:debug("Export:build");

    ---@type AceGUIFrame
    local Window = Interface:get(self, "GDKPPotExport");

    -- Looks like we already created the overview before
    if (Window) then
        return;
    end

    Window = AceGUI:Create("Frame");
    Interface:AceGUIDefaults(self, Window, "GDKPPotExport", 500, 600);
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
        GL.Settings:set("GDKP.potExportFormat", ExportFormat:GetValue());
        self:refresh();
    end);
    FixedHeightContentWrapper:AddChild(ExportFormat);

    ---@type AceGUIEditBox
    local CustomExportHeader = GL.AceGUI:Create("EditBox");
    CustomExportHeader:SetHeight(20);
    CustomExportHeader:SetFullWidth(true);
    CustomExportHeader:SetText(GL.Settings:get("GDKP.customPotExportHeader"));
    CustomExportHeader:SetLabel("|c00FFF569Your custom header|r");
    CustomExportHeader:DisableButton(true);
    CustomExportHeader:SetCallback("OnTextChanged", function ()
        local value = CustomExportHeader:GetText();

        GL.Settings:set("GDKP.customPotExportHeader", value);
        self:refresh();
    end);
    CustomExportHeader:SetDisabled(ExportFormat:GetValue() ~= 1);
    FixedHeightContentWrapper:AddChild(CustomExportHeader);

    ---@type AceGUIEditBox
    CustomExportFormat = GL.AceGUI:Create("EditBox");
    CustomExportFormat:SetHeight(20);
    CustomExportFormat:SetFullWidth(true);
    CustomExportFormat:SetText(GL.Settings:get("GDKP.customPotExportFormat"));
    CustomExportFormat:SetLabel("|c00FFF569      Your custom format|r");
    CustomExportFormat:DisableButton(true);
    CustomExportFormat:SetCallback("OnTextChanged", function ()
        local value = CustomExportFormat:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        GL.Settings:set("GDKP.customPotExportFormat", value);
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
            "@PLAYER",
            "@REALM",
            "@CUT",
            "@SPENT",
            "@BID",
            "@RECEIVED - total gold received from the player",
            "@GIVEN - total gold given to the player",
            "@TRADED - gold traded to the player",
            "@MAILED - gold mailed to the player",
            "@START - Date/time at which the first item was awarded",
            "@END - Date/time at which the session was locked",
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

    local Session = GDKPSession:byID(self.sessionID);

    if (type(Session) ~= "table") then
        return;
    end

    Interface:get(self, "Label.Title"):SetText(string.format("|c00FFF569%s|r", tostring(Session.title)));

    -- We can't work with this session since there are no auction attached
    local Cuts = GL:tableGet(Session, "Pot.Cuts", {});
    if (type(Cuts) ~= "table") then
        return;
    end

    local exportFormat = GL.Settings:get("GDKP.potExportFormat");

    local PlayerNames = {};
    for player in pairs(Cuts) do
        tinsert(PlayerNames, player);
    end

    table.sort(PlayerNames, function (a, b)
        if (a and b) then
            return a < b;
        end

        return false;
    end);

    local SortedCuts = {};
    for _, player in pairs(PlayerNames or {}) do
        tinsert(SortedCuts, {
            player = player,
            cut = Cuts[player],
        });
    end

    if (exportFormat == CUSTOM_FORMAT) then
        self:exportPotToCustomFormat(Session, SortedCuts);

    elseif (exportFormat == SOFTRES_FORMAT) then

    end
end

---@param Cuts table
---@return string
function Export:transformAuctionsToSoftResFormat(Cuts)
    return GL.JSON:encode("");
end

---@param Session table
---@param Cuts table
---@return string
function Export:exportPotToCustomFormat(Session, Cuts)
    GL:debug("Export:transformAuctionsToCustomFormat");

    local exportString = GL.Settings:get("GDKP.customPotExportHeader");
    local customExportFormat = GL.Settings:get("GDKP.customPotExportFormat");
    local endedAt = Session.lockedAt and date("%Y-%m-%d %H:%M", Session.lockedAt) or "";

    -- Determine the start of the raid, determined by the item that was awarded first
    local timestamps = {};
    for _, Details in pairs(Session.Auctions or {}) do
        tinsert(timestamps, Details.createdAt);
    end
    table.sort(timestamps);
    local startedAt = timestamps[1] and date("%Y-%m-%d %H:%M", timestamps[1]) or "";

    -- Make sure that all relevant item data is cached
    for _, Details in pairs(Cuts) do
        local player, cut = Details.player, Details.cut;
        local exportEntry = customExportFormat;

        local copperGiven, copperReceived, copperTraded, copperMailed = GDKPSession:goldTradedWithPlayer(Details.player, Session.ID);

        local Values = {
            ["@PLAYER"] = GL:nameFormat{ name = player, stripRealm = true },
            ["@REALM"] = GL:getRealmFromName(player),
            ["@CUT"] = cut,
            ["@SPENT"] = GDKPSession:goldSpentByPlayer(player, Session.ID),
            ["@BID"] = GDKPSession:goldBidByPlayer(player, Session.ID),
            ["@RECEIVED"] = copperReceived / 10000,
            ["@GIVEN"] = copperGiven / 10000,
            ["@TRADED"] = copperTraded / 10000,
            ["@MAILED"] = copperMailed / 10000,
            ["@START"] = startedAt,
            ["@END"] = endedAt,
            ["\\t"] = "\t",
        };

        for find, replace in pairs(Values) do
            exportEntry = exportEntry:gsub(find, replace);
        end

        exportString = exportString .. "\n" .. exportEntry;
    end

    GL.Interface:get(self, "MultiLineEditBox.Export"):SetText(strtrim(exportString));
end

GL:debug("Interfaces/GDKP/Export.lua");