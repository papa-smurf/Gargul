--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (true or GetLocale() ~= "deDE") then return; end
local L = Gargul_L or {};

L.ABOUT = "Über";
L.ALL_SETTINGS = "Alle Einstellungen";
L.ANNOUNCE = "Bekannt geben";
L.ANTISNIPE = "Anti-Snipe";
L.ANTISNIPE_EXPLANATION = [[

Ein Anti-Snipe-Wert von 10 bedeutet, dass jedes eingehende Gebot mit
Wenn weniger als 10 Sekunden verbleiben, wird der Timer auf 10 Sekunden zurückgesetzt

Sie können dieses Feld leer lassen oder auf 0 setzen, um Anti Snipe vollständig zu deaktivieren.
Anti-Snipe-Werte unter 5 werden nicht unterstützt

]];
L.ARE_YOU_SURE = "Bist du sicher?";
L.ASSIGN_GARGUL_INFO = [[
Vergessen Sie nicht, stattdessen Gargul zu verwenden
wenn Sie die Beute später exportieren möchten


-- Klicken Sie mit der rechten Maustaste, um dieses Fenster zu deaktivieren --]];
L.AUCTION = "Versteigerung";
L.AUCTIONEER = "Auktionator";
L.AUCTIONS = "Auktionen";
L.AUTO = "Auto";
L.AUTO_AWARD = "Auto-Auszeichnung";
L.AUTO_TRADE_OPTIONS = "Autohandel";
L.AVAILABLE_PLACEHOLDER_VALUES = "Verfügbare Werte:";
L.AWARD = "Vergeben";
L.AWARDED_TO = "Ausgezeichnet für";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "BR: %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Preise";
L.AWARDED_TOOLTIP_GIVEN = "Gegeben: ja";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Gegeben: nein";
L.AWARDED_TOOLTIP_SECOND_BID = "2. Gebot: %s von %s";
L.AWARDED_YOU_WON = "Du hast gewonnen";
L.AWARD_CONFIRM = "%s an %s vergeben?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "Sind Sie sicher, dass Sie %s entzaubern möchten? %s geboostete Rollpunkte werden zurückerstattet!";
L.AWARD_HEADER_IN_GROUP = "In einer Gruppe";
L.AWARD_HISTORY = "Preisgeschichte";
L.AWARD_NEW_WINNER_CONFIRMATION = "Zu wem sollte %s stattdessen gehen?";
L.AWARD_PLAYER_CUSTOM_NAME = "Geben Sie hier den Namen des Spielers ein";
L.AWARD_PLAYER_SELECT_NAME = "oder wählen Sie unten eines aus";
L.AWARD_RANDOM_CONFIRM = "Möchten Sie %s an einen zufälligen Spieler vergeben?";
L.AWARD_TOOLTIP_ADD_ITEM = "Ziehen Sie ein Element per Drag-and-Drop oder bei gedrückter Umschalttaste in das Feld rechts";
L.AWARD_TOOLTIP_BR_INDICATION = "(BR: %s)";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Entzauberte Gegenstände:";
L.AWARD_TOOLTIP_GIVEN = "(Gegeben: ja)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(Gegeben: nein)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(Betriebssystem)";
L.AWARD_UNDO_BR_REFUND = "%s geboostete Rollpunkte werden zurückerstattet!";
L.AWARD_UNDO_CONFIRM = "Sind Sie sicher, dass Sie %s, das %s zugeteilt wurde, rückgängig machen möchten?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "Tascheninspektion fehlgeschlagen: Keine Berichte erhalten";
L.BAGINSPECTOR_FINISHED = "Inspektion beendet";
L.BAGINSPECTOR_START = "Inspektion beginnt...";
L.BALANCE = "Gleichgewicht";
L.BASE = "Base";
L.BASE64_DECODE_WARNING = "Die Base64-Dekodierung der Daten ist nicht möglich. Stellen Sie sicher, dass Sie es unverändert kopieren/einfügen, ohne zusätzliche Zeichen oder Leerzeichen hinzuzufügen!";
L.BID = "Gebot";
L.BIDS = "Gebote";
L.BIND_ON_EQUIP_ABBR = "BOE";
L.BONUS_AUTO_INVITE = "1. Gruppen automatisch aus der Raid-Anmeldung einladen/sortieren! Klicken Sie unten oder verwenden Sie |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. Belohnen Sie Spieler dafür, dass sie Stammspieler sind oder die Extrameile gehen! Klicken Sie unten oder verwenden Sie |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "Gargul hat ein paar Tricks im Ärmel, die Ihnen vielleicht nicht bewusst sind. Schauen Sie mal rein!";
L.BONUS_PLUSONES = "3. Gargul beinhaltet ein Plus-One-Tracking-System! Klicken Sie unten oder verwenden Sie |c00A79EFF/gl po";
L.BOOSTED_ROLLS = "Boosted Rolls";
L.BOOSTED_ROLLS_ABBR = "BR";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
Wie viele Punkte addieren Sie für alle, die derzeit am Raid teilnehmen?

|c00BE3333Verwenden Sie zuerst die Schaltfläche „Vermisste Raider hinzufügen“, wenn Sie möchten, dass jeder Punkte erhält, auch diejenigen ohne einen Boost-Wurf-Eintrag!]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "Kein Punktwert angegeben!";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Fügen Sie dem Raid Punkte hinzu";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Fehlende Raider hinzufügen";
L.BOOSTED_ROLLS_ALIASES = "Aliase";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Aliase anwenden";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Erhöhte Rollkosten:";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "Sind Sie sicher, dass Sie Ihre Boost-Roll-Daten an alle in Ihrer Gruppe/Ihrem Raid übertragen möchten?";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "Nichts zum Senden, importieren Sie zuerst die Boosted Rolls-Daten!";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "Die von %s empfangenen BoostedRolls-Daten konnten nicht verarbeitet werden";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Es wird versucht, eingehende BoostedRolls-Daten von %s zu verarbeiten";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "Sind Sie sicher, dass Sie alle Boosted-Roll-Daten löschen möchten?";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "%s löschen?";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "Sind Sie sicher, dass Sie Ihre bestehenden Boosted-Roll-Daten löschen und neue, von %s gesendete Daten importieren möchten?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Ungültige Daten angegeben. Stellen Sie sicher, dass der Inhalt dem erforderlichen Format entspricht und keine Kopfzeile enthalten ist";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
Hier können Sie Boosted-Roll-Daten und Aliase aus einer Tabelle im CSV- oder TSV-Format importieren oder aus einem Google Docs-Blatt einfügen.

Die Tabelle benötigt mindestens zwei Spalten: Den Spielernamen gefolgt von der Punktzahl. Zusätzliche Spalten sind optional und können Aliase für den Player enthalten.
Hier ist eine Beispielzeile:

Foobar,240,Barfoo]];
L.BOOSTED_ROLLS_POINTS = "Punkte";
L.BOOSTED_ROLLS_RESERVE = "Reservieren";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
Sind Sie sicher, dass Sie Ihre vorhandenen geboosteten Rollen mit Daten von %s aktualisieren möchten?

Ihr letztes Update war auf |c00A79EFF%s, ihres auf |c00A79EFF%s.]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!bonus|!rb|!br";
L.BROADCAST = "Übertragen";
L.BROADCASTING_NOTIFICATION = "Rundfunk...";
L.BROADCAST_DELAYED_BY_COMBAT = "Sie befinden sich derzeit im Kampf und verzögern die Übertragung";
L.BROADCAST_FINISHED = "Übertragung beendet!";
L.BROADCAST_INC_AWARDED = "Beziehen Sie prämierte Gegenstände mit ein";
L.BROADCAST_INC_DISENCHANTED = "Schließen Sie entzauberte Gegenstände ein";
L.BROADCAST_INC_HIDDEN = "Schließen Sie versteckte Elemente ein";
L.BROADCAST_INC_TIME_LEFT = "Berücksichtigen Sie die verbleibende Zeit";
L.BROADCAST_IN_PROGRESS_ERROR = "Die Übertragung läuft noch";
L.BROADCAST_NO_DATA = "Es gibt nichts zu senden";
L.BROADCAST_NUMBER_OF_ITEMS = "Anzahl der Teile";
L.BROADCAST_TARGET_PLAYER = "Zielspieler (nur Flüstern)";
L.BROADCAST_TARGET_REQUIRED = "Flüstern erfordert einen Zielspieler";
L.BROADCAST_TRADE_TIME_LEFT = "Maximal verbleibende Handelszeit (in Minuten)";
L.BY = "von"; -- As in 'bid BY'
L.CANCEL = "Stornieren";
L.CHANGELOG_CONTRIBUTE = "Holen Sie sich Unterstützung oder teilen Sie Ideen auf unserem Discord";
L.CHANGELOG_ENABLE_LABEL = "Änderungsprotokoll aktivieren";
L.CHANGELOG_GETTING_STARTED = "Gargul macht das Verteilen von Beute ganz einfach. Klicken Sie auf die Schaltfläche unten, um loszulegen!";
L.CHANGELOG_OPEN_GARGUL = "Öffne Gargul";
L.CHANGE_SCALE = "Maßstab anpassen";
L.CHANNEL = "Kanal";
L.CHANNEL_OFFICER = "Offizier";
L.CHANNEL_RAID_WARNING = "Raid-Warnung";
L.CHANNEL_WHISPER = "Flüstern";
L.CLASSICPRIO_ABBR = "HLW";
L.CLEAR = "Klar"; -- As in clearing a window or data
L.CLOSE = "Schließen";
L.CLOSE_ON_AWARD = "Kurz vor der Auszeichnung";
L.CLOSE_ON_START = "Beim Start schließen";
L.COMMUNICATION = "Kommunikation";
L.COMM_PROGRESS = "%s von %s Bytes wurden gesendet";
L.COPPER_INDICATOR = "C";
L.CUT = "Schneiden";
L.CUTS = "Schnitte";
L.CUT_MAILBOX_CLOSED = "Es können keine E-Mails gesendet werden, wenn das Postfach geschlossen ist";
L.CUT_MAILS_FAILED = "Es wurden mehrere E-Mail-Fehler festgestellt, wodurch die Verteilung der Zuschnitte abgebrochen wurde";
L.CUT_MAIL_BODY = "Unterstützt von Gargul: ein Master-Loot-Tool mit Unterstützung für TMB, SoftRes, GDKP und Auto-Looting!";
L.CUT_MAIL_EVEN = "Du schuldest %s kein Gold";
L.CUT_MAIL_FAILED = "Der Schnitt konnte nicht an %s gesendet werden";
L.CUT_MAIL_GOLD_MISMATCH = "Mail je nach Spiel GESENDET, aber Ihr verbleibendes Gold stimmt nicht überein. Ist etwas schief gelaufen?";
L.CUT_MAIL_HISTORY = "E-Mail-Verlauf für |c00967FD2%s";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "Du hast nicht genug Gold, um %s zu bezahlen";
L.CUT_MAIL_IN_PROGRESS = "Warten Sie etwas, wir bearbeiten noch die vorherige E-Mail";
L.CUT_MAIL_SUBJECT = "Gargul GDKP: %sg";
L.CUT_SENT = "%sg an %s gesendet";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "Löschen";
L.DETAILS = "Einzelheiten";
L.DFT = "DFT";
L.DISABLE = "Deaktivieren";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "Entzaubern";
L.EDIT = "Bearbeiten";
L.ENABLE = "Aktivieren";
L.EXPORT = "Export";
L.EXPORT_DELETE_ALL_CONFIRM = "Sind Sie sicher, dass Sie Ihre vollständige Prämienverlaufstabelle entfernen möchten? Dadurch werden ALLE Beutedaten gelöscht und können nicht rückgängig gemacht werden!";
L.EXPORT_DELETE_DATE_CONFIRM = "Sind Sie sicher, dass Sie alle Daten für %s entfernen möchten? Das kann nicht rückgängig gemacht werden!";
L.EXPORT_READ_ONLY_NOTICE = [[
Dies ist NUR eine Exportfunktion. Es macht keinen Sinn, die Werte zu bearbeiten: SIE WERDEN NICHT GESPEICHERT!

]];
L.FILL = "Füllen";
L.FINAL_CALL = "Letzte Aufforderung";
L.FORMAT = "Format";
L.GARGUL = "Gargul";
L.GDKP = "GDKP";
L.GDKPS_ARE_NOT_ALLOWED = "GDKP-Raids sind in dieser Version von World of Warcraft nicht erlaubt";
L.GDKP_ACTIVATED = "GDKP Aktiv!";
L.GDKP_ADD_DROPS_TO_QUEUE = "Füge fallengelassene Beute zur Warteschlange hinzu";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "Gold (- zum Entfernen von Gold)";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "Wer bezahlt das?";
L.GDKP_ADD_GOLD_INVALID_WARNING = "Gold muss niedriger/höher als 0 sein";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "Bezahlt von";
L.GDKP_ADD_GOLD_TITLE = "Gold in %s anpassen";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "Sie können nicht gleichzeitig Gold von demselben Spieler geben UND erhalten";
L.GDKP_ALL_CUTS_MAILED = "Alle Schnitte wurden per Post verschickt!";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "Deaktivieren für desillusioniert";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "Im Kampf deaktivieren";
L.GDKP_AUCTIONS = "Auktionen";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "Erstellt von";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333Gelöscht von %s
Gründe dafür]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg von %s zum Pot hinzugefügt
Anmerkungen]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s hat |c00%s%sg dafür bezahlt
%S]];
L.GDKP_AUCTION_DETAILS_WON_BY = "Gewonnen von";
L.GDKP_AUCTION_PAID_AMOUNT = "Bezahlten Betrag festlegen (siehe links)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul verfolgt automatisch den Überblick über das gehandelte Gold. Solange die Spieler zahlen
Für das, was sie gekauft haben, sollten Sie dieses Feld niemals benötigen

„Bezahlter Betrag“ bezieht sich auf die Goldmenge, mit der der Käufer Sie bereits gehandelt hat.
Der tatsächliche Preis des Artikels ändert sich dadurch nicht!

Achtung: Legen Sie hier nur einen Wert fest, wenn der Spieler eine Zahlung verspricht
außerhalb des Raids oder tauscht das Gold von einem Alt / Mail usw.!


]];
L.GDKP_AWARD_DIALOG_LABEL = "GDKP-Preis:";
L.GDKP_AWARD_ITEM_CONFIRMATION = "%s an %s für %s vergeben?";
L.GDKP_BIDDER_AUTO_BID = "Automatisches Gebot";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "Wie hoch ist Ihr Höchstgebot? (Minimum %s|c00FFF569g)";
L.GDKP_BIDDER_BID_DENIED = "Angebot abgelehnt!";
L.GDKP_BIDDER_ITEM_PRICING = "Mindestgebot: %sg Inkrement: %sg";
L.GDKP_BIDDER_MY_MAX_BID = "(maximal %sg)";
L.GDKP_BIDDER_NEW_BID_LABEL = "Neues Angebot";
L.GDKP_BIDDER_STOP_AUTO_BID = "Stoppen Sie das automatische Gebot";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "Höchstgebot: %s von %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "Höchstgebot: %s von Ihnen";
L.GDKP_CREATE = "Erstellen Sie eine neue GDKP-Sitzung";
L.GDKP_CREATE_MANAGEMENT_CUT = "Managementkürzung %";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Management Cut muss leer sein oder zwischen 0 und 99 liegen (kein %-Zeichen!)";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "Wählen Sie einen Sitzungstyp!";
L.GDKP_CREATE_SESSION_SWITCH = "Wechseln Sie zu dieser Sitzung";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFMulti-Auction ermöglicht es Ihnen, Gebote für mehrere Artikel gleichzeitig abzugeben, was die Sache beschleunigt!
Befolgen Sie die Anweisungen nach dem Erstellen dieser Sitzung, um zu beginnen

Mit |c00A79EFFSingle-Auction können Sie stattdessen einzelne Artikel versteigern oder die Warteschlange nutzen

Durch Auswahl von |c00A79EFFMulti-Auction wird verhindert, dass fallengelassene Elemente zur Warteschlange hinzugefügt werden
Sie können |c00A79EFFMulti-Auction mit |c00A79EFFSingle-Auction und der Warteschlange kombinieren, wir raten jedoch dringend davon ab

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "Auktionstyp (|c00A79EFFi für weitere Informationen)";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "Mehrfachauktion";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "Einzelauktion";
L.GDKP_CREATE_SUCCESSFUL = "Sitzung erstellt. Wir empfehlen Ihnen, /reload zu verwenden, damit es ordnungsgemäß gespeichert wird, falls Ihr Spiel abstürzt!";
L.GDKP_CUTS_ADD_RAIDER = "Raider hinzufügen";
L.GDKP_CUTS_ADJUST_G = "anpassen [g]";
L.GDKP_CUTS_ADJUST_P = "anpassen [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "Kündigen Sie den Basisschnitt im Gruppenchat an";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "Sind Sie sicher, dass Sie alle Spieler und Berechnungen zurücksetzen möchten? Hinweis: Alle Spieler, die nicht mehr am Raid teilnehmen, werden aus der Liste entfernt!";
L.GDKP_CUTS_DELETE_RAIDER = "Raider löschen";
L.GDKP_CUTS_EDIT_RAIDER = "Raider bearbeiten";
L.GDKP_CUTS_LOCK_TOOLTIP = "Sperren und bezahlen";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "Verwalten Sie Goldgeschäfte";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

Mit Mutatoren können Sie den Spielern mehr oder weniger Gold geben
Beispiel: Mutatoren sind dafür gedacht, Tanks 2 % mehr zu geben!

Hinweis: Wenn Sie Mutatoren hier bearbeiten oder löschen, werden sie nur für diese Sitzung geändert

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "Nicht bei der Razzia";
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
L.GDKP_CUTS_SUMMARY = "%s Raiders | %s Mit Schnitt | Gesamtauszahlung: %sg";
L.GDKP_CUT_IMPORT_EMPTY = "Es gibt nichts zu importieren. Überprüfen Sie Ihre CSV-Datei noch einmal";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Es fehlt Gold für Spieler %s";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "Fehlender Header, Hinweis: Groß-/Kleinschreibung wird beachtet!";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Fehlender Spielername";
L.GDKP_DELETE_BID_INFO = "Gebot löschen. Die Auktion muss zuerst gestoppt werden!";
L.GDKP_DISTRIBUTE_ADDRAIDER = "Fügen Sie dieser Sitzung einen Raider hinzu";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "Benutzerdefiniert (erstellen Sie Ihr eigenes Format)";
L.GDKP_EXPORT_AUCTIONS_JSON = "Ausführlich (JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "Teilen (kann von anderen Spielern importiert werden)";
L.GDKP_EXPORT_CUSTOM_FORMAT = "Ihr individuelles Format";
L.GDKP_EXPORT_CUSTOM_HEADER = "Ihr benutzerdefinierter Header";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Benutzerdefiniert (erstellen Sie Ihr eigenes Format)";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@PLAYER,@CUT";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "Spieler, Schnitt";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "Datum/Uhrzeit, zu der die Sitzung gesperrt wurde";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "Gesamtgold, das dem Spieler gegeben wurde";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "Gold wird dem Spieler per Post zugesandt";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "Gesamtgold, das der Spieler erhalten hat";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "Datum/Uhrzeit der Verleihung des ersten Artikels";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "Gold wird an den Spieler getauscht";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "Gegenstand, Spieler, Gold, Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "Datum/Uhrzeit der Verleihung des ersten Artikels";
L.GDKP_EXPORT_FORMAT_TITLE = "Der Titel der GDKP-Sitzung";
L.GDKP_EXPORT_POT_CHANGED = "Topf gewechselt";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "Bist du sicher? Sie können kommende Artikel nicht sehen oder darauf bieten!";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!! ACHTUNG !!|r

Sie befinden sich auf einem verbundenen Realm und importieren Spielernamen ohne
ein Bereichssuffix, zum Beispiel „%s“. Dies kann dazu führen, dass Sie senden
schneidet und schneidet E-Mails an den falschen Spieler.

Wenn Sie sich auf einem verbundenen Realm befinden, versuchen Sie immer, den Realmnamen der Spieler anzugeben!

Mit dem Import fortfahren?
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "Dadurch werden alle Änderungen überschrieben, die Sie am Schnittfenster vorgenommen haben. Sind Sie sicher?";
L.GDKP_IMPORT_CUTS_INFO = [[
Sie können Spielerschnitte aus Ihren eigenen Berechnungen wie einem Google Sheet importieren. Softres GDKP usw.

Das Format ist wie folgt (|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333Player,Gold|c00967FD2
Spieler1.4000
Spieler2,4125
Spieler3.3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
Importieren Sie GDKP-Mindestpreise und -inkremente.

Das Format ist wie folgt: ItemID + Minimum oder Inkrement sind erforderlich. (|c00BE3333ERFORDERT EINEN HEADER!!):

|c00BE3333ItemID,Minimum,Inkrement|c00967FD2
18608.4000.500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "Vorhandene Preiseinstellungen löschen? Klicken Sie auf „Ja“, um alle Preisdaten zu löschen, und auf „Nein“, um vorhandene einfach mit den von Ihnen hier angegebenen Daten zu überschreiben";
L.GDKP_IMPORT_SESSION = "GDKP-Sitzung importieren";
L.GDKP_IMPORT_SESSION_ABOUT = "Hier können Sie eine GDKP-Sitzung importieren (und fortsetzen). Um eine GDKP-Sitzung von jemandem zu erhalten, muss er sie in |c00FFF569/gdkp exportieren und dort das Format „Teilen (kann von anderen Spielern importiert werden)“ auswählen";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "Sie sind dabei, eine von %s erstellte GDKP-Sitzung zu importieren. Sind Sie sicher?";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "Diese von %s erstellte GDKP-Sitzung scheint bereits zu existieren. Möchten Sie sie überschreiben?";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "Ungültige Daten für die GDKP-Erweiterung angegeben!";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "Ungültige Daten für GDKP-Umplanung angegeben!";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "Ungültige Daten zur GDKP-Verkürzung angegeben!";
L.GDKP_INVALID_DATA_FOR_START = "Ungültige Daten für GDKP-Auktionsstart angegeben!";
L.GDKP_INVALID_PAID_AMOUNT = "Ungültige Nummer für „bezahlt“ angegeben";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "In „Auktion: Neu planen“ wurde eine ungültige Zeit angegeben";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP Daten (verkauft %sx)
Zuletzt verkauft für: %s
Durchschnittspreis: %s
Mindestgebot: %s
Schritte

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "Kontostand: |c0092FF000 ? Du bist quadratisch! | |c00BE333330 ? Du schuldest %s 30g | |c00F7922E50 ? %s schuldet dir 50g";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "Gold wurde Ihnen von %s zugesandt";
L.GDKP_LEDGER_LEGEND_PAID_TO = "Gold wurde an %s gezahlt";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "Gold von %s erhalten";
L.GDKP_LEDGER_MUTATION = "Gold %s von"; -- %s = removed or added
L.GDKP_LEDGER_POT = "Gesamttopf: %sg | Managementkürzung: %sg (%s%%) | Zu verteilen: %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s | Von %s%s | Am |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "Die GDKP-Sitzung ist nicht verfügbar oder gesperrt";
L.GDKP_MAIL_ALL = "Mailen Sie allen";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "Keine Gebote für Legendary+-Artikel gefunden, manuell fortfahren!";
L.GDKP_MISSING_CONTENT_FOR_START = "Fehlender Inhalt in Auktion:Start";
L.GDKP_MULTIAUCTION_ABOUT = [[

Mit Mehrfachauktionen (oder Batch-Auktionen) können Sie so viele Artikel auf einmal versteigern, wie Sie möchten!
Dies beschleunigt Ihre Raid-Nächte enorm und sorgt für ein nahtloses Erlebnis für Ihre Raider

Alle handelbaren Artikel, die sich noch in Ihrem Inventar befinden, können automatisch mit „Aus Inventar füllen“ versteigert werden.
Versuch es einmal!

|c00808080Es gibt nur einen Nachteil: Damit Leute an einer Sammelauktion teilnehmen können, brauchen Raider Gargul!

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "Sie benötigen eine aktive (entsperrte) GDKP-Sitzung!";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "Wenn dieses Fenster geöffnet ist, fügen Sie %s Artikel zur Liste hinzu oder klicken Sie unten auf „Aus Inventar füllen“."; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Anti-Schnepfen in Sekundenschnelle";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "Der Anti-Snipe-Wert muss 0 (leer) oder >=5 sein";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Gehen Sie zurück zur Artikelauswahl";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Entfernen Sie alle Elemente aus der Liste";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "Aus Lagerbestand befüllen";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Fügen Sie handelbare Gegenstände aus Ihrem Inventar zur Liste hinzu";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Hier legen Sie fest, welche Artikel Sie in Ihre Multi-Auktion-Sitzung aufnehmen möchten

Benutzen Sie die Schaltfläche |c00A79EFFAus Inventar füllen unten, um Gegenstände, die noch gehandelt werden können, zur Liste hinzuzufügen
Wenn Sie dieses Fenster löschen und erneut öffnen, werden Ihre letzten Fülleinstellungen zum automatischen Hinzufügen von Elementen verwendet

|c00A79EFF%s Elemente, um sie manuell zur Liste hinzuzufügen
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Nächster Schritt: Überprüfen Sie die Add-on-Version von Raider auf Kompatibilität";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "Nicht jeder nutzt Gargul. Sind Sie sicher, dass Sie die Auktion starten möchten?";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Wählen Sie mindestens einen Artikel für Ihre Auktion aus";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Ihr Gargul ist veraltet. Wir empfehlen Ihnen, ihn vor Beginn einer Sitzung zu aktualisieren, um Probleme zu vermeiden!";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "Nicht jeder ist auf dem neuesten Stand. Wenn bei Ihnen Probleme auftreten, fordern Sie Ihre Raider auf, ein Update durchzuführen!";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "Es gibt eine aktive Mehrfachauktion. Die hier hinzugefügten Artikel werden der bestehenden Sitzung hinzugefügt. Achten Sie auf doppelte Artikel!";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Suchname oder iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Unterstützt Artikelnamen und iLVL, z. B. '252', '<252' usw";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Aktive GDKP-Sitzung: |c00967FD2%s | Von %s%s | Am |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Auktionszeit in Sekunden";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "Die Auktionszeit in Sekunden muss >= 10 sein";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "Sie sind während Ihrer GDKP-Gebotssitzung gegangen. Um es fortzusetzen, müssen Sie für alle nicht verkauften Artikel eine neue Gebotszeit (in Sekunden) angeben";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "Wenn dieses Fenster geöffnet ist, fügen Sie %s Elemente der Liste hinzu";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "Klicken Sie auf das Zahnradsymbol, um eine Auktion zu verwalten";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "Sie sind bereits der Höchstbietende für %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
Gebot |c00%s%sg
Von %s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%sGESCHLOSSEN
Keine Gebote]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
Minimum: |c00%s%sg
Inkrement: |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "Artikel: %s – Insgesamt verkauft: %sg – Von mir verpfändet: %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
Artikel mit Geboten: %s/%s
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
Von |c0092FF00YOU!]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "Das automatische Bieten für %s konnte nicht gestoppt werden. Versuchen Sie es erneut oder /reload!";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "Automatisches Gebot bis maximal %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "Automatisches Gebot bis zu dem Gebot, das Sie links eingeben";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "Stoppen Sie Ihr automatisches Gebot (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "Das Gebot für %s konnte nicht bestätigt werden";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "Ungültiges oder zu niedriges Gebot! Das Minimum ist %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "Zwischen Geboten für denselben Artikel müssen Sie zwei Sekunden warten";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "Klare Gebote";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "Entfernen Sie alle Gebote aus der Auktion";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "Alle schließen";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "ALLE Auktionen schließen?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
Schließen Sie ALLE Auktionen

Auktionen mit aktiven Geboten werden verkauft und können keine neuen Gebote erhalten!
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "Auktion schließen";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "Schließen Sie die Auktion. Spieler können nicht mehr bieten, aber das Höchstgebot bleibt aktiv";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "Entfernen Sie den Artikel einschließlich seiner Gebotsdetails aus der Auktion. DAS KANN NICHT RÜCKGEGEBEN WERDEN!";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "Alle fertigen, aber nicht verkauften Artikel entzaubern?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
Entzaubern Sie nicht verkaufte Gegenstände

Dadurch werden alle nicht verkauften Artikel als entzaubert markiert und in einer neuen Multi-Auktionssitzung nicht angezeigt
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "Favorit für diesen Artikel";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "Geben Sie einen letzten Anruf-Timer von wie vielen Sekunden an?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "Die Mindestanzahl an Sekunden beträgt 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "Starten Sie einen letzten Aufruf für diese Auktion, indem Sie einen (normalerweise kürzeren) Gebotstimer angeben";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "ALLE Auktionen schließen und diese Sitzung mit mehreren Auktionen abschließen?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
Beenden Sie die Multi-Auktion-Sitzung

Dadurch werden alle Auktionen geschlossen und der gesamte Pot im Chat bekannt gegeben
Auktionen mit aktiven Geboten werden verkauft und können keine neuen Gebote erhalten!
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "Inaktiv ausblenden";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "Unbrauchbar verstecken";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "Abgeschlossene Auktionen ein-/ausblenden";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "Auktion verwalten";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "Bieten Sie den erforderlichen Mindestbetrag";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "Gebotsfenster geschlossen, mit |c00A79EFF/gl-Gebot wieder öffnen!";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "Kündigen Sie Verkäufe im Chat an";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "Beim Überbieten wird ein Ton abgespielt";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "Weitere Soundoptionen...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "Zeige alles";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "Favoriten anzeigen";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "Inaktiv anzeigen";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "Unbrauchbar anzeigen";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "Dieser Artikel wurde verkauft. Verwenden Sie Ledger (|c00%s/gdkp), um Änderungen vorzunehmen!";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "Beenden";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "Alle Gebote/Gebote entfernen und alle Auktionen schließen?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
Beenden Sie die Multi-Auktion-Sitzung

Dadurch werden alle Gebote auf Artikel, die noch nicht verkauft wurden, gelöscht und alle Auktionen geschlossen!
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "Bewegen Sie den Mauszeiger über eine der Schaltflächen unten, um weitere Informationen zu erhalten";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "Elemente anzeigen/ausblenden, die Sie nicht verwenden können";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "Ungültige Daten für GDKP-Auktionsstart angegeben!";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s hat %s für %sg gekauft";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "Der Beutemaster (%s) ist veraltet, dies kann dazu führen, dass Gebote fehlschlagen!";
L.GDKP_MULTIAUCTION_OUTBID = "Du wurdest überboten!";
L.GDKP_MUTATORS = "Mutatoren";
L.GDKP_MUTATOR_ADD = "Mutator hinzufügen";
L.GDKP_MUTATOR_APPLY_LABEL = "Automatisch anwenden auf";
L.GDKP_MUTATOR_CREATE_NEW = "Erstellen Sie einen neuen GDKP-Mutator";
L.GDKP_MUTATOR_DELETE_BYPASS = "Löschen. Halten Sie die Umschalttaste gedrückt, um die Bestätigung zu umgehen";
L.GDKP_MUTATOR_EDIT = "Mutator bearbeiten";
L.GDKP_MUTATOR_FLAT_LABEL = "Pauschaler Goldpreis [Beispiel: 250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "Bei der Pauschale muss es sich um eine Zahl handeln";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
Beispiel:
|c00967FD2SELF,RL,HEALER]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "Sie können diesen Mutator mithilfe von Schlüsselwörtern automatisch auf Raider anwenden:";
L.GDKP_MUTATOR_NAME_LABEL = "Name [Beispiel: Panzer]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Mutatornamen dürfen keine Punkte (.) enthalten.";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Prozentsatz [Beispiel: 10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "Der Prozentsatz muss eine Zahl sein";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Für zukünftige Sitzungen speichern";
L.GDKP_MUTATOR_UNKNOWN = "Unbekannter Mutator: %s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "Benutzer „%s“ ist nicht berechtigt, Auktionen zu starten";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "Benutzer „%s“ ist nicht berechtigt, Auktionen zu stoppen";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "Benutzer „%s“ darf die Auktion nicht stoppen: Auktion ungültig";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "Es gibt nicht genug Gold zum Verteilen, man muss mit seltsamen Kürzungsberechnungen rechnen!";
L.GDKP_NO_BIDS = "Keine Gebote!";
L.GDKP_OUTBID = "Du wurdest überboten!";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(aktiv)";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
Zum Anpassen von Gold benötigen Sie Blei- oder Meisterbeute.
Sie können Gold für gesperrte/gelöschte Sitzungen nicht anpassen]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "Gold hinzufügen/entfernen";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s hat |c00%s%s dafür bezahlt
%S]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333Gelöscht von %s
Gründe dafür]];
L.GDKP_OVERVIEW_DELETED_SESSION = "(gelöscht)";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
Zum Löschen von Einträgen benötigen Sie Lead- oder Master-Loot.
Sie können keine Einträge in gesperrten/gelöschten Sitzungen löschen]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "Geben Sie einen Grund für das Löschen dieses Eintrags an";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "Löschen. Halten Sie die Umschalttaste gedrückt, um die Note zu umgehen";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "Sitzungen mit angehängten Auktionen werden nach 48 Stunden gelöscht";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
Um Einträge zu bearbeiten, benötigen Sie Lead- oder Master-Loot.
Sie können gelöschte Einträge oder Einträge in gesperrten/gelöschten Sitzungen nicht bearbeiten]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "Exportieren Sie eine Sitzung, damit andere Sitzungsdetails sehen oder Sie sogar als Beutemeister ersetzen können";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "Importieren Sie eine Sitzung von einem anderen Spieler oder Konto";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
Zeigen Sie eine vollständige Übersicht über das Hauptbuch an.
Ideal für Screenshotzwecke!]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "Wenn Sie eine Sitzung sperren, können Sie keine Gegenstände versteigern oder auf andere Weise etwas ändern, bis Sie die Sitzung entsperren. Sind Sie sicher?";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "Sperren oder entsperren Sie die Sitzung";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "Sperren Sie die Sitzung für die Auszahlung";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "Mehrfachauktion: Versteigern Sie mehrere Artikel gleichzeitig!";
L.GDKP_OVERVIEW_MUTATION_ADDED = "hinzugefügt zu";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s %s Topf um %s
Anmerkungen]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "entfernt von";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
Topf: %s
Managementkürzung (%s%%): %sg
Pro Spielerschnitt (1/%s): %sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
Um Einträge wiederherzustellen, benötigen Sie Lead- oder Master-Loot.
Einträge gesperrter/gelöschter Sitzungen können nicht wiederhergestellt werden]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "Von %s%s | Am |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "Das Freischalten und Ändern des Pots oder der Cuts kann sehr chaotisch werden, insbesondere wenn Sie bereits Auszahlungen vorgenommen haben. Bist du sicher?";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "Entsperren Sie die Sitzung";
L.GDKP_PAYOUT_INACTIVE = "Keine aktive GDKP-Sitzung erkannt oder Sitzung ist nicht für die Auszahlung gesperrt!";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "Inkrement bzw. Minimum darf nicht kleiner als .0001 sein!";
L.GDKP_PRICE_IMPORT_INVALID_INC = "Ungültiges „Inkrement“ für Element-ID „%s“ angegeben";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "Ungültiges „Minimum“ für Artikel-ID „%s“ angegeben";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "Für die Element-ID %s ist entweder ein Minimum oder ein Inkrement erforderlich";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "Fehlender Header, Hinweis: Groß-/Kleinschreibung wird beachtet!";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Daten für %s Artikel erfolgreich importiert";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "Unbekannte Element-ID: %s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s Gegenstände in Taschen, Beutefenstern oder sogar auf Links in Ihrem Chat, um sie dieser Auktionswarteschlange hinzuzufügen.
Artikel in der Warteschlange werden automatisch versteigert, sobald Ihre aktuelle Auktion abgeschlossen ist. Klicken Sie auf die Schaltfläche „%s“, um dies zu verhindern.

Möchten Sie, dass Gargul Auktionen automatisch für Sie vergibt oder entzaubert? Öffnen Sie das Einstellungsrad auf der linken Seite!

|c00FFF569Wussten Sie schon?
Sie können Elemente per Drag & Drop verschieben
Elemente werden gespeichert, auch wenn Sie |c00A79EFF/neu laden
In der Warteschlange befindliche Gegenstände werden Raidern, die über Gargul verfügen, automatisch angezeigt, damit sie vorab bieten können
Gargul kann auch das automatische Plündern für Sie übernehmen. Probieren Sie es mit |c00A79EFF/gl pm aus
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Verstecken Sie unbrauchbare Gegenstände";
L.GDKP_SESSION = "GDKP-Sitzung";
L.GDKP_SESSION_EDIT_TITLE = "%s wird bearbeitet";
L.GDKP_SHOW_UPCOMING = "Kommende Artikel anzeigen";
L.GDKP_STOP_AUCTION_FIRST = "Stoppen Sie zuerst die Auktion!";
L.GDKP_THEY_OWE = "%s schuldet dir %s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP Sitzung
Von Spieler ausgegeben: %s
Gegeben: %s
Empfangen: %s
Spielerschnitt: %s

%S
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "Aus GDKP ausschließen";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "Das gehandelte Gold wird nicht zum gegebenen oder erhaltenen Betrag addiert";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Gold |c00967FD2an %s übergeben";
L.GDKP_TRADE_GOLD_ADD_FAILED = "%s konnte nicht zum Handelsfenster hinzugefügt werden. Versuchen Sie, es manuell hinzuzufügen!";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "Sie haben nicht genug Geld, um %s zu bezahlen";
L.GDKP_TRADE_GOLD_TO_GIVE = "Zu geben: %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "Zu empfangen: %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Gold |c00967FD2erhalten von %s";
L.GDKP_TRY_MULTIAUCTION = "Schauen Sie sich Multi-Auktionen an!";
L.GDKP_TUTORIAL_INFO = "Befolgen Sie die folgenden Schritte, um schnell mit Gargul GDKP zu beginnen!";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "Aktivieren Sie diese Sitzung, indem Sie unten auf die Schaltfläche |c00FFF569Enable klicken!";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s ein Artikel, um einen einzelnen Artikel zu versteigern oder in die Warteschlange zu stellen"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
Hilfreiche Befehle:
- |c00FFF569/gdkp, um dieses Fenster zu öffnen
- |c00FFF569/gl ma, um das Fenster für mehrere Auktionen zu öffnen
- |c00FFF569/gl au, um den Auktionator / die Warteschlange für einzelne Artikel zu öffnen
- |c00FFF569/gl pm, um automatisches Plündern einzurichten

]];
L.GDKP_TUTORIAL_STEP_DONE = "Wenn alles gut gelaufen ist, sehen Sie hier Ihre frisch versteigerten Artikel!";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "Möchten Sie mehrere Artikel gleichzeitig versteigern? Führen Sie |c00FFF569/gl ma (oder |c00FFF569/gl Multiauction) aus oder klicken Sie auf das Multi-Auktionssymbol oben rechts in diesem Fenster!";
L.GDKP_TUTORIAL_STEP_NEW = "Klicken Sie unten auf die Schaltfläche |c00FFF569Neu, um Ihre erste GDKP-Sitzung zu erstellen. Nach der Erstellung wird es links angezeigt";
L.GDKP_TUTORIAL_STEP_READY = "Sie sind bereit, Artikel zu verkaufen! |c00BE3333Lesen Sie alle Schritte unten sorgfältig durch und testen Sie sie alle selbst (Sie müssen nicht an einem Raid teilnehmen), bevor Sie Ihren ersten GDKP-Raid starten!";
L.GDKP_TUTORIAL_STEP_SELL = "Möchten Sie einen Artikel verkaufen, ohne dass jemand bietet? |c00FFF569%s auf einen Artikel, wählen Sie einen Gewinner aus und legen Sie einen Preis fest!";
L.GDKP_TUTORIAL_TITLE = "Erste Schritte";
L.GDKP_UNKNOWN_ITEM = "Unbekannte Artikel-ID in Auktion:create: %s";
L.GDKP_UNKNOWN_SESSION = "Unbekannter SessionIdentifier in Auction:create: %s";
L.GDKP_YOU_OWE = "Du schuldest %s %s";
L.GIVEN = "Gegeben";
L.GOLD_INDICATOR = "G";
L.GROUP = "Gruppe";
L.GROUP_MANAGER = "Gruppenleiter";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "Auf CurseForge herunterladen";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "Halt";
L.HEADER = "Header";
L.HELLO = "|c00%sGargul v%s von Zhorax@Firemaw. Geben Sie |c00%s/gl oder |c00%s/gargul ein, um loszulegen!";
L.HIDE = "Verstecken";
L.HOURS_MINUTES_FORMAT = "%HM";
L.IDENTITY_INFO = "Besuchen Sie die URL unten, um mehr über die Personalisierung von Gargul GDKPs zu erfahren";
L.IDENTITY_TOOLTIP = "Ihr Logo hier? Klicken Sie für weitere Informationen!";
L.IMPORT = "Importieren";
L.IMPORTED_AND_UPDATED_ON = "Importiert am |c00A79EFF%s um |c00A79EFF%s, Aktualisiert am |c00A79EFF%s um |c00A79EFF%s";
L.IMPORT_EXPLANATION = "Welche Art von Daten möchten Sie importieren?";
L.IMPORT_SUCCESSFUL = "Import der Boosted-Roll-Daten erfolgreich";
L.INC = "Inc";
L.INCLUDE_AWARDED = "Beziehen Sie zuvor ausgezeichnete Artikel mit ein";
L.INCLUDE_BOES = "BOE einbeziehen";
L.INCLUDE_MATERIALS = "Materialien einschließen (wie Abyss-Kristalle)";
L.INCREMENT = "Zuwachs";
L.INFO = "Die Info";
L.INVALID_DATA_WARNING = "Ungültige Daten angegeben";
L.ITEM = "Artikel";
L.JSON_DECODE_WARNING = "JSON-Dekodierung der Daten ist nicht möglich. Stellen Sie sicher, dass Sie es unverändert kopieren/einfügen, ohne zusätzliche Zeichen oder Leerzeichen hinzuzufügen!";
L.KEYS_INFO = [[
Hotkeys für Gargul-Gegenstände

Rollout: |c00A79EFF%s
Auszeichnung: |c00A79EFF%s
Entzaubern: |c00A79EFF%s


-- Klicken Sie mit der rechten Maustaste, um dieses Fenster zu deaktivieren --
]];
L.LEDGER = "Hauptbuch";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "Sie müssen der Meisterplünderer sein oder eine Assistenz-/Hauptrolle übernehmen!";
L.LOCALE_CHANGE_NOTE = "Hinweis: Sie können das Gebietsschema jederzeit in den Einstellungen oder über |c00%s/gl Gebietsschema ändern";
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ENUS = "deUS"; -- English (United States)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_ITIT = "es es"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul postet Chatnachrichten auf Englisch (Standard)
Sie können im Dropdown-Menü unten eine andere Sprache auswählen

Ihre aktuelle Chat-Sprache ist „%s“. Das Aktivieren einer anderen Sprache führt zu einem /reload!
]];
L.LOCALE_NONE_TITLE = "Wählen Sie eine Chat-Sprache für Gargul";
L.LOCALE_PTBR = "ptBR"; -- Portuguese (Brazil)
L.LOCALE_RURU = "ruRU"; -- Russian (Russia)
L.LOCALE_ZHCN = "zhCN"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "zhTW"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "Sie haben ein oder mehrere Add-ons installiert, die möglicherweise zu Fehlfunktionen von Gargul führen können: %s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "SoftRes löschen";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "TMB löschen";
L.LOOTMASTER_DEFAULT_NOTE = "/roll für MS oder /roll 99 für OS";
L.LOOTMASTER_IMPORT_SR_BUTTON = "SoftRes importieren";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "TMB importieren";
L.LOOTMASTER_NOTICE_LABEL = "Ihnen wurde die Rolle des Meisterplünders übertragen";
L.LOOTMASTER_OPEN_LABEL = "Dieses Fenster automatisch öffnen";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Beuteprioritäten erfolgreich gelöscht";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Geben Sie eine Prio-CSV im folgenden Format an (1 Zeile pro Element): id or name > prio1, equalprio > prio2 > usw";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Beuteprioritäten erfolgreich importiert";
L.LOOTPRIORITY_INVALID_DATA = "Ungültige Daten angegeben";
L.LOOTPRIORITY_INVALID_LINE = "Ungültige Daten in Zeile: „%s“: Element-ID oder Priorität fehlt";
L.LOOTPRIORITY_PROCESS_INCOMING = "Es wird versucht, eingehende Beuteprioritäten von %s zu verarbeiten";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Beute Prio";
L.MAIL = "Post";
L.MAILED = "Per Post verschickt";
L.MAIL_CUTS_EXPLANATION = "Mail an Spieler gekürzt";
L.MAINSPEC_ABBR = "MS";
L.MAXIMIZE = "Maximieren";
L.MIN = "Mindest";
L.MINIMAP_BUTTON_AWARDED = "Verliehener Beuteverlauf";
L.MINIMAP_BUTTON_CUTS = "GDKP-Kürzungen";
L.MINIMAP_BUTTON_EXPORT = "Daten exportieren";
L.MINIMAP_BUTTON_GARGUL = "Öffne Gargul";
L.MINIMAP_BUTTON_IMPORT = "Daten importieren";
L.MINIMAP_BUTTON_LEDGER = "GDKP-Hauptbuch";
L.MINIMAP_BUTTON_MULTIAUCTION = "Mehrfachauktion";
L.MINIMAP_BUTTON_SETTING_INFO = "Ändern Sie die Einstellungen in der /gl-Minikarte";
L.MINIMIZE = "Minimieren";
L.MINIMIZE_ON_AWARD = "Prämie minimieren";
L.MINIMIZE_ON_START = "Beim Start minimieren";
L.MINIMUM = "Minimum";
L.MINIMUM_QUALITY = "Mindestqualität";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "Bewegen";
L.MULTI_AUCTION = "Mehrfachauktion";
L.NAME = "Name";
L.NEW = "Neu";
L.NEXT = "Nächste";
L.NO = "NEIN";
L.NONE = "Keiner";
L.NOTE = "Notiz";
L.NOTHING = "Nichts";
L.NO_BIDS_ACTION = "Wenn niemand bietet, tun Sie Folgendes:";
L.NO_OFFICER_PRIVILEGES = "Sie haben keine Offiziersprivilegien";
L.OFFSPEC_ABBR = "Betriebssystem";
L.OK = "OK";
L.OPEN = "Offen";
L.OPEN_AUCTIONEER = "Auktionator öffnen";
L.OPEN_MULTI_AUCTION = "Öffnen Sie eine Mehrfachauktion";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "GIER";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORIEREN";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "BRAUCHEN";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASSIEREN";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "ZUFÄLLIG";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SELBST";
L.PACKMULE_CONFIRM_DISENCHANTER = "%s als Entzauberer festlegen?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "%s an %s senden? Geben Sie /gl cd ein, um diesen Entzauberer zu entfernen!";
L.PACKMULE_NO_DISENCHANTER_WARNING = "Kein Entzauberer festgelegt, verwenden Sie /gl sd [mydisenchanter], um einen festzulegen";
L.PACKMULE_WHO_IS_DISENCHANTER = "Wer ist Ihr Entzauberer?";
L.PAID = "Bezahlt";
L.PASS = "Passieren";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "Spieler";
L.PLAYER_ITEM_WON_COUNT = "Von %s gewonnene Artikel:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "Pluspunkte";
L.PLUSONES_AWARD_DIALOG_LABEL = "Fügen Sie +1 hinzu";
L.PLUSONES_BROADCAST_CONFIRM = "Sind Sie sicher, dass Sie Ihre Plus-Eins-Daten an alle in Ihrer Gruppe/Ihrem Raid übertragen möchten?";
L.PLUSONES_BROADCAST_PROCESS_START = "Es wird versucht, eingehende PlusOnes-Daten von %s zu verarbeiten";
L.PLUSONES_CLEAR_CONFIRM = "%s möchte alle Ihre PlusOne-Daten löschen. Alle Daten löschen?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "Sind Sie sicher, dass Sie Ihre vorhandenen PlusOne-Daten löschen und neue, von %s gesendete Daten importieren möchten?";
L.PLUSONES_IMPORT_CONFIRM = "Sind Sie sicher, dass Sie neue, von %s gesendete Daten importieren möchten?";
L.PLUSONES_IMPORT_ERROR = "Ungültige Daten angegeben. Stellen Sie sicher, dass der Inhalt dem erforderlichen Format entspricht und keine Kopfzeile enthalten ist";
L.PLUSONES_IMPORT_INFO = [[
Hier können Sie Plus-One-Daten aus einer Tabelle im CSV- oder TSV-Format importieren oder aus einem Google Docs-Blatt einfügen.

Die Tabelle benötigt mindestens zwei Spalten: Den Spielernamen gefolgt von der Punktzahl. Zusätzliche Spalten werden ignoriert.

Hier ist eine Beispielzeile:

Foobar,240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Eingehende Broadcasts von %s automatisch akzeptieren";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Blockieren Sie alle eingehenden +1 geteilten Daten";
L.PLUSONES_UPDATE_CONFIRM = [[
Sind Sie sicher, dass Sie Ihre vorhandenen PlusOne-Daten mit Daten von %s aktualisieren möchten?

Ihr letztes Update war auf |c00A79EFF%s, ihres auf |c00A79EFF%s.]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "Topf";
L.PRICE = "Preis";
L.PRIOLIST_ABBR = "PL";
L.QUALITY_COMMON = "Gemeinsam";
L.QUALITY_EPIC = "Epos";
L.QUALITY_HEIRLOOM = "Erbstück";
L.QUALITY_LEGENDARY = "Legendär";
L.QUALITY_POOR = "Arm";
L.QUALITY_RARE = "Selten";
L.QUALITY_UNCOMMON = "Ungewöhnlich";
L.QUEUE = "Warteschlange";
L.RAIDERS = "Räuber";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Wer fehlt";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Fehlende Spielernamen anzeigen";
L.RAIDGROUPS_DISBAND_BUTTON = "Raid auflösen";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Lösen Sie Ihren Überfall auf";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s ist zweimal im Kader aufgeführt!";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "ein |c00FFF569Raid-Helper-Export (Verwenden Sie die Variante „Vertikal sortierte Gruppen“) oder eine |c00FFF569Gargul-Gruppenzusammensetzungs-CSV:";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
Im großen Bearbeitungsfeld unten können Sie einen Dienstplan erstellen und: alle einladen, überprüfen, wer fehlt, Gruppen erstellen und die Panzer zuweisen.

Sie können einen Link zur |c00FFF569Wowhead-Raid-Zusammensetzung bereitstellen:]];
L.RAIDGROUPS_GARGUL_BUTTON = "Wiki der Gargul-Gruppe";
L.RAIDGROUPS_GARGUL_INFO = "Weitere Informationen zum Raid-Gruppenformat finden Sie im Gargul-Gruppen-Wiki";
L.RAIDGROUPS_IMPOSTER_WARNING = "Die folgenden Spieler sind nicht Teil des Kaders: %s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Ungültige Gruppendaten angegeben. Überprüfen Sie Ihr Format!";
L.RAIDGROUPS_INVITE_BUTTON = "Einladen";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Senden Sie Einladungen an Spieler im Kader";
L.RAIDGROUPS_IN_COMBAT_WARNING = "Gruppen können nicht sortiert werden, während %s im Kampf ist!"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "Du musst an einem Raid teilnehmen!";
L.RAIDGROUPS_NO_TANKS_WARNING = "Keine Tanks definiert";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "Sie können keinen Platz für %s finden. Versuchen Sie, mehr als 5 Personen in eine Gruppe einzuteilen?";
L.RAIDGROUPS_PURGE_BUTTON = "Kicken Sie unerwünschte Spieler";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Kicken Sie Spieler, die nicht im Kader stehen";
L.RAIDGROUPS_SORTING_ERROR = "Beim Verschieben von %s ist ein Fehler aufgetreten";
L.RAIDGROUPS_SORTING_FINISHED = "Die Anwendung des Raid-Dienstplans ist abgeschlossen";
L.RAIDGROUPS_SORTING_GROUPS = "Gruppen sortieren";
L.RAIDGROUPS_SORT_BUTTON = "Gruppen anwenden";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Sortieren Sie Gruppen nach Dienstplan";
L.RAIDGROUPS_SORT_IN_PROGRESS = "Die Sortierung ist noch im Gange, warten Sie noch ein wenig!";
L.RAIDGROUPS_TANKS_ASSIGNED = "Alle Tanks sind zugewiesen";
L.RAIDGROUPS_TANK_BUTTON = "Weisen Sie Panzer zu";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Wowhead Comp-Tool";
L.RAIDGROUPS_WOWHEAD_INFO = "Sie können das Wowhead-Comp-Tool über die unten stehende URL besuchen. Nachdem Sie Ihre Komposition erstellt haben, können Sie sie hier oder in das große Bearbeitungsfeld des Gargul-Gruppenfensters einfügen";
L.REMOVE_BID = "Gebot entfernen";
L.RESET_SETTINGS = "Einstellungen zurücksetzen";
L.RESET_SETTINGS_CONFIRMATION = "Sind Sie sicher, dass Sie alle Einstellungen von Gargul zurücksetzen möchten? Dies kann nicht rückgängig gemacht werden!";
L.RESET_UI = "Gargul-Benutzeroberfläche zurücksetzen";
L.RESET_UI_CONFIRMATION = "Sind Sie sicher, dass Sie alle Fenstergrößen, -positionen und -skalen von Gargul zurücksetzen möchten? Dies kann nicht rückgängig gemacht werden!";
L.RESTORE = "Wiederherstellen";
L.RESUME = "Wieder aufnehmen";
L.RIGHT_SYMBOL = ">";
L.ROLL = "Rollen";
L.ROLLING_AWARD_CONFIRM = "%s an %s vergeben?";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Kurz vor der Auszeichnung";
L.ROLLING_CLOSE_ON_START_LABEL = "Beim Start schließen";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Halten Sie die Umschalttaste gedrückt, um die Auszeichnungsbestätigung zu umgehen";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Halten Sie die Umschalttaste gedrückt, um die Auszeichnungsbestätigung anzuzeigen";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
Warnung: Es wurde ein weiterer identischer Wurf gefunden, der auf ein Unentschieden hinweisen kann

]];
L.ROLLING_INVALID_START_DATA_WARNING = "Ungültige Daten für Startrolle angegeben!";
L.ROLLING_ITEM_WON_BR_COST = "(BR: %s)";
L.ROLLING_ITEM_WON_GIVEN = "(Angabe: ja)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(Gegebener Artikel: nein)";
L.ROLLING_ITEM_WON_OS = "(Betriebssystem)";
L.ROLLING_NOTE_LABEL = "NOTIZ";
L.ROLLING_NO_ROLLOFF_WARNING = "Der Roll-Off kann nicht gestoppt werden, da kein Roll-Off im Gange ist";
L.ROLLING_PASS_BUTTON = "Passieren";
L.ROLLING_REOPEN_ROLL_COUNT = "rollt: %s";
L.ROLLING_REOPEN_TOOLTIP = "Öffnen Sie das Master-Looter-Fenster";
L.ROLLING_ROLL_ACCEPTED = "Rolle angenommen!";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "Derzeit wird ein Rollout durchgeführt";
L.ROLLING_ROLL_PRIOLIST = "Priorität [%s]";
L.ROLLING_ROLL_SR_COUNT = "SR [%sx]";
L.ROLLING_ROLL_WISHLIST = "Wunsch [%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "Sie müssen zuerst einen Spieler auswählen";
L.ROLLING_TIMER_LABEL = "TIMER (s)";
L.ROLLING_UNUSABLE_ITEM = "Sie können diesen Artikel nicht verwenden!";
L.ROLLING_WINNER_NOT_UNIQUE = "Der Name des Gewinners ist nicht eindeutig. Wählen Sie den Spieler aus, dem Sie %s verleihen möchten";
L.SECONDS_ABBR = "S";
L.SELECT_ALL = "Alle auswählen/deaktivieren";
L.SESSION = "Sitzung";
L.SETTINGS = "Einstellungen";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Geben Sie eingehende Gebote bekannt";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Geben Sie den Topf nach der Vergabe des Gegenstands bekannt";
L.SETTINGS_ANNOUNCE_START = "Auktionsstart bekannt geben";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Countdown in der Raid-Warnung ankündigen";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Kündigen Sie eingehende Gebote in der Raid-Warnung an";
L.SETTINGS_RESET_UI = "Gargul-Benutzeroberfläche zurücksetzen";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Flüsterbieter, wenn das Gebot zu niedrig ist";
L.SILVER_INDICATOR = "S";
L.SKIP = "Überspringen";
L.SOFTRES = "Soft-Reserven";
L.SOFTRES_ABBR = "SR";
L.SOFTRES_BROADCAST_CONFIRM = "Sind Sie sicher, dass Sie Ihre Softres-Daten an alle Mitglieder Ihrer Gruppe/Ihres Raids übertragen möchten?";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "Die von %s empfangenen SoftRes-Daten konnten nicht verarbeitet werden";
L.SOFTRES_CLEAR_CONFIRM = "Sind Sie sicher, dass Sie alle vorhandenen Soft-Reserve-Daten löschen möchten?";
L.SOFTRES_EVERYONE_RESERVED = "Jeder füllte seine Soft-Reserven auf";
L.SOFTRES_FEATURE_MISSING = [[
Informationen zu harten Reserven sind aufgrund der weichen Reserven nicht verfügbar
Die bereitgestellten Dateien wurden nicht über die Schaltfläche „Gargul Export“ auf softres.it generiert]];
L.SOFTRES_IMPORT_DETAILS = "Importiert am |c00A79EFF%s um |c00A79EFF%s";
L.SOFTRES_IMPORT_FIXED_NAME = "Automatische Namenskorrektur: Die SR von „%s“ ist jetzt mit „%s“ verknüpft.";
L.SOFTRES_IMPORT_INFO = "Um zu beginnen, müssen Sie zunächst einen Raid auf softres.it erstellen. Klicken Sie anschließend auf „Addon Export“, wählen Sie „Gargul“, kopieren Sie die Daten und fügen Sie sie in das untenstehende Formular ein.";
L.SOFTRES_IMPORT_INVALID = "Es wurden ungültige Soft-Reserve-Daten bereitgestellt";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Ungültige Daten angegeben. Klicken Sie unbedingt auf die Schaltfläche „Gargul Export“ auf softres.it und fügen Sie den gesamten Inhalt hier ein";
L.SOFTRES_IMPORT_NEW_PLUSONES = "Die bereitgestellten PlusOne-Werte kollidieren mit den bereits vorhandenen. Möchten Sie Ihre alten PlusOne-Werte ersetzen?";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "Die folgenden Spieler haben nichts reserviert:";
L.SOFTRES_IMPORT_SUCCESSFUL = "Soft-Reserven erfolgreich importiert";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "Import erfolgreich!";
L.SOFTRES_IMPORT_USE_GARGUL = "SoftRes Weakaura- und CSV-Daten sind veraltet. Verwenden Sie stattdessen den Gargul-Export!";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "Verbindung zu LootReserve konnte nicht hergestellt werden. Wenden Sie sich an den Support (fügen Sie die Nachricht unten ein).";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "Keine softres.it-URL verfügbar. Stellen Sie sicher, dass Sie den Export über die Schaltfläche „Gargul Export“ auf softres.it durchgeführt haben!";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "Klicken Sie hier, um Informationen zur Festreserve anzuzeigen";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "Es sind keine Artikel fest reserviert";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "Keine Informationen zur Festreserve verfügbar";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "Posten Sie fehlende SRs";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "SR-URL posten";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "Dieser Spieler hat nichts reserviert!";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "Es wird versucht, eingehende SoftRes-Daten von %s zu verarbeiten";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "Dieser Artikel ist fest reserviert";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "Für: %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Hinweis: %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Reserviert von";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "Etwas ist schief gelaufen!";
L.START = "Start";
L.STOP = "Stoppen";
L.TAB_REPLACES_T = "	 is replaced by a tab";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "Zeit";
L.TITLE = "Titel";
L.TMBETC = "TMB, DFT oder PRIO3";
L.TMB_BROADCAST_CONFIRM = "Sind Sie sicher, dass Sie Ihre TMB-Daten an alle Mitglieder Ihrer Gruppe/Ihres Raids übertragen möchten? Hinweis: JEDER kann Ihre TMB-Daten sehen, unabhängig von seinen Berechtigungen auf der TMB-Website!";
L.TMB_BROADCAST_PROCESS_START = "Es wird versucht, eingehende TMB-Daten von %s zu verarbeiten";
L.TMB_CLEAR_CONFIRM = "Sind Sie sicher, dass Sie alle Daten plus eins löschen möchten?";
L.TMB_CLEAR_RAIDER_DATA = "Raider-Daten löschen";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "TMB-Daten für alle Raider löschen?";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "Automatisches Teilen aktiviert: %s";
L.TMB_IMPORT_CPO_INFO = "Klicken Sie bei Ihrem classicpr.io-Lauf auf die Schaltfläche „Gargul Export“ und kopieren Sie den Inhalt. Fügen Sie anschließend den Inhalt unverändert in das Feld unten ein und klicken Sie auf „Importieren“. Das ist es!";
L.TMB_IMPORT_DETAILS = "Importiert am ${date} um ${time}";
L.TMB_IMPORT_DFT_INFO = "Exportieren Sie Ihre DFT-Daten gemäß den Anweisungen auf dem Blatt. Fügen Sie anschließend den Inhalt unverändert in das Feld unten ein und klicken Sie auf „Importieren“. Das ist es!";
L.TMB_IMPORT_INVALID_CSV = "Es wurde eine ungültige CSV-Datei bereitgestellt. Das Format lautet: 6948,Spieler1,Spieler2";
L.TMB_IMPORT_INVALID_DFT = "Es wurden ungültige DFT-Daten bereitgestellt. Exportieren Sie Ihre DFT-Daten gemäß den Anweisungen auf dem Blatt und fügen Sie den Inhalt unverändert hier ein!";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Es wurden ungültige TMB-Daten bereitgestellt. Klicken Sie unbedingt auf die Schaltfläche „Herunterladen“ im Gargul-Bereich und fügen Sie den Inhalt unverändert hier ein!";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Es wurden ungültige TMB- oder DFT-Daten bereitgestellt. Stellen Sie sicher, dass Sie die Exportinhalte unverändert hier einfügen!";
L.TMB_IMPORT_NOTES_AVAILABLE = "Prioritätsnotizen verfügbar: %s";
L.TMB_IMPORT_NUMBER = "Anzahl der importierten Elemente: %s";
L.TMB_IMPORT_PLAYER_NO_DATA = "Die folgenden Spieler haben keine %s Einträge:"; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "So verwenden Sie Gargul mit TMB";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "Fügen Sie den Inhalt Ihres TMB-Exports unverändert in das Feld unten ein und klicken Sie auf „Importieren“.";
L.TMB_NO_BROADCAST_TARGETS = "Es gibt niemanden in Ihrer Gruppe, an den Sie senden können";
L.TMB_SYNCED = "TMB-Daten synchronisiert";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF Hinweis: |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(Betriebssystem)";
L.TMB_TOOLTIP_PRIO_HEADER = "%s Prio-Liste"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF Stufe: %s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "TMB-Wunschliste";
L.TOGGLE_DATES = "Termine ein-/ausblenden";
L.TOGGLE_QUEUE = "Warteschlange ein-/ausblenden";
L.TRADETIME_AWARD_HOWTO = "%s, um Beute zu vergeben!";
L.TRADETIME_ROLL_HOWTO = "%s bringt Beute raus!";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "Alle ausgezeichneten Gegenstände ausblenden";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "Verstecke entzauberte Gegenstände";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "Gegenstände, die man sich selbst zuerkannt hat, ausblenden";
L.TRADE_ANNOUNCE = "Handel ankündigen";
L.TRADE_ANNOUNCE_INFO = "Geben Sie Handelsdetails der Gruppe oder in /say bekannt, wenn Sie nicht in einer Gruppe sind";
L.TUTORIAL = "Lernprogramm";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s Gegenstände in Taschen, Beutefenstern oder sogar auf Links in Ihrem Chat, um sie zur Auktionswarteschlange hinzuzufügen.
Möchten Sie einen Artikel direkt verkaufen, ohne zu bieten? Verwenden Sie |c00A79EFF%s

Sie können das %s-Fenster direkt öffnen, indem Sie |c00A79EFF/gl Auktion eingeben

Gargul verfolgt |c00FF0000ALL gehandeltes Gold. Möchten Sie nicht, dass ein Trade Teil dieser GDKP-Sitzung ist? Aktivieren Sie beim Handel das Kontrollkästchen „Vom GDKP ausschließen“!

|c00FFF569Wussten Sie schon?
Prämierte Gegenstände werden automatisch zum Handelsfenster hinzugefügt
Gargul kann auch das automatische Plündern für Sie übernehmen. Probieren Sie es mit |c00A79EFF/gl pm aus
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
In diesem Fenster werden alle Gegenstände angezeigt, die an einem bestimmten Datum verliehen wurden (wählen Sie links ein oder mehrere Daten aus).

Elemente können die folgenden Tags enthalten:

|c00A79EFFOS: Ausgezeichnet für Offspec
|c00A79EFFSR: Dieses Element wurde vorläufig reserviert
|c00A79EFFWL: Dieser Artikel wurde auf die Wunschliste gesetzt (Thatsmybis)
|c00A79EFFPL: Dieser Artikel wurde priorisiert (Thatsmybis, DFT, prio3)
]];
L.TUTORIAL_BIDDER_QUEUE = [[
Die Gegenstände, die Sie hier sehen, befinden sich in der GDKP-Warteschlange des Meisterplünders
Sie können sie entfernen, darauf bieten und unbrauchbare Artikel ausblenden (aktivieren Sie „Unbrauchbare Artikel ausblenden“ in den Einstellungen oben links).

Sie können die Größe des Fensters ändern, es verschieben oder minimieren. Versuch es!

Für Beutemeister: Wenn Sie Gegenstände hier entfernen, werden sie nur aus Ihrer persönlichen Warteschlange entfernt, nicht aus der tatsächlichen GDKP-Warteschlange!
]];
L.TUTORIAL_MORE_HELP = "Benötigen Sie weitere Hilfe?";
L.TYPE = "Typ"; -- As in type of roll or type of item
L.UNKNOWN = "Unbekannt";
L.UNKNOWN_COMM_ACTION = "Unbekannte Kommunikationsaktion „%s“, aktualisieren Sie unbedingt Gargul!";
L.UNLOCK = "Freischalten";
L.UPDATE_GARGUL = "Aktualisiere Gargul!";
L.VERSION_ABBR = "v";
L.VERSION_CHECK_BUTTON_REPORT = "Bericht";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Veraltete Ergebnisse im Gruppenchat melden";
L.VERSION_CHECK_COLUMN_STATUS = "Gargul-Status";
L.VERSION_CHECK_STATUS_CHECKING = "Version wird geprüft...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s: Der Player ist auf dem neuesten Stand
|c00F7922Ev%s: Der Spieler muss seine Add-ons aktualisieren
|c00BE3333%s: Der Player verfügt nicht über Gargul oder nutzt eine nicht unterstützte Version
|c00808080%s: Der Spieler ist offline oder ignoriert uns!
|c0000FFFF%s: Der Spieler steht auf unserer Ignorierliste!

]];
L.VERSION_CHECK_STATUS_IGNORED = "SPIELER IGNORIERT!";
L.VERSION_CHECK_STATUS_OFFLINE = "Offline";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "Keine Antwort";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "Keine Antwort:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Offline:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "Veraltet:";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "Auf dem Laufenden:";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul ist veraltet und funktioniert erst, wenn Sie ein Update durchführen!";
L.VERSION_INVALID_WARNING = "Ungültige Versionszeichenfolge in Version:addRelease angegeben";
L.VERSION_UPDATE = "Aktualisiere Gargul!";
L.VERSION_UPDATED = "|c00%sGargul wird jetzt auf |c00%sv%s aktualisiert";
L.VERSION_UPDATE_AVAILABLE = "v|c00A79EFFv%s ist auf CurseForge/Wago verfügbar. Sie können aktualisieren, ohne Ihr Spiel zu schließen. Stellen Sie einfach sicher, dass Sie /reload ausführen!";
L.WINDOW = "Fenster";
L.WINDOW_HEADER = "Gargul v%s";
L.WINDOW_SCALE = "Fensterskalierung";
L.WISHLIST_ABBR = "WL";
L.YES = "Ja";
L.YOU_DISABLED_GDKP_QUEUES = "Sie haben GDKP-Warteschlangen deaktiviert";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "Zlib-Komprimierung der Daten ist nicht möglich. Kontaktieren Sie den Support über https://discord.gg/D3mDhYPVzf";
L.ZLIB_DECOMPRESS_WARNING = "Zlib kann die Daten nicht dekomprimieren. Stellen Sie sicher, dass Sie es unverändert kopieren/einfügen, ohne zusätzliche Zeichen oder Leerzeichen hinzuzufügen!";
