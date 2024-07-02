--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "zhCN") then return; end
local L = Gargul_L or {};

L.ABOUT = "关于";
L.ALL_SETTINGS = "所有设置";
L.ANNOUNCE = "公示";
L.ANTISNIPE = "防偷鸡倒数";
L.ANTISNIPE_EXPLANATION = [[

防偷鸡倒数值为 10 意味着任何出价
剩余时间少于 10 秒会将计时器重置回 10 秒

您可以将此留空或设置为 0 以完全禁用防偷鸡。
不支持小于 5 的防偷鸡倒数值

]];
L.ARE_YOU_SURE = "是否确定？";
L.ASSIGN_GARGUL_INFO = [[
不要忘记使用 Gargul 代替
如果你想稍后导出战利品

-- 右键单击禁用该窗口 --]];
L.AUCTION = "拍卖";
L.AUCTIONEER = "拍卖师";
L.AUCTIONS = "拍卖物";
L.AUTO = "自动";
L.AUTO_AWARD = "自动分配";
L.AUTO_TRADE_OPTIONS = "自动交易选项";
L.AVAILABLE_PLACEHOLDER_VALUES = "可用值：";
L.AWARD = "分配";
L.AWARDED_TO = "分配给";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "BR：%s";
L.AWARDED_TOOLTIP_GDKP_COST = "价格";
L.AWARDED_TOOLTIP_GIVEN = "给出：成功";
L.AWARDED_TOOLTIP_NOT_GIVEN = "给出：失败";
L.AWARDED_TOOLTIP_SECOND_BID = "出价第二高：%s，%s";
L.AWARDED_YOU_WON = "你赢了";
L.AWARD_CONFIRM = "将 %s 分配给 %s？";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "您确定要分解%s吗？ %s BR点数将被退还！";
L.AWARD_HEADER_IN_GROUP = "组内";
L.AWARD_HISTORY = "分配历史";
L.AWARD_NEW_WINNER_CONFIRMATION = "%s 将重新分配给谁？";
L.AWARD_PLAYER_CUSTOM_NAME = "输入玩家ID";
L.AWARD_PLAYER_SELECT_NAME = "或者从下面选择ID";
L.AWARD_RANDOM_CONFIRM = "是否将 %s 随机分配给团员？";
L.AWARD_TOOLTIP_ADD_ITEM = "拖动或者按住 Shift 键+左键单击右侧框中的项目";
L.AWARD_TOOLTIP_BR_INDICATION = "（BR：%s）";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "分解物品：";
L.AWARD_TOOLTIP_GIVEN = "（给出：成功）";
L.AWARD_TOOLTIP_NOT_GIVEN = "（给出：失败）";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "（副天赋）";
L.AWARD_UNDO_BR_REFUND = "%s BR点数将被退还！";
L.AWARD_UNDO_CONFIRM = "您确定要撤消分配 %s 的 %s 奖励吗？%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "背包检查失败：未发现物品";
L.BAGINSPECTOR_FINISHED = "检查完毕";
L.BAGINSPECTOR_START = "开始检查...";
L.BALANCE = "收支";
L.BASE = "基础工资";
L.BASE64_DECODE_WARNING = "无法对数据进行 Base64 解码。确保按原样复制/粘贴它，而不添加任何其他字符或空格！";
L.BID = "出价";
L.BIDS = "出价";
L.BIND_ON_EQUIP_ABBR = "装绑物品";
L.BONUS_AUTO_INVITE = "1.从团队中自动邀请/排序组！单击下面或使用 |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. 奖励固定团员或额外付出的玩家！单击下面或使用 |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "Gargul 有一些你可能不知道的技巧。来看看吧！";
L.BONUS_PLUSONES = "3. Gargul 包含MS>OS roll点 +1追踪系统！单击下面或使用 |c00A79EFF/gl po";
L.BOOSTED_ROLLS = "Boosted Rolls";
L.BOOSTED_ROLLS_ABBR = "BR";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
为当前团队中的每个人添加多少积分？

|c00BE3333如果您希望每个人都获得积分，即使是那些没有BR资格的人，请首先使用“添加缺失的团队成员”按钮！]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "不提供积分值！";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "为团队添加积分";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "添加缺失的团队成员";
L.BOOSTED_ROLLS_ALIASES = "别名";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "应用别名";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "BR成本：";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "您确定要将BR数据广播给队伍/团队中的每个人吗？";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "无数据，请先导入 Boosted Rolls 数据！";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "无法处理从 %s 收到的 BoostedRolls 数据";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "正在尝试处理来自 %s 的传入 BoostedRolls 数据";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "您确定要清除所有BR数据吗？";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "删除%s？";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "您确定要清除现有的BR数据并导入 %s 广播的新数据吗？";
L.BOOSTED_ROLLS_IMPORT_ERROR = "提供的数据无效。确保内容遵循所需的格式并且不包含标题行";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
在这里，您可以从 CSV 或 TSV 格式的表格或从 Google 文档表粘贴的表格导入BR数据和别名。

该表至少需要两列：玩家姓名，后跟分数。附加列是可选的，并且可能包含玩家的别名。
这是一个示例行：

Foobar,240,Barfoo]];
L.BOOSTED_ROLLS_POINTS = "积分";
L.BOOSTED_ROLLS_RESERVE = "指定";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
您确定要使用 %s 的数据更新现有的BR吗？

您的最新更新是在 |c00A79EFF%s 上，他们的最新更新是在 |c00A79EFF%s 上。]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!奖金|!rb|!br";
L.BROADCAST = "通告";
L.BROADCASTING_NOTIFICATION = "通告中...";
L.BROADCAST_DELAYED_BY_COMBAT = "您目前正处于战斗状态，延迟通告";
L.BROADCAST_FINISHED = "通告完毕！";
L.BROADCAST_INC_AWARDED = "包括分配物品";
L.BROADCAST_INC_DISENCHANTED = "包括分解的物品";
L.BROADCAST_INC_HIDDEN = "包括隐藏项目";
L.BROADCAST_INC_TIME_LEFT = "包括剩余时间";
L.BROADCAST_IN_PROGRESS_ERROR = "通告仍在进行中";
L.BROADCAST_NO_DATA = "没有什么可通告的";
L.BROADCAST_NUMBER_OF_ITEMS = "物品数量";
L.BROADCAST_PROGRESS = "广播${percent}%";
L.BROADCAST_TARGET_PLAYER = "目标玩家（仅私聊）";
L.BROADCAST_TARGET_REQUIRED = "私聊需要目标玩家";
L.BROADCAST_TRADE_TIME_LEFT = "剩余最大交易时间（分钟）";
L.BY = "从"; -- As in 'bid BY'
L.CANCEL = "取消";
L.CHANGELOG_CONTRIBUTE = "在我们的 Discord 上获取支持或分享想法";
L.CHANGELOG_ENABLE_LABEL = "启用更新日志";
L.CHANGELOG_GETTING_STARTED = "Gargul 让分发战利品变得超级简单，点击下面的按钮即可开始！";
L.CHANGELOG_OPEN_GARGUL = "打开Gargul";
L.CHANGE_SCALE = "调整比例";
L.CHANNEL = "频道";
L.CHANNEL_OFFICER = "官员频道";
L.CHANNEL_RAID_WARNING = "团队频道";
L.CHANNEL_WHISPER = "私聊频道";
L.CLASSICPRIO_ABBR = "CPR";
L.CLEAR = "清除"; -- As in clearing a window or data
L.CLOSE = "关闭";
L.CLOSE_ON_AWARD = "分配时关闭";
L.CLOSE_ON_START = "开始时关闭";
L.COMMUNICATION = "通信";
L.COMM_PROGRESS = "已发送 %s 个字节，共 %s 个字节";
L.COPPER_INDICATOR = "C";
L.CUT = "工资";
L.CUTS = "结账";
L.CUT_MAILBOX_CLOSED = "邮箱关闭后无法发送邮件";
L.CUT_MAILS_FAILED = "检测到多个邮件错误，中止工资分发";
L.CUT_MAIL_BODY = "由 Gargul 提供支持：一款队长分配工具，支持 TMB、SoftRes、GDKP 和自动拾取战利品！";
L.CUT_MAIL_EVEN = "你不欠%s任何金币";
L.CUT_MAIL_FAILED = "无法将工资发送至 %s";
L.CUT_MAIL_GOLD_MISMATCH = "邮件已根据分配结果发送，但您剩余的金币！不匹配！，是不是出了什么问题？";
L.CUT_MAIL_HISTORY = "|c00967FD2%s 的邮件历史记录";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "您没有足够的金币来支付 %s";
L.CUT_MAIL_IN_PROGRESS = "稍等一下，我们还在处理之前的邮件";
L.CUT_MAIL_SUBJECT = "Gargul GDKP：%sg";
L.CUT_SENT = "已发送 %sg 至 %s";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "删除";
L.DETAILS = "细节";
L.DFT = "DFT";
L.DISABLE = "禁用";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "分解";
L.EDIT = "编辑";
L.ENABLE = "激活";
L.EXPORT = "导出";
L.EXPORT_DELETE_ALL_CONFIRM = "您确定要删除完整的分配历史记录表吗？这将删除所有战利品数据并且无法撤消！";
L.EXPORT_DELETE_DATE_CONFIRM = "您确定要删除 %s 的所有数据吗？这不能撤消！";
L.EXPORT_READ_ONLY_NOTICE = [[
这只是导出功能，没有必要编辑任何值：它们不会被保存！

]];
L.FILL = "加入";
L.FINAL_CALL = "最终机会";
L.FINISH = "结束";
L.FORMAT = "格式";
L.GARGUL = "Gargul";
L.GDKP = "GDKP";
L.GDKPS_ARE_NOT_ALLOWED = "此版本的魔兽世界不允许 GDKP 模式";
L.GDKP_ACTIVATED = "GDKP 启动！";
L.GDKP_ADD_DROPS_TO_QUEUE = "将掉落的战利品添加到队列中";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "价格（- 用于扣减价格）";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "谁付钱？";
L.GDKP_ADD_GOLD_INVALID_WARNING = "黄金需要低于/高于 0";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "支付方：";
L.GDKP_ADD_GOLD_TITLE = "调整 %s 的价格";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "您不能同时从同一玩家处给予和接收金币";
L.GDKP_ALL_CUTS_MAILED = "所有工资均已邮寄！";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "分解禁用";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "战斗中禁用";
L.GDKP_AUCTIONS = "拍卖";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "由...制作";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333已被 %s 删除
原因：%s]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg 由 %s 添加到底池中
注意：%s]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s 已支付 |c00%s%sg 的费用
%s]];
L.GDKP_AUCTION_DETAILS_WON_BY = "获胜者：";
L.GDKP_AUCTION_PAID_AMOUNT = "设置支付金额（左）";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul 自动跟踪金币交易。只要玩家已经支付了
他们购买的东西所需的金币，那么你就不需要看这段文字

“支付金额”是指买家已经向您交易的金币数量。
这不会改变商品的实际价格！

警告：仅当玩家承诺付款时才在此处设置值
在团队之外或通过小号交易/邮件等交易金币！


]];
L.GDKP_AWARD_DIALOG_LABEL = "GDKP 价格：";
L.GDKP_AWARD_ITEM_CONFIRMATION = "分配 %s 给 %s, 价格为 %s？";
L.GDKP_BIDDER_AUTO_BID = "自动出价";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "您的最高预期出价是多少？ （最小 %s|c00FFF569g）";
L.GDKP_BIDDER_BID_DENIED = "竞拍被拒绝！";
L.GDKP_BIDDER_ITEM_PRICING = "最低出价：%sg 增量：%sg";
L.GDKP_BIDDER_MY_MAX_BID = "（最大 %sg）";
L.GDKP_BIDDER_NEW_BID_LABEL = "新出价";
L.GDKP_BIDDER_STOP_AUTO_BID = "停止自动出价";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "最高出价：%s，来自 %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "最高出价：%s 由您出价";
L.GDKP_CREATE = "创建新的 GDKP 账单";
L.GDKP_CREATE_MANAGEMENT_CUT = "管理费用 %";
L.GDKP_CREATE_SESSION_INVALID_CUT = "管理费用需要为空或介于 0 到 99 之间（没有 % 符号！）";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "选择拍卖类型！";
L.GDKP_CREATE_SESSION_SWITCH = "切换到此账单";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFF 多重拍卖允许您一次对多个物品开始出价，从而加快速度！
创建此会话后按照说明开始操作

使用 |c00A79EFFSingle-Auction，您可以选择拍卖单个物品或使用队列

选择 |c00A79EFF 多重拍卖可防止将已丢弃的项目添加到队列中
您可以将 |c00A79EFFMulti-Auction 与 |c00A79EFFSingle-Auction 和队列混合使用，但我们强烈建议不要这样做

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "拍卖类型（|c00A79EFFi 了解更多信息）";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "多物品拍卖";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "单物品拍卖";
L.GDKP_CREATE_SUCCESSFUL = "会话已创建。我们建议您 /reload 以便正确存储它，以防您的游戏崩溃！";
L.GDKP_CUTS_ADD_RAIDER = "添加团队成员";
L.GDKP_CUTS_ADJUST_G = "调整[g]";
L.GDKP_CUTS_ADJUST_P = "调整 [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "在群聊中宣布管理费用";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "您确定要重置所有玩家和计算吗？注意：所有不再参与团队的玩家都将从列表中删除！";
L.GDKP_CUTS_DELETE_RAIDER = "删除团队成员";
L.GDKP_CUTS_EDIT_RAIDER = "编辑团队成员";
L.GDKP_CUTS_LOCK_TOOLTIP = "锁定并付款";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "管理金币交易";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

通过补助管理，你可以给玩家更多或更少的金币
示例：为坦克提供 2% 的额外补助！

注意：在此处编辑或删除补助管理只会更改此账单的补助
]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "不在团队中";
L.GDKP_CUTS_POT_EXPLANATION = [[

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
L.GDKP_CUTS_SUMMARY = "%s 团员 | %s 已结清|总支出：%sg";
L.GDKP_CUT_IMPORT_EMPTY = "无任何内容导入，请仔细检查您的 CSV";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "%s 尚未付款";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "缺少标题，注意：区分大小写！";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "缺少成员姓名";
L.GDKP_DELETE_BID_INFO = "删除出价。必须先停止拍卖！";
L.GDKP_DISTRIBUTE_ADDRAIDER = "将团员添加到此账单";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "自定义（创建您自己的格式）";
L.GDKP_EXPORT_AUCTIONS_JSON = "详细（JSON）";
L.GDKP_EXPORT_AUCTIONS_SHARE = "分享（可以被其他玩家导入）";
L.GDKP_EXPORT_CUSTOM_FORMAT = "您的自定义格式";
L.GDKP_EXPORT_CUSTOM_HEADER = "您的自定义标题";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "自定义（创建您自己的格式）";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@玩家，@工资";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "玩家、工资";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "会话被锁定的日期/时间";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "给予玩家的总金币";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "金币邮寄给玩家";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "从玩家处收到的总金币";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "第一件物品被分配的日期/时间";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "交易给玩家的金币";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM、@WINNER、@GOLD、@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "物品、玩家、金币、Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "第一个物品被分配的日期/时间";
L.GDKP_EXPORT_FORMAT_TITLE = "GDKP 账单标题";
L.GDKP_EXPORT_POT_CHANGED = "底池更换";
L.GDKP_GOLD_TRADES = "黄金交易";
L.GDKP_EXPORT_INCLUDE_DISENCHANTED = "包括不再抱有幻想的物品";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "确定吗？您将无法对即将竞拍的物品查看和出价！";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!!警告！！|r

您目前在一个互通的服务器，并且正在导入玩家姓名（无服务器），例如“%s”。这可能会导致您将工资发送给错误的玩家。
当处于互通的服务器时，请始终尝试包含玩家的服务器名称！
继续导入吗？
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "这将覆盖您对剪切窗口所做的任何更改，您确定吗？";
L.GDKP_IMPORT_CUTS_INFO = [[
您可以从自己的计算中导入成员工资，例如谷歌表格。软件 GDKP 等

格式如下（|c00BE3333INCLUDE THE HEADER！！）：

|c00BE3333Player，黄金|c00967FD2
玩家1,4000
玩家2,4125
玩家3,3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
导入 GDKP 最低价格和增量。

格式如下：物品ID + 最小值或增量为必填项。 （|c00BE3333需要标题！！）：

|c00BE3333ItemID，最小值，增量|c00967FD2
18608,4000,500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "删除现有的价格设置？单击“是”删除所有价格数据，单击“否”则使用您在此处提供的数据覆盖现有价格数据";
L.GDKP_IMPORT_SESSION = "导入 GDKP 账单";
L.GDKP_IMPORT_SESSION_ABOUT = "您可以在此处导入（并继续）GDKP 账单。为了从其他人处获得 GDKP 账单，他们需要将其导出到 |c00FFF569/gdkp，其中他们选择“共享（可以由其他玩家导入）”格式";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "您即将导入由 %s 创建的 GDKP 账单，您确定吗？";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "%s 创建的 GDKP 账单似乎已存在，您要覆盖它吗？";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "为 GDKP 扩展提供的数据无效！";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "为 GDKP 重新安排提供的数据无效！";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "为 GDKP 缩短提供的数据无效！";
L.GDKP_INVALID_DATA_FOR_START = "为 GDKP 拍卖开始提供的数据无效！";
L.GDKP_INVALID_PAID_AMOUNT = "为“付款”提供的数量无效";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "拍卖中提供的时间无效：重新安排";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP 数据（已售出 %sx）
最终价格：%s
平均价格：%s
初始价格：%s
增量：%s

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "余额： |c0092FF000 ？已结清！ | |c00BE333330 ？你欠 %s 30g | |c00F7922E50 ？ %s欠你50g";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "金币已由 %s 邮寄给您";
L.GDKP_LEDGER_LEGEND_PAID_TO = "金币支付给%s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "从 %s 收到金币";
L.GDKP_LEDGER_MUTATION = "金币 %s 由"; -- %s = removed or added
L.GDKP_LEDGER_POT = "总底池：%sg |管理费用：%sg (%s%%) |分发：%sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s |作者：%s%s |于 |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "GDKP 账单不可用或已锁定";
L.GDKP_MAIL_ALL = "全部邮寄";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "未检测到橙色物品的出价，请手动继续！";
L.GDKP_MISSING_CONTENT_FOR_START = "竞拍开始中缺少内容";
L.GDKP_MULTIAUCTION_ABOUT = [[

通过批量竞拍，您可以一次拍卖任意数量的物品！
这极大地加快了你的团队效率，并为你的团员提供了丝滑的体验

库存中的所有可交易物品都可以通过“从库存填充”自动拍卖
试一试！

|c00808080只有一个缺点：团员需要安装 Gargul！

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "您需要有一个解锁的GDKP账单！";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "打开此窗口后，将 %s 件商品添加到列表中或点击下面的“从库存填充”"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "防偷鸡倒数";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "防偷鸡倒数需要为0（空）或>=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "返回账单选择";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "从列表中删除所有账单";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "从库存中填充";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "将库存中的可交易物品添加到列表中";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
您可以在此处确定要包含在多重拍卖会话中的物品

使用下面的 |c00A79EFFFFill from inventory 按钮将仍可交易的物品添加到列表中
每当您清除并重新打开此窗口时，您最后的填充设置将用于自动添加项目

|c00A79EFF%s 项手动将其添加到列表中
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "下一步：检查 raider 的附加版本的兼容性";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "不是每个人都在使用 Gargul，您确定要开始拍卖吗？";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "至少选择一件物品进行拍卖";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "您的 Gargul 已过时，我们建议在开始竞拍之前进行更新，以防止出现问题！";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "并不是每个人都是最新版本。如果遇到问题，请告诉您的团员进行更新！";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "有一个正在进行的批量竞拍，您在此处添加的物品将被添加到现有竞拍队列中。请注意重复的项目！";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "搜索名称或 iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "支持物品名称和 iLVL，例如“252”、“<252”等";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "活动 GDKP 会话： |c00967FD2%s |作者：%s%s |于 |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "拍卖时间（秒）";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "拍卖时间（以秒为单位）需要 >= 10";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "您在 GDKP 竞标期间剩下的物品。为了恢复竞拍，您必须为任何未售出的物品提供新的出价时间（以秒为单位）";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "打开此窗口后，将 %s 个物品添加到列表中";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "单击齿轮图标来管理拍卖";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "您已经是 %s 的最高出价者";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
出价 |c00%s%sg
买家：%s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%s已关闭
无人出价]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
增价：|c00%s%sg
：|c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "物品数量：%s - 总售价：%sg - 我承诺的：%sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
已拍装备：%s/%s
总售价：%s
我买的：%s
总出价（不包括已售出）：%s
我出价（不包括已售出）：%s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%s出售给
%s 价格为： |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
出价 |c00%s%sg
出价人：|c0092FF00YOU！]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "无法停止 %s 的自动出价，请重试或/reload！";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "自动竞拍最高价 %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "自动竞拍，在左侧填写最高价";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "停止自动竞拍 (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "无法确认 %s 的竞拍";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "竞拍无效或出价过低！最小值为 %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "同一商品的两次竞拍之间需要等待两秒钟";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "清除出价记录";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "从拍卖中删除所有出价";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "关闭所有";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "关闭所有拍卖？";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
关闭所有竞拍

具有有效竞拍的物品将被出售，并且无法接受新的竞拍！
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "结束拍卖";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "结束拍卖。玩家不能再出价，但最高出价仍然有效";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "从拍卖中移除该物品，包括其竞拍详细信息。这无法挽回！";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "分解所有已完成拍卖但未售出的物品？";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
分解未售出的物品

这会将所有未售出的物品标记为已分解，并且它们不会出现在新的批量拍卖中
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "收藏该物品";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "最终Call计时器设置为倒数多少秒？";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "最小秒数为 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "通过提供（通常较短的）出价倒数来开始本次拍卖的最终Call";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "关闭所有拍卖并结束本次批量拍卖？";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
完成批量拍卖环节

这将关闭所有拍卖并在聊天频道中公布总底池
具有有效出价的拍卖将被出售，并且无法接受新的出价！
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "隐藏非激活物品";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "隐藏不可用物品";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "显示/隐藏已完成的拍卖";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "管理拍卖";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "按最低要求金额竞拍";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "竞拍窗口已关闭，请使用 |c00A79EFF/gl bid 重新打开！";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "在聊天中宣布销售情况";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "被顶价时播放声音";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "更多声音选项...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "显示所有";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "显示我的最爱";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "显示非激活物品";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "显示不可用物品";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "该商品已售出。使用分类帐（|c00%s/gdkp）进行更改！";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "终止";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "删除所有 bidsl 出价并结束所有拍卖？";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
终止批量拍卖

这将删除尚未售出的物品的所有出价并关闭所有拍卖！
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "将鼠标悬停在下面的任何按钮上以获取更多信息";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "显示/隐藏您无法使用的项目";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "为 GDKP 拍卖开始提供的数据无效！";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s 为 %sg 花费了 %s";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "loot master (%s) 已过时，这可能会导致出价失败！";
L.GDKP_MULTIAUCTION_OUTBID = "你被超了！";
L.GDKP_MUTATORS = "补助项";
L.GDKP_MUTATOR_ADD = "添加补助项";
L.GDKP_MUTATOR_APPLY_LABEL = "自动应用于";
L.GDKP_MUTATOR_CREATE_NEW = "创建一个新的 GDKP 补助项";
L.GDKP_MUTATOR_DELETE_BYPASS = "删除。按住shift跳过确认";
L.GDKP_MUTATOR_EDIT = "编辑补助项";
L.GDKP_MUTATOR_FLAT_LABEL = "固定价格 [示例：250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "固定价格必须是数字";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
例子：
|c00967FD2本人，团长，治疗]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "您可以使用关键字自动将此补助项应用于团员：";
L.GDKP_MUTATOR_NAME_LABEL = "名称 [示例：坦克]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "补助项名称不能包含点 (.)";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "百分比 [示例：10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "百分比必须是数字";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "保存以备将来使用";
L.GDKP_MUTATOR_UNKNOWN = "未知补助项：%s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "不允许用户“%s”开始竞拍";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "不允许用户“%s”停止竞拍";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "不允许用户“%s”停止竞拍：竞拍无效";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "没有足够的金币可供分配，可能工资结算出错了！";
L.GDKP_NO_BIDS = "没有出价！";
L.GDKP_OUTBID = "你被超了！";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "（激活）";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
您需要作为团队领袖/拍卖师来调整价格。
您无法在锁定/删除的账单中调整价格]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "添加/删除价格";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s 支付了 |c00%s%s 的费用
%s]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333已被 %s 删除
原因：%s]];
L.GDKP_OVERVIEW_DELETED_SESSION = "（已删除）";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
您需要作为团队领袖/拍卖师才能删除条目。
您无法删除锁定/已删除账单中的条目]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "提供删除此条目的原因";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "删除。按住 Shift 键可跳过文字信息";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "附带拍卖的账单将在 48 小时后删除";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
您需要作为团队领袖/拍卖师才能编辑条目。
您无法编辑已删除的条目或查看锁定/删除的账单中的条目]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "导出账单，以便其他人可以查看账单详细信息，甚至取代您作为拍卖师";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "从其他玩家或帐户导入账单";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
显示最终账单的完整概述，
非常适合截图用途！]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "锁定账单意味着您无法拍卖物品或以其他方式更改任何内容，直到您解锁它，您确定吗？";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "锁定或解锁账单";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "锁定账单并发工资";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "批量拍卖：一次拍卖多个物品！";
L.GDKP_OVERVIEW_MUTATION_ADDED = "添加到";
L.GDKP_OVERVIEW_MUTATION_ENTRY =[[
|c00%s%s %s 总底池 by %s
备注: %s]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "已移除";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
底池：%s
管理费用（%s%%）：%sg
每名玩家工资 (1/%s)：%sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
您需要作为团队领袖/拍卖师才能恢复条目。
您无法恢复锁定/删除的会话条目]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "拍卖师：%s%s |于 |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "解锁和更改总底池或工资可能会变得非常混乱，特别是如果您已经支付完毕。你确定吗？";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "解锁账单";
L.GDKP_PAYOUT_INACTIVE = "未检测到激活的 GDKP 账单或账单尚未锁定！";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "增价或底价不能低于 0.0001！";
L.GDKP_PRICE_IMPORT_INVALID_INC = "为项目 ID“%s”提供的“增价”无效";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "为项目 ID“%s”提供的“底价”无效";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "项目 ID 需要底价或增价：%s";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "缺少标题，注意：区分大小写！";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "已成功导入 %s 项数据";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "未知的项目 ID：%s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s 物品在背包中、战利品窗口中，甚至在聊天中的链接上，将它们添加到此拍卖队列中。
当前拍卖完成后，队列中的物品将自动进行拍卖。单击“%s”按钮可以暂停。

想要 Gargul 自动为您分配或分解吗？打开左侧的设置轮！

|c00FFF569你知道吗？
您可以通过拖放来移动物品
即使您|c00A79EFF/重新加载，物品也会记录在列
排队的物品会自动显示给拥有 Gargul 的团员，以便他们可以预先出价
Gargul 还可以为您自动拾取。使用 |c00A79EFF/gl pm 查看
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "隐藏不可用的物品";
L.GDKP_SESSION = "GDKP 项目";
L.GDKP_SESSION_EDIT_TITLE = "正在编辑 %s";
L.GDKP_SHOW_UPCOMING = "显示即将竞拍的商品";
L.GDKP_STOP_AUCTION_FIRST = "立刻停止拍卖！";
L.GDKP_THEY_OWE = "%s欠你%s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP 会议
该玩家花费：%s
已付：%s
已收：%s
工资：%s

%s
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "从 GDKP 中排除";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "交易的金币不会添加到给予或接收的金额中";
L.GDKP_TRADE_GIVEN_TO_LABEL = "金币 |c00967FD2 已交易 %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "无法将 %s 添加到交易窗口。尝试手动添加！";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "您没有足够的钱来支付 %s";
L.GDKP_TRADE_GOLD_TO_GIVE = "给予：%s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "接收：%s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "金币 |c00967FD2 已从 %s 收到";
L.GDKP_TRY_MULTIAUCTION = "查看批量拍卖！";
L.GDKP_TUTORIAL_INFO = "按照以下步骤快速开始使用 Gargul GDKP！";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "单击下面的 |c00FFF569Enable 按钮激活此账单！";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s 一个要拍卖的物品或将单个物品排队"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
有用的命令：
- |c00FFF569/gdkp 打开此窗口
- |c00FFF569/gl ma 打开批量拍卖窗口
- |c00FFF569/gl au 打开单独拍卖/队列
- |c00FFF569/gl pm 设置自动拾取

]];
L.GDKP_TUTORIAL_STEP_DONE = "如果一切顺利，那么您将在这里看到新拍卖的物品！";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "想同时拍卖多件物品吗？运行|c00FFF569/gl ma（或|c00FFF569/gl multiauction）或单击此窗口右上角的multi-auction 图标！";
L.GDKP_TUTORIAL_STEP_NEW = "单击下面的 |c00FFF569New 按钮创建您的第一个 GDKP 账单。创建后会显示在左侧";
L.GDKP_TUTORIAL_STEP_READY = "您已准备好出售物品了！ |c00BE3333在开始您的第一个 GDKP raid 之前，请仔细阅读以下所有步骤并亲自测试它们（无需参加 raid）！";
L.GDKP_TUTORIAL_STEP_SELL = "想要在没有人出价的情况下出售物品吗？ |c00FFF569%s 的物品，选出获胜者并设定价格！";
L.GDKP_TUTORIAL_TITLE = "快速入门";
L.GDKP_UNKNOWN_ITEM = "拍卖中的未知 itemID：创建：%s";
L.GDKP_UNKNOWN_SESSION = "拍卖中未知的会话标识符：创建：%s";
L.GDKP_YOU_OWE = "你欠 %s %s";
L.GIVEN = "给定";
L.GOLD_INDICATOR = "G";
L.GROUP = "团体";
L.GROUP_MANAGER = "副本领袖";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "在 CurseForge 上下载";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "暂停";
L.HEADER = "标题";
L.HELLO = "|c00%sGargul v%s，作者：Zhorax@Firemaw。输入 |c00%s/gl 或 |c00%s/gargul 开始！";
L.HIDE = "隐藏";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.IDENTITY_INFO = "访问下面的 URL，了解有关个性化 Gargul GDKP 的更多信息";
L.IDENTITY_TOOLTIP = "你的logo在这里吗？点击了解更多信息！";
L.IMPORT = "导入";
L.IMPORTED_AND_UPDATED_ON = "导入于 |c00A79EFF%s |c00A79EFF%s，更新于 |c00A79EFF%s |c00A79EFF%s";
L.IMPORT_EXPLANATION = "您想导入什么类型的数据？";
L.IMPORT_SUCCESSFUL = "导入BR数据成功";
L.INC = "Inc";
L.INCLUDE_AWARDED = "包括以前授予的项目";
L.INCLUDE_BOES = "包括装绑";
L.INCLUDE_MATERIALS = "包含材料（如深渊水晶）";
L.INCREMENT = "增价";
L.INFO = "信息";
L.INVALID_DATA_WARNING = "无效数据";
L.ITEM = "物品";
L.JSON_DECODE_WARNING = "无法对数据进行 JSON 解析。确保按原样复制/粘贴它，而不添加任何其他字符或空格！";
L.KEYS_INFO = [[
Gargul 物品热键

Roll： |c00A79EFF%s
分配： |c00A79EFF%s
分解：|c00A79EFF%s


-- 右键单击禁用该窗口 --
]];
L.LEDGER = "分类帐";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "您需要成为您需要作为团队领袖/拍卖师！";
L.LOCALE_CHANGE_NOTE = "注意：您可以随时在设置中或通过 |c00%s/gl locale 更改区域设置";
L.LOCALE_DEDE = "德德"; -- German (Germany)
L.LOCALE_ENUS = "埃内斯"; -- English (United States)
L.LOCALE_ESES = "ES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "FRFR"; -- French (France)
L.LOCALE_ITIT = "它IT"; -- Italian (Italy)
L.LOCALE_KOKR = "韩国KR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul 用英语发布聊天消息（默认）
您可以在下面的下拉列表中选择不同的语言

您当前的聊天语言是“%s”，启用不同的语言将导致/重新加载！
]];
L.LOCALE_NONE_TITLE = "选择 Gargul 的聊天语言";
L.LOCALE_PTBR = "聚苯乙烯"; -- Portuguese (Brazil)
L.LOCALE_RURU = "茹茹"; -- Russian (Russia)
L.LOCALE_ZHCN = "简体中文"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "中文"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "您安装了一个或多个插件，可能会导致 Gargul 无法正常工作：%s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "清空SoftRes";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "清空TMB";
L.LOOTMASTER_DEFAULT_NOTE = "主天赋 /roll 或 副天赋 /roll 99 ";
L.LOOTMASTER_IMPORT_SR_BUTTON = "导入SoftRes";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "导入TMB";
L.LOOTMASTER_NOTICE_LABEL = "你被赋予了队长分配";
L.LOOTMASTER_OPEN_LABEL = "自动打开此窗口";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "拾取优先级已成功清除";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "提供以下格式的 prio CSV（每项 1 行）：id 或名称 > prio1、equalprio > prio2 > 等";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "拾取优先级导入成功";
L.LOOTPRIORITY_INVALID_DATA = "提供的数据无效";
L.LOOTPRIORITY_INVALID_LINE = "第“%s”行中提供的数据无效：缺少项目 ID 或优先级";
L.LOOTPRIORITY_PROCESS_INCOMING = "正在尝试处理来自 %s 的传入物品优先级";
L.LOOTPRIORITY_TOOLTIP_HEADER = "拾取优先权";
L.MAIL = "邮件";
L.MAILED = "邮寄";
L.MAIL_CUTS_EXPLANATION = "邮寄给玩家";
L.MAINSPEC_ABBR = "主天赋";
L.MAXIMIZE = "最大";
L.MIN = "最小";
L.MINIMAP_BUTTON_AWARDED = "分配记录";
L.MINIMAP_BUTTON_CUTS = "GDKP 工资";
L.MINIMAP_BUTTON_EXPORT = "导出数据";
L.MINIMAP_BUTTON_GARGUL = "打开Gargul";
L.MINIMAP_BUTTON_IMPORT = "导入数据";
L.MINIMAP_BUTTON_LEDGER = "GDKP分类账";
L.MINIMAP_BUTTON_MULTIAUCTION = "批量拍卖";
L.MINIMAP_BUTTON_SETTING_INFO = "更改 /gl 小地图中的设置";
L.MINIMIZE = "最小";
L.MINIMIZE_ON_AWARD = "以底价分配";
L.MINIMIZE_ON_START = "以底价开始";
L.MINIMUM = "底价";
L.MINIMUM_ITEM_LEVEL = "最低物品等级";
L.MINIMUM_QUALITY = "最低品质";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "移动";
L.MULTI_AUCTION = "批量拍卖";
L.NAME = "名称";
L.NEW = "新账单";
L.NEXT = "下一个";
L.NO = "不";
L.NONE = "无";
L.NOTE = "备注";
L.NOTHING = "无";
L.NO_BIDS_ACTION = "当无人出价时：";
L.NO_OFFICER_PRIVILEGES = "你没有官员特权";
L.OFFSPEC_ABBR = "副天赋";
L.OK = "好的";
L.OPEN = "打开";
L.OPEN_AUCTIONEER = "打开拍卖界面";
L.OPEN_MULTI_AUCTION = "打开批量拍卖";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "GREED";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORE";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "NEED";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASS";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "RANDOM";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SELF";
L.PACKMULE_CONFIRM_DISENCHANTER = "将 %s 设置为你的分解者？";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "将 %s 发送给 %s？输入 /gl cd 来删除这个分解者！";
L.PACKMULE_NO_DISENCHANTER_WARNING = "没有设置分解者，使用 /gl sd [mydisenchanter] 设置一个";
L.PACKMULE_WHO_IS_DISENCHANTER = "谁是你的分解者？";
L.PAID = "已付";
L.PASS = "跳过";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "玩家";
L.PLAYER_ITEM_WON_COUNT = "%s 赢得该物品：";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = " Plus Ones ";
L.PLUSONES_AWARD_DIALOG_LABEL = "添加+1";
L.PLUSONES_BROADCAST_CONFIRM = "您确定要将您的+1数据广播给您的队伍/团队中的每个人吗？";
L.PLUSONES_BROADCAST_PROCESS_START = "正在尝试处理来自 %s 的传入 PlusOnes 数据";
L.PLUSONES_CLEAR_CONFIRM = "%s 想要清除您的所有 PlusOne 数据。清除所有数据？";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "您确定要清除现有的 PlusOne 数据并导入 %s 广播的新数据吗？";
L.PLUSONES_IMPORT_CONFIRM = "您确定要导入 %s 广播的新数据吗？";
L.PLUSONES_IMPORT_ERROR = "提供的数据无效。确保内容遵循所需的格式并且不包含标题行";
L.PLUSONES_IMPORT_INFO = [[
在这里，您可以从 CSV 或 TSV 格式的表格或从 Google 文档表粘贴的数据导入加一数据。

该表至少需要两列：玩家姓名，后跟分数。附加列将被忽略。

这是一个示例行：

福巴，240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "自动接受来自 %s 的传入广播";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "阻止所有传入的 +1 共享数据";
L.PLUSONES_UPDATE_CONFIRM = [[
您确定要使用 %s 中的数据更新现有的 PlusOne 数据吗？

您的最新更新是在 |c00A79EFF%s 上，他们的最新更新是在 |c00A79EFF%s 上。]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "底池";
L.PRICE = "价格";
L.PRIOLIST_ABBR = "PL";
L.QUALITY_COMMON = "常见的";
L.QUALITY_EPIC = "史诗";
L.QUALITY_HEIRLOOM = "传家宝";
L.QUALITY_LEGENDARY = "传奇的";
L.QUALITY_POOR = "贫穷的";
L.QUALITY_RARE = "稀有的";
L.QUALITY_UNCOMMON = "罕见";
L.QUEUE = "队列";
L.RAIDERS = "攻略";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "谁失踪了";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "显示缺失的球员姓名";
L.RAIDGROUPS_DISBAND_BUTTON = "解散突袭";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "解散你的袭击";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s 在名册上被列出两次！";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "|c00FFF569Raid-Helper 导出（使用“垂直排序的组”变体）或 |c00FFF569Gargul 组组合 CSV：";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
在下面的大编辑框中，您可以提供名单并：邀请所有人，检查谁失踪了，应用组并分配坦克。

您可以提供 |c00FFF569Wowhead raid 组成链接：]];
L.RAIDGROUPS_GARGUL_BUTTON = "加尔古尔集团维基";
L.RAIDGROUPS_GARGUL_INFO = "访问 Gargul 组 wiki，了解有关 raid 组格式的更多信息";
L.RAIDGROUPS_IMPOSTER_WARNING = "以下球员不属于名单：%s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "提供的组数据无效，请检查您的格式！";
L.RAIDGROUPS_INVITE_BUTTON = "邀请";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "向名单上的玩家发送邀请";
L.RAIDGROUPS_IN_COMBAT_WARNING = "当 %s 处于战斗状态时无法对组进行排序！"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "你需要参加突袭！";
L.RAIDGROUPS_NO_TANKS_WARNING = "没有定义坦克";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "找不到 %s 的位置，您是否想将 5 人以上分成 1 组？";
L.RAIDGROUPS_PURGE_BUTTON = "踢掉不需要的球员";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "踢掉不在名单上的球员";
L.RAIDGROUPS_SORTING_ERROR = "移动 %s 时出了点问题";
L.RAIDGROUPS_SORTING_FINISHED = "完成申请raid名册";
L.RAIDGROUPS_SORTING_GROUPS = "对组进行排序";
L.RAIDGROUPS_SORT_BUTTON = "应用组";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "根据名单对组进行排序";
L.RAIDGROUPS_SORT_IN_PROGRESS = "排序还在进行中，请稍等！";
L.RAIDGROUPS_TANKS_ASSIGNED = "所有坦克均已分配";
L.RAIDGROUPS_TANK_BUTTON = "分配坦克";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Wowhead 比较工具";
L.RAIDGROUPS_WOWHEAD_INFO = "您可以使用下面的 URL 访问 wowhead comp 工具。创建组合后，您可以将其粘贴到此处或 Gargul 组窗口的大型编辑字段中";
L.REMOVE_BID = "删除出价";
L.RESET_SETTINGS = "重新设置";
L.RESET_SETTINGS_CONFIRMATION = "您确定要重置 Gargul 的所有设置吗？这无法挽回！";
L.RESET_UI = "重置 Gargul UI";
L.RESET_UI_CONFIRMATION = "您确定要重置 Gargul 的所有窗口大小、位置和比例吗？这无法挽回！";
L.RESTORE = "恢复";
L.RESUME = "恢复";
L.RIGHT_SYMBOL = ">";
L.ROLL = "卷";
L.ROLLING_AWARD_CONFIRM = "将 %s 奖励给 %s？";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "即将获奖";
L.ROLLING_CLOSE_ON_START_LABEL = "开始时关闭";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "按住shift绕过奖励确认";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "按住shift键即可显示获奖确认信息";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
警告：发现了另一个相同的卷，这可能表明平局

]];
L.ROLLING_INVALID_START_DATA_WARNING = "为开始卷提供的数据无效！";
L.ROLLING_ITEM_WON_BR_COST = "（BR：%s）";
L.ROLLING_ITEM_WON_GIVEN = "（给出的项目：是）";
L.ROLLING_ITEM_WON_NOT_GIVEN = "（给出的项目：无）";
L.ROLLING_ITEM_WON_OS = "（操作系统）";
L.ROLLING_NOTE_LABEL = "笔记";
L.ROLLING_NO_ROLLOFF_WARNING = "无法停止滚滚，没有正在进行滚滚";
L.ROLLING_PASS_BUTTON = "经过";
L.ROLLING_REOPEN_ROLL_COUNT = "卷数：%s";
L.ROLLING_REOPEN_TOOLTIP = "打开掠夺大师窗口";
L.ROLLING_ROLL_ACCEPTED = "滚滚接受！";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "当前正在进行滚动";
L.ROLLING_ROLL_PRIOLIST = "优先[%s]";
L.ROLLING_ROLL_SR_COUNT = "SR [%sx]";
L.ROLLING_ROLL_WISHLIST = "愿望[%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "您需要先选择一名玩家";
L.ROLLING_TIMER_LABEL = "计时器";
L.ROLLING_UNUSABLE_ITEM = "您不能使用该物品！";
L.ROLLING_WINNER_NOT_UNIQUE = "获奖者的名字不是唯一的，请选择您想要将 %s 奖励给的玩家";
L.SECONDS_ABBR = "s";
L.SELECT_ALL = "选择/禁用全部";
L.SETTINGS = "设置";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "宣布收到的投标";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "奖励物品后宣布底池";
L.SETTINGS_ANNOUNCE_START = "宣布拍卖开始";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "宣布突袭警告倒计时";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "在突袭警告中宣布收到的投标";
L.SETTINGS_RESET_UI = "重置 Gargul UI";
L.SETTINGS_WHISPER_BID_TOO_LOW = "如果出价太低，则对投标人耳语";
L.SILVER_INDICATOR = "s";
L.SKIP = "跳过";
L.SOFTRES = "软储备";
L.SOFTRES_ABBR = "SR";
L.SOFTRES_BROADCAST_CONFIRM = "您确定要将您的软件数据广播给您的队伍/突袭中的每个人吗？";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "无法处理从 %s 收到的 SoftRes 数据";
L.SOFTRES_CLEAR_CONFIRM = "您确定要清除所有现有的软保留数据吗？";
L.SOFTRES_EVERYONE_RESERVED = "每个人都填满了软储备";
L.SOFTRES_FEATURE_MISSING = [[
硬储备信息不可用，因为软储备
提供的内容不是使用 softres.it 上的“Gargul Export”按钮生成的]];
L.SOFTRES_IMPORT_DETAILS = "导入于 |c00A79EFF%s |c00A79EFF%s";
L.SOFTRES_IMPORT_FIXED_NAME = "自动名称修复：“%s”的 SR 现在链接到“%s”";
L.SOFTRES_IMPORT_INFO = "为了开始，您首先需要在 softres.it 上创建一个 raid。然后单击“Addon Export”，选择“Gargul”，复制数据并将其粘贴到下面的表单中。";
L.SOFTRES_IMPORT_INVALID = "提供的软储备数据无效";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "提供的数据无效。确保单击 softres.it 上的“Gargul Export”按钮并将完整内容粘贴到此处";
L.SOFTRES_IMPORT_NEW_PLUSONES = "提供的 PlusOne 值与已存在的值发生冲突。您想替换旧的 PlusOne 值吗？";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "以下玩家没有保留任何东西：";
L.SOFTRES_IMPORT_SUCCESSFUL = "软储备导入成功";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "导入成功！";
L.SOFTRES_IMPORT_USE_GARGUL = "SoftRes Weakaura 和 CSV 数据已弃用，请改用 Gargul 导出！";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "无法连接到 LootReserve，请联系支持人员（包括下面的消息）";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "没有可用的 softres.it URL，请确保使用 softres.it 上的“Gargul Export”按钮导出！";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "单击此处查看硬预订信息";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "没有硬性保留的项目";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "没有可用的硬性保留信息";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "发布缺失的 SR";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "发布 SR 网址";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "该玩家没有保留任何东西！";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "正在尝试处理来自 %s 的传入 SoftRes 数据";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "此商品为硬性保留商品";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "对于：%s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 注意：%s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "保留者";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "出了些问题！";
L.START = "开始";
L.STOP = "停止";
L.TAB_REPLACES_T = "\\t is replaced by a tab";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "时间";
L.TITLE = "标题";
L.TMBETC = "TMB、DFT 或 PRIO3";
L.TMB_BROADCAST_CONFIRM = "您确定要将 TMB 数据广播给队伍/团队中的每个人吗？注意：每个人都可以看到您的 TMB 数据，无论其在 TMB 网站上的权限如何！";
L.TMB_BROADCAST_PROCESS_START = "正在尝试处理来自 %s 的传入 TMB 数据";
L.TMB_CLEAR_CONFIRM = "您确定要清除所有加一数据吗？";
L.TMB_CLEAR_RAIDER_DATA = "清除袭击者数据";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "清除所有袭击者的 TMB 数据？";
L.TMB_IMPORT_CPO_INFO = "在您的 classicpr.io 运行中单击“Gargul Export”按钮并复制内容。然后将内容按原样粘贴到下面的框中，然后单击“导入”。就是这样！";
L.TMB_IMPORT_DFT_INFO = "按照工作表的说明导出 DFT 数据。然后将内容按原样粘贴到下面的框中，然后单击“导入”。就是这样！";
L.TMB_IMPORT_INVALID_CSV = "提供的 CSV 无效，格式为：6948,player1,player2";
L.TMB_IMPORT_INVALID_DFT = "提供的 DFT 数据无效，请按照工作表的说明导出您的 DFT 数据，然后按原样将内容粘贴到此处！";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "提供的 TMB 数据无效，请务必单击 Gargul 部分中的“下载”按钮并将内容按原样粘贴到此处！";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "提供的 TMB 或 DFT 数据无效，请确保将导出内容按原样粘贴到此处！";
L.TMB_IMPORT_PLAYER_NO_DATA = "以下玩家没有 %s 条目："; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "如何将 Gargul 与 ${source} 结合使用";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "将 TMB 导出内容按原样粘贴到下面的框中，然后单击“导入”";
L.TMB_NO_BROADCAST_TARGETS = "您的群组中没有人可以向其广播";
L.TMB_SYNCED = "TMB 数据已同步";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF 注： |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "（操作系统）";
L.TMB_TOOLTIP_PRIO_HEADER = "%s 优先级列表"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF 等级：%s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "TMB 愿望清单";
L.TOGGLE_DATES = "显示/隐藏日期";
L.TOGGLE_QUEUE = "显示/隐藏队列";
L.TRADETIME_AWARD_HOWTO = "%s 奖励战利品！";
L.TRADETIME_ROLL_HOWTO = "%s 推出战利品！";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "隐藏所有获奖物品";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "隐藏不再抱有幻想的物品";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "隐藏奖励给自己的物品";
L.TRADE_ANNOUNCE = "公告交易";
L.TRADE_ANNOUNCE_INFO = "向群组公布交易详情，或在/不在群组中时公布交易详情";
L.TUTORIAL = "教程";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s 物品在袋子中、战利品窗口中，甚至在聊天中的链接上，将它们添加到拍卖队列中。
想要无需出价直接出售商品吗？使用 |c00A79EFF%s

您可以通过输入 |c00A79EFF/gl 拍卖直接打开 %s 窗口

Gargul 追踪 |c00FF0000 所有黄金交易。不希望交易成为此 GDKP 会议的一部分吗？交易时勾选“从GDKP中排除”复选框！

|c00FFF569你知道吗？
获奖物品将自动添加到交易窗口
Gargul 还可以为您处理自动抢劫。使用 |c00A79EFF/gl pm 查看
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
此窗口显示在任何给定日期已授予的所有项目（在左侧选择一个或多个日期）。

项目可以包含以下标签：

|c00A79EFFOS：因不合格而获奖
|c00A79EFFSR：此项目已软保留
|c00A79EFFWL：该项目已列入愿望清单（Thatsmybis）
|c00A79EFFPL：该项目已列入优先级（Thatsmybis、DFT、prio3）
]];
L.TUTORIAL_BIDDER_QUEUE = [[
您在这里看到的物品位于主盗贼的 GDKP 队列中
您可以删除它们、对它们出价以及隐藏不可用的项目（在左上角的设置中启用“隐藏不可用的项目”）

您可以调整窗口大小、移动窗口或最小化窗口。试试看！

对于战利品大师：在这里删除物品只会将它们从您的个人队列中删除，而不是实际的 GDKP 队列中！
]];
L.TUTORIAL_MORE_HELP = "需要更多帮助吗？";
L.TYPE = "类型"; -- As in type of roll or type of item
L.UNKNOWN = "未知";
L.UNKNOWN_COMM_ACTION = "未知的通讯操作“%s”，请务必更新 Gargul！";
L.UNLOCK = "解锁";
L.UPDATE_GARGUL = "更新gargul！";
L.VERSION_ABBR = "v";
L.VERSION_CHECK_BUTTON_REPORT = "报告";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "在群聊中报告过时的结果";
L.VERSION_CHECK_COLUMN_STATUS = "加尔古尔状态";
L.VERSION_CHECK_STATUS_CHECKING = "检查版本...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s：播放器是最新的
|c00F7922Ev%s：玩家需要更新他的附加组件
|c00BE3333%s：玩家没有 Gargul 或者使用不受支持的版本
|c00808080%s：玩家离线或忽略我们！
|c0000FFFF%s：该玩家在我们的忽略列表中！

]];
L.VERSION_CHECK_STATUS_IGNORED = "玩家被忽略！";
L.VERSION_CHECK_STATUS_OFFLINE = "离线";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "没有反应";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "没有反应：";
L.VERSION_CHECK_SUMMARY_OFFLINE = "离线：";
L.VERSION_CHECK_SUMMARY_OUTDATED = "过时的：";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "最新：";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul 已过时，更新后才能使用！";
L.VERSION_INVALID_WARNING = "Version:addRelease 中提供的版本字符串无效";
L.VERSION_UPDATE = "更新加古尔！";
L.VERSION_UPDATED = "|c00%sGargul 现已更新为 |c00%sv%s";
L.VERSION_UPDATE_AVAILABLE = "|c00A79EFFv%s 可在 CurseForge/Wago 上使用。您可以在不关闭游戏的情况下进行更新，只需确保 /reload ！";
L.WAIT_SECONDS_BEFORE_RETRY = "再重试之前请再等待 %s 秒";
L.WINDOW = "窗户";
L.WINDOW_HEADER = "加尔古尔 v%s";
L.WINDOW_SCALE = "窗秤";
L.WISHLIST_ABBR = "WL";
L.YES = "是的";
L.YOU_DISABLED_GDKP_QUEUES = "您禁用了 GDKP 队列";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "无法使用 zlib 压缩数据。通过 https://discord.gg/D3mDhYPVzf 联系支持人员";
L.ZLIB_DECOMPRESS_WARNING = "无法解压缩 zlib 数据。确保按原样复制/粘贴它，而不添加任何其他字符或空格！";
