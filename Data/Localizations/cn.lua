--[[
    You can test this locally by removing line 8:
    if (GetLocale() ~= "zhCN") then return; end

    These translations where provided by
        - Skywardpixel
        - Takaqiao
]]
if (GetLocale() ~= "zhCN") then return; end
local L = Gargul_L or {};

L["About"] = "关于";
L["All Settings"] = "所有设置";
L["Announce"] = "公示";
L["Anti Snipe"] = "防偷鸡倒数";
L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"] = [[

防偷鸡倒数值为 10 意味着任何出价
剩余时间少于 10 秒会将计时器重置回 10 秒

您可以将此留空或设置为 0 以完全禁用防偷鸡。
不支持小于 5 的防偷鸡倒数值

]];
L["Are you sure?"] = "是否确定？";
L["\nDon't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --"] = [[
不要忘记使用 Gargul 代替
如果你想稍后导出战利品

-- 右键单击禁用该窗口 --]];
L["Auction"] = "拍卖";
L["Auctioneer"] = "拍卖师";
L["Auctions"] = "拍卖物";
L["Auto"] = "自动";
L["Auto award"] = "自动分配";
L["Auto trade"] = "自动交易选项";
L["Available values:"] = "可用值：";
L["Award"] = "分配";
L["Awarded To"] = "分配给";
L["BR: %s"] = "BR：%s";
L["Price: %s"] = "价格";
L["Given: yes"] = "给出：成功";
L["Given: no"] = "给出：失败";
L["2nd bid: %s by %s"] = "出价第二高：%s，%s";
L["You won"] = "你赢了";
L["Award %s to %s?"] = "将 %s 分配给 %s？";
L["Are you sure you want to disenchant %s? %s boosted roll points will be refunded!"] = "您确定要分解%s吗？ %s BR点数将被退还！";
L["In Group"] = "组内";
L["Award history"] = "分配历史";
L["Who should %s go to instead?"] = "%s 将重新分配给谁？";
L["Type player name here"] = "输入玩家ID";
L["or select one below"] = "或者从下面选择ID";
L["Do you want to award %s to a random player?"] = "是否将 %s 随机分配给团员？";
L["Drag and drop or shift+click an item in the box on the right"] = "拖动或者按住 Shift 键+左键单击右侧框中的项目";
L["(BR: %s)"] = "（BR：%s）";
L["Disenchanted items:"] = "分解物品：";
L["(Given: yes)"] = "（给出：成功）";
L["(Given: no)"] = "（给出：失败）";
L["(OS)"] = "（副天赋）";
L["%s boosted roll points will be refunded!"] = "%s BR点数将被退还！";
L["Are you sure you want to undo %s awarded to %s?%s"] = "您确定要撤消分配 %s 的 %s 奖励吗？%s"; -- The last %s is the content of L["%s boosted roll points will be refunded!"]
L["Bag inspection failed: no reports received"] = "背包检查失败：未发现物品";
L["Inspection finished"] = "检查完毕";
L["Starting inspection..."] = "开始检查...";
L["Balance"] = "收支";
L["Base"] = "基础工资";
L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "无法对数据进行 Base64 解码。确保按原样复制/粘贴它，而不添加任何其他字符或空格！";
L["Bid"] = "出价";
L["Bids"] = "出价";
L["BOE"] = "装绑物品";
L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"] = "1.从团队中自动邀请/排序组！单击下面或使用 |c00A79EFF/gl gr";
L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"] = "2. 奖励固定团员或额外付出的玩家！单击下面或使用 |c00A79EFF/gl br";
L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"] = "Gargul 有一些你可能不知道的技巧。来看看吧！";
L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"] = "3. Gargul 包含MS>OS roll点 +1追踪系统！单击下面或使用 |c00A79EFF/gl po";
L["Boosted Rolls"] = "Boosted Rolls";
L["BR"] = "BR";
L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"] = [[
为当前团队中的每个人添加多少积分？

|c00BE3333如果您希望每个人都获得积分，即使是那些没有BR资格的人，请首先使用“添加缺失的团队成员”按钮！]];
L["No point value provided!"] = "不提供积分值！";
L["Add points to raid"] = "为团队添加积分";
L["Add missing raiders"] = "添加缺失的团队成员";
L["Aliases"] = "别名";
L["Apply aliases"] = "应用别名";
L["Boosted Roll Cost:"] = "BR成本：";
L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"] = "您确定要将BR数据广播给队伍/团队中的每个人吗？";
L["Nothing to broadcast, import Boosted Rolls data first!"] = "无数据，请先导入 Boosted Rolls 数据！";
L["Couldn't process BoostedRolls data received from %s"] = "无法处理从 %s 收到的 BoostedRolls 数据";
L["Attempting to process incoming BoostedRolls data from %s"] = "正在尝试处理来自 %s 的传入 BoostedRolls 数据";
L["Are you sure you want to clear all boosted roll data?"] = "您确定要清除所有BR数据吗？";
L["Delete %s?"] = "删除%s？";
L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"] = "您确定要清除现有的BR数据并导入 %s 广播的新数据吗？";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "提供的数据无效。确保内容遵循所需的格式并且不包含标题行";
L["\nHere you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo"] = [[
在这里，您可以从 CSV 或 TSV 格式的表格或从 Google 文档表粘贴的表格导入BR数据和别名。

该表至少需要两列：玩家姓名，后跟分数。附加列是可选的，并且可能包含玩家的别名。
这是一个示例行：

Foobar,240,Barfoo]];
L["Points"] = "积分";
L["Points: %s"] = "积分：%s";
L["N/A"] = "未知";
L["Reserve"] = "指定";
L["\nAre you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
您确定要使用 %s 的数据更新现有的BR吗？

您的最新更新是在 |c00A79EFF%s 上，他们的最新更新是在 |c00A79EFF%s 上。]];
L["!bonus|!rb|!br"] = "!奖金|!rb|!br";
L["Broadcast"] = "通告";
L["Broadcasting..."] = "通告中...";
L["You are currently in combat, delaying broadcast"] = "您目前正处于战斗状态，延迟通告";
L["Broadcast finished!"] = "通告完毕！";
L["Include awarded items"] = "包括分配物品";
L["Include disenchanted items"] = "包括分解的物品";
L["Include hidden items"] = "包括隐藏项目";
L["Include time left"] = "包括剩余时间";
L["Broadcast still in progress"] = "通告仍在进行中";
L["There is nothing to broadcast"] = "没有什么可通告的";
L["Number of items"] = "物品数量";
L["Broadcast ${percentage}%"] = "广播${percent}%";
L["Target player (whisper only)"] = "目标玩家（仅私聊）";
L["Whisper requires a target player"] = "私聊需要目标玩家";
L["Max trade time left (in minutes)"] = "剩余最大交易时间（分钟）";
L["by"] = "从"; -- As in 'bid BY'
L["Cancel"] = "取消";
L["Get support or share ideas on our Discord"] = "在我们的 Discord 上获取支持或分享想法";
L["Enable changelog"] = "启用更新日志";
L["Gargul makes handing out loot super easy, click the button below to get started!"] = "Gargul 让分发战利品变得超级简单，点击下面的按钮即可开始！";
L["Open Gargul"] = "打开Gargul";
L["Adjust Scale"] = "调整比例";
L["Channel"] = "频道";
L["Officer"] = "官员频道";
L["Raid Warning"] = "团队频道";
L["Whisper"] = "私聊频道";
L["CPR"] = "CPR";
L["Clear"] = "清除"; -- As in clearing a window or data
L["Close"] = "关闭";
L["Close on award"] = "分配时关闭";
L["Close on start"] = "开始时关闭";
L["Communication"] = "通信";
L["Sent %s of %s bytes"] = "已发送 %s 个字节，共 %s 个字节";
L["c"] = "C";
L["Cut"] = "工资";
L["Cuts"] = "结账";
L["Can't send mail when the mailbox is closed"] = "邮箱关闭后无法发送邮件";
L["Multiple mail errors detected, aborting cut distribution"] = "检测到多个邮件错误，中止工资分发";
L["You don't owe %s any gold"] = "你不欠%s任何金币";
L["Failed to send cut to %s"] = "无法将工资发送至 %s";
L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"] = "邮件已根据分配结果发送，但您剩余的金币！不匹配！，是不是出了什么问题？";
L["Mail History for |c00967FD2%s"] = "|c00967FD2%s 的邮件历史记录";
L["You don't have enough gold to pay %s"] = "您没有足够的金币来支付 %s";
L["Wait a bit, we're still processing the previous mail"] = "稍等一下，我们还在处理之前的邮件";
L["Gargul GDKP: %sg"] = "Gargul GDKP：%sg";
L["Sent %sg to %s"] = "已发送 %sg 至 %s";
L["%Y-%m-%d"] = "%Y-%m-%d";
L["%Y-%m-%d %H:%M"] = "%Y-%m-%d %H:%M";
L["%d-%m %H:%M"] = "%d-%m %H:%M";
L["Delete"] = "删除";
L["Details"] = "细节";
L["DFT"] = "DFT";
L["Disable"] = "禁用";
L["https://discord.gg/D3mDhYPVzf"] = "https://discord.gg/D3mDhYPVzf";
L["Disenchant"] = "分解";
L["Edit"] = "编辑";
L["Enable"] = "激活";
L["Export"] = "导出";
L["Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!"] = "您确定要删除完整的分配历史记录表吗？这将删除所有战利品数据并且无法撤消！";
L["Are you sure you want to remove all data for %s? This cannot be undone!"] = "您确定要删除 %s 的所有数据吗？这不能撤消！";
L["\nThis is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n"] = [[
这只是导出功能，没有必要编辑任何值：它们不会被保存！

]];
L["Fill"] = "加入";
L["Final Call"] = "最终机会";
L["Finish"] = "结束";
L["Format"] = "格式";
L["Gargul"] = "Gargul";
L["GDKP"] = "GDKP";
L["GDKP raids are not allowed in this version of World of Warcraft"] = "此版本的魔兽世界不允许 GDKP 模式";
L["GDKP Active!"] = "GDKP 启动！";
L["Add dropped loot to queue"] = "将掉落的战利品添加到队列中";
L["Gold (- for removing gold)"] = "价格（- 用于扣减价格）";
L["Who pays for this?"] = "谁付钱？";
L["Gold needs to be lower/higher than 0"] = "黄金需要低于/高于 0";
L["Paid for by"] = "支付方：";
L["Adjust gold in %s"] = "调整 %s 的价格";
L["You can't give AND receive gold from the same player at the same time"] = "您不能同时从同一玩家处给予和接收金币";
L["All cuts were mailed!"] = "所有工资均已邮寄！";
L["Disable for disenchanted"] = "分解禁用";
L["Disable in combat"] = "战斗中禁用";
L["Auctions"] = "拍卖";
L["Created by"] = "由...制作";
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333已被 %s 删除
原因：%s]];
L["\n|c00%s%s added to pot by %s\nNote: %s"] = [[
|c00%s%sg 由 %s 添加到底池中
注意：%s]];
L["Won by"] = "获胜者：";
L["Set paid amount (read left)"] = "设置支付金额（左）";
L["\n\nGargul automatically keeps track of gold traded. As long as players pay\nfor what they bought then you shouldn't ever need this field\n\n'Paid amount' refers to the amount of gold the buyer already traded you.\nThis does not change the actual price of the item!\n\nWarning: only set a value here if the player promises to pay\noutside of the raid or trades the gold from an alt / mail etc!\n\n\n"] = [[

Gargul 自动跟踪金币交易。只要玩家已经支付了
他们购买的东西所需的金币，那么你就不需要看这段文字

“支付金额”是指买家已经向您交易的金币数量。
这不会改变商品的实际价格！

警告：仅当玩家承诺付款时才在此处设置值
在团队之外或通过小号交易/邮件等交易金币！


]];
L["GDKP Price:"] = "GDKP 价格：";
L["Award %s to %s for %s?"] = "分配 %s 给 %s, 价格为 %s？";
L["Auto Bid"] = "自动出价";
L["What's your maximum bid? (Minimum %s|c00FFF569g)"] = "您的最高预期出价是多少？ （最小 %s|c00FFF569g）";
L["Bid denied!"] = "竞拍被拒绝！";
L["Min bid: %sg   Increment: %sg"] = "最低出价：%sg 增量：%sg";
L["(max %sg)"] = "（最大 %sg）";
L["New bid"] = "新出价";
L["Stop Auto Bid"] = "停止自动出价";
L["Top bid: %s by %s"] = "最高出价：%s，来自 %s";
L["Top bid: %s by you"] = "最高出价：%s 由您出价";
L["Create a new GDKP session"] = "创建新的 GDKP 账单";
L["Management Cut %"] = "管理费用 %";
L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"] = "管理费用需要为空或介于 0 到 99 之间（没有 % 符号！）";
L["Choose a session type!"] = "选择拍卖类型！";
L["Switch to this session"] = "切换到此账单";
L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"] = [[

|c00A79EFF 多重拍卖允许您一次对多个物品开始出价，从而加快速度！
创建此会话后按照说明开始操作

使用 |c00A79EFFSingle-Auction，您可以选择拍卖单个物品或使用队列

选择 |c00A79EFF 多重拍卖可防止将已丢弃的项目添加到队列中
您可以将 |c00A79EFFMulti-Auction 与 |c00A79EFFSingle-Auction 和队列混合使用，但我们强烈建议不要这样做

]];
L["Auction type (|c00A79EFFi for more info)"] = "拍卖类型（|c00A79EFFi 了解更多信息）";
L["Multi-Auction"] = "多物品拍卖";
L["Single-Auction"] = "单物品拍卖";
L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"] = "会话已创建。我们建议您 /reload 以便正确存储它，以防您的游戏崩溃！";
L["Add Raider"] = "添加团队成员";
L["adjust [g]"] = "调整[g]";
L["adjust [%]"] = "调整 [%]";
L["Announce the base cut in group chat"] = "在群聊中宣布管理费用";
L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"] = "您确定要重置所有玩家和计算吗？注意：所有不再参与团队的玩家都将从列表中删除！";
L["Delete Raider"] = "删除团队成员";
L["Edit Raider"] = "编辑团队成员";
L["Lock and Pay"] = "锁定并付款";
L["Manage gold trades"] = "管理金币交易";
L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"] = [[

通过补助管理，你可以给玩家更多或更少的金币
示例：为坦克提供 2% 的额外补助！

注意：在此处编辑或删除补助管理只会更改此账单的补助
]];
L["Not in the raid"] = "不在团队中";
L["\n\nThe total payout can differ slightly from the pot due to rounding differences!\nPlayers currently in the raid can not be edited or removed!\n\nColor explanation:\n|c00F7922E(2000g) Means you owe this person 2000g\n|c00BE3333(3000g) Means this person owes you 3000g\n|c0092FF00(0) Means that you're square\n\nAdjuster explanation:\nWith adjust [g] you can add/deduct gold to a player (use -50 to deduct 50 gold from a player's cut)\nWith adjust [%] you can add/deduct a percentage to a player (use -50 to give players a half cut)\n"] = [[

由于四舍五入的差异，总工资可能与总底池略有不同!
当前在副本中的玩家不能被编辑或删除!

Color explanation:
|c00F7922E(2000g) 你欠该玩家 2000g
|c00BE3333(3000g) 该玩家欠你 3000g
|c0092FF00(0) 已结清

Adjuster explanation:
使用adjust [g] 你可以给玩家增加/减少金币(使用 -50,从玩家的工资中扣除50金币)
使用adjust [%] 你可以给球员增加/减少一定的百分比(使用-50来给该玩家工资减半)
]];
L["%s Raiders | %s With cut | Total payout: %s"] = "%s 团员 | %s 已结清|总支出：%sg";
L["Nothing to import, double check your CSV"] = "无任何内容导入，请仔细检查您的 CSV";
L["Missing gold for player %s"] = "%s 尚未付款";
L["Missing header, note: it's case-sensitive!"] = "缺少标题，注意：区分大小写！";
L["Missing player name"] = "缺少成员姓名";
L["Delete bid. Auction must be stopped first!"] = "删除出价。必须先停止拍卖！";
L["Add a raider to this session"] = "将团员添加到此账单";
L["Custom (create your own format)"] = "自定义（创建您自己的格式）";
L["Detailed (JSON)"] = "详细（JSON）";
L["Share (can be imported by other players)"] = "分享（可以被其他玩家导入）";
L["Your custom format"] = "您的自定义格式";
L["Your custom header"] = "您的自定义标题";
L["Custom (create your own format)"] = "自定义（创建您自己的格式）";
L["@PLAYER,@CUT"] = "@玩家，@工资";
L["Player,Cut"] = "玩家、工资";
L["date/time at which the session was locked"] = "会话被锁定的日期/时间";
L["total gold given to the player"] = "给予玩家的总金币";
L["gold mailed to the player"] = "金币邮寄给玩家";
L["total gold received from the player"] = "从玩家处收到的总金币";
L["date/time at which the first item was awarded"] = "第一件物品被分配的日期/时间";
L["gold traded to the player"] = "交易给玩家的金币";
L["@ITEM,@WINNER,@GOLD,@WOWHEAD"] = "@ITEM、@WINNER、@GOLD、@WOWHEAD";
L["Item,Player,Gold,Wowheadlink"] = "物品、玩家、金币、Wowheadlink";
L["Date/time at which the first item was awarded"] = "第一个物品被分配的日期/时间";
L["The title of the GDKP session"] = "GDKP 账单标题";
L["Pot changed"] = "底池更换";
L["Gold Trades"] = "黄金交易";
L["Include disenchanted items"] = "包括不再抱有幻想的物品";
L["Are you sure? You won't be able to see, or bid on, upcoming items!"] = "确定吗？您将无法对即将竞拍的物品查看和出价！";
L["\n|c00BE3333!! WARNING !!|r\n\nYou're on a connected realm and are importing player names without\na realm suffix, '%s' for example. This can cause you to send\ncuts and cut mails to the wrong player.\n\nWhen on a connected realm always try to include the realm name of players!\n\nContinue importing?\n"] = [[
|c00BE3333!!警告！！|r

您目前在一个互通的服务器，并且正在导入玩家姓名（无服务器），例如“%s”。这可能会导致您将工资发送给错误的玩家。
当处于互通的服务器时，请始终尝试包含玩家的服务器名称！
继续导入吗？
]];
L["This will override any changes you've made to the cut window, are you sure?"] = "这将覆盖您对剪切窗口所做的任何更改，您确定吗？";
L["\nYou can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!):\n\n|c00BE3333Player,Gold|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n"] = [[
您可以从自己的计算中导入成员工资，例如谷歌表格。软件 GDKP 等

格式如下（|c00BE3333INCLUDE THE HEADER！！）：

|c00BE3333Player，黄金|c00967FD2
玩家1,4000
玩家2,4125
玩家3,3998


]];
L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"] = [[
导入 GDKP 最低价格和增量。

格式如下：物品ID + 最小值或增量为必填项。 （|c00BE3333需要标题！！）：

|c00BE3333ItemID，最小值，增量|c00967FD2
18608,4000,500
]];
L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"] = "删除现有的价格设置？单击“是”删除所有价格数据，单击“否”则使用您在此处提供的数据覆盖现有价格数据";
L["Import GDKP Session"] = "导入 GDKP 账单";
L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"] = "您可以在此处导入（并继续）GDKP 账单。为了从其他人处获得 GDKP 账单，他们需要将其导出到 |c00FFF569/gdkp，其中他们选择“共享（可以由其他玩家导入）”格式";
L["You're about to import a GDKP session created by %s, are you sure?"] = "您即将导入由 %s 创建的 GDKP 账单，您确定吗？";
L["This GDKP session created by %s appears to exist already, do you wish to override it?"] = "%s 创建的 GDKP 账单似乎已存在，您要覆盖它吗？";
L["Invalid data provided for GDKP extension!"] = "为 GDKP 扩展提供的数据无效！";
L["Invalid data provided for GDKP reschedule!"] = "为 GDKP 重新安排提供的数据无效！";
L["Invalid data provided for GDKP shortening!"] = "为 GDKP 缩短提供的数据无效！";
L["Invalid data provided for GDKP auction start!"] = "为 GDKP 拍卖开始提供的数据无效！";
L["Invalid number provided for 'paid'"] = "为“付款”提供的数量无效";
L["Invalid time provided in Auction:reschedule"] = "拍卖中提供的时间无效：重新安排";
L["\n\n|c00967FD2GDKP Data (sold %sx)\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n\n"] = [[

|c00967FD2GDKP 数据（已售出 %sx）
最终价格：%s
平均价格：%s
初始价格：%s
增量：%s

]];
L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"] = "余额： |c0092FF000 ？已结清！ | |c00BE333330 ？你欠 %s 30g | |c00F7922E50 ？ %s欠你50g";
L["Gold mailed to you by %s"] = "金币已由 %s 邮寄给您";
L["Gold paid to %s"] = "金币支付给%s";
L["Gold received from %s"] = "从 %s 收到金币";
L["Gold %s by"] = "金币 %s 由"; -- %s = removed or added
L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"] = "总底池：%sg |管理费用：%sg (%s%%) |分发：%sg";
L["|c00967FD2%s | By %s%s | On |c00967FD2%s"] = "|c00967FD2%s |作者：%s%s |于 |c00967FD2%s";
L["The GDKP Session is not available or locked"] = "GDKP 账单不可用或已锁定";
L["Mail All"] = "全部邮寄";
L["No bids on Legendary+ item detected, continue manually!"] = "未检测到橙色物品的出价，请手动继续！";
L["Missing content in Auction:start"] = "竞拍开始中缺少内容";
L["\n\nWith multi auctions (or batch auctions) you can auction off as many items as you want at once!\nThis speeds up your raid nights immensely and makes for a seamless experience for your raiders\n\nAll tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'\nGive it a shot!\n\n|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!\n\n"] = [[

通过批量竞拍，您可以一次拍卖任意数量的物品！
这极大地加快了你的团队效率，并为你的团员提供了丝滑的体验

库存中的所有可交易物品都可以通过“从库存填充”自动拍卖
试一试！

|c00808080只有一个缺点：团员需要安装 Gargul！

]];
L["You need to have an active (unlocked) GDKP session!"] = "您需要有一个解锁的GDKP账单！";
L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"] = "打开此窗口后，将 %s 件商品添加到列表中或点击下面的“从库存填充”"; -- %s holds the add item hotkey (default ALT_CLICK)
L["Anti snipe in seconds"] = "防偷鸡倒数";
L["The anti snipe value needs to be 0 (empty) or >=5"] = "防偷鸡倒数需要为0（空）或>=5";
L["Go back to the item selector"] = "返回账单选择";
L["Remove all items from the list"] = "从列表中删除所有账单";
L["Fill from inventory"] = "从库存中填充";
L["Add tradeable items from your inventory to the list"] = "将库存中的可交易物品添加到列表中";
L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"] = [[
您可以在此处确定要包含在多重拍卖会话中的物品

使用下面的 |c00A79EFFFFill from inventory 按钮将仍可交易的物品添加到列表中
每当您清除并重新打开此窗口时，您最后的填充设置将用于自动添加项目

|c00A79EFF%s 项手动将其添加到列表中
]];
L["Next step: check raider's add-on version for compatibility"] = "下一步：检查 raider 的附加版本的兼容性";
L["Not everyone is using Gargul, are you sure you want to start the auction?"] = "不是每个人都在使用 Gargul，您确定要开始拍卖吗？";
L["Select at least one item for your auction"] = "至少选择一件物品进行拍卖";
L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"] = "您的 Gargul 已过时，我们建议在开始竞拍之前进行更新，以防止出现问题！";
L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"] = "并不是每个人都是最新版本。如果遇到问题，请告诉您的团员进行更新！";
L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"] = "有一个正在进行的批量竞拍，您在此处添加的物品将被添加到现有竞拍队列中。请注意重复的项目！";
L["Search name or iLVL"] = "搜索名称或 iLVL";
L["Supports item names and iLVL e.g. '252', '<252' etc"] = "支持物品名称和 iLVL，例如“252”、“<252”等";
L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"] = "活动 GDKP 会话： |c00967FD2%s |作者：%s%s |于 |c00967FD2%s";
L["Auction time in seconds"] = "拍卖时间（秒）";
L["The auction time in seconds needs to be >= 10"] = "拍卖时间（以秒为单位）需要 >= 10";
L["You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items"] = "您在 GDKP 竞标期间剩下的物品。为了恢复竞拍，您必须为任何未售出的物品提供新的出价时间（以秒为单位）";
L["With this window open, %s items to add them to the list"] = "打开此窗口后，将 %s 个物品添加到列表中";
L["Click the cogwheel icon to manage an auction"] = "单击齿轮图标来管理拍卖";
L["You're already the top bidder on %s"] = "您已经是 %s 的最高出价者";
L["Bid |c00%s%sg\nBy %s"] = [[
出价 |c00%s%sg
买家：%s]];
L["|c00%sCLOSED\nNo bids"] = [[
|c00%s已关闭
无人出价]];
L["Minimum: |c00%s%sg\nIncrement: |c00%s%sg"] = [[
增价：|c00%s%sg
：|c00%s%sg]];
L["Items: %s  -  Total sold: %sg  -  Pledged by me: %sg"] = "物品数量：%s - 总售价：%sg - 我承诺的：%sg";
L["Items with bids: %s/%s\nTotal sold: %s\nBought by me: %s\nTotal bid (does not include sold): %s\nBid by me (does not include sold): %s\n"] = [[
已拍装备：%s/%s
总售价：%s
我买的：%s
总出价（不包括已售出）：%s
我出价（不包括已售出）：%s
]];
L["|c00%sSOLD to%s\nfor |c00%s%s"] = [[
|c00%s出售给
%s 价格为： |c00%s%sg]];
L["Bid |c00%s%s\nBy |c0092FF00YOU!"] = [[
出价 |c00%s%sg
出价人：|c0092FF00YOU！]];
L["Could not stop auto bidding on %s, try again or /reload!"] = "无法停止 %s 的自动出价，请重试或/reload！";
L["Auto bid up to a maximum of %sg"] = "自动竞拍最高价 %sg";
L["Auto bid up to the bid you fill in on the left"] = "自动竞拍，在左侧填写最高价";
L["Stop your auto bid (%sg)"] = "停止自动竞拍 (%sg)";
L["Bid on %s could not be confirmed"] = "无法确认 %s 的竞拍";
L["Invalid bid or bid is too low! The minimum is %sg"] = "竞拍无效或出价过低！最小值为 %sg";
L["You need to wait two seconds between bids on the same item"] = "同一商品的两次竞拍之间需要等待两秒钟";
L["Clear bids"] = "清除出价记录";
L["Remove all bids from the auction"] = "从拍卖中删除所有出价";
L["Close all"] = "关闭所有";
L["Close ALL auctions?"] = "关闭所有拍卖？";
L["Close ALL auctions\n\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
关闭所有竞拍

具有有效竞拍的物品将被出售，并且无法接受新的竞拍！
]];
L["Close Auction"] = "结束拍卖";
L["Close the auction. Players can no longer bid but the highest bid remains active"] = "结束拍卖。玩家不能再出价，但最高出价仍然有效";
L["Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!"] = "从拍卖中移除该物品，包括其竞拍详细信息。这无法挽回！";
L["Disenchant all finished but unsold items?"] = "分解所有已完成拍卖但未售出的物品？";
L["Disenchant unsold items\n\nThis will mark all unsold items as disenchanted and they will not show up in a new multi-auction session"] = [[
分解未售出的物品

这会将所有未售出的物品标记为已分解，并且它们不会出现在新的批量拍卖中
]];
L["Favorite this item"] = "收藏该物品";
L["Give a final call timer of how many seconds?"] = "最终Call计时器设置为倒数多少秒？";
L["The minimum amount of seconds is 5"] = "最小秒数为 5";
L["Start a final call for this auction by giving a (usually shorter) bid timer"] = "通过提供（通常较短的）出价倒数来开始本次拍卖的最终Call";
L["Close ALL auctions and wrap up this multi-auction session?"] = "关闭所有拍卖并结束本次批量拍卖？";
L["Finish Multi-Auction session\n\nThis will close all auctions and announce the total pot in chat\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
完成批量拍卖环节

这将关闭所有拍卖并在聊天频道中公布总底池
具有有效出价的拍卖将被出售，并且无法接受新的出价！
]];
L["Hide inactive"] = "隐藏非激活物品";
L["Hide unusable"] = "隐藏不可用物品";
L["Show/Hide finished auctions"] = "显示/隐藏已完成的拍卖";
L["Manage Auction"] = "管理拍卖";
L["Bid the minimum required amount"] = "按最低要求金额竞拍";
L["Bidding window closed, use |c00A79EFF/gl bid to reopen it!"] = "竞拍窗口已关闭，请使用 |c00A79EFF/gl bid 重新打开！";
L["Announce sales in chat"] = "在聊天中宣布销售情况";
L["Play sound when outbid"] = "被顶价时播放声音";
L["More sound options..."] = "更多声音选项...";
L["Show all"] = "显示所有";
L["Show favorites"] = "显示我的最爱";
L["Show inactive"] = "显示非激活物品";
L["Show unusable"] = "显示不可用物品";
L["This item was sold. Use ledger (|c00%s/gdkp) to make changes!"] = "该商品已售出。使用分类帐（|c00%s/gdkp）进行更改！";
L["Terminate"] = "终止";
L["Remove all bidsl bids and close all auctions?"] = "删除所有 bidsl 出价并结束所有拍卖？";
L["Terminate Multi-Auction session\n\nThis will delete all bids on items that haven't sold yet and close all auctions!"] = [[
终止批量拍卖

这将删除尚未售出的物品的所有出价并关闭所有拍卖！
]];
L["Hover over any of the buttons below for more information"] = "将鼠标悬停在下面的任何按钮上以获取更多信息";
L["Show/Hide items you can't use"] = "显示/隐藏您无法使用的项目";
L["Invalid data provided for GDKP auction start!"] = "为 GDKP 拍卖开始提供的数据无效！";
L["%s bought %s for %s"] = "%s 为 %sg 花费了 %s";
L["The loot master (%s) is outdated, this can cause bids to fail!"] = "loot master (%s) 已过时，这可能会导致出价失败！";
L["You were outbid!"] = "你被超了！";
L["Mutators"] = "补助项";
L["Add Mutator"] = "添加补助项";
L["Auto apply to"] = "自动应用于";
L["Create a new GDKP mutator"] = "创建一个新的 GDKP 补助项";
L["Delete. Hold shift to bypass confirmation"] = "删除。按住shift跳过确认";
L["Edit mutator"] = "编辑补助项";
L["Flat gold rate [example: 250]"] = "固定价格 [示例：250]";
L["The flat rate needs to be a number"] = "固定价格必须是数字";
L["\nExample:\n|c00967FD2SELF,RL,HEALER"] = [[
例子：
|c00967FD2本人，团长，治疗]];
L["You can automatically apply this mutator to raiders using keywords:"] = "您可以使用关键字自动将此补助项应用于团员：";
L["Name [example: Tanks]"] = "名称 [示例：坦克]";
L["Mutator names can not contains dots (.)"] = "补助项名称不能包含点 (.)";
L["Percentage [example: 10]"] = "百分比 [示例：10]";
L["The percentage needs to be a number"] = "百分比必须是数字";
L["Store for future sessions"] = "保存以备将来使用";
L["Unknown mutator: %s"] = "未知补助项：%s";
L["User '%s' is not allowed to start auctions"] = "不允许用户“%s”开始竞拍";
L["User '%s' is not allowed to stop auctions"] = "不允许用户“%s”停止竞拍";
L["User '%s' is not allowed to stop auction: auction invalid"] = "不允许用户“%s”停止竞拍：竞拍无效";
L["There's not enough gold to distribute, expect some weird cut calculations!"] = "没有足够的金币可供分配，可能工资结算出错了！";
L["No bids!"] = "没有出价！";
L["You were outbid!"] = "你被超了！";
L["(active)"] = "（激活）";
L["\nYou need lead or master loot to adjust gold.\nYou can't adjust gold on locked/deleted sessions"] = [[
您需要作为团队领袖/拍卖师来调整价格。
您无法在锁定/删除的账单中调整价格]];
L["Add/Remove gold"] = "添加/删除价格";
L["\n%s paid |c00%s%s for\n%s"] = [[
%s 支付了 |c00%s%s 的费用
%s]]; -- Player paid 5000g for [Benediction]
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333已被 %s 删除
原因：%s]];
L["(deleted)"] = "（已删除）";
L["\nYou need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions"] = [[
您需要作为团队领袖/拍卖师才能删除条目。
您无法删除锁定/已删除账单中的条目]];
L["Provide a reason for deleting this entry"] = "提供删除此条目的原因";
L["Delete. Hold shift to bypass note"] = "删除。按住 Shift 键可跳过文字信息";
L["Sessions with auctions attached to them will be deleted after 48 hours"] = "附带拍卖的账单将在 48 小时后删除";
L["\nYou need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions"] = [[
您需要作为团队领袖/拍卖师才能编辑条目。
您无法编辑已删除的条目或查看锁定/删除的账单中的条目]];
L["Export a session so others can view session details or even replace you as a loot master"] = "导出账单，以便其他人可以查看账单详细信息，甚至取代您作为拍卖师";
L["Import a session from another player or account"] = "从其他玩家或帐户导入账单";
L["\nShow a full overview of the ledger,\nideal for screenshotting purposes!"] = [[
显示最终账单的完整概述，
非常适合截图用途！]];
L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"] = "锁定账单意味着您无法拍卖物品或以其他方式更改任何内容，直到您解锁它，您确定吗？";
L["Lock or unlock the session"] = "锁定或解锁账单";
L["Lock the session for payout"] = "锁定账单并发工资";
L["Multi-auction: auction multiple items at once!"] = "批量拍卖：一次拍卖多个物品！";
L["added to"] = "添加到";
L["\n|c00%s%s %s pot by %s\nNote: %s"] =[[
|c00%s%s %s 总底池 by %s
备注: %s]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L["removed from"] = "已移除";
L["\nPot: %s\nManagement cut (%s%%): %sg\nPer player cut (1/%s): %sg\n"] = [[
底池：%s
管理费用（%s%%）：%sg
每名玩家工资 (1/%s)：%sg
]];
L["\nYou need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions"] = [[
您需要作为团队领袖/拍卖师才能恢复条目。
您无法恢复锁定/删除的会话条目]];
L["By %s%s | On |c00%s%s%s"] = "拍卖师：%s%s |于 |c00%s%s%s"; -- By name<guild> on date
L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"] = "解锁和更改总底池或工资可能会变得非常混乱，特别是如果您已经支付完毕。你确定吗？";
L["Unlock the session"] = "解锁账单";
L["No active GDKP session detected or session is not locked for payout!"] = "未检测到激活的 GDKP 账单或账单尚未锁定！";
L["Increment or minimum can't be lower than .0001!"] = "增价或底价不能低于 0.0001！";
L["Invalid 'Increment' provided for item ID '%s'"] = "为项目 ID“%s”提供的“增价”无效";
L["Invalid 'Minimum' provided for item ID '%s'"] = "为项目 ID“%s”提供的“底价”无效";
L["Either minimum or increment is required for item ID: %s"] = "项目 ID 需要底价或增价：%s";
L["Missing header, note: it's case-sensitive!"] = "缺少标题，注意：区分大小写！";
L["Successfully imported data for %s items"] = "已成功导入 %s 项数据";
L["Unknown item ID: %s"] = "未知的项目 ID：%s";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.\nItems in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.\n\nWant Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!\n\n|c00FFF569Did you know?\nYou can move items around with drag and drop\nItems will be remembered, even when you |c00A79EFF/reload\nQueued items are automatically shown to raiders who have Gargul so they can prebid\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s 物品在背包中、战利品窗口中，甚至在聊天中的链接上，将它们添加到此拍卖队列中。
当前拍卖完成后，队列中的物品将自动进行拍卖。单击“%s”按钮可以暂停。

想要 Gargul 自动为您分配或分解吗？打开左侧的设置轮！

|c00FFF569你知道吗？
您可以通过拖放来移动物品
即使您|c00A79EFF/重新加载，物品也会记录在列
排队的物品会自动显示给拥有 Gargul 的团员，以便他们可以预先出价
Gargul 还可以为您自动拾取。使用 |c00A79EFF/gl pm 查看
]];
L["Hide unusable items"] = "隐藏不可用的物品";
L["GDKP Session"] = "GDKP 项目";
L["Editing %s"] = "正在编辑 %s";
L["Show upcoming items"] = "显示即将竞拍的商品";
L["Stop the auction first!"] = "立刻停止拍卖！";
L["%s owes you %s"] = "%s欠你%s";
L["\n|c00967FD2GDKP Session\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s\n"] = [[
|c00967FD2GDKP 会议
该玩家花费：%s
已付：%s
已收：%s
工资：%s

%s
]];
L["Exclude from GDKP"] = "从 GDKP 中排除";
L["Gold traded will not be added to amount given or received"] = "交易的金币不会添加到给予或接收的金额中";
L["Gold |c00967FD2given to %s"] = "金币 |c00967FD2 已交易 %s";
L["Unable to add %s to the trade window. Try adding it manually!"] = "无法将 %s 添加到交易窗口。尝试手动添加！";
L["You don't have enough money to pay %s"] = "您没有足够的钱来支付 %s";
L["To give: %s"] = "给予：%s";
L["To receive: %s"] = "接收：%s";
L["Gold |c00967FD2received from %s"] = "金币 |c00967FD2 已从 %s 收到";
L["Check out Multi Auctions!"] = "查看批量拍卖！";
L["Follow the steps below to quickly get started with Gargul GDKP!"] = "按照以下步骤快速开始使用 Gargul GDKP！";
L["Activate this session by clicking the |c00FFF569Enable button below!"] = "单击下面的 |c00FFF569Enable 按钮激活此账单！";
L["|c00FFF569%s an item to auction or queue a single item"] = "|c00FFF569%s 一个要拍卖的物品或将单个物品排队"; -- %s holds the auction item hotkey (default ALT_CLICK)
L["\nHelpful commands:\n- |c00FFF569/gdkp to open this window\n- |c00FFF569/gl ma to open the multi-auction window\n- |c00FFF569/gl au to open the single item auctioneer / queue\n- |c00FFF569/gl pm to set up auto-looting\n\n"] = [[
有用的命令：
- |c00FFF569/gdkp 打开此窗口
- |c00FFF569/gl ma 打开批量拍卖窗口
- |c00FFF569/gl au 打开单独拍卖/队列
- |c00FFF569/gl pm 设置自动拾取

]];
L["If all went well then you will see your freshly auctioned item(s) here!"] = "如果一切顺利，那么您将在这里看到新拍卖的物品！";
L["Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!"] = "想同时拍卖多件物品吗？运行|c00FFF569/gl ma（或|c00FFF569/gl multiauction）或单击此窗口右上角的multi-auction 图标！";
L["Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created"] = "单击下面的 |c00FFF569New 按钮创建您的第一个 GDKP 账单。创建后会显示在左侧";
L["You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!"] = "您已准备好出售物品了！ |c00BE3333在开始您的第一个 GDKP raid 之前，请仔细阅读以下所有步骤并亲自测试它们（无需参加 raid）！";
L["Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!"] = "想要在没有人出价的情况下出售物品吗？ |c00FFF569%s 的物品，选出获胜者并设定价格！";
L["Getting started"] = "快速入门";
L["Unknown itemID in Auction:create: %s"] = "拍卖中的未知 itemID：创建：%s";
L["Unknown sessionIdentifier in Auction:create: %s"] = "拍卖中未知的会话标识符：创建：%s";
L["You owe %s %s"] = "你欠 %s %s";
L["Given"] = "给定";
L["g"] = "G";
L["Group"] = "团体";
L["Group Manager"] = "副本领袖";
L["Download on CurseForge"] = "在 CurseForge 上下载";
L["https://addons.wago.io/addons/gargul/versions?stability=stable"] = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L["Halt"] = "暂停";
L["Header"] = "标题";
L["|c00%sGargul v%s by Zhorax@Firemaw. Type |c00%s/gl or |c00%s/gargul to get started!"] = "|c00%sGargul v%s，作者：Zhorax@Firemaw。输入 |c00%s/gl 或 |c00%s/gargul 开始！";
L["Hide"] = "隐藏";
L["%H:%M"] = "%H:%M";
L["Visit the URL below to learn more about personalizing Gargul GDKPs"] = "访问下面的 URL，了解有关个性化 Gargul GDKP 的更多信息";
L["Your logo here? Click for more info!"] = "你的logo在这里吗？点击了解更多信息！";
L["Import"] = "导入";
L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"] = "导入于 |c00A79EFF%s |c00A79EFF%s，更新于 |c00A79EFF%s |c00A79EFF%s";
L["What kind of data would you like to import?"] = "您想导入什么类型的数据？";
L["Import of boosted roll data successful"] = "导入BR数据成功";
L["Inc"] = "Inc";
L["Include previously awarded items"] = "包括以前授予的项目";
L["Include BOEs"] = "包括装绑";
L["Include materials (like Abyss Crystals)"] = "包含材料（如深渊水晶）";
L["Increment"] = "增价";
L["Info"] = "信息";
L["Invalid data supplied"] = "无效数据";
L["Item"] = "物品";
L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "无法对数据进行 JSON 解析。确保按原样复制/粘贴它，而不添加任何其他字符或空格！";
L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"] = [[
Gargul 物品热键

Roll： |c00A79EFF%s
分配： |c00A79EFF%s
分解：|c00A79EFF%s


-- 右键单击禁用该窗口 --
]];
L["Ledger"] = "分类帐";
L["<"] = "<";
L["You need to be the master looter or have an assist / lead role!"] = "您需要成为您需要作为团队领袖/拍卖师！";
L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"] = "注意：您可以随时在设置中或通过 |c00%s/gl locale 更改区域设置";
L["deDE"] = "德语（德国）"; -- German (Germany)
L["enUS"] = "英语（美国）"; -- English (United States)
L["esES"] = "西班牙语（西班牙）"; -- Spanish (Spain)
L["esMX"] = "西班牙语（墨西哥）"; -- Spanish (Mexico)
L["frFR"] = "法语（法国）"; -- French (France)
L["itIT"] = "意大利语（意大利）"; -- Italian (Italy)
L["koKR"] = "韩语（韩国）"; -- Korean (Korea)
L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"] = [[
Gargul 用英语发布聊天消息（默认）
您可以在下面的下拉列表中选择不同的语言

您当前的聊天语言是“%s”，启用不同的语言将导致/重新加载！
]];
L["Choose a chat language for Gargul"] = "选择 Gargul 的聊天语言";
L["ptBR"] = "葡萄牙语（巴西）"; -- Portuguese (Brazil)
L["ruRU"] = "俄语（俄罗斯）"; -- Russian (Russia)
L["zhCN"] = "简体中文（中国）"; -- Chinese (Simplified, PRC)
L["zhTW"] = "繁体中文（台湾）"; -- Chinese (Traditional, Taiwan)
L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"] = "您安装了一个或多个插件，可能会导致 Gargul 无法正常工作：%s";
L["Clear SoftRes"] = "清空SoftRes";
L["Clear TMB"] = "清空TMB";
L["/roll for MS or /roll 99 for OS"] = "主天赋 /roll 或 副天赋 /roll 99 ";
L["Import SoftRes"] = "导入SoftRes";
L["Import TMB"] = "导入TMB";
L["You were given the role of Master Looter"] = "你被赋予了队长分配";
L["Open this window automatically"] = "自动打开此窗口";
L["Loot priorities cleared successfully"] = "拾取优先级已成功清除";
L["Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc"] = "提供以下格式的 prio CSV（每项 1 行）：id 或名称 > prio1、equalprio > prio2 > 等";
L["Loot priorities imported successfully"] = "拾取优先级导入成功";
L["Invalid data provided"] = "提供的数据无效";
L["Invalid data provided in line: '%s': missing item id or priority"] = "第“%s”行中提供的数据无效：缺少项目 ID 或优先级";
L["Attempting to process incoming loot priorities from %s"] = "正在尝试处理来自 %s 的传入物品优先级";
L["Loot Prio"] = "拾取优先权";
L["Mail"] = "邮件";
L["Mailed"] = "邮寄";
L["Mail cut to players"] = "邮寄给玩家";
L["MS"] = "主天赋";
L["Maximize"] = "最大";
L["Min"] = "最小";
L["Awarded loot history"] = "分配记录";
L["GDKP Cuts"] = "GDKP 工资";
L["Export data"] = "导出数据";
L["Open Gargul"] = "打开Gargul";
L["Import data"] = "导入数据";
L["GDKP Ledger"] = "GDKP分类账";
L["Multiauction"] = "批量拍卖";
L["Change settings in /gl minimap"] = "更改 /gl 小地图中的设置";
L["Minimize"] = "最小";
L["Minimize on award"] = "以底价分配";
L["Minimize on start"] = "以底价开始";
L["Minimum"] = "底价";
L["Minimum item level"] = "最低物品等级";
L["Minimum Quality"] = "最低品质";
L["-10"] = "-10";
L["-"] = "-";
L["Move"] = "移动";
L["Multi-Auction"] = "批量拍卖";
L["Name"] = "名称";
L["New"] = "新账单";
L["Next"] = "下一个";
L["No"] = "不";
L["None"] = "无";
L["Note"] = "备注";
L["Nothing"] = "无";
L["When no one bids do:"] = "当无人出价时：";
L["You don't have officer privileges"] = "你没有官员特权";
L["OS"] = "副天赋";
L["Ok"] = "好的";
L["Open"] = "打开";
L["Open Auctioneer"] = "打开拍卖界面";
L["Open Multi-Auction"] = "打开批量拍卖";
L["DE"] = "DE";
L["GREED"] = "GREED";
L["IGNORE"] = "IGNORE";
L["NEED"] = "NEED";
L["PASS"] = "PASS";
L["RANDOM"] = "RANDOM";
L["RR"] = "RR";
L["SELF"] = "SELF";
L["Set %s as your disenchanter?"] = "将 %s 设置为你的分解者？";
L["Send %s to %s? Type /gl cd to remove this disenchanter!"] = "将 %s 发送给 %s？输入 /gl cd 来删除这个分解者！";
L["No disenchanter set, use /gl sd [mydisenchanter] to set one"] = "没有设置分解者，使用 /gl sd [mydisenchanter] 设置一个";
L["Who is your disenchanter?"] = "谁是你的分解者？";
L["Paid"] = "已付";
L["Pass"] = "跳过";
L["%"] = "%";
L["Player"] = "玩家";
L["Items won by %s:"] = "%s 赢得该物品：";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L["Plus Ones"] = " Plus Ones ";
L["Add a +1"] = "添加+1";
L["Are you sure you want to broadcast your plus one data to everyone in your party/raid?"] = "您确定要将您的+1数据广播给您的队伍/团队中的每个人吗？";
L["Attempting to process incoming PlusOnes data from %s"] = "正在尝试处理来自 %s 的传入 PlusOnes 数据";
L["%s wants to clear all your PlusOne data. Clear all data?"] = "%s 想要清除您的所有 PlusOne 数据。清除所有数据？";
L["Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?"] = "您确定要清除现有的 PlusOne 数据并导入 %s 广播的新数据吗？";
L["Are you sure you want to import new data broadcasted by %s?"] = "您确定要导入 %s 广播的新数据吗？";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "提供的数据无效。确保内容遵循所需的格式并且不包含标题行";
L["\nHere you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240\n"] = [[
在这里，您可以从 CSV 或 TSV 格式的表格或从 Google 文档表粘贴的数据导入加一数据。

该表至少需要两列：玩家姓名，后跟分数。附加列将被忽略。

这是一个示例行：

福巴，240
]];
L["Automatically accept incoming broadcasts from %s"] = "自动接受来自 %s 的传入广播";
L["Block all incoming +1 shared data"] = "阻止所有传入的 +1 共享数据";
L["\nAre you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
您确定要使用 %s 中的数据更新现有的 PlusOne 数据吗？

您的最新更新是在 |c00A79EFF%s 上，他们的最新更新是在 |c00A79EFF%s 上。]];
L["!plusone|!po|!+1"] = "!plusone|!po|!+1";
L["+"] = "+";
L["Pot"] = "底池";
L["Price"] = "价格";
L["PL"] = "PL";
L["Common"] = "普通";
L["Epic"] = "史诗";
L["Heirloom"] = "传家宝";
L["Legendary"] = "传说";
L["Poor"] = "垃圾";
L["Rare"] = "稀有";
L["Uncommon"] = "精良";
L["Queue"] = "队列";
L["Raiders"] = "攻略";
L["Who's Missing"] = "谁失踪了";
L["Show missing player names"] = "显示缺失的成员姓名";
L["Disband raid"] = "解散团队";
L["Disband your raid"] = "解散你的团队";
L["%s is listed twice on the roster!"] = "%s 在名册上被列出两次！";
L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"] = "|c00FFF569Raid-Helper 导出（使用“垂直排序的组”变体）或 |c00FFF569Gargul 组组合 CSV：";
L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"] = [[
在下面的大编辑框中，您可以提供名单并：邀请所有人，检查谁失踪了，应用组并分配坦克。

您可以提供 |c00FFF569Wowhead raid 组成链接：]];
L["Gargul Group Wiki"] = "加尔古尔集团维基";
L["Visit the Gargul group wiki for more info on the raid group format"] = "访问 Gargul 组 wiki，了解有关 raid 组格式的更多信息";
L["The following players are not part of the roster: %s"] = "以下球员不属于名单：%s";
L["Invalid group data provided, check your format!"] = "提供的组数据无效，请检查您的格式！";
L["Invite"] = "邀请";
L["Send invites to players on roster"] = "向名单上的玩家发送邀请";
L["Can't sort groups while %s is in combat!"] = "当 %s 处于战斗状态时无法对组进行排序！"; -- %s holds a player name
L["You need to be in a raid!"] = "你需要参加团队！";
L["No tanks defined"] = "没有定义坦克";
L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"] = "找不到 %s 的位置，您是否想将 5 人以上分成 1 组？";
L["Kick unwanted players"] = "踢掉不需要的球员";
L["Kick players that aren't on the roster"] = "踢掉不在名单上的球员";
L["Something went wrong while moving %s"] = "移动 %s 时出了点问题";
L["Finished applying raid roster"] = "完成申请raid名册";
L["Sorting groups"] = "对组进行排序";
L["Apply Groups"] = "应用组";
L["Sort groups based on roster"] = "根据名单对组进行排序";
L["Sorting is still in progress, wait a bit!"] = "排序还在进行中，请稍等！";
L["All tanks are assigned"] = "所有坦克均已分配";
L["Assign Tanks"] = "分配坦克";
L["Wowhead Comp Tool"] = "Wowhead 比较工具";
L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"] = "您可以使用下面的 URL 访问 wowhead comp 工具。创建组合后，您可以将其粘贴到此处或 Gargul 组窗口的大型编辑字段中";
L["Remove bid"] = "删除出价";
L["Reset Settings"] = "重新设置";
L["Are you sure you want to reset all of Gargul's settings? This can't be undone!"] = "您确定要重置 Gargul 的所有设置吗？这无法挽回！";
L["Reset Gargul UI"] = "重置 Gargul UI";
L["Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!"] = "您确定要重置 Gargul 的所有窗口大小、位置和比例吗？这无法挽回！";
L["Restore"] = "恢复";
L["Resume"] = "恢复";
L[">"] = ">";
L["Roll"] = "Roll 点";
L["Award %s to %s?"] = "将 %s 奖励给 %s？";
L["Close on award"] = "即将获奖";
L["Close on start"] = "开始时关闭";
L["Hold shift to bypass the award confirmation"] = "按住shift绕过奖励确认";
L["Hold shift to show the award confirmation"] = "按住shift键即可显示获奖确认信息";
L["Warning: another identical roll was found which can point to a tie"] = [[
警告：发现了另一个相同的 Roll 点，这可能表明平局

]];
L["Invalid data provided for roll start!"] = "为开始 Roll 点提供的数据无效！";
L["(BR: %s)"] = "（BR：%s）";
L["(item given: yes)"] = "（给出的项目：是）";
L["(item given: no)"] = "（给出的项目：无）";
L["(OS)"] = "（副天赋）";
L["NOTE"] = "笔记";
L["Can't stop roll off, no roll off in progress"] = "无法停止滚滚，没有正在进行滚滚";
L["Pass"] = "放弃";
L["rolls: %s"] = "Roll 点数：%s";
L["Open master looter window"] = "打开战利品分配者窗口";
L["Roll accepted!"] = "Roll 点已被接受！";
L["A roll is currently in progress"] = "当前正在进行 Roll 点";
L["Prio [%s]"] = "优先[%s]";
L["SR [%sx]"] = "SR [%sx]";
L["Wish [%s]"] = "愿望[%s]";
L["You need to select a player first"] = "您需要先选择一名玩家";
L["TIMER (s)"] = "计时器";
L["You can't use this item!"] = "您不能使用该物品！";
L["The winner's name is not unique, select the player you'd like to award %s to"] = "获奖者的名字不是唯一的，请选择您想要将 %s 奖励给的玩家";
L["s"] = "s";
L["Select / Disable all"] = "选择/禁用全部";
L["Settings"] = "设置";
L["Announce incoming bids"] = "宣布收到的投标";
L["Announce pot after awarding item"] = "奖励物品后宣布底池";
L["Announce auction start"] = "宣布拍卖开始";
L["Announce countdown in raid warning"] = "宣布团队警告倒计时";
L["Announce incoming bids in raid warning"] = "在团队警告中宣布收到的投标";
L["Reset Gargul UI"] = "重置 Gargul UI";
L["Whisper bidder if bid is too low"] = "如果出价太低，则对投标人密语";
L["s"] = "s";
L["Skip"] = "跳过";
L["Soft-Reserves"] = "软保留";
L["SR"] = "SR";
L["Are you sure you want to broadcast your softres data to everyone in your party/raid?"] = "您确定要将您的软保留数据广播给您的队伍/团队中的每个人吗？";
L["Couldn't process SoftRes data received from %s"] = "无法处理从 %s 收到的 SoftRes 数据";
L["Are you sure you want to clear all existing soft-reserve data?"] = "您确定要清除所有现有的软保留数据吗？";
L["Everyone filled out their soft-reserves"] = "每个人都填满了软保留";
L["\nHard-reserve information is not available because the soft-reserves\nprovided were not generated using the 'Gargul Export' button on softres.it"] = [[
硬保留信息不可用，因为软保留
提供的内容不是使用 softres.it 上的“Gargul Export”按钮生成的]];
L["Imported on |c00A79EFF%s at |c00A79EFF%s"] = "导入于 |c00A79EFF%s |c00A79EFF%s";
L["Auto name fix: the SR of '%s' is now linked to '%s'"] = "自动名称修复：“%s”的 SR 现在链接到“%s”";
L["In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below."] = "为了开始，您首先需要在 softres.it 上创建一个 raid。然后单击“Addon Export”，选择“Gargul”，复制数据并将其粘贴到下面的表单中。";
L["Invalid soft-reserve data provided"] = "提供的软保留数据无效";
L["Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here"] = "提供的数据无效。确保单击 softres.it 上的“Gargul Export”按钮并将完整内容粘贴到此处";
L["The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?"] = "提供的 PlusOne 值与已存在的值发生冲突。您想替换旧的 PlusOne 值吗？";
L["The following players did not reserve anything:"] = "以下玩家没有保留任何东西：";
L["Soft-reserves imported successfully"] = "软保留导入成功";
L["Import successful!"] = "导入成功！";
L["SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!"] = "SoftRes Weakaura 和 CSV 数据已弃用，请改用 Gargul 导出！";
L["Failed to connect to LootReserve, contact support (include message below)"] = "无法连接到 LootReserve，请联系支持人员（包括下面的消息）";
L["%s (%sx)"] = "%s (%sx)";
L["No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!"] = "没有可用的 softres.it URL，请确保使用 softres.it 上的“Gargul Export”按钮导出！";
L["Click here to see hard-reserve info"] = "单击此处查看硬保留信息";
L["No items are hard-reserved"] = "没有硬性保留的项目";
L["No hard-reserve info available"] = "没有可用的硬保留信息";
L["Post missing SRs"] = "发布缺失的 SR";
L["Post SR URL"] = "发布 SR 网址";
L["This player did not reserve anything!"] = "该玩家没有保留任何东西！";
L["%s (%sx)"] = "%s (%sx)";
L["Attempting to process incoming SoftRes data from %s"] = "正在尝试处理来自 %s 的传入 SoftRes 数据";
L["This item is hard-reserved"] = "此物品为硬保留";
L["For: %s"] = "对于：%s";
L["|c00CC2743 Note: %s"] = "|c00CC2743 注意：%s";
L["Reserved by"] = "保留者";
L["!sr|!softres|!softreserve"] = "!sr|!softres|!softreserve";
L["Something went wrong!"] = "出了些问题！";
L["Start"] = "开始";
L["Stop"] = "停止";
L["\\t is replaced by a tab"] = "\\t is replaced by a tab";
L["TMB"] = "TMB";
L["Time"] = "时间";
L["Title"] = "标题";
L["TMB, DFT or PRIO3"] = "TMB、DFT 或 PRIO3";
L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"] = "您确定要将 TMB 数据广播给队伍/团队中的每个人吗？注意：每个人都可以看到您的 TMB 数据，无论其在 TMB 网站上的权限如何！";
L["Attempting to process incoming TMB data from %s"] = "正在尝试处理来自 %s 的传入 TMB 数据";
L["Are you sure you want to clear all plus one data?"] = "您确定要清除所有加一数据吗？";
L["Clear Raider Data"] = "清除团队成员数据";
L["Clear TMB data for all raiders?"] = "清除所有团队成员的 TMB 数据？";
L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "在您的 classicpr.io 运行中单击“Gargul Export”按钮并复制内容。然后将内容按原样粘贴到下面的框中，然后单击“导入”。就是这样！";
L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "按照工作表的说明导出 DFT 数据。然后将内容按原样粘贴到下面的框中，然后单击“导入”。就是这样！";
L["Invalid CSV provided, the format is: 6948,player1,player2"] = "提供的 CSV 无效，格式为：6948,player1,player2";
L["Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!"] = "提供的 DFT 数据无效，请按照工作表的说明导出您的 DFT 数据，然后按原样将内容粘贴到此处！";
L["Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!"] = "提供的 TMB 数据无效，请务必单击 Gargul 部分中的“下载”按钮并将内容按原样粘贴到此处！";
L["Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!"] = "提供的 TMB 或 DFT 数据无效，请确保将导出内容按原样粘贴到此处！";
L["The following players have no %s entries:"] = "以下玩家没有 %s 条目："; -- %s can be TMB/DFT/CPR
L["How to use Gargul with ${source}"] = "如何将 Gargul 与 ${source} 结合使用";
L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"] = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L["Paste your TMB export contents as-is in the box below and click 'Import'"] = "将 TMB 导出内容按原样粘贴到下面的框中，然后单击“导入”";
L["There's no one in your group to broadcast to"] = "您的群组中没有人可以向其广播";
L["TMB data synced"] = "TMB 数据已同步";
L["|c00FFFFFF    Note: |c00FFF569%s"] = "|c00FFFFFF 注： |c00FFF569%s";
L["(OS)"] = "（副天赋）";
L["%s Prio List"] = "%s 优先级列表"; -- %s can be TMB/DFT/CPR
L["|c00FFFFFF    Tier: %s"] = "|c00FFFFFF 等级：%s";
L["TMB Wish List"] = "TMB 愿望清单";
L["Show/Hide Dates"] = "显示/隐藏日期";
L["Show/Hide Queue"] = "显示/隐藏队列";
L["%s to award loot!"] = "%s 奖励战利品！";
L["%s to roll out loot!"] = "%s 推出战利品！";
L["Hide all awarded items"] = "隐藏所有获奖物品";
L["Hide disenchanted items"] = "隐藏不再抱有幻想的物品";
L["Hide items awarded to self"] = "隐藏奖励给自己的物品";
L["Announce Trade"] = "公告交易";
L["Announce trade details to group or in /say when not in a group"] = "向群组公布交易详情，或在/不在群组中时公布交易详情";
L["Tutorial"] = "教程";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.\nWant to directly sell an item without bidding? Use |c00A79EFF%s\n\nYou can open the %s window directly by typing |c00A79EFF/gl auction\n\nGargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the \"Exclude from GDKP\" checkbox when trading!\n\n|c00FFF569Did you know?\nAwarded items will automatically be added to the trade window\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s 物品在袋子中、战利品窗口中，甚至在聊天中的链接上，将它们添加到拍卖队列中。
想要无需出价直接出售商品吗？使用 |c00A79EFF%s

您可以通过输入 |c00A79EFF/gl 拍卖直接打开 %s 窗口

Gargul 追踪 |c00FF0000 所有黄金交易。不希望交易成为此 GDKP 会议的一部分吗？交易时勾选“从GDKP中排除”复选框！

|c00FFF569你知道吗？
获奖物品将自动添加到交易窗口
Gargul 还可以为您处理自动抢劫。使用 |c00A79EFF/gl pm 查看
]];
L["\nThis window shows all the items that have been awarded on any given date (select one or more dates on the left).\n\nItems can contain the following tags:\n\n|c00A79EFFOS: Awarded for offspec\n|c00A79EFFSR: This item was soft-reserved\n|c00A79EFFWL: This item was wishlisted (Thatsmybis)\n|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)\n"] = [[
此窗口显示在任何给定日期已授予的所有项目（在左侧选择一个或多个日期）。

项目可以包含以下标签：

|c00A79EFFOS：因不合格而获奖
|c00A79EFFSR：此项目已软保留
|c00A79EFFWL：该项目已列入愿望清单（Thatsmybis）
|c00A79EFFPL：该项目已列入优先级（Thatsmybis、DFT、prio3）
]];
L["\nThe items you see here are in the master looter's GDKP queue\nYou can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)\n\nYou can resize the window, move it around, or minimize it. Try it out!\n\nFor loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!\n"] = [[
您在这里看到的物品位于主盗贼的 GDKP 队列中
您可以删除它们、对它们出价以及隐藏不可用的项目（在左上角的设置中启用“隐藏不可用的项目”）

您可以调整窗口大小、移动窗口或最小化窗口。试试看！

对于战利品大师：在这里删除物品只会将它们从您的个人队列中删除，而不是实际的 GDKP 队列中！
]];
L["Need more help?"] = "需要更多帮助吗？";
L["Type"] = "类型"; -- As in type of roll or type of item
L["unknown"] = "未知";
L["Unknown comm action '%s', make sure to update Gargul!"] = "未知的通讯操作“%s”，请务必更新 Gargul！";
L["Unlock"] = "解锁";
L["Update Gargul!"] = "更新gargul！";
L["v"] = "v";
L["Report"] = "报告";
L["Report outdated results in group chat"] = "在群聊中报告过时的结果";
L["Gargul status"] = "加尔古尔状态";
L["Checking version ..."] = "检查版本...";
L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"] = [[
|c0092FF00v%s：播放器是最新的
|c00F7922Ev%s：玩家需要更新他的附加组件
|c00BE3333%s：玩家没有 Gargul 或者使用不受支持的版本
|c00808080%s：玩家离线或忽略我们！
|c0000FFFF%s：该玩家在我们的忽略列表中！

]];
L["PLAYER IGNORED!"] = "玩家被忽略！";
L["Offline"] = "离线";
L["No response"] = "没有反应";
L["No response:"] = "没有反应：";
L["Offline:"] = "离线：";
L["Outdated:"] = "过时的：";
L["Up-to-date:"] = "最新：";
L["Gargul is out of date and won't work until you update!"] = "Gargul 已过时，更新后才能使用！";
L["Invalid version string provided in Version:addRelease"] = "Version:addRelease 中提供的版本字符串无效";
L["Update Gargul!"] = "更新 Gargul！";
L["|c00%sGargul is now updated to |c00%sv%s"] = "|c00%sGargul 现已更新至 |c00%sv%s";
L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"] = "|c00A79EFFv%s 可在 CurseForge/Wago 上使用。您可以在不关闭游戏的情况下进行更新，只需确保 /reload ！";
L["Wait %s more seconds before you retry"] = "再重试之前请再等待 %s 秒";
L["Window"] = "窗口";
L["Gargul v%s"] = "Gargul v%s";
L["Window Scale"] = "窗口缩放";
L["WL"] = "WL";
L["Yes"] = "是的";
L["You disabled GDKP queues"] = "您禁用了 GDKP 队列";
L["0"] = "0";
L["Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf"] = "无法使用 zlib 压缩数据。通过 https://discord.gg/D3mDhYPVzf 联系支持人员";
L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "无法解压缩 zlib 数据。确保按原样复制/粘贴它，而不添加任何其他字符或空格！";
