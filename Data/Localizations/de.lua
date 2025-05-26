--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "deDE") then return; end
local L = Gargul_L or {};

L["About"] = "Über";
L["All Settings"] = "Alle Einstellungen";
L["Announce"] = "Bekannt geben";
L["Anti Snipe"] = "Anti-Snipe";
L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"] = [[

Ein Anti-Snipe-Wert von 10 bedeutet, dass jedes eingehende Gebot mit
weniger als 10 Sekunden verbleibend auf einen Timer von 10 Sekunden zurückgesetzt wird.

Du kannst dieses Feld leer lassen oder auf 0 setzen, um Anti-Snipe vollständig zu deaktivieren.
Anti-Snipe-Werte unter 5 werden nicht unterstützt

]];
L["Are you sure?"] = "Bist du sicher?";
L["\nDon't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --"] = [[
Vergiss nicht, stattdessen Gargul zu verwenden
wenn du die Beute später exportieren möchtest


-- Klick mit der rechten Maustaste, um dieses Fenster zu deaktivieren --]];
L["Auction"] = "Auktion";
L["Auctioneer"] = "Auktionator";
L["Auctions"] = "Auktionen";
L["Auto"] = "Auto";
L["Auto award"] = "Auto-Verleihung";
L["Auto trade"] = "Autohandel";
L["Available values:"] = "Verfügbare Werte:";
L["Award"] = "Verleihen";
L["Awarded To"] = "Ausgezeichnet für";
L["BR: %s"] = "BR: %s";
L["Price: %s"] = "Preise";
L["Given: yes"] = "Gegeben: ja";
L["Given: no"] = "Gegeben: nein";
L["2nd bid: %s by %s"] = "2. Gebot: %s von %s";
L["You won"] = "Du hast gewonnen";
L["Award %s to %s?"] = "%s an %s verleihen?";
L["Are you sure you want to disenchant %s? %s boosted roll points will be refunded!"] = "Bist du sicher, dass du %s entzaubern möchtest? %s geboostete Rollpunkte werden zurückerstattet!";
L["In Group"] = "In einer Gruppe";
L["Award history"] = "Verleihungsverlauf";
L["Who should %s go to instead?"] = "Zu wem sollte %s stattdessen gehen?";
L["Type player name here"] = "Gib hier den Namen des Spielers ein";
L["or select one below"] = "oder wähle unten einen aus";
L["Do you want to award %s to a random player?"] = "Möchtest du %s an einen zufälligen Spieler verleihen?";
L["Drag and drop or shift+click an item in the box on the right"] = "Zieh ein Element per Drag-and-Drop oder bei gedrückter Umschalttaste in das Feld rechts";
L["(BR: %s)"] = "(BR: %s)";
L["Disenchanted items:"] = "Entzauberte Gegenstände:";
L["(Given: yes)"] = "(Gegeben: ja)";
L["(Given: no)"] = "(Gegeben: nein)";
L["(OS)"] = "(Betriebssystem)";
L["%s boosted roll points will be refunded!"] = "%s geboostete Rollpunkte werden zurückerstattet!";
L["Are you sure you want to undo %s awarded to %s?%s"] = "Bist du sicher, dass du %s, das %s zugeteilt wurde, rückgängig machen möchtest?%s"; -- The last %s is the content of L["%s boosted roll points will be refunded!"]
L["Bag inspection failed: no reports received"] = "Tascheninspektion fehlgeschlagen: Keine Berichte erhalten";
L["Inspection finished"] = "Inspektion beendet";
L["Starting inspection..."] = "Inspektion beginnt...";
L["Balance"] = "Saldo";
L["Base"] = "Basis";
L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Die Base64-Dekodierung der Daten ist nicht möglich. Stell sicher, dass du es unverändert kopiert/eingefügt hast, ohne zusätzliche Zeichen oder Leerzeichen hinzuzufügen!";
L["Bid"] = "Bieten";
L["Bids"] = "Gebote";
L["BOE"] = "BOE";
L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"] = "1. Gruppen automatisch aus der Raid-Anmeldung einladen/sortieren! Klick unten oder verwende |c00A79EFF/gl gr";
L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"] = "2. Belohne Spieler dafür, dass sie Stammspieler sind oder die Extrameile gehen! Klick unten oder verwende |c00A79EFF/gl br";
L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"] = "Gargul hat ein paar Tricks auf Lager, die dir vielleicht nicht bewusst sind. Schau mal rein!";
L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"] = "3. Gargul beinhaltet ein Plus-One-Tracking-System! Klick unten oder verwende |c00A79EFF/gl po";
L["Boosted Rolls"] = "Boosted Rolls";
L["BR"] = "BR";
L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"] = [[
Wie viele Punkte addierst du für alle, die derzeit am Raid teilnehmen?

|c00BE3333Verwende zuerst die Schaltfläche „Fehlende Raider hinzufügen“, wenn du möchtest, dass jeder Punkte erhält, auch diejenigen ohne einen Boosted-Rolls-Eintrag!]];
L["No point value provided!"] = "Kein Punktewert angegeben!";
L["Add points to raid"] = "Füge dem Raid Punkte hinzu";
L["Add missing raiders"] = "Fehlende Raider hinzufügen";
L["Aliases"] = "Aliase";
L["Apply aliases"] = "Aliase anwenden";
L["Boosted Roll Cost:"] = "Erhöhte Rollkosten:";
L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"] = "Bist du sicher, dass du deine Boosted-Rolls-Daten an alle in deiner Gruppe/deinem Raid übertragen möchtest?";
L["Nothing to broadcast, import Boosted Rolls data first!"] = "Nichts zum Senden, importiere zuerst die Boosted-Rolls-Daten!";
L["Couldn't process BoostedRolls data received from %s"] = "Die von %s empfangenen Boosted-Rolls-Daten konnten nicht verarbeitet werden";
L["Attempting to process incoming BoostedRolls data from %s"] = "Es wird versucht, eingehende Boosted-Rolls-Daten von %s zu verarbeiten";
L["Are you sure you want to clear all boosted roll data?"] = "Bist du sicher, dass du alle Boosted-Roll-Daten löschen möchtest?";
L["Delete %s?"] = "%s löschen?";
L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"] = "Bist du sicher, dass du deine bestehenden Boosted-Roll-Daten löschen und neue, von %s gesendete Daten importieren möchtest?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Ungültige Daten angegeben. Stell sicher, dass der Inhalt dem erforderlichen Format entspricht und keine Kopfzeile enthalten ist";
L["\nHere you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo"] = [[
Hier kannst du Boosted-Roll-Daten und Aliase aus einer Tabelle im CSV- oder TSV-Format importieren oder aus einem Google Docs-Blatt einfügen.

Die Tabelle benötigt mindestens zwei Spalten: Den Spielernamen gefolgt von der Punktzahl. Zusätzliche Spalten sind optional und können Aliase für den Player enthalten.
Hier ist eine Beispielzeile:

Foobar,240,Barfoo]];
L["Points"] = "Punkte";
L["Reserve"] = "Reserviert";
L["\nAre you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Bist du sicher, dass du deine bestehenden Boosted-Rolls-Daten von %s aktualisieren möchten?

Dein letztes Update war |c00A79EFF%s, ihres |c00A79EFF%s.]];
L["!bonus|!rb|!br"] = "!bonus|!rb|!br";
L["Broadcast"] = "Übertragung";
L["Broadcasting..."] = "Sende Übertragung...";
L["You are currently in combat, delaying broadcast"] = "Du befindest dich derzeit im Kampf und verzögerst die Übertragung";
L["Broadcast finished!"] = "Übertragung beendet!";
L["Include awarded items"] = "Beziehe verliehene Gegenstände mit ein";
L["Include disenchanted items"] = "Schließe entzauberte Gegenstände ein";
L["Include hidden items"] = "Schließe ausgeblendete Gegenstände ein";
L["Include time left"] = "Berücksichtige die verbleibende Zeit";
L["Broadcast still in progress"] = "Die Übertragung läuft noch";
L["There is nothing to broadcast"] = "Es gibt nichts zu senden";
L["Number of items"] = "Anzahl der Gegenstände";
L["Broadcast ${percentage}%"] = "Übertragung ${percentage}%";
L["Target player (whisper only)"] = "Zielspieler (nur Flüstern)";
L["Whisper requires a target player"] = "Flüstern erfordert einen Zielspieler";
L["Max trade time left (in minutes)"] = "Maximal verbleibende Handelszeit (in Minuten)";
L["by"] = "von"; -- As in 'bid BY'
L["Cancel"] = "Abbrechen";
L["Get support or share ideas on our Discord"] = "Suche dir Hilfe oder teile deine Ideen auf unserem Discord";
L["Enable changelog"] = "Änderungsprotokoll aktivieren";
L["Gargul makes handing out loot super easy, click the button below to get started!"] = "Gargul macht das Verteilen von Beute ganz einfach. Klick auf die Schaltfläche unten, um loszulegen!";
L["Open Gargul"] = "Öffne Gargul";
L["Adjust Scale"] = "Maßstab anpassen";
L["Channel"] = "Kanal";
L["Officer"] = "Offizier";
L["Raid Warning"] = "Raid-Warnung";
L["Whisper"] = "Flüstern";
L["CPR"] = "CPR";
L["Clear"] = "Leeren"; -- As in clearing a window or data
L["Close"] = "Schließen";
L["Close on award"] = "Bei Verleihung schließen";
L["Close on start"] = "Beim Starten schließen";
L["Communication"] = "Kommunikation";
L["Sent %s of %s bytes"] = "%s von %s Bytes wurden gesendet";
L["c"] = "C";
L["Cut"] = "Anteil";
L["Cuts"] = "Anteile";
L["Can't send mail when the mailbox is closed"] = "Es kann keine Post gesendet werden, wenn der Briefkasten geschlossen ist";
L["Multiple mail errors detected, aborting cut distribution"] = "Es wurden mehrere Post-Fehler festgestellt, wodurch die Verteilung der Anteile abgebrochen wurde";
L["You don't owe %s any gold"] = "Du schuldest %s kein Gold";
L["Failed to send cut to %s"] = "Der Anteil konnte nicht an %s gesendet werden";
L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"] = "Die Post wurde laut Spiel GESENDET, aber dein verbleibendes Gold stimmt nicht überein. Ist etwas schief gelaufen?";
L["Mail History for |c00967FD2%s"] = "Post-Verlauf für |c00967FD2%s";
L["You don't have enough gold to pay %s"] = "Du hast nicht genug Gold, um %s zu bezahlen";
L["Wait a bit, we're still processing the previous mail"] = "Warte etwas, wir bearbeiten noch die vorherige Post";
L["Gargul GDKP: %sg"] = "Gargul GDKP: %sg";
L["Sent %sg to %s"] = "%sg an %s gesendet";
L["%Y-%m-%d"] = "%Y-%m-%d";
L["%Y-%m-%d %H:%M"] = "%Y-%m-%d %H:%M";
L["%d-%m %H:%M"] = "%d-%m %H:%M";
L["Delete"] = "Löschen";
L["Details"] = "Details";
L["DFT"] = "DFT";
L["Disable"] = "Deaktivieren";
L["https://discord.gg/D3mDhYPVzf"] = "https://discord.gg/D3mDhYPVzf";
L["Disenchant"] = "Entzaubern";
L["Edit"] = "Bearbeiten";
L["Enable"] = "Aktivieren";
L["Export"] = "Export";
L["Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!"] = "Bist du sicher, dass du deinen vollständigen Verleihungsverlauf entfernen möchtest? Dadurch werden ALLE Beutedaten gelöscht und können nicht rückgängig gemacht werden!";
L["Are you sure you want to remove all data for %s? This cannot be undone!"] = "Bist du sicher, dass du alle Daten für %s entfernen möchtest? Das kann nicht rückgängig gemacht werden!";
L["\nThis is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n"] = [[
Dies ist NUR eine Exportfunktion. Es macht keinen Sinn, die Werte zu bearbeiten: SIE WERDEN NICHT GESPEICHERT!

]];
L["Fill"] = "Füllen";
L["Final Call"] = "Letzter Aufruf";
L["Finish"] = "Beenden";
L["Format"] = "Format";
L["Gargul"] = "Gargul";
L["GDKP"] = "GDKP";
L["GDKP raids are not allowed in this version of World of Warcraft"] = "GDKP-Raids sind in dieser Version von World of Warcraft nicht erlaubt";
L["GDKP Active!"] = "GDKP Aktiv!";
L["Add dropped loot to queue"] = "Füge neu gedroppte Beute zur Warteschlange hinzu";
L["Gold (- for removing gold)"] = "Gold (- zum Entfernen von Gold)";
L["Who pays for this?"] = "Wer bezahlt das?";
L["Gold needs to be lower/higher than 0"] = "Gold muss niedriger/höher als 0 sein";
L["Paid for by"] = "Bezahlt von";
L["Adjust gold in %s"] = "Gold in %s anpassen";
L["You can't give AND receive gold from the same player at the same time"] = "Du kannst nicht gleichzeitig demselben Spieler Gold geben UND erhalten";
L["All cuts were mailed!"] = "Alle Anteile wurden per Post verschickt!";
L["Disable for disenchanted"] = "Deaktivieren für entzauberte Gegenstände";
L["Disable in combat"] = "Im Kampf deaktivieren";
L["Auctions"] = "Auktionen";
L["Created by"] = "Erstellt von";
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Gelöscht von %s
Gründe dafür]];
L["\n|c00%s%s added to pot by %s\nNote: %s"] = [[
|c00%s%sg von %s zum Pott hinzugefügt
Anmerkungen]];
L["Won by"] = "Gewonnen von";
L["Set paid amount (read left)"] = "Bezahlten Betrag festlegen (siehe links)";
L["\n\nGargul automatically keeps track of gold traded. As long as players pay\nfor what they bought then you shouldn't ever need this field\n\n'Paid amount' refers to the amount of gold the buyer already traded you.\nThis does not change the actual price of the item!\n\nWarning: only set a value here if the player promises to pay\noutside of the raid or trades the gold from an alt / mail etc!\n\n\n"] = [[

Gargul behält automatisch den Überblick über das gehandelte Gold. Solange die Spieler für das zahlen, was sie gekauft haben, solltest du dieses Feld niemals benötigen

„Bezahlter Betrag“ bezieht sich auf die Goldmenge, die dir der Käufer bereits im Handel gegeben hat.
Der tatsächliche Preis des Gegenstandes ändert sich dadurch nicht!

Achtung: Leg hier nur einen Wert fest, wenn der Spieler eine Zahlung außerhalb des Raids verspricht
oder das Gold von einem Alt / per Post usw. handelt!


]];
L["GDKP Price:"] = "GDKP-Preis:";
L["Award %s to %s for %s?"] = "%s an %s für %s verleihen?";
L["Auto Bid"] = "Auto Bieten";
L["What's your maximum bid? (Minimum %s|c00FFF569g)"] = "Wie hoch ist dein Höchstgebot? (Minimum %s|c00FFF569g)";
L["Bid denied!"] = "Gebot abgelehnt!";
L["Min bid: %sg   Increment: %sg"] = "Mindestgebot: %sg Inkrement: %sg";
L["(max %sg)"] = "(maximal %sg)";
L["New bid"] = "Neues Gebot";
L["Stop Auto Bid"] = "Stop Auto";
L["Top bid: %s by %s"] = "Höchstgebot: %s von %s";
L["Top bid: %s by you"] = "Höchstgebot: %s von Dir";
L["Create a new GDKP session"] = "Erstell eine neue GDKP-Sitzung";
L["Management Cut %"] = "Managementanteil %";
L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"] = "Managementanteil muss leer sein oder zwischen 0 und 99 liegen (kein %-Zeichen!)";
L["Choose a session type!"] = "Wähl einen Sitzungstyp!";
L["Switch to this session"] = "Wechsel zu dieser Sitzung";
L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"] = [[

|c00A79EFFMehrfachauktion ermöglicht es dir, Gebote für mehrere Gegenstände gleichzeitig abzugeben, was die Sache beschleunigt!
Befolge die Anweisungen nach dem Erstellen dieser Sitzung, um zu beginnen

Mit |c00A79EFFEinzelauktion kannst du stattdessen einzelne Gegenstände versteigern oder die Warteschlange benutzen

Durch die Auswahl von |c00A79EFFMehrfachauktion wird verhindert, dass gedroppte Gegenstände zur Warteschlange hinzugefügt werden
Du kannst |c00A79EFFMehrfachauktion mit |c00A79EFFEinzelauktion und der Warteschlange kombinieren, wir raten jedoch dringend davon ab

]];
L["Auction type (|c00A79EFFi for more info)"] = "Auktionstyp (|c00A79EFFi für weitere Informationen)";
L["Multi-Auction"] = "Mehrfachauktion";
L["Single-Auction"] = "Einzelauktion";
L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"] = "Sitzung erstellt. Wir empfehlen dir, /reload zu verwenden, damit es vernünfitg gespeichert wird, falls dein Spiel abstürzt!";
L["Add Raider"] = "Raider hinzufügen";
L["adjust [g]"] = "anpassen [g]";
L["adjust [%]"] = "anpassen [%]";
L["Announce the base cut in group chat"] = "Kündige den Basisanteil im Gruppenchat an";
L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"] = "Bist du sicher, dass du alle Spieler und Berechnungen zurücksetzen möchtest? Hinweis: Alle Spieler, die nicht mehr am Raid teilnehmen, werden aus der Liste entfernt!";
L["Delete Raider"] = "Raider löschen";
L["Edit Raider"] = "Raider bearbeiten";
L["Lock and Pay"] = "Abschließen und bezahlen";
L["Manage gold trades"] = "Verwalte Goldhandel";
L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"] = [[

Mit Mutatoren kannst du den Spielern mehr oder weniger Gold geben
Beispiel: Mutatoren sind dafür gedacht, Tanks 2 % mehr zu geben!

Hinweis: Wenn Sie Mutatoren hier bearbeiten oder löschen, werden sie nur für diese Sitzung geändert

]];
L["Not in the raid"] = "Nicht im Raid";
L["\n\nThe total payout can differ slightly from the pot due to rounding differences!\nPlayers currently in the raid can not be edited or removed!\n\nColor explanation:\n|c00F7922E(2000g) Means you owe this person 2000g\n|c00BE3333(3000g) Means this person owes you 3000g\n|c0092FF00(0) Means that you're square\n\nAdjuster explanation:\nWith adjust [g] you can add/deduct gold to a player (use -50 to deduct 50 gold from a player's cut)\nWith adjust [%] you can add/deduct a percentage to a player (use -50 to give players a half cut)\n"] = [[

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
L["%s Raiders | %s With cut | Total payout: %s"] = "%s Raiders | %s Mit Anteil | Gesamtauszahlung: %sg";
L["Nothing to import, double check your CSV"] = "Es gibt nichts zu importieren. Überprüfe deine CSV-Datei noch einmal";
L["Missing gold for player %s"] = "Es fehlt Gold für Spieler %s";
L["Missing header, note: it's case-sensitive!"] = "Fehlender Header, Hinweis: Groß-/Kleinschreibung wird beachtet!";
L["Missing player name"] = "Fehlender Spielername";
L["Delete bid. Auction must be stopped first!"] = "Gebot löschen. Die Auktion muss zuerst gestoppt werden!";
L["Add a raider to this session"] = "Füge dieser Sitzung einen Raider hinzu";
L["Custom (create your own format)"] = "Benutzerdefiniert (erstell dein eigenes Format)";
L["Detailed (JSON)"] = "Detailliert (JSON)";
L["Share (can be imported by other players)"] = "Teilen (kann von anderen Spielern importiert werden)";
L["Your custom format"] = "Dein individuelles Format";
L["Your custom header"] = "Dein benutzerdefinierter Header";
L["Custom (create your own format)"] = "Benutzerdefiniert (erstell dein eigenes Format)";
L["@PLAYER,@CUT"] = "@PLAYER,@CUT";
L["Player,Cut"] = "Spieler, Anteil";
L["date/time at which the session was locked"] = "Datum/Uhrzeit, zu der die Sitzung gesperrt wurde";
L["total gold given to the player"] = "Gesamtgold, das dem Spieler gegeben wurde";
L["gold mailed to the player"] = "Gold wird dem Spieler per Post zugesandt";
L["total gold received from the player"] = "Gesamtgold, das der Spieler erhalten hat";
L["date/time at which the first item was awarded"] = "Datum/Uhrzeit der Verleihung des ersten Gegenstandes";
L["gold traded to the player"] = "Gold wird an den Spieler gehandelt";
L["@ITEM,@WINNER,@GOLD,@WOWHEAD"] = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L["Item,Player,Gold,Wowheadlink"] = "Gegenstand, Spieler, Gold, Wowheadlink";
L["Date/time at which the first item was awarded"] = "Datum/Uhrzeit der Verleihung des ersten Gegenstandes";
L["The title of the GDKP session"] = "Der Titel der GDKP-Sitzung";
L["Include disenchanted items"] = "Schließe entzauberte Gegenstände mit ein";
L["Pot changed"] = "Pott gewechselt";
L["Gold Trades"] = "Goldhandel";
L["Are you sure? You won't be able to see, or bid on, upcoming items!"] = "Bist du sicher? Du kannst kommende Gegenstände nicht sehen oder darauf bieten!";
L["\n|c00BE3333!! WARNING !!|r\n\nYou're on a connected realm and are importing player names without\na realm suffix, '%s' for example. This can cause you to send\ncuts and cut mails to the wrong player.\n\nWhen on a connected realm always try to include the realm name of players!\n\nContinue importing?\n"] = [[
|c00BE3333!! ACHTUNG !!|r

Du befindest dich auf einem verbundenen Realm und importierst Spielernamen ohne
einen Bereichssuffix, zum Beispiel „%s“. Dies kann dazu führen, dass du
Anteile und Post mit Anteilen an den falschen Spieler sendest.

Wenn du dich auf einem verbundenen Realm befindest, versuch immer, den Realmnamen der Spieler anzugeben!

Mit dem Import fortfahren?
]];
L["This will override any changes you've made to the cut window, are you sure?"] = "Dadurch werden alle Änderungen überschrieben, die du am Anteilfenster vorgenommen hast. Bist du sicher?";
L["\nYou can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!):\n\n|c00BE3333Player,Gold|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n"] = [[
Du kannst Spieleranteile aus deinen eigenen Berechnungen wie einem Google Sheet importieren. Softres GDKP usw.

Das Format ist wie folgt (|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333Player,Gold|c00967FD2
Spieler1.4000
Spieler2,4125
Spieler3.3998


]];
L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"] = [[
Importiere GDKP-Mindestpreise und -inkremente.

Das Format ist wie folgt: ItemID + Minimum oder Inkrement sind erforderlich. (|c00BE3333ERFORDERT EINEN HEADER!!):

|c00BE3333ItemID,Minimum,Inkrement|c00967FD2
18608.4000.500
]];
L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"] = "Vorhandene Preiseinstellungen löschen? Klick auf „Ja“, um alle Preisdaten zu löschen, und auf „Nein“, um vorhandene einfach mit den von dir hier angegebenen Daten zu überschreiben";
L["Import GDKP Session"] = "GDKP-Sitzung importieren";
L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"] = "Hier kannst du eine GDKP-Sitzung importieren (und fortsetzen). Um eine GDKP-Sitzung von jemandem zu erhalten, muss er sie in |c00FFF569/gdkp exportieren und dort das Format „Teilen (kann von anderen Spielern importiert werden)“ auswählen";
L["You're about to import a GDKP session created by %s, are you sure?"] = "Du bist dabei, eine von %s erstellte GDKP-Sitzung zu importieren. Bist du sicher?";
L["This GDKP session created by %s appears to exist already, do you wish to override it?"] = "Diese von %s erstellte GDKP-Sitzung scheint bereits zu existieren. Möchtest du sie überschreiben?";
L["Invalid data provided for GDKP extension!"] = "Ungültige Daten für die GDKP-Erweiterung angegeben!";
L["Invalid data provided for GDKP reschedule!"] = "Ungültige Daten für GDKP-Umplanung angegeben!";
L["Invalid data provided for GDKP shortening!"] = "Ungültige Daten zur GDKP-Verkürzung angegeben!";
L["Invalid data provided for GDKP auction start!"] = "Ungültige Daten für GDKP-Auktionsstart angegeben!";
L["Invalid number provided for 'paid'"] = "Ungültige Nummer für „bezahlt“ angegeben";
L["Invalid time provided in Auction:reschedule"] = "In „Auktion: Umplanung“ wurde eine ungültige Zeit angegeben";
L["\n\n|c00967FD2GDKP Data (sold %sx)\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n\n"] = [[

|c00967FD2GDKP Daten (verkauft %sx)
Zuletzt verkauft für: %s
Durchschnittspreis: %s
Mindestgebot: %s
Anteile

]];
L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"] = "Saldo: |c0092FF000 ? Du bist quitt! | |c00BE333330 ? Du schuldest %s 30g | |c00F7922E50 ? %s schuldet dir 50g";
L["Gold mailed to you by %s"] = "Gold wurde dir von %s zugesandt";
L["Gold paid to %s"] = "Gold wurde an %s gezahlt";
L["Gold received from %s"] = "Gold von %s erhalten";
L["Gold %s by"] = "Gold %s von"; -- %s = removed or added
L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"] = "Gesamtpott: %sg | Managementanteil: %sg (%s%%) | Zu verteilen: %sg";
L["|c00967FD2%s | By %s%s | On |c00967FD2%s"] = "|c00967FD2%s | Von %s%s | Am |c00967FD2%s";
L["The GDKP Session is not available or locked"] = "Die GDKP-Sitzung ist nicht verfügbar oder gesperrt";
L["Mail All"] = "Sende Post an alle";
L["No bids on Legendary+ item detected, continue manually!"] = "Keine Gebote für Legendary+-Artikel gefunden, manuell fortfahren!";
L["Missing content in Auction:start"] = "Fehlender Inhalt in Auktion:Start";
L["\n\nWith multi auctions (or batch auctions) you can auction off as many items as you want at once!\nThis speeds up your raid nights immensely and makes for a seamless experience for your raiders\n\nAll tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'\nGive it a shot!\n\n|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!\n\n"] = [[

Mit Mehrfachauktionen (oder Batch-Auktionen) kannst du so viele Gegenstände auf einmal versteigern, wie du möchtest!
Dies beschleunigt deine Raidabende enorm und sorgt für ein nahtloses Erlebnis für deine Raider

Alle handelbaren Gegenstände, die sich noch in deinem Inventar befinden, können automatisch mit „Aus Inventar füllen“ versteigert werden.
Versuch es einmal!

|c00808080Es gibt nur einen Nachteil: Damit Raider an einer Mehrfachauktion teilnehmen können, brauchen sie Gargul!

]];
L["You need to have an active (unlocked) GDKP session!"] = "Du benötigst eine aktive (entsperrte) GDKP-Sitzung!";
L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"] = "Wenn dieses Fenster geöffnet ist, füge %s Gegenstände zur Liste hinzu oder klick unten auf „Aus Inventar füllen“."; -- %s holds the add item hotkey (default ALT_CLICK)
L["Anti snipe in seconds"] = "Anti-Snipe in Sekunden";
L["The anti snipe value needs to be 0 (empty) or >=5"] = "Der Anti-Snipe-Wert muss 0 (leer) oder >=5 sein";
L["Go back to the item selector"] = "Geh zurück zur Gegenstandsauswahl";
L["Remove all items from the list"] = "Entferne alle Elemente aus der Liste";
L["Fill from inventory"] = "Aus Inventar füllen";
L["Add tradeable items from your inventory to the list"] = "Füge handelbare Gegenstände aus deinem Inventar zur Liste hinzu";
L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"] = [[
Hier legst du fest, welche Artikel du in deine Multiauktionssitzung aufnehmen möchtest

Benutze die Schaltfläche |c00A79EFFAus Inventar füllen unten, um Gegenstände, die noch gehandelt werden können, zur Liste hinzuzufügen
Wenn du dieses Fenster löschst und erneut öffnest, werden deine letzten Fülleinstellungen zum automatischen Hinzufügen von Gegenständen verwendet

|c00A79EFF%s Gegenstände um sie manuell zur Liste hinzuzufügen
]];
L["Next step: check raider's add-on version for compatibility"] = "Nächster Schritt: Überprüfe die Add-on-Version der Raider auf Kompatibilität";
L["Not everyone is using Gargul, are you sure you want to start the auction?"] = "Nicht jeder nutzt Gargul. Bist du sicher, dass du die Auktion starten möchtest?";
L["Select at least one item for your auction"] = "Wähle mindestens einen Gegenstand für deine Auktion aus";
L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"] = "Dein Gargul ist veraltet. Wir empfehlen dir das Addon vor Beginn einer Sitzung zu aktualisieren, um Probleme zu vermeiden!";
L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"] = "Nicht jeder ist auf dem neuesten Stand. Wenn bei dir Probleme auftreten, forde deine Raider auf, ein Update durchzuführen!";
L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"] = "Es gibt eine aktive Mehrfachauktion. Die hier hinzugefügten Gegenstände werden der bestehenden Sitzung hinzugefügt. Achte auf doppelte Artikel!";
L["Search name or iLVL"] = "Suche Name oder iLVL";
L["Supports item names and iLVL e.g. '252', '<252' etc"] = "Unterstützt Gegenstandsnamen und iLVL, z. B. '252', '<252' usw";
L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"] = "Aktive GDKP-Sitzung: |c00967FD2%s | Von %s%s | Am |c00967FD2%s";
L["Auction time in seconds"] = "Auktionszeit in Sekunden";
L["The auction time in seconds needs to be >= 10"] = "Die Auktionszeit in Sekunden muss >= 10 sein";
L["You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items"] = "Du bist während deiner GDKP-Gebotssitzung gegangen. Um sie fortzusetzen, musst du für alle nicht verkauften Gegenstände eine neue Gebotszeit (in Sekunden) angeben";
L["With this window open, %s items to add them to the list"] = "Wenn dieses Fenster geöffnet ist, füge %s Gegenstände der Liste hinzu";
L["Click the cogwheel icon to manage an auction"] = "Klick auf das Zahnradsymbol, um eine Auktion zu verwalten";
L["You're already the top bidder on %s"] = "Du bist bereits der Höchstbietende für %s";
L["Bid |c00%s%sg\nBy %s"] = [[
Gebot |c00%s%sg
Von %s]];
L["|c00%sCLOSED\nNo bids"] = [[
|c00%sGESCHLOSSEN
Keine Gebote]];
L["Minimum: |c00%s%sg\nIncrement: |c00%s%sg"] = [[
Minimum: |c00%s%sg
Inkrement: |c00%s%sg]];
L["Items: %s  -  Total sold: %sg  -  Pledged by me: %sg"] = "Gegenstände: %s – Insgesamt verkauft: %sg – Von mir zugesichert: %sg";
L["Items with bids: %s/%s\nTotal sold: %s\nBought by me: %s\nTotal bid (does not include sold): %s\nBid by me (does not include sold): %s\n"] = [[
Gegenstände mit Geboten: %s/%s
Insgesamt verkauft: %s
Von mir gekauft: %s
Gesamtgebot (ohne Verkauf): %s
Von mir geboten (ohne Verkauf): %s
]];
L["|c00%sSOLD to%s\nfor |c00%s%s"] = [[
|c00%sVERKAUFT an
%s für |c00%s%sg]];
L["Bid |c00%s%s\nBy |c0092FF00YOU!"] = [[
Gebot |c00%s%sg
Von |c0092FF00DIR!]];
L["Could not stop auto bidding on %s, try again or /reload!"] = "Das automatische Bieten für %s konnte nicht gestoppt werden. Versuche es erneut oder /reload!";
L["Auto bid up to a maximum of %sg"] = "Automatisches Gebot bis maximal %sg";
L["Auto bid up to the bid you fill in on the left"] = "Automatisches Gebot bis zu dem Gebot, das du links eingibst";
L["Stop your auto bid (%sg)"] = "Stoppe dein automatisches Gebot (%sg)";
L["Bid on %s could not be confirmed"] = "Das Gebot für %s konnte nicht bestätigt werden";
L["Invalid bid or bid is too low! The minimum is %sg"] = "Ungültiges oder zu niedriges Gebot! Das Minimum ist %sg";
L["You need to wait two seconds between bids on the same item"] = "Zwischen Geboten für denselben Gegenstand musst du zwei Sekunden warten";
L["Clear bids"] = "Leere Gebote";
L["Remove all bids from the auction"] = "Entferne alle Gebote aus der Auktion";
L["Close all"] = "Alle abschließen";
L["Close ALL auctions?"] = "ALLE Auktionen abschließen?";
L["Close ALL auctions\n\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Schließen Sie ALLE Auktionen ab

Auktionen mit aktiven Geboten werden verkauft und können keine neuen Gebote erhalten!
]];
L["Close Auction"] = "Auktion abschließen";
L["Close the auction. Players can no longer bid but the highest bid remains active"] = "Schließe die Auktion ab. Spieler können nicht mehr bieten, aber das Höchstgebot bleibt aktiv";
L["Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!"] = "Entferne den Gegenstand einschließlich seiner Gebotsdetails aus der Auktion. DAS KANN NICHT RÜCKGÄNGIG GEMACHT WERDEN!";
L["Disenchant all finished but unsold items?"] = "Alle fertigen, aber nicht verkauften Gegenstände entzaubern?";
L["Disenchant unsold items\n\nThis will mark all unsold items as disenchanted and they will not show up in a new multi-auction session"] = [[
Entzaubere nicht verkaufte Gegenstände

Dadurch werden alle nicht verkauften Gegenstände als entzaubert markiert und in einer neuen Mehrfachauktionssitzung nicht angezeigt
]];
L["Favorite this item"] = "Favorisiere diesen Gegenstand";
L["Give a final call timer of how many seconds?"] = "Gib einen letzten Aufruf- Timer von wie vielen Sekunden an?";
L["The minimum amount of seconds is 5"] = "Die Mindestanzahl an Sekunden beträgt 5";
L["Start a final call for this auction by giving a (usually shorter) bid timer"] = "Starte einen letzten Aufruf für diese Auktion, indem du einen (normalerweise kürzeren) Gebotstimer angibst";
L["Close ALL auctions and wrap up this multi-auction session?"] = "ALLE Auktionen abschließen und diese Mehrfachauktionssitzung abschließen?";
L["Finish Multi-Auction session\n\nThis will close all auctions and announce the total pot in chat\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Beende die Mehrfachauktionssitzung

Dadurch werden alle Auktionen abgeschlossen und der gesamte Pott im Chat bekannt gegeben
Auktionen mit aktiven Geboten werden verkauft und können keine neuen Gebote erhalten!
]];
L["Hide inactive"] = "Inaktive ausblenden";
L["Hide unusable"] = "Unbrauchbare ausblenden";
L["Show/Hide finished auctions"] = "Abgeschlossene Auktionen ein-/ausblenden";
L["Manage Auction"] = "Auktion verwalten";
L["Bid the minimum required amount"] = "Biete den erforderlichen Mindestbetrag";
L["Bidding window closed, use |c00A79EFF/gl bid to reopen it!"] = "Gebotsfenster geschlossen, mit |c00A79EFF/gl-Gebot wieder öffnen!";
L["Announce sales in chat"] = "Kündige verkaufte Gegenstände im Chat an";
L["Play sound when outbid"] = "Ton abgespielen wenn überboten";
L["More sound options..."] = "Weitere Tonoptionen...";
L["Show all"] = "Zeige alles";
L["Show favorites"] = "Favoriten anzeigen";
L["Show inactive"] = "Inaktive anzeigen";
L["Show unusable"] = "Unbrauchbare anzeigen";
L["This item was sold. Use ledger (|c00%s/gdkp) to make changes!"] = "Dieser Artikel wurde verkauft. Verwende das Register (|c00%s/gdkp), um Änderungen vorzunehmen!";
L["Terminate"] = "Abbrechen";
L["Remove all bidsl bids and close all auctions?"] = "Alle Gebote/Gebote entfernen und alle Auktionen schließen?";
L["Terminate Multi-Auction session\n\nThis will delete all bids on items that haven't sold yet and close all auctions!"] = [[
Brich die Mehrfachauktionssitzung ab

Dadurch werden alle Gebote auf Gegenstände, die noch nicht verkauft wurden, gelöscht und alle Auktionen geschlossen!
]];
L["Hover over any of the buttons below for more information"] = "Bewege den Mauszeiger über die Knöpfe für weitere Informationen";
L["Show/Hide items you can't use"] = "Gegenstände anzeigen/ausblenden, die du nicht verwenden kannst";
L["Invalid data provided for GDKP auction start!"] = "Ungültige Daten für GDKP-Auktionsstart angegeben!";
L["%s bought %s for %s"] = "%s hat %s für %sg gekauft";
L["The loot master (%s) is outdated, this can cause bids to fail!"] = "Der Plündermeister (%s) ist veraltet, dies kann dazu führen, dass Gebote fehlschlagen!";
L["You were outbid!"] = "Du wurdest überboten!";
L["Mutators"] = "Mutatoren";
L["Add Mutator"] = "Mutator hinzufügen";
L["Auto apply to"] = "Automatisch anwenden auf";
L["Create a new GDKP mutator"] = "Erstelle einen neuen GDKP-Mutator";
L["Delete. Hold shift to bypass confirmation"] = "Löschen. Halte die Umschalttaste gedrückt, um die Bestätigung zu umgehen";
L["Edit mutator"] = "Mutator bearbeiten";
L["Flat gold rate [example: 250]"] = "Pauschaler Goldpreis [Beispiel: 250]";
L["The flat rate needs to be a number"] = "Bei der Pauschale muss es sich um eine Zahl handeln";
L["\nExample:\n|c00967FD2SELF,RL,HEALER"] = [[
Beispiel:
|c00967FD2SELF,RL,HEALER]];
L["You can automatically apply this mutator to raiders using keywords:"] = "Du kannst diesen Mutator mithilfe von Schlüsselwörtern automatisch auf Raider anwenden:";
L["Name [example: Tanks]"] = "Name [Beispiel: Heiler]";
L["Mutator names can not contains dots (.)"] = "Mutatornamen dürfen keine Punkte (.) enthalten.";
L["Percentage [example: 10]"] = "Prozentsatz [Beispiel: 10]";
L["The percentage needs to be a number"] = "Der Prozentsatz muss eine Zahl sein";
L["Store for future sessions"] = "Für zukünftige Sitzungen speichern";
L["Unknown mutator: %s"] = "Unbekannter Mutator: %s";
L["User '%s' is not allowed to start auctions"] = "Benutzer „%s“ ist nicht berechtigt, Auktionen zu starten";
L["User '%s' is not allowed to stop auctions"] = "Benutzer „%s“ ist nicht berechtigt, Auktionen zu stoppen";
L["User '%s' is not allowed to stop auction: auction invalid"] = "Benutzer „%s“ darf die Auktion nicht stoppen: Auktion ungültig";
L["There's not enough gold to distribute, expect some weird cut calculations!"] = "Es gibt nicht genug Gold zum Verteilen, rechne mit seltsamen Anteilsberechnungen!";
L["No bids!"] = "Keine Gebote!";
L["You were outbid!"] = "Du wurdest überboten!";
L["(active)"] = "(aktiv)";
L["\nYou need lead or master loot to adjust gold.\nYou can't adjust gold on locked/deleted sessions"] = [[
Zum Anpassen von Gold musst du Anführer oder Plündermeister sein.
Du kannst Gold für gesperrte/gelöschte Sitzungen nicht anpassen]];
L["Add/Remove gold"] = "Gold hinzufügen/entfernen";
L["\n%s paid |c00%s%s for\n%s"] = [[
%s hat |c00%s%s bezahlt für
%s]]; -- Player paid 5000g for [Benediction]
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Gelöscht von %s
Gründe dafür]];
L["(deleted)"] = "(gelöscht)";
L["\nYou need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions"] = [[
Zum Löschen von Einträgen musst du Anführer oder Plündermeister sein.
Du kannst keine Einträge in gesperrten/gelöschten Sitzungen löschen]];
L["Provide a reason for deleting this entry"] = "Gib einen Grund für das Löschen dieses Eintrags an";
L["Delete. Hold shift to bypass note"] = "Löschen. Halte die Umschalttaste gedrückt, um die Notiz zu umgehen";
L["Sessions with auctions attached to them will be deleted after 48 hours"] = "Sitzungen mit angehängten Auktionen werden nach 48 Stunden gelöscht";
L["\nYou need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions"] = [[
Um Einträge zu bearbeiten musst du Anführer oder Plündermeister sein.
Du kannst gelöschte Einträge oder Einträge in gesperrten/gelöschten Sitzungen nicht bearbeiten]];
L["Export a session so others can view session details or even replace you as a loot master"] = "Exportiere eine Sitzung, damit andere Spieler Sitzungsdetails sehen oder dich sogar als Plündermeister ersetzen können";
L["Import a session from another player or account"] = "Importiere eine Sitzung von einem anderen Spieler oder Konto";
L["\nShow a full overview of the ledger,\nideal for screenshotting purposes!"] = [[
Zeige eine vollständige Übersicht über das Register an.
Ideal für Screenshotzwecke!]];
L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"] = "Wenn du eine Sitzung sperrst, kannst du keine Gegenstände versteigern oder auf andere Weise etwas ändern, bis du die Sitzung entsperrst. Bist du sicher?";
L["Lock or unlock the session"] = "Sperre oder entsperre die Sitzung";
L["Lock the session for payout"] = "Sperre die Sitzung für die Auszahlung";
L["Multi-auction: auction multiple items at once!"] = "Mehrfachauktion: Versteigere mehrere Gegenstände gleichzeitig!";
L["added to"] = "hinzugefügt zu";
L["\n|c00%s%s %s pot by %s\nNote: %s"] = [[
|c00%s%s %s Pott von %s
Anmerkungen]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L["removed from"] = "entfernt von";
L["\nPot: %s\nManagement cut (%s%%): %sg\nPer player cut (1/%s): %sg\n"] = [[
Pott: %s
Managementanteil (%s%%): %sg
Pro Spieleranteil (1/%s): %sg
]];
L["\nYou need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions"] = [[
Um Einträge wiederherzustellen musst du Anführer oder Plündermeister sein.
Einträge gesperrter/gelöschter Sitzungen können nicht wiederhergestellt werden]];
L["By %s%s | On |c00%s%s%s"] = "Von %s%s | Am |c00%s%s%s"; -- By name<guild> on date
L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"] = "Das Freischalten und Ändern des Potts oder der Anteile kann sehr chaotisch werden, insbesondere wenn du bereits Auszahlungen vorgenommen hast. Bist du sicher?";
L["Unlock the session"] = "Entsperre die Sitzung";
L["No active GDKP session detected or session is not locked for payout!"] = "Keine aktive GDKP-Sitzung erkannt oder Sitzung ist nicht für die Auszahlung gesperrt!";
L["Increment or minimum can't be lower than .0001!"] = "Inkrement bzw. Minimum darf nicht kleiner als .0001 sein!";
L["Invalid 'Increment' provided for item ID '%s'"] = "Ungültiges „Inkrement“ für Gegenstand-ID „%s“ angegeben";
L["Invalid 'Minimum' provided for item ID '%s'"] = "Ungültiges „Minimum“ für Gegenstand-ID „%s“ angegeben";
L["Either minimum or increment is required for item ID: %s"] = "Für die Gegenstand-ID %s ist entweder ein Minimum oder ein Inkrement erforderlich";
L["Missing header, note: it's case-sensitive!"] = "Fehlender Header, Hinweis: Groß-/Kleinschreibung wird beachtet!";
L["Successfully imported data for %s items"] = "Daten für %s Gegenstand erfolgreich importiert";
L["Unknown item ID: %s"] = "Unbekannte Gegenstand-ID: %s";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.\nItems in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.\n\nWant Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!\n\n|c00FFF569Did you know?\nYou can move items around with drag and drop\nItems will be remembered, even when you |c00A79EFF/reload\nQueued items are automatically shown to raiders who have Gargul so they can prebid\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s Gegenstände in Taschen, Beutefenstern oder sogar auf Links in deinem Chat, um sie dieser Auktionswarteschlange hinzuzufügen.
Gegenstände in der Warteschlange werden automatisch versteigert, sobald deine aktuelle Auktion abgeschlossen ist. Klick auf die Schaltfläche „%s“, um dies zu verhindern.

Möchtest du, dass Gargul Auktionen automatisch für dich verleiht oder entzaubert? Öffne das Einstellungsrad auf der linken Seite!

|c00FFF569Wusstest du schon?
Du kannst Gegenstände per Drag & Drop verschieben
Gegenstände werden gespeichert, auch wenn du |c00A79EFF/neu lädst
In der Warteschlange befindliche Gegenstände werden Raidern, die über Gargul verfügen, automatisch angezeigt, damit sie vorab bieten können
Gargul kann auch das automatische Plündern für dich übernehmen. Probier es mit |c00A79EFF/gl pm aus
]];
L["Hide unusable items"] = "Blende unbrauchbare Gegenstände aus";
L["GDKP Session"] = "GDKP-Sitzung";
L["Editing %s"] = "%s wird bearbeitet";
L["Show upcoming items"] = "Kommende Gegenstände anzeigen";
L["Stop the auction first!"] = "Stoppe zuerst die Auktion!";
L["%s owes you %s"] = "%s schuldet dir %s";
L["\n|c00967FD2GDKP Session\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s\n"] = [[
|c00967FD2GDKP Sitzung
Von Spieler ausgegeben: %s
Gegeben: %s
Empfangen: %s
Spieleranteil: %s

%s
]];
L["Exclude from GDKP"] = "Aus GDKP ausschließen";
L["Gold traded will not be added to amount given or received"] = "Das gehandelte Gold wird nicht zum gegebenen oder erhaltenen Betrag addiert";
L["Gold |c00967FD2given to %s"] = "Gold |c00967FD2an %s übergeben";
L["Unable to add %s to the trade window. Try adding it manually!"] = "%s konnte nicht zum Handelsfenster hinzugefügt werden. Versuch es manuell hinzuzufügen!";
L["You don't have enough money to pay %s"] = "Du hast nicht genug Geld, um %s zu bezahlen";
L["To give: %s"] = "Zu geben: %s";
L["To receive: %s"] = "Zu empfangen: %s";
L["Gold |c00967FD2received from %s"] = "Gold |c00967FD2erhalten von %s";
L["Check out Multi Auctions!"] = "Schau dir sich Mehrfachauktionen an!";
L["Follow the steps below to quickly get started with Gargul GDKP!"] = "Befolge die folgenden Schritte, um schnell mit Gargul GDKP zu beginnen!";
L["Activate this session by clicking the |c00FFF569Enable button below!"] = "Aktiviere diese Sitzung, indem du unten auf die Schaltfläche |c00FFF569Enable klickst!";
L["|c00FFF569%s an item to auction or queue a single item"] = "|c00FFF569%s einen Gegenstand, um einen einzelnen Gegenstand zu versteigern oder in die Warteschlange zu stellen"; -- %s holds the auction item hotkey (default ALT_CLICK)
L["\nHelpful commands:\n- |c00FFF569/gdkp to open this window\n- |c00FFF569/gl ma to open the multi-auction window\n- |c00FFF569/gl au to open the single item auctioneer / queue\n- |c00FFF569/gl pm to set up auto-looting\n\n"] = [[
Hilfreiche Befehle:
- |c00FFF569/gdkp, um dieses Fenster zu öffnen
- |c00FFF569/gl ma, um das Fenster für mehrere Auktionen zu öffnen
- |c00FFF569/gl au, um den Auktionator / die Warteschlange für einzelne Gegenstände zu öffnen
- |c00FFF569/gl pm, um automatisches Plündern einzurichten

]];
L["If all went well then you will see your freshly auctioned item(s) here!"] = "Wenn alles gut gelaufen ist, siehst du hier deine frisch versteigerten Gegenstände!";
L["Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!"] = "Möchtest du mehrere Artikel gleichzeitig versteigern? Führe |c00FFF569/gl ma (oder |c00FFF569/gl Multiauction) aus oder klick auf das Mehrfachauktionssymbol oben rechts in diesem Fenster!";
L["Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created"] = "Klick unten auf die Schaltfläche |c00FFF569Neu, um deine erste GDKP-Sitzung zu erstellen. Nach der Erstellung wird es links angezeigt";
L["You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!"] = "Du bist bereit Gegenstände zu verkaufen! |c00BE3333Lies alle Schritte unten sorgfältig durch und teste sie alle selbst (Du musst nicht an einem Raid teilnehmen), bevor du deinen ersten GDKP-Raid startest!";
L["Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!"] = "Möchtest du einen Gegenstand verkaufen, ohne dass jemand bietet? |c00FFF569%s auf einen Gegenstand, wähle einen Gewinner aus und lege einen Preis fest!";
L["Getting started"] = "Erste Schritte";
L["Unknown itemID in Auction:create: %s"] = "Unbekannte Gegenstand-ID in Auktion:create: %s";
L["Unknown sessionIdentifier in Auction:create: %s"] = "Unbekannter SessionIdentifier in Auction:create: %s";
L["You owe %s %s"] = "Du schuldest %s %s";
L["Given"] = "Gegeben";
L["g"] = "G";
L["Group"] = "Gruppe";
L["Group Manager"] = "Gruppenleiter";
L["Download on CurseForge"] = "Auf CurseForge herunterladen";
L["https://addons.wago.io/addons/gargul/versions?stability=stable"] = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L["Halt"] = "Halten";
L["Header"] = "Header";
L["|c00%sGargul v%s by Zhorax@Firemaw. Type |c00%s/gl or |c00%s/gargul to get started!"] = "|c00%sGargul v%s von Zhorax@Firemaw. Gib |c00%s/gl oder |c00%s/gargul ein, um loszulegen!";
L["Hide"] = "Ausblenden";
L["%H:%M"] = "%HM";
L["Visit the URL below to learn more about personalizing Gargul GDKPs"] = "Besuche die URL unten, um mehr über die Personalisierung von Gargul GDKPs zu erfahren";
L["Your logo here? Click for more info!"] = "Dein Logo hier? Klick für weitere Informationen!";
L["Import"] = "Importieren";
L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"] = "Importiert am |c00A79EFF%s um |c00A79EFF%s, Aktualisiert am |c00A79EFF%s um |c00A79EFF%s";
L["What kind of data would you like to import?"] = "Welche Art von Daten möchtest du importieren?";
L["Import of boosted roll data successful"] = "Import der Boosted-Rolls-Daten erfolgreich";
L["Inc"] = "Inc";
L["Include previously awarded items"] = "Beziehe zuvor verliehene Gegenstände mit ein";
L["Include BOEs"] = "BOE einbeziehen";
L["Include materials (like Abyss Crystals)"] = "Materialien einschließen (wie Kristalle der Leere)";
L["Increment"] = "Inkrement";
L["Info"] = "Info";
L["Invalid data supplied"] = "Ungültige Daten angegeben";
L["Item"] = "Gegenstand";
L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "JSON-Dekodierung der Daten ist nicht möglich. Stell sicher, dass du es unverändert kopiert/eingefügt hast, ohne zusätzliche Zeichen oder Leerzeichen hinzuzufügen!";
L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"] = [[
Gargul-Hotkeys für Gegenstände

Rollen: |c00A79EFF%s
Verleihen: |c00A79EFF%s
Entzaubern: |c00A79EFF%s


-- Klick mit der rechten Maustaste, um dieses Fenster zu deaktivieren --
]];
L["Ledger"] = "Register";
L["<"] = "<";
L["You need to be the master looter or have an assist / lead role!"] = "Du musst der Plündermeister sein oder eine Assistenz-/Anführerrolle übernehmen!";
L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"] = "Hinweis: Du kannst deine Region jederzeit in den Einstellungen oder über |c00%s/gl Region ändern";
L["deDE"] = "deDE"; -- German (Germany)
L["enUS"] = "enUS"; -- English (United States)
L["esES"] = "esES"; -- Spanish (Spain)
L["esMX"] = "esMX"; -- Spanish (Mexico)
L["frFR"] = "frFR"; -- French (France)
L["itIT"] = "itIT"; -- Italian (Italy)
L["koKR"] = "koKR"; -- Korean (Korea)
L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"] = [[
Gargul postet Chatnachrichten auf Englisch (Standard)
Du kannst im Dropdown-Menü unten eine andere Sprache auswählen

Deine aktuelle Chat-Sprache ist „%s“. Das Aktivieren einer anderen Sprache führt zu einem /reload!
]];
L["Choose a chat language for Gargul"] = "Wähle eine Chat-Sprache für Gargul";
L["ptBR"] = "ptBR"; -- Portuguese (Brazil)
L["ruRU"] = "ruRU"; -- Russian (Russia)
L["zhCN"] = "zhCN"; -- Chinese (Simplified, PRC)
L["zhTW"] = "zhTW"; -- Chinese (Traditional, Taiwan)
L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"] = "Du hast ein oder mehrere Add-ons installiert, die möglicherweise zu Fehlfunktionen von Gargul führen können: %s";
L["Clear SoftRes"] = "SoftRes löschen";
L["Clear TMB"] = "TMB löschen";
L["/roll for MS or /roll 99 for OS"] = "/roll für MS oder /roll 99 für OS";
L["Import SoftRes"] = "SoftRes importieren";
L["Import TMB"] = "TMB importieren";
L["You were given the role of Master Looter"] = "Dir wurde die Rolle des Plündermeisterd übertragen";
L["Open this window automatically"] = "Dieses Fenster automatisch öffnen";
L["Loot priorities cleared successfully"] = "Beuteprioritäten erfolgreich gelöscht";
L["Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc"] = "Gib eine Prio-CSV im folgenden Format an (1 Zeile pro Element): id or name > prio1, equalprio > prio2 > usw";
L["Loot priorities imported successfully"] = "Beuteprioritäten erfolgreich importiert";
L["Invalid data provided"] = "Ungültige Daten angegeben";
L["Invalid data provided in line: '%s': missing item id or priority"] = "Ungültige Daten in Zeile: „%s“: Gegenstand-ID oder Priorität fehlt";
L["Attempting to process incoming loot priorities from %s"] = "Es wird versucht, eingehende Beuteprioritäten von %s zu verarbeiten";
L["Loot Prio"] = "Beuteprioritäten";
L["Mail"] = "Post";
L["Mailed"] = "Per Post verschickt";
L["Mail cut to players"] = "Post mit Anteilen an Spieler";
L["MS"] = "MS";
L["Maximize"] = "Maximieren";
L["Min"] = "Minimum";
L["Awarded loot history"] = "Verliehener Beuteverlauf";
L["GDKP Cuts"] = "GDKP-Anteile";
L["Export data"] = "Daten exportieren";
L["Open Gargul"] = "Öffne Gargul";
L["Import data"] = "Daten importieren";
L["GDKP Ledger"] = "GDKP-Register";
L["Multiauction"] = "Mehrfachauktion";
L["Change settings in /gl minimap"] = "Ändere die Einstellungen in der /gl-Minikarte";
L["Minimize"] = "Minimieren";
L["Minimize on award"] = "Bei Verleihung minimieren";
L["Minimize on start"] = "Beim Start minimieren";
L["Minimum"] = "Minimum";
L["Minimum item level"] = "Mindestartikelstufe";
L["Minimum Quality"] = "Mindestqualität";
L["-10"] = "-10";
L["-"] = "-";
L["Move"] = "Bewegen";
L["Multi-Auction"] = "Mehrfachauktion";
L["Name"] = "Name";
L["New"] = "Neu";
L["Next"] = "Nächste";
L["No"] = "Nein";
L["None"] = "Kein";
L["Note"] = "Notiz";
L["Nothing"] = "Nichts";
L["When no one bids do:"] = "Wenn niemand bietet, tue Folgendes:";
L["You don't have officer privileges"] = "Du hast keine Offiziersprivilegien";
L["OS"] = "OS";
L["Ok"] = "OK";
L["Open"] = "Offen";
L["Open Auctioneer"] = "Auktionator öffnen";
L["Open Multi-Auction"] = "Öffne eine Mehrfachauktion";
L["DE"] = "DE";
L["GREED"] = "GREED";
L["IGNORE"] = "IGNORE";
L["NEED"] = "NEED";
L["PASS"] = "PASS";
L["RANDOM"] = "RANDOM";
L["RR"] = "RR";
L["SELF"] = "SELF";
L["Set %s as your disenchanter?"] = "%s als Entzauberer festlegen?";
L["Send %s to %s? Type /gl cd to remove this disenchanter!"] = "%s an %s senden? Gib /gl cd ein, um diesen Entzauberer zu entfernen!";
L["No disenchanter set, use /gl sd [mydisenchanter] to set one"] = "Kein Entzauberer festgelegt, verwende /gl sd [mydisenchanter], um einen festzulegen";
L["Who is your disenchanter?"] = "Wer ist dein Entzauberer?";
L["Paid"] = "Bezahlt";
L["Pass"] = "Passen";
L["%"] = "%";
L["Player"] = "Spieler";
L["Items won by %s:"] = "Von %s gewonnene Gegenstände:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L["Plus Ones"] = "PlusOne Punkte";
L["Add a +1"] = "Füge +1 hinzu";
L["Are you sure you want to broadcast your plus one data to everyone in your party/raid?"] = "Bist du sicher, dass du deine PlusOne-Daten an alle in deiner Gruppe/deinem Raid übertragen möchtest?";
L["Attempting to process incoming PlusOnes data from %s"] = "Es wird versucht, eingehende PlusOne-Daten von %s zu verarbeiten";
L["%s wants to clear all your PlusOne data. Clear all data?"] = "%s möchte alle deine PlusOne-Daten löschen. Alle Daten löschen?";
L["Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?"] = "Bist du sicher, dass du deine vorhandenen PlusOne-Daten löschen und neue, von %s gesendete Daten importieren möchtest?";
L["Are you sure you want to import new data broadcasted by %s?"] = "Bist du sicher, dass du neue, von %s gesendete Daten importieren möchtest?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Ungültige Daten angegeben. Stell sicher, dass der Inhalt dem erforderlichen Format entspricht und keine Kopfzeile enthalten ist";
L["\nHere you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240\n"] = [[
Hier kansst du PlusOne-Daten aus einer Tabelle im CSV- oder TSV-Format importieren oder aus einem Google Docs-Blatt einfügen.

Die Tabelle benötigt mindestens zwei Spalten: Den Spielernamen gefolgt von der Punktzahl. Zusätzliche Spalten werden ignoriert.

Hier ist eine Beispielzeile:

Foobar,240
]];
L["Automatically accept incoming broadcasts from %s"] = "Eingehende Broadcasts von %s automatisch akzeptieren";
L["Block all incoming +1 shared data"] = "Blockiere alle eingehenden +1 geteilten Daten";
L["\nAre you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Bist du sicher, dass du deine vorhandenen PlusOne-Daten mit Daten von %s aktualisieren möchten?

Dein letztes Update war auf |c00A79EFF%s, ihres auf |c00A79EFF%s.]];
L["!plusone|!po|!+1"] = "!plusone|!po|!+1";
L["+"] = "+";
L["Pot"] = "Pott";
L["Price"] = "Preis";
L["PL"] = "PL";
L["Common"] = "Gewöhnlich";
L["Epic"] = "Episch";
L["Heirloom"] = "Erbstück";
L["Legendary"] = "Legendär";
L["Poor"] = "Schlecht";
L["Rare"] = "Selten";
L["Uncommon"] = "Außergewöhnlich";
L["Queue"] = "Warteschlange";
L["Raiders"] = "Raiders";
L["Who's Missing"] = "Wer fehlt";
L["Show missing player names"] = "Fehlende Spielernamen anzeigen";
L["Disband raid"] = "Raid auflösen";
L["Disband your raid"] = "Löse deinen Raid auf";
L["%s is listed twice on the roster!"] = "%s ist zweimal im Kader aufgeführt!";
L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"] = "ein |c00FFF569Raid-Helper-Export (Verwende die Variante „Vertikal sortierte Gruppen“) oder eine |c00FFF569Gargul-Gruppenzusammensetzungs-CSV:";
L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"] = [[
Im großen Bearbeitungsfeld unten kannst du ein Kader erstellen und: alle einladen, überprüfen, wer fehlt, Gruppen erstellen und die Tanks zuweisen.

Du kannst einen Link zur |c00FFF569Wowhead-Raid-Zusammensetzung bereitstellen:]];
L["Gargul Group Wiki"] = "Wiki der Gargul-Gruppe";
L["Visit the Gargul group wiki for more info on the raid group format"] = "Weitere Informationen zum Raid-Gruppenformat finden Sie im Gargul-Gruppen-Wiki";
L["The following players are not part of the roster: %s"] = "Die folgenden Spieler sind nicht Teil des Kaders: %s";
L["Invalid group data provided, check your format!"] = "Ungültige Gruppendaten angegeben. Überprüfe dein Format!";
L["Invite"] = "Einladen";
L["Send invites to players on roster"] = "Sende Einladungen an Spieler im Kader";
L["Can't sort groups while %s is in combat!"] = "Gruppen können nicht sortiert werden, während %s im Kampf ist!"; -- %s holds a player name
L["You need to be in a raid!"] = "Du musst in einem Raid sein!";
L["No tanks defined"] = "Keine Tanks definiert";
L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"] = "Du kannst keinen Platz für %s finden. Versuchst du mehr als 5 Personen in eine Gruppe einzuteilen?";
L["Kick unwanted players"] = "Kicke unerwünschte Spieler";
L["Kick players that aren't on the roster"] = "Kicke Spieler, die nicht im Kader stehen";
L["Something went wrong while moving %s"] = "Beim Verschieben von %s ist ein Fehler aufgetreten";
L["Finished applying raid roster"] = "Die Anwendung des Raid-Kaders ist abgeschlossen";
L["Sorting groups"] = "Gruppen sortieren";
L["Apply Groups"] = "Gruppen anwenden";
L["Sort groups based on roster"] = "Sortiere Gruppen nach Kader";
L["Sorting is still in progress, wait a bit!"] = "Die Sortierung ist noch im Gange, warte noch ein wenig!";
L["All tanks are assigned"] = "Alle Tanks sind zugewiesen";
L["Assign Tanks"] = "Weise Tanks zu";
L["Wowhead Comp Tool"] = "Wowhead Comp-Tool";
L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"] = "Du kannst das Wowhead-Comp-Tool über die unten stehende URL besuchen. Nachdem du deine Komposition erstellt hast, kannst du sie hier oder in das große Bearbeitungsfeld des Gargul-Gruppenfensters einfügen";
L["Remove bid"] = "Gebot entfernen";
L["Reset Settings"] = "Einstellungen zurücksetzen";
L["Are you sure you want to reset all of Gargul's settings? This can't be undone!"] = "Bist du sicher, dass du alle Einstellungen von Gargul zurücksetzen möchtest? Es kann nicht rückgängig gemacht werden!";
L["Reset Gargul UI"] = "Gargul-Benutzeroberfläche zurücksetzen";
L["Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!"] = "Bist du sicher, dass du alle Fenstergrößen, -positionen und -skalen von Gargul zurücksetzen möchten? Es kann nicht rückgängig gemacht werden!";
L["Restore"] = "Wiederherstellen";
L["Resume"] = "Fortsetzen";
L[">"] = ">";
L["Roll"] = "Rollen";
L["Award %s to %s?"] = "%s an %s verleihen?";
L["Close on award"] = "Bei Verleihung schließen";
L["Close on start"] = "Beim Start schließen";
L["Hold shift to bypass the award confirmation"] = "Halte die Umschalttaste gedrückt, um die Verleihungsbestätigung zu umgehen";
L["Hold shift to show the award confirmation"] = "Halte die Umschalttaste gedrückt, um die Verleihungsbestätigung anzuzeigen";
L["\nWarning: another identical roll was found which can point to a tie\n\n"] = [[
Warnung: Es wurde ein weiterer identischer Wurf gefunden, der auf ein Unentschieden hinweisen kann

]];
L["Invalid data provided for roll start!"] = "Ungültige Daten für Würfelstart angegeben!";
L["(BR: %s)"] = "(BR: %s)";
L["(item given: yes)"] = "(Gegenstand gegeben: ja)";
L["(item given: no)"] = "(Gegenstand gegeben: nein)";
L["(OS)"] = "(OS)";
L["NOTE"] = "NOTIZ";
L["Can't stop roll off, no roll off in progress"] = "Das Würfeln kann nicht gestoppt werden, da kein Würfeln im Gange ist";
L["Pass"] = "Passen";
L["rolls: %s"] = "rollt: %s";
L["Open master looter window"] = "Öffne das Plündermeisterfenster";
L["Roll accepted!"] = "Wurf angenommen!";
L["A roll is currently in progress"] = "Derzeit wird gewürfelt";
L["Prio [%s]"] = "Priorität [%s]";
L["SR [%sx]"] = "SR [%sx]";
L["Wish [%s]"] = "Wunschliste [%s]";
L["You need to select a player first"] = "Du musst zuerst einen Spieler auswählen";
L["TIMER (s)"] = "TIMER (s)";
L["You can't use this item!"] = "Du kannst diesen Gegenstand nicht verwenden!";
L["The winner's name is not unique, select the player you'd like to award %s to"] = "Der Name des Gewinners ist nicht eindeutig. Wähle den Spieler aus, dem du %s verleihen möchtest";
L["s"] = "S";
L["Select / Disable all"] = "Alle auswählen/deaktivieren";
L["Session"] = "Sitzung";
L["Settings"] = "Einstellungen";
L["Announce incoming bids"] = "Gib eingehende Gebote bekannt";
L["Announce pot after awarding item"] = "Gib den Pott nach der Vergabe des Gegenstands bekannt";
L["Announce auction start"] = "Auktionsstart bekannt geben";
L["Announce countdown in raid warning"] = "Countdown in der Raid-Warnung ankündigen";
L["Announce incoming bids in raid warning"] = "Kündige eingehende Gebote in der Raid-Warnung an";
L["Reset Gargul UI"] = "Gargul-Benutzeroberfläche zurücksetzen";
L["Whisper bidder if bid is too low"] = "Flüster Bieter, wenn das Gebot zu niedrig ist";
L["s"] = "S";
L["Skip"] = "Überspringen";
L["Soft-Reserves"] = "Soft-Reserve";
L["SR"] = "SR";
L["Are you sure you want to broadcast your softres data to everyone in your party/raid?"] = "bist du sicher, dass du deine Softres-Daten an alle Mitglieder deiner Gruppe/deines Raids übertragen möchtest?";
L["Couldn't process SoftRes data received from %s"] = "Die von %s empfangenen SoftRes-Daten konnten nicht verarbeitet werden";
L["Are you sure you want to clear all existing soft-reserve data?"] = "Bist du sicher, dass du alle vorhandenen Soft-Reserv-Daten löschen möchtest?";
L["Everyone filled out their soft-reserves"] = "Jeder hat sein Soft-Reserve eingefüllt";
L["\nHard-reserve information is not available because the soft-reserves\nprovided were not generated using the 'Gargul Export' button on softres.it"] = [[
Informationen zu Hard-Reserves sind aufgrund der Soft-Reserves nicht verfügbar
Die bereitgestellten Dateien wurden nicht über die Schaltfläche „Gargul Export“ auf softres.it generiert]];
L["Imported on |c00A79EFF%s at |c00A79EFF%s"] = "Importiert am |c00A79EFF%s um |c00A79EFF%s";
L["Auto name fix: the SR of '%s' is now linked to '%s'"] = "Automatische Namenskorrektur: Die SR von „%s“ ist jetzt mit „%s“ verknüpft.";
L["In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below."] = "Um zu beginnen, musst du zunächst einen Raid auf softres.it erstellen. Klick anschließend auf „Addon Export“, wähle „Gargul“, kopiere die Daten und füge sie in das untenstehende Formular ein.";
L["Invalid soft-reserve data provided"] = "Es wurden ungültige Soft-Reserve-Daten bereitgestellt";
L["Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here"] = "Ungültige Daten angegeben. Klick auf die Schaltfläche „Gargul Export“ auf softres.it und füge den gesamten Inhalt hier ein";
L["The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?"] = "Die bereitgestellten PlusOne-Werte kollidieren mit den bereits vorhandenen. Möchtest du deine alten PlusOne-Werte ersetzen?";
L["The following players did not reserve anything:"] = "Die folgenden Spieler haben nichts reserviert:";
L["Soft-reserves imported successfully"] = "Soft-Reserves erfolgreich importiert";
L["Import successful!"] = "Import erfolgreich!";
L["SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!"] = "SoftRes Weakaura- und CSV-Daten sind veraltet. Verwende stattdessen den Gargul-Export!";
L["Failed to connect to LootReserve, contact support (include message below)"] = "Verbindung zu LootReserve konnte nicht hergestellt werden. Wende dich an den Support (füge die Nachricht unten ein).";
L["%s (%sx)"] = "%s (%sx)";
L["No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!"] = "Keine softres.it-URL verfügbar. Stell sicher, dass du den Export über die Schaltfläche „Gargul Export“ auf softres.it durchgeführt hast!";
L["Click here to see hard-reserve info"] = "Klick hier, um Informationen zur Festreserve anzuzeigen";
L["No items are hard-reserved"] = "Es sind keine Gegenstände hard-reserved";
L["No hard-reserve info available"] = "Keine Informationen zu hard-reserve verfügbar";
L["Post missing SRs"] = "Poste fehlende SRs";
L["Post SR URL"] = "SR-URL posten";
L["This player did not reserve anything!"] = "Dieser Spieler hat nichts reserviert!";
L["%s (%sx)"] = "%s (%sx)";
L["Attempting to process incoming SoftRes data from %s"] = "Es wird versucht, eingehende SoftRes-Daten von %s zu verarbeiten";
L["This item is hard-reserved"] = "Dieser Artikel ist hard-reserved";
L["For: %s"] = "Für: %s";
L["|c00CC2743 Note: %s"] = "|c00CC2743 Hinweis: %s";
L["Reserved by"] = "Reserviert von";
L["!sr|!softres|!softreserve"] = "!sr|!softres|!softreserve";
L["Something went wrong!"] = "Etwas ist schief gelaufen!";
L["Start"] = "Start";
L["Stop"] = "Stoppen";
L["\\t is replaced by a tab"] = "\\t wird ersetzt durch Tabulatortaste";
L["TMB"] = "TMB";
L["Time"] = "Zeit";
L["Title"] = "Titel";
L["TMB, DFT or PRIO3"] = "TMB, DFT oder PRIO3";
L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"] = "Bist du sicher, dass du deine TMB-Daten an alle Mitglieder deiner Gruppe/deines Raids übertragen möchtest? Hinweis: JEDER kann deine TMB-Daten sehen, unabhängig von seinen Berechtigungen auf der TMB-Website!";
L["Attempting to process incoming TMB data from %s"] = "Es wird versucht, eingehende TMB-Daten von %s zu verarbeiten";
L["Are you sure you want to clear all plus one data?"] = "Bist du sicher, dass du alle PlusOne-Daten löschen möchtest?";
L["Clear Raider Data"] = "Raider-Daten löschen";
L["Clear TMB data for all raiders?"] = "TMB-Daten für alle Raider löschen?";
L["Auto-sharing enabled: %s"] = "Automatisches Teilen aktiviert: %s";
L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Klick bei deinem classicpr.io-Lauf auf die Schaltfläche „Gargul Export“ und kopiere den Inhalt. Füge anschließend den Inhalt unverändert in das Feld unten ein und klick auf „Importieren“. Das ist es!";
L["Imported on ${date} at ${time}"] = "Importiert am ${date} um ${time}";
L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Exportiere deine DFT-Daten gemäß den Anweisungen auf dem Sheet. Füge anschließend den Inhalt unverändert in das Feld unten ein und klick auf „Importieren“. Das ist es!";
L["Invalid CSV provided, the format is: 6948,player1,player2"] = "Es wurde eine ungültige CSV-Datei bereitgestellt. Das Format lautet: 6948,Spieler1,Spieler2";
L["Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!"] = "Es wurden ungültige DFT-Daten bereitgestellt. Exportiere deine DFT-Daten gemäß den Anweisungen auf dem Sheet und füge den Inhalt unverändert hier ein!";
L["Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!"] = "Es wurden ungültige TMB-Daten bereitgestellt. Klick auf die Schaltfläche „Herunterladen“ im Gargul-Bereich und füge den Inhalt unverändert hier ein!";
L["Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!"] = "Es wurden ungültige TMB- oder DFT-Daten bereitgestellt. Stell sicher, dass du die Exportinhalte unverändert hier einfügst!";
L["Priority notes available: %s"] = "Prioritätsnotizen verfügbar: %s";
L["Number of items imported: %s"] = "Anzahl der importierten Gegenstände: %s";
L["The following players have no %s entries:"] = "Die folgenden Spieler haben keine %s Einträge:"; -- %s can be TMB/DFT/CPR
L["How to use Gargul with ${source}"] = "So verwendest du Gargul mit ${source}";
L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"] = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L["Paste your TMB export contents as-is in the box below and click 'Import'"] = "Füge den Inhalt deines TMB-Exports unverändert in das Feld unten ein und klick auf „Importieren“.";
L["There's no one in your group to broadcast to"] = "Es gibt niemanden in deiner Gruppe, an den du senden können";
L["TMB data synced"] = "TMB-Daten synchronisiert";
L["|c00FFFFFF    Note: |c00FFF569%s"] = "|c00FFFFFF Hinweis: |c00FFF569%s";
L["(OS)"] = "(OS)";
L["%s Prio List"] = "%s Prio-Liste"; -- %s can be TMB/DFT/CPR
L["|c00FFFFFF    Tier: %s"] = "|c00FFFFFF Tier: %s";
L["TMB Wish List"] = "TMB-Wunschliste";
L["Show/Hide Dates"] = "Daten ein-/ausblenden";
L["Show/Hide Queue"] = "Warteschlange ein-/ausblenden";
L["%s to award loot!"] = "%s, um Beute zu verleihen!";
L["%s to roll out loot!"] = "%s um um Beute zu würfeln!";
L["Hide all awarded items"] = "Alle verliehenen Gegenstände ausblenden";
L["Hide disenchanted items"] = "Blende entzauberte Gegenstände aus";
L["Hide items awarded to self"] = "Selbst verliehene Gegenstände ausblenden";
L["Announce Trade"] = "Handel ankündigen";
L["Announce trade details to group or in /say when not in a group"] = "Gib Handelsdetails der Gruppe oder in /say bekannt, wenn du nicht in einer Gruppe bist";
L["Tutorial"] = "Tutorial";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.\nWant to directly sell an item without bidding? Use |c00A79EFF%s\n\nYou can open the %s window directly by typing |c00A79EFF/gl auction\n\nGargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the \"Exclude from GDKP\" checkbox when trading!\n\n|c00FFF569Did you know?\nAwarded items will automatically be added to the trade window\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s Gegenstände in Taschen, Beutefenstern oder sogar auf Links in deinem Chat, um sie zur Auktionswarteschlange hinzuzufügen.
Möchtest du einen Gegenstand direkt verkaufen, ohne zu bieten? Verwende |c00A79EFF%s

Du kannst das %s-Fenster direkt öffnen, indem du |c00A79EFF/gl Auktion eingibst

Gargul verfolgt |c00FF0000ALL gehandeltes Gold. Möchtest du nicht, dass ein Handel Teil dieser GDKP-Sitzung ist? Aktiviere beim Handel das Kontrollkästchen „Vom GDKP ausschließen“!

|c00FFF569Wusstest du schon?
Verliehene Gegenstände werden automatisch zum Handelsfenster hinzugefügt
Gargul kann auch das automatische Plündern für dich übernehmen. Probier es mit |c00A79EFF/gl pm aus
]];
L["\nThis window shows all the items that have been awarded on any given date (select one or more dates on the left).\n\nItems can contain the following tags:\n\n|c00A79EFFOS: Awarded for offspec\n|c00A79EFFSR: This item was soft-reserved\n|c00A79EFFWL: This item was wishlisted (Thatsmybis)\n|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)\n"] = [[
In diesem Fenster werden alle Gegenstände angezeigt, die an einem bestimmten Datum verliehen wurden (wähle links ein oder mehrere Daten aus).

Gegenstände können die folgenden Tags enthalten:

|c00A79EFFOS: Verliehen für Offspec
|c00A79EFFSR: Dieser Gegenstand war Soft-Reserved
|c00A79EFFWL: Dieser Gegenstand war auf einer Wunschliste (Thatsmybis)
|c00A79EFFPL: Dieser Gegenstand war auf einer Prio-Liste (Thatsmybis, DFT, prio3)
]];
L["\nThe items you see here are in the master looter's GDKP queue\nYou can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)\n\nYou can resize the window, move it around, or minimize it. Try it out!\n\nFor loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!\n"] = [[
Die Gegenstände, die du hier siehst, befinden sich in der GDKP-Warteschlange des Plündermeisters
Du kannst sie entfernen, darauf bieten und unbrauchbare Gegenstände ausblenden (aktiviere „Unbrauchbare Gegenstände ausblenden“ in den Einstellungen oben links).

Du kannst die Größe des Fensters ändern, es verschieben oder minimieren. Versuch es!

Für Plündermeister: Wenn du Gegenstände hier entfernst, werden sie nur aus deiner persönlichen Warteschlange entfernt, nicht aus der tatsächlichen GDKP-Warteschlange!
]];
L["Need more help?"] = "Benötigst du mehr Hilfe?";
L["Type"] = "Typ"; -- As in type of roll or type of item
L["unknown"] = "Unbekannt";
L["Unknown comm action '%s', make sure to update Gargul!"] = "Unbekannte Kommunikationsaktion „%s“, aktualisiere unbedingt Gargul!";
L["Unlock"] = "Freischalten";
L["Update Gargul!"] = "Aktualisiere Gargul!";
L["v"] = "v";
L["Report"] = "Bericht";
L["Report outdated results in group chat"] = "Veraltete Ergebnisse im Gruppenchat melden";
L["Gargul status"] = "Gargul-Status";
L["Checking version ..."] = "Version wird geprüft...";
L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"] = [[
|c0092FF00v%s: Der Spieler ist auf dem neuesten Stand
|c00F7922Ev%s: Der Spieler muss seine Add-ons aktualisieren
|c00BE3333%s: Der Spieler verfügt nicht über Gargul oder nutzt eine nicht unterstützte Version
|c00808080%s: Der Spieler ist offline oder ignoriert uns!
|c0000FFFF%s: Der Spieler steht auf unserer Ignorierliste!

]];
L["PLAYER IGNORED!"] = "SPIELER IGNORIERT!";
L["Offline"] = "Offline";
L["No response"] = "Keine Antwort";
L["No response:"] = "Keine Antwort:";
L["Offline:"] = "Offline:";
L["Outdated:"] = "Veraltet:";
L["Up-to-date:"] = "Up-to-date:";
L["Gargul is out of date and won't work until you update!"] = "Gargul ist veraltet und funktioniert erst, wenn du ein Update durchführst!";
L["Invalid version string provided in Version:addRelease"] = "Ungültige Versionszeichenfolge in Version:addRelease angegeben";
L["Update Gargul!"] = "Aktualisiere Gargul!";
L["|c00%sGargul is now updated to |c00%sv%s"] = "|c00%sGargul wird jetzt auf |c00%sv%s aktualisiert";
L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"] = "|c00A79EFFv%s ist auf CurseForge/Wago verfügbar. Du kannst aktualisieren, ohne dein Spiel zu schließen. Stell einfach sicher, dass du /reload ausführst!";
L["Wait %s more seconds before you retry"] = "Warte %s weitere Sekunden, bevor du es erneut versuchst";
L["Window"] = "Fenster";
L["Gargul v%s"] = "Gargul v%s";
L["Window Scale"] = "Fensterskalierung";
L["WL"] = "WL";
L["Yes"] = "Ja";
L["You disabled GDKP queues"] = "Du hast GDKP-Warteschlangen deaktiviert";
L["0"] = "0";
L["Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf"] = "Zlib-Komprimierung der Daten ist nicht möglich. Kontaktiere den Support über https://discord.gg/D3mDhYPVzf";
L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Zlib kann die Daten nicht dekomprimieren. Stell sicher, dass du es unverändert kopiert/eingefügt hast, ohne zusätzliche Zeichen oder Leerzeichen hinzuzufügen!";
