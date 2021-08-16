---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class ExportingLootSettings
GL.Interface.Settings.ExportingLoot = {
    description = "Gargul keeps track of all loot awarded via /gl award or via one of the shortcuts (see the 'Awarding Loot' section on the left). Items awarded this way can be exported in order to share loot data with TMB, archiving purposes or audits. To export items you can run '/gl export' or Shift+Right-click the Gargul minimap icon.",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Export-To-TMB",
};
local ExportingLoot = GL.Interface.Settings.ExportingLoot; ---@type ExportingLootSettings

---@return void
function ExportingLoot:draw(Parent)
    GL:debug("ExportingLootSettings:draw");

    local OpenExporter = GL.AceGUI:Create("Button");
    OpenExporter:SetText("Open Exporter");
    OpenExporter:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("export");
    end);
    Parent:AddChild(OpenExporter);
end

GL:debug("Interface/Settings/ExportingLoot.lua");