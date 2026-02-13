--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "itIT") then return; end
local L = Gargul_L or {};

L["About"] = "Di";
L["All Settings"] = "Tutte le impostazioni";
L["Announce"] = "Annunciare";
L["Anti Snipe"] = "Anti-beccaccino";
L["\n\nAn Anti Snipe value of 10 means that any bid that comes in with\nless than 10 seconds left will reset the timer back to 10 seconds\n\nYou can leave this empty or set to 0 to disable Anti Snipe completely.\nAnti Snipe values less than 5 are not supported\n\n"] = [[

Un valore Anti Snipe pari a 10 significa che qualsiasi offerta che arriva
meno di 10 secondi rimasti ripristineranno il timer su 10 secondi

Puoi lasciarlo vuoto o impostarlo su 0 per disabilitare completamente Anti Snipe.
I valori Anti Snipe inferiori a 5 non sono supportati

]];
L["Are you sure?"] = "Sei sicuro?";
L["\nDon't forget to use Gargul instead\nif you wish to export loot later\n\n\n-- Right-click to disable this window --"] = [[
Non dimenticare di usare invece Gargul
se desideri esportare il bottino in un secondo momento


-- Fare clic con il tasto destro per disabilitare questa finestra --]];
L["Auction"] = "Asta";
L["Auctioneer"] = "Banditore";
L["Auctions"] = "Aste";
L["Auto"] = "Auto";
L["Auto Roll"] = "Tiro automatico";
L["Enable Auto Roll"] = "Abilita tiro automatico";
L["Auto roll is active ( profile: %s )"] = "Tiro automatico attivo ( profilo: %s )";
L["now supports auto rolling: |c00%s/gl ar|r or |c00%s/gl autoroll|r"] = "Gargul ora supporta il tiro automatico: |c00%s/gl ar|r o |c00%s/gl autoroll|r";
L["You automatically passed on %s"] = "Hai passato automaticamente su %s";
L["You automatically needed on %s"] = "Hai tirato Need automaticamente su %s";
L["You automatically greeded on %s"] = "Hai tirato Greed automaticamente su %s";
L["Action"] = "Azione";
L["Add"] = "Aggiungi";
L["Add item rules to automatically roll need, greed or pass when a roll is announced. Rules are stored per item ID. When you win an item, its rule is automatically set to pass."] = "Aggiungi regole per tirare automaticamente need, greed o pass. Le regole sono salvate per ID oggetto. Quando vinci un oggetto, la sua regola passa automaticamente a pass.";
L["Add item rules to automatically roll need, greed or pass when a Gargul roll is announced (does not work with group loot rolls). Rules are stored per item ID. When you win an item, its rule is automatically set to pass. Shift-click items, drag them into the box below or just start typing to search."] = "Aggiungi regole per tirare automaticamente need, greed o pass quando viene annunciato un tiro Gargul (non funziona con i tiri di bottino di gruppo). Le regole sono salvate per ID. Quando vinci un oggetto, la sua regola passa a pass. Shift+clic sugli oggetti o trascinali nella casella sotto.";
L["Add rule"] = "Aggiungi regola";
L["4. Automatically roll need, greed or pass based on saved rules! Click below or use |c00A79EFF/gl ar"] = "4. Tira automaticamente need, greed o pass in base alle regole salvate! Clicca sotto o usa |c00A79EFF/gl ar";
L["Automatically roll need, greed or pass based on your saved rules when a Gargul roll is announced. Does not work with group loot rolls. Manage rules via the Auto Roll Rules section or |c00A79EFF/gl autoroll|r"] = "Tira automaticamente need, greed o pass in base alle tue regole quando viene annunciato un tiro Gargul. Non funziona con i tiri di bottino di gruppo. Gestisci le regole nella sezione Auto Roll Rules o |c00A79EFF/gl autoroll|r";
L["No rules yet. Add an item link and choose need, greed or pass."] = "Nessuna regola. Aggiungi un link oggetto e scegli need, greed o pass.";
L["Your rules"] = "Le tue regole";
L["Clear all"] = "Cancella tutto";
L["Remove all rules from this profile"] = "Rimuovi tutte le regole da questo profilo";
L["Remove all rules from this profile?"] = "Rimuovi tutte le regole da questo profilo?";
L["Item link, ID, or type to search"] = "Link o ID oggetto";
L["Manage Auto Roll Rules"] = "Gestisci regole tiro automatico";
L["Invalid item link or ID"] = "Link o ID oggetto non valido";
L["(copy)"] = "(copia)";
L["A profile with that name already exists."] = "Esiste già un profilo con questo nome.";
L["Copy profile"] = "Copia profilo";
L["Create profile"] = "Crea profilo";
L["Delete profile"] = "Elimina profilo";
L["Delete profile \"%s\"?"] = "Elimina profilo \"%s\"?";
L["No profile"] = "Nessun profilo";
L["Profile name"] = "Nome profilo";
L["Profile: "] = "Profilo: ";
L["Rename profile"] = "Rinomina profilo";
L["Auto award"] = "Premio automatico";
L["Auto trade"] = "Commercio automobilistico";
L["Available values:"] = "Valori disponibili:";
L["Award"] = "Premio";
L["Awarded To"] = "Assegnato a";
L["BR: %s"] = "BR: %s";
L["Price: %s"] = "Prezzi";
L["Given: yes"] = "Dato: sì";
L["Given: no"] = "Dato: no";
L["2nd bid: %s by %s"] = "2a offerta: %s per %s";
L["You won"] = "Hai vinto";
L["Award %s to %s?"] = "Premio da %s a %s?";
L["Are you sure you want to disenchant %s? %s boosted roll points will be refunded!"] = "Sei sicuro di voler disincantare %s? %s punti di lancio potenziati verranno rimborsati!";
L["In Group"] = "In gruppo";
L["Award history"] = "Storia del premio";
L["Who should %s go to instead?"] = "Da chi dovrebbe andare invece %s?";
L["Type player name here"] = "Digita qui il nome del giocatore";
L["or select one below"] = "oppure selezionane uno qui sotto";
L["Do you want to award %s to a random player?"] = "Vuoi assegnare %s a un giocatore casuale?";
L["Drag and drop or shift+click an item in the box on the right"] = "Trascina e rilascia oppure fai clic+maiusc su un elemento nella casella a destra";
L["(BR: %s)"] = "(BR: %s)";
L["Disenchanted items:"] = "Oggetti disincantati:";
L["(Given: yes)"] = "(Dato: sì)";
L["(Given: no)"] = "(Dato: no)";
L["(OS)"] = "(sistema operativo)";
L["%s boosted roll points will be refunded!"] = "%s punti di lancio potenziati verranno rimborsati!";
L["Are you sure you want to undo %s awarded to %s?%s"] = "Sei sicuro di voler annullare %s assegnato a %s?%s"; -- The last %s is the content of L["%s boosted roll points will be refunded!"]
L["Bag inspection failed: no reports received"] = "Ispezione del bagaglio fallita: nessuna segnalazione ricevuta";
L["Inspection finished"] = "Ispezione terminata";
L["Starting inspection..."] = "Inizio ispezione...";
L["Balance"] = "Bilancia";
L["Base"] = "Base";
L["Unable to base64 decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Impossibile decodificare i dati in base64. Assicurati di copiarlo/incollarlo così com'è senza aggiungere caratteri o spazi bianchi aggiuntivi!";
L["Bid"] = "Offerta";
L["Bids"] = "Offerte";
L["BOE"] = "BOE";
L["1. Auto invite/sort groups from raid signup! Click below or use |c00A79EFF/gl gr"] = "1. Invita/ordina automaticamente i gruppi dall'iscrizione al raid! Clicca qui sotto o usa |c00A79EFF/gl gr";
L["2. Reward players for being regulars or going the extra mile! Click below or use |c00A79EFF/gl br"] = "2. Premia i giocatori che diventano clienti abituali o che fanno il possibile! Clicca qui sotto o usa |c00A79EFF/gl br";
L["Gargul has a few tricks up its sleeve that you might not be aware of. Have a looksy!"] = "Gargul ha alcuni assi nella manica di cui potresti non essere a conoscenza. Fatti un'occhiata!";
L["3. Gargul includes a plus one tracking system! Click below or use |c00A79EFF/gl po"] = "3. Gargul include un sistema di tracciamento Plus One! Fare clic qui sotto o utilizzare |c00A79EFF/gl po";
L["Boosted Rolls"] = "Tiri potenziati";
L["BR"] = "BR";
L["\nAdd how many points for everyone currently in the raid?\n\n|c00BE3333Use the 'Add missing raiders' button first if you want everyone to get points, even those without a boosted roll entry!"] = [[
Aggiungi quanti punti per tutti coloro che sono attualmente nel raid?

|c00BE3333Utilizza prima il pulsante 'Aggiungi predoni mancanti' se vuoi che tutti ottengano punti, anche quelli senza una voce potenziata!]];
L["No point value provided!"] = "Nessun valore in punti fornito!";
L["Add points to raid"] = "Aggiungi punti al raid";
L["Add missing raiders"] = "Aggiungi i predoni mancanti";
L["Aliases"] = "Alias";
L["Apply aliases"] = "Applicare alias";
L["Boosted Roll Cost:"] = "Costo del tiro potenziato:";
L["Are you sure you want to broadcast your boosted roll data to everyone in your party/raid?"] = "Sei sicuro di voler trasmettere i tuoi dati di rollio potenziati a tutti i membri del tuo party/raid?";
L["Nothing to broadcast, import Boosted Rolls data first!"] = "Niente da trasmettere, importa prima i dati dei Rulli potenziati!";
L["Couldn't process BoostedRolls data received from %s"] = "Impossibile elaborare i dati BoostedRolls ricevuti da %s";
L["Attempting to process incoming BoostedRolls data from %s"] = "Tentativo di elaborare i dati BoostedRolls in arrivo da %s";
L["Are you sure you want to clear all boosted roll data?"] = "Sei sicuro di voler cancellare tutti i dati di rollio potenziati?";
L["Delete %s?"] = "Eliminare %s?";
L["Are you sure you want to clear your existing boosted roll data and import new data broadcasted by %s?"] = "Sei sicuro di voler cancellare i dati di rollio potenziati esistenti e importare i nuovi dati trasmessi da %s?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Dati forniti non validi. Assicurati che i contenuti seguano il formato richiesto e che non sia inclusa alcuna riga di intestazione";
L["\nHere you can import boosted roll data and aliases from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are optional and may contain aliases for the player.\nHere is an example line:\n\nFoobar,240,Barfoo"] = [[
Qui puoi importare dati e alias dei ruoli potenziati da una tabella in formato CSV o TSV o incollati da un foglio di documenti Google.

La tabella necessita di almeno due colonne: il nome del giocatore seguito dalla quantità di punti. Le colonne aggiuntive sono facoltative e possono contenere alias per il giocatore.
Ecco una riga di esempio:

Foobar,240,Barfoo]];
L["Points"] = "Punti";
L["Points: %s"] = "Punti: %s";
L["N/A"] = "N/D";
L["Reserve"] = "Riserva";
L["\nAre you sure you want to update your existing boosted rolls with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Sei sicuro di voler aggiornare i tuoi elenchi potenziati esistenti con i dati di %s?

Il tuo ultimo aggiornamento è stato su |c00A79EFF%s, il loro su |c00A79EFF%s.]];
L["!bonus|!rb|!br"] = "!bonus|!rb|!br";
L["Broadcast"] = "Trasmissione";
L["Broadcasting..."] = "Trasmissione...";
L["You are currently in combat, delaying broadcast"] = "Attualmente sei in combattimento, stai ritardando la trasmissione";
L["Broadcast finished!"] = "Trasmissione terminata!";
L["Include awarded items"] = "Includi oggetti premiati";
L["Include disenchanted items"] = "Includi oggetti disincantati";
L["Include hidden items"] = "Includi oggetti nascosti";
L["Include time left"] = "Includi il tempo rimasto";
L["Broadcast still in progress"] = "Trasmissione ancora in corso";
L["There is nothing to broadcast"] = "Non c'è niente da trasmettere";
L["Number of items"] = "Numero di articoli";
L["Broadcast ${percentage}%"] = "Trasmetti ${percentage}%";
L["Target player (whisper only)"] = "Giocatore bersaglio (solo sussurro)";
L["Whisper requires a target player"] = "Whisper richiede un giocatore bersaglio";
L["Max trade time left (in minutes)"] = "Tempo massimo di scambio rimasto (in minuti)";
L["by"] = "di"; -- As in 'bid BY'
L["Cancel"] = "Annulla";
L["Get support or share ideas on our Discord"] = "Ottieni supporto o condividi idee sul nostro Discord";
L["Enable changelog"] = "Abilita il registro delle modifiche";
L["Gargul makes handing out loot super easy, click the button below to get started!"] = "Gargul rende semplicissimo distribuire il bottino, fai clic sul pulsante in basso per iniziare!";
L["Open Gargul"] = "Apri Gargul";
L["Adjust Scale"] = "Regola scala";
L["Channel"] = "Canale";
L["Officer"] = "Ufficiale";
L["Raid Warning"] = "Avviso raid";
L["Whisper"] = "Sussurro";
L["CPR"] = "RCP";
L["Clear"] = "Chiaro"; -- As in clearing a window or data
L["Close"] = "Vicino";
L["Close on award"] = "Vicino al premio";
L["Close on start"] = "Chiudi all'avvio";
L["Communication"] = "Comunicazione";
L["Sent %s of %s bytes"] = "Inviati %s di %s byte";
L["c"] = "C";
L["Cut"] = "Taglio";
L["Cuts"] = "Tagli";
L["Can't send mail when the mailbox is closed"] = "Impossibile inviare posta quando la casella di posta è chiusa";
L["Multiple mail errors detected, aborting cut distribution"] = "Rilevati più errori di posta, interruzione della distribuzione tagliata";
L["You don't owe %s any gold"] = "Non devi oro a %s";
L["Failed to send cut to %s"] = "Impossibile inviare il taglio a %s";
L["Mail SENT according to game, but your remaining GOLD DOESN'T MATCH, did something go wrong?"] = "Mail INVIATA in base al gioco, ma i tuoi ORO rimanenti NON CORRISPONDONO, qualcosa è andato storto?";
L["Mail History for |c00967FD2%s"] = "Cronologia posta per |c00967FD2%s";
L["You don't have enough gold to pay %s"] = "Non hai abbastanza oro per pagare %s";
L["Wait a bit, we're still processing the previous mail"] = "Aspetta un attimo, stiamo ancora elaborando la posta precedente";
L["Gargul GDKP: %sg"] = "Gargul GDKP: %sg";
L["Sent %sg to %s"] = "Inviato %sg a %s";
L["%Y-%m-%d"] = "%Y-%m-%d";
L["%Y-%m-%d %H:%M"] = "%Y-%m-%d %H:%M";
L["%d-%m %H:%M"] = "%d-%m %H:%M";
L["Delete"] = "Eliminare";
L["Details"] = "Dettagli";
L["DFT"] = "DFT";
L["Disable"] = "disattivare";
L["https://discord.gg/D3mDhYPVzf"] = "https://discord.gg/D3mDhYPVzf";
L["Disenchant"] = "Disincantare";
L["Edit"] = "Modificare";
L["Enable"] = "Abilitare";
L["Export"] = "Esportare";
L["Are you sure you want to remove your complete reward history table? This deletes ALL loot data and cannot be undone!"] = "Sei sicuro di voler rimuovere la tabella completa della cronologia dei premi? Questa operazione elimina TUTTI i dati del bottino e non può essere annullata!";
L["Are you sure you want to remove all data for %s? This cannot be undone!"] = "Sei sicuro di voler rimuovere tutti i dati per %s? Questa operazione non può essere annullata!";
L["\nThis is an export feature ONLY, there is no point editing any of the values: THEY WON'T BE SAVED!\n\n"] = [[
Questa è SOLO una funzione di esportazione, non ha senso modificare nessuno dei valori: NON VERRANNO SALVATI!

]];
L["Fill"] = "Riempire";
L["Final Call"] = "Chiamata finale";
L["Finish"] = "Fine";
L["Format"] = "Formato";
L["Gargul"] = "Gargul";
L["GDKP"] = "GDKP";
L["GDKP raids are not allowed in this version of World of Warcraft"] = "I raid GDKP non sono consentiti in questa versione di World of Warcraft";
L["GDKP Active!"] = "GDKP attivo!";
L["Add dropped loot to queue"] = "Aggiungi il bottino lasciato alla coda";
L["Gold (- for removing gold)"] = "Oro (- per rimuovere l'oro)";
L["Who pays for this?"] = "Chi paga per questo?";
L["Gold needs to be lower/higher than 0"] = "L'oro deve essere inferiore/superiore a 0";
L["Paid for by"] = "Pagato da";
L["Adjust gold in %s"] = "Modifica l'oro in %s";
L["You can't give AND receive gold from the same player at the same time"] = "Non puoi dare E ricevere oro dallo stesso giocatore allo stesso tempo";
L["All cuts were mailed!"] = "Tutti i tagli sono stati spediti per posta!";
L["Disable for disenchanted"] = "Disabilita per disincantato";
L["Disable in combat"] = "Disabilita in combattimento";
L["Auctions"] = "Aste";
L["Created by"] = "Creato da";
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Eliminato da %s
Motivi]];
L["\n|c00%s%s added to pot by %s\nNote: %s"] = [[
|c00%s%sg aggiunto al piatto da %s
Appunti]];
L["Won by"] = "Vinto da";
L["Set paid amount (read left)"] = "Imposta l'importo pagato (leggi a sinistra)";
L["\n\nGargul automatically keeps track of gold traded. As long as players pay\nfor what they bought then you shouldn't ever need this field\n\n'Paid amount' refers to the amount of gold the buyer already traded you.\nThis does not change the actual price of the item!\n\nWarning: only set a value here if the player promises to pay\noutside of the raid or trades the gold from an alt / mail etc!\n\n\n"] = [[

Gargul tiene traccia automaticamente dell'oro scambiato. Purché i giocatori paghino
per quello che hanno comprato allora non dovresti mai aver bisogno di questo campo

L''importo pagato' si riferisce alla quantità di oro che l'acquirente ti ha già scambiato.
Ciò non modifica il prezzo effettivo dell'articolo!

Attenzione: imposta qui un valore solo se il giocatore promette di pagare
al di fuori del raid o scambia l'oro da un alt/mail ecc!


]];
L["GDKP Price:"] = "Prezzo PIL:";
L["Award %s to %s for %s?"] = "Premio da %s a %s per %s?";
L["Auto Bid"] = "Offerta automatica";
L["What's your maximum bid? (Minimum %s|c00FFF569g)"] = "Qual è la tua offerta massima? (Minimo %s|c00FFF569g)";
L["Bid denied!"] = "Offerta rifiutata!";
L["Min bid: %sg   Increment: %sg"] = "Offerta minima: %sg Incremento: %sg";
L["(max %sg)"] = "(massimo %sg)";
L["New bid"] = "Nuova offerta";
L["Stop Auto Bid"] = "Interrompi l'offerta automatica";
L["Top bid: %s by %s"] = "Offerta migliore: %s per %s";
L["Top bid: %s by you"] = "Offerta migliore: %s da parte tua";
L["Create a new GDKP session"] = "Crea una nuova sessione GDKP";
L["Management Cut %"] = "Taglio gestionale%";
L["Management Cut needs to be empty or between 0 and 99 (no % sign!)"] = "Il taglio di gestione deve essere vuoto o compreso tra 0 e 99 (nessun segno %!)";
L["Choose a session type!"] = "Scegli un tipo di sessione!";
L["Switch to this session"] = "Passa a questa sessione";
L["\n\n|c00A79EFFMulti-Auction allows you to start bids on multiple items at once, speeding things up!\nFollow the instructions after creating this session to get started\n\nWith |c00A79EFFSingle-Auction you choose to auction off single items instead or use the queue\n\nSelecting |c00A79EFFMulti-Auction prevents dropped items from being added to the queue\nYou can mix |c00A79EFFMulti-Auction with |c00A79EFFSingle-Auction and the queue but we strongly advise against it\n\n"] = [[

|c00A79EFFLa multi-asta ti consente di fare offerte su più oggetti contemporaneamente, velocizzando il tutto!
Segui le istruzioni dopo aver creato questa sessione per iniziare

Con |c00A79EFFSingle-Auction scegli invece di mettere all'asta singoli oggetti o di utilizzare la coda

Selezionando |c00A79EFFMulti-Auction si evita che gli oggetti scartati vengano aggiunti alla coda
È possibile combinare |c00A79EFFMulti-Auction con |c00A79EFFSingle-Auction e la coda ma lo sconsigliamo vivamente

]];
L["Auction type (|c00A79EFFi for more info)"] = "Tipo di asta (|c00A79EFFi per maggiori informazioni)";
L["Multi-Auction"] = "Asta multipla";
L["Single-Auction"] = "Asta singola";
L["Session created. We advise you to /reload regularly so that it's stored properly in case your game crashes!"] = "Sessione creata. Ti consigliamo di /reload in modo che venga archiviato correttamente nel caso in cui il gioco si blocchi!";
L["Add Raider"] = "Aggiungi Raider";
L["adjust [g]"] = "regolare [g]";
L["adjust [%]"] = "regolare [%]";
L["Announce the base cut in group chat"] = "Annuncia il taglio base nella chat di gruppo";
L["Are you sure you want to reset all players and calculations? Note: all players no longer in the raid will be removed from the list!"] = "Sei sicuro di voler reimpostare tutti i giocatori e i calcoli? Nota: tutti i giocatori non più presenti nel raid verranno rimossi dalla lista!";
L["Delete Raider"] = "Elimina Raider";
L["Edit Raider"] = "Modifica Raider";
L["Lock and Pay"] = "Blocca e paga";
L["Manage gold trades"] = "Gestisci le transazioni in oro";
L["\n\nWith mutators you can give more or less gold to players\nExample: giving 2% extra to tanks is what mutators are for!\n\nNote: Editing or deleting mutators here only changes them for this session\n\n"] = [[

Con i mutatori puoi dare più o meno oro ai giocatori
Esempio: dare il 2% in più ai carri armati è a cosa servono i mutatori!

Nota: la modifica o l'eliminazione dei mutatori qui li modifica solo per questa sessione

]];
L["Not in the raid"] = "Non nel raid";
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
L["%s Raiders | %s With cut | Total payout: %s"] = "%s Predoni | %s Con taglio | Pagamento totale: %sg";
L["Nothing to import, double check your CSV"] = "Niente da importare, ricontrolla il tuo CSV";
L["Missing gold for player %s"] = "Oro mancante per il giocatore %s";
L["Missing header, note: it's case-sensitive!"] = "Intestazione mancante, nota: fa distinzione tra maiuscole e minuscole!";
L["Missing player name"] = "Nome del giocatore mancante";
L["Delete bid. Auction must be stopped first!"] = "Elimina l'offerta. L'asta deve essere fermata prima!";
L["Add a raider to this session"] = "Aggiungi un raider a questa sessione";
L["Custom (create your own format)"] = "Personalizzato (crea il tuo formato)";
L["Detailed (JSON)"] = "Dettagliato (JSON)";
L["Share (can be imported by other players)"] = "Condividi (può essere importato da altri giocatori)";
L["Your custom format"] = "Il tuo formato personalizzato";
L["Your custom header"] = "La tua intestazione personalizzata";
L["Custom (create your own format)"] = "Personalizzato (crea il tuo formato)";
L["@PLAYER,@CUT"] = "@GIOCATORE,@TAGLIO";
L["Player,Cut"] = "Giocatore,Taglia";
L["date/time at which the session was locked"] = "data/ora in cui la sessione è stata bloccata";
L["total gold given to the player"] = "oro totale dato al giocatore";
L["gold mailed to the player"] = "oro inviato al giocatore";
L["total gold received from the player"] = "oro totale ricevuto dal giocatore";
L["date/time at which the first item was awarded"] = "data/ora in cui è stato assegnato il primo oggetto";
L["gold traded to the player"] = "oro scambiato al giocatore";
L["@ITEM,@WINNER,@GOLD,@WOWHEAD"] = "@OGGETTO,@VINCITORE,@ORO,@WOWHEAD";
L["Item,Player,Gold,Wowheadlink"] = "Oggetto, Giocatore, Oro, Wowheadlink";
L["Date/time at which the first item was awarded"] = "Data/ora in cui è stato assegnato il primo item";
L["The title of the GDKP session"] = "Il titolo della sessione del GDKP";
L["Include disenchanted items"] = "Includi oggetti disincantati";
L["Pot changed"] = "La pentola è cambiata";
L["Gold Trades"] = "Commerci d'oro";
L["Are you sure? You won't be able to see, or bid on, upcoming items!"] = "Sei sicuro? Non sarai in grado di vedere o fare offerte sui prossimi articoli!";
L["\n|c00BE3333!! WARNING !!|r\n\nYou're on a connected realm and are importing player names without\na realm suffix, '%s' for example. This can cause you to send\ncuts and cut mails to the wrong player.\n\nWhen on a connected realm always try to include the realm name of players!\n\nContinue importing?\n"] = [[
|c00BE3333!! ATTENZIONE!!!|r

Sei su un reame connesso e stai importando i nomi dei giocatori senza
un suffisso di regno, '%s' per esempio. Ciò può causare l'invio
taglia e taglia le mail al giocatore sbagliato.

Quando sei su un reame connesso, cerca sempre di includere il nome del reame dei giocatori!

Continuare l'importazione?
]];
L["This will override any changes you've made to the cut window, are you sure?"] = "Ciò sovrascriverà qualsiasi modifica apportata alla finestra di taglio, sei sicuro?";
L["\nYou can import player cuts from your own calculations like a google sheet. softres GDKP etc.\n\nThe format is as follows (|c00BE3333INCLUDE THE HEADER!!):\n\n|c00BE3333Player,Gold|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n"] = [[
Puoi importare i tagli dei giocatori dai tuoi calcoli come un foglio di Google. softres GDKP ecc.

Il formato è il seguente (|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333Giocatore,Oro|c00967FD2
Giocatore1,4000
Giocatore2,4125
Giocatore3,3998


]];
L["\nImport GDKP minimum prices and increments.\n\nThe format is as follows: ItemID + minimum or increment are required. (|c00BE3333REQUIRES A HEADER!!):\n\n|c00BE3333ItemID,Minimum,Increment|c00967FD2\n18608,4000,500\n"] = [[
Importa prezzi minimi e incrementi GDKP.

Il formato è il seguente: ItemID + minimo o incremento sono obbligatori. (|c00BE3333RICHIEDE UN'INTESTAZIONE!!):

|c00BE3333IDArticolo,Minimo,Incremento|c00967FD2
18608,4000,500
]];
L["Delete existing price settings? Click yes to delete all price data, no to simply override existing ones with the data you provided here"] = "Eliminare le impostazioni di prezzo esistenti? Fai clic su Sì per eliminare tutti i dati sui prezzi, su No per sovrascrivere semplicemente quelli esistenti con i dati forniti qui";
L["Import GDKP Session"] = "Importa sessione GDKP";
L["Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp where they select the 'Share (can be imported by other players)' format"] = "Qui puoi importare (e continuare) una sessione GDKP. Per ottenere una sessione GDKP da qualcuno, è necessario esportarla in |c00FFF569/gdkp dove selezionare il formato 'Condividi (può essere importato da altri giocatori)'";
L["You're about to import a GDKP session created by %s, are you sure?"] = "Stai per importare una sessione GDKP creata da %s, sei sicuro?";
L["This GDKP session created by %s appears to exist already, do you wish to override it?"] = "Questa sessione GDKP creata da %s sembra già esistere, desideri sovrascriverla?";
L["Invalid data provided for GDKP extension!"] = "Dati non validi forniti per l'estensione GDKP!";
L["Invalid data provided for GDKP reschedule!"] = "Dati non validi forniti per la riprogrammazione GDKP!";
L["Invalid data provided for GDKP shortening!"] = "Dati non validi forniti per l'accorciamento GDKP!";
L["Invalid data provided for GDKP auction start!"] = "Dati non validi forniti per l'inizio dell'asta GDKP!";
L["Invalid number provided for 'paid'"] = "Numero non valido fornito per 'pagato'";
L["Invalid time provided in Auction:reschedule"] = "Orario non valido fornito nell'asta: riprogrammare";
L["\n\n|c00967FD2GDKP Data (sold %sx)\nLast sold for: %s\nAverage price: %s\nMinimum bid: %s\nIncrement: %s\n\n"] = [[

|c00967FD2GDKP Dati (venduti %sx)
Ultimo venduto per: %s
Prezzo medio: %s
Offerta minima: %s
Incremento: %s

]];
L["Balance:   |c0092FF000 ? You're square!  |  |c00BE333330 ? you owe %s 30g  |  |c00F7922E50 ? %s owes you 50g"] = "Saldo: |c0092FF000 ? Sei quadrato! | |c00BE333330 ? devi %s 30g | |c00F7922E50 ? %s ti deve 50 g";
L["Gold mailed to you by %s"] = "Oro inviato via posta da %s";
L["Gold paid to %s"] = "Oro pagato a %s";
L["Gold received from %s"] = "Oro ricevuto da %s";
L["Gold %s by"] = "Oro %s di"; -- %s = removed or added
L["Total pot: %sg | Management cut: %sg (%s%%) | To distribute: %sg"] = "Piatto totale: %sg | Taglio gestionale: %sg (%s%%) | Per distribuire: %sg";
L["|c00967FD2%s | By %s%s | On |c00967FD2%s"] = "|c00967FD2%s | Di %s%s | Su |c00967FD2%s";
L["The GDKP Session is not available or locked"] = "La sessione GDKP non è disponibile o è bloccata";
L["Mail All"] = "Invia posta a tutti";
L["No bids on Legendary+ item detected, continue manually!"] = "Nessuna offerta rilevata per un oggetto Leggendario+, continua manualmente!";
L["Missing content in Auction:start"] = "Contenuto mancante nell'asta:inizio";
L["\n\nWith multi auctions (or batch auctions) you can auction off as many items as you want at once!\nThis speeds up your raid nights immensely and makes for a seamless experience for your raiders\n\nAll tradable items still in your inventory can automatically be auctioned with 'Fill from inventory'\nGive it a shot!\n\n|c00808080There is but one con: in order for people to partake in a batch auction raiders will need Gargul!\n\n"] = [[

Con le aste multiple (o aste batch) puoi mettere all'asta tutti gli oggetti che desideri contemporaneamente!
Ciò velocizza enormemente le tue notti di raid e rende l'esperienza senza soluzione di continuità per i tuoi predoni

Tutti gli oggetti commerciabili ancora nel tuo inventario possono essere automaticamente messi all'asta con 'Riempi dall'inventario'
Dagli Un colpo!

|c00808080C'è solo uno svantaggio: affinché le persone possano partecipare a un'asta batch, i predoni avranno bisogno di Gargul!

]];
L["You need to have an active (unlocked) GDKP session!"] = "Devi avere una sessione GDKP attiva (sbloccata)!";
L["With this window open, %s items to add them to the list or click 'Fill from inventory' below"] = "Con questa finestra aperta, %s articoli per aggiungerli all'elenco oppure fai clic su 'Riempi dall'inventario' di seguito"; -- %s holds the add item hotkey (default ALT_CLICK)
L["Anti snipe in seconds"] = "Anti beccaccino in pochi secondi";
L["The anti snipe value needs to be 0 (empty) or >=5"] = "Il valore anti-snipe deve essere 0 (vuoto) o >=5";
L["Go back to the item selector"] = "Torna al selettore degli elementi";
L["Remove all items from the list"] = "Rimuovi tutti gli elementi dall'elenco";
L["Fill from inventory"] = "Riempi dall'inventario";
L["Add tradeable items from your inventory to the list"] = "Aggiungi oggetti commerciabili dal tuo inventario all'elenco";
L["\nHere you determine which items to include in your multi-auction session\n\nUse the |c00A79EFFFill from inventory button below to add items that can still be traded to the list\nWhenever you clear and re-open this window, your last fill settings will be used to automatically add items\n\n|c00A79EFF%s items to manually add them to the list\n"] = [[
Qui puoi determinare quali articoli includere nella sessione multi-asta

Utilizza il pulsante |c00A79EFFRiempi dall'inventario qui sotto per aggiungere oggetti che possono ancora essere scambiati all'elenco
Ogni volta che cancelli e riapri questa finestra, le ultime impostazioni di riempimento verranno utilizzate per aggiungere automaticamente gli elementi

|c00A79EFF%s elementi per aggiungerli manualmente all'elenco
]];
L["Next step: check raider's add-on version for compatibility"] = "Passaggio successivo: controlla la compatibilità della versione aggiuntiva di Raider";
L["Not everyone is using Gargul, are you sure you want to start the auction?"] = "Non tutti usano Gargul, sei sicuro di voler iniziare l'asta?";
L["Select at least one item for your auction"] = "Seleziona almeno un oggetto per la tua asta";
L["Your Gargul is outdated, we recommend updating before starting a session to prevent issues!"] = "Il tuo Gargul è obsoleto, ti consigliamo di aggiornarlo prima di iniziare una sessione per evitare problemi!";
L["Not everyone is up-to-date. If you're experiencing issues, tell your raiders to update!"] = "Non tutti sono aggiornati. Se riscontri problemi, dì ai tuoi raider di aggiornare!";
L["There is an active multi-auction, items you add here will be added to the existing session. Be mindful of duplicate items!"] = "C'è un'asta multipla attiva, gli articoli che aggiungi qui verranno aggiunti alla sessione esistente. Fai attenzione agli articoli duplicati!";
L["Search name or iLVL"] = "Cerca nome o iLVL";
L["Supports item names and iLVL e.g. '252', '<252' etc"] = "Supporta nomi di elementi e iLVL, ad es. '252', '<252' ecc";
L["Active GDKP Session: |c00967FD2%s | By %s%s | On |c00967FD2%s"] = "Sessione GDKP attiva: |c00967FD2%s | Di %s%s | Su |c00967FD2%s";
L["Auction time in seconds"] = "Tempo dell'asta in secondi";
L["The auction time in seconds needs to be >= 10"] = "Il tempo dell'asta in secondi deve essere >= 10";
L["You left during your GDKP bidding session. In order to resume it you have to provide a new bid time (in seconds) for any unsold items"] = "Te ne sei andato durante la sessione di offerte GDKP. Per riprenderlo devi fornire un nuovo tempo di offerta (in secondi) per tutti gli articoli invenduti";
L["With this window open, %s items to add them to the list"] = "Con questa finestra aperta, %s elementi per aggiungerli all'elenco";
L["Click the cogwheel icon to manage an auction"] = "Fai clic sull'icona dell'ingranaggio per gestire un'asta";
L["You're already the top bidder on %s"] = "Sei già il miglior offerente su %s";
L["Bid |c00%s%sg\nBy %s"] = [[
Offerta |c00%s%sg
Entro %s]];
L["|c00%sCLOSED\nNo bids"] = [[
|c00%sCHIUSO
Nessuna offerta]];
L["Minimum: |c00%s%sg\nIncrement: |c00%s%sg"] = [[
Minimo: |c00%s%sg
Incremento: |c00%s%sg]];
L["Items: %s  -  Total sold: %sg  -  Pledged by me: %sg"] = "Articoli: %s - Totale venduto: %sg - Promesso da me: %sg";
L["Items with bids: %s/%s\nTotal sold: %s\nBought by me: %s\nTotal bid (does not include sold): %s\nBid by me (does not include sold): %s\n"] = [[
Elementi con offerte: %s/%s
Totale venduto: %s
Comprato da me: %s
Offerta totale (non include la vendita): %s
Fai un'offerta (non include la vendita): %s
]];
L["|c00%sSOLD to%s\nfor |c00%s%s"] = [[
|c00%sVENDUTO a
%s per |c00%s%sg]];
L["Bid |c00%s%s\nBy |c0092FF00YOU!"] = [[
Offerta |c00%s%sg
Di |c0092FF00YOU!]];
L["Could not stop auto bidding on %s, try again or /reload!"] = "Impossibile interrompere le offerte automatiche su %s, riprova o /ricarica!";
L["Auto bid up to a maximum of %sg"] = "Offerta automatica fino a un massimo di %sg";
L["Auto bid up to the bid you fill in on the left"] = "Offerta automatica fino all'offerta che inserisci a sinistra";
L["Stop your auto bid (%sg)"] = "Interrompi la tua offerta automatica (%sg)";
L["Bid on %s could not be confirmed"] = "Impossibile confermare l'offerta su %s";
L["Invalid bid or bid is too low! The minimum is %sg"] = "Offerta non valida o offerta troppo bassa! Il minimo è %sg";
L["You need to wait two seconds between bids on the same item"] = "È necessario attendere due secondi tra le offerte sullo stesso articolo";
L["Clear bids"] = "Offerte chiare";
L["Remove all bids from the auction"] = "Rimuovi tutte le offerte dall'asta";
L["Close all"] = "Chiudi tutto";
L["Close ALL auctions?"] = "Chiudere TUTTE le aste?";
L["Close ALL auctions\n\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Chiudi TUTTE le aste

Le aste con offerte attive verranno vendute e non potranno ricevere nuove offerte!
]];
L["Close Auction"] = "Chiudi l'asta";
L["Close the auction. Players can no longer bid but the highest bid remains active"] = "Chiudi l'asta. I giocatori non possono più fare offerte ma l'offerta più alta rimane attiva";
L["Remove the item from the auction including its bid details. THIS CAN'T BE UNDONE!"] = "Rimuovi l'oggetto dall'asta compresi i dettagli dell'offerta. QUESTO NON PUÒ ESSERE ANNULLATO!";
L["Disenchant all finished but unsold items?"] = "Disincantare tutti gli oggetti finiti ma invenduti?";
L["Disenchant unsold items\n\nThis will mark all unsold items as disenchanted and they will not show up in a new multi-auction session"] = [[
Disincanta gli oggetti invenduti

Ciò contrassegnerà tutti gli articoli invenduti come disincantati e non verranno visualizzati in una nuova sessione di aste multiple
]];
L["Favorite this item"] = "Aggiungi questo articolo ai preferiti";
L["Give a final call timer of how many seconds?"] = "Fornire un timer per la chiamata finale di quanti secondi?";
L["The minimum amount of seconds is 5"] = "Il numero minimo di secondi è 5";
L["Start a final call for this auction by giving a (usually shorter) bid timer"] = "Avvia una chiamata finale per quest'asta fornendo un timer di offerta (solitamente più breve).";
L["Close ALL auctions and wrap up this multi-auction session?"] = "Chiudere TUTTE le aste e concludere questa sessione multi-asta?";
L["Finish Multi-Auction session\n\nThis will close all auctions and announce the total pot in chat\nAuctions with active bids on them will be sold and can not receive new bids!"] = [[
Termina la sessione di aste multiple

Questo chiuderà tutte le aste e annuncerà il piatto totale in chat
Le aste con offerte attive verranno vendute e non potranno ricevere nuove offerte!
]];
L["Hide inactive"] = "Nascondi inattivo";
L["Hide unusable"] = "Nascondi inutilizzabile";
L["Show/Hide finished auctions"] = "Mostra/Nascondi le aste finite";
L["Manage Auction"] = "Gestisci asta";
L["Bid the minimum required amount"] = "Fai un'offerta per l'importo minimo richiesto";
L["Bidding window closed, use |c00A79EFF/gl bid to reopen it!"] = "Finestra di offerta chiusa, usa |c00A79EFF/gl bid per riaprirla!";
L["Announce sales in chat"] = "Annuncia le vendite in chat";
L["Play sound when outbid"] = "Riproduci un suono quando l'offerta viene superata";
L["More sound options..."] = "Altre opzioni audio...";
L["Show all"] = "Mostra tutto";
L["Show favorites"] = "Mostra preferiti";
L["Show inactive"] = "Mostra inattivo";
L["Show unusable"] = "Mostra inutilizzabile";
L["This item was sold. Use ledger (|c00%s/gdkp) to make changes!"] = "Questo articolo è stato venduto. Utilizza il registro (|c00%s/gdkp) per apportare modifiche!";
L["Terminate"] = "Terminare";
L["Remove all bidsl bids and close all auctions?"] = "Rimuovere tutte le offerte bidsl e chiudere tutte le aste?";
L["Terminate Multi-Auction session\n\nThis will delete all bids on items that haven't sold yet and close all auctions!"] = [[
Termina la sessione multi-asta

Ciò eliminerà tutte le offerte sugli articoli che non sono ancora stati venduti e chiuderà tutte le aste!
]];
L["Hover over any of the buttons below for more information"] = "Passa il mouse su uno dei pulsanti sottostanti per ulteriori informazioni";
L["Show/Hide items you can't use"] = "Mostra/nascondi gli elementi che non puoi utilizzare";
L["Invalid data provided for GDKP auction start!"] = "Dati non validi forniti per l'inizio dell'asta GDKP!";
L["%s bought %s for %s"] = "%s ha acquistato %s per %sg";
L["The loot master (%s) is outdated, this can cause bids to fail!"] = "Il loot master (%s) è obsoleto, questo può far fallire le offerte!";
L["You were outbid!"] = "La tua offerta è stata superata!";
L["Mutators"] = "Mutatori";
L["Add Mutator"] = "Aggiungi Mutatore";
L["Auto apply to"] = "Applicazione automatica a";
L["Create a new GDKP mutator"] = "Crea un nuovo mutatore GDKP";
L["Delete. Hold shift to bypass confirmation"] = "Eliminare. Tieni premuto il turno per ignorare la conferma";
L["Edit mutator"] = "Modifica mutatore";
L["Flat gold rate [example: 250]"] = "Tasso fisso dell'oro [esempio: 250]";
L["The flat rate needs to be a number"] = "La tariffa forfettaria deve essere un numero";
L["\nExample:\n|c00967FD2SELF,RL,HEALER"] = [[
Esempio:
|c00967FD2SELF,RL,GUARITORE]];
L["You can automatically apply this mutator to raiders using keywords:"] = "Puoi applicare automaticamente questo mutatore ai predoni usando le parole chiave:";
L["Name [example: Tanks]"] = "Nome [esempio: Serbatoi]";
L["Mutator names can not contains dots (.)"] = "I nomi dei mutanti non possono contenere punti (.)";
L["Percentage [example: 10]"] = "Percentuale [esempio: 10]";
L["The percentage needs to be a number"] = "La percentuale deve essere un numero";
L["Store for future sessions"] = "Conservare per sessioni future";
L["Unknown mutator: %s"] = "Mutatore sconosciuto: %s";
L["User '%s' is not allowed to start auctions"] = "All'utente '%s' non è consentito avviare aste";
L["User '%s' is not allowed to stop auctions"] = "All'utente '%s' non è consentito interrompere le aste";
L["User '%s' is not allowed to stop auction: auction invalid"] = "L'utente '%s' non è autorizzato a interrompere l'asta: asta non valida";
L["There's not enough gold to distribute, expect some weird cut calculations!"] = "Non c'è abbastanza oro da distribuire, aspettatevi strani calcoli sui tagli!";
L["No bids!"] = "Nessuna offerta!";
L["You were outbid!"] = "La tua offerta è stata superata!";
L["(active)"] = "(attivo)";
L["\nYou need lead or master loot to adjust gold.\nYou can't adjust gold on locked/deleted sessions"] = [[
Hai bisogno di piombo o bottino principale per regolare l'oro.
Non è possibile modificare l'oro nelle sessioni bloccate/eliminate]];
L["Add/Remove gold"] = "Aggiungi/Rimuovi oro";
L["\n%s paid |c00%s%s for\n%s"] = [[
%s pagato |c00%s%s per
%s]]; -- Player paid 5000g for [Benediction]
L["\n|c00be3333Deleted by %s\nReason: %s"] = [[
|c00be3333Eliminato da %s
Motivi]];
L["(deleted)"] = "(eliminato)";
L["\nYou need lead or master loot to delete entries.\nYou can't delete entries on locked/deleted sessions"] = [[
Hai bisogno di lead o bottino principale per eliminare le voci.
Non è possibile eliminare le voci nelle sessioni bloccate/eliminate]];
L["Provide a reason for deleting this entry"] = "Fornire un motivo per eliminare questa voce";
L["Delete. Hold shift to bypass note"] = "Eliminare. Tieni premuto Maiusc per ignorare la nota";
L["Sessions with auctions attached to them will be deleted after 48 hours"] = "Le sessioni con aste allegate verranno cancellate dopo 48 ore";
L["\nYou need lead or master loot to edit entries.\nYou can't edit deleted entries or entries on locked/deleted sessions"] = [[
Hai bisogno di lead o bottino principale per modificare le voci.
Non è possibile modificare le voci eliminate o le voci presenti su sessioni bloccate/eliminate]];
L["Export a session so others can view session details or even replace you as a loot master"] = "Esporta una sessione in modo che altri possano visualizzarne i dettagli o addirittura sostituirti come maestro del bottino";
L["Import a session from another player or account"] = "Importa una sessione da un altro giocatore o account";
L["\nShow a full overview of the ledger,\nideal for screenshotting purposes!"] = [[
Mostra una panoramica completa del libro mastro,
ideale per scopi di screenshot!]];
L["Locking a session means you can't auction items or otherwise change anything until you unlock it, are you sure?"] = "Bloccare una sessione significa che non puoi mettere all'asta oggetti o modificare in altro modo nulla finché non la sblocchi, sei sicuro?";
L["Lock or unlock the session"] = "Blocca o sblocca la sessione";
L["Lock the session for payout"] = "Blocca la sessione per il pagamento";
L["Multi-auction: auction multiple items at once!"] = "Asta multipla: metti all'asta più oggetti contemporaneamente!";
L["added to"] = "aggiunto a";
L["\n|c00%s%s %s pot by %s\nNote: %s"] = [[
|c00%s%s %s piatto di %s
Appunti]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L["removed from"] = "rimosso da";
L["\nPot: %s\nManagement cut (%s%%): %sg\nPer player cut (1/%s): %sg\n"] = [[
Vaso: %s
Taglio gestionale (%s%%): %sg
Taglio per giocatore (1/%s): %sg
]];
L["\nYou need lead or master loot to restore entries.\nYou can't restore entries of locked/deleted sessions"] = [[
Hai bisogno di piombo o bottino principale per ripristinare le voci.
Non è possibile ripristinare le voci delle sessioni bloccate/eliminate]];
L["By %s%s | On |c00%s%s%s"] = "Di %s%s | Il |c00%s%s%s"; -- By name<guild> on date
L["Unlocking and changing the pot or cuts can get really messy, especially if you've already done payouts. Are you sure?"] = "Sbloccare e cambiare il piatto o i tagli può diventare davvero complicato, soprattutto se hai già effettuato i pagamenti. Sei sicuro?";
L["Unlock the session"] = "Sblocca la sessione";
L["No active GDKP session detected or session is not locked for payout!"] = "Nessuna sessione GDKP attiva rilevata o la sessione non è bloccata per il pagamento!";
L["Increment or minimum can't be lower than .0001!"] = "L'incremento o il minimo non possono essere inferiori a .0001!";
L["Invalid 'Increment' provided for item ID '%s'"] = "'Incremento' fornito non valido per l'ID articolo '%s'";
L["Invalid 'Minimum' provided for item ID '%s'"] = "Valore minimo fornito non valido per l'ID articolo '%s'";
L["Either minimum or increment is required for item ID: %s"] = "È richiesto un minimo o un incremento per l'ID articolo: %s";
L["Missing header, note: it's case-sensitive!"] = "Intestazione mancante, nota: fa distinzione tra maiuscole e minuscole!";
L["Successfully imported data for %s items"] = "Dati importati per %s elementi correttamente";
L["Unknown item ID: %s"] = "ID articolo sconosciuto: %s";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to this auction queue.\nItems in the queue will automatically be auctioned off once your current auction is done. Click the '%s' button to prevent this.\n\nWant Gargul to automatically award or disenchant auctions for you? Open the settings wheel on the left side!\n\n|c00FFF569Did you know?\nYou can move items around with drag and drop\nItems will be remembered, even when you |c00A79EFF/reload\nQueued items are automatically shown to raiders who have Gargul so they can prebid\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s oggetti nelle borse, nelle finestre del bottino o anche sui link nella tua chat per aggiungerli a questa coda dell'asta.
Gli articoli in coda verranno automaticamente messi all'asta una volta terminata l'asta corrente. Fare clic sul pulsante '%s' per impedirlo.

Vuoi che Gargul assegni o disincanti automaticamente le aste per te? Apri la rotella delle impostazioni sul lato sinistro!

|c00FFF569Lo sapevi?
Puoi spostare gli elementi trascinandoli
Gli elementi verranno ricordati, anche quando |c00A79EFF/ricarichi
Gli oggetti in coda vengono automaticamente mostrati ai predoni che hanno Gargul in modo che possano pre-offertare
Gargul può anche gestire il saccheggio automatico per te. Controllalo con |c00A79EFF/gl pm
]];
L["Hide unusable items"] = "Nascondi oggetti inutilizzabili";
L["GDKP Session"] = "Sessione del GDKP";
L["Editing %s"] = "Modifica %s";
L["Show upcoming items"] = "Mostra i prossimi articoli";
L["Stop the auction first!"] = "Prima ferma l'asta!";
L["%s owes you %s"] = "%s ti deve %s";
L["\n|c00967FD2GDKP Session\nSpent by player: %s\nGiven: %s\nReceived: %s\nPlayer cut: %s\n\n%s\n"] = [[
|c00967FD2GDKP Sessione
Speso dal giocatore: %s
Dati: %s
Ricevuto: %s
Taglio del giocatore: %s

%s
]];
L["Exclude from GDKP"] = "Escludi dal GDKP";
L["Gold traded will not be added to amount given or received"] = "L'oro scambiato non verrà aggiunto all'importo dato o ricevuto";
L["Gold |c00967FD2given to %s"] = "Oro |c00967FD2dato a %s";
L["Unable to add %s to the trade window. Try adding it manually!"] = "Impossibile aggiungere %s alla finestra di scambio. Prova ad aggiungerlo manualmente!";
L["You don't have enough money to pay %s"] = "Non hai abbastanza soldi per pagare %s";
L["To give: %s"] = "Per dare: %s";
L["To receive: %s"] = "Per ricevere: %s";
L["Gold |c00967FD2received from %s"] = "Oro |c00967FD2ricevuto da %s";
L["Check out Multi Auctions!"] = "Dai un'occhiata alle multi aste!";
L["Follow the steps below to quickly get started with Gargul GDKP!"] = "Segui i passaggi seguenti per iniziare rapidamente con Gargul GDKP!";
L["Activate this session by clicking the |c00FFF569Enable button below!"] = "Attiva questa sessione facendo clic sul pulsante |c00FFF569Abilita qui sotto!";
L["|c00FFF569%s an item to auction or queue a single item"] = "|c00FFF569%s un oggetto da mettere all'asta o mettere in coda un singolo oggetto"; -- %s holds the auction item hotkey (default ALT_CLICK)
L["\nHelpful commands:\n- |c00FFF569/gdkp to open this window\n- |c00FFF569/gl ma to open the multi-auction window\n- |c00FFF569/gl au to open the single item auctioneer / queue\n- |c00FFF569/gl pm to set up auto-looting\n\n"] = [[
Comandi utili:
- |c00FFF569/gdkp per aprire questa finestra
- |c00FFF569/gl ma per aprire la finestra multi-asta
- |c00FFF569/gl au per aprire il banditore/coda del singolo oggetto
- |c00FFF569/gl pm per impostare il saccheggio automatico

]];
L["If all went well then you will see your freshly auctioned item(s) here!"] = "Se tutto è andato bene, vedrai qui i tuoi oggetti appena messi all'asta!";
L["Want to auction multiple items at once? Run |c00FFF569/gl ma (or |c00FFF569/gl multiauction) or click the multi-auction icon in the top right of this window!"] = "Vuoi mettere all'asta più oggetti contemporaneamente? Esegui |c00FFF569/gl ma (o |c00FFF569/gl multiauction) o clicca sull'icona multi-asta in alto a destra in questa finestra!";
L["Click the |c00FFF569New button below to create your first GDKP session. It will show on the left when created"] = "Fai clic sul pulsante |c00FFF569Nuovo in basso per creare la tua prima sessione GDKP. Verrà visualizzato a sinistra una volta creato";
L["You're ready to sell items! |c00BE3333Read all the steps below carefully and test them all by yourself (no need to be in a raid) before starting your first GDKP raid!"] = "Sei pronto per vendere oggetti! |c00BE3333Leggi attentamente tutti i passaggi seguenti e testali tutti da solo (non è necessario partecipare a un raid) prima di iniziare il tuo primo raid GDKP!";
L["Want to sell an item without anyone bidding? |c00FFF569%s on an item, pick a winner and set a price!"] = "Vuoi vendere un oggetto senza che nessuno faccia offerte? |c00FFF569%s su un articolo, scegli un vincitore e stabilisci un prezzo!";
L["Getting started"] = "Iniziare";
L["Unknown itemID in Auction:create: %s"] = "ID oggetto sconosciuto nell'asta:crea: %s";
L["Unknown sessionIdentifier in Auction:create: %s"] = "Identificatore di sessione sconosciuto nell'asta:crea: %s";
L["You owe %s %s"] = "Sei in debito con %s %s";
L["Given"] = "Dato";
L["g"] = "G";
L["Group"] = "Gruppo";
L["Group Manager"] = "Gestore del gruppo";
L["Download on CurseForge"] = "Scarica su CurseForge";
L["https://addons.wago.io/addons/gargul/versions?stability=stable"] = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L["Halt"] = "Fermati";
L["Header"] = "Intestazione";
L["v%s. Type |c00967FD2/gl|r or |c00967FD2/gargul|r to get started!"] = "v%s. Digita |c00967FD2/gl|r o |c00967FD2/gargul|r per iniziare!";
L["Hide"] = "Nascondere";
L["%H:%M"] = "%H:%M";
L["Visit the URL below to learn more about personalizing Gargul GDKPs"] = "Visita l'URL riportato di seguito per ulteriori informazioni sulla personalizzazione dei GDKP Gargul";
L["Your logo here? Click for more info!"] = "Il tuo logo qui? Clicca per maggiori informazioni!";
L["Import"] = "Importare";
L["Imported on |c00A79EFF%s at |c00A79EFF%s, Updated on |c00A79EFF%s at |c00A79EFF%s"] = "Importato il |c00A79EFF%s a |c00A79EFF%s, Aggiornato il |c00A79EFF%s a |c00A79EFF%s";
L["What kind of data would you like to import?"] = "Che tipo di dati desideri importare?";
L["Import of boosted roll data successful"] = "Importazione dei dati di rollio potenziati riuscita";
L["Inc"] = "Inc";
L["Include previously awarded items"] = "Includi oggetti precedentemente assegnati";
L["Include BOEs"] = "Includi BOE";
L["Include materials (like Abyss Crystals)"] = "Includi materiali (come i cristalli dell'Abisso)";
L["Increment"] = "Incremento";
L["Info"] = "Informazioni";
L["Invalid data supplied"] = "Dati forniti non validi";
L["Item"] = "Articolo";
L["Unable to JSON decode data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Impossibile decodificare i dati JSON. Assicurati di copiarlo/incollarlo così com'è senza aggiungere caratteri o spazi bianchi aggiuntivi!";
L["\nGargul Item Hotkeys\n\nRoll out: |c00A79EFF%s|r\nAward: |c00A79EFF%s|r\nDisenchant: |c00A79EFF%s|r\n\n\n-- Right-click to disable this window --\n"] = [[
Tasti di scelta rapida degli oggetti Gargul

Lancio: |c00A79EFF%s
Premio: |c00A79EFF%s
Disincanta: |c00A79EFF%s


-- Fare clic con il tasto destro per disabilitare questa finestra --
]];
L["Ledger"] = "Registro";
L["<"] = "<";
L["You need to be the master looter or have an assist / lead role!"] = "Devi essere il maestro saccheggiatore o avere un ruolo di assistenza/protagonista!";
L["Note: you can change the locale at any time in the settings or via |c00%s/gl locale"] = "Nota: puoi modificare la localizzazione in qualsiasi momento nelle impostazioni o tramite |c00%s/gl locale";
L["deDE"] = "deDE"; -- German (Germany)
L["enUS"] = "enUS"; -- English (United States)
L["esES"] = "esES"; -- Spanish (Spain)
L["esMX"] = "esMX"; -- Spanish (Mexico)
L["frFR"] = "frFR"; -- French (France)
L["itIT"] = "itIT"; -- Italian (Italy)
L["koKR"] = "koKR"; -- Korean (Korea)
L["\nGargul posts chat messages in English (default)\nYou can select a different language in the dropdown below\n\nYour current chat language is '%s', enabling a different language will cause a /reload!\n"] = [[
Gargul pubblica messaggi di chat in inglese (impostazione predefinita)
Puoi selezionare una lingua diversa nel menu a discesa sottostante

La tua lingua di chat attuale è '%s', abilitare una lingua diversa causerà un /reload!
]];
L["Choose a chat language for Gargul"] = "Scegli una lingua di chat per Gargul";
L["ptBR"] = "ptBR"; -- Portuguese (Brazil)
L["ruRU"] = "ruRU"; -- Russian (Russia)
L["zhCN"] = "zhCN"; -- Chinese (Simplified, PRC)
L["zhTW"] = "zhTW"; -- Chinese (Traditional, Taiwan)
L["You have one or more addons installed that can potentially cause Gargul to misfunction: %s"] = "Hai uno o più componenti aggiuntivi installati che potrebbero potenzialmente causare il malfunzionamento di Gargul: %s";
L["Clear SoftRes"] = "Cancella SoftRes";
L["Clear TMB"] = "Cancella TMB";
L["/roll for MS or /roll 99 for OS"] = "/roll per MS o /roll 99 per sistema operativo";
L["Import SoftRes"] = "Importa SoftRes";
L["Import TMB"] = "Importa TMB";
L["You were given the role of Master Looter"] = "Ti è stato assegnato il ruolo di Master Looter";
L["Open this window automatically"] = "Apri questa finestra automaticamente";
L["Loot priorities cleared successfully"] = "Le priorità del bottino sono state cancellate con successo";
L["Provide a prio CSV in the following format (1 line per item): id or name > prio1, equalprio > prio2 > etc"] = "Fornire un CSV prio nel seguente formato (1 riga per articolo): id o nome > prio1, equalprio > prio2 > ecc.";
L["Loot priorities imported successfully"] = "Priorità del bottino importate con successo";
L["Invalid data provided"] = "Dati forniti non validi";
L["Invalid data provided in line: '%s': missing item id or priority"] = "Dati non validi forniti nella riga: '%s': ID elemento o priorità mancante";
L["Attempting to process incoming loot priorities from %s"] = "Tentativo di elaborare le priorità del bottino in arrivo da %s";
L["Loot Prio"] = "Saccheggio prioritario";
L["Mail"] = "Posta";
L["Mailed"] = "Spedito";
L["Mail cut to players"] = "Mail tagliata ai giocatori";
L["MS"] = "SM";
L["Maximize"] = "Massimizzare";
L["Min"] = "minimo";
L["Awarded loot history"] = "Premiato con la storia del bottino";
L["GDKP Cuts"] = "Tagli al Pil";
L["Export data"] = "Esporta dati";
L["Open Gargul"] = "Apri Gargul";
L["Import data"] = "Importa dati";
L["GDKP Ledger"] = "Registro GDKP";
L["Multiauction"] = "Multiasta";
L["Change settings in /gl minimap"] = "Modifica le impostazioni nella minimappa /gl";
L["Minimize"] = "Minimizzare";
L["Minimize on award"] = "Ridurre al minimo il premio";
L["Minimize on start"] = "Riduci a icona all'avvio";
L["Minimum"] = "Minimo";
L["Minimum item level"] = "Livello articolo minimo";
L["Minimum Quality"] = "Qualità minima";
L["-10"] = "-10";
L["-"] = "-";
L["Move"] = "Mossa";
L["Multi-Auction"] = "Asta multipla";
L["Name"] = "Nome";
L["New"] = "Nuovo";
L["Next"] = "Prossimo";
L["No"] = "NO";
L["None"] = "Nessuno";
L["Note"] = "Nota";
L["Nothing"] = "Niente";
L["When no one bids do:"] = "Quando nessuno fa offerte:";
L["You don't have officer privileges"] = "Non hai i privilegi di ufficiale";
L["OS"] = "sistema operativo";
L["Ok"] = "OK";
L["Open"] = "Aprire";
L["Open Auctioneer"] = "Banditore aperto";
L["Open Multi-Auction"] = "Asta multipla aperta";
L["DE"] = "DE";
L["GREED"] = "GREED";
L["IGNORE"] = "IGNORE";
L["NEED"] = "NEED";
L["PASS"] = "PASS";
L["RANDOM"] = "RANDOM";
L["RR"] = "RR";
L["SELF"] = "SELF";
L["Set %s as your disenchanter?"] = "Impostare %s come disincantatore?";
L["Send %s to %s? Type /gl cd to remove this disenchanter!"] = "Inviare %s a %s? Digita /gl cd per rimuovere questo disincantatore!";
L["No disenchanter set, use /gl sd [mydisenchanter] to set one"] = "Nessun set di disincantatore, usa /gl sd [mydisenchanter] per impostarne uno";
L["Who is your disenchanter?"] = "Chi è il tuo disincantatore?";
L["Paid"] = "Pagato";
L["Pass"] = "Passaggio";
L["%"] = "%";
L["Player"] = "Giocatore";
L["Items won by %s:"] = "Oggetti vinti da %s:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L["Plus Ones"] = "Quelli in più";
L["Add a +1"] = "Aggiungi un +1";
L["Are you sure you want to broadcast your plus one data to everyone in your party/raid?"] = "Sei sicuro di voler trasmettere i tuoi dati Plus One a tutti nel tuo party/raid?";
L["Attempting to process incoming PlusOnes data from %s"] = "Tentativo di elaborare i dati PlusOnes in arrivo da %s";
L["%s wants to clear all your PlusOne data. Clear all data?"] = "%s vuole cancellare tutti i tuoi dati PlusOne. Cancellare tutti i dati?";
L["Are you sure you want to clear your existing PlusOne data and import new data broadcasted by %s?"] = "Sei sicuro di voler cancellare i tuoi dati PlusOne esistenti e importare i nuovi dati trasmessi da %s?";
L["Are you sure you want to import new data broadcasted by %s?"] = "Sei sicuro di voler importare i nuovi dati trasmessi da %s?";
L["Invalid data provided. Make sure that the contents follows the required format and no header row is included"] = "Dati forniti non validi. Assicurati che i contenuti seguano il formato richiesto e che non sia inclusa alcuna riga di intestazione";
L["\nHere you can import plus one data from a table in CSV or TSV format or pasted from a Google Docs Sheet.\n\nThe table needs at least two columns: The player name followed by the amount of points. Additional columns are ignored.\n\nHere is an example line:\n\nFoobar,240\n"] = [[
Qui puoi importare più uno dati da una tabella in formato CSV o TSV o incollati da un foglio di Google Documenti.

La tabella necessita di almeno due colonne: il nome del giocatore seguito dalla quantità di punti. Le colonne aggiuntive vengono ignorate.

Ecco una riga di esempio:

Foobar,240
]];
L["Automatically accept incoming broadcasts from %s"] = "Accetta automaticamente le trasmissioni in arrivo da %s";
L["Block all incoming +1 shared data"] = "Blocca tutti i dati condivisi +1 in entrata";
L["\nAre you sure you want to update your existing PlusOne data with data from %s?\n\nYour latest update was on |c00A79EFF%s, theirs on |c00A79EFF%s."] = [[
Sei sicuro di voler aggiornare i tuoi dati PlusOne esistenti con i dati di %s?

Il tuo ultimo aggiornamento è stato su |c00A79EFF%s, il loro su |c00A79EFF%s.]];
L["!plusone|!po|!+1"] = "!plusone|!po|!+1";
L["+"] = "+";
L["Pot"] = "Pentola";
L["Price"] = "Prezzo";
L["PL"] = "PL";
L["Common"] = "Comune";
L["Epic"] = "Epico";
L["Heirloom"] = "Cimelio di famiglia";
L["Legendary"] = "Leggendario";
L["Poor"] = "Povero";
L["Rare"] = "Raro";
L["Uncommon"] = "Raro";
L["Queue"] = "Coda";
L["Raiders"] = "Predoni";
L["Who's Missing"] = "Chi manca";
L["Show missing player names"] = "Mostra i nomi dei giocatori mancanti";
L["Disband raid"] = "Sciogliere il raid";
L["Disband your raid"] = "Sciogli il tuo raid";
L["%s is listed twice on the roster!"] = "%s è elencato due volte nel roster!";
L["a |c00FFF569Raid-Helper export (Use the 'Groups sorted vertically' variant) or a |c00FFF569Gargul group composition CSV:"] = "un'esportazione |c00FFF569Raid-Helper (usa la variante 'Gruppi ordinati verticalmente') o un |c00FFF569CSV di composizione del gruppo Gargul:";
L["\nIn the large edit box below you can provide a roster and: invite everyone, check who's missing, apply groups and assign the tanks.\n\nYou can provide a |c00FFF569Wowhead raid composition link:"] = [[
Nella grande casella di modifica qui sotto puoi fornire un elenco e: invitare tutti, controllare chi manca, applicare gruppi e assegnare i carri armati.

Puoi fornire un link alla composizione del raid |c00FFF569Wowhead:]];
L["Gargul Group Wiki"] = "Wiki del gruppo Gargul";
L["Visit the Gargul group wiki for more info on the raid group format"] = "Visita la wiki del gruppo Gargul per maggiori informazioni sul formato del gruppo raid";
L["The following players are not part of the roster: %s"] = "I seguenti giocatori non fanno parte del roster: %s";
L["Invalid group data provided, check your format!"] = "Dati del gruppo forniti non validi, controlla il tuo formato!";
L["Invite"] = "Invitare";
L["Send invites to players on roster"] = "Invia inviti ai giocatori nel roster";
L["Can't sort groups while %s is in combat!"] = "Impossibile ordinare i gruppi mentre %s è in combattimento!"; -- %s holds a player name
L["You need to be in a raid!"] = "Devi partecipare a un raid!";
L["No tanks defined"] = "Nessun serbatoio definito";
L["Can't find a place for %s, are you trying to put more than 5 people in 1 group?"] = "Non riesci a trovare un posto per %s, stai cercando di inserire più di 5 persone in 1 gruppo?";
L["Kick unwanted players"] = "Calcia i giocatori indesiderati";
L["Kick players that aren't on the roster"] = "Espellere i giocatori che non sono nel roster";
L["Something went wrong while moving %s"] = "Qualcosa è andato storto durante lo spostamento di %s";
L["Finished applying raid roster"] = "Finita l'applicazione del roster del raid";
L["Sorting groups"] = "Gruppi di ordinamento";
L["Apply Groups"] = "Applica gruppi";
L["Sort groups based on roster"] = "Ordina i gruppi in base al roster";
L["Sorting is still in progress, wait a bit!"] = "L'ordinamento è ancora in corso, aspetta un po'!";
L["All tanks are assigned"] = "Tutti i carri armati sono assegnati";
L["Assign Tanks"] = "Assegna carri armati";
L["Wowhead Comp Tool"] = "Strumento di composizione Wowhead";
L["You can visit the wowhead comp tool using the URL down below. After creating your comp you can paste it here or in the large edit field of the Gargul group window"] = "Puoi visitare lo strumento Wowhead Comp utilizzando l'URL in basso. Dopo aver creato la tua composizione puoi incollarla qui o nel grande campo di modifica della finestra del gruppo Gargul";
L["Remove bid"] = "Rimuovi l'offerta";
L["Reset Settings"] = "Ripristina le impostazioni";
L["Are you sure you want to reset all of Gargul's settings? This can't be undone!"] = "Sei sicuro di voler ripristinare tutte le impostazioni di Gargul? Questa operazione non può essere annullata!";
L["Reset Gargul UI"] = "Ripristina l'interfaccia utente di Gargul";
L["Are you sure you want to reset all of Gargul's window sizes, positions and scale? This can't be undone!"] = "Sei sicuro di voler reimpostare tutte le dimensioni, le posizioni e la scala delle finestre di Gargul? Questa operazione non può essere annullata!";
L["Restore"] = "Ristabilire";
L["Resume"] = "Riprendere";
L[">"] = ">";
L["Roll"] = "Rotolo";
L["Award %s to %s?"] = "Premio da %s a %s?";
L["Close on award"] = "Vicino al premio";
L["Close on start"] = "Chiudi all'avvio";
L["Hold shift to bypass the award confirmation"] = "Tieni premuto il turno per ignorare la conferma del premio";
L["Hold shift to show the award confirmation"] = "Tieni premuto il turno per mostrare la conferma del premio";
L["Warning: another identical roll was found which can point to a tie"] = [[
Attenzione: è stato trovato un altro risultato identico che può far pensare ad un pareggio

]];
L["Invalid data provided for roll start!"] = "Dati forniti per il rullo di partenza non validi!";
L["(BR: %s)"] = "(BR: %s)";
L["(item given: yes)"] = "(voce data: sì)";
L["(item given: no)"] = "(voce data: no)";
L["(OS)"] = "(sistema operativo)";
L["NOTE"] = "NOTA";
L["Can't stop roll off, no roll off in progress"] = "Impossibile fermare il roll-off, nessun roll-off in corso";
L["Pass"] = "Passaggio";
L["rolls: %s"] = "rotoli: %s";
L["Open master looter window"] = "Apri la finestra principale del saccheggiatore";
L["Roll accepted!"] = "Rotolo accettato!";
L["A roll is currently in progress"] = "Attualmente è in corso un appello";
L["Prio [%s]"] = "Prezzo [%s]";
L["SR [%sx]"] = "RS [%sx]";
L["Wish [%s]"] = "Desiderio [%s]";
L["You need to select a player first"] = "Devi prima selezionare un giocatore";
L["TIMER (s)"] = "TIMER (i)";
L["You can't use this item!"] = "Non puoi usare questo oggetto!";
L["The winner's name is not unique, select the player you'd like to award %s to"] = "Il nome del vincitore non è univoco, seleziona il giocatore a cui desideri assegnare %s";
L["s"] = "S";
L["Select / Disable all"] = "Seleziona / Disabilita tutto";
L["Session"] = "Sessione";
L["Settings"] = "Impostazioni";
L["Announce incoming bids"] = "Annunciare le offerte in arrivo";
L["Announce pot after awarding item"] = "Annuncia il piatto dopo aver assegnato l'oggetto";
L["Announce auction start"] = "Annuncio dell'inizio dell'asta";
L["Announce countdown in raid warning"] = "Annuncia il conto alla rovescia nell'avviso di raid";
L["Announce incoming bids in raid warning"] = "Annuncia le offerte in arrivo nell'avviso di raid";
L["Reset Gargul UI"] = "Ripristina l'interfaccia utente di Gargul";
L["Whisper bidder if bid is too low"] = "Sussurra all'offerente se l'offerta è troppo bassa";
L["s"] = "S";
L["Skip"] = "Saltare";
L["Soft-Reserves"] = "Riserve Soft";
L["SR"] = "SR";
L["Are you sure you want to broadcast your softres data to everyone in your party/raid?"] = "Sei sicuro di voler trasmettere i tuoi dati softres a tutti i membri del tuo gruppo/raid?";
L["Couldn't process SoftRes data received from %s"] = "Impossibile elaborare i dati SoftRes ricevuti da %s";
L["Are you sure you want to clear all existing soft-reserve data?"] = "Sei sicuro di voler cancellare tutti i dati soft-reserve esistenti?";
L["Everyone filled out their soft-reserves"] = "Tutti hanno riempito le loro riserve morbide";
L["\nHard-reserve information is not available because the soft-reserves\nprovided were not generated using the 'Gargul Export' button on softres.it"] = [[
Le informazioni sulla riserva fisica non sono disponibili perché le riserve soft
forniti non sono stati generati utilizzando il pulsante 'Gargul Export' su softres.it]];
L["Imported on |c00A79EFF%s at |c00A79EFF%s"] = "Importato il |c00A79EFF%s a |c00A79EFF%s";
L["Auto name fix: the SR of '%s' is now linked to '%s'"] = "Correzione automatica del nome: la SR di '%s' è ora collegata a '%s'";
L["In order to get started you first need to create a raid on softres.it. Afterwards click on 'Addon Export', select 'Gargul', copy the data and paste it in the form below."] = "Per iniziare devi prima creare un raid su softres.it. Successivamente clicca su 'Addon Export', seleziona 'Gargul', copia i dati e incollali nel modulo sottostante.";
L["Invalid soft-reserve data provided"] = "Dati soft-reserve forniti non validi";
L["Invalid data provided. Make sure to click the 'Gargul Export' button on softres.it and paste the full contents here"] = "Dati forniti non validi. Assicurati di fare clic sul pulsante 'Gargul Export' su softres.it e incollare qui l'intero contenuto";
L["The PlusOne values provided collide with the ones already present. Do you want to replace your old PlusOne values?"] = "I valori PlusOne forniti collidono con quelli già presenti. Vuoi sostituire i tuoi vecchi valori PlusOne?";
L["The following players did not reserve anything:"] = "I seguenti giocatori non hanno prenotato nulla:";
L["Soft-reserves imported successfully"] = "Riserve software importate correttamente";
L["Import successful!"] = "Importazione riuscita!";
L["SoftRes Weakaura and CSV data are deprecated, use the Gargul export instead!"] = "I dati SoftRes Weakaura e CSV sono deprecati, utilizza invece l'esportazione Gargul!";
L["Failed to connect to LootReserve, contact support (include message below)"] = "Impossibile connettersi a LootReserve, contatta l'assistenza (includi il messaggio di seguito)";
L["%s (%sx)"] = "%s (%sx)";
L["No softres.it URL available, make sure you exported using the 'Gargul Export' button on softres.it!"] = "Nessun URL softres.it disponibile, assicurati di aver esportato utilizzando il pulsante 'Gargul Export' su softres.it!";
L["Click here to see hard-reserve info"] = "Clicca qui per vedere le informazioni sulla prenotazione definitiva";
L["No items are hard-reserved"] = "Nessun articolo è prenotato in modo definitivo";
L["No hard-reserve info available"] = "Nessuna informazione disponibile sulla riserva fisica";
L["Post missing SRs"] = "Pubblica SR mancanti";
L["Post SR URL"] = "Pubblica l'URL della SR";
L["This player did not reserve anything!"] = "Questo giocatore non ha prenotato nulla!";
L["%s (%sx)"] = "%s (%sx)";
L["Attempting to process incoming SoftRes data from %s"] = "Tentativo di elaborare i dati SoftRes in arrivo da %s";
L["This item is hard-reserved"] = "Questo articolo è riservato in modo permanente";
L["For: %s"] = "Per: %s";
L["|c00CC2743 Note: %s"] = "|c00CC2743 Nota: %s";
L["Reserved by"] = "Riservato da";
L["!sr|!softres|!softreserve"] = "!sr|!softres|!softreserve";
L["Something went wrong!"] = "Qualcosa è andato storto!";
L["Start"] = "Inizio";
L["Stop"] = "Fermare";
L["\\t is replaced by a tab"] = "\\t is replaced by a tab";
L["TMB"] = "TMB";
L["Time"] = "Tempo";
L["Title"] = "Titolo";
L["TMB, DFT or PRIO3"] = "TMB, DFT o PRIO3";
L["Are you sure you want to broadcast your TMB data to everyone in your party/raid? NB: EVERYONE can see your TMB data regardless of their permissions on the TMB website!"] = "Sei sicuro di voler trasmettere i tuoi dati TMB a tutti i membri del tuo gruppo/raid? NB: TUTTI possono vedere i tuoi dati TMB indipendentemente dai loro permessi sul sito TMB!";
L["Attempting to process incoming TMB data from %s"] = "Tentativo di elaborare i dati TMB in entrata da %s";
L["Are you sure you want to clear all plus one data?"] = "Sei sicuro di voler cancellare tutti i dati più uno?";
L["Clear Raider Data"] = "Cancella i dati del raider";
L["Clear TMB data for all raiders?"] = "Cancellare i dati TMB per tutti i predoni?";
L["Auto-sharing enabled: %s"] = "Condivisione automatica abilitata: %s";
L["On your classicpr.io run click on the 'Gargul Export' button and copy the contents. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Nella tua esecuzione classicpr.io, fai clic sul pulsante 'Gargul Export' e copia il contenuto. Successivamente incolla il contenuto così com'è nella casella sottostante e fai clic su 'Importa'. Questo è tutto!";
L["Imported on ${date} at ${time}"] = "Importato il ${date} alle ${time}";
L["Export your DFT data as per the sheet's instructions. Afterwards paste the contents as-is in the box below and click 'Import'. That's it!"] = "Esporta i tuoi dati DFT secondo le istruzioni del foglio. Successivamente incolla il contenuto così com'è nella casella sottostante e fai clic su 'Importa'. Questo è tutto!";
L["Invalid CSV provided, the format is: 6948,player1,player2"] = "CSV fornito non valido, il formato è: 6948,giocatore1,giocatore2";
L["Invalid DFT data provided, Export your DFT data as per the sheet's instructions and paste the contents here as-is!"] = "Dati DFT forniti non validi. Esporta i tuoi dati DFT secondo le istruzioni del foglio e incolla qui i contenuti così come sono!";
L["Invalid TMB data provided, make sure to click the 'Download' button in the Gargul section and paste the contents here as-is!"] = "Dati TMB forniti non validi, assicurati di fare clic sul pulsante 'Download' nella sezione Gargul e incollare i contenuti qui così come sono!";
L["Invalid TMB or DFT data provided, make sure to paste the export contents here as-is!"] = "Dati TMB o DFT forniti non validi, assicurati di incollare qui i contenuti dell'esportazione così come sono!";
L["Priority notes available: %s"] = "Note prioritarie disponibili: %s";
L["Number of items imported: %s"] = "Numero di elementi importati: %s";
L["The following players have no %s entries:"] = "I seguenti giocatori non hanno voci %s:"; -- %s can be TMB/DFT/CPR
L["How to use Gargul with ${source}"] = "Come usare Gargul con ${source}";
L["https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS"] = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L["Paste your TMB export contents as-is in the box below and click 'Import'"] = "Incolla il contenuto dell'esportazione TMB così com'è nella casella sottostante e fai clic su 'Importa'";
L["There's no one in your group to broadcast to"] = "Non c'è nessuno nel tuo gruppo a cui trasmettere";
L["TMB data synced"] = "Dati TMB sincronizzati";
L["|c00FFFFFF    Note: |c00FFF569%s"] = "|c00FFFFFF Nota: |c00FFF569%s";
L["(OS)"] = "(sistema operativo)";
L["%s Prio List"] = "%s Elenco priorità"; -- %s can be TMB/DFT/CPR
L["|c00FFFFFF    Tier: %s"] = "|c00FFFFFF Livello: %s";
L["TMB Wish List"] = "Lista dei desideri TMB";
L["Show/Hide Dates"] = "Mostra/Nascondi date";
L["Show/Hide Queue"] = "Mostra/Nascondi coda";
L["%s to award loot!"] = "%s per assegnare il bottino!";
L["%s to roll out loot!"] = "%s per distribuire il bottino!";
L["Hide all awarded items"] = "Nascondi tutti gli oggetti premiati";
L["Hide disenchanted items"] = "Nascondi gli oggetti disincantati";
L["Hide items awarded to self"] = "Nascondi gli oggetti assegnati a te stesso";
L["Announce Trade"] = "Annunciare il commercio";
L["Announce trade details to group or in /say when not in a group"] = "Annuncia i dettagli commerciali al gruppo o in /say quando non sei in un gruppo";
L["Tutorial"] = "Esercitazione";
L["\n|c00A79EFF%s items in bags, loot windows or even on links in your chat to add them to the auction queue.\nWant to directly sell an item without bidding? Use |c00A79EFF%s\n\nYou can open the %s window directly by typing |c00A79EFF/gl auction\n\nGargul tracks |c00FF0000ALL gold traded. Don't want a trade to be a part of this GDKP session? Check the \"Exclude from GDKP\" checkbox when trading!\n\n|c00FFF569Did you know?\nAwarded items will automatically be added to the trade window\nGargul can also handle auto looting for you. Check it out with |c00A79EFF/gl pm\n"] = [[
|c00A79EFF%s oggetti nelle borse, nelle finestre di bottino o anche sui link nella tua chat per aggiungerli alla coda dell'asta.
Vuoi vendere direttamente un articolo senza fare offerte? Utilizzare |c00A79EFF%s

Puoi aprire direttamente la finestra %s digitando |c00A79EFF/glauction

Tracce di Gargul |c00FF0000TUTTO oro scambiato. Non vuoi che un'operazione faccia parte di questa sessione GDKP? Seleziona la casella di controllo 'Escludi da GDKP' durante il trading!

|c00FFF569Lo sapevi?
Gli oggetti premiati verranno automaticamente aggiunti alla finestra dello scambio
Gargul può anche gestire il saccheggio automatico per te. Controllalo con |c00A79EFF/gl pm
]];
L["\nThis window shows all the items that have been awarded on any given date (select one or more dates on the left).\n\nItems can contain the following tags:\n\n|c00A79EFFOS: Awarded for offspec\n|c00A79EFFSR: This item was soft-reserved\n|c00A79EFFWL: This item was wishlisted (Thatsmybis)\n|c00A79EFFPL: This item was priolisted (Thatsmybis, DFT, prio3)\n"] = [[
In questa finestra vengono visualizzati tutti gli oggetti assegnati in una determinata data (seleziona una o più date a sinistra).

Gli elementi possono contenere i seguenti tag:

|c00A79EFFOS: Assegnato per fuorispec
|c00A79EFFSR: questo articolo è stato prenotato temporaneamente
|c00A79EFFWL: Questo articolo è stato inserito nella lista dei desideri (Thatsmybis)
|c00A79EFFPL: Questo articolo è stato inserito nella lista prioritaria (Thatsmybis, DFT, prio3)
]];
L["\nThe items you see here are in the master looter's GDKP queue\nYou can remove them, bid on them, and hide unusable items (enable 'Hide unusable items' in the settings in the top-left)\n\nYou can resize the window, move it around, or minimize it. Try it out!\n\nFor loot masters: removing items here will only remove them from your personal queue, not the actual GDKP queue!\n"] = [[
Gli oggetti che vedi qui sono nella coda GDKP del saccheggiatore principale
Puoi rimuoverli, fare offerte e nascondere oggetti inutilizzabili (abilita 'Nascondi oggetti inutilizzabili' nelle impostazioni in alto a sinistra)

Puoi ridimensionare la finestra, spostarla o ridurla a icona. Provalo!

Per i loot master: rimuovere gli oggetti qui li rimuoverà solo dalla tua coda personale, non dalla coda GDKP effettiva!
]];
L["Need more help?"] = "Serve ancora aiuto?";
L["Type"] = "Tipo"; -- As in type of roll or type of item
L["unknown"] = "sconosciuto";
L["Unknown comm action '%s', make sure to update Gargul!"] = "Azione di comunicazione sconosciuta '%s', assicurati di aggiornare Gargul!";
L["Unlock"] = "Sbloccare";
L["Update Gargul!"] = "Aggiorna Gargul!";
L["v"] = "v";
L["Report"] = "Rapporto";
L["Report outdated results in group chat"] = "Segnala risultati obsoleti nella chat di gruppo";
L["Gargul status"] = "Stato di Gargul";
L["Checking version ..."] = "Controllo della versione...";
L["\n|c0092FF00v%s: the player is up-to-date\n|c00F7922Ev%s: the player needs to update his add-ons\n|c00BE3333%s: the player doesn't have Gargul or is on an unsupported version\n|c00808080%s: the player is offline or is ignoring us!\n|c0000FFFF%s: the player is on our ignore list!\n\n"] = [[
|c0092FF00v%s: il player è aggiornato
|c00F7922Ev%s: il giocatore deve aggiornare i suoi componenti aggiuntivi
|c00BE3333%s: il giocatore non ha Gargul o utilizza una versione non supportata
|c00808080%s: il giocatore è offline o ci sta ignorando!
|c0000FFFF%s: il giocatore è nella nostra lista da ignorare!

]];
L["PLAYER IGNORED!"] = "GIOCATORE IGNORATO!";
L["Offline"] = "disconnesso";
L["No response"] = "Nessuna risposta";
L["No response:"] = "Nessuna risposta:";
L["Offline:"] = "Disconnesso:";
L["Outdated:"] = "obsoleto:";
L["Up-to-date:"] = "Aggiornato:";
L["Gargul is out of date and won't work until you update!"] = "Gargul non è aggiornato e non funzionerà finché non lo aggiorni!";
L["Invalid version string provided in Version:addRelease"] = "Stringa di versione non valida fornita in Version:addRelease";
L["Update Gargul!"] = "Aggiorna Gargul!";
L["|c00%sGargul is now updated to |c00%sv%s"] = "|c00%sGargul è ora aggiornato a |c00%sv%s";
L["|c00A79EFFv%s is available on CurseForge/Wago. You can update without closing your game, just be sure to /reload !"] = "|c00A79EFFv%s è disponibile su CurseForge/Wago. Puoi aggiornare senza chiudere il gioco, assicurati solo di /reload!";
L["Wait %s more seconds before you retry"] = "Attendi altri %s secondi prima di riprovare";
L["Window"] = "Finestra";
L["Gargul v%s"] = "Gargul v%s";
L["Window Scale"] = "Scala della finestra";
L["WL"] = "WL";
L["Yes"] = "SÌ";
L["You disabled GDKP queues"] = "Hai disabilitato le code GDKP";
L["0"] = "0";
L["Unable to zlib compress the data. Contact support via https://discord.gg/D3mDhYPVzf"] = "Impossibile comprimere i dati con zlib. Contatta l'assistenza tramite https://discord.gg/D3mDhYPVzf";
L["Unable to zlib decompress the data. Make sure you copy/paste it as-is without adding any additional characters or whitespaces!"] = "Impossibile decomprimere i dati con zlib. Assicurati di copiarlo/incollarlo così com'è senza aggiungere caratteri o spazi bianchi aggiuntivi!";
