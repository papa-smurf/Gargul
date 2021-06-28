local _, App = ...;

App.Commands = App.Commands or {};

local Utils = App.Utils;
local Commands = App.Commands;

-- Display the command help
function Commands:help ()
    Utils:message("---------------------");
    Utils:message("Commands:")
    Utils:message("/gl - Shows the dashboard");
    Utils:message("/gl version or /gl ve - Checks the addon version of everyone in the raid");
    Utils:message("/gl inspect or /gl ins - Check the groups bags for passed item ids");
    Utils:message("/gl stacktrace or /gl st - Displays a list of this session's debug lines");
    Utils:message("/gl rolloff or /gl roll or /gl ro - Displays the master looter window for rolling off items");
    Utils:message("/gl softreserves or /gl so - Opens the soft reserves window (master looter only)");
    Utils:message("/gl auction  or /gl au - Opens the auctioneer window for master looting purposes (officer only)");
    Utils:message("/gl bid or /gl bi - Reopens the bid window if you closed it");
    Utils:message("/gl import or /gl im - Opens the DKP / loot history import window (officer only)");
    Utils:message("/gl export or /gl ex - Opens the DKP / loot history export window (officer only)");
    Utils:message("/gl broadcast or /gl br - Broadcasts the DKP tables and loot history to the entire guild (officer only)");
    Utils:message("---------------------");
end

-- Open the dashboard or main hub if you will
Commands.dashboard = function() App.Dashboard:draw(); end

-- Open the settings menu
Commands.settings = function(...)
    InterfaceOptionsFrame_OpenToCategory(App.name);
    InterfaceOptionsFrame_OpenToCategory(App.name);
end
Commands.config = Commands.settings;
Commands.se = Commands.settings;
Commands.co = Commands.settings;

-- Open the auctioneer window (requires group and officer privileges)
Commands.auction = function(...) App.AuctioneerUI:draw(...); end
Commands.au = Commands.auction;

-- Open the window for rolling off items
Commands.rolloff = function(...) App.MasterLooterUI:draw(...); end
Commands.roll = Commands.rolloff;
Commands.ro = Commands.roll;

Commands.award = function(...) App.AwardedLoot:addWinner(...); end
Commands.a = Commands.award;

-- Export the current raid roster to csv
Commands.raidcsv = function ()
    App.RaidGroups:toCSV();
end
Commands.rcsv = Commands.raidcsv;

-- Open the raid gorups window
Commands.groups = function() App.RaidGroups:drawImporter(); end
Commands.roster = Commands.groups;
Commands.gr = Commands.groups;

-- Open the soft reserves window
Commands.softreserves = function() App.SoftReserves:drawImporter(); end
Commands.so = Commands.softreserves;
Commands.sr = Commands.softreserves;

-- Open the pack mule window
Commands.packmule = function() App.PackMuleUI:drawSetupWindow(); end
Commands.pm = Commands.packmule;

-- Open the loot priority window
Commands.lootpriority = function() App.LootPriority:drawImporter(); end
Commands.priority = Commands.lootpriority;
Commands.lo = Commands.lootpriority;
Commands.pr = Commands.lootpriority;

Commands.bid = function() App.BidderUI:reopen(); end
Commands.bi = Commands.bid;

-- Output all debug lines in a readable manner
Commands.stacktrace = function() Utils:stacktrace(); end
Commands.st = Commands.stacktrace;

-- Import data from our website into the addon
Commands.import = function() App.Importer:draw(); end
Commands.im = Commands.import;

-- Export data from the addon to use on our website
Commands.export = function() App.Exporter:draw(); end
Commands.ex = Commands.export;

-- Reset the dkp and loot history tables
Commands.reset = function() StaticPopup_Show(App.name .. "_RESET_TABLES_CONFIRMATION"); end
Commands.re = Commands.reset;

-- Broadcast our current dkp / loot tables to everyone
Commands.broadcast = function() StaticPopup_Show(App.name .. "_BROADCAST_TABLES_CONFIRMATION"); end
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

    local command = str:match("^(%S+)");
    local argumentString = "";

    if (command) then
        argumentString = strsub(str, strlen(command) + 2);
    end

    local arguments = { strsplit(" ", argumentString, 2) };

    if (not str or #str < 1) then
        -- User entered "/gl" with no additional arguments
        return Commands.dashboard();
    end

    Utils:debug("Dispatching " .. str);

    if (command == "_dispatch") then
        return Utils:warning("The 'dispatch' method is protected!");
    end

    if (command and self[command] and type(self[command]) == "function") then
        return self[command](unpack(arguments));
    end

    return self:help();
end;

-- Add slash command
SLASH_GIAL1 = "/gl";
SlashCmdList.GIAL = function (...)
    App.User:refresh();

    Commands:_dispatch(...);
end;

Utils:debug("Commands.lua");