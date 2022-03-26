---@type GL
local _, GL = ...;

---@class AwardDialogInterface
GL:tableSet(GL, "Interface.Dialogs.AwardDialog", {});
local AwardDialog = GL.Interface.Dialogs.AwardDialog; ---@type AwardDialogInterface

function AwardDialog:open(Dialog)
    local AceGUI = GL.AceGUI;

    Dialog.checkPlusOne = GL:toboolean(Dialog.checkPlusOne);
    Dialog.checkOS = GL:toboolean(Dialog.checkOS);
    Dialog.checkPlusOne = GL:toboolean(Dialog.checkPlusOne);
    Dialog.checkOS = GL:toboolean(Dialog.checkOS);
    Dialog.boostedRollCost = GL.BoostedRolls:toPoints(Dialog.boostedRollCost);

    -- Create a container/parent frame
    local Frame = AceGUI:Create("GargulAwardDialog");
    Frame:SetLayout("Flow");
    Frame:SetWidth(320);
    Frame:SetQuestion(Dialog.question);
    Frame:OnYes(Dialog.OnYes or function () end);
    Frame:OnNo(Dialog.OnNo or function () end);

    if (Dialog.checkPlusOne) then
        local PlusOneCheckBox = GL.Interface:getItem(GL.Interface.Dialogs.AwardDialog, "CheckBox.PlusOne");

        if (PlusOneCheckBox) then
            PlusOneCheckBox:SetValue(true);
        end
    end

    if (Dialog.checkOS) then
        local OSCheckBox = GL.Interface:getItem(self, "CheckBox.OffSpec");

        if (OSCheckBox) then
            OSCheckBox:SetValue(true);
        end
    end

    if (Dialog.boostedRollCost) then
        local BoostedRollsCostEditBox = GL.Interface:getItem(self, "EditBox.Cost");

        if (BoostedRollsCostEditBox) then
            BoostedRollsCostEditBox:SetText(Dialog.boostedRollCost);
        end
    end
end

GL:debug("Interface/AwardDialog.lua");