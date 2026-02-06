local L = Gargul_L;

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
    Info:SetText(L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"]);
    Info:SetFullWidth(true);
    Window:AddChild(Info);

    ---@type AceGUIMultiLineEditBox
    local ImportPricesBox = AceGUI:Create("MultiLineEditBox");
    ImportPricesBox:SetText("ItemID,Minimum,Increment\n");
    ImportPricesBox:SetFullWidth(true);
    ImportPricesBox:DisableButton(true);
    ImportPricesBox:SetLabel(" ");
    ImportPricesBox:SetMaxLetters(0);
    Window:AddChild(ImportPricesBox);

    local Confirm = AceGUI:Create("Button");
    Confirm:SetText(L["Import"]);
    Confirm:SetFullWidth(true);
    Confirm:SetCallback("OnClick", function()
        GL.Interface.Dialogs.PopupDialog:open{
            question = L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"],
            OnYes = function ()
                GDKP:resetPerItemSettings();
                GDKP:importPerItemSettings(ImportPricesBox:GetText());
            end,
            OnNo = function ()
                GDKP:importPerItemSettings(ImportPricesBox:GetText());
            end,
            withCancel = true,
        };
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
    local Window = Interface:get(self, "GDKPImportPrices");

    if (not Window) then
        Window = self:build();
    end

    return Window;
end

---@return nil
function ImportPrices:open()
    if (self.isVisible) then
        return self:close();
    end
    self.isVisible = true;

    local Window = self:window();
    Window:Show();
end

---@return nil
function ImportPrices:close()
    local Window = self:window();

    if (self.isVisible) then
        Window:Hide();

        self.isVisible = false;
    end
end
