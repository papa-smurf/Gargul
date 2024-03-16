local L = Gargul_L;

---@type GL
local _, GL = ...;

local LibDataBroker = LibStub("LibDataBroker-1.1");

---@class MinimapButton
GL.MinimapButton = LibStub("LibDBIcon-1.0");
local MinimapButton = GL.MinimapButton; ---@type MinimapButton

--[[ CONSTANTS ]]
local ACTIONS = {
    DISABLED = function () return; end,
    GARGUL = function () GL.Commands:call("settings"); end,
    SOFTRES = function () GL.Commands:call("softres"); end,
    GDKP = function () GL.Commands:call("gdkp"); end,
    MULTIAUCTION = function () GL.Commands:call("multiauction"); end,
    GDKP_LEDGER = function ()
        local sessionID = GL.GDKP.Session:activeSessionID();
        if (not sessionID) then
            return;
        end

        GL.Interface.GDKP.LedgerList:open(sessionID);
    end,
    GDKP_CUTS = function ()
        local sessionID = GL.GDKP.Session:activeSessionID();
        if (not sessionID) then
            return;
        end

        GL.Interface.GDKP.Distribute.Overview:open(sessionID);
    end,
    IMPORT = function () GL.Commands:call("import"); end,
    EXPORT = function () GL.Commands:call("export"); end,
    AWARDHISTORY = function () GL.Commands:call("awardhistory"); end,
    PLUS_ONE = function () GL.Commands:call("plusones"); end,
    BOOSTED_ROLLS = function () GL.Commands:call("boostedrolls"); end,
};

local SHORTCUT_ORDER = {
    "CLICK",
    "RIGHTCLICK",
    "MIDDLECLICK",
    "SHIFT_CLICK",
    "SHIFT_RIGHTCLICK",
    "SHIFT_MIDDLECLICK",
    "ALT_CLICK",
    "ALT_RIGHTCLICK",
    "ALT_MIDDLECLICK",
    "CTRL_CLICK",
    "CTRL_RIGHTCLICK",
    "CTRL_MIDDLECLICK",
    "ALT_SHIFT_CLICK",
    "ALT_SHIFT_RIGHTCLICK",
    "ALT_SHIFT_MIDDLECLICK",
    "CTRL_SHIFT_CLICK",
    "CTRL_SHIFT_RIGHTCLICK",
    "CTRL_SHIFT_MIDDLECLICK",
}

local EXPLANATIONS = {
    DISABLED = "--",
    GARGUL = L.MINIMAP_BUTTON_GARGUL,
    SOFTRES = L.SOFTRES,
    GDKP = L.GDKP,
    MULTIAUCTION = L.MINIMAP_BUTTON_MULTIAUCTION,
    GDKP_LEDGER = L.MINIMAP_BUTTON_LEDGER,
    GDKP_CUTS = L.MINIMAP_BUTTON_CUTS,
    IMPORT = L.MINIMAP_BUTTON_IMPORT,
    EXPORT = L.MINIMAP_BUTTON_EXPORT,
    AWARDHISTORY = L.MINIMAP_BUTTON_AWARDED,
    PLUS_ONE = L.PLUS1,
    BOOSTED_ROLLS = L.BOOSTED_ROLLS,
};

---@return void
function MinimapButton:_init()
    local GLDataBroker = LibDataBroker:NewDataObject("Gargul", {
        type = "data source",
        text = L.GARGUL,
        icon = "Interface/AddOns/Gargul/Assets/Buttons/minimap",
        OnClick = function(_, mouseButtonPressed)
            local ButtonActions = GL.Settings:get("MinimapButton.Actions");
            local clickCombination = GL.Events:getClickCombination(mouseButtonPressed);
            ACTIONS[ButtonActions[clickCombination]]();
        end,
        OnTooltipShow = function(tooltip)
            local ButtonActions = GL.Settings:get("MinimapButton.Actions");

            tooltip:AddLine(("|cff%s%s %s%s|r"):format(GL.Data.Constants.addonHexColor, L.GARGUL, L.VERSION_ABBR, GL.version));

            for _, shortcut in pairs(SHORTCUT_ORDER) do
                (function()
                    local action = ButtonActions[shortcut];
                    if (action == "DISABLED") then
                        return;
                    end

                    tooltip:AddLine(("|c00FFFFFF%s:|r %s"):format(shortcut, EXPLANATIONS[action]));
                end)();
            end

            tooltip:AddLine(" ");
            tooltip:AddLine(("|c00FFFFFF%s"):format(L.MINIMAP_BUTTON_SETTING_INFO));
        end,
    });

    MinimapButton:Register("Gargul", GLDataBroker,  GL.DB.MinimapButton);

    GL.Ace:ScheduleTimer(function ()
        self:drawOrHide();
    end, .4);
end

---@type void
function MinimapButton:drawOrHide()
    if (GL.Settings:get("MinimapButton.enabled")) then
        MinimapButton:Show("Gargul");
    else
        MinimapButton:Hide("Gargul");
    end
end