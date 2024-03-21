--[[
    You can test this locally by removing line 5:
    if (GetLocale() ~= "deDE") then return; end
]]
if (true or GetLocale() ~= "frFR") then return; end
local L = Gargul_L or {};

L.ABOUT = "À propos";
L.ALL_SETTINGS = "Tous les paramètres";
L.ANNOUNCE = "Annoncer";
L.ANTISNIPE = "Anti-snipe";
L.ANTISNIPE_EXPLANATION = [[

Une valeur anti-snipe de 10 signifie que toute enchère reçue avec
moins de 10 secondes restantes réinitialiseront la minuterie à 10 secondes.

Vous pouvez laisser ce champ vide ou le définir sur 0 pour désactiver complètement l'Anti-snipe.
Les valeurs anti-snipe inférieures à 5 ne sont pas prises en charge.

]];
L.ARE_YOU_SURE = "Es-tu sûr ?";
L.ASSIGN_GARGUL_INFO = [[
N'oubliez pas d'utiliser Gargul à la place
si vous souhaitez exporter le butin plus tard


-- Faites un clic droit pour désactiver cette fenêtre --]];
L.AUCTION = "Enchères";
L.AUCTIONEER = "Commissaire-priseur";
L.AUCTIONS = "Enchères";
L.AUTO = "Auto";
L.AUTO_AWARD = "Attribution auto"
L.AUTO_TRADE_OPTIONS = "Options échange auto";
L.AVAILABLE_PLACEHOLDER_VALUES = "Valeurs disponibles :";
L.AWARD = "Attribuer";
L.AWARDED_TO = "Attribué à";
L.AWARDED_TOOLTIP_BOOSTED_ROLL_COST = "LB : %s";
L.AWARDED_TOOLTIP_GDKP_COST = "Prix : %s";
L.AWARDED_TOOLTIP_GIVEN = "Donné : oui";
L.AWARDED_TOOLTIP_NOT_GIVEN = "Donné : non";
L.AWARDED_TOOLTIP_SECOND_BID = "2ème enchère : %s par %s";
L.AWARDED_YOU_WON = "Vous avez gagné";
L.AWARD_CONFIRM = "Attribuer %s à %s ?";
L.AWARD_DISENCHANT_BR_CONFIRMATION = "Etes-vous sûr de vouloir désenchanter %s ? %s points de lancer boosté seront remboursés !";
L.AWARD_HEADER_IN_GROUP = "En groupe";
L.AWARD_HISTORY = "Historique des attributions";
L.AWARD_NEW_WINNER_CONFIRMATION = "À qui %s devrait-il s'adresser à la place ?";
L.AWARD_PLAYER_CUSTOM_NAME = "Tapez le nom du joueur ici";
L.AWARD_PLAYER_SELECT_NAME = "ou sélectionnez-en un ci-dessous";
L.AWARD_RANDOM_CONFIRM = "Voulez-vous attribuer %s à un joueur aléatoire ?";
L.AWARD_TOOLTIP_ADD_ITEM = "Glisser-déposer ou Maj+clic sur un élément dans la case de droite";
L.AWARD_TOOLTIP_BR_INDICATION = "(LB : %s)";
L.AWARD_TOOLTIP_DISENCHANTED_ITEMS = "Objets désenchantés :";
L.AWARD_TOOLTIP_GIVEN = "(Donné : oui)";
L.AWARD_TOOLTIP_NOT_GIVEN = "(Donné : non)";
L.AWARD_TOOLTIP_OFFSPEC_INDICATION = "(+2)";
L.AWARD_UNDO_BR_REFUND = "%s points de lancer boosté seront remboursés !";
L.AWARD_UNDO_CONFIRM = "Etes-vous sûr de vouloir annuler %s attribué à %s ?%s"; -- The last %s is the content of L.AWARD_UNDO_BR_REFUND
L.BAGINSPECTOR_FAILED = "Échec de l'inspection des sacs : aucun rapport reçu";
L.BAGINSPECTOR_FINISHED = "Inspection terminée";
L.BAGINSPECTOR_START = "Début de l'inspection...";
L.BALANCE = "Différence";
L.BASE = "Base";
L.BASE64_DECODE_WARNING = "Impossible de décoder les données en base64. Assurez-vous de le copier/coller tel quel sans ajouter de caractères ou d'espaces supplémentaires !";
L.BID = "Enchère";
L.BIDS = "Enchères";
L.BIND_ON_EQUIP_ABBR = "LQE";
L.BONUS_AUTO_INVITE = "1. Inviter/trier automatiquement les groupes à partir de l'inscription au raid ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl gr";
L.BONUS_BOOSTED_ROLLS = "2. Récompensez les joueurs qui sont des habitués ou qui font un effort supplémentaire ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl br";
L.BONUS_FEATURE_EXPLANATION = "Gargul a quelques tours dans son sac que vous ne connaissez peut-être pas. Jetez un œil !";
L.BONUS_PLUSONES = "3. Gargul comprend un système de suivi des +1 ! Cliquez ci-dessous ou utilisez |c00A79EFF/gl po";
L.BOOSTED_ROLLS = "Lancers de dés améliorés";
L.BOOSTED_ROLLS_ABBR = "LA";
L.BOOSTED_ROLLS_ADD_POINTS_CONFIRM = [[
Ajoutez combien de points pour tous ceux qui participent actuellement au raid ?

|c00BE3333Utilisez d'abord le bouton « Ajouter des raideurs manquants » si vous souhaitez que tout le monde obtienne des points, même ceux qui n'ont pas d'entrée améliorée !]];
L.BOOSTED_ROLLS_ADD_POINTS_ERROR = "Aucune valeur en points fournie !";
L.BOOSTED_ROLLS_ADD_POINTS_TO_RAID_BUTTON = "Ajouter des points au raid";
L.BOOSTED_ROLLS_ADD_RAIDERS_BUTTON = "Ajouter les raiders manquants";
L.BOOSTED_ROLLS_ALIASES = "Alias";
L.BOOSTED_ROLLS_ALIAS_APPLY_BUTTON = "Appliquer des alias";
L.BOOSTED_ROLLS_AWARD_DIALOG_LABEL = "Coût du lancer amélioré :";
L.BOOSTED_ROLLS_BROADCAST_CONFIRM = "Êtes-vous sûr de vouloir diffuser vos données de lancers améliorés à tous les membres de votre groupe/raid ?";
L.BOOSTED_ROLLS_BROADCAST_NO_DATA_ERROR = "Rien à diffuser, importez d'abord les données de lancers améliorés !";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_FAILED = "Impossible de traiter les données de lancers améliorés reçues de %s";
L.BOOSTED_ROLLS_BROADCAST_PROCESS_START = "Tentative de traitement des données de lancers améliorés entrantes provenant de %s";
L.BOOSTED_ROLLS_CLEAR_CONFIRM = "Etes-vous sûr de vouloir effacer toutes les données de lancers améliorés ?";
L.BOOSTED_ROLLS_DELETE_CONFIRM = "Supprimer %s ?";
L.BOOSTED_ROLLS_IMPORT_CONFIRM = "Etes-vous sûr de vouloir effacer vos données de lancers améliorés existantes et importer de nouvelles données diffusées par %s ?";
L.BOOSTED_ROLLS_IMPORT_ERROR = "Données non valides fournies. Assurez-vous que le contenu suit le format requis et qu'aucune ligne d'en-tête n'est incluse.";
L.BOOSTED_ROLLS_IMPORT_TUTORIAL = [[
Ici, vous pouvez importer des données de lancers améliorés et des alias à partir d'un tableau au format CSV ou TSV ou collés à partir d'une feuille Google Docs.

Le tableau nécessite au moins deux colonnes : Le nom du joueur suivi du nombre de points. Les colonnes supplémentaires sont facultatives et peuvent contenir des alias pour le joueur.
Voici un exemple de ligne :

Foobar,240,Barfoo]];
L.BOOSTED_ROLLS_POINTS = "Points";
L.BOOSTED_ROLLS_RESERVE = "Réserve";
L.BOOSTED_ROLLS_UPDATE_CONFIRM = [[
Etes-vous sûr de vouloir mettre à jour vos lancers améliorés existants avec les données de %s ?

Votre dernière mise à jour était sur |c00A79EFF%s, la leur sur |c00A79EFF%s.]];
L.BOOSTED_ROLLS_WHISPER_PREFIXES = "!bonus|!br|!la";
L.BROADCAST = "Diffuser";
L.BROADCASTING_NOTIFICATION = "Diffusion...";
L.BROADCAST_DELAYED_BY_COMBAT = "Vous êtes actuellement en combat, la diffusion est reportée";
L.BROADCAST_FINISHED = "Diffusion terminée !";
L.BROADCAST_INC_AWARDED = "Inclure les objets attribués";
L.BROADCAST_INC_DISENCHANTED = "Inclure les objets désenchantés";
L.BROADCAST_INC_HIDDEN = "Inclure les éléments masqués";
L.BROADCAST_INC_TIME_LEFT = "Inclure le temps restant";
L.BROADCAST_IN_PROGRESS_ERROR = "Diffusion toujours en cours";
L.BROADCAST_NO_DATA = "Il n'y a rien à diffuser";
L.BROADCAST_NUMBER_OF_ITEMS = "Nombre d'objets";
L.BROADCAST_TARGET_PLAYER = "Joueur ciblé (chuchotement uniquement)";
L.BROADCAST_TARGET_REQUIRED = "Chuchoter nécessite un joueur ciblé";
L.BROADCAST_TRADE_TIME_LEFT = "Temps de transaction maximum restant (en minutes)";
L.BY = "par"; -- As in 'bid BY'
L.CANCEL = "Annuler";
L.CHANGELOG_CONTRIBUTE = "Obtenez de l'aide ou partagez des idées sur notre Discord";
L.CHANGELOG_ENABLE_LABEL = "Activer le journal des modifications";
L.CHANGELOG_GETTING_STARTED = "Gargul rend la distribution du butin très simple, cliquez sur le bouton ci-dessous pour commencer !";
L.CHANGELOG_OPEN_GARGUL = "Ouvrir Gargul";
L.CHANGE_SCALE = "Ajuster l'échelle";
L.CHANNEL = "Canal";
L.CHANNEL_OFFICER = "Officier";
L.CHANNEL_RAID_WARNING = "Avertissement de raid";
L.CHANNEL_WHISPER = "Chuchoter";
L.CLASSICPRIO_ABBR = "RCR";
L.CLEAR = "Effacer"; -- As in clearing a window or data
L.CLOSE = "Fermer";
L.CLOSE_ON_AWARD = "Fermer à l'attribution";
L.CLOSE_ON_START = "Fermer au démarrage";
L.COMMUNICATION = "Communication";
L.COMM_PROGRESS = "Envoyé %s sur %s octets";
L.COPPER_INDICATOR = "pc";
L.CUT = "Part";
L.CUTS = "Parts";
L.CUT_MAILBOX_CLOSED = "Impossible d'envoyer du courrier lorsque la boîte aux lettres est fermée";
L.CUT_MAILS_FAILED = "Plusieurs erreurs de courrier détectées, abandonnant la distribution des parts";
L.CUT_MAIL_BODY = "Propulsé par Gargul : un outil de maître du butin prenant en charge TMB, SoftRes, GDKP et Auto-Looting !";
L.CUT_MAIL_EVEN = "Vous ne devez pas d'or à %s";
L.CUT_MAIL_FAILED = "Échec de l'envoi de la part à %s";
L.CUT_MAIL_GOLD_MISMATCH = "Mail ENVOYÉ selon le jeu, mais votre OR restant NE CORRESPOND PAS, quelque chose s'est mal passé ?";
L.CUT_MAIL_HISTORY = "Historique du courrier pour |c00967FD2%s";
L.CUT_MAIL_INSUFFICIENT_FUNDS = "Vous n'avez pas assez d'or pour payer %s";
L.CUT_MAIL_IN_PROGRESS = "Attendez un peu, nous sommes toujours en train de traiter le mail précédent";
L.CUT_MAIL_SUBJECT = "Gargul GDKP : %sg";
L.CUT_SENT = "Envoyé %sg à %s";
L.DATE_FORMAT = "%Y-%m-%d";
L.DATE_HOURS_MINUTES_FORMAT = "%Y-%m-%d %H:%M";
L.DAY_MONTH_HOURS_MINUTES = "%d-%m %H:%M";
L.DELETE = "Supprimer";
L.DETAILS = "Détails";
L.DFT = "DFT";
L.DISABLE = "Désactiver";
L.DISCORD_URL = "https://discord.gg/D3mDhYPVzf";
L.DISENCHANT = "Désenchanter";
L.EDIT = "Modifier";
L.ENABLE = "Activer";
L.EXPORT = "Exporter";
L.EXPORT_DELETE_ALL_CONFIRM = "Êtes-vous sûr de vouloir supprimer l'intégralité de votre tableau d'historique des attributions ? Cela supprime TOUTES les données de butin et ne peut pas être annulé !";
L.EXPORT_DELETE_DATE_CONFIRM = "Êtes-vous sûr de vouloir supprimer toutes les données de %s ? Ça ne peut pas être annulé!";
L.EXPORT_READ_ONLY_NOTICE = [[
Il s'agit UNIQUEMENT d'une fonctionnalité d'exportation, il ne sert à rien de modifier les valeurs : ELLES NE SERONT PAS SAUVEGARDÉES !

]];
L.FILL = "Remplir";
L.FINAL_CALL = "Dernier appel";
L.FINISH = "Terminer";
L.FORMAT = "Format";
L.GARGUL = "Gargul";
L.GDKP = "GDKP";
L.GDKPS_ARE_NOT_ALLOWED = "Les raids GDKP ne sont pas autorisés dans cette version de World of Warcraft";
L.GDKP_ACTIVATED = "GDKP Actif !";
L.GDKP_ADD_DROPS_TO_QUEUE = "Ajouter le butin tombé à la file d'attente";
L.GDKP_ADD_GOLD_AMOUNT_LABEL = "Or (- pour retirer de l'or)";
L.GDKP_ADD_GOLD_INVALID_PAYER_WARNING = "Qui paie pour ça ?";
L.GDKP_ADD_GOLD_INVALID_WARNING = "L'or doit être inférieur/supérieur à 0";
L.GDKP_ADD_GOLD_PAID_BY_LABEL = "Payé par";
L.GDKP_ADD_GOLD_TITLE = "Ajuster l'or en %s";
L.GDKP_ADD_TRADE_GIVEN_AND_RECEIVED_WARNING = "Vous ne pouvez pas donner ET recevoir de l'or du même joueur en même temps";
L.GDKP_ALL_CUTS_MAILED = "Toutes les parts ont été postées !";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_FOR_DISENCHANTED = "Désactiver pour les désenchantés";
L.GDKP_AUCTIONEER_SETTINGS_DISABLE_IN_COMBAT = "Désactiver en combat";
L.GDKP_AUCTIONS = "Enchères";
L.GDKP_AUCTION_DETAILS_CREATED_BY = "Créé par";
L.GDKP_AUCTION_DETAILS_DELETED_REASON = [[
|c00be3333Supprimé par %s
Motif]];
L.GDKP_AUCTION_DETAILS_GOLD_ADDED = [[
|c00%s%spo ajouté au pot par %s
Remarques]];
L.GDKP_AUCTION_DETAILS_GOLD_PAID_BY = [[
%s a payé |c00%s%spo pour
%s]];
L.GDKP_AUCTION_DETAILS_WON_BY = "Gagné par";
L.GDKP_AUCTION_PAID_AMOUNT = "Définir montant payé (lire à gauche)";
L.GDKP_AUCTION_PAID_AMOUNT_INFO = [[

Gargul garde automatiquement une trace de l'or échangé. Tant que les joueurs paient
pour ce qu'ils ont acheté, vous ne devriez jamais avoir besoin de ce champ

Le « montant payé » fait référence au montant d'or que l'acheteur vous a déjà échangé.
Cela ne change pas le prix réel de l'objet !

Attention : ne définissez ici une valeur que si le joueur promet de payer
en dehors du raid ou échange l'or depuis un reroll/mail etc !


]];
L.GDKP_AWARD_DIALOG_LABEL = "Prix ​​​​GDKP :";
L.GDKP_AWARD_ITEM_CONFIRMATION = "Attribuer %s à %s pour %s ?";
L.GDKP_BIDDER_AUTO_BID = "Enchère auto";
L.GDKP_BIDDER_AUTO_BID_CONFIRM = "Quelle est votre enchère maximale ? (%s minimum|c00FFF569g)";
L.GDKP_BIDDER_BID_DENIED = "Enchère refusée !";
L.GDKP_BIDDER_ITEM_PRICING = "Enchère minimale : %spo Incrément : %spo";
L.GDKP_BIDDER_MY_MAX_BID = "(%spo maximum)";
L.GDKP_BIDDER_NEW_BID_LABEL = "Nouvelle enchère";
L.GDKP_BIDDER_STOP_AUTO_BID = "Arrêter enchère auto";
L.GDKP_BIDDER_THEYRE_TOP_BIDDER = "Enchère la plus élevée : %s par %s";
L.GDKP_BIDDER_YOURE_TOP_BIDDER = "Meilleure enchère : %s de votre part";
L.GDKP_CREATE = "Créer une nouvelle session GDKP";
L.GDKP_CREATE_MANAGEMENT_CUT = "% de part d'organisation";
L.GDKP_CREATE_SESSION_INVALID_CUT = "La part d'organisation doit être vide ou comprise entre 0 et 99 (pas de signe % !)";
L.GDKP_CREATE_SESSION_INVALID_TYPE = "Choisissez un type de session !";
L.GDKP_CREATE_SESSION_SWITCH = "Passer à cette session";
L.GDKP_CREATE_SESSION_TYPE_INFO = [[

|c00A79EFFMulti-enchères vous permet de lancer des enchères sur plusieurs objets à la fois, accélérant ainsi les choses !
Suivez les instructions après avoir créé cette session pour commencer

Avec |c00A79EFFEnchère unique, vous choisissez plutôt de mettre aux enchères des objets uniques ou d'utiliser la file d'attente

La sélection de |c00A79EFFMulti-enchères empêche l'ajout des objets tombés à la file d'attente.
Vous pouvez mélanger |c00A79EFFMulti-enchères avec |c00A79EFFEnchère unique et la file d'attente mais nous vous le déconseillons fortement.

]];
L.GDKP_CREATE_SESSION_TYPE_LABEL = "Type d'enchère (|c00A79EFFi pour plus d'infos)";
L.GDKP_CREATE_SESSION_TYPE_MULTI = "Multi-enchères";
L.GDKP_CREATE_SESSION_TYPE_SINGLE = "Enchère unique";
L.GDKP_CREATE_SUCCESSFUL = "Session créée. Nous vous conseillons de /reload pour qu'elle soit correctement stockée au cas où votre jeu planterait !";
L.GDKP_CUTS_ADD_RAIDER = "Ajouter raideur";
L.GDKP_CUTS_ADJUST_G = "ajuster [po]";
L.GDKP_CUTS_ADJUST_P = "ajuster [%]";
L.GDKP_CUTS_ANNOUNCE_TOOLTIP = "Annoncer la part de base dans la discussion de groupe";
L.GDKP_CUTS_CLEAR_CONFIRMATION = "Etes-vous sûr de vouloir réinitialiser tous les joueurs et calculs ? Attention : tous les joueurs qui ne sont plus dans le raid seront supprimés de la liste !";
L.GDKP_CUTS_DELETE_RAIDER = "Supprimer le raideur";
L.GDKP_CUTS_EDIT_RAIDER = "Modifier le raideur";
L.GDKP_CUTS_LOCK_TOOLTIP = "Verrouiller & payer";
L.GDKP_CUTS_MANAGE_TRADES_TOOLTIP = "Gérer les échanges d'or";
L.GDKP_CUTS_MUTATORS_EXPLANATION = [[

Avec les mutateurs, vous pouvez donner plus ou moins d'or aux joueurs
Exemple : donner 2 % de plus aux tanks, c'est à cela que servent les mutateurs !

Remarque : La modification ou la suppression de mutateurs ici ne les modifie que pour cette session.

]];
L.GDKP_CUTS_NOT_IN_RAID_HEADER = "Pas dans le raid";
L.GDKP_CUTS_POT_EXPLANATION = [[

Le paiement total peut différer légèrement du pot en raison de différences d'arrondi !
Les joueurs actuellement dans le raid ne peuvent pas être modifiés ou supprimés !

Légende des couleurs :
|c00F7922E(2000po) signifie que vous devez à cette personne 2000po
|c00BE3333(3000po) signifie que cette personne vous doit 3000po
|c0092FF00(0) signifie que vous êtes quittes

Explication de l'ajusteur :
Avec un ajusteur [po] vous pouvez ajouter/déduire de l'or à un joueur (utilisez -50 pour déduire 50po de la part d'un joueur)
Avec un ajusteur [%] vous pouvez ajouter/déduire un pourcentage à un joueur (utilisez -50 pour donner la moitié d'une part)
]];
L.GDKP_CUTS_SUMMARY = "%s Raideurs | %s Avec part | Paiement total : %spo";
L.GDKP_CUT_IMPORT_EMPTY = "Rien à importer, vérifiez votre CSV";
L.GDKP_CUT_IMPORT_MISSING_GOLD = "Or manquant pour le joueur %s";
L.GDKP_CUT_IMPORT_MISSING_HEADER = "En-tête manquant, attention : il est sensible à la casse !";
L.GDKP_CUT_IMPORT_MISSING_PLAYER = "Nom du joueur manquant";
L.GDKP_DELETE_BID_INFO = "Supprimer l'enchère. Les enchères doivent d'abord être arrêtées !";
L.GDKP_DISTRIBUTE_ADDRAIDER = "Ajouter un raideur à cette session";
L.GDKP_EXPORT_AUCTIONS_CUSTOM = "Personnalisé (créez votre propre format)";
L.GDKP_EXPORT_AUCTIONS_JSON = "Détaillé (JSON)";
L.GDKP_EXPORT_AUCTIONS_SHARE = "Partager (peut être importé par d'autres joueurs)";
L.GDKP_EXPORT_CUSTOM_FORMAT = "Votre format personnalisé";
L.GDKP_EXPORT_CUSTOM_HEADER = "Votre en-tête personnalisé";
L.GDKP_EXPORT_CUTS_CUSTOM_FORMAT = "Personnalisé (créez votre propre format)";
L.GDKP_EXPORT_CUTS_DEFAULT_FORMAT = "@PLAYER,@CUT";
L.GDKP_EXPORT_CUTS_DEFAULT_HEADER = "Joueur, Part";
L.GDKP_EXPORT_CUTS_FORMAT_END_INFO = "date/heure à laquelle la session a été verrouillée";
L.GDKP_EXPORT_CUTS_FORMAT_GIVEN_INFO = "or total donné au joueur";
L.GDKP_EXPORT_CUTS_FORMAT_MAILED_INFO = "or envoyé au joueur";
L.GDKP_EXPORT_CUTS_FORMAT_RECEIVED_INFO = "or total reçu du joueur";
L.GDKP_EXPORT_CUTS_FORMAT_START_INFO = "date/heure à laquelle le premier objet a été attribué";
L.GDKP_EXPORT_CUTS_FORMAT_TRADED_INFO = "or échangé au joueur";
L.GDKP_EXPORT_DEFAULT_FORMAT = "@ITEM,@WINNER,@GOLD,@WOWHEAD";
L.GDKP_EXPORT_DEFAULT_HEADER = "Objet, Joueur, Or, Wowheadlink";
L.GDKP_EXPORT_FORMAT_START = "Date/heure à laquelle le premier objet a été attribué";
L.GDKP_EXPORT_FORMAT_TITLE = "Titre de la session du GDKP";
L.GDKP_EXPORT_POT_CHANGED = "Pot changé";
L.GDKP_HIDE_UPCOMING_CONFIRMATION = "Êtes-vous sûr? Vous ne pourrez ni voir ni enchérir sur les objets à venir !";
L.GDKP_IMPORT_CONSEQUENCES_CROSS_REALM = [[
|c00BE3333!! ATTENTION !!|r

Vous êtes sur un royaume connecté et importez des noms de joueurs sans
un suffixe de domaine, '%s' par exemple. Cela peut vous amener à envoyer
des parts et poster des parts au mauvais joueur.

Lorsque vous êtes sur un royaume connecté, essayez toujours d'inclure le nom du royaume des joueurs !

Continuer l'importation ?
]];
L.GDKP_IMPORT_CONSEQUENCES_INFO = "Cela annulera toutes les modifications que vous avez apportées à la fenêtre de parts, en êtes-vous sûr ?";
L.GDKP_IMPORT_CUTS_INFO = [[
Vous pouvez importer les parts de joueurs à partir de vos propres calculs comme une feuille Google. softres GDKP etc.

Le format est le suivant (|c00BE3333INCLUDE THE HEADER !!) :

|c00BE3333Player,Gold|c00967FD2
Joueur1,4000
Joueur2,4125
Joueur3,3998


]];
L.GDKP_IMPORT_PRICES_ABOUT = [[
Importez les prix minimum et les incréments du GDKP.

Le format est le suivant : ItemID + minimum ou incrément sont requis. (|c00BE3333NÉCESSITE UN EN-TÊTE !!) :

|c00BE3333ItemID,Minimum,Increment|c00967FD2
18608,4000,500
]];
L.GDKP_IMPORT_PRICES_CONFIRM = "Supprimer les paramètres de prix existants ? Cliquez sur oui pour supprimer toutes les données de prix, sur non pour simplement remplacer celles existantes par les données que vous avez fournies ici.";
L.GDKP_IMPORT_SESSION = "Importer une session GDKP";
L.GDKP_IMPORT_SESSION_ABOUT = "Ici, vous pouvez importer (et continuer) une session GDKP. Afin d'obtenir une session GDKP de quelqu'un, il doit l'exporter dans |c00FFF569/gdkp où il sélectionne le format « Partager (peut être importé par d'autres joueurs) »";
L.GDKP_IMPORT_SESSION_CREATE_CONFIRM = "Vous êtes sur le point d'importer une session GDKP créée par %s, êtes-vous sûr ?";
L.GDKP_IMPORT_SESSION_UPDATE_CONFIRM = "Cette session GDKP créée par %s semble déjà exister, souhaitez-vous la remplacer ?";
L.GDKP_INVALID_DATA_FOR_EXTENSION = "Données invalides fournies pour l'extension GDKP !";
L.GDKP_INVALID_DATA_FOR_RESHEDULE = "Données non valides fournies pour la reprogrammation du GDKP !";
L.GDKP_INVALID_DATA_FOR_SHORTENING = "Données non valides fournies pour le raccourcissement du GDKP !";
L.GDKP_INVALID_DATA_FOR_START = "Données non valides fournies pour le début des enchères GDKP !";
L.GDKP_INVALID_PAID_AMOUNT = "Numéro fourni non valide pour « payé »";
L.GDKP_INVALID_TIME_IN_RESHEDULE = "Heure non valide indiquée dans Auction:reschedule";
L.GDKP_ITEM_SALE_HISTORY_TOOLTIP = [[

|c00967FD2GDKP Données (vendu %sx)
Dernière vente pour : %s
Prix moyen : %s
Enchère minimum : %s
Incrément : %s

]];
L.GDKP_LEDGER_LEGEND_BALANCE = "Solde : |c0092FF000 ? Tu es quitte ! | |c00BE333330 ? vous devez %s 50g | |c00F7922E50 ? %s vous doit 50g";
L.GDKP_LEDGER_LEGEND_MAILED_FROM = "De l'or vous a été envoyé par %s";
L.GDKP_LEDGER_LEGEND_PAID_TO = "Or payé à %s";
L.GDKP_LEDGER_LEGEND_RECEIVED_FROM = "Or reçu de %s";
L.GDKP_LEDGER_MUTATION = "Or %s par"; -- %s = removed or added
L.GDKP_LEDGER_POT = "Pot total : %spo | Part organisation : %spo (%s%%) | À distribuer : %sg";
L.GDKP_LEDGER_SESSION_BY = "|c00967FD2%s | Par %s%s | Le |c00967FD2%s";
L.GDKP_LOCKED_SESSION = "La session GDKP n'est pas disponible ou verrouillée";
L.GDKP_MAIL_ALL = "Envoyer tout";
L.GDKP_MANUAL_ACTION_ON_LEGENDARY = "Aucune enchère sur objet légendaire+ détectée, continuez manuellement !";
L.GDKP_MISSING_CONTENT_FOR_START = "Contenu manquant dans les Auction:start";
L.GDKP_MULTIAUCTION_ABOUT = [[

Avec les enchères multiples (ou enchères par lots), vous pouvez vendre aux enchères autant d'objets que vous le souhaitez à la fois !
Cela accélère considérablement vos soirées de raid et offre une expérience fluide à vos raideurs.

Tous les objets échangeables encore dans votre inventaire peuvent être automatiquement mis aux enchères avec « Remplir à partir de l'inventaire »
En avant !

|c00808080Il n'y a qu'un seul inconvénient : pour que les gens puissent participer à une vente aux enchères par lots, les raideurs auront besoin de Gargul !

]];
L.GDKP_MULTIAUCTION_AUCTIONEER_ACTIVE_SESSION_WARNING = "Vous devez avoir une session GDKP active (déverrouillée) !";
L.GDKP_MULTIAUCTION_AUCTIONEER_ADD_ITEM = "Avec cette fenêtre ouverte, %s les objets pour les ajouter à la liste ou cliquez sur « Remplir depuis l'inventaire » ci-dessous"; -- %s holds the add item hotkey (default ALT_CLICK)
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_LABEL = "Anti-snipe en secondes";
L.GDKP_MULTIAUCTION_AUCTIONEER_ANTI_SNIPE_WARNING = "La valeur anti-snipe doit être 0 (vide) ou >=5";
L.GDKP_MULTIAUCTION_AUCTIONEER_CANCEL_TOOLTIP = "Retourner au sélecteur d'objets";
L.GDKP_MULTIAUCTION_AUCTIONEER_CLEAR_TOOLTIP = "Supprimer tous les objets de la liste";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_BUTTON = "Remplir à partir de l'inventaire";
L.GDKP_MULTIAUCTION_AUCTIONEER_FILL_TOOLTIP = "Ajoutez des objets échangeables de votre inventaire à la liste";
L.GDKP_MULTIAUCTION_AUCTIONEER_INFO = [[
Ici, vous déterminez quels objets inclure dans votre session multi-enchères

Utilisez le bouton |c00A79EFFRemplir depuis l'inventaire ci-dessous pour ajouter des objets qui peuvent encore être échangés à la liste.
Chaque fois que vous effacez et rouvrez cette fenêtre, vos derniers paramètres de remplissage seront utilisés pour ajouter automatiquement des éléments.

|c00A79EFF%s les objets pour les ajouter manuellement à la liste
]];
L.GDKP_MULTIAUCTION_AUCTIONEER_NEXT_VERSION_CHECK_TOOLTIP = "Étape suivante : vérifier la compatibilité de la version de l'addon des raideurs";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_GARGUL_WARNING = "Tout le monde n'utilise pas Gargul, êtes-vous sûr de vouloir lancer l'enchère ?";
L.GDKP_MULTIAUCTION_AUCTIONEER_NO_ITEMS_WARNING = "Sélectionnez au moins un article pour votre enchère";
L.GDKP_MULTIAUCTION_AUCTIONEER_OUTDATED = "Votre Gargul est obsolète, nous vous recommandons de le mettre à jour avant de démarrer une session pour éviter tout problème !";
L.GDKP_MULTIAUCTION_AUCTIONEER_PLAYER_OUTDATED_WARNING = "Tout le monde n'est pas à jour. Si vous rencontrez des problèmes, dites à vos raiders de se mettre à jour !";
L.GDKP_MULTIAUCTION_AUCTIONEER_RUNNING_SESSION_WARNING = "Il y a une multi-enchère active, les articles que vous ajoutez ici seront ajoutés à la session existante. Attention aux éléments en double !";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_LABEL = "Rechercher un nom ou iLvl";
L.GDKP_MULTIAUCTION_AUCTIONEER_SEARCH_TOOLTIP = "Prend en charge les noms d'objets et iLvl, par ex. '252', '<252', etc.";
L.GDKP_MULTIAUCTION_AUCTIONEER_SESSION_DETAILS = "Session GDKP active : |c00967FD2%s | Par %s%s | Le |c00967FD2%s";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_LABEL = "Durée des enchères en secondes";
L.GDKP_MULTIAUCTION_AUCTIONEER_TIME_WARNING = "La durée de l'enchère en secondes doit être >= 10";
L.GDKP_MULTIAUCTION_CLAIM_RUNNING_SESSION = "Vous êtes parti pendant votre session d'enchères GDKP. Afin de le reprendre vous devez fournir un nouveau délai d'enchère (en secondes) pour les éventuels invendus.";
L.GDKP_MULTIAUCTION_CLIENT_ADD_ITEM = "Avec cette fenêtre ouverte, %s les objets pour les ajouter à la liste";
L.GDKP_MULTIAUCTION_CLIENT_ADMIN_INFO = "Cliquez sur l'icône en forme de roue dentée pour gérer une enchère";
L.GDKP_MULTIAUCTION_CLIENT_ALREADY_TOP = "Vous êtes déjà le meilleur enchérisseur sur %s";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_BID = [[
Enchère |c00%s%sg
Par %s]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_CLOSED = [[
|c00%sFERMÉE
Aucune offre]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_NO_BID = [[
Minimum : |c00%s%sg
Incrément : |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL = "Objets : %s - Total vendu : %spo - Promis par moi : %spo";
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_OVERALL_TOOLTIP = [[
Objets avec enchères : %s/%s
Total vendu : %s
Acheté par moi : %s
Enchère totale (n'inclut pas les ventes) : %s
Enchère par moi (n'inclut pas les ventes) : %s
]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_SOLD = [[
|c00%sVENDU à
%s pour |c00%s%sg]];
L.GDKP_MULTIAUCTION_CLIENT_AUCTION_STATUS_YOUR_BID = [[
Enchère |c00%s%sg
Par |c0092FF00VOUS !]];
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_STOP_FAILED = "Impossible d'arrêter les enchères automatiques pour %s, réessayez ou /reload !";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_GIVEN = "Enchère automatique jusqu'à un maximum de %spo";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_NONE = "Enchérissez automatiquement jusqu'à l'enchère que vous remplissez à gauche";
L.GDKP_MULTIAUCTION_CLIENT_AUTOBID_TOOLTIP_STOP = "Arrêtez votre enchère automatique (%spo)";
L.GDKP_MULTIAUCTION_CLIENT_BID_FAILED = "L'enchère sur %s n'a pas pu être confirmée";
L.GDKP_MULTIAUCTION_CLIENT_BID_INVALID = "Enchère invalide ou enchère trop basse ! Le minimum est %spo";
L.GDKP_MULTIAUCTION_CLIENT_BID_THROTTLE = "Vous devez attendre deux secondes entre les enchères sur le même objet";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS = "Effacer les enchères";
L.GDKP_MULTIAUCTION_CLIENT_CLEAR_BIDS_TOOLTIP = "Supprimer toutes les offres de l'enchère";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL = "Tout fermer";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_CONFIRM = "Fermer TOUTES les enchères ?";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_ALL_TOOLTIP = [[
Fermer TOUTES les enchères

Les enchères avec des offres actives seront vendues et ne pourront pas recevoir de nouvelles offres !
]];
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION = "Clôturer les enchères";
L.GDKP_MULTIAUCTION_CLIENT_CLOSE_AUCTION_TOOLTIP = "Clôturez les enchères. Les joueurs ne peuvent plus enchérir mais l'enchère la plus élevée reste active";
L.GDKP_MULTIAUCTION_CLIENT_DELETE_TOOLTIP = "Supprimez l'objet de l'enchère, y compris les détails de son offre. CELA NE PEUT PAS ÊTRE ANNULE !";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_CONFIRM = "Désenchanter tous les objets finis mais invendus ?";
L.GDKP_MULTIAUCTION_CLIENT_DISENCHANT_TOOLTIP = [[
Désenchanter les invendus

Cela marquera tous les objets invendus comme désenchantés et ils n'apparaîtront pas dans une nouvelle session d'enchères multiples.
]];
L.GDKP_MULTIAUCTION_CLIENT_FAVORITE_TOOLTIP = "Favoriser cet article";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_DIALOG = "Donner un minuteur de dernier appel de combien de secondes ?";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_MIN_5 = "Le nombre minimum de secondes est de 5";
L.GDKP_MULTIAUCTION_CLIENT_FINAL_CALL_TOOLTIP = "Lancez un dernier appel pour cette enchère en donnant un délai d'enchère (généralement plus court)";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_CONFIRM = "Clôturer TOUTES les enchères et conclure cette session multi-enchères ?";
L.GDKP_MULTIAUCTION_CLIENT_FINISH_TOOLTIP = [[
Terminer la session d'enchères multiples

Cela clôturera toutes les enchères et annoncera le pot total dans le chat.
Les enchères avec des offres actives seront vendues et ne pourront pas recevoir de nouvelles offres !
]];
L.GDKP_MULTIAUCTION_CLIENT_HIDE_INACTIVE = "Masquer les inactifs";
L.GDKP_MULTIAUCTION_CLIENT_HIDE_UNUSABLE = "Masquer inutilisable";
L.GDKP_MULTIAUCTION_CLIENT_INACTIVE_TOGGLE_TOOLTIP = "Afficher/Masquer les enchères terminées";
L.GDKP_MULTIAUCTION_CLIENT_MANAGE_AUCTION = "Gérer les enchères";
L.GDKP_MULTIAUCTION_CLIENT_MINBID_TOOLTIP = "Enchérissez sur le montant minimum requis";
L.GDKP_MULTIAUCTION_CLIENT_REOPEN_INFO = "Fenêtre d'enchères fermée, utilisez |c00A79EFF/gl bid pour la rouvrir !";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_ANNOUNCE_SALES = "Annoncer les ventes dans le chat";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_OUTBID_SOUND = "Jouer du son en cas de surenchère";
L.GDKP_MULTIAUCTION_CLIENT_SETTING_SOUND_OPTIONS = "Plus d'options sonores...";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_ALL = "Afficher tout";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_FAVORITES = "Afficher les favoris";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_INACTIVE = "Afficher inactif";
L.GDKP_MULTIAUCTION_CLIENT_SHOW_UNUSABLE = "Afficher inutilisable";
L.GDKP_MULTIAUCTION_CLIENT_SOLD_INFO = "Cet article a été vendu. Utilisez le grand livre (|c00%s/gdkp) pour apporter des modifications !";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE = "Terminer";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_CONFIRM = "Retirer toutes les enchères et clôturer toutes les mises à prix ?";
L.GDKP_MULTIAUCTION_CLIENT_TERMINATE_TOOLTIP = [[
Terminer la session d'enchères multiples

Cela supprimera toutes les enchères sur les objets qui n'ont pas encore été vendus et clôturera toutes les enchères !
]];
L.GDKP_MULTIAUCTION_CLIENT_TOOLTIP_INFO = "Passez la souris sur l'un des boutons ci-dessous pour plus d'informations";
L.GDKP_MULTIAUCTION_CLIENT_UNUSABLE_TOGGLE_TOOLTIP = "Afficher/masquer les objets que vous ne pouvez pas utiliser";
L.GDKP_MULTIAUCTION_INVALID_DATA_FOR_START = "Données non valides fournies pour le début des enchères GDKP !";
L.GDKP_MULTIAUCTION_ITEM_SOLD = "%s a acheté %s pour %spo";
L.GDKP_MULTIAUCTION_LM_OUTDATED = "Le maître du butin (%s) est obsolète, cela peut entraîner l'échec des enchères !";
L.GDKP_MULTIAUCTION_OUTBID = "Vous avez surenchéri !";
L.GDKP_MUTATORS = "Mutateurs";
L.GDKP_MUTATOR_ADD = "Ajouter mutateur";
L.GDKP_MUTATOR_APPLY_LABEL = "Appliquer automatiquement à";
L.GDKP_MUTATOR_CREATE_NEW = "Créer un nouveau mutateur GDKP";
L.GDKP_MUTATOR_DELETE_BYPASS = "Supprimer. Maintenez SHIFT pour contourner la confirmation";
L.GDKP_MUTATOR_EDIT = "Modifier mutateur";
L.GDKP_MUTATOR_FLAT_LABEL = "Montant d'or forfaitaire [exemple : 250]";
L.GDKP_MUTATOR_FLAT_RATE_NUMBER_WARNING = "Le montant forfaitaire doit être un nombre";
L.GDKP_MUTATOR_HELP_TOOLTIP_BOTTOM = [[
Exemple:
|c00967FD2SELF,RL,HEALER]];
L.GDKP_MUTATOR_HELP_TOOLTIP_TOP = "Vous pouvez appliquer automatiquement ce mutateur aux raiders en utilisant des mots-clés :";
L.GDKP_MUTATOR_NAME_LABEL = "Nom [exemple : Tanks]";
L.GDKP_MUTATOR_NO_DOTS_WARNING = "Le nom des mutateurs ne peuvent pas contenir de points (.)";
L.GDKP_MUTATOR_PERCENTAGE_LABEL = "Pourcentage [exemple : 10]";
L.GDKP_MUTATOR_PERCENTAGE_NUMBER_WARNING = "Le pourcentage doit être un nombre";
L.GDKP_MUTATOR_STORE_PERMANENTLY = "Stocker pour les prochaines sessions";
L.GDKP_MUTATOR_UNKNOWN = "Mutateur inconnu : %s";
L.GDKP_NOT_ALLOWED_TO_START_AUCTION = "L'utilisateur '%s' n'est pas autorisé à lancer des enchères";
L.GDKP_NOT_ALLOWED_TO_STOP_AUCTION = "L'utilisateur '%s' n'est pas autorisé à arrêter les enchères";
L.GDKP_NOT_ALLOWED_TO_STOP_INVALID_AUCTION = "L'utilisateur '%s' n'est pas autorisé à arrêter l'enchère : enchère invalide";
L.GDKP_NOT_ENOUGH_GOLD_TO_DISTRIBUTE = "Il n'y a pas assez d'or à distribuer, attendez-vous à des calculs de parts bizarres !";
L.GDKP_NO_BIDS = "Aucune offre !";
L.GDKP_OUTBID = "Vous avez surenchéri !";
L.GDKP_OVERVIEW_ACTIVE_SESSION = "(actif)";
L.GDKP_OVERVIEW_ADJUST_GOLD_DISABLED_TOOLTIP = [[
Vous devez être chef de groupe ou maître du butin pour ajuster l'or.
Vous ne pouvez pas ajuster l'or sur les sessions verrouillées/supprimées]];
L.GDKP_OVERVIEW_ADJUST_GOLD_TOOLTIP = "Ajouter/Supprimer de l'or";
L.GDKP_OVERVIEW_AUCTION_ENTRY = [[
%s a payé |c00%s%s pour
%s]]; -- Player paid 5000g for [Benediction]
L.GDKP_OVERVIEW_DELETED_ENTRY = [[
|c00be3333Supprimé par %s
Motif :]];
L.GDKP_OVERVIEW_DELETED_SESSION = "(supprimé)";
L.GDKP_OVERVIEW_DELETE_ENTRY_DISABLED_TOOLTIP = [[
Vous devez être chef de groupe ou maître du butin pour supprimer des entrées.
Vous ne pouvez pas supprimer des entrées sur des sessions verrouillées/supprimées]];
L.GDKP_OVERVIEW_DELETE_ENTRY_REASON = "Indiquez la raison de la suppression de cette entrée";
L.GDKP_OVERVIEW_DELETE_ENTRY_TOOLTIP = "Supprimer. Maintenez Shift pour contourner la note";
L.GDKP_OVERVIEW_DELETE_TOOLTIP = "Les sessions auxquelles sont attachées des enchères seront supprimées après 48 heures.";
L.GDKP_OVERVIEW_EDIT_ENTRY_DISABLED_TOOLTIP = [[
Vous devez être chef de groupe ou maître du butin pour modifier les entrées.
Vous ne pouvez pas modifier les entrées supprimées ou les entrées sur les sessions verrouillées/supprimées]];
L.GDKP_OVERVIEW_EXPORT_TOOLTIP = "Exportez une session pour que d'autres puissent voir les détails de la session ou même vous remplacer en tant que maître du butin";
L.GDKP_OVERVIEW_IMPORT_TOOLTIP = "Importer une session depuis un autre joueur ou compte";
L.GDKP_OVERVIEW_LEDGER_TOOLTIP = [[
Afficher un aperçu complet de l'historique,
idéal pour les captures d'écran !]];
L.GDKP_OVERVIEW_LOCK_CONFIRM = "Verrouiller une session signifie que vous ne pouvez pas mettre d'objets aux enchères ou modifier quoi que ce soit jusqu'à ce que vous la déverrouilliez, en êtes-vous sûr ?";
L.GDKP_OVERVIEW_LOCK_OR_UNLOCK_TOOLTIP = "Verrouiller ou déverrouiller la session";
L.GDKP_OVERVIEW_LOCK_TOOLTIP = "Verrouiller la session pour le paiement";
L.GDKP_OVERVIEW_MULTI_AUCTION_TOOLTIP = "Enchères multiples : mettez aux enchères plusieurs objets à la fois !";
L.GDKP_OVERVIEW_MUTATION_ADDED = "ajouté à";
L.GDKP_OVERVIEW_MUTATION_ENTRY = [[
|c00%s%s %s pot par %s
Remarques]]; -- i.e. 5000g added to pot by winner Note: I made a booboo
L.GDKP_OVERVIEW_MUTATION_REMOVED = "retiré de";
L.GDKP_OVERVIEW_POT_TOOLTIP = [[
Pot : %s
Part organisation (%s%%) : %spo
Part par joueur (1/%s) : %spo
]];
L.GDKP_OVERVIEW_RESTORE_ENTRY_DISABLED_TOOLTIP = [[
Vous devez être chef de groupe ou maître du butin pour restaurer les entrées.
Vous ne pouvez pas restaurer les entrées des sessions verrouillées/supprimées]];
L.GDKP_OVERVIEW_SESSION_DETAILS = "Par %s%s | Le |c00%s%s%s"; -- By name<guild> on date
L.GDKP_OVERVIEW_UNLOCK_CONFIRM = "Débloquer et modifier le pot ou les parts peut s'avérer très compliqué, surtout si vous avez déjà effectué des paiements. Es-tu sûr ?";
L.GDKP_OVERVIEW_UNLOCK_TOOLTIP = "Débloquez la session";
L.GDKP_PAYOUT_INACTIVE = "Aucune session GDKP active détectée ou la session n'est pas verrouillée pour le paiement !";
L.GDKP_PRICE_IMPORT_INC_OR_MIN_TOO_LOW = "L'incrément ou le minimum ne peut pas être inférieur à 0,0001 !";
L.GDKP_PRICE_IMPORT_INVALID_INC = "'Incrément' non valide fourni pour l'ID d'objet '%s'";
L.GDKP_PRICE_IMPORT_INVALID_MIN = "« Minimum » non valide fourni pour l'ID d'objet « %s »";
L.GDKP_PRICE_IMPORT_MIN_OR_INC_REQUIRED = "Un minimum ou un incrément est requis pour l'ID d'objet : %s";
L.GDKP_PRICE_IMPORT_MISSING_HEADER = "En-tête manquant, attention : il est sensible à la casse !";
L.GDKP_PRICE_IMPORT_SUCCESSFUL = "Données importées avec succès pour %s objets";
L.GDKP_PRICE_IMPORT_UNKNOWN_ITEM = "ID d'objet inconnu : %s";
L.GDKP_QUEUE_EXPLANATION = [[
|c00A79EFF%s dans des sacs, des fenêtres de butin ou même sur des liens dans votre chat pour les ajouter à cette file d'attente d'enchères.
Les objets dans la file d'attente seront automatiquement mis aux enchères une fois votre enchère en cours terminée. Cliquez sur le bouton '%s' pour éviter cela.

Vous voulez que Gargul attribue ou désenchante automatiquement les enchères pour vous ? Ouvrez la roue des paramètres sur le côté gauche !

|c00FFF569Le saviez-vous ?
Vous pouvez déplacer des objets par glisser-déposer
Les objets seront mémorisés, même lorsque vous |c00A79EFF/reload
Les objets en file d'attente sont automatiquement présentés aux raideurs qui possèdent Gargul afin qu'ils puissent pré-enchérir.
Gargul peut également gérer la fouille automatique pour vous. Découvrez-la avec |c00A79EFF/gl pm
]];
L.GDKP_QUEUE_HIDE_UNUSABLE = "Masquer les objets inutilisables";
L.GDKP_SESSION = "Session GDKP";
L.GDKP_SESSION_EDIT_TITLE = "Modification de %s";
L.GDKP_SHOW_UPCOMING = "Afficher les objets à venir";
L.GDKP_STOP_AUCTION_FIRST = "Arrêtez d'abord les enchères !";
L.GDKP_THEY_OWE = "%s vous doit %s";
L.GDKP_TRADE_BALANCE_INFO = [[
|c00967FD2GDKP Séance
Dépensé par le joueur : %s
Donné : %s
Reçu : %s
Joueur supprimé : %s

%s
]];
L.GDKP_TRADE_EXCLUDE_GOLD = "Exclure du GDKP";
L.GDKP_TRADE_EXCLUDE_GOLD_INFO = "L'or échangé ne sera pas ajouté au montant donné ou reçu";
L.GDKP_TRADE_GIVEN_TO_LABEL = "Or |c00967FD2donné à %s";
L.GDKP_TRADE_GOLD_ADD_FAILED = "Impossible d'ajouter %s à la fenêtre d'échange. Essayez de l'ajouter manuellement !";
L.GDKP_TRADE_GOLD_INSUFFICIENT_FUNDS = "Vous n'avez pas assez d'argent pour payer %s";
L.GDKP_TRADE_GOLD_TO_GIVE = "À donner : %s";
L.GDKP_TRADE_GOLD_TO_RECEIVE = "À recevoir : %s";
L.GDKP_TRADE_RECEIVED_FROM_LABEL = "Or |c00967FD2reçu de %s";
L.GDKP_TRY_MULTIAUCTION = "Découvrez les enchères multiples !";
L.GDKP_TUTORIAL_INFO = "Suivez les étapes ci-dessous pour démarrer rapidement avec Gargul GDKP !";
L.GDKP_TUTORIAL_STEP_ACTIVATE = "Activez cette session en cliquant sur le bouton |c00FFF569Activer ci-dessous !";
L.GDKP_TUTORIAL_STEP_AUCTION = "|c00FFF569%s un objet pour mettre aux enchères ou mettre en file d'attente un seul article"; -- %s holds the auction item hotkey (default ALT_CLICK)
L.GDKP_TUTORIAL_STEP_COMMANDS = [[
Commandes utiles :
- |c00FFF569/gdkp pour ouvrir cette fenêtre
- |c00FFF569/gl ma pour ouvrir la fenêtre multi-enchères
- |c00FFF569/gl au pour ouvrir la fenêtre d'enchères/la file d'attente d'un seul objet
- |c00FFF569/gl pm pour configurer la fouille automatique

]];
L.GDKP_TUTORIAL_STEP_DONE = "Si tout s'est bien passé, vous verrez ici vos objets fraîchement mis aux enchères !";
L.GDKP_TUTORIAL_STEP_MULTI_AUCTION = "Vous souhaitez mettre aux enchères plusieurs objets à la fois ? Exécutez |c00FFF569/gl ma (ou |c00FFF569/gl multiauction) ou cliquez sur l'icône multi-enchères en haut à droite de cette fenêtre !";
L.GDKP_TUTORIAL_STEP_NEW = "Cliquez sur le bouton |c00FFF569New ci-dessous pour créer votre première session GDKP. Il s'affichera à gauche une fois créé";
L.GDKP_TUTORIAL_STEP_READY = "Vous êtes prêt à vendre des objets ! |c00BE3333Lisez attentivement toutes les étapes ci-dessous et testez-les toutes par vous-même (pas besoin d'être dans un raid) avant de commencer votre premier raid GDKP !";
L.GDKP_TUTORIAL_STEP_SELL = "Vous souhaitez vendre un objet sans que personne n'enchérisse ? |c00FFF569%s sur un objet, choisissez un gagnant et fixez un prix !";
L.GDKP_TUTORIAL_TITLE = "Commencer";
L.GDKP_UNKNOWN_ITEM = "ID d'objet inconnu dans l'enchère : créer : %s";
L.GDKP_UNKNOWN_SESSION = "Identifiant de session inconnu dans l'enchère : créer : %s";
L.GDKP_YOU_OWE = "Vous devez %s %s";
L.GIVEN = "Donné";
L.GOLD_INDICATOR = "po";
L.GROUP = "Groupe";
L.GROUP_MANAGER = "Gestionnaire de groupes";
L.GROUP_VERSION_CHECK_NOTIFICATION_DESCRIPTION = "Télécharger sur CurseForge";
L.GROUP_VERSION_CHECK_NOTIFICATION_URL = "https://addons.wago.io/addons/gargul/versions?stability=stable";
L.HALT = "Arrêt";
L.HEADER = "En-tête";
L.HELLO = "|c00%sGargul v%s par Zhorax@Firemaw. Tapez |c00%s/gl ou |c00%s/gargul pour commencer !";
L.HIDE = "Cacher";
L.HOURS_MINUTES_FORMAT = "%H:%M";
L.IDENTITY_INFO = "Visitez l'URL ci-dessous pour en savoir plus sur la personnalisation des GDKP Gargul.";
L.IDENTITY_TOOLTIP = "Votre logo ici ? Cliquez pour plus d'informations !";
L.IMPORT = "Importer";
L.IMPORTED_AND_UPDATED_ON = "Importé le |c00A79EFF%s à |c00A79EFF%s, mis à jour le |c00A79EFF%s à |c00A79EFF%s";
L.IMPORT_EXPLANATION = "Quel type de données souhaitez-vous importer ?";
L.IMPORT_SUCCESSFUL = "Importation réussie des données de lancers améliorés";
L.INC = "Inc.";
L.INCLUDE_AWARDED = "Inclure les objets précédemment attribués";
L.INCLUDE_BOES = "Inclure les LQE";
L.INCLUDE_MATERIALS = "Inclure des matériaux (comme les cristaux des Abysses)";
L.INCREMENT = "Incrément";
L.INFO = "Info";
L.INVALID_DATA_WARNING = "Données non valides fournies";
L.ITEM = "Objet";
L.JSON_DECODE_WARNING = "Impossible de décoder les données JSON. Assurez-vous de le copier/coller tel quel sans ajouter de caractères ou d'espaces supplémentaires !";
L.KEYS_INFO = [[
Raccourcis clavier pour les objets Gargul

Démarrer les lancers : |c00A79EFF%s
Attribuer : |c00A79EFF%s
Désenchanter : |c00A79EFF%s


-- Faites un clic droit pour désactiver cette fenêtre --
]];
L.LEDGER = "historique";
L.LEFT_SYMBOL = "<";
L.LM_OR_ASSIST_REQUIRED = "Vous devez être le maître du butin ou avoir un rôle d'assistant/chef de groupe !";
L.LOCALE_CHANGE_NOTE = "Remarque : vous pouvez modifier la langue à tout moment dans les paramètres ou via |c00%s/gl locale";
L.LOCALE_DEDE = "deDE"; -- German (Germany)
L.LOCALE_ENUS = "frUS"; -- English (United States)
L.LOCALE_ESES = "ESES"; -- Spanish (Spain)
L.LOCALE_ESMX = "esMX"; -- Spanish (Mexico)
L.LOCALE_FRFR = "frFR"; -- French (France)
L.LOCALE_ITIT = "ça ça"; -- Italian (Italy)
L.LOCALE_KOKR = "koKR"; -- Korean (Korea)
L.LOCALE_NONE_EXPLANATION = [[
Gargul publie des messages de discussion en anglais (par défaut)
Vous pouvez sélectionner une autre langue dans la liste déroulante ci-dessous

Votre langue de discussion actuelle est '%s', l'activation d'une langue différente entraînera un /reload !
]];
L.LOCALE_NONE_TITLE = "Choisissez une langue de discussion pour Gargul";
L.LOCALE_PTBR = "ptBR"; -- Portuguese (Brazil)
L.LOCALE_RURU = "ruRU"; -- Russian (Russia)
L.LOCALE_ZHCN = "zhCN"; -- Chinese (Simplified, PRC)
L.LOCALE_ZHTW = "zhTW"; -- Chinese (Traditional, Taiwan)
L.LOOTMASTER_BAD_ADDONS = "Vous avez installé un ou plusieurs modules complémentaires qui peuvent potentiellement provoquer un dysfonctionnement de Gargul : %s";
L.LOOTMASTER_CLEAR_SR_BUTTON = "Effacer SoftRes";
L.LOOTMASTER_CLEAR_TMB_BUTTON = "Effacer TMB";
L.LOOTMASTER_DEFAULT_NOTE = "/roll pour MS ou /roll 99 pour OS";
L.LOOTMASTER_IMPORT_SR_BUTTON = "Importer SoftRes";
L.LOOTMASTER_IMPORT_TMB_BUTTON = "Importer TMB";
L.LOOTMASTER_NOTICE_LABEL = "On vous a confié le rôle de maître du butin";
L.LOOTMASTER_OPEN_LABEL = "Ouvrir cette fenêtre automatiquement";
L.LOOTPRIORITY_CLEAR_SUCCESSFUL = "Les priorités de butin ont été effacées avec succès";
L.LOOTPRIORITY_FORMAT_EXPLANATION = "Fournissez un CSV prio au format suivant (1 ligne par objet) : id ou nom > prio1, equalprio > prio2 > etc";
L.LOOTPRIORITY_IMPORT_SUCCESSFUL = "Priorités de butin importées avec succès";
L.LOOTPRIORITY_INVALID_DATA = "Données non valides fournies";
L.LOOTPRIORITY_INVALID_LINE = "Données non valides fournies à la ligne : '%s' : identifiant ou priorité d'objet manquant";
L.LOOTPRIORITY_PROCESS_INCOMING = "Tentative de traitement des priorités de butin entrantes de %s";
L.LOOTPRIORITY_TOOLTIP_HEADER = "Priorité de butin";
L.MAIL = "Mail";
L.MAILED = "Envoyé par la poste";
L.MAIL_CUTS_EXPLANATION = "Poster part aux joueurs";
L.MAINSPEC_ABBR = "+1";
L.MAXIMIZE = "Maximiser";
L.MIN = "Min.";
L.MINIMAP_BUTTON_AWARDED = "Historique attributions";
L.MINIMAP_BUTTON_CUTS = "Parts GDKP";
L.MINIMAP_BUTTON_EXPORT = "Exporter données";
L.MINIMAP_BUTTON_GARGUL = "Ouvrir Gargul";
L.MINIMAP_BUTTON_IMPORT = "Importer données";
L.MINIMAP_BUTTON_LEDGER = "Historique GDKP";
L.MINIMAP_BUTTON_MULTIAUCTION = "Multi-enchères";
L.MINIMAP_BUTTON_SETTING_INFO = "Modifier les paramètres dans la mini-carte /gl";
L.MINIMIZE = "Minimiser";
L.MINIMIZE_ON_AWARD = "Réduire lors de l'attribution";
L.MINIMIZE_ON_START = "Réduire au démarrage";
L.MINIMUM = "Minimum";
L.MINIMUM_QUALITY = "Qualité minimale";
L.MINUS10 = "-dix";
L.MINUS_SIGN = "-";
L.MOVE = "Déplacer";
L.MULTI_AUCTION = "Multi-enchères";
L.NAME = "Nom";
L.NEW = "Nouveau";
L.NEXT = "Suivant";
L.NO = "Non";
L.NONE = "Aucun";
L.NOTE = "Note";
L.NOTHING = "Rien";
L.NO_BIDS_ACTION = "Quand personne n'enchérit, faites :";
L.NO_OFFICER_PRIVILEGES = "Vous n'avez pas de privilèges d'officier";
L.OFFSPEC_ABBR = "+2";
L.OK = "OK";
L.OPEN = "Ouvrir";
L.OPEN_AUCTIONEER = "Ouvrir fenêtre d'enchères";
L.OPEN_MULTI_AUCTION = "Ouvrir enchères multiples";
L.PACKMULE_AUTOLOOT_DISENCHANT_PLACEHOLDER = "DEZ";
L.PACKMULE_AUTOLOOT_GREED_PLACEHOLDER = "CUPIDITÉ";
L.PACKMULE_AUTOLOOT_IGNORE_PLACEHOLDER = "IGNORER";
L.PACKMULE_AUTOLOOT_NEED_PLACEHOLDER = "BESOIN";
L.PACKMULE_AUTOLOOT_PASS_PLACEHOLDER = "PASSER";
L.PACKMULE_AUTOLOOT_RANDOM_PLACEHOLDER = "ALÉATOIRE";
L.PACKMULE_AUTOLOOT_ROUND_ROBIN_PLACEHOLDER = "CST";
L.PACKMULE_AUTOLOOT_SELF_PLACEHOLDER = "SOI";
L.PACKMULE_CONFIRM_DISENCHANTER = "Définir %s comme désenchanteur ?";
L.PACKMULE_CONFIRM_DISENCHANTMENT = "Envoyer %s à %s ? Tapez /gl cd pour supprimer ce désenchanteur !";
L.PACKMULE_NO_DISENCHANTER_WARNING = "Aucun désenchanteur défini, utilisez /gl sd [mydisenchanter] pour en définir un";
L.PACKMULE_WHO_IS_DISENCHANTER = "Qui est votre désenchanteur ?";
L.PAID = "Payé";
L.PASS = "Passer";
L.PERCENTAGE_SIGN = "%";
L.PLAYER = "Joueur";
L.PLAYER_ITEM_WON_COUNT = "Objets gagnés par %s :";
L.PLUS1 = "+1";
L.PLUS10 = "+10";
L.PLUSONES = "+1";
L.PLUSONES_AWARD_DIALOG_LABEL = "Ajouter un +1";
L.PLUSONES_BROADCAST_CONFIRM = "Êtes-vous sûr de vouloir diffuser vos données +1 à tous les membres de votre groupe/raid ?";
L.PLUSONES_BROADCAST_PROCESS_START = "Tentative de traitement des données +1 entrantes provenant de %s";
L.PLUSONES_CLEAR_CONFIRM = "%s souhaite effacer toutes vos données +1. Effacer toutes les données ?";
L.PLUSONES_IMPORT_CLEAR_CONFIRM = "Êtes-vous sûr de vouloir effacer vos données +1 existantes et importer de nouvelles données diffusées par %s ?";
L.PLUSONES_IMPORT_CONFIRM = "Etes-vous sûr de vouloir importer les nouvelles données diffusées par %s ?";
L.PLUSONES_IMPORT_ERROR = "Données non valides fournies. Assurez-vous que le contenu suit le format requis et qu'aucune ligne d'en-tête n'est incluse.";
L.PLUSONES_IMPORT_INFO = [[
Ici, vous pouvez importer les données +1 d'un tableau au format CSV ou TSV ou collée à partir d'une feuille Google Docs.

Le tableau nécessite au moins deux colonnes : Le nom du joueur suivi du nombre de points. Les colonnes supplémentaires sont ignorées.

Voici un exemple de ligne :

Foobar,240
]];
L.PLUSONES_INCOMING_DIALOG_AUTO_LABEL = "Accepter automatiquement les diffusions entrantes de %s";
L.PLUSONES_INCOMING_DIALOG_BLOCK_LABEL = "Bloquer toutes les données partagées +1 entrantes";
L.PLUSONES_UPDATE_CONFIRM = [[
Êtes-vous sûr de vouloir mettre à jour vos données +1 existantes avec les données de %s ?

Votre dernière mise à jour était sur |c00A79EFF%s, la leur sur |c00A79EFF%s.]];
L.PLUSONES_WHISPER_PREFIXES = "!plusone|!po|!+1";
L.PLUS_SIGN = "+";
L.POT = "Pot";
L.PRICE = "Prix";
L.PRIOLIST_ABBR = "LP";
L.QUALITY_COMMON = "Commun";
L.QUALITY_EPIC = "Épique";
L.QUALITY_HEIRLOOM = "Héritage";
L.QUALITY_LEGENDARY = "Légendaire";
L.QUALITY_POOR = "Médiocre";
L.QUALITY_RARE = "Rare";
L.QUALITY_UNCOMMON = "Inhabituel";
L.QUEUE = "File d'attente";
L.RAIDERS = "Raideurs";
L.RAIDGROUPS_ATTENDANCE_BUTTON = "Qui manque";
L.RAIDGROUPS_ATTENDANCE_BUTTON_TOOLTIP = "Afficher les noms des joueurs manquants";
L.RAIDGROUPS_DISBAND_BUTTON = "Dissoudre le raid";
L.RAIDGROUPS_DISBAND_BUTTON_TOOLTIP = "Dissoudre votre raid";
L.RAIDGROUPS_DUPLICATE_WARNING = "%s est répertorié deux fois sur la liste !";
L.RAIDGROUPS_EXPLANATION_LABEL_BOTTOM = "un export |c00FFF569Raid-Helper (Utilisez la variante 'Groupes triés verticalement') ou un CSV de composition de groupe |c00FFF569Gargul :";
L.RAIDGROUPS_EXPLANATION_LABEL_TOP = [[
Dans la zone d'édition ci-dessous, vous pouvez fournir une liste et : inviter tout le monde, vérifier qui manque, appliquer des groupes et attribuer les tanks.

Vous pouvez fournir un lien de composition de raid |c00FFF569Wowhead :]];
L.RAIDGROUPS_GARGUL_BUTTON = "Wiki des Groupes Gargul";
L.RAIDGROUPS_GARGUL_INFO = "Visitez le wiki des Groupes Gargul pour plus d'informations sur le format des groupes de raid.";
L.RAIDGROUPS_IMPOSTER_WARNING = "Les joueurs suivants ne font pas partie de la liste : %s";
L.RAIDGROUPS_INVALID_FORMAT_WARNING = "Données de groupe fournies non valides, vérifiez votre format !";
L.RAIDGROUPS_INVITE_BUTTON = "Inviter";
L.RAIDGROUPS_INVITE_BUTTON_TOOLTIP = "Envoyer des invitations aux joueurs inscrits sur la liste";
L.RAIDGROUPS_IN_COMBAT_WARNING = "Impossible de trier les groupes pendant que %s est en combat !"; -- %s holds a player name
L.RAIDGROUPS_NO_RAID_WARNING = "Vous devez participer à un raid !";
L.RAIDGROUPS_NO_TANKS_WARNING = "Aucun tank défini";
L.RAIDGROUPS_NO_VALID_SPOT_WARNING = "Vous ne trouvez pas de place pour %s, essayez-vous de mettre plus de 5 personnes dans 1 groupe ?";
L.RAIDGROUPS_PURGE_BUTTON = "Expulser indésirables";
L.RAIDGROUPS_PURGE_BUTTON_TOOLTIP = "Expulser les joueurs qui ne sont pas sur la liste";
L.RAIDGROUPS_SORTING_ERROR = "Quelque chose s'est mal passé lors du déplacement de %s";
L.RAIDGROUPS_SORTING_FINISHED = "Fin de l'application de la liste de raid";
L.RAIDGROUPS_SORTING_GROUPS = "Trier groupes";
L.RAIDGROUPS_SORT_BUTTON = "Appliquer groupes";
L.RAIDGROUPS_SORT_BUTTON_TOOLTIP = "Trier les groupes en fonction de la liste";
L.RAIDGROUPS_SORT_IN_PROGRESS = "Le tri est toujours en cours, attendez un peu !";
L.RAIDGROUPS_TANKS_ASSIGNED = "Tous les tanks sont attribués";
L.RAIDGROUPS_TANK_BUTTON = "Attribuer tanks";
L.RAIDGROUPS_WOWHEAD_BUTTON = "Outil de Composition Wowhead";
L.RAIDGROUPS_WOWHEAD_INFO = "Vous pouvez visiter l'outil de composition de raid Wowhead en utilisant l'URL ci-dessous. Après avoir créé votre composition, vous pouvez la coller ici ou dans le champ d'édition de la fenêtre du gestionnaire de groupes de Gargul.";
L.REMOVE_BID = "Supprimer l'enchère";
L.RESET_SETTINGS = "Réinitialiser options";
L.RESET_SETTINGS_CONFIRMATION = "Êtes-vous sûr de vouloir réinitialiser tous les paramètres de Gargul ? Cela ne peut pas être annulé !";
L.RESET_UI = "Réinitialiser interface";
L.RESET_UI_CONFIRMATION = "Êtes-vous sûr de vouloir réinitialiser toutes les tailles, positions et échelles de fenêtres de Gargul ? Cela ne peut pas être annulé !";
L.RESTORE = "Restaurer";
L.RESUME = "Reprendre";
L.RIGHT_SYMBOL = ">";
L.ROLL = "Lancer";
L.ROLLING_AWARD_CONFIRM = "Attribuer %s à %s ?";
L.ROLLING_CLOSE_ON_AWARD_LABEL = "Fermer à l'attribution";
L.ROLLING_CLOSE_ON_START_LABEL = "Fermer au démarrage";
L.ROLLING_HOLD_SHIFT_TO_BYPASS_CONFIRMATION = "Maintenez Shift pour contourner la confirmation d'attribution";
L.ROLLING_HOLD_SHIFT_TO_SHOW_CONFIRMATION = "Maintenez Shift pour afficher la confirmation d'attribution";
L.ROLLING_IDENTICAL_ROLL_WARNING = [[
Attention : un autre lancer identique a été trouvé qui peut indiquer une égalité

]];
L.ROLLING_INVALID_START_DATA_WARNING = "Données invalides fournies pour le début des lancers !";
L.ROLLING_ITEM_WON_BR_COST = "(LA : %s)";
L.ROLLING_ITEM_WON_GIVEN = "(objet donné : oui)";
L.ROLLING_ITEM_WON_NOT_GIVEN = "(objet donné : non)";
L.ROLLING_ITEM_WON_OS = "(+1)";
L.ROLLING_NOTE_LABEL = "NOTE";
L.ROLLING_NO_ROLLOFF_WARNING = "Impossible d'arrêter le lancer, aucun lancer en cours";
L.ROLLING_PASS_BUTTON = "Passer";
L.ROLLING_REOPEN_ROLL_COUNT = "lancers : %s";
L.ROLLING_REOPEN_TOOLTIP = "Ouvrir la fenêtre de maître du butin";
L.ROLLING_ROLL_ACCEPTED = "Lancer accepté !";
L.ROLLING_ROLL_IN_PROGRESS_WARNING = "Un lancer est actuellement en cours";
L.ROLLING_ROLL_PRIOLIST = "Priorité [%s]";
L.ROLLING_ROLL_SR_COUNT = "SR [%sx]";
L.ROLLING_ROLL_WISHLIST = "Souhait [%s]";
L.ROLLING_SELECT_PLAYER_WARNING = "Vous devez d'abord sélectionner un joueur";
L.ROLLING_TIMER_LABEL = "Temps";
L.ROLLING_UNUSABLE_ITEM = "Vous ne pouvez pas utiliser cet objet !";
L.ROLLING_WINNER_NOT_UNIQUE = "Le nom du gagnant n'est pas unique, sélectionnez le joueur à qui vous souhaitez attribuer %s";
L.SECONDS_ABBR = "s";
L.SELECT_ALL = "Sélectionner / désactiver tout";
L.SESSION = "Session";
L.SETTINGS = "Paramètres";
L.SETTINGS_ANNOUNCE_INCOMING_BIDS = "Annoncer les enchères entrantes";
L.SETTINGS_ANNOUNCE_POT_AFTER_AWARD = "Annoncer le pot après avoir attribué l'objet";
L.SETTINGS_ANNOUNCE_START = "Annoncer le début des enchères";
L.SETTINGS_COUNTDOWN_IN_RAID_WARNING = "Annoncer le compte à rebours dans l'avertissement de raid";
L.SETTINGS_INCOMING_BIDS_IN_RAID_WARNING = "Annoncer les enchères entrantes dans l'avertissement de raid";
L.SETTINGS_RESET_UI = "Réinitialiser l'interface utilisateur de Gargul";
L.SETTINGS_WHISPER_BID_TOO_LOW = "Chuchoter l'enchérisseur si l'offre est trop basse";
L.SILVER_INDICATOR = "pa";
L.SKIP = "Passer";
L.SOFTRES = "Soft Reserve";
L.SOFTRES_ABBR = "SR";
L.SOFTRES_BROADCAST_CONFIRM = "Etes-vous sûr de vouloir diffuser vos données softres à tous les membres de votre groupe/raid ?";
L.SOFTRES_BROADCAST_PROCESS_FAILED = "Impossible de traiter les données SoftRes reçues de %s";
L.SOFTRES_CLEAR_CONFIRM = "Êtes-vous sûr de vouloir effacer toutes les données de soft-reserve existantes ?";
L.SOFTRES_EVERYONE_RESERVED = "Tout le monde a rempli ses soft-reserves";
L.SOFTRES_FEATURE_MISSING = [[
Les informations sur les hard-reserves ne sont pas disponibles car les soft-reserves
fournis n'ont pas été générés à l'aide du bouton 'Gargul Export' sur softres.it]];
L.SOFTRES_IMPORT_DETAILS = "Importé le |c00A79EFF%s à |c00A79EFF%s";
L.SOFTRES_IMPORT_FIXED_NAME = "Correction automatique du nom : le SR de '%s' est désormais lié à '%s'";
L.SOFTRES_IMPORT_INFO = "Pour commencer, vous devez d'abord créer un raid sur softres.it. Cliquez ensuite sur « Addon Export », sélectionnez « Gargul », copiez les données et collez-les dans le formulaire ci-dessous.";
L.SOFTRES_IMPORT_INVALID = "Données soft-reserve fournies invalides";
L.SOFTRES_IMPORT_INVALID_INSTRUCTIONS = "Données non valides fournies. Assurez-vous de cliquer sur le bouton « Gargul Export » sur softres.it et collez le contenu complet ici";
L.SOFTRES_IMPORT_NEW_PLUSONES = "Les valeurs +1 fournies sont en conflit avec celles déjà présentes. Voulez-vous remplacer vos anciennes valeurs +1 ?";
L.SOFTRES_IMPORT_NO_RESERVES_WARNING = "Les joueurs suivants n'ont rien réservé :";
L.SOFTRES_IMPORT_SUCCESSFUL = "Soft-reserves importées avec succès";
L.SOFTRES_IMPORT_SUCCESSFUL_ALERT = "Importation réussie !";
L.SOFTRES_IMPORT_USE_GARGUL = "Les données SoftRes Weakaura et CSV sont obsolètes, utilisez plutôt l'exportation Gargul !";
L.SOFTRES_LOOTRESERVE_CONNECTION_WARNING = "Échec de la connexion à LootReserve, contactez l'assistance (inclure le message ci-dessous)";
L.SOFTRES_MULTIPLE_RESERVES = "%s (%sx)";
L.SOFTRES_NO_URL_AVAILABLE = "Aucune URL softres.it disponible, assurez-vous d'avoir exporté en utilisant le bouton 'Gargul Export' sur softres.it !";
L.SOFTRES_OVERVIEW_HARDRESERVES_LABEL = "Cliquez ici pour voir les informations sur les hard-reserves";
L.SOFTRES_OVERVIEW_NO_HARDRESERVES = "Aucun objet n'est hard-reseve";
L.SOFTRES_OVERVIEW_NO_HARDRESERVE_INFO = "Aucune information de hard-reserve disponible";
L.SOFTRES_OVERVIEW_POST_MISSING_BUTTON = "Publier SR manquants";
L.SOFTRES_OVERVIEW_POST_URL_BUTTON = "URL de la publication SR";
L.SOFTRES_PLAYER_DIDNT_RESERVE = "Ce joueur n'a rien réservé !";
L.SOFTRES_PLAYER_RESERVE_COUNT = "%s (%sx)";
L.SOFTRES_PROCESS_INCOMING = "Tentative de traitement des données SoftRes entrantes de %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED = "Cet objet est hard-réserved";
L.SOFTRES_TOOLTIP_HARD_RESERVED_FOR = "Pour : %s";
L.SOFTRES_TOOLTIP_HARD_RESERVED_NOTE = "|c00CC2743 Remarque : %s";
L.SOFTRES_TOOLTIP_RESERVED_BY = "Réservé par";
L.SOFTRES_WHISPER_PREFIXES = "!sr|!softres|!softreserve";
L.SOMETHING_WENT_WRONG_WARNING = "Quelque chose s'est mal passé !";
L.START = "Commencer";
L.STOP = "Arrêter";
L.TAB_REPLACES_T = "	 est remplacé par une tabulation";
L.THATSMYBIS_ABBR = "TMB";
L.TIME = "Temps";
L.TITLE = "Titre";
L.TMBETC = "TMB, DFT ou PRIO3";
L.TMB_BROADCAST_CONFIRM = "Êtes-vous sûr de vouloir diffuser vos données TMB à tous les membres de votre groupe/raid ? NB : TOUT LE MONDE peut voir vos données TMB quelles que soient ses autorisations sur le site de TMB !";
L.TMB_BROADCAST_PROCESS_START = "Tentative de traitement des données TMB entrantes de %s";
L.TMB_CLEAR_CONFIRM = "Êtes-vous sûr de vouloir effacer toutes les données +1 ?";
L.TMB_CLEAR_RAIDER_DATA = "Effacer données raideurs";
L.TMB_CLEAR_RAIDER_DATA_CONFIRM = "Effacer les données TMB pour tous les raiders ?";
L.TMB_IMPORT_AUTO_SHARING_ENABLED = "Partage automatique activé : %s";
L.TMB_IMPORT_CPO_INFO = "Sur votre exécution classicpr.io, cliquez sur le bouton « Gargul Export » et copiez le contenu. Collez ensuite le contenu tel quel dans la case ci-dessous et cliquez sur « Importer ». C'est tout !";
L.TMB_IMPORT_DETAILS = "Importé le ${date} à ${time}";
L.TMB_IMPORT_DFT_INFO = "Exportez vos données DFT selon les instructions de la feuille. Collez ensuite le contenu tel quel dans la case ci-dessous et cliquez sur « Importer ». C'est ça!";
L.TMB_IMPORT_INVALID_CSV = "CSV fourni non valide, le format est : 6948,player1,player2";
L.TMB_IMPORT_INVALID_DFT = "Données DFT fournies non valides. Exportez vos données DFT conformément aux instructions de la feuille et collez le contenu ici tel quel !";
L.TMB_IMPORT_INVALID_INSTRUCTIONS = "Données TMB fournies non valides, assurez-vous de cliquer sur le bouton « Télécharger » dans la section Gargul et collez le contenu ici tel quel !";
L.TMB_IMPORT_INVALID_UNKNOWN_INSTRUCTIONS = "Données TMB ou DFT fournies non valides. Assurez-vous de coller le contenu de l'exportation ici tel quel !";
L.TMB_IMPORT_NOTES_AVAILABLE = "Notes de priorité disponibles : %s";
L.TMB_IMPORT_NUMBER = "Nombre d'objets importés : %s";
L.TMB_IMPORT_PLAYER_NO_DATA = "Les joueurs suivants n'ont pas d'entrée %s :"; -- %s can be TMB/DFT/CPR
L.TMB_IMPORT_TMB_GARGUL_INFO = "Comment utiliser Gargul avec TMB";
L.TMB_IMPORT_TMB_GARGUL_INFO_URL = "https://github.com/papa-smurf/Gargul/wiki/Gargul-and-ThatsMyBIS";
L.TMB_IMPORT_TMB_INFO = "Collez le contenu de votre export TMB tel quel dans la case ci-dessous et cliquez sur 'Importer'.";
L.TMB_NO_BROADCAST_TARGETS = "Il n'y a personne dans votre groupe vers qui diffuser";
L.TMB_SYNCED = "Données TMB synchronisées";
L.TMB_TOOLTIP_NOTE = "|c00FFFFFF Note : |c00FFF569%s";
L.TMB_TOOLTIP_OFFSPEC_INDICATION = "(+1)";
L.TMB_TOOLTIP_PRIO_HEADER = "Liste prioritaire %s"; -- %s can be TMB/DFT/CPR
L.TMB_TOOLTIP_TIER = "|c00FFFFFF Niveau : %s";
L.TMB_TOOLTIP_WISHLIST_HEADER = "Liste de souhaits de TMB";
L.TOGGLE_DATES = "Afficher/masquer les dates";
L.TOGGLE_QUEUE = "Afficher/masquer la file d'attente";
L.TRADETIME_AWARD_HOWTO = "%s pour attribuer du butin !";
L.TRADETIME_ROLL_HOWTO = "%s pour lancer les dés sur le butin !";
L.TRADETIME_SETTINGS_HIDE_AWARDED = "Masquer tous les objets attribués";
L.TRADETIME_SETTINGS_HIDE_DISENCHANTED = "Cacher les objets désenchantés";
L.TRADETIME_SETTINGS_HIDE_SELF_AWARDED = "Masquer les objets attribués à soi-même";
L.TRADE_ANNOUNCE = "Annoncer échange";
L.TRADE_ANNOUNCE_INFO = "Annoncer les détails de l'échange au groupe ou dans /dire lorsque vous n'êtes pas dans un groupe";
L.TUTORIAL = "Didacticiel";
L.TUTORIAL_AUCTIONEER = [[
|c00A79EFF%s dans les sacs, des fenêtres de butin ou même sur des liens dans votre chat pour les ajouter à la file d'attente des enchères.
Vous souhaitez vendre directement un article sans enchérir ? Utilisez |c00A79EFF%s

Vous pouvez ouvrir la fenêtre %s directement en tapant |c00A79EFF/gl auctions

Gargul suit | c00FF0000TOUS l'or échangé. Vous ne voulez pas qu'un échange fasse partie de cette session GDKP ? Cochez la case « Exclure du GDKP » lors de l'échange !

|c00FFF569Le saviez-vous ?
Les objets attribués seront automatiquement ajoutés à la fenêtre d'échange
Gargul peut également gérer la fouille automatique pour vous. Découvrez-la avec |c00A79EFF/gl pm
]];
L.TUTORIAL_AWARD_OVERVIEW = [[
Cette fenêtre affiche tous les objets qui ont été attribués à une date donnée (sélectionnez une ou plusieurs dates sur la gauche).

Les éléments peuvent contenir les balises suivantes :

|c00A79EFFOS : attribué pour spécialisation secondaire
|c00A79EFFSR : Cet objet était soft-reserved
|c00A79EFFWL : Cet objet était en liste de souhaits (Thatsmybis)
|c00A79EFFPL : Cet objet était en liste de priorité (Thatsmybis, DFT, prio3)
]];
L.TUTORIAL_BIDDER_QUEUE = [[
Les objets que vous voyez ici sont dans la file d'attente GDKP du maître du butin
Vous pouvez les supprimer, enchérir sur eux et masquer les objets inutilisables (activez « Masquer les objets inutilisables » dans les paramètres en haut à gauche).

Vous pouvez redimensionner la fenêtre, la déplacer ou la réduire. Essaye la !

Pour les maîtres du butin : supprimer des objets ici les supprimera uniquement de votre file d'attente personnelle, pas de la file d'attente GDKP courante !
]];
L.TUTORIAL_MORE_HELP = "Besoin d'aide ?";
L.TYPE = "Type"; -- As in type of roll or type of item
L.UNKNOWN = "inconnu";
L.UNKNOWN_COMM_ACTION = "Action de communication inconnue '%s', assurez-vous de mettre à jour Gargul !";
L.UNLOCK = "Ouvrir";
L.UPDATE_GARGUL = "Mettez à jour Gargul !";
L.VERSION_ABBR = "v";
L.VERSION_CHECK_BUTTON_REPORT = "Rapporter";
L.VERSION_CHECK_BUTTON_REPORT_TOOLTIP = "Signaler les résultats obsolètes dans la discussion de groupe";
L.VERSION_CHECK_COLUMN_STATUS = "Statut Gargul";
L.VERSION_CHECK_STATUS_CHECKING = "Vérification de la version...";
L.VERSION_CHECK_STATUS_EXPLANATION = [[
|c0092FF00v%s : le joueur est à jour
|c00F7922Ev%s : le joueur doit mettre à jour ses add-ons
|c00BE3333%s : le joueur n'a pas Gargul ou utilise une version non supportée
|c00808080%s : le joueur est hors ligne ou nous ignore !
|c0000FFFF%s : le joueur est sur notre liste d'ignorés !

]];
L.VERSION_CHECK_STATUS_IGNORED = "JOUEUR IGNORÉ !";
L.VERSION_CHECK_STATUS_OFFLINE = "Hors-ligne";
L.VERSION_CHECK_STATUS_UNRESPONSIVE = "Pas de réponse";
L.VERSION_CHECK_SUMMARY_NO_RESPONSE = "Pas de réponse:";
L.VERSION_CHECK_SUMMARY_OFFLINE = "Hors-ligne:";
L.VERSION_CHECK_SUMMARY_OUTDATED = "Obsolète:";
L.VERSION_CHECK_SUMMARY_UP_TO_DATE = "À jour:";
L.VERSION_INCOMPATIBLE_WARNING = "Gargul est obsolète et ne fonctionnera pas tant que vous n'aurez pas mis à jour !";
L.VERSION_INVALID_WARNING = "Chaîne de version non valide fournie dans Version : addRelease";
L.VERSION_UPDATE = "Mettez à jour Gargul !";
L.VERSION_UPDATED = "|c00%sGargul est maintenant mis à jour vers |c00%sv%s";
L.VERSION_UPDATE_AVAILABLE = "v|c00A79EFFv%s est disponible sur CurseForge/Wago. Vous pouvez mettre à jour sans fermer votre jeu, assurez-vous simplement de /reload !";
L.WINDOW = "Fenêtre";
L.WINDOW_HEADER = "Gargul v%s";
L.WINDOW_SCALE = "Échelle de la fenêtre";
L.WISHLIST_ABBR = "WL";
L.YES = "Oui";
L.YOU_DISABLED_GDKP_QUEUES = "Vous avez désactivé les files d'attente GDKP";
L.ZERO_SIGN = "0";
L.ZLIB_COMPRESS_WARNING = "Impossible de compresser les données avec zlib. Contactez l'assistance via https://discord.gg/D3mDhYPVzf";
L.ZLIB_DECOMPRESS_WARNING = "Impossible de décompresser les données avec zlib. Assurez-vous de le copier/coller tel quel sans ajouter de caractères ou d'espaces supplémentaires !";
