---@type GL
local _, GL = ...;

GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

local AceGUI = GL.AceGUI;

---@class ShortcutKeysLegendInterface
GL.Interface.ShortcutKeysLegend = {
    isVisible = false,
};
local ShortcutKeysLegend = GL.Interface.ShortcutKeysLegend; ---@type ShortcutKeysLegendInterface

---@return void
function ShortcutKeysLegend:draw()
    GL:debug("ShortcutKeysLegend:draw");

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
    DescriptionLabel:SetText(string.format(
        "Gargul Item Hotkeys\n\nRoll out: |c00a79eff%s|r\nAward: |c00a79eff%s|r\nDisenchant: |c00a79eff%s|r\n\n\n-- Right-click to disable this window --",
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
    GL:debug("ShortcutKeysLegend:close");

    local Window = GL.Interface:get(self, "Window");

    if (not self.isVisible
        or not Window
    ) then
        return;
    end

    Window.frame:Hide();
    self.isVisible = false;
end

GL:debug("ShortcutKeysLegend.lua");