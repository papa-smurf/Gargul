--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "deDE") then return; end
local L = Gargul_L or {};

L.ABOUT = "Über";
L.ALL_SETTINGS = "Alle Einstellungen";
L.ANNOUNCE = "Bekannt geben";
L.ANTISNIPE = "Anti-Snipe";
L.ANTISNIPE_EXPLANATION = [[

Ein Anti-Snipe-Wert von 10 bedeutet, dass jedes eingehende Gebot mit
weniger als 10 Sekunden verbleibend auf einen Timer von 10 Sekunden zurückgesetzt wird.

Du kannst dieses Feld leer lassen oder auf 0 setzen, um Anti-Snipe vollständig zu deaktivieren.
Anti-Snipe-Werte unter 5 werden nicht unterstützt

]];
L.ARE_YOU_SURE = "Bist du sicher?";
L.ASSIGN_GARGUL_INFO = [[
Vergiss nicht, stattdessen Gargul zu verwenden
wenn du die Beute später exportieren möchtest


-- Klick mit der rechten Maustaste, um dieses Fenster zu deaktivieren --]];
L.AUCTION = "Auktion";
L.AUCTIONEER = "Auktionator";
L.AUCTIONS = "Auktionen";
L.AUTO = "Auto";
L.AUTO_AWARD = "Auto-Verleihung";
L.AUTO_TRADE_OPTIONS = "Autohandel";
L.AVAILABLE_PLACEHOLDER_VALUES = "Verfügbare Werte:";
L.AWARD = "Verleihen";
L.AWARDED_TO = "Ausgezeichnet für";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "BR: %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Preise";
L.AWARDED_TOOLTIP_GIVEN = "Gegeben: ja";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Gegeben: nein";
L.AWARDED_TOOLTIP_SECOND_BID = "2. Gebot: %s von %s";
L.AWARDED_YOU_WON = "Du hast gewonnen";
L.AWARD_CONFIRM = "%s an %s verleihen?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "Bist du sicher, dass du %s entzaubern möchtest? %s geboostete Rollpunkte werden zurückerstattet!";
L.AWARD_HEADER_IN_GROUP = "In einer Gruppe";
L.AWARD_HISTORY = "Verleihungsverlauf";
L.AWARD_NEW_WINNER_CONFIRMATION = "Zu wem sollte %s stattdessen gehen?";
L.AWARD_PLAYER_CUSTOM_NAME = "Gib hier den Namen des Spielers ein";
L.AWARD_PLAYER_SELECT_NAME = "oder wähle unten einen aus";
L.AWARD_RANDOM_CONFIRM = "Möchtest du %s an einen zufälligen Spieler verleihen?";
L.AWARD_TOOLTIP_ADD_ITEM = "Zieh ein Element per Drag-and-Drop oder bei gedrückter Umschalttaste in das Feld rechts";
L.AWARD_TOOLTIP_BR_INDICATION = "(BR: %s)";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Entzauberte Gegenstände:";
L.AWARD_TOOLTIP_GIVEN = "(Gegeben: ja)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(Gegeben: nein)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(Betriebssystem)";
L.AWARD_UNDO_BR_REFUND = "%s geboostete Rollpunkte werden zurückerstattet!";
L.AWARD_UNDO_CONFIRM = "Bist du sicher, dass du %s, das %s zugeteilt wurde, rückgängig machen möchtest?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "Tascheninspektion fehlgeschlagen: Keine Berichte erhalten";
L.BAGINSPECTOR_FINISHED = "Inspektion beendet";
L.BAGINSPECTOR_START = "Inspektion beginnt...";
L.BALANCE = "Saldo";
L.BASE = "Basis";
L.BASE64_DECODE_WARNING = "Die Base64-Dekodierung der Daten ist nicht möglich. Stell sicher, dass du es unverändert kopiert/eingefügt hast, ohne zusätzliche Zeichen oder Leerzeichen hinzuzufügen!";
L.BID = "Bieten";
L.BIDS = "Gebote";
L.BIND_ON_EQUIP_ABBR = "BOE";
L.BONUS_AUTO_INVITE = "1. Gruppen automatisch aus der Raid-Anmeldung einladen/sortieren! Klick unten oder verwende |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. Belohne Spieler dafür, dass sie Stammspieler sind oder die Extrameile gehen! Klick unten oder verwende |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "Gargul hat ein paar Tricks auf Lager, die dir vielleicht nicht bewusst sind. Schau mal rein!";
L.BONUS_PLUSONES = "3. Gargul beinhaltet ein Plus-One-Tracking-System! Klick unten oder verwende |c00A79EFF/gl po";
L.BOOSTED_ROLLS = "Boosted Rolls";
L.BOOSTED_ROLLS_ABBR = "BR";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
Wie viele Punkte addierst du für alle, die derzeit am Raid teilnehmen?

|c00BE3333Verwende zuerst die Schaltfläche „Fehlende Raider hinzufügen“, wenn du möchtest, dass jeder Punkte erhält, auch diejenigen ohne einen Boosted-Rolls-Eintrag!]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "Kein Punktewert angegeben!";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Füge dem Raid Punkte hinzu";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Fehlende Raider hinzufügen";
L.BOOSTED_ROLLS_ALIASES = "Aliase";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Aliase anwenden";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Erhöhte Rollkosten:";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "Bist du sicher, dass du deine Boosted-Rolls-Daten an alle in deiner Gruppe/deinem Raid übertragen möchtest?";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "Nichts zum Senden, importiere zuerst die Boosted-Rolls-Daten!";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "Die von %s empfangenen Boosted-Rolls-Daten konnten nicht verarbeitet werden";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Es wird versucht, eingehende Boosted-Rolls-Daten von %s zu verarbeiten";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "Bist du sicher, dass du alle Boosted-Roll-Daten löschen möchtest?";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "%s löschen?";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "Bist du sicher, dass du deine bestehenden Boosted-Roll-Daten löschen und neue, von %s gesendete Daten importieren möchtest?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Ungültige Daten angegeben. Stell sicher, dass der Inhalt dem erforderlichen Format entspricht und keine Kopfzeile enthalten ist";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
Hier kannst du Boosted-Roll-Daten und Aliase aus einer Tabelle im CSV- oder TSV-Format importieren oder aus einem Google Docs-Blatt einfügen.

Die Tabelle benötigt mindestens zwei Spalten: Den Spielernamen gefolgt von der Punktzahl. Zusätzliche Spalten sind optional und können Aliase für den Player enthalten.
Hier ist eine Beispielzeile:

Foobar,240,Barfoo]];
L.BOOSTED_ROLLS_POINTS = "Punkte";
L.BOOSTED_ROLLS_RESERVE = "Reserviert";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
Bist du sicher, dass du deine bestehenden Boosted-Rolls-Daten von %s aktualisieren möchten?

Dein letztes Update war |c00A79EFF%s, ihres |c00A79EFF%s.]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!bonus|!rb|!br";
L.BROADCAST = "Übertragung";
L.BROADCASTING_NOTIFICATION = "Sende Übertragung...";
L.BROADCAST_DELAYED_BY_COMBAT = "Du befindest dich derzeit im Kampf und verzögerst die Übertragung";
L.BROADCAST_FINISHED = "Übertragung beendet!";
L.BROADCAST_INC_AWARDED = "Beziehe verliehene Gegenstände mit ein";
L.BROADCAST_INC_DISENCHANTED = "Schließe entzauberte Gegenstände ein";
L.BROADCAST_INC_HIDDEN = "Schließe ausgeblendete Gegenstände ein";
L.BROADCAST_INC_TIME_LEFT = "Berücksichtige die verbleibende Zeit";
L.BROADCAST_IN_PROGRESS_ERROR = "Die Übertragung läuft noch";
L.BROADCAST_NO_DATA = "Es gibt nichts zu senden";
L.BROADCAST_NUMBER_OF_ITEMS = "Anzahl der Gegenstände";
L.BROADCAST_PROGRESS = "Übertragung ${percentage}%";
L.BROADCAST_TARGET_PLAYER = "Zielspieler (nur Flüstern)";
L.BROADCAST_TARGET_REQUIRED = "Flüstern erfordert einen Zielspieler";
L.BROADCAST_TRADE_TIME_LEFT = "Maximal verbleibende Handelszeit (in Minuten)";
L.BY = "von"; -- As in 'bid BY'
L.CANCEL = "Abbrechen";
L.CHANGELOG_CONTRIBUTE = "Suche dir Hilfe oder teile deine Ideen auf unserem Discord";
L.CHANGELOG_ENABLE_LABEL = "Änderungsprotokoll aktivieren";
L.CHANGELOG_GETTING_STARTED = "Gargul macht das Verteilen von Beute ganz einfach. Klick auf die Schaltfläche unten, um loszulegen!";
L.CHANGELOG_OPEN_GARGUL = "Öffne Gargul";
L.CHANGE_SCALE = "Maßstab anpassen";
L.CHANNEL = "Kanal";
L.CHANNEL_OFFICER = "Offizier";
L.CHANNEL_RAID_WARNING = "Raid-Warnung";
L.CHANNEL_WHISPER = "Flüstern";
L.CLASSICPRIO_ABBR = "CPR";
L.CLEAR = "Leeren"; -- As in clearing a window or data
L.CLOSE = "Schließen";
L.CLOSE_ON_AWARD = "Bei Verleihung schließen";
L.CLOSE_ON_START = "Beim Starten schließen";
L.COMMUNICATION = "Kommunikation";
L.COMM_PROGRESS = "%s von %s Bytes wurden gesendet";
L.COPPER_INDICATOR = "C";
L.CUT = "Anteil";
L.CUTS = "Anteile";
L.CUT_MAILBOX_CLOSED = "Es kann keine Post gesendet werden, wenn der Briefkasten geschlossen ist";
L.CUT_MAILS_FAILED = "Es wurden mehrere Post-Fehler festgestellt, wodurch die Verteilung der Anteile abgebrochen wurde";
L.CUT_MAIL_BODY = "Powered by Gargul: ein Master-Loot-Tool mit Unterstützung für TMB, SoftRes, GDKP und Auto-Looting!";
L.CUT_MAIL_EVEN = "Du schuldest %s kein Gold";
L.CUT_MAIL_FAILED = "Der Anteil konnte nicht an %s gesendet werden";
L.CUT_MAIL_GOLD_MISMATCH = "Die Post wurde laut Spiel GESENDET, aber dein verbleibendes Gold stimmt nicht überein. Ist etwas schief gelaufen?";
L.CUT_MAIL_HISTORY = "Post-Verlauf für |c00967FD2%s";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "Du hast nicht genug Gold, um %s zu bezahlen";
L.CUT_MAIL_IN_PROGRESS = "Warte etwas, wir bearbeiten noch die vorherige Post";
L.CUT_MAIL_SUBJECT = "Gargul GDKP: %sg";
L.CUT_SENT = "%sg an %s gesendet";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "Löschen";
L.DETAILS = "Details";
L.DFT = "DFT";
L.DISABLE = "Deaktivieren";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "Entzaubern";
L.EDIT = "Bearbeiten";
L.ENABLE = "Aktivieren";
L.EXPORT = "Export";
L.EXPORT_DELETE_ALL_CONFIRM = "Bist du sicher, dass du deinen vollständigen Verleihungsverlauf entfernen möchtest? Dadurch werden ALLE Beutedaten gelöscht und können nicht rückgängig gemacht werden!";
L.EXPORT_DELETE_DATE_CONFIRM = "Bist du sicher, dass du alle Daten für %s entfernen möchtest? Das kann nicht rückgängig gemacht werden!";
L.EXPORT_READ_ONLY_NOTICE = [[
Dies ist NUR eine Exportfunktion. Es macht keinen Sinn, die Werte zu bearbeiten: SIE WERDEN NICHT GESPEICHERT!

]];
L.FILL = "Füllen";
L.FINAL_CALL = "Letzter Aufruf";
L.FINISH = "Beenden";
L.FORMAT = "Format";
L.GARGUL = "Gargul";
L.GDKP = "GDKP";
L.GDKPS_ARE_NOT_ALLOWED = "GDKP-Raids sind in dieser Version von World of Warcraft nicht erlaubt";
L.GDKP_ACTIVATED = "GDKP Aktiv!";
L.GDKP_ADD_DROPS_TO_QUEUE = "Füge neu gedroppte Beute zur Warteschlange hinzu";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "Gold (- zum Entfernen von Gold)";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "Wer bezahlt das?";
L.GDKP_ADD_GOLD_INVALID_WARNING = "Gold muss niedriger/höher als 0 sein";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "Bezahlt von";
L.GDKP_ADD_GOLD_TITLE = "Gold in %s anpassen";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "Du kannst nicht gleichzeitig demselben Spieler Gold geben UND erhalten";
L.GDKP_ALL_CUTS_MAILED = "Alle Anteile wurden per Post verschickt!";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "Deaktivieren für entzauberte Gegenstände";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "Im Kampf deaktivieren";
L.GDKP_AUCTIONS = "Auktionen";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "Erstellt von";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333Gelöscht von %s
Gründe dafür]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg von %s zum Pott hinzugefügt
Anmerkungen]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s hat |c00%s%sg dafür bezahlt
%s]];
L.GDKP_AUCTION_DETAILS_WON_BY = "Gewonnen von";
L.GDKP_AUCTION_PAID_AMOUNT = "Bezahlten Betrag festlegen (siehe links)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul behält automatisch den Überblick über das gehandelte Gold. Solange die Spieler für das zahlen, was sie gekauft haben, solltest du dieses Feld niemals benötigen

„Bezahlter Betrag“ bezieht sich auf die Goldmenge, die dir der Käufer bereits im Handel gegeben hat.
Der tatsächliche Preis des Gegenstandes ändert sich dadurch nicht!

Achtung: Leg hier nur einen Wert fest, wenn der Spieler eine Zahlung außerhalb des Raids verspricht
oder das Gold von einem Alt / per Post usw. handelt!


]];
L.GDKP_AWARD_DIALOG_LABEL = "GDKP-Preis:";
L.GDKP_AWARD_ITEM_CONFIRMATION = "%s an %s für %s verleihen?";
L.GDKP_BIDDER_AUTO_BID = "Auto Bieten";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "Wie hoch ist dein Höchstgebot? (Minimum %s|c00FFF569g)";
L.GDKP_BIDDER_BID_DENIED = "Gebot abgelehnt!";
L.GDKP_BIDDER_ITEM_PRICING = "Mindestgebot: %sg Inkrement: %sg";
L.GDKP_BIDDER_MY_MAX_BID = "(maximal %sg)";
L.GDKP_BIDDER_NEW_BID_LABEL = "Neues Gebot";
L.GDKP_BIDDER_STOP_AUTO_BID = "Stop Auto";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "Höchstgebot: %s von %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "Höchstgebot: %s von Dir";
L.GDKP_CREATE = "Erstell eine neue GDKP-Sitzung";
L.GDKP_CREATE_MANAGEMENT_CUT = "Managementanteil %";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Managementanteil muss leer sein oder zwischen 0 und 99 liegen (kein %-Zeichen!)";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "Wähl einen Sitzungstyp!";
L.GDKP_CREATE_SESSION_SWITCH = "Wechsel zu dieser Sitzung";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFMehrfachauktion ermöglicht es dir, Gebote für mehrere Gegenstände gleichzeitig abzugeben, was die Sache beschleunigt!
Befolge die Anweisungen nach dem Erstellen dieser Sitzung, um zu beginnen

Mit |c00A79EFFEinzelauktion kannst du stattdessen einzelne Gegenstände versteigern oder die Warteschlange benutzen

Durch die Auswahl von |c00A79EFFMehrfachauktion wird verhindert, dass gedroppte Gegenstände zur Warteschlange hinzugefügt werden
Du kannst |c00A79EFFMehrfachauktion mit |c00A79EFFEinzelauktion und der Warteschlange kombinieren, wir raten jedoch dringend davon ab

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "Auktionstyp (|c00A79EFFi für weitere Informationen)";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "Mehrfachauktion";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "Einzelauktion";
L.GDKP_CREATE_SUCCESSFUL = "Sitzung erstellt. Wir empfehlen dir, /reload zu verwenden, damit es vernünfitg gespeichert wird, falls dein Spiel abstürzt!";
L.GDKP_CUTS_ADD_RAIDER = "Raider hinzufügen";
L.GDKP_CUTS_ADJUST_G = "anpassen [g]";
L.GDKP_CUTS_ADJUST_P = "anpassen [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "Kündige den Basisanteil im Gruppenchat an";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "Bist du sicher, dass du alle Spieler und Berechnungen zurücksetzen möchtest? Hinweis: Alle Spieler, die nicht mehr am Raid teilnehmen, werden aus der Liste entfernt!";
L.GDKP_CUTS_DELETE_RAIDER = "Raider löschen";
L.GDKP_CUTS_EDIT_RAIDER = "Raider bearbeiten";
L.GDKP_CUTS_LOCK_TOOLTIP = "Abschließen und bezahlen";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "Verwalte Goldhandel";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

Mit Mutatoren kannst du den Spielern mehr oder weniger Gold geben
Beispiel: Mutatoren sind dafür gedacht, Tanks 2 % mehr zu geben!

Hinweis: Wenn Sie Mutatoren hier bearbeiten oder löschen, werden sie nur für diese Sitzung geändert

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "Nicht im Raid";
L.GDKP_CUTS_POT_EXPLANATION = [[

Die Gesamtauszahlung kann aufgrund von Rundungsdifferenzen geringfügig vom Pott abweichen!
Spieler, die sich derzeit im Raid befinden, können nicht bearbeitet oder entfernt werden!

Color explanation:
|c00F7922E(2000g) Bedeutet du schuldest dieser Person 2000g
|c00BE3333(3000g) Bedeutet diese Person schuldet dir 3000g
|c0092FF00(0) Bedeutet ihr seid quitt

Erklärung der Anpassungen:
Mit Anpassen [g] kannst du einem Spieler Gold hinzufügen/abziehen (verwende -50, um 50 Gold vom Anteil eines Spielers abzuziehen).
Mit Anpassen [%] kannst du einem Spieler einen Prozentsatz hinzufügen/abziehen (verwende -50, um den Spielern einen halben Anteil zu geben).
]];
L.GDKP_CUTS_SUMMARY = "%s Raiders | %s Mit Anteil | Gesamtauszahlung: %sg";
L.GDKP_CUT_IMPORT_EMPTY = "Es gibt nichts zu importieren. Überprüfe deine CSV-Datei noch einmal";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Es fehlt Gold für Spieler %s";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "Fehlender Header, Hinweis: Groß-/Kleinschreibung wird beachtet!";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Fehlender Spielername";
L.GDKP_DELETE_BID_INFO = "Gebot löschen. Die Auktion muss zuerst gestoppt werden!";
L.GDKP_DISTRIBUTE_ADDRAIDER = "Füge dieser Sitzung einen Raider hinzu";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "Benutzerdefiniert (erstell dein eigenes Format)";
L.GDKP_EXPORT_AUCTIONS_JSON = "Detailliert (JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "Teilen (kann von anderen Spielern importiert werden)";
L.GDKP_EXPORT_CUSTOM_FORMAT = "Dein individuelles Format";
L.GDKP_EXPORT_CUSTOM_HEADER = "Dein benutzerdefinierter Header";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Benutzerdefiniert (erstell dein eigenes Format)";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@PLAYER,@CUT";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "Spieler, Anteil";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "Datum/Uhrzeit, zu der die Sitzung gesperrt wurde";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "Gesamtgold, das dem Spieler gegeben wurde";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "Gold wird dem Spieler per Post zugesandt";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "Gesamtgold, das der Spieler erhalten hat";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "Datum/Uhrzeit der Verleihung des ersten Gegenstandes";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "Gold wird an den Spieler gehandelt";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "Gegenstand, Spieler, Gold, Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "Datum/Uhrzeit der Verleihung des ersten Gegenstandes";
L.GDKP_EXPORT_FORMAT_TITLE = "Der Titel der GDKP-Sitzung";
L.GDKP_EXPORT_INCLUDE_DISENCHANTED = "Schließe entzauberte Gegenstände mit ein";
L.GDKP_EXPORT_POT_CHANGED = "Pott gewechselt";
L.GDKP_GOLD_TRADES = "Goldhandel";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "Bist du sicher? Du kannst kommende Gegenstände nicht sehen oder darauf bieten!";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!! ACHTUNG !!|r

Du befindest dich auf einem verbundenen Realm und importierst Spielernamen ohne
einen Bereichssuffix, zum Beispiel „%s“. Dies kann dazu führen, dass du
Anteile und Post mit Anteilen an den falschen Spieler sendest.

Wenn du dich auf einem verbundenen Realm befindest, versuch immer, den Realmnamen der Spieler anzugeben!

Mit dem Import fortfahren?
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "Dadurch werden alle Änderungen überschrieben, die du am Anteilfenster vorgenommen hast. Bist du sicher?";
L.GDKP_IMPORT_CUTS_INFO = [[
Du kannst Spieleranteile aus deinen eigenen Berechnungen wie einem Google Sheet importieren. Softres GDKP usw.

Das Format ist wie folgt (|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333Player,Gold|c00967FD2
Spieler1.4000
Spieler2,4125
Spieler3.3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
Importiere GDKP-Mindestpreise und -inkremente.

Das Format ist wie folgt: ItemID + Minimum oder Inkrement sind erforderlich. (|c00BE3333ERFORDERT EINEN HEADER!!):

|c00BE3333ItemID,Minimum,Inkrement|c00967FD2
18608.4000.500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "Vorhandene Preiseinstellungen löschen? Klick auf „Ja“, um alle Preisdaten zu löschen, und auf „Nein“, um vorhandene einfach mit den von dir hier angegebenen Daten zu überschreiben";
L.GDKP_IMPORT_SESSION = "GDKP-Sitzung importieren";
L.GDKP_IMPORT_SESSION_ABOUT = "Hier kannst du eine GDKP-Sitzung importieren (und fortsetzen). Um eine GDKP-Sitzung von jemandem zu erhalten, muss er sie in |c00FFF569/gdkp exportieren und dort das Format „Teilen (kann von anderen Spielern importiert werden)“ auswählen";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "Du bist dabei, eine von %s erstellte GDKP-Sitzung zu importieren. Bist du sicher?";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "Diese von %s erstellte GDKP-Sitzung scheint bereits zu existieren. Möchtest du sie überschreiben?";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "Ungültige Daten für die GDKP-Erweiterung angegeben!";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "Ungültige Daten für GDKP-Umplanung angegeben!";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "Ungültige Daten zur GDKP-Verkürzung angegeben!";
L.GDKP_INVALID_DATA_FOR_START = "Ungültige Daten für GDKP-Auktionsstart angegeben!";
L.GDKP_INVALID_PAID_AMOUNT = "Ungültige Nummer für „bezahlt“ angegeben";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "In „Auktion: Umplanung“ wurde eine ungültige Zeit angegeben";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP Daten (verkauft %sx)
Zuletzt verkauft für: %s
Durchschnittspreis: %s
Mindestgebot: %s
Anteile

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "Saldo: |c0092FF000 ? Du bist quitt! | |c00BE333330 ? Du schuldest %s 30g | |c00F7922E50 ? %s schuldet dir 50g";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "Gold wurde dir von %s zugesandt";
L.GDKP_LEDGER_LEGEND_PAID_TO = "Gold wurde an %s gezahlt";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "Gold von %s erhalten";
L.GDKP_LEDGER_MUTATION = "Gold %s von"; -- %s = removed or added
L.GDKP_LEDGER_POT = "Gesamtpott: %sg | Managementanteil: %sg (%s%%) | Zu verteilen: %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s | Von %s%s | Am |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "Die GDKP-Sitzung ist nicht verfügbar oder gesperrt";
L.GDKP_MAIL_ALL = "Sende Post an alle";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "Keine Gebote für Legendary+-Artikel gefunden, manuell fortfahren!";
L.GDKP_MISSING_CONTENT_FOR_START = "Fehlender Inhalt in Auktion:Start";
L.GDKP_MULTIAUCTION_ABOUT = [[

Mit Mehrfachauktionen (oder Batch-Auktionen) kannst du so viele Gegenstände auf einmal versteigern, wie du möchtest!
Dies beschleunigt deine Raidabende enorm und sorgt für ein nahtloses Erlebnis für deine Raider

Alle handelbaren Gegenstände, die sich noch in deinem Inventar befinden, können automatisch mit „Aus Inventar füllen“ versteigert werden.
Versuch es einmal!

|c00808080Es gibt nur einen Nachteil: Damit Raider an einer Mehrfachauktion teilnehmen können, brauchen sie Gargul!

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "Du benötigst eine aktive (entsperrte) GDKP-Sitzung!";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "Wenn dieses Fenster geöffnet ist, füge %s Gegenstände zur Liste hinzu oder klick unten auf „Aus Inventar füllen“."; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Anti-Snipe in Sekunden";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "Der Anti-Snipe-Wert muss 0 (leer) oder >=5 sein";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Geh zurück zur Gegenstandsauswahl";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Entferne alle Elemente aus der Liste";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "Aus Inventar füllen";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Füge handelbare Gegenstände aus deinem Inventar zur Liste hinzu";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Hier legst du fest, welche Artikel du in deine Multiauktionssitzung aufnehmen möchtest

Benutze die Schaltfläche |c00A79EFFAus Inventar füllen unten, um Gegenstände, die noch gehandelt werden können, zur Liste hinzuzufügen
Wenn du dieses Fenster löschst und erneut öffnest, werden deine letzten Fülleinstellungen zum automatischen Hinzufügen von Gegenständen verwendet

|c00A79EFF%s Gegenstände um sie manuell zur Liste hinzuzufügen
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Nächster Schritt: Überprüfe die Add-on-Version der Raider auf Kompatibilität";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "Nicht jeder nutzt Gargul. Bist du sicher, dass du die Auktion starten möchtest?";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Wähle mindestens einen Gegenstand für deine Auktion aus";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Dein Gargul ist veraltet. Wir empfehlen dir das Addon vor Beginn einer Sitzung zu aktualisieren, um Probleme zu vermeiden!";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "Nicht jeder ist auf dem neuesten Stand. Wenn bei dir Probleme auftreten, forde deine Raider auf, ein Update durchzuführen!";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "Es gibt eine aktive Mehrfachauktion. Die hier hinzugefügten Gegenstände werden der bestehenden Sitzung hinzugefügt. Achte auf doppelte Artikel!";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Suche Name oder iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Unterstützt Gegenstandsnamen und iLVL, z. B. '252', '<252' usw";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Aktive GDKP-Sitzung: |c00967FD2%s | Von %s%s | Am |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Auktionszeit in Sekunden";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "Die Auktionszeit in Sekunden muss >= 10 sein";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "Du bist während deiner GDKP-Gebotssitzung gegangen. Um sie fortzusetzen, musst du für alle nicht verkauften Gegenstände eine neue Gebotszeit (in Sekunden) angeben";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "Wenn dieses Fenster geöffnet ist, füge %s Gegenstände der Liste hinzu";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "Klick auf das Zahnradsymbol, um eine Auktion zu verwalten";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "Du bist bereits der Höchstbietende für %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
Gebot |c00%s%sg
Von %s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%sGESCHLOSSEN
Keine Gebote]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
Minimum: |c00%s%sg
Inkrement: |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "Gegenstände: %s – Insgesamt verkauft: %sg – Von mir zugesichert: %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
Gegenstände mit Geboten: %s/%s
Insgesamt verkauft: %s
Von mir gekauft: %s
Gesamtgebot (ohne Verkauf): %s
Von mir geboten (ohne Verkauf): %s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%sVERKAUFT an
%s für |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
Gebot |c00%s%sg
Von |c0092FF00DIR!]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "Das automatische Bieten für %s konnte nicht gestoppt werden. Versuche es erneut oder /reload!";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "Automatisches Gebot bis maximal %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "Automatisches Gebot bis zu dem Gebot, das du links eingibst";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "Stoppe dein automatisches Gebot (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "Das Gebot für %s konnte nicht bestätigt werden";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "Ungültiges oder zu niedriges Gebot! Das Minimum ist %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "Zwischen Geboten für denselben Gegenstand musst du zwei Sekunden warten";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "Leere Gebote";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "Entferne alle Gebote aus der Auktion";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "Alle abschließen";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "ALLE Auktionen abschließen?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
Schließen Sie ALLE Auktionen ab

Auktionen mit aktiven Geboten werden verkauft und können keine neuen Gebote erhalten!
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "Auktion abschließen";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "Schließe die Auktion ab. Spieler können nicht mehr bieten, aber das Höchstgebot bleibt aktiv";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "Entferne den Gegenstand einschließlich seiner Gebotsdetails aus der Auktion. DAS KANN NICHT RÜCKGÄNGIG GEMACHT WERDEN!";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "Alle fertigen, aber nicht verkauften Gegenstände entzaubern?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
Entzaubere nicht verkaufte Gegenstände

Dadurch werden alle nicht verkauften Gegenstände als entzaubert markiert und in einer neuen Mehrfachauktionssitzung nicht angezeigt
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "Favorisiere diesen Gegenstand";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "Gib einen letzten Aufruf- Timer von wie vielen Sekunden an?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "Die Mindestanzahl an Sekunden beträgt 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "Starte einen letzten Aufruf für diese Auktion, indem du einen (normalerweise kürzeren) Gebotstimer angibst";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "ALLE Auktionen abschließen und diese Mehrfachauktionssitzung abschließen?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
Beende die Mehrfachauktionssitzung

Dadurch werden alle Auktionen abgeschlossen und der gesamte Pott im Chat bekannt gegeben
Auktionen mit aktiven Geboten werden verkauft und können keine neuen Gebote erhalten!
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "Inaktive ausblenden";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "Unbrauchbare ausblenden";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "Abgeschlossene Auktionen ein-/ausblenden";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "Auktion verwalten";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "Biete den erforderlichen Mindestbetrag";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "Gebotsfenster geschlossen, mit |c00A79EFF/gl-Gebot wieder öffnen!";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "Kündige verkaufte Gegenstände im Chat an";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "Ton abgespielen wenn überboten";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "Weitere Tonoptionen...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "Zeige alles";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "Favoriten anzeigen";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "Inaktive anzeigen";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "Unbrauchbare anzeigen";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "Dieser Artikel wurde verkauft. Verwende das Register (|c00%s/gdkp), um Änderungen vorzunehmen!";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "Abbrechen";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "Alle Gebote/Gebote entfernen und alle Auktionen schließen?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
Brich die Mehrfachauktionssitzung ab

Dadurch werden alle Gebote auf Gegenstände, die noch nicht verkauft wurden, gelöscht und alle Auktionen geschlossen!
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "Bewege den Mauszeiger über die Knöpfe für weitere Informationen";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "Gegenstände anzeigen/ausblenden, die du nicht verwenden kannst";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "Ungültige Daten für GDKP-Auktionsstart angegeben!";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s hat %s für %sg gekauft";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "Der Plündermeister (%s) ist veraltet, dies kann dazu führen, dass Gebote fehlschlagen!";
L.GDKP_MULTIAUCTION_OUTBID = "Du wurdest überboten!";
L.GDKP_MUTATORS = "Mutatoren";
L.GDKP_MUTATOR_ADD = "Mutator hinzufügen";
L.GDKP_MUTATOR_APPLY_LABEL = "Automatisch anwenden auf";
L.GDKP_MUTATOR_CREATE_NEW = "Erstelle einen neuen GDKP-Mutator";
L.GDKP_MUTATOR_DELETE_BYPASS = "Löschen. Halte die Umschalttaste gedrückt, um die Bestätigung zu umgehen";
L.GDKP_MUTATOR_EDIT = "Mutator bearbeiten";
L.GDKP_MUTATOR_FLAT_LABEL = "Pauschaler Goldpreis [Beispiel: 250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "Bei der Pauschale muss es sich um eine Zahl handeln";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
Beispiel:
|c00967FD2SELF,RL,HEALER]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "Du kannst diesen Mutator mithilfe von Schlüsselwörtern automatisch auf Raider anwenden:";
L.GDKP_MUTATOR_NAME_LABEL = "Name [Beispiel: Heiler]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Mutatornamen dürfen keine Punkte (.) enthalten.";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Prozentsatz [Beispiel: 10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "Der Prozentsatz muss eine Zahl sein";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Für zukünftige Sitzungen speichern";
L.GDKP_MUTATOR_UNKNOWN = "Unbekannter Mutator: %s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "Benutzer „%s“ ist nicht berechtigt, Auktionen zu starten";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "Benutzer „%s“ ist nicht berechtigt, Auktionen zu stoppen";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "Benutzer „%s“ darf die Auktion nicht stoppen: Auktion ungültig";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "Es gibt nicht genug Gold zum Verteilen, rechne mit seltsamen Anteilsberechnungen!";
L.GDKP_NO_BIDS = "Keine Gebote!";
L.GDKP_OUTBID = "Du wurdest überboten!";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(aktiv)";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
Zum Anpassen von Gold musst du Anführer oder Plündermeister sein.
Du kannst Gold für gesperrte/gelöschte Sitzungen nicht anpassen]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "Gold hinzufügen/entfernen";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s hat |c00%s%s bezahlt für
%s]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333Gelöscht von %s
Gründe dafür]];
L.GDKP_OVERVIEW_DELETED_SESSION = "(gelöscht)";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
Zum Löschen von Einträgen musst du Anführer oder Plündermeister sein.
Du kannst keine Einträge in gesperrten/gelöschten Sitzungen löschen]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "Gib einen Grund für das Löschen dieses Eintrags an";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "Löschen. Halte die Umschalttaste gedrückt, um die Notiz zu umgehen";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "Sitzungen mit angehängten Auktionen werden nach 48 Stunden gelöscht";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
Um Einträge zu bearbeiten musst du Anführer oder Plündermeister sein.
Du kannst gelöschte Einträge oder Einträge in gesperrten/gelöschten Sitzungen nicht bearbeiten]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "Exportiere eine Sitzung, damit andere Spieler Sitzungsdetails sehen oder dich sogar als Plündermeister ersetzen können";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "Importiere eine Sitzung von einem anderen Spieler oder Konto";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
Zeige eine vollständige Übersicht über das Register an.
Ideal für Screenshotzwecke!]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "Wenn du eine Sitzung sperrst, kannst du keine Gegenstände versteigern oder auf andere Weise etwas ändern, bis du die Sitzung entsperrst. Bist du sicher?";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "Sperre oder entsperre die Sitzung";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "Sperre die Sitzung für die Auszahlung";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "Mehrfachauktion: Versteigere mehrere Gegenstände gleichzeitig!";
L.GDKP_OVERVIEW_MUTATION_ADDED = "hinzugefügt zu";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s %s Pott von %s
Anmerkungen]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "entfernt von";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
Pott: %s
Managementanteil (%s%%): %sg
Pro Spieleranteil (1/%s): %sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
Um Einträge wiederherzustellen musst du Anführer oder Plündermeister sein.
Einträge gesperrter/gelöschter Sitzungen können nicht wiederhergestellt werden]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "Von %s%s | Am |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "Das Freischalten und Ändern des Potts oder der Anteile kann sehr chaotisch werden, insbesondere wenn du bereits Auszahlungen vorgenommen hast. Bist du sicher?";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "Entsperre die Sitzung";
L.GDKP_PAYOUT_INACTIVE = "Keine aktive GDKP-Sitzung erkannt oder Sitzung ist nicht für die Auszahlung gesperrt!";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "Inkrement bzw. Minimum darf nicht kleiner als .0001 sein!";
L.GDKP_PRICE_IMPORT_INVALID_INC = "Ungültiges „Inkrement“ für Gegenstand-ID „%s“ angegeben";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "Ungültiges „Minimum“ für Gegenstand-ID „%s“ angegeben";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "Für die Gegenstand-ID %s ist entweder ein Minimum oder ein Inkrement erforderlich";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "Fehlender Header, Hinweis: Groß-/Kleinschreibung wird beachtet!";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Daten für %s Gegenstand erfolgreich importiert";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "Unbekannte Gegenstand-ID: %s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s Gegenstände in Taschen, Beutefenstern oder sogar auf Links in deinem Chat, um sie dieser Auktionswarteschlange hinzuzufügen.
Gegenstände in der Warteschlange werden automatisch versteigert, sobald deine aktuelle Auktion abgeschlossen ist. Klick auf die Schaltfläche „%s“, um dies zu verhindern.

Möchtest du, dass Gargul Auktionen automatisch für dich verleiht oder entzaubert? Öffne das Einstellungsrad auf der linken Seite!

|c00FFF569Wusstest du schon?
Du kannst Gegenstände per Drag & Drop verschieben
Gegenstände werden gespeichert, auch wenn du |c00A79EFF/neu lädst
In der Warteschlange befindliche Gegenstände werden Raidern, die über Gargul verfügen, automatisch angezeigt, damit sie vorab bieten können
Gargul kann auch das automatische Plündern für dich übernehmen. Probier es mit |c00A79EFF/gl pm aus
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Blende unbrauchbare Gegenstände aus";
L.GDKP_SESSION = "GDKP-Sitzung";
L.GDKP_SESSION_EDIT_TITLE = "%s wird bearbeitet";
L.GDKP_SHOW_UPCOMING = "Kommende Gegenstände anzeigen";
L.GDKP_STOP_AUCTION_FIRST = "Stoppe zuerst die Auktion!";
L.GDKP_THEY_OWE = "%s schuldet dir %s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP Sitzung
Von Spieler ausgegeben: %s
Gegeben: %s
Empfangen: %s
Spieleranteil: %s

%s
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "Aus GDKP ausschließen";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "Das gehandelte Gold wird nicht zum gegebenen oder erhaltenen Betrag addiert";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Gold |c00967FD2an %s übergeben";
L.GDKP_TRADE_GOLD_ADD_FAILED = "%s konnte nicht zum Handelsfenster hinzugefügt werden. Versuch es manuell hinzuzufügen!";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "Du hast nicht genug Geld, um %s zu bezahlen";
L.GDKP_TRADE_GOLD_TO_GIVE = "Zu geben: %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "Zu empfangen: %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Gold |c00967FD2erhalten von %s";
L.GDKP_TRY_MULTIAUCTION = "Schau dir sich Mehrfachauktionen an!";
L.GDKP_TUTORIAL_INFO = "Befolge die folgenden Schritte, um schnell mit Gargul GDKP zu beginnen!";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "Aktiviere diese Sitzung, indem du unten auf die Schaltfläche |c00FFF569Enable klickst!";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s einen Gegenstand, um einen einzelnen Gegenstand zu versteigern oder in die Warteschlange zu stellen"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
Hilfreiche Befehle:
- |c00FFF569/gdkp, um dieses Fenster zu öffnen
- |c00FFF569/gl ma, um das Fenster für mehrere Auktionen zu öffnen
- |c00FFF569/gl au, um den Auktionator / die Warteschlange für einzelne Gegenstände zu öffnen
- |c00FFF569/gl pm, um automatisches Plündern einzurichten

]];
L.GDKP_TUTORIAL_STEP_DONE = "Wenn alles gut gelaufen ist, siehst du hier deine frisch versteigerten Gegenstände!";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "Möchtest du mehrere Artikel gleichzeitig versteigern? Führe |c00FFF569/gl ma (oder |c00FFF569/gl Multiauction) aus oder klick auf das Mehrfachauktionssymbol oben rechts in diesem Fenster!";
L.GDKP_TUTORIAL_STEP_NEW = "Klick unten auf die Schaltfläche |c00FFF569Neu, um deine erste GDKP-Sitzung zu erstellen. Nach der Erstellung wird es links angezeigt";
L.GDKP_TUTORIAL_STEP_READY = "Du bist bereit Gegenstände zu verkaufen! |c00BE3333Lies alle Schritte unten sorgfältig durch und teste sie alle selbst (Du musst nicht an einem Raid teilnehmen), bevor du deinen ersten GDKP-Raid startest!";
L.GDKP_TUTORIAL_STEP_SELL = "Möchtest du einen Gegenstand verkaufen, ohne dass jemand bietet? |c00FFF569%s auf einen Gegenstand, wähle einen Gewinner aus und lege einen Preis fest!";
L.GDKP_TUTORIAL_TITLE = "Erste Schritte";
L.GDKP_UNKNOWN_ITEM = "Unbekannte Gegenstand-ID in Auktion:create: %s";
L.GDKP_UNKNOWN_SESSION = "Unbekannter SessionIdentifier in Auction:create: %s";
L.GDKP_YOU_OWE = "Du schuldest %s %s";
L.GIVEN = "Gegeben";
L.GOLD_INDICATOR = "G";
L.GROUP = "Gruppe";
L.GROUP_MANAGER = "Gruppenleiter";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "Auf CurseForge herunterladen";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "Halten";
L.HEADER = "Header";
L.HELLO = "|c00%sGargul v%s von Zhorax@Firemaw. Gib |c00%s/gl oder |c00%s/gargul ein, um loszulegen!";
L.HIDE = "Ausblenden";
L.HOURS_MINUTES_FORMAT = "%HM";
L.IDENTITY_INFO = "Besuche die URL unten, um mehr über die Personalisierung von Gargul GDKPs zu erfahren";
L.IDENTITY_TOOLTIP = "Dein Logo hier? Klick für weitere Informationen!";
L.IMPORT = "Importieren";
L.IMPORTED_AND_UPDATED_ON = "Importiert am |c00A79EFF%s um |c00A79EFF%s, Aktualisiert am |c00A79EFF%s um |c00A79EFF%s";
L.IMPORT_EXPLANATION = "Welche Art von Daten möchtest du importieren?";
L.IMPORT_SUCCESSFUL = "Import der Boosted-Rolls-Daten erfolgreich";
L.INC = "Inc";
L.INCLUDE_AWARDED = "Beziehe zuvor verliehene Gegenstände mit ein";
L.INCLUDE_BOES = "BOE einbeziehen";
L.INCLUDE_MATERIALS = "Materialien einschließen (wie Kristalle der Leere)";
L.INCREMENT = "Inkrement";
L.INFO = "Info";
L.INVALID_DATA_WARNING = "Ungültige Daten angegeben";
L.ITEM = "Gegenstand";
L.JSON_DECODE_WARNING = "JSON-Dekodierung der Daten ist nicht möglich. Stell sicher, dass du es unverändert kopiert/eingefügt hast, ohne zusätzliche Zeichen oder Leerzeichen hinzuzufügen!";
L.KEYS_INFO = [[
Gargul-Hotkeys für Gegenstände

Rollen: |c00A79EFF%s
Verleihen: |c00A79EFF%s
Entzaubern: |c00A79EFF%s


-- Klick mit der rechten Maustaste, um dieses Fenster zu deaktivieren --
]];
L.LEDGER = "Register";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "Du musst der Plündermeister sein oder eine Assistenz-/Anführerrolle übernehmen!";
L.LOCALE_CHANGE_NOTE = "Hinweis: Du kannst deine Region jederzeit in den Einstellungen oder über |c00%s/gl Region ändern";
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ENUS = "enUS"; -- English (United States)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_ITIT = "itIT"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul postet Chatnachrichten auf Englisch (Standard)
Du kannst im Dropdown-Menü unten eine andere Sprache auswählen

Deine aktuelle Chat-Sprache ist „%s“. Das Aktivieren einer anderen Sprache führt zu einem /reload!
]];
L.LOCALE_NONE_TITLE = "Wähle eine Chat-Sprache für Gargul";
L.LOCALE_PTBR = "ptBR"; -- Portuguese (Brazil)
L.LOCALE_RURU = "ruRU"; -- Russian (Russia)
L.LOCALE_ZHCN = "zhCN"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "zhTW"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "Du hast ein oder mehrere Add-ons installiert, die möglicherweise zu Fehlfunktionen von Gargul führen können: %s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "SoftRes löschen";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "TMB löschen";
L.LOOTMASTER_DEFAULT_NOTE = "/roll für MS oder /roll 99 für OS";
L.LOOTMASTER_IMPORT_SR_BUTTON = "SoftRes importieren";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "TMB importieren";
L.LOOTMASTER_NOTICE_LABEL = "Dir wurde die Rolle des Plündermeisterd übertragen";
L.LOOTMASTER_OPEN_LABEL = "Dieses Fenster automatisch öffnen";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Beuteprioritäten erfolgreich gelöscht";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Gib eine Prio-CSV im folgenden Format an (1 Zeile pro Element): id or name > prio1, equalprio > prio2 > usw";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Beuteprioritäten erfolgreich importiert";
L.LOOTPRIORITY_INVALID_DATA = "Ungültige Daten angegeben";
L.LOOTPRIORITY_INVALID_LINE = "Ungültige Daten in Zeile: „%s“: Gegenstand-ID oder Priorität fehlt";
L.LOOTPRIORITY_PROCESS_INCOMING = "Es wird versucht, eingehende Beuteprioritäten von %s zu verarbeiten";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Beuteprioritäten";
L.MAIL = "Post";
L.MAILED = "Per Post verschickt";
L.MAIL_CUTS_EXPLANATION = "Post mit Anteilen an Spieler";
L.MAINSPEC_ABBR = "MS";
L.MAXIMIZE = "Maximieren";
L.MIN = "Minimum";
L.MINIMAP_BUTTON_AWARDED = "Verliehener Beuteverlauf";
L.MINIMAP_BUTTON_CUTS = "GDKP-Anteile";
L.MINIMAP_BUTTON_EXPORT = "Daten exportieren";
L.MINIMAP_BUTTON_GARGUL = "Öffne Gargul";
L.MINIMAP_BUTTON_IMPORT = "Daten importieren";
L.MINIMAP_BUTTON_LEDGER = "GDKP-Register";
L.MINIMAP_BUTTON_MULTIAUCTION = "Mehrfachauktion";
L.MINIMAP_BUTTON_SETTING_INFO = "Ändere die Einstellungen in der /gl-Minikarte";
L.MINIMIZE = "Minimieren";
L.MINIMIZE_ON_AWARD = "Bei Verleihung minimieren";
L.MINIMIZE_ON_START = "Beim Start minimieren";
L.MINIMUM = "Minimum";
L.MINIMUM_ITEM_LEVEL = "Mindestartikelstufe";
L.MINIMUM_QUALITY = "Mindestqualität";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "Bewegen";
L.MULTI_AUCTION = "Mehrfachauktion";
L.NAME = "Name";
L.NEW = "Neu";
L.NEXT = "Nächste";
L.NO = "Nein";
L.NONE = "Kein";
L.NOTE = "Notiz";
L.NOTHING = "Nichts";
L.NO_BIDS_ACTION = "Wenn niemand bietet, tue Folgendes:";
L.NO_OFFICER_PRIVILEGES = "Du hast keine Offiziersprivilegien";
L.OFFSPEC_ABBR = "OS";
L.OK = "OK";
L.OPEN = "Offen";
L.OPEN_AUCTIONEER = "Auktionator öffnen";
L.OPEN_MULTI_AUCTION = "Öffne eine Mehrfachauktion";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "GREED";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORE";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "NEED";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASS";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "RANDOM";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SELF";
L.PACKMULE_CONFIRM_DISENCHANTER = "%s als Entzauberer festlegen?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "%s an %s senden? Gib /gl cd ein, um diesen Entzauberer zu entfernen!";
L.PACKMULE_NO_DISENCHANTER_WARNING = "Kein Entzauberer festgelegt, verwende /gl sd [mydisenchanter], um einen festzulegen";
L.PACKMULE_WHO_IS_DISENCHANTER = "Wer ist dein Entzauberer?";
L.PAID = "Bezahlt";
L.PASS = "Passen";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "Spieler";
L.PLAYER_ITEM_WON_COUNT = "Von %s gewonnene Gegenstände:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "PlusOne Punkte";
L.PLUSONES_AWARD_DIALOG_LABEL = "Füge +1 hinzu";
L.PLUSONES_BROADCAST_CONFIRM = "Bist du sicher, dass du deine PlusOne-Daten an alle in deiner Gruppe/deinem Raid übertragen möchtest?";
L.PLUSONES_BROADCAST_PROCESS_START = "Es wird versucht, eingehende PlusOne-Daten von %s zu verarbeiten";
L.PLUSONES_CLEAR_CONFIRM = "%s möchte alle deine PlusOne-Daten löschen. Alle Daten löschen?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "Bist du sicher, dass du deine vorhandenen PlusOne-Daten löschen und neue, von %s gesendete Daten importieren möchtest?";
L.PLUSONES_IMPORT_CONFIRM = "Bist du sicher, dass du neue, von %s gesendete Daten importieren möchtest?";
L.PLUSONES_IMPORT_ERROR = "Ungültige Daten angegeben. Stell sicher, dass der Inhalt dem erforderlichen Format entspricht und keine Kopfzeile enthalten ist";
L.PLUSONES_IMPORT_INFO = [[
Hier kansst du PlusOne-Daten aus einer Tabelle im CSV- oder TSV-Format importieren oder aus einem Google Docs-Blatt einfügen.

Die Tabelle benötigt mindestens zwei Spalten: Den Spielernamen gefolgt von der Punktzahl. Zusätzliche Spalten werden ignoriert.

Hier ist eine Beispielzeile:

Foobar,240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Eingehende Broadcasts von %s automatisch akzeptieren";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Blockiere alle eingehenden +1 geteilten Daten";
L.PLUSONES_UPDATE_CONFIRM = [[
Bist du sicher, dass du deine vorhandenen PlusOne-Daten mit Daten von %s aktualisieren möchten?

Dein letztes Update war auf |c00A79EFF%s, ihres auf |c00A79EFF%s.]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "Pott";
L.PRICE = "Preis";
L.PRIOLIST_ABBR = "PL";
L.QUALITY_COMMON = "Gewöhnlich";
L.QUALITY_EPIC = "Episch";
L.QUALITY_HEIRLOOM = "Erbstück";
L.QUALITY_LEGENDARY = "Legendär";
L.QUALITY_POOR = "Schlecht";
L.QUALITY_RARE = "Selten";
L.QUALITY_UNCOMMON = "Außergewöhnlich";
L.QUEUE = "Warteschlange";
L.RAIDERS = "Raiders";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Wer fehlt";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Fehlende Spielernamen anzeigen";
L.RAIDGROUPS_DISBAND_BUTTON = "Raid auflösen";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Löse deinen Raid auf";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s ist zweimal im Kader aufgeführt!";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "ein |c00FFF569Raid-Helper-Export (Verwende die Variante „Vertikal sortierte Gruppen“) oder eine |c00FFF569Gargul-Gruppenzusammensetzungs-CSV:";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
Im großen Bearbeitungsfeld unten kannst du ein Kader erstellen und: alle einladen, überprüfen, wer fehlt, Gruppen erstellen und die Tanks zuweisen.

Du kannst einen Link zur |c00FFF569Wowhead-Raid-Zusammensetzung bereitstellen:]];
L.RAIDGROUPS_GARGUL_BUTTON = "Wiki der Gargul-Gruppe";
L.RAIDGROUPS_GARGUL_INFO = "Weitere Informationen zum Raid-Gruppenformat finden Sie im Gargul-Gruppen-Wiki";
L.RAIDGROUPS_IMPOSTER_WARNING = "Die folgenden Spieler sind nicht Teil des Kaders: %s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Ungültige Gruppendaten angegeben. Überprüfe dein Format!";
L.RAIDGROUPS_INVITE_BUTTON = "Einladen";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Sende Einladungen an Spieler im Kader";
L.RAIDGROUPS_IN_COMBAT_WARNING = "Gruppen können nicht sortiert werden, während %s im Kampf ist!"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "Du musst in einem Raid sein!";
L.RAIDGROUPS_NO_TANKS_WARNING = "Keine Tanks definiert";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "Du kannst keinen Platz für %s finden. Versuchst du mehr als 5 Personen in eine Gruppe einzuteilen?";
L.RAIDGROUPS_PURGE_BUTTON = "Kicke unerwünschte Spieler";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Kicke Spieler, die nicht im Kader stehen";
L.RAIDGROUPS_SORTING_ERROR = "Beim Verschieben von %s ist ein Fehler aufgetreten";
L.RAIDGROUPS_SORTING_FINISHED = "Die Anwendung des Raid-Kaders ist abgeschlossen";
L.RAIDGROUPS_SORTING_GROUPS = "Gruppen sortieren";
L.RAIDGROUPS_SORT_BUTTON = "Gruppen anwenden";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Sortiere Gruppen nach Kader";
L.RAIDGROUPS_SORT_IN_PROGRESS = "Die Sortierung ist noch im Gange, warte noch ein wenig!";
L.RAIDGROUPS_TANKS_ASSIGNED = "Alle Tanks sind zugewiesen";
L.RAIDGROUPS_TANK_BUTTON = "Weise Tanks zu";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Wowhead Comp-Tool";
L.RAIDGROUPS_WOWHEAD_INFO = "Du kannst das Wowhead-Comp-Tool über die unten stehende URL besuchen. Nachdem du deine Komposition erstellt hast, kannst du sie hier oder in das große Bearbeitungsfeld des Gargul-Gruppenfensters einfügen";
L.REMOVE_BID = "Gebot entfernen";
L.RESET_SETTINGS = "Einstellungen zurücksetzen";
L.RESET_SETTINGS_CONFIRMATION = "Bist du sicher, dass du alle Einstellungen von Gargul zurücksetzen möchtest? Es kann nicht rückgängig gemacht werden!";
L.RESET_UI = "Gargul-Benutzeroberfläche zurücksetzen";
L.RESET_UI_CONFIRMATION = "Bist du sicher, dass du alle Fenstergrößen, -positionen und -skalen von Gargul zurücksetzen möchten? Es kann nicht rückgängig gemacht werden!";
L.RESTORE = "Wiederherstellen";
L.RESUME = "Fortsetzen";
L.RIGHT_SYMBOL = ">";
L.ROLL = "Rollen";
L.ROLLING_AWARD_CONFIRM = "%s an %s verleihen?";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Bei Verleihung schließen";
L.ROLLING_CLOSE_ON_START_LABEL = "Beim Start schließen";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Halte die Umschalttaste gedrückt, um die Verleihungsbestätigung zu umgehen";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Halte die Umschalttaste gedrückt, um die Verleihungsbestätigung anzuzeigen";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
Warnung: Es wurde ein weiterer identischer Wurf gefunden, der auf ein Unentschieden hinweisen kann

]];
L.ROLLING_INVALID_START_DATA_WARNING = "Ungültige Daten für Würfelstart angegeben!";
L.ROLLING_ITEM_WON_BR_COST = "(BR: %s)";
L.ROLLING_ITEM_WON_GIVEN = "(Gegenstand gegeben: ja)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(Gegenstand gegeben: nein)";
L.ROLLING_ITEM_WON_OS = "(OS)";
L.ROLLING_NOTE_LABEL = "NOTIZ";
L.ROLLING_NO_ROLLOFF_WARNING = "Das Würfeln kann nicht gestoppt werden, da kein Würfeln im Gange ist";
L.ROLLING_PASS_BUTTON = "Passen";
L.ROLLING_REOPEN_ROLL_COUNT = "rollt: %s";
L.ROLLING_REOPEN_TOOLTIP = "Öffne das Plündermeisterfenster";
L.ROLLING_ROLL_ACCEPTED = "Wurf angenommen!";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "Derzeit wird gewürfelt";
L.ROLLING_ROLL_PRIOLIST = "Priorität [%s]";
L.ROLLING_ROLL_SR_COUNT = "SR [%sx]";
L.ROLLING_ROLL_WISHLIST = "Wunschliste [%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "Du musst zuerst einen Spieler auswählen";
L.ROLLING_TIMER_LABEL = "TIMER (s)";
L.ROLLING_UNUSABLE_ITEM = "Du kannst diesen Gegenstand nicht verwenden!";
L.ROLLING_WINNER_NOT_UNIQUE = "Der Name des Gewinners ist nicht eindeutig. Wähle den Spieler aus, dem du %s verleihen möchtest";
L.SECONDS_ABBR = "S";
L.SELECT_ALL = "Alle auswählen/deaktivieren";
L.SESSION = "Sitzung";
L.SETTINGS = "Einstellungen";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Gib eingehende Gebote bekannt";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Gib den Pott nach der Vergabe des Gegenstands bekannt";
L.SETTINGS_ANNOUNCE_START = "Auktionsstart bekannt geben";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Countdown in der Raid-Warnung ankündigen";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Kündige eingehende Gebote in der Raid-Warnung an";
L.SETTINGS_RESET_UI = "Gargul-Benutzeroberfläche zurücksetzen";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Flüster Bieter, wenn das Gebot zu niedrig ist";
L.SILVER_INDICATOR = "S";
L.SKIP = "Überspringen";
L.SOFTRES = "Soft-Reserve";
L.SOFTRES_ABBR = "SR";
L.SOFTRES_BROADCAST_CONFIRM = "bist du sicher, dass du deine Softres-Daten an alle Mitglieder deiner Gruppe/deines Raids übertragen möchtest?";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "Die von %s empfangenen SoftRes-Daten konnten nicht verarbeitet werden";
L.SOFTRES_CLEAR_CONFIRM = "Bist du sicher, dass du alle vorhandenen Soft-Reserv-Daten löschen möchtest?";
L.SOFTRES_EVERYONE_RESERVED = "Jeder hat sein Soft-Reserve eingefüllt";
L.SOFTRES_FEATURE_MISSING = [[
Informationen zu Hard-Reserves sind aufgrund der Soft-Reserves nicht verfügbar
Die bereitgestellten Dateien wurden nicht über die Schaltfläche „Gargul Export“ auf softres.it generiert]];
L.SOFTRES_IMPORT_DETAILS = "Importiert am |c00A79EFF%s um |c00A79EFF%s";
L.SOFTRES_IMPORT_FIXED_NAME = "Automatische Namenskorrektur: Die SR von „%s“ ist jetzt mit „%s“ verknüpft.";
L.SOFTRES_IMPORT_INFO = "Um zu beginnen, musst du zunächst einen Raid auf softres.it erstellen. Klick anschließend auf „Addon Export“, wähle „Gargul“, kopiere die Daten und füge sie in das untenstehende Formular ein.";
L.SOFTRES_IMPORT_INVALID = "Es wurden ungültige Soft-Reserve-Daten bereitgestellt";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Ungültige Daten angegeben. Klick auf die Schaltfläche „Gargul Export“ auf softres.it und füge den gesamten Inhalt hier ein";
L.SOFTRES_IMPORT_NEW_PLUSONES = "Die bereitgestellten PlusOne-Werte kollidieren mit den bereits vorhandenen. Möchtest du deine alten PlusOne-Werte ersetzen?";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "Die folgenden Spieler haben nichts reserviert:";
L.SOFTRES_IMPORT_SUCCESSFUL = "Soft-Reserves erfolgreich importiert";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "Import erfolgreich!";
L.SOFTRES_IMPORT_USE_GARGUL = "SoftRes Weakaura- und CSV-Daten sind veraltet. Verwende stattdessen den Gargul-Export!";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "Verbindung zu LootReserve konnte nicht hergestellt werden. Wende dich an den Support (füge die Nachricht unten ein).";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "Keine softres.it-URL verfügbar. Stell sicher, dass du den Export über die Schaltfläche „Gargul Export“ auf softres.it durchgeführt hast!";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "Klick hier, um Informationen zur Festreserve anzuzeigen";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "Es sind keine Gegenstände hard-reserved";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "Keine Informationen zu hard-reserve verfügbar";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "Poste fehlende SRs";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "SR-URL posten";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "Dieser Spieler hat nichts reserviert!";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "Es wird versucht, eingehende SoftRes-Daten von %s zu verarbeiten";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "Dieser Artikel ist hard-reserved";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "Für: %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Hinweis: %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Reserviert von";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "Etwas ist schief gelaufen!";
L.START = "Start";
L.STOP = "Stoppen";
L.TAB_REPLACES_T = "\\t wird ersetzt durch Tabulatortaste";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "Zeit";
L.TITLE = "Titel";
L.TMBETC = "TMB, DFT oder PRIO3";
L.TMB_BROADCAST_CONFIRM = "Bist du sicher, dass du deine TMB-Daten an alle Mitglieder deiner Gruppe/deines Raids übertragen möchtest? Hinweis: JEDER kann deine TMB-Daten sehen, unabhängig von seinen Berechtigungen auf der TMB-Website!";
L.TMB_BROADCAST_PROCESS_START = "Es wird versucht, eingehende TMB-Daten von %s zu verarbeiten";
L.TMB_CLEAR_CONFIRM = "Bist du sicher, dass du alle PlusOne-Daten löschen möchtest?";
L.TMB_CLEAR_RAIDER_DATA = "Raider-Daten löschen";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "TMB-Daten für alle Raider löschen?";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "Automatisches Teilen aktiviert: %s";
L.TMB_IMPORT_CPO_INFO = "Klick bei deinem classicpr.io-Lauf auf die Schaltfläche „Gargul Export“ und kopiere den Inhalt. Füge anschließend den Inhalt unverändert in das Feld unten ein und klick auf „Importieren“. Das ist es!";
L.TMB_IMPORT_DETAILS = "Importiert am ${date} um ${time}";
L.TMB_IMPORT_DFT_INFO = "Exportiere deine DFT-Daten gemäß den Anweisungen auf dem Sheet. Füge anschließend den Inhalt unverändert in das Feld unten ein und klick auf „Importieren“. Das ist es!";
L.TMB_IMPORT_INVALID_CSV = "Es wurde eine ungültige CSV-Datei bereitgestellt. Das Format lautet: 6948,Spieler1,Spieler2";
L.TMB_IMPORT_INVALID_DFT = "Es wurden ungültige DFT-Daten bereitgestellt. Exportiere deine DFT-Daten gemäß den Anweisungen auf dem Sheet und füge den Inhalt unverändert hier ein!";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Es wurden ungültige TMB-Daten bereitgestellt. Klick auf die Schaltfläche „Herunterladen“ im Gargul-Bereich und füge den Inhalt unverändert hier ein!";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Es wurden ungültige TMB- oder DFT-Daten bereitgestellt. Stell sicher, dass du die Exportinhalte unverändert hier einfügst!";
L.TMB_IMPORT_NOTES_AVAILABLE = "Prioritätsnotizen verfügbar: %s";
L.TMB_IMPORT_NUMBER = "Anzahl der importierten Gegenstände: %s";
L.TMB_IMPORT_PLAYER_NO_DATA = "Die folgenden Spieler haben keine %s Einträge:"; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "So verwendest du Gargul mit ${source}";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "Füge den Inhalt deines TMB-Exports unverändert in das Feld unten ein und klick auf „Importieren“.";
L.TMB_NO_BROADCAST_TARGETS = "Es gibt niemanden in deiner Gruppe, an den du senden können";
L.TMB_SYNCED = "TMB-Daten synchronisiert";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF Hinweis: |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(OS)";
L.TMB_TOOLTIP_PRIO_HEADER = "%s Prio-Liste"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF Tier: %s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "TMB-Wunschliste";
L.TOGGLE_DATES = "Daten ein-/ausblenden";
L.TOGGLE_QUEUE = "Warteschlange ein-/ausblenden";
L.TRADETIME_AWARD_HOWTO = "%s, um Beute zu verleihen!";
L.TRADETIME_ROLL_HOWTO = "%s um um Beute zu würfeln!";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "Alle verliehenen Gegenstände ausblenden";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "Blende entzauberte Gegenstände aus";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "Selbst verliehene Gegenstände ausblenden";
L.TRADE_ANNOUNCE = "Handel ankündigen";
L.TRADE_ANNOUNCE_INFO = "Gib Handelsdetails der Gruppe oder in /say bekannt, wenn du nicht in einer Gruppe bist";
L.TUTORIAL = "Tutorial";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s Gegenstände in Taschen, Beutefenstern oder sogar auf Links in deinem Chat, um sie zur Auktionswarteschlange hinzuzufügen.
Möchtest du einen Gegenstand direkt verkaufen, ohne zu bieten? Verwende |c00A79EFF%s

Du kannst das %s-Fenster direkt öffnen, indem du |c00A79EFF/gl Auktion eingibst

Gargul verfolgt |c00FF0000ALL gehandeltes Gold. Möchtest du nicht, dass ein Handel Teil dieser GDKP-Sitzung ist? Aktiviere beim Handel das Kontrollkästchen „Vom GDKP ausschließen“!

|c00FFF569Wusstest du schon?
Verliehene Gegenstände werden automatisch zum Handelsfenster hinzugefügt
Gargul kann auch das automatische Plündern für dich übernehmen. Probier es mit |c00A79EFF/gl pm aus
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
In diesem Fenster werden alle Gegenstände angezeigt, die an einem bestimmten Datum verliehen wurden (wähle links ein oder mehrere Daten aus).

Gegenstände können die folgenden Tags enthalten:

|c00A79EFFOS: Verliehen für Offspec
|c00A79EFFSR: Dieser Gegenstand war Soft-Reserved
|c00A79EFFWL: Dieser Gegenstand war auf einer Wunschliste (Thatsmybis)
|c00A79EFFPL: Dieser Gegenstand war auf einer Prio-Liste (Thatsmybis, DFT, prio3)
]];
L.TUTORIAL_BIDDER_QUEUE = [[
Die Gegenstände, die du hier siehst, befinden sich in der GDKP-Warteschlange des Plündermeisters
Du kannst sie entfernen, darauf bieten und unbrauchbare Gegenstände ausblenden (aktiviere „Unbrauchbare Gegenstände ausblenden“ in den Einstellungen oben links).

Du kannst die Größe des Fensters ändern, es verschieben oder minimieren. Versuch es!

Für Plündermeister: Wenn du Gegenstände hier entfernst, werden sie nur aus deiner persönlichen Warteschlange entfernt, nicht aus der tatsächlichen GDKP-Warteschlange!
]];
L.TUTORIAL_MORE_HELP = "Benötigst du mehr Hilfe?";
L.TYPE = "Typ"; -- As in type of roll or type of item
L.UNKNOWN = "Unbekannt";
L.UNKNOWN_COMM_ACTION = "Unbekannte Kommunikationsaktion „%s“, aktualisiere unbedingt Gargul!";
L.UNLOCK = "Freischalten";
L.UPDATE_GARGUL = "Aktualisiere Gargul!";
L.VERSION_ABBR = "v";
L.VERSION_CHECK_BUTTON_REPORT = "Bericht";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Veraltete Ergebnisse im Gruppenchat melden";
L.VERSION_CHECK_COLUMN_STATUS = "Gargul-Status";
L.VERSION_CHECK_STATUS_CHECKING = "Version wird geprüft...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s: Der Spieler ist auf dem neuesten Stand
|c00F7922Ev%s: Der Spieler muss seine Add-ons aktualisieren
|c00BE3333%s: Der Spieler verfügt nicht über Gargul oder nutzt eine nicht unterstützte Version
|c00808080%s: Der Spieler ist offline oder ignoriert uns!
|c0000FFFF%s: Der Spieler steht auf unserer Ignorierliste!

]];
L.VERSION_CHECK_STATUS_IGNORED = "SPIELER IGNORIERT!";
L.VERSION_CHECK_STATUS_OFFLINE = "Offline";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "Keine Antwort";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "Keine Antwort:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Offline:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "Veraltet:";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "Up-to-date:";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul ist veraltet und funktioniert erst, wenn du ein Update durchführst!";
L.VERSION_INVALID_WARNING = "Ungültige Versionszeichenfolge in Version:addRelease angegeben";
L.VERSION_UPDATE = "Aktualisiere Gargul!";
L.VERSION_UPDATED = "|c00%sGargul wird jetzt auf |c00%sv%s aktualisiert";
L.VERSION_UPDATE_AVAILABLE = "|c00A79EFFv%s ist auf CurseForge/Wago verfügbar. Du kannst aktualisieren, ohne dein Spiel zu schließen. Stell einfach sicher, dass du /reload ausführst!";
L.WAIT_SECONDS_BEFORE_RETRY = "Warte %s weitere Sekunden, bevor du es erneut versuchst";
L.WINDOW = "Fenster";
L.WINDOW_HEADER = "Gargul v%s";
L.WINDOW_SCALE = "Fensterskalierung";
L.WISHLIST_ABBR = "WL";
L.YES = "Ja";
L.YOU_DISABLED_GDKP_QUEUES = "Du hast GDKP-Warteschlangen deaktiviert";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "Zlib-Komprimierung der Daten ist nicht möglich. Kontaktiere den Support über https://discord.gg/D3mDhYPVzf";
L.ZLIB_DECOMPRESS_WARNING = "Zlib kann die Daten nicht dekomprimieren. Stell sicher, dass du es unverändert kopiert/eingefügt hast, ohne zusätzliche Zeichen oder Leerzeichen hinzuzufügen!";
