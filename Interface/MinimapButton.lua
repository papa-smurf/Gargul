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
    GARGUL = "Open Gargul",
    SOFTRES = "Softres",
    GDKP = "GDKP",
    MULTIAUCTION = "Multiauction",
    GDKP_LEDGER = "GDKP Ledger",
    GDKP_CUTS = "GDKP Cuts",
    IMPORT = "Import data",
    EXPORT = "Export data",
    AWARDHISTORY = "Awarded loot history",
    PLUS_ONE = "+1",
    BOOSTED_ROLLS = "Boosted rolls",
};

---@return void
function MinimapButton:_init()
    local GLDataBroker = LibDataBroker:NewDataObject("Gargul", {
        type = "data source",
        text = "Gargul",
        icon = "Interface/AddOns/Gargul/Assets/Buttons/minimap",
        OnClick = function(_, mouseButtonPressed)
            local ButtonActions = GL.Settings:get("MinimapButton.Actions");
            local clickCombination = GL.Events:getClickCombination(mouseButtonPressed);
            ACTIONS[ButtonActions[clickCombination]]();
        end,
        OnTooltipShow = function(tooltip)
            local ButtonActions = GL.Settings:get("MinimapButton.Actions");

            tooltip:AddLine(string.format("|cff%sGargul v%s|r", GL.Data.Constants.addonHexColor, GL.version));

            for _, shortcut in pairs(SHORTCUT_ORDER) do
                (function()
                    local action = ButtonActions[shortcut];
                    if (action == "DISABLED") then
                        return;
                    end

                    tooltip:AddLine(("|cffffffff%s:|r %s"):format(shortcut, EXPLANATIONS[action]));
                end)();
            end

            tooltip:AddLine(" ");
            tooltip:AddLine("|cffffffffChange settings in|r /gl minimap");
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