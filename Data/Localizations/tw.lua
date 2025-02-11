--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "zhTW") then return; end
local L = Gargul_L or {};

L.ABOUT = "關於";
L.ALL_SETTINGS = "所有設定";
L.ANNOUNCE = "宣告";
L.ANTISNIPE = "反狙擊";
L.ANTISNIPE_EXPLANATION = [[

Anti Snipe 值為 10 表示任何出價
剩餘時間少於 10 秒會將計時器重設為 10 秒

您可以將此留空或設為 0 以完全停用反狙擊。
不支援小於 5 的反狙擊值

]];
L.ARE_YOU_SURE = "你確定嗎？";
L.ASSIGN_GARGUL_INFO = [[
不要忘記使用 Gargul 代替
如果你想稍後再匯出戰利品


-- 右鍵單擊禁用該視窗 --]];
L.AUCTION = "拍賣";
L.AUCTIONEER = "拍賣";
L.AUCTIONS = "拍賣";
L.AUTO = "汽車";
L.AUTO_AWARD = "汽車獎";
L.AUTO_TRADE_OPTIONS = "汽車貿易";
L.AVAILABLE_PLACEHOLDER_VALUES = "可用值：";
L.AWARD = "獎";
L.AWARDED_TO = "頒獎給";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "BR：%s";
L.AWARDED_TOOLTIP_GDKP_COST = "價格";
L.AWARDED_TOOLTIP_GIVEN = "給出：是的";
L.AWARDED_TOOLTIP_NOT_GIVEN = "給出：沒有";
L.AWARDED_TOOLTIP_SECOND_BID = "第二次出價：%s，%s";
L.AWARDED_YOU_WON = "你贏了";
L.AWARD_CONFIRM = "將 %s 獎勵給 %s？";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "您確定要分解%s嗎？ %s 提升的擲骰點數將會退還！";
L.AWARD_HEADER_IN_GROUP = "組內";
L.AWARD_HISTORY = "得獎歷史";
L.AWARD_NEW_WINNER_CONFIRMATION = "%s 應該去找誰？";
L.AWARD_PLAYER_CUSTOM_NAME = "在此輸入玩家姓名";
L.AWARD_PLAYER_SELECT_NAME = "或選擇以下一項";
L.AWARD_RANDOM_CONFIRM = "您想將 %s 獎勵給隨機玩家嗎？";
L.AWARD_TOOLTIP_ADD_ITEM = "拖放或按住 Shift 鍵點擊右側框中的項目";
L.AWARD_TOOLTIP_BR_INDICATION = "（BR：%s）";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "失望的物品：";
L.AWARD_TOOLTIP_GIVEN = "（給出：是）";
L.AWARD_TOOLTIP_NOT_GIVEN = "（給出：沒有）";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(作業系統)";
L.AWARD_UNDO_BR_REFUND = "%s 提升的擲骰點數將會退還！";
L.AWARD_UNDO_CONFIRM = "您確定要撤銷授予 %s 的 %s 獎勵嗎？%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "袋子檢定失敗：未收到報告";
L.BAGINSPECTOR_FINISHED = "檢驗完畢";
L.BAGINSPECTOR_START = "開始檢查...";
L.BALANCE = "平衡";
L.BASE = "根據";
L.BASE64_DECODE_WARNING = "無法對資料進行 Base64 解碼。確保按原樣複製/貼上它，而不添加任何其他字元或空格！";
L.BID = "出價";
L.BIDS = "出價";
L.BIND_ON_EQUIP_ABBR = "京東方";
L.BONUS_AUTO_INVITE = "1.從raid註冊中自動邀請/排序群組！點擊下面或使用 |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. 獎勵常客或加倍努力的玩家！點擊下面或使用 |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "Gargul 有一些你可能不知道的技巧。來看看吧！";
L.BONUS_PLUSONES = "3. Gargul 包含加一追蹤系統！點擊下面或使用 |c00A79EFF/gl po";
L.BOOSTED_ROLLS = "增強滾動";
L.BOOSTED_ROLLS_ABBR = "BR";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
為目前團隊中的每個人添加多少積分？

|c00BE3333如果您希望每個人都獲得積分，即使是那些沒有增強卷條目的人，請先使用「新增缺少的襲擊者」按鈕！]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "不提供積分值！";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "為突襲添加積分";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "添加缺失的襲擊者";
L.BOOSTED_ROLLS_ALIASES = "別名";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "應用程式別名";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "增加滾動成本：";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "您確定要將增強的擲骰數據廣播給隊伍/團隊中的每個人嗎？";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "沒什麼好播的，先導入 Boosted Rolls 資料！";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "無法處理從 %s 收到的 BoostedRolls 數據";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "正在嘗試處理來自 %s 的傳入 BoostedRolls 數據";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "您確定要清除所有增強滾動資料嗎？";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "刪除%s？";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "您確定要清除現有的增強滾動資料並匯入 %s 廣播的新資料嗎？";
L.BOOSTED_ROLLS_IMPORT_ERROR = "提供的數據無效。確保內容遵循所需的格式並且不包含標題行";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
在這裡，您可以從 CSV 或 TSV 格式的表格或從 Google 文件表貼上的表格匯入增強捲動資料和別名。

表格至少需要兩列：玩家姓名，後面跟著分數。附加列是可選的，並且可能包含玩家的別名。
這是一個範例行：

Foobar,240,Barfoo]];
L.BOOSTED_ROLLS_POINTS = "積分";
L.BOOSTED_ROLLS_RESERVE = "預訂";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
您確定要使用 %s 的數據更新現有的強化骰子嗎？

您的最新更新是在 |c00A79EFF%s 上，他們的最新更新是在 |c00A79EFF%s 上。]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!獎金|!rb|!br";
L.BROADCAST = "pod送";
L.BROADCASTING_NOTIFICATION = "廣播...";
L.BROADCAST_DELAYED_BY_COMBAT = "您目前正處於戰鬥狀態，延遲播出";
L.BROADCAST_FINISHED = "播出完畢！";
L.BROADCAST_INC_AWARDED = "包括獲獎項目";
L.BROADCAST_INC_DISENCHANTED = "包括不再抱持幻想的物品";
L.BROADCAST_INC_HIDDEN = "包括隱藏項目";
L.BROADCAST_INC_TIME_LEFT = "包括剩餘時間";
L.BROADCAST_IN_PROGRESS_ERROR = "播出仍在進行中";
L.BROADCAST_NO_DATA = "沒有什麼好廣播的";
L.BROADCAST_NUMBER_OF_ITEMS = "東西的個數";
L.BROADCAST_PROGRESS = "廣播${percent}%";
L.BROADCAST_TARGET_PLAYER = "目標玩家（僅低聲）";
L.BROADCAST_TARGET_REQUIRED = "耳語需要目標玩家";
L.BROADCAST_TRADE_TIME_LEFT = "剩餘最大交易時間（分鐘）";
L.BY = "經過"; -- As in 'bid BY'
L.CANCEL = "取消";
L.CHANGELOG_CONTRIBUTE = "在我們的 Discord 上獲取支持或分享想法";
L.CHANGELOG_ENABLE_LABEL = "啟用變更日誌";
L.CHANGELOG_GETTING_STARTED = "Gargul 讓分發戰利品變得超級簡單，點擊下面的按鈕即可開始！";
L.CHANGELOG_OPEN_GARGUL = "打開加爾古爾";
L.CHANGE_SCALE = "調整比例";
L.CHANNEL = "頻道";
L.CHANNEL_OFFICER = "官";
L.CHANNEL_RAID_WARNING = "襲擊警告";
L.CHANNEL_WHISPER = "耳語";
L.CLASSICPRIO_ABBR = "心肺復甦";
L.CLEAR = "清除"; -- As in clearing a window or data
L.CLOSE = "關閉";
L.CLOSE_ON_AWARD = "即將獲獎";
L.CLOSE_ON_START = "開始時關閉";
L.COMMUNICATION = "溝通";
L.COMM_PROGRESS = "已發送 %s 個字節，共 %s 個位元組";
L.COPPER_INDICATOR = "C";
L.CUT = "切";
L.CUTS = "削減";
L.CUT_MAILBOX_CLOSED = "郵箱關閉後無法發送郵件";
L.CUT_MAILS_FAILED = "偵測到多個郵件錯誤，中止剪切分發";
L.CUT_MAIL_EVEN = "你不欠%s任何金幣";
L["Failed to send cut to %s"] = "無法將剪輯發送至 %s";
L.CUT_MAIL_GOLD_MISMATCH = "郵件已根據遊戲發送，但您剩餘的金幣不匹配，是不是出了什麼問題？";
L.CUT_MAIL_HISTORY = "|c00967FD2%s 的郵件歷史記錄";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "您沒有足夠的金幣來支付 %s";
L.CUT_MAIL_IN_PROGRESS = "等一下，我們還在處理之前的郵件";
L.CUT_MAIL_SUBJECT = "加古爾 GDKP：%sg";
L.CUT_SENT = "已發送 %sg 至 %s";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "刪除";
L.DETAILS = "細節";
L.DFT = "密度泛函理論";
L.DISABLE = "停用";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "祛魅";
L.EDIT = "編輯";
L.ENABLE = "使能夠";
L.EXPORT = "出口";
L.EXPORT_DELETE_ALL_CONFIRM = "您確定要刪除完整的獎勵紀錄表嗎？這將刪除所有戰利品數據並且無法撤消！";
L.EXPORT_DELETE_DATE_CONFIRM = "您確定要刪除 %s 的所有資料嗎？這不能被撤銷！";
L.EXPORT_READ_ONLY_NOTICE = [[
這只是導出功能，沒有必要編輯任何值：它們不會被保存！

]];
L.FILL = "充滿";
L.FINAL_CALL = "最後呼叫";
L.FINISH = "結束";
L.FORMAT = "格式";
L.GARGUL = "加爾古爾";
L.GDKP = "GDKP";
L.GDKPS_ARE_NOT_ALLOWED = "此版本的魔獸世界不允許 GDKP 突襲";
L.GDKP_ACTIVATED = "GDKP 活躍！";
L.GDKP_ADD_DROPS_TO_QUEUE = "將掉落的戰利品加入隊列中";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "金（- 用於去除金）";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "誰為此買單？";
L.GDKP_ADD_GOLD_INVALID_WARNING = "黃金需要低於/高於 0";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "付款方式：";
L.GDKP_ADD_GOLD_TITLE = "調整 %s 中的金幣";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "您不能同時向同一玩家給予和接收金幣";
L.GDKP_ALL_CUTS_MAILED = "所有剪輯均已郵寄！";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "因失望而禁用";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "戰鬥中停用";
L.GDKP_AUCTIONS = "拍賣";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "由...製作";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333已被 %s 刪除
原因：%s]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg 由 %s 加入彩池中
注意：%s]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s 已支付 |c00%s%sg 的費用
%s]];
L.GDKP_AUCTION_DETAILS_WON_BY = "獲勝者：";
L.GDKP_AUCTION_PAID_AMOUNT = "設定支付金額（左讀）";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul 自動追蹤黃金交易。只要玩家付費
對於他們購買的東西，那麼你不應該需要這個字段

「支付金額」是指買家已經向您交易的黃金數量。
這不會改變商品的實際價格！

警告：僅當玩家承諾付款時才在此處設定值
在突襲之外或透過替代/郵件等交易黃金！


]];
L.GDKP_AWARD_DIALOG_LABEL = "GDKP 價格：";
L.GDKP_AWARD_ITEM_CONFIRMATION = "為 %s 獎勵 %s 給 %s？";
L.GDKP_BIDDER_AUTO_BID = "自動出價";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "您的最高出價是多少？ （最小 %s|c00FFF569g）";
L.GDKP_BIDDER_BID_DENIED = "投標被拒絕！";
L.GDKP_BIDDER_ITEM_PRICING = "最低出價：%sg 增量：%sg";
L.GDKP_BIDDER_MY_MAX_BID = "（最大 %sg）";
L.GDKP_BIDDER_NEW_BID_LABEL = "新出價";
L.GDKP_BIDDER_STOP_AUTO_BID = "停止自動出價";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "最高出價：%s，%s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "最高出價：%s 由您出價";
L.GDKP_CREATE = "建立新的 GDKP 會話";
L.GDKP_CREATE_MANAGEMENT_CUT = "管理層削減%";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Management Cut 需要為空或介於 0 到 99 之間（沒有 % 符號！）";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "選擇會話類型！";
L.GDKP_CREATE_SESSION_SWITCH = "切換到此會話";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFF 多重拍賣允許您一次對多個物品開始出價，從而加快速度！
建立此會話後請按照說明開始操作

使用 |c00A79EFFSingle-Auction，您可以選擇拍賣單一物品或使用佇列

選擇 |c00A79EFF 多重拍賣可防止將已丟棄的項目添加到隊列中
您可以將 |c00A79EFFMulti-Auction 與 |c00A79EFFSingle-Auction 和隊列混合使用，但我們強烈建議不要這樣做

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "拍賣類型（|c00A79EFFi 以了解更多資訊）";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "多重拍賣";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "單次拍賣";
L.GDKP_CREATE_SUCCESSFUL = "會話已建立。我們建議您 /reload 以便正確儲存它，以防您的遊戲崩潰！";
L.GDKP_CUTS_ADD_RAIDER = "新增攻略";
L.GDKP_CUTS_ADJUST_G = "調整[克]";
L.GDKP_CUTS_ADJUST_P = "調整 [％]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "在群聊中宣布基地削減";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "您確定要重置所有玩家和計算嗎？注意：所有不再參與團隊的玩家將從清單中刪除！";
L.GDKP_CUTS_DELETE_RAIDER = "刪除攻略";
L.GDKP_CUTS_EDIT_RAIDER = "編輯攻略";
L.GDKP_CUTS_LOCK_TOOLTIP = "鎖定並付款";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "管理黃金交易";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

透過變異器，你可以給玩家更多或更少的金幣
例如：為坦克提供 2% 的額外獎勵就是變異者的用途！

注意：在此編輯或刪除修改器只會變更此會話的修改器

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "不在突襲中";
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
L.GDKP_CUTS_SUMMARY = "%s 攻略 | %s 有切口 |總支出：%sg";
L.GDKP_CUT_IMPORT_EMPTY = "無需匯入任何內容，請仔細檢查您的 CSV";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "玩家 %s 缺少金幣";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "缺少標題，注意：區分大小寫！";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "缺少球員姓名";
L.GDKP_DELETE_BID_INFO = "刪除出價。必須先停止拍賣！";
L.GDKP_DISTRIBUTE_ADDRAIDER = "將襲擊者加入此會話";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "自訂（建立您自己的格式）";
L.GDKP_EXPORT_AUCTIONS_JSON = "詳細（JSON）";
L.GDKP_EXPORT_AUCTIONS_SHARE = "分享（可以被其他玩家導入）";
L.GDKP_EXPORT_CUSTOM_FORMAT = "您的自訂格式";
L.GDKP_EXPORT_CUSTOM_HEADER = "您的自訂標頭";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "自訂（建立您自己的格式）";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@玩家，@CUT";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "球員、切入";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "會話被鎖定的日期/時間";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "給予玩家的總金幣";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "金幣郵寄給玩家";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "從玩家收到的總金幣";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "第一個項目被授予的日期/時間";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "交易給玩家的金幣";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM、@WINNER、@GOLD、@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "物品、玩家、金幣、Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "第一個項目被授予的日期/時間";
L.GDKP_EXPORT_FORMAT_TITLE = "GDKP 會議的標題";
L.GDKP_EXPORT_INCLUDE_DISENCHANTED = "包括不再抱持幻想的物品";
L.GDKP_EXPORT_POT_CHANGED = "鍋換了";
L.GDKP_GOLD_TRADES = "黃金交易";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "你確定嗎？您將無法查看或競價即將推出的商品！";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!!警告！！|r

您位於一個連接的領域，並且正在導入玩家姓名，而無需
領域後綴，例如“%s”。這可能會導致您發送
將郵件剪切並剪切給錯誤的玩家。

當處於連接的領域時，請始終嘗試包含玩家的領域名稱！

繼續導入嗎？
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "這將覆蓋您對剪切視窗所做的任何更改，您確定嗎？";
L.GDKP_IMPORT_CUTS_INFO = [[
您可以從自己的計算中匯入球員剪輯，例如Google表格。軟體 GDKP 等

格式如下（|c00BE3333INCLUDE THE HEADER！！）：

|c00BE3333Player，黃金|c00967FD2
玩家1,4000
玩家2,4125
玩家3,3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
導入 GDKP 最低價格和增量。

格式如下：ItemID + 最小值或增量為必填項。 （|c00BE3333需要標頭！！）：

|c00BE3333ItemID，最小值，增量|c00967FD2
18608,4000,500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "刪除現有的價格設定？點擊“是”刪除所有價格數據，點擊“否”則使用您在此處提供的數據覆蓋現有價格數據";
L.GDKP_IMPORT_SESSION = "導入 GDKP 會話";
L.GDKP_IMPORT_SESSION_ABOUT = "您可以在此處匯入（並繼續）GDKP 會話。為了從某人那裡獲得 GDKP 會話，他們需要將其匯出到 |c00FFF569/gdkp，其中他們選擇「共享（可以由其他玩家匯入）」格式";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "您即將匯入由 %s 建立的 GDKP 會話，您確定嗎？";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "%s 建立的 GDKP 會話似乎已存在，您要覆蓋它嗎？";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "為 GDKP 擴充功能提供的資料無效！";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "為 GDKP 重新安排提供的資料無效！";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "為 GDKP 縮短所提供的資料無效！";
L.GDKP_INVALID_DATA_FOR_START = "為 GDKP 拍賣開始提供的數據無效！";
L.GDKP_INVALID_PAID_AMOUNT = "為「付費」提供的號碼無效";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "拍賣中提供的時間無效：重新安排";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP 資料（已售出 %sx）
最後售價：%s
平均價格：%s
最低出價：%s
增量：%s

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "餘額： |c0092FF000 ？你是方的！ | |c00BE333330 ？你欠 %s 30g | |c00F7922E50 ？ %s欠你50g";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "金幣已由 %s 郵寄給您";
L.GDKP_LEDGER_LEGEND_PAID_TO = "金幣支付給%s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "從 %s 收到金幣";
L.GDKP_LEDGER_MUTATION = "黃金 %s 由"; -- %s = removed or added
L.GDKP_LEDGER_POT = "總底池：%sg |管理層削減：%sg (%s%%) |分發：%sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s |作者：%s%s |於 |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "GDKP 會話不可用或已鎖定";
L.GDKP_MAIL_ALL = "全部郵寄";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "未偵測到傳奇+物品的出價，請手動繼續！";
L.GDKP_MISSING_CONTENT_FOR_START = "拍賣中缺少內容：開始";
L.GDKP_MULTIAUCTION_ABOUT = [[

透過多重拍賣（或大量拍賣），您可以一次拍賣任意數量的物品！
這大大加快了你的突襲之夜，並為你的突襲者提供了無縫的體驗

庫存中的所有可交易物品都可以透過「從庫存填充」自動拍賣
試一試！

|c00808080只有一個缺點：為了讓人們參與批量拍賣，襲擊者需要 Gargul！

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "您需要有一個活躍的（解鎖的）GDKP 會話！";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "打開此視窗後，將 %s 件商品添加到清單中或點擊下面的“從庫存填充”"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "秒反狙擊";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "反狙擊值需要為0（空）或>=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "返回項目選擇器";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "從清單中刪除所有項目";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "從庫存中填充";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "將庫存中的可交易物品加入清單中";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
您可以在此處確定要包含在多重拍賣會話中的物品

使用下面的 |c00A79EFFFFill from inventory 按鈕將仍可交易的物品新增至清單中
每當您清除並重新開啟此視窗時，您最後的填充設定將用於自動新增項目

|c00A79EFF%s 項手動將其新增至清單中
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "下一步：檢查 raider 的附加版本的兼容性";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "不是每個人都在使用 Gargul，您確定要開始拍賣嗎？";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "至少選擇一件物品進行拍賣";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "您的 Gargul 已過時，我們建議在開始會話之前進行更新，以防止問題出現！";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "並不是每個人都是最新的。如果您遇到問題，請告訴您的襲擊者進行更新！";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "有一個活躍的多重拍賣，您在此處添加的項目將被添加到現有會話中。請注意重複的項目！";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "搜尋名稱或 iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "支援項目名稱和 iLVL，例如「252」、「<252」等";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "活動 GDKP 會話： |c00967FD2%s |作者：%s%s |於 |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "拍賣時間（秒）";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "拍賣時間（以秒為單位）需 >= 10";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "您在 GDKP 競標期間離開。為了恢復它，您必須為任何未售出的商品提供新的出價時間（以秒為單位）";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "開啟此視窗後，將 %s 個項目新增至清單中";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "點擊齒輪圖標來管理拍賣";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "您已經是 %s 的最高出價者";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
出價 |c00%s%sg
作者：%s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%s已關閉
沒有出價]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
最小值：|c00%s%sg
增量：|c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "商品：%s - 售出總量：%sg - 我承諾的：%sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
出價項目：%s/%s
總銷量：%s
我買的：%s
總出價（不包括已售出）：%s
我出價（不包括已售出）：%s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%s賣給
%s 代表 |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
出價 |c00%s%sg
作者：|c0092FF00YOU！]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "無法停止 %s 上的自動出價，請重試或/重新加載！";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "自動出價最高可達 %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "自動出價，最高可達您在左側填寫的出價";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "停止自動出價 (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "無法確認 %s 的出價";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "出價無效或出價過低！最小值為 %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "同一商品的兩次出價之間需要等待兩秒鐘";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "明確出價";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "從拍賣中刪除所有出價";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "關閉所有";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "關閉所有拍賣？";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
關閉所有拍賣

具有有效出價的拍賣將被出售，並且無法接受新的出價！
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "結束拍賣";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "結束拍賣。玩家不能再出價，但最高出價仍然有效";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "從拍賣中刪除該物品，包括其出價詳細資訊。這無法挽回！";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "分解所有已完成但未售出的物品？";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
分解未售出的物品

這會將所有未售出的物品標記為幻滅，並且它們不會出現在新的多重拍賣會中
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "收藏該商品";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "給最後一個呼叫計時器多少秒？";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "最小秒數為 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "透過提供（通常較短的）出價計時器來開始本次拍賣的最終召集";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "關閉所有拍賣並結束本次多重拍賣？";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
完成多重拍賣環節

這將關閉所有拍賣並在聊天中公佈總底池
具有有效出價的拍賣將被出售，並且無法接受新的出價！
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "隱藏非活動狀態";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "隱藏不可用";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "顯示/隱藏已完成的拍賣";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "管理拍賣";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "出價最低要求金額";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "投標視窗已關閉，請使用 |c00A79EFF/gl bid 重新開啟！";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "在聊天中宣布銷售狀況";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "出價高於時播放聲音";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "更多聲音選項...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "顯示所有";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "顯示收藏夾";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "顯示非活動狀態";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "顯示不可用";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "該商品已售出。使用分類帳（|c00%s/gdkp）進行更改！";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "終止";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "刪除所有 bidsl 出價並結束所有拍賣？";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
終止多重拍賣會話

這將刪除尚未售出的物品的所有出價並關閉所有拍賣！
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "將滑鼠懸停在下面的任何按鈕上以獲取更多信息";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "顯示/隱藏您無法使用的項目";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "為 GDKP 拍賣開始提供的數據無效！";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s 為 %sg 購買了 %s";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "戰利品大師 (%s) 已過時，這可能會導致出價失敗！";
L.GDKP_MULTIAUCTION_OUTBID = "你的出價被高估了！";
L.GDKP_MUTATORS = "變異者";
L.GDKP_MUTATOR_ADD = "新增變異器";
L.GDKP_MUTATOR_APPLY_LABEL = "自動應用於";
L.GDKP_MUTATOR_CREATE_NEW = "建立一個新的 GDKP 變異器";
L.GDKP_MUTATOR_DELETE_BYPASS = "刪除。按住shift跳過確認";
L.GDKP_MUTATOR_EDIT = "編輯突變子";
L.GDKP_MUTATOR_FLAT_LABEL = "固定黃金匯率 [範例：250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "統一費率必須是數字";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
例子：
|c00967FD2SELF，RL，治療者]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "您可以使用關鍵字自動將此變異器套用至攻擊者：";
L.GDKP_MUTATOR_NAME_LABEL = "名稱 [範例：坦克]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "變異器名稱不能包含點 (.)";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "百分比 [範例：10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "百分比必須是數字";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "儲存以備將來使用";
L.GDKP_MUTATOR_UNKNOWN = "未知變異子：%s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "不允許用戶“%s”開始拍賣";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "不允許使用者「%s」停止拍賣";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "不允許使用者「%s」停止拍賣：拍賣無效";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "沒有足夠的黃金可供分配，期待一些奇怪的削減計算！";
L.GDKP_NO_BIDS = "沒有出價！";
L.GDKP_OUTBID = "你的出價被高估了！";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "（積極的）";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
您需要鉛或大師戰利品來調整黃金。
您無法在鎖定/刪除的會話中調整金幣]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "新增/刪除黃金";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s 支付了 |c00%s%s 的費用
%s]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333已被 %s 刪除
原因：%s]];
L.GDKP_OVERVIEW_DELETED_SESSION = "（已刪除）";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
您需要先行或主戰利品才能刪除條目。
您無法刪除鎖定/已刪除會話中的項目]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "提供刪除此條目的原因";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "刪除。按住 Shift 鍵可繞過音符";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "附帶拍賣的會話將在 48 小時後刪除";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
您需要引導或掌握戰利品才能編輯條目。
您無法編輯已刪除的條目或鎖定/刪除的會話中的條目]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "匯出會話，以便其他人可以查看會話詳細信息，甚至取代您作為戰利品大師";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "從其他玩家或帳號匯入會話";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
顯示分類帳的完整概述，
非常適合截圖用途！]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "鎖定會話意味著您無法拍賣物品或以其他方式更改任何內容，直到您解鎖它，您確定嗎？";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "鎖定或解鎖會話";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "鎖定付款會話";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "多重拍賣：一次拍賣多個物品！";
L.GDKP_OVERVIEW_MUTATION_ADDED = "添加到";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s %s %s 的鍋
注意：%s]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "已經從...刪除";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
底池：%s
管理削減（%s%%）：%sg
每位玩家削減 (1/%s)：%sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
您需要先行或主戰利品才能恢復條目。
您無法恢復鎖定/刪除的會話條目]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "作者：%s%s |於 |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "解鎖和更改底池或削減可能會變得非常混亂，特別是如果您已經支付完成。你確定嗎？";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "解鎖會話";
L.GDKP_PAYOUT_INACTIVE = "未偵測到活動的 GDKP 會話或會話未鎖定付款！";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "增量或最小值不能低於 0.0001！";
L.GDKP_PRICE_IMPORT_INVALID_INC = "為項目 ID“%s”提供的“增量”無效";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "為項目 ID“%s”提供的“最小值”無效";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "項目 ID 需要最小值或增量：%s";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "缺少標題，注意：區分大小寫！";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "已成功匯入 %s 項數據";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "未知的項目 ID：%s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s 物品在袋子中、戰利品窗口中，甚至在聊天中的連結上，將它們添加到此拍賣隊列中。
目前拍賣完成後，隊列中的物品將自動拍賣。點擊“%s”按鈕可以防止這種情況發生。

想要 Gargul 會自動為您授予或取消拍賣嗎？打開左側的設定輪！

|c00FFF569你知道嗎？
您可以透過拖放來移動項目
即使您|c00A79EFF/重新加載，項目也會被記住
排隊的物品會自動顯示給擁有 Gargul 的攻擊者，以便他們可以預先出價
Gargul 還可以為您處理自動搶劫。使用 |c00A79EFF/gl pm 查看
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "隱藏不可用的物品";
L.GDKP_SESSION = "GDKP 會議";
L.GDKP_SESSION_EDIT_TITLE = "正在編輯 %s";
L.GDKP_SHOW_UPCOMING = "顯示即將推出的商品";
L.GDKP_STOP_AUCTION_FIRST = "先停止拍賣吧！";
L.GDKP_THEY_OWE = "%s欠你%s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP 會議
玩家花費：%s
已給：%s
已收到：%s
球員切入：%s

%s
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "從 GDKP 中排除";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "交易的黃金不會添加到給予或接收的金額中";
L.GDKP_TRADE_GIVEN_TO_LABEL = "金幣 |c00967FD2 已授予 %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "無法將 %s 新增至交易視窗。嘗試手動新增！";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "您沒有足夠的錢來支付 %s";
L.GDKP_TRADE_GOLD_TO_GIVE = "給予：%s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "接收：%s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "金幣 |c00967FD2 已從 %s 收到";
L.GDKP_TRY_MULTIAUCTION = "看看多重拍賣！";
L.GDKP_TUTORIAL_INFO = "請依照以下步驟快速開始使用 Gargul GDKP！";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "點擊下面的 |c00FFF569Enable 按鈕啟動此會話！";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s 一個要拍賣的物品或將單一物品排隊"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
有用的命令：
- |c00FFF569/gdkp 開啟此窗口
- |c00FFF569/gl ma 打開多重拍賣窗口
- |c00FFF569/gl au 打開單品拍賣師/隊列
- |c00FFF569/gl pm 設定自動搶劫

]];
L.GDKP_TUTORIAL_STEP_DONE = "如果一切順利，那麼您將在這裡看到新拍賣的物品！";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "想同時拍賣多件物品嗎？運行|c00FFF569/gl ma（或|c00FFF569/gl multiauction）或點擊此視窗右上角的multi-auction 圖示！";
L.GDKP_TUTORIAL_STEP_NEW = "點擊下面的 |c00FFF569New 按鈕建立您的第一個 GDKP 會話。建立後會顯示在左側";
L.GDKP_TUTORIAL_STEP_READY = "您已準備好出售物品了！ |c00BE3333在開始您的第一個 GDKP raid 之前，請仔細閱讀以下所有步驟並親自測試它們（無需參加 raid）！";
L.GDKP_TUTORIAL_STEP_SELL = "想要在沒有人出價的情況下出售商品嗎？ |c00FFF569%s 的商品，選出獲勝者並設定價格！";
L.GDKP_TUTORIAL_TITLE = "入門";
L.GDKP_UNKNOWN_ITEM = "拍賣中的未知 itemID：建立：%s";
L.GDKP_UNKNOWN_SESSION = "拍賣中未知的會話識別碼：建立：%s";
L.GDKP_YOU_OWE = "你欠 %s %s";
L.GIVEN = "給定";
L.GOLD_INDICATOR = "G";
L.GROUP = "團體";
L.GROUP_MANAGER = "集團經理";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "在 CurseForge 上下載";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "停";
L.HEADER = "標頭";
L.HELLO = "|c00%sGargul v%s，作者：Zhorax@Firemaw。輸入 |c00%s/gl 或 |c00%s/gargul 開始！";
L.HIDE = "隱藏";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.IDENTITY_INFO = "請訪問下面的 URL，以了解有關個性化 Gargul GDKP 的更多信息";
L.IDENTITY_TOOLTIP = "你的標誌在這裡嗎？點擊了解更多！";
L.IMPORT = "進口";
L.IMPORTED_AND_UPDATED_ON = "導入於 |c00A79EFF%s |c00A79EFF%s，更新於 |c00A79EFF%s |c00A79EFF%s";
L.IMPORT_EXPLANATION = "您想匯入什麼類型的資料？";
L.IMPORT_SUCCESSFUL = "導入增強滾動資料成功";
L.INC = "公司";
L.INCLUDE_AWARDED = "包括先前授予的項目";
L.INCLUDE_BOES = "包括京東方";
L.INCLUDE_MATERIALS = "包含材料（如深淵水晶）";
L.INCREMENT = "增量";
L.INFO = "資訊";
L.INVALID_DATA_WARNING = "提供的資料無效";
L.ITEM = "物品";
L.JSON_DECODE_WARNING = "無法對資料進行 JSON 解碼。確保按原樣複製/貼上它，而不添加任何其他字元或空格！";
L.KEYS_INFO = [[
Gargul 物品熱鍵

推出： |c00A79EFF%s
獎項： |c00A79EFF%s
分解：|c00A79EFF%s


-- 右鍵單擊禁用該視窗 --
]];
L.LEDGER = "分類帳";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "您需要成為搶劫大師或擔任協助/主角！";
L.LOCALE_CHANGE_NOTE = "注意：您可以隨時在設定中或透過 |c00%s/gl locale 變更區域設定";
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ENUS = "enUS"; -- English (United States)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_ITIT = "itIT"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul 用英文發布聊天訊息（預設）
您可以在下面的下拉清單中選擇不同的語言

您目前的聊天語言是“%s”，啟用不同的語言將導致/重新載入！
]];
L.LOCALE_NONE_TITLE = "選擇 Gargul 的聊天語言";
L.LOCALE_PTBR = "聚苯乙烯"; -- Portuguese (Brazil)
L.LOCALE_RURU = "茹茹"; -- Russian (Russia)
L.LOCALE_ZHCN = "中文"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "中文"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "您安裝了一個或多個插件，可能會導致 Gargul 無法正常工作：%s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "清晰的軟資源";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "清除TMB";
L.LOOTMASTER_DEFAULT_NOTE = "/roll 對於 MS 或 /roll 99 對於作業系統";
L.LOOTMASTER_IMPORT_SR_BUTTON = "導入軟體資源";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "進口TMB";
L.LOOTMASTER_NOTICE_LABEL = "你被賦予了搶劫大師的角色";
L.LOOTMASTER_OPEN_LABEL = "自動開啟此視窗";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "戰利品優先級已成功清除";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "提供以下格式的 prio CSV（每項 1 行）：id 或名稱 > prio1、equalprio > prio2 > 等";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "戰利品優先導入成功";
L.LOOTPRIORITY_INVALID_DATA = "提供的資料無效";
L.LOOTPRIORITY_INVALID_LINE = "第「%s」行中提供的資料無效：缺少項目 ID 或優先級";
L.LOOTPRIORITY_PROCESS_INCOMING = "正在嘗試處理來自 %s 的傳入戰利品優先級";
L.LOOTPRIORITY_TOOLTIP_HEADER = "戰利品普里奧";
L.MAIL = "郵件";
L.MAILED = "郵寄";
L.MAIL_CUTS_EXPLANATION = "郵寄給玩家";
L.MAINSPEC_ABBR = "多發性硬化症";
L.MAXIMIZE = "最大化";
L.MIN = "最小";
L.MINIMAP_BUTTON_AWARDED = "授予的戰利品歷史";
L.MINIMAP_BUTTON_CUTS = "GDKP 削減";
L.MINIMAP_BUTTON_EXPORT = "匯出數據";
L.MINIMAP_BUTTON_GARGUL = "打開加爾古爾";
L.MINIMAP_BUTTON_IMPORT = "導入數據";
L.MINIMAP_BUTTON_LEDGER = "GDKP分類賬";
L.MINIMAP_BUTTON_MULTIAUCTION = "多重拍賣";
L.MINIMAP_BUTTON_SETTING_INFO = "更改 /gl 小地圖中的設置";
L.MINIMIZE = "最小化";
L.MINIMIZE_ON_AWARD = "盡量減少獎勵";
L.MINIMIZE_ON_START = "啟動時最小化";
L.MINIMUM = "最低限度";
L.MINIMUM_ITEM_LEVEL = "最低物品等級";
L.MINIMUM_QUALITY = "最低品質";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "移動";
L.MULTI_AUCTION = "多重拍賣";
L.NAME = "姓名";
L.NEW = "新的";
L.NEXT = "下一個";
L.NO = "不";
L.NONE = "沒有任何";
L.NOTE = "筆記";
L.NOTHING = "沒有什麼";
L.NO_BIDS_ACTION = "當無人出價時：";
L.NO_OFFICER_PRIVILEGES = "你沒有軍官特權";
L.OFFSPEC_ABBR = "作業系統";
L.OK = "好的";
L.OPEN = "打開";
L.OPEN_AUCTIONEER = "公開拍賣師";
L.OPEN_MULTI_AUCTION = "公開多重拍賣";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "GREED";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORE";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "NEED";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASS";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "RANDOM";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SELF";
L.PACKMULE_CONFIRM_DISENCHANTER = "將 %s 設定為你的祛魅者？";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "將 %s 發送給 %s？輸入 /gl cd 來刪除這個分解器！";
L.PACKMULE_NO_DISENCHANTER_WARNING = "沒有設定分解器，使用 /gl sd [mydisenchanter] 設定一個";
L.PACKMULE_WHO_IS_DISENCHANTER = "誰是你的幻滅者？";
L.PAID = "有薪資的";
L.PASS = "經過";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "玩家";
L.PLAYER_ITEM_WON_COUNT = "%s 贏得的物品：";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "加號";
L.PLUSONES_AWARD_DIALOG_LABEL = "添加+1";
L.PLUSONES_BROADCAST_CONFIRM = "您確定要將您的加一數據廣播給您的隊伍/團隊中的每個人嗎？";
L.PLUSONES_BROADCAST_PROCESS_START = "正在嘗試處理來自 %s 的傳入 PlusOnes 數據";
L.PLUSONES_CLEAR_CONFIRM = "%s 想要清除您的所有 PlusOne 資料。清除所有資料？";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "您確定要清除現有的 PlusOne 資料並匯入 %s 廣播的新資料嗎？";
L.PLUSONES_IMPORT_CONFIRM = "您確定要匯入 %s 廣播的新資料嗎？";
L.PLUSONES_IMPORT_ERROR = "提供的數據無效。確保內容遵循所需的格式並且不包含標題行";
L.PLUSONES_IMPORT_INFO = [[
在這裡，您可以從 CSV 或 TSV 格式的表格或從 Google 文件表貼上的資料匯入加一資料。

表格至少需要兩列：玩家姓名，後面跟著分數。附加列將被忽略。

這是一個範例行：

福巴，240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "自動接受來自 %s 的傳入廣播";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "阻止所有傳入的 +1 共享數據";
L.PLUSONES_UPDATE_CONFIRM = [[
您確定要使用 %s 中的資料更新現有的 PlusOne 資料嗎？

您的最新更新是在 |c00A79EFF%s 上，他們的最新更新是在 |c00A79EFF%s 上。]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "鍋";
L.PRICE = "價格";
L.PRIOLIST_ABBR = "PL";
L.QUALITY_COMMON = "常見的";
L.QUALITY_EPIC = "史詩";
L.QUALITY_HEIRLOOM = "傳家寶";
L.QUALITY_LEGENDARY = "傳奇的";
L.QUALITY_POOR = "貧窮的";
L.QUALITY_RARE = "稀有的";
L.QUALITY_UNCOMMON = "罕見";
L.QUEUE = "佇列";
L.RAIDERS = "攻略";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "誰失踪了";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "顯示缺少的球員姓名";
L.RAIDGROUPS_DISBAND_BUTTON = "解散突襲";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "解散你的攻擊";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s 在名冊上被列出兩次！";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "|c00FFF569Raid-Helper 匯出（使用「垂直排序的群組」變體）或 |c00FFF569Gargul 組組合 CSV：";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
在下面的大編輯框中，您可以提供名單並：邀請所有人，檢查誰失踪了，應用組並分配坦克。

您可以提供 |c00FFF569Wowhead raid 組成連結：]];
L.RAIDGROUPS_GARGUL_BUTTON = "加爾古爾集團維基";
L.RAIDGROUPS_GARGUL_INFO = "訪問 Gargul 組 wiki，以了解有關 raid 組格式的更多信息";
L.RAIDGROUPS_IMPOSTER_WARNING = "以下球員不屬於名單：%s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "提供的群組資料無效，請檢查您的格式！";
L.RAIDGROUPS_INVITE_BUTTON = "邀請";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "向名單上的玩家發送邀請";
L.RAIDGROUPS_IN_COMBAT_WARNING = "當 %s 處於戰鬥狀態時無法對群組進行排序！"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "你需要參加突襲！";
L.RAIDGROUPS_NO_TANKS_WARNING = "沒有定義坦克";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "找不到 %s 的位置，您是否想將 5 人以上分成 1 組？";
L.RAIDGROUPS_PURGE_BUTTON = "踢掉不需要的球員";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "踢掉不在名單上的球員";
L.RAIDGROUPS_SORTING_ERROR = "移動 %s 時出了點問題";
L.RAIDGROUPS_SORTING_FINISHED = "完成申請raid名冊";
L.RAIDGROUPS_SORTING_GROUPS = "對群組進行排序";
L.RAIDGROUPS_SORT_BUTTON = "應用組";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "根據名單對組別進行排序";
L.RAIDGROUPS_SORT_IN_PROGRESS = "排序還在進行中，請稍等！";
L.RAIDGROUPS_TANKS_ASSIGNED = "所有坦克均已分配";
L.RAIDGROUPS_TANK_BUTTON = "分配坦克";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Wowhead 比較工具";
L.RAIDGROUPS_WOWHEAD_INFO = "您可以使用下面的 URL 存取 wowhead comp 工具。建立組合後，您可以將其貼到此處或 Gargul 群組視窗的大型編輯欄位中";
L.REMOVE_BID = "刪除出價";
L.RESET_SETTINGS = "重新設定";
L.RESET_SETTINGS_CONFIRMATION = "您確定要重設 Gargul 的所有設定嗎？這無法挽回！";
L.RESET_UI = "重置 Gargul UI";
L.RESET_UI_CONFIRMATION = "您確定要重置 Gargul 的所有視窗大小、位置和比例嗎？這無法挽回！";
L.RESTORE = "恢復";
L.RESUME = "恢復";
L.RIGHT_SYMBOL = ">";
L.ROLL = "卷";
L.ROLLING_AWARD_CONFIRM = "將 %s 獎勵給 %s？";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "即將獲獎";
L.ROLLING_CLOSE_ON_START_LABEL = "開始時關閉";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "按住shift繞過獎勵確認";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "按住shift鍵即可顯示獲獎確認訊息";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
警告：發現了另一個相同的捲，這可能表明平局

]];
L.ROLLING_INVALID_START_DATA_WARNING = "為開始磁碟區提供的資料無效！";
L.ROLLING_ITEM_WON_BR_COST = "（BR：%s）";
L.ROLLING_ITEM_WON_GIVEN = "（給出的項目：是）";
L.ROLLING_ITEM_WON_NOT_GIVEN = "（給出的項目：無）";
L.ROLLING_ITEM_WON_OS = "(作業系統)";
L.ROLLING_NOTE_LABEL = "筆記";
L.ROLLING_NO_ROLLOFF_WARNING = "無法停止滾滾，沒有正在進行滾滾";
L.ROLLING_PASS_BUTTON = "經過";
L.ROLLING_REOPEN_ROLL_COUNT = "卷數：%s";
L.ROLLING_REOPEN_TOOLTIP = "打開掠奪大師窗口";
L.ROLLING_ROLL_ACCEPTED = "滾滾接受！";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "目前正在進行滾動";
L.ROLLING_ROLL_PRIOLIST = "優先[%s]";
L.ROLLING_ROLL_SR_COUNT = "SR [%sx]";
L.ROLLING_ROLL_WISHLIST = "願望[%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "您需要先選擇一名玩家";
L.ROLLING_TIMER_LABEL = "計時器";
L.ROLLING_UNUSABLE_ITEM = "您不能使用該物品！";
L.ROLLING_WINNER_NOT_UNIQUE = "獲獎者的名字不是唯一的，請選擇您想要將 %s 獎勵給的玩家";
L.SECONDS_ABBR = "s";
L.SELECT_ALL = "選擇/停用全部";
L.SESSION = "會議";
L.SETTINGS = "設定";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "宣布收到的投標";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "獎勵物品後宣布底池";
L.SETTINGS_ANNOUNCE_START = "宣布拍賣開始";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "宣布突襲警告倒數計時";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "在突襲警告中宣布收到的投標";
L.SETTINGS_RESET_UI = "重置 Gargul UI";
L.SETTINGS_WHISPER_BID_TOO_LOW = "如果出價太低，則對投標者耳語";
L.SILVER_INDICATOR = "s";
L.SKIP = "跳過";
L.SOFTRES = "軟儲備";
L.SOFTRES_ABBR = "SR";
L.SOFTRES_BROADCAST_CONFIRM = "您確定要將您的軟體資料廣播給您的隊伍/突襲中的每個人嗎？";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "無法處理從 %s 收到的 SoftRes 數據";
L.SOFTRES_CLEAR_CONFIRM = "您確定要清除所有現有的軟保留資料嗎？";
L.SOFTRES_EVERYONE_RESERVED = "每個人都填滿了軟儲備";
L.SOFTRES_FEATURE_MISSING = [[
硬儲備資訊不可用，因為軟儲備
提供的內容不是使用 softres.it 上的「Gargul Export」按鈕產生的]];
L.SOFTRES_IMPORT_DETAILS = "導入於 |c00A79EFF%s |c00A79EFF%s";
L.SOFTRES_IMPORT_FIXED_NAME = "自動名稱修復：“%s”的 SR 現在連結到“%s”";
L.SOFTRES_IMPORT_INFO = "為了開始，您首先需要在 softres.it 上建立一個 raid。然後點擊“Addon Export”，選擇“Gargul”，複製資料並將其貼上到下面的表單中。";
L.SOFTRES_IMPORT_INVALID = "提供的軟儲備資料無效";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "提供的數據無效。確保單擊 softres.it 上的“Gargul Export”按鈕並將完整內容貼到此處";
L.SOFTRES_IMPORT_NEW_PLUSONES = "提供的 PlusOne 值與已存在的值發生衝突。您想替換舊的 PlusOne 值嗎？";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "以下玩家沒有保留任何東西：";
L.SOFTRES_IMPORT_SUCCESSFUL = "軟儲備導入成功";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "導入成功！";
L.SOFTRES_IMPORT_USE_GARGUL = "SoftRes Weakaura 和 CSV 資料已棄用，請改用 Gargul 匯出！";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "無法連線到 LootReserve，請聯絡支援人員（包括下面的訊息）";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "沒有可用的 softres.it URL，請確保使用 softres.it 上的“Gargul Export”按鈕匯出！";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "點擊此處查看硬預訂信息";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "沒有硬性保留的項目";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "沒有可用的硬性保留訊息";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "發布缺少的 SR";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "發佈 SR 網址";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "該玩家沒有保留任何東西！";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "正在嘗試處理來自 %s 的傳入 SoftRes 數據";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "此商品為硬性保留商品";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "對於：%s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 注意：%s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "保留者";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "出了點問題！";
L.START = "開始";
L.STOP = "停止";
L.TAB_REPLACES_T = "\\t  is replaced by a tab";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "時間";
L.TITLE = "標題";
L.TMBETC = "TMB、DFT 或 PRIO3";
L.TMB_BROADCAST_CONFIRM = "您確定要將 TMB 資料廣播給隊伍/團隊中的每個人嗎？注意：每個人都可以看到您的 TMB 數據，無論其在 TMB 網站上的權限如何！";
L.TMB_BROADCAST_PROCESS_START = "正在嘗試處理來自 %s 的傳入 TMB 數據";
L.TMB_CLEAR_CONFIRM = "您確定要清除所有加一資料嗎？";
L.TMB_CLEAR_RAIDER_DATA = "清除襲擊者數據";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "清除所有襲擊者的 TMB 資料？";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "自動共享已啟用：%s";
L.TMB_IMPORT_CPO_INFO = "在您的 classicpr.io 運行中點擊「Gargul Export」按鈕並複製內容。然後將內容原樣貼到下面的框中，然後按一下「匯入」。就是這樣！";
L.TMB_IMPORT_DETAILS = "於 ${date} ${time} 導入";
L.TMB_IMPORT_DFT_INFO = "依照工作表的說明匯出 DFT 資料。然後將內容原樣貼到下面的框中，然後按一下「匯入」。就是這樣！";
L.TMB_IMPORT_INVALID_CSV = "提供的 CSV 無效，格式為：6948,player1,player2";
L.TMB_IMPORT_INVALID_DFT = "提供的 DFT 數據無效，請按照工作表的說明匯出您的 DFT 數據，然後按原樣將內容貼到此處！";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "提供的 TMB 資料無效，請務必點擊 Gargul 部分中的「下載」按鈕並將內容原樣貼到此處！";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "提供的 TMB 或 DFT 資料無效，請確保將匯出內容按原樣貼到此處！";
L.TMB_IMPORT_NOTES_AVAILABLE = "可用的優先註釋：%s";
L.TMB_IMPORT_NUMBER = "導入的項目數：%s";
L.TMB_IMPORT_PLAYER_NO_DATA = "以下玩家沒有 %s 條目："; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "如何將 Gargul 與 ${source} 結合使用";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "將 TMB 匯出內容按原樣貼上到下面的框中，然後按一下“匯入”";
L.TMB_NO_BROADCAST_TARGETS = "您的群組中沒有人可以向其廣播";
L.TMB_SYNCED = "TMB 資料已同步";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF 註： |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(作業系統)";
L.TMB_TOOLTIP_PRIO_HEADER = "%s 優先列表"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF 等級：%s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "TMB 願望清單";
L.TOGGLE_DATES = "顯示/隱藏日期";
L.TOGGLE_QUEUE = "顯示/隱藏佇列";
L.TRADETIME_AWARD_HOWTO = "%s 獎勵戰利品！";
L.TRADETIME_ROLL_HOWTO = "%s 推出戰利品！";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "隱藏所有得獎物品";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "隱藏不再抱持幻想的物品";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "隱藏獎勵給自己的物品";
L.TRADE_ANNOUNCE = "公告交易";
L.TRADE_ANNOUNCE_INFO = "向群組公佈交易詳情，或在/不在群組中時公佈交易詳情";
L.TUTORIAL = "教學";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s 物品在袋子中、戰利品窗口中，甚至在聊天中的連結上，將它們添加到拍賣隊列中。
想要無需出價直接販售商品嗎？使用 |c00A79EFF%s

您可以輸入 |c00A79EFF/gl 拍賣直接開啟 %s 窗口

Gargul 追蹤 |c00FF0000 所有黃金交易。不希望交易成為此 GDKP 會議的一部分嗎？交易時勾選「從GDKP中排除」複選框！

|c00FFF569你知道嗎？
獲獎物品將自動添加到交易窗口
Gargul 還可以為您處理自動搶劫。使用 |c00A79EFF/gl pm 查看
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
此視窗顯示在任何給定日期已授予的所有項目（在左側選擇一個或多個日期）。

項目可以包含以下標籤：

|c00A79EFFOS：因不合格而獲獎
|c00A79EFFSR：此項目已軟保留
|c00A79EFFWL：此項目已列入願望清單（Thatsmybis）
|c00A79EFFPL：此專案已列入優先順序（Thatsmybis、DFT、prio3）
]];
L.TUTORIAL_BIDDER_QUEUE = [[
您在這裡看到的物品位於主盜賊的 GDKP 隊列中
您可以刪除它們、對它們出價以及隱藏不可用的項目（在左上角的設定中啟用「隱藏不可用的項目」）

您可以調整視窗大小、移動視窗或最小化視窗。試試看！

對於戰利品大師：在這裡刪除物品只會將它們從您的個人隊列中刪除，而不是實際的 GDKP 隊列中！
]];
L.TUTORIAL_MORE_HELP = "需要更多幫助嗎？";
L.TYPE = "類型"; -- As in type of roll or type of item
L.UNKNOWN = "未知";
L.UNKNOWN_COMM_ACTION = "未知的通訊操作“%s”，請務必更新 Gargul！";
L.UNLOCK = "開鎖";
L.UPDATE_GARGUL = "更新加古爾！";
L.VERSION_ABBR = "v";
L.VERSION_CHECK_BUTTON_REPORT = "報告";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "在群組聊天中報告過時的結果";
L.VERSION_CHECK_COLUMN_STATUS = "加爾古爾狀態";
L.VERSION_CHECK_STATUS_CHECKING = "檢查版本...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s：播放器是最新的
|c00F7922Ev%s：玩家需要更新他的附加元件
|c00BE3333%s：玩家沒有 Gargul 或使用不支援的版本
|c00808080%s：玩家離線或忽略我們！
|c0000FFFF%s：該玩家在我們的忽略清單中！

]];
L.VERSION_CHECK_STATUS_IGNORED = "玩家被忽略！";
L.VERSION_CHECK_STATUS_OFFLINE = "離線";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "沒有反應";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "沒有反應：";
L.VERSION_CHECK_SUMMARY_OFFLINE = "離線：";
L.VERSION_CHECK_SUMMARY_OUTDATED = "過時的：";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "最新：";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul 已過時，更新後才能使用！";
L.VERSION_INVALID_WARNING = "Version:addRelease 中提供的版本字串無效";
L.VERSION_UPDATE = "更新加古爾！";
L.VERSION_UPDATED = "|c00%sGargul 現已更新為 |c00%sv%s";
L.VERSION_UPDATE_AVAILABLE = "|c00A79EFFv%s 可在 CurseForge/Wago 上使用。您可以在不關閉遊戲的情況下進行更新，只需確保 /reload ！";
L.WAIT_SECONDS_BEFORE_RETRY = "再重試之前請再等 %s 秒";
L.WINDOW = "窗戶";
L.WINDOW_HEADER = "加爾古爾 v%s";
L.WINDOW_SCALE = "窗秤";
L.WISHLIST_ABBR = "WL";
L.YES = "是的";
L.YOU_DISABLED_GDKP_QUEUES = "您禁用了 GDKP 佇列";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "無法使用 zlib 壓縮資料。透過 https://discord.gg/D3mDhYPVzf 聯繫支援人員";
L.ZLIB_DECOMPRESS_WARNING = "無法解壓縮 zlib 資料。確保按原樣複製/貼上它，而不添加任何其他字元或空格！";
