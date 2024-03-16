---@type GL
local _, GL = ...;

---@class PopupDialogInterface
GL:tableSet(GL, "Interface.Dialogs.PopupDialog", {});
local PopupDialog = GL.Interface.Dialogs.PopupDialog; ---@type PopupDialogInterface

function PopupDialog:open(Dialog)
    local AceGUI = GL.AceGUI;

    if (type(Dialog) == "string") then
        Dialog = self[Dialog];
    end

    -- Create a container/parent frame
    local Frame = AceGUI:Create("GargulPopupDialog");
    Frame:SetLayout("Flow");
    Frame:SetWidth(320);
    Frame:SetQuestion(Dialog.question or "");
    Frame:OnYes(Dialog.OnYes or function () end);
    Frame:OnNo(Dialog.OnNo or function () end);
    Frame:OnCancel(Dialog.OnCancel or function () end);

    if (Dialog.withCancel) then
        Frame:IncludeCancel();
    end
end
