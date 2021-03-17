local _, App = ...;

App.Commands = App.Commands or {};
local Commands = App.Commands;

-- Display the command help
function Commands:help ()
    App:message("---------------------");
    App:message("Commands:")
    App:message("/gl - Shows the dashboard");
    App:message("/gl version or /gl ve - Checks the addon version of everyone in the raid");
    App:message("/gl inspect or /gl ins - Check the groups bags for passed item ids");
    App:message("/gl stacktrace or /gl st - Displays a list of this session's debug lines");
    App:message("/gl rolloff or /gl roll or /gl ro - Displays the master looter window for rolling off items");
    App:message("/gl softreserves or /gl so - Opens the soft reserves window (master looter only)");
    App:message("/gl auction  or /gl au - Opens the auctioneer window for master looting purposes (officer only)");
    App:message("/gl bid or /gl bi - Reopens the bid window if you closed it");
    App:message("/gl import or /gl im - Opens the DKP / loot history import window (officer only)");
    App:message("/gl export or /gl ex - Opens the DKP / loot history export window (officer only)");
    App:message("/gl broadcast or /gl br - Broadcasts the DKP tables and loot history to the entire guild (officer only)");
    App:message("---------------------");
end

-- Open the dashboard or main hub if you will
Commands.dashboard = function() App.Dashboard:draw(); end

-- Open the auctioneer window (requires group and officer privileges)
Commands.auction = function(...) App.AuctioneerUI:draw(...); end
Commands.au = Commands.auction;

-- Open the window for rolling off items
Commands.rolloff = function(...) App.MasterLooterUI:draw(...); end
Commands.roll = Commands.rolloff;
Commands.ro = Commands.roll;

Commands.raidcsv = function ()
    App.RaidGroups:toCSV();
end
Commands.rcsv = Commands.raidcsv;

-- Open the raid gorups window
Commands.groups = function() App.RaidGroups:drawImporter(); end
Commands.gr = Commands.groups;

-- Open the soft reserves window
Commands.softreserves = function() App.SoftReserves:drawImporter(); end
Commands.so = Commands.softreserves;

-- Open the loot priority window
Commands.lootpriority = function() App.LootPriority:drawImporter(); end
Commands.lo = Commands.lootpriority;

Commands.bid = function() App.BidderUI:reopen(); end
Commands.bi = Commands.bid;

-- Output all debug lines in a readable manner
Commands.stacktrace = function() App:stacktrace(); end
Commands.st = Commands.stacktrace;

-- Import data from our website into the addon
Commands.import = function() App.Importer:draw(); end
Commands.im = Commands.import;

-- Export data from the addon to use on our website
Commands.export = function() App.Exporter:draw(); end
Commands.ex = Commands.export;

-- Reset the dkp and loot history tables
Commands.reset = function() StaticPopup_Show("RESET_TABLES_CONFIRMATION"); end
Commands.re = Commands.reset;

-- Broadcast our current dkp / loot tables to everyone
Commands.broadcast = function() StaticPopup_Show("BROADCAST_TABLES_CONFIRMATION"); end
Commands.br = Commands.broadcast;

-- Check if everyone is running the most up-to-date version
Commands.version = function() App.Version:inspectGroup(); end
Commands.ve = Commands.version;

-- Check if everyone is running the most up-to-date version
Commands.inspect = function(...) App.BagInspector:inspect(...); end
Commands.ins = Commands.inspect;

-- Check if everyone is running the most up-to-date version
Commands.buffs = function(...) App.BuffInspector:inspect(...); end
Commands.bu = Commands.buffs;

-- This method dispatches all slash commands to their final destination
function Commands:_dispatch (str)
    App.User:refresh();

    local path = Commands; -- required for updating found table.

    if (not str or #str < 1) then
        -- User entered "/gl" with no additional arguments
        Commands.dashboard();
        return;
    end

    App:debug("Dispatching " .. str);

    -- Search the str for a command / itemLink combination
    local command, itemLink = str:match("^(%w+)%s+(.+)$");

    -- We need to treat command requests with an item
    -- link as an argument a little differently, since
    -- item links may include spaces and shoult NOT be split
    if (command and itemLink) then
         return pcall(function () return path[command](itemLink); end);
    end

    if (str == "_dispatch") then
        App.warning("The 'dispatch' method is protected!");
        return;
    end

    local arguments = {};
    for _, argument in ipairs({ string.split(" ", str, 2) }) do
        if (#argument > 0) then
            table.insert(arguments, argument);
        end
    end

    for id, argument in ipairs(arguments) do
        if (#argument > 0) then -- if string length is greater than 0.
            argument = argument:lower();

            if (path[argument]) then
                if (type(path[argument]) == "function") then
                    -- all remaining arguments passed to our function!
                    path[argument](select(id + 1, unpack(arguments)));
                    return;
                elseif (type(path[argument]) == "table") then
                    path = path[argument]; -- another sub-table found!
                end
            else
                -- does not exist!
                return self:help();
            end
        end
    end
end;

-- Add slash command
SLASH_GIAL1 = "/gl";
SlashCmdList.GIAL = function (...)
    App.User:refresh();

    Commands:_dispatch(...);
end;

App:debug("Commands.lua");