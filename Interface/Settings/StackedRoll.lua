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
    SortingPriority:SetText(GL.Settings:get("StackedRoll.priority", 1));
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
    StackedRollIdentifier:SetText(GL.Settings:get("StackedRoll.identifier", "ST"));
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
    StackedRollReserveThreshold:SetText(GL.Settings:get("StackedRoll.reserveThreshold", 0));
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

    local StackedRollDefaultPoints = GL.AceGUI:Create("EditBox");
    StackedRollDefaultPoints:DisableButton(true);
    StackedRollDefaultPoints:SetHeight(20);
    StackedRollDefaultPoints:SetFullWidth(true);
    StackedRollDefaultPoints:SetText(GL.Settings:get("StackedRoll.defaultPoints", 0));
    StackedRollDefaultPoints:SetLabel(string.format(
        "|cff%sThe default points assigned to players.|r",
        GL:classHexColor("rogue")
    ));
    StackedRollDefaultPoints:SetCallback("OnTextChanged", function (self)
        local value = GL.StackedRoll:toPoints(strtrim(self:GetText()));

        if not value then
            return;
        end

        GL.Settings:set("StackedRoll.defaultPoints", value);
    end);
    Parent:AddChild(StackedRollDefaultPoints);

    local StackedRollDefaultCost = GL.AceGUI:Create("EditBox");
    StackedRollDefaultCost:DisableButton(true);
    StackedRollDefaultCost:SetHeight(20);
    StackedRollDefaultCost:SetFullWidth(true);
    StackedRollDefaultCost:SetText(GL.Settings:get("StackedRoll.defaultCost", 0));
    StackedRollDefaultCost:SetLabel(string.format(
        "|cff%sThe default cost for items awarded (can be changed when awarding it).|r",
        GL:classHexColor("rogue")
    ));
    StackedRollDefaultCost:SetCallback("OnTextChanged", function (self)
        local value = GL.StackedRoll:toPoints(strtrim(self:GetText()));

        if not value then
            return;
        end

        GL.Settings:set("StackedRoll.defaultCost", value);
    end);
    Parent:AddChild(StackedRollDefaultCost);

    local StackedRollDefaultStep = GL.AceGUI:Create("EditBox");
    StackedRollDefaultStep:DisableButton(true);
    StackedRollDefaultStep:SetHeight(20);
    StackedRollDefaultStep:SetFullWidth(true);
    StackedRollDefaultStep:SetText(GL.Settings:get("StackedRoll.defaultStep", 0));
    StackedRollDefaultStep:SetLabel(string.format(
        "|cff%sThe default step when modifying points.|r",
        GL:classHexColor("rogue")
    ));
    StackedRollDefaultStep:SetCallback("OnTextChanged", function (self)
        local value = GL.StackedRoll:toPoints(strtrim(self:GetText()));

        if not value then
            return;
        end

        GL.Settings:set("StackedRoll.defaultStep", value);
    end);
    Parent:AddChild(StackedRollDefaultStep);

    local OpenDataButton = GL.AceGUI:Create("Button");
    OpenDataButton:SetText("Open Stacked Rolls Data");
    OpenDataButton:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("points");
    end);
    Parent:AddChild(OpenDataButton);
end

GL:debug("Interface/Settings/StackedRoll.lua");