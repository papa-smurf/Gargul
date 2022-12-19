---@type GL
local _, GL = ...;

---@class ConfirmWithSingleInputDialog
GL:tableSet(GL, "Interface.Dialogs.ConfirmWithSingleInputDialog", {});
local Dialog = GL.Interface.Dialogs.ConfirmWithSingleInputDialog; ---@type ConfirmWithSingleInputDialog

function Dialog:open(Details)
    local AceGUI = GL.AceGUI;

    -- Create a container/parent frame
    local Frame = AceGUI:Create("ConfirmWithSingleInputDialog");
    Frame:SetLayout("Flow");
    Frame:SetWidth(320);
    Frame:SetQuestion(Details.question);

    local InputField = GL.Interface:get(self, "EditBox.Input");

    Frame:OnYes(function ()
        if (Details.OnYes) then
            local inputFieldValue = "";
            if (InputField) then
                inputFieldValue = InputField:GetText();
            end

            Details.OnYes(inputFieldValue);
        end
    end);

    Frame:OnNo(function ()
        if (Details.OnNo) then
            local inputFieldValue = "";
            if (InputField) then
                inputFieldValue = InputField:GetText();
            end

            Details:OnNo(inputFieldValue);
        end
    end);

    if (not InputField) then
        return;
    end

    if (Details.inputValue) then
        --- Adjust the value of the input if a default is given
        InputField:SetText(Details.inputValue);
    end

    if (Details.focus) then
        InputField:SetFocus();
    end
end

GL:debug("Interface/ConfirmWithSingleInputDialog.lua");