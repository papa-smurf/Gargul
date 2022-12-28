---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");
local AceGUI = GL.AceGUI;

---@type Interface
local Interface = GL.Interface;

---@type GDKP
local GDKP = GL.GDKP;

---@class ImportPrices
GL.Interface.GDKP.ImportPrices = {
    isVisible = false,
    sessionID = nil,
};

---@type ImportPrices
local ImportPrices = GL.Interface.GDKP.ImportPrices;

---@return Frame
function ImportPrices:build()
    GL:debug("Interface.GDKP.ImportPrices:build");

    ---@type AceGUIFrame
    local Window = Interface:get(self, "GDKPImportPrices");

    -- Looks like we already created the window before
    if (Window) then
        return;
    end

    Window = AceGUI:Create("Frame");
    Interface:AceGUIDefaults(self, Window, "GDKPImportPrices", 500, 600);
    Interface:resizeBounds(Window, 300, 300);

    ---@type AceGUILabel
    local Info = AceGUI:Create("Label");
    Info:SetText("Import GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!|r):\n\n|c00BE3333ItemID,Minimum,Increment|r|c00967FD2\n18608,4000,500|r");
    Info:SetFullWidth(true);
    Window:AddChild(Info);

    ---@type AceGUIMultiLineEditBox
    local ImportPricesBox = AceGUI:Create("MultiLineEditBox");
    ImportPricesBox:SetText("");
    ImportPricesBox:SetFullWidth(true);
    ImportPricesBox:DisableButton(true);
    ImportPricesBox:SetLabel("|c00FFF569Data|r");
    ImportPricesBox:SetMaxLetters(0);
    Window:AddChild(ImportPricesBox);

    local Confirm = AceGUI:Create("Button");
    Confirm:SetText("Import");
    Confirm:SetFullWidth(true);
    Confirm:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open({
            question = "Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here",
            OnYes = function ()
                GDKP:resetPerItemSettings();
                GDKP:importPerItemSettings(ImportPricesBox:GetText());
            end,
            OnNo = function ()
                GDKP:importPerItemSettings(ImportPricesBox:GetText());
            end,
            withCancel = true,
        });
    end);
    Window:AddChild(Confirm);

    local originalOnHeightSet = Window.OnHeightSet;
    Window.OnHeightSet = function (...)
        originalOnHeightSet(...);

        ImportPricesBox:SetNumLines(math.floor(
            (Window.frame:GetHeight() - 200) / 15
        ));
    end

    return Window;
end

---@return Frame
function ImportPrices:window()
    GL:debug("Interface.GDKP.ImportPrices:window");

    local Window = Interface:get(self, "GDKPImportPrices");

    if (not Window) then
        Window = self:build();
    end

    return Window;
end

---@return void
function ImportPrices:open()
    GL:debug("Interface.GDKP.ImportPrices:open");

    if (self.isVisible) then
        return self:close();
    end
    self.isVisible = true;

    local Window = self:window();
    Window:Show();
end

---@return void
function ImportPrices:close()
    GL:debug("Interface.GDKP.ImportPrices:close");

    local Window = self:window();

    if (self.isVisible) then
        Window:Hide();

        self.isVisible = false;
    end
end

GL:debug("Interface.GDKP.ImportPrices.lua");