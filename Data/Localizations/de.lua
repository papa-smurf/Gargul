--[[
    You can test this local by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "deDE") then return; end
local L = Gargul_L or {};

L.ALL_SETTINGS = "Alle Einstellungen";
L.ANTISNIPE = "Anti Snipe";
L.ANTISNIPE_EXPLANATION = {
    " ",
    "An Anti Snipe value of 10 means that 10 seconds will be added",
    "to the auction if someone bids within the last 10 seconds",
    " ",
    "You can leave this empty or set to 0 to disable Anti Snipe completely",
    " ",
};
L.SIMPLE_ANTISNIPE = "Simple Anti Snipe";
L.SIMPLE_ANTISNIPE_EXPLANATION = {
    " ",
    "Simple Anti Snipe means with Anti Snipe set to 10,",
    "any bid at less than 10 seconds resets the time remaining to 10 seconds",
    " ",
};
L.ADD_DROPS_TO_QUEUE = "Add dropped loot to queue";
L.AUCTIONS = "Auktionen";
L.AUTO_AWARD = "Auto award";
L.AWARD = "Vergeben";
L.AWARD_ITEM_CONFIRMATION = "Award %s to %s for %s|c00FFF569g|r?";
L.BID_DENIED_WHISPER = "Bid denied, the minimum bid is %sg";
L.CLEAR = "Löschen";
L.CLOSE = "Schließen";
L.CLOSE_ON_AWARD = "Close on award";
L.CLOSE_ON_START = "Close on start";
L.DELETE = "Löschen";
L.DISENCHANT = "Entzaubern";
L.INC = "Stufe";
L.INCREMENT = "Stufe";
L.HALT = "Halt";
L.HIGHEST_BIDDER_CONFIRMATION = "%s ist der höchste Bieter (%sg)";
L.START = "Start";
L.STOP = "Stop";
L.MIN = "Min";
L.MAXIMIZE = "Maximieren";
L.MINIMIZE = "Minimieren";
L.MINIMUM = "Minimum";
L.MINUS10 = "-10";
L.MOVE = "Bewegen";
L.NEXT = "Nächste";
L.PLUS10 = "+10";
L.QUEUE = "Queue";
L.RESUME = "Warteschlange";
L.TIME = "Zeit";
L.TOGGLE_QUEUE = "Show/Hide Queue";
L.WINDOW = "Fenster";