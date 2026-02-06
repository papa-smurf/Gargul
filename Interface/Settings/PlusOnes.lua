---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class PlusOnesSettings
GL.Interface.Settings.PlusOnes = {
    description = "With plus ones you can keep track of how many items have been awarded to each player. Players with a lower plus one value can be given a higher priority on rolls to help equalize loot distribution amongst players"
};
local PlusOnes = GL.Interface.Settings.PlusOnes; ---@type PlusOnesSettings

---@return nil
function PlusOnes:draw(Parent)
    GL:debug("PlusOnesSettings:draw");

    local HorizontalSpacer;
    local Checkboxes = {
        {
            label = "Block shared data",
            description = "Block shared +1s data from other players in your raid.\nEnabling this also blocks players on your allowed list.",
            setting = "PlusOnes.blockShareData",
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

    local OpenDataButton = GL.AceGUI:Create("Button");
    OpenDataButton:SetText("Open Plus Ones Data");
    OpenDataButton:SetCallback("OnClick", function()
        GL.Settings:close();
        GL.Commands:call("plusone");
    end);
    Parent:AddChild(OpenDataButton);
end

GL:debug("Interface/Settings/PlusOnes.lua");