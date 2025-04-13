local L = Gargul_L;

---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview
GL.AceGUI = GL.AceGUI or LibStub("AceGUI-3.0");

---@class ExportingLootSettings
GL.Interface.Settings.ExportingLoot = {
    description = "Items awarded using Gargul can be exported to TMB, DFT, or just about any other format you can think of. To export items run |c00A79EFF/gl export|r.",
    wikiUrl = "https://github.com/papa-smurf/Gargul/wiki/Export-To-TMB",
};
local ExportingLoot = GL.Interface.Settings.ExportingLoot; ---@type ExportingLootSettings
local Constants = GL.Data.Constants; ---@type Data

---@return void
function ExportingLoot:draw(Parent)
    GL:debug("ExportingLootSettings:draw");

    local HorizontalSpacer;
    local Checkboxes = {
        {
            label = "Include disenchanted items",
            setting = "ExportingLoot.includeDisenchantedItems",
            callback = function ()
                -- Refresh the export window if it's open
                if (GL.Exporter.visible) then
                    GL.Exporter:refreshExportString();
                end
            end
        },
        {
            label = "Include offspec items",
            setting = "ExportingLoot.includeOffspecItems",
            callback = function ()
                -- Refresh the export window if it's open
                if (GL.Exporter.visible) then
                    GL.Exporter:refreshExportString();
                end
            end
        },
        {
            label = "Show award reminder",
            description = "When assigning loot without using Gargul a reminder is shown to use Gargul instead in order to make exporting loot possible",
            setting = "ExportingLoot.showLootAssignmentReminder",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local DisenchanterIdentifier = GL.AceGUI:Create("EditBox");
    DisenchanterIdentifier:DisableButton(true);
    DisenchanterIdentifier:SetHeight(20);
    DisenchanterIdentifier:SetFullWidth(true);
    DisenchanterIdentifier:SetText(GL.Settings:get("ExportingLoot.disenchanterIdentifier"));
    DisenchanterIdentifier:SetLabel(string.format(
        "|cff%sMention disenchanted items under which name? (Default: _disenchanted). Note: |r|c00FF0000no hyhpens!|r",
        GL:classHexColor("rogue")
    ));
    DisenchanterIdentifier:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        GL.Settings:set("ExportingLoot.disenchanterIdentifier", value);

        -- Refresh the export window if it's open
        if (GL.Exporter.visible) then
            GL.Exporter:refreshExportString();
        end
    end);
    Parent:AddChild(DisenchanterIdentifier);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local ExportFormatLabel = GL.AceGUI:Create("Label");
    ExportFormatLabel:SetColor(1, .95686, .40784);
    ExportFormatLabel:SetText("The format in which awarded loot should be exported");
    ExportFormatLabel:SetHeight(20);
    ExportFormatLabel:SetFullWidth(true);
    Parent:AddChild(ExportFormatLabel);

    local DropDownItems = {
        [1] = "Thatsmybis TMB (default)",
        [5] = "Thatsmybis TMB with player realm",
        [2] = "DFT-Fight-Club (US date format)",
        [3] = "DFT-Fight-Club (EU date format)",
        [7] = "RRobin",
        [4] = "Custom (create your own format)",
        [6] = "Detailed (JSON)",
    };

    local ItemOrder = {
        1, 5, 2, 3, 7, 4, 6,
    };

    local CustomFormatWrapper;
    local ExportFormat = GL.AceGUI:Create("Dropdown");
    ExportFormat:SetValue(GL.Settings:get("ExportingLoot.format", Constants.ExportFormats.TMB));
    ExportFormat:SetList(DropDownItems, ItemOrder);
    ExportFormat:SetText(DropDownItems[GL.Settings:get("ExportingLoot.format", Constants.ExportFormats.TMB)]);
    ExportFormat:SetWidth(250);
    ExportFormat:SetCallback("OnValueChanged", function()
        GL.Settings:set("ExportingLoot.format", ExportFormat:GetValue());

        -- Refresh the export window if it's open
        if (GL.Exporter.visible) then
            GL.Exporter:refreshExportString();
        end

        if (ExportFormat:GetValue() == 4) then
            CustomFormatWrapper.frame:Show();
        else
            CustomFormatWrapper.frame:Hide();
        end
    end);
    Parent:AddChild(ExportFormat);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    CustomFormatWrapper = GL.AceGUI:Create("SimpleGroup");
    CustomFormatWrapper:SetFullWidth(true);
    Parent:AddChild(CustomFormatWrapper);

    local CustomExportFormat = GL.AceGUI:Create("EditBox");
    CustomExportFormat:DisableButton(true);
    CustomExportFormat:SetHeight(20);
    CustomExportFormat:SetFullWidth(true);
    CustomExportFormat:SetText(GL.Settings:get("ExportingLoot.customFormat"));
    CustomExportFormat:SetLabel(string.format(
        "|cff%sDefine your custom export format here. |cffC41E3AHover for more details. |cff%sNote: \\t is replaced by a tab!|r",
        GL:classHexColor("rogue"),
        GL:classHexColor("rogue")
    ));
    CustomExportFormat:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        GL.Settings:set("ExportingLoot.customFormat", value);

        -- Refresh the export window if it's open
        if (GL.Exporter.visible) then
            GL.Exporter:refreshExportString();
        end
    end);

    CustomExportFormat.frame:EnableMouse();
    CustomExportFormat.frame:SetScript("OnEnter", function ()
        GameTooltip:SetOwner(CustomFormatWrapper.frame, "ANCHOR_TOP");
        GameTooltip:SetText(string.format("Available values:\n\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n\n%s",
            "@ID",
            "@LINK",
            "@WOWHEAD",
            "@ITEM",
            "@ILVL",
            "@QUALITY",
            "@WINNER",
            "@REALM",
            "@DATE",
            "@OS",
            "@SR  |c00A79EFF(soft-reserved?)|r",
            "@WL |c00A79EFF(tmb wish?)|r",
            "@PL |c00A79EFF(tmb prio?)|r",
            "@TMB |c00A79EFF(tmb wish/prio?)|r",
            "@ROLLTYPE |c00A79EFF(MS, OS etc)|r",
            "@CHECKSUM",
            "@YEAR",
            "@YY",
            "@MONTH",
            "@DAY",
            "@HOUR",
            "@MINUTE",
            "@TIME",
            L["\\t is replaced by a tab"]
        ));
        GameTooltip:Show();
    end);
    CustomExportFormat.frame:SetScript("OnLeave", function ()
        GameTooltip:Hide();
    end);
    CustomFormatWrapper:AddChild(CustomExportFormat);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(10);
    Parent:AddChild(HorizontalSpacer);

    local OpenExporter = GL.AceGUI:Create("Button");
    OpenExporter:SetText("Open Exporter");
    OpenExporter:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("export");
    end);
    Parent:AddChild(OpenExporter);

    -- Hide the custom export format if custom is not selected
    if (GL.Settings:get("ExportingLoot.format") ~= 4) then
        CustomFormatWrapper.frame:Hide();
    end
end

GL:debug("Interface/Settings/ExportingLoot.lua");