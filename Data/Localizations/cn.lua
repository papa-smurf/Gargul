local _, GL = ...;
--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "zhCN") then return; end
local L = Gargul_L or {};

L.GARGUL = "Gargul";

L.GOLD_INDICATOR = "g";
L.SILVER_INDICATOR = "s";
L.COPPER_INDICATOR = "c";

L.HELLO = "|cff%sGargul v%s|r 作者：Zhorax@Firemaw。输入 |cff%s/gl|r 或 |cff%s/gargul|r 即可开始！";
L.ALL_SETTINGS = "所有设置";
L.ANTISNIPE = "反狙击";
L.ANTISNIPE_EXPLANATION = [[

Anti Snipe 值为 10 意味着任何出价
剩余时间少于 10 秒会将计时器重置回 10 秒

您可以将此留空或设置为 0 以完全禁用反狙击。
不支持小于 5 的反狙击值

]];
L.ZERO_SIGN = "0";
L.AUCTIONEER = "拍卖";
L.AUCTION = "拍卖";
L.AUCTIONS = "拍卖";
L.AUTO_AWARD = "汽车奖";
L.AUTO_TRADE_OPTIONS = "汽车贸易";
L.BID = "出价";
L.BIDS = "出价";
L.UNKNOWN = "未知";
L.BY = "经过"; -- As in "bid BY"
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.BONUS_FEATURE_EXPLANATION = "Gargul 有一些你可能不知道的技巧。来看看吧！";
L.BOOSTED_ROLLS = "增强滚动";
L.BROADCAST = "播送";
L.BROADCAST_INC_AWARDED = "包括获奖项目";
L.BROADCAST_INC_DISENCHANTED = "包括不再抱有幻想的物品";
L.BROADCAST_INC_HIDDEN = "包括隐藏项目";
L.BROADCAST_INC_TIME_LEFT = "包括剩余时间";
L.BROADCAST_NO_DATA = "没有什么可广播的";
L.BROADCAST_NUMBER_OF_ITEMS = "东西的个数";
L.BROADCAST_TARGET_PLAYER = "目标玩家（仅低声）";
L.BROADCAST_TARGET_REQUIRED = "耳语需要目标玩家";
L.BROADCAST_TRADE_TIME_LEFT = "剩余最大交易时间（分钟）";
L.FILL = "充满";
L.CANCEL = "取消";
L.ENABLE = "使能够";
L.NEW = "新的";
L.ABOUT = "关于";
L.NOTE = "笔记";
L.OK = "好的";
L.CHANGE_SCALE = "调整比例";
L.CHANNEL = "渠道";
L.CHANNEL_OFFICER = "官";
L.CHANNEL_WHISPER = "耳语";
L.CHANNEL_RAID_WARNING = "袭击警告";
L.CLOSE = "关闭";
L.CLOSE_ON_AWARD = "即将获奖";
L.CLOSE_ON_START = "开始时关闭";
L.COMMUNICATION = "沟通";
L.CUT_MAIL_IN_PROGRESS = "稍等一下，我们还在处理之前的邮件";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "您没有足够的金币来支付 %s";
L.CUT_MAILBOX_CLOSED = "邮箱关闭后无法发送邮件";
L.CUT_MAIL_FAILED = "无法将剪辑发送至 %s";
L.CUT_MAILS_FAILED = "检测到多个邮件错误，中止剪切分发";
L.CUT_MAIL_HISTORY = "|c00967FD2%s|r 的邮件历史记录";
L.CUT_SENT = "已发送 %sg 至 %s";
L.CUT_MAIL_BODY = "由 Gargul 提供支持：一款主战利品工具，支持 TMB、SoftRes、GDKP 和自动战利品！";
L.CUT_MAIL_GOLD_MISMATCH = "邮件已根据游戏发送，但您剩余的金币不匹配，是不是出了什么问题？";
L.CUT_MAIL_EVEN = "你不欠%s任何金币";
L.CUT_MAIL_SUBJECT = "加古尔 GDKP：%sg";
L.DELETE = "删除";
L.DISABLE = "禁用";
L.EDIT = "编辑";
L.DETAILS = "细节";
L.SELECT_ALL = "选择/禁用全部";
L.IMPORT = "进口";
L.EXPORT = "出口";
L.FINAL_CALL = "最后呼叫";
L.LEDGER = "分类帐";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s|r 包里的物品、战利品窗口甚至聊天中的链接上的物品，将它们添加到此拍卖队列中。
当前拍卖完成后，队列中的物品将自动拍卖。单击“%s”按钮可以防止这种情况发生。

想要 Gargul 自动为您授予或取消拍卖吗？打开左侧的设置轮！

|c00FFF569你知道吗？|r
您可以通过拖放来移动项目
即使您|c00A79EFF/reload|r，项目也会被记住
排队的物品会自动显示给拥有 Gargul 的袭击者，以便他们可以预先出价
Gargul 还可以为您处理自动抢劫。使用 |c00A79EFF/gl pm|r 查看
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "隐藏不可用的物品";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "你确定吗？您将无法查看或竞价即将推出的商品！";
L.GDKP_PAYOUT_INACTIVE = "未检测到活动的 GDKP 会话或会话未锁定支付！";
L.GDKP_SESSION = "GDKP 会议";
L.GDKP_SHOW_UPCOMING = "显示即将推出的商品";
L.GDKPS_ARE_NOT_ALLOWED = "此版本的魔兽世界不允许 GDKP 突袭";
L.GROUP = "团体";
L.GROUP_MANAGER = "集团经理";
L.IMPORT_EXPLANATION = "您想导入什么类型的数据？";
L.INFO = "信息";
L.INC = "公司";
L.INCLUDE_BOES = "包括京东方";
L.INCLUDE_AWARDED = "包括以前授予的项目";
L.INCLUDE_MATERIALS = "包含材料（如深渊水晶）";
L.INCREMENT = "增量";
L.INVALID_DATA_WARNING = "提供的数据无效";
L.SOMETHING_WENT_WRONG_WARNING = "出了些问题！";
L.HALT = "停";
L.HIDE = "隐藏";
L.TITLE = "标题";
L.RESTORE = "恢复";
L.MIN = "最小";
L.MAXIMIZE = "最大化";
L.MAIL = "邮件";
L.MAIL_CUTS_EXPLANATION = "邮寄给玩家";
L.MINIMIZE = "最小化";
L.MINIMIZE_ON_AWARD = "尽量减少奖励";
L.MINIMIZE_ON_START = "启动时最小化";
L.BID = "出价";
L.MINIMUM = "最低限度";
L.MINIMUM_QUALITY = "最低质量";
L.MINUS10 = "-10";
L.MULTI_AUCTION = "多重拍卖";
L.MOVE = "移动";
L.NEXT = "下一个";
L.NAME = "姓名";
L.NO_BIDS_ACTION = "当无人出价时：";
L.NO_OFFICER_PRIVILEGES = "你没有军官特权";
L.NOTHING = "没有什么";
L.OPEN = "打开";
L.OPEN_AUCTIONEER = "公开拍卖师";
L.OPEN_MULTI_AUCTION = "公开多重拍卖";
L.PLUS10 = "+10";
L.PLUSONES = "加号";
L.POT = "锅";
L.QUALITY_POOR = "贫穷的";
L.QUALITY_COMMON = "常见的";
L.QUALITY_UNCOMMON = "罕见";
L.QUALITY_RARE = "稀有的";
L.QUALITY_EPIC = "史诗";
L.QUALITY_LEGENDARY = "传奇的";
L.QUALITY_HEIRLOOM = "传家宝";
L.QUEUE = "队列";
L.REMOVE_BID = "删除出价";
L.RESET_SETTINGS = "重新设置";
L.RESET_SETTINGS_CONFIRMATION = "您确定要重置 Gargul 的所有设置吗？这无法挽回！";
L.RESET_UI = "重置 Gargul UI";
L.RESET_UI_CONFIRMATION = "您确定要重置 Gargul 的所有窗口大小、位置和比例吗？这无法挽回！";
L.RESUME = "恢复";
L.SKIP = "跳过";
L.SOFTRES = "软储备";
L.TIME = "时间";
L.TMBETC = "TMB、DFT 或 PRIO3";
L.TOGGLE_QUEUE = "显示/隐藏队列";
L.TOGGLE_DATES = "显示/隐藏日期";
L.TUTORIAL = "教程";
L.TUTORIAL_BIDDER_QUEUE = [[
您在这里看到的物品位于主盗贼的 GDKP 队列中
您可以删除它们、对它们出价以及隐藏不可用的项目（在左上角的设置中启用“隐藏不可用的项目”）

您可以调整窗口大小、移动窗口或最小化窗口。试试看！

对于战利品大师：在这里删除物品只会将它们从您的个人队列中删除，而不是实际的 GDKP 队列中！
]];
L.TUTORIAL_MORE_HELP = "需要更多帮助吗？";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s|r 包里的物品、战利品窗口甚至聊天中的链接上的物品，将它们添加到拍卖队列中。
想要无需出价直接出售商品吗？使用 |c00A79EFF%s|r

您可以通过输入 |c00A79EFF/gl auction|r 直接打开 %s 窗口

Gargul 追踪 |c00FF0000ALL|r 黄金交易。不希望交易成为此 GDKP 会议的一部分吗？交易时勾选“从GDKP中排除”复选框！

|c00FFF569你知道吗？|r
获奖物品将自动添加到交易窗口
Gargul 还可以为您处理自动抢劫。使用 |c00A79EFF/gl pm|r 查看
]];
L.UPDATE_GARGUL = "更新加古尔！";
L.WINDOW = "窗户";
L.WINDOW_SCALE = "窗秤";
L.YOU_DISABLED_GDKP_QUEUES = "您禁用了 GDKP 队列";

L.SETTINGS_ANNOUNCE_START = "宣布拍卖开始";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "奖励物品后宣布底池";
L.SETTINGS_WHISPER_BID_TOO_LOW = "如果出价太低，则对投标人耳语";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "宣布突袭警告倒计时";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "宣布收到的投标";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "在突袭警告中宣布收到的投标";

--[[ GROUP VERSION CHECK (/gl version) ]]
L.VERSION_CHECK_COLUMN_STATUS = "加尔古尔状态";

L.VERSION_CHECK_STATUS_CHECKING = "检查版本...";
L.VERSION_CHECK_STATUS_IGNORED = "玩家被忽略！";
L.VERSION_CHECK_STATUS_OFFLINE = "离线";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "没有反应";
L.VERSION_CHECK_STATUS_EXPLANATION = ([[
|c0092FF00v%s|r: the player is up-to-date
|c00F7922Ev%s|r: the player needs to update his add-ons
|c00BE3333%s|r: the player doesn't have Gargul or is on an unsupported version
|c00808080%s|r: the player is offline or is ignoring us!
|c0000FFFF%s|r: the player is on our ignore list!

]]):format(GL.version, GL.version, L.VERSION_CHECK_STATUS_UNRESPONSIVE, L.VERSION_CHECK_STATUS_OFFLINE, L.VERSION_CHECK_STATUS_IGNORED);

L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "最新：";
L.VERSION_CHECK_SUMMARY_OUTDATED = "过时的：";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "没有反应：";
L.VERSION_CHECK_SUMMARY_OFFLINE = "离线：";

L.VERSION_CHECK_BUTTON_REPORT = "报告";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "在群聊中报告过时的结果";

--[[ GLOBAL ]]
L.DFT = "密度泛函理论";
L.LEFT_SYMBOL = "<";
L.RIGHT_SYMBOL = ">";
L.BIND_ON_EQUIP_ABBR = "京东方";
L.CLASSICPRIO_ABBR = "心肺复苏";
L.THATSMYBIS_ABBR = "TMB";
L.WISHLIST_ABBR = "WL";
L.PRIOLIST_ABBR = "PL";
L.MAINSPEC_ABBR = "多发性硬化症";
L.OFFSPEC_ABBR = "操作系统";
L.VERSION_ABBR = "v";
L.SOFTRES_ABBR = "SR";
L.BOOSTED_ROLLS_ABBR = "BR";
L.SECONDS_ABBR = "s";

L.PLUS_SIGN = "+";
L.WINDOW_HEADER = "Gargul " .. L.VERSION_ABBR .. "%s" -- %s is Gargul's version number
L.YES = "是的";
L.NO = "不";
L.START = "开始";
L.STOP = "停止";
L.PASS = "经过";
L.AUTO = "汽车";
L.CLEAR = "清除";
L.AWARD = "奖";
L.NONE = "没有任何";
L.DISENCHANT = "祛魅";
L.SETTINGS = "设置";
L.PLUS1 = "+1";
L.AWARD_HISTORY = "获奖历史";
L.PLAYER = "玩家";
L.PAID = "有薪酬的";
L.CUT = "切";
L.CUTS = "削减";
L.GIVEN = "给定";
L.MAILED = "邮寄";
L.BALANCE = "平衡";
L.ROLL = "卷";
L.NOTE = "笔记";
L.ITEM = "物品";
L.HEADER = "标头";
L.FORMAT = "格式";
L.TAB_REPLACES_T = "\t 被替换为制表符";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.TYPE = "类型"; -- As in type of roll or type of item*
L.PLAYER_ITEM_WON_COUNT = "%s 赢得的物品：";
L.ARE_YOU_SURE = "你确定吗？";
L.IMPORT_SUCCESSFUL = "导入增强滚动数据成功";
L.BROADCAST_IN_PROGRESS_ERROR = "播出仍在进行中";
L.BROADCASTING_NOTIFICATION = "广播...";
L.BROADCAST_FINISHED = "播出完毕！";
L.AWARDED_TO = "颁奖给";
L.PRICE = "价格";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = L.BOOSTED_ROLLS_ABBR .. "：%s";
L.AWARDED_TOOLTIP_GDKP_COST = "价格";
L.AWARDED_TOOLTIP_GIVEN = "给出：是的";
L.AWARDED_TOOLTIP_NOT_GIVEN = "给出：没有";
L.AWARDED_TOOLTIP_SECOND_BID = "第二次出价：%s，%s";
L.AWARDED_YOU_WON = "你赢了";
L.LM_OR_ASSIST_REQUIRED = "您需要成为抢劫大师或担任协助/主角！";
L.COMM_PROGRESS = "已发送 %s 个字节，共 %s 个字节";
L.BROADCAST_DELAYED_BY_COMBAT = "您目前正处于战斗状态，延迟播出";
L.UNKNOWN_COMM_ACTION = "未知的通讯操作“%s”，请务必更新 Gargul！";
L.IMPORTED_AND_UPDATED_ON = "导入于 |c00A79EFF%s|r |c00A79EFF%s|r，更新于 |c00A79EFF%s|r |c00A79EFF%s|r";

L.BASE64_DECODE_WARNING = "无法对数据进行 Base64 解码。确保按原样复制/粘贴它，而不添加任何其他字符或空格！";
L.ZLIB_DECOMPRESS_WARNING = "无法解压缩 zlib 数据。确保按原样复制/粘贴它，而不添加任何其他字符或空格！";
L.ZLIB_COMPRESS_WARNING = ("Unable to zlib compress the data. Contact support via %s"):format(L.DISCORD_URL);
L.JSON_DECODE_WARNING = "无法对数据进行 JSON 解码。确保按原样复制/粘贴它，而不添加任何其他字符或空格！";

L.TUTORIAL_AWARD_OVERVIEW = ([[
This window shows all the items that have been awarded on any given date (select one or more dates on the left).

Items can contain the following tags:

|c00A79EFF%s|r: Awarded for offspec
|c00A79EFF%s|r: This item was soft-reserved
|c00A79EFF%s|r: This item was wishlisted (Thatsmybis)
|c00A79EFF%s|r: This item was priolisted (Thatsmybis, DFT, prio3)
]]):format(L.OFFSPEC_ABBR, L.SOFTRES_ABBR, L.WISHLIST_ABBR, L.PRIOLIST_ABBR);

--[[ AWARDED LOOT EXPORTER /gl ah ]]
L.EXPORT_READ_ONLY_NOTICE = "这只是导出功能，没有必要编辑任何值：它们不会被保存！\n\n";
L.EXPORT_DELETE_ALL_CONFIRM = "您确定要删除完整的奖励历史记录表吗？这将删除所有战利品数据并且无法撤消！";
L.EXPORT_DELETE_DATE_CONFIRM = "您确定要删除 %s 的所有数据吗？这不能被撤消！";

--[[ BAGINSPECTOR /gl inspect itemID1, itemID2 ]]
L.BAGINSPECTOR_START = "开始检查...";
L.BAGINSPECTOR_FINISHED = "检验完毕";
L.BAGINSPECTOR_FAILED = "袋子检查失败：未收到报告";

--[[ BOOSTED ROLLS /gl br ]]
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!奖金|!rb|!br";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "您确定要清除所有增强滚动数据吗？";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "您确定要将增强的掷骰数据广播给队伍/团队中的每个人吗？";
L.BOOSTED_ROLLS_IMPORT_ERROR = "提供的数据无效。确保内容遵循所需的格式并且不包含标题行";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "没什么可播的，先导入 Boosted Rolls 数据！";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "无法处理从 %s 收到的 BoostedRolls 数据";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "正在尝试处理来自 %s 的传入 BoostedRolls 数据";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = "您确定要使用来自 %s 的数据更新现有的增强卷吗？\n\n您的最新更新是在 |c00A79EFF%s|r 上，他们的最新更新是在 |c00A79EFF%s|r 上。";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "您确定要清除现有的增强滚动数据并导入 %s 广播的新数据吗？";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = "您可以在此处从 CSV 或 TSV 格式的表格或从 Google 文档表粘贴的表格导入增强掷骰数据和别名。\n\n该表格至少需要两列：玩家姓名，后跟分数。其他列是可选的，并且可能包含播放器的别名。\n以下是示例行：\n\nFoobar,240,Barfoo";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "应用别名";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "添加缺失的袭击者";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "为突袭添加积分";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = "为当前团队中的每个人添加多少积分？\n\n|c00BE3333如果您希望每个人都获得积分，请先使用“添加缺失的袭击者”按钮，即使是那些没有增强掷骰条目的人！|r";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "删除%s？";
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "不提供积分值！";
L.BOOSTED_ROLLS_POINTS = "积分";
L.BOOSTED_ROLLS_RESERVE = "预订";
L.BOOSTED_ROLLS_ALIASES = "别名";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "增加滚动成本：";

--[[ PLUS ONES /gl +1 ]]
L.PLUSONES_IMPORT_INFO = [[
在这里，您可以从 CSV 或 TSV 格式的表格或从 Google 文档表粘贴的数据导入加一数据。

该表至少需要两列：玩家姓名，后跟分数。附加列将被忽略。

这是一个示例行：

福巴，240
]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUSONES_CLEAR_CONFIRM = "您确定要清除所有加一数据吗？";
L.PLUSONES_BROADCAST_CONFIRM = "您确定要将您的加一数据广播给您的队伍/团队中的每个人吗？";
L.PLUSONES_IMPORT_ERROR = "提供的数据无效。确保内容遵循所需的格式并且不包含标题行";
L.PLUSONES_BROADCAST_PROCESS_START = "正在尝试处理来自 %s 的传入 PlusOnes 数据";
L.PLUSONES_CLEAR_CONFIRM = "%s 想要清除您的所有 PlusOne 数据。清除所有数据？";
L.PLUSONES_UPDATE_CONFIRM = "您确定要使用 %s 中的数据更新现有的 PlusOne 数据吗？\n\n您的最新更新是在 |c00A79EFF%s|r 上，他们的最新更新是在 |c00A79EFF%s|r 上。";
L.PLUSONES_IMPORT_CONFIRM = "您确定要导入 %s 广播的新数据吗？";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "您确定要清除现有的 PlusOne 数据并导入 %s 广播的新数据吗？";
L.PLUSONES_AWARD_DIALOG_LABEL = "添加+1";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "阻止所有传入的 +1 共享数据";
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "自动接受来自 %s 的传入广播";

--[[ LOOTPRIORITY /gl lo ]]
L.LOOTPRIORITY_FORMAT_EXPLANATION = "提供以下格式的 prio CSV（每项 1 行）：id 或名称 > prio1、equalprio > prio2 > 等";
L.LOOTPRIORITY_INVALID_DATA = "提供的数据无效";
L.LOOTPRIORITY_INVALID_LINE = "第“%s”行中提供的数据无效：缺少项目 ID 或优先级";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "战利品优先级导入成功";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "战利品优先级已成功清除";
L.LOOTPRIORITY_PROCESS_INCOMING = "正在尝试处理来自 %s 的传入战利品优先级";
L.LOOTPRIORITY_TOOLTIP_HEADER = "战利品普里奥";

--[[ SOFTRES /gl sr ]]
L.SOFTRES_CLEAR_CONFIRM = "您确定要清除所有现有的软保留数据吗？";
L.SOFTRES_BROADCAST_CONFIRM = "您确定要将您的软件数据广播给您的队伍/突袭中的每个人吗？";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "单击此处查看硬预订信息";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "没有可用的硬性保留信息";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "没有硬性保留的项目";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "发布 SR 网址";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "发布缺失的 SR";
L.SOFTRES_FEATURE_MISSING = "硬保留信息不可用，因为提供的软保留\n不是使用 softres.it 上的“Gargul 导出”按钮生成的";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "该玩家没有保留任何东西！";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";

L.SOFTRES_IMPORT_INFO = "为了开始，您首先需要在 softres.it 上创建一个 raid。然后单击“Addon Export”，选择“Gargul”，复制数据并将其粘贴到下面的表单中。";
L.SOFTRES_IMPORT_DETAILS = "导入于 |c00A79EFF%s|r |c00A79EFF%s|r";
L.SOFTRES_IMPORT_INVALID = "提供的软储备数据无效";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "提供的数据无效。确保单击 softres.it 上的“Gargul Export”按钮并将完整内容粘贴到此处";
L.SOFTRES_IMPORT_SUCCESSFUL = "软储备导入成功";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "导入成功！";
L.SOFTRES_IMPORT_FIXED_NAME = "自动名称修复：“%s”的 SR 现在链接到“%s”";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "以下玩家没有保留任何东西：";
L.SOFTRES_IMPORT_NEW_PLUSONES = "提供的 PlusOne 值与已存在的值发生冲突。您想替换旧的 PlusOne 值吗？";
L.SOFTRES_IMPORT_USE_GARGUL = "SoftRes Weakaura 和 CSV 数据已弃用，请改用 Gargul 导出！";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "此商品为硬性保留商品";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "对于：%s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 注：|r %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "保留者";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "无法连接到 LootReserve，请联系支持人员（包括下面的消息）";
L.SOFTRES_PROCESS_INCOMING = "正在尝试处理来自 %s 的传入 SoftRes 数据";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "无法处理从 %s 收到的 SoftRes 数据";
L.SOFTRES_EVERYONE_RESERVED = "每个人都填满了软储备";
L.SOFTRES_NO_URL_AVAILABLE = "没有可用的 softres.it URL，请确保使用 softres.it 上的“Gargul Export”按钮导出！";

--[[ AWARD ]]
L.AWARD_TOOLTIP_ADD_ITEM = "拖放或按住 Shift 键单击右侧框中的项目";
L.AWARD_RANDOM_CONFIRM = "您想将 %s 奖励给随机玩家吗？";
L.AWARD_CONFIRM = "将 %s 奖励给 %s？";
L.AWARD_PLAYER_CUSTOM_NAME = "在此输入玩家姓名";
L.AWARD_PLAYER_SELECT_NAME = "或选择以下一项";
L.AWARD_HEADER_IN_GROUP = "组内";
L.AWARD_UNDO_CONFIRM = "您确定要撤消授予 %s 的 %s 奖励吗？%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.AWARD_UNDO_BR_REFUND = "%s 提升的掷骰点数将被退还！";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "失望的物品：";
L.AWARD_TOOLTIP_GIVEN = "（给出：是）";
L.AWARD_TOOLTIP_NOT_GIVEN = "（给出：没有）";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(" .. L.OFFSPEC_ABBR .. "）";
L.AWARD_TOOLTIP_BR_INDICATION = "（BR：%s）";
L.AWARD_NEW_WINNER_CONFIRMATION = "%s 应该去找谁？";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "您确定要分解%s吗？ %s 提升的掷骰点数将被退还！";

--[[ THATSMYBIS /gl tmb ]]
L.TMB_CLEAR_CONFIRM = "您确定要清除所有加一数据吗？";
L.TMB_BROADCAST_CONFIRM = "您确定要将 TMB 数据广播给队伍/团队中的每个人吗？注意：每个人都可以看到您的 TMB 数据，无论其在 TMB 网站上的权限如何！";
L.TMB_IMPORT_DFT_INFO = "按照工作表的说明导出 DFT 数据。然后将内容按原样粘贴到下面的框中，然后单击“导入”。就是这样！";
L.TMB_IMPORT_CPO_INFO = "在您的 classicpr.io 运行中单击“Gargul Export”按钮并复制内容。然后将内容按原样粘贴到下面的框中，然后单击“导入”。就是这样！";
L.TMB_IMPORT_TMB_INFO = "将 TMB 导出内容按原样粘贴到下面的框中，然后单击“导入”";
L.TMB_IMPORT_TMB_GARGUL_INFO = "如何将 Gargul 与 TMB 结合使用";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "提供的 TMB 数据无效，请务必单击 Gargul 部分中的“下载”按钮并将内容按原样粘贴到此处！";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "提供的 TMB 或 DFT 数据无效，请确保将导出内容按原样粘贴到此处！";
L.TMB_IMPORT_INVALID_CSV = "提供的 CSV 无效，格式为：6948,player1,player2";
L.TMB_IMPORT_INVALID_DFT = "提供的 DFT 数据无效，请按照工作表的说明导出您的 DFT 数据，然后按原样将内容粘贴到此处！";
L.TMB_IMPORT_PLAYER_NO_DATA = "以下玩家没有 %s 条目："; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_PRIO_HEADER = "%s 优先级列表"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_WISHLIST_HEADER = "TMB 愿望清单";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(" .. L.OFFSPEC_ABBR .. "）";
L.TMB_TOOLTIP_TIER = "|c00FFFFFF 层：|r %s";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF 注：|r |cFFFFF569%s|r";
L.TMB_NO_BROADCAST_TARGETS = "您的群组中没有人可以向其广播";
L.TMB_BROADCAST_PROCESS_START = "正在尝试处理来自 %s 的传入 TMB 数据";
L.TMB_SYNCED = "TMB 数据已同步";

--[[ VERSION /gl version ]]
L.VERSION_UPDATED = "|cff%sGargul|r 现已更新为 |cff%sv%s|r";
L.VERSION_INVALID_WARNING = "Version:addRelease 中提供的版本字符串无效";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul 已过时，更新后才能使用！";
L.VERSION_UPDATE_AVAILABLE = "v|c00A79EFFv%s|r 可在 CurseForge/Wago 上使用。您可以在不关闭游戏的情况下进行更新，只需确保 /reload ！";
L.VERSION_UPDATE = "更新加古尔！";

--[[ PACKMULE /gl pm ]]
L.PACKMULE_NO_DISENCHANTER_WARNING = "没有设置分解器，使用 /gl sd [mydisenchanter] 设置一个";
L.PACKMULE_WHO_IS_DISENCHANTER = "谁是你的幻灭者？";
L.PACKMULE_CONFIRM_DISENCHANTER = "将 %s 设置为你的祛魅者？";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "将 %s 发送给 %s？输入 /gl cd 来删除这个分解器！";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "经过";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "贪婪";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "需要";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "忽略";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "德";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "随机的";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "自己";

--[[ GDKP /gl gdkp ]]
L.GDKP = "GDKP";
L.GDKP_CUTS_ADJUST_G = "调整[克]";
L.GDKP_CUTS_ADJUST_P = "调整 [％]";
L.GDKP_AUCTIONS = "拍卖";
L.GDKP_CREATE = "创建新的 GDKP 会话";
L.GDKP_CREATE_SESSION_TYPE_LABEL = "拍卖类型（|c00A79EFFi|r 了解更多信息）";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFMulti-Auction|r 允许您一次对多个项目开始出价，从而加快速度！
创建此会话后按照说明开始操作

使用|c00A79EFFSingle-Auction|r，您可以选择拍卖单个物品或使用队列

选择 |c00A79EFFMulti-Auction|r 可防止将已丢弃的项目添加到队列中
您可以将 |c00A79EFFMulti-Auction|r 与 |c00A79EFFSingle-Auction|r 和队列混合使用，但我们强烈建议不要这样做

]];
L.GDKP_CREATE_SESSION_TYPE_MULTI = "多重拍卖";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "单次拍卖";
L.GDKP_CREATE_MANAGEMENT_CUT = "管理层削减%";
L.GDKP_CREATE_SESSION_SWITCH = "切换到此会话";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Management Cut 需要为空或介于 0 到 99 之间（没有 % 符号！）";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "选择会话类型！";
L.GDKP_CREATE_SUCCESSFUL = "会话已创建。我们建议您 /reload 以便正确存储它，以防您的游戏崩溃！";
L.GDKP_AUCTION_PAID_AMOUNT = "设置支付金额（左读）";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul 自动跟踪黄金交易。只要玩家付费
对于他们购买的东西，那么你不应该需要这个字段

“支付金额”是指买家已经向您交易的黄金数量。
这不会改变商品的实际价格！

警告：仅当玩家承诺付款时才在此处设置值
在突袭之外或通过替代/邮件等交易黄金！


]];
L.GDKP_SESSION_EDIT_TITLE = "正在编辑 %s";
L.GDKP_EXPORT_DEFAULT_HEADER = "物品、玩家、金币、Wowheadlink";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM、@WINNER、@GOLD、@WOWHEAD";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "自定义（创建您自己的格式）";
L.GDKP_EXPORT_AUCTIONS_JSON = "详细（JSON）";
L.GDKP_EXPORT_AUCTIONS_SHARE = "分享（可以被其他玩家导入）";
L.GDKP_EXPORT_CUSTOM_HEADER = "您的自定义标头";
L.GDKP_EXPORT_CUSTOM_FORMAT = "您的自定义格式";
L.GDKP_EXPORT_FORMAT_TITLE = "GDKP 会议的标题";
L.GDKP_EXPORT_FORMAT_START = "第一个项目被授予的日期/时间";
L.GDKP_EXPORT_POT_CHANGED = "锅换了";
L.GDKP_IMPORT_SESSION = "导入 GDKP 会话";
L.GDKP_IMPORT_SESSION_ABOUT = ("Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp|r where they select the '%s' format"):format(L.GDKP_EXPORT_AUCTIONS_SHARE);
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "%s 创建的 GDKP 会话似乎已存在，您要覆盖它吗？";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "您即将导入由 %s 创建的 GDKP 会话，您确定吗？";

L.GDKP_IMPORT_PRICES_ABOUT = [[
导入 GDKP 最低价格和增量。

格式如下：ItemID + 最小值或增量为必填项。 （|c00BE3333需要标头！！|r）：

|c00BE3333ItemID，最小值，增量|r|c00967FD2
18608,4000,500|r
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "删除现有的价格设置？单击“是”删除所有价格数据，单击“否”则使用您在此处提供的数据覆盖现有价格数据";
L.GDKP_LEDGER_MUTATION = "黄金 %s 由"; --%s = removed or added
L.GDKP_LEDGER_LEGEND_PAID_TO = "金币支付给%s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "从 %s 收到金币";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "金币已由 %s 邮寄给您";
L.GDKP_LEDGER_LEGEND_BALANCE = "余额： |c0092FF000|r ？你是方的！ | |c00BE333330|r？你欠 %s 30g | |c00F7922E50|r ？ %s欠你50g";
L.GDKP_LEDGER_POT = "总底池：%sg |管理层削减：%sg (%s%%) |分发：%sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s|r |作者：%s%s |在 |c00967FD2%s|r";

L.GDKP_OVERVIEW_POT_TOOLTIP = [[
底池：%s
管理削减（%s%%）：%sg
每名玩家削减 (1/%s)：%sg
]];
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "多重拍卖：一次拍卖多个物品！";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "锁定或解锁会话";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "解锁会话";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "锁定付款会话";
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "添加/删除黄金";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = "您需要领先或主战利品才能调整金币。\n您无法在锁定/删除的会话中调整金币";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = "显示分类帐的完整概述，\n非常适合屏幕截图！";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "附带拍卖的会话将在 48 小时后删除";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "从其他玩家或帐户导入会话";
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "导出会话，以便其他人可以查看会话详细信息，甚至取代您作为战利品大师";
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "解锁和更改底池或削减可能会变得非常混乱，特别是如果您已经支付完毕。你确定吗？";
L.GDKP_OVERVIEW_LOCK_CONFIRM = "锁定会话意味着您无法拍卖物品或以其他方式更改任何内容，直到您解锁它，您确定吗？";
L.GDKP_OVERVIEW_SESSION_DETAILS = "作者：%s%s |在 |c00%s%s|r%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_MUTATION_ADDED = "添加到";
L.GDKP_OVERVIEW_MUTATION_REMOVED = "已经从...删除";
L.GDKP_OVERVIEW_MUTATION_ENTRY = "|cFF%s%s|r %s 锅，作者：%s\n注意: %s"; -- i.e. 5000g added to pot by winner \n Note: I made a booboo
L.GDKP_OVERVIEW_AUCTION_ENTRY = "%s 为\n%s 支付了 |cFF%s%s|r"; -- i.e. Player paid 5000g for \n [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = "|cFFbe3333删除者|r %s\n原因: %s";
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "提供删除此条目的原因";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "删除。按住 Shift 键可绕过音符";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = "您需要引导或主战利品才能删除条目。\n您无法删除锁定/已删除会话中的条目";
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = "您需要主战利品或主战利品才能恢复条目。\n您无法恢复锁定/删除会话的条目";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = "您需要主战利品或主战利品才能编辑条目。\n您无法编辑已删除的条目或锁定/已删除会话中的条目";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "（积极的）";
L.GDKP_OVERVIEW_DELETED_SESSION = "（已删除）";

L.GDKP_TUTORIAL_TITLE = "入门";
L.GDKP_TUTORIAL_INFO = "按照以下步骤快速开始使用 Gargul GDKP！";
L.GDKP_TUTORIAL_STEP_NEW = "单击下面的 |c00FFF569New|r 按钮创建您的第一个 GDKP 会话。创建后会显示在左侧";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "单击下面的 |c00FFF569Enable|r 按钮激活此会话！";
L.GDKP_TUTORIAL_STEP_READY = "您已准备好出售物品了！ |c00BE3333在开始您的第一个 GDKP raid 之前，请仔细阅读以下所有步骤并自行测试它们（无需参加 raid）！";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s|r 要拍卖或排队单个项目的项目"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "想同时拍卖多件物品吗？运行 |c00FFF569/gl ma|r （或 |c00FFF569/gl multiauction|r）或单击此窗口右上角的多重拍卖图标！";
L.GDKP_TUTORIAL_STEP_SELL = "想要在没有人出价的情况下出售商品吗？ |c00FFF569%s|r 就某件商品，选出获胜者并设定价格！";
L.GDKP_TUTORIAL_STEP_DONE = "如果一切顺利，那么您将在这里看到新拍卖的物品！";
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
有用的命令：
- |c00FFF569/gdkp|r 打开此窗口
- |c00FFF569/gl ma|r 打开多重拍卖窗口
- |c00FFF569/gl au|r 打开单品拍卖师/队列
- |c00FFF569/gl pm|r 设置自动抢劫

]];


L.GDKP_ADD_DROPS_TO_QUEUE = "将掉落的战利品添加到队列中";
L.GDKP_ALL_CUTS_MAILED = "所有剪辑均已邮寄！";
L.GDKP_TRY_MULTIAUCTION = "查看多重拍卖！";
L.GDKP_TRADE_EXCLUDE_GOLD = "Exclude from GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "交易的黄金不会添加到给予或接收的金额中";
L.GDKP_TRADE_GOLD_TO_GIVE = "给予：%s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "接收：%s";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "您没有足够的钱来支付 %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "无法将 %s 添加到交易窗口。尝试手动添加！";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP 会议|r
玩家花费：%s
给定：%s
已收到：%s
球员切入：%s

%s
]];
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP 数据（已售出 %sx）|r
最后售价：%s
平均价格：%s
最低出价：%s
增量：%s

]];
L.GDKP_ACTIVATED = "GDKP 活跃！";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "缺少标题，注意：区分大小写！";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "缺少标题，注意：区分大小写！";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "玩家 %s 缺少金币";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "缺少球员姓名";
L.GDKP_CUT_IMPORT_EMPTY = "无需导入任何内容，请仔细检查您的 CSV";
L.GDKP_ADD_GOLD_TITLE = "调整 %s 中的金币";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "金（- 用于去除金）";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "支付方式：";
L.GDKP_ADD_GOLD_INVALID_WARNING = "黄金需要低于/高于 0";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "谁为此买单？";
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = "|cFF%s%sg|r 由 %s 添加到锅中\n注意: %s";
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = "%s 为\n%s 支付了 |cFF%s%sg|r";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = "|cFFbe3333删除者|r %s\n原因: %s";
L.GDKP_AUCTION_DETAILS_WON_BY = "获胜者：";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "由...制作";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "因失望而禁用";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "战斗中禁用";

L.GDKP_BIDDER_ITEM_PRICING = "最低出价：%sg 增量：%sg";
L.GDKP_BIDDER_NEW_BID_LABEL = "新出价";
L.GDKP_BIDDER_AUTO_BID = "自动出价";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "您的最高出价是多少？ （最小 %s|c00FFF569g|r）";
L.GDKP_BIDDER_STOP_AUTO_BID = "停止自动出价";
L.GDKP_BIDDER_BID_DENIED = "投标被拒绝！";
L.GDKP_BIDDER_MY_MAX_BID = "（最大 %sg）";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "最高出价：%s 由您出价";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "最高出价：%s，%s";

L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "未知的项目 ID：%s";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "项目 ID 需要最小值或增量：%s";
L.GDKP_PRICE_IMPORT_INVALID_INC = "为项目 ID“%s”提供的“增量”无效";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "为项目 ID“%s”提供的“最小值”无效";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "增量或最小值不能低于 0.0001！";
L.GDKP_AWARD_ITEM_CONFIRMATION = "为 %s 奖励 %s 给 %s？";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "已成功导入 %s 项数据";
L.GDKP_STOP_AUCTION_FIRST = "先停止拍卖吧！";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "没有足够的黄金可供分配，期待一些奇怪的削减计算！";
L.GDKP_NO_BIDS = "没有出价！";
L.GDKP_DELETE_BID_INFO = "删除出价。必须先停止拍卖！";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "未检测到传奇+物品的出价，请手动继续！";
L.GDKP_UNKNOWN_SESSION = "拍卖中未知的会话标识符：创建：%s";
L.GDKP_LOCKED_SESSION = "GDKP 会话不可用或已锁定";
L.GDKP_MULTIAUCTION_OUTBID = "你的出价被高估了！";
L.GDKP_INVALID_DATA_FOR_START = "为 GDKP 拍卖开始提供的数据无效！";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "为 GDKP 扩展提供的数据无效！";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "为 GDKP 缩短提供的数据无效！";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "为 GDKP 重新安排提供的数据无效！";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "拍卖中提供的时间无效：重新安排";
L.GDKP_MISSING_CONTENT_FOR_START = "拍卖中缺少内容：开始";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "不允许用户“%s”开始拍卖";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "不允许用户“%s”停止拍卖";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "不允许用户“%s”停止拍卖：拍卖无效";
L.GDKP_OUTBID = "你的出价被高估了！";
L.GDKP_INVALID_PAID_AMOUNT = "为“付费”提供的号码无效";
L.GDKP_AWARD_DIALOG_LABEL = "GDKP 价格：";
L.GDKP_YOU_OWE = "你欠 %s %s";
L.GDKP_THEY_OWE = "%s欠你%s";

L.GDKP_MULTIAUCTION_ABOUT = [[

通过多重拍卖（或批量拍卖），您可以一次拍卖任意数量的物品！
这极大地加快了你的突袭之夜，并为你的突袭者提供了无缝的体验

库存中的所有可交易物品都可以通过“从库存填充”自动拍卖
试一试！

|c00808080只有一个缺点：为了让人们参与批量拍卖，袭击者需要 Gargul！|r

]];
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "在聊天中宣布销售情况";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "出价高于时播放声音";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "更多声音选项...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "显示所有";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "显示收藏夹";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "隐藏不可用";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "显示不可用";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "显示/隐藏您无法使用的项目";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "隐藏非活动状态";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "显示非活动状态";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "显示/隐藏已完成的拍卖";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "打开此窗口后，将 %s 个项目添加到列表中";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "竞价窗口已关闭，请使用 |c00A79EFF/gl bid|r 重新打开！";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "关闭所有";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "关闭所有拍卖？";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
关闭所有拍卖

具有有效出价的拍卖将被出售，并且无法接受新的出价！
]];
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "给最后一个呼叫计时器多少秒？";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "最小秒数为 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = [[
所有拍卖的最终决定

对所有尚未售出的拍卖品进行最后的征集！
]];
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "关闭所有拍卖并结束本次多重拍卖？";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
完成多重拍卖环节

这将关闭所有拍卖并在聊天中公布总底池
具有有效出价的拍卖将被出售，并且无法接受新的出价！
]];

L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "终止";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "删除所有 bidsl 出价并结束所有拍卖？";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
终止多重拍卖会话

这将删除尚未售出的物品的所有出价并关闭所有拍卖！
]];
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "分解所有已完成但未售出的物品？";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
分解未售出的物品

这会将所有未售出的物品标记为幻灭，并且它们不会出现在新的多重拍卖会中
]];
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "单击齿轮图标来管理拍卖";
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "将鼠标悬停在下面的任何按钮上以获取更多信息";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "该商品已售出。使用分类帐（|c00%s/gdkp|r）进行更改！";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "结束拍卖。玩家不能再出价，但最高出价仍然有效";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "通过提供（通常较短的）出价计时器来开始本次拍卖的最终召集";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "明确出价";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "从拍卖中删除所有出价";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "从拍卖中删除该物品，包括其出价详细信息。这无法挽回！";
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "收藏该商品";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "管理拍卖";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "停止自动出价 (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "自动出价，最高可达您在左侧填写的出价";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "自动出价最高可达 %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "无法停止 %s 上的自动出价，请重试或/重新加载！";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "出价无效或出价过低！最小值为 %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "无法确认 %s 的出价";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "同一商品的两次出价之间需要等待两秒钟";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "您已经是 %s 的最高出价者";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "出价最低要求金额";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = "|c00%sSOLD|r 至\n%s |c00%s%sg|r";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = "|c00%s已关闭\n没有出价|r";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = "出价 |c00%s%sg|r\n出价 |c0092FF00YOU!|r";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = "出价 |c00%s%sg|r\n由 %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = "最小值: |c00%s%sg|r\n增量: |c00%s%sg|r";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "商品：%s - 售出总量：%sg - 我承诺的：%sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
出价项目：%s/%s
总销量：%s
我买的：%s
总出价（不包括已售出）：%s
我出价（不包括已售出）：%s
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "结束拍卖";

L.GDKP_DISTRIBUTE_ADDRAIDER = "将袭击者添加到此会话";
L.GDKP_MUTATOR_CREATE_NEW = "创建一个新的 GDKP 变异器";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "存储以备将来使用";
L.GDKP_MUTATOR_NAME_LABEL = "名称 [示例：坦克]";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "百分比 [示例：10]";
L.GDKP_MUTATOR_FLAT_LABEL = "固定黄金汇率 [示例：250]";
L.GDKP_MUTATOR_APPLY_LABEL = "自动应用于";
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "您可以使用关键字自动将此变异器应用于袭击者：";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = "示例:\n|c00967FD2SELF,RL,HEALER|r";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "变异器名称不能包含点 (.)";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "百分比必须是数字";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "统一费率必须是数字";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "统一费率必须是数字";
L.GDKP_MUTATOR_UNKNOWN = "未知变异子：%s";
L.GDKP_MAIL_ALL = "全部邮寄";

L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "球员、切入";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@玩家，@CUT";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "自定义（创建您自己的格式）";
L.AVAILABLE_PLACEHOLDER_VALUES = "可用值：";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "从玩家处收到的总金币";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "给予玩家的总金币";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "交易给玩家的金币";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "金币邮寄给玩家";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "第一个项目被授予的日期/时间";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "会话被锁定的日期/时间";

L.GDKP_IMPORT_CUTS_INFO = "您可以从自己的计算中导入球员剪辑，例如谷歌表格。软件资源GDKP等\n\n格式如下（|c00BE3333INCLUDE THE HEADER!!|r）：\n\n|c00BE3333Player,Gold|r|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n|r";
L.GDKP_IMPORT_CONSEQUENCES_INFO = "这将覆盖您对剪切窗口所做的任何更改，您确定吗？";

L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "您不能同时从同一玩家处给予和接收金币";
L.GDKP_TRADE_GIVEN_TO_LABEL = "金币|c00967FD2给予|r %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "金币 |c00967FD2 收到自 |r %s";

--[[ MULTIAUCTION  /gl ma ]]
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "您在 GDKP 竞标期间离开。为了恢复它，您必须为任何未售出的商品提供新的出价时间（以秒为单位）";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "为 GDKP 拍卖开始提供的数据无效！";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "战利品大师 (%s) 已过时，这可能会导致出价失败！";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s 为 %sg 购买了 %s";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "打开此窗口后，将 %s 件商品添加到列表中或点击下面的“从库存填充”"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "您需要有一个活跃的（解锁的）GDKP 会话！";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "有一个活跃的多重拍卖，您在此处添加的项目将被添加到现有会话中。请注意重复的项目！";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "您的 Gargul 已过时，我们建议在开始会话之前进行更新，以防止出现问题！";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "活动 GDKP 会话： |c00967FD2%s|r |作者：%s%s |在 |c00967FD2%s|r";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "搜索名称或 iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "支持项目名称和 iLVL，例如“252”、“<252”等";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "拍卖时间（秒）";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "秒反狙击";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "从列表中删除所有项目";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "将库存中的可交易物品添加到列表中";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "从库存中填充";
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "下一步：检查 raider 的附加版本的兼容性";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "至少选择一件物品进行拍卖";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "拍卖时间（以秒为单位）需要 >= 10";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "反狙击值需要为0（空）或>=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "返回项目选择器";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "不是每个人都在使用 Gargul，您确定要开始拍卖吗？";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "并不是每个人都是最新的。如果您遇到问题，请告诉您的袭击者进行更新！";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
您可以在此处确定要包含在多重拍卖会话中的物品

使用下面的 |c00A79EFFFill from inventory|r 按钮将仍可交易的物品添加到列表中
每当您清除并重新打开此窗口时，您最后的填充设置将用于自动添加项目

|c00A79EFF%s|r 项手动将其添加到列表中
]];

L.GDKP_UNKNOWN_ITEM = "拍卖中的未知 itemID：创建：%s";

--[[ LOOT MASTER ]]
L.LOOTMASTER_DEFAULT_NOTE = "/roll 对于 MS 或 /roll 99 对于操作系统";
L.LOOTMASTER_BAD_ADDONS = "您安装了一个或多个插件，可能会导致 Gargul 无法正常工作：%s";
L.LOOTMASTER_NOTICE_LABEL = "你被赋予了抢劫大师的角色";
L.LOOTMASTER_OPEN_LABEL = "自动打开此窗口";
L.LOOTMASTER_CLEAR_SR_BUTTON = "清晰的软资源";
L.LOOTMASTER_IMPORT_SR_BUTTON = "导入软件资源";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "清除TMB";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "进口TMB";

--[[ TRADE TIME ]]
L.TRADETIME_ROLL_HOWTO = "%s 推出战利品！";
L.TRADETIME_AWARD_HOWTO = "%s 奖励战利品！";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "隐藏所有获奖物品";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "隐藏奖励给自己的物品";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "隐藏不再抱有幻想的物品";

--[[ BONUS FEATURES ]]
L.BONUS_AUTO_INVITE = "1.从raid注册中自动邀请/排序组！单击下面或使用 |c00A79EFF/gl gr|r";
L.BONUS_BOOSTED_ROLLS = "2. 奖励常客或加倍努力的玩家！单击下面或使用 |c00A79EFF/gl br|r";
L.BONUS_PLUSONES = "3. Gargul 包含加一跟踪系统！单击下面或使用 |c00A79EFF/gl po|r";

--[[ RAID GROUPS /gl gr ]]
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = "在下面的大编辑框中，您可以提供名单并：邀请所有人，检查谁失踪了，应用组并分配坦克。\n\n您可以提供|c00FFF569Wowhead raid构成|r链接：";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "|c00FFF569Raid-Helper 导出|r（使用“垂直排序的组”变体）或 |c00FFF569Gargul 组组合|r CSV：";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Wowhead 比较工具";
L.RAIDGROUPS_WOWHEAD_INFO = "您可以使用下面的 URL 访问 wowhead comp 工具。创建组合后，您可以将其粘贴到此处或 Gargul 组窗口的大型编辑字段中";
L.RAIDGROUPS_GARGUL_BUTTON = "加尔古尔集团维基";
L.RAIDGROUPS_GARGUL_INFO = "访问 Gargul 组 wiki，了解有关 raid 组格式的更多信息";
L.RAIDGROUPS_INVITE_BUTTON = "邀请";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "向名单上的玩家发送邀请";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "谁失踪了";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "显示缺失的球员姓名";
L.RAIDGROUPS_SORT_BUTTON = "应用组";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "根据名单对组进行排序";
L.RAIDGROUPS_TANK_BUTTON = "分配坦克";
L.RAIDGROUPS_PURGE_BUTTON = "踢掉不需要的球员";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "踢掉不在名单上的球员";
L.RAIDGROUPS_DISBAND_BUTTON = "解散突袭";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "解散你的袭击";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "提供的组数据无效，请检查您的格式！";
L.RAIDGROUPS_NO_RAID_WARNING = "你需要参加突袭！";
L.RAIDGROUPS_SORT_IN_PROGRESS = "排序还在进行中，请稍等！";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s 在名册上被列出两次！";
L.RAIDGROUPS_IN_COMBAT_WARNING = "当 %s 处于战斗状态时无法对组进行排序！"; -- %s holds a player name
L.RAIDGROUPS_IMPOSTER_WARNING = "以下球员不属于名单：%s";
L.RAIDGROUPS_NO_TANKS_WARNING = "没有定义坦克";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "找不到 %s 的位置，您是否想将 5 人以上分成 1 组？";
L.RAIDGROUPS_TANKS_ASSIGNED = "所有坦克均已分配";
L.RAIDGROUPS_SORTING_GROUPS = "对组进行排序";
L.RAIDGROUPS_SORTING_ERROR = "移动 %s 时出了点问题";
L.RAIDGROUPS_SORTING_FINISHED = "完成申请raid名册";

--[[ ROLLING /gl ro ]]
L.ROLLING_NOTE_LABEL = "笔记";
L.ROLLING_TIMER_LABEL = "计时器";
L.ROLLING_CLOSE_ON_START_LABEL = "开始时关闭";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "即将获奖";
L.ROLLING_SELECT_PLAYER_WARNING = "您需要先选择一名玩家";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "按住shift键即可显示获奖确认信息";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "按住shift绕过奖励确认";
L.ROLLING_REOPEN_TOOLTIP = "打开掠夺大师窗口";
L.ROLLING_REOPEN_ROLL_COUNT = "卷数：%s";
L.ROLLING_ITEM_WON_GIVEN = "（给出的项目：是）";
L.ROLLING_ITEM_WON_NOT_GIVEN = "（给出的项目：无）";
L.ROLLING_ITEM_WON_OS = "(" .. L.OFFSPEC_ABBR .. "）";
L.ROLLING_ITEM_WON_BR_COST = "(" .. L.BOOSTED_ROLLS_ABBR .. ": %s)";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "当前正在进行滚动";
L.ROLLING_IDENTICAL_ROLL_WARNING = "警告: 发现了另一个相同的卷，它可能指向平局|r\n\n";
L.ROLLING_INVALID_START_DATA_WARNING = "为开始卷提供的数据无效！";
L.ROLLING_NO_ROLLOFF_WARNING = "无法停止滚滚，没有正在进行滚滚";
L.ROLLING_ROLL_ACCEPTED = "滚滚接受！";
L.ROLLING_PASS_BUTTON = "经过";
L.ROLLING_UNUSABLE_ITEM = "您不能使用该物品！";
L.ROLLING_AWARD_CONFIRM = "将 %s 奖励给 %s？";
L.ROLLING_WINNER_NOT_UNIQUE = "获奖者的名字不是唯一的，请选择您想要将 %s 奖励给的玩家";
L.ROLLING_ROLL_SR_COUNT = L.SOFTRES_ABBR .. " [%sx]";
L.ROLLING_ROLL_PRIOLIST = "优先[%s]";
L.ROLLING_ROLL_WISHLIST = "愿望[%s]";

--[[ TRADE WINDOW / TRADE ]]
L.TRADE_ANNOUNCE = "公告交易";
L.TRADE_ANNOUNCE_INFO = "向群组公布交易详情，或在/不在群组中时公布交易详情";

L.SETTINGS_RESET_UI = "重置 Gargul UI";

--[[ CHANGELOG ]]
L.CHANGELOG_GETTING_STARTED = "Gargul 让分发战利品变得超级简单，点击下面的按钮即可开始！";
L.CHANGELOG_OPEN_GARGUL = "打开加尔古尔";
L.CHANGELOG_CONTRIBUTE = "在我们的 Discord 上获取支持或分享想法";
L.CHANGELOG_ENABLE_LABEL = "启用变更日志";

--[[ GROUP VERSION CHECK ]]
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "在 CurseForge 上下载";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";

--[[ IDENTITY ]]
L.IDENTITY_INFO = "访问下面的 URL，了解有关个性化 Gargul GDKP 的更多信息";
L.IDENTITY_TOOLTIP = "你的标志在这里吗？点击了解更多信息！";

--[[ IDENTITY ]]
L.MINIMAP_BUTTON_GARGUL = "打开加尔古尔";
L.MINIMAP_BUTTON_MULTIAUCTION = "多重拍卖";
L.MINIMAP_BUTTON_LEDGER = "GDKP分类账";
L.MINIMAP_BUTTON_CUTS = "GDKP 削减";
L.MINIMAP_BUTTON_IMPORT = "导入数据";
L.MINIMAP_BUTTON_EXPORT = "导出数据";
L.MINIMAP_BUTTON_AWARDED = "授予的战利品历史";
L.MINIMAP_BUTTON_SETTING_INFO = "更改|r /gl 小地图中的设置";

--[[ ASSIGN WITH GARGUL ]]
L.ASSIGN_GARGUL_INFO = "如果您想稍后导出战利品，请不要忘记使用 Gargul\n\n\n\n-- 右键单击​​以禁用此窗口 --";

--[[ SHORTCUT KEYS ]]
L.KEYS_INFO = [[
Gargul 物品热键

推出：|c00A79EFF%s|r
奖项： |c00A79EFF%s|r
分解：|c00A79EFF%s|r


-- 右键单击​​禁用该窗口 --
]];

L.LOCALE_NONE_TITLE = "选择 Gargul 的聊天语言";
L.LOCALE_NONE_EXPLANATION = [[
Gargul 用英语发布聊天消息（默认）
您可以在下面的下拉列表中选择不同的语言

您当前的游戏语言是“%s”
]];
L.LOCALE_CHANGE_NOTE = "注意：您可以随时在设置中或通过 |cff%s/gl locale|r 更改区域设置";

L.LOCALE_ENUS = "enUS"; -- English (United States)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ZHCN = "zhCN"; -- Chinese (Simplified, PRC)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ZHTW = "zhTW"; -- Chinese (Traditional, Taiwan)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_RURU = "ruRU"; -- Russian (Russia)
L.LOCALE_PTBR = "ptBR"; -- Portuguese (Brazil)
L.LOCALE_ITIT = "itIT"; -- Italian (Italy)
