--[[
    You can test this locally by removing line 8:
    if (GetLocale() ~= "ruRU") then return; end

    These translations where provided by
        - KartonArmadon
        (edited by Ренгольд-Пламегор
]]
if (GetLocale() ~= "ruRU") then return; end
local L = Gargul_L or {};

L["About"] = "О";
L["All Settings"] = "Все настройки";
L["Announce"] = "Объявить";
L["Anti Snipe"] = "Анти-cнайпер";
L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"] = [[
Значение Анти-cнайпера, равное 10, означает, что любая ставка, которая поступает менее
чем за 10 секунд до конца таймера, сбросит таймер обратно на 10 секунд.

Вы можете оставить это поле пустым или установить значение 0, чтобы полностью отключить Анти-cнайпер.
Значения Анти-cнайпера меньше 5 не поддерживаются.
]];
L["Are you sure?"] = "Вы уверены?";
L["\nDon't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --"] = [[
Не забудьте вместо этого использовать Гаргул.
если вы хотите экспортировать добычу позже


-- Щелкните правой кнопкой мыши, чтобы отключить это окно --]];
L["Auction"] = "Аукцион";
L["Auctioneer"] = "аукционист";
L["Auctions"] = "Аукционы";
L["Auto"] = "Авто";
L["Auto Roll"] = "Авто-бросок";
L["Enable Auto Roll"] = "Включить авто-бросок";
L["Auto roll is active ( profile: %s )"] = "Авто-бросок активен ( профиль: %s )";
L["now supports auto rolling: |c00%s/gl ar|r or |c00%s/gl autoroll|r"] = "Gargul теперь поддерживает авто-бросок: |c00%s/gl ar|r или |c00%s/gl autoroll|r";
L["You automatically passed on %s"] = "Вы автоматически отказались от %s";
L["You automatically needed on %s"] = "Вы автоматически кинули Need на %s";
L["You automatically greeded on %s"] = "Вы автоматически кинули Greed на %s";
L["Action"] = "Действие";
L["Add"] = "Добавить";
L["Add item rules to automatically roll need, greed or pass when a roll is announced. Rules are stored per item ID. When you win an item, its rule is automatically set to pass."] = "Добавьте правила для автоматического броска need, greed или pass. Правила хранятся по ID предмета. При выигрыше предмета его правило автоматически меняется на pass.";
L["Add item rules to automatically roll need, greed or pass when a Gargul roll is announced (does not work with group loot rolls). Rules are stored per item ID. When you win an item, its rule is automatically set to pass. Shift-click items, drag them into the box below or just start typing to search."] = "Добавьте правила для автоматического броска need, greed или pass при объявлении броска Gargul (не работает с бросками группового лута). Правила хранятся по ID. При выигрыше предмета его правило меняется на pass. Shift+клик по предметам или перетащите их в поле ниже.";
L["Add rule"] = "Добавить правило";
L["4. Automatically roll need, greed or pass based on saved rules! Click below or use |c00A79EFF/gl ar"] = "4. Автоматически бросайте need, greed или pass по сохранённым правилам! Нажмите ниже или используйте |c00A79EFF/gl ar";
L["Automatically roll need, greed or pass based on your saved rules when a Gargul roll is announced. Does not work with group loot rolls. Manage rules via the Auto Roll Rules section or |c00A79EFF/gl autoroll|r"] = "Автоматически бросайте need, greed или pass по вашим правилам при объявлении броска Gargul. Не работает с бросками группового лута. Управляйте правилами в разделе Auto Roll Rules или |c00A79EFF/gl autoroll|r";
L["No rules yet. Add an item link and choose need, greed or pass."] = "Правил пока нет. Добавьте ссылку на предмет и выберите need, greed или pass.";
L["Your rules"] = "Ваши правила";
L["Clear all"] = "Очистить всё";
L["Remove all rules from this profile"] = "Удалить все правила из этого профиля";
L["Remove all rules from this profile?"] = "Удалить все правила из этого профиля?";
L["Item link, ID, or type to search"] = "Ссылка или ID предмета";
L["Manage Auto Roll Rules"] = "Управление правилами авто-броска";
L["Invalid item link or ID"] = "Неверная ссылка или ID предмета";
L["(copy)"] = "(копия)";
L["A profile with that name already exists."] = "Профиль с таким именем уже существует.";
L["Copy profile"] = "Копировать профиль";
L["Create profile"] = "Создать профиль";
L["Delete profile"] = "Удалить профиль";
L["Delete profile \"%s\"?"] = "Удалить профиль \"%s\"?";
L["No profile"] = "Нет профиля";
L["Profile name"] = "Имя профиля";
L["Profile: "] = "Профиль: ";
L["Rename profile"] = "Переименовать профиль";
L["Auto award"] = "Авто награда";
L["Auto trade"] = "Авто обмен";
L["Available values:"] = "Доступные значения:";
L["Award"] = "Отдать";
L["Awarded To"] = "Отдано";
L["BR: %s"] = "БР: %s";
L["Price: %s"] = "Цена: %s";
L["Given: yes"] = "Передано: да";
L["Given: no"] = "Передано: нет";
L["2nd bid: %s by %s"] = "2-я ставка: %s от %s";
L["You won"] = "Ты выиграл";
L["Award %s to %s?"] = "Отдать %s %s?";
L["Are you sure you want to disenchant %s? %s boosted roll points will be refunded!"] = "Вы уверены, что хотите распылить %s? %s бонус-роллы будут возвращены!";
L["In Group"] = "В группе";
L["Award history"] = "История наград";
L["Who should %s go to instead?"] = "Кому передать %s?";
L["Type player name here"] = "Введите здесь имя игрока";
L["or select one below"] = "или выберите один ниже";
L["Do you want to award %s to a random player?"] = "Вы хотите отдать %s случайному игроку?";
L["Drag and drop or shift+click an item in the box on the right"] = "Перетащите или нажмите Shift+ЛКМ на предмет в поле справа.";
L["(BR: %s)"] = "(БР: %s)";
L["Disenchanted items:"] = "Распылённые предметы:";
L["(Given: yes)"] = "(Передано: да)";
L["(Given: no)"] = "(Передано: нет)";
L["(OS)"] = "(ОС)";
L["%s boosted roll points will be refunded!"] = "%s бонус-ролл будет возвращён!";
L["Are you sure you want to undo %s awarded to %s?%s"] = "Вы уверены, что хотите отменить награду %s %s?%s"; -- The last %s is the content of L["%s boosted roll points will be refunded!"]
L["Bag inspection failed: no reports received"] = "Проверка сумки не удалась: отчеты не получены";
L["Inspection finished"] = "Проверка завершена";
L["Starting inspection..."] = "Начинаю проверку...";
L["Balance"] = "Баланс";
L["Base"] = "База";
L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Невозможно декодировать данные в формате Base64. Обязательно скопируйте/вставьте его как есть, без добавления каких-либо дополнительных символов или пробелов!";
L["Bid"] = "Ставка";
L["Bids"] = "Ставки";
L["BOE"] = "BoE";
L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"] = "1. Автоматическое приглашение/сортировка групп при регистрации в рейде! Нажмите ниже или используйте |c00A79EFF/gl gr";
L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"] = "2. Награждайте игроков за то, что они являются постоянными клиентами или делают все возможное! Нажмите ниже или используйте |c00A79EFF/gl br";
L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"] = "У Гаргула есть несколько хитростей, о которых вы, возможно, не знали. Посмотрите!";
L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"] = "3. Гаргул включает в себя систему отслеживания плюс один! Нажмите ниже или используйте команду |c00A79EFF/gl po.";
L["Boosted Rolls"] = "Бонус-роллы";
L["BR"] = "БР";
L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"] = [[
Сколько очков добавить каждому, кто сейчас находится в рейде?

|c00BE3333Сначала используйте кнопку «Добавить недостающих рейдеров», если хотите, чтобы все получали очки, даже те, у кого нет усиленного результата броска!]];
L["No point value provided!"] = "Стоимость в баллах не указана!";
L["Add points to raid"] = "Добавить очки рейду";
L["Add missing raiders"] = "Добавить недостающих рейдеров";
L["Aliases"] = "Псевдонимы";
L["Apply aliases"] = "Применить псевдонимы";
L["Boosted Roll Cost:"] = "Стоимость ускоренного броска:";
L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"] = "Вы уверены, что хотите передать данные об усилении всем членам вашей группы/рейда?";
L["Nothing to broadcast, import Boosted Rolls data first!"] = "Нечего транслировать, сначала импортируйте данные бонус-роллов!";
L["Couldn't process BoostedRolls data received from %s"] = "Не удалось обработать данные бонус-роллов, полученные от %s.";
L["Attempting to process incoming BoostedRolls data from %s"] = "Попытка обработать входящие данные бонус-роллов от %s";
L["Are you sure you want to clear all boosted roll data?"] = "Вы уверены, что хотите удалить все данные бонус-роллов?";
L["Delete %s?"] = "Удалить %s?";
L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"] = "Вы уверены, что хотите очистить существующие данные бонус-ролла и импортировать новые данные, передаваемые %s?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Предоставлены неверные данные. Убедитесь, что содержимое соответствует требуемому формату и не включена строка заголовка.";
L["\nHere you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo"] = [[
Здесь вы можете импортировать увеличенные данные и псевдонимы из таблицы в формате CSV или TSV или вставить их из таблицы Документов Google.

В таблице должно быть как минимум два столбца: имя игрока и количество очков. Дополнительные столбцы не являются обязательными и могут содержать псевдонимы игрока.
Вот пример строки:

Фубар, 240, Барфу]];
L["Points"] = "Очки";
L["Points: %s"] = "Очки: %s";
L["N/A"] = "Н/Д";
L["Reserve"] = "Резервировать";
L["\nAre you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Вы уверены, что хотите обновить существующие усиленные броски данными от %s?

Ваше последнее обновление было |c00A79EFF%s, его — |c00A79EFF%s.]];
L["!bonus|!rb|!br"] = "!бонус|!рб|!бр";
L["Broadcast"] = "Передача данных";
L["Broadcasting..."] = "Передача данных...";
L["You are currently in combat, delaying broadcast"] = "Вы сейчас в бою, передача данных задерживается.";
L["Broadcast finished!"] = "Передача данных завершена!";
L["Include awarded items"] = "Включить награждённые предметы";
L["Include disenchanted items"] = "Включить распылённые предметы";
L["Include hidden items"] = "Включить скрытые предметы";
L["Include time left"] = "Включить оставшееся время";
L["Broadcast still in progress"] = "Передача данных ещё продолжается";
L["There is nothing to broadcast"] = "Нечего передавать";
L["Number of items"] = "Количество предметов";
L["Broadcast ${percentage}%"] = "Передача данных ${percentage}%";
L["Target player (whisper only)"] = "Целевой игрок (только шепотом)";
L["Whisper requires a target player"] = "Whisper требует целевого игрока";
L["Max trade time left (in minutes)"] = "Оставшееся максимальное время сделки (в минутах)";
L["by"] = "к"; -- As in 'bid BY'
L["Cancel"] = "Отмена";
L["Get support or share ideas on our Discord"] = "Получите поддержку или поделитесь идеями в нашем Discord";
L["Enable changelog"] = "Включить журнал изменений";
L["Gargul makes handing out loot super easy, click the button below to get started!"] = "Гаргул делает раздачу добычи очень простой: нажмите кнопку ниже, чтобы начать!";
L["Open Gargul"] = "Открыть Гаргул";
L["Adjust Scale"] = "Отрегулировать масштаб";
L["Channel"] = "Канал";
L["Officer"] = "Офицер";
L["Raid Warning"] = "Raid Warning";
L["Whisper"] = "Шепот";
L["CPR"] = "CPR";
L["Clear"] = "Очист."; -- As in clearing a window or data
L["Close"] = "Закрыть";
L["Close on award"] = "Закрыть при награде";
L["Close on start"] = "Закрыть при запуске";
L["Communication"] = "Коммуникация";
L["Sent %s of %s bytes"] = "Отправлено %s из %s байт";
L["c"] = "с";
L["Cut"] = "Доля";
L["Cuts"] = "ДОЛИ";
L["Can't send mail when the mailbox is closed"] = "Невозможно отправить письмо, когда почтовый ящик закрыт";
L["Multiple mail errors detected, aborting cut distribution"] = "Обнаружены многочисленные почтовые ошибки, что приводит к прерыванию рассылки.";
L["You don't owe %s any gold"] = "Вы не должны игроку %s золота";
L["Failed to send cut to %s"] = "Не удалось отправить долю игроку: %s.";
L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"] = "Письмо ОТПРАВЛЕНО согласно игре, но оставшееся у вас ЗОЛОТО НЕ СООТВЕТСТВУЕТ, что-то пошло не так?";
L["Mail History for |c00967FD2%s"] = "История почты для |c00967FD2%s";
L["You don't have enough gold to pay %s"] = "У вас недостаточно золота, чтобы заплатить %s";
L["Wait a bit, we're still processing the previous mail"] = "Подождите немного, мы все ещё обрабатываем предыдущее письмо.";
L["Gargul GDKP: %sg"] = "Гаргул GDKP: %sg";
L["Sent %sg to %s"] = "Отправлено %sg в %s";
L["%Y-%m-%d"] = "%Y-%m-%d";
L["%Y-%m-%d %H:%M"] = "%Y-%m-%d %H:%M";
L["%d-%m %H:%M"] = "%d-%m %H:%M";
L["Delete"] = "УДАЛ";
L["Details"] = "Подробности";
L["DFT"] = "DFT";
L["Disable"] = "ВЫКЛ";
L["https://discord.gg/D3mDhYPVzf"] = "https://discord.gg/D3mDhYPVzf";
L["Disenchant"] = "Диз";
L["Edit"] = "ИЗМ";
L["Enable"] = "ВКЛ";
L["Export"] = "ЭКСП";
L["Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!"] = "Вы уверены, что хотите удалить всю таблицу истории вознаграждений? Это удалит ВСЕ данные о добыче и не может быть отменено!";
L["Are you sure you want to remove all data for %s? This cannot be undone!"] = "Вы уверены, что хотите удалить все данные для %s? Это не может быть отменено!";
L["\nThis is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n"] = [[
Это ТОЛЬКО функция экспорта, редактировать какие-либо значения нет смысла: ОНИ НЕ СОХРАНЯТСЯ!

]];
L["Fill"] = "Наполнять";
L["Final Call"] = "Final Call";
L["Finish"] = "Заканчивать";
L["Format"] = "Формат";
L["Gargul"] = "Гаргул";
L["GDKP"] = "GDKP";
L["GDKP raids are not allowed in this version of World of Warcraft"] = "Рейды GDKP не разрешены в этой версии World of Warcraft.";
L["GDKP Active!"] = "GDKP активен!";
L["Add dropped loot to queue"] = "Добавить выпавшую добычу в очередь";
L["Gold (- for removing gold)"] = "Золото (- для удаления золота)";
L["Who pays for this?"] = "Кто за это платит?";
L["Gold needs to be lower/higher than 0"] = "Золото должно быть ниже/выше 0";
L["Paid for by"] = "Игрок";
L["Adjust gold in %s"] = "Изменить банк для сессии %s";
L["You can't give AND receive gold from the same player at the same time"] = "Вы не можете одновременно отдавать и получать золото от одного и того же игрока.";
L["All cuts were mailed!"] = "Все доли были отправлены по почте!";
L["Disable for disenchanted"] = "Отключить для распыления";
L["Disable in combat"] = "Отключить в бою";
L["Auctions"] = "Аукционы";
L["Created by"] = "Сделано";
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Удалено %s
Причина: %s]];
L["\n|c00%s%s added to pot by %s\nNote: %s"] = [[
|c00%s%s добавлено в банк игроком: %s
Заметка: %s]];
L["Won by"] = "Выиграл";
L["Set paid amount (read left)"] = "Оплата вручную";
L["\n\nGargul automatically keeps track of gold traded. As long as players pay\nfor what they bought then you shouldn't ever need this field\n\n'Paid amount' refers to the amount of gold the buyer already traded you.\nThis does not change the actual price of the item!\n\nWarning: only set a value here if the player promises to pay\noutside of the raid or trades the gold from an alt / mail etc!\n\n\n"] = [[
Gargul автоматически отслеживает переданное золото. Если игроки сразу
оплачивают то, что они купили, то вам никогда не понадобится это поле.

«Оплата вручную» означает количество золота, которое покупатель передал
вам. Фактическая цена товара не меняется!

Внимание: устанавливайте здесь значение только в том случае, если игрок обещает
заплатить вне рейда или передаёт золото через другого персонажа, почту и т.д.!
]];
L["GDKP Price:"] = "Цена GDKP:";
L["Award %s to %s for %s?"] = "Наградить %s %s за %s?";
L["Auto Bid"] = "Авто-ставка";
L["What's your maximum bid? (Minimum %s|c00FFF569g)"] = "Какова ваша максимальная ставка? (Минимум %s|c00FFF569g)";
L["Bid denied!"] = "Ставка отклонена!";
L["Min bid: %sg   Increment: %sg"] = "Мин.ставка: %sg. Шаг: %sg.";
L["(max %sg)"] = "(макс. %sg)";
L["New bid"] = "Новая ставка";
L["Stop Auto Bid"] = "Авто-ставка стоп";
L["Top bid: %s by %s"] = "Макс.ставка: %s от %s";
L["Top bid: %s by you"] = "Макс.ставка: %s от вас";
L["Create a new GDKP session"] = "Создать сессию GDKP.";
L["Management Cut %"] = "Доля РЛа%";
L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"] = "Management Cut должно быть пустым или иметь значение от 0 до 99 (без знака %!)";
L["Choose a session type!"] = "Выберите тип сессии!";
L["Switch to this session"] = "Сделать активной";
L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"] = [[|c00E7BB00Мульти-аукцион позволяет вам делать ставки
на несколько предметов одновременно, ускоряя продажу!

Следуйте инструкциям в центральной части этого окна
после создания сеанса, чтобы начать работу.

С помощью |c00A79EFFОдиночного аукциона|c00E7BB00 вы будете
продавать предметы по-отдельности или использовать очередь.

Выбор |c00A79EFFМульти-аукциона|c00E7BB00 отключает функцию
добавления выпавших предметов в очередь.

Вы можете комбинировать |c00A79EFFМульти-аукцион |c00E7BB00с |c00A79EFFОдиночным аукционом|c00E7BB00
и очередью, но мы настоятельно рекомендуем этого не делать!]];
L["Auction type (|c00A79EFFi for more info)"] = "Тип аукциона";
L["Multi-Auction"] = "Мульти-аукцион";
L["Single-Auction"] = "Одиночный аукцион";
L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"] = "Сессия создана. Мы советуем вам /reload, чтобы он сохранялся правильно на случай сбоя игры!";
L["Add Raider"] = "Добавить";
L["adjust [g]"] = "Изменить [золото]";
L["adjust [%]"] = "Изменить [процент]";
L["Announce the base cut in group chat"] = "Анонсировать базовую долю в групповой чат";
L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"] = "Вы уверены, что хотите сбросить всех игроков и расчёты? Внимание: все игроки, вышедшие из рейда, будут удалены из списка!";
L["Delete Raider"] = "Удалить";
L["Edit Raider"] = "Изменить";
L["Lock and Pay"] = "Блокировать";
L["Manage gold trades"] = "Управлять сделками";
L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"] = [[
С помощью бонусов вы можете давать игрокам больше или меньше золота.
Пример: прибавка танкам 2% — вот для чего это нужно!

Примечание. Редактирование или удаление бонусов изменяет их только для этой сессии.
]];
L["Not in the raid"] = "Не в рейде";
L["\n\nThe total payout can differ slightly from the pot due to rounding differences!\nPlayers currently in the raid can not be edited or removed!\n\nColor explanation:\n|c00F7922E(2000g) Means you owe this person 2000g\n|c00BE3333(3000g) Means this person owes you 3000g\n|c0092FF00(0) Means that you're square\n\nAdjuster explanation:\nWith adjust [g] you can add/deduct gold to a player (use -50 to deduct 50 gold from a player's cut)\nWith adjust [%] you can add/deduct a percentage to a player (use -50 to give players a half cut)\n"] = [[|c00E7BB00Общая выплата может немного отличаться от банка из-за округления чисел!
Игроки, которые в данный момент находятся в рейде, не могут быть отредактированы или удалены!

Цвета:
|c00F7922E(2000г) вы должны этому игроку 2000g;
|c00BE3333(3000г) этот игрок должен вам 3000g;
|c0092FF00(0) означает, что вы в расчёте!
|c00E7BB00
Изменение:
С помощью изменения [золото] вы можете добавить/вычесть золото игроку
(используйте -322, чтобы вычесть 322 золотых из доли игрока);
С помощью изменения [процент] вы можете добавить/вычесть процент игроку
(используйте -50, чтобы снять игроку половину доли).]];
L["%s Raiders | %s With cut | Total payout: %s"] = "%s рейдеров | %s с долей | Общая выплата: %s";
L["Nothing to import, double check your CSV"] = "Импортировать нечего. Проверьте CSV-файл.";
L["Missing gold for player %s"] = "Не хватает золота для игрока: %s";
L["Missing header, note: it's case-sensitive!"] = "Отсутствует заголовок. Обратите внимание: он чувствителен к регистру!";
L["Missing player name"] = "Отсутствует имя игрока";
L["Delete bid. Auction must be stopped first!"] = "Удалить ставку. Аукцион должен быть остановлен первым!";
L["Add a raider to this session"] = "Добавить рейдера в эту сессию";
L["Custom (create your own format)"] = "Пользовательский (создайте свой собственный формат)";
L["Detailed (JSON)"] = "Подробно (JSON)";
L["Share (can be imported by other players)"] = "Строка импорта (может быть импортирован другими игроками)";
L["Your custom format"] = "Ваш индивидуальный формат";
L["Your custom header"] = "Ваш индивидуальный заголовок";
L["Custom (create your own format)"] = "Пользовательский (создайте свой собственный формат)";
L["@PLAYER,@CUT"] = "@ИГРОК,@CUT";
L["Player,Cut"] = "Игрок,Доля";
L["date/time at which the session was locked"] = "дата/время блокировки сессии";
L["total gold given to the player"] = "общее количество золота, полученного игроком";
L["gold mailed to the player"] = "золото отправлено игроку по почте";
L["total gold received from the player"] = "общее количество золота, полученного от игрока";
L["date/time at which the first item was awarded"] = "дата/время, когда был выдан первый предмет";
L["gold traded to the player"] = "золото передано игроку";
L["@ITEM,@WINNER,@GOLD,@WOWHEAD"] = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L["Item,Player,Gold,Wowheadlink"] = "Предмет, Игрок, Золото, Wowheadlink";
L["Date/time at which the first item was awarded"] = "Дата/время получения первого предмета";
L["The title of the GDKP session"] = "Название сессии GDKP";
L["Include disenchanted items"] = "Включить распылённые предметы";
L["Pot changed"] = "Банк изменен";
L["Gold Trades"] = "Обмены золота";
L["Are you sure? You won't be able to see, or bid on, upcoming items!"] = "Вы уверены? Вы не сможете видеть предстоящие товары или делать ставки на них!";
L["\n|c00BE3333!! WARNING !!|r\n\nYou're on a connected realm and are importing player names without\na realm suffix, '%s' for example. This can cause you to send\ncuts and cut mails to the wrong player.\n\nWhen on a connected realm always try to include the realm name of players!\n\nContinue importing?\n"] = [[
|c00BE3333!! ВНИМАНИЕ !!|р

Вы находитесь в подключенном мире и импортируете имена игроков без
суффикс области, например «%s». Это может привести к отправке
доли не тому игроку.

Находясь в подключенном мире, всегда старайтесь указывать имена игроков!

Продолжить импорт?
]];
L["This will override any changes you've made to the cut window, are you sure?"] = "Это действие отменит любые изменения, внесенные вами в окно распределения доли. Вы уверены? ";
L["\nYou can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!):\n\n|c00BE3333Player,Gold|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n"] = [[
Вы можете импортировать доли игроков из собственных расчётов, например Google Таблицы, softres GDKP и т.д.

Формат следующий
|c00BE3333ВКЛЮЧАЯ ЗАГОЛОВОК:

|c00BE3333Player,Gold|c00967FD2
Игрок1,4000
Игрок2,4125
Игрок3,3998

]];
L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"] = [[
Импортируйте минимальные цены и шаг GDKP.

Формат следующий: Требуется ItemID + минимум или шаг. (|c00BE3333ТРЕБУЕТ ЗАГОЛОВОК!!):

|c00BE3333ItemID, минимум, шаг | c00967FD2
186084000500
]];
L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"] = "Удалить существующие настройки цен? Нажмите «Да», чтобы удалить все данные о ценах, или «Нет», чтобы просто заменить существующие данными, которые вы предоставили здесь.";
L["Import GDKP Session"] = "Импортировать сессию GDKP";
L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"] = "Здесь вы можете импортировать (и продолжить) сессию GDKP, которую экспортировал другой игрок в формате «Строка импорта».";
L["You're about to import a GDKP session created by %s, are you sure?"] = "Вы собираетесь импортировать сессию GDKP, созданную %s, вы уверены?";
L["This GDKP session created by %s appears to exist already, do you wish to override it?"] = "Кажется, эта сессия GDKP, созданная %s, уже существует. Вы хотите его переопределить?";
L["Invalid data provided for GDKP extension!"] = "Для расширения GDKP предоставлены неверные данные!";
L["Invalid data provided for GDKP reschedule!"] = "Для переноса графика GDKP предоставлены неверные данные!";
L["Invalid data provided for GDKP shortening!"] = "Для сокращения GDKP предоставлены неверные данные!";
L["Invalid data provided for GDKP auction start!"] = "Для начала аукциона GDKP предоставлены неверные данные!";
L["Invalid number provided for 'paid'"] = "Указан неверный номер для «платного»";
L["Invalid time provided in Auction:reschedule"] = "В разделе Аукцион:перепланирование указано неверное время.";
L["\n\n|c00967FD2GDKP Data (sold %sx)\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n\n"] = [[

|c00967FD2GDKP Данные (продано %sx)
Последняя продажа за: %s
Средняя цена: %s
Минимальная ставка: %s
Шаг: %s

]];
L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"] = "Баланс: |c0092FF000? Вы в расчёте!  |cFFFFFFFF||  |c00BE3333X? вы должны %s Xг  |cFFFFFFFF|  |c00F7922EY? %s должен вам Yг";
L["Gold mailed to you by %s"] = "Золото по почте от < %s";
L["Gold paid to %s"] = "Золота передал > %s";
L["Gold received from %s"] = "Золота получил от < %s";
L["Gold %s by"] = "Золото %s от"; -- %s = removed or added
L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"] = "Общий банк: %sg | Доля РЛа: %sg (%s%%) | Банк: %sg";
L["|c00967FD2%s | By %s%s | On |c00967FD2%s"] = "|c00967FD2Сессия: |cFFFFFFFF%s  |  |c00967FD2Автор: %s%s  |cFFFFFFFF|  |c00967FD2Дата: |cFFFFFFFF%s";
L["The GDKP Session is not available or locked"] = "Сессия GDKP недоступна или заблокирована.";
L["Mail All"] = "Почта всем";
L["No bids on Legendary+ item detected, continue manually!"] = "Ставок на предмет Legendary+ не обнаружено, продолжите вручную!";
L["Missing content in Auction:start"] = "Отсутствует контент на аукционе:начать";
L["\n\nWith multi auctions (or batch auctions) you can auction off as many items as you want at once!\nThis speeds up your raid nights immensely and makes for a seamless experience for your raiders\n\nAll tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'\nGive it a shot!\n\n|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!\n\n"] = [[

С помощью нескольких аукционов (или пакетных аукционов) вы можете продавать с аукциона столько предметов, сколько захотите одновременно!
Это значительно ускоряет ваши рейды и обеспечивает беспрепятственный опыт для ваших рейдеров.

Все торгуемые предметы, которые все ещё находятся в вашем инвентаре, могут быть автоматически проданы с аукциона с помощью функции «Заполнить из инвентаря».
Дать ему шанс!

|c00808080Есть только один минус: чтобы люди могли принять участие в пакетном аукционе, рейдерам понадобится Гаргул!

]];
L["You need to have an active (unlocked) GDKP session!"] = "Вам необходимо иметь активную (разблокированную) сессию GDKP!";
L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"] = "Пока это окно открыто: %s, чтобы добавить предметы в список или нажмите «Заполнить из инвентаря» ниже."; -- %s holds the add item hotkey (default ALT_CLICK)
L["Anti snipe in seconds"] = "Анти-снайпер";
L["The anti snipe value needs to be 0 (empty) or >=5"] = "Значение анти-снайпа должно быть 0 (пусто) или >=5.";
L["Go back to the item selector"] = "Вернитесь к выбору предметов";
L["Remove all items from the list"] = "Удалить все элементы из списка";
L["Fill from inventory"] = "Заполнить из инвентаря";
L["Add tradeable items from your inventory to the list"] = "Добавьте в список продаваемые предметы из своего инвентаря.";
L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"] = [[
В этом окне вы формируете список предметов для мульти-аукциона.

Используйте кнопку «Заполнить из инвентаря», расположенную ниже, чтобы добавить в список предметы, которые хотите продать.
Всякий раз, когда вы очищаете и снова открываете это окно, последние настройки заполнения будут использоваться автоматически для добавления предметов.

Чтобы добавить предметы вручную используйте |c00A79EFF%s
]];
L["Next step: check raider's add-on version for compatibility"] = "Следующий шаг: проверка версии Gargul у других участников рейда на совместимость";
L["Not everyone is using Gargul, are you sure you want to start the auction?"] = "Не все используют Гаргул. Вы уверены, что хотите начать аукцион?";
L["Select at least one item for your auction"] = "Выберите хотя бы один предмет для своего аукциона";
L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"] = "Ваш Gargul устарел. Мы рекомендуем обновить его перед началом сессии, чтобы предотвратить ошибки!";
L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"] = "Не у всех последняя версия. Если у вас возникли проблемы, попросите своих рейдеров обновиться!";
L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"] = "Существует активный мульти-аукцион, предметы, которые вы сюда добавляете, будут добавлены в существующую сессию. Будьте осторожны с дублирующими предметами!";
L["Search name or iLVL"] = "Поиск по имени или iLVL";
L["Supports item names and iLVL e.g. '252', '<252' etc"] = "Поддерживает названия предметов и их iLVL, например. «252», «<252» и т. д.";
L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"] = "Активная сессия GDKP: |c00967FD2%s | Автор: %s%s | На |c00967FD2%s";
L["Auction time in seconds"] = "Время аукциона в сек.";
L["The auction time in seconds needs to be >= 10"] = "Время аукциона в секундах должно быть >= 10.";
L["You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items"] = "Вы ушли во время сессии торгов GDKP. Чтобы возобновить её, вам необходимо указать новое время ставки (в секундах) для любых непроданных товаров.";
L["With this window open, %s items to add them to the list"] = "С открытием этого окна, %s предметов добавится в список.";
L["Click the cogwheel icon to manage an auction"] = "Нажмите на шестёнку для доп.опций.";
L["You're already the top bidder on %s"] = "Вы уже являетесь лидером торгов на %s";
L["Bid |c00%s%sg\nBy %s"] = [[
Ставка |c00%s%sg
%s]];
L["|c00%sCLOSED\nNo bids"] = [[
|c00%sЗАКРЫТО
Нет ставок]];
L["Minimum: |c00%s%sg\nIncrement: |c00%s%sg"] = [[
Минимум: |c00%s%sg
Шаг: |c00%s%sg]];
L["Items: %s  -  Total sold: %sg  -  Pledged by me: %sg"] = "Предметов: %s - Всего продано: %sg - Мой залог: %sg";
L["Items with bids: %s/%s\nTotal sold: %s\nBought by me: %s\nTotal bid (does not include sold): %s\nBid by me (does not include sold): %s\n"] = [[
Предметы со ставками: %s/%s
Всего продано: %s
Куплен мной: %s
Общая ставка (не включает проданные): %s
Моя ставка (не включает проданные): %s
]];
L["|c00%sSOLD to%s\nfor |c00%s%s"] = [[
|c00%s%s
SOLD |c00%s%s]];
L["Bid |c00%s%s\nBy |c0092FF00YOU!"] = [[
Bid |c00%s%s
By |c0092FF00YOU!]];
L["Could not stop auto bidding on %s, try again or /reload!"] = "Не удалось остановить авто-ставки для %s. Повторите попытку или /reload!";
L["Auto bid up to a maximum of %sg"] = "Автоматическая ставка до максимум %sg";
L["Auto bid up to the bid you fill in on the left"] = "Автоматическая ставка до суммы, которую вы указали слева.";
L["Stop your auto bid (%sg)"] = "Остановите автоматическую ставку (%sg)";
L["Bid on %s could not be confirmed"] = "Ставка на %s не может быть подтверждена";
L["Invalid bid or bid is too low! The minimum is %sg"] = "Недействительная ставка или ставка слишком низкая! Минимум — %sg.";
L["You need to wait two seconds between bids on the same item"] = "Вам нужно подождать две секунды между ставками на один и тот же товар.";
L["Clear bids"] = "Обнулить";
L["Remove all bids from the auction"] = "Удалить все ставки с аукциона";
L["Close all"] = "Закрыть все";
L["Close ALL auctions?"] = "Закрыть ВСЕ аукционы?";
L["Close ALL auctions\n\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Закрыть ВСЕ аукционы

Аукционы с активными ставками на них будут проданы и не смогут принимать новые ставки!
]];
L["Close Auction"] = "Закр.аук";
L["Close the auction. Players can no longer bid but the highest bid remains active"] = "Закройте аукцион. Игроки больше не могут делать ставки, но самая высокая ставка остается активной.";
L["Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!"] = "Удалите предмет с аукциона, включая информацию о его ставке. ЭТО НЕЛЬЗЯ ОТМЕНИТЬ!";
L["Disenchant all finished but unsold items?"] = "Расчаровать все готовые, но непроданные предметы?";
L["Disenchant unsold items\n\nThis will mark all unsold items as disenchanted and they will not show up in a new multi-auction session"] = [[
Расчаровать непроданные предметы

Все непроданные предметы будут отмечены как распылённые, и они не будут отображаться в новой сессии нескольких аукционов.
]];
L["Favorite this item"] = "Добавить в избранное этот товар";
L["Give a final call timer of how many seconds?"] = "На сколько секунд дать таймер финального отсчёта?";
L["The minimum amount of seconds is 5"] = "Минимальное количество секунд — 5";
L["Start a final call for this auction by giving a (usually shorter) bid timer"] = "Начните финальный отсчёт на этом аукционе, установив таймер ставки (обычно более короткий).";
L["Close ALL auctions and wrap up this multi-auction session?"] = "Закрыть ВСЕ аукционы и завершить эту многоаукционную сессию?";
L["Finish Multi-Auction session\n\nThis will close all auctions and announce the total pot in chat\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Завершить сеанс мульти-аукциона

Это закроет все аукционы и объявит общий размер банка в чате.
Аукционы с активными ставками на них будут проданы и не смогут принимать новые ставки!
]];
L["Hide inactive"] = "Скрыть неактивный";
L["Hide unusable"] = "Скрыть непригодное для использования";
L["Show/Hide finished auctions"] = "Показать/Скрыть завершенные аукционы";
L["Manage Auction"] = "Управление аукционом";
L["Bid the minimum required amount"] = "Предложите минимальную необходимую сумму";
L["Bidding window closed, use |c00A79EFF/gl bid to reopen it!"] = "Окно ставок закрыто. Используйте команду |c00A79EFF/gl bid, чтобы открыть его снова!";
L["Announce sales in chat"] = "Анонсируйте продажи в чате";
L["Play sound when outbid"] = "Воспроизводить звук, когда ставка перебита";
L["More sound options..."] = "Больше вариантов звука...";
L["Show all"] = "Показать все";
L["Show favorites"] = "Показать избранное";
L["Show inactive"] = "Показать неактивное";
L["Show unusable"] = "Показать непригодные для использования";
L["This item was sold. Use ledger (|c00%s/gdkp) to make changes!"] = "Этот товар продан. Используйте |c00%s/gdkp для изменений!";
L["Terminate"] = "Прекратить";
L["Remove all bidsl bids and close all auctions?"] = "Удалить все ставки bidsl и закрыть все аукционы?";
L["Terminate Multi-Auction session\n\nThis will delete all bids on items that haven't sold yet and close all auctions!"] = [[
Завершить сеанс мульти-аукциона

Это приведет к удалению всех ставок на ещё не проданные товары и закрытию всех аукционов!
]];
L["Hover over any of the buttons below for more information"] = "Наведите на кнопку для подсказки";
L["Show/Hide items you can't use"] = "Показать/скрыть предметы, которые вы не можете использовать";
L["Invalid data provided for GDKP auction start!"] = "Для начала аукциона GDKP предоставлены неверные данные!";
L["%s bought %s for %s"] = "%s купил %s за %s";
L["The loot master (%s) is outdated, this can cause bids to fail!"] = "Мастер добычи (%s) устарел, это может привести к провалу ставок!";
L["You were outbid!"] = "Ваша ставка была перебита!";
L["Mutators"] = "Бонусы";
L["Add Mutator"] = "Добавить";
L["Auto apply to"] = "Автоматически применять к";
L["Create a new GDKP mutator"] = "Добавить новый GDKP бонус";
L["Delete. Hold shift to bypass confirmation"] = [[Удалить бонус.
Удерживайте Shift, чтобы удалить без подтверждения]];
L["Edit mutator"] = "Редактировать бонус";
L["Flat gold rate [example: 250]"] = "Фикс. ставка золота";
L["The flat rate needs to be a number"] = "Фиксированная ставка должна быть числом";
L["\nExample:\n|c00967FD2SELF,RL,HEALER"] = [[
Пример:
|c00967FD2SELF,RL,ЦЕЛИТЕЛЬ]];
L["You can automatically apply this mutator to raiders using keywords:"] = "Автоматически применить этот бонус к рейдерам, по ключевым словам:";
L["Name [example: Tanks]"] = "Название [пример: Танки]";
L["Mutator names can not contains dots (.)"] = "Имена бонусов не могут содержать точки (.)";
L["Percentage [example: 10]"] = "Процент [пример: 10]";
L["The percentage needs to be a number"] = "Процент должен быть числом";
L["Store for future sessions"] = "Сохранить на будущее";
L["Unknown mutator: %s"] = "Неизвестный бонус: %s";
L["User '%s' is not allowed to start auctions"] = "Пользователю «%s» не разрешено начинать аукционы.";
L["User '%s' is not allowed to stop auctions"] = "Пользователю «%s» не разрешено останавливать аукционы.";
L["User '%s' is not allowed to stop auction: auction invalid"] = "Пользователю «%s» не разрешено останавливать аукцион: аукцион недействителен.";
L["There's not enough gold to distribute, expect some weird cut calculations!"] = "Недостаточно золота для распределения, возможны странные рассчёты долей!";
L["No bids!"] = "Ставок нет!";
L["You were outbid!"] = "Ваша ставка была перебита!";
L["(active)"] = "(активная)";
L["\nYou need lead or master loot to adjust gold.\nYou can't adjust gold on locked/deleted sessions"] = [[
Чтобы отрегулировать золото, вам понадобится роль лидера или мастер-лутера.
Вы не можете регулировать золото в заблокированных/удалённых сессиях.]];
L["Add/Remove gold"] = "Добавить/удалить золото";
L["\n%s paid |c00%s%s for\n%s"] = [[
%s |cFFFFFFFFзаплатил |c00%s%s |cFFFFFFFFза
%s]]; -- Player paid 5000g for [Benediction]
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Удалён %s
Причина: %s]];
L["(deleted)"] = "(удалено)";
L["\nYou need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions"] = [[
Для удаления записей вам понадобится роль лидера или мастер-лутера.
Вы не можете удалять записи в заблокированных/удалённых сессиях.]];
L["Provide a reason for deleting this entry"] = "Укажите причину удаления этой записи";
L["Delete. Hold shift to bypass note"] = "Удалить. Удерживайте Shift, чтобы пропустить заметку";
L["Sessions with auctions attached to them will be deleted after 48 hours"] = "Сессии с прикрепленными к ним аукционами будут удалены через 48 часов.";
L["\nYou need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions"] = [[
Для редактирования записей вам понадобится роль лидера или мастер-лутера.
Вы не можете редактировать удаленные записи или записи в заблокированных/удаленных сессиях.]];
L["Export a session so others can view session details or even replace you as a loot master"] = "Экспортируйте сессию, чтобы другие могли просмотреть детали или заменить вас в качестве ответственного за добычу";
L["Import a session from another player or account"] = "Импортируйте сессию другого игрока или с другой учётной записи";
L["\nShow a full overview of the ledger,\nideal for screenshotting purposes!"] = [[Показать полный обзор сессии,
идеально подходит для создания скриншотов!]];
L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"] = [[Блокировка сессии означает, что вы не сможете продавать предметы на аукционе или изменять что-либо, пока не разблокируете её обратно.
Вы уверены?]];
L["Lock or unlock the session"] = "Заблокировать или разблокировать сессию";
L["Lock the session for payout"] = "Заблокировать сессию";
L["Multi-auction: auction multiple items at once!"] = "Мульти-аукцион: выставляйте на аукцион несколько предметов одновременно!";
L["added to"] = "добавлено в банк";
L["\n|c00%s%s %s pot by %s\nNote: %s"] = [[
|c00%s%s %s игроком: %s
Заметка: %s]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L["removed from"] = "удалено из банка";
L["\nPot: %s\nManagement cut (%s%%): %sg\nPer player cut (1/%s): %sg\n"] = [[
Общий банк: %s
Доля РЛа (%s%%): %sg
Доля на игрока (1/%s): %sg
]];
L["\nYou need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions"] = [[
Для восстановления записей вам понадобится роль лидера или мастер-лутера.
Вы не можете восстановить записи заблокированных/удалённых сессий.]];
L["By %s%s | On |c00%s%s%s"] = "Автор: %s%s | |c00%s%s%s"; -- By name<guild> on date
L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"] = "Разблокировка и изменение банка или ставок может оказаться очень запутанной задачей, особенно если вы уже произвели выплаты. Вы уверены?";
L["Unlock the session"] = "Разблокировать сессию";
L["No active GDKP session detected or session is not locked for payout!"] = "Активная сессия GDKP не обнаружена или сессия не заблокирована для выплаты!";
L["Increment or minimum can't be lower than .0001!"] = "Шаг или минимум не может быть меньше 0,0001!";
L["Invalid 'Increment' provided for item ID '%s'"] = "Для идентификатора элемента «%s» указан неверный шаг.";
L["Invalid 'Minimum' provided for item ID '%s'"] = "Для идентификатора элемента '%s' указан неверный 'Минимум'.";
L["Either minimum or increment is required for item ID: %s"] = "Для идентификатора элемента требуется минимум или шаг: %s";
L["Missing header, note: it's case-sensitive!"] = "Отсутствует заголовок. Обратите внимание: он чувствителен к регистру!";
L["Successfully imported data for %s items"] = "Успешно импортированы данные для %s предметов.";
L["Unknown item ID: %s"] = "Неизвестный идентификатор предмета: %s";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.\nItems in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.\n\nWant Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!\n\n|c00FFF569Did you know?\nYou can move items around with drag and drop\nItems will be remembered, even when you |c00A79EFF/reload\nQueued items are automatically shown to raiders who have Gargul so they can prebid\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s предметов в сумках, окнах добычи или даже по ссылкам в чате, чтобы добавить их в эту очередь аукциона.
Предметы в очереди будут автоматически проданы с аукциона после завершения текущего аукциона. Нажмите кнопку «%s», чтобы предотвратить это.

Хотите, чтобы Гаргул автоматически присуждал или расколдовывал аукционы за вас? Откройте колесо настроек слева!

|c00FFF569Знаете ли вы?
Вы можете перемещать предметы с помощью перетаскивания
Предметы будут запоминаться, даже если вы |c00A79EFF/перезагрузите
Предметы в очереди автоматически отображаются рейдерам, у которых есть Гаргул, чтобы они могли сделать предварительную ставку.
Гаргул также может заняться авто-лутом. Проверьте это с помощью |c00A79EFF/gl pm
]];
L["Hide unusable items"] = "Скрыть неиспользуемые элементы";
L["GDKP Session"] = "Сессия GDKP";
L["Editing %s"] = "Редактирование %s";
L["Show upcoming items"] = "Показать предстоящие товары";
L["Stop the auction first!"] = "Сначала остановите аукцион!";
L["%s owes you %s"] = "%s должен вам %s";
L["\n|c00967FD2GDKP Session\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s\n"] = [[
|c00967FD2GDKP Сессия
Потрачено игроком: %s
Дано: %s
Получено: %s
Доля игрока: %s

%s
]];
L["Exclude from GDKP"] = "Исключить из GDKP";
L["Gold traded will not be added to amount given or received"] = "Проданное золото не будет добавлено к отданной или полученной сумме.";
L["Gold |c00967FD2given to %s"] = "Золото |c00967FD2 передано %s";
L["Unable to add %s to the trade window. Try adding it manually!"] = "Невозможно добавить %s в окно торговли. Попробуйте добавить его вручную!";
L["You don't have enough money to pay %s"] = "У вас недостаточно денег для оплаты %s";
L["To give: %s"] = "Чтобы дать: %s";
L["To receive: %s"] = "Чтобы получить: %s";
L["Gold |c00967FD2received from %s"] = "Золото |c00967FD2 получено от %s";
L["Check out Multi Auctions!"] = "Мульти-аукцион";
L["Follow the steps below to quickly get started with Gargul GDKP!"] = "Следуйте инструкциям ниже, чтобы быстро начать работу с Gargul GDKP!";
L["Activate this session by clicking the |c00FFF569Enable button below!"] = "|c00967FD2Активируйте эту сессию, нажав кнопку |c00FFF569ВКЛ |c00967FD2ниже!";
L["|c00FFF569%s an item to auction or queue a single item"] = [[%s
|c00FFF569Выставить предмет на аукцион или поместить его в очередь.
]]; -- %s holds the auction item hotkey (default ALT_CLICK)
L["\nHelpful commands:\n- |c00FFF569/gdkp to open this window\n- |c00FFF569/gl ma to open the multi-auction window\n- |c00FFF569/gl au to open the single item auctioneer / queue\n- |c00FFF569/gl pm to set up auto-looting\n\n"] = [[Полезные команды:
|c00FFF569- /gdkp, чтобы открыть это окно
|c00FFF569- /gl ma, чтобы открыть мульти-аукцион
|c00FFF569- /gl au, чтобы открыть аукцион/очередь с одним предметом
|c00FFF569- /gl pm для настройки автоматического лута
]];
L["If all went well then you will see your freshly auctioned item(s) here!"] = [[Если всё хорошо
|c00FFF569Вы увидите только что выставленные на аукцион предметы!
]];
L["Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!"] = [[Мульти-аукцион:
|c00FFF569/gl ma или нажмите на значок в правом верхнем углу этого окна!
]]
L["Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created"] = "Нажмите кнопку |c00FFF569НОВ ниже, чтобы создать первую сессию GDKP. Она будет отображаться в списке слева.";
L["You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!"] = [[Вы готовы продавать предметы!
|c00BE3333Внимательно прочитайте шаги ниже и выполните их (не обязательно участвовать в рейде), прежде чем начинать свой первый рейд GDKP!
]];
L["Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!"] = [[%s
|c00FFF569Продать товар без торгов. Выберите победителя и установите цену!
]];
L["Getting started"] = "Первые шаги!";
L["Unknown itemID in Auction:create: %s"] = "Неизвестный идентификатор предмета на аукционе: создать: %s";
L["Unknown sessionIdentifier in Auction:create: %s"] = "Неизвестный идентификатор сессии на аукционе: создать: %s";
L["You owe %s %s"] = "Вы должны %s %s";
L["Given"] = "Отдал";
L["g"] = "г";
L["Group"] = "Группа";
L["Group Manager"] = "Менеджер группы";
L["Download on CurseForge"] = "Скачать на CurseForge";
L["https://addons.wago.io/addons/gargul/versions?stability=stable"] = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L["Halt"] = "Остановиться";
L["Header"] = "Заголовок";
L["v%s. Type |c00967FD2/gl|r or |c00967FD2/gargul|r to get started!"] = "v%s. Чтобы начать, введите |c00967FD2/gl|r или |c00967FD2/gargul|r!";
L["Hide"] = "Скрыть";
L["%H:%M"] = "%H:%M";
L["Visit the URL below to learn more about personalizing Gargul GDKPs"] = "Посетите URL-адрес ниже, чтобы узнать больше о персонализации Gargul GDKP.";
L["Your logo here? Click for more info!"] = "Нажмите, чтобы получить дополнительную информацию!";
L["Import"] = "ИМП";
L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"] = "Импортировано |c00A79EFF%s по адресу |c00A79EFF%s, обновлено |c00A79EFF%s по адресу |c00A79EFF%s";
L["What kind of data would you like to import?"] = "Какие данные вы хотите импортировать?";
L["Import of boosted roll data successful"] = "Импорт данных бонус-ролла успешен.";
L["Inc"] = "Шаг";
L["Include previously awarded items"] = "Включить ранее разыгранные предметы";
L["Include BOEs"] = "Включить BOE";
L["Include materials (like Abyss Crystals)"] = "Включить материалы (например, кристаллы Бездны)";
L["Increment"] = "Шаг";
L["Info"] = "Инфо";
L["Invalid data supplied"] = "Предоставлены неверные данные";
L["Item"] = "Элемент";
L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Невозможно декодировать данные JSON. Обязательно скопируйте/вставьте его как есть, без добавления каких-либо дополнительных символов или пробелов!";
L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"] = [[
Горячие клавиши для предметов Гаргула

Разролл: |c00A79EFF%s
Награда: |c00A79EFF%s
Распылить: |c00A79EFF%s


-- Щелкните правой кнопкой мыши, чтобы отключить это окно --
]];
L["Ledger"] = "Бух. книга";
L["<"] = "<";
L["You need to be the master looter or have an assist / lead role!"] = "Вам нужно быть ответственынм за добычу или быть помощником/лидером!";
L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"] = "Примечание. Вы можете изменить локаль в любой момент в настройках или через |c00%s/gl locale.";
L["deDE"] = "Немецкий"; -- German (Germany)
L["enUS"] = "Английский (Великобритания)"; -- English (United States)
L["esES"] = "Испанский (Испания)"; -- Spanish (Spain)
L["esMX"] = "Испанский (Мексика)"; -- Spanish (Mexico)
L["frFR"] = "Французский"; -- French (France)
L["itIT"] = "Итальянский"; -- Italian (Italy)
L["koKR"] = "Корейский"; -- Korean (Korea)
L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"] = [[
Гаргул публикует сообщения в чате на английском языке (по умолчанию).
Вы можете выбрать другой язык в раскрывающемся списке ниже.

Ваш текущий язык чата — «%s», включение другого языка приведет к перезагрузке!
]];
L["Choose a chat language for Gargul"] = "Выберите язык чата для Гаргула";
L["ptBR"] = "Португальский"; -- Portuguese (Brazil)
L["ruRU"] = "Русский"; -- Russian (Russia)
L["zhCN"] = "Китайский (Упрощённый)"; -- Chinese (Simplified, PRC)
L["zhTW"] = "Китайский (Традиционный)"; -- Chinese (Traditional, Taiwan)
L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"] = "У вас установлено одно или несколько дополнений, которые потенциально могут привести к неправильной работе Гаргула: %s";
L["Clear SoftRes"] = "Очистить SoftRes";
L["Clear TMB"] = "Очистить ТМБ";
L["/roll for MS or /roll 99 for OS"] = "/roll для МС или /roll 99 для ОС";
L["Import SoftRes"] = "Импортировать SoftRes";
L["Import TMB"] = "Импортировать TMB";
L["You were given the role of Master Looter"] = "Вам дали роль мастер-лутера.";
L["Open this window automatically"] = "Открыть это окно автоматически";
L["Loot priorities cleared successfully"] = "Приоритеты добычи успешно очищены";
L["Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc"] = "Предоставьте CSV-файл prio в следующем формате (1 строка на элемент): идентификатор или имя > prio1, Equalprio > prio2 > и т. д.";
L["Loot priorities imported successfully"] = "Приоритеты добычи успешно импортированы.";
L["Invalid data provided"] = "Предоставлены неверные данные";
L["Invalid data provided in line: '%s': missing item id or priority"] = "В строке предоставлены неверные данные: «%s»: отсутствует идентификатор элемента или приоритет.";
L["Attempting to process incoming loot priorities from %s"] = "Попытка обработать входящие приоритеты добычи от %s.";
L["Loot Prio"] = "Лут Прио";
L["Mail"] = "Почта";
L["Mailed"] = "По почте";
L["Mail cut to players"] = "Почтовая рассылка игрокам";
L["MS"] = "MS";
L["Maximize"] = "Максимизировать";
L["Min"] = "Мин";
L["Awarded loot history"] = "История наград";
L["GDKP Cuts"] = "GDKP срезы";
L["Export data"] = "Экспорт данных";
L["Open Gargul"] = "Открыть Гаргул";
L["Import data"] = "Импортировать данные";
L["GDKP Ledger"] = "Бух. книга GDKP";
L["Multiauction"] = "Мульти-аукцион";
L["Change settings in /gl minimap"] = "Измените настройки в мини-карте /gl.";
L["Minimize"] = "Свернуть";
L["Minimize on award"] = "Минимизировать награду";
L["Minimize on start"] = "Свернуть при запуске";
L["Minimum"] = "Минимум";
L["Minimum item level"] = "Минимальный уровень предмета";
L["Minimum Quality"] = "Минимальное качество";
L["-10"] = "-10";
L["-"] = "-";
L["Move"] = "Передвинуть";
L["Multi-Auction"] = "Мульти-аукцион";
L["Name"] = "Имя";
L["New"] = "НОВ";
L["Next"] = "Далее";
L["No"] = "Нет";
L["None"] = "Никто";
L["Note"] = "Заметка";
L["Nothing"] = "Ничего";
L["When no one bids do:"] = "Когда никто не делает ставок:";
L["You don't have officer privileges"] = "У вас нет офицерских привилегий";
L["OS"] = "OS";
L["Ok"] = "ОК";
L["Open"] = "Открыть";
L["Open Auctioneer"] = "Открыть аукционы";
L["Open Multi-Auction"] = "Открыть мульти-аукцион";
L["DE"] = "DE";
L["GREED"] = "GREED";
L["IGNORE"] = "IGNORE";
L["NEED"] = "NEED";
L["PASS"] = "PASS";
L["RANDOM"] = "RANDOM";
L["RR"] = "RR";
L["SELF"] = "SELF";
L["Set %s as your disenchanter?"] = "Назначить %s своим дизенчантером?";
L["Send %s to %s? Type /gl cd to remove this disenchanter!"] = "Отправить %s %s? Введите /gl cd, чтобы удалить этого дизенчантера!";
L["No disenchanter set, use /gl sd [mydisenchanter] to set one"] = "Нет дизенчантеров, используйте /gl sd [mydisenchanter], чтобы назначить его.";
L["Who is your disenchanter?"] = "Кто твой дизенчантер?";
L["Paid"] = "Потратил";
L["Pass"] = "Пасс";
L["%"] = "%";
L["Player"] = "Игрок";
L["Items won by %s:"] = "Предметы, выигранные %s:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L["Plus Ones"] = "Плюс Один";
L["Add a +1"] = "Добавить +1";
L["Are you sure you want to broadcast your plus one data to everyone in your party/raid?"] = "Вы уверены, что хотите передать данные PlusOnes всем в вашей группе/рейде?";
L["Attempting to process incoming PlusOnes data from %s"] = "Попытка обработать входящие данные PlusOnes от %s";
L["%s wants to clear all your PlusOne data. Clear all data?"] = "%s хочет удалить все ваши данные PlusOne. Удалить все данные?";
L["Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?"] = "Вы уверены, что хотите очистить существующие данные PlusOne и импортировать новые данные, передаваемые %s?";
L["Are you sure you want to import new data broadcasted by %s?"] = "Вы уверены, что хотите импортировать новые данные, переданные %s?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Предоставлены неверные данные. Убедитесь, что содержимое соответствует требуемому формату и не включена строка заголовка.";
L["\nHere you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240\n"] = [[
Здесь вы можете импортировать плюс один данные из таблицы в формате CSV или TSV или вставить из листа Документов Google.

В таблице должно быть как минимум два столбца: имя игрока и количество очков. Дополнительные столбцы игнорируются.

Вот пример строки:

Фубар, 240
]];
L["Automatically accept incoming broadcasts from %s"] = "Автоматически принимать входящие передачи от %s";
L["Block all incoming +1 shared data"] = "Блокировать все входящие данные +1";
L["\nAre you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Вы уверены, что хотите обновить существующие данные PlusOne данными от %s?

Ваше последнее обновление было |c00A79EFF%s, его — |c00A79EFF%s.]];
L["!plusone|!po|!+1"] = "!plusone|!po|!+1";
L["+"] = "+";
L["Pot"] = "Банк";
L["Price"] = "Цена";
L["PL"] = "ПЛ";
L["Common"] = "Общий";
L["Epic"] = "Эпический";
L["Heirloom"] = "Наследуемое";
L["Legendary"] = "Легендарный";
L["Poor"] = "Серый";
L["Rare"] = "Редкий";
L["Uncommon"] = "Необычный";
L["Queue"] = "Очередь";
L["Raiders"] = "Рейдеры";
L["Who's Missing"] = "Кого не хватает";
L["Show missing player names"] = "Показать недостающие имена игроков";
L["Disband raid"] = "Распустить рейд";
L["Disband your raid"] = "Распустить свой рейд";
L["%s is listed twice on the roster!"] = "%s указан в списке дважды!";
L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"] = "экспорт |c00FFF569Raid-Helper (используйте вариант «Группы с вертикальной сортировкой») или CSV-файл |c00FFF569Gargul с составом группы:";
L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"] = [[
В большом поле редактирования ниже вы можете указать список и пригласить всех, проверить, кто отсутствует, применить группы и назначить танков.

Вы можете предоставить ссылку на состав рейда |c00FFF569Wowhead:]];
L["Gargul Group Wiki"] = "Вики Сообщества Гаргул";
L["Visit the Gargul group wiki for more info on the raid group format"] = "Посетите вики группы Гаргул для получения дополнительной информации о формате рейдовой группы.";
L["The following players are not part of the roster: %s"] = "Следующие игроки не входят в состав: %s";
L["Invalid group data provided, check your format!"] = "Предоставлены неверные данные группы, проверьте свой формат!";
L["Invite"] = "Пригласить";
L["Send invites to players on roster"] = "Отправка приглашений игрокам в составе";
L["Can't sort groups while %s is in combat!"] = "Невозможно сортировать группы, пока %s находится в бою!"; -- %s holds a player name
L["You need to be in a raid!"] = "Вам нужно быть в рейде!";
L["No tanks defined"] = "Танки не назначены";
L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"] = "Не получается найти место для %s. Вы пытаетесь объединить более 5 человек в 1 группу?";
L["Kick unwanted players"] = "Исключить нежелательных игроков";
L["Kick players that aren't on the roster"] = "Исключить игроков, которых нет в списке";
L["Something went wrong while moving %s"] = "Что-то пошло не так при перемещении %s";
L["Finished applying raid roster"] = "Завершено применение рейдового списка";
L["Sorting groups"] = "Сортировать группы";
L["Apply Groups"] = "Применить группы";
L["Sort groups based on roster"] = "Сортировка групп по списку";
L["Sorting is still in progress, wait a bit!"] = "Сортировка ещё продолжается, подождите немного!";
L["All tanks are assigned"] = "Все танки назначены";
L["Assign Tanks"] = "Назначьте танков";
L["Wowhead Comp Tool"] = "Инструмент Wowhead Comp";
L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"] = "Вы можете посетить инструмент wowhead comp, используя URL-адрес ниже. После создания вашей композиции вы можете вставить ее сюда или в большое поле редактирования окна группы Гаргул.";
L["Remove bid"] = "Удалить ставку";
L["Reset Settings"] = "Сбросить настр.";
L["Are you sure you want to reset all of Gargul's settings? This can't be undone!"] = "Вы уверены, что хотите сбросить все настройки Гаргула? Этого нельзя отменить!";
L["Reset Gargul UI"] = "Сбросить UI";
L["Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!"] = "Вы уверены, что хотите сбросить все размеры, положения и масштаб окон Гаргула? Этого нельзя отменить!";
L["Restore"] = "ВОССТ";
L["Resume"] = "Резюме";
L[">"] = ">";
L["Roll"] = "roll";
L["Award %s to %s?"] = "Наградить %s %s?";
L["Close on award"] = "Закрыть при награде";
L["Close on start"] = "Закрыть на старте";
L["Hold shift to bypass the award confirmation"] = "Удерживайте клавишу Shift, чтобы обойти подтверждение награды.";
L["Hold shift to show the award confirmation"] = "Удерживайте клавишу Shift, чтобы показать подтверждение награды.";
L["Warning: another identical roll was found which can point to a tie"] = [[
Внимание: найден ещё один идентичный бросок, который может указывать на ничью.

]];
L["Invalid data provided for roll start!"] = "Для начала разролла предоставлены неверные данные!";
L["(BR: %s)"] = "(БР: %s)";
L["(item given: yes)"] = "(предмет отдан: да)";
L["(item given: no)"] = "(предмет отдан: нет)";
L["(OS)"] = "(ОС)";
L["NOTE"] = "ЗАМЕТКА";
L["Can't stop roll off, no roll off in progress"] = "Не могу остановить разролл, т.к. разролл не происходит.";
L["Pass"] = "Пасс";
L["rolls: %s"] = "роллов: %s";
L["Open master looter window"] = "Открыть окно мастер-лутера";
L["Roll accepted!"] = "Ролл принят!";
L["A roll is currently in progress"] = "В настоящее время идет разролл";
L["Prio [%s]"] = "Прио [%s]";
L["SR [%sx]"] = "СР [%sx]";
L["Wish [%s]"] = "Желаю [%s]";
L["You need to select a player first"] = "Сначала вам нужно выбрать игрока";
L["TIMER (s)"] = "ТАЙМЕР (с)";
L["You can't use this item!"] = "Вы не можете использовать этот предмет!";
L["The winner's name is not unique, select the player you'd like to award %s to"] = "Имя победителя не уникально. Выберите игрока, которому вы хотите отдать %s.";
L["s"] = "с";
L["Select / Disable all"] = "Выбрать/снять выбор";
L["Session"] = "Сессия";
L["Settings"] = "Настройки";
L["Announce incoming bids"] = "Объявлять о поступивших ставках";
L["Announce pot after awarding item"] = "Объявлять банк после вручения предмета";
L["Announce auction start"] = "Объявлять о начале аукциона";
L["Announce countdown in raid warning"] = "Объявлять обратный отсчет в raid warning";
L["Announce incoming bids in raid warning"] = "Объявляйте о входящих ставках в raid warning";
L["Reset Gargul UI"] = "Сбросить UI";
L["Whisper bidder if bid is too low"] = "Сообщать участнику торгов, если ставка слишком низкая";
L["s"] = "с";
L["Skip"] = "Пропуск";
L["Soft-Reserves"] = "Софт-резервы";
L["SR"] = "СР";
L["Are you sure you want to broadcast your softres data to everyone in your party/raid?"] = "Вы уверены, что хотите передать данные SoftRes всем членам вашей группы/рейда?";
L["Couldn't process SoftRes data received from %s"] = "Не удалось обработать данные SoftRes, полученные от %s.";
L["Are you sure you want to clear all existing soft-reserve data?"] = "Вы уверены, что хотите удалить все существующие данные SoftRes?";
L["Everyone filled out their soft-reserves"] = "Все заполнили свои софт-резы";
L["\nHard-reserve information is not available because the soft-reserves\nprovided were not generated using the 'Gargul Export' button on softres.it"] = [[
Информация о хард-резах недоступна, поскольку предоставленные данные
софт-реза не были созданы с помощью кнопки «Экспортировать Gargul» на сайте softres.it.]];
L["Imported on |c00A79EFF%s at |c00A79EFF%s"] = "Импортировано |c00A79EFF%s в |c00A79EFF%s.";
L["Auto name fix: the SR of '%s' is now linked to '%s'"] = "Автоматическое исправление имени: SR «%s» теперь связан с «%s».";
L["In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below."] = "Для начала вам сначала нужно создать рейд на softres.it. После этого нажмите «Экспорт аддонов», выберите «Гаргул», скопируйте данные и вставьте их в форму ниже.";
L["Invalid soft-reserve data provided"] = "Предоставлены неверные данные софт-резерва.";
L["Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here"] = "Предоставлены неверные данные. Обязательно нажмите кнопку «Экспортировать Gargul» на сайте softres.it и вставьте сюда все содержимое.";
L["The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?"] = "Предоставленные значения PlusOne конфликтуют с уже существующими. Хотите заменить старые значения PlusOne?";
L["The following players did not reserve anything:"] = "Следующие игроки ничего не зарезервировали:";
L["Soft-reserves imported successfully"] = "Софт-резы успешно импортированы";
L["Import successful!"] = "Импорт выполнен успешно!";
L["SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!"] = "Данные SoftRes Weakaura и CSV устарели, вместо этого используйте экспорт Gargul!";
L["Failed to connect to LootReserve, contact support (include message below)"] = "Не удалось подключиться к LootReserve. Обратитесь в службу поддержки (сообщите сообщение ниже).";
L["%s (%sx)"] = "%s (%sx)";
L["No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!"] = "URL-адрес softres.it недоступен, убедитесь, что вы экспортировали его с помощью кнопки «Экспорт Gargul» на softres.it!";
L["Click here to see hard-reserve info"] = "Нажмите здесь, чтобы просмотреть информацию о хард-резерве";
L["No items are hard-reserved"] = "Нет хард-резерв предметов";
L["No hard-reserve info available"] = "Информация о хард-резерве отсутствует.";
L["Post missing SRs"] = "Опубликовать недостающие запросы на обслуживание";
L["Post SR URL"] = "URL-адрес публикации запроса на отправку заявок";
L["This player did not reserve anything!"] = "Этот игрок ничего не резервировал!";
L["%s (%sx)"] = "%s (%sx)";
L["Attempting to process incoming SoftRes data from %s"] = "Попытка обработать входящие данные SoftRes от %s";
L["This item is hard-reserved"] = "Этот предмет - хард-резерв";
L["For: %s"] = "Для: %s";
L["|c00CC2743 Note: %s"] = "|c00CC2743 Заметка: %s";
L["Reserved by"] = "Зарезервировано";
L["!sr|!softres|!softreserve"] = "!sr|!softres|!softreserve";
L["Something went wrong!"] = "Что-то пошло не так!";
L["Start"] = "Go";
L["Stop"] = "Stop";
L["\\t is replaced by a tab"] = "\\t  is replaced by a tab";
L["TMB"] = "TMB";
L["Time"] = "Время";
L["Title"] = "Заголовок";
L["TMB, DFT or PRIO3"] = "TMB, DFT или PRIO3";
L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"] = "Вы уверены, что хотите передать данные TMB всем членам вашей группы/рейда? Примечание: КАЖДЫЙ может видеть ваши данные TMB независимо от своих разрешений на веб-сайте TMB!";
L["Attempting to process incoming TMB data from %s"] = "Попытка обработать входящие данные TMB от %s";
L["Are you sure you want to clear all plus one data?"] = "Вы уверены, что хотите удалить все данные плюс один?";
L["Clear Raider Data"] = "Очистить данные рейдера";
L["Clear TMB data for all raiders?"] = "Очистить данные TMB для всех рейдеров?";
L["Auto-sharing enabled: %s"] = "Автоматический обмен включен: %s";
L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "При запуске classicpr.io нажмите кнопку «Экспорт Gargul» и скопируйте содержимое. После этого вставьте содержимое как есть в поле ниже и нажмите «Импортировать». Вот и все!";
L["Imported on ${date} at ${time}"] = "Импортировано ${date} в ${time}.";
L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Экспортируйте данные DFT в соответствии с инструкциями листа. После этого вставьте содержимое как есть в поле ниже и нажмите «Импортировать». Вот и все!";
L["Invalid CSV provided, the format is: 6948,player1,player2"] = "Предоставлен неверный CSV-файл, формат: 6948,player1,player2.";
L["Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!"] = "Предоставлены неверные данные DFT. Экспортируйте данные DFT в соответствии с инструкциями листа и вставьте сюда содержимое как есть!";
L["Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!"] = "Предоставлены неверные данные TMB. Обязательно нажмите кнопку «Загрузить» в разделе «Гаргул» и вставьте сюда содержимое как есть!";
L["Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!"] = "Предоставлены неверные данные TMB или DFT. Обязательно вставьте сюда содержимое экспорта как есть!";
L["Priority notes available: %s"] = "Доступны приоритетные примечания: %s";
L["Number of items imported: %s"] = "Количество импортированных предметов: %s";
L["The following players have no %s entries:"] = "У следующих игроков нет записей %s:"; -- %s can be TMB/DFT/CPR
L["How to use Gargul with ${source}"] = "Как использовать Гаргул с ${source}";
L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"] = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L["Paste your TMB export contents as-is in the box below and click 'Import'"] = "Вставьте содержимое экспорта TMB как есть в поле ниже и нажмите «Импортировать».";
L["There's no one in your group to broadcast to"] = "В вашей группе нет никого, кому можно было бы транслировать";
L["TMB data synced"] = "Данные TMB синхронизированы";
L["|c00FFFFFF    Note: |c00FFF569%s"] = "|c00FFFFFF Заметка: |c00FFF569%s";
L["(OS)"] = "(ОС)";
L["%s Prio List"] = "%s список приоритетов"; -- %s can be TMB/DFT/CPR
L["|c00FFFFFF    Tier: %s"] = "|c00FFFFFF Уровень: %s";
L["TMB Wish List"] = "Виш-лист TMB";
L["Show/Hide Dates"] = "Показать/скрыть даты";
L["Show/Hide Queue"] = "Показать/скрыть очередь";
L["%s to award loot!"] = "%s для награждения добычей!";
L["%s to roll out loot!"] = "%s выдает добычу!";
L["Hide all awarded items"] = "Скрыть все награжденные предметы";
L["Hide disenchanted items"] = "Скрыть распылённые предметы";
L["Hide items awarded to self"] = "Скрыть предметы, врученные самому себе";
L["Announce Trade"] = "Объявить об обмене";
L["Announce trade details to group or in /say when not in a group"] = "Объявляйте детали обмена группе или в /say, когда вы не в группе.";
L["Tutorial"] = "Руководство";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.\nWant to directly sell an item without bidding? Use |c00A79EFF%s\n\nYou can open the %s window directly by typing |c00A79EFF/gl auction\n\nGargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the \"Exclude from GDKP\" checkbox when trading!\n\n|c00FFF569Did you know?\nAwarded items will automatically be added to the trade window\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s предметы в сумках, окнах добычи или даже по ссылкам в чате, чтобы добавить их в очередь на аукцион.
Хотите напрямую продать товар без торгов? Используйте |c00A79EFF%s

Вы можете открыть окно %s напрямую, набрав |c00A79EFF/gl аукцион.

Гаргул отслеживает |c00FF0000ВСЕ переданное золото. Не хотите, чтобы сделка была частью сессии GDKP? При торговле ставьте галочку «Исключить из GDKP»!

|c00FFF569Знаете ли вы?
Наградные предметы будут автоматически добавлены в окно торговли.
Гаргул также может заняться авто-лутом. Проверьте это с помощью |c00A79EFF/gl pm
]];
L["\nThis window shows all the items that have been awarded on any given date (select one or more dates on the left).\n\nItems can contain the following tags:\n\n|c00A79EFFOS: Awarded for offspec\n|c00A79EFFSR: This item was soft-reserved\n|c00A79EFFWL: This item was wishlisted (Thatsmybis)\n|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)\n"] = [[
В этом окне показаны все предметы, которые были выданы в конкретную дату (выберите одну или несколько дат слева).

Элементы могут содержать следующие теги:

|c00A79EFFOS: присуждается за офф-спек.
|c00A79EFFSR: Этот предмет был зарезервирован
|c00A79EFFWL: Этот предмет был в виш-листе (Thatsmybis)
|c00A79EFFPL: Этот элемент был добавлен в список приоритетных (Thatsmybis, DFT, prio3)
]];
L["\nThe items you see here are in the master looter's GDKP queue\nYou can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)\n\nYou can resize the window, move it around, or minimize it. Try it out!\n\nFor loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!\n"] = [[
Предметы, которые вы видите здесь, находятся в GDKP очереди мастер-лутера.
Вы можете удалить их, сделать ставку на них и скрыть неиспользуемые элементы (включите «Скрывать неиспользуемые элементы» в настройках в левом верхнем углу)

Вы можете изменить размер окна, переместить его или свернуть. Попробуйте!

Для мастер-лутеров: удаление предметов здесь удалит их только из вашей личной очереди, а не из реальной очереди GDKP!
]];
L["Need more help?"] = "Нужна дополнительная помощь?";
L["Type"] = "Тип"; -- As in type of roll or type of item
L["unknown"] = "неизвестный";
L["Unknown comm action '%s', make sure to update Gargul!"] = "Неизвестное комм-действие «%s», обязательно обновите Гаргул!";
L["Unlock"] = "Разблокировать";
L["Update Gargul!"] = "Обновите Гаргул!";
L["v"] = "v";
L["Report"] = "Отчет";
L["Report outdated results in group chat"] = "Сообщите об устаревших результатах в групповом чате";
L["Gargul status"] = "Статус Гаргула";
L["Checking version ..."] = "Проверяю версию...";
L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"] = [[
|c0092FF00v%s: у игрока последняя версия
|c00F7922Ev%s: игроку необходимо обновить свои аддоны
|c00BE3333%s: у игрока нет Гаргула или используется неподдерживаемая версия.
|c00808080%s: игрок не в сети или игнорирует нас!
|c0000FFFF%s: игрок в нашем игнор-листе!

]];
L["PLAYER IGNORED!"] = "ИГРОК ИГНОРИРУЕТСЯ!";
L["Offline"] = "Не в сети";
L["No response"] = "Нет ответа";
L["No response:"] = "Нет ответа:";
L["Offline:"] = "Не в сети:";
L["Outdated:"] = "Устарело:";
L["Up-to-date:"] = "Последняя версия:";
L["Gargul is out of date and won't work until you update!"] = "Гаргул устарел и не будет работать, пока вы не обновите его!";
L["Invalid version string provided in Version:addRelease"] = "В Version:addRelease указана неверная строка версии.";
L["Update Gargul!"] = "Обновите Гаргул!";
L["|c00%sGargul is now updated to |c00%sv%s"] = "|c00%sGargul теперь обновлён до |c00%sv%s";
L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"] = "|c00A79EFFv%s доступен на CurseForge/Wago. Вы можете обновиться, не закрывая игру, просто сделайте /reload!";
L["Wait %s more seconds before you retry"] = "Подождите ещё %s секунд, прежде чем повторить попытку.";
L["Window"] = "Окно";
L["Gargul v%s"] = "Гаргул v%s";
L["Window Scale"] = "Масштаб окна";
L["WL"] = "ВЛ";
L["Yes"] = "Да";
L["You disabled GDKP queues"] = "Вы отключили очереди GDKP";
L["0"] = "0";
L["Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf"] = "Невозможно сжать данные zlib. Свяжитесь со службой поддержки через https://discord.gg/D3mDhYPVzf.";
L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Невозможно распаковать данные с помощью zlib. Обязательно скопируйте/вставьте его как есть, без добавления каких-либо дополнительных символов или пробелов!";