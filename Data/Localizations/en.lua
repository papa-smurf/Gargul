Gargul_L = {};
local L = Gargul_L;

--[[ DON'T TRANSLATE! ]]
L.GARGUL = "Gargul";

--[[ START TRANSLATING HERE! ]]
L.ALL_SETTINGS = "All Settings";
L.ANTISNIPE = "Anti Snipe";
L.ANTISNIPE_EXPLANATION = {
    " ",
    "An Anti Snipe value of 10 means any bids with less than 10 seconds left",
    "resets the time remaining back to 10 seconds",
    " ",
    "You can leave this empty or set to 0 to disable Anti Snipe completely",
    "Anti Snipe values less than 5 are not supported",
    " ",
};
L.ADD_DROPS_TO_QUEUE = "Add dropped loot to queue";
L.ALL_CUTS_MAILED = "All cuts were mailed!";
L.AUCTIONEER = "Auctioneer";
L.AUCTION = "Auction";
L.AUCTIONS = "Auctions";
L.AUTO_AWARD = "Auto award";
L.AUTO_TRADE_OPTIONS = "Auto trade";
L.AWARD = "Award";
L.AWARD_ITEM_CONFIRMATION = "Award %s to %s for %s|c00FFF569g|r?";
L.BID = "Bid";
L.BID_DENIED_WHISPER = "Bid denied, the minimum bid is %sg";
L.BIDDING_STARTED = "Bidding starts on %s. Minimum is %sg, increment is %sg. Use raid chat!";
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
L.CHANGE_SCALE = "Adjust Scale";
L.CHANNEL = "Channel";
L.CHANNEL_WHISPER = "Whisper";
L.CHANNEL_RAID_WARNING = "Raid Warning";
L.CLEAR = "Clear";
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
L.DELETE_BID_TOOLTIP = "Delete bid. Auction must be stopped first!";
L.DISENCHANT = "Disenchant";
L.EDIT = "Edit";
L.EXPORT = "Export";
L.FINAL_CALL = "Final Call";
L.FINAL_CALL_ANNOUNCEMENT = "Final Call on %s: %s seconds left to bid!";
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
L.GOLD_TRADE_GIVEN = "I gave %s to %s";
L.GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s";
L.GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s";
L.GOLD_TRADE_RECEIVED = "I received %s from %s";
L.GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s";
L.GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s";
L.GROUP = "Group";
L.GROUP_MANAGER = "Group Manager";
L.IMPORT_EXPLANATION = "What kind of data would you like to import?";
L.INFO = "Info";
L.INC = "Inc";
L.INCLUDE_BOES = "Include BOEs";
L.INCREMENT = "Increment";
L.GDKP_ACTIVATED = "GDKP Activated";
L.HALT = "Halt";
L.HIDE = "Hide";
L.HIGHEST_BIDDER_CONFIRMATION = "%s is the highest bidder (%sg)";
L.I_REMOVED_AWARDED = "I removed %s awarded to %s for %sg";
L.I_RESTORED_AWARDED = "I restored %s awarded to %s for %sg";
L.I_REMOVED_GOLD = "I removed %sg from the pot";
L.I_RESTORED_GOLD = "I added %sg back to the pot";
L.RESTORE = "Restore";
L.START = "Start";
L.STOP = "Stop";
L.STOP_AUCTION = "Stop the auction first!";
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
L.MOVE = "Move";
L.NEXT = "Next";
L.NO_BIDS_ACTION = "When no one bids do:";
L.NOTHING = "Nothing";
L.OPEN = "Open";
L.OPEN_AUCTIONEER = "Open Auctioneer";
L.PLUS10 = "+10";
L.PLUSONES = "Plus Ones";
L.POT = "Pot";
L.POT_HOLDS = "The pot now holds %sg";
L.POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %sg";
L.POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %sg";
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
L.SETTINGS = "Settings";
L.SOFTRES = "Soft-Reserves";
L.TIME = "Time";
L.TMBETC = "TMB, DFT or PRIO3";
L.TOGGLE_QUEUE = "Show/Hide Queue";
L.TOGGLE_DATES = "Show/Hide Dates";
L.TUTORIAL = "Tutorial";
L.TUTORIAL_AWARD_OVERVIEW = [[This window shows all the items that have been awarded on any given date (select one or more dates on the left).

Items can contain the following tags:

|c00A79EFFOS|r: Awarded for offspec
|c00A79EFFSR|r: This item was soft-reserved
|c00A79EFFWL|r: This item was wishlisted (Thatsmybis)
|c00A79EFFPL|r: This item was priolisted (Thatsmybis, DFT, prio3)
]];
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
L.WINDOW = "Window";
L.WINDOW_SCALE = "Window Scale";
L.YOU_DISABLED_GDKP_QUEUES = "You disabled GDKP queues";

L.SETTINGS_ANNOUNCE_START = "Announce auction start";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Announce pot after awarding item";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Whisper bidder if bid is too low";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Announce countdown in raid warning";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Announce incoming bids";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Announce incoming bids in raid warning";