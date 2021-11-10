---@type GL
local _, GL = ...;

local LibDataBroker = LibStub("LibDataBroker-1.1");

---@class MinimapButton
GL.MinimapButton = LibStub("LibDBIcon-1.0");
local MinimapButton = GL.MinimapButton; ---@type MinimapButton

---@return void
function MinimapButton:_init()
    local GLDataBroker = LibDataBroker:NewDataObject("Gargul", {
        type = "data source",
        text = "Gargul",
        icon = "Interface\\AddOns\\Gargul\\Assets\\Buttons\\minimap",
        OnClick = function(_, button)
            if (button == "LeftButton") then
                if (IsShiftKeyDown()) then
                    return GL.Commands:call("softreserves");
                end

                return GL.Commands:call("settings");
            end

            if (button == "RightButton") then
                if (IsShiftKeyDown()) then
                    return GL.Commands:call("export");
                end

                return GL.Commands:call("import");
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:AddLine(string.format("|cff%sGargul v%s|r", GL.Data.Constants.addonHexColor, GL.version));
            tooltip:AddLine("|cffffffffClick:|r Open Gargul");
            tooltip:AddLine("|cffffffffRight-click:|r Import data");
            tooltip:AddLine("|cffffffffShift+click:|r SoftRes");
            tooltip:AddLine("|cffffffffShift+Right-click:|r Export data");
            tooltip:AddLine("|cffffffffSlash Command:|r /gl or /gargul");
        end,
    });

    MinimapButton:Register("Gargul", GLDataBroker,  GL.DB.MinimapButton);

    GL.Ace:ScheduleTimer(function ()
        self:drawOrHide();
    end, .4);
end

---@type void
function MinimapButton:drawOrHide()
    if (GL.Settings:get("showMinimapButton")) then
        MinimapButton:Show("Gargul");
    else
        MinimapButton:Hide("Gargul");
    end
end