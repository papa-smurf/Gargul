local L = Gargul_L;

---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

---@class ShortcutKeysLegendInterface
GL.Interface.ShortcutKeysLegend = {
    isVisible = false,
};
local ShortcutKeysLegend = GL.Interface.ShortcutKeysLegend; ---@type ShortcutKeysLegendInterface

-- To test:
-- 1. Loot a mob and leave the loot window open
-- 2. Then run /script _G.Gargul.Interface.ShortcutKeysLegend:draw();
function ShortcutKeysLegend:draw()
    -- The reminder is already visible
    if (self.isVisible) then
        return;
    end

    self.isVisible = true;

    local Parent = LootFrame;
    local ElvLootFrame = getglobal("ElvLootFrame");
    if (ElvLootFrame and ElvLootFrame:IsShown()) then
        Parent = ElvLootFrame;
    end

    -- Create a container/parent frame
    local Window = AceGUI:Create("InlineGroup");
    Window:SetLayout("Flow");
    Window:SetWidth(240);
    Window:SetHeight(30);
    Window:SetCallback("OnClose", function()
        self:close();
    end);
    Window.frame:SetScript("OnMouseDown", function(_, button)
        if (button == "RightButton") then
            GL.Settings:set("ShortcutKeys.showLegend", false);
            self:close();
        end
    end);
    Window.frame:SetParent(Parent);
    GL.Interface:set(self, "Window", Window);

    if (ElvLootFrame) then
        Window:SetPoint("TOPLEFT", Parent, "TOPRIGHT", 0, 17);
    else
        Window:SetPoint("TOPLEFT", Parent, "TOPRIGHT", 0, 9);
    end

    --[[
        DESCRIPTION LABEL
    ]]
    local DescriptionLabel = AceGUI:Create("Label");
    DescriptionLabel:SetFullWidth(true);
    DescriptionLabel:SetFontObject(_G["GameFontNormalSmall"]);
    DescriptionLabel:SetText((L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"]):format(
        GL.Settings:get("ShortcutKeys.rollOffOrAuction"),
        GL.Settings:get("ShortcutKeys.award"),
        GL.Settings:get("ShortcutKeys.disenchant")
    ));
    DescriptionLabel:SetColor(1, .95686, .40784);
    DescriptionLabel:SetJustifyH("CENTER")
    Window:AddChild(DescriptionLabel);
end

---@return void
function ShortcutKeysLegend:close()
    local Window = GL.Interface:get(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    Window.frame:Hide();
    self.isVisible = false;
end
