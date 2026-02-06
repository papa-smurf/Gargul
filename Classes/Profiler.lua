local L = Gargul_L;

---@type GL
local _, GL = ...;

---@class Profiler
GL.Profiler = {
    addonIndex = nil,
    isVisible = false,
    updateRateInSeconds = 5,
    RefreshTimer = nil,
    Window = nil,
}

local Profiler = GL.Profiler; ---@type Profiler

--- Draw the profiler window and keep it updated
---
---@return nil
function Profiler:draw()
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    local Window = GL.AceGUI:Create("Frame");
    Window:SetTitle((L["Gargul v%s"]):format(GL.version));
    Window:SetLayout("Flow");
    Window:SetWidth(180);
    Window:SetHeight(60);
    Window:EnableResize(false);
    Window.statustext:GetParent():Hide(); -- Hide the statustext bar
    Window:SetPoint(GL.Interface:getPosition("Profiler"));
    Window.frame:SetScale(.8);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window.frame:SetScript("OnLeave", function()
        self:storePosition();
    end);
    self.Window = Window;

    -- Remove the close button
    local CloseButton = GL:fetchCloseButtonFromAceGUIWidget(Window);
    if (CloseButton) then
        CloseButton:Hide();
    end

    local VerticalSpacer = GL.AceGUI:Create("SimpleGroup");
    VerticalSpacer:SetLayout("FILL");
    VerticalSpacer:SetFullWidth(true);
    VerticalSpacer:SetHeight(4);
    Window:AddChild(VerticalSpacer);

    local Usage = GL.AceGUI:Create("Label");
    Usage:SetFontObject(_G["GameFontNormal"]);
    Usage:SetFullWidth(true);
    Usage:SetJustifyH("CENTER");
    Window:AddChild(Usage);
    self.Usage = Usage;

    local updateMemoryUsage = function ()
        local memory = self:getMemoryUsage();

        -- Use color to indicate the severety of the memory usage
        local function memoryColor(number)
            local color = "92FF00";
            if (number >= 8000) then
                color = "FFF569";
            elseif (number >= 15000) then
                color = "F7922E";
            elseif (number >= 30000) then
                color = "BE3333";
            end

            return color;
        end

        Usage:SetText(("MEM: |c00%s%s|rk"):format(
            memoryColor(memory),
            self:humanReadableNumber(memory)
        ));
    end;

    -- Make sure the usage gets updated every X seconds
    GL.Ace:CancelTimer(self.RefreshTimer); -- Just in case
    self.RefreshTimer = GL.Ace:ScheduleRepeatingTimer(function ()
        updateMemoryUsage();
    end, self.updateRateInSeconds);

    updateMemoryUsage();
end

--- Make large numbers human readble
---
---@param number number
---
---@return string
function Profiler:humanReadableNumber(number)
    local pattern = "%.1f";
    local numberString = (pattern):format(number);

    if (number >= 1000) then
        local subCount;
        repeat
            numberString, subCount = numberString:gsub("^(-?%d+)(%d%d%d)","%1,%2");
        until subCount == 0
    end

    return numberString;
end

--- Close the profile, cancel the refreshtimer
---
---@return nil
function Profiler:close()
    if (not self.isVisible) then
        return;
    end

    GL.Ace:CancelTimer(self.RefreshTimer);
    self:storePosition();
    self.Window:Hide();
    self.isVisible = false;
end

--- Store the profiler's position so it persists between playsessions
---
---@return nil
function Profiler:storePosition()
    GL.Interface:storePosition(self.Window, "Profiler");
end

--- Get the memory usage for Gargul in bytes
---
---@return number
function Profiler:getMemoryUsage()
    UpdateAddOnMemoryUsage();

    local usage = GetAddOnMemoryUsage("Gargul");

    return usage;
end
