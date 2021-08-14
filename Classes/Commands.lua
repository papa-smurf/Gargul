local _, GL = ...;

GL.Commands = GL.Commands or {
    CommandDescriptions = {
        settings = "Open the settings menu",
        rolloff = "Open the RollOff UI where you can announce an item for players to roll on: /gl award [itemLink?]",
        award = "Open the award window. Optionally accepts an ItemLink as an argument: /gl award [itemLink?]",
        awardOnDate = "In case you need to award something retrospectively you can use this command: /gl awardOnDate [winnerName] [itemLink] [yy-mm-dd]",
        raidcsv = "Output everyone currently in the group in a CSV format",
        groups = "Open the group window where you can provide a group csv so that you can: see who's missing and sort groups automatically",
        softreserves = "Open either the SoftRes import window if there's no data available or open the SoftRes overview",
        thatsmybis = "Open the TMB importer. Data exported from tmb.com can be imported here",
        packmule = "Open PackMule which allows you to automatically funnel dropped gear to specific players, very helpful with green items for example",
        lootpriority = "Open the loot priority editor where you can import loot priorities separately from That's My BIS (covered here) or do it manually in the loot priority editor which you can open",
        stacktrace = "Shows a list of all of the debug messages stored by Gargul, this can be helpful for debugging errors",
        import = "Opens the general import window that includes shortcuts to the TMB, SoftRes or loot priority importers",
        export = "Export dropped loot to a CSV format which is compatible with TMB for example.",
        version = "Compare your Gargul version with everyone in your group and shows you exactly who needs to upgrade or who doesn't have the addon installed",
        inspect = "You can check whether players brought items (and how many), e.g. to check for consumables (requires players to have Gargul!): /gl inspect itemId1, itemId2, itemId3",
        buffs = "You can instantly check player buffs like Ony, ZG, but also protection consumables like shadow protection: /gl buffs 22888, 22818, 22817, 22820, 24425, 15366, 20079",
    },

    ShorthandDictionary = {
        co = "settings",
        config = "settings",
        ro = "rolloff",
        ro = "rolloff",
        roll = "rolloff",
        a = "award",
        aod = "awardOnDate",
        rcsv = "raidcsv",
        gr = "groups",
        roster = "groups",
        so = "softreserves",
        sr = "softreserves",
        pm = "packmule",
        tmb = "thatsmybis",
        wl = "thatsmybis",
        lo = "lootpriority",
        pr = "lootpriority",
        priority = "lootpriority",
        bi = "bid",
        st = "stacktrace",
        im = "import",
        ex = "export",
        br = "broadcast",
        ve = "version",
        ins = "inspect",
        bu = "buffs",
    },

    Dictionary = {
        -- Open the settings menu
        settings = function(...) GL.Settings:draw(); end,

        -- Open the window for rolling off items
        rolloff = function(...) GL.MasterLooterUI:draw(...); end,

        -- Award an item. This either award it directly or opens the UI
        award = function(...)
            local winner, itemLink = ...;

            if (not winner or winner == "" or not itemLink) then
                return GL.Interface.Award:draw();
            end

            GL.AwardedLoot:addWinner(...);
        end,

        -- Award an item on a given date. Useful if you forgot to award an item and want to do it later
        awardOnDate = function(...) GL.AwardedLoot:addWinnerOnDate(...); end,

        -- Export the current raid roster to csv
        raidcsv = function ()
            GL.RaidGroups:toCSV();
        end,

        -- Open the raid groups window
        groups = function() GL.RaidGroups:drawImporter(); end,

        -- Open the soft reserves window
        softreserves = function() GL.SoftRes:draw(); end,

        -- Open the TMB window
        thatsmybis = function() GL.TMB:drawImporter(); end,

        -- Open the pack mule window
        packmule = function() GL.PackMuleUI:drawSetupWindow(); end,

        -- Open the loot priority window
        lootpriority = function() GL.LootPriority:drawImporter(); end,

        -- Output all debug lines in a readable manner
        stacktrace = function() GL:stacktrace(); end,

        -- Import data from our website into the addon
        import = function() GL.Interface.Importer:draw(); end,

        -- Export data from the addon to use on our website
        export = function() GL.Exporter:draw(); end,

        -- Check if everyone is running the most up-to-date version
        version = function() GL.Version:inspectGroup(); end,

        -- Check if everyone is running the most up-to-date version
        inspect = function(...) GL.BagInspector:inspect(...); end,

        -- Check if everyone is running the most up-to-date version
        buffs = function(...) GL.BuffInspector:inspect(...); end,

        -- Toggle Gargul's testmode
        test = function(...) GL.testMode = not GL.testMode; end,
    }
};

local Commands = GL.Commands;

-- Display the command help
function Commands:help () GL.Settings:draw("SlashCommands"); end

-- Helper method to call commands from within the addon
function Commands:call (str)
    return Commands:_dispatch (str);
end

-- This method dispatches all slash commands to their final destination
function Commands:_dispatch (str)
    GL.User:refresh();

    local command = str:match("^(%S+)");
    local argumentString = "";

    if (command) then
        argumentString = strsub(str, strlen(command) + 2);
    end

    if (not str or #str < 1) then
        -- User entered "/gl" with no additional arguments
        command = "settings";
    end

    -- Fetch the actual command name in case a shorthand is provided
    command = GL:tableGet(self.ShorthandDictionary, command, command);

    -- Some commands allow itemlinks, some don't. Items can contain spaces
    -- at which point we need to make sure the item itself isn't split up.
    -- We do that by specifying the number of (expected) arguments per command
    local arguments = {};
    local possibleArgumentChunks = nil;

    if (GL:inTable({"rolloff", "auction"}, command)) then
        numberOfArguments = 1;
    elseif (GL:inTable({"award"}, command)) then
        numberOfArguments = 2;
    elseif (GL:inTable({"awardOnDate"}, command)) then
        numberOfArguments = 3;
    end

    arguments = { strsplit(" ", argumentString, numberOfArguments) };

    GL:debug("Dispatching " .. str);

    if (command and self.Dictionary[command] and type(self.Dictionary[command]) == "function") then
        return self.Dictionary[command](unpack(arguments));
    end

    return self:help();
end;

-- Add slash command
SLASH_GIAL1 = "/gl";
SlashCmdList.GIAL = function (...)
    GL.User:refresh();

    Commands:_dispatch(...);
end;

GL:debug("Commands.lua");