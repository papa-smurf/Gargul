---@type GL
local _, GL = ...;

---@class IncomingBoostedRollDataDialogInterface
GL:tableSet(GL, "Interface.Dialogs.IncomingBoostedRollDataDialog", {});
local IncomingBoostedRollDataDialog = GL.Interface.Dialogs.IncomingBoostedRollDataDialog; ---@type IncomingBoostedRollDataDialogInterface

function IncomingBoostedRollDataDialog:open(Dialog)
    local AceGUI = GL.AceGUI;

    Dialog.checkSenderIsTrusted = GL:toboolean(Dialog.checkOS);

    -- Create a container/parent frame
    local Frame = AceGUI:Create("GargulIncomingBoostedRollDataDialog");
    Frame:SetLayout("Flow");
    Frame:SetWidth(320);
    Frame:SetQuestion(Dialog.question);
    Frame:SetSender(Dialog.sender or "");
    Frame:OnYes(Dialog.OnYes or function () end);
    Frame:OnNo(Dialog.OnNo or function () end);

    if (Dialog.sender
        and GL.BoostedRolls:playerIsTrusted(Dialog.sender)
    ) then
        local TrustSenderCheckBox = GL.Interface:get(GL.Interface.Dialogs.IncomingBoostedRollDataDialog, "CheckBox.TrustSender");
        TrustSenderCheckBox:SetValue(TrustSenderCheckBox);
    end
end
