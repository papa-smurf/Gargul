---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class PlusOnesSettings
GL.Interface.Settings.PlusOnes = {
    description = "With plus ones you can keep track of how many MS items have been awarded to each player by adding +1 to their plus one total for each MS item awarded. Those players with lower total plus one can be given a higher priority on rolls to help equalize loot distribution amongs all players."
};
local PlusOnes = GL.Interface.Settings.PlusOnes; ---@type PlusOnesSettings

---@return void
function PlusOnes:draw(Parent)
    GL:debug("PlusOnesSettings:draw");

    local HorizontalSpacer;
    local Checkboxes = {
        {
            label = "Enable plus ones",
            description = "When enabled, the plus one button will be displayed in the award window and plus ones will be tracked",
            setting = "PlusOnes.enabled",
        },

        {
            label = "Automatically share data",
            description = "Automatically share PlusOnes data with players who join your raid.",
            setting = "PlusOnes.automaticallyShareData",
        },
        {
            label = "Whisper command",
            description = string.format(
                "Players can whisper '|cff%s!plusone [<name>]|r' or '|cff%s!po [<name>]|r' or '|cff%s!+1 [<name>]|r' to the master looter to get the current plus one for this name in response. If no name is given, their own name is assumed instead.",
                GL:classHexColor("rogue"),
                GL:classHexColor("rogue"),
                GL:classHexColor("rogue")
            ),
            setting = "PlusOnes.enableWhisperCommand",
        },
    };

    Overview:drawCheckboxes(Checkboxes, Parent);

    HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(15);
    Parent:AddChild(HorizontalSpacer);

    local PlusOnesIdentifier = GL.AceGUI:Create("EditBox");
    PlusOnesIdentifier:DisableButton(true);
    PlusOnesIdentifier:SetHeight(20);
    PlusOnesIdentifier:SetFullWidth(true);
    PlusOnesIdentifier:SetText(GL.Settings:get("PlusOnes.automaticallyAcceptDataFrom", ""));
    PlusOnesIdentifier:SetLabel(string.format(
        "|cff%sAdd a comma separated list of players that are allowed to overwrite your data without your explicit consent:|r",
        GL:classHexColor("rogue")
    ));
    PlusOnesIdentifier:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string") then
            return;
        end

        GL.Settings:set("PlusOnes.automaticallyAcceptDataFrom", value:gsub(" ", ""));
    end);
    Parent:AddChild(PlusOnesIdentifier);

    local PlusOnesIdentifier = GL.AceGUI:Create("EditBox");
    PlusOnesIdentifier:DisableButton(true);
    PlusOnesIdentifier:SetHeight(20);
    PlusOnesIdentifier:SetFullWidth(true);
    PlusOnesIdentifier:SetMaxLetters(3);
    PlusOnesIdentifier:SetText(GL.Settings:get("PlusOnes.identifier", "PO"));
    PlusOnesIdentifier:SetLabel(string.format(
        "|cff%sThe 'Identifier' is the text shown on the button (maximum 3 characters).|r",
        GL:classHexColor("rogue")
    ));
    PlusOnesIdentifier:SetCallback("OnTextChanged", function (self)
        local value = self:GetText();

        if (type(value) ~= "string"
            or GL:empty(value)
        ) then
            return;
        end

        GL.Settings:set("PlusOnes.identifier", strtrim(value));
    end);
    Parent:AddChild(PlusOnesIdentifier);

    local OpenDataButton = GL.AceGUI:Create("Button");
    OpenDataButton:SetText("Open Plus Ones Data");
    OpenDataButton:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("plusone");
    end);
    Parent:AddChild(OpenDataButton);
end

GL:debug("Interface/Settings/PlusOnes.lua");