Gargul_L = {};
local L = Gargul_L;

setmetatable(L, {
    __index = function (_, key)
        return tostring(key)
    end,
});

L.ABOUT = "About";
L.ALL_SETTINGS = "All Settings";
L.ANNOUNCE = "Announce";
L.ANTISNIPE = "Anti Snipe";
L.ANTISNIPE_EXPLANATION = [[

An Anti Snipe value of 10 means that any bid that comes in with
less than 10 seconds left will reset the timer back to 10 seconds

You can leave this empty or set to 0 to disable Anti Snipe completely.
Anti Snipe values less than 5 are not supported

]];
L.ARE_YOU_SURE = "Are you sure?";
L.ASSIGN_GARGUL_INFO = [[
Don't forget to use Gargul instead
if you wish to export loot later


-- Right-click to disable this window --]];
L.AUCTION = "Auction";
L.AUCTIONEER = "Auctioneer";
L.AUCTIONS = "Auctions";
L.AUTO = "Auto";
L.AUTO_AWARD = "Auto award";
L.AUTO_TRADE_OPTIONS = "Auto trade";
L.AVAILABLE_PLACEHOLDER_VALUES = "Available values:";
L.AWARD = "Award";
L.AWARDED_TO = "Awarded To";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "BR: %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Price: %s";
L.AWARDED_TOOLTIP_GIVEN = "Given: yes";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Given: no";
L.AWARDED_TOOLTIP_SECOND_BID = "2nd bid: %s by %s";
L.AWARDED_YOU_WON = "You won";
L.AWARD_CONFIRM = "Award %s to %s?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "Are you sure you want to disenchant %s? %s boosted roll points will be refunded!";
L.AWARD_HEADER_IN_GROUP = "In Group";
L.AWARD_HISTORY = "Award history";
L.AWARD_NEW_WINNER_CONFIRMATION = "Who should %s go to instead?";
L.AWARD_PLAYER_CUSTOM_NAME = "Type player name here";
L.AWARD_PLAYER_SELECT_NAME = "or select one below";
L.AWARD_RANDOM_CONFIRM = "Do you want to award %s to a random player?";
L.AWARD_TOOLTIP_ADD_ITEM = "Drag and drop or shift+click an item in the box on the right";
L.AWARD_TOOLTIP_BR_INDICATION = "(BR: %s)";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Disenchanted items:";
L.AWARD_TOOLTIP_GIVEN = "(Given: yes)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(Given: no)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(OS)";
L.AWARD_UNDO_BR_REFUND = "%s boosted roll points will be refunded!";
L.AWARD_UNDO_CONFIRM = "Are you sure you want to undo %s awarded to %s?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "Bag inspection failed: no reports received";
L.BAGINSPECTOR_FINISHED = "Inspection finished";
L.BAGINSPECTOR_START = "Starting inspection...";
L.BALANCE = "Balance";
L.BASE = "Base";
L.BASE64_DECODE_WARNING = "Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!";
L.BID = "Bid";
L.BIDS = "Bids";
L.BIND_ON_EQUIP_ABBR = "BOE";
L.BONUS_AUTO_INVITE = "1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!";
L.BONUS_PLUSONES = "3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po";
L.BOOSTED_ROLLS = "Boosted Rolls";
L.BOOSTED_ROLLS_ABBR = "BR";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
Add how many points for everyone currently in the raid?

|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "No point value provided!";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Add points to raid";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Add missing raiders";
L.BOOSTED_ROLLS_ALIASES = "Aliases";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Apply aliases";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Boosted Roll Cost:";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "Nothing to broadcast, import Boosted Rolls data first!";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "Couldn't process BoostedRolls data received from %s";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Attempting to process incoming BoostedRolls data from %s";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "Are you sure you want to clear all boosted roll data?";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "Delete %s?";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Invalid data provided. Make sure that the contents follows the required format and no header row is included";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
Here you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.

The table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.
Here is an example line:

Foobar,240,Barfoo]];
L.BOOSTED_ROLLS_POINTS = "Points";
L.BOOSTED_ROLLS_RESERVE = "Reserve";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
Are you sure you want to update your existing boosted rolls with data from %s?

Your latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s.]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!bonus|!rb|!br";
L.BROADCAST = "Broadcast";
L.BROADCASTING_NOTIFICATION = "Broadcasting...";
L.BROADCAST_DELAYED_BY_COMBAT = "You are currently in combat, delaying broadcast";
L.BROADCAST_FINISHED = "Broadcast finished!";
L.BROADCAST_INC_AWARDED = "Include awarded items";
L.BROADCAST_INC_DISENCHANTED = "Include disenchanted items";
L.BROADCAST_INC_HIDDEN = "Include hidden items";
L.BROADCAST_INC_TIME_LEFT = "Include time left";
L.BROADCAST_IN_PROGRESS_ERROR = "Broadcast still in progress";
L.BROADCAST_NO_DATA = "There is nothing to broadcast";
L.BROADCAST_NUMBER_OF_ITEMS = "Number of items";
L.BROADCAST_TARGET_PLAYER = "Target player (whisper only)";
L.BROADCAST_TARGET_REQUIRED = "Whisper requires a target player";
L.BROADCAST_TRADE_TIME_LEFT = "Max trade time left (in minutes)";
L.BY = "by"; -- As in 'bid BY'
L.CANCEL = "Cancel";
L.CHANGELOG_CONTRIBUTE = "Get support or share ideas on our Discord";
L.CHANGELOG_ENABLE_LABEL = "Enable changelog";
L.CHANGELOG_GETTING_STARTED = "Gargul makes handing out loot super easy, click the button below to get started!";
L.CHANGELOG_OPEN_GARGUL = "Open Gargul";
L.CHANGE_SCALE = "Adjust Scale";
L.CHANNEL = "Channel";
L.CHANNEL_OFFICER = "Officer";
L.CHANNEL_RAID_WARNING = "Raid Warning";
L.CHANNEL_WHISPER = "Whisper";
L.CLASSICPRIO_ABBR = "CPR";
L.CLEAR = "Clear"; -- As in clearing a window or data
L.CLOSE = "Close";
L.CLOSE_ON_AWARD = "Close on award";
L.CLOSE_ON_START = "Close on start";
L.COMMUNICATION = "Communication";
L.COMM_PROGRESS = "Sent %s of %s bytes";
L.COPPER_INDICATOR = "c";
L.CUT = "Cut";
L.CUTS = "Cuts";
L.CUT_MAILBOX_CLOSED = "Can't send mail when the mailbox is closed";
L.CUT_MAILS_FAILED = "Multiple mail errors detected, aborting cut distribution";
L.CUT_MAIL_BODY = "Powered by Gargul: a Master Loot Tool with support for TMB, SoftRes, GDKP and Auto-Looting!";
L.CUT_MAIL_EVEN = "You don't owe %s any gold";
L.CUT_MAIL_FAILED = "Failed to send cut to %s";
L.CUT_MAIL_GOLD_MISMATCH = "Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?";
L.CUT_MAIL_HISTORY = "Mail History for |c00967FD2%s";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "You don't have enough gold to pay %s";
L.CUT_MAIL_IN_PROGRESS = "Wait a bit, we're still processing the previous mail";
L.CUT_MAIL_SUBJECT = "Gargul GDKP: %sg";
L.CUT_SENT = "Sent %sg to %s";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "Delete";
L.DETAILS = "Details";
L.DFT = "DFT";
L.DISABLE = "Disable";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "Disenchant";
L.EDIT = "Edit";
L.ENABLE = "Enable";
L.EXPORT = "Export";
L.EXPORT_DELETE_ALL_CONFIRM = "Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!";
L.EXPORT_DELETE_DATE_CONFIRM = "Are you sure you want to remove all data for %s? This cannot be undone!";
L.EXPORT_READ_ONLY_NOTICE = [[
This is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!

]];
L.FILL = "Fill";
L.FINAL_CALL = "Final Call";
L.FINISH = "Finish";
L.FORMAT = "Format";
L.GARGUL = "Gargul";
L.GDKP = "GDKP";
L.GDKPS_ARE_NOT_ALLOWED = "GDKP raids are not allowed in this version of World of Warcraft";
L.GDKP_ACTIVATED = "GDKP Active!";
L.GDKP_ADD_DROPS_TO_QUEUE = "Add dropped loot to queue";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "Gold (- for removing gold)";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "Who pays for this?";
L.GDKP_ADD_GOLD_INVALID_WARNING = "Gold needs to be lower/higher than 0";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "Paid for by";
L.GDKP_ADD_GOLD_TITLE = "Adjust gold in %s";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "You can't give AND receive gold from the same player at the same time";
L.GDKP_ALL_CUTS_MAILED = "All cuts were mailed!";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "Disable for disenchanted";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "Disable in combat";
L.GDKP_AUCTIONS = "Auctions";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "Created by";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333Deleted by %s
Reason: %s]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg added to pot by %s
Note: %s]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s paid |c00%s%sg for
%s]];
L.GDKP_AUCTION_DETAILS_WON_BY = "Won by";
L.GDKP_AUCTION_PAID_AMOUNT = "Set paid amount (read left)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul automatically keeps track of gold traded. As long as players pay
for what they bought then you shouldn't ever need this field

'Paid amount' refers to the amount of gold the buyer already traded you.
This does not change the actual price of the item!

Warning: only set a value here if the player promises to pay
outside of the raid or trades the gold from an alt / mail etc!


]];
L.GDKP_AWARD_DIALOG_LABEL = "GDKP Price:";
L.GDKP_AWARD_ITEM_CONFIRMATION = "Award %s to %s for %s?";
L.GDKP_BIDDER_AUTO_BID = "Auto Bid";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "What's your maximum bid? (Minimum %s|c00FFF569g)";
L.GDKP_BIDDER_BID_DENIED = "Bid denied!";
L.GDKP_BIDDER_ITEM_PRICING = "Min bid: %sg   Increment: %sg";
L.GDKP_BIDDER_MY_MAX_BID = "(max %sg)";
L.GDKP_BIDDER_NEW_BID_LABEL = "New bid";
L.GDKP_BIDDER_STOP_AUTO_BID = "Stop Auto Bid";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "Top bid: %s by %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "Top bid: %s by you";
L.GDKP_CREATE = "Create a new GDKP session";
L.GDKP_CREATE_MANAGEMENT_CUT = "Management Cut %";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Management Cut needs to be empty or between 0 and 99 (no % sign!)";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "Choose a session type!";
L.GDKP_CREATE_SESSION_SWITCH = "Switch to this session";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!
Follow the instructions after creating this session to get started

With |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue

Selecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue
You can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "Auction type (|c00A79EFFi for more info)";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "Multi-Auction";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "Single-Auction";
L.GDKP_CREATE_SUCCESSFUL = "Session created. We advise you to /reload so that it's stored properly in case your game crashes!";
L.GDKP_CUTS_ADD_RAIDER = "Add Raider";
L.GDKP_CUTS_ADJUST_G = "adjust [g]";
L.GDKP_CUTS_ADJUST_P = "adjust [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "Announce the base cut in group chat";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!";
L.GDKP_CUTS_DELETE_RAIDER = "Delete Raider";
L.GDKP_CUTS_EDIT_RAIDER = "Edit Raider";
L.GDKP_CUTS_LOCK_TOOLTIP = "Lock and Pay";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "Manage gold trades";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

With mutators you can give more or less gold to players
Example: giving 2% extra to tanks is what mutators are for!

Note: Editing or deleting mutators here only changes them for this session

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "Not in the raid";
L.GDKP_CUTS_POT_EXPLANATION = [[

The total payout can differ slightly from the pot due to rounding differences!
Players currently in the raid can not be edited or removed!

Color explanation:
|c00F7922E(2000g) Means you owe this person 2000g
|c00BE3333(3000g) Means this person owes you 3000g
|c0092FF00(0) Means that you're square

Adjuster explanation:
With adjust [g] you can add/deduct gold to a player (use -50 to deduct 50 gold from a player's cut)
With adjust [%] you can add/deduct a percentage to a player (use -50 to give players a half cut)
]];
L.GDKP_CUTS_SUMMARY = "%s Raiders | %s With cut | Total payout: %sg";
L.GDKP_CUT_IMPORT_EMPTY = "Nothing to import, double check your CSV";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Missing gold for player %s";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "Missing header, note: it's case-sensitive!";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Missing player name";
L.GDKP_DELETE_BID_INFO = "Delete bid. Auction must be stopped first!";
L.GDKP_DISTRIBUTE_ADDRAIDER = "Add a raider to this session";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "Custom (create your own format)";
L.GDKP_EXPORT_AUCTIONS_JSON = "Detailed (JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "Share (can be imported by other players)";
L.GDKP_EXPORT_CUSTOM_FORMAT = "Your custom format";
L.GDKP_EXPORT_CUSTOM_HEADER = "Your custom header";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Custom (create your own format)";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@PLAYER,@CUT";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "Player,Cut";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "date/time at which the session was locked";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "total gold given to the player";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "gold mailed to the player";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "total gold received from the player";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "date/time at which the first item was awarded";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "gold traded to the player";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "Item,Player,Gold,Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "Date/time at which the first item was awarded";
L.GDKP_EXPORT_FORMAT_TITLE = "The title of the GDKP session";
L.GDKP_EXPORT_POT_CHANGED = "Pot changed";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "Are you sure? You won't be able to see, or bid on, upcoming items!";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!! WARNING !!|r

You're on a connected realm and are importing player names without
a realm suffix, '%s' for example. This can cause you to send
cuts and cut mails to the wrong player.

When on a connected realm always try to include the realm name of players!

Continue importing?
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "This will override any changes you've made to the cut window, are you sure?";
L.GDKP_IMPORT_CUTS_INFO = [[
You can import player cuts from your own calculations like a google sheet. softres GDKP etc.

The format is as follows (|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333Player,Gold|c00967FD2
Player1,4000
Player2,4125
Player3,3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
Import GDKP minimum prices and increments.

The format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):

|c00BE3333ItemID,Minimum,Increment|c00967FD2
18608,4000,500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here";
L.GDKP_IMPORT_SESSION = "Import GDKP Session";
L.GDKP_IMPORT_SESSION_ABOUT = "Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "You're about to import a GDKP session created by %s, are you sure?";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "This GDKP session created by %s appears to exist already, do you wish to override it?";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "Invalid data provided for GDKP extension!";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "Invalid data provided for GDKP reschedule!";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "Invalid data provided for GDKP shortening!";
L.GDKP_INVALID_DATA_FOR_START = "Invalid data provided for GDKP auction start!";
L.GDKP_INVALID_PAID_AMOUNT = "Invalid number provided for 'paid'";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "Invalid time provided in Auction:reschedule";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP Data (sold %sx)
Last sold for: %s
Average price: %s
Minimum bid: %s
Increment: %s

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "Gold mailed to you by %s";
L.GDKP_LEDGER_LEGEND_PAID_TO = "Gold paid to %s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "Gold received from %s";
L.GDKP_LEDGER_MUTATION = "Gold %s by"; -- %s = removed or added
L.GDKP_LEDGER_POT = "Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s | By %s%s | On |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "The GDKP Session is not available or locked";
L.GDKP_MAIL_ALL = "Mail All";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "No bids on Legendary+ item detected, continue manually!";
L.GDKP_MISSING_CONTENT_FOR_START = "Missing content in Auction:start";
L.GDKP_MULTIAUCTION_ABOUT = [[

With multi auctions (or batch auctions) you can auction off as many items as you want at once!
This speeds up your raid nights immensely and makes for a seamless experience for your raiders

All tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'
Give it a shot!

|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "You need to have an active (unlocked) GDKP session!";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "With this window open, %s items to add them to the list or click 'Fill from inventory' below"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Anti snipe in seconds";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "The anti snipe value needs to be 0 (empty) or >=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Go back to the item selector";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Remove all items from the list";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "Fill from inventory";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Add tradeable items from your inventory to the list";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Here you determine which items to include in your multi-auction session

Use the |c00A79EFFFill from inventory button below to add items that can still be traded to the list
Whenever you clear and re-open this window, your last fill settings will be used to automatically add items

|c00A79EFF%s items to manually add them to the list
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Next step: check raider's add-on version for compatibility";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "Not everyone is using Gargul, are you sure you want to start the auction?";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Select at least one item for your auction";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Your Gargul is outdated, we recommend updating before starting a session to prevent issues!";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Search name or iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Supports item names and iLVL e.g. '252', '<252' etc";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Auction time in seconds";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "The auction time in seconds needs to be >= 10";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "With this window open, %s items to add them to the list";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "Click the cogwheel icon to manage an auction";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "You're already the top bidder on %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
Bid |c00%s%sg
By %s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%sCLOSED
No bids]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
Minimum: |c00%s%sg
Increment: |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "Items: %s  -  Total sold: %sg  -  Pledged by me: %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
Items with bids: %s/%s
Total sold: %s
Bought by me: %s
Total bid (does not include sold): %s
Bid by me (does not include sold): %s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%sSOLD to
%s for |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
Bid |c00%s%sg
By |c0092FF00YOU!]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "Could not stop auto bidding on %s, try again or /reload!";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "Auto bid up to a maximum of %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "Auto bid up to the bid you fill in on the left";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "Stop your auto bid (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "Bid on %s could not be confirmed";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "Invalid bid or bid is too low! The minimum is %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "You need to wait two seconds between bids on the same item";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "Clear bids";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "Remove all bids from the auction";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "Close all";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "Close ALL auctions?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
Close ALL auctions

Auctions with active bids on them will be sold and can not receive new bids!
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "Close Auction";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "Close the auction. Players can no longer bid but the highest bid remains active";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "Disenchant all finished but unsold items?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
Disenchant unsold items

This will mark all unsold items as disenchanted and they will not show up in a new multi-auction session
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "Favorite this item";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "Give a final call timer of how many seconds?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "The minimum amount of seconds is 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "Start a final call for this auction by giving a (usually shorter) bid timer";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "Close ALL auctions and wrap up this multi-auction session?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
Finish Multi-Auction session

This will close all auctions and announce the total pot in chat
Auctions with active bids on them will be sold and can not receive new bids!
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "Hide inactive";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "Hide unusable";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "Show/Hide finished auctions";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "Manage Auction";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "Bid the minimum required amount";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "Bidding window closed, use |c00A79EFF/gl bid to reopen it!";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "Announce sales in chat";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "Play sound when outbid";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "More sound options...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "Show all";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "Show favorites";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "Show inactive";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "Show unusable";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "This item was sold. Use ledger (|c00%s/gdkp) to make changes!";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "Terminate";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "Remove all bidsl bids and close all auctions?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
Terminate Multi-Auction session

This will delete all bids on items that haven't sold yet and close all auctions!
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "Hover over any of the buttons below for more information";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "Show/Hide items you can't use";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "Invalid data provided for GDKP auction start!";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s bought %s for %sg";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "The loot master (%s) is outdated, this can cause bids to fail!";
L.GDKP_MULTIAUCTION_OUTBID = "You were outbid!";
L.GDKP_MUTATORS = "Mutators";
L.GDKP_MUTATOR_ADD = "Add Mutator";
L.GDKP_MUTATOR_APPLY_LABEL = "Auto apply to";
L.GDKP_MUTATOR_CREATE_NEW = "Create a new GDKP mutator";
L.GDKP_MUTATOR_DELETE_BYPASS = "Delete. Hold shift to bypass confirmation";
L.GDKP_MUTATOR_EDIT = "Edit mutator";
L.GDKP_MUTATOR_FLAT_LABEL = "Flat gold rate [example: 250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "The flat rate needs to be a number";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
Example:
|c00967FD2SELF,RL,HEALER]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "You can automatically apply this mutator to raiders using keywords:";
L.GDKP_MUTATOR_NAME_LABEL = "Name [example: Tanks]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Mutator names can not contains dots (.)";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Percentage [example: 10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "The percentage needs to be a number";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Store for future sessions";
L.GDKP_MUTATOR_UNKNOWN = "Unknown mutator: %s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "User '%s' is not allowed to start auctions";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "User '%s' is not allowed to stop auctions";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "User '%s' is not allowed to stop auction: auction invalid";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "There's not enough gold to distribute, expect some weird cut calculations!";
L.GDKP_NO_BIDS = "No bids!";
L.GDKP_OUTBID = "You were outbid!";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(active)";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
You need lead or master loot to adjust gold.
You can't adjust gold on locked/deleted sessions]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "Add/Remove gold";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s paid |c00%s%s for
%s]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333Deleted by %s
Reason: %s]];
L.GDKP_OVERVIEW_DELETED_SESSION = "(deleted)";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
You need lead or master loot to delete entries.
You can't delete entries on locked/deleted sessions]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "Provide a reason for deleting this entry";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "Delete. Hold shift to bypass note";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "Sessions with auctions attached to them will be deleted after 48 hours";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
You need lead or master loot to edit entries.
You can't edit deleted entries or entries on locked/deleted sessions]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "Export a session so others can view session details or even replace you as a loot master";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "Import a session from another player or account";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
Show a full overview of the ledger,
ideal for screenshotting purposes!]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "Lock or unlock the session";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "Lock the session for payout";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "Multi-auction: auction multiple items at once!";
L.GDKP_OVERVIEW_MUTATION_ADDED = "added to";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s %s pot by %s
Note: %s]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "removed from";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
Pot: %s
Management cut (%s%%): %sg
Per player cut (1/%s): %sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
You need lead or master loot to restore entries.
You can't restore entries of locked/deleted sessions]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "By %s%s | On |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "Unlock the session";
L.GDKP_PAYOUT_INACTIVE = "No active GDKP session detected or session is not locked for payout!";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "Increment or minimum can't be lower than .0001!";
L.GDKP_PRICE_IMPORT_INVALID_INC = "Invalid 'Increment' provided for item ID '%s'";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "Invalid 'Minimum' provided for item ID '%s'";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "Either minimum or increment is required for item ID: %s";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "Missing header, note: it's case-sensitive!";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Successfully imported data for %s items";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "Unknown item ID: %s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.
Items in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.

Want Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!

|c00FFF569Did you know?
You can move items around with drag and drop
Items will be remembered, even when you |c00A79EFF/reload
Queued items are automatically shown to raiders who have Gargul so they can prebid
Gargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Hide unusable items";
L.GDKP_SESSION = "GDKP Session";
L.GDKP_SESSION_EDIT_TITLE = "Editing %s";
L.GDKP_SHOW_UPCOMING = "Show upcoming items";
L.GDKP_STOP_AUCTION_FIRST = "Stop the auction first!";
L.GDKP_THEY_OWE = "%s owes you %s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP Session
Spent by player: %s
Given: %s
Received: %s
Player cut: %s

%s
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "Exclude from GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "Gold traded will not be added to amount given or received";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Gold |c00967FD2given to %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "Unable to add %s to the trade window. Try adding it manually!";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "You don't have enough money to pay %s";
L.GDKP_TRADE_GOLD_TO_GIVE = "To give: %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "To receive: %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Gold |c00967FD2received from %s";
L.GDKP_TRY_MULTIAUCTION = "Check out Multi Auctions!";
L.GDKP_TUTORIAL_INFO = "Follow the steps below to quickly get started with Gargul GDKP!";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "Activate this session by clicking the |c00FFF569Enable button below!";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s an item to auction or queue a single item"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
Helpful commands:
- |c00FFF569/gdkp to open this window
- |c00FFF569/gl ma to open the multi-auction window
- |c00FFF569/gl au to open the single item auctioneer / queue
- |c00FFF569/gl pm to set up auto-looting

]];
L.GDKP_TUTORIAL_STEP_DONE = "If all went well then you will see your freshly auctioned item(s) here!";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!";
L.GDKP_TUTORIAL_STEP_NEW = "Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created";
L.GDKP_TUTORIAL_STEP_READY = "You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!";
L.GDKP_TUTORIAL_STEP_SELL = "Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!";
L.GDKP_TUTORIAL_TITLE = "Getting started";
L.GDKP_UNKNOWN_ITEM = "Unknown itemID in Auction:create: %s";
L.GDKP_UNKNOWN_SESSION = "Unknown sessionIdentifier in Auction:create: %s";
L.GDKP_YOU_OWE = "You owe %s %s";
L.GIVEN = "Given";
L.GOLD_INDICATOR = "g";
L.GROUP = "Group";
L.GROUP_MANAGER = "Group Manager";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "Download on CurseForge";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "Halt";
L.HEADER = "Header";
L.HELLO = "|c00%sGargul v%s by Zhorax@Firemaw. Type |c00%s/gl or |c00%s/gargul to get started!";
L.HIDE = "Hide";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.IDENTITY_INFO = "Visit the URL below to learn more about personalizing Gargul GDKPs";
L.IDENTITY_TOOLTIP = "Your logo here? Click for more info!";
L.IMPORT = "Import";
L.IMPORTED_AND_UPDATED_ON = "Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s";
L.IMPORT_EXPLANATION = "What kind of data would you like to import?";
L.IMPORT_SUCCESSFUL = "Import of boosted roll data successful";
L.INC = "Inc";
L.INCLUDE_AWARDED = "Include previously awarded items";
L.INCLUDE_BOES = "Include BOEs";
L.INCLUDE_MATERIALS = "Include materials (like Abyss Crystals)";
L.INCREMENT = "Increment";
L.INFO = "Info";
L.INVALID_DATA_WARNING = "Invalid data supplied";
L.ITEM = "Item";
L.JSON_DECODE_WARNING = "Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!";
L.KEYS_INFO = [[
Gargul Item Hotkeys

Roll out: |c00A79EFF%s
Award: |c00A79EFF%s
Disenchant: |c00A79EFF%s


-- Right-click to disable this window --
]];
L.LEDGER = "Ledger";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "You need to be the master looter or have an assist / lead role!";
L.LOCALE_CHANGE_NOTE = "Note: you can change the locale at any time in the settings or via |c00%s/gl locale";
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ENUS = "enUS"; -- English (United States)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_ITIT = "itIT"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul posts chat messages in English (default)
You can select a different language in the dropdown below

Your current chat language is '%s', enabling a different language will cause a /reload!
]];
L.LOCALE_NONE_TITLE = "Choose a chat language for Gargul";
L.LOCALE_PTBR = "ptBR"; -- Portuguese (Brazil)
L.LOCALE_RURU = "ruRU"; -- Russian (Russia)
L.LOCALE_ZHCN = "zhCN"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "zhTW"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "You have one or more addons installed that can potentially cause Gargul to misfunction: %s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "Clear SoftRes";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "Clear TMB";
L.LOOTMASTER_DEFAULT_NOTE = "/roll for MS or /roll 99 for OS";
L.LOOTMASTER_IMPORT_SR_BUTTON = "Import SoftRes";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "Import TMB";
L.LOOTMASTER_NOTICE_LABEL = "You were given the role of Master Looter";
L.LOOTMASTER_OPEN_LABEL = "Open this window automatically";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Loot priorities cleared successfully";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Loot priorities imported successfully";
L.LOOTPRIORITY_INVALID_DATA = "Invalid data provided";
L.LOOTPRIORITY_INVALID_LINE = "Invalid data provided in line: '%s': missing item id or priority";
L.LOOTPRIORITY_PROCESS_INCOMING = "Attempting to process incoming loot priorities from %s";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Loot Prio";
L.MAIL = "Mail";
L.MAILED = "Mailed";
L.MAIL_CUTS_EXPLANATION = "Mail cut to players";
L.MAINSPEC_ABBR = "MS";
L.MAXIMIZE = "Maximize";
L.MIN = "Min";
L.MINIMAP_BUTTON_AWARDED = "Awarded loot history";
L.MINIMAP_BUTTON_CUTS = "GDKP Cuts";
L.MINIMAP_BUTTON_EXPORT = "Export data";
L.MINIMAP_BUTTON_GARGUL = "Open Gargul";
L.MINIMAP_BUTTON_IMPORT = "Import data";
L.MINIMAP_BUTTON_LEDGER = "GDKP Ledger";
L.MINIMAP_BUTTON_MULTIAUCTION = "Multiauction";
L.MINIMAP_BUTTON_SETTING_INFO = "Change settings in /gl minimap";
L.MINIMIZE = "Minimize";
L.MINIMIZE_ON_AWARD = "Minimize on award";
L.MINIMIZE_ON_START = "Minimize on start";
L.MINIMUM = "Minimum";
L.MINIMUM_QUALITY = "Minimum Quality";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "Move";
L.MULTI_AUCTION = "Multi-Auction";
L.NAME = "Name";
L.NEW = "New";
L.NEXT = "Next";
L.NO = "No";
L.NONE = "None";
L.NOTE = "Note";
L.NOTHING = "Nothing";
L.NO_BIDS_ACTION = "When no one bids do:";
L.NO_OFFICER_PRIVILEGES = "You don't have officer privileges";
L.OFFSPEC_ABBR = "OS";
L.OK = "Ok";
L.OPEN = "Open";
L.OPEN_AUCTIONEER = "Open Auctioneer";
L.OPEN_MULTI_AUCTION = "Open Multi-Auction";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "GREED";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORE";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "NEED";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASS";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "RANDOM";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SELF";
L.PACKMULE_CONFIRM_DISENCHANTER = "Set %s as your disenchanter?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "Send %s to %s? Type /gl cd to remove this disenchanter!";
L.PACKMULE_NO_DISENCHANTER_WARNING = "No disenchanter set, use /gl sd [mydisenchanter] to set one";
L.PACKMULE_WHO_IS_DISENCHANTER = "Who is your disenchanter?";
L.PAID = "Paid";
L.PASS = "Pass";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "Player";
L.PLAYER_ITEM_WON_COUNT = "Items won by %s:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "Plus Ones";
L.PLUSONES_AWARD_DIALOG_LABEL = "Add a +1";
L.PLUSONES_BROADCAST_CONFIRM = "Are you sure you want to broadcast your plus one data to everyone in your party/raid?";
L.PLUSONES_BROADCAST_PROCESS_START = "Attempting to process incoming PlusOnes data from %s";
L.PLUSONES_CLEAR_CONFIRM = "%s wants to clear all your PlusOne data. Clear all data?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?";
L.PLUSONES_IMPORT_CONFIRM = "Are you sure you want to import new data broadcasted by %s?";
L.PLUSONES_IMPORT_ERROR = "Invalid data provided. Make sure that the contents follows the required format and no header row is included";
L.PLUSONES_IMPORT_INFO = [[
Here you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.

The table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.

Here is an example line:

Foobar,240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Automatically accept incoming broadcasts from %s";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Block all incoming +1 shared data";
L.PLUSONES_UPDATE_CONFIRM = [[
Are you sure you want to update your existing PlusOne data with data from %s?

Your latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s.]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "Pot";
L.PRICE = "Price";
L.PRIOLIST_ABBR = "PL";
L.QUALITY_COMMON = "Common";
L.QUALITY_EPIC = "Epic";
L.QUALITY_HEIRLOOM = "Heirloom";
L.QUALITY_LEGENDARY = "Legendary";
L.QUALITY_POOR = "Poor";
L.QUALITY_RARE = "Rare";
L.QUALITY_UNCOMMON = "Uncommon";
L.QUEUE = "Queue";
L.RAIDERS = "Raiders";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Who's Missing";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Show missing player names";
L.RAIDGROUPS_DISBAND_BUTTON = "Disband raid";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Disband your raid";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s is listed twice on the roster!";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
In the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.

You can provide a |c00FFF569Wowhead raid composition link:]];
L.RAIDGROUPS_GARGUL_BUTTON = "Gargul Group Wiki";
L.RAIDGROUPS_GARGUL_INFO = "Visit the Gargul group wiki for more info on the raid group format";
L.RAIDGROUPS_IMPOSTER_WARNING = "The following players are not part of the roster: %s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Invalid group data provided, check your format!";
L.RAIDGROUPS_INVITE_BUTTON = "Invite";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Send invites to players on roster";
L.RAIDGROUPS_IN_COMBAT_WARNING = "Can't sort groups while %s is in combat!"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "You need to be in a raid!";
L.RAIDGROUPS_NO_TANKS_WARNING = "No tanks defined";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "Can't find a place for %s, are you trying to put more than 5 people in 1 group?";
L.RAIDGROUPS_PURGE_BUTTON = "Kick unwanted players";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Kick players that aren't on the roster";
L.RAIDGROUPS_SORTING_ERROR = "Something went wrong while moving %s";
L.RAIDGROUPS_SORTING_FINISHED = "Finished applying raid roster";
L.RAIDGROUPS_SORTING_GROUPS = "Sorting groups";
L.RAIDGROUPS_SORT_BUTTON = "Apply Groups";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Sort groups based on roster";
L.RAIDGROUPS_SORT_IN_PROGRESS = "Sorting is still in progress, wait a bit!";
L.RAIDGROUPS_TANKS_ASSIGNED = "All tanks are assigned";
L.RAIDGROUPS_TANK_BUTTON = "Assign Tanks";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Wowhead Comp Tool";
L.RAIDGROUPS_WOWHEAD_INFO = "You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window";
L.REMOVE_BID = "Remove bid";
L.RESET_SETTINGS = "Reset Settings";
L.RESET_SETTINGS_CONFIRMATION = "Are you sure you want to reset all of Gargul's settings? This can't be undone!";
L.RESET_UI = "Reset Gargul UI";
L.RESET_UI_CONFIRMATION = "Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!";
L.RESTORE = "Restore";
L.RESUME = "Resume";
L.RIGHT_SYMBOL = ">";
L.ROLL = "Roll";
L.ROLLING_AWARD_CONFIRM = "Award %s to %s?";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Close on award";
L.ROLLING_CLOSE_ON_START_LABEL = "Close on start";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Hold shift to bypass the award confirmation";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Hold shift to show the award confirmation";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
Warning: another identical roll was found which can point to a tie

]];
L.ROLLING_INVALID_START_DATA_WARNING = "Invalid data provided for roll of start!";
L.ROLLING_ITEM_WON_BR_COST = "(BR: %s)";
L.ROLLING_ITEM_WON_GIVEN = "(item given: yes)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(item given: no)";
L.ROLLING_ITEM_WON_OS = "(OS)";
L.ROLLING_NOTE_LABEL = "NOTE";
L.ROLLING_NO_ROLLOFF_WARNING = "Can't stop roll off, no roll off in progress";
L.ROLLING_PASS_BUTTON = "Pass";
L.ROLLING_REOPEN_ROLL_COUNT = "rolls: %s";
L.ROLLING_REOPEN_TOOLTIP = "Open master looter window";
L.ROLLING_ROLL_ACCEPTED = "Roll accepted!";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "A roll is currently in progress";
L.ROLLING_ROLL_PRIOLIST = "Prio [%s]";
L.ROLLING_ROLL_SR_COUNT = "SR [%sx]";
L.ROLLING_ROLL_WISHLIST = "Wish [%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "You need to select a player first";
L.ROLLING_TIMER_LABEL = "TIMER (s)";
L.ROLLING_UNUSABLE_ITEM = "You can't use this item!";
L.ROLLING_WINNER_NOT_UNIQUE = "The winner's name is not unique, select the player you'd like to award %s to";
L.SECONDS_ABBR = "s";
L.SELECT_ALL = "Select / Disable all";
L.SESSION = "Session";
L.SETTINGS = "Settings";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Announce incoming bids";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Announce pot after awarding item";
L.SETTINGS_ANNOUNCE_START = "Announce auction start";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Announce countdown in raid warning";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Announce incoming bids in raid warning";
L.SETTINGS_RESET_UI = "Reset Gargul UI";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Whisper bidder if bid is too low";
L.SILVER_INDICATOR = "s";
L.SKIP = "Skip";
L.SOFTRES = "Soft-Reserves";
L.SOFTRES_ABBR = "SR";
L.SOFTRES_BROADCAST_CONFIRM = "Are you sure you want to broadcast your softres data to everyone in your party/raid?";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "Couldn't process SoftRes data received from %s";
L.SOFTRES_CLEAR_CONFIRM = "Are you sure you want to clear all existing soft-reserve data?";
L.SOFTRES_EVERYONE_RESERVED = "Everyone filled out their soft-reserves";
L.SOFTRES_FEATURE_MISSING = [[
Hard-reserve information is not available because the soft-reserves
provided were not generated using the 'Gargul Export' button on softres.it]];
L.SOFTRES_IMPORT_DETAILS = "Imported on |c00A79EFF%s at |c00A79EFF%s";
L.SOFTRES_IMPORT_FIXED_NAME = "Auto name fix: the SR of '%s' is now linked to '%s'";
L.SOFTRES_IMPORT_INFO = "In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below.";
L.SOFTRES_IMPORT_INVALID = "Invalid soft-reserve data provided";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here";
L.SOFTRES_IMPORT_NEW_PLUSONES = "The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "The following players did not reserve anything:";
L.SOFTRES_IMPORT_SUCCESSFUL = "Soft-reserves imported successfully";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "Import successful!";
L.SOFTRES_IMPORT_USE_GARGUL = "SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "Failed to connect to LootReserve, contact support (include message below)";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "Click here to see hard-reserve info";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "No items are hard-reserved";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "No hard-reserve info available";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "Post missing SRs";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "Post SR URL";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "This player did not reserve anything!";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "Attempting to process incoming SoftRes data from %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "This item is hard-reserved";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "For: %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Note: %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Reserved by";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "Something went wrong!";
L.START = "Start";
L.STOP = "Stop";
L.TAB_REPLACES_T = "	 is replaced by a tab";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "Time";
L.TITLE = "Title";
L.TMBETC = "TMB, DFT or PRIO3";
L.TMB_BROADCAST_CONFIRM = "Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!";
L.TMB_BROADCAST_PROCESS_START = "Attempting to process incoming TMB data from %s";
L.TMB_CLEAR_CONFIRM = "Are you sure you want to clear all plus one data?";
L.TMB_CLEAR_RAIDER_DATA = "Clear Raider Data";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "Clear TMB data for all raiders?";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "Auto-sharing enabled: %s";
L.TMB_IMPORT_CPO_INFO = "On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!";
L.TMB_IMPORT_DETAILS = "Imported on ${date} at ${time}";
L.TMB_IMPORT_DFT_INFO = "Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!";
L.TMB_IMPORT_INVALID_CSV = "Invalid CSV provided, the format is: 6948,player1,player2";
L.TMB_IMPORT_INVALID_DFT = "Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!";
L.TMB_IMPORT_NOTES_AVAILABLE = "Priority notes available: %s";
L.TMB_IMPORT_NUMBER = "Number of items imported: %s";
L.TMB_IMPORT_PLAYER_NO_DATA = "The following players have no %s entries:"; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "How to use Gargul with TMB";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "Paste your TMB export contents as-is in the box below and click 'Import'";
L.TMB_NO_BROADCAST_TARGETS = "There's no one in your group to broadcast to";
L.TMB_SYNCED = "TMB data synced";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF    Note: |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(OS)";
L.TMB_TOOLTIP_PRIO_HEADER = "%s Prio List"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF    Tier: %s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "TMB Wish List";
L.TOGGLE_DATES = "Show/Hide Dates";
L.TOGGLE_QUEUE = "Show/Hide Queue";
L.TRADETIME_AWARD_HOWTO = "%s to award loot!";
L.TRADETIME_ROLL_HOWTO = "%s to roll out loot!";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "Hide all awarded items";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "Hide disenchanted items";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "Hide items awarded to self";
L.TRADE_ANNOUNCE = "Announce Trade";
L.TRADE_ANNOUNCE_INFO = "Announce trade details to group or in /say when not in a group";
L.TUTORIAL = "Tutorial";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.
Want to directly sell an item without bidding? Use |c00A79EFF%s

You can open the %s window directly by typing |c00A79EFF/gl auction

Gargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the "Exclude from GDKP" checkbox when trading!

|c00FFF569Did you know?
Awarded items will automatically be added to the trade window
Gargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
This window shows all the items that have been awarded on any given date (select one or more dates on the left).

Items can contain the following tags:

|c00A79EFFOS: Awarded for offspec
|c00A79EFFSR: This item was soft-reserved
|c00A79EFFWL: This item was wishlisted (Thatsmybis)
|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)
]];
L.TUTORIAL_BIDDER_QUEUE = [[
The items you see here are in the master looter's GDKP queue
You can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)

You can resize the window, move it around, or minimize it. Try it out!

For loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!
]];
L.TUTORIAL_MORE_HELP = "Need more help?";
L.TYPE = "Type"; -- As in type of roll or type of item
L.UNKNOWN = "unknown";
L.UNKNOWN_COMM_ACTION = "Unknown comm action '%s', make sure to update Gargul!";
L.UNLOCK = "Unlock";
L.UPDATE_GARGUL = "Update Gargul!";
L.VERSION_ABBR = "v";
L.VERSION_CHECK_BUTTON_REPORT = "Report";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Report outdated results in group chat";
L.VERSION_CHECK_COLUMN_STATUS = "Gargul status";
L.VERSION_CHECK_STATUS_CHECKING = "Checking version ...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s: the player is up-to-date
|c00F7922Ev%s: the player needs to update his add-ons
|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version
|c00808080%s: the player is offline or is ignoring us!
|c0000FFFF%s: the player is on our ignore list!

]];
L.VERSION_CHECK_STATUS_IGNORED = "PLAYER IGNORED!";
L.VERSION_CHECK_STATUS_OFFLINE = "Offline";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "No response";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "No response:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Offline:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "Outdated:";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "Up-to-date:";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul is out of date and won't work until you update!";
L.VERSION_INVALID_WARNING = "Invalid version string provided in Version:addRelease";
L.VERSION_UPDATE = "Update Gargul!";
L.VERSION_UPDATED = "|c00%sGargul is now updated to |c00%sv%s";
L.VERSION_UPDATE_AVAILABLE = "v|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !";
L.WINDOW = "Window";
L.WINDOW_HEADER = "Gargul v%s";
L.WINDOW_SCALE = "Window Scale";
L.WISHLIST_ABBR = "WL";
L.YES = "Yes";
L.YOU_DISABLED_GDKP_QUEUES = "You disabled GDKP queues";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf";
L.ZLIB_DECOMPRESS_WARNING = "Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!";

--[[ SETTINGS ]]
L.SETTINGS_SECTION_GETTING_STARTED = "Getting Started";
L.SETTINGS_SECTION_GENERAL = "General";
L.SETTINGS_SECTION_SOFTRES = "SoftRes";

L.SETTINGS_SECTION_GETTING_STARTED_INTRO_BONUS_FEATURES = "Bonus Features";
L.SETTINGS_SECTION_GETTING_STARTED_INTRO = [[
Gargul can be used and tested without being in a raid,
|c00A79EFFtry it out|r by using the most common actions:

Auto Looting: |c00A79EFF/gl pm|r
GDKP: |c00A79EFF/gdkp|r
SoftRes: |c00A79EFF/gl sr|r
TMB: |c00A79EFF/gl tmb|r

Roll/Auction: |c00A79EFF%s|r on an item
Award/Sell: |c00A79EFF%s|r on an item

]];
L.SETTINGS_SECTION_GETTING_STARTED_MORE_INFO = "More info";
L.SETTINGS_SECTION_GETTING_STARTED_MORE_INFO_DIALOG = "Show your support by joining our cause!";
L.SETTINGS_SECTION_GETTING_STARTED_PATRONS = "Patrons";

L.SETTINGS_WELCOME_MESSAGE_LABEL = "Welcome message";
L.SETTINGS_WELCOME_MESSAGE_DESCRIPTION = "Show a message including current version when logging in";
L.SETTINGS_MASTER_LOOTING_LINK_NORMAL_AND_HARD_MODE_ITEMS_LABEL = "Link heroic mode items in TOGC and later and ICC";
L.SETTINGS_MASTER_LOOTING_LINK_NORMAL_AND_HARD_MODE_ITEMS_DESCRIPTION = "Ensures that TMB/DFT entries on normal mode items also show up on their heroic counterpart (and vice versa!)";
L.SETTINGS_SHOW_UPDATE_ALERT_LABEL = "Show update alert";
L.SETTINGS_SHOW_UPDATE_ALERT_DESCRIPTION = [[
Show an alert when there's an update. We believe in 'release early, release often',
it allows us to respond to bugs more quickly and limits the severity of issues
]];
L.SETTINGS_CHANGE_LOG_LABEL = "Show changelog";
L.SETTINGS_CHANGE_LOG_DESCRIPTION = "Show important changes after updating Gargul";
L.SETTINGS_OPEN_CHAT_LOCALE_LABEL = "Chat message language";
L.SETTINGS_OPEN_CHAT_LOCALE_DESCRIPTION = "Change the language";
L.SETTINGS_NO_SOUNDS_LABEL = "No sounds";
L.SETTINGS_NO_SOUNDS_DESCRIPTION = "When a roll starts or when you're outbid, Gargul will notify you";
L.SETTINGS_SOUND_CHANNEL_LABEL = "On which channel should Gargul play sounds (default SFX)";
L.SETTINGS_SOFT_RES_ENABLE_TOOLTIPS_LABEL = "Enable tooltip data";
L.SETTINGS_SOFT_RES_ENABLE_TOOLTIPS_DESCRIPTION = "Show SoftRes data on tooltips";
L.SETTINGS_SOFT_RES_HIDE_INFO_OF_PEOPLE_NOT_IN_GROUP_LABEL = "Show players in group only";
L.SETTINGS_SOFT_RES_HIDE_INFO_OF_PEOPLE_NOT_IN_GROUP_DESCRIPTION = "When in a group you only see players who are there with you on item tooltips and dropped loot announcements";

L.HOTKEYS_CLICK = "CLICK";
L.HOTKEYS_RIGHTCLICK = "RIGHTCLICK";
L.HOTKEYS_MIDDLECLICK = "MIDDLECLICK";
L.HOTKEYS_SHIFT_CLICK = "SHIFT_CLICK";
L.HOTKEYS_SHIFT_RIGHTCLICK = "SHIFT_RIGHTCLICK";
L.HOTKEYS_SHIFT_MIDDLECLICK = "SHIFT_MIDDLECLICK";
L.HOTKEYS_ALT_CLICK = "ALT_CLICK";
L.HOTKEYS_ALT_RIGHTCLICK = "ALT_RIGHTCLICK";
L.HOTKEYS_ALT_MIDDLECLICK = "ALT_MIDDLECLICK";
L.HOTKEYS_CTRL_CLICK = "CTRL_CLICK";
L.HOTKEYS_CTRL_RIGHTCLICK = "CTRL_RIGHTCLICK";
L.HOTKEYS_CTRL_MIDDLECLICK = "CTRL_MIDDLECLICK";
L.HOTKEYS_ALT_SHIFT_CLICK = "ALT_SHIFT_CLICK";
L.HOTKEYS_ALT_SHIFT_RIGHTCLICK = "ALT_SHIFT_RIGHTCLICK";
L.HOTKEYS_ALT_SHIFT_MIDDLECLICK = "ALT_SHIFT_MIDDLECLICK";
L.HOTKEYS_CTRL_SHIFT_CLICK = "CTRL_SHIFT_CLICK";
L.HOTKEYS_CTRL_SHIFT_RIGHTCLICK = "CTRL_SHIFT_RIGHTCLICK";
L.HOTKEYS_CTRL_SHIFT_MIDDLECLICK = "CTRL_SHIFT_MIDDLECLICK";

L.SETTINGS_MINIMAP_BUTTON_ENABLED_LABEL = "Enable minimap Icon";

L.SETTINGS_MINIMAP_BUTTON_ACTION_DISABLED = "Do nothing";
L.SETTINGS_MINIMAP_BUTTON_ACTION_GARGUL = "Open Gargul";
L.SETTINGS_MINIMAP_BUTTON_ACTION_SOFTRES = "Softres";
L.SETTINGS_MINIMAP_BUTTON_ACTION_GDKP = "GDKP";
L.SETTINGS_MINIMAP_BUTTON_ACTION_GDKP_LEDGER = "GDKP Ledger";
L.SETTINGS_MINIMAP_BUTTON_ACTION_GDKP_CUTS = "GDKP Cuts";
L.SETTINGS_MINIMAP_BUTTON_ACTION_MULTIAUCTION = "GDKP Multiauction";
L.SETTINGS_MINIMAP_BUTTON_ACTION_IMPORT = "Import data";
L.SETTINGS_MINIMAP_BUTTON_ACTION_EXPORT = "Export data";
L.SETTINGS_MINIMAP_BUTTON_ACTION_AWARDHISTORY = "Loot history";
L.SETTINGS_MINIMAP_BUTTON_ACTION_PLUS_ONE = "Manage +1";
L.SETTINGS_MINIMAP_BUTTON_ACTION_BOOSTED_ROLLS = "Boosted rolls";
