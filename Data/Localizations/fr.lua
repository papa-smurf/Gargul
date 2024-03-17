local _, GL = ...;
--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (GetLocale() ~= "frFR") then return; end
local L = Gargul_L or {};

L.GARGUL = "Gargul";

L.GOLD_INDICATOR = "g";
L.SILVER_INDICATOR = "s";
L.COPPER_INDICATOR = "c";

L.HELLO = "|cff%sGargul v%s|r par Zhorax@Firemaw. Tapez |cff%s/gl|r ou |cff%s/gargul|r pour commencer !";
L.ALL_SETTINGS = "Tous les paramètres";
L.ANTISNIPE = "Anti-bécassine";
L.ANTISNIPE_EXPLANATION = [[

Une valeur Anti Snipe de 10 signifie que toute enchère reçue avec
moins de 10 secondes restantes réinitialiseront la minuterie à 10 secondes

Vous pouvez laisser ce champ vide ou le définir sur 0 pour désactiver complètement Anti Snipe.
Les valeurs Anti Snipe inférieures à 5 ne sont pas prises en charge

]];
L.ZERO_SIGN = "0";
L.AUCTIONEER = "Commissaire-priseur";
L.AUCTION = "Enchères";
L.AUCTIONS = "Les enchères";
L.AUTO_AWARD = "Prix ​​​​auto";
L.AUTO_TRADE_OPTIONS = "Commerce automobile";
L.BID = "Offre";
L.BIDS = "Offres";
L.UNKNOWN = "inconnu";
L.BY = "par"; -- As in "bid BY"
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.BONUS_FEATURE_EXPLANATION = "Gargul a quelques tours dans son sac dont vous ne connaissez peut-être pas. Jetez un œil !";
L.BOOSTED_ROLLS = "Rouleaux boostés";
L.BROADCAST = "Diffuser";
L.BROADCAST_INC_AWARDED = "Inclure les objets récompensés";
L.BROADCAST_INC_DISENCHANTED = "Inclure les objets désenchantés";
L.BROADCAST_INC_HIDDEN = "Inclure les éléments masqués";
L.BROADCAST_INC_TIME_LEFT = "Inclure le temps restant";
L.BROADCAST_NO_DATA = "Il n'y a rien à diffuser";
L.BROADCAST_NUMBER_OF_ITEMS = "Nombre d'objets";
L.BROADCAST_TARGET_PLAYER = "Joueur ciblé (chuchotement uniquement)";
L.BROADCAST_TARGET_REQUIRED = "Whisper nécessite un joueur cible";
L.BROADCAST_TRADE_TIME_LEFT = "Temps de transaction maximum restant (en minutes)";
L.FILL = "Remplir";
L.CANCEL = "Annuler";
L.ENABLE = "Activer";
L.NEW = "Nouveau";
L.ABOUT = "À propos";
L.NOTE = "Note";
L.OK = "D'accord";
L.CHANGE_SCALE = "Ajuster l'échelle";
L.CHANNEL = "Canal";
L.CHANNEL_OFFICER = "Officier";
L.CHANNEL_WHISPER = "Chuchoter";
L.CHANNEL_RAID_WARNING = "Avertissement de raid";
L.CLOSE = "Fermer";
L.CLOSE_ON_AWARD = "Clôture sur l'attribution";
L.CLOSE_ON_START = "Fermer au démarrage";
L.COMMUNICATION = "Communication";
L.CUT_MAIL_IN_PROGRESS = "Attendez un peu, nous sommes toujours en train de traiter le mail précédent";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "Vous n'avez pas assez d'or pour payer %s";
L.CUT_MAILBOX_CLOSED = "Impossible d'envoyer du courrier lorsque la boîte aux lettres est fermée";
L.CUT_MAIL_FAILED = "Échec de l'envoi du montage à %s";
L.CUT_MAILS_FAILED = "Plusieurs erreurs de courrier détectées, abandonnant la distribution coupée";
L.CUT_MAIL_HISTORY = "Historique du courrier pour |c00967FD2%s|r";
L.CUT_SENT = "Envoyé %sg à %s";
L.CUT_MAIL_BODY = "Propulsé par Gargul : un outil de butin principal prenant en charge TMB, SoftRes, GDKP et Auto-Looting !";
L.CUT_MAIL_GOLD_MISMATCH = "Mail ENVOYÉ selon le jeu, mais votre OR restant NE CORRESPOND PAS, quelque chose s'est mal passé ?";
L.CUT_MAIL_EVEN = "Vous ne devez pas d'or à %s";
L.CUT_MAIL_SUBJECT = "Gargul GDKP : %sg";
L.DELETE = "Supprimer";
L.DISABLE = "Désactiver";
L.EDIT = "Modifier";
L.DETAILS = "Détails";
L.SELECT_ALL = "Sélectionner / Désactiver tout";
L.IMPORT = "Importer";
L.EXPORT = "Exporter";
L.FINAL_CALL = "Dernier appel";
L.LEDGER = "registre";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s|r objets dans des sacs, des fenêtres de butin ou même sur des liens dans votre chat pour les ajouter à cette file d'attente d'enchères.
Les articles dans la file d'attente seront automatiquement mis aux enchères une fois votre enchère en cours terminée. Cliquez sur le bouton '%s' pour éviter cela.

Voulez-vous que Gargul attribue ou désenchante automatiquement les enchères pour vous ? Ouvrez la molette des paramètres sur le côté gauche !

|c00FFF569Le saviez-vous ?|r
Vous pouvez déplacer des éléments par glisser-déposer
Les éléments seront mémorisés, même lorsque vous |c00A79EFF/reload|r
Les objets en file d'attente sont automatiquement présentés aux raiders qui possèdent Gargul afin qu'ils puissent pré-enchérir.
Gargul peut également gérer le pillage automatique pour vous. Découvrez-le avec |c00A79EFF/gl pm|r
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Masquer les éléments inutilisables";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "Es-tu sûr? Vous ne pourrez pas voir ni enchérir sur les articles à venir !";
L.GDKP_PAYOUT_INACTIVE = "Aucune session GDKP active détectée ou la session n'est pas verrouillée pour le paiement !";
L.GDKP_SESSION = "Séance GDKP";
L.GDKP_SHOW_UPCOMING = "Afficher les articles à venir";
L.GDKPS_ARE_NOT_ALLOWED = "GDKP raids are not allowed in this version of World of Warcraft"
L.GROUP = "Groupe";
L.GROUP_MANAGER = "Dirigeant de groupe, chef de groupe";
L.IMPORT_EXPLANATION = "Quel type de données souhaitez-vous importer ?";
L.INFO = "Info";
L.INC = "Inc.";
L.INCLUDE_BOES = "Inclure les BOE";
L.INCLUDE_AWARDED = "Inclure les objets précédemment attribués";
L.INCLUDE_MATERIALS = "Inclure des matériaux (comme les cristaux des Abysses)";
L.INCREMENT = "Incrément";
L.INVALID_DATA_WARNING = "Données non valides fournies";
L.SOMETHING_WENT_WRONG_WARNING = "Quelque chose s'est mal passé !";
L.HALT = "Arrêt";
L.HIDE = "Cacher";
L.TITLE = "Titre";
L.RESTORE = "Restaurer";
L.MIN = "Min.";
L.MAXIMIZE = "Maximiser";
L.MAIL = "Mail";
L.MAIL_CUTS_EXPLANATION = "Courrier coupé aux joueurs";
L.MINIMIZE = "Minimiser";
L.MINIMIZE_ON_AWARD = "Réduire lors de l'attribution";
L.MINIMIZE_ON_START = "Réduire au démarrage";
L.BID = "Offre";
L.MINIMUM = "Le minimum";
L.MINIMUM_QUALITY = "Qualité minimale";
L.MINUS10 = "-dix";
L.MULTI_AUCTION = "Multi-enchères";
L.MOVE = "Se déplacer";
L.NEXT = "Suivant";
L.NAME = "Nom";
L.NO_BIDS_ACTION = "Quand personne n’enchérit, faites :";
L.NO_OFFICER_PRIVILEGES = "Vous n'avez pas de privilèges d'officier";
L.NOTHING = "Rien";
L.OPEN = "Ouvrir";
L.OPEN_AUCTIONEER = "Commissaire-priseur ouvert";
L.OPEN_MULTI_AUCTION = "Ouvrir des enchères multiples";
L.PLUS10 = "+10";
L.PLUSONES = "Les plus";
L.POT = "Pot";
L.QUALITY_POOR = "Pauvre";
L.QUALITY_COMMON = "Commun";
L.QUALITY_UNCOMMON = "Rare";
L.QUALITY_RARE = "Rare";
L.QUALITY_EPIC = "Épique";
L.QUALITY_LEGENDARY = "Légendaire";
L.QUALITY_HEIRLOOM = "Héritage";
L.QUEUE = "File d'attente";
L.REMOVE_BID = "Supprimer l'enchère";
L.RESET_SETTINGS = "Reset Settings"
L.RESET_SETTINGS_CONFIRMATION = "Êtes-vous sûr de vouloir réinitialiser tous les paramètres de Gargul ? Cela ne peut pas être annulé !";
L.RESET_UI = "Réinitialiser l'interface utilisateur de Gargul";
L.RESET_UI_CONFIRMATION = "Êtes-vous sûr de vouloir réinitialiser toutes les tailles, positions et échelles de fenêtres de Gargul ? Cela ne peut pas être annulé !";
L.RESUME = "CV";
L.SKIP = "Sauter";
L.SOFTRES = "Réserves souples";
L.TIME = "Temps";
L.TMBETC = "TMB, DFT ou PRIO3";
L.TOGGLE_QUEUE = "Afficher/Masquer la file d'attente";
L.TOGGLE_DATES = "Afficher/Masquer les dates";
L.TUTORIAL = "Didacticiel";
L.TUTORIAL_BIDDER_QUEUE = [[
Les objets que vous voyez ici sont dans la file d'attente GDKP du maître pilleur
Vous pouvez les supprimer, enchérir sur eux et masquer les éléments inutilisables (activez « Masquer les éléments inutilisables » dans les paramètres en haut à gauche).

Vous pouvez redimensionner la fenêtre, la déplacer ou la réduire. Essaye le!

Pour les maîtres du butin : supprimer des éléments ici les supprimera uniquement de votre file d'attente personnelle, pas de la file d'attente GDKP réelle !
]];
L.TUTORIAL_MORE_HELP = "Besoin d'aide?";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s|r objets dans des sacs, des fenêtres de butin ou même sur des liens dans votre chat pour les ajouter à la file d'attente des enchères.
Vous souhaitez vendre directement un article sans enchérir ? Utilisez |c00A79EFF%s|r

Vous pouvez ouvrir la fenêtre %s directement en tapant |c00A79EFF/gl enchères|r

Gargul suit |c00FF0000ALL|r l'or échangé. Vous ne voulez pas qu'un échange fasse partie de cette session GDKP ? Cochez la case « Exclure du GDKP » lors du trading !

|c00FFF569Le saviez-vous ?|r
Les objets récompensés seront automatiquement ajoutés à la fenêtre d'échange
Gargul peut également gérer le pillage automatique pour vous. Découvrez-le avec |c00A79EFF/gl pm|r
]];
L.UPDATE_GARGUL = "Mettez à jour Gargul !";
L.WINDOW = "Fenêtre";
L.WINDOW_SCALE = "Échelle de la fenêtre";
L.YOU_DISABLED_GDKP_QUEUES = "Vous avez désactivé les files d'attente GDKP";

L.SETTINGS_ANNOUNCE_START = "Annoncer le début des enchères";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Annoncer le pot après avoir attribué l'objet";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Chuchoter l'enchérisseur si l'offre est trop basse";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Annoncer le compte à rebours dans l'avertissement de raid";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Annoncer les offres entrantes";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Annoncer les offres entrantes dans l'avertissement de raid";

--[[ GROUP VERSION CHECK (/gl version) ]]
L.VERSION_CHECK_COLUMN_STATUS = "Statut de gargouillis";

L.VERSION_CHECK_STATUS_CHECKING = "Vérification de la version...";
L.VERSION_CHECK_STATUS_IGNORED = "JOUEUR IGNORÉ !";
L.VERSION_CHECK_STATUS_OFFLINE = "Hors ligne";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "Pas de réponse";
L.VERSION_CHECK_STATUS_EXPLANATION = ([[
|c0092FF00v%s|r: the player is up-to-date
|c00F7922Ev%s|r: the player needs to update his add-ons
|c00BE3333%s|r: the player doesn't have Gargul or is on an unsupported version
|c00808080%s|r: the player is offline or is ignoring us!
|c0000FFFF%s|r: the player is on our ignore list!

]]):format(GL.version, GL.version, L.VERSION_CHECK_STATUS_UNRESPONSIVE, L.VERSION_CHECK_STATUS_OFFLINE, L.VERSION_CHECK_STATUS_IGNORED);

L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "À jour:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "Dépassé:";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "Pas de réponse:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Hors ligne:";

L.VERSION_CHECK_BUTTON_REPORT = "Rapport";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Signaler des résultats obsolètes dans le chat de groupe";

--[[ GLOBAL ]]
L.DFT = "TFD";
L.LEFT_SYMBOL = "<";
L.RIGHT_SYMBOL = ">";
L.BIND_ON_EQUIP_ABBR = "BOÉ";
L.CLASSICPRIO_ABBR = "RCR";
L.THATSMYBIS_ABBR = "TMB";
L.WISHLIST_ABBR = "WL";
L.PRIOLIST_ABBR = "PL";
L.MAINSPEC_ABBR = "MS";
L.OFFSPEC_ABBR = "Système d'exploitation";
L.VERSION_ABBR = "v";
L.SOFTRES_ABBR = "RS";
L.BOOSTED_ROLLS_ABBR = "BR";
L.SECONDS_ABBR = "s";

L.PLUS_SIGN = "+";
L.WINDOW_HEADER = "Gargul " .. L.VERSION_ABBR .. "%s" -- %s is Gargul's version number
L.YES = "Oui";
L.NO = "Non";
L.START = "Commencer";
L.STOP = "Arrêt";
L.PASS = "Passer";
L.AUTO = "Auto";
L.CLEAR = "Clair";
L.AWARD = "Prix";
L.NONE = "Aucun";
L.DISENCHANT = "Désenchanter";
L.SETTINGS = "Paramètres";
L.PLUS1 = "+1";
L.AWARD_HISTORY = "Historique des récompenses";
L.PLAYER = "Joueur";
L.PAID = "Payé";
L.CUT = "Couper";
L.CUTS = "Coupes";
L.GIVEN = "Donné";
L.MAILED = "Envoyé par la poste";
L.BALANCE = "Équilibre";
L.ROLL = "Rouler";
L.NOTE = "Note";
L.ITEM = "Article";
L.HEADER = "Entête";
L.FORMAT = "Format";
L.TAB_REPLACES_T = "\t est remplacé par un onglet";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.TYPE = "Taper"; -- As in type of roll or type of item*
L.PLAYER_ITEM_WON_COUNT = "Objets gagnés par %s :";
L.ARE_YOU_SURE = "Es-tu sûr?";
L.IMPORT_SUCCESSFUL = "Importation réussie des données de roulis boostées";
L.BROADCAST_IN_PROGRESS_ERROR = "Diffusion toujours en cours";
L.BROADCASTING_NOTIFICATION = "Diffusion...";
L.BROADCAST_FINISHED = "Diffusion terminée !";
L.AWARDED_TO = "Attribué à";
L.PRICE = "Prix";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = L.BOOSTED_ROLLS_ABBR .. ": %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Des prix";
L.AWARDED_TOOLTIP_GIVEN = "Donné : oui";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Donné : non";
L.AWARDED_TOOLTIP_SECOND_BID = "2ème enchère : %s par %s";
L.AWARDED_YOU_WON = "Tu as gagné";
L.LM_OR_ASSIST_REQUIRED = "Vous devez être le maître pilleur ou avoir un rôle d'assistant/leader !";
L.COMM_PROGRESS = "Envoyé %s sur %s octets";
L.BROADCAST_DELAYED_BY_COMBAT = "Vous êtes actuellement en combat, retardant la diffusion";
L.UNKNOWN_COMM_ACTION = "Action de communication inconnue '%s', assurez-vous de mettre à jour Gargul !";
L.IMPORTED_AND_UPDATED_ON = "Importé le |c00A79EFF%s|r à |c00A79EFF%s|r, mis à jour le |c00A79EFF%s|r à |c00A79EFF%s|r";

L.BASE64_DECODE_WARNING = "Impossible de décoder les données en base64. Assurez-vous de le copier/coller tel quel sans ajouter de caractères ou d'espaces supplémentaires !";
L.ZLIB_DECOMPRESS_WARNING = "Impossible de décompresser les données avec zlib. Assurez-vous de le copier/coller tel quel sans ajouter de caractères ou d'espaces supplémentaires !";
L.ZLIB_COMPRESS_WARNING = ("Unable to zlib compress the data. Contact support via %s"):format(L.DISCORD_URL);
L.JSON_DECODE_WARNING = "Impossible de décoder les données JSON. Assurez-vous de le copier/coller tel quel sans ajouter de caractères ou d'espaces supplémentaires !";

L.TUTORIAL_AWARD_OVERVIEW = ([[
This window shows all the items that have been awarded on any given date (select one or more dates on the left).

Items can contain the following tags:

|c00A79EFF%s|r: Awarded for offspec
|c00A79EFF%s|r: This item was soft-reserved
|c00A79EFF%s|r: This item was wishlisted (Thatsmybis)
|c00A79EFF%s|r: This item was priolisted (Thatsmybis, DFT, prio3)
]]):format(L.OFFSPEC_ABBR, L.SOFTRES_ABBR, L.WISHLIST_ABBR, L.PRIOLIST_ABBR);

--[[ AWARDED LOOT EXPORTER /gl ah ]]
L.EXPORT_READ_ONLY_NOTICE = "Il s'agit UNIQUEMENT d'une fonctionnalité d'exportation, cela ne sert à rien de modifier les valeurs : ELLES NE SERONT PAS ENREGISTRÉES !\n\n";
L.EXPORT_DELETE_ALL_CONFIRM = "Êtes-vous sûr de vouloir supprimer l'intégralité de votre tableau d'historique des récompenses ? Cela supprime TOUTES les données de butin et ne peut pas être annulé !";
L.EXPORT_DELETE_DATE_CONFIRM = "Êtes-vous sûr de vouloir supprimer toutes les données de %s ? Ça ne peut pas être annulé!";

--[[ BAGINSPECTOR /gl inspect itemID1, itemID2 ]]
L.BAGINSPECTOR_START = "Début du contrôle....";
L.BAGINSPECTOR_FINISHED = "Inspection terminée";
L.BAGINSPECTOR_FAILED = "Échec de l'inspection des sacs : aucun rapport reçu";

--[[ BOOSTED ROLLS /gl br ]]
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!bonus|!rb|!br";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "Etes-vous sûr de vouloir effacer toutes les données de roulis boostées ?";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "Êtes-vous sûr de vouloir diffuser vos données de roulis boostées à tous les membres de votre groupe/raid ?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Données non valides fournies. Assurez-vous que le contenu suit le format requis et qu'aucune ligne d'en-tête n'est incluse.";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "Rien à diffuser, importez d'abord les données Boosted Rolls !";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "Impossible de traiter les données BoostedRolls reçues de %s";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Tentative de traitement des données BoostedRolls entrantes provenant de %s";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = "Êtes-vous sûr de vouloir mettre à jour vos rouleaux boostés existants avec les données de %s ?\n\nVotre dernière mise à jour date du |c00A79EFF%s|r, la leur le |c00A79EFF%s|r.";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "Etes-vous sûr de vouloir effacer vos données de roll boostées existantes et importer de nouvelles données diffusées par %s ?";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = "Ici, vous pouvez importer des données de lancer boostées et des alias à partir d'un tableau au format CSV ou TSV ou collés à partir d'une feuille Google Docs.\n\nLe tableau doit avoir au moins deux colonnes : le nom du joueur suivi du nombre de points. Les colonnes supplémentaires sont facultatives et peuvent contenir des alias pour le joueur.\nVoici un exemple de ligne :\n\nFoobar,240,Barfoo";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Appliquer des alias";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Ajouter les raiders manquants";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Ajouter des points au raid";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = "Ajouter combien de points pour tous ceux qui participent actuellement au raid ?\n\n|c00BE3333Utilisez d'abord le bouton 'Ajouter des raiders manquants' si vous souhaitez que tout le monde obtienne des points, même ceux qui n'ont pas d'entrée de jet améliorée !|r";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "Supprimer %s ?";
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "Aucune valeur en points fournie !";
L.BOOSTED_ROLLS_POINTS = "Points";
L.BOOSTED_ROLLS_RESERVE = "Réserve";
L.BOOSTED_ROLLS_ALIASES = "Alias";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Coût du rouleau augmenté :";

--[[ PLUS ONES /gl +1 ]]
L.PLUSONES_IMPORT_INFO = [[
Ici, vous pouvez importer plus une donnée d'un tableau au format CSV ou TSV ou collée à partir d'une feuille Google Docs.

Le tableau nécessite au moins deux colonnes : Le nom du joueur suivi du nombre de points. Les colonnes supplémentaires sont ignorées.

Voici un exemple de ligne :

Foobar,240
]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUSONES_CLEAR_CONFIRM = "Êtes-vous sûr de vouloir effacer toutes les données plus une ?";
L.PLUSONES_BROADCAST_CONFIRM = "Êtes-vous sûr de vouloir diffuser vos données Plus Un à tous les membres de votre groupe/raid ?";
L.PLUSONES_IMPORT_ERROR = "Données non valides fournies. Assurez-vous que le contenu suit le format requis et qu'aucune ligne d'en-tête n'est incluse.";
L.PLUSONES_BROADCAST_PROCESS_START = "Tentative de traitement des données PlusOnes entrantes provenant de %s";
L.PLUSONES_CLEAR_CONFIRM = "%s souhaite effacer toutes vos données PlusOne. Effacer toutes les données ?";
L.PLUSONES_UPDATE_CONFIRM = "Êtes-vous sûr de vouloir mettre à jour vos données PlusOne existantes avec les données de %s ?\n\nVotre dernière mise à jour date du |c00A79EFF%s|r, la leur le |c00A79EFF%s|r.";
L.PLUSONES_IMPORT_CONFIRM = "Etes-vous sûr de vouloir importer les nouvelles données diffusées par %s ?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "Êtes-vous sûr de vouloir effacer vos données PlusOne existantes et importer de nouvelles données diffusées par %s ?";
L.PLUSONES_AWARD_DIALOG_LABEL = "Ajouter un +1";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Bloquer toutes les données partagées +1 entrantes";
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Accepter automatiquement les diffusions entrantes de %s";

--[[ LOOTPRIORITY /gl lo ]]
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Fournissez un CSV prio au format suivant (1 ligne par élément) : id ou nom > prio1, equalprio > prio2 > etc";
L.LOOTPRIORITY_INVALID_DATA = "Données non valides fournies";
L.LOOTPRIORITY_INVALID_LINE = "Données non valides fournies à la ligne : '%s' : identifiant ou priorité d'élément manquant";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Priorités de butin importées avec succès";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Les priorités de butin ont été effacées avec succès";
L.LOOTPRIORITY_PROCESS_INCOMING = "Tentative de traitement des priorités de butin entrantes de %s";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Priorité de butin";

--[[ SOFTRES /gl sr ]]
L.SOFTRES_CLEAR_CONFIRM = "Êtes-vous sûr de vouloir effacer toutes les données de réserve logicielle existantes ?";
L.SOFTRES_BROADCAST_CONFIRM = "Etes-vous sûr de vouloir diffuser vos données softres à tous les membres de votre groupe/raid ?";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "Cliquez ici pour voir les informations sur la réserve dure";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "Aucune information de réserve dure disponible";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "Aucun article n'est dur réservé";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "URL de la publication SR";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "Publier les SR manquants";
L.SOFTRES_FEATURE_MISSING = "Les informations sur les réserves matérielles ne sont pas disponibles car les réserves logicielles\nfournies n'ont pas été générées à l'aide du bouton 'Gargul Export' sur softres.it";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "Ce joueur n'a rien réservé !";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";

L.SOFTRES_IMPORT_INFO = "Pour commencer, vous devez d'abord créer un raid sur softres.it. Cliquez ensuite sur « Addon Export », sélectionnez « Gargul », copiez les données et collez-les dans le formulaire ci-dessous.";
L.SOFTRES_IMPORT_DETAILS = "Importé le |c00A79EFF%s|r à |c00A79EFF%s|r";
L.SOFTRES_IMPORT_INVALID = "Données de réserve logicielle non valides fournies";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Données non valides fournies. Assurez-vous de cliquer sur le bouton « Gargul Export » sur softres.it et collez le contenu complet ici";
L.SOFTRES_IMPORT_SUCCESSFUL = "Réserves logicielles importées avec succès";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "Importation réussie !";
L.SOFTRES_IMPORT_FIXED_NAME = "Correction automatique du nom : le SR de '%s' est désormais lié à '%s'";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "Les joueurs suivants n'ont rien réservé :";
L.SOFTRES_IMPORT_NEW_PLUSONES = "Les valeurs PlusOne fournies entrent en collision avec celles déjà présentes. Voulez-vous remplacer vos anciennes valeurs PlusOne ?";
L.SOFTRES_IMPORT_USE_GARGUL = "Les données SoftRes Weakaura et CSV sont obsolètes, utilisez plutôt l'exportation Gargul !";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "Cet article est hard-réservé";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "Pour : %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Remarque :|r %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Réservé par";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "Échec de la connexion à LootReserve, contactez l'assistance (inclure le message ci-dessous)";
L.SOFTRES_PROCESS_INCOMING = "Tentative de traitement des données SoftRes entrantes de %s";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "Impossible de traiter les données SoftRes reçues de %s";
L.SOFTRES_EVERYONE_RESERVED = "Tout le monde a rempli ses soft-reserves";
L.SOFTRES_NO_URL_AVAILABLE = "Aucune URL softres.it disponible, assurez-vous d'avoir exporté en utilisant le bouton 'Gargul Export' sur softres.it !";

--[[ AWARD ]]
L.AWARD_TOOLTIP_ADD_ITEM = "Glisser-déposer ou Maj+clic sur un élément dans la case de droite";
L.AWARD_RANDOM_CONFIRM = "Voulez-vous attribuer %s à un joueur aléatoire ?";
L.AWARD_CONFIRM = "Attribuer %s à %s ?";
L.AWARD_PLAYER_CUSTOM_NAME = "Tapez le nom du joueur ici";
L.AWARD_PLAYER_SELECT_NAME = "ou sélectionnez-en un ci-dessous";
L.AWARD_HEADER_IN_GROUP = "En groupe";
L.AWARD_UNDO_CONFIRM = "Etes-vous sûr de vouloir annuler %s attribué à %s ?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.AWARD_UNDO_BR_REFUND = "%s points de roulement boostés seront remboursés !";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Objets désenchantés :";
L.AWARD_TOOLTIP_GIVEN = "(Donné : oui)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(Donné : non)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(" .. L.OFFSPEC_ABBR .. ")";
L.AWARD_TOOLTIP_BR_INDICATION = "(BR : %s)";
L.AWARD_NEW_WINNER_CONFIRMATION = "À qui %s devrait-il s'adresser à la place ?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "Etes-vous sûr de vouloir désenchanter %s ? %s points de roulement boostés seront remboursés !";

--[[ THATSMYBIS /gl tmb ]]
L.TMB_CLEAR_CONFIRM = "Êtes-vous sûr de vouloir effacer toutes les données plus une ?";
L.TMB_BROADCAST_CONFIRM = "Êtes-vous sûr de vouloir diffuser vos données TMB à tous les membres de votre groupe/raid ? NB : TOUT LE MONDE peut voir vos données TMB quelles que soient ses autorisations sur le site de la TMB !";
L.TMB_IMPORT_DFT_INFO = "Exportez vos données DFT selon les instructions de la feuille. Collez ensuite le contenu tel quel dans la case ci-dessous et cliquez sur « Importer ». C'est ça!";
L.TMB_IMPORT_CPO_INFO = "Sur votre exécution classicpr.io, cliquez sur le bouton « Gargul Export » et copiez le contenu. Collez ensuite le contenu tel quel dans la case ci-dessous et cliquez sur « Importer ». C'est ça!";
L.TMB_IMPORT_TMB_INFO = "Collez le contenu de votre export TMB tel quel dans la case ci-dessous et cliquez sur 'Importer'.";
L.TMB_IMPORT_TMB_GARGUL_INFO = "Comment utiliser Gargul avec TMB";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Données TMB fournies non valides, assurez-vous de cliquer sur le bouton « Télécharger » dans la section Gargul et collez le contenu ici tel quel !";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Données TMB ou DFT fournies non valides. Assurez-vous de coller le contenu de l'exportation ici tel quel !";
L.TMB_IMPORT_INVALID_CSV = "CSV fourni non valide, le format est : 6948,player1,player2";
L.TMB_IMPORT_INVALID_DFT = "Données DFT fournies non valides. Exportez vos données DFT conformément aux instructions de la feuille et collez le contenu ici tel quel !";
L.TMB_IMPORT_PLAYER_NO_DATA = "Les joueurs suivants n'ont pas d'entrée %s :"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_PRIO_HEADER = "Liste prioritaire %s"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_WISHLIST_HEADER = "Liste de souhaits de la TMB";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(" .. L.OFFSPEC_ABBR .. ")";
L.TMB_TOOLTIP_TIER = "|c00FFFFFF Niveau :|r %s";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF Remarque :|r |cFFFFF569%s|r";
L.TMB_NO_BROADCAST_TARGETS = "Il n'y a personne dans votre groupe vers qui diffuser";
L.TMB_BROADCAST_PROCESS_START = "Tentative de traitement des données TMB entrantes de %s";
L.TMB_SYNCED = "Données TMB synchronisées";

--[[ VERSION /gl version ]]
L.VERSION_UPDATED = "|cff%sGargul|r est maintenant mis à jour vers |cff%sv%s|r";
L.VERSION_INVALID_WARNING = "Chaîne de version non valide fournie dans Version : addRelease";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul est obsolète et ne fonctionnera pas tant que vous n'aurez pas mis à jour !";
L.VERSION_UPDATE_AVAILABLE = "v|c00A79EFFv%s|r est disponible sur CurseForge/Wago. Vous pouvez mettre à jour sans fermer votre jeu, assurez-vous simplement de /reload !";
L.VERSION_UPDATE = "Mettez à jour Gargul !";

--[[ PACKMULE /gl pm ]]
L.PACKMULE_NO_DISENCHANTER_WARNING = "Aucun désenchanteur défini, utilisez /gl sd [mydisenchanter] pour en définir un";
L.PACKMULE_WHO_IS_DISENCHANTER = "Qui est ton désenchanteur ?";
L.PACKMULE_CONFIRM_DISENCHANTER = "Définir %s comme désenchanteur ?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "Envoyer %s à %s ? Tapez /gl cd pour supprimer ce désenchanteur !";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASSER";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "AVIDITÉ";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "BESOIN";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORER";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DE";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "FR";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "ALÉATOIRE";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SOI";

--[[ GDKP /gl gdkp ]]
L.GDKP = "GDKP";
L.GDKP_CUTS_ADJUST_G = "ajuster [g]";
L.GDKP_CUTS_ADJUST_P = "ajuster [%]";
L.GDKP_AUCTIONS = "Les enchères";
L.GDKP_CREATE = "Créer une nouvelle session GDKP";
L.GDKP_CREATE_SESSION_TYPE_LABEL = "Type d'enchère (|c00A79EFFi|r pour plus d'informations)";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFMulti-Auction|r vous permet de lancer des enchères sur plusieurs articles à la fois, accélérant ainsi les choses !
Suivez les instructions après avoir créé cette session pour commencer

Avec |c00A79EFFSingle-Auction|r, vous choisissez de mettre aux enchères des objets uniques à la place ou d'utiliser la file d'attente.

La sélection de |c00A79EFFMulti-Auction|r empêche l'ajout des éléments supprimés à la file d'attente.
Vous pouvez mélanger |c00A79EFFMulti-Auction|r avec |c00A79EFFSingle-Auction|r et la file d'attente mais nous vous le déconseillons fortement.

]];
L.GDKP_CREATE_SESSION_TYPE_MULTI = "Multi-enchères";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "Enchère unique";
L.GDKP_CREATE_MANAGEMENT_CUT = "% de réduction de la gestion";
L.GDKP_CREATE_SESSION_SWITCH = "Passer à cette session";
L.GDKP_CREATE_SESSION_INVALID_CUT = "Management Cut doit être vide ou compris entre 0 et 99 (pas de signe % !)";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "Choisissez un type de séance !";
L.GDKP_CREATE_SUCCESSFUL = "Séance créée. Nous vous conseillons de /reload pour qu'il soit correctement stocké au cas où votre jeu planterait !";
L.GDKP_AUCTION_PAID_AMOUNT = "Définir le montant payé (lire à gauche)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul garde automatiquement une trace de l'or échangé. Tant que les joueurs paient
pour ce qu'ils ont acheté, tu ne devrais jamais avoir besoin de ce champ

Le « montant payé » fait référence au montant d'or que l'acheteur vous a déjà échangé.
Cela ne change pas le prix réel de l’article !

Attention : ne définissez ici une valeur que si le joueur promet de payer
en dehors du raid ou échange l'or depuis un alt/mail etc !


]];
L.GDKP_SESSION_EDIT_TITLE = "Modification de %s";
L.GDKP_EXPORT_DEFAULT_HEADER = "Objet, Joueur, Or, Wowheadlink";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM,@GAGNANT,@GOLD,@WOWHEAD";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "Personnalisé (créez votre propre format)";
L.GDKP_EXPORT_AUCTIONS_JSON = "Détaillé (JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "Partager (peut être importé par d'autres joueurs)";
L.GDKP_EXPORT_CUSTOM_HEADER = "Votre en-tête personnalisé";
L.GDKP_EXPORT_CUSTOM_FORMAT = "Votre format personnalisé";
L.GDKP_EXPORT_FORMAT_TITLE = "Le titre de la session du GDKP";
L.GDKP_EXPORT_FORMAT_START = "Date/heure à laquelle le premier article a été attribué";
L.GDKP_EXPORT_POT_CHANGED = "Pot changé";
L.GDKP_IMPORT_SESSION = "Importer une session GDKP";
L.GDKP_IMPORT_SESSION_ABOUT = ("Here you can import (and continue) a GDKP session. In order to get a GDKP session from someone they need to export it in |c00FFF569/gdkp|r where they select the '%s' format"):format(L.GDKP_EXPORT_AUCTIONS_SHARE);
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "Cette session GDKP créée par %s semble déjà exister, souhaitez-vous la remplacer ?";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "Vous êtes sur le point d'importer une session GDKP créée par %s, êtes-vous sûr ?";

L.GDKP_IMPORT_PRICES_ABOUT = [[
Importez les prix minimum et les incréments du GDKP.

Le format est le suivant : ItemID + minimum ou incrément sont requis. (|c00BE3333NÉCESSITE UN EN-TÊTE !!|r) :

|c00BE3333ItemID,Minimum,Incrément|r|c00967FD2
18608,4000,500|r
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "Supprimer les paramètres de prix existants ? Cliquez sur oui pour supprimer toutes les données de prix, sur non pour simplement remplacer celles existantes par les données que vous avez fournies ici.";
L.GDKP_LEDGER_MUTATION = "Or %s par"; --%s = removed or added
L.GDKP_LEDGER_LEGEND_PAID_TO = "Or payé à %s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "Or reçu de %s";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "De l'or vous a été envoyé par %s";
L.GDKP_LEDGER_LEGEND_BALANCE = "Solde : |c0092FF000|r ? Tu es carré ! | |c00BE333330|r ? vous devez %s 30g | |c00F7922E50|r ? %s vous doit 50g";
L.GDKP_LEDGER_POT = "Pot total : %sg | Réduction de la gestion : %sg (%s%%) | À distribuer : %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s|r | Par %s%s | Sur |c00967FD2%s|r";

L.GDKP_OVERVIEW_POT_TOOLTIP = [[
Casserole : %s
Réduction de la gestion (%s%%) : %sg
Coupe par joueur (1/%s) : %sg
]];
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "Enchères multiples : mettez aux enchères plusieurs objets à la fois !";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "Verrouiller ou déverrouiller la session";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "Débloquez la session";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "Verrouiller la session pour le paiement";
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "Ajouter/Supprimer de l'or";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = "Vous avez besoin d'un butin principal ou principal pour ajuster l'or.\nVous ne pouvez pas ajuster l'or sur les sessions verrouillées/supprimées.";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = "Affichez un aperçu complet du grand livre,\nidéal à des fins de capture d'écran !";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "Les sessions auxquelles sont attachées des enchères seront supprimées après 48 heures.";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "Importer une session depuis un autre joueur ou compte";
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "Exportez une session pour que d'autres puissent voir les détails de la session ou même vous remplacer en tant que maître du butin";
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "Débloquer et modifier le pot ou les coupes peut s'avérer très compliqué, surtout si vous avez déjà effectué des paiements. Es-tu sûr?";
L.GDKP_OVERVIEW_LOCK_CONFIRM = "Verrouiller une session signifie que vous ne pouvez pas mettre d'objets aux enchères ou modifier quoi que ce soit jusqu'à ce que vous la déverrouilliez, en êtes-vous sûr ?";
L.GDKP_OVERVIEW_SESSION_DETAILS = "Par %s%s | Le |c00%s%s|r%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_MUTATION_ADDED = "ajouté à";
L.GDKP_OVERVIEW_MUTATION_REMOVED = "retiré de";
L.GDKP_OVERVIEW_MUTATION_ENTRY = "|cFF%s%s|r %s pot par %s\nRemarque : %s"; -- i.e. 5000g added to pot by winner \n Note: I made a booboo
L.GDKP_OVERVIEW_AUCTION_ENTRY = "%s a payé |cFF%s%s|r pour\n%s"; -- i.e. Player paid 5000g for \n [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = "|cFFbe3333Supprimé par|r %s\nRaison : %s";
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "Indiquez la raison de la suppression de cette entrée";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "Supprimer. Maintenez Shift pour contourner la note";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = "Vous avez besoin d'un butin principal ou principal pour supprimer des entrées.\nVous ne pouvez pas supprimer des entrées sur des sessions verrouillées/supprimées.";
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = "Vous avez besoin d'un butin principal ou principal pour restaurer les entrées.\nVous ne pouvez pas restaurer les entrées des sessions verrouillées/supprimées.";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = "Vous avez besoin d'un butin principal ou principal pour modifier les entrées.\nVous ne pouvez pas modifier les entrées supprimées ou les entrées sur les sessions verrouillées/supprimées.";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(actif)";
L.GDKP_OVERVIEW_DELETED_SESSION = "(supprimé)";

L.GDKP_TUTORIAL_TITLE = "Commencer";
L.GDKP_TUTORIAL_INFO = "Suivez les étapes ci-dessous pour démarrer rapidement avec Gargul GDKP !";
L.GDKP_TUTORIAL_STEP_NEW = "Cliquez sur le bouton |c00FFF569New|r ci-dessous pour créer votre première session GDKP. Il s'affichera à gauche une fois créé";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "Activez cette session en cliquant sur le bouton |c00FFF569Enable|r ci-dessous !";
L.GDKP_TUTORIAL_STEP_READY = "Vous êtes prêt à vendre des objets ! |c00BE3333Lisez attentivement toutes les étapes ci-dessous et testez-les toutes|r par vous-même (pas besoin d'être dans un raid) avant de commencer votre premier raid GDKP !";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s|r un article pour mettre aux enchères ou mettre en file d'attente un seul article"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "Vous souhaitez mettre aux enchères plusieurs objets à la fois ? Exécutez |c00FFF569/gl ma|r (ou |c00FFF569/gl multiauction|r) ou cliquez sur l'icône multi-enchères en haut à droite de cette fenêtre !";
L.GDKP_TUTORIAL_STEP_SELL = "Vous souhaitez vendre un objet sans que personne n’enchérisse ? |c00FFF569%s|r sur un article, choisissez un gagnant et fixez un prix !";
L.GDKP_TUTORIAL_STEP_DONE = "Si tout s’est bien passé, vous verrez ici vos articles fraîchement mis aux enchères !";
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
Commandes utiles :
- |c00FFF569/gdkp|r pour ouvrir cette fenêtre
- |c00FFF569/gl ma|r pour ouvrir la fenêtre multi-enchères
- |c00FFF569/gl au|r pour ouvrir le commissaire-priseur/la file d'attente d'un seul objet
- |c00FFF569/gl pm|r pour configurer le pillage automatique

]];


L.GDKP_ADD_DROPS_TO_QUEUE = "Ajouter le butin abandonné à la file d'attente";
L.GDKP_ALL_CUTS_MAILED = "Toutes les coupes ont été postées !";
L.GDKP_TRY_MULTIAUCTION = "Découvrez les enchères multiples !";
L.GDKP_TRADE_EXCLUDE_GOLD = "Exclude from GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "L'or échangé ne sera pas ajouté au montant donné ou reçu";
L.GDKP_TRADE_GOLD_TO_GIVE = "À donner : %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "Pour recevoir : %s";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "Vous n'avez pas assez d'argent pour payer %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "Impossible d'ajouter %s à la fenêtre d'échange. Essayez de l'ajouter manuellement !";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP Session|r
Dépensé par le joueur : %s
Donné : %s
Reçu : %s
Joueur supprimé : %s

%s
]];
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP Données (vendu %sx)|r
Dernière vente pour : %s
Prix ​​moyen : %s
Enchère minimum : %s
Incrément : %s

]];
L.GDKP_ACTIVATED = "GDKP Actif !";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "En-tête manquant, attention : il est sensible à la casse !";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "En-tête manquant, attention : il est sensible à la casse !";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Or manquant pour le joueur %s";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Nom du joueur manquant";
L.GDKP_CUT_IMPORT_EMPTY = "Rien à importer, vérifiez votre CSV";
L.GDKP_ADD_GOLD_TITLE = "Ajuster l'or en %s";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "Or (- pour retirer l'or)";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "Payé par";
L.GDKP_ADD_GOLD_INVALID_WARNING = "L'or doit être inférieur/supérieur à 0";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "Qui paie pour ça ?";
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = "|cFF%s%sg|r ajouté au pot par %s\nRemarque : %s";
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = "%s a payé |cFF%s%sg|r pour\n%s";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = "|cFFbe3333Supprimé par|r %s\nRaison : %s";
L.GDKP_AUCTION_DETAILS_WON_BY = "Gagné par";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "Créé par";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "Désactiver pour les désenchantés";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "Désactiver au combat";

L.GDKP_BIDDER_ITEM_PRICING = "Enchère minimale : %sg Incrément : %sg";
L.GDKP_BIDDER_NEW_BID_LABEL = "Nouvelle offre";
L.GDKP_BIDDER_AUTO_BID = "Enchère automatique";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "Quelle est votre enchère maximale ? (%s minimum|c00FFF569g|r)";
L.GDKP_BIDDER_STOP_AUTO_BID = "Arrêter l'enchère automatique";
L.GDKP_BIDDER_BID_DENIED = "Offre refusée !";
L.GDKP_BIDDER_MY_MAX_BID = "(%sg maximum)";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "Meilleure enchère : %s de votre part";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "Enchère la plus élevée : %s par %s";

L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "ID d'élément inconnu : %s";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "Un minimum ou un incrément est requis pour l'ID d'élément : %s";
L.GDKP_PRICE_IMPORT_INVALID_INC = "'Incrément' non valide fourni pour l'ID d'élément '%s'";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "« Minimum » non valide fourni pour l'ID d'article « %s »";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "L'incrément ou le minimum ne peut pas être inférieur à 0,0001 !";
L.GDKP_AWARD_ITEM_CONFIRMATION = "Attribuer %s à %s pour %s ?";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Données importées avec succès pour %s éléments";
L.GDKP_STOP_AUCTION_FIRST = "Arrêtez d'abord les enchères !";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "Il n'y a pas assez d'or à distribuer, attendez-vous à des calculs de coupe bizarres !";
L.GDKP_NO_BIDS = "Aucune offre !";
L.GDKP_DELETE_BID_INFO = "Supprimer l'enchère. Les enchères doivent d'abord être arrêtées !";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "Aucune enchère sur l'article Légendaire+ détectée, continuez manuellement !";
L.GDKP_UNKNOWN_SESSION = "Identifiant de session inconnu dans l'enchère : créer : %s";
L.GDKP_LOCKED_SESSION = "La session GDKP n'est pas disponible ou verrouillée";
L.GDKP_MULTIAUCTION_OUTBID = "Vous avez surenchéri !";
L.GDKP_INVALID_DATA_FOR_START = "Données non valides fournies pour le début des enchères GDKP !";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "Données invalides fournies pour l'extension GDKP !";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "Données non valides fournies pour le raccourcissement du GDKP !";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "Données non valides fournies pour la reprogrammation du GDKP !";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "Heure non valide indiquée dans l'enchère : replanifier";
L.GDKP_MISSING_CONTENT_FOR_START = "Contenu manquant dans les enchères : début";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "L'utilisateur '%s' n'est pas autorisé à lancer des enchères";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "L'utilisateur '%s' n'est pas autorisé à arrêter les enchères";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "L'utilisateur '%s' n'est pas autorisé à arrêter l'enchère : enchère invalide";
L.GDKP_OUTBID = "Vous avez surenchéri !";
L.GDKP_INVALID_PAID_AMOUNT = "Numéro fourni non valide pour « payé »";
L.GDKP_AWARD_DIALOG_LABEL = "Prix ​​​​GDKP :";
L.GDKP_YOU_OWE = "Vous devez %s %s";
L.GDKP_THEY_OWE = "%s vous doit %s";

L.GDKP_MULTIAUCTION_ABOUT = [[

Avec les enchères multiples (ou enchères par lots), vous pouvez vendre aux enchères autant d'articles que vous le souhaitez à la fois !
Cela accélère considérablement vos nuits de raid et offre une expérience fluide à vos raiders.

Tous les objets échangeables encore dans votre inventaire peuvent être automatiquement mis aux enchères avec « Remplir à partir de l'inventaire »
Donner un coup de feu!

|c00808080Il n'y a qu'un seul inconvénient : pour que les gens puissent participer à une vente aux enchères par lots, les raiders auront besoin de Gargul !|r

]];
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "Annoncer les ventes dans le chat";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "Jouer du son en cas de surenchère";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "Plus d'options sonores...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "Afficher tout";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "Afficher les favoris";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "Masquer inutilisable";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "Afficher inutilisable";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "Afficher/Masquer les éléments que vous ne pouvez pas utiliser";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "Masquer les inactifs";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "Afficher inactif";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "Afficher/Masquer les enchères terminées";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "Avec cette fenêtre ouverte, %s éléments pour les ajouter à la liste";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "Fenêtre d'enchères fermée, utilisez |c00A79EFF/gl bid|r pour la rouvrir !";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "Ferme tout";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "Fermer TOUTES les enchères ?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
Fermer TOUTES les enchères

Les enchères avec des offres actives seront vendues et ne pourront pas recevoir de nouvelles offres !
]];
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "Donner un minuteur de dernier appel de combien de secondes ?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "Le nombre minimum de secondes est de 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = [[
Dernier appel sur TOUTES les enchères

Lancez un dernier appel pour toutes les enchères qui n'ont pas encore été vendues !
]];
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "Clôturer TOUTES les enchères et conclure cette session multi-enchères ?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
Terminer la session d'enchères multiples

Cela clôturera toutes les enchères et annoncera le pot total dans le chat.
Les enchères avec des offres actives seront vendues et ne pourront pas recevoir de nouvelles offres !
]];

L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "Mettre fin";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "Supprimer toutes les enchères et clôturer toutes les enchères ?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
Terminer la session d'enchères multiples

Cela supprimera toutes les enchères sur les articles qui n'ont pas encore été vendus et clôturera toutes les enchères !
]];
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "Désenchanter tous les objets finis mais invendus ?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
Désenchanter les invendus

Cela marquera tous les objets invendus comme désenchantés et ils n'apparaîtront pas dans une nouvelle session d'enchères multiples.
]];
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "Cliquez sur l'icône en forme de roue dentée pour gérer une enchère";
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "Passez la souris sur l'un des boutons ci-dessous pour plus d'informations";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "Cet article a été vendu. Utilisez le grand livre (|c00%s/gdkp|r) pour apporter des modifications !";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "Clôturez les enchères. Les joueurs ne peuvent plus enchérir mais l'enchère la plus élevée reste active";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "Lancez un dernier appel pour cette enchère en donnant un délai d'enchère (généralement plus court)";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "Effacer les enchères";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "Supprimer toutes les offres de l'enchère";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "Supprimez l'objet de l'enchère, y compris les détails de son offre. CELA NE PEUT PAS ÊTRE DÉFAITE !";
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "Favoriser cet article";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "Gérer les enchères";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "Arrêtez votre enchère automatique (%sg)";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "Enchérissez automatiquement jusqu'à l'enchère que vous remplissez à gauche";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "Enchère automatique jusqu'à un maximum de %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "Impossible d'arrêter les enchères automatiques sur %s, réessayez ou /reload !";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "Enchère invalide ou enchère trop basse ! Le minimum est %sg";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "L'enchère sur %s n'a pas pu être confirmée";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "Vous devez attendre deux secondes entre les enchères sur le même article";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "Vous êtes déjà le meilleur enchérisseur sur %s";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "Enchérissez sur le montant minimum requis";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = "|c00%sVENDU|r à\n%s pour |c00%s%sg|r";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = "|c00%sFERMÉ\nAucune offre|r";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = "Enchérir |c00%s%sg|r\nPar |c0092FF00VOUS!|r";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = "Enchère |c00%s%sg|r\nPar %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = "Minimum : |c00%s%sg|r\nIncrément : |c00%s%sg|r";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "Articles : %s - Total vendu : %sg - Mis en gage par moi : %sg";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
Articles avec enchères : %s/%s
Total vendu : %s
Acheté par moi : %s
Enchère totale (n'inclut pas les ventes) : %s
Enchère par moi (n'inclut pas les ventes) : %s
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "Clôturer les enchères";

L.GDKP_DISTRIBUTE_ADDRAIDER = "Ajouter un raider à cette session";
L.GDKP_MUTATOR_CREATE_NEW = "Créer un nouveau mutateur GDKP";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Stocker pour les prochaines sessions";
L.GDKP_MUTATOR_NAME_LABEL = "Nom [exemple : Chars]";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Pourcentage [exemple : 10]";
L.GDKP_MUTATOR_FLAT_LABEL = "Taux d'or forfaitaire [exemple : 250]";
L.GDKP_MUTATOR_APPLY_LABEL = "Appliquer automatiquement à";
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "Vous pouvez appliquer automatiquement ce mutateur aux raiders en utilisant des mots-clés :";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = "Exemple :\n|c00967FD2SELF,RL,HEALER|r";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Les noms de mutateurs ne peuvent pas contenir de points (.)";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "Le pourcentage doit être un nombre";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "Le forfait doit être un nombre";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "Le forfait doit être un nombre";
L.GDKP_MUTATOR_UNKNOWN = "Mutateur inconnu : %s";
L.GDKP_MAIL_ALL = "Envoyer tout";

L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "Joueur, Couper";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@JOUEUR,@CUT";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Personnalisé (créez votre propre format)";
L.AVAILABLE_PLACEHOLDER_VALUES = "Valeurs disponibles :";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "or total reçu du joueur";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "or total donné au joueur";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "l'or échangé au joueur";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "or envoyé au joueur";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "date/heure à laquelle le premier article a été attribué";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "date/heure à laquelle la session a été verrouillée";

L.GDKP_IMPORT_CUTS_INFO = "Vous pouvez importer des coupes de joueurs à partir de vos propres calculs comme une feuille Google. softres GDKP etc.\n\nLe format est le suivant (|c00BE3333INCLUEZ L'EN-TÊTE!!|r):\n\n|c00BE3333Player,Gold|r|c00967FD2\nPlayer1,4000\nPlayer2,4125\nPlayer3,3998\n\n\n|r";
L.GDKP_IMPORT_CONSEQUENCES_INFO = "Cela annulera toutes les modifications que vous avez apportées à la fenêtre coupée, en êtes-vous sûr ?";

L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "Vous ne pouvez pas donner ET recevoir de l'or du même joueur en même temps";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Or |c00967FD2donné à|r %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Or |c00967FD2reçu de|r %s";

--[[ MULTIAUCTION  /gl ma ]]
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "Vous êtes parti pendant votre séance d'enchères GDKP. Afin de le reprendre vous devez fournir un nouveau délai d'enchère (en secondes) pour les éventuels invendus.";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "Données non valides fournies pour le début des enchères GDKP !";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "Le maître du butin (%s) est obsolète, cela peut entraîner l'échec des enchères !";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s a acheté %s pour %sg";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "Avec cette fenêtre ouverte, %s articles pour les ajouter à la liste ou cliquez sur « Remplir depuis l'inventaire » ci-dessous"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "Vous devez avoir une session GDKP active (déverrouillée) !";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "Il y a une multi-enchère active, les articles que vous ajoutez ici seront ajoutés à la session existante. Attention aux éléments en double !";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Votre Gargul est obsolète, nous vous recommandons de le mettre à jour avant de démarrer une session pour éviter tout problème !";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Session GDKP active : |c00967FD2%s|r | Par %s%s | Sur |c00967FD2%s|r";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Rechercher un nom ou iLVL";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Prend en charge les noms d'éléments et iLVL, par ex. '252', '<252', etc.";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Durée des enchères en secondes";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Anti-snipe en quelques secondes";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Supprimer tous les éléments de la liste";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Ajoutez des objets échangeables de votre inventaire à la liste";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "Remplir à partir de l'inventaire";
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Étape suivante : vérifier la compatibilité de la version du module complémentaire de raider";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Sélectionnez au moins un article pour votre enchère";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "La durée de l'enchère en secondes doit être >= 10";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "La valeur anti-snipe doit être 0 (vide) ou >=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Retourner au sélecteur d'articles";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "Tout le monde n'utilise pas Gargul, êtes-vous sûr de vouloir lancer l'enchère ?";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "Tout le monde n'est pas à jour. Si vous rencontrez des problèmes, dites à vos raiders de se mettre à jour !";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Ici, vous déterminez quels articles inclure dans votre session multi-enchères

Utilisez le bouton |c00A79EFFFRemplir depuis l'inventaire|r ci-dessous pour ajouter des objets qui peuvent encore être échangés à la liste.
Chaque fois que vous effacez et rouvrez cette fenêtre, vos derniers paramètres de remplissage seront utilisés pour ajouter automatiquement des éléments.

|c00A79EFF%s|r éléments pour les ajouter manuellement à la liste
]];

L.GDKP_UNKNOWN_ITEM = "ID d'article inconnu dans l'enchère : créer : %s";

--[[ LOOT MASTER ]]
L.LOOTMASTER_DEFAULT_NOTE = "/roll pour MS ou /roll 99 pour OS";
L.LOOTMASTER_BAD_ADDONS = "Vous avez installé un ou plusieurs modules complémentaires qui peuvent potentiellement provoquer un dysfonctionnement de Gargul : %s";
L.LOOTMASTER_NOTICE_LABEL = "On vous a confié le rôle de Master Looter";
L.LOOTMASTER_OPEN_LABEL = "Ouvrir cette fenêtre automatiquement";
L.LOOTMASTER_CLEAR_SR_BUTTON = "Effacer SoftRes";
L.LOOTMASTER_IMPORT_SR_BUTTON = "Importer SoftRes";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "Effacer le TMB";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "Importer le TMB";

--[[ TRADE TIME ]]
L.TRADETIME_ROLL_HOWTO = "%s pour déployer le butin !";
L.TRADETIME_AWARD_HOWTO = "%s pour attribuer du butin !";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "Masquer tous les objets récompensés";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "Masquer les objets attribués à soi-même";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "Cacher les objets désenchantés";

--[[ BONUS FEATURES ]]
L.BONUS_AUTO_INVITE = "1. Inviter/trier automatiquement les groupes à partir de l'inscription au raid ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl gr|r";
L.BONUS_BOOSTED_ROLLS = "2. Récompensez les joueurs qui sont des habitués ou qui font un effort supplémentaire ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl br|r";
L.BONUS_PLUSONES = "3. Gargul comprend un système de suivi plus un ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl po|r";

--[[ RAID GROUPS /gl gr ]]
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = "Dans la grande zone d'édition ci-dessous, vous pouvez fournir une liste et : inviter tout le monde, vérifier qui manque, appliquer des groupes et attribuer les chars.\n\nVous pouvez fournir un lien |c00FFF569Wowhead composition de raid|r :";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "un |c00FFF569Raid-Helper export|r (Utilisez la variante 'Groupes triés verticalement') ou un |c00FFF569Composition de groupe Gargul|r CSV :";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Outil de compilation Wowhead";
L.RAIDGROUPS_WOWHEAD_INFO = "Vous pouvez visiter l'outil de compilation Wowhead en utilisant l'URL ci-dessous. Après avoir créé votre composition, vous pouvez la coller ici ou dans le grand champ d'édition de la fenêtre du groupe Gargul.";
L.RAIDGROUPS_GARGUL_BUTTON = "Wiki du Groupe Gargul";
L.RAIDGROUPS_GARGUL_INFO = "Visitez le wiki du groupe Gargul pour plus d'informations sur le format du groupe de raid.";
L.RAIDGROUPS_INVITE_BUTTON = "Inviter";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Envoyer des invitations aux joueurs inscrits sur la liste";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Qui manque";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Afficher les noms des joueurs manquants";
L.RAIDGROUPS_SORT_BUTTON = "Appliquer des groupes";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Trier les groupes en fonction de la liste";
L.RAIDGROUPS_TANK_BUTTON = "Attribuer des réservoirs";
L.RAIDGROUPS_PURGE_BUTTON = "Expulser les joueurs indésirables";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Expulser les joueurs qui ne sont pas sur la liste";
L.RAIDGROUPS_DISBAND_BUTTON = "Dissoudre le raid";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Dissoudre votre raid";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Données de groupe fournies non valides, vérifiez votre format !";
L.RAIDGROUPS_NO_RAID_WARNING = "Vous devez participer à un raid !";
L.RAIDGROUPS_SORT_IN_PROGRESS = "Le tri est toujours en cours, attendez un peu !";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s est répertorié deux fois sur la liste !";
L.RAIDGROUPS_IN_COMBAT_WARNING = "Impossible de trier les groupes pendant que %s est en combat !"; -- %s holds a player name
L.RAIDGROUPS_IMPOSTER_WARNING = "Les joueurs suivants ne font pas partie de la liste : %s";
L.RAIDGROUPS_NO_TANKS_WARNING = "Aucun réservoir défini";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "Vous ne trouvez pas de place pour %s, essayez-vous de mettre plus de 5 personnes dans 1 groupe ?";
L.RAIDGROUPS_TANKS_ASSIGNED = "Tous les réservoirs sont attribués";
L.RAIDGROUPS_SORTING_GROUPS = "Groupes de tri";
L.RAIDGROUPS_SORTING_ERROR = "Quelque chose s'est mal passé lors du déplacement de %s";
L.RAIDGROUPS_SORTING_FINISHED = "Fin de l'application de la liste de raid";

--[[ ROLLING /gl ro ]]
L.ROLLING_NOTE_LABEL = "NOTE";
L.ROLLING_TIMER_LABEL = "MINUTERIE(s)";
L.ROLLING_CLOSE_ON_START_LABEL = "Fermer au démarrage";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Clôture sur l'attribution";
L.ROLLING_SELECT_PLAYER_WARNING = "Vous devez d'abord sélectionner un joueur";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Maintenez Shift pour afficher la confirmation de récompense";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Maintenez Shift pour contourner la confirmation de récompense";
L.ROLLING_REOPEN_TOOLTIP = "Ouvrir la fenêtre du maître pilleur";
L.ROLLING_REOPEN_ROLL_COUNT = "lancers : %s";
L.ROLLING_ITEM_WON_GIVEN = "(élément donné : oui)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(élément donné : non)";
L.ROLLING_ITEM_WON_OS = "(" .. L.OFFSPEC_ABBR .. ")";
L.ROLLING_ITEM_WON_BR_COST = "(" .. L.BOOSTED_ROLLS_ABBR .. ": %s)";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "Un roll est actuellement en cours";
L.ROLLING_IDENTICAL_ROLL_WARNING = "Attention : un autre jet identique a été trouvé qui peut indiquer une égalité|r\n\n";
L.ROLLING_INVALID_START_DATA_WARNING = "Données invalides fournies pour le lancement !";
L.ROLLING_NO_ROLLOFF_WARNING = "Je ne peux pas arrêter le roll off, aucun roll off en cours";
L.ROLLING_ROLL_ACCEPTED = "Rouleau accepté !";
L.ROLLING_PASS_BUTTON = "Passer";
L.ROLLING_UNUSABLE_ITEM = "Vous ne pouvez pas utiliser cet objet !";
L.ROLLING_AWARD_CONFIRM = "Attribuer %s à %s ?";
L.ROLLING_WINNER_NOT_UNIQUE = "Le nom du gagnant n'est pas unique, sélectionnez le joueur à qui vous souhaitez attribuer %s";
L.ROLLING_ROLL_SR_COUNT = L.SOFTRES_ABBR .. " [%sx]";
L.ROLLING_ROLL_PRIOLIST = "Priorité [%s]";
L.ROLLING_ROLL_WISHLIST = "Souhait [%s]";

--[[ TRADE WINDOW / TRADE ]]
L.TRADE_ANNOUNCE = "Annoncer un échange";
L.TRADE_ANNOUNCE_INFO = "Annoncer les détails de l'échange au groupe ou dans /dire lorsque vous n'êtes pas dans un groupe";

L.SETTINGS_RESET_UI = "Réinitialiser l'interface utilisateur de Gargul";

--[[ CHANGELOG ]]
L.CHANGELOG_GETTING_STARTED = "Gargul rend la distribution du butin très simple, cliquez sur le bouton ci-dessous pour commencer !";
L.CHANGELOG_OPEN_GARGUL = "Gargul ouvert";
L.CHANGELOG_CONTRIBUTE = "Obtenez de l'aide ou partagez des idées sur notre Discord";
L.CHANGELOG_ENABLE_LABEL = "Activer le journal des modifications";

--[[ GROUP VERSION CHECK ]]
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "Télécharger sur CurseForge";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";

--[[ IDENTITY ]]
L.IDENTITY_INFO = "Visitez l'URL ci-dessous pour en savoir plus sur la personnalisation des GDKP Gargul.";
L.IDENTITY_TOOLTIP = "Votre logo ici ? Cliquez pour plus d'informations !";

--[[ IDENTITY ]]
L.MINIMAP_BUTTON_GARGUL = "Gargul ouvert";
L.MINIMAP_BUTTON_MULTIAUCTION = "Multi-enchères";
L.MINIMAP_BUTTON_LEDGER = "Grand livre GDKP";
L.MINIMAP_BUTTON_CUTS = "Réductions du GDKP";
L.MINIMAP_BUTTON_IMPORT = "Importer des données";
L.MINIMAP_BUTTON_EXPORT = "Exporter des données";
L.MINIMAP_BUTTON_AWARDED = "Historique du butin attribué";
L.MINIMAP_BUTTON_SETTING_INFO = "Modifier les paramètres dans la mini-carte |r /gl";

--[[ ASSIGN WITH GARGUL ]]
L.ASSIGN_GARGUL_INFO = "N'oubliez pas d'utiliser Gargul à la place\nsi vous souhaitez exporter le butin plus tard\n\n\n-- Faites un clic droit pour désactiver cette fenêtre --";

--[[ SHORTCUT KEYS ]]
L.KEYS_INFO = [[
Raccourcis clavier pour les objets Gargul

Déploiement : |c00A79EFF%s|r
Récompense : |c00A79EFF%s|r
Désenchanter : |c00A79EFF%s|r


-- Faites un clic droit pour désactiver cette fenêtre --
]];
