local _, App = ...;

App.Commands = App.Commands or {};
local Commands = App.Commands;

-- Display the command help
function Commands:help ()
    App:message("---------------------");
    App:message("List commands:")
    App:message("/gl - Shows the dashboard");
    App:message("/gl bid - Reopens the bid window if you closed it");

    if (App.User.isOfficer) then
        App:message("/gl broadcast - Broadcasts the DKP tables and loot history to the entire guild");
        App:message("/gl auction - Opens the auctioneer window for master looting purposes");
        App:message("/gl import - Opens the DKP / loot history import window");
        App:message("/gl export - Opens the DKP / loot history export window");
        App:message("/gl version - Checks the addon version of everyone in the raid");
        App:message("/gl stacktrace - Displays a list of this session's debug lines");
    end

    App:message("---------------------");
end

-- Open the dashboard or main hub if you will
Commands.dashboard = function() App.Dashboard:draw(); end

-- Open the auctioneer window (requires group and officer privileges)
Commands.auction = function()
    if (not App.User.isOfficer) then
        return App:warning("This feature requires officer privileges");
    end

    App.AuctioneerUI:draw();
end

Commands.bid = function() App.BidderUI:reopen(); end

-- Output all debug lines in a readable manner
Commands.stacktrace = function() App:stacktrace(); end

-- Import data from our website into the addon
Commands.import = function() App.Importer:draw(); end

-- Export data from the addon to use on our website
Commands.export = function() App.Exporter:draw(); end

-- Broadcast our current dkp / loot tables to everyone
Commands.broadcast = function()
    if (not App.User.isOfficer) then
        return App:warning("This feature requires officer privileges");
    end

    App.Sync:broadcast();
end

-- Check if everyone is running the most up-to-date version
Commands.version = function() App.Version:inspectGroup(); end

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
        path[command](itemLink);
        return;
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