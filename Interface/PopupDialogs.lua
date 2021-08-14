---@type GL
local _, GL = ...;

-- Clear soft-reserve data confirmation
StaticPopupDialogs[GL.name .. "_CLEAR_SOFTRES_CONFIRMATION"] = {
    text = "Are you sure you want to clear all soft-reserve data?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function ()
       GL.Interface.SoftRes.Overview:close();
       GL.SoftRes:clear();
       GL.SoftRes:draw();
   end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Import new soft-reserve data confirmation
StaticPopupDialogs[GL.name .. "_NEW_SOFTRES_IMPORT_CONFIRMATION"] = {
    text = "Are you sure you want to clear your existing soft-reserves and import new data?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function ()
        GL.Interface.Importer:close();
        GL.SoftRes:clear();
        GL.SoftRes:draw();
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Broadcast soft-reserve data confirmation
StaticPopupDialogs[GL.name .. "_BROADCAST_SOFTRES_CONFIRMATION"] = {
    text = "Are you sure you want to broadcast your softres data to everyone in your party/raid?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function ()
        GL.SoftRes:broadcast();
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Reset settings to defaults confirmation
StaticPopupDialogs[GL.name .. "_RESET_TO_DEFAULTS_CONFIRMATION"] = {
    text = string.format("Are you sure you want to reset %s to its default settings? DKP, Soft reserves and loot priorities will remain untouched!", GL.name),
    button1 = "Yes",
    button2 = "No",
    OnAccept = function ()
        GL.Settings:resetToDefault();
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Add a resut table confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[GL.name .. "_RESET_AWARD_HISTORY_CONFIRMATION"] = {
    preferredIndex = 3,
    text = "",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[GL.name .. "_ROLLOFF_AWARD_CONFIRMATION"] = {
    text = "",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[GL.name .. "_CLEAR_ROLLOFF_CONFIRMATION"] = {
    text = "Are you sure you want to clear everything?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = function ()
        GL.RollOff:reset();
    end,
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[GL.name .. "_AWARD_CONFIRMATION"] = {
    text = "",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

-- Add a award confirmation dialog to Blizzard's global StaticPopupDialogs object
StaticPopupDialogs[GL.name .. "_CLEAR_TMB_CONFIRMATION"] = {
    text = "Are you sure you want to clear the TMB tables?",
    button1 = "Yes",
    button2 = "No",
    OnAccept = {},
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}