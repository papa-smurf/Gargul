--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "deDE") then return; end
local L = Gargul_L or {};

L.GOLD_INDICATOR = "g";
L.SILVER_INDICATOR = "s";
L.COPPER_INDICATOR = "c";

--[[ START TRANSLATING HERE! ]]
L.GDKP_CUTS_ADJUST_G = "adjust [g]";
L.GDKP_CUTS_ADJUST_P = "adjust [%]";

L.ALL_SETTINGS = "All Settings";
L.ANTISNIPE = "Anti Snipe";
L.ANTISNIPE_EXPLANATION = {
    " ",
    "An Anti Snipe value of 10 means that any bid that comes in with",
    "less than 10 seconds left will reset the timer back to 10 seconds",
    " ",
    "You can leave this empty or set to 0 to disable Anti Snipe completely",
    "Anti Snipe values less than 5 are not supported",
    " ",
};
L.GDKP_ADD_DROPS_TO_QUEUE = "Add dropped loot to queue";
L.GDKP_ALL_CUTS_MAILED = "All cuts were mailed!";
L.AUCTIONEER = "Auctioneer";
L.AUCTION = "Auction";
L.AUCTIONS = "Auctions";
L.AUTO_AWARD = "Auto award";
L.AUTO_TRADE_OPTIONS = "Auto trade";
L.BID = "Bid";
L.BONUS_FEATURE_EXPLANATION = "Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!";
L.BOOSTED_ROLLS = "Boosted Rolls";
L.BROADCAST = "Broadcast";
L.BROADCAST_INC_AWARDED = "Include awarded items";
L.BROADCAST_INC_DISENCHANTED = "Include disenchanted items";
L.BROADCAST_INC_HIDDEN = "Include hidden items";
L.BROADCAST_INC_TIME_LEFT = "Include time left";
L.BROADCAST_NO_DATA = "There is nothing to broadcast";
L.BROADCAST_NUMBER_OF_ITEMS = "Number of items";
L.BROADCAST_PREFIX = "I have the following items left to trade";
L.BROADCAST_TARGET_PLAYER = "Target player (whisper only)";
L.BROADCAST_TARGET_REQUIRED = "Whisper requires a target player";
L.BROADCAST_TRADE_TIME_LEFT = "Max trade time left (in minutes)";
L.CANCEL = "Cancel";
L.CHANGE_SCALE = "Adjust Scale";
L.CHANNEL = "Channel";
L.CHANNEL_OFFICER = "Officer";
L.CHANNEL_WHISPER = "Whisper";
L.CHANNEL_RAID_WARNING = "Raid Warning";
L.CLOSE = "Close";
L.CLOSE_ON_AWARD = "Close on award";
L.CLOSE_ON_START = "Close on start";
L.COMMUNICATION = "Communication";
L.CUT_MAIL_IN_PROGRESS = "Wait a bit, we're still processing the previous mail";
L.CUT_MAIL_IN_PROGRESdeS = "Wait a bit, we're still processing the previous mail";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "You don't have enough gold to pay %s";
L.CUT_MAILBOX_CLOSED = "Can't send mail when the mailbox is closed";
L.CUT_MAIL_FAILED = "Failed to send cut to %s";
L.CUT_MAILS_FAILED = "Multiple mail errors detected, aborting cut distribution";
L.CUT_MAIL_HISTORY = "Mail History for |c00967FD2%s|r";
L.CUT_SENT = "Sent %sg to %s ";
L.CUT_MAIL_BODY = "Powered by Gargul: a Master Loot Tool with support for TMB, SoftRes, GDKP and Auto-Looting!";
L.CUT_MAIL_GOLD_MISMATCH = "Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?";
L.CUT_MAIL_EVEN = "You don't owe %s any gold";
L.CUT_MAIL_SUBJECT = "Gargul GDKP: %sg";
L.DELETE = "Delete";
L.EDIT = "Edit";
L.SELECT_ALL = "Select / Disable all";
L.IMPORT = "Import";
L.EXPORT = "Export";
L.FINAL_CALL = "Final Call";
L.GDKP_QUEUE_EXPLANATION = [[|c00a79eff%s|r items in bags, loot windows or even on links in your chat to add them to this auction queue.
Items in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.

Want Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!

|c00FFF569Did you know?|r
You can move items around with drag and drop
Items will be remembered, even when you |c00a79eff/reload|r
Queued items are automatically shown to raiders who have Gargul so they can prebid
Gargul can also handle auto looting for you. Check it out with |c00a79eff/gl pm|r
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Hide unusable items";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "Are you sure? You won't be able to see, or bid on, upcoming items!";
L.GDKP_PAYOUT_INACTIVE = "No active GDKP session detected or session is not locked for payout!";
L.GDKP_SESSION = "GDKP Session";
L.GDKP_SHOW_UPCOMING = "Show upcoming items";
L.GDKPS_ARE_NOT_ALLOWED = "GDKP raids are not allowed in this version of World of Warcraft"
L.GROUP = "Group";
L.GROUP_MANAGER = "Group Manager";
L.IMPORT_EXPLANATION = "What kind of data would you like to import?";
L.INFO = "Info";
L.INC = "Inc";
L.INCLUDE_BOES = "Include BOEs";
L.INCREMENT = "Increment";
L.INVALID_DATA_WARNING = "Invalid data supplied";
L.SOMETHING_WENT_WRONG_WARNING = "Something went wrong!";
L.HALT = "Halt";
L.HIDE = "Hide";
L.TITLE = "Title";
L.RESTORE = "Restore";
L.MIN = "Min";
L.MAXIMIZE = "Maximize";
L.MAIL = "Mail";
L.MAIL_CUTS_EXPLANATION = "Mail cut to players";
L.MINIMIZE = "Minimize";
L.MINIMIZE_ON_AWARD = "Minimize on award";
L.MINIMIZE_ON_START = "Minimize on start";
L.MINIMUM = "Minimum";
L.MINIMUM_QUALITY = "Minimum Quality";
L.MINUS10 = "-10";
L.MULTI_AUCTION = "Multi-Auction";
L.MOVE = "Move";
L.NEXT = "Next";
L.NAME = "Name";
L.NO_BIDS_ACTION = "When no one bids do:";
L.NO_OFFICER_PRIVILEGES = "You don't have officer privileges";
L.NOTHING = "Nothing";
L.OPEN = "Open";
L.OPEN_AUCTIONEER = "Open Auctioneer";
L.OPEN_MULTI_AUCTION = "Open Multi-Auction";
L.PLUS10 = "+10";
L.PLUSONES = "Plus Ones";
L.POT = "Pot";
L.QUALITY_POOR = "Poor";
L.QUALITY_COMMON = "Common";
L.QUALITY_UNCOMMON = "Uncommon";
L.QUALITY_RARE = "Rare";
L.QUALITY_EPIC = "Epic";
L.QUALITY_LEGENDARY = "Legendary";
L.QUALITY_HEIRLOOM = "Heirloom";
L.QUEUE = "Queue";
L.REMOVE_BID = "Remove bid";
L.RESET_SETTINGS = "Reset Settings"
L.RESET_SETTINGS_CONFIRMATION = "Are you sure you want to reset all of Gargul's settings? This can't be undone!";
L.RESET_UI = "Reset Gargul UI";
L.RESET_UI_CONFIRMATION = "Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!";
L.RESUME = "Resume";
L.SKIP = "Skip";
L.SOFTRES = "Soft-Reserves";
L.TIME = "Time";
L.TMBETC = "TMB, DFT or PRIO3";
L.TOGGLE_QUEUE = "Show/Hide Queue";
L.TOGGLE_DATES = "Show/Hide Dates";
L.TUTORIAL = "Tutorial";
L.TUTORIAL_BIDDER_QUEUE = [[The items you see here are in the master looter's GDKP queue
You can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)

You can resize the window, move it around, or minimize it. Try it out!

For loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!
]];
L.TUTORIAL_MORE_HELP = "Need more help?";
L.TUTORIAL_AUCTIONEER = [[|c00a79eff%s|r items in bags, loot windows or even on links in your chat to add them to the auction queue.
Want to directly sell an item without bidding? Use |c00a79eff%s|r

You can open the %s window directly by typing |c00a79eff/gl auction|r

Gargul tracks |c00FF0000ALL|r gold traded. Don't want a trade to be a part of this GDKP session? Check the "Exclude from GDKP" checkbox when trading!

|c00FFF569Did you know?|r
Awarded items will automatically be added to the trade window
Gargul can also handle auto looting for you. Check it out with |c00a79eff/gl pm|r
]];
L.UPDATE_GARGUL = "Update Gargul!";
L.WINDOW = "Window";
L.WINDOW_SCALE = "Window Scale";
L.YOU_DISABLED_GDKP_QUEUES = "You disabled GDKP queues";

L.SETTINGS_ANNOUNCE_START = "Announce auction start";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Announce pot after awarding item";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Whisper bidder if bid is too low";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Announce countdown in raid warning";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Announce incoming bids";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Announce incoming bids in raid warning";

--[[ GROUP VERSION CHECK (/gl version) ]]
L.VERSION_CHECK_COLUMN_STATUS = "Gargul status";

L.VERSION_CHECK_STATUS_CHECKING = "Checking version ...";
L.VERSION_CHECK_STATUS_IGNORED = "PLAYER IGNORED!";
L.VERSION_CHECK_STATUS_OFFLINE = "Offline";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "No response";
L.VERSION_CHECK_STATUS_EXPLANATION = ([[
|c0092FF00v%s|r: the player is up-to-date
|c00F7922Ev%s|r: the player needs to update his add-ons
|c00BE3333%s|r: the player doesn't have Gargul or is on an unsupported version
|c00808080%s|r: the player is offline or is ignoring us!
|c0000FFFF%s|r: the player is on our ignore list!

]]):format(GL.version, GL.version, L.VERSION_CHECK_STATUS_UNRESPONSIVE, L.VERSION_CHECK_STATUS_OFFLINE, L.VERSION_CHECK_STATUS_IGNORED);

L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "Up-to-date:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "Outdated:";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "No response:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Offline:";

L.VERSION_CHECK_BUTTON_REPORT = "Report";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Report outdated results in group chat";

L.VERSION_CHECK_CHAT_MISSING = "Gargul missing for:";
L.VERSION_CHECK_CHAT_OUTDATED = "Gargul outdated for:";
L.VERSION_CHECK_CHAT_OFFLINE = "The following players were offline:";

--[[ GLOBAL ]]
L.DFT = "DFT";
L.BIND_ON_EQUIP_ABBR = "BOE";
L.CLASSICPRIO_ABBR = "CPR";
L.THATSMYBIS_ABBR = "TMB";
L.WISHLIST_ABBR = "WL";
L.PRIOLIST_ABBR = "PL";
L.MAINSPEC_ABBR = "MS";
L.OFFSPEC_ABBR = "OS";
L.VERSION_ABBR = "v";
L.SOFTRES_ABBR = "SR";
L.BOOSTED_ROLLS_ABBR = "BR";

L.PLUS_SIGN = "+";
L.WINDOW_HEADER = "Gargul " .. L.VERSION_ABBR .. "%s" -- %s is Gargul's version number
L.YES = "Yes";
L.NO = "No";
L.START = "Start";
L.STOP = "Stop";
L.CLEAR = "Clear";
L.AWARD = "Award";
L.NONE = "None";
L.DISENCHANT = "Disenchant";
L.SETTINGS = "Settings";
L.PLUS1 = "+1";
L.AWARD_HISTORY = "Award history";
L.PLAYER = "Player";
L.ROLL = "Roll";
L.NOTE = "Note";
L.ITEM = "Item";
L.HEADER = "Header";
L.FORMAT = "Format";
L.TAB_REPLACES_T = "\\t is replaced by a tab";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.TYPE = "Type"; -- As in type of roll or type of item*
L.ARE_YOU_SURE = "Are you sure?";
L.IMPORT_SUCCESSFUL = "Import of boosted roll data successful";
L.BROADCAST_IN_PROGRESS_ERROR = "Broadcast still in progress";
L.BROADCASTING_NOTIFICATION = "Broadcasting...";
L.BROADCAST_FINISHED = "Broadcast finished!";
L.AWARDED_TO = "Awarded To";
L.PRICE = "Price";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = L.BOOSTED_ROLLS_ABBR .. ": %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Price: %s";
L.AWARDED_TOOLTIP_GIVEN = "Given: yes";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Given: no";
L.AWARDED_TOOLTIP_SECOND_BID = "2nd bid: %s by %s";
L.AWARDED_YOU_WON = "You won";
L.LM_OR_ASSIST_REQUIRED = "You need to be the master looter or have an assist / lead role!";
L.COMM_PROGRESS = "Sent %s of %s bytes";
L.BROADCAST_DELAYED_BY_COMBAT = "You are currently in combat, delaying broadcast";
L.UNKNOWN_COMM_ACTION = "Unknown comm action '%s', make sure to update Gargul!";
L.IMPORTED_AND_UPDATED_ON = "Imported on |c00a79eff%s|r at |c00a79eff%s|r, Updated on |c00a79eff%s|r at |c00a79eff%s|r";

L.BASE64_DECODE_WARNING = "Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!";
L.ZLIB_DECOMPRESS_WARNING = "Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!";
L.JSON_DECODE_WARNING = "Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!";

L.TUTORIAL_AWARD_OVERVIEW = ([[
This window shows all the items that have been awarded on any given date (select one or more dates on the left).

Items can contain the following tags:

|c00A79EFF%s|r: Awarded for offspec
|c00A79EFF%s|r: This item was soft-reserved
|c00A79EFF%s|r: This item was wishlisted (Thatsmybis)
|c00A79EFF%s|r: This item was priolisted (Thatsmybis, DFT, prio3)
]]):format(L.OFFSPEC_ABBR, L.SOFTRES_ABBR, L.WISHLIST_ABBR, L.PRIOLIST_ABBR);

--[[ AWARDED LOOT EXPORTER /gl ah ]]
L.EXPORT_READ_ONLY_NOTICE = "This is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n";
L.EXPORT_DELETE_ALL_CONFIRM = "Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!";
L.EXPORT_DELETE_DATE_CONFIRM = "Are you sure you want to remove all data for %s? This cannot be undone!";

--[[ BAGINSPECTOR /gl inspect itemID1, itemID2 ]]
L.BAGINSPECTOR_START = "Starting inspection...";
L.BAGINSPECTOR_FINISHED = "Inspection finished";
L.BAGINSPECTOR_FAILED = "Bag inspection failed: no reports received";

--[[ BOOSTED ROLLS /gl br ]]
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!bonus|!rb|!br";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "Are you sure you want to clear all boosted roll data?";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Invalid data provided. Make sure that the contents follows the required format and no header row is included";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "Nothing to broadcast, import Boosted Rolls data first!";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "Couldn't process BoostedRolls data received from %s";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Attempting to process incoming BoostedRolls data from %s";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = "Are you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00a79eff%s|r, theirs on |c00a79eff%s|r.";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = "Here you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Apply aliases";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Add missing raiders";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Add points to raid";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = "Add how many points for everyone currently in the raid?\n\n|c00BE3333Use the \"Add missing raiders\" button first if you want everyone to get points, even those without a boosted roll entry!|r";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "Delete %s?";
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "No point value provided!";
L.BOOSTED_ROLLS_POINTS = "Points";
L.BOOSTED_ROLLS_RESERVE = "Reserve";
L.BOOSTED_ROLLS_ALIASES = "Aliases";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Boosted Roll Cost:";

--[[ PLUS ONES /gl +1 ]]
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUSONES_CLEAR_CONFIRM = "Are you sure you want to clear all plus one data?";
L.PLUSONES_BROADCAST_CONFIRM = "Are you sure you want to broadcast your plus one data to everyone in your party/raid?";
L.PLUSONES_IMPORT_ERROR = "Invalid data provided. Make sure that the contents follows the required format and no header row is included";
L.PLUSONES_BROADCAST_PROCESS_START = "Attempting to process incoming PlusOnes data from %s";
L.PLUSONES_CLEAR_CONFIRM = "%s wants to clear all your PlusOne data. Clear all data?";
L.PLUSONES_UPDATE_CONFIRM = "Are you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00a79eff%s|r, theirs on |c00a79eff%s|r.";
L.PLUSONES_IMPORT_CONFIRM = "Are you sure you want to import new data broadcasted by %s?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?";
L.PLUSONES_AWARD_DIALOG_LABEL = "Add a +1";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Block all incoming +1 shared data";
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Automatically accept incoming broadcasts from %s";

--[[ LOOTPRIORITY /gl lo ]]
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc";
L.LOOTPRIORITY_INVALID_DATA = "Invalid data provided";
L.LOOTPRIORITY_INVALID_LINE = "Invalid data provided in line: '%s': missing item id or priority";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Loot priorities imported successfully";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Loot priorities cleared successfully";
L.LOOTPRIORITY_PROCESS_INCOMING = "Attempting to process incoming loot priorities from %s";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Loot Prio";

--[[ SOFTRES /gl sr ]]
L.SOFTRES_CLEAR_CONFIRM = "Are you sure you want to clear all existing soft-reserve data?";
L.SOFTRES_BROADCAST_CONFIRM = "Are you sure you want to broadcast your softres data to everyone in your party/raid?";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_IMPORT_INVALID = "Invalid soft-reserve data provided";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here";
L.SOFTRES_IMPORT_SUCCESSFUL = "Soft-reserves imported successfully";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "Import successful!";
L.SOFTRES_IMPORT_FIXED_NAME = "Auto name fix: the SR of \"%s\" is now linked to \"%s\"";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "The following players did not reserve anything:";
L.SOFTRES_IMPORT_NEW_PLUSONES = "The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?";
L.SOFTRES_IMPORT_USE_GARGUL = "SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "This item is hard-reserved";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "For: %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Note:|r %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Reserved by";
L.SOFTRES_TOOLTIP_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "Failed to connect to LootReserve, contact support (include message below)";
L.SOFTRES_PROCESS_INCOMING = "Attempting to process incoming SoftRes data from %s";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "Couldn't process SoftRes data received from %s";
L.SOFTRES_EVERYONE_RESERVED = "Everyone filled out their soft-reserves";
L.SOFTRES_NO_URL_AVAILABLE = "No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!";

--[[ AWARD ]]
L.AWARD_TOOLTIP_ADD_ITEM = "Drag and drop or shift+click an item in the box on the right";
L.AWARD_RANDOM_CONFIRM = "Do you want to award %s to a random player?";
L.AWARD_CONFIRM = "Award %s to %s?";
L.AWARD_PLAYER_CUSTOM_NAME = "Type player name here";
L.AWARD_PLAYER_SELECT_NAME = "or select one below";
L.AWARD_HEADER_IN_GROUP = "In Group";
L.AWARD_UNDO_CONFIRM = "Are you sure you want to undo %s awarded to %s?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.AWARD_UNDO_BR_REFUND = " %s boosted roll points will be refunded!";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Disenchanted items:";
L.AWARD_TOOLTIP_GIVEN = " (Given: yes)";
L.AWARD_TOOLTIP_NOT_GIVEN = " (Given: no)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = " (" .. L.OFFSPEC_ABBR .. ")";
L.AWARD_TOOLTIP_BR_INDICATION = " (BR: %s)";
L.AWARD_NEW_WINNER_CONFIRMATION = "Who should %s go to instead?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "Are you sure you want to disenchant %s? %s boosted roll points will be refunded!";

--[[ THATSMYBIS /gl tmb ]]
L.TMB_CLEAR_CONFIRM = "Are you sure you want to clear all plus one data?";
L.TMB_BROADCAST_CONFIRM = "Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!";
L.TMB_IMPORT_INVALID_CSV = "Invalid CSV provided, the format is: 6948,player1,player2";
L.TMB_IMPORT_INVALID_DFT = "Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!";
L.TMB_IMPORT_PLAYER_NO_DATA = "The following players have no %s entries:"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_PRIO_HEADER = "%s Prio List"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_WISHLIST_HEADER = "TMB Wish List";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = " (" .. L.OFFSPEC_ABBR .. ")";
L.TMB_TOOLTIP_TIER = "|cFFFFFFFF    Tier:|r %s";
L.TMB_TOOLTIP_NOTE = "|cFFFFFFFF    Note:|r |cFFFFF569%s|r";
L.TMB_NO_BROADCAST_TARGETS = "There's no one in your group to broadcast to";
L.TMB_BROADCAST_PROCESS_START = "Attempting to process incoming TMB data from %s";
L.TMB_SYNCED = "TMB data synced";

--[[ VERSION /gl version ]]
L.VERSION_UPDATED = "|cff%sGargul|r is now updated to |cff%sv%s|r";
L.VERSION_INVALID_WARNING = "Invalid version string provided in Version:addRelease";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul is out of date and won't work until you update!";
L.VERSION_UPDATE_AVAILABLE = "v|c00a79effv%s|r is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !";
L.VERSION_UPDATE = "Update Gargul!";

--[[ PACKMULE /gl pm ]]
L.PACKMULE_NO_DISENCHANTER_WARNING = "No disenchanter set, use /gl sd [mydisenchanter] to set one";
L.PACKMULE_WHO_IS_DISENCHANTER = "Who is your disenchanter?";
L.PACKMULE_CONFIRM_DISENCHANTER = "Set %s as your disenchanter?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "Send %s to %s? Type /gl cd to remove this disenchanter!";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASS";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "GREED";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "NEED";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORE";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "RANDOM";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SELF";

--[[ GDKP /gl gdkp ]]
L.GDKP = "GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD = "Exclude from GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "Gold traded will not be added to amount given or received";
L.GDKP_TRADE_GOLD_TO_GIVE = "To give: %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "To receive: %s";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "You don't have enough money to pay %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "Unable to add %s to the trade window. Try adding it manually!";
L.GDKP_TRADE_BALANCE_INFO = "|c00967FD2GDKP Session|r\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = " \n|c00967FD2GDKP Data (sold %sx)|r\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n";
L.GDKP_ACTIVATED = "GDKP Active!";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "Missing header, note: it's case-sensitive!";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "Missing header, note: it's case-sensitive!";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Missing gold for player %s";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Missing player name";
L.GDKP_CUT_IMPORT_EMPTY = "Nothing to import, double check your CSV";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "Unknown item ID: %s";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "Either minimum or increment is required for item ID: %s";
L.GDKP_PRICE_IMPORT_INVALID_INC = "Invalid 'Increment' provided for item ID '%s'";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "Invalid 'Minimum' provided for item ID '%s'";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "Increment or minimum can't be lower than .0001!";
L.GDKP_AWARD_ITEM_CONFIRMATION = "Award %s to %s for %s?";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Successfully imported data for %s items";
L.GDKP_STOP_AUCTION_FIRST = "Stop the auction first!";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "There's not enough gold to distribute, expect some weird cut calculations!";
L.GDKP_NO_BIDS = "No bids!";
L.GDKP_DELETE_BID_INFO = "Delete bid. Auction must be stopped first!";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "No bids on Legendary+ item detected, continue manually!";
L.GDKP_UNKNOWN_SESSION = "Unknown sessionIdentifier in Auction:create: %s";
L.GDKP_LOCKED_SESSION = "The GDKP Session is not available or locked";
L.GDKP_MULTIAUCTION_OUTBID = "You were outbid!";
L.GDKP_INVALID_DATA_FOR_START = "Invalid data provided for GDKP auction start!";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "Invalid data provided for GDKP extension!";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "Invalid data provided for GDKP shortening!";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "Invalid data provided for GDKP reschedule!";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "Invalid time provided in Auction:reschedule";
L.GDKP_MISSING_CONTENT_FOR_START = "Missing content in Auction:start";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "User '%s' is not allowed to start auctions";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "User '%s' is not allowed to stop auctions";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "User '%s' is not allowed to stop auction: auction invalid";
L.GDKP_OUTBID = "You were outbid!";
L.GDKP_INVALID_PAID_AMOUNT = "Invalid number provided for 'paid'";
L.GDKP_AWARD_DIALOG_LABEL = "GDKP Price:";
L.GDKP_YOU_OWE = "You owe %s %s";
L.GDKP_THEY_OWE = "%s owes you %s";

L.GDKP_DISTRIBUTE_ADDRAIDER = "Add a raider to this session";
L.GDKP_MUTATOR_CREATE_NEW = "Create a new GDKP mutator";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Store for future sessions";
L.GDKP_MUTATOR_NAME_LABEL = "Name [example: Tanks]";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Percentage [example: 10]";
L.GDKP_MUTATOR_FLAT_LABEL = "Flat gold rate [example: 250]";
L.GDKP_MUTATOR_APPLY_LABEL = "     Auto apply to";
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "You can automatically apply this mutator to raiders using keywords:";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = "Example:\n|c00967FD2SELF,RL,HEALER|r";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Mutator names can not contains dots (.)";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "The percentage needs to be a number";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "The flat rate needs to be a number";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "The flat rate needs to be a number";
L.GDKP_MUTATOR_UNKNOWN = "Unknown mutator: %s";
L.GDKP_MAIL_ALL = "Mail All";

L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Custom (create your own format)";
L.GDKP_EXPORT_CUTS_FORMAT_TOOLTIP = "Available values:";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "total gold received from the player";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "total gold given to the player";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "gold traded to the player";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "gold mailed to the player";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "date/time at which the first item was awarded";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "date/time at which the session was locked";

L.GDKP_IMPORT_CUTS_INFO = "You can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!|r):\n\n|c00BE3333Player,Gold|r|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n|r";
L.GDKP_IMPORT_CONSEQUENCES_INFO = "This will override any changes you've made to the cut window, are you sure?";

L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "You can't give AND receive gold from the same player at the same time";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Gold |c00967FD2given to|r %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Gold |c00967FD2received from|r %s";

--[[ MULTIAUCTION  /gl ma ]]
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "Invalid data provided for GDKP auction start!";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "The loot master (%s) is outdated, this can cause bids to fail!";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s bought %s for %sg";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "With this window open, %s items to add them to the list or click 'Fill from inventory' below"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "You need to have an active (unlocked) GDKP session!";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Your Gargul is outdated, we recommend updating before starting a session to prevent issues!";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Active GDKP Session: |c00967FD2%s|r | By %s%s | On |c00967FD2%s|r";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Search name or iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Supports item names and iLVL e.g. '252', '<252' etc";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Auction time in seconds";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Anti snipe in seconds";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Remove all items from the list";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Add tradeable items from your inventory to the list";
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Next step: check raider's add-on version for compatibility";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Select at least one item for your auction";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "The auction time in seconds needs to be >= 10";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "The anti snipe value needs to be 0 (empty) or >=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Go back to the item selector";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "Not everyone is using Gargul, are you sure you want to start the auction?";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Here you determine which items to include in your multi-auction session

Use the |c00a79effFill from inventory|r button below to add items that can still be traded to the list
Whenever you clear and re-open this window, your last fill settings will be used to automatically add items

|c00a79eff%s|r items to manually add them to the list
]];

L.GDKP_UNKNOWN_ITEM = "Unknown itemID in Auction:create: %s";

L.LOOTMASTER_FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!";
L.LOOTMASTER_NOTICE_LABEL = "You were given the role of Master Looter";
L.LOOTMASTER_OPEN_LABEL = "Open this window automatically";
L.LOOTMASTER_CLEAR_SR_BUTTON = "Clear SoftRes";
L.LOOTMASTER_IMPORT_SR_BUTTON = "Import SoftRes";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "Clear TMB";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "Import TMB";

--[[ RAID GROUPS /gl gr ]]
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = "In the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition|r link:";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "a |c00FFF569Raid-Helper export|r (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition|r CSV:";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Wowhead Comp Tool";
L.RAIDGROUPS_WOWHEAD_INFO = "You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window";
L.RAIDGROUPS_GARGUL_BUTTON = "Gargul Group Wiki";
L.RAIDGROUPS_GARGUL_INFO = "Visit the Gargul group wiki for more info on the raid group format";
L.RAIDGROUPS_INVITE_BUTTON = "Invite";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Send invites to players on roster";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Who's Missing";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Show missing player names";
L.RAIDGROUPS_SORT_BUTTON = "Apply Groups";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Sort groups based on roster";
L.RAIDGROUPS_TANK_BUTTON = "Assign Tanks";
L.RAIDGROUPS_PURGE_BUTTON = "Kick unwanted players";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Kick players that aren't on the roster";
L.RAIDGROUPS_DISBAND_BUTTON = "Disband raid";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Disband your raid";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Invalid group data provided, check your format!";
L.RAIDGROUPS_NO_RAID_WARNING = "You need to be in a raid!";
L.RAIDGROUPS_SORT_IN_PROGRESS = "Sorting is still in progress, wait a bit!";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s is listed twice on the roster!";
L.RAIDGROUPS_IN_COMBAT_WARNING = "Can't sort groups while %s is in combat!"; -- %s holds a player name
L.RAIDGROUPS_IMPOSTER_WARNING = "The following players are not part of the roster: %s";
L.RAIDGROUPS_NO_TANKS_WARNING = "No tanks defined";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "Can't find a place for %s, are you trying to put more than 5 people in 1 group?";
L.RAIDGROUPS_TANKS_ASSIGNED = "All tanks are assigned";
L.RAIDGROUPS_SORTING_GROUPS = "Sorting groups";
L.RAIDGROUPS_SORTING_ERROR = "Something went wrong while moving %s";
L.RAIDGROUPS_SORTING_FINISHED = "Finished applying raid roster";

--[[ ROLLING /gl ro ]]
L.ROLLING_NOTE_LABEL = "NOTE";
L.ROLLING_TIMER_LABEL = "TIMER (s)";
L.ROLLING_CLOSE_ON_START_LABEL = "Close on start";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Close on award";
L.ROLLING_SELECT_PLAYER_WARNING = "You need to select a player first";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Hold shift to show the award confirmation";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Hold shift to bypass the award confirmation";
L.ROLLING_REOPEN_TOOLTIP = "Open master looter window";
L.ROLLING_REOPEN_ROLL_COUNT = "rolls: %s";
L.PLAYER_ITEM_WON_COUNT = "Items won by %s:";
L.ROLLING_ITEM_WON_GIVEN = " (item given: yes)";
L.ROLLING_ITEM_WON_NOT_GIVEN = " (item given: no)";
L.ROLLING_ITEM_WON_OS = "(" .. L.OFFSPEC_ABBR .. ")";
L.ROLLING_ITEM_WON_BR_COST = "(" .. L.BOOSTED_ROLLS_ABBR .. ": %s)";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "A roll is currently in progress";
L.ROLLING_IDENTICAL_ROLL_WARNING = "Warning: another identical roll was found which can point to a tie|r\n\n";
L.ROLLING_INVALID_START_DATA_WARNING = "Invalid data provided for roll of start!";
L.ROLLING_NO_ROLLOFF_WARNING = "Can't stop roll off, no roll off in progress";
L.ROLLING_ROLL_ACCEPTED = "Roll accepted!";
L.ROLLING_PASS_BUTTON = "Pass";
L.ROLLING_UNUSABLE_ITEM = "You can't use this item!";
L.ROLLING_AWARD_CONFIRM = "Award %s to %s?";
L.ROLLING_WINNER_NOT_UNIQUE = "The winner's name is not unique, select the player you'd like to award %s to";
L.ROLLING_ROLL_SR_COUNT = L.SOFTRES_ABBR .. " [%sx]";
L.ROLLING_ROLL_PRIOLIST = "Prio [%s]";
L.ROLLING_ROLL_WISHLIST = "Wish [%s]";

--[[ TradeWindow / Trade ]]
L.TRADE_ANNOUNCE = "Announce Trade";
L.TRADE_ANNOUNCE_INFO = "Announce trade details to group or in /say when not in a group";

L.SETTINGS_RESET_UI = "Reset Gargul UI";

--[[ CHAT MESSAGES ]]
L.CHAT = {
    ITEM_AWARDED = "%s was awarded to %s. Congrats!",
    ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
    ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

    GOLD_TRADE_GIVEN = "I gave %s to %s",
    GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
    GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
    GOLD_TRADE_RECEIVED = "I received %s from %s",
    GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
    GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

    --[[ BOOSTED ROLLS ]]
    BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
    BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
    BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

    --[[ PLUS ONES ]]
    PLUSONES_PLUS_SIGN = "+";
    PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
    PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

    --[[ GDKP ]]
    GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
    GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
    GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
    GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
    GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s";
    GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
    GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
    GDKP_REMOVED_GOLD = "I removed %sg from the pot",
    GDKP_RESTORED_GOLD = "I added %sg back to the pot",
    GDKP_POT_HOLDS = "The pot now holds %s",
    GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
    GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
    GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
    GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!";
    GDKP_STOP_BIDDING = "Stop your bids!",
    GDKP_SECONDS_TO_BID = "%s seconds to bid",
    GDKP_POT_TOTAL = "Total Pot: %s",
    GDKP_BASE_CUT = "Base cut: %s",

    --[[ MULTIAUCTION ]]
    MULTIAUCTION_STARTED = "I started a bidding session. Can't see it? Make sure to download/update Gargul!",
    MULTIAUCTION_RESUMED = "I resumed a previous bidding session, double check your bids!",
    MULTIAUCTION_ITEMS_ADDED = "I added %s item(s) to the auction for a total of %s",
    MULTIAUCTION_FINISHED = "Multi-auction finished. The pot now holds %s",

    --[[ SOFTRES ]]
    SOFTRES_MY_RESERVES_REPLY = "You reserved %s", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
    SOFTRES_MY_RESERVED_ITEM_REPLY = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
    SOFTRES_NO_RESERVES_REPLY = "It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master",
    SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)";
    SOFTRES_DETAILS = "Reserved by: %s",
    SOFTRES_MISSING_RESERVES = "Missing soft-reserves from: %s",
    SOFTRES_DATA_IMPORTED = "I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!",

    --[[ THATSMYBIS ]]
    TMB_WISHLIST_DETAILS = "TMB Wishlist: %s",
    TMB_PRIORITY_DETAILS = "%s Priority: %s", -- First %s can be TMB/DFT/CPR

    --[[ PACKMULE ]]
    PACKMULE_DISENCHANTER_SET = "%s was set as disenchanter",
    PACKMULE_DISENCHANTMENT_NOTICE = "%s will be disenchanted by %s",

    --[[ ROLLING ]]
    ROLLING_START = "You have %s seconds to roll on %s",
    ROLLING_STOP = "Stop your rolls!",
    ROLLING_TIME_LEFT = "%s seconds to roll",
    ROLLING_SOFTRES_INFO = "This item was reserved by: %s",
    ROLLING_TMB_INFO = "The following players have the highest %s prio: %s", -- First %s can be TMB/DFT/CPR

    --[[ TradeWindow / Trade ]]
    TRADE_TO = "%s to %s",
    TRADE_TO_PART = "to %s",
    TRADE_GAVE = "I gave %s",
    TRADE_GAVE_GOLD = "I gave %s to %s",
    TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s"; -- I gave [item]x3
    TRADE_GAVE_ENCHANTMENT = "I enchanted %s with %s for %s",
    TRADE_GAVE_ENCHANTMENT_AND_GOLD = "I enchanted %s with %s for %s and gave %s",
    TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "I enchanted %s with %s for %s and received %s",
    TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "to %s and enchanted their %s with %s",
    TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "%s to %s and enchanted their %s with %s",
    TRADE_GOT_ENCHANTMENT = "%s enchanted my %s with %s",
    TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s enchanted my %s with %s and gave me %s",
    TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s enchanted my %s with %s for %s",
    TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s enchanted my %s with %s and I enchanted their %s with %s",
    TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s",
    TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s",
    TRADE_FROM = "%s from %s",
    TRADE_FROM_PART = "from %s",
    TRADE_RECEIVED = "I received %s",
    TRADE_RECEIVED_GOLD = "I received %s from %s",
    TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s"; -- I gave [item]x3
    TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
    TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

    --[[ AWARD ]]
    AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player
}
