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
end

-- Clear soft-reserve data confirmation
PopupDialog.CLEAR_SOFTRES_CONFIRMATION = {
    question = "Are you sure you want to clear all soft-reserve data?",
    OnYes = function ()
       GL.Interface.SoftRes.Overview:close();
       GL.SoftRes:clear();
       GL.SoftRes:draw();
   end,
}

-- Broadcast soft-reserve data confirmation
PopupDialog.BROADCAST_SOFTRES_CONFIRMATION = {
    question = "Are you sure you want to broadcast your softres data to everyone in your party/raid?",
    OnYes = function ()
        GL.SoftRes:broadcast();
    end,
}

-- Clear stacked roll data confirmation
PopupDialog.CLEAR_STACKEDROLL_CONFIRMATION = {
    question = "Are you sure you want to clear all stacked roll data?",
    OnYes = function ()
        GL.Interface.StackedRoll.Overview:close();
        GL.StackedRoll:clear();
        GL.StackedRoll:draw();
   end,
}

-- Import new stacked roll data confirmation
PopupDialog.NEW_STACKEDROLL_IMPORT_CONFIRMATION = {
    question = "Are you sure you want to clear your existing stacked rolls and import new data?",
    OnYes = function ()
        GL.Interface.StackedRoll.Importer:import();
    end,
    OnNo = function ()
        GL.Interface.StackedRoll.Importer:close();
        GL.StackedRoll:draw();
    end,
}

-- Broadcast stacked roll data confirmation
PopupDialog.BROADCAST_STACKEDROLL_CONFIRMATION = {
    question = "Are you sure you want to broadcast your stacked roll data to everyone in your party/raid?",
    OnYes = function ()
        GL.StackedRoll:broadcast();
    end,
}

-- Broadcast soft-reserve data confirmation
PopupDialog.BROADCAST_TMB_CONFIRMATION = {
    question = "Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!",
    OnYes = function ()
        GL.TMB:broadcast();
    end,
}

-- Reset settings to defaults confirmation
PopupDialog.RESET_TO_DEFAULTS_CONFIRMATION = {
    question = "Are you sure you want to reset Gargul to its default settings? DKP, Soft reserves and loot priorities will remain untouched!",
    OnYes = function ()
        GL.Settings:resetToDefault();
    end,
}

-- Add a resut table confirmation dialog to Blizzard's global StaticPopupDialogs object
PopupDialog.RESET_AWARD_HISTORY_CONFIRMATION = {
    question = "",
    OnYes = {},
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
PopupDialog.ROLLOFF_AWARD_CONFIRMATION = {
    question = "",
    OnYes = {},
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
PopupDialog.CLEAR_ROLLOFF_CONFIRMATION = {
    question = "Are you sure you want to clear everything?",
    OnYes = function ()
        GL.RollOff:reset();
    end,
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
PopupDialog.AWARD_CONFIRMATION = {
    question = "",
    OnYes = {},
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
PopupDialog.CLEAR_TMB_CONFIRMATION = {
    question = "Are you sure you want to clear the TMB tables?",
    OnYes = function ()
        GL.Interface.TMB.Overview:close();
        GL.TMB:clear();
        GL.TMB:draw();
    end,
}

GL:debug("Interface/PopupDialog.lua");