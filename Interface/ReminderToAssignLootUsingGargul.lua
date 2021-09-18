---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;
local Settings = GL.Settings; ---@type Settings

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
    Window:SetWidth(MasterLooterFrame:GetWidth());
    Window:SetHeight(30);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    GL.Interface:setItem(self, "Window", Window);

    Window:SetPoint("TOPLEFT", MasterLooterFrame, "TOPRIGHT");

    --[[
        DESCRIPTION LABEL
    ]]
    local DescriptionLabel = AceGUI:Create("Label");
    DescriptionLabel:SetFullWidth(true);
    DescriptionLabel:SetFontObject(_G["GameFontNormalSmall"]);
    DescriptionLabel:SetText("Don't forget to use Gargul instead\nif you wish to export loot later");
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