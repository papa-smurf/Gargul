local L = Gargul_L;

--[[ CHAT MESSAGES ]]
L.CHAT = {
    --[[ enUS ]]
    enUS = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },

    --[[ deDE ]]
    deDE = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },

    --[[ zhCN ]]
    zhCN = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },

    --[[ esES ]]
    esES = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },

    --[[ frFR ]]
    frFR = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },

    --[[ itIT ]]
    itIT = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },

    --[[ koKR ]]
    koKR = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },

    --[[ ptBR ]]
    ptBR = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },

    --[[ ruRU ]]
    ruRU = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },

    --[[ zhTW ]]
    zhTW = {
        PASS = "Pass",
        FLIGHT_ATTENDANT = "I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul missing for:",
        VERSION_CHECK_OUTDATED = "Gargul outdated for:",
        VERSION_CHECK_OFFLINE = "The following players were offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s was awarded to %s. Congrats!",
        ITEM_AWARDED_BR = "%s was awarded to %s for %s points. Congrats!",
        ITEM_AWARDED_GDKP = "%s was awarded to %s for %s. Congrats!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "I gave %s to %s",
        GOLD_TRADE_GIVEN_DELETED = "I deleted a gold trade in which I gave %s to %s",
        GOLD_TRADE_GIVEN_RESTORED = "I restored a gold trade in which I gave %s to %s",
        GOLD_TRADE_RECEIVED = "I received %s from %s",
        GOLD_TRADE_RECEIVED_DELETED = "I deleted a gold trade in which I received %s from %s",
        GOLD_TRADE_RECEIVED_RESTORED = "I restored a gold trade in which I received %s from %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "I have the following items left to trade",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Your %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Player %s's %s roll is /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = " (default)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Your +1 total is %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Player %s's +1 total is %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "I owe you %s. Enjoy!",
        GDKP_YOU_OWE_ME = "You owe me %s. Thank you!",
        GDKP_POT_UPDATED = "Pot was updated, it now holds %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Pot was updated after deleting an auction, it now holds %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Pot was updated after restoring an auction, it now holds %s",
        GDKP_REMOVED_AWARDED = "I removed %s awarded to %s for %s",
        GDKP_RESTORED_AWARDED = "I restored %s awarded to %s for %s",
        GDKP_REMOVED_GOLD = "I removed %sg from the pot",
        GDKP_RESTORED_GOLD = "I added %sg back to the pot",
        GDKP_POT_HOLDS = "The pot now holds %s",
        GDKP_CONFIRM_TOP_BID = "%s is the highest bidder (%s)",
        GDKP_FINAL_CALL = "Final Call on %s: %s seconds left to bid!",
        GDKP_BID_DENIED = "Bid denied, the minimum bid is %s",
        GDKP_START_BIDDING = "Bid on %s. Minimum is %s, increment is %s. Use raid chat!",
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
        SOFTRES_HARDRESERVED_NOTICE = "%s (This item is hard-reserved!)",
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
        TRADE_GAVE_MULTIPLE_OF_ITEM = "I gave %sx%s", -- I gave [item]x3
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
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "I received %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "from %s and got my %s enchanted with %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s from %s and got my %s enchanted with %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Random winner for %s selected (%s)", -- First %s is item, second %s is player,
    },
};

L.CHAT.esMX = L.CHAT.esES;