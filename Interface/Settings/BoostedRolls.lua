---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class BoostedRollsSettings
GL.Interface.Settings.BoostedRolls = {
    description = "This allows to enable an extra button for boosted rolls. Players will need to keep track of their points for the button to yield the correct roll. The addon will remind them when joining a raid group or being awarded an item to update their roll."
};
local BoostedRolls = GL.Interface.Settings.BoostedRolls; ---@type BoostedRollsSettings

---@return void
function BoostedRolls:draw(Parent)
    GL:debug("BoostedRollsSettings:draw");

    local HorizontalSpacer;
    local Checkboxes = {
        {
            label = "Enable boosted rolls feature",
            description = "When enabled, the boosted roll button will be displayed in the rolling window",
            setting = "BoostedRolls.enabled",
        },
        {
            label = "Automatically share data",
            description = "Checking this means you'll automatically share BoostedRolls data with players who join your raid or when you import new BoostedRolls data",
            setting = "BoostedRolls.automaticallyShareData",
        },
        {
            label = "Enable whisper command",
            description = string.format(
                "When enabled, players can whisper '|cff%s!rollbonus [<name>]|r' or '|cff%s!rb [<name>]|r to the master looter to get the current boosted roll for this name in response. If no name is given, their own boosted roll is given.",
                GL:classHexColor("rogue"), GL:classHexColor("rogue")
            ),
            setting = "BoostedRolls.enableWhisperCommand",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(15);
    Parent:AddChild(HorizontalSpacer);

    local BoostedRollsIdentifier = GL.AceGUI:Create("EditBox");
    BoostedRollsIdentifier:DisableButton(true);
    BoostedRollsIdentifier:SetHeight(20);
    BoostedRollsIdentifier:SetFullWidth(true);
    BoostedRollsIdentifier:SetMaxLetters(3);
    BoostedRollsIdentifier:SetText(GL.Settings:get("BoostedRolls.automaticallyAcceptDataFrom", ""));
    BoostedRollsIdentifier:SetLabel(string.format(
        "|cff%sAdd a comma separated list of players that are allowed to overwrite your data without your explicit consent:|r",
        GL:classHexColor("rogue")
    ));
    BoostedRollsIdentifier:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        GL.Settings:set("BoostedRolls.automaticallyAcceptDataFrom", strtrim(value));
    end);
    Parent:AddChild(BoostedRollsIdentifier);

    local SortingPriority = GL.AceGUI:Create("EditBox");
    SortingPriority:DisableButton(true);
    SortingPriority:SetHeight(20);
    SortingPriority:SetFullWidth(true);
    SortingPriority:SetMaxLetters(1);
    SortingPriority:SetText(GL.Settings:get("BoostedRolls.priority", 1));
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

        GL.Settings:set("BoostedRolls.priority", value);
    end);
    Parent:AddChild(SortingPriority);

    local BoostedRollsIdentifier = GL.AceGUI:Create("EditBox");
    BoostedRollsIdentifier:DisableButton(true);
    BoostedRollsIdentifier:SetHeight(20);
    BoostedRollsIdentifier:SetFullWidth(true);
    BoostedRollsIdentifier:SetMaxLetters(3);
    BoostedRollsIdentifier:SetText(GL.Settings:get("BoostedRolls.identifier", "BR"));
    BoostedRollsIdentifier:SetLabel(string.format(
        "|cff%sThe 'Identifier' is the text shown on the button (maximum 3 characters).|r",
        GL:classHexColor("rogue")
    ));
    BoostedRollsIdentifier:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        GL.Settings:set("BoostedRolls.identifier", strtrim(value));
    end);
    Parent:AddChild(BoostedRollsIdentifier);

    local BoostedRollsReserveThreshold = GL.AceGUI:Create("EditBox");
    BoostedRollsReserveThreshold:DisableButton(true);
    BoostedRollsReserveThreshold:SetHeight(20);
    BoostedRollsReserveThreshold:SetFullWidth(true);
    BoostedRollsReserveThreshold:SetText(GL.Settings:get("BoostedRolls.reserveThreshold", 0));
    BoostedRollsReserveThreshold:SetLabel(string.format(
        "|cff%sThe maximum roll, everything above is the 'reserve'.|r",
        GL:classHexColor("rogue")
    ));
    BoostedRollsReserveThreshold:SetCallback("OnTextChanged", function (self)
        local value = GL.BoostedRolls:toPoints(strtrim(self:GetText()));

        if not value then
            return;
        end

        GL.Settings:set("BoostedRolls.reserveThreshold", value);
    end);
    Parent:AddChild(BoostedRollsReserveThreshold);

    local BoostedRollsDefaultPoints = GL.AceGUI:Create("EditBox");
    BoostedRollsDefaultPoints:DisableButton(true);
    BoostedRollsDefaultPoints:SetHeight(20);
    BoostedRollsDefaultPoints:SetFullWidth(true);
    BoostedRollsDefaultPoints:SetText(GL.Settings:get("BoostedRolls.defaultPoints", 0));
    BoostedRollsDefaultPoints:SetLabel(string.format(
        "|cff%sThe default points assigned to players.|r",
        GL:classHexColor("rogue")
    ));
    BoostedRollsDefaultPoints:SetCallback("OnTextChanged", function (self)
        local value = GL.BoostedRolls:toPoints(strtrim(self:GetText()));

        if not value then
            return;
        end

        GL.Settings:set("BoostedRolls.defaultPoints", value);
    end);
    Parent:AddChild(BoostedRollsDefaultPoints);

    local BoostedRollsDefaultCost = GL.AceGUI:Create("EditBox");
    BoostedRollsDefaultCost:DisableButton(true);
    BoostedRollsDefaultCost:SetHeight(20);
    BoostedRollsDefaultCost:SetFullWidth(true);
    BoostedRollsDefaultCost:SetText(GL.Settings:get("BoostedRolls.defaultCost", 0));
    BoostedRollsDefaultCost:SetLabel(string.format(
        "|cff%sThe default cost for items awarded (can be changed when awarding it).|r",
        GL:classHexColor("rogue")
    ));
    BoostedRollsDefaultCost:SetCallback("OnTextChanged", function (self)
        local value = GL.BoostedRolls:toPoints(strtrim(self:GetText()));

        if not value then
            return;
        end

        GL.Settings:set("BoostedRolls.defaultCost", value);
    end);
    Parent:AddChild(BoostedRollsDefaultCost);

    local BoostedRollsDefaultStep = GL.AceGUI:Create("EditBox");
    BoostedRollsDefaultStep:DisableButton(true);
    BoostedRollsDefaultStep:SetHeight(20);
    BoostedRollsDefaultStep:SetFullWidth(true);
    BoostedRollsDefaultStep:SetText(GL.Settings:get("BoostedRolls.defaultStep", 0));
    BoostedRollsDefaultStep:SetLabel(string.format(
        "|cff%sThe default step when modifying points.|r",
        GL:classHexColor("rogue")
    ));
    BoostedRollsDefaultStep:SetCallback("OnTextChanged", function (self)
        local value = GL.BoostedRolls:toPoints(strtrim(self:GetText()));

        if not value then
            return;
        end

        GL.Settings:set("BoostedRolls.defaultStep", value);
    end);
    Parent:AddChild(BoostedRollsDefaultStep);

    local OpenDataButton = GL.AceGUI:Create("Button");
    OpenDataButton:SetText("Open Boosted Rolls Data");
    OpenDataButton:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("points");
    end);
    Parent:AddChild(OpenDataButton);
end

GL:debug("Interface/Settings/BoostedRolls.lua");