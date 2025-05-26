--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "esES" and GetLocale() ~= "esMX") then return; end
local L = Gargul_L or {};

L["About"] = "Acerca de";
L["All Settings"] = "Todos los ajustes";
L["Announce"] = "Anunciar";
L["Anti Snipe"] = "Anti agachadiza";
L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"] = [[

Un valor Anti Snipe de 10 significa que cualquier oferta que entre con
Quedan menos de 10 segundos y el cronómetro se restablecerá a 10 segundos.

Puede dejarlo vacío o configurarlo en 0 para desactivar Anti Snipe por completo.
No se admiten valores de Anti Snipe inferiores a 5

]];
L["Are you sure?"] = "¿Está seguro?";
L["\nDon't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --"] = [[
No olvides usar Gargul en su lugar.
si deseas exportar el botín más tarde


-- Haga clic derecho para desactivar esta ventana --]];
L["Auction"] = "Subasta";
L["Auctioneer"] = "Subastador";
L["Auctions"] = "Subastas";
L["Auto"] = "Auto";
L["Auto award"] = "Premio automático";
L["Auto trade"] = "Comercio de automóviles";
L["Available values:"] = "Valores disponibles:";
L["Award"] = "Otorgar";
L["Awarded To"] = "Adjudicado a";
L["BR: %s"] = "BR: %s";
L["Price: %s"] = "Precios";
L["Given: yes"] = "Dado: si";
L["Given: no"] = "Dado: no";
L["2nd bid: %s by %s"] = "2da oferta: %s por %s";
L["You won"] = "Ganaste";
L["Award %s to %s?"] = "¿Otorgar %s a %s?";
L["Are you sure you want to disenchant %s? %s boosted roll points will be refunded!"] = "¿Estás seguro de que quieres desencantar a %s? ¡Se reembolsarán %s puntos de tirada potenciados!";
L["In Group"] = "En grupo";
L["Award history"] = "Historial de premios";
L["Who should %s go to instead?"] = "¿A quién debería acudir %s?";
L["Type player name here"] = "Escribe el nombre del jugador aquí.";
L["or select one below"] = "o seleccione uno a continuación";
L["Do you want to award %s to a random player?"] = "¿Quieres otorgar %s a un jugador aleatorio?";
L["Drag and drop or shift+click an item in the box on the right"] = "Arrastre y suelte o presione Mayús y haga clic en un elemento en el cuadro de la derecha";
L["(BR: %s)"] = "(BR: %s)";
L["Disenchanted items:"] = "Objetos desencantados:";
L["(Given: yes)"] = "(Dado: sí)";
L["(Given: no)"] = "(Dado: no)";
L["(OS)"] = "(SO)";
L["%s boosted roll points will be refunded!"] = "¡Se reembolsarán %s puntos de tirada potenciados!";
L["Are you sure you want to undo %s awarded to %s?%s"] = "¿Estás seguro de que deseas deshacer %s otorgados a %s?%s"; -- The last %s is the content of L["%s boosted roll points will be refunded!"]
L["Bag inspection failed: no reports received"] = "La inspección de la bolsa falló: no se recibieron informes";
L["Inspection finished"] = "Inspección terminada";
L["Starting inspection..."] = "Iniciando inspección...";
L["Balance"] = "Balance";
L["Base"] = "Base";
L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "No se pueden decodificar datos en base64. ¡Asegúrese de copiarlo y pegarlo tal como está sin agregar caracteres ni espacios en blanco adicionales!";
L["Bid"] = "Licitación";
L["Bids"] = "Ofertas";
L["BOE"] = "BOE";
L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"] = "1. ¡Invita/clasifica automáticamente grupos desde el registro de incursiones! Haga clic a continuación o use |c00A79EFF/gl gr";
L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"] = "2. ¡Recompensa a los jugadores por ser habituales o hacer un esfuerzo adicional! Haga clic a continuación o use |c00A79EFF/gl br";
L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"] = "Gargul tiene algunos trucos bajo la manga que quizás no conozcas. ¡Echa un vistazo!";
L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"] = "3. ¡Gargul incluye un sistema de seguimiento más uno! Haga clic a continuación o utilice |c00A79EFF/gl po";
L["Boosted Rolls"] = "Rollos potenciados";
L["BR"] = "BR";
L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"] = [[
¿Suma cuántos puntos para todos los que están actualmente en la incursión?

|c00BE3333Utiliza primero el botón 'Agregar asaltantes faltantes' si quieres que todos obtengan puntos, ¡incluso aquellos sin una entrada de tirada mejorada!]];
L["No point value provided!"] = "¡No se proporciona ningún valor en puntos!";
L["Add points to raid"] = "Agregar puntos a la incursión";
L["Add missing raiders"] = "Agregar asaltantes faltantes";
L["Aliases"] = "Alias";
L["Apply aliases"] = "Aplicar alias";
L["Boosted Roll Cost:"] = "Costo de tirada aumentado:";
L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"] = "¿Estás seguro de que deseas transmitir los datos de tus tiradas mejoradas a todos los miembros de tu grupo/incursión?";
L["Nothing to broadcast, import Boosted Rolls data first!"] = "No hay nada que transmitir, ¡importe primero los datos de Boosted Rolls!";
L["Couldn't process BoostedRolls data received from %s"] = "No se pudieron procesar los datos de BoostedRolls recibidos de %s";
L["Attempting to process incoming BoostedRolls data from %s"] = "Intentando procesar datos BoostedRolls entrantes de %s";
L["Are you sure you want to clear all boosted roll data?"] = "¿Estás seguro de que deseas borrar todos los datos de la tirada mejorada?";
L["Delete %s?"] = "¿Eliminar %s?";
L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"] = "¿Estás seguro de que deseas borrar los datos de tus tiradas mejoradas existentes e importar nuevos datos transmitidos por %s?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Se proporcionaron datos no válidos. Asegúrese de que el contenido siga el formato requerido y no se incluya ninguna fila de encabezado";
L["\nHere you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo"] = [[
Aquí puede importar datos y alias de rollos mejorados desde una tabla en formato CSV o TSV o pegarlos desde una hoja de Google Docs.

La tabla necesita al menos dos columnas: el nombre del jugador seguido de la cantidad de puntos. Las columnas adicionales son opcionales y pueden contener alias del reproductor.
Aquí hay una línea de ejemplo:

Foobar,240,Barfoo]];
L["Points"] = "Puntos";
L["Reserve"] = "Reservar";
L["\nAre you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
¿Estás seguro de que deseas actualizar tus tiradas mejoradas existentes con datos de %s?

Su última actualización fue en |c00A79EFF%s, la de ellos en |c00A79EFF%s.]];
L["!bonus|!rb|!br"] = "!bonificación|!rb|!br";
L["Broadcast"] = "Transmisión";
L["Broadcasting..."] = "Radiodifusión...";
L["You are currently in combat, delaying broadcast"] = "Actualmente estás en combate, retrasando la transmisión.";
L["Broadcast finished!"] = "¡Transmisión terminada!";
L["Include awarded items"] = "Incluir artículos premiados";
L["Include disenchanted items"] = "Incluir elementos desencantados";
L["Include hidden items"] = "Incluir elementos ocultos";
L["Include time left"] = "Incluir el tiempo restante";
L["Broadcast still in progress"] = "Transmisión aún en progreso";
L["There is nothing to broadcast"] = "No hay nada que transmitir";
L["Number of items"] = "Número de items";
L["Broadcast ${percentage}%"] = "Difusión ${percentage}%";
L["Target player (whisper only)"] = "Jugador objetivo (solo susurro)";
L["Whisper requires a target player"] = "Whisper requiere un jugador objetivo";
L["Max trade time left (in minutes)"] = "Tiempo máximo restante para operar (en minutos)";
L["by"] = "por"; -- As in 'bid BY'
L["Cancel"] = "Cancelar";
L["Get support or share ideas on our Discord"] = "Obtenga apoyo o comparta ideas en nuestro Discord";
L["Enable changelog"] = "Habilitar registro de cambios";
L["Gargul makes handing out loot super easy, click the button below to get started!"] = "Gargul hace que repartir botín sea muy fácil. ¡Haz clic en el botón de abajo para comenzar!";
L["Open Gargul"] = "Gárgola abierta";
L["Adjust Scale"] = "Ajustar escala";
L["Channel"] = "Canal";
L["Officer"] = "Oficial";
L["Raid Warning"] = "Advertencia de incursión";
L["Whisper"] = "Susurro";
L["CPR"] = "RCP";
L["Clear"] = "Claro"; -- As in clearing a window or data
L["Close"] = "Cerca";
L["Close on award"] = "Cerrar la adjudicación";
L["Close on start"] = "Cerrar al inicio";
L["Communication"] = "Comunicación";
L["Sent %s of %s bytes"] = "Enviado %s de %s bytes";
L["c"] = "c";
L["Cut"] = "Cortar";
L["Cuts"] = "cortes";
L["Can't send mail when the mailbox is closed"] = "No puedo enviar correo cuando el buzón está cerrado";
L["Multiple mail errors detected, aborting cut distribution"] = "Se detectaron múltiples errores de correo que abortaron la distribución cortada";
L["You don't owe %s any gold"] = "No le debes oro a %s";
L["Failed to send cut to %s"] = "No se pudo enviar el corte a %s";
L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"] = "Correo ENVIADO según el juego, pero el ORO restante NO COINCIDE, ¿algo salió mal?";
L["Mail History for |c00967FD2%s"] = "Historial de correo para |c00967FD2%s";
L["You don't have enough gold to pay %s"] = "No tienes suficiente oro para pagar %s";
L["Wait a bit, we're still processing the previous mail"] = "Espera un poco, todavía estamos procesando el correo anterior.";
L["Gargul GDKP: %sg"] = "Gárgul GDKP: %sg";
L["Sent %sg to %s"] = "Enviado %sg a %s";
L["%Y-%m-%d"] = "%Y-%m-%d";
L["%Y-%m-%d %H:%M"] = "%Y-%m-%d %H:%M";
L["%d-%m %H:%M"] = "%d-%m %H:%M";
L["Delete"] = "Borrar";
L["Details"] = "Detalles";
L["DFT"] = "DFT";
L["Disable"] = "Desactivar";
L["https://discord.gg/D3mDhYPVzf"] = "https://discord.gg/D3mDhYPVzf";
L["Disenchant"] = "Desencantar";
L["Edit"] = "Editar";
L["Enable"] = "Permitir";
L["Export"] = "Exportar";
L["Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!"] = "¿Está seguro de que desea eliminar la tabla completa de su historial de recompensas? ¡Esto elimina TODOS los datos del botín y no se puede deshacer!";
L["Are you sure you want to remove all data for %s? This cannot be undone!"] = "¿Está seguro de que desea eliminar todos los datos de %s? ¡Esto no se puede deshacer!";
L["\nThis is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n"] = [[
Esta es SÓLO una función de exportación, no tiene sentido editar ninguno de los valores: ¡NO SE GUARDARÁN!

]];
L["Fill"] = "Llenar";
L["Final Call"] = "Llamada final";
L["Finish"] = "Finalizar";
L["Format"] = "Formato";
L["Gargul"] = "Gárgola";
L["GDKP"] = "GDKP";
L["GDKP raids are not allowed in this version of World of Warcraft"] = "Las incursiones de GDKP no están permitidas en esta versión de World of Warcraft.";
L["GDKP Active!"] = "¡GDKP activo!";
L["Add dropped loot to queue"] = "Agregar botín caído a la cola";
L["Gold (- for removing gold)"] = "Oro (- para quitar oro)";
L["Who pays for this?"] = "¿Quién paga por esto?";
L["Gold needs to be lower/higher than 0"] = "El oro debe ser inferior/superior a 0";
L["Paid for by"] = "Pagado por";
L["Adjust gold in %s"] = "Ajustar oro en %s";
L["You can't give AND receive gold from the same player at the same time"] = "No puedes dar Y recibir oro del mismo jugador al mismo tiempo.";
L["All cuts were mailed!"] = "¡Todos los cortes fueron enviados por correo!";
L["Disable for disenchanted"] = "Desactivar para desencantados";
L["Disable in combat"] = "Desactivar en combate";
L["Auctions"] = "Subastas";
L["Created by"] = "Creado por";
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Eliminado por %s
Razones]];
L["\n|c00%s%s added to pot by %s\nNote: %s"] = [[
|c00%s%sg añadido al bote por %s
Nota: %s]];
L["Won by"] = "Ganado por";
L["Set paid amount (read left)"] = "Establecer monto pagado (leer a la izquierda)";
L["\n\nGargul automatically keeps track of gold traded. As long as players pay\nfor what they bought then you shouldn't ever need this field\n\n'Paid amount' refers to the amount of gold the buyer already traded you.\nThis does not change the actual price of the item!\n\nWarning: only set a value here if the player promises to pay\noutside of the raid or trades the gold from an alt / mail etc!\n\n\n"] = [[

Gargul realiza un seguimiento automático del oro comercializado. Mientras los jugadores paguen
por lo que compraron entonces nunca deberías necesitar este campo

La 'cantidad pagada' se refiere a la cantidad de oro que el comprador ya le intercambió.
¡Esto no cambia el precio real del artículo!

Advertencia: solo establezca un valor aquí si el jugador promete pagar
fuera de la incursión o intercambia el oro desde un alt/mail, etc.


]];
L["GDKP Price:"] = "Precio GDKP:";
L["Award %s to %s for %s?"] = "¿Premio %s a %s por %s?";
L["Auto Bid"] = "Oferta automática";
L["What's your maximum bid? (Minimum %s|c00FFF569g)"] = "¿Cuál es su oferta máxima? (Mínimo %s|c00FFF569g)";
L["Bid denied!"] = "¡Oferta rechazada!";
L["Min bid: %sg   Increment: %sg"] = "Oferta mínima: %sg Incremento: %sg";
L["(max %sg)"] = "(%sg máximo)";
L["New bid"] = "Nueva oferta";
L["Stop Auto Bid"] = "Detener oferta automática";
L["Top bid: %s by %s"] = "Oferta superior: %s por %s";
L["Top bid: %s by you"] = "Oferta superior: %s tuya";
L["Create a new GDKP session"] = "Crear una nueva sesión de GDKP";
L["Management Cut %"] = "% de recorte de gestión";
L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"] = "Management Cut debe estar vacío o entre 0 y 99 (¡sin signo de %!)";
L["Choose a session type!"] = "¡Elige un tipo de sesión!";
L["Switch to this session"] = "Cambiar a esta sesión";
L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"] = [[

|c00A79EFFMulti-Auction le permite iniciar pujas por varios artículos a la vez, ¡lo que acelera el proceso!
Siga las instrucciones después de crear esta sesión para comenzar

Con |c00A79EFFSingle-Auction, usted elige subastar artículos individuales o utilizar la cola

Seleccionar |c00A79EFFMulti-Auction evita que los artículos descartados se agreguen a la cola
Puede mezclar |c00A79EFFMulti-Auction con |c00A79EFFSingle-Auction y la cola, pero lo desaconsejamos encarecidamente.

]];
L["Auction type (|c00A79EFFi for more info)"] = "Tipo de subasta (|c00A79EFFi para más información)";
L["Multi-Auction"] = "Subasta múltiple";
L["Single-Auction"] = "Subasta única";
L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"] = "Sesión creada. ¡Te recomendamos /reload para que se almacene correctamente en caso de que tu juego falle!";
L["Add Raider"] = "Agregar asaltante";
L["adjust [g]"] = "ajustar [g]";
L["adjust [%]"] = "ajustar [%]";
L["Announce the base cut in group chat"] = "Anunciar el corte de base en el chat grupal";
L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"] = "¿Estás seguro de que quieres restablecer todos los jugadores y cálculos? Nota: ¡todos los jugadores que ya no estén en la incursión serán eliminados de la lista!";
L["Delete Raider"] = "Eliminar asaltante";
L["Edit Raider"] = "Editar asaltante";
L["Lock and Pay"] = "Bloquear y pagar";
L["Manage gold trades"] = "Gestionar transacciones de oro";
L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"] = [[

Con mutadores puedes dar más o menos oro a los jugadores.
Ejemplo: ¡dar un 2% extra a los tanques para eso están los mutadores!

Nota: Editar o eliminar mutadores aquí solo los cambia para esta sesión

]];
L["Not in the raid"] = "No en la redada";
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
L["%s Raiders | %s With cut | Total payout: %s"] = "%s asaltantes | %s Con corte | Pago total: %sg";
L["Nothing to import, double check your CSV"] = "No hay nada que importar, revisa tu CSV";
L["Missing gold for player %s"] = "Falta oro para el jugador %s";
L["Missing header, note: it's case-sensitive!"] = "Falta encabezado, nota: ¡distingue entre mayúsculas y minúsculas!";
L["Missing player name"] = "Falta el nombre del jugador";
L["Delete bid. Auction must be stopped first!"] = "Eliminar oferta. ¡Primero hay que detener la subasta!";
L["Add a raider to this session"] = "Agregar un asaltante a esta sesión";
L["Custom (create your own format)"] = "Personalizado (crea tu propio formato)";
L["Detailed (JSON)"] = "Detallado (JSON)";
L["Share (can be imported by other players)"] = "Compartir (puede ser importado por otros jugadores)";
L["Your custom format"] = "Tu formato personalizado";
L["Your custom header"] = "Tu encabezado personalizado";
L["Custom (create your own format)"] = "Personalizado (crea tu propio formato)";
L["@PLAYER,@CUT"] = "@JUGADOR,@CORTAR";
L["Player,Cut"] = "Jugador, corte";
L["date/time at which the session was locked"] = "fecha/hora en la que se bloqueó la sesión";
L["total gold given to the player"] = "oro total entregado al jugador";
L["gold mailed to the player"] = "oro enviado por correo al jugador";
L["total gold received from the player"] = "oro total recibido del jugador";
L["date/time at which the first item was awarded"] = "fecha/hora en la que se otorgó el primer artículo";
L["gold traded to the player"] = "oro intercambiado al jugador";
L["@ITEM,@WINNER,@GOLD,@WOWHEAD"] = "@ARTÍCULO,@GANADOR,@ORO,@WOWHEAD";
L["Item,Player,Gold,Wowheadlink"] = "Artículo, Jugador, Oro, Wowheadlink";
L["Date/time at which the first item was awarded"] = "Fecha/hora en la que se adjudicó el primer artículo";
L["The title of the GDKP session"] = "El título de la sesión del GDKP";
L["Include disenchanted items"] = "Incluir elementos desencantados";
L["Pot changed"] = "Olla cambiada";
L["Gold Trades"] = "Comercio de oro";
L["Are you sure? You won't be able to see, or bid on, upcoming items!"] = "¿Está seguro? ¡No podrás ver ni pujar por los próximos artículos!";
L["\n|c00BE3333!! WARNING !!|r\n\nYou're on a connected realm and are importing player names without\na realm suffix, '%s' for example. This can cause you to send\ncuts and cut mails to the wrong player.\n\nWhen on a connected realm always try to include the realm name of players!\n\nContinue importing?\n"] = [[
|c00BE3333!! ¡¡ADVERTENCIA!!|r

Estás en un reino conectado y estás importando nombres de jugadores sin
un sufijo de reino, '%s' por ejemplo. Esto puede hacer que envíes
corta y corta correos al jugador equivocado.

Cuando estés en un reino conectado, intenta siempre incluir el nombre del reino de los jugadores.

¿Continuar importando?
]];
L["This will override any changes you've made to the cut window, are you sure?"] = "Esto anulará cualquier cambio que hayas realizado en la ventana de corte, ¿estás seguro?";
L["\nYou can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!):\n\n|c00BE3333Player,Gold|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n"] = [[
Puedes importar cortes de jugadores desde tus propios cálculos como una hoja de Google. software GDKP, etc.

El formato es el siguiente (|c00BE3333¡¡INCLUDE EL ENCABEZADO!!):

|c00BE3333Jugador,Oro|c00967FD2
Jugador1,4000
Jugador2,4125
Jugador3,3998


]];
L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"] = [[
Importe precios mínimos e incrementos de GDKP.

El formato es el siguiente: Se requiere ItemID + mínimo o incremento. (|c00BE3333¡¡REQUIERE UN ENCABEZADO!!):

|c00BE3333ItemID,Mínimo,Incremento|c00967FD2
18608,4000,500
]];
L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"] = "¿Eliminar la configuración de precios existente? Haga clic en Sí para eliminar todos los datos de precios, en No para simplemente anular los existentes con los datos que proporcionó aquí.";
L["Import GDKP Session"] = "Importar sesión de GDKP";
L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"] = "Aquí puede importar (y continuar) una sesión de GDKP. Para obtener una sesión GDKP de alguien, debe exportarla en |c00FFF569/gdkp donde selecciona el formato 'Compartir (puede ser importado por otros jugadores)'.";
L["You're about to import a GDKP session created by %s, are you sure?"] = "Estás a punto de importar una sesión de GDKP creada por %s, ¿estás seguro?";
L["This GDKP session created by %s appears to exist already, do you wish to override it?"] = "Esta sesión de GDKP creada por %s parece que ya existe. ¿Desea anularla?";
L["Invalid data provided for GDKP extension!"] = "¡Se proporcionaron datos no válidos para la extensión GDKP!";
L["Invalid data provided for GDKP reschedule!"] = "¡Se proporcionaron datos no válidos para la reprogramación de GDKP!";
L["Invalid data provided for GDKP shortening!"] = "¡Se proporcionaron datos no válidos para la reducción de GDKP!";
L["Invalid data provided for GDKP auction start!"] = "¡Se proporcionaron datos no válidos para el inicio de la subasta GDKP!";
L["Invalid number provided for 'paid'"] = "Número no válido proporcionado para 'pagado'";
L["Invalid time provided in Auction:reschedule"] = "Hora no válida proporcionada en la subasta: reprogramar";
L["\n\n|c00967FD2GDKP Data (sold %sx)\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n\n"] = [[

|c00967FD2GDKP Datos (vendido %sx)
Vendido por última vez por: %s
Precio medio: %s
Oferta mínima: %s
Incremento: %s

]];
L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"] = "Saldo: |c0092FF000 ? ¡Eres cuadrado! | |c00BE333330 ? debes %s 30g | |c00F7922E50 ? %s te debe 50g";
L["Gold mailed to you by %s"] = "Oro enviado a ti por %s";
L["Gold paid to %s"] = "Oro pagado a %s";
L["Gold received from %s"] = "Oro recibido de %s";
L["Gold %s by"] = "Oro %s por"; -- %s = removed or added
L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"] = "Bote total: %sg | Recorte de gestión: %sg (%s%%) | Para distribuir: %sg";
L["|c00967FD2%s | By %s%s | On |c00967FD2%s"] = "|c00967FD2%s | Por %s%s | En |c00967FD2%s";
L["The GDKP Session is not available or locked"] = "La sesión de GDKP no está disponible o bloqueada";
L["Mail All"] = "Enviar por correo a todos";
L["No bids on Legendary+ item detected, continue manually!"] = "No se detectaron ofertas para el artículo Legendario+. ¡Continúe manualmente!";
L["Missing content in Auction:start"] = "Contenido faltante en la subasta: inicio";
L["\n\nWith multi auctions (or batch auctions) you can auction off as many items as you want at once!\nThis speeds up your raid nights immensely and makes for a seamless experience for your raiders\n\nAll tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'\nGive it a shot!\n\n|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!\n\n"] = [[

¡Con las subastas múltiples (o subastas por lotes) puedes subastar tantos artículos como quieras a la vez!
Esto acelera enormemente tus noches de incursión y crea una experiencia perfecta para tus asaltantes.

Todos los artículos comercializables que aún estén en su inventario se pueden subastar automáticamente con 'Rellenar desde inventario'
¡Dale un tiro!

|c00808080Solo hay una desventaja: para que la gente pueda participar en una subasta por lotes, ¡los asaltantes necesitarán a Gargul!

]];
L["You need to have an active (unlocked) GDKP session!"] = "¡Necesita tener una sesión GDKP activa (desbloqueada)!";
L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"] = "Con esta ventana abierta, %s artículos para agregarlos a la lista o haga clic en 'Rellenar desde el inventario' a continuación"; -- %s holds the add item hotkey (default ALT_CLICK)
L["Anti snipe in seconds"] = "Anti-snipe en segundos";
L["The anti snipe value needs to be 0 (empty) or >=5"] = "El valor anti-snipe debe ser 0 (vacío) o >=5";
L["Go back to the item selector"] = "Volver al selector de artículos";
L["Remove all items from the list"] = "Eliminar todos los elementos de la lista";
L["Fill from inventory"] = "Llenar desde el inventario";
L["Add tradeable items from your inventory to the list"] = "Agregue artículos comercializables de su inventario a la lista";
L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"] = [[
Aquí usted determina qué artículos incluir en su sesión de subasta múltiple

Utilice el botón |c00A79EFFFRellenar desde el inventario a continuación para agregar artículos que aún se pueden intercambiar a la lista
Cada vez que borre y vuelva a abrir esta ventana, se utilizará la última configuración de llenado para agregar elementos automáticamente

|c00A79EFF%s elementos para agregarlos manualmente a la lista
]];
L["Next step: check raider's add-on version for compatibility"] = "Siguiente paso: verifique la compatibilidad de la versión complementaria de Raider";
L["Not everyone is using Gargul, are you sure you want to start the auction?"] = "No todo el mundo usa Gargul, ¿estás seguro de que quieres iniciar la subasta?";
L["Select at least one item for your auction"] = "Seleccione al menos un artículo para su subasta";
L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"] = "Tu Gargul está desactualizado, te recomendamos actualizarlo antes de iniciar una sesión para evitar problemas.";
L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"] = "No todo el mundo está al día. Si tienes problemas, ¡diles a tus asaltantes que actualicen!";
L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"] = "Hay una subasta múltiple activa, los artículos que agregue aquí se agregarán a la sesión existente. ¡Tenga cuidado con los artículos duplicados!";
L["Search name or iLVL"] = "Buscar nombre o iLVL";
L["Supports item names and iLVL e.g. '252', '<252' etc"] = "Admite nombres de elementos e iLVL, p. '252', '<252', etc.";
L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"] = "Sesión GDKP activa: |c00967FD2%s | Por %s%s | En |c00967FD2%s";
L["Auction time in seconds"] = "Tiempo de subasta en segundos";
L["The auction time in seconds needs to be >= 10"] = "El tiempo de la subasta en segundos debe ser >= 10";
L["You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items"] = "Te fuiste durante tu sesión de licitación de GDKP. Para reanudarlo, debe proporcionar un nuevo tiempo de oferta (en segundos) para cualquier artículo no vendido.";
L["With this window open, %s items to add them to the list"] = "Con esta ventana abierta, %s elementos para agregarlos a la lista";
L["Click the cogwheel icon to manage an auction"] = "Haga clic en el icono de la rueda dentada para gestionar una subasta.";
L["You're already the top bidder on %s"] = "Ya eres el mejor postor en %s";
L["Bid |c00%s%sg\nBy %s"] = [[
Oferta |c00%s%sg
Por %s]];
L["|c00%sCLOSED\nNo bids"] = [[
|c00%sCERRADO
Sin pujas]];
L["Minimum: |c00%s%sg\nIncrement: |c00%s%sg"] = [[
Mínimo: |c00%s%sg
Incremento: |c00%s%sg]];
L["Items: %s  -  Total sold: %sg  -  Pledged by me: %sg"] = "Artículos: %s - Total vendido: %sg - Prometido por mí: %sg";
L["Items with bids: %s/%s\nTotal sold: %s\nBought by me: %s\nTotal bid (does not include sold): %s\nBid by me (does not include sold): %s\n"] = [[
Artículos con ofertas: %s/%s
Total vendido: %s
Comprado por mí: %s
Oferta total (no incluye vendidos): %s
Pujar por mí (no incluye vendido): %s
]];
L["|c00%sSOLD to%s\nfor |c00%s%s"] = [[
|c00%sVENDIDO a
%s para |c00%s%sg]];
L["Bid |c00%s%s\nBy |c0092FF00YOU!"] = [[
Oferta |c00%s%sg
Por |c0092FF00YOU!]];
L["Could not stop auto bidding on %s, try again or /reload!"] = "No se pudo detener la oferta automática en %s. Inténtelo de nuevo o /recargue.";
L["Auto bid up to a maximum of %sg"] = "Oferta automática hasta un máximo de %sg";
L["Auto bid up to the bid you fill in on the left"] = "Oferta automática hasta la oferta que complete a la izquierda";
L["Stop your auto bid (%sg)"] = "Detenga su oferta automática (%sg)";
L["Bid on %s could not be confirmed"] = "No se pudo confirmar la oferta de %s";
L["Invalid bid or bid is too low! The minimum is %sg"] = "¡Oferta no válida o la oferta es demasiado baja! El mínimo es %sg";
L["You need to wait two seconds between bids on the same item"] = "Debe esperar dos segundos entre ofertas por el mismo artículo.";
L["Clear bids"] = "Borrar ofertas";
L["Remove all bids from the auction"] = "Eliminar todas las ofertas de la subasta.";
L["Close all"] = "Cierra todo";
L["Close ALL auctions?"] = "¿Cerrar TODAS las subastas?";
L["Close ALL auctions\n\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Cerrar TODAS las subastas

¡Las subastas con ofertas activas se venderán y no podrán recibir nuevas ofertas!
]];
L["Close Auction"] = "Cerrar subasta";
L["Close the auction. Players can no longer bid but the highest bid remains active"] = "Cierra la subasta. Los jugadores ya no pueden ofertar, pero la oferta más alta permanece activa.";
L["Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!"] = "Retire el artículo de la subasta, incluidos los detalles de la oferta. ¡ESTO NO SE PUEDE DESHACER!";
L["Disenchant all finished but unsold items?"] = "¿Desencantar todos los artículos terminados pero no vendidos?";
L["Disenchant unsold items\n\nThis will mark all unsold items as disenchanted and they will not show up in a new multi-auction session"] = [[
Desencantar artículos no vendidos

Esto marcará todos los artículos no vendidos como desencantados y no aparecerán en una nueva sesión de subasta múltiple.
]];
L["Favorite this item"] = "Favorito este artículo";
L["Give a final call timer of how many seconds?"] = "¿Dar un cronómetro de llamada final de cuántos segundos?";
L["The minimum amount of seconds is 5"] = "La cantidad mínima de segundos es 5.";
L["Start a final call for this auction by giving a (usually shorter) bid timer"] = "Inicie una convocatoria final para esta subasta dando un temporizador de oferta (generalmente más corto)";
L["Close ALL auctions and wrap up this multi-auction session?"] = "¿Cerrar TODAS las subastas y concluir esta sesión de subastas múltiples?";
L["Finish Multi-Auction session\n\nThis will close all auctions and announce the total pot in chat\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Finalizar sesión de subasta múltiple

Esto cerrará todas las subastas y anunciará el bote total en el chat.
¡Las subastas con ofertas activas se venderán y no podrán recibir nuevas ofertas!
]];
L["Hide inactive"] = "Ocultar inactivo";
L["Hide unusable"] = "Ocultar inutilizable";
L["Show/Hide finished auctions"] = "Mostrar/Ocultar subastas finalizadas";
L["Manage Auction"] = "Gestionar subasta";
L["Bid the minimum required amount"] = "Oferta la cantidad mínima requerida";
L["Bidding window closed, use |c00A79EFF/gl bid to reopen it!"] = "¡La ventana de oferta está cerrada, use la oferta |c00A79EFF/gl para reabrirla!";
L["Announce sales in chat"] = "Anunciar ventas en el chat";
L["Play sound when outbid"] = "Reproducir sonido cuando se supere la oferta";
L["More sound options..."] = "Más opciones de sonido...";
L["Show all"] = "Mostrar todo";
L["Show favorites"] = "Mostrar favoritos";
L["Show inactive"] = "Mostrar inactivo";
L["Show unusable"] = "Mostrar inutilizable";
L["This item was sold. Use ledger (|c00%s/gdkp) to make changes!"] = "Este artículo fue vendido. ¡Utilice el libro mayor (|c00%s/gdkp) para realizar cambios!";
L["Terminate"] = "Terminar";
L["Remove all bidsl bids and close all auctions?"] = "¿Eliminar todas las ofertas y cerrar todas las subastas?";
L["Terminate Multi-Auction session\n\nThis will delete all bids on items that haven't sold yet and close all auctions!"] = [[
Terminar la sesión de subasta múltiple

¡Esto eliminará todas las ofertas de artículos que aún no se han vendido y cerrará todas las subastas!
]];
L["Hover over any of the buttons below for more information"] = "Pase el cursor sobre cualquiera de los botones a continuación para obtener más información.";
L["Show/Hide items you can't use"] = "Mostrar/Ocultar elementos que no puedes usar";
L["Invalid data provided for GDKP auction start!"] = "¡Se proporcionaron datos no válidos para el inicio de la subasta GDKP!";
L["%s bought %s for %s"] = "%s compró %s por %sg";
L["The loot master (%s) is outdated, this can cause bids to fail!"] = "El botín maestro (%s) está desactualizado, ¡esto puede provocar que las ofertas fallen!";
L["You were outbid!"] = "¡Te superaron la oferta!";
L["Mutators"] = "Mutadores";
L["Add Mutator"] = "Agregar mutador";
L["Auto apply to"] = "Aplicar automáticamente a";
L["Create a new GDKP mutator"] = "Crea un nuevo mutador GDKP";
L["Delete. Hold shift to bypass confirmation"] = "Borrar. Mantenga presionada la tecla Mayús para omitir la confirmación";
L["Edit mutator"] = "Editar mutador";
L["Flat gold rate [example: 250]"] = "Tasa fija de oro [ejemplo: 250]";
L["The flat rate needs to be a number"] = "La tarifa plana debe ser un número.";
L["\nExample:\n|c00967FD2SELF,RL,HEALER"] = [[
Ejemplo:
|c00967FD2SELF,RL,CURADOR]];
L["You can automatically apply this mutator to raiders using keywords:"] = "Puedes aplicar automáticamente este mutador a los asaltantes usando palabras clave:";
L["Name [example: Tanks]"] = "Nombre [ejemplo: Tanques]";
L["Mutator names can not contains dots (.)"] = "Los nombres de los mutadores no pueden contener puntos (.)";
L["Percentage [example: 10]"] = "Porcentaje [ejemplo: 10]";
L["The percentage needs to be a number"] = "El porcentaje debe ser un número.";
L["Store for future sessions"] = "Guardar para futuras sesiones";
L["Unknown mutator: %s"] = "Mutador desconocido: %s";
L["User '%s' is not allowed to start auctions"] = "El usuario '%s' no puede iniciar subastas";
L["User '%s' is not allowed to stop auctions"] = "El usuario '%s' no puede detener subastas";
L["User '%s' is not allowed to stop auction: auction invalid"] = "El usuario '%s' no puede detener la subasta: subasta no válida";
L["There's not enough gold to distribute, expect some weird cut calculations!"] = "No hay suficiente oro para distribuir, ¡espera algunos cálculos de corte extraños!";
L["No bids!"] = "¡Sin ofertas!";
L["You were outbid!"] = "¡Te superaron la oferta!";
L["(active)"] = "(activo)";
L["\nYou need lead or master loot to adjust gold.\nYou can't adjust gold on locked/deleted sessions"] = [[
Necesitas plomo o botín maestro para ajustar el oro.
No puedes ajustar el oro en sesiones bloqueadas/eliminadas]];
L["Add/Remove gold"] = "Agregar/quitar oro";
L["\n%s paid |c00%s%s for\n%s"] = [[
%s pagado |c00%s%s por
%s]]; -- Player paid 5000g for [Benediction]
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Eliminado por %s
Razones]];
L["(deleted)"] = "(eliminado)";
L["\nYou need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions"] = [[
Necesitas un botín principal o maestro para eliminar entradas.
No puede eliminar entradas en sesiones bloqueadas/eliminadas]];
L["Provide a reason for deleting this entry"] = "Proporcione una razón para eliminar esta entrada";
L["Delete. Hold shift to bypass note"] = "Borrar. Mantenga presionada la tecla Mayús para omitir nota";
L["Sessions with auctions attached to them will be deleted after 48 hours"] = "Las sesiones con subastas adjuntas se eliminarán después de 48 horas.";
L["\nYou need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions"] = [[
Necesitas un botín principal o maestro para editar las entradas.
No puede editar entradas eliminadas o entradas en sesiones bloqueadas/eliminadas]];
L["Export a session so others can view session details or even replace you as a loot master"] = "Exporta una sesión para que otros puedan ver los detalles de la sesión o incluso reemplazarte como maestro del botín.";
L["Import a session from another player or account"] = "Importar una sesión de otro jugador o cuenta";
L["\nShow a full overview of the ledger,\nideal for screenshotting purposes!"] = [[
Mostrar una descripción completa del libro mayor,
¡Ideal para propósitos de captura de pantalla!]];
L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"] = "Bloquear una sesión significa que no puedes subastar artículos ni cambiar nada hasta que la desbloquees, ¿estás seguro?";
L["Lock or unlock the session"] = "Bloquear o desbloquear la sesión";
L["Lock the session for payout"] = "Bloquear la sesión para recibir pagos";
L["Multi-auction: auction multiple items at once!"] = "Subasta múltiple: ¡subasta varios artículos a la vez!";
L["added to"] = "añadido a";
L["\n|c00%s%s %s pot by %s\nNote: %s"] = [[
|c00%s%s %s olla por %s
Nota: %s]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L["removed from"] = "retirado de";
L["\nPot: %s\nManagement cut (%s%%): %sg\nPer player cut (1/%s): %sg\n"] = [[
Ollas
Recorte de gestión (%s%%): %sg
Corte por jugador (1/%s): %sg
]];
L["\nYou need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions"] = [[
Necesitas un botín principal o maestro para restaurar las entradas.
No puedes restaurar entradas de sesiones bloqueadas/eliminadas]];
L["By %s%s | On |c00%s%s%s"] = "Por %s%s | En |c00%s%s%s"; -- By name<guild> on date
L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"] = "Desbloquear y cambiar el bote o los cortes puede resultar muy complicado, especialmente si ya has realizado pagos. ¿Está seguro?";
L["Unlock the session"] = "Desbloquear la sesión";
L["No active GDKP session detected or session is not locked for payout!"] = "¡No se detectó ninguna sesión activa de GDKP o la sesión no está bloqueada para el pago!";
L["Increment or minimum can't be lower than .0001!"] = "¡El incremento o mínimo no puede ser inferior a 0,0001!";
L["Invalid 'Increment' provided for item ID '%s'"] = "'Incremento' no válido proporcionado para el ID del artículo '%s'";
L["Invalid 'Minimum' provided for item ID '%s'"] = "Se proporcionó un 'mínimo' no válido para el ID del artículo '%s'";
L["Either minimum or increment is required for item ID: %s"] = "Se requiere mínimo o incremento para el ID del artículo: %s";
L["Missing header, note: it's case-sensitive!"] = "Falta encabezado, nota: ¡distingue entre mayúsculas y minúsculas!";
L["Successfully imported data for %s items"] = "Datos importados correctamente para %s elementos";
L["Unknown item ID: %s"] = "ID de artículo desconocido: %s";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.\nItems in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.\n\nWant Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!\n\n|c00FFF569Did you know?\nYou can move items around with drag and drop\nItems will be remembered, even when you |c00A79EFF/reload\nQueued items are automatically shown to raiders who have Gargul so they can prebid\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s artículos en bolsas, ventanas de botín o incluso en enlaces en tu chat para agregarlos a esta cola de subasta.
Los artículos en la cola se subastarán automáticamente una vez que finalice la subasta actual. Haga clic en el botón '%s' para evitar esto.

¿Quieres que Gargul te otorgue o desencante automáticamente las subastas? ¡Abre la rueda de configuración en el lado izquierdo!

|c00FFF569¿Lo sabías?
Puedes mover elementos con arrastrar y soltar
Los elementos se recordarán, incluso cuando |c00A79EFF/recargue
Los objetos en cola se muestran automáticamente a los asaltantes que tienen Gargul para que puedan hacer una oferta previa.
Gargul también puede encargarse del saqueo automático por ti. Compruébalo con |c00A79EFF/gl pm
]];
L["Hide unusable items"] = "Ocultar elementos inutilizables";
L["GDKP Session"] = "Sesión GDKP";
L["Editing %s"] = "Editando %s";
L["Show upcoming items"] = "Mostrar próximos artículos";
L["Stop the auction first!"] = "¡Detén la subasta primero!";
L["%s owes you %s"] = "%s te debe %s";
L["\n|c00967FD2GDKP Session\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s\n"] = [[
|c00967FD2GDKP Sesión
Gastado por jugador: %s
Dado: %s
Recibido: %s
Corte de jugador: %s

%s
]];
L["Exclude from GDKP"] = "Excluir del GDKP";
L["Gold traded will not be added to amount given or received"] = "El oro negociado no se agregará a la cantidad entregada o recibida";
L["Gold |c00967FD2given to %s"] = "Oro |c00967FD2dado a %s";
L["Unable to add %s to the trade window. Try adding it manually!"] = "No se puede agregar %s a la ventana comercial. ¡Intenta agregarlo manualmente!";
L["You don't have enough money to pay %s"] = "No tienes suficiente dinero para pagar %s";
L["To give: %s"] = "Para regalar: %s";
L["To receive: %s"] = "Para recibir: %s";
L["Gold |c00967FD2received from %s"] = "Oro |c00967FD2recibido de %s";
L["Check out Multi Auctions!"] = "¡Mira las subastas múltiples!";
L["Follow the steps below to quickly get started with Gargul GDKP!"] = "¡Siga los pasos a continuación para comenzar rápidamente con Gargul GDKP!";
L["Activate this session by clicking the |c00FFF569Enable button below!"] = "¡Active esta sesión haciendo clic en el botón |c00FFF569Habilitar a continuación!";
L["|c00FFF569%s an item to auction or queue a single item"] = "|c00FFF569%s un artículo para subastar o poner en cola un solo artículo"; -- %s holds the auction item hotkey (default ALT_CLICK)
L["\nHelpful commands:\n- |c00FFF569/gdkp to open this window\n- |c00FFF569/gl ma to open the multi-auction window\n- |c00FFF569/gl au to open the single item auctioneer / queue\n- |c00FFF569/gl pm to set up auto-looting\n\n"] = [[
Comandos útiles:
- |c00FFF569/gdkp para abrir esta ventana
- |c00FFF569/gl ma para abrir la ventana de subasta múltiple
- |c00FFF569/gl au para abrir la cola/subastador de artículos individuales
- |c00FFF569/gl pm para configurar el saqueo automático

]];
L["If all went well then you will see your freshly auctioned item(s) here!"] = "Si todo salió bien, verás aquí tus artículos recién subastados.";
L["Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!"] = "¿Quiere subastar varios artículos a la vez? Ejecute |c00FFF569/gl ma (o |c00FFF569/gl multiauction) o haga clic en el icono de subasta múltiple en la parte superior derecha de esta ventana.";
L["Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created"] = "Haga clic en el botón |c00FFF569New a continuación para crear su primera sesión de GDKP. Se mostrará a la izquierda cuando se cree.";
L["You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!"] = "¡Estás listo para vender artículos! |c00BE3333Lea atentamente todos los pasos a continuación y pruébelos usted mismo (no es necesario estar en una incursión) antes de comenzar su primera incursión en GDKP.";
L["Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!"] = "¿Quiere vender un artículo sin que nadie puje? |c00FFF569%s en un artículo, elige un ganador y fija un precio.";
L["Getting started"] = "Empezando";
L["Unknown itemID in Auction:create: %s"] = "ID de artículo desconocido en la subasta: crear: %s";
L["Unknown sessionIdentifier in Auction:create: %s"] = "Identificador de sesión desconocido en subasta: crear: %s";
L["You owe %s %s"] = "Debes %s %s";
L["Given"] = "Dado";
L["g"] = "g";
L["Group"] = "Grupo";
L["Group Manager"] = "Administrador de grupo";
L["Download on CurseForge"] = "Descargar en CurseForge";
L["https://addons.wago.io/addons/gargul/versions?stability=stable"] = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L["Halt"] = "Detener";
L["Header"] = "Encabezamiento";
L["|c00%sGargul v%s by Zhorax@Firemaw. Type |c00%s/gl or |c00%s/gargul to get started!"] = "|c00%sGargul v%s por Zhorax@Firemaw. Escribe |c00%s/gl o |c00%s/gargul para comenzar.";
L["Hide"] = "Esconder";
L["%H:%M"] = "%H:%M";
L["Visit the URL below to learn more about personalizing Gargul GDKPs"] = "Visite la siguiente URL para obtener más información sobre cómo personalizar los GDKP de Gargul.";
L["Your logo here? Click for more info!"] = "¿Tu logo aquí? ¡Haga clic para obtener más información!";
L["Import"] = "Importar";
L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"] = "Importado el |c00A79EFF%s en |c00A79EFF%s, actualizado el |c00A79EFF%s en |c00A79EFF%s";
L["What kind of data would you like to import?"] = "¿Qué tipo de datos le gustaría importar?";
L["Import of boosted roll data successful"] = "Importación exitosa de datos de tirada impulsada";
L["Inc"] = "Cª";
L["Include previously awarded items"] = "Incluir artículos previamente premiados";
L["Include BOEs"] = "Incluir BOE";
L["Include materials (like Abyss Crystals)"] = "Incluir materiales (como Abyss Crystals)";
L["Increment"] = "Incremento";
L["Info"] = "Información";
L["Invalid data supplied"] = "Datos no válidos proporcionados";
L["Item"] = "Artículo";
L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "No se pueden decodificar datos JSON. ¡Asegúrese de copiarlo y pegarlo tal como está sin agregar caracteres ni espacios en blanco adicionales!";
L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"] = [[
Teclas de acceso rápido para elementos de Gárgul

Implementación: |c00A79EFF%s
Premio: |c00A79EFF%s
Desencantar: |c00A79EFF%s


-- Haga clic derecho para desactivar esta ventana --
]];
L["Ledger"] = "Libro mayor";
L["<"] = "<";
L["You need to be the master looter or have an assist / lead role!"] = "¡Debes ser el maestro saqueador o tener un papel de asistente o líder!";
L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"] = "Nota: puedes cambiar la configuración regional en cualquier momento en la configuración o mediante |c00%s/gl locale";
L["deDE"] = "deDE"; -- German (Germany)
L["enUS"] = "enUS"; -- English (United States)
L["esES"] = "esES"; -- Spanish (Spain)
L["esMX"] = "esMX"; -- Spanish (Mexico)
L["frFR"] = "frFR"; -- French (France)
L["itIT"] = "itIT"; -- Italian (Italy)
L["koKR"] = "koKR"; -- Korean (Korea)
L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"] = [[
Gargul publica mensajes de chat en inglés (predeterminado)
Puede seleccionar un idioma diferente en el menú desplegable a continuación

Tu idioma de chat actual es '%s', habilitar un idioma diferente provocará una recarga /.
]];
L["Choose a chat language for Gargul"] = "Elige un idioma de chat para Gargul";
L["ptBR"] = "PTBR"; -- Portuguese (Brazil)
L["ruRU"] = "ruRU"; -- Russian (Russia)
L["zhCN"] = "zhCN"; -- Chinese (Simplified, PRC)
L["zhTW"] = "zhTW"; -- Chinese (Traditional, Taiwan)
L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"] = "Tienes uno o más complementos instalados que potencialmente pueden causar que Gargul no funcione correctamente: %s";
L["Clear SoftRes"] = "Borrar resolución suave";
L["Clear TMB"] = "Borrar TMB";
L["/roll for MS or /roll 99 for OS"] = "/roll para MS o /roll 99 para OS";
L["Import SoftRes"] = "Importar resolución suave";
L["Import TMB"] = "Importar TMB";
L["You were given the role of Master Looter"] = "Te asignaron el papel de Maestro saqueador.";
L["Open this window automatically"] = "Abrir esta ventana automáticamente";
L["Loot priorities cleared successfully"] = "Prioridades de botín eliminadas con éxito";
L["Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc"] = "Proporcione un CSV prio en el siguiente formato (1 línea por elemento): id o nombre > prio1, igualprio > prio2 > etc.";
L["Loot priorities imported successfully"] = "Prioridades de botín importadas con éxito";
L["Invalid data provided"] = "Datos no válidos proporcionados";
L["Invalid data provided in line: '%s': missing item id or priority"] = "Datos no válidos proporcionados en la línea: '%s': falta identificación del elemento o prioridad";
L["Attempting to process incoming loot priorities from %s"] = "Intentando procesar las prioridades de botín entrantes de %s";
L["Loot Prio"] = "Prio de botín";
L["Mail"] = "Correo";
L["Mailed"] = "Blindado";
L["Mail cut to players"] = "Corte de correo a los jugadores";
L["MS"] = "EM";
L["Maximize"] = "Maximizar";
L["Min"] = "mín.";
L["Awarded loot history"] = "Historial de botín otorgado";
L["GDKP Cuts"] = "Recortes del PIBK";
L["Export data"] = "Exportar datos";
L["Open Gargul"] = "Gárgola abierta";
L["Import data"] = "Datos de importacion";
L["GDKP Ledger"] = "Libro mayor del GDKP";
L["Multiauction"] = "Multisubasta";
L["Change settings in /gl minimap"] = "Cambiar la configuración en el minimapa /gl";
L["Minimize"] = "Minimizar";
L["Minimize on award"] = "Minimizar el premio";
L["Minimize on start"] = "Minimizar al inicio";
L["Minimum"] = "Mínimo";
L["Minimum item level"] = "Nivel mínimo de artículo";
L["Minimum Quality"] = "Calidad mínima";
L["-10"] = "-10";
L["-"] = "-";
L["Move"] = "Mover";
L["Multi-Auction"] = "Subasta múltiple";
L["Name"] = "Nombre";
L["New"] = "Nuevo";
L["Next"] = "Próximo";
L["No"] = "No";
L["None"] = "Ninguno";
L["Note"] = "Nota";
L["Nothing"] = "Nada";
L["When no one bids do:"] = "Cuando nadie puja:";
L["You don't have officer privileges"] = "No tienes privilegios de oficial.";
L["OS"] = "SO";
L["Ok"] = "De acuerdo";
L["Open"] = "Abierto";
L["Open Auctioneer"] = "Subastador abierto";
L["Open Multi-Auction"] = "Subasta múltiple abierta";
L["DE"] = "DE";
L["GREED"] = "GREED";
L["IGNORE"] = "IGNORE";
L["NEED"] = "NEED";
L["PASS"] = "PASS";
L["RANDOM"] = "RANDOM";
L["RR"] = "RR";
L["SELF"] = "SELF";
L["Set %s as your disenchanter?"] = "¿Establecer a %s como tu desencantador?";
L["Send %s to %s? Type /gl cd to remove this disenchanter!"] = "¿Enviar %s a %s? ¡Escribe /gl cd para eliminar este desencantador!";
L["No disenchanter set, use /gl sd [mydisenchanter] to set one"] = "No hay desencantador configurado, use /gl sd [mydisenchanter] para configurar uno";
L["Who is your disenchanter?"] = "¿Quién es tu desencantador?";
L["Paid"] = "Pagado";
L["Pass"] = "Aprobar";
L["%"] = "%";
L["Player"] = "Jugador";
L["Items won by %s:"] = "Artículos ganados por %s:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L["Plus Ones"] = "Los más";
L["Add a +1"] = "Añadir un +1";
L["Are you sure you want to broadcast your plus one data to everyone in your party/raid?"] = "¿Estás seguro de que quieres transmitir tus datos de acompañante a todos los miembros de tu grupo/incursión?";
L["Attempting to process incoming PlusOnes data from %s"] = "Intentando procesar datos PlusOnes entrantes de %s";
L["%s wants to clear all your PlusOne data. Clear all data?"] = "%s quiere borrar todos tus datos de PlusOne. ¿Borrar todos los datos?";
L["Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?"] = "¿Está seguro de que desea borrar sus datos PlusOne existentes e importar nuevos datos transmitidos por %s?";
L["Are you sure you want to import new data broadcasted by %s?"] = "¿Estás seguro de que deseas importar nuevos datos transmitidos por %s?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Se proporcionaron datos no válidos. Asegúrese de que el contenido siga el formato requerido y no se incluya ninguna fila de encabezado";
L["\nHere you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240\n"] = [[
Aquí puede importar más uno de los datos de una tabla en formato CSV o TSV o pegarlos desde una hoja de Google Docs.

La tabla necesita al menos dos columnas: el nombre del jugador seguido de la cantidad de puntos. Se ignoran las columnas adicionales.

Aquí hay una línea de ejemplo:

Fobar,240
]];
L["Automatically accept incoming broadcasts from %s"] = "Aceptar automáticamente transmisiones entrantes de %s";
L["Block all incoming +1 shared data"] = "Bloquear todos los datos compartidos +1 entrantes";
L["\nAre you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
¿Está seguro de que desea actualizar sus datos PlusOne existentes con datos de %s?

Su última actualización fue en |c00A79EFF%s, la de ellos en |c00A79EFF%s.]];
L["!plusone|!po|!+1"] = "!plusone|!po|!+1";
L["+"] = "+";
L["Pot"] = "Maceta";
L["Price"] = "Precio";
L["PL"] = "PL";
L["Common"] = "Común";
L["Epic"] = "Épico";
L["Heirloom"] = "Reliquia de familia";
L["Legendary"] = "Legendario";
L["Poor"] = "Pobre";
L["Rare"] = "Extraño";
L["Uncommon"] = "Poco común";
L["Queue"] = "Cola";
L["Raiders"] = "asaltantes";
L["Who's Missing"] = "Quién falta";
L["Show missing player names"] = "Mostrar nombres de jugadores faltantes";
L["Disband raid"] = "Disolver incursión";
L["Disband your raid"] = "Disuelve tu incursión";
L["%s is listed twice on the roster!"] = "¡%s aparece dos veces en la lista!";
L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"] = "una exportación |c00FFF569Raid-Helper (use la variante 'Grupos ordenados verticalmente') o una composición de grupo CSV |c00FFF569Gargul:";
L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"] = [[
En el gran cuadro de edición que aparece a continuación, puedes proporcionar una lista e invitar a todos, comprobar quién falta, aplicar grupos y asignar los tanques.

Puede proporcionar un enlace de composición de raid |c00FFF569Wowhead:]];
L["Gargul Group Wiki"] = "Wiki Grupo Gárgul";
L["Visit the Gargul group wiki for more info on the raid group format"] = "Visita la wiki del grupo Gargul para obtener más información sobre el formato del grupo de incursión.";
L["The following players are not part of the roster: %s"] = "Los siguientes jugadores no forman parte del roster: %s";
L["Invalid group data provided, check your format!"] = "Los datos del grupo proporcionados no son válidos, ¡comprueba tu formato!";
L["Invite"] = "Invitar";
L["Send invites to players on roster"] = "Enviar invitaciones a jugadores en la lista";
L["Can't sort groups while %s is in combat!"] = "¡No se pueden ordenar grupos mientras %s está en combate!"; -- %s holds a player name
L["You need to be in a raid!"] = "¡Tienes que estar en una redada!";
L["No tanks defined"] = "No hay tanques definidos";
L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"] = "No puedo encontrar un lugar para %s. ¿Estás intentando poner a más de 5 personas en 1 grupo?";
L["Kick unwanted players"] = "Patear a jugadores no deseados";
L["Kick players that aren't on the roster"] = "Expulsar a jugadores que no están en la plantilla.";
L["Something went wrong while moving %s"] = "Algo salió mal al mover %s";
L["Finished applying raid roster"] = "Se terminó de aplicar la lista de incursiones.";
L["Sorting groups"] = "Ordenar grupos";
L["Apply Groups"] = "Aplicar grupos";
L["Sort groups based on roster"] = "Ordenar grupos según la lista";
L["Sorting is still in progress, wait a bit!"] = "La clasificación aún está en progreso, ¡espera un poco!";
L["All tanks are assigned"] = "Todos los tanques están asignados.";
L["Assign Tanks"] = "Asignar tanques";
L["Wowhead Comp Tool"] = "Herramienta de compilación Wowhead";
L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"] = "Puedes visitar la herramienta de compilación de wowhead usando la URL a continuación. Después de crear tu composición, puedes pegarla aquí o en el campo de edición grande de la ventana del grupo Gargul.";
L["Remove bid"] = "Eliminar oferta";
L["Reset Settings"] = "Reiniciar ajustes";
L["Are you sure you want to reset all of Gargul's settings? This can't be undone!"] = "¿Estás seguro de que quieres restablecer todas las configuraciones de Gargul? ¡Esto no se puede deshacer!";
L["Reset Gargul UI"] = "Restablecer la interfaz de usuario de Gargul";
L["Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!"] = "¿Está seguro de que desea restablecer todos los tamaños, posiciones y escalas de las ventanas de Gargul? ¡Esto no se puede deshacer!";
L["Restore"] = "Restaurar";
L["Resume"] = "Reanudar";
L[">"] = ">";
L["Roll"] = "Rollo";
L["Award %s to %s?"] = "¿Otorgar %s a %s?";
L["Close on award"] = "Cerrar la adjudicación";
L["Close on start"] = "Cerrar al inicio";
L["Hold shift to bypass the award confirmation"] = "Mantenga presionado el turno para omitir la confirmación del premio";
L["Hold shift to show the award confirmation"] = "Mantenga presionado el turno para mostrar la confirmación del premio.";
L["\nWarning: another identical roll was found which can point to a tie\n\n"] = [[
Advertencia: se encontró otra tirada idéntica que puede indicar un empate

]];
L["Invalid data provided for roll start!"] = "¡Se proporcionaron datos no válidos para la tirada de inicio!";
L["(BR: %s)"] = "(BR: %s)";
L["(item given: yes)"] = "(artículo dado: sí)";
L["(item given: no)"] = "(ítem dado: no)";
L["(OS)"] = "(SO)";
L["NOTE"] = "NOTA";
L["Can't stop roll off, no roll off in progress"] = "No se puede detener la transferencia, no hay ninguna transferencia en curso";
L["Pass"] = "Aprobar";
L["rolls: %s"] = "rollos: %s";
L["Open master looter window"] = "Abrir ventana de saqueador maestro";
L["Roll accepted!"] = "Rollo aceptado!";
L["A roll is currently in progress"] = "Actualmente hay una tirada en curso.";
L["Prio [%s]"] = "Prioridad [%s]";
L["SR [%sx]"] = "SR [%sx]";
L["Wish [%s]"] = "Deseo [%s]";
L["You need to select a player first"] = "Primero debes seleccionar un jugador.";
L["TIMER (s)"] = "TEMPORIZADOR(es)";
L["You can't use this item!"] = "¡No puedes usar este artículo!";
L["The winner's name is not unique, select the player you'd like to award %s to"] = "El nombre del ganador no es único, seleccione el jugador al que le gustaría otorgar %s";
L["s"] = "s";
L["Select / Disable all"] = "Seleccionar / Desactivar todo";
L["Session"] = "Sesión";
L["Settings"] = "Ajustes";
L["Announce incoming bids"] = "Anunciar ofertas entrantes";
L["Announce pot after awarding item"] = "Anunciar el bote después de otorgar el artículo";
L["Announce auction start"] = "Anunciar el inicio de la subasta";
L["Announce countdown in raid warning"] = "Anunciar cuenta atrás en aviso de incursión";
L["Announce incoming bids in raid warning"] = "Anunciar ofertas entrantes en advertencia de incursión";
L["Reset Gargul UI"] = "Restablecer la interfaz de usuario de Gargul";
L["Whisper bidder if bid is too low"] = "Pujador en voz baja si la oferta es demasiado baja";
L["s"] = "s";
L["Skip"] = "Saltar";
L["Soft-Reserves"] = "Reservas blandas";
L["SR"] = "SR";
L["Are you sure you want to broadcast your softres data to everyone in your party/raid?"] = "¿Estás seguro de que deseas transmitir tus datos de softres a todos los miembros de tu grupo/incursión?";
L["Couldn't process SoftRes data received from %s"] = "No se pudieron procesar los datos de SoftRes recibidos de %s";
L["Are you sure you want to clear all existing soft-reserve data?"] = "¿Está seguro de que desea borrar todos los datos de reserva temporal existentes?";
L["Everyone filled out their soft-reserves"] = "Todos llenaron sus reservas blandas.";
L["\nHard-reserve information is not available because the soft-reserves\nprovided were not generated using the 'Gargul Export' button on softres.it"] = [[
La información sobre reservas físicas no está disponible porque las reservas blandas
proporcionados no se generaron usando el botón 'Exportar Gargul' en softres.it]];
L["Imported on |c00A79EFF%s at |c00A79EFF%s"] = "Importado el |c00A79EFF%s en |c00A79EFF%s";
L["Auto name fix: the SR of '%s' is now linked to '%s'"] = "Corrección automática de nombres: el SR de '%s' ahora está vinculado a '%s'";
L["In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below."] = "Para comenzar, primero debes crear una redada en softres.it. Luego haga clic en 'Exportar complemento', seleccione 'Gargul', copie los datos y péguelos en el formulario a continuación.";
L["Invalid soft-reserve data provided"] = "Se proporcionaron datos de reserva flexible no válidos";
L["Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here"] = "Se proporcionaron datos no válidos. Asegúrese de hacer clic en el botón 'Exportar Gargul' en softres.it y pegar el contenido completo aquí";
L["The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?"] = "Los valores de PlusOne proporcionados chocan con los que ya están presentes. ¿Quiere reemplazar sus antiguos valores PlusOne?";
L["The following players did not reserve anything:"] = "Los siguientes jugadores no reservaron nada:";
L["Soft-reserves imported successfully"] = "Reservas blandas importadas con éxito";
L["Import successful!"] = "¡Importación exitosa!";
L["SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!"] = "Los datos de SoftRes Weakaura y CSV están obsoletos; ¡use la exportación Gargul en su lugar!";
L["Failed to connect to LootReserve, contact support (include message below)"] = "No se pudo conectar a LootReserve, comuníquese con el soporte (incluya el mensaje a continuación)";
L["%s (%sx)"] = "%s (%sx)";
L["No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!"] = "No hay ninguna URL de softres.it disponible, asegúrese de exportar usando el botón 'Exportar Gargul' en softres.it.";
L["Click here to see hard-reserve info"] = "Haga clic aquí para ver información sobre reservas definitivas";
L["No items are hard-reserved"] = "No hay artículos reservados";
L["No hard-reserve info available"] = "No hay información de reserva dura disponible";
L["Post missing SRs"] = "Publicar SR faltantes";
L["Post SR URL"] = "Publicar URL SR";
L["This player did not reserve anything!"] = "¡Este jugador no reservó nada!";
L["%s (%sx)"] = "%s (%sx)";
L["Attempting to process incoming SoftRes data from %s"] = "Intentando procesar datos SoftRes entrantes de %s";
L["This item is hard-reserved"] = "Este artículo está reservado";
L["For: %s"] = "Para: %s";
L["|c00CC2743 Note: %s"] = "|c00CC2743 Nota: %s";
L["Reserved by"] = "Reservado por";
L["!sr|!softres|!softreserve"] = "!sr|!softres|!softreserve";
L["Something went wrong!"] = "¡Algo salió mal!";
L["Start"] = "Comenzar";
L["Stop"] = "Detener";
L["\\t is replaced by a tab"] = "\\t is replaced by a tab";
L["TMB"] = "TMB";
L["Time"] = "Tiempo";
L["Title"] = "Título";
L["TMB, DFT or PRIO3"] = "TMB, DFT o PRIO3";
L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"] = "¿Estás seguro de que quieres transmitir tus datos de TMB a todos los miembros de tu grupo/incursión? NB: ¡TODOS pueden ver tus datos de TMB independientemente de sus permisos en el sitio web de TMB!";
L["Attempting to process incoming TMB data from %s"] = "Intentando procesar datos TMB entrantes de %s";
L["Are you sure you want to clear all plus one data?"] = "¿Está seguro de que desea borrar todos los datos más uno?";
L["Clear Raider Data"] = "Borrar datos de asaltante";
L["Clear TMB data for all raiders?"] = "¿Borrar datos de TMB para todos los asaltantes?";
L["Auto-sharing enabled: %s"] = "Compartir automáticamente habilitado: %s";
L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "En su ejecución de classicpr.io, haga clic en el botón 'Exportar Gargul' y copie el contenido. Luego pegue el contenido tal cual en el cuadro a continuación y haga clic en 'Importar'. ¡Eso es todo!";
L["Imported on ${date} at ${time}"] = "Importado el ${date} a las ${time}";
L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Exporte sus datos DFT según las instrucciones de la hoja. Luego pegue el contenido tal cual en el cuadro a continuación y haga clic en 'Importar'. ¡Eso es todo!";
L["Invalid CSV provided, the format is: 6948,player1,player2"] = "CSV proporcionado no válido, el formato es: 6948,jugador1,jugador2";
L["Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!"] = "Se proporcionaron datos DFT no válidos. Exporte sus datos DFT según las instrucciones de la hoja y pegue el contenido aquí tal como está.";
L["Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!"] = "Se proporcionaron datos de TMB no válidos, asegúrese de hacer clic en el botón 'Descargar' en la sección Gargul y pegue el contenido aquí tal como está.";
L["Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!"] = "Se proporcionaron datos TMB o DFT no válidos. Asegúrese de pegar el contenido de exportación aquí tal como está.";
L["Priority notes available: %s"] = "Notas prioritarias disponibles: %s";
L["Number of items imported: %s"] = "Número de artículos importados: %s";
L["The following players have no %s entries:"] = "Los siguientes jugadores no tienen %s entradas:"; -- %s can be TMB/DFT/CPR
L["How to use Gargul with ${source}"] = "Cómo utilizar Gargul con ${source}";
L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"] = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L["Paste your TMB export contents as-is in the box below and click 'Import'"] = "Pegue el contenido de exportación de TMB tal como está en el cuadro a continuación y haga clic en 'Importar'";
L["There's no one in your group to broadcast to"] = "No hay nadie en tu grupo para transmitir";
L["TMB data synced"] = "Datos TMB sincronizados";
L["|c00FFFFFF    Note: |c00FFF569%s"] = "|c00FFFFFF Nota: |c00FFF569%s";
L["(OS)"] = "(SO)";
L["%s Prio List"] = "%s lista de prioridades"; -- %s can be TMB/DFT/CPR
L["|c00FFFFFF    Tier: %s"] = "|c00FFFFFF Nivel: %s";
L["TMB Wish List"] = "Lista de deseos de TMB";
L["Show/Hide Dates"] = "Mostrar/Ocultar fechas";
L["Show/Hide Queue"] = "Mostrar/ocultar cola";
L["%s to award loot!"] = "¡%s para otorgar botín!";
L["%s to roll out loot!"] = "¡%s para lanzar el botín!";
L["Hide all awarded items"] = "Ocultar todos los artículos premiados";
L["Hide disenchanted items"] = "Ocultar elementos desencantados";
L["Hide items awarded to self"] = "Ocultar artículos otorgados a uno mismo";
L["Announce Trade"] = "anunciar comercio";
L["Announce trade details to group or in /say when not in a group"] = "Anuncie los detalles comerciales al grupo o en /say cuando no esté en un grupo";
L["Tutorial"] = "Tutorial";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.\nWant to directly sell an item without bidding? Use |c00A79EFF%s\n\nYou can open the %s window directly by typing |c00A79EFF/gl auction\n\nGargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the \"Exclude from GDKP\" checkbox when trading!\n\n|c00FFF569Did you know?\nAwarded items will automatically be added to the trade window\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s artículos en bolsas, ventanas de botín o incluso en enlaces en tu chat para agregarlos a la cola de subasta.
¿Quiere vender directamente un artículo sin pujar? Utilice |c00A79EFF%s

Puede abrir la ventana %s directamente escribiendo |c00A79EFF/gl subasta

Gargul rastrea |c00FF0000TODO el oro comercializado. ¿No quieres que una operación sea parte de esta sesión de GDKP? ¡Marque la casilla de verificación 'Excluir de GDKP' cuando opere!

|c00FFF569¿Lo sabías?
Los artículos premiados se agregarán automáticamente a la ventana de intercambio.
Gargul también puede encargarse del saqueo automático por ti. Compruébalo con |c00A79EFF/gl pm
]];
L["\nThis window shows all the items that have been awarded on any given date (select one or more dates on the left).\n\nItems can contain the following tags:\n\n|c00A79EFFOS: Awarded for offspec\n|c00A79EFFSR: This item was soft-reserved\n|c00A79EFFWL: This item was wishlisted (Thatsmybis)\n|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)\n"] = [[
Esta ventana muestra todos los artículos que se han otorgado en una fecha determinada (seleccione una o más fechas a la izquierda).

Los artículos pueden contener las siguientes etiquetas:

|c00A79EFFOS: Otorgado por fuera de especificación
|c00A79EFFSR: Este elemento fue reservado temporalmente
|c00A79EFFWL: Este artículo fue incluido en la lista de deseos (Thatsmybis)
|c00A79EFFPL: Este elemento fue priorizado (Thatsmybis, DFT, prio3)
]];
L["\nThe items you see here are in the master looter's GDKP queue\nYou can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)\n\nYou can resize the window, move it around, or minimize it. Try it out!\n\nFor loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!\n"] = [[
Los elementos que ves aquí están en la cola GDKP del maestro saqueador.
Puede eliminarlos, ofertar por ellos y ocultar elementos inutilizables (habilite 'Ocultar elementos inutilizables' en la configuración en la parte superior izquierda)

Puede cambiar el tamaño de la ventana, moverla o minimizarla. ¡Pruébalo!

Para los maestros del botín: ¡eliminar elementos aquí solo los eliminará de su cola personal, no de la cola GDKP real!
]];
L["Need more help?"] = "Necesitas más ayuda?";
L["Type"] = "Tipo"; -- As in type of roll or type of item
L["unknown"] = "desconocido";
L["Unknown comm action '%s', make sure to update Gargul!"] = "Acción de comunicación desconocida '%s', ¡asegúrate de actualizar Gargul!";
L["Unlock"] = "desbloquear";
L["Update Gargul!"] = "¡Actualiza Gárgul!";
L["v"] = "v";
L["Report"] = "Informe";
L["Report outdated results in group chat"] = "Informar resultados obsoletos en el chat grupal";
L["Gargul status"] = "Estado de gárgola";
L["Checking version ..."] = "Comprobando versión...";
L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"] = [[
|c0092FF00v%s: el reproductor está actualizado
|c00F7922Ev%s: el jugador necesita actualizar sus complementos
|c00BE3333%s: el reproductor no tiene Gargul o está en una versión no compatible
|c00808080%s: ¡el jugador está desconectado o nos está ignorando!
|c0000FFFF%s: ¡el jugador está en nuestra lista de ignorados!

]];
L["PLAYER IGNORED!"] = "¡JUGADOR IGNORADO!";
L["Offline"] = "Desconectado";
L["No response"] = "Ninguna respuesta";
L["No response:"] = "Ninguna respuesta:";
L["Offline:"] = "Desconectado:";
L["Outdated:"] = "Anticuado:";
L["Up-to-date:"] = "A hoy:";
L["Gargul is out of date and won't work until you update!"] = "¡Gargul está desactualizado y no funcionará hasta que actualices!";
L["Invalid version string provided in Version:addRelease"] = "Cadena de versión no válida proporcionada en Versión:addRelease";
L["Update Gargul!"] = "¡Actualiza Gárgul!";
L["|c00%sGargul is now updated to |c00%sv%s"] = "|c00%sGargul ahora está actualizado a |c00%sv%s";
L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"] = "|c00A79EFFv%s está disponible en CurseForge/Wago. Puedes actualizar sin cerrar el juego, ¡solo asegúrate de /recargar!";
L["Wait %s more seconds before you retry"] = "Espere %s segundos más antes de volver a intentarlo";
L["Window"] = "Ventana";
L["Gargul v%s"] = "Gárgola v%s";
L["Window Scale"] = "Escala de ventana";
L["WL"] = "WL";
L["Yes"] = "Sí";
L["You disabled GDKP queues"] = "Deshabilitaste las colas de GDKP";
L["0"] = "0";
L["Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf"] = "No se pueden comprimir los datos con zlib. Póngase en contacto con el soporte a través de https://discord.gg/D3mDhYPVzf";
L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "No se pueden descomprimir zlib los datos. ¡Asegúrese de copiarlo y pegarlo tal como está sin agregar caracteres ni espacios en blanco adicionales!";
