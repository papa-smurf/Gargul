--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (true or GetLocale() ~= "itIT") then return; end
local L = Gargul_L or {};

L.ABOUT = "Di";
L.ALL_SETTINGS = "Tutte le impostazioni";
L.ANNOUNCE = "Annunciare";
L.ANTISNIPE = "Anti-beccaccino";
L.ANTISNIPE_EXPLANATION = [[

Un valore Anti Snipe pari a 10 significa che qualsiasi offerta che arriva
meno di 10 secondi rimasti ripristineranno il timer su 10 secondi

Puoi lasciarlo vuoto o impostarlo su 0 per disabilitare completamente Anti Snipe.
I valori Anti Snipe inferiori a 5 non sono supportati

]];
L.ARE_YOU_SURE = "Sei sicuro?";
L.ASSIGN_GARGUL_INFO = [[
Non dimenticare di usare invece Gargul
se desideri esportare il bottino in un secondo momento


-- Fare clic con il tasto destro per disabilitare questa finestra --]];
L.AUCTION = "Asta";
L.AUCTIONEER = "Banditore";
L.AUCTIONS = "Aste";
L.AUTO = "Auto";
L.AUTO_AWARD = "Premio automatico";
L.AUTO_TRADE_OPTIONS = "Commercio automobilistico";
L.AVAILABLE_PLACEHOLDER_VALUES = "Valori disponibili:";
L.AWARD = "Premio";
L.AWARDED_TO = "Assegnato a";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "BR: %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Prezzi";
L.AWARDED_TOOLTIP_GIVEN = "Dato: sì";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Dato: no";
L.AWARDED_TOOLTIP_SECOND_BID = "2a offerta: %s per %s";
L.AWARDED_YOU_WON = "Hai vinto";
L.AWARD_CONFIRM = "Premio da %s a %s?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "Sei sicuro di voler disincantare %s? %s punti di lancio potenziati verranno rimborsati!";
L.AWARD_HEADER_IN_GROUP = "In gruppo";
L.AWARD_HISTORY = "Storia del premio";
L.AWARD_NEW_WINNER_CONFIRMATION = "Da chi dovrebbe andare invece %s?";
L.AWARD_PLAYER_CUSTOM_NAME = "Digita qui il nome del giocatore";
L.AWARD_PLAYER_SELECT_NAME = "oppure selezionane uno qui sotto";
L.AWARD_RANDOM_CONFIRM = "Vuoi assegnare %s a un giocatore casuale?";
L.AWARD_TOOLTIP_ADD_ITEM = "Trascina e rilascia oppure fai clic+maiusc su un elemento nella casella a destra";
L.AWARD_TOOLTIP_BR_INDICATION = "(BR: %s)";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Oggetti disincantati:";
L.AWARD_TOOLTIP_GIVEN = "(Dato: sì)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(Dato: no)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(sistema operativo)";
L.AWARD_UNDO_BR_REFUND = "%s punti di lancio potenziati verranno rimborsati!";
L.AWARD_UNDO_CONFIRM = "Sei sicuro di voler annullare %s assegnato a %s?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "Ispezione del bagaglio fallita: nessuna segnalazione ricevuta";
L.BAGINSPECTOR_FINISHED = "Ispezione terminata";
L.BAGINSPECTOR_START = "Inizio ispezione...";
L.BALANCE = "Bilancia";
L.BASE = "Base";
L.BASE64_DECODE_WARNING = "Impossibile decodificare i dati in base64. Assicurati di copiarlo/incollarlo così com'è senza aggiungere caratteri o spazi bianchi aggiuntivi!";
L.BID = "Offerta";
L.BIDS = "Offerte";
L.BIND_ON_EQUIP_ABBR = "BOE";
L.BONUS_AUTO_INVITE = "1. Invita/ordina automaticamente i gruppi dall'iscrizione al raid! Clicca qui sotto o usa |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. Premia i giocatori che diventano clienti abituali o che fanno il possibile! Clicca qui sotto o usa |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "Gargul ha alcuni assi nella manica di cui potresti non essere a conoscenza. Fatti un'occhiata!";
L.BONUS_PLUSONES = "3. Gargul include un sistema di tracciamento Plus One! Fare clic qui sotto o utilizzare |c00A79EFF/gl po";
L.BOOSTED_ROLLS = "Tiri potenziati";
L.BOOSTED_ROLLS_ABBR = "BR";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
Aggiungi quanti punti per tutti coloro che sono attualmente nel raid?

|c00BE3333Utilizza prima il pulsante 'Aggiungi predoni mancanti' se vuoi che tutti ottengano punti, anche quelli senza una voce potenziata!]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "Nessun valore in punti fornito!";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Aggiungi punti al raid";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Aggiungi i predoni mancanti";
L.BOOSTED_ROLLS_ALIASES = "Alias";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Applicare alias";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Costo del tiro potenziato:";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "Sei sicuro di voler trasmettere i tuoi dati di rollio potenziati a tutti i membri del tuo party/raid?";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "Niente da trasmettere, importa prima i dati dei Rulli potenziati!";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "Impossibile elaborare i dati BoostedRolls ricevuti da %s";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Tentativo di elaborare i dati BoostedRolls in arrivo da %s";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "Sei sicuro di voler cancellare tutti i dati di rollio potenziati?";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "Eliminare %s?";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "Sei sicuro di voler cancellare i dati di rollio potenziati esistenti e importare i nuovi dati trasmessi da %s?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Dati forniti non validi. Assicurati che i contenuti seguano il formato richiesto e che non sia inclusa alcuna riga di intestazione";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
Qui puoi importare dati e alias dei ruoli potenziati da una tabella in formato CSV o TSV o incollati da un foglio di documenti Google.

La tabella necessita di almeno due colonne: il nome del giocatore seguito dalla quantità di punti. Le colonne aggiuntive sono facoltative e possono contenere alias per il giocatore.
Ecco una riga di esempio:

Foobar,240,Barfoo]];
L.BOOSTED_ROLLS_POINTS = "Punti";
L.BOOSTED_ROLLS_RESERVE = "Riserva";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
Sei sicuro di voler aggiornare i tuoi elenchi potenziati esistenti con i dati di %s?

Il tuo ultimo aggiornamento è stato su |c00A79EFF%s, il loro su |c00A79EFF%s.]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!bonus|!rb|!br";
L.BROADCAST = "Trasmissione";
L.BROADCASTING_NOTIFICATION = "Trasmissione...";
L.BROADCAST_DELAYED_BY_COMBAT = "Attualmente sei in combattimento, stai ritardando la trasmissione";
L.BROADCAST_FINISHED = "Trasmissione terminata!";
L.BROADCAST_INC_AWARDED = "Includi oggetti premiati";
L.BROADCAST_INC_DISENCHANTED = "Includi oggetti disincantati";
L.BROADCAST_INC_HIDDEN = "Includi oggetti nascosti";
L.BROADCAST_INC_TIME_LEFT = "Includi il tempo rimasto";
L.BROADCAST_IN_PROGRESS_ERROR = "Trasmissione ancora in corso";
L.BROADCAST_NO_DATA = "Non c'è niente da trasmettere";
L.BROADCAST_NUMBER_OF_ITEMS = "Numero di articoli";
L.BROADCAST_TARGET_PLAYER = "Giocatore bersaglio (solo sussurro)";
L.BROADCAST_TARGET_REQUIRED = "Whisper richiede un giocatore bersaglio";
L.BROADCAST_TRADE_TIME_LEFT = "Tempo massimo di scambio rimasto (in minuti)";
L.BY = "di"; -- As in 'bid BY'
L.CANCEL = "Annulla";
L.CHANGELOG_CONTRIBUTE = "Ottieni supporto o condividi idee sul nostro Discord";
L.CHANGELOG_ENABLE_LABEL = "Abilita il registro delle modifiche";
L.CHANGELOG_GETTING_STARTED = "Gargul rende semplicissimo distribuire il bottino, fai clic sul pulsante in basso per iniziare!";
L.CHANGELOG_OPEN_GARGUL = "Apri Gargul";
L.CHANGE_SCALE = "Regola scala";
L.CHANNEL = "Canale";
L.CHANNEL_OFFICER = "Ufficiale";
L.CHANNEL_RAID_WARNING = "Avviso raid";
L.CHANNEL_WHISPER = "Sussurro";
L.CLASSICPRIO_ABBR = "RCP";
L.CLEAR = "Chiaro"; -- As in clearing a window or data
L.CLOSE = "Vicino";
L.CLOSE_ON_AWARD = "Vicino al premio";
L.CLOSE_ON_START = "Chiudi all'avvio";
L.COMMUNICATION = "Comunicazione";
L.COMM_PROGRESS = "Inviati %s di %s byte";
L.COPPER_INDICATOR = "C";
L.CUT = "Taglio";
L.CUTS = "Tagli";
L.CUT_MAILBOX_CLOSED = "Impossibile inviare posta quando la casella di posta è chiusa";
L.CUT_MAILS_FAILED = "Rilevati più errori di posta, interruzione della distribuzione tagliata";
L.CUT_MAIL_BODY = "Realizzato da Gargul: uno strumento di bottino eccezionale con supporto per TMB, SoftRes, GDKP e auto-looting!";
L.CUT_MAIL_EVEN = "Non devi oro a %s";
L.CUT_MAIL_FAILED = "Impossibile inviare il taglio a %s";
L.CUT_MAIL_GOLD_MISMATCH = "Mail INVIATA in base al gioco, ma i tuoi ORO rimanenti NON CORRISPONDONO, qualcosa è andato storto?";
L.CUT_MAIL_HISTORY = "Cronologia posta per |c00967FD2%s";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "Non hai abbastanza oro per pagare %s";
L.CUT_MAIL_IN_PROGRESS = "Aspetta un attimo, stiamo ancora elaborando la posta precedente";
L.CUT_MAIL_SUBJECT = "Gargul GDKP: %sg";
L.CUT_SENT = "Inviato %sg a %s";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "Eliminare";
L.DETAILS = "Dettagli";
L.DFT = "DFT";
L.DISABLE = "disattivare";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "Disincantare";
L.EDIT = "Modificare";
L.ENABLE = "Abilitare";
L.EXPORT = "Esportare";
L.EXPORT_DELETE_ALL_CONFIRM = "Sei sicuro di voler rimuovere la tabella completa della cronologia dei premi? Questa operazione elimina TUTTI i dati del bottino e non può essere annullata!";
L.EXPORT_DELETE_DATE_CONFIRM = "Sei sicuro di voler rimuovere tutti i dati per %s? Questa operazione non può essere annullata!";
L.EXPORT_READ_ONLY_NOTICE = [[
Questa è SOLO una funzione di esportazione, non ha senso modificare nessuno dei valori: NON VERRANNO SALVATI!

]];
L.FILL = "Riempire";
L.FINAL_CALL = "Chiamata finale";
L.FINISH = "Fine";
L.FORMAT = "Formato";
L.GARGUL = "Gargul";
L.GDKP = "GDKP";
L.GDKPS_ARE_NOT_ALLOWED = "I raid GDKP non sono consentiti in questa versione di World of Warcraft";
L.GDKP_ACTIVATED = "GDKP attivo!";
L.GDKP_ADD_DROPS_TO_QUEUE = "Aggiungi il bottino lasciato alla coda";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "Oro (- per rimuovere l'oro)";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "Chi paga per questo?";
L.GDKP_ADD_GOLD_INVALID_WARNING = "L'oro deve essere inferiore/superiore a 0";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "Pagato da";
L.GDKP_ADD_GOLD_TITLE = "Modifica l'oro in %s";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "Non puoi dare E ricevere oro dallo stesso giocatore allo stesso tempo";
L.GDKP_ALL_CUTS_MAILED = "Tutti i tagli sono stati spediti per posta!";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "Disabilita per disincantato";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "Disabilita in combattimento";
L.GDKP_AUCTIONS = "Aste";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "Creato da";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333Eliminato da %s
Motivi]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%sg aggiunto al piatto da %s
Appunti]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s pagato |c00%s%sg per
%S]];
L.GDKP_AUCTION_DETAILS_WON_BY = "Vinto da";
L.GDKP_AUCTION_PAID_AMOUNT = "Imposta l'importo pagato (leggi a sinistra)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul tiene traccia automaticamente dell'oro scambiato. Purché i giocatori paghino
per quello che hanno comprato allora non dovresti mai aver bisogno di questo campo

L''importo pagato' si riferisce alla quantità di oro che l'acquirente ti ha già scambiato.
Ciò non modifica il prezzo effettivo dell'articolo!

Attenzione: imposta qui un valore solo se il giocatore promette di pagare
al di fuori del raid o scambia l'oro da un alt/mail ecc!


]];
L.GDKP_AWARD_DIALOG_LABEL = "Prezzo PIL:";
L.GDKP_AWARD_ITEM_CONFIRMATION = "Premio da %s a %s per %s?";
L.GDKP_BIDDER_AUTO_BID = "Offerta automatica";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "Qual è la tua offerta massima? (Minimo %s|c00FFF569g)";
L.GDKP_BIDDER_BID_DENIED = "Offerta rifiutata!";
L.GDKP_BIDDER_ITEM_PRICING = "Offerta minima: %sg Incremento: %sg";
L.GDKP_BIDDER_MY_MAX_BID = "(massimo %sg)";
L.GDKP_BIDDER_NEW_BID_LABEL = "Nuova offerta";
L.GDKP_BIDDER_STOP_AUTO_BID = "Interrompi l'offerta automatica";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "Offerta migliore: %s per %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "Offerta migliore: %s da parte tua";
L.GDKP_CREATE = "Crea una nuova sessione GDKP";
L.GDKP_CREATE_MANAGEMENT_CUT = "Taglio gestionale%";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Il taglio di gestione deve essere vuoto o compreso tra 0 e 99 (nessun segno %!)";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "Scegli un tipo di sessione!";
L.GDKP_CREATE_SESSION_SWITCH = "Passa a questa sessione";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFLa multi-asta ti consente di fare offerte su più oggetti contemporaneamente, velocizzando il tutto!
Segui le istruzioni dopo aver creato questa sessione per iniziare

Con |c00A79EFFSingle-Auction scegli invece di mettere all'asta singoli oggetti o di utilizzare la coda

Selezionando |c00A79EFFMulti-Auction si evita che gli oggetti scartati vengano aggiunti alla coda
È possibile combinare |c00A79EFFMulti-Auction con |c00A79EFFSingle-Auction e la coda ma lo sconsigliamo vivamente

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "Tipo di asta (|c00A79EFFi per maggiori informazioni)";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "Asta multipla";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "Asta singola";
L.GDKP_CREATE_SUCCESSFUL = "Sessione creata. Ti consigliamo di /reload in modo che venga archiviato correttamente nel caso in cui il gioco si blocchi!";
L.GDKP_CUTS_ADD_RAIDER = "Aggiungi Raider";
L.GDKP_CUTS_ADJUST_G = "regolare [g]";
L.GDKP_CUTS_ADJUST_P = "regolare [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "Annuncia il taglio base nella chat di gruppo";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "Sei sicuro di voler reimpostare tutti i giocatori e i calcoli? Nota: tutti i giocatori non più presenti nel raid verranno rimossi dalla lista!";
L.GDKP_CUTS_DELETE_RAIDER = "Elimina Raider";
L.GDKP_CUTS_EDIT_RAIDER = "Modifica Raider";
L.GDKP_CUTS_LOCK_TOOLTIP = "Blocca e paga";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "Gestisci le transazioni in oro";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

Con i mutatori puoi dare più o meno oro ai giocatori
Esempio: dare il 2% in più ai carri armati è a cosa servono i mutatori!

Nota: la modifica o l'eliminazione dei mutatori qui li modifica solo per questa sessione

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "Non nel raid";
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
L.GDKP_CUTS_SUMMARY = "%s Predoni | %s Con taglio | Pagamento totale: %sg";
L.GDKP_CUT_IMPORT_EMPTY = "Niente da importare, ricontrolla il tuo CSV";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Oro mancante per il giocatore %s";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "Intestazione mancante, nota: fa distinzione tra maiuscole e minuscole!";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Nome del giocatore mancante";
L.GDKP_DELETE_BID_INFO = "Elimina l'offerta. L'asta deve essere fermata prima!";
L.GDKP_DISTRIBUTE_ADDRAIDER = "Aggiungi un raider a questa sessione";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "Personalizzato (crea il tuo formato)";
L.GDKP_EXPORT_AUCTIONS_JSON = "Dettagliato (JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "Condividi (può essere importato da altri giocatori)";
L.GDKP_EXPORT_CUSTOM_FORMAT = "Il tuo formato personalizzato";
L.GDKP_EXPORT_CUSTOM_HEADER = "La tua intestazione personalizzata";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Personalizzato (crea il tuo formato)";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@GIOCATORE,@TAGLIO";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "Giocatore,Taglia";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "data/ora in cui la sessione è stata bloccata";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "oro totale dato al giocatore";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "oro inviato al giocatore";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "oro totale ricevuto dal giocatore";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "data/ora in cui è stato assegnato il primo oggetto";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "oro scambiato al giocatore";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@OGGETTO,@VINCITORE,@ORO,@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "Oggetto, Giocatore, Oro, Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "Data/ora in cui è stato assegnato il primo item";
L.GDKP_EXPORT_FORMAT_TITLE = "Il titolo della sessione del GDKP";
L.GDKP_EXPORT_POT_CHANGED = "La pentola è cambiata";
L.GDKP_GOLD_TRADES = "Commerci d'oro";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "Sei sicuro? Non sarai in grado di vedere o fare offerte sui prossimi articoli!";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!! ATTENZIONE!!!|r

Sei su un reame connesso e stai importando i nomi dei giocatori senza
un suffisso di regno, '%s' per esempio. Ciò può causare l'invio
taglia e taglia le mail al giocatore sbagliato.

Quando sei su un reame connesso, cerca sempre di includere il nome del reame dei giocatori!

Continuare l'importazione?
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "Ciò sovrascriverà qualsiasi modifica apportata alla finestra di taglio, sei sicuro?";
L.GDKP_IMPORT_CUTS_INFO = [[
Puoi importare i tagli dei giocatori dai tuoi calcoli come un foglio di Google. softres GDKP ecc.

Il formato è il seguente (|c00BE3333INCLUDE THE HEADER!!):

|c00BE3333Giocatore,Oro|c00967FD2
Giocatore1,4000
Giocatore2,4125
Giocatore3,3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
Importa prezzi minimi e incrementi GDKP.

Il formato è il seguente: ItemID + minimo o incremento sono obbligatori. (|c00BE3333RICHIEDE UN'INTESTAZIONE!!):

|c00BE3333IDArticolo,Minimo,Incremento|c00967FD2
18608,4000,500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "Eliminare le impostazioni di prezzo esistenti? Fai clic su Sì per eliminare tutti i dati sui prezzi, su No per sovrascrivere semplicemente quelli esistenti con i dati forniti qui";
L.GDKP_IMPORT_SESSION = "Importa sessione GDKP";
L.GDKP_IMPORT_SESSION_ABOUT = "Qui puoi importare (e continuare) una sessione GDKP. Per ottenere una sessione GDKP da qualcuno, è necessario esportarla in |c00FFF569/gdkp dove selezionare il formato 'Condividi (può essere importato da altri giocatori)'";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "Stai per importare una sessione GDKP creata da %s, sei sicuro?";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "Questa sessione GDKP creata da %s sembra già esistere, desideri sovrascriverla?";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "Dati non validi forniti per l'estensione GDKP!";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "Dati non validi forniti per la riprogrammazione GDKP!";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "Dati non validi forniti per l'accorciamento GDKP!";
L.GDKP_INVALID_DATA_FOR_START = "Dati non validi forniti per l'inizio dell'asta GDKP!";
L.GDKP_INVALID_PAID_AMOUNT = "Numero non valido fornito per 'pagato'";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "Orario non valido fornito nell'asta: riprogrammare";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP Dati (venduti %sx)
Ultimo venduto per: %s
Prezzo medio: %s
Offerta minima: %s
Incremento: %s

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "Saldo: |c0092FF000 ? Sei quadrato! | |c00BE333330 ? devi %s 30g | |c00F7922E50 ? %s ti deve 50 g";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "Oro inviato via posta da %s";
L.GDKP_LEDGER_LEGEND_PAID_TO = "Oro pagato a %s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "Oro ricevuto da %s";
L.GDKP_LEDGER_MUTATION = "Oro %s di"; -- %s = removed or added
L.GDKP_LEDGER_POT = "Piatto totale: %sg | Taglio gestionale: %sg (%s%%) | Per distribuire: %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s | Di %s%s | Su |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "La sessione GDKP non è disponibile o è bloccata";
L.GDKP_MAIL_ALL = "Invia posta a tutti";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "Nessuna offerta rilevata per un oggetto Leggendario+, continua manualmente!";
L.GDKP_MISSING_CONTENT_FOR_START = "Contenuto mancante nell'asta:inizio";
L.GDKP_MULTIAUCTION_ABOUT = [[

Con le aste multiple (o aste batch) puoi mettere all'asta tutti gli oggetti che desideri contemporaneamente!
Ciò velocizza enormemente le tue notti di raid e rende l'esperienza senza soluzione di continuità per i tuoi predoni

Tutti gli oggetti commerciabili ancora nel tuo inventario possono essere automaticamente messi all'asta con 'Riempi dall'inventario'
Dagli Un colpo!

|c00808080C'è solo uno svantaggio: affinché le persone possano partecipare a un'asta batch, i predoni avranno bisogno di Gargul!

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "Devi avere una sessione GDKP attiva (sbloccata)!";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "Con questa finestra aperta, %s articoli per aggiungerli all'elenco oppure fai clic su 'Riempi dall'inventario' di seguito"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Anti beccaccino in pochi secondi";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "Il valore anti-snipe deve essere 0 (vuoto) o >=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Torna al selettore degli elementi";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Rimuovi tutti gli elementi dall'elenco";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "Riempi dall'inventario";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Aggiungi oggetti commerciabili dal tuo inventario all'elenco";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Qui puoi determinare quali articoli includere nella sessione multi-asta

Utilizza il pulsante |c00A79EFFRiempi dall'inventario qui sotto per aggiungere oggetti che possono ancora essere scambiati all'elenco
Ogni volta che cancelli e riapri questa finestra, le ultime impostazioni di riempimento verranno utilizzate per aggiungere automaticamente gli elementi

|c00A79EFF%s elementi per aggiungerli manualmente all'elenco
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Passaggio successivo: controlla la compatibilità della versione aggiuntiva di Raider";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "Non tutti usano Gargul, sei sicuro di voler iniziare l'asta?";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Seleziona almeno un oggetto per la tua asta";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Il tuo Gargul è obsoleto, ti consigliamo di aggiornarlo prima di iniziare una sessione per evitare problemi!";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "Non tutti sono aggiornati. Se riscontri problemi, dì ai tuoi raider di aggiornare!";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "C'è un'asta multipla attiva, gli articoli che aggiungi qui verranno aggiunti alla sessione esistente. Fai attenzione agli articoli duplicati!";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Cerca nome o iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Supporta nomi di elementi e iLVL, ad es. '252', '<252' ecc";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Sessione GDKP attiva: |c00967FD2%s | Di %s%s | Su |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Tempo dell'asta in secondi";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "Il tempo dell'asta in secondi deve essere >= 10";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "Te ne sei andato durante la sessione di offerte GDKP. Per riprenderlo devi fornire un nuovo tempo di offerta (in secondi) per tutti gli articoli invenduti";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "Con questa finestra aperta, %s elementi per aggiungerli all'elenco";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "Fai clic sull'icona dell'ingranaggio per gestire un'asta";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "Sei già il miglior offerente su %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
Offerta |c00%s%sg
Entro %s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%sCHIUSO
Nessuna offerta]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
Minimo: |c00%s%sg
Incremento: |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "Articoli: %s - Totale venduto: %sg - Promesso da me: %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
Elementi con offerte: %s/%s
Totale venduto: %s
Comprato da me: %s
Offerta totale (non include la vendita): %s
Fai un'offerta (non include la vendita): %s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%sVENDUTO a
%s per |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
Offerta |c00%s%sg
Di |c0092FF00YOU!]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "Impossibile interrompere le offerte automatiche su %s, riprova o /ricarica!";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "Offerta automatica fino a un massimo di %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "Offerta automatica fino all'offerta che inserisci a sinistra";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "Interrompi la tua offerta automatica (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "Impossibile confermare l'offerta su %s";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "Offerta non valida o offerta troppo bassa! Il minimo è %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "È necessario attendere due secondi tra le offerte sullo stesso articolo";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "Offerte chiare";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "Rimuovi tutte le offerte dall'asta";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "Chiudi tutto";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "Chiudere TUTTE le aste?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
Chiudi TUTTE le aste

Le aste con offerte attive verranno vendute e non potranno ricevere nuove offerte!
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "Chiudi l'asta";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "Chiudi l'asta. I giocatori non possono più fare offerte ma l'offerta più alta rimane attiva";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "Rimuovi l'oggetto dall'asta compresi i dettagli dell'offerta. QUESTO NON PUÒ ESSERE ANNULLATO!";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "Disincantare tutti gli oggetti finiti ma invenduti?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
Disincanta gli oggetti invenduti

Ciò contrassegnerà tutti gli articoli invenduti come disincantati e non verranno visualizzati in una nuova sessione di aste multiple
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "Aggiungi questo articolo ai preferiti";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "Fornire un timer per la chiamata finale di quanti secondi?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "Il numero minimo di secondi è 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "Avvia una chiamata finale per quest'asta fornendo un timer di offerta (solitamente più breve).";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "Chiudere TUTTE le aste e concludere questa sessione multi-asta?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
Termina la sessione di aste multiple

Questo chiuderà tutte le aste e annuncerà il piatto totale in chat
Le aste con offerte attive verranno vendute e non potranno ricevere nuove offerte!
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "Nascondi inattivo";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "Nascondi inutilizzabile";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "Mostra/Nascondi le aste finite";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "Gestisci asta";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "Fai un'offerta per l'importo minimo richiesto";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "Finestra di offerta chiusa, usa |c00A79EFF/gl bid per riaprirla!";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "Annuncia le vendite in chat";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "Riproduci un suono quando l'offerta viene superata";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "Altre opzioni audio...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "Mostra tutto";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "Mostra preferiti";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "Mostra inattivo";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "Mostra inutilizzabile";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "Questo articolo è stato venduto. Utilizza il registro (|c00%s/gdkp) per apportare modifiche!";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "Terminare";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "Rimuovere tutte le offerte bidsl e chiudere tutte le aste?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
Termina la sessione multi-asta

Ciò eliminerà tutte le offerte sugli articoli che non sono ancora stati venduti e chiuderà tutte le aste!
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "Passa il mouse su uno dei pulsanti sottostanti per ulteriori informazioni";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "Mostra/nascondi gli elementi che non puoi utilizzare";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "Dati non validi forniti per l'inizio dell'asta GDKP!";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s ha acquistato %s per %sg";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "Il loot master (%s) è obsoleto, questo può far fallire le offerte!";
L.GDKP_MULTIAUCTION_OUTBID = "La tua offerta è stata superata!";
L.GDKP_MUTATORS = "Mutatori";
L.GDKP_MUTATOR_ADD = "Aggiungi Mutatore";
L.GDKP_MUTATOR_APPLY_LABEL = "Applicazione automatica a";
L.GDKP_MUTATOR_CREATE_NEW = "Crea un nuovo mutatore GDKP";
L.GDKP_MUTATOR_DELETE_BYPASS = "Eliminare. Tieni premuto il turno per ignorare la conferma";
L.GDKP_MUTATOR_EDIT = "Modifica mutatore";
L.GDKP_MUTATOR_FLAT_LABEL = "Tasso fisso dell'oro [esempio: 250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "La tariffa forfettaria deve essere un numero";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
Esempio:
|c00967FD2SELF,RL,GUARITORE]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "Puoi applicare automaticamente questo mutatore ai predoni usando le parole chiave:";
L.GDKP_MUTATOR_NAME_LABEL = "Nome [esempio: Serbatoi]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "I nomi dei mutanti non possono contenere punti (.)";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Percentuale [esempio: 10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "La percentuale deve essere un numero";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Conservare per sessioni future";
L.GDKP_MUTATOR_UNKNOWN = "Mutatore sconosciuto: %s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "All'utente '%s' non è consentito avviare aste";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "All'utente '%s' non è consentito interrompere le aste";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "L'utente '%s' non è autorizzato a interrompere l'asta: asta non valida";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "Non c'è abbastanza oro da distribuire, aspettatevi strani calcoli sui tagli!";
L.GDKP_NO_BIDS = "Nessuna offerta!";
L.GDKP_OUTBID = "La tua offerta è stata superata!";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(attivo)";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
Hai bisogno di piombo o bottino principale per regolare l'oro.
Non è possibile modificare l'oro nelle sessioni bloccate/eliminate]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "Aggiungi/Rimuovi oro";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s pagato |c00%s%s per
%S]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333Eliminato da %s
Motivi]];
L.GDKP_OVERVIEW_DELETED_SESSION = "(eliminato)";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
Hai bisogno di lead o bottino principale per eliminare le voci.
Non è possibile eliminare le voci nelle sessioni bloccate/eliminate]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "Fornire un motivo per eliminare questa voce";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "Eliminare. Tieni premuto Maiusc per ignorare la nota";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "Le sessioni con aste allegate verranno cancellate dopo 48 ore";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
Hai bisogno di lead o bottino principale per modificare le voci.
Non è possibile modificare le voci eliminate o le voci presenti su sessioni bloccate/eliminate]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "Esporta una sessione in modo che altri possano visualizzarne i dettagli o addirittura sostituirti come maestro del bottino";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "Importa una sessione da un altro giocatore o account";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
Mostra una panoramica completa del libro mastro,
ideale per scopi di screenshot!]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "Bloccare una sessione significa che non puoi mettere all'asta oggetti o modificare in altro modo nulla finché non la sblocchi, sei sicuro?";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "Blocca o sblocca la sessione";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "Blocca la sessione per il pagamento";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "Asta multipla: metti all'asta più oggetti contemporaneamente!";
L.GDKP_OVERVIEW_MUTATION_ADDED = "aggiunto a";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s %s piatto di %s
Appunti]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "rimosso da";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
Vaso: %s
Taglio gestionale (%s%%): %sg
Taglio per giocatore (1/%s): %sg
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
Hai bisogno di piombo o bottino principale per ripristinare le voci.
Non è possibile ripristinare le voci delle sessioni bloccate/eliminate]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "Di %s%s | Il |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "Sbloccare e cambiare il piatto o i tagli può diventare davvero complicato, soprattutto se hai già effettuato i pagamenti. Sei sicuro?";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "Sblocca la sessione";
L.GDKP_PAYOUT_INACTIVE = "Nessuna sessione GDKP attiva rilevata o la sessione non è bloccata per il pagamento!";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "L'incremento o il minimo non possono essere inferiori a .0001!";
L.GDKP_PRICE_IMPORT_INVALID_INC = "'Incremento' fornito non valido per l'ID articolo '%s'";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "Valore minimo fornito non valido per l'ID articolo '%s'";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "È richiesto un minimo o un incremento per l'ID articolo: %s";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "Intestazione mancante, nota: fa distinzione tra maiuscole e minuscole!";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Dati importati per %s elementi correttamente";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "ID articolo sconosciuto: %s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s oggetti nelle borse, nelle finestre del bottino o anche sui link nella tua chat per aggiungerli a questa coda dell'asta.
Gli articoli in coda verranno automaticamente messi all'asta una volta terminata l'asta corrente. Fare clic sul pulsante '%s' per impedirlo.

Vuoi che Gargul assegni o disincanti automaticamente le aste per te? Apri la rotella delle impostazioni sul lato sinistro!

|c00FFF569Lo sapevi?
Puoi spostare gli elementi trascinandoli
Gli elementi verranno ricordati, anche quando |c00A79EFF/ricarichi
Gli oggetti in coda vengono automaticamente mostrati ai predoni che hanno Gargul in modo che possano pre-offertare
Gargul può anche gestire il saccheggio automatico per te. Controllalo con |c00A79EFF/gl pm
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Nascondi oggetti inutilizzabili";
L.GDKP_SESSION = "Sessione del GDKP";
L.GDKP_SESSION_EDIT_TITLE = "Modifica %s";
L.GDKP_SHOW_UPCOMING = "Mostra i prossimi articoli";
L.GDKP_STOP_AUCTION_FIRST = "Prima ferma l'asta!";
L.GDKP_THEY_OWE = "%s ti deve %s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP Sessione
Speso dal giocatore: %s
Dati: %s
Ricevuto: %s
Taglio del giocatore: %s

%S
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "Escludi dal GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "L'oro scambiato non verrà aggiunto all'importo dato o ricevuto";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Oro |c00967FD2dato a %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "Impossibile aggiungere %s alla finestra di scambio. Prova ad aggiungerlo manualmente!";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "Non hai abbastanza soldi per pagare %s";
L.GDKP_TRADE_GOLD_TO_GIVE = "Per dare: %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "Per ricevere: %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Oro |c00967FD2ricevuto da %s";
L.GDKP_TRY_MULTIAUCTION = "Dai un'occhiata alle multi aste!";
L.GDKP_TUTORIAL_INFO = "Segui i passaggi seguenti per iniziare rapidamente con Gargul GDKP!";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "Attiva questa sessione facendo clic sul pulsante |c00FFF569Abilita qui sotto!";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s un oggetto da mettere all'asta o mettere in coda un singolo oggetto"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
Comandi utili:
- |c00FFF569/gdkp per aprire questa finestra
- |c00FFF569/gl ma per aprire la finestra multi-asta
- |c00FFF569/gl au per aprire il banditore/coda del singolo oggetto
- |c00FFF569/gl pm per impostare il saccheggio automatico

]];
L.GDKP_TUTORIAL_STEP_DONE = "Se tutto è andato bene, vedrai qui i tuoi oggetti appena messi all'asta!";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "Vuoi mettere all'asta più oggetti contemporaneamente? Esegui |c00FFF569/gl ma (o |c00FFF569/gl multiauction) o clicca sull'icona multi-asta in alto a destra in questa finestra!";
L.GDKP_TUTORIAL_STEP_NEW = "Fai clic sul pulsante |c00FFF569Nuovo in basso per creare la tua prima sessione GDKP. Verrà visualizzato a sinistra una volta creato";
L.GDKP_TUTORIAL_STEP_READY = "Sei pronto per vendere oggetti! |c00BE3333Leggi attentamente tutti i passaggi seguenti e testali tutti da solo (non è necessario partecipare a un raid) prima di iniziare il tuo primo raid GDKP!";
L.GDKP_TUTORIAL_STEP_SELL = "Vuoi vendere un oggetto senza che nessuno faccia offerte? |c00FFF569%s su un articolo, scegli un vincitore e stabilisci un prezzo!";
L.GDKP_TUTORIAL_TITLE = "Iniziare";
L.GDKP_UNKNOWN_ITEM = "ID oggetto sconosciuto nell'asta:crea: %s";
L.GDKP_UNKNOWN_SESSION = "Identificatore di sessione sconosciuto nell'asta:crea: %s";
L.GDKP_YOU_OWE = "Sei in debito con %s %s";
L.GIVEN = "Dato";
L.GOLD_INDICATOR = "G";
L.GROUP = "Gruppo";
L.GROUP_MANAGER = "Gestore del gruppo";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "Scarica su CurseForge";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "Fermati";
L.HEADER = "Intestazione";
L.HELLO = "|c00%sGargul v%s di Zhorax@Firemaw. Digita |c00%s/gl o |c00%s/gargul per iniziare!";
L.HIDE = "Nascondere";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.IDENTITY_INFO = "Visita l'URL riportato di seguito per ulteriori informazioni sulla personalizzazione dei GDKP Gargul";
L.IDENTITY_TOOLTIP = "Il tuo logo qui? Clicca per maggiori informazioni!";
L.IMPORT = "Importare";
L.IMPORTED_AND_UPDATED_ON = "Importato il |c00A79EFF%s a |c00A79EFF%s, Aggiornato il |c00A79EFF%s a |c00A79EFF%s";
L.IMPORT_EXPLANATION = "Che tipo di dati desideri importare?";
L.IMPORT_SUCCESSFUL = "Importazione dei dati di rollio potenziati riuscita";
L.INC = "Inc";
L.INCLUDE_AWARDED = "Includi oggetti precedentemente assegnati";
L.INCLUDE_BOES = "Includi BOE";
L.INCLUDE_MATERIALS = "Includi materiali (come i cristalli dell'Abisso)";
L.INCREMENT = "Incremento";
L.INFO = "Informazioni";
L.INVALID_DATA_WARNING = "Dati forniti non validi";
L.ITEM = "Articolo";
L.JSON_DECODE_WARNING = "Impossibile decodificare i dati JSON. Assicurati di copiarlo/incollarlo così com'è senza aggiungere caratteri o spazi bianchi aggiuntivi!";
L.KEYS_INFO = [[
Tasti di scelta rapida degli oggetti Gargul

Lancio: |c00A79EFF%s
Premio: |c00A79EFF%s
Disincanta: |c00A79EFF%s


-- Fare clic con il tasto destro per disabilitare questa finestra --
]];
L.LEDGER = "Registro";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "Devi essere il maestro saccheggiatore o avere un ruolo di assistenza/protagonista!";
L.LOCALE_CHANGE_NOTE = "Nota: puoi modificare la localizzazione in qualsiasi momento nelle impostazioni o tramite |c00%s/gl locale";
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ENUS = "itUS"; -- English (United States)
L.LOCALE_ESES = "esES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "fraFR"; -- French (France)
L.LOCALE_ITIT = "esso esso"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul pubblica messaggi di chat in inglese (impostazione predefinita)
Puoi selezionare una lingua diversa nel menu a discesa sottostante

La tua lingua di chat attuale è '%s', abilitare una lingua diversa causerà un /reload!
]];
L.LOCALE_NONE_TITLE = "Scegli una lingua di chat per Gargul";
L.LOCALE_PTBR = "ptBR"; -- Portuguese (Brazil)
L.LOCALE_RURU = "ruRU"; -- Russian (Russia)
L.LOCALE_ZHCN = "zhCN"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "zhTW"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "Hai uno o più componenti aggiuntivi installati che potrebbero potenzialmente causare il malfunzionamento di Gargul: %s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "Cancella SoftRes";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "Cancella TMB";
L.LOOTMASTER_DEFAULT_NOTE = "/roll per MS o /roll 99 per sistema operativo";
L.LOOTMASTER_IMPORT_SR_BUTTON = "Importa SoftRes";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "Importa TMB";
L.LOOTMASTER_NOTICE_LABEL = "Ti è stato assegnato il ruolo di Master Looter";
L.LOOTMASTER_OPEN_LABEL = "Apri questa finestra automaticamente";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Le priorità del bottino sono state cancellate con successo";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Fornire un CSV prio nel seguente formato (1 riga per articolo): id o nome > prio1, equalprio > prio2 > ecc.";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Priorità del bottino importate con successo";
L.LOOTPRIORITY_INVALID_DATA = "Dati forniti non validi";
L.LOOTPRIORITY_INVALID_LINE = "Dati non validi forniti nella riga: '%s': ID elemento o priorità mancante";
L.LOOTPRIORITY_PROCESS_INCOMING = "Tentativo di elaborare le priorità del bottino in arrivo da %s";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Saccheggio prioritario";
L.MAIL = "Posta";
L.MAILED = "Spedito";
L.MAIL_CUTS_EXPLANATION = "Mail tagliata ai giocatori";
L.MAINSPEC_ABBR = "SM";
L.MAXIMIZE = "Massimizzare";
L.MIN = "minimo";
L.MINIMAP_BUTTON_AWARDED = "Premiato con la storia del bottino";
L.MINIMAP_BUTTON_CUTS = "Tagli al Pil";
L.MINIMAP_BUTTON_EXPORT = "Esporta dati";
L.MINIMAP_BUTTON_GARGUL = "Apri Gargul";
L.MINIMAP_BUTTON_IMPORT = "Importa dati";
L.MINIMAP_BUTTON_LEDGER = "Registro GDKP";
L.MINIMAP_BUTTON_MULTIAUCTION = "Multiasta";
L.MINIMAP_BUTTON_SETTING_INFO = "Modifica le impostazioni nella minimappa /gl";
L.MINIMIZE = "Minimizzare";
L.MINIMIZE_ON_AWARD = "Ridurre al minimo il premio";
L.MINIMIZE_ON_START = "Riduci a icona all'avvio";
L.MINIMUM = "Minimo";
L.MINIMUM_QUALITY = "Qualità minima";
L.MINUS10 = "-10";
L.MINUS_SIGN = "-";
L.MOVE = "Mossa";
L.MULTI_AUCTION = "Asta multipla";
L.NAME = "Nome";
L.NEW = "Nuovo";
L.NEXT = "Prossimo";
L.NO = "NO";
L.NONE = "Nessuno";
L.NOTE = "Nota";
L.NOTHING = "Niente";
L.NO_BIDS_ACTION = "Quando nessuno fa offerte:";
L.NO_OFFICER_PRIVILEGES = "Non hai i privilegi di ufficiale";
L.OFFSPEC_ABBR = "sistema operativo";
L.OK = "OK";
L.OPEN = "Aprire";
L.OPEN_AUCTIONEER = "Banditore aperto";
L.OPEN_MULTI_AUCTION = "Asta multipla aperta";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "AVIDITÀ";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORARE";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "BISOGNO";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASSAGGIO";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "CASUALE";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "RR";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SE STESSO";
L.PACKMULE_CONFIRM_DISENCHANTER = "Impostare %s come disincantatore?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "Inviare %s a %s? Digita /gl cd per rimuovere questo disincantatore!";
L.PACKMULE_NO_DISENCHANTER_WARNING = "Nessun set di disincantatore, usa /gl sd [mydisenchanter] per impostarne uno";
L.PACKMULE_WHO_IS_DISENCHANTER = "Chi è il tuo disincantatore?";
L.PAID = "Pagato";
L.PASS = "Passaggio";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "Giocatore";
L.PLAYER_ITEM_WON_COUNT = "Oggetti vinti da %s:";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "Quelli in più";
L.PLUSONES_AWARD_DIALOG_LABEL = "Aggiungi un +1";
L.PLUSONES_BROADCAST_CONFIRM = "Sei sicuro di voler trasmettere i tuoi dati Plus One a tutti nel tuo party/raid?";
L.PLUSONES_BROADCAST_PROCESS_START = "Tentativo di elaborare i dati PlusOnes in arrivo da %s";
L.PLUSONES_CLEAR_CONFIRM = "%s vuole cancellare tutti i tuoi dati PlusOne. Cancellare tutti i dati?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "Sei sicuro di voler cancellare i tuoi dati PlusOne esistenti e importare i nuovi dati trasmessi da %s?";
L.PLUSONES_IMPORT_CONFIRM = "Sei sicuro di voler importare i nuovi dati trasmessi da %s?";
L.PLUSONES_IMPORT_ERROR = "Dati forniti non validi. Assicurati che i contenuti seguano il formato richiesto e che non sia inclusa alcuna riga di intestazione";
L.PLUSONES_IMPORT_INFO = [[
Qui puoi importare più uno dati da una tabella in formato CSV o TSV o incollati da un foglio di Google Documenti.

La tabella necessita di almeno due colonne: il nome del giocatore seguito dalla quantità di punti. Le colonne aggiuntive vengono ignorate.

Ecco una riga di esempio:

Foobar,240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Accetta automaticamente le trasmissioni in arrivo da %s";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Blocca tutti i dati condivisi +1 in entrata";
L.PLUSONES_UPDATE_CONFIRM = [[
Sei sicuro di voler aggiornare i tuoi dati PlusOne esistenti con i dati di %s?

Il tuo ultimo aggiornamento è stato su |c00A79EFF%s, il loro su |c00A79EFF%s.]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "Pentola";
L.PRICE = "Prezzo";
L.PRIOLIST_ABBR = "PL";
L.QUALITY_COMMON = "Comune";
L.QUALITY_EPIC = "Epico";
L.QUALITY_HEIRLOOM = "Cimelio di famiglia";
L.QUALITY_LEGENDARY = "Leggendario";
L.QUALITY_POOR = "Povero";
L.QUALITY_RARE = "Raro";
L.QUALITY_UNCOMMON = "Raro";
L.QUEUE = "Coda";
L.RAIDERS = "Predoni";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Chi manca";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Mostra i nomi dei giocatori mancanti";
L.RAIDGROUPS_DISBAND_BUTTON = "Sciogliere il raid";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Sciogli il tuo raid";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s è elencato due volte nel roster!";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "un'esportazione |c00FFF569Raid-Helper (usa la variante 'Gruppi ordinati verticalmente') o un |c00FFF569CSV di composizione del gruppo Gargul:";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
Nella grande casella di modifica qui sotto puoi fornire un elenco e: invitare tutti, controllare chi manca, applicare gruppi e assegnare i carri armati.

Puoi fornire un link alla composizione del raid |c00FFF569Wowhead:]];
L.RAIDGROUPS_GARGUL_BUTTON = "Wiki del gruppo Gargul";
L.RAIDGROUPS_GARGUL_INFO = "Visita la wiki del gruppo Gargul per maggiori informazioni sul formato del gruppo raid";
L.RAIDGROUPS_IMPOSTER_WARNING = "I seguenti giocatori non fanno parte del roster: %s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Dati del gruppo forniti non validi, controlla il tuo formato!";
L.RAIDGROUPS_INVITE_BUTTON = "Invitare";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Invia inviti ai giocatori nel roster";
L.RAIDGROUPS_IN_COMBAT_WARNING = "Impossibile ordinare i gruppi mentre %s è in combattimento!"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "Devi partecipare a un raid!";
L.RAIDGROUPS_NO_TANKS_WARNING = "Nessun serbatoio definito";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "Non riesci a trovare un posto per %s, stai cercando di inserire più di 5 persone in 1 gruppo?";
L.RAIDGROUPS_PURGE_BUTTON = "Calcia i giocatori indesiderati";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Espellere i giocatori che non sono nel roster";
L.RAIDGROUPS_SORTING_ERROR = "Qualcosa è andato storto durante lo spostamento di %s";
L.RAIDGROUPS_SORTING_FINISHED = "Finita l'applicazione del roster del raid";
L.RAIDGROUPS_SORTING_GROUPS = "Gruppi di ordinamento";
L.RAIDGROUPS_SORT_BUTTON = "Applica gruppi";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Ordina i gruppi in base al roster";
L.RAIDGROUPS_SORT_IN_PROGRESS = "L'ordinamento è ancora in corso, aspetta un po'!";
L.RAIDGROUPS_TANKS_ASSIGNED = "Tutti i carri armati sono assegnati";
L.RAIDGROUPS_TANK_BUTTON = "Assegna carri armati";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Strumento di composizione Wowhead";
L.RAIDGROUPS_WOWHEAD_INFO = "Puoi visitare lo strumento Wowhead Comp utilizzando l'URL in basso. Dopo aver creato la tua composizione puoi incollarla qui o nel grande campo di modifica della finestra del gruppo Gargul";
L.REMOVE_BID = "Rimuovi l'offerta";
L.RESET_SETTINGS = "Ripristina le impostazioni";
L.RESET_SETTINGS_CONFIRMATION = "Sei sicuro di voler ripristinare tutte le impostazioni di Gargul? Questa operazione non può essere annullata!";
L.RESET_UI = "Ripristina l'interfaccia utente di Gargul";
L.RESET_UI_CONFIRMATION = "Sei sicuro di voler reimpostare tutte le dimensioni, le posizioni e la scala delle finestre di Gargul? Questa operazione non può essere annullata!";
L.RESTORE = "Ristabilire";
L.RESUME = "Riprendere";
L.RIGHT_SYMBOL = ">";
L.ROLL = "Rotolo";
L.ROLLING_AWARD_CONFIRM = "Premio da %s a %s?";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Vicino al premio";
L.ROLLING_CLOSE_ON_START_LABEL = "Chiudi all'avvio";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Tieni premuto il turno per ignorare la conferma del premio";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Tieni premuto il turno per mostrare la conferma del premio";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
Attenzione: è stato trovato un altro risultato identico che può far pensare ad un pareggio

]];
L.ROLLING_INVALID_START_DATA_WARNING = "Dati forniti per il rullo di partenza non validi!";
L.ROLLING_ITEM_WON_BR_COST = "(BR: %s)";
L.ROLLING_ITEM_WON_GIVEN = "(voce data: sì)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(voce data: no)";
L.ROLLING_ITEM_WON_OS = "(sistema operativo)";
L.ROLLING_NOTE_LABEL = "NOTA";
L.ROLLING_NO_ROLLOFF_WARNING = "Impossibile fermare il roll-off, nessun roll-off in corso";
L.ROLLING_PASS_BUTTON = "Passaggio";
L.ROLLING_REOPEN_ROLL_COUNT = "rotoli: %s";
L.ROLLING_REOPEN_TOOLTIP = "Apri la finestra principale del saccheggiatore";
L.ROLLING_ROLL_ACCEPTED = "Rotolo accettato!";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "Attualmente è in corso un appello";
L.ROLLING_ROLL_PRIOLIST = "Prezzo [%s]";
L.ROLLING_ROLL_SR_COUNT = "RS [%sx]";
L.ROLLING_ROLL_WISHLIST = "Desiderio [%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "Devi prima selezionare un giocatore";
L.ROLLING_TIMER_LABEL = "TIMER (i)";
L.ROLLING_UNUSABLE_ITEM = "Non puoi usare questo oggetto!";
L.ROLLING_WINNER_NOT_UNIQUE = "Il nome del vincitore non è univoco, seleziona il giocatore a cui desideri assegnare %s";
L.SECONDS_ABBR = "S";
L.SELECT_ALL = "Seleziona / Disabilita tutto";
L.SESSION = "Sessione";
L.SETTINGS = "Impostazioni";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Annunciare le offerte in arrivo";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Annuncia il piatto dopo aver assegnato l'oggetto";
L.SETTINGS_ANNOUNCE_START = "Annuncio dell'inizio dell'asta";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Annuncia il conto alla rovescia nell'avviso di raid";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Annuncia le offerte in arrivo nell'avviso di raid";
L.SETTINGS_RESET_UI = "Ripristina l'interfaccia utente di Gargul";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Sussurra all'offerente se l'offerta è troppo bassa";
L.SILVER_INDICATOR = "S";
L.SKIP = "Saltare";
L.SOFTRES = "Riserve Soft";
L.SOFTRES_ABBR = "SR";
L.SOFTRES_BROADCAST_CONFIRM = "Sei sicuro di voler trasmettere i tuoi dati softres a tutti i membri del tuo gruppo/raid?";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "Impossibile elaborare i dati SoftRes ricevuti da %s";
L.SOFTRES_CLEAR_CONFIRM = "Sei sicuro di voler cancellare tutti i dati soft-reserve esistenti?";
L.SOFTRES_EVERYONE_RESERVED = "Tutti hanno riempito le loro riserve morbide";
L.SOFTRES_FEATURE_MISSING = [[
Le informazioni sulla riserva fisica non sono disponibili perché le riserve soft
forniti non sono stati generati utilizzando il pulsante 'Gargul Export' su softres.it]];
L.SOFTRES_IMPORT_DETAILS = "Importato il |c00A79EFF%s a |c00A79EFF%s";
L.SOFTRES_IMPORT_FIXED_NAME = "Correzione automatica del nome: la SR di '%s' è ora collegata a '%s'";
L.SOFTRES_IMPORT_INFO = "Per iniziare devi prima creare un raid su softres.it. Successivamente clicca su 'Addon Export', seleziona 'Gargul', copia i dati e incollali nel modulo sottostante.";
L.SOFTRES_IMPORT_INVALID = "Dati soft-reserve forniti non validi";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Dati forniti non validi. Assicurati di fare clic sul pulsante 'Gargul Export' su softres.it e incollare qui l'intero contenuto";
L.SOFTRES_IMPORT_NEW_PLUSONES = "I valori PlusOne forniti collidono con quelli già presenti. Vuoi sostituire i tuoi vecchi valori PlusOne?";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "I seguenti giocatori non hanno prenotato nulla:";
L.SOFTRES_IMPORT_SUCCESSFUL = "Riserve software importate correttamente";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "Importazione riuscita!";
L.SOFTRES_IMPORT_USE_GARGUL = "I dati SoftRes Weakaura e CSV sono deprecati, utilizza invece l'esportazione Gargul!";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "Impossibile connettersi a LootReserve, contatta l'assistenza (includi il messaggio di seguito)";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "Nessun URL softres.it disponibile, assicurati di aver esportato utilizzando il pulsante 'Gargul Export' su softres.it!";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "Clicca qui per vedere le informazioni sulla prenotazione definitiva";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "Nessun articolo è prenotato in modo definitivo";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "Nessuna informazione disponibile sulla riserva fisica";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "Pubblica SR mancanti";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "Pubblica l'URL della SR";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "Questo giocatore non ha prenotato nulla!";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "Tentativo di elaborare i dati SoftRes in arrivo da %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "Questo articolo è riservato in modo permanente";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "Per: %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Nota: %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Riservato da";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "Qualcosa è andato storto!";
L.START = "Inizio";
L.STOP = "Fermare";
L.TAB_REPLACES_T = "	 is replaced by a tab";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "Tempo";
L.TITLE = "Titolo";
L.TMBETC = "TMB, DFT o PRIO3";
L.TMB_BROADCAST_CONFIRM = "Sei sicuro di voler trasmettere i tuoi dati TMB a tutti i membri del tuo gruppo/raid? NB: TUTTI possono vedere i tuoi dati TMB indipendentemente dai loro permessi sul sito TMB!";
L.TMB_BROADCAST_PROCESS_START = "Tentativo di elaborare i dati TMB in entrata da %s";
L.TMB_CLEAR_CONFIRM = "Sei sicuro di voler cancellare tutti i dati più uno?";
L.TMB_CLEAR_RAIDER_DATA = "Cancella i dati del raider";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "Cancellare i dati TMB per tutti i predoni?";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "Condivisione automatica abilitata: %s";
L.TMB_IMPORT_CPO_INFO = "Nella tua esecuzione classicpr.io, fai clic sul pulsante 'Gargul Export' e copia il contenuto. Successivamente incolla il contenuto così com'è nella casella sottostante e fai clic su 'Importa'. Questo è tutto!";
L.TMB_IMPORT_DETAILS = "Importato il ${date} alle ${time}";
L.TMB_IMPORT_DFT_INFO = "Esporta i tuoi dati DFT secondo le istruzioni del foglio. Successivamente incolla il contenuto così com'è nella casella sottostante e fai clic su 'Importa'. Questo è tutto!";
L.TMB_IMPORT_INVALID_CSV = "CSV fornito non valido, il formato è: 6948,giocatore1,giocatore2";
L.TMB_IMPORT_INVALID_DFT = "Dati DFT forniti non validi. Esporta i tuoi dati DFT secondo le istruzioni del foglio e incolla qui i contenuti così come sono!";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Dati TMB forniti non validi, assicurati di fare clic sul pulsante 'Download' nella sezione Gargul e incollare i contenuti qui così come sono!";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Dati TMB o DFT forniti non validi, assicurati di incollare qui i contenuti dell'esportazione così come sono!";
L.TMB_IMPORT_NOTES_AVAILABLE = "Note prioritarie disponibili: %s";
L.TMB_IMPORT_NUMBER = "Numero di elementi importati: %s";
L.TMB_IMPORT_PLAYER_NO_DATA = "I seguenti giocatori non hanno voci %s:"; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "Come usare Gargul con TMB";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "Incolla il contenuto dell'esportazione TMB così com'è nella casella sottostante e fai clic su 'Importa'";
L.TMB_NO_BROADCAST_TARGETS = "Non c'è nessuno nel tuo gruppo a cui trasmettere";
L.TMB_SYNCED = "Dati TMB sincronizzati";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF Nota: |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(sistema operativo)";
L.TMB_TOOLTIP_PRIO_HEADER = "%s Elenco priorità"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF Livello: %s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "Lista dei desideri TMB";
L.TOGGLE_DATES = "Mostra/Nascondi date";
L.TOGGLE_QUEUE = "Mostra/Nascondi coda";
L.TRADETIME_AWARD_HOWTO = "%s per assegnare il bottino!";
L.TRADETIME_ROLL_HOWTO = "%s per distribuire il bottino!";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "Nascondi tutti gli oggetti premiati";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "Nascondi gli oggetti disincantati";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "Nascondi gli oggetti assegnati a te stesso";
L.TRADE_ANNOUNCE = "Annunciare il commercio";
L.TRADE_ANNOUNCE_INFO = "Annuncia i dettagli commerciali al gruppo o in /say quando non sei in un gruppo";
L.TUTORIAL = "Esercitazione";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s oggetti nelle borse, nelle finestre di bottino o anche sui link nella tua chat per aggiungerli alla coda dell'asta.
Vuoi vendere direttamente un articolo senza fare offerte? Utilizzare |c00A79EFF%s

Puoi aprire direttamente la finestra %s digitando |c00A79EFF/glauction

Tracce di Gargul |c00FF0000TUTTO oro scambiato. Non vuoi che un'operazione faccia parte di questa sessione GDKP? Seleziona la casella di controllo 'Escludi da GDKP' durante il trading!

|c00FFF569Lo sapevi?
Gli oggetti premiati verranno automaticamente aggiunti alla finestra dello scambio
Gargul può anche gestire il saccheggio automatico per te. Controllalo con |c00A79EFF/gl pm
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
In questa finestra vengono visualizzati tutti gli oggetti assegnati in una determinata data (seleziona una o più date a sinistra).

Gli elementi possono contenere i seguenti tag:

|c00A79EFFOS: Assegnato per fuorispec
|c00A79EFFSR: questo articolo è stato prenotato temporaneamente
|c00A79EFFWL: Questo articolo è stato inserito nella lista dei desideri (Thatsmybis)
|c00A79EFFPL: Questo articolo è stato inserito nella lista prioritaria (Thatsmybis, DFT, prio3)
]];
L.TUTORIAL_BIDDER_QUEUE = [[
Gli oggetti che vedi qui sono nella coda GDKP del saccheggiatore principale
Puoi rimuoverli, fare offerte e nascondere oggetti inutilizzabili (abilita 'Nascondi oggetti inutilizzabili' nelle impostazioni in alto a sinistra)

Puoi ridimensionare la finestra, spostarla o ridurla a icona. Provalo!

Per i loot master: rimuovere gli oggetti qui li rimuoverà solo dalla tua coda personale, non dalla coda GDKP effettiva!
]];
L.TUTORIAL_MORE_HELP = "Serve ancora aiuto?";
L.TYPE = "Tipo"; -- As in type of roll or type of item
L.UNKNOWN = "sconosciuto";
L.UNKNOWN_COMM_ACTION = "Azione di comunicazione sconosciuta '%s', assicurati di aggiornare Gargul!";
L.UNLOCK = "Sbloccare";
L.UPDATE_GARGUL = "Aggiorna Gargul!";
L.VERSION_ABBR = "v";
L.VERSION_CHECK_BUTTON_REPORT = "Rapporto";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Segnala risultati obsoleti nella chat di gruppo";
L.VERSION_CHECK_COLUMN_STATUS = "Stato di Gargul";
L.VERSION_CHECK_STATUS_CHECKING = "Controllo della versione...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s: il player è aggiornato
|c00F7922Ev%s: il giocatore deve aggiornare i suoi componenti aggiuntivi
|c00BE3333%s: il giocatore non ha Gargul o utilizza una versione non supportata
|c00808080%s: il giocatore è offline o ci sta ignorando!
|c0000FFFF%s: il giocatore è nella nostra lista da ignorare!

]];
L.VERSION_CHECK_STATUS_IGNORED = "GIOCATORE IGNORATO!";
L.VERSION_CHECK_STATUS_OFFLINE = "disconnesso";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "Nessuna risposta";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "Nessuna risposta:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Disconnesso:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "obsoleto:";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "Aggiornato:";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul non è aggiornato e non funzionerà finché non lo aggiorni!";
L.VERSION_INVALID_WARNING = "Stringa di versione non valida fornita in Version:addRelease";
L.VERSION_UPDATE = "Aggiorna Gargul!";
L.VERSION_UPDATED = "|c00%sGargul è ora aggiornato a |c00%sv%s";
L.VERSION_UPDATE_AVAILABLE = "v|c00A79EFFv%s è disponibile su CurseForge/Wago. Puoi aggiornare senza chiudere il gioco, assicurati solo di /reload!";
L.WINDOW = "Finestra";
L.WINDOW_HEADER = "Gargul v%s";
L.WINDOW_SCALE = "Scala della finestra";
L.WISHLIST_ABBR = "WL";
L.YES = "SÌ";
L.YOU_DISABLED_GDKP_QUEUES = "Hai disabilitato le code GDKP";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "Impossibile comprimere i dati con zlib. Contatta l'assistenza tramite https://discord.gg/D3mDhYPVzf";
L.ZLIB_DECOMPRESS_WARNING = "Impossibile decomprimere i dati con zlib. Assicurati di copiarlo/incollarlo così com'è senza aggiungere caratteri o spazi bianchi aggiuntivi!";
