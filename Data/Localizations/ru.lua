--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "ruRU") then return; end
local L = Gargul_L or {};

L.ABOUT = "О";
L.ALL_SETTINGS = "Все настройки";
L.ANNOUNCE = "объявить";
L.ANTISNIPE = "Анти-бекас";
L.ANTISNIPE_EXPLANATION = [[

Значение Anti Snipe, равное 10, означает, что любая ставка, которая поступает с
если осталось менее 10 секунд, таймер сбросится обратно на 10 секунд.

Вы можете оставить это поле пустым или установить значение 0, чтобы полностью отключить Anti Snipe.
Значения Anti Snipe меньше 5 не поддерживаются.

]];
L.ARE_YOU_SURE = "Вы уверены?";
L.ASSIGN_GARGUL_INFO = [[
Не забудьте вместо этого использовать Гаргул.
если вы хотите экспортировать добычу позже


-- Щелкните правой кнопкой мыши, чтобы отключить это окно --]];
L.AUCTION = "Аукцион";
L.AUCTIONEER = "аукционист";
L.AUCTIONS = "Аукционы";
L.AUTO = "Авто";
L.AUTO_AWARD = "Авто премия";
L.AUTO_TRADE_OPTIONS = "Автоторговля";
L.AVAILABLE_PLACEHOLDER_VALUES = "Доступные значения:";
L.AWARD = "Премия";
L.AWARDED_TO = "Предназначенный кому-либо";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "БР: %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Цены";
L.AWARDED_TOOLTIP_GIVEN = "Дано: да";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Дано: нет";
L.AWARDED_TOOLTIP_SECOND_BID = "2-я ставка: %s от %s";
L.AWARDED_YOU_WON = "Ты выиграл";
L.AWARD_CONFIRM = "Наградить %s %s?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "Вы уверены, что хотите распылить %s? %s повышенных очков броска будут возвращены!";
L.AWARD_HEADER_IN_GROUP = "В группе";
L.AWARD_HISTORY = "История наград";
L.AWARD_NEW_WINNER_CONFIRMATION = "К кому вместо этого следует обратиться %s?";
L.AWARD_PLAYER_CUSTOM_NAME = "Введите здесь имя игрока";
L.AWARD_PLAYER_SELECT_NAME = "или выберите один ниже";
L.AWARD_RANDOM_CONFIRM = "Вы хотите наградить %s случайному игроку?";
L.AWARD_TOOLTIP_ADD_ITEM = "Перетащите или нажмите клавишу Shift+щелкнуть элемент в поле справа.";
L.AWARD_TOOLTIP_BR_INDICATION = "(БР: %s)";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Разочарованные предметы:";
L.AWARD_TOOLTIP_GIVEN = "(Дано: да)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(Дано: нет)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(ОПЕРАЦИОННЫЕ СИСТЕМЫ)";
L.AWARD_UNDO_BR_REFUND = "%s повышенных очков броска будут возвращены!";
L.AWARD_UNDO_CONFIRM = "Вы уверены, что хотите отменить награду %s %s?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "Проверка сумки не удалась: отчеты не получены";
L.BAGINSPECTOR_FINISHED = "Проверка завершена";
L.BAGINSPECTOR_START = "Начинаю проверку...";
L.BALANCE = "Баланс";
L.BASE = "База";
L.BASE64_DECODE_WARNING = "Невозможно декодировать данные в формате Base64. Обязательно скопируйте/вставьте его как есть, без добавления каких-либо дополнительных символов или пробелов!";
L.BID = "Делать ставку";
L.BIDS = "Ставки";
L.BIND_ON_EQUIP_ABBR = "Банк Англии";
L.BONUS_AUTO_INVITE = "1. Автоматическое приглашение/сортировка групп при регистрации в рейде! Нажмите ниже или используйте |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. Награждайте игроков за то, что они являются постоянными клиентами или делают все возможное! Нажмите ниже или используйте |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "У Гаргула есть несколько хитростей, о которых вы, возможно, не знали. Посмотрите!";
L.BONUS_PLUSONES = "3. Гаргул включает в себя систему отслеживания плюс один! Нажмите ниже или используйте |c00A79EFF/gl po.";
L.BOOSTED_ROLLS = "Усиленные броски";
L.BOOSTED_ROLLS_ABBR = "БР";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
Добавьте сколько очков каждому, кто сейчас находится в рейде?

|c00BE3333Сначала используйте кнопку «Добавить недостающих рейдеров», если хотите, чтобы все получали очки, даже те, у кого нет усиленного результата броска!]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "Стоимость баллов не указана!";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Добавить очки в рейд";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Добавить недостающих рейдеров";
L.BOOSTED_ROLLS_ALIASES = "Псевдонимы";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Применить псевдонимы";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Стоимость ускоренного броска:";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "Вы уверены, что хотите передать данные об усилении всем членам вашей группы/рейда?";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "Нечего транслировать, сначала импортируйте данные Boosted Rolls!";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "Не удалось обработать данные BoostedRolls, полученные от %s.";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Попытка обработать входящие данные BoostedRolls от %s";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "Вы уверены, что хотите удалить все данные ускоренных бросков?";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "Удалить %s?";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "Вы уверены, что хотите очистить существующие данные ускоренного броска и импортировать новые данные, передаваемые %s?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Предоставлены неверные данные. Убедитесь, что содержимое соответствует требуемому формату и не включена строка заголовка.";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
Здесь вы можете импортировать увеличенные данные и псевдонимы из таблицы в формате CSV или TSV или вставить их из таблицы Документов Google.

В таблице должно быть как минимум два столбца: имя игрока и количество очков. Дополнительные столбцы не являются обязательными и могут содержать псевдонимы игрока.
Вот пример строки:

Фубар, 240, Барфу]];
L.BOOSTED_ROLLS_POINTS = "Точки";
L.BOOSTED_ROLLS_RESERVE = "Бронировать";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
Вы уверены, что хотите обновить существующие усиленные броски данными от %s?

Ваше последнее обновление было |c00A79EFF%s, их — |c00A79EFF%s.]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!бонус|!рб|!бр";
L.BROADCAST = "Транслировать";
L.BROADCASTING_NOTIFICATION = "Трансляция...";
L.BROADCAST_DELAYED_BY_COMBAT = "Вы сейчас в бою, трансляция задерживается.";
L.BROADCAST_FINISHED = "Трансляция завершена!";
L.BROADCAST_INC_AWARDED = "Включить награжденные предметы";
L.BROADCAST_INC_DISENCHANTED = "Включить разочарованные предметы";
L.BROADCAST_INC_HIDDEN = "Включить скрытые элементы";
L.BROADCAST_INC_TIME_LEFT = "Включить оставшееся время";
L.BROADCAST_IN_PROGRESS_ERROR = "Трансляция еще продолжается";
L.BROADCAST_NO_DATA = "Нечего транслировать";
L.BROADCAST_NUMBER_OF_ITEMS = "Количество предметов";
L.BROADCAST_PROGRESS = "Трансляция ${percentage}%";
L.BROADCAST_TARGET_PLAYER = "Целевой игрок (только шепотом)";
L.BROADCAST_TARGET_REQUIRED = "Whisper требует целевого игрока";
L.BROADCAST_TRADE_TIME_LEFT = "Оставшееся максимальное время сделки (в минутах)";
L.BY = "к"; -- As in 'bid BY'
L.CANCEL = "Отмена";
L.CHANGELOG_CONTRIBUTE = "Получите поддержку или поделитесь идеями в нашем Discord";
L.CHANGELOG_ENABLE_LABEL = "Включить журнал изменений";
L.CHANGELOG_GETTING_STARTED = "Гаргул делает раздачу добычи очень простой: нажмите кнопку ниже, чтобы начать!";
L.CHANGELOG_OPEN_GARGUL = "Открыть Гаргул";
L.CHANGE_SCALE = "Отрегулировать масштаб";
L.CHANNEL = "Канал";
L.CHANNEL_OFFICER = "Офицер";
L.CHANNEL_RAID_WARNING = "Предупреждение о рейде";
L.CHANNEL_WHISPER = "Шепот";
L.CLASSICPRIO_ABBR = "СЛР";
L.CLEAR = "Прозрачный"; -- As in clearing a window or data
L.CLOSE = "Закрывать";
L.CLOSE_ON_AWARD = "Близко к награде";
L.CLOSE_ON_START = "Закрыть при запуске";
L.COMMUNICATION = "Коммуникация";
L.COMM_PROGRESS = "Отправлено %s из %s байт";
L.COPPER_INDICATOR = "с";
L.CUT = "Резать";
L.CUTS = "Порезы";
L.CUT_MAILBOX_CLOSED = "Невозможно отправить письмо, когда почтовый ящик закрыт";
L.CUT_MAILS_FAILED = "Обнаружены многочисленные почтовые ошибки, что приводит к прерыванию рассылки.";
L.CUT_MAIL_BODY = "Создано Gargul: мастер-инструмент добычи с поддержкой TMB, SoftRes, GDKP и автоматического сбора информации!";
L.CUT_MAIL_EVEN = "Вы не должны %s золота";
L.CUT_MAIL_FAILED = "Не удалось отправить фрагмент %s.";
L.CUT_MAIL_GOLD_MISMATCH = "Письмо ОТПРАВЛЕНО согласно игре, но оставшееся у вас ЗОЛОТО НЕ СООТВЕТСТВУЕТ, что-то пошло не так?";
L.CUT_MAIL_HISTORY = "История почты для |c00967FD2%s";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "У вас недостаточно золота, чтобы заплатить %s";
L.CUT_MAIL_IN_PROGRESS = "Подождите немного, мы все еще обрабатываем предыдущее письмо.";
L.CUT_MAIL_SUBJECT = "Гаргул ГДКП: %sg";
L.CUT_SENT = "Отправлено %sg в %s";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "Удалить";
L.DETAILS = "Подробности";
L.DFT = "ДПФ";
L.DISABLE = "Запрещать";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "Расколдовать";
L.EDIT = "Редактировать";
L.ENABLE = "Давать возможность";
L.EXPORT = "Экспорт";
L.EXPORT_DELETE_ALL_CONFIRM = "Вы уверены, что хотите удалить всю таблицу истории вознаграждений? Это удалит ВСЕ данные о добыче и не может быть отменено!";
L.EXPORT_DELETE_DATE_CONFIRM = "Вы уверены, что хотите удалить все данные для %s? Это не может быть отменено!";
L.EXPORT_READ_ONLY_NOTICE = [[
Это ТОЛЬКО функция экспорта, редактировать какие-либо значения нет смысла: ОНИ НЕ СОХРАНЯТСЯ!

]];
L.FILL = "Наполнять";
L.FINAL_CALL = "Последний вызов";
L.FINISH = "Заканчивать";
L.FORMAT = "Формат";
L.GARGUL = "Гаргул";
L.GDKP = "ГДКП";
L.GDKPS_ARE_NOT_ALLOWED = "Рейды ГДКП не разрешены в этой версии World of Warcraft.";
L.GDKP_ACTIVATED = "ГДКП активен!";
L.GDKP_ADD_DROPS_TO_QUEUE = "Добавить выпавшую добычу в очередь";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "Золото (- для удаления золота)";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "Кто за это платит?";
L.GDKP_ADD_GOLD_INVALID_WARNING = "Золото должно быть ниже/выше 0";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "Оплачено";
L.GDKP_ADD_GOLD_TITLE = "Изменить золото в %s";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "Вы не можете одновременно отдавать и получать золото от одного и того же игрока.";
L.GDKP_ALL_CUTS_MAILED = "Все вырезки были отправлены по почте!";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "Отключить для разочарования";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "Отключить в бою";
L.GDKP_AUCTIONS = "Аукционы";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "Сделано";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333Удален %s
Причина: %s]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg добавлен в банк пользователем %s
Примечания]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s заплатил |c00%s%sg за
%s]];
L.GDKP_AUCTION_DETAILS_WON_BY = "Выиграл";
L.GDKP_AUCTION_PAID_AMOUNT = "Установить сумму оплаты (читать слева)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Гаргул автоматически отслеживает проданное золото. Пока игроки платят
за то, что они купили, вам никогда не понадобится это поле

«Выплаченная сумма» означает количество золота, которое покупатель уже продал вам.
Это не меняет фактическую цену товара!

Внимание: устанавливайте здесь значение только в том случае, если игрок обещает заплатить.
вне рейда или торгует золотом через альт/почту и т.д.!


]];
L.GDKP_AWARD_DIALOG_LABEL = "Цена ГДКП:";
L.GDKP_AWARD_ITEM_CONFIRMATION = "Наградить %s %s за %s?";
L.GDKP_BIDDER_AUTO_BID = "Автоматическая ставка";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "Какова ваша максимальная ставка? (Минимум %s|c00FFF569g)";
L.GDKP_BIDDER_BID_DENIED = "Ставка отклонена!";
L.GDKP_BIDDER_ITEM_PRICING = "Минимальная ставка: %sg. Шаг: %sg.";
L.GDKP_BIDDER_MY_MAX_BID = "(макс. %sg)";
L.GDKP_BIDDER_NEW_BID_LABEL = "Новая ставка";
L.GDKP_BIDDER_STOP_AUTO_BID = "Остановить автоматическую ставку";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "Максимальная ставка: %s от %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "Максимальная ставка: %s от вас";
L.GDKP_CREATE = "Создайте новый сеанс GDKP.";
L.GDKP_CREATE_MANAGEMENT_CUT = "Управленческое сокращение %";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Management Cut должно быть пустым или иметь значение от 0 до 99 (без знака %!)";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "Выберите тип сеанса!";
L.GDKP_CREATE_SESSION_SWITCH = "Переключиться на этот сеанс";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFМульти-аукцион позволяет вам делать ставки на несколько предметов одновременно, ускоряя процесс!
Следуйте инструкциям после создания этого сеанса, чтобы начать работу.

С помощью |c00A79EFFSingle-Auction вы выбираете продажу отдельных предметов с аукциона или использование очереди.

Выбор |c00A79EFFMulti-Auction предотвращает добавление выброшенных предметов в очередь.
Вы можете смешивать |c00A79EFFMulti-Auction с |c00A79EFFSingle-Auction и очередью, но мы настоятельно не рекомендуем этого делать.

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "Тип аукциона (|c00A79EFFi для получения дополнительной информации)";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "Мультиаукцион";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "Одиночный аукцион";
L.GDKP_CREATE_SUCCESSFUL = "Сессия создана. Мы советуем вам /reload, чтобы он сохранялся правильно на случай сбоя игры!";
L.GDKP_CUTS_ADD_RAIDER = "Добавить рейдера";
L.GDKP_CUTS_ADJUST_G = "отрегулировать [г]";
L.GDKP_CUTS_ADJUST_P = "регулировать [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "Анонсируйте сокращение базы в групповом чате";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "Вы уверены, что хотите сбросить всех игроков и расчеты? Внимание: все игроки, вышедшие из рейда, будут удалены из списка!";
L.GDKP_CUTS_DELETE_RAIDER = "Удалить Рейдера";
L.GDKP_CUTS_EDIT_RAIDER = "Править Рейдер";
L.GDKP_CUTS_LOCK_TOOLTIP = "Блокируй и плати";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "Управляйте сделками с золотом";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

С помощью мутаторов вы можете давать игрокам больше или меньше золота.
Пример: прибавка танкам 2% — вот для чего нужны мутаторы!

Примечание. Редактирование или удаление мутаторов изменяет их только для этого сеанса.

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "Не в рейде";
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
L.GDKP_CUTS_SUMMARY = "%s рейдеров | %s С разрезом | Общая выплата: %sg";
L.GDKP_CUT_IMPORT_EMPTY = "Импортировать нечего. Проверьте CSV-файл.";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Не хватает золота игроку %s";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "Отсутствует заголовок. Обратите внимание: он чувствителен к регистру!";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Отсутствует имя игрока";
L.GDKP_DELETE_BID_INFO = "Удалить ставку. Аукцион должен быть остановлен первым!";
L.GDKP_DISTRIBUTE_ADDRAIDER = "Добавить рейдера в эту сессию";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "Пользовательский (создайте свой собственный формат)";
L.GDKP_EXPORT_AUCTIONS_JSON = "Подробно (JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "Поделиться (могут быть импортированы другими игроками)";
L.GDKP_EXPORT_CUSTOM_FORMAT = "Ваш индивидуальный формат";
L.GDKP_EXPORT_CUSTOM_HEADER = "Ваш индивидуальный заголовок";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Пользовательский (создайте свой собственный формат)";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@ИГРОК,@CUT";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "Игрок,Вырезать";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "дата/время блокировки сеанса";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "общее количество золота, полученного игроком";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "золото отправлено игроку";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "общее количество золота, полученного от игрока";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "дата/время, когда был выдан первый предмет";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "золото продано игроку";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "Предмет, Игрок, Золото, Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "Дата/время получения первого предмета";
L.GDKP_EXPORT_FORMAT_TITLE = "Название сессии ГДКП";
L.GDKP_EXPORT_POT_CHANGED = "Горшок изменен";
L.GDKP_GOLD_TRADES = "Золотые сделки";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "Вы уверены? Вы не сможете видеть предстоящие товары или делать ставки на них!";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!! ВНИМАНИЕ !!|р

Вы находитесь в подключенном мире и импортируете имена игроков без
суффикс области, например «%s». Это может привести к отправке
режет и режет почту не тому игроку.

Находясь в подключенном мире, всегда старайтесь указывать имена игроков!

Продолжить импорт?
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "Это отменит любые изменения, внесенные вами в вырезанное окно, вы уверены?";
L.GDKP_IMPORT_CUTS_INFO = [[
Вы можете импортировать вырезы игроков из собственных расчетов, например, из таблицы Google. софтрес ГДКП и т.д.

Формат следующий (|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333Плеер,золотой|c00967FD2
Игрок1,4000
Игрок2,4125
Игрок3,3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
Импортируйте минимальные цены и приращения GDKP.

Формат следующий: Требуется ItemID + минимум или приращение. (|c00BE3333ТРЕБУЕТ ЗАГОЛОВОК!!):

|c00BE3333ItemID, минимум, приращение | c00967FD2
186084000500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "Удалить существующие настройки цен? Нажмите «Да», чтобы удалить все данные о ценах, или «Нет», чтобы просто заменить существующие данными, которые вы предоставили здесь.";
L.GDKP_IMPORT_SESSION = "Импортировать сеанс GDKP";
L.GDKP_IMPORT_SESSION_ABOUT = "Здесь вы можете импортировать (и продолжить) сеанс GDKP. Чтобы получить сеанс GDKP от кого-либо, ему необходимо экспортировать его в |c00FFF569/gdkp, где они выбирают формат «Поделиться (может быть импортирован другими игроками)».";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "Вы собираетесь импортировать сеанс GDKP, созданный %s, вы уверены?";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "Кажется, этот сеанс GDKP, созданный %s, уже существует. Вы хотите его переопределить?";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "Для расширения GDKP предоставлены неверные данные!";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "Для переноса графика GDKP предоставлены неверные данные!";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "Для сокращения ГДКП предоставлены неверные данные!";
L.GDKP_INVALID_DATA_FOR_START = "Для начала аукциона GDKP предоставлены неверные данные!";
L.GDKP_INVALID_PAID_AMOUNT = "Указан неверный номер для «платного»";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "В разделе Аукцион:перепланирование указано неверное время.";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP Данные (продано %sx)
Последняя продажа за: %s
Средняя цена: %s
Минимальная ставка: %s
Приращение: %s

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "Баланс: |c0092FF000 ? Ты квадратный! | |c00BE333330 ? вы должны %s 30 г | |c00F7922E50 ? %s должен вам 50 г";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "Золото отправлено вам по почте от %s";
L.GDKP_LEDGER_LEGEND_PAID_TO = "Золото выплачено %s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "Золото получено от %s";
L.GDKP_LEDGER_MUTATION = "Золото %s от"; -- %s = removed or added
L.GDKP_LEDGER_POT = "Общий банк: %sg | Сокращение руководства: %sg (%s%%) | Для распространения: %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s | Автор: %s%s | На |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "Сеанс GDKP недоступен или заблокирован.";
L.GDKP_MAIL_ALL = "Почта всем";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "Ставок на предмет Legendary+ не обнаружено, продолжите вручную!";
L.GDKP_MISSING_CONTENT_FOR_START = "Отсутствует контент на аукционе:начать";
L.GDKP_MULTIAUCTION_ABOUT = [[

С помощью нескольких аукционов (или пакетных аукционов) вы можете продавать с аукциона столько предметов, сколько захотите одновременно!
Это значительно ускоряет ваши рейдовые ночи и обеспечивает беспрепятственный опыт для ваших рейдеров.

Все торгуемые предметы, которые все еще находятся в вашем инвентаре, могут быть автоматически проданы с аукциона с помощью функции «Заполнить из инвентаря».
Дать ему шанс!

|c00808080Есть только один минус: чтобы люди могли принять участие в пакетном аукционе, рейдерам понадобится Гаргул!

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "Вам необходимо иметь активную (разблокированную) сессию GDKP!";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "В этом открытом окне добавьте элементы %s в список или нажмите «Заполнить из инвентаря» ниже."; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Анти-бекас за секунды";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "Значение анти-снайпа должно быть 0 (пусто) или >=5.";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Вернитесь к выбору элементов";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Удалить все элементы из списка";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "Заполнить из инвентаря";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Добавьте в список продаваемые предметы из своего инвентаря.";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Здесь вы определяете, какие предметы включить в вашу сессию нескольких аукционов.

Используйте кнопку |c00A79EFFFЗаполнить из инвентаря ниже, чтобы добавить в список предметы, которые еще можно продать.
Всякий раз, когда вы очищаете и снова открываете это окно, для автоматического добавления элементов будут использоваться ваши последние настройки заполнения.

|c00A79EFF%s элементы, чтобы добавить их в список вручную
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Следующий шаг: проверьте версию дополнения Raider на совместимость";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "Не все используют Гаргул. Вы уверены, что хотите начать аукцион?";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Выберите хотя бы один предмет для своего аукциона";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Ваш Гаргул устарел. Мы рекомендуем обновить его перед началом сеанса, чтобы предотвратить проблемы!";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "Не все в курсе. Если у вас возникли проблемы, попросите своих рейдеров обновиться!";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "Существует активный мультиаукцион, предметы, которые вы сюда добавляете, будут добавлены в существующую сессию. Будьте осторожны с дублирующими товарами!";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Поиск по имени или iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Поддерживает имена предметов и iLVL, например. «252», «<252» и т. д.";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Активный сеанс GDKP: |c00967FD2%s | Автор: %s%s | На |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Время аукциона в секундах";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "Время аукциона в секундах должно быть >= 10.";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "Вы ушли во время сессии торгов GDKP. Чтобы возобновить его, вам необходимо указать новое время ставки (в секундах) для любых непроданных товаров.";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "В этом окне открыто %s элементов, чтобы добавить их в список.";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "Нажмите на значок шестеренки, чтобы управлять аукционом.";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "Вы уже являетесь лидером торгов на %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
Ставка |c00%s%sg
%s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%sЗАКРЫТО
Нет ставок]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
Минимум: |c00%s%sg
Приращение: |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "Предметов: %s - Всего продано: %sg - Залог мной: %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
Предметы со ставками: %s/%s
Всего продано: %s
Куплен мной: %s
Общая ставка (не включая проданные): %s
Моя ставка (не включает проданные): %s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%sПРОДАНО
%s для |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
Ставка |c00%s%sg
Автор: |c0092FF00ВЫ!]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "Не удалось остановить автоматическое назначение ставок для %s. Повторите попытку или /reload!";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "Автоматическая ставка до максимум %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "Автоматическая ставка до суммы, которую вы указали слева.";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "Остановите автоматическую ставку (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "Ставка на %s не может быть подтверждена";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "Недействительная ставка или ставка слишком низкая! Минимум — %sg.";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "Вам нужно подождать две секунды между ставками на один и тот же товар.";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "Очистить ставки";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "Удалить все ставки с аукциона";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "Закрыть все";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "Закрыть ВСЕ аукционы?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
Закрыть ВСЕ аукционы

Аукционы с активными ставками на них будут проданы и не смогут принимать новые ставки!
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "Закрыть аукцион";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "Закройте аукцион. Игроки больше не могут делать ставки, но самая высокая ставка остается активной.";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "Удалите предмет с аукциона, включая информацию о его ставке. ЭТО НЕ МОЖЕТ ОТМЕНИТЬ!";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "Расчаровать все готовые, но непроданные предметы?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
Расчаровать непроданные предметы

Все непроданные предметы будут отмечены как разочарованные, и они не будут отображаться в новой сессии нескольких аукционов.
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "Добавить в избранное этот товар";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "Дайте таймер финального звонка на сколько секунд?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "Минимальное количество секунд — 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "Начните последний вызов на этом аукционе, установив таймер ставки (обычно более короткий).";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "Закрыть ВСЕ аукционы и завершить эту многоаукционную сессию?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
Завершить сеанс мультиаукциона

Это закроет все аукционы и объявит общий размер банка в чате.
Аукционы с активными ставками на них будут проданы и не смогут принимать новые ставки!
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "Скрыть неактивный";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "Скрыть непригодное для использования";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "Показать/Скрыть завершенные аукционы";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "Управление аукционом";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "Предложите минимальную необходимую сумму";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "Окно ставок закрыто. Используйте ставку |c00A79EFF/gl, чтобы открыть его снова!";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "Анонсируйте продажи в чате";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "Воспроизводить звук, когда ставка перебита";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "Больше вариантов звука...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "Показать все";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "Показать избранное";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "Показать неактивное";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "Показать непригодные для использования";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "Этот товар был продан. Используйте реестр (|c00%s/gdkp) для внесения изменений!";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "Прекратить";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "Удалить все ставки bidsl и закрыть все аукционы?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
Завершить сеанс мультиаукциона

Это приведет к удалению всех ставок на еще не проданные товары и закрытию всех аукционов!
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "Наведите курсор на любую из кнопок ниже, чтобы получить дополнительную информацию.";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "Показать/скрыть предметы, которые вы не можете использовать";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "Для начала аукциона GDKP предоставлены неверные данные!";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s купил %s за %sg";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "Мастер добычи (%s) устарел, это может привести к провалу ставок!";
L.GDKP_MULTIAUCTION_OUTBID = "Ваша ставка была перебита!";
L.GDKP_MUTATORS = "Мутаторы";
L.GDKP_MUTATOR_ADD = "Добавить мутатор";
L.GDKP_MUTATOR_APPLY_LABEL = "Автоматически применять к";
L.GDKP_MUTATOR_CREATE_NEW = "Создайте новый мутатор GDKP.";
L.GDKP_MUTATOR_DELETE_BYPASS = "Удалить. Удерживайте Shift, чтобы обойти подтверждение";
L.GDKP_MUTATOR_EDIT = "Редактировать мутатор";
L.GDKP_MUTATOR_FLAT_LABEL = "Фиксированная ставка золота [пример: 250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "Фиксированная ставка должна быть числом";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
Пример:
|c00967FD2SELF,RL,ЦЕЛИТЕЛЬ]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "Вы можете автоматически применить этот мутатор к рейдерам, используя ключевые слова:";
L.GDKP_MUTATOR_NAME_LABEL = "Название [пример: Танки]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Имена мутаторов не могут содержать точки (.)";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Процент [пример: 10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "Процент должен быть числом";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Сохраните для будущих сеансов";
L.GDKP_MUTATOR_UNKNOWN = "Неизвестный мутатор: %s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "Пользователю «%s» не разрешено начинать аукционы.";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "Пользователю «%s» не разрешено останавливать аукционы.";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "Пользователю «%s» не разрешено останавливать аукцион: аукцион недействителен.";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "Недостаточно золота для распределения, ожидайте странных расчетов!";
L.GDKP_NO_BIDS = "Никаких ставок!";
L.GDKP_OUTBID = "Ваша ставка была перебита!";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(активный)";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
Чтобы отрегулировать золото, вам понадобится свинец или мастер-лут.
Вы не можете регулировать золото в заблокированных/удалённых сессиях.]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "Добавить/удалить золото";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s заплатил |c00%s%s за
%s]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333Удален %s
Причина: %s]];
L.GDKP_OVERVIEW_DELETED_SESSION = "(удалено)";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
Для удаления записей вам понадобится ведущий или мастер-лут.
Вы не можете удалять записи в заблокированных/удалённых сеансах.]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "Укажите причину удаления этой записи";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "Удалить. Удерживайте Shift, чтобы пропустить заметку";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "Сессии с прикрепленными к ним аукционами будут удалены через 48 часов.";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
Для редактирования записей вам понадобится ведущий или мастер-лут.
Вы не можете редактировать удаленные записи или записи в заблокированных/удаленных сеансах.]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "Экспортируйте сеанс, чтобы другие могли просмотреть детали сеанса или даже заменить вас в качестве мастера добычи.";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "Импортируйте сессию из другого игрока или учетной записи.";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
Показать полный обзор реестра,
идеально подходит для создания скриншотов!]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "Блокировка сеанса означает, что вы не можете продавать предметы на аукционе или иным образом изменять что-либо, пока не разблокируете его, вы уверены?";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "Заблокировать или разблокировать сеанс";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "Заблокируйте сессию для выплаты";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "Мультиаукцион: выставляйте на аукцион несколько предметов одновременно!";
L.GDKP_OVERVIEW_MUTATION_ADDED = "Добавлено в";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s Банк %s от %s
Примечания]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "удалено из";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
Горшок: %s
Сокращение менеджмента (%s%%): %sg
Вырезание на игрока (1/%s): %sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
Для восстановления записей вам понадобится ведущий или мастер-лут.
Вы не можете восстановить записи заблокированных/удалённых сессий.]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "Автор: %s%s | |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "Разблокировка и изменение банка или ставок может оказаться очень запутанной задачей, особенно если вы уже произвели выплаты. Вы уверены?";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "Разблокировать сеанс";
L.GDKP_PAYOUT_INACTIVE = "Активная сессия GDKP не обнаружена или сессия не заблокирована для выплаты!";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "Приращение или минимум не может быть меньше 0,0001!";
L.GDKP_PRICE_IMPORT_INVALID_INC = "Для идентификатора элемента «%s» указан неверный «прирост».";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "Для идентификатора элемента '%s' указан неверный 'Минимум'.";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "Для идентификатора элемента: %s требуется минимум или приращение.";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "Отсутствует заголовок. Обратите внимание: он чувствителен к регистру!";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Успешно импортированы данные для %s элементов.";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "Неизвестный идентификатор предмета: %s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s предметов в сумках, окнах добычи или даже по ссылкам в чате, чтобы добавить их в эту очередь аукциона.
Предметы в очереди будут автоматически проданы с аукциона после завершения текущего аукциона. Нажмите кнопку «%s», чтобы предотвратить это.

Хотите, чтобы Гаргул автоматически присуждал или расколдовывал аукционы за вас? Откройте колесо настроек слева!

|c00FFF569Знаете ли вы?
Вы можете перемещать предметы с помощью перетаскивания
Предметы будут запоминаться, даже если вы |c00A79EFF/перезагрузите
Предметы в очереди автоматически отображаются рейдерам, у которых есть Гаргул, чтобы они могли сделать предварительную ставку.
Гаргул также может заняться автоматическим грабежом. Проверьте это с помощью |c00A79EFF/gl pm
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Скрыть неиспользуемые элементы";
L.GDKP_SESSION = "Сессия ГДКП";
L.GDKP_SESSION_EDIT_TITLE = "Редактирование %s";
L.GDKP_SHOW_UPCOMING = "Показать предстоящие товары";
L.GDKP_STOP_AUCTION_FIRST = "Сначала остановите аукцион!";
L.GDKP_THEY_OWE = "%s должен вам %s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP Сеанс
Потрачено игроком: %s
Дано: %s
Получено: %s
Удаление игрока: %s

%s
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "Исключить из GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "Проданное золото не будет добавлено к отданной или полученной сумме.";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Золото |c00967FD2 передано %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "Невозможно добавить %s в окно торговли. Попробуйте добавить его вручную!";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "У вас недостаточно денег для оплаты %s";
L.GDKP_TRADE_GOLD_TO_GIVE = "Чтобы дать: %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "Чтобы получить: %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Золото |c00967FD2 получено от %s";
L.GDKP_TRY_MULTIAUCTION = "Посетите мультиаукционы!";
L.GDKP_TUTORIAL_INFO = "Следуйте инструкциям ниже, чтобы быстро начать работу с Gargul GDKP!";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "Активируйте этот сеанс, нажав кнопку |c00FFF569Включить ниже!";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s предмет для аукциона или постановки в очередь одного предмета"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
Полезные команды:
- |c00FFF569/gdkp, чтобы открыть это окно
- |c00FFF569/gl ma, чтобы открыть окно нескольких аукционов
- |c00FFF569/gl au, чтобы открыть аукциониста/очередь с одним предметом
- |c00FFF569/gl pm для настройки автоматического лута

]];
L.GDKP_TUTORIAL_STEP_DONE = "Если все прошло хорошо, вы увидите здесь свои только что выставленные на аукцион предметы!";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "Хотите выставить на аукцион несколько предметов одновременно? Запустите |c00FFF569/gl ma (или |c00FFF569/gl мультиаукцион) или щелкните значок мультиаукциона в правом верхнем углу этого окна!";
L.GDKP_TUTORIAL_STEP_NEW = "Нажмите кнопку |c00FFF569Новый ниже, чтобы создать первый сеанс GDKP. Он будет отображаться слева после создания.";
L.GDKP_TUTORIAL_STEP_READY = "Вы готовы продавать предметы! |c00BE3333Внимательно прочитайте все приведенные ниже шаги и проверьте их все самостоятельно (не обязательно участвовать в рейде), прежде чем начинать свой первый рейд GDKP!";
L.GDKP_TUTORIAL_STEP_SELL = "Хотите продать товар без торгов? |c00FFF569%s на предмет, выберите победителя и установите цену!";
L.GDKP_TUTORIAL_TITLE = "Начиная";
L.GDKP_UNKNOWN_ITEM = "Неизвестный идентификатор предмета на аукционе: создать: %s";
L.GDKP_UNKNOWN_SESSION = "Неизвестный идентификатор сеанса на аукционе: создать: %s";
L.GDKP_YOU_OWE = "Вы должны %s %s";
L.GIVEN = "Данный";
L.GOLD_INDICATOR = "г";
L.GROUP = "Группа";
L.GROUP_MANAGER = "Менеджер группы";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "Скачать на CurseForge";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "Остановиться";
L.HEADER = "Заголовок";
L.HELLO = "|c00%sГаргул v%s от Zhorax@Firemaw. Чтобы начать, введите |c00%s/gl или |c00%s/gargul!";
L.HIDE = "Скрывать";
L.HOURS_MINUTES_FORMAT = "%Ч:%М";
L.IDENTITY_INFO = "Посетите URL-адрес ниже, чтобы узнать больше о персонализации Gargul GDKP.";
L.IDENTITY_TOOLTIP = "Ваш логотип здесь? Нажмите, чтобы получить дополнительную информацию!";
L.IMPORT = "Импортировать";
L.IMPORTED_AND_UPDATED_ON = "Импортировано |c00A79EFF%s по адресу |c00A79EFF%s, обновлено |c00A79EFF%s по адресу |c00A79EFF%s";
L.IMPORT_EXPLANATION = "Какие данные вы хотите импортировать?";
L.IMPORT_SUCCESSFUL = "Импорт данных ускоренного вращения успешен.";
L.INC = "Инк";
L.INCLUDE_AWARDED = "Включить ранее награжденные предметы";
L.INCLUDE_BOES = "Включить BOE";
L.INCLUDE_MATERIALS = "Включить материалы (например, кристаллы Бездны)";
L.INCREMENT = "Приращение";
L.INFO = "Информация";
L.INVALID_DATA_WARNING = "Предоставлены неверные данные";
L.ITEM = "Элемент";
L.JSON_DECODE_WARNING = "Невозможно декодировать данные JSON. Обязательно скопируйте/вставьте его как есть, без добавления каких-либо дополнительных символов или пробелов!";
L.KEYS_INFO = [[
Горячие клавиши для предметов Гаргула

Развертывание: |c00A79EFF%s
Награда: |c00A79EFF%s
Расчаровать: |c00A79EFF%s


-- Щелкните правой кнопкой мыши, чтобы отключить это окно --
]];
L.LEDGER = "Леджер";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "Вам нужно быть главным мародёром или играть ассистентскую/ведущую роль!";
L.LOCALE_CHANGE_NOTE = "Примечание. Вы можете изменить локаль в любой момент в настройках или через |c00%s/gl locale.";
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ENUS = "enUS"; -- English (United States)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_ITIT = "itIT"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Гаргул публикует сообщения в чате на английском языке (по умолчанию).
Вы можете выбрать другой язык в раскрывающемся списке ниже.

Ваш текущий язык чата — «%s», включение другого языка приведет к перезагрузке!
]];
L.LOCALE_NONE_TITLE = "Выберите язык чата для Гаргула";
L.LOCALE_PTBR = "птБР"; -- Portuguese (Brazil)
L.LOCALE_RURU = "ruRU"; -- Russian (Russia)
L.LOCALE_ZHCN = "жЦН"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "жТВ"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "У вас установлено одно или несколько дополнений, которые потенциально могут привести к неправильной работе Гаргула: %s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "Очистить SoftRes";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "Очистить ТМБ";
L.LOOTMASTER_DEFAULT_NOTE = "/roll для MS или /roll 99 для ОС";
L.LOOTMASTER_IMPORT_SR_BUTTON = "Импортировать SoftRes";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "Импортировать ТМБ";
L.LOOTMASTER_NOTICE_LABEL = "Вам дали роль Мастера мародёра.";
L.LOOTMASTER_OPEN_LABEL = "Открыть это окно автоматически";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Приоритеты добычи успешно очищены";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Предоставьте CSV-файл prio в следующем формате (1 строка на элемент): идентификатор или имя > prio1, Equalprio > prio2 > и т. д.";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Приоритеты добычи успешно импортированы.";
L.LOOTPRIORITY_INVALID_DATA = "Предоставлены неверные данные";
L.LOOTPRIORITY_INVALID_LINE = "В строке предоставлены неверные данные: «%s»: отсутствует идентификатор элемента или приоритет.";
L.LOOTPRIORITY_PROCESS_INCOMING = "Попытка обработать входящие приоритеты добычи от %s.";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Лут Прио";
L.MAIL = "Почта";
L.MAILED = "Отправлено по почте";
L.MAIL_CUTS_EXPLANATION = "Отказ почты игрокам";
L.MAINSPEC_ABBR = "РС";
L.MAXIMIZE = "Максимизировать";
L.MIN = "Мин";
L.MINIMAP_BUTTON_AWARDED = "История наград";
L.MINIMAP_BUTTON_CUTS = "ГДКП сокращает";
L.MINIMAP_BUTTON_EXPORT = "Экспорт данных";
L.MINIMAP_BUTTON_GARGUL = "Открыть Гаргул";
L.MINIMAP_BUTTON_IMPORT = "Импортировать данные";
L.MINIMAP_BUTTON_LEDGER = "Книга ГДКП";
L.MINIMAP_BUTTON_MULTIAUCTION = "Мультиаукцион";
L.MINIMAP_BUTTON_SETTING_INFO = "Измените настройки в мини-карте /gl.";
L.MINIMIZE = "Минимизировать";
L.MINIMIZE_ON_AWARD = "Минимизировать награду";
L.MINIMIZE_ON_START = "Свернуть при запуске";
L.MINIMUM = "Минимум";
L.MINIMUM_QUALITY = "Минимальное качество";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "Двигаться";
L.MULTI_AUCTION = "Мультиаукцион";
L.NAME = "Имя";
L.NEW = "Новый";
L.NEXT = "Следующий";
L.NO = "Нет";
L.NONE = "Никто";
L.NOTE = "Примечание";
L.NOTHING = "Ничего";
L.NO_BIDS_ACTION = "Когда никто не делает ставок:";
L.NO_OFFICER_PRIVILEGES = "У вас нет офицерских привилегий";
L.OFFSPEC_ABBR = "Операционные системы";
L.OK = "Хорошо";
L.OPEN = "Открыть";
L.OPEN_AUCTIONEER = "Открытый аукционист";
L.OPEN_MULTI_AUCTION = "Открытый мультиаукцион";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "GREED";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORE";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "NEED";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASS";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "RANDOM";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SELF";
L.PACKMULE_CONFIRM_DISENCHANTER = "Назначить %s своим распылителем?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "Отправить %s %s? Введите /gl cd, чтобы удалить этот дисчантер!";
L.PACKMULE_NO_DISENCHANTER_WARNING = "Нет набора распылителей, используйте /gl sd [mydisenchanter], чтобы установить его.";
L.PACKMULE_WHO_IS_DISENCHANTER = "Кто твой разочаровывающий?";
L.PAID = "Оплаченный";
L.PASS = "Проходить";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "Игрок";
L.PLAYER_ITEM_WON_COUNT = "Предметы, выигранные %s:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "Плюс Один";
L.PLUSONES_AWARD_DIALOG_LABEL = "Добавить +1";
L.PLUSONES_BROADCAST_CONFIRM = "Вы уверены, что хотите передать данные плюс один всем в вашей группе/рейде?";
L.PLUSONES_BROADCAST_PROCESS_START = "Попытка обработать входящие данные PlusOnes от %s";
L.PLUSONES_CLEAR_CONFIRM = "%s хочет удалить все ваши данные PlusOne. Удалить все данные?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "Вы уверены, что хотите очистить существующие данные PlusOne и импортировать новые данные, передаваемые %s?";
L.PLUSONES_IMPORT_CONFIRM = "Вы уверены, что хотите импортировать новые данные, переданные %s?";
L.PLUSONES_IMPORT_ERROR = "Предоставлены неверные данные. Убедитесь, что содержимое соответствует требуемому формату и не включена строка заголовка.";
L.PLUSONES_IMPORT_INFO = [[
Здесь вы можете импортировать плюс один данные из таблицы в формате CSV или TSV или вставить из листа Документов Google.

В таблице должно быть как минимум два столбца: имя игрока и количество очков. Дополнительные столбцы игнорируются.

Вот пример строки:

Фубар, 240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Автоматически принимать входящие трансляции от %s";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Блокировать все входящие общие данные +1";
L.PLUSONES_UPDATE_CONFIRM = [[
Вы уверены, что хотите обновить существующие данные PlusOne данными из %s?

Ваше последнее обновление было |c00A79EFF%s, их — |c00A79EFF%s.]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "Горшок";
L.PRICE = "Цена";
L.PRIOLIST_ABBR = "ПЛ";
L.QUALITY_COMMON = "Общий";
L.QUALITY_EPIC = "Эпический";
L.QUALITY_HEIRLOOM = "Семейная реликвия";
L.QUALITY_LEGENDARY = "Легендарный";
L.QUALITY_POOR = "Бедный";
L.QUALITY_RARE = "Редкий";
L.QUALITY_UNCOMMON = "Необычный";
L.QUEUE = "Очередь";
L.RAIDERS = "Рейдеры";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Кого не хватает";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Показать недостающие имена игроков";
L.RAIDGROUPS_DISBAND_BUTTON = "Расформировать рейд";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Расформировать свой рейд";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s указан в списке дважды!";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "экспорт |c00FFF569Raid-Helper (используйте вариант «Группы с вертикальной сортировкой») или CSV-файл |c00FFF569Gargul с составом группы:";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
В большом поле редактирования ниже вы можете указать список и: пригласить всех, проверить, кто отсутствует, применить группы и назначить танки.

Вы можете предоставить ссылку на состав рейда |c00FFF569Wowhead:]];
L.RAIDGROUPS_GARGUL_BUTTON = "Вики Сообщества Гаргул";
L.RAIDGROUPS_GARGUL_INFO = "Посетите вики группы Гаргул для получения дополнительной информации о формате рейдовой группы.";
L.RAIDGROUPS_IMPOSTER_WARNING = "Следующие игроки не входят в состав: %s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Предоставлены неверные данные группы, проверьте свой формат!";
L.RAIDGROUPS_INVITE_BUTTON = "Приглашать";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Отправка приглашений игрокам в составе";
L.RAIDGROUPS_IN_COMBAT_WARNING = "Невозможно сортировать группы, пока %s находится в бою!"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "Вам нужно быть в рейде!";
L.RAIDGROUPS_NO_TANKS_WARNING = "Танки не определены";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "Не можете найти место для %s. Вы пытаетесь объединить более 5 человек в 1 группу?";
L.RAIDGROUPS_PURGE_BUTTON = "Выкидывайте нежелательных игроков";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Выкидывать игроков, которых нет в списке";
L.RAIDGROUPS_SORTING_ERROR = "Что-то пошло не так при перемещении %s";
L.RAIDGROUPS_SORTING_FINISHED = "Завершено применение рейдового списка.";
L.RAIDGROUPS_SORTING_GROUPS = "Сортировочные группы";
L.RAIDGROUPS_SORT_BUTTON = "Применить группы";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Сортировка групп по списку";
L.RAIDGROUPS_SORT_IN_PROGRESS = "Сортировка еще продолжается, подождите немного!";
L.RAIDGROUPS_TANKS_ASSIGNED = "Все танки распределены";
L.RAIDGROUPS_TANK_BUTTON = "Назначьте танки";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Инструмент Wowhead Comp";
L.RAIDGROUPS_WOWHEAD_INFO = "Вы можете посетить инструмент wowhead comp, используя URL-адрес ниже. После создания вашей композиции вы можете вставить ее сюда или в большое поле редактирования окна группы Гаргул.";
L.REMOVE_BID = "Удалить ставку";
L.RESET_SETTINGS = "Сбросить настройки";
L.RESET_SETTINGS_CONFIRMATION = "Вы уверены, что хотите сбросить все настройки Гаргула? Этого нельзя отменить!";
L.RESET_UI = "Сбросить пользовательский интерфейс Гаргула";
L.RESET_UI_CONFIRMATION = "Вы уверены, что хотите сбросить все размеры, положения и масштаб окон Гаргула? Этого нельзя отменить!";
L.RESTORE = "Восстановить";
L.RESUME = "Резюме";
L.RIGHT_SYMBOL = ">";
L.ROLL = "Рулон";
L.ROLLING_AWARD_CONFIRM = "Наградить %s %s?";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Близко к награде";
L.ROLLING_CLOSE_ON_START_LABEL = "Закрыть при запуске";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Удерживайте клавишу Shift, чтобы обойти подтверждение награды.";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Удерживайте клавишу Shift, чтобы показать подтверждение награды.";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
Внимание: найден еще один идентичный бросок, который может указывать на ничью.

]];
L.ROLLING_INVALID_START_DATA_WARNING = "Для начала старта предоставлены неверные данные!";
L.ROLLING_ITEM_WON_BR_COST = "(БР: %s)";
L.ROLLING_ITEM_WON_GIVEN = "(данный пункт: да)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(данный пункт: нет)";
L.ROLLING_ITEM_WON_OS = "(ОПЕРАЦИОННЫЕ СИСТЕМЫ)";
L.ROLLING_NOTE_LABEL = "ПРИМЕЧАНИЕ";
L.ROLLING_NO_ROLLOFF_WARNING = "Не могу остановить скатывание, скатывание не происходит.";
L.ROLLING_PASS_BUTTON = "Проходить";
L.ROLLING_REOPEN_ROLL_COUNT = "бросков: %s";
L.ROLLING_REOPEN_TOOLTIP = "Открыть главное окно мародёра";
L.ROLLING_ROLL_ACCEPTED = "Ролл принят!";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "В настоящее время идет проверка";
L.ROLLING_ROLL_PRIOLIST = "Прио [%s]";
L.ROLLING_ROLL_SR_COUNT = "СР [%sx]";
L.ROLLING_ROLL_WISHLIST = "Желаю [%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "Сначала вам нужно выбрать игрока";
L.ROLLING_TIMER_LABEL = "ТАЙМЕР (с)";
L.ROLLING_UNUSABLE_ITEM = "Вы не можете использовать этот предмет!";
L.ROLLING_WINNER_NOT_UNIQUE = "Имя победителя не уникально. Выберите игрока, которому вы хотите наградить %s.";
L.SECONDS_ABBR = "с";
L.SELECT_ALL = "Выбрать/отключить все";
L.SESSION = "Сессия";
L.SETTINGS = "Настройки";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Объявить о поступивших ставках";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Объявить банк после вручения предмета";
L.SETTINGS_ANNOUNCE_START = "Объявить о начале аукциона";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Объявить обратный отсчет в предупреждении о рейде";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Объявляйте о входящих ставках в предупреждении о рейде";
L.SETTINGS_RESET_UI = "Сбросить пользовательский интерфейс Гаргула";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Сообщите участнику торгов, если ставка слишком низкая";
L.SILVER_INDICATOR = "с";
L.SKIP = "Пропускать";
L.SOFTRES = "Мягкие резервы";
L.SOFTRES_ABBR = "СР";
L.SOFTRES_BROADCAST_CONFIRM = "Вы уверены, что хотите передать данные программного обеспечения всем членам вашей группы/рейда?";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "Не удалось обработать данные SoftRes, полученные от %s.";
L.SOFTRES_CLEAR_CONFIRM = "Вы уверены, что хотите удалить все существующие данные мягкого резервирования?";
L.SOFTRES_EVERYONE_RESERVED = "Все пополнили свои мягкие резервы";
L.SOFTRES_FEATURE_MISSING = [[
Информация о жестких резервах недоступна, поскольку мягкие резервы
предоставленные данные не были созданы с помощью кнопки «Экспортировать Gargul» на сайте softres.it.]];
L.SOFTRES_IMPORT_DETAILS = "Импортировано |c00A79EFF%s в |c00A79EFF%s.";
L.SOFTRES_IMPORT_FIXED_NAME = "Автоматическое исправление имени: SR «%s» теперь связан с «%s».";
L.SOFTRES_IMPORT_INFO = "Для начала вам сначала нужно создать рейд на softres.it. После этого нажмите «Экспорт аддонов», выберите «Гаргул», скопируйте данные и вставьте их в форму ниже.";
L.SOFTRES_IMPORT_INVALID = "Предоставлены неверные данные мягкого резерва.";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Предоставлены неверные данные. Обязательно нажмите кнопку «Экспортировать Gargul» на сайте softres.it и вставьте сюда все содержимое.";
L.SOFTRES_IMPORT_NEW_PLUSONES = "Предоставленные значения PlusOne конфликтуют с уже существующими. Хотите заменить старые значения PlusOne?";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "Следующие игроки ничего не зарезервировали:";
L.SOFTRES_IMPORT_SUCCESSFUL = "Мягкие резервы успешно импортированы";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "Импорт выполнен успешно!";
L.SOFTRES_IMPORT_USE_GARGUL = "Данные SoftRes Weakaura и CSV устарели, вместо этого используйте экспорт Gargul!";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "Не удалось подключиться к LootReserve. Обратитесь в службу поддержки (сообщите сообщение ниже).";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "URL-адрес softres.it недоступен, убедитесь, что вы экспортировали его с помощью кнопки «Экспорт Gargul» на softres.it!";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "Нажмите здесь, чтобы просмотреть информацию о жестком резерве";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "Ни один элемент не зарезервирован жестко";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "Информация о жестком резерве отсутствует.";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "Опубликовать недостающие запросы на обслуживание";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "URL-адрес публикации запроса на отправку заявок";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "Этот игрок ничего не резервировал!";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "Попытка обработать входящие данные SoftRes от %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "Этот предмет жестко зарезервирован";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "Для: %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Примечание: %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Зарезервировано";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "Что-то пошло не так!";
L.START = "Начинать";
L.STOP = "Останавливаться";
L.TAB_REPLACES_T = "\\t  is replaced by a tab";
L.THATSMYBIS_ABBR = "ТМБ";
L.TIME = "Время";
L.TITLE = "Заголовок";
L.TMBETC = "ТМБ, ДФТ или ПРИО3";
L.TMB_BROADCAST_CONFIRM = "Вы уверены, что хотите передать данные TMB всем членам вашей группы/рейда? Примечание: КАЖДЫЙ может видеть ваши данные TMB независимо от своих разрешений на веб-сайте TMB!";
L.TMB_BROADCAST_PROCESS_START = "Попытка обработать входящие данные TMB от %s";
L.TMB_CLEAR_CONFIRM = "Вы уверены, что хотите удалить все данные плюс один?";
L.TMB_CLEAR_RAIDER_DATA = "Очистить данные рейдера";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "Очистить данные TMB для всех рейдеров?";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "Автоматический обмен включен: %s";
L.TMB_IMPORT_CPO_INFO = "При запуске classicpr.io нажмите кнопку «Экспорт Gargul» и скопируйте содержимое. После этого вставьте содержимое как есть в поле ниже и нажмите «Импортировать». Вот и все!";
L.TMB_IMPORT_DETAILS = "Импортировано ${date} в ${time}.";
L.TMB_IMPORT_DFT_INFO = "Экспортируйте данные DFT в соответствии с инструкциями листа. После этого вставьте содержимое как есть в поле ниже и нажмите «Импортировать». Вот и все!";
L.TMB_IMPORT_INVALID_CSV = "Предоставлен неверный CSV-файл, формат: 6948,player1,player2.";
L.TMB_IMPORT_INVALID_DFT = "Предоставлены неверные данные DFT. Экспортируйте данные DFT в соответствии с инструкциями листа и вставьте сюда содержимое как есть!";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Предоставлены неверные данные TMB. Обязательно нажмите кнопку «Загрузить» в разделе «Гаргул» и вставьте сюда содержимое как есть!";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Предоставлены неверные данные TMB или DFT. Обязательно вставьте сюда содержимое экспорта как есть!";
L.TMB_IMPORT_NOTES_AVAILABLE = "Доступны приоритетные примечания: %s";
L.TMB_IMPORT_NUMBER = "Количество импортированных товаров: %s";
L.TMB_IMPORT_PLAYER_NO_DATA = "У следующих игроков нет записей %s:"; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "Как использовать Гаргул с ${source}";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "Вставьте содержимое экспорта TMB как есть в поле ниже и нажмите «Импортировать».";
L.TMB_NO_BROADCAST_TARGETS = "В вашей группе нет никого, кому можно было бы транслировать";
L.TMB_SYNCED = "Данные TMB синхронизированы";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF Примечание: |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(ОПЕРАЦИОННЫЕ СИСТЕМЫ)";
L.TMB_TOOLTIP_PRIO_HEADER = "%s список приоритетов"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF Уровень: %s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "Список желаний ТМБ";
L.TOGGLE_DATES = "Показать/скрыть даты";
L.TOGGLE_QUEUE = "Показать/скрыть очередь";
L.TRADETIME_AWARD_HOWTO = "%s для награждения добычей!";
L.TRADETIME_ROLL_HOWTO = "%s выдает добычу!";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "Скрыть все награжденные предметы";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "Скрыть разочарованные предметы";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "Скрыть предметы, врученные самому себе";
L.TRADE_ANNOUNCE = "Объявить о торговле";
L.TRADE_ANNOUNCE_INFO = "Объявляйте детали сделки группе или в /say, когда вы не в группе.";
L.TUTORIAL = "Руководство";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s предметы в сумках, окнах добычи или даже по ссылкам в чате, чтобы добавить их в очередь на аукцион.
Хотите напрямую продать товар без торгов? Используйте |c00A79EFF%s

Вы можете открыть окно %s напрямую, набрав |c00A79EFF/gl аукцион.

Следы Гаргула |c00FF0000ВСЕ золото продано. Не хотите, чтобы сделка была частью сессии GDKP? При торговле ставьте галочку «Исключить из GDKP»!

|c00FFF569Знаете ли вы?
Наградные предметы будут автоматически добавлены в окно торговли.
Гаргул также может заняться автоматическим грабежом. Проверьте это с помощью |c00A79EFF/gl pm
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
В этом окне показаны все предметы, которые были выданы в конкретную дату (выберите одну или несколько дат слева).

Элементы могут содержать следующие теги:

|c00A79EFFOS: присуждается за нестандартность.
|c00A79EFFSR: Этот предмет был зарезервирован мягко
|c00A79EFFWL: Этот товар был в списке желаний (Thatsmybis)
|c00A79EFFPL: Этот элемент был добавлен в список приоритетных (Thatsmybis, DFT, prio3)
]];
L.TUTORIAL_BIDDER_QUEUE = [[
Предметы, которые вы видите здесь, находятся в очереди GDKP главного мародёра.
Вы можете удалить их, сделать ставку на них и скрыть неиспользуемые элементы (включите «Скрывать неиспользуемые элементы» в настройках в левом верхнем углу)

Вы можете изменить размер окна, переместить его или свернуть. Попробуйте!

Для мастеров добычи: удаление предметов здесь удалит их только из вашей личной очереди, а не из реальной очереди GDKP!
]];
L.TUTORIAL_MORE_HELP = "Нужна дополнительная помощь?";
L.TYPE = "Тип"; -- As in type of roll or type of item
L.UNKNOWN = "неизвестный";
L.UNKNOWN_COMM_ACTION = "Неизвестное комм-действие «%s», обязательно обновите Гаргул!";
L.UNLOCK = "Разблокировать";
L.UPDATE_GARGUL = "Обновите Гаргул!";
L.VERSION_ABBR = "в";
L.VERSION_CHECK_BUTTON_REPORT = "Отчет";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Сообщите об устаревших результатах в групповом чате";
L.VERSION_CHECK_COLUMN_STATUS = "Статус Гаргула";
L.VERSION_CHECK_STATUS_CHECKING = "Проверяю версию...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s: плеер обновлен
|c00F7922Ev%s: игроку необходимо обновить свои дополнения
|c00BE3333%s: у игрока нет Гаргула или используется неподдерживаемая версия.
|c00808080%s: игрок не в сети или игнорирует нас!
|c0000FFFF%s: игрок в нашем игнор-листе!

]];
L.VERSION_CHECK_STATUS_IGNORED = "ИГРОК ИГНОРИРУЕТСЯ!";
L.VERSION_CHECK_STATUS_OFFLINE = "Не в сети";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "Нет ответа";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "Нет ответа:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Не в сети:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "Устарело:";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "До настоящего времени:";
L.VERSION_INCOMPATIBLE_WARNING = "Гаргул устарел и не будет работать, пока вы не обновите его!";
L.VERSION_INVALID_WARNING = "В Version:addRelease указана неверная строка версии.";
L.VERSION_UPDATE = "Обновите Гаргул!";
L.VERSION_UPDATED = "|c00%sGargul теперь обновлен до |c00%sv%s";
L.VERSION_UPDATE_AVAILABLE = "|c00A79EFFv%s доступен на CurseForge/Wago. Вы можете обновиться, не закрывая игру, просто обязательно /reload!";
L.WAIT_SECONDS_BEFORE_RETRY = "Подождите еще %s секунд, прежде чем повторить попытку.";
L.WINDOW = "Окно";
L.WINDOW_HEADER = "Гаргул против %s";
L.WINDOW_SCALE = "Масштаб окна";
L.WISHLIST_ABBR = "ВЛ";
L.YES = "Да";
L.YOU_DISABLED_GDKP_QUEUES = "Вы отключили очереди GDKP";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "Невозможно сжать данные zlib. Свяжитесь со службой поддержки через https://discord.gg/D3mDhYPVzf.";
L.ZLIB_DECOMPRESS_WARNING = "Невозможно распаковать данные с помощью zlib. Обязательно скопируйте/вставьте его как есть, без добавления каких-либо дополнительных символов или пробелов!";
