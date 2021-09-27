---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

---@class ReminderToAssignLootUsingGargulInterface
GL.Interface.ReminderToAssignLootUsingGargul = {
    isVisible = false,
};
local ReminderToAssignLootUsingGargul = GL.Interface.ReminderToAssignLootUsingGargul; ---@type ReminderToAssignLootUsingGargulInterface

---@return void
function ReminderToAssignLootUsingGargul:draw()
    GL:debug("ReminderToAssignLootUsingGargul:draw");

    -- The reminder is already visible
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    -- Create a container/parent frame
    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(220);
    Window:SetHeight(30);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window.frame:SetScript("OnMouseDown", function(_, button)
        if (button == "RightButton") then
            GL.Settings:set("TMB.showLootAssignmentReminder", false);
            self:close();
        end
    end);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint("TOPLEFT", MasterLooterFrame, "TOPRIGHT", 0, 9);

    --[[
        DESCRIPTION LABEL
    ]]
    local DescriptionLabel = AceGUI:Create("Label");
    DescriptionLabel:SetFullWidth(true);
    DescriptionLabel:SetFontObject(_G["GameFontNormalSmall"]);
    DescriptionLabel:SetText("Don't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --");
    DescriptionLabel:SetColor(1, .95686, .40784);
    DescriptionLabel:SetJustifyH("CENTER")
    Window:AddChild(DescriptionLabel);
end

---@return void
function ReminderToAssignLootUsingGargul:close()
    GL:debug("ReminderToAssignLootUsingGargul:close");

    local Window = GL.Interface:getItem(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    Window.frame:Hide();
    self.isVisible = false;
end

GL:debug("ReminderToAssignLootUsingGargul.lua");