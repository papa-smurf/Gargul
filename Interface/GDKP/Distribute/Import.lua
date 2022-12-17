---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@type GDKPOverview
local Overview = GL.Interface.GDKP.Distribute.Overview;

---@type Interface
local Interface = GL.Interface;

---@type GDKPSession
local GDKPSession = GL.GDKP.Session;

---@type GDKPSession
local GDKPPot = GL.GDKP.Pot;

GL.Interface.GDKP.Distribute = GL.Interface.GDKP.Distribute or {};
---@class Import
GL.Interface.GDKP.Distribute.Import = {
    isVisible = false,
    sessionID = nil,
};

---@type Import
local Import = GL.Interface.GDKP.Distribute.Import;

---@return Frame
function Import:build()
    GL:debug("Interface.GDKP.Distribute.Import:build");

    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(200);
    Window:SetHeight(280);
    Window.frame:SetFrameStrata("HIGH");
    Window.frame:Show();
    Interface:set(self, "Window", Window);

    ---@type AceGUILabel
    local Info = AceGUI:Create("Label");
    Info:SetText("You can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!|r):\n\n|c00BE3333Player,Gold|r|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n|r");
    Info:SetFullWidth(true);
    Window:AddChild(Info);

    ---@type AceGUIMultiLineEditBox
    local ImportBox = AceGUI:Create("MultiLineEditBox");
    ImportBox:SetText("");
    ImportBox:SetFullWidth(true);
    ImportBox:DisableButton(true);
    ImportBox:SetLabel("|c00FFF569Import|r");
    ImportBox:SetNumLines(21);
    ImportBox:SetMaxLetters(0);
    Window:AddChild(ImportBox);

    local Confirm = AceGUI:Create("Button");
    Confirm:SetText("Import");
    Confirm:SetFullWidth(true);
    Confirm:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open({
            question = "This will override any changes you've made to the cut window, are you sure?",
            OnYes = function ()
                if (GDKPPot:importCuts(self.sessionID, ImportBox:GetText())) then
                    ImportBox:SetText("");
                    self:close();
                end
            end,
        });
    end);
    Window:AddChild(Confirm);

    local Cancel = AceGUI:Create("Button");
    Cancel:SetText("Cancel");
    Cancel:SetFullWidth(true);
    Cancel:SetCallback("OnClick", function()
        self:close();
    end);
    Window:AddChild(Cancel);

    return Window;
end

---@return Frame
function Import:window()
    GL:debug("Interface.GDKP.Distribute.Import:window");

    local Window = Interface:get(self, "Window");

    if (not Window) then
        Window = self:build();
    end

    return Window;
end

--- Toggle the create session window that's anchored to the right side of the GDKP overview window
---
---@return void
function Import:toggle()
    GL:debug("Interface.GDKP.Distribute.Import:toggle");

    if (self.isVisible) then
        return self:close();
    end

    self:open();
end

---@return void
function Import:open(sessionID)
    GL:debug("Interface.GDKP.Distribute.Import:open");

    local Session = GDKPSession:byID(sessionID);

    if (not Session) then
        return;
    end

    -- It seems our distribution window is not opened
    if (not Overview.isVisible) then
        return;
    end

    self.sessionID = sessionID;
    self.isVisible = true;

    local Window = self:window();
    local DistributionWindow = Interface:get(Overview, "GDKPDistribute");

    Window.frame:SetPoint("TOPLEFT", DistributionWindow.frame, "TOPRIGHT", 2, 16);
    Window.frame:SetPoint("BOTTOMLEFT", DistributionWindow.frame, "BOTTOMLEFT", 2);
    Window.frame:Show();
end

---@return void
function Import:close()
    GL:debug("Interface.GDKP.Distribute.Import:close");

    local Window = self:window();

    if (self.isVisible) then
        Window.frame:Hide();
        self.isVisible = false;
    end
end

GL:debug("Interface.GDKP.Distribute.Import.lua");