--[[
    You can test this locally by removing line 8:
    if (GetLocale() ~= "deDE") then return; end

    These translations where provided by
        - genexliu
]]
if (GetLocale() ~= "zhTW") then return; end
local L = Gargul_L or {};

L["About"] = "關於";
L["All Settings"] = "所有設定";
L["Announce"] = "宣告";
L["Anti Snipe"] = "反狙擊";
L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"] = [[

Anti Snipe 值為 10 表示任何出價
剩餘時間少於 10 秒會將計時器重設為 10 秒

您可以將此留空或設為 0 以完全停用反狙擊。
不支援小於 5 的反狙擊值

]];
L["Are you sure?"] = "你確定嗎？";
L["\nDon't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --"] = [[
不要忘記使用 Gargul 代替
如果你想稍後再匯出戰利品


-- 右鍵單擊禁用該視窗 --]];
L["Auction"] = "拍賣";
L["Auctioneer"] = "拍賣";
L["Auctions"] = "拍賣";
L["Auto"] = "汽車";
L["Auto award"] = "汽車獎";
L["Auto trade"] = "汽車貿易";
L["Available values:"] = "可用值：";
L["Award"] = "分裝";
L["Awarded To"] = "裝備分給";
L["BR: %s"] = "BR：%s";
L["Price: %s"] = "價格";
L["Given: yes"] = "給出：是的";
L["Given: no"] = "給出：沒有";
L["2nd bid: %s by %s"] = "第二次出價：%s，%s";
L["You won"] = "你贏了";
L["Award %s to %s?"] = "將 %s 獎勵給 %s？";
L["Are you sure you want to disenchant %s? %s boosted roll points will be refunded!"] = "您確定要分解%s嗎？ %s 提升的擲骰點數將會退還！";
L["In Group"] = "組內";
L["Award history"] = "分裝紀錄";
L["Who should %s go to instead?"] = "%s 應該去找誰？";
L["Type player name here"] = "在此輸入玩家姓名";
L["or select one below"] = "或選擇以下一項";
L["Do you want to award %s to a random player?"] = "您想將 %s 獎勵給隨機玩家嗎？";
L["Drag and drop or shift+click an item in the box on the right"] = "拖放或按住 Shift 鍵點擊右側框中的項目";
L["(BR: %s)"] = "（BR：%s）";
L["Disenchanted items:"] = "失望的物品：";
L["(Given: yes)"] = "（給出：是）";
L["(Given: no)"] = "（給出：沒有）";
L["(OS)"] = "(作業系統)";
L["%s boosted roll points will be refunded!"] = "%s 提升的擲骰點數將會退還！";
L["Are you sure you want to undo %s awarded to %s?%s"] = "您確定要撤銷授予 %s 的 %s 獎勵嗎？%s"; -- The last %s is the content of L["%s boosted roll points will be refunded!"]
L["Bag inspection failed: no reports received"] = "袋子檢定失敗：未收到報告";
L["Inspection finished"] = "檢驗完畢";
L["Starting inspection..."] = "開始檢查...";
L["Balance"] = "平衡";
L["Base"] = "根據";
L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "無法對資料進行 Base64 解碼。確保按原樣複製/貼上它，而不添加任何其他字元或空格！";
L["Bid"] = "出價";
L["Bids"] = "出價";
L["BOE"] = "裝綁";
L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"] = "1.從raid註冊中自動邀請/排序群組！點擊下面或使用 |c00A79EFF/gl gr";
L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"] = "2. 獎勵常客或加倍努力的玩家！點擊下面或使用 |c00A79EFF/gl br";
L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"] = "Gargul 有一些你可能不知道的技巧。來看看吧！";
L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"] = "3. Gargul 包含加一追蹤系統！點擊下面或使用 |c00A79EFF/gl po";
L["Boosted Rolls"] = "額外增加 Roll 點";
L["BR"] = "BR";
L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"] = [[
為目前團隊中的每個人添加多少積分？

|c00BE3333如果您希望每個人都獲得積分，即使是那些沒有增強卷條目的人，請先使用「新增缺少的襲擊者」按鈕！]];
L["No point value provided!"] = "不提供積分值！";
L["Add points to raid"] = "為突襲添加積分";
L["Add missing raiders"] = "添加缺失的襲擊者";
L["Aliases"] = "別名";
L["Apply aliases"] = "應用程式別名";
L["Boosted Roll Cost:"] = "增加滾動成本：";
L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"] = "您確定要將增強的擲骰數據廣播給隊伍/團隊中的每個人嗎？";
L["Nothing to broadcast, import Boosted Rolls data first!"] = "沒什麼好播的，先導入 Boosted Rolls 資料！";
L["Couldn't process BoostedRolls data received from %s"] = "無法處理從 %s 收到的 BoostedRolls 數據";
L["Attempting to process incoming BoostedRolls data from %s"] = "正在嘗試處理來自 %s 的傳入 BoostedRolls 數據";
L["Are you sure you want to clear all boosted roll data?"] = "您確定要清除所有增強滾動資料嗎？";
L["Delete %s?"] = "刪除%s？";
L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"] = "您確定要清除現有的增強滾動資料並匯入 %s 廣播的新資料嗎？";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "提供的數據無效。確保內容遵循所需的格式並且不包含標題行";
L["\nHere you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo"] = [[
在這裡，您可以從 CSV 或 TSV 格式的表格或從 Google 文件表貼上的表格匯入增強捲動資料和別名。

表格至少需要兩列：玩家姓名，後面跟著分數。附加列是可選的，並且可能包含玩家的別名。
這是一個範例行：

Foobar,240,Barfoo]];
L["Points"] = "積分";
L["Points: %s"] = "積分：%s";
L["N/A"] = "無法取得";
L["Reserve"] = "預訂";
L["\nAre you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
您確定要使用 %s 的數據更新現有的強化骰子嗎？

您的最新更新是在 |c00A79EFF%s 上，他們的最新更新是在 |c00A79EFF%s 上。]];
L["!bonus|!rb|!br"] = "!獎金|!rb|!br";
L["Broadcast"] = "pod送";
L["Broadcasting..."] = "廣播...";
L["You are currently in combat, delaying broadcast"] = "您目前正處於戰鬥狀態，延遲播出";
L["Broadcast finished!"] = "播出完畢！";
L["Include awarded items"] = "包括獲獎項目";
L["Include disenchanted items"] = "包括不再抱持幻想的物品";
L["Include hidden items"] = "包括隱藏項目";
L["Include time left"] = "包括剩餘時間";
L["Broadcast still in progress"] = "播出仍在進行中";
L["There is nothing to broadcast"] = "沒有什麼好廣播的";
L["Number of items"] = "東西的個數";
L["Broadcast ${percentage}%"] = "廣播${percent}%";
L["Target player (whisper only)"] = "目標玩家（僅低聲）";
L["Whisper requires a target player"] = "耳語需要目標玩家";
L["Max trade time left (in minutes)"] = "剩餘最大交易時間（分鐘）";
L["by"] = "由"; -- As in 'bid BY'
L["Cancel"] = "取消";
L["Get support or share ideas on our Discord"] = "在我們的 Discord 上獲取支持或分享想法";
L["Enable changelog"] = "啟用變更日誌";
L["Gargul makes handing out loot super easy, click the button below to get started!"] = "Gargul 讓分裝變得超級簡單，點擊下面的按鈕即可開始！";
L["Open Gargul"] = "開啟 Gargul";
L["Adjust Scale"] = "調整比例";
L["Channel"] = "頻道";
L["Officer"] = "幹部頻道";
L["Raid Warning"] = "團隊警報(rw)頻道";
L["Whisper"] = "密語";
L["CPR"] = "心肺復甦";
L["Clear"] = "清除"; -- As in clearing a window or data
L["Close"] = "關閉";
L["Close on award"] = "分裝時關閉";
L["Close on start"] = "開始倒數時關閉";
L["Communication"] = "溝通";
L["Sent %s of %s bytes"] = "已發送 %s 個字節，共 %s 個位元組";
L["c"] = "C";
L["Cut"] = "切";
L["Cuts"] = "削減";
L["Can't send mail when the mailbox is closed"] = "郵箱關閉後無法發送郵件";
L["Multiple mail errors detected, aborting cut distribution"] = "偵測到多個郵件錯誤，中止剪切分發";
L["You don't owe %s any gold"] = "你不欠%s任何金幣";
L["Failed to send cut to %s"] = "無法將剪輯發送至 %s";
L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"] = "郵件已根據遊戲發送，但您剩餘的金幣不匹配，是不是出了什麼問題？";
L["Mail History for |c00967FD2%s"] = "|c00967FD2%s 的郵件歷史記錄";
L["You don't have enough gold to pay %s"] = "您沒有足夠的金幣來支付 %s";
L["Wait a bit, we're still processing the previous mail"] = "等一下，我們還在處理之前的郵件";
L["Gargul GDKP: %sg"] = "加古爾 GDKP：%sg";
L["Sent %sg to %s"] = "已發送 %sg 至 %s";
L["%Y-%m-%d"] = "%Y-%m-%d";
L["%Y-%m-%d %H:%M"] = "%Y-%m-%d %H:%M";
L["%d-%m %H:%M"] = "%d-%m %H:%M";
L["Delete"] = "刪除";
L["Details"] = "細節";
L["DFT"] = "密度泛函理論";
L["Disable"] = "停用";
L["https://discord.gg/D3mDhYPVzf"] = "https://discord.gg/D3mDhYPVzf";
L["Disenchant"] = "分解";
L["Edit"] = "編輯";
L["Enable"] = "啟用";
L["Export"] = "匯出";
L["Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!"] = "您確定要刪除全部的分裝紀錄嗎？這將刪除所有分裝數據並且無法回復！";
L["Are you sure you want to remove all data for %s? This cannot be undone!"] = "您確定要刪除 %s 的所有資料嗎？這不能被回復！";
L["\nThis is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n"] = [[
這只是匯出功能，沒有必要編輯任何值：它們不會被保存！

]];
L["Fill"] = "充滿";
L["Final Call"] = "最後呼叫";
L["Finish"] = "結束";
L["Format"] = "格式";
L["Gargul"] = "Gargul";
L["GDKP"] = "GDKP";
L["GDKP raids are not allowed in this version of World of Warcraft"] = "此版本的魔獸世界不允許 GDKP";
L["GDKP Active!"] = "GDKP 啟用！";
L["Add dropped loot to queue"] = "將掉落的戰利品加入隊列中";
L["Gold (- for removing gold)"] = "金（- 用於去除金）";
L["Who pays for this?"] = "誰為此買單？";
L["Gold needs to be lower/higher than 0"] = "黃金需要低於/高於 0";
L["Paid for by"] = "付款方式：";
L["Adjust gold in %s"] = "調整 %s 中的金幣";
L["You can't give AND receive gold from the same player at the same time"] = "您不能同時向同一玩家給予和接收金幣";
L["All cuts were mailed!"] = "所有剪輯均已郵寄！";
L["Disable for disenchanted"] = "因失望而禁用";
L["Disable in combat"] = "戰鬥中停用";
L["Auctions"] = "拍賣";
L["Created by"] = "由...製作";
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333已被 %s 刪除
原因：%s]];
L["\n|c00%s%s added to pot by %s\nNote: %s"] = [[
|c00%s%sg 由 %s 加入彩池中
注意：%s]];
L["Won by"] = "獲勝者：";
L["Set paid amount (read left)"] = "設定支付金額（左讀）";
L["\n\nGargul automatically keeps track of gold traded. As long as players pay\nfor what they bought then you shouldn't ever need this field\n\n'Paid amount' refers to the amount of gold the buyer already traded you.\nThis does not change the actual price of the item!\n\nWarning: only set a value here if the player promises to pay\noutside of the raid or trades the gold from an alt / mail etc!\n\n\n"] = [[

Gargul 自動追蹤黃金交易。只要玩家付費
對於他們購買的東西，那麼你不應該需要這個字段

「支付金額」是指買家已經向您交易的黃金數量。
這不會改變商品的實際價格！

警告：僅當玩家承諾付款時才在此處設定值
在突襲之外或透過替代/郵件等交易黃金！


]];
L["GDKP Price:"] = "GDKP 價格：";
L["Award %s to %s for %s?"] = "為 %s 獎勵 %s 給 %s？";
L["Auto Bid"] = "自動出價";
L["What's your maximum bid? (Minimum %s|c00FFF569g)"] = "您的最高出價是多少？ （最小 %s|c00FFF569g）";
L["Bid denied!"] = "投標被拒絕！";
L["Min bid: %sg   Increment: %sg"] = "最低出價：%sg 增量：%sg";
L["(max %sg)"] = "（最大 %sg）";
L["New bid"] = "新出價";
L["Stop Auto Bid"] = "停止自動出價";
L["Top bid: %s by %s"] = "最高出價：%s，%s";
L["Top bid: %s by you"] = "最高出價：%s 由您出價";
L["Create a new GDKP session"] = "建立新的 GDKP 會話";
L["Management Cut %"] = "管理層削減%";
L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"] = "Management Cut 需要為空或介於 0 到 99 之間（沒有 % 符號！）";
L["Choose a session type!"] = "選擇會話類型！";
L["Switch to this session"] = "切換到此會話";
L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"] = [[

|c00A79EFF 多重拍賣允許您一次對多個物品開始出價，從而加快速度！
建立此會話後請按照說明開始操作

使用 |c00A79EFFSingle-Auction，您可以選擇拍賣單一物品或使用佇列

選擇 |c00A79EFF 多重拍賣可防止將已丟棄的項目添加到隊列中
您可以將 |c00A79EFFMulti-Auction 與 |c00A79EFFSingle-Auction 和隊列混合使用，但我們強烈建議不要這樣做

]];
L["Auction type (|c00A79EFFi for more info)"] = "拍賣類型（|c00A79EFFi 以了解更多資訊）";
L["Multi-Auction"] = "多重拍賣";
L["Single-Auction"] = "單次拍賣";
L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"] = "會話已建立。我們建議您 /reload 以便正確儲存它，以防您的遊戲崩潰！";
L["Add Raider"] = "新增攻略";
L["adjust [g]"] = "調整[克]";
L["adjust [%]"] = "調整 [％]";
L["Announce the base cut in group chat"] = "在群聊中宣布基地削減";
L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"] = "您確定要重置所有玩家和計算嗎？注意：所有不再參與團隊的玩家將從清單中刪除！";
L["Delete Raider"] = "刪除攻略";
L["Edit Raider"] = "編輯攻略";
L["Lock and Pay"] = "鎖定並付款";
L["Manage gold trades"] = "管理黃金交易";
L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"] = [[

透過變異器，你可以給玩家更多或更少的金幣
例如：為坦克提供 2% 的額外獎勵就是變異者的用途！

注意：在此編輯或刪除修改器只會變更此會話的修改器

]];
L["Not in the raid"] = "不在突襲中";
L["\n\nThe total payout can differ slightly from the pot due to rounding differences!\nPlayers currently in the raid can not be edited or removed!\n\nColor explanation:\n|c00F7922E(2000g) Means you owe this person 2000g\n|c00BE3333(3000g) Means this person owes you 3000g\n|c0092FF00(0) Means that you're square\n\nAdjuster explanation:\nWith adjust [g] you can add/deduct gold to a player (use -50 to deduct 50 gold from a player's cut)\nWith adjust [%] you can add/deduct a percentage to a player (use -50 to give players a half cut)\n"] = [[

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
L["%s Raiders | %s With cut | Total payout: %s"] = "%s 攻略 | %s 有切口 |總支出：%sg";
L["Nothing to import, double check your CSV"] = "無需匯入任何內容，請仔細檢查您的 CSV";
L["Missing gold for player %s"] = "玩家 %s 缺少金幣";
L["Missing header, note: it's case-sensitive!"] = "缺少標題，注意：區分大小寫！";
L["Missing player name"] = "缺少球員姓名";
L["Delete bid. Auction must be stopped first!"] = "刪除出價。必須先停止拍賣！";
L["Add a raider to this session"] = "將襲擊者加入此會話";
L["Custom (create your own format)"] = "自訂（建立您自己的格式）";
L["Detailed (JSON)"] = "詳細（JSON）";
L["Share (can be imported by other players)"] = "分享（可以被其他玩家導入）";
L["Your custom format"] = "您的自訂格式";
L["Your custom header"] = "您的自訂標頭";
L["Custom (create your own format)"] = "自訂（建立您自己的格式）";
L["@PLAYER,@CUT"] = "@玩家，@CUT";
L["Player,Cut"] = "球員、切入";
L["date/time at which the session was locked"] = "會話被鎖定的日期/時間";
L["total gold given to the player"] = "給予玩家的總金幣";
L["gold mailed to the player"] = "金幣郵寄給玩家";
L["total gold received from the player"] = "從玩家收到的總金幣";
L["date/time at which the first item was awarded"] = "第一個項目被授予的日期/時間";
L["gold traded to the player"] = "交易給玩家的金幣";
L["@ITEM,@WINNER,@GOLD,@WOWHEAD"] = "@ITEM、@WINNER、@GOLD、@WOWHEAD";
L["Item,Player,Gold,Wowheadlink"] = "物品、玩家、金幣、Wowheadlink";
L["Date/time at which the first item was awarded"] = "第一個項目被授予的日期/時間";
L["The title of the GDKP session"] = "GDKP 會議的標題";
L["Include disenchanted items"] = "包括不再抱持幻想的物品";
L["Pot changed"] = "鍋換了";
L["Gold Trades"] = "黃金交易";
L["Are you sure? You won't be able to see, or bid on, upcoming items!"] = "你確定嗎？您將無法查看或競價即將推出的商品！";
L["\n|c00BE3333!! WARNING !!|r\n\nYou're on a connected realm and are importing player names without\na realm suffix, '%s' for example. This can cause you to send\ncuts and cut mails to the wrong player.\n\nWhen on a connected realm always try to include the realm name of players!\n\nContinue importing?\n"] = [[
|c00BE3333!!警告！！|r

您位於一個連接的領域，並且正在導入玩家姓名，而無需
領域後綴，例如“%s”。這可能會導致您發送
將郵件剪切並剪切給錯誤的玩家。

當處於連接的領域時，請始終嘗試包含玩家的領域名稱！

繼續導入嗎？
]];
L["This will override any changes you've made to the cut window, are you sure?"] = "這將覆蓋您對剪切視窗所做的任何更改，您確定嗎？";
L["\nYou can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!):\n\n|c00BE3333Player,Gold|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n"] = [[
您可以從自己的計算中匯入球員剪輯，例如Google表格。軟體 GDKP 等

格式如下（|c00BE3333INCLUDE THE HEADER！！）：

|c00BE3333Player，黃金|c00967FD2
玩家1,4000
玩家2,4125
玩家3,3998


]];
L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"] = [[
導入 GDKP 最低價格和增量。

格式如下：ItemID + 最小值或增量為必填項。 （|c00BE3333需要標頭！！）：

|c00BE3333ItemID，最小值，增量|c00967FD2
18608,4000,500
]];
L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"] = "刪除現有的價格設定？點擊“是”刪除所有價格數據，點擊“否”則使用您在此處提供的數據覆蓋現有價格數據";
L["Import GDKP Session"] = "導入 GDKP 會話";
L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"] = "您可以在此處匯入（並繼續）GDKP 會話。為了從某人那裡獲得 GDKP 會話，他們需要將其匯出到 |c00FFF569/gdkp，其中他們選擇「共享（可以由其他玩家匯入）」格式";
L["You're about to import a GDKP session created by %s, are you sure?"] = "您即將匯入由 %s 建立的 GDKP 會話，您確定嗎？";
L["This GDKP session created by %s appears to exist already, do you wish to override it?"] = "%s 建立的 GDKP 會話似乎已存在，您要覆蓋它嗎？";
L["Invalid data provided for GDKP extension!"] = "為 GDKP 擴充功能提供的資料無效！";
L["Invalid data provided for GDKP reschedule!"] = "為 GDKP 重新安排提供的資料無效！";
L["Invalid data provided for GDKP shortening!"] = "為 GDKP 縮短所提供的資料無效！";
L["Invalid data provided for GDKP auction start!"] = "為 GDKP 拍賣開始提供的數據無效！";
L["Invalid number provided for 'paid'"] = "為「付費」提供的號碼無效";
L["Invalid time provided in Auction:reschedule"] = "拍賣中提供的時間無效：重新安排";
L["\n\n|c00967FD2GDKP Data (sold %sx)\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n\n"] = [[

|c00967FD2GDKP 資料（已售出 %sx）
最後售價：%s
平均價格：%s
最低出價：%s
增量：%s

]];
L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"] = "餘額： |c0092FF000 ？你是方的！ | |c00BE333330 ？你欠 %s 30g | |c00F7922E50 ？ %s欠你50g";
L["Gold mailed to you by %s"] = "金幣已由 %s 郵寄給您";
L["Gold paid to %s"] = "金幣支付給%s";
L["Gold received from %s"] = "從 %s 收到金幣";
L["Gold %s by"] = "黃金 %s 由"; -- %s = removed or added
L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"] = "總底池：%sg |管理層削減：%sg (%s%%) |分發：%sg";
L["|c00967FD2%s | By %s%s | On |c00967FD2%s"] = "|c00967FD2%s |作者：%s%s |於 |c00967FD2%s";
L["The GDKP Session is not available or locked"] = "GDKP 會話不可用或已鎖定";
L["Mail All"] = "全部郵寄";
L["No bids on Legendary+ item detected, continue manually!"] = "未偵測到傳奇+物品的出價，請手動繼續！";
L["Missing content in Auction:start"] = "拍賣中缺少內容：開始";
L["\n\nWith multi auctions (or batch auctions) you can auction off as many items as you want at once!\nThis speeds up your raid nights immensely and makes for a seamless experience for your raiders\n\nAll tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'\nGive it a shot!\n\n|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!\n\n"] = [[

透過多重拍賣（或大量拍賣），您可以一次拍賣任意數量的物品！
這大大加快了你的突襲之夜，並為你的突襲者提供了無縫的體驗

庫存中的所有可交易物品都可以透過「從庫存填充」自動拍賣
試一試！

|c00808080只有一個缺點：為了讓人們參與批量拍賣，襲擊者需要 Gargul！

]];
L["You need to have an active (unlocked) GDKP session!"] = "您需要有一個活躍的（解鎖的）GDKP 會話！";
L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"] = "打開此視窗後，將 %s 件商品添加到清單中或點擊下面的“從庫存填充”"; -- %s holds the add item hotkey (default ALT_CLICK)
L["Anti snipe in seconds"] = "秒反狙擊";
L["The anti snipe value needs to be 0 (empty) or >=5"] = "反狙擊值需要為0（空）或>=5";
L["Go back to the item selector"] = "返回項目選擇器";
L["Remove all items from the list"] = "從清單中刪除所有項目";
L["Fill from inventory"] = "從庫存中填充";
L["Add tradeable items from your inventory to the list"] = "將庫存中的可交易物品加入清單中";
L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"] = [[
您可以在此處確定要包含在多重拍賣會話中的物品

使用下面的 |c00A79EFFFFill from inventory 按鈕將仍可交易的物品新增至清單中
每當您清除並重新開啟此視窗時，您最後的填充設定將用於自動新增項目

|c00A79EFF%s 項手動將其新增至清單中
]];
L["Next step: check raider's add-on version for compatibility"] = "下一步：檢查 raider 的附加版本的兼容性";
L["Not everyone is using Gargul, are you sure you want to start the auction?"] = "不是每個人都在使用 Gargul，您確定要開始拍賣嗎？";
L["Select at least one item for your auction"] = "至少選擇一件物品進行拍賣";
L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"] = "您的 Gargul 已過時，我們建議在開始會話之前進行更新，以防止問題出現！";
L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"] = "並不是每個人都是最新的。如果您遇到問題，請告訴您的襲擊者進行更新！";
L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"] = "有一個活躍的多重拍賣，您在此處添加的項目將被添加到現有會話中。請注意重複的項目！";
L["Search name or iLVL"] = "搜尋名稱或 iLVL";
L["Supports item names and iLVL e.g. '252', '<252' etc"] = "支援項目名稱和 iLVL，例如「252」、「<252」等";
L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"] = "活動 GDKP 會話： |c00967FD2%s |作者：%s%s |於 |c00967FD2%s";
L["Auction time in seconds"] = "拍賣時間（秒）";
L["The auction time in seconds needs to be >= 10"] = "拍賣時間（以秒為單位）需 >= 10";
L["You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items"] = "您在 GDKP 競標期間離開。為了恢復它，您必須為任何未售出的商品提供新的出價時間（以秒為單位）";
L["With this window open, %s items to add them to the list"] = "開啟此視窗後，將 %s 個項目新增至清單中";
L["Click the cogwheel icon to manage an auction"] = "點擊齒輪圖標來管理拍賣";
L["You're already the top bidder on %s"] = "您已經是 %s 的最高出價者";
L["Bid |c00%s%sg\nBy %s"] = [[
出價 |c00%s%sg
作者：%s]];
L["|c00%sCLOSED\nNo bids"] = [[
|c00%s已關閉
沒有出價]];
L["Minimum: |c00%s%sg\nIncrement: |c00%s%sg"] = [[
最小值：|c00%s%sg
增量：|c00%s%sg]];
L["Items: %s  -  Total sold: %sg  -  Pledged by me: %sg"] = "商品：%s - 售出總量：%sg - 我承諾的：%sg";
L["Items with bids: %s/%s\nTotal sold: %s\nBought by me: %s\nTotal bid (does not include sold): %s\nBid by me (does not include sold): %s\n"] = [[
出價項目：%s/%s
總銷量：%s
我買的：%s
總出價（不包括已售出）：%s
我出價（不包括已售出）：%s
]];
L["|c00%sSOLD to%s\nfor |c00%s%s"] = [[
|c00%s賣給
%s 代表 |c00%s%sg]];
L["Bid |c00%s%s\nBy |c0092FF00YOU!"] = [[
出價 |c00%s%sg
作者：|c0092FF00YOU！]];
L["Could not stop auto bidding on %s, try again or /reload!"] = "無法停止 %s 上的自動出價，請重試或/重新加載！";
L["Auto bid up to a maximum of %sg"] = "自動出價最高可達 %sg";
L["Auto bid up to the bid you fill in on the left"] = "自動出價，最高可達您在左側填寫的出價";
L["Stop your auto bid (%sg)"] = "停止自動出價 (%sg)";
L["Bid on %s could not be confirmed"] = "無法確認 %s 的出價";
L["Invalid bid or bid is too low! The minimum is %sg"] = "出價無效或出價過低！最小值為 %sg";
L["You need to wait two seconds between bids on the same item"] = "同一商品的兩次出價之間需要等待兩秒鐘";
L["Clear bids"] = "明確出價";
L["Remove all bids from the auction"] = "從拍賣中刪除所有出價";
L["Close all"] = "關閉所有";
L["Close ALL auctions?"] = "關閉所有拍賣？";
L["Close ALL auctions\n\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
關閉所有拍賣

具有有效出價的拍賣將被出售，並且無法接受新的出價！
]];
L["Close Auction"] = "結束拍賣";
L["Close the auction. Players can no longer bid but the highest bid remains active"] = "結束拍賣。玩家不能再出價，但最高出價仍然有效";
L["Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!"] = "從拍賣中刪除該物品，包括其出價詳細資訊。這無法挽回！";
L["Disenchant all finished but unsold items?"] = "分解所有已完成但未售出的物品？";
L["Disenchant unsold items\n\nThis will mark all unsold items as disenchanted and they will not show up in a new multi-auction session"] = [[
分解未售出的物品

這會將所有未售出的物品標記為幻滅，並且它們不會出現在新的多重拍賣會中
]];
L["Favorite this item"] = "收藏該商品";
L["Give a final call timer of how many seconds?"] = "給最後一個呼叫計時器多少秒？";
L["The minimum amount of seconds is 5"] = "最小秒數為 5";
L["Start a final call for this auction by giving a (usually shorter) bid timer"] = "透過提供（通常較短的）出價計時器來開始本次拍賣的最終召集";
L["Close ALL auctions and wrap up this multi-auction session?"] = "關閉所有拍賣並結束本次多重拍賣？";
L["Finish Multi-Auction session\n\nThis will close all auctions and announce the total pot in chat\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
完成多重拍賣環節

這將關閉所有拍賣並在聊天中公佈總底池
具有有效出價的拍賣將被出售，並且無法接受新的出價！
]];
L["Hide inactive"] = "隱藏非活動狀態";
L["Hide unusable"] = "隱藏不可用";
L["Show/Hide finished auctions"] = "顯示/隱藏已完成的拍賣";
L["Manage Auction"] = "管理拍賣";
L["Bid the minimum required amount"] = "出價最低要求金額";
L["Bidding window closed, use |c00A79EFF/gl bid to reopen it!"] = "投標視窗已關閉，請使用 |c00A79EFF/gl bid 重新開啟！";
L["Announce sales in chat"] = "在聊天中宣布銷售狀況";
L["Play sound when outbid"] = "出價高於時播放聲音";
L["More sound options..."] = "更多聲音選項...";
L["Show all"] = "顯示所有";
L["Show favorites"] = "顯示收藏夾";
L["Show inactive"] = "顯示非活動狀態";
L["Show unusable"] = "顯示不可用";
L["This item was sold. Use ledger (|c00%s/gdkp) to make changes!"] = "該商品已售出。使用分類帳（|c00%s/gdkp）進行更改！";
L["Terminate"] = "終止";
L["Remove all bidsl bids and close all auctions?"] = "刪除所有 bidsl 出價並結束所有拍賣？";
L["Terminate Multi-Auction session\n\nThis will delete all bids on items that haven't sold yet and close all auctions!"] = [[
終止多重拍賣會話

這將刪除尚未售出的物品的所有出價並關閉所有拍賣！
]];
L["Hover over any of the buttons below for more information"] = "將滑鼠懸停在下面的任何按鈕上以獲取更多信息";
L["Show/Hide items you can't use"] = "顯示/隱藏您無法使用的項目";
L["Invalid data provided for GDKP auction start!"] = "為 GDKP 拍賣開始提供的數據無效！";
L["%s bought %s for %s"] = "%s 為 %sg 購買了 %s";
L["The loot master (%s) is outdated, this can cause bids to fail!"] = "戰利品大師 (%s) 已過時，這可能會導致出價失敗！";
L["You were outbid!"] = "你的出價被高估了！";
L["Mutators"] = "變異者";
L["Add Mutator"] = "新增變異器";
L["Auto apply to"] = "自動應用於";
L["Create a new GDKP mutator"] = "建立一個新的 GDKP 變異器";
L["Delete. Hold shift to bypass confirmation"] = "刪除。按住shift跳過確認";
L["Edit mutator"] = "編輯突變子";
L["Flat gold rate [example: 250]"] = "固定黃金匯率 [範例：250]";
L["The flat rate needs to be a number"] = "統一費率必須是數字";
L["\nExample:\n|c00967FD2SELF,RL,HEALER"] = [[
例子：
|c00967FD2SELF，RL，治療者]];
L["You can automatically apply this mutator to raiders using keywords:"] = "您可以使用關鍵字自動將此變異器套用至攻擊者：";
L["Name [example: Tanks]"] = "名稱 [範例：坦克]";
L["Mutator names can not contains dots (.)"] = "變異器名稱不能包含點 (.)";
L["Percentage [example: 10]"] = "百分比 [範例：10]";
L["The percentage needs to be a number"] = "百分比必須是數字";
L["Store for future sessions"] = "儲存以備將來使用";
L["Unknown mutator: %s"] = "未知變異子：%s";
L["User '%s' is not allowed to start auctions"] = "不允許用戶“%s”開始拍賣";
L["User '%s' is not allowed to stop auctions"] = "不允許使用者「%s」停止拍賣";
L["User '%s' is not allowed to stop auction: auction invalid"] = "不允許使用者「%s」停止拍賣：拍賣無效";
L["There's not enough gold to distribute, expect some weird cut calculations!"] = "沒有足夠的黃金可供分配，期待一些奇怪的削減計算！";
L["No bids!"] = "沒有出價！";
L["You were outbid!"] = "你的出價被高估了！";
L["(active)"] = "（積極的）";
L["\nYou need lead or master loot to adjust gold.\nYou can't adjust gold on locked/deleted sessions"] = [[
您需要鉛或大師戰利品來調整黃金。
您無法在鎖定/刪除的會話中調整金幣]];
L["Add/Remove gold"] = "新增/刪除黃金";
L["\n%s paid |c00%s%s for\n%s"] = [[
%s 支付了 |c00%s%s 的費用
%s]]; -- Player paid 5000g for [Benediction]
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333已被 %s 刪除
原因：%s]];
L["(deleted)"] = "（已刪除）";
L["\nYou need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions"] = [[
您需要先行或主戰利品才能刪除條目。
您無法刪除鎖定/已刪除會話中的項目]];
L["Provide a reason for deleting this entry"] = "提供刪除此條目的原因";
L["Delete. Hold shift to bypass note"] = "刪除。按住 Shift 鍵可繞過音符";
L["Sessions with auctions attached to them will be deleted after 48 hours"] = "附帶拍賣的會話將在 48 小時後刪除";
L["\nYou need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions"] = [[
您需要引導或掌握戰利品才能編輯條目。
您無法編輯已刪除的條目或鎖定/刪除的會話中的條目]];
L["Export a session so others can view session details or even replace you as a loot master"] = "匯出會話，以便其他人可以查看會話詳細信息，甚至取代您作為戰利品大師";
L["Import a session from another player or account"] = "從其他玩家或帳號匯入會話";
L["\nShow a full overview of the ledger,\nideal for screenshotting purposes!"] = [[
顯示分類帳的完整概述，
非常適合截圖用途！]];
L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"] = "鎖定會話意味著您無法拍賣物品或以其他方式更改任何內容，直到您解鎖它，您確定嗎？";
L["Lock or unlock the session"] = "鎖定或解鎖會話";
L["Lock the session for payout"] = "鎖定付款會話";
L["Multi-auction: auction multiple items at once!"] = "多重拍賣：一次拍賣多個物品！";
L["added to"] = "添加到";
L["\n|c00%s%s %s pot by %s\nNote: %s"] = [[
|c00%s%s %s %s 的鍋
注意：%s]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L["removed from"] = "已經從...刪除";
L["\nPot: %s\nManagement cut (%s%%): %sg\nPer player cut (1/%s): %sg\n"] = [[
底池：%s
管理削減（%s%%）：%sg
每位玩家削減 (1/%s)：%sg
]];
L["\nYou need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions"] = [[
您需要先行或主戰利品才能恢復條目。
您無法恢復鎖定/刪除的會話條目]];
L["By %s%s | On |c00%s%s%s"] = "作者：%s%s |於 |c00%s%s%s"; -- By name<guild> on date
L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"] = "解鎖和更改底池或削減可能會變得非常混亂，特別是如果您已經支付完成。你確定嗎？";
L["Unlock the session"] = "解鎖會話";
L["No active GDKP session detected or session is not locked for payout!"] = "未偵測到活動的 GDKP 會話或會話未鎖定付款！";
L["Increment or minimum can't be lower than .0001!"] = "增量或最小值不能低於 0.0001！";
L["Invalid 'Increment' provided for item ID '%s'"] = "為項目 ID“%s”提供的“增量”無效";
L["Invalid 'Minimum' provided for item ID '%s'"] = "為項目 ID“%s”提供的“最小值”無效";
L["Either minimum or increment is required for item ID: %s"] = "項目 ID 需要最小值或增量：%s";
L["Missing header, note: it's case-sensitive!"] = "缺少標題，注意：區分大小寫！";
L["Successfully imported data for %s items"] = "已成功匯入 %s 項數據";
L["Unknown item ID: %s"] = "未知的項目 ID：%s";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.\nItems in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.\n\nWant Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!\n\n|c00FFF569Did you know?\nYou can move items around with drag and drop\nItems will be remembered, even when you |c00A79EFF/reload\nQueued items are automatically shown to raiders who have Gargul so they can prebid\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s 物品在袋子中、戰利品窗口中，甚至在聊天中的連結上，將它們添加到此拍賣隊列中。
目前拍賣完成後，隊列中的物品將自動拍賣。點擊“%s”按鈕可以防止這種情況發生。

想要 Gargul 會自動為您授予或取消拍賣嗎？打開左側的設定輪！

|c00FFF569你知道嗎？
您可以透過拖放來移動項目
即使您|c00A79EFF/重新加載，項目也會被記住
排隊的物品會自動顯示給擁有 Gargul 的攻擊者，以便他們可以預先出價
Gargul 還可以為您處理自動搶劫。使用 |c00A79EFF/gl pm 查看
]];
L["Hide unusable items"] = "隱藏不可用的物品";
L["GDKP Session"] = "GDKP 會議";
L["Editing %s"] = "正在編輯 %s";
L["Show upcoming items"] = "顯示即將推出的商品";
L["Stop the auction first!"] = "先停止拍賣吧！";
L["%s owes you %s"] = "%s欠你%s";
L["\n|c00967FD2GDKP Session\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s\n"] = [[
|c00967FD2GDKP 會議
玩家花費：%s
已給：%s
已收到：%s
球員切入：%s

%s
]];
L["Exclude from GDKP"] = "從 GDKP 中排除";
L["Gold traded will not be added to amount given or received"] = "交易的黃金不會添加到給予或接收的金額中";
L["Gold |c00967FD2given to %s"] = "金幣 |c00967FD2 已授予 %s";
L["Unable to add %s to the trade window. Try adding it manually!"] = "無法將 %s 新增至交易視窗。嘗試手動新增！";
L["You don't have enough money to pay %s"] = "您沒有足夠的錢來支付 %s";
L["To give: %s"] = "給予：%s";
L["To receive: %s"] = "接收：%s";
L["Gold |c00967FD2received from %s"] = "金幣 |c00967FD2 已從 %s 收到";
L["Check out Multi Auctions!"] = "看看多重拍賣！";
L["Follow the steps below to quickly get started with Gargul GDKP!"] = "請依照以下步驟快速開始使用 Gargul GDKP！";
L["Activate this session by clicking the |c00FFF569Enable button below!"] = "點擊下面的 |c00FFF569Enable 按鈕啟動此會話！";
L["|c00FFF569%s an item to auction or queue a single item"] = "|c00FFF569%s 一個要拍賣的物品或將單一物品排隊"; -- %s holds the auction item hotkey (default ALT_CLICK)
L["\nHelpful commands:\n- |c00FFF569/gdkp to open this window\n- |c00FFF569/gl ma to open the multi-auction window\n- |c00FFF569/gl au to open the single item auctioneer / queue\n- |c00FFF569/gl pm to set up auto-looting\n\n"] = [[
有用的命令：
- |c00FFF569/gdkp 開啟此窗口
- |c00FFF569/gl ma 打開多重拍賣窗口
- |c00FFF569/gl au 打開單品拍賣師/隊列
- |c00FFF569/gl pm 設定自動搶劫

]];
L["If all went well then you will see your freshly auctioned item(s) here!"] = "如果一切順利，那麼您將在這裡看到新拍賣的物品！";
L["Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!"] = "想同時拍賣多件物品嗎？運行|c00FFF569/gl ma（或|c00FFF569/gl multiauction）或點擊此視窗右上角的multi-auction 圖示！";
L["Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created"] = "點擊下面的 |c00FFF569New 按鈕建立您的第一個 GDKP 會話。建立後會顯示在左側";
L["You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!"] = "您已準備好出售物品了！ |c00BE3333在開始您的第一個 GDKP raid 之前，請仔細閱讀以下所有步驟並親自測試它們（無需參加 raid）！";
L["Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!"] = "想要在沒有人出價的情況下出售商品嗎？ |c00FFF569%s 的商品，選出獲勝者並設定價格！";
L["Getting started"] = "入門";
L["Unknown itemID in Auction:create: %s"] = "拍賣中的未知 itemID：建立：%s";
L["Unknown sessionIdentifier in Auction:create: %s"] = "拍賣中未知的會話識別碼：建立：%s";
L["You owe %s %s"] = "你欠 %s %s";
L["Given"] = "給定";
L["g"] = "G";
L["Group"] = "團體";
L["Group Manager"] = "集團經理";
L["Download on CurseForge"] = "在 CurseForge 上下載";
L["https://addons.wago.io/addons/gargul/versions?stability=stable"] = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L["Halt"] = "停";
L["Header"] = "標頭";
L["|c00%sGargul v%s by Zhorax@Firemaw. Type |c00%s/gl or |c00%s/gargul to get started!"] = "|c00%sGargul v%s，作者：Zhorax@Firemaw。輸入 |c00%s/gl 或 |c00%s/gargul 開始！";
L["Hide"] = "隱藏";
L["%H:%M"] = "%H:%M";
L["Visit the URL below to learn more about personalizing Gargul GDKPs"] = "請訪問下面的 URL，以了解有關個性化 Gargul GDKP 的更多信息";
L["Your logo here? Click for more info!"] = "你的標誌在這裡嗎？點擊了解更多！";
L["Import"] = "匯入";
L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"] = "匯入於 |c00A79EFF%s |c00A79EFF%s，更新於 |c00A79EFF%s |c00A79EFF%s";
L["What kind of data would you like to import?"] = "您想匯入什麼類型的資料？";
L["Import of boosted roll data successful"] = "匯入成功";
L["Inc"] = "公司";
L["Include previously awarded items"] = "包括先前授予的項目";
L["Include BOEs"] = "包括裝綁";
L["Include materials (like Abyss Crystals)"] = "包含材料（如深淵水晶）";
L["Increment"] = "增量";
L["Info"] = "資訊";
L["Invalid data supplied"] = "提供的資料無效";
L["Item"] = "物品";
L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "無法對資料進行 JSON 解碼。確保按原樣複製/貼上它，而不添加任何其他字元或空格！";
L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"] = [[
Gargul 物品熱鍵

推出： |c00A79EFF%s
獎項： |c00A79EFF%s
分解：|c00A79EFF%s


-- 右鍵單擊禁用該視窗 --
]];
L["Ledger"] = "分類帳";
L["<"] = "<";
L["You need to be the master looter or have an assist / lead role!"] = "您需要成為分裝者或團隊助理！";
L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"] = "注意：您可以隨時在設定中或透過 |c00%s/gl locale 變更區域設定";
L["deDE"] = "deDE"; -- German (Germany)
L["enUS"] = "enUS"; -- English (United States)
L["esES"] = "esES"; -- Spanish (Spain)
L["esMX"] = "esMX"; -- Spanish (Mexico)
L["frFR"] = "frFR"; -- French (France)
L["itIT"] = "itIT"; -- Italian (Italy)
L["koKR"] = "koKR"; -- Korean (Korea)
L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"] = [[
Gargul 用英文發布聊天訊息（預設）
您可以在下面的下拉選單中選擇不同的語言

您目前的聊天語言是“%s”，啟用不同的語言將導致/重新載入！
]];
L["Choose a chat language for Gargul"] = "選擇 Gargul 的聊天語言";
L["ptBR"] = "ptBR"; -- Portuguese (Brazil)
L["ruRU"] = "ruRU"; -- Russian (Russia)
L["zhCN"] = "zhCN"; -- Chinese (Simplified, PRC)
L["zhTW"] = "zhTW"; -- Chinese (Traditional, Taiwan)
L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"] = "您安裝了一個或多個插件，可能會導致 Gargul 無法正常工作：%s";
L["Clear SoftRes"] = "清除 SR";
L["Clear TMB"] = "清除 TMB";
L["/roll for MS or /roll 99 for OS"] = "主天賦需求 /roll，或是副天賦需求 /roll 99";
L["Import SoftRes"] = "匯入 SR";
L["Import TMB"] = "匯入 TMB";
L["You were given the role of Master Looter"] = "你被賦予了分裝者的角色";
L["Open this window automatically"] = "自動開啟此視窗";
L["Loot priorities cleared successfully"] = "裝備優先度已成功清除";
L["Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc"] = "提供以下格式的 prio CSV（每項 1 行）：id 或名稱 > prio1、equalprio > prio2 > 等";
L["Loot priorities imported successfully"] = "裝備優先度匯入成功";
L["Invalid data provided"] = "提供的資料無效";
L["Invalid data provided in line: '%s': missing item id or priority"] = "第「%s」行中提供的資料無效：缺少項目 ID 或優先度";
L["Attempting to process incoming loot priorities from %s"] = "正在嘗試處理來自 %s 的戰利品優先度";
L["Loot Prio"] = "裝備優先度";
L["Mail"] = "郵件";
L["Mailed"] = "郵寄";
L["Mail cut to players"] = "郵寄給玩家";
L["MS"] = "主天賦";
L["Maximize"] = "最大化";
L["Min"] = "最小";
L["Awarded loot history"] = "分裝歷史";
L["GDKP Cuts"] = "GDKP 削減";
L["Export data"] = "匯出數據";
L["Open Gargul"] = "打開 Gargul";
L["Import data"] = "匯入數據";
L["GDKP Ledger"] = "GDKP 紀錄";
L["Multiauction"] = "多重拍賣";
L["Change settings in /gl minimap"] = "更改 /gl 小地圖中的設置";
L["Minimize"] = "最小化";
L["Minimize on award"] = "分裝時最小化";
L["Minimize on start"] = "開始倒數時最小化";
L["Minimum"] = "最低限度";
L["Minimum item level"] = "最低物品等級";
L["Minimum Quality"] = "最低品質";
L["-10"] = "-10";
L["-"] = "-";
L["Move"] = "移動";
L["Multi-Auction"] = "多重拍賣";
L["Name"] = "名稱";
L["New"] = "新的";
L["Next"] = "下一個";
L["No"] = "否";
L["None"] = "無";
L["Note"] = "備註";
L["Nothing"] = "無";
L["When no one bids do:"] = "當無人出價時：";
L["You don't have officer privileges"] = "你沒有幹部權限";
L["OS"] = "副天賦";
L["Ok"] = "確定";
L["Open"] = "開啟";
L["Open Auctioneer"] = "公開拍賣師";
L["Open Multi-Auction"] = "公開多重拍賣";
L["DE"] = "DE";
L["GREED"] = "GREED";
L["IGNORE"] = "IGNORE";
L["NEED"] = "NEED";
L["PASS"] = "PASS";
L["RANDOM"] = "RANDOM";
L["RR"] = "RR";
L["SELF"] = "SELF";
L["Set %s as your disenchanter?"] = "將 %s 設定為你的祛魅者？";
L["Send %s to %s? Type /gl cd to remove this disenchanter!"] = "將 %s 發送給 %s？輸入 /gl cd 來刪除這個分解器！";
L["No disenchanter set, use /gl sd [mydisenchanter] to set one"] = "沒有設定分解器，使用 /gl sd [mydisenchanter] 設定一個";
L["Who is your disenchanter?"] = "誰是你的幻滅者？";
L["Paid"] = "有薪資的";
L["Pass"] = "放棄";
L["%"] = "%";
L["Player"] = "玩家";
L["Items won by %s:"] = "%s 贏得的物品：";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L["Plus Ones"] = "加號";
L["Add a +1"] = "添加+1";
L["Are you sure you want to broadcast your plus one data to everyone in your party/raid?"] = "您確定要將您的 +1 數據廣播給您的隊伍/團隊中的每個人嗎？";
L["Attempting to process incoming PlusOnes data from %s"] = "正在嘗試處理來自 %s 的傳入 +1 數據";
L["%s wants to clear all your PlusOne data. Clear all data?"] = "%s 想要清除您的所有 +1 資料。清除所有資料？";
L["Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?"] = "您確定要清除現有的 +1 資料並匯入 %s 廣播的新資料嗎？";
L["Are you sure you want to import new data broadcasted by %s?"] = "您確定要匯入 %s 廣播的新資料嗎？";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "提供的數據無效。確保內容遵循所需的格式並且不包含標題行";
L["\nHere you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240\n"] = [[
在這裡，您可以從 CSV 或 TSV 格式的表格或從 Google 文件表貼上的資料匯入加一資料。

表格至少需要兩列：玩家姓名，後面跟著分數。附加列將被忽略。

這是一個範例行：

福巴，240
]];
L["Automatically accept incoming broadcasts from %s"] = "自動接受來自 %s 的傳入廣播";
L["Block all incoming +1 shared data"] = "阻止所有傳入的 +1 共享數據";
L["\nAre you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
您確定要使用 %s 中的資料更新現有的 PlusOne 資料嗎？

您的最新更新是在 |c00A79EFF%s 上，他們的最新更新是在 |c00A79EFF%s 上。]];
L["!plusone|!po|!+1"] = "!plusone|!po|!+1";
L["+"] = "+";
L["Pot"] = "鍋";
L["Price"] = "價格";
L["PL"] = "PL";
L["Common"] = "普通";
L["Epic"] = "史詩";
L["Heirloom"] = "傳家寶";
L["Legendary"] = "傳奇";
L["Poor"] = "劣質";
L["Rare"] = "精良";
L["Uncommon"] = "優秀";
L["Queue"] = "佇列";
L["Raiders"] = "團隊成員";
L["Who's Missing"] = "誰失踪了";
L["Show missing player names"] = "顯示缺少的球員姓名";
L["Disband raid"] = "解散突襲";
L["Disband your raid"] = "解散你的攻擊";
L["%s is listed twice on the roster!"] = "%s 在名冊上被列出兩次！";
L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"] = "|c00FFF569Raid-Helper 匯出（使用「垂直排序的群組」變體）或 |c00FFF569Gargul 組組合 CSV：";
L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"] = [[
在下面的大編輯框中，您可以提供名單並：邀請所有人，檢查誰失踪了，應用組並分配坦克。

您可以提供 |c00FFF569Wowhead raid 組成連結：]];
L["Gargul Group Wiki"] = "加爾古爾集團維基";
L["Visit the Gargul group wiki for more info on the raid group format"] = "訪問 Gargul 組 wiki，以了解有關 raid 組格式的更多信息";
L["The following players are not part of the roster: %s"] = "以下球員不屬於名單：%s";
L["Invalid group data provided, check your format!"] = "提供的群組資料無效，請檢查您的格式！";
L["Invite"] = "邀請";
L["Send invites to players on roster"] = "向名單上的玩家發送邀請";
L["Can't sort groups while %s is in combat!"] = "當 %s 處於戰鬥狀態時無法對群組進行排序！"; -- %s holds a player name
L["You need to be in a raid!"] = "你需要參加突襲！";
L["No tanks defined"] = "沒有定義坦克";
L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"] = "找不到 %s 的位置，您是否想將 5 人以上分成 1 組？";
L["Kick unwanted players"] = "踢掉不需要的球員";
L["Kick players that aren't on the roster"] = "踢掉不在名單上的球員";
L["Something went wrong while moving %s"] = "移動 %s 時出了點問題";
L["Finished applying raid roster"] = "完成申請raid名冊";
L["Sorting groups"] = "對群組進行排序";
L["Apply Groups"] = "應用組";
L["Sort groups based on roster"] = "根據名單對組別進行排序";
L["Sorting is still in progress, wait a bit!"] = "排序還在進行中，請稍等！";
L["All tanks are assigned"] = "所有坦克均已分配";
L["Assign Tanks"] = "分配坦克";
L["Wowhead Comp Tool"] = "Wowhead 比較工具";
L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"] = "您可以使用下面的 URL 存取 wowhead comp 工具。建立組合後，您可以將其貼到此處或 Gargul 群組視窗的大型編輯欄位中";
L["Remove bid"] = "刪除出價";
L["Reset Settings"] = "重新設定";
L["Are you sure you want to reset all of Gargul's settings? This can't be undone!"] = "您確定要重設 Gargul 的所有設定嗎？這無法挽回！";
L["Reset Gargul UI"] = "重置 Gargul UI";
L["Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!"] = "您確定要重置 Gargul 的所有視窗大小、位置和比例嗎？這無法挽回！";
L["Restore"] = "回復";
L["Resume"] = "回復";
L[">"] = ">";
L["Roll"] = "Roll";
L["Award %s to %s?"] = "將 %s 分給 %s？";
L["Close on award"] = "分裝時關閉";
L["Close on start"] = "開始倒數時關閉";
L["Hold shift to bypass the award confirmation"] = "按住 shift 以略過分裝確認";
L["Hold shift to show the award confirmation"] = "按住 shift 以顯示分裝確認";
L["Warning: another identical roll was found which can point to a tie"] = [[
警告：發現了另一個相同的 roll 點，這可能代表平手

]];
L["Invalid data provided for roll start!"] = "為開始磁碟區提供的資料無效！";
L["(BR: %s)"] = "（BR：%s）";
L["(item given: yes)"] = "（給出的項目：是）";
L["(item given: no)"] = "（給出的項目：無）";
L["(OS)"] = "(副天賦)";
L["NOTE"] = "訊息";
L["Can't stop roll off, no roll off in progress"] = "無法停止 Roll 裝，無正在進行中的 Roll 裝";
L["Pass"] = "經過";
L["rolls: %s"] = "Roll 數：%s";
L["Open master looter window"] = "打開掠奪大師窗口";
L["Roll accepted!"] = "接受 Roll 點！";
L["A roll is currently in progress"] = "目前正在進行 Roll 裝";
L["Prio [%s]"] = "優先[%s]";
L["SR [%sx]"] = "SR [%sx]";
L["Wish [%s]"] = "願望[%s]";
L["You need to select a player first"] = "您需要先選擇一名玩家";
L["TIMER (s)"] = "倒數秒數";
L["You can't use this item!"] = "您不能使用該物品！";
L["The winner's name is not unique, select the player you'd like to award %s to"] = "獲獎者的名字不是唯一的，請選擇您想要將 %s 獎勵給的玩家";
L["s"] = "s";
L["Select / Disable all"] = "選擇/停用全部";
L["Session"] = "session";
L["Settings"] = "設定";
L["Announce incoming bids"] = "宣布收到的投標";
L["Announce pot after awarding item"] = "獎勵物品後宣布底池";
L["Announce auction start"] = "宣布拍賣開始";
L["Announce countdown in raid warning"] = "宣布突襲警告倒數計時";
L["Announce incoming bids in raid warning"] = "在突襲警告中宣布收到的投標";
L["Reset Gargul UI"] = "重置 Gargul UI";
L["Whisper bidder if bid is too low"] = "如果出價太低，則對投標者耳語";
L["s"] = "s";
L["Skip"] = "跳過";
L["Soft-Reserves"] = "軟儲備";
L["SR"] = "SR";
L["Are you sure you want to broadcast your softres data to everyone in your party/raid?"] = "您確定要將您的軟體資料廣播給您的隊伍/突襲中的每個人嗎？";
L["Couldn't process SoftRes data received from %s"] = "無法處理從 %s 收到的 SoftRes 數據";
L["Are you sure you want to clear all existing soft-reserve data?"] = "您確定要清除所有現有的軟保留資料嗎？";
L["Everyone filled out their soft-reserves"] = "每個人都填滿了軟儲備";
L["\nHard-reserve information is not available because the soft-reserves\nprovided were not generated using the 'Gargul Export' button on softres.it"] = [[
硬儲備資訊不可用，因為軟儲備
提供的內容不是使用 softres.it 上的「Gargul Export」按鈕產生的]];
L["Imported on |c00A79EFF%s at |c00A79EFF%s"] = "導入於 |c00A79EFF%s |c00A79EFF%s";
L["Auto name fix: the SR of '%s' is now linked to '%s'"] = "自動名稱修復：“%s”的 SR 現在連結到“%s”";
L["In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below."] = "為了開始，您首先需要在 softres.it 上建立一個 raid。然後點擊“Addon Export”，選擇“Gargul”，複製資料並將其貼上到下面的表單中。";
L["Invalid soft-reserve data provided"] = "提供的軟儲備資料無效";
L["Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here"] = "提供的數據無效。確保單擊 softres.it 上的“Gargul Export”按鈕並將完整內容貼到此處";
L["The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?"] = "提供的 PlusOne 值與已存在的值發生衝突。您想替換舊的 PlusOne 值嗎？";
L["The following players did not reserve anything:"] = "以下玩家沒有保留任何東西：";
L["Soft-reserves imported successfully"] = "軟儲備導入成功";
L["Import successful!"] = "導入成功！";
L["SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!"] = "SoftRes Weakaura 和 CSV 資料已棄用，請改用 Gargul 匯出！";
L["Failed to connect to LootReserve, contact support (include message below)"] = "無法連線到 LootReserve，請聯絡支援人員（包括下面的訊息）";
L["%s (%sx)"] = "%s (%sx)";
L["No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!"] = "沒有可用的 softres.it URL，請確保使用 softres.it 上的“Gargul Export”按鈕匯出！";
L["Click here to see hard-reserve info"] = "點擊此處查看硬預訂信息";
L["No items are hard-reserved"] = "沒有硬性保留的項目";
L["No hard-reserve info available"] = "沒有可用的硬性保留訊息";
L["Post missing SRs"] = "發布缺少的 SR";
L["Post SR URL"] = "發佈 SR 網址";
L["This player did not reserve anything!"] = "該玩家沒有保留任何東西！";
L["%s (%sx)"] = "%s (%sx)";
L["Attempting to process incoming SoftRes data from %s"] = "正在嘗試處理來自 %s 的傳入 SoftRes 數據";
L["This item is hard-reserved"] = "此商品為硬性保留商品";
L["For: %s"] = "對於：%s";
L["|c00CC2743 Note: %s"] = "|c00CC2743 注意：%s";
L["Reserved by"] = "保留者";
L["!sr|!softres|!softreserve"] = "!sr|!softres|!softreserve";
L["Something went wrong!"] = "出了點問題！";
L["Start"] = "開始";
L["Stop"] = "停止";
L["\\t is replaced by a tab"] = "\\t  is replaced by a tab";
L["TMB"] = "TMB";
L["Time"] = "時間";
L["Title"] = "標題";
L["TMB, DFT or PRIO3"] = "TMB、DFT 或 PRIO3";
L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"] = "您確定要將 TMB 資料廣播給隊伍/團隊中的每個人嗎？注意：每個人都可以看到您的 TMB 數據，無論其在 TMB 網站上的權限如何！";
L["Attempting to process incoming TMB data from %s"] = "正在嘗試處理來自 %s 的傳入 TMB 數據";
L["Are you sure you want to clear all plus one data?"] = "您確定要清除所有加一資料嗎？";
L["Clear Raider Data"] = "清除襲擊者數據";
L["Clear TMB data for all raiders?"] = "清除所有襲擊者的 TMB 資料？";
L["Auto-sharing enabled: %s"] = "自動共享已啟用：%s";
L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "在您的 classicpr.io 運行中點擊「Gargul Export」按鈕並複製內容。然後將內容原樣貼到下面的框中，然後按一下「匯入」。就是這樣！";
L["Imported on ${date} at ${time}"] = "於 ${date} ${time} 導入";
L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "依照工作表的說明匯出 DFT 資料。然後將內容原樣貼到下面的框中，然後按一下「匯入」。就是這樣！";
L["Invalid CSV provided, the format is: 6948,player1,player2"] = "提供的 CSV 無效，格式為：6948,player1,player2";
L["Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!"] = "提供的 DFT 數據無效，請按照工作表的說明匯出您的 DFT 數據，然後按原樣將內容貼到此處！";
L["Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!"] = "提供的 TMB 資料無效，請務必點擊 Gargul 部分中的「下載」按鈕並將內容原樣貼到此處！";
L["Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!"] = "提供的 TMB 或 DFT 資料無效，請確保將匯出內容按原樣貼到此處！";
L["Priority notes available: %s"] = "可用的優先註釋：%s";
L["Number of items imported: %s"] = "導入的項目數：%s";
L["The following players have no %s entries:"] = "以下玩家沒有 %s 條目："; -- %s can be TMB/DFT/CPR
L["How to use Gargul with ${source}"] = "如何將 Gargul 與 ${source} 結合使用";
L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"] = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L["Paste your TMB export contents as-is in the box below and click 'Import'"] = "將 TMB 匯出內容按原樣貼上到下面的框中，然後按一下“匯入”";
L["There's no one in your group to broadcast to"] = "您的群組中沒有人可以向其廣播";
L["TMB data synced"] = "TMB 資料已同步";
L["|c00FFFFFF    Note: |c00FFF569%s"] = "|c00FFFFFF 註： |c00FFF569%s";
L["(OS)"] = "(作業系統)";
L["%s Prio List"] = "%s 優先列表"; -- %s can be TMB/DFT/CPR
L["|c00FFFFFF    Tier: %s"] = "|c00FFFFFF 等級：%s";
L["TMB Wish List"] = "TMB 願望清單";
L["Show/Hide Dates"] = "顯示/隱藏日期";
L["Show/Hide Queue"] = "顯示/隱藏佇列";
L["%s to award loot!"] = "%s 獎勵戰利品！";
L["%s to roll out loot!"] = "%s 推出戰利品！";
L["Hide all awarded items"] = "隱藏所有得獎物品";
L["Hide disenchanted items"] = "隱藏不再抱持幻想的物品";
L["Hide items awarded to self"] = "隱藏獎勵給自己的物品";
L["Announce Trade"] = "公告交易";
L["Announce trade details to group or in /say when not in a group"] = "向群組公佈交易詳情，或在/不在群組中時公佈交易詳情";
L["Tutorial"] = "教學";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.\nWant to directly sell an item without bidding? Use |c00A79EFF%s\n\nYou can open the %s window directly by typing |c00A79EFF/gl auction\n\nGargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the \"Exclude from GDKP\" checkbox when trading!\n\n|c00FFF569Did you know?\nAwarded items will automatically be added to the trade window\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s 物品在袋子中、戰利品窗口中，甚至在聊天中的連結上，將它們添加到拍賣隊列中。
想要無需出價直接販售商品嗎？使用 |c00A79EFF%s

您可以輸入 |c00A79EFF/gl 拍賣直接開啟 %s 窗口

Gargul 追蹤 |c00FF0000 所有黃金交易。不希望交易成為此 GDKP 會議的一部分嗎？交易時勾選「從GDKP中排除」複選框！

|c00FFF569你知道嗎？
獲獎物品將自動添加到交易窗口
Gargul 還可以為您處理自動搶劫。使用 |c00A79EFF/gl pm 查看
]];
L["\nThis window shows all the items that have been awarded on any given date (select one or more dates on the left).\n\nItems can contain the following tags:\n\n|c00A79EFFOS: Awarded for offspec\n|c00A79EFFSR: This item was soft-reserved\n|c00A79EFFWL: This item was wishlisted (Thatsmybis)\n|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)\n"] = [[
此視窗顯示在任何給定日期已授予的所有項目（在左側選擇一個或多個日期）。

項目可以包含以下標籤：

|c00A79EFFOS：因不合格而獲獎
|c00A79EFFSR：此項目已軟保留
|c00A79EFFWL：此項目已列入願望清單（Thatsmybis）
|c00A79EFFPL：此專案已列入優先順序（Thatsmybis、DFT、prio3）
]];
L["\nThe items you see here are in the master looter's GDKP queue\nYou can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)\n\nYou can resize the window, move it around, or minimize it. Try it out!\n\nFor loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!\n"] = [[
您在這裡看到的物品位於主盜賊的 GDKP 隊列中
您可以刪除它們、對它們出價以及隱藏不可用的項目（在左上角的設定中啟用「隱藏不可用的項目」）

您可以調整視窗大小、移動視窗或最小化視窗。試試看！

對於戰利品大師：在這裡刪除物品只會將它們從您的個人隊列中刪除，而不是實際的 GDKP 隊列中！
]];
L["Need more help?"] = "需要更多幫助嗎？";
L["Type"] = "類型"; -- As in type of roll or type of item
L["unknown"] = "未知";
L["Unknown comm action '%s', make sure to update Gargul!"] = "未知的通訊操作“%s”，請務必更新 Gargul！";
L["Unlock"] = "解鎖";
L["Update Gargul!"] = "更新 Gargul！";
L["v"] = "v";
L["Report"] = "報告";
L["Report outdated results in group chat"] = "在群組聊天中報告過時的結果";
L["Gargul status"] = "Gargul 狀態";
L["Checking version ..."] = "檢查版本...";
L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"] = [[
|c0092FF00v%s：播放器是最新的
|c00F7922Ev%s：玩家需要更新他的附加元件
|c00BE3333%s：玩家沒有 Gargul 或使用不支援的版本
|c00808080%s：玩家離線或忽略我們！
|c0000FFFF%s：該玩家在我們的忽略清單中！

]];
L["PLAYER IGNORED!"] = "玩家被忽略！";
L["Offline"] = "離線";
L["No response"] = "沒有反應";
L["No response:"] = "沒有反應：";
L["Offline:"] = "離線：";
L["Outdated:"] = "過時的：";
L["Up-to-date:"] = "最新：";
L["Gargul is out of date and won't work until you update!"] = "Gargul 版本過舊，更新後才能使用！";
L["Invalid version string provided in Version:addRelease"] = "Version:addRelease 中提供的版本字串無效";
L["Update Gargul!"] = "更新 Gargul！";
L["|c00%sGargul is now updated to |c00%sv%s"] = "|c00%sGargul 現已更新為 |c00%sv%s";
L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"] = "|c00A79EFFv%s 可在 CurseForge/Wago 上使用。您可以在不關閉遊戲的情況下進行更新，只需確保 /reload ！";
L["Wait %s more seconds before you retry"] = "再重試之前請再等 %s 秒";
L["Window"] = "視窗";
L["Gargul v%s"] = "Gargul v%s";
L["Window Scale"] = "窗秤";
L["WL"] = "WL";
L["Yes"] = "是";
L["You disabled GDKP queues"] = "您禁用了 GDKP 佇列";
L["0"] = "0";
L["Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf"] = "無法使用 zlib 壓縮資料。透過 https://discord.gg/D3mDhYPVzf 聯繫支援人員";
L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "無法解壓縮 zlib 資料。確保按原樣複製/貼上它，而不添加任何其他字元或空格！";
