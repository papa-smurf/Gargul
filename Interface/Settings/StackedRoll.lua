---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class StackedRollSettings
GL.Interface.Settings.StackedRoll = {
    description = "This allows to enable an extra button for stacked rolls. Players will need to keep track of their stacked points for the button to yield the correct roll. The addon will remind them when joining a raid group or being awarded an item to update their roll."
};
local StackedRoll = GL.Interface.Settings.StackedRoll; ---@type StackedRollSettings

---@return void
function StackedRoll:draw(Parent)
    GL:debug("StackedRollSettings:draw");

    local HorizontalSpacer;
    local Checkboxes = {
        {
            label = "Enable stacked rolls",
            description = "When enabled, the stacked roll button will be displayed in the rolling window",
            setting = "StackedRoll.enabled",
        },
        {
            label = "Raid reminder",
            description = "When enabled, the points update window will automatically be opened when joining a raid group",
            setting = "StackedRoll.raidUpdateReminder",
        },
        {
            label = "Item reminder",
            description = "When enabled, the points update window will automatically be opened when being awarded an item",
            setting = "StackedRoll.itemUpdateReminder",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(15);
    Parent:AddChild(HorizontalSpacer);

    local SortingPriority = GL.AceGUI:Create("EditBox");
    SortingPriority:DisableButton(true);
    SortingPriority:SetHeight(20);
    SortingPriority:SetFullWidth(true);
    SortingPriority:SetMaxLetters(1);
    SortingPriority:SetText(GL.Settings:get("StackedRoll.priority"));
    SortingPriority:SetLabel(string.format(
        "|cff%sThe 'Priority' field determines how rolls will be sorted in the roll tracking table (priority 1 is the highest priority).|r",
        GL:classHexColor("rogue")
    ));
    SortingPriority:SetCallback("OnTextChanged", function (self)
        local value = tonumber(strtrim(self:GetText()));

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        GL.Settings:set("StackedRoll.priority", value);
    end);
    Parent:AddChild(SortingPriority);

    local StackedRollIdentifier = GL.AceGUI:Create("EditBox");
    StackedRollIdentifier:DisableButton(true);
    StackedRollIdentifier:SetHeight(20);
    StackedRollIdentifier:SetFullWidth(true);
    StackedRollIdentifier:SetMaxLetters(3);
    StackedRollIdentifier:SetText(GL.Settings:get("StackedRoll.identifier"));
    StackedRollIdentifier:SetLabel(string.format(
        "|cff%sThe 'Identifier' is the text shown on the button (maximum 3 characters).|r",
        GL:classHexColor("rogue")
    ));
    StackedRollIdentifier:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        GL.Settings:set("StackedRoll.identifier", strtrim(value));
    end);
    Parent:AddChild(StackedRollIdentifier);

    local StackedRollReserveThreshold = GL.AceGUI:Create("EditBox");
    StackedRollReserveThreshold:DisableButton(true);
    StackedRollReserveThreshold:SetHeight(20);
    StackedRollReserveThreshold:SetFullWidth(true);
    StackedRollReserveThreshold:SetText(GL.Settings:get("StackedRoll.reserveThreshold"));
    StackedRollReserveThreshold:SetLabel(string.format(
        "|cff%sThe maximum roll, everything above is the 'reserve'.|r",
        GL:classHexColor("rogue")
    ));
    StackedRollReserveThreshold:SetCallback("OnTextChanged", function (self)
        local value = GL.StackedRoll:toPoints(strtrim(self:GetText()));

        if not value then
            return;
        end

        GL.Settings:set("StackedRoll.reserveThreshold", value);
    end);
    Parent:AddChild(StackedRollReserveThreshold);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(15);
    Parent:AddChild(HorizontalSpacer);

    local StackedRollCurrentPoints = GL.AceGUI:Create("EditBox");
    StackedRollCurrentPoints:DisableButton(true);
    StackedRollCurrentPoints:SetHeight(20);
    StackedRollCurrentPoints:SetFullWidth(true);
    StackedRollCurrentPoints:SetText(GL.Settings:get("StackedRoll.currentPoints"));
    StackedRollCurrentPoints:SetLabel(string.format(
        "|cff%sThe current points (including the reserve).|r",
        GL:classHexColor("rogue")
    ));
    StackedRollCurrentPoints:SetCallback("OnTextChanged", function (self)
        local value = GL.StackedRoll:toPoints(strtrim(self:GetText()));

        if not value then
            return;
        end

        GL.Settings:set("StackedRoll.currentPoints", value);
    end);
    Parent:AddChild(StackedRollCurrentPoints);

    local OpenPointModifier = GL.AceGUI:Create("Button");
    OpenPointModifier:SetText("Open Points Window");
    OpenPointModifier:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("points");
    end);
    Parent:AddChild(OpenPointModifier);
end

GL:debug("Interface/Settings/StackedRoll.lua");