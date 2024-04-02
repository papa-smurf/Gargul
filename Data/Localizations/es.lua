--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "esES" and GetLocale() ~= "esMX") then return; end
local L = Gargul_L or {};

L.ABOUT = "Acerca de";
L.ALL_SETTINGS = "Todos los ajustes";
L.ANNOUNCE = "Anunciar";
L.ANTISNIPE = "Anti agachadiza";
L.ANTISNIPE_EXPLANATION = [[

Un valor Anti Snipe de 10 significa que cualquier oferta que entre con
Quedan menos de 10 segundos y el cronómetro se restablecerá a 10 segundos.

Puede dejarlo vacío o configurarlo en 0 para desactivar Anti Snipe por completo.
No se admiten valores de Anti Snipe inferiores a 5

]];
L.ARE_YOU_SURE = "¿Está seguro?";
L.ASSIGN_GARGUL_INFO = [[
No olvides usar Gargul en su lugar.
si deseas exportar el botín más tarde


-- Haga clic derecho para desactivar esta ventana --]];
L.AUCTION = "Subasta";
L.AUCTIONEER = "Subastador";
L.AUCTIONS = "Subastas";
L.AUTO = "Auto";
L.AUTO_AWARD = "Premio automático";
L.AUTO_TRADE_OPTIONS = "Comercio de automóviles";
L.AVAILABLE_PLACEHOLDER_VALUES = "Valores disponibles:";
L.AWARD = "Otorgar";
L.AWARDED_TO = "Adjudicado a";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "BR: %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Precios";
L.AWARDED_TOOLTIP_GIVEN = "Dado: si";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Dado: no";
L.AWARDED_TOOLTIP_SECOND_BID = "2da oferta: %s por %s";
L.AWARDED_YOU_WON = "Ganaste";
L.AWARD_CONFIRM = "¿Otorgar %s a %s?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "¿Estás seguro de que quieres desencantar a %s? ¡Se reembolsarán %s puntos de tirada potenciados!";
L.AWARD_HEADER_IN_GROUP = "En grupo";
L.AWARD_HISTORY = "Historial de premios";
L.AWARD_NEW_WINNER_CONFIRMATION = "¿A quién debería acudir %s?";
L.AWARD_PLAYER_CUSTOM_NAME = "Escribe el nombre del jugador aquí.";
L.AWARD_PLAYER_SELECT_NAME = "o seleccione uno a continuación";
L.AWARD_RANDOM_CONFIRM = "¿Quieres otorgar %s a un jugador aleatorio?";
L.AWARD_TOOLTIP_ADD_ITEM = "Arrastre y suelte o presione Mayús y haga clic en un elemento en el cuadro de la derecha";
L.AWARD_TOOLTIP_BR_INDICATION = "(BR: %s)";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Objetos desencantados:";
L.AWARD_TOOLTIP_GIVEN = "(Dado: sí)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(Dado: no)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(SO)";
L.AWARD_UNDO_BR_REFUND = "¡Se reembolsarán %s puntos de tirada potenciados!";
L.AWARD_UNDO_CONFIRM = "¿Estás seguro de que deseas deshacer %s otorgados a %s?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "La inspección de la bolsa falló: no se recibieron informes";
L.BAGINSPECTOR_FINISHED = "Inspección terminada";
L.BAGINSPECTOR_START = "Iniciando inspección...";
L.BALANCE = "Balance";
L.BASE = "Base";
L.BASE64_DECODE_WARNING = "No se pueden decodificar datos en base64. ¡Asegúrese de copiarlo y pegarlo tal como está sin agregar caracteres ni espacios en blanco adicionales!";
L.BID = "Licitación";
L.BIDS = "Ofertas";
L.BIND_ON_EQUIP_ABBR = "BOE";
L.BONUS_AUTO_INVITE = "1. ¡Invita/clasifica automáticamente grupos desde el registro de incursiones! Haga clic a continuación o use |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. ¡Recompensa a los jugadores por ser habituales o hacer un esfuerzo adicional! Haga clic a continuación o use |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "Gargul tiene algunos trucos bajo la manga que quizás no conozcas. ¡Echa un vistazo!";
L.BONUS_PLUSONES = "3. ¡Gargul incluye un sistema de seguimiento más uno! Haga clic a continuación o utilice |c00A79EFF/gl po";
L.BOOSTED_ROLLS = "Rollos potenciados";
L.BOOSTED_ROLLS_ABBR = "BR";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
¿Suma cuántos puntos para todos los que están actualmente en la incursión?

|c00BE3333Utiliza primero el botón 'Agregar asaltantes faltantes' si quieres que todos obtengan puntos, ¡incluso aquellos sin una entrada de tirada mejorada!]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "¡No se proporciona ningún valor en puntos!";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Agregar puntos a la incursión";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Agregar asaltantes faltantes";
L.BOOSTED_ROLLS_ALIASES = "Alias";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Aplicar alias";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Costo de tirada aumentado:";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "¿Estás seguro de que deseas transmitir los datos de tus tiradas mejoradas a todos los miembros de tu grupo/incursión?";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "No hay nada que transmitir, ¡importe primero los datos de Boosted Rolls!";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "No se pudieron procesar los datos de BoostedRolls recibidos de %s";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Intentando procesar datos BoostedRolls entrantes de %s";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "¿Estás seguro de que deseas borrar todos los datos de la tirada mejorada?";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "¿Eliminar %s?";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "¿Estás seguro de que deseas borrar los datos de tus tiradas mejoradas existentes e importar nuevos datos transmitidos por %s?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Se proporcionaron datos no válidos. Asegúrese de que el contenido siga el formato requerido y no se incluya ninguna fila de encabezado";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
Aquí puede importar datos y alias de rollos mejorados desde una tabla en formato CSV o TSV o pegarlos desde una hoja de Google Docs.

La tabla necesita al menos dos columnas: el nombre del jugador seguido de la cantidad de puntos. Las columnas adicionales son opcionales y pueden contener alias del reproductor.
Aquí hay una línea de ejemplo:

Foobar,240,Barfoo]];
L.BOOSTED_ROLLS_POINTS = "Puntos";
L.BOOSTED_ROLLS_RESERVE = "Reservar";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
¿Estás seguro de que deseas actualizar tus tiradas mejoradas existentes con datos de %s?

Su última actualización fue en |c00A79EFF%s, la de ellos en |c00A79EFF%s.]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!bonificación|!rb|!br";
L.BROADCAST = "Transmisión";
L.BROADCASTING_NOTIFICATION = "Radiodifusión...";
L.BROADCAST_DELAYED_BY_COMBAT = "Actualmente estás en combate, retrasando la transmisión.";
L.BROADCAST_FINISHED = "¡Transmisión terminada!";
L.BROADCAST_INC_AWARDED = "Incluir artículos premiados";
L.BROADCAST_INC_DISENCHANTED = "Incluir elementos desencantados";
L.BROADCAST_INC_HIDDEN = "Incluir elementos ocultos";
L.BROADCAST_INC_TIME_LEFT = "Incluir el tiempo restante";
L.BROADCAST_IN_PROGRESS_ERROR = "Transmisión aún en progreso";
L.BROADCAST_NO_DATA = "No hay nada que transmitir";
L.BROADCAST_NUMBER_OF_ITEMS = "Número de items";
L.BROADCAST_PROGRESS = "Difusión ${percentage}%";
L.BROADCAST_TARGET_PLAYER = "Jugador objetivo (solo susurro)";
L.BROADCAST_TARGET_REQUIRED = "Whisper requiere un jugador objetivo";
L.BROADCAST_TRADE_TIME_LEFT = "Tiempo máximo restante para operar (en minutos)";
L.BY = "por"; -- As in 'bid BY'
L.CANCEL = "Cancelar";
L.CHANGELOG_CONTRIBUTE = "Obtenga apoyo o comparta ideas en nuestro Discord";
L.CHANGELOG_ENABLE_LABEL = "Habilitar registro de cambios";
L.CHANGELOG_GETTING_STARTED = "Gargul hace que repartir botín sea muy fácil. ¡Haz clic en el botón de abajo para comenzar!";
L.CHANGELOG_OPEN_GARGUL = "Gárgola abierta";
L.CHANGE_SCALE = "Ajustar escala";
L.CHANNEL = "Canal";
L.CHANNEL_OFFICER = "Oficial";
L.CHANNEL_RAID_WARNING = "Advertencia de incursión";
L.CHANNEL_WHISPER = "Susurro";
L.CLASSICPRIO_ABBR = "RCP";
L.CLEAR = "Claro"; -- As in clearing a window or data
L.CLOSE = "Cerca";
L.CLOSE_ON_AWARD = "Cerrar la adjudicación";
L.CLOSE_ON_START = "Cerrar al inicio";
L.COMMUNICATION = "Comunicación";
L.COMM_PROGRESS = "Enviado %s de %s bytes";
L.COPPER_INDICATOR = "C";
L.CUT = "Cortar";
L.CUTS = "cortes";
L.CUT_MAILBOX_CLOSED = "No puedo enviar correo cuando el buzón está cerrado";
L.CUT_MAILS_FAILED = "Se detectaron múltiples errores de correo que abortaron la distribución cortada";
L.CUT_MAIL_BODY = "Desarrollado por Gargul: ¡una herramienta de botín maestra compatible con TMB, SoftRes, GDKP y Auto-Looting!";
L.CUT_MAIL_EVEN = "No le debes oro a %s";
L.CUT_MAIL_FAILED = "No se pudo enviar el corte a %s";
L.CUT_MAIL_GOLD_MISMATCH = "Correo ENVIADO según el juego, pero el ORO restante NO COINCIDE, ¿algo salió mal?";
L.CUT_MAIL_HISTORY = "Historial de correo para |c00967FD2%s";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "No tienes suficiente oro para pagar %s";
L.CUT_MAIL_IN_PROGRESS = "Espera un poco, todavía estamos procesando el correo anterior.";
L.CUT_MAIL_SUBJECT = "Gárgul GDKP: %sg";
L.CUT_SENT = "Enviado %sg a %s";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "Borrar";
L.DETAILS = "Detalles";
L.DFT = "DFT";
L.DISABLE = "Desactivar";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "Desencantar";
L.EDIT = "Editar";
L.ENABLE = "Permitir";
L.EXPORT = "Exportar";
L.EXPORT_DELETE_ALL_CONFIRM = "¿Está seguro de que desea eliminar la tabla completa de su historial de recompensas? ¡Esto elimina TODOS los datos del botín y no se puede deshacer!";
L.EXPORT_DELETE_DATE_CONFIRM = "¿Está seguro de que desea eliminar todos los datos de %s? ¡Esto no se puede deshacer!";
L.EXPORT_READ_ONLY_NOTICE = [[
Esta es SÓLO una función de exportación, no tiene sentido editar ninguno de los valores: ¡NO SE GUARDARÁN!

]];
L.FILL = "Llenar";
L.FINAL_CALL = "Llamada final";
L.FINISH = "Finalizar";
L.FORMAT = "Formato";
L.GARGUL = "Gárgola";
L.GDKP = "GDKP";
L.GDKPS_ARE_NOT_ALLOWED = "Las incursiones de GDKP no están permitidas en esta versión de World of Warcraft.";
L.GDKP_ACTIVATED = "¡GDKP activo!";
L.GDKP_ADD_DROPS_TO_QUEUE = "Agregar botín caído a la cola";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "Oro (- para quitar oro)";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "¿Quién paga por esto?";
L.GDKP_ADD_GOLD_INVALID_WARNING = "El oro debe ser inferior/superior a 0";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "Pagado por";
L.GDKP_ADD_GOLD_TITLE = "Ajustar oro en %s";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "No puedes dar Y recibir oro del mismo jugador al mismo tiempo.";
L.GDKP_ALL_CUTS_MAILED = "¡Todos los cortes fueron enviados por correo!";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "Desactivar para desencantados";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "Desactivar en combate";
L.GDKP_AUCTIONS = "Subastas";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "Creado por";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333Eliminado por %s
Razones]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg añadido al bote por %s
Nota: %s]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s pagado |c00%s%sg por
%s]];
L.GDKP_AUCTION_DETAILS_WON_BY = "Ganado por";
L.GDKP_AUCTION_PAID_AMOUNT = "Establecer monto pagado (leer a la izquierda)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul realiza un seguimiento automático del oro comercializado. Mientras los jugadores paguen
por lo que compraron entonces nunca deberías necesitar este campo

La 'cantidad pagada' se refiere a la cantidad de oro que el comprador ya le intercambió.
¡Esto no cambia el precio real del artículo!

Advertencia: solo establezca un valor aquí si el jugador promete pagar
fuera de la incursión o intercambia el oro desde un alt/mail, etc.


]];
L.GDKP_AWARD_DIALOG_LABEL = "Precio GDKP:";
L.GDKP_AWARD_ITEM_CONFIRMATION = "¿Premio %s a %s por %s?";
L.GDKP_BIDDER_AUTO_BID = "Oferta automática";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "¿Cuál es su oferta máxima? (Mínimo %s|c00FFF569g)";
L.GDKP_BIDDER_BID_DENIED = "¡Oferta rechazada!";
L.GDKP_BIDDER_ITEM_PRICING = "Oferta mínima: %sg Incremento: %sg";
L.GDKP_BIDDER_MY_MAX_BID = "(%sg máximo)";
L.GDKP_BIDDER_NEW_BID_LABEL = "Nueva oferta";
L.GDKP_BIDDER_STOP_AUTO_BID = "Detener oferta automática";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "Oferta superior: %s por %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "Oferta superior: %s tuya";
L.GDKP_CREATE = "Crear una nueva sesión de GDKP";
L.GDKP_CREATE_MANAGEMENT_CUT = "% de recorte de gestión";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Management Cut debe estar vacío o entre 0 y 99 (¡sin signo de %!)";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "¡Elige un tipo de sesión!";
L.GDKP_CREATE_SESSION_SWITCH = "Cambiar a esta sesión";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFMulti-Auction le permite iniciar pujas por varios artículos a la vez, ¡lo que acelera el proceso!
Siga las instrucciones después de crear esta sesión para comenzar

Con |c00A79EFFSingle-Auction, usted elige subastar artículos individuales o utilizar la cola

Seleccionar |c00A79EFFMulti-Auction evita que los artículos descartados se agreguen a la cola
Puede mezclar |c00A79EFFMulti-Auction con |c00A79EFFSingle-Auction y la cola, pero lo desaconsejamos encarecidamente.

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "Tipo de subasta (|c00A79EFFi para más información)";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "Subasta múltiple";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "Subasta única";
L.GDKP_CREATE_SUCCESSFUL = "Sesión creada. ¡Te recomendamos /reload para que se almacene correctamente en caso de que tu juego falle!";
L.GDKP_CUTS_ADD_RAIDER = "Agregar asaltante";
L.GDKP_CUTS_ADJUST_G = "ajustar [g]";
L.GDKP_CUTS_ADJUST_P = "ajustar [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "Anunciar el corte de base en el chat grupal";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "¿Estás seguro de que quieres restablecer todos los jugadores y cálculos? Nota: ¡todos los jugadores que ya no estén en la incursión serán eliminados de la lista!";
L.GDKP_CUTS_DELETE_RAIDER = "Eliminar asaltante";
L.GDKP_CUTS_EDIT_RAIDER = "Editar asaltante";
L.GDKP_CUTS_LOCK_TOOLTIP = "Bloquear y pagar";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "Gestionar transacciones de oro";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

Con mutadores puedes dar más o menos oro a los jugadores.
Ejemplo: ¡dar un 2% extra a los tanques para eso están los mutadores!

Nota: Editar o eliminar mutadores aquí solo los cambia para esta sesión

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "No en la redada";
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
L.GDKP_CUTS_SUMMARY = "%s asaltantes | %s Con corte | Pago total: %sg";
L.GDKP_CUT_IMPORT_EMPTY = "No hay nada que importar, revisa tu CSV";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Falta oro para el jugador %s";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "Falta encabezado, nota: ¡distingue entre mayúsculas y minúsculas!";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Falta el nombre del jugador";
L.GDKP_DELETE_BID_INFO = "Eliminar oferta. ¡Primero hay que detener la subasta!";
L.GDKP_DISTRIBUTE_ADDRAIDER = "Agregar un asaltante a esta sesión";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "Personalizado (crea tu propio formato)";
L.GDKP_EXPORT_AUCTIONS_JSON = "Detallado (JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "Compartir (puede ser importado por otros jugadores)";
L.GDKP_EXPORT_CUSTOM_FORMAT = "Tu formato personalizado";
L.GDKP_EXPORT_CUSTOM_HEADER = "Tu encabezado personalizado";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Personalizado (crea tu propio formato)";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@JUGADOR,@CORTAR";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "Jugador, corte";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "fecha/hora en la que se bloqueó la sesión";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "oro total entregado al jugador";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "oro enviado por correo al jugador";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "oro total recibido del jugador";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "fecha/hora en la que se otorgó el primer artículo";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "oro intercambiado al jugador";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ARTÍCULO,@GANADOR,@ORO,@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "Artículo, Jugador, Oro, Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "Fecha/hora en la que se adjudicó el primer artículo";
L.GDKP_EXPORT_FORMAT_TITLE = "El título de la sesión del GDKP";
L.GDKP_EXPORT_POT_CHANGED = "Olla cambiada";
L.GDKP_GOLD_TRADES = "Comercio de oro";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "¿Está seguro? ¡No podrás ver ni pujar por los próximos artículos!";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!! ¡¡ADVERTENCIA!!|r

Estás en un reino conectado y estás importando nombres de jugadores sin
un sufijo de reino, '%s' por ejemplo. Esto puede hacer que envíes
corta y corta correos al jugador equivocado.

Cuando estés en un reino conectado, intenta siempre incluir el nombre del reino de los jugadores.

¿Continuar importando?
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "Esto anulará cualquier cambio que hayas realizado en la ventana de corte, ¿estás seguro?";
L.GDKP_IMPORT_CUTS_INFO = [[
Puedes importar cortes de jugadores desde tus propios cálculos como una hoja de Google. software GDKP, etc.

El formato es el siguiente (|c00BE3333¡¡INCLUDE EL ENCABEZADO!!):

|c00BE3333Jugador,Oro|c00967FD2
Jugador1,4000
Jugador2,4125
Jugador3,3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
Importe precios mínimos e incrementos de GDKP.

El formato es el siguiente: Se requiere ItemID + mínimo o incremento. (|c00BE3333¡¡REQUIERE UN ENCABEZADO!!):

|c00BE3333ItemID,Mínimo,Incremento|c00967FD2
18608,4000,500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "¿Eliminar la configuración de precios existente? Haga clic en Sí para eliminar todos los datos de precios, en No para simplemente anular los existentes con los datos que proporcionó aquí.";
L.GDKP_IMPORT_SESSION = "Importar sesión de GDKP";
L.GDKP_IMPORT_SESSION_ABOUT = "Aquí puede importar (y continuar) una sesión de GDKP. Para obtener una sesión GDKP de alguien, debe exportarla en |c00FFF569/gdkp donde selecciona el formato 'Compartir (puede ser importado por otros jugadores)'.";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "Estás a punto de importar una sesión de GDKP creada por %s, ¿estás seguro?";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "Esta sesión de GDKP creada por %s parece que ya existe. ¿Desea anularla?";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "¡Se proporcionaron datos no válidos para la extensión GDKP!";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "¡Se proporcionaron datos no válidos para la reprogramación de GDKP!";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "¡Se proporcionaron datos no válidos para la reducción de GDKP!";
L.GDKP_INVALID_DATA_FOR_START = "¡Se proporcionaron datos no válidos para el inicio de la subasta GDKP!";
L.GDKP_INVALID_PAID_AMOUNT = "Número no válido proporcionado para 'pagado'";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "Hora no válida proporcionada en la subasta: reprogramar";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP Datos (vendido %sx)
Vendido por última vez por: %s
Precio medio: %s
Oferta mínima: %s
Incremento: %s

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "Saldo: |c0092FF000 ? ¡Eres cuadrado! | |c00BE333330 ? debes %s 30g | |c00F7922E50 ? %s te debe 50g";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "Oro enviado a ti por %s";
L.GDKP_LEDGER_LEGEND_PAID_TO = "Oro pagado a %s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "Oro recibido de %s";
L.GDKP_LEDGER_MUTATION = "Oro %s por"; -- %s = removed or added
L.GDKP_LEDGER_POT = "Bote total: %sg | Recorte de gestión: %sg (%s%%) | Para distribuir: %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s | Por %s%s | En |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "La sesión de GDKP no está disponible o bloqueada";
L.GDKP_MAIL_ALL = "Enviar por correo a todos";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "No se detectaron ofertas para el artículo Legendario+. ¡Continúe manualmente!";
L.GDKP_MISSING_CONTENT_FOR_START = "Contenido faltante en la subasta: inicio";
L.GDKP_MULTIAUCTION_ABOUT = [[

¡Con las subastas múltiples (o subastas por lotes) puedes subastar tantos artículos como quieras a la vez!
Esto acelera enormemente tus noches de incursión y crea una experiencia perfecta para tus asaltantes.

Todos los artículos comercializables que aún estén en su inventario se pueden subastar automáticamente con 'Rellenar desde inventario'
¡Dale un tiro!

|c00808080Solo hay una desventaja: para que la gente pueda participar en una subasta por lotes, ¡los asaltantes necesitarán a Gargul!

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "¡Necesita tener una sesión GDKP activa (desbloqueada)!";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "Con esta ventana abierta, %s artículos para agregarlos a la lista o haga clic en 'Rellenar desde el inventario' a continuación"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Anti-snipe en segundos";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "El valor anti-snipe debe ser 0 (vacío) o >=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Volver al selector de artículos";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Eliminar todos los elementos de la lista";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "Llenar desde el inventario";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Agregue artículos comercializables de su inventario a la lista";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Aquí usted determina qué artículos incluir en su sesión de subasta múltiple

Utilice el botón |c00A79EFFFRellenar desde el inventario a continuación para agregar artículos que aún se pueden intercambiar a la lista
Cada vez que borre y vuelva a abrir esta ventana, se utilizará la última configuración de llenado para agregar elementos automáticamente

|c00A79EFF%s elementos para agregarlos manualmente a la lista
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Siguiente paso: verifique la compatibilidad de la versión complementaria de Raider";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "No todo el mundo usa Gargul, ¿estás seguro de que quieres iniciar la subasta?";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Seleccione al menos un artículo para su subasta";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Tu Gargul está desactualizado, te recomendamos actualizarlo antes de iniciar una sesión para evitar problemas.";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "No todo el mundo está al día. Si tienes problemas, ¡diles a tus asaltantes que actualicen!";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "Hay una subasta múltiple activa, los artículos que agregue aquí se agregarán a la sesión existente. ¡Tenga cuidado con los artículos duplicados!";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Buscar nombre o iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Admite nombres de elementos e iLVL, p. '252', '<252', etc.";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Sesión GDKP activa: |c00967FD2%s | Por %s%s | En |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Tiempo de subasta en segundos";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "El tiempo de la subasta en segundos debe ser >= 10";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "Te fuiste durante tu sesión de licitación de GDKP. Para reanudarlo, debe proporcionar un nuevo tiempo de oferta (en segundos) para cualquier artículo no vendido.";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "Con esta ventana abierta, %s elementos para agregarlos a la lista";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "Haga clic en el icono de la rueda dentada para gestionar una subasta.";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "Ya eres el mejor postor en %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
Oferta |c00%s%sg
Por %s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%sCERRADO
Sin pujas]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
Mínimo: |c00%s%sg
Incremento: |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "Artículos: %s - Total vendido: %sg - Prometido por mí: %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
Artículos con ofertas: %s/%s
Total vendido: %s
Comprado por mí: %s
Oferta total (no incluye vendidos): %s
Pujar por mí (no incluye vendido): %s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%sVENDIDO a
%s para |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
Oferta |c00%s%sg
Por |c0092FF00YOU!]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "No se pudo detener la oferta automática en %s. Inténtelo de nuevo o /recargue.";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "Oferta automática hasta un máximo de %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "Oferta automática hasta la oferta que complete a la izquierda";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "Detenga su oferta automática (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "No se pudo confirmar la oferta de %s";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "¡Oferta no válida o la oferta es demasiado baja! El mínimo es %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "Debe esperar dos segundos entre ofertas por el mismo artículo.";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "Borrar ofertas";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "Eliminar todas las ofertas de la subasta.";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "Cierra todo";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "¿Cerrar TODAS las subastas?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
Cerrar TODAS las subastas

¡Las subastas con ofertas activas se venderán y no podrán recibir nuevas ofertas!
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "Cerrar subasta";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "Cierra la subasta. Los jugadores ya no pueden ofertar, pero la oferta más alta permanece activa.";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "Retire el artículo de la subasta, incluidos los detalles de la oferta. ¡ESTO NO SE PUEDE DESHACER!";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "¿Desencantar todos los artículos terminados pero no vendidos?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
Desencantar artículos no vendidos

Esto marcará todos los artículos no vendidos como desencantados y no aparecerán en una nueva sesión de subasta múltiple.
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "Favorito este artículo";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "¿Dar un cronómetro de llamada final de cuántos segundos?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "La cantidad mínima de segundos es 5.";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "Inicie una convocatoria final para esta subasta dando un temporizador de oferta (generalmente más corto)";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "¿Cerrar TODAS las subastas y concluir esta sesión de subastas múltiples?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
Finalizar sesión de subasta múltiple

Esto cerrará todas las subastas y anunciará el bote total en el chat.
¡Las subastas con ofertas activas se venderán y no podrán recibir nuevas ofertas!
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "Ocultar inactivo";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "Ocultar inutilizable";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "Mostrar/Ocultar subastas finalizadas";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "Gestionar subasta";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "Oferta la cantidad mínima requerida";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "¡La ventana de oferta está cerrada, use la oferta |c00A79EFF/gl para reabrirla!";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "Anunciar ventas en el chat";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "Reproducir sonido cuando se supere la oferta";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "Más opciones de sonido...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "Mostrar todo";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "Mostrar favoritos";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "Mostrar inactivo";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "Mostrar inutilizable";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "Este artículo fue vendido. ¡Utilice el libro mayor (|c00%s/gdkp) para realizar cambios!";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "Terminar";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "¿Eliminar todas las ofertas y cerrar todas las subastas?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
Terminar la sesión de subasta múltiple

¡Esto eliminará todas las ofertas de artículos que aún no se han vendido y cerrará todas las subastas!
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "Pase el cursor sobre cualquiera de los botones a continuación para obtener más información.";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "Mostrar/Ocultar elementos que no puedes usar";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "¡Se proporcionaron datos no válidos para el inicio de la subasta GDKP!";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s compró %s por %sg";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "El botín maestro (%s) está desactualizado, ¡esto puede provocar que las ofertas fallen!";
L.GDKP_MULTIAUCTION_OUTBID = "¡Te superaron la oferta!";
L.GDKP_MUTATORS = "Mutadores";
L.GDKP_MUTATOR_ADD = "Agregar mutador";
L.GDKP_MUTATOR_APPLY_LABEL = "Aplicar automáticamente a";
L.GDKP_MUTATOR_CREATE_NEW = "Crea un nuevo mutador GDKP";
L.GDKP_MUTATOR_DELETE_BYPASS = "Borrar. Mantenga presionada la tecla Mayús para omitir la confirmación";
L.GDKP_MUTATOR_EDIT = "Editar mutador";
L.GDKP_MUTATOR_FLAT_LABEL = "Tasa fija de oro [ejemplo: 250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "La tarifa plana debe ser un número.";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
Ejemplo:
|c00967FD2SELF,RL,CURADOR]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "Puedes aplicar automáticamente este mutador a los asaltantes usando palabras clave:";
L.GDKP_MUTATOR_NAME_LABEL = "Nombre [ejemplo: Tanques]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Los nombres de los mutadores no pueden contener puntos (.)";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Porcentaje [ejemplo: 10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "El porcentaje debe ser un número.";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Guardar para futuras sesiones";
L.GDKP_MUTATOR_UNKNOWN = "Mutador desconocido: %s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "El usuario '%s' no puede iniciar subastas";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "El usuario '%s' no puede detener subastas";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "El usuario '%s' no puede detener la subasta: subasta no válida";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "No hay suficiente oro para distribuir, ¡espera algunos cálculos de corte extraños!";
L.GDKP_NO_BIDS = "¡Sin ofertas!";
L.GDKP_OUTBID = "¡Te superaron la oferta!";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(activo)";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
Necesitas plomo o botín maestro para ajustar el oro.
No puedes ajustar el oro en sesiones bloqueadas/eliminadas]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "Agregar/quitar oro";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s pagado |c00%s%s por
%s]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333Eliminado por %s
Razones]];
L.GDKP_OVERVIEW_DELETED_SESSION = "(eliminado)";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
Necesitas un botín principal o maestro para eliminar entradas.
No puede eliminar entradas en sesiones bloqueadas/eliminadas]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "Proporcione una razón para eliminar esta entrada";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "Borrar. Mantenga presionada la tecla Mayús para omitir nota";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "Las sesiones con subastas adjuntas se eliminarán después de 48 horas.";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
Necesitas un botín principal o maestro para editar las entradas.
No puede editar entradas eliminadas o entradas en sesiones bloqueadas/eliminadas]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "Exporta una sesión para que otros puedan ver los detalles de la sesión o incluso reemplazarte como maestro del botín.";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "Importar una sesión de otro jugador o cuenta";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
Mostrar una descripción completa del libro mayor,
¡Ideal para propósitos de captura de pantalla!]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "Bloquear una sesión significa que no puedes subastar artículos ni cambiar nada hasta que la desbloquees, ¿estás seguro?";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "Bloquear o desbloquear la sesión";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "Bloquear la sesión para recibir pagos";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "Subasta múltiple: ¡subasta varios artículos a la vez!";
L.GDKP_OVERVIEW_MUTATION_ADDED = "añadido a";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s %s olla por %s
Nota: %s]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "retirado de";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
Ollas
Recorte de gestión (%s%%): %sg
Corte por jugador (1/%s): %sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
Necesitas un botín principal o maestro para restaurar las entradas.
No puedes restaurar entradas de sesiones bloqueadas/eliminadas]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "Por %s%s | En |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "Desbloquear y cambiar el bote o los cortes puede resultar muy complicado, especialmente si ya has realizado pagos. ¿Está seguro?";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "Desbloquear la sesión";
L.GDKP_PAYOUT_INACTIVE = "¡No se detectó ninguna sesión activa de GDKP o la sesión no está bloqueada para el pago!";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "¡El incremento o mínimo no puede ser inferior a 0,0001!";
L.GDKP_PRICE_IMPORT_INVALID_INC = "'Incremento' no válido proporcionado para el ID del artículo '%s'";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "Se proporcionó un 'mínimo' no válido para el ID del artículo '%s'";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "Se requiere mínimo o incremento para el ID del artículo: %s";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "Falta encabezado, nota: ¡distingue entre mayúsculas y minúsculas!";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Datos importados correctamente para %s elementos";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "ID de artículo desconocido: %s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s artículos en bolsas, ventanas de botín o incluso en enlaces en tu chat para agregarlos a esta cola de subasta.
Los artículos en la cola se subastarán automáticamente una vez que finalice la subasta actual. Haga clic en el botón '%s' para evitar esto.

¿Quieres que Gargul te otorgue o desencante automáticamente las subastas? ¡Abre la rueda de configuración en el lado izquierdo!

|c00FFF569¿Lo sabías?
Puedes mover elementos con arrastrar y soltar
Los elementos se recordarán, incluso cuando |c00A79EFF/recargue
Los objetos en cola se muestran automáticamente a los asaltantes que tienen Gargul para que puedan hacer una oferta previa.
Gargul también puede encargarse del saqueo automático por ti. Compruébalo con |c00A79EFF/gl pm
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Ocultar elementos inutilizables";
L.GDKP_SESSION = "Sesión GDKP";
L.GDKP_SESSION_EDIT_TITLE = "Editando %s";
L.GDKP_SHOW_UPCOMING = "Mostrar próximos artículos";
L.GDKP_STOP_AUCTION_FIRST = "¡Detén la subasta primero!";
L.GDKP_THEY_OWE = "%s te debe %s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP Sesión
Gastado por jugador: %s
Dado: %s
Recibido: %s
Corte de jugador: %s

%s
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "Excluir del GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "El oro negociado no se agregará a la cantidad entregada o recibida";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Oro |c00967FD2dado a %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "No se puede agregar %s a la ventana comercial. ¡Intenta agregarlo manualmente!";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "No tienes suficiente dinero para pagar %s";
L.GDKP_TRADE_GOLD_TO_GIVE = "Para regalar: %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "Para recibir: %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Oro |c00967FD2recibido de %s";
L.GDKP_TRY_MULTIAUCTION = "¡Mira las subastas múltiples!";
L.GDKP_TUTORIAL_INFO = "¡Siga los pasos a continuación para comenzar rápidamente con Gargul GDKP!";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "¡Active esta sesión haciendo clic en el botón |c00FFF569Habilitar a continuación!";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s un artículo para subastar o poner en cola un solo artículo"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
Comandos útiles:
- |c00FFF569/gdkp para abrir esta ventana
- |c00FFF569/gl ma para abrir la ventana de subasta múltiple
- |c00FFF569/gl au para abrir la cola/subastador de artículos individuales
- |c00FFF569/gl pm para configurar el saqueo automático

]];
L.GDKP_TUTORIAL_STEP_DONE = "Si todo salió bien, verás aquí tus artículos recién subastados.";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "¿Quiere subastar varios artículos a la vez? Ejecute |c00FFF569/gl ma (o |c00FFF569/gl multiauction) o haga clic en el icono de subasta múltiple en la parte superior derecha de esta ventana.";
L.GDKP_TUTORIAL_STEP_NEW = "Haga clic en el botón |c00FFF569New a continuación para crear su primera sesión de GDKP. Se mostrará a la izquierda cuando se cree.";
L.GDKP_TUTORIAL_STEP_READY = "¡Estás listo para vender artículos! |c00BE3333Lea atentamente todos los pasos a continuación y pruébelos usted mismo (no es necesario estar en una incursión) antes de comenzar su primera incursión en GDKP.";
L.GDKP_TUTORIAL_STEP_SELL = "¿Quiere vender un artículo sin que nadie puje? |c00FFF569%s en un artículo, elige un ganador y fija un precio.";
L.GDKP_TUTORIAL_TITLE = "Empezando";
L.GDKP_UNKNOWN_ITEM = "ID de artículo desconocido en la subasta: crear: %s";
L.GDKP_UNKNOWN_SESSION = "Identificador de sesión desconocido en subasta: crear: %s";
L.GDKP_YOU_OWE = "Debes %s %s";
L.GIVEN = "Dado";
L.GOLD_INDICATOR = "gramo";
L.GROUP = "Grupo";
L.GROUP_MANAGER = "Administrador de grupo";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "Descargar en CurseForge";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "Detener";
L.HEADER = "Encabezamiento";
L.HELLO = "|c00%sGargul v%s por Zhorax@Firemaw. Escribe |c00%s/gl o |c00%s/gargul para comenzar.";
L.HIDE = "Esconder";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.IDENTITY_INFO = "Visite la siguiente URL para obtener más información sobre cómo personalizar los GDKP de Gargul.";
L.IDENTITY_TOOLTIP = "¿Tu logo aquí? ¡Haga clic para obtener más información!";
L.IMPORT = "Importar";
L.IMPORTED_AND_UPDATED_ON = "Importado el |c00A79EFF%s en |c00A79EFF%s, actualizado el |c00A79EFF%s en |c00A79EFF%s";
L.IMPORT_EXPLANATION = "¿Qué tipo de datos le gustaría importar?";
L.IMPORT_SUCCESSFUL = "Importación exitosa de datos de tirada impulsada";
L.INC = "Cª";
L.INCLUDE_AWARDED = "Incluir artículos previamente premiados";
L.INCLUDE_BOES = "Incluir BOE";
L.INCLUDE_MATERIALS = "Incluir materiales (como Abyss Crystals)";
L.INCREMENT = "Incremento";
L.INFO = "Información";
L.INVALID_DATA_WARNING = "Datos no válidos proporcionados";
L.ITEM = "Artículo";
L.JSON_DECODE_WARNING = "No se pueden decodificar datos JSON. ¡Asegúrese de copiarlo y pegarlo tal como está sin agregar caracteres ni espacios en blanco adicionales!";
L.KEYS_INFO = [[
Teclas de acceso rápido para elementos de Gárgul

Implementación: |c00A79EFF%s
Premio: |c00A79EFF%s
Desencantar: |c00A79EFF%s


-- Haga clic derecho para desactivar esta ventana --
]];
L.LEDGER = "Libro mayor";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "¡Debes ser el maestro saqueador o tener un papel de asistente o líder!";
L.LOCALE_CHANGE_NOTE = "Nota: puedes cambiar la configuración regional en cualquier momento en la configuración o mediante |c00%s/gl locale";
L.LOCALE_DEDE = "DEDE"; -- German (Germany)
L.LOCALE_ENUS = "esUS"; -- English (United States)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_ITIT = "eso eso"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul publica mensajes de chat en inglés (predeterminado)
Puede seleccionar un idioma diferente en el menú desplegable a continuación

Tu idioma de chat actual es '%s', habilitar un idioma diferente provocará una recarga /.
]];
L.LOCALE_NONE_TITLE = "Elige un idioma de chat para Gargul";
L.LOCALE_PTBR = "PTBR"; -- Portuguese (Brazil)
L.LOCALE_RURU = "ruRU"; -- Russian (Russia)
L.LOCALE_ZHCN = "zhCN"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "zhTW"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "Tienes uno o más complementos instalados que potencialmente pueden causar que Gargul no funcione correctamente: %s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "Borrar resolución suave";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "Borrar TMB";
L.LOOTMASTER_DEFAULT_NOTE = "/roll para MS o /roll 99 para OS";
L.LOOTMASTER_IMPORT_SR_BUTTON = "Importar resolución suave";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "Importar TMB";
L.LOOTMASTER_NOTICE_LABEL = "Te asignaron el papel de Maestro saqueador.";
L.LOOTMASTER_OPEN_LABEL = "Abrir esta ventana automáticamente";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Prioridades de botín eliminadas con éxito";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Proporcione un CSV prio en el siguiente formato (1 línea por elemento): id o nombre > prio1, igualprio > prio2 > etc.";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Prioridades de botín importadas con éxito";
L.LOOTPRIORITY_INVALID_DATA = "Datos no válidos proporcionados";
L.LOOTPRIORITY_INVALID_LINE = "Datos no válidos proporcionados en la línea: '%s': falta identificación del elemento o prioridad";
L.LOOTPRIORITY_PROCESS_INCOMING = "Intentando procesar las prioridades de botín entrantes de %s";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Prio de botín";
L.MAIL = "Correo";
L.MAILED = "Blindado";
L.MAIL_CUTS_EXPLANATION = "Corte de correo a los jugadores";
L.MAINSPEC_ABBR = "EM";
L.MAXIMIZE = "Maximizar";
L.MIN = "mín.";
L.MINIMAP_BUTTON_AWARDED = "Historial de botín otorgado";
L.MINIMAP_BUTTON_CUTS = "Recortes del PIBK";
L.MINIMAP_BUTTON_EXPORT = "Exportar datos";
L.MINIMAP_BUTTON_GARGUL = "Gárgola abierta";
L.MINIMAP_BUTTON_IMPORT = "Datos de importacion";
L.MINIMAP_BUTTON_LEDGER = "Libro mayor del GDKP";
L.MINIMAP_BUTTON_MULTIAUCTION = "Multisubasta";
L.MINIMAP_BUTTON_SETTING_INFO = "Cambiar la configuración en el minimapa /gl";
L.MINIMIZE = "Minimizar";
L.MINIMIZE_ON_AWARD = "Minimizar el premio";
L.MINIMIZE_ON_START = "Minimizar al inicio";
L.MINIMUM = "Mínimo";
L.MINIMUM_QUALITY = "Calidad mínima";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "Mover";
L.MULTI_AUCTION = "Subasta múltiple";
L.NAME = "Nombre";
L.NEW = "Nuevo";
L.NEXT = "Próximo";
L.NO = "No";
L.NONE = "Ninguno";
L.NOTE = "Nota";
L.NOTHING = "Nada";
L.NO_BIDS_ACTION = "Cuando nadie puja:";
L.NO_OFFICER_PRIVILEGES = "No tienes privilegios de oficial.";
L.OFFSPEC_ABBR = "SO";
L.OK = "De acuerdo";
L.OPEN = "Abierto";
L.OPEN_AUCTIONEER = "Subastador abierto";
L.OPEN_MULTI_AUCTION = "Subasta múltiple abierta";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "Delaware";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "CODICIA";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORAR";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "NECESIDAD";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "APROBAR";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "ALEATORIO";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SER";
L.PACKMULE_CONFIRM_DISENCHANTER = "¿Establecer a %s como tu desencantador?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "¿Enviar %s a %s? ¡Escribe /gl cd para eliminar este desencantador!";
L.PACKMULE_NO_DISENCHANTER_WARNING = "No hay desencantador configurado, use /gl sd [mydisenchanter] para configurar uno";
L.PACKMULE_WHO_IS_DISENCHANTER = "¿Quién es tu desencantador?";
L.PAID = "Pagado";
L.PASS = "Aprobar";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "Jugador";
L.PLAYER_ITEM_WON_COUNT = "Artículos ganados por %s:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "Los más";
L.PLUSONES_AWARD_DIALOG_LABEL = "Añadir un +1";
L.PLUSONES_BROADCAST_CONFIRM = "¿Estás seguro de que quieres transmitir tus datos de acompañante a todos los miembros de tu grupo/incursión?";
L.PLUSONES_BROADCAST_PROCESS_START = "Intentando procesar datos PlusOnes entrantes de %s";
L.PLUSONES_CLEAR_CONFIRM = "%s quiere borrar todos tus datos de PlusOne. ¿Borrar todos los datos?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "¿Está seguro de que desea borrar sus datos PlusOne existentes e importar nuevos datos transmitidos por %s?";
L.PLUSONES_IMPORT_CONFIRM = "¿Estás seguro de que deseas importar nuevos datos transmitidos por %s?";
L.PLUSONES_IMPORT_ERROR = "Se proporcionaron datos no válidos. Asegúrese de que el contenido siga el formato requerido y no se incluya ninguna fila de encabezado";
L.PLUSONES_IMPORT_INFO = [[
Aquí puede importar más uno de los datos de una tabla en formato CSV o TSV o pegarlos desde una hoja de Google Docs.

La tabla necesita al menos dos columnas: el nombre del jugador seguido de la cantidad de puntos. Se ignoran las columnas adicionales.

Aquí hay una línea de ejemplo:

Fobar,240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Aceptar automáticamente transmisiones entrantes de %s";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Bloquear todos los datos compartidos +1 entrantes";
L.PLUSONES_UPDATE_CONFIRM = [[
¿Está seguro de que desea actualizar sus datos PlusOne existentes con datos de %s?

Su última actualización fue en |c00A79EFF%s, la de ellos en |c00A79EFF%s.]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "Maceta";
L.PRICE = "Precio";
L.PRIOLIST_ABBR = "PL";
L.QUALITY_COMMON = "Común";
L.QUALITY_EPIC = "Épico";
L.QUALITY_HEIRLOOM = "Reliquia de familia";
L.QUALITY_LEGENDARY = "Legendario";
L.QUALITY_POOR = "Pobre";
L.QUALITY_RARE = "Extraño";
L.QUALITY_UNCOMMON = "Poco común";
L.QUEUE = "Cola";
L.RAIDERS = "asaltantes";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Quién falta";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Mostrar nombres de jugadores faltantes";
L.RAIDGROUPS_DISBAND_BUTTON = "Disolver incursión";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Disuelve tu incursión";
L.RAIDGROUPS_DUPLICATE_WARNING = "¡%s aparece dos veces en la lista!";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "una exportación |c00FFF569Raid-Helper (use la variante 'Grupos ordenados verticalmente') o una composición de grupo CSV |c00FFF569Gargul:";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
En el gran cuadro de edición que aparece a continuación, puedes proporcionar una lista e invitar a todos, comprobar quién falta, aplicar grupos y asignar los tanques.

Puede proporcionar un enlace de composición de raid |c00FFF569Wowhead:]];
L.RAIDGROUPS_GARGUL_BUTTON = "Wiki Grupo Gárgul";
L.RAIDGROUPS_GARGUL_INFO = "Visita la wiki del grupo Gargul para obtener más información sobre el formato del grupo de incursión.";
L.RAIDGROUPS_IMPOSTER_WARNING = "Los siguientes jugadores no forman parte del roster: %s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Los datos del grupo proporcionados no son válidos, ¡comprueba tu formato!";
L.RAIDGROUPS_INVITE_BUTTON = "Invitar";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Enviar invitaciones a jugadores en la lista";
L.RAIDGROUPS_IN_COMBAT_WARNING = "¡No se pueden ordenar grupos mientras %s está en combate!"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "¡Tienes que estar en una redada!";
L.RAIDGROUPS_NO_TANKS_WARNING = "No hay tanques definidos";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "No puedo encontrar un lugar para %s. ¿Estás intentando poner a más de 5 personas en 1 grupo?";
L.RAIDGROUPS_PURGE_BUTTON = "Patear a jugadores no deseados";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Expulsar a jugadores que no están en la plantilla.";
L.RAIDGROUPS_SORTING_ERROR = "Algo salió mal al mover %s";
L.RAIDGROUPS_SORTING_FINISHED = "Se terminó de aplicar la lista de incursiones.";
L.RAIDGROUPS_SORTING_GROUPS = "Ordenar grupos";
L.RAIDGROUPS_SORT_BUTTON = "Aplicar grupos";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Ordenar grupos según la lista";
L.RAIDGROUPS_SORT_IN_PROGRESS = "La clasificación aún está en progreso, ¡espera un poco!";
L.RAIDGROUPS_TANKS_ASSIGNED = "Todos los tanques están asignados.";
L.RAIDGROUPS_TANK_BUTTON = "Asignar tanques";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Herramienta de compilación Wowhead";
L.RAIDGROUPS_WOWHEAD_INFO = "Puedes visitar la herramienta de compilación de wowhead usando la URL a continuación. Después de crear tu composición, puedes pegarla aquí o en el campo de edición grande de la ventana del grupo Gargul.";
L.REMOVE_BID = "Eliminar oferta";
L.RESET_SETTINGS = "Reiniciar ajustes";
L.RESET_SETTINGS_CONFIRMATION = "¿Estás seguro de que quieres restablecer todas las configuraciones de Gargul? ¡Esto no se puede deshacer!";
L.RESET_UI = "Restablecer la interfaz de usuario de Gargul";
L.RESET_UI_CONFIRMATION = "¿Está seguro de que desea restablecer todos los tamaños, posiciones y escalas de las ventanas de Gargul? ¡Esto no se puede deshacer!";
L.RESTORE = "Restaurar";
L.RESUME = "Reanudar";
L.RIGHT_SYMBOL = ">";
L.ROLL = "Rollo";
L.ROLLING_AWARD_CONFIRM = "¿Otorgar %s a %s?";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Cerrar la adjudicación";
L.ROLLING_CLOSE_ON_START_LABEL = "Cerrar al inicio";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Mantenga presionado el turno para omitir la confirmación del premio";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Mantenga presionado el turno para mostrar la confirmación del premio.";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
Advertencia: se encontró otra tirada idéntica que puede indicar un empate

]];
L.ROLLING_INVALID_START_DATA_WARNING = "¡Se proporcionaron datos no válidos para la tirada de inicio!";
L.ROLLING_ITEM_WON_BR_COST = "(BR: %s)";
L.ROLLING_ITEM_WON_GIVEN = "(artículo dado: sí)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(ítem dado: no)";
L.ROLLING_ITEM_WON_OS = "(SO)";
L.ROLLING_NOTE_LABEL = "NOTA";
L.ROLLING_NO_ROLLOFF_WARNING = "No se puede detener la transferencia, no hay ninguna transferencia en curso";
L.ROLLING_PASS_BUTTON = "Aprobar";
L.ROLLING_REOPEN_ROLL_COUNT = "rollos: %s";
L.ROLLING_REOPEN_TOOLTIP = "Abrir ventana de saqueador maestro";
L.ROLLING_ROLL_ACCEPTED = "Rollo aceptado!";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "Actualmente hay una tirada en curso.";
L.ROLLING_ROLL_PRIOLIST = "Prioridad [%s]";
L.ROLLING_ROLL_SR_COUNT = "SR [%sx]";
L.ROLLING_ROLL_WISHLIST = "Deseo [%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "Primero debes seleccionar un jugador.";
L.ROLLING_TIMER_LABEL = "TEMPORIZADOR(es)";
L.ROLLING_UNUSABLE_ITEM = "¡No puedes usar este artículo!";
L.ROLLING_WINNER_NOT_UNIQUE = "El nombre del ganador no es único, seleccione el jugador al que le gustaría otorgar %s";
L.SECONDS_ABBR = "s";
L.SELECT_ALL = "Seleccionar / Desactivar todo";
L.SESSION = "Sesión";
L.SETTINGS = "Ajustes";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Anunciar ofertas entrantes";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Anunciar el bote después de otorgar el artículo";
L.SETTINGS_ANNOUNCE_START = "Anunciar el inicio de la subasta";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Anunciar cuenta atrás en aviso de incursión";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Anunciar ofertas entrantes en advertencia de incursión";
L.SETTINGS_RESET_UI = "Restablecer la interfaz de usuario de Gargul";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Pujador en voz baja si la oferta es demasiado baja";
L.SILVER_INDICATOR = "s";
L.SKIP = "Saltar";
L.SOFTRES = "Reservas blandas";
L.SOFTRES_ABBR = "SR";
L.SOFTRES_BROADCAST_CONFIRM = "¿Estás seguro de que deseas transmitir tus datos de softres a todos los miembros de tu grupo/incursión?";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "No se pudieron procesar los datos de SoftRes recibidos de %s";
L.SOFTRES_CLEAR_CONFIRM = "¿Está seguro de que desea borrar todos los datos de reserva temporal existentes?";
L.SOFTRES_EVERYONE_RESERVED = "Todos llenaron sus reservas blandas.";
L.SOFTRES_FEATURE_MISSING = [[
La información sobre reservas físicas no está disponible porque las reservas blandas
proporcionados no se generaron usando el botón 'Exportar Gargul' en softres.it]];
L.SOFTRES_IMPORT_DETAILS = "Importado el |c00A79EFF%s en |c00A79EFF%s";
L.SOFTRES_IMPORT_FIXED_NAME = "Corrección automática de nombres: el SR de '%s' ahora está vinculado a '%s'";
L.SOFTRES_IMPORT_INFO = "Para comenzar, primero debes crear una redada en softres.it. Luego haga clic en 'Exportar complemento', seleccione 'Gargul', copie los datos y péguelos en el formulario a continuación.";
L.SOFTRES_IMPORT_INVALID = "Se proporcionaron datos de reserva flexible no válidos";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Se proporcionaron datos no válidos. Asegúrese de hacer clic en el botón 'Exportar Gargul' en softres.it y pegar el contenido completo aquí";
L.SOFTRES_IMPORT_NEW_PLUSONES = "Los valores de PlusOne proporcionados chocan con los que ya están presentes. ¿Quiere reemplazar sus antiguos valores PlusOne?";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "Los siguientes jugadores no reservaron nada:";
L.SOFTRES_IMPORT_SUCCESSFUL = "Reservas blandas importadas con éxito";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "¡Importación exitosa!";
L.SOFTRES_IMPORT_USE_GARGUL = "Los datos de SoftRes Weakaura y CSV están obsoletos; ¡use la exportación Gargul en su lugar!";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "No se pudo conectar a LootReserve, comuníquese con el soporte (incluya el mensaje a continuación)";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "No hay ninguna URL de softres.it disponible, asegúrese de exportar usando el botón 'Exportar Gargul' en softres.it.";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "Haga clic aquí para ver información sobre reservas definitivas";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "No hay artículos reservados";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "No hay información de reserva dura disponible";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "Publicar SR faltantes";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "Publicar URL SR";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "¡Este jugador no reservó nada!";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "Intentando procesar datos SoftRes entrantes de %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "Este artículo está reservado";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "Para: %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Nota: %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Reservado por";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "¡Algo salió mal!";
L.START = "Comenzar";
L.STOP = "Detener";
L.TAB_REPLACES_T = "	 is replaced by a tab";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "Tiempo";
L.TITLE = "Título";
L.TMBETC = "TMB, DFT o PRIO3";
L.TMB_BROADCAST_CONFIRM = "¿Estás seguro de que quieres transmitir tus datos de TMB a todos los miembros de tu grupo/incursión? NB: ¡TODOS pueden ver tus datos de TMB independientemente de sus permisos en el sitio web de TMB!";
L.TMB_BROADCAST_PROCESS_START = "Intentando procesar datos TMB entrantes de %s";
L.TMB_CLEAR_CONFIRM = "¿Está seguro de que desea borrar todos los datos más uno?";
L.TMB_CLEAR_RAIDER_DATA = "Borrar datos de asaltante";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "¿Borrar datos de TMB para todos los asaltantes?";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "Compartir automáticamente habilitado: %s";
L.TMB_IMPORT_CPO_INFO = "En su ejecución de classicpr.io, haga clic en el botón 'Exportar Gargul' y copie el contenido. Luego pegue el contenido tal cual en el cuadro a continuación y haga clic en 'Importar'. ¡Eso es todo!";
L.TMB_IMPORT_DETAILS = "Importado el ${date} a las ${time}";
L.TMB_IMPORT_DFT_INFO = "Exporte sus datos DFT según las instrucciones de la hoja. Luego pegue el contenido tal cual en el cuadro a continuación y haga clic en 'Importar'. ¡Eso es todo!";
L.TMB_IMPORT_INVALID_CSV = "CSV proporcionado no válido, el formato es: 6948,jugador1,jugador2";
L.TMB_IMPORT_INVALID_DFT = "Se proporcionaron datos DFT no válidos. Exporte sus datos DFT según las instrucciones de la hoja y pegue el contenido aquí tal como está.";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Se proporcionaron datos de TMB no válidos, asegúrese de hacer clic en el botón 'Descargar' en la sección Gargul y pegue el contenido aquí tal como está.";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Se proporcionaron datos TMB o DFT no válidos. Asegúrese de pegar el contenido de exportación aquí tal como está.";
L.TMB_IMPORT_NOTES_AVAILABLE = "Notas prioritarias disponibles: %s";
L.TMB_IMPORT_NUMBER = "Número de artículos importados: %s";
L.TMB_IMPORT_PLAYER_NO_DATA = "Los siguientes jugadores no tienen %s entradas:"; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "Cómo utilizar Gargul con TMB";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "Pegue el contenido de exportación de TMB tal como está en el cuadro a continuación y haga clic en 'Importar'";
L.TMB_NO_BROADCAST_TARGETS = "No hay nadie en tu grupo para transmitir";
L.TMB_SYNCED = "Datos TMB sincronizados";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF Nota: |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(SO)";
L.TMB_TOOLTIP_PRIO_HEADER = "%s lista de prioridades"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF Nivel: %s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "Lista de deseos de TMB";
L.TOGGLE_DATES = "Mostrar/Ocultar fechas";
L.TOGGLE_QUEUE = "Mostrar/ocultar cola";
L.TRADETIME_AWARD_HOWTO = "¡%s para otorgar botín!";
L.TRADETIME_ROLL_HOWTO = "¡%s para lanzar el botín!";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "Ocultar todos los artículos premiados";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "Ocultar elementos desencantados";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "Ocultar artículos otorgados a uno mismo";
L.TRADE_ANNOUNCE = "anunciar comercio";
L.TRADE_ANNOUNCE_INFO = "Anuncie los detalles comerciales al grupo o en /say cuando no esté en un grupo";
L.TUTORIAL = "Tutorial";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s artículos en bolsas, ventanas de botín o incluso en enlaces en tu chat para agregarlos a la cola de subasta.
¿Quiere vender directamente un artículo sin pujar? Utilice |c00A79EFF%s

Puede abrir la ventana %s directamente escribiendo |c00A79EFF/gl subasta

Gargul rastrea |c00FF0000TODO el oro comercializado. ¿No quieres que una operación sea parte de esta sesión de GDKP? ¡Marque la casilla de verificación 'Excluir de GDKP' cuando opere!

|c00FFF569¿Lo sabías?
Los artículos premiados se agregarán automáticamente a la ventana de intercambio.
Gargul también puede encargarse del saqueo automático por ti. Compruébalo con |c00A79EFF/gl pm
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
Esta ventana muestra todos los artículos que se han otorgado en una fecha determinada (seleccione una o más fechas a la izquierda).

Los artículos pueden contener las siguientes etiquetas:

|c00A79EFFOS: Otorgado por fuera de especificación
|c00A79EFFSR: Este elemento fue reservado temporalmente
|c00A79EFFWL: Este artículo fue incluido en la lista de deseos (Thatsmybis)
|c00A79EFFPL: Este elemento fue priorizado (Thatsmybis, DFT, prio3)
]];
L.TUTORIAL_BIDDER_QUEUE = [[
Los elementos que ves aquí están en la cola GDKP del maestro saqueador.
Puede eliminarlos, ofertar por ellos y ocultar elementos inutilizables (habilite 'Ocultar elementos inutilizables' en la configuración en la parte superior izquierda)

Puede cambiar el tamaño de la ventana, moverla o minimizarla. ¡Pruébalo!

Para los maestros del botín: ¡eliminar elementos aquí solo los eliminará de su cola personal, no de la cola GDKP real!
]];
L.TUTORIAL_MORE_HELP = "Necesitas más ayuda?";
L.TYPE = "Tipo"; -- As in type of roll or type of item
L.UNKNOWN = "desconocido";
L.UNKNOWN_COMM_ACTION = "Acción de comunicación desconocida '%s', ¡asegúrate de actualizar Gargul!";
L.UNLOCK = "desbloquear";
L.UPDATE_GARGUL = "¡Actualiza Gárgul!";
L.VERSION_ABBR = "v";
L.VERSION_CHECK_BUTTON_REPORT = "Informe";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Informar resultados obsoletos en el chat grupal";
L.VERSION_CHECK_COLUMN_STATUS = "Estado de gárgola";
L.VERSION_CHECK_STATUS_CHECKING = "Comprobando versión...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s: el reproductor está actualizado
|c00F7922Ev%s: el jugador necesita actualizar sus complementos
|c00BE3333%s: el reproductor no tiene Gargul o está en una versión no compatible
|c00808080%s: ¡el jugador está desconectado o nos está ignorando!
|c0000FFFF%s: ¡el jugador está en nuestra lista de ignorados!

]];
L.VERSION_CHECK_STATUS_IGNORED = "¡JUGADOR IGNORADO!";
L.VERSION_CHECK_STATUS_OFFLINE = "Desconectado";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "Ninguna respuesta";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "Ninguna respuesta:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Desconectado:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "Anticuado:";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "A hoy:";
L.VERSION_INCOMPATIBLE_WARNING = "¡Gargul está desactualizado y no funcionará hasta que actualices!";
L.VERSION_INVALID_WARNING = "Cadena de versión no válida proporcionada en Versión:addRelease";
L.VERSION_UPDATE = "¡Actualiza Gárgul!";
L.VERSION_UPDATED = "|c00%sGargul ahora está actualizado a |c00%sv%s";
L.VERSION_UPDATE_AVAILABLE = "v|c00A79EFFv%s está disponible en CurseForge/Wago. Puedes actualizar sin cerrar el juego, ¡solo asegúrate de /recargar!";
L.WAIT_SECONDS_BEFORE_RETRY = "Espere %s segundos más antes de volver a intentarlo";
L.WINDOW = "Ventana";
L.WINDOW_HEADER = "Gárgola v%s";
L.WINDOW_SCALE = "Escala de ventana";
L.WISHLIST_ABBR = "WL";
L.YES = "Sí";
L.YOU_DISABLED_GDKP_QUEUES = "Deshabilitaste las colas de GDKP";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "No se pueden comprimir los datos con zlib. Póngase en contacto con el soporte a través de https://discord.gg/D3mDhYPVzf";
L.ZLIB_DECOMPRESS_WARNING = "No se pueden descomprimir zlib los datos. ¡Asegúrese de copiarlo y pegarlo tal como está sin agregar caracteres ni espacios en blanco adicionales!";
