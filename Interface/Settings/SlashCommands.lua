---@type GL
local _, GL = ...;

local Overview = GL.Interface.Settings.Overview; ---@type SettingsOverview

---@class SlashCommandsSettings
GL.Interface.Settings.SlashCommands = {
    description = "There are many shorthand slash commands available in Gargul to help speed up your instance runs. Keep in mind that you can use both /gl and /gargul as a prefix for the commands and their shorthands listed below!\n",
    hiddenCommands = {
        "test",
    },
};
local SlashCommands = GL.Interface.Settings.SlashCommands; ---@type SlashCommandsSettings

---@return nil
function SlashCommands:draw(Parent)
    GL:debug("SlashCommandsSettings:draw");

    local CommandDescriptions = GL.Commands.CommandDescriptions;
    local ShorthandDictionary = GL.Commands.ShorthandDictionary;
    local Commands = {};
    local CommandsWithShorthands = {};

    for command in pairs(CommandDescriptions) do
        CommandsWithShorthands[command] = {};
    end

    for shorthand, command in pairs(ShorthandDictionary) do
        if (CommandsWithShorthands[command]) then
            tinsert(CommandsWithShorthands[command], shorthand);
        end
    end

    for command, Shorthands in pairs(CommandsWithShorthands) do
        if (not GL:inTable(self.hiddenCommands, command)) then
            tinsert(Commands, {
                command = command,
                Shorthands = Shorthands,
                description = CommandDescriptions[command] or "",
            });
        end
    end

    -- Sort the commands alphabetically
    table.sort(Commands, function (a, b)
        if (a.command and b.command) then
            return a.command:sub(1, 1) < b.command:sub(1, 1);
        end

        return false;
    end);

    Overview:drawCheckboxes({
        {
            label = "Open on faulty command",
            description = "This window will automatically open if you try to run a command that doesn't exist",
            setting = "autoOpenCommandHelp",
        }
    }, Parent);

    local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
    HorizontalSpacer:SetLayout("FILL");
    HorizontalSpacer:SetFullWidth(true);
    HorizontalSpacer:SetHeight(20);
    Parent:AddChild(HorizontalSpacer);

    for _, Entry in pairs(Commands) do
        local CommandLabel = GL.AceGUI:Create("Label");
        CommandLabel:SetText("/gl " .. Entry.command);
        CommandLabel:SetFontObject(_G.GameFontNormal);
        CommandLabel:SetColor(1, .95686, .40784);
        CommandLabel:SetWidth(120);
        Parent:AddChild(CommandLabel);

        if (not GL:empty(Entry.Shorthands)) then
            local CommandShorthands = GL.AceGUI:Create("Label");
            CommandShorthands:SetText("Shorthands: /gl " .. table.concat(Entry.Shorthands, " /gl "));
            CommandShorthands:SetFontObject(_G.GameFontNormalSmall);
            CommandShorthands:SetColor(.95686, .5490, .72941);
            Parent:AddChild(CommandShorthands);
        end

        local CommandDescription = GL.AceGUI:Create("Label");
        CommandDescription:SetText(Entry.description);
        CommandDescription:SetFullWidth(true);
        CommandDescription:SetFontObject(_G.GameFontNormalSmall);
        Parent:AddChild(CommandDescription);

        local HorizontalSpacer = GL.AceGUI:Create("SimpleGroup");
        HorizontalSpacer:SetLayout("FILL");
        HorizontalSpacer:SetFullWidth(true);
        HorizontalSpacer:SetHeight(20);
        Parent:AddChild(HorizontalSpacer);
    end
end

GL:debug("Interface/Settings/SlashCommands.lua");