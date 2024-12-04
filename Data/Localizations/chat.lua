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
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "(default)",

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
        ROLLING_TMB_INFO = "These players have the highest %s prio: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
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
        PASS = "passt",
        FLIGHT_ATTENDANT = "Ich benutze Gargul, um Beute zu verteilen. Es erleichtert das Würfeln, also probier es unbedingt aus!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul fehlt bei:",
        VERSION_CHECK_OUTDATED = "Gargul ist veraltet bei:",
        VERSION_CHECK_OFFLINE = "Die folgenden Spieler waren offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s wurde an %s verliehen. Glückwunsch!",
        ITEM_AWARDED_BR = "%s wurde %s für %s Punkte verliehen. Glückwunsch!",
        ITEM_AWARDED_GDKP = "%s wurde %s für %s verliehen. Glückwunsch!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "Ich habe %s an %s gegeben",
        GOLD_TRADE_GIVEN_DELETED = "Ich habe einen Goldhandel gelöscht, bei dem ich %s an %s gegeben habe",
        GOLD_TRADE_GIVEN_RESTORED = "Ich habe einen Goldhandel wiederhergestellt, bei dem ich %s an %s gegeben habe",
        GOLD_TRADE_RECEIVED = "Ich habe %s von %s erhalten",
        GOLD_TRADE_RECEIVED_DELETED = "Ich habe einen Goldhandel gelöscht, bei dem ich %s von %s erhalten habe",
        GOLD_TRADE_RECEIVED_RESTORED = "Ich habe einen Goldhandel wiederhergestellt, bei dem ich %s von %s erhalten habe",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "Ich habe noch die folgenden Gegenstände zum Handeln übrig",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Dein %s-Wurf ist /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Der %s-Wurf von Spieler %s ist /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "(Standard)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Dein +1-Gesamtwert beträgt %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Der +1-Gesamtwert von Spieler %s beträgt %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "Ich schulde dir %s",
        GDKP_YOU_OWE_ME = "Du schuldest mir %s. Danke!",
        GDKP_POT_UPDATED = "Der Pott wurde aktualisiert, er enthält jetzt %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Der Pott wurde nach dem Löschen einer Auktion aktualisiert und enthält jetzt %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Der Pott wurde nach der Wiederherstellung einer Auktion aktualisiert und enthält jetzt %s",
        GDKP_REMOVED_AWARDED = "Ich habe %s, das %s für %s verliehen wurde, entfernt",
        GDKP_RESTORED_AWARDED = "Ich habe %s wiederhergestellt, das %s für %s verliehen wurde",
        GDKP_REMOVED_GOLD = "Ich habe %sg aus dem Pott entfernt",
        GDKP_RESTORED_GOLD = "Ich habe %sg wieder in den Pott gegeben",
        GDKP_POT_HOLDS = "Der Pott enthält jetzt %s",
        GDKP_CONFIRM_TOP_BID = "%s ist der Höchstbietende (%s)",
        GDKP_FINAL_CALL = "Letzter Aufruf zu %s: Noch %s Sekunden zum Bieten!",
        GDKP_BID_DENIED = "Gebot abgelehnt, das Mindestgebot beträgt %s",
        GDKP_START_BIDDING = "Biete auf %s. Minimum ist %s, Inkrement ist %s. Benutze den Raid-Chat!",
        GDKP_STOP_BIDDING = "Stopp deine Gebote!",
        GDKP_SECONDS_TO_BID = "%s Sekunden zum Bieten",
        GDKP_POT_TOTAL = "Gesamtpott: %s",
        GDKP_BASE_CUT = "Basisanteil: %s",

        --[[ MULTIAUCTION ]]
        MULTIAUCTION_STARTED = "Ich habe eine Mehrfachauktion gestartet. Du kannst es nicht sehen? Stell sicher, dass du Gargul heruntergeladen/aktualisiert hast!",
        MULTIAUCTION_RESUMED = "Ich habe eine vorherige Auktion fortgesetzt. Überprüfe deine Gebote noch einmal!",
        MULTIAUCTION_ITEMS_ADDED = "Ich habe %s Gegenstände zur Auktion hinzugefügt, insgesamt %s",
        MULTIAUCTION_FINISHED = "Mehrfachauktion beendet. Der Pott enthält jetzt %s",

        --[[ SOFTRES ]]
        SOFTRES_MY_RESERVES_REPLY = "Du hast %s reserviert", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
        SOFTRES_MY_RESERVED_ITEM_REPLY = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        SOFTRES_NO_RESERVES_REPLY = "Es scheint, als hättest du noch nichts reserviert. Sieh dir die Soft-Reserve Website an oder frage deinen Plündermeister",
        SOFTRES_HARDRESERVED_NOTICE = "%s (Dieser Gegenstand ist hard-reserved!)",
        SOFTRES_DETAILS = "Reserviert von: %s",
        SOFTRES_MISSING_RESERVES = "Fehlende Soft-Reserves von: %s",
        SOFTRES_DATA_IMPORTED = "Ich habe gerade die Soft-Reserves in Gargul importiert. Flüstere !sr, um deine reservierten Gegenstände noch einmal zu überprüfen!",

        --[[ THATSMYBIS ]]
        TMB_WISHLIST_DETAILS = "TMB-Wunschliste: %s",
        TMB_PRIORITY_DETAILS = "%s Priorität: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        PACKMULE_DISENCHANTER_SET = "%s wurde als Entzauberer ausgewählt",
        PACKMULE_DISENCHANTMENT_NOTICE = "%s wird von %s entzaubert",

        --[[ ROLLING ]]
        ROLLING_START = "Du hast %s Sekunden um auf %s zu würfeln",
        ROLLING_STOP = "Stopp deine Würfe!",
        ROLLING_TIME_LEFT = "Noch %s Sekunden übrig",
        ROLLING_SOFTRES_INFO = "Dieser Gegenstand wurde reserviert von: %s",
        ROLLING_TMB_INFO = "Die folgenden Spieler haben die höchste %s-Prio: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        TRADE_TO = "%s an %s",
        TRADE_TO_PART = "an %s",
        TRADE_GAVE = "Ich habe %s gegeben",
        TRADE_GAVE_GOLD = "Ich habe %s an %s gegeben",
        TRADE_GAVE_MULTIPLE_OF_ITEM = "Ich habe %sx%s gegeben", -- I gave [item]x3
        TRADE_GAVE_ENCHANTMENT = "Ich habe %s mit %s für %s verzaubert",
        TRADE_GAVE_ENCHANTMENT_AND_GOLD = "Ich habe %s mit %s für %s verzaubert und %s gegeben",
        TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "Ich habe %s mit %s für %s verzaubert und %s erhalten",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "an %s und verzauberte %s mit %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "%s an %s und %s mit %s verzaubert",
        TRADE_GOT_ENCHANTMENT = "%s hat meinen %s mit %s verzaubert",
        TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s hat mein %s mit %s verzaubert und mir %s gegeben",
        TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s hat meinen %s mit %s für %s verzaubert",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s hat meine %s mit %s verzaubert und ich habe %s mit %s verzaubert",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s hat meine %s mit %s verzaubert und ich habe ihre %s mit %s verzaubert. Ich habe ihm auch %s gegeben",
        TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s hat mein %s mit %s verzaubert und mir %s gegeben. Ich habe %s mit %s verzaubert",
        TRADE_FROM = "%s von %s",
        TRADE_FROM_PART = "von %s",
        TRADE_RECEIVED = "Ich habe %s erhalten",
        TRADE_RECEIVED_GOLD = "Ich habe %s von %s erhalten",
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "Ich habe %sx%s erhalten", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "von %s und habe meinen %s mit %s verzaubert",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s von %s und habe meinen %s mit %s verzaubert",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Zufälliger Gewinner für %s ausgewählt (%s)", -- First %s is item, second %s is player,
    },

    --[[ zhCN
        These translations where provided by
        - Skywardpixel
        - Takaqiao
    ]]
    zhCN = {
        PASS = "放弃",
        FLIGHT_ATTENDANT = "我正在使用 Gargul 来分发战利品。它使分发变得更容易，所以一定要尝试一下！",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul 未安装：",
        VERSION_CHECK_OUTDATED = "Gargul 已过时：",
        VERSION_CHECK_OFFLINE = "以下玩家离线：",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s 被授予了 %s。恭喜！",
        ITEM_AWARDED_BR = "%s 被授予了 %s %s 积分。恭喜！",
        ITEM_AWARDED_GDKP = "%s 因 %s 而被授予了 %s。恭喜！",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "我把 %s 给了 %s",
        GOLD_TRADE_GIVEN_DELETED = "我删除了一笔金币交易，其中我向 %s 提供了 %s",
        GOLD_TRADE_GIVEN_RESTORED = "我恢复了一笔金币交易，其中我将 %s 给予 %s",
        GOLD_TRADE_RECEIVED = "我收到了来自 %s 的 %s",
        GOLD_TRADE_RECEIVED_DELETED = "我删除了一笔金币交易，其中我从 %s 收到了 %s",
        GOLD_TRADE_RECEIVED_RESTORED = "我恢复了一笔金币交易，其中我从 %s 收到了 %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "我还有以下物品需要交易",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "你的 %s 点数是 /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "玩家 %s 的 %s 掷骰结果为 /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "（默认）",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "您的 +1 总数为 %d",
        PLUSONES_OTHER_BALANCE_REPLY = "玩家 %s 的 +1 总数为 %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "我欠你 %s。享受！",
        GDKP_YOU_OWE_ME = "你欠我 %s。谢谢你！",
        GDKP_POT_UPDATED = "奖池已更新，现在共有 %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "删除拍卖后，奖池已更新，现在共有 %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "恢复拍卖后，奖池已更新，现在共有 %s",
        GDKP_REMOVED_AWARDED = "我删除了为 %s 授予 %s 的 %s",
        GDKP_RESTORED_AWARDED = "我恢复了为 %s 授予 %s 的 %s",
        GDKP_REMOVED_GOLD = "我从奖池中取出%sg",
        GDKP_RESTORED_GOLD = "我将 %sg 添加回奖池中",
        GDKP_POT_HOLDS = "奖池现在有 %s",
        GDKP_CONFIRM_TOP_BID = "%s 是最高出价者 (%s)",
        GDKP_FINAL_CALL = "%s 的最后通知：还剩 %s 秒出价！",
        GDKP_BID_DENIED = "出价被拒绝，最低出价为 %s",
        GDKP_START_BIDDING = "对 %s 出价。底价为 %s，每次加价 %s 起。使用团队聊天！",
        GDKP_STOP_BIDDING = "停止出价！",
        GDKP_SECONDS_TO_BID = "在 %s 秒内出价",
        GDKP_POT_TOTAL = "总奖池：%s",
        GDKP_BASE_CUT = "基础分成：%s",

        --[[ MULTIAUCTION ]]
        MULTIAUCTION_STARTED = "多重拍卖已经开始。看不到吗？请务必下载/更新 Gargul！",
        MULTIAUCTION_RESUMED = "我恢复了之前的出价，请仔细检查您的出价！",
        MULTIAUCTION_ITEMS_ADDED = "我将 %s 件物品添加到拍卖中，总共 %s 件",
        MULTIAUCTION_FINISHED = "多重拍卖已结束。奖池现在有 %s",

        --[[ SOFTRES ]]
        SOFTRES_MY_RESERVES_REPLY = "您已预订 %s", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
        SOFTRES_MY_RESERVED_ITEM_REPLY = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        SOFTRES_NO_RESERVES_REPLY = "您似乎还没有软保留任何东西，请检查软保留表或询问您的战利品分配者",
        SOFTRES_HARDRESERVED_NOTICE = "%s（该物品是硬保留的！）",
        SOFTRES_DETAILS = "保留者：%s",
        SOFTRES_MISSING_RESERVES = "缺少软保留：%s",
        SOFTRES_DATA_IMPORTED = "我刚刚将软保留导入 Gargul。私聊输入 !sr 仔细检查您的保留！",

        --[[ THATSMYBIS ]]
        TMB_WISHLIST_DETAILS = "TMB 愿望清单：%s",
        TMB_PRIORITY_DETAILS = "%s 优先级：%s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        PACKMULE_DISENCHANTER_SET = "%s 被设置为分解者",
        PACKMULE_DISENCHANTMENT_NOTICE = "%s会被%s分解",

        --[[ ROLLING ]]
        ROLLING_START = "您还有 %s 秒时间 Roll %s",
        ROLLING_STOP = "停止你的 Roll 点！",
        ROLLING_TIME_LEFT = "还剩 %s 秒结束 Roll 点",
        ROLLING_SOFTRES_INFO = "该项目已被保留：%s",
        ROLLING_TMB_INFO = "以下玩家的 %s 优先级最高：%s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        TRADE_TO = "%s 给 %s",
        TRADE_TO_PART = "给 %s",
        TRADE_GAVE = "我给了 %s",
        TRADE_GAVE_GOLD = "我将 %s 给了 %s",
        TRADE_GAVE_MULTIPLE_OF_ITEM = "我给了 %sx%s", -- I gave [item]x3
        TRADE_GAVE_ENCHANTMENT = "我给 %s 的 %s 附魔了",
        TRADE_GAVE_ENCHANTMENT_AND_GOLD = "我为 %s 用 %s 对 %s 附魔，并给了 %s",
        TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "我为 %s 用 %s 对 %s 附魔，并收到了 %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "给 %s 附魔了 %s，用的是他的 %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "%s 给 %s 附魔了 %s，用的是他的 %s",
        TRADE_GOT_ENCHANTMENT = "%s 附魔了我的 %s （用了 %s）",
        TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s 附魔了 %s 用的是 %s 并给了我 %s",
        TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s 附魔了 %s 用的是 %s 并给了 %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s 用 %s 附魔了我的 %s ，我用 %s 附魔了他的 %s ",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s 用 %s 附魔了我的 %s，而且我附魔了他的 %s（用了 %s），我还给了他 %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s 附魔了我的 %s（用了 %s）并且给了我 %s， 我附魔了他的 %s （用了 %s）",
        TRADE_FROM = "%s 来自 %s",
        TRADE_FROM_PART = "来自 %s",
        TRADE_RECEIVED = "我收到 %s",
        TRADE_RECEIVED_GOLD = "我收到了来自 %s 的 %s",
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "我收到了 %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "来自 %s 并让我的 %s 附魔了 %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = " %s 来自 %s 并让我的 %s 附魔了 %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "已选择 %s 的随机获胜者 (%s)", -- First %s is item, second %s is player,
    },

    --[[ esES ]]
    esES = {
        PASS = "Aprobar",
        FLIGHT_ATTENDANT = "Estoy usando Gargul para distribuir el botín. Hace que rodar sea más fácil, así que ¡asegúrate de probarlo!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gárgul falta por:",
        VERSION_CHECK_OUTDATED = "Gargul desactualizado para:",
        VERSION_CHECK_OFFLINE = "Los siguientes jugadores estaban desconectados:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s fue otorgado a %s. ¡Felicitaciones!",
        ITEM_AWARDED_BR = "%s fue otorgado a %s por %s puntos. ¡Felicitaciones!",
        ITEM_AWARDED_GDKP = "%s fue otorgado a %s por %s. ¡Felicitaciones!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "Le di %s a %s",
        GOLD_TRADE_GIVEN_DELETED = "Eliminé una operación de oro en la que le di %s a %s",
        GOLD_TRADE_GIVEN_RESTORED = "Restablecí un intercambio de oro en el que le di %s a %s",
        GOLD_TRADE_RECEIVED = "Recibí %s de %s",
        GOLD_TRADE_RECEIVED_DELETED = "Eliminé una operación de oro en la que recibí %s de %s",
        GOLD_TRADE_RECEIVED_RESTORED = "Restablecí un comercio de oro en el que recibí %s de %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "Me quedan los siguientes artículos para intercambiar",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Tu tirada de %s es /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "La tirada %s del jugador %s es /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "(por defecto)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Tu +1 total es %d",
        PLUSONES_OTHER_BALANCE_REPLY = "El total +1 del jugador %s es %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "Te debo %s. ¡Disfrutar!",
        GDKP_YOU_OWE_ME = "Me debes %s. ¡Gracias!",
        GDKP_POT_UPDATED = "El bote fue actualizado, ahora contiene %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "El bote se actualizó después de eliminar una subasta, ahora tiene %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "El bote se actualizó después de restaurar una subasta, ahora tiene %s",
        GDKP_REMOVED_AWARDED = "Eliminé %s otorgados a %s por %s",
        GDKP_RESTORED_AWARDED = "Restauré %s otorgados a %s por %s",
        GDKP_REMOVED_GOLD = "Saqué %sg del bote",
        GDKP_RESTORED_GOLD = "Agregué %sg nuevamente al bote",
        GDKP_POT_HOLDS = "El bote ahora tiene %s",
        GDKP_CONFIRM_TOP_BID = "%s es el mejor postor (%s)",
        GDKP_FINAL_CALL = "Llamada final en %s: ¡Quedan %s segundos para ofertar!",
        GDKP_BID_DENIED = "Oferta denegada, la oferta mínima es %s",
        GDKP_START_BIDDING = "Oferta por %s. El mínimo es %s, el incremento es %s. ¡Usa el chat de incursión!",
        GDKP_STOP_BIDDING = "¡Detén tus ofertas!",
        GDKP_SECONDS_TO_BID = "%s segundos para pujar",
        GDKP_POT_TOTAL = "Bote total: %s",
        GDKP_BASE_CUT = "Corte base: %s",

        --[[ MULTIAUCTION ]]
        MULTIAUCTION_STARTED = "Comencé una sesión de licitación. ¿No puedes verlo? ¡Asegúrate de descargar/actualizar Gargul!",
        MULTIAUCTION_RESUMED = "Reanudé una sesión de ofertas anterior, ¡verifique sus ofertas!",
        MULTIAUCTION_ITEMS_ADDED = "Agregué %s artículos a la subasta por un total de %s",
        MULTIAUCTION_FINISHED = "Subasta múltiple finalizada. El bote ahora tiene %s",

        --[[ SOFTRES ]]
        SOFTRES_MY_RESERVES_REPLY = "Reservaste %s", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
        SOFTRES_MY_RESERVED_ITEM_REPLY = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        SOFTRES_NO_RESERVES_REPLY = "Parece que aún no has reservado nada, consulta la hoja de resolución suave o pregúntale a tu maestro del botín.",
        SOFTRES_HARDRESERVED_NOTICE = "%s (¡Este artículo está reservado!)",
        SOFTRES_DETAILS = "Reservado por: %s",
        SOFTRES_MISSING_RESERVES = "Faltan reservas flexibles de: %s",
        SOFTRES_DATA_IMPORTED = "Acabo de importar reservas blandas a Gargul. ¡Susurra !sr para volver a verificar tus reservas!",

        --[[ THATSMYBIS ]]
        TMB_WISHLIST_DETAILS = "Lista de deseos de TMB: %s",
        TMB_PRIORITY_DETAILS = "%s Prioridad: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        PACKMULE_DISENCHANTER_SET = "%s fue establecido como desencantador",
        PACKMULE_DISENCHANTMENT_NOTICE = "%s quedará desencantado por %s",

        --[[ ROLLING ]]
        ROLLING_START = "Tienes %s segundos para seguir %s",
        ROLLING_STOP = "¡Detén tus rollos!",
        ROLLING_TIME_LEFT = "%s segundos para rodar",
        ROLLING_SOFTRES_INFO = "Este artículo fue reservado por: %s",
        ROLLING_TMB_INFO = "Los siguientes jugadores tienen el %s prio más alto: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        TRADE_TO = "%s a %s",
        TRADE_TO_PART = "a %s",
        TRADE_GAVE = "Le di %s",
        TRADE_GAVE_GOLD = "Le di %s a %s",
        TRADE_GAVE_MULTIPLE_OF_ITEM = "Le di %sx%s", -- I gave [item]x3
        TRADE_GAVE_ENCHANTMENT = "He encantado a %s con %s para %s",
        TRADE_GAVE_ENCHANTMENT_AND_GOLD = "Encanté a %s con %s para %s y le di a %s",
        TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "Encanté a %s con %s para %s y recibí %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "a %s y encantó a sus %s con %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "%s a %s y encantaron a sus %s con %s",
        TRADE_GOT_ENCHANTMENT = "%s encantó a mi %s con %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s encantó a mi %s con %s y me regaló %s",
        TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s encantó a mi %s con %s para %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s encantó a mi %s con %s y yo encantaba a sus %s con %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s encantó a mi %s con %s y yo encantaba a sus %s con %s. Yo también le di %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s encantó a mi %s con %s y me regaló %s. Encanté a sus %s con %s",
        TRADE_FROM = "%s de %s",
        TRADE_FROM_PART = "de %s",
        TRADE_RECEIVED = "Recibí %s",
        TRADE_RECEIVED_GOLD = "Recibí %s de %s",
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "Recibí %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "de %s y tengo a mi %s encantado con %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s de %s y tengo a mi %s encantado con %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Ganador aleatorio para %s seleccionados (%s)", -- First %s is item, second %s is player,
    },

    --[[ frFR
        These translations where provided by
        - Bhahlou
    ]]
    frFR = {
        PASS = "Passer",
        FLIGHT_ATTENDANT = "J'utilise Gargul pour distribuer le butin. Cela rend les lancers de dés plus faciles, donc essayez-le !",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul manquant pour :",
        VERSION_CHECK_OUTDATED = "Gargul obsolète pour :",
        VERSION_CHECK_OFFLINE = "Les joueurs suivants étaient hors-ligne :",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s a été attribué à %s. Bravo !",
        ITEM_AWARDED_BR = "%s a été attribué à %s pour %s points. Bravo !",
        ITEM_AWARDED_GDKP = "%s a été attribué à %s pour %s. Bravo !",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "J'ai donné %s à %s",
        GOLD_TRADE_GIVEN_DELETED = "J'ai supprimé un échange d'or dans lequel j'avais donné %s à %s",
        GOLD_TRADE_GIVEN_RESTORED = "J'ai restauré un échange d'or dans lequel j'avais donné %s à %s",
        GOLD_TRADE_RECEIVED = "J'ai reçu %s de %s",
        GOLD_TRADE_RECEIVED_DELETED = "J'ai supprimé un échange d'or dans lequel j'avais reçu %s de %s",
        GOLD_TRADE_RECEIVED_RESTORED = "J'ai restauré un échange d'or dans lequel j'avais reçu %s de %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "Il me reste les objets suivants à échanger",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Votre lancer %s est /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Le lancer %s du joueur %s est /rnd %d-%d%s", --TODO:PLACEHOLDER POSITION CHANGE (2<->1)
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "(par défaut)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Votre total de +1 est %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Le total de +1 du joueur %s est %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "Je vous dois %s. Profitez-en !",
        GDKP_YOU_OWE_ME = "Vous me devez %s. Merci !",
        GDKP_POT_UPDATED = "Le pot a été mis à jour, il contient maintenant %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Le pot a  été mis à jour après la suppression d'une enchère, il contient maintenant %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Le pot a été mis à jour après la restauration d'une enchère, il contient maintenant %s",
        GDKP_REMOVED_AWARDED = "J'ai supprimé l'attribution de %s à %s pour %s",
        GDKP_RESTORED_AWARDED = "J'ai restauré l'attribution de %s à %s pour %s",
        GDKP_REMOVED_GOLD = "J'ai supprimé %spo du pot",
        GDKP_RESTORED_GOLD = "J'ai rajouté %spo au pot",
        GDKP_POT_HOLDS = "Le pot contient maintenant %s",
        GDKP_CONFIRM_TOP_BID = "%s est le plus gros enchérisseur (%s)",
        GDKP_FINAL_CALL = "Dernier appel sur %s: %s secondes restantes pour enchérir !",
        GDKP_BID_DENIED = "Enchère refusée, l'enchère minimum est de %s",
        GDKP_START_BIDDING = "Enchère sur %s. Le minimum est de %s, l'incrément est de %s. Utilisez la discussion de raid !",
        GDKP_STOP_BIDDING = "Arrêtez vos enchères !",
        GDKP_SECONDS_TO_BID = "%s restantes pour enchérir",
        GDKP_POT_TOTAL = "Pot total : %s",
        GDKP_BASE_CUT = "Coupe de base : %s",

        --[[ MULTIAUCTION ]]
        MULTIAUCTION_STARTED = "J'ai démarré une session d'enchères. Vous ne la voyez pas ? Assurez-vous de télécharger/mettre à jour Gargul !",
        MULTIAUCTION_RESUMED = "J'ai redémarré une session d'enchères précédente, revérifiez vos enchères !",
        MULTIAUCTION_ITEMS_ADDED = "J'ai ajouté %s objet(s) à l'enchère pour un total de %s",
        MULTIAUCTION_FINISHED = "Multi-enchère terminée. Le pot contient maintenant %s",

        --[[ SOFTRES ]]
        SOFTRES_MY_RESERVES_REPLY = "Vous avez réservé %s", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
        SOFTRES_MY_RESERVED_ITEM_REPLY = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        SOFTRES_NO_RESERVES_REPLY = "Il semble que vous n'ayez pas encore fait de soft-reserve, vérifiez la feuille de soft-res ou demandez à votre maître du butin",
        SOFTRES_HARDRESERVED_NOTICE = "%s (Cet objet est hard-reserved !)",
        SOFTRES_DETAILS = "Reservé par : %s",
        SOFTRES_MISSING_RESERVES = "Soft-reserves manquants pour : %s",
        SOFTRES_DATA_IMPORTED = "Je viens d'importer les soft-reserves dans Gargul. Chuchotez !sr pour revérifier vos réservations !",

        --[[ THATSMYBIS ]]
        TMB_WISHLIST_DETAILS = "List de souhaits TMB : %s",
        TMB_PRIORITY_DETAILS = "Priorité %s : %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        PACKMULE_DISENCHANTER_SET = "%s a été défini comme désenchanteur",
        PACKMULE_DISENCHANTMENT_NOTICE = "%s sera désenchanté par %s",

        --[[ ROLLING ]]
        ROLLING_START = "Vous avez %s secondes pour lancer les dés sur %s",
        ROLLING_STOP = "Arrêtez vos lancers !",
        ROLLING_TIME_LEFT = "%s secondes pour lancer les dés",
        ROLLING_SOFTRES_INFO = "Cet objet a été reservé par : %s",
        ROLLING_TMB_INFO = "Les joueurs suivants ont la plus haute prio %s : %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        TRADE_TO = "%s à %s",
        TRADE_TO_PART = "à %s",
        TRADE_GAVE = "J'ai donné %s",
        TRADE_GAVE_GOLD = "J'ai donné %s à %s",
        TRADE_GAVE_MULTIPLE_OF_ITEM = "J'ai donné %sx%s", -- I gave [item]x3
        TRADE_GAVE_ENCHANTMENT = "J'ai enchanté %s avec %s pour %s",
        TRADE_GAVE_ENCHANTMENT_AND_GOLD = "J'ai enchanté %s avec %s pour %s et j'ai donné %s",
        TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "J'ai enchanté %s avec %s pour %s et j'ai reçu %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "à %s et enchanté son %s avec %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "%s à %s et enchanté son %s avec %s",
        TRADE_GOT_ENCHANTMENT = "%s a enchanté mon %s avec %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s a enchanté %s avec %s et m'a donné %s",
        TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s a enchanté %s avec %s pour %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s a enchanté %s avec %s et j'ai enchanté son %s avec %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s a enchanté %s avec %s et j'ai enchanté son %s avec %s. Je lui ai aussi donné %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s a enchanté %s avec %s et m'a donné %s. J'ai enchanté son %s avec %s",
        TRADE_FROM = "%s de %s",
        TRADE_FROM_PART = "de %s",
        TRADE_RECEIVED = "J'ai reçu %s",
        TRADE_RECEIVED_GOLD = "J'ai reçu %s de %s",
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "J'ai reçu %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "de %s et ai eu mon %s enchanté avec %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s de %s et ai eu mon %s enchanté avec %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Gagant aléatoire pour %s sélectionné (%s)", -- First %s is item, second %s is player,
    },

    --[[ itIT ]]
    itIT = {
        PASS = "Passaggio",
        FLIGHT_ATTENDANT = "Sto usando Gargul per distribuire il bottino. Rende più facile arrotolare, quindi assicurati di provarlo!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul scomparso per:",
        VERSION_CHECK_OUTDATED = "Gargul obsoleto per:",
        VERSION_CHECK_OFFLINE = "I seguenti giocatori erano offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s è stato assegnato a %s. Congratulazioni!",
        ITEM_AWARDED_BR = "%s è stato assegnato a %s per %s punti. Congratulazioni!",
        ITEM_AWARDED_GDKP = "%s è stato assegnato a %s per %s. Congratulazioni!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "Ho dato %s a %s",
        GOLD_TRADE_GIVEN_DELETED = "Ho cancellato uno scambio di oro in cui avevo dato %s a %s",
        GOLD_TRADE_GIVEN_RESTORED = "Ho ripristinato uno scambio di oro in cui avevo dato %s a %s",
        GOLD_TRADE_RECEIVED = "Ho ricevuto %s da %s",
        GOLD_TRADE_RECEIVED_DELETED = "Ho eliminato uno scambio di oro in cui ho ricevuto %s da %s",
        GOLD_TRADE_RECEIVED_RESTORED = "Ho ripristinato uno scambio di oro in cui ho ricevuto %s da %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "Mi restano i seguenti oggetti da scambiare",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Il tuo tiro di %s è /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Il tiro %s del giocatore %s è /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "(predefinito)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Il tuo totale +1 è %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Il totale +1 del giocatore %s è %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "Ti devo %s. Godere!",
        GDKP_YOU_OWE_ME = "Mi devi %s. Grazie!",
        GDKP_POT_UPDATED = "Il piatto è stato aggiornato, ora contiene %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Il piatto è stato aggiornato dopo aver eliminato un'asta, ora contiene %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Il piatto è stato aggiornato dopo aver ripristinato un'asta, ora contiene %s",
        GDKP_REMOVED_AWARDED = "Ho rimosso %s assegnato a %s per %s",
        GDKP_RESTORED_AWARDED = "Ho ripristinato %s assegnato a %s per %s",
        GDKP_REMOVED_GOLD = "Ho rimosso %sg dal piatto",
        GDKP_RESTORED_GOLD = "Ho aggiunto %sg al piatto",
        GDKP_POT_HOLDS = "Il piatto ora contiene %s",
        GDKP_CONFIRM_TOP_BID = "%s è il miglior offerente (%s)",
        GDKP_FINAL_CALL = "Chiamata finale su %s: %s secondi rimasti per fare un'offerta!",
        GDKP_BID_DENIED = "Offerta negata, l'offerta minima è %s",
        GDKP_START_BIDDING = "Fai un'offerta su %s. Il minimo è %s, l'incremento è %s. Usa la chat raid!",
        GDKP_STOP_BIDDING = "Ferma le tue offerte!",
        GDKP_SECONDS_TO_BID = "%s secondi per fare un'offerta",
        GDKP_POT_TOTAL = "Piatto totale: %s",
        GDKP_BASE_CUT = "Taglio base: %s",

        --[[ MULTIAUCTION ]]
        MULTIAUCTION_STARTED = "Ho avviato una sessione di offerte. Non riesci a vederlo? Assicurati di scaricare/aggiornare Gargul!",
        MULTIAUCTION_RESUMED = "Ho ripreso una sessione di offerte precedente, ricontrolla le tue offerte!",
        MULTIAUCTION_ITEMS_ADDED = "Ho aggiunto %s articoli all'asta per un totale di %s",
        MULTIAUCTION_FINISHED = "Multiasta terminata. Il piatto ora contiene %s",

        --[[ SOFTRES ]]
        SOFTRES_MY_RESERVES_REPLY = "Hai prenotato %s", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
        SOFTRES_MY_RESERVED_ITEM_REPLY = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        SOFTRES_NO_RESERVES_REPLY = "Sembra che tu non abbia ancora effettuato la prenotazione soft, controlla il foglio soft-res o chiedi al tuo loot master",
        SOFTRES_HARDRESERVED_NOTICE = "%s (Questo articolo è prenotato in modo definitivo!)",
        SOFTRES_DETAILS = "Riservato da: %s",
        SOFTRES_MISSING_RESERVES = "Riserve software mancanti da: %s",
        SOFTRES_DATA_IMPORTED = "Ho appena importato le riserve software in Gargul. Sussurra!sr per ricontrollare le tue riserve!",

        --[[ THATSMYBIS ]]
        TMB_WISHLIST_DETAILS = "Lista dei desideri TMB: %s",
        TMB_PRIORITY_DETAILS = "Priorità %s: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        PACKMULE_DISENCHANTER_SET = "%s è stato impostato come disincantatore",
        PACKMULE_DISENCHANTMENT_NOTICE = "%s verrà disincantato da %s",

        --[[ ROLLING ]]
        ROLLING_START = "Hai %s secondi per avanzare su %s",
        ROLLING_STOP = "Ferma i tuoi rotoli!",
        ROLLING_TIME_LEFT = "%s secondi per tirare",
        ROLLING_SOFTRES_INFO = "Questo elemento è stato prenotato da: %s",
        ROLLING_TMB_INFO = "I seguenti giocatori hanno il vantaggio di %s più alto: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        TRADE_TO = "Da %s a %s",
        TRADE_TO_PART = "a %s",
        TRADE_GAVE = "Ho dato %s",
        TRADE_GAVE_GOLD = "Ho dato %s a %s",
        TRADE_GAVE_MULTIPLE_OF_ITEM = "Ho dato %sx%s", -- I gave [item]x3
        TRADE_GAVE_ENCHANTMENT = "Ho incantato %s con %s per %s",
        TRADE_GAVE_ENCHANTMENT_AND_GOLD = "Ho incantato %s con %s per %s e ho dato %s",
        TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "Ho incantato %s con %s per %s e ho ricevuto %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "a %s e hanno incantato i loro %s con %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "da %s a %se hanno incantato i loro %s con %s",
        TRADE_GOT_ENCHANTMENT = "%s ha incantato il mio %s con %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s ha incantato il mio %s con %s e mi ha dato %s",
        TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s ha incantato il mio %s con %s per %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s ha incantato i miei %s con %s e io ho incantato i loro %s con %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s ha incantato i miei %s con %s e io ho incantato i loro %s con %s. Gli ho anche dato %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s ha incantato il mio %s con %s e mi ha dato %s. Ho incantato i loro %s con %s",
        TRADE_FROM = "%s da %s",
        TRADE_FROM_PART = "da %s",
        TRADE_RECEIVED = "Ho ricevuto %s",
        TRADE_RECEIVED_GOLD = "Ho ricevuto %s da %s",
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "Ho ricevuto %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "da %s e ho incantato il mio %s con %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s da %s e ho fatto incantare il mio %s con %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Vincitore casuale per %s selezionato (%s)", -- First %s is item, second %s is player,
    },

    --[[ koKR ]]
    koKR = {
        PASS = "통과하다",
        FLIGHT_ATTENDANT = "전리품을 배포하기 위해 Gargul을 사용하고 있습니다. 롤링이 더 쉬워지므로 꼭 시도해 보세요!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul이 누락된 이유:",
        VERSION_CHECK_OUTDATED = "Gargul은 다음과 같은 이유로 구식입니다.",
        VERSION_CHECK_OFFLINE = "다음 플레이어는 오프라인 상태였습니다:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s이(가) %s에게 수여되었습니다. 축하해요!",
        ITEM_AWARDED_BR = "%s은(는) %s 포인트로 %s에게 수여되었습니다. 축하해요!",
        ITEM_AWARDED_GDKP = "%s는 %s에 대해 %s에게 수여되었습니다. 축하해요!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "%s을(를) %s에게 주었습니다.",
        GOLD_TRADE_GIVEN_DELETED = "%s을(를) %s에게 준 금 거래를 삭제했습니다.",
        GOLD_TRADE_GIVEN_RESTORED = "%s을(를) %s에게 준 금 거래를 복원했습니다.",
        GOLD_TRADE_RECEIVED = "%s로부터 %s을(를) 받았습니다",
        GOLD_TRADE_RECEIVED_DELETED = "%s로부터 %s을(를) 받은 금 거래를 삭제했습니다.",
        GOLD_TRADE_RECEIVED_RESTORED = "%s로부터 %s을(를) 받은 금 거래를 복원했습니다.",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "다음과 같은 거래 품목이 남았습니다",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "귀하의 %s 롤은 /rnd %d-%d%s입니다.",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "플레이어 %s의 %s 판정은 /rnd %d-%d%s입니다.",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "(기본)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "귀하의 +1 총계는 %d입니다.",
        PLUSONES_OTHER_BALANCE_REPLY = "플레이어 %s의 +1 총합은 %d입니다.",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "당신에게 빚진 게 있어요 %s. 즐기다!",
        GDKP_YOU_OWE_ME = "나한테 빚진 게 있어 %s. 감사합니다!",
        GDKP_POT_UPDATED = "냄비가 업데이트되어 이제 %s을(를) 보유하고 있습니다.",
        GDKP_POT_UPDATED_AFTER_DELETE = "경매를 삭제한 후 냄비가 업데이트되어 현재 %s을(를) 보유하고 있습니다.",
        GDKP_POT_UPDATED_AFTER_RESTORE = "경매를 복원한 후 냄비가 업데이트되어 이제 %s을(를) 보유하고 있습니다.",
        GDKP_REMOVED_AWARDED = "%s에 대해 %s에게 부여된 %s을(를) 제거했습니다.",
        GDKP_RESTORED_AWARDED = "%s에 대해 %s에게 부여된 %s을(를) 복원했습니다.",
        GDKP_REMOVED_GOLD = "냄비에서 %sg을(를) 제거했습니다",
        GDKP_RESTORED_GOLD = "냄비에 %sg을(를) 다시 추가했습니다",
        GDKP_POT_HOLDS = "이제 냄비에 %s이 들어있습니다.",
        GDKP_CONFIRM_TOP_BID = "%s은(는) 최고 입찰자(%s)입니다.",
        GDKP_FINAL_CALL = "%s에 대한 최종 결정: 입찰까지 %s초 남았습니다!",
        GDKP_BID_DENIED = "입찰이 거부되었습니다. 최소 입찰가는 %s입니다.",
        GDKP_START_BIDDING = "%s에 입찰하세요. 최소값은 %s, 증가량은 %s입니다. 레이드채팅을 이용해보세요!",
        GDKP_STOP_BIDDING = "입찰을 중단하세요!",
        GDKP_SECONDS_TO_BID = "입찰에 걸리는 시간은 %s초입니다.",
        GDKP_POT_TOTAL = "총 팟: %s",
        GDKP_BASE_CUT = "기본 컷: %s",

        --[[ MULTIAUCTION ]]
        MULTIAUCTION_STARTED = "입찰 세션을 시작했습니다. 볼 수 없나요? Gargul을 다운로드/업데이트하세요!",
        MULTIAUCTION_RESUMED = "이전 입찰 세션을 재개했습니다. 입찰을 다시 확인하세요!",
        MULTIAUCTION_ITEMS_ADDED = "총 %s 가격으로 %s개 항목을 경매에 추가했습니다.",
        MULTIAUCTION_FINISHED = "다중경매가 완료되었습니다. 이제 냄비에 %s이 들어있습니다.",

        --[[ SOFTRES ]]
        SOFTRES_MY_RESERVES_REPLY = "%s을(를) 예약했습니다", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
        SOFTRES_MY_RESERVED_ITEM_REPLY = "%s(%sx)", -- First %s = item, second %s is times reserved if higher than 1
        SOFTRES_NO_RESERVES_REPLY = "아직 소프트 리저브를 하지 않은 것 같습니다. 소프트 레스 시트를 확인하거나 전리품 마스터에게 문의하세요.",
        SOFTRES_HARDRESERVED_NOTICE = "%s (이 항목은 예약되어 있습니다!)",
        SOFTRES_DETAILS = "예약자: %s",
        SOFTRES_MISSING_RESERVES = "다음에서 소프트 예약 누락: %s",
        SOFTRES_DATA_IMPORTED = "방금 Gargul로 소프트 리저브를 가져왔습니다. !sr을 통해 보유액을 다시 확인해보세요!",

        --[[ THATSMYBIS ]]
        TMB_WISHLIST_DETAILS = "TMB 위시리스트: %s",
        TMB_PRIORITY_DETAILS = "%s 우선순위: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        PACKMULE_DISENCHANTER_SET = "%s이(가) 마법 해제자로 설정되었습니다",
        PACKMULE_DISENCHANTMENT_NOTICE = "%s은(는) %s에 의해 마력을 잃습니다.",

        --[[ ROLLING ]]
        ROLLING_START = "%s를 굴릴 시간은 %s초 남았습니다.",
        ROLLING_STOP = "롤을 멈춰라!",
        ROLLING_TIME_LEFT = "굴릴 시간은 %s초",
        ROLLING_SOFTRES_INFO = "이 항목을 예약한 사람: %s",
        ROLLING_TMB_INFO = "다음 플레이어의 %s 우선 순위가 가장 높습니다: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        TRADE_TO = "%s ~ %s",
        TRADE_TO_PART = "%s에게",
        TRADE_GAVE = "%s을(를) 줬습니다",
        TRADE_GAVE_GOLD = "%s을(를) %s에게 주었습니다.",
        TRADE_GAVE_MULTIPLE_OF_ITEM = "%sx%s을(를) 줬습니다", -- I gave [item]x3
        TRADE_GAVE_ENCHANTMENT = "%s에 %s을(를) 사용하여 %s에 마법을 부여했습니다.",
        TRADE_GAVE_ENCHANTMENT_AND_GOLD = "%s에 %s로 %s 마법을 부여하고 %s을(를) 주었습니다.",
        TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "%s에 %s을(를) 사용하여 %s에 마법을 부여하고 %s을(를) 받았습니다.",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "%s에게 %s을(를) 부여하여 %s에 마법을 부여했습니다.",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "%s에서 %s로 %s에 %s 마법을 부여했습니다.",
        TRADE_GOT_ENCHANTMENT = "%s가 내 %s에 %s 마법을 부여했습니다.",
        TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s님이 내 %s에 %s 마법을 부여하고 %s을(를) 주셨습니다.",
        TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s가 %s에 대해 %s로 내 %s에 마법을 걸었습니다.",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s님이 내 %s에 %s을(를) 마법을 부여했고 나는 %s을(를) %s로 마법을 부여했습니다.",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s님은 내 %s에 %s을(를) 부여했고 나는 %s을(를) %s로 부여했습니다. 나도 그에게 %s을(를) 줬어요",
        TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s님이 내 %s에 %s 마법을 부여하고 %s을(를) 주셨습니다. %s에 %s 마법을 부여했습니다.",
        TRADE_FROM = "%s(%s에서)",
        TRADE_FROM_PART = "%s에서",
        TRADE_RECEIVED = "%s을(를) 받았습니다",
        TRADE_RECEIVED_GOLD = "%s로부터 %s을(를) 받았습니다",
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "%sx%s을(를) 받았습니다", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "%s에서 내 %s을(를) %s에 매혹시켰습니다.",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s의 %s이(가) %s에 마법을 부여했습니다.",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "%s의 무작위 우승자가 선택되었습니다(%s).", -- First %s is item, second %s is player,
    },

    --[[ ptBR ]]
    ptBR = {
        PASS = "Passar",
        FLIGHT_ATTENDANT = "Estou usando Gargul para distribuir itens. Torna o rolamento mais fácil, então não deixe de experimentá-lo!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul faltando para:",
        VERSION_CHECK_OUTDATED = "Gargul desatualizado para:",
        VERSION_CHECK_OFFLINE = "Os seguintes jogadores estavam offline:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s foi concedido a %s. Parabéns!",
        ITEM_AWARDED_BR = "%s foi concedido a %s por %s pontos. Parabéns!",
        ITEM_AWARDED_GDKP = "%s foi concedido a %s por %s. Parabéns!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "Eu dei %s para %s",
        GOLD_TRADE_GIVEN_DELETED = "Excluí uma negociação de ouro na qual dei %s para %s",
        GOLD_TRADE_GIVEN_RESTORED = "Restaurei uma negociação de ouro na qual dei %s para %s",
        GOLD_TRADE_RECEIVED = "Recebi %s de %s",
        GOLD_TRADE_RECEIVED_DELETED = "Excluí uma negociação de ouro na qual recebi %s de %s",
        GOLD_TRADE_RECEIVED_RESTORED = "Restaurei uma negociação de ouro na qual recebi %s de %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "Ainda tenho os seguintes itens para trocar",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Seu rolo %s é /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "A jogada %s do jogador %s é /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "(padrão)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Seu total de +1 é %d",
        PLUSONES_OTHER_BALANCE_REPLY = "O total de +1 do jogador %s é %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "Eu devo a você %s. Aproveitar!",
        GDKP_YOU_OWE_ME = "Você me deve %s. Obrigado!",
        GDKP_POT_UPDATED = "O pote foi atualizado, agora contém %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "O pote foi atualizado após a exclusão de um leilão, agora contém %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "O pote foi atualizado após restaurar um leilão, agora contém %s",
        GDKP_REMOVED_AWARDED = "Eu removi %s concedidos a %s por %s",
        GDKP_RESTORED_AWARDED = "Eu restaurei %s concedidos a %s por %s",
        GDKP_REMOVED_GOLD = "Eu removi %sg do pote",
        GDKP_RESTORED_GOLD = "Eu adicionei %sg de volta ao pote",
        GDKP_POT_HOLDS = "O pote agora contém %s",
        GDKP_CONFIRM_TOP_BID = "%s é o licitante com lance mais alto (%s)",
        GDKP_FINAL_CALL = "Chamada final em %s: %s segundos restantes para lance!",
        GDKP_BID_DENIED = "Lance negado, o lance mínimo é %s",
        GDKP_START_BIDDING = "Dê um lance em %s. O mínimo é %s, o incremento é %s. Use o bate-papo de invasão!",
        GDKP_STOP_BIDDING = "Pare seus lances!",
        GDKP_SECONDS_TO_BID = "%s segundos para dar lance",
        GDKP_POT_TOTAL = "Pote Total: %s",
        GDKP_BASE_CUT = "Corte base: %s",

        --[[ MULTIAUCTION ]]
        MULTIAUCTION_STARTED = "Iniciei uma sessão de licitação. Não consegue ver? Certifique-se de baixar/atualizar o Gargul!",
        MULTIAUCTION_RESUMED = "Retomei uma sessão de lances anterior. Verifique seus lances!",
        MULTIAUCTION_ITEMS_ADDED = "Adicionei %s itens ao leilão totalizando %s",
        MULTIAUCTION_FINISHED = "Multi-leilão concluído. O pote agora contém %s",

        --[[ SOFTRES ]]
        SOFTRES_MY_RESERVES_REPLY = "Você reservou %s", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
        SOFTRES_MY_RESERVED_ITEM_REPLY = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        SOFTRES_NO_RESERVES_REPLY = "Parece que você ainda não fez reserva temporária de nada, verifique a folha de resolução suave ou pergunte ao seu mestre de saque",
        SOFTRES_HARDRESERVED_NOTICE = "%s (Este item é reservado!)",
        SOFTRES_DETAILS = "Reservado por: %s",
        SOFTRES_MISSING_RESERVES = "Reservas temporárias ausentes de: %s",
        SOFTRES_DATA_IMPORTED = "Acabei de importar reservas temporárias para Gargul. Sussurre !sr para verificar suas reservas!",

        --[[ THATSMYBIS ]]
        TMB_WISHLIST_DETAILS = "Lista de desejos do TMB: %s",
        TMB_PRIORITY_DETAILS = "%s Prioridade: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        PACKMULE_DISENCHANTER_SET = "%s foi definido como desencantador",
        PACKMULE_DISENCHANTMENT_NOTICE = "%s ficará desencantado com %s",

        --[[ ROLLING ]]
        ROLLING_START = "Você tem %s segundos para rolar %s",
        ROLLING_STOP = "Pare com seus rolos!",
        ROLLING_TIME_LEFT = "%s segundos para rolar",
        ROLLING_SOFTRES_INFO = "Este item foi reservado por: %s",
        ROLLING_TMB_INFO = "Os seguintes jogadores têm o maior %s prio: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        TRADE_TO = "%s para %s",
        TRADE_TO_PART = "para %s",
        TRADE_GAVE = "Eu dei %s",
        TRADE_GAVE_GOLD = "Eu dei %s para %s",
        TRADE_GAVE_MULTIPLE_OF_ITEM = "Eu dei %sx%s", -- I gave [item]x3
        TRADE_GAVE_ENCHANTMENT = "Encantei %s com %s para %s",
        TRADE_GAVE_ENCHANTMENT_AND_GOLD = "Encantei %s com %s para %s e dei %s",
        TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "Encantei %s com %s para %s e recebi %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "para %s e encantou seu %s com %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "%s para %s e encantou seu %s com %s",
        TRADE_GOT_ENCHANTMENT = "%s encantou meu %s com %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s encantou meu %s com %s e me deu %s",
        TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s encantou meu %s com %s para %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s encantou meu %s com %s e eu encantei o %s dele com %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s encantou meus %s com %s e eu encantei seus %s com %s. Eu também dei a ele %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s encantou meu %s com %s e me deu %s. Eu encantei o %s deles com %s",
        TRADE_FROM = "%s de %s",
        TRADE_FROM_PART = "de %s",
        TRADE_RECEIVED = "Eu recebi %s",
        TRADE_RECEIVED_GOLD = "Recebi %s de %s",
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "Recebi %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "de %s e deixei meu %s encantado com %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s de %s e encantei meu %s com %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Vencedor aleatório para %s selecionados (%s)", -- First %s is item, second %s is player,
    },

    --[[ ruRU
        These translations where provided by
        - KartonArmadon
    ]]
    ruRU = {
        PASS = "Пас",
        FLIGHT_ATTENDANT = "Я использую Gargul! Аддон облегчает раздачу добычи, поэтому обязательно попробуйте!",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "Gargul не найден:",
        VERSION_CHECK_OUTDATED = "Gargul устарел:",
        VERSION_CHECK_OFFLINE = "Следующие игроки были оффлайн:",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s выиграл %s. Поздравляю!",
        ITEM_AWARDED_BR = "%s выиграл %s за %s баллов. Поздравляю!",
        ITEM_AWARDED_GDKP = "%s выиграл %s за %s. Поздравляю!",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "Я отдал %s %s",
        GOLD_TRADE_GIVEN_DELETED = "Я удалил обмен золотом, в котором я отдал %s %s",
        GOLD_TRADE_GIVEN_RESTORED = "Я восстановил обмен золотом, в котором я отдал %s %s",
        GOLD_TRADE_RECEIVED = "Я получил %s от %s",
        GOLD_TRADE_RECEIVED_DELETED = "Я удалил обмен золотом, в котором я получил %s от %s",
        GOLD_TRADE_RECEIVED_RESTORED = "Я восстановил обмен золотом, в котором получил %s от %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "У меня остались следующие предметы для обмена",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "Ваш результат %s: /rnd %d-%d%s.",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "Бросок %s игрока %s: /rnd %d-%d%s.",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "(по умолчанию)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "Ваша сумма +1 составляет %d",
        PLUSONES_OTHER_BALANCE_REPLY = "Сумма +1 игрока %s составляет %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "Я должен тебе %s",
        GDKP_YOU_OWE_ME = "Ты мне должен, %s",
        GDKP_POT_UPDATED = "Банк обновлен. Общая сумма %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "Банк обновлен после удаления аукциона. Общая сумма %s.",
        GDKP_POT_UPDATED_AFTER_RESTORE = "Банк обновлен после восстановления аукциона. Общая сумма %s.",
        GDKP_REMOVED_AWARDED = "Я удалил %s игрока %s за %s",
        GDKP_RESTORED_AWARDED = "Я восстановил %s игрока %s за %s",
        GDKP_REMOVED_GOLD = "Я удалил %sg из банка",
        GDKP_RESTORED_GOLD = "Я восстановил %sg в банке",
        GDKP_POT_HOLDS = "В банке сейчас %s",
        GDKP_CONFIRM_TOP_BID = "Высшая ставка %s (%s)",
        GDKP_FINAL_CALL = "Аукион на %s завершается: осталось %sсек.!",
        GDKP_BID_DENIED = "Ставка отклонена, мин. ставка %s.",
        GDKP_START_BIDDING = "Ставка на %s. Старт %s, шаг %s!",
        GDKP_STOP_BIDDING = "Аукцион завершён!",
        GDKP_SECONDS_TO_BID = "%s сек. осталось",
        GDKP_POT_TOTAL = "Общий банк: %s",
        GDKP_BASE_CUT = "Базовая доля: %s",

        --[[ MULTIAUCTION ]]
        MULTIAUCTION_STARTED = "Я начал мультиаукцион. Если не отображается, то скачайте/обновите Gargul!",
        MULTIAUCTION_RESUMED = "Я возобновил предыдущий мультиаукцион. Проверьте свои ставки!",
        MULTIAUCTION_ITEMS_ADDED = "Я добавил %s товар(ов) на мультиаукцион на %s",
        MULTIAUCTION_FINISHED = "Мультиаукцион завершен. В банке теперь %s",

        --[[ SOFTRES ]]
        SOFTRES_MY_RESERVES_REPLY = "Ваш софтрезерв %s", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
        SOFTRES_MY_RESERVED_ITEM_REPLY = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        SOFTRES_NO_RESERVES_REPLY = "Похоже, вы еще ничего не резервировали, проверьте таблицу софтрезерва или спросите ответственного за добычу.",
        SOFTRES_HARDRESERVED_NOTICE = "%s (Этот предмет в хардрезерве!)",
        SOFTRES_DETAILS = "Софтрезерв: %s",
        SOFTRES_MISSING_RESERVES = "Отсутствуют софтрезервы от: %s",
        SOFTRES_DATA_IMPORTED = "Я только что импортировал софтрезервы в Gargul. Шепните мне !sr, чтобы перепроверить резервы!",

        --[[ THATSMYBIS ]]
        TMB_WISHLIST_DETAILS = "Список ThatsMyBis: %s",
        TMB_PRIORITY_DETAILS = "%s Приоритет: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        PACKMULE_DISENCHANTER_SET = "%s был назначен дизэнчантером",
        PACKMULE_DISENCHANTMENT_NOTICE = "%s будет распылён %s",

        --[[ ROLLING ]]
        ROLLING_START = "У вас есть %sсек., чтобы разроллить %s",
        ROLLING_STOP = "Остановите разролл!",
        ROLLING_TIME_LEFT = "%sсек. осталось",
        ROLLING_SOFTRES_INFO = "Этот товар зарезервировал: %s",
        ROLLING_TMB_INFO = "Следующие игроки имеют самый высокий ролл %s приоритет: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "Не получилось передать предмет - кинь мне обмен за ${item}!",
        TRADE_TO = "от кого: %s кому: %s",
        TRADE_TO_PART = "кому: %s",
        TRADE_GAVE = "Я отдал %s",
        TRADE_GAVE_GOLD = "Я отдал %s %s",
        TRADE_GAVE_MULTIPLE_OF_ITEM = "Я отдал %sx%s", -- I gave [item]x3
        TRADE_GAVE_ENCHANTMENT = "Я зачаровал %s за %s для %s",
        TRADE_GAVE_ENCHANTMENT_AND_GOLD = "Я зачаровал %s за %s для %s и передал %s",
        TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "Я зачаровал %s за %s для %s и получил %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "%s и зачаровал его %s за %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "Передал %s %s и зачаровал его %s за %s",
        TRADE_GOT_ENCHANTMENT = "%s зачаровал мой %s за %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s зачаровал мой %s за %s и передал мне %s",
        TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s зачаровал мой %s за %s и %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s зачаровал мой %s за %s, а я зачаровал его %s за %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s зачаровал мой %s за %s, а я зачаровал его %s за %s и дал ему %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s зачаровал мой %s за %s и дал мне %s. Я зачаровал его %s за %s",
        TRADE_FROM = "%s от %s",
        TRADE_FROM_PART = "от %s",
        TRADE_RECEIVED = "Я получил %s",
        TRADE_RECEIVED_GOLD = "Я получил %s от %s",
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "Я получил %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "от %s и получил мой %s зачарованный за %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "%s от %s и получил мой %s зачарованный за %s",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "Случайный победитель на %s выбран (%s)", -- First %s is item, second %s is player,
    },

    --[[ zhTW ]]
    zhTW = {
        PASS = "經過",
        FLIGHT_ATTENDANT = "我正在使用 Gargul 來分發戰利品。它使滾動變得更容易，所以一定要嘗試！",

        --[[ VERSION CHECK ]]
        VERSION_CHECK_MISSING = "加古爾失蹤原因：",
        VERSION_CHECK_OUTDATED = "Gargul 已過時：",
        VERSION_CHECK_OFFLINE = "以下玩家離線：",

        --[[ ITEM AWARDED ]]
        ITEM_AWARDED = "%s 被授予 %s。恭喜！",
        ITEM_AWARDED_BR = "%s 被授予 %s %s 積分。恭喜！",
        ITEM_AWARDED_GDKP = "%s 因 %s 而被授予 %s。恭喜！",

        --[[ TRADE DETAILS ]]
        GOLD_TRADE_GIVEN = "我把 %s 給了 %s",
        GOLD_TRADE_GIVEN_DELETED = "我刪除了一筆黃金交易，其中我向 %s 提供了 %s",
        GOLD_TRADE_GIVEN_RESTORED = "我恢復了一筆黃金交易，其中我將 %s 給予 %s",
        GOLD_TRADE_RECEIVED = "我收到了來自 %s 的 %s",
        GOLD_TRADE_RECEIVED_DELETED = "我刪除了一筆黃金交易，其中我從 %s 收到了 %s",
        GOLD_TRADE_RECEIVED_RESTORED = "我恢復了一筆黃金交易，其中我從 %s 收到了 %s",

        --[[ TRADE TIME ]]
        TRADETIME_BROADCAST_PREFIX = "我還有以下物品需要交易",

        --[[ BOOSTED ROLLS ]]
        BOOSTED_ROLLS_MY_BALANCE_REPLY = "你的 %s 卷是 /rnd %d-%d%s",
        BOOSTED_ROLLS_OTHER_BALANCE_REPLY = "玩家 %s 的 %s 擲骰結果為 /rnd %d-%d%s",
        BOOSTED_ROLLS_BALANCE_REPLY_DEFAULT_SUFFIX = "(預設)",

        --[[ PLUS ONES ]]
        PLUSONES_PLUS_SIGN = "+",
        PLUSONES_MY_BALANCE_REPLY = "您的 +1 總數為 %d",
        PLUSONES_OTHER_BALANCE_REPLY = "玩家 %s 的 +1 總數為 %d",

        --[[ GDKP ]]
        GDKP_I_OWE_YOU = "我欠你%s。享受！",
        GDKP_YOU_OWE_ME = "你欠我%s。謝謝你！",
        GDKP_POT_UPDATED = "罐子已更新，現在容納 %s",
        GDKP_POT_UPDATED_AFTER_DELETE = "刪除拍賣後，鍋子已更新，現在持有 %s",
        GDKP_POT_UPDATED_AFTER_RESTORE = "恢復拍賣後，底池已更新，現在持有 %s",
        GDKP_REMOVED_AWARDED = "我刪除了為 %s 授予 %s 的 %s",
        GDKP_RESTORED_AWARDED = "我恢復了為 %s 授予 %s 的 %s",
        GDKP_REMOVED_GOLD = "我從鍋中取出%sg",
        GDKP_RESTORED_GOLD = "我將 %sg 添加回鍋中",
        GDKP_POT_HOLDS = "底池現在有 %s",
        GDKP_CONFIRM_TOP_BID = "%s 是最高出價者 (%s)",
        GDKP_FINAL_CALL = "%s 的最終召集：還剩 %s 秒出價！",
        GDKP_BID_DENIED = "出價被拒絕，最低出價為 %s",
        GDKP_START_BIDDING = "對 %s 出價。最小值為 %s，增量為 %s。使用突襲聊天！",
        GDKP_STOP_BIDDING = "停止出價！",
        GDKP_SECONDS_TO_BID = "%s 秒出價",
        GDKP_POT_TOTAL = "總底池：%s",
        GDKP_BASE_CUT = "基礎切割：%s",

        --[[ MULTIAUCTION ]]
        MULTIAUCTION_STARTED = "我開始了投標會議。看不到嗎？請務必下載/更新 Gargul！",
        MULTIAUCTION_RESUMED = "我恢復了之前的競價，請仔細檢查您的出價！",
        MULTIAUCTION_ITEMS_ADDED = "我將 %s 件物品添加到拍賣中，總共 %s 件",
        MULTIAUCTION_FINISHED = "多重拍賣結束。底池現在有 %s",

        --[[ SOFTRES ]]
        SOFTRES_MY_RESERVES_REPLY = "您已預訂 %s", -- %s is a summary of all items or the SOFTRES_MY_RESERVED_ITEM_REPLY format (if more than 1 reserve)
        SOFTRES_MY_RESERVED_ITEM_REPLY = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        SOFTRES_NO_RESERVES_REPLY = "您似乎還沒有軟保留任何東西，請檢查軟資源表或詢問您的戰利品大師",
        SOFTRES_HARDRESERVED_NOTICE = "%s（該商品是硬性保留的！）",
        SOFTRES_DETAILS = "保留者：%s",
        SOFTRES_MISSING_RESERVES = "缺少軟儲備：%s",
        SOFTRES_DATA_IMPORTED = "我剛剛將軟儲備導入 Gargul。輕聲細語 !sr 仔細檢查您的儲備！",

        --[[ THATSMYBIS ]]
        TMB_WISHLIST_DETAILS = "TMB 願望清單：%s",
        TMB_PRIORITY_DETAILS = "%s 優先：%s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        PACKMULE_DISENCHANTER_SET = "%s 被設定為分解者",
        PACKMULE_DISENCHANTMENT_NOTICE = "%s將會因%s而不再抱持幻想",

        --[[ ROLLING ]]
        ROLLING_START = "您還有 %s 秒時間繼續 %s",
        ROLLING_STOP = "停止你的捲！",
        ROLLING_TIME_LEFT = "%s 秒滾動",
        ROLLING_SOFTRES_INFO = "此項目已保留：%s",
        ROLLING_TMB_INFO = "以下玩家的 %s 優先順序最高：%s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        TRADE_START_FAILED = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        TRADE_TO = "%s 至 %s",
        TRADE_TO_PART = "至 %s",
        TRADE_GAVE = "我給了%s",
        TRADE_GAVE_GOLD = "我把 %s 給了 %s",
        TRADE_GAVE_MULTIPLE_OF_ITEM = "我給了 %sx%s", -- I gave [item]x3
        TRADE_GAVE_ENCHANTMENT = "我為 %s 對 %s 施了魔法",
        TRADE_GAVE_ENCHANTMENT_AND_GOLD = "我為 %s 用 %s 對 %s 施了魔法，並給了 %s",
        TRADE_GAVE_ENCHANTMENT_FOR_GOLD = "我為 %s 用 %s 對 %s 施了魔法，並收到了 %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS_PART = "給 %s 並用 %s 迷住了他們的 %s",
        TRADE_GAVE_ENCHANTMENT_AFTER_ITEMS = "%s 給 %s 並用 %s 迷住了他們的 %s",
        TRADE_GOT_ENCHANTMENT = "%s 用 %s 迷惑了我的 %s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD = "%s 用 %s 對我的 %s 施了魔法，並給了我 %s",
        TRADE_GOT_ENCHANTMENT_FOR_GOLD = "%s 用 %s 為我的 %s 施了魔法，讓 %s",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT = "%s 用 %s 對我的 %s 施了魔法，我用 %s 對他們的 %s 施了魔法",
        TRADE_GOT_ENCHANTMENT_AND_GAVE_ENCHANTMENT_AND_GAVE_GOLD = "%s 用 %s 對我的 %s 施了魔法，我用 %s 對他們的 %s 施了魔法。我也給了他%s",
        TRADE_GOT_ENCHANTMENT_AND_GOLD_AND_GAVE_ENCHANTMENT = "%s 用 %s 對我的 %s 施了魔法，並給了我 %s。我用 %s 迷住了他們的 %s",
        TRADE_FROM = "%s 來自 %s",
        TRADE_FROM_PART = "來自 %s",
        TRADE_RECEIVED = "我收到%s",
        TRADE_RECEIVED_GOLD = "我收到了來自 %s 的 %s",
        TRADE_RECEIVED_MULTIPLE_OF_ITEM = "我收到了 %sx%s", -- I gave [item]x3
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS_PART = "來自 %s 並讓我的 %s 著迷於 %s",
        TRADE_RECEIVED_ENCHANTMENT_AFTER_ITEMS = "來自 %s 的 %s 讓我的 %s 為 %s 著迷",

        --[[ AWARD ]]
        AWARD_RANDOM_WINNER = "已選出 %s 的隨機獲勝者 (%s)", -- First %s is item, second %s is player,
    },
};

L.CHAT.esMX = L.CHAT.esES;
