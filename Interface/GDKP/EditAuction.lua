---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

---@type EditAuction
GL.Interface.GDKP.EditAuction = {
    isVisible = false,
};

---@class EditAuction
local EditAuction = GL.Interface.GDKP.EditAuction;

---@return void
function EditAuction:draw(session, checksum)
    GL:debug("GDKP.Edit:draw");

    -- The overview is already visible
    if (self.isVisible) then
        return;
    end

    session = tostring(session);
    checksum = tostring(checksum);
    local LedgerEntry = GL.DB:get(string.format("GDKP.Ledger.%s.Auctions.%s", session, checksum));

    -- The given GDKP Ledger entry does not exist
    if (not LedgerEntry) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("Frame");
    Window:SetTitle("Gargul v" .. GL.version);
    Window:SetLayout("Flow");
    Window:SetWidth(300);
    Window:SetHeight(250);
    Window:EnableResize(false);
    Window.statustext:GetParent():Show(); -- Explicitely show the statustext bar
    Window:SetCallback("OnClose", function()
        self.isVisible = false;
    end);
    GL.Interface:setItem(self, "Window", Window);
    Window:SetPoint(GL.Interface:getPosition("GDKPEdit"));
    Window.frame:SetFrameStrata("HIGH");

    -- Make sure the window can be closed by pressing the escape button
    _G["GARGUL_GDKP_EDIT_LEDGER_WINDOW"] = Window.frame;
    tinsert(UISpecialFrames, "GARGUL_GDKP_EDIT_LEDGER_WINDOW");
end

GL:debug("Interfaces/GDKP/Overview.lua");