local L = Gargul_L;

---@type GL
local _, GL = ...;

local AceGUI = LibStub("AceGUI-3.0");

---@type Interface
local Interface = GL.Interface;

---@class GDKPImport
GL.Interface.GDKP.Import = {
    isVisible = false,
};

---@type GDKPImport
local Import = GL.Interface.GDKP.Import;

---@return nil
function Import:open()
    local Window = Interface:get(self, "GDKPImport");

    if (not Window) then
        Window = self:build();
    end

    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    Window:Show();
end

--- Build the GDKP import window. We only do this once and reuse it when reopened
---
---@return nil
function Import:build()
    ---@type AceGUIFrame
    local Window = Interface:get(self, "GDKPImport");

    -- Looks like we already created the overview before
    if (Window) then
        return Window;
    end

    Window = AceGUI:Create("Frame");
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window.frame:SetFrameStrata("FULLSCREEN_DIALOG");
    Interface:AceGUIDefaults(self, Window, "GDKPImport", 500, 600);
    Interface:resizeBounds(Window, 300, 300);

    local HorizontalSpacer;

    local FixedHeightContentWrapper = GL.AceGUI:Create("SimpleGroup");
    FixedHeightContentWrapper:SetFullWidth(true);
    Window:AddChild(FixedHeightContentWrapper);

    ---@type AceGUILabel
    local Title = AceGUI:Create("Label");
    Title:SetFontObject(GameFontNormalLarge);
    Title:SetText(L["Import GDKP Session"]);
    Title:SetFullWidth(true);
    Interface:set(self, "Title", Title);
    FixedHeightContentWrapper:AddChild(Title);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    FixedHeightContentWrapper:AddChild(HorizontalSpacer);

    local MoreInfoLabel = AceGUI:Create("Label");
    MoreInfoLabel:SetText(L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"]);
    MoreInfoLabel:SetFontObject(_G["GameFontNormal"]);
    MoreInfoLabel:SetFullWidth(true);
    FixedHeightContentWrapper:AddChild(MoreInfoLabel);

    HorizontalSpacer = AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    FixedHeightContentWrapper:AddChild(HorizontalSpacer);

    ---@type AceGUIMultiLineEditBox
    local ImportBox = AceGUI:Create("MultiLineEditBox");
    ImportBox:SetText("");
    ImportBox:SetFullWidth(true);
    ImportBox:DisableButton(true);
    ImportBox:SetLabel(" ");
    ImportBox:SetNumLines(1);
    ImportBox:SetMaxLetters(0);
    GL.Interface:set(self, "Import", ImportBox);

    local Import = AceGUI:Create("Button");
    Import:SetText(L["Import"]);
    Import:SetWidth(72);
    Import:SetHeight(20);
    Import:SetCallback("OnClick", function()
        local data = self:decompress(ImportBox:GetText() or "");

        if (type(data) ~= "table"
            or not data.ID
            or not data.CreatedBy
            or not data.CreatedBy.guid
        ) then
            return;
        end

        local import = function (data)
            GL.DB:set("GDKP.Ledger." .. data.ID, data);
        end;

        if (GL.DB:has("GDKP.Ledger." .. data.ID)) then
            -- Show a confirmation dialog before overriding the existing session
            GL.Interface.Dialogs.PopupDialog:open{
                question = (L["This GDKP session created by %s appears to exist already, do you wish to override it?"]):format(GL:formatPlayerName(data.CreatedBy.guid)),
                OnYes = function ()
                    import(data);
                    self:close();
                    GL.Commands:call("gdkp");
                    GL.Events:fire("GL.GDKP_SESSION_CHANGED");
                end,
            };
        else
            -- Show a confirmation dialog before import a new session
            GL.Interface.Dialogs.PopupDialog:open{
                question = (L["You're about to import a GDKP session created by %s, are you sure?"]):format(GL:formatPlayerName(data.CreatedBy.guid)),
                OnYes = function ()
                    import(data);
                    self:close();
                    GL.Commands:call("gdkp");
                    GL.Events:fire("GL.GDKP_SESSION_CREATED");
                end,
            };
        end
    end);

    Window:PauseLayout();

    Window:AddChild(ImportBox);
    Window:AddChild(Import);
    ImportBox.frame:SetPoint("TOPLEFT", Window.frame, "TOPLEFT", 20, -90);
    ImportBox.frame:SetPoint("BOTTOMRIGHT", Window.frame, "BOTTOMRIGHT", -20, 50);
    Import.frame:SetPoint("BOTTOMLEFT", Window.frame, "BOTTOMLEFT", 20, 20);
    Import.frame:SetPoint("TOPRIGHT", Window.frame, "BOTTOMLEFT", 100, 40);

    return Window;
end

---@return nil
function Import:close()
    local Window = Interface:get(self, "GDKPImport");

    if (Window) then
        Window:Hide();
    end

    self.isVisible = false;
end

---@param data string
---@return nil|table
function Import:decompress(data)
    local base64DecodeSucceeded;
    base64DecodeSucceeded, data = pcall(function () return GL.Base64.decode(data); end);

    -- Something went wrong while base64 decoding the payload
    if (not base64DecodeSucceeded) then
        return GL:error(L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"]);
    end

    local LibDeflate = LibStub:GetLibrary("LibDeflate");
    local zlibDecodeSucceeded;
    zlibDecodeSucceeded, data = pcall(function () return LibDeflate:DecompressZlib(data); end);

    -- Something went wrong while zlib decoding the payload
    if (not zlibDecodeSucceeded) then
        return GL:error(L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"]);
    end

    -- Something went wrong while json decoding the payload
    local jsonDecodeSucceeded;
    jsonDecodeSucceeded, data = pcall(function () return GL.JSON:decode(data); end);
    if (not jsonDecodeSucceeded) then
        return GL:error(L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"]);
    end

    return data;
end
