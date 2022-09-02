local _, GL = ...;

---@class Commands
GL.Commands = GL.Commands or {
    CommandDescriptions = {
        awardondate = "In case you need to award something retroactively you can use this command: /gl awardOnDate [winnerName] [itemLink] [yy-mm-dd]",
        award = "Open the award window. Optionally accepts an ItemLink as an argument: /gl award [itemLink?]",
        boostedrolls = "Open the Boosted Rolls UI that allows you to easily manage roll boosts.",
        buffs = "You can instantly check player buffs like Ony, ZG, but also protection consumables like shadow protection: /gl buffs 22888, 22818, 22817, 22820, 24425, 15366, 20079",
        clearplusones = "Clear all plus one values",
        cleardisenchanter = "Clear the disenchanter entry so you can pick a new one the next time around",
		setdisenchanter = "Sets the disenchanter entry directly without having to select one: /gl sd mydisenchanter",
        dft = "Open the DFT importer. Data exported from your DFT sheet can be imported here",
        export = "Export dropped loot to a CSV format which is compatible with TMB for example.",
        groups = "Open the group window where you can provide a roster from csv/raidhelper/wowhead so that you can: see who's missing and sort groups automatically",
        import = "Opens the general import window that includes shortcuts to the TMB, SoftRes or loot priority importers",
        inspect = "You can check whether players brought items (and how many), e.g. to check for consumables (requires players to have Gargul!): /gl inspect itemID1, itemID2, itemID3",
        lootpriority = "Open the loot priority editor where you can edit / clear loot priorities. These are the same priorities as imported by the TMB importer, clearing them here clears them for TMB as well",
        packmule = "Open PackMule which allows you to automatically funnel dropped gear to specific players, very helpful with green items for example",
        plusones = "Open the PlusOnes window that allows you to check and manipulate all plus one values",
        raidcsv = "Output everyone currently in the group in a CSV format",
        rolloff = "Open the RollOff UI where you can announce an item for players to roll on: /gl award [itemLink?]",
        softreserves = "Open either the SoftRes import window if there's no data available or open the SoftRes overview",
        settings = "Open the settings menu",
        thatsmybis = "Open the TMB importer. Data exported from tmb.com can be imported here",
        version = "Compare your Gargul version with everyone in your group and shows you exactly who needs to upgrade or who doesn't have the addon installed",
    },

    ShorthandDictionary = {
        br = "boostedrolls",
        boosted = "boostedrolls",
        boostedroll = "boostedrolls",
        points = "boostedrolls",
        co = "settings",
        config = "settings",
        ro = "rolloff",
        roll = "rolloff",
        a = "award",
        aod = "awardondate",
        cd = "cleardisenchanter",
		sd = "setdisenchanter",
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
        im = "import",
        ex = "export",
        ve = "version",
        ins = "inspect",
        bu = "buffs",
        ["+1"] = "plusones",
        plusone = "plusones",
        po = "plusones",
        cpo = "clearplusones",
        clearplusone = "clearplusones",
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
                if (GL:getItemIdFromLink(winner)) then
                    itemLink = winner;
                end

                return GL.Interface.Award:draw(itemLink);
            end

            GL.AwardedLoot:addWinner(...);
        end,

        -- Award an item on a given date. Useful if you forgot to award an item and want to do it later
        awardondate = function(...) GL.AwardedLoot:addWinnerOnDate(...); end,

        -- Open the boosted rolls window
        boostedrolls = function() GL.BoostedRolls:draw(); end,

        -- Export the current raid roster to csv
        raidcsv = function ()
            GL.RaidGroups:toCSV();
        end,

        -- Open the raid groups window
        groups = function() GL.RaidGroups:drawImporter(); end,

        -- Open the soft reserves window
        softreserves = function() GL.SoftRes:draw(); end,

        -- Open the plus ones window
        plusones = function() GL.Interface.PlusOnes.Overview:draw(); end,

        -- Clear the disenchanter
        cleardisenchanter = function () GL.PackMule:clearDisenchanter(); end,
		
		-- sets the disenchanter
		setdisenchanter = function (...) GL.PackMule:setDisenchanter(...); end,

        -- Clear all plus ones
        clearplusones = function() GL.PlusOnes:clear(); end,

        -- Open the TMB window
        thatsmybis = function() GL.TMB:draw(); end,

        -- Open the TMB window with DFT skin
        dft = function() GL.TMB:draw(true); end,

        -- Open the pack mule window
        packmule = function() GL.Settings:draw("PackMule"); end,

        -- Open the loot priority window
        lootpriority = function() GL.LootPriority:drawImporter(); end,

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
    }
};

local Commands = GL.Commands; ---@type Commands

--- Display the command help
---@return void
function Commands:help () GL.Settings:draw("SlashCommands"); end

--- Helper method to call commands from within the addon
---
---@param str string
---@return any
function Commands:call(str)
    return Commands:_dispatch(str);
end

--- This method dispatches all slash commands to their final destination
---
---@param str string
---@return any
function Commands:_dispatch(str)
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
    local numberOfArguments;

    if (GL:inTable({"rolloff", "auction"}, command)) then
        numberOfArguments = 1;
    elseif (GL:inTable({"award"}, command)) then
        numberOfArguments = 2;
    elseif (GL:inTable({"awardondate"}, command)) then
        numberOfArguments = 3;
    end

    arguments = { strsplit(" ", argumentString, numberOfArguments) };

    GL:debug("Dispatching " .. str);

    if (command and self.Dictionary[command] and type(self.Dictionary[command]) == "function") then
        return self.Dictionary[command](unpack(arguments));
    end

    -- Show the list of commands unless the user disabled this feature
    if (GL.Settings:get("autoOpenCommandHelp")) then
        self:help();
    end
end;

GL:debug("Commands.lua");