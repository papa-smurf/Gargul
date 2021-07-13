local _, App = ...;

local Utils = App.Utils;

App.Commands = App.Commands or {
    ShorthandDictionary = {
        co = "settings",
        config = "settings",
        au = "auction",
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
        wl = "wishlists",
        wish = "wishlists",
        lo = "lootpriority",
        pr = "lootpriority",
        priority = "lootpriority",
        bi = "bid",
        st = "stacktrace",
        im = "import",
        ex = "export",
        re = "reset",
        br = "broadcast",
        ve = "version",
        ins = "inspect",
        bu = "buffs",
    },

    Dictionary = {
        -- Open the dashboard or main hub if you will
        dashboard = function() App.Dashboard:draw(); end,

        -- Open the settings menu
        settings = function(...)
            InterfaceOptionsFrame_OpenToCategory(App.name);
            InterfaceOptionsFrame_OpenToCategory(App.name);
        end,

        -- Open the auctioneer window (requires group and officer privileges)
        auction = function(...) App.AuctioneerUI:draw(...); end,

        -- Open the window for rolling off items
        rolloff = function(...) App.MasterLooterUI:draw(...); end,

        -- Award an item. This either award it directly or opens the UI
        award = function(...)
            local winner, itemLink = ...;

            if (not winner or winner == "" or not itemLink) then
                return App.AwardUI:draw();
            end

            App.AwardedLoot:addWinner(...);
        end,

        -- Award an item on a given date. Useful if you forgot to award an item and want to do it later
        awardOnDate = function(...) App.AwardedLoot:addWinnerOnDate(...); end,

        -- Export the current raid roster to csv
        raidcsv = function ()
            App.RaidGroups:toCSV();
        end,

        -- Open the raid groups window
        groups = function() App.RaidGroups:drawImporter(); end,

        -- Open the soft reserves window
        softreserves = function() App.SoftReserves:drawImporter(); end,

        -- Open the wish lists window
        wishlists = function() App.WishLists:drawImporter(); end,

        -- Open the pack mule window
        packmule = function() App.PackMuleUI:drawSetupWindow(); end,

        -- Open the loot priority window
        lootpriority = function() App.LootPriority:drawImporter(); end,

        bid = function() App.BidderUI:reopen(); end,

        -- Output all debug lines in a readable manner
        stacktrace = function() Utils:stacktrace(); end,

        -- Import data from our website into the addon
        import = function() App.Importer:draw(); end,

        -- Export data from the addon to use on our website
        export = function() App.Exporter:draw(); end,

        -- Reset the dkp and loot history tables
        reset = function() StaticPopup_Show(App.name .. "_RESET_TABLES_CONFIRMATION"); end,

        -- Broadcast our current dkp / loot tables to everyone
        broadcast = function() StaticPopup_Show(App.name .. "_BROADCAST_TABLES_CONFIRMATION"); end,

        -- Check if everyone is running the most up-to-date version
        version = function() App.Version:inspectGroup(); end,

        -- Check if everyone is running the most up-to-date version
        inspect = function(...) App.BagInspector:inspect(...); end,

        -- Check if everyone is running the most up-to-date version
        buffs = function(...) App.BuffInspector:inspect(...); end,
    }
};

local Commands = App.Commands;

-- Display the command help
function Commands:help ()
    Utils:message("---------------------");
    Utils:message("Commands:")
    Utils:message("/gl - Shows the dashboard");
    Utils:message("/gl version - Checks the addon version of everyone in the raid");
    Utils:message("/gl inspect - Check player bags for passed item ids");
    Utils:message("/gl stacktrace - Displays a list of debug lines, always include when reporting a bug!");
    Utils:message("/gl roll - Displays the master looter window for rolling off items");
    Utils:message("/gl softreserves - Opens the soft reserves window (master looter only)");
    Utils:message("/gl export - Opens the loot history export window");
    Utils:message("/gl wishlists - Opens the thatsmybis import window");
    Utils:message("/gl award - Opens the award UI");
--     Utils:message("DKP Features:");
--     Utils:message("/gl auction - Opens the auctioneer window for master looting purposes (officer only)");
--     Utils:message("/gl bid - Reopens the bid window if you closed it");
--     Utils:message("/gl import - Opens the DKP / loot history import window (officer only)");
--     Utils:message("/gl broadcast - Broadcasts the DKP tables and loot history to the entire guild (officer only)");
    Utils:message("---------------------");
end

-- This method dispatches all slash commands to their final destination
function Commands:_dispatch (str)
    App.User:refresh();

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
    command = Utils:tableGet(self.ShorthandDictionary, command, command);

    -- Some commands allow itemlinks, some don't. Items can contain spaces
    -- at which point we need to make sure the item itself isn't split up.
    -- We do that by specifying the number of (expected) arguments per command
    local arguments = {};
    local possibleArgumentChunks = nil;

    if (Utils:inArray({"rolloff", "auction"}, command)) then
        numberOfArguments = 1;
    elseif (Utils:inArray({"award"}, command)) then
        numberOfArguments = 2;
    elseif (Utils:inArray({"awardOnDate"}, command)) then
        numberOfArguments = 3;
    end

    arguments = { strsplit(" ", argumentString, numberOfArguments) };

    Utils:debug("Dispatching " .. str);

    if (command and self.Dictionary[command] and type(self.Dictionary[command]) == "function") then
        return self.Dictionary[command](unpack(arguments));
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