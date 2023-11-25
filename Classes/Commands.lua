local _, GL = ...;

---@type Settings
local Settings = GL.Settings;

---@class Commands
GL.Commands = GL.Commands or {
    CommandDescriptions = {
        auction = "Open the Auctioneer UI where you can auction off items for a GDKP session (requires an active GDKP session!)",
        awardondate = "In case you need to award something retroactively you can use this command: /gl awardOnDate [winnerName] [yy-mm-dd] [itemLink]",
        award = "Open the award window. Optionally accepts an ItemLink as an argument: /gl award [itemLink?]",
        awardhistory = "Open the award history window which shows recently awarded items and their rolls",
        bid = "Open the window which lets you bid during a GDKP multi-auction",
        boostedrolls = "Open the Boosted Rolls UI that allows you to easily manage roll boosts.",
        buffs = "You can instantly check player buffs like Ony, ZG, but also protection consumables like shadow protection: /gl buffs 22888, 22818, 22817, 22820, 24425, 15366, 20079",
        bugreport = "Include the output of this command when filing a bug report on the Gargul discord server",
        clearplusones = "Clear all plus one values",
        cleardisenchanter = "Clear the disenchanter entry so you can pick a new one the next time around",
        setdisenchanter = "Sets the disenchanter entry directly without having to select one: /gl sd [mydisenchanter]",
        dft = "Open the DFT importer. Data exported from your DFT sheet can be imported here",
        cpr = "Open the classicpr importer. Data exported from https://classicpr.io/ can be imported here",
        export = "Export dropped loot to a CSV format which is compatible with TMB for example.",
        gdkp = "Open the GDKP UI where you can manage your GDKP sessions",
        groups = "Open the group window where you can provide a roster from csv/raidhelper/wowhead so that you can: see who's missing and sort groups automatically",
        import = "Opens the general import window that includes shortcuts to the TMB, SoftRes or loot priority importers",
        importprices = "Open an import window with which you can import per-product minimum and increment settings",
        inspect = "You can check whether players brought items (and how many), e.g. to check for consumables (requires players to have Gargul!): /gl inspect itemID1, itemID2, itemID3",
        lootpriority = "Open the loot priority editor where you can edit / clear loot priorities. These are the same priorities as imported by the TMB importer, clearing them here clears them for TMB as well",
        multiauction = "Auction off multiple items at once in your GDKP raids. This requires all participants to have an up-to-date version of Gargul!",
        packmule = "Open PackMule which allows you to automatically funnel dropped gear to specific players, very helpful with green items for example",
        plusones = "Open the PlusOnes window that allows you to check and manipulate all plus one values",
        raidcsv = "Output everyone currently in the group in a CSV format",
        resetui = "Reset Gargul's UI sizes and positions. Useful in case something went out of bounds!",
        resetsettings = "Reset Gargul's settings. This can't be undone!",
        rolloff = "Open the RollOff UI where you can announce an item for players to roll on: /gl award [itemLink?]",
        settings = "Open the settings menu",
        softreserves = "Open either the SoftRes import window if there's no data available or open the SoftRes overview",
        thatsmybis = "Open the TMB importer. Data exported from tmb.com can be imported here",
        version = "Compare your Gargul version with everyone in your group and shows you exactly who needs to upgrade or who doesn't have the addon installed",
    },

    ShorthandDictionary = {
        -- auction
        au = "auction",

        -- awardondate
        aod = "awardondate",

        -- award
        a = "award",

        -- awardhistory
        ah = "awardhistory",

        -- boostedrolls
        boosted = "boostedrolls",
        boostedroll = "boostedrolls",
        br = "boostedrolls",
        points = "boostedrolls",

        -- buffs
        bu = "buffs",

        -- bugreport
        bug = "bugreport",

        -- clearplusones
        clearplusone = "clearplusones",
        cpo = "clearplusones",

        -- cleardisenchanter
        cd = "cleardisenchanter",

        -- setdisenchanter
        sd = "setdisenchanter",

        -- cpr
        prio3 = "cpr",

        -- export
        ex = "export",

        -- gdkp
        gd = "gdkp",

        -- groups
        gr = "groups",
        roster = "groups",

        -- import
        im = "import",

        -- importprices
        ip = "importprices",

        -- inspect
        ins = "inspect",

        -- lootpriority
        lo = "lootpriority",
        pr = "lootpriority",
        priority = "lootpriority",

        -- multiauction
        ma = "multiauction",
        ba = "multiauction",
        batchauction = "multiauction",

        -- packmule
        pm = "packmule",

        -- plusones
        ["+1"] = "plusones",
        plusone = "plusones",
        po = "plusones",

        -- raidcsv
        rcsv = "raidcsv",

        -- rolloff
        ro = "rolloff",
        roll = "rolloff",

        -- settings
        co = "settings",
        config = "settings",

        -- softreserves
        so = "softreserves",
        softres = "softreserves",
        sr = "softreserves",

        -- thatsmybis
        tmb = "thatsmybis",
        wl = "thatsmybis",

        -- version
        ve = "version",
    },

    Dictionary = {
        -- Open the window for auctioning off items
        auction = function(...) GL.Interface.GDKP.Auctioneer:open(); end,

        -- Open the multi-auction bid UI
        bid = function ()
            GL.Interface.GDKP.MultiAuction.Client:open();
        end,

        -- Used to get a bnet ID hash for identification purposes
        bnid = function ()
            local bth = GL.User:bth();
            if (GL:empty(bth)) then
                print("Try again in a couple seconds!");

                return;
            end

            print(bth);
        end,

        -- Open the window for rolling off items
        rolloff = function(...) GL.MasterLooterUI:draw(...); end,

        -- Open the settings menu
        settings = function(...) Settings:draw(); end,

        -- Award an item. This either awards it directly or opens the UI
        award = function(...)
            local winner, itemLink = ...;

            if (GL:strContains(winner, "Hitem:")) then
                itemLink = winner .. itemLink;
                winner = nil;
            end

            if (not winner or winner == "" or not itemLink) then
                if (GL:getItemIDFromLink(winner)) then
                    itemLink = winner;
                end

                return GL.Interface.Award.Award:draw(itemLink);
            end

            GL.AwardedLoot:addWinner{
                winner = winner,
                itemLink = itemLink,
            };
        end,

        -- Toggle the award history window
        awardhistory = function ()
            GL.Interface.Award.Overview:open();
        end,

        -- Award an item on a given date. Useful if you forgot to award an item and want to do it later
        awardondate = function(...) GL.AwardedLoot:addWinnerOnDate(...); end,

        -- Open the boosted rolls window
        boostedrolls = function() GL.BoostedRolls:draw(); end,

        -- Generate a bug report
        bugreport = function() GL:bugReport(); end,

        -- Open the GDKP overview
        gdkp = function () GL.Interface.GDKP.Overview:open(); end,

        -- Open the raid groups window
        groups = function() GL.RaidGroups:drawImporter(); end,

        -- Open the GDKP minimum price / increment importer
        importprices = function()
            GL.Interface.GDKP.ImportPrices:open();
        end,

        -- Open the soft reserves window
        softreserves = function() GL.SoftRes:draw(); end,

        -- Open the plus ones window
        plusones = function() GL.Interface.PlusOnes.Overview:draw(); end,

        -- Clear the disenchanter
        cleardisenchanter = function () GL.PackMule:clearDisenchanter(); end,

        -- sets the disenchanter
        setdisenchanter = function (...) GL.PackMule:setDisenchanter(...); end,

        -- Clear all plus ones
        clearplusones = function() GL.PlusOnes:clearPlusOnes(); end,

        -- Export the current raid roster to csv
        raidcsv = function ()
            GL.RaidGroups:toCSV();
        end,

        resetui = function ()
            Settings:set("UI", {});
            C_UI.Reload();
        end,

        resetsettings = function ()
            GL.Settings.Active = {};
            C_UI.Reload();
        end,

        -- Open the TMB window
        thatsmybis = function() GL.TMB:draw(); end,

        -- Open the TMB window with DFT skin
        dft = function() GL.TMB:draw("dft"); end,

        -- Open the TMB window with CPR skin
        cpr = function() GL.TMB:draw("cpr"); end,

        -- Open the pack mule window
        packmule = function() Settings:draw("PackMule"); end,

        -- Open the loot priority window
        lootpriority = function() GL.LootPriority:drawImporter(); end,

        multiauction = function() GL.Interface.GDKP.MultiAuction.Auctioneer:open(); end,

        -- Import data from our website into the addon
        import = function() GL.Interface.Importer:open(); end,

        -- Export data from the addon to use on our website
        export = function() GL.Exporter:draw(); end,

        -- Check if everyone is running the most up-to-date version
        version = function() GL.Interface.GroupVersionCheck:open() end,

        -- Check if everyone is running the most up-to-date version
        inspect = function(...) GL.BagInspector:inspect(...); end,

        -- Check if everyone is running the most up-to-date version
        buffs = function(...) GL.BuffInspector:inspect(...); end,
    }
};

local Commands = GL.Commands; ---@type Commands

--- Display the command help
---@return void
function Commands:help () Settings:draw("SlashCommands"); end

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

    -- Make sure commands are case insensitive (Busmonstret = dumdum)
    command = string.lower(command);

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
    if (Settings:get("autoOpenCommandHelp")) then
        self:help();
    end
end;

GL:debug("Commands.lua");