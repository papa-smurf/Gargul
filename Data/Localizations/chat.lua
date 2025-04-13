local L = Gargul_L;

--[[ CHAT MESSAGES ]]
L.CHAT = {
    --[[ deDE ]]
    deDE = {
        ["Pass"] = "passt",
        ["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"] = "Ich benutze Gargul, um Beute zu verteilen. Es erleichtert das Würfeln, also probier es unbedingt aus!",

        --[[ VERSION CHECK ]]
        ["Gargul missing for:"] = "Gargul fehlt bei:",
        ["Gargul outdated for:"] = "Gargul ist veraltet bei:",
        ["The following players were offline:"] = "Die folgenden Spieler waren offline:",

        --[[ ITEM AWARDED ]]
        ["%s was awarded to %s. Congrats!"] = "%s wurde an %s verliehen. Glückwunsch!",
        ["%s was awarded to %s for %s points. Congrats!"] = "%s wurde %s für %s Punkte verliehen. Glückwunsch!",
        ["%s was awarded to %s for %s. Congrats!"] = "%s wurde %s für %s verliehen. Glückwunsch!",

        --[[ TRADE DETAILS ]]
        ["I gave %s to %s"] = "Ich habe %s an %s gegeben",
        ["I deleted a gold trade in which I gave %s to %s"] = "Ich habe einen Goldhandel gelöscht, bei dem ich %s an %s gegeben habe",
        ["I restored a gold trade in which I gave %s to %s"] = "Ich habe einen Goldhandel wiederhergestellt, bei dem ich %s an %s gegeben habe",
        ["I received %s from %s"] = "Ich habe %s von %s erhalten",
        ["I deleted a gold trade in which I received %s from %s"] = "Ich habe einen Goldhandel gelöscht, bei dem ich %s von %s erhalten habe",
        ["I restored a gold trade in which I received %s from %s"] = "Ich habe einen Goldhandel wiederhergestellt, bei dem ich %s von %s erhalten habe",

        --[[ TRADE TIME ]]
        ["I have the following items left to trade"] = "Ich habe noch die folgenden Gegenstände zum Handeln übrig",

        --[[ BOOSTED ROLLS ]]
        ["Your %s roll is /rnd %d-%d%s"] = "Dein %s-Wurf ist /rnd %d-%d%s",
        ["Player %s's %s roll is /rnd %d-%d%s"] = "Der %s-Wurf von Spieler %s ist /rnd %d-%d%s",
        ["(default)"] = "(Standard)",

        --[[ PLUS ONES ]]
        ["+"] = "+",
        ["Your +1 total is %d"] = "Dein +1-Gesamtwert beträgt %d",
        ["Player %s's +1 total is %d"] = "Der +1-Gesamtwert von Spieler %s beträgt %d",

        --[[ GDKP ]]
        ["I owe you %s. Enjoy!"] = "Ich schulde dir %s",
        ["You owe me %s. Thank you!"] = "Du schuldest mir %s. Danke!",
        ["Pot was updated, it now holds %s"] = "Der Pott wurde aktualisiert, er enthält jetzt %s",
        ["Pot was updated after deleting an auction, it now holds %s"] = "Der Pott wurde nach dem Löschen einer Auktion aktualisiert und enthält jetzt %s",
        ["Pot was updated after restoring an auction, it now holds %s"] = "Der Pott wurde nach der Wiederherstellung einer Auktion aktualisiert und enthält jetzt %s",
        ["I removed %s awarded to %s for %s"] = "Ich habe %s, das %s für %s verliehen wurde, entfernt",
        ["I restored %s awarded to %s for %s"] = "Ich habe %s wiederhergestellt, das %s für %s verliehen wurde",
        ["I removed %sg from the pot"] = "Ich habe %sg aus dem Pott entfernt",
        ["I added %sg back to the pot"] = "Ich habe %sg wieder in den Pott gegeben",
        ["The pot now holds %s"] = "Der Pott enthält jetzt %s",
        ["%s is the highest bidder (%s)"] = "%s ist der Höchstbietende (%s)",
        ["Final Call on %s: %s seconds left to bid!"] = "Letzter Aufruf zu %s: Noch %s Sekunden zum Bieten!",
        ["Bid denied, the minimum bid is %s"] = "Gebot abgelehnt, das Mindestgebot beträgt %s",
        ["Bid on %s. Minimum is %s, increment is %s. Use raid chat!"] = "Biete auf %s. Minimum ist %s, Inkrement ist %s. Benutze den Raid-Chat!",
        ["Stop your bids!"] = "Stopp deine Gebote!",
        ["%s seconds to bid"] = "%s Sekunden zum Bieten",
        ["Total Pot: %s"] = "Gesamtpott: %s",
        ["Base cut: %s"] = "Basisanteil: %s",

        --[[ MULTIAUCTION ]]
        ["I started a bidding session. Can't see it? Make sure to download/update Gargul!"] = "Ich habe eine Mehrfachauktion gestartet. Du kannst es nicht sehen? Stell sicher, dass du Gargul heruntergeladen/aktualisiert hast!",
        ["I resumed a previous bidding session, double check your bids!"] = "Ich habe eine vorherige Auktion fortgesetzt. Überprüfe deine Gebote noch einmal!",
        ["I added %s item(s) to the auction for a total of %s"] = "Ich habe %s Gegenstände zur Auktion hinzugefügt, insgesamt %s",
        ["Multi-auction finished. The pot now holds %s"] = "Mehrfachauktion beendet. Der Pott enthält jetzt %s",

        --[[ SOFTRES ]]
        ["You reserved %s"] = "Du hast %s reserviert", -- %s is a summary of all items or the ["%s (%sx)"] format (if more than 1 reserve)
        ["%s (%sx)"] = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        ["It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master"] = "Es scheint, als hättest du noch nichts reserviert. Sieh dir die Soft-Reserve Website an oder frage deinen Plündermeister",
        ["%s (This item is hard-reserved!)"] = "%s (Dieser Gegenstand ist hard-reserved!)",
        ["Reserved by: %s"] = "Reserviert von: %s",
        ["Missing soft-reserves from: %s"] = "Fehlende Soft-Reserves von: %s",
        ["I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!"] = "Ich habe gerade die Soft-Reserves in Gargul importiert. Flüstere !sr, um deine reservierten Gegenstände noch einmal zu überprüfen!",

        --[[ THATSMYBIS ]]
        ["TMB Wishlist: %s"] = "TMB-Wunschliste: %s",
        ["%s Priority: %s"] = "%s Priorität: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        ["%s was set as disenchanter"] = "%s wurde als Entzauberer ausgewählt",
        ["%s will be disenchanted by %s"] = "%s wird von %s entzaubert",

        --[[ ROLLING ]]
        ["You have %s seconds to roll on %s"] = "Du hast %s Sekunden um auf %s zu würfeln",
        ["Stop your rolls!"] = "Stopp deine Würfe!",
        ["%s seconds to roll"] = "Noch %s Sekunden übrig",
        ["This item was reserved by: %s"] = "Dieser Gegenstand wurde reserviert von: %s",
        ["These players have the highest %s prio: %s"] = "Die folgenden Spieler haben die höchste %s-Prio: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        ["I tried to trade you, but was unsuccessful - trade me for ${item} asap!"] = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        ["%s to %s"] = "%s an %s",
        ["to %s"] = "an %s",
        ["I gave %s"] = "Ich habe %s gegeben",
        ["I gave %s to %s"] = "Ich habe %s an %s gegeben",
        ["I gave %sx%s"] = "Ich habe %sx%s gegeben", -- I gave [item]x3
        ["I enchanted %s with %s for %s"] = "Ich habe %s mit %s für %s verzaubert",
        ["I enchanted %s with %s for %s and gave %s"] = "Ich habe %s mit %s für %s verzaubert und %s gegeben",
        ["I enchanted %s with %s for %s and received %s"] = "Ich habe %s mit %s für %s verzaubert und %s erhalten",
        ["to %s and enchanted their %s with %s"] = "an %s und verzauberte %s mit %s",
        ["%s to %s and enchanted their %s with %s"] = "%s an %s und %s mit %s verzaubert",
        ["%s enchanted my %s with %s"] = "%s hat meinen %s mit %s verzaubert",
        ["%s enchanted my %s with %s and gave me %s"] = "%s hat mein %s mit %s verzaubert und mir %s gegeben",
        ["%s enchanted my %s with %s for %s"] = "%s hat meinen %s mit %s für %s verzaubert",
        ["%s enchanted my %s with %s and I enchanted their %s with %s"] = "%s hat meine %s mit %s verzaubert und ich habe %s mit %s verzaubert",
        ["%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s"] = "%s hat meine %s mit %s verzaubert und ich habe ihre %s mit %s verzaubert. Ich habe ihm auch %s gegeben",
        ["%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s"] = "%s hat mein %s mit %s verzaubert und mir %s gegeben. Ich habe %s mit %s verzaubert",
        ["%s from %s"] = "%s von %s",
        ["from %s"] = "von %s",
        ["I received %s"] = "Ich habe %s erhalten",
        ["I received %s from %s"] = "Ich habe %s von %s erhalten",
        ["I received %sx%s"] = "Ich habe %sx%s erhalten", -- I gave [item]x3
        ["from %s and got my %s enchanted with %s"] = "von %s und habe meinen %s mit %s verzaubert",
        ["%s from %s and got my %s enchanted with %s"] = "%s von %s und habe meinen %s mit %s verzaubert",

        --[[ AWARD ]]
        ["Random winner for %s selected (%s)"] = "Zufälliger Gewinner für %s ausgewählt (%s)", -- First %s is item, second %s is player,
    },

    --[[ zhCN
        These translations where provided by
        - Skywardpixel
        - Takaqiao
    ]]
    zhCN = {
        ["Pass"] = "放弃",
        ["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"] = "我正在使用 Gargul 来分发战利品。它使分发变得更容易，所以一定要尝试一下！",

        --[[ VERSION CHECK ]]
        ["Gargul missing for:"] = "Gargul 未安装：",
        ["Gargul outdated for:"] = "Gargul 已过时：",
        ["The following players were offline:"] = "以下玩家离线：",

        --[[ ITEM AWARDED ]]
        ["%s was awarded to %s. Congrats!"] = "%s 被授予了 %s。恭喜！",
        ["%s was awarded to %s for %s points. Congrats!"] = "%s 被授予了 %s %s 积分。恭喜！",
        ["%s was awarded to %s for %s. Congrats!"] = "%s 因 %s 而被授予了 %s。恭喜！",

        --[[ TRADE DETAILS ]]
        ["I gave %s to %s"] = "我把 %s 给了 %s",
        ["I deleted a gold trade in which I gave %s to %s"] = "我删除了一笔金币交易，其中我向 %s 提供了 %s",
        ["I restored a gold trade in which I gave %s to %s"] = "我恢复了一笔金币交易，其中我将 %s 给予 %s",
        ["I received %s from %s"] = "我收到了来自 %s 的 %s",
        ["I deleted a gold trade in which I received %s from %s"] = "我删除了一笔金币交易，其中我从 %s 收到了 %s",
        ["I restored a gold trade in which I received %s from %s"] = "我恢复了一笔金币交易，其中我从 %s 收到了 %s",

        --[[ TRADE TIME ]]
        ["I have the following items left to trade"] = "我还有以下物品需要交易",

        --[[ BOOSTED ROLLS ]]
        ["Your %s roll is /rnd %d-%d%s"] = "你的 %s 点数是 /rnd %d-%d%s",
        ["Player %s's %s roll is /rnd %d-%d%s"] = "玩家 %s 的 %s 掷骰结果为 /rnd %d-%d%s",
        ["(default)"] = "（默认）",

        --[[ PLUS ONES ]]
        ["+"] = "+",
        ["Your +1 total is %d"] = "您的 +1 总数为 %d",
        ["Player %s's +1 total is %d"] = "玩家 %s 的 +1 总数为 %d",

        --[[ GDKP ]]
        ["I owe you %s. Enjoy!"] = "我欠你 %s。享受！",
        ["You owe me %s. Thank you!"] = "你欠我 %s。谢谢你！",
        ["Pot was updated, it now holds %s"] = "奖池已更新，现在共有 %s",
        ["Pot was updated after deleting an auction, it now holds %s"] = "删除拍卖后，奖池已更新，现在共有 %s",
        ["Pot was updated after restoring an auction, it now holds %s"] = "恢复拍卖后，奖池已更新，现在共有 %s",
        ["I removed %s awarded to %s for %s"] = "我删除了为 %s 授予 %s 的 %s",
        ["I restored %s awarded to %s for %s"] = "我恢复了为 %s 授予 %s 的 %s",
        ["I removed %sg from the pot"] = "我从奖池中取出%sg",
        ["I added %sg back to the pot"] = "我将 %sg 添加回奖池中",
        ["The pot now holds %s"] = "奖池现在有 %s",
        ["%s is the highest bidder (%s)"] = "%s 是最高出价者 (%s)",
        ["Final Call on %s: %s seconds left to bid!"] = "%s 的最后通知：还剩 %s 秒出价！",
        ["Bid denied, the minimum bid is %s"] = "出价被拒绝，最低出价为 %s",
        ["Bid on %s. Minimum is %s, increment is %s. Use raid chat!"] = "对 %s 出价。底价为 %s，每次加价 %s 起。使用团队聊天！",
        ["Stop your bids!"] = "停止出价！",
        ["%s seconds to bid"] = "在 %s 秒内出价",
        ["Total Pot: %s"] = "总奖池：%s",
        ["Base cut: %s"] = "基础分成：%s",

        --[[ MULTIAUCTION ]]
        ["I started a bidding session. Can't see it? Make sure to download/update Gargul!"] = "多重拍卖已经开始。看不到吗？请务必下载/更新 Gargul！",
        ["I resumed a previous bidding session, double check your bids!"] = "我恢复了之前的出价，请仔细检查您的出价！",
        ["I added %s item(s) to the auction for a total of %s"] = "我将 %s 件物品添加到拍卖中，总共 %s 件",
        ["Multi-auction finished. The pot now holds %s"] = "多重拍卖已结束。奖池现在有 %s",

        --[[ SOFTRES ]]
        ["You reserved %s"] = "您已预订 %s", -- %s is a summary of all items or the ["%s (%sx)"] format (if more than 1 reserve)
        ["%s (%sx)"] = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        ["It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master"] = "您似乎还没有软保留任何东西，请检查软保留表或询问您的战利品分配者",
        ["%s (This item is hard-reserved!)"] = "%s（该物品是硬保留的！）",
        ["Reserved by: %s"] = "保留者：%s",
        ["Missing soft-reserves from: %s"] = "缺少软保留：%s",
        ["I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!"] = "我刚刚将软保留导入 Gargul。私聊输入 !sr 仔细检查您的保留！",

        --[[ THATSMYBIS ]]
        ["TMB Wishlist: %s"] = "TMB 愿望清单：%s",
        ["%s Priority: %s"] = "%s 优先级：%s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        ["%s was set as disenchanter"] = "%s 被设置为分解者",
        ["%s will be disenchanted by %s"] = "%s会被%s分解",

        --[[ ROLLING ]]
        ["You have %s seconds to roll on %s"] = "您还有 %s 秒时间 Roll %s",
        ["Stop your rolls!"] = "停止你的 Roll 点！",
        ["%s seconds to roll"] = "还剩 %s 秒结束 Roll 点",
        ["This item was reserved by: %s"] = "该项目已被保留：%s",
        ["These players have the highest %s prio: %s"] = "以下玩家的 %s 优先级最高：%s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        ["I tried to trade you, but was unsuccessful - trade me for ${item} asap!"] = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        ["%s to %s"] = "%s 给 %s",
        ["to %s"] = "给 %s",
        ["I gave %s"] = "我给了 %s",
        ["I gave %s to %s"] = "我将 %s 给了 %s",
        ["I gave %sx%s"] = "我给了 %sx%s", -- I gave [item]x3
        ["I enchanted %s with %s for %s"] = "我给 %s 的 %s 附魔了",
        ["I enchanted %s with %s for %s and gave %s"] = "我为 %s 用 %s 对 %s 附魔，并给了 %s",
        ["I enchanted %s with %s for %s and received %s"] = "我为 %s 用 %s 对 %s 附魔，并收到了 %s",
        ["to %s and enchanted their %s with %s"] = "给 %s 附魔了 %s，用的是他的 %s",
        ["%s to %s and enchanted their %s with %s"] = "%s 给 %s 附魔了 %s，用的是他的 %s",
        ["%s enchanted my %s with %s"] = "%s 附魔了我的 %s （用了 %s）",
        ["%s enchanted my %s with %s and gave me %s"] = "%s 附魔了 %s 用的是 %s 并给了我 %s",
        ["%s enchanted my %s with %s for %s"] = "%s 附魔了 %s 用的是 %s 并给了 %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s"] = "%s 用 %s 附魔了我的 %s ，我用 %s 附魔了他的 %s ",
        ["%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s"] = "%s 用 %s 附魔了我的 %s，而且我附魔了他的 %s（用了 %s），我还给了他 %s",
        ["%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s"] = "%s 附魔了我的 %s（用了 %s）并且给了我 %s， 我附魔了他的 %s （用了 %s）",
        ["%s from %s"] = "%s 来自 %s",
        ["from %s"] = "来自 %s",
        ["I received %s"] = "我收到 %s",
        ["I received %s from %s"] = "我收到了来自 %s 的 %s",
        ["I received %sx%s"] = "我收到了 %sx%s", -- I gave [item]x3
        ["from %s and got my %s enchanted with %s"] = "来自 %s 并让我的 %s 附魔了 %s",
        ["%s from %s and got my %s enchanted with %s"] = " %s 来自 %s 并让我的 %s 附魔了 %s",

        --[[ AWARD ]]
        ["Random winner for %s selected (%s)"] = "已选择 %s 的随机获胜者 (%s)", -- First %s is item, second %s is player,
    },

    --[[ esES ]]
    esES = {
        ["Pass"] = "Aprobar",
        ["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"] = "Estoy usando Gargul para distribuir el botín. Hace que rodar sea más fácil, así que ¡asegúrate de probarlo!",

        --[[ VERSION CHECK ]]
        ["Gargul missing for:"] = "Gárgul falta por:",
        ["Gargul outdated for:"] = "Gargul desactualizado para:",
        ["The following players were offline:"] = "Los siguientes jugadores estaban desconectados:",

        --[[ ITEM AWARDED ]]
        ["%s was awarded to %s. Congrats!"] = "%s fue otorgado a %s. ¡Felicitaciones!",
        ["%s was awarded to %s for %s points. Congrats!"] = "%s fue otorgado a %s por %s puntos. ¡Felicitaciones!",
        ["%s was awarded to %s for %s. Congrats!"] = "%s fue otorgado a %s por %s. ¡Felicitaciones!",

        --[[ TRADE DETAILS ]]
        ["I gave %s to %s"] = "Le di %s a %s",
        ["I deleted a gold trade in which I gave %s to %s"] = "Eliminé una operación de oro en la que le di %s a %s",
        ["I restored a gold trade in which I gave %s to %s"] = "Restablecí un intercambio de oro en el que le di %s a %s",
        ["I received %s from %s"] = "Recibí %s de %s",
        ["I deleted a gold trade in which I received %s from %s"] = "Eliminé una operación de oro en la que recibí %s de %s",
        ["I restored a gold trade in which I received %s from %s"] = "Restablecí un comercio de oro en el que recibí %s de %s",

        --[[ TRADE TIME ]]
        ["I have the following items left to trade"] = "Me quedan los siguientes artículos para intercambiar",

        --[[ BOOSTED ROLLS ]]
        ["Your %s roll is /rnd %d-%d%s"] = "Tu tirada de %s es /rnd %d-%d%s",
        ["Player %s's %s roll is /rnd %d-%d%s"] = "La tirada %s del jugador %s es /rnd %d-%d%s",
        ["(default)"] = "(por defecto)",

        --[[ PLUS ONES ]]
        ["+"] = "+",
        ["Your +1 total is %d"] = "Tu +1 total es %d",
        ["Player %s's +1 total is %d"] = "El total +1 del jugador %s es %d",

        --[[ GDKP ]]
        ["I owe you %s. Enjoy!"] = "Te debo %s. ¡Disfrutar!",
        ["You owe me %s. Thank you!"] = "Me debes %s. ¡Gracias!",
        ["Pot was updated, it now holds %s"] = "El bote fue actualizado, ahora contiene %s",
        ["Pot was updated after deleting an auction, it now holds %s"] = "El bote se actualizó después de eliminar una subasta, ahora tiene %s",
        ["Pot was updated after restoring an auction, it now holds %s"] = "El bote se actualizó después de restaurar una subasta, ahora tiene %s",
        ["I removed %s awarded to %s for %s"] = "Eliminé %s otorgados a %s por %s",
        ["I restored %s awarded to %s for %s"] = "Restauré %s otorgados a %s por %s",
        ["I removed %sg from the pot"] = "Saqué %sg del bote",
        ["I added %sg back to the pot"] = "Agregué %sg nuevamente al bote",
        ["The pot now holds %s"] = "El bote ahora tiene %s",
        ["%s is the highest bidder (%s)"] = "%s es el mejor postor (%s)",
        ["Final Call on %s: %s seconds left to bid!"] = "Llamada final en %s: ¡Quedan %s segundos para ofertar!",
        ["Bid denied, the minimum bid is %s"] = "Oferta denegada, la oferta mínima es %s",
        ["Bid on %s. Minimum is %s, increment is %s. Use raid chat!"] = "Oferta por %s. El mínimo es %s, el incremento es %s. ¡Usa el chat de incursión!",
        ["Stop your bids!"] = "¡Detén tus ofertas!",
        ["%s seconds to bid"] = "%s segundos para pujar",
        ["Total Pot: %s"] = "Bote total: %s",
        ["Base cut: %s"] = "Corte base: %s",

        --[[ MULTIAUCTION ]]
        ["I started a bidding session. Can't see it? Make sure to download/update Gargul!"] = "Comencé una sesión de licitación. ¿No puedes verlo? ¡Asegúrate de descargar/actualizar Gargul!",
        ["I resumed a previous bidding session, double check your bids!"] = "Reanudé una sesión de ofertas anterior, ¡verifique sus ofertas!",
        ["I added %s item(s) to the auction for a total of %s"] = "Agregué %s artículos a la subasta por un total de %s",
        ["Multi-auction finished. The pot now holds %s"] = "Subasta múltiple finalizada. El bote ahora tiene %s",

        --[[ SOFTRES ]]
        ["You reserved %s"] = "Reservaste %s", -- %s is a summary of all items or the ["%s (%sx)"] format (if more than 1 reserve)
        ["%s (%sx)"] = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        ["It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master"] = "Parece que aún no has reservado nada, consulta la hoja de resolución suave o pregúntale a tu maestro del botín.",
        ["%s (This item is hard-reserved!)"] = "%s (¡Este artículo está reservado!)",
        ["Reserved by: %s"] = "Reservado por: %s",
        ["Missing soft-reserves from: %s"] = "Faltan reservas flexibles de: %s",
        ["I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!"] = "Acabo de importar reservas blandas a Gargul. ¡Susurra !sr para volver a verificar tus reservas!",

        --[[ THATSMYBIS ]]
        ["TMB Wishlist: %s"] = "Lista de deseos de TMB: %s",
        ["%s Priority: %s"] = "%s Prioridad: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        ["%s was set as disenchanter"] = "%s fue establecido como desencantador",
        ["%s will be disenchanted by %s"] = "%s quedará desencantado por %s",

        --[[ ROLLING ]]
        ["You have %s seconds to roll on %s"] = "Tienes %s segundos para seguir %s",
        ["Stop your rolls!"] = "¡Detén tus rollos!",
        ["%s seconds to roll"] = "%s segundos para rodar",
        ["This item was reserved by: %s"] = "Este artículo fue reservado por: %s",
        ["These players have the highest %s prio: %s"] = "Los siguientes jugadores tienen el %s prio más alto: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        ["I tried to trade you, but was unsuccessful - trade me for ${item} asap!"] = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        ["%s to %s"] = "%s a %s",
        ["to %s"] = "a %s",
        ["I gave %s"] = "Le di %s",
        ["I gave %s to %s"] = "Le di %s a %s",
        ["I gave %sx%s"] = "Le di %sx%s", -- I gave [item]x3
        ["I enchanted %s with %s for %s"] = "He encantado a %s con %s para %s",
        ["I enchanted %s with %s for %s and gave %s"] = "Encanté a %s con %s para %s y le di a %s",
        ["I enchanted %s with %s for %s and received %s"] = "Encanté a %s con %s para %s y recibí %s",
        ["to %s and enchanted their %s with %s"] = "a %s y encantó a sus %s con %s",
        ["%s to %s and enchanted their %s with %s"] = "%s a %s y encantaron a sus %s con %s",
        ["%s enchanted my %s with %s"] = "%s encantó a mi %s con %s",
        ["%s enchanted my %s with %s and gave me %s"] = "%s encantó a mi %s con %s y me regaló %s",
        ["%s enchanted my %s with %s for %s"] = "%s encantó a mi %s con %s para %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s"] = "%s encantó a mi %s con %s y yo encantaba a sus %s con %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s"] = "%s encantó a mi %s con %s y yo encantaba a sus %s con %s. Yo también le di %s",
        ["%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s"] = "%s encantó a mi %s con %s y me regaló %s. Encanté a sus %s con %s",
        ["%s from %s"] = "%s de %s",
        ["from %s"] = "de %s",
        ["I received %s"] = "Recibí %s",
        ["I received %s from %s"] = "Recibí %s de %s",
        ["I received %sx%s"] = "Recibí %sx%s", -- I gave [item]x3
        ["from %s and got my %s enchanted with %s"] = "de %s y tengo a mi %s encantado con %s",
        ["%s from %s and got my %s enchanted with %s"] = "%s de %s y tengo a mi %s encantado con %s",

        --[[ AWARD ]]
        ["Random winner for %s selected (%s)"] = "Ganador aleatorio para %s seleccionados (%s)", -- First %s is item, second %s is player,
    },

    --[[ frFR
        These translations where provided by
        - Bhahlou
    ]]
    frFR = {
        ["Pass"] = "Passer",
        ["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"] = "J'utilise Gargul pour distribuer le butin. Cela rend les lancers de dés plus faciles, donc essayez-le !",

        --[[ VERSION CHECK ]]
        ["Gargul missing for:"] = "Gargul manquant pour :",
        ["Gargul outdated for:"] = "Gargul obsolète pour :",
        ["The following players were offline:"] = "Les joueurs suivants étaient hors-ligne :",

        --[[ ITEM AWARDED ]]
        ["%s was awarded to %s. Congrats!"] = "%s a été attribué à %s. Bravo !",
        ["%s was awarded to %s for %s points. Congrats!"] = "%s a été attribué à %s pour %s points. Bravo !",
        ["%s was awarded to %s for %s. Congrats!"] = "%s a été attribué à %s pour %s. Bravo !",

        --[[ TRADE DETAILS ]]
        ["I gave %s to %s"] = "J'ai donné %s à %s",
        ["I deleted a gold trade in which I gave %s to %s"] = "J'ai supprimé un échange d'or dans lequel j'avais donné %s à %s",
        ["I restored a gold trade in which I gave %s to %s"] = "J'ai restauré un échange d'or dans lequel j'avais donné %s à %s",
        ["I received %s from %s"] = "J'ai reçu %s de %s",
        ["I deleted a gold trade in which I received %s from %s"] = "J'ai supprimé un échange d'or dans lequel j'avais reçu %s de %s",
        ["I restored a gold trade in which I received %s from %s"] = "J'ai restauré un échange d'or dans lequel j'avais reçu %s de %s",

        --[[ TRADE TIME ]]
        ["I have the following items left to trade"] = "Il me reste les objets suivants à échanger",

        --[[ BOOSTED ROLLS ]]
        ["Your %s roll is /rnd %d-%d%s"] = "Votre lancer %s est /rnd %d-%d%s",
        ["Player %s's %s roll is /rnd %d-%d%s"] = "Le lancer %s du joueur %s est /rnd %d-%d%s", --TODO:PLACEHOLDER POSITION CHANGE (2<->1)
        ["(default)"] = "(par défaut)",

        --[[ PLUS ONES ]]
        ["+"] = "+",
        ["Your +1 total is %d"] = "Votre total de +1 est %d",
        ["Player %s's +1 total is %d"] = "Le total de +1 du joueur %s est %d",

        --[[ GDKP ]]
        ["I owe you %s. Enjoy!"] = "Je vous dois %s. Profitez-en !",
        ["You owe me %s. Thank you!"] = "Vous me devez %s. Merci !",
        ["Pot was updated, it now holds %s"] = "Le pot a été mis à jour, il contient maintenant %s",
        ["Pot was updated after deleting an auction, it now holds %s"] = "Le pot a  été mis à jour après la suppression d'une enchère, il contient maintenant %s",
        ["Pot was updated after restoring an auction, it now holds %s"] = "Le pot a été mis à jour après la restauration d'une enchère, il contient maintenant %s",
        ["I removed %s awarded to %s for %s"] = "J'ai supprimé l'attribution de %s à %s pour %s",
        ["I restored %s awarded to %s for %s"] = "J'ai restauré l'attribution de %s à %s pour %s",
        ["I removed %sg from the pot"] = "J'ai supprimé %spo du pot",
        ["I added %sg back to the pot"] = "J'ai rajouté %spo au pot",
        ["The pot now holds %s"] = "Le pot contient maintenant %s",
        ["%s is the highest bidder (%s)"] = "%s est le plus gros enchérisseur (%s)",
        ["Final Call on %s: %s seconds left to bid!"] = "Dernier appel sur %s: %s secondes restantes pour enchérir !",
        ["Bid denied, the minimum bid is %s"] = "Enchère refusée, l'enchère minimum est de %s",
        ["Bid on %s. Minimum is %s, increment is %s. Use raid chat!"] = "Enchère sur %s. Le minimum est de %s, l'incrément est de %s. Utilisez la discussion de raid !",
        ["Stop your bids!"] = "Arrêtez vos enchères !",
        ["%s seconds to bid"] = "%s restantes pour enchérir",
        ["Total Pot: %s"] = "Pot total : %s",
        ["Base cut: %s"] = "Coupe de base : %s",

        --[[ MULTIAUCTION ]]
        ["I started a bidding session. Can't see it? Make sure to download/update Gargul!"] = "J'ai démarré une session d'enchères. Vous ne la voyez pas ? Assurez-vous de télécharger/mettre à jour Gargul !",
        ["I resumed a previous bidding session, double check your bids!"] = "J'ai redémarré une session d'enchères précédente, revérifiez vos enchères !",
        ["I added %s item(s) to the auction for a total of %s"] = "J'ai ajouté %s objet(s) à l'enchère pour un total de %s",
        ["Multi-auction finished. The pot now holds %s"] = "Multi-enchère terminée. Le pot contient maintenant %s",

        --[[ SOFTRES ]]
        ["You reserved %s"] = "Vous avez réservé %s", -- %s is a summary of all items or the ["%s (%sx)"] format (if more than 1 reserve)
        ["%s (%sx)"] = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        ["It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master"] = "Il semble que vous n'ayez pas encore fait de soft-reserve, vérifiez la feuille de soft-res ou demandez à votre maître du butin",
        ["%s (This item is hard-reserved!)"] = "%s (Cet objet est hard-reserved !)",
        ["Reserved by: %s"] = "Reservé par : %s",
        ["Missing soft-reserves from: %s"] = "Soft-reserves manquants pour : %s",
        ["I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!"] = "Je viens d'importer les soft-reserves dans Gargul. Chuchotez !sr pour revérifier vos réservations !",

        --[[ THATSMYBIS ]]
        ["TMB Wishlist: %s"] = "List de souhaits TMB : %s",
        ["%s Priority: %s"] = "Priorité %s : %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        ["%s was set as disenchanter"] = "%s a été défini comme désenchanteur",
        ["%s will be disenchanted by %s"] = "%s sera désenchanté par %s",

        --[[ ROLLING ]]
        ["You have %s seconds to roll on %s"] = "Vous avez %s secondes pour lancer les dés sur %s",
        ["Stop your rolls!"] = "Arrêtez vos lancers !",
        ["%s seconds to roll"] = "%s secondes pour lancer les dés",
        ["This item was reserved by: %s"] = "Cet objet a été reservé par : %s",
        ["These players have the highest %s prio: %s"] = "Les joueurs suivants ont la plus haute prio %s : %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        ["I tried to trade you, but was unsuccessful - trade me for ${item} asap!"] = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        ["%s to %s"] = "%s à %s",
        ["to %s"] = "à %s",
        ["I gave %s"] = "J'ai donné %s",
        ["I gave %s to %s"] = "J'ai donné %s à %s",
        ["I gave %sx%s"] = "J'ai donné %sx%s", -- I gave [item]x3
        ["I enchanted %s with %s for %s"] = "J'ai enchanté %s avec %s pour %s",
        ["I enchanted %s with %s for %s and gave %s"] = "J'ai enchanté %s avec %s pour %s et j'ai donné %s",
        ["I enchanted %s with %s for %s and received %s"] = "J'ai enchanté %s avec %s pour %s et j'ai reçu %s",
        ["to %s and enchanted their %s with %s"] = "à %s et enchanté son %s avec %s",
        ["%s to %s and enchanted their %s with %s"] = "%s à %s et enchanté son %s avec %s",
        ["%s enchanted my %s with %s"] = "%s a enchanté mon %s avec %s",
        ["%s enchanted my %s with %s and gave me %s"] = "%s a enchanté %s avec %s et m'a donné %s",
        ["%s enchanted my %s with %s for %s"] = "%s a enchanté %s avec %s pour %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s"] = "%s a enchanté %s avec %s et j'ai enchanté son %s avec %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s"] = "%s a enchanté %s avec %s et j'ai enchanté son %s avec %s. Je lui ai aussi donné %s",
        ["%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s"] = "%s a enchanté %s avec %s et m'a donné %s. J'ai enchanté son %s avec %s",
        ["%s from %s"] = "%s de %s",
        ["from %s"] = "de %s",
        ["I received %s"] = "J'ai reçu %s",
        ["I received %s from %s"] = "J'ai reçu %s de %s",
        ["I received %sx%s"] = "J'ai reçu %sx%s", -- I gave [item]x3
        ["from %s and got my %s enchanted with %s"] = "de %s et ai eu mon %s enchanté avec %s",
        ["%s from %s and got my %s enchanted with %s"] = "%s de %s et ai eu mon %s enchanté avec %s",

        --[[ AWARD ]]
        ["Random winner for %s selected (%s)"] = "Gagant aléatoire pour %s sélectionné (%s)", -- First %s is item, second %s is player,
    },

    --[[ itIT ]]
    itIT = {
        ["Pass"] = "Passaggio",
        ["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"] = "Sto usando Gargul per distribuire il bottino. Rende più facile arrotolare, quindi assicurati di provarlo!",

        --[[ VERSION CHECK ]]
        ["Gargul missing for:"] = "Gargul scomparso per:",
        ["Gargul outdated for:"] = "Gargul obsoleto per:",
        ["The following players were offline:"] = "I seguenti giocatori erano offline:",

        --[[ ITEM AWARDED ]]
        ["%s was awarded to %s. Congrats!"] = "%s è stato assegnato a %s. Congratulazioni!",
        ["%s was awarded to %s for %s points. Congrats!"] = "%s è stato assegnato a %s per %s punti. Congratulazioni!",
        ["%s was awarded to %s for %s. Congrats!"] = "%s è stato assegnato a %s per %s. Congratulazioni!",

        --[[ TRADE DETAILS ]]
        ["I gave %s to %s"] = "Ho dato %s a %s",
        ["I deleted a gold trade in which I gave %s to %s"] = "Ho cancellato uno scambio di oro in cui avevo dato %s a %s",
        ["I restored a gold trade in which I gave %s to %s"] = "Ho ripristinato uno scambio di oro in cui avevo dato %s a %s",
        ["I received %s from %s"] = "Ho ricevuto %s da %s",
        ["I deleted a gold trade in which I received %s from %s"] = "Ho eliminato uno scambio di oro in cui ho ricevuto %s da %s",
        ["I restored a gold trade in which I received %s from %s"] = "Ho ripristinato uno scambio di oro in cui ho ricevuto %s da %s",

        --[[ TRADE TIME ]]
        ["I have the following items left to trade"] = "Mi restano i seguenti oggetti da scambiare",

        --[[ BOOSTED ROLLS ]]
        ["Your %s roll is /rnd %d-%d%s"] = "Il tuo tiro di %s è /rnd %d-%d%s",
        ["Player %s's %s roll is /rnd %d-%d%s"] = "Il tiro %s del giocatore %s è /rnd %d-%d%s",
        ["(default)"] = "(predefinito)",

        --[[ PLUS ONES ]]
        ["+"] = "+",
        ["Your +1 total is %d"] = "Il tuo totale +1 è %d",
        ["Player %s's +1 total is %d"] = "Il totale +1 del giocatore %s è %d",

        --[[ GDKP ]]
        ["I owe you %s. Enjoy!"] = "Ti devo %s. Godere!",
        ["You owe me %s. Thank you!"] = "Mi devi %s. Grazie!",
        ["Pot was updated, it now holds %s"] = "Il piatto è stato aggiornato, ora contiene %s",
        ["Pot was updated after deleting an auction, it now holds %s"] = "Il piatto è stato aggiornato dopo aver eliminato un'asta, ora contiene %s",
        ["Pot was updated after restoring an auction, it now holds %s"] = "Il piatto è stato aggiornato dopo aver ripristinato un'asta, ora contiene %s",
        ["I removed %s awarded to %s for %s"] = "Ho rimosso %s assegnato a %s per %s",
        ["I restored %s awarded to %s for %s"] = "Ho ripristinato %s assegnato a %s per %s",
        ["I removed %sg from the pot"] = "Ho rimosso %sg dal piatto",
        ["I added %sg back to the pot"] = "Ho aggiunto %sg al piatto",
        ["The pot now holds %s"] = "Il piatto ora contiene %s",
        ["%s is the highest bidder (%s)"] = "%s è il miglior offerente (%s)",
        ["Final Call on %s: %s seconds left to bid!"] = "Chiamata finale su %s: %s secondi rimasti per fare un'offerta!",
        ["Bid denied, the minimum bid is %s"] = "Offerta negata, l'offerta minima è %s",
        ["Bid on %s. Minimum is %s, increment is %s. Use raid chat!"] = "Fai un'offerta su %s. Il minimo è %s, l'incremento è %s. Usa la chat raid!",
        ["Stop your bids!"] = "Ferma le tue offerte!",
        ["%s seconds to bid"] = "%s secondi per fare un'offerta",
        ["Total Pot: %s"] = "Piatto totale: %s",
        ["Base cut: %s"] = "Taglio base: %s",

        --[[ MULTIAUCTION ]]
        ["I started a bidding session. Can't see it? Make sure to download/update Gargul!"] = "Ho avviato una sessione di offerte. Non riesci a vederlo? Assicurati di scaricare/aggiornare Gargul!",
        ["I resumed a previous bidding session, double check your bids!"] = "Ho ripreso una sessione di offerte precedente, ricontrolla le tue offerte!",
        ["I added %s item(s) to the auction for a total of %s"] = "Ho aggiunto %s articoli all'asta per un totale di %s",
        ["Multi-auction finished. The pot now holds %s"] = "Multiasta terminata. Il piatto ora contiene %s",

        --[[ SOFTRES ]]
        ["You reserved %s"] = "Hai prenotato %s", -- %s is a summary of all items or the ["%s (%sx)"] format (if more than 1 reserve)
        ["%s (%sx)"] = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        ["It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master"] = "Sembra che tu non abbia ancora effettuato la prenotazione soft, controlla il foglio soft-res o chiedi al tuo loot master",
        ["%s (This item is hard-reserved!)"] = "%s (Questo articolo è prenotato in modo definitivo!)",
        ["Reserved by: %s"] = "Riservato da: %s",
        ["Missing soft-reserves from: %s"] = "Riserve software mancanti da: %s",
        ["I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!"] = "Ho appena importato le riserve software in Gargul. Sussurra!sr per ricontrollare le tue riserve!",

        --[[ THATSMYBIS ]]
        ["TMB Wishlist: %s"] = "Lista dei desideri TMB: %s",
        ["%s Priority: %s"] = "Priorità %s: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        ["%s was set as disenchanter"] = "%s è stato impostato come disincantatore",
        ["%s will be disenchanted by %s"] = "%s verrà disincantato da %s",

        --[[ ROLLING ]]
        ["You have %s seconds to roll on %s"] = "Hai %s secondi per avanzare su %s",
        ["Stop your rolls!"] = "Ferma i tuoi rotoli!",
        ["%s seconds to roll"] = "%s secondi per tirare",
        ["This item was reserved by: %s"] = "Questo elemento è stato prenotato da: %s",
        ["These players have the highest %s prio: %s"] = "I seguenti giocatori hanno il vantaggio di %s più alto: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        ["I tried to trade you, but was unsuccessful - trade me for ${item} asap!"] = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        ["%s to %s"] = "Da %s a %s",
        ["to %s"] = "a %s",
        ["I gave %s"] = "Ho dato %s",
        ["I gave %s to %s"] = "Ho dato %s a %s",
        ["I gave %sx%s"] = "Ho dato %sx%s", -- I gave [item]x3
        ["I enchanted %s with %s for %s"] = "Ho incantato %s con %s per %s",
        ["I enchanted %s with %s for %s and gave %s"] = "Ho incantato %s con %s per %s e ho dato %s",
        ["I enchanted %s with %s for %s and received %s"] = "Ho incantato %s con %s per %s e ho ricevuto %s",
        ["to %s and enchanted their %s with %s"] = "a %s e hanno incantato i loro %s con %s",
        ["%s to %s and enchanted their %s with %s"] = "da %s a %se hanno incantato i loro %s con %s",
        ["%s enchanted my %s with %s"] = "%s ha incantato il mio %s con %s",
        ["%s enchanted my %s with %s and gave me %s"] = "%s ha incantato il mio %s con %s e mi ha dato %s",
        ["%s enchanted my %s with %s for %s"] = "%s ha incantato il mio %s con %s per %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s"] = "%s ha incantato i miei %s con %s e io ho incantato i loro %s con %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s"] = "%s ha incantato i miei %s con %s e io ho incantato i loro %s con %s. Gli ho anche dato %s",
        ["%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s"] = "%s ha incantato il mio %s con %s e mi ha dato %s. Ho incantato i loro %s con %s",
        ["%s from %s"] = "%s da %s",
        ["from %s"] = "da %s",
        ["I received %s"] = "Ho ricevuto %s",
        ["I received %s from %s"] = "Ho ricevuto %s da %s",
        ["I received %sx%s"] = "Ho ricevuto %sx%s", -- I gave [item]x3
        ["from %s and got my %s enchanted with %s"] = "da %s e ho incantato il mio %s con %s",
        ["%s from %s and got my %s enchanted with %s"] = "%s da %s e ho fatto incantare il mio %s con %s",

        --[[ AWARD ]]
        ["Random winner for %s selected (%s)"] = "Vincitore casuale per %s selezionato (%s)", -- First %s is item, second %s is player,
    },

    --[[ koKR ]]
    koKR = {
        ["Pass"] = "통과하다",
        ["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"] = "전리품을 배포하기 위해 Gargul을 사용하고 있습니다. 롤링이 더 쉬워지므로 꼭 시도해 보세요!",

        --[[ VERSION CHECK ]]
        ["Gargul missing for:"] = "Gargul이 누락된 이유:",
        ["Gargul outdated for:"] = "Gargul은 다음과 같은 이유로 구식입니다.",
        ["The following players were offline:"] = "다음 플레이어는 오프라인 상태였습니다:",

        --[[ ITEM AWARDED ]]
        ["%s was awarded to %s. Congrats!"] = "%s이(가) %s에게 수여되었습니다. 축하해요!",
        ["%s was awarded to %s for %s points. Congrats!"] = "%s은(는) %s 포인트로 %s에게 수여되었습니다. 축하해요!",
        ["%s was awarded to %s for %s. Congrats!"] = "%s는 %s에 대해 %s에게 수여되었습니다. 축하해요!",

        --[[ TRADE DETAILS ]]
        ["I gave %s to %s"] = "%s을(를) %s에게 주었습니다.",
        ["I deleted a gold trade in which I gave %s to %s"] = "%s을(를) %s에게 준 금 거래를 삭제했습니다.",
        ["I restored a gold trade in which I gave %s to %s"] = "%s을(를) %s에게 준 금 거래를 복원했습니다.",
        ["I received %s from %s"] = "%s로부터 %s을(를) 받았습니다",
        ["I deleted a gold trade in which I received %s from %s"] = "%s로부터 %s을(를) 받은 금 거래를 삭제했습니다.",
        ["I restored a gold trade in which I received %s from %s"] = "%s로부터 %s을(를) 받은 금 거래를 복원했습니다.",

        --[[ TRADE TIME ]]
        ["I have the following items left to trade"] = "다음과 같은 거래 품목이 남았습니다",

        --[[ BOOSTED ROLLS ]]
        ["Your %s roll is /rnd %d-%d%s"] = "귀하의 %s 롤은 /rnd %d-%d%s입니다.",
        ["Player %s's %s roll is /rnd %d-%d%s"] = "플레이어 %s의 %s 판정은 /rnd %d-%d%s입니다.",
        ["(default)"] = "(기본)",

        --[[ PLUS ONES ]]
        ["+"] = "+",
        ["Your +1 total is %d"] = "귀하의 +1 총계는 %d입니다.",
        ["Player %s's +1 total is %d"] = "플레이어 %s의 +1 총합은 %d입니다.",

        --[[ GDKP ]]
        ["I owe you %s. Enjoy!"] = "당신에게 빚진 게 있어요 %s. 즐기다!",
        ["You owe me %s. Thank you!"] = "나한테 빚진 게 있어 %s. 감사합니다!",
        ["Pot was updated, it now holds %s"] = "냄비가 업데이트되어 이제 %s을(를) 보유하고 있습니다.",
        ["Pot was updated after deleting an auction, it now holds %s"] = "경매를 삭제한 후 냄비가 업데이트되어 현재 %s을(를) 보유하고 있습니다.",
        ["Pot was updated after restoring an auction, it now holds %s"] = "경매를 복원한 후 냄비가 업데이트되어 이제 %s을(를) 보유하고 있습니다.",
        ["I removed %s awarded to %s for %s"] = "%s에 대해 %s에게 부여된 %s을(를) 제거했습니다.",
        ["I restored %s awarded to %s for %s"] = "%s에 대해 %s에게 부여된 %s을(를) 복원했습니다.",
        ["I removed %sg from the pot"] = "냄비에서 %sg을(를) 제거했습니다",
        ["I added %sg back to the pot"] = "냄비에 %sg을(를) 다시 추가했습니다",
        ["The pot now holds %s"] = "이제 냄비에 %s이 들어있습니다.",
        ["%s is the highest bidder (%s)"] = "%s은(는) 최고 입찰자(%s)입니다.",
        ["Final Call on %s: %s seconds left to bid!"] = "%s에 대한 최종 결정: 입찰까지 %s초 남았습니다!",
        ["Bid denied, the minimum bid is %s"] = "입찰이 거부되었습니다. 최소 입찰가는 %s입니다.",
        ["Bid on %s. Minimum is %s, increment is %s. Use raid chat!"] = "%s에 입찰하세요. 최소값은 %s, 증가량은 %s입니다. 레이드채팅을 이용해보세요!",
        ["Stop your bids!"] = "입찰을 중단하세요!",
        ["%s seconds to bid"] = "입찰에 걸리는 시간은 %s초입니다.",
        ["Total Pot: %s"] = "총 팟: %s",
        ["Base cut: %s"] = "기본 컷: %s",

        --[[ MULTIAUCTION ]]
        ["I started a bidding session. Can't see it? Make sure to download/update Gargul!"] = "입찰 세션을 시작했습니다. 볼 수 없나요? Gargul을 다운로드/업데이트하세요!",
        ["I resumed a previous bidding session, double check your bids!"] = "이전 입찰 세션을 재개했습니다. 입찰을 다시 확인하세요!",
        ["I added %s item(s) to the auction for a total of %s"] = "총 %s 가격으로 %s개 항목을 경매에 추가했습니다.",
        ["Multi-auction finished. The pot now holds %s"] = "다중경매가 완료되었습니다. 이제 냄비에 %s이 들어있습니다.",

        --[[ SOFTRES ]]
        ["You reserved %s"] = "%s을(를) 예약했습니다", -- %s is a summary of all items or the ["%s (%sx)"] format (if more than 1 reserve)
        ["%s (%sx)"] = "%s(%sx)", -- First %s = item, second %s is times reserved if higher than 1
        ["It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master"] = "아직 소프트 리저브를 하지 않은 것 같습니다. 소프트 레스 시트를 확인하거나 전리품 마스터에게 문의하세요.",
        ["%s (This item is hard-reserved!)"] = "%s (이 항목은 예약되어 있습니다!)",
        ["Reserved by: %s"] = "예약자: %s",
        ["Missing soft-reserves from: %s"] = "다음에서 소프트 예약 누락: %s",
        ["I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!"] = "방금 Gargul로 소프트 리저브를 가져왔습니다. !sr을 통해 보유액을 다시 확인해보세요!",

        --[[ THATSMYBIS ]]
        ["TMB Wishlist: %s"] = "TMB 위시리스트: %s",
        ["%s Priority: %s"] = "%s 우선순위: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        ["%s was set as disenchanter"] = "%s이(가) 마법 해제자로 설정되었습니다",
        ["%s will be disenchanted by %s"] = "%s은(는) %s에 의해 마력을 잃습니다.",

        --[[ ROLLING ]]
        ["You have %s seconds to roll on %s"] = "%s를 굴릴 시간은 %s초 남았습니다.",
        ["Stop your rolls!"] = "롤을 멈춰라!",
        ["%s seconds to roll"] = "굴릴 시간은 %s초",
        ["This item was reserved by: %s"] = "이 항목을 예약한 사람: %s",
        ["These players have the highest %s prio: %s"] = "다음 플레이어의 %s 우선 순위가 가장 높습니다: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        ["I tried to trade you, but was unsuccessful - trade me for ${item} asap!"] = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        ["%s to %s"] = "%s ~ %s",
        ["to %s"] = "%s에게",
        ["I gave %s"] = "%s을(를) 줬습니다",
        ["I gave %s to %s"] = "%s을(를) %s에게 주었습니다.",
        ["I gave %sx%s"] = "%sx%s을(를) 줬습니다", -- I gave [item]x3
        ["I enchanted %s with %s for %s"] = "%s에 %s을(를) 사용하여 %s에 마법을 부여했습니다.",
        ["I enchanted %s with %s for %s and gave %s"] = "%s에 %s로 %s 마법을 부여하고 %s을(를) 주었습니다.",
        ["I enchanted %s with %s for %s and received %s"] = "%s에 %s을(를) 사용하여 %s에 마법을 부여하고 %s을(를) 받았습니다.",
        ["to %s and enchanted their %s with %s"] = "%s에게 %s을(를) 부여하여 %s에 마법을 부여했습니다.",
        ["%s to %s and enchanted their %s with %s"] = "%s에서 %s로 %s에 %s 마법을 부여했습니다.",
        ["%s enchanted my %s with %s"] = "%s가 내 %s에 %s 마법을 부여했습니다.",
        ["%s enchanted my %s with %s and gave me %s"] = "%s님이 내 %s에 %s 마법을 부여하고 %s을(를) 주셨습니다.",
        ["%s enchanted my %s with %s for %s"] = "%s가 %s에 대해 %s로 내 %s에 마법을 걸었습니다.",
        ["%s enchanted my %s with %s and I enchanted their %s with %s"] = "%s님이 내 %s에 %s을(를) 마법을 부여했고 나는 %s을(를) %s로 마법을 부여했습니다.",
        ["%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s"] = "%s님은 내 %s에 %s을(를) 부여했고 나는 %s을(를) %s로 부여했습니다. 나도 그에게 %s을(를) 줬어요",
        ["%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s"] = "%s님이 내 %s에 %s 마법을 부여하고 %s을(를) 주셨습니다. %s에 %s 마법을 부여했습니다.",
        ["%s from %s"] = "%s(%s에서)",
        ["from %s"] = "%s에서",
        ["I received %s"] = "%s을(를) 받았습니다",
        ["I received %s from %s"] = "%s로부터 %s을(를) 받았습니다",
        ["I received %sx%s"] = "%sx%s을(를) 받았습니다", -- I gave [item]x3
        ["from %s and got my %s enchanted with %s"] = "%s에서 내 %s을(를) %s에 매혹시켰습니다.",
        ["%s from %s and got my %s enchanted with %s"] = "%s의 %s이(가) %s에 마법을 부여했습니다.",

        --[[ AWARD ]]
        ["Random winner for %s selected (%s)"] = "%s의 무작위 우승자가 선택되었습니다(%s).", -- First %s is item, second %s is player,
    },

    --[[ ptBR ]]
    ptBR = {
        ["Pass"] = "Passar",
        ["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"] = "Estou usando Gargul para distribuir itens. Torna o rolamento mais fácil, então não deixe de experimentá-lo!",

        --[[ VERSION CHECK ]]
        ["Gargul missing for:"] = "Gargul faltando para:",
        ["Gargul outdated for:"] = "Gargul desatualizado para:",
        ["The following players were offline:"] = "Os seguintes jogadores estavam offline:",

        --[[ ITEM AWARDED ]]
        ["%s was awarded to %s. Congrats!"] = "%s foi concedido a %s. Parabéns!",
        ["%s was awarded to %s for %s points. Congrats!"] = "%s foi concedido a %s por %s pontos. Parabéns!",
        ["%s was awarded to %s for %s. Congrats!"] = "%s foi concedido a %s por %s. Parabéns!",

        --[[ TRADE DETAILS ]]
        ["I gave %s to %s"] = "Eu dei %s para %s",
        ["I deleted a gold trade in which I gave %s to %s"] = "Excluí uma negociação de ouro na qual dei %s para %s",
        ["I restored a gold trade in which I gave %s to %s"] = "Restaurei uma negociação de ouro na qual dei %s para %s",
        ["I received %s from %s"] = "Recebi %s de %s",
        ["I deleted a gold trade in which I received %s from %s"] = "Excluí uma negociação de ouro na qual recebi %s de %s",
        ["I restored a gold trade in which I received %s from %s"] = "Restaurei uma negociação de ouro na qual recebi %s de %s",

        --[[ TRADE TIME ]]
        ["I have the following items left to trade"] = "Ainda tenho os seguintes itens para trocar",

        --[[ BOOSTED ROLLS ]]
        ["Your %s roll is /rnd %d-%d%s"] = "Seu rolo %s é /rnd %d-%d%s",
        ["Player %s's %s roll is /rnd %d-%d%s"] = "A jogada %s do jogador %s é /rnd %d-%d%s",
        ["(default)"] = "(padrão)",

        --[[ PLUS ONES ]]
        ["+"] = "+",
        ["Your +1 total is %d"] = "Seu total de +1 é %d",
        ["Player %s's +1 total is %d"] = "O total de +1 do jogador %s é %d",

        --[[ GDKP ]]
        ["I owe you %s. Enjoy!"] = "Eu devo a você %s. Aproveitar!",
        ["You owe me %s. Thank you!"] = "Você me deve %s. Obrigado!",
        ["Pot was updated, it now holds %s"] = "O pote foi atualizado, agora contém %s",
        ["Pot was updated after deleting an auction, it now holds %s"] = "O pote foi atualizado após a exclusão de um leilão, agora contém %s",
        ["Pot was updated after restoring an auction, it now holds %s"] = "O pote foi atualizado após restaurar um leilão, agora contém %s",
        ["I removed %s awarded to %s for %s"] = "Eu removi %s concedidos a %s por %s",
        ["I restored %s awarded to %s for %s"] = "Eu restaurei %s concedidos a %s por %s",
        ["I removed %sg from the pot"] = "Eu removi %sg do pote",
        ["I added %sg back to the pot"] = "Eu adicionei %sg de volta ao pote",
        ["The pot now holds %s"] = "O pote agora contém %s",
        ["%s is the highest bidder (%s)"] = "%s é o licitante com lance mais alto (%s)",
        ["Final Call on %s: %s seconds left to bid!"] = "Chamada final em %s: %s segundos restantes para lance!",
        ["Bid denied, the minimum bid is %s"] = "Lance negado, o lance mínimo é %s",
        ["Bid on %s. Minimum is %s, increment is %s. Use raid chat!"] = "Dê um lance em %s. O mínimo é %s, o incremento é %s. Use o bate-papo de invasão!",
        ["Stop your bids!"] = "Pare seus lances!",
        ["%s seconds to bid"] = "%s segundos para dar lance",
        ["Total Pot: %s"] = "Pote Total: %s",
        ["Base cut: %s"] = "Corte base: %s",

        --[[ MULTIAUCTION ]]
        ["I started a bidding session. Can't see it? Make sure to download/update Gargul!"] = "Iniciei uma sessão de licitação. Não consegue ver? Certifique-se de baixar/atualizar o Gargul!",
        ["I resumed a previous bidding session, double check your bids!"] = "Retomei uma sessão de lances anterior. Verifique seus lances!",
        ["I added %s item(s) to the auction for a total of %s"] = "Adicionei %s itens ao leilão totalizando %s",
        ["Multi-auction finished. The pot now holds %s"] = "Multi-leilão concluído. O pote agora contém %s",

        --[[ SOFTRES ]]
        ["You reserved %s"] = "Você reservou %s", -- %s is a summary of all items or the ["%s (%sx)"] format (if more than 1 reserve)
        ["%s (%sx)"] = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        ["It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master"] = "Parece que você ainda não fez reserva temporária de nada, verifique a folha de resolução suave ou pergunte ao seu mestre de saque",
        ["%s (This item is hard-reserved!)"] = "%s (Este item é reservado!)",
        ["Reserved by: %s"] = "Reservado por: %s",
        ["Missing soft-reserves from: %s"] = "Reservas temporárias ausentes de: %s",
        ["I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!"] = "Acabei de importar reservas temporárias para Gargul. Sussurre !sr para verificar suas reservas!",

        --[[ THATSMYBIS ]]
        ["TMB Wishlist: %s"] = "Lista de desejos do TMB: %s",
        ["%s Priority: %s"] = "%s Prioridade: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        ["%s was set as disenchanter"] = "%s foi definido como desencantador",
        ["%s will be disenchanted by %s"] = "%s ficará desencantado com %s",

        --[[ ROLLING ]]
        ["You have %s seconds to roll on %s"] = "Você tem %s segundos para rolar %s",
        ["Stop your rolls!"] = "Pare com seus rolos!",
        ["%s seconds to roll"] = "%s segundos para rolar",
        ["This item was reserved by: %s"] = "Este item foi reservado por: %s",
        ["These players have the highest %s prio: %s"] = "Os seguintes jogadores têm o maior %s prio: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        ["I tried to trade you, but was unsuccessful - trade me for ${item} asap!"] = "I tried to trade you, but was unsuccessful - trade me for ${item} asap!",
        ["%s to %s"] = "%s para %s",
        ["to %s"] = "para %s",
        ["I gave %s"] = "Eu dei %s",
        ["I gave %s to %s"] = "Eu dei %s para %s",
        ["I gave %sx%s"] = "Eu dei %sx%s", -- I gave [item]x3
        ["I enchanted %s with %s for %s"] = "Encantei %s com %s para %s",
        ["I enchanted %s with %s for %s and gave %s"] = "Encantei %s com %s para %s e dei %s",
        ["I enchanted %s with %s for %s and received %s"] = "Encantei %s com %s para %s e recebi %s",
        ["to %s and enchanted their %s with %s"] = "para %s e encantou seu %s com %s",
        ["%s to %s and enchanted their %s with %s"] = "%s para %s e encantou seu %s com %s",
        ["%s enchanted my %s with %s"] = "%s encantou meu %s com %s",
        ["%s enchanted my %s with %s and gave me %s"] = "%s encantou meu %s com %s e me deu %s",
        ["%s enchanted my %s with %s for %s"] = "%s encantou meu %s com %s para %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s"] = "%s encantou meu %s com %s e eu encantei o %s dele com %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s"] = "%s encantou meus %s com %s e eu encantei seus %s com %s. Eu também dei a ele %s",
        ["%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s"] = "%s encantou meu %s com %s e me deu %s. Eu encantei o %s deles com %s",
        ["%s from %s"] = "%s de %s",
        ["from %s"] = "de %s",
        ["I received %s"] = "Eu recebi %s",
        ["I received %s from %s"] = "Recebi %s de %s",
        ["I received %sx%s"] = "Recebi %sx%s", -- I gave [item]x3
        ["from %s and got my %s enchanted with %s"] = "de %s e deixei meu %s encantado com %s",
        ["%s from %s and got my %s enchanted with %s"] = "%s de %s e encantei meu %s com %s",

        --[[ AWARD ]]
        ["Random winner for %s selected (%s)"] = "Vencedor aleatório para %s selecionados (%s)", -- First %s is item, second %s is player,
    },

    --[[ ruRU
        These translations where provided by
        - KartonArmadon
    ]]
    ruRU = {
        ["Pass"] = "Пас",
        ["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"] = "Я использую Gargul! Аддон облегчает раздачу добычи, поэтому обязательно попробуйте!",

        --[[ VERSION CHECK ]]
        ["Gargul missing for:"] = "Gargul не найден:",
        ["Gargul outdated for:"] = "Gargul устарел:",
        ["The following players were offline:"] = "Следующие игроки были оффлайн:",

        --[[ ITEM AWARDED ]]
        ["%s was awarded to %s. Congrats!"] = "%s выиграл %s. Поздравляю!",
        ["%s was awarded to %s for %s points. Congrats!"] = "%s выиграл %s за %s баллов. Поздравляю!",
        ["%s was awarded to %s for %s. Congrats!"] = "%s выиграл %s за %s. Поздравляю!",

        --[[ TRADE DETAILS ]]
        ["I gave %s to %s"] = "Я отдал %s %s",
        ["I deleted a gold trade in which I gave %s to %s"] = "Я удалил обмен золотом, в котором я отдал %s %s",
        ["I restored a gold trade in which I gave %s to %s"] = "Я восстановил обмен золотом, в котором я отдал %s %s",
        ["I received %s from %s"] = "Я получил %s от %s",
        ["I deleted a gold trade in which I received %s from %s"] = "Я удалил обмен золотом, в котором я получил %s от %s",
        ["I restored a gold trade in which I received %s from %s"] = "Я восстановил обмен золотом, в котором получил %s от %s",

        --[[ TRADE TIME ]]
        ["I have the following items left to trade"] = "У меня остались следующие предметы для обмена",

        --[[ BOOSTED ROLLS ]]
        ["Your %s roll is /rnd %d-%d%s"] = "Ваш результат %s: /rnd %d-%d%s.",
        ["Player %s's %s roll is /rnd %d-%d%s"] = "Бросок %s игрока %s: /rnd %d-%d%s.",
        ["(default)"] = "(по умолчанию)",

        --[[ PLUS ONES ]]
        ["+"] = "+",
        ["Your +1 total is %d"] = "Ваша сумма +1 составляет %d",
        ["Player %s's +1 total is %d"] = "Сумма +1 игрока %s составляет %d",

        --[[ GDKP ]]
        ["I owe you %s. Enjoy!"] = "Я должен тебе %s",
        ["You owe me %s. Thank you!"] = "Ты мне должен, %s",
        ["Pot was updated, it now holds %s"] = "Банк обновлен. Общая сумма %s",
        ["Pot was updated after deleting an auction, it now holds %s"] = "Банк обновлен после удаления аукциона. Общая сумма %s.",
        ["Pot was updated after restoring an auction, it now holds %s"] = "Банк обновлен после восстановления аукциона. Общая сумма %s.",
        ["I removed %s awarded to %s for %s"] = "Я удалил %s игрока %s за %s",
        ["I restored %s awarded to %s for %s"] = "Я восстановил %s игрока %s за %s",
        ["I removed %sg from the pot"] = "Я удалил %sg из банка",
        ["I added %sg back to the pot"] = "Я восстановил %sg в банке",
        ["The pot now holds %s"] = "В банке сейчас %s",
        ["%s is the highest bidder (%s)"] = "Высшая ставка %s (%s)",
        ["Final Call on %s: %s seconds left to bid!"] = "Аукион на %s завершается: осталось %sсек.!",
        ["Bid denied, the minimum bid is %s"] = "Ставка отклонена, мин. ставка %s.",
        ["Bid on %s. Minimum is %s, increment is %s. Use raid chat!"] = "Ставка на %s. Старт %s, шаг %s!",
        ["Stop your bids!"] = "Аукцион завершён!",
        ["%s seconds to bid"] = "%s сек. осталось",
        ["Total Pot: %s"] = "Общий банк: %s",
        ["Base cut: %s"] = "Базовая доля: %s",

        --[[ MULTIAUCTION ]]
        ["I started a bidding session. Can't see it? Make sure to download/update Gargul!"] = "Я начал мультиаукцион. Если не отображается, то скачайте/обновите Gargul!",
        ["I resumed a previous bidding session, double check your bids!"] = "Я возобновил предыдущий мультиаукцион. Проверьте свои ставки!",
        ["I added %s item(s) to the auction for a total of %s"] = "Я добавил %s товар(ов) на мультиаукцион на %s",
        ["Multi-auction finished. The pot now holds %s"] = "Мультиаукцион завершен. В банке теперь %s",

        --[[ SOFTRES ]]
        ["You reserved %s"] = "Ваш софтрезерв %s", -- %s is a summary of all items or the ["%s (%sx)"] format (if more than 1 reserve)
        ["%s (%sx)"] = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        ["It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master"] = "Похоже, вы еще ничего не резервировали, проверьте таблицу софтрезерва или спросите ответственного за добычу.",
        ["%s (This item is hard-reserved!)"] = "%s (Этот предмет в хардрезерве!)",
        ["Reserved by: %s"] = "Софтрезерв: %s",
        ["Missing soft-reserves from: %s"] = "Отсутствуют софтрезервы от: %s",
        ["I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!"] = "Я только что импортировал софтрезервы в Gargul. Шепните мне !sr, чтобы перепроверить резервы!",

        --[[ THATSMYBIS ]]
        ["TMB Wishlist: %s"] = "Список ThatsMyBis: %s",
        ["%s Priority: %s"] = "%s Приоритет: %s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        ["%s was set as disenchanter"] = "%s был назначен дизэнчантером",
        ["%s will be disenchanted by %s"] = "%s будет распылён %s",

        --[[ ROLLING ]]
        ["You have %s seconds to roll on %s"] = "У вас есть %sсек., чтобы разроллить %s",
        ["Stop your rolls!"] = "Остановите разролл!",
        ["%s seconds to roll"] = "%sсек. осталось",
        ["This item was reserved by: %s"] = "Этот товар зарезервировал: %s",
        ["These players have the highest %s prio: %s"] = "Следующие игроки имеют самый высокий ролл %s приоритет: %s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        ["I tried to trade you, but was unsuccessful - trade me for ${item} asap!"] = "Не получилось передать предмет - кинь мне обмен за ${item}!",
        ["%s to %s"] = "от кого: %s кому: %s",
        ["to %s"] = "кому: %s",
        ["I gave %s"] = "Я отдал %s",
        ["I gave %s to %s"] = "Я отдал %s %s",
        ["I gave %sx%s"] = "Я отдал %sx%s", -- I gave [item]x3
        ["I enchanted %s with %s for %s"] = "Я зачаровал %s за %s для %s",
        ["I enchanted %s with %s for %s and gave %s"] = "Я зачаровал %s за %s для %s и передал %s",
        ["I enchanted %s with %s for %s and received %s"] = "Я зачаровал %s за %s для %s и получил %s",
        ["to %s and enchanted their %s with %s"] = "%s и зачаровал его %s за %s",
        ["%s to %s and enchanted their %s with %s"] = "Передал %s %s и зачаровал его %s за %s",
        ["%s enchanted my %s with %s"] = "%s зачаровал мой %s за %s",
        ["%s enchanted my %s with %s and gave me %s"] = "%s зачаровал мой %s за %s и передал мне %s",
        ["%s enchanted my %s with %s for %s"] = "%s зачаровал мой %s за %s и %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s"] = "%s зачаровал мой %s за %s, а я зачаровал его %s за %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s"] = "%s зачаровал мой %s за %s, а я зачаровал его %s за %s и дал ему %s",
        ["%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s"] = "%s зачаровал мой %s за %s и дал мне %s. Я зачаровал его %s за %s",
        ["%s from %s"] = "%s от %s",
        ["from %s"] = "от %s",
        ["I received %s"] = "Я получил %s",
        ["I received %s from %s"] = "Я получил %s от %s",
        ["I received %sx%s"] = "Я получил %sx%s", -- I gave [item]x3
        ["from %s and got my %s enchanted with %s"] = "от %s и получил мой %s зачарованный за %s",
        ["%s from %s and got my %s enchanted with %s"] = "%s от %s и получил мой %s зачарованный за %s",

        --[[ AWARD ]]
        ["Random winner for %s selected (%s)"] = "Случайный победитель на %s выбран (%s)", -- First %s is item, second %s is player,
    },

    --[[ zhTW ]]
    zhTW = {
        ["Pass"] = "放棄",
        ["I'm using Gargul to distribute loot. It makes rolling easier so be sure to try it out!"] = "我正在使用 Gargul 來分裝。它使分裝變得更容易，值得一試！",

        --[[ VERSION CHECK ]]
        ["Gargul missing for:"] = "未安裝 Gargul：",
        ["Gargul outdated for:"] = "Gargul 版本過舊：",
        ["The following players were offline:"] = "以下玩家離線：",

        --[[ ITEM AWARDED ]]
        ["%s was awarded to %s. Congrats!"] = "%s 的幸運得主為 %s 。恭喜！",
        ["%s was awarded to %s for %s points. Congrats!"] = "%s 被授予 %s %s 積分。恭喜！",
        ["%s was awarded to %s for %s. Congrats!"] = "%s 因 %s 而被授予 %s。恭喜！",

        --[[ TRADE DETAILS ]]
        ["I gave %s to %s"] = "我把 %s 給了 %s",
        ["I deleted a gold trade in which I gave %s to %s"] = "我刪除了一筆黃金交易，其中我向 %s 提供了 %s",
        ["I restored a gold trade in which I gave %s to %s"] = "我恢復了一筆黃金交易，其中我將 %s 給予 %s",
        ["I received %s from %s"] = "我收到了來自 %s 的 %s",
        ["I deleted a gold trade in which I received %s from %s"] = "我刪除了一筆黃金交易，其中我從 %s 收到了 %s",
        ["I restored a gold trade in which I received %s from %s"] = "我恢復了一筆黃金交易，其中我從 %s 收到了 %s",

        --[[ TRADE TIME ]]
        ["I have the following items left to trade"] = "我還有以下物品尚未交易",

        --[[ BOOSTED ROLLS ]]
        ["Your %s roll is /rnd %d-%d%s"] = "你的 %s 卷是 /rnd %d-%d%s",
        ["Player %s's %s roll is /rnd %d-%d%s"] = "玩家 %s 的 %s 擲骰結果為 /rnd %d-%d%s",
        ["(default)"] = "(預設)",

        --[[ PLUS ONES ]]
        ["+"] = "+",
        ["Your +1 total is %d"] = "您的拿裝總數為 %d",
        ["Player %s's +1 total is %d"] = "玩家 %s 的拿裝總數為 %d",

        --[[ GDKP ]]
        ["I owe you %s. Enjoy!"] = "我欠你%s。享受！",
        ["You owe me %s. Thank you!"] = "你欠我%s。謝謝你！",
        ["Pot was updated, it now holds %s"] = "罐子已更新，現在容納 %s",
        ["Pot was updated after deleting an auction, it now holds %s"] = "刪除拍賣後，鍋子已更新，現在持有 %s",
        ["Pot was updated after restoring an auction, it now holds %s"] = "恢復拍賣後，底池已更新，現在持有 %s",
        ["I removed %s awarded to %s for %s"] = "我刪除了為 %s 授予 %s 的 %s",
        ["I restored %s awarded to %s for %s"] = "我恢復了為 %s 授予 %s 的 %s",
        ["I removed %sg from the pot"] = "我從鍋中取出%sg",
        ["I added %sg back to the pot"] = "我將 %sg 添加回鍋中",
        ["The pot now holds %s"] = "底池現在有 %s",
        ["%s is the highest bidder (%s)"] = "%s 是最高出價者 (%s)",
        ["Final Call on %s: %s seconds left to bid!"] = "%s 的最終召集：還剩 %s 秒出價！",
        ["Bid denied, the minimum bid is %s"] = "出價被拒絕，最低出價為 %s",
        ["Bid on %s. Minimum is %s, increment is %s. Use raid chat!"] = "對 %s 出價。最小值為 %s，增量為 %s。使用突襲聊天！",
        ["Stop your bids!"] = "停止出價！",
        ["%s seconds to bid"] = "%s 秒出價",
        ["Total Pot: %s"] = "總底池：%s",
        ["Base cut: %s"] = "基礎切割：%s",

        --[[ MULTIAUCTION ]]
        ["I started a bidding session. Can't see it? Make sure to download/update Gargul!"] = "我開始了投標會議。看不到嗎？請務必下載/更新 Gargul！",
        ["I resumed a previous bidding session, double check your bids!"] = "我恢復了之前的競價，請仔細檢查您的出價！",
        ["I added %s item(s) to the auction for a total of %s"] = "我將 %s 件物品添加到拍賣中，總共 %s 件",
        ["Multi-auction finished. The pot now holds %s"] = "多重拍賣結束。底池現在有 %s",

        --[[ SOFTRES ]]
        ["You reserved %s"] = "您已預訂 %s", -- %s is a summary of all items or the ["%s (%sx)"] format (if more than 1 reserve)
        ["%s (%sx)"] = "%s (%sx)", -- First %s = item, second %s is times reserved if higher than 1
        ["It seems like you didn't soft-reserve anything yet, check the soft-res sheet or ask your loot master"] = "您似乎還沒有軟保留任何東西，請檢查軟資源表或詢問您的戰利品大師",
        ["%s (This item is hard-reserved!)"] = "%s（該商品是硬性保留的！）",
        ["Reserved by: %s"] = "保留者：%s",
        ["Missing soft-reserves from: %s"] = "缺少軟儲備：%s",
        ["I just imported soft-reserves into Gargul. Whisper !sr to double-check your reserves!"] = "我剛剛將軟儲備導入 Gargul。輕聲細語 !sr 仔細檢查您的儲備！",

        --[[ THATSMYBIS ]]
        ["TMB Wishlist: %s"] = "TMB 願望清單：%s",
        ["%s Priority: %s"] = "%s 優先：%s", -- First %s can be TMB/DFT/CPR

        --[[ PACKMULE ]]
        ["%s was set as disenchanter"] = "%s 被設定為分解者",
        ["%s will be disenchanted by %s"] = "%s將會因%s而不再抱持幻想",

        --[[ ROLLING ]]
        ["You have %s seconds to roll on %s"] = "倒數 %s 秒，裝備為 %s",
        ["Stop your rolls!"] = "停！",
        ["%s seconds to roll"] = "倒數 %s 秒",
        ["This item was reserved by: %s"] = "此項目已保留：%s",
        ["These players have the highest %s prio: %s"] = "以下玩家的 %s 優先順序最高：%s", -- First %s can be TMB/DFT/CPR

        --[[ TradeWindow / Trade ]]
        ["I tried to trade you, but was unsuccessful - trade me for ${item} asap!"] = "我嘗試與你交易，但失敗了。麻煩盡速與我交易 ${item} !",
        ["%s to %s"] = "%s 至 %s",
        ["to %s"] = "至 %s",
        ["I gave %s"] = "我給出了 %s",
        ["I gave %s to %s"] = "我把 %s 給了 %s",
        ["I gave %sx%s"] = "我給了 %sx%s", -- I gave [item]x3
        ["I enchanted %s with %s for %s"] = "我為 %s 對 %s 施了魔法",
        ["I enchanted %s with %s for %s and gave %s"] = "我為 %s 用 %s 對 %s 施了魔法，並給了 %s",
        ["I enchanted %s with %s for %s and received %s"] = "我為 %s 用 %s 對 %s 施了魔法，並收到了 %s",
        ["to %s and enchanted their %s with %s"] = "給 %s 並用 %s 迷住了他們的 %s",
        ["%s to %s and enchanted their %s with %s"] = "%s 給 %s 並用 %s 迷住了他們的 %s",
        ["%s enchanted my %s with %s"] = "%s 用 %s 迷惑了我的 %s",
        ["%s enchanted my %s with %s and gave me %s"] = "%s 用 %s 對我的 %s 施了魔法，並給了我 %s",
        ["%s enchanted my %s with %s for %s"] = "%s 用 %s 為我的 %s 施了魔法，讓 %s",
        ["%s enchanted my %s with %s and I enchanted their %s with %s"] = "%s 用 %s 對我的 %s 施了魔法，我用 %s 對他們的 %s 施了魔法",
        ["%s enchanted my %s with %s and I enchanted their %s with %s. I also gave him %s"] = "%s 用 %s 對我的 %s 施了魔法，我用 %s 對他們的 %s 施了魔法。我也給了他%s",
        ["%s enchanted my %s with %s and gave me %s. I enchanted their %s with %s"] = "%s 用 %s 對我的 %s 施了魔法，並給了我 %s。我用 %s 迷住了他們的 %s",
        ["%s from %s"] = "%s 來自 %s",
        ["from %s"] = "來自 %s",
        ["I received %s"] = "我收到了 %s",
        ["I received %s from %s"] = "我收到了來自 %s 的 %s",
        ["I received %sx%s"] = "我收到了 %sx%s", -- I gave [item]x3
        ["from %s and got my %s enchanted with %s"] = "來自 %s 並讓我的 %s 著迷於 %s",
        ["%s from %s and got my %s enchanted with %s"] = "來自 %s 的 %s 讓我的 %s 為 %s 著迷",

        --[[ AWARD ]]
        ["Random winner for %s selected (%s)"] = "已選出 %s 的隨機獲勝者 (%s)", -- First %s is item, second %s is player,
    },
};

L.CHAT.esMX = L.CHAT.esES;
