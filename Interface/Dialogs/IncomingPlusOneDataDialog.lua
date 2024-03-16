---@type GL
local _, GL = ...;

---@class IncomingPlusOneDataDialogInterface
GL:tableSet(GL, "Interface.Dialogs.IncomingPlusOneDataDialog", {});
local IncomingPlusOneDataDialog = GL.Interface.Dialogs.IncomingPlusOneDataDialog; ---@type IncomingPlusOneDataDialogInterface

function IncomingPlusOneDataDialog:open(Dialog)
    local AceGUI = GL.AceGUI;

    Dialog.checkSenderIsTrusted = GL:toboolean(Dialog.checkOS);

    -- Create a container/parent frame
    local Frame = AceGUI:Create("GargulIncomingPlusOneDataDialog");
    Frame:SetLayout("Flow");
    Frame:SetWidth(320);
    Frame:SetQuestion(Dialog.question);
    Frame:SetSender(Dialog.sender or "");
    Frame:OnYes(Dialog.OnYes or function () end);
    Frame:OnNo(Dialog.OnNo or function () end);

    if (Dialog.sender
        and GL.PlusOnes:playerIsTrusted(Dialog.sender)
    ) then
        local TrustSenderCheckBox = GL.Interface:get(GL.Interface.Dialogs.IncomingPlusOneDataDialog, "CheckBox.TrustSender");
        TrustSenderCheckBox:SetValue(TrustSenderCheckBox);
    end
end
